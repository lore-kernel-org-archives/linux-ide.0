From: Steven Schlansker <stevenschlansker@gmail.com>
Subject: siimage card causes repeated oopses and panics on a PowerMac G4 running 2.6.12.1
Date: Mon, 27 Jun 2005 02:20:25 -0700
Message-ID: <9c1484f205062702203936d7ca@mail.gmail.com>
Reply-To: Steven Schlansker <stevenschlansker@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.202]:41259 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261968AbVF0JU1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 27 Jun 2005 05:20:27 -0400
Received: by wproxy.gmail.com with SMTP id 67so301535wri
        for <linux-ide@vger.kernel.org>; Mon, 27 Jun 2005 02:20:25 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

I have a SIIG Ultra-ATA 133/100 Pro for Mac card in my Sawtooth G4
that, upon being touched in any way (loading the siimage module,
trying to access the corresponding /dev/hd? entries, and just about
anything else) causes either an oops, a flood of oopses, or a panic.

I have probably isolated it to this driver (siimage.ko), as when built
as a module and not loaded the kernel has no issues at all.

I am running:
Linux 42 2.6.12.1-steven-2 #3 Sat Jun 25 11:23:45 PDT 2005 ppc GNU/Linux

ver_linux reports:
Gnu C                  3.3.5
Gnu make               3.80
binutils               2.15
util-linux             2.12p
mount                  2.12p
module-init-tools      3.1
e2fsprogs              1.35
jfsutils               1.1.6
reiserfsprogs          3.6.19
reiser4progs           1.0.3
xfsprogs               2.6.20
PPP                    2.4.2
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 3.2.4
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.2.1
udev                   050
Modules Loaded         ipv6

CPU:
cpu             : 7455, altivec supported
clock           : 900MHz
revision        : 0.1 (pvr 8001 0201)
bogomips        : 894.97
machine         : PowerMac3,1
motherboard     : PowerMac3,1 MacRISC2 MacRISC Power Macintosh
detected as     : 65 (PowerMac G4 AGP Graphics)
pmac flags      : 00000004
L2 cache        : 256K unified
memory          : 768MB
pmac-generation : NewWorld

The offending card is reported as:
0001:11:03.0 IDE interface: Silicon Image, Inc. (formerly CMD Technology Inc) PC
I0680 Ultra ATA-133 Host Controller (rev 02) (prog-if 85 [Master SecO PriO])
        Subsystem: Silicon Image, Inc. (formerly CMD Technology Inc) PCI0680 Ult
ra ATA-133 Host Controller
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Step
ping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort
- <MAbort- >SERR- <PERR-
        Latency: 16, Cache Line Size: 0x01 (4 bytes)
        Interrupt: pin A routed to IRQ 53
        Region 0: I/O ports at 1040 [size=8]
        Region 1: I/O ports at 1030 [size=4]
        Region 2: I/O ports at 1020 [size=8]
        Region 3: I/O ports at 1010 [size=4]
        Region 4: I/O ports at 1000 [size=16]
        Region 5: Memory at 80080000 (32-bit, non-prefetchable) [size=256]
        Expansion ROM at 80100000 [disabled] [size=512K]
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot
-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=2 PME-


When I try to insmod/modprobe the siimage driver, it causes an
immediate segmentation fault.  The following appears in dmesg:

SiI680: IDE controller at PCI slot 0001:11:03.0
SiI680: chipset revision 2
SiI680: BASE CLOCK == 133
SiI680: 100% native mode on irq 53
    ide2: MMIO-DMA , BIOS settings: hde:pio, hdf:pio
    ide3: MMIO-DMA , BIOS settings: hdg:pio, hdh:pio
Probing IDE interface ide2...
hde: WDC WD2000BB-22DAA0, ATA DISK drive
ide2 at 0xf1052080-0xf1052087,0xf105208a on irq 53
hde: max request size: 64KiB
hde: 390721968 sectors (200049 MB) w/2048KiB Cache, CHS=24321/255/63, UDMA(100)
hde: cache flushes supported
 hde:Oops: kernel access of bad area, sig: 11 [#1]
PREEMPT 
NIP: C05C94B8 LR: C05C9A58 SP: E3D73890 REGS: e3d737e0 TRAP: 0300    Not tainted
MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
DAR: 00000000, DSISR: 42000000
TASK = e438ae50[5644] 'insmod' THREAD: e3d72000
Last syscall: 128 
GPR00: 00000050 E3D73890 E438AE50 C0615648 C112DAE8 00000000 C06155B8 00000000 
GPR08: 00000000 F8000000 00000001 E01622C0 24002282 10019600 100C0000 100A0000 
GPR16: 00000000 100F1648 10030000 10030000 10030000 00000000 C06155B8 C0615648 
GPR24: F1052000 C112DAE8 00000000 00000000 00000000 00000000 00000000 F1052000 
NIP [c05c94b8] pmac_ide_build_dmatable+0x38/0x20c
LR [c05c9a58] pmac_ide_dma_setup+0x44/0xe8
Call trace:
 [c05c9a58] pmac_ide_dma_setup+0x44/0xe8
 [c02be54c] __ide_do_rw_disk+0x300/0x524
 [c02b1794] start_request+0x170/0x244
 [c02b1af4] ide_do_request+0x260/0x40c
 [c0294214] __generic_unplug_device+0x68/0x6c
 [c0294248] generic_unplug_device+0x30/0x70
 [c02942c0] blk_backing_dev_unplug+0x38/0x3c
 [c006e51c] block_sync_page+0x74/0x84
 [c003f8c4] sync_page+0x74/0x84
 [c03f2a60] __wait_on_bit_lock+0xbc/0xd4
 [c00401e8] __lock_page+0x50/0x60
 [c004225c] read_cache_page+0x1ec/0x310
 [c00a8738] read_dev_sector+0x34/0x100
 [c00a910c] msdos_partition+0x54/0x400
 [c00a812c] check_partition+0xd4/0x160
Oops: kernel access of bad area, sig: 11 [#2]
PREEMPT 
NIP: 0FF60DAC LR: C0016180 SP: D1E91D90 REGS: d1e91ce0 TRAP: 0400    Not tainted
MSR: 40001032 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = e438a2f0[5697] 'udev' THREAD: d1e90000
Last syscall: 6 
GPR00: 0FF60DAC D1E91D90 E438A2F0 E3D73A48 00000003 00000000 D1E91DF8 D1E91DF8 
GPR08: 00000475 E3D73A54 00000000 D1E90000 2438A4B0 10027344 100C0000 7FE12E14 
GPR16: 00000002 7FE12F2E 10011311 10000000 300269E8 E3B07100 E60A6540 289DA387 
GPR24: C05D0000 00000003 00000000 D1E91DF8 00000001 0FF57DF4 C0687F70 0FF636B4 
NIP [0ff60dac] 0xff60dac
LR [c0016180] __wake_up_common+0x54/0x9c
Call trace:
 [c0016214] __wake_up+0x4c/0x84
 [c0034390] __wake_up_bit+0x38/0x48
 [c004010c] unlock_page+0x44/0x58
 [c0052f9c] do_wp_page+0x854/0x9d0
 [c0054f04] handle_mm_fault+0x204/0x230
 [c000fec8] do_page_fault+0x150/0x3a8
 [c0004b58] handle_page_fault+0xc/0x80
note: udev[5697] exited with preempt_count 3


If I do so much as touch the new /dev/hde entry or such, many more
oopses and occassionally a panic will happen.  I can provide more
samples if necessary, I figured two would be enough to get started. 
The process is always different, and sometimes it even seems to be
unrelated to the card entirely.  Usually it's modprobe and udev.  I
have not successfully captured one of the panics with netconsole yet,
but I remember the line "Aieeee, killing interrupt handler" from them.
 I do not believe that the hardware is defective, as the exact same
card works very well under Mac OS X (which even boots from a drive
connected to it, so OpenFirmware does not seem to have issues with it
either)

I am really quite desperate, because the internal IDE interfaces do
not work well with my drives > 137GB and this was quite an expensive
card.  I would appreciate any help with debugging this, and am quite
willing to do any necessary testing/digging to get it working. 
Hopefully this is a quick fix, but my instinct tells me that it is
not...

I have not subscribed to this linux-ide list, as I do not want to
receive possibly hundreds of emails unrelated to this and have very
little chance of being able to help out with other people's issues. 
I'm not a veteran kernel hacker (yet!)  Therefore, if you could please
CC me in any replies I would greatly appreciate it.  If my Reply-To
headers somehow get mangled by the list, my email address is
stevenschlansker _atsign_ gmail.com.  Thank you for any possible
fixes!
