From: mtths@nurfuerspam.de
Subject: PROBLEM: sil24: transfer errors causing data corruption or very low performance
Date: Sat, 22 Apr 2017 17:33:56 +0200
Message-ID: <1605874.IPVSbxyx3P@c21>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="nextPart1825563.CaAURjkrJz"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.18]:54731 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1424956AbdDVPeC (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Sat, 22 Apr 2017 11:34:02 -0400
Received: from c21.localnet ([83.135.166.99]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lmr1w-1cNNVJ13ls-00h5uj for
 <linux-ide@vger.kernel.org>; Sat, 22 Apr 2017 17:33:59 +0200
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

This is a multi-part message in MIME format.

--nextPart1825563.CaAURjkrJz
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

A SATA PCI-controller card using the kernel module sata_sil24 has problems 
transferring big files.


First of all a description of the situation:

-- Hardware:
- mainboard Gigabyte GA-MA69GM-S2H; chipset AMD 690G / SB600; 2 PCI slots
  (32 bit); 1 PCIe 4x slot; 1 PCIe 16 x slot; 8 GiB RAM; AMD Phenom(tm) II X4
  955 Processor
- SATA controller card Dawicontrol DC-3410 RAID, 32 bit PCI; chipset
  SiI3124ACBHU; BIOS message: running at 32 bit / 33 MHz
- with hard disks: HDS721616PLA380 (twice), ST3000DM001-9YN166 (temporary)
- q.v. attachment lspci; (dmidecode (v 3.0) finds no SMBIOS nor DMI entry
  point)

-- [Debian] System Information:
Debian Release: stretch/sid
  APT prefers unstable
  APT policy: (998, 'unstable')
Architecture: amd64 (x86_64)

Kernel: Linux 4.9.2 (SMP w/4 CPU cores)
Locale: LANG=de_DE.UTF-8, LC_CTYPE=de_DE.UTF-8 (charmap=UTF-8)
Shell: /bin/sh linked to /bin/dash
Init: systemd (via /run/systemd/system)

Versions of packages linux-source-4.9 depends on:
ii  binutils  2.27.90.20170113-1
ii  xz-utils  5.2.2-1.2

Versions of packages linux-source-4.9 recommends:
ii  bc                    1.06.95-9+b2
ii  gcc                   4:6.2.1-1
ii  libc6-dev [libc-dev]  2.24-8
ii  make                  4.1-9

Versions of packages linux-source-4.9 suggests:
ii  libncurses5-dev [ncurses-dev]  6.0+20161126-1
pn  libqt4-dev                     <none>
pn  pkg-config                     <none>


1st test setting:
Reading from the disks to /dev/null with
		dd if=/dev/sde of=/dev/null bs=4k count=2304k
one after the other. (Disk ST3000DM001 was temporarily directly connected to 
the card's external SATA port.)
Result: After some MB, but before 470 MiB errors occurred:
	failed command: READ FPDMA QUEUED
		[cf. attachment dmesg]
	failed command: READ DMA
		[cf. attachment dmesg_tmpHD]
The errors were reproducible - however, they started after different amounts 
of data.

2nd test setting:
Using Debian's kernel and patching the driver to not use 64 bit DMA [cf. 
attachment sata_sil24.c.diff].
Doing the same tests as above.
Result: Repeatedly no errors occurred.


N.B.: 1) There is a Windows Vista (32 bit) installation that uses two of the 
ports of the controller card as a fake RAID 1: There are no problems with the 
internal directly connected drives nor with an external drive.
2) Prior to this controller card there was a PCI Express card using SiI 3132, 
that - if I remember rightly - also had such problems, but they started after 
a greater amount of data. (At that time a Windows XP x64 installation had no 
problems, too.)


If you need or want additional information or tests, let me know.

Matthias
--nextPart1825563.CaAURjkrJz
Content-Disposition: attachment; filename="lspci"
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"; name="lspci"

00:00.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD/ATI] RS690 Host Bridge [1002:7910]
	Subsystem: Gigabyte Technology Co., Ltd RS690 Host Bridge [1458:5000]
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR- INTx-
	Latency: 32
	NUMA node: 0

00:02.0 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD/ATI] RS690 PCI to PCI Bridge (PCI Express Graphics Port 0) [1002:7913] (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 4 bytes
	Interrupt: pin ? routed to IRQ 24
	NUMA node: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 0000c000-0000cfff
	Memory behind bridge: fdd00000-fddfffff
	Prefetchable memory behind bridge: 00000000d0000000-00000000dfffffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [50] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [58] Express (v1) Root Port (Slot+), MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0
			ExtTag+ RBE+
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #0, Speed 2.5GT/s, Width x16, ASPM L0s L1, Exit Latency L0s <64ns, L1 <1us
			ClockPM- Surprise- LLActRep+ BwNot- ASPMOptComp-
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x16, TrErr- Train- SlotClk+ DLActive+ BWMgmt- ABWMgmt-
		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
			Slot #2, PowerLimit 75.000W; Interlock- NoCompl-
		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
			Control: AttnInd Off, PwrInd Off, Power- Interlock-
		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
			Changed: MRL- PresDet+ LinkState-
		RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible+
		RootCap: CRSVisible+
		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
	Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
		Address: fee0f00c  Data: 41b1
	Capabilities: [b0] Subsystem: Gigabyte Technology Co., Ltd RS690 PCI to PCI Bridge (PCI Express Graphics Port 0) [1458:5000]
	Capabilities: [b8] HyperTransport: MSI Mapping Enable+ Fixed+
	Capabilities: [100 v1] Virtual Channel
		Caps:	LPEVC=0 RefClk=100ns PATEntryBits=1
		Arb:	Fixed- WRR32- WRR64- WRR128-
		Ctrl:	ArbSelect=Fixed
		Status:	InProgress-
		VC0:	Caps:	PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
			Arb:	Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
			Status:	NegoPending- InProgress-
	Kernel driver in use: pcieport
	Kernel modules: shpchp

00:04.0 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD/ATI] Device [1002:7914] (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 4 bytes
	Interrupt: pin ? routed to IRQ 25
	NUMA node: 0
	Bus: primary=00, secondary=02, subordinate=05, sec-latency=0
	I/O behind bridge: 0000d000-0000efff
	Memory behind bridge: fdb00000-fdcfffff
	Prefetchable memory behind bridge: 00000000fde00000-00000000fdffffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [50] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [58] Express (v1) Root Port (Slot+), MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0
			ExtTag+ RBE+
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #1, Speed 2.5GT/s, Width x4, ASPM L0s L1, Exit Latency L0s <64ns, L1 <1us
			ClockPM- Surprise- LLActRep+ BwNot- ASPMOptComp-
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive+ BWMgmt- ABWMgmt-
		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
			Slot #4, PowerLimit 25.000W; Interlock- NoCompl-
		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
			Control: AttnInd Off, PwrInd Off, Power- Interlock-
		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
			Changed: MRL- PresDet+ LinkState-
		RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible+
		RootCap: CRSVisible+
		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
	Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
		Address: fee0f00c  Data: 41c1
	Capabilities: [b0] Subsystem: Gigabyte Technology Co., Ltd Device [1458:5000]
	Capabilities: [b8] HyperTransport: MSI Mapping Enable+ Fixed+
	Capabilities: [100 v1] Virtual Channel
		Caps:	LPEVC=0 RefClk=100ns PATEntryBits=1
		Arb:	Fixed- WRR32- WRR64- WRR128-
		Ctrl:	ArbSelect=Fixed
		Status:	InProgress-
		VC0:	Caps:	PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
			Arb:	Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
			Status:	NegoPending- InProgress-
	Kernel driver in use: pcieport
	Kernel modules: shpchp

00:12.0 SATA controller [0106]: Advanced Micro Devices, Inc. [AMD/ATI] SB600 Non-Raid-5 SATA [1002:4380] (prog-if 01 [AHCI 1.0])
	Subsystem: Gigabyte Technology Co., Ltd Gigabyte GA-MA69G-S3H Motherboard [1458:b005]
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 32
	Interrupt: pin A routed to IRQ 22
	NUMA node: 0
	Region 0: I/O ports at ff00 [size=8]
	Region 1: I/O ports at fe00 [size=4]
	Region 2: I/O ports at fd00 [size=8]
	Region 3: I/O ports at fc00 [size=4]
	Region 4: I/O ports at fb00 [size=16]
	Region 5: Memory at fe02f000 (32-bit, non-prefetchable) [size=1K]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Kernel driver in use: ahci
	Kernel modules: ahci

00:13.0 USB controller [0c03]: Advanced Micro Devices, Inc. [AMD/ATI] SB600 USB (OHCI0) [1002:4387] (prog-if 10 [OHCI])
	Subsystem: Gigabyte Technology Co., Ltd SB600 USB (OHCI0) [1458:5004]
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 32, Cache Line Size: 4 bytes
	Interrupt: pin A routed to IRQ 16
	NUMA node: 0
	Region 0: Memory at fe02e000 (32-bit, non-prefetchable) [size=4K]
	Kernel driver in use: ohci-pci
	Kernel modules: ohci_pci

00:13.1 USB controller [0c03]: Advanced Micro Devices, Inc. [AMD/ATI] SB600 USB (OHCI1) [1002:4388] (prog-if 10 [OHCI])
	Subsystem: Gigabyte Technology Co., Ltd SB600 USB (OHCI1) [1458:5004]
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 32, Cache Line Size: 4 bytes
	Interrupt: pin B routed to IRQ 17
	NUMA node: 0
	Region 0: Memory at fe02d000 (32-bit, non-prefetchable) [size=4K]
	Kernel driver in use: ohci-pci
	Kernel modules: ohci_pci

00:13.2 USB controller [0c03]: Advanced Micro Devices, Inc. [AMD/ATI] SB600 USB (OHCI2) [1002:4389] (prog-if 10 [OHCI])
	Subsystem: Gigabyte Technology Co., Ltd SB600 USB (OHCI2) [1458:5004]
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 32, Cache Line Size: 4 bytes
	Interrupt: pin C routed to IRQ 18
	NUMA node: 0
	Region 0: Memory at fe02c000 (32-bit, non-prefetchable) [size=4K]
	Kernel driver in use: ohci-pci
	Kernel modules: ohci_pci

00:13.3 USB controller [0c03]: Advanced Micro Devices, Inc. [AMD/ATI] SB600 USB (OHCI3) [1002:438a] (prog-if 10 [OHCI])
	Subsystem: Gigabyte Technology Co., Ltd SB600 USB (OHCI3) [1458:5004]
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 32, Cache Line Size: 4 bytes
	Interrupt: pin B routed to IRQ 17
	NUMA node: 0
	Region 0: Memory at fe02b000 (32-bit, non-prefetchable) [size=4K]
	Kernel driver in use: ohci-pci
	Kernel modules: ohci_pci

00:13.4 USB controller [0c03]: Advanced Micro Devices, Inc. [AMD/ATI] SB600 USB (OHCI4) [1002:438b] (prog-if 10 [OHCI])
	Subsystem: Gigabyte Technology Co., Ltd SB600 USB (OHCI4) [1458:5004]
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 32, Cache Line Size: 4 bytes
	Interrupt: pin C routed to IRQ 18
	NUMA node: 0
	Region 0: Memory at fe02a000 (32-bit, non-prefetchable) [size=4K]
	Kernel driver in use: ohci-pci
	Kernel modules: ohci_pci

00:13.5 USB controller [0c03]: Advanced Micro Devices, Inc. [AMD/ATI] SB600 USB Controller (EHCI) [1002:4386] (prog-if 20 [EHCI])
	Subsystem: Gigabyte Technology Co., Ltd SB600 USB Controller (EHCI) [1458:5004]
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 32, Cache Line Size: 4 bytes
	Interrupt: pin D routed to IRQ 19
	NUMA node: 0
	Region 0: Memory at fe029000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
		Bridge: PM- B3+
	Capabilities: [e4] Debug port: BAR=1 offset=00e0
	Kernel driver in use: ehci-pci
	Kernel modules: ehci_pci

00:14.0 SMBus [0c05]: Advanced Micro Devices, Inc. [AMD/ATI] SBx00 SMBus Controller [1002:4385] (rev 14)
	Subsystem: Gigabyte Technology Co., Ltd GA-MA770-DS3rev2.0 Motherboard [1458:4385]
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	NUMA node: 0
	Region 0: I/O ports at 0b00 [size=16]
	Capabilities: [b0] HyperTransport: MSI Mapping Enable- Fixed+
	Kernel driver in use: piix4_smbus
	Kernel modules: i2c_piix4, sp5100_tco

00:14.1 IDE interface [0101]: Advanced Micro Devices, Inc. [AMD/ATI] SB600 IDE [1002:438c] (prog-if 8a [Master SecP PriP])
	Subsystem: Gigabyte Technology Co., Ltd Gigabyte GA-MA69G-S3H Motherboard [1458:5002]
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 32
	Interrupt: pin A routed to IRQ 16
	NUMA node: 0
	Region 0: I/O ports at 01f0 [size=8]
	Region 1: I/O ports at 03f4
	Region 2: I/O ports at 0170 [size=8]
	Region 3: I/O ports at 0374
	Region 4: I/O ports at f900 [size=16]
	Kernel driver in use: pata_atiixp
	Kernel modules: pata_atiixp, ata_generic

00:14.2 Audio device [0403]: Advanced Micro Devices, Inc. [AMD/ATI] SBx00 Azalia (Intel HDA) [1002:4383]
	Subsystem: Gigabyte Technology Co., Ltd GA-MA770-DS3rev2.0 Motherboard [1458:a022]
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 32, Cache Line Size: 4 bytes
	Interrupt: pin A routed to IRQ 16
	NUMA node: 0
	Region 0: Memory at fe024000 (64-bit, non-prefetchable) [size=16K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Kernel driver in use: snd_hda_intel
	Kernel modules: snd_hda_intel

00:14.3 ISA bridge [0601]: Advanced Micro Devices, Inc. [AMD/ATI] SB600 PCI to LPC Bridge [1002:438d]
	Subsystem: Gigabyte Technology Co., Ltd SB600 PCI to LPC Bridge [1458:5001]
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	NUMA node: 0

00:14.4 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD/ATI] SBx00 PCI to PCI Bridge [1002:4384] (prog-if 01 [Subtractive decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop+ ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 64
	NUMA node: 0
	Bus: primary=00, secondary=06, subordinate=06, sec-latency=64
	I/O behind bridge: 0000b000-0000bfff
	Memory behind bridge: fda00000-fdafffff
	Prefetchable memory behind bridge: fd900000-fd9fffff
	Secondary status: 66MHz- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-

00:18.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Family 10h Processor HyperTransport Configuration [1022:1200]
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	NUMA node: 0
	Capabilities: [80] HyperTransport: Host or Secondary Interface
		Command: WarmRst+ DblEnd- DevNum=0 ChainSide- HostHide+ Slave- <EOCErr- DUL-
		Link Control: CFlE- CST- CFE- <LkFail- Init+ EOC- TXO- <CRCErr=0 IsocEn- LSEn+ ExtCTL- 64b-
		Link Config: MLWI=16bit DwFcIn- MLWO=16bit DwFcOut- LWI=16bit DwFcInEn- LWO=16bit DwFcOutEn-
		Revision ID: 3.00
		Link Frequency: 1.0GHz
		Link Error: <Prot- <Ovfl- <EOC- CTLTm-
		Link Frequency Capability: 200MHz+ 300MHz- 400MHz+ 500MHz- 600MHz+ 800MHz+ 1.0GHz+ 1.2GHz+ 1.4GHz- 1.6GHz- Vend-
		Feature Capability: IsocFC+ LDTSTOP+ CRCTM- ECTLT- 64bA+ UIDRD- ExtRS- UCnfE-

00:18.1 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Family 10h Processor Address Map [1022:1201]
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	NUMA node: 0

00:18.2 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Family 10h Processor DRAM Controller [1022:1202]
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	NUMA node: 0

00:18.3 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Family 10h Processor Miscellaneous Control [1022:1203]
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	NUMA node: 0
	Capabilities: [f0] Secure device <?>
	Kernel driver in use: k10temp
	Kernel modules: k10temp

00:18.4 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Family 10h Processor Link Control [1022:1204]
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	NUMA node: 0

01:00.0 VGA compatible controller [0300]: Advanced Micro Devices, Inc. [AMD/ATI] Cape Verde LE [Radeon HD 7730/8730] [1002:6837] (prog-if 00 [VGA controller])
	Subsystem: Hightech Information System Ltd. Cape Verde LE [Radeon HD 7730/8730] [1787:2330]
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 4 bytes
	Interrupt: pin A routed to IRQ 34
	NUMA node: 0
	Region 0: Memory at d0000000 (64-bit, prefetchable) [size=256M]
	Region 2: Memory at fdd80000 (64-bit, non-prefetchable) [size=256K]
	Region 4: I/O ports at ce00 [size=256]
	[virtual] Expansion ROM at 000c0000 [disabled] [size=128K]
	Capabilities: [48] Vendor Specific Information: Len=08 <?>
	Capabilities: [50] Power Management version 3
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1+,D2+,D3hot+,D3cold-)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [58] Express (v2) Legacy Endpoint, MSI 00
		DevCap:	MaxPayload 256 bytes, PhantFunc 0, Latency L0s <4us, L1 unlimited
			ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 128 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr- TransPend-
		LnkCap:	Port #0, Speed 8GT/s, Width x16, ASPM L0s L1, Exit Latency L0s <64ns, L1 <1us
			ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp+
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x16, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Not Supported, TimeoutDis-, LTR-, OBFF Not Supported
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled
		LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-, EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [a0] MSI: Enable+ Count=1/1 Maskable- 64bit+
		Address: 00000000fee0f00c  Data: 4143
	Capabilities: [100 v1] Vendor Specific Information: ID=0001 Rev=1 Len=010 <?>
	Capabilities: [150 v2] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		AERCap:	First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
	Capabilities: [270 v1] #19
	Kernel driver in use: radeon
	Kernel modules: radeon

01:00.1 Audio device [0403]: Advanced Micro Devices, Inc. [AMD/ATI] Cape Verde/Pitcairn HDMI Audio [Radeon HD 7700/7800 Series] [1002:aab0]
	Subsystem: Hightech Information System Ltd. Cape Verde/Pitcairn HDMI Audio [Radeon HD 7700/7800 Series] [1787:aab0]
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 4 bytes
	Interrupt: pin B routed to IRQ 4
	NUMA node: 0
	Region 0: Memory at fddfc000 (64-bit, non-prefetchable) [size=16K]
	Capabilities: [48] Vendor Specific Information: Len=08 <?>
	Capabilities: [50] Power Management version 3
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [58] Express (v2) Legacy Endpoint, MSI 00
		DevCap:	MaxPayload 256 bytes, PhantFunc 0, Latency L0s <4us, L1 unlimited
			ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 128 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr- TransPend-
		LnkCap:	Port #0, Speed 8GT/s, Width x16, ASPM L0s L1, Exit Latency L0s <64ns, L1 <1us
			ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp+
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x16, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Not Supported, TimeoutDis-, LTR-, OBFF Not Supported
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled
		LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-, EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [a0] MSI: Enable- Count=1/1 Maskable- 64bit+
		Address: 0000000000000000  Data: 0000
	Capabilities: [100 v1] Vendor Specific Information: ID=0001 Rev=1 Len=010 <?>
	Capabilities: [150 v2] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		AERCap:	First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
	Kernel modules: snd_hda_intel

02:00.0 PCI bridge [0604]: Pericom Semiconductor Device [12d8:2304] (rev 05) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 4 bytes
	NUMA node: 0
	Bus: primary=02, secondary=03, subordinate=05, sec-latency=0
	I/O behind bridge: 0000d000-0000efff
	Memory behind bridge: fdb00000-fdcfffff
	Prefetchable memory behind bridge: 00000000fde00000-00000000fdffffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Power Management version 3
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [5c] Vital Product Data
		Not readable
	Capabilities: [64] Vendor Specific Information: Len=34 <?>
	Capabilities: [b0] Subsystem: Device [0000:0000]
	Capabilities: [c0] Express (v2) Upstream Port, MSI 00
		DevCap:	MaxPayload 256 bytes, PhantFunc 0
			ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ SlotPowerLimit 0.000W
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr+ TransPend-
		LnkCap:	Port #0, Speed 5GT/s, Width x2, ASPM not supported, Exit Latency L0s <512ns, L1 <1us
			ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp-
		LnkCtl:	ASPM Disabled; Disabled- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Not Supported, TimeoutDis-, LTR+, OBFF Via message
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled
		LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [100 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		AERCap:	First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
	Capabilities: [140 v1] Virtual Channel
		Caps:	LPEVC=0 RefClk=100ns PATEntryBits=4
		Arb:	Fixed- WRR32- WRR64- WRR128-
		Ctrl:	ArbSelect=Fixed
		Status:	InProgress-
		VC0:	Caps:	PATOffset=04 MaxTimeSlots=64 RejSnoopTrans-
			Arb:	Fixed+ WRR32- WRR64- WRR128+ TWRR128- WRR256-
			Ctrl:	Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
			Status:	NegoPending- InProgress-
			Port Arbitration Table <?>
	Capabilities: [20c v1] Power Budgeting <?>
	Capabilities: [230 v1] Latency Tolerance Reporting
		Max snoop latency: 0ns
		Max no snoop latency: 0ns
	Kernel driver in use: pcieport
	Kernel modules: shpchp

03:01.0 PCI bridge [0604]: Pericom Semiconductor Device [12d8:2304] (rev 05) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 4 bytes
	Interrupt: pin ? routed to IRQ 26
	NUMA node: 0
	Bus: primary=03, secondary=04, subordinate=04, sec-latency=0
	I/O behind bridge: 0000e000-0000efff
	Memory behind bridge: fdc00000-fdcfffff
	Prefetchable memory behind bridge: 00000000fdf00000-00000000fdffffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Power Management version 3
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [4c] MSI: Enable+ Count=1/1 Maskable- 64bit+
		Address: 00000000fee0f00c  Data: 41d1
	Capabilities: [64] Vendor Specific Information: Len=34 <?>
	Capabilities: [b0] Subsystem: Device [0000:0000]
	Capabilities: [c0] Express (v2) Downstream Port (Slot+), MSI 00
		DevCap:	MaxPayload 256 bytes, PhantFunc 0
			ExtTag- RBE+
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
		LnkCap:	Port #1, Speed 5GT/s, Width x1, ASPM not supported, Exit Latency L0s <512ns, L1 <1us
			ClockPM- Surprise- LLActRep- BwNot+ ASPMOptComp-
		LnkCtl:	ASPM Disabled; Disabled- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
			Slot #0, PowerLimit 0.000W; Interlock- NoCompl-
		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
			Control: AttnInd Off, PwrInd Off, Power- Interlock-
		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
			Changed: MRL- PresDet- LinkState+
		DevCap2: Completion Timeout: Not Supported, TimeoutDis-, LTR+, OBFF Via message ARIFwd-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled ARIFwd-
		LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-, Selectable De-emphasis: -3.5dB
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-, EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [100 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		AERCap:	First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
	Capabilities: [140 v1] Virtual Channel
		Caps:	LPEVC=0 RefClk=100ns PATEntryBits=4
		Arb:	Fixed- WRR32- WRR64- WRR128-
		Ctrl:	ArbSelect=Fixed
		Status:	InProgress-
		VC0:	Caps:	PATOffset=04 MaxTimeSlots=64 RejSnoopTrans-
			Arb:	Fixed+ WRR32- WRR64- WRR128+ TWRR128- WRR256-
			Ctrl:	Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
			Status:	NegoPending- InProgress-
			Port Arbitration Table <?>
	Capabilities: [20c v1] Power Budgeting <?>
	Capabilities: [220 v1] Access Control Services
		ACSCap:	SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ UpstreamFwd+ EgressCtrl+ DirectTrans+
		ACSCtl:	SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd- EgressCtrl- DirectTrans-
	Kernel driver in use: pcieport
	Kernel modules: shpchp

03:02.0 PCI bridge [0604]: Pericom Semiconductor Device [12d8:2304] (rev 05) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 4 bytes
	Interrupt: pin ? routed to IRQ 27
	NUMA node: 0
	Bus: primary=03, secondary=05, subordinate=05, sec-latency=0
	I/O behind bridge: 0000d000-0000dfff
	Memory behind bridge: fdb00000-fdbfffff
	Prefetchable memory behind bridge: 00000000fde00000-00000000fdefffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Power Management version 3
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [4c] MSI: Enable+ Count=1/1 Maskable- 64bit+
		Address: 00000000fee0f00c  Data: 41e1
	Capabilities: [64] Vendor Specific Information: Len=34 <?>
	Capabilities: [b0] Subsystem: Device [0000:0000]
	Capabilities: [c0] Express (v2) Downstream Port (Slot+), MSI 00
		DevCap:	MaxPayload 256 bytes, PhantFunc 0
			ExtTag- RBE+
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
		LnkCap:	Port #2, Speed 2.5GT/s, Width x1, ASPM not supported, Exit Latency L0s <512ns, L1 <1us
			ClockPM- Surprise- LLActRep- BwNot+ ASPMOptComp-
		LnkCtl:	ASPM Disabled; Disabled- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
			Slot #0, PowerLimit 0.000W; Interlock- NoCompl-
		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
			Control: AttnInd Off, PwrInd Off, Power- Interlock-
		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
			Changed: MRL- PresDet- LinkState+
		DevCap2: Completion Timeout: Not Supported, TimeoutDis-, LTR+, OBFF Via message ARIFwd-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled ARIFwd-
		LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-, Selectable De-emphasis: -3.5dB
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-, EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [100 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		AERCap:	First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
	Capabilities: [140 v1] Virtual Channel
		Caps:	LPEVC=0 RefClk=100ns PATEntryBits=4
		Arb:	Fixed- WRR32- WRR64- WRR128-
		Ctrl:	ArbSelect=Fixed
		Status:	InProgress-
		VC0:	Caps:	PATOffset=04 MaxTimeSlots=64 RejSnoopTrans-
			Arb:	Fixed+ WRR32- WRR64- WRR128+ TWRR128- WRR256-
			Ctrl:	Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
			Status:	NegoPending- InProgress-
			Port Arbitration Table <?>
	Capabilities: [20c v1] Power Budgeting <?>
	Capabilities: [220 v1] Access Control Services
		ACSCap:	SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ UpstreamFwd+ EgressCtrl+ DirectTrans+
		ACSCtl:	SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd- EgressCtrl- DirectTrans-
	Kernel driver in use: pcieport
	Kernel modules: shpchp

04:00.0 USB controller [0c03]: Fresco Logic FL1100 USB 3.0 Host Controller [1b73:1100] (rev 10) (prog-if 30 [XHCI])
	Subsystem: Sonnet Technologies, Inc. FL1100 USB 3.0 Host Controller [16b8:6e02]
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 4 bytes
	Interrupt: pin A routed to IRQ 17
	NUMA node: 0
	Region 0: Memory at fdce0000 (64-bit, non-prefetchable) [size=64K]
	Region 2: Memory at fdcff000 (64-bit, non-prefetchable) [size=4K]
	Region 4: Memory at fdcfe000 (64-bit, non-prefetchable) [size=4K]
	Capabilities: [40] Power Management version 3
		Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA PME(D0+,D1+,D2-,D3hot+,D3cold-)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [50] MSI: Enable- Count=1/8 Maskable- 64bit+
		Address: 0000000000000000  Data: 0000
	Capabilities: [70] Express (v2) Endpoint, MSI 00
		DevCap:	MaxPayload 512 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset- SlotPowerLimit 0.000W
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 128 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #0, Speed 5GT/s, Width x1, ASPM L0s L1, Exit Latency L0s unlimited, L1 unlimited
			ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp-
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Not Supported, TimeoutDis+, LTR-, OBFF Not Supported
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled
		LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [b0] MSI-X: Enable+ Count=8 Masked-
		Vector table: BAR=2 offset=00000000
		PBA: BAR=4 offset=00000000
	Capabilities: [100 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		AERCap:	First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
	Kernel driver in use: xhci_hcd
	Kernel modules: xhci_pci

05:00.0 FireWire (IEEE 1394) [0c00]: LSI Corporation FW643 [TrueFire] PCIe 1394b Controller [11c1:5901] (rev 08) (prog-if 10 [OHCI])
	Subsystem: Sonnet Technologies, Inc. FW643 [TrueFire] PCIe 1394b Controller [16b8:6e11]
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 4 bytes
	Interrupt: pin A routed to IRQ 28
	NUMA node: 0
	Region 0: Memory at fdbff000 (64-bit, non-prefetchable) [size=4K]
	Capabilities: [44] Power Management version 3
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME+
	Capabilities: [4c] MSI: Enable+ Count=1/1 Maskable- 64bit+
		Address: 00000000fee0f00c  Data: 4182
	Capabilities: [60] Express (v1) Endpoint, MSI 00
		DevCap:	MaxPayload 256 bytes, PhantFunc 0, Latency L0s <4us, L1 <64us
			ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset- SlotPowerLimit 0.000W
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 2048 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #0, Speed 2.5GT/s, Width x1, ASPM not supported, Exit Latency L0s <512ns, L1 <64us
			ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp-
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
	Capabilities: [100 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		AERCap:	First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
	Capabilities: [140 v1] Virtual Channel
		Caps:	LPEVC=0 RefClk=100ns PATEntryBits=1
		Arb:	Fixed- WRR32- WRR64- WRR128-
		Ctrl:	ArbSelect=Fixed
		Status:	InProgress-
		VC0:	Caps:	PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
			Arb:	Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
			Status:	NegoPending- InProgress-
		VC1:	Caps:	PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
			Arb:	Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable- ID=0 ArbSelect=Fixed TC/VC=00
			Status:	NegoPending- InProgress-
	Capabilities: [170 v1] Device Serial Number 00-30-93-00-00-00-01-c3
	Kernel driver in use: firewire_ohci
	Kernel modules: firewire_ohci

06:06.0 RAID bus controller [0104]: Silicon Image, Inc. SiI 3124 PCI-X Serial ATA Controller [1095:3124] (rev 02)
	Subsystem: Silicon Image, Inc. SiI 3124 PCI-X Serial ATA Controller [1095:7124]
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR- INTx-
	Latency: 128, Cache Line Size: 4 bytes
	Interrupt: pin A routed to IRQ 20
	NUMA node: 0
	Region 0: Memory at fdaff000 (64-bit, non-prefetchable) [size=128]
	Region 2: Memory at fdaf0000 (64-bit, non-prefetchable) [size=32K]
	Region 4: I/O ports at bf00 [size=16]
	[virtual] Expansion ROM at fd900000 [disabled] [size=512K]
	Capabilities: [64] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=1 PME-
	Capabilities: [40] PCI-X non-bridge device
		Command: DPERE- ERO+ RBC=512 OST=12
		Status: Dev=ff:1f.0 64bit+ 133MHz+ SCD- USC- DC=simple DMMRBC=2048 DMOST=12 DMCRS=128 RSCEM- 266MHz- 533MHz-
	Capabilities: [54] MSI: Enable- Count=1/1 Maskable- 64bit+
		Address: 0000000000000000  Data: 0000
	Kernel driver in use: sata_sil24
	Kernel modules: sata_sil24

06:07.0 Multimedia audio controller [0401]: VIA Technologies Inc. ICE1712 [Envy24] PCI Multi-Channel I/O Controller [1412:1712] (rev 02)
	Subsystem: TERRATEC Electronic GmbH DMX 6fire 24/96 [153b:1138]
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 32
	Interrupt: pin A routed to IRQ 21
	NUMA node: 0
	Region 0: I/O ports at be00 [size=32]
	Region 1: I/O ports at bd00 [size=16]
	Region 2: I/O ports at bc00 [size=16]
	Region 3: I/O ports at bb00 [size=64]
	Capabilities: [80] Power Management version 1
		Flags: PMEClk- DSI- D1- D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Kernel driver in use: snd_ice1712
	Kernel modules: snd_ice1712

06:0e.0 FireWire (IEEE 1394) [0c00]: Texas Instruments TSB43AB23 IEEE-1394a-2000 Controller (PHY/Link) [104c:8024] (prog-if 10 [OHCI])
	Subsystem: Gigabyte Technology Co., Ltd Motherboard [1458:1000]
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 32 (500ns min, 1000ns max), Cache Line Size: 4 bytes
	Interrupt: pin A routed to IRQ 22
	NUMA node: 0
	Region 0: Memory at fdafe000 (32-bit, non-prefetchable) [size=2K]
	Region 1: Memory at fdaf8000 (32-bit, non-prefetchable) [size=16K]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME+
	Kernel driver in use: firewire_ohci
	Kernel modules: firewire_ohci

06:0f.0 Ethernet controller [0200]: Realtek Semiconductor Co., Ltd. RTL-8110SC/8169SC Gigabit Ethernet [10ec:8167] (rev 10)
	Subsystem: Gigabyte Technology Co., Ltd GA-MA69G-S3H Motherboard [1458:e000]
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 64 (8000ns min, 16000ns max), Cache Line Size: 32 bytes
	Interrupt: pin A routed to IRQ 23
	NUMA node: 0
	Region 0: I/O ports at b800 [size=256]
	Region 1: Memory at fdafd000 (32-bit, non-prefetchable) [size=256]
	[virtual] Expansion ROM at fd980000 [disabled] [size=128K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0-,D1+,D2+,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Kernel driver in use: r8169
	Kernel modules: r8169


--nextPart1825563.CaAURjkrJz
Content-Disposition: attachment; filename="dmesg"
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"; name="dmesg"

[    0.000000] Linux version 4.9.2 (root@c21) (gcc version 6.3.0 20161229 (Debian 6.3.0-2) ) #1 SMP Fri Jan 13 20:21:28 CET 2017
[    0.000000] Command line: BOOT_IMAGE=/vmlinuz-4.9.2 root=/dev/md127p2 ro printk.time=1 single video=DVI-D-1:1920x1200-8@60D video=VGA-1:d video=HDMI-A-1:d
[    0.000000] x86/fpu: Legacy x87 FPU detected.
[    0.000000] x86/fpu: Using 'eager' FPU context switches.
[    0.000000] e820: BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x00000000000997ff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009f800-0x000000000009ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000000f0000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x00000000cfedffff] usable
[    0.000000] BIOS-e820: [mem 0x00000000cfee0000-0x00000000cfee2fff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x00000000cfee3000-0x00000000cfeeffff] ACPI data
[    0.000000] BIOS-e820: [mem 0x00000000cfef0000-0x00000000cfefffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000e0000000-0x00000000efffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fec00000-0x00000000ffffffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000022fffffff] usable
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] DMI not present or invalid.
[    0.000000] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.000000] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000000] AGP: No AGP bridge found
[    0.000000] e820: last_pfn = 0x230000 max_arch_pfn = 0x400000000
[    0.000000] MTRR default type: uncachable
[    0.000000] MTRR fixed ranges enabled:
[    0.000000]   00000-9FFFF write-back
[    0.000000]   A0000-BFFFF uncachable
[    0.000000]   C0000-C7FFF write-protect
[    0.000000]   C8000-FFFFF uncachable
[    0.000000] MTRR variable ranges enabled:
[    0.000000]   0 base 000000000000 mask FFFF80000000 write-back
[    0.000000]   1 base 000080000000 mask FFFFC0000000 write-back
[    0.000000]   2 base 0000C0000000 mask FFFFF0000000 write-back
[    0.000000]   3 base 0000CFF00000 mask FFFFFFF00000 uncachable
[    0.000000]   4 base 000100000000 mask FFFF00000000 write-back
[    0.000000]   5 base 000200000000 mask FFFFE0000000 write-back
[    0.000000]   6 base 000220000000 mask FFFFF0000000 write-back
[    0.000000]   7 disabled
[    0.000000] TOM2: 0000000230000000 aka 8960M
[    0.000000] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WC  UC- WT  
[    0.000000] e820: update [mem 0xcff00000-0xffffffff] usable ==> reserved
[    0.000000] e820: last_pfn = 0xcfee0 max_arch_pfn = 0x400000000
[    0.000000] found SMP MP-table at [mem 0x000f4f50-0x000f4f5f] mapped at [ffff89b3400f4f50]
[    0.000000] Base memory trampoline at [ffff89b340093000] 93000 size 24576
[    0.000000] Using GB pages for direct mapping
[    0.000000] BRK [0x207d4a000, 0x207d4afff] PGTABLE
[    0.000000] BRK [0x207d4b000, 0x207d4bfff] PGTABLE
[    0.000000] BRK [0x207d4c000, 0x207d4cfff] PGTABLE
[    0.000000] BRK [0x207d4d000, 0x207d4dfff] PGTABLE
[    0.000000] BRK [0x207d4e000, 0x207d4efff] PGTABLE
[    0.000000] BRK [0x207d4f000, 0x207d4ffff] PGTABLE
[    0.000000] BRK [0x207d50000, 0x207d50fff] PGTABLE
[    0.000000] RAMDISK: [mem 0x3626b000-0x3712cfff]
[    0.000000] ACPI: Early table checksum verification disabled
[    0.000000] ACPI: RSDP 0x00000000000F6920 000014 (v00 GBT   )
[    0.000000] ACPI: RSDT 0x00000000CFEE3000 000038 (v01 GBT    GBTUACPI 42302E31 GBTU 01010101)
[    0.000000] ACPI: FACP 0x00000000CFEE3040 000074 (v01 GBT    GBTUACPI 42302E31 GBTU 01010101)
[    0.000000] ACPI: DSDT 0x00000000CFEE30C0 00494D (v01 GBT    GBTUACPI 00001000 MSFT 03000000)
[    0.000000] ACPI: FACS 0x00000000CFEE0000 000040
[    0.000000] ACPI: SSDT 0x00000000CFEE7B00 00088C (v01 PTLTD  POWERNOW 00000001  LTP 00000001)
[    0.000000] ACPI: HPET 0x00000000CFEE83C0 000038 (v01 GBT    GBTUACPI 42302E31 GBTU 00000098)
[    0.000000] ACPI: MCFG 0x00000000CFEE8400 00003C (v01 GBT    GBTUACPI 42302E31 GBTU 01010101)
[    0.000000] ACPI: APIC 0x00000000CFEE7A40 000084 (v01 GBT    GBTUACPI 42302E31 GBTU 01010101)
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] Scanning NUMA topology in Northbridge 24
[    0.000000] No NUMA configuration found
[    0.000000] Faking a node at [mem 0x0000000000000000-0x000000022fffffff]
[    0.000000] NODE_DATA(0) allocated [mem 0x22fffb000-0x22fffffff]
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.000000]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.000000]   Normal   [mem 0x0000000100000000-0x000000022fffffff]
[    0.000000]   Device   empty
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000001000-0x0000000000098fff]
[    0.000000]   node   0: [mem 0x0000000000100000-0x00000000cfedffff]
[    0.000000]   node   0: [mem 0x0000000100000000-0x000000022fffffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000000001000-0x000000022fffffff]
[    0.000000] On node 0 totalpages: 2096760
[    0.000000]   DMA zone: 64 pages used for memmap
[    0.000000]   DMA zone: 21 pages reserved
[    0.000000]   DMA zone: 3992 pages, LIFO batch:0
[    0.000000]   DMA32 zone: 13244 pages used for memmap
[    0.000000]   DMA32 zone: 847584 pages, LIFO batch:31
[    0.000000]   Normal zone: 19456 pages used for memmap
[    0.000000]   Normal zone: 1245184 pages, LIFO batch:31
[    0.000000] ACPI: PM-Timer IO Port: 0x4008
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x00] dfl dfl lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x01] dfl dfl lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x02] dfl dfl lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x03] dfl dfl lint[0x1])
[    0.000000] IOAPIC[0]: apic_id 2, version 33, address 0xfec00000, GSI 0-23
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] ACPI: HPET id: 0x10b9a201 base: 0xfed00000
[    0.000000] smpboot: Allowing 4 CPUs, 0 hotplug CPUs
[    0.000000] PM: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    0.000000] PM: Registered nosave memory: [mem 0x00099000-0x0009ffff]
[    0.000000] PM: Registered nosave memory: [mem 0x000a0000-0x000effff]
[    0.000000] PM: Registered nosave memory: [mem 0x000f0000-0x000fffff]
[    0.000000] PM: Registered nosave memory: [mem 0xcfee0000-0xcfee2fff]
[    0.000000] PM: Registered nosave memory: [mem 0xcfee3000-0xcfeeffff]
[    0.000000] PM: Registered nosave memory: [mem 0xcfef0000-0xcfefffff]
[    0.000000] PM: Registered nosave memory: [mem 0xcff00000-0xdfffffff]
[    0.000000] PM: Registered nosave memory: [mem 0xe0000000-0xefffffff]
[    0.000000] PM: Registered nosave memory: [mem 0xf0000000-0xfebfffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfec00000-0xffffffff]
[    0.000000] e820: [mem 0xcff00000-0xdfffffff] available for PCI devices
[    0.000000] Booting paravirtualized kernel on bare hardware
[    0.000000] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645519600211568 ns
[    0.000000] setup_percpu: NR_CPUS:512 nr_cpumask_bits:512 nr_cpu_ids:4 nr_node_ids:1
[    0.000000] percpu: Embedded 35 pages/cpu @ffff89b56fc00000 s103768 r8192 d31400 u524288
[    0.000000] pcpu-alloc: s103768 r8192 d31400 u524288 alloc=1*2097152
[    0.000000] pcpu-alloc: [0] 0 1 2 3 
[    0.000000] Built 1 zonelists in Node order, mobility grouping on.  Total pages: 2063975
[    0.000000] Policy zone: Normal
[    0.000000] Kernel command line: BOOT_IMAGE=/vmlinuz-4.9.2 root=/dev/md127p2 ro printk.time=1 single video=DVI-D-1:1920x1200-8@60D video=VGA-1:d video=HDMI-A-1:d
[    0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
[    0.000000] AGP: Checking aperture...
[    0.000000] AGP: No AGP bridge found
[    0.000000] AGP: Node 0: aperture [bus addr 0xc4000000-0xc5ffffff] (32MB)
[    0.000000] Aperture pointing to e820 RAM. Ignoring.
[    0.000000] AGP: Your BIOS doesn't leave an aperture memory hole
[    0.000000] AGP: Please enable the IOMMU option in the BIOS setup
[    0.000000] AGP: This costs you 64MB of RAM
[    0.000000] AGP: Mapping aperture over RAM [mem 0xc4000000-0xc7ffffff] (65536KB)
[    0.000000] PM: Registered nosave memory: [mem 0xc4000000-0xc7ffffff]
[    0.000000] Memory: 8092940K/8387040K available (6138K kernel code, 1134K rwdata, 2812K rodata, 1388K init, 812K bss, 294100K reserved, 0K cma-reserved)
[    0.000000] Hierarchical RCU implementation.
[    0.000000] 	Build-time adjustment of leaf fanout to 64.
[    0.000000] 	RCU restricting CPUs from NR_CPUS=512 to nr_cpu_ids=4.
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=64, nr_cpu_ids=4
[    0.000000] NR_IRQS:33024 nr_irqs:456 16
[    0.000000] spurious 8259A interrupt: IRQ7.
[    0.000000] Console: colour VGA+ 80x25
[    0.000000] console [tty0] enabled
[    0.000000] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 133484873504 ns
[    0.000000] hpet clockevent registered
[    0.000000] tsc: Fast TSC calibration failed
[    0.000000] tsc: Unable to calibrate against PIT
[    0.000000] tsc: using HPET reference calibration
[    0.000000] tsc: Detected 3207.269 MHz processor
[    0.000019] Calibrating delay loop (skipped), value calculated using timer frequency.. 6414.53 BogoMIPS (lpj=12829076)
[    0.000108] pid_max: default: 32768 minimum: 301
[    0.000167] ACPI: Core revision 20160831
[    0.002721] ACPI: 2 ACPI AML tables successfully acquired and loaded
[    0.002856] Security Framework initialized
[    0.002901] Yama: disabled by default; enable with sysctl kernel.yama.*
[    0.002951] AppArmor: AppArmor disabled by boot time parameter
[    0.003356] Dentry cache hash table entries: 1048576 (order: 11, 8388608 bytes)
[    0.006310] Inode-cache hash table entries: 524288 (order: 10, 4194304 bytes)
[    0.007570] Mount-cache hash table entries: 16384 (order: 5, 131072 bytes)
[    0.007623] Mountpoint-cache hash table entries: 16384 (order: 5, 131072 bytes)
[    0.008007] CPU: Physical Processor ID: 0
[    0.008051] CPU: Processor Core ID: 0
[    0.008095] mce: CPU supports 6 MCE banks
[    0.008143] LVT offset 0 assigned for vector 0xf9
[    0.008191] Last level iTLB entries: 4KB 512, 2MB 16, 4MB 8
[    0.008235] Last level dTLB entries: 4KB 512, 2MB 128, 4MB 64, 1GB 0
[    0.008508] Freeing SMP alternatives memory: 24K (ffffffffb6478000 - ffffffffb647e000)
[    0.035545] ftrace: allocating 24972 entries in 98 pages
[    0.043263] smpboot: Max logical packages: 1
[    0.043864] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.189342] smpboot: CPU0: AMD Phenom(tm) II X4 955 Processor (family: 0x10, model: 0x4, stepping: 0x3)
[    0.189506] Performance Events: AMD PMU driver.
[    0.189589] ... version:                0
[    0.189632] ... bit width:              48
[    0.189675] ... generic registers:      4
[    0.189718] ... value mask:             0000ffffffffffff
[    0.189761] ... max period:             00007fffffffffff
[    0.189805] ... fixed-purpose events:   0
[    0.189847] ... event mask:             000000000000000f
[    0.190354] NMI watchdog: enabled on all CPUs, permanently consumes one hw-PMU counter.
[    0.190519] x86: Booting SMP configuration:
[    0.190563] .... node  #0, CPUs:      #1 #2 #3
[    0.431417] x86: Booted up 1 node, 4 CPUs
[    0.431503] smpboot: Total of 4 processors activated (25657.97 BogoMIPS)
[    0.437278] devtmpfs: initialized
[    0.437394] x86/mm: Memory block size: 128MB
[    0.441042] PM: Registering ACPI NVS region [mem 0xcfee0000-0xcfee2fff] (12288 bytes)
[    0.441151] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
[    0.441236] pinctrl core: initialized pinctrl subsystem
[    0.441399] NET: Registered protocol family 16
[    0.453359] cpuidle: using governor ladder
[    0.469358] cpuidle: using governor menu
[    0.469409] node 0 link 0: io port [b000, ffff]
[    0.469410] TOM: 00000000d0000000 aka 3328M
[    0.469454] Fam 10h mmconf [mem 0xe0000000-0xe00fffff]
[    0.469456] node 0 link 0: mmio [a0000, bffff]
[    0.469457] node 0 link 0: mmio [d0000000, dfffffff]
[    0.469459] node 0 link 0: mmio [f0000000, fe02ffff]
[    0.469460] node 0 link 0: mmio [e0000000, e06fffff] ==> [e0100000, e06fffff]
[    0.469461] TOM2: 0000000230000000 aka 8960M
[    0.469505] bus: [bus 00-06] on node 0 link 0
[    0.469506] bus: 00 [io  0x0000-0xffff]
[    0.469507] bus: 00 [mem 0x000a0000-0x000bffff]
[    0.469507] bus: 00 [mem 0xd0000000-0xdfffffff]
[    0.469508] bus: 00 [mem 0xe0700000-0xffffffff]
[    0.469508] bus: 00 [mem 0xe0100000-0xe06fffff]
[    0.469509] bus: 00 [mem 0x230000000-0xfcffffffff]
[    0.469574] ACPI: bus type PCI registered
[    0.469618] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.469699] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xe0000000-0xefffffff] (base 0xe0000000)
[    0.469749] PCI: MMCONFIG at [mem 0xe0000000-0xefffffff] reserved in E820
[    0.469810] PCI: Using configuration type 1 for base access
[    0.470144] mtrr: your CPUs had inconsistent variable MTRR settings
[    0.470189] mtrr: probably your BIOS does not setup all CPUs.
[    0.470232] mtrr: corrected configuration.
[    0.485543] HugeTLB registered 1 GB page size, pre-allocated 0 pages
[    0.485590] HugeTLB registered 2 MB page size, pre-allocated 0 pages
[    0.485975] ACPI: Added _OSI(Module Device)
[    0.486022] ACPI: Added _OSI(Processor Device)
[    0.486066] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.486109] ACPI: Added _OSI(Processor Aggregator Device)
[    0.486328] ACPI: Executed 1 blocks of module-level executable AML code
[    0.491141] ACPI: Interpreter enabled
[    0.491197] ACPI: (supports S0 S3 S4 S5)
[    0.491240] ACPI: Using IOAPIC for interrupt routing
[    0.491336] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    0.495034] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.495084] acpi PNP0A03:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
[    0.495135] acpi PNP0A03:00: _OSC failed (AE_NOT_FOUND); disabling ASPM
[    0.495393] PCI host bridge to bus 0000:00
[    0.495438] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[    0.495483] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    0.495528] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
[    0.498051] pci_bus 0000:00: root bus resource [mem 0x000c0000-0x000dffff window]
[    0.498100] pci_bus 0000:00: root bus resource [mem 0xd0000000-0xfebfffff window]
[    0.498149] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.498198] pci 0000:00:00.0: [1002:7910] type 00 class 0x060000
[    0.498279] pci 0000:00:02.0: [1002:7913] type 01 class 0x060400
[    0.498308] pci 0000:00:02.0: PME# supported from D0 D3hot D3cold
[    0.498346] pci 0000:00:02.0: System wakeup disabled by ACPI
[    0.498424] pci 0000:00:04.0: [1002:7914] type 01 class 0x060400
[    0.498451] pci 0000:00:04.0: PME# supported from D0 D3hot D3cold
[    0.498485] pci 0000:00:04.0: System wakeup disabled by ACPI
[    0.498582] pci 0000:00:12.0: [1002:4380] type 00 class 0x010601
[    0.498598] pci 0000:00:12.0: reg 0x10: [io  0xff00-0xff07]
[    0.498607] pci 0000:00:12.0: reg 0x14: [io  0xfe00-0xfe03]
[    0.498616] pci 0000:00:12.0: reg 0x18: [io  0xfd00-0xfd07]
[    0.498624] pci 0000:00:12.0: reg 0x1c: [io  0xfc00-0xfc03]
[    0.498633] pci 0000:00:12.0: reg 0x20: [io  0xfb00-0xfb0f]
[    0.498642] pci 0000:00:12.0: reg 0x24: [mem 0xfe02f000-0xfe02f3ff]
[    0.498740] pci 0000:00:13.0: [1002:4387] type 00 class 0x0c0310
[    0.498752] pci 0000:00:13.0: reg 0x10: [mem 0xfe02e000-0xfe02efff]
[    0.498843] pci 0000:00:13.0: System wakeup disabled by ACPI
[    0.498920] pci 0000:00:13.1: [1002:4388] type 00 class 0x0c0310
[    0.498933] pci 0000:00:13.1: reg 0x10: [mem 0xfe02d000-0xfe02dfff]
[    0.499024] pci 0000:00:13.1: System wakeup disabled by ACPI
[    0.499101] pci 0000:00:13.2: [1002:4389] type 00 class 0x0c0310
[    0.499114] pci 0000:00:13.2: reg 0x10: [mem 0xfe02c000-0xfe02cfff]
[    0.499204] pci 0000:00:13.2: System wakeup disabled by ACPI
[    0.499285] pci 0000:00:13.3: [1002:438a] type 00 class 0x0c0310
[    0.499298] pci 0000:00:13.3: reg 0x10: [mem 0xfe02b000-0xfe02bfff]
[    0.499400] pci 0000:00:13.3: System wakeup disabled by ACPI
[    0.499477] pci 0000:00:13.4: [1002:438b] type 00 class 0x0c0310
[    0.499490] pci 0000:00:13.4: reg 0x10: [mem 0xfe02a000-0xfe02afff]
[    0.499581] pci 0000:00:13.4: System wakeup disabled by ACPI
[    0.499661] pci 0000:00:13.5: [1002:4386] type 00 class 0x0c0320
[    0.499678] pci 0000:00:13.5: reg 0x10: [mem 0xfe029000-0xfe0290ff]
[    0.499758] pci 0000:00:13.5: supports D1 D2
[    0.499759] pci 0000:00:13.5: PME# supported from D0 D1 D2 D3hot
[    0.499797] pci 0000:00:13.5: System wakeup disabled by ACPI
[    0.499879] pci 0000:00:14.0: [1002:4385] type 00 class 0x0c0500
[    0.499899] pci 0000:00:14.0: reg 0x10: [io  0x0b00-0x0b0f]
[    0.500031] pci 0000:00:14.1: [1002:438c] type 00 class 0x01018a
[    0.500044] pci 0000:00:14.1: reg 0x10: [io  0x0000-0x0007]
[    0.500052] pci 0000:00:14.1: reg 0x14: [io  0x0000-0x0003]
[    0.500061] pci 0000:00:14.1: reg 0x18: [io  0x0000-0x0007]
[    0.500070] pci 0000:00:14.1: reg 0x1c: [io  0x0000-0x0003]
[    0.500079] pci 0000:00:14.1: reg 0x20: [io  0xf900-0xf90f]
[    0.500098] pci 0000:00:14.1: legacy IDE quirk: reg 0x10: [io  0x01f0-0x01f7]
[    0.500143] pci 0000:00:14.1: legacy IDE quirk: reg 0x14: [io  0x03f6]
[    0.500187] pci 0000:00:14.1: legacy IDE quirk: reg 0x18: [io  0x0170-0x0177]
[    0.500232] pci 0000:00:14.1: legacy IDE quirk: reg 0x1c: [io  0x0376]
[    0.500345] pci 0000:00:14.2: [1002:4383] type 00 class 0x040300
[    0.500365] pci 0000:00:14.2: reg 0x10: [mem 0xfe024000-0xfe027fff 64bit]
[    0.500432] pci 0000:00:14.2: PME# supported from D0 D3hot D3cold
[    0.500469] pci 0000:00:14.2: System wakeup disabled by ACPI
[    0.500545] pci 0000:00:14.3: [1002:438d] type 00 class 0x060100
[    0.500671] pci 0000:00:14.4: [1002:4384] type 01 class 0x060401
[    0.500739] pci 0000:00:14.4: System wakeup disabled by ACPI
[    0.500819] pci 0000:00:18.0: [1022:1200] type 00 class 0x060000
[    0.500883] pci 0000:00:18.1: [1022:1201] type 00 class 0x060000
[    0.500942] pci 0000:00:18.2: [1022:1202] type 00 class 0x060000
[    0.501000] pci 0000:00:18.3: [1022:1203] type 00 class 0x060000
[    0.501061] pci 0000:00:18.4: [1022:1204] type 00 class 0x060000
[    0.501166] pci 0000:01:00.0: [1002:6837] type 00 class 0x030000
[    0.501181] pci 0000:01:00.0: reg 0x10: [mem 0xd0000000-0xdfffffff 64bit pref]
[    0.501191] pci 0000:01:00.0: reg 0x18: [mem 0xfdd80000-0xfddbffff 64bit]
[    0.501198] pci 0000:01:00.0: reg 0x20: [io  0xce00-0xceff]
[    0.501210] pci 0000:01:00.0: reg 0x30: [mem 0x00000000-0x0001ffff pref]
[    0.501255] pci 0000:01:00.0: supports D1 D2
[    0.501256] pci 0000:01:00.0: PME# supported from D1 D2 D3hot
[    0.501312] pci 0000:01:00.1: [1002:aab0] type 00 class 0x040300
[    0.501326] pci 0000:01:00.1: reg 0x10: [mem 0xfddfc000-0xfddfffff 64bit]
[    0.501402] pci 0000:01:00.1: supports D1 D2
[    0.515403] pci 0000:00:02.0: PCI bridge to [bus 01]
[    0.515451] pci 0000:00:02.0:   bridge window [io  0xc000-0xcfff]
[    0.515453] pci 0000:00:02.0:   bridge window [mem 0xfdd00000-0xfddfffff]
[    0.515455] pci 0000:00:02.0:   bridge window [mem 0xd0000000-0xdfffffff 64bit pref]
[    0.515534] pci 0000:02:00.0: [12d8:2304] type 01 class 0x060400
[    0.515630] pci 0000:02:00.0: Max Payload Size set to 128 (was 256, max 256)
[    0.515785] pci 0000:02:00.0: supports D1 D2
[    0.515786] pci 0000:02:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.527407] pci 0000:00:04.0: PCI bridge to [bus 02-05]
[    0.527455] pci 0000:00:04.0:   bridge window [io  0xd000-0xefff]
[    0.527457] pci 0000:00:04.0:   bridge window [mem 0xfdb00000-0xfdcfffff]
[    0.527459] pci 0000:00:04.0:   bridge window [mem 0xfde00000-0xfdffffff 64bit pref]
[    0.527567] pci 0000:03:01.0: [12d8:2304] type 01 class 0x060400
[    0.527642] pci 0000:03:01.0: Max Payload Size set to 128 (was 256, max 256)
[    0.527796] pci 0000:03:01.0: supports D1 D2
[    0.527797] pci 0000:03:01.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.527896] pci 0000:03:02.0: [12d8:2304] type 01 class 0x060400
[    0.527969] pci 0000:03:02.0: Max Payload Size set to 128 (was 256, max 256)
[    0.528114] pci 0000:03:02.0: supports D1 D2
[    0.528114] pci 0000:03:02.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.528242] pci 0000:02:00.0: PCI bridge to [bus 03-05]
[    0.528294] pci 0000:02:00.0:   bridge window [io  0xd000-0xefff]
[    0.528299] pci 0000:02:00.0:   bridge window [mem 0xfdb00000-0xfdcfffff]
[    0.528307] pci 0000:02:00.0:   bridge window [mem 0xfde00000-0xfdffffff 64bit pref]
[    0.528392] pci 0000:04:00.0: [1b73:1100] type 00 class 0x0c0330
[    0.528424] pci 0000:04:00.0: reg 0x10: [mem 0xfdce0000-0xfdceffff 64bit]
[    0.528445] pci 0000:04:00.0: reg 0x18: [mem 0xfdcff000-0xfdcfffff 64bit]
[    0.528467] pci 0000:04:00.0: reg 0x20: [mem 0xfdcfe000-0xfdcfefff 64bit]
[    0.528492] pci 0000:04:00.0: Max Payload Size set to 128 (was 256, max 512)
[    0.528611] pci 0000:04:00.0: supports D1
[    0.528612] pci 0000:04:00.0: PME# supported from D0 D1 D3hot
[    0.528701] pci 0000:03:01.0: PCI bridge to [bus 04]
[    0.528752] pci 0000:03:01.0:   bridge window [io  0xe000-0xefff]
[    0.528757] pci 0000:03:01.0:   bridge window [mem 0xfdc00000-0xfdcfffff]
[    0.528765] pci 0000:03:01.0:   bridge window [mem 0xfdf00000-0xfdffffff 64bit pref]
[    0.528852] pci 0000:05:00.0: [11c1:5901] type 00 class 0x0c0010
[    0.528884] pci 0000:05:00.0: reg 0x10: [mem 0xfdbff000-0xfdbfffff 64bit]
[    0.528962] pci 0000:05:00.0: Max Payload Size set to 128 (was 256, max 256)
[    0.529090] pci 0000:05:00.0: supports D1 D2
[    0.529090] pci 0000:05:00.0: PME# supported from D0 D1 D2 D3hot
[    0.539412] pci 0000:03:02.0: PCI bridge to [bus 05]
[    0.539467] pci 0000:03:02.0:   bridge window [io  0xd000-0xdfff]
[    0.539472] pci 0000:03:02.0:   bridge window [mem 0xfdb00000-0xfdbfffff]
[    0.539480] pci 0000:03:02.0:   bridge window [mem 0xfde00000-0xfdefffff 64bit pref]
[    0.539573] pci 0000:06:06.0: [1095:3124] type 00 class 0x010400
[    0.539604] pci 0000:06:06.0: reg 0x10: [mem 0xfdaff000-0xfdaff07f 64bit]
[    0.539623] pci 0000:06:06.0: reg 0x18: [mem 0xfdaf0000-0xfdaf7fff 64bit]
[    0.539635] pci 0000:06:06.0: reg 0x20: [io  0xbf00-0xbf0f]
[    0.539659] pci 0000:06:06.0: reg 0x30: [mem 0x00000000-0x0007ffff pref]
[    0.539723] pci 0000:06:06.0: supports D1 D2
[    0.539769] pci 0000:06:07.0: [1412:1712] type 00 class 0x040100
[    0.539789] pci 0000:06:07.0: reg 0x10: [io  0xbe00-0xbe1f]
[    0.539800] pci 0000:06:07.0: reg 0x14: [io  0xbd00-0xbd0f]
[    0.539812] pci 0000:06:07.0: reg 0x18: [io  0xbc00-0xbc0f]
[    0.539823] pci 0000:06:07.0: reg 0x1c: [io  0xbb00-0xbb3f]
[    0.539891] pci 0000:06:07.0: supports D2
[    0.539938] pci 0000:06:0e.0: [104c:8024] type 00 class 0x0c0010
[    0.539959] pci 0000:06:0e.0: reg 0x10: [mem 0xfdafe000-0xfdafe7ff]
[    0.539971] pci 0000:06:0e.0: reg 0x14: [mem 0xfdaf8000-0xfdafbfff]
[    0.540064] pci 0000:06:0e.0: supports D1 D2
[    0.540065] pci 0000:06:0e.0: PME# supported from D0 D1 D2 D3hot
[    0.540113] pci 0000:06:0f.0: [10ec:8167] type 00 class 0x020000
[    0.540132] pci 0000:06:0f.0: reg 0x10: [io  0xb800-0xb8ff]
[    0.540143] pci 0000:06:0f.0: reg 0x14: [mem 0xfdafd000-0xfdafd0ff]
[    0.540196] pci 0000:06:0f.0: reg 0x30: [mem 0x00000000-0x0001ffff pref]
[    0.540230] pci 0000:06:0f.0: supports D1 D2
[    0.540231] pci 0000:06:0f.0: PME# supported from D1 D2 D3hot D3cold
[    0.540292] pci 0000:00:14.4: PCI bridge to [bus 06] (subtractive decode)
[    0.540339] pci 0000:00:14.4:   bridge window [io  0xb000-0xbfff]
[    0.540342] pci 0000:00:14.4:   bridge window [mem 0xfda00000-0xfdafffff]
[    0.540345] pci 0000:00:14.4:   bridge window [mem 0xfd900000-0xfd9fffff pref]
[    0.540346] pci 0000:00:14.4:   bridge window [io  0x0000-0x0cf7 window] (subtractive decode)
[    0.540347] pci 0000:00:14.4:   bridge window [io  0x0d00-0xffff window] (subtractive decode)
[    0.540348] pci 0000:00:14.4:   bridge window [mem 0x000a0000-0x000bffff window] (subtractive decode)
[    0.540349] pci 0000:00:14.4:   bridge window [mem 0x000c0000-0x000dffff window] (subtractive decode)
[    0.540350] pci 0000:00:14.4:   bridge window [mem 0xd0000000-0xfebfffff window] (subtractive decode)
[    0.540500] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 11) *0, disabled.
[    0.541005] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 10 11) *0, disabled.
[    0.541508] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 10 11) *0, disabled.
[    0.542010] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 10 11) *0, disabled.
[    0.542511] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 10 11) *0, disabled.
[    0.543013] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 10 11) *0, disabled.
[    0.543519] ACPI: PCI Interrupt Link [LNK0] (IRQs 3 4 5 6 7 10 11) *0, disabled.
[    0.544019] ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 5 6 7 10 11) *0, disabled.
[    0.544990] ACPI: Enabled 1 GPEs in block 00 to 1F
[    0.545252] vgaarb: setting as boot device: PCI:0000:01:00.0
[    0.545297] vgaarb: device added: PCI:0000:01:00.0,decodes=io+mem,owns=io+mem,locks=none
[    0.545346] vgaarb: loaded
[    0.545389] vgaarb: bridge control possible 0000:01:00.0
[    0.545464] dmi: Firmware registration failed.
[    0.545561] PCI: Using ACPI for IRQ routing
[    0.554455] PCI: pci_cache_line_size set to 64 bytes
[    0.554534] e820: reserve RAM buffer [mem 0x00099800-0x0009ffff]
[    0.554535] e820: reserve RAM buffer [mem 0xcfee0000-0xcfffffff]
[    0.554750] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0
[    0.554985] hpet0: 4 comparators, 32-bit 14.318180 MHz counter
[    0.557091] clocksource: Switched to clocksource hpet
[    0.563981] VFS: Disk quotas dquot_6.6.0
[    0.564050] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    0.564175] pnp: PnP ACPI init
[    0.564332] system 00:00: [io  0x04d0-0x04d1] has been reserved
[    0.564377] system 00:00: [io  0x0220-0x0225] has been reserved
[    0.564421] system 00:00: [io  0x0290-0x0294] has been reserved
[    0.564467] system 00:00: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.564626] pnp 00:01: disabling [mem 0x00000000-0x00000fff window] because it overlaps 0000:01:00.0 BAR 6 [mem 0x00000000-0x0001ffff pref]
[    0.564682] pnp 00:01: disabling [mem 0x00000000-0x00000fff window disabled] because it overlaps 0000:06:06.0 BAR 6 [mem 0x00000000-0x0007ffff pref]
[    0.564736] pnp 00:01: disabling [mem 0x00000000-0x00000fff window disabled] because it overlaps 0000:06:0f.0 BAR 6 [mem 0x00000000-0x0001ffff pref]
[    0.564806] system 00:01: [io  0x4100-0x411f] has been reserved
[    0.564851] system 00:01: [io  0x0228-0x022f] has been reserved
[    0.564895] system 00:01: [io  0x040b] has been reserved
[    0.564939] system 00:01: [io  0x04d6] has been reserved
[    0.564983] system 00:01: [io  0x0c00-0x0c01] has been reserved
[    0.565027] system 00:01: [io  0x0c14] has been reserved
[    0.565072] system 00:01: [io  0x0c50-0x0c52] has been reserved
[    0.565128] system 00:01: [io  0x0c6c-0x0c6d] has been reserved
[    0.565173] system 00:01: [io  0x0c6f] has been reserved
[    0.565217] system 00:01: [io  0x0cd0-0x0cd1] has been reserved
[    0.565261] system 00:01: [io  0x0cd2-0x0cd3] has been reserved
[    0.565306] system 00:01: [io  0x0cd4-0x0cdf] has been reserved
[    0.565350] system 00:01: [io  0x4000-0x40fe] has been reserved
[    0.565394] system 00:01: [io  0x4210-0x4217] has been reserved
[    0.565439] system 00:01: [io  0x0b00-0x0b1f] could not be reserved
[    0.565483] system 00:01: [io  0x0238-0x023f] has been reserved
[    0.565528] system 00:01: [mem 0xfee00400-0xfee00fff window] has been reserved
[    0.565577] system 00:01: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.565704] pnp 00:02: Plug and Play ACPI device, IDs PNP0b00 (active)
[    0.565823] pnp 00:03: [dma 2]
[    0.565847] pnp 00:03: Plug and Play ACPI device, IDs PNP0700 (active)
[    0.566092] pnp 00:04: Plug and Play ACPI device, IDs PNP0501 (active)
[    0.566330] pnp 00:05: [dma 3]
[    0.566362] pnp 00:05: Plug and Play ACPI device, IDs PNP0401 (active)
[    0.566435] system 00:06: [mem 0xe0000000-0xefffffff] has been reserved
[    0.566481] system 00:06: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.566613] system 00:07: [mem 0x000d6000-0x000d7fff] has been reserved
[    0.566659] system 00:07: [mem 0x000f0000-0x000f7fff] could not be reserved
[    0.566703] system 00:07: [mem 0x000f8000-0x000fbfff] could not be reserved
[    0.566748] system 00:07: [mem 0x000fc000-0x000fffff] could not be reserved
[    0.566792] system 00:07: [mem 0xcfee0000-0xcfefffff] could not be reserved
[    0.566837] system 00:07: [mem 0xffff0000-0xffffffff] has been reserved
[    0.566882] system 00:07: [mem 0x00000000-0x0009ffff] could not be reserved
[    0.566926] system 00:07: [mem 0x00100000-0xcfedffff] could not be reserved
[    0.566971] system 00:07: [mem 0xfec00000-0xfec00fff] could not be reserved
[    0.567016] system 00:07: [mem 0xfee00000-0xfee00fff] could not be reserved
[    0.567060] system 00:07: [mem 0xfff80000-0xfffeffff] has been reserved
[    0.567105] system 00:07: Plug and Play ACPI device, IDs PNP0c01 (active)
[    0.567118] pnp: PnP ACPI: found 8 devices
[    0.573881] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    0.573989] pci 0000:01:00.0: BAR 6: assigned [mem 0xfdd00000-0xfdd1ffff pref]
[    0.574038] pci 0000:00:02.0: PCI bridge to [bus 01]
[    0.574083] pci 0000:00:02.0:   bridge window [io  0xc000-0xcfff]
[    0.574128] pci 0000:00:02.0:   bridge window [mem 0xfdd00000-0xfddfffff]
[    0.574173] pci 0000:00:02.0:   bridge window [mem 0xd0000000-0xdfffffff 64bit pref]
[    0.574223] pci 0000:03:01.0: PCI bridge to [bus 04]
[    0.574269] pci 0000:03:01.0:   bridge window [io  0xe000-0xefff]
[    0.574319] pci 0000:03:01.0:   bridge window [mem 0xfdc00000-0xfdcfffff]
[    0.574367] pci 0000:03:01.0:   bridge window [mem 0xfdf00000-0xfdffffff 64bit pref]
[    0.574422] pci 0000:03:02.0: PCI bridge to [bus 05]
[    0.574468] pci 0000:03:02.0:   bridge window [io  0xd000-0xdfff]
[    0.574518] pci 0000:03:02.0:   bridge window [mem 0xfdb00000-0xfdbfffff]
[    0.574566] pci 0000:03:02.0:   bridge window [mem 0xfde00000-0xfdefffff 64bit pref]
[    0.574621] pci 0000:02:00.0: PCI bridge to [bus 03-05]
[    0.574667] pci 0000:02:00.0:   bridge window [io  0xd000-0xefff]
[    0.574717] pci 0000:02:00.0:   bridge window [mem 0xfdb00000-0xfdcfffff]
[    0.574765] pci 0000:02:00.0:   bridge window [mem 0xfde00000-0xfdffffff 64bit pref]
[    0.574820] pci 0000:00:04.0: PCI bridge to [bus 02-05]
[    0.574864] pci 0000:00:04.0:   bridge window [io  0xd000-0xefff]
[    0.574909] pci 0000:00:04.0:   bridge window [mem 0xfdb00000-0xfdcfffff]
[    0.574954] pci 0000:00:04.0:   bridge window [mem 0xfde00000-0xfdffffff 64bit pref]
[    0.575005] pci 0000:06:06.0: BAR 6: assigned [mem 0xfd900000-0xfd97ffff pref]
[    0.575054] pci 0000:06:0f.0: BAR 6: assigned [mem 0xfd980000-0xfd99ffff pref]
[    0.575103] pci 0000:00:14.4: PCI bridge to [bus 06]
[    0.575147] pci 0000:00:14.4:   bridge window [io  0xb000-0xbfff]
[    0.575195] pci 0000:00:14.4:   bridge window [mem 0xfda00000-0xfdafffff]
[    0.575241] pci 0000:00:14.4:   bridge window [mem 0xfd900000-0xfd9fffff pref]
[    0.575295] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    0.575296] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[    0.575297] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
[    0.575298] pci_bus 0000:00: resource 7 [mem 0x000c0000-0x000dffff window]
[    0.575299] pci_bus 0000:00: resource 8 [mem 0xd0000000-0xfebfffff window]
[    0.575300] pci_bus 0000:01: resource 0 [io  0xc000-0xcfff]
[    0.575301] pci_bus 0000:01: resource 1 [mem 0xfdd00000-0xfddfffff]
[    0.575301] pci_bus 0000:01: resource 2 [mem 0xd0000000-0xdfffffff 64bit pref]
[    0.575303] pci_bus 0000:02: resource 0 [io  0xd000-0xefff]
[    0.575303] pci_bus 0000:02: resource 1 [mem 0xfdb00000-0xfdcfffff]
[    0.575304] pci_bus 0000:02: resource 2 [mem 0xfde00000-0xfdffffff 64bit pref]
[    0.575305] pci_bus 0000:03: resource 0 [io  0xd000-0xefff]
[    0.575306] pci_bus 0000:03: resource 1 [mem 0xfdb00000-0xfdcfffff]
[    0.575307] pci_bus 0000:03: resource 2 [mem 0xfde00000-0xfdffffff 64bit pref]
[    0.575308] pci_bus 0000:04: resource 0 [io  0xe000-0xefff]
[    0.575309] pci_bus 0000:04: resource 1 [mem 0xfdc00000-0xfdcfffff]
[    0.575310] pci_bus 0000:04: resource 2 [mem 0xfdf00000-0xfdffffff 64bit pref]
[    0.575311] pci_bus 0000:05: resource 0 [io  0xd000-0xdfff]
[    0.575312] pci_bus 0000:05: resource 1 [mem 0xfdb00000-0xfdbfffff]
[    0.575313] pci_bus 0000:05: resource 2 [mem 0xfde00000-0xfdefffff 64bit pref]
[    0.575314] pci_bus 0000:06: resource 0 [io  0xb000-0xbfff]
[    0.575315] pci_bus 0000:06: resource 1 [mem 0xfda00000-0xfdafffff]
[    0.575316] pci_bus 0000:06: resource 2 [mem 0xfd900000-0xfd9fffff pref]
[    0.575317] pci_bus 0000:06: resource 4 [io  0x0000-0x0cf7 window]
[    0.575318] pci_bus 0000:06: resource 5 [io  0x0d00-0xffff window]
[    0.575318] pci_bus 0000:06: resource 6 [mem 0x000a0000-0x000bffff window]
[    0.575319] pci_bus 0000:06: resource 7 [mem 0x000c0000-0x000dffff window]
[    0.575320] pci_bus 0000:06: resource 8 [mem 0xd0000000-0xfebfffff window]
[    0.575424] NET: Registered protocol family 2
[    0.575655] TCP established hash table entries: 65536 (order: 7, 524288 bytes)
[    0.575878] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[    0.576242] TCP: Hash tables configured (established 65536 bind 65536)
[    0.576341] UDP hash table entries: 4096 (order: 5, 131072 bytes)
[    0.576436] UDP-Lite hash table entries: 4096 (order: 5, 131072 bytes)
[    0.576569] NET: Registered protocol family 1
[    1.037374] pci 0000:01:00.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
[    1.037547] PCI: CLS 4 bytes, default 64
[    1.037596] Unpacking initramfs...
[    2.404026] Freeing initrd memory: 15112K (ffff89b37626b000 - ffff89b37712d000)
[    2.404368] PCI-DMA: Disabling AGP.
[    2.404511] PCI-DMA: aperture base @ c4000000 size 65536 KB
[    2.404555] PCI-DMA: using GART IOMMU.
[    2.404600] PCI-DMA: Reserving 64MB of IOMMU area in the AGP aperture
[    2.407924] LVT offset 1 assigned for vector 0x400
[    2.407981] IBS: LVT offset 1 assigned
[    2.408157] perf: AMD IBS detected (0x0000001f)
[    2.408524] futex hash table entries: 1024 (order: 4, 65536 bytes)
[    2.408596] audit: initializing netlink subsys (disabled)
[    2.408663] audit: type=2000 audit(1484393533.296:1): initialized
[    2.408974] Initialise system trusted keyrings
[    2.409193] workingset: timestamp_bits=40 max_order=21 bucket_order=0
[    2.409293] zbud: loaded
[    2.454442] Key type asymmetric registered
[    2.454491] Asymmetric key parser 'x509' registered
[    2.454576] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 251)
[    2.454664] io scheduler noop registered
[    2.454708] io scheduler deadline registered
[    2.454755] io scheduler cfq registered (default)
[    2.455507] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[    2.455555] pciehp: PCI Express Hot Plug Controller Driver version: 0.4
[    2.455758] GHES: HEST is not enabled!
[    2.455870] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    2.476468] 00:04: ttyS1 at I/O 0x2f8 (irq = 3, base_baud = 115200) is a 16550A
[    2.476941] Linux agpgart interface v0.103
[    2.477012] AMD IOMMUv2 driver by Joerg Roedel <jroedel@suse.de>
[    2.477056] AMD IOMMUv2 functionality not available on this system
[    2.479968] i8042: PNP: No PS/2 controller found. Probing ports directly.
[    2.513615] i8042: Failed to disable AUX port, but continuing anyway... Is this a SiS?
[    2.513663] i8042: If AUX port is really absent please use the 'i8042.noaux' option
[    2.797233] serio: i8042 KBD port at 0x60,0x64 irq 1
[    2.797443] mousedev: PS/2 mouse device common for all mice
[    2.797535] rtc_cmos 00:02: RTC can wake from S4
[    2.797692] rtc_cmos 00:02: rtc core: registered rtc_cmos as rtc0
[    2.797771] rtc_cmos 00:02: alarms up to one month, 242 bytes nvram, hpet irqs
[    2.797909] ledtrig-cpu: registered to indicate activity on CPUs
[    2.797952] dmi-sysfs: dmi entry is absent.
[    2.798119] NET: Registered protocol family 10
[    2.798377] mip6: Mobile IPv6
[    2.798421] NET: Registered protocol family 17
[    2.798466] mpls_gso: MPLS GSO support
[    2.798730] microcode: CPU0: patch_level=0x010000af
[    2.798783] microcode: CPU1: patch_level=0x010000af
[    2.798844] microcode: CPU2: patch_level=0x010000af
[    2.798909] microcode: CPU3: patch_level=0x010000af
[    2.798992] microcode: Microcode Update Driver: v2.01 <tigran@aivazian.fsnet.co.uk>, Peter Oruba
[    2.799165] registered taskstats version 1
[    2.799210] Loading compiled-in X.509 certificates
[    2.799265] zswap: loaded using pool lzo/zbud
[    2.799749] rtc_cmos 00:02: setting system clock to 2017-01-14 11:32:13 UTC (1484393533)
[    2.799844] PM: Hibernation image not present or could not be loaded.
[    2.801085] Freeing unused kernel memory: 1388K (ffffffffb631d000 - ffffffffb6478000)
[    2.801160] Write protecting the kernel read-only data: 12288k
[    2.801844] Freeing unused kernel memory: 2040K (ffff89b547402000 - ffff89b547600000)
[    2.804783] Freeing unused kernel memory: 1284K (ffff89b5478bf000 - ffff89b547a00000)
[    2.810210] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    2.823232] random: systemd-udevd: uninitialized urandom read (16 bytes read)
[    2.823338] random: systemd-udevd: uninitialized urandom read (16 bytes read)
[    2.823390] random: systemd-udevd: uninitialized urandom read (16 bytes read)
[    2.823443] random: systemd-udevd: uninitialized urandom read (16 bytes read)
[    2.824136] random: udevadm: uninitialized urandom read (16 bytes read)
[    2.824211] random: udevadm: uninitialized urandom read (16 bytes read)
[    2.825023] random: udevadm: uninitialized urandom read (16 bytes read)
[    2.825386] random: udevadm: uninitialized urandom read (16 bytes read)
[    2.825480] random: udevadm: uninitialized urandom read (16 bytes read)
[    2.825568] random: udevadm: uninitialized urandom read (16 bytes read)
[    2.842139] fjes: module verification failed: signature and/or required key missing - tainting kernel
[    2.842553] FUJITSU Extended Socket Network Device Driver - version 1.1 - Copyright (c) 2015 FUJITSU LIMITED
[    2.843356] Floppy drive(s): fd0 is 1.44M
[    2.848479] SCSI subsystem initialized
[    2.849152] ACPI: bus type USB registered
[    2.849221] usbcore: registered new interface driver usbfs
[    2.849274] usbcore: registered new interface driver hub
[    2.849337] usbcore: registered new device driver usb
[    2.849584] [drm] Initialized
[    2.849832] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    2.850434] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    2.850734] ehci-pci: EHCI PCI platform driver
[    2.850893] libata version 3.00 loaded.
[    2.850976] ehci-pci 0000:00:13.5: EHCI Host Controller
[    2.851031] ehci-pci 0000:00:13.5: new USB bus registered, assigned bus number 1
[    2.851088] ehci-pci 0000:00:13.5: applying AMD SB600/SB700 USB freeze workaround
[    2.851150] ehci-pci 0000:00:13.5: debug port 1
[    2.851253] ehci-pci 0000:00:13.5: irq 19, io mem 0xfe029000
[    2.852904] sata_sil24 0000:06:06.0: version 1.1
[    2.853794] scsi host0: sata_sil24
[    2.853949] scsi host1: sata_sil24
[    2.854075] scsi host2: sata_sil24
[    2.854219] scsi host3: sata_sil24
[    2.854311] ata1: SATA max UDMA/100 host m128@0xfdaff000 port 0xfdaf0000 irq 20
[    2.854367] ata2: SATA max UDMA/100 host m128@0xfdaff000 port 0xfdaf2000 irq 20
[    2.854424] ata3: SATA max UDMA/100 host m128@0xfdaff000 port 0xfdaf4000 irq 20
[    2.854476] ata4: SATA max UDMA/100 host m128@0xfdaff000 port 0xfdaf6000 irq 20
[    2.854598] r8169 Gigabit Ethernet driver 2.3LK-NAPI loaded
[    2.854765] r8169 0000:06:0f.0 (unnamed net_device) (uninitialized): not PCI Express
[    2.855109] r8169 0000:06:0f.0 eth0: RTL8169sc/8110sc at 0xffffb7b900c91000, 00:1a:4d:9a:6d:99, XID 18000000 IRQ 23
[    2.855161] r8169 0000:06:0f.0 eth0: jumbo features [frames: 7152 bytes, tx checksumming: ok]
[    2.859817] [drm] radeon kernel modesetting enabled.
[    2.861011] [drm] initializing kernel modesetting (VERDE 0x1002:0x6837 0x1787:0x2330 0x00).
[    2.861072] [drm] register mmio base: 0xFDD80000
[    2.861137] [drm] register mmio size: 262144
[    2.861243] radeon 0000:01:00.0: Invalid PCI ROM header signature: expecting 0xaa55, got 0xffff
[    2.861696] ATOM BIOS: C44101
[    2.861907] radeon 0000:01:00.0: VRAM: 1024M 0x0000000000000000 - 0x000000003FFFFFFF (1024M used)
[    2.861957] radeon 0000:01:00.0: GTT: 2048M 0x0000000040000000 - 0x00000000BFFFFFFF
[    2.862013] [drm] Detected VRAM RAM=1024M, BAR=256M
[    2.862062] [drm] RAM width 128bits DDR
[    2.862177] [TTM] Zone  kernel: Available graphics memory: 4089370 kiB
[    2.862225] [TTM] Zone   dma32: Available graphics memory: 2097152 kiB
[    2.862270] [TTM] Initializing pool allocator
[    2.862322] [TTM] Initializing DMA pool allocator
[    2.862387] [drm] radeon: 1024M of VRAM memory ready
[    2.862431] [drm] radeon: 2048M of GTT memory ready.
[    2.862488] [drm] Loading verde Microcode
[    2.862554] radeon 0000:01:00.0: firmware: direct-loading firmware radeon/verde_pfp.bin
[    2.862615] radeon 0000:01:00.0: firmware: direct-loading firmware radeon/verde_me.bin
[    2.862680] radeon 0000:01:00.0: firmware: direct-loading firmware radeon/verde_ce.bin
[    2.862743] radeon 0000:01:00.0: firmware: direct-loading firmware radeon/verde_rlc.bin
[    2.862810] radeon 0000:01:00.0: firmware: direct-loading firmware radeon/verde_mc.bin
[    2.862887] radeon 0000:01:00.0: firmware: direct-loading firmware radeon/verde_smc.bin
[    2.862938] [drm] Internal thermal controller with fan control
[    2.863047] [drm] probing gen 2 caps for device 1002:7913 = 100d01/0
[    2.865354] FDC 0 is a post-1991 82077
[    2.869116] ehci-pci 0000:00:13.5: USB 2.0 started, EHCI 1.00
[    2.869206] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
[    2.869255] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.869304] usb usb1: Product: EHCI Host Controller
[    2.869354] usb usb1: Manufacturer: Linux 4.9.2 ehci_hcd
[    2.869398] usb usb1: SerialNumber: 0000:00:13.5
[    2.869583] hub 1-0:1.0: USB hub found
[    2.869642] hub 1-0:1.0: 10 ports detected
[    2.869912] ahci 0000:00:12.0: version 3.0
[    2.870031] ahci 0000:00:12.0: controller can't do 64bit DMA, forcing 32bit
[    2.870239] ahci 0000:00:12.0: AHCI 0001.0100 32 slots 4 ports 3 Gbps 0xf impl SATA mode
[    2.870336] ahci 0000:00:12.0: flags: ncq sntf ilck pm led clo pmp pio slum part ccc 
[    2.870605] ohci-pci: OHCI PCI platform driver
[    2.871068] xhci_hcd 0000:04:00.0: xHCI Host Controller
[    2.871140] xhci_hcd 0000:04:00.0: new USB bus registered, assigned bus number 2
[    2.871363] [drm] radeon: dpm initialized
[    2.871552] radeon 0000:01:00.0: firmware: direct-loading firmware radeon/TAHITI_uvd.bin
[    2.871701] radeon 0000:01:00.0: firmware: direct-loading firmware radeon/TAHITI_vce.bin
[    2.872466] [drm] Found VCE firmware/feedback version 50.0.1 / 17!
[    2.872575] [drm] GART: num cpu pages 524288, num gpu pages 524288
[    2.872668] xhci_hcd 0000:04:00.0: hcc params 0x200071e1 hci version 0x100 quirks 0x00000010
[    2.872925] usb usb2: New USB device found, idVendor=1d6b, idProduct=0002
[    2.872971] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.873025] usb usb2: Product: xHCI Host Controller
[    2.873073] usb usb2: Manufacturer: Linux 4.9.2 xhci-hcd
[    2.873148] usb usb2: SerialNumber: 0000:04:00.0
[    2.873477] hub 2-0:1.0: USB hub found
[    2.873540] hub 2-0:1.0: 4 ports detected
[    2.873739] xhci_hcd 0000:04:00.0: xHCI Host Controller
[    2.873792] xhci_hcd 0000:04:00.0: new USB bus registered, assigned bus number 3
[    2.873862] usb usb3: We don't know the algorithms for LPM for this host, disabling LPM.
[    2.873936] usb usb3: New USB device found, idVendor=1d6b, idProduct=0003
[    2.873984] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.874032] usb usb3: Product: xHCI Host Controller
[    2.874082] usb usb3: Manufacturer: Linux 4.9.2 xhci-hcd
[    2.874126] usb usb3: SerialNumber: 0000:04:00.0
[    2.874700] hub 3-0:1.0: USB hub found
[    2.874871] hub 3-0:1.0: 4 ports detected
[    2.875504] [drm] probing gen 2 caps for device 1002:7913 = 100d01/0
[    2.877835] scsi host4: ahci
[    2.881155] scsi host5: ahci
[    2.881376] scsi host6: ahci
[    2.881565] scsi host7: ahci
[    2.881715] ata5: SATA max UDMA/133 abar m1024@0xfe02f000 port 0xfe02f100 irq 22
[    2.881830] ata6: SATA max UDMA/133 abar m1024@0xfe02f000 port 0xfe02f180 irq 22
[    2.882625] r8169 0000:06:0f.0 enp6s15: renamed from eth0
[    2.886417] ata7: SATA max UDMA/133 abar m1024@0xfe02f000 port 0xfe02f200 irq 22
[    2.886505] ata8: SATA max UDMA/133 abar m1024@0xfe02f000 port 0xfe02f280 irq 22
[    2.887587] scsi host8: pata_atiixp
[    2.887817] scsi host9: pata_atiixp
[    2.887949] ata9: PATA max UDMA/100 cmd 0x1f0 ctl 0x3f6 bmdma 0xf900 irq 14
[    2.888045] ata10: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0xf908 irq 15
[    2.888168] piix4_smbus 0000:00:14.0: SMBus Host Controller at 0xb00, revision 0
[    2.888298] piix4_smbus 0000:00:14.0: Auxiliary SMBus Host Controller at 0xb10
[    2.888544] ohci-pci 0000:00:13.0: OHCI PCI host controller
[    2.888683] ohci-pci 0000:00:13.0: new USB bus registered, assigned bus number 4
[    2.888842] ohci-pci 0000:00:13.0: irq 16, io mem 0xfe02e000
[    2.894834] [drm] PCIE GART of 2048M enabled (table at 0x00000000001D6000).
[    2.894998] radeon 0000:01:00.0: WB enabled
[    2.895043] radeon 0000:01:00.0: fence driver on ring 0 use gpu addr 0x0000000040000c00 and cpu addr 0xffff89b55f9b9c00
[    2.895093] radeon 0000:01:00.0: fence driver on ring 1 use gpu addr 0x0000000040000c04 and cpu addr 0xffff89b55f9b9c04
[    2.895142] radeon 0000:01:00.0: fence driver on ring 2 use gpu addr 0x0000000040000c08 and cpu addr 0xffff89b55f9b9c08
[    2.895192] radeon 0000:01:00.0: fence driver on ring 3 use gpu addr 0x0000000040000c0c and cpu addr 0xffff89b55f9b9c0c
[    2.895241] radeon 0000:01:00.0: fence driver on ring 4 use gpu addr 0x0000000040000c10 and cpu addr 0xffff89b55f9b9c10
[    2.895741] radeon 0000:01:00.0: fence driver on ring 5 use gpu addr 0x0000000000075a18 and cpu addr 0xffffb7b901635a18
[    2.915851] radeon 0000:01:00.0: fence driver on ring 6 use gpu addr 0x0000000040000c18 and cpu addr 0xffff89b55f9b9c18
[    2.915901] radeon 0000:01:00.0: fence driver on ring 7 use gpu addr 0x0000000040000c1c and cpu addr 0xffff89b55f9b9c1c
[    2.915975] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[    2.916026] [drm] Driver supports precise vblank timestamp query.
[    2.916073] radeon 0000:01:00.0: radeon: MSI limited to 32-bit
[    2.916162] radeon 0000:01:00.0: radeon: using MSI.
[    2.916239] [drm] radeon: irq initialized.
[    2.925180] firewire_ohci 0000:05:00.0: added OHCI v1.10 device as card 0, 8 IR + 8 IT contexts, quirks 0x0, physUB
[    2.953176] usb usb4: New USB device found, idVendor=1d6b, idProduct=0001
[    2.953240] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.953306] usb usb4: Product: OHCI PCI host controller
[    2.953367] usb usb4: Manufacturer: Linux 4.9.2 ohci_hcd
[    2.953428] usb usb4: SerialNumber: 0000:00:13.0
[    2.953617] hub 4-0:1.0: USB hub found
[    2.953693] hub 4-0:1.0: 2 ports detected
[    2.953942] ohci-pci 0000:00:13.1: OHCI PCI host controller
[    2.954007] ohci-pci 0000:00:13.1: new USB bus registered, assigned bus number 5
[    2.954109] ohci-pci 0000:00:13.1: irq 17, io mem 0xfe02d000
[    2.985180] firewire_ohci 0000:06:0e.0: added OHCI v1.10 device as card 1, 4 IR + 8 IT contexts, quirks 0x2
[    3.021177] usb usb5: New USB device found, idVendor=1d6b, idProduct=0001
[    3.021241] usb usb5: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    3.021307] usb usb5: Product: OHCI PCI host controller
[    3.021368] usb usb5: Manufacturer: Linux 4.9.2 ohci_hcd
[    3.021429] usb usb5: SerialNumber: 0000:00:13.1
[    3.021613] hub 5-0:1.0: USB hub found
[    3.021689] hub 5-0:1.0: 2 ports detected
[    3.021943] ohci-pci 0000:00:13.2: OHCI PCI host controller
[    3.022008] ohci-pci 0000:00:13.2: new USB bus registered, assigned bus number 6
[    3.022111] ohci-pci 0000:00:13.2: irq 18, io mem 0xfe02c000
[    3.052125] ata9.00: ATAPI: ASUS    DRW-1814BL, 1.14, max UDMA/66
[    3.057341] ata9.00: configured for UDMA/66
[    3.085182] usb usb6: New USB device found, idVendor=1d6b, idProduct=0001
[    3.085245] usb usb6: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    3.085311] usb usb6: Product: OHCI PCI host controller
[    3.085372] usb usb6: Manufacturer: Linux 4.9.2 ohci_hcd
[    3.085434] usb usb6: SerialNumber: 0000:00:13.2
[    3.085623] hub 6-0:1.0: USB hub found
[    3.085702] hub 6-0:1.0: 2 ports detected
[    3.085954] ohci-pci 0000:00:13.3: OHCI PCI host controller
[    3.086020] ohci-pci 0000:00:13.3: new USB bus registered, assigned bus number 7
[    3.086108] ohci-pci 0000:00:13.3: irq 17, io mem 0xfe02b000
[    3.153163] usb usb7: New USB device found, idVendor=1d6b, idProduct=0001
[    3.153227] usb usb7: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    3.153292] usb usb7: Product: OHCI PCI host controller
[    3.153354] usb usb7: Manufacturer: Linux 4.9.2 ohci_hcd
[    3.153415] usb usb7: SerialNumber: 0000:00:13.3
[    3.153583] hub 7-0:1.0: USB hub found
[    3.153659] hub 7-0:1.0: 2 ports detected
[    3.153885] ohci-pci 0000:00:13.4: OHCI PCI host controller
[    3.153949] ohci-pci 0000:00:13.4: new USB bus registered, assigned bus number 8
[    3.154047] ohci-pci 0000:00:13.4: irq 18, io mem 0xfe02a000
[    3.199705] ata8: SATA link down (SStatus 0 SControl 300)
[    3.205129] usb 1-1: new high-speed USB device number 2 using ehci-pci
[    3.217168] usb usb8: New USB device found, idVendor=1d6b, idProduct=0001
[    3.217231] usb usb8: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    3.217296] usb usb8: Product: OHCI PCI host controller
[    3.217357] usb usb8: Manufacturer: Linux 4.9.2 ohci_hcd
[    3.217418] usb usb8: SerialNumber: 0000:00:13.4
[    3.217588] hub 8-0:1.0: USB hub found
[    3.217663] hub 8-0:1.0: 2 ports detected
[    3.361131] ata7: softreset failed (device not ready)
[    3.361196] ata7: applying PMP SRST workaround and retrying
[    3.377529] usb 1-1: New USB device found, idVendor=03f0, idProduct=0610
[    3.377592] usb 1-1: New USB device strings: Mfr=10, Product=11, SerialNumber=0
[    3.377658] usb 1-1: Product: USB2.0 HUB
[    3.377718] usb 1-1: Manufacturer: Genesyslogic
[    3.378171] hub 1-1:1.0: USB hub found
[    3.379915] hub 1-1:1.0: 4 ports detected
[    3.437206] firewire_core 0000:05:00.0: created device fw0: GUID 00309300000001c3, S800
[    3.441187] tsc: Refined TSC clocksource calibration: 3207.272 MHz
[    3.441259] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x2e3b1f431f7, max_idle_ns: 440795241363 ns
[    3.501195] firewire_core 0000:06:0e.0: created device fw1: GUID 001a4d0000eb2917, S400
[    3.503056] [drm] ring test on 0 succeeded in 1 usecs
[    3.503107] [drm] ring test on 1 succeeded in 1 usecs
[    3.503154] [drm] ring test on 2 succeeded in 1 usecs
[    3.503212] [drm] ring test on 3 succeeded in 10 usecs
[    3.503267] [drm] ring test on 4 succeeded in 10 usecs
[    3.521140] ata7: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    3.521313] ata7.00: ATA-8: OCZ-VECTOR180, 1.01, max UDMA/133
[    3.521360] ata7.00: 234441648 sectors, multi 1: LBA48 NCQ (depth 31/32), AA
[    3.521406] ata7.00: SB600 AHCI: limiting to 255 sectors per cmd
[    3.522443] ata7.00: SB600 AHCI: limiting to 255 sectors per cmd
[    3.522490] ata7.00: configured for UDMA/133
[    3.573130] ata5: softreset failed (device not ready)
[    3.573177] ata5: applying PMP SRST workaround and retrying
[    3.573240] ata6: softreset failed (device not ready)
[    3.573287] ata6: applying PMP SRST workaround and retrying
[    3.679100] [drm] ring test on 5 succeeded in 1 usecs
[    3.679151] [drm] UVD initialized successfully.
[    3.733138] ata6: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    3.733210] ata5: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    3.734479] ata6.00: HPA detected: current 3907020911, native 3907029168
[    3.734631] ata6.00: ATA-8: Hitachi HDS5C3020ALA632, ML6OA580, max UDMA/133
[    3.734676] ata6.00: 3907020911 sectors, multi 16: LBA48 NCQ (depth 31/32), AA
[    3.734725] ata6.00: SB600 AHCI: limiting to 255 sectors per cmd
[    3.736209] ata6.00: SB600 AHCI: limiting to 255 sectors per cmd
[    3.736255] ata6.00: configured for UDMA/133
[    3.737122] usb 1-1.1: new full-speed USB device number 4 using ehci-pci
[    3.738726] ata5.00: ATA-8: WDC WD10EARS-00MVWB0, 51.0AB51, max UDMA/133
[    3.738773] ata5.00: 1953525168 sectors, multi 16: LBA48 NCQ (depth 31/32), AA
[    3.738822] ata5.00: SB600 AHCI: limiting to 255 sectors per cmd
[    3.743261] ata5.00: SB600 AHCI: limiting to 255 sectors per cmd
[    3.743307] ata5.00: configured for UDMA/133
[    3.788406] [drm] ring test on 6 succeeded in 18 usecs
[    3.788465] [drm] ring test on 7 succeeded in 4 usecs
[    3.788508] [drm] VCE initialized successfully.
[    3.788655] [drm] ib test on ring 0 succeeded in 0 usecs
[    3.788731] [drm] ib test on ring 1 succeeded in 0 usecs
[    3.788804] [drm] ib test on ring 2 succeeded in 0 usecs
[    3.788892] [drm] ib test on ring 3 succeeded in 0 usecs
[    3.788978] [drm] ib test on ring 4 succeeded in 0 usecs
[    3.857720] usb 1-1.1: New USB device found, idVendor=046d, idProduct=c042
[    3.857767] usb 1-1.1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    3.857815] usb 1-1.1: Product: USB Gaming Mouse
[    3.857859] usb 1-1.1: Manufacturer: Logitech
[    3.860923] hidraw: raw HID events driver (C) Jiri Kosina
[    3.870963] usbcore: registered new interface driver usbhid
[    3.871010] usbhid: USB HID core driver
[    3.871666] input: Logitech USB Gaming Mouse as /devices/pci0000:00/0000:00:13.5/usb1/1-1/1-1.1/1-1.1:1.0/0003:046D:C042.0001/input/input1
[    3.871798] hid-generic 0003:046D:C042.0001: input,hidraw0: USB HID v1.11 Mouse [Logitech USB Gaming Mouse] on usb-0000:00:13.5-1.1/input0
[    3.872818] hid-generic 0003:046D:C042.0002: hiddev0,hidraw1: USB HID v1.11 Device [Logitech USB Gaming Mouse] on usb-0000:00:13.5-1.1/input1
[    3.965137] usb 7-1: new full-speed USB device number 2 using ohci-pci
[    3.965139] usb 1-8: new high-speed USB device number 5 using ehci-pci
[    4.117522] usb 1-8: New USB device found, idVendor=05e3, idProduct=070e
[    4.117569] usb 1-8: New USB device strings: Mfr=3, Product=4, SerialNumber=5
[    4.120169] usb 1-8: Product: USB Reader
[    4.120213] usb 1-8: Manufacturer: Genesys
[    4.120256] usb 1-8: SerialNumber: 000000590523
[    4.122861] usb-storage 1-8:1.0: USB Mass Storage device detected
[    4.123056] scsi host10: usb-storage 1-8:1.0
[    4.123169] usbcore: registered new interface driver usb-storage
[    4.123509] usbcore: registered new interface driver uas
[    4.164139] usb 7-1: New USB device found, idVendor=0a5c, idProduct=21e8
[    4.164186] usb 7-1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[    4.164231] usb 7-1: Product: BCM920702 Bluetooth 4.0
[    4.164274] usb 7-1: Manufacturer: Broadcom Corp
[    4.164318] usb 7-1: SerialNumber: 5CF3707BF326
[    4.193124] usb 1-1.2: new low-speed USB device number 6 using ehci-pci
[    4.321298] usb 1-1.2: New USB device found, idVendor=04d9, idProduct=1603
[    4.321345] usb 1-1.2: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    4.321393] usb 1-1.2: Product: USB Keyboard
[    4.321436] usb 1-1.2: Manufacturer:  
[    4.331906] input:   USB Keyboard as /devices/pci0000:00/0000:00:13.5/usb1/1-1/1-1.2/1-1.2:1.0/0003:04D9:1603.0003/input/input2
[    4.389252] hid-generic 0003:04D9:1603.0003: input,hidraw2: USB HID v1.10 Keyboard [  USB Keyboard] on usb-0000:00:13.5-1.2/input0
[    4.406353] input:   USB Keyboard as /devices/pci0000:00/0000:00:13.5/usb1/1-1/1-1.2/1-1.2:1.1/0003:04D9:1603.0004/input/input3
[    4.421128] usb 1-9: new high-speed USB device number 7 using ehci-pci
[    4.461159] [drm] ib test on ring 5 succeeded
[    4.461229] clocksource: Switched to clocksource tsc
[    4.465165] hid-generic 0003:04D9:1603.0004: input,hidraw3: USB HID v1.10 Device [  USB Keyboard] on usb-0000:00:13.5-1.2/input1
[    4.572950] usb 1-9: New USB device found, idVendor=05e3, idProduct=0716
[    4.572997] usb 1-9: New USB device strings: Mfr=0, Product=1, SerialNumber=2
[    4.573041] usb 1-9: Product: USB Storage
[    4.573085] usb 1-9: SerialNumber: 000000009744
[    4.573726] usb-storage 1-9:1.0: USB Mass Storage device detected
[    4.573859] scsi host11: usb-storage 1-9:1.0
[    4.917131] ata1: SATA link down (SStatus 0 SControl 0)
[    4.973141] [drm] ib test on ring 6 succeeded
[    5.134285] scsi 10:0:0:0: Direct-Access     Generic  STORAGE DEVICE   9325 PQ: 0 ANSI: 0
[    5.135161] scsi 10:0:0:1: Direct-Access     Generic  STORAGE DEVICE   9325 PQ: 0 ANSI: 0
[    5.139120] random: fast init done
[    5.139389] sd 10:0:0:0: [sda] Attached SCSI removable disk
[    5.140013] sd 10:0:0:1: [sdb] Attached SCSI removable disk
[    5.485144] [drm] ib test on ring 7 succeeded
[    5.485219] [drm] hw_i2c forced on, you may experience display detection problems!
[    5.485507] [drm] forcing HDMI-A-1 connector OFF
[    5.485598] [drm] forcing DVI-D-1 connector ON
[    5.485676] [drm] forcing VGA-1 connector OFF
[    5.485743] [drm] Radeon Display Connectors
[    5.485786] [drm] Connector 0:
[    5.485829] [drm]   HDMI-A-1
[    5.485871] [drm]   HPD1
[    5.485914] [drm]   DDC: 0x6570 0x6570 0x6574 0x6574 0x6578 0x6578 0x657c 0x657c
[    5.485962] [drm]   Encoders:
[    5.486004] [drm]     DFP1: INTERNAL_UNIPHY2
[    5.486047] [drm] Connector 1:
[    5.486089] [drm]   DVI-D-1
[    5.486132] [drm]   HPD2
[    5.486175] [drm]   DDC: 0x6560 0x6560 0x6564 0x6564 0x6568 0x6568 0x656c 0x656c
[    5.486222] [drm]   Encoders:
[    5.486265] [drm]     DFP2: INTERNAL_UNIPHY
[    5.486307] [drm] Connector 2:
[    5.486350] [drm]   VGA-1
[    5.486392] [drm]   DDC: 0x6540 0x6540 0x6544 0x6544 0x6548 0x6548 0x654c 0x654c
[    5.486440] [drm]   Encoders:
[    5.486482] [drm]     CRT1: INTERNAL_KLDSCP_DAC1
[    5.517096] [drm] fb mappable at 0xD05D9000
[    5.517139] [drm] vram apper at 0xD0000000
[    5.517182] [drm] size 2457600
[    5.517225] [drm] fb depth is 8
[    5.517267] [drm]    pitch is 2048
[    5.517376] fbcon: radeondrmfb (fb0) is primary device
[    5.572944] Console: switching to colour frame buffer device 240x75
[    5.574467] radeon 0000:01:00.0: fb0: radeondrmfb frame buffer device
[    5.582461] scsi 11:0:0:0: Direct-Access     Generic  STORAGE DEVICE   9744 PQ: 0 ANSI: 0
[    5.583336] scsi 11:0:0:1: Direct-Access     Generic  STORAGE DEVICE   9744 PQ: 0 ANSI: 0
[    5.591698] sd 11:0:0:0: [sdc] Attached SCSI removable disk
[    5.592329] sd 11:0:0:1: [sdd] Attached SCSI removable disk
[    5.593474] [drm] Initialized radeon 2.48.0 20080528 for 0000:01:00.0 on minor 0
[    7.097288] ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
[    7.098176] ata2.00: HPA detected: current 312579695, native 312581808
[    7.098195] ata2.00: ATA-7: Hitachi HDS721616PLA380, P22OABEA, max UDMA/133
[    7.098205] ata2.00: 312579695 sectors, multi 16: LBA48 NCQ (depth 31/32)
[    7.099255] ata2.00: configured for UDMA/100
[    7.099452] scsi 1:0:0:0: Direct-Access     ATA      Hitachi HDS72161 ABEA PQ: 0 ANSI: 5
[    7.129293] sd 1:0:0:0: [sde] 312579695 512-byte logical blocks: (160 GB/149 GiB)
[    7.129411] sd 1:0:0:0: [sde] Write Protect is off
[    7.129424] sd 1:0:0:0: [sde] Mode Sense: 00 3a 00 00
[    7.129453] sd 1:0:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    7.151580] sd 1:0:0:0: [sde] Attached SCSI disk
[    9.309288] ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
[    9.310172] ata3.00: HPA detected: current 312579695, native 312581808
[    9.310187] ata3.00: ATA-7: Hitachi HDS721616PLA380, P22OABEA, max UDMA/133
[    9.310197] ata3.00: 312579695 sectors, multi 16: LBA48 NCQ (depth 31/32)
[    9.311246] ata3.00: configured for UDMA/100
[    9.311422] scsi 2:0:0:0: Direct-Access     ATA      Hitachi HDS72161 ABEA PQ: 0 ANSI: 5
[    9.341303] sd 2:0:0:0: [sdf] 312579695 512-byte logical blocks: (160 GB/149 GiB)
[    9.341403] sd 2:0:0:0: [sdf] Write Protect is off
[    9.341416] sd 2:0:0:0: [sdf] Mode Sense: 00 3a 00 00
[    9.341446] sd 2:0:0:0: [sdf] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    9.369882] sd 2:0:0:0: [sdf] Attached SCSI disk
[   11.393137] ata4: SATA link down (SStatus 0 SControl 0)
[   11.393334] scsi 4:0:0:0: Direct-Access     ATA      WDC WD10EARS-00M AB51 PQ: 0 ANSI: 5
[   11.425292] sd 4:0:0:0: [sdg] 1953525168 512-byte logical blocks: (1.00 TB/932 GiB)
[   11.425307] sd 4:0:0:0: [sdg] 4096-byte physical blocks
[   11.425410] sd 4:0:0:0: [sdg] Write Protect is off
[   11.425422] sd 4:0:0:0: [sdg] Mode Sense: 00 3a 00 00
[   11.425438] scsi 5:0:0:0: Direct-Access     ATA      Hitachi HDS5C302 A580 PQ: 0 ANSI: 5
[   11.425449] sd 4:0:0:0: [sdg] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   11.442088]  sdg: sdg1 sdg2 sdg3
[   11.442481] sd 4:0:0:0: [sdg] Attached SCSI disk
[   11.457273] sd 5:0:0:0: [sdh] 3907020911 512-byte logical blocks: (2.00 TB/1.82 TiB)
[   11.457368] sd 5:0:0:0: [sdh] Write Protect is off
[   11.457380] sd 5:0:0:0: [sdh] Mode Sense: 00 3a 00 00
[   11.457399] scsi 6:0:0:0: Direct-Access     ATA      OCZ-VECTOR180    1.01 PQ: 0 ANSI: 5
[   11.457409] sd 5:0:0:0: [sdh] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   11.489283] sd 6:0:0:0: [sdi] 234441648 512-byte logical blocks: (120 GB/112 GiB)
[   11.489407] sd 6:0:0:0: [sdi] Write Protect is off
[   11.489419] sd 6:0:0:0: [sdi] Mode Sense: 00 3a 00 00
[   11.489444] sd 6:0:0:0: [sdi] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   11.489892] scsi 8:0:0:0: CD-ROM            ASUS     DRW-1814BL       1.14 PQ: 0 ANSI: 5
[   11.490207]  sdi: sdi1 sdi2
[   11.490561] sd 6:0:0:0: [sdi] Attached SCSI disk
[   11.498525]  sdh: sdh1 sdh2 sdh3 sdh4
[   11.498932] sd 5:0:0:0: [sdh] Attached SCSI disk
[   11.519205] sr 8:0:0:0: [sr0] scsi3-mmc drive: 48x/48x writer dvd-ram cd/rw xa/form2 cdda tray
[   11.519226] cdrom: Uniform CD-ROM driver Revision: 3.20
[   11.519942] sr 8:0:0:0: Attached scsi CD-ROM sr0
[   11.524854] md: bind<sdi2>
[   11.568599] device-mapper: uevent: version 1.0.3
[   11.569257] device-mapper: ioctl: 4.35.0-ioctl (2016-06-23) initialised: dm-devel@redhat.com
[   11.570959] bcache: bch_journal_replay() journal replay done, 222 keys in 18 entries, seq 277165
[   11.572529] bcache: register_cache() registered cache device sdi1
[   11.665956] md: bind<sdg2>
[   11.667876] md: raid1 personality registered for level 1
[   11.668677] md/raid1:md127: active with 2 out of 2 mirrors
[   11.669393] created bitmap (1 pages) for device md127
[   11.670063] md127: bitmap initialized from disk: read 1 pages, set 0 of 1724 bits
[   11.736285] md127: detected capacity change from 0 to 115670974464
[   11.737148]  md127: p1 p2 p3
[   11.757297] bcache: register_bdev() registered backing device sdg1
[   11.799462] bcache: bch_cached_dev_attach() Caching sdg1 as bcache0 on set 83bdeae1-6390-4435-ae29-c31616227bc7
[   11.977678] random: crng init done
[   12.452269] md: linear personality registered for level -1
[   12.454108] md: multipath personality registered for level -4
[   12.456055] md: raid0 personality registered for level 0
[   12.569125] raid6: sse2x1   gen()  3834 MB/s
[   12.637114] raid6: sse2x1   xor()  4277 MB/s
[   12.705118] raid6: sse2x2   gen()  6483 MB/s
[   12.773113] raid6: sse2x2   xor()  7282 MB/s
[   12.841126] raid6: sse2x4   gen()  6869 MB/s
[   12.909114] raid6: sse2x4   xor()  4560 MB/s
[   12.909704] raid6: using algorithm sse2x4 gen() 6869 MB/s
[   12.910293] raid6: .... xor() 4560 MB/s, rmw enabled
[   12.910879] raid6: using intx1 recovery algorithm
[   12.911670] xor: measuring software checksum speed
[   12.949118]    prefetch64-sse: 12256.000 MB/sec
[   12.989118]    generic_sse: 11646.000 MB/sec
[   12.989702] xor: using function: prefetch64-sse (12256.000 MB/sec)
[   12.990524] async_tx: api initialized (async)
[   12.992379] md: raid6 personality registered for level 6
[   12.993048] md: raid5 personality registered for level 5
[   12.993642] md: raid4 personality registered for level 4
[   12.997315] md: raid10 personality registered for level 10
[   13.296939] Btrfs loaded, crc32c=crc32c-generic
[   13.381140] blk_update_request: I/O error, dev fd0, sector 0
[   13.381735] floppy: error -5 while reading block 0
[   13.969467] BTRFS: device label home devid 1 transid 3289 /dev/md127p3
[   13.970161] BTRFS: device label srv devid 2 transid 174 /dev/sdh3
[   13.970845] BTRFS: device label srv devid 1 transid 174 /dev/sdg3
[   13.973330] PM: Starting manual resume from disk
[   13.973900] PM: Hibernation image partition 8:113 present
[   13.973901] PM: Looking for hibernation image.
[   13.974044] PM: Image not found (code -22)
[   13.974045] PM: Hibernation image not present or could not be loaded.
[   14.106664] EXT4-fs (md127p2): mounted filesystem with ordered data mode. Opts: (null)
[   14.218213] ip_tables: (C) 2000-2006 Netfilter Core Team
[   14.222074] systemd[1]: systemd 232 running in system mode. (+PAM +AUDIT +SELINUX +IMA +APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD +IDN)
[   14.222750] systemd[1]: Detected architecture x86-64.
[   14.225414] systemd[1]: Set hostname to <c21>.
[   14.286478] systemd[1]: Listening on Journal Socket.
[   14.287772] systemd[1]: Listening on udev Control Socket.
[   14.289009] systemd[1]: Listening on Journal Audit Socket.
[   14.290299] systemd[1]: Set up automount Arbitrary Executable File Formats File System Automount Point.
[   14.291525] systemd[1]: Listening on Journal Socket (/dev/log).
[   14.292753] systemd[1]: Started Dispatch Password Requests to Console Directory Watch.
[   14.294089] systemd[1]: Created slice System Slice.
[   14.306823] it87: Found IT8716F chip at 0x228, revision 0
[   14.306844] it87: Beeping is supported
[   14.316148] EXT4-fs (md127p2): re-mounted. Opts: errors=remount-ro
[   14.402136] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input4
[   14.402714] ACPI: Power Button [PWRB]
[   14.403335] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input5
[   14.403916] ACPI: Power Button [PWRF]
[   14.408675] parport0: PC-style at 0x378 (0x778), irq 7 [PCSPP,TRISTATE,EPP]
[   14.410139] acpi_cpufreq: overriding BIOS provided _PSD data
[   14.416712] sd 10:0:0:0: Attached scsi generic sg0 type 0
[   14.417708] sd 10:0:0:1: Attached scsi generic sg1 type 0
[   14.418316] sd 11:0:0:0: Attached scsi generic sg2 type 0
[   14.418928] sd 11:0:0:1: Attached scsi generic sg3 type 0
[   14.419589] sd 1:0:0:0: Attached scsi generic sg4 type 0
[   14.420408] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[   14.421028] sd 2:0:0:0: Attached scsi generic sg5 type 0
[   14.422592] sd 4:0:0:0: Attached scsi generic sg6 type 0
[   14.423740] sd 5:0:0:0: Attached scsi generic sg7 type 0
[   14.424411] sp5100_tco: SP5100/SB800 TCO WatchDog Timer Driver v0.05
[   14.424697] sd 6:0:0:0: Attached scsi generic sg8 type 0
[   14.424748] sr 8:0:0:0: Attached scsi generic sg9 type 5
[   14.426300] sp5100_tco: PCI Vendor ID: 0x1002, Device ID: 0x4385, Revision ID: 0x14
[   14.426871] sp5100_tco: failed to find MMIO address, giving up.
[   14.459472] snd_hda_intel 0000:00:14.2: position_fix set to 1 for device 1458:a022
[   14.460455] snd_hda_intel: probe of 0000:01:00.1 failed with error -2
[   14.485265] snd_hda_codec_realtek hdaudioC0D3: autoconfig for ALC889A: line_outs=4 (0x14/0x15/0x16/0x17/0x0) type:line
[   14.485838] snd_hda_codec_realtek hdaudioC0D3:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
[   14.486396] snd_hda_codec_realtek hdaudioC0D3:    hp_outs=1 (0x1b/0x0/0x0/0x0/0x0)
[   14.486922] snd_hda_codec_realtek hdaudioC0D3:    mono: mono_out=0x0
[   14.487439] snd_hda_codec_realtek hdaudioC0D3:    dig-out=0x1e/0x0
[   14.487941] snd_hda_codec_realtek hdaudioC0D3:    inputs:
[   14.488439] snd_hda_codec_realtek hdaudioC0D3:      Rear Mic=0x18
[   14.488949] snd_hda_codec_realtek hdaudioC0D3:      Front Mic=0x19
[   14.489466] snd_hda_codec_realtek hdaudioC0D3:      Line=0x1a
[   14.489991] snd_hda_codec_realtek hdaudioC0D3:      CD=0x1c
[   14.490177] snd_ice1712 0000:06:07.0: Using board model TerraTec DMX6Fire
[   14.490985] snd_hda_codec_realtek hdaudioC0D3:    dig-in=0x1f
[   14.507492] Bluetooth: Core ver 2.22
[   14.508013] NET: Registered protocol family 31
[   14.508493] Bluetooth: HCI device and connection manager initialized
[   14.508968] Bluetooth: HCI socket layer initialized
[   14.511338] Bluetooth: L2CAP socket layer initialized
[   14.512165] Bluetooth: SCO socket layer initialized
[   14.517683] input: PC Speaker as /devices/platform/pcspkr/input/input6
[   14.521043] usbcore: registered new interface driver btusb
[   14.530275] Bluetooth: hci0: BCM: chip id 63
[   14.531835] input: HDA ATI SB Rear Mic as /devices/pci0000:00/0000:00:14.2/sound/card0/input7
[   14.533937] input: HDA ATI SB Front Mic as /devices/pci0000:00/0000:00:14.2/sound/card0/input8
[   14.534503] input: HDA ATI SB Line as /devices/pci0000:00/0000:00:14.2/sound/card0/input9
[   14.535073] input: HDA ATI SB Line Out Front as /devices/pci0000:00/0000:00:14.2/sound/card0/input10
[   14.535638] input: HDA ATI SB Line Out Surround as /devices/pci0000:00/0000:00:14.2/sound/card0/input11
[   14.536246] input: HDA ATI SB Line Out CLFE as /devices/pci0000:00/0000:00:14.2/sound/card0/input12
[   14.536800] input: HDA ATI SB Line Out Side as /devices/pci0000:00/0000:00:14.2/sound/card0/input13
[   14.538790] bcache: register_bcache() error opening /dev/sdg1: device already registered
[   14.549307] Bluetooth: hci0: c21
[   14.551373] Bluetooth: hci0: BCM20702A1 (001.002.014) build 1338
[   14.552780] bluetooth hci0: firmware: direct-loading firmware brcm/BCM20702A1-0a5c-21e8.hcd
[   14.554066] kvm: Nested Virtualization enabled
[   14.554590] kvm: Nested Paging enabled
[   14.557603] EDAC MC: Ver: 3.0.0
[   14.558989] bcache: register_bcache() error opening /dev/sdi1: device already registered
[   14.560914] MCE: In-kernel MCE decoding enabled.
[   14.562535] EDAC amd64: DRAM ECC disabled.
[   14.563040] EDAC amd64: ECC disabled in the BIOS or no ECC capability, module will not load.
                Either enable ECC checking or force module loading by setting 'ecc_enable_override'.
                (Note that use of the override may cause unknown side effects.)
[   14.602687] ppdev: user-space parallel port driver
[   14.603346] EDAC amd64: DRAM ECC disabled.
[   14.603997] EDAC amd64: ECC disabled in the BIOS or no ECC capability, module will not load.
                Either enable ECC checking or force module loading by setting 'ecc_enable_override'.
                (Note that use of the override may cause unknown side effects.)
[   15.188907] Adding 16777212k swap on /dev/sdh1.  Priority:-1 extents:1 across:16777212k FS
[   15.347208] Bluetooth: hci0: BCM20702A1 (001.002.014) build 1338
[   15.366194] Bluetooth: hci0: Broadcom Bluetooth Device
[   15.389882] BTRFS info (device md127p3): use ssd allocation scheme
[   15.390704] BTRFS info (device md127p3): use lzo compression
[   15.390706] BTRFS info (device md127p3): disk space caching is enabled
[   15.390707] BTRFS info (device md127p3): has skinny extents
[   15.431388] EXT4-fs (bcache0): mounted filesystem with ordered data mode. Opts: (null)
[   15.455247] systemd-journald[423]: Received request to flush runtime journal from PID 1
[   15.456994] EXT4-fs (md127p1): mounted filesystem with ordered data mode. Opts: (null)
[   15.549810] BTRFS info (device sdg3): disk space caching is enabled
[   15.551856] BTRFS info (device sdg3): has skinny extents
[   15.673919] EXT4-fs (sdh2): mounted filesystem without journal. Opts: (null)
[   15.715252] SGI XFS with ACLs, security attributes, realtime, no debug enabled
[   15.756160] XFS (sdh4): Mounting V5 Filesystem
[   15.887668] XFS (sdh4): Ending clean mount
[   15.933906] r8169 0000:06:0f.0 enp6s15: link down
[   15.935936] r8169 0000:06:0f.0 enp6s15: link down
[   15.938010] IPv6: ADDRCONF(NETDEV_UP): enp6s15: link is not ready
[   16.135146] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[   16.135148] Bluetooth: BNEP filters: protocol multicast
[   16.135156] Bluetooth: BNEP socket layer initialized
[   19.335519] r8169 0000:06:0f.0 enp6s15: link up
[   19.337439] IPv6: ADDRCONF(NETDEV_CHANGE): enp6s15: link becomes ready
[  266.470363] ata2.00: exception Emask 0x20 SAct 0x3 SErr 0x0 action 0x6 frozen
[  266.472190] ata2.00: irq_stat 0x00020002, PCI master abort while transferring data
[  266.474022] ata2.00: failed command: READ FPDMA QUEUED
[  266.475827] ata2.00: cmd 60/00:00:f0:bb:0e/01:00:00:00:00/40 tag 0 ncq dma 131072 in
                        res 60/00:00:f0:bb:0e/00:00:00:00:00/40 Emask 0x21 (host bus error)
[  266.479401] ata2.00: status: { DRDY DF }
[  266.481180] ata2.00: failed command: READ FPDMA QUEUED
[  266.482964] ata2.00: cmd 60/00:08:f0:ba:0e/01:00:00:00:00/40 tag 1 ncq dma 131072 in
                        res 40/25:02:02:00:00/00:00:40:10:40/00 Emask 0x20 (host bus error)
[  266.486912] ata2.00: status: { DRDY }
[  266.488711] ata2.00: error: { AMNF ABRT }
[  266.490524] ata2: hard resetting link
[  266.492295] ata2: controller in dubious state, performing PORT_RST
[  268.693624] ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
[  268.697455] ata2.00: configured for UDMA/100
[  268.699297] ata2: EH complete
[  268.834440] ata2.00: exception Emask 0x20 SAct 0x3 SErr 0x0 action 0x6 frozen
[  268.836245] ata2.00: irq_stat 0x00020002, PCI master abort while transferring data
[  268.838063] ata2.00: failed command: READ FPDMA QUEUED
[  268.839843] ata2.00: cmd 60/00:00:f0:ba:0e/01:00:00:00:00/40 tag 0 ncq dma 131072 in
                        res 40/25:02:02:00:00/00:00:40:00:40/00 Emask 0x20 (host bus error)
[  268.843421] ata2.00: status: { DRDY }
[  268.845213] ata2.00: error: { AMNF ABRT }
[  268.847013] ata2.00: failed command: READ FPDMA QUEUED
[  268.848794] ata2.00: cmd 60/00:08:f0:bb:0e/01:00:00:00:00/40 tag 1 ncq dma 131072 in
                        res 40/25:02:02:00:00/00:00:00:10:40/00 Emask 0x20 (host bus error)
[  268.852416] ata2.00: status: { DRDY }
[  268.854236] ata2.00: error: { AMNF ABRT }
[  268.856027] ata2: hard resetting link
[  268.857801] ata2: controller in dubious state, performing PORT_RST
[  271.057626] ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
[  271.061485] ata2.00: configured for UDMA/100
[  271.063319] ata2: EH complete
[  271.202443] ata2.00: exception Emask 0x20 SAct 0x3 SErr 0x0 action 0x6 frozen
[  271.204249] ata2.00: irq_stat 0x00020002, PCI master abort while transferring data
[  271.206073] ata2.00: failed command: READ FPDMA QUEUED
[  271.207870] ata2.00: cmd 60/00:00:f0:bb:0e/01:00:00:00:00/40 tag 0 ncq dma 131072 in
                        res 40/25:02:02:00:00/00:00:00:00:40/00 Emask 0x20 (host bus error)
[  271.211530] ata2.00: status: { DRDY }
[  271.213363] ata2.00: error: { AMNF ABRT }
[  271.215189] ata2.00: failed command: READ FPDMA QUEUED
[  271.217016] ata2.00: cmd 60/00:08:f0:ba:0e/01:00:00:00:00/40 tag 1 ncq dma 131072 in
                        res 40/25:02:02:00:00/00:00:00:10:40/00 Emask 0x20 (host bus error)
[  271.220715] ata2.00: status: { DRDY }
[  271.222581] ata2.00: error: { AMNF ABRT }
[  271.224427] ata2: hard resetting link
[  271.226281] ata2: controller in dubious state, performing PORT_RST
[  273.425629] ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
[  273.429528] ata2.00: configured for UDMA/100
[  273.431416] ata2: EH complete
[  273.566425] ata2.00: exception Emask 0x20 SAct 0x3 SErr 0x0 action 0x6 frozen
[  273.568314] ata2.00: irq_stat 0x00020002, PCI master abort while transferring data
[  273.570224] ata2.00: failed command: READ FPDMA QUEUED
[  273.572099] ata2.00: cmd 60/00:00:f0:ba:0e/01:00:00:00:00/40 tag 0 ncq dma 131072 in
                        res 40/25:02:02:00:00/00:00:40:00:40/00 Emask 0x20 (host bus error)
[  273.575879] ata2.00: status: { DRDY }
[  273.577806] ata2.00: error: { AMNF ABRT }
[  273.580071] ata2.00: failed command: READ FPDMA QUEUED
[  273.581984] ata2.00: cmd 60/00:08:f0:bb:0e/01:00:00:00:00/40 tag 1 ncq dma 131072 in
                        res 40/25:02:02:00:00/00:00:00:10:40/00 Emask 0x20 (host bus error)
[  273.585815] ata2.00: status: { DRDY }
[  273.587706] ata2.00: error: { AMNF ABRT }
[  273.589596] ata2: hard resetting link
[  273.591468] ata2: controller in dubious state, performing PORT_RST
[  275.793629] ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
[  275.797567] ata2.00: configured for UDMA/100
[  275.799496] ata2: EH complete
[  275.934436] ata2.00: exception Emask 0x20 SAct 0x3 SErr 0x0 action 0x6 frozen
[  275.936386] ata2.00: irq_stat 0x00020002, PCI master abort while transferring data
[  275.938361] ata2.00: failed command: READ FPDMA QUEUED
[  275.940330] ata2.00: cmd 60/00:00:f0:bb:0e/01:00:00:00:00/40 tag 0 ncq dma 131072 in
                        res 40/25:02:02:00:00/00:00:00:00:40/00 Emask 0x20 (host bus error)
[  275.944329] ata2.00: status: { DRDY }
[  275.946355] ata2.00: error: { AMNF ABRT }
[  275.948346] ata2.00: failed command: READ FPDMA QUEUED
[  275.950347] ata2.00: cmd 60/00:08:f0:ba:0e/01:00:00:00:00/40 tag 1 ncq dma 131072 in
                        res 40/25:02:02:00:00/00:00:00:10:40/00 Emask 0x20 (host bus error)
[  275.954345] ata2.00: status: { DRDY }
[  275.956330] ata2.00: error: { AMNF ABRT }
[  275.958324] ata2: hard resetting link
[  275.960284] ata2: controller in dubious state, performing PORT_RST
[  278.161633] ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
[  278.165627] ata2.00: configured for UDMA/100
[  278.167609] ata2: EH complete
[  278.310432] ata2.00: exception Emask 0x20 SAct 0x3 SErr 0x0 action 0x6 frozen
[  278.312407] ata2.00: irq_stat 0x00020002, PCI master abort while transferring data
[  278.314397] ata2.00: failed command: READ FPDMA QUEUED
[  278.316365] ata2.00: cmd 60/00:00:f0:ba:0e/01:00:00:00:00/40 tag 0 ncq dma 131072 in
                        res 40/25:02:02:00:00/00:00:40:00:40/00 Emask 0x20 (host bus error)
[  278.320315] ata2.00: status: { DRDY }
[  278.322304] ata2.00: error: { AMNF ABRT }
[  278.324279] ata2.00: failed command: READ FPDMA QUEUED
[  278.326268] ata2.00: cmd 60/00:08:f0:bb:0e/01:00:00:00:00/40 tag 1 ncq dma 131072 in
                        res 40/25:02:02:00:00/00:00:00:10:40/00 Emask 0x20 (host bus error)
[  278.330242] ata2.00: status: { DRDY }
[  278.332212] ata2.00: error: { AMNF ABRT }
[  278.334178] ata2: hard resetting link
[  278.336128] ata2: controller in dubious state, performing PORT_RST
[  280.537636] ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
[  280.541646] ata2.00: configured for UDMA/100
[  280.543627] sd 1:0:0:0: [sde] tag#0 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE
[  280.545611] sd 1:0:0:0: [sde] tag#0 Sense Key : Medium Error [current] 
[  280.547567] sd 1:0:0:0: [sde] tag#0 Add. Sense: Address mark not found for data field
[  280.549548] sd 1:0:0:0: [sde] tag#0 CDB: Read(10) 28 00 00 0e ba f0 00 01 00 00
[  280.551517] blk_update_request: I/O error, dev sde, sector 965360
[  280.553542] sd 1:0:0:0: [sde] tag#1 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE
[  280.555901] sd 1:0:0:0: [sde] tag#1 Sense Key : Medium Error [current] 
[  280.557924] sd 1:0:0:0: [sde] tag#1 Add. Sense: Address mark not found for data field
[  280.559928] sd 1:0:0:0: [sde] tag#1 CDB: Read(10) 28 00 00 0e bb f0 00 01 00 00
[  280.561940] blk_update_request: I/O error, dev sde, sector 965616
[  280.563961] ata2: EH complete

--nextPart1825563.CaAURjkrJz
Content-Disposition: attachment; filename="dmesg_tmpHD"
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"; name="dmesg_tmpHD"

[ 8348.620026] ata1: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0xe frozen
[ 8348.621645] ata1: irq_stat 0x00b40090, PHY RDY changed
[ 8348.623295] ata1: hard resetting link
[ 8358.626310] ata1: softreset failed (timeout)
[ 8358.627924] ata1: hard resetting link
[ 8361.391599] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
[ 8361.393811] ata1.00: ATA-8: ST3000DM001-9YN166, CC4H, max UDMA/133
[ 8361.395466] ata1.00: 5860533168 sectors, multi 0: LBA48 
[ 8361.397671] ata1.00: configured for UDMA/100
[ 8361.398342] ata1: EH complete
[ 8361.399205] scsi 0:0:0:0: Direct-Access     ATA      ST3000DM001-9YN1 CC4H PQ: 0 ANSI: 5
[ 8361.438676] sd 0:0:0:0: Attached scsi generic sg10 type 0
[ 8361.438689] sd 0:0:0:0: [sdj] 5860533168 512-byte logical blocks: (3.00 TB/2.73 TiB)
[ 8361.438694] sd 0:0:0:0: [sdj] 4096-byte physical blocks
[ 8361.438888] sd 0:0:0:0: [sdj] Write Protect is off
[ 8361.438896] sd 0:0:0:0: [sdj] Mode Sense: 00 3a 00 00
[ 8361.438971] sd 0:0:0:0: [sdj] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 8361.487871]  sdj: sdj1 sdj2
[ 8361.489045] sd 0:0:0:0: [sdj] Attached SCSI disk
[10562.688262] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
[10562.689701] ata1.00: irq_stat 0x00060002, PCI master abort while transferring data
[10562.691127] ata1.00: failed command: READ DMA
[10562.692609] ata1.00: cmd c8/00:00:e0:d3:d3/00:00:00:00:00/e0 tag 0 dma 131072 in
                        res b8/20:02:02:00:00/00:00:00:00:b8/00 Emask 0x22 (host bus error)
[10562.695565] ata1.00: status: { Busy }
[10562.697060] ata1: hard resetting link
[10562.698547] ata1: controller in dubious state, performing PORT_RST
[10564.889203] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
[10564.891970] ata1.00: configured for UDMA/100
[10564.893545] ata1: EH complete
[10565.028037] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
[10565.029608] ata1.00: irq_stat 0x00020002, PCI master abort while transferring data
[10565.031207] ata1.00: failed command: READ DMA
[10565.032784] ata1.00: cmd c8/00:00:e0:d3:d3/00:00:00:00:00/e0 tag 0 dma 131072 in
                        res b8/20:02:02:00:00/00:00:00:00:b8/00 Emask 0x22 (host bus error)
[10565.035952] ata1.00: status: { Busy }
[10565.037543] ata1: hard resetting link
[10565.039140] ata1: controller in dubious state, performing PORT_RST
[10567.228972] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
[10567.231793] ata1.00: configured for UDMA/100
[10567.233456] ata1: EH complete
[10567.368096] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
[10567.369692] ata1.00: irq_stat 0x00020002, PCI master abort while transferring data
[10567.371315] ata1.00: failed command: READ DMA
[10567.372995] ata1.00: cmd c8/00:00:e0:d3:d3/00:00:00:00:00/e0 tag 0 dma 131072 in
                        res b8/20:02:02:00:00/00:00:00:00:b8/00 Emask 0x22 (host bus error)
[10567.376224] ata1.00: status: { Busy }
[10567.377851] ata1: hard resetting link
[10567.379492] ata1: controller in dubious state, performing PORT_RST
[10569.568810] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
[10569.571690] ata1.00: configured for UDMA/100
[10569.573371] ata1: EH complete
[10569.707698] ata1: limiting SATA link speed to 1.5 Gbps
[10569.709374] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
[10569.711087] ata1.00: irq_stat 0x00020002, PCI master abort while transferring data
[10569.712777] ata1.00: failed command: READ DMA
[10569.714466] ata1.00: cmd c8/00:00:e0:d3:d3/00:00:00:00:00/e0 tag 0 dma 131072 in
                        res b8/20:02:02:00:00/00:00:00:00:b8/00 Emask 0x22 (host bus error)
[10569.717913] ata1.00: status: { Busy }
[10569.719683] ata1: hard resetting link
[10569.721770] ata1: controller in dubious state, performing PORT_RST
[10571.912619] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 10)
[10571.915665] ata1.00: configured for UDMA/100
[10571.917481] ata1: EH complete
[10572.051552] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
[10572.053372] ata1.00: irq_stat 0x00020002, PCI master abort while transferring data
[10572.055229] ata1.00: failed command: READ DMA
[10572.057046] ata1.00: cmd c8/00:00:e0:d3:d3/00:00:00:00:00/e0 tag 0 dma 131072 in
                        res b8/20:02:02:00:00/00:00:00:00:b8/00 Emask 0x22 (host bus error)
[10572.060734] ata1.00: status: { Busy }
[10572.062609] ata1: hard resetting link
[10572.064484] ata1: controller in dubious state, performing PORT_RST
[10574.257205] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 10)
[10574.260335] ata1.00: configured for UDMA/100
[10574.262294] ata1: EH complete
[10574.399322] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
[10574.401276] ata1.00: irq_stat 0x00020002, PCI master abort while transferring data
[10574.403257] ata1.00: failed command: READ DMA
[10574.405205] ata1.00: cmd c8/00:00:e0:d3:d3/00:00:00:00:00/e0 tag 0 dma 131072 in
                        res b8/20:02:02:00:00/00:00:00:00:b8/00 Emask 0x22 (host bus error)
[10574.409144] ata1.00: status: { Busy }
[10574.411542] ata1: hard resetting link
[10574.413555] ata1: controller in dubious state, performing PORT_RST
[10576.604232] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 10)
[10576.607520] ata1.00: configured for UDMA/100
[10576.609563] sd 0:0:0:0: [sdj] tag#0 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE
[10576.611611] sd 0:0:0:0: [sdj] tag#0 Sense Key : Aborted Command [current] 
[10576.613654] sd 0:0:0:0: [sdj] tag#0 Add. Sense: Scsi parity error
[10576.616047] sd 0:0:0:0: [sdj] tag#0 CDB: Read(16) 88 00 00 00 00 00 00 d3 d3 e0 00 00 01 00 00 00
[10576.618148] blk_update_request: I/O error, dev sdj, sector 13882336
[10576.620285] ata1: EH complete
[10576.759123] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
[10576.761194] ata1.00: irq_stat 0x00020002, PCI master abort while transferring data
[10576.763277] ata1.00: failed command: READ DMA
[10576.765334] ata1.00: cmd c8/00:00:e0:d4:d3/00:00:00:00:00/e0 tag 0 dma 131072 in
                        res b8/20:02:02:00:00/00:00:00:00:b8/00 Emask 0x22 (host bus error)
[10576.769458] ata1.00: status: { Busy }
[10576.771537] ata1: hard resetting link
[10576.773567] ata1: controller in dubious state, performing PORT_RST
[10578.964029] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 10)
[10578.967309] ata1.00: configured for UDMA/100
[10578.969352] ata1: EH complete
[10579.102837] ata1.00: limiting speed to UDMA/66:PIO4
[10579.104858] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
[10579.106911] ata1.00: irq_stat 0x00020002, PCI master abort while transferring data
[10579.108930] ata1.00: failed command: READ DMA
[10579.110962] ata1.00: cmd c8/00:00:e0:d4:d3/00:00:00:00:00/e0 tag 0 dma 131072 in
                        res b8/20:02:02:00:00/00:00:00:00:b8/00 Emask 0x22 (host bus error)
[10579.115015] ata1.00: status: { Busy }
[10579.117024] ata1: hard resetting link
[10579.119025] ata1: controller in dubious state, performing PORT_RST
[10581.307818] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 10)
[10581.311119] ata1.00: configured for UDMA/66
[10581.313168] ata1: EH complete
[10581.450700] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
[10581.452739] ata1.00: irq_stat 0x00020002, PCI master abort while transferring data
[10581.454797] ata1.00: failed command: READ DMA
[10581.456811] ata1.00: cmd c8/00:00:e0:d4:d3/00:00:00:00:00/e0 tag 0 dma 131072 in
                        res b8/20:02:02:00:00/00:00:00:00:b8/00 Emask 0x22 (host bus error)
[10581.460858] ata1.00: status: { Busy }
[10581.462922] ata1: hard resetting link
[10581.464926] ata1: controller in dubious state, performing PORT_RST
[10583.655637] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 10)
[10583.658911] ata1.00: configured for UDMA/66
[10583.660997] ata1: EH complete
[10583.794492] ata1.00: limiting speed to UDMA/33:PIO4
[10583.796511] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
[10583.798564] ata1.00: irq_stat 0x00020002, PCI master abort while transferring data
[10583.800583] ata1.00: failed command: READ DMA
[10583.802618] ata1.00: cmd c8/00:00:e0:d4:d3/00:00:00:00:00/e0 tag 0 dma 131072 in
                        res b8/20:02:02:00:00/00:00:00:00:b8/00 Emask 0x22 (host bus error)
[10583.806679] ata1.00: status: { Busy }
[10583.809058] ata1: hard resetting link
[10583.811090] ata1: controller in dubious state, performing PORT_RST
[10585.999405] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 10)
[10586.002714] ata1.00: configured for UDMA/33
[10586.004761] ata1: EH complete
[10586.142263] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
[10586.144308] ata1.00: irq_stat 0x00020002, PCI master abort while transferring data
[10586.146368] ata1.00: failed command: READ DMA
[10586.148404] ata1.00: cmd c8/00:00:e0:d4:d3/00:00:00:00:00/e0 tag 0 dma 131072 in
                        res b8/20:02:02:00:00/00:00:00:00:b8/00 Emask 0x22 (host bus error)
[10586.152495] ata1.00: status: { Busy }
[10586.154561] ata1: hard resetting link
[10586.156566] ata1: controller in dubious state, performing PORT_RST
[10588.347248] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 10)
[10588.350519] ata1.00: configured for UDMA/33
[10588.352550] ata1: EH complete
[10588.494107] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
[10588.496144] ata1.00: irq_stat 0x00020002, PCI master abort while transferring data
[10588.498202] ata1.00: failed command: READ DMA
[10588.500218] ata1.00: cmd c8/00:00:e0:d4:d3/00:00:00:00:00/e0 tag 0 dma 131072 in
                        res b8/20:02:02:00:00/00:00:00:00:b8/00 Emask 0x22 (host bus error)
[10588.504272] ata1.00: status: { Busy }
[10588.506335] ata1: hard resetting link
[10588.508342] ata1: controller in dubious state, performing PORT_RST
[10590.699055] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 10)
[10590.702324] ata1.00: configured for UDMA/33
[10590.704363] sd 0:0:0:0: [sdj] tag#0 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE
[10590.706425] sd 0:0:0:0: [sdj] tag#0 Sense Key : Aborted Command [current] 
[10590.708464] sd 0:0:0:0: [sdj] tag#0 Add. Sense: Scsi parity error
[10590.710512] sd 0:0:0:0: [sdj] tag#0 CDB: Read(16) 88 00 00 00 00 00 00 d3 d4 e0 00 00 01 00 00 00
[10590.712560] blk_update_request: I/O error, dev sdj, sector 13882592
[10590.714663] ata1: EH complete

--nextPart1825563.CaAURjkrJz
Content-Disposition: attachment; filename="sata_sil24.c.diff"
Content-Transfer-Encoding: 7Bit
Content-Type: text/x-patch; charset="UTF-8"; name="sata_sil24.c.diff"

--- drivers/ata/sata_sil24.c.orig	2017-01-09 08:32:38.000000000 +0100
+++ drivers/ata/sata_sil24.c	2017-01-13 23:44:58.378675018 +0100
@@ -1313,15 +1313,4 @@
 
 	/* configure and activate the device */
-	if (!dma_set_mask(&pdev->dev, DMA_BIT_MASK(64))) {
-		rc = dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(64));
-		if (rc) {
-			rc = dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(32));
-			if (rc) {
-				dev_err(&pdev->dev,
-					"64-bit DMA enable failed\n");
-				return rc;
-			}
-		}
-	} else {
 		rc = dma_set_mask(&pdev->dev, DMA_BIT_MASK(32));
 		if (rc) {
@@ -1335,5 +1324,4 @@
 			return rc;
 		}
-	}
 
 	/* Set max read request size to 4096.  This slightly increases

--nextPart1825563.CaAURjkrJz--

