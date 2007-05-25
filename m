From: Vasily Averin <vvs@sw.ru>
Subject: VIA VT6420: SATA disconnects
Date: Fri, 25 May 2007 11:41:53 +0400
Message-ID: <46569341.4020801@sw.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=KOI8-R
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailhub.sw.ru ([195.214.233.200]:1447 "EHLO relay.sw.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750769AbXEYHmJ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 25 May 2007 03:42:09 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org
Cc: j.e.van.grootheest@caiway.nl, devel@openvz.org

Jeff, Tejun,

Our RHEL5-based OpenVZ linux kernel reports about SATA-related issues:
VIA VT6420 SATA RAID Controller on MSI motherboard, x86_64 kernel based on latest RHEL5 kernel,
On booting hardware initialized properly and all works fine some time, but then it detects timeout and disables devices. We have replaced SATA cables, but issue didn't go away and still present.

I've googled and found similair bugreport in linux-ide@
http://www.mail-archive.com/linux-ide@vger.kernel.org/msg06011.html

Are you know something about this issue? I've seen that you have fixed SATA reset procedure recently, probably this issue was fixed already?

thank you,
	Vasily Averin

OpenVZ/Virtuozzo Linux kernel Team

May 24 09:39:39 ts28 SCSI subsystem initialized
May 24 09:39:39 ts28 libata version 2.00 loaded.
May 24 09:39:39 ts28 sata_via 0000:00:0f.0: version 2.0
May 24 09:39:39 ts28 ACPI: PCI Interrupt 0000:00:0f.0[B] -> Link [ALKA] -> GSI 20 (level, low) -> IRQ 169
May 24 09:39:39 ts28 sata_via 0000:00:0f.0: routed to hard irq line 11
May 24 09:39:39 ts28 ata1: SATA max UDMA/133 cmd 0xC000 ctl 0xC402 bmdma 0xD000 irq 169
May 24 09:39:39 ts28 ata2: SATA max UDMA/133 cmd 0xC800 ctl 0xCC02 bmdma 0xD008 irq 169
May 24 09:39:39 ts28 scsi0 : sata_via
May 24 09:39:39 ts28 ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
May 24 09:39:40 ts28 ata1.00: ATA-7, max UDMA/133, 156301488 sectors: LBA48 NCQ (depth 0/32)
May 24 09:39:40 ts28
May 24 09:39:40 ts28 ata1.00: ata1: dev 0 multi count 16
May 24 09:39:40 ts28 ata1.00: configured for UDMA/133
May 24 09:39:40 ts28 scsi1 : sata_via
May 24 09:39:40 ts28 ata2: SATA link down 1.5 Gbps (SStatus 0 SControl 300)
May 24 09:39:40 ts28 ATA: abnormal status 0x7F on port 0xC807
May 24 09:39:40 ts28   Vendor: ATA       Model: ST380811AS        Rev: 3.AA
May 24 09:39:40 ts28   Type:   Direct-Access                      ANSI SCSI revision: 05
May 24 09:39:40 ts28 SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
May 24 09:39:40 ts28 sda: Write Protect is off
May 24 09:39:40 ts28 sda: Mode Sense: 00 3a 00 00
May 24 09:39:40 ts28 SCSI device sda: drive cache: write back
May 24 09:39:40 ts28 SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
May 24 09:39:40 ts28 sda: Write Protect is off
May 24 09:39:40 ts28 sda: Mode Sense: 00 3a 00 00
May 24 09:39:40 ts28
May 24 09:39:40 ts28 SCSI device sda: drive cache: write back
May 24 09:39:40 ts28  sda: sda1 sda2 sda3 sda4 < sda5 >
May 24 09:39:40 ts28 sd 0:0:0:0: Attached scsi disk sda
May 24 09:39:43 ts28 kjournald starting.  Commit interval 5 seconds
May 24 09:39:43 ts28 EXT3-fs: mounted filesystem with ordered data mode.
May 24 09:53:15 ts28 ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
May 24 09:53:15 ts28 ata1.00: (BMDMA stat 0x4)
May 24 09:53:15 ts28 ata1.00: tag 0 cmd 0xca Emask 0x4 stat 0x40 err 0x0 (timeout)
May 24 09:53:46 ts28 ata1.00: qc timeout (cmd 0xec)
May 24 09:53:46 ts28 ata1.00: failed to IDENTIFY (I/O error, err_mask=0x4)
May 24 09:53:46 ts28 ata1.00: revalidation failed (errno=-5)
May 24 09:53:46 ts28 ata1: failed to recover some devices, retrying in 5 secs
May 24 09:54:23 ts28 ata1.00: qc timeout (cmd 0xec)
May 24 09:54:23 ts28 ata1.00: failed to IDENTIFY (I/O error, err_mask=0x4)
May 24 09:54:23 ts28 ata1.00: revalidation failed (errno=-5)
May 24 09:54:23 ts28 ata1: failed to recover some devices, retrying in 5 secs
May 24 09:54:59 ts28 ata1.00: qc timeout (cmd 0xec)
May 24 09:54:59 ts28 ata1.00: failed to IDENTIFY (I/O error, err_mask=0x4)
May 24 09:54:59 ts28 ata1.00: revalidation failed (errno=-5)
May 24 09:54:59 ts28 ata1.00: disabled


Linux ts28 2.6.18-028stab031.1 #1 SMP Fri Apr 27 18:39:46 MSD 2007 x86_64 x86_64 x86_64 GNU/Linux

00:0f.0 RAID bus controller: VIA Technologies, Inc. VIA VT6420 SATA RAID Controller (rev 80)
        Subsystem: Micro-Star International Co., Ltd. Unknown device 1300
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Interrupt: pin B routed to IRQ 169
        Region 0: I/O ports at c000 [size=8]
        Region 1: I/O ports at c400 [size=4]
        Region 2: I/O ports at c800 [size=8]
        Region 3: I/O ports at cc00 [size=4]
        Region 4: I/O ports at d000 [size=16]
        Region 5: I/O ports at d400 [size=256]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 06 11 49 31 07 00 90 02 80 00 04 01 00 20 80 00
10: 01 c0 00 00 01 c4 00 00 01 c8 00 00 01 cc 00 00
20: 01 d0 00 00 01 d4 00 00 00 00 00 00 62 14 00 13
30: 00 00 00 00 c0 00 00 00 00 00 00 00 0b 02 00 00
40: 33 03 f1 44 06 af 00 00 10 82 65 03 00 00 00 00
50: 00 00 00 00 00 00 04 04 00 10 10 00 05 00 20 00
60: 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 01 00 01 10 10 00 00 00
80: 00 00 00 00 00 00 00 00 00 30 c6 de 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 01 00 02 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 80 02 49 31 62 14 00 13 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
