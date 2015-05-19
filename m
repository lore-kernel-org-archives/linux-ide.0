From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: READ LOG DMA EXT failed, trying unqueued
Date: Tue, 19 May 2015 21:05:08 +0900
Message-ID: <20150519120508.GB390@swordfish>
References: <20150519113320.GA498@swordfish>
 <yq1wq04kcso.fsf@sermon.lab.mkp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:36287 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932081AbbESMFb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 19 May 2015 08:05:31 -0400
Content-Disposition: inline
In-Reply-To: <yq1wq04kcso.fsf@sermon.lab.mkp.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Hannes Reinecke <hare@suse.de>, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>


Hello,

On (05/19/15 07:49), Martin K. Petersen wrote:
> Does the patch below help?

I think it should, I'll test it.


> Also, please let us know which drive you have and send us the output of:
> 
> # smartctl -l gplog,0x13 /dev/sdN
> 

hm...

sudo smartctl -l gplog,0x13 /dev/sda1
smartctl 6.3 2014-07-26 r3976 [x86_64-linux-4.1.0-rc3-dbg-00347-g0a60060-dirty] (local build)
Copyright (C) 2002-14, Bruce Allen, Christian Franke, www.smartmontools.org

General Purpose Log 0x13 does not exist (override with '-T permissive' option)


fwiw, I did `dmesg | grep -i ata`

[    0.472463] ahci 0000:00:1f.2: AHCI 0001.0300 32 slots 4 ports 6 Gbps 0x10 impl SATA mode
[    0.476304] ata1: DUMMY
[    0.476391] ata2: DUMMY
[    0.476478] ata3: DUMMY
[    0.476565] ata4: DUMMY
[    0.476654] ata5: SATA max UDMA/133 abar m2048@0xf7a1a000 port 0xf7a1a300 irq 30
[    0.795403] ata5: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    0.798156] ata5.00: ACPI cmd ef/10:06:00:00:00:00 (SET FEATURES) succeeded
[    0.798160] ata5.00: ACPI cmd f5/00:00:00:00:00:00 (SECURITY FREEZE LOCK) filtered out
[    0.798290] ata5.00: ACPI cmd b1/c1:00:00:00:00:00 (DEVICE CONFIGURATION OVERLAY) filtered out
[    0.798696] ata5.00: failed to get NCQ Send/Recv Log Emask 0x1
[    0.798699] ata5.00: ATA-9: SAMSUNG MZMTE256HMHP-000, EXT49K0Q, max UDMA/133
[    0.798821] ata5.00: 500118192 sectors, multi 16: LBA48 NCQ (depth 31/32), AA
[    0.799576] ata5.00: ACPI cmd ef/10:06:00:00:00:00 (SET FEATURES) succeeded
[    0.799581] ata5.00: ACPI cmd f5/00:00:00:00:00:00 (SECURITY FREEZE LOCK) filtered out
[    0.799705] ata5.00: ACPI cmd b1/c1:00:00:00:00:00 (DEVICE CONFIGURATION OVERLAY) filtered out
[    0.800109] ata5.00: failed to get NCQ Send/Recv Log Emask 0x1
[    0.800115] ata5.00: configured for UDMA/133
[    0.800753] scsi 4:0:0:0: Direct-Access     ATA      SAMSUNG MZMTE256 9K0Q PQ: 0 ANSI: 5


it's a SAMSUNG MZMTE256 9K0Q.

	-ss

> 
> diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
> index 2893563d0537..2b370ee0ae86 100644
> --- a/drivers/ata/libata-eh.c
> +++ b/drivers/ata/libata-eh.c
> @@ -1521,6 +1521,7 @@ retry:
>  	} else {
>  		tf.command = ATA_CMD_READ_LOG_EXT;
>  		tf.protocol = ATA_PROT_PIO;
> +		dma = false;
>  	}
>  	tf.lbal = log;
>  	tf.lbam = page;
> 
> 
