From: Jim Paris <jim@jtan.com>
Subject: Re: sata_sis only recognizing primary drive in 2.6.18
Date: Fri, 6 Oct 2006 17:22:51 -0400
Message-ID: <20061006212251.GA1324@jim.sh>
References: <20061006065816.GA5782@jim.sh> <45263683.408@gmx.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="LQksG6bCIzRHxTLp"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from NEUROSIS.MIT.EDU ([18.95.3.133]:18379 "EHLO neurosis.jim.sh")
	by vger.kernel.org with ESMTP id S932641AbWJFVXC (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 6 Oct 2006 17:23:02 -0400
Content-Disposition: inline
In-Reply-To: <45263683.408@gmx.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Uwe Koziolek <uwe.koziolek@gmx.net>
Cc: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org, muthas@mit.edu, fragmede@gmail.com


--LQksG6bCIzRHxTLp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Uwe Koziolek wrote:
> the sata_sis is running without slave support in the versions from
> kernel.org. That is ok if you are using
> a SiS964 and 965L chip. The SiS 965, SiS180 and SiS966 needs a slave
> support.
> 
> The attached patch against 2.6.18 should help.
>
> + .host_flags = ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY | ATA_FLAG_SLAVE_POSS,

Hi Uwe,

Adding ATA_FLAG_SLAVE_POSS works great -- all drives are now recognized.
dmesg and lspci output are attached.

Thank you!

-jim

--LQksG6bCIzRHxTLp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="lspci.txt"

00:00.0 Host bridge: Silicon Integrated Systems [SiS] 761/M761 Host (rev 01)
	Subsystem: Foxconn International, Inc. Unknown device 0c67
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 32
	Region 0: Memory at b0000000 (32-bit, non-prefetchable) [size=256M]
	Capabilities: [a0] AGP version 3.0
		Status: RQ=32 Iso- ArqSz=2 Cal=3 SBA+ ITACoh- GART64- HTrans- 64bit- FW+ AGP3+ Rate=x4,x8
		Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=<none>
	Capabilities: [d0] HyperTransport: Slave or Primary Interface
		Command: BaseUnitID=0 UnitCnt=17 MastHost- DefDir- DUL-
		Link Control 0: CFlE- CST- CFE- <LkFail- Init+ EOC- TXO- <CRCErr=0 IsocEn- LSEn- ExtCTL- 64b-
		Link Config 0: MLWI=16bit DwFcIn- MLWO=16bit DwFcOut- LWI=16bit DwFcInEn- LWO=16bit DwFcOutEn-
		Link Control 1: CFlE- CST- CFE- <LkFail+ Init- EOC+ TXO+ <CRCErr=0 IsocEn- LSEn- ExtCTL- 64b-
		Link Config 1: MLWI=N/C DwFcIn- MLWO=N/C DwFcOut- LWI=N/C DwFcInEn- LWO=N/C DwFcOutEn-
		Revision ID: 1.05
		Link Frequency 0: 1.0GHz
		Link Error 0: <Prot- <Ovfl- <EOC- CTLTm-
		Link Frequency Capability 0: 200MHz+ 300MHz- 400MHz+ 500MHz- 600MHz- 800MHz+ 1.0GHz+ 1.2GHz- 1.4GHz- 1.6GHz- Vend-
		Feature Capability: IsocFC- LDTSTOP+ CRCTM- ECTLT- 64bA+ UIDRD-
		Link Frequency 1: 200MHz
		Link Error 1: <Prot- <Ovfl- <EOC- CTLTm-
		Link Frequency Capability 1: 200MHz- 300MHz- 400MHz- 500MHz- 600MHz- 800MHz- 1.0GHz- 1.2GHz- 1.4GHz- 1.6GHz- Vend-
		Error Handling: PFlE- OFlE- PFE- OFE- EOCFE- RFE- CRCFE- SERRFE- CF- RE- PNFE- ONFE- EOCNFE- RNFE- CRCNFE- SERRNFE-
		Prefetchable memory behind bridge Upper: 00-00
		Bus Number: 00
	Capabilities: [f0] HyperTransport: Interrupt Discovery and Configuration
	Capabilities: [5c] HyperTransport: Revision ID: 1.05
00: 39 10 61 07 07 00 10 22 01 00 00 06 00 20 00 00
10: 00 00 00 b0 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 5b 10 67 0c
30: 00 00 00 00 a0 00 00 00 00 00 00 00 ff 00 00 00
40: 06 00 b9 8b 05 ff 90 a0 00 00 00 00 00 00 00 02
50: 00 00 00 00 00 00 00 00 00 00 00 44 08 00 25 88
60: 00 00 00 00 00 00 00 00 4c 00 00 07 dd ad e8 4d
70: 7c 80 10 00 01 10 00 00 00 00 00 00 00 00 29 10
80: 00 00 00 00 00 00 14 c8 00 00 00 10 00 03 00 80
90: 0a 40 10 03 00 00 00 00 00 00 00 00 00 00 00 00
a0: 02 d0 30 00 1b 4e 00 1f 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 0f 01 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 08 f0 20 02 20 00 11 11 d0 00 77 77 25 06 65 00
e0: 12 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 08 5c 00 80 f4 08 00 00 00 00 00 00 68 68 44 00

00:01.0 PCI bridge: Silicon Integrated Systems [SiS] PCI-to-PCI bridge (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size: 32 bytes
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 0000c000-0000cfff
	Memory behind bridge: d4000000-dbffffff
	Prefetchable memory behind bridge: 00000000c0000000-00000000c7ffffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-
	Capabilities: [d0] Express Root Port (Slot+) IRQ 0
		Device: Supported: MaxPayload 128 bytes, PhantFunc 0, ExtTag+
		Device: Latency L0s <64ns, L1 <1us
		Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
		Device: RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
		Device: MaxPayload 128 bytes, MaxReadReq 128 bytes
		Link: Supported Speed 2.5Gb/s, Width x16, ASPM unknown, Port 0
		Link: Latency L0s <1us, L1 <2us
		Link: ASPM Disabled RCB 64 bytes CommClk- ExtSynch-
		Link: Speed 2.5Gb/s, Width x16
		Slot: AtnBtn- PwrCtrl- MRL- AtnInd- PwrInd- HotPlug- Surpise-
		Slot: Number 0, PowerLimit 75.000000
		Slot: Enabled AtnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq-
		Slot: AttnInd Off, PwrInd Off, Power-
		Root: Correctable- Non-Fatal- Fatal- PME-
	Capabilities: [bc] HyperTransport: MSI Mapping
	Capabilities: [a0] Message Signalled Interrupts: Mask- 64bit- Queue=0/0 Enable+
		Address: feeff000  Data: 4041
	Capabilities: [f4] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [b0] Subsystem: Silicon Integrated Systems [SiS] Unknown device 0000
00: 39 10 04 00 07 04 10 00 00 00 04 06 08 00 01 00
10: 00 00 00 00 00 00 00 00 00 01 01 00 c1 c1 00 00
20: 00 d4 f0 db 01 c0 f1 c7 00 00 00 00 00 00 00 00
30: 00 00 00 00 d0 00 00 00 00 00 00 00 09 01 08 00
40: 10 00 00 78 02 10 01 00 52 e3 00 16 80 02 00 00
50: 00 00 00 2e 00 00 00 00 80 c1 05 00 52 ff 11 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 07 77 27 13 97 00 00 00 00 00 00 00 00 00 00 00
a0: 05 f4 01 00 00 f0 ef fe 41 40 00 00 00 00 00 00
b0: 0d 00 00 00 39 10 00 00 00 00 00 00 08 a0 02 a8
c0: 40 01 18 00 02 88 43 28 00 10 19 00 00 00 60 5c
d0: 10 bc 41 01 20 00 00 00 10 08 10 00 01 c1 10 00
e0: 00 00 01 31 80 25 00 00 c0 03 40 00 00 00 00 00
f0: 00 00 00 00 01 b0 02 c8 00 00 00 00 00 00 00 00

00:02.0 ISA bridge: Silicon Integrated Systems [SiS] SiS965 [MuTIOL Media IO] (rev 48)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
00: 39 10 65 09 0f 00 00 02 48 00 01 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 93 09 0b 0a 05 60 3d dd 12 00 00 00 11 20 04 01
50: 11 28 02 01 61 0b 63 0b a5 12 12 00 36 06 b6 00
60: 05 0a 0b 06 ff c1 0c 12 09 80 00 00 80 00 00 00
70: 00 00 ff ff 00 10 03 3e 20 00 00 80 02 00 00 40
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 1f 00 00 00 01 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 f0 01 08 00 00 00 00 7c 80 10 00 00 00 00 75
d0: 03 00 00 00 44 63 30 00 45 00 04 6b aa aa aa aa
e0: 40 00 00 f8 43 00 44 00 00 00 00 00 00 00 00 00
f0: 0a 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:02.5 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] (rev 01) (prog-if 80 [Master])
	Subsystem: Foxconn International, Inc. Unknown device 0c67
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 128
	Interrupt: pin ? routed to IRQ 9
	Region 0: I/O ports at <unassigned>
	Region 1: I/O ports at <unassigned>
	Region 2: I/O ports at <unassigned>
	Region 3: I/O ports at <unassigned>
	Region 4: I/O ports at 4000 [size=16]
	Capabilities: [58] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 39 10 13 55 05 00 10 02 01 80 01 01 00 80 00 00
10: 01 00 00 00 01 00 00 00 01 00 00 00 01 00 00 00
20: 01 40 00 00 00 00 00 00 00 00 00 00 5b 10 67 0c
30: 00 00 00 00 58 00 00 00 00 00 00 00 00 00 00 00
40: 00 00 00 00 00 00 00 00 00 00 06 00 00 00 00 00
50: 82 21 82 21 2a 96 80 d0 01 00 02 80 00 00 00 00
60: fb aa fb aa 00 00 00 00 c8 00 a0 00 00 00 ff ff
70: 26 21 06 04 00 60 1c 1e 56 23 06 04 00 60 1c 1e
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:02.7 Multimedia audio controller: Silicon Integrated Systems [SiS] AC'97 Sound Controller (rev a0)
	Subsystem: Foxconn International, Inc. Unknown device 0c67
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (13000ns min, 2750ns max)
	Interrupt: pin C routed to IRQ 10
	Region 0: I/O ports at f000 [size=256]
	Region 1: I/O ports at fe00 [size=128]
	Capabilities: [48] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=55mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 39 10 12 70 05 00 90 02 a0 00 01 04 00 20 00 00
10: 01 f0 00 00 01 fe 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 5b 10 67 0c
30: 00 00 00 00 48 00 00 00 00 00 00 00 0a 03 34 0b
40: 04 00 00 00 00 00 00 00 01 00 42 c6 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 04 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:03.0 USB Controller: Silicon Integrated Systems [SiS] USB 1.0 Controller (rev 0f) (prog-if 10 [OHCI])
	Subsystem: Foxconn International, Inc. Unknown device 0c67
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (20000ns max), Cache Line Size: 32 bytes
	Interrupt: pin A routed to IRQ 5
	Region 0: Memory at dffff000 (32-bit, non-prefetchable) [size=4K]
00: 39 10 01 70 07 00 80 02 0f 10 03 0c 08 20 80 00
10: 00 f0 ff df 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 5b 10 67 0c
30: 00 00 00 00 00 00 00 00 00 00 00 00 05 01 00 50
40: 00 00 00 00 54 af 01 00 7f 02 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 01 00 c2 c9
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:03.1 USB Controller: Silicon Integrated Systems [SiS] USB 1.0 Controller (rev 0f) (prog-if 10 [OHCI])
	Subsystem: Foxconn International, Inc. Unknown device 0c67
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (20000ns max), Cache Line Size: 32 bytes
	Interrupt: pin B routed to IRQ 10
	Region 0: Memory at dfffe000 (32-bit, non-prefetchable) [size=4K]
00: 39 10 01 70 07 00 80 02 0f 10 03 0c 08 20 00 00
10: 00 e0 ff df 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 5b 10 67 0c
30: 00 00 00 00 00 00 00 00 00 00 00 00 0a 02 00 50
40: 00 00 00 00 54 af 01 00 7f 02 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 01 00 c2 c9
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:03.2 USB Controller: Silicon Integrated Systems [SiS] USB 1.0 Controller (rev 0f) (prog-if 10 [OHCI])
	Subsystem: Foxconn International, Inc. Unknown device 0c67
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (20000ns max), Cache Line Size: 32 bytes
	Interrupt: pin C routed to IRQ 11
	Region 0: Memory at dfffd000 (32-bit, non-prefetchable) [size=4K]
00: 39 10 01 70 07 00 80 02 0f 10 03 0c 08 20 00 00
10: 00 d0 ff df 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 5b 10 67 0c
30: 00 00 00 00 00 00 00 00 00 00 00 00 0b 03 00 50
40: 00 00 00 00 54 af 01 00 7f 02 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 01 00 c2 c9
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:03.3 USB Controller: Silicon Integrated Systems [SiS] USB 2.0 Controller (prog-if 20 [EHCI])
	Subsystem: Silicon Integrated Systems [SiS] USB 2.0 Controller
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (20000ns max)
	Interrupt: pin D routed to IRQ 6
	Region 0: Memory at dfffc000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 39 10 02 70 06 00 90 02 00 20 03 0c 00 20 00 00
10: 00 c0 ff df 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 39 10 02 70
30: 00 00 00 00 50 00 00 00 00 00 00 00 06 04 00 50
40: 20 00 00 08 04 00 00 00 00 00 00 00 00 00 00 00
50: 01 00 c2 c9 00 00 00 00 0a 00 00 21 00 00 00 00
60: 20 20 ff 01 00 00 00 00 00 00 00 00 00 00 00 00
70: 01 00 00 01 00 00 08 e0 00 00 c7 3f 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:04.0 Ethernet controller: Silicon Integrated Systems [SiS] 191 Gigabit Ethernet Adapter
	Subsystem: Foxconn International, Inc. Unknown device 0c67
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 5
	Region 0: Memory at dfffb000 (32-bit, non-prefetchable) [size=128]
	Region 1: I/O ports at fd00 [size=128]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 39 10 91 01 07 00 10 02 00 00 00 02 00 00 00 00
10: 00 b0 ff df 01 fd 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 5b 10 67 0c
30: 00 00 00 00 40 00 00 00 00 00 00 00 05 01 00 00
40: 01 00 02 fe 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 40 00 00 00 00 00 00 00 00 04 05 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:05.0 IDE interface: Silicon Integrated Systems [SiS] 182 SATA/RAID Controller (rev 01) (prog-if 85 [Master SecO PriO])
	Subsystem: Foxconn International, Inc. Unknown device 0c67
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at fc00 [size=8]
	Region 1: I/O ports at fb00 [size=4]
	Region 2: I/O ports at fa00 [size=8]
	Region 3: I/O ports at f900 [size=4]
	Region 4: I/O ports at f800 [size=16]
	Region 5: I/O ports at f700 [size=128]
	Capabilities: [58] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 39 10 82 01 05 00 10 02 01 85 01 01 00 20 00 00
10: 01 fc 00 00 01 fb 00 00 01 fa 00 00 01 f9 00 00
20: 01 f8 00 00 01 f7 00 00 00 00 00 00 5b 10 67 0c
30: 00 00 00 00 58 00 00 00 00 00 00 00 0b 01 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 82 00 82 00 2a 96 80 14 01 00 02 80 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 80
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: bf 33 72 c0 bf 33 72 c0 bf 33 72 40 bf 33 72 40
90: 60 00 00 f0 c0 05 c0 05 cc 04 0c 10 c0 05 c0 05
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: c0 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 13 01 00 00 00 00 00 00 00 03 00 00 00 00 00 00
d0: 13 01 00 00 00 00 00 00 00 03 00 00 00 00 00 00
e0: 00 00 00 00 01 00 18 00 00 03 00 00 00 00 00 00
f0: 00 00 00 00 01 00 18 00 00 03 00 00 00 00 00 00

00:06.0 PCI bridge: Silicon Integrated Systems [SiS] PCI-to-PCI bridge (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size: 32 bytes
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
	I/O behind bridge: 0000b000-0000bfff
	Memory behind bridge: dfb00000-dfbfffff
	Prefetchable memory behind bridge: 00000000dfe00000-00000000dfefffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
	Capabilities: [d0] Express Root Port (Slot+) IRQ 0
		Device: Supported: MaxPayload 128 bytes, PhantFunc 0, ExtTag+
		Device: Latency L0s <64ns, L1 <1us
		Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
		Device: RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
		Device: MaxPayload 128 bytes, MaxReadReq 128 bytes
		Link: Supported Speed 2.5Gb/s, Width x16, ASPM L0s L1, Port 0
		Link: Latency L0s <1us, L1 <2us
		Link: ASPM Disabled RCB 64 bytes CommClk- ExtSynch-
		Link: Speed 2.5Gb/s, Width x1
		Slot: AtnBtn- PwrCtrl- MRL- AtnInd- PwrInd- HotPlug- Surpise-
		Slot: Number 0, PowerLimit 0.000000
		Slot: Enabled AtnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq-
		Slot: AttnInd Off, PwrInd Off, Power-
		Root: Correctable- Non-Fatal- Fatal- PME-
	Capabilities: [f4] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [100] Virtual Channel
	Capabilities: [130] Advanced Error Reporting
00: 39 10 0a 00 07 00 10 00 00 00 04 06 08 00 01 00
10: 00 00 00 00 00 00 00 00 00 02 02 00 b1 b1 00 00
20: b0 df b0 df e1 df e1 df 00 00 00 00 00 00 00 00
30: 00 00 00 00 d0 00 00 00 00 00 00 00 ff 00 00 00
40: 00 00 00 00 00 00 00 00 03 06 0c 00 00 00 08 00
50: 2e 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 08 b0 02 a8 00 00 00 00 00 00 00 00 00 00 00 00
b0: 0d c0 00 00 39 10 00 00 00 00 00 00 00 00 00 00
c0: 05 d0 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 10 f4 41 01 20 00 00 00 10 08 10 00 01 cd 00 00
e0: 00 00 11 10 00 00 00 00 c0 03 40 00 00 00 00 00
f0: 00 00 00 00 01 00 02 c8 00 00 00 00 00 00 00 00

00:07.0 PCI bridge: Silicon Integrated Systems [SiS] PCI-to-PCI bridge (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size: 32 bytes
	Bus: primary=00, secondary=03, subordinate=03, sec-latency=0
	I/O behind bridge: 0000d000-0000dfff
	Memory behind bridge: dfd00000-dfdfffff
	Prefetchable memory behind bridge: 00000000dfc00000-00000000dfcfffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
	Capabilities: [d0] Express Root Port (Slot+) IRQ 0
		Device: Supported: MaxPayload 128 bytes, PhantFunc 0, ExtTag+
		Device: Latency L0s <64ns, L1 <1us
		Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
		Device: RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
		Device: MaxPayload 128 bytes, MaxReadReq 128 bytes
		Link: Supported Speed 2.5Gb/s, Width x16, ASPM L0s L1, Port 0
		Link: Latency L0s <1us, L1 <2us
		Link: ASPM Disabled RCB 64 bytes CommClk- ExtSynch-
		Link: Speed 2.5Gb/s, Width x0
		Slot: AtnBtn- PwrCtrl- MRL- AtnInd- PwrInd- HotPlug- Surpise-
		Slot: Number 0, PowerLimit 0.000000
		Slot: Enabled AtnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq-
		Slot: AttnInd Off, PwrInd Off, Power-
		Root: Correctable- Non-Fatal- Fatal- PME-
	Capabilities: [f4] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [100] Virtual Channel
	Capabilities: [130] Advanced Error Reporting
00: 39 10 0a 00 07 00 10 00 00 00 04 06 08 00 01 00
10: 00 00 00 00 00 00 00 00 00 03 03 00 d1 d1 00 00
20: d0 df d0 df c1 df c1 df 00 00 00 00 00 00 00 00
30: 00 00 00 00 d0 00 00 00 00 00 00 00 ff 00 00 00
40: 00 00 00 00 00 00 00 00 03 06 0c 00 00 00 08 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 08 b0 02 a8 00 00 00 00 00 00 00 00 00 00 00 00
b0: 0d c0 00 00 39 10 00 00 00 00 00 00 00 00 00 00
c0: 05 d0 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 10 f4 41 01 20 00 00 00 10 08 10 00 01 cd 00 00
e0: 00 00 01 10 00 00 00 00 c0 03 40 00 00 00 00 00
f0: 00 00 00 00 01 00 02 c8 00 00 00 00 00 00 00 00

00:0a.0 VGA compatible controller: nVidia Corporation NV18 [GeForce4 MX 4000 AGP 8x] (rev c1) (prog-if 00 [VGA])
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at de000000 (32-bit, non-prefetchable) [disabled] [size=16M]
	Region 1: Memory at c8000000 (32-bit, prefetchable) [disabled] [size=128M]
	[virtual] Expansion ROM at 80000000 [disabled] [size=128K]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: de 10 85 01 00 00 b0 02 c1 00 00 03 00 20 00 00
10: 00 00 00 de 08 00 00 c8 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 60 00 00 00 00 00 00 00 0b 01 05 01
40: 00 00 00 00 02 00 30 00 17 02 00 1f 00 00 00 00
50: 00 00 00 00 01 00 00 00 ce d6 23 00 0f 00 00 00
60: 01 00 02 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:0b.0 RAID bus controller: Triones Technologies, Inc. HPT302/302N (rev 02)
	Subsystem: Triones Technologies, Inc. Unknown device 0001
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 120 (2000ns min, 2000ns max)
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at f600 [size=8]
	Region 1: I/O ports at f500 [size=4]
	Region 2: I/O ports at f400 [size=8]
	Region 3: I/O ports at f300 [size=4]
	Region 4: I/O ports at ee00 [size=256]
	Expansion ROM at 80020000 [disabled by cmd] [size=128K]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 03 11 06 00 05 00 30 02 02 00 04 01 00 78 00 00
10: 01 f6 00 00 01 f5 00 00 01 f4 00 00 01 f3 00 00
20: 01 ee 00 00 00 00 00 00 00 00 00 00 03 11 01 00
30: 01 00 02 80 60 00 00 00 00 00 00 00 0a 01 08 08
40: 62 dc 6d 1c 8a f4 c1 0a 62 dc 6d 1c 8a f4 c1 0a
50: 05 00 00 00 05 00 00 00 1b 00 00 23 1a 00 1c 00
60: 01 00 22 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 6c 00 f0 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] HyperTransport Technology Configuration
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Capabilities: [80] HyperTransport: Host or Secondary Interface
		!!! Possibly incomplete decoding
		Command: WarmRst+ DblEnd-
		Link Control: CFlE- CST- CFE- <LkFail- Init+ EOC- TXO- <CRCErr=0
		Link Config: MLWI=16bit MLWO=16bit LWI=16bit LWO=16bit
		Revision ID: 1.02
00: 22 10 00 11 00 00 10 00 00 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 80 00 00 00 00 00 00 00 00 00 00 00
40: 01 01 01 00 01 01 01 00 01 01 01 00 01 01 01 00
50: 01 01 01 00 01 01 01 00 01 01 01 00 01 01 01 00
60: 00 00 00 00 e4 00 00 00 0f cc 00 0f 0c 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 08 00 01 21 20 00 11 11 22 06 75 80 02 00 00 00
90: 56 04 51 02 00 00 03 00 07 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Address Map
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
00: 22 10 01 11 00 00 00 00 00 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 03 00 00 00 00 00 7f 00 00 00 00 00 01 00 00 00
50: 00 00 00 00 02 00 00 00 00 00 00 00 03 00 00 00
60: 00 00 00 00 04 00 00 00 00 00 00 00 05 00 00 00
70: 00 00 00 00 06 00 00 00 00 00 00 00 07 00 00 00
80: 03 0a 00 00 00 0b 00 00 00 00 00 00 00 00 00 00
90: 03 00 80 00 00 ff df 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 03 00 f0 00 00 ff ef 00
b0: 03 00 e0 00 80 3f e0 00 00 00 00 00 00 00 00 00
c0: 13 b0 00 00 00 f0 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 03 00 00 03 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] DRAM Controller
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
00: 22 10 02 11 00 00 00 00 00 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 01 00 00 00 01 20 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 de e0 07 00 de e0 07 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 07 00 00 00 00 00 00 00 52 3f 73 13 11 0b 00 00
90: 00 8e 05 a8 07 07 7b 3e 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 72 9f ed 84 62 00 00 00 d2 6d 14 80 c4 b1 ec 08
c0: 00 80 00 00 00 20 00 00 00 00 00 00 00 00 00 00
d0: 46 ae c7 06 d8 46 db c0 31 64 19 29 e6 65 80 49
e0: 21 e8 92 00 40 46 05 7a 2c ae 3a 32 31 02 c0 e3
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Miscellaneous Control
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
00: 22 10 03 11 00 00 00 00 00 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: ff 3b 00 00 40 00 00 00 00 00 00 00 00 00 00 00
50: 40 00 20 00 10 00 00 00 00 00 00 00 00 a2 27 ee
60: 37 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 11 01 02 51 11 80 00 50 00 38 00 08 1b 22 00 00
80: 00 00 07 23 13 21 13 21 00 00 00 00 00 00 00 00
90: 06 00 00 00 58 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 3a 00 00 40 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 01 a7 0d 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 20 01 4e 09 19 05 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

01:00.0 VGA compatible controller: nVidia Corporation NV43 [GeForce 6600 PCIe] (rev a2) (prog-if 00 [VGA])
	Subsystem: eVga.com. Corp. Unknown device c363
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size: 32 bytes
	Interrupt: pin A routed to IRQ 9
	Region 0: Memory at d4000000 (32-bit, non-prefetchable) [size=64M]
	Region 1: Memory at c0000000 (64-bit, prefetchable) [size=128M]
	Region 3: Memory at da000000 (64-bit, non-prefetchable) [size=16M]
	[virtual] Expansion ROM at d8000000 [disabled] [size=128K]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [68] Message Signalled Interrupts: Mask- 64bit+ Queue=0/0 Enable-
		Address: 0000000000000000  Data: 0000
	Capabilities: [78] Express Endpoint IRQ 0
		Device: Supported: MaxPayload 128 bytes, PhantFunc 0, ExtTag-
		Device: Latency L0s <512ns, L1 <4us
		Device: AtnBtn- AtnInd- PwrInd-
		Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
		Device: RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
		Device: MaxPayload 128 bytes, MaxReadReq 512 bytes
		Link: Supported Speed 2.5Gb/s, Width x16, ASPM L0s L1, Port 0
		Link: Latency L0s <1us, L1 <4us
		Link: ASPM Disabled RCB 128 bytes CommClk- ExtSynch-
		Link: Speed 2.5Gb/s, Width x16
	Capabilities: [100] Virtual Channel
	Capabilities: [128] Power Budgeting
00: de 10 42 01 07 00 10 00 a2 00 00 03 08 00 00 00
10: 00 00 00 d4 0c 00 00 c0 00 00 00 00 04 00 00 da
20: 00 00 00 00 00 00 00 00 00 00 00 00 42 38 63 c3
30: 00 00 00 00 60 00 00 00 00 00 00 00 09 01 00 00
40: 42 38 63 c3 00 00 00 00 00 00 00 00 00 00 00 00
50: 01 00 00 00 01 00 00 00 ce d6 23 00 00 00 00 00
60: 01 68 02 00 00 00 00 00 05 78 80 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 10 00 01 00 c0 04 2c 01
80: 10 28 0a 00 01 4d 01 00 08 00 01 11 00 00 00 00
90: 00 00 00 00 00 00 00 00 0c 08 40 c1 01 04 40 c1
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

02:00.0 Ethernet controller: Marvell Technology Group Ltd. 88E8053 PCI-E Gigabit Ethernet Controller (rev 20)
	Subsystem: SysKonnect Unknown device 4340
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size: 32 bytes
	Interrupt: pin A routed to IRQ 5
	Region 0: Memory at dfbfc000 (64-bit, non-prefetchable) [size=16K]
	Region 2: I/O ports at be00 [size=256]
	[virtual] Expansion ROM at dfe00000 [disabled] [size=128K]
	Capabilities: [48] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=1 PME-
	Capabilities: [50] Vital Product Data
	Capabilities: [5c] Message Signalled Interrupts: Mask- 64bit+ Queue=0/1 Enable-
		Address: 00000000feeff000  Data: 4049
	Capabilities: [e0] Express Legacy Endpoint IRQ 0
		Device: Supported: MaxPayload 128 bytes, PhantFunc 0, ExtTag-
		Device: Latency L0s unlimited, L1 unlimited
		Device: AtnBtn- AtnInd- PwrInd-
		Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
		Device: RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
		Device: MaxPayload 128 bytes, MaxReadReq 512 bytes
		Link: Supported Speed 2.5Gb/s, Width x1, ASPM L0s, Port 0
		Link: Latency L0s <256ns, L1 unlimited
		Link: ASPM Disabled RCB 128 bytes CommClk- ExtSynch-
		Link: Speed 2.5Gb/s, Width x1
	Capabilities: [100] Advanced Error Reporting
00: ab 11 62 43 07 00 10 00 20 00 00 02 08 00 00 00
10: 04 c0 bf df 00 00 00 00 01 be 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 48 11 40 43
30: 00 00 00 00 48 00 00 00 00 00 00 00 0b 01 00 00
40: 00 00 f0 01 00 80 a0 01 01 50 02 fe 00 20 00 13
50: 03 5c 00 80 00 00 00 01 00 00 00 01 05 e0 82 00
60: 00 f0 ef fe 00 00 00 00 49 40 00 00 00 00 00 00
70: 00 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 10 00 11 00 c0 0f 00 00 00 20 1b 00 11 a4 03 00
f0: 08 00 11 10 00 00 00 00 00 00 00 00 00 00 00 00


--LQksG6bCIzRHxTLp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dmesg.txt"

Bootdata ok (command line is root=/dev/sda2 ro )
Linux version 2.6.18-1-amd64 (Debian 2.6.18-2) (waldi@debian.org) (gcc version 4.1.2 20060920 (prerelease) (Debian 4.1.1-14)) #1 SMP Fri Sep 29 17:39:19 CEST 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f000 (usable)
 BIOS-e820: 000000000009f000 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000007fef0000 (usable)
 BIOS-e820: 000000007fef0000 - 000000007fef3000 (ACPI NVS)
 BIOS-e820: 000000007fef3000 - 000000007ff00000 (ACPI data)
 BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
 BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
DMI 2.2 present.
ACPI: RSDP (v000 AWARD                                 ) @ 0x00000000000f7f10
ACPI: RSDT (v001 AWARD  AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x000000007fef3040
ACPI: FADT (v001 AWARD  AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x000000007fef30c0
ACPI: SSDT (v001 PTLTD  POWERNOW 0x00000001  LTP 0x00000001) @ 0x000000007fef6e80
ACPI: SRAT (v001 AMD    HAMMER   0x00000001 AMD  0x00000001) @ 0x000000007fef6fc0
ACPI: MCFG (v001 AWARD  AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x000000007fef70c0
ACPI: DSDT (v001 AWARD  AWRDACPI 0x00001000 MSFT 0x0100000e) @ 0x0000000000000000
SRAT: PXM 0 -> APIC 0 -> Node 0
SRAT: Node 0 PXM 0 0-a0000
SRAT: Node 0 PXM 0 0-80000000
NUMA: Using 63 for the hash shift.
Bootmem setup node 0 0000000000000000-000000007fef0000
No mptable found.
On node 0 totalpages: 515872
  DMA zone: 3060 pages, LIFO batch:0
  DMA32 zone: 512812 pages, LIFO batch:31
ACPI: PM-Timer IO Port: 0x1008
No local APIC present
Allocating PCI resources starting at 80000000 (gap: 7ff00000:60100000)
SMP: Allowing 0 CPUs, 0 hotplug CPUs
Built 1 zonelists.  Total pages: 515872
Kernel command line: root=/dev/sda2 ro 
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 32768 bytes)
time.c: Using 3.579545 MHz WALL PM GTOD PIT/TSC timer.
time.c: Detected 2199.416 MHz processor.
Console: colour VGA+ 80x25
Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes)
Checking aperture...
CPU 0: aperture @ b0000000 size 32 MB
Aperture too small (32 MB)
AGP bridge at 00:00:00
Aperture from AGP @ b0000000 size 256 MB (APSIZE f00)
Memory: 2055144k/2096064k available (1929k kernel code, 40532k reserved, 863k data, 176k init)
Calibrating delay using timer specific routine.. 4400.89 BogoMIPS (lpj=8801796)
Security Framework v1.0.0 initialized
SELinux:  Disabled at boot.
Capability LSM initialized
Mount-cache hash table entries: 256
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 0/0 -> Node 0
SMP alternatives: switching to UP code
Freeing SMP alternatives: 28k freed
ACPI: Core revision 20060707
ACPI: setting ELCR to 0200 (from 0e60)
weird, boot CPU (#0) not listed by the BIOS.
SMP motherboard not detected.
Apic disabled by BIOS
Local APIC not detected. Using dummy APIC emulation.
SMP disabled
Brought up 1 CPUs
testing NMI watchdog ... CPU#0: NMI appears to be stuck (0->0)!
migration_cost=0
checking if image is initramfs... it is
Freeing initrd memory: 5108k freed
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: Using MMCONFIG at e0000000
PCI: No mmconfig possible on device 0:18
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
ACPI: Assume root bridge [\_SB_.PCI0] bus is 0
PCI: Ignoring BAR0-3 of IDE controller 0000:00:02.5
Boot video device is 0000:01:00.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 *6 7 9 10 11 12 14 15)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: ACPI device : hid PNP0A08
pnp: ACPI device : hid PNP0C02
pnp: ACPI device : hid PNP0200
pnp: ACPI device : hid PNP0B00
pnp: ACPI device : hid PNP0800
pnp: ACPI device : hid PNP0C04
pnp: ACPI device : hid PNP0501
pnp: ACPI device : hid PNP0501
pnp: ACPI device : hid PNP0400
pnp: ACPI device : hid PNP0303
pnp: ACPI device : hid PNP0C02
pnp: ACPI device : hid PNP0C01
pnp: PnP ACPI: found 12 devices
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
PCI-DMA: Disabling IOMMU.
pnp: the driver 'system' has been registered
pnp: match found with the PnP device '00:01' and the driver 'system'
pnp: match found with the PnP device '00:0a' and the driver 'system'
pnp: match found with the PnP device '00:0b' and the driver 'system'
PCI: Bridge: 0000:00:01.0
  IO window: c000-cfff
  MEM window: d4000000-dbffffff
  PREFETCH window: c0000000-c7ffffff
PCI: Bridge: 0000:00:06.0
  IO window: b000-bfff
  MEM window: dfb00000-dfbfffff
  PREFETCH window: dfe00000-dfefffff
PCI: Bridge: 0000:00:07.0
  IO window: d000-dfff
  MEM window: dfd00000-dfdfffff
  PREFETCH window: dfc00000-dfcfffff
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 9
PCI: setting IRQ 9 as level-triggered
ACPI: PCI Interrupt 0000:00:01.0[A] -> Link [LNKA] -> GSI 9 (level, low) -> IRQ 9
PCI: Setting latency timer of device 0000:00:01.0 to 64
PCI: Setting latency timer of device 0000:00:06.0 to 64
PCI: Setting latency timer of device 0000:00:07.0 to 64
NET: Registered protocol family 2
IP route cache hash table entries: 65536 (order: 7, 524288 bytes)
TCP established hash table entries: 262144 (order: 10, 4194304 bytes)
TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
TCP: Hash tables configured (established 262144 bind 65536)
TCP reno registered
audit: initializing netlink socket (disabled)
audit(1160168547.588:1): initialized
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
0000:00:03.3 EHCI: BIOS handoff failed (BIOS bug ?) 01010001
PCI: Setting latency timer of device 0000:00:01.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:01.0:pcie00]
PCI: Setting latency timer of device 0000:00:06.0 to 64
pcie_portdrv_probe->Dev[000a:1039] has invalid IRQ. Check vendor BIOS
Allocate Port Service[0000:00:06.0:pcie00]
Allocate Port Service[0000:00:06.0:pcie01]
Allocate Port Service[0000:00:06.0:pcie03]
PCI: Setting latency timer of device 0000:00:07.0 to 64
pcie_portdrv_probe->Dev[000a:1039] has invalid IRQ. Check vendor BIOS
Allocate Port Service[0000:00:07.0:pcie00]
Allocate Port Service[0000:00:07.0:pcie01]
Allocate Port Service[0000:00:07.0:pcie03]
Real Time Clock Driver v1.12ac
Linux agpgart interface v0.101 (c) Dave Jones
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
pnp: the driver 'serial' has been registered
pnp: match found with the PnP device '00:06' and the driver 'serial'
00:06: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
pnp: match found with the PnP device '00:07' and the driver 'serial'
00:07: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 65536K size 1024 blocksize
usbmon: debugfs is not available
pnp: the driver 'i8042 kbd' has been registered
pnp: match found with the PnP device '00:09' and the driver 'i8042 kbd'
pnp: the driver 'i8042 aux' has been registered
PNP: PS/2 Controller [PNP0303:PS2K] at 0x60,0x64 irq 1
PNP: PS/2 controller doesn't have AUX irq; using default 12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
mice: PS/2 mouse device common for all mice
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
NET: Registered protocol family 8
NET: Registered protocol family 20
ACPI: (supports S0 S1 S3 S4 S5)
Freeing unused kernel memory: 176k freed
ACPI: Fan [FAN] (on)
ACPI Exception (acpi_processor-0681): AE_NOT_FOUND, Processor Device is not present [20060707]
ACPI: Getting cpuindex for acpiid 0x1
ACPI: Thermal Zone [THRM] (36 C)
input: AT Translated Set 2 keyboard as /class/input/input0
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
HPT302: IDE controller at PCI slot 0000:00:0b.0
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 10
PCI: setting IRQ 10 as level-triggered
ACPI: PCI Interrupt 0000:00:0b.0[A] -> Link [LNKC] -> GSI 10 (level, low) -> IRQ 10
HPT302: chipset revision 2
HPT302: 100% native mode on irq 10
HPT37X: using 33MHz PCI clock
    ide2: BM-DMA at 0xee00-0xee07, BIOS settings: hde:DMA, hdf:pio
HPT37X: using 33MHz PCI clock
    ide3: BM-DMA at 0xee08-0xee0f, BIOS settings: hdg:DMA, hdh:pio
Probing IDE interface ide2...
ohci_hcd: 2005 April 22 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
hde: ST3160022A, ATA DISK drive
ide2 at 0xf600-0xf607,0xf502 on irq 10
Probing IDE interface ide3...
hdg: SAMSUNG SP0802N, ATA DISK drive
ide3 at 0xf400-0xf407,0xf302 on irq 10
ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 6
PCI: setting IRQ 6 as level-triggered
ACPI: PCI Interrupt 0000:00:03.3[D] -> Link [LNKH] -> GSI 6 (level, low) -> IRQ 6
ehci_hcd 0000:00:03.3: EHCI Host Controller
ehci_hcd 0000:00:03.3: new USB bus registered, assigned bus number 1
PCI: cache line size of 64 is not supported by device 0000:00:03.3
ehci_hcd 0000:00:03.3: irq 6, io mem 0xdfffc000
ehci_hcd 0000:00:03.3: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 8 ports detected
SCSI subsystem initialized
libata version 2.00 loaded.
hde: max request size: 512KiB
hde: 312558593 sectors (160029 MB) w/1024KiB Cache, CHS=19455/255/63, UDMA(100)
hde: cache flushes supported
 hde: hde1 hde2 hde3
hdg: max request size: 512KiB
hdg: 156368016 sectors (80060 MB) w/2048KiB Cache, CHS=16383/255/63, UDMA(100)
hdg: cache flushes supported
 hdg: hdg1 hdg2
ACPI: PCI Interrupt Link [LNKE] enabled at IRQ 5
PCI: setting IRQ 5 as level-triggered
ACPI: PCI Interrupt 0000:00:03.0[A] -> Link [LNKE] -> GSI 5 (level, low) -> IRQ 5
ohci_hcd 0000:00:03.0: OHCI Host Controller
ohci_hcd 0000:00:03.0: new USB bus registered, assigned bus number 2
ohci_hcd 0000:00:03.0: irq 5, io mem 0xdffff000
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 3 ports detected
ACPI: PCI Interrupt Link [LNKF] enabled at IRQ 10
ACPI: PCI Interrupt 0000:00:03.1[B] -> Link [LNKF] -> GSI 10 (level, low) -> IRQ 10
ohci_hcd 0000:00:03.1: OHCI Host Controller
ohci_hcd 0000:00:03.1: new USB bus registered, assigned bus number 3
ohci_hcd 0000:00:03.1: irq 10, io mem 0xdfffe000
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 3 ports detected
ACPI: PCI Interrupt Link [LNKG] enabled at IRQ 11
PCI: setting IRQ 11 as level-triggered
ACPI: PCI Interrupt 0000:00:03.2[C] -> Link [LNKG] -> GSI 11 (level, low) -> IRQ 11
ohci_hcd 0000:00:03.2: OHCI Host Controller
ohci_hcd 0000:00:03.2: new USB bus registered, assigned bus number 4
ohci_hcd 0000:00:03.2: irq 11, io mem 0xdfffd000
usb usb4: configuration #1 chosen from 1 choice
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
SIS5513: IDE controller at PCI slot 0000:00:02.5
ACPI: PCI Interrupt 0000:00:02.5[A] -> Link [LNKA] -> GSI 9 (level, low) -> IRQ 9
SIS5513: chipset revision 1
SIS5513: not 100% native mode: will probe irqs later
SIS5513: SiS965 ATA 133 (2nd gen) controller
    ide0: BM-DMA at 0x4000-0x4007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x4008-0x400f, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide0...
usb 3-1: new low speed USB device using ohci_hcd and address 2
usb 3-1: configuration #1 chosen from 1 choice
usbcore: registered new driver hiddev
input: Hewlett-Packard  HP f2100a Optical USB Travel Mouse as /class/input/input1
input: USB HID v1.00 Mouse [Hewlett-Packard  HP f2100a Optical USB Travel Mouse] on usb-0000:00:03.1-1
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
hda: DVD DC DQ60, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: SAMSUNG SP0822N, ATA DISK drive
ide1 at 0x170-0x177,0x376 on irq 15
hdc: max request size: 512KiB
hdc: 156368016 sectors (80060 MB) w/2048KiB Cache, CHS=16383/255/63, UDMA(33)
hdc: cache flushes supported
 hdc: hdc1 hdc2
sata_sis 0000:00:05.0: version 0.6
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 11
ACPI: PCI Interrupt 0000:00:05.0[A] -> Link [LNKB] -> GSI 11 (level, low) -> IRQ 11
sata_sis 0000:00:05.0: Detected SiS 182 chipset
ata1: SATA max UDMA/133 cmd 0xFC00 ctl 0xFB02 bmdma 0xF800 irq 11
ata2: SATA max UDMA/133 cmd 0xFA00 ctl 0xF902 bmdma 0xF808 irq 11
scsi0 : sata_sis
hda: ATAPI 40X DVD-ROM DVD-R-RAM CD-R/RW drive, 1419kB Cache, UDMA(66)
Uniform CD-ROM driver Revision: 3.20
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.00: ATA-7, max UDMA/133, 625142448 sectors: LBA48 NCQ (depth 0/32)
ata1.00: ata1: dev 0 multi count 1
ata1.01: ATA-7, max UDMA/133, 625142448 sectors: LBA48 NCQ (depth 0/32)
ata1.01: ata1: dev 1 multi count 1
ata1.00: configured for UDMA/133
ata1.01: configured for UDMA/133
scsi1 : sata_sis
ata2: SATA link down (SStatus 0 SControl 300)
ATA: abnormal status 0x7F on port 0xFA07
  Vendor: ATA       Model: ST3320620AS       Rev: 3.AA
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: ATA       Model: ST3320620AS       Rev: 3.AA
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 625142448 512-byte hdwr sectors (320073 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sda: 625142448 512-byte hdwr sectors (320073 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
 sda: sda1 sda2
sd 0:0:0:0: Attached scsi disk sda
SCSI device sdb: 625142448 512-byte hdwr sectors (320073 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
SCSI device sdb: 625142448 512-byte hdwr sectors (320073 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
 sdb:
sd 0:0:1:0: Attached scsi disk sdb
md: md driver 0.90.3 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: bitmap version 4.39
md: raid1 personality registered for level 1
raid5: automatically using best checksumming function: generic_sse
   generic_sse:  6730.000 MB/sec
raid5: using function: generic_sse (6730.000 MB/sec)
raid6: int64x1   2004 MB/s
raid6: int64x2   2651 MB/s
raid6: int64x4   2512 MB/s
raid6: int64x8   1756 MB/s
raid6: sse2x1    2739 MB/s
raid6: sse2x2    3692 MB/s
raid6: sse2x4    3989 MB/s
raid6: using algorithm sse2x4 (3989 MB/s)
md: raid6 personality registered for level 6
md: raid5 personality registered for level 5
md: raid4 personality registered for level 4
md: md0 stopped.
md: bind<hdc1>
md: bind<hdg1>
md: bind<hde1>
md: kicking non-fresh hdc1 from array!
md: unbind<hdc1>
md: export_rdev(hdc1)
raid5: device hde1 operational as raid disk 1
raid5: device hdg1 operational as raid disk 2
raid5: allocated 3212kB for md0
raid5: raid level 5 set md0 active with 2 out of 3 devices, algorithm 2
RAID5 conf printout:
 --- rd:3 wd:2 fd:1
 disk 1, o:1, dev:hde1
 disk 2, o:1, dev:hdg1
md: md1 stopped.
md: bind<hdc2>
md: bind<hdg2>
md: bind<hde2>
md: kicking non-fresh hdc2 from array!
md: unbind<hdc2>
md: export_rdev(hdc2)
raid1: raid set md1 active with 2 out of 3 mirrors
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
input: PC Speaker as /class/input/input2
pnp: the driver 'parport_pc' has been registered
pnp: match found with the PnP device '00:08' and the driver 'parport_pc'
parport: PnPBIOS parport detected.
parport0: PC-style at 0x378, irq 7 [PCSPP,TRISTATE]
agpgart: Unsupported SiS chipset (device id: 0761)
ts: Compaq touchscreen protocol output
sis190 Gigabit Ethernet driver 1.2 loaded.
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 5
ACPI: PCI Interrupt 0000:00:04.0[A] -> Link [LNKD] -> GSI 5 (level, low) -> IRQ 5
PCI: Setting latency timer of device 0000:00:04.0 to 64
0000:00:04.0: Read MAC address from EEPROM
Intel 810 + AC97 Audio, version 1.01, 17:40:31 Sep 29 2006
0000:00:04.0: Broadcom PHY BCM5461 transceiver at address 1.
0000:00:04.0: Using transceiver at address 1 as default.
0000:00:04.0: SiS 191 PCI Gigabit Ethernet adapter at ffffc2000001e000 (IRQ: 5), 71:d9:00:00:00:00
eth0: RGMII mode.
eth0: Enabling Auto-negotiation.
ACPI: PCI Interrupt 0000:00:02.7[C] -> Link [LNKC] -> GSI 10 (level, low) -> IRQ 10
i810: SiS 7012 found at IO 0xfe00 and 0xf000, MEM 0x0000 and 0x0000, IRQ 10
i810_audio: Audio Controller supports 6 channels.
i810_audio: Defaulting to base 2 channel mode.
i810_audio: Resetting connection 0
ac97_codec: AC97  codec, id: ALG97 (Unknown)
i810_audio: only 48Khz playback available.
i810_audio: AC'97 codec 0 Unable to map surround DAC's (or DAC's not present), total channels = 2
ACPI: PCI Interrupt 0000:02:00.0[A] -> Link [LNKE] -> GSI 5 (level, low) -> IRQ 5
PCI: Setting latency timer of device 0000:02:00.0 to 64
sky2 v1.5 addr 0xdfbfc000 irq 5 Yukon-EC (0xb6) rev 2
sky2 eth0: addr 00:00:5a:00:01:98
sky2 0000:02:00.0: No interrupt was generated using MSI, switching to INTx mode. Please report this failure to the PCI maintainer and include system chipset information.
EXT3 FS on sda2, internal journal
loop: loaded (max 8 devices)
device-mapper: ioctl: 4.7.0-ioctl (2006-06-24) initialised: dm-devel@redhat.com
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
sky2 eth0: enabling interface
ACPI: Power Button (FF) [PWRF]
ACPI: Power Button (CM) [PWRB]
NET: Registered protocol family 10
lo: Disabled Privacy Extensions
ADDRCONF(NETDEV_UP): eth0: link is not ready
IPv6 over IPv4 tunneling driver
sky2 eth0: Link is up at 100 Mbps, full duplex, flow control both
ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
eth0: no IPv6 routers present

--LQksG6bCIzRHxTLp--
