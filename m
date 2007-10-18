From: Mark Lord <liml@rtr.ca>
Subject: Bug?  2.6.23-git13 + Jens's latest sg_next fixes:   DRDY?
Date: Thu, 18 Oct 2007 11:14:43 -0400
Message-ID: <47177863.1080500@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:3577 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753578AbXJRPOo (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 18 Oct 2007 11:14:44 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>, IDE/ATA development list <linux-ide@vger.kernel.org>


Something weird in libata with latest -git13 + Jens's patch.
Jeff, did I miss a libata fix somewhere?

-ml



Inserting sata SiI 3132 ExpressCard (normal):

11:04:48: pciehp: Card present on Slot(0013_0005)
11:04:49: program_fw_provided_values: Could not get hotplug parameters
11:04:49: PCI: Enabling device 0000:0d:00.0 (0000 -> 0003)
11:04:49: ACPI: PCI Interrupt 0000:0d:00.0[A] -> GSI 19 (level, low) -> IRQ 18
11:04:49: PCI: Setting latency timer of device 0000:0d:00.0 to 64
11:04:49: scsi4 : sata_sil24
11:04:49: scsi5 : sata_sil24
11:04:49: ata5: SATA max UDMA/100 host m128@0xefa84000 port 0xefa80000 irq 18
11:04:49: ata6: SATA max UDMA/100 host m128@0xefa84000 port 0xefa82000 irq 18
11:04:51: ata5: SATA link down (SStatus 0 SControl 0)
11:04:53: ata6: SATA link down (SStatus 0 SControl 0)

Plugging a drive into the card (normal):

11:05:16: ata5: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0xa frozen
11:05:16: ata5: irq_stat 0x00a00080, device exchanged
11:05:16: ata5: hard resetting link
11:05:18: ata5: SATA link up 1.5 Gbps (SStatus 113 SControl 0)
11:05:18: ata5.00: ATA-7: ST9160821AS, 3.ALC, max UDMA/133
11:05:18: ata5.00: 312581808 sectors, multi 0: LBA48 NCQ (depth 31/32)
11:05:18: ata5.00: configured for UDMA/100
11:05:18: ata5: EH complete
11:05:18: scsi 4:0:0:0: Direct-Access     ATA      ST9160821AS      3.AL PQ: 0 ANSI: 5
11:05:18: sd 4:0:0:0: [sdb] 312581808 512-byte hardware sectors (160042 MB)
11:05:18: sd 4:0:0:0: [sdb] Write Protect is off
11:05:18: sd 4:0:0:0: [sdb] Mode Sense: 00 3a 00 00
11:05:18: sd 4:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
11:05:19: sd 4:0:0:0: [sdb] 312581808 512-byte hardware sectors (160042 MB)
11:05:19: sd 4:0:0:0: [sdb] Write Protect is off
11:05:19: sd 4:0:0:0: [sdb] Mode Sense: 00 3a 00 00
11:05:19: sd 4:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
11:05:19:  sdb: sdb1 sdb2 sdb3
11:05:19: sd 4:0:0:0: [sdb] Attached SCSI disk
11:05:19: sd 4:0:0:0: Attached scsi generic sg2 type 0
11:05:52: kjournald starting.  Commit interval 5 seconds
11:05:52: EXT3 FS on sdb1, internal journal
11:05:52: EXT3-fs: mounted filesystem with ordered data mode.

Not normal, during I/O to the drive:

11:06:09: ata5.00: exception Emask 0x40 SAct 0x40001 SErr 0x0 action 0x2
11:06:09: ata5.00: irq_stat 0x00020002, SGT no on qword boundary
11:06:09: ata5.00: cmd 60/08:00:1b:e7:ed/00:00:0e:00:00/40 tag 0 cdb 0x0 data 4096 in
11:06:09:          res 50/00:03:00:00:00/00:00:00:00:00/40 Emask 0x40 (internal error)
11:06:09: ata5.00: status: { DRDY }
11:06:09: ata5.00: cmd 61/08:90:ab:26:ef/00:00:0e:00:00/40 tag 18 cdb 0x0 data 4096 out
11:06:09:          res 50/00:03:00:00:00/00:00:00:00:00/40 Emask 0x40 (internal error)
11:06:09: ata5.00: status: { DRDY }
11:06:09: ata5: hard resetting link
11:06:11: ata5: SATA link up 1.5 Gbps (SStatus 113 SControl 0)
11:06:11: ata5.00: configured for UDMA/100
11:06:11: ata5: EH complete
11:06:11: sd 4:0:0:0: [sdb] 312581808 512-byte hardware sectors (160042 MB)
11:06:11: sd 4:0:0:0: [sdb] Write Protect is off
11:06:11: sd 4:0:0:0: [sdb] Mode Sense: 00 3a 00 00
11:06:11: sd 4:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
11:06:11: ata5.00: exception Emask 0x40 SAct 0x4001c SErr 0x0 action 0x2
11:06:11: ata5.00: irq_stat 0x00020002, SGT no on qword boundary
11:06:11: ata5.00: cmd 61/70:10:6b:0d:f0/01:00:0e:00:00/40 tag 2 cdb 0x0 data 188416 out
11:06:11:          res 50/00:00:af:9e:a1/00:00:12:00:00/e0 Emask 0x40 (internal error)
11:06:11: ata5.00: status: { DRDY }
11:06:11: ata5.00: cmd 61/d8:18:e3:0e:f0/01:00:0e:00:00/40 tag 3 cdb 0x0 data 241664 out
11:06:11:          res 50/00:00:af:9e:a1/00:00:12:00:00/e0 Emask 0x40 (internal error)
11:06:11: ata5.00: status: { DRDY }
11:06:11: ata5.00: cmd 61/88:20:c3:10:f0/02:00:0e:00:00/40 tag 4 cdb 0x0 data 331776 out
11:06:11:          res 50/00:00:af:9e:a1/00:00:12:00:00/e0 Emask 0x40 (internal error)
11:06:11: ata5.00: status: { DRDY }
11:06:11: ata5.00: cmd 61/b0:90:b3:0c:f0/00:00:0e:00:00/40 tag 18 cdb 0x0 data 90112 out
11:06:11:          res 50/00:00:af:9e:a1/00:00:12:00:00/e0 Emask 0x40 (internal error)
11:06:11: ata5.00: status: { DRDY }
11:06:11: ata5: hard resetting link
11:06:14: ata5: SATA link up 1.5 Gbps (SStatus 113 SControl 0)
11:06:14: ata5.00: configured for UDMA/100
11:06:14: ata5: exception Emask 0x2 SAct 0x0 SErr 0x0 action 0x2 t4
11:06:14: ata5: irq_stat 0x00060002, protocol mismatch
11:06:14: ata5: hard resetting link
11:06:16: ata5: SATA link up 1.5 Gbps (SStatus 113 SControl 0)
11:06:16: ata5.00: configured for UDMA/100
11:06:16: ata5: EH complete
11:06:16: sd 4:0:0:0: [sdb] 312581808 512-byte hardware sectors (160042 MB)
11:06:16: sd 4:0:0:0: [sdb] Write Protect is off
11:06:16: sd 4:0:0:0: [sdb] Mode Sense: 00 3a 00 00
11:06:16: sd 4:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
11:06:16: sd 4:0:0:0: [sdb] 312581808 512-byte hardware sectors (160042 MB)
11:06:16: sd 4:0:0:0: [sdb] Write Protect is off
11:06:16: sd 4:0:0:0: [sdb] Mode Sense: 00 3a 00 00
11:06:16: sd 4:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
