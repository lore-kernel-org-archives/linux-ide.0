From: Davidovac Zoran <davidovacz@gmail.com>
Subject: kernel 3.6+  problem with Marvell 88SE9172 SATA Controller
Date: Fri, 04 Oct 2013 07:03:37 +0200
Message-ID: <524E4C29.10506@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------010104050809060804050608"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ea0-f175.google.com ([209.85.215.175]:42736 "EHLO
	mail-ea0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750932Ab3JDFDp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 4 Oct 2013 01:03:45 -0400
Received: by mail-ea0-f175.google.com with SMTP id m14so1515901eaj.20
        for <linux-ide@vger.kernel.org>; Thu, 03 Oct 2013 22:03:43 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------010104050809060804050608
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Dear All,

After I've upgraded from kernel 3.4.X to 3.10.14 and I noticed 2 drives 
missing that
are connected on Marvell 88SE9172 SATA Controller.

The last version that worked properly was 3.5.7, but any kernel above 
3.6.0+ drives connected to Marvell are missing.

This was tested on Board GA-X79-UD5 
http://www.gigabyte.com/products/product-page.aspx?pid=4049#sp
that have 3 x Marvell 88SE9172 chips.

tested kernels:
linux-3.10.1.tar.xz   linux-3.12-rc3.tar.xz  linux-3.6.11.tar.xz 
linux-3.7.10.tar.xz
linux-3.10.14.tar.xz  linux-3.4.64.tar.xz    linux-3.6.5.tar.xz 
linux-3.8.13.tar.xz
linux-3.11.3.tar.xz   linux-3.5.7.tar.xz     linux-3.6.tar.xz 
linux-3.9.11.tar.xz

3.6.0+ dmesg:
ata7.00: failed to IDENTIFY (INIT_DEV_PARAMS failed, err_mask=0x80)
dmar: DRHD: handling fault status reg 502
dmar: DMAR:[DMA Write] Request device [05:00.1] fault addr fffc0000
DMAR:[fault reason 02] Present bit in context entry is clear
dmar: DRHD: handling fault status reg 602
dmar: DMAR:[DMA Write] Request device [05:00.1] fault addr fffe0000
DMAR:[fault reason 02] Present bit in context entry is clear
dmar: DRHD: handling fault status reg 702
dmar: DMAR:[DMA Write] Request device [05:00.1] fault addr fffc0000
DMAR:[fault reason 02] Present bit in context entry is clear
dmar: DRHD: handling fault status reg 2
dmar: DMAR:[DMA Write] Request device [05:00.1] fault addr fffe0000
DMAR:[fault reason 02] Present bit in context entry is clear
ata8: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
ata7: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
dmar: DRHD: handling fault status reg 102
dmar: DMAR:[DMA Write] Request device [05:00.1] fault addr fffc0000
DMAR:[fault reason 02] Present bit in context entry is clear
dmar: DMAR:[DMA Write] Request device [05:00.1] fault addr fffe0000
DMAR:[fault reason 02] Present bit in context entry is clear
dmar: DRHD: handling fault status reg 300
ata7.00: failed to IDENTIFY (INIT_DEV_PARAMS failed, err_mask=0x80)
ata7: limiting SATA link speed to 1.5 Gbps
ata8.00: failed to IDENTIFY (INIT_DEV_PARAMS failed, err_mask=0x80)
ata8: limiting SATA link speed to 3.0 Gbps
dmar: DRHD: handling fault status reg 302
dmar: DMAR:[DMA Write] Request device [05:00.1] fault addr fffc0000
DMAR:[fault reason 02] Present bit in context entry is clear
dmar: DRHD: handling fault status reg 402
dmar: DMAR:[DMA Write] Request device [05:00.1] fault addr fffe0000
DMAR:[fault reason 02] Present bit in context entry is clear
dmar: DRHD: handling fault status reg 502
dmar: DMAR:[DMA Write] Request device [05:00.1] fault addr fffc0000
DMAR:[fault reason 02] Present bit in context entry is clear
dmar: DRHD: handling fault status reg 602
dmar: DMAR:[DMA Write] Request device [05:00.1] fault addr fffe0000
DMAR:[fault reason 02] Present bit in context entry is clear
ata8: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
ata7: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
dmar: DRHD: handling fault status reg 702
dmar: DMAR:[DMA Write] Request device [05:00.1] fault addr fffc0000
DMAR:[fault reason 02] Present bit in context entry is clear
dmar: DMAR:[DMA Write] Request device [05:00.1] fault addr fffe0000
DMAR:[fault reason 02] Present bit in context entry is clear
dmar: DRHD: handling fault status reg 100
ata7.00: failed to IDENTIFY (INIT_DEV_PARAMS failed, err_mask=0x80)
ata8.00: failed to IDENTIFY (INIT_DEV_PARAMS failed, err_mask=0x80)
dmar: DRHD: handling fault status reg 102
dmar: DMAR:[DMA Write] Request device [05:00.1] fault addr fffc0000
DMAR:[fault reason 02] Present bit in context entry is clear
dmar: DRHD: handling fault status reg 202
dmar: DMAR:[DMA Write] Request device [05:00.1] fault addr fffe0000
DMAR:[fault reason 02] Present bit in context entry is clear
dmar: DRHD: handling fault status reg 302
dmar: DMAR:[DMA Write] Request device [05:00.1] fault addr fffc0000
DMAR:[fault reason 02] Present bit in context entry is clear
dmar: DRHD: handling fault status reg 402
dmar: DMAR:[DMA Write] Request device [05:00.1] fault addr fffe0000
DMAR:[fault reason 02] Present bit in context entry is clear
ata8: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
ata7: SATA link up 1.5 Gbps (SStatus 113 SControl 310)

let me know if you need anything else.

BR,

Z

--------------010104050809060804050608
Content-Type: text/plain; charset=ISO-8859-1;
 name="36.dmesg"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="36.dmesg"

Initializing cgroup subsys cpu
Linux version 3.6.0quad-loop-i7n (root@quad) (gcc version 4.7.1 (GCC) ) #1 SMP Fri Oct 4 03:55:41 CEST 2013
Command line: BOOT_IMAGE=Linux36 ro root=901 vt.default_utf8=0
e820: BIOS-provided physical RAM map:
BIOS-e820: [mem 0x0000000000000000-0x000000000009e7ff] usable
BIOS-e820: [mem 0x000000000009e800-0x000000000009ffff] reserved
BIOS-e820: [mem 0x00000000000e0000-0x00000000000fffff] reserved
BIOS-e820: [mem 0x0000000000100000-0x00000000cca50fff] usable
BIOS-e820: [mem 0x00000000cca51000-0x00000000ccb6afff] ACPI NVS
BIOS-e820: [mem 0x00000000ccb6b000-0x00000000cce91fff] reserved
BIOS-e820: [mem 0x00000000cce92000-0x00000000ccf09fff] ACPI data
BIOS-e820: [mem 0x00000000ccf0a000-0x00000000ccf2cfff] reserved
BIOS-e820: [mem 0x00000000ccf2d000-0x00000000ccf31fff] ACPI NVS
BIOS-e820: [mem 0x00000000ccf32000-0x00000000ccf50fff] reserved
BIOS-e820: [mem 0x00000000ccf51000-0x00000000ccf51fff] ACPI NVS
BIOS-e820: [mem 0x00000000ccf52000-0x00000000ccf54fff] reserved
BIOS-e820: [mem 0x00000000ccf55000-0x00000000ccf5cfff] ACPI NVS
BIOS-e820: [mem 0x00000000ccf5d000-0x00000000ccf87fff] reserved
BIOS-e820: [mem 0x00000000ccf88000-0x00000000cd18afff] ACPI NVS
BIOS-e820: [mem 0x00000000cd18b000-0x00000000cd47dfff] usable
BIOS-e820: [mem 0x00000000cd47e000-0x00000000cd7dafff] reserved
BIOS-e820: [mem 0x00000000cd7db000-0x00000000cd7fffff] usable
BIOS-e820: [mem 0x00000000e0000000-0x00000000efffffff] reserved
BIOS-e820: [mem 0x00000000fed1c000-0x00000000fed1ffff] reserved
BIOS-e820: [mem 0x00000000ff000000-0x00000000ffffffff] reserved
BIOS-e820: [mem 0x0000000100000000-0x000000082fffffff] usable
NX (Execute Disable) protection: active
DMI 2.7 present.
DMI: Gigabyte Technology Co., Ltd. To be filled by O.E.M./X79-UD5, BIOS F10 03/05/2012
e820: update [mem 0x00000000-0x0000ffff] usable ==> reserved
e820: remove [mem 0x000a0000-0x000fffff] usable
No AGP bridge found
e820: last_pfn = 0x830000 max_arch_pfn = 0x400000000
MTRR default type: uncachable
MTRR fixed ranges enabled:
  00000-9FFFF write-back
  A0000-BFFFF uncachable
  C0000-CFFFF write-protect
  D0000-E7FFF uncachable
  E8000-FFFFF write-protect
MTRR variable ranges enabled:
  0 base 000000000000 mask 3FF800000000 write-back
  1 base 000800000000 mask 3FFFE0000000 write-back
  2 base 000820000000 mask 3FFFF0000000 write-back
  3 base 0000CE000000 mask 3FFFFE000000 uncachable
  4 base 0000D0000000 mask 3FFFF0000000 uncachable
  5 base 0000E0000000 mask 3FFFE0000000 uncachable
  6 disabled
  7 disabled
  8 disabled
  9 disabled
x86 PAT enabled: cpu 0, old 0x7040600070406, new 0x7010600070106
original variable MTRRs
reg 0, base: 0GB, range: 32GB, type WB
reg 1, base: 32GB, range: 512MB, type WB
reg 2, base: 33280MB, range: 256MB, type WB
reg 3, base: 3296MB, range: 32MB, type UC
reg 4, base: 3328MB, range: 256MB, type UC
reg 5, base: 3584MB, range: 512MB, type UC
total RAM covered: 32736M
Found optimal setting for mtrr clean up
 gran_size: 64K 	chunk_size: 64M 	num_reg: 9  	lose cover RAM: 0G
New variable MTRRs
reg 0, base: 0GB, range: 2GB, type WB
reg 1, base: 2GB, range: 1GB, type WB
reg 2, base: 3GB, range: 256MB, type WB
reg 3, base: 3296MB, range: 32MB, type UC
reg 4, base: 4GB, range: 4GB, type WB
reg 5, base: 8GB, range: 8GB, type WB
reg 6, base: 16GB, range: 16GB, type WB
reg 7, base: 32GB, range: 512MB, type WB
reg 8, base: 33280MB, range: 256MB, type WB
e820: update [mem 0xce000000-0xffffffff] usable ==> reserved
e820: last_pfn = 0xcd800 max_arch_pfn = 0x400000000
found SMP MP-table at [mem 0x000fcd10-0x000fcd1f] mapped at [ffff8800000fcd10]
initial memory mapped: [mem 0x00000000-0x1fffffff]
Base memory trampoline at [ffff880000098000] 98000 size 24576
Using GB pages for direct mapping
init_memory_mapping: [mem 0x00000000-0xcd7fffff]
 [mem 0x00000000-0xbfffffff] page 1G
 [mem 0xc0000000-0xcd7fffff] page 2M
kernel direct mapping tables up to 0xcd7fffff @ [mem 0x1f9fe000-0x1fffffff]
init_memory_mapping: [mem 0x100000000-0x82fffffff]
 [mem 0x100000000-0x7ffffffff] page 1G
 [mem 0x800000000-0x82fffffff] page 2M
kernel direct mapping tables up to 0x82fffffff @ [mem 0xcd7fe000-0xcd7fffff]
ACPI: RSDP 00000000000f0450 00024 (v02 ALASKA)
ACPI: XSDT 00000000cce92070 00064 (v01 ALASKA    A M I 01072009 AMI  00010013)
ACPI: FACP 00000000cce9a0c8 000F4 (v04 ALASKA    A M I 01072009 AMI  00010013)
ACPI: DSDT 00000000cce92168 07F5F (v02 ALASKA    A M I 00000000 INTL 20051117)
ACPI: FACS 00000000ccf5af80 00040
ACPI: APIC 00000000cce9a1c0 000B2 (v03 ALASKA    A M I 01072009 AMI  00010013)
ACPI: MCFG 00000000cce9a278 0003C (v01 ALASKA OEMMCFG. 01072009 MSFT 00000097)
ACPI: HPET 00000000cce9a2b8 00038 (v01 ALASKA    A M I 01072009 AMI. 00000004)
ACPI: SSDT 00000000cce9a2f0 6F0C4 (v02  INTEL    CpuPm 00004000 INTL 20051117)
ACPI: MATS 00000000ccf093b8 00034 (v01 ALASKA    A M I 00000001 w?x2 00000000)
ACPI: DMAR 00000000ccf093f0 000C4 (v01 A M I   OEMDMAR 00000001 INTL 00000001)
ACPI: MATS 00000000ccf094b8 00034 (v02 ALASKA    A M I 00000002 w?x2 00000000)
ACPI: Local APIC address 0xfee00000
 [ffffea0000000000-ffffea0020bfffff] PMD -> [ffff88080f600000-ffff88082f5fffff] on node 0
Zone ranges:
  DMA      [mem 0x00010000-0x00ffffff]
  DMA32    [mem 0x01000000-0xffffffff]
  Normal   [mem 0x100000000-0x82fffffff]
Movable zone start for each node
Early memory node ranges
  node   0: [mem 0x00010000-0x0009dfff]
  node   0: [mem 0x00100000-0xcca50fff]
  node   0: [mem 0xcd18b000-0xcd47dfff]
  node   0: [mem 0xcd7db000-0xcd7fffff]
  node   0: [mem 0x100000000-0x82fffffff]
On node 0 totalpages: 8375543
  DMA zone: 64 pages used for memmap
  DMA zone: 6 pages reserved
  DMA zone: 3912 pages, LIFO batch:0
  DMA32 zone: 16320 pages used for memmap
  DMA32 zone: 818601 pages, LIFO batch:31
  Normal zone: 117760 pages used for memmap
  Normal zone: 7418880 pages, LIFO batch:31
ACPI: PM-Timer IO Port: 0x408
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x02] enabled)
ACPI: LAPIC (acpi_id[0x04] lapic_id[0x04] enabled)
ACPI: LAPIC (acpi_id[0x06] lapic_id[0x06] enabled)
ACPI: LAPIC (acpi_id[0x08] lapic_id[0x08] enabled)
ACPI: LAPIC (acpi_id[0x0a] lapic_id[0x0a] enabled)
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
ACPI: LAPIC (acpi_id[0x03] lapic_id[0x03] enabled)
ACPI: LAPIC (acpi_id[0x05] lapic_id[0x05] enabled)
ACPI: LAPIC (acpi_id[0x07] lapic_id[0x07] enabled)
ACPI: LAPIC (acpi_id[0x09] lapic_id[0x09] enabled)
ACPI: LAPIC (acpi_id[0x0b] lapic_id[0x0b] enabled)
ACPI: LAPIC_NMI (acpi_id[0xff] high edge lint[0x1])
ACPI: IOAPIC (id[0x00] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 0, version 32, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Using ACPI (MADT) for SMP configuration information
ACPI: HPET id: 0x8086a701 base: 0xfed00000
smpboot: Allowing 12 CPUs, 0 hotplug CPUs
nr_irqs_gsi: 40
e820: [mem 0xcd800000-0xdfffffff] available for PCI devices
setup_percpu: NR_CPUS:16 nr_cpumask_bits:16 nr_cpu_ids:12 nr_node_ids:1
PERCPU: Embedded 25 pages/cpu @ffff88082fc00000 s73024 r8192 d21184 u131072
pcpu-alloc: s73024 r8192 d21184 u131072 alloc=1*2097152
pcpu-alloc: [0] 00 01 02 03 04 05 06 07 08 09 10 11 -- -- -- -- 
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 8241393
Kernel command line: BOOT_IMAGE=Linux36 ro root=901 vt.default_utf8=0
PID hash table entries: 4096 (order: 3, 32768 bytes)
Dentry cache hash table entries: 4194304 (order: 13, 33554432 bytes)
Inode-cache hash table entries: 2097152 (order: 12, 16777216 bytes)
__ex_table already sorted, skipping sort
xsave: enabled xstate_bv 0x7, cntxt size 0x340
Checking aperture...
No AGP bridge found
Memory: 32851088k/34340864k available (6338k kernel code, 838692k absent, 651084k reserved, 2704k data, 504k init)
SLUB: Genslabs=15, HWalign=64, Order=0-3, MinObjects=0, CPUs=12, Nodes=1
Hierarchical RCU implementation.
	RCU dyntick-idle grace-period acceleration is enabled.
	RCU restricting CPUs from NR_CPUS=16 to nr_cpu_ids=12.
NR_IRQS:4352 nr_irqs:776 16
Extended CMOS year: 2000
Console: colour VGA+ 80x25
console [tty0] enabled
hpet clockevent registered
tsc: Fast TSC calibration using PIT
tsc: Detected 3199.971 MHz processor
Calibrating delay loop (skipped), value calculated using timer frequency.. 6402.60 BogoMIPS (lpj=10666570)
pid_max: default: 32768 minimum: 301
Mount-cache hash table entries: 256
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 0
mce: CPU supports 18 MCE banks
CPU0: Thermal monitoring enabled (TM1)
process: using mwait in idle threads
Last level iTLB entries: 4KB 512, 2MB 0, 4MB 0
Last level dTLB entries: 4KB 512, 2MB 32, 4MB 32
tlb_flushall_shift is 0x5
ACPI: Core revision 20120711
Switched APIC routing to physical flat.
..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
smpboot: CPU0: Intel(R) Core(TM) i7-3930K CPU @ 3.20GHz stepping 07
Performance Events: PEBS fmt1+, 16-deep LBR, SandyBridge events, Intel PMU driver.
perf_event_intel: PEBS disabled due to CPU errata, please upgrade microcode
... version:                3
... bit width:              48
... generic registers:      4
... value mask:             0000ffffffffffff
... max period:             000000007fffffff
... fixed-purpose events:   3
... event mask:             000000070000000f
smpboot: Booting Node   0, Processors  #1 #2 #3 #4 #5 #6 #7 #8 #9 #10 #11 OK
Brought up 12 CPUs
smpboot: Total of 12 processors activated (76830.27 BogoMIPS)
devtmpfs: initialized
PM: Registering ACPI NVS region [mem 0xcca51000-0xccb6afff] (1155072 bytes)
PM: Registering ACPI NVS region [mem 0xccf2d000-0xccf31fff] (20480 bytes)
PM: Registering ACPI NVS region [mem 0xccf51000-0xccf51fff] (4096 bytes)
PM: Registering ACPI NVS region [mem 0xccf55000-0xccf5cfff] (32768 bytes)
PM: Registering ACPI NVS region [mem 0xccf88000-0xcd18afff] (2109440 bytes)
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xe0000000-0xefffffff] (base 0xe0000000)
PCI: MMCONFIG at [mem 0xe0000000-0xefffffff] reserved in E820
PCI: Using configuration type 1 for base access
bio: create slab <bio-0> at 0
ACPI: Added _OSI(Module Device)
ACPI: Added _OSI(Processor Device)
ACPI: Added _OSI(3.0 _SCP Extensions)
ACPI: Added _OSI(Processor Aggregator Device)
ACPI: EC: Look up EC in DSDT
ACPI: Executed 1 blocks of module-level executable AML code
ACPI: Interpreter enabled
ACPI: (supports S0 S1 S3 S5)
ACPI: Using IOAPIC for interrupt routing
PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-fe])
PCI host bridge to bus 0000:00
pci_bus 0000:00: busn_res: [bus 00-fe] is inserted under domain [bus 00-ff]
pci_bus 0000:00: root bus resource [bus 00-fe]
pci_bus 0000:00: root bus resource [io  0x0000-0x03af]
pci_bus 0000:00: root bus resource [io  0x03e0-0x0cf7]
pci_bus 0000:00: root bus resource [io  0x03b0-0x03df]
pci_bus 0000:00: root bus resource [io  0x0d00-0xffff]
pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff]
pci_bus 0000:00: root bus resource [mem 0x000c0000-0x000dffff]
pci_bus 0000:00: root bus resource [mem 0xd0000000-0xfbffffff]
pci 0000:00:00.0: [8086:3c00] type 00 class 0x060000
pci 0000:00:00.0: PME# supported from D0 D3hot D3cold
pci 0000:00:01.0: [8086:3c02] type 01 class 0x060400
pci 0000:00:01.0: PME# supported from D0 D3hot D3cold
pci 0000:00:02.0: [8086:3c04] type 01 class 0x060400
pci 0000:00:02.0: PME# supported from D0 D3hot D3cold
pci 0000:00:03.0: [8086:3c08] type 01 class 0x060400
pci 0000:00:03.0: PME# supported from D0 D3hot D3cold
pci 0000:00:04.0: [8086:3c20] type 00 class 0x088000
pci 0000:00:04.0: reg 10: [mem 0xfb740000-0xfb743fff 64bit]
pci 0000:00:04.1: [8086:3c21] type 00 class 0x088000
pci 0000:00:04.1: reg 10: [mem 0xfb73c000-0xfb73ffff 64bit]
pci 0000:00:04.2: [8086:3c22] type 00 class 0x088000
pci 0000:00:04.2: reg 10: [mem 0xfb738000-0xfb73bfff 64bit]
pci 0000:00:04.3: [8086:3c23] type 00 class 0x088000
pci 0000:00:04.3: reg 10: [mem 0xfb734000-0xfb737fff 64bit]
pci 0000:00:04.4: [8086:3c24] type 00 class 0x088000
pci 0000:00:04.4: reg 10: [mem 0xfb730000-0xfb733fff 64bit]
pci 0000:00:04.5: [8086:3c25] type 00 class 0x088000
pci 0000:00:04.5: reg 10: [mem 0xfb72c000-0xfb72ffff 64bit]
pci 0000:00:04.6: [8086:3c26] type 00 class 0x088000
pci 0000:00:04.6: reg 10: [mem 0xfb728000-0xfb72bfff 64bit]
pci 0000:00:04.7: [8086:3c27] type 00 class 0x088000
pci 0000:00:04.7: reg 10: [mem 0xfb724000-0xfb727fff 64bit]
pci 0000:00:05.0: [8086:3c28] type 00 class 0x088000
pci 0000:00:05.2: [8086:3c2a] type 00 class 0x088000
pci 0000:00:05.4: [8086:3c2c] type 00 class 0x080020
pci 0000:00:05.4: reg 10: [mem 0xfb74a000-0xfb74afff]
pci 0000:00:11.0: [8086:1d3e] type 01 class 0x060400
pci 0000:00:11.0: PME# supported from D0 D3hot D3cold
pci 0000:00:16.0: [8086:1d3a] type 00 class 0x078000
pci 0000:00:16.0: reg 10: [mem 0xfb749000-0xfb74900f 64bit]
pci 0000:00:16.0: PME# supported from D0 D3hot D3cold
pci 0000:00:19.0: [8086:1503] type 00 class 0x020000
pci 0000:00:19.0: reg 10: [mem 0xfb700000-0xfb71ffff]
pci 0000:00:19.0: reg 14: [mem 0xfb748000-0xfb748fff]
pci 0000:00:19.0: reg 18: [io  0xf040-0xf05f]
pci 0000:00:19.0: PME# supported from D0 D3hot D3cold
pci 0000:00:1a.0: [8086:1d2d] type 00 class 0x0c0320
pci 0000:00:1a.0: reg 10: [mem 0xfb747000-0xfb7473ff]
pci 0000:00:1a.0: PME# supported from D0 D3hot D3cold
pci 0000:00:1b.0: [8086:1d20] type 00 class 0x040300
pci 0000:00:1b.0: reg 10: [mem 0xfb720000-0xfb723fff 64bit]
pci 0000:00:1b.0: PME# supported from D0 D3hot D3cold
pci 0000:00:1c.0: [8086:1d10] type 01 class 0x060400
pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
pci 0000:00:1c.1: [8086:1d12] type 01 class 0x060400
pci 0000:00:1c.1: PME# supported from D0 D3hot D3cold
pci 0000:00:1c.2: [8086:1d14] type 01 class 0x060400
pci 0000:00:1c.2: PME# supported from D0 D3hot D3cold
pci 0000:00:1c.3: [8086:1d16] type 01 class 0x060400
pci 0000:00:1c.3: PME# supported from D0 D3hot D3cold
pci 0000:00:1c.5: [8086:1d1a] type 01 class 0x060400
pci 0000:00:1c.5: PME# supported from D0 D3hot D3cold
pci 0000:00:1c.6: [8086:1d1c] type 01 class 0x060400
pci 0000:00:1c.6: PME# supported from D0 D3hot D3cold
pci 0000:00:1c.7: [8086:1d1e] type 01 class 0x060400
pci 0000:00:1c.7: PME# supported from D0 D3hot D3cold
pci 0000:00:1d.0: [8086:1d26] type 00 class 0x0c0320
pci 0000:00:1d.0: reg 10: [mem 0xfb746000-0xfb7463ff]
pci 0000:00:1d.0: PME# supported from D0 D3hot D3cold
pci 0000:00:1e.0: [8086:244e] type 01 class 0x060401
pci 0000:00:1f.0: [8086:1d41] type 00 class 0x060100
pci 0000:00:1f.2: [8086:1d02] type 00 class 0x010601
pci 0000:00:1f.2: reg 10: [io  0xf090-0xf097]
pci 0000:00:1f.2: reg 14: [io  0xf080-0xf083]
pci 0000:00:1f.2: reg 18: [io  0xf070-0xf077]
pci 0000:00:1f.2: reg 1c: [io  0xf060-0xf063]
pci 0000:00:1f.2: reg 20: [io  0xf020-0xf03f]
pci 0000:00:1f.2: reg 24: [mem 0xfb745000-0xfb7457ff]
pci 0000:00:1f.2: PME# supported from D3hot
pci 0000:00:1f.3: [8086:1d22] type 00 class 0x0c0500
pci 0000:00:1f.3: reg 10: [mem 0xfb744000-0xfb7440ff 64bit]
pci 0000:00:1f.3: reg 20: [io  0xf000-0xf01f]
pci_bus 0000:01: busn_res: [bus 01] is inserted under [bus 00-fe]
pci 0000:01:00.0: [10de:0640] type 00 class 0x030000
pci 0000:01:00.0: reg 10: [mem 0xfa000000-0xfaffffff]
pci 0000:01:00.0: reg 14: [mem 0xd0000000-0xdfffffff 64bit pref]
pci 0000:01:00.0: reg 1c: [mem 0xf8000000-0xf9ffffff 64bit]
pci 0000:01:00.0: reg 24: [io  0xe000-0xe07f]
pci 0000:01:00.0: reg 30: [mem 0xfb000000-0xfb07ffff pref]
pci 0000:00:01.0: PCI bridge to [bus 01]
pci 0000:00:01.0:   bridge window [io  0xe000-0xefff]
pci 0000:00:01.0:   bridge window [mem 0xf8000000-0xfb0fffff]
pci 0000:00:01.0:   bridge window [mem 0xd0000000-0xdfffffff 64bit pref]
pci_bus 0000:02: busn_res: [bus 02] is inserted under [bus 00-fe]
pci 0000:00:02.0: PCI bridge to [bus 02]
pci_bus 0000:03: busn_res: [bus 03] is inserted under [bus 00-fe]
pci 0000:00:03.0: PCI bridge to [bus 03]
pci_bus 0000:04: busn_res: [bus 04] is inserted under [bus 00-fe]
pci 0000:00:11.0: PCI bridge to [bus 04]
pci_bus 0000:05: busn_res: [bus 05] is inserted under [bus 00-fe]
pci 0000:05:00.0: [1b4b:9172] type 00 class 0x010601
pci 0000:05:00.0: reg 10: [io  0xd040-0xd047]
pci 0000:05:00.0: reg 14: [io  0xd030-0xd033]
pci 0000:05:00.0: reg 18: [io  0xd020-0xd027]
pci 0000:05:00.0: reg 1c: [io  0xd010-0xd013]
pci 0000:05:00.0: reg 20: [io  0xd000-0xd00f]
pci 0000:05:00.0: reg 24: [mem 0xfb610000-0xfb6101ff]
pci 0000:05:00.0: reg 30: [mem 0xfb600000-0xfb60ffff pref]
pci 0000:05:00.0: PME# supported from D3hot
pci 0000:00:1c.0: PCI bridge to [bus 05]
pci 0000:00:1c.0:   bridge window [io  0xd000-0xdfff]
pci 0000:00:1c.0:   bridge window [mem 0xfb600000-0xfb6fffff]
pci_bus 0000:06: busn_res: [bus 06] is inserted under [bus 00-fe]
pci 0000:06:00.0: [1b4b:9172] type 00 class 0x010601
pci 0000:06:00.0: reg 10: [io  0xc040-0xc047]
pci 0000:06:00.0: reg 14: [io  0xc030-0xc033]
pci 0000:06:00.0: reg 18: [io  0xc020-0xc027]
pci 0000:06:00.0: reg 1c: [io  0xc010-0xc013]
pci 0000:06:00.0: reg 20: [io  0xc000-0xc00f]
pci 0000:06:00.0: reg 24: [mem 0xfb510000-0xfb5101ff]
pci 0000:06:00.0: reg 30: [mem 0xfb500000-0xfb50ffff pref]
pci 0000:06:00.0: PME# supported from D3hot
pci 0000:00:1c.1: PCI bridge to [bus 06]
pci 0000:00:1c.1:   bridge window [io  0xc000-0xcfff]
pci 0000:00:1c.1:   bridge window [mem 0xfb500000-0xfb5fffff]
pci_bus 0000:07: busn_res: [bus 07] is inserted under [bus 00-fe]
pci 0000:00:1c.2: PCI bridge to [bus 07]
pci_bus 0000:08: busn_res: [bus 08] is inserted under [bus 00-fe]
pci 0000:00:1c.3: PCI bridge to [bus 08]
pci_bus 0000:09: busn_res: [bus 09] is inserted under [bus 00-fe]
pci 0000:09:00.0: [1b73:1009] type 00 class 0x0c0330
pci 0000:09:00.0: reg 10: [mem 0xfb400000-0xfb40ffff 64bit]
pci 0000:09:00.0: reg 18: [mem 0xfb411000-0xfb411fff 64bit]
pci 0000:09:00.0: reg 20: [mem 0xfb410000-0xfb410fff 64bit]
pci 0000:09:00.0: supports D1
pci 0000:09:00.0: PME# supported from D0 D1 D3hot D3cold
pci 0000:00:1c.5: PCI bridge to [bus 09]
pci 0000:00:1c.5:   bridge window [mem 0xfb400000-0xfb4fffff]
pci_bus 0000:0a: busn_res: [bus 0a] is inserted under [bus 00-fe]
pci 0000:0a:00.0: [1b73:1009] type 00 class 0x0c0330
pci 0000:0a:00.0: reg 10: [mem 0xfb300000-0xfb30ffff 64bit]
pci 0000:0a:00.0: reg 18: [mem 0xfb311000-0xfb311fff 64bit]
pci 0000:0a:00.0: reg 20: [mem 0xfb310000-0xfb310fff 64bit]
pci 0000:0a:00.0: supports D1
pci 0000:0a:00.0: PME# supported from D0 D1 D3hot D3cold
pci 0000:00:1c.6: PCI bridge to [bus 0a]
pci 0000:00:1c.6:   bridge window [mem 0xfb300000-0xfb3fffff]
pci_bus 0000:0b: busn_res: [bus 0b] is inserted under [bus 00-fe]
pci 0000:0b:00.0: [1b4b:9172] type 00 class 0x010601
pci 0000:0b:00.0: reg 10: [io  0xb040-0xb047]
pci 0000:0b:00.0: reg 14: [io  0xb030-0xb033]
pci 0000:0b:00.0: reg 18: [io  0xb020-0xb027]
pci 0000:0b:00.0: reg 1c: [io  0xb010-0xb013]
pci 0000:0b:00.0: reg 20: [io  0xb000-0xb00f]
pci 0000:0b:00.0: reg 24: [mem 0xfb210000-0xfb2101ff]
pci 0000:0b:00.0: reg 30: [mem 0xfb200000-0xfb20ffff pref]
pci 0000:0b:00.0: PME# supported from D3hot
pci 0000:00:1c.7: PCI bridge to [bus 0b]
pci 0000:00:1c.7:   bridge window [io  0xb000-0xbfff]
pci 0000:00:1c.7:   bridge window [mem 0xfb200000-0xfb2fffff]
pci_bus 0000:0c: busn_res: [bus 0c] is inserted under [bus 00-fe]
pci 0000:0c:03.0: [1106:3044] type 00 class 0x0c0010
pci 0000:0c:03.0: reg 10: [mem 0xfb100000-0xfb1007ff]
pci 0000:0c:03.0: reg 14: [io  0xa000-0xa07f]
pci 0000:0c:03.0: supports D2
pci 0000:0c:03.0: PME# supported from D2 D3hot D3cold
pci 0000:00:1e.0: PCI bridge to [bus 0c] (subtractive decode)
pci 0000:00:1e.0:   bridge window [io  0xa000-0xafff]
pci 0000:00:1e.0:   bridge window [mem 0xfb100000-0xfb1fffff]
pci 0000:00:1e.0:   bridge window [io  0x0000-0x03af] (subtractive decode)
pci 0000:00:1e.0:   bridge window [io  0x03e0-0x0cf7] (subtractive decode)
pci 0000:00:1e.0:   bridge window [io  0x03b0-0x03df] (subtractive decode)
pci 0000:00:1e.0:   bridge window [io  0x0d00-0xffff] (subtractive decode)
pci 0000:00:1e.0:   bridge window [mem 0x000a0000-0x000bffff] (subtractive decode)
pci 0000:00:1e.0:   bridge window [mem 0x000c0000-0x000dffff] (subtractive decode)
pci 0000:00:1e.0:   bridge window [mem 0xd0000000-0xfbffffff] (subtractive decode)
pci_bus 0000:00: on NUMA node 0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.BR20._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEX0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEX1._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEX2._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEX3._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEX5._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEX6._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEX7._PRT]
 pci0000:00: Requesting ACPI _OSC control (0x1d)
 pci0000:00: ACPI _OSC control (0x15) granted
ACPI: PCI Root Bridge [UNC0] (domain 0000 [bus ff])
PCI host bridge to bus 0000:ff
pci_bus 0000:ff: busn_res: [bus ff] is inserted under domain [bus 00-ff]
pci_bus 0000:ff: root bus resource [bus ff]
pci 0000:ff:08.0: [8086:3c80] type 00 class 0x088000
pci 0000:ff:08.3: [8086:3c83] type 00 class 0x088000
pci 0000:ff:08.4: [8086:3c84] type 00 class 0x088000
pci 0000:ff:09.0: [8086:3c90] type 00 class 0x088000
pci 0000:ff:09.3: [8086:3c93] type 00 class 0x088000
pci 0000:ff:09.4: [8086:3c94] type 00 class 0x088000
pci 0000:ff:0a.0: [8086:3cc0] type 00 class 0x088000
pci 0000:ff:0a.1: [8086:3cc1] type 00 class 0x088000
pci 0000:ff:0a.2: [8086:3cc2] type 00 class 0x088000
pci 0000:ff:0a.3: [8086:3cd0] type 00 class 0x088000
pci 0000:ff:0b.0: [8086:3ce0] type 00 class 0x088000
pci 0000:ff:0b.3: [8086:3ce3] type 00 class 0x088000
pci 0000:ff:0c.0: [8086:3ce8] type 00 class 0x088000
pci 0000:ff:0c.1: [8086:3ce8] type 00 class 0x088000
pci 0000:ff:0c.2: [8086:3ce8] type 00 class 0x088000
pci 0000:ff:0c.6: [8086:3cf4] type 00 class 0x088000
pci 0000:ff:0c.7: [8086:3cf6] type 00 class 0x088000
pci 0000:ff:0d.0: [8086:3ce8] type 00 class 0x088000
pci 0000:ff:0d.1: [8086:3ce8] type 00 class 0x088000
pci 0000:ff:0d.2: [8086:3ce8] type 00 class 0x088000
pci 0000:ff:0d.6: [8086:3cf5] type 00 class 0x088000
pci 0000:ff:0e.0: [8086:3ca0] type 00 class 0x088000
pci 0000:ff:0e.1: [8086:3c46] type 00 class 0x110100
pci 0000:ff:0f.0: [8086:3ca8] type 00 class 0x088000
pci 0000:ff:0f.1: [8086:3c71] type 00 class 0x088000
pci 0000:ff:0f.2: [8086:3caa] type 00 class 0x088000
pci 0000:ff:0f.3: [8086:3cab] type 00 class 0x088000
pci 0000:ff:0f.4: [8086:3cac] type 00 class 0x088000
pci 0000:ff:0f.5: [8086:3cad] type 00 class 0x088000
pci 0000:ff:0f.6: [8086:3cae] type 00 class 0x088000
pci 0000:ff:10.0: [8086:3cb0] type 00 class 0x088000
pci 0000:ff:10.1: [8086:3cb1] type 00 class 0x088000
pci 0000:ff:10.2: [8086:3cb2] type 00 class 0x088000
pci 0000:ff:10.3: [8086:3cb3] type 00 class 0x088000
pci 0000:ff:10.4: [8086:3cb4] type 00 class 0x088000
pci 0000:ff:10.5: [8086:3cb5] type 00 class 0x088000
pci 0000:ff:10.6: [8086:3cb6] type 00 class 0x088000
pci 0000:ff:10.7: [8086:3cb7] type 00 class 0x088000
pci 0000:ff:11.0: [8086:3cb8] type 00 class 0x088000
pci 0000:ff:13.0: [8086:3ce4] type 00 class 0x088000
pci 0000:ff:13.1: [8086:3c43] type 00 class 0x110100
pci 0000:ff:13.4: [8086:3ce6] type 00 class 0x110100
pci 0000:ff:13.5: [8086:3c44] type 00 class 0x110100
pci 0000:ff:13.6: [8086:3c45] type 00 class 0x088000
pci_bus 0000:ff: on NUMA node 0
 pci0000:ff: ACPI _OSC support notification failed, disabling PCIe ASPM
 pci0000:ff: Unable to request _OSC control (_OSC support mask: 0x08)
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs *3 4 5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 *4 5 6 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 10 11 12 14 15) *0
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 *7 10 11 12 14 15)
vgaarb: device added: PCI:0000:01:00.0,decodes=io+mem,owns=io+mem,locks=none
vgaarb: loaded
vgaarb: bridge control possible 0000:01:00.0
SCSI subsystem initialized
ACPI: bus type scsi registered
libata version 3.00 loaded.
ACPI: bus type usb registered
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
Advanced Linux Sound Architecture Driver Version 1.0.25.
PCI: Using ACPI for IRQ routing
PCI: pci_cache_line_size set to 64 bytes
e820: reserve RAM buffer [mem 0x0009e800-0x0009ffff]
e820: reserve RAM buffer [mem 0xcca51000-0xcfffffff]
e820: reserve RAM buffer [mem 0xcd47e000-0xcfffffff]
e820: reserve RAM buffer [mem 0xcd800000-0xcfffffff]
hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0, 0, 0, 0, 0
hpet0: 8 comparators, 64-bit 14.318180 MHz counter
Switching to clocksource hpet
pnp: PnP ACPI init
ACPI: bus type pnp registered
pnp 00:00: [bus 00-fe]
pnp 00:00: [io  0x0cf8-0x0cff]
pnp 00:00: [io  0x0000-0x03af window]
pnp 00:00: [io  0x03e0-0x0cf7 window]
pnp 00:00: [io  0x03b0-0x03df window]
pnp 00:00: [io  0x0d00-0xffff window]
pnp 00:00: [mem 0x000a0000-0x000bffff window]
pnp 00:00: [mem 0x000c0000-0x000dffff window]
pnp 00:00: [mem 0xd0000000-0xfbffffff window]
pnp 00:00: [mem 0x00000000 window]
pnp 00:00: Plug and Play ACPI device, IDs PNP0a08 PNP0a03 (active)
pnp 00:01: [mem 0xfc000000-0xfcffffff]
pnp 00:01: [mem 0xfd000000-0xfdffffff]
pnp 00:01: [mem 0xfe000000-0xfeafffff]
pnp 00:01: [mem 0xfeb00000-0xfebfffff]
pnp 00:01: [mem 0xfed00400-0xfed3ffff]
pnp 00:01: [mem 0xfed45000-0xfedfffff]
system 00:01: [mem 0xfc000000-0xfcffffff] has been reserved
system 00:01: [mem 0xfd000000-0xfdffffff] has been reserved
system 00:01: [mem 0xfe000000-0xfeafffff] has been reserved
system 00:01: [mem 0xfeb00000-0xfebfffff] has been reserved
system 00:01: [mem 0xfed00400-0xfed3ffff] could not be reserved
system 00:01: [mem 0xfed45000-0xfedfffff] has been reserved
system 00:01: Plug and Play ACPI device, IDs PNP0c01 (active)
pnp 00:02: [io  0x0000-0xffffffffffffffff disabled]
pnp 00:02: [io  0x0a00-0x0a0f]
pnp 00:02: [io  0x0a30-0x0a3f]
pnp 00:02: [io  0x0a20-0x0a2f]
system 00:02: [io  0x0a00-0x0a0f] has been reserved
system 00:02: [io  0x0a30-0x0a3f] has been reserved
system 00:02: [io  0x0a20-0x0a2f] has been reserved
system 00:02: Plug and Play ACPI device, IDs PNP0c02 (active)
pnp 00:03: [io  0x0060]
pnp 00:03: [io  0x0064]
pnp 00:03: [irq 1]
pnp 00:03: Plug and Play ACPI device, IDs PNP0303 PNP030b (active)
pnp 00:04: [dma 4]
pnp 00:04: [io  0x0000-0x000f]
pnp 00:04: [io  0x0081-0x0083]
pnp 00:04: [io  0x0087]
pnp 00:04: [io  0x0089-0x008b]
pnp 00:04: [io  0x008f]
pnp 00:04: [io  0x00c0-0x00df]
pnp 00:04: Plug and Play ACPI device, IDs PNP0200 (active)
pnp 00:05: [io  0x0070-0x0071]
pnp 00:05: [irq 8]
pnp 00:05: Plug and Play ACPI device, IDs PNP0b00 (active)
pnp 00:06: [io  0x0061]
pnp 00:06: Plug and Play ACPI device, IDs PNP0800 (active)
pnp 00:07: [io  0x0010-0x001f]
pnp 00:07: [io  0x0022-0x003f]
pnp 00:07: [io  0x0044-0x005f]
pnp 00:07: [io  0x0062-0x0063]
pnp 00:07: [io  0x0065-0x006f]
pnp 00:07: [io  0x0072-0x007f]
pnp 00:07: [io  0x0080]
pnp 00:07: [io  0x0084-0x0086]
pnp 00:07: [io  0x0088]
pnp 00:07: [io  0x008c-0x008e]
pnp 00:07: [io  0x0090-0x009f]
pnp 00:07: [io  0x00a2-0x00bf]
pnp 00:07: [io  0x00e0-0x00ef]
pnp 00:07: [io  0x04d0-0x04d1]
system 00:07: [io  0x04d0-0x04d1] has been reserved
system 00:07: Plug and Play ACPI device, IDs PNP0c02 (active)
pnp 00:08: [io  0x00f0-0x00ff]
pnp 00:08: [irq 13]
pnp 00:08: Plug and Play ACPI device, IDs PNP0c04 (active)
pnp 00:09: [io  0x0400-0x0453]
pnp 00:09: [io  0x0458-0x047f]
pnp 00:09: [io  0x1180-0x119f]
pnp 00:09: [io  0x0500-0x057f]
pnp 00:09: [mem 0xfed1c000-0xfed1ffff]
pnp 00:09: [mem 0xfec00000-0xfecfffff]
pnp 00:09: [mem 0xfed08000-0xfed08fff]
pnp 00:09: [mem 0xff000000-0xffffffff]
system 00:09: [io  0x0400-0x0453] has been reserved
system 00:09: [io  0x0458-0x047f] has been reserved
system 00:09: [io  0x1180-0x119f] has been reserved
system 00:09: [io  0x0500-0x057f] has been reserved
system 00:09: [mem 0xfed1c000-0xfed1ffff] has been reserved
system 00:09: [mem 0xfec00000-0xfecfffff] could not be reserved
system 00:09: [mem 0xfed08000-0xfed08fff] has been reserved
system 00:09: [mem 0xff000000-0xffffffff] has been reserved
system 00:09: Plug and Play ACPI device, IDs PNP0c01 (active)
pnp 00:0a: [io  0x0454-0x0457]
system 00:0a: [io  0x0454-0x0457] has been reserved
system 00:0a: Plug and Play ACPI device, IDs INT3f0d PNP0c02 (active)
pnp 00:0b: [mem 0xfed00000-0xfed003ff]
pnp 00:0b: Plug and Play ACPI device, IDs PNP0103 (active)
pnp 00:0c: [bus ff]
pnp 00:0c: Plug and Play ACPI device, IDs PNP0a03 (active)
pnp: PnP ACPI: found 13 devices
ACPI: ACPI bus type pnp unregistered
pci 0000:00:01.0: PCI bridge to [bus 01]
pci 0000:00:01.0:   bridge window [io  0xe000-0xefff]
pci 0000:00:01.0:   bridge window [mem 0xf8000000-0xfb0fffff]
pci 0000:00:01.0:   bridge window [mem 0xd0000000-0xdfffffff 64bit pref]
pci 0000:00:02.0: PCI bridge to [bus 02]
pci 0000:00:03.0: PCI bridge to [bus 03]
pci 0000:00:11.0: PCI bridge to [bus 04]
pci 0000:00:1c.0: PCI bridge to [bus 05]
pci 0000:00:1c.0:   bridge window [io  0xd000-0xdfff]
pci 0000:00:1c.0:   bridge window [mem 0xfb600000-0xfb6fffff]
pci 0000:00:1c.1: PCI bridge to [bus 06]
pci 0000:00:1c.1:   bridge window [io  0xc000-0xcfff]
pci 0000:00:1c.1:   bridge window [mem 0xfb500000-0xfb5fffff]
pci 0000:00:1c.2: PCI bridge to [bus 07]
pci 0000:00:1c.3: PCI bridge to [bus 08]
pci 0000:00:1c.5: PCI bridge to [bus 09]
pci 0000:00:1c.5:   bridge window [mem 0xfb400000-0xfb4fffff]
pci 0000:00:1c.6: PCI bridge to [bus 0a]
pci 0000:00:1c.6:   bridge window [mem 0xfb300000-0xfb3fffff]
pci 0000:00:1c.7: PCI bridge to [bus 0b]
pci 0000:00:1c.7:   bridge window [io  0xb000-0xbfff]
pci 0000:00:1c.7:   bridge window [mem 0xfb200000-0xfb2fffff]
pci 0000:00:1e.0: PCI bridge to [bus 0c]
pci 0000:00:1e.0:   bridge window [io  0xa000-0xafff]
pci 0000:00:1e.0:   bridge window [mem 0xfb100000-0xfb1fffff]
pci 0000:00:1e.0: setting latency timer to 64
pci_bus 0000:00: resource 4 [io  0x0000-0x03af]
pci_bus 0000:00: resource 5 [io  0x03e0-0x0cf7]
pci_bus 0000:00: resource 6 [io  0x03b0-0x03df]
pci_bus 0000:00: resource 7 [io  0x0d00-0xffff]
pci_bus 0000:00: resource 8 [mem 0x000a0000-0x000bffff]
pci_bus 0000:00: resource 9 [mem 0x000c0000-0x000dffff]
pci_bus 0000:00: resource 10 [mem 0xd0000000-0xfbffffff]
pci_bus 0000:01: resource 0 [io  0xe000-0xefff]
pci_bus 0000:01: resource 1 [mem 0xf8000000-0xfb0fffff]
pci_bus 0000:01: resource 2 [mem 0xd0000000-0xdfffffff 64bit pref]
pci_bus 0000:05: resource 0 [io  0xd000-0xdfff]
pci_bus 0000:05: resource 1 [mem 0xfb600000-0xfb6fffff]
pci_bus 0000:06: resource 0 [io  0xc000-0xcfff]
pci_bus 0000:06: resource 1 [mem 0xfb500000-0xfb5fffff]
pci_bus 0000:09: resource 1 [mem 0xfb400000-0xfb4fffff]
pci_bus 0000:0a: resource 1 [mem 0xfb300000-0xfb3fffff]
pci_bus 0000:0b: resource 0 [io  0xb000-0xbfff]
pci_bus 0000:0b: resource 1 [mem 0xfb200000-0xfb2fffff]
pci_bus 0000:0c: resource 0 [io  0xa000-0xafff]
pci_bus 0000:0c: resource 1 [mem 0xfb100000-0xfb1fffff]
pci_bus 0000:0c: resource 4 [io  0x0000-0x03af]
pci_bus 0000:0c: resource 5 [io  0x03e0-0x0cf7]
pci_bus 0000:0c: resource 6 [io  0x03b0-0x03df]
pci_bus 0000:0c: resource 7 [io  0x0d00-0xffff]
pci_bus 0000:0c: resource 8 [mem 0x000a0000-0x000bffff]
pci_bus 0000:0c: resource 9 [mem 0x000c0000-0x000dffff]
pci_bus 0000:0c: resource 10 [mem 0xd0000000-0xfbffffff]
NET: Registered protocol family 2
TCP established hash table entries: 262144 (order: 10, 4194304 bytes)
TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
TCP: Hash tables configured (established 262144 bind 65536)
TCP: reno registered
UDP hash table entries: 16384 (order: 7, 524288 bytes)
UDP-Lite hash table entries: 16384 (order: 7, 524288 bytes)
NET: Registered protocol family 1
RPC: Registered named UNIX socket transport module.
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
RPC: Registered tcp NFSv4.1 backchannel transport module.
pci 0000:01:00.0: Boot video device
PCI: CLS 64 bytes, default 64
dmar: Host address width 46
dmar: DRHD base: 0x000000fbffc000 flags: 0x1
dmar: IOMMU 0: reg_base_addr fbffc000 ver 1:0 cap d2078c106f0462 ecap f020ff
dmar: RMRR base: 0x000000ccf10000 end: 0x000000ccf2cfff
dmar: RHSA base: 0x000000fbffc000 proximity domain: 0x0
DMAR: No ATSR found
IOMMU 0 0xfbffc000: using Queued invalidation
IOMMU: Setting RMRR:
IOMMU: Setting identity map for device 0000:00:1d.0 [0xccf10000 - 0xccf2cfff]
IOMMU: Setting identity map for device 0000:00:1a.0 [0xccf10000 - 0xccf2cfff]
IOMMU: Prepare 0-16MiB unity mapping for LPC
IOMMU: Setting identity map for device 0000:00:1f.0 [0x0 - 0xffffff]
PCI-DMA: Intel(R) Virtualization Technology for Directed I/O
microcode: CPU0 sig=0x206d7, pf=0x4, revision=0x70a
microcode: CPU1 sig=0x206d7, pf=0x4, revision=0x70a
microcode: CPU2 sig=0x206d7, pf=0x4, revision=0x70a
microcode: CPU3 sig=0x206d7, pf=0x4, revision=0x70a
microcode: CPU4 sig=0x206d7, pf=0x4, revision=0x70a
microcode: CPU5 sig=0x206d7, pf=0x4, revision=0x70a
microcode: CPU6 sig=0x206d7, pf=0x4, revision=0x70a
microcode: CPU7 sig=0x206d7, pf=0x4, revision=0x70a
microcode: CPU8 sig=0x206d7, pf=0x4, revision=0x70a
microcode: CPU9 sig=0x206d7, pf=0x4, revision=0x70a
microcode: CPU10 sig=0x206d7, pf=0x4, revision=0x70a
microcode: CPU11 sig=0x206d7, pf=0x4, revision=0x70a
microcode: Microcode Update Driver: v2.00 <tigran@aivazian.fsnet.co.uk>, Peter Oruba
sha1_ssse3: Using AVX optimized SHA-1 implementation
NFS: Registering the id_resolver key type
Key type id_resolver registered
Key type id_legacy registered
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
NTFS driver 2.1.30 [Flags: R/O].
fuse init (API version 7.20)
msgmni has been set to 32768
Block layer SCSI generic (bsg) driver version 0.4 loaded (major 252)
io scheduler noop registered
io scheduler deadline registered
io scheduler cfq registered (default)
pcieport 0000:00:01.0: irq 41 for MSI/MSI-X
pcieport 0000:00:02.0: irq 42 for MSI/MSI-X
pcieport 0000:00:03.0: irq 43 for MSI/MSI-X
pcieport 0000:00:11.0: irq 44 for MSI/MSI-X
pcieport 0000:00:1c.0: irq 45 for MSI/MSI-X
pcieport 0000:00:1c.1: irq 46 for MSI/MSI-X
pcieport 0000:00:1c.2: irq 47 for MSI/MSI-X
pcieport 0000:00:1c.3: irq 48 for MSI/MSI-X
pcieport 0000:00:1c.5: irq 49 for MSI/MSI-X
pcieport 0000:00:1c.6: irq 50 for MSI/MSI-X
pcieport 0000:00:1c.7: irq 51 for MSI/MSI-X
ioapic: probe of 0000:00:05.4 failed with error -22
input: Power Button as /devices/LNXSYSTM:00/device:00/PNP0C0C:00/input/input0
ACPI: Power Button [PWRB]
input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input1
ACPI: Power Button [PWRF]
ACPI: Requesting acpi_cpufreq
ACPI Error: [\TST0] Namespace lookup failure, AE_NOT_FOUND (20120711/psargs-359)
ACPI Error: Method parse/execution failed [\_SB_.C000._TPC] (Node ffff88080c07c7f8), AE_NOT_FOUND (20120711/psparse-536)
Monitor-Mwait will be used to enter C-1 state
Monitor-Mwait will be used to enter C-3 state
Monitor-Mwait will be used to enter C-3 state
ACPI: acpi_idle registered with cpuidle
ACPI Error: [\TST0] Namespace lookup failure, AE_NOT_FOUND (20120711/psargs-359)
ACPI Error: Method parse/execution failed [\_SB_.C001._TPC] (Node ffff88080c0815c8), AE_NOT_FOUND (20120711/psparse-536)
ACPI Error: [\TST0] Namespace lookup failure, AE_NOT_FOUND (20120711/psargs-359)
ACPI Error: Method parse/execution failed [\_SB_.C002._TPC] (Node ffff88080c085398), AE_NOT_FOUND (20120711/psparse-536)
ACPI Error: [\TST0] Namespace lookup failure, AE_NOT_FOUND (20120711/psargs-359)
ACPI Error: Method parse/execution failed [\_SB_.C003._TPC] (Node ffff88080c089168), AE_NOT_FOUND (20120711/psparse-536)
ACPI Error: [\TST0] Namespace lookup failure, AE_NOT_FOUND (20120711/psargs-359)
ACPI Error: Method parse/execution failed [\_SB_.C004._TPC] (Node ffff88080c08cf28), AE_NOT_FOUND (20120711/psparse-536)
ACPI Error: [\TST0] Namespace lookup failure, AE_NOT_FOUND (20120711/psargs-359)
ACPI Error: Method parse/execution failed [\_SB_.C005._TPC] (Node ffff88080c090cf8), AE_NOT_FOUND (20120711/psparse-536)
ACPI Error: [\TST0] Namespace lookup failure, AE_NOT_FOUND (20120711/psargs-359)
ACPI Error: Method parse/execution failed [\_SB_.C006._TPC] (Node ffff88080c094ac8), AE_NOT_FOUND (20120711/psparse-536)
ACPI Error: [\TST0] Namespace lookup failure, AE_NOT_FOUND (20120711/psargs-359)
ACPI Error: Method parse/execution failed [\_SB_.C007._TPC] (Node ffff88080c098898), AE_NOT_FOUND (20120711/psparse-536)
ACPI Error: [\TST0] Namespace lookup failure, AE_NOT_FOUND (20120711/psargs-359)
ACPI Error: Method parse/execution failed [\_SB_.C008._TPC] (Node ffff88080c09c668), AE_NOT_FOUND (20120711/psparse-536)
ACPI Error: [\TST0] Namespace lookup failure, AE_NOT_FOUND (20120711/psargs-359)
ACPI Error: Method parse/execution failed [\_SB_.C009._TPC] (Node ffff88080c0a0438), AE_NOT_FOUND (20120711/psparse-536)
ACPI Error: [\TST0] Namespace lookup failure, AE_NOT_FOUND (20120711/psargs-359)
ACPI Error: Method parse/execution failed [\_SB_.C00A._TPC] (Node ffff88080c0a4208), AE_NOT_FOUND (20120711/psparse-536)
ACPI Error: [\TST0] Namespace lookup failure, AE_NOT_FOUND (20120711/psargs-359)
ACPI Error: Method parse/execution failed [\_SB_.C00B._TPC] (Node ffff88080c0a7fc8), AE_NOT_FOUND (20120711/psparse-536)
Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
Non-volatile memory driver v1.3
Linux agpgart interface v0.103
ipmi message handler version 39.2
ipmi device interface
IPMI System Interface driver.
ipmi_si: Adding default-specified kcs state machine
ipmi_si: Trying default-specified kcs state machine at i/o address 0xca2, slave address 0x0, irq 0
ipmi_si: Interface detection failed
ipmi_si: Adding default-specified smic state machine
ipmi_si: Trying default-specified smic state machine at i/o address 0xca9, slave address 0x0, irq 0
ipmi_si: Interface detection failed
ipmi_si: Adding default-specified bt state machine
ipmi_si: Trying default-specified bt state machine at i/o address 0xe4, slave address 0x0, irq 0
ipmi_si: Interface detection failed
ipmi_si: Unable to find any System Interface(s)
IPMI Watchdog: driver initialized
Copyright (C) 2004 MontaVista Software - IPMI Powerdown via sys_reboot.
[drm] Initialized drm 1.1.0 20060810
nbd: registered device at major 43
ACPI Warning: 0x0000000000000500-0x000000000000053f SystemIO conflicts with Region \_SB_.PCI0.SBRG.LED_ 1 (20120711/utaddress-251)
ACPI: If an ACPI driver is available for this device, you should use it instead of the native driver
lpc_ich: Resource conflict(s) found affecting gpio_ich
ahci 0000:00:1f.2: version 3.0
ahci 0000:00:1f.2: irq 52 for MSI/MSI-X
ahci: SSS flag set, parallel bus scan disabled
ahci 0000:00:1f.2: AHCI 0001.0300 32 slots 6 ports 6 Gbps 0x3f impl SATA mode
ahci 0000:00:1f.2: flags: 64bit ncq sntf stag led clo pio ems apst 
ahci 0000:00:1f.2: setting latency timer to 64
scsi0 : ahci
scsi1 : ahci
scsi2 : ahci
scsi3 : ahci
scsi4 : ahci
scsi5 : ahci
ata1: SATA max UDMA/133 abar m2048@0xfb745000 port 0xfb745100 irq 52
ata2: SATA max UDMA/133 abar m2048@0xfb745000 port 0xfb745180 irq 52
ata3: SATA max UDMA/133 abar m2048@0xfb745000 port 0xfb745200 irq 52
ata4: SATA max UDMA/133 abar m2048@0xfb745000 port 0xfb745280 irq 52
ata5: SATA max UDMA/133 abar m2048@0xfb745000 port 0xfb745300 irq 52
ata6: SATA max UDMA/133 abar m2048@0xfb745000 port 0xfb745380 irq 52
ahci 0000:05:00.0: irq 53 for MSI/MSI-X
ahci 0000:05:00.0: AHCI 0001.0000 32 slots 2 ports 6 Gbps 0x3 impl SATA mode
ahci 0000:05:00.0: flags: 64bit ncq sntf led only pmp fbs pio slum part sxs 
scsi6 : ahci
scsi7 : ahci
ata7: SATA max UDMA/133 abar m512@0xfb610000 port 0xfb610100 irq 53
ata8: SATA max UDMA/133 abar m512@0xfb610000 port 0xfb610180 irq 53
ahci 0000:06:00.0: irq 54 for MSI/MSI-X
ahci 0000:06:00.0: AHCI 0001.0000 32 slots 2 ports 6 Gbps 0x3 impl SATA mode
ahci 0000:06:00.0: flags: 64bit ncq sntf led only pmp fbs pio slum part sxs 
scsi8 : ahci
scsi9 : ahci
ata9: SATA max UDMA/133 abar m512@0xfb510000 port 0xfb510100 irq 54
ata10: SATA max UDMA/133 abar m512@0xfb510000 port 0xfb510180 irq 54
ahci 0000:0b:00.0: irq 55 for MSI/MSI-X
ahci 0000:0b:00.0: AHCI 0001.0000 32 slots 2 ports 6 Gbps 0x3 impl SATA mode
ahci 0000:0b:00.0: flags: 64bit ncq sntf led only pmp fbs pio slum part sxs 
scsi10 : ahci
scsi11 : ahci
ata11: SATA max UDMA/133 abar m512@0xfb210000 port 0xfb210100 irq 55
ata12: SATA max UDMA/133 abar m512@0xfb210000 port 0xfb210180 irq 55
usbcore: registered new interface driver asix
usbcore: registered new interface driver cdc_ncm
ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
ehci_hcd 0000:00:1a.0: setting latency timer to 64
ehci_hcd 0000:00:1a.0: EHCI Host Controller
ehci_hcd 0000:00:1a.0: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:1a.0: debug port 2
ehci_hcd 0000:00:1a.0: cache line size of 64 is not supported
ehci_hcd 0000:00:1a.0: irq 16, io mem 0xfb747000
ehci_hcd 0000:00:1a.0: USB 2.0 started, EHCI 1.00
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
ehci_hcd 0000:00:1d.0: setting latency timer to 64
ehci_hcd 0000:00:1d.0: EHCI Host Controller
ehci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
dmar: DRHD: handling fault status reg 2
dmar: DMAR:[DMA Write] Request device [05:00.1] fault addr fffe0000 
DMAR:[fault reason 02] Present bit in context entry is clear
ehci_hcd 0000:00:1d.0: debug port 2
ehci_hcd 0000:00:1d.0: cache line size of 64 is not supported
ehci_hcd 0000:00:1d.0: irq 23, io mem 0xfb746000
dmar: DRHD: handling fault status reg 102
dmar: DMAR:[DMA Write] Request device [05:00.1] fault addr fffc0000 
DMAR:[fault reason 02] Present bit in context entry is clear
ehci_hcd 0000:00:1d.0: USB 2.0 started, EHCI 1.00
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
uhci_hcd: USB Universal Host Controller Interface driver
usbcore: registered new interface driver usblp
Initializing USB Mass Storage driver...
usbcore: registered new interface driver usb-storage
USB Mass Storage support registered.
usbcore: registered new interface driver usbserial
usbcore: registered new interface driver usbserial_generic
USB Serial support registered for generic
usbserial: USB Serial Driver core
usbcore: registered new interface driver ipaq
USB Serial support registered for PocketPC PDA
usbcore: registered new interface driver pl2303
USB Serial support registered for pl2303
i8042: PNP: PS/2 Controller [PNP0303:PS2K] at 0x60,0x64 irq 1
i8042: PNP: PS/2 appears to have AUX port disabled, if this is incorrect please boot with i8042.nopnp
serio: i8042 KBD port at 0x60,0x64 irq 1
mousedev: PS/2 mouse device common for all mice
input: PC Speaker as /devices/platform/pcspkr/input/input2
rtc_cmos 00:05: RTC can wake from S4
rtc_cmos 00:05: rtc core: registered rtc_cmos as rtc0
rtc0: alarms up to one month, y3k, 114 bytes nvram, hpet irqs
i2c /dev entries driver
iTCO_wdt: Intel TCO WatchDog Timer Driver v1.10
iTCO_wdt: Found a Patsburg TCO device (Version=2, TCOBASE=0x0460)
iTCO_wdt: initialized. heartbeat=30 sec (nowayout=0)
iTCO_vendor_support: vendor-support=0
md: raid0 personality registered for level 0
md: raid1 personality registered for level 1
md: raid10 personality registered for level 10
md: multipath personality registered for level -4
device-mapper: uevent: version 1.0.3
device-mapper: ioctl: 4.23.0-ioctl (2012-07-25) initialised: dm-devel@redhat.com
cpuidle: using governor ladder
cpuidle: using governor menu
usbcore: registered new interface driver usbhid
usbhid: USB HID core driver
snd_hda_intel 0000:00:1b.0: irq 56 for MSI/MSI-X
input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input3
NET: Registered protocol family 26
TCP: cubic registered
Initializing XFRM netlink socket
NET: Registered protocol family 10
sit: IPv6 over IPv4 tunneling driver
NET: Registered protocol family 17
NET: Registered protocol family 15
Key type dns_resolver registered
registered taskstats version 1
rtc_cmos 00:05: setting system clock to 2013-10-04 03:58:35 UTC (1380859115)
ALSA device list:
  #0: HDA Intel PCH at 0xfb720000 irq 56
ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
usb 1-1: new high-speed USB device number 2 using ehci_hcd
ata12: SATA link down (SStatus 0 SControl 300)
ata10: SATA link down (SStatus 0 SControl 300)
ata11: SATA link down (SStatus 0 SControl 300)
ata9: SATA link down (SStatus 0 SControl 300)
dmar: DRHD: handling fault status reg 202
dmar: DMAR:[DMA Write] Request device [05:00.1] fault addr fffc0000 
DMAR:[fault reason 02] Present bit in context entry is clear
ata1.00: ATA-9: SAMSUNG SSD 830 Series, CXM03B1Q, max UDMA/133
ata1.00: 500118192 sectors, multi 16: LBA48 NCQ (depth 31/32), AA
dmar: DRHD: handling fault status reg 302
dmar: DMAR:[DMA Write] Request device [05:00.1] fault addr fffe0000 
DMAR:[fault reason 02] Present bit in context entry is clear
ata1.00: configured for UDMA/133
scsi 0:0:0:0: Direct-Access     ATA      SAMSUNG SSD 830  CXM0 PQ: 0 ANSI: 5
sd 0:0:0:0: [sda] 500118192 512-byte logical blocks: (256 GB/238 GiB)
sd 0:0:0:0: Attached scsi generic sg0 type 0
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sda: unknown partition table
sd 0:0:0:0: [sda] Attached SCSI disk
hub 1-1:1.0: USB hub found
hub 1-1:1.0: 6 ports detected
ata8: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
ata7: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
dmar: DRHD: handling fault status reg 402
dmar: DMAR:[DMA Write] Request device [05:00.1] fault addr fffc0000 
DMAR:[fault reason 02] Present bit in context entry is clear
ata8.00: failed to IDENTIFY (INIT_DEV_PARAMS failed, err_mask=0x80)
usb 2-1: new high-speed USB device number 2 using ehci_hcd
hub 2-1:1.0: USB hub found
hub 2-1:1.0: 8 ports detected
ata2: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
ata2.00: ATA-9: SAMSUNG SSD 830 Series, CXM03B1Q, max UDMA/133
ata2.00: 500118192 sectors, multi 16: LBA48 NCQ (depth 31/32), AA
ata2.00: configured for UDMA/133
scsi 1:0:0:0: Direct-Access     ATA      SAMSUNG SSD 830  CXM0 PQ: 0 ANSI: 5
sd 1:0:0:0: [sdb] 500118192 512-byte logical blocks: (256 GB/238 GiB)
sd 1:0:0:0: Attached scsi generic sg1 type 0
sd 1:0:0:0: [sdb] Write Protect is off
sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sdb:
sd 1:0:0:0: [sdb] Attached SCSI disk
tsc: Refined TSC clocksource calibration: 3200.029 MHz
Switching to clocksource tsc
ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata3.00: ATA-8: WDC WD1001FALS-00J7B0, 05.00K05, max UDMA/133
ata3.00: 1953525168 sectors, multi 16: LBA48 NCQ (depth 31/32), AA
ata3.00: configured for UDMA/133
scsi 2:0:0:0: Direct-Access     ATA      WDC WD1001FALS-0 05.0 PQ: 0 ANSI: 5
sd 2:0:0:0: [sdc] 1953525168 512-byte logical blocks: (1.00 TB/931 GiB)
sd 2:0:0:0: Attached scsi generic sg2 type 0
sd 2:0:0:0: [sdc] Write Protect is off
sd 2:0:0:0: [sdc] Mode Sense: 00 3a 00 00
sd 2:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sdc: sdc1 sdc2 sdc3
sd 2:0:0:0: [sdc] Attached SCSI disk
ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata4.00: ATA-8: WDC WD1001FALS-00J7B0, 05.00K05, max UDMA/133
ata4.00: 1953525168 sectors, multi 16: LBA48 NCQ (depth 31/32), AA
ata4.00: configured for UDMA/133
scsi 3:0:0:0: Direct-Access     ATA      WDC WD1001FALS-0 05.0 PQ: 0 ANSI: 5
sd 3:0:0:0: [sdd] 1953525168 512-byte logical blocks: (1.00 TB/931 GiB)
sd 3:0:0:0: Attached scsi generic sg3 type 0
sd 3:0:0:0: [sdd] Write Protect is off
sd 3:0:0:0: [sdd] Mode Sense: 00 3a 00 00
sd 3:0:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sdd: sdd1 sdd2 sdd3
sd 3:0:0:0: [sdd] Attached SCSI disk
ata5: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata5.00: ATA-8: WDC WD30EZRS-00J99B0, 80.00A80, max UDMA/133
ata5.00: 5860533168 sectors, multi 16: LBA48 NCQ (depth 31/32), AA
ata5.00: configured for UDMA/133
scsi 4:0:0:0: Direct-Access     ATA      WDC WD30EZRS-00J 80.0 PQ: 0 ANSI: 5
sd 4:0:0:0: [sde] 5860533168 512-byte logical blocks: (3.00 TB/2.72 TiB)
sd 4:0:0:0: [sde] 4096-byte physical blocks
sd 4:0:0:0: Attached scsi generic sg4 type 0
sd 4:0:0:0: [sde] Write Protect is off
sd 4:0:0:0: [sde] Mode Sense: 00 3a 00 00
sd 4:0:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sde: unknown partition table
sd 4:0:0:0: [sde] Attached SCSI disk
ata6: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata6.00: ATA-8: WDC WD30EZRS-00J99B0, 80.00A80, max UDMA/133
ata6.00: 5860533168 sectors, multi 16: LBA48 NCQ (depth 31/32), AA
ata6.00: configured for UDMA/133
scsi 5:0:0:0: Direct-Access     ATA      WDC WD30EZRS-00J 80.0 PQ: 0 ANSI: 5
sd 5:0:0:0: [sdf] 5860533168 512-byte logical blocks: (3.00 TB/2.72 TiB)
sd 5:0:0:0: [sdf] 4096-byte physical blocks
sd 5:0:0:0: Attached scsi generic sg5 type 0
sd 5:0:0:0: [sdf] Write Protect is off
sd 5:0:0:0: [sdf] Mode Sense: 00 3a 00 00
sd 5:0:0:0: [sdf] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sdf: unknown partition table
sd 5:0:0:0: [sdf] Attached SCSI disk
ata7.00: failed to IDENTIFY (INIT_DEV_PARAMS failed, err_mask=0x80)
dmar: DRHD: handling fault status reg 502
dmar: DMAR:[DMA Write] Request device [05:00.1] fault addr fffc0000 
DMAR:[fault reason 02] Present bit in context entry is clear
dmar: DRHD: handling fault status reg 602
dmar: DMAR:[DMA Write] Request device [05:00.1] fault addr fffe0000 
DMAR:[fault reason 02] Present bit in context entry is clear
dmar: DRHD: handling fault status reg 702
dmar: DMAR:[DMA Write] Request device [05:00.1] fault addr fffc0000 
DMAR:[fault reason 02] Present bit in context entry is clear
dmar: DRHD: handling fault status reg 2
dmar: DMAR:[DMA Write] Request device [05:00.1] fault addr fffe0000 
DMAR:[fault reason 02] Present bit in context entry is clear
ata8: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
ata7: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
dmar: DRHD: handling fault status reg 102
dmar: DMAR:[DMA Write] Request device [05:00.1] fault addr fffc0000 
DMAR:[fault reason 02] Present bit in context entry is clear
dmar: DMAR:[DMA Write] Request device [05:00.1] fault addr fffe0000 
DMAR:[fault reason 02] Present bit in context entry is clear
dmar: DRHD: handling fault status reg 300
ata7.00: failed to IDENTIFY (INIT_DEV_PARAMS failed, err_mask=0x80)
ata7: limiting SATA link speed to 1.5 Gbps
ata8.00: failed to IDENTIFY (INIT_DEV_PARAMS failed, err_mask=0x80)
ata8: limiting SATA link speed to 3.0 Gbps
dmar: DRHD: handling fault status reg 302
dmar: DMAR:[DMA Write] Request device [05:00.1] fault addr fffc0000 
DMAR:[fault reason 02] Present bit in context entry is clear
dmar: DRHD: handling fault status reg 402
dmar: DMAR:[DMA Write] Request device [05:00.1] fault addr fffe0000 
DMAR:[fault reason 02] Present bit in context entry is clear
dmar: DRHD: handling fault status reg 502
dmar: DMAR:[DMA Write] Request device [05:00.1] fault addr fffc0000 
DMAR:[fault reason 02] Present bit in context entry is clear
dmar: DRHD: handling fault status reg 602
dmar: DMAR:[DMA Write] Request device [05:00.1] fault addr fffe0000 
DMAR:[fault reason 02] Present bit in context entry is clear
ata8: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
ata7: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
dmar: DRHD: handling fault status reg 702
dmar: DMAR:[DMA Write] Request device [05:00.1] fault addr fffc0000 
DMAR:[fault reason 02] Present bit in context entry is clear
dmar: DMAR:[DMA Write] Request device [05:00.1] fault addr fffe0000 
DMAR:[fault reason 02] Present bit in context entry is clear
dmar: DRHD: handling fault status reg 100
ata7.00: failed to IDENTIFY (INIT_DEV_PARAMS failed, err_mask=0x80)
ata8.00: failed to IDENTIFY (INIT_DEV_PARAMS failed, err_mask=0x80)
dmar: DRHD: handling fault status reg 102
dmar: DMAR:[DMA Write] Request device [05:00.1] fault addr fffc0000 
DMAR:[fault reason 02] Present bit in context entry is clear
dmar: DRHD: handling fault status reg 202
dmar: DMAR:[DMA Write] Request device [05:00.1] fault addr fffe0000 
DMAR:[fault reason 02] Present bit in context entry is clear
dmar: DRHD: handling fault status reg 302
dmar: DMAR:[DMA Write] Request device [05:00.1] fault addr fffc0000 
DMAR:[fault reason 02] Present bit in context entry is clear
dmar: DRHD: handling fault status reg 402
dmar: DMAR:[DMA Write] Request device [05:00.1] fault addr fffe0000 
DMAR:[fault reason 02] Present bit in context entry is clear
ata8: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
ata7: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
md: Waiting for all devices to be available before autodetect
md: If you don't use raid, use raid=noautodetect
md: Autodetecting RAID arrays.
md: Scanned 6 and added 6 devices.
md: autorun ...
md: considering sdd3 ...
md:  adding sdd3 ...
md: sdd2 has different UUID to sdd3
md: sdd1 has different UUID to sdd3
md:  adding sdc3 ...
md: sdc2 has different UUID to sdd3
md: sdc1 has different UUID to sdd3
md: created md3
md: bind<sdc3>
md: bind<sdd3>
md: running: <sdd3><sdc3>
bio: create slab <bio-1> at 1
md/raid0:md3: md_size is 6457856 sectors.
md: RAID0 configuration for md3 - 1 zone
md: zone0=[sdd3/sdc3]
      zone-offset=         0KB, device-offset=         0KB, size=   3228928KB

md3: detected capacity change from 0 to 3306422272
md: considering sdd2 ...
md:  adding sdd2 ...
md: sdd1 has different UUID to sdd2
md:  adding sdc2 ...
md: sdc1 has different UUID to sdd2
md: created md2
md: bind<sdc2>
md: bind<sdd2>
md: running: <sdd2><sdc2>
md/raid0:md2: md_size is 3666161152 sectors.
md: RAID0 configuration for md2 - 1 zone
md: zone0=[sdd2/sdc2]
      zone-offset=         0KB, device-offset=         0KB, size=1833080576KB

md2: detected capacity change from 0 to 1877074509824
md: considering sdd1 ...
md:  adding sdd1 ...
md:  adding sdc1 ...
md: created md1
md: bind<sdc1>
md: bind<sdd1>
md: running: <sdd1><sdc1>
md/raid1:md1: active with 2 out of 2 mirrors
md1: detected capacity change from 0 to 60011511808
md: ... autorun DONE.
 md1:
EXT4-fs (md1): couldn't mount as ext3 due to feature incompatibilities
EXT4-fs (md1): couldn't mount as ext2 due to feature incompatibilities
EXT4-fs (md1): mounted filesystem with ordered data mode. Opts: (null)
VFS: Mounted root (ext4 filesystem) readonly on device 9:1.
Freeing unused kernel memory: 504k freed
 md3: unknown partition table
Adding 3228924k swap on /dev/md3.  Priority:-1 extents:1 across:3228924k 
EXT4-fs (md1): re-mounted. Opts: (null)
EXT4-fs (md1): re-mounted. Opts: (null)
 md2: unknown partition table
EXT4-fs (md2): mounting ext3 file system using the ext4 subsystem
EXT4-fs (md2): mounted filesystem with ordered data mode. Opts: (null)
udevd[1997]: starting version 182
dca service started, version 1.12.1
e1000e: Intel(R) PRO/1000 Network Driver - 2.0.0-k
e1000e: Copyright(c) 1999 - 2012 Intel Corporation.
e1000e 0000:00:19.0: setting latency timer to 64
e1000e 0000:00:19.0: Interrupt Throttling Rate (ints/sec) set to dynamic conservative mode
e1000e 0000:00:19.0: irq 57 for MSI/MSI-X
ioatdma: Intel(R) QuickData Technology Driver 4.00
firewire_ohci 0000:0c:03.0: added OHCI v1.10 device as card 0, 4 IR + 8 IT contexts, quirks 0x11
e1000e 0000:00:19.0: eth0: (PCI Express:2.5GT/s:Width x1) 90:2b:34:50:a3:25
e1000e 0000:00:19.0: eth0: Intel(R) PRO/1000 Network Connection
e1000e 0000:00:19.0: eth0: MAC: 10, PHY: 11, PBA No: FFFFFF-0FF
ioatdma 0000:00:04.0: can't derive routing for PCI INT A
ioatdma 0000:00:04.0: PCI INT A: no GSI

ioatdma 0000:00:04.0: irq 58 for MSI/MSI-X
ioatdma 0000:00:04.1: can't derive routing for PCI INT B
ioatdma 0000:00:04.1: PCI INT B: no GSI

ioatdma 0000:00:04.1: irq 59 for MSI/MSI-X
ioatdma 0000:00:04.2: can't derive routing for PCI INT C
ioatdma 0000:00:04.2: PCI INT C: no GSI

ioatdma 0000:00:04.2: irq 60 for MSI/MSI-X
ioatdma 0000:00:04.3: can't derive routing for PCI INT D
ioatdma 0000:00:04.3: PCI INT D: no GSI

ioatdma 0000:00:04.3: irq 61 for MSI/MSI-X
ioatdma 0000:00:04.4: can't derive routing for PCI INT A
ioatdma 0000:00:04.4: PCI INT A: no GSI

ioatdma 0000:00:04.4: irq 62 for MSI/MSI-X
ioatdma 0000:00:04.5: can't derive routing for PCI INT B
ioatdma 0000:00:04.5: PCI INT B: no GSI

ioatdma 0000:00:04.5: irq 63 for MSI/MSI-X
ioatdma 0000:00:04.6: can't derive routing for PCI INT C
ioatdma 0000:00:04.6: PCI INT C: no GSI

ioatdma 0000:00:04.6: irq 64 for MSI/MSI-X
ioatdma 0000:00:04.7: can't derive routing for PCI INT D
ioatdma 0000:00:04.7: PCI INT D: no GSI

ioatdma 0000:00:04.7: irq 65 for MSI/MSI-X
firewire_core 0000:0c:03.0: created device fw0: GUID 0049e550b4e04b00, S400
md: bind<sdb>
md: bind<sda>
md/raid0:md0: md_size is 1000235008 sectors.
md: RAID0 configuration for md0 - 1 zone
md: zone0=[sda/sdb]
      zone-offset=         0KB, device-offset=         0KB, size= 500117504KB

md0: detected capacity change from 0 to 512120324096
 md0: unknown partition table
md: bind<sde>
md: bind<sdf>
md/raid1:md4: active with 2 out of 2 mirrors
md4: detected capacity change from 0 to 3000591794176
 md4: unknown partition table
e1000e 0000:00:19.0: irq 57 for MSI/MSI-X
e1000e 0000:00:19.0: irq 57 for MSI/MSI-X
IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
e1000e: eth0 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: Rx/Tx
IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
warning: `squid' uses 32-bit capabilities (legacy support in use)
EXT4-fs (md0): mounted filesystem without journal. Opts: (null)

--------------010104050809060804050608
Content-Type: text/plain; charset=ISO-8859-1;
 name="357.dmesg"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="357.dmesg"

Initializing cgroup subsys cpu
Linux version 3.5.7quad-loop-i7n (root@quad) (gcc version 4.7.1 (GCC) ) #1 SMP Fri Oct 4 03:21:36 CEST 2013
Command line: BOOT_IMAGE=Linux357 ro root=901 vt.default_utf8=0
e820: BIOS-provided physical RAM map:
BIOS-e820: [mem 0x0000000000000000-0x000000000009e7ff] usable
BIOS-e820: [mem 0x000000000009e800-0x000000000009ffff] reserved
BIOS-e820: [mem 0x00000000000e0000-0x00000000000fffff] reserved
BIOS-e820: [mem 0x0000000000100000-0x00000000cca50fff] usable
BIOS-e820: [mem 0x00000000cca51000-0x00000000ccb6afff] ACPI NVS
BIOS-e820: [mem 0x00000000ccb6b000-0x00000000cce91fff] reserved
BIOS-e820: [mem 0x00000000cce92000-0x00000000ccf09fff] ACPI data
BIOS-e820: [mem 0x00000000ccf0a000-0x00000000ccf2cfff] reserved
BIOS-e820: [mem 0x00000000ccf2d000-0x00000000ccf31fff] ACPI NVS
BIOS-e820: [mem 0x00000000ccf32000-0x00000000ccf50fff] reserved
BIOS-e820: [mem 0x00000000ccf51000-0x00000000ccf51fff] ACPI NVS
BIOS-e820: [mem 0x00000000ccf52000-0x00000000ccf54fff] reserved
BIOS-e820: [mem 0x00000000ccf55000-0x00000000ccf5cfff] ACPI NVS
BIOS-e820: [mem 0x00000000ccf5d000-0x00000000ccf87fff] reserved
BIOS-e820: [mem 0x00000000ccf88000-0x00000000cd18afff] ACPI NVS
BIOS-e820: [mem 0x00000000cd18b000-0x00000000cd47dfff] usable
BIOS-e820: [mem 0x00000000cd47e000-0x00000000cd7dafff] reserved
BIOS-e820: [mem 0x00000000cd7db000-0x00000000cd7fffff] usable
BIOS-e820: [mem 0x00000000e0000000-0x00000000efffffff] reserved
BIOS-e820: [mem 0x00000000fed1c000-0x00000000fed1ffff] reserved
BIOS-e820: [mem 0x00000000ff000000-0x00000000ffffffff] reserved
BIOS-e820: [mem 0x0000000100000000-0x000000082fffffff] usable
NX (Execute Disable) protection: active
DMI 2.7 present.
DMI: Gigabyte Technology Co., Ltd. To be filled by O.E.M./X79-UD5, BIOS F10 03/05/2012
e820: update [mem 0x00000000-0x0000ffff] usable ==> reserved
e820: remove [mem 0x000a0000-0x000fffff] usable
No AGP bridge found
e820: last_pfn = 0x830000 max_arch_pfn = 0x400000000
MTRR default type: uncachable
MTRR fixed ranges enabled:
  00000-9FFFF write-back
  A0000-BFFFF uncachable
  C0000-CFFFF write-protect
  D0000-E7FFF uncachable
  E8000-FFFFF write-protect
MTRR variable ranges enabled:
  0 base 000000000000 mask 3FF800000000 write-back
  1 base 000800000000 mask 3FFFE0000000 write-back
  2 base 000820000000 mask 3FFFF0000000 write-back
  3 base 0000CE000000 mask 3FFFFE000000 uncachable
  4 base 0000D0000000 mask 3FFFF0000000 uncachable
  5 base 0000E0000000 mask 3FFFE0000000 uncachable
  6 disabled
  7 disabled
  8 disabled
  9 disabled
x86 PAT enabled: cpu 0, old 0x7040600070406, new 0x7010600070106
original variable MTRRs
reg 0, base: 0GB, range: 32GB, type WB
reg 1, base: 32GB, range: 512MB, type WB
reg 2, base: 33280MB, range: 256MB, type WB
reg 3, base: 3296MB, range: 32MB, type UC
reg 4, base: 3328MB, range: 256MB, type UC
reg 5, base: 3584MB, range: 512MB, type UC
total RAM covered: 32736M
Found optimal setting for mtrr clean up
 gran_size: 64K 	chunk_size: 64M 	num_reg: 9  	lose cover RAM: 0G
New variable MTRRs
reg 0, base: 0GB, range: 2GB, type WB
reg 1, base: 2GB, range: 1GB, type WB
reg 2, base: 3GB, range: 256MB, type WB
reg 3, base: 3296MB, range: 32MB, type UC
reg 4, base: 4GB, range: 4GB, type WB
reg 5, base: 8GB, range: 8GB, type WB
reg 6, base: 16GB, range: 16GB, type WB
reg 7, base: 32GB, range: 512MB, type WB
reg 8, base: 33280MB, range: 256MB, type WB
e820: update [mem 0xce000000-0xffffffff] usable ==> reserved
e820: last_pfn = 0xcd800 max_arch_pfn = 0x400000000
found SMP MP-table at [mem 0x000fcd10-0x000fcd1f] mapped at [ffff8800000fcd10]
initial memory mapped: [mem 0x00000000-0x1fffffff]
Base memory trampoline at [ffff880000098000] 98000 size 24576
Using GB pages for direct mapping
init_memory_mapping: [mem 0x00000000-0xcd7fffff]
 [mem 0x00000000-0xbfffffff] page 1G
 [mem 0xc0000000-0xcd7fffff] page 2M
kernel direct mapping tables up to 0xcd7fffff @ [mem 0x1f9fe000-0x1fffffff]
init_memory_mapping: [mem 0x100000000-0x82fffffff]
 [mem 0x100000000-0x7ffffffff] page 1G
 [mem 0x800000000-0x82fffffff] page 2M
kernel direct mapping tables up to 0x82fffffff @ [mem 0xcd7fe000-0xcd7fffff]
ACPI: RSDP 00000000000f0450 00024 (v02 ALASKA)
ACPI: XSDT 00000000cce92070 00064 (v01 ALASKA    A M I 01072009 AMI  00010013)
ACPI: FACP 00000000cce9a0c8 000F4 (v04 ALASKA    A M I 01072009 AMI  00010013)
ACPI: DSDT 00000000cce92168 07F5F (v02 ALASKA    A M I 00000000 INTL 20051117)
ACPI: FACS 00000000ccf5af80 00040
ACPI: APIC 00000000cce9a1c0 000B2 (v03 ALASKA    A M I 01072009 AMI  00010013)
ACPI: MCFG 00000000cce9a278 0003C (v01 ALASKA OEMMCFG. 01072009 MSFT 00000097)
ACPI: HPET 00000000cce9a2b8 00038 (v01 ALASKA    A M I 01072009 AMI. 00000004)
ACPI: SSDT 00000000cce9a2f0 6F0C4 (v02  INTEL    CpuPm 00004000 INTL 20051117)
ACPI: MATS 00000000ccf093b8 00034 (v01 ALASKA    A M I 00000001 w?x2 00000000)
ACPI: DMAR 00000000ccf093f0 000C4 (v01 A M I   OEMDMAR 00000001 INTL 00000001)
ACPI: MATS 00000000ccf094b8 00034 (v02 ALASKA    A M I 00000002 w?x2 00000000)
ACPI: Local APIC address 0xfee00000
 [ffffea0000000000-ffffea0020bfffff] PMD -> [ffff88080f600000-ffff88082f5fffff] on node 0
Zone ranges:
  DMA      [mem 0x00010000-0x00ffffff]
  DMA32    [mem 0x01000000-0xffffffff]
  Normal   [mem 0x100000000-0x82fffffff]
Movable zone start for each node
Early memory node ranges
  node   0: [mem 0x00010000-0x0009dfff]
  node   0: [mem 0x00100000-0xcca50fff]
  node   0: [mem 0xcd18b000-0xcd47dfff]
  node   0: [mem 0xcd7db000-0xcd7fffff]
  node   0: [mem 0x100000000-0x82fffffff]
On node 0 totalpages: 8375543
  DMA zone: 64 pages used for memmap
  DMA zone: 6 pages reserved
  DMA zone: 3912 pages, LIFO batch:0
  DMA32 zone: 16320 pages used for memmap
  DMA32 zone: 818601 pages, LIFO batch:31
  Normal zone: 117760 pages used for memmap
  Normal zone: 7418880 pages, LIFO batch:31
ACPI: PM-Timer IO Port: 0x408
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x02] enabled)
ACPI: LAPIC (acpi_id[0x04] lapic_id[0x04] enabled)
ACPI: LAPIC (acpi_id[0x06] lapic_id[0x06] enabled)
ACPI: LAPIC (acpi_id[0x08] lapic_id[0x08] enabled)
ACPI: LAPIC (acpi_id[0x0a] lapic_id[0x0a] enabled)
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
ACPI: LAPIC (acpi_id[0x03] lapic_id[0x03] enabled)
ACPI: LAPIC (acpi_id[0x05] lapic_id[0x05] enabled)
ACPI: LAPIC (acpi_id[0x07] lapic_id[0x07] enabled)
ACPI: LAPIC (acpi_id[0x09] lapic_id[0x09] enabled)
ACPI: LAPIC (acpi_id[0x0b] lapic_id[0x0b] enabled)
ACPI: LAPIC_NMI (acpi_id[0xff] high edge lint[0x1])
ACPI: IOAPIC (id[0x00] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 0, version 32, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Using ACPI (MADT) for SMP configuration information
ACPI: HPET id: 0x8086a701 base: 0xfed00000
SMP: Allowing 12 CPUs, 0 hotplug CPUs
nr_irqs_gsi: 40
e820: [mem 0xcd800000-0xdfffffff] available for PCI devices
setup_percpu: NR_CPUS:16 nr_cpumask_bits:16 nr_cpu_ids:12 nr_node_ids:1
PERCPU: Embedded 25 pages/cpu @ffff88082fc00000 s72000 r8192 d22208 u131072
pcpu-alloc: s72000 r8192 d22208 u131072 alloc=1*2097152
pcpu-alloc: [0] 00 01 02 03 04 05 06 07 08 09 10 11 -- -- -- -- 
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 8241393
Kernel command line: BOOT_IMAGE=Linux357 ro root=901 vt.default_utf8=0
PID hash table entries: 4096 (order: 3, 32768 bytes)
Dentry cache hash table entries: 4194304 (order: 13, 33554432 bytes)
Inode-cache hash table entries: 2097152 (order: 12, 16777216 bytes)
__ex_table already sorted, skipping sort
xsave/xrstor: enabled xstate_bv 0x7, cntxt size 0x340
Checking aperture...
No AGP bridge found
Memory: 32850436k/34340864k available (6771k kernel code, 838692k absent, 651736k reserved, 2907k data, 500k init)
SLUB: Genslabs=15, HWalign=64, Order=0-3, MinObjects=0, CPUs=12, Nodes=1
Hierarchical RCU implementation.
	RCU dyntick-idle grace-period acceleration is enabled.
NR_IRQS:4352 nr_irqs:776 16
Extended CMOS year: 2000
Console: colour VGA+ 80x25
console [tty0] enabled
hpet clockevent registered
Fast TSC calibration using PIT
Detected 3199.851 MHz processor.
Calibrating delay loop (skipped), value calculated using timer frequency.. 6402.35 BogoMIPS (lpj=10666170)
pid_max: default: 32768 minimum: 301
Mount-cache hash table entries: 256
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 0
mce: CPU supports 18 MCE banks
CPU0: Thermal monitoring enabled (TM1)
using mwait in idle threads.
ACPI: Core revision 20120320
Switched APIC routing to physical flat.
..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
CPU0: Intel(R) Core(TM) i7-3930K CPU @ 3.20GHz stepping 07
Performance Events: PEBS fmt1+, 16-deep LBR, SandyBridge events, Intel PMU driver.
PEBS disabled due to CPU errata.
... version:                3
... bit width:              48
... generic registers:      4
... value mask:             0000ffffffffffff
... max period:             000000007fffffff
... fixed-purpose events:   3
... event mask:             000000070000000f
Booting Node   0, Processors  #1 #2 #3 #4 #5 #6 #7 #8 #9 #10 #11 Ok.
Brought up 12 CPUs
Total of 12 processors activated (76827.27 BogoMIPS).
devtmpfs: initialized
PM: Registering ACPI NVS region [mem 0xcca51000-0xccb6afff] (1155072 bytes)
PM: Registering ACPI NVS region [mem 0xccf2d000-0xccf31fff] (20480 bytes)
PM: Registering ACPI NVS region [mem 0xccf51000-0xccf51fff] (4096 bytes)
PM: Registering ACPI NVS region [mem 0xccf55000-0xccf5cfff] (32768 bytes)
PM: Registering ACPI NVS region [mem 0xccf88000-0xcd18afff] (2109440 bytes)
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xe0000000-0xefffffff] (base 0xe0000000)
PCI: MMCONFIG at [mem 0xe0000000-0xefffffff] reserved in E820
PCI: Using configuration type 1 for base access
bio: create slab <bio-0> at 0
ACPI: Added _OSI(Module Device)
ACPI: Added _OSI(Processor Device)
ACPI: Added _OSI(3.0 _SCP Extensions)
ACPI: Added _OSI(Processor Aggregator Device)
ACPI: EC: Look up EC in DSDT
ACPI: Executed 1 blocks of module-level executable AML code
ACPI: Interpreter enabled
ACPI: (supports S0 S1 S3 S5)
ACPI: Using IOAPIC for interrupt routing
ACPI: No dock devices found.
PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-fe])
pci_root PNP0A08:00: host bridge window [io  0x0000-0x03af]
pci_root PNP0A08:00: host bridge window [io  0x03e0-0x0cf7]
pci_root PNP0A08:00: host bridge window [io  0x03b0-0x03df]
pci_root PNP0A08:00: host bridge window [io  0x0d00-0xffff]
pci_root PNP0A08:00: host bridge window [mem 0x000a0000-0x000bffff]
pci_root PNP0A08:00: host bridge window [mem 0x000c0000-0x000dffff]
pci_root PNP0A08:00: host bridge window [mem 0xd0000000-0xfbffffff]
PCI host bridge to bus 0000:00
pci_bus 0000:00: root bus resource [io  0x0000-0x03af]
pci_bus 0000:00: root bus resource [io  0x03e0-0x0cf7]
pci_bus 0000:00: root bus resource [io  0x03b0-0x03df]
pci_bus 0000:00: root bus resource [io  0x0d00-0xffff]
pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff]
pci_bus 0000:00: root bus resource [mem 0x000c0000-0x000dffff]
pci_bus 0000:00: root bus resource [mem 0xd0000000-0xfbffffff]
pci 0000:00:00.0: [8086:3c00] type 00 class 0x060000
pci 0000:00:00.0: PME# supported from D0 D3hot D3cold
pci 0000:00:01.0: [8086:3c02] type 01 class 0x060400
pci 0000:00:01.0: PME# supported from D0 D3hot D3cold
pci 0000:00:02.0: [8086:3c04] type 01 class 0x060400
pci 0000:00:02.0: PME# supported from D0 D3hot D3cold
pci 0000:00:03.0: [8086:3c08] type 01 class 0x060400
pci 0000:00:03.0: PME# supported from D0 D3hot D3cold
pci 0000:00:04.0: [8086:3c20] type 00 class 0x088000
pci 0000:00:04.0: reg 10: [mem 0xfb740000-0xfb743fff 64bit]
pci 0000:00:04.1: [8086:3c21] type 00 class 0x088000
pci 0000:00:04.1: reg 10: [mem 0xfb73c000-0xfb73ffff 64bit]
pci 0000:00:04.2: [8086:3c22] type 00 class 0x088000
pci 0000:00:04.2: reg 10: [mem 0xfb738000-0xfb73bfff 64bit]
pci 0000:00:04.3: [8086:3c23] type 00 class 0x088000
pci 0000:00:04.3: reg 10: [mem 0xfb734000-0xfb737fff 64bit]
pci 0000:00:04.4: [8086:3c24] type 00 class 0x088000
pci 0000:00:04.4: reg 10: [mem 0xfb730000-0xfb733fff 64bit]
pci 0000:00:04.5: [8086:3c25] type 00 class 0x088000
pci 0000:00:04.5: reg 10: [mem 0xfb72c000-0xfb72ffff 64bit]
pci 0000:00:04.6: [8086:3c26] type 00 class 0x088000
pci 0000:00:04.6: reg 10: [mem 0xfb728000-0xfb72bfff 64bit]
pci 0000:00:04.7: [8086:3c27] type 00 class 0x088000
pci 0000:00:04.7: reg 10: [mem 0xfb724000-0xfb727fff 64bit]
pci 0000:00:05.0: [8086:3c28] type 00 class 0x088000
pci 0000:00:05.2: [8086:3c2a] type 00 class 0x088000
pci 0000:00:05.4: [8086:3c2c] type 00 class 0x080020
pci 0000:00:05.4: reg 10: [mem 0xfb74a000-0xfb74afff]
pci 0000:00:11.0: [8086:1d3e] type 01 class 0x060400
pci 0000:00:11.0: PME# supported from D0 D3hot D3cold
pci 0000:00:16.0: [8086:1d3a] type 00 class 0x078000
pci 0000:00:16.0: reg 10: [mem 0xfb749000-0xfb74900f 64bit]
pci 0000:00:16.0: PME# supported from D0 D3hot D3cold
pci 0000:00:19.0: [8086:1503] type 00 class 0x020000
pci 0000:00:19.0: reg 10: [mem 0xfb700000-0xfb71ffff]
pci 0000:00:19.0: reg 14: [mem 0xfb748000-0xfb748fff]
pci 0000:00:19.0: reg 18: [io  0xf040-0xf05f]
pci 0000:00:19.0: PME# supported from D0 D3hot D3cold
pci 0000:00:1a.0: [8086:1d2d] type 00 class 0x0c0320
pci 0000:00:1a.0: reg 10: [mem 0xfb747000-0xfb7473ff]
pci 0000:00:1a.0: PME# supported from D0 D3hot D3cold
pci 0000:00:1b.0: [8086:1d20] type 00 class 0x040300
pci 0000:00:1b.0: reg 10: [mem 0xfb720000-0xfb723fff 64bit]
pci 0000:00:1b.0: PME# supported from D0 D3hot D3cold
pci 0000:00:1c.0: [8086:1d10] type 01 class 0x060400
pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
pci 0000:00:1c.1: [8086:1d12] type 01 class 0x060400
pci 0000:00:1c.1: PME# supported from D0 D3hot D3cold
pci 0000:00:1c.2: [8086:1d14] type 01 class 0x060400
pci 0000:00:1c.2: PME# supported from D0 D3hot D3cold
pci 0000:00:1c.3: [8086:1d16] type 01 class 0x060400
pci 0000:00:1c.3: PME# supported from D0 D3hot D3cold
pci 0000:00:1c.5: [8086:1d1a] type 01 class 0x060400
pci 0000:00:1c.5: PME# supported from D0 D3hot D3cold
pci 0000:00:1c.6: [8086:1d1c] type 01 class 0x060400
pci 0000:00:1c.6: PME# supported from D0 D3hot D3cold
pci 0000:00:1c.7: [8086:1d1e] type 01 class 0x060400
pci 0000:00:1c.7: PME# supported from D0 D3hot D3cold
pci 0000:00:1d.0: [8086:1d26] type 00 class 0x0c0320
pci 0000:00:1d.0: reg 10: [mem 0xfb746000-0xfb7463ff]
pci 0000:00:1d.0: PME# supported from D0 D3hot D3cold
pci 0000:00:1e.0: [8086:244e] type 01 class 0x060401
pci 0000:00:1f.0: [8086:1d41] type 00 class 0x060100
pci 0000:00:1f.2: [8086:1d02] type 00 class 0x010601
pci 0000:00:1f.2: reg 10: [io  0xf090-0xf097]
pci 0000:00:1f.2: reg 14: [io  0xf080-0xf083]
pci 0000:00:1f.2: reg 18: [io  0xf070-0xf077]
pci 0000:00:1f.2: reg 1c: [io  0xf060-0xf063]
pci 0000:00:1f.2: reg 20: [io  0xf020-0xf03f]
pci 0000:00:1f.2: reg 24: [mem 0xfb745000-0xfb7457ff]
pci 0000:00:1f.2: PME# supported from D3hot
pci 0000:00:1f.3: [8086:1d22] type 00 class 0x0c0500
pci 0000:00:1f.3: reg 10: [mem 0xfb744000-0xfb7440ff 64bit]
pci 0000:00:1f.3: reg 20: [io  0xf000-0xf01f]
pci 0000:01:00.0: [10de:0640] type 00 class 0x030000
pci 0000:01:00.0: reg 10: [mem 0xfa000000-0xfaffffff]
pci 0000:01:00.0: reg 14: [mem 0xd0000000-0xdfffffff 64bit pref]
pci 0000:01:00.0: reg 1c: [mem 0xf8000000-0xf9ffffff 64bit]
pci 0000:01:00.0: reg 24: [io  0xe000-0xe07f]
pci 0000:01:00.0: reg 30: [mem 0xfb000000-0xfb07ffff pref]
pci 0000:00:01.0: PCI bridge to [bus 01-01]
pci 0000:00:01.0:   bridge window [io  0xe000-0xefff]
pci 0000:00:01.0:   bridge window [mem 0xf8000000-0xfb0fffff]
pci 0000:00:01.0:   bridge window [mem 0xd0000000-0xdfffffff 64bit pref]
pci 0000:00:02.0: PCI bridge to [bus 02-02]
pci 0000:00:03.0: PCI bridge to [bus 03-03]
pci 0000:00:11.0: PCI bridge to [bus 04-04]
pci 0000:05:00.0: [1b4b:9172] type 00 class 0x010601
pci 0000:05:00.0: reg 10: [io  0xd040-0xd047]
pci 0000:05:00.0: reg 14: [io  0xd030-0xd033]
pci 0000:05:00.0: reg 18: [io  0xd020-0xd027]
pci 0000:05:00.0: reg 1c: [io  0xd010-0xd013]
pci 0000:05:00.0: reg 20: [io  0xd000-0xd00f]
pci 0000:05:00.0: reg 24: [mem 0xfb610000-0xfb6101ff]
pci 0000:05:00.0: reg 30: [mem 0xfb600000-0xfb60ffff pref]
pci 0000:05:00.0: PME# supported from D3hot
pci 0000:00:1c.0: PCI bridge to [bus 05-05]
pci 0000:00:1c.0:   bridge window [io  0xd000-0xdfff]
pci 0000:00:1c.0:   bridge window [mem 0xfb600000-0xfb6fffff]
pci 0000:06:00.0: [1b4b:9172] type 00 class 0x010601
pci 0000:06:00.0: reg 10: [io  0xc040-0xc047]
pci 0000:06:00.0: reg 14: [io  0xc030-0xc033]
pci 0000:06:00.0: reg 18: [io  0xc020-0xc027]
pci 0000:06:00.0: reg 1c: [io  0xc010-0xc013]
pci 0000:06:00.0: reg 20: [io  0xc000-0xc00f]
pci 0000:06:00.0: reg 24: [mem 0xfb510000-0xfb5101ff]
pci 0000:06:00.0: reg 30: [mem 0xfb500000-0xfb50ffff pref]
pci 0000:06:00.0: PME# supported from D3hot
pci 0000:00:1c.1: PCI bridge to [bus 06-06]
pci 0000:00:1c.1:   bridge window [io  0xc000-0xcfff]
pci 0000:00:1c.1:   bridge window [mem 0xfb500000-0xfb5fffff]
pci 0000:00:1c.2: PCI bridge to [bus 07-07]
pci 0000:00:1c.3: PCI bridge to [bus 08-08]
pci 0000:09:00.0: [1b73:1009] type 00 class 0x0c0330
pci 0000:09:00.0: reg 10: [mem 0xfb400000-0xfb40ffff 64bit]
pci 0000:09:00.0: reg 18: [mem 0xfb411000-0xfb411fff 64bit]
pci 0000:09:00.0: reg 20: [mem 0xfb410000-0xfb410fff 64bit]
pci 0000:09:00.0: supports D1
pci 0000:09:00.0: PME# supported from D0 D1 D3hot D3cold
pci 0000:00:1c.5: PCI bridge to [bus 09-09]
pci 0000:00:1c.5:   bridge window [mem 0xfb400000-0xfb4fffff]
pci 0000:0a:00.0: [1b73:1009] type 00 class 0x0c0330
pci 0000:0a:00.0: reg 10: [mem 0xfb300000-0xfb30ffff 64bit]
pci 0000:0a:00.0: reg 18: [mem 0xfb311000-0xfb311fff 64bit]
pci 0000:0a:00.0: reg 20: [mem 0xfb310000-0xfb310fff 64bit]
pci 0000:0a:00.0: supports D1
pci 0000:0a:00.0: PME# supported from D0 D1 D3hot D3cold
pci 0000:00:1c.6: PCI bridge to [bus 0a-0a]
pci 0000:00:1c.6:   bridge window [mem 0xfb300000-0xfb3fffff]
pci 0000:0b:00.0: [1b4b:9172] type 00 class 0x010601
pci 0000:0b:00.0: reg 10: [io  0xb040-0xb047]
pci 0000:0b:00.0: reg 14: [io  0xb030-0xb033]
pci 0000:0b:00.0: reg 18: [io  0xb020-0xb027]
pci 0000:0b:00.0: reg 1c: [io  0xb010-0xb013]
pci 0000:0b:00.0: reg 20: [io  0xb000-0xb00f]
pci 0000:0b:00.0: reg 24: [mem 0xfb210000-0xfb2101ff]
pci 0000:0b:00.0: reg 30: [mem 0xfb200000-0xfb20ffff pref]
pci 0000:0b:00.0: PME# supported from D3hot
pci 0000:00:1c.7: PCI bridge to [bus 0b-0b]
pci 0000:00:1c.7:   bridge window [io  0xb000-0xbfff]
pci 0000:00:1c.7:   bridge window [mem 0xfb200000-0xfb2fffff]
pci 0000:0c:03.0: [1106:3044] type 00 class 0x0c0010
pci 0000:0c:03.0: reg 10: [mem 0xfb100000-0xfb1007ff]
pci 0000:0c:03.0: reg 14: [io  0xa000-0xa07f]
pci 0000:0c:03.0: supports D2
pci 0000:0c:03.0: PME# supported from D2 D3hot D3cold
pci 0000:00:1e.0: PCI bridge to [bus 0c-0c] (subtractive decode)
pci 0000:00:1e.0:   bridge window [io  0xa000-0xafff]
pci 0000:00:1e.0:   bridge window [mem 0xfb100000-0xfb1fffff]
pci 0000:00:1e.0:   bridge window [io  0x0000-0x03af] (subtractive decode)
pci 0000:00:1e.0:   bridge window [io  0x03e0-0x0cf7] (subtractive decode)
pci 0000:00:1e.0:   bridge window [io  0x03b0-0x03df] (subtractive decode)
pci 0000:00:1e.0:   bridge window [io  0x0d00-0xffff] (subtractive decode)
pci 0000:00:1e.0:   bridge window [mem 0x000a0000-0x000bffff] (subtractive decode)
pci 0000:00:1e.0:   bridge window [mem 0x000c0000-0x000dffff] (subtractive decode)
pci 0000:00:1e.0:   bridge window [mem 0xd0000000-0xfbffffff] (subtractive decode)
pci_bus 0000:00: on NUMA node 0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.BR20._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEX0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEX1._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEX2._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEX3._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEX5._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEX6._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEX7._PRT]
 pci0000:00: Requesting ACPI _OSC control (0x1d)
 pci0000:00: ACPI _OSC control (0x15) granted
ACPI: PCI Root Bridge [UNC0] (domain 0000 [bus ff])
PCI host bridge to bus 0000:ff
pci 0000:ff:08.0: [8086:3c80] type 00 class 0x088000
pci 0000:ff:08.3: [8086:3c83] type 00 class 0x088000
pci 0000:ff:08.4: [8086:3c84] type 00 class 0x088000
pci 0000:ff:09.0: [8086:3c90] type 00 class 0x088000
pci 0000:ff:09.3: [8086:3c93] type 00 class 0x088000
pci 0000:ff:09.4: [8086:3c94] type 00 class 0x088000
pci 0000:ff:0a.0: [8086:3cc0] type 00 class 0x088000
pci 0000:ff:0a.1: [8086:3cc1] type 00 class 0x088000
pci 0000:ff:0a.2: [8086:3cc2] type 00 class 0x088000
pci 0000:ff:0a.3: [8086:3cd0] type 00 class 0x088000
pci 0000:ff:0b.0: [8086:3ce0] type 00 class 0x088000
pci 0000:ff:0b.3: [8086:3ce3] type 00 class 0x088000
pci 0000:ff:0c.0: [8086:3ce8] type 00 class 0x088000
pci 0000:ff:0c.1: [8086:3ce8] type 00 class 0x088000
pci 0000:ff:0c.2: [8086:3ce8] type 00 class 0x088000
pci 0000:ff:0c.6: [8086:3cf4] type 00 class 0x088000
pci 0000:ff:0c.7: [8086:3cf6] type 00 class 0x088000
pci 0000:ff:0d.0: [8086:3ce8] type 00 class 0x088000
pci 0000:ff:0d.1: [8086:3ce8] type 00 class 0x088000
pci 0000:ff:0d.2: [8086:3ce8] type 00 class 0x088000
pci 0000:ff:0d.6: [8086:3cf5] type 00 class 0x088000
pci 0000:ff:0e.0: [8086:3ca0] type 00 class 0x088000
pci 0000:ff:0e.1: [8086:3c46] type 00 class 0x110100
pci 0000:ff:0f.0: [8086:3ca8] type 00 class 0x088000
pci 0000:ff:0f.1: [8086:3c71] type 00 class 0x088000
pci 0000:ff:0f.2: [8086:3caa] type 00 class 0x088000
pci 0000:ff:0f.3: [8086:3cab] type 00 class 0x088000
pci 0000:ff:0f.4: [8086:3cac] type 00 class 0x088000
pci 0000:ff:0f.5: [8086:3cad] type 00 class 0x088000
pci 0000:ff:0f.6: [8086:3cae] type 00 class 0x088000
pci 0000:ff:10.0: [8086:3cb0] type 00 class 0x088000
pci 0000:ff:10.1: [8086:3cb1] type 00 class 0x088000
pci 0000:ff:10.2: [8086:3cb2] type 00 class 0x088000
pci 0000:ff:10.3: [8086:3cb3] type 00 class 0x088000
pci 0000:ff:10.4: [8086:3cb4] type 00 class 0x088000
pci 0000:ff:10.5: [8086:3cb5] type 00 class 0x088000
pci 0000:ff:10.6: [8086:3cb6] type 00 class 0x088000
pci 0000:ff:10.7: [8086:3cb7] type 00 class 0x088000
pci 0000:ff:11.0: [8086:3cb8] type 00 class 0x088000
pci 0000:ff:13.0: [8086:3ce4] type 00 class 0x088000
pci 0000:ff:13.1: [8086:3c43] type 00 class 0x110100
pci 0000:ff:13.4: [8086:3ce6] type 00 class 0x110100
pci 0000:ff:13.5: [8086:3c44] type 00 class 0x110100
pci 0000:ff:13.6: [8086:3c45] type 00 class 0x088000
pci_bus 0000:ff: on NUMA node 0
 pci0000:ff: Requesting ACPI _OSC control (0x1d)
 pci0000:ff: ACPI _OSC request failed (AE_NOT_FOUND), returned control mask: 0x1d
ACPI _OSC control for PCIe not granted, disabling ASPM
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs *3 4 5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 *4 5 6 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 10 11 12 14 15) *0
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 *7 10 11 12 14 15)
vgaarb: device added: PCI:0000:01:00.0,decodes=io+mem,owns=io+mem,locks=none
vgaarb: loaded
vgaarb: bridge control possible 0000:01:00.0
SCSI subsystem initialized
libata version 3.00 loaded.
ACPI: bus type usb registered
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
Linux video capture interface: v2.00
Advanced Linux Sound Architecture Driver Version 1.0.25.
PCI: Using ACPI for IRQ routing
PCI: pci_cache_line_size set to 64 bytes
e820: reserve RAM buffer [mem 0x0009e800-0x0009ffff]
e820: reserve RAM buffer [mem 0xcca51000-0xcfffffff]
e820: reserve RAM buffer [mem 0xcd47e000-0xcfffffff]
e820: reserve RAM buffer [mem 0xcd800000-0xcfffffff]
hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0, 0, 0, 0, 0
hpet0: 8 comparators, 64-bit 14.318180 MHz counter
Switching to clocksource hpet
pnp: PnP ACPI init
ACPI: bus type pnp registered
pnp 00:00: [bus 00-fe]
pnp 00:00: [io  0x0cf8-0x0cff]
pnp 00:00: [io  0x0000-0x03af window]
pnp 00:00: [io  0x03e0-0x0cf7 window]
pnp 00:00: [io  0x03b0-0x03df window]
pnp 00:00: [io  0x0d00-0xffff window]
pnp 00:00: [mem 0x000a0000-0x000bffff window]
pnp 00:00: [mem 0x000c0000-0x000dffff window]
pnp 00:00: [mem 0xd0000000-0xfbffffff window]
pnp 00:00: [mem 0x00000000 window]
pnp 00:00: Plug and Play ACPI device, IDs PNP0a08 PNP0a03 (active)
pnp 00:01: [mem 0xfc000000-0xfcffffff]
pnp 00:01: [mem 0xfd000000-0xfdffffff]
pnp 00:01: [mem 0xfe000000-0xfeafffff]
pnp 00:01: [mem 0xfeb00000-0xfebfffff]
pnp 00:01: [mem 0xfed00400-0xfed3ffff]
pnp 00:01: [mem 0xfed45000-0xfedfffff]
system 00:01: [mem 0xfc000000-0xfcffffff] has been reserved
system 00:01: [mem 0xfd000000-0xfdffffff] has been reserved
system 00:01: [mem 0xfe000000-0xfeafffff] has been reserved
system 00:01: [mem 0xfeb00000-0xfebfffff] has been reserved
system 00:01: [mem 0xfed00400-0xfed3ffff] could not be reserved
system 00:01: [mem 0xfed45000-0xfedfffff] has been reserved
system 00:01: Plug and Play ACPI device, IDs PNP0c01 (active)
pnp 00:02: [io  0x0000-0xffffffffffffffff disabled]
pnp 00:02: [io  0x0a00-0x0a0f]
pnp 00:02: [io  0x0a30-0x0a3f]
pnp 00:02: [io  0x0a20-0x0a2f]
system 00:02: [io  0x0a00-0x0a0f] has been reserved
system 00:02: [io  0x0a30-0x0a3f] has been reserved
system 00:02: [io  0x0a20-0x0a2f] has been reserved
system 00:02: Plug and Play ACPI device, IDs PNP0c02 (active)
pnp 00:03: [io  0x0060]
pnp 00:03: [io  0x0064]
pnp 00:03: [irq 1]
pnp 00:03: Plug and Play ACPI device, IDs PNP0303 PNP030b (active)
pnp 00:04: [dma 4]
pnp 00:04: [io  0x0000-0x000f]
pnp 00:04: [io  0x0081-0x0083]
pnp 00:04: [io  0x0087]
pnp 00:04: [io  0x0089-0x008b]
pnp 00:04: [io  0x008f]
pnp 00:04: [io  0x00c0-0x00df]
pnp 00:04: Plug and Play ACPI device, IDs PNP0200 (active)
pnp 00:05: [io  0x0070-0x0071]
pnp 00:05: [irq 8]
pnp 00:05: Plug and Play ACPI device, IDs PNP0b00 (active)
pnp 00:06: [io  0x0061]
pnp 00:06: Plug and Play ACPI device, IDs PNP0800 (active)
pnp 00:07: [io  0x0010-0x001f]
pnp 00:07: [io  0x0022-0x003f]
pnp 00:07: [io  0x0044-0x005f]
pnp 00:07: [io  0x0062-0x0063]
pnp 00:07: [io  0x0065-0x006f]
pnp 00:07: [io  0x0072-0x007f]
pnp 00:07: [io  0x0080]
pnp 00:07: [io  0x0084-0x0086]
pnp 00:07: [io  0x0088]
pnp 00:07: [io  0x008c-0x008e]
pnp 00:07: [io  0x0090-0x009f]
pnp 00:07: [io  0x00a2-0x00bf]
pnp 00:07: [io  0x00e0-0x00ef]
pnp 00:07: [io  0x04d0-0x04d1]
system 00:07: [io  0x04d0-0x04d1] has been reserved
system 00:07: Plug and Play ACPI device, IDs PNP0c02 (active)
pnp 00:08: [io  0x00f0-0x00ff]
pnp 00:08: [irq 13]
pnp 00:08: Plug and Play ACPI device, IDs PNP0c04 (active)
pnp 00:09: [io  0x0400-0x0453]
pnp 00:09: [io  0x0458-0x047f]
pnp 00:09: [io  0x1180-0x119f]
pnp 00:09: [io  0x0500-0x057f]
pnp 00:09: [mem 0xfed1c000-0xfed1ffff]
pnp 00:09: [mem 0xfec00000-0xfecfffff]
pnp 00:09: [mem 0xfed08000-0xfed08fff]
pnp 00:09: [mem 0xff000000-0xffffffff]
system 00:09: [io  0x0400-0x0453] has been reserved
system 00:09: [io  0x0458-0x047f] has been reserved
system 00:09: [io  0x1180-0x119f] has been reserved
system 00:09: [io  0x0500-0x057f] has been reserved
system 00:09: [mem 0xfed1c000-0xfed1ffff] has been reserved
system 00:09: [mem 0xfec00000-0xfecfffff] could not be reserved
system 00:09: [mem 0xfed08000-0xfed08fff] has been reserved
system 00:09: [mem 0xff000000-0xffffffff] has been reserved
system 00:09: Plug and Play ACPI device, IDs PNP0c01 (active)
pnp 00:0a: [io  0x0454-0x0457]
system 00:0a: [io  0x0454-0x0457] has been reserved
system 00:0a: Plug and Play ACPI device, IDs INT3f0d PNP0c02 (active)
pnp 00:0b: [mem 0xfed00000-0xfed003ff]
pnp 00:0b: Plug and Play ACPI device, IDs PNP0103 (active)
pnp 00:0c: [bus ff]
pnp 00:0c: Plug and Play ACPI device, IDs PNP0a03 (active)
pnp: PnP ACPI: found 13 devices
ACPI: ACPI bus type pnp unregistered
pci 0000:00:01.0: PCI bridge to [bus 01-01]
pci 0000:00:01.0:   bridge window [io  0xe000-0xefff]
pci 0000:00:01.0:   bridge window [mem 0xf8000000-0xfb0fffff]
pci 0000:00:01.0:   bridge window [mem 0xd0000000-0xdfffffff 64bit pref]
pci 0000:00:02.0: PCI bridge to [bus 02-02]
pci 0000:00:03.0: PCI bridge to [bus 03-03]
pci 0000:00:11.0: PCI bridge to [bus 04-04]
pci 0000:00:1c.0: PCI bridge to [bus 05-05]
pci 0000:00:1c.0:   bridge window [io  0xd000-0xdfff]
pci 0000:00:1c.0:   bridge window [mem 0xfb600000-0xfb6fffff]
pci 0000:00:1c.1: PCI bridge to [bus 06-06]
pci 0000:00:1c.1:   bridge window [io  0xc000-0xcfff]
pci 0000:00:1c.1:   bridge window [mem 0xfb500000-0xfb5fffff]
pci 0000:00:1c.2: PCI bridge to [bus 07-07]
pci 0000:00:1c.3: PCI bridge to [bus 08-08]
pci 0000:00:1c.5: PCI bridge to [bus 09-09]
pci 0000:00:1c.5:   bridge window [mem 0xfb400000-0xfb4fffff]
pci 0000:00:1c.6: PCI bridge to [bus 0a-0a]
pci 0000:00:1c.6:   bridge window [mem 0xfb300000-0xfb3fffff]
pci 0000:00:1c.7: PCI bridge to [bus 0b-0b]
pci 0000:00:1c.7:   bridge window [io  0xb000-0xbfff]
pci 0000:00:1c.7:   bridge window [mem 0xfb200000-0xfb2fffff]
pci 0000:00:1e.0: PCI bridge to [bus 0c-0c]
pci 0000:00:1e.0:   bridge window [io  0xa000-0xafff]
pci 0000:00:1e.0:   bridge window [mem 0xfb100000-0xfb1fffff]
pci 0000:00:1e.0: setting latency timer to 64
pci_bus 0000:00: resource 4 [io  0x0000-0x03af]
pci_bus 0000:00: resource 5 [io  0x03e0-0x0cf7]
pci_bus 0000:00: resource 6 [io  0x03b0-0x03df]
pci_bus 0000:00: resource 7 [io  0x0d00-0xffff]
pci_bus 0000:00: resource 8 [mem 0x000a0000-0x000bffff]
pci_bus 0000:00: resource 9 [mem 0x000c0000-0x000dffff]
pci_bus 0000:00: resource 10 [mem 0xd0000000-0xfbffffff]
pci_bus 0000:01: resource 0 [io  0xe000-0xefff]
pci_bus 0000:01: resource 1 [mem 0xf8000000-0xfb0fffff]
pci_bus 0000:01: resource 2 [mem 0xd0000000-0xdfffffff 64bit pref]
pci_bus 0000:05: resource 0 [io  0xd000-0xdfff]
pci_bus 0000:05: resource 1 [mem 0xfb600000-0xfb6fffff]
pci_bus 0000:06: resource 0 [io  0xc000-0xcfff]
pci_bus 0000:06: resource 1 [mem 0xfb500000-0xfb5fffff]
pci_bus 0000:09: resource 1 [mem 0xfb400000-0xfb4fffff]
pci_bus 0000:0a: resource 1 [mem 0xfb300000-0xfb3fffff]
pci_bus 0000:0b: resource 0 [io  0xb000-0xbfff]
pci_bus 0000:0b: resource 1 [mem 0xfb200000-0xfb2fffff]
pci_bus 0000:0c: resource 0 [io  0xa000-0xafff]
pci_bus 0000:0c: resource 1 [mem 0xfb100000-0xfb1fffff]
pci_bus 0000:0c: resource 4 [io  0x0000-0x03af]
pci_bus 0000:0c: resource 5 [io  0x03e0-0x0cf7]
pci_bus 0000:0c: resource 6 [io  0x03b0-0x03df]
pci_bus 0000:0c: resource 7 [io  0x0d00-0xffff]
pci_bus 0000:0c: resource 8 [mem 0x000a0000-0x000bffff]
pci_bus 0000:0c: resource 9 [mem 0x000c0000-0x000dffff]
pci_bus 0000:0c: resource 10 [mem 0xd0000000-0xfbffffff]
NET: Registered protocol family 2
IP route cache hash table entries: 524288 (order: 10, 4194304 bytes)
TCP established hash table entries: 262144 (order: 10, 4194304 bytes)
TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
TCP: Hash tables configured (established 262144 bind 65536)
TCP: reno registered
UDP hash table entries: 16384 (order: 7, 524288 bytes)
UDP-Lite hash table entries: 16384 (order: 7, 524288 bytes)
NET: Registered protocol family 1
RPC: Registered named UNIX socket transport module.
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
RPC: Registered tcp NFSv4.1 backchannel transport module.
pci 0000:01:00.0: Boot video device
PCI: CLS 64 bytes, default 64
PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
software IO TLB [mem 0xc8a51000-0xcca50fff] (64MB) mapped at [ffff8800c8a51000-ffff8800cca50fff]
microcode: CPU0 sig=0x206d7, pf=0x4, revision=0x70a
microcode: CPU1 sig=0x206d7, pf=0x4, revision=0x70a
microcode: CPU2 sig=0x206d7, pf=0x4, revision=0x70a
microcode: CPU3 sig=0x206d7, pf=0x4, revision=0x70a
microcode: CPU4 sig=0x206d7, pf=0x4, revision=0x70a
microcode: CPU5 sig=0x206d7, pf=0x4, revision=0x70a
microcode: CPU6 sig=0x206d7, pf=0x4, revision=0x70a
microcode: CPU7 sig=0x206d7, pf=0x4, revision=0x70a
microcode: CPU8 sig=0x206d7, pf=0x4, revision=0x70a
microcode: CPU9 sig=0x206d7, pf=0x4, revision=0x70a
microcode: CPU10 sig=0x206d7, pf=0x4, revision=0x70a
microcode: CPU11 sig=0x206d7, pf=0x4, revision=0x70a
microcode: Microcode Update Driver: v2.00 <tigran@aivazian.fsnet.co.uk>, Peter Oruba
sha1_ssse3: Using AVX optimized SHA-1 implementation
NFS: Registering the id_resolver key type
Key type id_resolver registered
Key type id_legacy registered
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
NTFS driver 2.1.30 [Flags: R/O].
fuse init (API version 7.19)
msgmni has been set to 32768
Block layer SCSI generic (bsg) driver version 0.4 loaded (major 253)
io scheduler noop registered
io scheduler deadline registered
io scheduler cfq registered (default)
pcieport 0000:00:01.0: irq 40 for MSI/MSI-X
pcieport 0000:00:02.0: irq 41 for MSI/MSI-X
pcieport 0000:00:03.0: irq 42 for MSI/MSI-X
pcieport 0000:00:11.0: irq 43 for MSI/MSI-X
pcieport 0000:00:1c.0: irq 44 for MSI/MSI-X
pcieport 0000:00:1c.1: irq 45 for MSI/MSI-X
pcieport 0000:00:1c.2: irq 46 for MSI/MSI-X
pcieport 0000:00:1c.3: irq 47 for MSI/MSI-X
pcieport 0000:00:1c.5: irq 48 for MSI/MSI-X
pcieport 0000:00:1c.6: irq 49 for MSI/MSI-X
pcieport 0000:00:1c.7: irq 50 for MSI/MSI-X
ioapic: probe of 0000:00:05.4 failed with error -22
input: Power Button as /devices/LNXSYSTM:00/device:00/PNP0C0C:00/input/input0
ACPI: Power Button [PWRB]
input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input1
ACPI: Power Button [PWRF]
ACPI: Requesting acpi_cpufreq
ACPI Error: [\TST0] Namespace lookup failure, AE_NOT_FOUND (20120320/psargs-359)
ACPI Error: Method parse/execution failed [\_SB_.C000._TPC] (Node ffff88080c07c7f8), AE_NOT_FOUND (20120320/psparse-536)
Monitor-Mwait will be used to enter C-1 state
Monitor-Mwait will be used to enter C-3 state
Monitor-Mwait will be used to enter C-3 state
ACPI: acpi_idle registered with cpuidle
ACPI Error: [\TST0] Namespace lookup failure, AE_NOT_FOUND (20120320/psargs-359)
ACPI Error: Method parse/execution failed [\_SB_.C001._TPC] (Node ffff88080c0815c8), AE_NOT_FOUND (20120320/psparse-536)
ACPI Error: [\TST0] Namespace lookup failure, AE_NOT_FOUND (20120320/psargs-359)
ACPI Error: Method parse/execution failed [\_SB_.C002._TPC] (Node ffff88080c085398), AE_NOT_FOUND (20120320/psparse-536)
ACPI Error: [\TST0] Namespace lookup failure, AE_NOT_FOUND (20120320/psargs-359)
ACPI Error: Method parse/execution failed [\_SB_.C003._TPC] (Node ffff88080c089168), AE_NOT_FOUND (20120320/psparse-536)
ACPI Error: [\TST0] Namespace lookup failure, AE_NOT_FOUND (20120320/psargs-359)
ACPI Error: Method parse/execution failed [\_SB_.C004._TPC] (Node ffff88080c08cf28), AE_NOT_FOUND (20120320/psparse-536)
ACPI Error: [\TST0] Namespace lookup failure, AE_NOT_FOUND (20120320/psargs-359)
ACPI Error: Method parse/execution failed [\_SB_.C005._TPC] (Node ffff88080c090cf8), AE_NOT_FOUND (20120320/psparse-536)
ACPI Error: [\TST0] Namespace lookup failure, AE_NOT_FOUND (20120320/psargs-359)
ACPI Error: Method parse/execution failed [\_SB_.C006._TPC] (Node ffff88080c094ac8), AE_NOT_FOUND (20120320/psparse-536)
ACPI Error: [\TST0] Namespace lookup failure, AE_NOT_FOUND (20120320/psargs-359)
ACPI Error: Method parse/execution failed [\_SB_.C007._TPC] (Node ffff88080c098898), AE_NOT_FOUND (20120320/psparse-536)
ACPI Error: [\TST0] Namespace lookup failure, AE_NOT_FOUND (20120320/psargs-359)
ACPI Error: Method parse/execution failed [\_SB_.C008._TPC] (Node ffff88080c09c668), AE_NOT_FOUND (20120320/psparse-536)
ACPI Error: [\TST0] Namespace lookup failure, AE_NOT_FOUND (20120320/psargs-359)
ACPI Error: Method parse/execution failed [\_SB_.C009._TPC] (Node ffff88080c0a0438), AE_NOT_FOUND (20120320/psparse-536)
ACPI Error: [\TST0] Namespace lookup failure, AE_NOT_FOUND (20120320/psargs-359)
ACPI Error: Method parse/execution failed [\_SB_.C00A._TPC] (Node ffff88080c0a4208), AE_NOT_FOUND (20120320/psparse-536)
ACPI Error: [\TST0] Namespace lookup failure, AE_NOT_FOUND (20120320/psargs-359)
ACPI Error: Method parse/execution failed [\_SB_.C00B._TPC] (Node ffff88080c0a7fc8), AE_NOT_FOUND (20120320/psparse-536)
Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
Non-volatile memory driver v1.3
ppdev: user-space parallel port driver
Linux agpgart interface v0.103
ipmi message handler version 39.2
ipmi device interface
IPMI System Interface driver.
ipmi_si: Adding default-specified kcs state machine
ipmi_si: Trying default-specified kcs state machine at i/o address 0xca2, slave address 0x0, irq 0
ipmi_si: Interface detection failed
ipmi_si: Adding default-specified smic state machine
ipmi_si: Trying default-specified smic state machine at i/o address 0xca9, slave address 0x0, irq 0
ipmi_si: Interface detection failed
ipmi_si: Adding default-specified bt state machine
ipmi_si: Trying default-specified bt state machine at i/o address 0xe4, slave address 0x0, irq 0
ipmi_si: Interface detection failed
ipmi_si: Unable to find any System Interface(s)
IPMI Watchdog: driver initialized
Copyright (C) 2004 MontaVista Software - IPMI Powerdown via sys_reboot.
[drm] Initialized drm 1.1.0 20060810
nbd: registered device at major 43
ACPI Warning: 0x0000000000000430-0x0000000000000433 SystemIO conflicts with Region \_SB_.PCI0.SBRG.SMIE 1 (20120320/utaddress-251)
ACPI: If an ACPI driver is available for this device, you should use it instead of the native driver
lpc_ich: Resource conflict(s) found affecting iTCO_wdt
ACPI Warning: 0x0000000000000500-0x000000000000053f SystemIO conflicts with Region \_SB_.PCI0.SBRG.LED_ 1 (20120320/utaddress-251)
ACPI: If an ACPI driver is available for this device, you should use it instead of the native driver
lpc_ich: Resource conflict(s) found affecting gpio_ich
ahci 0000:00:1f.2: version 3.0
ahci 0000:00:1f.2: irq 51 for MSI/MSI-X
ahci: SSS flag set, parallel bus scan disabled
ahci 0000:00:1f.2: AHCI 0001.0300 32 slots 6 ports 6 Gbps 0x3f impl SATA mode
ahci 0000:00:1f.2: flags: 64bit ncq sntf stag led clo pio ems apst 
ahci 0000:00:1f.2: setting latency timer to 64
scsi0 : ahci
scsi1 : ahci
scsi2 : ahci
scsi3 : ahci
scsi4 : ahci
scsi5 : ahci
ata1: SATA max UDMA/133 abar m2048@0xfb745000 port 0xfb745100 irq 51
ata2: SATA max UDMA/133 abar m2048@0xfb745000 port 0xfb745180 irq 51
ata3: SATA max UDMA/133 abar m2048@0xfb745000 port 0xfb745200 irq 51
ata4: SATA max UDMA/133 abar m2048@0xfb745000 port 0xfb745280 irq 51
ata5: SATA max UDMA/133 abar m2048@0xfb745000 port 0xfb745300 irq 51
ata6: SATA max UDMA/133 abar m2048@0xfb745000 port 0xfb745380 irq 51
ahci 0000:05:00.0: irq 52 for MSI/MSI-X
ahci 0000:05:00.0: AHCI 0001.0000 32 slots 2 ports 6 Gbps 0x3 impl SATA mode
ahci 0000:05:00.0: flags: 64bit ncq sntf led only pmp fbs pio slum part sxs 
scsi6 : ahci
scsi7 : ahci
ata7: SATA max UDMA/133 abar m512@0xfb610000 port 0xfb610100 irq 52
ata8: SATA max UDMA/133 abar m512@0xfb610000 port 0xfb610180 irq 52
ahci 0000:06:00.0: irq 53 for MSI/MSI-X
ahci 0000:06:00.0: AHCI 0001.0000 32 slots 2 ports 6 Gbps 0x3 impl SATA mode
ahci 0000:06:00.0: flags: 64bit ncq sntf led only pmp fbs pio slum part sxs 
scsi8 : ahci
scsi9 : ahci
ata9: SATA max UDMA/133 abar m512@0xfb510000 port 0xfb510100 irq 53
ata10: SATA max UDMA/133 abar m512@0xfb510000 port 0xfb510180 irq 53
ahci 0000:0b:00.0: irq 54 for MSI/MSI-X
ahci 0000:0b:00.0: AHCI 0001.0000 32 slots 2 ports 6 Gbps 0x3 impl SATA mode
ahci 0000:0b:00.0: flags: 64bit ncq sntf led only pmp fbs pio slum part sxs 
scsi10 : ahci
scsi11 : ahci
ata11: SATA max UDMA/133 abar m512@0xfb210000 port 0xfb210100 irq 54
ata12: SATA max UDMA/133 abar m512@0xfb210000 port 0xfb210180 irq 54
PPP generic driver version 2.4.2
PPP BSD Compression module registered
PPP Deflate Compression module registered
PPP MPPE Compression module registered
NET: Registered protocol family 24
usbcore: registered new interface driver asix
usbcore: registered new interface driver cdc_ncm
ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
ehci_hcd 0000:00:1a.0: setting latency timer to 64
ehci_hcd 0000:00:1a.0: EHCI Host Controller
ehci_hcd 0000:00:1a.0: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:1a.0: debug port 2
ehci_hcd 0000:00:1a.0: cache line size of 64 is not supported
ehci_hcd 0000:00:1a.0: irq 16, io mem 0xfb747000
ehci_hcd 0000:00:1a.0: USB 2.0 started, EHCI 1.00
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
ehci_hcd 0000:00:1d.0: setting latency timer to 64
ehci_hcd 0000:00:1d.0: EHCI Host Controller
ehci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
ehci_hcd 0000:00:1d.0: debug port 2
ehci_hcd 0000:00:1d.0: cache line size of 64 is not supported
ehci_hcd 0000:00:1d.0: irq 23, io mem 0xfb746000
ehci_hcd 0000:00:1d.0: USB 2.0 started, EHCI 1.00
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
uhci_hcd: USB Universal Host Controller Interface driver
usbcore: registered new interface driver usblp
Initializing USB Mass Storage driver...
usbcore: registered new interface driver usb-storage
USB Mass Storage support registered.
usbcore: registered new interface driver usbserial
usbcore: registered new interface driver usbserial_generic
USB Serial support registered for generic
usbserial: USB Serial Driver core
usbcore: registered new interface driver ipaq
USB Serial support registered for PocketPC PDA
usbcore: registered new interface driver pl2303
USB Serial support registered for pl2303
i8042: PNP: PS/2 Controller [PNP0303:PS2K] at 0x60,0x64 irq 1
i8042: PNP: PS/2 appears to have AUX port disabled, if this is incorrect please boot with i8042.nopnp
serio: i8042 KBD port at 0x60,0x64 irq 1
mousedev: PS/2 mouse device common for all mice
input: PC Speaker as /devices/platform/pcspkr/input/input2
rtc_cmos 00:05: RTC can wake from S4
rtc_cmos 00:05: rtc core: registered rtc_cmos as rtc0
rtc0: alarms up to one month, y3k, 114 bytes nvram, hpet irqs
i2c /dev entries driver
lirc_dev: IR Remote Control driver registered, major 250 
IR NEC protocol handler initialized
IR RC5(x) protocol handler initialized
IR RC6 protocol handler initialized
IR JVC protocol handler initialized
IR Sony protocol handler initialized
IR RC5 (streamzap) protocol handler initialized
IR SANYO protocol handler initialized
IR MCE Keyboard/mouse protocol handler initialized
IR LIRC bridge handler initialized
saa7146: register extension 'av7110'
b2c2-flexcop: B2C2 FlexcopII/II(b)/III digital TV receiver chip loaded successfully
Driver for 1-wire Dallas network protocol.
1-Wire driver for the DS2760 battery monitor  chip  - (c) 2004-2005, Szabolcs Gyurko
iTCO_wdt: Intel TCO WatchDog Timer Driver v1.07
iTCO_vendor_support: vendor-support=0
md: raid0 personality registered for level 0
md: raid1 personality registered for level 1
md: multipath personality registered for level -4
device-mapper: ioctl: 4.22.0-ioctl (2011-10-19) initialised: dm-devel@redhat.com
cpuidle: using governor ladder
cpuidle: using governor menu
sdhci: Secure Digital Host Controller Interface driver
sdhci: Copyright(c) Pierre Ossman
wbsd: Winbond W83L51xD SD/MMC card interface driver
wbsd: Copyright(c) Pierre Ossman
usbcore: registered new interface driver usbhid
usbhid: USB HID core driver
snd_hda_intel 0000:00:1b.0: irq 55 for MSI/MSI-X
input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input3
NET: Registered protocol family 26
TCP: cubic registered
Initializing XFRM netlink socket
NET: Registered protocol family 10
sit: IPv6 over IPv4 tunneling driver
NET: Registered protocol family 17
NET: Registered protocol family 15
lib80211: common routines for IEEE802.11 drivers
lib80211_crypt: registered algorithm 'NULL'
Key type dns_resolver registered
registered taskstats version 1
rtc_cmos 00:05: setting system clock to 2013-10-04 03:28:32 UTC (1380857312)
ALSA device list:
  #0: HDA Intel PCH at 0xfb720000 irq 55
ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
usb 1-1: new high-speed USB device number 2 using ehci_hcd
ata9: SATA link down (SStatus 0 SControl 300)
ata11: SATA link down (SStatus 0 SControl 300)
ata10: SATA link down (SStatus 0 SControl 300)
ata12: SATA link down (SStatus 0 SControl 300)
ata1.00: ATA-9: SAMSUNG SSD 830 Series, CXM03B1Q, max UDMA/133
ata1.00: 500118192 sectors, multi 16: LBA48 NCQ (depth 31/32), AA
ata1.00: configured for UDMA/133
scsi 0:0:0:0: Direct-Access     ATA      SAMSUNG SSD 830  CXM0 PQ: 0 ANSI: 5
sd 0:0:0:0: [sda] 500118192 512-byte logical blocks: (256 GB/238 GiB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 0:0:0:0: Attached scsi generic sg0 type 0
 sda: unknown partition table
sd 0:0:0:0: [sda] Attached SCSI disk
hub 1-1:1.0: USB hub found
hub 1-1:1.0: 6 ports detected
ata7: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata8: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
ata7.00: ATA-8: WDC WD30EZRS-00J99B0, 80.00A80, max UDMA/133
ata7.00: 5860533168 sectors, multi 16: LBA48 NCQ (depth 31/32), AA
ata8.00: ATA-8: WDC WD30EZRX-00MMMB0, 80.00A80, max UDMA/133
ata8.00: 5860533168 sectors, multi 16: LBA48 NCQ (depth 31/32), AA
ata7.00: configured for UDMA/133
ata8.00: configured for UDMA/133
usb 2-1: new high-speed USB device number 2 using ehci_hcd
hub 2-1:1.0: USB hub found
hub 2-1:1.0: 8 ports detected
ata2: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
ata2.00: ATA-9: SAMSUNG SSD 830 Series, CXM03B1Q, max UDMA/133
ata2.00: 500118192 sectors, multi 16: LBA48 NCQ (depth 31/32), AA
ata2.00: configured for UDMA/133
scsi 1:0:0:0: Direct-Access     ATA      SAMSUNG SSD 830  CXM0 PQ: 0 ANSI: 5
sd 1:0:0:0: [sdb] 500118192 512-byte logical blocks: (256 GB/238 GiB)
sd 1:0:0:0: Attached scsi generic sg1 type 0
sd 1:0:0:0: [sdb] Write Protect is off
sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sdb:
sd 1:0:0:0: [sdb] Attached SCSI disk
Refined TSC clocksource calibration: 3200.028 MHz.
Switching to clocksource tsc
ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata3.00: ATA-8: WDC WD1001FALS-00J7B0, 05.00K05, max UDMA/133
ata3.00: 1953525168 sectors, multi 16: LBA48 NCQ (depth 31/32), AA
ata3.00: configured for UDMA/133
scsi 2:0:0:0: Direct-Access     ATA      WDC WD1001FALS-0 05.0 PQ: 0 ANSI: 5
sd 2:0:0:0: [sdc] 1953525168 512-byte logical blocks: (1.00 TB/931 GiB)
sd 2:0:0:0: [sdc] Write Protect is off
sd 2:0:0:0: Attached scsi generic sg2 type 0
sd 2:0:0:0: [sdc] Mode Sense: 00 3a 00 00
sd 2:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sdc: sdc1 sdc2 sdc3
sd 2:0:0:0: [sdc] Attached SCSI disk
ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata4.00: ATA-8: WDC WD1001FALS-00J7B0, 05.00K05, max UDMA/133
ata4.00: 1953525168 sectors, multi 16: LBA48 NCQ (depth 31/32), AA
ata4.00: configured for UDMA/133
scsi 3:0:0:0: Direct-Access     ATA      WDC WD1001FALS-0 05.0 PQ: 0 ANSI: 5
sd 3:0:0:0: [sdd] 1953525168 512-byte logical blocks: (1.00 TB/931 GiB)
sd 3:0:0:0: Attached scsi generic sg3 type 0
sd 3:0:0:0: [sdd] Write Protect is off
sd 3:0:0:0: [sdd] Mode Sense: 00 3a 00 00
sd 3:0:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sdd: sdd1 sdd2 sdd3
sd 3:0:0:0: [sdd] Attached SCSI disk
ata5: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata5.00: ATA-8: WDC WD30EZRS-00J99B0, 80.00A80, max UDMA/133
ata5.00: 5860533168 sectors, multi 16: LBA48 NCQ (depth 31/32), AA
ata5.00: configured for UDMA/133
scsi 4:0:0:0: Direct-Access     ATA      WDC WD30EZRS-00J 80.0 PQ: 0 ANSI: 5
sd 4:0:0:0: [sde] 5860533168 512-byte logical blocks: (3.00 TB/2.72 TiB)
sd 4:0:0:0: [sde] 4096-byte physical blocks
sd 4:0:0:0: Attached scsi generic sg4 type 0
sd 4:0:0:0: [sde] Write Protect is off
sd 4:0:0:0: [sde] Mode Sense: 00 3a 00 00
sd 4:0:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sde: unknown partition table
sd 4:0:0:0: [sde] Attached SCSI disk
ata6: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata6.00: ATA-8: WDC WD30EZRS-00J99B0, 80.00A80, max UDMA/133
ata6.00: 5860533168 sectors, multi 16: LBA48 NCQ (depth 31/32), AA
ata6.00: configured for UDMA/133
scsi 5:0:0:0: Direct-Access     ATA      WDC WD30EZRS-00J 80.0 PQ: 0 ANSI: 5
sd 5:0:0:0: [sdf] 5860533168 512-byte logical blocks: (3.00 TB/2.72 TiB)
sd 5:0:0:0: [sdf] 4096-byte physical blocks
sd 5:0:0:0: Attached scsi generic sg5 type 0
sd 5:0:0:0: [sdf] Write Protect is off
sd 5:0:0:0: [sdf] Mode Sense: 00 3a 00 00
sd 5:0:0:0: [sdf] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sdf: unknown partition table
sd 5:0:0:0: [sdf] Attached SCSI disk
scsi 6:0:0:0: Direct-Access     ATA      WDC WD30EZRS-00J 80.0 PQ: 0 ANSI: 5
sd 6:0:0:0: [sdg] 5860533168 512-byte logical blocks: (3.00 TB/2.72 TiB)
sd 6:0:0:0: [sdg] 4096-byte physical blocks
sd 6:0:0:0: Attached scsi generic sg6 type 0
sd 6:0:0:0: [sdg] Write Protect is off
sd 6:0:0:0: [sdg] Mode Sense: 00 3a 00 00
sd 6:0:0:0: [sdg] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sdg: unknown partition table
sd 6:0:0:0: [sdg] Attached SCSI disk
scsi 7:0:0:0: Direct-Access     ATA      WDC WD30EZRX-00M 80.0 PQ: 0 ANSI: 5
sd 7:0:0:0: [sdh] 5860533168 512-byte logical blocks: (3.00 TB/2.72 TiB)
sd 7:0:0:0: Attached scsi generic sg7 type 0
sd 7:0:0:0: [sdh] 4096-byte physical blocks
sd 7:0:0:0: [sdh] Write Protect is off
sd 7:0:0:0: [sdh] Mode Sense: 00 3a 00 00
sd 7:0:0:0: [sdh] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sdh: unknown partition table
sd 7:0:0:0: [sdh] Attached SCSI disk
md: Waiting for all devices to be available before autodetect
md: If you don't use raid, use raid=noautodetect
md: Autodetecting RAID arrays.
md: Scanned 6 and added 6 devices.
md: autorun ...
md: considering sdd3 ...
md:  adding sdd3 ...
md: sdd2 has different UUID to sdd3
md: sdd1 has different UUID to sdd3
md:  adding sdc3 ...
md: sdc2 has different UUID to sdd3
md: sdc1 has different UUID to sdd3
md: created md3
md: bind<sdc3>
md: bind<sdd3>
md: running: <sdd3><sdc3>
bio: create slab <bio-1> at 1
md/raid0:md3: md_size is 6457856 sectors.
md: RAID0 configuration for md3 - 1 zone
md: zone0=[sdd3/sdc3]
      zone-offset=         0KB, device-offset=         0KB, size=   3228928KB

md3: detected capacity change from 0 to 3306422272
md: considering sdd2 ...
md:  adding sdd2 ...
md: sdd1 has different UUID to sdd2
md:  adding sdc2 ...
md: sdc1 has different UUID to sdd2
md: created md2
md: bind<sdc2>
md: bind<sdd2>
md: running: <sdd2><sdc2>
md/raid0:md2: md_size is 3666161152 sectors.
md: RAID0 configuration for md2 - 1 zone
md: zone0=[sdd2/sdc2]
      zone-offset=         0KB, device-offset=         0KB, size=1833080576KB

md2: detected capacity change from 0 to 1877074509824
md: considering sdd1 ...
md:  adding sdd1 ...
md:  adding sdc1 ...
md: created md1
md: bind<sdc1>
md: bind<sdd1>
md: running: <sdd1><sdc1>
md/raid1:md1: active with 2 out of 2 mirrors
md1: detected capacity change from 0 to 60011511808
md: ... autorun DONE.
 md1:
EXT4-fs (md1): couldn't mount as ext3 due to feature incompatibilities
EXT4-fs (md1): couldn't mount as ext2 due to feature incompatibilities
EXT4-fs (md1): mounted filesystem with ordered data mode. Opts: (null)
VFS: Mounted root (ext4 filesystem) readonly on device 9:1.
Freeing unused kernel memory: 500k freed
 md3: unknown partition table
Adding 3228924k swap on /dev/md3.  Priority:-1 extents:1 across:3228924k 
EXT4-fs (md1): re-mounted. Opts: (null)
EXT4-fs (md1): re-mounted. Opts: (null)
lp: driver loaded but no devices found
 md2: unknown partition table
EXT4-fs (md2): mounting ext3 file system using the ext4 subsystem
EXT4-fs (md2): mounted filesystem with ordered data mode. Opts: (null)
udevd[2113]: starting version 182
e1000e: Intel(R) PRO/1000 Network Driver - 2.0.0-k
e1000e: Copyright(c) 1999 - 2012 Intel Corporation.
e1000e 0000:00:19.0: setting latency timer to 64
e1000e 0000:00:19.0: (unregistered net_device): Interrupt Throttling Rate (ints/sec) set to dynamic conservative mode
e1000e 0000:00:19.0: irq 56 for MSI/MSI-X
e1000e 0000:00:19.0: eth0: (PCI Express:2.5GT/s:Width x1) 90:2b:34:50:a3:25
e1000e 0000:00:19.0: eth0: Intel(R) PRO/1000 Network Connection
e1000e 0000:00:19.0: eth0: MAC: 10, PHY: 11, PBA No: FFFFFF-0FF
md: bind<sdg>
md: bind<sdb>
md: bind<sda>
md/raid0:md0: md_size is 1000235008 sectors.
md: RAID0 configuration for md0 - 1 zone
md: zone0=[sda/sdb]
      zone-offset=         0KB, device-offset=         0KB, size= 500117504KB

md0: detected capacity change from 0 to 512120324096
md: bind<sde>
 md0: unknown partition table
md: bind<sdh>
md/raid1:md4: active with 2 out of 2 mirrors
md4: detected capacity change from 0 to 3000591794176
md: bind<sdf>
md/raid1:md127: active with 2 out of 2 mirrors
md127: detected capacity change from 0 to 3000591794176
 md127: unknown partition table
 md4: unknown partition table
e1000e 0000:00:19.0: irq 56 for MSI/MSI-X
e1000e 0000:00:19.0: irq 56 for MSI/MSI-X
IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
e1000e: eth0 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: Rx/Tx
IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
warning: `squid' uses 32-bit capabilities (legacy support in use)
EXT4-fs (md0): mounted filesystem without journal. Opts: (null)

--------------010104050809060804050608
Content-Type: text/plain; charset=ISO-8859-1;
 name="dmidecode"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="dmidecode"

# dmidecode 2.11
SMBIOS 2.7 present.
62 structures occupying 3007 bytes.
Table at 0x000EB1C0.

Handle 0x0000, DMI type 0, 24 bytes
BIOS Information
	Vendor: American Megatrends Inc.
	Version: F10
	Release Date: 03/05/2012
	Address: 0xF0000
	Runtime Size: 64 kB
	ROM Size: 4096 kB
	Characteristics:
		PCI is supported
		BIOS is upgradeable
		BIOS shadowing is allowed
		Boot from CD is supported
		Selectable boot is supported
		BIOS ROM is socketed
		EDD is supported
		5.25"/1.2 MB floppy services are supported (int 13h)
		3.5"/720 kB floppy services are supported (int 13h)
		3.5"/2.88 MB floppy services are supported (int 13h)
		Print screen service is supported (int 5h)
		8042 keyboard services are supported (int 9h)
		Serial services are supported (int 14h)
		Printer services are supported (int 17h)
		ACPI is supported
		USB legacy is supported
		BIOS boot specification is supported
		Targeted content distribution is supported
		UEFI is supported
	BIOS Revision: 4.6

Handle 0x0001, DMI type 1, 27 bytes
System Information
	Manufacturer: Gigabyte Technology Co., Ltd.
	Product Name: To be filled by O.E.M.
	Version: To be filled by O.E.M.
	Serial Number: To be filled by O.E.M.
	UUID: 03000200-0400-0500-0006-000700080009
	Wake-up Type: Power Switch
	SKU Number: To be filled by O.E.M.
	Family: To be filled by O.E.M.

Handle 0x0002, DMI type 2, 15 bytes
Base Board Information
	Manufacturer: Gigabyte Technology Co., Ltd.
	Product Name: X79-UD5
	Version: x.x
	Serial Number: To be filled by O.E.M.
	Asset Tag: To be filled by O.E.M.
	Features:
		Board is a hosting board
		Board is replaceable
	Location In Chassis: To be filled by O.E.M.
	Chassis Handle: 0x0003
	Type: Motherboard
	Contained Object Handles: 0

Handle 0x0003, DMI type 3, 22 bytes
Chassis Information
	Manufacturer: Gigabyte Technology Co., Ltd.
	Type: Desktop
	Lock: Not Present
	Version: To Be Filled By O.E.M.
	Serial Number: To Be Filled By O.E.M.
	Asset Tag: To Be Filled By O.E.M.
	Boot-up State: Safe
	Power Supply State: Safe
	Thermal State: Safe
	Security Status: None
	OEM Information: 0x00000000
	Height: Unspecified
	Number Of Power Cords: 1
	Contained Elements: 0
	SKU Number: To be filled by O.E.M.

Handle 0x0004, DMI type 7, 19 bytes
Cache Information
	Socket Designation: CPU Internal L1
	Configuration: Enabled, Not Socketed, Level 1
	Operational Mode: Varies With Memory Address
	Location: Internal
	Installed Size: 384 kB
	Maximum Size: 384 kB
	Supported SRAM Types:
		Unknown
	Installed SRAM Type: Unknown
	Speed: Unknown
	Error Correction Type: Parity
	System Type: Other
	Associativity: 8-way Set-associative

Handle 0x0005, DMI type 7, 19 bytes
Cache Information
	Socket Designation: CPU Internal L2
	Configuration: Enabled, Not Socketed, Level 2
	Operational Mode: Varies With Memory Address
	Location: Internal
	Installed Size: 1536 kB
	Maximum Size: 1536 kB
	Supported SRAM Types:
		Unknown
	Installed SRAM Type: Unknown
	Speed: Unknown
	Error Correction Type: Single-bit ECC
	System Type: Unified
	Associativity: 8-way Set-associative

Handle 0x0006, DMI type 7, 19 bytes
Cache Information
	Socket Designation: CPU Internal L3
	Configuration: Enabled, Not Socketed, Level 3
	Operational Mode: Varies With Memory Address
	Location: Internal
	Installed Size: 12288 kB
	Maximum Size: 12288 kB
	Supported SRAM Types:
		Unknown
	Installed SRAM Type: Unknown
	Speed: Unknown
	Error Correction Type: Single-bit ECC
	System Type: Unified
	Associativity: 16-way Set-associative

Handle 0x0008, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J1A1
	Internal Connector Type: None
	External Reference Designator: PS2Mouse
	External Connector Type: PS/2
	Port Type: Mouse Port

Handle 0x0009, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J1A1
	Internal Connector Type: None
	External Reference Designator: Keyboard
	External Connector Type: PS/2
	Port Type: Keyboard Port

Handle 0x000A, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J2A1
	Internal Connector Type: None
	External Reference Designator: TV Out
	External Connector Type: Mini Centronics Type-14
	Port Type: Other

Handle 0x000B, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J2A2A
	Internal Connector Type: None
	External Reference Designator: COM A
	External Connector Type: DB-9 male
	Port Type: Serial Port 16550A Compatible

Handle 0x000C, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J2A2B
	Internal Connector Type: None
	External Reference Designator: Video
	External Connector Type: DB-15 female
	Port Type: Video Port

Handle 0x000D, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J3A1
	Internal Connector Type: None
	External Reference Designator: USB1
	External Connector Type: Access Bus (USB)
	Port Type: USB

Handle 0x000E, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J3A1
	Internal Connector Type: None
	External Reference Designator: USB2
	External Connector Type: Access Bus (USB)
	Port Type: USB

Handle 0x000F, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J3A1
	Internal Connector Type: None
	External Reference Designator: USB3
	External Connector Type: Access Bus (USB)
	Port Type: USB

Handle 0x0010, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J9A1 - TPM HDR
	Internal Connector Type: Other
	External Reference Designator: Not Specified
	External Connector Type: None
	Port Type: Other

Handle 0x0011, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J9C1 - PCIE DOCKING CONN
	Internal Connector Type: Other
	External Reference Designator: Not Specified
	External Connector Type: None
	Port Type: Other

Handle 0x0012, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J2B3 - CPU FAN
	Internal Connector Type: Other
	External Reference Designator: Not Specified
	External Connector Type: None
	Port Type: Other

Handle 0x0013, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J6C2 - EXT HDMI
	Internal Connector Type: Other
	External Reference Designator: Not Specified
	External Connector Type: None
	Port Type: Other

Handle 0x0014, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J3C1 - GMCH FAN
	Internal Connector Type: Other
	External Reference Designator: Not Specified
	External Connector Type: None
	Port Type: Other

Handle 0x0015, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J1D1 - ITP
	Internal Connector Type: Other
	External Reference Designator: Not Specified
	External Connector Type: None
	Port Type: Other

Handle 0x0016, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J9E2 - MDC INTPSR
	Internal Connector Type: Other
	External Reference Designator: Not Specified
	External Connector Type: None
	Port Type: Other

Handle 0x0017, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J9E4 - MDC INTPSR
	Internal Connector Type: Other
	External Reference Designator: Not Specified
	External Connector Type: None
	Port Type: Other

Handle 0x0018, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J9E3 - LPC HOT DOCKING
	Internal Connector Type: Other
	External Reference Designator: Not Specified
	External Connector Type: None
	Port Type: Other

Handle 0x0019, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J9E1 - SCAN MATRIX
	Internal Connector Type: Other
	External Reference Designator: Not Specified
	External Connector Type: None
	Port Type: Other

Handle 0x001A, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J9G1 - LPC SIDE BAND
	Internal Connector Type: Other
	External Reference Designator: Not Specified
	External Connector Type: None
	Port Type: Other

Handle 0x001B, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J8F1 - UNIFIED
	Internal Connector Type: Other
	External Reference Designator: Not Specified
	External Connector Type: None
	Port Type: Other

Handle 0x001C, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J6F1 - LVDS
	Internal Connector Type: Other
	External Reference Designator: Not Specified
	External Connector Type: None
	Port Type: Other

Handle 0x001D, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J2F1 - LAI FAN
	Internal Connector Type: Other
	External Reference Designator: Not Specified
	External Connector Type: None
	Port Type: Other

Handle 0x001E, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J2G1 - GFX VID
	Internal Connector Type: Other
	External Reference Designator: Not Specified
	External Connector Type: None
	Port Type: Other

Handle 0x001F, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J1G6 - AC JACK
	Internal Connector Type: Other
	External Reference Designator: Not Specified
	External Connector Type: None
	Port Type: Other

Handle 0x0020, DMI type 9, 17 bytes
System Slot Information
	Designation: J6B2
	Type: x16 PCI Express
	Current Usage: In Use
	Length: Long
	ID: 0
	Characteristics:
		3.3 V is provided
		Opening is shared
		PME signal is supported
	Bus Address: 0000:00:02.0

Handle 0x0021, DMI type 9, 17 bytes
System Slot Information
	Designation: J6B1
	Type: x1 PCI Express
	Current Usage: In Use
	Length: Short
	ID: 1
	Characteristics:
		3.3 V is provided
		Opening is shared
		PME signal is supported
	Bus Address: 0000:00:1c.0

Handle 0x0022, DMI type 9, 17 bytes
System Slot Information
	Designation: J6D1
	Type: x8 PCI Express
	Current Usage: In Use
	Length: Short
	ID: 2
	Characteristics:
		3.3 V is provided
		Opening is shared
		PME signal is supported
	Bus Address: 0000:00:01.0

Handle 0x0023, DMI type 9, 17 bytes
System Slot Information
	Designation: J7B1
	Type: x16 PCI Express
	Current Usage: In Use
	Length: Short
	ID: 3
	Characteristics:
		3.3 V is provided
		Opening is shared
		PME signal is supported
	Bus Address: 0000:00:03.0

Handle 0x0024, DMI type 9, 17 bytes
System Slot Information
	Designation: J8B4
	Type: x1 PCI Express
	Current Usage: In Use
	Length: Short
	ID: 4
	Characteristics:
		3.3 V is provided
		Opening is shared
		PME signal is supported
	Bus Address: 0000:00:1c.7

Handle 0x0025, DMI type 9, 17 bytes
System Slot Information
	Designation: J8B3
	Type: 32-bit PCI
	Current Usage: In Use
	Length: Short
	ID: 6
	Characteristics:
		3.3 V is provided
		Opening is shared
		PME signal is supported
	Bus Address: 0000:14:1e.0

Handle 0x0026, DMI type 10, 6 bytes
On Board Device Information
	Type: Video
	Status: Enabled
	Description:    To Be Filled By O.E.M.

Handle 0x0027, DMI type 11, 5 bytes
OEM Strings
	String 1: To Be Filled By O.E.M.

Handle 0x0028, DMI type 12, 5 bytes
System Configuration Options
	Option 1: To Be Filled By O.E.M.

Handle 0x0029, DMI type 16, 23 bytes
Physical Memory Array
	Location: System Board Or Motherboard
	Use: System Memory
	Error Correction Type: None
	Maximum Capacity: 512 GB
	Error Information Handle: Not Provided
	Number Of Devices: 8

Handle 0x002A, DMI type 19, 31 bytes
Memory Array Mapped Address
	Starting Address: 0x00000000000
	Ending Address: 0x007FFFFFFFF
	Range Size: 32 GB
	Physical Array Handle: 0x0029
	Partition Width: 12

Handle 0x002B, DMI type 17, 34 bytes
Memory Device
	Array Handle: 0x0029
	Error Information Handle: Not Provided
	Total Width: 64 bits
	Data Width: 64 bits
	Size: 8192 MB
	Form Factor: DIMM
	Set: None
	Locator: Node0_Dimm0
	Bank Locator: Node0_Bank0
	Type: DDR3
	Type Detail: Synchronous
	Speed: 1333 MHz
	Manufacturer: Kingston          
	Serial Number: 00000000    
	Asset Tag: Dimm0_AssetTag
	Part Number: 9905403-500.A
	Rank: 2
	Configured Clock Speed: Unknown

Handle 0x002C, DMI type 20, 35 bytes
Memory Device Mapped Address
	Starting Address: 0x00000000000
	Ending Address: 0x001FFFFFFFF
	Range Size: 8 GB
	Physical Device Handle: 0x002B
	Memory Array Mapped Address Handle: 0x002A
	Partition Row Position: Unknown
	Interleave Position: Unknown
	Interleaved Data Depth: Unknown

Handle 0x002D, DMI type 17, 34 bytes
Memory Device
	Array Handle: 0x0029
	Error Information Handle: Not Provided
	Total Width: Unknown
	Data Width: 64 bits
	Size: No Module Installed
	Form Factor: DIMM
	Set: None
	Locator: Node0_Dimm1
	Bank Locator: Node0_Bank0
	Type: Unknown
	Type Detail: Synchronous
	Speed: Unknown
	Manufacturer: Dimm1_Manufacturer
	Serial Number: Dimm1_SerNum
	Asset Tag: Dimm1_AssetTag
	Part Number: Dimm1_PartNum
	Rank: Unknown
	Configured Clock Speed: Unknown

Handle 0x002E, DMI type 126, 35 bytes
Inactive

Handle 0x002F, DMI type 17, 34 bytes
Memory Device
	Array Handle: 0x0029
	Error Information Handle: Not Provided
	Total Width: 64 bits
	Data Width: 64 bits
	Size: 8192 MB
	Form Factor: DIMM
	Set: None
	Locator: Node0_Dimm2
	Bank Locator: Node0_Bank0
	Type: DDR3
	Type Detail: Fast-paged
	Speed: 1333 MHz
	Manufacturer: Kingston          
	Serial Number: 00000000    
	Asset Tag: Dimm2_AssetTag
	Part Number: 9905403-500.A
	Rank: 2
	Configured Clock Speed: Unknown

Handle 0x0030, DMI type 20, 35 bytes
Memory Device Mapped Address
	Starting Address: 0x00200000000
	Ending Address: 0x003FFFFFFFF
	Range Size: 8 GB
	Physical Device Handle: 0x002F
	Memory Array Mapped Address Handle: 0x002A
	Partition Row Position: Unknown
	Interleave Position: Unknown
	Interleaved Data Depth: Unknown

Handle 0x0031, DMI type 17, 34 bytes
Memory Device
	Array Handle: 0x0029
	Error Information Handle: Not Provided
	Total Width: Unknown
	Data Width: 64 bits
	Size: No Module Installed
	Form Factor: DIMM
	Set: None
	Locator: Node0_Dimm3
	Bank Locator: Node0_Bank0
	Type: Unknown
	Type Detail: Synchronous
	Speed: Unknown
	Manufacturer: Dimm3_Manufacturer
	Serial Number: Dimm3_SerNum
	Asset Tag: Dimm3_AssetTag
	Part Number: Dimm3_PartNum
	Rank: Unknown
	Configured Clock Speed: Unknown

Handle 0x0032, DMI type 126, 35 bytes
Inactive

Handle 0x0033, DMI type 17, 34 bytes
Memory Device
	Array Handle: 0x0029
	Error Information Handle: Not Provided
	Total Width: 64 bits
	Data Width: 64 bits
	Size: 8192 MB
	Form Factor: DIMM
	Set: None
	Locator: Node0_Dimm4
	Bank Locator: Node0_Bank0
	Type: DDR3
	Type Detail: Fast-paged Static Column Pseudo-static
	Speed: 1333 MHz
	Manufacturer: Kingston          
	Serial Number: 00000000    
	Asset Tag: Dimm4_AssetTag
	Part Number: 9905403-500.A
	Rank: 2
	Configured Clock Speed: Unknown

Handle 0x0034, DMI type 20, 35 bytes
Memory Device Mapped Address
	Starting Address: 0x00400000000
	Ending Address: 0x005FFFFFFFF
	Range Size: 8 GB
	Physical Device Handle: 0x0033
	Memory Array Mapped Address Handle: 0x002A
	Partition Row Position: Unknown
	Interleave Position: Unknown
	Interleaved Data Depth: Unknown

Handle 0x0035, DMI type 17, 34 bytes
Memory Device
	Array Handle: 0x0029
	Error Information Handle: Not Provided
	Total Width: Unknown
	Data Width: 64 bits
	Size: No Module Installed
	Form Factor: DIMM
	Set: None
	Locator: Node0_Dimm5
	Bank Locator: Node0_Bank0
	Type: Unknown
	Type Detail: Synchronous
	Speed: Unknown
	Manufacturer: Dimm5_Manufacturer
	Serial Number: Dimm5_SerNum
	Asset Tag: Dimm5_AssetTag
	Part Number: Dimm5_PartNum
	Rank: Unknown
	Configured Clock Speed: Unknown

Handle 0x0036, DMI type 126, 35 bytes
Inactive

Handle 0x0037, DMI type 17, 34 bytes
Memory Device
	Array Handle: 0x0029
	Error Information Handle: Not Provided
	Total Width: 64 bits
	Data Width: 64 bits
	Size: 8192 MB
	Form Factor: DIMM
	Set: None
	Locator: Node0_Dimm6
	Bank Locator: Node0_Bank0
	Type: DDR3
	Type Detail: Other Static Column RAMBus
	Speed: 1333 MHz
	Manufacturer: Kingston          
	Serial Number: 00000000    
	Asset Tag: Dimm6_AssetTag
	Part Number: 9905403-500.A
	Rank: 2
	Configured Clock Speed: Unknown

Handle 0x0038, DMI type 20, 35 bytes
Memory Device Mapped Address
	Starting Address: 0x00600000000
	Ending Address: 0x007FFFFFFFF
	Range Size: 8 GB
	Physical Device Handle: 0x0037
	Memory Array Mapped Address Handle: 0x002A
	Partition Row Position: Unknown
	Interleave Position: Unknown
	Interleaved Data Depth: Unknown

Handle 0x0039, DMI type 17, 34 bytes
Memory Device
	Array Handle: 0x0029
	Error Information Handle: Not Provided
	Total Width: Unknown
	Data Width: 64 bits
	Size: No Module Installed
	Form Factor: DIMM
	Set: None
	Locator: Node0_Dimm7
	Bank Locator: Node0_Bank0
	Type: Unknown
	Type Detail: Synchronous
	Speed: Unknown
	Manufacturer: Dimm7_Manufacturer
	Serial Number: Dimm7_SerNum
	Asset Tag: Dimm7_AssetTag
	Part Number: Dimm7_PartNum
	Rank: Unknown
	Configured Clock Speed: Unknown

Handle 0x003A, DMI type 126, 35 bytes
Inactive

Handle 0x003B, DMI type 41, 11 bytes
Onboard Device
	Reference Designation:  Onboard LAN
	Type: Ethernet
	Status: Enabled
	Type Instance: 1
	Bus Address: 0000:00:19.0

Handle 0x003F, DMI type 4, 42 bytes
Processor Information
	Socket Designation: SOCKET 0
	Type: Central Processor
	Family: Core i7
	Manufacturer: Intel
	ID: D7 06 02 00 FF FB EB BF
	Signature: Type 0, Family 6, Model 45, Stepping 7
	Flags:
		FPU (Floating-point unit on-chip)
		VME (Virtual mode extension)
		DE (Debugging extension)
		PSE (Page size extension)
		TSC (Time stamp counter)
		MSR (Model specific registers)
		PAE (Physical address extension)
		MCE (Machine check exception)
		CX8 (CMPXCHG8 instruction supported)
		APIC (On-chip APIC hardware supported)
		SEP (Fast system call)
		MTRR (Memory type range registers)
		PGE (Page global enable)
		MCA (Machine check architecture)
		CMOV (Conditional move instruction supported)
		PAT (Page attribute table)
		PSE-36 (36-bit page size extension)
		CLFSH (CLFLUSH instruction supported)
		DS (Debug store)
		ACPI (ACPI supported)
		MMX (MMX technology supported)
		FXSR (FXSAVE and FXSTOR instructions supported)
		SSE (Streaming SIMD extensions)
		SSE2 (Streaming SIMD extensions 2)
		SS (Self-snoop)
		HTT (Multi-threading)
		TM (Thermal monitor supported)
		PBE (Pending break enabled)
	Version: Intel(R) Core(TM) i7-3930K CPU @ 3.20GHz
	Voltage: 1.2 V
	External Clock: 100 MHz
	Max Speed: 7000 MHz
	Current Speed: 3500 MHz
	Status: Populated, Enabled
	Upgrade: Other
	L1 Cache Handle: 0x0004
	L2 Cache Handle: 0x0005
	L3 Cache Handle: 0x0006
	Serial Number: Not Specified
	Asset Tag: Not Specified
	Part Number: Not Specified
	Core Count: 6
	Core Enabled: 1
	Thread Count: 2
	Characteristics:
		64-bit capable

Handle 0x0040, DMI type 13, 22 bytes
BIOS Language Information
	Language Description Format: Long
	Installable Languages: 6
		en|US|iso8859-1
		de|DE|iso8859-1
		ru|RU|iso8859-5
		ja|JP|unicode
		zh|CS|unicode
		zh|CT|unicode
	Currently Installed Language: en|US|iso8859-1

Handle 0x0042, DMI type 127, 4 bytes
End Of Table


--------------010104050809060804050608--
