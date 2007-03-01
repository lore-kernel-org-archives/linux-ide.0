From: James Clark <jclark@metaparadigm.com>
Subject: Adaptec 1220SA (Sil3132) & sata_sil24 question
Date: Thu, 01 Mar 2007 12:23:28 +0800
Message-ID: <45E65540.6090308@metaparadigm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from moof.zeroth.org ([203.117.131.35]:59092 "EHLO moof.zeroth.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750709AbXCAE4N (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 28 Feb 2007 23:56:13 -0500
Received: from adele-en1.metaparadigm.com (localhost [[UNIX: localhost]])
	(authenticated bits=0)
	by moof.zeroth.org (8.13.8/8.13.8) with ESMTP id l214NSNh015615
	for <linux-ide@vger.kernel.org>; Thu, 1 Mar 2007 12:23:29 +0800 (SGT)
	(envelope-from jclark@metaparadigm.com)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

I have an Adaptec 1220SA which I originally thought was just a re-badged
Sil3132 design. Externally it appears that way (the stamp on the chip
reads 3132), however it identifies as a Silicon Image type 0x0242
according to lspci.  sata_sil24 does not attach.

I made the trivial addition to sata_sil24 device id table and it appears
to work. Performance is about the same as I get with the same drives on
the onboard sata_via (about 78MB/s sequential read, 72MB/s write) and
md mirror resyncing reflects this.

This is on a FC6 system (2.6.19-1.2911.fc6  SMP x86_64).
I compared with 2.6.20 sources and sata_sil24 seems to have some
cosmetic changes, but nothing that would help this it seems.

When the patched module loads I see a 'failed to IDENTIFY' and spurious
interrupt message. These do not seem to recur during use. Anything to
worry about?
I note that lspci reports a subvendor of Adaptec, type 0x242. Is it
correct to just patch (like below) where one vendor appears to have
'cloaked' a generic board?

---

04:00.0 RAID bus controller: Silicon Image, Inc. Unknown device 0242 
(rev 01) (prog-if 01)
	Subsystem: Adaptec Unknown device 0242
	Flags: bus master, fast devsel, latency 0, IRQ 32
	Memory at dc004000 (64-bit, non-prefetchable) [size=128]
	Memory at dc000000 (64-bit, non-prefetchable) [size=16K]
	I/O ports at 9000 [size=128]
	Expansion ROM at db000000 [disabled] [size=512K]
	Capabilities: [54] Power Management version 2
	Capabilities: [5c] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
	Capabilities: [70] Express Legacy Endpoint IRQ 0
	Capabilities: [100] Advanced Error Reporting

---

--- drivers/ata/sata_sil24.c.orig	2006-11-30 05:57:37.000000000 +0800
+++ drivers/ata/sata_sil24.c	2007-02-28 19:08:18.000000000 +0800
@@ -347,6 +347,7 @@
  	{ PCI_VDEVICE(CMD, 0x3124), BID_SIL3124 },
  	{ PCI_VDEVICE(INTEL, 0x3124), BID_SIL3124 },
  	{ PCI_VDEVICE(CMD, 0x3132), BID_SIL3132 },
+	{ PCI_VDEVICE(CMD, 0x0242), BID_SIL3132 },
  	{ PCI_VDEVICE(CMD, 0x3131), BID_SIL3131 },
  	{ PCI_VDEVICE(CMD, 0x3531), BID_SIL3131 },

---

sata_sil24 0000:04:00.0: version 0.3
ACPI: PCI Interrupt 0000:04:00.0[A] -> GSI 32 (level, low) -> IRQ 32
PCI: Setting latency timer of device 0000:04:00.0 to 64
ata3: SATA max UDMA/100 cmd 0xFFFFC20012378000 ctl 0x0 bmdma 0x0 irq 32
ata4: SATA max UDMA/100 cmd 0xFFFFC2001237A000 ctl 0x0 bmdma 0x0 irq 32
scsi2 : sata_sil24
ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata3.00: failed to IDENTIFY (INIT_DEV_PARAMS failed, err_mask=0x80)
ata3: spurious interrupt (slot_stat 0x0 active_tag -84148995 sactive 0x0)
ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata3.00: ATA-6, max UDMA/133, 390721968 sectors: LBA48
ata3.00: configured for UDMA/100
scsi3 : sata_sil24
ata4: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata4.00: failed to IDENTIFY (INIT_DEV_PARAMS failed, err_mask=0x80)
ata4: spurious interrupt (slot_stat 0x0 active_tag -84148995 sactive 0x0)
ata4: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata4.00: ATA-6, max UDMA/133, 390721968 sectors: LBA48
ata4.00: configured for UDMA/100
scsi 2:0:0:0: Direct-Access     ATA      ST3200822AS      3.01 PQ: 0 ANSI: 5
SCSI device sdc: 390721968 512-byte hdwr sectors (200050 MB)
sdc: Write Protect is off
sdc: Mode Sense: 00 3a 00 00
SCSI device sdc: drive cache: write back
SCSI device sdc: 390721968 512-byte hdwr sectors (200050 MB)
sdc: Write Protect is off
sdc: Mode Sense: 00 3a 00 00
SCSI device sdc: drive cache: write back
  sdc: sdc1 sdc2
sd 2:0:0:0: Attached scsi disk sdc
sd 2:0:0:0: Attached scsi generic sg2 type 0
scsi 3:0:0:0: Direct-Access     ATA      ST3200822AS      3.01 PQ: 0 ANSI: 5
SCSI device sdd: 390721968 512-byte hdwr sectors (200050 MB)
sdd: Write Protect is off
sdd: Mode Sense: 00 3a 00 00
SCSI device sdd: drive cache: write back
SCSI device sdd: 390721968 512-byte hdwr sectors (200050 MB)
sdd: Write Protect is off
sdd: Mode Sense: 00 3a 00 00
SCSI device sdd: drive cache: write back
  sdd: sdd1 sdd2
sd 3:0:0:0: Attached scsi disk sdd
sd 3:0:0:0: Attached scsi generic sg3 type 0

