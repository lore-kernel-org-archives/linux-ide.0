From: Brad Campbell <brad@wasp.net.au>
Subject: pata_hpt37x problem when writing on ports 2&3 with RocketRaid 1540
Date: Thu, 16 Nov 2006 17:29:35 +0400
Message-ID: <455C67BF.2020608@wasp.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wasp.net.au ([203.190.192.17]:20674 "EHLO wasp.net.au")
	by vger.kernel.org with ESMTP id S932857AbWKPNaF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 16 Nov 2006 08:30:05 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>

G'day all,

Rehash of an old problem. I've done a bit of homework and found this only occurs on the last 2 ports 
of the card. If I take the drives from ports 3&4 and put them on a SIL3112 I've got lying around, 
then the system works perfectly.

Diving deeper, the below problem only surfaces when *writing* to a drive on the last 2 ports. I can 
read as much as you like from the drives after bootup and it all goes swimmingly well, but on the 
1st write the system dies. Writing to ports 1&2 works perfectly well.

Like I've said previously, the system is a bit of a beater test system so I'm happy to keep 
looking/playing if anyone is interested.

I've tried the HPT37X ATA driver and it runs nicely, except on any drive error it disables DMA and 
cripples the machine.

In the meantime, I'll keep adding some printk's and try and narrow it down a bit further.

Linux storage2 2.6.19-rc5-mm2 #5 Thu Nov 16 16:52:42 GST 2006 i686 GNU/Linux

[   24.832237] pata_hpt37x: BIOS has not set timing clocks.
[   24.834301] hpt37x: HPT374: Bus clock 33MHz.
[   24.834364] ACPI: PCI Interrupt 0000:00:05.0[A] -> GSI 16 (level, low) -> IRQ 17
[   24.834548] ata1: PATA max UDMA/133 cmd 0xE000 ctl 0xE102 bmdma 0xE400 irq 17
[   24.834636] ata2: PATA max UDMA/133 cmd 0xE200 ctl 0xE302 bmdma 0xE408 irq 17
[   24.834703] scsi0 : pata_hpt37x
[   24.989705] ata1.00: ATA-6, max UDMA/100, 390622887 sectors: LBA48
[   24.989764] ata1.00: ata1: dev 0 multi count 16
[   24.989825] Find mode for 12 reports A81F442
[   24.991069] Find mode for DMA 69 reports 12848242
[   24.994465] ata1.00: configured for UDMA/100
[   24.994525] scsi1 : pata_hpt37x
[   25.149768] ata2.00: ATA-6, max UDMA/100, 390625000 sectors: LBA48
[   25.149820] ata2.00: ata2: dev 0 multi count 16
[   25.149874] Find mode for 12 reports A81F442
[   25.149926] Find mode for DMA 69 reports 12848242
[   25.153793] ata2.00: configured for UDMA/100
[   25.153993] scsi 0:0:0:0: Direct-Access     ATA      WDC WD2000JB-00D 02.1 PQ: 0 ANSI: 5
[   25.154158] SCSI device sda: 390622887 512-byte hdwr sectors (199999 MB)
[   25.154222] sda: Write Protect is off
[   25.154271] sda: Mode Sense: 00 3a 00 00
[   25.154288] SCSI device sda: drive cache: write back
[   25.154392] SCSI device sda: 390622887 512-byte hdwr sectors (199999 MB)
[   25.154451] sda: Write Protect is off
[   25.154499] sda: Mode Sense: 00 3a 00 00
[   25.154515] SCSI device sda: drive cache: write back
[   25.154565]  sda: sda1
[   25.167801] sd 0:0:0:0: Attached scsi disk sda
[   25.167956] scsi 1:0:0:0: Direct-Access     ATA      WDC WD2000JB-00D 75.1 PQ: 0 ANSI: 5
[   25.168103] SCSI device sdb: 390625000 512-byte hdwr sectors (200000 MB)
[   25.168164] sdb: Write Protect is off
[   25.168212] sdb: Mode Sense: 00 3a 00 00
[   25.168227] SCSI device sdb: drive cache: write back
[   25.168306] SCSI device sdb: 390625000 512-byte hdwr sectors (200000 MB)
[   25.168366] sdb: Write Protect is off
[   25.168414] sdb: Mode Sense: 00 3a 00 00
[   25.168429] SCSI device sdb: drive cache: write back
[   25.168478]  sdb: sdb1
[   25.179353] sd 1:0:0:0: Attached scsi disk sdb
[   25.179464] pata_hpt37x: BIOS has not set timing clocks.
[   25.181526] hpt37x: HPT374: Bus clock 33MHz.
[   25.181589] ACPI: PCI Interrupt 0000:00:05.1[A] -> GSI 16 (level, low) -> IRQ 17
[   25.181742] ata3: PATA max UDMA/133 cmd 0xE500 ctl 0xE602 bmdma 0xE900 irq 17
[   25.181830] ata4: PATA max UDMA/133 cmd 0xE700 ctl 0xE802 bmdma 0xE908 irq 17
[   25.181888] scsi2 : pata_hpt37x
[   25.337713] ata3.00: ATA-6, max UDMA/100, 390622887 sectors: LBA48
[   25.337765] ata3.00: ata3: dev 0 multi count 16
[   25.337825] Find mode for 12 reports A81F442
[   25.337877] Find mode for DMA 69 reports 12848242
[   25.341731] ata3.00: configured for UDMA/100
[   25.341784] scsi3 : pata_hpt37x
[   25.497527] ata4.00: ATA-6, max UDMA/100, 390625000 sectors: LBA48
[   25.497579] ata4.00: ata4: dev 0 multi count 16
[   25.497633] Find mode for 12 reports A81F442
[   25.497684] Find mode for DMA 69 reports 12848242
[   25.501503] ata4.00: configured for UDMA/100
[   25.501655] scsi 2:0:0:0: Direct-Access     ATA      WDC WD2000JB-00D 75.1 PQ: 0 ANSI: 5
[   25.501805] SCSI device sdc: 390622887 512-byte hdwr sectors (199999 MB)
[   25.501869] sdc: Write Protect is off
[   25.501917] sdc: Mode Sense: 00 3a 00 00
[   25.501934] SCSI device sdc: drive cache: write back
[   25.502029] SCSI device sdc: 390622887 512-byte hdwr sectors (199999 MB)
[   25.502088] sdc: Write Protect is off
[   25.502137] sdc: Mode Sense: 00 3a 00 00
[   25.502152] SCSI device sdc: drive cache: write back
[   25.502202]  sdc: sdc1
[   25.527692] sd 2:0:0:0: Attached scsi disk sdc
[   25.527845] scsi 3:0:0:0: Direct-Access     ATA      WDC WD2000JB-00D 75.1 PQ: 0 ANSI: 5
[   25.527983] SCSI device sdd: 390625000 512-byte hdwr sectors (200000 MB)
[   25.528044] sdd: Write Protect is off
[   25.528092] sdd: Mode Sense: 00 3a 00 00
[   25.528107] SCSI device sdd: drive cache: write back
[   25.528187] SCSI device sdd: 390625000 512-byte hdwr sectors (200000 MB)
[   25.528246] sdd: Write Protect is off
[   25.528295] sdd: Mode Sense: 00 3a 00 00
[   25.528310] SCSI device sdd: drive cache: write back
[   25.528361]  sdd: sdd1
[   25.544113] sd 3:0:0:0: Attached scsi disk sdd


[  146.149034] irq 17: nobody cared (try booting with the "irqpoll" option)
[  146.149088]  [<b013526a>] __report_bad_irq+0x2a/0x90
[  146.149177]  [<b0135364>] note_interrupt+0x74/0x110
[  146.149259]  [<b0135a2a>] handle_fasteoi_irq+0x8a/0xa0
[  146.149345]  [<b0105529>] do_IRQ+0x39/0x80
[  146.149429]  [<b010b180>] local_apic_timer_interrupt+0x30/0x40
[  146.149514]  [<b0103763>] common_interrupt+0x23/0x28
[  146.149596]  [<b0100db0>] default_idle+0x0/0x40
[  146.149678]  [<b0100dd7>] default_idle+0x27/0x40
[  146.149759]  [<b0100e57>] cpu_idle+0x57/0x60
[  146.149840]  [<b045c7d2>] start_kernel+0x172/0x1a0
[  146.149928]  [<b045c340>] unknown_bootoption+0x0/0x1a0
[  146.150015]  =======================
[  146.150063] handlers:
[  146.150108] [<b02955b0>] (ata_interrupt+0x0/0x180)
[  146.150233] [<b02955b0>] (ata_interrupt+0x0/0x180)
[  146.150356] Disabling IRQ #17


0000:00:05.0 RAID bus controller: Triones Technologies, Inc. HPT374 (rev 07)
         Subsystem: Triones Technologies, Inc.: Unknown device 0001
         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- 
<PERR-
         Latency: 120 (2000ns min, 2000ns max)
         Interrupt: pin A routed to IRQ 18
         Region 0: I/O ports at d000 [size=8]
         Region 1: I/O ports at d100 [size=4]
         Region 2: I/O ports at d200 [size=8]
         Region 3: I/O ports at d300 [size=4]
         Region 4: I/O ports at d400 [size=256]
         Expansion ROM at 40080000 [disabled] [size=128K]
         Capabilities: [60] Power Management version 2
                 Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:05.1 RAID bus controller: Triones Technologies, Inc. HPT374 (rev 07)
         Subsystem: Triones Technologies, Inc.: Unknown device 0001
         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- 
<PERR-
         Latency: 120 (2000ns min, 2000ns max)
         Interrupt: pin A routed to IRQ 18
         Region 0: I/O ports at d500 [size=8]
         Region 1: I/O ports at d600 [size=4]
         Region 2: I/O ports at d700 [size=8]
         Region 3: I/O ports at d800 [size=4]
         Region 4: I/O ports at d900 [size=256]
         Capabilities: [60] Power Management version 2
                 Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-


Brad
-- 
"Human beings, who are almost unique in having the ability
to learn from the experience of others, are also remarkable
for their apparent disinclination to do so." -- Douglas Adams
