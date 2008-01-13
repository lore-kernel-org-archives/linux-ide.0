From: "Jim MacBaine" <jmacbaine@gmail.com>
Subject: SATA timeouts on two disks
Date: Sun, 13 Jan 2008 01:56:25 +0100
Message-ID: <3afbacad0801121656u7318de7l57ba5064da259f3f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.184]:4558 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751193AbYAMA4a (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 12 Jan 2008 19:56:30 -0500
Received: by mu-out-0910.google.com with SMTP id w8so858551mue.1
        for <linux-ide@vger.kernel.org>; Sat, 12 Jan 2008 16:56:26 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi,

Recently I'm experiencing strange sata errors on my desktop system.
The system was recently equipped with three 250 GB SATA drives from
three different manufacturers and I'm having an identical problem on
two of them.  The drives are connected to two on-board controllers on
an Asus A8V board, which were both running with Linux for more than
two years with older SATA disks without problems. A hardware failure
seems unlikely to me as the same error occurrs on two brand new disks
from two different manufacturers.  I'm running a vanilla 2.6.23.12
kernel.

Errror on sdc happened about 10 times tonight, each time I could hear
the disk spin down and up again, while the system was frozen for
several seconds:

ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x180000 action 0x2 frozen
ata2.00: cmd ea/00:00:00:00:00/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0
         res 40/00:00:00:00:40/00:00:00:00:00/00 Emask 0x4 (timeout)
ata2: soft resetting port
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata2.00: configured for UDMA/133
ata2: EH complete
sd 1:0:0:0: [sdb] 488397168 512-byte hardware sectors (250059 MB)
sd 1:0:0:0: [sdb] Write Protect is off
sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA

In the log I also found several identical errors on one other drive:

ata5.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata5.00: cmd 25/00:08:b7:f2:11/00:00:13:00:00/e0 tag 0 cdb 0x0 data 4096 in
         res 40/00:01:00:4f:c2/00:00:00:00:00/00 Emask 0x4 (timeout)
ata5: soft resetting port
ata5.00: configured for UDMA/33
ata5: EH complete
sd 4:0:0:0: [sdc] 488397168 512-byte hardware sectors (250059 MB)
sd 4:0:0:0: [sdc] Write Protect is off
sd 4:0:0:0: [sdc] Mode Sense: 00 3a 00 00
sd 4:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA

Can this be the result of a hardware failure?  I've seen several
drives being added to an NCQ blacklist during the last weeks.  Is it
possible that my drives need to be added here, too?  Or have I just
two failing drives?

Thanks a lot for any clues,
Jim


System boot log extract:

sata_promise 0000:00:08.0: version 2.10
ACPI: PCI Interrupt 0000:00:08.0[A] -> GSI 18 (level, low) -> IRQ 18
scsi0 : sata_promise
scsi1 : sata_promise
scsi2 : sata_promise
ata1: SATA max UDMA/133 cmd 0xf882e200 ctl 0xf882e238 bmdma 0x00000000 irq 18
ata2: SATA max UDMA/133 cmd 0xf882e280 ctl 0xf882e2b8 bmdma 0x00000000 irq 18
ata3: PATA max UDMA/133 cmd 0xf882e300 ctl 0xf882e338 bmdma 0x00000000 irq 18
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.00: ATA-8: SAMSUNG HD252KJ, CM100-12, max UDMA7
ata1.00: 488397168 sectors, multi 0: LBA48 NCQ (depth 0/32)
ata1.00: configured for UDMA/133
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata2.00: ATA-7: WDC WD2500JS-55NCB1, 10.02E01, max UDMA/133
ata2.00: 488397168 sectors, multi 0: LBA48 NCQ (depth 0/32)
ata2.00: configured for UDMA/133
scsi 0:0:0:0: Direct-Access     ATA      SAMSUNG HD252KJ  CM10 PQ: 0 ANSI: 5
sd 0:0:0:0: [sda] 488397168 512-byte hardware sectors (250059 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
sd 0:0:0:0: [sda] 488397168 512-byte hardware sectors (250059 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
 sda: sda2 sda3
sd 0:0:0:0: [sda] Attached SCSI disk
scsi 1:0:0:0: Direct-Access     ATA      WDC WD2500JS-55N 10.0 PQ: 0 ANSI: 5
sd 1:0:0:0: [sdb] 488397168 512-byte hardware sectors (250059 MB)
sd 1:0:0:0: [sdb] Write Protect is off
sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
sd 1:0:0:0: [sdb] 488397168 512-byte hardware sectors (250059 MB)
sd 1:0:0:0: [sdb] Write Protect is off
sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
 sdb: sdb2 sdb3
sd 1:0:0:0: [sdb] Attached SCSI disk
sata_via 0000:00:0f.0: version 2.3
ACPI: PCI Interrupt 0000:00:0f.0[B] -> GSI 20 (level, low) -> IRQ 17
sata_via 0000:00:0f.0: routed to hard irq line 10
scsi3 : sata_via
scsi4 : sata_via
ata4: SATA max UDMA/133 cmd 0x0001d000 ctl 0x0001c802 bmdma 0x0001b800 irq 17
ata5: SATA max UDMA/133 cmd 0x0001c400 ctl 0x0001c002 bmdma 0x0001b808 irq 17
ata4: SATA link down 1.5 Gbps (SStatus 0 SControl 300)
ata5: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata5.00: ATA-7: MAXTOR STM3250820AS, 3.AAE, max UDMA/133
ata5.00: 488397168 sectors, multi 16: LBA48 NCQ (depth 0/32)
ata5.00: configured for UDMA/133
scsi 4:0:0:0: Direct-Access     ATA      MAXTOR STM325082 3.AA PQ: 0 ANSI: 5
sd 4:0:0:0: [sdc] 488397168 512-byte hardware sectors (250059 MB)
sd 4:0:0:0: [sdc] Write Protect is off
sd 4:0:0:0: [sdc] Mode Sense: 00 3a 00 00
sd 4:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
sd 4:0:0:0: [sdc] 488397168 512-byte hardware sectors (250059 MB)
sd 4:0:0:0: [sdc] Write Protect is off
sd 4:0:0:0: [sdc] Mode Sense: 00 3a 00 00
sd 4:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
 sdc: sdc1 sdc2 sdc3
sd 4:0:0:0: [sdc] Attached SCSI disk


# lspci -nn
00:00.0 Host bridge [0600]: VIA Technologies, Inc. K8T800Pro Host
Bridge [1106:0282]
00:00.1 Host bridge [0600]: VIA Technologies, Inc. K8T800Pro Host
Bridge [1106:1282]
00:00.2 Host bridge [0600]: VIA Technologies, Inc. K8T800Pro Host
Bridge [1106:2282]
00:00.3 Host bridge [0600]: VIA Technologies, Inc. K8T800Pro Host
Bridge [1106:3282]
00:00.4 Host bridge [0600]: VIA Technologies, Inc. K8T800Pro Host
Bridge [1106:4282]
00:00.7 Host bridge [0600]: VIA Technologies, Inc. K8T800Pro Host
Bridge [1106:7282]
00:01.0 PCI bridge [0604]: VIA Technologies, Inc. VT8237 PCI bridge
[K8T800/K8T890 South] [1106:b188]
00:08.0 RAID bus controller [0104]: Promise Technology, Inc. PDC20378
(FastTrak 378/SATA 378) [105a:3373] (rev 02)
00:09.0 Multimedia video controller [0400]: Brooktree Corporation
Bt848 Video Capture [109e:0350] (rev 12)
00:0a.0 Ethernet controller [0200]: Marvell Technology Group Ltd.
88E8001 Gigabit Ethernet Controller [11ab:4320] (rev 13)
00:0f.0 RAID bus controller [0104]: VIA Technologies, Inc. VIA VT6420
SATA RAID Controller [1106:3149] (rev 80)
00:0f.1 IDE interface [0101]: VIA Technologies, Inc.
VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE [1106:0571]
(rev 06)
00:10.0 USB Controller [0c03]: VIA Technologies, Inc. VT82xxxxx UHCI
USB 1.1 Controller [1106:3038] (rev 81)
00:10.1 USB Controller [0c03]: VIA Technologies, Inc. VT82xxxxx UHCI
USB 1.1 Controller [1106:3038] (rev 81)
00:10.2 USB Controller [0c03]: VIA Technologies, Inc. VT82xxxxx UHCI
USB 1.1 Controller [1106:3038] (rev 81)
00:10.3 USB Controller [0c03]: VIA Technologies, Inc. VT82xxxxx UHCI
USB 1.1 Controller [1106:3038] (rev 81)
00:10.4 USB Controller [0c03]: VIA Technologies, Inc. USB 2.0
[1106:3104] (rev 86)
00:11.0 ISA bridge [0601]: VIA Technologies, Inc. VT8237 ISA bridge
[KT600/K8T800/K8T890 South] [1106:3227]
00:11.5 Multimedia audio controller [0401]: VIA Technologies, Inc.
VT8233/A/8235/8237 AC97 Audio Controller [1106:3059] (rev 60)
00:11.6 Communication controller [0780]: VIA Technologies, Inc. AC'97
Modem Controller [1106:3068] (rev 80)
00:18.0 Host bridge [0600]: Advanced Micro Devices [AMD] K8
[Athlon64/Opteron] HyperTransport Technology Configuration [1022:1100]
00:18.1 Host bridge [0600]: Advanced Micro Devices [AMD] K8
[Athlon64/Opteron] Address Map [1022:1101]
00:18.2 Host bridge [0600]: Advanced Micro Devices [AMD] K8
[Athlon64/Opteron] DRAM Controller [1022:1102]
00:18.3 Host bridge [0600]: Advanced Micro Devices [AMD] K8
[Athlon64/Opteron] Miscellaneous Control [1022:1103]
01:00.0 VGA compatible controller [0300]: Matrox Graphics, Inc. MGA
G400/G450 [102b:0525] (rev 82)
