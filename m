From: Nate Riffe <inkblot@movealong.org>
Subject: sata_inic162x card init trouble
Date: Mon, 12 Mar 2007 18:06:56 -0400
Message-ID: <20070312220656.GA5457@movealong.org>
References: <20070310205636.GA14704@movealong.org> <45F4F483.9080302@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from dorothy.movealong.org ([69.56.173.86]:3478 "EHLO
	dorothy.movealong.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932798AbXCLW3M (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 12 Mar 2007 18:29:12 -0400
Content-Disposition: inline
In-Reply-To: <45F4F483.9080302@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, kernel@vger.kernel.org, Jeff Garzik <jeff@garzik.org>

I have built and booted a 2.6.21-rc3 kernel with the sata_inic162x
driver compiled as a module.  The machine has a SIIG-branded SATA-II
150 card in it with two drives attached, a matching pair of 320GB
Seagates currently containing no data.  I am aware of the driver's
"highly experimental" status and willing to test.  The operating
system is installed on a third drive on a PATA connection (no issues
there).

On boot, the sata_inic162x module loads but the card does not appear
to be properly initialized and the drives are not seen by the system.
It looks like resource allocation is failing for this card during PCI
bus initialization, but I'm not exactly sure how to read most of this
information.  Adding "pci=routeirq" per suggestion in the dmesg output
does not help.

Here is the complete output of "dmesg" immediately after boot:

Linux version 2.6.21-rc3 (inkblot@oz) (gcc version 4.1.2 20061115 (prerelease) (Debian 4.1.1-21)) #1 SMP Sun Mar 11 04:28:51 EDT 2007
BIOS-provided physical RAM map:
sanitize start
sanitize end
copy_e820_map() start: 0000000000000000 size: 000000000009e800 end: 000000000009e800 type: 1
copy_e820_map() type is E820_RAM
copy_e820_map() start: 000000000009e800 size: 0000000000001800 end: 00000000000a0000 type: 2
copy_e820_map() start: 00000000000e7000 size: 0000000000019000 end: 0000000000100000 type: 2
copy_e820_map() start: 0000000000100000 size: 000000001fefdc00 end: 000000001fffdc00 type: 1
copy_e820_map() type is E820_RAM
copy_e820_map() start: 000000001fffdc00 size: 0000000000002000 end: 000000001ffffc00 type: 3
copy_e820_map() start: 000000001ffffc00 size: 0000000000000400 end: 0000000020000000 type: 4
copy_e820_map() start: 00000000fffe7000 size: 0000000000019000 end: 0000000100000000 type: 2
 BIOS-e820: 0000000000000000 - 000000000009e800 (usable)
 BIOS-e820: 000000000009e800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e7000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fffdc00 (usable)
 BIOS-e820: 000000001fffdc00 - 000000001ffffc00 (ACPI data)
 BIOS-e820: 000000001ffffc00 - 0000000020000000 (ACPI NVS)
 BIOS-e820: 00000000fffe7000 - 0000000100000000 (reserved)
0MB HIGHMEM available.
511MB LOWMEM available.
Entering add_active_range(0, 0, 131069) 0 entries of 256 used
Zone PFN ranges:
  DMA             0 ->     4096
  Normal       4096 ->   131069
  HighMem    131069 ->   131069
early_node_map[1] active PFN ranges
    0:        0 ->   131069
On node 0 totalpages: 131069
  DMA zone: 32 pages used for memmap
  DMA zone: 0 pages reserved
  DMA zone: 4064 pages, LIFO batch:0
  Normal zone: 991 pages used for memmap
  Normal zone: 125982 pages, LIFO batch:31
  HighMem zone: 0 pages used for memmap
DMI 2.1 present.
ACPI: RSDP 000F6B00, 0014 (r0 PTLTD )
ACPI: RSDT 1FFFDD5D, 0028 (r1 PTLTD    RSDT          0 PTL   1000000)
ACPI: FACP 1FFFFB8C, 0074 (r1 INTEL  SEATTLE2 19990830 PTL     F4240)
ACPI: DSDT 1FFFDD85, 1E07 (r1  Intel  S2440BX        0 MSFT  1000004)
ACPI: FACS 1FFFFFC0, 0040
ACPI: PM-Timer IO Port: 0x8008
Allocating PCI resources starting at 30000000 (gap: 20000000:dffe7000)
Built 1 zonelists.  Total pages: 130046
Kernel command line: root=/dev/hda1 ro 
Local APIC disabled by BIOS -- you can enable it with "lapic"
mapped APIC to ffffd000 (0140a000)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
PID hash table entries: 2048 (order: 11, 8192 bytes)
Detected 548.762 MHz processor.
Console: colour VGA+ 80x25
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 514244k/524276k available (1547k kernel code, 9480k reserved, 588k data, 200k init, 0k highmem)
virtual kernel memory layout:
    fixmap  : 0xfff4f000 - 0xfffff000   ( 704 kB)
    pkmap   : 0xff800000 - 0xffc00000   (4096 kB)
    vmalloc : 0xe0800000 - 0xff7fe000   ( 495 MB)
    lowmem  : 0xc0000000 - 0xdfffd000   ( 511 MB)
      .init : 0xc031d000 - 0xc034f000   ( 200 kB)
      .data : 0xc0282c7d - 0xc0316014   ( 588 kB)
      .text : 0xc0100000 - 0xc0282c7d   (1547 kB)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 1098.43 BogoMIPS (lpj=2196869)
Security Framework v1.0.0 initialized
SELinux:  Disabled at boot.
Capability LSM initialized
Mount-cache hash table entries: 512
CPU: After generic identify, caps: 0387f9ff 00000000 00000000 00000000 00000000 00000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
CPU serial number disabled.
CPU: After all inits, caps: 0383f9ff 00000000 00000000 00000040 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Compat vDSO mapped to ffffe000.
Checking 'hlt' instruction... OK.
SMP alternatives: switching to UP code
Freeing SMP alternatives: 11k freed
ACPI: Core revision 20070126
ACPI: setting ELCR to 0200 (from 0e20)
CPU0: Intel Pentium III (Katmai) stepping 03
SMP motherboard not detected.
Local APIC not detected. Using dummy APIC emulation.
Brought up 1 CPUs
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xfd9b4, last bus=1
PCI: Using configuration type 1
Setting up standard PCI resources
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
0000:00:07.1: cannot adjust BAR0 (not I/O)
0000:00:07.1: cannot adjust BAR1 (not I/O)
0000:00:07.1: cannot adjust BAR2 (not I/O)
0000:00:07.1: cannot adjust BAR3 (not I/O)
* Found PM-Timer Bug on the chipset. Due to workarounds for a bug,
* this clock source is slow. Consider trying other clock sources
PCI quirk: region 8000-803f claimed by PIIX4 ACPI
PCI quirk: region 7000-700f claimed by PIIX4 SMB
PCI: Firmware left 0000:00:0d.0 e100 interrupts enabled, disabling
Boot video device is 0000:01:00.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 9 10 *11 12)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 7 9 *10 11 12)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 7 9 10 11 12)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 7 *9 10 11 12)
ACPI: Power Resource [PFAN] (on)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 12 devices
PnPBIOS: Disabled by ACPI PNP
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
pnp: 00:01: ioport range 0x7000-0x700f has been reserved
pnp: 00:01: ioport range 0x8000-0x803f has been reserved
pnp: 00:01: iomem range 0xfff80000-0xffffffff could not be reserved
Time: tsc clocksource has been installed.
PCI: Bridge: 0000:00:01.0
  IO window: 9000-9fff
  MEM window: f4200000-f5ffffff
  PREFETCH window: 30000000-300fffff
NET: Registered protocol family 2
IP route cache hash table entries: 4096 (order: 2, 16384 bytes)
TCP established hash table entries: 16384 (order: 5, 196608 bytes)
TCP bind hash table entries: 16384 (order: 5, 131072 bytes)
TCP: Hash tables configured (established 16384 bind 16384)
TCP reno registered
checking if image is initramfs... it is
Freeing initrd memory: 2323k freed
audit: initializing netlink socket (disabled)
audit(1173735395.036:1): initialized
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
Limiting direct PCI/PCI transfers.
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
00:07: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
00:08: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
PNP: PS/2 Controller [PNP0303:KBC,PNP0f13:MICE] at 0x60,0x64 irq 1,12
serio: i8042 KBD port at 0x60,0x64 irq 1
serio: i8042 AUX port at 0x60,0x64 irq 12
mice: PS/2 mouse device common for all mice
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
Using IPI Shortcut mode
Freeing unused kernel memory: 200k freed
input: AT Translated Set 2 keyboard as /class/input/input0
ACPI: Fan [FAN1] (on)
ACPI: CPU0 (power states: C1[C1] C2[C2])
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller at PCI slot 0000:00:07.1
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1c60-0x1c67, BIOS settings: hda:DMA, hdb:pio
Probing IDE interface ide0...
e100: Intel(R) PRO/100 Network Driver, 3.5.17-k2-NAPI
e100: Copyright(c) 1999-2006 Intel Corporation
SCSI subsystem initialized
libata version 2.20 loaded.
hda: DIAMOND 0000000, ATA DISK drive
Time: pit clocksource has been installed.
hdb: CREATIVE CD5230E, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
PCI: setting IRQ 11 as level-triggered
ACPI: PCI Interrupt 0000:00:0d.0[A] -> Link [LNKA] -> GSI 11 (level, low) -> IRQ 11
e100: eth0: e100_probe: addr 0xf4010000, irq 11, MAC addr 00:90:27:BD:38:EF
sata_inic162x 0000:00:0e.0: version 0.1
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 10
PCI: setting IRQ 10 as level-triggered
ACPI: PCI Interrupt 0000:00:0e.0[A] -> Link [LNKB] -> GSI 10 (level, low) -> IRQ 10
PCI: Unable to reserve I/O region #1:100@2400 for device 0000:00:0e.0
ACPI: PCI interrupt for device 0000:00:0e.0 disabled
sata_inic162x: probe of 0000:00:0e.0 failed with error -16
hda: max request size: 512KiB
hda: 240121728 sectors (122942 MB) w/2048KiB Cache, CHS=16383/255/63, UDMA(33)
hda: cache flushes supported
 hda: hda1 hda2 < hda5 >
hdb: ATAPI 52X CD-ROM drive, 128kB Cache, DMA
Uniform CD-ROM driver Revision: 3.20
md: raid1 personality registered for level 1
raid5: automatically using best checksumming function: pIII_sse
   pIII_sse  :  1098.000 MB/sec
raid5: using function: pIII_sse (1098.000 MB/sec)
raid6: int32x1    113 MB/s
raid6: int32x2    110 MB/s
raid6: int32x4    130 MB/s
raid6: int32x8    130 MB/s
raid6: mmxx1      297 MB/s
raid6: mmxx2      345 MB/s
raid6: sse1x1     255 MB/s
raid6: sse1x2     338 MB/s
raid6: using algorithm sse1x2 (338 MB/s)
md: raid6 personality registered for level 6
md: raid5 personality registered for level 5
md: raid4 personality registered for level 4
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
Linux agpgart interface v0.102 (c) Dave Jones
agpgart: Detected an Intel 440BX Chipset.
agpgart: AGP aperture is 64M @ 0xf8000000
input: PC Speaker as /class/input/input1
Real Time Clock Driver v1.12ac
piix4_smbus 0000:00:07.3: Found 0000:00:07.3 device
Adding 1510068k swap on /dev/hda5.  Priority:-1 extents:1 across:1510068k
EXT3 FS on hda1, internal journal
loop: loaded (max 8 devices)
device-mapper: ioctl: 4.11.0-ioctl (2006-10-12) initialised: dm-devel@redhat.com
e100: eth0: e100_watchdog: link up, 100Mbps, full-duplex
NET: Registered protocol family 10
lo: Disabled Privacy Extensions
input: Power Button (FF) as /class/input/input2
ACPI: Power Button (FF) [PWRF]
eth0: no IPv6 routers present

Complete output of "lspci -nnvvv":

00:00.0 Host bridge [0600]: Intel Corporation 440BX/ZX/DX - 82443BX/ZX/DX Host bridge [8086:7190] (rev 03)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 64
	Region 0: Memory at f8000000 (32-bit, prefetchable) [size=64M]
	Capabilities: <access denied>

00:01.0 PCI bridge [0604]: Intel Corporation 440BX/ZX/DX - 82443BX/ZX/DX AGP bridge [8086:7191] (rev 03) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 128
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
	I/O behind bridge: 00009000-00009fff
	Memory behind bridge: f4200000-f5ffffff
	Prefetchable memory behind bridge: 30000000-300fffff
	Secondary status: 66MHz+ FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B+

00:07.0 ISA bridge [0601]: Intel Corporation 82371AB/EB/MB PIIX4 ISA [8086:7110] (rev 02)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:07.1 IDE interface [0101]: Intel Corporation 82371AB/EB/MB PIIX4 IDE [8086:7111] (rev 01) (prog-if 80 [Master])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Region 0: [virtual] Memory at 000001f0 (32-bit, non-prefetchable) [disabled] [size=8]
	Region 1: [virtual] Memory at 000003f0 (type 3, non-prefetchable) [disabled] [size=1]
	Region 2: [virtual] Memory at 00000170 (32-bit, non-prefetchable) [disabled] [size=8]
	Region 3: [virtual] Memory at 00000370 (type 3, non-prefetchable) [disabled] [size=1]
	Region 4: I/O ports at 1c60 [size=16]

00:07.2 USB Controller [0c03]: Intel Corporation 82371AB/EB/MB PIIX4 USB [8086:7112] (rev 01) (prog-if 00 [UHCI])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Interrupt: pin D routed to IRQ 9
	Region 4: I/O ports at 1c40 [size=32]

00:07.3 Bridge [0680]: Intel Corporation 82371AB/EB/MB PIIX4 ACPI [8086:7113] (rev 02)
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin ? routed to IRQ 9

00:0c.0 Multimedia audio controller [0401]: Yamaha Corporation YMF-740C [DS-1L Audio Controller] [1073:000c] (rev 03)
	Subsystem: Intel Corporation Unknown device [8086:5332]
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (1250ns min, 6250ns max)
	Interrupt: pin A routed to IRQ 5
	Region 0: Memory at f4000000 (32-bit, non-prefetchable) [size=32K]
	Capabilities: <access denied>

00:0d.0 Ethernet controller [0200]: Intel Corporation 82557/8/9 [Ethernet Pro 100] [8086:1229] (rev 08)
	Subsystem: Intel Corporation EtherExpress PRO/100+ Management Adapter [8086:000c]
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 66 (2000ns min, 14000ns max), Cache Line Size: 32 bytes
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at f4010000 (32-bit, non-prefetchable) [size=4K]
	Region 1: I/O ports at 1c00 [size=64]
	Region 2: Memory at f4100000 (32-bit, non-prefetchable) [size=1M]
	[virtual] Expansion ROM at 30100000 [disabled] [size=1M]
	Capabilities: <access denied>

00:0e.0 SATA controller [0106]: Initio Corporation INI-1623 PCI SATA-II Controller [1101:1622] (rev 02) (prog-if 00 [Vendor specific])
	Subsystem: Initio Corporation INI-1623 PCI SATA-II Controller [1101:1622]
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at 2400 [size=256]
	Region 1: I/O ports at 2000 [size=256]
	Region 2: I/O ports at 1800 [size=256]
	Region 3: I/O ports at 1400 [size=256]
	Region 4: I/O ports at 1000 [size=256]
	Region 5: Memory at f4011000 (32-bit, non-prefetchable) [size=4K]
	[virtual] Expansion ROM at 30200000 [disabled] [size=256K]
	Capabilities: <access denied>

00:0f.0 Network controller [0280]: RaLink RT2561/RT61 802.11g PCI [1814:0301]
	Subsystem: RaLink Unknown device [1814:2561]
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64, Cache Line Size: 32 bytes
	Interrupt: pin A routed to IRQ 5
	Region 0: Memory at f4008000 (32-bit, non-prefetchable) [size=32K]
	Capabilities: <access denied>

01:00.0 VGA compatible controller [0300]: ATI Technologies Inc 3D Rage Pro AGP 1X/2X [1002:4742] (rev 5c) (prog-if 00 [VGA])
	Subsystem: ATI Technologies Inc Rage Pro Turbo AGP 2X [1002:0084]
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 66 (2000ns min), Cache Line Size: 32 bytes
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at f5000000 (32-bit, non-prefetchable) [size=16M]
	Region 1: I/O ports at 9000 [size=256]
	Region 2: Memory at f4200000 (32-bit, non-prefetchable) [size=4K]
	[virtual] Expansion ROM at 30000000 [disabled] [size=128K]
	Capabilities: <access denied>

Contents of /proc/ioports:

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
0170-0177 : 0000:00:07.1
01f0-01f7 : 0000:00:07.1
  01f0-01f7 : ide0
02f8-02ff : serial
0376-0376 : 0000:00:07.1
03c0-03df : vga+
03f6-03f6 : 0000:00:07.1
  03f6-03f6 : ide0
03f8-03ff : serial
0cf8-0cff : PCI conf1
1000-10ff : 0000:00:0e.0
1400-14ff : 0000:00:0e.0
1800-18ff : 0000:00:0e.0
1c00-1c3f : 0000:00:0d.0
  1c00-1c3f : e100
1c40-1c5f : 0000:00:07.2
1c60-1c6f : 0000:00:07.1
  1c60-1c67 : ide0
2000-20ff : 0000:00:0e.0
2400-24ff : 0000:00:0e.0
7000-700f : 0000:00:07.3
  7000-700f : pnp 00:01
    7000-7007 : piix4_smbus
8000-803f : 0000:00:07.3
  8000-803f : pnp 00:01
    8000-8003 : ACPI PM1a_EVT_BLK
    8004-8005 : ACPI PM1a_CNT_BLK
    8008-800b : ACPI PM_TMR
    800c-800f : ACPI GPE0_BLK
    8010-8015 : ACPI CPU throttle
9000-9fff : PCI Bus #01
  9000-90ff : 0000:01:00.0

And contents of /proc/iomem:

00000000-0009e7ff : System RAM
  00000000-00000000 : Crash kernel
0009e800-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000c8000-000c8fff : Adapter ROM
000c9000-000d0fff : Adapter ROM
000e4000-000effff : Adapter ROM
000f0000-000fffff : System ROM
00100000-1fffdbff : System RAM
  00100000-00282c7c : Kernel code
  00282c7d-00316013 : Kernel data
1fffdc00-1ffffbff : ACPI Tables
1ffffc00-1fffffff : ACPI Non-volatile Storage
30000000-300fffff : PCI Bus #01
  30000000-3001ffff : 0000:01:00.0
30100000-301fffff : 0000:00:0d.0
30200000-3023ffff : 0000:00:0e.0
f4000000-f4007fff : 0000:00:0c.0
f4008000-f400ffff : 0000:00:0f.0
f4010000-f4010fff : 0000:00:0d.0
  f4010000-f4010fff : e100
f4011000-f4011fff : 0000:00:0e.0
f4100000-f41fffff : 0000:00:0d.0
  f4100000-f41fffff : e100
f4200000-f5ffffff : PCI Bus #01
  f4200000-f4200fff : 0000:01:00.0
  f5000000-f5ffffff : 0000:01:00.0
f8000000-fbffffff : 0000:00:00.0
fffe7000-ffffffff : reserved

-- 
--< ((\))< >----< inkblot@movealong.org >----< http://www.movealong.org/ >--
pub  1024D/05A058E0 2002-03-07 Nate Riffe (06-Mar-2002) <inkblot@movealong.org>
     Key fingerprint = 0DAC F5CB D182 3165 D757  C466 CD42 12A8 05A0 58E0
