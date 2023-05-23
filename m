Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F174DC7EE23
	for <linux-ide@archiver.kernel.org>; Tue, 23 May 2023 12:30:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbjEWMaB (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 23 May 2023 08:30:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236867AbjEWM3t (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 23 May 2023 08:29:49 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 997C1DB
        for <linux-ide@vger.kernel.org>; Tue, 23 May 2023 05:29:46 -0700 (PDT)
Received: from canpemm100004.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4QQYWN1S8hzLmGZ;
        Tue, 23 May 2023 20:28:16 +0800 (CST)
Received: from [10.174.179.14] (10.174.179.14) by
 canpemm100004.china.huawei.com (7.192.105.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 23 May 2023 20:29:43 +0800
Subject: Re: [PATCH v2] ata: libata-scsi: Use correct device no in
 ata_find_dev()
To:     Damien Le Moal <dlemoal@kernel.org>, <linux-ide@vger.kernel.org>
CC:     John Garry <john.g.garry@oracle.com>,
        Xingui Yang <yangxingui@huawei.com>
References: <20230523023219.291253-1-dlemoal@kernel.org>
 <a291e973-32e3-f717-4b94-54a78c514800@huawei.com>
 <301a5198-9686-e3b5-74d8-4e5e85e6fc08@kernel.org>
From:   Jason Yan <yanaijie@huawei.com>
Message-ID: <cb2d18ed-2b61-6d92-96f4-4c84429ebe74@huawei.com>
Date:   Tue, 23 May 2023 20:29:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <301a5198-9686-e3b5-74d8-4e5e85e6fc08@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.14]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm100004.china.huawei.com (7.192.105.92)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2023/5/23 19:52, Damien Le Moal wrote:
>> I wonder if you can change the type of devno to 'unsigned int'? At a
>> closer look I found the user can control this value and may pass in a
>> bogus channel or id.
>>
>> proc_scsi_write
>>       =>scsi_add_single_device
>>           =>ata_scsi_user_scan
>>               =>ata_find_dev
> Reading more about scsi_add_single_device(), the comment says "Note: this seems
> to be aimed exclusively at SCSI parallel busses.". So I don't think we should
> worry about it. But then I also do not understand why libata is wired to this at
> all. Cannot have ATA device on a parallel SCSI bus...

The comment is kind of obsolete. It is not limited to SCSI parallel 
busses only.

> 
> On my system, I cannot get
> 
> echo "scsi add-single-device X 0 100 0" >/proc/scsi/scsi
> 
> to do anything and so I do not see how ata_scsi_user_scan can ever be called...
> 

Did you enabled CONFIG_SCSI_PROC_FS ? I started a qemu and it still works.

[root@localhost ~]# cat /proc/scsi/scsi
Attached devices:
Host: scsi1 Channel: 00 Id: 00 Lun: 00
   Vendor: QEMU     Model: QEMU DVD-ROM     Rev: 2.5+
   Type:   CD-ROM                           ANSI  SCSI revision: 05
[root@localhost ~]# lsscsi
[1:0:0:0]    cd/dvd  QEMU     QEMU DVD-ROM     2.5+  /dev/sr0
[root@localhost ~]#
[root@localhost ~]#
[root@localhost ~]# echo "scsi remove-single-device 1 0 0 0" > 
/proc/scsi/scsi
[  639.747836] ata2.00: disable device
[root@localhost ~]#
[root@localhost ~]#
[root@localhost ~]# echo "scsi add-single-device 1 0 0 0" > /proc/scsi/scsi
[root@localhost ~]#
[root@localhost ~]#
[root@localhost ~]# lsscsi
[1:0:0:0]    cd/dvd  QEMU     QEMU DVD-ROM     2.5+  /dev/sr0
[root@localhost ~]#
[root@localhost ~]#
[root@localhost ~]# echo "scsi add-single-device 1 0 100 0" > 
/proc/scsi/scsi
-bash: echo: write error: Invalid argument
[root@localhost ~]#
[root@localhost ~]#


For a wrong scsi nubmer "1 0 100 0", it returns an error now. If our 
patch is applied, it will return ok and will add "1 0 0 0" instead, I guess.


Thanks,
Jason
