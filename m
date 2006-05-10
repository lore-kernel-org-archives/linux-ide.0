From: "zhao, forrest" <forrest.zhao@intel.com>
Subject: Re: [ANNOUNCE] libata EH/NCQ/hotplug/PM git tree
Date: Wed, 10 May 2006 13:36:36 +0800
Message-ID: <1147239396.7273.13.camel@forrest26.sh.intel.com>
References: <44614592.7080301@gmail.com>
	 <1147236696.7273.5.camel@forrest26.sh.intel.com>
	 <44617782.7000302@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:40554 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S964817AbWEJFrZ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 10 May 2006 01:47:25 -0400
In-Reply-To: <44617782.7000302@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Albert Lee <albertcc@tw.ibm.com>, Jens Axboe <axboe@suse.de>, Edward Falk <efalk@google.com>, Carlos Pardo <Carlos.Pardo@siliconimage.com>, Raymond Liu <Raymond.Liu@siliconimage.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

On Wed, 2006-05-10 at 14:17 +0900, Tejun Heo wrote:

> Does your ICH7 report 1 for the SMP bit (bit 17 of the CAP register)?
> Cool.  How come mine doesn't?  :/  Can you tell me the exact name of the
> product?
Yes, PMP bit is set. let me post the dmesg output here:

ahci 0000:00:1f.2: AHCI 0001.0000 32 slots 6 ports ? Gbps 0x3f impl SATA
mode
ahci 0000:00:1f.2: flags: 64bit stag led pmp
ata1: SATA max UDMA/133 cmd 0xFFFFC20000002100 ctl 0x0 bmdma 0x0 irq 201
ata2: SATA max UDMA/133 cmd 0xFFFFC20000002180 ctl 0x0 bmdma 0x0 irq 201
ata3: SATA max UDMA/133 cmd 0xFFFFC20000002200 ctl 0x0 bmdma 0x0 irq 201
ata4: SATA max UDMA/133 cmd 0xFFFFC20000002280 ctl 0x0 bmdma 0x0 irq 201
ata5: SATA max UDMA/133 cmd 0xFFFFC20000002300 ctl 0x0 bmdma 0x0 irq 201
ata6: SATA max UDMA/133 cmd 0xFFFFC20000002380 ctl 0x0 bmdma 0x0 irq 201
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4003 85:3469 86:3c01 87:4003
88:007f
ata1: dev 0 ATA-6, max UDMA/133, 234441648 sectors: LBA48 NCQ (depth
0/32)
ata1: dev 0 configured for UDMA/133

The platform name is bensley, and the chipset is ESB2 instead of ICH7
(sorry for my mistake in last mail), the output of lspci is:

00:1f.2 Class 0106: Intel Corporation Enterprise Southbridge SATA
cc=AHCI (rev 08)

> Zhao, I think I've ironed out all the problems you've reported with the
> previous revision of hotplug.  If you've got some time, can you please
> check whether those problems are really gone?
> 
Yes, I'm preparing for the next round of test for your updated patches.

Thanks,
Forrest
