From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 11659] New: CDROM on Laptop  Fudjitsu-siemens Amilo Xa-2528 isn't reconized
Date: Sat, 27 Sep 2008 06:09:36 -0700 (PDT)
Message-ID: <bug-11659-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:34859 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752921AbYI0NKJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 27 Sep 2008 09:10:09 -0400
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m8RD9b5f007745
	for <linux-ide@vger.kernel.org>; Sat, 27 Sep 2008 06:09:38 -0700
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=11659

           Summary: CDROM on Laptop  Fudjitsu-siemens Amilo Xa-2528 isn't
                    reconized
           Product: IO/Storage
           Version: 2.5
     KernelVersion: 2.6.26-5 debian amd64
          Platform: All
        OS/Version: Linux
              Tree: Mainline
            Status: NEW
          Severity: high
          Priority: P1
         Component: IDE
        AssignedTo: io_ide@kernel-bugs.osdl.org
        ReportedBy: remy.labene@free.fr


Latest working kernel version: no
Earliest failing kernel version:  2.6.26  (gcc version 4.3.1  ) 
Distribution: debian 
Hardware Environment: X86_64
Software Environment: k8
Problem Description: The IDE driver IDE-Generic or IDE-AMD7xxx don't start the
CDROM on Laptop  Fudjitsu-siemens Amilo Xa-2528

Steps to reproduce:;

It's necessary to install Linux on this laptop to boot with a cdrom netinstall. 
After install the CD/DVD is see but it don't work. I try differents drivers IDE
(Generic_ide and amd7xxx_ide) but the DVD don't work. My distribution is a
debian amd64 lenny (testing, stable etch cdrom don't boot correctly). See my
dmesg (part), lsmod, lspci, /proc/info... bellow : 

I will try to build the kernel with SCSI emulation for CDROM

Thanks for your help

Remy LABENE
------------------------------------------------------------

[    4.743400] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    4.811401] ata2.00: ATA-8: WDC WD2500BEVS-22UST0, 01.01A01, max UDMA/133
[    4.811401] ata2.00: 488397168 sectors, multi 16: LBA48 NCQ (depth 31/32)
[    4.823400] ata2.00: configured for UDMA/133
[    4.823400] isa bounce pool size: 16 pages
[    4.823400] scsi 0:0:0:0: Direct-Access     ATA      WDC WD2500BEVS-2 01.0
PQ: 0 ANSI: 5
[    4.823400] scsi 1:0:0:0: Direct-Access     ATA      WDC WD2500BEVS-2 01.0
PQ: 0 ANSI: 5
[    4.823400] forcedeth: Reverse Engineered nForce ethernet driver. Version
0.61.

[    5.511843] ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[11] 
MMIO=[c4000000-c40007ff]  Max Packet=[2048]  IR/IT contexts=[4/8]
[    5.522012] Uniform Multi-Platform E-IDE driver
[    5.522012] ide: Assuming 33MHz system bus speed for PIO modes; override
with idebus=xx
[    5.524676] NFORCE-MCP51: 0000:00:0d.0 (rev f1) UDMA133 controller
[    5.524676] NFORCE-MCP51: IDE controller (0x10de:0x0265 rev 0xf1) at  PCI
slot 0000:00:0d.0
[    5.524676] NFORCE-MCP51: not 100% native mode: will probe irqs later
[    5.524676] NFORCE-MCP51: BIOS didn't set cable bits correctly. Enabling
workaround.
[    5.524676]     ide0: BM-DMA at 0x3080-0x3087
[    5.524676]     ide1: BM-DMA at 0x3088-0x308f
[    5.524676] Probing IDE interface ide0...
[    5.608668] usb 2-8: configuration #1 chosen from 1 choice
[    5.608668] Driver 'sd' needs updating - please use bus_type methods

[    7.288168] ide0 at 0x1f0-0x1f7,0x3f6 on irq 14  <---- bloc here at boot
[   37.292293] hda: irq timeout: status=0x58 { DriveReady SeekComplete
DataRequest }
[   37.292293] ide: failed opcode was: 0xa1
[   37.292293] ide1 at 0x170-0x177,0x376 on irq 15
[   37.329063] hda: status error: status=0x58 { DriveReady SeekComplete
DataRequest }
[   37.329204] ide: failed opcode was: unknown
[   37.329264] hda: drive not ready for command
[   37.329297] hda: ATAPI CD-ROM drive, 0kB Cache
[   37.329403] Uniform CD-ROM driver Revision: 3.20
[   37.329460] hda: status error: status=0x58 { DriveReady SeekComplete
DataRequest }
[   37.329595] ide: failed opcode was: unknown
[   37.329652] hda: drive not ready for command
[   37.329702] hda: status error: status=0x58 { DriveReady SeekComplete
DataRequest }
[   37.329839] ide: failed opcode was: unknown
[   37.332334] hda: drive not ready for command
[   37.332367] hda: weird block size 0
[   37.332398] hda: default to 2kb block size
[   37.332448] hda: status error: status=0x58 { DriveReady SeekComplete
DataRequest }
 DataRequest }

-----------------------------------------------------------

/proc/modules

fujitsu_laptop 7112 0 - Live 0xffffffffa02ea000
rfcomm 37408 2 - Live 0xffffffffa02df000
l2cap 21888 5 rfcomm, Live 0xffffffffa02d8000
ipv6 284728 16 - Live 0xffffffffa0291000
ppdev 9416 0 - Live 0xffffffffa028d000
parport_pc 27928 0 - Live 0xffffffffa0285000
lp 12324 0 - Live 0xffffffffa0280000
parport 39456 3 ppdev,parport_pc,lp, Live 0xffffffffa0275000
video 21780 0 - Live 0xffffffffa026e000
output 5696 1 video, Live 0xffffffffa026b000
powernow_k8 14916 1 - Live 0xffffffffa0266000
cpufreq_powersave 4224 0 - Live 0xffffffffa0263000
cpufreq_stats 6864 0 - Live 0xffffffffa0260000
cpufreq_userspace 6276 0 - Live 0xffffffffa025d000
cpufreq_ondemand 9616 1 - Live 0xffffffffa0259000
cpufreq_conservative 9544 0 - Live 0xffffffffa0255000
freq_table 7168 3 powernow_k8,cpufreq_stats,cpufreq_ondemand, Live
0xffffffffa0252000
loop 17228 0 - Live 0xffffffffa024c000
joydev 12736 0 - Live 0xffffffffa0247000
snd_hda_intel 426188 1 - Live 0xffffffffa01dd000
snd_pcm_oss 38560 0 - Live 0xffffffffa01d2000
snd_mixer_oss 16704 1 snd_pcm_oss, Live 0xffffffffa01cc000
snd_pcm 79240 2 snd_hda_intel,snd_pcm_oss, Live 0xffffffffa01b7000
pcspkr 4864 0 - Live 0xffffffffa01b4000
snd_timer 23760 1 snd_pcm, Live 0xffffffffa01ad000
snd 61304 7 snd_hda_intel,snd_pcm_oss,snd_mixer_oss,snd_pcm,snd_timer, Live
0xffffffffa019d000
psmouse 40220 0 - Live 0xffffffffa0192000
serio_raw 7812 0 - Live 0xffffffffa018f000
k8temp 7040 0 - Live 0xffffffffa018c000
soundcore 9744 1 snd, Live 0xffffffffa0188000
snd_page_alloc 10960 2 snd_hda_intel,snd_pcm, Live 0xffffffffa0184000
hci_usb 16604 2 - Live 0xffffffffa017e000
bluetooth 53540 7 rfcomm,l2cap,hci_usb, Live 0xffffffffa016f000
i2c_nforce2 8512 0 - Live 0xffffffffa016b000
i2c_core 25440 1 i2c_nforce2, Live 0xffffffffa0163000
battery 14600 0 - Live 0xffffffffa015e000
container 6208 0 - Live 0xffffffffa015b000
ac 7240 0 - Live 0xffffffffa007e000
button 9504 0 - Live 0xffffffffa0157000
evdev 12160 6 - Live 0xffffffffa0153000
reiserfs 210256 2 - Live 0xffffffffa011e000
sd_mod 26928 5 - Live 0xffffffffa0116000
usbhid 43792 0 - Live 0xffffffffa010a000
hid 39584 1 usbhid, Live 0xffffffffa00ff000
ff_memless 7240 1 usbhid, Live 0xffffffffa00fc000
ide_cd_mod 34248 0 - Live 0xffffffffa00f2000
cdrom 36008 1 ide_cd_mod, Live 0xffffffffa00e8000
ohci1394 30260 0 - Live 0xffffffffa00dd000
ieee1394 90984 1 ohci1394, Live 0xffffffffa00c5000
forcedeth 51664 0 - Live 0xffffffffa00b7000
sata_nv 25160 5 - Live 0xffffffffa00af000
libata 164288 1 sata_nv, Live 0xffffffffa0085000
amd74xx 11336 0 [permanent], Live 0xffffffffa0081000
scsi_mod 158232 2 sd_mod,libata, Live 0xffffffffa0056000
dock 11808 1 libata, Live 0xffffffffa0052000
ide_core 127244 2 ide_cd_mod,amd74xx, Live 0xffffffffa002f000
ohci_hcd 22724 0 - Live 0xffffffffa0026000
ehci_hcd 34764 0 - Live 0xffffffffa001a000
thermal 20512 0 - Live 0xffffffffa0013000
processor 40512 2 powernow_k8,thermal, Live 0xffffffffa0008000
fan 7176 0 - Live 0xffffffffa0005000
thermal_sys 15424 4 video,thermal,processor,fan, Live 0xffffffffa0000000

---------------------------------------------------------------------------
/proc/ioports

0000-001f : dma1
0020-0021 : pic1
0040-0043 : timer0
0050-0053 : timer1
0060-0060 : keyboard
0064-0064 : keyboard
0070-0071 : rtc0
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : 0000:00:0d.0
  0170-0177 : NFORCE-MCP51
01f0-01f7 : 0000:00:0d.0
  01f0-01f7 : NFORCE-MCP51
0360-0361 : pnp 00:0b
0376-0376 : 0000:00:0d.0
  0376-0376 : NFORCE-MCP51
03c0-03df : vga+
03f6-03f6 : 0000:00:0d.0
  03f6-03f6 : NFORCE-MCP51
04d0-04d1 : pnp 00:0b
0cf8-0cff : PCI conf1
1000-107f : pnp 00:03
  1000-1003 : ACPI PM1a_EVT_BLK
  1004-1005 : ACPI PM1a_CNT_BLK
  1008-100b : ACPI PM_TMR
  1010-1015 : ACPI CPU throttle
  1020-1027 : ACPI GPE0_BLK
1080-10ff : pnp 00:03
1400-147f : pnp 00:03
1480-14ff : pnp 00:03
  1484-1484 : ACPI PM2_CNT_BLK
1800-187f : pnp 00:03
1880-18ff : pnp 00:03
3000-303f : 0000:00:0a.1
  3000-303f : nForce2_smbus
3040-307f : 0000:00:0a.1
  3040-307f : nForce2_smbus
3080-308f : 0000:00:0d.0
  3080-308f : NFORCE-MCP51
3090-309f : 0000:00:0e.0
  3090-309f : sata_nv
30a0-30a3 : 0000:00:0e.0
  30a0-30a3 : sata_nv
30a4-30a7 : 0000:00:0e.0
  30a4-30a7 : sata_nv
30a8-30af : 0000:00:0e.0
  30a8-30af : sata_nv
30b0-30b7 : 0000:00:0e.0
  30b0-30b7 : sata_nv
30b8-30bf : 0000:00:14.0
  30b8-30bf : forcedeth
4000-4fff : PCI Bus 0000:01
5000-5fff : PCI Bus 0000:05
  5000-507f : 0000:05:00.0
6000-6fff : PCI Bus 0000:07
  6000-607f : 0000:07:06.0
---------------------------------------------------------------------------

/proc/iomem

00000000-0009dbff : System RAM
0009dc00-0009ffff : reserved
000ce000-000fffff : reserved
00100000-7ff5ffff : System RAM
  00200000-00435b60 : Kernel code
  00435b61-0053f167 : Kernel data
  005e3000-00676df7 : Kernel bss
7ff60000-7ff69fff : ACPI Tables
7ff6a000-7ff7ffff : ACPI Non-volatile Storage
7ff80000-7fffffff : reserved
c0000000-c0003fff : 0000:00:10.1
  c0000000-c0003fff : ICH HD audio
c0004000-c0004fff : 0000:00:0b.0
  c0004000-c0004fff : ohci_hcd
c0005000-c00050ff : 0000:00:0b.1
  c0005000-c00050ff : ehci_hcd
c0006000-c0006fff : 0000:00:0e.0
  c0006000-c0006fff : sata_nv
c0007000-c0007fff : 0000:00:14.0
  c0007000-c0007fff : forcedeth
c0040000-c007ffff : 0000:00:0a.3
c0200000-c03fffff : PCI Bus 0000:01
c1000000-c3ffffff : PCI Bus 0000:05
  c1000000-c1ffffff : 0000:05:00.0
  c2000000-c3ffffff : 0000:05:00.0
c4000000-c40fffff : PCI Bus 0000:07
  c4000000-c40007ff : 0000:07:06.0
    c4000000-c40007ff : ohci1394
c4200000-c43fffff : PCI Bus 0000:01
d0000000-dfffffff : PCI Bus 0000:05
  d0000000-dfffffff : 0000:05:00.0
e0000000-efffffff : reserved
  e0000000-e06fffff : PCI MMCONFIG 0
fec00000-fec0ffff : reserved
  fec00000-fec00fff : IOAPIC 0
fed00000-fed00fff : pnp 00:00
  fed00000-fed003ff : HPET 0
fee00000-fee00fff : Local APIC
  fee00000-fee00fff : reserved
fff80000-ffffffff : reserved


--------------------------------------------------------------

lspci -vvvv :

00:00.0 RAM memory: nVidia Corporation C51 Host Bridge (rev a2)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-
        Latency: 0
        Capabilities: [44] HyperTransport: Slave or Primary Interface
                Command: BaseUnitID=0 UnitCnt=15 MastHost- DefDir- DUL-
                Link Control 0: CFlE+ CST- CFE- <LkFail- Init+ EOC- TXO-
<CRCErr=3 IsocEn- LSEn+ ExtCTL- 64b-
                Link Config 0: MLWI=16bit DwFcIn- MLWO=16bit DwFcOut- LWI=16bit
DwFcInEn- LWO=16bit DwFcOutEn-
                Link Control 1: CFlE+ CST- CFE- <LkFail- Init+ EOC- TXO-
<CRCErr=0 IsocEn- LSEn+ ExtCTL- 64b-
                Link Config 1: MLWI=16bit DwFcIn- MLWO=16bit DwFcOut- LWI=8bit
DwFcInEn- LWO=8bit DwFcOutEn-
                Revision ID: 1.03
                Link Frequency 0: 800MHz
                Link Error 0: <Prot- <Ovfl- <EOC- CTLTm-
                Link Frequency Capability 0: 200MHz+ 300MHz+ 400MHz+ 500MHz+
600MHz+ 800MHz+ 1.0GHz+ 1.2GHz- 1.4GHz- 1.6GHz- Vend-
                Feature Capability: IsocFC+ LDTSTOP+ CRCTM- ECTLT- 64bA- UIDRD-
                Link Frequency 1: 800MHz
                Link Error 1: <Prot- <Ovfl- <EOC- CTLTm-
                Link Frequency Capability 1: 200MHz+ 300MHz+ 400MHz+ 500MHz+
600MHz+ 800MHz+ 1.0GHz+ 1.2GHz- 1.4GHz- 1.6GHz- Vend-
                Error Handling: PFlE+ OFlE+ PFE- OFE- EOCFE- RFE- CRCFE-
SERRFE- CF- RE- PNFE- ONFE- EOCNFE- RNFE- CRCNFE- SERRNFE-
                Prefetchable memory behind bridge Upper: 00-00
                Bus Number: 00
        Capabilities: [e0] HyperTransport: MSI Mapping Enable+ Fixed-
                Mapping Address Base: 00000000fee00000

00:00.1 RAM memory: nVidia Corporation C51 Memory Controller 0 (rev a2)
        Subsystem: Fujitsu Siemens Computers Device 110c
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B- DisINTx-
        Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR+ <PERR- INTx-

00:00.2 RAM memory: nVidia Corporation C51 Memory Controller 1 (rev a2)
        Subsystem: Fujitsu Siemens Computers Device 110c
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
        Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-

00:00.3 RAM memory: nVidia Corporation C51 Memory Controller 5 (rev a2)
        Subsystem: Fujitsu Siemens Computers Device 110c
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
        Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-

00:00.4 RAM memory: nVidia Corporation C51 Memory Controller 4 (rev a2)
        Subsystem: Fujitsu Siemens Computers Device 110c
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
        Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-
        Latency: 0

00:00.5 RAM memory: nVidia Corporation C51 Host Bridge (rev a2)
        Subsystem: Fujitsu Siemens Computers Device 110c
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-
        Latency: 0
        Capabilities: [44] #00 [00fe]
        Capabilities: [fc] #00 [0000]

00:00.6 RAM memory: nVidia Corporation C51 Memory Controller 3 (rev a2)
        Subsystem: Fujitsu Siemens Computers Device 110c
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B- DisINTx-
        Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-

00:00.7 RAM memory: nVidia Corporation C51 Memory Controller 2 (rev a2)
        Subsystem: Fujitsu Siemens Computers Device 110c
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
        Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-

00:02.0 PCI bridge: nVidia Corporation C51 PCI Express Bridge (rev a1)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B- DisINTx+
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-
        Latency: 0, Cache Line Size: 64 bytes
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 00004000-00004fff
        Memory behind bridge: c0200000-c03fffff
        Prefetchable memory behind bridge: 00000000c4200000-00000000c43fffff
        Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- <SERR- <PERR-
        BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
                PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
        Capabilities: [40] Subsystem: nVidia Corporation Device 0000
        Capabilities: [48] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [50] Message Signalled Interrupts: Mask- 64bit+ Queue=0/1
Enable+
                Address: 00000000fee0300c  Data: 4149
        Capabilities: [60] HyperTransport: MSI Mapping Enable+ Fixed-
                Mapping Address Base: 00000000fee00000
        Capabilities: [80] Express (v1) Root Port (Slot+), MSI 00
                DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s <512ns,
L1 <4us
                        ExtTag- RBE- FLReset-
                DevCtl: Report errors: Correctable+ Non-Fatal+ Fatal+
Unsupported+
                        RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
                        MaxPayload 128 bytes, MaxReadReq 512 bytes
                DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr-
TransPend-
                LnkCap: Port #2, Speed 2.5GT/s, Width x1, ASPM L0s L1, Latency
L0 <512ns, L1 <4us
                        ClockPM- Suprise- LLActRep+ BwNot-
                LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk-
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+
DLActive- BWMgmt- ABWMgmt-
                SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+
Surpise-
                        Slot #  0, PowerLimit 0.000000; Interlock- NoCompl-
                SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq+
LinkChg+
                        Control: AttnInd Off, PwrInd On, Power- Interlock-
                SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet-
Interlock-
                        Changed: MRL- PresDet- LinkState-
                RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna-
CRSVisible-
                RootCap: CRSVisible-
                RootSta: PME ReqID 0000, PMEStatus- PMEPending-
        Capabilities: [100] Virtual Channel <?>
        Kernel driver in use: pcieport-driver
        Kernel modules: shpchp

00:03.0 PCI bridge: nVidia Corporation C51 PCI Express Bridge (rev a1)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B- DisINTx+
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-
        Latency: 0, Cache Line Size: 64 bytes
        Bus: primary=00, secondary=03, subordinate=03, sec-latency=0
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: fff00000-000fffff
        Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
        Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- <SERR- <PERR-
        BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
                PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
        Capabilities: [40] Subsystem: nVidia Corporation Device 0000
        Capabilities: [48] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [50] Message Signalled Interrupts: Mask- 64bit+ Queue=0/1
Enable+
                Address: 00000000fee0300c  Data: 4151
        Capabilities: [60] HyperTransport: MSI Mapping Enable+ Fixed-
                Mapping Address Base: 00000000fee00000
        Capabilities: [80] Express (v1) Root Port (Slot+), MSI 00
                DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s <512ns,
L1 <4us
                        ExtTag- RBE- FLReset-
                DevCtl: Report errors: Correctable+ Non-Fatal+ Fatal+
Unsupported+
                        RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
                        MaxPayload 128 bytes, MaxReadReq 512 bytes
                DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr-
TransPend-
                LnkCap: Port #1, Speed 2.5GT/s, Width x1, ASPM L0s L1, Latency
L0 <512ns, L1 <4us
                        ClockPM- Suprise- LLActRep+ BwNot-
                LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk-
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+
DLActive- BWMgmt- ABWMgmt-
                SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+
Surpise-
                        Slot #  0, PowerLimit 0.000000; Interlock- NoCompl-
                SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq+
LinkChg+
                        Control: AttnInd Off, PwrInd On, Power- Interlock-
                SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+
Interlock-
                        Changed: MRL- PresDet- LinkState-
                RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna-
CRSVisible-
                RootCap: CRSVisible-
                RootSta: PME ReqID 0000, PMEStatus- PMEPending-
        Capabilities: [100] Virtual Channel <?>
        Kernel driver in use: pcieport-driver
        Kernel modules: shpchp

00:04.0 PCI bridge: nVidia Corporation C51 PCI Express Bridge (rev a1)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B- DisINTx+
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-
        Latency: 0, Cache Line Size: 64 bytes
        Bus: primary=00, secondary=05, subordinate=05, sec-latency=0
        I/O behind bridge: 00005000-00005fff
        Memory behind bridge: c1000000-c3ffffff
        Prefetchable memory behind bridge: 00000000d0000000-00000000dfffffff
        Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- <SERR- <PERR-
        BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
                PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
        Capabilities: [40] Subsystem: nVidia Corporation Device 0000
        Capabilities: [48] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [50] Message Signalled Interrupts: Mask- 64bit+ Queue=0/1
Enable+
                Address: 00000000fee0300c  Data: 4159
        Capabilities: [60] HyperTransport: MSI Mapping Enable+ Fixed-
                Mapping Address Base: 00000000fee00000
        Capabilities: [80] Express (v1) Root Port (Slot+), MSI 00
                DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s <512ns,
L1 <4us
                        ExtTag- RBE- FLReset-
                DevCtl: Report errors: Correctable+ Non-Fatal+ Fatal+
Unsupported+
                        RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
                        MaxPayload 128 bytes, MaxReadReq 512 bytes
                DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr-
TransPend-
                LnkCap: Port #0, Speed 2.5GT/s, Width x16, ASPM L0s L1, Latency
L0 <512ns, L1 <4us
                        ClockPM- Suprise- LLActRep+ BwNot-
                LnkCtl: ASPM L0s L1 Enabled; RCB 64 bytes Disabled- Retrain-
CommClk+
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 2.5GT/s, Width x16, TrErr- Train- SlotClk+
DLActive+ BWMgmt- ABWMgmt-
                SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug-
Surpise-
                        Slot #  0, PowerLimit 0.000000; Interlock- NoCompl-
                SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq-
LinkChg-
                        Control: AttnInd Off, PwrInd On, Power- Interlock-
                SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+
Interlock-
                        Changed: MRL- PresDet+ LinkState+
                RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna-
CRSVisible-
                RootCap: CRSVisible-
                RootSta: PME ReqID 0000, PMEStatus- PMEPending-
        Capabilities: [100] Virtual Channel <?>
        Kernel driver in use: pcieport-driver
        Kernel modules: shpchp

00:09.0 RAM memory: nVidia Corporation MCP51 Host Bridge (rev a2)
        Subsystem: Fujitsu Siemens Computers Device 110c
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-
        Latency: 0
        Capabilities: [44] HyperTransport: Slave or Primary Interface
                Command: BaseUnitID=9 UnitCnt=15 MastHost- DefDir- DUL-
                Link Control 0: CFlE+ CST- CFE- <LkFail- Init+ EOC- TXO-
<CRCErr=0 IsocEn- LSEn+ ExtCTL- 64b-
                Link Config 0: MLWI=8bit DwFcIn- MLWO=8bit DwFcOut- LWI=8bit
DwFcInEn- LWO=8bit DwFcOutEn-
                Link Control 1: CFlE- CST- CFE- <LkFail+ Init- EOC+ TXO+
<CRCErr=0 IsocEn- LSEn- ExtCTL- 64b-
                Link Config 1: MLWI=8bit DwFcIn- MLWO=8bit DwFcOut- LWI=8bit
DwFcInEn- LWO=8bit DwFcOutEn-
                Revision ID: 1.03
                Link Frequency 0: 800MHz
                Link Error 0: <Prot- <Ovfl- <EOC- CTLTm-
                Link Frequency Capability 0: 200MHz+ 300MHz+ 400MHz+ 500MHz+
600MHz+ 800MHz+ 1.0GHz+ 1.2GHz- 1.4GHz- 1.6GHz- Vend-
                Feature Capability: IsocFC+ LDTSTOP+ CRCTM- ECTLT- 64bA- UIDRD-
                Link Frequency 1: 200MHz
                Link Error 1: <Prot- <Ovfl- <EOC- CTLTm-
                Link Frequency Capability 1: 200MHz- 300MHz- 400MHz- 500MHz-
600MHz- 800MHz- 1.0GHz- 1.2GHz- 1.4GHz- 1.6GHz- Vend-
                Error Handling: PFlE+ OFlE+ PFE- OFE- EOCFE- RFE- CRCFE-
SERRFE- CF- RE- PNFE- ONFE- EOCNFE- RNFE- CRCNFE- SERRNFE-
                Prefetchable memory behind bridge Upper: 00-00
                Bus Number: 00
        Capabilities: [e0] HyperTransport: MSI Mapping Enable+ Fixed-
                Mapping Address Base: 00000000fee00000

00:0a.0 ISA bridge: nVidia Corporation MCP51 LPC Bridge (rev a3)
        Subsystem: nVidia Corporation Device cb84
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
        Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-
        Latency: 0

00:0a.1 SMBus: nVidia Corporation MCP51 SMBus (rev a3)
        Subsystem: Fujitsu Siemens Computers Device 110c
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-
        Interrupt: pin A routed to IRQ 10
        Region 4: I/O ports at 3040 [size=64]
        Region 5: I/O ports at 3000 [size=64]
        Capabilities: [44] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Kernel driver in use: nForce2_smbus
        Kernel modules: i2c-nforce2

00:0a.3 Co-processor: nVidia Corporation MCP51 PMU (rev a3)
        Subsystem: Fujitsu Siemens Computers Device 110c
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
        Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-
        Latency: 0 (750ns min, 250ns max)
        Interrupt: pin B routed to IRQ 10
        Region 0: Memory at c0040000 (32-bit, non-prefetchable) [size=256K]

00:0b.0 USB Controller: nVidia Corporation MCP51 USB Controller (rev a3)
(prog-if 10)
        Subsystem: nVidia Corporation Device cb84
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-
        Latency: 0 (750ns min, 250ns max)
        Interrupt: pin A routed to IRQ 22
        Region 0: Memory at c0004000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [44] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Kernel driver in use: ohci_hcd
        Kernel modules: ohci-hcd

00:0b.1 USB Controller: nVidia Corporation MCP51 USB Controller (rev a3)
(prog-if 20)
        Subsystem: nVidia Corporation Device cb84
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-
        Latency: 0 (750ns min, 250ns max)
        Interrupt: pin B routed to IRQ 23
        Region 0: Memory at c0005000 (32-bit, non-prefetchable) [size=256]
        Capabilities: [44] Debug port: BAR=1 offset=0098
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Kernel driver in use: ehci_hcd
        Kernel modules: ehci-hcd

00:0d.0 IDE interface: nVidia Corporation MCP51 IDE (rev f1) (prog-if 8a
[Master SecP PriP])
        Subsystem: Fujitsu Siemens Computers Device 110c
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-
        Latency: 0 (750ns min, 250ns max)
        Region 0: [virtual] Memory at 000001f0 (32-bit, non-prefetchable)
[disabled] [size=8]
        Region 1: [virtual] Memory at 000003f0 (type 3, non-prefetchable)
[disabled] [size=1]
        Region 2: [virtual] Memory at 00000170 (32-bit, non-prefetchable)
[disabled] [size=8]
        Region 3: [virtual] Memory at 00000370 (type 3, non-prefetchable)
[disabled] [size=1]
        Region 4: I/O ports at 3080 [size=16]
        Capabilities: [44] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Kernel driver in use: AMD_IDE
        Kernel modules: amd74xx

00:0e.0 IDE interface: nVidia Corporation MCP51 Serial ATA Controller (rev f1)
(prog-if 85 [Master SecO PriO])
        Subsystem: Fujitsu Siemens Computers Device 110c
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-
        Latency: 0 (750ns min, 250ns max)
        Interrupt: pin A routed to IRQ 21
        Region 0: I/O ports at 30b0 [size=8]
        Region 1: I/O ports at 30a4 [size=4]
        Region 2: I/O ports at 30a8 [size=8]
        Region 3: I/O ports at 30a0 [size=4]
        Region 4: I/O ports at 3090 [size=16]
        Region 5: Memory at c0006000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [44] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [b0] Message Signalled Interrupts: Mask- 64bit+ Queue=0/2
Enable-
                Address: 0000000000000000  Data: 0000
        Capabilities: [cc] HyperTransport: MSI Mapping Enable+ Fixed+
        Kernel driver in use: sata_nv
        Kernel modules: sata_nv

00:10.0 PCI bridge: nVidia Corporation MCP51 PCI Bridge (rev a2) (prog-if 01)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B- DisINTx-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-
        Latency: 0
        Bus: primary=00, secondary=07, subordinate=07, sec-latency=64
        I/O behind bridge: 00006000-00006fff
        Memory behind bridge: c4000000-c40fffff
        Prefetchable memory behind bridge: fff00000-000fffff
        Secondary status: 66MHz- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- <SERR- <PERR-
        BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
                PriDiscTmr- SecDiscTmr+ DiscTmrStat- DiscTmrSERREn-
        Capabilities: [b8] Subsystem: nVidia Corporation Device cb84
        Capabilities: [8c] HyperTransport: MSI Mapping Enable+ Fixed-
                Mapping Address Base: 00000000fee00000

00:10.1 Audio device: nVidia Corporation MCP51 High Definition Audio (rev a2)
        Subsystem: Fujitsu Siemens Computers Device 110c
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-
        Latency: 0 (500ns min, 1250ns max)
        Interrupt: pin B routed to IRQ 19
        Region 0: Memory at c0000000 (32-bit, non-prefetchable) [size=16K]
        Capabilities: [44] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [50] Message Signalled Interrupts: Mask+ 64bit+ Queue=0/0
Enable-
                Address: 0000000000000000  Data: 0000
                Masking: 00000000  Pending: 00000000
        Capabilities: [6c] HyperTransport: MSI Mapping Enable+ Fixed+
        Kernel driver in use: HDA Intel
        Kernel modules: snd-hda-intel

00:14.0 Bridge: nVidia Corporation MCP51 Ethernet Controller (rev a3)
        Subsystem: Fujitsu Siemens Computers Device 110c
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-
        Latency: 0 (250ns min, 5000ns max)
        Interrupt: pin A routed to IRQ 20
        Region 0: Memory at c0007000 (32-bit, non-prefetchable) [size=4K]
        Region 1: I/O ports at 30b8 [size=8]
        Capabilities: [44] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable+ DSel=0 DScale=0 PME-
        Kernel driver in use: forcedeth
        Kernel modules: forcedeth

00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]
HyperTransport Technology Configuration
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-
        Capabilities: [80] HyperTransport: Host or Secondary Interface
                !!! Possibly incomplete decoding
                Command: WarmRst+ DblEnd-
                Link Control: CFlE- CST- CFE- <LkFail- Init+ EOC- TXO-
<CRCErr=8
                Link Config: MLWI=16bit MLWO=16bit LWI=16bit LWO=16bit
                Revision ID: 1.02

00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Address
Map
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
        Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-

00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] DRAM
Controller
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
        Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-

00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]
Miscellaneous Control
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-
        Capabilities: [f0] Secure device <?>
        Kernel driver in use: k8temp
        Kernel modules: k8temp

05:00.0 VGA compatible controller: nVidia Corporation GeForce 8600M GS (rev a1)
        Subsystem: Fujitsu Siemens Computers Device 110c
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-
        Latency: 0, Cache Line Size: 64 bytes
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at c1000000 (32-bit, non-prefetchable) [size=16M]
        Region 1: Memory at d0000000 (64-bit, prefetchable) [size=256M]
        Region 3: Memory at c2000000 (64-bit, non-prefetchable) [size=32M]
        Region 5: I/O ports at 5000 [size=128]
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [68] Message Signalled Interrupts: Mask- 64bit+ Queue=0/0
Enable-
                Address: 0000000000000000  Data: 0000
        Capabilities: [78] Express (v1) Endpoint, MSI 00
                DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s <512ns,
L1 <4us
                        ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
                DevCtl: Report errors: Correctable- Non-Fatal- Fatal-
Unsupported-
                        RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
                        MaxPayload 128 bytes, MaxReadReq 512 bytes
                DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr-
TransPend-
                LnkCap: Port #0, Speed 2.5GT/s, Width x16, ASPM L0s L1, Latency
L0 <512ns, L1 <4us
                        ClockPM- Suprise- LLActRep- BwNot-
                LnkCtl: ASPM L0s L1 Enabled; RCB 128 bytes Disabled- Retrain-
CommClk+
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 2.5GT/s, Width x16, TrErr- Train- SlotClk+
DLActive- BWMgmt- ABWMgmt-
        Capabilities: [100] Virtual Channel <?>
        Capabilities: [128] Power Budgeting <?>
        Capabilities: [600] Vendor Specific Information <?>
        Kernel modules: nvidiafb

07:06.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host Controller
(rev c0) (prog-if 10)
        Subsystem: Fujitsu Siemens Computers Device 110c
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR+ FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 64 (8000ns max), Cache Line Size: 64 bytes
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at c4000000 (32-bit, non-prefetchable) [size=2K]
        Region 1: I/O ports at 6000 [size=128]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2+ AuxCurrent=0mA
PME(D0-,D1-,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Kernel driver in use: ohci1394
        Kernel modules: ohci1394




---------------------------------------------------------------------------
/proc/scsi/scsi


Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: ATA      Model: WDC WD2500BEVS-2 Rev: 01.0
  Type:   Direct-Access                    ANSI  SCSI revision: 05
Host: scsi1 Channel: 00 Id: 00 Lun: 00
  Vendor: ATA      Model: WDC WD2500BEVS-2 Rev: 01.0
  Type:   Direct-Access                    ANSI  SCSI revision: 05

---------------------------------------------------------------------------


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
