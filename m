From: Johnny Luong <johnny.linux-ide@compfazed.com>
Subject: unable to use cdrom/dvd drive after some usage
Date: Mon, 14 Jan 2008 20:46:08 -0800
Message-ID: <20080115044608.GA13420@www>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="cNdxnHkX5QqsyA0e"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtpauth.rollernet.us ([208.11.75.5]:52876 "EHLO
	smtpauth.rollernet.us" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750719AbYAOFB2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 15 Jan 2008 00:01:28 -0500
Received: from smtpauth.rollernet.us (localhost.localdomain [127.0.0.1])
	by smtpauth.rollernet.us (Postfix) with ESMTP id F2391594038
	for <linux-ide@vger.kernel.org>; Mon, 14 Jan 2008 20:39:08 -0800 (PST)
Received: from www.compfazed.com (cpe-66-75-83-220.socal.res.rr.com [66.75.83.220])
	by smtpauth.rollernet.us (Postfix) with ESMTP
	for <linux-ide@vger.kernel.org>; Mon, 14 Jan 2008 20:39:05 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


--cNdxnHkX5QqsyA0e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

If possible, I would like to know if its worthwhile simply just to get another
SATA drive / different controller / cable rather than trying to figure out
this PATA drive on SATA/PATA controller...  see attached for bug report and
config file.  I'm not on this email list so if you can CC that would be 
appreciated.

Thanks,
Johnny

--cNdxnHkX5QqsyA0e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="bug-report.txt"

1) No longer able to access DVD/CD drive after HSM violation.  It becomes available again after reboot.
2) On some occassions when reading from the drive, the application (wine) 
closes down and the kernel reports a weird exception.  The disc itself employs
SecuROM but generally speaking runs as expected.
3) pata_jmicron
4.1) Linux version 2.6.23.12 (root@belldandy) (gcc version 4.1.2 20061115 (prerelease) (Debian 4.1.1-21)) #1 SMP Sun Dec 23 15:01:19 PST 2007
4.2) See attached.
5) I've encountered this on older versions as well...
6) N/A
7) Not really sure how I can reproduce this one.
8.1)
Linux belldandy 2.6.23.12 #1 SMP Sun Dec 23 15:01:19 PST 2007 x86_64 GNU/Linux
 
Gnu C                  4.1.2
Gnu make               3.81
binutils               2.17
util-linux             2.12r
mount                  2.12r
module-init-tools      3.3-pre2
e2fsprogs              1.40-WIP
reiserfsprogs          3.6.19
PPP                    2.4.4
Linux C Library        3.6
Dynamic linker (ldd)   2.3.6
Procps                 3.2.7
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.97
udev                   105
wireless-tools         28
Modules Loaded         appletalk ax25 ipx p8023 nvidia ppdev parport_pc lp parport fan ac battery ipv6 dm_snapshot dm_mirror snd_pcm_oss snd_mixer_oss sbp2 loop snd_emu10k1 snd_rawmidi firmware_class snd_ac97_codec ac97_bus snd_seq_device snd_hda_intel snd_pcm snd_util_mem ohci1394 snd_timer snd_page_alloc thermal snd_hwdep snd soundcore processor button intel_agp ieee1394 i2c_i801 i2c_core emu10k1_gp tsdev gameport floppy r8169 joydev pcspkr sg sr_mod cdrom reiserfs dm_mod sd_mod generic ide_core evdev usbhid usbkbd ehci_hcd uhci_hcd

8.2)
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 15
model name      : Intel(R) Core(TM)2 CPU          6600  @ 2.40GHz
stepping        : 6
cpu MHz         : 2394.081
cache size      : 4096 KB
physical id     : 0
siblings        : 2
core id         : 0
cpu cores       : 2
fpu             : yes
fpu_exception   : yes
cpuid level     : 10
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx lm constant_tsc arch_perfmon pebs bts rep_good pni monitor ds_cpl vmx est tm2 ssse3 cx16 xtpr lahf_lm
bogomips        : 4792.96
clflush size    : 64
cache_alignment : 64
address sizes   : 36 bits physical, 48 bits virtual
power management:

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 6
model           : 15
model name      : Intel(R) Core(TM)2 CPU          6600  @ 2.40GHz
stepping        : 6
cpu MHz         : 2394.081
cache size      : 4096 KB
physical id     : 0
siblings        : 2
core id         : 1
cpu cores       : 2
fpu             : yes
fpu_exception   : yes
cpuid level     : 10
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx lm constant_tsc arch_perfmon pebs bts rep_good pni monitor ds_cpl vmx est tm2 ssse3 cx16 xtpr lahf_lm
bogomips        : 4789.23
clflush size    : 64
cache_alignment : 64
address sizes   : 36 bits physical, 48 bits virtual
power management:

8.3)
appletalk 42544 2 - Live 0xffffffff88b72000
ax25 62140 2 - Live 0xffffffff88b61000
ipx 33864 2 - Live 0xffffffff88b57000
p8023 4672 1 ipx, Live 0xffffffff88b54000
nvidia 8896356 24 - Live 0xffffffff882d7000 (P)
ppdev 11912 0 - Live 0xffffffff882d3000
parport_pc 40936 0 - Live 0xffffffff882c8000
lp 15560 0 - Live 0xffffffff882c3000
parport 42764 3 ppdev,parport_pc,lp, Live 0xffffffff882b7000
fan 8264 0 - Live 0xffffffff882b3000
ac 8840 0 - Live 0xffffffff882af000
battery 16208 0 - Live 0xffffffff882aa000
ipv6 283944 16 - Live 0xffffffff88263000
dm_snapshot 20104 0 - Live 0xffffffff8825d000
dm_mirror 25152 0 - Live 0xffffffff88255000
snd_pcm_oss 45600 0 - Live 0xffffffff88248000
snd_mixer_oss 19968 1 snd_pcm_oss, Live 0xffffffff88242000
sbp2 26376 0 - Live 0xffffffff8823a000
loop 21572 0 - Live 0xffffffff88233000
snd_emu10k1 143584 0 - Live 0xffffffff8820e000
snd_rawmidi 29024 1 snd_emu10k1, Live 0xffffffff88205000
firmware_class 13440 1 snd_emu10k1, Live 0xffffffff88200000
snd_ac97_codec 116760 1 snd_emu10k1, Live 0xffffffff881e2000
ac97_bus 5248 1 snd_ac97_codec, Live 0xffffffff881df000
snd_seq_device 11220 2 snd_emu10k1,snd_rawmidi, Live 0xffffffff881db000
snd_hda_intel 358888 0 - Live 0xffffffff88180000
snd_pcm 88072 4 snd_pcm_oss,snd_emu10k1,snd_ac97_codec,snd_hda_intel, Live 0xffffffff88169000
snd_util_mem 7616 1 snd_emu10k1, Live 0xffffffff88166000
ohci1394 35060 0 - Live 0xffffffff8815c000
snd_timer 26824 2 snd_emu10k1,snd_pcm, Live 0xffffffff88154000
snd_page_alloc 13776 3 snd_emu10k1,snd_hda_intel,snd_pcm, Live 0xffffffff8814f000
thermal 20320 0 - Live 0xffffffff88149000
snd_hwdep 13064 2 snd_emu10k1,snd_hda_intel, Live 0xffffffff88144000
snd 65512 10 snd_pcm_oss,snd_mixer_oss,snd_emu10k1,snd_rawmidi,snd_ac97_codec,snd_seq_device,snd_hda_intel,snd_pcm,snd_timer,snd_hwdep, Live 0xffffffff88133000
soundcore 11296 1 snd, Live 0xffffffff8812f000
processor 41832 1 thermal, Live 0xffffffff88123000
button 11936 0 - Live 0xffffffff8811f000
intel_agp 30240 0 - Live 0xffffffff88116000
ieee1394 100696 2 sbp2,ohci1394, Live 0xffffffff880fc000
i2c_i801 11996 0 - Live 0xffffffff880f8000
i2c_core 29120 2 nvidia,i2c_i801, Live 0xffffffff880ef000
emu10k1_gp 6656 0 - Live 0xffffffff880ec000
tsdev 11520 0 - Live 0xffffffff880e8000
gameport 19408 2 emu10k1_gp, Live 0xffffffff880e2000
floppy 64872 0 - Live 0xffffffff880d1000
r8169 34628 0 - Live 0xffffffff880c7000
joydev 13824 0 - Live 0xffffffff880c0000
pcspkr 5824 0 - Live 0xffffffff880bd000
sg 39144 0 - Live 0xffffffff880b2000
sr_mod 20644 0 - Live 0xffffffff880ab000
cdrom 37864 1 sr_mod, Live 0xffffffff880a0000
reiserfs 230976 6 - Live 0xffffffff88066000
dm_mod 62384 15 dm_snapshot,dm_mirror, Live 0xffffffff88055000
sd_mod 31680 3 - Live 0xffffffff8804c000
generic 8452 0 [permanent], Live 0xffffffff88048000
ide_core 142480 1 generic, Live 0xffffffff88024000
evdev 13440 0 - Live 0xffffffff8801f000
usbhid 32352 0 - Live 0xffffffff88016000
usbkbd 9792 0 - Live 0xffffffff88012000
ehci_hcd 36748 0 - Live 0xffffffff88008000
uhci_hcd 27992 0 - Live 0xffffffff88000000

8.4)
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
03c0-03df : vga+
03f2-03f5 : floppy
03f7-03f7 : floppy DIR
0400-047f : 0000:00:1f.0
  0400-0403 : ACPI PM1a_EVT_BLK
  0404-0405 : ACPI PM1a_CNT_BLK
  0408-040b : ACPI PM_TMR
  0428-042f : ACPI GPE0_BLK
0480-04bf : 0000:00:1f.0
0500-051f : 0000:00:1f.3
  0500-051f : i801_smbus
0cf8-0cff : PCI conf1
7000-7fff : PCI Bus #03
  7e00-7eff : 0000:03:00.0
    7e00-7eff : r8169
8000-8fff : PCI Bus #02
9000-9fff : PCI Bus #01
  9f00-9f7f : 0000:01:00.0
a000-afff : PCI Bus #06
  ab00-ab0f : 0000:06:00.1
    ab00-ab0f : libata
  ac00-ac03 : 0000:06:00.1
    ac00-ac03 : libata
  ad00-ad07 : 0000:06:00.1
    ad00-ad07 : libata
  ae00-ae03 : 0000:06:00.1
    ae00-ae03 : libata
  af00-af07 : 0000:06:00.1
    af00-af07 : libata
b000-bfff : PCI Bus #05
  be00-beff : 0000:05:00.0
    be00-beff : r8169
c000-cfff : PCI Bus #04
  cf00-cf7f : 0000:04:00.0
d000-dfff : PCI Bus #07
  de00-de07 : 0000:07:06.1
    de00-de07 : emu10k1-gp
  df00-df3f : 0000:07:06.0
    df00-df3f : EMU10K1
ee00-ee0f : 0000:00:1f.5
ef00-ef0f : 0000:00:1f.5
  ef00-ef0f : libata
f000-f003 : 0000:00:1f.5
  f000-f003 : libata
f100-f107 : 0000:00:1f.5
  f100-f107 : libata
f200-f203 : 0000:00:1f.5
  f200-f203 : libata
f300-f307 : 0000:00:1f.5
  f300-f307 : libata
f500-f50f : 0000:00:1f.2
f600-f60f : 0000:00:1f.2
  f600-f60f : libata
f700-f703 : 0000:00:1f.2
  f700-f703 : libata
f800-f807 : 0000:00:1f.2
  f800-f807 : libata
f900-f903 : 0000:00:1f.2
  f900-f903 : libata
fa00-fa07 : 0000:00:1f.2
  fa00-fa07 : libata
fb00-fb1f : 0000:00:1d.2
  fb00-fb1f : uhci_hcd
fc00-fc1f : 0000:00:1d.1
  fc00-fc1f : uhci_hcd
fd00-fd1f : 0000:00:1d.0
  fd00-fd1f : uhci_hcd
fe00-fe1f : 0000:00:1a.1
  fe00-fe1f : uhci_hcd
ff00-ff1f : 0000:00:1a.0
  ff00-ff1f : uhci_hcd
00000000-0009f3ff : System RAM
  00000000-00000000 : Crash kernel
0009f400-0009ffff : reserved
000f0000-000fffff : reserved
00100000-7fedffff : System RAM
  00200000-00421f34 : Kernel code
  00421f35-0052923f : Kernel data
7fee0000-7fee2fff : ACPI Non-volatile Storage
7fee3000-7feeffff : ACPI Tables
7fef0000-7fefffff : reserved
7ff00000-7fffffff : pnp 00:0b
d0000000-dfffffff : PCI Bus #01
  d0000000-dfffffff : 0000:01:00.0
e0000000-efffffff : PCI MMCONFIG 0
  e0000000-efffffff : reserved
f8000000-fbffffff : PCI Bus #01
  f8000000-f9ffffff : 0000:01:00.0
  fa000000-faffffff : 0000:01:00.0
    fa000000-faffffff : nvidia
  fb000000-fb01ffff : 0000:01:00.0
fd300000-fd3fffff : PCI Bus #03
  fd3ff000-fd3fffff : 0000:03:00.0
    fd3ff000-fd3fffff : r8169
fd400000-fd4fffff : PCI Bus #02
fd500000-fd5fffff : PCI Bus #07
fd600000-fd6fffff : PCI Bus #07
  fd6f4000-fd6f7fff : 0000:07:06.2
  fd6f8000-fd6fbfff : 0000:07:02.0
  fd6fe000-fd6fe7ff : 0000:07:06.2
    fd6fe000-fd6fe7ff : ohci1394
  fd6ff000-fd6ff7ff : 0000:07:02.0
    fd6ff000-fd6ff7ff : ohci1394
fd700000-fd7fffff : PCI Bus #02
fd800000-fd8fffff : PCI Bus #06
  fd800000-fd80ffff : 0000:06:00.0
fd900000-fd9fffff : PCI Bus #06
  fd9fe000-fd9fffff : 0000:06:00.0
    fd9fe000-fd9fffff : ahci
fda00000-fdafffff : PCI Bus #05
  fda00000-fda0ffff : 0000:05:00.0
fdb00000-fdbfffff : PCI Bus #05
  fdbff000-fdbfffff : 0000:05:00.0
    fdbff000-fdbfffff : r8169
fdc00000-fdcfffff : PCI Bus #04
  fdc00000-fdc7ffff : 0000:04:00.0
fdd00000-fddfffff : PCI Bus #04
  fddf8000-fddfbfff : 0000:04:00.0
    fddf8000-fddfbfff : sata_sil24
  fddff000-fddff07f : 0000:04:00.0
    fddff000-fddff07f : sata_sil24
fde00000-fdefffff : PCI Bus #03
  fde00000-fde0ffff : 0000:03:00.0
fdff8000-fdffbfff : 0000:00:1b.0
  fdff8000-fdffbfff : ICH HD audio
fdffd000-fdffd0ff : 0000:00:1f.3
fdffe000-fdffe3ff : 0000:00:1d.7
  fdffe000-fdffe3ff : ehci_hcd
fdfff000-fdfff3ff : 0000:00:1a.7
  fdfff000-fdfff3ff : ehci_hcd
fec00000-fec00fff : IOAPIC 0
fee00000-fee00fff : Local APIC

8.5)

00:00.0 Host bridge: Intel Corporation P965/G965 Memory Controller Hub (rev 02)
	Subsystem: ABIT Computer Corp. Unknown device 1073
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Capabilities: [e0] Vendor Specific Information

00:01.0 PCI bridge: Intel Corporation P965/G965 PCI Express Root Port (rev 02) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size: 64 bytes
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 00009000-00009fff
	Memory behind bridge: f8000000-fbffffff
	Prefetchable memory behind bridge: 00000000d0000000-00000000dfffffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-
	Capabilities: [88] Subsystem: Intel Corporation Unknown device 0000
	Capabilities: [80] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [90] Message Signalled Interrupts: Mask- 64bit- Queue=0/0 Enable+
		Address: fee0300c  Data: 4169
	Capabilities: [a0] Express Root Port (Slot+) IRQ 0
		Device: Supported: MaxPayload 128 bytes, PhantFunc 0, ExtTag-
		Device: Latency L0s <64ns, L1 <1us
		Device: Errors: Correctable+ Non-Fatal+ Fatal+ Unsupported+
		Device: RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
		Device: MaxPayload 128 bytes, MaxReadReq 128 bytes
		Link: Supported Speed 2.5Gb/s, Width x16, ASPM L0s, Port 2
		Link: Latency L0s <256ns, L1 <4us
		Link: ASPM Disabled RCB 64 bytes CommClk+ ExtSynch-
		Link: Speed 2.5Gb/s, Width x16
		Slot: AtnBtn- PwrCtrl- MRL- AtnInd- PwrInd- HotPlug- Surpise-
		Slot: Number 32, PowerLimit 75.000000
		Slot: Enabled AtnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq-
		Slot: AttnInd Off, PwrInd On, Power-
		Root: Correctable- Non-Fatal- Fatal- PME-
	Capabilities: [100] Virtual Channel
	Capabilities: [140] Unknown (5)

00:1a.0 USB Controller: Intel Corporation 82801H (ICH8 Family) USB UHCI #4 (rev 02) (prog-if 00 [UHCI])
	Subsystem: ABIT Computer Corp. Unknown device 1073
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 16
	Region 4: I/O ports at ff00 [size=32]

00:1a.1 USB Controller: Intel Corporation 82801H (ICH8 Family) USB UHCI #5 (rev 02) (prog-if 00 [UHCI])
	Subsystem: ABIT Computer Corp. Unknown device 1073
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 21
	Region 4: I/O ports at fe00 [size=32]

00:1a.7 USB Controller: Intel Corporation 82801H (ICH8 Family) USB2 EHCI #2 (rev 02) (prog-if 20 [EHCI])
	Subsystem: ABIT Computer Corp. Unknown device 1073
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin C routed to IRQ 18
	Region 0: Memory at fdfff000 (32-bit, non-prefetchable) [size=1K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:1b.0 Audio device: Intel Corporation 82801H (ICH8 Family) HD Audio Controller (rev 02)
	Subsystem: ABIT Computer Corp. Unknown device 1073
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 22
	Region 0: Memory at fdff8000 (64-bit, non-prefetchable) [size=16K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [60] Message Signalled Interrupts: Mask- 64bit+ Queue=0/0 Enable-
		Address: 0000000000000000  Data: 0000
	Capabilities: [70] Express Unknown type IRQ 0
		Device: Supported: MaxPayload 128 bytes, PhantFunc 0, ExtTag-
		Device: Latency L0s <64ns, L1 <1us
		Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
		Device: RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop+
		Device: MaxPayload 128 bytes, MaxReadReq 128 bytes
		Link: Supported Speed unknown, Width x0, ASPM unknown, Port 0
		Link: Latency L0s <64ns, L1 <1us
		Link: ASPM Disabled CommClk- ExtSynch-
		Link: Speed unknown, Width x0
	Capabilities: [100] Virtual Channel
	Capabilities: [130] Unknown (5)

00:1c.0 PCI bridge: Intel Corporation 82801H (ICH8 Family) PCI Express Port 1 (rev 02) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size: 64 bytes
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
	I/O behind bridge: 00008000-00008fff
	Memory behind bridge: fd700000-fd7fffff
	Prefetchable memory behind bridge: 00000000fd400000-00000000fd4fffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
	Capabilities: [40] Express Root Port (Slot+) IRQ 0
		Device: Supported: MaxPayload 128 bytes, PhantFunc 0, ExtTag-
		Device: Latency L0s unlimited, L1 unlimited
		Device: Errors: Correctable+ Non-Fatal+ Fatal+ Unsupported+
		Device: RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
		Device: MaxPayload 128 bytes, MaxReadReq 128 bytes
		Link: Supported Speed 2.5Gb/s, Width x1, ASPM L0s L1, Port 1
		Link: Latency L0s <256ns, L1 <4us
		Link: ASPM Disabled RCB 64 bytes Disabled CommClk+ ExtSynch-
		Link: Speed 2.5Gb/s, Width x0
		Slot: AtnBtn- PwrCtrl- MRL- AtnInd- PwrInd- HotPlug+ Surpise+
		Slot: Number 16, PowerLimit 10.000000
		Slot: Enabled AtnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq-
		Slot: AttnInd Unknown, PwrInd Unknown, Power-
		Root: Correctable- Non-Fatal- Fatal- PME-
	Capabilities: [80] Message Signalled Interrupts: Mask- 64bit- Queue=0/0 Enable+
		Address: fee0300c  Data: 4171
	Capabilities: [90] Subsystem: Intel Corporation 82801H (ICH8 Family) PCI Express Port 1
	Capabilities: [a0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [100] Virtual Channel
	Capabilities: [180] Unknown (5)

00:1c.2 PCI bridge: Intel Corporation 82801H (ICH8 Family) PCI Express Port 3 (rev 02) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size: 64 bytes
	Bus: primary=00, secondary=03, subordinate=03, sec-latency=0
	I/O behind bridge: 00007000-00007fff
	Memory behind bridge: fd300000-fd3fffff
	Prefetchable memory behind bridge: 00000000fde00000-00000000fdefffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
	Capabilities: [40] Express Root Port (Slot+) IRQ 0
		Device: Supported: MaxPayload 128 bytes, PhantFunc 0, ExtTag-
		Device: Latency L0s unlimited, L1 unlimited
		Device: Errors: Correctable+ Non-Fatal+ Fatal+ Unsupported+
		Device: RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
		Device: MaxPayload 128 bytes, MaxReadReq 128 bytes
		Link: Supported Speed 2.5Gb/s, Width x1, ASPM L0s L1, Port 3
		Link: Latency L0s <256ns, L1 <4us
		Link: ASPM Disabled RCB 64 bytes CommClk+ ExtSynch-
		Link: Speed 2.5Gb/s, Width x1
		Slot: AtnBtn- PwrCtrl- MRL- AtnInd- PwrInd- HotPlug+ Surpise+
		Slot: Number 18, PowerLimit 10.000000
		Slot: Enabled AtnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq-
		Slot: AttnInd Unknown, PwrInd Unknown, Power-
		Root: Correctable- Non-Fatal- Fatal- PME-
	Capabilities: [80] Message Signalled Interrupts: Mask- 64bit- Queue=0/0 Enable+
		Address: fee0300c  Data: 4179
	Capabilities: [90] Subsystem: Intel Corporation 82801H (ICH8 Family) PCI Express Port 3
	Capabilities: [a0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [100] Virtual Channel
	Capabilities: [180] Unknown (5)

00:1c.3 PCI bridge: Intel Corporation 82801H (ICH8 Family) PCI Express Port 4 (rev 02) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size: 64 bytes
	Bus: primary=00, secondary=04, subordinate=04, sec-latency=0
	I/O behind bridge: 0000c000-0000cfff
	Memory behind bridge: fdd00000-fddfffff
	Prefetchable memory behind bridge: 00000000fdc00000-00000000fdcfffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
	Capabilities: [40] Express Root Port (Slot+) IRQ 0
		Device: Supported: MaxPayload 128 bytes, PhantFunc 0, ExtTag-
		Device: Latency L0s unlimited, L1 unlimited
		Device: Errors: Correctable+ Non-Fatal+ Fatal+ Unsupported+
		Device: RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
		Device: MaxPayload 128 bytes, MaxReadReq 128 bytes
		Link: Supported Speed 2.5Gb/s, Width x1, ASPM L0s L1, Port 4
		Link: Latency L0s <256ns, L1 <4us
		Link: ASPM Disabled RCB 64 bytes CommClk+ ExtSynch-
		Link: Speed 2.5Gb/s, Width x1
		Slot: AtnBtn- PwrCtrl- MRL- AtnInd- PwrInd- HotPlug+ Surpise+
		Slot: Number 19, PowerLimit 10.000000
		Slot: Enabled AtnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq-
		Slot: AttnInd Unknown, PwrInd Unknown, Power-
		Root: Correctable- Non-Fatal- Fatal- PME-
	Capabilities: [80] Message Signalled Interrupts: Mask- 64bit- Queue=0/0 Enable+
		Address: fee0300c  Data: 4181
	Capabilities: [90] Subsystem: Intel Corporation 82801H (ICH8 Family) PCI Express Port 4
	Capabilities: [a0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [100] Virtual Channel
	Capabilities: [180] Unknown (5)

00:1c.4 PCI bridge: Intel Corporation 82801H (ICH8 Family) PCI Express Port 5 (rev 02) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size: 64 bytes
	Bus: primary=00, secondary=05, subordinate=05, sec-latency=0
	I/O behind bridge: 0000b000-0000bfff
	Memory behind bridge: fdb00000-fdbfffff
	Prefetchable memory behind bridge: 00000000fda00000-00000000fdafffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
	Capabilities: [40] Express Root Port (Slot+) IRQ 0
		Device: Supported: MaxPayload 128 bytes, PhantFunc 0, ExtTag-
		Device: Latency L0s unlimited, L1 unlimited
		Device: Errors: Correctable+ Non-Fatal+ Fatal+ Unsupported+
		Device: RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
		Device: MaxPayload 128 bytes, MaxReadReq 128 bytes
		Link: Supported Speed 2.5Gb/s, Width x1, ASPM L0s L1, Port 5
		Link: Latency L0s <256ns, L1 <4us
		Link: ASPM Disabled RCB 64 bytes CommClk+ ExtSynch-
		Link: Speed 2.5Gb/s, Width x1
		Slot: AtnBtn- PwrCtrl- MRL- AtnInd- PwrInd- HotPlug+ Surpise+
		Slot: Number 20, PowerLimit 10.000000
		Slot: Enabled AtnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq-
		Slot: AttnInd Unknown, PwrInd Unknown, Power-
		Root: Correctable- Non-Fatal- Fatal- PME-
	Capabilities: [80] Message Signalled Interrupts: Mask- 64bit- Queue=0/0 Enable+
		Address: fee0300c  Data: 4189
	Capabilities: [90] Subsystem: Intel Corporation 82801H (ICH8 Family) PCI Express Port 5
	Capabilities: [a0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [100] Virtual Channel
	Capabilities: [180] Unknown (5)

00:1c.5 PCI bridge: Intel Corporation 82801H (ICH8 Family) PCI Express Port 6 (rev 02) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0, Cache Line Size: 64 bytes
	Bus: primary=00, secondary=06, subordinate=06, sec-latency=0
	I/O behind bridge: 0000a000-0000afff
	Memory behind bridge: fd900000-fd9fffff
	Prefetchable memory behind bridge: 00000000fd800000-00000000fd8fffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
	Capabilities: [40] Express Root Port (Slot+) IRQ 0
		Device: Supported: MaxPayload 128 bytes, PhantFunc 0, ExtTag-
		Device: Latency L0s unlimited, L1 unlimited
		Device: Errors: Correctable+ Non-Fatal+ Fatal+ Unsupported+
		Device: RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
		Device: MaxPayload 128 bytes, MaxReadReq 128 bytes
		Link: Supported Speed 2.5Gb/s, Width x1, ASPM L0s L1, Port 6
		Link: Latency L0s <256ns, L1 <4us
		Link: ASPM Disabled RCB 64 bytes CommClk+ ExtSynch-
		Link: Speed 2.5Gb/s, Width x1
		Slot: AtnBtn- PwrCtrl- MRL- AtnInd- PwrInd- HotPlug+ Surpise+
		Slot: Number 21, PowerLimit 10.000000
		Slot: Enabled AtnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq-
		Slot: AttnInd Unknown, PwrInd Unknown, Power-
		Root: Correctable- Non-Fatal- Fatal- PME-
	Capabilities: [80] Message Signalled Interrupts: Mask- 64bit- Queue=0/0 Enable+
		Address: fee0300c  Data: 4191
	Capabilities: [90] Subsystem: Intel Corporation 82801H (ICH8 Family) PCI Express Port 6
	Capabilities: [a0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [100] Virtual Channel
	Capabilities: [180] Unknown (5)

00:1d.0 USB Controller: Intel Corporation 82801H (ICH8 Family) USB UHCI #1 (rev 02) (prog-if 00 [UHCI])
	Subsystem: ABIT Computer Corp. Unknown device 1073
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 23
	Region 4: I/O ports at fd00 [size=32]

00:1d.1 USB Controller: Intel Corporation 82801H (ICH8 Family) USB UHCI #2 (rev 02) (prog-if 00 [UHCI])
	Subsystem: ABIT Computer Corp. Unknown device 1073
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 19
	Region 4: I/O ports at fc00 [size=32]

00:1d.2 USB Controller: Intel Corporation 82801H (ICH8 Family) USB UHCI #3 (rev 02) (prog-if 00 [UHCI])
	Subsystem: ABIT Computer Corp. Unknown device 1073
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin C routed to IRQ 18
	Region 4: I/O ports at fb00 [size=32]

00:1d.7 USB Controller: Intel Corporation 82801H (ICH8 Family) USB2 EHCI #1 (rev 02) (prog-if 20 [EHCI])
	Subsystem: ABIT Computer Corp. Unknown device 1073
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 23
	Region 0: Memory at fdffe000 (32-bit, non-prefetchable) [size=1K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev f2) (prog-if 01 [Subtractive decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=07, subordinate=07, sec-latency=32
	I/O behind bridge: 0000d000-0000dfff
	Memory behind bridge: fd600000-fd6fffff
	Prefetchable memory behind bridge: 00000000fd500000-00000000fd5fffff
	Secondary status: 66MHz- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
	Capabilities: [50] Subsystem: Intel Corporation 82801 PCI Bridge

00:1f.0 ISA bridge: Intel Corporation 82801HB/HR (ICH8/R) LPC Interface Controller (rev 02)
	Subsystem: Intel Corporation 82801HB/HR (ICH8/R) LPC Interface Controller
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: [e0] Vendor Specific Information

00:1f.2 IDE interface: Intel Corporation 82801H (ICH8 Family) 4 port SATA IDE Controller (rev 02) (prog-if 8f [Master SecP SecO PriP PriO])
	Subsystem: ABIT Computer Corp. Unknown device 1073
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 19
	Region 0: I/O ports at fa00 [size=8]
	Region 1: I/O ports at f900 [size=4]
	Region 2: I/O ports at f800 [size=8]
	Region 3: I/O ports at f700 [size=4]
	Region 4: I/O ports at f600 [size=16]
	Region 5: I/O ports at f500 [size=16]
	Capabilities: [70] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:1f.3 SMBus: Intel Corporation 82801H (ICH8 Family) SMBus Controller (rev 02)
	Subsystem: Intel Corporation 82801H (ICH8 Family) SMBus Controller
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin B routed to IRQ 19
	Region 0: Memory at fdffd000 (32-bit, non-prefetchable) [size=256]
	Region 4: I/O ports at 0500 [size=32]

00:1f.5 IDE interface: Intel Corporation 82801H (ICH8 Family) 2 port SATA IDE Controller (rev 02) (prog-if 85 [Master SecO PriO])
	Subsystem: ABIT Computer Corp. Unknown device 1073
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 19
	Region 0: I/O ports at f300 [size=8]
	Region 1: I/O ports at f200 [size=4]
	Region 2: I/O ports at f100 [size=8]
	Region 3: I/O ports at f000 [size=4]
	Region 4: I/O ports at ef00 [size=16]
	Region 5: I/O ports at ee00 [size=16]
	Capabilities: [70] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: nVidia Corporation Unknown device 0402 (rev a1) (prog-if 00 [VGA])
	Subsystem: eVga.com. Corp. Unknown device c751
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 16
	Region 0: Memory at fa000000 (32-bit, non-prefetchable) [size=16M]
	Region 1: Memory at d0000000 (64-bit, prefetchable) [size=256M]
	Region 3: Memory at f8000000 (64-bit, non-prefetchable) [size=32M]
	Region 5: I/O ports at 9f00 [size=128]
	[virtual] Expansion ROM at fb000000 [disabled] [size=128K]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [68] Message Signalled Interrupts: Mask- 64bit+ Queue=0/0 Enable-
		Address: 0000000000000000  Data: 0000
	Capabilities: [78] Express Endpoint IRQ 0
		Device: Supported: MaxPayload 128 bytes, PhantFunc 0, ExtTag+
		Device: Latency L0s <512ns, L1 <4us
		Device: AtnBtn- AtnInd- PwrInd-
		Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
		Device: RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
		Device: MaxPayload 128 bytes, MaxReadReq 512 bytes
		Link: Supported Speed 2.5Gb/s, Width x16, ASPM L0s L1, Port 0
		Link: Latency L0s <512ns, L1 <4us
		Link: ASPM Disabled RCB 128 bytes CommClk+ ExtSynch-
		Link: Speed 2.5Gb/s, Width x16
	Capabilities: [100] Virtual Channel
	Capabilities: [128] Power Budgeting
	Capabilities: [600] Unknown (11)

03:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL8111/8168B PCI Express Gigabit Ethernet controller (rev 01)
	Subsystem: ABIT Computer Corp. Unknown device 1073
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 18
	Region 0: I/O ports at 7e00 [size=256]
	Region 2: Memory at fd3ff000 (64-bit, non-prefetchable) [size=4K]
	[virtual] Expansion ROM at fde00000 [disabled] [size=64K]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0-,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [48] Vital Product Data
	Capabilities: [50] Message Signalled Interrupts: Mask- 64bit+ Queue=0/1 Enable-
		Address: 0000000000000000  Data: 0000
	Capabilities: [60] Express Endpoint IRQ 0
		Device: Supported: MaxPayload 1024 bytes, PhantFunc 0, ExtTag-
		Device: Latency L0s unlimited, L1 unlimited
		Device: AtnBtn+ AtnInd+ PwrInd+
		Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
		Device: RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
		Device: MaxPayload 128 bytes, MaxReadReq 4096 bytes
		Link: Supported Speed 2.5Gb/s, Width x1, ASPM L0s L1, Port 0
		Link: Latency L0s unlimited, L1 unlimited
		Link: ASPM Disabled RCB 64 bytes CommClk+ ExtSynch-
		Link: Speed 2.5Gb/s, Width x1
	Capabilities: [84] Vendor Specific Information
	Capabilities: [100] Advanced Error Reporting
	Capabilities: [12c] Virtual Channel
	Capabilities: [148] Device Serial Number 00-00-00-00-00-00-00-37
	Capabilities: [154] Power Budgeting

04:00.0 Mass storage controller: Silicon Image, Inc. SiI 3132 Serial ATA Raid II Controller (rev 01)
	Subsystem: Silicon Image, Inc. SiI 3132 Serial ATA Raid II Controller
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 19
	Region 0: Memory at fddff000 (64-bit, non-prefetchable) [size=128]
	Region 2: Memory at fddf8000 (64-bit, non-prefetchable) [size=16K]
	Region 4: I/O ports at cf00 [size=128]
	[virtual] Expansion ROM at fdc00000 [disabled] [size=512K]
	Capabilities: [54] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=1 PME-
	Capabilities: [5c] Message Signalled Interrupts: Mask- 64bit+ Queue=0/0 Enable-
		Address: 0000000000000000  Data: 0000
	Capabilities: [70] Express Legacy Endpoint IRQ 0
		Device: Supported: MaxPayload 1024 bytes, PhantFunc 0, ExtTag-
		Device: Latency L0s <64ns, L1 <1us
		Device: AtnBtn- AtnInd- PwrInd-
		Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
		Device: RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
		Device: MaxPayload 128 bytes, MaxReadReq 512 bytes
		Link: Supported Speed 2.5Gb/s, Width x1, ASPM L0s, Port 0
		Link: Latency L0s unlimited, L1 unlimited
		Link: ASPM Disabled RCB 64 bytes CommClk+ ExtSynch-
		Link: Speed 2.5Gb/s, Width x1
	Capabilities: [100] Advanced Error Reporting

05:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL8111/8168B PCI Express Gigabit Ethernet controller (rev 01)
	Subsystem: ABIT Computer Corp. Unknown device 1073
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 16
	Region 0: I/O ports at be00 [size=256]
	Region 2: Memory at fdbff000 (64-bit, non-prefetchable) [size=4K]
	[virtual] Expansion ROM at fda00000 [disabled] [size=64K]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0-,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [48] Vital Product Data
	Capabilities: [50] Message Signalled Interrupts: Mask- 64bit+ Queue=0/1 Enable-
		Address: 0000000000000000  Data: 0000
	Capabilities: [60] Express Endpoint IRQ 0
		Device: Supported: MaxPayload 1024 bytes, PhantFunc 0, ExtTag-
		Device: Latency L0s unlimited, L1 unlimited
		Device: AtnBtn+ AtnInd+ PwrInd+
		Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
		Device: RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
		Device: MaxPayload 128 bytes, MaxReadReq 512 bytes
		Link: Supported Speed 2.5Gb/s, Width x1, ASPM L0s L1, Port 0
		Link: Latency L0s unlimited, L1 unlimited
		Link: ASPM Disabled RCB 64 bytes CommClk+ ExtSynch-
		Link: Speed 2.5Gb/s, Width x1
	Capabilities: [84] Vendor Specific Information
	Capabilities: [100] Advanced Error Reporting
	Capabilities: [12c] Virtual Channel
	Capabilities: [148] Device Serial Number 00-00-00-00-00-00-00-38
	Capabilities: [154] Power Budgeting

06:00.0 SATA controller: JMicron Technologies, Inc. JMicron 20360/20363 AHCI Controller (rev 02) (prog-if 01 [AHCI 1.0])
	Subsystem: JMicron Technologies, Inc. JMicron 20360/20363 AHCI Controller
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 17
	Region 5: Memory at fd9fe000 (32-bit, non-prefetchable) [size=8K]
	[virtual] Expansion ROM at fd800000 [disabled] [size=64K]
	Capabilities: [68] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [50] Express Legacy Endpoint IRQ 1
		Device: Supported: MaxPayload 128 bytes, PhantFunc 0, ExtTag-
		Device: Latency L0s <64ns, L1 <1us
		Device: AtnBtn- AtnInd- PwrInd-
		Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
		Device: RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
		Device: MaxPayload 128 bytes, MaxReadReq 512 bytes
		Link: Supported Speed 2.5Gb/s, Width x1, ASPM L0s, Port 1
		Link: Latency L0s <1us, L1 <16us
		Link: ASPM Disabled RCB 64 bytes CommClk+ ExtSynch-
		Link: Speed 2.5Gb/s, Width x1

06:00.1 IDE interface: JMicron Technologies, Inc. JMicron 20360/20363 AHCI Controller (rev 02) (prog-if 85 [Master SecO PriO])
	Subsystem: JMicron Technologies, Inc. JMicron 20360/20363 AHCI Controller
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 18
	Region 0: I/O ports at af00 [size=8]
	Region 1: I/O ports at ae00 [size=4]
	Region 2: I/O ports at ad00 [size=8]
	Region 3: I/O ports at ac00 [size=4]
	Region 4: I/O ports at ab00 [size=16]
	Capabilities: [68] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

07:02.0 FireWire (IEEE 1394): Texas Instruments TSB43AB22/A IEEE-1394a-2000 Controller (PHY/Link) (prog-if 10 [OHCI])
	Subsystem: ABIT Computer Corp. Unknown device 1073
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 68 (500ns min, 1000ns max), Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 17
	Region 0: Memory at fd6ff000 (32-bit, non-prefetchable) [size=2K]
	Region 1: Memory at fd6f8000 (32-bit, non-prefetchable) [size=16K]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME+

07:06.0 Multimedia audio controller: Creative Labs SB Audigy (rev 04)
	Subsystem: Creative Labs Unknown device 1002
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (500ns min, 5000ns max)
	Interrupt: pin A routed to IRQ 23
	Region 0: I/O ports at df00 [size=64]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

07:06.1 Input device controller: Creative Labs SB Audigy Game Port (rev 04)
	Subsystem: Creative Labs Unknown device 0060
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Region 0: I/O ports at de00 [size=8]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

07:06.2 FireWire (IEEE 1394): Creative Labs SB Audigy FireWire Port (rev 04) (prog-if 10 [OHCI])
	Subsystem: Creative Labs SB Audigy FireWire Port
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (500ns min, 1000ns max), Cache Line Size: 64 bytes
	Interrupt: pin B routed to IRQ 20
	Region 0: Memory at fd6fe000 (32-bit, non-prefetchable) [size=2K]
	Region 1: Memory at fd6f4000 (32-bit, non-prefetchable) [size=16K]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME+

8.6)
Attached devices:
Host: scsi2 Channel: 00 Id: 00 Lun: 00
  Vendor: ATA      Model: WDC WD1500ADFD-0 Rev: 20.0
    Type:   Direct-Access                    ANSI  SCSI revision: 05
    Host: scsi3 Channel: 00 Id: 00 Lun: 00
      Vendor: ATA      Model: Maxtor 6B300S0   Rev: BANC
        Type:   Direct-Access                    ANSI  SCSI revision: 05
	Host: scsi8 Channel: 00 Id: 01 Lun: 00
	  Vendor: TSSTcorp Model: CD/DVDW SH-S182D Rev: SB04
	    Type:   CD-ROM                           ANSI  SCSI revision: 05

8.7)
An excerpt from dmesg.
ahci 0000:06:00.0: version 2.3
ACPI: PCI Interrupt 0000:06:00.0[A] -> GSI 17 (level, low) -> IRQ 17
ahci 0000:06:00.0: AHCI 0001.0000 32 slots 2 ports 3 Gbps 0x3 impl SATA mode
ahci 0000:06:00.0: flags: 64bit ncq pm led clo pmp pio slum part
PCI: Setting latency timer of device 0000:06:00.0 to 64
scsi0 : ahci
scsi1 : ahci
ata1: SATA max UDMA/133 cmd 0xffffc20000328100 ctl 0x0000000000000000 bmdma 0x0000000000000000 irq 17
ata2: SATA max UDMA/133 cmd 0xffffc20000328180 ctl 0x0000000000000000 bmdma 0x0000000000000000 irq 17
ata1: SATA link down (SStatus 0 SControl 300)
ata2: SATA link down (SStatus 0 SControl 300)
ata_piix 0000:00:1f.2: version 2.12
ata_piix 0000:00:1f.2: MAP [ P0 P2 P1 P3 ]
ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 19 (level, low) -> IRQ 19
PCI: Setting latency timer of device 0000:00:1f.2 to 64
scsi2 : ata_piix
scsi3 : ata_piix
ata3: SATA max UDMA/133 cmd 0x000000000001fa00 ctl 0x000000000001f902 bmdma 0x000000000001f600 irq 19
ata4: SATA max UDMA/133 cmd 0x000000000001f800 ctl 0x000000000001f702 bmdma 0x000000000001f608 irq 19
ata3.00: ATA-7: WDC WD1500ADFD-00NLR1, 20.07P20, max UDMA/133
ata3.00: 293046768 sectors, multi 16: LBA48 NCQ (depth 0/32)
ata3.00: configured for UDMA/133
ata4.00: ATA-7: Maxtor 6B300S0, BANC1B70, max UDMA/133
ata4.00: 586114704 sectors, multi 16: LBA48 NCQ (depth 0/32)
ata4.00: configured for UDMA/133
scsi 2:0:0:0: Direct-Access     ATA      WDC WD1500ADFD-0 20.0 PQ: 0 ANSI: 5
scsi 3:0:0:0: Direct-Access     ATA      Maxtor 6B300S0   BANC PQ: 0 ANSI: 5
ata_piix 0000:00:1f.5: MAP [ P0 P2 P1 P3 ]
ACPI: PCI Interrupt 0000:00:1f.5[B] -> GSI 19 (level, low) -> IRQ 19
PCI: Setting latency timer of device 0000:00:1f.5 to 64
scsi4 : ata_piix
scsi5 : ata_piix
ata5: SATA max UDMA/133 cmd 0x000000000001f300 ctl 0x000000000001f202 bmdma 0x000000000001ef00 irq 19
ata6: SATA max UDMA/133 cmd 0x000000000001f100 ctl 0x000000000001f002 bmdma 0x000000000001ef08 irq 19
sata_sil24 0000:04:00.0: version 1.0
ACPI: PCI Interrupt 0000:04:00.0[A] -> GSI 19 (level, low) -> IRQ 19
PCI: Setting latency timer of device 0000:04:00.0 to 64
scsi6 : sata_sil24
scsi7 : sata_sil24
ata7: SATA max UDMA/100 cmd 0xffffc20000330000 ctl 0x0000000000000000 bmdma 0x0000000000000000 irq 19
ata8: SATA max UDMA/100 cmd 0xffffc20000332000 ctl 0x0000000000000000 bmdma 0x0000000000000000 irq 19
ata7: SATA link down (SStatus 0 SControl 300)
ata8: SATA link down (SStatus 0 SControl 300)
PCI: Enabling device 0000:06:00.1 (0000 -> 0001)
ACPI: PCI Interrupt 0000:06:00.1[B] -> GSI 18 (level, low) -> IRQ 18
PCI: Setting latency timer of device 0000:06:00.1 to 64
scsi8 : pata_jmicron
scsi9 : pata_jmicron
ata9: PATA max UDMA/100 cmd 0x000000000001af00 ctl 0x000000000001ae02 bmdma 0x000000000001ab00 irq 18
ata10: PATA max UDMA/100 cmd 0x000000000001ad00 ctl 0x000000000001ac02 bmdma 0x000000000001ab08 irq 18
ata9.01: ATAPI: TSSTcorpCD/DVDW SH-S182D, SB04, max UDMA/33
ata9.01: configured for UDMA/33
scsi 8:0:1:0: CD-ROM            TSSTcorp CD/DVDW SH-S182D SB04 PQ: 0 ANSI: 5
.......................

.......................
ata9.01: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata9.01: cmd a0/00:00:00:00:20/00:00:00:00:00/b0 tag 0 cdb 0x0 data 0
         res 00/00:00:00:00:00/00:00:00:00:00/00 Emask 0x2 (HSM violation)
	 ata9: soft resetting port
	 ata9.01: revalidation failed (errno=-2)
	 ata9: failed to recover some devices, retrying in 5 secs
	 ata9: soft resetting port
	 ata9.01: revalidation failed (errno=-2)
	 ata9: failed to recover some devices, retrying in 5 secs
	 ata9: soft resetting port
	 ata9.01: qc timeout (cmd 0xa1)
	 ata9.01: failed to IDENTIFY (I/O error, err_mask=0x4)
	 ata9.01: revalidation failed (errno=-5)
	 ata9.01: disabled
	 ata9: EH pending after completion, repeating EH (cnt=4)
	 ata9: soft resetting port
	 ata9: EH complete

After running cat /dev/cdrom (which points to the dvd drive)
Buffer I/O error on device sr0, logical block 0
Buffer I/O error on device sr0, logical block 1
Buffer I/O error on device sr0, logical block 2
Buffer I/O error on device sr0, logical block 3
Buffer I/O error on device sr0, logical block 0


--cNdxnHkX5QqsyA0e
Content-Type: application/x-gzip
Content-Disposition: attachment; filename="config.gz"
Content-Transfer-Encoding: base64

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

--cNdxnHkX5QqsyA0e--
