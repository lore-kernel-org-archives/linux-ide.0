From: "dusty@gmx.li" <dusty@gmx.li>
Subject: libata pm
Date: Sat, 26 Jan 2008 18:03:20 -0000 (UTC)
Message-ID: <52279.82.140.50.2.1201370600.squirrel@ssl.cavemail.org>
Reply-To: dusty@gmx.li
Mime-Version: 1.0
Content-Type: multipart/mixed;boundary="----=_20080126180320_57157"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cavemail.org ([62.75.189.85]:37172 "EHLO mail.cavemail.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751256AbYAZSe5 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 26 Jan 2008 13:34:57 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: htejun@gmail.com
Cc: linux-ide@vger.kernel.org

------=_20080126180320_57157
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

I'm currently running

Linux *** 2.6.23 #1 SMP PREEMPT Sat Jan 26 17:59:58 CET 2008 x86_64
Intel(R) Pentium(R) D CPU 3.20GHz GenuineIntel GNU/Linux
with the libata-tj-2.6.23-20071011 path for 2.6.23

and for testing purposes

linux-2.6.24-rc6-mm1


on a Asus P5WDG2-WS with two PCI-X Dawicontrol DC 4300 Controllers and two
Dawicontrol DC 6510 PM port multipliers to get 16 sata ports. (the linux
partition is on a ide drive)

the second raid array with 8 Samsung HD-LJ 501 works great without any
errors. but the first raid with 8 Maxtor 6V300F0 produces one error after
another after mounting the filesystem:

Filesystem "dm-0": Disabling barriers, not supported by the underlying device
XFS mounting filesystem dm-0
Ending clean XFS mount for filesystem: dm-0
Filesystem "dm-1": Disabling barriers, not supported by the underlying device
XFS mounting filesystem dm-1
Ending clean XFS mount for filesystem: dm-1
ata6.04: exception Emask 0x10 SAct 0x0 SErr 0x4010000 action 0xb
ata6: SError: { PHYRdyChg DevExch }
ata6.04: hard resetting link
ata6.04: SATA link down (SStatus 0 SControl 300)
ata6: failed to recover some devices, retrying in 5 secs
ata6.04: hard resetting link
ata6.04: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata6.04: configured for UDMA/100
ata6: EH complete
sd 5:0:0:0: [sdh] 586114704 512-byte hardware sectors (300091 MB)
sd 5:0:0:0: [sdh] Write Protect is off
sd 5:0:0:0: [sdh] Mode Sense: 00 3a 00 00
sd 5:0:0:0: [sdh] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
sd 5:1:0:0: [sdi] 586114704 512-byte hardware sectors (300091 MB)
sd 5:1:0:0: [sdi] Write Protect is off
sd 5:1:0:0: [sdi] Mode Sense: 00 3a 00 00
sd 5:1:0:0: [sdi] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
sd 5:2:0:0: [sdj] 586114704 512-byte hardware sectors (300091 MB)
sd 5:2:0:0: [sdj] Write Protect is off
sd 5:2:0:0: [sdj] Mode Sense: 00 3a 00 00
sd 5:2:0:0: [sdj] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
sd 5:3:0:0: [sdk] 586114704 512-byte hardware sectors (300091 MB)
sd 5:3:0:0: [sdk] Write Protect is off
sd 5:3:0:0: [sdk] Mode Sense: 00 3a 00 00
sd 5:3:0:0: [sdk] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
sd 5:4:0:0: [sdl] 586114704 512-byte hardware sectors (300091 MB)
sd 5:4:0:0: [sdl] Write Protect is off
sd 5:4:0:0: [sdl] Mode Sense: 00 3a 00 00
sd 5:4:0:0: [sdl] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
ata6.00: failed to read SCR 1 (Emask=0x40)
ata6.01: failed to read SCR 1 (Emask=0x40)
ata6.02: failed to read SCR 1 (Emask=0x40)
ata6.03: failed to read SCR 1 (Emask=0x40)
ata6.04: failed to read SCR 1 (Emask=0x40)
ata6.05: failed to read SCR 1 (Emask=0x40)
ata6.00: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata6.01: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata6.01: cmd c8/00:10:97:26:00/00:00:00:00:00/e0 tag 0 cdb 0x0 data 8192 in
         res 50/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata6.01: status: { DRDY }
ata6.02: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata6.03: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata6.04: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata6.05: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata6.15: hard resetting link
ata6.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
ata6.00: hard resetting link
ata6.00: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata6.01: hard resetting link
ata6.01: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata6.02: hard resetting link
ata6.02: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata6.03: hard resetting link
ata6.03: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata6.04: hard resetting link
ata6.04: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata6.05: hard resetting link
ata6.05: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata6.00: configured for UDMA/100
ata6.01: configured for UDMA/100
ata6.02: configured for UDMA/100
ata6.03: configured for UDMA/100
ata6.04: configured for UDMA/100
ata6: EH complete
sd 5:0:0:0: [sdh] 586114704 512-byte hardware sectors (300091 MB)
sd 5:0:0:0: [sdh] Write Protect is off
sd 5:0:0:0: [sdh] Mode Sense: 00 3a 00 00
sd 5:0:0:0: [sdh] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
sd 5:1:0:0: [sdi] 586114704 512-byte hardware sectors (300091 MB)
sd 5:1:0:0: [sdi] Write Protect is off
sd 5:1:0:0: [sdi] Mode Sense: 00 3a 00 00
sd 5:1:0:0: [sdi] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
sd 5:2:0:0: [sdj] 586114704 512-byte hardware sectors (300091 MB)
sd 5:2:0:0: [sdj] Write Protect is off
sd 5:2:0:0: [sdj] Mode Sense: 00 3a 00 00
sd 5:2:0:0: [sdj] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
sd 5:3:0:0: [sdk] 586114704 512-byte hardware sectors (300091 MB)
sd 5:3:0:0: [sdk] Write Protect is off
sd 5:3:0:0: [sdk] Mode Sense: 00 3a 00 00
sd 5:3:0:0: [sdk] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
sd 5:4:0:0: [sdl] 586114704 512-byte hardware sectors (300091 MB)
sd 5:4:0:0: [sdl] Write Protect is off
sd 5:4:0:0: [sdl] Mode Sense: 00 3a 00 00
sd 5:4:0:0: [sdl] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
sd 5:0:0:0: [sdh] 586114704 512-byte hardware sectors (300091 MB)
sd 5:0:0:0: [sdh] Write Protect is off
sd 5:0:0:0: [sdh] Mode Sense: 00 3a 00 00
sd 5:0:0:0: [sdh] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
sd 5:1:0:0: [sdi] 586114704 512-byte hardware sectors (300091 MB)
sd 5:1:0:0: [sdi] Write Protect is off
sd 5:1:0:0: [sdi] Mode Sense: 00 3a 00 00
sd 5:1:0:0: [sdi] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
sd 5:2:0:0: [sdj] 586114704 512-byte hardware sectors (300091 MB)
sd 5:2:0:0: [sdj] Write Protect is off
sd 5:2:0:0: [sdj] Mode Sense: 00 3a 00 00
sd 5:2:0:0: [sdj] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
sd 5:3:0:0: [sdk] 586114704 512-byte hardware sectors (300091 MB)
sd 5:3:0:0: [sdk] Write Protect is off
sd 5:3:0:0: [sdk] Mode Sense: 00 3a 00 00
sd 5:3:0:0: [sdk] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
sd 5:4:0:0: [sdl] 586114704 512-byte hardware sectors (300091 MB)
sd 5:4:0:0: [sdl] Write Protect is off
sd 5:4:0:0: [sdl] Mode Sense: 00 3a 00 00
sd 5:4:0:0: [sdl] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA



these messages repeat themself for hours...

attached to this message is th dmesg output and hdparam -i for all devices
------=_20080126180320_57157
Content-Type: text/plain; name="dmesg.txt"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="dmesg.txt"

sata_sil24 0000:05:01.0: version 1.1
ACPI: PCI Interrupt 0000:05:01.0[A] -> GSI 24 (level, low) -> IRQ 24
sata_sil24 0000:05:01.0: Applying completion IRQ loss on PCI-X errata fix
scsi2 : sata_sil24
scsi3 : sata_sil24
scsi4 : sata_sil24
scsi5 : sata_sil24
ata3: SATA max UDMA/100 host m128@0xfeaffc00 port 0xfeaf0000 irq 24
ata4: SATA max UDMA/100 host m128@0xfeaffc00 port 0xfeaf2000 irq 24
ata5: SATA max UDMA/100 host m128@0xfeaffc00 port 0xfeaf4000 irq 24
ata6: SATA max UDMA/100 host m128@0xfeaffc00 port 0xfeaf6000 irq 24
ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
ata3.00: ATA-7: Maxtor 6V300F0, VA111630, max UDMA/133
ata3.00: 586114704 sectors, multi 16: LBA48 NCQ (not used)
ata3.00: configured for UDMA/100
ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
ata4.00: ATA-7: Maxtor 6V300F0, VA111630, max UDMA/133
ata4.00: 586114704 sectors, multi 16: LBA48 NCQ (not used)
ata4.00: configured for UDMA/100
ata5: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
ata5.00: ATA-7: Maxtor 6V300F0, VA111630, max UDMA/133
ata5.00: 586114704 sectors, multi 16: LBA48 NCQ (not used)
ata5.00: configured for UDMA/100
ata6: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
ata6.15: Port Multiplier 1.1, 0x1095:0x3726 r23, 6 ports, feat 0x1/0x9
ata6.00: hard resetting link
ata6.00: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata6.01: hard resetting link
ata6.01: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata6.02: hard resetting link
ata6.02: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata6.03: hard resetting link
ata6.03: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata6.04: hard resetting link
ata6.04: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata6.05: hard resetting link
ata6.05: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata6.00: ATA-7: Maxtor 6V300F0, VA111630, max UDMA/133
ata6.00: 586114704 sectors, multi 16: LBA48 NCQ (not used)
ata6.00: configured for UDMA/100
ata6.01: ATA-7: Maxtor 6V300F0, VA111630, max UDMA/133
ata6.01: 586114704 sectors, multi 0: LBA48 NCQ (not used)
ata6.01: configured for UDMA/100
ata6.02: ATA-7: Maxtor 6V300F0, VA111630, max UDMA/133
ata6.02: 586114704 sectors, multi 0: LBA48 NCQ (not used)
ata6.02: configured for UDMA/100
ata6.03: ATA-7: Maxtor 6V300F0, VA111630, max UDMA/133
ata6.03: 586114704 sectors, multi 0: LBA48 NCQ (not used)
ata6.03: configured for UDMA/100
ata6.04: ATA-7: Maxtor 6V300F0, VA111630, max UDMA/133
ata6.04: 586114704 sectors, multi 0: LBA48 NCQ (not used)
ata6.04: configured for UDMA/100
ata6: EH complete
scsi 2:0:0:0: Direct-Access     ATA      Maxtor 6V300F0   VA11 PQ: 0 ANSI: 5
sd 2:0:0:0: [sde] 586114704 512-byte hardware sectors (300091 MB)
sd 2:0:0:0: [sde] Write Protect is off
sd 2:0:0:0: [sde] Mode Sense: 00 3a 00 00
sd 2:0:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 2:0:0:0: [sde] 586114704 512-byte hardware sectors (300091 MB)
sd 2:0:0:0: [sde] Write Protect is off
sd 2:0:0:0: [sde] Mode Sense: 00 3a 00 00
sd 2:0:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sde: sde1
sd 2:0:0:0: [sde] Attached SCSI disk
sd 2:0:0:0: Attached scsi generic sg4 type 0
scsi 3:0:0:0: Direct-Access     ATA      Maxtor 6V300F0   VA11 PQ: 0 ANSI: 5
sd 3:0:0:0: [sdf] 586114704 512-byte hardware sectors (300091 MB)
sd 3:0:0:0: [sdf] Write Protect is off
sd 3:0:0:0: [sdf] Mode Sense: 00 3a 00 00
sd 3:0:0:0: [sdf] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 3:0:0:0: [sdf] 586114704 512-byte hardware sectors (300091 MB)
sd 3:0:0:0: [sdf] Write Protect is off
sd 3:0:0:0: [sdf] Mode Sense: 00 3a 00 00
sd 3:0:0:0: [sdf] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sdf: sdf1
sd 3:0:0:0: [sdf] Attached SCSI disk
sd 3:0:0:0: Attached scsi generic sg5 type 0
scsi 4:0:0:0: Direct-Access     ATA      Maxtor 6V300F0   VA11 PQ: 0 ANSI: 5
sd 4:0:0:0: [sdg] 586114704 512-byte hardware sectors (300091 MB)
sd 4:0:0:0: [sdg] Write Protect is off
sd 4:0:0:0: [sdg] Mode Sense: 00 3a 00 00
sd 4:0:0:0: [sdg] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 4:0:0:0: [sdg] 586114704 512-byte hardware sectors (300091 MB)
sd 4:0:0:0: [sdg] Write Protect is off
sd 4:0:0:0: [sdg] Mode Sense: 00 3a 00 00
sd 4:0:0:0: [sdg] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sdg: sdg1
sd 4:0:0:0: [sdg] Attached SCSI disk
sd 4:0:0:0: Attached scsi generic sg6 type 0
scsi 5:0:0:0: Direct-Access     ATA      Maxtor 6V300F0   VA11 PQ: 0 ANSI: 5
sd 5:0:0:0: [sdh] 586114704 512-byte hardware sectors (300091 MB)
sd 5:0:0:0: [sdh] Write Protect is off
sd 5:0:0:0: [sdh] Mode Sense: 00 3a 00 00
sd 5:0:0:0: [sdh] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 5:0:0:0: [sdh] 586114704 512-byte hardware sectors (300091 MB)
sd 5:0:0:0: [sdh] Write Protect is off
sd 5:0:0:0: [sdh] Mode Sense: 00 3a 00 00
sd 5:0:0:0: [sdh] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sdh: sdh1
sd 5:0:0:0: [sdh] Attached SCSI disk
sd 5:0:0:0: Attached scsi generic sg7 type 0
scsi 5:1:0:0: Direct-Access     ATA      Maxtor 6V300F0   VA11 PQ: 0 ANSI: 5
sd 5:1:0:0: [sdi] 586114704 512-byte hardware sectors (300091 MB)
sd 5:1:0:0: [sdi] Write Protect is off
sd 5:1:0:0: [sdi] Mode Sense: 00 3a 00 00
sd 5:1:0:0: [sdi] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 5:1:0:0: [sdi] 586114704 512-byte hardware sectors (300091 MB)
sd 5:1:0:0: [sdi] Write Protect is off
sd 5:1:0:0: [sdi] Mode Sense: 00 3a 00 00
sd 5:1:0:0: [sdi] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sdi: sdi1
sd 5:1:0:0: [sdi] Attached SCSI disk
sd 5:1:0:0: Attached scsi generic sg8 type 0
scsi 5:2:0:0: Direct-Access     ATA      Maxtor 6V300F0   VA11 PQ: 0 ANSI: 5
sd 5:2:0:0: [sdj] 586114704 512-byte hardware sectors (300091 MB)
sd 5:2:0:0: [sdj] Write Protect is off
sd 5:2:0:0: [sdj] Mode Sense: 00 3a 00 00
sd 5:2:0:0: [sdj] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 5:2:0:0: [sdj] 586114704 512-byte hardware sectors (300091 MB)
sd 5:2:0:0: [sdj] Write Protect is off
sd 5:2:0:0: [sdj] Mode Sense: 00 3a 00 00
sd 5:2:0:0: [sdj] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sdj: sdj1
sd 5:2:0:0: [sdj] Attached SCSI disk
sd 5:2:0:0: Attached scsi generic sg9 type 0
scsi 5:3:0:0: Direct-Access     ATA      Maxtor 6V300F0   VA11 PQ: 0 ANSI: 5
sd 5:3:0:0: [sdk] 586114704 512-byte hardware sectors (300091 MB)
sd 5:3:0:0: [sdk] Write Protect is off
sd 5:3:0:0: [sdk] Mode Sense: 00 3a 00 00
sd 5:3:0:0: [sdk] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 5:3:0:0: [sdk] 586114704 512-byte hardware sectors (300091 MB)
sd 5:3:0:0: [sdk] Write Protect is off
sd 5:3:0:0: [sdk] Mode Sense: 00 3a 00 00
sd 5:3:0:0: [sdk] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sdk: sdk1
sd 5:3:0:0: [sdk] Attached SCSI disk
sd 5:3:0:0: Attached scsi generic sg10 type 0
scsi 5:4:0:0: Direct-Access     ATA      Maxtor 6V300F0   VA11 PQ: 0 ANSI: 5
sd 5:4:0:0: [sdl] 586114704 512-byte hardware sectors (300091 MB)
sd 5:4:0:0: [sdl] Write Protect is off
sd 5:4:0:0: [sdl] Mode Sense: 00 3a 00 00
sd 5:4:0:0: [sdl] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 5:4:0:0: [sdl] 586114704 512-byte hardware sectors (300091 MB)
sd 5:4:0:0: [sdl] Write Protect is off
sd 5:4:0:0: [sdl] Mode Sense: 00 3a 00 00
sd 5:4:0:0: [sdl] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sdl: sdl1
sd 5:4:0:0: [sdl] Attached SCSI disk
sd 5:4:0:0: Attached scsi generic sg11 type 0
ACPI: PCI Interrupt 0000:05:02.0[A] -> GSI 28 (level, low) -> IRQ 28
sata_sil24 0000:05:02.0: Applying completion IRQ loss on PCI-X errata fix
scsi6 : sata_sil24
scsi7 : sata_sil24
scsi8 : sata_sil24
scsi9 : sata_sil24
ata7: SATA max UDMA/100 host m128@0xfeaff800 port 0xfeae8000 irq 28
ata8: SATA max UDMA/100 host m128@0xfeaff800 port 0xfeaea000 irq 28
ata9: SATA max UDMA/100 host m128@0xfeaff800 port 0xfeaec000 irq 28
ata10: SATA max UDMA/100 host m128@0xfeaff800 port 0xfeaee000 irq 28
ata6.04: exception Emask 0x10 SAct 0x0 SErr 0x4010000 action 0xb
ata6: SError: { PHYRdyChg DevExch }
ata6.04: hard resetting link
ata6.04: SATA link down (SStatus 0 SControl 300)
ata6: failed to recover some devices, retrying in 5 secs
ata7: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
ata7.00: ATA-8: SAMSUNG HD501LJ, CR100-10, max UDMA7
ata7.00: 976773168 sectors, multi 16: LBA48 NCQ (depth 31/32)
ata7.00: configured for UDMA/100
ata8: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
ata8.00: ATA-8: SAMSUNG HD501LJ, CR100-10, max UDMA7
ata8.00: 976773168 sectors, multi 16: LBA48 NCQ (depth 31/32)
ata8.00: configured for UDMA/100
ata6.04: hard resetting link
ata6.04: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata6.04: configured for UDMA/100
ata6: EH complete
sd 5:0:0:0: [sdh] 586114704 512-byte hardware sectors (300091 MB)
sd 5:0:0:0: [sdh] Write Protect is off
sd 5:0:0:0: [sdh] Mode Sense: 00 3a 00 00
sd 5:0:0:0: [sdh] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 5:1:0:0: [sdi] 586114704 512-byte hardware sectors (300091 MB)
sd 5:1:0:0: [sdi] Write Protect is off
sd 5:1:0:0: [sdi] Mode Sense: 00 3a 00 00
sd 5:1:0:0: [sdi] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 5:2:0:0: [sdj] 586114704 512-byte hardware sectors (300091 MB)
sd 5:2:0:0: [sdj] Write Protect is off
sd 5:2:0:0: [sdj] Mode Sense: 00 3a 00 00
sd 5:2:0:0: [sdj] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 5:3:0:0: [sdk] 586114704 512-byte hardware sectors (300091 MB)
sd 5:3:0:0: [sdk] Write Protect is off
sd 5:3:0:0: [sdk] Mode Sense: 00 3a 00 00
sd 5:3:0:0: [sdk] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 5:4:0:0: [sdl] 586114704 512-byte hardware sectors (300091 MB)
sd 5:4:0:0: [sdl] Write Protect is off
sd 5:4:0:0: [sdl] Mode Sense: 00 3a 00 00
sd 5:4:0:0: [sdl] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
ata9: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
ata9.00: ATA-8: SAMSUNG HD501LJ, CR100-10, max UDMA7
ata9.00: 976773168 sectors, multi 16: LBA48 NCQ (depth 31/32)
ata9.00: configured for UDMA/100
ata10: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
ata10.15: Port Multiplier 1.1, 0x1095:0x3726 r23, 6 ports, feat 0x1/0x9
ata10.00: hard resetting link
ata10.00: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata10.01: hard resetting link
ata10.01: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata10.02: hard resetting link
ata10.02: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata10.03: hard resetting link
ata10.03: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata10.04: hard resetting link
ata10.04: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata10.05: hard resetting link
ata10.05: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata10.00: ATA-8: SAMSUNG HD501LJ, CR100-10, max UDMA7
ata10.00: 976773168 sectors, multi 16: LBA48 NCQ (depth 31/32)
ata10.00: configured for UDMA/100
ata10.01: ATA-8: SAMSUNG HD501LJ, CR100-10, max UDMA7
ata10.01: 976773168 sectors, multi 0: LBA48 NCQ (depth 31/32)
ata10.01: configured for UDMA/100
ata10.02: ATA-8: SAMSUNG HD501LJ, CR100-11, max UDMA7
ata10.02: 976773168 sectors, multi 0: LBA48 NCQ (depth 31/32)
ata10.02: configured for UDMA/100
ata10.03: ATA-8: SAMSUNG HD501LJ, CR100-11, max UDMA7
ata10.03: 976773168 sectors, multi 0: LBA48 NCQ (depth 31/32)
ata10.03: configured for UDMA/100
ata10.04: ATA-8: SAMSUNG HD501LJ, CR100-11, max UDMA7
ata10.04: 976773168 sectors, multi 0: LBA48 NCQ (depth 31/32)
ata10.04: configured for UDMA/100
ata10: EH complete
scsi 6:0:0:0: Direct-Access     ATA      SAMSUNG HD501LJ  CR10 PQ: 0 ANSI: 5
sd 6:0:0:0: [sdm] 976773168 512-byte hardware sectors (500108 MB)
sd 6:0:0:0: [sdm] Write Protect is off
sd 6:0:0:0: [sdm] Mode Sense: 00 3a 00 00
sd 6:0:0:0: [sdm] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 6:0:0:0: [sdm] 976773168 512-byte hardware sectors (500108 MB)
sd 6:0:0:0: [sdm] Write Protect is off
sd 6:0:0:0: [sdm] Mode Sense: 00 3a 00 00
sd 6:0:0:0: [sdm] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sdm: sdm1
sd 6:0:0:0: [sdm] Attached SCSI disk
sd 6:0:0:0: Attached scsi generic sg12 type 0
scsi 7:0:0:0: Direct-Access     ATA      SAMSUNG HD501LJ  CR10 PQ: 0 ANSI: 5
sd 7:0:0:0: [sdn] 976773168 512-byte hardware sectors (500108 MB)
sd 7:0:0:0: [sdn] Write Protect is off
sd 7:0:0:0: [sdn] Mode Sense: 00 3a 00 00
sd 7:0:0:0: [sdn] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 7:0:0:0: [sdn] 976773168 512-byte hardware sectors (500108 MB)
sd 7:0:0:0: [sdn] Write Protect is off
sd 7:0:0:0: [sdn] Mode Sense: 00 3a 00 00
sd 7:0:0:0: [sdn] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sdn: sdn1
sd 7:0:0:0: [sdn] Attached SCSI disk
sd 7:0:0:0: Attached scsi generic sg13 type 0
scsi 8:0:0:0: Direct-Access     ATA      SAMSUNG HD501LJ  CR10 PQ: 0 ANSI: 5
sd 8:0:0:0: [sdo] 976773168 512-byte hardware sectors (500108 MB)
sd 8:0:0:0: [sdo] Write Protect is off
sd 8:0:0:0: [sdo] Mode Sense: 00 3a 00 00
sd 8:0:0:0: [sdo] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 8:0:0:0: [sdo] 976773168 512-byte hardware sectors (500108 MB)
sd 8:0:0:0: [sdo] Write Protect is off
sd 8:0:0:0: [sdo] Mode Sense: 00 3a 00 00
sd 8:0:0:0: [sdo] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sdo: sdo1
sd 8:0:0:0: [sdo] Attached SCSI disk
sd 8:0:0:0: Attached scsi generic sg14 type 0
scsi 9:0:0:0: Direct-Access     ATA      SAMSUNG HD501LJ  CR10 PQ: 0 ANSI: 5
sd 9:0:0:0: [sdp] 976773168 512-byte hardware sectors (500108 MB)
sd 9:0:0:0: [sdp] Write Protect is off
sd 9:0:0:0: [sdp] Mode Sense: 00 3a 00 00
sd 9:0:0:0: [sdp] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 9:0:0:0: [sdp] 976773168 512-byte hardware sectors (500108 MB)
sd 9:0:0:0: [sdp] Write Protect is off
sd 9:0:0:0: [sdp] Mode Sense: 00 3a 00 00
sd 9:0:0:0: [sdp] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sdp: sdp1
sd 9:0:0:0: [sdp] Attached SCSI disk
sd 9:0:0:0: Attached scsi generic sg15 type 0
scsi 9:1:0:0: Direct-Access     ATA      SAMSUNG HD501LJ  CR10 PQ: 0 ANSI: 5
sd 9:1:0:0: [sdq] 976773168 512-byte hardware sectors (500108 MB)
sd 9:1:0:0: [sdq] Write Protect is off
sd 9:1:0:0: [sdq] Mode Sense: 00 3a 00 00
sd 9:1:0:0: [sdq] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 9:1:0:0: [sdq] 976773168 512-byte hardware sectors (500108 MB)
sd 9:1:0:0: [sdq] Write Protect is off
sd 9:1:0:0: [sdq] Mode Sense: 00 3a 00 00
sd 9:1:0:0: [sdq] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sdq: sdq1
sd 9:1:0:0: [sdq] Attached SCSI disk
sd 9:1:0:0: Attached scsi generic sg16 type 0
scsi 9:2:0:0: Direct-Access     ATA      SAMSUNG HD501LJ  CR10 PQ: 0 ANSI: 5
sd 9:2:0:0: [sdr] 976773168 512-byte hardware sectors (500108 MB)
sd 9:2:0:0: [sdr] Write Protect is off
sd 9:2:0:0: [sdr] Mode Sense: 00 3a 00 00
sd 9:2:0:0: [sdr] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 9:2:0:0: [sdr] 976773168 512-byte hardware sectors (500108 MB)
sd 9:2:0:0: [sdr] Write Protect is off
sd 9:2:0:0: [sdr] Mode Sense: 00 3a 00 00
sd 9:2:0:0: [sdr] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sdr: sdr1
sd 9:2:0:0: [sdr] Attached SCSI disk
sd 9:2:0:0: Attached scsi generic sg17 type 0
scsi 9:3:0:0: Direct-Access     ATA      SAMSUNG HD501LJ  CR10 PQ: 0 ANSI: 5
sd 9:3:0:0: [sds] 976773168 512-byte hardware sectors (500108 MB)
sd 9:3:0:0: [sds] Write Protect is off
sd 9:3:0:0: [sds] Mode Sense: 00 3a 00 00
sd 9:3:0:0: [sds] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 9:3:0:0: [sds] 976773168 512-byte hardware sectors (500108 MB)
sd 9:3:0:0: [sds] Write Protect is off
sd 9:3:0:0: [sds] Mode Sense: 00 3a 00 00
sd 9:3:0:0: [sds] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sds: sds1
sd 9:3:0:0: [sds] Attached SCSI disk
sd 9:3:0:0: Attached scsi generic sg18 type 0
scsi 9:4:0:0: Direct-Access     ATA      SAMSUNG HD501LJ  CR10 PQ: 0 ANSI: 5
sd 9:4:0:0: [sdt] 976773168 512-byte hardware sectors (500108 MB)
sd 9:4:0:0: [sdt] Write Protect is off
sd 9:4:0:0: [sdt] Mode Sense: 00 3a 00 00
sd 9:4:0:0: [sdt] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 9:4:0:0: [sdt] 976773168 512-byte hardware sectors (500108 MB)
sd 9:4:0:0: [sdt] Write Protect is off
sd 9:4:0:0: [sdt] Mode Sense: 00 3a 00 00
sd 9:4:0:0: [sdt] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sdt: sdt1
sd 9:4:0:0: [sdt] Attached SCSI disk
sd 9:4:0:0: Attached scsi generic sg19 type 0
ACPI: PCI Interrupt 0000:01:03.0[A] -> GSI 21 (level, low) -> IRQ 21
ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[21]  MMIO=[fe5fb800-fe5fbfff]  Max Packet=[2048]  IR/IT contexts=[4/8]
ieee1394: raw1394: /dev/raw1394 device initialized
ehci_hcd: block sizes: qh 160 qtd 96 itd 192 sitd 96
ACPI: PCI Interrupt 0000:00:1d.7[A] -> GSI 20 (level, low) -> IRQ 20
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: EHCI Host Controller
drivers/usb/core/inode.c: creating file 'devices'
drivers/usb/core/inode.c: creating file '001'
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:1d.7: reset hcs_params 0x104208 dbg=1 cc=4 pcc=2 ordered !ppc ports=8
ehci_hcd 0000:00:1d.7: reset hcc_params 6871 thresh 7 uframes 1024 64 bit addr
ehci_hcd 0000:00:1d.7: debug port 1
PCI: cache line size of 128 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: supports USB remote wakeup
ehci_hcd 0000:00:1d.7: irq 20, io mem 0xfebfbc00
ehci_hcd 0000:00:1d.7: reset command 080002 (park)=0 ithresh=8 period=1024 Reset HALT
ehci_hcd 0000:00:1d.7: init command 010001 (park)=0 ithresh=1 period=1024 RUN
ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb1: default language 0x0409
usb usb1: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb1: Product: EHCI Host Controller
usb usb1: Manufacturer: Linux 2.6.23 ehci_hcd
usb usb1: SerialNumber: 0000:00:1d.7
usb usb1: uevent
usb usb1: usb_probe_device
usb usb1: configuration #1 chosen from 1 choice
usb usb1: adding 1-0:1.0 (config #1, interface 0)
usb 1-0:1.0: uevent
usb 1-0:1.0: uevent
hub 1-0:1.0: usb_probe_interface
hub 1-0:1.0: usb_probe_interface - got id
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 8 ports detected
hub 1-0:1.0: standalone hub
hub 1-0:1.0: no power switching (usb 1.0)
hub 1-0:1.0: individual port over-current protection
hub 1-0:1.0: Single TT
hub 1-0:1.0: TT requires at most 8 FS bit times (666 ns)
hub 1-0:1.0: power on to power good time: 20ms
hub 1-0:1.0: local power source is good
hub 1-0:1.0: trying to enable port power on non-switchable hub
hub 1-0:1.0: state 7 ports 8 chg 0000 evt 0000
drivers/usb/core/inode.c: creating file '001'
ohci_hcd: 2006 August 04 USB 1.1 'Open' Host Controller (OHCI) Driver
ohci_hcd: block sizes: ed 80 td 96
USB Universal Host Controller Interface driver v3.0
ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 20 (level, low) -> IRQ 20
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: UHCI Host Controller
drivers/usb/core/inode.c: creating file '002'
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1d.0: detected 2 ports
uhci_hcd 0000:00:1d.0: uhci_check_and_reset_hc: cmd = 0x0000
uhci_hcd 0000:00:1d.0: Performing full reset
uhci_hcd 0000:00:1d.0: irq 20, io base 0x0000e480
usb usb2: default language 0x0409
usb usb2: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb2: Product: UHCI Host Controller
usb usb2: Manufacturer: Linux 2.6.23 uhci_hcd
usb usb2: SerialNumber: 0000:00:1d.0
usb usb2: uevent
usb usb2: usb_probe_device
usb usb2: configuration #1 chosen from 1 choice
usb usb2: adding 2-0:1.0 (config #1, interface 0)
usb 2-0:1.0: uevent
usb 2-0:1.0: uevent
hub 2-0:1.0: usb_probe_interface
hub 2-0:1.0: usb_probe_interface - got id
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
hub 2-0:1.0: standalone hub
hub 2-0:1.0: no power switching (usb 1.0)
hub 2-0:1.0: individual port over-current protection
hub 2-0:1.0: power on to power good time: 2ms
hub 2-0:1.0: local power source is good
hub 2-0:1.0: trying to enable port power on non-switchable hub
hub 2-0:1.0: state 7 ports 2 chg 0000 evt 0000
drivers/usb/core/inode.c: creating file '001'
ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 17 (level, low) -> IRQ 17
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: UHCI Host Controller
drivers/usb/core/inode.c: creating file '003'
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1d.1: detected 2 ports
uhci_hcd 0000:00:1d.1: uhci_check_and_reset_hc: cmd = 0x0000
uhci_hcd 0000:00:1d.1: Performing full reset
uhci_hcd 0000:00:1d.1: irq 17, io base 0x0000e800
usb usb3: default language 0x0409
usb usb3: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb3: Product: UHCI Host Controller
usb usb3: Manufacturer: Linux 2.6.23 uhci_hcd
usb usb3: SerialNumber: 0000:00:1d.1
usb usb3: uevent
usb usb3: usb_probe_device
usb usb3: configuration #1 chosen from 1 choice
usb usb3: adding 3-0:1.0 (config #1, interface 0)
usb 3-0:1.0: uevent
usb 3-0:1.0: uevent
hub 3-0:1.0: usb_probe_interface
hub 3-0:1.0: usb_probe_interface - got id
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
hub 3-0:1.0: standalone hub
hub 3-0:1.0: no power switching (usb 1.0)
hub 3-0:1.0: individual port over-current protection
hub 3-0:1.0: power on to power good time: 2ms
hub 3-0:1.0: local power source is good
hub 3-0:1.0: trying to enable port power on non-switchable hub
hub 3-0:1.0: state 7 ports 2 chg 0000 evt 0000
drivers/usb/core/inode.c: creating file '001'
ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 18
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: UHCI Host Controller
drivers/usb/core/inode.c: creating file '004'
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:1d.2: detected 2 ports
uhci_hcd 0000:00:1d.2: uhci_check_and_reset_hc: cmd = 0x0000
uhci_hcd 0000:00:1d.2: Performing full reset
uhci_hcd 0000:00:1d.2: irq 18, io base 0x0000e880
usb usb4: default language 0x0409
usb usb4: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb4: Product: UHCI Host Controller
usb usb4: Manufacturer: Linux 2.6.23 uhci_hcd
usb usb4: SerialNumber: 0000:00:1d.2
usb usb4: uevent
usb usb4: usb_probe_device
usb usb4: configuration #1 chosen from 1 choice
usb usb4: adding 4-0:1.0 (config #1, interface 0)
usb 4-0:1.0: uevent
usb 4-0:1.0: uevent
hub 4-0:1.0: usb_probe_interface
hub 4-0:1.0: usb_probe_interface - got id
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
hub 4-0:1.0: standalone hub
hub 4-0:1.0: no power switching (usb 1.0)
hub 4-0:1.0: individual port over-current protection
hub 4-0:1.0: power on to power good time: 2ms
hub 4-0:1.0: local power source is good
hub 4-0:1.0: trying to enable port power on non-switchable hub
hub 4-0:1.0: state 7 ports 2 chg 0000 evt 0000
drivers/usb/core/inode.c: creating file '001'
ACPI: PCI Interrupt 0000:00:1d.3[D] -> GSI 19 (level, low) -> IRQ 19
PCI: Setting latency timer of device 0000:00:1d.3 to 64
uhci_hcd 0000:00:1d.3: UHCI Host Controller
drivers/usb/core/inode.c: creating file '005'
uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 5
uhci_hcd 0000:00:1d.3: detected 2 ports
uhci_hcd 0000:00:1d.3: uhci_check_and_reset_hc: cmd = 0x0000
uhci_hcd 0000:00:1d.3: Performing full reset
uhci_hcd 0000:00:1d.3: irq 19, io base 0x0000ec00
usb usb5: default language 0x0409
usb usb5: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb5: Product: UHCI Host Controller
usb usb5: Manufacturer: Linux 2.6.23 uhci_hcd
usb usb5: SerialNumber: 0000:00:1d.3
usb usb5: uevent
usb usb5: usb_probe_device
usb usb5: configuration #1 chosen from 1 choice
usb usb5: adding 5-0:1.0 (config #1, interface 0)
usb 5-0:1.0: uevent
usb 5-0:1.0: uevent
hub 5-0:1.0: usb_probe_interface
hub 5-0:1.0: usb_probe_interface - got id
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 2 ports detected
hub 5-0:1.0: standalone hub
hub 5-0:1.0: no power switching (usb 1.0)
hub 5-0:1.0: individual port over-current protection
hub 5-0:1.0: power on to power good time: 2ms
hub 5-0:1.0: local power source is good
hub 5-0:1.0: trying to enable port power on non-switchable hub
hub 5-0:1.0: state 7 ports 2 chg 0000 evt 0000
drivers/usb/core/inode.c: creating file '001'
usbcore: registered new interface driver usblp
Initializing USB Mass Storage driver...
usbcore: registered new interface driver usb-storage
USB Mass Storage support registered.
usbcore: registered new interface driver libusual
PNP: PS/2 Controller [PNP0303:PS2K] at 0x60,0x64 irq 1
PNP: PS/2 appears to have AUX port disabled, if this is incorrect please boot with i8042.nopnp
serio: i8042 KBD port at 0x60,0x64 irq 1
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard as /class/input/input2
Software Watchdog Timer: 0.07 initialized. soft_noboot=0 soft_margin=60 sec (nowayout= 0)
raid6: int64x1   1475 MB/s
raid6: int64x2   1948 MB/s
raid6: int64x4   2527 MB/s
raid6: int64x8   1794 MB/s
raid6: sse2x1    2383 MB/s
raid6: sse2x2    2079 MB/s
raid6: sse2x4    3100 MB/s
raid6: using algorithm sse2x4 (3100 MB/s)
md: raid6 personality registered for level 6
md: raid5 personality registered for level 5
md: raid4 personality registered for level 4
device-mapper: ioctl: 4.11.0-ioctl (2006-10-12) initialised: dm-devel@redhat.com
usbcore: registered new interface driver usbhid
drivers/hid/usbhid/hid-core.c: v2.6:USB HID core driver
oprofile: using NMI interrupt.
IPv4 over IPv4 tunneling driver
TCP cubic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
Bridge firewalling registered
802.1Q VLAN Support v1.8 Ben Greear <greearb@candelatech.com>
All bugs added by David S. Miller <davem@redhat.com>
Freeing unused kernel memory: 244k freed
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[0011d80000a4e2a2]
usb usb2: suspend_rh (auto-stop)
usb usb3: suspend_rh (auto-stop)
usb usb4: suspend_rh (auto-stop)
usb usb5: suspend_rh (auto-stop)
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
usb usb2: uevent
usb 2-0:1.0: uevent
usb 2-0:1.0: uevent
usb usb3: uevent
usb 3-0:1.0: uevent
usb 3-0:1.0: uevent
usb usb4: uevent
usb 4-0:1.0: uevent
usb 4-0:1.0: uevent
usb usb5: uevent
usb 5-0:1.0: uevent
usb 5-0:1.0: uevent
usb usb1: uevent
usb 1-0:1.0: uevent
usb 1-0:1.0: uevent
EXT3 FS on hda3, internal journal
ACPI: PCI Interrupt 0000:03:00.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:03:00.0 to 64
sky2 0000:03:00.0: v1.18 addr 0xfe7fc000 irq 16 Yukon-XL (0xb3) rev 3
sky2 eth0: addr 00:17:31:2d:e6:a9
sky2 eth1: addr 00:17:31:2d:e6:aa
md: md1 stopped.
md: bind<sdg1>
md: bind<sdf1>
md: bind<sdh1>
md: bind<sdl1>
md: bind<sdk1>
md: bind<sdi1>
md: bind<sdj1>
md: bind<sde1>
raid5: device sde1 operational as raid disk 0
raid5: device sdj1 operational as raid disk 7
raid5: device sdi1 operational as raid disk 6
raid5: device sdk1 operational as raid disk 5
raid5: device sdl1 operational as raid disk 4
raid5: device sdh1 operational as raid disk 3
raid5: device sdf1 operational as raid disk 2
raid5: device sdg1 operational as raid disk 1
raid5: allocated 8476kB for md1
raid5: raid level 6 set md1 active with 8 out of 8 devices, algorithm 2
RAID5 conf printout:
 --- rd:8 wd:8
 disk 0, o:1, dev:sde1
 disk 1, o:1, dev:sdg1
 disk 2, o:1, dev:sdf1
 disk 3, o:1, dev:sdh1
 disk 4, o:1, dev:sdl1
 disk 5, o:1, dev:sdk1
 disk 6, o:1, dev:sdi1
 disk 7, o:1, dev:sdj1
md1: bitmap initialized from disk: read 9/9 pages, set 1 bits
created bitmap (140 pages) for device md1
md: md2 stopped.
md: bind<sdt1>
md: bind<sds1>
md: bind<sdp1>
md: bind<sdo1>
md: bind<sdn1>
md: bind<sdm1>
md: bind<sdr1>
md: bind<sdq1>
raid5: device sdq1 operational as raid disk 0
raid5: device sdr1 operational as raid disk 7
raid5: device sdm1 operational as raid disk 6
raid5: device sdn1 operational as raid disk 5
raid5: device sdo1 operational as raid disk 4
raid5: device sdp1 operational as raid disk 3
raid5: device sds1 operational as raid disk 2
raid5: device sdt1 operational as raid disk 1
raid5: allocated 8476kB for md2
raid5: raid level 6 set md2 active with 8 out of 8 devices, algorithm 2
RAID5 conf printout:
 --- rd:8 wd:8
 disk 0, o:1, dev:sdq1
 disk 1, o:1, dev:sdt1
 disk 2, o:1, dev:sds1
 disk 3, o:1, dev:sdp1
 disk 4, o:1, dev:sdo1
 disk 5, o:1, dev:sdn1
 disk 6, o:1, dev:sdm1
 disk 7, o:1, dev:sdr1
md2: bitmap initialized from disk: read 15/15 pages, set 0 bits
created bitmap (233 pages) for device md2
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda4, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
Adding 4096564k swap on /dev/hda2.  Priority:-1 extents:1 across:4096564k
sky2 eth0: enabling interface
sky2 eth0: Link is up at 1000 Mbps, full duplex, flow control both
sky2 eth1: enabling interface
ip_tables: (C) 2000-2006 Netfilter Core Team
sky2 eth1: Link is up at 100 Mbps, full duplex, flow control both
------=_20080126180320_57157
Content-Type: text/plain; name="hdparm.txt"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="hdparm.txt"


/dev/sde:

 Model=Maxtor 6V300F0                          , FwRev=VA111630, SerialNo=V602NCVG            
 Config={ Fixed }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=4
 BuffType=DualPortCache, BuffSize=16384kB, MaxMultSect=16, MultSect=?16?
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=268435455
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes:  pio0 pio1 pio2 pio3 pio4 
 DMA modes:  mdma0 mdma1 mdma2 
 UDMA modes: udma0 udma1 udma2 udma3 udma4 *udma5 
 AdvancedPM=yes: disabled (255) WriteCache=enabled
 Drive conforms to: ATA/ATAPI-7 T13 1532D revision 0:  ATA/ATAPI-1,2,3,4,5,6,7

 * signifies the current active mode


/dev/sdf:

 Model=Maxtor 6V300F0                          , FwRev=VA111630, SerialNo=V60CJFRG            
 Config={ Fixed }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=4
 BuffType=DualPortCache, BuffSize=16384kB, MaxMultSect=16, MultSect=?16?
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=268435455
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes:  pio0 pio1 pio2 pio3 pio4 
 DMA modes:  mdma0 mdma1 mdma2 
 UDMA modes: udma0 udma1 udma2 udma3 udma4 *udma5 
 AdvancedPM=yes: disabled (255) WriteCache=enabled
 Drive conforms to: ATA/ATAPI-7 T13 1532D revision 0:  ATA/ATAPI-1,2,3,4,5,6,7

 * signifies the current active mode


/dev/sdg:

 Model=Maxtor 6V300F0                          , FwRev=VA111630, SerialNo=V609JETG            
 Config={ Fixed }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=4
 BuffType=DualPortCache, BuffSize=16384kB, MaxMultSect=16, MultSect=?16?
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=268435455
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes:  pio0 pio1 pio2 pio3 pio4 
 DMA modes:  mdma0 mdma1 mdma2 
 UDMA modes: udma0 udma1 udma2 udma3 udma4 *udma5 
 AdvancedPM=yes: disabled (255) WriteCache=enabled
 Drive conforms to: ATA/ATAPI-7 T13 1532D revision 0:  ATA/ATAPI-1,2,3,4,5,6,7

 * signifies the current active mode


/dev/sdh:

 Model=Maxtor 6V300F0                          , FwRev=VA111630, SerialNo=V60DX1ZG            
 Config={ Fixed }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=4
 BuffType=DualPortCache, BuffSize=16384kB, MaxMultSect=16, MultSect=?16?
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=268435455
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes:  pio0 pio1 pio2 pio3 pio4 
 DMA modes:  mdma0 mdma1 mdma2 
 UDMA modes: udma0 udma1 udma2 udma3 udma4 *udma5 
 AdvancedPM=yes: disabled (255) WriteCache=enabled
 Drive conforms to: ATA/ATAPI-7 T13 1532D revision 0:  ATA/ATAPI-1,2,3,4,5,6,7

 * signifies the current active mode


/dev/sdi:

 Model=Maxtor 6V300F0                          , FwRev=VA111630, SerialNo=V606E2PG            
 Config={ Fixed }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=4
 BuffType=DualPortCache, BuffSize=16384kB, MaxMultSect=16, MultSect=?0?
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=268435455
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes:  pio0 pio1 pio2 pio3 pio4 
 DMA modes:  mdma0 mdma1 mdma2 
 UDMA modes: udma0 udma1 udma2 udma3 udma4 *udma5 
 AdvancedPM=yes: disabled (255) WriteCache=enabled
 Drive conforms to: ATA/ATAPI-7 T13 1532D revision 0:  ATA/ATAPI-1,2,3,4,5,6,7

 * signifies the current active mode


/dev/sdj:

 Model=Maxtor 6V300F0                          , FwRev=VA111630, SerialNo=V606F26G            
 Config={ Fixed }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=4
 BuffType=DualPortCache, BuffSize=16384kB, MaxMultSect=16, MultSect=?0?
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=268435455
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes:  pio0 pio1 pio2 pio3 pio4 
 DMA modes:  mdma0 mdma1 mdma2 
 UDMA modes: udma0 udma1 udma2 udma3 udma4 *udma5 
 AdvancedPM=yes: disabled (255) WriteCache=enabled
 Drive conforms to: ATA/ATAPI-7 T13 1532D revision 0:  ATA/ATAPI-1,2,3,4,5,6,7

 * signifies the current active mode


/dev/sdk:

 Model=Maxtor 6V300F0                          , FwRev=VA111630, SerialNo=V606EAPG            
 Config={ Fixed }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=4
 BuffType=DualPortCache, BuffSize=16384kB, MaxMultSect=16, MultSect=?0?
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=268435455
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes:  pio0 pio1 pio2 pio3 pio4 
 DMA modes:  mdma0 mdma1 mdma2 
 UDMA modes: udma0 udma1 udma2 udma3 udma4 *udma5 
 AdvancedPM=yes: disabled (255) WriteCache=enabled
 Drive conforms to: ATA/ATAPI-7 T13 1532D revision 0:  ATA/ATAPI-1,2,3,4,5,6,7

 * signifies the current active mode


/dev/sdl:

 Model=Maxtor 6V300F0                          , FwRev=VA111630, SerialNo=V60CJCHG            
 Config={ Fixed }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=4
 BuffType=DualPortCache, BuffSize=16384kB, MaxMultSect=16, MultSect=?0?
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=268435455
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes:  pio0 pio1 pio2 pio3 pio4 
 DMA modes:  mdma0 mdma1 mdma2 
 UDMA modes: udma0 udma1 udma2 udma3 udma4 *udma5 
 AdvancedPM=yes: disabled (255) WriteCache=enabled
 Drive conforms to: ATA/ATAPI-7 T13 1532D revision 0:  ATA/ATAPI-1,2,3,4,5,6,7

 * signifies the current active mode


/dev/sdm:

 Model=SAMSUNG HD501LJ                         , FwRev=CR100-10, SerialNo=S0MUJ13P119746      
 Config={ Fixed }
 RawCHS=16383/16/63, TrkSize=34902, SectSize=554, ECCbytes=4
 BuffType=DualPortCache, BuffSize=16384kB, MaxMultSect=16, MultSect=?16?
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=268435455
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes:  pio0 pio1 pio2 pio3 pio4 
 DMA modes:  mdma0 mdma1 mdma2 
 UDMA modes: udma0 udma1 udma2 udma3 udma4 *udma5 
 AdvancedPM=no WriteCache=enabled
 Drive conforms to: unknown:  ATA/ATAPI-3,4,5,6,7

 * signifies the current active mode


/dev/sdn:

 Model=SAMSUNG HD501LJ                         , FwRev=CR100-10, SerialNo=S0MUJ13P119744      
 Config={ Fixed }
 RawCHS=16383/16/63, TrkSize=34902, SectSize=554, ECCbytes=4
 BuffType=DualPortCache, BuffSize=16384kB, MaxMultSect=16, MultSect=?16?
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=268435455
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes:  pio0 pio1 pio2 pio3 pio4 
 DMA modes:  mdma0 mdma1 mdma2 
 UDMA modes: udma0 udma1 udma2 udma3 udma4 *udma5 
 AdvancedPM=no WriteCache=enabled
 Drive conforms to: unknown:  ATA/ATAPI-3,4,5,6,7

 * signifies the current active mode


/dev/sdo:

 Model=SAMSUNG HD501LJ                         , FwRev=CR100-10, SerialNo=S0MUJ13P119747      
 Config={ Fixed }
 RawCHS=16383/16/63, TrkSize=34902, SectSize=554, ECCbytes=4
 BuffType=DualPortCache, BuffSize=16384kB, MaxMultSect=16, MultSect=?16?
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=268435455
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes:  pio0 pio1 pio2 pio3 pio4 
 DMA modes:  mdma0 mdma1 mdma2 
 UDMA modes: udma0 udma1 udma2 udma3 udma4 *udma5 
 AdvancedPM=no WriteCache=enabled
 Drive conforms to: unknown:  ATA/ATAPI-3,4,5,6,7

 * signifies the current active mode


/dev/sdp:

 Model=SAMSUNG HD501LJ                         , FwRev=CR100-10, SerialNo=S0MUJ13P119745      
 Config={ Fixed }
 RawCHS=16383/16/63, TrkSize=34902, SectSize=554, ECCbytes=4
 BuffType=DualPortCache, BuffSize=16384kB, MaxMultSect=16, MultSect=?16?
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=268435455
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes:  pio0 pio1 pio2 pio3 pio4 
 DMA modes:  mdma0 mdma1 mdma2 
 UDMA modes: udma0 udma1 udma2 udma3 udma4 *udma5 
 AdvancedPM=no WriteCache=enabled
 Drive conforms to: unknown:  ATA/ATAPI-3,4,5,6,7

 * signifies the current active mode


/dev/sdq:

 Model=SAMSUNG HD501LJ                         , FwRev=CR100-10, SerialNo=S0MUJ13P798046      
 Config={ Fixed }
 RawCHS=16383/16/63, TrkSize=34902, SectSize=554, ECCbytes=4
 BuffType=DualPortCache, BuffSize=16384kB, MaxMultSect=16, MultSect=?0?
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=268435455
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes:  pio0 pio1 pio2 pio3 pio4 
 DMA modes:  mdma0 mdma1 mdma2 
 UDMA modes: udma0 udma1 udma2 udma3 udma4 *udma5 
 AdvancedPM=no WriteCache=enabled
 Drive conforms to: unknown:  ATA/ATAPI-3,4,5,6,7

 * signifies the current active mode


/dev/sdr:

 Model=SAMSUNG HD501LJ                         , FwRev=CR100-11, SerialNo=S0MUJ1FP901642      
 Config={ Fixed }
 RawCHS=16383/16/63, TrkSize=34902, SectSize=554, ECCbytes=4
 BuffType=DualPortCache, BuffSize=16384kB, MaxMultSect=16, MultSect=?0?
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=268435455
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes:  pio0 pio1 pio2 pio3 pio4 
 DMA modes:  mdma0 mdma1 mdma2 
 UDMA modes: udma0 udma1 udma2 udma3 udma4 *udma5 
 AdvancedPM=no WriteCache=enabled
 Drive conforms to: unknown:  ATA/ATAPI-3,4,5,6,7

 * signifies the current active mode


/dev/sds:

 Model=SAMSUNG HD501LJ                         , FwRev=CR100-11, SerialNo=S0MUJ1DP924383      
 Config={ Fixed }
 RawCHS=16383/16/63, TrkSize=34902, SectSize=554, ECCbytes=4
 BuffType=DualPortCache, BuffSize=16384kB, MaxMultSect=16, MultSect=?0?
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=268435455
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes:  pio0 pio1 pio2 pio3 pio4 
 DMA modes:  mdma0 mdma1 mdma2 
 UDMA modes: udma0 udma1 udma2 udma3 udma4 *udma5 
 AdvancedPM=no WriteCache=enabled
 Drive conforms to: unknown:  ATA/ATAPI-3,4,5,6,7

 * signifies the current active mode


/dev/sdt:

 Model=SAMSUNG HD501LJ                         , FwRev=CR100-11, SerialNo=      S0ZFJ1MP905874
 Config={ Fixed }
 RawCHS=16383/16/63, TrkSize=34902, SectSize=554, ECCbytes=4
 BuffType=DualPortCache, BuffSize=16384kB, MaxMultSect=16, MultSect=?0?
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=268435455
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes:  pio0 pio1 pio2 pio3 pio4 
 DMA modes:  mdma0 mdma1 mdma2 
 UDMA modes: udma0 udma1 udma2 udma3 udma4 *udma5 
 AdvancedPM=no WriteCache=enabled
 Drive conforms to: unknown:  ATA/ATAPI-3,4,5,6,7

 * signifies the current active mode

------=_20080126180320_57157
Content-Type: text/plain; name="lspci-nn.txt"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="lspci-nn.txt"

00:00.0 Host bridge [0600]: Intel Corporation 82975X Memory Controller Hub [8086:277c] (rev c0)
00:01.0 PCI bridge [0604]: Intel Corporation 82975X PCI Express Root Port [8086:277d] (rev c0)
00:1b.0 Audio device [0403]: Intel Corporation 82801G (ICH7 Family) High Definition Audio Controller [8086:27d8] (rev 01)
00:1c.0 PCI bridge [0604]: Intel Corporation 82801G (ICH7 Family) PCI Express Port 1 [8086:27d0] (rev 01)
00:1c.4 PCI bridge [0604]: Intel Corporation 82801GR/GH/GHM (ICH7 Family) PCI Express Port 5 [8086:27e0] (rev 01)
00:1c.5 PCI bridge [0604]: Intel Corporation 82801GR/GH/GHM (ICH7 Family) PCI Express Port 6 [8086:27e2] (rev 01)
00:1d.0 USB Controller [0c03]: Intel Corporation 82801G (ICH7 Family) USB UHCI Controller #1 [8086:27c8] (rev 01)
00:1d.1 USB Controller [0c03]: Intel Corporation 82801G (ICH7 Family) USB UHCI Controller #2 [8086:27c9] (rev 01)
00:1d.2 USB Controller [0c03]: Intel Corporation 82801G (ICH7 Family) USB UHCI Controller #3 [8086:27ca] (rev 01)
00:1d.3 USB Controller [0c03]: Intel Corporation 82801G (ICH7 Family) USB UHCI Controller #4 [8086:27cb] (rev 01)
00:1d.7 USB Controller [0c03]: Intel Corporation 82801G (ICH7 Family) USB2 EHCI Controller [8086:27cc] (rev 01)
00:1e.0 PCI bridge [0604]: Intel Corporation 82801 PCI Bridge [8086:244e] (rev e1)
00:1f.0 ISA bridge [0601]: Intel Corporation 82801GB/GR (ICH7 Family) LPC Interface Bridge [8086:27b8] (rev 01)
00:1f.1 IDE interface [0101]: Intel Corporation 82801G (ICH7 Family) IDE Controller [8086:27df] (rev 01)
00:1f.2 IDE interface [0101]: Intel Corporation 82801GB/GR/GH (ICH7 Family) SATA IDE Controller [8086:27c0] (rev 01)
00:1f.3 SMBus [0c05]: Intel Corporation 82801G (ICH7 Family) SMBus Controller [8086:27da] (rev 01)
01:01.0 VGA compatible controller [0300]: Matrox Graphics, Inc. MGA 1064SG [Mystique] [102b:051a] (rev 02)
01:03.0 FireWire (IEEE 1394) [0c00]: Texas Instruments TSB43AB22/A IEEE-1394a-2000 Controller (PHY/Link) [104c:8023]
02:00.0 SATA controller [0106]: Marvell Technology Group Ltd. 88SE614x SATA II PCI-E controller [11ab:6141] (rev 01)
03:00.0 Ethernet controller [0200]: Marvell Technology Group Ltd. 88E8062 PCI-E IPMI Gigabit Ethernet Controller [11ab:4343] (rev 14)
04:00.0 PCI bridge [0604]: Intel Corporation 6702PXH PCI Express-to-PCI Bridge A [8086:032c] (rev 09)
05:01.0 RAID bus controller [0104]: Silicon Image, Inc. SiI 3124 PCI-X Serial ATA Controller [1095:3124] (rev 01)
05:02.0 RAID bus controller [0104]: Silicon Image, Inc. SiI 3124 PCI-X Serial ATA Controller [1095:3124] (rev 02)
------=_20080126180320_57157--


