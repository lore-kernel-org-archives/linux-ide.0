Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BFA8C7EE26
	for <linux-ide@archiver.kernel.org>; Tue, 23 May 2023 09:23:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232887AbjEWJXa (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 23 May 2023 05:23:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235908AbjEWJX3 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 23 May 2023 05:23:29 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E56E11F
        for <linux-ide@vger.kernel.org>; Tue, 23 May 2023 02:23:25 -0700 (PDT)
Received: from canpemm100004.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4QQTNN5nYtzLm9b;
        Tue, 23 May 2023 17:21:56 +0800 (CST)
Received: from [10.174.179.14] (10.174.179.14) by
 canpemm100004.china.huawei.com (7.192.105.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 23 May 2023 17:23:23 +0800
Subject: Re: [PATCH v3] ata: libata-scsi: Use correct device no in
 ata_find_dev()
To:     John Garry <john.g.garry@oracle.com>,
        Damien Le Moal <dlemoal@kernel.org>,
        <linux-ide@vger.kernel.org>
CC:     Xingui Yang <yangxingui@huawei.com>
References: <20230523080443.398912-1-dlemoal@kernel.org>
 <1da247a6-57d3-a2dc-7375-e5a1fb02f9c1@oracle.com>
From:   Jason Yan <yanaijie@huawei.com>
Message-ID: <4a48966b-c193-06c7-54b0-d175a9009de9@huawei.com>
Date:   Tue, 23 May 2023 17:23:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <1da247a6-57d3-a2dc-7375-e5a1fb02f9c1@oracle.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.14]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm100004.china.huawei.com (7.192.105.92)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2023/5/23 16:29, John Garry wrote:
> On 23/05/2023 09:04, Damien Le Moal wrote:
>> For devices not attached to a port multiplier and managed directly by
>> libata, the device number passed to ata_find_dev() must always be lower
>> than the maximum number of devices returned by ata_link_max_devices().
>> That is 1 for SATA devices or 2 for an IDE link with master+slave
>> devices. This device number is the scsi device ID which matches these
>> constraint as the ID are generated per port and so never exceed the
>> link maximum.
>>
>> However, for libsas managed devices, scsi device IDs are assigned per
>> scsi host, leading to device IDs for SATA devices that can be well in
>> excess of libata per-link maximum number of devices. This results in
>> ata_find_dev() always returning NULL for libsas managed devices except
>> for the first device of the host with ID (device number) 0. This issue
>> is visible by executing hdparm command, which fails:
>>
>> hdparm -i /dev/sdX
>> /dev/sdX:
>>    HDIO_GET_IDENTITY failed: No message of desired type
>>
>> Fix this by rewriting ata_find_dev() to ignore the device number for
>> non-pmp attached devices with a link with at most 1 device, that is SATA
>> devices on SATA ports. For these, device number 0 is always used to
>> return the correct ata_device struct of the port link. This change
>> excludes IDE master/slave setups (maximum number of devices per link
>> is 2) and port-multiplier attached devices. Also, to be consistant with
>> the fact that scsi device IDs and channel numbers used as device numbers
>> are both unsigned int, change the devno argument of ata_find_dev() to
>> unsinged int.
>>
>> Reported-by: Xingui Yang <yangxingui@huawei.com>
>> Fixes: 41bda9c98035 ("libata-link: update hotplug to handle PMP links")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> 
> Reviewed-by: John Garry <john.g.garry@oracle.com>

Hi Damien & John,

I think we may missed something. What about if we do this:

echo "scsi add-single-device 0 0 100 0" >/proc/scsi/scsi

Then in ata_scsi_user_scan() we will return device "0 0 0 0 " and rescan 
this device, which is wrong?

Thanks,
Jason
