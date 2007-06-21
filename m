From: Vincent Bernat <Vincent.Bernat@wallix.com>
Subject: SATA update in 2.4, ICH8
Date: Thu, 21 Jun 2007 09:41:58 +0200
Message-ID: <87y7idiwjd.fsf@naruto.ifr.lan>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.wallix.com ([212.43.221.50]:37197 "EHLO postman.wallix.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753185AbXFUIMc (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 21 Jun 2007 04:12:32 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Willy Tarreau <w@1wt.eu>, linux-ide@vger.kernel.org
Cc: JF Taltavull <jean-francois.taltavull@wallix.com>

--=-=-=

Hi !

I have patched 2.4.34 with the  following patch to allow the use of SATA
drive on an ICH8 motherboard :


--=-=-=
Content-Type: text/x-patch
Content-Disposition: inline

--- linux/drivers/scsi/ata_piix.c~	2006-12-22 17:06:45.000000000 -0500
+++ linux/drivers/scsi/ata_piix.c	2007-06-14 05:27:02.000000000 -0400
@@ -115,6 +115,8 @@
 	{ 0x8086, 0x2653, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich6_sata_rm },
 	{ 0x8086, 0x27c0, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich7_sata },
 	{ 0x8086, 0x27c4, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich7_sata },
+	{ 0x8086, 0x2820, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich7_sata },
+	{ 0x8086, 0x2825, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich7_sata },
 	{ 0x8086, 0x2680, PCI_ANY_ID, PCI_ANY_ID, 0, 0, esb2_sata },
 
 	{ }	/* terminate list */

--=-=-=
Content-Disposition: inline


This works fine for the disk but  this does not work for the CDROM. Here
is lspci:

00:00.0 Host bridge: Intel Corporation Q963/Q965 Memory Controller Hub (rev 02)
00:01.0 PCI bridge: Intel Corporation Q963/Q965 PCI Express Root Port (rev 02)
00:02.0 VGA compatible controller: Intel Corporation Q963/Q965 Integrated Graphics Controller (rev 02)
00:02.1 Display controller: Intel Corporation Q963/Q965 Integrated Graphics Controller (rev 02)
00:1a.0 USB Controller: Intel Corporation 82801H (ICH8 Family) USB UHCI #4 (rev 02)
00:1a.1 USB Controller: Intel Corporation 82801H (ICH8 Family) USB UHCI #5 (rev 02)
00:1a.7 USB Controller: Intel Corporation 82801H (ICH8 Family) USB2 EHCI #2 (rev 02)
00:1b.0 Audio device: Intel Corporation 82801H (ICH8 Family) HD Audio Controller (rev 02)
00:1c.0 PCI bridge: Intel Corporation 82801H (ICH8 Family) PCI Express Port 1 (rev 02)
00:1c.4 PCI bridge: Intel Corporation 82801H (ICH8 Family) PCI Express Port 5 (rev 02)
00:1d.0 USB Controller: Intel Corporation 82801H (ICH8 Family) USB UHCI #1 (rev 02)
00:1d.1 USB Controller: Intel Corporation 82801H (ICH8 Family) USB UHCI #2 (rev 02)
00:1d.2 USB Controller: Intel Corporation 82801H (ICH8 Family) USB UHCI #3 (rev 02)
00:1d.7 USB Controller: Intel Corporation 82801H (ICH8 Family) USB2 EHCI #1 (rev 02)
00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev f2)
00:1f.0 ISA bridge: Intel Corporation 82801HB/HR (ICH8/R) LPC Interface Controller (rev 02)
00:1f.2 IDE interface: Intel Corporation 82801H (ICH8 Family) 4 port SATA IDE Controller (rev 02)
00:1f.3 SMBus: Intel Corporation 82801H (ICH8 Family) SMBus Controller (rev 02)
00:1f.5 IDE interface: Intel Corporation 82801H (ICH8 Family) 2 port SATA IDE Controller (rev 02)
03:00.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5754 Gigabit Ethernet PCI Express (rev 02)

An excerpt of dmesg :

Jun 21 05:11:10 debian kernel: libata version 1.20 loaded.
Jun 21 05:11:10 debian kernel: PCI(00:1f.2): version 1.05
Jun 21 05:11:10 debian kernel: PCI: Setting latency timer of device 00:1f.2 to 64
Jun 21 05:11:10 debian kernel: PCI: Setting latency timer of device 00:1f.5 to 64
Jun 21 05:11:10 debian kernel: ata1: SATA max UDMA/133 cmd 0xFE00 ctl 0xFE12 bmdma 0xFEC0 irq 20
Jun 21 05:11:10 debian kernel: ata2: SATA max UDMA/133 cmd 0xFE20 ctl 0xFE32 bmdma 0xFEC8 irq 20
Jun 21 05:11:10 debian kernel: ata1: dev 0 cfg 49:2f00 82:346b 83:7701 84:4023 85:3469 86:3601 87:4023 88:207f
Jun 21 05:11:10 debian kernel: ata1: dev 0 ATA-7, max UDMA/133, 156250000 sectors: LBA48
Jun 21 05:11:10 debian kernel: ata1: dev 0 configured for UDMA/133
Jun 21 05:11:10 debian kernel: ata2: dev 0 cfg 49:0f00 82:4210 83:5000 84:4000 85:0210 86:1000 87:4000 88:203f
Jun 21 05:11:10 debian kernel: ata2: dev 0 ATAPI, max UDMA/100
Jun 21 05:11:10 debian kernel: ata2: PIO error
Jun 21 05:11:10 debian kernel: ata2: dev 1 cfg 49:0000 82:0000 83:0000 84:0000 85:0000 86:0000 87:0000 88:0000
Jun 21 05:11:10 debian kernel: ata2: no dma
Jun 21 05:11:10 debian kernel: ata2: dev 1 not supported, ignoring
Jun 21 05:11:10 debian kernel: ata2: dev 0 configured for UDMA/100
Jun 21 05:11:10 debian kernel: ata3: SATA max UDMA/133 cmd 0xFE40 ctl 0xFE52 bmdma 0xFED0 irq 20
Jun 21 05:11:10 debian kernel: ata4: SATA max UDMA/133 cmd 0xFE60 ctl 0xFE72 bmdma 0xFED8 irq 20
Jun 21 05:11:10 debian kernel: ata3: SATA port has no device.
Jun 21 05:11:10 debian kernel: ata4: SATA port has no device.
Jun 21 05:11:10 debian kernel: scsi0 : ata_piix
Jun 21 05:11:10 debian kernel: scsi1 : ata_piix
Jun 21 05:11:10 debian kernel: scsi2 : ata_piix
Jun 21 05:11:10 debian kernel: scsi3 : ata_piix
Jun 21 05:11:10 debian kernel:   Vendor: ATA       Model: ST3808110AS       Rev: 3.AD
Jun 21 05:11:10 debian kernel:   Type:   Direct-Access                      ANSI SCSI revision: 05
Jun 21 05:11:10 debian kernel: Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
Jun 21 05:11:10 debian kernel: SCSI device sda: 156250000 512-byte hdwr sectors (80000 MB)
Jun 21 05:11:10 debian kernel: Partition check:
Jun 21 05:11:10 debian kernel:  sda: sda1 sda2 < sda5 >

I suppose the problem is "dev  1 not supported". From source, I see that
it is because, no DMA support was available.
With a 2.6.18, I get :

Jun 11 07:44:27 debian kernel: ata1.00: ATA-7, max UDMA/133, 156250000 sectors: LBA48 NCQ (depth 0/32)
Jun 11 07:44:27 debian kernel: ata1.00: ata1: dev 0 multi count 8
Jun 11 07:44:27 debian kernel: ata1.00: configured for UDMA/133
Jun 11 07:44:27 debian kernel:   Vendor: ATA       Model: ST3808110AS       Rev: 3.AD
Jun 11 07:44:27 debian kernel:   Type:   Direct-Access                      ANSI SCSI revision: 05
Jun 11 07:44:27 debian kernel: ata2: SATA max UDMA/133 cmd 0x170 ctl 0x376 bmdma 0xFEC8 irq 15
Jun 11 07:44:27 debian kernel: scsi1 : ata_piix
Jun 11 07:44:27 debian kernel: ata2.00: ATAPI, max UDMA/100
Jun 11 07:44:27 debian kernel: ata2.00: configured for UDMA/100
Jun 11 07:44:27 debian kernel:   Vendor: SONY      Model: CDRWDVD CRX310S   Rev: VDK2
Jun 11 07:44:27 debian kernel:   Type:   CD-ROM                             ANSI SCSI revision: 05
Jun 11 07:44:27 debian kernel: ata_piix 0000:00:1f.5: MAP [ P0 -- P1 -- ]

Of course, I have compiled CDROM support :
CONFIG_BLK_DEV_SR=y
# CONFIG_BLK_DEV_SR_VENDOR is not set

If I try AHCI driver instead (and add PCI ID into ahci.c), I get an oops
(libata-compat.h, line 141).

Now,  back  with   ata_piix,  it  seems  that  because   of  PIO  error,
all capabilities  are set to  0. In 2.6,  PIO error seems to  be handled
differently.

Any hint on how to fix this ?

Thanks.
-- 
Vincent Bernat
118 rue de Tocqueville, 75017 Paris
Tel: +33 1 53 42 12 86
http://www.wallix.com

--=-=-=--
