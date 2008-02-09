From: "Andrew Paprocki" <andrew@ishiboo.com>
Subject: 2.6.24 found 5 exceptions in dmesg after not using the system for while
Date: Sat, 9 Feb 2008 18:14:12 -0500
Message-ID: <76366b180802091514k23cc5b0dw875386427eacf881@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.187]:3618 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753479AbYBIXOP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 9 Feb 2008 18:14:15 -0500
Received: by rv-out-0910.google.com with SMTP id k20so2913019rvb.1
        for <linux-ide@vger.kernel.org>; Sat, 09 Feb 2008 15:14:13 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

I haven't used the system with these errors in a day or two and I came
back and noticed 5 exceptions in dmesg. These are all the same:

ata1: exception Emask 0x10 SAct 0x0 SErr 0x90200 action 0xe frozen
ata1: irq_stat 0x00400000, PHY RDY changed
ata1: SError: { Persist PHYRdyChg 10B8B }
ata1: hard resetting link
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.00: configured for UDMA/133
ata1: EH complete
sd 0:0:0:0: [sda] 488397168 512-byte hardware sectors (250059 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA

Any idea what caused these? This is on a ATI SB600 SATA controller:

00:12.0 SATA controller [0106]: ATI Technologies Inc SB600 Non-Raid-5
SATA [1002:4380] (prog-if 01 [AHCI 1.0])
        Subsystem: Albatron Corp. Unknown device [17f2:5999]
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Interrupt: pin A routed to IRQ 18
        Region 0: I/O ports at ff00 [size=8]
        Region 1: I/O ports at fe00 [size=4]
        Region 2: I/O ports at fd00 [size=8]
        Region 3: I/O ports at fc00 [size=4]
        Region 4: I/O ports at fb00 [size=16]
        Region 5: Memory at fe02f000 (32-bit, non-prefetchable) [size=1K]
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [70] #12 [0010]

>From boot time:

ata1: SATA max UDMA/133 abar m1024@0xfe02f000 port 0xfe02f100 irq 18
ata2: SATA max UDMA/133 abar m1024@0xfe02f000 port 0xfe02f180 irq 18
ata3: SATA max UDMA/133 abar m1024@0xfe02f000 port 0xfe02f200 irq 18
ata4: SATA max UDMA/133 abar m1024@0xfe02f000 port 0xfe02f280 irq 18
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.00: ATA-7: HDT722525DLA380, V44OA96A, max UDMA/133
ata1.00: 488397168 sectors, multi 16: LBA48 NCQ (depth 31/32)
ata1.00: configured for UDMA/133
ata2: SATA link down (SStatus 0 SControl 300)
ata3: SATA link down (SStatus 0 SControl 300)
ata4: SATA link down (SStatus 0 SControl 300)
scsi 0:0:0:0: Direct-Access     ATA      HDT722525DLA380  V44O PQ: 0 ANSI: 5
sd 0:0:0:0: [sda] 488397168 512-byte hardware sectors (250059 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO
 or FUA
sd 0:0:0:0: [sda] 488397168 512-byte hardware sectors (250059 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO
 or FUA
 sda: sda1
sd 0:0:0:0: [sda] Attached SCSI disk

Thanks,
-Andrew
