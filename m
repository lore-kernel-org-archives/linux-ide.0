From: Bram Verweij <bram.verweij@wanadoo.nl>
Subject: PATCH: ALI15x3, 200GB HD, dma broken, no_lba48_dma
Date: Fri, 4 Mar 2005 23:52:06 +0100 (CET)
Message-ID: <Pine.LNX.4.60.0503042332240.1782@thelonious.dnsalias.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-1779126693-1109976726=:1782"
Received: from smtp05.wanadoo.nl ([194.134.35.145]:24879 "EHLO
	smtp05.wanadoo.nl") by vger.kernel.org with ESMTP id S263317AbVCDWwc
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 4 Mar 2005 17:52:32 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, B.Zolnierkiewicz@elka.pw.edu.pl

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1779126693-1109976726=:1782
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed

1. Problem: ALI15x3, 200GB HD, dma broken, no_lba48_dma
===========

2. Full description:
====================

When booting the 2.6.11 kernel on my Asus P5A I experience dma timeout
expiries.  From the dmesg output below, one can see that it does not
have any problems with a 120GB Maxtor hard disk (hda). When it tries to
read hdb, however, four DMA timeout expiries occur. hdb is a 200GB
Maxtor hard disk, from which the first 137 GB are partitioned.

After the dma timeouts, the system proceeds booting.  DMA, however is
turned off completely on hdb.

The problem seems to be that ide-disk.c tries to use pio mode for
blocks > 137 GB (which is good), and lba48 + dma for blocks <= 137GB
(which is known to be a problem, i.e., this is why the no_lba48_dma 
field was introduced in the first place). Attached is a small patch
that makes ide-disk.c use pio mode for blocks > 137 GB, and lba dma
(instead of lba48 dma) for blocks <= 137 GB.

3. Keywords: dma timeout expiry, ALI15x3, 200GB hard disk, lba48 dma.
============

4. Kernel version: Linux version 2.6.11 (root@thelonious) (gcc version 3.3.4) #1 Wed Mar 2 21:24:58 CET 2005

7.1 Software:
=============

If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux thelonious 2.6.11 #1 Wed Mar 2 21:24:58 CET 2005 i586 unknown unknown GNU/Linux

Gnu C                  3.3.4
Gnu make               3.80
binutils               2.15.90.0.3
util-linux             2.12a
mount                  2.12a
module-init-tools      3.0
e2fsprogs              1.35
jfsutils               1.1.6
reiserfsprogs          3.6.17
reiser4progs           line
xfsprogs               2.6.13
quota-tools            3.12.
PPP                    2.4.2
nfs-utils              1.0.6
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Linux C++ Library      5.0.6
Procps                 3.2.1
Net-tools              1.60
Kbd                    1.12
Sh-utils               5.2.1
udev                   026
Modules Loaded         ppp_deflate zlib_deflate zlib_inflate bsd_comp r128 drm ppp_synctty ipv6 ppp_generic slhc ipt_REJECT ipt_state iptable_filter 3c59x mii nls_iso8859_1 nls_cp437 vfat fat w83781d i2c_sensor i2c_isa i2c_core ip_nat_snmp_basic ip_nat_irc ip_nat_ftp iptable_nat ip_conntrack_irc ip_conntrack_ftp ipt_conntrack ip_conntrack ip_tables ohci_hcd agpgart lp parport_pc parport ext3 jbd

7.2 /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 5
model           : 8
model name      : AMD-K6(tm) 3D processor
stepping        : 12
cpu MHz         : 501.101
cache size      : 64 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr mce cx8 pge mmx pni syscall 3dnow k6_mtrr
bogomips        : 993.28

7.3 /proc/modules
=================

ppp_deflate 4864 0 - Live 0xd6a1d000
zlib_deflate 22040 1 ppp_deflate, Live 0xd7293000
zlib_inflate 17024 1 ppp_deflate, Live 0xd728d000
bsd_comp 5632 0 - Live 0xd6a14000
r128 41600 1 - Live 0xd6a31000
drm 57876 2 r128, Live 0xd6a21000
ppp_synctty 8064 1 - Live 0xd69e8000
ipv6 231040 12 - Live 0xd6a52000
ppp_generic 24468 7 ppp_deflate,bsd_comp,ppp_synctty, Live 0xd6a07000
slhc 6400 1 ppp_generic, Live 0xd69ed000
ipt_REJECT 5376 1 - Live 0xd69f0000
ipt_state 1792 3 - Live 0xd69eb000
iptable_filter 2432 1 - Live 0xd69c4000
3c59x 38440 0 - Live 0xd69f3000
mii 3968 1 3c59x, Live 0xd69c2000
nls_iso8859_1 3968 1 - Live 0xd69c0000
nls_cp437 5632 1 - Live 0xd698c000
vfat 12032 1 - Live 0xd69e1000
fat 34844 1 vfat, Live 0xd69cd000
w83781d 31016 0 - Live 0xd69d8000
i2c_sensor 2944 1 w83781d, Live 0xd6984000
i2c_isa 1920 0 - Live 0xd6982000
i2c_core 18960 3 w83781d,i2c_sensor,i2c_isa, Live 0xd69c7000
ip_nat_snmp_basic 12292 0 - Live 0xd6987000
ip_nat_irc 1920 0 - Live 0xd484f000
ip_nat_ftp 2560 0 - Live 0xd484d000
iptable_nat 20316 3 ip_nat_irc,ip_nat_ftp, Live 0xd4879000
ip_conntrack_irc 70672 1 ip_nat_irc, Live 0xd69ad000
ip_conntrack_ftp 71440 1 ip_nat_ftp, Live 0xd699a000
ipt_conntrack 2176 0 - Live 0xd4835000
ip_conntrack 38680 8 ipt_state,ip_nat_snmp_basic,ip_nat_irc,ip_nat_ftp,iptable_nat,ip_conntrack_irc,ip_conntrack_ftp,ipt_conntrack, Live 0xd698f000
ip_tables 19712 5 ipt_REJECT,ipt_state,iptable_filter,iptable_nat,ipt_conntrack, Live 0xd4873000
ohci_hcd 18952 0 - Live 0xd4847000
agpgart 27176 1 drm, Live 0xd483f000
lp 9672 0 - Live 0xd4812000
parport_pc 23492 1 - Live 0xd4817000
parport 31688 2 lp,parport_pc, Live 0xd482c000
ext3 127368 6 - Live 0xd4852000
jbd 51096 1 ext3, Live 0xd481e000

7.4 /proc/ioports
=================
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
0170-0177 : ide1
01f0-01f7 : ide0
0294-0297 : pnp 00:01
0376-0376 : ide1
0378-037a : parport0
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial
040b-040b : pnp 00:01
0480-049f : pnp 00:01
04d6-04d6 : pnp 00:01
0cf8-0cff : PCI conf1
5c20-5c3f : 0000:00:03.0
a000-a00f : 0000:00:0f.0
   a000-a007 : ide0
   a008-a00f : ide1
a400-a43f : 0000:00:0d.0
   a400-a43f : 0000:00:0d.0
a800-a87f : 0000:00:0b.0
b000-b01f : 0000:00:0b.0
b400-b43f : 0000:00:0a.0
b800-b87f : 0000:00:09.0
   b800-b87f : 0000:00:09.0
d000-dfff : PCI Bus #01
   d800-d8ff : 0000:01:00.0
e800-e81f : motherboard
   e800-e81f : pnp 00:01
ec00-ec3f : motherboard
   ec00-ec03 : PM1a_EVT_BLK
   ec04-ec05 : PM1a_CNT_BLK
   ec08-ec0b : PM_TMR
   ec18-ec1b : GPE0_BLK
   ec1c-ec1f : GPE1_BLK
   ec30-ec30 : PM2_CNT_BLK

/proc/iomem
===========

00000000-0009ffff : System RAM
000a0000-000bffff : Video RAM area
000c0000-000cffff : Video ROM
000d0000-000d07ff : Adapter ROM
000f0000-000fffff : System ROM
00100000-13ffbfff : System RAM
   00100000-00305cec : Kernel code
   00305ced-003d03ff : Kernel data
13ffc000-13ffefff : ACPI Tables
13fff000-13ffffff : ACPI Non-volatile Storage
da800000-da80007f : 0000:00:09.0
db000000-db000fff : 0000:00:02.0
   db000000-db000fff : ohci_hcd
db800000-dbffffff : PCI Bus #01
   db800000-db803fff : 0000:01:00.0
     db800000-db803fff : aty128fb MMIO
dc000000-dfffffff : 0000:00:00.0
e3f00000-e7ffffff : PCI Bus #01
   e4000000-e7ffffff : 0000:01:00.0
     e4000000-e7ffffff : aty128fb FB
ffff0000-ffffffff : reserved

7.5 lspci -vvv
==============

00:00.0 Host bridge: ALi Corporation M1541 (rev 04)
         Subsystem: ALi Corporation ALI M1541 Aladdin V/V+ AGP System Controller
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
         Latency: 64
         Region 0: Memory at dc000000 (32-bit, non-prefetchable) [size=64M]
         Capabilities: [b0] AGP version 1.0
                 Status: RQ=29 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW- AGP3- Rate=x1,x2
                 Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=<none>

00:01.0 PCI bridge: ALi Corporation M1541 PCI to AGP Controller (rev 04) (prog-if 00 [Normal decode])
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 64
         Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
         I/O behind bridge: 0000d000-0000dfff
         Memory behind bridge: db800000-dbffffff
         Prefetchable memory behind bridge: e3f00000-e7ffffff
         BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-

00:02.0 USB Controller: ALi Corporation USB 1.1 Controller (rev 03) (prog-if 10 [OHCI])
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 64 (20000ns max)
         Interrupt: pin A routed to IRQ 12
         Region 0: Memory at db000000 (32-bit, non-prefetchable) [size=4K]

00:03.0 Bridge: ALi Corporation M7101 Power Management Controller [PMU]
         Subsystem: ALi Corporation M7101 Power Management Controller [PMU]
         Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:07.0 ISA bridge: ALi Corporation M1533 PCI to ISA Bridge [Aladdin IV] (rev c3)
         Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort+ <MAbort+ >SERR- <PERR-
         Latency: 0

00:09.0 Ethernet controller: 3Com Corporation 3c905C-TX/TX-M [Tornado] (rev 74)
         Subsystem: 3Com Corporation 3C905C-TX Fast Etherlink for PC Management NIC
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 32 (2500ns min, 2500ns max), cache line size 08
         Interrupt: pin A routed to IRQ 5
         Region 0: I/O ports at b800 [size=128]
         Region 1: Memory at da800000 (32-bit, non-prefetchable) [size=128]
         Expansion ROM at <unassigned> [disabled] [size=128K]
         Capabilities: [dc] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=0 DScale=2 PME-

00:0a.0 Multimedia audio controller: Ensoniq ES1371 [AudioPCI-97] (rev 08)
         Subsystem: Ensoniq Creative Sound Blaster AudioPCI64V, AudioPCI128
         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 32 (3000ns min, 32000ns max)
         Interrupt: pin A routed to IRQ 10
         Region 0: I/O ports at b400 [size=64]
         Capabilities: [dc] Power Management version 1
                 Flags: PMEClk- DSI+ D1- D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0b.0 Multimedia audio controller: VIA Technologies Inc. VT1720/24 [Envy24PT/HT] PCI Multi-Channel Audio Controller (rev 01)
         Subsystem: VIA Technologies Inc.: Unknown device 3630
         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 32
         Interrupt: pin A routed to IRQ 9
         Region 0: I/O ports at b000 [size=32]
         Region 1: I/O ports at a800 [size=128]
         Capabilities: [80] Power Management version 1
                 Flags: PMEClk- DSI- D1- D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0d.0 Ethernet controller: 3Com Corporation 3c900 10Mbps Combo [Boomerang]
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 32 (750ns min, 2000ns max)
         Interrupt: pin A routed to IRQ 5
         Region 0: I/O ports at a400 [size=64]
         Expansion ROM at <unassigned> [disabled] [size=64K]

00:0f.0 IDE interface: ALi Corporation M5229 IDE (rev c1) (prog-if 8a [Master SecP PriP])
         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 32 (500ns min, 1000ns max)
         Interrupt: pin A routed to IRQ 0
         Region 4: I/O ports at a000 [size=16]

01:00.0 VGA compatible controller: ATI Technologies Inc Rage 128 PF/PRO AGP 4x TMDS (prog-if 00 [VGA])
         Subsystem: Connect Components Ltd: Unknown device 5046
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
         Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 64 (2000ns min), cache line size 08
         Interrupt: pin A routed to IRQ 11
         Region 0: Memory at e4000000 (32-bit, prefetchable) [size=64M]
         Region 1: I/O ports at d800 [size=256]
         Region 2: Memory at db800000 (32-bit, non-prefetchable) [size=16K]
         Expansion ROM at e3fe0000 [disabled] [size=128K]
         Capabilities: [50] AGP version 2.0
                 Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW- AGP3- Rate=x1,x2,x4
                 Command: RQ=1 ArqSz=0 Cal=0 SBA+ AGP- GART64- 64bit- FW- Rate=<none>
         Capabilities: [5c] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

7.6 /proc/scsi/scsi
===================
Attached devices:

7.7 /proc/ide/ali
=================

                                 Ali M15x3 Chipset.
                                 ------------------
PCI Clock: 33.
CD_ROM FIFO:No , CD_ROM DMA:Yes
FIFO Status: contains 0 Words, runs.

-------------------primary channel-------------------secondary channel---------

channel status:       Off                               Off
both channels togth:  Yes                               Yes
Channel state:        OK                                OK
Add. Setup Timing:    8T                                8T
Command Act. Count:   8T                                8T
Command Rec. Count:   16T                               16T

----------------drive0-----------drive1------------drive0-----------drive1------

DMA enabled:      Yes              No                Yes              Yes
FIFO threshold:    8 Words          8 Words           4 Words          4 Words
FIFO mode:        FIFO On          FIFO On           FIFO Off         FIFO Off
Dt RW act. Cnt     3T               3T                3T               3T
Dt RW rec. Cnt     1T               1T                1T               1T

-----------------------------------UDMA Timings--------------------------------

UDMA:             OK               OK                No               No
UDMA timings:     2.5T             2.5T              2.5T             2.5T


dmesg output:
=============

Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ALI15X3: IDE controller at PCI slot 0000:00:0f.0
ACPI: PCI interrupt 0000:00:0f.0[A]: no GSI - using IRQ 0
ALI15X3: chipset revision 193
ALI15X3: not 100% native mode: will probe irqs later
     ide0: BM-DMA at 0xa000-0xa007, BIOS settings: hda:DMA, hdb:DMA
     ide1: BM-DMA at 0xa008-0xa00f, BIOS settings: hdc:pio, hdd:pio
Probing IDE interface ide0...
hda: Maxtor 6Y120L0, ATA DISK drive
hdb: Maxtor 6Y200P0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: PLEXTOR DVDR PX-708A, ATAPI CD/DVD-ROM drive
hdd: PLEXTOR CD-R PX-W2410A, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 240121728 sectors (122942 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(33)
hda: cache flushes supported
  hda: hda1 hda2 hda3 < hda5 hda6 hda7 >
hdb: max request size: 128KiB
hdb: cannot use LBA48 DMA - PIO mode will be used for accessing sectors > 268435456
hdb: 398297088 sectors (203928 MB) w/7936KiB Cache, CHS=24792/255/63, UDMA(33)
hdb: cache flushes supported
  hdb:<4>hdb: dma_timer_expiry: dma status == 0x61
hdb: DMA timeout error
hdb: dma timeout error: status=0x58 { DriveReady SeekComplete DataRequest }

ide: failed opcode was: unknown
spurious 8259A interrupt: IRQ7.
  hdb1 hdb2 <<4>hdb: dma_timer_expiry: dma status == 0x61
hdb: DMA timeout error
hdb: dma timeout error: status=0x58 { DriveReady SeekComplete DataRequest }

ide: failed opcode was: unknown
  hdb5<4>hdb: dma_timer_expiry: dma status == 0x61
hdb: DMA timeout error
hdb: dma timeout error: status=0x58 { DriveReady SeekComplete DataRequest }

ide: failed opcode was: unknown
  hdb6<4>hdb: dma_timer_expiry: dma status == 0x61
hdb: DMA timeout error
hdb: dma timeout error: status=0x58 { DriveReady SeekComplete DataRequest }

ide: failed opcode was: unknown
  hdb7 hdb8 >
hdc: ATAPI 40X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache, (U)DMA
Uniform CD-ROM driver Revision: 3.20
hdd: ATAPI 40X CD-ROM CD-R/RW drive, 4096kB Cache, (U)DMA


X. Notes:
=========

- I also experienced this problem with the 2.4.9 kernel;
- It seems that a similar problem has been reported to
alt.os.linux.mandrake by a certain Shibu on November 25, 2004:
   http://groups.google.nl/groups?q=ali15x3+dma+timeout+2.6&hl=nl&lr=&selm=Tulpd.185095%24Np3.7506842%40ursa-nb00s0.nbnet.nb.ca&rnum=1
- Carefull reading of ide-disk.c reveals a potential cause: while the
   no_lba48_dma check makes sure we use pio mode for the blocks > 137
   GB, it still lets us use lba48 + dma for all blocks <= 137 GB, which
   does not work on the ALI 1543c.
- Indeed, after applying the attached patch, (i) the DMA timeouts at
   boot time disappear, (ii) the blocks above 137 GB are accessible,
   (iii) DMA works properly again for blocks below 137 GB.
--8323328-1779126693-1109976726=:1782
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="2.6.11-dodgydisk-no_lba48_dma.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.60.0503042352060.1782@thelonious.dnsalias.com>
Content-Description: 
Content-Disposition: attachment; filename="2.6.11-dodgydisk-no_lba48_dma.patch"

ZGlmZiAtTmF1ciBsaW51eC0yLjYuMTEvZHJpdmVycy9pZGUvaWRlLWRpc2su
YyBsaW51eC0yLjYuMTEtYWxpbTE1eDMvZHJpdmVycy9pZGUvaWRlLWRpc2su
Yw0KLS0tIGxpbnV4LTIuNi4xMS9kcml2ZXJzL2lkZS9pZGUtZGlzay5jCTIw
MDUtMDMtMDIgMDg6Mzg6MDcuMDAwMDAwMDAwICswMTAwDQorKysgbGludXgt
Mi42LjExLWFsaW0xNXgzL2RyaXZlcnMvaWRlL2lkZS1kaXNrLmMJMjAwNS0w
My0wNCAxMToxNDoxNC4wMDAwMDAwMDAgKzAxMDANCkBAIC0xMzgsNiArMTM4
LDggQEANCiAJaWYgKCFkbWEpIHsNCiAJCWlkZV9pbml0X3NnX2NtZChkcml2
ZSwgcnEpOw0KIAkJaWRlX21hcF9zZyhkcml2ZSwgcnEpOw0KKwl9IGVsc2Ug
aWYgKGxiYTQ4ICYmIGh3aWYtPm5vX2xiYTQ4X2RtYSkgew0KKwkJbGJhNDgg
PSAwOw0KIAl9DQogDQogCWlmIChJREVfQ09OVFJPTF9SRUcpDQpAQCAtMTQ2
LDcgKzE0OCw3IEBADQogCS8qIEZJWE1FOiBTRUxFQ1RfTUFTSyhkcml2ZSwg
MCkgPyAqLw0KIA0KIAlpZiAoZHJpdmUtPnNlbGVjdC5iLmxiYSkgew0KLQkJ
aWYgKGRyaXZlLT5hZGRyZXNzaW5nID09IDEpIHsNCisJCWlmIChsYmE0OCkg
ew0KIAkJCXRhc2tfaW9yZWdfdCB0YXNrbGV0c1sxMF07DQogDQogCQkJcHJf
ZGVidWcoIiVzOiBMQkE9MHglMDEybGx4XG4iLCBkcml2ZS0+bmFtZSwgYmxv
Y2spOw0K

--8323328-1779126693-1109976726=:1782--
