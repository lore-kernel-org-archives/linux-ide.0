From: Stephane Raimbault <stephane.raimbault@free.fr>
Subject: PROBLEM: irq handling (IDE, USB)
Date: Tue, 11 May 2004 18:20:33 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <1084292433.3000.3.camel@trax.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from huva.hittite.isp.9tel.net ([62.62.156.28]:35016 "EHLO
	huva.hittite.isp.9tel.net") by vger.kernel.org with ESMTP
	id S264827AbUEKQUE (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 11 May 2004 12:20:04 -0400
Received: from [192.168.0.2] (unknown [80.119.175.187])
	by huva.hittite.isp.9tel.net (Postfix) with ESMTP id 1B4479BD88
	for <linux-ide@vger.kernel.org>; Tue, 11 May 2004 18:21:18 +0200 (CEST)
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi,

syslogd shows some warnings :

Message from syslogd@trax at Tue May 11 18:18:13 2004 ...
trax last message repeated 105 times

Good luck !
Stephane

Some infos about the problem :

[root@trax root]# more /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Pentium(R) 4 CPU 2.60GHz
stepping        : 9
cpu MHz         : 2599.791
cache size      : 512 KB
physical id     : 0
siblings        : 2
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid
bogomips        : 5144.57

00:00.0 Host bridge: Intel Corp. 82865G/PE/P DRAM Controller/Host-Hub
Interface (rev 02)
Subsystem: Asustek Computer, Inc. P4P800 Mainboard
Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort- <TAbor=
t-
<MAbort+ >SERR- <PERR-
Latency: 0
Region 0: Memory at e0000000 (32-bit, prefetchable) [size=3D256M]
Capabilities: [e4] #09 [2106]
Capabilities: [a0] AGP version 3.0
Status: RQ=3D31 SBA+ 64bit- FW+ Rate=3Dx1,x2
Command: RQ=3D0 SBA+ AGP+ 64bit- FW+ Rate=3Dx2

00:01.0 PCI bridge: Intel Corp. 82865G/PE/P PCI to AGP Controller (rev
02) (prog-if 00 [Normal decode])
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort- <TAbor=
t-
<MAbort- >SERR- <PERR-
Latency: 64
Bus: primary=3D00, secondary=3D01, subordinate=3D01, sec-latency=3D64
I/O behind bridge: 0000c000-0000cfff
Memory behind bridge: fe900000-fe9fffff
Prefetchable memory behind bridge: bff00000-dfefffff
BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-

00:1d.0 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #1
(rev 02) (prog-if 00 [UHCI])
Subsystem: Asustek Computer, Inc. P4P800 Mainboard
Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
Latency: 0
Interrupt: pin A routed to IRQ 16
Region 4: I/O ports at ef00 [size=3D32]

00:1d.1 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #2
(rev 02) (prog-if 00 [UHCI])
Subsystem: Asustek Computer, Inc. P4P800 Mainboard
Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
Latency: 0
Interrupt: pin B routed to IRQ 19
Region 4: I/O ports at ef20 [size=3D32]

00:1d.2 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #3
(rev 02) (prog-if 00 [UHCI])
Subsystem: Asustek Computer, Inc. P4P800 Mainboard
Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
Latency: 0
Interrupt: pin C routed to IRQ 18
Region 4: I/O ports at ef40 [size=3D32]

00:1d.3 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #4
(rev 02) (prog-if 00 [UHCI])
Subsystem: Asustek Computer, Inc. P4P800 Mainboard
Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
Latency: 0
Interrupt: pin A routed to IRQ 16
Region 4: I/O ports at ef80 [size=3D32]

00:1d.7 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB2 EHCI
Controller (rev 02) (prog-if 20 [EHCI])
Subsystem: Asustek Computer, Inc. P4P800 Mainboard
Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
Latency: 0
Interrupt: pin D routed to IRQ 23
Region 0: Memory at febffc00 (32-bit, non-prefetchable) [size=3D1K]
Capabilities: [50] Power Management version 2
=46lags: PMEClk- DSI- D1- D2- AuxCurrent=3D375mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
Capabilities: [58] #0a [20a0]

00:1e.0 PCI bridge: Intel Corp. 82801BA/CA/DB/EB/ER Hub interface to PC=
I
Bridge (rev c2) (prog-if 00 [Normal decode])
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort- <TAbor=
t-
<MAbort- >SERR- <PERR-
Latency: 0
Bus: primary=3D00, secondary=3D02, subordinate=3D02, sec-latency=3D64
I/O behind bridge: 0000d000-0000dfff
Memory behind bridge: fea00000-feafffff
Prefetchable memory behind bridge: fff00000-000fffff
BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-

00:1f.0 ISA bridge: Intel Corp. 82801EB/ER (ICH5/ICH5R) LPC Bridge (rev
02)
Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
Latency: 0

00:1f.1 IDE interface: Intel Corp. 82801EB/ER (ICH5/ICH5R) Ultra ATA 10=
0
Storage Controller (rev 02) (prog-if 8f [Master SecP SecO PriP PriO])
Subsystem: Asustek Computer, Inc. P4P800 Mainboard
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
Latency: 0
Interrupt: pin A routed to IRQ 18
Region 0: I/O ports at efe0 [size=3D8]
Region 1: I/O ports at efac [size=3D4]
Region 2: I/O ports at efa0 [size=3D8]
Region 3: I/O ports at efa8 [size=3D4]
Region 4: I/O ports at ef60 [size=3D16]
Region 5: Memory at 20000000 (32-bit, non-prefetchable) [size=3D1K]

00:1f.3 SMBus: Intel Corp. 82801EB/ER (ICH5/ICH5R) SMBus Controller (re=
v
02)
Subsystem: Asustek Computer, Inc. P4P800 Mainboard
Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
Interrupt: pin B routed to IRQ 17
Region 4: I/O ports at 0400 [size=3D32]

00:1f.5 Multimedia audio controller: Intel Corp. 82801EB/ER (ICH5/ICH5R=
)
AC'97 Audio Controller (rev 02)
Subsystem: Asustek Computer, Inc. P4P800 Mainboard
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
Latency: 0
Interrupt: pin B routed to IRQ 17
Region 0: I/O ports at e800 [size=3D256]
Region 1: I/O ports at ee80 [size=3D64]
Region 2: Memory at febff800 (32-bit, non-prefetchable) [size=3D512]
Region 3: Memory at febff400 (32-bit, non-prefetchable) [size=3D256]
Capabilities: [50] Power Management version 2
=46lags: PMEClk- DSI- D1- D2- AuxCurrent=3D375mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

01:00.0 VGA compatible controller: ATI Technologies Inc Radeon R350
[Radeon 9800] (prog-if 00 [VGA])
Subsystem: ATI Technologies Inc: Unknown device 3002
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping+ SERR+ FastB2B-
Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
Latency: 255 (2000ns min), cache line size 04
Interrupt: pin A routed to IRQ 16
Region 0: Memory at d0000000 (32-bit, prefetchable) [size=3D128M]
Region 1: I/O ports at c000 [size=3D256]
Region 2: Memory at fe9f0000 (32-bit, non-prefetchable) [size=3D64K]
Expansion ROM at fe9c0000 [disabled] [size=3D128K]
Capabilities: [58] AGP version 3.0
Status: RQ=3D255 SBA+ 64bit- FW+ Rate=3Dx1,x2
Command: RQ=3D31 SBA+ AGP+ 64bit- FW+ Rate=3Dx2
Capabilities: [50] Power Management version 2
=46lags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

01:00.1 Display controller: ATI Technologies Inc Radeon R350 [Radeon
9800] (Secondary)
Subsystem: ATI Technologies Inc: Unknown device 3003
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping+ SERR- FastB2B-
Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
Latency: 64 (2000ns min), cache line size 04
Region 0: Memory at c8000000 (32-bit, prefetchable) [size=3D128M]
Region 1: Memory at fe9e0000 (32-bit, non-prefetchable) [size=3D64K]
Capabilities: [50] Power Management version 2
=46lags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

02:03.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host
Controller (rev 80) (prog-if 10 [OHCI])
Subsystem: Asustek Computer, Inc.: Unknown device 808a
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
Latency: 64 (8000ns max), cache line size 04
Interrupt: pin A routed to IRQ 20
Region 0: Memory at feaff800 (32-bit, non-prefetchable) [size=3D2K]
Region 1: I/O ports at dc00 [size=3D128]
Capabilities: [50] Power Management version 2
=46lags: PMEClk- DSI- D1- D2+ AuxCurrent=3D0mA
PME(D0-,D1-,D2+,D3hot+,D3cold+)
Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

02:05.0 Ethernet controller: 3Com Corporation 3c940 1000Base? (rev 12)
Subsystem: Asustek Computer, Inc.: Unknown device 80eb
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
Latency: 64 (5750ns min, 7750ns max), cache line size 04
Interrupt: pin A routed to IRQ 22
Region 0: Memory at feaf8000 (32-bit, non-prefetchable) [size=3D16K]
Region 1: I/O ports at d800 [size=3D256]
Capabilities: [48] Power Management version 2
=46lags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
Status: D0 PME-Enable- DSel=3D7 DScale=3D1 PME-
Capabilities: [50] Vital Product Data

02:0d.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone=
]
(rev 30)
Subsystem: 3Com Corporation 3C905B Fast Etherlink XL 10/100
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
Latency: 64 (2500ns min, 2500ns max), cache line size 04
Interrupt: pin A routed to IRQ 21
Region 0: I/O ports at d480 [size=3D128]
Region 1: Memory at feaff400 (32-bit, non-prefetchable) [size=3D128]
Expansion ROM at feac0000 [disabled] [size=3D128K]
Capabilities: [dc] Power Management version 1
=46lags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA
PME(D0-,D1+,D2+,D3hot+,D3cold+)
Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-



May 11 17:43:10 trax syslogd 1.4.1: restart.
May 11 17:43:10 trax syslog: D=C3=A9marrage de syslogd succeeded
May 11 17:43:10 trax kernel: klogd 1.4.1, log source =3D /proc/kmsg
started.
May 11 17:43:10 trax kernel: Linux version 2.6.6 (root@trax.lan)
(version gcc 3.3.2 20031022 (Red Hat Linux 3.3.2-1)) #8 SMP Mon May 10
10:38:45 CEST 2004
May 11 17:43:10 trax kernel: BIOS-provided physical RAM map:
May 11 17:43:10 trax kernel:  BIOS-e820: 0000000000000000 -
000000000009fc00 (usable)
May 11 17:43:10 trax kernel:  BIOS-e820: 000000000009fc00 -
00000000000a0000 (reserved)
May 11 17:43:10 trax kernel:  BIOS-e820: 00000000000e8000 -
0000000000100000 (reserved)
May 11 17:43:10 trax kernel:  BIOS-e820: 0000000000100000 -
000000001ff30000 (usable)
May 11 17:43:10 trax kernel:  BIOS-e820: 000000001ff30000 -
000000001ff40000 (ACPI data)
May 11 17:43:10 trax kernel:  BIOS-e820: 000000001ff40000 -
000000001fff0000 (ACPI NVS)
May 11 17:43:10 trax kernel:  BIOS-e820: 000000001fff0000 -
0000000020000000 (reserved)
May 11 17:43:10 trax kernel:  BIOS-e820: 00000000ffb80000 -
0000000100000000 (reserved)
May 11 17:43:10 trax kernel: 0MB HIGHMEM available.
May 11 17:43:10 trax syslog: D=C3=A9marrage de klogd succeeded
May 11 17:43:10 trax kernel: 511MB LOWMEM available.
May 11 17:43:10 trax kernel: found SMP MP-table at 000ff780
May 11 17:43:10 trax kernel: On node 0 totalpages: 130864
May 11 17:43:10 trax kernel:   DMA zone: 4096 pages, LIFO batch:1
May 11 17:43:10 trax irqbalance: D=C3=A9marrage de irqbalance succeeded
May 11 17:43:10 trax kernel:   Normal zone: 126768 pages, LIFO batch:16
May 11 17:43:10 trax kernel:   HighMem zone: 0 pages, LIFO batch:1
May 11 17:43:10 trax kernel: DMI 2.3 present.
May 11 17:43:10 trax kernel: ACPI: RSDP (v002
ACPIAM                                    ) @ 0x000f9e60
May 11 17:43:10 trax kernel: ACPI: XSDT (v001 A M I  OEMXSDT  0x0800032=
0
MSFT 0x00000097) @ 0x1ff30100
May 11 17:43:10 trax kernel: ACPI: FADT (v003 A M I  OEMFACP  0x0800032=
0
MSFT 0x00000097) @ 0x1ff30290
May 11 17:43:10 trax portmap: D=C3=A9marrage de portmap succeeded
May 11 17:43:10 trax kernel: ACPI: MADT (v001 A M I  OEMAPIC  0x0800032=
0
MSFT 0x00000097) @ 0x1ff30390
May 11 17:43:10 trax kernel: ACPI: OEMB (v001 A M I  OEMBIOS  0x0800032=
0
MSFT 0x00000097) @ 0x1ff40040
May 11 17:43:10 trax kernel: ACPI: DSDT (v001  P4P81 P4P81086 0x0000008=
6
INTL 0x02002026) @ 0x00000000
May 11 17:43:10 trax kernel: ACPI: PM-Timer IO Port: 0x808
May 11 17:43:10 trax rpc.statd[1645]: Version 1.0.6 Starting
May 11 17:43:10 trax kernel: ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00]
enabled)
May 11 17:43:10 trax kernel: Processor #0 15:2 APIC version 20
May 11 17:43:10 trax nfslock: D=C3=A9marrage de rpc.statd succeeded
May 11 17:43:10 trax kernel: ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01]
enabled)
May 11 17:43:10 trax kernel: Processor #1 15:2 APIC version 20
May 11 17:43:10 trax kernel: ACPI: IOAPIC (id[0x02] address[0xfec00000]
global_irq_base[0x0])
May 11 17:43:10 trax kernel: IOAPIC[0]: Assigned apic_id 2
May 11 17:43:10 trax random: Initialisation du g=C3=A9n=C3=A9rateur de =
nombres
al=C3=A9atoires : succeeded
May 11 17:43:10 trax kernel: IOAPIC[0]: apic_id 2, version 32, address
0xfec00000, GSI 0-23
May 11 17:43:10 trax kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 0
global_irq 2 dfl dfl)
May 11 17:43:10 trax kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 9
global_irq 9 high level)
May 11 17:43:10 trax kernel: Enabling APIC mode:  Flat.  Using 1 I/O
APICs
May 11 17:43:10 trax kernel: Using ACPI (MADT) for SMP configuration
information
May 11 17:43:10 trax kernel: Built 1 zonelists
May 11 17:43:10 trax kernel: Kernel command line: ro root=3D/dev/hda2 r=
hgb
May 11 17:43:10 trax kernel: Initializing CPU#0
May 11 17:43:10 trax kernel: PID hash table entries: 2048 (order 11:
16384 bytes)
May 11 17:43:10 trax netfs: Montage d'autres syt=C3=A8mes de fichiers :
succeeded
May 11 17:43:10 trax kernel: Detected 2599.619 MHz processor.
May 11 17:43:10 trax kernel: Using pmtmr for high-res timesource
May 11 17:43:10 trax kernel: Console: colour VGA+ 80x25
May 11 17:43:10 trax kernel: Memory: 515684k/523456k available (1622k
kernel code, 7004k reserved, 736k data, 152k init, 0k highmem)
May 11 17:43:10 trax kernel: Checking if this processor honours the WP
bit even in supervisor mode... Ok.
May 11 17:43:10 trax kernel: Calibrating delay loop... 5144.57 BogoMIPS
May 11 17:43:10 trax kernel: Dentry cache hash table entries: 65536
(order: 6, 262144 bytes)
May 11 17:43:10 trax kernel: Inode-cache hash table entries: 32768
(order: 5, 131072 bytes)
May 11 17:43:11 trax kernel: Mount-cache hash table entries: 512 (order=
:
0, 4096 bytes)
May 11 17:43:11 trax autofs: automount startup succeeded
May 11 17:43:11 trax kernel: CPU: Trace cache: 12K uops, L1 D cache: 8K
May 11 17:43:11 trax kernel: CPU: L2 cache: 512K
May 11 17:43:11 trax kernel: CPU: Physical Processor ID: 0
May 11 17:43:11 trax smartd[1713]: smartd version 5.21 Copyright (C)
2002-3 Bruce Allen=20
May 11 17:43:11 trax smartd[1713]: Home page is
http://smartmontools.sourceforge.net/ =20
May 11 17:43:11 trax kernel: Enabling fast FPU save and restore... done=
=2E
May 11 17:43:11 trax smartd[1713]: Opened configuration file
/etc/smartd.conf=20
May 11 17:43:11 trax kernel: Enabling unmasked SIMD FPU exception
support... done.
May 11 17:43:11 trax smartd[1713]: Configuration file /etc/smartd.conf
parsed.=20
May 11 17:43:11 trax kernel: Checking 'hlt' instruction... OK.
May 11 17:43:11 trax smartd[1713]: Device: /dev/hda, opened=20
May 11 17:43:11 trax kernel: POSIX conformance testing by UNIFIX
May 11 17:43:11 trax kernel: CPU0: Intel(R) Pentium(R) 4 CPU 2.60GHz
stepping 09
May 11 17:43:11 trax smartd[1713]: Device: /dev/hda, not found in smart=
d
database.=20
May 11 17:43:11 trax kernel: per-CPU timeslice cutoff: 1462.80 usecs.
May 11 17:43:11 trax smartd[1713]: Device: /dev/hda, is SMART capable.
Adding to "monitor" list.=20
May 11 17:43:11 trax kernel: task migration cache decay timeout: 2
msecs.
May 11 17:43:11 trax smartd[1713]: Monitoring 1 ATA and 0 SCSI devices=20
May 11 17:43:11 trax kernel: enabled ExtINT on CPU#0
May 11 17:43:11 trax kernel: ESR value before enabling vector: 00000000
May 11 17:43:11 trax smartd[1715]: smartd has fork()ed into background
mode. New PID=3D1715.=20
May 11 17:43:11 trax kernel: ESR value after enabling vector: 00000000
May 11 17:43:11 trax smartd: D=C3=A9marrage de smartd succeeded
May 11 17:43:11 trax kernel: Booting processor 1/1 eip 3000
May 11 17:43:11 trax kernel: Initializing CPU#1
May 11 17:43:11 trax kernel: masked ExtINT on CPU#1
May 11 17:43:11 trax kernel: ESR value before enabling vector: 00000000
May 11 17:43:11 trax kernel: ESR value after enabling vector: 00000000
May 11 17:43:11 trax kernel: Calibrating delay loop... 5193.72 BogoMIPS
May 11 17:43:11 trax acpid: D=C3=A9marrage de acpid succeeded
May 11 17:43:11 trax kernel: CPU: Trace cache: 12K uops, L1 D cache: 8K
May 11 17:43:11 trax kernel: CPU: L2 cache: 512K
May 11 17:43:11 trax kernel: CPU: Physical Processor ID: 0
May 11 17:43:11 trax yum:  succeeded
May 11 17:43:11 trax kernel: CPU1: Intel(R) Pentium(R) 4 CPU 2.60GHz
stepping 09
May 11 17:43:11 trax kernel: Total of 2 processors activated (10338.30
BogoMIPS).
May 11 17:43:11 trax kernel: cpu_sibling_map[0] =3D 1
May 11 17:43:11 trax kernel: cpu_sibling_map[1] =3D 0
May 11 17:43:12 trax kernel: ENABLING IO-APIC IRQs
May 11 17:43:12 trax kernel: ..TIMER: vector=3D0x31 pin1=3D2 pin2=3D-1
May 11 17:43:12 trax kernel: Using local APIC timer interrupts.
May 11 17:43:12 trax kernel: calibrating APIC timer ...
May 11 17:43:12 trax kernel: ..... CPU clock speed is 2598.0332 MHz.
May 11 17:43:12 trax kernel: ..... host bus clock speed is 199.0871 MHz=
=2E
May 11 17:43:12 trax kernel: checking TSC synchronization across 2 CPUs=
:
passed.
May 11 17:43:12 trax kernel: Brought up 2 CPUs
May 11 17:43:13 trax kernel: NET: Registered protocol family 16
May 11 17:43:13 trax kernel: PCI: PCI BIOS revision 2.10 entry at
0xf0031, last bus=3D2
May 11 17:43:13 trax kernel: PCI: Using configuration type 1
May 11 17:43:13 trax kernel: mtrr: v2.0 (20020519)
May 11 17:43:13 trax kernel: ACPI: Subsystem revision 20040326
May 11 17:43:13 trax kernel: ACPI: Interpreter enabled
May 11 17:43:13 trax kernel: ACPI: Using IOAPIC for interrupt routing
May 11 17:43:13 trax kernel: ACPI: PCI Root Bridge [PCI0] (00:00)
May 11 17:43:13 trax kernel: PCI: Probing PCI hardware (bus 00)
May 11 17:43:13 trax kernel: Transparent bridge - 0000:00:1e.0
May 11 17:43:13 trax kernel: ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 =
5
6 7 *10 11 12 14 15)
May 11 17:43:13 trax kernel: ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 =
5
6 7 10 *11 12 14 15)
May 11 17:43:13 trax kernel: ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4
*5 6 7 10 11 12 14 15)
May 11 17:43:13 trax kernel: ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4
*5 6 7 10 11 12 14 15)
May 11 17:43:13 trax kernel: ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 =
5
6 7 10 *11 12 14 15)
May 11 17:43:13 trax kernel: ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 =
5
6 7 10 11 12 14 15) *0, disabled.
May 11 17:43:13 trax kernel: ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 =
5
6 7 10 *11 12 14 15)
May 11 17:43:13 trax kernel: ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 =
5
6 7 10 *11 12 14 15)
May 11 17:43:13 trax kernel: testing the IO APIC.......................
May 11 17:43:13 trax kernel: .................................... done.
May 11 17:43:13 trax kernel: PCI: Using ACPI for IRQ routing
May 11 17:43:13 trax kernel: Starting balanced_irq
May 11 17:43:13 trax kernel: Total HugeTLB memory allocated, 0
May 11 17:43:13 trax kernel: Initializing Cryptographic API
May 11 17:43:13 trax kernel: Real Time Clock Driver v1.12
May 11 17:43:13 trax kernel: Serial: 8250/16550 driver $Revision: 1.90 =
$
8 ports, IRQ sharing disabled
May 11 17:43:13 trax kernel: ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
May 11 17:43:13 trax kernel: ttyS1 at I/O 0x2f8 (irq =3D 3) is a 16550A
May 11 17:43:13 trax kernel: loop: loaded (max 8 devices)
May 11 17:43:13 trax kernel: Uniform Multi-Platform E-IDE driver
Revision: 7.00alpha2
May 11 17:43:13 trax kernel: ide: Assuming 33MHz system bus speed for
PIO modes; override with idebus=3Dxx
May 11 17:43:13 trax kernel: ICH5: IDE controller at PCI slot
0000:00:1f.1
May 11 17:43:13 trax kernel: PCI: Enabling device 0000:00:1f.1 (0005 ->
0007)
May 11 17:43:13 trax kernel: ICH5: chipset revision 2
May 11 17:43:13 trax kernel: ICH5: 100%% native mode on irq 18
May 11 17:43:13 trax kernel:     ide0: BM-DMA at 0xef60-0xef67, BIOS
settings: hda:DMA, hdb:pio
May 11 17:43:13 trax kernel:     ide1: BM-DMA at 0xef68-0xef6f, BIOS
settings: hdc:DMA, hdd:pio
May 11 17:43:13 trax kernel: hda: ST3120026A, ATA DISK drive
May 11 17:43:13 trax kernel: Using anticipatory io scheduler
May 11 17:43:13 trax kernel: ide0 at 0xefe0-0xefe7,0xefae on irq 18
May 11 17:43:13 trax kernel: hdc: PIONEER DVD-RW DVR-105, ATAPI
CD/DVD-ROM drive
May 11 17:43:13 trax kernel: ide1 at 0xefa0-0xefa7,0xefaa on irq 18
May 11 17:43:13 trax kernel: hda: max request size: 1024KiB
May 11 17:43:13 trax kernel: hda: 234441648 sectors (120034 MB)
w/8192KiB Cache, CHS=3D16383/255/63, UDMA(33)
May 11 17:43:13 trax kernel:  hda: hda1 hda2 hda3 hda4 < hda5 hda6 >
May 11 17:43:13 trax kernel: ide-floppy driver 0.99.newide
May 11 17:43:13 trax kernel: mice: PS/2 mouse device common for all mic=
e
May 11 17:43:13 trax kernel: serio: i8042 AUX port at 0x60,0x64 irq 12
May 11 17:43:13 trax kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
May 11 17:43:13 trax kernel: input: AT Translated Set 2 keyboard on
isa0060/serio0
May 11 17:43:13 trax kernel: NET: Registered protocol family 2
May 11 17:43:14 trax kernel: IP: routing cache hash table of 4096
buckets, 32Kbytes
May 11 17:43:14 trax cupsd: cupsd: Child exited with status 99!
May 11 17:43:14 trax kernel: TCP: Hash tables configured (established
32768 bind 32768)
May 11 17:43:14 trax kernel: Initializing IPsec netlink socket
May 11 17:43:14 trax cups: D=C3=A9marrage de cupsd succeeded
May 11 17:43:14 trax kernel: NET: Registered protocol family 1
May 11 17:43:14 trax kernel: NET: Registered protocol family 17
May 11 17:43:14 trax kernel: ACPI: (supports S0 S1 S3 S4 S5)
May 11 17:43:14 trax kernel: BIOS EDD facility v0.13 2004-Mar-09, 1
devices found
May 11 17:43:14 trax sshd:  succeeded
May 11 17:43:14 trax kernel: Please report your BIOS at
http://linux.dell.com/edd/results.html
May 11 17:43:14 trax kernel: kjournald starting.  Commit interval 5
seconds
May 11 17:43:14 trax kernel: EXT3-fs: mounted filesystem with ordered
data mode.
May 11 17:43:15 trax xinetd: D=C3=A9marrage de xinetd succeeded
May 11 17:43:15 trax kernel: VFS: Mounted root (ext3 filesystem)
readonly.
May 11 17:43:15 trax kernel: Freeing unused kernel memory: 152k freed
May 11 17:43:15 trax kernel: Linux agpgart interface v0.100 (c) Dave
Jones
May 11 17:43:15 trax kernel: fglrx: module license 'Proprietary. (C)
2002 - ATI Technologies, Starnberg, GERMANY' taints kernel.
May 11 17:43:15 trax kernel: [fglrx] Maximum main memory to use for
locked dma buffers: 432 MBytes.
May 11 17:43:15 trax kernel: [fglrx] module loaded - fglrx 3.7.6 [Mar  =
5
2004] on minor 0
May 11 17:43:15 trax kernel: [fglrx:firegl_unlock] *ERROR* Process 474
using kernel context 0
May 11 17:43:15 trax kernel: atkbd.c: Unknown key released (translated
set 2, code 0x7a on isa0060/serio0).
May 11 17:43:15 trax kernel: atkbd.c: This is an XFree86 bug. It
shouldn't access hardware directly.
May 11 17:43:15 trax kernel: atkbd.c: Unknown key released (translated
set 2, code 0x7a on isa0060/serio0).
May 11 17:43:15 trax kernel: atkbd.c: This is an XFree86 bug. It
shouldn't access hardware directly.
May 11 17:43:15 trax kernel: ACPI: Power Button (FF) [PWRF]
May 11 17:43:15 trax kernel: ACPI: Processor [CPU1] (supports C1)
May 11 17:43:15 trax kernel: ACPI: Processor [CPU2] (supports C1)
May 11 17:43:15 trax kernel: usbcore: registered new driver usbfs
May 11 17:43:15 trax kernel: usbcore: registered new driver hub
May 11 17:43:15 trax kernel: USB Universal Host Controller Interface
driver v2.2
May 11 17:43:15 trax kernel: uhci_hcd 0000:00:1d.0: Intel Corp. 82801EB
USB
May 11 17:43:15 trax kernel: uhci_hcd 0000:00:1d.0: irq 16, io base
0000ef00
May 11 17:43:15 trax kernel: uhci_hcd 0000:00:1d.0: new USB bus
registered, assigned bus number 1
May 11 17:43:15 trax kernel: hub 1-0:1.0: USB hub found
May 11 17:43:15 trax kernel: hub 1-0:1.0: 2 ports detected
May 11 17:43:15 trax kernel: uhci_hcd 0000:00:1d.1: Intel Corp. 82801EB
USB
May 11 17:43:15 trax kernel: uhci_hcd 0000:00:1d.1: irq 19, io base
0000ef20
May 11 17:43:15 trax kernel: uhci_hcd 0000:00:1d.1: new USB bus
registered, assigned bus number 2
May 11 17:43:15 trax kernel: hub 2-0:1.0: USB hub found
May 11 17:43:15 trax kernel: hub 2-0:1.0: 2 ports detected
May 11 17:43:15 trax kernel: uhci_hcd 0000:00:1d.2: Intel Corp. 82801EB
USB
May 11 17:43:15 trax kernel: uhci_hcd 0000:00:1d.2: irq 18, io base
0000ef40
May 11 17:43:15 trax kernel: uhci_hcd 0000:00:1d.2: new USB bus
registered, assigned bus number 3
May 11 17:43:15 trax kernel: hub 3-0:1.0: USB hub found
May 11 17:43:15 trax kernel: hub 3-0:1.0: 2 ports detected
May 11 17:43:15 trax xinetd[1949]: xinetd Version 2.3.12 started with
libwrap loadavg options compiled in.
May 11 17:43:15 trax kernel: uhci_hcd 0000:00:1d.3: Intel Corp. 82801EB
USB
May 11 17:43:15 trax xinetd[1949]: Started working: 0 available service=
s
May 11 17:43:15 trax kernel: uhci_hcd 0000:00:1d.3: irq 16, io base
0000ef80
May 11 17:43:15 trax kernel: uhci_hcd 0000:00:1d.3: new USB bus
registered, assigned bus number 4
May 11 17:43:15 trax kernel: hub 4-0:1.0: USB hub found
May 11 17:43:15 trax kernel: hub 4-0:1.0: 2 ports detected
May 11 17:43:15 trax kernel: usb 2-1: new low speed USB device using
address 2
May 11 17:43:15 trax kernel: EXT3 FS on hda2, internal journal
May 11 17:43:15 trax kernel: Adding 522104k swap on /dev/hda3.=20
Priority:-1 extents:1
May 11 17:43:15 trax kernel: usbcore: registered new driver hiddev
May 11 17:43:15 trax kernel: drivers/usb/input/hid-core.c: ctrl urb
status -32 received
May 11 17:43:15 trax kernel: drivers/usb/input/hid-core.c: ctrl urb
status -32 received
May 11 17:43:15 trax gpm: D=C3=A9marrage de gpm succeeded
May 11 17:43:15 trax kernel: drivers/usb/input/hid-core.c: ctrl urb
status -32 received
May 11 17:43:15 trax kernel: input: USB HID v1.10 Joystick [Saitek PLC
Cyborg Force Rumble Pad] on usb-0000:00:1d.1-1
May 11 17:43:15 trax kernel: usbcore: registered new driver hid
May 11 17:43:15 trax kernel: drivers/usb/input/hid-core.c: v2.0:USB HID
core driver
May 11 17:43:15 trax kernel: usb 1-1: new low speed USB device using
address 2
May 11 17:43:15 trax kernel: input: USB HID v1.10 Mouse [Logitech USB
Optical Mouse] on usb-0000:00:1d.0-1
May 11 17:43:15 trax kernel: usbcore: registered new driver usbmouse
May 11 17:43:15 trax kernel: drivers/usb/input/usbmouse.c: v1.6:USB HID
Boot Protocol mouse driver
May 11 17:43:16 trax kernel: usb 1-2: new full speed USB device using
address 3
May 11 17:43:16 trax kernel: drivers/usb/class/usblp.c: usblp0: USB
Bidirectional printer dev 3 if 0 alt 1 proto 2 vid 0x03F0 pid 0x1017
May 11 17:43:16 trax kernel: usbcore: registered new driver usblp
May 11 17:43:16 trax kernel: drivers/usb/class/usblp.c: v0.13: USB
Printer Device Class driver
May 11 17:43:16 trax kernel: kjournald starting.  Commit interval 5
seconds
May 11 17:43:16 trax kernel: EXT3 FS on hda6, internal journal
May 11 17:43:16 trax kernel: EXT3-fs: mounted filesystem with ordered
data mode.
May 11 17:43:16 trax kernel: parport0: PC-style at 0x378 (0x778)
[PCSPP,TRISTATE,EPP]
May 11 17:43:16 trax kernel: parport0: irq 7 detected
May 11 17:43:16 trax kernel: lp0: using parport0 (polling).
May 11 17:43:18 trax httpd: D=C3=A9marrage de httpd succeeded
May 11 17:43:18 trax crond: D=C3=A9marrage de crond succeeded
May 11 17:43:20 trax xfs: D=C3=A9marrage de xfs succeeded
May 11 17:43:20 trax anacron: D=C3=A9marrage de anacron succeeded
May 11 17:43:20 trax atd: D=C3=A9marrage de atd succeeded
May 11 17:43:20 trax xfs: ignoring font path element
/usr/X11R6/lib/X11/fonts/cyrillic (unreadable)=20
May 11 17:43:20 trax messagebus: D=C3=A9marrage de messagebus succeeded
May 11 17:43:20 trax kernel: agpgart: Detected an Intel 865 Chipset.
May 11 17:43:20 trax kernel: agpgart: Maximum main memory to use for ag=
p
memory: 439M
May 11 17:43:20 trax kernel: agpgart: AGP aperture is 256M @ 0xe0000000
May 11 17:43:21 trax kernel: AC'97 0 analog subsections not ready
May 11 17:43:21 trax kernel: intel8x0_measure_ac97_clock: measured 4947=
5
usecs
May 11 17:43:21 trax kernel: intel8x0: clocking to 48000
May 11 17:43:21 trax input.agent[2236]: ... no modules for INPUT produc=
t
May 11 17:43:21 trax su(pam_unix)[2234]: session opened for user
mldonkey by (uid=3D0)
May 11 17:43:24 trax kernel: [fglrx] AGP detected, AgpState   =3D
0x1f004a1b (hardware caps of chipset)
May 11 17:43:24 trax kernel: agpgart: Found an AGP 3.0 compliant device
at 0000:00:00.0.
May 11 17:43:24 trax kernel: agpgart: Putting AGP V3 device at
0000:00:00.0 into 8x mode
May 11 17:43:24 trax kernel: agpgart: Putting AGP V3 device at
0000:01:00.0 into 8x mode
May 11 17:43:24 trax kernel: [fglrx] AGP enabled,  AgpCommand =3D
0x1f004312 (selected caps)
May 11 17:43:24 trax kernel: [fglrx] free  AGP =3D 256126976
May 11 17:43:24 trax kernel: [fglrx] max   AGP =3D 256126976
May 11 17:43:24 trax kernel: [fglrx] free  LFB =3D 120176640
May 11 17:43:24 trax kernel: [fglrx] max   LFB =3D 120176640
May 11 17:43:24 trax kernel: [fglrx] free  Inv =3D 0
May 11 17:43:24 trax kernel: [fglrx] max   Inv =3D 0
May 11 17:43:24 trax kernel: [fglrx] total Inv =3D 0
May 11 17:43:24 trax kernel: [fglrx] total TIM =3D 0
May 11 17:43:24 trax kernel: [fglrx] total FB  =3D 0
May 11 17:43:24 trax kernel: [fglrx] total AGP =3D 65536
May 11 17:43:24 trax kernel: atkbd.c: Unknown key released (translated
set 2, code 0x7a on isa0060/serio0).
May 11 17:43:24 trax kernel: atkbd.c: This is an XFree86 bug. It
shouldn't access hardware directly.
May 11 17:43:24 trax kernel: atkbd.c: Unknown key released (translated
set 2, code 0x7a on isa0060/serio0).
May 11 17:43:24 trax kernel: atkbd.c: This is an XFree86 bug. It
shouldn't access hardware directly.
May 11 17:43:35 trax gdm(pam_unix)[2594]: session opened for user
stephane by (uid=3D0)
May 11 17:43:36 trax gconfd (stephane-2708): d=C3=A9marrage (version 2.=
4.0),
pid 2708 utilisateur =C2=AB=C2 stephane=C2 =C2=BB
May 11 17:43:36 trax gconfd (stephane-2708): Adresse =C2=AB=C2
xml:readonly:/etc/gconf/gconf.xml.mandatory=C2 =C2=BB r=C3=A9solue vers=
 une source
de configuration en lecture seule =C3  la position 0
May 11 17:43:36 trax gconfd (stephane-2708): Adresse =C2=AB=C2
xml:readwrite:/home/stephane/.gconf=C2 =C2=BB r=C3=A9solue vers une sou=
rce de
configuration enregistrable =C3  la position 1
May 11 17:43:36 trax gconfd (stephane-2708): Adresse =C2=AB=C2
xml:readonly:/etc/gconf/gconf.xml.defaults=C2 =C2=BB r=C3=A9solue vers =
une source
de configuration en lecture seule =C3  la position 2
May 11 17:43:42 trax kernel: hdc: ATAPI 32X DVD-ROM DVD-R CD-R/RW drive=
,
2000kB Cache, UDMA(33)
May 11 17:43:42 trax kernel: Uniform CD-ROM driver Revision: 3.20
May 11 17:43:42 trax kernel: inserting floppy driver for 2.6.6
May 11 17:43:42 trax kernel: Floppy drive(s): fd0 is 1.44M
May 11 17:43:42 trax kernel: FDC 0 is a post-1991 82077
May 11 17:43:42 trax kernel: SCSI subsystem initialized
May 11 17:43:43 trax kernel: irq 18: nobody cared!
May 11 17:43:43 trax kernel: Call Trace:
May 11 17:43:43 trax kernel:  [<c01062b6>] __report_bad_irq+0x2a/0x8b
May 11 17:43:43 trax kernel:  [<c01063a0>] note_interrupt+0x6f/0x9f
May 11 17:43:43 trax kernel:  [<c01066be>] do_IRQ+0x161/0x192
May 11 17:43:43 trax kernel:  [<c0104a1c>] common_interrupt+0x18/0x20
May 11 17:43:43 trax kernel:  [<c010201e>] default_idle+0x0/0x2c
May 11 17:43:45 trax kernel:  [<c0102047>] default_idle+0x29/0x2c
May 11 17:43:45 trax kernel:  [<c01020b0>] cpu_idle+0x33/0x3c
May 11 17:43:47 trax kernel:  [<c035085d>] start_kernel+0x183/0x1b2
May 11 17:43:49 trax kernel:  [<c0350433>] unknown_bootoption+0x0/0x110
May 11 17:43:51 trax kernel:=20
May 11 17:43:53 trax kernel: handlers:
May 11 17:43:55 trax kernel: [<c021d201>] (ide_intr+0x0/0x1cb)
May 11 17:43:57 trax kernel: [<c021d201>] (ide_intr+0x0/0x1cb)
May 11 17:43:57 trax kernel: [<e08addb4>] (usb_hcd_irq+0x0/0x67
[usbcore])
May 11 17:43:59 trax kernel: Disabling IRQ #18
May 11 17:43:59 trax kernel: cdrom: This disc doesn't have any tracks I
recognize!
May 11 17:43:59 trax kernel: irq 18: nobody cared!
May 11 17:44:01 trax kernel: Call Trace:
May 11 17:44:01 trax kernel:  [<c01062b6>] __report_bad_irq+0x2a/0x8b
May 11 17:44:02 trax kernel:  [<c01063a0>] note_interrupt+0x6f/0x9f
May 11 17:44:02 trax kernel:  [<c01066be>] do_IRQ+0x161/0x192
May 11 17:44:02 trax kernel:  [<c0104a1c>] common_interrupt+0x18/0x20
May 11 17:44:02 trax kernel:  [<c010201e>] default_idle+0x0/0x2c
May 11 17:44:02 trax kernel:  [<c0102047>] default_idle+0x29/0x2c
May 11 17:44:02 trax kernel:  [<c01020b0>] cpu_idle+0x33/0x3c
May 11 17:44:02 trax kernel:  [<c011d795>] printk+0x1a1/0x1eb
May 11 17:44:02 trax kernel:=20
May 11 17:44:02 trax kernel: handlers:
May 11 17:44:02 trax kernel: [<c021d201>] (ide_intr+0x0/0x1cb)
May 11 17:44:03 trax kernel: [<c021d201>] (ide_intr+0x0/0x1cb)
May 11 17:44:05 trax kernel: [<e08addb4>] (usb_hcd_irq+0x0/0x67
[usbcore])
May 11 17:44:05 trax kernel: Disabling IRQ #18
May 11 17:44:05 trax kernel: irq 18: nobody cared!
May 11 17:44:05 trax kernel: Call Trace:
May 11 17:44:07 trax kernel:  [<c01062b6>] __report_bad_irq+0x2a/0x8b
May 11 17:44:07 trax kernel:  [<c01063a0>] note_interrupt+0x6f/0x9f
May 11 17:44:09 trax kernel:  [<c01066be>] do_IRQ+0x161/0x192
May 11 17:44:11 trax kernel:  [<c0104a1c>] common_interrupt+0x18/0x20
May 11 17:44:11 trax kernel:  [<c01210c2>] __do_softirq+0x42/0xaa
May 11 17:44:11 trax kernel:  [<c0121157>] do_softirq+0x2d/0x2f
May 11 17:44:11 trax kernel:  [<c010669b>] do_IRQ+0x13e/0x192
May 11 17:44:11 trax kernel:  [<c0104a1c>] common_interrupt+0x18/0x20
May 11 17:44:11 trax kernel:  [<c0293e48>] schedule+0x3b4/0x6b6
May 11 17:44:11 trax kernel:  [<c012c27f>] queue_work+0x7b/0x87
May 11 17:44:11 trax kernel:  [<c0294174>] preempt_schedule+0x2a/0x43
May 11 17:44:11 trax kernel:  [<c020beda>] __make_request+0x356/0x59f
May 11 17:44:11 trax kernel:  [<c020c22d>]
generic_make_request+0x10a/0x18b
May 11 17:44:11 trax kernel:  [<c0176f57>] do_mpage_readpage+0x1f5/0x3a=
a
May 11 17:44:11 trax kernel:  [<c020c31f>] submit_bio+0x71/0x122
May 11 17:44:11 trax kernel:  [<c0140d06>] __pagevec_lru_add+0xfe/0x127
May 11 17:44:12 trax kernel:  [<c0176c36>] mpage_bio_submit+0x23/0x32
May 11 17:44:12 trax kernel:  [<c01771fc>] mpage_readpages+0xf0/0x12a
May 11 17:44:12 trax kernel:  [<c018f9ba>] ext3_get_block+0x0/0x96
May 11 17:44:13 trax kernel:  [<c0293e16>] schedule+0x382/0x6b6
May 11 17:44:15 trax kernel:  [<c013d698>] read_pages+0x106/0x10c
May 11 17:44:15 trax kernel:  [<c018f9ba>] ext3_get_block+0x0/0x96
May 11 17:44:15 trax kernel:  [<c013b117>] buffered_rmqueue+0x115/0x247
May 11 17:44:15 trax kernel:  [<c013b2de>] __alloc_pages+0x95/0x2ef
May 11 17:44:15 trax kernel:  [<c013d9e3>]
do_page_cache_readahead+0x128/0x1b9
May 11 17:44:15 trax kernel:  [<c01383b0>] filemap_nopage+0x2dd/0x33b
May 11 17:44:15 trax kernel:  [<c0146c32>] do_no_page+0xcd/0x322
May 11 17:44:15 trax kernel:  [<c01448c1>] pte_alloc_map+0xbd/0xfe
May 11 17:44:15 trax kernel:  [<c01470b6>] handle_mm_fault+0x111/0x1bb
May 11 17:44:15 trax kernel:  [<c011627f>] do_page_fault+0x328/0x512
May 11 17:44:15 trax kernel:  [<c0156126>] __fput+0xc7/0x125
May 11 17:44:15 trax kernel:  [<c01c1978>] copy_from_user+0x4a/0x76
May 11 17:44:15 trax kernel:  [<c01294c1>] sys_rt_sigaction+0x87/0xbc
May 11 17:44:15 trax kernel:  [<c01284a2>] sigprocmask+0x64/0xf0
May 11 17:44:15 trax kernel:  [<c01c191e>] copy_to_user+0x3e/0x4e
May 11 17:44:16 trax kernel:  [<c0115f57>] do_page_fault+0x0/0x512
May 11 17:44:16 trax kernel:  [<c0104b19>] error_code+0x2d/0x38
May 11 17:44:16 trax kernel:=20
May 11 17:44:16 trax kernel: handlers:
May 11 17:44:16 trax kernel: [<c021d201>] (ide_intr+0x0/0x1cb)
May 11 17:44:16 trax kernel: [<c021d201>] (ide_intr+0x0/0x1cb)
May 11 17:44:16 trax kernel: [<e08addb4>] (usb_hcd_irq+0x0/0x67
[usbcore])
May 11 17:44:16 trax kernel: Disabling IRQ #18
May 11 17:44:17 trax kernel: irq 18: nobody cared!
May 11 17:44:17 trax kernel: Call Trace:
May 11 17:44:17 trax kernel:  [<c01062b6>] __report_bad_irq+0x2a/0x8b
May 11 17:44:17 trax kernel:  [<c01063a0>] note_interrupt+0x6f/0x9f
May 11 17:44:17 trax kernel:  [<c01066be>] do_IRQ+0x161/0x192
May 11 17:44:17 trax kernel:  [<c0104a1c>] common_interrupt+0x18/0x20
May 11 17:44:19 trax kernel:  [<c010201e>] default_idle+0x0/0x2c
May 11 17:44:19 trax kernel:  [<c0102047>] default_idle+0x29/0x2c
May 11 17:44:19 trax kernel:  [<c01020b0>] cpu_idle+0x33/0x3c
May 11 17:44:19 trax kernel:  [<c011d795>] printk+0x1a1/0x1eb
May 11 17:44:19 trax kernel:=20
May 11 17:44:19 trax kernel: handlers:
May 11 17:44:19 trax kernel: [<c021d201>] (ide_intr+0x0/0x1cb)
May 11 17:44:19 trax kernel: [<c021d201>] (ide_intr+0x0/0x1cb)
May 11 17:44:19 trax kernel: [<e08addb4>] (usb_hcd_irq+0x0/0x67
[usbcore])
May 11 17:44:19 trax kernel: Disabling IRQ #18
May 11 17:44:19 trax kernel: irq 18: nobody cared!
May 11 17:44:19 trax kernel: Call Trace:
May 11 17:44:19 trax kernel:  [<c01062b6>] __report_bad_irq+0x2a/0x8b
May 11 17:44:19 trax kernel:  [<c01063a0>] note_interrupt+0x6f/0x9f
May 11 17:44:19 trax kernel:  [<c01066be>] do_IRQ+0x161/0x192
May 11 17:44:19 trax kernel:  [<c0104a1c>] common_interrupt+0x18/0x20
May 11 17:44:19 trax kernel:  [<c010201e>] default_idle+0x0/0x2c
May 11 17:44:19 trax kernel:  [<c0102047>] default_idle+0x29/0x2c
May 11 17:44:19 trax kernel:  [<c01020b0>] cpu_idle+0x33/0x3c
May 11 17:44:19 trax kernel:  [<c011d795>] printk+0x1a1/0x1eb
May 11 17:44:19 trax kernel:=20
May 11 17:44:19 trax kernel: handlers:
May 11 17:44:19 trax kernel: [<c021d201>] (ide_intr+0x0/0x1cb)
May 11 17:44:19 trax kernel: [<c021d201>] (ide_intr+0x0/0x1cb)
May 11 17:44:19 trax kernel: [<e08addb4>] (usb_hcd_irq+0x0/0x67
[usbcore])
May 11 17:44:19 trax kernel: Disabling IRQ #18
May 11 17:44:19 trax kernel: irq 18: nobody cared!
May 11 17:44:19 trax kernel: Call Trace:
May 11 17:44:19 trax kernel:  [<c01062b6>] __report_bad_irq+0x2a/0x8b
May 11 17:44:19 trax kernel:  [<c01063a0>] note_interrupt+0x6f/0x9f
May 11 17:44:19 trax kernel:  [<c01066be>] do_IRQ+0x161/0x192
May 11 17:44:19 trax kernel:  [<c0104a1c>] common_interrupt+0x18/0x20
May 11 17:44:19 trax kernel:  [<c010201e>] default_idle+0x0/0x2c
May 11 17:44:19 trax kernel:  [<c0102047>] default_idle+0x29/0x2c
May 11 17:44:19 trax kernel:  [<c01020b0>] cpu_idle+0x33/0x3c
May 11 17:44:19 trax kernel:  [<c011d795>] printk+0x1a1/0x1eb
May 11 17:44:19 trax kernel:=20
May 11 17:44:19 trax kernel: handlers:
May 11 17:44:19 trax kernel: [<c021d201>] (ide_intr+0x0/0x1cb)
May 11 17:44:19 trax kernel: [<c021d201>] (ide_intr+0x0/0x1cb)
May 11 17:44:19 trax kernel: [<e08addb4>] (usb_hcd_irq+0x0/0x67
[usbcore])
May 11 17:44:19 trax kernel: Disabling IRQ #18
May 11 17:44:19 trax kernel: irq 18: nobody cared!
May 11 17:44:19 trax kernel: Call Trace:
May 11 17:44:19 trax kernel:  [<c01062b6>] __report_bad_irq+0x2a/0x8b
May 11 17:44:19 trax kernel:  [<c01063a0>] note_interrupt+0x6f/0x9f
May 11 17:44:19 trax kernel:  [<c01066be>] do_IRQ+0x161/0x192
May 11 17:44:19 trax kernel:  [<c0104a1c>] common_interrupt+0x18/0x20
May 11 17:44:19 trax kernel:  [<c010201e>] default_idle+0x0/0x2c
May 11 17:44:19 trax kernel:  [<c0102047>] default_idle+0x29/0x2c
May 11 17:44:19 trax kernel:  [<c01020b0>] cpu_idle+0x33/0x3c
May 11 17:44:19 trax kernel:  [<c035085d>] start_kernel+0x183/0x1b2
May 11 17:44:19 trax kernel:  [<c0350433>] unknown_bootoption+0x0/0x110
May 11 17:44:19 trax kernel:=20
May 11 17:44:19 trax kernel: handlers:
May 11 17:44:19 trax kernel: [<c021d201>] (ide_intr+0x0/0x1cb)
May 11 17:44:19 trax kernel: [<c021d201>] (ide_intr+0x0/0x1cb)
May 11 17:44:19 trax kernel: [<e08addb4>] (usb_hcd_irq+0x0/0x67
[usbcore])
May 11 17:44:19 trax kernel: Disabling IRQ #18
May 11 17:44:19 trax kernel: irq 18: nobody cared!
May 11 17:44:19 trax kernel: Call Trace:
May 11 17:44:19 trax kernel:  [<c01062b6>] __report_bad_irq+0x2a/0x8b
May 11 17:44:19 trax kernel:  [<c01063a0>] note_interrupt+0x6f/0x9f
May 11 17:44:19 trax kernel:  [<c01066be>] do_IRQ+0x161/0x192
May 11 17:44:19 trax kernel:  [<c0104a1c>] common_interrupt+0x18/0x20
May 11 17:44:19 trax kernel:=20
May 11 17:44:19 trax kernel: handlers:
May 11 17:44:20 trax kernel: [<c021d201>] (ide_intr+0x0/0x1cb)
May 11 17:44:20 trax kernel: [<c021d201>] (ide_intr+0x0/0x1cb)
May 11 17:44:20 trax kernel: [<e08addb4>] (usb_hcd_irq+0x0/0x67
[usbcore])
May 11 17:44:20 trax kernel: Disabling IRQ #18
May 11 17:44:20 trax kernel: irq 18: nobody cared!
May 11 17:44:20 trax kernel: Call Trace:
May 11 17:44:20 trax kernel:  [<c01062b6>] __report_bad_irq+0x2a/0x8b
May 11 17:44:20 trax kernel:  [<c01063a0>] note_interrupt+0x6f/0x9f
May 11 17:44:20 trax kernel:  [<c01066be>] do_IRQ+0x161/0x192
May 11 17:44:20 trax kernel:  [<c0104a1c>] common_interrupt+0x18/0x20
May 11 17:44:20 trax kernel:  [<c010201e>] default_idle+0x0/0x2c
May 11 17:44:20 trax kernel:  [<c0102047>] default_idle+0x29/0x2c
May 11 17:44:20 trax kernel:  [<c01020b0>] cpu_idle+0x33/0x3c
May 11 17:44:20 trax kernel:  [<c035085d>] start_kernel+0x183/0x1b2
May 11 17:44:20 trax kernel:  [<c0350433>] unknown_bootoption+0x0/0x110
May 11 17:44:20 trax kernel:=20
May 11 17:44:20 trax kernel: handlers:
May 11 17:44:20 trax kernel: [<c021d201>] (ide_intr+0x0/0x1cb)
May 11 17:44:20 trax kernel: [<c021d201>] (ide_intr+0x0/0x1cb)
May 11 17:44:20 trax kernel: [<e08addb4>] (usb_hcd_irq+0x0/0x67
[usbcore])
May 11 17:44:20 trax kernel: Disabling IRQ #18
May 11 17:44:20 trax kernel: irq 18: nobody cared!
May 11 17:44:20 trax kernel: Call Trace:
May 11 17:44:20 trax kernel:  [<c01062b6>] __report_bad_irq+0x2a/0x8b
May 11 17:44:20 trax kernel:  [<c01063a0>] note_interrupt+0x6f/0x9f
May 11 17:44:20 trax kernel:  [<c01066be>] do_IRQ+0x161/0x192
May 11 17:44:20 trax kernel:  [<c0104a1c>] common_interrupt+0x18/0x20
May 11 17:44:20 trax kernel:  [<c0211a51>] as_work_handler+0x47/0x81
May 11 17:44:20 trax kernel:  [<c012c53f>] worker_thread+0x1e6/0x29d
May 11 17:44:20 trax kernel:  [<c0211a0a>] as_work_handler+0x0/0x81
May 11 17:44:20 trax kernel:  [<c0118e2d>]
default_wake_function+0x0/0x12
May 11 17:44:20 trax kernel:  [<c0118e2d>]
default_wake_function+0x0/0x12
May 11 17:44:20 trax kernel:  [<c012c359>] worker_thread+0x0/0x29d
May 11 17:44:20 trax kernel:  [<c0130019>] kthread+0xb7/0xbd
May 11 17:44:20 trax kernel:  [<c012ff62>] kthread+0x0/0xbd
May 11 17:44:20 trax kernel:  [<c0102271>] kernel_thread_helper+0x5/0xb
May 11 17:44:20 trax kernel:=20
May 11 17:44:20 trax kernel: handlers:
May 11 17:44:20 trax kernel: [<c021d201>] (ide_intr+0x0/0x1cb)
May 11 17:44:20 trax kernel: [<c021d201>] (ide_intr+0x0/0x1cb)
May 11 17:44:20 trax kernel: [<e08addb4>] (usb_hcd_irq+0x0/0x67
[usbcore])
May 11 17:44:20 trax kernel: Disabling IRQ #18
May 11 17:44:20 trax kernel: irq 18: nobody cared!
May 11 17:44:20 trax kernel: Call Trace:
May 11 17:44:20 trax kernel:  [<c01062b6>] __report_bad_irq+0x2a/0x8b
May 11 17:44:20 trax kernel:  [<c01063a0>] note_interrupt+0x6f/0x9f
May 11 17:44:20 trax kernel:  [<c01066be>] do_IRQ+0x161/0x192
May 11 17:44:20 trax kernel:  [<c0104a1c>] common_interrupt+0x18/0x20
May 11 17:44:20 trax kernel:  [<c010201e>] default_idle+0x0/0x2c
May 11 17:44:20 trax kernel:  [<c0102047>] default_idle+0x29/0x2c
May 11 17:44:20 trax kernel:  [<c01020b0>] cpu_idle+0x33/0x3c
May 11 17:44:20 trax kernel:  [<c035085d>] start_kernel+0x183/0x1b2
May 11 17:44:20 trax kernel:  [<c0350433>] unknown_bootoption+0x0/0x110
May 11 17:44:20 trax kernel:=20
May 11 17:44:20 trax kernel: handlers:
May 11 17:44:20 trax kernel: [<c021d201>] (ide_intr+0x0/0x1cb)
May 11 17:44:20 trax kernel: [<c021d201>] (ide_intr+0x0/0x1cb)
May 11 17:44:20 trax kernel: [<e08addb4>] (usb_hcd_irq+0x0/0x67
[usbcore])
May 11 17:44:20 trax kernel: Disabling IRQ #18
May 11 17:44:20 trax kernel: irq 18: nobody cared!
May 11 17:44:20 trax kernel: Call Trace:
May 11 17:44:20 trax kernel:  [<c01062b6>] __report_bad_irq+0x2a/0x8b
May 11 17:44:20 trax kernel:  [<c01063a0>] note_interrupt+0x6f/0x9f
May 11 17:44:20 trax kernel:  [<c01066be>] do_IRQ+0x161/0x192
May 11 17:44:20 trax kernel:  [<c0104a1c>] common_interrupt+0x18/0x20
May 11 17:44:20 trax kernel:  [<c010201e>] default_idle+0x0/0x2c
May 11 17:44:20 trax kernel:  [<c0102047>] default_idle+0x29/0x2c
May 11 17:44:20 trax kernel:  [<c01020b0>] cpu_idle+0x33/0x3c
May 11 17:44:20 trax kernel:  [<c035085d>] start_kernel+0x183/0x1b2
May 11 17:44:20 trax kernel:  [<c0350433>] unknown_bootoption+0x0/0x110
May 11 17:44:20 trax kernel:=20
May 11 17:44:20 trax kernel: handlers:
May 11 17:44:20 trax kernel: [<c021d201>] (ide_intr+0x0/0x1cb)
May 11 17:44:20 trax kernel: [<c021d201>] (ide_intr+0x0/0x1cb)
May 11 17:44:20 trax kernel: [<e08addb4>] (usb_hcd_irq+0x0/0x67
[usbcore])
May 11 17:44:20 trax kernel: Disabling IRQ #18
May 11 17:44:20 trax kernel: irq 18: nobody cared!
May 11 17:44:20 trax kernel: Call Trace:
May 11 17:44:20 trax kernel:  [<c01062b6>] __report_bad_irq+0x2a/0x8b
May 11 17:44:20 trax kernel:  [<c01063a0>] note_interrupt+0x6f/0x9f
May 11 17:44:20 trax kernel:  [<c01066be>] do_IRQ+0x161/0x192
May 11 17:44:20 trax kernel:  [<c0104a1c>] common_interrupt+0x18/0x20
May 11 17:44:20 trax kernel:  [<c01210c2>] __do_softirq+0x42/0xaa
May 11 17:44:20 trax kernel:  [<c0121157>] do_softirq+0x2d/0x2f
May 11 17:44:20 trax kernel:  [<c0113044>]
smp_apic_timer_interrupt+0xdd/0x145
May 11 17:44:20 trax kernel:  [<c0104a9e>]
apic_timer_interrupt+0x1a/0x20
May 11 17:44:20 trax kernel:=20
May 11 17:44:20 trax kernel: handlers:
May 11 17:44:20 trax kernel: [<c021d201>] (ide_intr+0x0/0x1cb)
May 11 17:44:20 trax kernel: [<c021d201>] (ide_intr+0x0/0x1cb)
May 11 17:44:20 trax kernel: [<e08addb4>] (usb_hcd_irq+0x0/0x67
[usbcore])
May 11 17:44:20 trax kernel: Disabling IRQ #18
May 11 17:44:20 trax kernel: irq 18: nobody cared!
May 11 17:44:20 trax kernel: Call Trace:
May 11 17:44:20 trax kernel:  [<c01062b6>] __report_bad_irq+0x2a/0x8b
May 11 17:44:20 trax kernel:  [<c01063a0>] note_interrupt+0x6f/0x9f
May 11 17:44:20 trax kernel:  [<c01066be>] do_IRQ+0x161/0x192
May 11 17:44:20 trax kernel:  [<c0104a1c>] common_interrupt+0x18/0x20
May 11 17:44:20 trax kernel:  [<c010201e>] default_idle+0x0/0x2c
May 11 17:44:20 trax kernel:  [<c0102047>] default_idle+0x29/0x2c
May 11 17:44:20 trax kernel:  [<c01020b0>] cpu_idle+0x33/0x3c
May 11 17:44:20 trax kernel:  [<c011d795>] printk+0x1a1/0x1eb
May 11 17:44:20 trax kernel:=20
May 11 17:44:20 trax kernel: handlers:
May 11 17:44:20 trax kernel: [<c021d201>] (ide_intr+0x0/0x1cb)
May 11 17:44:20 trax kernel: [<c021d201>] (ide_intr+0x0/0x1cb)
May 11 17:44:20 trax kernel: [<e08addb4>] (usb_hcd_irq+0x0/0x67
[usbcore])
May 11 17:44:20 trax kernel: Disabling IRQ #18
May 11 17:44:20 trax kernel: irq 18: nobody cared!
May 11 17:44:20 trax kernel: Call Trace:
May 11 17:44:20 trax kernel:  [<c01062b6>] __report_bad_irq+0x2a/0x8b
May 11 17:44:20 trax kernel:  [<c01063a0>] note_interrupt+0x6f/0x9f
May 11 17:44:20 trax kernel:  [<c01066be>] do_IRQ+0x161/0x192
May 11 17:44:20 trax kernel:  [<c0104a1c>] common_interrupt+0x18/0x20
May 11 17:44:20 trax kernel:=20
May 11 17:44:20 trax kernel: handlers:
May 11 17:44:20 trax kernel: [<c021d201>] (ide_intr+0x0/0x1cb)
May 11 17:44:20 trax kernel: [<c021d201>] (ide_intr+0x0/0x1cb)
May 11 17:44:20 trax kernel: [<e08addb4>] (usb_hcd_irq+0x0/0x67
[usbcore])
May 11 17:44:20 trax kernel: Disabling IRQ #18
May 11 17:44:20 trax kernel: irq 18: nobody cared!
May 11 17:44:20 trax kernel: Call Trace:
May 11 17:44:20 trax kernel:  [<c01062b6>] __report_bad_irq+0x2a/0x8b
May 11 17:44:20 trax kernel:  [<c01063a0>] note_interrupt+0x6f/0x9f
May 11 17:44:20 trax kernel:  [<c01066be>] do_IRQ+0x161/0x192
May 11 17:44:20 trax kernel:  [<c0104a1c>] common_interrupt+0x18/0x20
May 11 17:44:20 trax kernel:=20
May 11 17:44:20 trax kernel: handlers:
May 11 17:44:20 trax kernel: [<c021d201>] (ide_intr+0x0/0x1cb)
May 11 17:44:20 trax kernel: [<c021d201>] (ide_intr+0x0/0x1cb)
May 11 17:44:20 trax kernel: [<e08addb4>] (usb_hcd_irq+0x0/0x67
[usbcore])
May 11 17:44:20 trax kernel: Disabling IRQ #18
May 11 17:44:20 trax kernel: irq 18: nobody cared!
May 11 17:44:20 trax kernel: Call Trace:
May 11 17:44:20 trax kernel:  [<c01062b6>] __report_bad_irq+0x2a/0x8b
May 11 17:44:20 trax kernel:  [<c01063a0>] note_interrupt+0x6f/0x9f
May 11 17:44:20 trax kernel:  [<c01066be>] do_IRQ+0x161/0x192
May 11 17:44:20 trax kernel:  [<c0104a1c>] common_interrupt+0x18/0x20
May 11 17:44:20 trax kernel:=20
May 11 17:44:20 trax kernel: handlers:
May 11 17:44:21 trax kernel: [<c021d201>] (ide_intr+0x0/0x1cb)
May 11 17:44:21 trax kernel: [<c021d201>] (ide_intr+0x0/0x1cb)
May 11 17:44:21 trax kernel: [<e08addb4>] (usb_hcd_irq+0x0/0x67
[usbcore])
May 11 17:44:21 trax kernel: Disabling IRQ #18
May 11 17:44:21 trax kernel: irq 18: nobody cared!
May 11 17:44:21 trax kernel: Call Trace:
May 11 17:44:21 trax kernel:  [<c01062b6>] __report_bad_irq+0x2a/0x8b
May 11 17:44:21 trax kernel:  [<c01063a0>] note_interrupt+0x6f/0x9f
May 11 17:44:21 trax kernel:  [<c01066be>] do_IRQ+0x161/0x192
May 11 17:44:21 trax kernel:  [<c0104a1c>] common_interrupt+0x18/0x20
May 11 17:44:21 trax kernel:  [<c010201e>] default_idle+0x0/0x2c
May 11 17:44:21 trax kernel:  [<c0102047>] default_idle+0x29/0x2c
May 11 17:44:21 trax kernel:  [<c01020b0>] cpu_idle+0x33/0x3c
May 11 17:44:21 trax kernel:  [<c011d795>] printk+0x1a1/0x1eb
May 11 17:44:21 trax kernel:=20
May 11 17:44:21 trax kernel: handlers:
May 11 17:44:21 trax kernel: [<c021d201>] (ide_intr+0x0/0x1cb)
May 11 17:44:21 trax kernel: [<c021d201>] (ide_intr+0x0/0x1cb)
May 11 17:44:21 trax kernel: [<e08addb4>] (usb_hcd_irq+0x0/0x67
[usbcore])
May 11 17:44:21 trax kernel: Disabling IRQ #18
May 11 17:44:21 trax kernel: irq 18: nobody cared!
May 11 17:44:21 trax kernel: Call Trace:
May 11 17:44:21 trax kernel:  [<c01062b6>] __report_bad_irq+0x2a/0x8b
May 11 17:44:21 trax kernel:  [<c01063a0>] note_interrupt+0x6f/0x9f
May 11 17:44:21 trax kernel:  [<c01066be>] do_IRQ+0x161/0x192
May 11 17:44:21 trax kernel:  [<c0104a1c>] common_interrupt+0x18/0x20
May 11 17:44:21 trax kernel:=20
May 11 17:44:21 trax kernel: handlers:
May 11 17:44:21 trax kernel: [<c021d201>] (ide_intr+0x0/0x1cb)
May 11 17:44:21 trax kernel: [<c021d201>] (ide_intr+0x0/0x1cb)
May 11 17:44:21 trax kernel: [<e08addb4>] (usb_hcd_irq+0x0/0x67
[usbcore])
May 11 17:44:21 trax kernel: Disabling IRQ #18
May 11 17:44:21 trax kernel: irq 18: nobody cared!
May 11 17:44:21 trax kernel: Call Trace:
May 11 17:44:21 trax kernel:  [<c01062b6>] __report_bad_irq+0x2a/0x8b
May 11 17:44:21 trax kernel:  [<c01063a0>] note_interrupt+0x6f/0x9f
May 11 17:44:21 trax kernel:  [<c01066be>] do_IRQ+0x161/0x192
May 11 17:44:21 trax kernel:  [<c0104a1c>] common_interrupt+0x18/0x20
May 11 17:44:21 trax kernel:  [<c010201e>] default_idle+0x0/0x2c
May 11 17:44:21 trax kernel:  [<c0102047>] default_idle+0x29/0x2c
May 11 17:44:21 trax kernel:  [<c01020b0>] cpu_idle+0x33/0x3c
May 11 17:44:21 trax kernel:  [<c035085d>] start_kernel+0x183/0x1b2
May 11 17:44:21 trax kernel:  [<c0350433>] unknown_bootoption+0x0/0x110
May 11 17:44:21 trax kernel:=20
May 11 17:44:21 trax kernel: handlers:
May 11 17:44:21 trax kernel: [<c021d201>] (ide_intr+0x0/0x1cb)
May 11 17:44:21 trax kernel: [<c021d201>] (ide_intr+0x0/0x1cb)
May 11 17:44:21 trax kernel: [<e08addb4>] (usb_hcd_irq+0x0/0x67
[usbcore])
May 11 17:44:21 trax kernel: Disabling IRQ #18
May 11 17:44:22 trax kernel: irq 18: nobody cared!
May 11 17:44:22 trax kernel: Call Trace:
May 11 17:44:22 trax kernel:  [<c01062b6>] __report_bad_irq+0x2a/0x8b
May 11 17:44:22 trax kernel:  [<c01063a0>] note_interrupt+0x6f/0x9f
May 11 17:44:22 trax kernel:  [<c01066be>] do_IRQ+0x161/0x192
May 11 17:44:22 trax kernel:  [<c0104a1c>] common_interrupt+0x18/0x20
May 11 17:44:22 trax kernel:  [<c010201e>] default_idle+0x0/0x2c
May 11 17:44:22 trax kernel:  [<c0102047>] default_idle+0x29/0x2c
May 11 17:44:22 trax kernel:  [<c01020b0>] cpu_idle+0x33/0x3c
May 11 17:44:22 trax kernel:  [<c035085d>] start_kernel+0x183/0x1b2
May 11 17:44:22 trax kernel:  [<c0350433>] unknown_bootoption+0x0/0x110
May 11 17:44:22 trax kernel:=20
May 11 17:44:22 trax kernel: handlers:
May 11 17:44:22 trax kernel: [<c021d201>] (ide_intr+0x0/0x1cb)
May 11 17:44:22 trax kernel: [<c021d201>] (ide_intr+0x0/0x1cb)
May 11 17:44:22 trax kernel: [<e08addb4>] (usb_hcd_irq+0x0/0x67
[usbcore])
May 11 17:44:22 trax kernel: Disabling IRQ #18
May 11 17:44:22 trax kernel: irq 18: nobody cared!
May 11 17:44:22 trax kernel: Call Trace:
May 11 17:44:22 trax kernel:  [<c01062b6>] __report_bad_irq+0x2a/0x8b
May 11 17:44:22 trax kernel:  [<c01063a0>] note_interrupt+0x6f/0x9f
May 11 17:44:22 trax kernel:  [<c01066be>] do_IRQ+0x161/0x192
May 11 17:44:22 trax kernel:  [<c0104a1c>] common_interrupt+0x18/0x20
May 11 17:44:22 trax kernel:  [<c010201e>] default_idle+0x0/0x2c
May 11 17:44:22 trax kernel:  [<c0102047>] default_idle+0x29/0x2c
May 11 17:44:22 trax kernel:  [<c01020b0>] cpu_idle+0x33/0x3c
May 11 17:44:22 trax kernel:  [<c035085d>] start_kernel+0x183/0x1b2
May 11 17:44:22 trax kernel:  [<c0350433>] unknown_bootoption+0x0/0x110
May 11 17:44:22 trax kernel:=20
May 11 17:44:22 trax kernel: handlers:
May 11 17:44:22 trax kernel: [<c021d201>] (ide_intr+0x0/0x1cb)
May 11 17:44:22 trax kernel: [<c021d201>] (ide_intr+0x0/0x1cb)
May 11 17:44:22 trax kernel: [<e08addb4>] (usb_hcd_irq+0x0/0x67
[usbcore])
May 11 17:44:22 trax kernel: Disabling IRQ #18
May 11 17:44:23 trax kernel: irq 18: nobody cared!
May 11 17:44:23 trax kernel: Call Trace:
May 11 17:44:23 trax kernel:  [<c01062b6>] __report_bad_irq+0x2a/0x8b
May 11 17:44:23 trax kernel:  [<c01063a0>] note_interrupt+0x6f/0x9f
May 11 17:44:23 trax kernel:  [<c01066be>] do_IRQ+0x161/0x192
May 11 17:44:23 trax kernel:  [<c0104a1c>] common_interrupt+0x18/0x20
May 11 17:44:23 trax kernel:  [<c010201e>] default_idle+0x0/0x2c
May 11 17:44:23 trax kernel:  [<c0102047>] default_idle+0x29/0x2c
May 11 17:44:23 trax kernel:  [<c01020b0>] cpu_idle+0x33/0x3c
May 11 17:44:23 trax kernel:  [<c035085d>] start_kernel+0x183/0x1b2
May 11 17:44:23 trax kernel:  [<c0350433>] unknown_bootoption+0x0/0x110
May 11 17:44:23 trax kernel:=20
May 11 17:44:23 trax kernel: handlers:
May 11 17:44:23 trax kernel: [<c021d201>] (ide_intr+0x0/0x1cb)
May 11 17:44:23 trax kernel: [<c021d201>] (ide_intr+0x0/0x1cb)
May 11 17:44:23 trax kernel: [<e08addb4>] (usb_hcd_irq+0x0/0x67
[usbcore])
May 11 17:44:23 trax kernel: Disabling IRQ #18
May 11 17:44:24 trax kernel: irq 18: nobody cared!
May 11 17:44:24 trax kernel: Call Trace:
May 11 17:44:24 trax kernel:  [<c01062b6>] __report_bad_irq+0x2a/0x8b
May 11 17:44:24 trax kernel:  [<c01063a0>] note_interrupt+0x6f/0x9f
May 11 17:44:24 trax kernel:  [<c01066be>] do_IRQ+0x161/0x192
May 11 17:44:24 trax kernel:  [<c0104a1c>] common_interrupt+0x18/0x20
May 11 17:44:24 trax kernel:=20
May 11 17:44:24 trax kernel: handlers:
May 11 17:44:24 trax kernel: [<c021d201>] (ide_intr+0x0/0x1cb)
May 11 17:44:24 trax kernel: [<c021d201>] (ide_intr+0x0/0x1cb)
May 11 17:44:24 trax kernel: [<e08addb4>] (usb_hcd_irq+0x0/0x67
[usbcore])
May 11 17:44:24 trax kernel: Disabling IRQ #18
May 11 17:44:24 trax kernel: irq 18: nobody cared!
May 11 17:44:24 trax kernel: Call Trace:
May 11 17:44:24 trax kernel:  [<c01062b6>] __report_bad_irq+0x2a/0x8b
May 11 17:44:24 trax kernel:  [<c01063a0>] note_interrupt+0x6f/0x9f
May 11 17:44:24 trax kernel:  [<c01066be>] do_IRQ+0x161/0x192
May 11 17:44:24 trax kernel:  [<c0104a1c>] common_interrupt+0x18/0x20
May 11 17:44:24 trax kernel:  [<c010201e>] default_idle+0x0/0x2c
May 11 17:44:24 trax kernel:  [<c0102047>] default_idle+0x29/0x2c
May 11 17:44:24 trax kernel:  [<c01020b0>] cpu_idle+0x33/0x3c
May 11 17:44:24 trax kernel:  [<c035085d>] start_kernel+0x183/0x1b2
May 11 17:44:24 trax kernel:  [<c0350433>] unknown_bootoption+0x0/0x110
May 11 17:44:24 trax kernel:=20
May 11 17:44:24 trax kernel: handlers:
May 11 17:44:24 trax kernel: [<c021d201>] (ide_intr+0x0/0x1cb)
May 11 17:44:24 trax kernel: [<c021d201>] (ide_intr+0x0/0x1cb)
May 11 17:44:24 trax kernel: [<e08addb4>] (usb_hcd_irq+0x0/0x67
[usbcore])
May 11 17:44:24 trax kernel: Disabling IRQ #18
May 11 17:44:25 trax kernel: irq 18: nobody cared!
May 11 17:44:25 trax kernel: Call Trace:
May 11 17:44:25 trax kernel:  [<c01062b6>] __report_bad_irq+0x2a/0x8b
May 11 17:44:25 trax kernel:  [<c01063a0>] note_interrupt+0x6f/0x9f
May 11 17:44:25 trax kernel:  [<c01066be>] do_IRQ+0x161/0x192
May 11 17:44:25 trax kernel:  [<c0104a1c>] common_interrupt+0x18/0x20
May 11 17:44:25 trax kernel:  [<c010201e>] default_idle+0x0/0x2c
May 11 17:44:25 trax kernel:  [<c0102047>] default_idle+0x29/0x2c
May 11 17:44:25 trax kernel:  [<c01020b0>] cpu_idle+0x33/0x3c
May 11 17:44:25 trax kernel:  [<c035085d>] start_kernel+0x183/0x1b2
May 11 17:44:25 trax kernel:  [<c0350433>] unknown_bootoption+0x0/0x110
May 11 17:44:25 trax kernel:=20
May 11 17:44:25 trax kernel: handlers:
May 11 17:44:25 trax kernel: [<c021d201>] (ide_intr+0x0/0x1cb)
May 11 17:44:25 trax kernel: [<c021d201>] (ide_intr+0x0/0x1cb)
May 11 17:44:25 trax kernel: [<e08addb4>] (usb_hcd_irq+0x0/0x67
[usbcore])

ETC

