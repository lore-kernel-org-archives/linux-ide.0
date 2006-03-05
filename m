From: "Stefan-W. Hahn" <stefan.hahn@s-hahn.de>
Subject: promise 300 tx4 does not recognize 4 drives
Date: Sun, 5 Mar 2006 22:45:47 +0100
Message-ID: <20060305214547.GC6949@scotty.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:24313 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1751835AbWCEVpu (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 5 Mar 2006 16:45:50 -0500
Received: from scotty.home (localhost [127.0.0.1])
	by scotty.home (8.13.4/8.13.4/Debian-3) with ESMTP id k25Ljlh5001520
	for <linux-ide@vger.kernel.org>; Sun, 5 Mar 2006 22:45:47 +0100
Received: (from hs@localhost)
	by scotty.home (8.13.4/8.13.4/Submit) id k25LjlxY001517
	for linux-ide@vger.kernel.org; Sun, 5 Mar 2006 22:45:47 +0100
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hello,

I have a strange problem and after googling the hole sunday without success, I
hope anybody on this list can help me.

Using an ASUS P5GD1 board with an onboard ICH6 controller a attached 

      1 HD at ide0 (PATA)
      1 CDROM at ide0 (PATA)

      4 HDs at ide1 (SATA)

I configured the IDE controller as AHCI, S-ATA mode.

Running on Linux 2.4.32 and 2.4.33-pre2 is ok.

Now I attached a PROMISE 300 TX4 (S-ATA) as PCI device with

    4 HDs attached.

When booting following happened:

1. The bios switched the internal controller to standard mode, so it recognizes
   just 2 of the 4 s-ata drives. (Why? I don't know.)

   The promise controller recognizes all 4 HDs.

   After loading ata_piix and sata_promise I get 2 drives from the internal
   controller and 4 from the promise controller.


2. After switching the bios back to AHCI mode it recognizes correct the 4
   internal s-ata drives.

   But now the promise controller just recognizes 2 of the 4 attached drives and
   that drives me crazy.

   How can I get the 4 drives in this situation working? Any advice?


lspci says:
0000:00:00.0 Host bridge: Intel Corp. 915G/P/GV Processor to I/O Controller (rev 04)
0000:00:01.0 PCI bridge: Intel Corp. 915G/P/GV PCI Express Root Port (rev 04)
0000:00:1b.0 0403: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6 Family) High Definition Audio Controller (rev 03)
0000:00:1c.0 PCI bridge: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6 Family) PCI Express Port 1 (rev 03)
0000:00:1c.1 PCI bridge: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6 Family) PCI Express Port 2 (rev 03)
0000:00:1d.0 USB Controller: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #1 (rev 03)
0000:00:1d.1 USB Controller: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #2 (rev 03)
0000:00:1d.2 USB Controller: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #3 (rev 03)
0000:00:1d.3 USB Controller: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #4 (rev 03)
0000:00:1d.7 USB Controller: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB2 EHCI Controller (rev 03)
0000:00:1e.0 PCI bridge: Intel Corp. 82801 PCI Bridge (rev d3)
0000:00:1f.0 ISA bridge: Intel Corp. 82801FB/FR (ICH6/ICH6R) LPC Interface Bridge (rev 03)
0000:00:1f.1 IDE interface: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6 Family) IDE Controller (rev 03)
0000:00:1f.2 0106: Intel Corp. 82801FR/FRW (ICH6R/ICH6RW) SATA Controller (rev 03)
0000:00:1f.3 SMBus: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6 Family) SMBus Controller (rev 03)
0000:01:09.0 Network controller: AVM Audiovisuelles MKTG & Computer System GmbH A1 ISDN [Fritz] (rev 02)
0000:01:0a.0 Unknown mass storage controller: Promise Technology, Inc.: Unknown device 3d17 (rev 02)
0000:02:00.0 Ethernet controller: Marvell Technology Group Ltd.: Unknown device 4362 (rev 19)
0000:04:00.0 VGA compatible controller: nVidia Corporation: Unknown device 0161 (rev a1)

For situation 1 syslog says while loading sata_promise:

Mar  5 12:58:12 waldorf kernel: PCI(01:0a.0): version 1.03
Mar  5 12:58:12 waldorf kernel: ata3: SATA max UDMA/133 cmd 0xE09FF200 ctl 0xE09FF238 bmdma 0x0 irq 5
Mar  5 12:58:12 waldorf kernel: ata4: SATA max UDMA/133 cmd 0xE09FF280 ctl 0xE09FF2B8 bmdma 0x0 irq 5
Mar  5 12:58:12 waldorf kernel: ata5: SATA max UDMA/133 cmd 0xE09FF300 ctl 0xE09FF338 bmdma 0x0 irq 5
Mar  5 12:58:12 waldorf kernel: ata6: SATA max UDMA/133 cmd 0xE09FF380 ctl 0xE09FF3B8 bmdma 0x0 irq 5
Mar  5 12:58:13 waldorf kernel: ata3: dev 0 cfg 49:2f00 82:746b 83:7f01 84:4023 85:7469 86:3c01 87:4023 88:407f
Mar  5 12:58:13 waldorf kernel: ata3: dev 0 ATA-7, max UDMA/133, 390721968 sectors: LBA48
Mar  5 12:58:13 waldorf kernel: ata3: dev 0 configured for UDMA/133
Mar  5 12:58:13 waldorf kernel: ata4: dev 0 cfg 49:2f00 82:746b 83:7f01 84:4023 85:7469 86:3c01 87:4023 88:407f
Mar  5 12:58:13 waldorf kernel: ata4: dev 0 ATA-7, max UDMA/133, 390721968 sectors: LBA48
Mar  5 12:58:13 waldorf kernel: ata4: dev 0 configured for UDMA/133
Mar  5 12:58:13 waldorf kernel: ata5: dev 0 cfg 49:2f00 82:746b 83:7f01 84:4023 85:7469 86:3c01 87:4023 88:407f
Mar  5 12:58:13 waldorf kernel: ata5: dev 0 ATA-7, max UDMA/133, 390721968 sectors: LBA48
Mar  5 12:58:13 waldorf kernel: ata5: dev 0 configured for UDMA/133
Mar  5 12:58:14 waldorf kernel: ata6: dev 0 cfg 49:2f00 82:746b 83:7f01 84:4023 85:7469 86:3c01 87:4023 88:407f
Mar  5 12:58:14 waldorf kernel: ata6: dev 0 ATA-7, max UDMA/133, 390721968 sectors: LBA48
Mar  5 12:58:14 waldorf kernel: ata6: dev 0 configured for UDMA/133
Mar  5 12:58:14 waldorf kernel: scsi3 : sata_promise
Mar  5 12:58:14 waldorf kernel: scsi4 : sata_promise
Mar  5 12:58:14 waldorf kernel: scsi5 : sata_promise
Mar  5 12:58:14 waldorf kernel: scsi6 : sata_promise
Mar  5 12:58:14 waldorf kernel:   Vendor: ATA       Model: WDC WD2000JS-00M  Rev: 02.0
Mar  5 12:58:14 waldorf kernel:   Type:   Direct-Access                      ANSI SCSI revision: 05
Mar  5 12:58:14 waldorf kernel:   Vendor: ATA       Model: WDC WD2000JS-00M  Rev: 02.0
Mar  5 12:58:14 waldorf kernel:   Type:   Direct-Access                      ANSI SCSI revision: 05
Mar  5 12:58:14 waldorf kernel:   Vendor: ATA       Model: WDC WD2000JS-00M  Rev: 02.0
Mar  5 12:58:14 waldorf kernel:   Type:   Direct-Access                      ANSI SCSI revision: 05
Mar  5 12:58:14 waldorf kernel:   Vendor: ATA       Model: WDC WD2000JS-00M  Rev: 02.0
Mar  5 12:58:14 waldorf kernel:   Type:   Direct-Access                      ANSI SCSI revision: 05
Mar  5 12:58:14 waldorf kernel: Attached scsi disk sdc at scsi3, channel 0, id 0, lun 0
Mar  5 12:58:14 waldorf kernel: Attached scsi disk sdd at scsi4, channel 0, id 0, lun 0
Mar  5 12:58:14 waldorf kernel: Attached scsi disk sde at scsi5, channel 0, id 0, lun 0
Mar  5 12:58:14 waldorf kernel: Attached scsi disk sdf at scsi6, channel 0, id 0, lun 0
Mar  5 12:58:14 waldorf kernel: SCSI device sdc: 390721968 512-byte hdwr sectors (200050 MB)
Mar  5 12:58:14 waldorf kernel:  sdc: unknown partition table
Mar  5 12:58:14 waldorf kernel: SCSI device sdd: 390721968 512-byte hdwr sectors (200050 MB)
Mar  5 12:58:14 waldorf kernel:  sdd: unknown partition table
Mar  5 12:58:14 waldorf kernel: SCSI device sde: 390721968 512-byte hdwr sectors (200050 MB)
Mar  5 12:58:14 waldorf kernel:  sde: unknown partition table
Mar  5 12:58:14 waldorf kernel: SCSI device sdf: 390721968 512-byte hdwr sectors (200050 MB)
Mar  5 12:58:14 waldorf kernel:  sdf: sdf1


For situation 2 syslog says while loading sata_promise:

Mar  5 17:44:22 waldorf kernel: PCI(01:0a.0): version 1.03
Mar  5 17:44:22 waldorf kernel: ata7: SATA max UDMA/133 cmd 0xE09F9200 ctl 0xE09F9238 bmdma 0x0 irq 5
Mar  5 17:44:22 waldorf kernel: ata8: SATA max UDMA/133 cmd 0xE09F9280 ctl 0xE09F92B8 bmdma 0x0 irq 5
Mar  5 17:44:22 waldorf kernel: ata9: SATA max UDMA/133 cmd 0xE09F9300 ctl 0xE09F9338 bmdma 0x0 irq 5
Mar  5 17:44:22 waldorf kernel: ata10: SATA max UDMA/133 cmd 0xE09F9380 ctl 0xE09F93B8 bmdma 0x0 irq 5
Mar  5 17:44:22 waldorf kernel: ata7: no device found (phy stat 00000000)
Mar  5 17:44:22 waldorf kernel: ata8: dev 0 cfg 49:2f00 82:746b 83:7f01 84:4023 85:7469 86:3c01 87:4023 88:407f
Mar  5 17:44:22 waldorf kernel: ata8: dev 0 ATA-7, max UDMA/133, 390721968 sectors: LBA48
Mar  5 17:44:22 waldorf kernel: ata8: dev 0 configured for UDMA/133
Mar  5 17:44:23 waldorf kernel: ata9: dev 0 cfg 49:2f00 82:746b 83:7f01 84:4023 85:7469 86:3c01 87:4023 88:407f
Mar  5 17:44:23 waldorf kernel: ata9: dev 0 ATA-7, max UDMA/133, 390721968 sectors: LBA48
Mar  5 17:44:23 waldorf kernel: ata9: dev 0 configured for UDMA/133
Mar  5 17:44:23 waldorf kernel: ata10: no device found (phy stat 00000000)
Mar  5 17:44:23 waldorf kernel: scsi4 : sata_promise
Mar  5 17:44:23 waldorf kernel: scsi5 : sata_promise
Mar  5 17:44:23 waldorf kernel: scsi6 : sata_promise
Mar  5 17:44:23 waldorf kernel: scsi7 : sata_promise
Mar  5 17:44:23 waldorf kernel:   Vendor: ATA       Model: WDC WD2000JS-00M  Rev: 02.0
Mar  5 17:44:23 waldorf kernel:   Type:   Direct-Access                      ANSI SCSI revision: 05
Mar  5 17:44:23 waldorf kernel:   Vendor: ATA       Model: WDC WD2000JS-00M  Rev: 02.0
Mar  5 17:44:23 waldorf kernel:   Type:   Direct-Access                      ANSI SCSI revision: 05
Mar  5 17:44:23 waldorf kernel: Attached scsi disk sde at scsi5, channel 0, id 0, lun 0
Mar  5 17:44:23 waldorf kernel: Attached scsi disk sdf at scsi6, channel 0, id 0, lun 0
Mar  5 17:44:23 waldorf kernel: SCSI device sde: 390721968 512-byte hdwr sectors (200050 MB)
Mar  5 17:44:23 waldorf kernel:  sde: unknown partition table
Mar  5 17:44:23 waldorf kernel: SCSI device sdf: 390721968 512-byte hdwr sectors (200050 MB)
Mar  5 17:44:23 waldorf kernel:  sdf: unknown partition table



Thanks,
Stefan
-- 
Stefan-W. Hahn                          It is easy to make things.
/ mailto:stefan.hahn@s-hahn.de /        It is hard to make things simple.			

