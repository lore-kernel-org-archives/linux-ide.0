From: Mike Hayward <hayward@tenax.loup.net>
Subject: Re: Regression: my systems can no longer boot from an ide hard drive
Date: Thu, 25 Mar 2010 14:25:08 -0600
Message-ID: <201003252025.o2PKP8CS032185@tenax.loup.net>
References: <201003230801.o2N81UKg009750@alien.loup.net>
	 <20100323091718.5a57b6e1.randy.dunlap@oracle.com>
	 <4BA95AD1.2090906@gmail.com>
	 <201003240046.o2O0kvHU010541@alien.loup.net> <51f3faa71003241647l17d41171r7f2e4f1e6b773099@mail.gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from tenax.loup.net ([209.169.16.66]:56336 "EHLO tenax.loup.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754861Ab0CYUZb (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 25 Mar 2010 16:25:31 -0400
In-reply-to: <51f3faa71003241647l17d41171r7f2e4f1e6b773099@mail.gmail.com>
	(message from Robert Hancock on Wed, 24 Mar 2010 17:47:22 -0600)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: randy.dunlap@oracle.com, linux-ide@vger.kernel.org

Hi Robert,

 | This one looks normal.. so it only fails if you actually boot from the
 | IDE drive? That's a bit odd. What if you boot from a Fedora install
 | disc in rescue mode - can it see the drive then?
 | 
 | I'm not too familiar with the Ubuntu boot process - it could be the
 | kernel messages are set up to be so quiet you don't get any output
 | even if it can't mount the root file system, etc.

Yeah, I'm a RedHat man from the very first box they sent me back when
it seemed like a silly idea to "sell" free stuff.  Ubuntu still has
kinks to work out with their server or advanced installs for sure.

I narrowed the problem down with Fedora 12 x86_64.  You can dump into
grub at boot so it get's through 1.5 and I guess maybe to stage 2.  I
see no menu or config stuff when smashing F1 to get into it and can't
seem to drive it to do anything from it's command line.  But if I let
it run, it'll strap the kernel in just fine, but then the kernel
doesn't like the disks too well.

The problem appears to be with ident order I think.  During install
the ide drive is /dev/sda now with the newer kernels.  Even when
booting from the ide, it thinks the ide is on /dev/sda.  If you
install to a sata drive, it will be /dev/sda and the ide drive ends up
being idented after all sata at /dev/sdi!  Even via sata that threw me
off once and I ended up corrupting the boot drive with random ios.

I am appending fdisk output and the boot messages from one of these
opterons from the rescue mode with the ide drive mounted.  You can see
the ubuntu distro which will actually boot installed to one of the
much larger sata drives as well.

The other strange thing is that the boot messages if you let it run
claim it's trying to set up a raid array for some reason.  I never did
anything whatsoever related to raid on these partitions or drives.  No
idea why that is happening, but I will email you screen shots of that
seperately from my G1.

- Mike


Disk /dev/sda: 41.0 GB, 40982151168 bytes
255 heads, 63 sectors/track, 4982 cylinders
Units = cylinders of 16065 * 512 = 8225280 bytes
Disk identifier: 0x99999999

   Device Boot      Start         End      Blocks   Id  System
/dev/sda1   *           1          26      204800   83  Linux
Partition 1 does not end on cylinder boundary.
/dev/sda2              26         287     2097152   82  Linux swap / Solaris
Partition 2 does not end on cylinder boundary.
/dev/sda3             287        4982    37715931+  83  Linux

Disk /dev/sdb: 320.1 GB, 320072933376 bytes
255 heads, 63 sectors/track, 38913 cylinders
Units = cylinders of 16065 * 512 = 8225280 bytes
Disk identifier: 0x00087ccf

   Device Boot      Start         End      Blocks   Id  System
/dev/sdb1               1         243     1951866   82  Linux swap / Solaris
/dev/sdb2   *         244       38913   310616775   83  Linux

Disk /dev/sdc: 320.1 GB, 320072933376 bytes
255 heads, 63 sectors/track, 38913 cylinders
Units = cylinders of 16065 * 512 = 8225280 bytes
Disk identifier: 0x00000000


Disk /dev/sdd: 320.1 GB, 320072933376 bytes
255 heads, 63 sectors/track, 38913 cylinders
Units = cylinders of 16065 * 512 = 8225280 bytes
Disk identifier: 0x00000000


Disk /dev/sde: 320.1 GB, 320072933376 bytes
255 heads, 63 sectors/track, 38913 cylinders
Units = cylinders of 16065 * 512 = 8225280 bytes
Disk identifier: 0x00000000


Disk /dev/sdf: 320.1 GB, 320072933376 bytes
255 heads, 63 sectors/track, 38913 cylinders
Units = cylinders of 16065 * 512 = 8225280 bytes
Disk identifier: 0x00000000


Disk /dev/sdg: 320.1 GB, 320072933376 bytes
255 heads, 63 sectors/track, 38913 cylinders
Units = cylinders of 16065 * 512 = 8225280 bytes
Disk identifier: 0x00000000


Disk /dev/sdh: 320.1 GB, 320072933376 bytes
255 heads, 63 sectors/track, 38913 cylinders
Units = cylinders of 16065 * 512 = 8225280 bytes
Disk identifier: 0x00000000


Disk /dev/sdi: 320.1 GB, 320072933376 bytes
255 heads, 63 sectors/track, 38913 cylinders
Units = cylinders of 16065 * 512 = 8225280 bytes
Disk identifier: 0x00000000

Initializing cgroup subsys cpuset
Initializing cgroup subsys cpu
Linux version 2.6.31.5-127.fc12.x86_64 (mockbuild@x86-4.fedora.phx.redhat.com) (gcc version 4.4.2 20091027 (Red Hat 4.4.2-7) (GCC) ) #1 SMP Sat Nov 7 21:11:14 EST 2009
Command line: initrd=initrd.img stage2=hd:LABEL="Fedora" rescue BOOT_IMAGE=vmlinuz 
KERNEL supported cpus:
  Intel GenuineIntel
  AMD AuthenticAMD
  Centaur CentaurHauls
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000007fff0000 (usable)
 BIOS-e820: 000000007fff0000 - 000000007ffff000 (ACPI data)
 BIOS-e820: 000000007ffff000 - 0000000080000000 (ACPI NVS)
 BIOS-e820: 00000000ff7c0000 - 0000000100000000 (reserved)
DMI 2.3 present.
AMI BIOS detected: BIOS may corrupt low RAM, working around it.
e820 update range: 0000000000000000 - 0000000000010000 (usable) ==> (reserved)
last_pfn = 0x7fff0 max_arch_pfn = 0x400000000
MTRR default type: uncachable
MTRR fixed ranges enabled:
  00000-9FFFF write-back
  A0000-EFFFF uncachable
  F0000-FFFFF write-protect
MTRR variable ranges enabled:
  0 base 0000000000 mask FF80000000 write-back
  1 disabled
  2 disabled
  3 disabled
  4 disabled
  5 disabled
  6 disabled
  7 disabled
x86 PAT enabled: cpu 0, old 0x7040600070406, new 0x7010600070106
initial memory mapped : 0 - 20000000
init_memory_mapping: 0000000000000000-000000007fff0000
 0000000000 - 007fe00000 page 2M
 007fe00000 - 007fff0000 page 4k
kernel direct mapping tables up to 7fff0000 @ 10000-14000
RAMDISK: 7e95b000 - 7ffce474
ACPI: RSDP 00000000000f4620 00014 (v00 ACPIAM)
ACPI: RSDT 000000007fff0000 00034 (v01 A M I  OEMRSDT  10000304 MSFT 00000097)
ACPI: FACP 000000007fff0200 00081 (v02 A M I  OEMFACP  10000304 MSFT 00000097)
ACPI: DSDT 000000007fff0400 03086 (v01  0AAAA 0AAAA000 00000000 INTL 02002026)
ACPI: FACS 000000007ffff000 00040
ACPI: APIC 000000007fff0380 00074 (v01 A M I  OEMAPIC  10000304 MSFT 00000097)
ACPI: OEMB 000000007ffff040 0005E (v01 A M I  OEMBIOS  10000304 MSFT 00000097)
ACPI: ASF! 000000007fff3490 00086 (v16 AMIASF AMDSTRET 00000001 INTL 02002026)
ACPI: Local APIC address 0xfee00000
Scanning NUMA topology in Northbridge 24
Number of nodes 2
Node 0 MemBase 0000000000000000 Limit 0000000040000000
Node 1 MemBase 0000000040000000 Limit 000000007fff0000
NUMA: Using 30 for the hash shift.
Using node hash shift of 30
found SMP MP-table at [ffff8800000ff780] ff780
ACPI: Local APIC address 0xfee00000
Bootmem setup node 0 0000000000000000-0000000040000000
  NODE_DATA [0000000000012000 - 0000000000027fff]
  bootmap [0000000000028000 -  000000000002ffff] pages 8
(7 early reservations) ==> bootmem [0000000000 - 0040000000]
  #0 [0000000000 - 0000001000]   BIOS data page ==> [0000000000 - 0000001000]
  #1 [0000006000 - 0000008000]       TRAMPOLINE ==> [0000006000 - 0000008000]
  #2 [0001000000 - 00019adb00]    TEXT DATA BSS ==> [0001000000 - 00019adb00]
  #3 [007e95b000 - 007ffce474]          RAMDISK
  #4 [000009d400 - 0000100000]    BIOS reserved ==> [000009d400 - 0000100000]
  #5 [00019ae000 - 00019ae280]              BRK ==> [00019ae000 - 00019ae280]
  #6 [0000010000 - 0000012000]          PGTABLE ==> [0000010000 - 0000012000]
Bootmem setup node 1 0000000040000000-000000007fff0000
  NODE_DATA [0000000040000000 - 0000000040015fff]
  bootmap [0000000040016000 -  000000004001dfff] pages 8
(7 early reservations) ==> bootmem [0040000000 - 007fff0000]
  #0 [0000000000 - 0000001000]   BIOS data page
  #1 [0000006000 - 0000008000]       TRAMPOLINE
  #2 [0001000000 - 00019adb00]    TEXT DATA BSS
  #3 [007e95b000 - 007ffce474]          RAMDISK ==> [007e95b000 - 007ffce474]
  #4 [000009d400 - 0000100000]    BIOS reserved
  #5 [00019ae000 - 00019ae280]              BRK
  #6 [0000010000 - 0000012000]          PGTABLE
found SMP MP-table at [ffff8800000ff780] ff780
 [ffffea0000000000-ffffea0000dfffff] PMD -> [ffff880001e00000-ffff880002bfffff] on node 0
 [ffffea0000e00000-ffffea0001bfffff] PMD -> [ffff880040200000-ffff880040ffffff] on node 1
Zone PFN ranges:
  DMA      0x00000010 -> 0x00001000
  DMA32    0x00001000 -> 0x00100000
  Normal   0x00100000 -> 0x00100000
Movable zone start PFN for each node
early_node_map[3] active PFN ranges
    0: 0x00000010 -> 0x0000009f
    0: 0x00000100 -> 0x00040000
    1: 0x00040000 -> 0x0007fff0
On node 0 totalpages: 262031
  DMA zone: 56 pages used for memmap
  DMA zone: 103 pages reserved
  DMA zone: 3824 pages, LIFO batch:0
  DMA32 zone: 3528 pages used for memmap
  DMA32 zone: 254520 pages, LIFO batch:31
On node 1 totalpages: 262128
  DMA32 zone: 3584 pages used for memmap
  DMA32 zone: 258544 pages, LIFO batch:31
ACPI: PM-Timer IO Port: 0x5008
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, GSI 0-23
ACPI: IOAPIC (id[0x03] address[0xfebff000] gsi_base[24])
IOAPIC[1]: apic_id 3, version 17, address 0xfebff000, GSI 24-27
ACPI: IOAPIC (id[0x04] address[0xfebfe000] gsi_base[28])
IOAPIC[2]: apic_id 4, version 17, address 0xfebfe000, GSI 28-31
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Using ACPI (MADT) for SMP configuration information
SMP: Allowing 2 CPUs, 0 hotplug CPUs
nr_irqs_gsi: 32
PM: Registered nosave memory: 000000000009f000 - 00000000000a0000
PM: Registered nosave memory: 00000000000a0000 - 00000000000e0000
PM: Registered nosave memory: 00000000000e0000 - 0000000000100000
Allocating PCI resources starting at 80000000 (gap: 80000000:7f7c0000)
NR_CPUS:256 nr_cpumask_bits:256 nr_cpu_ids:2 nr_node_ids:2
PERCPU: Remapped at ffffc90000000000 with large pages, static data 90080 bytes
Built 2 zonelists in Node order, mobility grouping on.  Total pages: 516888
Policy zone: DMA32
Kernel command line: initrd=initrd.img stage2=hd:LABEL="Fedora" rescue BOOT_IMAGE=vmlinuz 
PID hash table entries: 4096 (order: 12, 32768 bytes)
Initializing CPU#0
Checking aperture...
No AGP bridge found
Node 0: aperture @ eff2000000 size 32 MB
Aperture beyond 4GB. Ignoring.
Memory: 2034480k/2097088k available (4227k kernel code, 452k absent, 62156k reserved, 2926k data, 1324k init)
SLUB: Genslabs=14, HWalign=64, Order=0-3, MinObjects=0, CPUs=2, Nodes=2
Hierarchical RCU implementation.
NR_IRQS:4352 nr_irqs:512
Fast TSC calibration failed
TSC: PIT calibration matches PMTIMER. 2 loops
Detected 1397.518 MHz processor.
Console: colour VGA+ 80x25
console [tty0] enabled
allocated 20971520 bytes of page_cgroup
please try 'cgroup_disable=memory' option if you don't want memory cgroups
Calibrating delay loop (skipped), value calculated using timer frequency.. 2795.03 BogoMIPS (lpj=1397518)
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
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 0/0x0 -> Node 0
tseg: 0000000000
mce: CPU supports 5 MCE banks
Performance Counters: AMD PMU driver.
... version:                 0
... bit width:               48
... generic counters:        4
... value mask:              0000ffffffffffff
... max period:              00007fffffffffff
... fixed-purpose counters:  0
... counter mask:            000000000000000f
ACPI: Core revision 20090521
ftrace: converting mcount calls to 0f 1f 44 00 00
ftrace: allocating 20852 entries in 82 pages
Setting APIC routing to flat
..TIMER: vector=0x30 apic1=0 pin1=2 apic2=0 pin2=0
CPU0: AMD Opteron(tm) Processor 240 stepping 01
Booting processor 1 APIC 0x1 ip 0x6000
Initializing CPU#1
Calibrating delay using timer specific routine.. 2794.47 BogoMIPS (lpj=1397235)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 1/0x1 -> Node 1
mce: CPU supports 5 MCE banks
x86 PAT enabled: cpu 1, old 0x7040600070406, new 0x7010600070106
CPU1: AMD Opteron(tm) Processor 240 stepping 01
Brought up 2 CPUs
Total of 2 processors activated (5589.50 BogoMIPS).
sizeof(vma)=176 bytes
sizeof(page)=56 bytes
sizeof(inode)=584 bytes
sizeof(dentry)=192 bytes
sizeof(ext3inode)=776 bytes
sizeof(buffer_head)=104 bytes
sizeof(skbuff)=248 bytes
sizeof(task_struct)=6008 bytes
CPU0 attaching sched-domain:
 domain 0: span 0-1 level NODE
  groups: 0 1
CPU1 attaching sched-domain:
 domain 0: span 0-1 level NODE
  groups: 1 0
Booting paravirtualized kernel on bare hardware
regulator: core version 0.5
Time: 19:57:49  Date: 03/25/10
NET: Registered protocol family 16
node 0 link 0: io port [0, ffffff]
TOM: 0000000080000000 aka 2048M
node 0 link 0: mmio [a0000, bffff]
node 0 link 0: mmio [80000000, ffffffff]
bus: [00,ff] on node 0 link 0
bus: 00 index 0 io port: [0, ffff]
bus: 00 index 1 mmio: [a0000, bffff]
bus: 00 index 2 mmio: [80000000, fcffffffff]
ACPI: bus type pci registered
PCI: Using configuration type 1 for base access
bio: create slab <bio-0> at 0
ACPI: EC: Look up EC in DSDT
ACPI: Interpreter enabled
ACPI: (supports S0 S1 S4 S5)
ACPI: Using IOAPIC for interrupt routing
ACPI: No dock devices found.
ACPI: PCI Root Bridge [PCI0] (0000:00)
pci 0000:00:07.1: reg 20 io port: [0xffa0-0xffaf]
pci 0000:00:07.2: reg 10 io port: [0xcc00-0xcc1f]
pci 0000:00:0a.1: reg 10 64bit mmio: [0xfebff000-0xfebfffff]
pci 0000:00:0b.1: reg 10 64bit mmio: [0xfebfe000-0xfebfefff]
pci 0000:03:00.0: reg 10 32bit mmio: [0xfeafc000-0xfeafcfff]
pci 0000:03:00.1: reg 10 32bit mmio: [0xfeafd000-0xfeafdfff]
pci 0000:03:05.0: reg 10 io port: [0xac00-0xac07]
pci 0000:03:05.0: reg 14 io port: [0xa480-0xa483]
pci 0000:03:05.0: reg 18 io port: [0xa400-0xa407]
pci 0000:03:05.0: reg 1c io port: [0xa080-0xa083]
pci 0000:03:05.0: reg 20 io port: [0xa000-0xa00f]
pci 0000:03:05.0: reg 24 32bit mmio: [0xfeafec00-0xfeafefff]
pci 0000:03:05.0: reg 30 32bit mmio: [0xfea00000-0xfea7ffff]
pci 0000:03:05.0: supports D1 D2
pci 0000:03:06.0: reg 10 32bit mmio: [0xfd000000-0xfdffffff]
pci 0000:03:06.0: reg 14 io port: [0xa800-0xa8ff]
pci 0000:03:06.0: reg 18 32bit mmio: [0xfeaff000-0xfeafffff]
pci 0000:03:06.0: reg 30 32bit mmio: [0xfeac0000-0xfeadffff]
pci 0000:03:06.0: supports D1 D2
pci 0000:03:08.0: reg 10 32bit mmio: [0xfeafb000-0xfeafbfff]
pci 0000:03:08.0: reg 14 io port: [0x9c00-0x9c3f]
pci 0000:03:08.0: reg 18 32bit mmio: [0xfeaa0000-0xfeabffff]
pci 0000:03:08.0: supports D1 D2
pci 0000:03:08.0: PME# supported from D0 D1 D2 D3hot D3cold
pci 0000:03:08.0: PME# disabled
pci 0000:00:06.0: bridge io port: [0x9000-0xafff]
pci 0000:00:06.0: bridge 32bit mmio: [0xfc900000-0xfeafffff]
pci 0000:00:06.0: bridge 32bit mmio pref: [0xff500000-0xff5fffff]
pci 0000:02:02.0: reg 10 io port: [0x8c00-0x8c7f]
pci 0000:02:02.0: reg 18 io port: [0x8800-0x88ff]
pci 0000:02:02.0: reg 1c 32bit mmio: [0xfc8ff000-0xfc8fffff]
pci 0000:02:02.0: reg 20 32bit mmio: [0xfc8c0000-0xfc8dffff]
pci 0000:02:02.0: reg 30 32bit mmio: [0xfc8f0000-0xfc8f7fff]
pci 0000:02:02.0: supports D1
pci 0000:02:09.0: reg 10 64bit mmio: [0xfc890000-0xfc89ffff]
pci 0000:02:09.0: reg 18 64bit mmio: [0xfc880000-0xfc88ffff]
pci 0000:02:09.0: reg 30 32bit mmio: [0xfc870000-0xfc87ffff]
pci 0000:02:09.0: PME# supported from D3hot D3cold
pci 0000:02:09.0: PME# disabled
pci 0000:02:09.1: reg 10 64bit mmio: [0xfc8e0000-0xfc8effff]
pci 0000:02:09.1: reg 18 64bit mmio: [0xfc8b0000-0xfc8bffff]
pci 0000:02:09.1: reg 30 32bit mmio: [0xfc8a0000-0xfc8affff]
pci 0000:02:09.1: PME# supported from D3hot D3cold
pci 0000:02:09.1: PME# disabled
pci 0000:00:0a.0: bridge io port: [0x8000-0x8fff]
pci 0000:00:0a.0: bridge 32bit mmio: [0xfc700000-0xfc8fffff]
pci 0000:00:0a.0: bridge 64bit mmio pref: [0xff400000-0xff4fffff]
pci 0000:01:03.0: reg 10 io port: [0x7c00-0x7c7f]
pci 0000:01:03.0: reg 18 io port: [0x7800-0x78ff]
pci 0000:01:03.0: reg 1c 32bit mmio: [0xfc6ff000-0xfc6fffff]
pci 0000:01:03.0: reg 20 32bit mmio: [0xfc6c0000-0xfc6dffff]
pci 0000:01:03.0: reg 30 32bit mmio: [0xfc6f0000-0xfc6f7fff]
pci 0000:01:03.0: supports D1
pci 0000:00:0b.0: bridge io port: [0x7000-0x7fff]
pci 0000:00:0b.0: bridge 32bit mmio: [0xfc600000-0xfc6fffff]
pci 0000:00:0b.0: bridge 64bit mmio pref: [0xff300000-0xff3fffff]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.GOLA._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.GOLB._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
vgaarb: device added: PCI:0000:03:06.0,decodes=io+mem,owns=io+mem,locks=none
vgaarb: loaded
SCSI subsystem initialized
libata version 3.00 loaded.
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
PCI: Using ACPI for IRQ routing
PCI: pci_cache_line_size set to 64 bytes
NetLabel: Initializing
NetLabel:  domain hash size = 128
NetLabel:  protocols = UNLABELED CIPSOv4
NetLabel:  unlabeled traffic allowed by default
pnp: PnP ACPI init
ACPI: bus type pnp registered
pnp: PnP ACPI: found 13 devices
ACPI: ACPI bus type pnp unregistered
system 00:09: ioport range 0x680-0x6ff has been reserved
system 00:09: ioport range 0x295-0x296 has been reserved
system 00:09: ioport range 0x778-0x77f has been reserved
system 00:09: ioport range 0xb78-0xb7f has been reserved
system 00:09: ioport range 0xf78-0xf7f has been reserved
system 00:0a: ioport range 0x4d0-0x4d1 has been reserved
system 00:0a: ioport range 0x5000-0x50bf has been reserved
system 00:0a: ioport range 0x50e0-0x50ff has been reserved
system 00:0a: ioport range 0x50c0-0x50df has been reserved
system 00:0a: ioport range 0xde00-0xde7f has been reserved
system 00:0a: ioport range 0xde80-0xdeff has been reserved
system 00:0b: iomem range 0xfec00000-0xfec00fff could not be reserved
system 00:0b: iomem range 0xfee00000-0xfee00fff has been reserved
system 00:0b: iomem range 0xfff80000-0xffffffff has been reserved
system 00:0c: iomem range 0x0-0x9ffff could not be reserved
system 00:0c: iomem range 0xc0000-0xdffff has been reserved
system 00:0c: iomem range 0xe0000-0xfffff could not be reserved
system 00:0c: iomem range 0x100000-0x7fffffff could not be reserved
pci 0000:00:06.0: PCI bridge, secondary bus 0000:03
Switched to high resolution mode on CPU 0
pci 0000:00:06.0:   IO window: 0x9000-0xafff
pci 0000:00:06.0:   MEM window: 0xfc900000-0xfeafffff
pci 0000:00:06.0:   PREFETCH window: 0xff500000-0xff5fffff
Switched to high resolution mode on CPU 1
pci 0000:00:0a.0: PCI bridge, secondary bus 0000:02
pci 0000:00:0a.0:   IO window: 0x8000-0x8fff
pci 0000:00:0a.0:   MEM window: 0xfc700000-0xfc8fffff
pci 0000:00:0a.0:   PREFETCH window: 0x000000ff400000-0x000000ff4fffff
pci 0000:00:0b.0: PCI bridge, secondary bus 0000:01
pci 0000:00:0b.0:   IO window: 0x7000-0x7fff
pci 0000:00:0b.0:   MEM window: 0xfc600000-0xfc6fffff
pci 0000:00:0b.0:   PREFETCH window: 0x000000ff300000-0x000000ff3fffff
pci_bus 0000:00: resource 0 io:  [0x00-0xffff]
pci_bus 0000:00: resource 1 mem: [0x000000-0xffffffffffffffff]
pci_bus 0000:03: resource 0 io:  [0x9000-0xafff]
pci_bus 0000:03: resource 1 mem: [0xfc900000-0xfeafffff]
pci_bus 0000:03: resource 2 pref mem [0xff500000-0xff5fffff]
pci_bus 0000:02: resource 0 io:  [0x8000-0x8fff]
pci_bus 0000:02: resource 1 mem: [0xfc700000-0xfc8fffff]
pci_bus 0000:02: resource 2 pref mem [0xff400000-0xff4fffff]
pci_bus 0000:01: resource 0 io:  [0x7000-0x7fff]
pci_bus 0000:01: resource 1 mem: [0xfc600000-0xfc6fffff]
pci_bus 0000:01: resource 2 pref mem [0xff300000-0xff3fffff]
NET: Registered protocol family 2
IP route cache hash table entries: 65536 (order: 7, 524288 bytes)
TCP established hash table entries: 262144 (order: 10, 4194304 bytes)
TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
TCP: Hash tables configured (established 262144 bind 65536)
TCP reno registered
NET: Registered protocol family 1
Trying to unpack rootfs image as initramfs...
Freeing initrd memory: 22989k freed
audit: initializing netlink socket (disabled)
type=2000 audit(1269547069.989:1): initialized
HugeTLB registered 2 MB page size, pre-allocated 0 pages
VFS: Disk quotas dquot_6.5.2
Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
msgmni has been set to 4018
SELinux:  Registering netfilter hooks
alg: No test for stdrng (krng)
Block layer SCSI generic (bsg) driver version 0.4 loaded (major 252)
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
boot interrupts on PCI device 0x1022:0x746b already disabled
pci 0000:00:0a.0: MSI quirk detected; subordinate MSI disabled
disabled boot interrupts on PCI device 0x1022:0x7450
pci 0000:00:0a.0: AMD8131 rev 12 detected; disabling PCI-X MMRBC
pci 0000:00:0b.0: MSI quirk detected; subordinate MSI disabled
disabled boot interrupts on PCI device 0x1022:0x7450
pci 0000:00:0b.0: AMD8131 rev 12 detected; disabling PCI-X MMRBC
pci 0000:03:06.0: Boot video device
pci 0000:03:08.0: Firmware left e100 interrupts enabled; disabling
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
pciehp: PCI Express Hot Plug Controller Driver version: 0.4
acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input0
ACPI: Power Button [PWRF]
input: Power Button as /devices/LNXSYSTM:00/device:00/PNP0C0C:00/input/input1
ACPI: Power Button [PWRB]
ACPI: processor limited to max C-state 1
processor LNXCPU:00: registered as cooling_device0
ACPI: Processor [CPU0] (supports 8 throttling states)
processor LNXCPU:01: registered as cooling_device1
Non-volatile memory driver v1.3
Linux agpgart interface v0.103
Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
00:05: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
00:06: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
brd: module loaded
loop: module loaded
input: Macintosh mouse button emulation as /devices/virtual/input/input2
Fixed MDIO Bus: probed
ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
  alloc irq_desc for 19 on node 0
  alloc kstat_irqs on node 0
ohci_hcd 0000:03:00.0: PCI INT D -> GSI 19 (level, low) -> IRQ 19
ohci_hcd 0000:03:00.0: OHCI Host Controller
ohci_hcd 0000:03:00.0: new USB bus registered, assigned bus number 1
ohci_hcd 0000:03:00.0: irq 19, io mem 0xfeafc000
usb usb1: New USB device found, idVendor=1d6b, idProduct=0001
usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb1: Product: OHCI Host Controller
usb usb1: Manufacturer: Linux 2.6.31.5-127.fc12.x86_64 ohci_hcd
usb usb1: SerialNumber: 0000:03:00.0
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 3 ports detected
ohci_hcd 0000:03:00.1: PCI INT D -> GSI 19 (level, low) -> IRQ 19
ohci_hcd 0000:03:00.1: OHCI Host Controller
ohci_hcd 0000:03:00.1: new USB bus registered, assigned bus number 2
ohci_hcd 0000:03:00.1: irq 19, io mem 0xfeafd000
usb usb2: New USB device found, idVendor=1d6b, idProduct=0001
usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb2: Product: OHCI Host Controller
usb usb2: Manufacturer: Linux 2.6.31.5-127.fc12.x86_64 ohci_hcd
usb usb2: SerialNumber: 0000:03:00.1
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 3 ports detected
uhci_hcd: USB Universal Host Controller Interface driver
PNP: No PS/2 controller found. Probing ports directly.
serio: i8042 KBD port at 0x60,0x64 irq 1
serio: i8042 AUX port at 0x60,0x64 irq 12
mice: PS/2 mouse device common for all mice
rtc_cmos 00:02: RTC can wake from S4
rtc_cmos 00:02: rtc core: registered rtc_cmos as rtc0
rtc0: alarms up to one year, y3k, 114 bytes nvram
device-mapper: uevent: version 1.0.3
device-mapper: ioctl: 4.15.0-ioctl (2009-04-01) initialised: dm-devel@redhat.com
cpuidle: using governor ladder
cpuidle: using governor menu
usbcore: registered new interface driver hiddev
usbcore: registered new interface driver usbhid
usbhid: v2.6:USB HID core driver
nf_conntrack version 0.5.0 (16384 buckets, 65536 max)
CONFIG_NF_CT_ACCT is deprecated and will be removed soon. Please use
nf_conntrack.acct=1 kernel parameter, acct=1 nf_conntrack module option or
sysctl net.netfilter.nf_conntrack_acct=1 to enable it.
ip_tables: (C) 2000-2006 Netfilter Core Team
TCP cubic registered
Initializing XFRM netlink socket
NET: Registered protocol family 17
PM: Resume from disk failed.
registered taskstats version 1
No TPM chip found, activating TPM-bypass!
  Magic number: 2:319:1002
pnp 00:04: hash matches
rtc_cmos 00:02: setting system clock to 2010-03-25 19:57:51 UTC (1269547071)
Initalizing network drop monitor service
Freeing unused kernel memory: 1324k freed
Write protecting the kernel read-only data: 6344k
usb 1-3: new low speed USB device using ohci_hcd and address 2
usb 1-3: New USB device found, idVendor=1241, idProduct=f760
usb 1-3: New USB device strings: Mfr=1, Product=2, SerialNumber=0
usb 1-3: Product: Wireless Keyboard/Mouse(2.4G)
usb 1-3: Manufacturer:   
usb 1-3: configuration #1 chosen from 1 choice
input:    Wireless Keyboard/Mouse(2.4G) as /devices/pci0000:00/0000:00:06.0/0000:03:00.0/usb1/1-3/1-3:1.0/input/input3
generic-usb 0003:1241:F760.0001: input,hidraw0: USB HID v1.10 Keyboard [   Wireless Keyboard/Mouse(2.4G)] on usb-0000:03:00.0-3/input0
input:    Wireless Keyboard/Mouse(2.4G) as /devices/pci0000:00/0000:00:06.0/0000:03:00.0/usb1/1-3/1-3:1.1/input/input4
generic-usb 0003:1241:F760.0002: input,hidraw1: USB HID v1.10 Mouse [   Wireless Keyboard/Mouse(2.4G)] on usb-0000:03:00.0-3/input1
squashfs: version 4.0 (2009/01/31) Phillip Lougher
Loading iSCSI transport class v2.0-870.
iscsi: registered transport (tcp)
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
BIOS EDD facility v0.16 2004-Jun-25, 6 devices found
input: PC Speaker as /devices/platform/pcspkr/input/input5
No iBFT detected.
e100: Intel(R) PRO/100 Network Driver, 3.5.24-k2-NAPI
e100: Copyright(c) 1999-2006 Intel Corporation
pata_amd 0000:00:07.1: version 0.4.1
scsi0 : pata_amd
scsi1 : pata_amd
ata1: PATA max UDMA/133 cmd 0x1f0 ctl 0x3f6 bmdma 0xffa0 irq 14
ata2: PATA max UDMA/133 cmd 0x170 ctl 0x376 bmdma 0xffa8 irq 15
sata_promise 0000:02:02.0: version 2.12
  alloc irq_desc for 26 on node 0
  alloc kstat_irqs on node 0
sata_promise 0000:02:02.0: PCI INT A -> GSI 26 (level, low) -> IRQ 26
scsi2 : sata_promise
  alloc irq_desc for 18 on node 0
  alloc kstat_irqs on node 0
e100 0000:03:08.0: PCI INT A -> GSI 18 (level, low) -> IRQ 18
e100 0000:03:08.0: PME# disabled
scsi3 : sata_promise
scsi4 : sata_promise
ata1.00: ATA-6: Maxtor 4D040H2, DAH017K0, max UDMA/100
ata1.00: 80043264 sectors, multi 16: LBA 
ata1.01: ATAPI: SONY    DVD RW AW-G540A, 1.30, max UDMA/33
ata1.00: configured for UDMA/100
ata1.01: configured for UDMA/33
scsi 0:0:0:0: Direct-Access     ATA      Maxtor 4D040H2   DAH0 PQ: 0 ANSI: 5
sd 0:0:0:0: Attached scsi generic sg0 type 0
scsi 0:0:1:0: CD-ROM            SONY     DVD RW AW-G540A  1.30 PQ: 0 ANSI: 5
sr0: scsi3-mmc drive: 24x/24x writer dvd-ram cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.20
sr 0:0:1:0: Attached scsi CD-ROM sr0
sr 0:0:1:0: Attached scsi generic sg1 type 5
sd 0:0:0:0: [sda] 80043264 512-byte logical blocks: (40.9 GB/38.1 GiB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sda:
scsi5 : sata_promise
ata3: SATA max UDMA/133 mmio m4096@0xfc8ff000 ata 0xfc8ff380 irq 26
ata4: SATA max UDMA/133 mmio m4096@0xfc8ff000 ata 0xfc8ff280 irq 26
ata5: SATA max UDMA/133 mmio m4096@0xfc8ff000 ata 0xfc8ff200 irq 26
ata6: SATA max UDMA/133 mmio m4096@0xfc8ff000 ata 0xfc8ff300 irq 26
 sda1 sda2 sda3
  alloc irq_desc for 28 on node 0
  alloc kstat_irqs on node 0
sata_promise 0000:01:03.0: PCI INT A -> GSI 28 (level, low) -> IRQ 28
scsi6 : sata_promise
tg3.c:v3.99 (April 20, 2009)
  alloc irq_desc for 24 on node 0
  alloc kstat_irqs on node 0
tg3 0000:02:09.0: PCI INT A -> GSI 24 (level, low) -> IRQ 24
scsi7 : sata_promise
scsi8 : sata_promise
tg3 0000:02:09.0: wake-up capability disabled by ACPI
tg3 0000:02:09.0: PME# disabled
scsi9 : sata_promise
ata7: SATA max UDMA/133 mmio m4096@0xfc6ff000 ata 0xfc6ff380 irq 28
ata8: SATA max UDMA/133 mmio m4096@0xfc6ff000 ata 0xfc6ff280 irq 28
ata9: SATA max UDMA/133 mmio m4096@0xfc6ff000 ata 0xfc6ff200 irq 28
ata10: SATA max UDMA/133 mmio m4096@0xfc6ff000 ata 0xfc6ff300 irq 28
eth0: Tigon3 [partno(BCM95704A7) rev 2003] (PCI:66MHz:64-bit) MAC address 00:e0:81:28:67:9a
eth0: attached PHY is 5704 (10/100/1000Base-T Ethernet) (WireSpeed[1])
eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] TSOcap[1]
eth0: dma_rwctrl[763f0000] dma_mask[64-bit]
  alloc irq_desc for 25 on node 0
  alloc kstat_irqs on node 0
tg3 0000:02:09.1: PCI INT B -> GSI 25 (level, low) -> IRQ 25
sd 0:0:0:0: [sda] Attached SCSI disk
tg3 0000:02:09.1: PME# disabled
e100: eth1: e100_probe: addr 0xfeafb000, irq 18, MAC addr 00:e0:81:28:67:65
sata_sil 0000:03:05.0: version 2.4
sata_sil 0000:03:05.0: PCI INT A -> GSI 19 (level, low) -> IRQ 19
sata_sil 0000:03:05.0: Applying R_ERR on DMA activate FIS errata fix
scsi10 : sata_sil
eth2: Tigon3 [partno(BCM95704A7) rev 2003] (PCI:66MHz:64-bit) MAC address 00:e0:81:28:67:9b
eth2: attached PHY is 5704 (10/100/1000Base-T Ethernet) (WireSpeed[1])
eth2: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] TSOcap[1]
eth2: dma_rwctrl[763f0000] dma_mask[64-bit]
scsi11 : sata_sil
scsi12 : sata_sil
scsi13 : sata_sil
ata11: SATA max UDMA/100 mmio m1024@0xfeafec00 tf 0xfeafec80 irq 19
ata12: SATA max UDMA/100 mmio m1024@0xfeafec00 tf 0xfeafecc0 irq 19
ata13: SATA max UDMA/100 mmio m1024@0xfeafec00 tf 0xfeafee80 irq 19
ata14: SATA max UDMA/100 mmio m1024@0xfeafec00 tf 0xfeafeec0 irq 19
ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata7: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata11: SATA link down (SStatus 0 SControl 310)
ata3.00: ATA-7: ST3320620AS, 3.AAJ, max UDMA/133
ata3.00: 625142448 sectors, multi 0: LBA48 NCQ (depth 0/32)
ata7.00: ATA-7: ST3320620AS, 3.AAJ, max UDMA/133
ata7.00: 625142448 sectors, multi 0: LBA48 NCQ (depth 0/32)
ata3.00: configured for UDMA/133
scsi 2:0:0:0: Direct-Access     ATA      ST3320620AS      3.AA PQ: 0 ANSI: 5
sd 2:0:0:0: Attached scsi generic sg2 type 0
sd 2:0:0:0: [sdb] 625142448 512-byte logical blocks: (320 GB/298 GiB)
sd 2:0:0:0: [sdb] Write Protect is off
sd 2:0:0:0: [sdb] Mode Sense: 00 3a 00 00
sd 2:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sdb:
ata7.00: configured for UDMA/133
 sdb1 sdb2
sd 2:0:0:0: [sdb] Attached SCSI disk
ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata4.00: ATA-7: ST3320620AS, 3.AAJ, max UDMA/133
ata4.00: 625142448 sectors, multi 0: LBA48 NCQ (depth 0/32)
ata4.00: configured for UDMA/133
ata4: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0xf t4
ata4: hotplug_status 0x22
ata4: hard resetting link
ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata4.00: configured for UDMA/133
ata4: EH complete
scsi 3:0:0:0: Direct-Access     ATA      ST3320620AS      3.AA PQ: 0 ANSI: 5
sd 3:0:0:0: Attached scsi generic sg3 type 0
sd 3:0:0:0: [sdc] 625142448 512-byte logical blocks: (320 GB/298 GiB)
sd 3:0:0:0: [sdc] Write Protect is off
sd 3:0:0:0: [sdc] Mode Sense: 00 3a 00 00
sd 3:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sdc: unknown partition table
sd 3:0:0:0: [sdc] Attached SCSI disk
ata5: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata5.00: ATA-7: ST3320620AS, 3.AAJ, max UDMA/133
ata5.00: 625142448 sectors, multi 0: LBA48 NCQ (depth 0/32)
ata5.00: configured for UDMA/133
ata5: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0xf t4
ata5: hotplug_status 0x11
ata5: hard resetting link
ata5: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata5.00: configured for UDMA/133
ata5: EH complete
scsi 4:0:0:0: Direct-Access     ATA      ST3320620AS      3.AA PQ: 0 ANSI: 5
sd 4:0:0:0: Attached scsi generic sg4 type 0
sd 4:0:0:0: [sdd] 625142448 512-byte logical blocks: (320 GB/298 GiB)
sd 4:0:0:0: [sdd] Write Protect is off
sd 4:0:0:0: [sdd] Mode Sense: 00 3a 00 00
sd 4:0:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sdd: unknown partition table
sd 4:0:0:0: [sdd] Attached SCSI disk
ata6: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata6.00: ATA-7: ST3320620AS, 3.AAJ, max UDMA/133
ata6.00: 625142448 sectors, multi 0: LBA48 NCQ (depth 0/32)
ata6.00: configured for UDMA/133
ata6: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0xf t4
ata6: hotplug_status 0x44
ata6: hard resetting link
ata6: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata6.00: configured for UDMA/133
ata6: EH complete
scsi 5:0:0:0: Direct-Access     ATA      ST3320620AS      3.AA PQ: 0 ANSI: 5
sd 5:0:0:0: Attached scsi generic sg5 type 0
sd 5:0:0:0: [sde] 625142448 512-byte logical blocks: (320 GB/298 GiB)
sd 5:0:0:0: [sde] Write Protect is off
sd 5:0:0:0: [sde] Mode Sense: 00 3a 00 00
sd 5:0:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sde:
scsi 6:0:0:0: Direct-Access     ATA      ST3320620AS      3.AA PQ: 0 ANSI: 5
sd 6:0:0:0: Attached scsi generic sg6 type 0
sd 6:0:0:0: [sdf] 625142448 512-byte logical blocks: (320 GB/298 GiB)
sd 6:0:0:0: [sdf] Write Protect is off
sd 6:0:0:0: [sdf] Mode Sense: 00 3a 00 00
sd 6:0:0:0: [sdf] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sdf: unknown partition table
sd 6:0:0:0: [sdf] Attached SCSI disk
 unknown partition table
sd 5:0:0:0: [sde] Attached SCSI disk
ata8: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata8.00: ATA-7: ST3320620AS, 3.AAJ, max UDMA/133
ata8.00: 625142448 sectors, multi 0: LBA48 NCQ (depth 0/32)
ata8.00: configured for UDMA/133
ata8: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0xf t4
ata8: hotplug_status 0x22
ata8: hard resetting link
ata8: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata8.00: configured for UDMA/133
ata8: EH complete
scsi 7:0:0:0: Direct-Access     ATA      ST3320620AS      3.AA PQ: 0 ANSI: 5
sd 7:0:0:0: Attached scsi generic sg7 type 0
sd 7:0:0:0: [sdg] 625142448 512-byte logical blocks: (320 GB/298 GiB)
sd 7:0:0:0: [sdg] Write Protect is off
sd 7:0:0:0: [sdg] Mode Sense: 00 3a 00 00
sd 7:0:0:0: [sdg] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sdg: unknown partition table
sd 7:0:0:0: [sdg] Attached SCSI disk
ata9: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata9.00: ATA-7: ST3320620AS, 3.AAJ, max UDMA/133
ata9.00: 625142448 sectors, multi 0: LBA48 NCQ (depth 0/32)
ata9.00: configured for UDMA/133
ata9: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0xf t4
ata9: hotplug_status 0x11
ata9: hard resetting link
ata9: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata9.00: configured for UDMA/133
ata9: EH complete
scsi 8:0:0:0: Direct-Access     ATA      ST3320620AS      3.AA PQ: 0 ANSI: 5
sd 8:0:0:0: Attached scsi generic sg8 type 0
sd 8:0:0:0: [sdh] 625142448 512-byte logical blocks: (320 GB/298 GiB)
sd 8:0:0:0: [sdh] Write Protect is off
sd 8:0:0:0: [sdh] Mode Sense: 00 3a 00 00
sd 8:0:0:0: [sdh] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sdh: unknown partition table
sd 8:0:0:0: [sdh] Attached SCSI disk
ata10: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata10.00: ATA-7: ST3320620AS, 3.AAJ, max UDMA/133
ata10.00: 625142448 sectors, multi 0: LBA48 NCQ (depth 0/32)
ata10.00: configured for UDMA/133
ata10: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0xf t4
ata10: hotplug_status 0x44
ata10: hard resetting link
ata10: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata10.00: configured for UDMA/133
ata10: EH complete
scsi 9:0:0:0: Direct-Access     ATA      ST3320620AS      3.AA PQ: 0 ANSI: 5
sd 9:0:0:0: Attached scsi generic sg9 type 0
sd 9:0:0:0: [sdi] 625142448 512-byte logical blocks: (320 GB/298 GiB)
sd 9:0:0:0: [sdi] Write Protect is off
sd 9:0:0:0: [sdi] Mode Sense: 00 3a 00 00
sd 9:0:0:0: [sdi] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sdi: unknown partition table
sd 9:0:0:0: [sdi] Attached SCSI disk
ata12: SATA link down (SStatus 0 SControl 310)
ata13: SATA link down (SStatus 0 SControl 310)
ata14: SATA link down (SStatus 0 SControl 310)
ISO 9660 Extensions: Microsoft Joliet Level 3
ISO 9660 Extensions: RRIP_1991A
SELinux: 8192 avtab hash slots, 144734 rules.
SELinux: 8192 avtab hash slots, 144734 rules.
SELinux:  8 users, 12 roles, 2941 types, 136 bools, 1 sens, 1024 cats
SELinux:  75 classes, 144734 rules
SELinux:  Completing initialization.
SELinux:  Setting up existing superblocks.
SELinux: initialized (dev loop0, type squashfs), not configured for labeling
SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs
SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs
SELinux: initialized (dev securityfs, type securityfs), uses genfs_contexts
SELinux: initialized (dev usbfs, type usbfs), uses genfs_contexts
SELinux: initialized (dev selinuxfs, type selinuxfs), uses genfs_contexts
SELinux: initialized (dev mqueue, type mqueue), uses transition SIDs
SELinux: initialized (dev hugetlbfs, type hugetlbfs), uses transition SIDs
SELinux: initialized (dev devpts, type devpts), uses transition SIDs
SELinux: initialized (dev inotifyfs, type inotifyfs), uses genfs_contexts
SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs
SELinux: initialized (dev anon_inodefs, type anon_inodefs), uses genfs_contexts
SELinux: initialized (dev pipefs, type pipefs), uses task SIDs
SELinux: initialized (dev debugfs, type debugfs), uses genfs_contexts
SELinux: initialized (dev sockfs, type sockfs), uses task SIDs
SELinux: initialized (dev proc, type proc), uses genfs_contexts
SELinux: initialized (dev bdev, type bdev), uses genfs_contexts
SELinux: initialized (dev rootfs, type rootfs), uses genfs_contexts
SELinux: initialized (dev sysfs, type sysfs), uses genfs_contexts
type=1403 audit(1269547102.191:2): policy loaded auid=4294967295 ses=4294967295
md: raid0 personality registered for level 0
md: raid1 personality registered for level 1
xor: automatically using best checksumming function: generic_sse
   generic_sse:  4476.000 MB/sec
xor: using function: generic_sse (4476.000 MB/sec)
async_tx: api initialized (async)
raid6: int64x1   1160 MB/s
raid6: int64x2   1414 MB/s
raid6: int64x4   1066 MB/s
raid6: int64x8    839 MB/s
raid6: sse2x1    1582 MB/s
raid6: sse2x2    2253 MB/s
raid6: sse2x4    2500 MB/s
raid6: using algorithm sse2x4 (2500 MB/s)
md: raid6 personality registered for level 6
md: raid5 personality registered for level 5
md: raid4 personality registered for level 4
md: raid10 personality registered for level 10
md: linear personality registered for level -1
device-mapper: multipath: version 1.1.0 loaded
device-mapper: multipath round-robin: version 1.0.0 loaded
e100 0000:03:08.0: firmware: requesting e100/d102e_ucode.bin
e100: eth1 NIC Link is Up 100 Mbps Full Duplex
tg3 0000:02:09.1: firmware: requesting tigon/tg3_tso.bin
tg3 0000:02:09.1: PME# disabled
tg3 0000:02:09.0: firmware: requesting tigon/tg3_tso.bin
tg3 0000:02:09.0: wake-up capability disabled by ACPI
tg3 0000:02:09.0: PME# disabled
tg3: eth0: Link is up at 1000 Mbps, full duplex.
tg3: eth0: Flow control is on for TX and on for RX.
end_request: I/O error, dev fd0, sector 0
end_request: I/O error, dev fd0, sector 0
Buffer I/O error on device fd0, logical block 0
end_request: I/O error, dev fd0, sector 0
Buffer I/O error on device fd0, logical block 0
EXT4-fs (sda1): barriers enabled
kjournald2 starting: pid 747, dev sda1:8, commit interval 5 seconds
EXT4-fs (sda1): delayed allocation enabled
EXT4-fs: file extents enabled
EXT4-fs: mballoc enabled
EXT4-fs (sda1): mounted filesystem with ordered data mode
SELinux: initialized (dev sda1, type ext4), uses xattr
EXT4-fs: mballoc: 0 blocks 0 reqs (0 success)
EXT4-fs: mballoc: 0 extents scanned, 0 goal hits, 0 2^N hits, 0 breaks, 0 lost
EXT4-fs: mballoc: 0 generated and it took 0
EXT4-fs: mballoc: 0 preallocated, 0 discarded
EXT4-fs (sda3): barriers enabled
kjournald2 starting: pid 756, dev sda3:8, commit interval 5 seconds
EXT4-fs (sda3): delayed allocation enabled
EXT4-fs: file extents enabled
EXT4-fs: mballoc enabled
EXT4-fs (sda3): mounted filesystem with ordered data mode
SELinux: initialized (dev sda3, type ext4), uses xattr
EXT4-fs: mballoc: 0 blocks 0 reqs (0 success)
EXT4-fs: mballoc: 0 extents scanned, 0 goal hits, 0 2^N hits, 0 breaks, 0 lost
EXT4-fs: mballoc: 0 generated and it took 0
EXT4-fs: mballoc: 0 preallocated, 0 discarded
EXT4-fs (sdb2): barriers enabled
kjournald2 starting: pid 765, dev sdb2:8, commit interval 5 seconds
EXT4-fs (sdb2): delayed allocation enabled
EXT4-fs: file extents enabled
EXT4-fs: mballoc enabled
EXT4-fs (sdb2): mounted filesystem with ordered data mode
SELinux: initialized (dev sdb2, type ext4), uses xattr
EXT4-fs: mballoc: 0 blocks 0 reqs (0 success)
EXT4-fs: mballoc: 0 extents scanned, 0 goal hits, 0 2^N hits, 0 breaks, 0 lost
EXT4-fs: mballoc: 0 generated and it took 0
EXT4-fs: mballoc: 0 preallocated, 0 discarded
EXT4-fs (sda3): barriers enabled
kjournald2 starting: pid 774, dev sda3:8, commit interval 5 seconds
EXT4-fs (sda3): internal journal on sda3:8
EXT4-fs (sda3): delayed allocation enabled
EXT4-fs: file extents enabled
EXT4-fs: mballoc enabled
EXT4-fs (sda3): mounted filesystem with ordered data mode
SELinux: initialized (dev sda3, type ext4), uses xattr
EXT4-fs (sda1): barriers enabled
kjournald2 starting: pid 776, dev sda1:8, commit interval 5 seconds
EXT4-fs (sda1): internal journal on sda1:8
EXT4-fs (sda1): delayed allocation enabled
EXT4-fs: file extents enabled
EXT4-fs: mballoc enabled
EXT4-fs (sda1): mounted filesystem with ordered data mode
SELinux: initialized (dev sda1, type ext4), uses xattr
SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs
Adding 2097144k swap on /dev/sda2.  Priority:-1 extents:1 across:2097144k 
Adding 1951856k swap on /dev/sdb1.  Priority:-2 extents:1 across:1951856k 
