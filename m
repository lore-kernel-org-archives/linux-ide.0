Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18FAFC77B7E
	for <linux-ide@archiver.kernel.org>; Mon, 29 May 2023 09:11:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231478AbjE2JLE (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 29 May 2023 05:11:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjE2JLE (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 29 May 2023 05:11:04 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7EE991
        for <linux-ide@vger.kernel.org>; Mon, 29 May 2023 02:11:01 -0700 (PDT)
Received: from canpemm100004.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4QV8rr3ynMzTkvb;
        Mon, 29 May 2023 17:10:52 +0800 (CST)
Received: from [10.174.179.14] (10.174.179.14) by
 canpemm100004.china.huawei.com (7.192.105.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 29 May 2023 17:10:59 +0800
Subject: Re: [PATCH v3] ata: libata-scsi: Use correct device no in
 ata_find_dev()
To:     Damien Le Moal <dlemoal@kernel.org>,
        John Garry <john.g.garry@oracle.com>,
        <linux-ide@vger.kernel.org>
CC:     Xingui Yang <yangxingui@huawei.com>
References: <20230523080443.398912-1-dlemoal@kernel.org>
 <1da247a6-57d3-a2dc-7375-e5a1fb02f9c1@oracle.com>
 <4a48966b-c193-06c7-54b0-d175a9009de9@huawei.com>
 <e68130f1-272c-c2f0-7725-5b287bffb22d@kernel.org>
From:   Jason Yan <yanaijie@huawei.com>
Message-ID: <5985650d-ad46-e868-3a50-af59dadf0dd8@huawei.com>
Date:   Mon, 29 May 2023 17:10:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <e68130f1-272c-c2f0-7725-5b287bffb22d@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.14]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm100004.china.huawei.com (7.192.105.92)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2023/5/29 14:45, Damien Le Moal wrote:
> On 5/23/23 18:23, Jason Yan wrote:
>> On 2023/5/23 16:29, John Garry wrote:
>>> On 23/05/2023 09:04, Damien Le Moal wrote:
>>>> For devices not attached to a port multiplier and managed directly by
>>>> libata, the device number passed to ata_find_dev() must always be lower
>>>> than the maximum number of devices returned by ata_link_max_devices().
>>>> That is 1 for SATA devices or 2 for an IDE link with master+slave
>>>> devices. This device number is the scsi device ID which matches these
>>>> constraint as the ID are generated per port and so never exceed the
>>>> link maximum.
>>>>
>>>> However, for libsas managed devices, scsi device IDs are assigned per
>>>> scsi host, leading to device IDs for SATA devices that can be well in
>>>> excess of libata per-link maximum number of devices. This results in
>>>> ata_find_dev() always returning NULL for libsas managed devices except
>>>> for the first device of the host with ID (device number) 0. This issue
>>>> is visible by executing hdparm command, which fails:
>>>>
>>>> hdparm -i /dev/sdX
>>>> /dev/sdX:
>>>>     HDIO_GET_IDENTITY failed: No message of desired type
>>>>
>>>> Fix this by rewriting ata_find_dev() to ignore the device number for
>>>> non-pmp attached devices with a link with at most 1 device, that is SATA
>>>> devices on SATA ports. For these, device number 0 is always used to
>>>> return the correct ata_device struct of the port link. This change
>>>> excludes IDE master/slave setups (maximum number of devices per link
>>>> is 2) and port-multiplier attached devices. Also, to be consistant with
>>>> the fact that scsi device IDs and channel numbers used as device numbers
>>>> are both unsigned int, change the devno argument of ata_find_dev() to
>>>> unsinged int.
>>>>
>>>> Reported-by: Xingui Yang <yangxingui@huawei.com>
>>>> Fixes: 41bda9c98035 ("libata-link: update hotplug to handle PMP links")
>>>> Cc: stable@vger.kernel.org
>>>> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
>>>
>>> Reviewed-by: John Garry <john.g.garry@oracle.com>
>>
>> Hi Damien & John,
>>
>> I think we may missed something. What about if we do this:
>>
>> echo "scsi add-single-device 0 0 100 0" >/proc/scsi/scsi
>>
>> Then in ata_scsi_user_scan() we will return device "0 0 0 0 " and rescan
>> this device, which is wrong?
> 
> I did some more digging into this. And I do not think there are any
> issues (I tested and it works). The reason is that the "shost" passed to
> ata_scsi_user_scan() corresponds to the scsi host for the ata_port of
> the ata_device in libsas (dev->sata_dev.ap). It is not the scsi_host
> representing the HBA itself (which has multiple devices).
> 
> So changing the devno to 0 has no effect and deleting+rescanning
> particular devices leads to the correct IDs being used. E.g., on my
> system, I have 4 drives connected to the pm80xx:
> 
> # lsscsi -g
> [0:0:0:0]    disk    ATA      WDC  WUH721818AL W232  /dev/sdc   /dev/sg3
> [0:0:1:0]    disk    ATA      WDC  WUH721818AL WTW2  /dev/sdb   /dev/sg1
> [0:0:2:0]    disk    ATA      WDC  WUH722222AL Wf86  /dev/sdd   /dev/sg2
> [0:0:3:0]    zbc     ATA      WDC  WSH722020AL W803  /dev/sda   /dev/sg0
> 
> If I remove the first 0 and 2:
> 
> # echo 1 > /sys/class/scsi_device/0:0:0:0/device/delete
> # echo 1 > /sys/class/scsi_device/0:0:2:0/device/delete
> # lsscsi -g
> [0:0:1:0]    disk    ATA      WDC  WUH721818AL WTW2  /dev/sdb   /dev/sg1
> [0:0:3:0]    zbc     ATA      WDC  WSH722020AL W803  /dev/sda   /dev/sg0
> 
> And then manually rescan in reverse order of the removal:
> 
> # echo "scsi add-single-device 0 0 2 0" > /proc/scsi/scsi
> # lsscsi -g
> [0:0:1:0]    disk    ATA      WDC  WUH721818AL WTW2  /dev/sdb   /dev/sg1
> [0:0:2:0]    disk    ATA      WDC  WUH722222AL Wf86  /dev/sdc   /dev/sg2
> [0:0:3:0]    zbc     ATA      WDC  WSH722020AL W803  /dev/sda   /dev/sg0
> 
> # echo "scsi add-single-device 0 0 0 0" > /proc/scsi/scsi
> # lsscsi -g
> [0:0:0:0]    disk    ATA      WDC  WUH721818AL W232  /dev/sdd   /dev/sg3
> [0:0:1:0]    disk    ATA      WDC  WUH721818AL WTW2  /dev/sdb   /dev/sg1
> [0:0:2:0]    disk    ATA      WDC  WUH722222AL Wf86  /dev/sdc   /dev/sg2
> [0:0:3:0]    zbc     ATA      WDC  WSH722020AL W803  /dev/sda   /dev/sg0
> 
> I get back all devices with the correct IDs.
> 
> Note that I tried John's suggestion as well using an ata_for_each_dev()
> loop. That does work well for libsas as we do have ata_dev->sdev set to
> the scsi device already when scanning, but does not work for AHCI as we
> do not. I will keep doing some more tests with v3 (and correct typos and
> suggested) but I think this is all good.

Thanks to clarify this:

Reviewed-by: Jason Yan <yanaijie@huawei.com>
