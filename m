From: Marc Bejarano <beej@alum.mit.edu>
Subject: errors on shutdown with PMP
Date: Fri, 27 Jul 2007 17:53:11 -0400
Message-ID: <200707272153.l6RLrE5r007622@outgoing-alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ALUM-2.MIT.EDU ([18.7.21.145]:36409 "EHLO alum-2.mit.edu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1765377AbXG0V74 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 27 Jul 2007 17:59:56 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

hi, tejun.  i've been using your libata-tj-2.6.22-rc6-20070702 kernel 
on a centos 4 machine for a while with some 3124's and 3726's.  up 
until today, i hadn't seen any issues.

while trying to shut the machine down, this happened:
===
Jul 27 14:58:44 dell shutdown: shutting down for system halt
Jul 27 14:59:15 dell kernel: ata8.00: exception Emask 0x0 SAct 0x1 
SErr 0x0 action 0x2 frozen
Jul 27 14:59:15 dell kernel: ata8.00: cmd 
61/10:00:a7:0a:00/00:00:00:00:00/40 tag 0 cdb 0x0 data 8192 out
Jul 27 14:59:15 dell kernel:          res 
40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
Jul 27 14:59:15 dell kernel: ata8.15: hard resetting link
Jul 27 14:59:17 dell kernel: ata8.15: SATA link up 3.0 Gbps (SStatus 
123 SControl 0)
Jul 27 14:59:17 dell kernel: ata8.00: hard resetting link
Jul 27 14:59:27 dell kernel: ata8.00: softreset failed (timeout)
Jul 27 14:59:27 dell kernel: ata8.00: hard resetting link
Jul 27 14:59:28 dell kernel: ata8.00: COMRESET failed (errno=-5)
Jul 27 14:59:28 dell kernel: ata8.00: reset failed, giving up
Jul 27 14:59:28 dell kernel: ata8.15: hard resetting link
Jul 27 14:59:38 dell kernel: ata8.15: softreset failed (timeout)
Jul 27 14:59:38 dell kernel: ata8.15: hard resetting link
Jul 27 14:59:40 dell kernel: ata8.15: SATA link up 3.0 Gbps (SStatus 
123 SControl 0)
Jul 27 14:59:40 dell kernel: ata8.00: hard resetting link
Jul 27 14:59:50 dell kernel: ata8.00: softreset failed (timeout)
Jul 27 14:59:50 dell kernel: ata8.00: hard resetting link
Jul 27 14:59:51 dell kernel: ata8.00: COMRESET failed (errno=-5)
Jul 27 14:59:51 dell kernel: ata8.00: reset failed, giving up
Jul 27 14:59:51 dell kernel: ata8.15: hard resetting link
Jul 27 15:00:01 dell kernel: ata8.15: softreset failed (timeout)
Jul 27 15:00:01 dell kernel: ata8.15: hard resetting link
Jul 27 15:00:03 dell kernel: ata8.15: SATA link up 3.0 Gbps (SStatus 
123 SControl 0)
Jul 27 15:00:03 dell kernel: ata8.00: hard resetting link
Jul 27 15:00:13 dell kernel: ata8.00: softreset failed (timeout)
Jul 27 15:00:13 dell kernel: ata8.00: hard resetting link
Jul 27 15:00:14 dell kernel: ata8.00: COMRESET failed (errno=-5)
Jul 27 15:00:14 dell kernel: ata8.00: reset failed, giving up
Jul 27 15:00:14 dell kernel: ata8.00: failed to recover link after 3 
tries, disabling
Jul 27 15:00:14 dell kernel: ata8.00: disabled
Jul 27 15:00:14 dell kernel: ata8: failed to recover PMP, retrying in 5 secs
Jul 27 15:00:19 dell kernel: ata8.15: hard resetting link
Jul 27 15:00:29 dell kernel: ata8.15: softreset failed (timeout)
Jul 27 15:00:29 dell kernel: ata8.15: hard resetting link
Jul 27 15:00:32 dell kernel: ata8.15: SATA link up 3.0 Gbps (SStatus 
123 SControl 0)
Jul 27 15:00:32 dell kernel: ata8.01: hard resetting link
Jul 27 15:00:33 dell kernel: ata8.01: SATA link up 3.0 Gbps (SStatus 
123 SControl 300)
Jul 27 15:00:33 dell kernel: ata8.02: hard resetting link
Jul 27 15:00:33 dell kernel: ata8.02: SATA link up 3.0 Gbps (SStatus 
123 SControl 300)
Jul 27 15:00:33 dell kernel: ata8.03: hard resetting link
Jul 27 15:00:34 dell kernel: ata8.03: SATA link up 1.5 Gbps (SStatus 
113 SControl 300)
Jul 27 15:00:34 dell kernel: ata8.04: hard resetting link
Jul 27 15:00:35 dell kernel: ata8.04: SATA link down (SStatus 0 SControl 300)
Jul 27 15:00:35 dell kernel: ata8.05: hard resetting link
Jul 27 15:00:35 dell kernel: ata8.05: SATA link up 1.5 Gbps (SStatus 
113 SControl 300)
Jul 27 15:00:35 dell kernel: ata8.01: configured for UDMA/100
Jul 27 15:00:35 dell kernel: ata8.02: configured for UDMA/100
Jul 27 15:00:35 dell kernel: ata8.03: configured for UDMA/100
Jul 27 15:00:35 dell kernel: sd 7:0:0:0: [sdc] Result: 
hostbyte=DID_OK driverbyte=DRIVER_SENSE,SUGGEST_OK
Jul 27 15:00:35 dell kernel: sd 7:0:0:0: [sdc] Sense Key : Aborted 
Command [current] [descriptor]
Jul 27 15:00:35 dell kernel: Descriptor sense data with sense 
descriptors (in hex):
Jul 27 15:00:35 dell kernel:         72 0b 00 00 00 00 00 0c 00 0a 80 
00 00 00 00 00
Jul 27 15:00:35 dell kernel:         00 00 00 00
Jul 27 15:00:35 dell kernel: sd 7:0:0:0: [sdc] Add. Sense: No 
additional sense information
Jul 27 15:00:35 dell kernel: end_request: I/O error, dev sdc, sector 2727
Jul 27 15:00:35 dell kernel: ata8: EH complete
Jul 27 15:00:35 dell kernel: sd 7:0:0:0: rejecting I/O to offline device
Jul 27 15:00:35 dell kernel: Buffer I/O error on device dm-4, logical 
block 1055
Jul 27 15:00:35 dell kernel: lost page write due to I/O error on dm-4
Jul 27 15:00:35 dell kernel: Aborting journal on device dm-4.
Jul 27 15:00:35 dell kernel: journal commit I/O error
Jul 27 15:00:36 dell kernel: sd 7:0:1:0: [sdd] 488397168 512-byte 
hardware sectors (250059 MB)
Jul 27 15:00:36 dell kernel: sd 7:0:1:0: [sdd] Write Protect is off
Jul 27 15:00:36 dell kernel: sd 7:0:1:0: [sdd] Write cache: enabled, 
read cache: enabled, doesn't support DPO or FUA
Jul 27 15:00:36 dell kernel: sd 7:0:2:0: [sde] 488397168 512-byte 
hardware sectors (250059 MB)
Jul 27 15:00:36 dell kernel: sd 7:0:2:0: [sde] Write Protect is off
Jul 27 15:00:36 dell kernel: sd 7:0:2:0: [sde] Write cache: enabled, 
read cache: enabled, doesn't support DPO or FUA
Jul 27 15:00:36 dell kernel: sd 7:0:3:0: [sdf] 488397168 512-byte 
hardware sectors (250059 MB)
Jul 27 15:00:36 dell kernel: sd 7:0:3:0: [sdf] Write Protect is off
Jul 27 15:00:36 dell kernel: sd 7:0:3:0: [sdf] Write cache: enabled, 
read cache: enabled, doesn't support DPO or FUA
Jul 27 15:00:36 dell kernel: sd 7:0:1:0: [sdd] 488397168 512-byte 
hardware sectors (250059 MB)
Jul 27 15:00:36 dell kernel: sd 7:0:1:0: [sdd] Write Protect is off
Jul 27 15:00:36 dell kernel: sd 7:0:1:0: [sdd] Write cache: enabled, 
read cache: enabled, doesn't support DPO or FUA
Jul 27 15:00:36 dell kernel: sd 7:0:2:0: [sde] 488397168 512-byte 
hardware sectors (250059 MB)
Jul 27 15:00:36 dell kernel: sd 7:0:2:0: [sde] Write Protect is off
Jul 27 15:00:36 dell kernel: sd 7:0:2:0: [sde] Write cache: enabled, 
read cache: enabled, doesn't support DPO or FUA
Jul 27 15:00:36 dell kernel: sd 7:0:3:0: [sdf] 488397168 512-byte 
hardware sectors (250059 MB)
Jul 27 15:00:36 dell kernel: sd 7:0:3:0: [sdf] Write Protect is off
Jul 27 15:00:36 dell kernel: sd 7:0:3:0: [sdf] Write cache: enabled, 
read cache: enabled, doesn't support DPO or FUA
Jul 27 15:00:36 dell kernel: ata8.00: detaching (SCSI 7:0:0:0)
Jul 27 15:00:36 dell kernel: sd 7:0:0:0: [sdc] Synchronizing SCSI cache
Jul 27 15:00:36 dell kernel: sd 7:0:0:0: [sdc] Result: 
hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK,SUGGEST_OK
Jul 27 15:00:36 dell kernel: sd 7:0:0:0: [sdc] Stopping disk
Jul 27 15:00:36 dell kernel: sd 7:0:0:0: [sdc] START_STOP FAILED
Jul 27 15:00:36 dell kernel: sd 7:0:0:0: [sdc] Result: 
hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK,SUGGEST_OK
Jul 27 15:00:36 dell init: Switching to runlevel: 0
===

here are the devices being detected on the next reboot (which 
required an fsck):
===
Jul 27 15:18:56 dell kernel: SCSI subsystem initialized
Jul 27 15:18:56 dell kernel: ata_piix 0000:00:1f.2: MAP [ P0 P2 P1 P3 ]
Jul 27 15:18:56 dell kernel: ACPI: PCI Interrupt 0000:00:1f.2[C] -> 
GSI 20 (level, low) -> IRQ 20
Jul 27 15:18:56 dell kernel: scsi0 : ata_piix
Jul 27 15:18:56 dell kernel: scsi1 : ata_piix
Jul 27 15:18:56 dell kernel: ata1: SATA max UDMA/133 cmd 
0x000000000001bc98 ctl 0x000000000001bc92 bmdma 0x000000000001bc60 irq 0
Jul 27 15:18:56 dell kernel: ata2: SATA max UDMA/133 cmd 
0x000000000001bc80 ctl 0x000000000001bc7a bmdma 0x000000000001bc68 irq 0
Jul 27 15:18:56 dell kernel: ata1.00: ATA-7: Maxtor 6L080M0, 
BACE1G10, max UDMA/133
Jul 27 15:18:56 dell kernel: ata1.00: 156250000 sectors, multi 8: 
LBA48 NCQ (depth 0/32)
Jul 27 15:18:56 dell kernel: ata1.01: ATA-7: WDC WD2500KS-00MJB0, 
02.01C03, max UDMA/133
Jul 27 15:18:56 dell kernel: ata1.01: 488397168 sectors, multi 8: LBA48
Jul 27 15:18:56 dell kernel: ata1.00: configured for UDMA/133
Jul 27 15:18:56 dell kernel: ata1.01: configured for UDMA/133
Jul 27 15:18:56 dell kernel: scsi 0:0:0:0: 
Direct-Access     ATA      Maxtor 6L080M0   BACE PQ: 0 ANSI: 5
Jul 27 15:18:56 dell kernel: sd 0:0:0:0: [sda] 156250000 512-byte 
hardware sectors (80000 MB)
Jul 27 15:18:56 dell kernel: sd 0:0:0:0: [sda] Write Protect is off
Jul 27 15:18:56 dell kernel: sd 0:0:0:0: [sda] Write cache: enabled, 
read cache: enabled, doesn't support DPO or FUA
Jul 27 15:18:56 dell kernel: sd 0:0:0:0: [sda] 156250000 512-byte 
hardware sectors (80000 MB)
Jul 27 15:18:56 dell kernel: sd 0:0:0:0: [sda] Write Protect is off
Jul 27 15:18:56 dell kernel: sd 0:0:0:0: [sda] Write cache: enabled, 
read cache: enabled, doesn't support DPO or FUA
Jul 27 15:18:56 dell kernel:  sda: sda1 sda2
Jul 27 15:18:56 dell kernel: sd 0:0:0:0: [sda] Attached SCSI disk
Jul 27 15:18:56 dell kernel: scsi 0:0:1:0: 
Direct-Access     ATA      WDC WD2500KS-00M 02.0 PQ: 0 ANSI: 5
Jul 27 15:18:56 dell kernel: sd 0:0:1:0: [sdb] 488397168 512-byte 
hardware sectors (250059 MB)
Jul 27 15:18:56 dell kernel: sd 0:0:1:0: [sdb] Write Protect is off
Jul 27 15:18:56 dell kernel: sd 0:0:1:0: [sdb] Write cache: enabled, 
read cache: enabled, doesn't support DPO or FUA
Jul 27 15:18:56 dell kernel: sd 0:0:1:0: [sdb] 488397168 512-byte 
hardware sectors (250059 MB)
Jul 27 15:18:56 dell kernel: sd 0:0:1:0: [sdb] Write Protect is off
Jul 27 15:18:56 dell kernel: sd 0:0:1:0: [sdb] Write cache: enabled, 
read cache: enabled, doesn't support DPO or FUA
Jul 27 15:18:56 dell kernel:  sdb: sdb1
Jul 27 15:18:56 dell kernel: sd 0:0:1:0: [sdb] Attached SCSI disk
Jul 27 15:18:56 dell kernel: ACPI: PCI Interrupt 0000:03:01.0[A] -> 
GSI 32 (level, low) -> IRQ 32
Jul 27 15:18:56 dell kernel: sata_sil24 0000:03:01.0: Applying 
completion IRQ loss on PCI-X errata fix
Jul 27 15:18:56 dell kernel: scsi2 : sata_sil24
Jul 27 15:18:56 dell kernel: scsi3 : sata_sil24
Jul 27 15:18:56 dell kernel: scsi4 : sata_sil24
Jul 27 15:18:56 dell kernel: scsi5 : sata_sil24
Jul 27 15:18:56 dell kernel: ata3: SATA max UDMA/100 cmd 
0xffffc20000c40000 ctl 0x0000000000000000 bmdma 0x0000000000000000 irq 0
Jul 27 15:18:56 dell kernel: ata4: SATA max UDMA/100 cmd 
0xffffc20000c42000 ctl 0x0000000000000000 bmdma 0x0000000000000000 irq 0
Jul 27 15:18:56 dell kernel: ata5: SATA max UDMA/100 cmd 
0xffffc20000c44000 ctl 0x0000000000000000 bmdma 0x0000000000000000 irq 0
Jul 27 15:18:56 dell kernel: ata6: SATA max UDMA/100 cmd 
0xffffc20000c46000 ctl 0x0000000000000000 bmdma 0x0000000000000000 irq 0
Jul 27 15:18:56 dell kernel: ata3: SATA link down (SStatus 0 SControl 0)
Jul 27 15:18:56 dell kernel: ata4: SATA link down (SStatus 0 SControl 0)
Jul 27 15:18:56 dell kernel: ata5: SATA link up 3.0 Gbps (SStatus 123 
SControl 0)
Jul 27 15:18:56 dell kernel: ata5.15: Port Multiplier 1.1, 
0x1095:0x3726 r23, 6 ports, feat 0x9/0x9
Jul 27 15:18:56 dell kernel: ata5.00: hard resetting link
Jul 27 15:18:56 dell kernel: ata5.00: SATA link down (SStatus 0 SControl 310)
Jul 27 15:18:56 dell kernel: ata5.01: hard resetting link
Jul 27 15:18:56 dell kernel: ata5.01: SATA link up 3.0 Gbps (SStatus 
123 SControl 300)
Jul 27 15:18:56 dell kernel: ata5.02: hard resetting link
Jul 27 15:18:56 dell kernel: ata5.02: SATA link up 3.0 Gbps (SStatus 
123 SControl 300)
Jul 27 15:18:56 dell kernel: ata5.03: hard resetting link
Jul 27 15:18:56 dell kernel: ata5.03: SATA link up 3.0 Gbps (SStatus 
123 SControl 300)
Jul 27 15:18:56 dell kernel: ata5.04: hard resetting link
Jul 27 15:18:56 dell kernel: ata5.04: SATA link up 3.0 Gbps (SStatus 
123 SControl 300)
Jul 27 15:18:56 dell kernel: ata5.05: hard resetting link
Jul 27 15:18:56 dell kernel: ata5.05: SATA link up 1.5 Gbps (SStatus 
113 SControl 300)
Jul 27 15:18:56 dell kernel: ata5.01: ATA-7: ST3750640AS, 3.AAJ, max UDMA/133
Jul 27 15:18:56 dell kernel: ata5.01: 1465149168 sectors, multi 0: 
LBA48 NCQ (depth 31/32)
Jul 27 15:18:56 dell kernel: ata5.01: configured for UDMA/100
Jul 27 15:18:56 dell kernel: ata5.02: ATA-7: ST3750640AS, 3.AAJ, max UDMA/133
Jul 27 15:18:56 dell kernel: ata5.02: 1465149168 sectors, multi 0: 
LBA48 NCQ (depth 31/32)
Jul 27 15:18:56 dell kernel: ata5.02: configured for UDMA/100
Jul 27 15:18:56 dell kernel: ata5.03: ATA-7: ST3750640AS, 3.AAC, max UDMA/133
Jul 27 15:18:56 dell kernel: ata5.03: 1465149168 sectors, multi 0: 
LBA48 NCQ (depth 31/32)
Jul 27 15:18:56 dell kernel: ata5.03: configured for UDMA/100
Jul 27 15:18:56 dell kernel: ata5.04: ATA-7: ST3750640AS, 3.AAJ, max UDMA/133
Jul 27 15:18:56 dell kernel: ata5.04: 1465149168 sectors, multi 0: 
LBA48 NCQ (depth 31/32)
Jul 27 15:18:56 dell kernel: ata5.04: configured for UDMA/100
Jul 27 15:18:56 dell kernel: ata5: EH complete
Jul 27 15:18:56 dell kernel: ata6: SATA link up 3.0 Gbps (SStatus 123 
SControl 0)
Jul 27 15:18:56 dell kernel: ata6.15: Port Multiplier 1.1, 
0x1095:0x3726 r23, 6 ports, feat 0x9/0x9
Jul 27 15:18:56 dell kernel: ata6.00: hard resetting link
Jul 27 15:18:56 dell kernel: ata6.00: SATA link up 3.0 Gbps (SStatus 
123 SControl 300)
Jul 27 15:18:56 dell kernel: ata6.01: hard resetting link
Jul 27 15:18:56 dell kernel: ata6.01: SATA link up 3.0 Gbps (SStatus 
123 SControl 300)
Jul 27 15:18:56 dell kernel: ata6.02: hard resetting link
Jul 27 15:18:56 dell kernel: ata6.02: SATA link up 3.0 Gbps (SStatus 
123 SControl 300)
Jul 27 15:18:56 dell kernel: ata6.03: hard resetting link
Jul 27 15:18:56 dell kernel: ata6.03: SATA link down (SStatus 0 SControl 300)
Jul 27 15:18:56 dell kernel: ata6.04: hard resetting link
Jul 27 15:18:56 dell kernel: ata6.04: SATA link up 3.0 Gbps (SStatus 
123 SControl 300)
Jul 27 15:18:56 dell kernel: ata6.05: hard resetting link
Jul 27 15:18:56 dell kernel: ata6.05: SATA link up 1.5 Gbps (SStatus 
113 SControl 300)
Jul 27 15:18:56 dell kernel: ata6.00: ATA-7: ST3750640AS, 3.AAC, max UDMA/133
Jul 27 15:18:56 dell kernel: ata6.00: 1465149168 sectors, multi 16: 
LBA48 NCQ (depth 31/32)
Jul 27 15:18:56 dell kernel: ata6.00: configured for UDMA/100
Jul 27 15:18:56 dell kernel: ata6.01: ATA-7: ST3750640AS, 3.AAC, max UDMA/133
Jul 27 15:18:56 dell kernel: ata6.01: 1465149168 sectors, multi 0: 
LBA48 NCQ (depth 31/32)
Jul 27 15:18:56 dell kernel: ata6.01: configured for UDMA/100
Jul 27 15:18:56 dell kernel: ata6.02: ATA-7: ST3750640AS, 3.AAJ, max UDMA/133
Jul 27 15:18:56 dell kernel: ata6.02: 1465149168 sectors, multi 0: 
LBA48 NCQ (depth 31/32)
Jul 27 15:18:56 dell kernel: ata6.02: configured for UDMA/100
Jul 27 15:18:56 dell kernel: ata6.04: ATA-7: ST3750640AS, 3.AAJ, max UDMA/133
Jul 27 15:18:56 dell kernel: ata6.04: 1465149168 sectors, multi 0: 
LBA48 NCQ (depth 31/32)
Jul 27 15:18:56 dell kernel: ata6.04: configured for UDMA/100
Jul 27 15:18:56 dell kernel: ata6: EH complete
Jul 27 15:18:56 dell kernel: scsi 4:0:1:0: 
Direct-Access     ATA      ST3750640AS      3.AA PQ: 0 ANSI: 5
Jul 27 15:18:56 dell kernel: sd 4:0:1:0: [sdc] 1465149168 512-byte 
hardware sectors (750156 MB)
Jul 27 15:18:56 dell kernel: sd 4:0:1:0: [sdc] Write Protect is off
Jul 27 15:18:56 dell kernel: sd 4:0:1:0: [sdc] Write cache: enabled, 
read cache: enabled, doesn't support DPO or FUA
Jul 27 15:18:56 dell kernel: sd 4:0:1:0: [sdc] 1465149168 512-byte 
hardware sectors (750156 MB)
Jul 27 15:18:56 dell kernel: sd 4:0:1:0: [sdc] Write Protect is off
Jul 27 15:18:56 dell kernel: sd 4:0:1:0: [sdc] Write cache: enabled, 
read cache: enabled, doesn't support DPO or FUA
Jul 27 15:18:56 dell kernel:  sdc: sdc1
Jul 27 15:18:56 dell kernel: sd 4:0:1:0: [sdc] Attached SCSI disk
Jul 27 15:18:56 dell kernel: scsi 4:0:2:0: 
Direct-Access     ATA      ST3750640AS      3.AA PQ: 0 ANSI: 5
Jul 27 15:18:56 dell kernel: sd 4:0:2:0: [sdd] 1465149168 512-byte 
hardware sectors (750156 MB)
Jul 27 15:18:56 dell kernel: sd 4:0:2:0: [sdd] Write Protect is off
Jul 27 15:18:56 dell kernel: sd 4:0:2:0: [sdd] Write cache: enabled, 
read cache: enabled, doesn't support DPO or FUA
Jul 27 15:18:56 dell kernel: sd 4:0:2:0: [sdd] 1465149168 512-byte 
hardware sectors (750156 MB)
Jul 27 15:18:56 dell kernel: sd 4:0:2:0: [sdd] Write Protect is off
Jul 27 15:18:56 dell kernel: sd 4:0:2:0: [sdd] Write cache: enabled, 
read cache: enabled, doesn't support DPO or FUA
Jul 27 15:18:56 dell kernel:  sdd: sdd1
Jul 27 15:18:56 dell kernel: sd 4:0:2:0: [sdd] Attached SCSI disk
Jul 27 15:18:56 dell kernel: scsi 4:0:3:0: 
Direct-Access     ATA      ST3750640AS      3.AA PQ: 0 ANSI: 5
Jul 27 15:18:56 dell kernel: sd 4:0:3:0: [sde] 1465149168 512-byte 
hardware sectors (750156 MB)
Jul 27 15:18:56 dell kernel: sd 4:0:3:0: [sde] Write Protect is off
Jul 27 15:18:56 dell kernel: sd 4:0:3:0: [sde] Write cache: enabled, 
read cache: enabled, doesn't support DPO or FUA
Jul 27 15:18:56 dell kernel: sd 4:0:3:0: [sde] 1465149168 512-byte 
hardware sectors (750156 MB)
Jul 27 15:18:56 dell kernel: sd 4:0:3:0: [sde] Write Protect is off
Jul 27 15:18:56 dell kernel: sd 4:0:3:0: [sde] Write cache: enabled, 
read cache: enabled, doesn't support DPO or FUA
Jul 27 15:18:56 dell kernel:  sde: sde1
Jul 27 15:18:56 dell kernel: sd 4:0:3:0: [sde] Attached SCSI disk
Jul 27 15:18:56 dell kernel: scsi 4:0:4:0: 
Direct-Access     ATA      ST3750640AS      3.AA PQ: 0 ANSI: 5
Jul 27 15:18:56 dell kernel: sd 4:0:4:0: [sdf] 1465149168 512-byte 
hardware sectors (750156 MB)
Jul 27 15:18:56 dell kernel: sd 4:0:4:0: [sdf] Write Protect is off
Jul 27 15:18:56 dell kernel: sd 4:0:4:0: [sdf] Write cache: enabled, 
read cache: enabled, doesn't support DPO or FUA
Jul 27 15:18:56 dell kernel: sd 4:0:4:0: [sdf] 1465149168 512-byte 
hardware sectors (750156 MB)
Jul 27 15:18:57 dell kernel: sd 4:0:4:0: [sdf] Write Protect is off
Jul 27 15:18:57 dell kernel: sd 4:0:4:0: [sdf] Write cache: enabled, 
read cache: enabled, doesn't support DPO or FUA
Jul 27 15:18:57 dell kernel:  sdf: sdf1
Jul 27 15:18:57 dell kernel: sd 4:0:4:0: [sdf] Attached SCSI disk
Jul 27 15:18:57 dell kernel: scsi 5:0:0:0: 
Direct-Access     ATA      ST3750640AS      3.AA PQ: 0 ANSI: 5
Jul 27 15:18:57 dell kernel: sd 5:0:0:0: [sdg] 1465149168 512-byte 
hardware sectors (750156 MB)
Jul 27 15:18:57 dell kernel: sd 5:0:0:0: [sdg] Write Protect is off
Jul 27 15:18:57 dell kernel: sd 5:0:0:0: [sdg] Write cache: enabled, 
read cache: enabled, doesn't support DPO or FUA
Jul 27 15:18:57 dell kernel: sd 5:0:0:0: [sdg] 1465149168 512-byte 
hardware sectors (750156 MB)
Jul 27 15:18:57 dell kernel: sd 5:0:0:0: [sdg] Write Protect is off
Jul 27 15:18:57 dell kernel: sd 5:0:0:0: [sdg] Write cache: enabled, 
read cache: enabled, doesn't support DPO or FUA
Jul 27 15:18:57 dell kernel:  sdg: sdg1
Jul 27 15:18:57 dell kernel: sd 5:0:0:0: [sdg] Attached SCSI disk
Jul 27 15:18:57 dell kernel: scsi 5:0:1:0: 
Direct-Access     ATA      ST3750640AS      3.AA PQ: 0 ANSI: 5
Jul 27 15:18:57 dell kernel: sd 5:0:1:0: [sdh] 1465149168 512-byte 
hardware sectors (750156 MB)
Jul 27 15:18:57 dell kernel: sd 5:0:1:0: [sdh] Write Protect is off
Jul 27 15:18:57 dell kernel: sd 5:0:1:0: [sdh] Write cache: enabled, 
read cache: enabled, doesn't support DPO or FUA
Jul 27 15:18:57 dell kernel: sd 5:0:1:0: [sdh] 1465149168 512-byte 
hardware sectors (750156 MB)
Jul 27 15:18:57 dell kernel: sd 5:0:1:0: [sdh] Write Protect is off
Jul 27 15:18:57 dell netfs: Mounting NFS filesystems:  succeeded
Jul 27 15:18:57 dell kernel: sd 5:0:1:0: [sdh] Write cache: enabled, 
read cache: enabled, doesn't support DPO or FUA
Jul 27 15:18:57 dell kernel:  sdh: sdh1
Jul 27 15:18:57 dell kernel: sd 5:0:1:0: [sdh] Attached SCSI disk
Jul 27 15:18:57 dell kernel: scsi 5:0:2:0: 
Direct-Access     ATA      ST3750640AS      3.AA PQ: 0 ANSI: 5
Jul 27 15:18:57 dell kernel: sd 5:0:2:0: [sdi] 1465149168 512-byte 
hardware sectors (750156 MB)
Jul 27 15:18:57 dell kernel: sd 5:0:2:0: [sdi] Write Protect is off
Jul 27 15:18:57 dell kernel: sd 5:0:2:0: [sdi] Write cache: enabled, 
read cache: enabled, doesn't support DPO or FUA
Jul 27 15:18:57 dell kernel: sd 5:0:2:0: [sdi] 1465149168 512-byte 
hardware sectors (750156 MB)
Jul 27 15:18:57 dell kernel: sd 5:0:2:0: [sdi] Write Protect is off
Jul 27 15:18:57 dell kernel: sd 5:0:2:0: [sdi] Write cache: enabled, 
read cache: enabled, doesn't support DPO or FUA
Jul 27 15:18:57 dell kernel:  sdi: sdi1
Jul 27 15:18:57 dell kernel: sd 5:0:2:0: [sdi] Attached SCSI disk
Jul 27 15:18:57 dell kernel: scsi 5:0:4:0: 
Direct-Access     ATA      ST3750640AS      3.AA PQ: 0 ANSI: 5
Jul 27 15:18:57 dell kernel: sd 5:0:4:0: [sdj] 1465149168 512-byte 
hardware sectors (750156 MB)
Jul 27 15:18:57 dell kernel: sd 5:0:4:0: [sdj] Write Protect is off
Jul 27 15:18:57 dell kernel: sd 5:0:4:0: [sdj] Write cache: enabled, 
read cache: enabled, doesn't support DPO or FUA
Jul 27 15:18:57 dell kernel: sd 5:0:4:0: [sdj] 1465149168 512-byte 
hardware sectors (750156 MB)
Jul 27 15:18:57 dell kernel: sd 5:0:4:0: [sdj] Write Protect is off
Jul 27 15:18:57 dell kernel: sd 5:0:4:0: [sdj] Write cache: enabled, 
read cache: enabled, doesn't support DPO or FUA
Jul 27 15:18:57 dell kernel:  sdj: sdj1
Jul 27 15:18:57 dell kernel: sd 5:0:4:0: [sdj] Attached SCSI disk
Jul 27 15:18:57 dell kernel: ACPI: PCI Interrupt 0000:03:02.0[A] -> 
GSI 35 (level, low) -> IRQ 35
Jul 27 15:18:57 dell kernel: sata_sil24 0000:03:02.0: Applying 
completion IRQ loss on PCI-X errata fix
Jul 27 15:18:57 dell kernel: scsi6 : sata_sil24
Jul 27 15:18:57 dell kernel: scsi7 : sata_sil24
Jul 27 15:18:57 dell kernel: scsi8 : sata_sil24
Jul 27 15:18:57 dell kernel: scsi9 : sata_sil24
Jul 27 15:18:57 dell kernel: ata7: SATA max UDMA/100 cmd 
0xffffc20000c50000 ctl 0x0000000000000000 bmdma 0x0000000000000000 irq 0
Jul 27 15:18:57 dell kernel: ata8: SATA max UDMA/100 cmd 
0xffffc20000c52000 ctl 0x0000000000000000 bmdma 0x0000000000000000 irq 0
Jul 27 15:18:57 dell kernel: ata9: SATA max UDMA/100 cmd 
0xffffc20000c54000 ctl 0x0000000000000000 bmdma 0x0000000000000000 irq 0
Jul 27 15:18:57 dell kernel: ata10: SATA max UDMA/100 cmd 
0xffffc20000c56000 ctl 0x0000000000000000 bmdma 0x0000000000000000 irq 0
Jul 27 15:18:57 dell kernel: ata7: SATA link down (SStatus 0 SControl 0)
Jul 27 15:18:57 dell kernel: ata8: SATA link up 3.0 Gbps (SStatus 123 
SControl 0)
Jul 27 15:18:57 dell kernel: ata8.15: Port Multiplier 1.1, 
0x1095:0x3726 r23, 6 ports, feat 0x9/0x9
Jul 27 15:18:57 dell kernel: ata8.00: hard resetting link
Jul 27 15:18:57 dell kernel: ata8.00: SATA link up 1.5 Gbps (SStatus 
113 SControl 300)
Jul 27 15:18:57 dell kernel: ata8.01: hard resetting link
Jul 27 15:18:57 dell kernel: ata8.01: SATA link up 1.5 Gbps (SStatus 
113 SControl 300)
Jul 27 15:18:57 dell kernel: ata8.02: hard resetting link
Jul 27 15:18:57 dell kernel: ata8.02: SATA link up 1.5 Gbps (SStatus 
113 SControl 300)
Jul 27 15:18:57 dell kernel: ata8.03: hard resetting link
Jul 27 15:18:57 dell kernel: ata8.03: SATA link up 1.5 Gbps (SStatus 
113 SControl 300)
Jul 27 15:18:57 dell kernel: ata8.04: hard resetting link
Jul 27 15:18:57 dell kernel: ata8.04: SATA link down (SStatus 0 SControl 300)
Jul 27 15:18:57 dell kernel: ata8.05: hard resetting link
Jul 27 15:18:57 dell kernel: ata8.05: SATA link up 1.5 Gbps (SStatus 
113 SControl 300)
Jul 27 15:18:57 dell kernel: ata8.00: ATA-7: ST3750640AS, 3.AAE, max UDMA/133
Jul 27 15:18:57 dell kernel: ata8.00: 1465149168 sectors, multi 16: 
LBA48 NCQ (depth 31/32)
Jul 27 15:18:57 dell kernel: ata8.00: configured for UDMA/100
Jul 27 15:18:57 dell kernel: ata8.01: ATA-7: WDC WD2500KS-00MJB0, 
02.01C03, max UDMA/133
Jul 27 15:18:57 dell kernel: ata8.01: 488397168 sectors, multi 0: LBA48
Jul 27 15:18:57 dell kernel: ata8.01: configured for UDMA/100
Jul 27 15:18:57 dell kernel: ata8.02: ATA-7: WDC WD2500KS-00MJB0, 
02.01C03, max UDMA/133
Jul 27 15:18:57 dell kernel: ata8.02: 488397168 sectors, multi 0: LBA48
Jul 27 15:18:57 dell kernel: ata8.02: configured for UDMA/100
Jul 27 15:18:57 dell kernel: ata8.03: ATA-7: WDC WD2500KS-00MJB0, 
02.01C03, max UDMA/133
Jul 27 15:18:57 dell kernel: ata8.03: 488397168 sectors, multi 0: LBA48
Jul 27 15:18:57 dell kernel: ata8.03: configured for UDMA/100
Jul 27 15:18:57 dell kernel: ata8: EH complete
Jul 27 15:18:57 dell kernel: ata9: SATA link up 3.0 Gbps (SStatus 123 
SControl 0)
Jul 27 15:18:57 dell kernel: ata9.15: Port Multiplier 1.1, 
0x1095:0x3726 r23, 6 ports, feat 0x9/0x9
Jul 27 15:18:57 dell kernel: ata9.00: hard resetting link
Jul 27 15:18:57 dell kernel: ata9.00: SATA link up 1.5 Gbps (SStatus 
113 SControl 300)
Jul 27 15:18:57 dell kernel: ata9.01: hard resetting link
Jul 27 15:18:57 dell kernel: ata9.01: SATA link up 1.5 Gbps (SStatus 
113 SControl 300)
Jul 27 15:18:57 dell kernel: ata9.02: hard resetting link
Jul 27 15:18:57 dell kernel: ata9.02: SATA link up 1.5 Gbps (SStatus 
113 SControl 300)
Jul 27 15:18:57 dell kernel: ata9.03: hard resetting link
Jul 27 15:18:57 dell kernel: ata9.03: SATA link up 1.5 Gbps (SStatus 
113 SControl 300)
Jul 27 15:18:57 dell kernel: ata9.04: hard resetting link
Jul 27 15:18:57 dell kernel: ata9.04: SATA link up 1.5 Gbps (SStatus 
113 SControl 300)
Jul 27 15:18:57 dell kernel: ata9.05: hard resetting link
Jul 27 15:18:57 dell kernel: ata9.05: SATA link up 1.5 Gbps (SStatus 
113 SControl 300)
Jul 27 15:18:57 dell kernel: ata9.00: ATA-7: ST3750640AS, 3.AAE, max UDMA/133
Jul 27 15:18:57 dell kernel: ata9.00: 1465149168 sectors, multi 16: 
LBA48 NCQ (depth 31/32)
Jul 27 15:18:57 dell kernel: ata9.00: configured for UDMA/100
Jul 27 15:18:57 dell kernel: ata9.01: ATA-7: ST3320620AS, 3.AAC, max UDMA/133
Jul 27 15:18:57 dell kernel: ata9.01: 625142448 sectors, multi 0: 
LBA48 NCQ (depth 31/32)
Jul 27 15:18:57 dell kernel: ata9.01: configured for UDMA/100
Jul 27 15:18:57 dell kernel: ata9.02: ATA-7: WDC WD2500KS-00MJB0, 
02.01C03, max UDMA/133
Jul 27 15:18:57 dell kernel: ata9.02: 488397168 sectors, multi 0: LBA48
Jul 27 15:18:57 dell kernel: ata9.02: configured for UDMA/100
Jul 27 15:18:57 dell kernel: ata9.03: ATA-7: WDC WD2500KS-00MJB0, 
02.01C03, max UDMA/133
Jul 27 15:18:57 dell kernel: ata9.03: 488397168 sectors, multi 0: LBA48
Jul 27 15:18:57 dell kernel: ata9.03: configured for UDMA/100
Jul 27 15:18:57 dell kernel: ata9.04: ATA-7: WDC WD2500KS-00MJB0, 
02.01C03, max UDMA/133
Jul 27 15:18:57 dell kernel: ata9.04: 488397168 sectors, multi 0: LBA48
Jul 27 15:18:57 dell kernel: ata9.04: configured for UDMA/100
Jul 27 15:18:57 dell kernel: ata9: EH complete
Jul 27 15:18:57 dell kernel: ata10: SATA link up 3.0 Gbps (SStatus 
123 SControl 0)
Jul 27 15:18:57 dell kernel: ata10.15: Port Multiplier 1.1, 
0x1095:0x3726 r23, 6 ports, feat 0x9/0x9
Jul 27 15:18:57 dell kernel: ata10.00: hard resetting link
Jul 27 15:18:57 dell kernel: ata10.00: SATA link up 1.5 Gbps (SStatus 
113 SControl 300)
Jul 27 15:18:57 dell kernel: ata10.01: hard resetting link
Jul 27 15:18:57 dell kernel: ata10.01: SATA link down (SStatus 0 SControl 300)
Jul 27 15:18:57 dell kernel: ata10.02: hard resetting link
Jul 27 15:18:57 dell kernel: ata10.02: SATA link down (SStatus 0 SControl 300)
Jul 27 15:18:57 dell kernel: ata10.03: hard resetting link
Jul 27 15:18:57 dell kernel: ata10.03: SATA link up 3.0 Gbps (SStatus 
123 SControl 300)
Jul 27 15:18:57 dell kernel: ata10.04: hard resetting link
Jul 27 15:18:57 dell kernel: ata10.04: SATA link up 3.0 Gbps (SStatus 
123 SControl 300)
Jul 27 15:18:57 dell kernel: ata10.05: hard resetting link
Jul 27 15:18:57 dell kernel: ata10.05: SATA link up 1.5 Gbps (SStatus 
113 SControl 300)
Jul 27 15:18:57 dell kernel: ata10.00: ATA-7: ST3750640AS, 3.AAE, max UDMA/133
Jul 27 15:18:57 dell kernel: ata10.00: 1465149168 sectors, multi 16: 
LBA48 NCQ (depth 31/32)
Jul 27 15:18:57 dell kernel: ata10.00: configured for UDMA/100
Jul 27 15:18:57 dell kernel: ata10.03: ATA-7: WDC WD2500KS-00MJB0, 
02.01C03, max UDMA/133
Jul 27 15:18:57 dell kernel: ata10.03: 488397168 sectors, multi 0: LBA48
Jul 27 15:18:57 dell kernel: ata10.03: configured for UDMA/100
Jul 27 15:18:57 dell kernel: ata10.04: ATA-7: WDC WD2500KS-00MJB0, 
02.01C03, max UDMA/133
Jul 27 15:18:57 dell kernel: ata10.04: 488397168 sectors, multi 0: LBA48
Jul 27 15:18:57 dell kernel: ata10.04: configured for UDMA/100
Jul 27 15:18:57 dell kernel: ata10: EH complete
Jul 27 15:18:57 dell kernel: scsi 7:0:0:0: 
Direct-Access     ATA      ST3750640AS      3.AA PQ: 0 ANSI: 5
Jul 27 15:18:57 dell kernel: sd 7:0:0:0: [sdk] 1465149168 512-byte 
hardware sectors (750156 MB)
Jul 27 15:18:57 dell kernel: sd 7:0:0:0: [sdk] Write Protect is off
Jul 27 15:18:57 dell kernel: sd 7:0:0:0: [sdk] Write cache: enabled, 
read cache: enabled, doesn't support DPO or FUA
Jul 27 15:18:57 dell kernel: sd 7:0:0:0: [sdk] 1465149168 512-byte 
hardware sectors (750156 MB)
Jul 27 15:18:57 dell kernel: sd 7:0:0:0: [sdk] Write Protect is off
Jul 27 15:18:57 dell kernel: sd 7:0:0:0: [sdk] Write cache: enabled, 
read cache: enabled, doesn't support DPO or FUA
Jul 27 15:18:57 dell kernel:  sdk: sdk1
Jul 27 15:18:57 dell netfs: Mounting other filesystems:  succeeded
Jul 27 15:18:57 dell kernel: sd 7:0:0:0: [sdk] Attached SCSI disk
Jul 27 15:18:57 dell kernel: scsi 7:0:1:0: 
Direct-Access     ATA      WDC WD2500KS-00M 02.0 PQ: 0 ANSI: 5
Jul 27 15:18:57 dell kernel: sd 7:0:1:0: [sdl] 488397168 512-byte 
hardware sectors (250059 MB)
Jul 27 15:18:57 dell kernel: sd 7:0:1:0: [sdl] Write Protect is off
Jul 27 15:18:57 dell kernel: sd 7:0:1:0: [sdl] Write cache: enabled, 
read cache: enabled, doesn't support DPO or FUA
Jul 27 15:18:57 dell kernel: sd 7:0:1:0: [sdl] 488397168 512-byte 
hardware sectors (250059 MB)
Jul 27 15:18:57 dell kernel: sd 7:0:1:0: [sdl] Write Protect is off
Jul 27 15:18:57 dell kernel: sd 7:0:1:0: [sdl] Write cache: enabled, 
read cache: enabled, doesn't support DPO or FUA
Jul 27 15:18:57 dell kernel:  sdl: unknown partition table
Jul 27 15:18:57 dell kernel: sd 7:0:1:0: [sdl] Attached SCSI disk
Jul 27 15:18:57 dell kernel: scsi 7:0:2:0: 
Direct-Access     ATA      WDC WD2500KS-00M 02.0 PQ: 0 ANSI: 5
Jul 27 15:18:57 dell kernel: sd 7:0:2:0: [sdm] 488397168 512-byte 
hardware sectors (250059 MB)
Jul 27 15:18:57 dell kernel: sd 7:0:2:0: [sdm] Write Protect is off
Jul 27 15:18:57 dell kernel: sd 7:0:2:0: [sdm] Write cache: enabled, 
read cache: enabled, doesn't support DPO or FUA
Jul 27 15:18:57 dell kernel: sd 7:0:2:0: [sdm] 488397168 512-byte 
hardware sectors (250059 MB)
Jul 27 15:18:57 dell kernel: sd 7:0:2:0: [sdm] Write Protect is off
Jul 27 15:18:57 dell kernel: sd 7:0:2:0: [sdm] Write cache: enabled, 
read cache: enabled, doesn't support DPO or FUA
Jul 27 15:18:57 dell kernel:  sdm: unknown partition table
Jul 27 15:18:57 dell kernel: sd 7:0:2:0: [sdm] Attached SCSI disk
Jul 27 15:18:57 dell kernel: scsi 7:0:3:0: 
Direct-Access     ATA      WDC WD2500KS-00M 02.0 PQ: 0 ANSI: 5
Jul 27 15:18:57 dell kernel: sd 7:0:3:0: [sdn] 488397168 512-byte 
hardware sectors (250059 MB)
Jul 27 15:18:57 dell kernel: sd 7:0:3:0: [sdn] Write Protect is off
Jul 27 15:18:57 dell kernel: sd 7:0:3:0: [sdn] Write cache: enabled, 
read cache: enabled, doesn't support DPO or FUA
Jul 27 15:18:57 dell kernel: sd 7:0:3:0: [sdn] 488397168 512-byte 
hardware sectors (250059 MB)
Jul 27 15:18:57 dell kernel: sd 7:0:3:0: [sdn] Write Protect is off
Jul 27 15:18:57 dell rc: Starting lm_sensors:  succeeded
Jul 27 15:18:57 dell kernel: sd 7:0:3:0: [sdn] Write cache: enabled, 
read cache: enabled, doesn't support DPO or FUA
Jul 27 15:18:57 dell kernel:  sdn: unknown partition table
Jul 27 15:18:57 dell kernel: sd 7:0:3:0: [sdn] Attached SCSI disk
Jul 27 15:18:57 dell kernel: scsi 8:0:0:0: 
Direct-Access     ATA      ST3750640AS      3.AA PQ: 0 ANSI: 5
Jul 27 15:18:57 dell kernel: sd 8:0:0:0: [sdo] 1465149168 512-byte 
hardware sectors (750156 MB)
Jul 27 15:18:57 dell kernel: sd 8:0:0:0: [sdo] Write Protect is off
Jul 27 15:18:57 dell kernel: sd 8:0:0:0: [sdo] Write cache: enabled, 
read cache: enabled, doesn't support DPO or FUA
Jul 27 15:18:57 dell kernel: sd 8:0:0:0: [sdo] 1465149168 512-byte 
hardware sectors (750156 MB)
Jul 27 15:18:57 dell kernel: sd 8:0:0:0: [sdo] Write Protect is off
Jul 27 15:18:57 dell kernel: sd 8:0:0:0: [sdo] Write cache: enabled, 
read cache: enabled, doesn't support DPO or FUA
Jul 27 15:18:57 dell kernel:  sdo: sdo1
Jul 27 15:18:57 dell kernel: sd 8:0:0:0: [sdo] Attached SCSI disk
Jul 27 15:18:57 dell kernel: scsi 8:0:1:0: 
Direct-Access     ATA      ST3320620AS      3.AA PQ: 0 ANSI: 5
Jul 27 15:18:57 dell kernel: sd 8:0:1:0: [sdp] 625142448 512-byte 
hardware sectors (320073 MB)
Jul 27 15:18:57 dell kernel: sd 8:0:1:0: [sdp] Write Protect is off
Jul 27 15:18:57 dell kernel: sd 8:0:1:0: [sdp] Write cache: enabled, 
read cache: enabled, doesn't support DPO or FUA
Jul 27 15:18:57 dell kernel: sd 8:0:1:0: [sdp] 625142448 512-byte 
hardware sectors (320073 MB)
Jul 27 15:18:57 dell kernel: sd 8:0:1:0: [sdp] Write Protect is off
Jul 27 15:18:57 dell kernel: sd 8:0:1:0: [sdp] Write cache: enabled, 
read cache: enabled, doesn't support DPO or FUA
Jul 27 15:18:57 dell kernel:  sdp: sdp1
Jul 27 15:18:57 dell kernel: sd 8:0:1:0: [sdp] Attached SCSI disk
Jul 27 15:18:57 dell kernel: scsi 8:0:2:0: 
Direct-Access     ATA      WDC WD2500KS-00M 02.0 PQ: 0 ANSI: 5
Jul 27 15:18:57 dell kernel: sd 8:0:2:0: [sdq] 488397168 512-byte 
hardware sectors (250059 MB)
Jul 27 15:18:57 dell kernel: sd 8:0:2:0: [sdq] Write Protect is off
Jul 27 15:18:57 dell kernel: sd 8:0:2:0: [sdq] Write cache: enabled, 
read cache: enabled, doesn't support DPO or FUA
Jul 27 15:18:57 dell kernel: sd 8:0:2:0: [sdq] 488397168 512-byte 
hardware sectors (250059 MB)
Jul 27 15:18:57 dell kernel: sd 8:0:2:0: [sdq] Write Protect is off
Jul 27 15:18:57 dell kernel: sd 8:0:2:0: [sdq] Write cache: enabled, 
read cache: enabled, doesn't support DPO or FUA
Jul 27 15:18:57 dell kernel:  sdq: unknown partition table
Jul 27 15:18:57 dell kernel: sd 8:0:2:0: [sdq] Attached SCSI disk
Jul 27 15:18:57 dell kernel: scsi 8:0:3:0: 
Direct-Access     ATA      WDC WD2500KS-00M 02.0 PQ: 0 ANSI: 5
Jul 27 15:18:57 dell kernel: sd 8:0:3:0: [sdr] 488397168 512-byte 
hardware sectors (250059 MB)
Jul 27 15:18:57 dell kernel: sd 8:0:3:0: [sdr] Write Protect is off
Jul 27 15:18:57 dell kernel: sd 8:0:3:0: [sdr] Write cache: enabled, 
read cache: enabled, doesn't support DPO or FUA
Jul 27 15:18:57 dell kernel: sd 8:0:3:0: [sdr] 488397168 512-byte 
hardware sectors (250059 MB)
Jul 27 15:18:57 dell kernel: sd 8:0:3:0: [sdr] Write Protect is off
Jul 27 15:18:57 dell kernel: sd 8:0:3:0: [sdr] Write cache: enabled, 
read cache: enabled, doesn't support DPO or FUA
Jul 27 15:18:57 dell kernel:  sdr: unknown partition table
Jul 27 15:18:57 dell kernel: sd 8:0:3:0: [sdr] Attached SCSI disk
Jul 27 15:18:57 dell kernel: scsi 8:0:4:0: 
Direct-Access     ATA      WDC WD2500KS-00M 02.0 PQ: 0 ANSI: 5
Jul 27 15:18:57 dell kernel: sd 8:0:4:0: [sds] 488397168 512-byte 
hardware sectors (250059 MB)
Jul 27 15:18:57 dell kernel: sd 8:0:4:0: [sds] Write Protect is off
Jul 27 15:18:57 dell kernel: sd 8:0:4:0: [sds] Write cache: enabled, 
read cache: enabled, doesn't support DPO or FUA
Jul 27 15:18:57 dell kernel: sd 8:0:4:0: [sds] 488397168 512-byte 
hardware sectors (250059 MB)
Jul 27 15:18:57 dell kernel: sd 8:0:4:0: [sds] Write Protect is off
Jul 27 15:18:57 dell kernel: sd 8:0:4:0: [sds] Write cache: enabled, 
read cache: enabled, doesn't support DPO or FUA
Jul 27 15:18:57 dell kernel:  sds: unknown partition table
Jul 27 15:18:57 dell kernel: sd 8:0:4:0: [sds] Attached SCSI disk
Jul 27 15:18:57 dell kernel: scsi 9:0:0:0: 
Direct-Access     ATA      ST3750640AS      3.AA PQ: 0 ANSI: 5
Jul 27 15:18:57 dell kernel: sd 9:0:0:0: [sdt] 1465149168 512-byte 
hardware sectors (750156 MB)
Jul 27 15:18:57 dell kernel: sd 9:0:0:0: [sdt] Write Protect is off
Jul 27 15:18:57 dell kernel: sd 9:0:0:0: [sdt] Write cache: enabled, 
read cache: enabled, doesn't support DPO or FUA
Jul 27 15:18:57 dell kernel: sd 9:0:0:0: [sdt] 1465149168 512-byte 
hardware sectors (750156 MB)
Jul 27 15:18:57 dell kernel: sd 9:0:0:0: [sdt] Write Protect is off
Jul 27 15:18:57 dell kernel: sd 9:0:0:0: [sdt] Write cache: enabled, 
read cache: enabled, doesn't support DPO or FUA
Jul 27 15:18:57 dell kernel:  sdt: sdt1
Jul 27 15:18:57 dell kernel: sd 9:0:0:0: [sdt] Attached SCSI disk
Jul 27 15:18:57 dell kernel: scsi 9:0:3:0: 
Direct-Access     ATA      WDC WD2500KS-00M 02.0 PQ: 0 ANSI: 5
Jul 27 15:18:57 dell kernel: sd 9:0:3:0: [sdu] 488397168 512-byte 
hardware sectors (250059 MB)
Jul 27 15:18:57 dell kernel: sd 9:0:3:0: [sdu] Write Protect is off
Jul 27 15:18:57 dell kernel: sd 9:0:3:0: [sdu] Write cache: enabled, 
read cache: enabled, doesn't support DPO or FUA
Jul 27 15:18:57 dell kernel: sd 9:0:3:0: [sdu] 488397168 512-byte 
hardware sectors (250059 MB)
Jul 27 15:18:57 dell kernel: sd 9:0:3:0: [sdu] Write Protect is off
Jul 27 15:18:57 dell kernel: sd 9:0:3:0: [sdu] Write cache: enabled, 
read cache: enabled, doesn't support DPO or FUA
Jul 27 15:18:57 dell kernel:  sdu: unknown partition table
Jul 27 15:18:57 dell kernel: sd 9:0:3:0: [sdu] Attached SCSI disk
Jul 27 15:18:57 dell kernel: scsi 9:0:4:0: 
Direct-Access     ATA      WDC WD2500KS-00M 02.0 PQ: 0 ANSI: 5
Jul 27 15:18:57 dell kernel: sd 9:0:4:0: [sdv] 488397168 512-byte 
hardware sectors (250059 MB)
Jul 27 15:18:57 dell kernel: sd 9:0:4:0: [sdv] Write Protect is off
Jul 27 15:18:57 dell kernel: sd 9:0:4:0: [sdv] Write cache: enabled, 
read cache: enabled, doesn't support DPO or FUA
Jul 27 15:18:57 dell kernel: sd 9:0:4:0: [sdv] 488397168 512-byte 
hardware sectors (250059 MB)
Jul 27 15:18:57 dell kernel: sd 9:0:4:0: [sdv] Write Protect is off
Jul 27 15:18:57 dell kernel: sd 9:0:4:0: [sdv] Write cache: enabled, 
read cache: enabled, doesn't support DPO or FUA
Jul 27 15:18:57 dell kernel:  sdv: unknown partition table
Jul 27 15:18:57 dell kernel: sd 9:0:4:0: [sdv] Attached SCSI disk
Jul 27 15:18:57 dell kernel: device-mapper: ioctl: 4.11.0-ioctl 
(2006-10-12) initialised: dm-devel@redhat.com
===

any clues?

i haven't tried to reproduce as this is a production machine.

tia,
marc

