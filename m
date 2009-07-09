From: Zdenek Kaspar <zkaspar82@gmail.com>
Subject: Re: AHCI: connection status changed + hard resetting link with 2.6.30+
Date: Thu, 09 Jul 2009 03:23:54 +0200
Message-ID: <4A5546AA.8000404@gmail.com>
References: <4A4FD162.30604@gmail.com> <4A552185.7090301@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------020801040501030802010903"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f218.google.com ([209.85.220.218]:62582 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756782AbZGIBYF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 8 Jul 2009 21:24:05 -0400
Received: by fxm18 with SMTP id 18so6076020fxm.37
        for <linux-ide@vger.kernel.org>; Wed, 08 Jul 2009 18:24:02 -0700 (PDT)
In-Reply-To: <4A552185.7090301@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------020801040501030802010903
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit

Tejun Heo napsal(a):
> Zdenek Kaspar wrote:
>> Hi, when booted latest -stable kernel (2.6.30.1) got this in dmesg:
>>
>> [    1.521856] ata8: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0xf t4
>> [    1.521908] ata8: irq_stat 0x00400040, connection status changed
>> [    1.521962] ata8: hard resetting link
>>
>> Same result with 2.6.31-rc2, with 2.6.29.6 it works OK.
>>
>> Could this cause any trouble ?
> 
> Most likely not.  Looks like the device going through an extra PHY
> event cycle during initial probing.  I don't recall any change since
> 2.6.29 which could cause such behavior difference.  Can you please
> post the output of "lspci -nn" and full boot log?
> 
> Thanks.
> 

Hello Tejun, thanks for your reply. Attaching logs from my testing machine..

I see this behavior on ICH7R with i3000 chipset too:
00:1f.2 RAID bus controller [0104]: Intel Corporation 82801GR/GH (ICH7
Family) SATA RAID Controller [8086:27c3] (rev 01)

TIA, Z.

--------------020801040501030802010903
Content-Type: text/plain;
 name="dmesg-2.6.31-rc2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg-2.6.31-rc2"

[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Linux version 2.6.31-rc2 (root@atlas) (gcc version 4.3.2 (Debian 4.3.2-1.1) ) #1 SMP Sat Jul 4 19:50:11 UTC 2009
[    0.000000] Command line: root=/dev/mapper/sda2_crypt ro 
[    0.000000] KERNEL supported cpus:
[    0.000000]   Intel GenuineIntel
[    0.000000]   AMD AuthenticAMD
[    0.000000]   Centaur CentaurHauls
[    0.000000] BIOS-provided physical RAM map:
[    0.000000]  BIOS-e820: 0000000000000000 - 000000000008f000 (usable)
[    0.000000]  BIOS-e820: 000000000008f000 - 00000000000a0000 (reserved)
[    0.000000]  BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
[    0.000000]  BIOS-e820: 0000000000100000 - 000000007f547000 (usable)
[    0.000000]  BIOS-e820: 000000007f547000 - 000000007f553000 (reserved)
[    0.000000]  BIOS-e820: 000000007f553000 - 000000007f637000 (usable)
[    0.000000]  BIOS-e820: 000000007f637000 - 000000007f6e8000 (ACPI NVS)
[    0.000000]  BIOS-e820: 000000007f6e8000 - 000000007f6eb000 (usable)
[    0.000000]  BIOS-e820: 000000007f6eb000 - 000000007f6f0000 (ACPI data)
[    0.000000]  BIOS-e820: 000000007f6f0000 - 000000007f6f1000 (usable)
[    0.000000]  BIOS-e820: 000000007f6f1000 - 000000007f6ff000 (ACPI data)
[    0.000000]  BIOS-e820: 000000007f6ff000 - 000000007f700000 (usable)
[    0.000000]  BIOS-e820: 000000007f700000 - 0000000080000000 (reserved)
[    0.000000]  BIOS-e820: 00000000fff00000 - 0000000100000000 (reserved)
[    0.000000] DMI 2.4 present.
[    0.000000] last_pfn = 0x7f700 max_arch_pfn = 0x400000000
[    0.000000] MTRR default type: uncachable
[    0.000000] MTRR fixed ranges enabled:
[    0.000000]   00000-9FFFF write-back
[    0.000000]   A0000-FFFFF uncachable
[    0.000000] MTRR variable ranges enabled:
[    0.000000]   0 base 000000000 mask F80000000 write-back
[    0.000000]   1 base 07F800000 mask FFF800000 uncachable
[    0.000000]   2 base 07F700000 mask FFFF00000 uncachable
[    0.000000]   3 disabled
[    0.000000]   4 disabled
[    0.000000]   5 disabled
[    0.000000]   6 disabled
[    0.000000]   7 disabled
[    0.000000] x86 PAT enabled: cpu 0, old 0x7040600070406, new 0x7010600070106
[    0.000000] initial memory mapped : 0 - 20000000
[    0.000000] init_memory_mapping: 0000000000000000-000000007f700000
[    0.000000]  0000000000 - 007f600000 page 2M
[    0.000000]  007f600000 - 007f700000 page 4k
[    0.000000] kernel direct mapping tables up to 7f700000 @ 8000-c000
[    0.000000] RAMDISK: 37854000 - 37fefa8d
[    0.000000] ACPI: RSDP 00000000000fe020 00014 (v00 INTEL )
[    0.000000] ACPI: RSDT 000000007f6fd038 00050 (v01 INTEL  ECG3510M 00000073      01000013)
[    0.000000] ACPI: FACP 000000007f6fc000 00074 (v01 INTEL  ECG3510M 00000073 MSFT 01000013)
[    0.000000] ACPI: DSDT 000000007f6f6000 05BEB (v01 INTEL  ECG3510M 00000073 MSFT 01000013)
[    0.000000] ACPI: FACS 000000007f693000 00040
[    0.000000] ACPI: APIC 000000007f6f5000 00078 (v01 INTEL  ECG3510M 00000073 MSFT 01000013)
[    0.000000] ACPI: WDDT 000000007f6f4000 00040 (v01 INTEL  ECG3510M 00000073 MSFT 01000013)
[    0.000000] ACPI: MCFG 000000007f6f3000 0003C (v01 INTEL  ECG3510M 00000073 MSFT 01000013)
[    0.000000] ACPI: ASF! 000000007f6f2000 000A6 (v32 INTEL  ECG3510M 00000073 MSFT 01000013)
[    0.000000] ACPI: HPET 000000007f6f1000 00038 (v01 INTEL  ECG3510M 00000073 MSFT 01000013)
[    0.000000] ACPI: SSDT 000000007f6ef000 0020C (v01 INTEL     CpuPm 00000073 MSFT 01000013)
[    0.000000] ACPI: SSDT 000000007f6ee000 00175 (v01 INTEL   Cpu0Ist 00000073 MSFT 01000013)
[    0.000000] ACPI: SSDT 000000007f6ed000 00175 (v01 INTEL   Cpu1Ist 00000073 MSFT 01000013)
[    0.000000] ACPI: SSDT 000000007f6ec000 00175 (v01 INTEL   Cpu2Ist 00000073 MSFT 01000013)
[    0.000000] ACPI: SSDT 000000007f6eb000 00175 (v01 INTEL   Cpu3Ist 00000073 MSFT 01000013)
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] No NUMA configuration found
[    0.000000] Faking a node at 0000000000000000-000000007f700000
[    0.000000] Bootmem setup node 0 0000000000000000-000000007f700000
[    0.000000]   NODE_DATA [0000000000001000 - 0000000000004fff]
[    0.000000]   bootmap [000000000000a000 -  0000000000019edf] pages 10
[    0.000000] (7 early reservations) ==> bootmem [0000000000 - 007f700000]
[    0.000000]   #0 [0000000000 - 0000001000]   BIOS data page ==> [0000000000 - 0000001000]
[    0.000000]   #1 [0000006000 - 0000008000]       TRAMPOLINE ==> [0000006000 - 0000008000]
[    0.000000]   #2 [0001000000 - 000152280c]    TEXT DATA BSS ==> [0001000000 - 000152280c]
[    0.000000]   #3 [0037854000 - 0037fefa8d]          RAMDISK ==> [0037854000 - 0037fefa8d]
[    0.000000]   #4 [000009e000 - 0000100000]    BIOS reserved ==> [000009e000 - 0000100000]
[    0.000000]   #5 [0001523000 - 000152314d]              BRK ==> [0001523000 - 000152314d]
[    0.000000]   #6 [0000008000 - 000000a000]          PGTABLE ==> [0000008000 - 000000a000]
[    0.000000] found SMP MP-table at [ffff8800000fe200] fe200
[    0.000000]  [ffffea0000000000-ffffea0001bfffff] PMD -> [ffff880001a00000-ffff8800035fffff] on node 0
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA      0x00000000 -> 0x00001000
[    0.000000]   DMA32    0x00001000 -> 0x00100000
[    0.000000]   Normal   0x00100000 -> 0x00100000
[    0.000000] Movable zone start PFN for each node
[    0.000000] early_node_map[6] active PFN ranges
[    0.000000]     0: 0x00000000 -> 0x0000008f
[    0.000000]     0: 0x00000100 -> 0x0007f547
[    0.000000]     0: 0x0007f553 -> 0x0007f637
[    0.000000]     0: 0x0007f6e8 -> 0x0007f6eb
[    0.000000]     0: 0x0007f6f0 -> 0x0007f6f1
[    0.000000]     0: 0x0007f6ff -> 0x0007f700
[    0.000000] On node 0 totalpages: 521663
[    0.000000]   DMA zone: 56 pages used for memmap
[    0.000000]   DMA zone: 103 pages reserved
[    0.000000]   DMA zone: 3824 pages, LIFO batch:0
[    0.000000]   DMA32 zone: 7081 pages used for memmap
[    0.000000]   DMA32 zone: 510599 pages, LIFO batch:31
[    0.000000] ACPI: PM-Timer IO Port: 0x408
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x03] lapic_id[0x82] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x04] lapic_id[0x83] disabled)
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x01] dfl dfl lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x02] dfl dfl lint[0x1])
[    0.000000] ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ2 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.000000] SMP: Allowing 4 CPUs, 2 hotplug CPUs
[    0.000000] nr_irqs_gsi: 24
[    0.000000] PM: Registered nosave memory: 000000000008f000 - 00000000000a0000
[    0.000000] PM: Registered nosave memory: 00000000000a0000 - 00000000000e0000
[    0.000000] PM: Registered nosave memory: 00000000000e0000 - 0000000000100000
[    0.000000] PM: Registered nosave memory: 000000007f547000 - 000000007f553000
[    0.000000] PM: Registered nosave memory: 000000007f637000 - 000000007f6e8000
[    0.000000] PM: Registered nosave memory: 000000007f6eb000 - 000000007f6f0000
[    0.000000] PM: Registered nosave memory: 000000007f6f1000 - 000000007f6ff000
[    0.000000] Allocating PCI resources starting at 80000000 (gap: 80000000:7ff00000)
[    0.000000] NR_CPUS:8 nr_cpumask_bits:8 nr_cpu_ids:4 nr_node_ids:1
[    0.000000] PERCPU: Embedded 25 pages at ffff880001534000, static data 72800 bytes
[    0.000000] Built 1 zonelists in Node order, mobility grouping on.  Total pages: 514423
[    0.000000] Policy zone: DMA32
[    0.000000] Kernel command line: root=/dev/mapper/sda2_crypt ro 
[    0.000000] PID hash table entries: 4096 (order: 12, 32768 bytes)
[    0.000000] Initializing CPU#0
[    0.000000] Checking aperture...
[    0.000000] No AGP bridge found
[    0.000000] Calgary: detecting Calgary via BIOS EBDA area
[    0.000000] Calgary: Unable to locate Rio Grande table in EBDA - bailing!
[    0.000000] Memory: 2044360k/2087936k available (2789k kernel code, 1284k absent, 42292k reserved, 1376k data, 512k init)
[    0.000000] Experimental hierarchical RCU implementation.
[    0.000000] Experimental hierarchical RCU init done.
[    0.000000] NR_IRQS:4352 nr_irqs:440
[    0.000000] Fast TSC calibration using PIT
[    0.000000] Detected 2387.845 MHz processor.
[    0.002343] Console: colour VGA+ 80x25
[    0.002345] console [tty0] enabled
[    0.007428] hpet clockevent registered
[    0.007431] HPET: 3 timers in total, 0 timers will be used for per-cpu timer
[    0.007483] Calibrating delay loop (skipped), value calculated using timer frequency.. 4775.69 BogoMIPS (lpj=23878450)
[    0.007609] Security Framework initialized
[    0.007655] SELinux:  Disabled at boot.
[    0.007853] Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
[    0.008993] Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes)
[    0.009524] Mount-cache hash table entries: 256
[    0.009697] Initializing cgroup subsys ns
[    0.009742] Initializing cgroup subsys cpuacct
[    0.009787] Initializing cgroup subsys devices
[    0.009830] Initializing cgroup subsys freezer
[    0.009873] Initializing cgroup subsys net_cls
[    0.009933] CPU: L1 I cache: 32K, L1 D cache: 32K
[    0.009995] CPU: L2 cache: 4096K
[    0.010000] CPU 0/0x0 -> Node 0
[    0.010000] CPU: Physical Processor ID: 0
[    0.010000] CPU: Processor Core ID: 0
[    0.010000] mce: CPU supports 6 MCE banks
[    0.010000] CPU0: Thermal monitoring enabled (TM2)
[    0.010000] using mwait in idle threads.
[    0.010000] ACPI: Core revision 20090521
[    0.011484] Setting APIC routing to flat
[    0.011828] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.111624] CPU0: Intel(R) Core(TM)2 CPU          6600  @ 2.40GHz stepping 06
[    0.120000] Booting processor 1 APIC 0x1 ip 0x6000
[    0.010000] Initializing CPU#1
[    0.010000] Calibrating delay using timer specific routine.. 4757.98 BogoMIPS (lpj=23789916)
[    0.010000] CPU: L1 I cache: 32K, L1 D cache: 32K
[    0.010000] CPU: L2 cache: 4096K
[    0.010000] CPU 1/0x1 -> Node 0
[    0.010000] CPU: Physical Processor ID: 0
[    0.010000] CPU: Processor Core ID: 1
[    0.010000] mce: CPU supports 6 MCE banks
[    0.010000] CPU1: Thermal monitoring enabled (TM2)
[    0.010000] x86 PAT enabled: cpu 1, old 0x7040600070406, new 0x7010600070106
[    0.271216] CPU1: Intel(R) Core(TM)2 CPU          6600  @ 2.40GHz stepping 06
[    0.271736] checking TSC synchronization [CPU#0 -> CPU#1]: passed.
[    0.280017] Brought up 2 CPUs
[    0.280059] Total of 2 processors activated (9533.67 BogoMIPS).
[    0.280181] regulator: core version 0.5
[    0.280181] NET: Registered protocol family 16
[    0.280181] ACPI: bus type pci registered
[    0.280181] PCI: MCFG configuration 0: base f0000000 segment 0 buses 0 - 127
[    0.280181] PCI: Not using MMCONFIG.
[    0.280181] PCI: Using configuration type 1 for base access
[    0.280182] bio: create slab <bio-0> at 0
[    0.280443] ACPI: EC: Look up EC in DSDT
[    0.283365] ACPI: Interpreter enabled
[    0.283408] ACPI: (supports S0 S1 S3 S4 S5)
[    0.283556] ACPI: Using IOAPIC for interrupt routing
[    0.283631] PCI: MCFG configuration 0: base f0000000 segment 0 buses 0 - 127
[    0.284316] PCI: MCFG area at f0000000 reserved in ACPI motherboard resources
[    0.292732] PCI: Using MMCONFIG at f0000000 - f7ffffff
[    0.292786] ACPI: No dock devices found.
[    0.292786] ACPI: PCI Root Bridge [PCI0] (0000:00)
[    0.292786] pci 0000:00:02.0: reg 10 32bit mmio: [0x90100000-0x901fffff]
[    0.292786] pci 0000:00:02.0: reg 18 64bit mmio: [0x80000000-0x8fffffff]
[    0.292786] pci 0000:00:02.0: reg 20 io port: [0x2410-0x2417]
[    0.292786] pci 0000:00:02.1: reg 10 32bit mmio: [0x90000000-0x900fffff]
[    0.292786] pci 0000:00:19.0: reg 10 32bit mmio: [0x90200000-0x9021ffff]
[    0.292786] pci 0000:00:19.0: reg 14 32bit mmio: [0x90220000-0x90220fff]
[    0.292786] pci 0000:00:19.0: reg 18 io port: [0x20e0-0x20ff]
[    0.292786] pci 0000:00:19.0: PME# supported from D0 D3hot D3cold
[    0.292786] pci 0000:00:19.0: PME# disabled
[    0.292786] pci 0000:00:1a.0: reg 20 io port: [0x20c0-0x20df]
[    0.292786] pci 0000:00:1a.1: reg 20 io port: [0x20a0-0x20bf]
[    0.292786] pci 0000:00:1a.7: reg 10 32bit mmio: [0x90221c00-0x90221fff]
[    0.292786] pci 0000:00:1a.7: PME# supported from D0 D3hot D3cold
[    0.292786] pci 0000:00:1a.7: PME# disabled
[    0.292786] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    0.292786] pci 0000:00:1c.0: PME# disabled
[    0.292786] pci 0000:00:1c.1: PME# supported from D0 D3hot D3cold
[    0.292786] pci 0000:00:1c.1: PME# disabled
[    0.292786] pci 0000:00:1c.2: PME# supported from D0 D3hot D3cold
[    0.292786] pci 0000:00:1c.2: PME# disabled
[    0.292786] pci 0000:00:1d.0: reg 20 io port: [0x2080-0x209f]
[    0.292786] pci 0000:00:1d.1: reg 20 io port: [0x2060-0x207f]
[    0.292786] pci 0000:00:1d.2: reg 20 io port: [0x2040-0x205f]
[    0.292786] pci 0000:00:1d.7: reg 10 32bit mmio: [0x90221800-0x90221bff]
[    0.292786] pci 0000:00:1d.7: PME# supported from D0 D3hot D3cold
[    0.292786] pci 0000:00:1d.7: PME# disabled
[    0.300103] pci 0000:00:1f.0: quirk: region 0400-047f claimed by ICH6 ACPI/GPIO/TCO
[    0.300170] pci 0000:00:1f.0: quirk: region 0500-053f claimed by ICH6 GPIO
[    0.300219] pci 0000:00:1f.0: ICH7 LPC Generic IO decode 1 PIO at 0680 (mask 007f)
[    0.300334] pci 0000:00:1f.2: reg 10 io port: [0x2408-0x240f]
[    0.300339] pci 0000:00:1f.2: reg 14 io port: [0x241c-0x241f]
[    0.300344] pci 0000:00:1f.2: reg 18 io port: [0x2400-0x2407]
[    0.300349] pci 0000:00:1f.2: reg 1c io port: [0x2418-0x241b]
[    0.300354] pci 0000:00:1f.2: reg 20 io port: [0x2020-0x203f]
[    0.300359] pci 0000:00:1f.2: reg 24 32bit mmio: [0x90221000-0x902217ff]
[    0.300383] pci 0000:00:1f.2: PME# supported from D3hot
[    0.300429] pci 0000:00:1f.2: PME# disabled
[    0.300489] pci 0000:00:1f.3: reg 10 32bit mmio: [0x90222000-0x902220ff]
[    0.300504] pci 0000:00:1f.3: reg 20 io port: [0x2000-0x201f]
[    0.300653] pci 0000:03:00.0: reg 10 io port: [0x1018-0x101f]
[    0.300661] pci 0000:03:00.0: reg 14 io port: [0x1024-0x1027]
[    0.300670] pci 0000:03:00.0: reg 18 io port: [0x1010-0x1017]
[    0.300679] pci 0000:03:00.0: reg 1c io port: [0x1020-0x1023]
[    0.300687] pci 0000:03:00.0: reg 20 io port: [0x1000-0x100f]
[    0.300702] pci 0000:03:00.0: reg 30 32bit mmio: [0xffff0000-0xffffffff]
[    0.300779] pci 0000:00:1c.2: bridge io port: [0x1000-0x1fff]
[    0.300827] pci 0000:00:1e.0: transparent bridge
[    0.300892] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[    0.301107] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P32_._PRT]
[    0.301191] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEX0._PRT]
[    0.301251] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEX1._PRT]
[    0.301310] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEX2._PRT]
[    0.301606] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 9 10 *11 12)
[    0.301606] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 7 9 10 11 12) *0, disabled.
[    0.301606] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 7 9 10 *11 12)
[    0.301606] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 7 9 *10 11 12)
[    0.301606] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 7 *9 10 11 12)
[    0.301687] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 7 9 *10 11 12)
[    0.302000] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 7 9 10 11 12) *0, disabled.
[    0.302363] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 7 *9 10 11 12)
[    0.302629] usbcore: registered new interface driver usbfs
[    0.302629] usbcore: registered new interface driver hub
[    0.302629] usbcore: registered new device driver usb
[    0.310029] PCI: Using ACPI for IRQ routing
[    0.330044] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
[    0.330172] hpet0: 3 comparators, 64-bit 14.318180 MHz counter
[    0.370013] pnp: PnP ACPI init
[    0.370067] ACPI: bus type pnp registered
[    0.372544] pnp: PnP ACPI: found 11 devices
[    0.372587] ACPI: ACPI bus type pnp unregistered
[    0.372637] system 00:01: iomem range 0xf0000000-0xf7ffffff has been reserved
[    0.372687] system 00:01: iomem range 0xfed13000-0xfed13fff has been reserved
[    0.372736] system 00:01: iomem range 0xfed14000-0xfed17fff has been reserved
[    0.372786] system 00:01: iomem range 0xfed18000-0xfed18fff has been reserved
[    0.372835] system 00:01: iomem range 0xfed19000-0xfed19fff has been reserved
[    0.372885] system 00:01: iomem range 0xfed1c000-0xfed1ffff has been reserved
[    0.372934] system 00:01: iomem range 0xfed20000-0xfed3ffff has been reserved
[    0.372984] system 00:01: iomem range 0xfed45000-0xfed99fff has been reserved
[    0.373033] system 00:01: iomem range 0xc0000-0xdffff has been reserved
[    0.373082] system 00:01: iomem range 0xe0000-0xfffff could not be reserved
[    0.373134] system 00:06: ioport range 0x500-0x53f has been reserved
[    0.373182] system 00:06: ioport range 0x400-0x47f has been reserved
[    0.373230] system 00:06: ioport range 0x360-0x361 has been reserved
[    0.373277] system 00:06: ioport range 0x680-0x6ff has been reserved
[    0.378267] pci 0000:03:00.0: BAR 6: no parent found for of device [0xffff0000-0xffffffff]
[    0.378359] pci 0000:00:1c.0: PCI bridge, secondary bus 0000:01
[    0.378405] pci 0000:00:1c.0:   IO window: disabled
[    0.378451] pci 0000:00:1c.0:   MEM window: disabled
[    0.378496] pci 0000:00:1c.0:   PREFETCH window: disabled
[    0.378543] pci 0000:00:1c.1: PCI bridge, secondary bus 0000:02
[    0.378589] pci 0000:00:1c.1:   IO window: disabled
[    0.378635] pci 0000:00:1c.1:   MEM window: disabled
[    0.378681] pci 0000:00:1c.1:   PREFETCH window: disabled
[    0.378728] pci 0000:00:1c.2: PCI bridge, secondary bus 0000:03
[    0.378776] pci 0000:00:1c.2:   IO window: 0x1000-0x1fff
[    0.378823] pci 0000:00:1c.2:   MEM window: disabled
[    0.378869] pci 0000:00:1c.2:   PREFETCH window: 0x90300000-0x903fffff
[    0.378918] pci 0000:00:1e.0: PCI bridge, secondary bus 0000:04
[    0.378965] pci 0000:00:1e.0:   IO window: disabled
[    0.379011] pci 0000:00:1e.0:   MEM window: disabled
[    0.379056] pci 0000:00:1e.0:   PREFETCH window: disabled
[    0.379108]   alloc irq_desc for 17 on node 0
[    0.379110]   alloc kstat_irqs on node 0
[    0.379115] pci 0000:00:1c.0: PCI INT A -> GSI 17 (level, low) -> IRQ 17
[    0.379165] pci 0000:00:1c.0: setting latency timer to 64
[    0.379170]   alloc irq_desc for 16 on node 0
[    0.379172]   alloc kstat_irqs on node 0
[    0.379175] pci 0000:00:1c.1: PCI INT B -> GSI 16 (level, low) -> IRQ 16
[    0.379224] pci 0000:00:1c.1: setting latency timer to 64
[    0.379229]   alloc irq_desc for 18 on node 0
[    0.379231]   alloc kstat_irqs on node 0
[    0.379234] pci 0000:00:1c.2: PCI INT C -> GSI 18 (level, low) -> IRQ 18
[    0.379284] pci 0000:00:1c.2: setting latency timer to 64
[    0.379289] pci 0000:00:1e.0: setting latency timer to 64
[    0.379292] pci_bus 0000:00: resource 0 io:  [0x00-0xffff]
[    0.379294] pci_bus 0000:00: resource 1 mem: [0x000000-0xffffffffffffffff]
[    0.379297] pci_bus 0000:03: resource 0 io:  [0x1000-0x1fff]
[    0.379299] pci_bus 0000:03: resource 2 pref mem [0x90300000-0x903fffff]
[    0.379301] pci_bus 0000:04: resource 3 io:  [0x00-0xffff]
[    0.379303] pci_bus 0000:04: resource 4 mem: [0x000000-0xffffffffffffffff]
[    0.379345] NET: Registered protocol family 2
[    0.379498] IP route cache hash table entries: 65536 (order: 7, 524288 bytes)
[    0.380170] TCP established hash table entries: 262144 (order: 10, 4194304 bytes)
[    0.381753] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[    0.382315] TCP: Hash tables configured (established 262144 bind 65536)
[    0.382364] TCP reno registered
[    0.382528] NET: Registered protocol family 1
[    0.382628] Trying to unpack rootfs image as initramfs...
[    0.501432] Switched to high resolution mode on CPU 1
[    0.509504] Switched to high resolution mode on CPU 0
[    0.565041] Freeing initrd memory: 7790k freed
[    0.568725] audit: initializing netlink socket (disabled)
[    0.568793] type=2000 audit(1247108221.561:1): initialized
[    0.569057] HugeTLB registered 2 MB page size, pre-allocated 0 pages
[    0.569199] VFS: Disk quotas dquot_6.5.2
[    0.569267] Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    0.569363] msgmni has been set to 4008
[    0.569539] alg: No test for stdrng (krng)
[    0.569627] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 253)
[    0.569693] io scheduler noop registered
[    0.569735] io scheduler anticipatory registered
[    0.569778] io scheduler deadline registered (default)
[    0.569832] io scheduler cfq registered
[    0.569883] pci 0000:00:02.0: Boot video device
[    0.570342]   alloc irq_desc for 24 on node 0
[    0.570344]   alloc kstat_irqs on node 0
[    0.570353] pcieport-driver 0000:00:1c.0: irq 24 for MSI/MSI-X
[    0.570361] pcieport-driver 0000:00:1c.0: setting latency timer to 64
[    0.570536]   alloc irq_desc for 25 on node 0
[    0.570537]   alloc kstat_irqs on node 0
[    0.570543] pcieport-driver 0000:00:1c.1: irq 25 for MSI/MSI-X
[    0.570550] pcieport-driver 0000:00:1c.1: setting latency timer to 64
[    0.570721]   alloc irq_desc for 26 on node 0
[    0.570723]   alloc kstat_irqs on node 0
[    0.570729] pcieport-driver 0000:00:1c.2: irq 26 for MSI/MSI-X
[    0.570735] pcieport-driver 0000:00:1c.2: setting latency timer to 64
[    0.573681] Linux agpgart interface v0.103
[    0.573725] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    0.573884] serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[    0.574109] Platform driver 'serial8250' needs updating - please use dev_pm_ops
[    0.574404] 00:08: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[    0.576053] brd: module loaded
[    0.576155] input: Macintosh mouse button emulation as /devices/virtual/input/input0
[    0.576388] PNP: PS/2 Controller [PNP0303:PS2K] at 0x60,0x64 irq 1
[    0.576435] PNP: PS/2 appears to have AUX port disabled, if this is incorrect please boot with i8042.nopnp
[    0.576512] Platform driver 'i8042' needs updating - please use dev_pm_ops
[    0.576968] serio: i8042 KBD port at 0x60,0x64 irq 1
[    0.577137] mice: PS/2 mouse device common for all mice
[    0.577231] rtc_cmos 00:03: RTC can wake from S4
[    0.577320] rtc_cmos 00:03: rtc core: registered rtc_cmos as rtc0
[    0.577387] rtc0: alarms up to one month, 114 bytes nvram, hpet irqs
[    0.577462] cpuidle: using governor ladder
[    0.577504] cpuidle: using governor menu
[    0.577549] No iBFT detected.
[    0.577846] TCP cubic registered
[    0.577919] NET: Registered protocol family 10
[    0.578321] lo: Disabled Privacy Extensions
[    0.578579] Mobile IPv6
[    0.578619] NET: Registered protocol family 17
[    0.578787] registered taskstats version 1
[    0.578950] rtc_cmos 00:03: setting system clock to 2009-07-09 02:57:02 UTC (1247108222)
[    0.579072] Freeing unused kernel memory: 512k freed
[    0.603563] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input1
[    0.688114] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    0.690269] e1000e: Intel(R) PRO/1000 Network Driver - 1.0.2-k2
[    0.690323] e1000e: Copyright (c) 1999-2008 Intel Corporation.
[    0.690539] ehci_hcd 0000:00:1a.7: PCI INT C -> GSI 18 (level, low) -> IRQ 18
[    0.690602] ehci_hcd 0000:00:1a.7: setting latency timer to 64
[    0.690605] ehci_hcd 0000:00:1a.7: EHCI Host Controller
[    0.690699] ehci_hcd 0000:00:1a.7: new USB bus registered, assigned bus number 1
[    0.694666] ehci_hcd 0000:00:1a.7: debug port 1
[    0.694713] ehci_hcd 0000:00:1a.7: cache line size of 32 is not supported
[    0.694729] ehci_hcd 0000:00:1a.7: irq 18, io mem 0x90221c00
[    0.710216] SCSI subsystem initialized
[    0.720010] ehci_hcd 0000:00:1a.7: USB 2.0 started, EHCI 1.00
[    0.720081] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
[    0.720130] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    0.720194] usb usb1: Product: EHCI Host Controller
[    0.720243] usb usb1: Manufacturer: Linux 2.6.31-rc2 ehci_hcd
[    0.720302] usb usb1: SerialNumber: 0000:00:1a.7
[    0.720408] usb usb1: configuration #1 chosen from 1 choice
[    0.720487] hub 1-0:1.0: USB hub found
[    0.720542] hub 1-0:1.0: 4 ports detected
[    0.720702]   alloc irq_desc for 20 on node 0
[    0.720704]   alloc kstat_irqs on node 0
[    0.720711] e1000e 0000:00:19.0: PCI INT A -> GSI 20 (level, low) -> IRQ 20
[    0.720780] e1000e 0000:00:19.0: setting latency timer to 64
[    0.720845]   alloc irq_desc for 27 on node 0
[    0.720847]   alloc kstat_irqs on node 0
[    0.720855] e1000e 0000:00:19.0: irq 27 for MSI/MSI-X
[    0.731355] libata version 3.00 loaded.
[    0.733382] pata_jmicron 0000:03:00.0: PCI INT A -> GSI 18 (level, low) -> IRQ 18
[    0.733476] pata_jmicron 0000:03:00.0: setting latency timer to 64
[    0.733514] scsi0 : pata_jmicron
[    0.733623] scsi1 : pata_jmicron
[    0.734185] ata1: PATA max UDMA/100 cmd 0x1018 ctl 0x1024 bmdma 0x1000 irq 18
[    0.734235] ata2: PATA max UDMA/100 cmd 0x1010 ctl 0x1020 bmdma 0x1008 irq 18
[    0.735318] uhci_hcd: USB Universal Host Controller Interface driver
[    0.972389] 0000:00:19.0: eth0: (PCI Express:2.5GB/s:Width x1) 00:1c:c0:5a:d8:ba
[    0.972457] 0000:00:19.0: eth0: Intel(R) PRO/1000 Network Connection
[    0.972525] 0000:00:19.0: eth0: MAC: 6, PHY: 6, PBA No: ffffff-0ff
[    0.972655]   alloc irq_desc for 23 on node 0
[    0.972657]   alloc kstat_irqs on node 0
[    0.972663] ehci_hcd 0000:00:1d.7: PCI INT A -> GSI 23 (level, low) -> IRQ 23
[    0.972728] ehci_hcd 0000:00:1d.7: setting latency timer to 64
[    0.972731] ehci_hcd 0000:00:1d.7: EHCI Host Controller
[    0.972820] ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 2
[    0.976784] ehci_hcd 0000:00:1d.7: debug port 1
[    0.976831] ehci_hcd 0000:00:1d.7: cache line size of 32 is not supported
[    0.976845] ehci_hcd 0000:00:1d.7: irq 23, io mem 0x90221800
[    1.000014] ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00
[    1.000089] usb usb2: New USB device found, idVendor=1d6b, idProduct=0002
[    1.000141] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.000210] usb usb2: Product: EHCI Host Controller
[    1.000267] usb usb2: Manufacturer: Linux 2.6.31-rc2 ehci_hcd
[    1.000313] usb usb2: SerialNumber: 0000:00:1d.7
[    1.000395] usb usb2: configuration #1 chosen from 1 choice
[    1.000465] hub 2-0:1.0: USB hub found
[    1.000511] hub 2-0:1.0: 6 ports detected
[    1.000653] uhci_hcd 0000:00:1a.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
[    1.000708] uhci_hcd 0000:00:1a.0: setting latency timer to 64
[    1.000710] uhci_hcd 0000:00:1a.0: UHCI Host Controller
[    1.000779] uhci_hcd 0000:00:1a.0: new USB bus registered, assigned bus number 3
[    1.000868] uhci_hcd 0000:00:1a.0: irq 16, io base 0x000020c0
[    1.000940] usb usb3: New USB device found, idVendor=1d6b, idProduct=0001
[    1.000990] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.001055] usb usb3: Product: UHCI Host Controller
[    1.001102] usb usb3: Manufacturer: Linux 2.6.31-rc2 uhci_hcd
[    1.001149] usb usb3: SerialNumber: 0000:00:1a.0
[    1.003021] usb usb3: configuration #1 chosen from 1 choice
[    1.003089] hub 3-0:1.0: USB hub found
[    1.003134] hub 3-0:1.0: 2 ports detected
[    1.003669] ahci 0000:00:1f.2: version 3.0
[    1.003677]   alloc irq_desc for 19 on node 0
[    1.003679]   alloc kstat_irqs on node 0
[    1.003682] ahci 0000:00:1f.2: PCI INT A -> GSI 19 (level, low) -> IRQ 19
[    1.003752]   alloc irq_desc for 28 on node 0
[    1.003754]   alloc kstat_irqs on node 0
[    1.003760] ahci 0000:00:1f.2: irq 28 for MSI/MSI-X
[    1.003817] ahci 0000:00:1f.2: AHCI 0001.0100 32 slots 4 ports 3 Gbps 0x33 impl SATA mode
[    1.003885] ahci 0000:00:1f.2: flags: 64bit ncq sntf led clo pio slum part ems 
[    1.003950] ahci 0000:00:1f.2: setting latency timer to 64
[    1.077600] Uniform Multi-Platform E-IDE driver
[    1.079279] scsi2 : ahci
[    1.079377] scsi3 : ahci
[    1.079459] scsi4 : ahci
[    1.079542] scsi5 : ahci
[    1.079623] scsi6 : ahci
[    1.079705] scsi7 : ahci
[    1.079836] ata3: SATA max UDMA/133 abar m2048@0x90221000 port 0x90221100 irq 28
[    1.079902] ata4: SATA max UDMA/133 abar m2048@0x90221000 port 0x90221180 irq 28
[    1.079968] ata5: DUMMY
[    1.080031] ata6: DUMMY
[    1.080070] ata7: SATA max UDMA/133 abar m2048@0x90221000 port 0x90221300 irq 28
[    1.080135] ata8: SATA max UDMA/133 abar m2048@0x90221000 port 0x90221380 irq 28
[    1.080267]   alloc irq_desc for 21 on node 0
[    1.080269]   alloc kstat_irqs on node 0
[    1.080274] uhci_hcd 0000:00:1a.1: PCI INT B -> GSI 21 (level, low) -> IRQ 21
[    1.080328] uhci_hcd 0000:00:1a.1: setting latency timer to 64
[    1.080330] uhci_hcd 0000:00:1a.1: UHCI Host Controller
[    1.080408] uhci_hcd 0000:00:1a.1: new USB bus registered, assigned bus number 4
[    1.080498] uhci_hcd 0000:00:1a.1: irq 21, io base 0x000020a0
[    1.080574] usb usb4: New USB device found, idVendor=1d6b, idProduct=0001
[    1.080623] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.080687] usb usb4: Product: UHCI Host Controller
[    1.080730] usb usb4: Manufacturer: Linux 2.6.31-rc2 uhci_hcd
[    1.080776] usb usb4: SerialNumber: 0000:00:1a.1
[    1.080857] usb usb4: configuration #1 chosen from 1 choice
[    1.080924] hub 4-0:1.0: USB hub found
[    1.080969] hub 4-0:1.0: 2 ports detected
[    1.091560] uhci_hcd 0000:00:1d.0: PCI INT A -> GSI 23 (level, low) -> IRQ 23
[    1.091620] uhci_hcd 0000:00:1d.0: setting latency timer to 64
[    1.091623] uhci_hcd 0000:00:1d.0: UHCI Host Controller
[    1.091725] uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 5
[    1.091813] uhci_hcd 0000:00:1d.0: irq 23, io base 0x00002080
[    1.091892] usb usb5: New USB device found, idVendor=1d6b, idProduct=0001
[    1.091942] usb usb5: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.092015] usb usb5: Product: UHCI Host Controller
[    1.092063] usb usb5: Manufacturer: Linux 2.6.31-rc2 uhci_hcd
[    1.092111] usb usb5: SerialNumber: 0000:00:1d.0
[    1.092195] usb usb5: configuration #1 chosen from 1 choice
[    1.092263] hub 5-0:1.0: USB hub found
[    1.092308] hub 5-0:1.0: 2 ports detected
[    1.093544] uhci_hcd 0000:00:1d.1: PCI INT B -> GSI 19 (level, low) -> IRQ 19
[    1.093597] uhci_hcd 0000:00:1d.1: setting latency timer to 64
[    1.093600] uhci_hcd 0000:00:1d.1: UHCI Host Controller
[    1.093676] uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 6
[    1.093770] uhci_hcd 0000:00:1d.1: irq 19, io base 0x00002060
[    1.093841] usb usb6: New USB device found, idVendor=1d6b, idProduct=0001
[    1.093890] usb usb6: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.093954] usb usb6: Product: UHCI Host Controller
[    1.093999] usb usb6: Manufacturer: Linux 2.6.31-rc2 uhci_hcd
[    1.094045] usb usb6: SerialNumber: 0000:00:1d.1
[    1.094127] usb usb6: configuration #1 chosen from 1 choice
[    1.094194] hub 6-0:1.0: USB hub found
[    1.094238] hub 6-0:1.0: 2 ports detected
[    1.095008] uhci_hcd 0000:00:1d.2: PCI INT C -> GSI 18 (level, low) -> IRQ 18
[    1.095061] uhci_hcd 0000:00:1d.2: setting latency timer to 64
[    1.095063] uhci_hcd 0000:00:1d.2: UHCI Host Controller
[    1.095133] uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 7
[    1.095217] uhci_hcd 0000:00:1d.2: irq 18, io base 0x00002040
[    1.095290] usb usb7: New USB device found, idVendor=1d6b, idProduct=0001
[    1.095338] usb usb7: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.095402] usb usb7: Product: UHCI Host Controller
[    1.095446] usb usb7: Manufacturer: Linux 2.6.31-rc2 uhci_hcd
[    1.095492] usb usb7: SerialNumber: 0000:00:1d.2
[    1.095569] usb usb7: configuration #1 chosen from 1 choice
[    1.095636] hub 7-0:1.0: USB hub found
[    1.095680] hub 7-0:1.0: 2 ports detected
[    1.420018] ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    1.420088] ata4: SATA link down (SStatus 0 SControl 300)
[    1.441264] ata7: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    1.441326] ata8: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    1.482914] ata8.00: ATA-7: ST3400620NS, 3.AEG, max UDMA/133
[    1.482966] ata8.00: 781422768 sectors, multi 0: LBA48 NCQ (depth 31/32)
[    1.483987] ata7.00: ATA-7: ST3400620NS, 3.AEG, max UDMA/133
[    1.484037] ata7.00: 781422768 sectors, multi 0: LBA48 NCQ (depth 31/32)
[    1.502388] ata3.00: ATA-8: WDC WD2502ABYS-01B7A0, 02.03B02, max UDMA/133
[    1.502441] ata3.00: 490350672 sectors, multi 0: LBA48 NCQ (depth 31/32)
[    1.503432] ata3.00: configured for UDMA/133
[    1.503570] scsi 2:0:0:0: Direct-Access     ATA      WDC WD2502ABYS-0 02.0 PQ: 0 ANSI: 5
[    1.541250] ata8.00: configured for UDMA/133
[    1.541305] ata8: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0xf t4
[    1.541356] ata8: irq_stat 0x00400040, connection status changed
[    1.541411] ata8: hard resetting link
[    1.542323] ata7.00: configured for UDMA/133
[    1.542375] ata7: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0xf t4
[    1.542426] ata7: irq_stat 0x00400040, connection status changed
[    1.542480] ata7: hard resetting link
[    2.290078] ata7: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    2.290150] ata8: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    2.382595] ata8.00: configured for UDMA/133
[    2.382642] ata8: EH complete
[    2.383662] ata7.00: configured for UDMA/133
[    2.383709] ata7: EH complete
[    2.383818] scsi 6:0:0:0: Direct-Access     ATA      ST3400620NS      3.AE PQ: 0 ANSI: 5
[    2.384005] scsi 7:0:0:0: Direct-Access     ATA      ST3400620NS      3.AE PQ: 0 ANSI: 5
[    2.421253] sd 2:0:0:0: [sda] 490350672 512-byte logical blocks: (251 GB/233 GiB)
[    2.421314] sd 6:0:0:0: [sdb] 781422768 512-byte logical blocks: (400 GB/372 GiB)
[    2.421346] sd 6:0:0:0: [sdb] Write Protect is off
[    2.421348] sd 6:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[    2.421363] sd 6:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    2.421463]  sdb:
[    2.421499] sd 7:0:0:0: [sdc] 781422768 512-byte logical blocks: (400 GB/372 GiB)
[    2.421528] sd 7:0:0:0: [sdc] Write Protect is off
[    2.421530] sd 7:0:0:0: [sdc] Mode Sense: 00 3a 00 00
[    2.421545] sd 7:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    2.421622]  sdc:
[    2.421788] sd 2:0:0:0: [sda] Write Protect is off
[    2.421869] sd 2:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    2.421886] sd 2:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    2.422039]  sda: sda1 sda2
[    2.427375] sd 2:0:0:0: [sda] Attached SCSI disk
[    2.438898]  sdc1
[    2.439150] sd 7:0:0:0: [sdc] Attached SCSI disk
[    2.439955]  sdb1
[    2.440185] sd 6:0:0:0: [sdb] Attached SCSI disk
[    2.547890] md: raid1 personality registered for level 1
[    2.552779] md: md0 stopped.
[    2.571716] md: bind<sdc1>
[    2.571886] md: bind<sdb1>
[    2.579854] raid1: raid set md0 active with 2 out of 2 mirrors
[    2.580090]  md0: unknown partition table
[    2.643969] device-mapper: uevent: version 1.0.3
[    2.644289] device-mapper: ioctl: 4.15.0-ioctl (2009-04-01) initialised: dm-devel@redhat.com
[   11.829365] kjournald starting.  Commit interval 5 seconds
[   11.829421] EXT3-fs: mounted filesystem with ordered data mode.
[   14.574275] udevd version 125 started
[   15.041305] agpgart-intel 0000:00:00.0: Intel G35 Chipset
[   15.042207] agpgart-intel 0000:00:00.0: detected 7676K stolen memory
[   15.044931] agpgart-intel 0000:00:00.0: AGP aperture is 256M @ 0x80000000
[   15.060761] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input2
[   15.060833] ACPI: Power Button [PWRF]
[   15.060924] input: Sleep Button as /devices/LNXSYSTM:00/device:00/PNP0C0E:00/input/input3
[   15.060995] ACPI: Sleep Button [SLPB]
[   15.074500] processor LNXCPU:00: registered as cooling_device0
[   15.074551] ACPI: Processor [CPU0] (supports 8 throttling states)
[   15.076557] processor LNXCPU:01: registered as cooling_device1
[   15.076614] ACPI: Processor [CPU1] (supports 8 throttling states)
[   15.181004] iTCO_wdt: Intel TCO WatchDog Timer Driver v1.05
[   15.181128] iTCO_wdt: Found a ICH8 or ICH8R TCO device (Version=2, TCOBASE=0x0460)
[   15.181240] iTCO_wdt: initialized. heartbeat=30 sec (nowayout=0)
[   15.269147] i801_smbus 0000:00:1f.3: PCI INT B -> GSI 21 (level, low) -> IRQ 21
[   15.310514] Platform driver 'pcspkr' needs updating - please use dev_pm_ops
[   15.310619] input: PC Speaker as /devices/platform/pcspkr/input/input4
[   15.410688] Platform driver 'pcspkr' needs updating - please use dev_pm_ops
[   15.410746] Error: Driver 'pcspkr' is already registered, aborting...
[   17.554175] EXT3 FS on dm-0, internal journal
[   18.419761] loop: module loaded
[   18.851198] fuse init (API version 7.12)
[   18.933746] kjournald starting.  Commit interval 5 seconds
[   18.933976] EXT3 FS on sda1, internal journal
[   18.934039] EXT3-fs: mounted filesystem with ordered data mode.
[   20.180290] e1000e 0000:00:19.0: irq 27 for MSI/MSI-X
[   20.240048] e1000e 0000:00:19.0: irq 27 for MSI/MSI-X
[   20.240335] ADDRCONF(NETDEV_UP): eth0: link is not ready
[   22.901486] e1000e: eth0 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX/TX
[   22.901818] ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
[   33.530004] eth0: no IPv6 routers present

--------------020801040501030802010903
Content-Type: text/plain;
 name="lspci-2.6.31-rc2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="lspci-2.6.31-rc2"

00:00.0 Host bridge [0600]: Intel Corporation 82G35 Express DRAM Controller [8086:2980] (rev 03)
00:02.0 VGA compatible controller [0300]: Intel Corporation 82G35 Express Integrated Graphics Controller [8086:2982] (rev 03)
00:02.1 Display controller [0380]: Intel Corporation 82G35 Express Integrated Graphics Controller [8086:2983] (rev 03)
00:19.0 Ethernet controller [0200]: Intel Corporation 82566DC Gigabit Network Connection [8086:104b] (rev 02)
00:1a.0 USB Controller [0c03]: Intel Corporation 82801H (ICH8 Family) USB UHCI Controller #4 [8086:2834] (rev 02)
00:1a.1 USB Controller [0c03]: Intel Corporation 82801H (ICH8 Family) USB UHCI Controller #5 [8086:2835] (rev 02)
00:1a.7 USB Controller [0c03]: Intel Corporation 82801H (ICH8 Family) USB2 EHCI Controller #2 [8086:283a] (rev 02)
00:1c.0 PCI bridge [0604]: Intel Corporation 82801H (ICH8 Family) PCI Express Port 1 [8086:283f] (rev 02)
00:1c.1 PCI bridge [0604]: Intel Corporation 82801H (ICH8 Family) PCI Express Port 2 [8086:2841] (rev 02)
00:1c.2 PCI bridge [0604]: Intel Corporation 82801H (ICH8 Family) PCI Express Port 3 [8086:2843] (rev 02)
00:1d.0 USB Controller [0c03]: Intel Corporation 82801H (ICH8 Family) USB UHCI Controller #1 [8086:2830] (rev 02)
00:1d.1 USB Controller [0c03]: Intel Corporation 82801H (ICH8 Family) USB UHCI Controller #2 [8086:2831] (rev 02)
00:1d.2 USB Controller [0c03]: Intel Corporation 82801H (ICH8 Family) USB UHCI Controller #3 [8086:2832] (rev 02)
00:1d.7 USB Controller [0c03]: Intel Corporation 82801H (ICH8 Family) USB2 EHCI Controller #1 [8086:2836] (rev 02)
00:1e.0 PCI bridge [0604]: Intel Corporation 82801 PCI Bridge [8086:244e] (rev f2)
00:1f.0 ISA bridge [0601]: Intel Corporation 82801HB/HR (ICH8/R) LPC Interface Controller [8086:2810] (rev 02)
00:1f.2 SATA controller [0106]: Intel Corporation 82801HB (ICH8) 4 port SATA AHCI Controller [8086:2824] (rev 02)
00:1f.3 SMBus [0c05]: Intel Corporation 82801H (ICH8 Family) SMBus Controller [8086:283e] (rev 02)
03:00.0 IDE interface [0101]: JMicron Technology Corp. JMB368 IDE controller [197b:2368]

--------------020801040501030802010903--
