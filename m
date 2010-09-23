From: "George Spelvin" <linux@horizon.com>
Subject: PDC42819 porr performance: how to debug?
Date: 23 Sep 2010 05:10:18 -0400
Message-ID: <20100923091018.14139.qmail@science.horizon.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from science.horizon.com ([71.41.210.146]:54106 "HELO
	science.horizon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753673Ab0IWJKU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 23 Sep 2010 05:10:20 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux@horizon.com

I have an AM2 motherboard with onboard SB600 AHCI, connected to 10
identical 2 TB hard drives:
- 4 from the onboard SB600 (sd[abcd])
- 2 from the motherboard PDC42819 (sd[ef])
- 4 from a Si3132 PCIe card (sd[ghij])

I can copy (RAID resync, actually) from sda to sdc (or sdb to sdd)
at around 100 MB/s.
But copying sda to sde (or sdb to sdf) runs around 25-33 MB/s.
Copying to the Si3132 drices is also reasonably fast.

This is very annoying.  Same drives, same kernel, same driver (AHCI),
same queue depth (31), same write cache settings (on; I have a good UPS
and I'll take the risk while a resync is minimizing a different risk).

Same drive firmware version, even (Hitachi HDS722020ALA330, FwRev=JKAOA3EA).

The one difference I notice is the multicount setting:
/dev/sda: multcount     = 16 (on)
/dev/sdb: multcount     = 16 (on)
/dev/sdc: multcount     = 16 (on)
/dev/sdd: multcount     = 16 (on)
/dev/sde: multcount     =  0 (off)
/dev/sdf: multcount     =  0 (off)
/dev/sdg: multcount     =  0 (off)
/dev/sdh: multcount     =  0 (off)
/dev/sdi: multcount     = 16 (on)
/dev/sdj: multcount     = 16 (on)

"hdparm -m16 /dev/sde" gives me a rather threatening warning.
If I ignore it and force it anyway, the setting is accepted, but there's
no apparent speed difference. :-(

I can also *read* from all drives at 110 MB/s.  It's only writes that
differ.


Is there a good place to start debugging this?




Here's the lspci -nn output:
00:12.0 SATA controller [0106]: ATI Technologies Inc SB600 Non-Raid-5 SATA [1002:4380]
01:00.0 Mass storage controller [0180]: Silicon Image, Inc. SiI 3132 Serial ATA Raid II Controller [1095:3132] (rev 01)
02:00.0 Mass storage controller [0180]: Silicon Image, Inc. SiI 3132 Serial ATA Raid II Controller [1095:3132] (rev 01)
04:00.0 RAID bus controller [0104]: Promise Technology, Inc. PDC42819 [FastTrak TX2650/TX4650] [105a:3f20]


And the relevant boot messages:

libata version 3.00 loaded.

ahci 0000:00:12.0: version 3.0
ahci 0000:00:12.0: PCI INT A -> GSI 22 (level, low) -> IRQ 22
ahci 0000:00:12.0: MSI K9A2 Platinum: enabling 64bit DMA
ahci 0000:00:12.0: AHCI 0001.0100 32 slots 4 ports 3 Gbps 0xf impl SATA mode
ahci 0000:00:12.0: flags: 64bit ncq sntf ilck pm led clo pmp pio slum part ccc 
scsi0 : ahci
scsi1 : ahci
scsi2 : ahci
scsi3 : ahci
ata1: SATA max UDMA/133 irq_stat 0x00400040, connection status changed irq 22
ata2: SATA max UDMA/133 irq_stat 0x00400040, connection status changed irq 22
ata3: SATA max UDMA/133 irq_stat 0x00400000, PHY RDY changed irq 22
ata4: SATA max UDMA/133 abar m1024@0xfe5ff800 port 0xfe5ffa80 irq 22
ahci 0000:04:00.0: PDC42819 can only drive SATA devices with this driver
ahci 0000:04:00.0: PCI INT A -> GSI 17 (level, low) -> IRQ 17
ahci 0000:04:00.0: AHCI 0001.0100 32 slots 4 ports 3 Gbps 0xf impl RAID mode
ahci 0000:04:00.0: flags: 64bit ncq sntf ilck pm led clo pmp pio slum part ccc 
ahci 0000:04:00.0: setting latency timer to 64
scsi4 : ahci
scsi5 : ahci
scsi6 : ahci
scsi7 : ahci
ata5: SATA max UDMA/133 abar m8192@0xfe9fc000 port 0xfe9fc100 irq 17
ata6: SATA max UDMA/133 abar m8192@0xfe9fc000 port 0xfe9fc180 irq 17
ata7: SATA max UDMA/133 abar m8192@0xfe9fc000 port 0xfe9fc200 irq 17
ata8: SATA max UDMA/133 abar m8192@0xfe9fc000 port 0xfe9fc280 irq 17
sata_sil24 0000:01:00.0: version 1.1
sata_sil24 0000:01:00.0: PCI INT A -> GSI 19 (level, low) -> IRQ 19
sata_sil24 0000:01:00.0: setting latency timer to 64
scsi8 : sata_sil24
scsi9 : sata_sil24
ata9: SATA max UDMA/100 host m128@0xfe6ffc00 port 0xfe6f8000 irq 19
ata10: SATA max UDMA/100 host m128@0xfe6ffc00 port 0xfe6fa000 irq 19
sata_sil24 0000:02:00.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
sata_sil24 0000:02:00.0: setting latency timer to 64
scsi10 : sata_sil24
scsi11 : sata_sil24
ata11: SATA max UDMA/100 host m128@0xfe7ffc00 port 0xfe7f8000 irq 16
ata12: SATA max UDMA/100 host m128@0xfe7ffc00 port 0xfe7fa000 irq 16

ata8: SATA link down (SStatus 0 SControl 300)
ata7: SATA link down (SStatus 0 SControl 300)

ata6: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata6.00: ATA-8: Hitachi HDS722020ALA330, JKAOA3EA, max UDMA/133
ata6.00: 3907029168 sectors, multi 0: LBA48 NCQ (depth 31/32), AA
ata6.00: configured for UDMA/133
ata5: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata5.00: ATA-8: Hitachi HDS722020ALA330, JKAOA3EA, max UDMA/133
ata5.00: 3907029168 sectors, multi 0: LBA48 NCQ (depth 31/32), AA
ata5.00: configured for UDMA/133
ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata4.00: ATA-8: Hitachi HDS722020ALA330, JKAOA3EA, max UDMA/133
ata4.00: 3907029168 sectors, multi 16: LBA48 NCQ (depth 31/32), AA
ata4.00: SB600 AHCI: limiting to 255 sectors per cmd
ata4.00: SB600 AHCI: limiting to 255 sectors per cmd
ata4.00: configured for UDMA/133
ata2: softreset failed (device not ready)
ata3: softreset failed (device not ready)
ata3: applying SB600 PMP SRST workaround and retrying
ata1: softreset failed (device not ready)
ata1: applying SB600 PMP SRST workaround and retrying
ata2: applying SB600 PMP SRST workaround and retrying
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata3.00: ATA-8: Hitachi HDS722020ALA330, JKAOA3EA, max UDMA/133
ata3.00: 3907029168 sectors, multi 16: LBA48 NCQ (depth 31/32), AA
ata3.00: SB600 AHCI: limiting to 255 sectors per cmd
ata3.00: configured for UDMA/133
ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata2.00: ATA-8: Hitachi HDS722020ALA330, JKAOA3EA, max UDMA/133
ata2.00: 3907029168 sectors, multi 16: LBA48 NCQ (depth 31/32), AA
ata2.00: SB600 AHCI: limiting to 255 sectors per cmd
ata2.00: SB600 AHCI: limiting to 255 sectors per cmd
ata2.00: configured for UDMA/133
ata1.00: ATA-8: Hitachi HDS722020ALA330, JKAOA3EA, max UDMA/133
ata1.00: 3907029168 sectors, multi 16: LBA48 NCQ (depth 31/32), AA
ata1.00: SB600 AHCI: limiting to 255 sectors per cmd
ata1.00: SB600 AHCI: limiting to 255 sectors per cmd
ata1.00: configured for UDMA/133
scsi 0:0:0:0: Direct-Access     ATA      Hitachi HDS72202 JKAO PQ: 0 ANSI: 5
sd 0:0:0:0: [sda] 3907029168 512-byte logical blocks: (2.00 TB/1.81 TiB)
scsi 1:0:0:0: Direct-Access     ATA      Hitachi HDS72202 JKAO PQ: 0 ANSI: 5
sd 1:0:0:0: [sdb] 3907029168 512-byte logical blocks: (2.00 TB/1.81 TiB)
scsi 2:0:0:0: Direct-Access     ATA      Hitachi HDS72202 JKAO PQ: 0 ANSI: 5
sd 1:0:0:0: [sdb] Write Protect is off
sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 10
sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, supports DPO and FUA
sd 2:0:0:0: [sdc] 3907029168 512-byte logical blocks: (2.00 TB/1.81 TiB)
sd 2:0:0:0: [sdc] Write Protect is off
sd 2:0:0:0: [sdc] Mode Sense: 00 3a 00 10
sd 2:0:0:0: [sdc] Write cache: enabled, read cache: enabled, supports DPO and FUA
scsi 3:0:0:0: Direct-Access     ATA      Hitachi HDS72202 JKAO PQ: 0 ANSI: 5
sd 3:0:0:0: [sdd] 3907029168 512-byte logical blocks: (2.00 TB/1.81 TiB)
scsi 4:0:0:0: Direct-Access     ATA      Hitachi HDS72202 JKAO PQ: 0 ANSI: 5
sd 3:0:0:0: [sdd] Write Protect is off
sd 3:0:0:0: [sdd] Mode Sense: 00 3a 00 10
sd 3:0:0:0: [sdd] Write cache: enabled, read cache: enabled, supports DPO and FUA
sd 4:0:0:0: [sde] 3907029168 512-byte logical blocks: (2.00 TB/1.81 TiB)
sd 4:0:0:0: [sde] Write Protect is off
sd 4:0:0:0: [sde] Mode Sense: 00 3a 00 10
scsi 5:0:0:0: Direct-Access     ATA      Hitachi HDS72202 JKAO PQ: 0 ANSI: 5
sd 4:0:0:0: [sde] Write cache: enabled, read cache: enabled, supports DPO and FUA
sd 5:0:0:0: [sdf] 3907029168 512-byte logical blocks: (2.00 TB/1.81 TiB)
sd 5:0:0:0: [sdf] Write Protect is off
sd 5:0:0:0: [sdf] Mode Sense: 00 3a 00 10
sd 5:0:0:0: [sdf] Write cache: enabled, read cache: enabled, supports DPO and FUA
 sdc: sdc1 sdc2 sdc3 sdc4
 sdd: sdd1 sdd2 sdd3 sdd4
 sdb: sdb1 sdb2 sdb3 sdb4
 sde: sde1 sde2 sde3 sde4
 sdf: sdf1 sdf2 sdf3 sdf4
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 10
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, supports DPO and FUA
sd 2:0:0:0: [sdc] Attached SCSI disk
sd 1:0:0:0: [sdb] Attached SCSI disk
sd 3:0:0:0: [sdd] Attached SCSI disk
sd 5:0:0:0: [sdf] Attached SCSI disk
sd 4:0:0:0: [sde] Attached SCSI disk
 sda: sda1 sda2 sda3 sda4
sd 0:0:0:0: [sda] Attached SCSI disk
ata9: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
ata9.00: ATA-8: Hitachi HDS722020ALA330, JKAOA3EA, max UDMA/133
ata9.00: 3907029168 sectors, multi 0: LBA48 NCQ (depth 31/32)
ata11: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
ata9.00: configured for UDMA/100
scsi 8:0:0:0: Direct-Access     ATA      Hitachi HDS72202 JKAO PQ: 0 ANSI: 5
sd 8:0:0:0: [sdg] 3907029168 512-byte logical blocks: (2.00 TB/1.81 TiB)
sd 8:0:0:0: [sdg] Write Protect is off
sd 8:0:0:0: [sdg] Mode Sense: 00 3a 00 10
sd 8:0:0:0: [sdg] Write cache: enabled, read cache: enabled, supports DPO and FUA
ata11.00: ATA-8: Hitachi HDS722020ALA330, JKAOA3EA, max UDMA/133
ata11.00: 3907029168 sectors, multi 16: LBA48 NCQ (depth 31/32)
 sdg: sdg1 sdg2 sdg3 sdg4
sd 8:0:0:0: [sdg] Attached SCSI disk
ata11.00: configured for UDMA/100
ata10: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
ata10.00: ATA-8: Hitachi HDS722020ALA330, JKAOA3EA, max UDMA/133
ata10.00: 3907029168 sectors, multi 0: LBA48 NCQ (depth 31/32)
ata10.00: configured for UDMA/100
scsi 9:0:0:0: Direct-Access     ATA      Hitachi HDS72202 JKAO PQ: 0 ANSI: 5
sd 9:0:0:0: [sdh] 3907029168 512-byte logical blocks: (2.00 TB/1.81 TiB)
scsi 10:0:0:0: Direct-Access     ATA      Hitachi HDS72202 JKAO PQ: 0 ANSI: 5
sd 10:0:0:0: [sdi] 3907029168 512-byte logical blocks: (2.00 TB/1.81 TiB)
sd 10:0:0:0: [sdi] Write Protect is off
sd 10:0:0:0: [sdi] Mode Sense: 00 3a 00 10
sd 10:0:0:0: [sdi] Write cache: enabled, read cache: enabled, supports DPO and FUA
 sdi: sdi1 sdi2 sdi3 sdi4
sd 9:0:0:0: [sdh] Write Protect is off
sd 10:0:0:0: [sdi] Attached SCSI disk
sd 9:0:0:0: [sdh] Mode Sense: 00 3a 00 10
sd 9:0:0:0: [sdh] Write cache: enabled, read cache: enabled, supports DPO and FUA
 sdh: sdh1 sdh2 sdh3 sdh4
sd 9:0:0:0: [sdh] Attached SCSI disk
ata12: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
ata12.00: ATA-8: Hitachi HDS722020ALA330, JKAOA3EA, max UDMA/133
ata12.00: 3907029168 sectors, multi 16: LBA48 NCQ (depth 31/32)
ata12.00: configured for UDMA/100
scsi 11:0:0:0: Direct-Access     ATA      Hitachi HDS72202 JKAO PQ: 0 ANSI: 5
sd 11:0:0:0: [sdj] 3907029168 512-byte logical blocks: (2.00 TB/1.81 TiB)
sd 11:0:0:0: [sdj] Write Protect is off
sd 11:0:0:0: [sdj] Mode Sense: 00 3a 00 10
sd 11:0:0:0: [sdj] Write cache: enabled, read cache: enabled, supports DPO and FUA
 sdj: sdj1 sdj2 sdj3 sdj4
sd 11:0:0:0: [sdj] Attached SCSI disk
