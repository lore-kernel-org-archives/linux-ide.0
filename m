From: Tuomas Jormola <tj@solitudo.net>
Subject: PROBLEM: SATA hotplugging not working with nForce MCP61
Date: Mon, 28 Jan 2008 09:43:36 +0200
Message-ID: <20080128074336.GB2736@solitudo.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="dDRMvlgZJXvWKvBx"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.solitudo.net ([213.157.84.60]:50385 "EHLO
	mail.solitudo.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751833AbYA1Huy (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 28 Jan 2008 02:50:54 -0500
Received: from mail.solitudo.net (mail.solitudo.net [213.157.84.60])
	by mail.solitudo.net (Postfix) with ESMTP id 03F3C181983
	for <linux-ide@vger.kernel.org>; Mon, 28 Jan 2008 09:43:49 +0200 (EET)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


--dDRMvlgZJXvWKvBx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

[1.] One line summary of the problem:
SATA hotplugging does not seem to work with NVIDIA nForce MCP61.

[2.] Full description of the problem/report:
I have a machine with ASRock 939NF6G-VSTA motherboard (more info:
http://www.asrock.com/mb/overview.asp?Model=939NF6G-VSTA). The SATA
functionality of the board is enabled by sata_nv driver. However, when I
tested hot plugging of a SATA hard disk, no hotplugging events were
generated when I detached the SATA cable from the disk. I tested the same
disk with an older machine which has MSI Neo Platinium motherboard with
nForce3 250Gb chipset, also driven by sata_nv driver, and hot plugging
was ok. Both experiments were done on the same kernel, Ubuntu gutsy
desktop installer/live CD was used to boot the machines. The attached
file sata_nv_hotplug_ok.txt is the kernel log of the latter system. At
around 814 the cable was detached from the drive and by 827 the disk was
removed from the running configuration. Then at around 871 the cable was
re-attached, and by 887 the disk was usable again. The file
sata_nv_hotplug_not_ok.txt contains kernel log of the machine with the
MCP61 chipset. When the cable is detached, nothing will be printed to the
log. I hope there is a solution to this problem.

[3.] Keywords (i.e., modules, networking, kernel):
SATA, libata, nvidia, hot plugging

[4.] Kernel version (from /proc/version):
root@ubuntu:~# cat /proc/version
Linux version 2.6.22-14-generic (buildd@palmer) (gcc version 4.1.3 20070929 (prerelease) (Ubuntu 4.1.2-16ubuntu2)) #1 SMP Sun Oct 14 23:05:12 GMT 2007

[5.] Output of Oops.. message (if applicable) with symbolic information 
     resolved (see Documentation/oops-tracing.txt)
Not available.

[6.] A small shell script or example program which triggers the
     problem (if possible)
Not available, just boot the system with a SATA disk installed and then
detached the SATA cable when the system is running.

[7.] Environment
Ubuntu 7.10 (gutsy) i386

[7.1.] Software (add the output of the ver_linux script here)
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
Linux ubuntu 2.6.22-14-generic #1 SMP Sun Oct 14 23:05:12 GMT 2007 i686 GNU/Linux
 
Gnu C                  4.1.3
Gnu make               3.81
binutils               Binutils
util-linux             2.13
mount                  2.13
module-init-tools      3.3-pre2
e2fsprogs              1.40.2
jfsutils               1.1.11
reiserfsprogs          3.6.19
xfsprogs               2.9.0
pcmciautils            014
PPP                    2.4.4
Linux C Library        2.6.1
Dynamic linker (ldd)   2.6.1
Procps                 3.2.7
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.97
udev                   113
wireless-tools         29
Modules Loaded         nls_iso8859_1 vfat fat usb_storage libusual rfcomm l2cap bluetooth ppdev parport_pc lp parport powernow_k8 cpufreq_userspace cpufreq_stats cpufreq_powersave cpufreq_ondemand freq_table cpufreq_conservative video sbs container button dock ac snd_hda_intel snd_pcm_oss snd_mixer_oss snd_pcm snd_seq_dummy snd_seq_oss snd_seq_midi snd_rawmidi pcspkr snd_seq_midi_event snd_seq snd_timer snd_seq_device snd shpchp k8temp psmouse pci_hotplug agpgart serio_raw soundcore snd_page_alloc i2c_nforce2 i2c_core evdev battery squashfs loop unionfs nls_cp437 sg isofs sd_mod ide_cd cdrom sata_nv ata_generic libata scsi_mod forcedeth amd74xx ide_core ehci_hcd ohci_hcd usbcore thermal processor fan fuse apparmor commoncap

[7.2.] Processor information (from /proc/cpuinfo):
root@ubuntu:~# cat /proc/cpuinfo
processor	: 0
vendor_id	: AuthenticAMD
cpu family	: 15
model		: 31
model name	: AMD Athlon(tm) 64 Processor 3200+
stepping	: 0
cpu MHz		: 1000.000
cache size	: 512 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 1
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 syscall nx mmxext fxsr_opt lm 3dnowext 3dnow up lahf_lm ts fid vid ttp
bogomips	: 2010.96
clflush size	: 64

[7.3.] Module information (from /proc/modules):
root@ubuntu:~# cat /proc/modules
nls_iso8859_1 5120 0 - Live 0xf8afc000
vfat 14080 0 - Live 0xf88c3000
fat 54300 1 vfat, Live 0xf8b49000
usb_storage 73024 0 - Live 0xf8b36000
libusual 18448 1 usb_storage, Live 0xf8aa7000
rfcomm 42136 2 - Live 0xf8b13000
l2cap 26240 11 rfcomm, Live 0xf8af1000
bluetooth 57060 4 rfcomm,l2cap, Live 0xf8b04000
ppdev 10244 0 - Live 0xf8a9d000
parport_pc 37412 0 - Live 0xf8a85000
lp 12580 0 - Live 0xf8a78000
parport 37448 3 ppdev,parport_pc,lp, Live 0xf8a92000
powernow_k8 16960 0 - Live 0xf8a7f000
cpufreq_userspace 5280 0 - Live 0xf8a75000
cpufreq_stats 7232 0 - Live 0xf8a72000
cpufreq_powersave 2688 0 - Live 0xf8844000
cpufreq_ondemand 9612 1 - Live 0xf8a6e000
freq_table 5792 3 powernow_k8,cpufreq_stats,cpufreq_ondemand, Live 0xf8a5d000
cpufreq_conservative 8072 0 - Live 0xf8a5a000
video 18060 0 - Live 0xf8a68000
sbs 19592 0 - Live 0xf8a62000
container 5504 0 - Live 0xf8a35000
button 8976 0 - Live 0xf8a41000
dock 10656 0 - Live 0xf8a3d000
ac 6148 0 - Live 0xf8a32000
snd_hda_intel 263712 1 - Live 0xf8aaf000
snd_pcm_oss 44672 0 - Live 0xf8a16000
snd_mixer_oss 17664 1 snd_pcm_oss, Live 0xf8a2c000
snd_pcm 80388 2 snd_hda_intel,snd_pcm_oss, Live 0xf8a45000
snd_seq_dummy 4740 0 - Live 0xf89e7000
snd_seq_oss 33152 0 - Live 0xf8a22000
snd_seq_midi 9600 0 - Live 0xf89eb000
snd_rawmidi 25728 1 snd_seq_midi, Live 0xf8a0e000
pcspkr 4224 0 - Live 0xf89e4000
snd_seq_midi_event 8448 2 snd_seq_oss,snd_seq_midi, Live 0xf89e0000
snd_seq 53232 6 snd_seq_dummy,snd_seq_oss,snd_seq_midi,snd_seq_midi_event, Live 0xf8a00000
snd_timer 24324 2 snd_pcm,snd_seq, Live 0xf89ce000
snd_seq_device 9228 5 snd_seq_dummy,snd_seq_oss,snd_seq_midi,snd_rawmidi,snd_seq, Live 0xf89ca000
snd 54660 11 snd_hda_intel,snd_pcm_oss,snd_mixer_oss,snd_pcm,snd_seq_oss,snd_rawmidi,snd_seq,snd_timer,snd_seq_device, Live 0xf89f1000
shpchp 34580 0 - Live 0xf89d6000
k8temp 6656 0 - Live 0xf89c7000
psmouse 39952 0 - Live 0xf89a8000
pci_hotplug 32704 1 shpchp, Live 0xf89be000
agpgart 35016 0 - Live 0xf89b4000
serio_raw 8068 0 - Live 0xf89a5000
soundcore 8800 1 snd, Live 0xf8977000
snd_page_alloc 11400 2 snd_hda_intel,snd_pcm, Live 0xf8973000
i2c_nforce2 7040 0 - Live 0xf8970000
i2c_core 26112 1 i2c_nforce2, Live 0xf899d000
evdev 11136 3 - Live 0xf8910000
battery 11012 0 - Live 0xf8875000
squashfs 48132 1 - Live 0xf8990000
loop 19076 2 - Live 0xf887c000
unionfs 77096 1 - Live 0xf897c000
nls_cp437 6784 1 - Live 0xf8879000
sg 36764 0 - Live 0xf895a000
isofs 36412 1 - Live 0xf88fa000
sd_mod 30336 0 - Live 0xf88f1000
ide_cd 32672 1 - Live 0xf88ac000
cdrom 37536 1 ide_cd, Live 0xf88e6000
sata_nv 20612 0 - Live 0xf88a5000
ata_generic 8452 0 - Live 0xf8866000
libata 125168 2 sata_nv,ata_generic, Live 0xf893a000
scsi_mod 147084 4 usb_storage,sg,sd_mod,libata, Live 0xf8915000
forcedeth 51592 0 - Live 0xf88b5000
amd74xx 15260 0 [permanent], Live 0xf885f000
ide_core 116804 3 usb_storage,ide_cd,amd74xx, Live 0xf88c8000
ehci_hcd 36492 0 - Live 0xf886b000
ohci_hcd 22916 0 - Live 0xf8858000
usbcore 138632 5 usb_storage,libusual,ehci_hcd,ohci_hcd, Live 0xf8882000
thermal 14344 0 - Live 0xf8853000
processor 32072 2 powernow_k8,thermal, Live 0xf884a000
fan 5764 0 - Live 0xf883c000
fuse 47124 1 - Live 0xf8823000
apparmor 40728 0 - Live 0xf8831000
commoncap 8320 1 apparmor, Live 0xf881f000

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)
root@ubuntu:~# cat /proc/ioports
0000-001f : dma1
0020-0021 : pic1
0040-0043 : timer0
0050-0053 : timer1
0060-006f : keyboard
0070-0077 : rtc
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : 0000:00:06.0
01f0-01f7 : 0000:00:06.0
  01f0-01f7 : ide0
0290-029f : pnp 00:0b
0376-0376 : 0000:00:06.0
03c0-03df : vga+
03f6-03f6 : 0000:00:06.0
  03f6-03f6 : ide0
03f8-03ff : serial
0cf8-0cff : PCI conf1
0e00-0e07 : 0000:00:08.0
  0e00-0e07 : libata
0e20-0e23 : 0000:00:08.0
  0e20-0e23 : libata
0e40-0e47 : 0000:00:08.0
  0e40-0e47 : libata
0e60-0e63 : 0000:00:08.0
  0e60-0e63 : libata
0e80-0e87 : 0000:00:08.1
  0e80-0e87 : libata
0ea0-0ea3 : 0000:00:08.1
  0ea0-0ea3 : libata
0ec0-0ec7 : 0000:00:08.1
  0ec0-0ec7 : libata
0ee0-0ee3 : 0000:00:08.1
  0ee0-0ee3 : libata
4000-4003 : ACPI PM1a_EVT_BLK
4004-4005 : ACPI PM1a_CNT_BLK
4008-400b : ACPI PM_TMR
4010-4015 : ACPI CPU throttle
4020-4027 : ACPI GPE0_BLK
44a0-44af : ACPI GPE1_BLK
5000-503f : 0000:00:01.1
  5000-503f : nForce2_smbus
6000-603f : 0000:00:01.1
  6000-603f : nForce2_smbus
d000-d00f : 0000:00:08.1
  d000-d00f : libata
d880-d88f : 0000:00:08.0
  d880-d88f : libata
e480-e487 : 0000:00:07.0
  e480-e487 : forcedeth
ec00-ec3f : 0000:00:01.1
ffa0-ffaf : 0000:00:06.0
  ffa0-ffa7 : ide0
root@ubuntu:~# cat /proc/iomem
00000000-0009fbff : System RAM
  00000000-00000000 : Crash kernel
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000cebff : Video ROM
000cf000-000d07ff : Adapter ROM
000f0000-000fffff : System ROM
00100000-3efaffff : System RAM
  00100000-002f7d25 : Kernel code
  002f7d26-003dce83 : Kernel data
3efb0000-3efbffff : ACPI Tables
3efc0000-3efeffff : ACPI Non-volatile Storage
3eff0000-3effffff : reserved
c0000000-cfffffff : 0000:00:0d.0
dd000000-ddffffff : 0000:00:0d.0
de000000-deffffff : 0000:00:0d.0
dffc0000-dffdffff : 0000:00:0d.0
dfff3000-dfff3fff : 0000:00:08.1
  dfff3000-dfff3fff : sata_nv
dfff8000-dfffbfff : 0000:00:05.0
  dfff8000-dfffbfff : ICH HD audio
dfffc000-dfffcfff : 0000:00:08.0
  dfffc000-dfffcfff : sata_nv
dfffd000-dfffdfff : 0000:00:07.0
  dfffd000-dfffdfff : forcedeth
dfffec00-dfffecff : 0000:00:02.1
  dfffec00-dfffecff : ehci_hcd
dffff000-dfffffff : 0000:00:02.0
  dffff000-dfffffff : ohci_hcd
e0000000-efffffff : pnp 00:0c
fec00000-fec00fff : reserved
fee00000-feefffff : reserved
fefe0000-fefe01ff : pnp 00:05
fefe1000-fefe1fff : pnp 00:05
ff380000-ffffffff : reserved

[7.5.] PCI information ('lspci -vvv' as root)
root@ubuntu:~# lspci -vvv
00:00.0 RAM memory: nVidia Corporation MCP61 Memory Controller (rev a1)
	Subsystem: ASRock Incorporation 939NF6G-VSTA Board
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: [44] HyperTransport: Slave or Primary Interface
		Command: BaseUnitID=0 UnitCnt=17 MastHost- DefDir- DUL-
		Link Control 0: CFlE- CST- CFE- <LkFail- Init+ EOC- TXO- <CRCErr=0 IsocEn- LSEn- ExtCTL- 64b-
		Link Config 0: MLWI=16bit DwFcIn- MLWO=16bit DwFcOut- LWI=16bit DwFcInEn- LWO=16bit DwFcOutEn-
		Link Control 1: CFlE- CST- CFE- <LkFail+ Init- EOC+ TXO+ <CRCErr=0 IsocEn- LSEn- ExtCTL- 64b-
		Link Config 1: MLWI=8bit DwFcIn- MLWO=8bit DwFcOut- LWI=8bit DwFcInEn- LWO=8bit DwFcOutEn-
		Revision ID: 1.03
		Link Frequency 0: 1.0GHz
		Link Error 0: <Prot- <Ovfl- <EOC- CTLTm-
		Link Frequency Capability 0: 200MHz+ 300MHz+ 400MHz+ 500MHz+ 600MHz+ 800MHz+ 1.0GHz+ 1.2GHz- 1.4GHz- 1.6GHz- Vend-
		Feature Capability: IsocFC+ LDTSTOP+ CRCTM- ECTLT- 64bA- UIDRD-
		Link Frequency 1: 200MHz
		Link Error 1: <Prot- <Ovfl- <EOC- CTLTm-
		Link Frequency Capability 1: 200MHz- 300MHz- 400MHz- 500MHz- 600MHz- 800MHz- 1.0GHz- 1.2GHz- 1.4GHz- 1.6GHz- Vend-
		Error Handling: PFlE+ OFlE+ PFE- OFE- EOCFE- RFE- CRCFE- SERRFE- CF- RE- PNFE- ONFE- EOCNFE- RNFE- CRCNFE- SERRNFE-
		Prefetchable memory behind bridge Upper: 00-00
		Bus Number: 00
	Capabilities: [dc] HyperTransport: MSI Mapping

00:01.0 ISA bridge: nVidia Corporation MCP61 LPC Bridge (rev a2)
	Subsystem: ASRock Incorporation 939NF6G-VSTA Board
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:01.1 SMBus: nVidia Corporation MCP61 SMBus (rev a2)
	Subsystem: ASRock Incorporation 939NF6G-VSTA Board
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at ec00 [size=64]
	Region 4: I/O ports at 5000 [size=64]
	Region 5: I/O ports at 6000 [size=64]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:01.2 RAM memory: nVidia Corporation MCP61 Memory Controller (rev a2)
	Subsystem: ASRock Incorporation 939NF6G-VSTA Board
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:02.0 USB Controller: nVidia Corporation MCP61 USB Controller (rev a2) (prog-if 10 [OHCI])
	Subsystem: ASRock Incorporation 939NF6G-VSTA Board
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (750ns min, 250ns max)
	Interrupt: pin A routed to IRQ 16
	Region 0: Memory at dffff000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:02.1 USB Controller: nVidia Corporation MCP61 USB Controller (rev a2) (prog-if 20 [EHCI])
	Subsystem: ASRock Incorporation 939NF6G-VSTA Board
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (750ns min, 250ns max)
	Interrupt: pin B routed to IRQ 17
	Region 0: Memory at dfffec00 (32-bit, non-prefetchable) [size=256]
	Capabilities: [44] Debug port
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME+

00:04.0 PCI bridge: nVidia Corporation MCP61 PCI bridge (rev a1) (prog-if 01 [Subtractive decode])
	Control: I/O- Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: fff00000-000fffff
	Prefetchable memory behind bridge: fff00000-000fffff
	Secondary status: 66MHz- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
	Capabilities: [b8] Subsystem: ASRock Incorporation Unknown device 03f3
	Capabilities: [8c] HyperTransport: MSI Mapping

00:05.0 Audio device: nVidia Corporation MCP61 High Definition Audio (rev a2)
	Subsystem: ASRock Incorporation Unknown device 0888
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (500ns min, 1250ns max)
	Interrupt: pin B routed to IRQ 17
	Region 0: Memory at dfff8000 (32-bit, non-prefetchable) [size=16K]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [50] Message Signalled Interrupts: Mask+ 64bit+ Queue=0/0 Enable-
		Address: 0000000000000000  Data: 0000
		Masking: 00000000  Pending: 00000000
	Capabilities: [6c] HyperTransport: MSI Mapping

00:06.0 IDE interface: nVidia Corporation MCP61 IDE (rev a2) (prog-if 8a [Master SecP PriP])
	Subsystem: ASRock Incorporation Unknown device 03ec
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (750ns min, 250ns max)
	Region 0: [virtual] Memory at 000001f0 (32-bit, non-prefetchable) [disabled] [size=8]
	Region 1: [virtual] Memory at 000003f0 (type 3, non-prefetchable) [disabled] [size=1]
	Region 2: [virtual] Memory at 00000170 (32-bit, non-prefetchable) [disabled] [size=8]
	Region 3: [virtual] Memory at 00000370 (type 3, non-prefetchable) [disabled] [size=1]
	Region 4: I/O ports at ffa0 [size=16]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.0 Bridge: nVidia Corporation MCP61 Ethernet (rev a2)
	Subsystem: ASRock Incorporation Unknown device 03ef
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (250ns min, 5000ns max)
	Interrupt: pin A routed to IRQ 18
	Region 0: Memory at dfffd000 (32-bit, non-prefetchable) [size=4K]
	Region 1: I/O ports at e480 [size=8]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable+ DSel=0 DScale=0 PME-
	Capabilities: [50] Message Signalled Interrupts: Mask+ 64bit+ Queue=0/3 Enable-
		Address: 0000000000000000  Data: 0000
		Masking: 00000000  Pending: 00000000
	Capabilities: [6c] HyperTransport: MSI Mapping

00:08.0 IDE interface: nVidia Corporation MCP61 SATA Controller (rev a2) (prog-if 85 [Master SecO PriO])
	Subsystem: ASRock Incorporation 939NF6G-VSTA Board
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (750ns min, 250ns max)
	Interrupt: pin A routed to IRQ 19
	Region 0: I/O ports at 0e00 [size=8]
	Region 1: I/O ports at 0e20 [size=4]
	Region 2: I/O ports at 0e40 [size=8]
	Region 3: I/O ports at 0e60 [size=4]
	Region 4: I/O ports at d880 [size=16]
	Region 5: Memory at dfffc000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [b0] Message Signalled Interrupts: Mask- 64bit+ Queue=0/2 Enable-
		Address: 0000000000000000  Data: 0000
	Capabilities: [cc] HyperTransport: MSI Mapping

00:08.1 IDE interface: nVidia Corporation MCP61 SATA Controller (rev a2) (prog-if 85 [Master SecO PriO])
	Subsystem: ASRock Incorporation 939NF6G-VSTA Board
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (750ns min, 250ns max)
	Interrupt: pin B routed to IRQ 16
	Region 0: I/O ports at 0e80 [size=8]
	Region 1: I/O ports at 0ea0 [size=4]
	Region 2: I/O ports at 0ec0 [size=8]
	Region 3: I/O ports at 0ee0 [size=4]
	Region 4: I/O ports at d000 [size=16]
	Region 5: Memory at dfff3000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [b0] Message Signalled Interrupts: Mask- 64bit+ Queue=0/2 Enable-
		Address: 0000000000000000  Data: 0000
	Capabilities: [cc] HyperTransport: MSI Mapping

00:09.0 PCI bridge: nVidia Corporation MCP61 PCI Express bridge (rev a2) (prog-if 00 [Normal decode])
	Control: I/O- Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size: 64 bytes
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: fff00000-000fffff
	Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
	Capabilities: [40] Subsystem: ASRock Incorporation Unknown device 03e8
	Capabilities: [48] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [50] Message Signalled Interrupts: Mask- 64bit+ Queue=0/1 Enable-
		Address: 0000000000000000  Data: 0000
	Capabilities: [60] HyperTransport: MSI Mapping
	Capabilities: [80] Express Root Port (Slot+) IRQ 0
		Device: Supported: MaxPayload 256 bytes, PhantFunc 0, ExtTag-
		Device: Latency L0s <64ns, L1 <1us
		Device: Errors: Correctable+ Non-Fatal+ Fatal+ Unsupported+
		Device: RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
		Device: MaxPayload 128 bytes, MaxReadReq 512 bytes
		Link: Supported Speed 2.5Gb/s, Width x16, ASPM L0s L1, Port 0
		Link: Latency L0s <512ns, L1 <4us
		Link: ASPM Disabled RCB 64 bytes CommClk- ExtSynch-
		Link: Speed 2.5Gb/s, Width x16
		Slot: AtnBtn- PwrCtrl- MRL- AtnInd- PwrInd- HotPlug- Surpise-
		Slot: Number 1, PowerLimit 75.000000
		Slot: Enabled AtnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq-
		Slot: AttnInd Off, PwrInd On, Power-
		Root: Correctable- Non-Fatal- Fatal- PME-

00:0b.0 PCI bridge: nVidia Corporation MCP61 PCI Express bridge (rev a2) (prog-if 00 [Normal decode])
	Control: I/O- Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size: 64 bytes
	Bus: primary=00, secondary=03, subordinate=03, sec-latency=0
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: fff00000-000fffff
	Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
	Capabilities: [40] Subsystem: ASRock Incorporation Unknown device 03e9
	Capabilities: [48] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [50] Message Signalled Interrupts: Mask- 64bit+ Queue=0/1 Enable-
		Address: 0000000000000000  Data: 0000
	Capabilities: [60] HyperTransport: MSI Mapping
	Capabilities: [80] Express Root Port (Slot+) IRQ 0
		Device: Supported: MaxPayload 256 bytes, PhantFunc 0, ExtTag-
		Device: Latency L0s <64ns, L1 <1us
		Device: Errors: Correctable+ Non-Fatal+ Fatal+ Unsupported+
		Device: RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
		Device: MaxPayload 128 bytes, MaxReadReq 512 bytes
		Link: Supported Speed 2.5Gb/s, Width x1, ASPM L0s L1, Port 1
		Link: Latency L0s <512ns, L1 <4us
		Link: ASPM Disabled RCB 64 bytes CommClk- ExtSynch-
		Link: Speed 2.5Gb/s, Width x1
		Slot: AtnBtn- PwrCtrl- MRL- AtnInd- PwrInd- HotPlug- Surpise-
		Slot: Number 2, PowerLimit 10.000000
		Slot: Enabled AtnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq-
		Slot: AttnInd Off, PwrInd On, Power-
		Root: Correctable- Non-Fatal- Fatal- PME-

00:0c.0 PCI bridge: nVidia Corporation MCP61 PCI Express bridge (rev a2) (prog-if 00 [Normal decode])
	Control: I/O- Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size: 64 bytes
	Bus: primary=00, secondary=04, subordinate=04, sec-latency=0
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: fff00000-000fffff
	Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
	Capabilities: [40] Subsystem: ASRock Incorporation Unknown device 03e9
	Capabilities: [48] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [50] Message Signalled Interrupts: Mask- 64bit+ Queue=0/1 Enable-
		Address: 0000000000000000  Data: 0000
	Capabilities: [60] HyperTransport: MSI Mapping
	Capabilities: [80] Express Root Port (Slot+) IRQ 0
		Device: Supported: MaxPayload 256 bytes, PhantFunc 0, ExtTag-
		Device: Latency L0s <64ns, L1 <1us
		Device: Errors: Correctable+ Non-Fatal+ Fatal+ Unsupported+
		Device: RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
		Device: MaxPayload 128 bytes, MaxReadReq 512 bytes
		Link: Supported Speed 2.5Gb/s, Width x1, ASPM L0s L1, Port 2
		Link: Latency L0s <512ns, L1 <4us
		Link: ASPM Disabled RCB 64 bytes CommClk- ExtSynch-
		Link: Speed 2.5Gb/s, Width x1
		Slot: AtnBtn- PwrCtrl- MRL- AtnInd- PwrInd- HotPlug- Surpise-
		Slot: Number 3, PowerLimit 10.000000
		Slot: Enabled AtnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq-
		Slot: AttnInd Off, PwrInd On, Power-
		Root: Correctable- Non-Fatal- Fatal- PME-

00:0d.0 VGA compatible controller: nVidia Corporation GeForce 6100 nForce 430 (rev a2) (prog-if 00 [VGA])
	Subsystem: ASRock Incorporation Unknown device 03d0
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at de000000 (32-bit, non-prefetchable) [size=16M]
	Region 1: Memory at c0000000 (64-bit, prefetchable) [size=256M]
	Region 3: Memory at dd000000 (64-bit, non-prefetchable) [size=16M]
	Expansion ROM at dffc0000 [disabled] [size=128K]
	Capabilities: [48] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [50] Message Signalled Interrupts: Mask- 64bit+ Queue=0/0 Enable-
		Address: 0000000000000000  Data: 0000

00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] HyperTransport Technology Configuration
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Capabilities: [80] HyperTransport: Host or Secondary Interface
		!!! Possibly incomplete decoding
		Command: WarmRst+ DblEnd-
		Link Control: CFlE- CST- CFE- <LkFail- Init+ EOC- TXO- <CRCErr=0
		Link Config: MLWI=16bit MLWO=16bit LWI=16bit LWO=16bit
		Revision ID: 1.02

00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Address Map
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] DRAM Controller
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Miscellaneous Control
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

[7.6.] SCSI information (from /proc/scsi/scsi)
root@ubuntu:~# cat /proc/scsi/scsi
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: ATA      Model: ST31000340AS     Rev: SD14
  Type:   Direct-Access                    ANSI  SCSI revision: 05

[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):
Output of dmidecode:
root@ubuntu:~# dmidecode
# dmidecode 2.9
SMBIOS 2.4 present.
28 structures occupying 1397 bytes.
Table at 0x000FC7D0.

Handle 0x0000, DMI type 0, 24 bytes
BIOS Information
	Vendor: American Megatrends Inc.
	Version: P1.40
	Release Date: 04/30/2007
	Address: 0xF0000
	Runtime Size: 64 kB
	ROM Size: 512 kB
	Characteristics:
		PCI is supported
		BIOS is upgradeable
		BIOS shadowing is allowed
		Boot from CD is supported
		Selectable boot is supported
		BIOS ROM is socketed
		EDD is supported
		5.25"/1.2 MB floppy services are supported (int 13h)
		3.5"/720 KB floppy services are supported (int 13h)
		3.5"/2.88 MB floppy services are supported (int 13h)
		Print screen service is supported (int 5h)
		8042 keyboard services are supported (int 9h)
		Serial services are supported (int 14h)
		Printer services are supported (int 17h)
		CGA/mono video services are supported (int 10h)
		ACPI is supported
		USB legacy is supported
		LS-120 boot is supported
		ATAPI Zip drive boot is supported
		BIOS boot specification is supported
		Function key-initiated network boot is supported
		Targeted content distribution is supported
	BIOS Revision: 8.14

Handle 0x0001, DMI type 1, 27 bytes
System Information
	Manufacturer: To Be Filled By O.E.M.
	Product Name: To Be Filled By O.E.M.
	Version: To Be Filled By O.E.M.
	Serial Number: To Be Filled By O.E.M.
	UUID: 00020003-0004-0005-0006-000700080009
	Wake-up Type: Power Switch
	SKU Number: To Be Filled By O.E.M.
	Family: To Be Filled By O.E.M.

Handle 0x0002, DMI type 2, 15 bytes
Base Board Information
	Manufacturer:                       
	Product Name: 939NF6G-VSTA
	Version:                       
	Serial Number:                       
	Asset Tag:                       
	Features:
		Board is a hosting board
		Board is replaceable
	Location In Chassis:                       
	Chassis Handle: 0x0003
	Type: Motherboard
	Contained Object Handles: 0

Handle 0x0003, DMI type 3, 21 bytes
Chassis Information
	Manufacturer: To Be Filled By O.E.M.
	Type: Desktop
	Lock: Not Present
	Version: To Be Filled By O.E.M.
	Serial Number: To Be Filled By O.E.M.
	Asset Tag: To Be Filled By O.E.M.
	Boot-up State: Safe
	Power Supply State: Safe
	Thermal State: Safe
	Security Status: None
	OEM Information: 0x00000000
	Height: Unspecified
	Number Of Power Cords: 1
	Contained Elements: 0

Handle 0x0004, DMI type 4, 35 bytes
Processor Information
	Socket Designation: CPUSocket
	Type: Central Processor
	Family: Athlon 64
	Manufacturer: AMD              
	ID: F0 0F 01 00 FF FB 8B 07
	Signature: Family 15, Model 31, Stepping 0
	Flags:
		FPU (Floating-point unit on-chip)
		VME (Virtual mode extension)
		DE (Debugging extension)
		PSE (Page size extension)
		TSC (Time stamp counter)
		MSR (Model specific registers)
		PAE (Physical address extension)
		MCE (Machine check exception)
		CX8 (CMPXCHG8 instruction supported)
		APIC (On-chip APIC hardware supported)
		SEP (Fast system call)
		MTRR (Memory type range registers)
		PGE (Page global enable)
		MCA (Machine check architecture)
		CMOV (Conditional move instruction supported)
		PAT (Page attribute table)
		PSE-36 (36-bit page size extension)
		CLFSH (CLFLUSH instruction supported)
		MMX (MMX technology supported)
		FXSR (Fast floating-point save and restore)
		SSE (Streaming SIMD extensions)
		SSE2 (Streaming SIMD extensions 2)
	Version: AMD Athlon(tm) 64 Processor 3200+                   
	Voltage: 3.3 V 2.9 V
	External Clock: 200 MHz
	Max Speed: 2000 MHz
	Current Speed: 2000 MHz
	Status: Populated, Enabled
	Upgrade: Socket 939
	L1 Cache Handle: 0x0005
	L2 Cache Handle: 0x0006
	L3 Cache Handle: Not Provided
	Serial Number: To Be Filled By O.E.M.
	Asset Tag: To Be Filled By O.E.M.
	Part Number: To Be Filled By O.E.M.

Handle 0x0005, DMI type 7, 19 bytes
Cache Information
	Socket Designation: L1-Cache
	Configuration: Enabled, Not Socketed, Level 1
	Operational Mode: Varies With Memory Address
	Location: Internal
	Installed Size: 128 KB
	Maximum Size: 128 KB
	Supported SRAM Types:
		Pipeline Burst
	Installed SRAM Type: Pipeline Burst
	Speed: Unknown
	Error Correction Type: Single-bit ECC
	System Type: Data
	Associativity: 4-way Set-associative

Handle 0x0006, DMI type 7, 19 bytes
Cache Information
	Socket Designation: L2-Cache
	Configuration: Enabled, Not Socketed, Level 2
	Operational Mode: Varies With Memory Address
	Location: Internal
	Installed Size: 512 KB
	Maximum Size: 512 KB
	Supported SRAM Types:
		Pipeline Burst
	Installed SRAM Type: Pipeline Burst
	Speed: Unknown
	Error Correction Type: Single-bit ECC
	System Type: Unified
	Associativity: 4-way Set-associative

Handle 0x0007, DMI type 5, 24 bytes
Memory Controller Information
	Error Detecting Method: 64-bit ECC
	Error Correcting Capabilities:
		None
	Supported Interleave: One-way Interleave
	Current Interleave: One-way Interleave
	Maximum Memory Module Size: 2048 MB
	Maximum Total Memory Size: 8192 MB
	Supported Speeds:
		70 ns
		60 ns
	Supported Memory Types:
		DIMM
		SDRAM
	Memory Module Voltage: 3.3 V
	Associated Memory Slots: 4
		0x0008
		0x0009
		0x000A
		0x000B
	Enabled Error Correcting Capabilities:
		None

Handle 0x0008, DMI type 6, 12 bytes
Memory Module Information
	Socket Designation: DIMM0
	Bank Connections: 0 2
	Current Speed: Unknown
	Type: ECC DIMM
	Installed Size: 512 MB (Double-bank Connection)
	Enabled Size: 512 MB (Double-bank Connection)
	Error Status: OK

Handle 0x0009, DMI type 6, 12 bytes
Memory Module Information
	Socket Designation: DIMM1
	Bank Connections: 0 2
	Current Speed: Unknown
	Type: ECC DIMM
	Installed Size: 512 MB (Double-bank Connection)
	Enabled Size: 512 MB (Double-bank Connection)
	Error Status: OK

Handle 0x000A, DMI type 6, 12 bytes
Memory Module Information
	Socket Designation: DIMM2
	Bank Connections: None
	Current Speed: Unknown
	Type: Unknown
	Installed Size: Not Installed
	Enabled Size: Not Installed
	Error Status: OK

Handle 0x000B, DMI type 6, 12 bytes
Memory Module Information
	Socket Designation: DIMM3
	Bank Connections: None
	Current Speed: Unknown
	Type: Unknown
	Installed Size: Not Installed
	Enabled Size: Not Installed
	Error Status: OK

Handle 0x000C, DMI type 9, 13 bytes
System Slot Information
	Designation: PCI1
	Type: 32-bit PCI
	Current Usage: Available
	Length: Short
	ID: 1
	Characteristics:
		3.3 V is provided
		Opening is shared
		PME signal is supported

Handle 0x000D, DMI type 9, 13 bytes
System Slot Information
	Designation: PCI2
	Type: 32-bit PCI
	Current Usage: Available
	Length: Short
	ID: 2
	Characteristics:
		3.3 V is provided
		Opening is shared
		PME signal is supported

Handle 0x000E, DMI type 9, 13 bytes
System Slot Information
	Designation: PCIE1
	Type: x16 PCI Express
	Current Usage: Available
	Length: Short
	ID: 17
	Characteristics:
		3.3 V is provided
		Opening is shared
		PME signal is supported

Handle 0x000F, DMI type 9, 13 bytes
System Slot Information
	Designation: PCIE2
	Type: x1 PCI Express
	Current Usage: Available
	Length: Short
	ID: 18
	Characteristics:
		3.3 V is provided
		Opening is shared
		PME signal is supported

Handle 0x0010, DMI type 16, 15 bytes
Physical Memory Array
	Location: System Board Or Motherboard
	Use: System Memory
	Error Correction Type: None
	Maximum Capacity: 8 GB
	Error Information Handle: Not Provided
	Number Of Devices: 4

Handle 0x0011, DMI type 19, 15 bytes
Memory Array Mapped Address
	Starting Address: 0x00000000000
	Ending Address: 0x0003FFFFFFF
	Range Size: 1 GB
	Physical Array Handle: 0x0010
	Partition Width: 0

Handle 0x0012, DMI type 17, 27 bytes
Memory Device
	Array Handle: 0x0010
	Error Information Handle: Not Provided
	Total Width: 64 bits
	Data Width: 72 bits
	Size: 512 MB
	Form Factor: DIMM
	Set: None
	Locator: DIMM0
	Bank Locator: BANK0
	Type: DDR
	Type Detail: Synchronous
	Speed: 333 MHz (3.0 ns)
	Manufacturer: Manufacturer0
	Serial Number: SerNum0
	Asset Tag: AssetTagNum0
	Part Number: PartNum0

Handle 0x0013, DMI type 20, 19 bytes
Memory Device Mapped Address
	Starting Address: 0x00000000000
	Ending Address: 0x0001FFFFFFF
	Range Size: 512 MB
	Physical Device Handle: 0x0012
	Memory Array Mapped Address Handle: 0x0011
	Partition Row Position: 1

Handle 0x0014, DMI type 17, 27 bytes
Memory Device
	Array Handle: 0x0010
	Error Information Handle: Not Provided
	Total Width: 64 bits
	Data Width: 72 bits
	Size: 512 MB
	Form Factor: DIMM
	Set: None
	Locator: DIMM1
	Bank Locator: BANK1
	Type: DDR
	Type Detail: Synchronous
	Speed: 333 MHz (3.0 ns)
	Manufacturer: Manufacturer1
	Serial Number: SerNum1
	Asset Tag: AssetTagNum1
	Part Number: PartNum1

Handle 0x0015, DMI type 20, 19 bytes
Memory Device Mapped Address
	Starting Address: 0x00020000000
	Ending Address: 0x0003FFFFFFF
	Range Size: 512 MB
	Physical Device Handle: 0x0014
	Memory Array Mapped Address Handle: 0x0011
	Partition Row Position: 1

Handle 0x0016, DMI type 17, 27 bytes
Memory Device
	Array Handle: 0x0010
	Error Information Handle: Not Provided
	Total Width: Unknown
	Data Width: 64 bits
	Size: No Module Installed
	Form Factor: DIMM
	Set: None
	Locator: DIMM2
	Bank Locator: BANK2
	Type: Unknown
	Type Detail: Unknown
	Speed: Unknown
	Manufacturer: Manufacturer2
	Serial Number: SerNum2
	Asset Tag: AssetTagNum2
	Part Number: PartNum2

Handle 0x0017, DMI type 126, 19 bytes
Inactive

Handle 0x0018, DMI type 17, 27 bytes
Memory Device
	Array Handle: 0x0010
	Error Information Handle: Not Provided
	Total Width: Unknown
	Data Width: 64 bits
	Size: No Module Installed
	Form Factor: DIMM
	Set: None
	Locator: DIMM3
	Bank Locator: BANK3
	Type: Unknown
	Type Detail: Unknown
	Speed: Unknown
	Manufacturer: Manufacturer3
	Serial Number: SerNum3
	Asset Tag: AssetTagNum3
	Part Number: PartNum3

Handle 0x0019, DMI type 126, 19 bytes
Inactive

Handle 0x001A, DMI type 32, 20 bytes
System Boot Information
	Status: No errors detected

Handle 0x001B, DMI type 127, 4 bytes
End Of Table

-- 
Tuomas Jormola <tj@solitudo.net>

--dDRMvlgZJXvWKvBx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="sata_nv_hotplug_ok.txt"

[    0.000000] Linux version 2.6.22-14-generic (buildd@palmer) (gcc version 4.1.3 20070929 (prerelease) (Ubuntu 4.1.2-16ubuntu2)) #1 SMP Sun Oct 14 23:05:12 GMT 2007 (Ubuntu 2.6.22-14.46-generic)
[    0.000000] BIOS-provided physical RAM map:
[    0.000000]  BIOS-e820: 0000000000000000 - 000000000009c000 (usable)
[    0.000000]  BIOS-e820: 000000000009c000 - 00000000000a0000 (reserved)
[    0.000000]  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
[    0.000000]  BIOS-e820: 0000000000100000 - 000000007fff0000 (usable)
[    0.000000]  BIOS-e820: 000000007fff0000 - 000000007fff3000 (ACPI NVS)
[    0.000000]  BIOS-e820: 000000007fff3000 - 0000000080000000 (ACPI data)
[    0.000000]  BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
[    0.000000] 1151MB HIGHMEM available.
[    0.000000] 896MB LOWMEM available.
[    0.000000] found SMP MP-table at 000f4fc0
[    0.000000] Entering add_active_range(0, 0, 524272) 0 entries of 256 used
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA             0 ->     4096
[    0.000000]   Normal       4096 ->   229376
[    0.000000]   HighMem    229376 ->   524272
[    0.000000] early_node_map[1] active PFN ranges
[    0.000000]     0:        0 ->   524272
[    0.000000] On node 0 totalpages: 524272
[    0.000000]   DMA zone: 32 pages used for memmap
[    0.000000]   DMA zone: 0 pages reserved
[    0.000000]   DMA zone: 4064 pages, LIFO batch:0
[    0.000000]   Normal zone: 1760 pages used for memmap
[    0.000000]   Normal zone: 223520 pages, LIFO batch:31
[    0.000000]   HighMem zone: 2303 pages used for memmap
[    0.000000]   HighMem zone: 292593 pages, LIFO batch:31
[    0.000000] DMI 2.2 present.
[    0.000000] ACPI: RSDP signature @ 0xC00F8EB0 checksum 0
[    0.000000] ACPI: RSDP 000F8EB0, 0014 (r0 Nvidia)
[    0.000000] ACPI: RSDT 7FFF3040, 0030 (r1 LENOVO TC-2P    42302E31 AWRD        0)
[    0.000000] ACPI: FACP 7FFF30C0, 0074 (r1 Nvidia AWRDACPI 42302E31 AWRD        0)
[    0.000000] ACPI: DSDT 7FFF3180, 48C1 (r1 NVIDIA AWRDACPI     1000 MSFT  100000E)
[    0.000000] ACPI: FACS 7FFF0000, 0040
[    0.000000] ACPI: SLIC 7FFF7B80, 0176 (r1 LENOVO TC-2P           0  LTP        0)
[    0.000000] ACPI: APIC 7FFF7AC0, 007C (r1 Nvidia AWRDACPI 42302E31 AWRD        0)
[    0.000000] Nvidia board detected. Ignoring ACPI timer override.
[    0.000000] If you got timer trouble try acpi_use_timer_override
[    0.000000] ACPI: PM-Timer IO Port: 0x4008
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
[    0.000000] Processor #0 15:4 APIC version 16
[    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] disabled)
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
[    0.000000] ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, GSI 0-23
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: BIOS IRQ0 pin2 override ignored.
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 14 global_irq 14 high edge)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 15 global_irq 15 high edge)
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] ACPI: IRQ14 used by override.
[    0.000000] ACPI: IRQ15 used by override.
[    0.000000] Enabling APIC mode:  Flat.  Using 1 I/O APICs
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] Allocating PCI resources starting at 88000000 (gap: 80000000:7ec00000)
[    0.000000] Built 1 zonelists.  Total pages: 520177
[    0.000000] Kernel command line: BOOT_IMAGE=/casper/vmlinuz file=/cdrom/preseed/ubuntu.seed boot=casper initrd=/casper/initrd.gz quiet splash -- console-setup/layoutcode=fi
[    0.000000] mapped APIC to ffffd000 (fee00000)
[    0.000000] mapped IOAPIC to ffffc000 (fec00000)
[    0.000000] Enabling fast FPU save and restore... done.
[    0.000000] Enabling unmasked SIMD FPU exception support... done.
[    0.000000] Initializing CPU#0
[    0.000000] PID hash table entries: 4096 (order: 12, 16384 bytes)
[    0.000000] Detected 2009.830 MHz processor.
[   29.597675] spurious 8259A interrupt: IRQ7.
[   29.599440] Console: colour VGA+ 80x25
[   29.600003] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
[   29.600468] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
[   29.669012] Memory: 2067444k/2097088k available (2015k kernel code, 28388k reserved, 916k data, 364k init, 1179584k highmem)
[   29.669022] virtual kernel memory layout:
[   29.669023]     fixmap  : 0xfff4d000 - 0xfffff000   ( 712 kB)
[   29.669024]     pkmap   : 0xff800000 - 0xffc00000   (4096 kB)
[   29.669026]     vmalloc : 0xf8800000 - 0xff7fe000   ( 111 MB)
[   29.669027]     lowmem  : 0xc0000000 - 0xf8000000   ( 896 MB)
[   29.669028]       .init : 0xc03e3000 - 0xc043e000   ( 364 kB)
[   29.669029]       .data : 0xc02f7d26 - 0xc03dce84   ( 916 kB)
[   29.669030]       .text : 0xc0100000 - 0xc02f7d26   (2015 kB)
[   29.669033] Checking if this processor honours the WP bit even in supervisor mode... Ok.
[   29.669074] SLUB: Genslabs=22, HWalign=64, Order=0-1, MinObjects=4, CPUs=1, Nodes=1
[   29.749016] Calibrating delay using timer specific routine.. 4022.13 BogoMIPS (lpj=8044271)
[   29.749046] Security Framework v1.0.0 initialized
[   29.749055] SELinux:  Disabled at boot.
[   29.749068] Mount-cache hash table entries: 512
[   29.749204] CPU: After generic identify, caps: 078bfbff e1d3fbff 00000000 00000000 00000000 00000000 00000000
[   29.749212] CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
[   29.749214] CPU: L2 Cache: 1024K (64 bytes/line)
[   29.749217] CPU: After all inits, caps: 078bfbff e1d3fbff 00000000 00000410 00000000 00000000 00000000
[   29.749228] Compat vDSO mapped to ffffe000.
[   29.749240] Checking 'hlt' instruction... OK.
[   29.765136] SMP alternatives: switching to UP code
[   29.765352] Freeing SMP alternatives: 11k freed
[   29.765624] Early unpacking initramfs... done
[   30.065867] ACPI: Core revision 20070126
[   30.065927] ACPI: Looking for DSDT in initramfs... error, file /DSDT.aml not found.
[   30.068849] CPU0: AMD Athlon(tm) 64 Processor 3200+ stepping 0a
[   30.068863] Total of 1 processors activated (4022.13 BogoMIPS).
[   30.069004] ENABLING IO-APIC IRQs
[   30.069188] ..TIMER: vector=0x31 apic1=0 pin1=0 apic2=-1 pin2=-1
[   30.216622] Brought up 1 CPUs
[   30.216719] Booting paravirtualized kernel on bare hardware
[   30.216760] Time:  9:33:27  Date: 00/27/108
[   30.216777] NET: Registered protocol family 16
[   30.216844] EISA bus registered
[   30.216852] ACPI: bus type pci registered
[   30.248759] PCI: PCI BIOS revision 2.10 entry at 0xfb7d0, last bus=2
[   30.248761] PCI: Using configuration type 1
[   30.248762] Setting up standard PCI resources
[   30.252464] ACPI: EC: Look up EC in DSDT
[   30.257932] ACPI: Interpreter enabled
[   30.257934] ACPI: (supports S0 S1 S4 S5)
[   30.257946] ACPI: Using IOAPIC for interrupt routing
[   30.266126] ACPI: PCI Root Bridge [PCI0] (0000:00)
[   30.266131] PCI: Probing PCI hardware (bus 00)
[   30.266574] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[   30.266720] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB0._PRT]
[   30.266972] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGPB._PRT]
[   30.315550] ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 5 6 7 10 *11 12 14 15)
[   30.315707] ACPI: PCI Interrupt Link [LNK2] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
[   30.315863] ACPI: PCI Interrupt Link [LNK3] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
[   30.316019] ACPI: PCI Interrupt Link [LNK4] (IRQs 3 4 5 6 7 10 *11 12 14 15)
[   30.316174] ACPI: PCI Interrupt Link [LNK5] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
[   30.316331] ACPI: PCI Interrupt Link [LUBA] (IRQs 3 4 5 6 7 10 *11 12 14 15)
[   30.316487] ACPI: PCI Interrupt Link [LUBB] (IRQs 3 4 *5 6 7 10 11 12 14 15)
[   30.316645] ACPI: PCI Interrupt Link [LMAC] (IRQs 3 4 *5 6 7 10 11 12 14 15)
[   30.316801] ACPI: PCI Interrupt Link [LAPU] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
[   30.316957] ACPI: PCI Interrupt Link [LACI] (IRQs 3 4 5 6 7 *10 11 12 14 15)
[   30.317113] ACPI: PCI Interrupt Link [LMCI] (IRQs 3 4 *5 6 7 10 11 12 14 15)
[   30.317276] ACPI: PCI Interrupt Link [LSMB] (IRQs 3 4 5 6 7 *10 11 12 14 15)
[   30.317432] ACPI: PCI Interrupt Link [LUB2] (IRQs 3 4 5 6 7 *10 11 12 14 15)
[   30.317587] ACPI: PCI Interrupt Link [LFIR] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
[   30.317743] ACPI: PCI Interrupt Link [L3CM] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
[   30.317899] ACPI: PCI Interrupt Link [LIDE] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
[   30.318062] ACPI: PCI Interrupt Link [LSID] (IRQs 3 4 5 6 7 *10 11 12 14 15)
[   30.318227] ACPI: PCI Interrupt Link [LFID] (IRQs 3 4 5 6 7 10 *11 12 14 15)
[   30.318405] ACPI: PCI Interrupt Link [APC1] (IRQs 16) *0
[   30.318569] ACPI: PCI Interrupt Link [APC2] (IRQs 17) *0, disabled.
[   30.318734] ACPI: PCI Interrupt Link [APC3] (IRQs 18) *0, disabled.
[   30.318898] ACPI: PCI Interrupt Link [APC4] (IRQs 19) *0
[   30.319015] ACPI: PCI Interrupt Link [APC5] (IRQs *16), disabled.
[   30.319184] ACPI: PCI Interrupt Link [APCF] (IRQs 20 21 22 23) *0
[   30.319353] ACPI: PCI Interrupt Link [APCG] (IRQs 20 21 22 23) *0
[   30.319522] ACPI: PCI Interrupt Link [APCH] (IRQs 20 21 22 23) *0
[   30.319691] ACPI: PCI Interrupt Link [APCI] (IRQs 20 21 22 23) *0, disabled.
[   30.319860] ACPI: PCI Interrupt Link [APCJ] (IRQs 20 21 22 23) *0
[   30.320029] ACPI: PCI Interrupt Link [APCK] (IRQs 20 21 22 23) *0
[   30.320197] ACPI: PCI Interrupt Link [APCS] (IRQs 20 21 22 23) *0
[   30.320366] ACPI: PCI Interrupt Link [APCL] (IRQs 20 21 22 23) *0
[   30.320539] ACPI: PCI Interrupt Link [APCM] (IRQs 20 21 22 23) *0, disabled.
[   30.320709] ACPI: PCI Interrupt Link [AP3C] (IRQs 20 21 22 23) *0, disabled.
[   30.320879] ACPI: PCI Interrupt Link [APCZ] (IRQs 20 21 22 23) *0, disabled.
[   30.321054] ACPI: PCI Interrupt Link [APSI] (IRQs 20 21 22 23) *0
[   30.321229] ACPI: PCI Interrupt Link [APSJ] (IRQs 20 21 22 23) *0
[   30.321346] ACPI: Power Resource [ISAV] (on)
[   30.321361] Linux Plug and Play Support v0.97 (c) Adam Belay
[   30.321368] pnp: PnP ACPI init
[   30.321374] ACPI: bus type pnp registered
[   30.325456] pnp: PnP ACPI: found 14 devices
[   30.325459] ACPI: ACPI bus type pnp unregistered
[   30.325461] PnPBIOS: Disabled by ACPI PNP
[   30.325496] PCI: Using ACPI for IRQ routing
[   30.325500] PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
[   30.353723] NET: Registered protocol family 8
[   30.353724] NET: Registered protocol family 20
[   30.353770] pnp: 00:00: ioport range 0x4000-0x407f has been reserved
[   30.353773] pnp: 00:00: ioport range 0x4080-0x40ff has been reserved
[   30.353776] pnp: 00:00: ioport range 0x4400-0x447f has been reserved
[   30.353779] pnp: 00:00: ioport range 0x4480-0x44ff has been reserved
[   30.353781] pnp: 00:00: ioport range 0x4800-0x487f has been reserved
[   30.353784] pnp: 00:00: ioport range 0x4880-0x48ff has been reserved
[   30.353789] pnp: 00:01: iomem range 0x9e000-0xa1fff could not be reserved
[   30.353791] pnp: 00:01: iomem range 0xd1800-0xd3fff has been reserved
[   30.353794] pnp: 00:01: iomem range 0xf0000-0xfbfff could not be reserved
[   30.353797] pnp: 00:01: iomem range 0xfc000-0xfffff could not be reserved
[   30.356462] Time: tsc clocksource has been installed.
[   30.383985] PCI: Bridge: 0000:00:0b.0
[   30.383987]   IO window: 9000-9fff
[   30.383991]   MEM window: fa000000-fcffffff
[   30.383994]   PREFETCH window: d0000000-dfffffff
[   30.383998] PCI: Bridge: 0000:00:0e.0
[   30.384000]   IO window: 8000-8fff
[   30.384003]   MEM window: fdf00000-fdffffff
[   30.384005]   PREFETCH window: fde00000-fdefffff
[   30.384014] PCI: Setting latency timer of device 0000:00:0e.0 to 64
[   30.384024] NET: Registered protocol family 2
[   30.420439] IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
[   30.420572] TCP established hash table entries: 131072 (order: 8, 1572864 bytes)
[   30.422202] TCP bind hash table entries: 65536 (order: 7, 524288 bytes)
[   30.422763] TCP: Hash tables configured (established 131072 bind 65536)
[   30.422765] TCP reno registered
[   30.432517] checking if image is initramfs... it is
[   30.883982] Switched to high resolution mode on CPU 0
[   31.018706] Freeing initrd memory: 7305k freed
[   31.019043] audit: initializing netlink socket (disabled)
[   31.019056] audit(1201426407.088:1): initialized
[   31.019112] highmem bounce pool size: 64 pages
[   31.020430] VFS: Disk quotas dquot_6.5.1
[   31.020468] Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
[   31.020537] io scheduler noop registered
[   31.020539] io scheduler anticipatory registered
[   31.020541] io scheduler deadline registered
[   31.020553] io scheduler cfq registered (default)
[   31.051754] Boot video device is 0000:01:00.0
[   31.051861] isapnp: Scanning for PnP cards...
[   31.405171] isapnp: No Plug & Play device found
[   31.422719] Real Time Clock Driver v1.12ac
[   31.422805] Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
[   31.422884] serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[   31.422992] serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
[   31.423388] 00:09: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[   31.423551] 00:0a: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
[   31.424066] RAMDISK driver initialized: 16 RAM disks of 65536K size 1024 blocksize
[   31.424242] input: Macintosh mouse button emulation as /class/input/input0
[   31.424297] PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
[   31.426828] serio: i8042 KBD port at 0x60,0x64 irq 1
[   31.426833] serio: i8042 AUX port at 0x60,0x64 irq 12
[   31.426947] mice: PS/2 mouse device common for all mice
[   31.427023] EISA: Probing bus 0 at eisa.0
[   31.427041] Cannot allocate resource for EISA slot 4
[   31.427055] Cannot allocate resource for EISA slot 8
[   31.427057] EISA: Detected 0 cards.
[   31.427135] TCP cubic registered
[   31.427146] NET: Registered protocol family 1
[   31.427165] Using IPI No-Shortcut mode
[   31.427308]   Magic number: 8:978:576
[   31.427372]   hash matches device ptyb8
[   31.427834] Freeing unused kernel memory: 364k freed
[   31.495355] input: AT Translated Set 2 keyboard as /class/input/input1
[   32.629889] AppArmor: AppArmor initialized<5>audit(1201426408.588:2):  type=1505 info="AppArmor initialized" pid=1231
[   32.637333] fuse init (API version 7.8)
[   32.642503] Failure registering capabilities with primary security module.
[   32.658370] ACPI Exception (processor_core-0783): AE_NOT_FOUND, Processor Device is not present [20070126]
[   33.182327] usbcore: registered new interface driver usbfs
[   33.182351] usbcore: registered new interface driver hub
[   33.182368] usbcore: registered new device driver usb
[   33.182871] ohci_hcd: 2006 August 04 USB 1.1 'Open' Host Controller (OHCI) Driver
[   33.183195] ACPI: PCI Interrupt Link [APCF] enabled at IRQ 23
[   33.183204] ACPI: PCI Interrupt 0000:00:02.0[A] -> Link [APCF] -> GSI 23 (level, high) -> IRQ 16
[   33.183216] PCI: Setting latency timer of device 0000:00:02.0 to 64
[   33.183219] ohci_hcd 0000:00:02.0: OHCI Host Controller
[   33.183362] ohci_hcd 0000:00:02.0: new USB bus registered, assigned bus number 1
[   33.183377] ohci_hcd 0000:00:02.0: irq 16, io mem 0xfe02f000
[   33.241819] forcedeth.c: Reverse Engineered nForce ethernet driver. Version 0.60.
[   33.245355] usb usb1: configuration #1 chosen from 1 choice
[   33.245384] hub 1-0:1.0: USB hub found
[   33.245393] hub 1-0:1.0: 4 ports detected
[   33.265446] Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
[   33.265451] ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
[   33.277588] SCSI subsystem initialized
[   33.282269] libata version 2.21 loaded.
[   33.345785] ACPI: PCI Interrupt Link [APCG] enabled at IRQ 22
[   33.345796] ACPI: PCI Interrupt 0000:00:02.1[B] -> Link [APCG] -> GSI 22 (level, high) -> IRQ 17
[   33.345809] PCI: Setting latency timer of device 0000:00:02.1 to 64
[   33.345812] ohci_hcd 0000:00:02.1: OHCI Host Controller
[   33.345832] ohci_hcd 0000:00:02.1: new USB bus registered, assigned bus number 2
[   33.345848] ohci_hcd 0000:00:02.1: irq 17, io mem 0xfe02e000
[   33.403409] usb usb2: configuration #1 chosen from 1 choice
[   33.403433] hub 2-0:1.0: USB hub found
[   33.403443] hub 2-0:1.0: 4 ports detected
[   33.477422] FDC 0 is a post-1991 82077
[   33.507111] ACPI: PCI Interrupt Link [APCL] enabled at IRQ 21
[   33.507123] ACPI: PCI Interrupt 0000:00:02.2[C] -> Link [APCL] -> GSI 21 (level, high) -> IRQ 18
[   33.507134] PCI: Setting latency timer of device 0000:00:02.2 to 64
[   33.507137] ehci_hcd 0000:00:02.2: EHCI Host Controller
[   33.507163] ehci_hcd 0000:00:02.2: new USB bus registered, assigned bus number 3
[   33.507195] ehci_hcd 0000:00:02.2: debug port 1
[   33.507198] PCI: cache line size of 64 is not supported by device 0000:00:02.2
[   33.507208] ehci_hcd 0000:00:02.2: irq 18, io mem 0xfe02d000
[   33.507214] ehci_hcd 0000:00:02.2: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
[   33.507287] usb usb3: configuration #1 chosen from 1 choice
[   33.507314] hub 3-0:1.0: USB hub found
[   33.507322] hub 3-0:1.0: 8 ports detected
[   33.609590] ACPI: PCI Interrupt Link [APCH] enabled at IRQ 20
[   33.609601] ACPI: PCI Interrupt 0000:00:05.0[A] -> Link [APCH] -> GSI 20 (level, high) -> IRQ 19
[   33.609607] PCI: Setting latency timer of device 0000:00:05.0 to 64
[   34.128938] eth0: forcedeth.c: subsystem: 01462:0300 bound to 0000:00:05.0
[   34.129042] NFORCE3-250: IDE controller at PCI slot 0000:00:08.0
[   34.129132] NFORCE3-250: chipset revision 162
[   34.129134] NFORCE3-250: not 100% native mode: will probe irqs later
[   34.129139] NFORCE3-250: 0000:00:08.0 (rev a2) UDMA133 controller
[   34.129147]     ide0: BM-DMA at 0xdc00-0xdc07, BIOS settings: hda:DMA, hdb:DMA
[   34.129156]     ide1: BM-DMA at 0xdc08-0xdc0f, BIOS settings: hdc:DMA, hdd:DMA
[   34.129164] Probing IDE interface ide0...
[   34.687996] hub 3-0:1.0: over-current change on port 1
[   34.695984] Probing IDE interface ide1...
[   34.791889] hub 3-0:1.0: over-current change on port 2
[   35.135539] hub 3-0:1.0: over-current change on port 5
[   35.239423] hub 3-0:1.0: over-current change on port 6
[   35.266831] sata_nv 0000:00:09.0: version 3.4
[   35.267198] ACPI: PCI Interrupt Link [APSI] enabled at IRQ 23
[   35.267202] ACPI: PCI Interrupt 0000:00:09.0[A] -> Link [APSI] -> GSI 23 (level, high) -> IRQ 16
[   35.267242] PCI: Setting latency timer of device 0000:00:09.0 to 64
[   35.267295] scsi0 : sata_nv
[   35.267449] scsi1 : sata_nv
[   35.267602] ata1: SATA max UDMA/133 cmd 0x000109e0 ctl 0x00010be2 bmdma 0x0001c800 irq 16
[   35.267606] ata2: SATA max UDMA/133 cmd 0x00010960 ctl 0x00010b62 bmdma 0x0001c808 irq 16
[   35.647004] usb 2-1: new full speed USB device using ohci_hcd and address 2
[   35.734919] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[   35.743390] ata1.00: ATA-7: ST31000340AS, SD14, max UDMA/133
[   35.743393] ata1.00: 1953525168 sectors, multi 16: LBA48 NCQ (depth 0/32)
[   35.759362] ata1.00: configured for UDMA/133
[   35.849954] usb 2-1: configuration #1 chosen from 1 choice
[   35.852911] hub 2-1:1.0: USB hub found
[   35.855884] hub 2-1:1.0: 4 ports detected
[   36.183554] usb 2-1.1: new low speed USB device using ohci_hcd and address 3
[   36.226413] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[   36.326466] usb 2-1.1: configuration #1 chosen from 1 choice
[   36.406325] ata2.00: ATAPI: LITE-ON DVDRW LH-16A1S, CL02, max UDMA/100
[   36.547191] usb 2-1.4: new low speed USB device using ohci_hcd and address 4
[   36.594122] ata2.00: configured for UDMA/100
[   36.594225] scsi 0:0:0:0: Direct-Access     ATA      ST31000340AS     SD14 PQ: 0 ANSI: 5
[   36.595602] scsi 1:0:0:0: CD-ROM            LITE-ON  DVDRW LH-16A1S   CL02 PQ: 0 ANSI: 5
[   36.596199] ACPI: PCI Interrupt Link [APSJ] enabled at IRQ 22
[   36.596204] ACPI: PCI Interrupt 0000:00:0a.0[A] -> Link [APSJ] -> GSI 22 (level, high) -> IRQ 17
[   36.596244] PCI: Setting latency timer of device 0000:00:0a.0 to 64
[   36.596283] scsi2 : sata_nv
[   36.597193] scsi3 : sata_nv
[   36.597340] ata3: SATA max UDMA/133 cmd 0x000109f0 ctl 0x00010bf2 bmdma 0x0001b000 irq 17
[   36.597344] ata4: SATA max UDMA/133 cmd 0x00010970 ctl 0x00010b72 bmdma 0x0001b008 irq 17
[   36.650148] usb 2-1.4: configuration #1 chosen from 1 choice
[   36.654101] usbcore: registered new interface driver hiddev
[   36.672358] input: ATEN Advance Tech Inc. CS-1764 V1.4.132 as /class/input/input2
[   36.672370] input: USB HID v1.00 Keyboard [ATEN Advance Tech Inc. CS-1764 V1.4.132] on usb-0000:00:02.1-1.1
[   36.689274] input: ATEN Advance Tech Inc. CS-1764 V1.4.132 as /class/input/input3
[   36.689403] input: USB HID v1.00 Mouse [ATEN Advance Tech Inc. CS-1764 V1.4.132] on usb-0000:00:02.1-1.1
[   36.694251] input: HID 0430:0100 as /class/input/input4
[   36.694384] input: USB HID v1.10 Mouse [HID 0430:0100] on usb-0000:00:02.1-1.4
[   36.694392] usbcore: registered new interface driver usbhid
[   36.694395] /build/buildd/linux-source-2.6.22-2.6.22/drivers/hid/usbhid/hid-core.c: v2.6:USB HID core driver
[   36.905708] ata3: SATA link down (SStatus 0 SControl 300)
[   36.905717] ata3: EH pending after completion, repeating EH (cnt=4)
[   37.217384] ata4: SATA link down (SStatus 0 SControl 300)
[   37.217729] ACPI: PCI Interrupt Link [APC4] enabled at IRQ 19
[   37.217738] ACPI: PCI Interrupt 0000:02:0c.0[A] -> Link [APC4] -> GSI 19 (level, low) -> IRQ 20
[   37.272588] ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=[20]  MMIO=[fdfff000-fdfff7ff]  Max Packet=[2048]  IR/IT contexts=[8/8]
[   37.293635] sd 0:0:0:0: [sda] 1953525168 512-byte hardware sectors (1000205 MB)
[   37.293665] sd 0:0:0:0: [sda] Write Protect is off
[   37.293668] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[   37.293691] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   37.293735] sd 0:0:0:0: [sda] 1953525168 512-byte hardware sectors (1000205 MB)
[   37.293742] sd 0:0:0:0: [sda] Write Protect is off
[   37.293745] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[   37.293755] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   37.293759]  sda: unknown partition table
[   37.299629] sd 0:0:0:0: [sda] Attached SCSI disk
[   37.303514] sd 0:0:0:0: Attached scsi generic sg0 type 0
[   37.303619] scsi 1:0:0:0: Attached scsi generic sg1 type 5
[   37.322011] sr0: scsi3-mmc drive: 48x/48x writer dvd-ram cd/rw xa/form2 cdda tray
[   37.322016] Uniform CD-ROM driver Revision: 3.20
[   37.322194] sr 1:0:0:0: Attached scsi CD-ROM sr0
[   38.168967] ISO 9660 Extensions: Microsoft Joliet Level 3
[   38.187213] ISO 9660 Extensions: RRIP_1991A
[   38.399954] Registering unionfs 1.4
[   38.399958] unionfs: debugging is not enabled
[   38.408530] loop: module loaded
[   38.548101] ieee1394: Host added: ID:BUS[0-00:1023]  GUID[0010dc00006c51bb]
[   38.641879] squashfs: version 3.2-UBUNTU (2007/07/26) Phillip Lougher
[   78.907384] Linux agpgart interface v0.102 (c) Dave Jones
[   78.921990] agpgart: Detected AGP bridge 0
[   78.922006] agpgart: Setting up Nforce3 AGP.
[   78.929995] agpgart: AGP aperture is 256M @ 0xe0000000
[   78.960484] i2c-adapter i2c-0: nForce2 SMBus adapter at 0x4c00
[   78.960509] i2c-adapter i2c-1: nForce2 SMBus adapter at 0x4c40
[   79.681030] input: PC Speaker as /class/input/input5
[   79.750888] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[   80.074899] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[   80.508269] input: ImExPS/2 Generic Explorer Mouse as /class/input/input6
[   80.520798] parport_pc 00:0b: reported by Plug and Play ACPI
[   80.520843] parport0: PC-style at 0x378, irq 7 [PCSPP,TRISTATE]
[   80.968495] ACPI: PCI Interrupt Link [APCJ] enabled at IRQ 21
[   80.968501] ACPI: PCI Interrupt 0000:00:06.0[A] -> Link [APCJ] -> GSI 21 (level, high) -> IRQ 18
[   80.968520] PCI: Setting latency timer of device 0000:00:06.0 to 64
[   81.291935] intel8x0_measure_ac97_clock: measured 54693 usecs
[   81.291938] intel8x0: clocking to 46879
[   84.658691] No dock devices found.
[   84.824715] input: Power Button (FF) as /class/input/input7
[   84.828635] ACPI: Power Button (FF) [PWRF]
[   84.866047] input: Power Button (CM) as /class/input/input8
[   84.869957] ACPI: Power Button (CM) [PWRB]
[   85.532121] powernow-k8: Found 1 AMD Athlon(tm) 64 Processor 3200+ processors (version 2.00.00)
[   85.539730] powernow-k8: BIOS error - no PSB or ACPI _PSS objects
[   89.297216] lp0: using parport0 (interrupt-driven).
[   89.363168] ppdev: user-space parallel port driver
[   90.740642] apm: BIOS version 1.2 Flags 0x07 (Driver version 1.16ac)
[   90.740646] apm: overridden by ACPI.
[   91.026382] Failure registering capabilities with primary security module.
[   91.735654] Bluetooth: Core ver 2.11
[   91.735781] NET: Registered protocol family 31
[   91.735783] Bluetooth: HCI device and connection manager initialized
[   91.735787] Bluetooth: HCI socket layer initialized
[   91.761256] Bluetooth: L2CAP ver 2.8
[   91.761260] Bluetooth: L2CAP socket layer initialized
[   91.920535] Bluetooth: RFCOMM socket layer initialized
[   91.920659] Bluetooth: RFCOMM TTY layer initialized
[   91.920661] Bluetooth: RFCOMM ver 1.8
[   96.511430] NET: Registered protocol family 17
[  107.555747] NET: Registered protocol family 10
[  107.555941] lo: Disabled Privacy Extensions
[  118.461603] eth0: no IPv6 routers present
[  814.326115] ata1: exception Emask 0x10 SAct 0x0 SErr 0x1810000 action 0x2 frozen
[  814.326183] ata1: hard resetting port
[  815.047279] ata1: SATA link down (SStatus 0 SControl 300)
[  815.047284] ata1: failed to recover some devices, retrying in 5 secs
[  820.046129] ata1: hard resetting port
[  820.769379] ata1: SATA link down (SStatus 0 SControl 300)
[  820.769386] ata1.00: limiting speed to UDMA/133:PIO3
[  820.769388] ata1: failed to recover some devices, retrying in 5 secs
[  825.768225] ata1: hard resetting port
[  826.491478] ata1: SATA link down (SStatus 0 SControl 300)
[  826.491483] ata1.00: disabled
[  826.994963] ata1: EH complete
[  826.994974] ata1.00: detaching (SCSI 0:0:0:0)
[  826.995137] sd 0:0:0:0: [sda] Synchronizing SCSI cache
[  826.998970] sd 0:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK,SUGGEST_OK
[  826.998977] sd 0:0:0:0: [sda] Stopping disk
[  827.000812] sd 0:0:0:0: [sda] START_STOP FAILED
[  827.000816] sd 0:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK,SUGGEST_OK
[  871.924626] ata1: port is slow to respond, please be patient (Status 0x80)
[  876.623780] ata1: device not ready (errno=-16), forcing hardreset
[  876.623784] ata1: hard resetting port
[  882.134097] ata1: port is slow to respond, please be patient (Status 0x80)
[  886.665424] ata1: COMRESET failed (errno=-16)
[  886.665472] ata1: hard resetting port
[  887.296780] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  887.305235] ata1.00: ATA-7: ST31000340AS, SD14, max UDMA/133
[  887.305238] ata1.00: 1953525168 sectors, multi 16: LBA48 NCQ (depth 0/32)
[  887.321211] ata1.00: configured for UDMA/133
[  887.321214] ata1: EH pending after completion, repeating EH (cnt=4)
[  887.321221] ata1: EH complete
[  887.321763] scsi 0:0:0:0: Direct-Access     ATA      ST31000340AS     SD14 PQ: 0 ANSI: 5
[  887.322758] sd 0:0:0:0: [sda] 1953525168 512-byte hardware sectors (1000205 MB)
[  887.322979] sd 0:0:0:0: [sda] Write Protect is off
[  887.322982] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[  887.323329] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  887.323619] sd 0:0:0:0: [sda] 1953525168 512-byte hardware sectors (1000205 MB)
[  887.323840] sd 0:0:0:0: [sda] Write Protect is off
[  887.323843] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[  887.324186] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  887.324189]  sda: unknown partition table
[  887.332812] sd 0:0:0:0: [sda] Attached SCSI disk
[  887.332844] sd 0:0:0:0: Attached scsi generic sg0 type 0

--dDRMvlgZJXvWKvBx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="sata_nv_hotplug_not_ok.txt"

[    0.000000] Linux version 2.6.22-14-generic (buildd@palmer) (gcc version 4.1.3 20070929 (prerelease) (Ubuntu 4.1.2-16ubuntu2)) #1 SMP Sun Oct 14 23:05:12 GMT 2007 (Ubuntu 2.6.22-14.46-generic)
[    0.000000] BIOS-provided physical RAM map:
[    0.000000]  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
[    0.000000]  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
[    0.000000]  BIOS-e820: 00000000000e8000 - 0000000000100000 (reserved)
[    0.000000]  BIOS-e820: 0000000000100000 - 000000003efb0000 (usable)
[    0.000000]  BIOS-e820: 000000003efb0000 - 000000003efc0000 (ACPI data)
[    0.000000]  BIOS-e820: 000000003efc0000 - 000000003eff0000 (ACPI NVS)
[    0.000000]  BIOS-e820: 000000003eff0000 - 000000003f000000 (reserved)
[    0.000000]  BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
[    0.000000]  BIOS-e820: 00000000fee00000 - 00000000fef00000 (reserved)
[    0.000000]  BIOS-e820: 00000000ff380000 - 0000000100000000 (reserved)
[    0.000000] 111MB HIGHMEM available.
[    0.000000] 896MB LOWMEM available.
[    0.000000] found SMP MP-table at 000ff780
[    0.000000] Entering add_active_range(0, 0, 257968) 0 entries of 256 used
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA             0 ->     4096
[    0.000000]   Normal       4096 ->   229376
[    0.000000]   HighMem    229376 ->   257968
[    0.000000] early_node_map[1] active PFN ranges
[    0.000000]     0:        0 ->   257968
[    0.000000] On node 0 totalpages: 257968
[    0.000000]   DMA zone: 32 pages used for memmap
[    0.000000]   DMA zone: 0 pages reserved
[    0.000000]   DMA zone: 4064 pages, LIFO batch:0
[    0.000000]   Normal zone: 1760 pages used for memmap
[    0.000000]   Normal zone: 223520 pages, LIFO batch:31
[    0.000000]   HighMem zone: 223 pages used for memmap
[    0.000000]   HighMem zone: 28369 pages, LIFO batch:7
[    0.000000] DMI present.
[    0.000000] ACPI: RSDP signature @ 0xC00FA2F0 checksum 0
[    0.000000] ACPI: RSDP 000FA2F0, 0014 (r0 ACPIAM)
[    0.000000] ACPI: RSDT 3EFB0000, 0038 (r1 A M I  OEMRSDT   4000730 MSFT       97)
[    0.000000] ACPI: FACP 3EFB0200, 0084 (r2 A M I  OEMFACP  12000601 MSFT       97)
[    0.000000] ACPI: DSDT 3EFB0440, 4F1C (r1  ASRO1 ASRO1132      132 INTL 20051117)
[    0.000000] ACPI: FACS 3EFC0000, 0040
[    0.000000] ACPI: APIC 3EFB0390, 0070 (r1 A M I  OEMAPIC   4000730 MSFT       97)
[    0.000000] ACPI: MCFG 3EFB0400, 003C (r1 A M I  OEMMCFG   4000730 MSFT       97)
[    0.000000] ACPI: OEMB 3EFC0040, 0060 (r1 A M I  AMI_OEM   4000730 MSFT       97)
[    0.000000] ACPI: HPET 3EFB5360, 0038 (r1 A M I  OEMHPET0  4000730 MSFT       97)
[    0.000000] ACPI: PM-Timer IO Port: 0x4008
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
[    0.000000] Processor #0 15:15 APIC version 16
[    0.000000] ACPI: LAPIC (acpi_id[0x02] lapic_id[0x81] disabled)
[    0.000000] ACPI: IOAPIC (id[0x01] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 1, version 17, address 0xfec00000, GSI 0-23
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 14 global_irq 14 high edge)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 15 global_irq 15 high edge)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ2 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] ACPI: IRQ14 used by override.
[    0.000000] ACPI: IRQ15 used by override.
[    0.000000] Enabling APIC mode:  Flat.  Using 1 I/O APICs
[    0.000000] ACPI: HPET id: 0x10de8201 base: 0xfed00000
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] Allocating PCI resources starting at 40000000 (gap: 3f000000:bfc00000)
[    0.000000] Built 1 zonelists.  Total pages: 255953
[    0.000000] Kernel command line: BOOT_IMAGE=/casper/vmlinuz file=/cdrom/preseed/ubuntu.seed boot=casper initrd=/casper/initrd.gz quiet splash -- console-setup/layoutcode=fi
[    0.000000] mapped APIC to ffffd000 (fee00000)
[    0.000000] mapped IOAPIC to ffffc000 (fec00000)
[    0.000000] Enabling fast FPU save and restore... done.
[    0.000000] Enabling unmasked SIMD FPU exception support... done.
[    0.000000] Initializing CPU#0
[    0.000000] PID hash table entries: 4096 (order: 12, 16384 bytes)
[    0.000000] Detected 2009.006 MHz processor.
[   40.703248] spurious 8259A interrupt: IRQ7.
[   40.706153] Console: colour VGA+ 80x25
[   40.706495] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
[   40.706879] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
[   40.724918] Memory: 1011120k/1031872k available (2015k kernel code, 20044k reserved, 916k data, 364k init, 114368k highmem)
[   40.724928] virtual kernel memory layout:
[   40.724929]     fixmap  : 0xfff4d000 - 0xfffff000   ( 712 kB)
[   40.724931]     pkmap   : 0xff800000 - 0xffc00000   (4096 kB)
[   40.724932]     vmalloc : 0xf8800000 - 0xff7fe000   ( 111 MB)
[   40.724933]     lowmem  : 0xc0000000 - 0xf8000000   ( 896 MB)
[   40.724934]       .init : 0xc03e3000 - 0xc043e000   ( 364 kB)
[   40.724935]       .data : 0xc02f7d26 - 0xc03dce84   ( 916 kB)
[   40.724937]       .text : 0xc0100000 - 0xc02f7d26   (2015 kB)
[   40.724939] Checking if this processor honours the WP bit even in supervisor mode... Ok.
[   40.724974] SLUB: Genslabs=22, HWalign=64, Order=0-1, MinObjects=4, CPUs=1, Nodes=1
[   40.725105] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 31
[   40.725109] hpet0: 3 32-bit timers, 25000000 Hz
[   40.806018] Calibrating delay using timer specific routine.. 4021.92 BogoMIPS (lpj=8043845)
[   40.806040] Security Framework v1.0.0 initialized
[   40.806045] SELinux:  Disabled at boot.
[   40.806058] Mount-cache hash table entries: 512
[   40.806169] CPU: After generic identify, caps: 078bfbff e3d3fbff 00000000 00000000 00000000 00000000 00000001
[   40.806177] CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
[   40.806179] CPU: L2 Cache: 512K (64 bytes/line)
[   40.806182] CPU: After all inits, caps: 078bfbff e3d3fbff 00000000 00000410 00000000 00000000 00000001
[   40.806191] Compat vDSO mapped to ffffe000.
[   40.806201] Checking 'hlt' instruction... OK.
[   40.822115] SMP alternatives: switching to UP code
[   40.822286] Freeing SMP alternatives: 11k freed
[   40.822534] Early unpacking initramfs... done
[   41.118723] ACPI: Core revision 20070126
[   41.118783] ACPI: Looking for DSDT in initramfs... error, file /DSDT.aml not found.
[   41.120953] CPU0: AMD Athlon(tm) 64 Processor 3200+ stepping 00
[   41.120970] Total of 1 processors activated (4021.92 BogoMIPS).
[   41.121205] ENABLING IO-APIC IRQs
[   41.121434] ..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
[   41.265410] Brought up 1 CPUs
[   41.265521] Booting paravirtualized kernel on bare hardware
[   41.265580] Time: 18:16:53  Date: 00/27/108
[   41.265599] NET: Registered protocol family 16
[   41.265665] EISA bus registered
[   41.265669] ACPI: bus type pci registered
[   41.266320] PCI: PCI BIOS revision 3.00 entry at 0xf0031, last bus=4
[   41.266322] PCI: Using configuration type 1
[   41.266324] Setting up standard PCI resources
[   41.274122] ACPI: EC: Look up EC in DSDT
[   41.278803] ACPI: Interpreter enabled
[   41.278805] ACPI: (supports S0 S1 S3 S4 S5)
[   41.278819] ACPI: Using IOAPIC for interrupt routing
[   41.278986] Error attaching device data
[   41.278991] Error attaching device data
[   41.286889] ACPI: PCI Root Bridge [PCI0] (0000:00)
[   41.286898] PCI: Probing PCI hardware (bus 00)
[   41.287380] PCI: Transparent bridge - 0000:00:04.0
[   41.287553] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[   41.287729] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P1._PRT]
[   41.287834] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.BR10._PRT]
[   41.287920] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.BR11._PRT]
[   41.294802] ACPI: PCI Interrupt Link [LNKA] (IRQs 16 17 18 19) *0, disabled.
[   41.294992] ACPI: PCI Interrupt Link [LNKB] (IRQs 16 17 18 19) *0, disabled.
[   41.295181] ACPI: PCI Interrupt Link [LNKC] (IRQs 16 17 18 19) *0, disabled.
[   41.295368] ACPI: PCI Interrupt Link [LNKD] (IRQs 16 17 18 19) *0, disabled.
[   41.295556] ACPI: PCI Interrupt Link [LNEA] (IRQs 16 17 18 19) *0, disabled.
[   41.295743] ACPI: PCI Interrupt Link [LNEB] (IRQs 16 17 18 19) *0, disabled.
[   41.295930] ACPI: PCI Interrupt Link [LNEC] (IRQs 16 17 18 19) *0, disabled.
[   41.296118] ACPI: PCI Interrupt Link [LNED] (IRQs 16 17 18 19) *0, disabled.
[   41.296306] ACPI: PCI Interrupt Link [LUB0] (IRQs 20 21 22 23) *5
[   41.296493] ACPI: PCI Interrupt Link [LUB2] (IRQs 20 21 22 23) *7
[   41.296706] ACPI: PCI Interrupt Link [LMAC] (IRQs 20 21 22 23) *11
[   41.296894] ACPI: PCI Interrupt Link [LAZA] (IRQs 20 21 22 23) *10
[   41.297082] ACPI: PCI Interrupt Link [LACI] (IRQs 20 21 22 23) *0, disabled.
[   41.297270] ACPI: PCI Interrupt Link [LMC9] (IRQs 20 21 22 23) *10
[   41.297477] ACPI: PCI Interrupt Link [LSMB] (IRQs 20 21 22 23) *11
[   41.297690] ACPI: PCI Interrupt Link [LPMU] (IRQs 20 21 22 23) *0, disabled.
[   41.297878] ACPI: PCI Interrupt Link [LSA0] (IRQs 20 21 22 23) *5
[   41.298082] ACPI: PCI Interrupt Link [LSA1] (IRQs 20 21 22 23) *10
[   41.298308] ACPI: PCI Interrupt Link [LATA] (IRQs 20 21 22 23) *0, disabled.
[   41.298382] Linux Plug and Play Support v0.97 (c) Adam Belay
[   41.298393] pnp: PnP ACPI init
[   41.298399] ACPI: bus type pnp registered
[   41.302360] pnp: PnP ACPI: found 14 devices
[   41.302362] ACPI: ACPI bus type pnp unregistered
[   41.302365] PnPBIOS: Disabled by ACPI PNP
[   41.302405] PCI: Using ACPI for IRQ routing
[   41.302408] PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
[   41.309274] NET: Registered protocol family 8
[   41.309276] NET: Registered protocol family 20
[   41.309319] Time: tsc clocksource has been installed.
[   41.309335] pnp: 00:05: iomem range 0x0-0x0 could not be reserved
[   41.309338] pnp: 00:05: iomem range 0xfefe0000-0xfefe01ff has been reserved
[   41.309341] pnp: 00:05: iomem range 0xfefe1000-0xfefe1fff has been reserved
[   41.309344] pnp: 00:05: iomem range 0xfee01000-0xfeefffff could not be reserved
[   41.309348] pnp: 00:07: iomem range 0xfec00000-0xfec00fff could not be reserved
[   41.309351] pnp: 00:07: iomem range 0xfee00000-0xfee00fff could not be reserved
[   41.309356] pnp: 00:0b: ioport range 0x290-0x29f has been reserved
[   41.309361] pnp: 00:0c: iomem range 0xe0000000-0xefffffff has been reserved
[   41.309365] pnp: 00:0d: iomem range 0x0-0x9ffff could not be reserved
[   41.309367] pnp: 00:0d: iomem range 0xc0000-0xcffff could not be reserved
[   41.309370] pnp: 00:0d: iomem range 0xe0000-0xfffff could not be reserved
[   41.309373] pnp: 00:0d: iomem range 0x100000-0x3fffffff could not be reserved
[   41.337285] Switched to high resolution mode on CPU 0
[   41.339544] PCI: Bridge: 0000:00:04.0
[   41.339546]   IO window: disabled.
[   41.339549]   MEM window: disabled.
[   41.339551]   PREFETCH window: disabled.
[   41.339553] PCI: Bridge: 0000:00:09.0
[   41.339555]   IO window: disabled.
[   41.339557]   MEM window: disabled.
[   41.339559]   PREFETCH window: disabled.
[   41.339561] PCI: Bridge: 0000:00:0b.0
[   41.339562]   IO window: disabled.
[   41.339564]   MEM window: disabled.
[   41.339566]   PREFETCH window: disabled.
[   41.339568] PCI: Bridge: 0000:00:0c.0
[   41.339569]   IO window: disabled.
[   41.339571]   MEM window: disabled.
[   41.339573]   PREFETCH window: disabled.
[   41.339582] PCI: Setting latency timer of device 0000:00:04.0 to 64
[   41.339588] PCI: Setting latency timer of device 0000:00:09.0 to 64
[   41.339594] PCI: Setting latency timer of device 0000:00:0b.0 to 64
[   41.339599] PCI: Setting latency timer of device 0000:00:0c.0 to 64
[   41.339610] NET: Registered protocol family 2
[   41.377234] IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
[   41.377343] TCP established hash table entries: 131072 (order: 8, 1572864 bytes)
[   41.378458] TCP bind hash table entries: 65536 (order: 7, 524288 bytes)
[   41.378821] TCP: Hash tables configured (established 131072 bind 65536)
[   41.378824] TCP reno registered
[   41.389295] checking if image is initramfs... it is
[   41.968856] Freeing initrd memory: 7305k freed
[   41.969184] audit: initializing netlink socket (disabled)
[   41.969196] audit(1201457813.976:1): initialized
[   41.969250] highmem bounce pool size: 64 pages
[   41.970591] VFS: Disk quotas dquot_6.5.1
[   41.970628] Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
[   41.970699] io scheduler noop registered
[   41.970701] io scheduler anticipatory registered
[   41.970703] io scheduler deadline registered
[   41.970715] io scheduler cfq registered (default)
[   42.495626] Boot video device is 0000:00:0d.0
[   42.495689] PCI: Setting latency timer of device 0000:00:09.0 to 64
[   42.495707] assign_interrupt_mode Found MSI capability
[   42.495709] Allocate Port Service[0000:00:09.0:pcie00]
[   42.495754] PCI: Setting latency timer of device 0000:00:0b.0 to 64
[   42.495772] assign_interrupt_mode Found MSI capability
[   42.495774] Allocate Port Service[0000:00:0b.0:pcie00]
[   42.495821] PCI: Setting latency timer of device 0000:00:0c.0 to 64
[   42.495838] assign_interrupt_mode Found MSI capability
[   42.495840] Allocate Port Service[0000:00:0c.0:pcie00]
[   42.495927] isapnp: Scanning for PnP cards...
[   42.848287] isapnp: No Plug & Play device found
[   42.865550] Real Time Clock Driver v1.12ac
[   42.865708] hpet_resources: 0xfed00000 is busy
[   42.865741] Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
[   42.865831] serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[   42.866313] 00:0a: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[   42.866791] RAMDISK driver initialized: 16 RAM disks of 65536K size 1024 blocksize
[   42.866958] input: Macintosh mouse button emulation as /class/input/input0
[   42.867012] PNP: PS/2 Controller [PNP0303:PS2K,PNP0f03:PS2M] at 0x60,0x64 irq 1,12
[   42.870200] serio: i8042 KBD port at 0x60,0x64 irq 1
[   42.870205] serio: i8042 AUX port at 0x60,0x64 irq 12
[   42.870325] mice: PS/2 mouse device common for all mice
[   42.870406] EISA: Probing bus 0 at eisa.0
[   42.870420] Cannot allocate resource for EISA slot 4
[   42.870422] Cannot allocate resource for EISA slot 5
[   42.870424] Cannot allocate resource for EISA slot 6
[   42.870430] EISA: Detected 0 cards.
[   42.870510] TCP cubic registered
[   42.870521] NET: Registered protocol family 1
[   42.870540] Using IPI No-Shortcut mode
[   42.870682]   Magic number: 8:626:292
[   42.870703]   hash matches device ttyz6
[   42.870788]   hash matches device tty25
[   42.871046] Freeing unused kernel memory: 364k freed
[   42.911058] input: AT Translated Set 2 keyboard as /class/input/input1
[   44.071778] AppArmor: AppArmor initialized<5>audit(1201457815.976:2):  type=1505 info="AppArmor initialized" pid=1221
[   44.079456] fuse init (API version 7.8)
[   44.084684] Failure registering capabilities with primary security module.
[   44.098090] ACPI Exception (processor_core-0783): AE_NOT_FOUND, Processor Device is not present [20070126]
[   44.657056] usbcore: registered new interface driver usbfs
[   44.657078] usbcore: registered new interface driver hub
[   44.657096] usbcore: registered new device driver usb
[   44.657647] ohci_hcd: 2006 August 04 USB 1.1 'Open' Host Controller (OHCI) Driver
[   44.657976] ACPI: PCI Interrupt Link [LUB0] enabled at IRQ 23
[   44.657986] ACPI: PCI Interrupt 0000:00:02.0[A] -> Link [LUB0] -> GSI 23 (level, low) -> IRQ 16
[   44.657997] PCI: Setting latency timer of device 0000:00:02.0 to 64
[   44.658000] ohci_hcd 0000:00:02.0: OHCI Host Controller
[   44.658135] ohci_hcd 0000:00:02.0: new USB bus registered, assigned bus number 1
[   44.658150] ohci_hcd 0000:00:02.0: irq 16, io mem 0xdffff000
[   44.718794] Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
[   44.718799] ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
[   44.728574] forcedeth.c: Reverse Engineered nForce ethernet driver. Version 0.60.
[   44.740412] SCSI subsystem initialized
[   44.744433] libata version 2.21 loaded.
[   44.767395] usb usb1: configuration #1 chosen from 1 choice
[   44.767418] hub 1-0:1.0: USB hub found
[   44.767427] hub 1-0:1.0: 10 ports detected
[   44.868861] ACPI: PCI Interrupt Link [LUB2] enabled at IRQ 22
[   44.868872] ACPI: PCI Interrupt 0000:00:02.1[B] -> Link [LUB2] -> GSI 22 (level, low) -> IRQ 17
[   44.868883] PCI: Setting latency timer of device 0000:00:02.1 to 64
[   44.868886] ehci_hcd 0000:00:02.1: EHCI Host Controller
[   44.868907] ehci_hcd 0000:00:02.1: new USB bus registered, assigned bus number 2
[   44.868932] ehci_hcd 0000:00:02.1: debug port 1
[   44.868935] PCI: cache line size of 64 is not supported by device 0000:00:02.1
[   44.868945] ehci_hcd 0000:00:02.1: irq 17, io mem 0xdfffec00
[   44.868952] ehci_hcd 0000:00:02.1: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
[   44.869010] usb usb2: configuration #1 chosen from 1 choice
[   44.869035] hub 2-0:1.0: USB hub found
[   44.869041] hub 2-0:1.0: 10 ports detected
[   44.973037] NFORCE-MCP61: IDE controller at PCI slot 0000:00:06.0
[   44.973056] NFORCE-MCP61: chipset revision 162
[   44.973059] NFORCE-MCP61: not 100% native mode: will probe irqs later
[   44.973065] NFORCE-MCP61: 0000:00:06.0 (rev a2) UDMA133 controller
[   44.973072]     ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:pio
[   44.973081] Probing IDE interface ide0...
[   45.707074] hda: HL-DT-STDVD-RAM GSA-H20L, ATAPI CD/DVD-ROM drive
[   46.043050] ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
[   46.047326] ACPI: PCI Interrupt Link [LMAC] enabled at IRQ 21
[   46.047336] ACPI: PCI Interrupt 0000:00:07.0[A] -> Link [LMAC] -> GSI 21 (level, low) -> IRQ 18
[   46.047342] PCI: Setting latency timer of device 0000:00:07.0 to 64
[   46.047348] forcedeth: using HIGHDMA
[   46.566223] eth0: forcedeth.c: subsystem: 01849:03ef bound to 0000:00:07.0
[   46.569685] sata_nv 0000:00:08.0: version 3.4
[   46.570007] ACPI: PCI Interrupt Link [LSA0] enabled at IRQ 20
[   46.570016] ACPI: PCI Interrupt 0000:00:08.0[A] -> Link [LSA0] -> GSI 20 (level, low) -> IRQ 19
[   46.570053] PCI: Setting latency timer of device 0000:00:08.0 to 64
[   46.570110] scsi0 : sata_nv
[   46.570264] scsi1 : sata_nv
[   46.570398] ata1: SATA max UDMA/133 cmd 0x00010e00 ctl 0x00010e22 bmdma 0x0001d880 irq 19
[   46.570401] ata2: SATA max UDMA/133 cmd 0x00010e40 ctl 0x00010e62 bmdma 0x0001d888 irq 19
[   46.581063] hda: ATAPI 48X DVD-ROM DVD-R-RAM CD-R/RW drive, 2048kB Cache, UDMA(33)
[   46.581070] Uniform CD-ROM driver Revision: 3.20
[   47.037070] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[   47.045513] ata1.00: ATA-7: ST31000340AS, SD14, max UDMA/133
[   47.045516] ata1.00: 1953525168 sectors, multi 16: LBA48 NCQ (depth 0/32)
[   47.061457] ata1.00: configured for UDMA/133
[   47.372582] ata2: SATA link down (SStatus 0 SControl 300)
[   47.382870] scsi 0:0:0:0: Direct-Access     ATA      ST31000340AS     SD14 PQ: 0 ANSI: 5
[   47.383484] ACPI: PCI Interrupt Link [LSA1] enabled at IRQ 23
[   47.383488] ACPI: PCI Interrupt 0000:00:08.1[B] -> Link [LSA1] -> GSI 23 (level, low) -> IRQ 16
[   47.383526] PCI: Setting latency timer of device 0000:00:08.1 to 64
[   47.383559] scsi2 : sata_nv
[   47.383682] scsi3 : sata_nv
[   47.383821] ata3: SATA max UDMA/133 cmd 0x00010e80 ctl 0x00010ea2 bmdma 0x0001d000 irq 16
[   47.383824] ata4: SATA max UDMA/133 cmd 0x00010ec0 ctl 0x00010ee2 bmdma 0x0001d008 irq 16
[   47.692121] ata3: SATA link down (SStatus 0 SControl 300)
[   48.011659] ata4: SATA link down (SStatus 0 SControl 300)
[   48.030459] sd 0:0:0:0: [sda] 1953525168 512-byte hardware sectors (1000205 MB)
[   48.030471] sd 0:0:0:0: [sda] Write Protect is off
[   48.030473] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[   48.030485] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   48.030538] sd 0:0:0:0: [sda] 1953525168 512-byte hardware sectors (1000205 MB)
[   48.030545] sd 0:0:0:0: [sda] Write Protect is off
[   48.030547] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[   48.030558] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   48.030562]  sda: unknown partition table
[   48.042689] sd 0:0:0:0: [sda] Attached SCSI disk
[   48.046017] sd 0:0:0:0: Attached scsi generic sg0 type 0
[   48.468867] ISO 9660 Extensions: Microsoft Joliet Level 3
[   48.507177] ISO 9660 Extensions: RRIP_1991A
[   48.778563] Registering unionfs 1.4
[   48.778566] unionfs: debugging is not enabled
[   48.794505] loop: module loaded
[   49.049080] squashfs: version 3.2-UBUNTU (2007/07/26) Phillip Lougher
[  102.994479] i2c-adapter i2c-0: nForce2 SMBus adapter at 0x5000
[  102.994506] i2c-adapter i2c-1: nForce2 SMBus adapter at 0x6000
[  103.892731] Linux agpgart interface v0.102 (c) Dave Jones
[  104.192319] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[  104.446175] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[  104.615274] input: PC Speaker as /class/input/input2
[  104.898320] input: ImPS/2 Logitech Wheel Mouse as /class/input/input3
[  105.125680] ACPI: PCI Interrupt Link [LAZA] enabled at IRQ 22
[  105.125686] ACPI: PCI Interrupt 0000:00:05.0[B] -> Link [LAZA] -> GSI 22 (level, low) -> IRQ 17
[  105.125701] PCI: Setting latency timer of device 0000:00:05.0 to 64
[  105.333014] hda_codec: Unknown model for ALC883, trying auto-probe from BIOS...
[  108.673980] No dock devices found.
[  109.146554] input: Power Button (FF) as /class/input/input4
[  109.149994] ACPI: Power Button (FF) [PWRF]
[  109.185675] input: Power Button (CM) as /class/input/input5
[  109.189104] ACPI: Power Button (CM) [PWRB]
[  110.076864] powernow-k8: Found 1 AMD Athlon(tm) 64 Processor 3200+ processors (version 2.00.00)
[  110.076900] powernow-k8:    0 : fid 0xc (2000 MHz), vid 0x6
[  110.076903] powernow-k8:    1 : fid 0xa (1800 MHz), vid 0x8
[  110.076905] powernow-k8:    2 : fid 0x2 (1000 MHz), vid 0x12
[  115.072080] lp: driver loaded but no devices found
[  115.107560] eth0: no link during initialization.
[  115.193432] ppdev: user-space parallel port driver
[  117.297719] apm: BIOS version 1.2 Flags 0x02 (Driver version 1.16ac)
[  117.297724] apm: overridden by ACPI.
[  117.589955] Failure registering capabilities with primary security module.
[  118.469715] Bluetooth: Core ver 2.11
[  118.469814] NET: Registered protocol family 31
[  118.469817] Bluetooth: HCI device and connection manager initialized
[  118.469820] Bluetooth: HCI socket layer initialized
[   77.780000] Marking TSC unstable due to: cpufreq changes.
[   77.784000] Time: hpet clocksource has been installed.
[   77.924000] Bluetooth: L2CAP ver 2.8
[   77.924000] Bluetooth: L2CAP socket layer initialized
[   78.000000] Clocksource tsc unstable (delta = -110532165 ns)
[   78.204000] Bluetooth: RFCOMM socket layer initialized
[   78.204000] Bluetooth: RFCOMM TTY layer initialized
[   78.204000] Bluetooth: RFCOMM ver 1.8

--dDRMvlgZJXvWKvBx--
