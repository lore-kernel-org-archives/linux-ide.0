Return-Path: <SRS0=YTe+=65=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF6A2C433E0
	for <linux-ide@archiver.kernel.org>; Fri, 15 May 2020 17:49:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A71AB20657
	for <linux-ide@archiver.kernel.org>; Fri, 15 May 2020 17:49:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726179AbgEORtG convert rfc822-to-8bit (ORCPT
        <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 15 May 2020 13:49:06 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:37961 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbgEORtG (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 15 May 2020 13:49:06 -0400
Received: from mail-pf1-f198.google.com ([209.85.210.198])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1jZeSF-0000ir-1P
        for linux-ide@vger.kernel.org; Fri, 15 May 2020 17:49:03 +0000
Received: by mail-pf1-f198.google.com with SMTP id 194so2507030pfb.15
        for <linux-ide@vger.kernel.org>; Fri, 15 May 2020 10:49:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=XNrxl7Ei4SzRzAuobvLq0dv0NglXRJzSCfyYrWyMnGQ=;
        b=sn5UWZJc1+DY7UfNUrpfIyDBVvag5oHcz7VODBZG35CpVnzyvAqQl+EtZpqhaNr0kR
         tBZFxe2eikVDYASeaZTZy16tQ4oBIWDudE8p4aRYH+TB4X+4ZhZ6p+6ooWIr/kOSDvuq
         zIkd4ygFEQqco18VTab3SVADIDc6y+VIr79JE0oGvFDR3sz/gnaXdJio6kcj7hZHk+U6
         st3GgF+YPXRqTwA0engfSeCCfWlifvdPfU7CVtoFZZ8thZygQvzw6W+qBeTcgoGuxupz
         wN8h8FIpjArziKgcvD2uUJM3RSi+Jp/hwYGvem6NFDhBc7wd2aO6KxcgWEqtzdzcHxoO
         JtVg==
X-Gm-Message-State: AOAM5330OFT67zEdIChN9PmpINyiCqZLWPzJRAyVOMOzKnmWZcXTHjcy
        VHeR770VPGy/GpIG1wCyd8In0t3KWX0BcziDpGpII4idxoUMdAwJVZpieMxyVS99p1LJdOCof0Q
        7xFZRVtXU8Os0BJsGPqpn4xgbp/CCkxG9a6skyw==
X-Received: by 2002:a17:90a:1f4b:: with SMTP id y11mr4818642pjy.136.1589564941560;
        Fri, 15 May 2020 10:49:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzF7OfuYHHgmnr3u2K2khymUzuj1d3YSkFB3LJdHptvsBqWppa7E7h//JX9y1UDJwrEIuNN0Q==
X-Received: by 2002:a17:90a:1f4b:: with SMTP id y11mr4818546pjy.136.1589564940851;
        Fri, 15 May 2020 10:49:00 -0700 (PDT)
Received: from [192.168.1.208] (220-133-187-190.HINET-IP.hinet.net. [220.133.187.190])
        by smtp.gmail.com with ESMTPSA id o27sm2280110pgd.18.2020.05.15.10.48.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 May 2020 10:49:00 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH] libata: Use per port sync for detach
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <555101fd-71bc-fa0b-98c2-69249bb3eda6@huawei.com>
Date:   Sat, 16 May 2020 01:48:57 +0800
Cc:     Jens Axboe <axboe@kernel.dk>,
        "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <15CFC20D-B8CB-43D7-8973-60E82DE6B894@canonical.com>
References: <20200515110916.11556-1-kai.heng.feng@canonical.com>
 <555101fd-71bc-fa0b-98c2-69249bb3eda6@huawei.com>
To:     John Garry <john.garry@huawei.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org



> On May 15, 2020, at 20:38, John Garry <john.garry@huawei.com> wrote:
> 
> On 15/05/2020 12:09, Kai-Heng Feng wrote:
>> Commit 130f4caf145c ("libata: Ensure ata_port probe has completed before
>> detach") may cause system freeze during suspend.
>> Using async_synchronize_full() in PM callbacks is wrong, since async
>> callbacks that are already scheduled may wait for not-yet-scheduled
>> callbacks, causes a circular dependency.
> 
> It would be nice to describe this circular dependency a bit more.

Hmm, I think it's quite self-explanatory. Which part do you want me to add? 

> 
>> Instead of using big hammer like async_synchronize_full(), use async
>> cookie to make sure port probe are synced, without affecting other
>> scheduled PM callbacks.
> 
> oh, I thought that we could avoid the hassle of per-port cookie management. Sorry.
> 
> Did you check if the original issue which I tried to remedy is still suppressed?
> 
> I tried your patch, and got this:
> 
> [   28.190587] ------------[ cut here ]------------
> [   28.195194] WARNING: CPU: 79 PID: 1 at drivers/ata/libata-core.c:5888 ata_hos
> t_detach+0x238/0x248
> [   28.204025] Modules linked in:
> [   28.207072] CPU: 79 PID: 1 Comm: swapper/0 Tainted: G        W  5.7.0-
> rc5-g644cd6f-dirty #84
> [   28.216076] Hardware name: Huawei TaiShan 2280 V2/BC82AMDC, BIOS 2280-V2 CS V
> 3.B220.02 03/27/2020
> [   28.224906] pstate: 20c00009 (nzCv daif +PAN +UAO)
> [   28.229677] pc : ata_host_detach+0x238/0x248
> [   28.233929] lr : ata_host_detach+0x12c/0x248
> [   28.238181] sp : ffff0026dc74f980
> [   28.241481] x29: ffff0026dc74f980 x28: 0000000000000000
> [   28.246769] x27: ffff2026c541c010 x26: 00000000000038e0
> [   28.252059] x25: 0000000000003590 x24: ffff0026d3a0a018
> [   28.257350] x23: 0000000000000001 x22: ffff0026d3a0a000
> [   28.262638] x21: 0000000000013ec0 x20: ffff2026c541c000
> [   28.267928] x19: ffff2026c541c020 x18: 0000000000000000
> [   28.273215] x17: 0000000000000000 x16: 0000000000000000
> [   28.278504] x15: 00000000000006c0 x14: 0000000000000000
> [   28.283792] x13: 0000000000000000 x12: 1fffe004da744317
> [   28.289081] x11: ffff8004da744317 x10: dfffa00000000000
> [   28.294370] x9 : ffff8004da744318 x8 : ffff0026d3a218bc
> [   28.299657] x7 : 0000000000000001 x6 : ffff8004da744318
> [   28.304945] x5 : ffff8004da744318 x4 : dfffa00000000000
> [   28.310233] x3 : ffffa00075ea18b4 x2 : 0000000000000003
> [   28.315521] x1 : 0000000000000000 x0 : 0000000000400200
> [   28.320808] Call trace:
> [   28.323246]  ata_host_detach+0x238/0x248
> [   28.327153]  ata_pci_remove_one+0x24/0x38
> [   28.331147]  ahci_remove_one+0x54/0x88
> [   28.334881]  pci_device_remove+0x70/0x148
> [   28.338874]  really_probe+0x17c/0x570
> [   28.342522]  driver_probe_device+0x80/0x150
> [   28.346690]  device_driver_attach+0x9c/0xa8
> [   28.350856]  __driver_attach+0xac/0x118
> [   28.354677]  bus_for_each_dev+0xf0/0x168
> [   28.358584]  driver_attach+0x34/0x48
> [   28.362146]  bus_add_driver+0x240/0x300
> [   28.365966]  driver_register+0xc0/0x1e0
> [   28.369787]  __pci_register_driver+0xb4/0xd0
> [   28.374039]  ahci_pci_driver_init+0x24/0x30
> [   28.378205]  do_one_initcall+0xb8/0x268
> [   28.382027]  kernel_init_freeable+0x294/0x30c
> [   28.386366]  kernel_init+0x14/0x120
> [   28.389841]  ret_from_fork+0x10/0x1c
> [   28.393400] ---[ end trace 9972785c7052048f ]---
> [   28.435826] ahci 0000:b4:03.0: SSS flag set, parallel bus scan disabled

Can you please test the following patch:

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 474c6c34fe02..51ee0cc4d414 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -3583,8 +3583,10 @@ int ata_eh_recover(struct ata_port *ap, ata_prereset_fn_t prereset,
        rc = 0;
 
        /* if UNLOADING, finish immediately */
-       if (ap->pflags & ATA_PFLAG_UNLOADING)
+       if (ap->pflags & ATA_PFLAG_UNLOADING) {
+               ap->pflags |= ATA_PFLAG_UNLOADED;
                goto out;
+       }

It's only compile-tested, many drivers panic with CONFIG_DEBUG_TEST_DRIVER_REMOVE enabled, so the system I have can't even boot properly :(

Probably worth some time to fix them one by one...

Kai-Heng

> 
> 
> Thanks,
> John
> 
>> Fixes: 130f4caf145c ("libata: Ensure ata_port probe has completed before detach")
>> BugLink: https://bugs.launchpad.net/bugs/1867983
>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>> ---
>>  drivers/ata/libata-core.c | 6 +++---
>>  include/linux/libata.h    | 3 +++
>>  2 files changed, 6 insertions(+), 3 deletions(-)
>> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
>> index beca5f91bb4c..4a698f6388cd 100644
>> --- a/drivers/ata/libata-core.c
>> +++ b/drivers/ata/libata-core.c
>> @@ -42,7 +42,6 @@
>>  #include <linux/workqueue.h>
>>  #include <linux/scatterlist.h>
>>  #include <linux/io.h>
>> -#include <linux/async.h>
>>  #include <linux/log2.h>
>>  #include <linux/slab.h>
>>  #include <linux/glob.h>
>> @@ -5778,7 +5777,7 @@ int ata_host_register(struct ata_host *host, struct scsi_host_template *sht)
>>  	/* perform each probe asynchronously */
>>  	for (i = 0; i < host->n_ports; i++) {
>>  		struct ata_port *ap = host->ports[i];
>> -		async_schedule(async_port_probe, ap);
>> +		ap->cookie = async_schedule(async_port_probe, ap);
>>  	}
>>    	return 0;
>> @@ -5921,7 +5920,8 @@ void ata_host_detach(struct ata_host *host)
>>  	int i;
>>    	/* Ensure ata_port probe has completed */
>> -	async_synchronize_full();
>> +	for (i = 0; i < host->n_ports; i++)
>> +		async_synchronize_cookie(host->ports[i]->cookie);
>>    	for (i = 0; i < host->n_ports; i++)
> 
> Is it possible to combine these "for" loops?
> 
>>  		ata_port_detach(host->ports[i]);
>> diff --git a/include/linux/libata.h b/include/linux/libata.h
>> index cffa4714bfa8..ae6dfc107ea8 100644
>> --- a/include/linux/libata.h
>> +++ b/include/linux/libata.h
>> @@ -22,6 +22,7 @@
>>  #include <linux/acpi.h>
>>  #include <linux/cdrom.h>
>>  #include <linux/sched.h>
>> +#include <linux/async.h>
>>  
> 
> alphabetic?
> 
>>  /*
>>   * Define if arch has non-standard setup.  This is a _PCI_ standard
>> @@ -872,6 +873,8 @@ struct ata_port {
>>  	struct timer_list	fastdrain_timer;
>>  	unsigned long		fastdrain_cnt;
>>  +	async_cookie_t		cookie;
>> +
>>  	int			em_message_type;
>>  	void			*private_data;

