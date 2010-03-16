From: Stan Hoeppner <stan@hardwarefreak.com>
Subject: Re: ata2.00: failed to set xfermode (err_mask=0x100),ata2.00: disabled,
 CD-ROM drive dead
Date: Mon, 15 Mar 2010 19:26:15 -0500
Message-ID: <4B9ED027.30800@hardwarefreak.com>
References: <4B9EA02F.2070704@hardwarefreak.com> <4B9EC67A.3020201@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mo-65-41-216-221.sta.embarqhsd.net ([65.41.216.221]:59154 "EHLO
	greer.hardwarefreak.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965862Ab0CPAZg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 15 Mar 2010 20:25:36 -0400
Received: from [192.168.100.53] (gffx.hardwarefreak.com [192.168.100.53])
	by greer.hardwarefreak.com (Postfix) with ESMTP id BD93E6C3DE
	for <linux-ide@vger.kernel.org>; Mon, 15 Mar 2010 19:25:35 -0500 (CDT)
In-Reply-To: <4B9EC67A.3020201@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Robert Hancock put forth on 3/15/2010 6:44 PM:
> On 03/15/2010 03:01 PM, Stan Hoeppner wrote:
>> dmesg:
>> ata2.00: failed to set xfermode (err_mask=0x100)
>> ata2.00: disabled
> 
> Can you post the full dmesg output from bootup?

Sure:

Linux version 2.6.32.9 (root@greer) (gcc version 4.3.2 (Debian 4.3.2-1.1) )
#1 SMP Wed Mar 10 19:02:00 CST 2010
KERNEL supported cpus:
  Intel GenuineIntel
  AMD AuthenticAMD
  NSC Geode by NSC
  Cyrix CyrixInstead
  Centaur CentaurHauls
  Transmeta GenuineTMx86
  Transmeta TransmetaCPU
  UMC UMC UMC UMC
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000018000000 (usable)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
DMI 2.2 present.
last_pfn = 0x18000 max_arch_pfn = 0x100000
initial memory mapped : 0 - 01800000
init_memory_mapping: 0000000000000000-0000000018000000
 0000000000 - 0000400000 page 4k
 0000400000 - 0018000000 page 2M
kernel direct mapping tables up to 18000000 @ 7000-b000
384MB LOWMEM available.
  mapped low ram: 0 - 18000000
  low ram: 0 - 18000000
  node 0 low ram: 00000000 - 18000000
  node 0 bootmap 00002000 - 00005000
(7 early reservations) ==> bootmem [0000000000 - 0018000000]
  #0 [0000000000 - 0000001000]   BIOS data page ==> [0000000000 - 0000001000]
  #1 [0000001000 - 0000002000]    EX TRAMPOLINE ==> [0000001000 - 0000002000]
  #2 [0000006000 - 0000007000]       TRAMPOLINE ==> [0000006000 - 0000007000]
  #3 [0001000000 - 00012c025c]    TEXT DATA BSS ==> [0001000000 - 00012c025c]
  #4 [000009f800 - 0000100000]    BIOS reserved ==> [000009f800 - 0000100000]
  #5 [00012c1000 - 00012c707a]              BRK ==> [00012c1000 - 00012c707a]
  #6 [0000002000 - 0000005000]          BOOTMAP ==> [0000002000 - 0000005000]
found SMP MP-table at [c00f5b90] f5b90
Zone PFN ranges:
  DMA      0x00000000 -> 0x00001000
  Normal   0x00001000 -> 0x00018000
Movable zone start PFN for each node
early_node_map[2] active PFN ranges
    0: 0x00000000 -> 0x000000a0
    0: 0x00000100 -> 0x00018000
On node 0 totalpages: 98208
free_area_init_node: node 0, pgdat c125e580, node_mem_map c12c8000
  DMA zone: 32 pages used for memmap
  DMA zone: 0 pages reserved
  DMA zone: 3968 pages, LIFO batch:0
  Normal zone: 736 pages used for memmap
  Normal zone: 93472 pages, LIFO batch:31
Using APIC driver default
Intel MultiProcessor Specification v1.1
    Virtual Wire compatibility mode.
MPTABLE: OEM ID: OEM00000
MPTABLE: Product ID: PROD00000000
MPTABLE: APIC at: 0xFEE00000
Processor #0 (Bootup-CPU)
Processor #1
I/O APIC #2 Version 17 at 0xFEC00000.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Processors: 2
SMP: Allowing 2 CPUs, 0 hotplug CPUs
nr_irqs_gsi: 24
Allocating PCI resources starting at 18000000 (gap: 18000000:e6c00000)
NR_CPUS:2 nr_cpumask_bits:2 nr_cpu_ids:2 nr_node_ids:1
PERCPU: Embedded 10 pages/cpu @c1800000 s20280 r0 d20680 u2097152
pcpu-alloc: s20280 r0 d20680 u2097152 alloc=1*4194304
pcpu-alloc: [0] 0 1
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 97440
Kernel command line: auto BOOT_IMAGE=Linux ro root=802
PID hash table entries: 2048 (order: 1, 8192 bytes)
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Enabling fast FPU save and restore... done.
Initializing CPU#0
Memory: 386032k/393216k available (1772k kernel code, 6424k reserved, 660k
data, 244k init, 0k highmem)
virtual kernel memory layout:
    fixmap  : 0xfff92000 - 0xfffff000   ( 436 kB)
    vmalloc : 0xd8800000 - 0xfff90000   ( 631 MB)
    lowmem  : 0xc0000000 - 0xd8000000   ( 384 MB)
      .init : 0xc1261000 - 0xc129e000   ( 244 kB)
      .data : 0xc11bb258 - 0xc1260418   ( 660 kB)
      .text : 0xc1000000 - 0xc11bb258   (1772 kB)
Checking if this processor honours the WP bit even in supervisor mode...Ok.
Hierarchical RCU implementation.
NR_IRQS:320
Console: colour VGA+ 80x25
console [tty0] enabled
Fast TSC calibration using PIT
Detected 511.876 MHz processor.
Calibrating delay loop (skipped), value calculated using timer frequency..
1023.75 BogoMIPS (lpj=2047504)
Mount-cache hash table entries: 512
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 128K
mce: CPU supports 5 MCE banks
Checking 'hlt' instruction... OK.
Freeing SMP alternatives: 9k freed
ExtINT not setup in hardware but reported by MP table
..TIMER: vector=0x30 apic1=0 pin1=2 apic2=0 pin2=0
CPU0: Intel Celeron (Mendocino) stepping 05
Booting processor 1 APIC 0x1 ip 0x6000
Initializing CPU#1
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 128K
CPU1: Intel Celeron (Mendocino) stepping 05
checking TSC synchronization [CPU#0 -> CPU#1]: passed.
Brought up 2 CPUs
Total of 2 processors activated (2047.60 BogoMIPS).
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfb440, last bus=1
PCI: Using configuration type 1 for base access
bio: create slab <bio-0> at 0
vgaarb: loaded
SCSI subsystem initialized
libata version 3.00 loaded.
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
pci 0000:00:00.0: reg 10 32bit mmio pref: [0xe4400000-0xe47fffff]
pci 0000:00:07.1: reg 20 io port: [0xf000-0xf00f]
pci 0000:00:07.2: reg 20 io port: [0x9000-0x901f]
pci 0000:00:07.3: quirk: region 4000-403f claimed by PIIX4 ACPI
pci 0000:00:07.3: quirk: region 5000-500f claimed by PIIX4 SMB
pci 0000:00:0d.0: reg 10 32bit mmio: [0xe4910000-0xe4910fff]
pci 0000:00:0d.0: reg 14 io port: [0x9400-0x943f]
pci 0000:00:0d.0: reg 18 32bit mmio: [0xe4800000-0xe48fffff]
pci 0000:00:0d.0: reg 30 32bit mmio pref: [0xe0000000-0xe00fffff]
pci 0000:00:0d.0: supports D1 D2
pci 0000:00:0d.0: PME# supported from D0 D1 D2 D3hot D3cold
pci 0000:00:0d.0: PME# disabled
pci 0000:00:0f.0: reg 10 32bit mmio: [0xe4000000-0xe43fffff]
pci 0000:00:0f.0: reg 14 32bit mmio: [0xe4900000-0xe490ffff]
pci 0000:00:0f.0: reg 30 32bit mmio pref: [0x000000-0x00ffff]
pci 0000:00:11.0: reg 10 io port: [0x9800-0x9807]
pci 0000:00:11.0: reg 14 io port: [0x9c00-0x9c03]
pci 0000:00:11.0: reg 18 io port: [0xa000-0xa007]
pci 0000:00:11.0: reg 1c io port: [0xa400-0xa403]
pci 0000:00:11.0: reg 20 io port: [0xa800-0xa80f]
pci 0000:00:11.0: reg 24 32bit mmio: [0xe4911000-0xe49111ff]
pci 0000:00:11.0: reg 30 32bit mmio pref: [0xe2000000-0xe207ffff]
pci 0000:00:11.0: supports D1 D2
pci 0000:00:13.0: reg 10 io port: [0xac00-0xac07]
pci 0000:00:13.0: reg 14 io port: [0xb000-0xb003]
pci 0000:00:13.0: reg 20 io port: [0xb400-0xb4ff]
pci 0000:00:13.0: reg 30 32bit mmio pref: [0xe3000000-0xe301ffff]
pci 0000:00:13.1: reg 10 io port: [0xb800-0xb807]
pci 0000:00:13.1: reg 14 io port: [0xbc00-0xbc03]
pci 0000:00:13.1: reg 20 io port: [0xc000-0xc0ff]
vgaarb: device added: PCI:0000:00:0f.0,decodes=io+mem,owns=io+mem,locks=none
pci 0000:00:07.0: PIIX/ICH IRQ router [8086:7110]
Switching to clocksource tsc
pci 0000:00:01.0: PCI bridge, secondary bus 0000:01
pci 0000:00:01.0:   IO window: disabled
pci 0000:00:01.0:   MEM window: disabled
pci 0000:00:01.0:   PREFETCH window: disabled
pci_bus 0000:00: resource 0 io:  [0x00-0xffff]
pci_bus 0000:00: resource 1 mem: [0x000000-0xffffffff]
NET: Registered protocol family 2
IP route cache hash table entries: 4096 (order: 2, 16384 bytes)
TCP established hash table entries: 16384 (order: 5, 131072 bytes)
TCP bind hash table entries: 16384 (order: 5, 131072 bytes)
TCP: Hash tables configured (established 16384 bind 16384)
TCP reno registered
NET: Registered protocol family 1
pci 0000:00:00.0: Limiting direct PCI/PCI transfers
pci 0000:00:0d.0: Firmware left e100 interrupts enabled; disabling
pci 0000:00:0f.0: Boot video device
platform rtc_cmos: registered platform RTC device (no PNP device found)
SGI XFS with security attributes, no debug enabled
msgmni has been set to 754
io scheduler noop registered
io scheduler deadline registered (default)
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
ata_piix 0000:00:07.1: version 2.13
scsi0 : ata_piix
scsi1 : ata_piix
ata1: PATA max UDMA/33 cmd 0x1f0 ctl 0x3f6 bmdma 0xf000 irq 14
ata2: PATA max UDMA/33 cmd 0x170 ctl 0x376 bmdma 0xf008 irq 15
ata1: port disabled. ignoring.
sata_sil 0000:00:11.0: version 2.4
sata_sil 0000:00:11.0: PCI->APIC IRQ transform: INT A -> IRQ 19
scsi2 : sata_sil
scsi3 : sata_sil
ata3: SATA max UDMA/100 mmio m512@0xe4911000 tf 0xe4911080 irq 19
ata4: SATA max UDMA/100 mmio m512@0xe4911000 tf 0xe49110c0 irq 19
e100: Intel(R) PRO/100 Network Driver, 3.5.24-k2-NAPI
e100: Copyright(c) 1999-2006 Intel Corporation
e100 0000:00:0d.0: PCI->APIC IRQ transform: INT A -> IRQ 17
e100 0000:00:0d.0: PME# disabled
e100: eth0: e100_probe: addr 0xe4910000, irq 17, MAC addr 00:90:27:65:01:69
PNP: No PS/2 controller found. Probing ports directly.
serio: i8042 KBD port at 0x60,0x64 irq 1
mice: PS/2 mouse device common for all mice
rtc_cmos rtc_cmos: rtc core: registered rtc_cmos as rtc0
rtc0: alarms up to one day, 114 bytes nvram
i2c /dev entries driver
piix4_smbus 0000:00:07.3: SMBus Host Controller at 0x5000, revision 0
w83781d: Found a W83782D chip at 0x290
input: AT Translated Set 2 keyboard as
/devices/platform/i8042/serio0/input/input0
ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata3.00: ATA-8: WDC WD5000AAKS-00V1A0, 05.01D05, max UDMA/133
ata3.00: 976773168 sectors, multi 16: LBA48 NCQ (depth 0/32)
ata3.00: configured for UDMA/100
ata2.00: ATAPI: Pioneer CD-ROM ATAPI Model DR-A24X  0102, E1.02, max MWDMA2
ata2.00: failed to set xfermode (err_mask=0x100)
TCP cubic registered
NET: Registered protocol family 17
Using IPI Shortcut mode
rtc_cmos rtc_cmos: setting system clock to 2010-03-10 20:53:54 UTC (1268254434)
ata2.00: failed to set xfermode (err_mask=0x100)
ata2.00: limiting speed to MWDMA2:PIO3
ata2.00: failed to set xfermode (err_mask=0x100)
ata2.00: disabled
scsi 2:0:0:0: Direct-Access     ATA      WDC WD5000AAKS-0 05.0 PQ: 0 ANSI: 5
sd 2:0:0:0: [sda] 976773168 512-byte logical blocks: (500 GB/465 GiB)
sd 2:0:0:0: [sda] Write Protect is off
sd 2:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 2:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support
DPO or FUA
 sda: sda1 sda2 sda3 < sda5 sda6 sda7 >
sd 2:0:0:0: [sda] Attached SCSI disk
ata4: SATA link down (SStatus 0 SControl 310)
VFS: Mounted root (ext2 filesystem) readonly on device 8:2.
Freeing unused kernel memory: 244k freed
Adding 995988k swap on /dev/sda5.  Priority:-1 extents:1 across:995988k
XFS mounting filesystem sda6
Ending clean XFS mount for filesystem: sda6
XFS mounting filesystem sda7
Ending clean XFS mount for filesystem: sda7
e100 0000:00:0d.0: firmware: using built-in firmware e100/d101m_ucode.bin
e100: eth0 NIC Link is Up 100 Mbps Full Duplex
warning: `ntpd' uses 32-bit capabilities (legacy support in use)
e100: eth0 NIC Link is Down
e100: eth0 NIC Link is Up 100 Mbps Full Duplex

-- 
Stan

