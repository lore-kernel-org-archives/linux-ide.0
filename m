From: "Tomi Orava" <tomimo+linux-ide@ncircle.nullnet.fi>
Subject: HPT366-driver cable detection bug
Date: Sun, 16 Nov 2003 19:26:50 +0200 (EET)
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <38172.192.168.9.10.1069003610.squirrel@ncircle.nullnet.fi>
References: <3FB4A448.3080402@computer.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ncircle.nullnet.fi ([62.236.96.207]:8341 "EHLO
	ncircle.nullnet.fi") by vger.kernel.org with ESMTP id S263019AbTKPR0x
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 16 Nov 2003 12:26:53 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by ncircle.nullnet.fi (Postfix) with ESMTP id 77B461CB56D2
	for <linux-ide@vger.kernel.org>; Sun, 16 Nov 2003 19:26:51 +0200 (EET)
Received: from ncircle.nullnet.fi ([127.0.0.1])
 by localhost (alderan.ncircle.nullnet.fi [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 10477-08 for <linux-ide@vger.kernel.org>;
 Sun, 16 Nov 2003 19:26:50 +0200 (EET)
Received: from ncircle.nullnet.fi (localhost.localdomain [127.0.0.1])
	by ncircle.nullnet.fi (Postfix) with SMTP
	for <linux-ide@vger.kernel.org>; Sun, 16 Nov 2003 19:26:50 +0200 (EET)
In-Reply-To: <3FB4A448.3080402@computer.org>
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


Hi,

I'm wondering if someone would be able to figure out
the reason why the hpt366-driver under up to and
including kernel versions 2.4.23-preX detect the controller 0,
channel 1 as ATA-33 instead of ATA-66 as it should be ?

The controller in question is HPT374 with 2xSamsung 80GB
and 2xSamsung 160GB disks and the cables are identical
and for sure 80-pins versions.

The highpoint drivers seem to detect the mode properly.
However, the source code of HighTechpoint's cable detection
seems quite a bit different compared to kernels own hpt366 source code
and I'm unable to figure out what goes wrong on the latter driver ...

I'd be really happy for any answers !

Regards,
Tomi Orava

PS. Is there any information available how to interpret the
       IDE PCI-card's configuration data from the lspci-output ?



Output of /proc/ide/hpt366:
----------------------------------------------------------------------------
                            HighPoint HPT366/368/370/372/374

Controller: 0
Chipset: HPT374
--------------- Primary Channel --------------- Secondary Channel
--------------
Enabled:        yes                             yes
Cable:          ATA-66                          ATA-33

--------------- drive0 --------- drive1 ------- drive0 ---------- drive1
-------
DMA capable:    yes              no             yes               no
Mode:           UDMA             off            UDMA              off

Controller: 1
Chipset: HPT374
--------------- Primary Channel --------------- Secondary Channel
--------------
Enabled:        yes                             yes
Cable:          ATA-66                          ATA-66

--------------- drive0 --------- drive1 ------- drive0 ---------- drive1
-------
DMA capable:    no               no             no                no
Mode:           UDMA             off            UDMA              off




The dmesg shows:
---------------------------------------------------------------------
HPT374: IDE controller at PCI slot 00:0e.0
HPT374: chipset revision 7
HPT374: not 100% native mode: will probe irqs later
HPT37X: using 33MHz PCI clock
    ide2: BM-DMA at 0xb800-0xb807, BIOS settings: hde:DMA, hdf:pio
    ide3: BM-DMA at 0xb808-0xb80f, BIOS settings: hdg:DMA, hdh:pio
HPT37X: using 33MHz PCI clock
    ide4: BM-DMA at 0xcc00-0xcc07, BIOS settings: hdi:DMA, hdj:pio
    ide5: BM-DMA at 0xcc08-0xcc0f, BIOS settings: hdk:DMA, hdl:pio
SiI680: IDE controller at PCI slot 00:09.0
SiI680: chipset revision 1
SiI680: not 100% native mode: will probe irqs later
SiI680: BASE CLOCK == 133
    ide6: MMIO-DMA , BIOS settings: hdm:pio, hdn:pio
    ide7: MMIO-DMA , BIOS settings: hdo:pio, hdp:pio
hda: GCR-8523B, ATAPI CD/DVD-ROM drive
hde: SAMSUNG SV8004H, ATA DISK drive
blk: queue c0470d28, I/O limit 4095Mb (mask 0xffffffff)
hdg: SAMSUNG SV8004H, ATA DISK drive
blk: queue c047117c, I/O limit 4095Mb (mask 0xffffffff)
hdi: SAMSUNG SV1604N, ATA DISK drive
blk: queue c04715d0, I/O limit 4095Mb (mask 0xffffffff)
hdk: SAMSUNG SV1604N, ATA DISK drive
blk: queue c0471a24, I/O limit 4095Mb (mask 0xffffffff)
hdm: MAXTOR 6L060J3, ATA DISK drive
blk: queue c0471e78, I/O limit 4095Mb (mask 0xffffffff)
hdo: MAXTOR 6L060J3, ATA DISK drive
blk: queue c04722cc, I/O limit 4095Mb (mask 0xffffffff)
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide2 at 0xa800-0xa807,0xac02 on irq 17
ide3 at 0xb000-0xb007,0xb402 on irq 17
ide4 at 0xbc00-0xbc07,0xc002 on irq 17
ide5 at 0xc400-0xc407,0xc802 on irq 17
ide6 at 0xf885d080-0xf885d087,0xf885d08a on irq 17
ide7 at 0xf885d0c0-0xf885d0c7,0xf885d0ca on irq 17
hde: attached ide-disk driver.
hde: host protected area => 1
hde: 156368016 sectors (80060 MB) w/2048KiB Cache, CHS=155127/16/63,
UDMA(100)
hdg: attached ide-disk driver.
hdg: host protected area => 1
hdg: 156368016 sectors (80060 MB) w/2048KiB Cache, CHS=155127/16/63,
UDMA(100)
hdi: attached ide-disk driver.
hdi: host protected area => 1
hdi: 312581808 sectors (160042 MB) w/2048KiB Cache, CHS=19457/255/63,
UDMA(100)
hdk: attached ide-disk driver.
hdk: host protected area => 1
hdk: 312581808 sectors (160042 MB) w/2048KiB Cache, CHS=19457/255/63,
UDMA(100)
hdm: attached ide-disk driver.
hdm: host protected area => 1
hdm: 117266688 sectors (60041 MB) w/1819KiB Cache, CHS=116336/16/63,
UDMA(133)
hdo: attached ide-disk driver.
hdo: host protected area => 1
hdo: 117266688 sectors (60041 MB) w/1819KiB Cache, CHS=116336/16/63,
UDMA(133)
hda: attached ide-scsi driver.
Partition check:
 hde: hde1 hde2 hde3
 hdg: hdg1 hdg2 hdg3
 hdi: hdi1 hdi2
 hdk: hdk1 hdk2
 hdm: hdm1 hdm2
 hdo: hdo1 hdo2
-------------------------------------------------------------------------------------------------

And finally the lspci -vvv -xxx shows for the hpt374-controller the following
configuration info:

----------------------------------------------------------------------------------------------------
00:0e.0 RAID bus controller: Triones Technologies, Inc. HPT374 (rev 07)
	Subsystem: Triones Technologies, Inc.: Unknown device 0001
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 120 (2000ns min, 2000ns max)
	Interrupt: pin A routed to IRQ 17
	Region 0: I/O ports at a800 [size=8]
	Region 1: I/O ports at ac00 [size=4]
	Region 2: I/O ports at b000 [size=8]
	Region 3: I/O ports at b400 [size=4]
	Region 4: I/O ports at b800 [size=256]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 03 11 08 00 05 00 30 02 07 00 04 01 00 78 80 00
10: 01 a8 00 00 01 ac 00 00 01 b0 00 00 01 b4 00 00
20: 01 b8 00 00 00 00 00 00 00 00 00 00 03 11 01 00
30: 00 00 00 00 60 00 00 00 00 00 00 00 11 01 08 08
40: 42 82 84 12 a7 4e 81 06 42 82 84 12 a7 4e 81 06
50: 05 00 00 00 05 00 00 00 1b 00 01 22 20 00 64 00
60: 01 00 22 00 00 00 00 00 00 08 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 93 00 f0 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:0e.1 RAID bus controller: Triones Technologies, Inc. HPT374 (rev 07)
	Subsystem: Triones Technologies, Inc.: Unknown device 0001
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 120 (2000ns min, 2000ns max)
	Interrupt: pin A routed to IRQ 17
	Region 0: I/O ports at bc00 [size=8]
	Region 1: I/O ports at c000 [size=4]
	Region 2: I/O ports at c400 [size=8]
	Region 3: I/O ports at c800 [size=4]
	Region 4: I/O ports at cc00 [size=256]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 03 11 08 00 07 00 30 02 07 00 04 01 00 78 80 00
10: 01 bc 00 00 01 c0 00 00 01 c4 00 00 01 c8 00 00
20: 01 cc 00 00 00 00 00 00 00 00 00 00 03 11 01 00
30: 00 00 00 00 60 00 00 00 00 00 00 00 11 01 08 08
40: 42 82 84 12 a7 4e 81 06 42 82 84 12 a7 4e 81 06
50: 05 00 00 00 05 00 00 00 1b 00 00 22 20 00 24 00
60: 01 00 22 00 00 00 00 00 00 08 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 96 00 f0 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

----------------------------------------------------------------------------------------------

If I use the hightechpoint's drivers the same data is little bit different:

----------------------------------------------------------------------------------------------------
00:0e.0 RAID bus controller: Triones Technologies, Inc. HPT374 (rev 07)
	Subsystem: Triones Technologies, Inc.: Unknown device 0001
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 64 (2000ns min, 2000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 17
	Region 0: I/O ports at a800 [size=8]
	Region 1: I/O ports at ac00 [size=4]
	Region 2: I/O ports at b000 [size=8]
	Region 3: I/O ports at b400 [size=4]
	Region 4: I/O ports at b800 [size=256]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 03 11 08 00 05 00 30 02 07 00 04 01 08 40 80 00
10: 01 a8 00 00 01 ac 00 00 01 b0 00 00 01 b4 00 00
20: 01 b8 00 00 00 00 00 00 00 00 00 00 03 11 01 00
30: 00 00 00 00 60 00 00 00 00 00 00 00 0b 01 08 08
40: 42 82 84 12 a7 4e 81 06 42 82 0c 12 a7 4e 81 06
50: 05 00 00 00 05 00 00 00 1f 00 00 21 20 00 22 00
60: 01 00 22 00 00 00 00 00 00 10 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 84 00 f0 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:0e.1 RAID bus controller: Triones Technologies, Inc. HPT374 (rev 07)
	Subsystem: Triones Technologies, Inc.: Unknown device 0001
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 64 (2000ns min, 2000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 17
	Region 0: I/O ports at bc00 [size=8]
	Region 1: I/O ports at c000 [size=4]
	Region 2: I/O ports at c400 [size=8]
	Region 3: I/O ports at c800 [size=4]
	Region 4: I/O ports at cc00 [size=256]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 03 11 08 00 05 00 30 02 07 00 04 01 08 40 80 00
10: 01 bc 00 00 01 c0 00 00 01 c4 00 00 01 c8 00 00
20: 01 cc 00 00 00 00 00 00 00 00 00 00 03 11 01 00
30: 00 00 00 00 60 00 00 00 00 00 00 00 0b 01 08 08
40: 42 82 84 12 a7 4e 81 06 42 82 84 12 a7 4e 81 06
50: 05 00 00 00 05 00 00 00 1b 00 00 21 20 00 22 00
60: 01 00 22 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 83 00 f0 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00




