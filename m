From: Andi Kleen <ak@suse.de>
Subject: Re: More information on ATI IXP failure in git9
Date: Mon, 26 Jun 2006 08:18:46 +0200
Message-ID: <200606260818.46672.ak@suse.de>
References: <200606252359.27671.ak@suse.de> <449F1AEE.700@pobox.com> <20060626021011.GB21435@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:20697 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751170AbWFZGSy (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 26 Jun 2006 02:18:54 -0400
In-Reply-To: <20060626021011.GB21435@htj.dyndns.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

On Monday 26 June 2006 04:10, Tejun Heo wrote:
> On Sun, Jun 25, 2006 at 07:23:26PM -0400, Jeff Garzik wrote:
> > Andi created a patch at my suggestion:
> > http://one.firstfloor.org/~andi/sil-debug
> > 
> > and that got him mounting the device, but the EH was still giving him 
> > much pain:
> > http://one.firstfloor.org/~andi/sata-error-loop
> > 
> > It looks like some condition isn't getting ack'd...
> 
> Weird.  To me, it almost seems like BMDMA2 is lying about whether it
> generated interrupt or not.  e.g. It's sharing IRQ w/ another device,

It shares the interrupt with a 8139 NIC

> but when the other device raises interrupt, BMDMA2 says it generated
> the IRQ.
> 
> Once frozen, new EH does pretty good job of clearing status and the
> interrupts seem too sporadic to be unacked IRQ.
>
> Andi, can you pleaes try the following patch?  It makes sata_sil print
> more data on errors and disables SATA PHY IRQ.

Still doesn't work with it - see http://one.firstfloor.org/~andi/sata3.jpg

For reference a working 2.6.16-suse boot again (I think the ports must be mislabelled
on the mobo - i especially connected the disk to port 1 as printed on the PCB) 

ata1: SATA max UDMA/100 cmd 0xFFFFC20000012080 ctl 0xFFFFC2000001208A bmdma 0xFFFFC20000012000 irq 201
ata2: SATA max UDMA/100 cmd 0xFFFFC200000120C0 ctl 0xFFFFC200000120CA bmdma 0xFFFFC20000012008 irq 201
ata1: SATA link down (SStatus 0)
scsi0 : sata_sil
ata2: SATA link down (SStatus 0)
scsi1 : sata_sil
ACPI: PCI Interrupt 0000:00:12.0[A] -> GSI 22 (level, low) -> IRQ 177
ata3: SATA max UDMA/100 cmd 0xFFFFC20000014080 ctl 0xFFFFC2000001408A bmdma 0xFFFFC20000014000 irq 177
ata4: SATA max UDMA/100 cmd 0xFFFFC200000140C0 ctl 0xFFFFC200000140CA bmdma 0xFFFFC20000014008 irq 177
ata3: SATA link up 1.5 Gbps (SStatus 113)
ata3: dev 0 cfg 00:0040 49:2f00 82:746b 83:7f01 84:4023 85:7469 86:3c01 87:4023 88:40ff 93:0000
ata3: dev 0 ATA-7, max UDMA7, 488397168 sectors: LBA48
sata_get_dev_handle: SATA dev addr=0x120000, handle=0x0000000000000000
ata3: dev 0 configured for UDMA/100
sata_get_dev_handle: SATA dev addr=0x120000, handle=0x0000000000000000
scsi2 : sata_sil
ata4: SATA link down (SStatus 0)
scsi3 : sata_sil
  Vendor: ATA       Model: SAMSUNG SP2504C   Rev: VT10
  Type:   Direct-Access                      ANSI SCSI revision: 05
Driver 'sd' needs updating - please use bus_type methods
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
ehci_hcd: block sizes: qh 160 qtd 96 itd 192 sitd 96




-Andi
