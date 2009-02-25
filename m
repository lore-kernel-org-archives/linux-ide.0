From: Chuck Ebbert <cebbert@redhat.com>
Subject: Re: ahci fails with SATA DVD drive, IDE mode works
Date: Wed, 25 Feb 2009 18:15:30 -0500
Message-ID: <20090225181530.1c575a30@dhcp-100-2-144.bos.redhat.com>
References: <20090211174558.505354fe@dhcp-100-2-144.bos.redhat.com>
	<499D2202.7070503@kernel.org>
	<20090221181705.0b5f9ed3@dhcp-100-2-144.bos.redhat.com>
	<49A4DFD4.3030206@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx2.redhat.com ([66.187.237.31]:55811 "EHLO mx2.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756616AbZBYXPo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 25 Feb 2009 18:15:44 -0500
In-Reply-To: <49A4DFD4.3030206@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org

On Wed, 25 Feb 2009 15:06:12 +0900
Tejun Heo <tj@kernel.org> wrote:

> Hello,
>=20
> Chuck Ebbert wrote:
> > I don't have another drive like this one, but maybe can borrow one =
on
> > Monday (it's a SATA notebook drive.) I did get the other informatio=
n
> > though.
>=20
> How did it go?
>=20

I found another machine with the same chipset and a different ATAPI SAT=
A
drive; that one works okay in ahci mode.

> > Looking in the kernel log, I saw this after running hdparm -I:
> >=20
> > ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
> > ata2.00: cmd a0/01:00:00:00:02/00:00:00:00:00/a0 tag 0 dma 512 in
> >          cdb a1 08 2e 00 00 00 00 00  40 ec 00 00 00 00 00 00
> >          res 40/00:02:00:08:00/00:00:00:00:00/a0 Emask 0x4 (timeout=
)
> > ata2.00: status: { DRDY }
> > ata2: hard resetting link
> > ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> > ata2.00: configured for MWDMA2
> > ata2: EH complete
> >=20
> > And after that the drive was inaccessible, filling the log with
> > these messages:
> >=20
> > end_request: I/O error, dev sr0, sector 153612
> > sr 1:0:0:0: [sr0] Result: hostbyte=3DDID_OK driverbyte=3DDRIVER_SEN=
SE,SUGGEST_OK
> > sr 1:0:0:0: [sr0] Sense Key : Illegal Request [current].
> > sr 1:0:0:0: [sr0] Add. Sense: Logical block address out of range
>=20
> Hmmm... Can you please post full kernel log including the booting
> part?  There gotta be other errors before the driver gives up on the
> device.  Strange.

There are no messages at all between "EH complete" and the string of SC=
SI
error messages:

Initializing cgroup subsys cpuset
Initializing cgroup subsys cpu
Linux version 2.6.29-0.148.rc6.fc11.x86_64 (mockbuild@x86-6.fedora.phx.=
redhat.com) (gcc version 4.4.0 20090219 (Red Hat 4.4.0-0.21) (GCC) ) #1=
 SMP Tue Feb 24 10:36:50 EST 2009
Command line: ro root=3DUUID=3D761881c4-ce2e-460f-8edb-c2d63504fb12 rhg=
b quiet i915.modeset=3D0
KERNEL supported cpus:
  Intel GenuineIntel
  AMD AuthenticAMD
  Centaur CentaurHauls
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009d000 (usable)
 BIOS-e820: 000000000009d000 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000007e730000 (usable)
 BIOS-e820: 000000007e730000 - 000000007e773000 (ACPI NVS)
 BIOS-e820: 000000007e773000 - 000000007e774000 (reserved)
 BIOS-e820: 000000007e774000 - 000000007e9d6000 (ACPI NVS)
 BIOS-e820: 000000007e9d6000 - 000000007ea08000 (reserved)
 BIOS-e820: 000000007ea08000 - 000000007ea1c000 (ACPI NVS)
 BIOS-e820: 000000007ea1c000 - 000000007efd7000 (reserved)
 BIOS-e820: 000000007efd7000 - 000000007efe1000 (ACPI NVS)
 BIOS-e820: 000000007efe1000 - 000000007efe8000 (reserved)
 BIOS-e820: 000000007efe8000 - 000000007f016000 (ACPI NVS)
 BIOS-e820: 000000007f016000 - 000000007f0c7000 (reserved)
 BIOS-e820: 000000007f0c7000 - 000000007f10e000 (ACPI data)
 BIOS-e820: 000000007f10e000 - 000000007f140000 (ACPI NVS)
 BIOS-e820: 000000007f140000 - 000000007f160000 (reserved)
 BIOS-e820: 000000007f160000 - 000000007f211000 (ACPI NVS)
 BIOS-e820: 000000007f211000 - 000000007f4cf000 (reserved)
 BIOS-e820: 000000007f4cf000 - 000000007f500000 (ACPI NVS)
 BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
 BIOS-e820: 00000000fed1c000 - 00000000fed20000 (reserved)
 BIOS-e820: 00000000ffa80000 - 00000000ffc00000 (reserved)
 BIOS-e820: 00000000ffe80000 - 0000000100000000 (reserved)
DMI 2.4 present.
AMI BIOS detected: BIOS may corrupt low RAM, working around it.
last_pfn =3D 0x7e730 max_arch_pfn =3D 0x100000000
x86 PAT enabled: cpu 0, old 0x7040600070406, new 0x7010600070106
original variable MTRRs
reg 0, base: 0GB, range: 2GB, type WB
reg 1, base: 2040MB, range: 8MB, type UC
reg 2, base: 2038MB, range: 2MB, type UC
reg 3, base: 2037MB, range: 1MB, type UC
reg 4, base: 4094MB, range: 2MB, type WP
total RAM coverred: 2037M
=46ound optimal setting for mtrr clean up
 gran_size: 64K 	chunk_size: 16M 	num_reg: 4  	lose cover RAM: 0G
New variable MTRRs
reg 0, base: 0GB, range: 2GB, type WB
reg 1, base: 2037MB, range: 1MB, type UC
reg 2, base: 2038MB, range: 2MB, type UC
reg 3, base: 2040MB, range: 8MB, type UC
x86 PAT enabled: cpu 0, old 0x7040600070406, new 0x7010600070106
init_memory_mapping: 0000000000000000-000000007e730000
 0000000000 - 007e600000 page 2M
 007e600000 - 007e730000 page 4k
kernel direct mapping tables up to 7e730000 @ 10000-14000
last_map_addr: 7e730000 end: 7e730000
RAMDISK: 37caa000 - 37fef1a7
ACPI: X
ACPI: X
ACPI: X
ACPI Warning (tbfadt-0328): 32/64 FACS address mismatch in FADT - two F=
ACS tables! [20081204]
ACPI Warning (tbfadt-0530): 32/64X FACS address mismatch in FADT - two =
=46ACS tables! 7F120F40/000000007F160E40 [20081204]
=46ADT: X_PM1a_EVT_BLK.bit_width (16) does not match PM1_EVT_LEN (4)
ACPI: X
ACPI: X
ACPI: X
ACPI: X
ACPI: X
ACPI: X
ACPI: Local APIC address 0xfee00000
No NUMA configuration found
=46aking a node at 0000000000000000-000000007e730000
Bootmem setup node 0 0000000000000000-000000007e730000
  NODE_DATA [0000000000012000 - 0000000000029fff]
  bootmap [000000000002a000 -  0000000000039ce7] pages 10
(6 early reservations) =3D=3D> bootmem [0000000000 - 007e730000]
  #0 [0000000000 - 0000001000]   BIOS data page =3D=3D> [0000000000 - 0=
000001000]
  #1 [0000006000 - 0000008000]       TRAMPOLINE =3D=3D> [0000006000 - 0=
000008000]
  #2 [0000200000 - 00014a05c0]    TEXT DATA BSS =3D=3D> [0000200000 - 0=
0014a05c0]
  #3 [0037caa000 - 0037fef1a7]          RAMDISK =3D=3D> [0037caa000 - 0=
037fef1a7]
  #4 [000009d000 - 0000100000]    BIOS reserved =3D=3D> [000009d000 - 0=
000100000]
  #5 [0000010000 - 0000012000]          PGTABLE =3D=3D> [0000010000 - 0=
000012000]
found SMP MP-table at [ffff8800000fd0d0] 000fd0d0
 [ffffe20000000000-ffffe200033fffff] PMD -> [ffff880001600000-ffff88000=
49fffff] on node 0
Zone PFN ranges:
  DMA      0x00000010 -> 0x00001000
  DMA32    0x00001000 -> 0x00100000
  Normal   0x00100000 -> 0x00100000
Movable zone start PFN for each node
early_node_map[2] active PFN ranges
    0: 0x00000010 -> 0x0000009d
    0: 0x00000100 -> 0x0007e730
On node 0 totalpages: 517821
  DMA zone: 104 pages used for memmap
  DMA zone: 106 pages reserved
  DMA zone: 3771 pages, LIFO batch:0
  DMA32 zone: 13047 pages used for memmap
  DMA32 zone: 500793 pages, LIFO batch:31
ACPI: PM-Timer IO Port: 0x408
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
ACPI: LAPIC (acpi_id[0x03] lapic_id[0x02] disabled)
ACPI: LAPIC (acpi_id[0x04] lapic_id[0x03] disabled)
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 0, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Using ACPI (MADT) for SMP configuration information
SMP: Allowing 4 CPUs, 2 hotplug CPUs
nr_irqs_gsi: 24
PM: Registered nosave memory: 000000000009d000 - 00000000000a0000
PM: Registered nosave memory: 00000000000a0000 - 00000000000e0000
PM: Registered nosave memory: 00000000000e0000 - 0000000000100000
Allocating PCI resources starting at 80000000 (gap: 7f500000:60b00000)
NR_CPUS:512 nr_cpumask_bits:512 nr_cpu_ids:4 nr_node_ids:1
PERCPU: Allocating 1904640 bytes of per cpu data
Built 1 zonelists in Node order, mobility grouping on.  Total pages: 50=
4564
Policy zone: DMA32
Kernel command line: ro root=3DUUID=3D761881c4-ce2e-460f-8edb-c2d63504f=
b12 rhgb quiet i915.modeset=3D0
Unknown boot option `i915.modeset=3D0': ignoring
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 32768 bytes)
Extended CMOS year: 2000
=46ast TSC calibration using PIT
Detected 2399.798 MHz processor.
Console: colour VGA+ 80x25
console [tty0] enabled
Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molna=
r
=2E.. MAX_LOCKDEP_SUBCLASSES:  8
=2E.. MAX_LOCK_DEPTH:          48
=2E.. MAX_LOCKDEP_KEYS:        8191
=2E.. CLASSHASH_SIZE:          4096
=2E.. MAX_LOCKDEP_ENTRIES:     8192
=2E.. MAX_LOCKDEP_CHAINS:      16384
=2E.. CHAINHASH_SIZE:          8192
 memory used by lock dependency info: 4351 kB
 per task-struct memory footprint: 2688 bytes
allocated 20971520 bytes of page_cgroup
please try cgroup_disable=3Dmemory option if you don't want
Checking aperture...
No AGP bridge found
Calgary: detecting Calgary via BIOS EBDA area
Calgary: Unable to locate Rio Grande table in EBDA - bailing!
Memory: 1967272k/2071744k available (3699k kernel code, 460k absent, 10=
4012k reserved, 2349k data, 3064k init)
SLUB: Genslabs=3D13, HWalign=3D64, Order=3D0-3, MinObjects=3D0, CPUs=3D=
4, Nodes=3D1
Calibrating delay loop (skipped), value calculated using timer frequenc=
y.. 4799.59 BogoMIPS (lpj=3D2399798)
Security Framework initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes)
Mount-cache hash table entries: 256
Initializing cgroup subsys ns
Initializing cgroup subsys cpuacct
Initializing cgroup subsys memory
Initializing cgroup subsys devices
Initializing cgroup subsys freezer
Initializing cgroup subsys net_cls
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 6144K
[ds] using Core 2/Atom configuration
CPU 0/0x0 -> Node 0
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 0
CPU0: Thermal monitoring enabled (TM2)
using mwait in idle threads.
ACPI: Core revision 20081204
ftrace: converting mcount calls to 0f 1f 44 00 00
ftrace: allocating 18275 entries in 144 pages
Setting APIC routing to flat
=2E.TIMER: vector=3D0x30 apic1=3D0 pin1=3D2 apic2=3D0 pin2=3D0
CPU0: Genuine Intel(R) CPU                  @ 2.40GHz stepping 04
lockdep: fixing up alternatives.
Booting processor 1 APIC 0x1 ip 0x6000
Initializing CPU#1
Calibrating delay using timer specific routine.. 4799.26 BogoMIPS (lpj=3D=
2399631)
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 6144K
[ds] using Core 2/Atom configuration
CPU 1/0x1 -> Node 0
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 1
CPU1: Thermal monitoring enabled (TM2)
x86 PAT enabled: cpu 1, old 0x7040600070406, new 0x7010600070106
CPU1: Genuine Intel(R) CPU                  @ 2.40GHz stepping 04
checking TSC synchronization [CPU#0 -> CPU#1]: passed.
Brought up 2 CPUs
Total of 2 processors activated (9598.85 BogoMIPS).
sizeof(vma)=3D176 bytes
sizeof(page)=3D104 bytes
sizeof(inode)=3D1168 bytes
sizeof(dentry)=3D256 bytes
sizeof(ext3inode)=3D1600 bytes
sizeof(buffer_head)=3D104 bytes
sizeof(skbuff)=3D232 bytes
sizeof(task_struct)=3D8960 bytes
CPU0 attaching sched-domain:
 domain 0: span 0-1 level MC
  groups: 0 1
CPU1 attaching sched-domain:
 domain 0: span 0-1 level MC
  groups: 1 0
khelper used greatest stack depth: 5416 bytes left
net_namespace: 2232 bytes
Booting paravirtualized kernel on bare hardware
regulator: core version 0.5
Time: 22:49:25  Date: 02/25/09
NET: Registered protocol family 16
ACPI FADT declares the system doesn't support PCIe ASPM, so disable it
ACPI: bus type pci registered
PCI: MCFG configuration 0: base e0000000 segment 0 buses 0 - 255
PCI: MCFG area at e0000000 reserved in E820
PCI: Using MMCONFIG at e0000000 - efffffff
PCI: Using configuration type 1 for base access
bio: create slab <bio-0> at 0
ACPI: EC: Look up EC in DSDT
ACPI: BIOS _OSI(Linux) query ignored
ACPI: EC: non-query interrupt received, switching to interrupt mode
ACPI: Interpreter enabled
ACPI: (supports S0 S3 S4 S5)
ACPI: Using IOAPIC for interrupt routing
ACPI: EC: GPE =3D 0x17, I/O: command/status =3D 0x66, data =3D 0x62
ACPI: EC: driver started in interrupt mode
ACPI: ACPI Dock Station Driver: 1 docks/bays found
_OSC invalid UUID
ACPI: PCI Root Bridge [PCI0] (0000:00)
DMAR: Forcing write-buffer flush capability
pci 0000:00:02.0: reg 10 64bit mmio: [0x90000000-0x903fffff]
pci 0000:00:02.0: reg 18 64bit mmio: [0x80000000-0x8fffffff]
pci 0000:00:02.0: reg 20 io port: [0x21c0-0x21c7]
pci 0000:00:02.1: reg 10 64bit mmio: [0x90400000-0x904fffff]
pci 0000:00:19.0: reg 10 32bit mmio: [0x90500000-0x9051ffff]
pci 0000:00:19.0: reg 14 32bit mmio: [0x90520000-0x90520fff]
pci 0000:00:19.0: reg 18 io port: [0x20e0-0x20ff]
pci 0000:00:19.0: PME# supported from D0 D3hot D3cold
pci 0000:00:19.0: PME# disabled
pci 0000:00:1a.0: reg 20 io port: [0x20c0-0x20df]
pci 0000:00:1a.1: reg 20 io port: [0x20a0-0x20bf]
pci 0000:00:1a.7: reg 10 32bit mmio: [0x90521400-0x905217ff]
pci 0000:00:1a.7: PME# supported from D0 D3hot D3cold
pci 0000:00:1a.7: PME# disabled
pci 0000:00:1d.0: reg 20 io port: [0x2080-0x209f]
pci 0000:00:1d.1: reg 20 io port: [0x2060-0x207f]
pci 0000:00:1d.2: reg 20 io port: [0x2040-0x205f]
pci 0000:00:1d.3: reg 20 io port: [0x2020-0x203f]
pci 0000:00:1d.7: reg 10 32bit mmio: [0x90521000-0x905213ff]
pci 0000:00:1d.7: PME# supported from D0 D3hot D3cold
pci 0000:00:1d.7: PME# disabled
pci 0000:00:1f.2: reg 10 io port: [0x21b0-0x21b7]
pci 0000:00:1f.2: reg 14 io port: [0x21a0-0x21a3]
pci 0000:00:1f.2: reg 18 io port: [0x2190-0x2197]
pci 0000:00:1f.2: reg 1c io port: [0x2180-0x2183]
pci 0000:00:1f.2: reg 20 io port: [0x2170-0x217f]
pci 0000:00:1f.2: reg 24 io port: [0x2160-0x216f]
pci 0000:00:1f.3: reg 10 64bit mmio: [0x90521800-0x905218ff]
pci 0000:00:1f.3: reg 20 io port: [0x2000-0x201f]
pci 0000:00:1f.5: reg 10 io port: [0x2150-0x2157]
pci 0000:00:1f.5: reg 14 io port: [0x2140-0x2143]
pci 0000:00:1f.5: reg 18 io port: [0x2130-0x2137]
pci 0000:00:1f.5: reg 1c io port: [0x2120-0x2123]
pci 0000:00:1f.5: reg 20 io port: [0x2110-0x211f]
pci 0000:00:1f.5: reg 24 io port: [0x2100-0x210f]
pci 0000:00:1e.0: transparent bridge
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P1._PRT]
_OSC invalid UUID
ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 5 6 7 10 12 14 15) *11
ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 5 6 7 11 12 14 15) *0, disa=
bled.
ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 5 6 7 *10 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 5 6 7 11 12 14 15) *10
ACPI: PCI Interrupt Link [LNKE] (IRQs 1 3 4 5 6 7 *10 12 14 15)
ACPI: PCI Interrupt Link [LNKF] (IRQs 1 3 4 5 6 7 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKG] (IRQs 1 3 4 5 6 7 10 12 14 15) *0, disa=
bled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 1 3 4 5 6 7 *11 12 14 15)
ACPI: Power Resource [FN00] (off)
ACPI: Power Resource [FN01] (off)
SCSI subsystem initialized
libata version 3.00 loaded.
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
PCI: Using ACPI for IRQ routing
NetLabel: Initializing
NetLabel:  domain hash size =3D 128
NetLabel:  protocols =3D UNLABELED CIPSOv4
NetLabel:  unlabeled traffic allowed by default
DMA-API: preallocated 8192 debug entries
DMA-API: debugging enabled by kernel config
pnp: PnP ACPI init
ACPI: bus type pnp registered
pnp: PnP ACPI: found 12 devices
ACPI: ACPI bus type pnp unregistered
system 00:04: ioport range 0x680-0x69f has been reserved
system 00:04: ioport range 0x1000-0x100f has been reserved
system 00:04: ioport range 0xffff-0xffff has been reserved
system 00:04: ioport range 0xffff-0xffff has been reserved
system 00:04: ioport range 0x400-0x47f has been reserved
system 00:04: ioport range 0x500-0x53f has been reserved
system 00:04: ioport range 0x164e-0x164f has been reserved
system 00:05: ioport range 0x6a0-0x6af has been reserved
system 00:05: ioport range 0x6b0-0x6ef has been reserved
system 00:0b: iomem range 0xfed1c000-0xfed1ffff has been reserved
system 00:0b: iomem range 0xfed14000-0xfed17fff has been reserved
system 00:0b: iomem range 0xfed18000-0xfed18fff has been reserved
system 00:0b: iomem range 0xfed19000-0xfed19fff has been reserved
system 00:0b: iomem range 0xe0000000-0xefffffff has been reserved
system 00:0b: iomem range 0xfed20000-0xfed3ffff has been reserved
system 00:0b: iomem range 0xfeb00000-0xfeb03fff has been reserved
system 00:0b: iomem range 0xfed45000-0xfed8ffff has been reserved
pci 0000:00:1e.0: PCI bridge, secondary bus 0000:01
pci 0000:00:1e.0:   IO window: disabled
pci 0000:00:1e.0:   MEM window: disabled
pci 0000:00:1e.0:   PREFETCH window: disabled
pci 0000:00:1e.0: setting latency timer to 64
pci_bus 0000:00: resource 0 io:  [0x00-0xffff]
pci_bus 0000:00: resource 1 mem: [0x000000-0xffffffffffffffff]
pci_bus 0000:01: resource 0 mem: [0x0-0x0]
pci_bus 0000:01: resource 1 mem: [0x0-0x0]
pci_bus 0000:01: resource 2 mem: [0x0-0x0]
pci_bus 0000:01: resource 3 io:  [0x00-0xffff]
pci_bus 0000:01: resource 4 mem: [0x000000-0xffffffffffffffff]
NET: Registered protocol family 2
IP route cache hash table entries: 65536 (order: 7, 524288 bytes)
TCP established hash table entries: 262144 (order: 10, 4194304 bytes)
TCP bind hash table entries: 65536 (order: 10, 4718592 bytes)
TCP: Hash tables configured (established 262144 bind 65536)
TCP reno registered
NET: Registered protocol family 1
checking if image is initramfs... it is
=46reeing initrd memory: 3348k freed
audit: initializing netlink socket (disabled)
type=3D2000 audit(1235602164.693:1): initialized
HugeTLB registered 2 MB page size, pre-allocated 0 pages
VFS: Disk quotas dquot_6.5.2
Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
Created ptmx node in devpts ino 2
msgmni has been set to 3848
SELinux:  Registering netfilter hooks
alg: No test for stdrng (krng)
Block layer SCSI generic (bsg) driver version 0.4 loaded (major 252)
io scheduler noop registered
io scheduler cfq registered (default)
pci 0000:00:02.0: Boot video device
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
pciehp: PCI Express Hot Plug Controller Driver version: 0.4
acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
decode_hpp: Could not get hotplug parameters. Use defaults
acpiphp: Slot [1] registered
ACPI: AC Adapter [ADP1] (on-line)
ACPI: Battery Slot [BAT0] (battery present)
ACPI: Battery Slot [BAT1] (battery absent)
ACPI: Battery Slot [BAT2] (battery absent)
input: Power Button (FF) as /devices/LNXSYSTM:00/LNXPWRBN:00/input/inpu=
t0
ACPI: Power Button (FF) [PWRF]
input: Lid Switch as /devices/LNXSYSTM:00/device:00/PNP0C0D:00/input/in=
put1
ACPI: Lid Switch [LID0]
input: Power Button (CM) as /devices/LNXSYSTM:00/device:00/PNP0C0C:00/i=
nput/input2
ACPI: Power Button (CM) [PWRB]
fan PNP0C0B:00: registered as cooling_device0
ACPI: Fan [FAN0] (off)
fan PNP0C0B:01: registered as cooling_device1
ACPI: Fan [FAN1] (off)
ACPI: SSDT 7EFE3C18, 0265 (r1  PmRef  Cpu0Ist     3000 INTL 20060912)
ACPI: SSDT 7EFE1618, 05B8 (r1  PmRef  Cpu0Cst     3001 INTL 20060912)
Monitor-Mwait will be used to enter C-1 state
Monitor-Mwait will be used to enter C-2 state
ACPI: CPU0 (power states: C1[C1] C2[C2])
processor ACPI_CPU:00: registered as cooling_device2
ACPI: Processor [CPU0] (supports 8 throttling states)
ACPI: SSDT 7EFE2E18, 01CF (r1  PmRef    ApIst     3000 INTL 20060912)
ACPI: SSDT 7EFE3F18, 008D (r1  PmRef    ApCst     3000 INTL 20060912)
ACPI: CPU1 (power states: C1[C1] C2[C2])
processor ACPI_CPU:01: registered as cooling_device3
ACPI: Processor [CPU1] (supports 8 throttling states)
thermal LNXTHERM:01: registered as thermal_zone0
ACPI: Thermal Zone [TZ00] (40 C)
thermal LNXTHERM:02: registered as thermal_zone1
ACPI: Thermal Zone [TZ01] (40 C)
Non-volatile memory driver v1.3
Linux agpgart interface v0.103
agpgart-intel 0000:00:00.0: Intel Mobile Intel=AE GM45 Express Chipset
agpgart-intel 0000:00:00.0: detected 8188K stolen memory
agpgart-intel 0000:00:00.0: AGP aperture is 256M @ 0x80000000
Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
Switched to high resolution mode on CPU 1
Switched to high resolution mode on CPU 0
serial8250: ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
serial8250: ttyS2 at I/O 0x3e8 (irq =3D 3) is a 16550A
00:07: ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
brd: module loaded
loop: module loaded
=46ixed MDIO Bus: probed
input: Macintosh mouse button emulation as /devices/virtual/input/input=
3
Driver 'sd' needs updating - please use bus_type methods
Driver 'sr' needs updating - please use bus_type methods
ata_piix 0000:00:1f.2: version 2.12
  alloc irq_desc for 19 on cpu 0 node 0
  alloc kstat_irqs on cpu 0 node 0
ata_piix 0000:00:1f.2: PCI INT B -> GSI 19 (level, low) -> IRQ 19
ata_piix 0000:00:1f.2: MAP [ P0 -- P1 -- ]
ata_piix 0000:00:1f.2: setting latency timer to 64
scsi0 : ata_piix
scsi1 : ata_piix
ata1: SATA max UDMA/133 cmd 0x21b0 ctl 0x21a0 bmdma 0x2170 irq 19
ata2: SATA max UDMA/133 cmd 0x2190 ctl 0x2180 bmdma 0x2178 irq 19
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.00: ATA-8: Hitachi HTS722016K9SA00, DCDOC54P, max UDMA/133
ata1.00: 312581808 sectors, multi 16: LBA48 NCQ (depth 0/32)
ata1.00: configured for UDMA/133
isa bounce pool size: 16 pages
scsi 0:0:0:0: Direct-Access     ATA      Hitachi HTS72201 DCDO PQ: 0 AN=
SI: 5
sd 0:0:0:0: [sda] 312581808 512-byte hardware sectors: (160 GB/149 GiB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't su=
pport DPO or FUA
sd 0:0:0:0: [sda] 312581808 512-byte hardware sectors: (160 GB/149 GiB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't su=
pport DPO or FUA
 sda: sda1 sda2
sd 0:0:0:0: [sda] Attached SCSI disk
sd 0:0:0:0: Attached scsi generic sg0 type 0
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata2.00: ATAPI: TSSTcorp CDDVDW TS-L633A, UO00, max MWDMA2
ata2.00: applying bridge limits
ata2.00: configured for MWDMA2
scsi 1:0:0:0: CD-ROM            TSSTcorp CDDVDW TS-L633A  UO00 PQ: 0 AN=
SI: 5
sr0: scsi3-mmc drive: 24x/24x writer dvd-ram cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.20
sr 1:0:0:0: Attached scsi CD-ROM sr0
sr 1:0:0:0: Attached scsi generic sg1 type 5
  alloc irq_desc for 21 on cpu 0 node 0
  alloc kstat_irqs on cpu 0 node 0
ata_piix 0000:00:1f.5: PCI INT A -> GSI 21 (level, low) -> IRQ 21
ata_piix 0000:00:1f.5: MAP [ P0 -- P1 -- ]
ata_piix 0000:00:1f.5: setting latency timer to 64
scsi2 : ata_piix
scsi3 : ata_piix
ata3: SATA max UDMA/133 cmd 0x2150 ctl 0x2140 bmdma 0x2110 irq 21
ata4: SATA max UDMA/133 cmd 0x2130 ctl 0x2120 bmdma 0x2118 irq 21
ata3: SATA link down (SStatus 0 SControl 300)
ata4: SATA link down (SStatus 0 SControl 300)
ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
ehci_hcd 0000:00:1a.7: PCI INT C -> GSI 19 (level, low) -> IRQ 19
ehci_hcd 0000:00:1a.7: setting latency timer to 64
ehci_hcd 0000:00:1a.7: EHCI Host Controller
ehci_hcd 0000:00:1a.7: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:1a.7: debug port 1
ehci_hcd 0000:00:1a.7: cache line size of 32 is not supported
ehci_hcd 0000:00:1a.7: irq 19, io mem 0x90521400
ehci_hcd 0000:00:1a.7: USB 2.0 started, EHCI 1.00
usb usb1: New USB device found, idVendor=3D1d6b, idProduct=3D0002
usb usb1: New USB device strings: Mfr=3D3, Product=3D2, SerialNumber=3D=
1
usb usb1: Product: EHCI Host Controller
usb usb1: Manufacturer: Linux 2.6.29-0.148.rc6.fc11.x86_64 ehci_hcd
usb usb1: SerialNumber: 0000:00:1a.7
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 4 ports detected
  alloc irq_desc for 23 on cpu 0 node 0
  alloc kstat_irqs on cpu 0 node 0
ehci_hcd 0000:00:1d.7: PCI INT A -> GSI 23 (level, low) -> IRQ 23
ehci_hcd 0000:00:1d.7: setting latency timer to 64
ehci_hcd 0000:00:1d.7: EHCI Host Controller
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 2
ehci_hcd 0000:00:1d.7: debug port 1
ehci_hcd 0000:00:1d.7: cache line size of 32 is not supported
ehci_hcd 0000:00:1d.7: irq 23, io mem 0x90521000
ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00
usb usb2: New USB device found, idVendor=3D1d6b, idProduct=3D0002
usb usb2: New USB device strings: Mfr=3D3, Product=3D2, SerialNumber=3D=
1
usb usb2: Product: EHCI Host Controller
usb usb2: Manufacturer: Linux 2.6.29-0.148.rc6.fc11.x86_64 ehci_hcd
usb usb2: SerialNumber: 0000:00:1d.7
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 8 ports detected
ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
uhci_hcd: USB Universal Host Controller Interface driver
  alloc irq_desc for 16 on cpu 0 node 0
  alloc kstat_irqs on cpu 0 node 0
uhci_hcd 0000:00:1a.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
uhci_hcd 0000:00:1a.0: setting latency timer to 64
uhci_hcd 0000:00:1a.0: UHCI Host Controller
uhci_hcd 0000:00:1a.0: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1a.0: irq 16, io base 0x000020c0
usb usb3: New USB device found, idVendor=3D1d6b, idProduct=3D0001
usb usb3: New USB device strings: Mfr=3D3, Product=3D2, SerialNumber=3D=
1
usb usb3: Product: UHCI Host Controller
usb usb3: Manufacturer: Linux 2.6.29-0.148.rc6.fc11.x86_64 uhci_hcd
usb usb3: SerialNumber: 0000:00:1a.0
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
uhci_hcd 0000:00:1a.1: PCI INT B -> GSI 21 (level, low) -> IRQ 21
uhci_hcd 0000:00:1a.1: setting latency timer to 64
uhci_hcd 0000:00:1a.1: UHCI Host Controller
uhci_hcd 0000:00:1a.1: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:1a.1: irq 21, io base 0x000020a0
usb usb4: New USB device found, idVendor=3D1d6b, idProduct=3D0001
usb usb4: New USB device strings: Mfr=3D3, Product=3D2, SerialNumber=3D=
1
usb usb4: Product: UHCI Host Controller
usb usb4: Manufacturer: Linux 2.6.29-0.148.rc6.fc11.x86_64 uhci_hcd
usb usb4: SerialNumber: 0000:00:1a.1
usb usb4: configuration #1 chosen from 1 choice
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
uhci_hcd 0000:00:1d.0: PCI INT A -> GSI 23 (level, low) -> IRQ 23
uhci_hcd 0000:00:1d.0: setting latency timer to 64
uhci_hcd 0000:00:1d.0: UHCI Host Controller
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 5
uhci_hcd 0000:00:1d.0: irq 23, io base 0x00002080
usb usb5: New USB device found, idVendor=3D1d6b, idProduct=3D0001
usb usb5: New USB device strings: Mfr=3D3, Product=3D2, SerialNumber=3D=
1
usb usb5: Product: UHCI Host Controller
usb usb5: Manufacturer: Linux 2.6.29-0.148.rc6.fc11.x86_64 uhci_hcd
usb usb5: SerialNumber: 0000:00:1d.0
usb usb5: configuration #1 chosen from 1 choice
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 2 ports detected
uhci_hcd 0000:00:1d.1: PCI INT B -> GSI 19 (level, low) -> IRQ 19
uhci_hcd 0000:00:1d.1: setting latency timer to 64
uhci_hcd 0000:00:1d.1: UHCI Host Controller
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 6
uhci_hcd 0000:00:1d.1: irq 19, io base 0x00002060
usb usb6: New USB device found, idVendor=3D1d6b, idProduct=3D0001
usb usb6: New USB device strings: Mfr=3D3, Product=3D2, SerialNumber=3D=
1
usb usb6: Product: UHCI Host Controller
usb usb6: Manufacturer: Linux 2.6.29-0.148.rc6.fc11.x86_64 uhci_hcd
usb usb6: SerialNumber: 0000:00:1d.1
usb usb6: configuration #1 chosen from 1 choice
hub 6-0:1.0: USB hub found
hub 6-0:1.0: 2 ports detected
  alloc irq_desc for 18 on cpu 0 node 0
  alloc kstat_irqs on cpu 0 node 0
uhci_hcd 0000:00:1d.2: PCI INT C -> GSI 18 (level, low) -> IRQ 18
uhci_hcd 0000:00:1d.2: setting latency timer to 64
uhci_hcd 0000:00:1d.2: UHCI Host Controller
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 7
uhci_hcd 0000:00:1d.2: irq 18, io base 0x00002040
usb usb7: New USB device found, idVendor=3D1d6b, idProduct=3D0001
usb usb7: New USB device strings: Mfr=3D3, Product=3D2, SerialNumber=3D=
1
usb usb7: Product: UHCI Host Controller
usb usb7: Manufacturer: Linux 2.6.29-0.148.rc6.fc11.x86_64 uhci_hcd
usb usb7: SerialNumber: 0000:00:1d.2
usb usb7: configuration #1 chosen from 1 choice
hub 7-0:1.0: USB hub found
hub 7-0:1.0: 2 ports detected
uhci_hcd 0000:00:1d.3: PCI INT D -> GSI 16 (level, low) -> IRQ 16
uhci_hcd 0000:00:1d.3: setting latency timer to 64
uhci_hcd 0000:00:1d.3: UHCI Host Controller
uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 8
uhci_hcd 0000:00:1d.3: irq 16, io base 0x00002020
usb usb8: New USB device found, idVendor=3D1d6b, idProduct=3D0001
usb usb8: New USB device strings: Mfr=3D3, Product=3D2, SerialNumber=3D=
1
usb usb8: Product: UHCI Host Controller
usb usb8: Manufacturer: Linux 2.6.29-0.148.rc6.fc11.x86_64 uhci_hcd
usb usb8: SerialNumber: 0000:00:1d.3
usb usb8: configuration #1 chosen from 1 choice
hub 8-0:1.0: USB hub found
hub 8-0:1.0: 2 ports detected
PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
serio: i8042 KBD port at 0x60,0x64 irq 1
serio: i8042 AUX port at 0x60,0x64 irq 12
mice: PS/2 mouse device common for all mice
rtc_cmos 00:06: RTC can wake from S4
rtc_cmos 00:06: rtc core: registered rtc_cmos as rtc0
rtc0: alarms up to one year, y3k, 242 bytes nvram
device-mapper: uevent: version 1.0.3
device-mapper: ioctl: 4.14.0-ioctl (2008-04-23) initialised: dm-devel@r=
edhat.com
cpuidle: using governor ladder
cpuidle: using governor menu
Marking TSC unstable due to TSC halts in idle
usbcore: registered new interface driver hiddev
usbcore: registered new interface driver usbhid
usbhid: v2.6:USB HID core driver
nf_conntrack version 0.5.0 (16384 buckets, 65536 max)
CONFIG_NF_CT_ACCT is deprecated and will be removed soon. Please use
nf_conntrack.acct=3D1 kernel paramater, acct=3D1 nf_conntrack module op=
tion or
sysctl net.netfilter.nf_conntrack_acct=3D1 to enable it.
ip_tables: (C) 2000-2006 Netfilter Core Team
TCP cubic registered
Initializing XFRM netlink socket
NET: Registered protocol family 17
registered taskstats version 1
  Magic number: 13:974:856
=46reeing unused kernel memory: 3064k freed
Write protecting the kernel read-only data: 1852k
input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/i=
nput/input4
Clocksource tsc unstable (delta =3D -157279725 ns)
[drm] Initialized drm 1.1.0 20060810
pci 0000:00:02.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
pci 0000:00:02.0: setting latency timer to 64
  alloc irq_desc for 24 on cpu 0 node 0
  alloc kstat_irqs on cpu 0 node 0
pci 0000:00:02.0: irq 24 for MSI/MSI-X
[drm] Initialized i915 1.6.0 20080730 on minor 0
input: PS/2 Generic Mouse as /devices/platform/i8042/serio1/input/input=
5
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
type=3D1404 audit(1235602169.437:2): enforcing=3D1 old_enforcing=3D0 au=
id=3D4294967295 ses=3D4294967295
SELinux: 8192 avtab hash slots, 125003 rules.
SELinux: 8192 avtab hash slots, 125003 rules.
SELinux:  8 users, 14 roles, 2612 types, 117 bools, 1 sens, 1024 cats
SELinux:  74 classes, 125003 rules
SELinux:  Completing initialization.
SELinux:  Setting up existing superblocks.
SELinux: initialized (dev sda1, type ext3), uses xattr
SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs
SELinux: initialized (dev usbfs, type usbfs), uses genfs_contexts
SELinux: initialized (dev selinuxfs, type selinuxfs), uses genfs_contex=
ts
SELinux: initialized (dev mqueue, type mqueue), uses transition SIDs
SELinux: initialized (dev hugetlbfs, type hugetlbfs), uses genfs_contex=
ts
SELinux: initialized (dev devpts, type devpts), uses transition SIDs
SELinux: initialized (dev inotifyfs, type inotifyfs), uses genfs_contex=
ts
SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs
SELinux: initialized (dev anon_inodefs, type anon_inodefs), uses genfs_=
contexts
SELinux: initialized (dev pipefs, type pipefs), uses task SIDs
SELinux: initialized (dev debugfs, type debugfs), uses genfs_contexts
SELinux: initialized (dev sockfs, type sockfs), uses task SIDs
SELinux: initialized (dev proc, type proc), uses genfs_contexts
SELinux: initialized (dev bdev, type bdev), uses genfs_contexts
SELinux: initialized (dev rootfs, type rootfs), uses genfs_contexts
SELinux: initialized (dev sysfs, type sysfs), uses genfs_contexts
type=3D1403 audit(1235602169.978:3): policy loaded auid=3D4294967295 se=
s=3D4294967295
runlevel used greatest stack depth: 4536 bytes left
hostname used greatest stack depth: 4088 bytes left
mount used greatest stack depth: 3304 bytes left
udev: starting version 137
e1000e: Intel(R) PRO/1000 Network Driver - 0.3.3.3-k6
e1000e: Copyright (c) 1999-2008 Intel Corporation.
  alloc irq_desc for 20 on cpu 0 node 0
  alloc kstat_irqs on cpu 0 node 0
e1000e 0000:00:19.0: PCI INT A -> GSI 20 (level, low) -> IRQ 20
e1000e 0000:00:19.0: setting latency timer to 64
  alloc irq_desc for 25 on cpu 0 node 0
  alloc kstat_irqs on cpu 0 node 0
e1000e 0000:00:19.0: irq 25 for MSI/MSI-X
input: Video Bus as /devices/LNXSYSTM:00/device:00/PNP0A08:00/device:03=
/input/input6
ACPI: Video Device [GFX0] (multi-head: yes  rom: no  post: no)
0000:00:19.0: eth0: (PCI Express:2.5GB/s:Width x1) 00:13:20:62:32:4b
0000:00:19.0: eth0: Intel(R) PRO/1000 Network Connection
0000:00:19.0: eth0: MAC: 6, PHY: 8, PBA No: ffffff-0ff
i801_smbus 0000:00:1f.3: PCI INT C -> GSI 19 (level, low) -> IRQ 19
input: PC Speaker as /devices/platform/pcspkr/input/input7
------------[ cut here ]------------
WARNING: at drivers/pci/pci.c:66 pci_ioremap_bar+0x37/0x70() (Not taint=
ed)
Hardware name: ------------------
Modules linked in: snd_hda_intel(+) snd_hda_codec snd_hwdep snd_seq_dum=
my snd_seq_oss snd_seq_midi_event snd_seq snd_seq_device snd_pcm_oss sn=
d_mixer_oss pcspkr snd_pcm i2c_i801 snd_timer snd soundcore snd_page_al=
loc video output e1000e ata_generic pata_acpi i915 drm i2c_algo_bit i2c=
_core [last unloaded: scsi_wait_scan]
Pid: 12, comm: work_on_cpu/0 Not tainted 2.6.29-0.148.rc6.fc11.x86_64 #=
1
Call Trace:
 [<ffffffff8104ba7b>] warn_slowpath+0xbc/0xf0
 [<ffffffff81060030>] ? sys_timer_gettime+0x4f/0x9b
 [<ffffffff8106f4e5>] ? mark_lock+0x28/0x37f
 [<ffffffff8106fbfa>] ? debug_check_no_locks_freed+0x131/0x149
 [<ffffffff8106fa96>] ? trace_hardirqs_on_caller+0x12f/0x153
 [<ffffffff8106e166>] ? static_obj+0x74/0x80
 [<ffffffff8106e843>] ? lockdep_init_map+0x93/0x102
 [<ffffffff811aa960>] ? __pci_request_selected_regions+0x3a/0x72
 [<ffffffff811ab4df>] pci_ioremap_bar+0x37/0x70
 [<ffffffffa01630f7>] azx_probe+0x314/0x949 [snd_hda_intel]
 [<ffffffff8105ca0c>] ? do_work_for_cpu+0x0/0x20
 [<ffffffff811ac92d>] local_pci_probe+0x17/0x1b
 [<ffffffff8105ca24>] do_work_for_cpu+0x18/0x20
 [<ffffffff8105cbf8>] run_workqueue+0xfd/0x1fd
 [<ffffffff8105cba7>] ? run_workqueue+0xac/0x1fd
 [<ffffffff8106fa96>] ? trace_hardirqs_on_caller+0x12f/0x153
 [<ffffffff8105cde7>] worker_thread+0xef/0x100
 [<ffffffff81060c1a>] ? autoremove_wake_function+0x0/0x39
 [<ffffffff8105ccf8>] ? worker_thread+0x0/0x100
 [<ffffffff8105ccf8>] ? worker_thread+0x0/0x100
 [<ffffffff81060881>] kthread+0x4d/0x78
 [<ffffffff810126aa>] child_rip+0xa/0x20
 [<ffffffff8100f88b>] ? __switch_to+0x190/0x398
 [<ffffffff81011fbe>] ? restore_args+0x0/0x30
 [<ffffffff81060834>] ? kthread+0x0/0x78
 [<ffffffff810126a0>] ? child_rip+0x0/0x20
---[ end trace 6109741e9cf496fb ]---
ALSA sound/pci/hda/hda_intel.c:2191: hda-intel: ioremap error
device-mapper: multipath: version 1.0.5 loaded
EXT3 FS on sda1, internal journal
SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs
swap_cgroup: uses 16008 bytes of vmalloc for pointer array space and 81=
96096 bytes to hold mem_cgroup pointers on swap
swap_cgroup can be disabled by noswapaccount boot option.
Adding 4096564k swap on /dev/sda2.  Priority:-1 extents:1 across:409656=
4k=20
SELinux: initialized (dev binfmt_misc, type binfmt_misc), uses genfs_co=
ntexts
platform microcode: firmware: requesting intel-ucode/06-17-04
platform microcode: firmware: requesting intel-ucode/06-17-04
Microcode Update Driver: v2.00 <tigran@aivazian.fsnet.co.uk>, Peter Oru=
ba
Microcode Update Driver: v2.00 removed.
NET: Registered protocol family 10
lo: Disabled Privacy Extensions
ip6_tables: (C) 2000-2006 Netfilter Core Team
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
SELinux: initialized (dev rpc_pipefs, type rpc_pipefs), uses genfs_cont=
exts
Bluetooth: Core ver 2.14
NET: Registered protocol family 31
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
Bluetooth: L2CAP ver 2.11
Bluetooth: L2CAP socket layer initialized
Bluetooth: BNEP (Ethernet Emulation) ver 1.3
Bluetooth: BNEP filters: protocol multicast
Bridge firewalling registered
Bluetooth: SCO (Voice Link) ver 0.6
Bluetooth: SCO socket layer initialized
e1000e 0000:00:19.0: irq 25 for MSI/MSI-X
e1000e 0000:00:19.0: irq 25 for MSI/MSI-X
ADDRCONF(NETDEV_UP): eth0: link is not ready
X:2258 conflicting memory types 80000000-90000000 uncached-minus<->writ=
e-combining
reserve_memtype failed 0x80000000-0x90000000, track uncached-minus, req=
 uncached-minus
X:2258 conflicting memory types 80000000-90000000 uncached-minus<->writ=
e-combining
reserve_memtype failed 0x80000000-0x90000000, track uncached-minus, req=
 uncached-minus
X:2258 conflicting memory types 80000000-90000000 uncached-minus<->writ=
e-combining
reserve_memtype failed 0x80000000-0x90000000, track uncached-minus, req=
 uncached-minus
X:2258 conflicting memory types 80000000-90000000 uncached-minus<->writ=
e-combining
reserve_memtype failed 0x80000000-0x90000000, track uncached-minus, req=
 uncached-minus
X:2266 freeing invalid memtype 80000000-90000000
X:2258 conflicting memory types 80000000-90000000 uncached-minus<->writ=
e-combining
reserve_memtype failed 0x80000000-0x90000000, track uncached-minus, req=
 uncached-minus
X:2267 freeing invalid memtype 80000000-90000000
e1000e: eth0 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX/TX
ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
eth0: no IPv6 routers present
CPU0 attaching NULL sched-domain.
CPU1 attaching NULL sched-domain.
CPU0 attaching sched-domain:
 domain 0: span 0-1 level MC
  groups: 0 1
CPU1 attaching sched-domain:
 domain 0: span 0-1 level MC
  groups: 1 0
------------[ cut here ]------------
WARNING: at lib/dma-debug.c:448 check_unmap+0x2b4/0x3dd() (Tainted: G  =
      W )
Hardware name: ------------------
e1000e 0000:00:19.0: DMA-API: device driver frees DMA memory with wrong=
 function [device address=3D0x0000000058853000] [size=3D129 bytes] [map=
ped as page] [unmapped as single]
Modules linked in: sco bridge stp llc bnep l2cap bluetooth sunrpc ip6t_=
REJECT nf_conntrack_ipv6 ip6table_filter ip6_tables ipv6 cpufreq_ondema=
nd acpi_cpufreq freq_table dm_multipath uinput snd_hda_intel snd_hda_co=
dec snd_hwdep snd_seq_dummy snd_seq_oss snd_seq_midi_event snd_seq snd_=
seq_device snd_pcm_oss snd_mixer_oss pcspkr snd_pcm i2c_i801 snd_timer =
snd soundcore snd_page_alloc video output e1000e ata_generic pata_acpi =
i915 drm i2c_algo_bit i2c_core [last unloaded: microcode]
Pid: 0, comm: swapper Tainted: G        W  2.6.29-0.148.rc6.fc11.x86_64=
 #1
Call Trace:
 <IRQ>  [<ffffffff8104ba7b>] warn_slowpath+0xbc/0xf0
 [<ffffffff811a16ab>] ? _raw_spin_unlock+0x8e/0x94
 [<ffffffff81395891>] ? _spin_unlock+0x2b/0x30
 [<ffffffff81395bc8>] ? _spin_lock_irqsave+0x7d/0x8b
 [<ffffffff811a6617>] ? get_hash_bucket+0x28/0x34
 [<ffffffff8106f986>] ? trace_hardirqs_on_caller+0x1f/0x153
 [<ffffffff811a6c5b>] check_unmap+0x2b4/0x3dd
 [<ffffffff810da2ad>] ? __slab_free+0x238/0x265
 [<ffffffff811a6ed1>] debug_dma_unmap_page+0x50/0x52
 [<ffffffffa008a4d2>] pci_unmap_page+0x72/0x7b [e1000e]
 [<ffffffffa008a509>] e1000_put_txbuf+0x2e/0x4f [e1000e]
 [<ffffffffa008a630>] e1000_clean_tx_irq+0xc8/0x2c2 [e1000e]
 [<ffffffffa008d83a>] ? e1000_clean+0x6b/0x246 [e1000e]
 [<ffffffffa008d846>] e1000_clean+0x77/0x246 [e1000e]
 [<ffffffff812f8043>] net_rx_action+0xb6/0x1ee
 [<ffffffff812f8132>] ? net_rx_action+0x1a5/0x1ee
 [<ffffffff810512be>] __do_softirq+0x94/0x176
 [<ffffffff810127ac>] call_softirq+0x1c/0x30
 [<ffffffff8101393e>] do_softirq+0x52/0xb9
 [<ffffffff81050ee1>] irq_exit+0x53/0x90
 [<ffffffff81013c57>] do_IRQ+0x12c/0x151
 [<ffffffff81011e93>] ret_from_intr+0x0/0x2e
 <EOI>  [<ffffffff811fdaea>] ? acpi_idle_enter_simple+0x14f/0x192
 [<ffffffff8106fac7>] ? trace_hardirqs_on+0xd/0xf
 [<ffffffff811fdaf2>] ? acpi_idle_enter_simple+0x157/0x192
 [<ffffffff811fdaea>] ? acpi_idle_enter_simple+0x14f/0x192
 [<ffffffff812d5985>] ? cpuidle_idle_call+0x8d/0xc4
 [<ffffffff810102c7>] ? cpu_idle+0x68/0xb3
 [<ffffffff8138f1c0>] ? start_secondary+0x199/0x19e
---[ end trace 6109741e9cf496fc ]---
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
ata2.00: cmd a0/01:00:00:00:02/00:00:00:00:00/a0 tag 0 dma 512 in
         cdb a1 08 2e 00 00 00 00 00  40 ec 00 00 00 00 00 00
         res 40/00:02:00:08:00/00:00:00:00:00/a0 Emask 0x4 (timeout)
ata2.00: status: { DRDY }
ata2: hard resetting link
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata2.00: configured for MWDMA2
ata2: EH complete
sr 1:0:0:0: [sr0] Result: hostbyte=3DDID_OK driverbyte=3DDRIVER_SENSE,S=
UGGEST_OK
sr 1:0:0:0: [sr0] Sense Key : Illegal Request [current]=20
sr 1:0:0:0: [sr0] Add. Sense: Logical block address out of range
end_request: I/O error, dev sr0, sector 0
Buffer I/O error on device sr0, logical block 0
sr 1:0:0:0: [sr0] Result: hostbyte=3DDID_OK driverbyte=3DDRIVER_SENSE,S=
UGGEST_OK
sr 1:0:0:0: [sr0] Sense Key : Illegal Request [current]=20
sr 1:0:0:0: [sr0] Add. Sense: Logical block address out of range
end_request: I/O error, dev sr0, sector 0
Buffer I/O error on device sr0, logical block 0
sr 1:0:0:0: [sr0] Result: hostbyte=3DDID_OK driverbyte=3DDRIVER_SENSE,S=
UGGEST_OK
sr 1:0:0:0: [sr0] Sense Key : Illegal Request [current]=20
sr 1:0:0:0: [sr0] Add. Sense: Logical block address out of range
end_request: I/O error, dev sr0, sector 0
Buffer I/O error on device sr0, logical block 0
sr 1:0:0:0: [sr0] Result: hostbyte=3DDID_OK driverbyte=3DDRIVER_SENSE,S=
UGGEST_OK
sr 1:0:0:0: [sr0] Sense Key : Illegal Request [current]=20
sr 1:0:0:0: [sr0] Add. Sense: Logical block address out of range
end_request: I/O error, dev sr0, sector 0
Buffer I/O error on device sr0, logical block 0
sr 1:0:0:0: [sr0] Result: hostbyte=3DDID_OK driverbyte=3DDRIVER_SENSE,S=
UGGEST_OK
sr 1:0:0:0: [sr0] Sense Key : Illegal Request [current]=20
sr 1:0:0:0: [sr0] Add. Sense: Logical block address out of range
end_request: I/O error, dev sr0, sector 0
Buffer I/O error on device sr0, logical block 0
sr 1:0:0:0: [sr0] Result: hostbyte=3DDID_OK driverbyte=3DDRIVER_SENSE,S=
UGGEST_OK
sr 1:0:0:0: [sr0] Sense Key : Illegal Request [current]=20
sr 1:0:0:0: [sr0] Add. Sense: Logical block address out of range
end_request: I/O error, dev sr0, sector 64
isofs_fill_super: bread failed, dev=3Dsr0, iso_blknum=3D16, block=3D16
