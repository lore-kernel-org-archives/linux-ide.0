From: Andrew Henry <adhenry@bredband.net>
Subject: Re: 2.6.25: sata_sil freezes, hard resets port.
Date: Wed, 11 Jun 2008 20:42:17 +0200
Message-ID: <48501C89.2040402@bredband.net>
References: <4846F3EA.2050408@bredband.net> <484DF2A2.103@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from proxy2.bredband.net ([195.54.101.72]:34550 "EHLO
	proxy2.bredband.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759894AbYFKTCg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 11 Jun 2008 15:02:36 -0400
Received: from ironport.bredband.com (195.54.101.120) by proxy2.bredband.net (7.3.127)
        id 4811833300DFB16D for linux-ide@vger.kernel.org; Wed, 11 Jun 2008 20:42:20 +0200
In-Reply-To: <484DF2A2.103@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Tejun Heo wrote:
>   Can you please
> post the outputs of dmesg after the wake up failure (fdisk -l) and
> "hdparm --Istdout /dev/sdX"?
>   
Yepp.  Here is the hdparm result (identical for both drives), followed
by the full dmesg output from boot until one of the drives starts
failing and then all the messages that come for a while after failure.
By the way, these are not the latest 'green' drives by Western Digital
that you hinted at.  They are one generation below the green drives, but
maybe they do have an updated standby feature.

[root@k2 Desktop]# hdparm --Istdout /dev/sdb

/dev/sdb:
 IO_support   =  0 (default 16-bit)
 readonly     =  0 (off)
 readahead    = 256 (on)
 geometry     = 60801/255/63, sectors = 976773168, start = 0
0040 3fff c837 0010 0000 0000 003f 0000
0000 0000 2020 2020 2057 442d 5743 4153
5530 3230 3638 3733 0000 0000 0000 3031
2e30 3142 3031 5744 204d 7920 426f 6f6b
2020 2020 2020 2020 2020 2020 2020 2020
2020 2020 2020 2020 2020 2020 2020 8001
0000 0b00 4001 0000 0000 0007 3fff 0010
003f fc10 00fb 0100 ffff 0fff 0000 0007
0003 0078 0078 0078 0078 0000 0000 0000
0000 0000 0000 0000 0106 0000 0000 0000
0070 001c 0029 7400 4002 0029 3400 4002
207f 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 6030 3a38 0000 0000
0000 0000 4000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 ab12 8004 c000 0001 0002 0001 0001
0000 0002 0000 0000 0000 0000 0001 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0001 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
[root@k2 Desktop]#


#########################
dmesg
#########################
[root@k2 Desktop]# cat dmesg.out
Linux version 2.6.25-custom (root@k2) (gcc version 4.1.2 20070626 (Red
Hat 4.1.2-14)) #1 SMP Tue May 27 22:12:03 CEST 2008
Command line: ro root=/dev/VolGroup00/LogVol00 rhgb quiet
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009b800 (usable)
 BIOS-e820: 000000000009b800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000d0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fea0000 (usable)
 BIOS-e820: 000000001fea0000 - 000000001feae000 (ACPI data)
 BIOS-e820: 000000001feae000 - 000000001ff00000 (ACPI NVS)
 BIOS-e820: 000000001ff00000 - 0000000020000000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
Entering add_active_range(0, 0, 155) 0 entries of 3200 used
Entering add_active_range(0, 256, 130720) 1 entries of 3200 used
end_pfn_map = 1048576
DMI 2.3 present.
ACPI: RSDP 000F6DA0, 0014 (r0 PTLTD )
ACPI: RSDT 1FEA81E3, 0034 (r1 PTLTD    RSDT    6040000  LTP        0)
ACPI: FACP 1FEADE41, 0074 (r1 ATI    Piranha   6040000 ATI     F4240)
ACPI: DSDT 1FEA8217, 5C2A (r1    ATI    SB400  6040000 MSFT  100000E)
ACPI: FACS 1FEAEFC0, 0040
ACPI: SSDT 1FEADEB5, 00B5 (r1 PTLTD  POWERNOW  6040000  LTP        1)
ACPI: APIC 1FEADF6A, 005A (r1 PTLTD       APIC    6040000  LTP        0)
ACPI: MCFG 1FEADFC4, 003C (r1 PTLTD    MCFG    6040000  LTP        0)
ACPI: DMI detected: Acer
Scanning NUMA topology in Northbridge 24
No NUMA configuration found
Faking a node at 0000000000000000-000000001fea0000
Entering add_active_range(0, 0, 155) 0 entries of 3200 used
Entering add_active_range(0, 256, 130720) 1 entries of 3200 used
Bootmem setup node 0 0000000000000000-000000001fea0000
  NODE_DATA [000000000000b000 - 0000000000013fff]
  bootmap [0000000000014000 -  0000000000017fd7] pages 4
early res: 0 [0-fff] BIOS data page
early res: 1 [6000-7fff] SMP_TRAMPOLINE
early res: 2 [200000-ab972b] TEXT DATA BSS
early res: 3 [1fbd8000-1fe8fe52] RAMDISK
early res: 4 [9b800-9c7ff] EBDA
early res: 5 [8000-afff] PGTABLE
 [ffffe20000000000-ffffe200001fffff] PMD ->ffff810001200000 on node 0
 [ffffe20000200000-ffffe200003fffff] PMD ->ffff810001600000 on node 0
 [ffffe20000400000-ffffe200005fffff] PMD ->ffff810001a00000 on node 0
 [ffffe20000600000-ffffe200007fffff] PMD ->ffff810001e00000 on node 0
Zone PFN ranges:
  DMA             0 ->     4096
  DMA32        4096 ->  1048576
  Normal    1048576 ->  1048576
Movable zone start PFN for each node
early_node_map[2] active PFN ranges
    0:        0 ->      155
    0:      256 ->   130720
On node 0 totalpages: 130619
  DMA zone: 56 pages used for memmap
  DMA zone: 2242 pages reserved
  DMA zone: 1697 pages, LIFO batch:0
  DMA32 zone: 1731 pages used for memmap
  DMA32 zone: 124893 pages, LIFO batch:31
  Normal zone: 0 pages used for memmap
  Movable zone: 0 pages used for memmap
ATI board detected. Disabling timer routing over 8254.
ACPI: PM-Timer IO Port: 0x8008
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 (Bootup-CPU)
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: IOAPIC (id[0x01] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 1, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 high edge)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 21 low level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
Setting APIC routing to flat
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 30000000 (gap: 20000000:dec00000)
SMP: Allowing 1 CPUs, 0 hotplug CPUs
PERCPU: Allocating 65360 bytes of per cpu data
Built 1 zonelists in Node order, mobility grouping on.  Total pages: 126590
Policy zone: DMA32
Kernel command line: ro root=/dev/VolGroup00/LogVol00 rhgb quiet
Initializing CPU#0
PID hash table entries: 2048 (order: 11, 16384 bytes)
TSC calibrated against PM_TIMER
time.c: Detected 1599.995 MHz processor.
Console: colour VGA+ 80x25
console [tty0] enabled
Checking aperture...
Node 0: aperture @ 387e000000 size 32 MB
Aperture beyond 4GB. Ignoring.
No AGP bridge found
Memory: 502108k/522880k available (3622k kernel code, 20368k reserved,
1775k data, 324k init)
CPA: page pool initialized 1 of 1 pages preallocated
Calibrating delay using timer specific routine.. 3202.23 BogoMIPS
(lpj=1601119)
Security Framework initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
selinux_register_security:  Registering secondary module capability
Capability LSM initialized as secondary
Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode-cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount-cache hash table entries: 256
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 512K (64 bytes/line)
CPU 0/0 -> Node 0
SMP alternatives: switching to UP code
Freeing SMP alternatives: 37k freed
ACPI: Core revision 20070126
..MP-BIOS bug: 8254 timer not connected to IO-APIC
Using local APIC timer interrupts.
APIC timer calibration result 12499959
Detected 12.499 MHz APIC timer.
Brought up 1 CPUs
CPU0 attaching sched-domain:
 domain 0: span
00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000001
  groups:
00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000001
net_namespace: 1016 bytes
xor: automatically using best checksumming function: generic_sse
   generic_sse:  5124.000 MB/sec
xor: using function: generic_sse (5124.000 MB/sec)
NET: Registered protocol family 16
ACPI: ACPI Dock Station Driver
ACPI: bus type pci registered
PCI: BIOS Bug: MCFG area at e0000000 is not E820-reserved
PCI: Not using MMCONFIG.
PCI: Using configuration type 1
ACPI: EC: Look up EC in DSDT
ACPI: Interpreter enabled
ACPI: (supports S0 S3 S5)
ACPI: Using IOAPIC for interrupt routing
ACPI: EC: non-query interrupt received, switching to interrupt mode
ACPI: EC: GPE = 0x3, I/O: command/status = 0x66, data = 0x62
ACPI: EC: driver started in interrupt mode
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Transparent bridge - 0000:00:14.4
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PB6_._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PB7_._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.EXP1._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P2P_._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 10 11) *0, disabled.
ACPI: PCI Interrupt Link [LNKB] (IRQs 10 11) *0, disabled.
ACPI: PCI Interrupt Link [LNKC] (IRQs 10 11) *0, disabled.
ACPI: PCI Interrupt Link [LNKD] (IRQs 10 11) *0, disabled.
ACPI: PCI Interrupt Link [LNKE] (IRQs 10 11) *0, disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 10 11) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 10 11) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 10 11) *0, disabled.
ACPI: WMI: Mapper loaded
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
ACPI: bus type pnp registered
 00:09: mem resource (0xe0000-0xfffff) overlaps 0000:00:06.0 BAR 8
(0x0-0xfffff), disabling
 00:09: mem resource (0x0-0xfff) overlaps 0000:00:06.0 BAR 8
(0x0-0xfffff), disabling
pnp: PnP ACPI: found 11 devices
ACPI: ACPI bus type pnp unregistered
SCSI subsystem initialized
libata version 3.00 loaded.
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a
report
PCI: Cannot allocate resource region 7 of bridge 0000:00:06.0
PCI: Cannot allocate resource region 8 of bridge 0000:00:06.0
PCI: Cannot allocate resource region 7 of bridge 0000:00:07.0
PCI: Cannot allocate resource region 8 of bridge 0000:00:07.0
NetLabel: Initializing
NetLabel:  domain hash size = 128
NetLabel:  protocols = UNLABELED CIPSOv4
NetLabel:  unlabeled traffic allowed by default
system 00:01: iomem range 0xe0000000-0xefffffff has been reserved
system 00:01: iomem range 0xfec00000-0xfec00fff could not be reserved
system 00:01: iomem range 0xfee00000-0xfee00fff could not be reserved
system 00:08: ioport range 0x1080-0x1080 has been reserved
system 00:08: ioport range 0x1200-0x120f has been reserved
system 00:08: ioport range 0x500-0x51f has been reserved
system 00:08: ioport range 0x40b-0x40b has been reserved
system 00:08: ioport range 0x4d0-0x4d1 has been reserved
system 00:08: ioport range 0x4d6-0x4d6 has been reserved
system 00:08: ioport range 0xc00-0xc01 has been reserved
system 00:08: ioport range 0xc14-0xc14 has been reserved
system 00:08: ioport range 0xc50-0xc52 has been reserved
system 00:08: ioport range 0xc6c-0xc6c has been reserved
system 00:08: ioport range 0xc6f-0xc6f has been reserved
system 00:08: ioport range 0xcd4-0xcd5 has been reserved
system 00:08: ioport range 0xcd6-0xcd7 has been reserved
system 00:08: ioport range 0xcd8-0xcdf has been reserved
system 00:08: ioport range 0x8000-0x805f has been reserved
system 00:08: ioport range 0xf40-0xf47 has been reserved
system 00:08: ioport range 0x87f-0x87f has been reserved
system 00:09: iomem range 0xfff80000-0xffffffff could not be reserved
PCI: Bridge: 0000:00:02.0
  IO window: 9000-9fff
  MEM window: 0xc0100000-0xc01fffff
  PREFETCH window: 0x00000000c8000000-0x00000000cfffffff
PCI: Bridge: 0000:00:06.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:07.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bus 7, cardbus bridge: 0000:06:06.0
  IO window: 0x0000a400-0x0000a4ff
  IO window: 0x0000a800-0x0000a8ff
  PREFETCH window: 0x30000000-0x33ffffff
  MEM window: 0x34000000-0x37ffffff
PCI: Bridge: 0000:00:14.4
  IO window: a000-afff
  MEM window: 0xc0200000-0xc02fffff
  PREFETCH window: 0x0000000030000000-0x0000000033ffffff
PCI: Setting latency timer of device 0000:00:02.0 to 64
PCI: Setting latency timer of device 0000:00:06.0 to 64
PCI: Setting latency timer of device 0000:00:07.0 to 64
ACPI: PCI Interrupt 0000:06:06.0[A] -> GSI 20 (level, low) -> IRQ 20
NET: Registered protocol family 2
IP route cache hash table entries: 4096 (order: 3, 32768 bytes)
TCP established hash table entries: 16384 (order: 6, 262144 bytes)
TCP bind hash table entries: 16384 (order: 6, 262144 bytes)
TCP: Hash tables configured (established 16384 bind 16384)
TCP reno registered
checking if image is initramfs... it is
Freeing initrd memory: 2783k freed
audit: initializing netlink socket (disabled)
type=2000 audit(1212039986.527:1): initialized
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
NTFS driver 2.1.29 [Flags: R/W].
fuse init (API version 7.9)
SELinux:  Registering netfilter hooks
async_tx: api initialized (sync-only)
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
pci 0000:00:00.0: MSI quirk detected; MSI disabled
pci 0000:01:00.0: Boot video device
PCI: Setting latency timer of device 0000:00:02.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:02.0:pcie00]
PCI: Setting latency timer of device 0000:00:06.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:06.0:pcie00]
PCI: Setting latency timer of device 0000:00:07.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:07.0:pcie00]
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
ACPI: AC Adapter [ADP1] (on-line)
Switched to high resolution mode on CPU 0
ACPI: Battery Slot [BAT0] (battery present)
input: Power Button (FF) as /class/input/input0
ACPI: Power Button (FF) [PWRF]
input: Lid Switch as /class/input/input1
ACPI: Lid Switch [LID0]
input: Sleep Button (CM) as /class/input/input2
ACPI: Sleep Button (CM) [SLPB]
ACPI: CPU0 (power states: C1[C1] C2[C2] C3[C3])
ACPI: ACPI0007:00 is registered as cooling_device0
ACPI: LNXTHERM:01 is registered as thermal_zone0
ACPI: Thermal Zone [TZS0] (44 C)
ACPI: LNXTHERM:02 is registered as thermal_zone1
ACPI: Thermal Zone [TZS1] (27 C)
ACPI: LNXTHERM:03 is registered as thermal_zone2
ACPI: Thermal Zone [TZSV] (33 C)
Real Time Clock Driver v1.12ac
Non-volatile memory driver v1.2
Linux agpgart interface v0.103
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
ACPI: PCI Interrupt 0000:00:14.6[B] -> GSI 17 (level, low) -> IRQ 17
ACPI: PCI interrupt for device 0000:00:14.6 disabled
brd: module loaded
acer-wmi: Acer Laptop ACPI-WMI Extras version 0.1
Registered led device: acer-wmi::mail
Uniform Multi-Platform E-IDE driver
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ATIIXP: IDE controller (0x1002:0x4376 rev 0x00) at  PCI slot 0000:00:14.1
ACPI: PCI Interrupt 0000:00:14.1[A] -> GSI 16 (level, low) -> IRQ 16
ATIIXP: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x8410-0x8417, BIOS settings: hda:DMA, hdb:PIO
    ide1: BM-DMA at 0x8418-0x841f, BIOS settings: hdc:DMA, hdd:PIO
Probing IDE interface ide0...
hda: ST9808210A, ATA DISK drive
hda: host max PIO4 wanted PIO255(auto-tune) selected PIO4
hda: UDMA/100 mode selected
Probing IDE interface ide1...
hdc: MATSHITAUJ-845D, ATAPI CD/DVD-ROM drive
hdc: host max PIO4 wanted PIO255(auto-tune) selected PIO4
hdc: UDMA/33 mode selected
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 512KiB
hda: 156301488 sectors (80026 MB) w/8192KiB Cache, CHS=16383/255/63
hda: cache flushes supported
 hda: hda1 hda2
ide-floppy driver 1.00
ACPI: PCI Interrupt 0000:06:06.2[C] -> GSI 22 (level, low) -> IRQ 22
ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[22] 
MMIO=[c0208000-c02087ff]  Max Packet=[2048]  IR/IT contexts=[4/8]
video1394: Installed video1394 module
ieee1394: raw1394: /dev/raw1394 device initialized
eth1394: eth0: IPv4 over IEEE 1394 (fw-host0)
Yenta: CardBus bridge found at 0000:06:06.0 [1025:0080]
Yenta: Using CSCINT to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta TI: socket 0000:06:06.0, mfunc 0x010a1b22, devctl 0x64
Yenta: ISA IRQ mask 0x0ef8, PCI irq 20
Socket status: 30000820
Yenta: Raising subordinate bus# of parent bus (#06) from #06 to #08
pcmcia: parent PCI bridge I/O window: 0xa000 - 0xafff
pcmcia: parent PCI bridge Memory window: 0xc0200000 - 0xc02fffff
pcmcia: parent PCI bridge Memory window: 0x30000000 - 0x33ffffff
PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
i8042.c: Detected active multiplexing controller, rev 1.1.
serio: i8042 KBD port at 0x60,0x64 irq 1
serio: i8042 AUX0 port at 0x60,0x64 irq 12
serio: i8042 AUX1 port at 0x60,0x64 irq 12
serio: i8042 AUX2 port at 0x60,0x64 irq 12
serio: i8042 AUX3 port at 0x60,0x64 irq 12
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard as /class/input/input3
md: linear personality registered for level -1
md: raid0 personality registered for level 0
md: raid1 personality registered for level 1
raid6: int64x1   1019 MB/s
raid6: int64x2   1605 MB/s
raid6: int64x4   1414 MB/s
raid6: int64x8   1406 MB/s
raid6: sse2x1    1722 MB/s
raid6: sse2x2    2585 MB/s
raid6: sse2x4    2882 MB/s
raid6: using algorithm sse2x4 (2882 MB/s)
md: raid6 personality registered for level 6
md: raid5 personality registered for level 5
md: raid4 personality registered for level 4
md: multipath personality registered for level -4
md: faulty personality registered for level -5
device-mapper: ioctl: 4.13.0-ioctl (2007-10-18) initialised:
dm-devel@redhat.com
device-mapper: multipath: version 1.0.5 loaded
device-mapper: multipath round-robin: version 1.0.0 loaded
cpuidle: using governor ladder
cpuidle: using governor menu
sdhci: Secure Digital Host Controller Interface driver
sdhci: Copyright(c) Pierre Ossman
sdhci: SDHCI controller found at 0000:06:06.4 [104c:8034] (rev 0)
ACPI: PCI Interrupt 0000:06:06.4[A] -> GSI 20 (level, low) -> IRQ 20
sdhc0:slot0: Will use DMA mode even though HW doesn't fully claim to
support it.
mmc0: SDHCI at 0xc0209000 irq 20 DMA
sdhc0:slot1: Will use DMA mode even though HW doesn't fully claim to
support it.
mmc1: SDHCI at 0xc0208c00 irq 20 DMA
sdhc0:slot2: Will use DMA mode even though HW doesn't fully claim to
support it.
mmc2: SDHCI at 0xc0208800 irq 20 DMA
wbsd: Winbond W83L51xD SD/MMC card interface driver
wbsd: Copyright(c) Pierre Ossman
usbcore: registered new interface driver hiddev
usbcore: registered new interface driver usbhid
drivers/hid/usbhid/hid-core.c: v2.6:USB HID core driver
Advanced Linux Sound Architecture Driver Version 1.0.16rc2 (Thu Jan 31
16:40:16 2008 UTC).
Marking TSC unstable due to TSC halts in idle
pccard: CardBus card inserted into slot 0
sata_sil 0000:07:00.0: version 2.3
PCI: Enabling device 0000:07:00.0 (0000 -> 0003)
ACPI: PCI Interrupt 0000:07:00.0[A] -> GSI 20 (level, low) -> IRQ 20
sata_sil 0000:07:00.0: cache line size not set.  Driver may not function
sata_sil 0000:07:00.0: Applying R_ERR on DMA activate FIS errata fix
PCI: Setting latency timer of device 0000:07:00.0 to 64
scsi0 : sata_sil
scsi1 : sata_sil
ata1: SATA max UDMA/100 mmio m512@0x34000000 tf 0x34000080 irq 20
ata2: SATA max UDMA/100 mmio m512@0x34000000 tf 0x340000c0 irq 20
Synaptics Touchpad, model: 1, fw: 6.2, id: 0x12a0b1, caps: 0xa04713/0x204000
input: SynPS/2 Synaptics TouchPad as /class/input/input4
no UART detected at 0x1
ALSA device list:
  #0: Dummy 1
  #1: Virtual MIDI Card 1
TCP bic registered
Initializing XFRM netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
powernow-k8: Found 1 AMD Turion(tm) 64 Mobile Technology ML-28
processors (1 cpu cores) (version 2.20.00)
powernow-k8:    0 : fid 0x8 (1600 MHz), vid 0x4
powernow-k8:    1 : fid 0x0 (800 MHz), vid 0x16
registered taskstats version 1
Freeing unused kernel memory: 324k freed
Write protecting the kernel read-only data: 1340k
ieee1394: Node added: ID:BUS[0-00:1023]  GUID[0090a991e01124a2]
ieee1394: Host added: ID:BUS[0-01:1023]  GUID[1234567812345678]
scsi2 : SBP-2 IEEE-1394
USB Universal Host Controller Interface driver v3.0
ohci_hcd: 2006 August 04 USB 1.1 'Open' Host Controller (OHCI) Driver
ACPI: PCI Interrupt 0000:00:13.0[A] -> GSI 19 (level, low) -> IRQ 19
ohci_hcd 0000:00:13.0: OHCI Host Controller
ohci_hcd 0000:00:13.0: new USB bus registered, assigned bus number 1
ohci_hcd 0000:00:13.0: irq 19, io mem 0xc0000000
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 4 ports detected
ACPI: PCI Interrupt 0000:00:13.1[A] -> GSI 19 (level, low) -> IRQ 19
ohci_hcd 0000:00:13.1: OHCI Host Controller
ohci_hcd 0000:00:13.1: new USB bus registered, assigned bus number 2
ohci_hcd 0000:00:13.1: irq 19, io mem 0xc0001000
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 4 ports detected
ACPI: PCI Interrupt 0000:00:13.2[A] -> GSI 19 (level, low) -> IRQ 19
ehci_hcd 0000:00:13.2: EHCI Host Controller
ehci_hcd 0000:00:13.2: new USB bus registered, assigned bus number 3
ehci_hcd 0000:00:13.2: irq 19, io mem 0xc0002000
ehci_hcd 0000:00:13.2: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 8 ports detected
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
ieee1394: sbp2: Logged into SBP-2 device
ieee1394: sbp2: Node 0-00:1023: Max speed [S400] - Max payload [2048]
type=1404 audit(1212039992.772:2): enforcing=1 old_enforcing=0
auid=4294967295 ses=4294967295
SELinux:8192 avtab hash slots allocated. Num of rules:57758
SELinux:8192 avtab hash slots allocated. Num of rules:57758
security:  3 users, 6 roles, 1660 types, 210 bools, 1 sens, 1024 cats
security:  61 classes, 57758 rules
security:  class peer not defined in policy
security:  class capability2 not defined in policy
security:  permission recvfrom in class node not defined in policy
security:  permission sendto in class node not defined in policy
security:  permission ingress in class netif not defined in policy
security:  permission egress in class netif not defined in policy
security:  permission setfcap in class capability not defined in policy
security:  permission forward_in in class packet not defined in policy
security:  permission forward_out in class packet not defined in policy
SELinux:  Completing initialization.
SELinux:  Setting up existing superblocks.
SELinux: initialized (dev dm-0, type ext3), uses xattr
SELinux: initialized (dev usbfs, type usbfs), uses genfs_contexts
SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs
SELinux: initialized (dev selinuxfs, type selinuxfs), uses genfs_contexts
SELinux: initialized (dev mqueue, type mqueue), uses transition SIDs
SELinux: initialized (dev hugetlbfs, type hugetlbfs), uses genfs_contexts
SELinux: initialized (dev devpts, type devpts), uses transition SIDs
SELinux: initialized (dev inotifyfs, type inotifyfs), uses genfs_contexts
SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs
SELinux: initialized (dev futexfs, type futexfs), uses genfs_contexts
SELinux: initialized (dev anon_inodefs, type anon_inodefs), uses
genfs_contexts
SELinux: initialized (dev pipefs, type pipefs), uses task SIDs
SELinux: initialized (dev debugfs, type debugfs), uses genfs_contexts
SELinux: initialized (dev sockfs, type sockfs), uses task SIDs
SELinux: initialized (dev proc, type proc), uses genfs_contexts
SELinux: initialized (dev bdev, type bdev), uses genfs_contexts
SELinux: initialized (dev rootfs, type rootfs), uses genfs_contexts
SELinux: initialized (dev sysfs, type sysfs), uses genfs_contexts
SELinux: policy loaded with handle_unknown=deny
type=1403 audit(1212039992.996:3): policy loaded auid=4294967295
ses=4294967295
ata1: port is slow to respond, please be patient (Status 0xff)
input: PC Speaker as /class/input/input5
ieee1394: sbp2: aborting sbp2 command
scsi 2:0:1:0: CDB: Inquiry: 12 00 00 00 24 00
shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
r8169 Gigabit Ethernet driver 2.2LK-NAPI loaded
ACPI: PCI Interrupt 0000:06:07.0[A] -> GSI 23 (level, low) -> IRQ 23
eth1: RTL8169sb/8110sb at 0xffffc2000019a400, 00:0a:e4:e1:37:69, XID
10000000 IRQ 23
ata1.00: ATA-6: WD My Book, 01.01B01, max UDMA/133
ata1.00: 976773168 sectors, multi 0: LBA48 NCQ (depth 0/1)
cannot find the slot for index 0 (range 0-2), error: -16
ATI IXP AC97 controller: probe of 0000:00:14.5 failed with error -12
ACPI: PCI Interrupt 0000:00:14.6[B] -> GSI 17 (level, low) -> IRQ 17
ata1.00: configured for UDMA/100
MC'97 1 converters and GPIO not ready (0xff00)
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata2.00: ATA-6: WD My Book, 01.01B01, max UDMA/133
ata2.00: 976773168 sectors, multi 0: LBA48 NCQ (depth 0/1)
ata2.00: configured for UDMA/100
scsi 0:0:0:0: Direct-Access     ATA      WD My Book       01.0 PQ: 0 ANSI: 5
scsi 1:0:0:0: Direct-Access     ATA      WD My Book       01.0 PQ: 0 ANSI: 5
hdc: ATAPI 24X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache
Uniform CD-ROM driver Revision: 3.20
scsi 2:0:1:0: Direct-Access     WD       3200JS External  106a PQ: 0 ANSI: 4
Driver 'sd' needs updating - please use bus_type methods
sd 0:0:0:0: [sda] 976773168 512-byte hardware sectors (500108 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
sd 0:0:0:0: [sda] 976773168 512-byte hardware sectors (500108 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
 sda:<5>sd 0:0:0:0: Attached scsi generic sg0 type 0
scsi 1:0:0:0: Attached scsi generic sg1 type 0
scsi 2:0:1:0: Attached scsi generic sg2 type 0
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata1.00: cmd c8/00:08:00:00:00/00:00:00:00:00/e0 tag 0 dma 4096 in
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata1.00: status: { DRDY }
ata1: port is slow to respond, please be patient (Status 0xd8)
ata1: device not ready (errno=-16), forcing hardreset
ata1: hard resetting link
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata1.00: configured for UDMA/100
ata1: EH complete
 unknown partition table
sd 0:0:0:0: [sda] Attached SCSI disk
sd 1:0:0:0: [sdb] 976773168 512-byte hardware sectors (500108 MB)
sd 1:0:0:0: [sdb] Write Protect is off
sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
sd 1:0:0:0: [sdb] 976773168 512-byte hardware sectors (500108 MB)
sd 1:0:0:0: [sdb] Write Protect is off
sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
 sdb:<5>sd 0:0:0:0: [sda] 976773168 512-byte hardware sectors (500108 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata2.00: cmd c8/00:08:00:00:00/00:00:00:00:00/e0 tag 0 dma 4096 in
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata2.00: status: { DRDY }
ata2: port is slow to respond, please be patient (Status 0xd8)
ata2: device not ready (errno=-16), forcing hardreset
ata2: hard resetting link
ata2: port is slow to respond, please be patient (Status 0xff)
ata2: COMRESET failed (errno=-16)
ata2: hard resetting link
ata2: port is slow to respond, please be patient (Status 0xff)
ata2: COMRESET failed (errno=-16)
ata2: hard resetting link
ata2: port is slow to respond, please be patient (Status 0xff)
ata2: COMRESET failed (errno=-16)
ata2: hard resetting link
ata2: COMRESET failed (errno=-16)
ata2: reset failed, giving up
ata2.00: disabled
ata2: EH complete
sd 1:0:0:0: [sdb] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK
end_request: I/O error, dev sdb, sector 0
Buffer I/O error on device sdb, logical block 0
sd 1:0:0:0: [sdb] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK
end_request: I/O error, dev sdb, sector 0
Buffer I/O error on device sdb, logical block 0
sd 1:0:0:0: [sdb] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK
end_request: I/O error, dev sdb, sector 0
Buffer I/O error on device sdb, logical block 0
sd 1:0:0:0: [sdb] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK
end_request: I/O error, dev sdb, sector 0
Buffer I/O error on device sdb, logical block 0
ldm_validate_partition_table(): Disk read failed.
sd 1:0:0:0: [sdb] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK
end_request: I/O error, dev sdb, sector 0
Buffer I/O error on device sdb, logical block 0
sd 1:0:0:0: [sdb] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK
end_request: I/O error, dev sdb, sector 0
Buffer I/O error on device sdb, logical block 0
sd 1:0:0:0: [sdb] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK
end_request: I/O error, dev sdb, sector 0
Buffer I/O error on device sdb, logical block 0
sd 1:0:0:0: [sdb] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK
end_request: I/O error, dev sdb, sector 0
Buffer I/O error on device sdb, logical block 0
Dev sdb: unable to read RDB block 0
sd 1:0:0:0: [sdb] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK
end_request: I/O error, dev sdb, sector 0
Buffer I/O error on device sdb, logical block 0
sd 1:0:0:0: [sdb] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK
end_request: I/O error, dev sdb, sector 0
Buffer I/O error on device sdb, logical block 0
 unable to read partition table
sd 1:0:0:0: [sdb] Attached SCSI disk
sd 2:0:1:0: [sdc] 625142448 512-byte hardware sectors (320073 MB)
sd 2:0:1:0: [sdc] Write Protect is off
sd 2:0:1:0: [sdc] Mode Sense: 11 00 00 00
sd 2:0:1:0: [sdc] Cache data unavailable
sd 2:0:1:0: [sdc] Assuming drive cache: write through
sd 2:0:1:0: [sdc] 625142448 512-byte hardware sectors (320073 MB)
sd 2:0:1:0: [sdc] Write Protect is off
sd 2:0:1:0: [sdc] Mode Sense: 11 00 00 00
sd 2:0:1:0: [sdc] Cache data unavailable
sd 2:0:1:0: [sdc] Assuming drive cache: write through
 sdc: sdc1
sd 2:0:1:0: [sdc] Attached SCSI disk
sd 1:0:0:0: [sdb] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK
end_request: I/O error, dev sdb, sector 976772992
sd 1:0:0:0: [sdb] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK
end_request: I/O error, dev sdb, sector 976772992
sd 1:0:0:0: [sdb] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK
end_request: I/O error, dev sdb, sector 976773160
sd 1:0:0:0: [sdb] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK
end_request: I/O error, dev sdb, sector 976773160
sd 1:0:0:0: [sdb] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK
end_request: I/O error, dev sdb, sector 976773160
sd 1:0:0:0: [sdb] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK
end_request: I/O error, dev sdb, sector 976773160
sd 1:0:0:0: [sdb] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK
end_request: I/O error, dev sdb, sector 976773160
sd 1:0:0:0: [sdb] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK
end_request: I/O error, dev sdb, sector 976773160
sd 1:0:0:0: [sdb] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK
end_request: I/O error, dev sdb, sector 976773104
sd 1:0:0:0: [sdb] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK
end_request: I/O error, dev sdb, sector 976773152
sd 1:0:0:0: [sdb] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK
end_request: I/O error, dev sdb, sector 976773160
sd 1:0:0:0: [sdb] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK
end_request: I/O error, dev sdb, sector 976773160
sd 1:0:0:0: [sdb] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK
end_request: I/O error, dev sdb, sector 0
sd 1:0:0:0: [sdb] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK
end_request: I/O error, dev sdb, sector 0
sd 1:0:0:0: [sdb] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK
end_request: I/O error, dev sdb, sector 0
sd 1:0:0:0: [sdb] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK
end_request: I/O error, dev sdb, sector 0
sd 1:0:0:0: [sdb] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK
end_request: I/O error, dev sdb, sector 0
sd 1:0:0:0: [sdb] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK
end_request: I/O error, dev sdb, sector 0
sd 1:0:0:0: [sdb] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK
end_request: I/O error, dev sdb, sector 0
sd 1:0:0:0: [sdb] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK
end_request: I/O error, dev sdb, sector 0
sd 1:0:0:0: [sdb] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK
end_request: I/O error, dev sdb, sector 0
sd 1:0:0:0: [sdb] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK
end_request: I/O error, dev sdb, sector 0
sd 1:0:0:0: [sdb] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK
end_request: I/O error, dev sdb, sector 0
sd 1:0:0:0: [sdb] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK
end_request: I/O error, dev sdb, sector 0
sd 1:0:0:0: [sdb] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK
end_request: I/O error, dev sdb, sector 0
sd 1:0:0:0: [sdb] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK
end_request: I/O error, dev sdb, sector 0
sd 1:0:0:0: [sdb] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK
end_request: I/O error, dev sdb, sector 0
sd 1:0:0:0: [sdb] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK
end_request: I/O error, dev sdb, sector 0
sd 1:0:0:0: [sdb] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK
end_request: I/O error, dev sdb, sector 0
sd 1:0:0:0: [sdb] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK
end_request: I/O error, dev sdb, sector 0
sd 1:0:0:0: [sdb] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK
end_request: I/O error, dev sdb, sector 0
sd 1:0:0:0: [sdb] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK
end_request: I/O error, dev sdb, sector 0
sd 1:0:0:0: [sdb] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK
end_request: I/O error, dev sdb, sector 0
sd 1:0:0:0: [sdb] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK
end_request: I/O error, dev sdb, sector 0
sd 1:0:0:0: [sdb] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK
end_request: I/O error, dev sdb, sector 0
sd 1:0:0:0: [sdb] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK
end_request: I/O error, dev sdb, sector 0
sd 1:0:0:0: [sdb] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK
end_request: I/O error, dev sdb, sector 0
sd 1:0:0:0: [sdb] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK
end_request: I/O error, dev sdb, sector 0
sd 1:0:0:0: [sdb] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK
end_request: I/O error, dev sdb, sector 0
sd 1:0:0:0: [sdb] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK
end_request: I/O error, dev sdb, sector 0
SELinux: initialized (dev ramfs, type ramfs), uses genfs_contexts
NET: Registered protocol family 10
lo: Disabled Privacy Extensions
[drm] Initialized drm 1.1.0 20060810
ACPI: PCI Interrupt 0000:01:00.0[A] -> GSI 18 (level, low) -> IRQ 18
PCI: Setting latency timer of device 0000:01:00.0 to 64
[drm] Initialized radeon 1.28.0 20060524 on minor 0
md: Autodetecting RAID arrays.
md: Scanned 0 and added 0 devices.
md: autorun ...
md: ... autorun DONE.
sd 1:0:0:0: [sdb] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK
end_request: I/O error, dev sdb, sector 976773160
printk: 40 messages suppressed.
Buffer I/O error on device sdb, logical block 122096645
sd 1:0:0:0: [sdb] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK
end_request: I/O error, dev sdb, sector 976773160
Buffer I/O error on device sdb, logical block 122096645
sd 1:0:0:0: [sdb] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK
end_request: I/O error, dev sdb, sector 976773160
sd 1:0:0:0: [sdb] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK
end_request: I/O error, dev sdb, sector 976773160
sd 1:0:0:0: [sdb] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK
end_request: I/O error, dev sdb, sector 976772904
sd 1:0:0:0: [sdb] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK
end_request: I/O error, dev sdb, sector 976772904
sd 1:0:0:0: [sdb] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK
end_request: I/O error, dev sdb, sector 8
sd 1:0:0:0: [sdb] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK
end_request: I/O error, dev sdb, sector 8
sd 1:0:0:0: [sdb] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK
end_request: I/O error, dev sdb, sector 976773152
sd 1:0:0:0: [sdb] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK
end_request: I/O error, dev sdb, sector 976773152
sd 1:0:0:0: [sdb] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK
end_request: I/O error, dev sdb, sector 976773160
sd 1:0:0:0: [sdb] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK
end_request: I/O error, dev sdb, sector 976773160
sd 1:0:0:0: [sdb] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK
end_request: I/O error, dev sdb, sector 976773160
sd 1:0:0:0: [sdb] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK
end_request: I/O error, dev sdb, sector 976773160
sd 1:0:0:0: [sdb] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK
end_request: I/O error, dev sdb, sector 976773160
sd 1:0:0:0: [sdb] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK
end_request: I/O error, dev sdb, sector 976773160
sd 1:0:0:0: [sdb] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK
end_request: I/O error, dev sdb, sector 976773160
sd 1:0:0:0: [sdb] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK
end_request: I/O error, dev sdb, sector 976773160
sd 1:0:0:0: [sdb] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK
end_request: I/O error, dev sdb, sector 976773104
sd 1:0:0:0: [sdb] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK
end_request: I/O error, dev sdb, sector 976773104
sd 1:0:0:0: [sdb] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK
end_request: I/O error, dev sdb, sector 976772912
sd 1:0:0:0: [sdb] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK
end_request: I/O error, dev sdb, sector 976772912
sd 1:0:0:0: [sdb] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK
end_request: I/O error, dev sdb, sector 976772912
sd 1:0:0:0: [sdb] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK
end_request: I/O error, dev sdb, sector 976772912
sd 1:0:0:0: [sdb] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK
end_request: I/O error, dev sdb, sector 976773152
sd 1:0:0:0: [sdb] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK
end_request: I/O error, dev sdb, sector 976773152
sd 1:0:0:0: [sdb] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK
end_request: I/O error, dev sdb, sector 976772768
sd 1:0:0:0: [sdb] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK
end_request: I/O error, dev sdb, sector 976772768
sd 1:0:0:0: [sdb] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK
end_request: I/O error, dev sdb, sector 976772432
sd 1:0:0:0: [sdb] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK
end_request: I/O error, dev sdb, sector 976772432
sd 1:0:0:0: [sdb] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK
end_request: I/O error, dev sdb, sector 976773160
sd 1:0:0:0: [sdb] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK
end_request: I/O error, dev sdb, sector 976773160
sd 1:0:0:0: [sdb] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK
end_request: I/O error, dev sdb, sector 976773160
sd 1:0:0:0: [sdb] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK
end_request: I/O error, dev sdb, sector 976773160
sd 1:0:0:0: [sdb] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK
end_request: I/O error, dev sdb, sector 0
EXT3 FS on dm-0, internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
SELinux: initialized (dev dm-1, type ext3), uses xattr
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-2, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
SELinux: initialized (dev dm-2, type ext3), uses xattr
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
SELinux: initialized (dev hda1, type ext3), uses xattr
SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-3, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
SELinux: initialized (dev dm-3, type ext3), uses xattr
Adding 2097144k swap on /dev/VolGroup00/LogVol04.  Priority:-1 extents:1
across:2097144k
SELinux: initialized (dev binfmt_misc, type binfmt_misc), uses
genfs_contexts
sd 1:0:0:0: [sdb] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK
end_request: I/O error, dev sdb, sector 0
sd 1:0:0:0: [sdb] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK
end_request: I/O error, dev sdb, sector 0
warning: process `kudzu' used the deprecated sysctl system call with 1.23.
Clocksource tsc unstable (delta = -169474473 ns)
r8169: eth0: link up
warning: `mcstransd' uses 32-bit capabilities (legacy support in use)
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
SELinux: initialized (dev rpc_pipefs, type rpc_pipefs), uses genfs_contexts
Bluetooth: Core ver 2.11
NET: Registered protocol family 31
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
Bluetooth: L2CAP ver 2.9
Bluetooth: L2CAP socket layer initialized
Bluetooth: RFCOMM socket layer initialized
Bluetooth: RFCOMM TTY layer initialized
Bluetooth: RFCOMM ver 1.8
Bluetooth: HIDP (Human Interface Emulation) ver 1.2
SELinux: initialized (dev autofs, type autofs), uses genfs_contexts
eth0: no IPv6 routers present
SELinux: initialized (dev autofs, type autofs), uses genfs_contexts
SELinux: initialized (dev autofs, type autofs), uses genfs_contexts
sd 1:0:0:0: [sdb] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK
end_request: I/O error, dev sdb, sector 976772992
printk: 32 messages suppressed.
Buffer I/O error on device sdb, logical block 122096624
sd 1:0:0:0: [sdb] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK
end_request: I/O error, dev sdb, sector 976772992
Buffer I/O error on device sdb, logical block 122096624
sd 1:0:0:0: [sdb] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK
end_request: I/O error, dev sdb, sector 976773160
Buffer I/O error on device sdb, logical block 122096645
sd 1:0:0:0: [sdb] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK
end_request: I/O error, dev sdb, sector 976773160
Buffer I/O error on device sdb, logical block 122096645
sd 1:0:0:0: [sdb] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK
end_request: I/O error, dev sdb, sector 976773160
Buffer I/O error on device sdb, logical block 122096645
sd 1:0:0:0: [sdb] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK
end_request: I/O error, dev sdb, sector 976773160
Buffer I/O error on device sdb, logical block 122096645
sd 1:0:0:0: [sdb] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK
end_request: I/O error, dev sdb, sector 976773160
Buffer I/O error on device sdb, logical block 122096645
sd 1:0:0:0: [sdb] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK
end_request: I/O error, dev sdb, sector 976773160
sd 1:0:0:0: [sdb] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK
end_request: I/O error, dev sdb, sector 976773104
sd 1:0:0:0: [sdb] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK
end_request: I/O error, dev sdb, sector 976773152
sd 1:0:0:0: [sdb] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK
end_request: I/O error, dev sdb, sector 976773160
sd 1:0:0:0: [sdb] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK
end_request: I/O error, dev sdb, sector 976773160
sd 1:0:0:0: [sdb] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK
end_request: I/O error, dev sdb, sector 0
sd 1:0:0:0: [sdb] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK
end_request: I/O error, dev sdb, sector 0
sd 1:0:0:0: [sdb] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK
end_request: I/O error, dev sdb, sector 0
sd 1:0:0:0: [sdb] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK
end_request: I/O error, dev sdb, sector 0
sd 1:0:0:0: [sdb] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK
end_request: I/O error, dev sdb, sector 0
sd 1:0:0:0: [sdb] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK
end_request: I/O error, dev sdb, sector 0
sd 1:0:0:0: [sdb] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK
end_request: I/O error, dev sdb, sector 0
sd 1:0:0:0: [sdb] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK
end_request: I/O error, dev sdb, sector 0
sd 1:0:0:0: [sdb] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK
end_request: I/O error, dev sdb, sector 0
sd 1:0:0:0: [sdb] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK
end_request: I/O error, dev sdb, sector 0
sd 1:0:0:0: [sdb] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK
end_request: I/O error, dev sdb, sector 0
sd 1:0:0:0: [sdb] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK
end_request: I/O error, dev sdb, sector 0
sd 1:0:0:0: [sdb] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK
end_request: I/O error, dev sdb, sector 0
sd 1:0:0:0: [sdb] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK
end_request: I/O error, dev sdb, sector 0
sd 1:0:0:0: [sdb] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK
end_request: I/O error, dev sdb, sector 0
sd 1:0:0:0: [sdb] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK
end_request: I/O error, dev sdb, sector 0
sd 1:0:0:0: [sdb] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK
end_request: I/O error, dev sdb, sector 0
sd 1:0:0:0: [sdb] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK
end_request: I/O error, dev sdb, sector 0
sd 1:0:0:0: [sdb] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK
end_request: I/O error, dev sdb, sector 0
sd 1:0:0:0: [sdb] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK
end_request: I/O error, dev sdb, sector 0
sd 1:0:0:0: [sdb] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK
end_request: I/O error, dev sdb, sector 0
sd 1:0:0:0: [sdb] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK
end_request: I/O error, dev sdb, sector 0
sd 1:0:0:0: [sdb] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK
end_request: I/O error, dev sdb, sector 0
sd 1:0:0:0: [sdb] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK
end_request: I/O error, dev sdb, sector 0
sd 1:0:0:0: [sdb] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK
end_request: I/O error, dev sdb, sector 0
sd 1:0:0:0: [sdb] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK
end_request: I/O error, dev sdb, sector 0
sd 1:0:0:0: [sdb] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK
end_request: I/O error, dev sdb, sector 0
sd 1:0:0:0: [sdb] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK
end_request: I/O error, dev sdb, sector 0
[drm] Setting GART location based on new memory map
[drm] Loading R300 Microcode
[drm] writeback test succeeded in 1 usecs
[drm] Setting GART location based on new memory map
[drm] Loading R300 Microcode
[drm] writeback test succeeded in 1 usecs
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-5, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
SELinux: initialized (dev dm-5, type ext3), uses xattr
[root@k2 Desktop]#

