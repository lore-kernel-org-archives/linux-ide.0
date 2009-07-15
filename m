From: Zdenek Kaspar <zkaspar82@gmail.com>
Subject: Re: AHCI: connection status changed + hard resetting link with 2.6.30+
Date: Wed, 15 Jul 2009 12:20:46 +0200
Message-ID: <4A5DAD7E.8050309@gmail.com>
References: <4A4FD162.30604@gmail.com> <4A552185.7090301@kernel.org> <4A5546AA.8000404@gmail.com> <4A5D981F.9020404@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060104080600010302050306"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.158]:27751 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752525AbZGOKUw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 15 Jul 2009 06:20:52 -0400
Received: by fg-out-1718.google.com with SMTP id e12so835096fga.17
        for <linux-ide@vger.kernel.org>; Wed, 15 Jul 2009 03:20:50 -0700 (PDT)
In-Reply-To: <4A5D981F.9020404@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------060104080600010302050306
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit

Tejun Heo napsal(a):
> Zdenek Kaspar wrote:
>> Hello Tejun, thanks for your reply. Attaching logs from my testing machine..
>>
>> I see this behavior on ICH7R with i3000 chipset too:
>> 00:1f.2 RAID bus controller [0104]: Intel Corporation 82801GR/GH (ICH7
>> Family) SATA RAID Controller [8086:27c3] (rev 01)
> 
> Can you please apply the attached patch and report the resulting boot
> log?  Thanks.

logs from 2.6.31-rc3

Z.

--------------060104080600010302050306
Content-Type: text/plain;
 name="dmesg-2.6.31-rc3"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg-2.6.31-rc3"

[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Linux version 2.6.31-rc3 (root@merkur) (gcc version 4.3.2 (Debian 4.3.2-1.1) ) #1 SMP Wed Jul 15 11:41:02 CEST 2009
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
[    0.000000] RAMDISK: 37854000 - 37fef8e0
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
[    0.000000]   #3 [0037854000 - 0037fef8e0]          RAMDISK ==> [0037854000 - 0037fef8e0]
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
[    0.000000] PERCPU: Embedded 25 pages at ffff880001534000, static data 72864 bytes
[    0.000000] Built 1 zonelists in Node order, mobility grouping on.  Total pages: 514423
[    0.000000] Policy zone: DMA32
[    0.000000] Kernel command line: root=/dev/mapper/sda2_crypt ro 
[    0.000000] PID hash table entries: 4096 (order: 12, 32768 bytes)
[    0.000000] Initializing CPU#0
[    0.000000] Checking aperture...
[    0.000000] No AGP bridge found
[    0.000000] Calgary: detecting Calgary via BIOS EBDA area
[    0.000000] Calgary: Unable to locate Rio Grande table in EBDA - bailing!
[    0.000000] Memory: 2044360k/2087936k available (2790k kernel code, 1284k absent, 42292k reserved, 1375k data, 512k init)
[    0.000000] Hierarchical RCU implementation.
[    0.000000] NR_IRQS:4352 nr_irqs:440
[    0.000000] Fast TSC calibration using PIT
[    0.000000] Detected 2388.099 MHz processor.
[    0.002347] Console: colour VGA+ 80x25
[    0.002349] console [tty0] enabled
[    0.007382] hpet clockevent registered
[    0.007385] HPET: 3 timers in total, 0 timers will be used for per-cpu timer
[    0.007436] Calibrating delay loop (skipped), value calculated using timer frequency.. 4776.19 BogoMIPS (lpj=23880990)
[    0.007563] Security Framework initialized
[    0.007608] SELinux:  Disabled at boot.
[    0.007807] Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
[    0.008969] Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes)
[    0.009516] Mount-cache hash table entries: 256
[    0.009685] Initializing cgroup subsys ns
[    0.009730] Initializing cgroup subsys cpuacct
[    0.009774] Initializing cgroup subsys devices
[    0.009818] Initializing cgroup subsys freezer
[    0.009860] Initializing cgroup subsys net_cls
[    0.009921] CPU: L1 I cache: 32K, L1 D cache: 32K
[    0.009982] CPU: L2 cache: 4096K
[    0.010000] CPU 0/0x0 -> Node 0
[    0.010000] CPU: Physical Processor ID: 0
[    0.010000] CPU: Processor Core ID: 0
[    0.010000] mce: CPU supports 6 MCE banks
[    0.010000] CPU0: Thermal monitoring enabled (TM2)
[    0.010000] using mwait in idle threads.
[    0.010000] ACPI: Core revision 20090521
[    0.011492] Setting APIC routing to flat
[    0.011837] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.111909] CPU0: Intel(R) Core(TM)2 CPU          6600  @ 2.40GHz stepping 06
[    0.120000] Booting processor 1 APIC 0x1 ip 0x6000
[    0.010000] Initializing CPU#1
[    0.010000] Calibrating delay using timer specific routine.. 4776.01 BogoMIPS (lpj=23880088)
[    0.010000] CPU: L1 I cache: 32K, L1 D cache: 32K
[    0.010000] CPU: L2 cache: 4096K
[    0.010000] CPU 1/0x1 -> Node 0
[    0.010000] CPU: Physical Processor ID: 0
[    0.010000] CPU: Processor Core ID: 1
[    0.010000] mce: CPU supports 6 MCE banks
[    0.010000] CPU1: Thermal monitoring enabled (TM2)
[    0.010000] x86 PAT enabled: cpu 1, old 0x7040600070406, new 0x7010600070106
[    0.271245] CPU1: Intel(R) Core(TM)2 CPU          6600  @ 2.40GHz stepping 06
[    0.271765] checking TSC synchronization [CPU#0 -> CPU#1]: passed.
[    0.280023] Brought up 2 CPUs
[    0.280064] Total of 2 processors activated (9552.21 BogoMIPS).
[    0.280185] regulator: core version 0.5
[    0.280185] NET: Registered protocol family 16
[    0.280185] ACPI: bus type pci registered
[    0.280185] PCI: MCFG configuration 0: base f0000000 segment 0 buses 0 - 127
[    0.280185] PCI: Not using MMCONFIG.
[    0.280185] PCI: Using configuration type 1 for base access
[    0.280185] bio: create slab <bio-0> at 0
[    0.280440] ACPI: EC: Look up EC in DSDT
[    0.283373] ACPI: Interpreter enabled
[    0.283416] ACPI: (supports S0 S1 S3 S4 S5)
[    0.283564] ACPI: Using IOAPIC for interrupt routing
[    0.283640] PCI: MCFG configuration 0: base f0000000 segment 0 buses 0 - 127
[    0.284334] PCI: MCFG area at f0000000 reserved in ACPI motherboard resources
[    0.292653] PCI: Using MMCONFIG at f0000000 - f7ffffff
[    0.292707] ACPI: No dock devices found.
[    0.292707] ACPI: PCI Root Bridge [PCI0] (0000:00)
[    0.292707] pci 0000:00:02.0: reg 10 32bit mmio: [0x90100000-0x901fffff]
[    0.292707] pci 0000:00:02.0: reg 18 64bit mmio: [0x80000000-0x8fffffff]
[    0.292707] pci 0000:00:02.0: reg 20 io port: [0x2410-0x2417]
[    0.292707] pci 0000:00:02.1: reg 10 32bit mmio: [0x90000000-0x900fffff]
[    0.292707] pci 0000:00:19.0: reg 10 32bit mmio: [0x90200000-0x9021ffff]
[    0.292707] pci 0000:00:19.0: reg 14 32bit mmio: [0x90220000-0x90220fff]
[    0.292707] pci 0000:00:19.0: reg 18 io port: [0x20e0-0x20ff]
[    0.292707] pci 0000:00:19.0: PME# supported from D0 D3hot D3cold
[    0.292707] pci 0000:00:19.0: PME# disabled
[    0.292707] pci 0000:00:1a.0: reg 20 io port: [0x20c0-0x20df]
[    0.292707] pci 0000:00:1a.1: reg 20 io port: [0x20a0-0x20bf]
[    0.292707] pci 0000:00:1a.7: reg 10 32bit mmio: [0x90221c00-0x90221fff]
[    0.292707] pci 0000:00:1a.7: PME# supported from D0 D3hot D3cold
[    0.292707] pci 0000:00:1a.7: PME# disabled
[    0.292707] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    0.292707] pci 0000:00:1c.0: PME# disabled
[    0.292707] pci 0000:00:1c.1: PME# supported from D0 D3hot D3cold
[    0.292707] pci 0000:00:1c.1: PME# disabled
[    0.292707] pci 0000:00:1c.2: PME# supported from D0 D3hot D3cold
[    0.292707] pci 0000:00:1c.2: PME# disabled
[    0.292707] pci 0000:00:1d.0: reg 20 io port: [0x2080-0x209f]
[    0.292707] pci 0000:00:1d.1: reg 20 io port: [0x2060-0x207f]
[    0.292707] pci 0000:00:1d.2: reg 20 io port: [0x2040-0x205f]
[    0.292707] pci 0000:00:1d.7: reg 10 32bit mmio: [0x90221800-0x90221bff]
[    0.292707] pci 0000:00:1d.7: PME# supported from D0 D3hot D3cold
[    0.292707] pci 0000:00:1d.7: PME# disabled
[    0.292707] pci 0000:00:1f.0: quirk: region 0400-047f claimed by ICH6 ACPI/GPIO/TCO
[    0.300003] pci 0000:00:1f.0: quirk: region 0500-053f claimed by ICH6 GPIO
[    0.300053] pci 0000:00:1f.0: ICH7 LPC Generic IO decode 1 PIO at 0680 (mask 007f)
[    0.300167] pci 0000:00:1f.2: reg 10 io port: [0x2408-0x240f]
[    0.300172] pci 0000:00:1f.2: reg 14 io port: [0x241c-0x241f]
[    0.300177] pci 0000:00:1f.2: reg 18 io port: [0x2400-0x2407]
[    0.300182] pci 0000:00:1f.2: reg 1c io port: [0x2418-0x241b]
[    0.300187] pci 0000:00:1f.2: reg 20 io port: [0x2020-0x203f]
[    0.300192] pci 0000:00:1f.2: reg 24 32bit mmio: [0x90221000-0x902217ff]
[    0.300215] pci 0000:00:1f.2: PME# supported from D3hot
[    0.300261] pci 0000:00:1f.2: PME# disabled
[    0.300322] pci 0000:00:1f.3: reg 10 32bit mmio: [0x90222000-0x902220ff]
[    0.300337] pci 0000:00:1f.3: reg 20 io port: [0x2000-0x201f]
[    0.300478] pci 0000:03:00.0: reg 10 io port: [0x1018-0x101f]
[    0.300486] pci 0000:03:00.0: reg 14 io port: [0x1024-0x1027]
[    0.300495] pci 0000:03:00.0: reg 18 io port: [0x1010-0x1017]
[    0.300503] pci 0000:03:00.0: reg 1c io port: [0x1020-0x1023]
[    0.300511] pci 0000:03:00.0: reg 20 io port: [0x1000-0x100f]
[    0.300526] pci 0000:03:00.0: reg 30 32bit mmio: [0xffff0000-0xffffffff]
[    0.300603] pci 0000:00:1c.2: bridge io port: [0x1000-0x1fff]
[    0.300651] pci 0000:00:1e.0: transparent bridge
[    0.300716] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[    0.300926] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P32_._PRT]
[    0.301010] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEX0._PRT]
[    0.301071] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEX1._PRT]
[    0.301130] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEX2._PRT]
[    0.301426] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 9 10 *11 12)
[    0.301426] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 7 9 10 11 12) *0, disabled.
[    0.301426] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 7 9 10 *11 12)
[    0.301426] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 7 9 *10 11 12)
[    0.301426] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 7 *9 10 11 12)
[    0.301684] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 7 9 *10 11 12)
[    0.301996] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 7 9 10 11 12) *0, disabled.
[    0.302359] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 7 *9 10 11 12)
[    0.302624] usbcore: registered new interface driver usbfs
[    0.302624] usbcore: registered new interface driver hub
[    0.302624] usbcore: registered new device driver usb
[    0.302624] PCI: Using ACPI for IRQ routing
[    0.330031] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
[    0.330158] hpet0: 3 comparators, 64-bit 14.318180 MHz counter
[    0.360046] pnp: PnP ACPI init
[    0.360101] ACPI: bus type pnp registered
[    0.362582] pnp: PnP ACPI: found 11 devices
[    0.362625] ACPI: ACPI bus type pnp unregistered
[    0.362674] system 00:01: iomem range 0xf0000000-0xf7ffffff has been reserved
[    0.362724] system 00:01: iomem range 0xfed13000-0xfed13fff has been reserved
[    0.362774] system 00:01: iomem range 0xfed14000-0xfed17fff has been reserved
[    0.362823] system 00:01: iomem range 0xfed18000-0xfed18fff has been reserved
[    0.362872] system 00:01: iomem range 0xfed19000-0xfed19fff has been reserved
[    0.362922] system 00:01: iomem range 0xfed1c000-0xfed1ffff has been reserved
[    0.362971] system 00:01: iomem range 0xfed20000-0xfed3ffff has been reserved
[    0.363021] system 00:01: iomem range 0xfed45000-0xfed99fff has been reserved
[    0.363070] system 00:01: iomem range 0xc0000-0xdffff has been reserved
[    0.363119] system 00:01: iomem range 0xe0000-0xfffff could not be reserved
[    0.363171] system 00:06: ioport range 0x500-0x53f has been reserved
[    0.363219] system 00:06: ioport range 0x400-0x47f has been reserved
[    0.363266] system 00:06: ioport range 0x360-0x361 has been reserved
[    0.363314] system 00:06: ioport range 0x680-0x6ff has been reserved
[    0.368310] pci 0000:03:00.0: BAR 6: no parent found for of device [0xffff0000-0xffffffff]
[    0.368403] pci 0000:00:1c.0: PCI bridge, secondary bus 0000:01
[    0.368449] pci 0000:00:1c.0:   IO window: disabled
[    0.368495] pci 0000:00:1c.0:   MEM window: disabled
[    0.368541] pci 0000:00:1c.0:   PREFETCH window: disabled
[    0.368587] pci 0000:00:1c.1: PCI bridge, secondary bus 0000:02
[    0.368634] pci 0000:00:1c.1:   IO window: disabled
[    0.368680] pci 0000:00:1c.1:   MEM window: disabled
[    0.368725] pci 0000:00:1c.1:   PREFETCH window: disabled
[    0.368772] pci 0000:00:1c.2: PCI bridge, secondary bus 0000:03
[    0.368819] pci 0000:00:1c.2:   IO window: 0x1000-0x1fff
[    0.368866] pci 0000:00:1c.2:   MEM window: disabled
[    0.368912] pci 0000:00:1c.2:   PREFETCH window: 0x90300000-0x903fffff
[    0.368961] pci 0000:00:1e.0: PCI bridge, secondary bus 0000:04
[    0.369007] pci 0000:00:1e.0:   IO window: disabled
[    0.369053] pci 0000:00:1e.0:   MEM window: disabled
[    0.369098] pci 0000:00:1e.0:   PREFETCH window: disabled
[    0.369150]   alloc irq_desc for 17 on node 0
[    0.369152]   alloc kstat_irqs on node 0
[    0.369156] pci 0000:00:1c.0: PCI INT A -> GSI 17 (level, low) -> IRQ 17
[    0.369206] pci 0000:00:1c.0: setting latency timer to 64
[    0.369211]   alloc irq_desc for 16 on node 0
[    0.369213]   alloc kstat_irqs on node 0
[    0.369216] pci 0000:00:1c.1: PCI INT B -> GSI 16 (level, low) -> IRQ 16
[    0.369265] pci 0000:00:1c.1: setting latency timer to 64
[    0.369271]   alloc irq_desc for 18 on node 0
[    0.369272]   alloc kstat_irqs on node 0
[    0.369275] pci 0000:00:1c.2: PCI INT C -> GSI 18 (level, low) -> IRQ 18
[    0.369324] pci 0000:00:1c.2: setting latency timer to 64
[    0.369329] pci 0000:00:1e.0: setting latency timer to 64
[    0.369332] pci_bus 0000:00: resource 0 io:  [0x00-0xffff]
[    0.369334] pci_bus 0000:00: resource 1 mem: [0x000000-0xffffffffffffffff]
[    0.369337] pci_bus 0000:03: resource 0 io:  [0x1000-0x1fff]
[    0.369339] pci_bus 0000:03: resource 2 pref mem [0x90300000-0x903fffff]
[    0.369341] pci_bus 0000:04: resource 3 io:  [0x00-0xffff]
[    0.369343] pci_bus 0000:04: resource 4 mem: [0x000000-0xffffffffffffffff]
[    0.369386] NET: Registered protocol family 2
[    0.369537] IP route cache hash table entries: 65536 (order: 7, 524288 bytes)
[    0.370202] TCP established hash table entries: 262144 (order: 10, 4194304 bytes)
[    0.371779] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[    0.372356] TCP: Hash tables configured (established 262144 bind 65536)
[    0.372405] TCP reno registered
[    0.372572] NET: Registered protocol family 1
[    0.372671] Trying to unpack rootfs image as initramfs...
[    0.501898] Switched to high resolution mode on CPU 1
[    0.510049] Switched to high resolution mode on CPU 0
[    0.553381] Freeing initrd memory: 7790k freed
[    0.557046] audit: initializing netlink socket (disabled)
[    0.557114] type=2000 audit(1247659922.551:1): initialized
[    0.557381] HugeTLB registered 2 MB page size, pre-allocated 0 pages
[    0.557522] VFS: Disk quotas dquot_6.5.2
[    0.557589] Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    0.557686] msgmni has been set to 4008
[    0.557861] alg: No test for stdrng (krng)
[    0.557950] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 253)
[    0.558015] io scheduler noop registered
[    0.558057] io scheduler anticipatory registered
[    0.558100] io scheduler deadline registered (default)
[    0.558154] io scheduler cfq registered
[    0.558206] pci 0000:00:02.0: Boot video device
[    0.558642]   alloc irq_desc for 24 on node 0
[    0.558644]   alloc kstat_irqs on node 0
[    0.558655] pcieport-driver 0000:00:1c.0: irq 24 for MSI/MSI-X
[    0.558662] pcieport-driver 0000:00:1c.0: setting latency timer to 64
[    0.558838]   alloc irq_desc for 25 on node 0
[    0.558840]   alloc kstat_irqs on node 0
[    0.558846] pcieport-driver 0000:00:1c.1: irq 25 for MSI/MSI-X
[    0.558852] pcieport-driver 0000:00:1c.1: setting latency timer to 64
[    0.559023]   alloc irq_desc for 26 on node 0
[    0.559024]   alloc kstat_irqs on node 0
[    0.559030] pcieport-driver 0000:00:1c.2: irq 26 for MSI/MSI-X
[    0.559036] pcieport-driver 0000:00:1c.2: setting latency timer to 64
[    0.561942] Linux agpgart interface v0.103
[    0.561987] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    0.562145] serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[    0.562363] Platform driver 'serial8250' needs updating - please use dev_pm_ops
[    0.562666] 00:08: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[    0.564318] brd: module loaded
[    0.564419] input: Macintosh mouse button emulation as /devices/virtual/input/input0
[    0.564653] PNP: PS/2 Controller [PNP0303:PS2K] at 0x60,0x64 irq 1
[    0.564700] PNP: PS/2 appears to have AUX port disabled, if this is incorrect please boot with i8042.nopnp
[    0.564778] Platform driver 'i8042' needs updating - please use dev_pm_ops
[    0.565235] serio: i8042 KBD port at 0x60,0x64 irq 1
[    0.565404] mice: PS/2 mouse device common for all mice
[    0.565498] rtc_cmos 00:03: RTC can wake from S4
[    0.565587] rtc_cmos 00:03: rtc core: registered rtc_cmos as rtc0
[    0.565654] rtc0: alarms up to one month, 114 bytes nvram, hpet irqs
[    0.565729] cpuidle: using governor ladder
[    0.565772] cpuidle: using governor menu
[    0.565816] No iBFT detected.
[    0.566104] TCP cubic registered
[    0.566178] NET: Registered protocol family 10
[    0.566581] lo: Disabled Privacy Extensions
[    0.566839] Mobile IPv6
[    0.566878] NET: Registered protocol family 17
[    0.567044] registered taskstats version 1
[    0.567206] rtc_cmos 00:03: setting system clock to 2009-07-15 12:12:03 UTC (1247659923)
[    0.567324] Freeing unused kernel memory: 512k freed
[    0.593068] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input1
[    0.680043] e1000e: Intel(R) PRO/1000 Network Driver - 1.0.2-k2
[    0.680109] e1000e: Copyright (c) 1999-2008 Intel Corporation.
[    0.680204]   alloc irq_desc for 20 on node 0
[    0.680206]   alloc kstat_irqs on node 0
[    0.680213] e1000e 0000:00:19.0: PCI INT A -> GSI 20 (level, low) -> IRQ 20
[    0.680268] e1000e 0000:00:19.0: setting latency timer to 64
[    0.680329]   alloc irq_desc for 27 on node 0
[    0.680330]   alloc kstat_irqs on node 0
[    0.680338] e1000e 0000:00:19.0: irq 27 for MSI/MSI-X
[    0.720496] uhci_hcd: USB Universal Host Controller Interface driver
[    0.756400] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    0.756451] Warning! ehci_hcd should always be loaded before uhci_hcd and ohci_hcd, not after
[    0.787913] SCSI subsystem initialized
[    0.816276] libata version 3.00 loaded.
[    0.850533] pata_jmicron 0000:03:00.0: PCI INT A -> GSI 18 (level, low) -> IRQ 18
[    0.850626] pata_jmicron 0000:03:00.0: setting latency timer to 64
[    0.850675] scsi0 : pata_jmicron
[    0.850787] scsi1 : pata_jmicron
[    0.851339] ata1: PATA max UDMA/100 cmd 0x1018 ctl 0x1024 bmdma 0x1000 irq 18
[    0.851389] ata2: PATA max UDMA/100 cmd 0x1010 ctl 0x1020 bmdma 0x1008 irq 18
[    0.962535] 0000:00:19.0: eth0: (PCI Express:2.5GB/s:Width x1) 00:1c:c0:5a:d8:ba
[    0.962604] 0000:00:19.0: eth0: Intel(R) PRO/1000 Network Connection
[    0.962672] 0000:00:19.0: eth0: MAC: 6, PHY: 6, PBA No: ffffff-0ff
[    0.962773] uhci_hcd 0000:00:1a.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
[    0.962828] uhci_hcd 0000:00:1a.0: setting latency timer to 64
[    0.962831] uhci_hcd 0000:00:1a.0: UHCI Host Controller
[    0.962913] uhci_hcd 0000:00:1a.0: new USB bus registered, assigned bus number 1
[    0.963007] uhci_hcd 0000:00:1a.0: irq 16, io base 0x000020c0
[    0.963085] usb usb1: New USB device found, idVendor=1d6b, idProduct=0001
[    0.963133] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    0.963197] usb usb1: Product: UHCI Host Controller
[    0.963241] usb usb1: Manufacturer: Linux 2.6.31-rc3 uhci_hcd
[    0.963286] usb usb1: SerialNumber: 0000:00:1a.0
[    0.963367] usb usb1: configuration #1 chosen from 1 choice
[    0.963436] hub 1-0:1.0: USB hub found
[    0.963482] hub 1-0:1.0: 2 ports detected
[    0.963605] ehci_hcd 0000:00:1a.7: PCI INT C -> GSI 18 (level, low) -> IRQ 18
[    0.963668] ehci_hcd 0000:00:1a.7: setting latency timer to 64
[    0.963671] ehci_hcd 0000:00:1a.7: EHCI Host Controller
[    0.963738] ehci_hcd 0000:00:1a.7: new USB bus registered, assigned bus number 2
[    0.967697] ehci_hcd 0000:00:1a.7: debug port 1
[    0.967743] ehci_hcd 0000:00:1a.7: cache line size of 32 is not supported
[    0.967748] ehci_hcd 0000:00:1a.7: irq 18, io mem 0x90221c00
[    1.000064] ehci_hcd 0000:00:1a.7: USB 2.0 started, EHCI 1.00
[    1.000134] usb usb2: New USB device found, idVendor=1d6b, idProduct=0002
[    1.000187] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.000255] usb usb2: Product: EHCI Host Controller
[    1.000312] usb usb2: Manufacturer: Linux 2.6.31-rc3 ehci_hcd
[    1.000357] usb usb2: SerialNumber: 0000:00:1a.7
[    1.000436] usb usb2: configuration #1 chosen from 1 choice
[    1.000502] hub 2-0:1.0: USB hub found
[    1.000548] hub 2-0:1.0: 4 ports detected
[    1.000663] ahci 0000:00:1f.2: version 3.0
[    1.000672]   alloc irq_desc for 19 on node 0
[    1.000674]   alloc kstat_irqs on node 0
[    1.000678] ahci 0000:00:1f.2: PCI INT A -> GSI 19 (level, low) -> IRQ 19
[    1.000746]   alloc irq_desc for 28 on node 0
[    1.000748]   alloc kstat_irqs on node 0
[    1.000754] ahci 0000:00:1f.2: irq 28 for MSI/MSI-X
[    1.000807] ahci 0000:00:1f.2: AHCI 0001.0100 32 slots 4 ports 3 Gbps 0x33 impl SATA mode
[    1.000874] ahci 0000:00:1f.2: flags: 64bit ncq sntf led clo pio slum part ems 
[    1.000940] ahci 0000:00:1f.2: setting latency timer to 64
[    1.000987] ata4294967295: XXX port freeze
[    1.020055] ata4294967295: XXX port freeze
[    1.040061] ata4294967295: XXX port freeze
[    1.060082] ata4294967295: XXX port freeze
[    1.060168] scsi2 : ahci
[    1.060281] scsi3 : ahci
[    1.060375] scsi4 : ahci
[    1.062246] scsi5 : ahci
[    1.062329] scsi6 : ahci
[    1.062409] scsi7 : ahci
[    1.062552] ata3: SATA max UDMA/133 abar m2048@0x90221000 port 0x90221100 irq 28
[    1.062618] ata4: SATA max UDMA/133 abar m2048@0x90221000 port 0x90221180 irq 28
[    1.062682] ata5: DUMMY
[    1.062720] ata6: DUMMY
[    1.062759] ata7: SATA max UDMA/133 abar m2048@0x90221000 port 0x90221300 irq 28
[    1.062824] ata8: SATA max UDMA/133 abar m2048@0x90221000 port 0x90221380 irq 28
[    1.062948] ata4: XXX port freeze
[    1.062992] ata4: XXX hardresetting link, stopping engine
[    1.063038] ata4: XXX flipping SControl
[    1.063124] ata7: XXX port freeze
[    1.063164] ata7: XXX hardresetting link, stopping engine
[    1.063210] ata7: XXX flipping SControl
[    1.063265] ata8: XXX port freeze
[    1.063305] ata8: XXX hardresetting link, stopping engine
[    1.063352] ata8: XXX flipping SControl
[    1.064840]   alloc irq_desc for 21 on node 0
[    1.064842]   alloc kstat_irqs on node 0
[    1.064846] uhci_hcd 0000:00:1a.1: PCI INT B -> GSI 21 (level, low) -> IRQ 21
[    1.064903] uhci_hcd 0000:00:1a.1: setting latency timer to 64
[    1.064906] uhci_hcd 0000:00:1a.1: UHCI Host Controller
[    1.064997] uhci_hcd 0000:00:1a.1: new USB bus registered, assigned bus number 3
[    1.065094] uhci_hcd 0000:00:1a.1: irq 21, io base 0x000020a0
[    1.065167] usb usb3: New USB device found, idVendor=1d6b, idProduct=0001
[    1.065215] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.065279] usb usb3: Product: UHCI Host Controller
[    1.065323] usb usb3: Manufacturer: Linux 2.6.31-rc3 uhci_hcd
[    1.065368] usb usb3: SerialNumber: 0000:00:1a.1
[    1.065450] usb usb3: configuration #1 chosen from 1 choice
[    1.065517] hub 3-0:1.0: USB hub found
[    1.065562] hub 3-0:1.0: 2 ports detected
[    1.066385]   alloc irq_desc for 23 on node 0
[    1.066387]   alloc kstat_irqs on node 0
[    1.066391] ehci_hcd 0000:00:1d.7: PCI INT A -> GSI 23 (level, low) -> IRQ 23
[    1.066448] ehci_hcd 0000:00:1d.7: setting latency timer to 64
[    1.066451] ehci_hcd 0000:00:1d.7: EHCI Host Controller
[    1.066521] ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 4
[    1.070489] ehci_hcd 0000:00:1d.7: debug port 1
[    1.070536] ehci_hcd 0000:00:1d.7: cache line size of 32 is not supported
[    1.070547] ehci_hcd 0000:00:1d.7: irq 23, io mem 0x90221800
[    1.074659] ata3: XXX port freeze
[    1.074700] ata3: XXX hardresetting link, stopping engine
[    1.074746] ata3: XXX flipping SControl
[    1.090076] ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00
[    1.090142] usb usb4: New USB device found, idVendor=1d6b, idProduct=0002
[    1.090195] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.090263] usb usb4: Product: EHCI Host Controller
[    1.090319] usb usb4: Manufacturer: Linux 2.6.31-rc3 ehci_hcd
[    1.090364] usb usb4: SerialNumber: 0000:00:1d.7
[    1.090443] usb usb4: configuration #1 chosen from 1 choice
[    1.090511] hub 4-0:1.0: USB hub found
[    1.090556] hub 4-0:1.0: 6 ports detected
[    1.091483] uhci_hcd 0000:00:1d.0: PCI INT A -> GSI 23 (level, low) -> IRQ 23
[    1.091537] uhci_hcd 0000:00:1d.0: setting latency timer to 64
[    1.091540] uhci_hcd 0000:00:1d.0: UHCI Host Controller
[    1.091616] uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 5
[    1.091701] uhci_hcd 0000:00:1d.0: irq 23, io base 0x00002080
[    1.091772] usb usb5: New USB device found, idVendor=1d6b, idProduct=0001
[    1.091820] usb usb5: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.091884] usb usb5: Product: UHCI Host Controller
[    1.091928] usb usb5: Manufacturer: Linux 2.6.31-rc3 uhci_hcd
[    1.091974] usb usb5: SerialNumber: 0000:00:1d.0
[    1.092052] usb usb5: configuration #1 chosen from 1 choice
[    1.092118] hub 5-0:1.0: USB hub found
[    1.092165] hub 5-0:1.0: 2 ports detected
[    1.093093] uhci_hcd 0000:00:1d.1: PCI INT B -> GSI 19 (level, low) -> IRQ 19
[    1.093146] uhci_hcd 0000:00:1d.1: setting latency timer to 64
[    1.093148] uhci_hcd 0000:00:1d.1: UHCI Host Controller
[    1.093219] uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 6
[    1.093308] uhci_hcd 0000:00:1d.1: irq 19, io base 0x00002060
[    1.093380] usb usb6: New USB device found, idVendor=1d6b, idProduct=0001
[    1.093428] usb usb6: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.093492] usb usb6: Product: UHCI Host Controller
[    1.093536] usb usb6: Manufacturer: Linux 2.6.31-rc3 uhci_hcd
[    1.093582] usb usb6: SerialNumber: 0000:00:1d.1
[    1.093659] usb usb6: configuration #1 chosen from 1 choice
[    1.093725] hub 6-0:1.0: USB hub found
[    1.093770] hub 6-0:1.0: 2 ports detected
[    1.094745] uhci_hcd 0000:00:1d.2: PCI INT C -> GSI 18 (level, low) -> IRQ 18
[    1.094797] uhci_hcd 0000:00:1d.2: setting latency timer to 64
[    1.094800] uhci_hcd 0000:00:1d.2: UHCI Host Controller
[    1.094870] uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 7
[    1.094953] uhci_hcd 0000:00:1d.2: irq 18, io base 0x00002040
[    1.095025] usb usb7: New USB device found, idVendor=1d6b, idProduct=0001
[    1.095073] usb usb7: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.095137] usb usb7: Product: UHCI Host Controller
[    1.095181] usb usb7: Manufacturer: Linux 2.6.31-rc3 uhci_hcd
[    1.095226] usb usb7: SerialNumber: 0000:00:1d.2
[    1.095306] usb usb7: configuration #1 chosen from 1 choice
[    1.095372] hub 7-0:1.0: USB hub found
[    1.095418] hub 7-0:1.0: 2 ports detected
[    1.411279] ata8: XXX starting engine
[    1.411327] ata8: XXX rc=0, class=1
[    1.411372] ata8: XXX clearing IRQs for thawing
[    1.411419] ata8: XXX port thawed
[    1.411467] ata8: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    1.411471] ata3: XXX irq_stat=400040 CONN|PHY
[    1.411475] ata3: XXX port freeze
[    1.411480] ata7: XXX irq_stat=400040 CONN|PHY
[    1.411483] ata7: XXX port freeze
[    1.411701] ata4: XXX starting engine
[    1.411743] ata4: XXX rc=0, class=0
[    1.411785] ata4: XXX clearing IRQs for thawing
[    1.411828] ata4: XXX port thawed
[    1.411870] ata4: SATA link down (SStatus 0 SControl 300)
[    1.411921] ata7: XXX starting engine
[    1.411964] ata7: XXX rc=0, class=1
[    1.412006] ata7: XXX clearing IRQs for thawing
[    1.412049] ata7: XXX port thawed
[    1.412092] ata7: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    1.420049] ata3: XXX starting engine
[    1.420096] ata3: XXX rc=0, class=1
[    1.420142] ata3: XXX clearing IRQs for thawing
[    1.420188] ata3: XXX port thawed
[    1.420234] ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    1.453029] ata7.00: ATA-7: ST3400620NS, 3.AEG, max UDMA/133
[    1.453079] ata7.00: 781422768 sectors, multi 0: LBA48 NCQ (depth 31/32)
[    1.459401] ata8.00: ATA-7: ST3400620NS, 3.AEG, max UDMA/133
[    1.459451] ata8.00: 781422768 sectors, multi 0: LBA48 NCQ (depth 31/32)
[    1.496647] ata3.00: ATA-8: WDC WD2502ABYS-01B7A0, 02.03B02, max UDMA/133
[    1.496700] ata3.00: 490350672 sectors, multi 0: LBA48 NCQ (depth 31/32)
[    1.497695] ata3.00: configured for UDMA/133
[    1.497748] ata3: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0xf t4
[    1.497808] ata3: irq_stat 0x00400040, connection status changed
[    1.497857] ata3: XXX port freeze
[    1.497898] ata3: hard resetting link
[    1.497939] ata3: XXX hardresetting link, stopping engine
[    1.497984] ata3: XXX flipping SControl
[    1.511352] ata7.00: configured for UDMA/133
[    1.511403] ata7: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0xf t4
[    1.511454] ata7: irq_stat 0x00400040, connection status changed
[    1.511508] ata7: XXX port freeze
[    1.511561] ata7: hard resetting link
[    1.511601] ata7: XXX hardresetting link, stopping engine
[    1.511647] ata7: XXX flipping SControl
[    1.517725] ata8.00: configured for UDMA/133
[    2.250048] ata3: XXX starting engine
[    2.250094] ata3: XXX rc=0, class=1
[    2.250139] ata3: XXX clearing IRQs for thawing
[    2.250186] ata3: XXX port thawed
[    2.250232] ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    2.252466] ata3.00: configured for UDMA/133
[    2.252513] ata3: EH complete
[    2.252657] scsi 2:0:0:0: Direct-Access     ATA      WDC WD2502ABYS-0 02.0 PQ: 0 ANSI: 5
[    2.260110] ata7: XXX starting engine
[    2.260156] ata7: XXX rc=0, class=1
[    2.260201] ata7: XXX clearing IRQs for thawing
[    2.260248] ata7: XXX port thawed
[    2.260293] ata7: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    2.352600] ata7.00: configured for UDMA/133
[    2.352647] ata7: EH complete
[    2.352760] scsi 6:0:0:0: Direct-Access     ATA      ST3400620NS      3.AE PQ: 0 ANSI: 5
[    2.352948] scsi 7:0:0:0: Direct-Access     ATA      ST3400620NS      3.AE PQ: 0 ANSI: 5
[    2.360382] Uniform Multi-Platform E-IDE driver
[    2.415567] sd 2:0:0:0: [sda] 490350672 512-byte logical blocks: (251 GB/233 GiB)
[    2.415665] sd 2:0:0:0: [sda] Write Protect is off
[    2.415712] sd 2:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    2.415728] sd 2:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    2.415891]  sda:
[    2.415950] sd 6:0:0:0: [sdb] 781422768 512-byte logical blocks: (400 GB/372 GiB)
[    2.416076] sd 6:0:0:0: [sdb] Write Protect is off
[    2.416122] sd 6:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[    2.416138] sd 6:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    2.416281]  sdb:
[    2.416330] sd 7:0:0:0: [sdc] 781422768 512-byte logical blocks: (400 GB/372 GiB)
[    2.416455] sd 7:0:0:0: [sdc] Write Protect is off
[    2.416500] sd 7:0:0:0: [sdc] Mode Sense: 00 3a 00 00
[    2.416516] sd 7:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    2.418433]  sdc: sda1 sda2
[    2.421587] sd 2:0:0:0: [sda] Attached SCSI disk
[    2.431946]  sdc1
[    2.432196] sd 7:0:0:0: [sdc] Attached SCSI disk
[    2.433883]  sdb1
[    2.434126] sd 6:0:0:0: [sdb] Attached SCSI disk
[    2.628814] md: raid1 personality registered for level 1
[    2.634179] md: md0 stopped.
[    2.656893] md: bind<sdc1>
[    2.657136] md: bind<sdb1>
[    2.664053] raid1: raid set md0 active with 2 out of 2 mirrors
[    2.664220]  md0: unknown partition table
[    2.734343] device-mapper: uevent: version 1.0.3
[    2.734655] device-mapper: ioctl: 4.15.0-ioctl (2009-04-01) initialised: dm-devel@redhat.com
[   13.314171] kjournald starting.  Commit interval 5 seconds
[   13.314227] EXT3-fs: mounted filesystem with ordered data mode.
[   15.875488] udevd version 125 started
[   16.277158] agpgart-intel 0000:00:00.0: Intel G35 Chipset
[   16.278084] agpgart-intel 0000:00:00.0: detected 7676K stolen memory
[   16.280905] agpgart-intel 0000:00:00.0: AGP aperture is 256M @ 0x80000000
[   16.475037] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input2
[   16.475109] ACPI: Power Button [PWRF]
[   16.475201] input: Sleep Button as /devices/LNXSYSTM:00/device:00/PNP0C0E:00/input/input3
[   16.475271] ACPI: Sleep Button [SLPB]
[   16.500061] processor LNXCPU:00: registered as cooling_device0
[   16.500111] ACPI: Processor [CPU0] (supports 8 throttling states)
[   16.500279] processor LNXCPU:01: registered as cooling_device1
[   16.500328] ACPI: Processor [CPU1] (supports 8 throttling states)
[   16.510322] iTCO_wdt: Intel TCO WatchDog Timer Driver v1.05
[   16.510431] iTCO_wdt: Found a ICH8 or ICH8R TCO device (Version=2, TCOBASE=0x0460)
[   16.510547] iTCO_wdt: initialized. heartbeat=30 sec (nowayout=0)
[   16.565056] i801_smbus 0000:00:1f.3: PCI INT B -> GSI 21 (level, low) -> IRQ 21
[   16.701647] Platform driver 'pcspkr' needs updating - please use dev_pm_ops
[   16.701757] input: PC Speaker as /devices/platform/pcspkr/input/input4
[   16.714492] Platform driver 'pcspkr' needs updating - please use dev_pm_ops
[   16.714548] Error: Driver 'pcspkr' is already registered, aborting...
[   18.530220] EXT3 FS on dm-0, internal journal
[   19.325743] loop: module loaded
[   19.844067] fuse init (API version 7.12)
[   19.959518] kjournald starting.  Commit interval 5 seconds
[   19.959745] EXT3 FS on sda1, internal journal
[   19.959807] EXT3-fs: mounted filesystem with ordered data mode.
[   21.420319] e1000e 0000:00:19.0: irq 27 for MSI/MSI-X
[   21.480046] e1000e 0000:00:19.0: irq 27 for MSI/MSI-X
[   21.480391] ADDRCONF(NETDEV_UP): eth0: link is not ready
[   24.171501] e1000e: eth0 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX/TX
[   24.171811] ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
[   34.790006] eth0: no IPv6 routers present

--------------060104080600010302050306--
