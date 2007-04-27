From: Jan Evert van Grootheest <j.e.van.grootheest@caiway.nl>
Subject: SATA disconnects
Date: Fri, 27 Apr 2007 18:58:23 +0200
Message-ID: <46322BAF.20306@caiway.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cardassian.kabelfoon.nl ([62.45.45.18]:60459 "EHLO
	cardassian.kabelfoon.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756778AbXD0RTn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 27 Apr 2007 13:19:43 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: debain-kernel@lists.debian.org, htejun@gmail.com, linux-ide@vger.kernel.org

Hi,

I have this AMD64 based machine that regularly (about once per 1.5 days) 
has problems with one of its SATA disks. It runs the 64 bit Etch 
(2.6.18-4-xen-amd64).
Unfortunately all those values in the ata logs don't mean much to me and 
I don't know where to go look for their meaning.
Any explanation of what those codes mean is greatly appreciated!

The disk is connected to a VIA controller:
00:0f.0 RAID bus controller [0104]: VIA Technologies, Inc. VIA VT6420 
SATA RAID Controller [1106:3149] (rev 80)

sata_via 0000:00:0f.0: version 2.0
GSI 18 sharing vector 0xB0 and IRQ 18
ACPI: PCI Interrupt 0000:00:0f.0[B] -> GSI 20 (level, low) -> IRQ 18
sata_via 0000:00:0f.0: routed to hard irq line 10
ata3: SATA max UDMA/133 cmd 0xD000 ctl 0xCC02 bmdma 0xC000 irq 18
ata4: SATA max UDMA/133 cmd 0xC800 ctl 0xC402 bmdma 0xC008 irq 18
scsi2 : sata_via
ata3: SATA link down 1.5 Gbps (SStatus 0 SControl 300)
ATA: abnormal status 0x7F on port 0xD007
scsi3 : sata_via
ata4: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata4.00: ATA-7, max UDMA/133, 160086528 sectors: LBA
ata4.00: ata4: dev 0 multi count 16
ata4.00: configured for UDMA/133
  Vendor: ATA       Model: Maxtor 6Y080M0    Rev: YAR5
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sdb: 160086528 512-byte hdwr sectors (81964 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
SCSI device sdb: 160086528 512-byte hdwr sectors (81964 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
 sdb: sdb2 < sdb5 sdb6 >
sd 3:0:0:0: Attached scsi disk sdb

This is what's in syslog:
Apr 27 11:31:45 quark kernel: ata4.00: exception Emask 0x0 SAct 0x0 SErr 
0x0 action 0x2 frozen
Apr 27 11:31:45 quark kernel: ata4.00: (BMDMA stat 0x1)
Apr 27 11:31:45 quark kernel: ata4.00: tag 0 cmd 0xca Emask 0x4 stat 
0x40 err 0x0 (timeout)
Apr 27 11:31:46 quark kernel: ata4: SATA link up 1.5 Gbps (SStatus 113 
SControl 300)
Apr 27 11:31:53 quark kernel: ata4: port is slow to respond, please be 
patient
Apr 27 11:32:16 quark kernel: ata4: port failed to respond (30 secs)
Apr 27 11:32:16 quark kernel: ata4: soft resetting port
Apr 27 11:32:16 quark kernel: ATA: abnormal status 0xD0 on port 0xC807
Apr 27 11:32:16 quark last message repeated 5 times
Apr 27 11:32:46 quark kernel: ata4.00: qc timeout (cmd 0xec)
Apr 27 11:32:46 quark kernel: ata4.00: failed to IDENTIFY (I/O error, 
err_mask=0x4)
Apr 27 11:32:46 quark kernel: ata4.00: revalidation failed (errno=-5)
Apr 27 11:32:46 quark kernel: ata4: failed to recover some devices, 
retrying in 5 secs
Apr 27 11:32:52 quark kernel: ata4: SATA link up 1.5 Gbps (SStatus 113 
SControl 300)
Apr 27 11:32:59 quark kernel: ata4: port is slow to respond, please be 
patient
Apr 27 11:33:22 quark kernel: ata4: port failed to respond (30 secs)
Apr 27 11:33:22 quark kernel: ata4: soft resetting port
Apr 27 11:33:22 quark kernel: ATA: abnormal status 0xD0 on port 0xC807
Apr 27 11:33:22 quark last message repeated 5 times
Apr 27 11:33:52 quark kernel: ata4.00: qc timeout (cmd 0xec)
Apr 27 11:33:52 quark kernel: ata4.00: failed to IDENTIFY (I/O error, 
err_mask=0x4)
Apr 27 11:33:52 quark kernel: ata4.00: revalidation failed (errno=-5)
Apr 27 11:33:52 quark kernel: ata4: failed to recover some devices, 
retrying in 5 secs
Apr 27 11:33:57 quark kernel: ata4: SATA link up 1.5 Gbps (SStatus 113 
SControl 300)
Apr 27 11:34:04 quark kernel: ata4: port is slow to respond, please be 
patient
Apr 27 11:34:27 quark kernel: ata4: port failed to respond (30 secs)
Apr 27 11:34:27 quark kernel: ata4: soft resetting port
Apr 27 11:34:27 quark kernel: ATA: abnormal status 0xD0 on port 0xC807
Apr 27 11:34:27 quark last message repeated 5 times
Apr 27 11:34:57 quark kernel: ata4.00: qc timeout (cmd 0xec)
Apr 27 11:34:57 quark kernel: ata4.00: failed to IDENTIFY (I/O error, 
err_mask=0x4)
Apr 27 11:34:57 quark kernel: ata4.00: revalidation failed (errno=-5)
Apr 27 11:34:57 quark kernel: ata4.00: disabled
Apr 27 11:34:58 quark kernel: ata4: EH complete
Apr 27 11:34:58 quark kernel: sd 3:0:0:0: SCSI error: return code = 
0x00040000
Apr 27 11:34:58 quark kernel: end_request: I/O error, dev sdb, sector 
138101809
Apr 27 11:34:58 quark kernel: sd 3:0:0:0: SCSI error: return code = 
0x00040000
Apr 27 11:34:58 quark kernel: end_request: I/O error, dev sdb, sector 
138101821

The last two lines keep repeating for different sectors.

Smartctl does not appear to have anything in its logs.

Interesting thing is that the disk reappears and operates normally after 
'echo 1 > /sys/class/pci_bus/0000:0f.0/host3/rescan'.
Unfortunately, LVM won't reconnect to it.

This machine is running Xen in 1.5G with two guests. The failing disk 
provides storage via LVM to one of those.

I can have this machine running like this another week or so.

Any help is greatly appreciated!
Thanks,
Jan Evert

