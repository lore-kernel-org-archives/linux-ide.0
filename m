From: "Gaston, Jason D" <jason.d.gaston@intel.com>
Subject: ATAPI devices in AHCI mode not working
Date: Mon, 29 Oct 2007 11:14:13 -0700
Message-ID: <39B20DF628532344BC7A2692CB6AEE0701EA6E7D@orsmsx420.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:36771 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752696AbXJ2SU5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 29 Oct 2007 14:20:57 -0400
Content-class: urn:content-classes:message
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hello,

On a Tolapai 2 port SATA controller, I am not able to mount ATAPI
drives.  The device shows up in /sys/block, but does not show up in
/proc/sxx. I am getting the following messages in dmesg.  ata1 is the
DVD drive.

Any ideas what the problem is?

Thanks,

Jason


...
libata version 3.00 loaded.
ahci 0000:00:1f.2: version 3.0
ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 19 (level, low) -> IRQ 19
ahci 0000:00:1f.2: AHCI 0001.0100 32 slots 2 ports 3 Gbps 0x3 impl SATA
mode
ahci 0000:00:1f.2: flags: 64bit ncq sntf ilck stag pm led clo pio slum
part 
PCI: Setting latency timer of device 0000:00:1f.2 to 64
scsi0 : ahci
scsi1 : ahci
ata1: SATA max UDMA/133 abar m1024@0xd9101000 port 0xd9101100 irq 216
ata2: SATA max UDMA/133 abar m1024@0xd9101000 port 0xd9101180 irq 216
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.00: ATAPI: TSSTcorpCD/DVDW SH-S183L, SB01, max UDMA/33, ATAPI AN
ata1.00: applying bridge limits
ata1.00: configured for UDMA/33
ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata2.00: ATA-7: WDC WD1600JS-61MHB1, 10.02E01, max UDMA/133
ata2.00: 312581808 sectors, multi 0: LBA48 
ata2.00: configured for UDMA/133
scsi 0:0:0:0: CD-ROM            TSSTcorp CD/DVDW SH-S183L SB01 PQ: 0
ANSI: 5
scsi 1:0:0:0: Direct-Access     ATA      WDC WD1600JS-61M 10.0 PQ: 0
ANSI: 5
sd 1:0:0:0: [sda] 312581808 512-byte hardware sectors (160042 MB)
sd 1:0:0:0: [sda] Write Protect is off
sd 1:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 1:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
sd 1:0:0:0: [sda] 312581808 512-byte hardware sectors (160042 MB)
sd 1:0:0:0: [sda] Write Protect is off
sd 1:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 1:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
 sda: sda1 sda2
sd 1:0:0:0: [sda] Attached SCSI disk
sr 0:0:0:0: Attached scsi generic sg0 type 5
sd 1:0:0:0: Attached scsi generic sg1 type 0
ACPI: Processor [CPU1] (supports 8 throttling states)
BIOS EDD facility v0.16 2004-Jun-25, 6 devices found
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata1.00: cmd a0/00:00:00:00:00/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
         res 40/00:03:00:00:00/00:00:00:00:00/a0 Emask 0x4 (timeout)
ata1.00: status: { DRDY }
ata1: soft resetting link
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.00: configured for UDMA/33
ata1: EH complete
sr0: scsi3-mmc drive: 32x/40x writer dvd-ram cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.20
sr 0:0:0:0: Attached scsi CD-ROM sr0
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata1.00: cmd a0/00:00:00:00:00/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
         res 40/00:03:00:00:00/00:00:00:00:00/a0 Emask 0x4 (timeout)
ata1.00: status: { DRDY }
ata1: soft resetting link
ata1: SATA link down (SStatus 11 SControl 300)
ata1: failed to recover some devices, retrying in 5 secs
ata1: hard resetting link
ata1: SATA link down (SStatus 0 SControl 300)
ata1: limiting SATA link speed to 1.5 Gbps
ata1.00: limiting speed to UDMA/33:PIO3
ata1: failed to recover some devices, retrying in 5 secs
ReiserFS: sda2: found reiserfs format "3.6" with standard journal
ReiserFS: sda2: using ordered data mode
ReiserFS: sda2: journal params: device sda2, size 8192, journal first
block 18, max trans len 1024, max batch 900, max commit age 30, max
trans age 30
ReiserFS: sda2: checking transaction log (sda2)
ReiserFS: sda2: Using r5 hash to sort names
ata1: hard resetting link
ata1: SATA link down (SStatus 0 SControl 310)
ata1.00: disabled
ata1: EH complete
sr 0:0:0:0: rejecting I/O to offline device
sr 0:0:0:0: rejecting I/O to offline device
ata1.00: detaching (SCSI 0:0:0:0)
Adding 2104472k swap on
/dev/disk/by-id/scsi-SATA_WDC_WD1600JS-61_WD-WCANMC345198-part1.
Priority:-1 extents:1 across:2104472k
...
