From: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH] sata_sil: disable hotplug interrupts on two ATI IXPs
Date: Mon, 26 Jun 2006 18:33:14 +0200
Message-ID: <200606261833.14905.ak@suse.de>
References: <200606252359.27671.ak@suse.de> <200606261113.30316.ak@suse.de> <20060626122352.GA10140@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:12978 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750774AbWFZQf4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 26 Jun 2006 12:35:56 -0400
In-Reply-To: <20060626122352.GA10140@htj.dyndns.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

On Monday 26 June 2006 14:23, Tejun Heo wrote:
> Some SATA controllers embedded in ATI IXPs seem to have broken
> SATA_IRQ bit in their bmdma2 registers which is always stuck at 1.
> This makes the driver believe that there has been a hotplug event and
> freeze the port whenever there's an interrupt thus failing all
> commands.
> 
> This patch disables SATA_IRQ for those controllers.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> ---
> 
> Andi, can you please verify this patch works?  Jeff, if Andi confirms
> it, please push this to Andrew & Linus.  I'll contact SIMG and try to
> find another way around this.  

Works thanks.

-Andi


libata version 1.30 loaded.
sata_sil 0000:00:11.0: version 1.0
GSI 19 sharing vector 0xC9 and IRQ 19
ACPI: PCI Interrupt 0000:00:11.0[A] -> GSI 23 (level, low) -> IRQ 201
ata1: SATA max UDMA/100 cmd 0xFFFFC2001008E080 ctl 0xFFFFC2001008E08A bmdma 0xFF
FFC2001008E000 irq 201
ata2: SATA max UDMA/100 cmd 0xFFFFC2001008E0C0 ctl 0xFFFFC2001008E0CA bmdma 0xFF
FFC2001008E008 irq 201
scsi0 : sata_sil
ata1: SATA link down (SStatus 0 SControl 300)
scsi1 : sata_sil
ata2: SATA link down (SStatus 0 SControl 300)
ACPI: PCI Interrupt 0000:00:12.0[A] -> GSI 22 (level, low) -> IRQ 177
ata3: SATA max UDMA/100 cmd 0xFFFFC20010090080 ctl 0xFFFFC2001009008A bmdma 0xFF
FFC20010090000 irq 177
ata4: SATA max UDMA/100 cmd 0xFFFFC200100900C0 ctl 0xFFFFC200100900CA bmdma 0xFF
FFC20010090008 irq 177
scsi2 : sata_sil
ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata3.00: configured for UDMA/100
scsi3 : sata_sil
ata4: SATA link down (SStatus 0 SControl 300)
  Vendor: ATA       Model: SAMSUNG SP2504C   Rev: VT10
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 488397168 512-byte hdwr sectors (250059 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sda: 488397168 512-byte hdwr sectors (250059 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
 sda: sda1 sda2 sda3
sd 2:0:0:0: Attached scsi disk sda

