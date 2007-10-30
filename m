From: "Matheus Izvekov" <mizvekov@gmail.com>
Subject: AHCI + ST3160023AS + NCQ problems
Date: Mon, 29 Oct 2007 22:13:03 -0200
Message-ID: <305c16960710291713v22875d26v8ccfc76daab102bd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.170]:22074 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752751AbXJ3ANH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 29 Oct 2007 20:13:07 -0400
Received: by ug-out-1314.google.com with SMTP id z38so33053ugc
        for <linux-ide@vger.kernel.org>; Mon, 29 Oct 2007 17:13:05 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, jgarzik@pobox.com

Seagate drive ST3160023AS is correctly detected as supporting NCQ, but
when its used with moderate loads, libata keeps throwing error
messages until it finally decides to disable NCQ on it.
this is the controller:

00:1f.2 SATA controller: Intel Corporation 82801GR/GH (ICH7 Family)
SATA AHCI Controller (rev 01) (prog-if 01 [AHCI 1.0])
        Subsystem: Intel Corporation Unknown device 5842
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx+
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0
        Interrupt: pin B routed to IRQ 379
        Region 0: I/O ports at 30c8 [size=8]
        Region 1: I/O ports at 30e4 [size=4]
        Region 2: I/O ports at 30c0 [size=8]
        Region 3: I/O ports at 30e0 [size=4]
        Region 4: I/O ports at 30a0 [size=16]
        Region 5: Memory at 29304000 (32-bit, non-prefetchable) [size=1K]
        Capabilities: [80] Message Signalled Interrupts: Mask- 64bit-
Queue=0/0 Enable+
                Address: fee0f00c  Data: 4181
        Capabilities: [70] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

relevant kmsg output:

ahci 0000:00:1f.2: version 2.3
ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 19 (level, low) -> IRQ 19
ahci 0000:00:1f.2: AHCI 0001.0100 32 slots 4 ports 3 Gbps 0xf impl SATA mode
ahci 0000:00:1f.2: flags: 64bit ncq led clo pio slum part
PCI: Setting latency timer of device 0000:00:1f.2 to 64
scsi0 : ahci
scsi1 : ahci
scsi2 : ahci
scsi3 : ahci
ata1: SATA max UDMA/133 cmd 0xffffc20000024100 ctl 0x0000000000000000
bmdma 0x0000000000000000 irq 379
ata2: SATA max UDMA/133 cmd 0xffffc20000024180 ctl 0x0000000000000000
bmdma 0x0000000000000000 irq 379
ata3: SATA max UDMA/133 cmd 0xffffc20000024200 ctl 0x0000000000000000
bmdma 0x0000000000000000 irq 379
ata4: SATA max UDMA/133 cmd 0xffffc20000024280 ctl 0x0000000000000000
bmdma 0x0000000000000000 irq 379
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.00: ATA-6: ST3120026AS, 3.18, max UDMA/133
ata1.00: 234441648 sectors, multi 16: LBA48
ata1.00: configured for UDMA/133
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata2.00: ATA-7: ST3320620AS, 3.AAK, max UDMA/133
ata2.00: 625142448 sectors, multi 16: LBA48 NCQ (depth 31/32)
ata2.00: configured for UDMA/133
ata3: SATA link down (SStatus 0 SControl 300)
ata4: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata4.00: ATA-6: ST3160023AS, 3.42, max UDMA/133
ata4.00: 312581808 sectors, multi 16: LBA48 NCQ (depth 31/32)
ata4.00: configured for UDMA/133
scsi 0:0:0:0: Direct-Access     ATA      ST3120026AS      3.18 PQ: 0 ANSI: 5
sd 0:0:0:0: [sda] 234441648 512-byte hardware sectors (120034 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
sd 0:0:0:0: [sda] 234441648 512-byte hardware sectors (120034 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
 sda: sda1 sda2 sda3
sd 0:0:0:0: [sda] Attached SCSI disk
scsi 1:0:0:0: Direct-Access     ATA      ST3320620AS      3.AA PQ: 0 ANSI: 5
sd 1:0:0:0: [sdb] 625142448 512-byte hardware sectors (320073 MB)
sd 1:0:0:0: [sdb] Write Protect is off
sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
sd 1:0:0:0: [sdb] 625142448 512-byte hardware sectors (320073 MB)
sd 1:0:0:0: [sdb] Write Protect is off
sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
 sdb: unknown partition table
sd 1:0:0:0: [sdb] Attached SCSI disk
scsi 3:0:0:0: Direct-Access     ATA      ST3160023AS      3.42 PQ: 0 ANSI: 5
sd 3:0:0:0: [sdc] 312581808 512-byte hardware sectors (160042 MB)
sd 3:0:0:0: [sdc] Write Protect is off
sd 3:0:0:0: [sdc] Mode Sense: 00 3a 00 00
sd 3:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
sd 3:0:0:0: [sdc] 312581808 512-byte hardware sectors (160042 MB)
sd 3:0:0:0: [sdc] Write Protect is off
sd 3:0:0:0: [sdc] Mode Sense: 00 3a 00 00
sd 3:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
 sdc: unknown partition table
sd 3:0:0:0: [sdc] Attached SCSI disk

.....

ata4.00: exception Emask 0x0 SAct 0x1 SErr 0x0 action 0x2 frozen
ata4.00: cmd 61/1f:00:f4:14:52/00:00:09:00:00/40 tag 0 cdb 0x0 data 15872 out
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata4: soft resetting port
ata4: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata4.00: configured for UDMA/133
ata4: EH complete
sd 3:0:0:0: [sdc] 312581808 512-byte hardware sectors (160042 MB)
sd 3:0:0:0: [sdc] Write Protect is off
sd 3:0:0:0: [sdc] Mode Sense: 00 3a 00 00
sd 3:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
ata4.00: exception Emask 0x0 SAct 0x1 SErr 0x0 action 0x2 frozen
ata4.00: cmd 61/40:00:e1:52:52/00:00:09:00:00/40 tag 0 cdb 0x0 data 32768 out
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata4: soft resetting port
ata4: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata4.00: configured for UDMA/133
ata4: EH complete
sd 3:0:0:0: [sdc] 312581808 512-byte hardware sectors (160042 MB)
sd 3:0:0:0: [sdc] Write Protect is off
sd 3:0:0:0: [sdc] Mode Sense: 00 3a 00 00
sd 3:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
ata4.00: exception Emask 0x0 SAct 0x1 SErr 0x0 action 0x2 frozen
ata4.00: cmd 61/19:00:4e:78:52/00:00:09:00:00/40 tag 0 cdb 0x0 data 12800 out
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata4: soft resetting port
ata4: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata4.00: configured for UDMA/133
ata4: EH complete
sd 3:0:0:0: [sdc] 312581808 512-byte hardware sectors (160042 MB)
sd 3:0:0:0: [sdc] Write Protect is off
sd 3:0:0:0: [sdc] Mode Sense: 00 3a 00 00
sd 3:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
ata4.00: NCQ disabled due to excessive errors
ata4.00: exception Emask 0x0 SAct 0x1 SErr 0x0 action 0x2 frozen
ata4.00: cmd 61/35:00:27:a2:52/00:00:09:00:00/40 tag 0 cdb 0x0 data 27136 out
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata4: soft resetting port
ata4: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata4.00: configured for UDMA/133
ata4: EH complete
sd 3:0:0:0: [sdc] 312581808 512-byte hardware sectors (160042 MB)
sd 3:0:0:0: [sdc] Write Protect is off
sd 3:0:0:0: [sdc] Mode Sense: 00 3a 00 00
sd 3:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA

Also, ST3320620AS is SATA2 according to the manufacturer, but i only
see libata setting the link to 1.5gbps.
