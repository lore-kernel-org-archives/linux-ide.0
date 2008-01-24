From: <drtyc@centrum.cz>
Subject: excess timeouts accessing pci-sata card both ports
Date: Thu, 24 Jan 2008 09:19:19 +0100
Message-ID: <200801240919.2173@centrum.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1250"
Content-Transfer-Encoding: 8bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail1007.centrum.cz ([213.29.7.97]:43276 "EHLO
	mail1007.centrum.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753279AbYAXI1Z (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 24 Jan 2008 03:27:25 -0500
Received: by mail1007.centrum.cz id S35570981AbYAXITT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 24 Jan 2008 09:19:19 +0100
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hello.

The scenario:
PCI bus with 2 cards (sata_via)
Each card has 2 SATA ports connected.
Each disk does 40MB/s in hdparm -t read test.

First card has the sda and sdb
Second card has the sdc and sdd
verified by watching the led blinking on the card

ok - accessing two ports at same time but each port on different card:
cat /dev/sda > /dev/null & cat /dev/sdc > /dev/null

problem - accessing two ports at same time and both ports on same card:
cat /dev/sda > /dev/null & cat /dev/sdb > /dev/null

side effect of the problem:
due to heavy traffic on one port the reset of the other port fails with timeout and port is disabled

logged error command at the initial problem (is it DMA read ext and DMA write log?):
ata2.00: exception Emask 0x2 SAct 0x0 SErr 0x3000400 action 0x2 frozen
ata2.00: cmd 25/00:68:b8:83:13/00:01:00:00:00/e0 tag 0 cdb 0x0 data 184320 in
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x6 (timeout)
ata2: port is slow to respond, please be patient (Status 0xd0)

ata2.00: exception Emask 0x2 SAct 0x0 SErr 0x3000400 action 0x2 frozen
ata2.00: cmd c8/00:60:70:50:08/00:00:00:00:00/e0 tag 0 cdb 0x0 data 49152 in
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x6 (timeout)
ata2: port is slow to respond, please be patient (Status 0xd0)

logged EH sequence failure:
ata2: port is slow to respond, please be patient (Status 0xd0)
ata2: device not ready (errno=-16), forcing hardreset
ata2: hard resetting port
ata2: port is slow to respond, please be patient (Status 0x80)
ata2: COMRESET failed (errno=-16)
ata2: hard resetting port
ata2: port is slow to respond, please be patient (Status 0x80)
ata2: COMRESET failed (errno=-16)
ata2: hard resetting port
ata2: port is slow to respond, please be patient (Status 0x80)
ata2: COMRESET failed (errno=-16)
ata2: hard resetting port
ata2: COMRESET failed (errno=-16)
ata2: reset failed, giving up
ata2.00: disabled
ata2: EH complete
sd 1:0:0:0: [sdb] Result: hostbyte=0x04 driverbyte=0x00

tried does not work:
- multiply the ATA_TMOUT values by 10 and later by 100 against vanilla 
- increase retry counters

some lines from dmesg below
libata version 2.21 loaded.
sata_via 0000:00:0d.0: version 2.3
ACPI: PCI Interrupt 0000:00:0d.0[A] -> Link [LNKA] -> GSI 11 (level, low) -> IRQ 11
sata_via 0000:00:0d.0: routed to hard irq line 11
scsi0 : sata_via
scsi1 : sata_via
scsi2 : sata_via
ata1: SATA max UDMA/133 cmd 0x0001b800 ctl 0x0001b80a bmdma 0x0001a400 irq 11
ata2: SATA max UDMA/133 cmd 0x0001b400 ctl 0x0001b40a bmdma 0x0001a408 irq 11
ata3: PATA max UDMA/133 cmd 0x0001b000 ctl 0x0001b00a bmdma 0x0001a410 irq 11
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata1.00: ATA-7: Maxtor 6L250S0, BANC1G10, max UDMA/133
ata1.00: 490234752 sectors, multi 16: LBA48 NCQ (not used)
ata1.00: configured for UDMA/133
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata2.00: ATA-7: Maxtor 6L250S0, BANC1G10, max UDMA/133
ata2.00: 490234752 sectors, multi 16: LBA48 NCQ (not used)
ata2.00: configured for UDMA/133
scsi 0:0:0:0: Direct-Access     ATA      Maxtor 6L250S0   BANC PQ: 0 ANSI: 5
sd 0:0:0:0: [sda] 490234752 512-byte hardware sectors (251000 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 0:0:0:0: [sda] 490234752 512-byte hardware sectors (251000 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sda: sda1 sda2 sda3
sd 0:0:0:0: [sda] Attached SCSI disk
sd 0:0:0:0: Attached scsi generic sg0 type 0
scsi 1:0:0:0: Direct-Access     ATA      Maxtor 6L250S0   BANC PQ: 0 ANSI: 5
sd 1:0:0:0: [sdb] 490234752 512-byte hardware sectors (251000 MB)
sd 1:0:0:0: [sdb] Write Protect is off
sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 1:0:0:0: [sdb] 490234752 512-byte hardware sectors (251000 MB)
sd 1:0:0:0: [sdb] Write Protect is off
sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sdb: sdb1 sdb2 sdb3
sd 1:0:0:0: [sdb] Attached SCSI disk
sd 1:0:0:0: Attached scsi generic sg1 type 0
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 10
PCI: setting IRQ 10 as level-triggered
ACPI: PCI Interrupt 0000:00:0e.0[A] -> Link [LNKB] -> GSI 10 (level, low) -> IRQ 10
sata_via 0000:00:0e.0: routed to hard irq line 10
scsi3 : sata_via
scsi4 : sata_via
scsi5 : sata_via
ata4: SATA max UDMA/133 cmd 0x00019800 ctl 0x0001980a bmdma 0x00018400 irq 10
ata5: SATA max UDMA/133 cmd 0x00019400 ctl 0x0001940a bmdma 0x00018408 irq 10
ata6: PATA max UDMA/133 cmd 0x00019000 ctl 0x0001900a bmdma 0x00018410 irq 10
ata4: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata4.00: ATA-7: Maxtor 6L250S0, BANC1G10, max UDMA/133
ata4.00: 490234752 sectors, multi 16: LBA48 NCQ (not used)
ata4.00: configured for UDMA/133
ata5: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata5.00: ATA-7: Maxtor 6L250S0, BANC1G10, max UDMA/133
ata5.00: 490234752 sectors, multi 16: LBA48 NCQ (not used)
ata5.00: configured for UDMA/133
scsi 3:0:0:0: Direct-Access     ATA      Maxtor 6L250S0   BANC PQ: 0 ANSI: 5
sd 3:0:0:0: [sdc] 490234752 512-byte hardware sectors (251000 MB)
sd 3:0:0:0: [sdc] Write Protect is off
sd 3:0:0:0: [sdc] Mode Sense: 00 3a 00 00
sd 3:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 3:0:0:0: [sdc] 490234752 512-byte hardware sectors (251000 MB)
sd 3:0:0:0: [sdc] Write Protect is off
sd 3:0:0:0: [sdc] Mode Sense: 00 3a 00 00
sd 3:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sdc: sdc1 sdc2 sdc3
sd 3:0:0:0: [sdc] Attached SCSI disk
sd 3:0:0:0: Attached scsi generic sg2 type 0
scsi 4:0:0:0: Direct-Access     ATA      Maxtor 6L250S0   BANC PQ: 0 ANSI: 5
sd 4:0:0:0: [sdd] 490234752 512-byte hardware sectors (251000 MB)
sd 4:0:0:0: [sdd] Write Protect is off
sd 4:0:0:0: [sdd] Mode Sense: 00 3a 00 00
sd 4:0:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 4:0:0:0: [sdd] 490234752 512-byte hardware sectors (251000 MB)
sd 4:0:0:0: [sdd] Write Protect is off
sd 4:0:0:0: [sdd] Mode Sense: 00 3a 00 00
sd 4:0:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sdd: sdd1 sdd2 sdd3
sd 4:0:0:0: [sdd] Attached SCSI disk
sd 4:0:0:0: Attached scsi generic sg3 type 0

The card information:
00:0d.0 RAID bus controller: VIA Technologies, Inc. VT6421 IDE RAID Controller (rev 50)
        Subsystem: VIA Technologies, Inc. VT6421 IDE RAID Controller
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at b800 [size=16]
        Region 1: I/O ports at b400 [size=16]
        Region 2: I/O ports at b000 [size=16]
        Region 3: I/O ports at a800 [size=16]
        Region 4: I/O ports at a400 [size=32]
        Region 5: I/O ports at a000 [size=256]
        [virtual] Expansion ROM at 30100000 [disabled] [size=64K]
        Capabilities: [e0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 06 11 49 32 07 00 90 02 50 00 04 01 00 20 00 00
10: 01 b8 00 00 01 b4 00 00 01 b0 00 00 01 a8 00 00
20: 01 a4 00 00 01 a0 00 00 00 00 00 00 06 11 49 32
30: 00 00 00 00 e0 00 00 00 00 00 00 00 0b 01 00 00
40: 33 03 f1 44 06 af 00 00 00 00 00 03 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 10 10 00 05 00 20 00
60: 00 00 ff ff 00 00 00 00 00 00 00 00 00 00 ff ff
70: 00 00 00 00 01 f0 00 00 01 00 01 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 20 f2 1f 00 10 b7 1f
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 0b f2 c9 35 10 ac c0 00 a8 a8 a8 a8 ff 00 b6 b6
b0: 0f 0f 0f 0f 34 00 00 00 00 00 20 00 00 00 00 00
c0: 00 02 00 00 00 00 00 00 00 02 00 00 00 00 00 00
d0: 02 01 00 00 00 00 00 00 02 01 00 00 00 00 00 00
e0: 01 00 02 00 00 00 00 00 50 01 49 32 06 11 49 32
f0: 00 00 70 00 00 00 00 00 00 00 00 00 00 00 00 00

00:0e.0 RAID bus controller: VIA Technologies, Inc. VT6421 IDE RAID Controller (rev 50)
        Subsystem: VIA Technologies, Inc. VT6421 IDE RAID Controller
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Interrupt: pin A routed to IRQ 10
        Region 0: I/O ports at 9800 [size=16]
        Region 1: I/O ports at 9400 [size=16]
        Region 2: I/O ports at 9000 [size=16]
        Region 3: I/O ports at 8800 [size=16]
        Region 4: I/O ports at 8400 [size=32]
        Region 5: I/O ports at 8000 [size=256]
        [virtual] Expansion ROM at 30110000 [disabled] [size=64K]
        Capabilities: [e0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 06 11 49 32 07 00 90 02 50 00 04 01 00 20 00 00
10: 01 98 00 00 01 94 00 00 01 90 00 00 01 88 00 00
20: 01 84 00 00 01 80 00 00 00 00 00 00 06 11 49 32
30: 00 00 00 00 e0 00 00 00 00 00 00 00 0a 01 00 00
40: 33 03 f1 44 06 af 00 00 00 00 00 03 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 10 10 00 05 00 10 00
60: 00 00 ff ff 00 00 00 00 00 00 00 00 00 00 ff ff
70: 00 00 00 00 01 f0 00 00 01 00 01 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 80 b6 1f 00 70 bb 1f
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 0b f2 c9 35 10 ac c0 00 a8 a8 a8 a8 ff 00 b6 b6
b0: 0f 0f 0f 0f 34 00 00 00 00 00 20 00 00 00 00 00
c0: 00 02 00 00 00 00 00 00 00 02 00 00 00 00 00 00
d0: 02 01 00 00 00 00 00 00 02 01 00 00 00 00 00 00
e0: 01 00 02 00 00 00 00 00 50 01 49 32 06 11 49 32
f0: 00 00 70 00 00 00 00 00 00 00 00 00 00 00 00 00

Thanks for everything and anything.

PS: to me it seems that the kernel treats both ports on one card as paralelly accessible SATA ports but the PCI/DMA makes it only one port a time and this missed fact is causing the problem. So the question is this correct and where should I start looking for the port to pci slot mapping to group ports and where to add some kind of locking - first/second port. (if nobody else has that already fixed somewhere)
Btw. how about 3 port and 4 port cards?

