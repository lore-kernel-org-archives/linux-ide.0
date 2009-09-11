From: "Christoph .J Thompson" <cjsthompson@gmail.com>
Subject: Can't burn CDs/DVDs
Date: Fri, 11 Sep 2009 19:30:17 +0200
Message-ID: <20090911193017.d47e167e.cjsthompson@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ew0-f206.google.com ([209.85.219.206]:42310 "EHLO
	mail-ew0-f206.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752835AbZIKR3h convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 11 Sep 2009 13:29:37 -0400
Received: by ewy2 with SMTP id 2so1292704ewy.17
        for <linux-ide@vger.kernel.org>; Fri, 11 Sep 2009 10:29:38 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

This is an issue I've had for a while, but since I rarely burn CDs or D=
VDs I forget about it. But still I'd like to be able not to have to reb=
oot to Windows XP to burn that occasional CD/DVD. So as you can gather =
both drives work with Nero/Windows XP so *something* is fishy with Linu=
x. It used to work on Linux up until some point which I don't really re=
member.

I did not switch to libata/pata_via because it's still marked as experi=
mental (should I?). I don't have any SATA drives.

This message seems to be interresting:

cdrecord: Warning: The DMA speed test has been skipped.

As on my system cdparanoia barfs if I don't disable DMA on the drive I'=
m trying to rip from.

Any help to fix this would be really welcome.

---

# cdrecord -vvv dev=3D/dev/hdc haiku-alpha.iso=20
cdrecord: No write mode specified.
cdrecord: Asuming -sao mode.
cdrecord: If your drive does not accept -sao, try -tao.
cdrecord: Future versions of cdrecord may have different drive dependen=
t defaults.
Cdrecord-ProDVD-ProBD-Clone 2.01.01a57 (i686-pc-linux-gnu) Copyright (C=
) 1995-2009 J=F6rg Schilling
TOC Type: 1 =3D CD-ROM
scsidev: '/dev/hdc'
devname: '/dev/hdc'
scsibus: -2 target: -2 lun: -2
Warning: Open by 'devname' is unintentional and not supported.
Linux sg driver version: 3.5.27
Using libscg version 'schily-0.9'.
Using libscg transport code version 'schily-scsi-linux-sg.c-1.92'
SCSI buffer size: 64512
atapi: 1
Device type    : Removable CD-ROM
Version        : 0
Response Format: 2
Capabilities   :=20
Vendor_info    : 'PHILIPS '
Identifikation : 'PCRW5232P       '
Revision       : 'P2.2'
Device seems to be: Generic mmc CD-RW.
Current: none
Profile: CD-RW=20
Profile: CD-R=20
Profile: CD-ROM=20
=46eature: 'Profile List' (current) (persistent)
=46eature: 'Core' (current) (persistent)
=46eature: 'Morphing' (current) (persistent)
=46eature: 'Removable Medium' (current) (persistent)
=46eature: 'Random Readable' =20
=46eature: 'Multi Read' (current) (persistent)
=46eature: 'CD Read' =20
=46eature: 'Random Writable' =20
=46eature: 'Incremental Streaming Writable' =20
=46eature: 'Formattable' =20
=46eature: 'Restricted Overwrite' =20
=46eature: 'CD Track at Once' =20
=46eature: 'CD Mastering' =20
=46eature: 'Power Management' (current) (persistent)
=46eature: 'S.M.A.R.T.' =20
=46eature: 'CD Audio analog play' (current)=20
=46eature: 'Time-out' (current) (persistent)
Drive current speed: 48
Drive default speed: 52
Drive max speed    : 52
Selected speed     : 52
Using generic SCSI-3/mmc   CD-R/CD-RW driver (mmc_cdr).
Driver flags   : MMC-3 SWABAUDIO BURNFREE FORCESPEED=20
Supported modes: TAO PACKET SAO SAO/R96P SAO/R96R RAW/R16 RAW/R96P RAW/=
R96R
cdrecord: Warning: The DMA speed test has been skipped.
=46IFO size      : 4194304 =3D 4096 KB
Track 01: data   379 MB       =20
track: 1 start: 0 pregap: 150
Total size:      436 MB (43:13.44) =3D 194508 sectors
Lout start:      436 MB (43:15/33) =3D 194508 sectors
 41 00 00 14 00 00 00 00
 41 01 00 10 00 00 00 00
 41 01 01 10 00 00 02 00
 41 AA 01 14 00 2B 0F 21
Track 1 start 0
Track 2 start 194508
 41 00 A0 00 00 00 00 01 00 00 00 00
 41 00 A1 00 00 00 00 01 00 00 00 00
 41 00 A2 00 00 00 00 43 15 33 00 00
 41 00 01 00 00 00 00 00 02 00 00 00
cdrecord: Success. test unit ready: scsi sendcmd: no error
CDB:  00 00 00 00 00 00
status: 0x2 (CHECK CONDITION)
Sense Bytes: 70 00 02 00 00 00 00 0A 00 00 00 00 3A 00 00 00
Sense Key: 0x2 Not Ready, Segment 0
Sense Code: 0x3A Qual 0x00 (medium not present) Fru 0x0
Sense flags: Blk 0 (not valid)=20
cmd finished after 0.001s timeout 200s
cdrecord: No disk / Wrong disk!

# uname -a
Linux wotan 2.6.31-wotan-10 #1 Thu Sep 10 21:03:09 CEST 2009 i686 AMD S=
empron(tm) 2400+ AuthenticAMD GNU/Linux

# lsscsi -vvv
 sysfsroot: /sys
[0:0:0:0]    disk    Maxtor   Basics Portable  0122  /dev/sda=20
  dir: /sys/bus/scsi/devices/0:0:0:0  [/sys/devices/pci0000:00/0000:00:=
10.4/usb1/1-3/1-3:1.0/host0/target0:0:0/0:0:0:0]

# lspci -vvv
00:00.0 Host bridge: VIA Technologies, Inc. VT8377 [KT400/KT600 AGP] Ho=
st Bridge (rev 80)
	Subsystem: ASRock Incorporation K7VT6 motherboard
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- St=
epping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TA=
bort- <MAbort+ >SERR- <PERR- INTx-
	Latency: 8
	Region 0: Memory at e0000000 (32-bit, prefetchable) [size=3D64M]
	Capabilities: [80] AGP version 3.5
		Status: RQ=3D32 Iso- ArqSz=3D0 Cal=3D2 SBA+ ITACoh- GART64- HTrans- 6=
4bit- FW- AGP3+ Rate=3Dx4,x8
		Command: RQ=3D1 ArqSz=3D0 Cal=3D0 SBA+ AGP+ GART64- 64bit- FW- Rate=3D=
x8
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D=
3cold-)
		Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
	Kernel driver in use: agpgart-via
	Kernel modules: via-agp

00:01.0 PCI bridge: VIA Technologies, Inc. VT8237/VX700 PCI Bridge (pro=
g-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- St=
epping- SERR+ FastB2B- DisINTx-
	Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TA=
bort- <MAbort+ >SERR- <PERR- INTx-
	Latency: 0
	Bus: primary=3D00, secondary=3D01, subordinate=3D01, sec-latency=3D0
	I/O behind bridge: 0000a000-0000afff
	Memory behind bridge: dfe00000-dfefffff
	Prefetchable memory behind bridge: bfd00000-dfcfffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbo=
rt- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D=
3cold-)
		Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-

00:0a.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8=
139C/8139C+ (rev 10)
	Subsystem: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- St=
epping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TA=
bort- <MAbort- >SERR- <PERR- INTx-
	Latency: 32 (8000ns min, 16000ns max)
	Interrupt: pin A routed to IRQ 18
	Region 0: I/O ports at d400 [size=3D256]
	Region 1: Memory at dfffbf00 (32-bit, non-prefetchable) [size=3D256]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA PME(D0-,D1+,D2+,D3hot+,D=
3cold-)
		Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
	Kernel driver in use: 8139too
	Kernel modules: 8139too

00:0f.0 RAID bus controller: VIA Technologies, Inc. VIA VT6420 SATA RAI=
D Controller (rev 80)
	Subsystem: ASRock Incorporation K7VT6 motherboard
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- St=
epping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TA=
bort- <MAbort- >SERR- <PERR- INTx-
	Latency: 32
	Interrupt: pin B routed to IRQ 10
	Region 0: I/O ports at ec00 [size=3D8]
	Region 1: I/O ports at e800 [size=3D4]
	Region 2: I/O ports at e400 [size=3D8]
	Region 3: I/O ports at e000 [size=3D4]
	Region 4: I/O ports at dc00 [size=3D16]
	Region 5: I/O ports at d800 [size=3D256]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D=
3cold-)
		Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
	Kernel modules: sata_via

00:0f.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/=
VT823x/A/C PIPC Bus Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
	Subsystem: ASRock Incorporation K7VT2/K7VT6 motherboard
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- St=
epping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TA=
bort- <MAbort- >SERR- <PERR- INTx-
	Latency: 32
	Interrupt: pin A routed to IRQ 20
	Region 0: [virtual] Memory at 000001f0 (32-bit, non-prefetchable) [siz=
e=3D8]
	Region 1: [virtual] Memory at 000003f0 (type 3, non-prefetchable) [siz=
e=3D1]
	Region 2: [virtual] Memory at 00000170 (32-bit, non-prefetchable) [siz=
e=3D8]
	Region 3: [virtual] Memory at 00000370 (type 3, non-prefetchable) [siz=
e=3D1]
	Region 4: I/O ports at fc00 [size=3D16]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D=
3cold-)
		Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
	Kernel driver in use: VIA_IDE
	Kernel modules: pata_via

00:10.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 C=
ontroller (rev 81) (prog-if 00 [UHCI])
	Subsystem: ASRock Incorporation K7VT6
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- St=
epping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TA=
bort- <MAbort- >SERR- <PERR- INTx-
	Latency: 32, Cache Line Size: 32 bytes
	Interrupt: pin A routed to IRQ 21
	Region 4: I/O ports at c400 [size=3D32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D375mA PME(D0+,D1+,D2+,D3hot+=
,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
	Kernel driver in use: uhci_hcd
	Kernel modules: uhci-hcd

00:10.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 C=
ontroller (rev 81) (prog-if 00 [UHCI])
	Subsystem: ASRock Incorporation K7VT6
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- St=
epping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TA=
bort- <MAbort- >SERR- <PERR- INTx-
	Latency: 32, Cache Line Size: 32 bytes
	Interrupt: pin A routed to IRQ 21
	Region 4: I/O ports at c800 [size=3D32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D375mA PME(D0+,D1+,D2+,D3hot+=
,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
	Kernel driver in use: uhci_hcd
	Kernel modules: uhci-hcd

00:10.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 C=
ontroller (rev 81) (prog-if 00 [UHCI])
	Subsystem: ASRock Incorporation K7VT6
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- St=
epping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TA=
bort- <MAbort- >SERR- <PERR- INTx-
	Latency: 32, Cache Line Size: 32 bytes
	Interrupt: pin B routed to IRQ 21
	Region 4: I/O ports at cc00 [size=3D32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D375mA PME(D0+,D1+,D2+,D3hot+=
,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
	Kernel driver in use: uhci_hcd
	Kernel modules: uhci-hcd

00:10.3 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 C=
ontroller (rev 81) (prog-if 00 [UHCI])
	Subsystem: ASRock Incorporation K7VT6
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- St=
epping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TA=
bort- <MAbort- >SERR- <PERR- INTx-
	Latency: 32, Cache Line Size: 32 bytes
	Interrupt: pin B routed to IRQ 21
	Region 4: I/O ports at d000 [size=3D32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D375mA PME(D0+,D1+,D2+,D3hot+=
,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
	Kernel driver in use: uhci_hcd
	Kernel modules: uhci-hcd

00:10.4 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 86) (prog-i=
f 20 [EHCI])
	Subsystem: ASRock Incorporation K7VT6 motherboard
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- St=
epping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TA=
bort- <MAbort- >SERR- <PERR- INTx-
	Latency: 32, Cache Line Size: 64 bytes
	Interrupt: pin C routed to IRQ 21
	Region 0: Memory at dfffbd00 (32-bit, non-prefetchable) [size=3D256]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D375mA PME(D0+,D1+,D2+,D3hot+=
,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
	Kernel driver in use: ehci_hcd
	Kernel modules: ehci-hcd

00:11.0 ISA bridge: VIA Technologies, Inc. VT8237 ISA bridge [KT600/K8T=
800/K8T890 South]
	Subsystem: ASRock Incorporation K7VT4 motherboard
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- St=
epping+ SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TA=
bort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D=
3cold-)
		Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
	Kernel modules: i2c-viapro

00:11.5 Multimedia audio controller: VIA Technologies, Inc. VT8233/A/82=
35/8237 AC97 Audio Controller (rev 60)
	Subsystem: ASRock Incorporation K7VT6 motherboard
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- St=
epping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TA=
bort- <MAbort- >SERR- <PERR- INTx-
	Interrupt: pin C routed to IRQ 22
	Region 0: I/O ports at c000 [size=3D256]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D=
3cold-)
		Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
	Kernel driver in use: VIA 82xx Audio
	Kernel modules: snd-via82xx

00:12.0 Ethernet controller: VIA Technologies, Inc. VT6102 [Rhine-II] (=
rev 78)
	Subsystem: ASRock Incorporation K7VT6 motherboard
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- St=
epping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TA=
bort- <MAbort- >SERR- <PERR- INTx-
	Latency: 32 (750ns min, 2000ns max), Cache Line Size: 32 bytes
	Interrupt: pin A routed to IRQ 23
	Region 0: I/O ports at bc00 [size=3D256]
	Region 1: Memory at dfffbc00 (32-bit, non-prefetchable) [size=3D256]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA PME(D0+,D1+,D2+,D3hot+,D=
3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
	Kernel driver in use: via-rhine
	Kernel modules: via-rhine

01:00.0 VGA compatible controller: ATI Technologies Inc RV280 [Radeon 9=
200 PRO] (rev 01) (prog-if 00 [VGA controller])
	Subsystem: ATI Technologies Inc RV280 [Radeon 9200 PRO]
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- St=
epping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TA=
bort- <MAbort- >SERR- <PERR- INTx-
	Latency: 32 (2000ns min), Cache Line Size: 32 bytes
	Interrupt: pin A routed to IRQ 16
	Region 0: Memory at d0000000 (32-bit, prefetchable) [size=3D128M]
	Region 1: I/O ports at a800 [size=3D256]
	Region 2: Memory at dfef0000 (32-bit, non-prefetchable) [size=3D64K]
	Expansion ROM at dfec0000 [disabled] [size=3D128K]
	Capabilities: [58] AGP version 3.0
		Status: RQ=3D256 Iso- ArqSz=3D0 Cal=3D0 SBA+ ITACoh- GART64- HTrans- =
64bit- FW+ AGP3+ Rate=3Dx4,x8
		Command: RQ=3D32 ArqSz=3D0 Cal=3D0 SBA+ AGP+ GART64- 64bit- FW- Rate=3D=
x8
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D=
3cold-)
		Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
	Kernel driver in use: radeonfb

01:00.1 Display controller: ATI Technologies Inc RV280 [Radeon 9200 PRO=
] (Secondary) (rev 01)
	Subsystem: ATI Technologies Inc Device 5961
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- St=
epping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TA=
bort- <MAbort- >SERR- <PERR- INTx-
	Latency: 32 (2000ns min), Cache Line Size: 32 bytes
	Region 0: Memory at c8000000 (32-bit, prefetchable) [size=3D128M]
	Region 1: Memory at dfee0000 (32-bit, non-prefetchable) [size=3D64K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D=
3cold-)
		Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-

# lsmod
Module                  Size  Used by
ipv6                  197524  8=20
radeon                330896  2=20
drm                   119248  3 radeon
af_packet              17104  0=20
ext3                   99512  2=20
jbd                    33536  1 ext3
sg                     16932  0=20
sd_mod                 22240  2=20
fuse                   49204  3=20
gspca_zc3xx            44160  0=20
gspca_main             18540  1 gspca_zc3xx
videodev               28860  1 gspca_main
v4l1_compat            11160  1 videodev
joydev                  8320  0=20
usbhid                 22804  0=20
hid                    32708  1 usbhid
usb_storage            30812  1=20
scsi_mod               76560  3 sg,sd_mod,usb_storage
usb_libusual           18956  1 usb_storage
evdev                   7824  8=20
uhci_hcd               18096  0=20
snd_via82xx            20248  3=20
snd_ac97_codec         89360  1 snd_via82xx
ac97_bus                1268  1 snd_ac97_codec
snd_pcsp                7864  1=20
snd_mpu401_uart         5252  1 snd_via82xx
snd_rawmidi            14988  1 snd_mpu401_uart
processor              23596  0=20
ehci_hcd               27832  0=20
snd_pcm                49012  4 snd_via82xx,snd_ac97_codec,snd_pcsp
via_rhine              18268  0=20
8139too                18524  0=20
rtc_cmos                7772  0=20
mii                     3900  2 via_rhine,8139too
snd_timer              15148  1 snd_pcm
snd_page_alloc          7080  2 snd_via82xx,snd_pcm
ide_cd_mod             23464  0=20
thermal                12688  0=20
via_agp                 7472  1=20
usbcore               110336  7 gspca_zc3xx,gspca_main,usbhid,usb_stora=
ge,usb_libusual,uhci_hcd,ehci_hcd
snd_seq_device          5400  1 snd_rawmidi
rtc_core               13320  1 rtc_cmos
8250_pnp               13972  0=20
nls_base                5696  1 usbcore
thermal_sys            12260  2 processor,thermal
8250                   22952  1 8250_pnp
snd                    36968  15 snd_via82xx,snd_ac97_codec,snd_pcsp,sn=
d_mpu401_uart,snd_rawmidi,snd_pcm,snd_timer,snd_seq_device
agpgart                25264  2 drm,via_agp
ns558                   3944  0=20
psmouse                36760  0=20
rtc_lib                 2048  1 rtc_core
cdrom                  29076  1 ide_cd_mod
soundcore               1280  1 snd
i2c_viapro              6516  0=20
serial_core            14756  1 8250
floppy                 45708  0=20
button                  4860  0=20
hwmon                   2132  1 thermal_sys
gameport                8508  3 snd_via82xx,ns558
unix                   20016  334

# lshal -l

Dumping 84 device(s) from the Global Device List:
-------------------------------------------------
udi =3D '/org/freedesktop/Hal/devices/computer'
  info.addons =3D {'hald-addon-cpufreq', 'hald-addon-acpi'} (string lis=
t)
  info.callouts.add =3D {'hal-storage-cleanup-all-mountpoints'} (string=
 list)
  info.interfaces =3D {'org.freedesktop.Hal.Device.SystemPowerManagemen=
t'} (string list)
  info.product =3D 'Computer'  (string)
  info.subsystem =3D 'unknown'  (string)
  info.udi =3D '/org/freedesktop/Hal/devices/computer'  (string)
  org.freedesktop.Hal.Device.SystemPowerManagement.method_argnames =3D =
{'num_seconds_to_sleep', 'num_seconds_to_sleep', '', '', '', 'enable_po=
wer_save'} (string list)
  org.freedesktop.Hal.Device.SystemPowerManagement.method_execpaths =3D=
 {'hal-system-power-suspend', 'hal-system-power-suspend-hybrid', 'hal-s=
ystem-power-hibernate', 'hal-system-power-shutdown', 'hal-system-power-=
reboot', 'hal-system-power-set-power-save'} (string list)
  org.freedesktop.Hal.Device.SystemPowerManagement.method_names =3D {'S=
uspend', 'SuspendHybrid', 'Hibernate', 'Shutdown', 'Reboot', 'SetPowerS=
ave'} (string list)
  org.freedesktop.Hal.Device.SystemPowerManagement.method_signatures =3D=
 {'i', 'i', '', '', '', 'b'} (string list)
  power_management.acpi.linux.version =3D '20090521'  (string)
  power_management.can_hibernate =3D true  (bool)
  power_management.can_suspend =3D false  (bool)
  power_management.can_suspend_hybrid =3D false  (bool)
  power_management.is_powersave_set =3D false  (bool)
  power_management.quirk.dpms_on =3D true  (bool)
  power_management.quirk.dpms_suspend =3D true  (bool)
  power_management.quirk.vbe_post =3D true  (bool)
  power_management.quirk.vbemode_restore =3D true  (bool)
  power_management.quirk.vbestate_restore =3D true  (bool)
  power_management.quirk.vga_mode_3 =3D true  (bool)
  power_management.type =3D 'acpi'  (string)
  system.chassis.manufacturer =3D ''  (string)
  system.chassis.type =3D 'Desktop'  (string)
  system.firmware.release_date =3D '12/08/2004'  (string)
  system.firmware.vendor =3D 'American Megatrends Inc.'  (string)
  system.firmware.version =3D 'P1.10'  (string)
  system.formfactor =3D 'desktop'  (string)
  system.hardware.primary_video.product =3D 22880  (0x5960)  (int)
  system.hardware.primary_video.vendor =3D 4098  (0x1002)  (int)
  system.hardware.product =3D 'K7VT4APro'  (string)
  system.hardware.serial =3D '00000000'  (string)
  system.hardware.uuid =3D ''  (string)
  system.hardware.vendor =3D ''  (string)
  system.hardware.version =3D '1.0x'  (string)
  system.kernel.machine =3D 'i686'  (string)
  system.kernel.name =3D 'Linux'  (string)
  system.kernel.version =3D '2.6.31-wotan-10'  (string)

udi =3D '/org/freedesktop/Hal/devices/acpi_CPU0'
  info.capabilities =3D {'processor'} (string list)
  info.category =3D 'processor'  (string)
  info.parent =3D '/org/freedesktop/Hal/devices/computer'  (string)
  info.product =3D 'AMD Sempron(tm) 2400+'  (string)
  info.udi =3D '/org/freedesktop/Hal/devices/acpi_CPU0'  (string)
  linux.acpi_path =3D '/proc/acpi/processor/CPU0'  (string)
  linux.acpi_type =3D 1  (0x1)  (int)
  linux.hotplug_type =3D 4  (0x4)  (int)
  processor.can_throttle =3D false  (bool)
  processor.number =3D 0  (0x0)  (int)

udi =3D '/org/freedesktop/Hal/devices/computer_alsa_timer'
  alsa.device_file =3D '/dev/snd/timer'  (string)
  alsa.type =3D 'timer'  (string)
  info.capabilities =3D {'alsa'} (string list)
  info.category =3D 'alsa'  (string)
  info.parent =3D '/org/freedesktop/Hal/devices/computer'  (string)
  info.product =3D 'ALSA Timer Device'  (string)
  info.subsystem =3D 'sound'  (string)
  info.udi =3D '/org/freedesktop/Hal/devices/computer_alsa_timer'  (str=
ing)
  linux.device_file =3D '/dev/snd/timer'  (string)
  linux.hotplug_type =3D 2  (0x2)  (int)
  linux.subsystem =3D 'sound'  (string)
  linux.sysfs_path =3D '/sys/devices/virtual/sound/timer'  (string)

udi =3D '/org/freedesktop/Hal/devices/computer_logicaldev_input_1'
  button.has_state =3D false  (bool)
  button.type =3D 'sleep'  (string)
  info.addons.singleton =3D {'hald-addon-input'} (string list)
  info.capabilities =3D {'input', 'button'} (string list)
  info.category =3D 'input'  (string)
  info.parent =3D '/org/freedesktop/Hal/devices/computer'  (string)
  info.product =3D 'Sleep Button'  (string)
  info.subsystem =3D 'input'  (string)
  info.udi =3D '/org/freedesktop/Hal/devices/computer_logicaldev_input_=
1'  (string)
  input.device =3D '/dev/input/event2'  (string)
  input.product =3D 'Sleep Button'  (string)
  linux.device_file =3D '/dev/input/event2'  (string)
  linux.hotplug_type =3D 2  (0x2)  (int)
  linux.subsystem =3D 'input'  (string)
  linux.sysfs_path =3D '/sys/devices/LNXSYSTM:00/device:00/PNP0C0E:00/i=
nput/input2/event2'  (string)

udi =3D '/org/freedesktop/Hal/devices/computer_logicaldev_input_0'
  button.has_state =3D false  (bool)
  button.type =3D 'power'  (string)
  info.addons.singleton =3D {'hald-addon-input'} (string list)
  info.capabilities =3D {'input', 'button'} (string list)
  info.category =3D 'input'  (string)
  info.parent =3D '/org/freedesktop/Hal/devices/computer'  (string)
  info.product =3D 'Power Button'  (string)
  info.subsystem =3D 'input'  (string)
  info.udi =3D '/org/freedesktop/Hal/devices/computer_logicaldev_input_=
0'  (string)
  input.device =3D '/dev/input/event1'  (string)
  input.product =3D 'Power Button'  (string)
  linux.device_file =3D '/dev/input/event1'  (string)
  linux.hotplug_type =3D 2  (0x2)  (int)
  linux.subsystem =3D 'input'  (string)
  linux.sysfs_path =3D '/sys/devices/LNXSYSTM:00/device:00/PNP0C0C:00/i=
nput/input1/event1'  (string)

udi =3D '/org/freedesktop/Hal/devices/computer_logicaldev_input'
  button.has_state =3D false  (bool)
  button.type =3D 'power'  (string)
  info.addons.singleton =3D {'hald-addon-input'} (string list)
  info.capabilities =3D {'input', 'button'} (string list)
  info.category =3D 'input'  (string)
  info.parent =3D '/org/freedesktop/Hal/devices/computer'  (string)
  info.product =3D 'Power Button'  (string)
  info.subsystem =3D 'input'  (string)
  info.udi =3D '/org/freedesktop/Hal/devices/computer_logicaldev_input'=
  (string)
  input.device =3D '/dev/input/event0'  (string)
  input.product =3D 'Power Button'  (string)
  linux.device_file =3D '/dev/input/event0'  (string)
  linux.hotplug_type =3D 2  (0x2)  (int)
  linux.subsystem =3D 'input'  (string)
  linux.sysfs_path =3D '/sys/devices/LNXSYSTM:00/LNXPWRBN:00/input/inpu=
t0/event0'  (string)

udi =3D '/org/freedesktop/Hal/devices/pnp_PNP0f13'
  info.linux.driver =3D 'i8042 aux'  (string)
  info.parent =3D '/org/freedesktop/Hal/devices/computer'  (string)
  info.product =3D 'PS/2 Port for PS/2-style Mice'  (string)
  info.subsystem =3D 'pnp'  (string)
  info.udi =3D '/org/freedesktop/Hal/devices/pnp_PNP0f13'  (string)
  linux.hotplug_type =3D 2  (0x2)  (int)
  linux.subsystem =3D 'pnp'  (string)
  linux.sysfs_path =3D '/sys/devices/pnp0/00:0a'  (string)
  pnp.description =3D 'PS/2 Port for PS/2-style Mice'  (string)
  pnp.id =3D 'PNP0f13'  (string)

udi =3D '/org/freedesktop/Hal/devices/pnp_PNP0c04'
  info.parent =3D '/org/freedesktop/Hal/devices/computer'  (string)
  info.product =3D 'Math Coprocessor'  (string)
  info.subsystem =3D 'pnp'  (string)
  info.udi =3D '/org/freedesktop/Hal/devices/pnp_PNP0c04'  (string)
  linux.hotplug_type =3D 2  (0x2)  (int)
  linux.subsystem =3D 'pnp'  (string)
  linux.sysfs_path =3D '/sys/devices/pnp0/00:09'  (string)
  pnp.description =3D 'Math Coprocessor'  (string)
  pnp.id =3D 'PNP0c04'  (string)

udi =3D '/org/freedesktop/Hal/devices/pnp_PNP0800'
  info.parent =3D '/org/freedesktop/Hal/devices/computer'  (string)
  info.product =3D 'AT-style speaker sound'  (string)
  info.subsystem =3D 'pnp'  (string)
  info.udi =3D '/org/freedesktop/Hal/devices/pnp_PNP0800'  (string)
  linux.hotplug_type =3D 2  (0x2)  (int)
  linux.subsystem =3D 'pnp'  (string)
  linux.sysfs_path =3D '/sys/devices/pnp0/00:08'  (string)
  pnp.description =3D 'AT-style speaker sound'  (string)
  pnp.id =3D 'PNP0800'  (string)

udi =3D '/org/freedesktop/Hal/devices/pnp_PNP0b00'
  info.linux.driver =3D 'rtc_cmos'  (string)
  info.parent =3D '/org/freedesktop/Hal/devices/computer'  (string)
  info.product =3D 'AT Real-Time Clock'  (string)
  info.subsystem =3D 'pnp'  (string)
  info.udi =3D '/org/freedesktop/Hal/devices/pnp_PNP0b00'  (string)
  linux.hotplug_type =3D 2  (0x2)  (int)
  linux.subsystem =3D 'pnp'  (string)
  linux.sysfs_path =3D '/sys/devices/pnp0/00:07'  (string)
  pnp.description =3D 'AT Real-Time Clock'  (string)
  pnp.id =3D 'PNP0b00'  (string)

udi =3D '/org/freedesktop/Hal/devices/pnp_PNP0200'
  info.parent =3D '/org/freedesktop/Hal/devices/computer'  (string)
  info.product =3D 'AT DMA Controller'  (string)
  info.subsystem =3D 'pnp'  (string)
  info.udi =3D '/org/freedesktop/Hal/devices/pnp_PNP0200'  (string)
  linux.hotplug_type =3D 2  (0x2)  (int)
  linux.subsystem =3D 'pnp'  (string)
  linux.sysfs_path =3D '/sys/devices/pnp0/00:06'  (string)
  pnp.description =3D 'AT DMA Controller'  (string)
  pnp.id =3D 'PNP0200'  (string)

udi =3D '/org/freedesktop/Hal/devices/pnp_PNP0c02'
  info.linux.driver =3D 'system'  (string)
  info.parent =3D '/org/freedesktop/Hal/devices/computer'  (string)
  info.product =3D 'General ID for reserving resources required by PnP =
motherboard registers. (Not device specific.)'  (string)
  info.subsystem =3D 'pnp'  (string)
  info.udi =3D '/org/freedesktop/Hal/devices/pnp_PNP0c02'  (string)
  linux.hotplug_type =3D 2  (0x2)  (int)
  linux.subsystem =3D 'pnp'  (string)
  linux.sysfs_path =3D '/sys/devices/pnp0/00:05'  (string)
  pnp.description =3D 'General ID for reserving resources required by P=
nP motherboard registers. (Not device specific.)'  (string)
  pnp.id =3D 'PNP0c02'  (string)

udi =3D '/org/freedesktop/Hal/devices/pnp_PNPb02f'
  info.linux.driver =3D 'ns558'  (string)
  info.parent =3D '/org/freedesktop/Hal/devices/computer'  (string)
  info.product =3D 'Joystick/Game port'  (string)
  info.subsystem =3D 'pnp'  (string)
  info.udi =3D '/org/freedesktop/Hal/devices/pnp_PNPb02f'  (string)
  linux.hotplug_type =3D 2  (0x2)  (int)
  linux.subsystem =3D 'pnp'  (string)
  linux.sysfs_path =3D '/sys/devices/pnp0/00:04'  (string)
  pnp.description =3D 'Joystick/Game port'  (string)
  pnp.id =3D 'PNPb02f'  (string)

udi =3D '/org/freedesktop/Hal/devices/pnp_PNP0401'
  info.parent =3D '/org/freedesktop/Hal/devices/computer'  (string)
  info.product =3D 'ECP printer port'  (string)
  info.subsystem =3D 'pnp'  (string)
  info.udi =3D '/org/freedesktop/Hal/devices/pnp_PNP0401'  (string)
  linux.hotplug_type =3D 2  (0x2)  (int)
  linux.subsystem =3D 'pnp'  (string)
  linux.sysfs_path =3D '/sys/devices/pnp0/00:03'  (string)
  pnp.description =3D 'ECP printer port'  (string)
  pnp.id =3D 'PNP0401'  (string)

udi =3D '/org/freedesktop/Hal/devices/pnp_PNP0501'
  info.linux.driver =3D 'serial'  (string)
  info.parent =3D '/org/freedesktop/Hal/devices/computer'  (string)
  info.product =3D '16550A-compatible COM port'  (string)
  info.subsystem =3D 'pnp'  (string)
  info.udi =3D '/org/freedesktop/Hal/devices/pnp_PNP0501'  (string)
  linux.hotplug_type =3D 2  (0x2)  (int)
  linux.subsystem =3D 'pnp'  (string)
  linux.sysfs_path =3D '/sys/devices/pnp0/00:02'  (string)
  pnp.description =3D '16550A-compatible COM port'  (string)
  pnp.id =3D 'PNP0501'  (string)

udi =3D '/org/freedesktop/Hal/devices/pnp_PNP0501_serial_platform_0'
  info.capabilities =3D {'serial'} (string list)
  info.category =3D 'serial'  (string)
  info.parent =3D '/org/freedesktop/Hal/devices/pnp_PNP0501'  (string)
  info.product =3D '16550A-compatible COM port'  (string)
  info.subsystem =3D 'tty'  (string)
  info.udi =3D '/org/freedesktop/Hal/devices/pnp_PNP0501_serial_platfor=
m_0'  (string)
  linux.device_file =3D '/dev/ttyS0'  (string)
  linux.hotplug_type =3D 2  (0x2)  (int)
  linux.subsystem =3D 'tty'  (string)
  linux.sysfs_path =3D '/sys/devices/pnp0/00:02/tty/ttyS0'  (string)
  serial.device =3D '/dev/ttyS0'  (string)
  serial.originating_device =3D '/org/freedesktop/Hal/devices/pnp_PNP05=
01'  (string)
  serial.port =3D 0  (0x0)  (int)
  serial.type =3D 'platform'  (string)

udi =3D '/org/freedesktop/Hal/devices/pnp_PNP0700'
  info.parent =3D '/org/freedesktop/Hal/devices/computer'  (string)
  info.product =3D 'PC standard floppy disk controller'  (string)
  info.subsystem =3D 'pnp'  (string)
  info.udi =3D '/org/freedesktop/Hal/devices/pnp_PNP0700'  (string)
  linux.hotplug_type =3D 2  (0x2)  (int)
  linux.subsystem =3D 'pnp'  (string)
  linux.sysfs_path =3D '/sys/devices/pnp0/00:01'  (string)
  pnp.description =3D 'PC standard floppy disk controller'  (string)
  pnp.id =3D 'PNP0700'  (string)

udi =3D '/org/freedesktop/Hal/devices/pnp_PNP0a03'
  info.parent =3D '/org/freedesktop/Hal/devices/computer'  (string)
  info.product =3D 'PCI Bus'  (string)
  info.subsystem =3D 'pnp'  (string)
  info.udi =3D '/org/freedesktop/Hal/devices/pnp_PNP0a03'  (string)
  linux.hotplug_type =3D 2  (0x2)  (int)
  linux.subsystem =3D 'pnp'  (string)
  linux.sysfs_path =3D '/sys/devices/pnp0/00:00'  (string)
  pnp.description =3D 'PCI Bus'  (string)
  pnp.id =3D 'PNP0a03'  (string)

udi =3D '/org/freedesktop/Hal/devices/platform_serial8250'
  info.linux.driver =3D 'serial8250'  (string)
  info.parent =3D '/org/freedesktop/Hal/devices/computer'  (string)
  info.product =3D 'Platform Device (serial8250)'  (string)
  info.subsystem =3D 'platform'  (string)
  info.udi =3D '/org/freedesktop/Hal/devices/platform_serial8250'  (str=
ing)
  linux.hotplug_type =3D 2  (0x2)  (int)
  linux.subsystem =3D 'platform'  (string)
  linux.sysfs_path =3D '/sys/devices/platform/serial8250'  (string)
  platform.id =3D 'serial8250'  (string)

udi =3D '/org/freedesktop/Hal/devices/platform_pcspkr'
  info.linux.driver =3D 'pcspkr'  (string)
  info.parent =3D '/org/freedesktop/Hal/devices/computer'  (string)
  info.product =3D 'Platform Device (pcspkr)'  (string)
  info.subsystem =3D 'platform'  (string)
  info.udi =3D '/org/freedesktop/Hal/devices/platform_pcspkr'  (string)
  linux.hotplug_type =3D 2  (0x2)  (int)
  linux.subsystem =3D 'platform'  (string)
  linux.sysfs_path =3D '/sys/devices/platform/pcspkr'  (string)
  platform.id =3D 'pcspkr'  (string)

udi =3D '/org/freedesktop/Hal/devices/platform_pcspkr_sound_card_0'
  info.capabilities =3D {'sound'} (string list)
  info.category =3D 'sound'  (string)
  info.parent =3D '/org/freedesktop/Hal/devices/platform_pcspkr'  (stri=
ng)
  info.product =3D 'Internal PC-Speaker Sound Card'  (string)
  info.subsystem =3D 'sound'  (string)
  info.udi =3D '/org/freedesktop/Hal/devices/platform_pcspkr_sound_card=
_0'  (string)
  linux.hotplug_type =3D 2  (0x2)  (int)
  linux.subsystem =3D 'sound'  (string)
  linux.sysfs_path =3D '/sys/devices/platform/pcspkr/sound/card2'  (str=
ing)
  sound.card =3D 2  (0x2)  (int)
  sound.card_id =3D 'Internal PC-Speaker'  (string)
  sound.originating_device =3D '/org/freedesktop/Hal/devices/platform_p=
cspkr'  (string)

udi =3D '/org/freedesktop/Hal/devices/platform_pcspkr_sound_card_0_alsa=
_playback_0'
  alsa.card =3D 2  (0x2)  (int)
  alsa.card_id =3D 'Internal PC-Speaker'  (string)
  alsa.device =3D 0  (0x0)  (int)
  alsa.device_file =3D '/dev/snd/pcmC2D0p'  (string)
  alsa.originating_device =3D '/org/freedesktop/Hal/devices/platform_pc=
spkr_sound_card_0'  (string)
  alsa.pcm_class =3D 'generic'  (string)
  alsa.type =3D 'playback'  (string)
  info.capabilities =3D {'alsa'} (string list)
  info.category =3D 'alsa'  (string)
  info.parent =3D '/org/freedesktop/Hal/devices/platform_pcspkr_sound_c=
ard_0'  (string)
  info.product =3D 'ALSA Playback Device'  (string)
  info.subsystem =3D 'sound'  (string)
  info.udi =3D '/org/freedesktop/Hal/devices/platform_pcspkr_sound_card=
_0_alsa_playback_0'  (string)
  linux.device_file =3D '/dev/snd/pcmC2D0p'  (string)
  linux.hotplug_type =3D 2  (0x2)  (int)
  linux.subsystem =3D 'sound'  (string)
  linux.sysfs_path =3D '/sys/devices/platform/pcspkr/sound/card2/pcmC2D=
0p'  (string)

udi =3D '/org/freedesktop/Hal/devices/platform_pcspkr_sound_card_0_alsa=
_control__1'
  alsa.card =3D 2  (0x2)  (int)
  alsa.card_id =3D 'Internal PC-Speaker'  (string)
  alsa.device_file =3D '/dev/snd/controlC2'  (string)
  alsa.originating_device =3D '/org/freedesktop/Hal/devices/platform_pc=
spkr_sound_card_0'  (string)
  alsa.type =3D 'control'  (string)
  info.capabilities =3D {'alsa'} (string list)
  info.category =3D 'alsa'  (string)
  info.parent =3D '/org/freedesktop/Hal/devices/platform_pcspkr_sound_c=
ard_0'  (string)
  info.product =3D 'Internal PC-Speaker ALSA Control Device'  (string)
  info.subsystem =3D 'sound'  (string)
  info.udi =3D '/org/freedesktop/Hal/devices/platform_pcspkr_sound_card=
_0_alsa_control__1'  (string)
  linux.device_file =3D '/dev/snd/controlC2'  (string)
  linux.hotplug_type =3D 2  (0x2)  (int)
  linux.subsystem =3D 'sound'  (string)
  linux.sysfs_path =3D '/sys/devices/platform/pcspkr/sound/card2/contro=
lC2'  (string)

udi =3D '/org/freedesktop/Hal/devices/platform_pcspkr_logicaldev_input'
  info.capabilities =3D {'input'} (string list)
  info.category =3D 'input'  (string)
  info.parent =3D '/org/freedesktop/Hal/devices/platform_pcspkr'  (stri=
ng)
  info.product =3D 'PC Speaker'  (string)
  info.subsystem =3D 'input'  (string)
  info.udi =3D '/org/freedesktop/Hal/devices/platform_pcspkr_logicaldev=
_input'  (string)
  input.device =3D '/dev/input/event3'  (string)
  input.originating_device =3D '/org/freedesktop/Hal/devices/platform_p=
cspkr'  (string)
  input.product =3D 'PC Speaker'  (string)
  linux.device_file =3D '/dev/input/event3'  (string)
  linux.hotplug_type =3D 2  (0x2)  (int)
  linux.subsystem =3D 'input'  (string)
  linux.sysfs_path =3D '/sys/devices/platform/pcspkr/input/input3/event=
3'  (string)

udi =3D '/org/freedesktop/Hal/devices/platform_i8042'
  info.linux.driver =3D 'i8042'  (string)
  info.parent =3D '/org/freedesktop/Hal/devices/computer'  (string)
  info.product =3D 'Platform Device (i8042)'  (string)
  info.subsystem =3D 'platform'  (string)
  info.udi =3D '/org/freedesktop/Hal/devices/platform_i8042'  (string)
  linux.hotplug_type =3D 2  (0x2)  (int)
  linux.subsystem =3D 'platform'  (string)
  linux.sysfs_path =3D '/sys/devices/platform/i8042'  (string)
  platform.id =3D 'i8042'  (string)

udi =3D '/org/freedesktop/Hal/devices/platform_i8042_i8042_AUX_port'
  info.linux.driver =3D 'psmouse'  (string)
  info.parent =3D '/org/freedesktop/Hal/devices/platform_i8042'  (strin=
g)
  info.product =3D 'i8042 AUX port'  (string)
  info.subsystem =3D 'serio'  (string)
  info.udi =3D '/org/freedesktop/Hal/devices/platform_i8042_i8042_AUX_p=
ort'  (string)
  linux.hotplug_type =3D 2  (0x2)  (int)
  linux.subsystem =3D 'serio'  (string)
  linux.sysfs_path =3D '/sys/devices/platform/i8042/serio1'  (string)
  serio.description =3D 'i8042 AUX port'  (string)
  serio.id =3D 'serio1'  (string)

udi =3D '/org/freedesktop/Hal/devices/platform_i8042_i8042_AUX_port_log=
icaldev_input'
  info.capabilities =3D {'input', 'input.mouse'} (string list)
  info.category =3D 'input'  (string)
  info.parent =3D '/org/freedesktop/Hal/devices/platform_i8042_i8042_AU=
X_port'  (string)
  info.product =3D 'ImExPS/2 Generic Explorer Mouse'  (string)
  info.subsystem =3D 'input'  (string)
  info.udi =3D '/org/freedesktop/Hal/devices/platform_i8042_i8042_AUX_p=
ort_logicaldev_input'  (string)
  input.device =3D '/dev/input/event4'  (string)
  input.originating_device =3D '/org/freedesktop/Hal/devices/platform_i=
8042_i8042_AUX_port'  (string)
  input.product =3D 'ImExPS/2 Generic Explorer Mouse'  (string)
  input.x11_driver =3D 'evdev'  (string)
  linux.device_file =3D '/dev/input/event4'  (string)
  linux.hotplug_type =3D 2  (0x2)  (int)
  linux.subsystem =3D 'input'  (string)
  linux.sysfs_path =3D '/sys/devices/platform/i8042/serio1/input/input4=
/event4'  (string)

udi =3D '/org/freedesktop/Hal/devices/platform_i8042_i8042_KBD_port'
  info.parent =3D '/org/freedesktop/Hal/devices/platform_i8042'  (strin=
g)
  info.product =3D 'i8042 KBD port'  (string)
  info.subsystem =3D 'serio'  (string)
  info.udi =3D '/org/freedesktop/Hal/devices/platform_i8042_i8042_KBD_p=
ort'  (string)
  linux.hotplug_type =3D 2  (0x2)  (int)
  linux.subsystem =3D 'serio'  (string)
  linux.sysfs_path =3D '/sys/devices/platform/i8042/serio0'  (string)
  serio.description =3D 'i8042 KBD port'  (string)
  serio.id =3D 'serio0'  (string)

udi =3D '/org/freedesktop/Hal/devices/platform_floppy_0'
  info.linux.driver =3D 'floppy'  (string)
  info.parent =3D '/org/freedesktop/Hal/devices/computer'  (string)
  info.product =3D 'Platform Device (floppy.0)'  (string)
  info.subsystem =3D 'platform'  (string)
  info.udi =3D '/org/freedesktop/Hal/devices/platform_floppy_0'  (strin=
g)
  linux.hotplug_type =3D 2  (0x2)  (int)
  linux.subsystem =3D 'platform'  (string)
  linux.sysfs_path =3D '/sys/devices/platform/floppy.0'  (string)
  platform.id =3D 'floppy.0'  (string)

udi =3D '/org/freedesktop/Hal/devices/platform_floppy_0_storage_platfor=
m_floppy'
  block.device =3D '/dev/fd0'  (string)
  block.is_volume =3D false  (bool)
  block.major =3D 2  (0x2)  (int)
  block.minor =3D 0  (0x0)  (int)
  block.storage_device =3D '/org/freedesktop/Hal/devices/platform_flopp=
y_0_storage_platform_floppy'  (string)
  info.addons =3D {'hald-addon-storage'} (string list)
  info.capabilities =3D {'storage', 'block'} (string list)
  info.category =3D 'storage'  (string)
  info.interfaces =3D {'org.freedesktop.Hal.Device.Volume', 'org.freede=
sktop.Hal.Device.Storage.Removable'} (string list)
  info.parent =3D '/org/freedesktop/Hal/devices/platform_floppy_0'  (st=
ring)
  info.product =3D 'PC Floppy Drive'  (string)
  info.udi =3D '/org/freedesktop/Hal/devices/platform_floppy_0_storage_=
platform_floppy'  (string)
  info.vendor =3D ''  (string)
  linux.hotplug_type =3D 3  (0x3)  (int)
  linux.sysfs_path =3D '/sys/devices/platform/floppy.0/block/fd0'  (str=
ing)
  org.freedesktop.Hal.Device.Volume.method_argnames =3D {'mount_point f=
stype extra_options', 'extra_options', 'extra_options'} (string list)
  org.freedesktop.Hal.Device.Volume.method_execpaths =3D {'hal-storage-=
mount', 'hal-storage-unmount', 'hal-storage-eject'} (string list)
  org.freedesktop.Hal.Device.Volume.method_names =3D {'Mount', 'Unmount=
', 'Eject'} (string list)
  org.freedesktop.Hal.Device.Volume.method_signatures =3D {'ssas', 'as'=
, 'as'} (string list)
  storage.automount_enabled_hint =3D true  (bool)
  storage.bus =3D 'platform'  (string)
  storage.drive_type =3D 'floppy'  (string)
  storage.hotpluggable =3D false  (bool)
  storage.media_check_enabled =3D false  (bool)
  storage.model =3D ''  (string)
  storage.no_partitions_hint =3D true  (bool)
  storage.originating_device =3D '/org/freedesktop/Hal/devices/platform=
_floppy_0'  (string)
  storage.removable =3D true  (bool)
  storage.removable.media_available =3D false  (bool)
  storage.requires_eject =3D false  (bool)
  storage.size =3D 0  (0x0)  (uint64)
  storage.vendor =3D 'PC Floppy Drive'  (string)
  volume.mount.valid_options =3D {'ro', 'sync', 'dirsync', 'noatime', '=
nodiratime', 'noexec', 'quiet', 'remount', 'exec', 'utf8', 'shortname=3D=
', 'codepage=3D', 'iocharset=3D', 'umask=3D', 'uid=3D'} (string list)

udi =3D '/org/freedesktop/Hal/devices/pci_1106_3065'
  info.linux.driver =3D 'via-rhine'  (string)
  info.parent =3D '/org/freedesktop/Hal/devices/computer'  (string)
  info.product =3D 'VT6102 [Rhine-II]'  (string)
  info.subsystem =3D 'pci'  (string)
  info.udi =3D '/org/freedesktop/Hal/devices/pci_1106_3065'  (string)
  info.vendor =3D 'VIA Technologies, Inc.'  (string)
  linux.hotplug_type =3D 2  (0x2)  (int)
  linux.subsystem =3D 'pci'  (string)
  linux.sysfs_path =3D '/sys/devices/pci0000:00/0000:00:12.0'  (string)
  pci.device_class =3D 2  (0x2)  (int)
  pci.device_protocol =3D 0  (0x0)  (int)
  pci.device_subclass =3D 0  (0x0)  (int)
  pci.linux.sysfs_path =3D '/sys/devices/pci0000:00/0000:00:12.0'  (str=
ing)
  pci.product =3D 'VT6102 [Rhine-II]'  (string)
  pci.product_id =3D 12389  (0x3065)  (int)
  pci.subsys_product =3D 'K7VT6 motherboard'  (string)
  pci.subsys_product_id =3D 12389  (0x3065)  (int)
  pci.subsys_vendor =3D 'ASRock Incorporation'  (string)
  pci.subsys_vendor_id =3D 6217  (0x1849)  (int)
  pci.vendor =3D 'VIA Technologies, Inc.'  (string)
  pci.vendor_id =3D 4358  (0x1106)  (int)

udi =3D '/org/freedesktop/Hal/devices/net_00_0b_6a_c0_a1_d7'
  info.capabilities =3D {'net', 'net.80203', 'wake_on_lan'} (string lis=
t)
  info.category =3D 'net.80203'  (string)
  info.interfaces =3D {'org.freedesktop.Hal.Device.WakeOnLan'} (string =
list)
  info.parent =3D '/org/freedesktop/Hal/devices/pci_1106_3065'  (string=
)
  info.product =3D 'Networking Interface'  (string)
  info.subsystem =3D 'net'  (string)
  info.udi =3D '/org/freedesktop/Hal/devices/net_00_0b_6a_c0_a1_d7'  (s=
tring)
  linux.hotplug_type =3D 2  (0x2)  (int)
  linux.subsystem =3D 'net'  (string)
  linux.sysfs_path =3D '/sys/devices/pci0000:00/0000:00:12.0/net/eth0' =
 (string)
  net.80203.mac_address =3D 49035649495  (0xb6ac0a1d7)  (uint64)
  net.address =3D '00:0b:6a:c0:a1:d7'  (string)
  net.arp_proto_hw_id =3D 1  (0x1)  (int)
  net.interface =3D 'eth0'  (string)
  net.linux.ifindex =3D 2  (0x2)  (int)
  net.originating_device =3D '/org/freedesktop/Hal/devices/pci_1106_306=
5'  (string)
  org.freedesktop.Hal.Device.WakeOnLan.method_argnames =3D {'', '', 'en=
able'} (string list)
  org.freedesktop.Hal.Device.WakeOnLan.method_execpaths =3D {'hal-syste=
m-wol-supported', 'hal-system-wol-enabled', 'hal-system-wol-enable'} (s=
tring list)
  org.freedesktop.Hal.Device.WakeOnLan.method_names =3D {'GetSupported'=
, 'GetEnabled', 'SetEnabled'} (string list)
  org.freedesktop.Hal.Device.WakeOnLan.method_signatures =3D {'', '', '=
b'} (string list)

udi =3D '/org/freedesktop/Hal/devices/pci_1106_3059'
  info.linux.driver =3D 'VIA 82xx Audio'  (string)
  info.parent =3D '/org/freedesktop/Hal/devices/computer'  (string)
  info.product =3D 'VT8233/A/8235/8237 AC97 Audio Controller'  (string)
  info.subsystem =3D 'pci'  (string)
  info.udi =3D '/org/freedesktop/Hal/devices/pci_1106_3059'  (string)
  info.vendor =3D 'VIA Technologies, Inc.'  (string)
  linux.hotplug_type =3D 2  (0x2)  (int)
  linux.subsystem =3D 'pci'  (string)
  linux.sysfs_path =3D '/sys/devices/pci0000:00/0000:00:11.5'  (string)
  pci.device_class =3D 4  (0x4)  (int)
  pci.device_protocol =3D 0  (0x0)  (int)
  pci.device_subclass =3D 1  (0x1)  (int)
  pci.linux.sysfs_path =3D '/sys/devices/pci0000:00/0000:00:11.5'  (str=
ing)
  pci.product =3D 'VT8233/A/8235/8237 AC97 Audio Controller'  (string)
  pci.product_id =3D 12377  (0x3059)  (int)
  pci.subsys_product =3D 'K7VT6 motherboard'  (string)
  pci.subsys_product_id =3D 38753  (0x9761)  (int)
  pci.subsys_vendor =3D 'ASRock Incorporation'  (string)
  pci.subsys_vendor_id =3D 6217  (0x1849)  (int)
  pci.vendor =3D 'VIA Technologies, Inc.'  (string)
  pci.vendor_id =3D 4358  (0x1106)  (int)

udi =3D '/org/freedesktop/Hal/devices/pci_1106_3059_sound_card_0'
  info.capabilities =3D {'sound'} (string list)
  info.category =3D 'sound'  (string)
  info.parent =3D '/org/freedesktop/Hal/devices/pci_1106_3059'  (string=
)
  info.product =3D 'VIA 8237 with CMI9761A+ Sound Card'  (string)
  info.subsystem =3D 'sound'  (string)
  info.udi =3D '/org/freedesktop/Hal/devices/pci_1106_3059_sound_card_0=
'  (string)
  linux.hotplug_type =3D 2  (0x2)  (int)
  linux.subsystem =3D 'sound'  (string)
  linux.sysfs_path =3D '/sys/devices/pci0000:00/0000:00:11.5/sound/card=
0'  (string)
  sound.card =3D 0  (0x0)  (int)
  sound.card_id =3D 'VIA 8237 with CMI9761A+'  (string)
  sound.originating_device =3D '/org/freedesktop/Hal/devices/pci_1106_3=
059'  (string)

udi =3D '/org/freedesktop/Hal/devices/pci_1106_3059_sound_card_0_alsa_p=
layback_1'
  alsa.card =3D 0  (0x0)  (int)
  alsa.card_id =3D 'VIA 8237 with CMI9761A+'  (string)
  alsa.device =3D 1  (0x1)  (int)
  alsa.device_file =3D '/dev/snd/pcmC0D1p'  (string)
  alsa.originating_device =3D '/org/freedesktop/Hal/devices/pci_1106_30=
59_sound_card_0'  (string)
  alsa.pcm_class =3D 'generic'  (string)
  alsa.type =3D 'playback'  (string)
  info.capabilities =3D {'alsa'} (string list)
  info.category =3D 'alsa'  (string)
  info.parent =3D '/org/freedesktop/Hal/devices/pci_1106_3059_sound_car=
d_0'  (string)
  info.product =3D 'ALSA Playback Device'  (string)
  info.subsystem =3D 'sound'  (string)
  info.udi =3D '/org/freedesktop/Hal/devices/pci_1106_3059_sound_card_0=
_alsa_playback_1'  (string)
  linux.device_file =3D '/dev/snd/pcmC0D1p'  (string)
  linux.hotplug_type =3D 2  (0x2)  (int)
  linux.subsystem =3D 'sound'  (string)
  linux.sysfs_path =3D '/sys/devices/pci0000:00/0000:00:11.5/sound/card=
0/pcmC0D1p'  (string)

udi =3D '/org/freedesktop/Hal/devices/pci_1106_3059_sound_card_0_alsa_c=
apture_1'
  alsa.card =3D 0  (0x0)  (int)
  alsa.card_id =3D 'VIA 8237 with CMI9761A+'  (string)
  alsa.device =3D 1  (0x1)  (int)
  alsa.device_file =3D '/dev/snd/pcmC0D1c'  (string)
  alsa.originating_device =3D '/org/freedesktop/Hal/devices/pci_1106_30=
59_sound_card_0'  (string)
  alsa.pcm_class =3D 'generic'  (string)
  alsa.type =3D 'capture'  (string)
  info.capabilities =3D {'alsa'} (string list)
  info.category =3D 'alsa'  (string)
  info.parent =3D '/org/freedesktop/Hal/devices/pci_1106_3059_sound_car=
d_0'  (string)
  info.product =3D 'ALSA Capture Device'  (string)
  info.subsystem =3D 'sound'  (string)
  info.udi =3D '/org/freedesktop/Hal/devices/pci_1106_3059_sound_card_0=
_alsa_capture_1'  (string)
  linux.device_file =3D '/dev/snd/pcmC0D1c'  (string)
  linux.hotplug_type =3D 2  (0x2)  (int)
  linux.subsystem =3D 'sound'  (string)
  linux.sysfs_path =3D '/sys/devices/pci0000:00/0000:00:11.5/sound/card=
0/pcmC0D1c'  (string)

udi =3D '/org/freedesktop/Hal/devices/pci_1106_3059_sound_card_0_alsa_p=
layback_0'
  alsa.card =3D 0  (0x0)  (int)
  alsa.card_id =3D 'VIA 8237 with CMI9761A+'  (string)
  alsa.device =3D 0  (0x0)  (int)
  alsa.device_file =3D '/dev/snd/pcmC0D0p'  (string)
  alsa.originating_device =3D '/org/freedesktop/Hal/devices/pci_1106_30=
59_sound_card_0'  (string)
  alsa.pcm_class =3D 'generic'  (string)
  alsa.type =3D 'playback'  (string)
  info.capabilities =3D {'alsa'} (string list)
  info.category =3D 'alsa'  (string)
  info.parent =3D '/org/freedesktop/Hal/devices/pci_1106_3059_sound_car=
d_0'  (string)
  info.product =3D 'ALSA Playback Device'  (string)
  info.subsystem =3D 'sound'  (string)
  info.udi =3D '/org/freedesktop/Hal/devices/pci_1106_3059_sound_card_0=
_alsa_playback_0'  (string)
  linux.device_file =3D '/dev/snd/pcmC0D0p'  (string)
  linux.hotplug_type =3D 2  (0x2)  (int)
  linux.subsystem =3D 'sound'  (string)
  linux.sysfs_path =3D '/sys/devices/pci0000:00/0000:00:11.5/sound/card=
0/pcmC0D0p'  (string)

udi =3D '/org/freedesktop/Hal/devices/pci_1106_3059_sound_card_0_alsa_c=
apture_0'
  alsa.card =3D 0  (0x0)  (int)
  alsa.card_id =3D 'VIA 8237 with CMI9761A+'  (string)
  alsa.device =3D 0  (0x0)  (int)
  alsa.device_file =3D '/dev/snd/pcmC0D0c'  (string)
  alsa.originating_device =3D '/org/freedesktop/Hal/devices/pci_1106_30=
59_sound_card_0'  (string)
  alsa.pcm_class =3D 'generic'  (string)
  alsa.type =3D 'capture'  (string)
  info.capabilities =3D {'alsa'} (string list)
  info.category =3D 'alsa'  (string)
  info.parent =3D '/org/freedesktop/Hal/devices/pci_1106_3059_sound_car=
d_0'  (string)
  info.product =3D 'ALSA Capture Device'  (string)
  info.subsystem =3D 'sound'  (string)
  info.udi =3D '/org/freedesktop/Hal/devices/pci_1106_3059_sound_card_0=
_alsa_capture_0'  (string)
  linux.device_file =3D '/dev/snd/pcmC0D0c'  (string)
  linux.hotplug_type =3D 2  (0x2)  (int)
  linux.subsystem =3D 'sound'  (string)
  linux.sysfs_path =3D '/sys/devices/pci0000:00/0000:00:11.5/sound/card=
0/pcmC0D0c'  (string)

udi =3D '/org/freedesktop/Hal/devices/pci_1106_3059_sound_card_0_alsa_c=
ontrol__1'
  alsa.card =3D 0  (0x0)  (int)
  alsa.card_id =3D 'VIA 8237 with CMI9761A+'  (string)
  alsa.device_file =3D '/dev/snd/controlC0'  (string)
  alsa.originating_device =3D '/org/freedesktop/Hal/devices/pci_1106_30=
59_sound_card_0'  (string)
  alsa.type =3D 'control'  (string)
  info.capabilities =3D {'alsa'} (string list)
  info.category =3D 'alsa'  (string)
  info.parent =3D '/org/freedesktop/Hal/devices/pci_1106_3059_sound_car=
d_0'  (string)
  info.product =3D 'VIA 8237 with CMI9761A+ ALSA Control Device'  (stri=
ng)
  info.subsystem =3D 'sound'  (string)
  info.udi =3D '/org/freedesktop/Hal/devices/pci_1106_3059_sound_card_0=
_alsa_control__1'  (string)
  linux.device_file =3D '/dev/snd/controlC0'  (string)
  linux.hotplug_type =3D 2  (0x2)  (int)
  linux.subsystem =3D 'sound'  (string)
  linux.sysfs_path =3D '/sys/devices/pci0000:00/0000:00:11.5/sound/card=
0/controlC0'  (string)

udi =3D '/org/freedesktop/Hal/devices/pci_1106_3227'
  info.parent =3D '/org/freedesktop/Hal/devices/computer'  (string)
  info.product =3D 'VT8237 ISA bridge [KT600/K8T800/K8T890 South]'  (st=
ring)
  info.subsystem =3D 'pci'  (string)
  info.udi =3D '/org/freedesktop/Hal/devices/pci_1106_3227'  (string)
  info.vendor =3D 'VIA Technologies, Inc.'  (string)
  linux.hotplug_type =3D 2  (0x2)  (int)
  linux.subsystem =3D 'pci'  (string)
  linux.sysfs_path =3D '/sys/devices/pci0000:00/0000:00:11.0'  (string)
  pci.device_class =3D 6  (0x6)  (int)
  pci.device_protocol =3D 0  (0x0)  (int)
  pci.device_subclass =3D 1  (0x1)  (int)
  pci.linux.sysfs_path =3D '/sys/devices/pci0000:00/0000:00:11.0'  (str=
ing)
  pci.product =3D 'VT8237 ISA bridge [KT600/K8T800/K8T890 South]'  (str=
ing)
  pci.product_id =3D 12839  (0x3227)  (int)
  pci.subsys_product =3D 'K7VT4 motherboard'  (string)
  pci.subsys_product_id =3D 12839  (0x3227)  (int)
  pci.subsys_vendor =3D 'ASRock Incorporation'  (string)
  pci.subsys_vendor_id =3D 6217  (0x1849)  (int)
  pci.vendor =3D 'VIA Technologies, Inc.'  (string)
  pci.vendor_id =3D 4358  (0x1106)  (int)

udi =3D '/org/freedesktop/Hal/devices/pci_1106_3104'
  info.linux.driver =3D 'ehci_hcd'  (string)
  info.parent =3D '/org/freedesktop/Hal/devices/computer'  (string)
  info.product =3D 'USB 2.0'  (string)
  info.subsystem =3D 'pci'  (string)
  info.udi =3D '/org/freedesktop/Hal/devices/pci_1106_3104'  (string)
  info.vendor =3D 'VIA Technologies, Inc.'  (string)
  linux.hotplug_type =3D 2  (0x2)  (int)
  linux.subsystem =3D 'pci'  (string)
  linux.sysfs_path =3D '/sys/devices/pci0000:00/0000:00:10.4'  (string)
  pci.device_class =3D 12  (0xc)  (int)
  pci.device_protocol =3D 32  (0x20)  (int)
  pci.device_subclass =3D 3  (0x3)  (int)
  pci.linux.sysfs_path =3D '/sys/devices/pci0000:00/0000:00:10.4'  (str=
ing)
  pci.product =3D 'USB 2.0'  (string)
  pci.product_id =3D 12548  (0x3104)  (int)
  pci.subsys_product =3D 'K7VT6 motherboard'  (string)
  pci.subsys_product_id =3D 12548  (0x3104)  (int)
  pci.subsys_vendor =3D 'ASRock Incorporation'  (string)
  pci.subsys_vendor_id =3D 6217  (0x1849)  (int)
  pci.vendor =3D 'VIA Technologies, Inc.'  (string)
  pci.vendor_id =3D 4358  (0x1106)  (int)

udi =3D '/org/freedesktop/Hal/devices/usb_device_1d6b_2_0000_00_10_4'
  info.linux.driver =3D 'usb'  (string)
  info.parent =3D '/org/freedesktop/Hal/devices/pci_1106_3104'  (string=
)
  info.product =3D '2.0 root hub'  (string)
  info.subsystem =3D 'usb_device'  (string)
  info.udi =3D '/org/freedesktop/Hal/devices/usb_device_1d6b_2_0000_00_=
10_4'  (string)
  info.vendor =3D 'Linux Foundation'  (string)
  linux.device_file =3D '/dev/bus/usb/001/001'  (string)
  linux.hotplug_type =3D 2  (0x2)  (int)
  linux.subsystem =3D 'usb'  (string)
  linux.sysfs_path =3D '/sys/devices/pci0000:00/0000:00:10.4/usb1'  (st=
ring)
  usb_device.bus_number =3D 1  (0x1)  (int)
  usb_device.can_wake_up =3D true  (bool)
  usb_device.configuration_value =3D 1  (0x1)  (int)
  usb_device.device_class =3D 9  (0x9)  (int)
  usb_device.device_protocol =3D 0  (0x0)  (int)
  usb_device.device_revision_bcd =3D 518  (0x206)  (int)
  usb_device.device_subclass =3D 0  (0x0)  (int)
  usb_device.is_self_powered =3D true  (bool)
  usb_device.linux.device_number =3D 1  (0x1)  (int)
  usb_device.linux.sysfs_path =3D '/sys/devices/pci0000:00/0000:00:10.4=
/usb1'  (string)
  usb_device.max_power =3D 0  (0x0)  (int)
  usb_device.num_configurations =3D 1  (0x1)  (int)
  usb_device.num_interfaces =3D 1  (0x1)  (int)
  usb_device.num_ports =3D 8  (0x8)  (int)
  usb_device.product =3D '2.0 root hub'  (string)
  usb_device.product_id =3D 2  (0x2)  (int)
  usb_device.serial =3D '0000:00:10.4'  (string)
  usb_device.speed =3D 480.0 (480) (double)
  usb_device.vendor =3D 'Linux Foundation'  (string)
  usb_device.vendor_id =3D 7531  (0x1d6b)  (int)
  usb_device.version =3D 2.0 (2) (double)

udi =3D '/org/freedesktop/Hal/devices/usb_device_d49_7450_2HB1APLX'
  info.linux.driver =3D 'usb'  (string)
  info.parent =3D '/org/freedesktop/Hal/devices/usb_device_1d6b_2_0000_=
00_10_4'  (string)
  info.product =3D 'Basics Portable'  (string)
  info.subsystem =3D 'usb_device'  (string)
  info.udi =3D '/org/freedesktop/Hal/devices/usb_device_d49_7450_2HB1AP=
LX'  (string)
  info.vendor =3D 'Maxtor'  (string)
  linux.device_file =3D '/dev/bus/usb/001/003'  (string)
  linux.hotplug_type =3D 2  (0x2)  (int)
  linux.subsystem =3D 'usb'  (string)
  linux.sysfs_path =3D '/sys/devices/pci0000:00/0000:00:10.4/usb1/1-3' =
 (string)
  usb_device.bus_number =3D 1  (0x1)  (int)
  usb_device.can_wake_up =3D false  (bool)
  usb_device.configuration_value =3D 1  (0x1)  (int)
  usb_device.device_class =3D 0  (0x0)  (int)
  usb_device.device_protocol =3D 0  (0x0)  (int)
  usb_device.device_revision_bcd =3D 290  (0x122)  (int)
  usb_device.device_subclass =3D 0  (0x0)  (int)
  usb_device.is_self_powered =3D false  (bool)
  usb_device.linux.device_number =3D 3  (0x3)  (int)
  usb_device.linux.sysfs_path =3D '/sys/devices/pci0000:00/0000:00:10.4=
/usb1/1-3'  (string)
  usb_device.max_power =3D 100  (0x64)  (int)
  usb_device.num_configurations =3D 1  (0x1)  (int)
  usb_device.num_interfaces =3D 1  (0x1)  (int)
  usb_device.num_ports =3D 0  (0x0)  (int)
  usb_device.product =3D 'Basics Portable'  (string)
  usb_device.product_id =3D 29776  (0x7450)  (int)
  usb_device.serial =3D '2HB1APLX'  (string)
  usb_device.speed =3D 480.0 (480) (double)
  usb_device.vendor =3D 'Maxtor'  (string)
  usb_device.vendor_id =3D 3401  (0xd49)  (int)
  usb_device.version =3D 2.0 (2) (double)

udi =3D '/org/freedesktop/Hal/devices/usb_device_d49_7450_2HB1APLX_if0'
  info.linux.driver =3D 'usb-storage'  (string)
  info.parent =3D '/org/freedesktop/Hal/devices/usb_device_d49_7450_2HB=
1APLX'  (string)
  info.product =3D 'USB Mass Storage Interface'  (string)
  info.subsystem =3D 'usb'  (string)
  info.udi =3D '/org/freedesktop/Hal/devices/usb_device_d49_7450_2HB1AP=
LX_if0'  (string)
  linux.hotplug_type =3D 2  (0x2)  (int)
  linux.subsystem =3D 'usb'  (string)
  linux.sysfs_path =3D '/sys/devices/pci0000:00/0000:00:10.4/usb1/1-3/1=
-3:1.0'  (string)
  usb.bus_number =3D 1  (0x1)  (int)
  usb.can_wake_up =3D false  (bool)
  usb.configuration_value =3D 1  (0x1)  (int)
  usb.device_class =3D 0  (0x0)  (int)
  usb.device_protocol =3D 0  (0x0)  (int)
  usb.device_revision_bcd =3D 290  (0x122)  (int)
  usb.device_subclass =3D 0  (0x0)  (int)
  usb.interface.class =3D 8  (0x8)  (int)
  usb.interface.number =3D 0  (0x0)  (int)
  usb.interface.protocol =3D 80  (0x50)  (int)
  usb.interface.subclass =3D 6  (0x6)  (int)
  usb.is_self_powered =3D false  (bool)
  usb.linux.device_number =3D 3  (0x3)  (int)
  usb.linux.sysfs_path =3D '/sys/devices/pci0000:00/0000:00:10.4/usb1/1=
-3/1-3:1.0'  (string)
  usb.max_power =3D 100  (0x64)  (int)
  usb.num_configurations =3D 1  (0x1)  (int)
  usb.num_interfaces =3D 1  (0x1)  (int)
  usb.num_ports =3D 0  (0x0)  (int)
  usb.product =3D 'USB Mass Storage Interface'  (string)
  usb.product_id =3D 29776  (0x7450)  (int)
  usb.serial =3D '2HB1APLX'  (string)
  usb.speed =3D 480.0 (480) (double)
  usb.vendor =3D 'Maxtor'  (string)
  usb.vendor_id =3D 3401  (0xd49)  (int)
  usb.version =3D 2.0 (2) (double)

udi =3D '/org/freedesktop/Hal/devices/usb_device_d49_7450_2HB1APLX_if0_=
scsi_host'
  info.capabilities =3D {'scsi_host'} (string list)
  info.category =3D 'scsi_host'  (string)
  info.parent =3D '/org/freedesktop/Hal/devices/usb_device_d49_7450_2HB=
1APLX_if0'  (string)
  info.product =3D 'SCSI Host Adapter'  (string)
  info.subsystem =3D 'scsi_host'  (string)
  info.udi =3D '/org/freedesktop/Hal/devices/usb_device_d49_7450_2HB1AP=
LX_if0_scsi_host'  (string)
  linux.hotplug_type =3D 2  (0x2)  (int)
  linux.subsystem =3D 'scsi_host'  (string)
  linux.sysfs_path =3D '/sys/devices/pci0000:00/0000:00:10.4/usb1/1-3/1=
-3:1.0/host0'  (string)
  scsi_host.host =3D 0  (0x0)  (int)

udi =3D '/org/freedesktop/Hal/devices/usb_device_d49_7450_2HB1APLX_if0_=
scsi_host_scsi_host'
  info.capabilities =3D {'scsi_host'} (string list)
  info.category =3D 'scsi_host'  (string)
  info.parent =3D '/org/freedesktop/Hal/devices/usb_device_d49_7450_2HB=
1APLX_if0_scsi_host'  (string)
  info.product =3D 'SCSI Host Adapter'  (string)
  info.subsystem =3D 'scsi_host'  (string)
  info.udi =3D '/org/freedesktop/Hal/devices/usb_device_d49_7450_2HB1AP=
LX_if0_scsi_host_scsi_host'  (string)
  linux.hotplug_type =3D 2  (0x2)  (int)
  linux.subsystem =3D 'scsi_host'  (string)
  linux.sysfs_path =3D '/sys/devices/pci0000:00/0000:00:10.4/usb1/1-3/1=
-3:1.0/host0/scsi_host/host0'  (string)
  scsi_host.host =3D 0  (0x0)  (int)

udi =3D '/org/freedesktop/Hal/devices/usb_device_d49_7450_2HB1APLX_if0_=
scsi_host_scsi_device_lun0'
  info.linux.driver =3D 'sd'  (string)
  info.parent =3D '/org/freedesktop/Hal/devices/usb_device_d49_7450_2HB=
1APLX_if0_scsi_host'  (string)
  info.product =3D 'SCSI Device'  (string)
  info.subsystem =3D 'scsi'  (string)
  info.udi =3D '/org/freedesktop/Hal/devices/usb_device_d49_7450_2HB1AP=
LX_if0_scsi_host_scsi_device_lun0'  (string)
  linux.hotplug_type =3D 2  (0x2)  (int)
  linux.subsystem =3D 'scsi'  (string)
  linux.sysfs_path =3D '/sys/devices/pci0000:00/0000:00:10.4/usb1/1-3/1=
-3:1.0/host0/target0:0:0/0:0:0:0'  (string)
  scsi.bus =3D 0  (0x0)  (int)
  scsi.host =3D 0  (0x0)  (int)
  scsi.lun =3D 0  (0x0)  (int)
  scsi.model =3D 'Basics Portable'  (string)
  scsi.target =3D 0  (0x0)  (int)
  scsi.type =3D 'disk'  (string)
  scsi.vendor =3D 'Maxtor'  (string)

udi =3D '/org/freedesktop/Hal/devices/usb_device_d49_7450_2HB1APLX_if0_=
scsi_host_scsi_device_lun0_scsi_generic'
  info.capabilities =3D {'scsi_generic'} (string list)
  info.category =3D 'scsi_generic'  (string)
  info.parent =3D '/org/freedesktop/Hal/devices/usb_device_d49_7450_2HB=
1APLX_if0_scsi_host_scsi_device_lun0'  (string)
  info.product =3D 'SCSI Generic Interface'  (string)
  info.subsystem =3D 'scsi_generic'  (string)
  info.udi =3D '/org/freedesktop/Hal/devices/usb_device_d49_7450_2HB1AP=
LX_if0_scsi_host_scsi_device_lun0_scsi_generic'  (string)
  linux.device_file =3D '/dev/sg0'  (string)
  linux.hotplug_type =3D 2  (0x2)  (int)
  linux.subsystem =3D 'scsi_generic'  (string)
  linux.sysfs_path =3D '/sys/devices/pci0000:00/0000:00:10.4/usb1/1-3/1=
-3:1.0/host0/target0:0:0/0:0:0:0/scsi_generic/sg0'  (string)
  scsi_generic.device =3D '/dev/sg0'  (string)

udi =3D '/org/freedesktop/Hal/devices/usb_device_5e3_608_noserial'
  info.linux.driver =3D 'usb'  (string)
  info.parent =3D '/org/freedesktop/Hal/devices/usb_device_1d6b_2_0000_=
00_10_4'  (string)
  info.product =3D 'USB-2.0 4-Port HUB'  (string)
  info.subsystem =3D 'usb_device'  (string)
  info.udi =3D '/org/freedesktop/Hal/devices/usb_device_5e3_608_noseria=
l'  (string)
  info.vendor =3D 'Genesys Logic, Inc.'  (string)
  linux.device_file =3D '/dev/bus/usb/001/002'  (string)
  linux.hotplug_type =3D 2  (0x2)  (int)
  linux.subsystem =3D 'usb'  (string)
  linux.sysfs_path =3D '/sys/devices/pci0000:00/0000:00:10.4/usb1/1-1' =
 (string)
  usb_device.bus_number =3D 1  (0x1)  (int)
  usb_device.can_wake_up =3D true  (bool)
  usb_device.configuration_value =3D 1  (0x1)  (int)
  usb_device.device_class =3D 9  (0x9)  (int)
  usb_device.device_protocol =3D 1  (0x1)  (int)
  usb_device.device_revision_bcd =3D 1794  (0x702)  (int)
  usb_device.device_subclass =3D 0  (0x0)  (int)
  usb_device.is_self_powered =3D true  (bool)
  usb_device.linux.device_number =3D 2  (0x2)  (int)
  usb_device.linux.sysfs_path =3D '/sys/devices/pci0000:00/0000:00:10.4=
/usb1/1-1'  (string)
  usb_device.max_power =3D 100  (0x64)  (int)
  usb_device.num_configurations =3D 1  (0x1)  (int)
  usb_device.num_interfaces =3D 1  (0x1)  (int)
  usb_device.num_ports =3D 4  (0x4)  (int)
  usb_device.product =3D 'USB-2.0 4-Port HUB'  (string)
  usb_device.product_id =3D 1544  (0x608)  (int)
  usb_device.speed =3D 480.0 (480) (double)
  usb_device.vendor =3D 'Genesys Logic, Inc.'  (string)
  usb_device.vendor_id =3D 1507  (0x5e3)  (int)
  usb_device.version =3D 2.0 (2) (double)

udi =3D '/org/freedesktop/Hal/devices/usb_device_5e3_608_noserial_if0'
  info.linux.driver =3D 'hub'  (string)
  info.parent =3D '/org/freedesktop/Hal/devices/usb_device_5e3_608_nose=
rial'  (string)
  info.product =3D 'USB Hub Interface'  (string)
  info.subsystem =3D 'usb'  (string)
  info.udi =3D '/org/freedesktop/Hal/devices/usb_device_5e3_608_noseria=
l_if0'  (string)
  linux.hotplug_type =3D 2  (0x2)  (int)
  linux.subsystem =3D 'usb'  (string)
  linux.sysfs_path =3D '/sys/devices/pci0000:00/0000:00:10.4/usb1/1-1/1=
-1:1.0'  (string)
  usb.bus_number =3D 1  (0x1)  (int)
  usb.can_wake_up =3D true  (bool)
  usb.configuration_value =3D 1  (0x1)  (int)
  usb.device_class =3D 9  (0x9)  (int)
  usb.device_protocol =3D 1  (0x1)  (int)
  usb.device_revision_bcd =3D 1794  (0x702)  (int)
  usb.device_subclass =3D 0  (0x0)  (int)
  usb.interface.class =3D 9  (0x9)  (int)
  usb.interface.number =3D 0  (0x0)  (int)
  usb.interface.protocol =3D 0  (0x0)  (int)
  usb.interface.subclass =3D 0  (0x0)  (int)
  usb.is_self_powered =3D true  (bool)
  usb.linux.device_number =3D 2  (0x2)  (int)
  usb.linux.sysfs_path =3D '/sys/devices/pci0000:00/0000:00:10.4/usb1/1=
-1/1-1:1.0'  (string)
  usb.max_power =3D 100  (0x64)  (int)
  usb.num_configurations =3D 1  (0x1)  (int)
  usb.num_interfaces =3D 1  (0x1)  (int)
  usb.num_ports =3D 4  (0x4)  (int)
  usb.product =3D 'USB Hub Interface'  (string)
  usb.product_id =3D 1544  (0x608)  (int)
  usb.speed =3D 480.0 (480) (double)
  usb.vendor =3D 'Genesys Logic, Inc.'  (string)
  usb.vendor_id =3D 1507  (0x5e3)  (int)
  usb.version =3D 2.0 (2) (double)

udi =3D '/org/freedesktop/Hal/devices/usb_device_1d6b_2_0000_00_10_4_if=
0'
  info.linux.driver =3D 'hub'  (string)
  info.parent =3D '/org/freedesktop/Hal/devices/usb_device_1d6b_2_0000_=
00_10_4'  (string)
  info.product =3D 'USB Hub Interface'  (string)
  info.subsystem =3D 'usb'  (string)
  info.udi =3D '/org/freedesktop/Hal/devices/usb_device_1d6b_2_0000_00_=
10_4_if0'  (string)
  linux.hotplug_type =3D 2  (0x2)  (int)
  linux.subsystem =3D 'usb'  (string)
  linux.sysfs_path =3D '/sys/devices/pci0000:00/0000:00:10.4/usb1/1-0:1=
=2E0'  (string)
  usb.bus_number =3D 1  (0x1)  (int)
  usb.can_wake_up =3D true  (bool)
  usb.configuration_value =3D 1  (0x1)  (int)
  usb.device_class =3D 9  (0x9)  (int)
  usb.device_protocol =3D 0  (0x0)  (int)
  usb.device_revision_bcd =3D 518  (0x206)  (int)
  usb.device_subclass =3D 0  (0x0)  (int)
  usb.interface.class =3D 9  (0x9)  (int)
  usb.interface.number =3D 0  (0x0)  (int)
  usb.interface.protocol =3D 0  (0x0)  (int)
  usb.interface.subclass =3D 0  (0x0)  (int)
  usb.is_self_powered =3D true  (bool)
  usb.linux.device_number =3D 1  (0x1)  (int)
  usb.linux.sysfs_path =3D '/sys/devices/pci0000:00/0000:00:10.4/usb1/1=
-0:1.0'  (string)
  usb.max_power =3D 0  (0x0)  (int)
  usb.num_configurations =3D 1  (0x1)  (int)
  usb.num_interfaces =3D 1  (0x1)  (int)
  usb.num_ports =3D 8  (0x8)  (int)
  usb.product =3D 'USB Hub Interface'  (string)
  usb.product_id =3D 2  (0x2)  (int)
  usb.serial =3D '0000:00:10.4'  (string)
  usb.speed =3D 480.0 (480) (double)
  usb.vendor =3D 'Linux Foundation'  (string)
  usb.vendor_id =3D 7531  (0x1d6b)  (int)
  usb.version =3D 2.0 (2) (double)

udi =3D '/org/freedesktop/Hal/devices/pci_1106_3038_2'
  info.linux.driver =3D 'uhci_hcd'  (string)
  info.parent =3D '/org/freedesktop/Hal/devices/computer'  (string)
  info.product =3D 'VT82xxxxx UHCI USB 1.1 Controller'  (string)
  info.subsystem =3D 'pci'  (string)
  info.udi =3D '/org/freedesktop/Hal/devices/pci_1106_3038_2'  (string)
  info.vendor =3D 'VIA Technologies, Inc.'  (string)
  linux.hotplug_type =3D 2  (0x2)  (int)
  linux.subsystem =3D 'pci'  (string)
  linux.sysfs_path =3D '/sys/devices/pci0000:00/0000:00:10.3'  (string)
  pci.device_class =3D 12  (0xc)  (int)
  pci.device_protocol =3D 0  (0x0)  (int)
  pci.device_subclass =3D 3  (0x3)  (int)
  pci.linux.sysfs_path =3D '/sys/devices/pci0000:00/0000:00:10.3'  (str=
ing)
  pci.product =3D 'VT82xxxxx UHCI USB 1.1 Controller'  (string)
  pci.product_id =3D 12344  (0x3038)  (int)
  pci.subsys_product =3D 'K7VT6'  (string)
  pci.subsys_product_id =3D 12344  (0x3038)  (int)
  pci.subsys_vendor =3D 'ASRock Incorporation'  (string)
  pci.subsys_vendor_id =3D 6217  (0x1849)  (int)
  pci.vendor =3D 'VIA Technologies, Inc.'  (string)
  pci.vendor_id =3D 4358  (0x1106)  (int)

udi =3D '/org/freedesktop/Hal/devices/usb_device_1d6b_1_0000_00_10_3'
  info.linux.driver =3D 'usb'  (string)
  info.parent =3D '/org/freedesktop/Hal/devices/pci_1106_3038_2'  (stri=
ng)
  info.product =3D '1.1 root hub'  (string)
  info.subsystem =3D 'usb_device'  (string)
  info.udi =3D '/org/freedesktop/Hal/devices/usb_device_1d6b_1_0000_00_=
10_3'  (string)
  info.vendor =3D 'Linux Foundation'  (string)
  linux.device_file =3D '/dev/bus/usb/005/001'  (string)
  linux.hotplug_type =3D 2  (0x2)  (int)
  linux.subsystem =3D 'usb'  (string)
  linux.sysfs_path =3D '/sys/devices/pci0000:00/0000:00:10.3/usb5'  (st=
ring)
  usb_device.bus_number =3D 5  (0x5)  (int)
  usb_device.can_wake_up =3D true  (bool)
  usb_device.configuration_value =3D 1  (0x1)  (int)
  usb_device.device_class =3D 9  (0x9)  (int)
  usb_device.device_protocol =3D 0  (0x0)  (int)
  usb_device.device_revision_bcd =3D 518  (0x206)  (int)
  usb_device.device_subclass =3D 0  (0x0)  (int)
  usb_device.is_self_powered =3D true  (bool)
  usb_device.linux.device_number =3D 1  (0x1)  (int)
  usb_device.linux.sysfs_path =3D '/sys/devices/pci0000:00/0000:00:10.3=
/usb5'  (string)
  usb_device.max_power =3D 0  (0x0)  (int)
  usb_device.num_configurations =3D 1  (0x1)  (int)
  usb_device.num_interfaces =3D 1  (0x1)  (int)
  usb_device.num_ports =3D 2  (0x2)  (int)
  usb_device.product =3D '1.1 root hub'  (string)
  usb_device.product_id =3D 1  (0x1)  (int)
  usb_device.serial =3D '0000:00:10.3'  (string)
  usb_device.speed =3D 12.0 (12) (double)
  usb_device.vendor =3D 'Linux Foundation'  (string)
  usb_device.vendor_id =3D 7531  (0x1d6b)  (int)
  usb_device.version =3D 1.1 (1.1) (double)

udi =3D '/org/freedesktop/Hal/devices/usb_device_1d6b_1_0000_00_10_3_if=
0'
  info.linux.driver =3D 'hub'  (string)
  info.parent =3D '/org/freedesktop/Hal/devices/usb_device_1d6b_1_0000_=
00_10_3'  (string)
  info.product =3D 'USB Hub Interface'  (string)
  info.subsystem =3D 'usb'  (string)
  info.udi =3D '/org/freedesktop/Hal/devices/usb_device_1d6b_1_0000_00_=
10_3_if0'  (string)
  linux.hotplug_type =3D 2  (0x2)  (int)
  linux.subsystem =3D 'usb'  (string)
  linux.sysfs_path =3D '/sys/devices/pci0000:00/0000:00:10.3/usb5/5-0:1=
=2E0'  (string)
  usb.bus_number =3D 5  (0x5)  (int)
  usb.can_wake_up =3D true  (bool)
  usb.configuration_value =3D 1  (0x1)  (int)
  usb.device_class =3D 9  (0x9)  (int)
  usb.device_protocol =3D 0  (0x0)  (int)
  usb.device_revision_bcd =3D 518  (0x206)  (int)
  usb.device_subclass =3D 0  (0x0)  (int)
  usb.interface.class =3D 9  (0x9)  (int)
  usb.interface.number =3D 0  (0x0)  (int)
  usb.interface.protocol =3D 0  (0x0)  (int)
  usb.interface.subclass =3D 0  (0x0)  (int)
  usb.is_self_powered =3D true  (bool)
  usb.linux.device_number =3D 1  (0x1)  (int)
  usb.linux.sysfs_path =3D '/sys/devices/pci0000:00/0000:00:10.3/usb5/5=
-0:1.0'  (string)
  usb.max_power =3D 0  (0x0)  (int)
  usb.num_configurations =3D 1  (0x1)  (int)
  usb.num_interfaces =3D 1  (0x1)  (int)
  usb.num_ports =3D 2  (0x2)  (int)
  usb.product =3D 'USB Hub Interface'  (string)
  usb.product_id =3D 1  (0x1)  (int)
  usb.serial =3D '0000:00:10.3'  (string)
  usb.speed =3D 12.0 (12) (double)
  usb.vendor =3D 'Linux Foundation'  (string)
  usb.vendor_id =3D 7531  (0x1d6b)  (int)
  usb.version =3D 1.1 (1.1) (double)

udi =3D '/org/freedesktop/Hal/devices/pci_1106_3038_1'
  info.linux.driver =3D 'uhci_hcd'  (string)
  info.parent =3D '/org/freedesktop/Hal/devices/computer'  (string)
  info.product =3D 'VT82xxxxx UHCI USB 1.1 Controller'  (string)
  info.subsystem =3D 'pci'  (string)
  info.udi =3D '/org/freedesktop/Hal/devices/pci_1106_3038_1'  (string)
  info.vendor =3D 'VIA Technologies, Inc.'  (string)
  linux.hotplug_type =3D 2  (0x2)  (int)
  linux.subsystem =3D 'pci'  (string)
  linux.sysfs_path =3D '/sys/devices/pci0000:00/0000:00:10.2'  (string)
  pci.device_class =3D 12  (0xc)  (int)
  pci.device_protocol =3D 0  (0x0)  (int)
  pci.device_subclass =3D 3  (0x3)  (int)
  pci.linux.sysfs_path =3D '/sys/devices/pci0000:00/0000:00:10.2'  (str=
ing)
  pci.product =3D 'VT82xxxxx UHCI USB 1.1 Controller'  (string)
  pci.product_id =3D 12344  (0x3038)  (int)
  pci.subsys_product =3D 'K7VT6'  (string)
  pci.subsys_product_id =3D 12344  (0x3038)  (int)
  pci.subsys_vendor =3D 'ASRock Incorporation'  (string)
  pci.subsys_vendor_id =3D 6217  (0x1849)  (int)
  pci.vendor =3D 'VIA Technologies, Inc.'  (string)
  pci.vendor_id =3D 4358  (0x1106)  (int)

udi =3D '/org/freedesktop/Hal/devices/usb_device_1d6b_1_0000_00_10_2'
  info.linux.driver =3D 'usb'  (string)
  info.parent =3D '/org/freedesktop/Hal/devices/pci_1106_3038_1'  (stri=
ng)
  info.product =3D '1.1 root hub'  (string)
  info.subsystem =3D 'usb_device'  (string)
  info.udi =3D '/org/freedesktop/Hal/devices/usb_device_1d6b_1_0000_00_=
10_2'  (string)
  info.vendor =3D 'Linux Foundation'  (string)
  linux.device_file =3D '/dev/bus/usb/004/001'  (string)
  linux.hotplug_type =3D 2  (0x2)  (int)
  linux.subsystem =3D 'usb'  (string)
  linux.sysfs_path =3D '/sys/devices/pci0000:00/0000:00:10.2/usb4'  (st=
ring)
  usb_device.bus_number =3D 4  (0x4)  (int)
  usb_device.can_wake_up =3D true  (bool)
  usb_device.configuration_value =3D 1  (0x1)  (int)
  usb_device.device_class =3D 9  (0x9)  (int)
  usb_device.device_protocol =3D 0  (0x0)  (int)
  usb_device.device_revision_bcd =3D 518  (0x206)  (int)
  usb_device.device_subclass =3D 0  (0x0)  (int)
  usb_device.is_self_powered =3D true  (bool)
  usb_device.linux.device_number =3D 1  (0x1)  (int)
  usb_device.linux.sysfs_path =3D '/sys/devices/pci0000:00/0000:00:10.2=
/usb4'  (string)
  usb_device.max_power =3D 0  (0x0)  (int)
  usb_device.num_configurations =3D 1  (0x1)  (int)
  usb_device.num_interfaces =3D 1  (0x1)  (int)
  usb_device.num_ports =3D 2  (0x2)  (int)
  usb_device.product =3D '1.1 root hub'  (string)
  usb_device.product_id =3D 1  (0x1)  (int)
  usb_device.serial =3D '0000:00:10.2'  (string)
  usb_device.speed =3D 12.0 (12) (double)
  usb_device.vendor =3D 'Linux Foundation'  (string)
  usb_device.vendor_id =3D 7531  (0x1d6b)  (int)
  usb_device.version =3D 1.1 (1.1) (double)

udi =3D '/org/freedesktop/Hal/devices/usb_device_41e_401c_noserial'
  info.linux.driver =3D 'usb'  (string)
  info.parent =3D '/org/freedesktop/Hal/devices/usb_device_1d6b_1_0000_=
00_10_2'  (string)
  info.product =3D 'Webcam NX [PD1110]'  (string)
  info.subsystem =3D 'usb_device'  (string)
  info.udi =3D '/org/freedesktop/Hal/devices/usb_device_41e_401c_noseri=
al'  (string)
  info.vendor =3D 'Creative Technology, Ltd'  (string)
  linux.device_file =3D '/dev/bus/usb/004/003'  (string)
  linux.hotplug_type =3D 2  (0x2)  (int)
  linux.subsystem =3D 'usb'  (string)
  linux.sysfs_path =3D '/sys/devices/pci0000:00/0000:00:10.2/usb4/4-2' =
 (string)
  usb_device.bus_number =3D 4  (0x4)  (int)
  usb_device.can_wake_up =3D false  (bool)
  usb_device.configuration_value =3D 1  (0x1)  (int)
  usb_device.device_class =3D 255  (0xff)  (int)
  usb_device.device_protocol =3D 0  (0x0)  (int)
  usb_device.device_revision_bcd =3D 256  (0x100)  (int)
  usb_device.device_subclass =3D 0  (0x0)  (int)
  usb_device.is_self_powered =3D false  (bool)
  usb_device.linux.device_number =3D 3  (0x3)  (int)
  usb_device.linux.sysfs_path =3D '/sys/devices/pci0000:00/0000:00:10.2=
/usb4/4-2'  (string)
  usb_device.max_power =3D 80  (0x50)  (int)
  usb_device.num_configurations =3D 1  (0x1)  (int)
  usb_device.num_interfaces =3D 1  (0x1)  (int)
  usb_device.num_ports =3D 0  (0x0)  (int)
  usb_device.product =3D 'Webcam NX [PD1110]'  (string)
  usb_device.product_id =3D 16412  (0x401c)  (int)
  usb_device.speed =3D 12.0 (12) (double)
  usb_device.vendor =3D 'Creative Technology, Ltd'  (string)
  usb_device.vendor_id =3D 1054  (0x41e)  (int)
  usb_device.version =3D 1.1 (1.1) (double)

udi =3D '/org/freedesktop/Hal/devices/usb_device_41e_401c_noserial_if0'
  info.linux.driver =3D 'zc3xx'  (string)
  info.parent =3D '/org/freedesktop/Hal/devices/usb_device_41e_401c_nos=
erial'  (string)
  info.product =3D 'USB Vendor Specific Interface'  (string)
  info.subsystem =3D 'usb'  (string)
  info.udi =3D '/org/freedesktop/Hal/devices/usb_device_41e_401c_noseri=
al_if0'  (string)
  linux.hotplug_type =3D 2  (0x2)  (int)
  linux.subsystem =3D 'usb'  (string)
  linux.sysfs_path =3D '/sys/devices/pci0000:00/0000:00:10.2/usb4/4-2/4=
-2:1.0'  (string)
  usb.bus_number =3D 4  (0x4)  (int)
  usb.can_wake_up =3D false  (bool)
  usb.configuration_value =3D 1  (0x1)  (int)
  usb.device_class =3D 255  (0xff)  (int)
  usb.device_protocol =3D 0  (0x0)  (int)
  usb.device_revision_bcd =3D 256  (0x100)  (int)
  usb.device_subclass =3D 0  (0x0)  (int)
  usb.interface.class =3D 255  (0xff)  (int)
  usb.interface.number =3D 0  (0x0)  (int)
  usb.interface.protocol =3D 255  (0xff)  (int)
  usb.interface.subclass =3D 255  (0xff)  (int)
  usb.is_self_powered =3D false  (bool)
  usb.linux.device_number =3D 3  (0x3)  (int)
  usb.linux.sysfs_path =3D '/sys/devices/pci0000:00/0000:00:10.2/usb4/4=
-2/4-2:1.0'  (string)
  usb.max_power =3D 80  (0x50)  (int)
  usb.num_configurations =3D 1  (0x1)  (int)
  usb.num_interfaces =3D 1  (0x1)  (int)
  usb.num_ports =3D 0  (0x0)  (int)
  usb.product =3D 'USB Vendor Specific Interface'  (string)
  usb.product_id =3D 16412  (0x401c)  (int)
  usb.speed =3D 12.0 (12) (double)
  usb.vendor =3D 'Creative Technology, Ltd'  (string)
  usb.vendor_id =3D 1054  (0x41e)  (int)
  usb.version =3D 1.1 (1.1) (double)

udi =3D '/org/freedesktop/Hal/devices/usb_device_41e_401c_noserial_if0_=
video4linux'
  info.capabilities =3D {'video4linux', 'video4linux.video_capture'} (s=
tring list)
  info.category =3D 'video4linux'  (string)
  info.parent =3D '/org/freedesktop/Hal/devices/usb_device_41e_401c_nos=
erial_if0'  (string)
  info.product =3D 'USB Camera (041e:401c)'  (string)
  info.subsystem =3D 'video4linux'  (string)
  info.udi =3D '/org/freedesktop/Hal/devices/usb_device_41e_401c_noseri=
al_if0_video4linux'  (string)
  linux.device_file =3D '/dev/video0'  (string)
  linux.hotplug_type =3D 2  (0x2)  (int)
  linux.subsystem =3D 'video4linux'  (string)
  linux.sysfs_path =3D '/sys/devices/pci0000:00/0000:00:10.2/usb4/4-2/4=
-2:1.0/video4linux/video0'  (string)
  video4linux.device =3D '/dev/video0'  (string)
  video4linux.version =3D '1'  (string)

udi =3D '/org/freedesktop/Hal/devices/usb_device_45e_dd_noserial'
  info.linux.driver =3D 'usb'  (string)
  info.parent =3D '/org/freedesktop/Hal/devices/usb_device_1d6b_1_0000_=
00_10_2'  (string)
  info.product =3D 'Comfort Curve Keyboard 2000'  (string)
  info.subsystem =3D 'usb_device'  (string)
  info.udi =3D '/org/freedesktop/Hal/devices/usb_device_45e_dd_noserial=
'  (string)
  info.vendor =3D 'Microsoft Corp.'  (string)
  linux.device_file =3D '/dev/bus/usb/004/002'  (string)
  linux.hotplug_type =3D 2  (0x2)  (int)
  linux.subsystem =3D 'usb'  (string)
  linux.sysfs_path =3D '/sys/devices/pci0000:00/0000:00:10.2/usb4/4-1' =
 (string)
  usb_device.bus_number =3D 4  (0x4)  (int)
  usb_device.can_wake_up =3D true  (bool)
  usb_device.configuration_value =3D 1  (0x1)  (int)
  usb_device.device_class =3D 0  (0x0)  (int)
  usb_device.device_protocol =3D 0  (0x0)  (int)
  usb_device.device_revision_bcd =3D 371  (0x173)  (int)
  usb_device.device_subclass =3D 0  (0x0)  (int)
  usb_device.is_self_powered =3D false  (bool)
  usb_device.linux.device_number =3D 2  (0x2)  (int)
  usb_device.linux.sysfs_path =3D '/sys/devices/pci0000:00/0000:00:10.2=
/usb4/4-1'  (string)
  usb_device.max_power =3D 100  (0x64)  (int)
  usb_device.num_configurations =3D 1  (0x1)  (int)
  usb_device.num_interfaces =3D 2  (0x2)  (int)
  usb_device.num_ports =3D 0  (0x0)  (int)
  usb_device.product =3D 'Comfort Curve Keyboard 2000'  (string)
  usb_device.product_id =3D 221  (0xdd)  (int)
  usb_device.speed =3D 1.5 (1.5) (double)
  usb_device.vendor =3D 'Microsoft Corp.'  (string)
  usb_device.vendor_id =3D 1118  (0x45e)  (int)
  usb_device.version =3D 2.0 (2) (double)

udi =3D '/org/freedesktop/Hal/devices/usb_device_45e_dd_noserial_if1'
  info.linux.driver =3D 'usbhid'  (string)
  info.parent =3D '/org/freedesktop/Hal/devices/usb_device_45e_dd_noser=
ial'  (string)
  info.product =3D 'USB HID Interface'  (string)
  info.subsystem =3D 'usb'  (string)
  info.udi =3D '/org/freedesktop/Hal/devices/usb_device_45e_dd_noserial=
_if1'  (string)
  linux.hotplug_type =3D 2  (0x2)  (int)
  linux.subsystem =3D 'usb'  (string)
  linux.sysfs_path =3D '/sys/devices/pci0000:00/0000:00:10.2/usb4/4-1/4=
-1:1.1'  (string)
  usb.bus_number =3D 4  (0x4)  (int)
  usb.can_wake_up =3D true  (bool)
  usb.configuration_value =3D 1  (0x1)  (int)
  usb.device_class =3D 0  (0x0)  (int)
  usb.device_protocol =3D 0  (0x0)  (int)
  usb.device_revision_bcd =3D 371  (0x173)  (int)
  usb.device_subclass =3D 0  (0x0)  (int)
  usb.interface.class =3D 3  (0x3)  (int)
  usb.interface.number =3D 1  (0x1)  (int)
  usb.interface.protocol =3D 0  (0x0)  (int)
  usb.interface.subclass =3D 0  (0x0)  (int)
  usb.is_self_powered =3D false  (bool)
  usb.linux.device_number =3D 2  (0x2)  (int)
  usb.linux.sysfs_path =3D '/sys/devices/pci0000:00/0000:00:10.2/usb4/4=
-1/4-1:1.1'  (string)
  usb.max_power =3D 100  (0x64)  (int)
  usb.num_configurations =3D 1  (0x1)  (int)
  usb.num_interfaces =3D 2  (0x2)  (int)
  usb.num_ports =3D 0  (0x0)  (int)
  usb.product =3D 'USB HID Interface'  (string)
  usb.product_id =3D 221  (0xdd)  (int)
  usb.speed =3D 1.5 (1.5) (double)
  usb.vendor =3D 'Microsoft Corp.'  (string)
  usb.vendor_id =3D 1118  (0x45e)  (int)
  usb.version =3D 2.0 (2) (double)

udi =3D '/org/freedesktop/Hal/devices/usb_device_45e_dd_noserial_if1_lo=
gicaldev_input'
  info.addons.singleton =3D {'hald-addon-input'} (string list)
  info.capabilities =3D {'input', 'input.keyboard', 'input.keypad', 'in=
put.keys', 'button'} (string list)
  info.category =3D 'input'  (string)
  info.parent =3D '/org/freedesktop/Hal/devices/usb_device_45e_dd_noser=
ial_if1'  (string)
  info.product =3D 'Microsoft Comfort Curve Keyboard 2000'  (string)
  info.subsystem =3D 'input'  (string)
  info.udi =3D '/org/freedesktop/Hal/devices/usb_device_45e_dd_noserial=
_if1_logicaldev_input'  (string)
  input.device =3D '/dev/input/event6'  (string)
  input.originating_device =3D '/org/freedesktop/Hal/devices/usb_device=
_45e_dd_noserial_if1'  (string)
  input.product =3D 'Microsoft Comfort Curve Keyboard 2000'  (string)
  input.x11_driver =3D 'evdev'  (string)
  input.xkb.layout =3D 'us'  (string)
  input.xkb.model =3D 'evdev'  (string)
  input.xkb.options =3D 'compose:rwin'  (string)
  input.xkb.rules =3D 'xorg'  (string)
  input.xkb.variant =3D ''  (string)
  linux.device_file =3D '/dev/input/event6'  (string)
  linux.hotplug_type =3D 2  (0x2)  (int)
  linux.subsystem =3D 'input'  (string)
  linux.sysfs_path =3D '/sys/devices/pci0000:00/0000:00:10.2/usb4/4-1/4=
-1:1.1/input/input6/event6'  (string)

udi =3D '/org/freedesktop/Hal/devices/usb_device_45e_dd_noserial_if0'
  info.linux.driver =3D 'usbhid'  (string)
  info.parent =3D '/org/freedesktop/Hal/devices/usb_device_45e_dd_noser=
ial'  (string)
  info.product =3D 'USB HID Interface'  (string)
  info.subsystem =3D 'usb'  (string)
  info.udi =3D '/org/freedesktop/Hal/devices/usb_device_45e_dd_noserial=
_if0'  (string)
  linux.hotplug_type =3D 2  (0x2)  (int)
  linux.subsystem =3D 'usb'  (string)
  linux.sysfs_path =3D '/sys/devices/pci0000:00/0000:00:10.2/usb4/4-1/4=
-1:1.0'  (string)
  usb.bus_number =3D 4  (0x4)  (int)
  usb.can_wake_up =3D true  (bool)
  usb.configuration_value =3D 1  (0x1)  (int)
  usb.device_class =3D 0  (0x0)  (int)
  usb.device_protocol =3D 0  (0x0)  (int)
  usb.device_revision_bcd =3D 371  (0x173)  (int)
  usb.device_subclass =3D 0  (0x0)  (int)
  usb.interface.class =3D 3  (0x3)  (int)
  usb.interface.number =3D 0  (0x0)  (int)
  usb.interface.protocol =3D 1  (0x1)  (int)
  usb.interface.subclass =3D 1  (0x1)  (int)
  usb.is_self_powered =3D false  (bool)
  usb.linux.device_number =3D 2  (0x2)  (int)
  usb.linux.sysfs_path =3D '/sys/devices/pci0000:00/0000:00:10.2/usb4/4=
-1/4-1:1.0'  (string)
  usb.max_power =3D 100  (0x64)  (int)
  usb.num_configurations =3D 1  (0x1)  (int)
  usb.num_interfaces =3D 2  (0x2)  (int)
  usb.num_ports =3D 0  (0x0)  (int)
  usb.product =3D 'USB HID Interface'  (string)
  usb.product_id =3D 221  (0xdd)  (int)
  usb.speed =3D 1.5 (1.5) (double)
  usb.vendor =3D 'Microsoft Corp.'  (string)
  usb.vendor_id =3D 1118  (0x45e)  (int)
  usb.version =3D 2.0 (2) (double)

udi =3D '/org/freedesktop/Hal/devices/usb_device_45e_dd_noserial_if0_lo=
gicaldev_input'
  info.addons.singleton =3D {'hald-addon-input'} (string list)
  info.capabilities =3D {'input', 'input.keyboard', 'input.keypad', 'in=
put.keys', 'button'} (string list)
  info.category =3D 'input'  (string)
  info.parent =3D '/org/freedesktop/Hal/devices/usb_device_45e_dd_noser=
ial_if0'  (string)
  info.product =3D 'Microsoft Comfort Curve Keyboard 2000'  (string)
  info.subsystem =3D 'input'  (string)
  info.udi =3D '/org/freedesktop/Hal/devices/usb_device_45e_dd_noserial=
_if0_logicaldev_input'  (string)
  input.device =3D '/dev/input/event5'  (string)
  input.originating_device =3D '/org/freedesktop/Hal/devices/usb_device=
_45e_dd_noserial_if0'  (string)
  input.product =3D 'Microsoft Comfort Curve Keyboard 2000'  (string)
  input.x11_driver =3D 'evdev'  (string)
  input.xkb.layout =3D 'us'  (string)
  input.xkb.model =3D 'evdev'  (string)
  input.xkb.options =3D 'compose:rwin'  (string)
  input.xkb.rules =3D 'xorg'  (string)
  input.xkb.variant =3D ''  (string)
  linux.device_file =3D '/dev/input/event5'  (string)
  linux.hotplug_type =3D 2  (0x2)  (int)
  linux.subsystem =3D 'input'  (string)
  linux.sysfs_path =3D '/sys/devices/pci0000:00/0000:00:10.2/usb4/4-1/4=
-1:1.0/input/input5/event5'  (string)

udi =3D '/org/freedesktop/Hal/devices/usb_device_1d6b_1_0000_00_10_2_if=
0'
  info.linux.driver =3D 'hub'  (string)
  info.parent =3D '/org/freedesktop/Hal/devices/usb_device_1d6b_1_0000_=
00_10_2'  (string)
  info.product =3D 'USB Hub Interface'  (string)
  info.subsystem =3D 'usb'  (string)
  info.udi =3D '/org/freedesktop/Hal/devices/usb_device_1d6b_1_0000_00_=
10_2_if0'  (string)
  linux.hotplug_type =3D 2  (0x2)  (int)
  linux.subsystem =3D 'usb'  (string)
  linux.sysfs_path =3D '/sys/devices/pci0000:00/0000:00:10.2/usb4/4-0:1=
=2E0'  (string)
  usb.bus_number =3D 4  (0x4)  (int)
  usb.can_wake_up =3D true  (bool)
  usb.configuration_value =3D 1  (0x1)  (int)
  usb.device_class =3D 9  (0x9)  (int)
  usb.device_protocol =3D 0  (0x0)  (int)
  usb.device_revision_bcd =3D 518  (0x206)  (int)
  usb.device_subclass =3D 0  (0x0)  (int)
  usb.interface.class =3D 9  (0x9)  (int)
  usb.interface.number =3D 0  (0x0)  (int)
  usb.interface.protocol =3D 0  (0x0)  (int)
  usb.interface.subclass =3D 0  (0x0)  (int)
  usb.is_self_powered =3D true  (bool)
  usb.linux.device_number =3D 1  (0x1)  (int)
  usb.linux.sysfs_path =3D '/sys/devices/pci0000:00/0000:00:10.2/usb4/4=
-0:1.0'  (string)
  usb.max_power =3D 0  (0x0)  (int)
  usb.num_configurations =3D 1  (0x1)  (int)
  usb.num_interfaces =3D 1  (0x1)  (int)
  usb.num_ports =3D 2  (0x2)  (int)
  usb.product =3D 'USB Hub Interface'  (string)
  usb.product_id =3D 1  (0x1)  (int)
  usb.serial =3D '0000:00:10.2'  (string)
  usb.speed =3D 12.0 (12) (double)
  usb.vendor =3D 'Linux Foundation'  (string)
  usb.vendor_id =3D 7531  (0x1d6b)  (int)
  usb.version =3D 1.1 (1.1) (double)

udi =3D '/org/freedesktop/Hal/devices/pci_1106_3038_0'
  info.linux.driver =3D 'uhci_hcd'  (string)
  info.parent =3D '/org/freedesktop/Hal/devices/computer'  (string)
  info.product =3D 'VT82xxxxx UHCI USB 1.1 Controller'  (string)
  info.subsystem =3D 'pci'  (string)
  info.udi =3D '/org/freedesktop/Hal/devices/pci_1106_3038_0'  (string)
  info.vendor =3D 'VIA Technologies, Inc.'  (string)
  linux.hotplug_type =3D 2  (0x2)  (int)
  linux.subsystem =3D 'pci'  (string)
  linux.sysfs_path =3D '/sys/devices/pci0000:00/0000:00:10.1'  (string)
  pci.device_class =3D 12  (0xc)  (int)
  pci.device_protocol =3D 0  (0x0)  (int)
  pci.device_subclass =3D 3  (0x3)  (int)
  pci.linux.sysfs_path =3D '/sys/devices/pci0000:00/0000:00:10.1'  (str=
ing)
  pci.product =3D 'VT82xxxxx UHCI USB 1.1 Controller'  (string)
  pci.product_id =3D 12344  (0x3038)  (int)
  pci.subsys_product =3D 'K7VT6'  (string)
  pci.subsys_product_id =3D 12344  (0x3038)  (int)
  pci.subsys_vendor =3D 'ASRock Incorporation'  (string)
  pci.subsys_vendor_id =3D 6217  (0x1849)  (int)
  pci.vendor =3D 'VIA Technologies, Inc.'  (string)
  pci.vendor_id =3D 4358  (0x1106)  (int)

udi =3D '/org/freedesktop/Hal/devices/usb_device_1d6b_1_0000_00_10_1'
  info.linux.driver =3D 'usb'  (string)
  info.parent =3D '/org/freedesktop/Hal/devices/pci_1106_3038_0'  (stri=
ng)
  info.product =3D '1.1 root hub'  (string)
  info.subsystem =3D 'usb_device'  (string)
  info.udi =3D '/org/freedesktop/Hal/devices/usb_device_1d6b_1_0000_00_=
10_1'  (string)
  info.vendor =3D 'Linux Foundation'  (string)
  linux.device_file =3D '/dev/bus/usb/003/001'  (string)
  linux.hotplug_type =3D 2  (0x2)  (int)
  linux.subsystem =3D 'usb'  (string)
  linux.sysfs_path =3D '/sys/devices/pci0000:00/0000:00:10.1/usb3'  (st=
ring)
  usb_device.bus_number =3D 3  (0x3)  (int)
  usb_device.can_wake_up =3D true  (bool)
  usb_device.configuration_value =3D 1  (0x1)  (int)
  usb_device.device_class =3D 9  (0x9)  (int)
  usb_device.device_protocol =3D 0  (0x0)  (int)
  usb_device.device_revision_bcd =3D 518  (0x206)  (int)
  usb_device.device_subclass =3D 0  (0x0)  (int)
  usb_device.is_self_powered =3D true  (bool)
  usb_device.linux.device_number =3D 1  (0x1)  (int)
  usb_device.linux.sysfs_path =3D '/sys/devices/pci0000:00/0000:00:10.1=
/usb3'  (string)
  usb_device.max_power =3D 0  (0x0)  (int)
  usb_device.num_configurations =3D 1  (0x1)  (int)
  usb_device.num_interfaces =3D 1  (0x1)  (int)
  usb_device.num_ports =3D 2  (0x2)  (int)
  usb_device.product =3D '1.1 root hub'  (string)
  usb_device.product_id =3D 1  (0x1)  (int)
  usb_device.serial =3D '0000:00:10.1'  (string)
  usb_device.speed =3D 12.0 (12) (double)
  usb_device.vendor =3D 'Linux Foundation'  (string)
  usb_device.vendor_id =3D 7531  (0x1d6b)  (int)
  usb_device.version =3D 1.1 (1.1) (double)

udi =3D '/org/freedesktop/Hal/devices/usb_device_1d6b_1_0000_00_10_1_if=
0'
  info.linux.driver =3D 'hub'  (string)
  info.parent =3D '/org/freedesktop/Hal/devices/usb_device_1d6b_1_0000_=
00_10_1'  (string)
  info.product =3D 'USB Hub Interface'  (string)
  info.subsystem =3D 'usb'  (string)
  info.udi =3D '/org/freedesktop/Hal/devices/usb_device_1d6b_1_0000_00_=
10_1_if0'  (string)
  linux.hotplug_type =3D 2  (0x2)  (int)
  linux.subsystem =3D 'usb'  (string)
  linux.sysfs_path =3D '/sys/devices/pci0000:00/0000:00:10.1/usb3/3-0:1=
=2E0'  (string)
  usb.bus_number =3D 3  (0x3)  (int)
  usb.can_wake_up =3D true  (bool)
  usb.configuration_value =3D 1  (0x1)  (int)
  usb.device_class =3D 9  (0x9)  (int)
  usb.device_protocol =3D 0  (0x0)  (int)
  usb.device_revision_bcd =3D 518  (0x206)  (int)
  usb.device_subclass =3D 0  (0x0)  (int)
  usb.interface.class =3D 9  (0x9)  (int)
  usb.interface.number =3D 0  (0x0)  (int)
  usb.interface.protocol =3D 0  (0x0)  (int)
  usb.interface.subclass =3D 0  (0x0)  (int)
  usb.is_self_powered =3D true  (bool)
  usb.linux.device_number =3D 1  (0x1)  (int)
  usb.linux.sysfs_path =3D '/sys/devices/pci0000:00/0000:00:10.1/usb3/3=
-0:1.0'  (string)
  usb.max_power =3D 0  (0x0)  (int)
  usb.num_configurations =3D 1  (0x1)  (int)
  usb.num_interfaces =3D 1  (0x1)  (int)
  usb.num_ports =3D 2  (0x2)  (int)
  usb.product =3D 'USB Hub Interface'  (string)
  usb.product_id =3D 1  (0x1)  (int)
  usb.serial =3D '0000:00:10.1'  (string)
  usb.speed =3D 12.0 (12) (double)
  usb.vendor =3D 'Linux Foundation'  (string)
  usb.vendor_id =3D 7531  (0x1d6b)  (int)
  usb.version =3D 1.1 (1.1) (double)

udi =3D '/org/freedesktop/Hal/devices/pci_1106_3038'
  info.linux.driver =3D 'uhci_hcd'  (string)
  info.parent =3D '/org/freedesktop/Hal/devices/computer'  (string)
  info.product =3D 'VT82xxxxx UHCI USB 1.1 Controller'  (string)
  info.subsystem =3D 'pci'  (string)
  info.udi =3D '/org/freedesktop/Hal/devices/pci_1106_3038'  (string)
  info.vendor =3D 'VIA Technologies, Inc.'  (string)
  linux.hotplug_type =3D 2  (0x2)  (int)
  linux.subsystem =3D 'pci'  (string)
  linux.sysfs_path =3D '/sys/devices/pci0000:00/0000:00:10.0'  (string)
  pci.device_class =3D 12  (0xc)  (int)
  pci.device_protocol =3D 0  (0x0)  (int)
  pci.device_subclass =3D 3  (0x3)  (int)
  pci.linux.sysfs_path =3D '/sys/devices/pci0000:00/0000:00:10.0'  (str=
ing)
  pci.product =3D 'VT82xxxxx UHCI USB 1.1 Controller'  (string)
  pci.product_id =3D 12344  (0x3038)  (int)
  pci.subsys_product =3D 'K7VT6'  (string)
  pci.subsys_product_id =3D 12344  (0x3038)  (int)
  pci.subsys_vendor =3D 'ASRock Incorporation'  (string)
  pci.subsys_vendor_id =3D 6217  (0x1849)  (int)
  pci.vendor =3D 'VIA Technologies, Inc.'  (string)
  pci.vendor_id =3D 4358  (0x1106)  (int)

udi =3D '/org/freedesktop/Hal/devices/usb_device_1d6b_1_0000_00_10_0'
  info.linux.driver =3D 'usb'  (string)
  info.parent =3D '/org/freedesktop/Hal/devices/pci_1106_3038'  (string=
)
  info.product =3D '1.1 root hub'  (string)
  info.subsystem =3D 'usb_device'  (string)
  info.udi =3D '/org/freedesktop/Hal/devices/usb_device_1d6b_1_0000_00_=
10_0'  (string)
  info.vendor =3D 'Linux Foundation'  (string)
  linux.device_file =3D '/dev/bus/usb/002/001'  (string)
  linux.hotplug_type =3D 2  (0x2)  (int)
  linux.subsystem =3D 'usb'  (string)
  linux.sysfs_path =3D '/sys/devices/pci0000:00/0000:00:10.0/usb2'  (st=
ring)
  usb_device.bus_number =3D 2  (0x2)  (int)
  usb_device.can_wake_up =3D true  (bool)
  usb_device.configuration_value =3D 1  (0x1)  (int)
  usb_device.device_class =3D 9  (0x9)  (int)
  usb_device.device_protocol =3D 0  (0x0)  (int)
  usb_device.device_revision_bcd =3D 518  (0x206)  (int)
  usb_device.device_subclass =3D 0  (0x0)  (int)
  usb_device.is_self_powered =3D true  (bool)
  usb_device.linux.device_number =3D 1  (0x1)  (int)
  usb_device.linux.sysfs_path =3D '/sys/devices/pci0000:00/0000:00:10.0=
/usb2'  (string)
  usb_device.max_power =3D 0  (0x0)  (int)
  usb_device.num_configurations =3D 1  (0x1)  (int)
  usb_device.num_interfaces =3D 1  (0x1)  (int)
  usb_device.num_ports =3D 2  (0x2)  (int)
  usb_device.product =3D '1.1 root hub'  (string)
  usb_device.product_id =3D 1  (0x1)  (int)
  usb_device.serial =3D '0000:00:10.0'  (string)
  usb_device.speed =3D 12.0 (12) (double)
  usb_device.vendor =3D 'Linux Foundation'  (string)
  usb_device.vendor_id =3D 7531  (0x1d6b)  (int)
  usb_device.version =3D 1.1 (1.1) (double)

udi =3D '/org/freedesktop/Hal/devices/usb_device_1d6b_1_0000_00_10_0_if=
0'
  info.linux.driver =3D 'hub'  (string)
  info.parent =3D '/org/freedesktop/Hal/devices/usb_device_1d6b_1_0000_=
00_10_0'  (string)
  info.product =3D 'USB Hub Interface'  (string)
  info.subsystem =3D 'usb'  (string)
  info.udi =3D '/org/freedesktop/Hal/devices/usb_device_1d6b_1_0000_00_=
10_0_if0'  (string)
  linux.hotplug_type =3D 2  (0x2)  (int)
  linux.subsystem =3D 'usb'  (string)
  linux.sysfs_path =3D '/sys/devices/pci0000:00/0000:00:10.0/usb2/2-0:1=
=2E0'  (string)
  usb.bus_number =3D 2  (0x2)  (int)
  usb.can_wake_up =3D true  (bool)
  usb.configuration_value =3D 1  (0x1)  (int)
  usb.device_class =3D 9  (0x9)  (int)
  usb.device_protocol =3D 0  (0x0)  (int)
  usb.device_revision_bcd =3D 518  (0x206)  (int)
  usb.device_subclass =3D 0  (0x0)  (int)
  usb.interface.class =3D 9  (0x9)  (int)
  usb.interface.number =3D 0  (0x0)  (int)
  usb.interface.protocol =3D 0  (0x0)  (int)
  usb.interface.subclass =3D 0  (0x0)  (int)
  usb.is_self_powered =3D true  (bool)
  usb.linux.device_number =3D 1  (0x1)  (int)
  usb.linux.sysfs_path =3D '/sys/devices/pci0000:00/0000:00:10.0/usb2/2=
-0:1.0'  (string)
  usb.max_power =3D 0  (0x0)  (int)
  usb.num_configurations =3D 1  (0x1)  (int)
  usb.num_interfaces =3D 1  (0x1)  (int)
  usb.num_ports =3D 2  (0x2)  (int)
  usb.product =3D 'USB Hub Interface'  (string)
  usb.product_id =3D 1  (0x1)  (int)
  usb.serial =3D '0000:00:10.0'  (string)
  usb.speed =3D 12.0 (12) (double)
  usb.vendor =3D 'Linux Foundation'  (string)
  usb.vendor_id =3D 7531  (0x1d6b)  (int)
  usb.version =3D 1.1 (1.1) (double)

udi =3D '/org/freedesktop/Hal/devices/pci_1106_571'
  info.linux.driver =3D 'VIA_IDE'  (string)
  info.parent =3D '/org/freedesktop/Hal/devices/computer'  (string)
  info.product =3D 'VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master=
 IDE'  (string)
  info.subsystem =3D 'pci'  (string)
  info.udi =3D '/org/freedesktop/Hal/devices/pci_1106_571'  (string)
  info.vendor =3D 'VIA Technologies, Inc.'  (string)
  linux.hotplug_type =3D 2  (0x2)  (int)
  linux.subsystem =3D 'pci'  (string)
  linux.sysfs_path =3D '/sys/devices/pci0000:00/0000:00:0f.1'  (string)
  pci.device_class =3D 1  (0x1)  (int)
  pci.device_protocol =3D 138  (0x8a)  (int)
  pci.device_subclass =3D 1  (0x1)  (int)
  pci.linux.sysfs_path =3D '/sys/devices/pci0000:00/0000:00:0f.1'  (str=
ing)
  pci.product =3D 'VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master =
IDE'  (string)
  pci.product_id =3D 1393  (0x571)  (int)
  pci.subsys_product =3D 'K7VT2/K7VT6 motherboard'  (string)
  pci.subsys_product_id =3D 1393  (0x571)  (int)
  pci.subsys_vendor =3D 'ASRock Incorporation'  (string)
  pci.subsys_vendor_id =3D 6217  (0x1849)  (int)
  pci.vendor =3D 'VIA Technologies, Inc.'  (string)
  pci.vendor_id =3D 4358  (0x1106)  (int)

udi =3D '/org/freedesktop/Hal/devices/pci_1106_571_ide_1_1'
  ide.channel =3D 1  (0x1)  (int)
  ide.host =3D 1  (0x1)  (int)
  info.linux.driver =3D 'ide-cdrom'  (string)
  info.parent =3D '/org/freedesktop/Hal/devices/pci_1106_571'  (string)
  info.product =3D 'IDE device (slave)'  (string)
  info.subsystem =3D 'ide'  (string)
  info.udi =3D '/org/freedesktop/Hal/devices/pci_1106_571_ide_1_1'  (st=
ring)
  linux.hotplug_type =3D 2  (0x2)  (int)
  linux.subsystem =3D 'ide'  (string)
  linux.sysfs_path =3D '/sys/devices/pci0000:00/0000:00:0f.1/ide1/1.1' =
 (string)

udi =3D '/org/freedesktop/Hal/devices/pci_1106_571_ide_1_0'
  ide.channel =3D 0  (0x0)  (int)
  ide.host =3D 1  (0x1)  (int)
  info.linux.driver =3D 'ide-cdrom'  (string)
  info.parent =3D '/org/freedesktop/Hal/devices/pci_1106_571'  (string)
  info.product =3D 'IDE device (master)'  (string)
  info.subsystem =3D 'ide'  (string)
  info.udi =3D '/org/freedesktop/Hal/devices/pci_1106_571_ide_1_0'  (st=
ring)
  linux.hotplug_type =3D 2  (0x2)  (int)
  linux.subsystem =3D 'ide'  (string)
  linux.sysfs_path =3D '/sys/devices/pci0000:00/0000:00:0f.1/ide1/1.0' =
 (string)

udi =3D '/org/freedesktop/Hal/devices/pci_1106_571_ide_0_1'
  ide.channel =3D 1  (0x1)  (int)
  ide.host =3D 0  (0x0)  (int)
  info.linux.driver =3D 'ide-gd'  (string)
  info.parent =3D '/org/freedesktop/Hal/devices/pci_1106_571'  (string)
  info.product =3D 'IDE device (slave)'  (string)
  info.subsystem =3D 'ide'  (string)
  info.udi =3D '/org/freedesktop/Hal/devices/pci_1106_571_ide_0_1'  (st=
ring)
  linux.hotplug_type =3D 2  (0x2)  (int)
  linux.subsystem =3D 'ide'  (string)
  linux.sysfs_path =3D '/sys/devices/pci0000:00/0000:00:0f.1/ide0/0.1' =
 (string)

udi =3D '/org/freedesktop/Hal/devices/pci_1106_571_ide_0_0'
  ide.channel =3D 0  (0x0)  (int)
  ide.host =3D 0  (0x0)  (int)
  info.linux.driver =3D 'ide-gd'  (string)
  info.parent =3D '/org/freedesktop/Hal/devices/pci_1106_571'  (string)
  info.product =3D 'IDE device (master)'  (string)
  info.subsystem =3D 'ide'  (string)
  info.udi =3D '/org/freedesktop/Hal/devices/pci_1106_571_ide_0_0'  (st=
ring)
  linux.hotplug_type =3D 2  (0x2)  (int)
  linux.subsystem =3D 'ide'  (string)
  linux.sysfs_path =3D '/sys/devices/pci0000:00/0000:00:0f.1/ide0/0.0' =
 (string)

udi =3D '/org/freedesktop/Hal/devices/pci_1106_3149'
  info.parent =3D '/org/freedesktop/Hal/devices/computer'  (string)
  info.product =3D 'VIA VT6420 SATA RAID Controller'  (string)
  info.subsystem =3D 'pci'  (string)
  info.udi =3D '/org/freedesktop/Hal/devices/pci_1106_3149'  (string)
  info.vendor =3D 'VIA Technologies, Inc.'  (string)
  linux.hotplug_type =3D 2  (0x2)  (int)
  linux.subsystem =3D 'pci'  (string)
  linux.sysfs_path =3D '/sys/devices/pci0000:00/0000:00:0f.0'  (string)
  pci.device_class =3D 1  (0x1)  (int)
  pci.device_protocol =3D 0  (0x0)  (int)
  pci.device_subclass =3D 4  (0x4)  (int)
  pci.linux.sysfs_path =3D '/sys/devices/pci0000:00/0000:00:0f.0'  (str=
ing)
  pci.product =3D 'VIA VT6420 SATA RAID Controller'  (string)
  pci.product_id =3D 12617  (0x3149)  (int)
  pci.subsys_product =3D 'K7VT6 motherboard'  (string)
  pci.subsys_product_id =3D 12617  (0x3149)  (int)
  pci.subsys_vendor =3D 'ASRock Incorporation'  (string)
  pci.subsys_vendor_id =3D 6217  (0x1849)  (int)
  pci.vendor =3D 'VIA Technologies, Inc.'  (string)
  pci.vendor_id =3D 4358  (0x1106)  (int)

udi =3D '/org/freedesktop/Hal/devices/pci_10ec_8139'
  info.linux.driver =3D '8139too'  (string)
  info.parent =3D '/org/freedesktop/Hal/devices/computer'  (string)
  info.product =3D 'RTL-8139/8139C/8139C+'  (string)
  info.subsystem =3D 'pci'  (string)
  info.udi =3D '/org/freedesktop/Hal/devices/pci_10ec_8139'  (string)
  info.vendor =3D 'Realtek Semiconductor Co., Ltd.'  (string)
  linux.hotplug_type =3D 2  (0x2)  (int)
  linux.subsystem =3D 'pci'  (string)
  linux.sysfs_path =3D '/sys/devices/pci0000:00/0000:00:0a.0'  (string)
  pci.device_class =3D 2  (0x2)  (int)
  pci.device_protocol =3D 0  (0x0)  (int)
  pci.device_subclass =3D 0  (0x0)  (int)
  pci.linux.sysfs_path =3D '/sys/devices/pci0000:00/0000:00:0a.0'  (str=
ing)
  pci.product =3D 'RTL-8139/8139C/8139C+'  (string)
  pci.product_id =3D 33081  (0x8139)  (int)
  pci.subsys_product_id =3D 33081  (0x8139)  (int)
  pci.subsys_vendor =3D 'Realtek Semiconductor Co., Ltd.'  (string)
  pci.subsys_vendor_id =3D 4332  (0x10ec)  (int)
  pci.vendor =3D 'Realtek Semiconductor Co., Ltd.'  (string)
  pci.vendor_id =3D 4332  (0x10ec)  (int)

udi =3D '/org/freedesktop/Hal/devices/net_00_08_54_52_31_26'
  info.capabilities =3D {'net', 'net.80203', 'wake_on_lan'} (string lis=
t)
  info.category =3D 'net.80203'  (string)
  info.interfaces =3D {'org.freedesktop.Hal.Device.WakeOnLan'} (string =
list)
  info.parent =3D '/org/freedesktop/Hal/devices/pci_10ec_8139'  (string=
)
  info.product =3D 'Networking Interface'  (string)
  info.subsystem =3D 'net'  (string)
  info.udi =3D '/org/freedesktop/Hal/devices/net_00_08_54_52_31_26'  (s=
tring)
  linux.hotplug_type =3D 2  (0x2)  (int)
  linux.subsystem =3D 'net'  (string)
  linux.sysfs_path =3D '/sys/devices/pci0000:00/0000:00:0a.0/net/eth1' =
 (string)
  net.80203.mac_address =3D 35774411046  (0x854523126)  (uint64)
  net.address =3D '00:08:54:52:31:26'  (string)
  net.arp_proto_hw_id =3D 1  (0x1)  (int)
  net.interface =3D 'eth1'  (string)
  net.linux.ifindex =3D 3  (0x3)  (int)
  net.originating_device =3D '/org/freedesktop/Hal/devices/pci_10ec_813=
9'  (string)
  org.freedesktop.Hal.Device.WakeOnLan.method_argnames =3D {'', '', 'en=
able'} (string list)
  org.freedesktop.Hal.Device.WakeOnLan.method_execpaths =3D {'hal-syste=
m-wol-supported', 'hal-system-wol-enabled', 'hal-system-wol-enable'} (s=
tring list)
  org.freedesktop.Hal.Device.WakeOnLan.method_names =3D {'GetSupported'=
, 'GetEnabled', 'SetEnabled'} (string list)
  org.freedesktop.Hal.Device.WakeOnLan.method_signatures =3D {'', '', '=
b'} (string list)

udi =3D '/org/freedesktop/Hal/devices/pci_1106_b198'
  info.parent =3D '/org/freedesktop/Hal/devices/computer'  (string)
  info.product =3D 'VT8237/VX700 PCI Bridge'  (string)
  info.subsystem =3D 'pci'  (string)
  info.udi =3D '/org/freedesktop/Hal/devices/pci_1106_b198'  (string)
  info.vendor =3D 'VIA Technologies, Inc.'  (string)
  linux.hotplug_type =3D 2  (0x2)  (int)
  linux.subsystem =3D 'pci'  (string)
  linux.sysfs_path =3D '/sys/devices/pci0000:00/0000:00:01.0'  (string)
  pci.device_class =3D 6  (0x6)  (int)
  pci.device_protocol =3D 0  (0x0)  (int)
  pci.device_subclass =3D 4  (0x4)  (int)
  pci.linux.sysfs_path =3D '/sys/devices/pci0000:00/0000:00:01.0'  (str=
ing)
  pci.product =3D 'VT8237/VX700 PCI Bridge'  (string)
  pci.product_id =3D 45464  (0xb198)  (int)
  pci.subsys_product_id =3D 0  (0x0)  (int)
  pci.subsys_vendor_id =3D 0  (0x0)  (int)
  pci.vendor =3D 'VIA Technologies, Inc.'  (string)
  pci.vendor_id =3D 4358  (0x1106)  (int)

udi =3D '/org/freedesktop/Hal/devices/pci_1002_5940'
  info.parent =3D '/org/freedesktop/Hal/devices/pci_1106_b198'  (string=
)
  info.product =3D 'RV280 [Radeon 9200 PRO] (Secondary)'  (string)
  info.subsystem =3D 'pci'  (string)
  info.udi =3D '/org/freedesktop/Hal/devices/pci_1002_5940'  (string)
  info.vendor =3D 'ATI Technologies Inc'  (string)
  linux.hotplug_type =3D 2  (0x2)  (int)
  linux.subsystem =3D 'pci'  (string)
  linux.sysfs_path =3D '/sys/devices/pci0000:00/0000:00:01.0/0000:01:00=
=2E1'  (string)
  pci.device_class =3D 3  (0x3)  (int)
  pci.device_protocol =3D 0  (0x0)  (int)
  pci.device_subclass =3D 128  (0x80)  (int)
  pci.linux.sysfs_path =3D '/sys/devices/pci0000:00/0000:00:01.0/0000:0=
1:00.1'  (string)
  pci.product =3D 'RV280 [Radeon 9200 PRO] (Secondary)'  (string)
  pci.product_id =3D 22848  (0x5940)  (int)
  pci.subsys_product_id =3D 22881  (0x5961)  (int)
  pci.subsys_vendor =3D 'ATI Technologies Inc'  (string)
  pci.subsys_vendor_id =3D 4098  (0x1002)  (int)
  pci.vendor =3D 'ATI Technologies Inc'  (string)
  pci.vendor_id =3D 4098  (0x1002)  (int)

udi =3D '/org/freedesktop/Hal/devices/pci_1002_5960'
  info.linux.driver =3D 'radeonfb'  (string)
  info.parent =3D '/org/freedesktop/Hal/devices/pci_1106_b198'  (string=
)
  info.product =3D 'RV280 [Radeon 9200 PRO]'  (string)
  info.subsystem =3D 'pci'  (string)
  info.udi =3D '/org/freedesktop/Hal/devices/pci_1002_5960'  (string)
  info.vendor =3D 'ATI Technologies Inc'  (string)
  linux.hotplug_type =3D 2  (0x2)  (int)
  linux.subsystem =3D 'pci'  (string)
  linux.sysfs_path =3D '/sys/devices/pci0000:00/0000:00:01.0/0000:01:00=
=2E0'  (string)
  pci.device_class =3D 3  (0x3)  (int)
  pci.device_protocol =3D 0  (0x0)  (int)
  pci.device_subclass =3D 0  (0x0)  (int)
  pci.linux.sysfs_path =3D '/sys/devices/pci0000:00/0000:00:01.0/0000:0=
1:00.0'  (string)
  pci.product =3D 'RV280 [Radeon 9200 PRO]'  (string)
  pci.product_id =3D 22880  (0x5960)  (int)
  pci.subsys_product_id =3D 22880  (0x5960)  (int)
  pci.subsys_vendor =3D 'ATI Technologies Inc'  (string)
  pci.subsys_vendor_id =3D 4098  (0x1002)  (int)
  pci.vendor =3D 'ATI Technologies Inc'  (string)
  pci.vendor_id =3D 4098  (0x1002)  (int)

udi =3D '/org/freedesktop/Hal/devices/pci_1002_5960_drm__null__card0'
  info.capabilities =3D {'drm'} (string list)
  info.category =3D 'drm'  (string)
  info.parent =3D '/org/freedesktop/Hal/devices/pci_1002_5960'  (string=
)
  info.product =3D 'Direct Rendering Manager Device'  (string)
  info.subsystem =3D 'drm'  (string)
  info.udi =3D '/org/freedesktop/Hal/devices/pci_1002_5960_drm__null__c=
ard0'  (string)
  info.vendor =3D 'ATI Technologies Inc'  (string)
  linux.device_file =3D '/dev/dri/card0'  (string)
  linux.hotplug_type =3D 2  (0x2)  (int)
  linux.subsystem =3D 'drm'  (string)
  linux.sysfs_path =3D '/sys/devices/pci0000:00/0000:00:01.0/0000:01:00=
=2E0/drm/card0'  (string)

udi =3D '/org/freedesktop/Hal/devices/pci_1106_3189'
  info.linux.driver =3D 'agpgart-via'  (string)
  info.parent =3D '/org/freedesktop/Hal/devices/computer'  (string)
  info.product =3D 'VT8377 [KT400/KT600 AGP] Host Bridge'  (string)
  info.subsystem =3D 'pci'  (string)
  info.udi =3D '/org/freedesktop/Hal/devices/pci_1106_3189'  (string)
  info.vendor =3D 'VIA Technologies, Inc.'  (string)
  linux.hotplug_type =3D 2  (0x2)  (int)
  linux.subsystem =3D 'pci'  (string)
  linux.sysfs_path =3D '/sys/devices/pci0000:00/0000:00:00.0'  (string)
  pci.device_class =3D 6  (0x6)  (int)
  pci.device_protocol =3D 0  (0x0)  (int)
  pci.device_subclass =3D 0  (0x0)  (int)
  pci.linux.sysfs_path =3D '/sys/devices/pci0000:00/0000:00:00.0'  (str=
ing)
  pci.product =3D 'VT8377 [KT400/KT600 AGP] Host Bridge'  (string)
  pci.product_id =3D 12681  (0x3189)  (int)
  pci.subsys_product =3D 'K7VT6 motherboard'  (string)
  pci.subsys_product_id =3D 12681  (0x3189)  (int)
  pci.subsys_vendor =3D 'ASRock Incorporation'  (string)
  pci.subsys_vendor_id =3D 6217  (0x1849)  (int)
  pci.vendor =3D 'VIA Technologies, Inc.'  (string)
  pci.vendor_id =3D 4358  (0x1106)  (int)


Dumped 84 device(s) from the Global Device List.
------------------------------------------------

# dmesg
Linux version 2.6.31-wotan-10 (witukind@wotan) (gcc version 4.3.3 (GCC)=
 ) #1 Thu Sep 10 21:03:09 CEST 2009
KERNEL supported cpus:
  Intel GenuineIntel
  AMD AuthenticAMD
  NSC Geode by NSC
  Cyrix CyrixInstead
  Centaur CentaurHauls
  Transmeta GenuineTMx86
  Transmeta TransmetaCPU
  UMC UMC UMC UMC
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000ce000 - 00000000000d6000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000002fff0000 (usable)
 BIOS-e820: 000000002fff0000 - 000000002fff8000 (ACPI data)
 BIOS-e820: 000000002fff8000 - 0000000030000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
DMI 2.3 present.
last_pfn =3D 0x2fff0 max_arch_pfn =3D 0x100000
MTRR default type: uncachable
MTRR fixed ranges enabled:
  00000-9FFFF write-back
  A0000-BFFFF uncachable
  C0000-C7FFF write-protect
  C8000-EFFFF uncachable
  F0000-FFFFF write-protect
MTRR variable ranges enabled:
  0 base 000000000 mask FE0000000 write-back
  1 base 020000000 mask FF0000000 write-back
  2 disabled
  3 disabled
  4 disabled
  5 base 0E0000000 mask FFC000000 write-combining
  6 disabled
  7 disabled
x86 PAT enabled: cpu 0, old 0x7040600070406, new 0x7010600070106
initial memory mapped : 0 - 01800000
init_memory_mapping: 0000000000000000-000000002fff0000
 0000000000 - 0000400000 page 4k
 0000400000 - 002fc00000 page 2M
 002fc00000 - 002fff0000 page 4k
kernel direct mapping tables up to 2fff0000 @ 7000-c000
ACPI: RSDP 000fa8c0 00014 (v00 AMI   )
ACPI: RSDT 2fff0000 0002C (v01 AMIINT VIA_K7   00000010 MSFT 00000097)
ACPI: FACP 2fff0030 00081 (v01 AMIINT VIA_K7   00000011 MSFT 00000097)
ACPI: DSDT 2fff0120 03502 (v01    VIA    K7VT4 00001000 INTL 02002024)
ACPI: FACS 2fff8000 00040
ACPI: APIC 2fff00c0 00054 (v01 AMIINT VIA_K7   00000009 MSFT 00000097)
ACPI: Local APIC address 0xfee00000
0MB HIGHMEM available.
767MB LOWMEM available.
  mapped low ram: 0 - 2fff0000
  low ram: 0 - 2fff0000
  node 0 low ram: 00000000 - 2fff0000
  node 0 bootmap 00001000 - 00007000
(6 early reservations) =3D=3D> bootmem [0000000000 - 002fff0000]
  #0 [0000000000 - 0000001000]   BIOS data page =3D=3D> [0000000000 - 0=
000001000]
  #1 [0001000000 - 00012da084]    TEXT DATA BSS =3D=3D> [0001000000 - 0=
0012da084]
  #2 [000009fc00 - 0000100000]    BIOS reserved =3D=3D> [000009fc00 - 0=
000100000]
  #3 [00012db000 - 00012e1095]              BRK =3D=3D> [00012db000 - 0=
0012e1095]
  #4 [0000007000 - 0000008000]          PGTABLE =3D=3D> [0000007000 - 0=
000008000]
  #5 [0000001000 - 0000007000]          BOOTMAP =3D=3D> [0000001000 - 0=
000007000]
Zone PFN ranges:
  DMA      0x00000000 -> 0x00001000
  Normal   0x00001000 -> 0x0002fff0
  HighMem  0x0002fff0 -> 0x0002fff0
Movable zone start PFN for each node
early_node_map[2] active PFN ranges
    0: 0x00000000 -> 0x0000009f
    0: 0x00000100 -> 0x0002fff0
On node 0 totalpages: 196495
free_area_init_node: node 0, pgdat c125b6d0, node_mem_map c12e2000
  DMA zone: 32 pages used for memmap
  DMA zone: 0 pages reserved
  DMA zone: 3967 pages, LIFO batch:0
  Normal zone: 1504 pages used for memmap
  Normal zone: 190992 pages, LIFO batch:31
Using APIC driver default
ACPI: PM-Timer IO Port: 0x808
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 3, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
nr_irqs_gsi: 24
PM: Registered nosave memory: 000000000009f000 - 00000000000a0000
PM: Registered nosave memory: 00000000000a0000 - 00000000000ce000
PM: Registered nosave memory: 00000000000ce000 - 00000000000d6000
PM: Registered nosave memory: 00000000000d6000 - 00000000000f0000
PM: Registered nosave memory: 00000000000f0000 - 0000000000100000
Allocating PCI resources starting at 30000000 (gap: 30000000:cec00000)
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 19=
4959
Kernel command line: BOOT_IMAGE=3DLinux ro root=3D307 vt.default_utf8=3D=
1
PID hash table entries: 4096 (order: 12, 16384 bytes)
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
Initializing HighMem for node 0 (00000000:00000000)
Memory: 775904k/786368k available (1691k kernel code, 9916k reserved, 7=
30k data, 232k init, 0k highmem)
virtual kernel memory layout:
    fixmap  : 0xfffa4000 - 0xfffff000   ( 364 kB)
    pkmap   : 0xff800000 - 0xffc00000   (4096 kB)
    vmalloc : 0xf07f0000 - 0xff7fe000   ( 240 MB)
    lowmem  : 0xc0000000 - 0xefff0000   ( 767 MB)
      .init : 0xc125e000 - 0xc1298000   ( 232 kB)
      .data : 0xc11a6ef7 - 0xc125d890   ( 730 kB)
      .text : 0xc1000000 - 0xc11a6ef7   (1691 kB)
Checking if this processor honours the WP bit even in supervisor mode..=
=2EOk.
SLUB: Genslabs=3D13, HWalign=3D32, Order=3D0-3, MinObjects=3D0, CPUs=3D=
1, Nodes=3D1
NR_IRQS:288
=46ast TSC calibration using PIT
Detected 1666.090 MHz processor.
Console: colour VGA+ 80x25
console [tty0] enabled
Calibrating delay loop (skipped), value calculated using timer frequenc=
y.. 3332.18 BogoMIPS (lpj=3D1666090)
Security Framework initialized
Mount-cache hash table entries: 512
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
mce: CPU supports 4 MCE banks
Performance Counters: AMD PMU driver.
=2E.. version:                 0
=2E.. bit width:               48
=2E.. generic counters:        4
=2E.. value mask:              0000ffffffffffff
=2E.. max period:              00007fffffffffff
=2E.. fixed-purpose counters:  0
=2E.. counter mask:            000000000000000f
CPU: AMD Sempron(tm) 2400+ stepping 01
Checking 'hlt' instruction... OK.
ACPI: Core revision 20090521
=2E.TIMER: vector=3D0x30 apic1=3D0 pin1=3D2 apic2=3D-1 pin2=3D-1
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xfda71, last bus=3D1
PCI: Using configuration type 1 for base access
bio: create slab <bio-0> at 0
ACPI: EC: Look up EC in DSDT
ACPI: Interpreter enabled
ACPI: (supports S0 S1 S4 S5)
ACPI: Using IOAPIC for interrupt routing
ACPI: Power Resource [URP1] (off)
ACPI: Power Resource [URP2] (off)
ACPI: Power Resource [FDDP] (off)
ACPI: Power Resource [LPTP] (off)
ACPI: No dock devices found.
ACPI: PCI Root Bridge [PCI0] (0000:00)
pci 0000:00:00.0: reg 10 32bit mmio: [0xe0000000-0xe3ffffff]
pci 0000:00:01.0: supports D1
pci 0000:00:0a.0: reg 10 io port: [0xd400-0xd4ff]
pci 0000:00:0a.0: reg 14 32bit mmio: [0xdfffbf00-0xdfffbfff]
pci 0000:00:0a.0: supports D1 D2
pci 0000:00:0a.0: PME# supported from D1 D2 D3hot
pci 0000:00:0a.0: PME# disabled
pci 0000:00:0f.0: reg 10 io port: [0xec00-0xec07]
pci 0000:00:0f.0: reg 14 io port: [0xe800-0xe803]
pci 0000:00:0f.0: reg 18 io port: [0xe400-0xe407]
pci 0000:00:0f.0: reg 1c io port: [0xe000-0xe003]
pci 0000:00:0f.0: reg 20 io port: [0xdc00-0xdc0f]
pci 0000:00:0f.0: reg 24 io port: [0xd800-0xd8ff]
pci 0000:00:0f.1: reg 20 io port: [0xfc00-0xfc0f]
pci 0000:00:10.0: reg 20 io port: [0xc400-0xc41f]
pci 0000:00:10.0: supports D1 D2
pci 0000:00:10.0: PME# supported from D0 D1 D2 D3hot D3cold
pci 0000:00:10.0: PME# disabled
pci 0000:00:10.1: reg 20 io port: [0xc800-0xc81f]
pci 0000:00:10.1: supports D1 D2
pci 0000:00:10.1: PME# supported from D0 D1 D2 D3hot D3cold
pci 0000:00:10.1: PME# disabled
pci 0000:00:10.2: reg 20 io port: [0xcc00-0xcc1f]
pci 0000:00:10.2: supports D1 D2
pci 0000:00:10.2: PME# supported from D0 D1 D2 D3hot D3cold
pci 0000:00:10.2: PME# disabled
pci 0000:00:10.3: reg 20 io port: [0xd000-0xd01f]
pci 0000:00:10.3: supports D1 D2
pci 0000:00:10.3: PME# supported from D0 D1 D2 D3hot D3cold
pci 0000:00:10.3: PME# disabled
pci 0000:00:10.4: reg 10 32bit mmio: [0xdfffbd00-0xdfffbdff]
pci 0000:00:10.4: supports D1 D2
pci 0000:00:10.4: PME# supported from D0 D1 D2 D3hot D3cold
pci 0000:00:10.4: PME# disabled
pci 0000:00:11.5: reg 10 io port: [0xc000-0xc0ff]
pci 0000:00:11.5: supports D1 D2
pci 0000:00:12.0: reg 10 io port: [0xbc00-0xbcff]
pci 0000:00:12.0: reg 14 32bit mmio: [0xdfffbc00-0xdfffbcff]
pci 0000:00:12.0: supports D1 D2
pci 0000:00:12.0: PME# supported from D0 D1 D2 D3hot D3cold
pci 0000:00:12.0: PME# disabled
pci 0000:01:00.0: reg 10 32bit mmio: [0xd0000000-0xd7ffffff]
pci 0000:01:00.0: reg 14 io port: [0xa800-0xa8ff]
pci 0000:01:00.0: reg 18 32bit mmio: [0xdfef0000-0xdfefffff]
pci 0000:01:00.0: reg 30 32bit mmio: [0xdfec0000-0xdfedffff]
pci 0000:01:00.0: supports D1 D2
pci 0000:01:00.1: reg 10 32bit mmio: [0xc8000000-0xcfffffff]
pci 0000:01:00.1: reg 14 32bit mmio: [0xdfee0000-0xdfeeffff]
pci 0000:01:00.1: supports D1 D2
pci 0000:00:01.0: bridge io port: [0xa000-0xafff]
pci 0000:00:01.0: bridge 32bit mmio: [0xdfe00000-0xdfefffff]
pci 0000:00:01.0: bridge 32bit mmio pref: [0xbfd00000-0xdfcfffff]
pci_bus 0000:00: on NUMA node 0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs *3 4 5 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 7 10 11 12 14 15) *0, disab=
led.
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 7 10 11 12 14 15) *0, disab=
led.
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 7 10 11 12 14 15) *0, disab=
led.
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 7 10 11 12 14 15) *0, disab=
led.
PCI: Using ACPI for IRQ routing
pnp: PnP ACPI init
ACPI: bus type pnp registered
pnp: PnP ACPI: found 11 devices
ACPI: ACPI bus type pnp unregistered
system 00:05: ioport range 0x295-0x296 has been reserved
system 00:05: ioport range 0x3f0-0x3f1 has been reserved
system 00:05: ioport range 0x4d0-0x4d1 has been reserved
system 00:05: ioport range 0x400-0x40f has been reserved
system 00:05: ioport range 0x800-0x87f has been reserved
system 00:05: iomem range 0xfec00000-0xfec00fff could not be reserved
system 00:05: iomem range 0xfee00000-0xfee00fff has been reserved
pci 0000:00:01.0: PCI bridge, secondary bus 0000:01
pci 0000:00:01.0:   IO window: 0xa000-0xafff
pci 0000:00:01.0:   MEM window: 0xdfe00000-0xdfefffff
pci 0000:00:01.0:   PREFETCH window: 0xbfd00000-0xdfcfffff
pci 0000:00:01.0: setting latency timer to 64
pci_bus 0000:00: resource 0 io:  [0x00-0xffff]
pci_bus 0000:00: resource 1 mem: [0x000000-0xffffffff]
pci_bus 0000:01: resource 0 io:  [0xa000-0xafff]
pci_bus 0000:01: resource 1 mem: [0xdfe00000-0xdfefffff]
pci_bus 0000:01: resource 2 pref mem [0xbfd00000-0xdfcfffff]
NET: Registered protocol family 2
IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
TCP established hash table entries: 131072 (order: 8, 1048576 bytes)
TCP bind hash table entries: 65536 (order: 6, 262144 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
TCP reno registered
msgmni has been set to 1515
Block layer SCSI generic (bsg) driver version 0.4 loaded (major 254)
io scheduler noop registered
io scheduler cfq registered (default)
pci 0000:00:01.0: disabling DAC on VIA PCI bridge
pci 0000:00:11.0: Bypassing VIA 8237 APIC De-Assert Message
pci 0000:01:00.0: Boot video device
radeonfb 0000:01:00.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
radeonfb: Found Intel x86 BIOS ROM Image
radeonfb: Retrieved PLL infos from BIOS
radeonfb: Reference=3D27.00 MHz (RefDiv=3D12) Memory=3D240.00 Mhz, Syst=
em=3D200.25 MHz
radeonfb: PLL min 20000 max 40000
i2c-adapter i2c-1: unable to read EDID block.
i2c-adapter i2c-1: unable to read EDID block.
i2c-adapter i2c-1: unable to read EDID block.
i2c-adapter i2c-3: unable to read EDID block.
Switched to high resolution mode on CPU 0
i2c-adapter i2c-3: unable to read EDID block.
i2c-adapter i2c-3: unable to read EDID block.
radeonfb: Monitor 1 type CRT found
radeonfb: EDID probed
radeonfb: Monitor 2 type no found
Console: switching to colour frame buffer device 160x64
radeonfb (0000:01:00.0): ATI Radeon 5960 "Y`"
Uniform Multi-Platform E-IDE driver
via82cxxx 0000:00:0f.1: VIA vt8237 (rev 00) IDE UDMA133
via82cxxx 0000:00:0f.1: IDE controller (0x1106:0x0571 rev 0x06)
VIA_IDE 0000:00:0f.1: PCI INT A -> GSI 20 (level, low) -> IRQ 20
via82cxxx 0000:00:0f.1: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xfc00-0xfc07
    ide1: BM-DMA at 0xfc08-0xfc0f
Probing IDE interface ide0...
hda: WDC WD800BB-00JKA0, ATA DISK drive
hdb: WDC WD800JB-00ETA0, ATA DISK drive
hda: host max PIO5 wanted PIO255(auto-tune) selected PIO4
hda: UDMA/100 mode selected
hdb: host max PIO5 wanted PIO255(auto-tune) selected PIO4
hdb: UDMA/100 mode selected
Probing IDE interface ide1...
hdc: PHILIPS PCRW5232P, ATAPI CD/DVD-ROM drive
hdd: LITE-ON DVDRW SOHW-1693S, ATAPI CD/DVD-ROM drive
hdc: host max PIO5 wanted PIO255(auto-tune) selected PIO4
hdc: UDMA/33 mode selected
hdd: host max PIO5 wanted PIO255(auto-tune) selected PIO4
hdd: UDMA/66 mode selected
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
ide-gd driver 1.18
hda: max request size: 128KiB
hda: 156301488 sectors (80026 MB) w/2048KiB Cache, CHS=3D65535/16/63
hda: cache flushes supported
 hda: hda1 hda2 hda3 < hda5 hda6 hda7 hda8 hda9 >
hdb: max request size: 512KiB
hdb: 156301488 sectors (80026 MB) w/8192KiB Cache, CHS=3D16383/255/63
hdb: cache flushes supported
 hdb: hdb1
PNP: PS/2 Controller [PNP0f13:PS2M] at 0x60,0x64 irq 12
PNP: PS/2 controller doesn't have KBD irq; using default 1
serio: i8042 KBD port at 0x60,0x64 irq 1
serio: i8042 AUX port at 0x60,0x64 irq 12
mice: PS/2 mouse device common for all mice
cpuidle: using governor ladder
cpuidle: using governor menu
TCP cubic registered
Using IPI Shortcut mode
EXT4-fs (hda7): barriers enabled
kjournald2 starting: pid 350, dev hda7:8, commit interval 5 seconds
EXT4-fs (hda7): delayed allocation enabled
EXT4-fs: file extents enabled
EXT4-fs: mballoc enabled
EXT4-fs (hda7): mounted filesystem with ordered data mode
VFS: Mounted root (ext4 filesystem) readonly on device 3:7.
=46reeing unused kernel memory: 232k freed
NET: Registered protocol family 1
input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input0
ACPI: Power Button [PWRF]
input: Power Button as /devices/LNXSYSTM:00/device:00/PNP0C0C:00/input/=
input1
ACPI: Power Button [PWRB]
input: Sleep Button as /devices/LNXSYSTM:00/device:00/PNP0C0E:00/input/=
input2
ACPI: Sleep Button [SLPB]
=46loppy drive(s): fd0 is 1.44M
=46DC 0 is a post-1991 82077
Linux agpgart interface v0.103
gameport: NS558 PnP Gameport is pnp00:04/gameport0, io 0x200, speed 101=
1kHz
Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
serial8250: ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
00:02: ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
agpgart: Detected VIA KT400/KT400A/KT600 chipset
ide-cd driver 5.00
agpgart-via 0000:00:00.0: AGP aperture is 64M @ 0xe0000000
ide-cd: hdc: ATAPI 52X CD-ROM CD-R/RW drive, 2048kB Cache
Uniform CD-ROM driver Revision: 3.20
rtc_cmos 00:07: RTC can wake from S4
8139too Fast Ethernet driver 0.9.28
via-rhine.c:v1.10-LK1.4.3 2007-03-06 Written by Donald Becker
via-rhine 0000:00:12.0: PCI INT A -> GSI 23 (level, low) -> IRQ 23
eth0: VIA Rhine II at 0xdfffbc00, 00:0b:6a:c0:a1:d7, IRQ 23.
eth0: MII PHY found at address 1, status 0x786d advertising 05e1 Link 4=
5e1.
rtc_cmos 00:07: rtc core: registered rtc_cmos as rtc0
rtc0: alarms up to one year, y3k, 114 bytes nvram
8139too 0000:00:0a.0: PCI INT A -> GSI 18 (level, low) -> IRQ 18
eth1: RealTek RTL8139 at 0xf190af00, 00:08:54:52:31:26, IRQ 18
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
processor LNXCPU:00: registered as cooling_device0
ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
ehci_hcd 0000:00:10.4: PCI INT C -> GSI 21 (level, low) -> IRQ 21
ehci_hcd 0000:00:10.4: EHCI Host Controller
ehci_hcd 0000:00:10.4: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:10.4: irq 21, io mem 0xdfffbd00
ehci_hcd 0000:00:10.4: USB 2.0 started, EHCI 1.00
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
input: PC Speaker as /devices/platform/pcspkr/input/input3
hub 1-0:1.0: 8 ports detected
VIA 82xx Audio 0000:00:11.5: PCI INT C -> GSI 22 (level, low) -> IRQ 22
VIA 82xx Audio 0000:00:11.5: setting latency timer to 64
uhci_hcd: USB Universal Host Controller Interface driver
ide-cd: hdd: ATAPI 48X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache
usb 1-1: new high speed USB device using ehci_hcd and address 2
usb 1-1: configuration #1 chosen from 1 choice
hub 1-1:1.0: USB hub found
hub 1-1:1.0: 4 ports detected
input: ImExPS/2 Generic Explorer Mouse as /devices/platform/i8042/serio=
1/input/input4
uhci_hcd 0000:00:10.0: PCI INT A -> GSI 21 (level, low) -> IRQ 21
uhci_hcd 0000:00:10.0: UHCI Host Controller
uhci_hcd 0000:00:10.0: new USB bus registered, assigned bus number 2
usb 1-3: new high speed USB device using ehci_hcd and address 3
uhci_hcd 0000:00:10.0: irq 21, io base 0x0000c400
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
uhci_hcd 0000:00:10.1: PCI INT A -> GSI 21 (level, low) -> IRQ 21
uhci_hcd 0000:00:10.1: UHCI Host Controller
uhci_hcd 0000:00:10.1: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:10.1: irq 21, io base 0x0000c800
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
uhci_hcd 0000:00:10.2: PCI INT B -> GSI 21 (level, low) -> IRQ 21
uhci_hcd 0000:00:10.2: UHCI Host Controller
uhci_hcd 0000:00:10.2: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:10.2: irq 21, io base 0x0000cc00
usb usb4: configuration #1 chosen from 1 choice
usb 1-3: configuration #1 chosen from 1 choice
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
uhci_hcd 0000:00:10.3: PCI INT B -> GSI 21 (level, low) -> IRQ 21
uhci_hcd 0000:00:10.3: UHCI Host Controller
uhci_hcd 0000:00:10.3: new USB bus registered, assigned bus number 5
uhci_hcd 0000:00:10.3: irq 21, io base 0x0000d000
usb usb5: configuration #1 chosen from 1 choice
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 2 ports detected
usbcore: registered new interface driver libusual
SCSI subsystem initialized
Initializing USB Mass Storage driver...
scsi0 : SCSI emulation for USB Mass Storage devices
usbcore: registered new interface driver usb-storage
USB Mass Storage support registered.
usb-storage: device found at 3
usb-storage: waiting for device to settle before scanning
usb 4-1: new low speed USB device using uhci_hcd and address 2
usb 4-1: configuration #1 chosen from 1 choice
usbcore: registered new interface driver hiddev
input: Microsoft Comfort Curve Keyboard 2000 as /devices/pci0000:00/000=
0:00:10.2/usb4/4-1/4-1:1.0/input/input5
generic-usb 0003:045E:00DD.0001: input,hidraw0: USB HID v1.11 Keyboard =
[Microsoft Comfort Curve Keyboard 2000] on usb-0000:00:10.2-1/input0
input: Microsoft Comfort Curve Keyboard 2000 as /devices/pci0000:00/000=
0:00:10.2/usb4/4-1/4-1:1.1/input/input6
generic-usb 0003:045E:00DD.0002: input,hidraw1: USB HID v1.11 Device [M=
icrosoft Comfort Curve Keyboard 2000] on usb-0000:00:10.2-1/input1
usbcore: registered new interface driver usbhid
usbhid: v2.6:USB HID core driver
usb 4-2: new full speed USB device using uhci_hcd and address 3
usb 4-2: configuration #1 chosen from 1 choice
Linux video capture interface: v2.00
gspca: main v2.6.0 registered
gspca: probing 041e:401c
zc3xx: probe sif 0x0007
zc3xx: probe sensor -> 000f
zc3xx: Find Sensor PAS106
gspca: probe ok
usbcore: registered new interface driver zc3xx
zc3xx: registered
Adding 3903752k swap on /dev/hda6.  Priority:-1 extents:1 across:390375=
2k=20
fuse init (API version 7.12)
EXT4-fs (hda7): internal journal on hda7:8
scsi 0:0:0:0: Direct-Access     Maxtor   Basics Portable  0122 PQ: 0 AN=
SI: 4
usb-storage: device scan complete
sd 0:0:0:0: [sda] 488397168 512-byte logical blocks: (250 GB/232 GiB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 2d 08 00 00
sd 0:0:0:0: [sda] Assuming drive cache: write through
sd 0:0:0:0: [sda] Assuming drive cache: write through
 sda: sda1
sd 0:0:0:0: [sda] Assuming drive cache: write through
sd 0:0:0:0: [sda] Attached SCSI disk
sd 0:0:0:0: Attached scsi generic sg0 type 0
EXT4-fs (hda5): barriers enabled
kjournald2 starting: pid 998, dev hda5:8, commit interval 5 seconds
EXT4-fs (hda5): internal journal on hda5:8
EXT4-fs (hda5): delayed allocation enabled
EXT4-fs: file extents enabled
EXT4-fs: mballoc enabled
EXT4-fs (hda5): mounted filesystem with ordered data mode
EXT4-fs (hda8): barriers enabled
kjournald2 starting: pid 999, dev hda8:8, commit interval 5 seconds
EXT4-fs (hda8): internal journal on hda8:8
EXT4-fs (hda8): delayed allocation enabled
EXT4-fs: file extents enabled
EXT4-fs: mballoc enabled
EXT4-fs (hda8): mounted filesystem with ordered data mode
EXT4-fs (hda9): barriers enabled
kjournald2 starting: pid 1000, dev hda9:8, commit interval 5 seconds
EXT4-fs (hda9): internal journal on hda9:8
EXT4-fs (hda9): delayed allocation enabled
EXT4-fs: file extents enabled
EXT4-fs: mballoc enabled
EXT4-fs (hda9): mounted filesystem with ordered data mode
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hdb1, internal journal
EXT3-fs: mounted filesystem with writeback data mode.
kjournald starting.  Commit interval 5 seconds
EXT3-fs warning: maximal mount count reached, running e2fsck is recomme=
nded
EXT3 FS on sda1, internal journal
EXT3-fs: mounted filesystem with writeback data mode.
eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
NET: Registered protocol family 17
[drm] Initialized drm 1.1.0 20060810
[drm] Initialized radeon 1.31.0 20080528 for 0000:01:00.0 on minor 0
agpgart-via 0000:00:00.0: AGP 3.5 bridge
agpgart-via 0000:00:00.0: putting AGP V3 device into 8x mode
radeonfb 0000:01:00.0: putting AGP V3 device into 8x mode
[drm] Setting GART location based on new memory map
[drm] Loading R200 Microcode
[drm] writeback test succeeded in 1 usecs
NET: Registered protocol family 10
lo: Disabled Privacy Extensions
eth0: no IPv6 routers present
agpgart-via 0000:00:00.0: AGP 3.5 bridge
agpgart-via 0000:00:00.0: putting AGP V3 device into 8x mode
radeonfb 0000:01:00.0: putting AGP V3 device into 8x mode
[drm] Loading R200 Microcode
agpgart-via 0000:00:00.0: AGP 3.5 bridge
agpgart-via 0000:00:00.0: putting AGP V3 device into 8x mode
radeonfb 0000:01:00.0: putting AGP V3 device into 8x mode
[drm] Loading R200 Microcode
agpgart-via 0000:00:00.0: AGP 3.5 bridge
agpgart-via 0000:00:00.0: putting AGP V3 device into 8x mode
radeonfb 0000:01:00.0: putting AGP V3 device into 8x mode
[drm] Loading R200 Microcode
agpgart-via 0000:00:00.0: AGP 3.5 bridge
agpgart-via 0000:00:00.0: putting AGP V3 device into 8x mode
radeonfb 0000:01:00.0: putting AGP V3 device into 8x mode
[drm] Loading R200 Microcode
agpgart-via 0000:00:00.0: AGP 3.5 bridge
agpgart-via 0000:00:00.0: putting AGP V3 device into 8x mode
radeonfb 0000:01:00.0: putting AGP V3 device into 8x mode
[drm] Loading R200 Microcode
agpgart-via 0000:00:00.0: AGP 3.5 bridge
agpgart-via 0000:00:00.0: putting AGP V3 device into 8x mode
radeonfb 0000:01:00.0: putting AGP V3 device into 8x mode
[drm] Loading R200 Microcode
agpgart-via 0000:00:00.0: AGP 3.5 bridge
agpgart-via 0000:00:00.0: putting AGP V3 device into 8x mode
radeonfb 0000:01:00.0: putting AGP V3 device into 8x mode
[drm] Loading R200 Microcode
agpgart-via 0000:00:00.0: AGP 3.5 bridge
agpgart-via 0000:00:00.0: putting AGP V3 device into 8x mode
radeonfb 0000:01:00.0: putting AGP V3 device into 8x mode
[drm] Loading R200 Microcode
agpgart-via 0000:00:00.0: AGP 3.5 bridge
agpgart-via 0000:00:00.0: putting AGP V3 device into 8x mode
radeonfb 0000:01:00.0: putting AGP V3 device into 8x mode
[drm] Loading R200 Microcode
agpgart-via 0000:00:00.0: AGP 3.5 bridge
agpgart-via 0000:00:00.0: putting AGP V3 device into 8x mode
radeonfb 0000:01:00.0: putting AGP V3 device into 8x mode
[drm] Loading R200 Microcode
agpgart-via 0000:00:00.0: AGP 3.5 bridge
agpgart-via 0000:00:00.0: putting AGP V3 device into 8x mode
radeonfb 0000:01:00.0: putting AGP V3 device into 8x mode
[drm] Loading R200 Microcode
agpgart-via 0000:00:00.0: AGP 3.5 bridge
agpgart-via 0000:00:00.0: putting AGP V3 device into 8x mode
radeonfb 0000:01:00.0: putting AGP V3 device into 8x mode
[drm] Loading R200 Microcode
agpgart-via 0000:00:00.0: AGP 3.5 bridge
agpgart-via 0000:00:00.0: putting AGP V3 device into 8x mode
radeonfb 0000:01:00.0: putting AGP V3 device into 8x mode
[drm] Loading R200 Microcode
agpgart-via 0000:00:00.0: AGP 3.5 bridge
agpgart-via 0000:00:00.0: putting AGP V3 device into 8x mode
radeonfb 0000:01:00.0: putting AGP V3 device into 8x mode
[drm] Loading R200 Microcode
Adding 3903752k swap on /dev/hda6.  Priority:-1 extents:1 across:390375=
2k=20

--=20
PGP: 0xC189F229
