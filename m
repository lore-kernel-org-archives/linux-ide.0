From: Kurt Roeckx <kurt@roeckx.be>
Subject: Re: sata_promise: Keeps saying SATA link down (SStatus 0 SControl
	0)
Date: Tue, 15 Jan 2008 01:09:53 +0100
Message-ID: <20080115000953.GA2799@roeckx.be>
References: <20080113234320.GA6225@roeckx.be> <18315.7567.747367.84127@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="/04w6evG8XlLl3ft"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hoefnix.telenet-ops.be ([195.130.132.54]:55079 "EHLO
	hoefnix.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750956AbYAOAKp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 14 Jan 2008 19:10:45 -0500
Received: from agave.telenet-ops.be (agave.telenet-ops.be [195.130.137.77])
	by hoefnix.telenet-ops.be (Postfix) with ESMTP id 1E5A99DD06
	for <linux-ide@vger.kernel.org>; Tue, 15 Jan 2008 01:10:36 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <18315.7567.747367.84127@harpo.it.uu.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: linux-ide@vger.kernel.org


--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 14, 2008 at 09:30:07AM +0100, Mikael Pettersson wrote:
> 
> The chip repeatedly signals plug and unplug events on its second
> ATA port. This is not a common error.
> 
> I need a lot more information to debug this:
> - the output of /sbin/lspci

00:00.0 Host bridge: VIA Technologies, Inc. VT8385 [K8T800 AGP] Host Bridge (rev 01)
00:01.0 PCI bridge: VIA Technologies, Inc. VT8237 PCI bridge [K8T800/K8T890 South]
00:08.0 RAID bus controller: Promise Technology, Inc. PDC20376 (FastTrak 376) (rev 02)
00:0a.0 Ethernet controller: Marvell Technology Group Ltd. 88E8001 Gigabit Ethernet Controller (rev 13)
00:0f.0 RAID bus controller: VIA Technologies, Inc. VIA VT6420 SATA RAID Controller (rev 80)
00:0f.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06)
00:10.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 81)
00:10.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 81)
00:10.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 81)
00:10.3 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 81)
00:10.4 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 86)
00:11.0 ISA bridge: VIA Technologies, Inc. VT8237 ISA bridge [KT600/K8T800/K8T890 South]
00:11.5 Multimedia audio controller: VIA Technologies, Inc. VT8233/A/8235/8237 AC97 Audio Controller (rev 60)
00:11.6 Communication controller: VIA Technologies, Inc. AC'97 Modem Controller
(rev 80)
00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] HyperTransport Technology Configuration
00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Address
Map
00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] DRAM Controller
00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Miscellaneous Control
01:00.0 VGA compatible controller: ATI Technologies Inc RV280 [Radeon 9200 SE] (rev 01)
01:00.1 Display controller: ATI Technologies Inc RV280 [Radeon 9200 SE] (Secondary) (rev 01)

> - for the Promise device only, the output of /sbin/lspci -n -vvxxx

00:08.0 0104: 105a:3376 (rev 02)
        Subsystem: 1043:809e
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (1000ns min, 4500ns max), Cache Line Size: 256 bytes
        Interrupt: pin A routed to IRQ 18
        Region 0: I/O ports at ec00 [size=64]
        Region 1: I/O ports at dc00 [size=16]
        Region 2: I/O ports at cc00 [size=128]
        Region 3: Memory at fdf00000 (32-bit, non-prefetchable) [size=4K]
        Region 4: Memory at fdb00000 (32-bit, non-prefetchable) [size=128K]
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 5a 10 76 33 17 01 30 02 02 00 04 01 40 40 00 00
10: 01 ec 00 00 01 dc 00 00 01 cc 00 00 00 00 f0 fd
20: 00 00 b0 fd 00 00 00 00 00 00 00 00 43 10 9e 80
30: 00 00 00 00 60 00 00 00 00 00 00 00 05 01 04 12
40: 00 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 01 00 22 02 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 ff ff 03 00 00 00 00 00 00 00 00 00


> - a complete kernel boot log from a boot with a vanilla www.kernel.org
>   2.6.24-rc7 kernel

I guess any boot log that shows the problem is good.  I've attached the
one from the first kernel showing the version.

> 
> Since 2.6.22 works for you, it would help if you did a binary search
> to identify when the problem was introduced. Like first try 2.6.23
> (or current stable 2.6.23.n), and then either the 2.6.23-rc kernels
> (if 2.6.23 is broken) or the 2.6.24-rc kernels (if 2.6.23 works).

The patch that broke it for me is the one that enabled the hotplug for
the promise driver:
# bad: [a77720ad0a4049e4bc6355e4febf899966a48222] sata_promise: SATA hotplug support, take 2


Kurt


--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="kern.log"

Linux version 2.6.22 (kurt@intrepid) (gcc version 4.2.3 20071123 (prerelease) (Debian 4.2.2-4)) #2 Tue Jan 15 00:51:17 CET 2008
Command line: root=/dev/sdb3 ro 
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e4000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001ff30000 (usable)
 BIOS-e820: 000000001ff30000 - 000000001ff40000 (ACPI data)
 BIOS-e820: 000000001ff40000 - 000000001fff0000 (ACPI NVS)
 BIOS-e820: 000000001fff0000 - 0000000020000000 (reserved)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
Entering add_active_range(0, 0, 159) 0 entries of 256 used
Entering add_active_range(0, 256, 130864) 1 entries of 256 used
end_pfn_map = 1048576
DMI 2.3 present.
ACPI: RSDP 000FAAC0, 0021 (r2 ACPIAM)
ACPI: XSDT 1FF30100, 003C (r1 A M I  OEMXSDT   1000428 MSFT       97)
ACPI: FACP 1FF30290, 00F4 (r3 A M I  OEMFACP   1000428 MSFT       97)
ACPI: DSDT 1FF303E0, 35C1 (r1  A0043 A0043006        6 MSFT  100000D)
ACPI: FACS 1FF40000, 0040
ACPI: APIC 1FF30390, 004A (r1 A M I  OEMAPIC   1000428 MSFT       97)
ACPI: OEMB 1FF40040, 003F (r1 A M I  OEMBIOS   1000428 MSFT       97)
Entering add_active_range(0, 0, 159) 0 entries of 256 used
Entering add_active_range(0, 256, 130864) 1 entries of 256 used
Zone PFN ranges:
  DMA             0 ->     4096
  DMA32        4096 ->  1048576
  Normal    1048576 ->  1048576
early_node_map[2] active PFN ranges
    0:        0 ->      159
    0:      256 ->   130864
On node 0 totalpages: 130767
  DMA zone: 56 pages used for memmap
  DMA zone: 1200 pages reserved
  DMA zone: 2743 pages, LIFO batch:0
  DMA32 zone: 1733 pages used for memmap
  DMA32 zone: 125035 pages, LIFO batch:31
  Normal zone: 0 pages used for memmap
ACPI: PM-Timer IO Port: 0x808
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 (Bootup-CPU)
ACPI: IOAPIC (id[0x01] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 1, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Setting APIC routing to flat
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 30000000 (gap: 20000000:dff80000)
Built 1 zonelists.  Total pages: 127778
Kernel command line: root=/dev/sdb3 ro 
Initializing CPU#0
PID hash table entries: 2048 (order: 11, 16384 bytes)
Extended CMOS year: 2000
time.c: Detected 2002.649 MHz processor.
Console: colour VGA+ 80x25
Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode-cache hash table entries: 32768 (order: 6, 262144 bytes)
Checking aperture...
CPU 0: aperture @ f8000000 size 64 MB
Memory: 509884k/523456k available (2545k kernel code, 12784k reserved, 1587k data, 180k init)
SLUB: Genslabs=22, HWalign=64, Order=0-1, MinObjects=4, CPUs=1, Nodes=1
Calibrating delay using timer specific routine.. 4009.60 BogoMIPS (lpj=8019216)
Security Framework v1.0.0 initialized
Capability LSM initialized
Mount-cache hash table entries: 256
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 512K (64 bytes/line)
CPU: AMD Athlon(tm) 64 Processor 3000+ stepping 08
ACPI: Core revision 20070126
Using local APIC timer interrupts.
result 12516574
Detected 12.516 MHz APIC timer.
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: Using configuration type 1
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
PCI: enabled onboard AC97/MC97 devices
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 10 *11 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 7 *10 11 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 7 10 11 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 7 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 7 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 7 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 7 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 7 10 11 14 15) *0, disabled.
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
ACPI: bus type pnp registered
pnp: PnP ACPI: found 12 devices
ACPI: ACPI bus type pnp unregistered
SCSI subsystem initialized
libata version 2.21 loaded.
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
PCI: Cannot allocate resource region 0 of device 0000:00:00.0
agpgart: Detected AGP bridge 0
agpgart: AGP aperture is 64M @ 0xf8000000
ACPI: RTC can wake from S4
pnp: 00:09: iomem range 0xfec00000-0xfec00fff has been reserved
pnp: 00:09: iomem range 0xfee00000-0xfee00fff could not be reserved
pnp: 00:09: iomem range 0xfff80000-0xffffffff could not be reserved
pnp: 00:0b: iomem range 0x0-0x9ffff could not be reserved
pnp: 00:0b: iomem range 0xc0000-0xdffff has been reserved
pnp: 00:0b: iomem range 0xe0000-0xfffff could not be reserved
pnp: 00:0b: iomem range 0x100000-0x1ffeffff could not be reserved
PCI: Bridge: 0000:00:01.0
  IO window: a000-afff
  MEM window: fcf00000-fd4fffff
  PREFETCH window: d7f00000-f7efffff
PCI: Setting latency timer of device 0000:00:01.0 to 64
NET: Registered protocol family 2
Time: tsc clocksource has been installed.
IP route cache hash table entries: 4096 (order: 3, 32768 bytes)
TCP established hash table entries: 16384 (order: 6, 262144 bytes)
TCP bind hash table entries: 16384 (order: 5, 131072 bytes)
TCP: Hash tables configured (established 16384 bind 16384)
TCP reno registered
fuse init (API version 7.8)
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
PCI: VIA PCI bridge detected. Disabling DAC.
Boot video device is 0000:01:00.0
ACPI: PCI Interrupt 0000:01:00.0[A] -> GSI 16 (level, low) -> IRQ 16
radeonfb: Found Intel x86 BIOS ROM Image
radeonfb: Retrieved PLL infos from BIOS
radeonfb: Reference=27.00 MHz (RefDiv=12) Memory=200.00 Mhz, System=166.00 MHz
radeonfb: PLL min 20000 max 40000
i2c-adapter i2c-1: unable to read EDID block.
sage repeated 2 times
i2c-adapter i2c-3: unable to read EDID block.
sage repeated 2 times
radeonfb: Monitor 1 type CRT found
radeonfb: EDID probed
radeonfb: Monitor 2 type no found
Console: switching to colour frame buffer device 128x48
radeonfb (0000:01:00.0): ATI Radeon Yd 
input: Power Button (FF) as /class/input/input0
ACPI: Power Button (FF) [PWRF]
input: Power Button (CM) as /class/input/input1
ACPI: Power Button (CM) [PWRB]
input: Sleep Button (CM) as /class/input/input2
ACPI: Sleep Button (CM) [SLPB]
lp: driver loaded but no devices found
Real Time Clock Driver v1.12ac
Non-volatile memory driver v1.2
ppdev: user-space parallel port driver
Linux agpgart interface v0.102 (c) Dave Jones
[drm] Initialized drm 1.1.0 20060810
[drm] Initialized radeon 1.27.0 20060524 on minor 0
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
00:0a: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
parport_pc 00:07: reported by Plug and Play ACPI
parport0: PC-style at 0x378, irq 7 [PCSPP]
lp0: using parport0 (interrupt-driven).
floppy0: no floppy controllers found
loop: module loaded
ACPI: PCI Interrupt 0000:00:0a.0[A] -> GSI 17 (level, low) -> IRQ 17
PCI: Disallowing DAC for device 0000:00:0a.0
skge 1.11 addr 0xfdd00000 irq 17 chip Yukon-Lite rev 7
skge eth0: addr 00:0e:a6:8f:04:8b
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:0f.1
ACPI: PCI Interrupt 0000:00:0f.1[A] -> GSI 20 (level, low) -> IRQ 20
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt8237 (rev 00) IDE UDMA133 controller on pci0000:00:0f.1
    ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xfc08-0xfc0f, BIOS settings: hdc:pio, hdd:pio
Probing IDE interface ide0...
hda: SONY DVD RW DRU-700A, ATAPI CD/DVD-ROM drive
hda: selected mode 0x42
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
Probing IDE interface ide1...
hda: ATAPI 40X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
sata_promise 0000:00:08.0: version 2.09
ACPI: PCI Interrupt 0000:00:08.0[A] -> GSI 18 (level, low) -> IRQ 18
scsi0 : sata_promise
scsi1 : sata_promise
scsi2 : sata_promise
ata1: SATA max UDMA/133 cmd 0xffffc20000036200 ctl 0xffffc20000036238 bmdma 0x0000000000000000 irq 18
ata2: SATA max UDMA/133 cmd 0xffffc20000036280 ctl 0xffffc200000362b8 bmdma 0x0000000000000000 irq 18
ata3: PATA max UDMA/133 cmd 0xffffc20000036300 ctl 0xffffc20000036338 bmdma 0x0000000000000000 irq 18
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.00: ATA-7: WDC WD5000YS-01MPB1, 09.02E09, max UDMA/133
ata1.00: 976773168 sectors, multi 0: LBA48 NCQ (depth 0/32)
ata1.00: configured for UDMA/133
ata2: SATA link down (SStatus 100 SControl 0)
ata2: EH pending after completion, repeating EH (cnt=4)
ata2: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0x3
ata2: (hotplug_status 0x20)
ata2: soft resetting port
ata2: SATA link down (SStatus 100 SControl 0)
ata2: EH pending after completion, repeating EH (cnt=3)
ata2: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0x3
ata2: (hotplug_status 0x20)
ata2: soft resetting port
ata2: SATA link down (SStatus 100 SControl 0)
ata2: EH pending after completion, repeating EH (cnt=2)
ata2: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0x3
ata2: (hotplug_status 0x20)
ata2: soft resetting port
ata2: SATA link down (SStatus 0 SControl 0)
ata2: EH pending after completion, repeating EH (cnt=1)
ata2: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0x3
ata2: (hotplug_status 0x2)
ata2: failed to resume link for reset (errno=-16)
ata2: soft resetting port
ata2: SATA link down (SStatus 101 SControl 0)
ata2: EH pending after 5 tries, giving up
ata2: EH complete
scsi 0:0:0:0: Direct-Access     ATA      WDC WD5000YS-01M 09.0 PQ: 0 ANSI: 5
sd 0:0:0:0: [sda] 976773168 512-byte hardware sectors (500108 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 0:0:0:0: [sda] 976773168 512-byte hardware sectors (500108 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sda: unknown partition table
sd 0:0:0:0: [sda] Attached SCSI disk
sd 0:0:0:0: Attached scsi generic sg0 type 0
sata_via 0000:00:0f.0: version 2.2
ACPI: PCI Interrupt 0000:00:0f.0[B] -> GSI 20 (level, low) -> IRQ 20
sata_via 0000:00:0f.0: routed to hard irq line 10
scsi3 : sata_via
scsi4 : sata_via
ata4: SATA max UDMA/133 cmd 0x000000000001e800 ctl 0x000000000001e402 bmdma 0x000000000001d400 irq 20
ata5: SATA max UDMA/133 cmd 0x000000000001e000 ctl 0x000000000001d802 bmdma 0x000000000001d408 irq 20
ata4: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata2: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0x2 frozen
ata2: (hotplug_status 0x2)
ata4.00: ATA-7: Maxtor 6Y080M0, YAR51EW0, max UDMA/133
ata4.00: 160086528 sectors, multi 16: LBA 
ata4.00: configured for UDMA/133
ata5: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata5.00: ATA-6: ST3200822AS, 3.01, max UDMA/133
ata5.00: 390721968 sectors, multi 16: LBA48 
ata5.00: configured for UDMA/133
scsi 3:0:0:0: Direct-Access     ATA      Maxtor 6Y080M0   YAR5 PQ: 0 ANSI: 5
sd 3:0:0:0: [sdb] 160086528 512-byte hardware sectors (81964 MB)
sd 3:0:0:0: [sdb] Write Protect is off
sd 3:0:0:0: [sdb] Mode Sense: 00 3a 00 00
sd 3:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 3:0:0:0: [sdb] 160086528 512-byte hardware sectors (81964 MB)
sd 3:0:0:0: [sdb] Write Protect is off
sd 3:0:0:0: [sdb] Mode Sense: 00 3a 00 00
sd 3:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sdb: sdb1 sdb2 sdb3 sdb4
sd 3:0:0:0: [sdb] Attached SCSI disk
sd 3:0:0:0: Attached scsi generic sg1 type 0
scsi 4:0:0:0: Direct-Access     ATA      ST3200822AS      3.01 PQ: 0 ANSI: 5
sd 4:0:0:0: [sdc] 390721968 512-byte hardware sectors (200050 MB)
sd 4:0:0:0: [sdc] Write Protect is off
sd 4:0:0:0: [sdc] Mode Sense: 00 3a 00 00
sd 4:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 4:0:0:0: [sdc] 390721968 512-byte hardware sectors (200050 MB)
sd 4:0:0:0: [sdc] Write Protect is off
sd 4:0:0:0: [sdc] Mode Sense: 00 3a 00 00
sd 4:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sdc: unknown partition table
sd 4:0:0:0: [sdc] Attached SCSI disk
sd 4:0:0:0: Attached scsi generic sg2 type 0
PNP: PS/2 Controller [PNP0303:PS2K,PNP0f03:PS2M] at 0x60,0x64 irq 1,12
serio: i8042 KBD port at 0x60,0x64 irq 1
serio: i8042 AUX port at 0x60,0x64 irq 12
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard as /class/input/input3
rtc_cmos 00:02: rtc core: registered rtc_cmos as rtc0
rtc_cmos: probe of 00:02 failed with error -16
i2c /dev entries driver
w83627hf: Found W83697HF chip at 0x290
ata2: soft resetting port
ata2: SATA link down (SStatus 100 SControl 0)
ata2: EH pending after completion, repeating EH (cnt=4)
ata2: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0x3
ata2: (hotplug_status 0x20)
input: ImPS/2 Generic Wheel Mouse as /class/input/input4
device-mapper: ioctl: 4.11.0-ioctl (2006-10-12) initialised: dm-devel@redhat.com
Advanced Linux Sound Architecture Driver Version 1.0.14 (Thu May 31 09:03:25 2007 UTC).
ACPI: PCI Interrupt 0000:00:11.5[C] -> GSI 22 (level, low) -> IRQ 22
PCI: Setting latency timer of device 0000:00:11.5 to 64
codec_read: codec 0 is not valid [0xfe0000]
Jan 15 00:54:25 intrepid last message repeated 3 times
ALSA device list:
  #0: VIA 8237 with AD1980 at 0xc800, irq 22
TCP cubic registered
NET: Registered protocol family 1
NET: Registered protocol family 10
lo: Disabled Privacy Extensions
NET: Registered protocol family 17
powernow-k8: Found 1 AMD Athlon(tm) 64 Processor 3000+ processors (version 2.00.00)
powernow-k8:    0 : fid 0xc (2000 MHz), vid 0x2
powernow-k8:    1 : fid 0xa (1800 MHz), vid 0x6
powernow-k8:    2 : fid 0xa (1800 MHz), vid 0x6
powernow-k8:    3 : fid 0x0 (800 MHz), vid 0xa
powernow-k8: ph2 null fid transition 0xc
drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 180k freed
ata2: soft resetting port
ata2: SATA link down (SStatus 100 SControl 0)
ata2: EH pending after completion, repeating EH (cnt=3)
ata2: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0x3
ata2: (hotplug_status 0x20)
ata2: soft resetting port
ata2: SATA link down (SStatus 100 SControl 0)
ata2: EH pending after completion, repeating EH (cnt=2)
ata2: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0x3
ata2: (hotplug_status 0x20)
ata2: soft resetting port
ata2: SATA link down (SStatus 100 SControl 0)
ata2: EH pending after completion, repeating EH (cnt=1)
ata2: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0x3
ata2: (hotplug_status 0x20)
ata2: soft resetting port
ata2: SATA link down (SStatus 100 SControl 0)
ata2: EH pending after 5 tries, giving up
ata2: EH complete
ata2: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0x2 frozen
ata2: (hotplug_status 0x2)
ata2: soft resetting port
ata2: SATA link down (SStatus 101 SControl 0)
ata2: EH pending after completion, repeating EH (cnt=4)
ata2: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0x3
ata2: (hotplug_status 0x20)
ata2: soft resetting port
ata2: SATA link down (SStatus 100 SControl 0)
ata2: EH pending after completion, repeating EH (cnt=3)
ata2: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0x3
ata2: (hotplug_status 0x20)
EXT3 FS on sdb3, internal journal
ata2: soft resetting port
ata2: SATA link down (SStatus 0 SControl 0)
ata2: EH pending after completion, repeating EH (cnt=2)
ata2: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0x3
ata2: (hotplug_status 0x2)
ata2: soft resetting port
ata2: SATA link down (SStatus 0 SControl 0)
ata2: EH pending after completion, repeating EH (cnt=1)
ata2: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0x3
ata2: (hotplug_status 0x2)
ata2: soft resetting port
ata2: SATA link down (SStatus 0 SControl 0)
ata2: EH pending after 5 tries, giving up
ata2: EH complete
ata2: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0x2 frozen
ata2: (hotplug_status 0x20)
kjournald starting.  Commit interval 5 seconds
EXT3-fs warning: maximal mount count reached, running e2fsck is recommended
EXT3 FS on sdb1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sdb2, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
ata2: soft resetting port
ata2: SATA link down (SStatus 0 SControl 0)
ata2: EH pending after completion, repeating EH (cnt=4)
ata2: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0x3
ata2: (hotplug_status 0x2)
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-0, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sdb4, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
ata2: soft resetting port
ata2: SATA link down (SStatus 0 SControl 0)
ata2: EH pending after completion, repeating EH (cnt=3)
ata2: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0x3
ata2: (hotplug_status 0x2)
skge eth0: enabling interface
ADDRCONF(NETDEV_UP): eth0: link is not ready
ata2: soft resetting port
ata2: SATA link down (SStatus 0 SControl 0)
ata2: EH complete
ata2: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0x2 frozen
ata2: (hotplug_status 0x20)
ata2: soft resetting port
ata2: SATA link down (SStatus 0 SControl 0)
ata2: EH pending after completion, repeating EH (cnt=4)
ata2: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0x3
ata2: (hotplug_status 0x2)
skge eth0: Link is up at 100 Mbps, full duplex, flow control both
ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
ata2: soft resetting port
ata2: SATA link down (SStatus 100 SControl 0)
ata2: EH pending after completion, repeating EH (cnt=3)
ata2: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0x3
ata2: (hotplug_status 0x20)
ata2: soft resetting port
ata2: SATA link down (SStatus 0 SControl 0)
ata2: EH pending after completion, repeating EH (cnt=2)
ata2: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0x3
ata2: (hotplug_status 0x2)
ata2: soft resetting port
ata2: SATA link down (SStatus 0 SControl 0)
ata2: EH complete
ata2: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0x2 frozen
ata2: (hotplug_status 0x20)
ata2: soft resetting port
ata2: SATA link down (SStatus 100 SControl 0)
ata2: EH pending after completion, repeating EH (cnt=4)
ata2: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0x3
ata2: (hotplug_status 0x20)
ata2: soft resetting port
ata2: SATA link down (SStatus 100 SControl 0)
ata2: EH pending after completion, repeating EH (cnt=3)
ata2: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0x3
ata2: (hotplug_status 0x20)
ata2: soft resetting port
ata2: SATA link down (SStatus 0 SControl 0)
ata2: EH pending after completion, repeating EH (cnt=2)
ata2: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0x3
ata2: (hotplug_status 0x2)
ata2: soft resetting port
ata2: SATA link down (SStatus 0 SControl 0)
ata2: EH pending after completion, repeating EH (cnt=1)
ata2: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0x3
ata2: (hotplug_status 0x2)
ata2: soft resetting port
ata2: SATA link down (SStatus 100 SControl 0)
ata2: EH pending after 5 tries, giving up
ata2: EH complete
Marking TSC unstable due to cpufreq changes
Time: acpi_pm clocksource has been installed.
ata2: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0x2 frozen
ata2: (hotplug_status 0x2)
ata2: soft resetting port
ata2: SATA link down (SStatus 100 SControl 0)
ata2: EH pending after completion, repeating EH (cnt=4)
ata2: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0x3
ata2: (hotplug_status 0x20)
ata2: soft resetting port
ata2: SATA link down (SStatus 100 SControl 0)
ata2: EH pending after completion, repeating EH (cnt=3)
ata2: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0x3
ata2: (hotplug_status 0x20)
ata2: soft resetting port
ata2: SATA link down (SStatus 0 SControl 0)
ata2: EH pending after completion, repeating EH (cnt=2)
ata2: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0x3
ata2: (hotplug_status 0x2)
ata2: soft resetting port
ata2: SATA link down (SStatus 100 SControl 0)
ata2: EH pending after completion, repeating EH (cnt=1)
ata2: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0x3
ata2: (hotplug_status 0x20)
ata2: soft resetting port
ata2: SATA link down (SStatus 100 SControl 300)
ata2: EH complete
eth0: no IPv6 routers present
ata2: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0x2 frozen
ata2: (hotplug_status 0x2)
ata2: soft resetting port
ata2: SATA link down (SStatus 0 SControl 0)
ata2: EH pending after completion, repeating EH (cnt=4)
ata2: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0x3
ata2: (hotplug_status 0x2)
ata2: soft resetting port
ata2: SATA link down (SStatus 0 SControl 0)
ata2: EH pending after completion, repeating EH (cnt=3)
ata2: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0x3
ata2: (hotplug_status 0x2)
ata2: soft resetting port
ata2: SATA link down (SStatus 100 SControl 0)
ata2: EH pending after completion, repeating EH (cnt=2)
ata2: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0x3
ata2: (hotplug_status 0x20)
ata2: soft resetting port
ata2: SATA link down (SStatus 100 SControl 0)
ata2: EH pending after completion, repeating EH (cnt=1)
ata2: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0x3
ata2: (hotplug_status 0x20)
ata2: soft resetting port
ata2: SATA link down (SStatus 0 SControl 0)
ata2: EH pending after 5 tries, giving up
ata2: EH complete
ata2: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0x2 frozen
ata2: (hotplug_status 0x20)
ata2: soft resetting port
ata2: SATA link down (SStatus 100 SControl 0)
ata2: EH complete
ata2: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0x2 frozen
ata2: (hotplug_status 0x2)
ata2: soft resetting port
ata2: SATA link down (SStatus 0 SControl 0)
ata2: EH pending after completion, repeating EH (cnt=4)
ata2: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0x3
ata2: (hotplug_status 0x2)
ata2: soft resetting port
ata2: SATA link down (SStatus 0 SControl 0)
ata2: EH pending after completion, repeating EH (cnt=3)
ata2: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0x3
ata2: (hotplug_status 0x2)
ata2: soft resetting port
ata2: SATA link down (SStatus 100 SControl 0)
ata2: EH pending after completion, repeating EH (cnt=2)
ata2: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0x3
ata2: (hotplug_status 0x20)
ata2: soft resetting port
ata2: SATA link down (SStatus 100 SControl 0)
ata2: EH pending after completion, repeating EH (cnt=1)
ata2: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0x3
ata2: (hotplug_status 0x20)
ata2: soft resetting port
ata2: SATA link down (SStatus 0 SControl 0)
ata2: EH pending after 5 tries, giving up
ata2: EH complete
ata2: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0x2 frozen
ata2: (hotplug_status 0x20)
ata2: soft resetting port
ata2: SATA link down (SStatus 100 SControl 0)
ata2: EH complete

--/04w6evG8XlLl3ft--
