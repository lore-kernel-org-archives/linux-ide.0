From: Mike Accetta <maccetta@laurelnetworks.com>
Subject: ICH6-M libata disk timeouts 2.6.18 -> 2.6.19
Date: Tue, 09 Jan 2007 18:16:17 -0500
Message-ID: <10741.1168384577@mdt.dhcp.pit.laurelnetworks.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from staple.laurelnetworks.com ([63.94.127.68]:41397 "EHLO
	staple.laurelnetworks.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932540AbXAIXgs (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 9 Jan 2007 18:36:48 -0500
Received: from postit.laurelnetworks.com (postit.laurelnetworks.com [63.94.127.21])
	by staple.laurelnetworks.com (ECI-DND/ECI-DND) with ESMTP id l09NGHkf004596
	for <linux-ide@vger.kernel.org>; Tue, 9 Jan 2007 18:16:17 -0500
Received: from mdt.dhcp.pit.laurelnetworks.com (mdt.dhcp.pit.laurelnetworks.com [10.0.21.56])
	by postit.laurelnetworks.com (ECI-DND/ECI-DND) with ESMTP id l09NGH4P008063
	for <linux-ide@vger.kernel.org>; Tue, 9 Jan 2007 18:16:17 -0500
Received: from mdt.dhcp.pit.laurelnetworks.com (localhost.localdomain [127.0.0.1])
	by mdt.dhcp.pit.laurelnetworks.com (8.13.8/8.13.4) with ESMTP id l09NGHEC010742
	for <linux-ide@vger.kernel.org>; Tue, 9 Jan 2007 18:16:17 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

We have a system with an ICH6-M controller and two SATA drives configured
for software RAID1. Under 2.6.18, adding the second drive to the array and
starting a re-sync would go to completion without incident. Under 2.6.19,
adding the second drive will always eventually generate what appear
to be timeout errors, before completion of the re-sync operation. One
trial completed. A second trial devolved into a reset/retry loop which
eventually hard fails the operation.

Transcript of the kernel boot disk section, console logs and lspci
output are included below. Note that the errors are apparently being
logged from the source drive that is already part of the array, not
the drive which is the re-sync target.  I haven't dug into any of this
yet but since it worked on 2.6.18 and consistently fails under 2.6.19,
I thought others might be interested in the interim (and will hopefully
know more than me right away about what might be going wrong).

*** Boot info for SATA disks<

Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH6: IDE controller at PCI slot 0000:00:1f.1
PCI: Found IRQ 5 for device 0000:00:1f.1
PCI: Sharing IRQ 5 with 0000:00:1d.2
ICH6: chipset revision 4
ICH6: not 100% native mode: will probe irqs later
ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:pio, hdb:pio
ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:pio, hdd:pio
ide-floppy driver 0.99.newide
PCI: Found IRQ 11 for device 0000:00:1f.2
PCI: Sharing IRQ 11 with 0000:00:1d.1
IRQ routing conflict for 0000:00:1f.3, have irq 5, want irq 11
ahci 0000:00:1f.2: AHCI 0001.0000 32 slots 4 ports 1.5 Gbps 0x5 impl SATA mode
ahci 0000:00:1f.2: flags: 64bit ncq pm led slum part
ata1: SATA max UDMA/133 cmd 0xF8800D00 ctl 0x0 bmdma 0x0 irq 11
ata2: SATA max UDMA/133 cmd 0xF8800D80 ctl 0x0 bmdma 0x0 irq 11
ata3: SATA max UDMA/133 cmd 0xF8800E00 ctl 0x0 bmdma 0x0 irq 11
ata4: SATA max UDMA/133 cmd 0xF8800E80 ctl 0x0 bmdma 0x0 irq 11
scsi0 : ahci
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.00: ATA-7, max UDMA/100, 117210240 sectors: LBA48 NCQ (depth 31/32)
ata1.00: ata1: dev 0 multi count 16
ata1.00: configured for UDMA/100
scsi1 : ahci
ata2: SATA link down (SStatus 0 SControl 0)
scsi2 : ahci
ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata3.00: ATA-7, max UDMA/100, 117210240 sectors: LBA48 NCQ (depth 31/32)
ata3.00: ata3: dev 0 multi count 16
ata3.00: configured for UDMA/100
scsi3 : ahci
ata4: SATA link down (SStatus 0 SControl 0)
scsi 0:0:0:0: Direct-Access ATA FUJITSU MHV2060B 0000 PQ: 0 ANSI: 5
SCSI device sda: 117210240 512-byte hdwr sectors (60012 MB)
sda: Write Protect is off
SCSI device sda: drive cache: write back
SCSI device sda: 117210240 512-byte hdwr sectors (60012 MB)
sda: Write Protect is off
SCSI device sda: drive cache: write back
sda: sda1 sda4 &lt; sda5 sda6 sda7 sda8 sda9 &gt;
sd 0:0:0:0: Attached scsi disk sda
scsi 2:0:0:0: Direct-Access ATA FUJITSU MHT2060B 0000 PQ: 0 ANSI: 5
SCSI device sdb: 117210240 512-byte hdwr sectors (60012 MB)
sdb: Write Protect is off
SCSI device sdb: drive cache: write back
SCSI device sdb: 117210240 512-byte hdwr sectors (60012 MB)
sdb: Write Protect is off
SCSI device sdb: drive cache: write back
sdb: sdb1 sdb4 &lt; sdb5 sdb6 sdb7 sdb8 sdb9 &gt;
sd 2:0:0:0: Attached scsi disk sdb

*** First re-sync trial starts here

# mdadm -a /dev/md_d0 /dev/sda
RAID1 conf printout:
--- wd:1 rd:2
disk 0, wo:0, o:1, dev:sdb
disk 1, wo:1, o:1, dev:sda
mdadm: re-added /dev/sda
# ata3.00: exception Emask 0x0 SAct 0x7fffffff SErr 0x0 action 0x2 frozen
ata3.00: tag 0 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 1 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 2 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 3 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 4 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 5 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 6 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 7 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 8 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 9 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 10 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 11 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 12 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 13 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 14 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 15 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 16 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 17 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 18 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 19 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 20 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 21 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 22 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 23 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 24 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 25 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 26 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 27 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 28 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 29 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 30 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
SCSI device sdb: 117210240 512-byte hdwr sectors (60012 MB)
sdb: Write Protect is off
SCSI device sdb: drive cache: write back
ata3.00: exception Emask 0x0 SAct 0x7fffffff SErr 0x0 action 0x2 frozen
ata3.00: tag 0 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 1 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 2 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 3 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 4 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 5 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 6 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 7 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 8 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 9 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 10 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 11 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 12 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 13 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 14 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 15 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 16 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 17 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 18 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 19 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 20 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 21 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 22 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 23 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 24 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 25 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 26 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 27 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 28 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 29 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 30 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
SCSI device sdb: 117210240 512-byte hdwr sectors (60012 MB)
sdb: Write Protect is off
SCSI device sdb: drive cache: write back
ata3.00: exception Emask 0x0 SAct 0x1fffffff SErr 0x0 action 0x2 frozen
ata3.00: tag 0 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 1 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 2 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 3 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 4 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 5 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 6 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 7 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 8 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 9 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 10 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 11 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 12 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 13 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 14 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 15 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 16 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 17 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 18 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 19 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 20 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 21 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 22 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 23 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 24 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 25 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 26 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 27 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 28 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
SCSI device sdb: 117210240 512-byte hdwr sectors (60012 MB)
sdb: Write Protect is off
SCSI device sdb: drive cache: write back
ata3.00: limiting speed to UDMA/66
ata3.00: exception Emask 0x0 SAct 0x7fffffff SErr 0x0 action 0x2 frozen
ata3.00: tag 0 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 1 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 2 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 3 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 4 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 5 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 6 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 7 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 8 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 9 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 10 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 11 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 12 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 13 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 14 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 15 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 16 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 17 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 18 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 19 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 20 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 21 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 22 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 23 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 24 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 25 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 26 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 27 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 28 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 29 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 30 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
SCSI device sdb: 117210240 512-byte hdwr sectors (60012 MB)
sdb: Write Protect is off
SCSI device sdb: drive cache: write back
ata3.00: limiting speed to UDMA/44
ata3.00: exception Emask 0x0 SAct 0x7fffffff SErr 0x0 action 0x2 frozen
ata3.00: tag 0 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 1 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 2 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 3 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 4 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 5 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 6 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 7 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 8 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 9 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 10 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 11 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 12 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 13 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 14 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 15 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 16 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 17 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 18 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 19 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 20 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 21 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 22 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 23 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 24 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 25 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 26 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 27 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 28 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 29 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 30 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
SCSI device sdb: 117210240 512-byte hdwr sectors (60012 MB)
sdb: Write Protect is off
SCSI device sdb: drive cache: write back
ata3.00: limiting speed to UDMA/33
ata3.00: exception Emask 0x0 SAct 0x7fffffff SErr 0x0 action 0x2 frozen
ata3.00: tag 0 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 1 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 2 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 3 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 4 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 5 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 6 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 7 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 8 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 9 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 10 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 11 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 12 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 13 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 14 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 15 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 16 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 17 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 18 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 19 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 20 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 21 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 22 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 23 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 24 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 25 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 26 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 27 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 28 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 29 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 30 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
SCSI device sdb: 117210240 512-byte hdwr sectors (60012 MB)
sdb: Write Protect is off
SCSI device sdb: drive cache: write back

# ata3.00: exception Emask 0x0 SAct 0x7fffffff SErr
0x0 action 0x2 frozen
ata3.00: tag 0 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 1 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 2 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 3 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 4 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 5 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 6 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 7 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 8 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 9 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 10 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 11 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 12 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 13 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 14 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 15 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 16 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 17 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 18 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 19 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 20 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 21 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 22 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 23 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 24 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 25 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 26 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 27 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 28 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 29 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 30 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
SCSI device sdb: 117210240 512-byte hdwr sectors (60012 MB)
sdb: Write Protect is off
SCSI device sdb: drive cache: write back

# ata3.00: exception Emask 0x0 SAct 0x7fffffff SErr
0x0 action 0x2 frozen
ata3.00: tag 0 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 1 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 2 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 3 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 4 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 5 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 6 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 7 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 8 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 9 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 10 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 11 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 12 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 13 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 14 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 15 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 16 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 17 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 18 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 19 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 20 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 21 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 22 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 23 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 24 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 25 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 26 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 27 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 28 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 29 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 30 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
SCSI device sdb: 117210240 512-byte hdwr sectors (60012 MB)
sdb: Write Protect is off
SCSI device sdb: drive cache: write back
ata3.00: exception Emask 0x0 SAct 0x7fffffff SErr 0x0 action 0x2 frozen
ata3.00: tag 0 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 1 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 2 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 3 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 4 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 5 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 6 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 7 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 8 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 9 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 10 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 11 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 12 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 13 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 14 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 15 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 16 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 17 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 18 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 19 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 20 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 21 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 22 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 23 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 24 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 25 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 26 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 27 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 28 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 29 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 30 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
SCSI device sdb: 117210240 512-byte hdwr sectors (60012 MB)
sdb: Write Protect is off
SCSI device sdb: drive cache: write back
RAID1 conf printout:
--- wd:2 rd:2
disk 0, wo:0, o:1, dev:sdb
disk 1, wo:0, o:1, dev:sda

*** First re-sync trial completed here

# mdadm -f /dev/md_d0 /dev/sda
raid1: Disk failure on sda, disabling device.
Operation continuing on 1 devices
mdadm: set /dev/sda faulty in /dev/md_d0
# RAID1 conf printout:
--- wd:1 rd:2
disk 0, wo:0, o:1, dev:sdb
disk 1, wo:1, o:0, dev:sda
RAID1 conf printout:
--- wd:1 rd:2
disk 0, wo:0, o:1, dev:sdb

# mdadm -r /dev/md_d0 /dev/sda
mdadm: hot removed /dev/sda

*** Second re-sync trial starts here

# mdadm -a /dev/md_d0 /dev/sda
RAID1 conf printout:
--- wd:1 rd:2
disk 0, wo:0, o:1, dev:sdb
disk 1, wo:1, o:1, dev:sda
mdadm: re-added /dev/sda
# cat /proc/mdstat
Personalities : [raid1]
md_d0 : active raid1 sda[1] sdb[0]
58593750 blocks super 1.0 [2/1] [U_]
[>....................] recovery = 0.2% (120320/58593750)
finish=40.4min speed=24064K/sec

unused devices: <none>
# ata3.00: exception Emask 0x0 SAct 0x3ffffff SErr 0x0 action 0x2 frozen
ata3.00: tag 0 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 1 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 2 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 3 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 4 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 5 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 6 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 7 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 8 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 9 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 10 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 11 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 12 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 13 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 14 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 15 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 16 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 17 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 18 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 19 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 20 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 21 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 22 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 23 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 24 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 25 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
SCSI device sdb: 117210240 512-byte hdwr sectors (60012 MB)
sdb: Write Protect is off
SCSI device sdb: drive cache: write back

# ata3.00: exception Emask 0x0 SAct 0x7fffffff SErr 0x0 action 0x2 frozen
ata3.00: tag 0 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 1 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 2 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 3 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 4 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 5 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 6 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 7 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 8 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 9 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 10 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 11 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 12 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 13 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 14 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 15 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 16 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 17 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 18 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 19 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 20 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 21 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 22 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 23 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 24 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 25 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 26 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 27 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 28 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 29 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 30 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
SCSI device sdb: 117210240 512-byte hdwr sectors (60012 MB)
sdb: Write Protect is off
SCSI device sdb: drive cache: write back
ata3.00: limiting speed to UDMA/25
ata3.00: exception Emask 0x0 SAct 0x7fffffff SErr 0x0 action 0x2 frozen
ata3.00: tag 0 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 1 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 2 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 3 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 4 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 5 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 6 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 7 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 8 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 9 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 10 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 11 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 12 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 13 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 14 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 15 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 16 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 17 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 18 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 19 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 20 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 21 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 22 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 23 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 24 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 25 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 26 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 27 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 28 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 29 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 30 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
SCSI device sdb: 117210240 512-byte hdwr sectors (60012 MB)
sdb: Write Protect is off
SCSI device sdb: drive cache: write back
ata3.00: limiting speed to UDMA/16
ata3.00: exception Emask 0x0 SAct 0x7fffffff SErr 0x0 action 0x2 frozen
ata3.00: tag 0 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 1 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 2 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 3 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 4 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 5 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 6 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 7 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 8 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 9 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 10 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 11 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 12 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 13 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 14 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 15 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 16 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 17 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 18 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 19 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 20 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 21 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 22 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 23 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 24 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 25 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 26 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 27 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 28 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 29 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 30 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
SCSI device sdb: 117210240 512-byte hdwr sectors (60012 MB)
sdb: Write Protect is off
SCSI device sdb: drive cache: write back
ata3.00: limiting speed to PIO4
ata3.00: exception Emask 0x0 SAct 0x7fffffff SErr 0x0 action 0x2 frozen
ata3.00: tag 0 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 1 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 2 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 3 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 4 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 5 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 6 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 7 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 8 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 9 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 10 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 11 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 12 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 13 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 14 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 15 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 16 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 17 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 18 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 19 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 20 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 21 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 22 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 23 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 24 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 25 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 26 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 27 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 28 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 29 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 30 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: limiting speed to PIO3
ata3.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata3.00: tag 0 cmd 0xc4 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3: softreset failed (port busy but CLO unavailable)
ata3: softreset failed, retrying in 5 secs
ata3: port is slow to respond, please be patient (Status 0x80)
ata3: port failed to respond (30 secs, Status 0x80)
ata3: COMRESET failed (device not ready)
ata3: hardreset failed, retrying in 5 secs
ata3.00: limiting speed to PIO2
ata3.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata3.00: tag 0 cmd 0xc4 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3: softreset failed (port busy but CLO unavailable)
ata3: softreset failed, retrying in 5 secs
ata3: port is slow to respond, please be patient (Status 0x80)
ata3: port failed to respond (30 secs, Status 0x80)
ata3: COMRESET failed (device not ready)
ata3: hardreset failed, retrying in 5 secs
ata3.00: limiting speed to PIO1
ata3.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata3.00: tag 0 cmd 0xc4 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3: softreset failed (port busy but CLO unavailable)
ata3: softreset failed, retrying in 5 secs
ata3: port is slow to respond, please be patient (Status 0x80)
ata3: port failed to respond (30 secs, Status 0x80)
ata3: COMRESET failed (device not ready)
ata3: hardreset failed, retrying in 5 secs
ata3.00: limiting speed to PIO0
ata3.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata3.00: tag 0 cmd 0xc4 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3: softreset failed (port busy but CLO unavailable)
ata3: softreset failed, retrying in 5 secs
ata3: port is slow to respond, please be patient (Status 0x80)
ata3: port failed to respond (30 secs, Status 0x80)
ata3: COMRESET failed (device not ready)
ata3: hardreset failed, retrying in 5 secs
ata3.00: speed down requested but no transfer mode left
ata3.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata3.00: tag 0 cmd 0xc4 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3: softreset failed (port busy but CLO unavailable)
ata3: softreset failed, retrying in 5 secs
ata3: port is slow to respond, please be patient (Status 0x80)
ata3: port failed to respond (30 secs, Status 0x80)
ata3: COMRESET failed (device not ready)
ata3: hardreset failed, retrying in 5 secs
end_request: I/O error, dev sdb, sector 26751104
ata3.00: speed down requested but no transfer mode left
ata3.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata3.00: tag 0 cmd 0xc4 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3: softreset failed (port busy but CLO unavailable)
ata3: softreset failed, retrying in 5 secs
ata3: port is slow to respond, please be patient (Status 0x80)
ata3: port failed to respond (30 secs, Status 0x80)
ata3: COMRESET failed (device not ready)
ata3: hardreset failed, retrying in 5 secs
ata3.00: speed down requested but no transfer mode left
ata3.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata3.00: tag 0 cmd 0xc4 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3: softreset failed (port busy but CLO unavailable)
ata3: softreset failed, retrying in 5 secs
ata3: port is slow to respond, please be patient (Status 0x80)
ata3: port failed to respond (30 secs, Status 0x80)
ata3: COMRESET failed (device not ready)
ata3: hardreset failed, retrying in 5 secs
ata3.00: speed down requested but no transfer mode left
ata3.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata3.00: tag 0 cmd 0xc4 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3: softreset failed (port busy but CLO unavailable)
ata3: softreset failed, retrying in 5 secs
ata3: port is slow to respond, please be patient (Status 0x80)
ata3: port failed to respond (30 secs, Status 0x80)
ata3: COMRESET failed (device not ready)
ata3: hardreset failed, retrying in 5 secs
ata3.00: speed down requested but no transfer mode left
ata3.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata3.00: tag 0 cmd 0xc4 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3: softreset failed (port busy but CLO unavailable)
ata3: softreset failed, retrying in 5 secs
ata3: port is slow to respond, please be patient (Status 0x80)
ata3: port failed to respond (30 secs, Status 0x80)
ata3: COMRESET failed (device not ready)
ata3: hardreset failed, retrying in 5 secs
ata3.00: speed down requested but no transfer mode left
ata3.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata3.00: tag 0 cmd 0xc4 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3: softreset failed (port busy but CLO unavailable)
ata3: softreset failed, retrying in 5 secs
ata3: port is slow to respond, please be patient (Status 0x80)
ata3: port failed to respond (30 secs, Status 0x80)
ata3: COMRESET failed (device not ready)
ata3: hardreset failed, retrying in 5 secs
end_request: I/O error, dev sdb, sector 26750976
ata3.00: speed down requested but no transfer mode left
ata3.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata3.00: tag 0 cmd 0xc4 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3: softreset failed (port busy but CLO unavailable)
ata3: softreset failed, retrying in 5 secs
ata3: port is slow to respond, please be patient (Status 0x80)
<span style="white-space: pre;">ata3: port failed to respond (30 secs,
Status 0x80)
ata3: COMRESET failed (device not ready)
ata3: hardreset failed, retrying in 5 secs
ata3.00: speed down requested but no transfer mode left
ata3.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata3.00: tag 0 cmd 0xc4 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3: softreset failed (port busy but CLO unavailable)
ata3: softreset failed, retrying in 5 secs
ata3: port is slow to respond, please be patient (Status 0x80)
ata3: port failed to respond (30 secs, Status 0x80)
ata3: COMRESET failed (device not ready)
ata3: hardreset failed, retrying in 5 secs
ata3.00: speed down requested but no transfer mode left
ata3.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata3.00: tag 0 cmd 0xc4 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3: softreset failed (port busy but CLO unavailable)
ata3: softreset failed, retrying in 5 secs
ata3: port is slow to respond, please be patient (Status 0x80)
ata3: port failed to respond (30 secs, Status 0x80)
ata3: COMRESET failed (device not ready)
ata3: hardreset failed, retrying in 5 secs
ata3.00: speed down requested but no transfer mode left
ata3.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata3.00: tag 0 cmd 0xc4 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3: softreset failed (port busy but CLO unavailable)
ata3: softreset failed, retrying in 5 secs
ata3: port is slow to respond, please be patient (Status 0x80)
ata3: port failed to respond (30 secs, Status 0x80)
ata3: COMRESET failed (device not ready)
ata3: hardreset failed, retrying in 5 secs
ata3.00: speed down requested but no transfer mode left
ata3.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata3.00: tag 0 cmd 0xc4 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3: softreset failed (port busy but CLO unavailable)
ata3: softreset failed, retrying in 5 secs
ata3: port is slow to respond, please be patient (Status 0x80)
ata3: port failed to respond (30 secs, Status 0x80)
ata3: COMRESET failed (device not ready)
ata3: hardreset failed, retrying in 5 secs
end_request: I/O error, dev sdb, sector 26750848

*** lspci -vvvn

00:00.0 Class 0600: 8086:2590 (rev 03)
        Subsystem: 8086:1999
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort+ >SERR- <PERR-
        Latency: 0
        Capabilities: [e0] #09 [2109]

00:02.0 Class 0300: 8086:2592 (rev 03)
        Subsystem: 8086:1999
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at ffa80000 (32-bit, non-prefetchable) [size=512K]
        Region 1: I/O ports at ec00 [size=8]
        Region 2: Memory at d0000000 (32-bit, prefetchable) [size=256M]
        Region 3: Memory at ffa40000 (32-bit, non-prefetchable) [size=256K]
        Expansion ROM at <unassigned> [disabled]
        Capabilities: [d0] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:02.1 Class 0380: 8086:2792 (rev 03)
        Subsystem: 8086:1999
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
        Latency: 0
        Region 0: Memory at ff980000 (32-bit, non-prefetchable) [size=512K]
        Capabilities: [d0] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:1d.0 Class 0c03: 8086:2658 (rev 04)
        Subsystem: 8086:2658
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 5
        Region 4: I/O ports at e000 [size=32]

00:1d.1 Class 0c03: 8086:2659 (rev 04)
        Subsystem: 8086:2659
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin B routed to IRQ 11
        Region 4: I/O ports at dc00 [size=32]

00:1d.2 Class 0c03: 8086:265a (rev 04)
        Subsystem: 8086:265a
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin C routed to IRQ 5
        Region 4: I/O ports at d880 [size=32]

00:1d.3 Class 0c03: 8086:265b (rev 04)
        Subsystem: 8086:265b
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin D routed to IRQ 10
        Region 4: I/O ports at d800 [size=32]

00:1d.7 Class 0c03: 8086:265c (rev 04) (prog-if 20)
        Subsystem: 8086:265c
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 5
        Region 0: Memory at ffa3b800 (32-bit, non-prefetchable) [size=1K]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [58] #0a [20a0]

00:1e.0 Class 0604: 8086:2448 (rev d4) (prog-if 01)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
        I/O behind bridge: 0000c000-0000cfff
        Memory behind bridge: ff700000-ff7fffff
        Prefetchable memory behind bridge: 00000000fff00000-0000000000000000
        BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
        Capabilities: [50] #0d [0000]

00:1e.2 Class 0401: 8086:266e (rev 04)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 5
        Region 0: I/O ports at d400 [size=256]
        Region 1: I/O ports at d080 [size=64]
        Region 2: Memory at ffa3b400 (32-bit, non-prefetchable) [size=512]
        Region 3: Memory at ffa3b000 (32-bit, non-prefetchable) [size=256]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:1f.0 Class 0601: 8086:2641 (rev 04)
        Subsystem: 8086:2641
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:1f.1 Class 0101: 8086:266f (rev 04) (prog-if 8a [Master SecP PriP])
        Subsystem: 8086:266f
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 5
        Region 0: I/O ports at <unassigned>
        Region 1: I/O ports at <unassigned>
        Region 2: I/O ports at <unassigned>
        Region 3: I/O ports at <unassigned>
        Region 4: I/O ports at ffa0 [size=16]

00:1f.2 Class 0106: 8086:2653 (rev 04) (prog-if 01)
        Subsystem: 8086:2653
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin B routed to IRQ 11
        Region 0: I/O ports at e880 [size=8]
        Region 1: I/O ports at e800 [size=4]
        Region 2: I/O ports at e480 [size=8]
        Region 3: I/O ports at e400 [size=4]
        Region 4: I/O ports at e080 [size=16]
        Region 5: Memory at ffa3bc00 (32-bit, non-prefetchable) [size=1K]
        Capabilities: [70] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:1f.3 Class 0c05: 8086:266a (rev 04)
        Subsystem: 8086:266a
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin B routed to IRQ 5
        Region 4: I/O ports at 0400 [size=32]

01:08.0 Class 0200: 8086:1068 (rev 04)
        Subsystem: 8086:1094
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (2000ns min, 14000ns max), cache line size 10
        Interrupt: pin A routed to IRQ 5
        Region 0: Memory at ff7ff000 (32-bit, non-prefetchable) [size=4K]
        Region 1: I/O ports at cc00 [size=64]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=2 PME-

--
Mike Accetta

ECI Telecom Ltd.
Data Networking Division (previously Laurel Networks)
