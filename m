From: Eric Wong <normalperson@yhbt.net>
Subject: Success(?) with SiI + Seagate pessimistic fix disabled.
Date: Thu, 8 Jan 2004 21:48:01 -0800
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20040109054800.GA32112@Mayonaise>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from user-0c8gj4g.cable.mindspring.com ([24.136.76.144]:48001 "EHLO
	localhost") by vger.kernel.org with ESMTP id S266277AbUAIFsF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 9 Jan 2004 00:48:05 -0500
Received: from normalperson by localhost with local (Exim 3.36 #1 (Debian))
	id 1AepV7-000076-00
	for <linux-ide@vger.kernel.org>; Thu, 08 Jan 2004 21:48:05 -0800
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi, I got a generic SiI card at the computer fair over the weekend and a
pair of Seagate drives (not RAIDed in any way).  Disappointed by the
performance with the pessimistic errata fix, I took a chance and
commented it out... my computer is still running and the drives are a
lot faster :)

I have nothing important on the drives yet, but I'm copying data back
and forth between them (reiserfs 3.6) to test it.  MD5 checks don't show
any problems, either.  Let me know if you have any other ideas to test
(and try to break) my setup.

kernel: 2.6.1-rc3

lspci:
00:0e.0 RAID bus controller: CMD Technology Inc Silicon Image SiI 3112 SATARaid Controller (rev 02)
	Subsystem: CMD Technology Inc: Unknown device 6112
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at b000 [size=8]
	Region 1: I/O ports at a800 [size=4]
	Region 2: I/O ports at a400 [size=8]
	Region 3: I/O ports at a000 [size=4]
	Region 4: I/O ports at 9800 [size=16]
	Region 5: Memory at de800000 (32-bit, non-prefetchable) [size=512]
	Expansion ROM at <unassigned> [disabled] [size=512K]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=2 PME-


dmesg:
ata1: SATA max UDMA/133 cmd 0xF8933080 ctl 0xF893308A bmdma 0xF8933000 irq 10
ata2: SATA max UDMA/133 cmd 0xF89330C0 ctl 0xF89330CA bmdma 0xF8933008 irq 10
ata1: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4003 85:3469 86:3c01 87:4003 88:207f
ata1: dev 0 ATA, max UDMA/133, 312581808 sectors (lba48)
ata1: dev 0 configured for UDMA/133
scsi0 : ata_sil
ata2: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4003 85:3469 86:3c01 87:4003 88:207f
ata2: dev 0 ATA, max UDMA/133, 312581808 sectors (lba48)
ata2: dev 0 configured for UDMA/133
scsi1 : ata_sil
  Vendor: ATA       Model: ST3160023AS       Rev: 0.81
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 312581808 512-byte hdwr sectors (160042 MB)
SCSI device sda: drive cache: write through
 sda: sda1
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
  Vendor: ATA       Model: ST3160023AS       Rev: 0.81
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sdb: 312581808 512-byte hdwr sectors (160042 MB)

-- 
Eric Wong
