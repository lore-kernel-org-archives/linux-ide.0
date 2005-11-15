From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] Marvell SATA fixes v2
Date: Tue, 15 Nov 2005 09:39:25 -0500
Message-ID: <4379F31D.4000508@pobox.com>
References: <20051114050404.GA18144@havoc.gtf.org> <Pine.LNX.4.63.0511151437320.3015@dingo.iwr.uni-heidelberg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:46760 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751431AbVKOOjb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 15 Nov 2005 09:39:31 -0500
In-Reply-To: <Pine.LNX.4.63.0511151437320.3015@dingo.iwr.uni-heidelberg.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bogdan Costescu <Bogdan.Costescu@iwr.uni-heidelberg.de>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Bogdan Costescu wrote:
> On Mon, 14 Nov 2005, Jeff Garzik wrote:
> 
>> Finally got Marvell 50XX SATA to the point where it, too, complains
>> about "ATA: abnormal status 0x80 on port ...11C"... which is progress :)
> 
> 
> Thanks for picking up the sata_mv development, Jeff!
> 
> I can confirm your results on a 5041 controller:
> 
> sata_mv 0000:02:08.0: version 0.25
> ACPI: PCI Interrupt 0000:02:08.0[A] -> GSI 26 (level, low) -> IRQ 177
> sata_mv 0000:02:08.0: 32 slots 4 ports SCSI mode IRQ via MSI
> ata11: SATA max UDMA/133 cmd 0x0 ctl 0xF8C22120 bmdma 0x0 irq 177
> ata12: SATA max UDMA/133 cmd 0x0 ctl 0xF8C24120 bmdma 0x0 irq 177
> ata13: SATA max UDMA/133 cmd 0x0 ctl 0xF8C26120 bmdma 0x0 irq 177
> ata14: SATA max UDMA/133 cmd 0x0 ctl 0xF8C28120 bmdma 0x0 irq 177
> ATA: abnormal status 0x80 on port 0xF8C2211C
> ata11: dev 0 cfg 49:2f00 82:74eb 83:7feb 84:4123 85:74e9 86:3c03 87:4123 
> 88:007f
> ata11: dev 0 ATA-7, max UDMA/133, 781422768 sectors: LBA48
> 
> (there is a 400GB Hitachi disk attached to the first port)

hey, great, that's farther than I got.


> However, when running 'insmod ./sata_mv.ko' with a disk attched, insmod 
> doesn't return, it gets blocked into "D" state (gdb says "ptrace: 
> Operation not permitted." while strace attaches but doesn't show 
> anything and cannot be detached). This is with the 2.6.15-rc1 based FC 
> devel kernel (2.6.14-1.1665), using up-to-date FC4 user space, if that 
> helps... This is not an one-off, I was able to reproduce it three times 
> out of three :-(

any chance you could obtain additional debugging output by turning on
#undef ATA_DEBUG                /* debugging output */
#undef ATA_VERBOSE_DEBUG        /* yet more debugging output */

in include/linux/libata.h?  this would help us see where it is stuck in 
'D' state.

Also, you might try turning off CONFIG_PCI_MSI, in case MSI is 
problematic on your machine, or on this card.


> Another thing that I noticed and don't know if it's normal is that the 
> ataXX ports remain "allocated" even after rmmod; I have two ICH6 ports 
> (ata1 and 2) and then insmod-ed the sata_mv driver 2 times without disks 
> attached (which took ata3-6 and ata7-10) and then the insmod shown above.

That's expect, as we just use a simple counter to create a unique id:

         host->unique_id = ata_unique_id++;

Regards and thanks,

	Jeff


