From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] ata_piix: fix MAP VALUE interpretation for for ICH6/7
Date: Wed, 1 Feb 2006 14:13:11 +0900
Message-ID: <20060201051311.GA28302@htj.dyndns.org>
References: <20051218081707.GA4129@htj.dyndns.org> <43D98C23.4040004@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from xproxy.gmail.com ([66.249.82.196]:25305 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030341AbWBAFNS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 1 Feb 2006 00:13:18 -0500
Received: by xproxy.gmail.com with SMTP id i30so54627wxd
        for <linux-ide@vger.kernel.org>; Tue, 31 Jan 2006 21:13:17 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <43D98C23.4040004@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

On Thu, Jan 26, 2006 at 09:57:39PM -0500, Jeff Garzik wrote:
> Tejun Heo wrote:
> >Unlike their older siblings, ICH6 and 7 use different scheme for MAP
> >VALUE.  This patch makes ata_piix interpret MV properly on ICH6/7.
> >
> >Pre-ICH6/7
> >
> > The value of these bits indicate the address range the SATA port
> > responds to, and whether or not the SATA and IDE functions are
> > combined.
> >
> > 000 = Non-combined. P0 is primary master. P1 is secondary master.
> > 001 = Non-combined. P0 is secondary master. P1 is primary master.
> > 100 = Combined. P0 is primary master. P1 is primary slave. P-ATA is
> >       2:0 Map Value secondary.
> > 101 = Combined. P0 is primary slave. P1 is primary master. P-ATA is
> >       secondary.
> > 110 = Combined. P-ATA is primary. P0 is secondary master. P1 is
> >       secondary slave.
> > 111 = Combined. P-ATA is primary. P0 is secondary slave. P1 is
> >       secondary master.
> >
> >ICH6/7
> >
> > Map Value - R/W. Map Value (MV): The value in the bits below indicate
> >the address range the SATA ports responds to, and whether or not the
> >PATA and SATA functions are combined. When in combined mode, the AHCI
> >memory space is not available and AHCI may not be used.
> >
> > 00 = Non-combined. P0 is primary master, P2 is the primary slave. P1
> >      is secondary master, P3 is the 1:0 secondary slave (desktop
> >      only). P0 is primary master, P2 is the primary slave (mobile
> >      only).
> > 01 = Combined. IDE is primary. P1 is secondary master, P3 is the
> >      secondary slave. (desktop only)
> > 10 = Combined. P0 is primary master. P2 is primary slave. IDE is secondary
> > 11 = Reserved
> >
> >Signed-off-by: Tejun Heo <htejun@gmail.com>
> 
> applied to upstream-2.6.17.  patch looks OK, but only testing on 
> ICH5+6+7 will really convince me.  Documentation has often been confused 
> before, and the only data I've received from you is "it works for me." 
> So, proceeding with caution :)
> 

Here are some results on my ICH7 (ASUS P5LD2).  This is on vanilla
2.6.15.  I've added printk of PMR in piix_init_one().  You can see
bridge limit is being applied to an IDE drive hooked on the PATA port
due to PMR misinterpretation.  If I put my SATA DVD writer (PX716SA)
which has SATA bridge embedded on the combined SATA port, the opposite
happens.  Bridge limit is not applied when it's needed.

Also note that quirk_intel_ide_combined() in drivers/pci/quirks.c is
already interpreting ICH6/7 MAP value correctly.


Pri PATA + Sec SATA (combined)
==============================

ata_piix: PMR=0x1

ata1: SATA max UDMA/133 cmd 0x1F0 ctl 0x3F6 bmdma 0xFFA0 irq 14
ata1: dev 0 cfg 49:2f00 82:7c69 83:4009 84:4000 85:7c69 86:0001 87:4000 88:041f
ata1: dev 0 ATA-5, max UDMA/66, 25410672 sectors: LBA
ata1(0): applying bridge limits
ata1: dev 0 configured for UDMA/66
scsi1 : ata_piix
  Vendor: ATA       Model: Maxtor 91301U3    Rev: FA57
  Type:   Direct-Access                      ANSI SCSI revision: 05
ata2: SATA max UDMA/133 cmd 0x170 ctl 0x376 bmdma 0xFFA8 irq 15
ata2: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4023 85:3469 86:3c01 87:4023 88:207f
ata2: dev 0 ATA-7, max UDMA/133, 312581808 sectors: LBA48
ata2: dev 0 configured for UDMA/133
scsi2 : ata_piix
  Vendor: ATA       Model: ST3160812AS       Rev: 3.AA
  Type:   Direct-Access                      ANSI SCSI revision: 05

# lspci -s 00:1f
0000:00:1f.0 ISA bridge: Intel Corporation 82801GB/GR (ICH7 Family) LPC Interface Bridge (rev 01)
0000:00:1f.2 IDE interface: Intel Corporation 82801GB/GR/GH (ICH7 Family) Serial ATA Storage Controllers cc=IDE (rev 01)
0000:00:1f.3 SMBus: Intel Corporation 82801G (ICH7 Family) SMBus Controller (rev 01)

# lspci -ns 00:1f
0000:00:1f.0 0601: 8086:27b8 (rev 01)
0000:00:1f.2 0101: 8086:27c0 (rev 01)
0000:00:1f.3 0c05: 8086:27da (rev 01)


SATA only
=========

ata_piix: PMR=0x0

ata1: SATA max UDMA/133 cmd 0x1F0 ctl 0x3F6 bmdma 0xFFA0 irq 14
ata1: dev 0 cfg 49:2f00 82:7c6b 83:5b09 84:4043 85:7c69 86:1a01 87:4043 88:207f
ata1: dev 0 ATA-7, max UDMA/133, 160086528 sectors: LBA
ata1: dev 1 cfg 49:2f00 82:746b 83:7f01 84:4023 85:7469 86:3c01 87:4023 88:20ff
ata1: dev 1 ATA-7, max UDMA7, 312581808 sectors: LBA48
ata1: dev 0 configured for UDMA/133
ata1: dev 1 configured for UDMA/133
scsi1 : ata_piix
  Vendor: ATA       Model: Maxtor 6B080M0    Rev: BANC
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: ATA       Model: SAMSUNG HD160JJ   Rev: ZM10
  Type:   Direct-Access                      ANSI SCSI revision: 05
ata2: SATA max UDMA/133 cmd 0x170 ctl 0x376 bmdma 0xFFA8 irq 15
ata2: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4023 85:3469 86:3c01 87:4023 88:207f
ata2: dev 0 ATA-7, max UDMA/133, 312581808 sectors: LBA48
ata2: dev 0 configured for UDMA/133
scsi2 : ata_piix
  Vendor: ATA       Model: ST3160812AS       Rev: 3.AA
  Type:   Direct-Access                      ANSI SCSI revision: 05

# lspci -s 00:1f
0000:00:1f.0 ISA bridge: Intel Corporation 82801GB/GR (ICH7 Family) LPC Interface Bridge (rev 01)
0000:00:1f.2 IDE interface: Intel Corporation 82801GB/GR/GH (ICH7 Family) Serial ATA Storage Controllers cc=IDE (rev 01)
0000:00:1f.3 SMBus: Intel Corporation 82801G (ICH7 Family) SMBus Controller (rev 01)

# lspci -ns 00:1f
0000:00:1f.0 0601: 8086:27b8 (rev 01)
0000:00:1f.2 0101: 8086:27c0 (rev 01)
0000:00:1f.3 0c05: 8086:27da (rev 01)


PATA only
=========

# lspci -s 00:1f
0000:00:1f.0 ISA bridge: Intel Corporation 82801GB/GR (ICH7 Family) LPC Interface Bridge (rev 01)
0000:00:1f.1 IDE interface: Intel Corporation 82801G (ICH7 Family) IDE Controller (rev 01)
0000:00:1f.3 SMBus: Intel Corporation 82801G (ICH7 Family) SMBus Controller (rev 01)

# lspci -ns 00:1f
0000:00:1f.0 0601: 8086:27b8 (rev 01)
0000:00:1f.1 0101: 8086:27df (rev 01)
0000:00:1f.3 0c05: 8086:27da (rev 01)
