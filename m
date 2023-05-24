Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB132C7EE29
	for <linux-ide@archiver.kernel.org>; Wed, 24 May 2023 01:31:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbjEXBbH (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 23 May 2023 21:31:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238994AbjEXBbG (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 23 May 2023 21:31:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CAC4136
        for <linux-ide@vger.kernel.org>; Tue, 23 May 2023 18:31:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A255C637BA
        for <linux-ide@vger.kernel.org>; Wed, 24 May 2023 01:31:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99178C433D2;
        Wed, 24 May 2023 01:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684891864;
        bh=cdzhjgFxZiQ9xJ3tGFAp1j2mVdzZh9yPFSXHYSdn8VQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Osx1Td0ZVyhejHQfYx2SDALuYewEjKoy3sUrsvKCPMAJG3Xqk9JW50iQ1oK9FyylX
         5SmUHtFV6XKvHaiJlINgWZCQjQJ1PNp3K+7BpCaPbhAkC/p5JFYcs+p3OBtz9iKDDC
         8biY2v5SKEWKB8TkouRAc1NPBK54l9Xnq5IyFPnfQG6Y1DOydIRK8ZeN+I6kN32bdV
         FTeZdXznPhS+RUXlaavfG3sk0P3vLyHRGX8ygqyDqbDn6mXtxblqfYxG4zK0bQtP/R
         l7rnn1oZtyQSiXnNkY3UjVOkrcMMwvs+MKgT7cgZAwWRR5XrKkafObMVKPhGnd/wj2
         dHjE6yHxKG1pg==
Message-ID: <18bd6b4f-0c08-2ea3-c676-1803f55de9bf@kernel.org>
Date:   Wed, 24 May 2023 10:31:02 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2] ata: libata-scsi: Use correct device no in
 ata_find_dev()
To:     Jason Yan <yanaijie@huawei.com>, linux-ide@vger.kernel.org
Cc:     John Garry <john.g.garry@oracle.com>,
        Xingui Yang <yangxingui@huawei.com>
References: <20230523023219.291253-1-dlemoal@kernel.org>
 <a291e973-32e3-f717-4b94-54a78c514800@huawei.com>
 <301a5198-9686-e3b5-74d8-4e5e85e6fc08@kernel.org>
 <cb2d18ed-2b61-6d92-96f4-4c84429ebe74@huawei.com>
Content-Language: en-US
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <cb2d18ed-2b61-6d92-96f4-4c84429ebe74@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 5/23/23 21:29, Jason Yan wrote:
> On 2023/5/23 19:52, Damien Le Moal wrote:
>>> I wonder if you can change the type of devno to 'unsigned int'? At a
>>> closer look I found the user can control this value and may pass in a
>>> bogus channel or id.
>>>
>>> proc_scsi_write
>>>       =>scsi_add_single_device
>>>           =>ata_scsi_user_scan
>>>               =>ata_find_dev
>> Reading more about scsi_add_single_device(), the comment says "Note:
>> this seems
>> to be aimed exclusively at SCSI parallel busses.". So I don't think we
>> should
>> worry about it. But then I also do not understand why libata is wired
>> to this at
>> all. Cannot have ATA device on a parallel SCSI bus...
> 
> The comment is kind of obsolete. It is not limited to SCSI parallel
> busses only.
> 
>>
>> On my system, I cannot get
>>
>> echo "scsi add-single-device X 0 100 0" >/proc/scsi/scsi
>>
>> to do anything and so I do not see how ata_scsi_user_scan can ever be
>> called...
>>
> 
> Did you enabled CONFIG_SCSI_PROC_FS ? I started a qemu and it still works.
> 
> [root@localhost ~]# cat /proc/scsi/scsi
> Attached devices:
> Host: scsi1 Channel: 00 Id: 00 Lun: 00
>   Vendor: QEMU     Model: QEMU DVD-ROM     Rev: 2.5+
>   Type:   CD-ROM                           ANSI  SCSI revision: 05
> [root@localhost ~]# lsscsi
> [1:0:0:0]    cd/dvd  QEMU     QEMU DVD-ROM     2.5+  /dev/sr0
> [root@localhost ~]#
> [root@localhost ~]#
> [root@localhost ~]# echo "scsi remove-single-device 1 0 0 0" >
> /proc/scsi/scsi
> [  639.747836] ata2.00: disable device
> [root@localhost ~]#
> [root@localhost ~]#
> [root@localhost ~]# echo "scsi add-single-device 1 0 0 0" > /proc/scsi/scsi
> [root@localhost ~]#
> [root@localhost ~]#
> [root@localhost ~]# lsscsi
> [1:0:0:0]    cd/dvd  QEMU     QEMU DVD-ROM     2.5+  /dev/sr0
> [root@localhost ~]#
> [root@localhost ~]#
> [root@localhost ~]# echo "scsi add-single-device 1 0 100 0" >
> /proc/scsi/scsi
> -bash: echo: write error: Invalid argument
> [root@localhost ~]#
> [root@localhost ~]#
> 
> 
> For a wrong scsi nubmer "1 0 100 0", it returns an error now. If our
> patch is applied, it will return ok and will add "1 0 0 0" instead, I
> guess.

Indeed. Using ata_find_dev() in ata_scsi_user_scan() as it is is not
broken. And ata_scsi_user_scan() is also likely broken in subtle ways
for libsas due to the ata port being determined from the scsi host,
which does not seem to be how libsas manages things. Need to dig further.

> 
> 
> Thanks,
> Jason

-- 
Damien Le Moal
Western Digital Research

