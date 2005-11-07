From: Chris Studholme <cvs@cs.utoronto.ca>
Subject: BUG: spinlock recursion on CPU#0, scsi_eh_3/737
Date: Sun, 6 Nov 2005 21:54:28 -0500
Message-ID: <20051107025428.GA2611@cs.utoronto.ca>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EeQfGwPcQSOJBaQU"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cliff.cs.toronto.edu ([128.100.3.120]:40086 "EHLO
	cliff.cs.toronto.edu") by vger.kernel.org with ESMTP
	id S932409AbVKGCya (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 6 Nov 2005 21:54:30 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, jgarzik@pobox.com


--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

I'm having the fillowing problem.


[1.] One line summary of the problem:

BUG: spinlock recursion on CPU#0, scsi_eh_3/737


[2.] Full description of the problem/report:

I just recently purchased my first SATA drive (Seagate) and a Promise TX4
controller for it.  Since then, my nightly backup script BUGs when executing
`tar cfvl - / |gzip`.  My root partition is /dev/md1, where:

     md1 : active raid1 sda1[0] hdc1[1]
	   4819392 blocks [2/2] [UU]

hdc is a PATA Maxtor drive.  When running in the following degraded state:

     md1 : active raid1 hdc1[1]
	   4819392 blocks [2/1] [_U]

the BUG does not happen.  Also, `tar cfvl - /` (without the gzip) does not
seem to cause the BUG.

This machine is an SMP machine with 2 AMD processors.  I've seen the BUG
happen 3 times so far and in all 3 cases, the messages given in section
6 were identical.


[3.] Keywords (i.e., modules, networking, kernel):

sata libide scsi spinlock bug


[4.] Kernel version (from /proc/version):

Linux version 2.6.14 (cvs@stoa) (gcc version 3.3.5 (Debian 1:3.3.5-13))
      #1 SMP Tue Nov 1 19:26:55 EST 2005


[5.] Most recent kernel version which did not have the bug:

no others tested


[6.] Output of Oops.. message (if applicable) with symbolic information
     resolved (see Documentation/oops-tracing.txt)

ATA: abnormal status 0xFF on port 0xF880239C
ata4: status=3D0xff { Busy }
ata4: command timeout
ATA: abnormal status 0xFF on port 0xF880239C
ata4: status=3D0xff { Busy }
BUG: spinlock recursion on CPU#0, scsi_eh_3/737
lock: f782168c, .magic: dead4ead, .owner: scsi_eh_3/737, .owner_cpu: 0
[<c0103ebe>] dump_stack+0x1e/0x20
[<c01fc9af>] spin_bug+0xaf/0xc0
[<c01fcb05>] _raw_spin_lock+0x75/0x90
[<c02ef4e4>] _spin_lock_irqsave+0x14/0x20
[<c0273a6c>] scsi_device_unbusy+0x1c/0x80
[<c026f25f>] scsi_finish_command+0x1f/0xa0
[<c027dfca>] ata_scsi_qc_complete+0x2a/0x50
[<c027bff2>] ata_qc_complete+0x42/0xc0
[<c027f043>] pdc_eng_timeout+0xa3/0x140
[<c027da7b>] ata_scsi_error+0x1b/0x40
[<c0272f10>] scsi_error_handler+0x70/0xb0
[<c0132137>] kthread+0xb7/0xc0
[<c0101225>] kernel_thread_helper+0x5/0x10
BUG: spinlock lockup on CPU#0, scsi_eh_3/737, f782168c
[<c0103ebe>] dump_stack+0x1e/0x20
[<c01fca6e>] __spin_lock_debug+0xae/0xd0
[<c01fcae1>] _raw_spin_lock+0x51/0x90
[<c02ef4e4>] _spin_lock_irqsave+0x14/0x20
[<c0273a6c>] scsi_device_unbusy+0x1c/0x80
[<c026f25f>] scsi_finish_command+0x1f/0xa0
[<c027dfca>] ata_scsi_qc_complete+0x2a/0x50
[<c027bff2>] ata_qc_complete+0x42/0xc0
[<c027f043>] pdc_eng_timeout+0xa3/0x140
[<c027da7b>] ata_scsi_error+0x1b/0x40
[<c0272f10>] scsi_error_handler+0x70/0xb0
[<c0132137>] kthread+0xb7/0xc0
[<c0101225>] kernel_thread_helper+0x5/0x10


[7.] A small shell script or example program which triggers the
     problem (if possible)

causes BUG:
tar cfvl - / 2>/dev/null |gzip >/dev/null

does not cause BUG:=20
tar cfvl - / 2>/dev/null >/dev/null


[8.] Environment
[8.1.] Software (add the output of the ver_linux script here)

Linux stoa 2.6.14 #1 SMP Tue Nov 1 19:26:55 EST 2005 i686 GNU/Linux

Gnu C                  3.3.5
Gnu make               3.80
binutils               2.15
util-linux             2.12p
mount                  2.12p
module-init-tools      3.2-pre1
e2fsprogs              1.37
reiserfsprogs          3.6.19
reiser4progs           line
PPP                    2.4.3
nfs-utils              1.0.6
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 3.2.1
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.2.1
Modules Loaded         loop hw_random nfsd exportfs lockd sunrpc tun
crc32 ipt_REJECT ipt_limit ipt_LOG ipt_pkttype iptable_nat ip_nat
ip_conntrack iptable_filter ip_tables bridge sd_mod w83781d hwmon_vid
eeprom lm90 i2c_isa i2c_amd756 tuner bttv video_buf firmware_class
i2c_algo_bit v4l2_common btcx_risc tveeprom i2c_core videodev ppdev
parport_pc parport ftdi_sio usbserial usb_storage ohci_hcd usbcore
ide_cd cdrom snd_intel8x0 snd_ac97_codec snd_ac97_bus snd_pcm_oss
snd_mixer_oss snd_pcm snd_timer snd soundcore snd_page_alloc e1000
3c59x genrtc


[8.2.] Processor information (from /proc/cpuinfo):

processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 8
model name      : AMD Athlon(tm) MP 1800+
stepping        : 1
cpu MHz         : 1533.589
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
		  mca cmov pat pse36 mmx fxsr sse syscall mp mmxext
		  3dnowext 3dnow
bogomips        : 3071.21

processor       : 1
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 8
model name      : AMD Athlon(tm) MP
stepping        : 1
cpu MHz         : 1533.589
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
		  mca cmovpat pse36 mmx fxsr sse syscall mp mmxext
		  3dnowext 3dnow
bogomips        : 3067.07


[8.3.] Module information (from /proc/modules):

loop 55628 16 - Live 0xf881f000
hw_random 4628 1 - Live 0xf8a11000
nfsd 94280 1 - Live 0xf8a6b000
exportfs 5184 1 nfsd, Live 0xf8a08000
lockd 62344 2 nfsd, Live 0xf8a1c000
sunrpc 133948 2 nfsd,lockd, Live 0xf8a2d000
tun 8960 2 - Live 0xf89fa000
crc32 3904 1 tun, Live 0xf8986000
ipt_REJECT 4544 2 - Live 0xf89ff000
ipt_limit 2112 2 - Live 0xf89f8000
ipt_LOG 6208 5 - Live 0xf89cd000
ipt_pkttype 1536 2 - Live 0xf8988000
iptable_nat 6596 1 - Live 0xf898a000
ip_nat 16148 1 iptable_nat, Live 0xf89c0000
ip_conntrack 42908 2 iptable_nat,ip_nat, Live 0xf89dd000
iptable_filter 2432 1 - Live 0xf895f000
ip_tables 19840 6 ipt_REJECT,ipt_limit,ipt_LOG,ipt_pkttype,iptable_nat,
	  iptable_filter, Live 0xf896e000
bridge 48084 0 - Live 0xf89d0000
sd_mod 13184 5 - Live 0xf897f000
w83781d 32932 0 - Live 0xf89b6000
hwmon_vid 2048 1 w83781d, Live 0xf8967000
eeprom 5776 0 - Live 0xf896b000
lm90 10724 0 - Live 0xf8949000
i2c_isa 3712 1 w83781d, Live 0xf895d000
i2c_amd756 5700 0 - Live 0xf895a000
tuner 38248 0 - Live 0xf8974000
bttv 162064 0 - Live 0xf898d000
video_buf 17796 1 bttv, Live 0xf8961000
firmware_class 8192 1 bttv, Live 0xf894d000
i2c_algo_bit 8840 1 bttv, Live 0xf8956000
v4l2_common 4800 1 bttv, Live 0xf88ec000
btcx_risc 3912 1 bttv, Live 0xf8804000
tveeprom 12176 1 bttv, Live 0xf883c000
i2c_core 18304 9 w83781d,eeprom,lm90,i2c_isa,i2c_amd756,tuner,bttv,
	 i2c_algo_bit,tveeprom, Live 0xf8950000
videodev 7488 1 bttv, Live 0xf88e9000
ppdev 7940 2 - Live 0xf8846000
parport_pc 22660 1 - Live 0xf890b000
parport 21184 2 ppdev,parport_pc, Live 0xf8913000
ftdi_sio 29064 1 - Live 0xf88fa000
usbserial 25696 3 ftdi_sio, Live 0xf8903000
usb_storage 63872 0 - Live 0xf8938000
ohci_hcd 19012 0 - Live 0xf88e3000
usbcore 110144 5 ftdi_sio,usbserial,usb_storage,ohci_hcd, Live 0xf891c000
ide_cd 38468 0 - Live 0xf88ef000
cdrom 37472 1 ide_cd, Live 0xf88cf000
snd_intel8x0 30176 0 - Live 0xf88da000
snd_ac97_codec 92796 1 snd_intel8x0, Live 0xf88a1000
snd_ac97_bus 1984 1 snd_ac97_codec, Live 0xf8806000
snd_pcm_oss 47328 0 - Live 0xf8872000
snd_mixer_oss 16960 1 snd_pcm_oss, Live 0xf8840000
snd_pcm 81668 3 snd_intel8x0,snd_ac97_codec,snd_pcm_oss, Live 0xf88ba000
snd_timer 21572 1 snd_pcm, Live 0xf8818000
snd 47588 6 snd_intel8x0,snd_ac97_codec,snd_pcm_oss,snd_mixer_oss,
    snd_pcm,snd_timer, Live 0xf8849000
soundcore 7584 1 snd, Live 0xf8815000
snd_page_alloc 8648 2 snd_intel8x0,snd_pcm, Live 0xf8811000
e1000 101620 0 - Live 0xf8858000
3c59x 39080 0 - Live 0xf882e000
genrtc 8328 0 - Live 0xf880d000


[8.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)

0000-001f : dma1
0020-0021 : pic1
0040-0043 : timer0
0050-0053 : timer1
0060-006f : keyboard
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
0290-0297 : w83781d-isa
0376-0376 : ide1
0378-037a : parport0
03b0-03bb : mda
03bf-03bf : mda
03f6-03f6 : ide0
03f8-03ff : serial
0cf8-0cff : PCI conf1
5000-5003 : PM1a_EVT_BLK
5004-5005 : PM1a_CNT_BLK
5008-500b : PM_TMR
5020-5023 : GPE0_BLK
50e0-50ef : amd756-smbus
9000-afff : PCI Bus #02
  9000-907f : 0000:02:04.0
    9000-907f : 0000:02:04.0
  9400-943f : 0000:02:07.0
  9800-9807 : 0000:02:08.0
    9800-9807 : ide2
  9c00-9c03 : 0000:02:08.0
    9c02-9c02 : ide2
  a000-a007 : 0000:02:08.0
    a000-a007 : ide3
  a400-a403 : 0000:02:08.0
    a402-a402 : ide3
  a800-a80f : 0000:02:08.0
    a800-a807 : ide2
    a808-a80f : ide3
b000-b0ff : 0000:00:07.5
  b000-b0ff : AMD AMD768
b400-b43f : 0000:00:07.5
  b400-b43f : AMD AMD768
c000-c03f : 0000:00:08.0
  c000-c03f : e1000
c400-c47f : 0000:00:09.0
  c400-c47f : sata_promise
c800-c8ff : 0000:00:09.0
  c800-c8ff : sata_promise
cc00-cc03 : 0000:00:00.0
f000-f00f : 0000:00:07.1
  f000-f007 : ide0
  f008-f00f : ide1

00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000cc000-000ce7ff : Adapter ROM
000cf000-000d3fff : Adapter ROM
000f0000-000fffff : System ROM
00100000-3ffeffff : System RAM
  00100000-002f0c6e : Kernel code
  002f0c6f-003863f3 : Kernel data
3fff0000-3fff2fff : ACPI Non-volatile Storage
3fff3000-3fffffff : ACPI Tables
50000000-5001ffff : 0000:00:08.0
50020000-50027fff : 0000:00:09.0
e8000000-efffffff : 0000:00:00.0
f1000000-f2ffffff : PCI Bus #02
  f2000000-f201ffff : 0000:02:07.0
  f2020000-f2023fff : 0000:02:08.0
  f2024000-f2024fff : 0000:02:07.0
  f2025000-f202507f : 0000:02:04.0
  f2026000-f2026fff : 0000:02:00.0
    f2026000-f2026fff : ohci_hcd
f3000000-f30fffff : PCI Bus #02
  f3000000-f3000fff : 0000:02:05.0
    f3000000-f3000fff : bttv0
  f3001000-f3001fff : 0000:02:05.1
  f3010000-f301ffff : 0000:02:07.0
  f3020000-f303ffff : 0000:02:04.0
f3100000-f311ffff : 0000:00:09.0
  f3100000-f311ffff : sata_promise
f3120000-f313ffff : 0000:00:08.0
  f3120000-f313ffff : e1000
f3140000-f315ffff : 0000:00:08.0
  f3140000-f315ffff : e1000
f3160000-f3160fff : 0000:00:09.0
  f3160000-f3160fff : sata_promise
f3161000-f3161fff : 0000:00:00.0
fec00000-ffffffff : reserved


[8.5.] PCI information ('lspci -vvv' as root)

0000:00:00.0 Host bridge: Advanced Micro Devices [AMD] AMD-760 MP [IGD4-2P]=
 System Controller (rev 11)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort+ >SERR- <PERR-
	Latency: 32
	Region 0: Memory at e8000000 (32-bit, prefetchable) [size=3D128M]
	Region 1: Memory at f3161000 (32-bit, prefetchable) [size=3D4K]
	Region 2: I/O ports at cc00 [disabled] [size=3D4]
	Capabilities: <available only to root>

0000:00:01.0 PCI bridge: Advanced Micro Devices [AMD] AMD-760 MP [IGD4-2P] =
AGP Bridge (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR+ FastB2B-
	Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 32
	Bus: primary=3D00, secondary=3D01, subordinate=3D01, sec-latency=3D32
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: fff00000-000fffff
	Prefetchable memory behind bridge: fff00000-000fffff
	BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-

0000:00:07.0 ISA bridge: Advanced Micro Devices [AMD] AMD-768 [Opus] ISA (r=
ev 05)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 0

0000:00:07.1 IDE interface: Advanced Micro Devices [AMD] AMD-768 [Opus] IDE=
 (rev 04) (prog-if 8a [Master SecP PriP])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 32
	Region 4: I/O ports at f000 [size=3D16]

0000:00:07.3 Bridge: Advanced Micro Devices [AMD] AMD-768 [Opus] ACPI (rev =
03)
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-

0000:00:07.5 Multimedia audio controller: Advanced Micro Devices [AMD] AMD-=
768 [Opus] Audio (rev 03)
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 32
	Interrupt: pin B routed to IRQ 10
	Region 0: I/O ports at b000 [size=3D256]
	Region 1: I/O ports at b400 [size=3D64]

0000:00:08.0 Ethernet controller: Intel Corp. 82540EM Gigabit Ethernet Cont=
roller (rev 02)
	Subsystem: Intel Corp. PRO/1000 MT Desktop Adapter
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 32 (63750ns min), Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin A routed to IRQ 12
	Region 0: Memory at f3140000 (32-bit, non-prefetchable) [size=3D128K]
	Region 1: Memory at f3120000 (32-bit, non-prefetchable) [size=3D128K]
	Region 2: I/O ports at c000 [size=3D64]
	Expansion ROM at 50000000 [disabled] [size=3D128K]
	Capabilities: <available only to root>

0000:00:09.0 Unknown mass storage controller: Promise Technology, Inc.: Unk=
nown device 3d17 (rev 02)
	Subsystem: Promise Technology, Inc.: Unknown device 3d17
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 72 (1000ns min, 4500ns max), Cache Line Size: 0x01 (4 bytes)
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at c400 [size=3D128]
	Region 2: I/O ports at c800 [size=3D256]
	Region 3: Memory at f3160000 (32-bit, non-prefetchable) [size=3D4K]
	Region 4: Memory at f3100000 (32-bit, non-prefetchable) [size=3D128K]
	Expansion ROM at 50020000 [disabled] [size=3D32K]
	Capabilities: <available only to root>

0000:00:10.0 PCI bridge: Advanced Micro Devices [AMD] AMD-768 [Opus] PCI (r=
ev 05) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR+ FastB2B-
	Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort+ >SERR- <PERR-
	Latency: 32
	Bus: primary=3D00, secondary=3D02, subordinate=3D02, sec-latency=3D32
	I/O behind bridge: 00009000-0000afff
	Memory behind bridge: f1000000-f2ffffff
	Prefetchable memory behind bridge: f3000000-f30fffff
	BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-

0000:02:00.0 USB Controller: Advanced Micro Devices [AMD] AMD-768 [Opus] US=
B (rev 07) (prog-if 10 [OHCI])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR+
	Latency: 32 (20000ns max), Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin D routed to IRQ 5
	Region 0: Memory at f2026000 (32-bit, non-prefetchable) [size=3D4K]

0000:02:04.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclon=
e] (rev 24)
	Subsystem: 3Com Corporation 3C905B Fast Etherlink XL 10/100
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 32 (2500ns min, 2500ns max), Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin A routed to IRQ 12
	Region 0: I/O ports at 9000 [size=3D128]
	Region 1: Memory at f2025000 (32-bit, non-prefetchable) [size=3D128]
	Expansion ROM at f3020000 [disabled] [size=3D128K]
	Capabilities: <available only to root>

0000:02:05.0 Multimedia video controller: Brooktree Corporation Bt878 Video=
 Capture (rev 11)
	Subsystem: LeadTek Research Inc. WinFast TV 2000
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 32 (4000ns min, 10000ns max)
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at f3000000 (32-bit, prefetchable) [size=3D4K]
	Capabilities: <available only to root>

0000:02:05.1 Multimedia controller: Brooktree Corporation Bt878 Audio Captu=
re (rev 11)
	Subsystem: LeadTek Research Inc.: Unknown device 6606
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 32 (1000ns min, 63750ns max)
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at f3001000 (32-bit, prefetchable) [size=3D4K]
	Capabilities: <available only to root>

0000:02:07.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] =
(rev 0d)
	Subsystem: Intel Corp. EtherExpress PRO/100 Server Adapter
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 32 (2000ns min, 14000ns max), Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin A routed to IRQ 12
	Region 0: Memory at f2024000 (32-bit, non-prefetchable) [size=3D4K]
	Region 1: I/O ports at 9400 [size=3D64]
	Region 2: Memory at f2000000 (32-bit, non-prefetchable) [size=3D128K]
	Expansion ROM at f3010000 [disabled] [size=3D64K]
	Capabilities: <available only to root>

0000:02:08.0 RAID bus controller: Promise Technology, Inc. PDC20276 (MBFast=
Trak133 Lite) (rev 01) (prog-if 85)
	Subsystem: Giga-byte Technology MBUltra 133
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=3Dslow >TAbort- <TAbort- =
<MAbort- >SERR- <PERR-
	Latency: 32 (1000ns min, 4500ns max), Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at 9800 [size=3D8]
	Region 1: I/O ports at 9c00 [size=3D4]
	Region 2: I/O ports at a000 [size=3D8]
	Region 3: I/O ports at a400 [size=3D4]
	Region 4: I/O ports at a800 [size=3D16]
	Region 5: Memory at f2020000 (32-bit, non-prefetchable) [size=3D16K]
	Capabilities: <available only to root>


[8.6.] SCSI information (from /proc/scsi/scsi)

$ lsscsi -lv
[3:0:0:0]    disk    ATA      ST3250823AS      3.03  /dev/sda
  state=3Drunning queue_depth=3D1 scsi_level=3D6 type=3D0 device_blocked=3D=
0 timeout=3D30
  dir: /sys/devices/pci0000:00/0000:00:09.0/host3/target3:0:0/3:0:0:0


[8.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):

boot messages:
libata version 1.12 loaded.
sata_promise version 1.02
ata1: SATA max UDMA/133 cmd 0xF8802200 ctl 0xF8802238 bmdma 0x0 irq 10
ata2: SATA max UDMA/133 cmd 0xF8802280 ctl 0xF88022B8 bmdma 0x0 irq 10
ata3: SATA max UDMA/133 cmd 0xF8802300 ctl 0xF8802338 bmdma 0x0 irq 10
ata4: SATA max UDMA/133 cmd 0xF8802380 ctl 0xF88023B8 bmdma 0x0 irq 10
ata1: no device found (phy stat 00000000)
scsi0 : sata_promise
ata2: no device found (phy stat 00000000)
scsi1 : sata_promise
ata3: no device found (phy stat 00000000)
scsi2 : sata_promise
ata4: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4023 85:3469 86:3c01 87:4023 88:=
407f
ata4: dev 0 ATA, max UDMA/133, 488397168 sectors: lba48
ata4: dev 0 configured for UDMA/133
scsi3 : sata_promise
  Vendor: ATA       Model: ST3250823AS       Rev: 3.03
  Type:   Direct-Access                      ANSI SCSI revision: 05

Kernel hacking:
    [ ] Show timing information on printks   =20
    [*] Kernel debugging                     =20
    [*]   Magic SysRq key                    =20
    (15)  Kernel log buffer size (16 =3D> 64KB, 17 =3D> 128KB)
    [*]   Detect Soft Lockups                 =20
    [ ]   Collect scheduler statistics        =20
    [*]   Debug memory allocations            =20
    [*]   Spinlock debugging                   =20
    [*]   Sleep-inside-spinlock checking       =20
    [ ]   kobject debugging                    =20
    [ ]   Highmem debugging                    =20
    [ ]   Compile the kernel with debug info   =20
    [ ]   Debug Filesystem                     =20
    [*]   Compile the kernel with frame pointers
    [*]   Check for stack overflows       =20
    [ ]   Kprobes                         =20
    [ ]   Stack utilization instrumentation
    [ ]   Page alloc debugging
    [ ]   Use 4Kb for kernel stacks instead of 8Kb

sata controller: Promise SATA300 TX4 4-Port Serial ATA Adapter Support NCQ/=
TCQ
motherboard: Gigabyte GA-7DPXDW+


[X.] Other notes, patches, fixes, workarounds:

Let me know if more info is needed.

Thanks.
Chris.

--EeQfGwPcQSOJBaQU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDbsHkwTYpZrwvqLQRArG+AKDRUURCTm3rW7ITknryIODaLlKb/gCghmbD
QxjZQL8MInoWn5NrOCo2lDw=
=rNXv
-----END PGP SIGNATURE-----

--EeQfGwPcQSOJBaQU--
