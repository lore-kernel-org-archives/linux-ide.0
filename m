From: Srihari Vijayaraghavan <sriharivijayaraghavan@yahoo.com.au>
Subject: ASUS M2A-VM - AMD690G - SB600 Non-Raid-5 SATA - problem
Date: Wed, 2 May 2007 22:32:39 +1000 (EST)
Message-ID: <343456.16264.qm@web52604.mail.re2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from web52604.mail.re2.yahoo.com ([206.190.48.207]:32270 "HELO
	web52604.mail.re2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1755209AbXEBMk1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 2 May 2007 08:40:27 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hardware:
ASUS M2A-VM (with the latest BIOS - 0402)
AMD AM2
Seagate IDE hard drive & LG IDE DVDRW

All works rather very nicely expect for the SATA :-).

No luck detecting the 2 Seagate ST3250620NS SATA-II
drives (Kernel.org's 2.6.21):
Linux version 2.6.21 (hari@fedora7) (gcc version 4.1.2
20070424 (Red Hat 4.1.2-1
1)) #3 SMP Mon Apr 30 18:49:04 EST 2007
Command line: ro root=LABEL=/1234 rhgb quiet
...
ahci 0000:00:12.0: version 2.1
ACPI: PCI Interrupt 0000:00:12.0[A] -> GSI 22 (level,
low) -> IRQ 22
PM: Adding info for No Bus:timer
sr0: scsi3-mmc drive: 40x/40x writer dvd-ram cd/rw
xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.20
sr 0:0:1:0: Attached scsi CD-ROM sr0
PM: Adding info for No Bus:seq
PM: Adding info for No Bus:sequencer
PM: Adding info for No Bus:sequencer2
ahci 0000:00:12.0: AHCI 0001.0100 32 slots 4 ports 3
Gbps 0xf impl SATA mode
ahci 0000:00:12.0: flags: 64bit ncq ilck pm led clo
pmp pio slum part 
ata3: SATA max UDMA/133 cmd 0xffffc2000006a100 ctl
0x0000000000000000 bmdma 0x00
00000000000000 irq 22
ata4: SATA max UDMA/133 cmd 0xffffc2000006a180 ctl
0x0000000000000000 bmdma 0x00
00000000000000 irq 22
ata5: SATA max UDMA/133 cmd 0xffffc2000006a200 ctl
0x0000000000000000 bmdma 0x00
00000000000000 irq 22
ata6: SATA max UDMA/133 cmd 0xffffc2000006a280 ctl
0x0000000000000000 bmdma 0x00
00000000000000 irq 22
scsi2 : ahci
PM: Adding info for No Bus:host2
ata3: softreset failed (1st FIS failed)
ata3: softreset failed, retrying in 5 secs
ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata3.00: qc timeout (cmd 0xec)
ata3.00: failed to IDENTIFY (I/O error,
err_mask=0x104)
ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata3.00: qc timeout (cmd 0xec)
ata3.00: failed to IDENTIFY (I/O error,
err_mask=0x104)
ata3.00: limiting speed to UDMA7:PIO5
ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata3.00: qc timeout (cmd 0xec)
ata3.00: failed to IDENTIFY (I/O error,
err_mask=0x104)
ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
scsi3 : ahci
PM: Adding info for No Bus:host3
ata4: softreset failed (1st FIS failed)
ata4: softreset failed, retrying in 5 secs
ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata4.00: qc timeout (cmd 0xec)
ata4.00: failed to IDENTIFY (I/O error,
err_mask=0x104)
ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata4.00: qc timeout (cmd 0xec)
ata4.00: failed to IDENTIFY (I/O error,
err_mask=0x104)
ata4.00: limiting speed to UDMA7:PIO5
ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 300)

(curiously irq 22 is exclusive to libata & irq count
is at 0)

(complete dmesg at the bottom of the email)

As was suggested by many folks
(http://marc.info/?l=linux-ide&w=2&r=1&s=SB600+Non-Raid-5+SATA&q=b),
tried various bootup parameters to no avail:
pci=nomsi
acpi=noirq
irqpoll
acpi=off pci=nomsi irqpoll

Also tried changing the BIOS SATA Controller from AHCI
to IDE to RAID to no avail (all observations in this
email captured while it was set was AHCI).

Here's lspci -vvv:
00:12.0 SATA controller: ATI Technologies Inc SB600
Non-Raid-5 SATA (prog-if 01 
[AHCI 1.0])
        Subsystem: ASUSTeK Computer Inc. Unknown
device 8231
        Control: I/O+ Mem+ BusMaster+ SpecCycle-
MemWINV- VGASnoop- ParErr- Step
ping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B- ParErr-
DEVSEL=medium >TAbort- <TAbort
- <MAbort- >SERR- <PERR-
        Latency: 64
        Interrupt: pin A routed to IRQ 22
        Region 0: I/O ports at ff00 [size=8]
        Region 1: I/O ports at fe00 [size=4]
        Region 2: I/O ports at fd00 [size=8]
        Region 3: I/O ports at fc00 [size=4]
        Region 4: I/O ports at fb00 [size=16]
        Region 5: Memory at fe02f000 (32-bit,
non-prefetchable) [size=1K]
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2-
AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot
-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0
PME-
        Capabilities: [70] #12 [0010]

Complete dmesg:
Linux version 2.6.21 (hari@fedora7) (gcc version 4.1.2
20070424 (Red Hat 4.1.2-11)) #3 SMP Mon Apr 30
18:49:04 EST 2007
Command line: ro root=LABEL=/1234 rhgb quiet
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f000
(usable)
 BIOS-e820: 000000000009f000 - 00000000000a0000
(reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000
(reserved)
 BIOS-e820: 0000000000100000 - 00000000dfee0000
(usable)
 BIOS-e820: 00000000dfee0000 - 00000000dfee3000 (ACPI
NVS)
 BIOS-e820: 00000000dfee3000 - 00000000dfef0000 (ACPI
data)
 BIOS-e820: 00000000dfef0000 - 00000000dff00000
(reserved)
 BIOS-e820: 00000000e0000000 - 00000000f0000000
(reserved)
 BIOS-e820: 00000000fec00000 - 0000000100000000
(reserved)
 BIOS-e820: 0000000100000000 - 0000000120000000
(usable)
Entering add_active_range(0, 0, 159) 0 entries of 3200
used
Entering add_active_range(0, 256, 917216) 1 entries of
3200 used
Entering add_active_range(0, 1048576, 1179648) 2
entries of 3200 used
end_pfn_map = 1179648
DMI 2.4 present.
ACPI: RSDP 000F80A0, 0024 (r2 ATI   )
ACPI: XSDT DFEE30C0, 0044 (r1 ATI    ASUSACPI 42302E31
AWRD        0)
ACPI: FACP DFEE83C0, 00F4 (r3 ATI    ASUSACPI 42302E31
AWRD        0)
ACPI: DSDT DFEE3240, 511F (r1 ATI    ASUSACPI     1000
MSFT  3000000)
ACPI: FACS DFEE0000, 0040
ACPI: SSDT DFEE85C0, 02CC (r1 PTLTD  POWERNOW        1
 LTP        1)
ACPI: MCFG DFEE8980, 003C (r1 ATI    ASUSACPI 42302E31
AWRD        0)
ACPI: APIC DFEE8500, 0068 (r1 ATI    ASUSACPI 42302E31
AWRD        0)
Scanning NUMA topology in Northbridge 24
Number of nodes 1
Node 0 MemBase 0000000000000000 Limit 0000000120000000
Entering add_active_range(0, 0, 159) 0 entries of 3200
used
Entering add_active_range(0, 256, 917216) 1 entries of
3200 used
Entering add_active_range(0, 1048576, 1179648) 2
entries of 3200 used
NUMA: Using 63 for the hash shift.
Using node hash shift of 63
Bootmem setup node 0 0000000000000000-0000000120000000
Zone PFN ranges:
  DMA             0 ->     4096
  DMA32        4096 ->  1048576
  Normal    1048576 ->  1179648
early_node_map[3] active PFN ranges
    0:        0 ->      159
    0:      256 ->   917216
    0:  1048576 ->  1179648
On node 0 totalpages: 1048191
  DMA zone: 88 pages used for memmap
  DMA zone: 2218 pages reserved
  DMA zone: 1693 pages, LIFO batch:0
  DMA32 zone: 22440 pages used for memmap
  DMA32 zone: 890680 pages, LIFO batch:31
  Normal zone: 2816 pages used for memmap
  Normal zone: 128256 pages, LIFO batch:31
ATI board detected. Disabling timer routing over 8254.
ACPI: PM-Timer IO Port: 0x4008
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 (Bootup-CPU)
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
Processor #1
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000]
gsi_base[0])
IOAPIC[0]: apic_id 2, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl
dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low
level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Setting APIC routing to physical flat
Using ACPI (MADT) for SMP configuration information
Nosave address range: 000000000009f000 -
00000000000a0000
Nosave address range: 00000000000a0000 -
00000000000f0000
Nosave address range: 00000000000f0000 -
0000000000100000
Nosave address range: 00000000dfee0000 -
00000000dfee3000
Nosave address range: 00000000dfee3000 -
00000000dfef0000
Nosave address range: 00000000dfef0000 -
00000000dff00000
Nosave address range: 00000000dff00000 -
00000000e0000000
Nosave address range: 00000000e0000000 -
00000000f0000000
Nosave address range: 00000000f0000000 -
00000000fec00000
Nosave address range: 00000000fec00000 -
0000000100000000
Allocating PCI resources starting at f1000000 (gap:
f0000000:ec00000)
SMP: Allowing 2 CPUs, 0 hotplug CPUs
PERCPU: Allocating 42048 bytes of per cpu data
Built 1 zonelists.  Total pages: 1020629
Kernel command line: ro root=LABEL=/1234 rhgb quiet
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 32768 bytes)
time.c: Detected 2800.020 MHz processor.
Console: colour VGA+ 80x25
Lock dependency validator: Copyright (c) 2006 Red Hat,
Inc., Ingo Molnar
... MAX_LOCKDEP_SUBCLASSES:    8
... MAX_LOCK_DEPTH:          30
... MAX_LOCKDEP_KEYS:        2048
... CLASSHASH_SIZE:           1024
... MAX_LOCKDEP_ENTRIES:     8192
... MAX_LOCKDEP_CHAINS:      16384
... CHAINHASH_SIZE:          8192
 memory used by lock dependency info: 1648 kB
 per task-struct memory footprint: 1680 bytes
Dentry cache hash table entries: 524288 (order: 10,
4194304 bytes)
Inode-cache hash table entries: 262144 (order: 9,
2097152 bytes)
Checking aperture...
CPU 0: aperture @ 8000000 size 32 MB
Aperture too small (32 MB)
No AGP bridge found
Your BIOS doesn't leave a aperture memory hole
Please enable the IOMMU option in the BIOS setup
This costs you 64 MB of RAM
Mapping aperture over 65536 KB of RAM @ 8000000
Memory: 4018560k/4718592k available (2303k kernel
code, 174204k reserved, 1327k data, 320k init)
Calibrating delay using timer specific routine..
5602.55 BogoMIPS (lpj=2801276)
Security Framework v1.0.0 initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
selinux_register_security:  Registering secondary
module capability
Capability LSM initialized as secondary
Mount-cache hash table entries: 256
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64
bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 0/0 -> Node 0
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 0
lockdep: not fixing up alternatives.
ACPI: Core revision 20070126
Using local APIC timer interrupts.
result 12500100
Detected 12.500 MHz APIC timer.
lockdep: not fixing up alternatives.
Booting processor 1/2 APIC 0x1
Initializing CPU#1
Calibrating delay using timer specific routine..
5598.98 BogoMIPS (lpj=2799494)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64
bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 1/1 -> Node 0
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 1
AMD Athlon(tm) 64 X2 Dual Core Processor 5600+
stepping 03
Brought up 2 CPUs
migration_cost=291
PM: Adding info for No Bus:platform
NET: Registered protocol family 16
PM: Adding info for No Bus:vtcon0
ACPI: bus type pci registered
PCI: Using MMCONFIG at e0000000 - efffffff
PCI: No mmconfig possible on device 00:18
ACPI: Interpreter enabled
ACPI: (supports S0 S1 S3 S4 S5)
ACPI: Using IOAPIC for interrupt routing
PM: Adding info for acpi:acpi_system:00
PM: Adding info for acpi:button_power:00
PM: Adding info for acpi:ACPI0007:00
PM: Adding info for acpi:ACPI0007:01
PM: Adding info for acpi:device:00
PM: Adding info for acpi:PNP0C0C:00
PM: Adding info for acpi:PNP0A03:00
PM: Adding info for acpi:device:01
PM: Adding info for acpi:device:02
PM: Adding info for acpi:device:03
PM: Adding info for acpi:device:04
PM: Adding info for acpi:device:05
PM: Adding info for acpi:device:06
PM: Adding info for acpi:device:07
PM: Adding info for acpi:device:08
PM: Adding info for acpi:device:09
PM: Adding info for acpi:PNP0C02:00
PM: Adding info for acpi:PNP0C0F:00
PM: Adding info for acpi:PNP0C0F:01
PM: Adding info for acpi:PNP0C0F:02
PM: Adding info for acpi:PNP0C0F:03
PM: Adding info for acpi:PNP0C0F:04
PM: Adding info for acpi:PNP0C0F:05
PM: Adding info for acpi:PNP0C0F:06
PM: Adding info for acpi:PNP0C0F:07
PM: Adding info for acpi:PNP0000:00
PM: Adding info for acpi:PNP0200:00
PM: Adding info for acpi:PNP0100:00
PM: Adding info for acpi:PNP0B00:00
PM: Adding info for acpi:PNP0800:00
PM: Adding info for acpi:PNP0C04:00
PM: Adding info for acpi:device:0a
PM: Adding info for acpi:device:0b
PM: Adding info for acpi:device:0c
PM: Adding info for acpi:device:0d
PM: Adding info for acpi:device:0e
PM: Adding info for acpi:device:0f
PM: Adding info for acpi:device:10
PM: Adding info for acpi:device:11
PM: Adding info for acpi:device:12
PM: Adding info for acpi:device:13
PM: Adding info for acpi:device:14
PM: Adding info for acpi:device:15
PM: Adding info for acpi:device:16
PM: Adding info for acpi:device:17
PM: Adding info for acpi:device:18
PM: Adding info for acpi:device:19
PM: Adding info for acpi:device:1a
PM: Adding info for acpi:device:1b
PM: Adding info for acpi:device:1c
PM: Adding info for acpi:PNP0C02:01
PM: Adding info for acpi:PNP0700:00
PM: Adding info for acpi:PNP0303:00
PM: Adding info for acpi:ATK0110:00
PM: Adding info for acpi:device:1d
PM: Adding info for acpi:PNP0C02:02
PM: Adding info for acpi:PNP0C01:00
PM: Adding info for acpi:thermal:00
PM: Adding info for acpi:PNP0C0B:00
PM: Adding info for acpi:thermal:01
PM: Adding info for acpi:AWY0001:00
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
PM: Adding info for No Bus:pci0000:00
Boot video device is 0000:01:00.0
PCI: Transparent bridge - 0000:00:14.4
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table
[\_SB_.PCI0.P2P_._PRT]
ACPI: PCI Interrupt Routing Table
[\_SB_.PCI0.PCE2._PRT]
ACPI: PCI Interrupt Routing Table
[\_SB_.PCI0.PCE7._PRT]
PM: Adding info for pci:0000:00:00.0
PM: Adding info for pci:0000:00:02.0
PM: Adding info for pci:0000:00:07.0
PM: Adding info for pci:0000:00:12.0
PM: Adding info for pci:0000:00:13.0
PM: Adding info for pci:0000:00:13.1
PM: Adding info for pci:0000:00:13.2
PM: Adding info for pci:0000:00:13.3
PM: Adding info for pci:0000:00:13.4
PM: Adding info for pci:0000:00:13.5
PM: Adding info for pci:0000:00:14.0
PM: Adding info for pci:0000:00:14.1
PM: Adding info for pci:0000:00:14.2
PM: Adding info for pci:0000:00:14.3
PM: Adding info for pci:0000:00:14.4
PM: Adding info for pci:0000:00:18.0
PM: Adding info for pci:0000:00:18.1
PM: Adding info for pci:0000:00:18.2
PM: Adding info for pci:0000:00:18.3
PM: Adding info for pci:0000:01:00.0
PM: Adding info for pci:0000:01:00.1
PM: Adding info for pci:0000:02:00.0
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 11)
*0, disabled.
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 10 11)
*0, disabled.
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 10 11)
*0, disabled.
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 10 11)
*0, disabled.
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 10 11)
*0, disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 10 11)
*0, disabled.
ACPI: PCI Interrupt Link [LNK0] (IRQs 3 4 5 6 7 10
*11)
ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 5 6 7 10 11)
*0, disabled.
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
PM: Adding info for No Bus:pnp0
PM: Adding info for pnp:00:00
PM: Adding info for pnp:00:01
PM: Adding info for pnp:00:02
PM: Adding info for pnp:00:03
PM: Adding info for pnp:00:04
PM: Adding info for pnp:00:05
PM: Adding info for pnp:00:06
PM: Adding info for pnp:00:07
PM: Adding info for pnp:00:08
PM: Adding info for pnp:00:09
PM: Adding info for pnp:00:0a
pnp: PnP ACPI: found 11 devices
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If
it helps, post a report
NetLabel: Initializing
NetLabel:  domain hash size = 128
NetLabel:  protocols = UNLABELED CIPSOv4
NetLabel:  unlabeled traffic allowed by default
PCI-DMA: Disabling AGP.
PCI-DMA: aperture base @ 8000000 size 65536 KB
PCI-DMA: using GART IOMMU.
PCI-DMA: Reserving 64MB of IOMMU area in the AGP
aperture
pnp: 00:01: ioport range 0x4100-0x411f has been
reserved
pnp: 00:01: ioport range 0x228-0x22f has been reserved
pnp: 00:01: ioport range 0x40b-0x40b has been reserved
pnp: 00:01: ioport range 0x4d6-0x4d6 has been reserved
pnp: 00:01: ioport range 0xc00-0xc01 has been reserved
pnp: 00:01: ioport range 0xc14-0xc14 has been reserved
pnp: 00:01: ioport range 0xc50-0xc52 has been reserved
pnp: 00:01: ioport range 0xc6c-0xc6d has been reserved
pnp: 00:09: iomem range 0xe0000000-0xefffffff could
not be reserved
pnp: 00:0a: iomem range 0xf0000-0xf3fff could not be
reserved
pnp: 00:0a: iomem range 0xf4000-0xf7fff could not be
reserved
pnp: 00:0a: iomem range 0xf8000-0xfbfff could not be
reserved
pnp: 00:0a: iomem range 0xfc000-0xfffff could not be
reserved
PM: Adding info for No Bus:mem
PM: Adding info for No Bus:kmem
PM: Adding info for No Bus:null
PM: Adding info for No Bus:port
PM: Adding info for No Bus:zero
PM: Adding info for No Bus:full
PM: Adding info for No Bus:random
PM: Adding info for No Bus:urandom
PM: Adding info for No Bus:kmsg
PCI: Bridge: 0000:00:02.0
  IO window: d000-dfff
  MEM window: fdc00000-fdcfffff
  PREFETCH window: f0000000-f7ffffff
PCI: Bridge: 0000:00:07.0
  IO window: e000-efff
  MEM window: fdb00000-fdbfffff
  PREFETCH window: fdf00000-fdffffff
PCI: Bridge: 0000:00:14.4
  IO window: c000-cfff
  MEM window: fde00000-fdefffff
  PREFETCH window: fdd00000-fddfffff
PCI: Setting latency timer of device 0000:00:02.0 to
64
PCI: Setting latency timer of device 0000:00:07.0 to
64
NET: Registered protocol family 2
Time: acpi_pm clocksource has been installed.
IP route cache hash table entries: 131072 (order: 8,
1048576 bytes)
TCP established hash table entries: 65536 (order: 10,
4194304 bytes)
TCP bind hash table entries: 65536 (order: 9, 3670016
bytes)
TCP: Hash tables configured (established 65536 bind
65536)
TCP reno registered
checking if image is initramfs... it is
Freeing initrd memory: 3034k freed
PM: Adding info for No Bus:mcelog
PM: Adding info for No Bus:msr0
PM: Adding info for No Bus:msr1
PM: Adding info for No Bus:cpu0
PM: Adding info for No Bus:cpu1
PM: Adding info for platform:pcspkr
PM: Adding info for No Bus:snapshot
audit: initializing netlink socket (disabled)
audit(1178106805.029:1): initialized
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 512 (order 0, 4096
bytes)
SELinux:  Registering netfilter hooks
io scheduler noop registered
io scheduler cfq registered (default)
PCI: Setting latency timer of device 0000:00:02.0 to
64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:02.0:pcie00]
PM: Adding info for pci_express:0000:00:02.0:pcie00
Allocate Port Service[0000:00:02.0:pcie03]
PM: Adding info for pci_express:0000:00:02.0:pcie03
PCI: Setting latency timer of device 0000:00:07.0 to
64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:07.0:pcie00]
PM: Adding info for pci_express:0000:00:07.0:pcie00
Allocate Port Service[0000:00:07.0:pcie03]
PM: Adding info for pci_express:0000:00:07.0:pcie03
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
PM: Adding info for platform:vesafb.0
ACPI: Fan [FAN] (on)
ACPI: Thermal Zone [THRM] (40 C)
PM: Adding info for No Bus:tty
PM: Adding info for No Bus:console
PM: Adding info for No Bus:ptmx
PM: Adding info for No Bus:tty0
PM: Adding info for No Bus:vcs
PM: Adding info for No Bus:vcsa
PM: Adding info for No Bus:tty1
PM: Adding info for No Bus:tty2
PM: Adding info for No Bus:tty3
PM: Adding info for No Bus:tty4
PM: Adding info for No Bus:tty5
PM: Adding info for No Bus:tty6
PM: Adding info for No Bus:tty7
PM: Adding info for No Bus:tty8
PM: Adding info for No Bus:tty9
PM: Adding info for No Bus:tty10
PM: Adding info for No Bus:tty11
PM: Adding info for No Bus:tty12
PM: Adding info for No Bus:tty13
PM: Adding info for No Bus:tty14
PM: Adding info for No Bus:tty15
PM: Adding info for No Bus:tty16
PM: Adding info for No Bus:tty17
PM: Adding info for No Bus:tty18
PM: Adding info for No Bus:tty19
PM: Adding info for No Bus:tty20
PM: Adding info for No Bus:tty21
PM: Adding info for No Bus:tty22
PM: Adding info for No Bus:tty23
PM: Adding info for No Bus:tty24
PM: Adding info for No Bus:tty25
PM: Adding info for No Bus:tty26
PM: Adding info for No Bus:tty27
PM: Adding info for No Bus:tty28
PM: Adding info for No Bus:tty29
PM: Adding info for No Bus:tty30
PM: Adding info for No Bus:tty31
PM: Adding info for No Bus:tty32
PM: Adding info for No Bus:tty33
PM: Adding info for No Bus:tty34
PM: Adding info for No Bus:tty35
PM: Adding info for No Bus:tty36
PM: Adding info for No Bus:tty37
PM: Adding info for No Bus:tty38
PM: Adding info for No Bus:tty39
PM: Adding info for No Bus:tty40
PM: Adding info for No Bus:tty41
PM: Adding info for No Bus:tty42
PM: Adding info for No Bus:tty43
PM: Adding info for No Bus:tty44
PM: Adding info for No Bus:tty45
PM: Adding info for No Bus:tty46
PM: Adding info for No Bus:tty47
PM: Adding info for No Bus:tty48
PM: Adding info for No Bus:tty49
PM: Adding info for No Bus:tty50
PM: Adding info for No Bus:tty51
PM: Adding info for No Bus:tty52
PM: Adding info for No Bus:tty53
PM: Adding info for No Bus:tty54
PM: Adding info for No Bus:tty55
PM: Adding info for No Bus:tty56
PM: Adding info for No Bus:tty57
PM: Adding info for No Bus:tty58
PM: Adding info for No Bus:tty59
PM: Adding info for No Bus:tty60
PM: Adding info for No Bus:tty61
PM: Adding info for No Bus:tty62
PM: Adding info for No Bus:tty63
PM: Adding info for No Bus:rtc
Real Time Clock Driver v1.12ac
PM: Adding info for No Bus:hpet
PM: Adding info for No Bus:nvram
Non-volatile memory driver v1.2
Linux agpgart interface v0.102 (c) Dave Jones
Serial: 8250/16550 driver $Revision: 1.90 $ 2 ports,
IRQ sharing enabled
PM: Adding info for platform:serial8250
PM: Adding info for No Bus:ttyS0
PM: Adding info for No Bus:ttyS1
RAMDISK driver initialized: 16 RAM disks of 16384K
size 4096 blocksize
PM: Adding info for No Bus:lo
usbcore: registered new interface driver libusual
usbcore: registered new interface driver hiddev
usbcore: registered new interface driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
PNP: PS/2 Controller [PNP0303:PS2K] at 0x60,0x64 irq 1
PNP: PS/2 controller doesn't have AUX irq; using
default 12
PM: Adding info for platform:i8042
serio: i8042 KBD port at 0x60,0x64 irq 1
serio: i8042 AUX port at 0x60,0x64 irq 12
PM: Adding info for serio:serio0
mice: PS/2 mouse device common for all mice
TCP bic registered
Initializing XFRM netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
powernow-k8: Found 2 AMD Athlon(tm) 64 X2 Dual Core
Processor 5600+ processors (version 2.00.00)
powernow-k8:    0 : fid 0x14 (2800 MHz), vid 0x8
powernow-k8:    1 : fid 0x12 (2600 MHz), vid 0xa
powernow-k8:    2 : fid 0x10 (2400 MHz), vid 0xc
powernow-k8:    3 : fid 0xe (2200 MHz), vid 0xe
powernow-k8:    4 : fid 0xc (2000 MHz), vid 0x10
powernow-k8:    5 : fid 0xa (1800 MHz), vid 0x10
powernow-k8:    6 : fid 0x2 (1000 MHz), vid 0x12
Freeing unused kernel memory: 320k freed
Write protecting the kernel read-only data: 993k
PM: Adding info for No Bus:vcs1
PM: Adding info for No Bus:vcsa1
input: AT Translated Set 2 keyboard as
/class/input/input0
PM: Adding info for serio:serio1
ohci_hcd: 2006 August 04 USB 1.1 'Open' Host
Controller (OHCI) Driver
ACPI: PCI Interrupt 0000:00:13.0[A] -> GSI 16 (level,
low) -> IRQ 16
ohci_hcd 0000:00:13.0: OHCI Host Controller
ohci_hcd 0000:00:13.0: new USB bus registered,
assigned bus number 1
ohci_hcd 0000:00:13.0: irq 16, io mem 0xfe02e000
PM: Adding info for usb:usb1
PM: Adding info for No Bus:usbdev1.1_ep00
usb usb1: configuration #1 chosen from 1 choice
PM: Adding info for usb:1-0:1.0
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
PM: Adding info for No Bus:usbdev1.1_ep81
PM: Adding info for No Bus:usbdev1.1
ACPI: PCI Interrupt 0000:00:13.1[B] -> GSI 17 (level,
low) -> IRQ 17
ohci_hcd 0000:00:13.1: OHCI Host Controller
ohci_hcd 0000:00:13.1: new USB bus registered,
assigned bus number 2
ohci_hcd 0000:00:13.1: irq 17, io mem 0xfe02d000
PM: Adding info for usb:usb2
PM: Adding info for No Bus:usbdev2.1_ep00
usb usb2: configuration #1 chosen from 1 choice
PM: Adding info for usb:2-0:1.0
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
PM: Adding info for No Bus:usbdev2.1_ep81
PM: Adding info for No Bus:usbdev2.1
ACPI: PCI Interrupt 0000:00:13.2[C] -> GSI 18 (level,
low) -> IRQ 18
ohci_hcd 0000:00:13.2: OHCI Host Controller
ohci_hcd 0000:00:13.2: new USB bus registered,
assigned bus number 3
ohci_hcd 0000:00:13.2: irq 18, io mem 0xfe02c000
PM: Adding info for usb:usb3
PM: Adding info for No Bus:usbdev3.1_ep00
usb usb3: configuration #1 chosen from 1 choice
PM: Adding info for usb:3-0:1.0
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
PM: Adding info for No Bus:usbdev3.1_ep81
PM: Adding info for No Bus:usbdev3.1
ACPI: PCI Interrupt 0000:00:13.3[B] -> GSI 17 (level,
low) -> IRQ 17
ohci_hcd 0000:00:13.3: OHCI Host Controller
ohci_hcd 0000:00:13.3: new USB bus registered,
assigned bus number 4
ohci_hcd 0000:00:13.3: irq 17, io mem 0xfe02b000
PM: Adding info for usb:usb4
PM: Adding info for No Bus:usbdev4.1_ep00
usb usb4: configuration #1 chosen from 1 choice
PM: Adding info for usb:4-0:1.0
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
usb 2-1: new low speed USB device using ohci_hcd and
address 2
PM: Adding info for No Bus:usbdev4.1_ep81
PM: Adding info for No Bus:usbdev4.1
ACPI: PCI Interrupt 0000:00:13.4[C] -> GSI 18 (level,
low) -> IRQ 18
ohci_hcd 0000:00:13.4: OHCI Host Controller
ohci_hcd 0000:00:13.4: new USB bus registered,
assigned bus number 5
ohci_hcd 0000:00:13.4: irq 18, io mem 0xfe02a000
PM: Adding info for usb:2-1
PM: Adding info for No Bus:usbdev2.2_ep00
usb 2-1: configuration #1 chosen from 1 choice
PM: Adding info for usb:2-1:1.0
PM: Adding info for usb:usb5
PM: Adding info for No Bus:usbdev5.1_ep00
usb usb5: configuration #1 chosen from 1 choice
PM: Adding info for usb:5-0:1.0
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 2 ports detected
input: Logitech USB Receiver as /class/input/input1
input: USB HID v1.10 Keyboard [Logitech USB Receiver]
on usb-0000:00:13.1-1
PM: Adding info for No Bus:usbdev2.2_ep81
PM: Adding info for usb:2-1:1.1
drivers/usb/input/hid-core.c: Fixing up Logitech S510
report descriptor
input: Logitech USB Receiver as /class/input/input2
PM: Adding info for No Bus:hiddev0
input,hiddev96: USB HID v1.10 Mouse [Logitech USB
Receiver] on usb-0000:00:13.1-1
PM: Adding info for No Bus:usbdev2.2_ep82
PM: Adding info for No Bus:usbdev2.2
PM: Adding info for No Bus:usbdev5.1_ep81
PM: Adding info for No Bus:usbdev5.1
ACPI: PCI Interrupt 0000:00:13.5[D] -> GSI 19 (level,
low) -> IRQ 19
ehci_hcd 0000:00:13.5: EHCI Host Controller
ehci_hcd 0000:00:13.5: new USB bus registered,
assigned bus number 6
ehci_hcd 0000:00:13.5: debug port 1
ehci_hcd 0000:00:13.5: irq 19, io mem 0xfe029000
ehci_hcd 0000:00:13.5: USB 2.0 started, EHCI 1.00,
driver 10 Dec 2004
PM: Adding info for usb:usb6
PM: Adding info for No Bus:usbdev6.1_ep00
usb usb6: configuration #1 chosen from 1 choice
PM: Adding info for usb:6-0:1.0
hub 6-0:1.0: USB hub found
hub 6-0:1.0: 10 ports detected
PM: Adding info for No Bus:usbdev6.1_ep81
PM: Adding info for No Bus:usbdev6.1
SCSI subsystem initialized
libata version 2.20 loaded.
ACPI: PCI Interrupt 0000:00:14.1[A] -> GSI 16 (level,
low) -> IRQ 16
ata1: PATA max UDMA/100 cmd 0x00000000000101f0 ctl
0x00000000000103f6 bmdma 0x000000000001f900 irq 14
ata2: PATA max UDMA/100 cmd 0x0000000000010170 ctl
0x0000000000010376 bmdma 0x000000000001f908 irq 15
scsi0 : pata_atiixp
PM: Adding info for No Bus:host0
usb 2-1: USB disconnect, address 2
PM: Removing info for No Bus:usbdev2.2_ep81
PM: Removing info for usb:2-1:1.0
PM: Removing info for No Bus:usbdev2.2_ep82
PM: Removing info for No Bus:hiddev0
PM: Removing info for usb:2-1:1.1
PM: Removing info for No Bus:usbdev2.2
PM: Removing info for No Bus:usbdev2.2_ep00
PM: Removing info for usb:2-1
usb 2-1: new low speed USB device using ohci_hcd and
address 3
ata1.00: ATA-6: ST3120026A, 3.06, max UDMA/100
ata1.00: 234435439 sectors, multi 1: LBA48 
ata1.01: ATAPI, max UDMA/33
ata1.00: configured for UDMA/100
PM: Adding info for usb:2-1
PM: Adding info for No Bus:usbdev2.3_ep00
usb 2-1: configuration #1 chosen from 1 choice
PM: Adding info for usb:2-1:1.0
input: Logitech USB Receiver as /class/input/input3
input: USB HID v1.10 Keyboard [Logitech USB Receiver]
on usb-0000:00:13.1-1
PM: Adding info for No Bus:usbdev2.3_ep81
PM: Adding info for usb:2-1:1.1
drivers/usb/input/hid-core.c: Fixing up Logitech S510
report descriptor
input: Logitech USB Receiver as /class/input/input4
PM: Adding info for No Bus:hiddev0
input,hiddev96: USB HID v1.10 Mouse [Logitech USB
Receiver] on usb-0000:00:13.1-1
PM: Adding info for No Bus:usbdev2.3_ep82
PM: Adding info for No Bus:usbdev2.3
ata1.01: configured for UDMA/33
scsi1 : pata_atiixp
PM: Adding info for No Bus:host1
PM: Adding info for No Bus:target0:0:0
scsi 0:0:0:0: Direct-Access     ATA      ST3120026A   
   3.06 PQ: 0 ANSI: 5
PM: Adding info for scsi:0:0:0:0
SCSI device sda: 234435439 512-byte hdwr sectors
(120031 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: write cache: enabled, read cache:
enabled, doesn't support DPO or FUA
SCSI device sda: 234435439 512-byte hdwr sectors
(120031 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: write cache: enabled, read cache:
enabled, doesn't support DPO or FUA
 sda: sda1 sda2 sda3 sda4 < sda5 sda6 sda7 sda8 sda9
sda10 sda11 sda12 sda13 sda14 >
sd 0:0:0:0: Attached scsi disk sda
PM: Adding info for No Bus:target0:0:1
scsi 0:0:1:0: CD-ROM            HL-DT-ST DVDRAM
GSA-4163B A102 PQ: 0 ANSI: 5
PM: Adding info for scsi:0:0:1:0
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
audit(1178106810.695:2): enforcing=1 old_enforcing=0
auid=4294967295
security:  3 users, 6 roles, 1801 types, 76 bools, 1
sens, 1024 cats
security:  60 classes, 65047 rules
SELinux:  Completing initialization.
SELinux:  Setting up existing superblocks.
SELinux: initialized (dev sda1, type ext3), uses xattr
SELinux: initialized (dev usbfs, type usbfs), uses
genfs_contexts
SELinux: initialized (dev tmpfs, type tmpfs), uses
transition SIDs
SELinux: initialized (dev debugfs, type debugfs), uses
genfs_contexts
SELinux: initialized (dev selinuxfs, type selinuxfs),
uses genfs_contexts
SELinux: initialized (dev mqueue, type mqueue), uses
transition SIDs
SELinux: initialized (dev hugetlbfs, type hugetlbfs),
uses genfs_contexts
SELinux: initialized (dev devpts, type devpts), uses
transition SIDs
SELinux: initialized (dev eventpollfs, type
eventpollfs), uses task SIDs
SELinux: initialized (dev inotifyfs, type inotifyfs),
uses genfs_contexts
SELinux: initialized (dev tmpfs, type tmpfs), uses
transition SIDs
SELinux: initialized (dev futexfs, type futexfs), uses
genfs_contexts
SELinux: initialized (dev pipefs, type pipefs), uses
task SIDs
SELinux: initialized (dev sockfs, type sockfs), uses
task SIDs
SELinux: initialized (dev cpuset, type cpuset), uses
genfs_contexts
SELinux: initialized (dev proc, type proc), uses
genfs_contexts
SELinux: initialized (dev bdev, type bdev), uses
genfs_contexts
SELinux: initialized (dev rootfs, type rootfs), uses
genfs_contexts
SELinux: initialized (dev sysfs, type sysfs), uses
genfs_contexts
audit(1178106810.987:3): policy loaded auid=4294967295
PM: Removing info for No Bus:vcs1
PM: Removing info for No Bus:vcsa1
PM: Adding info for No Bus:vcs1
PM: Adding info for No Bus:vcsa1
PM: Removing info for No Bus:vcs1
PM: Removing info for No Bus:vcsa1
PM: Adding info for No Bus:vcs1
PM: Adding info for No Bus:vcsa1
sd 0:0:0:0: Attached scsi generic sg0 type 0
scsi 0:0:1:0: Attached scsi generic sg1 type 5
input: PC Speaker as /class/input/input5
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
PM: Adding info for platform:floppy.0
rtc_cmos 00:03: rtc core: registered rtc_cmos as rtc0
rtc_cmos: probe of 00:03 failed with error -16
ahci 0000:00:12.0: version 2.1
ACPI: PCI Interrupt 0000:00:12.0[A] -> GSI 22 (level,
low) -> IRQ 22
PM: Adding info for No Bus:timer
sr0: scsi3-mmc drive: 40x/40x writer dvd-ram cd/rw
xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.20
sr 0:0:1:0: Attached scsi CD-ROM sr0
PM: Adding info for No Bus:seq
PM: Adding info for No Bus:sequencer
PM: Adding info for No Bus:sequencer2
ahci 0000:00:12.0: AHCI 0001.0100 32 slots 4 ports 3
Gbps 0xf impl SATA mode
ahci 0000:00:12.0: flags: 64bit ncq ilck pm led clo
pmp pio slum part 
ata3: SATA max UDMA/133 cmd 0xffffc2000006a100 ctl
0x0000000000000000 bmdma 0x0000000000000000 irq 22
ata4: SATA max UDMA/133 cmd 0xffffc2000006a180 ctl
0x0000000000000000 bmdma 0x0000000000000000 irq 22
ata5: SATA max UDMA/133 cmd 0xffffc2000006a200 ctl
0x0000000000000000 bmdma 0x0000000000000000 irq 22
ata6: SATA max UDMA/133 cmd 0xffffc2000006a280 ctl
0x0000000000000000 bmdma 0x0000000000000000 irq 22
scsi2 : ahci
PM: Adding info for No Bus:host2
ata3: softreset failed (1st FIS failed)
ata3: softreset failed, retrying in 5 secs
ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata3.00: qc timeout (cmd 0xec)
ata3.00: failed to IDENTIFY (I/O error,
err_mask=0x104)
ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata3.00: qc timeout (cmd 0xec)
ata3.00: failed to IDENTIFY (I/O error,
err_mask=0x104)
ata3.00: limiting speed to UDMA7:PIO5
ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata3.00: qc timeout (cmd 0xec)
ata3.00: failed to IDENTIFY (I/O error,
err_mask=0x104)
ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
scsi3 : ahci
PM: Adding info for No Bus:host3
ata4: softreset failed (1st FIS failed)
ata4: softreset failed, retrying in 5 secs
ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata4.00: qc timeout (cmd 0xec)
ata4.00: failed to IDENTIFY (I/O error,
err_mask=0x104)
ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata4.00: qc timeout (cmd 0xec)
ata4.00: failed to IDENTIFY (I/O error,
err_mask=0x104)
ata4.00: limiting speed to UDMA7:PIO5
ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
SELinux: initialized (dev kvmfs, type kvmfs), uses
genfs_contexts
PM: Adding info for No Bus:kvm
loop: loaded (max 8 devices)
SELinux: initialized (dev ramfs, type ramfs), uses
genfs_contexts
PM: Adding info for No Bus:vcs8
PM: Adding info for No Bus:vcsa8
PM: Removing info for No Bus:vcs8
PM: Removing info for No Bus:vcsa8
PM: Adding info for No Bus:vcs8
PM: Adding info for No Bus:vcsa8
PM: Removing info for No Bus:vcs8
PM: Removing info for No Bus:vcsa8
PM: Adding info for No Bus:vcs8
PM: Adding info for No Bus:vcsa8
ACPI: PCI Interrupt 0000:01:00.0[A] -> GSI 18 (level,
low) -> IRQ 18
[drm] Initialized drm 1.1.0 20060810
[drm] Initialized radeon 1.25.0 20060524 on minor 0
No dock devices found.
input: Power Button (FF) as /class/input/input6
ACPI: Power Button (FF) [PWRF]
input: Power Button (CM) as /class/input/input7
ACPI: Power Button (CM) [PWRB]
ibm_acpi: ec object not found
PM: Adding info for No Bus:device-mapper
device-mapper: ioctl: 4.11.0-ioctl (2006-10-12)
initialised: dm-devel@redhat.com
EXT3 FS on sda1, internal journal
SELinux: initialized (dev tmpfs, type tmpfs), uses
transition SIDs
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda12, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
SELinux: initialized (dev sda12, type ext3), uses
xattr
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda14, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
SELinux: initialized (dev sda14, type ext3), uses
xattr
audit(1178107008.787:4): avc:  denied  { read } for 
pid=1381 comm="mount" name="ubuntu-7.04-dvd-i386.iso"
dev=sda12 ino=1896840
scontext=system_u:system_r:mount_t:s0
tcontext=user_u:object_r:public_content_t:s0
tclass=file
Adding 1052216k swap on /dev/sda9.  Priority:-1
extents:1 across:1052216k
SELinux: initialized (dev binfmt_misc, type
binfmt_misc), uses genfs_contexts
PM: Removing info for No Bus:vcs1
PM: Removing info for No Bus:vcsa1
ata4.00: qc timeout (cmd 0xec)
ata4.00: failed to IDENTIFY (I/O error,
err_mask=0x104)
audit(1178107014.226:5): audit_pid=1685 old=0 by
auid=4294967295 subj=system_u:system_r:auditd_t:s0
ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
scsi4 : ahci
PM: Adding info for No Bus:host4
ata5: SATA link down (SStatus 0 SControl 300)
scsi5 : ahci
PM: Adding info for No Bus:host5
ata6: SATA link down (SStatus 0 SControl 300)
ACPI: PCI Interrupt 0000:00:14.2[A] -> GSI 16 (level,
low) -> IRQ 16
hda_codec: Unknown model for ALC883, trying auto-probe
from BIOS...
PM: Adding info for No Bus:pcmC0D2c
PM: Adding info for No Bus:pcmC0D1p
PM: Adding info for No Bus:adsp
PM: Adding info for No Bus:pcmC0D0p
PM: Adding info for No Bus:pcmC0D0c
PM: Adding info for No Bus:dsp
PM: Adding info for No Bus:audio
PM: Adding info for No Bus:controlC0
PM: Adding info for No Bus:mixer
r8169 Gigabit Ethernet driver 2.2LK-NAPI loaded
ACPI: PCI Interrupt 0000:02:00.0[A] -> GSI 19 (level,
low) -> IRQ 19
PCI: Setting latency timer of device 0000:02:00.0 to
64
PM: Adding info for No Bus:eth0
eth0: RTL8168b/8111b at 0xffffc20010104000,
00:1a:92:6f:e9:d5, IRQ 19
shpchp: Standard Hot Plug PCI Controller Driver
version: 0.4
r8169: eth0: link down
r8169: eth0: link down
r8169: eth0: link up
SELinux: initialized (dev rpc_pipefs, type
rpc_pipefs), uses genfs_contexts
SELinux: initialized (dev autofs, type autofs), uses
genfs_contexts
SELinux: initialized (dev autofs, type autofs), uses
genfs_contexts
SELinux: initialized (dev autofs, type autofs), uses
genfs_contexts
Bridge firewalling registered
PM: Adding info for No Bus:vnet0
ip_tables: (C) 2000-2006 Netfilter Core Team
Netfilter messages via NETLINK v0.30.
nf_conntrack version 0.5.0 (8192 buckets, 65536 max)
PM: Adding info for No Bus:vcs1
PM: Adding info for No Bus:vcs3
PM: Adding info for No Bus:vcsa3
PM: Removing info for No Bus:vcs3
PM: Removing info for No Bus:vcsa3
PM: Adding info for No Bus:vcs3
PM: Adding info for No Bus:vcsa3
PM: Adding info for No Bus:vcs6
PM: Adding info for No Bus:vcsa6
PM: Removing info for No Bus:vcs6
PM: Removing info for No Bus:vcsa6
PM: Adding info for No Bus:vcs6
PM: Adding info for No Bus:vcsa6
PM: Adding info for No Bus:vcsa1
PM: Removing info for No Bus:vcs1
PM: Removing info for No Bus:vcsa1
PM: Adding info for No Bus:vcs1
PM: Adding info for No Bus:vcsa1
PM: Adding info for No Bus:vcs2
PM: Adding info for No Bus:vcsa2
PM: Removing info for No Bus:vcs2
PM: Removing info for No Bus:vcsa2
PM: Adding info for No Bus:vcs2
PM: Adding info for No Bus:vcsa2
PM: Adding info for No Bus:vcs4
PM: Adding info for No Bus:vcsa4
PM: Removing info for No Bus:vcs4
PM: Removing info for No Bus:vcsa4
PM: Adding info for No Bus:vcs4
PM: Adding info for No Bus:vcsa4
PM: Adding info for No Bus:vcs5
PM: Adding info for No Bus:vcsa5
PM: Removing info for No Bus:vcs5
PM: Removing info for No Bus:vcsa5
PM: Adding info for No Bus:vcs5
PM: Adding info for No Bus:vcsa5
PM: Adding info for No Bus:vcs7
PM: Adding info for No Bus:vcsa7
PM: Removing info for No Bus:vcs7
PM: Removing info for No Bus:vcsa7
PM: Adding info for No Bus:vcs7
PM: Adding info for No Bus:vcsa7
[drm] Setting GART location based on new memory map
[drm] Loading R300 Microcode
[drm] writeback test succeeded in 1 usecs
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda8, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
SELinux: initialized (dev sda8, type ext3), uses xattr

I see Linus's post 2.6.21 git tree has been updated
with many SATA updates, not sure whether it'd help.

(Incidentally, while 2.6.20 is fine, starting 2.6.21,
enabling hpet leads to a solid hang. Having got round
to reporting it to LKML. Will do that later on.
Perhaps an indication AMD690G chipset, ASUS AM2-VM or
BIOS or all of them are badly broken??)

Thanks
Hari


Send instant messages to your online friends http://au.messenger.yahoo.com 
