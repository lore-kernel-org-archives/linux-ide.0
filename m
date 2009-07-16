From: Zdenek Kaspar <zkaspar82@gmail.com>
Subject: Re: AHCI: connection status changed + hard resetting link with 2.6.30+
Date: Thu, 16 Jul 2009 15:47:21 +0200
Message-ID: <4A5F2F69.2050800@gmail.com>
References: <4A4FD162.30604@gmail.com> <4A552185.7090301@kernel.org> <4A5546AA.8000404@gmail.com> <4A5D981F.9020404@kernel.org> <4A5DAD7E.8050309@gmail.com> <4A5EA2DD.7000905@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------070107020604080304090602"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.152]:47412 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757065AbZGPNr1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 16 Jul 2009 09:47:27 -0400
Received: by fg-out-1718.google.com with SMTP id e12so1095508fga.17
        for <linux-ide@vger.kernel.org>; Thu, 16 Jul 2009 06:47:26 -0700 (PDT)
In-Reply-To: <4A5EA2DD.7000905@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------070107020604080304090602
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit

Tejun Heo napsal(a):
> Zdenek Kaspar wrote:
>> Tejun Heo napsal(a):
>>> Zdenek Kaspar wrote:
>>>> Hello Tejun, thanks for your reply. Attaching logs from my testing machine..
>>>>
>>>> I see this behavior on ICH7R with i3000 chipset too:
>>>> 00:1f.2 RAID bus controller [0104]: Intel Corporation 82801GR/GH (ICH7
>>>> Family) SATA RAID Controller [8086:27c3] (rev 01)
>>> Can you please apply the attached patch and report the resulting boot
>>> log?  Thanks.
> 
> Can you please try the attached patch?
> 
> Thanks.

Now it's fine. Thanks & attaching dmesg..

--------------070107020604080304090602
Content-Type: text/plain;
 name="dmesg-2.6.31-rc3"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg-2.6.31-rc3"

[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Linux version 2.6.31-rc3 (root@merkur) (gcc version 4.3.2 (Debian 4.3.2-1.1) ) #1 SMP Thu Jul 16 14:59:08 CEST 2009
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
[    0.000000] RAMDISK: 37854000 - 37fef79e
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
[    0.000000]   #3 [0037854000 - 0037fef79e]          RAMDISK ==> [0037854000 - 0037fef79e]
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
[    0.000000] Detected 2387.987 MHz processor.
[    0.002333] Console: colour VGA+ 80x25
[    0.002335] console [tty0] enabled
[    0.007354] hpet clockevent registered
[    0.007356] HPET: 3 timers in total, 0 timers will be used for per-cpu timer
[    0.007408] Calibrating delay loop (skipped), value calculated using timer frequency.. 4775.97 BogoMIPS (lpj=23879870)
[    0.007533] Security Framework initialized
[    0.007578] SELinux:  Disabled at boot.
[    0.007778] Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
[    0.008927] Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes)
[    0.009468] Mount-cache hash table entries: 256
[    0.009636] Initializing cgroup subsys ns
[    0.009682] Initializing cgroup subsys cpuacct
[    0.009726] Initializing cgroup subsys devices
[    0.009769] Initializing cgroup subsys freezer
[    0.009812] Initializing cgroup subsys net_cls
[    0.009873] CPU: L1 I cache: 32K, L1 D cache: 32K
[    0.009934] CPU: L2 cache: 4096K
[    0.009976] CPU 0/0x0 -> Node 0
[    0.010000] CPU: Physical Processor ID: 0
[    0.010000] CPU: Processor Core ID: 0
[    0.010000] mce: CPU supports 6 MCE banks
[    0.010000] CPU0: Thermal monitoring enabled (TM2)
[    0.010000] using mwait in idle threads.
[    0.010000] ACPI: Core revision 20090521
[    0.011461] Setting APIC routing to flat
[    0.011804] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.114031] CPU0: Intel(R) Core(TM)2 CPU          6600  @ 2.40GHz stepping 06
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
[    0.271221] CPU1: Intel(R) Core(TM)2 CPU          6600  @ 2.40GHz stepping 06
[    0.271740] checking TSC synchronization [CPU#0 -> CPU#1]: passed.
[    0.280019] Brought up 2 CPUs
[    0.280060] Total of 2 processors activated (9551.99 BogoMIPS).
[    0.280183] regulator: core version 0.5
[    0.280183] NET: Registered protocol family 16
[    0.280183] ACPI: bus type pci registered
[    0.280183] PCI: MCFG configuration 0: base f0000000 segment 0 buses 0 - 127
[    0.280183] PCI: Not using MMCONFIG.
[    0.280183] PCI: Using configuration type 1 for base access
[    0.280184] bio: create slab <bio-0> at 0
[    0.280440] ACPI: EC: Look up EC in DSDT
[    0.283365] ACPI: Interpreter enabled
[    0.283408] ACPI: (supports S0 S1 S3 S4 S5)
[    0.283555] ACPI: Using IOAPIC for interrupt routing
[    0.283632] PCI: MCFG configuration 0: base f0000000 segment 0 buses 0 - 127
[    0.284326] PCI: MCFG area at f0000000 reserved in ACPI motherboard resources
[    0.292821] PCI: Using MMCONFIG at f0000000 - f7ffffff
[    0.292874] ACPI: No dock devices found.
[    0.292874] ACPI: PCI Root Bridge [PCI0] (0000:00)
[    0.292874] pci 0000:00:02.0: reg 10 32bit mmio: [0x90100000-0x901fffff]
[    0.292874] pci 0000:00:02.0: reg 18 64bit mmio: [0x80000000-0x8fffffff]
[    0.292874] pci 0000:00:02.0: reg 20 io port: [0x2410-0x2417]
[    0.292874] pci 0000:00:02.1: reg 10 32bit mmio: [0x90000000-0x900fffff]
[    0.292874] pci 0000:00:19.0: reg 10 32bit mmio: [0x90200000-0x9021ffff]
[    0.292874] pci 0000:00:19.0: reg 14 32bit mmio: [0x90220000-0x90220fff]
[    0.292874] pci 0000:00:19.0: reg 18 io port: [0x20e0-0x20ff]
[    0.292874] pci 0000:00:19.0: PME# supported from D0 D3hot D3cold
[    0.292874] pci 0000:00:19.0: PME# disabled
[    0.292874] pci 0000:00:1a.0: reg 20 io port: [0x20c0-0x20df]
[    0.292874] pci 0000:00:1a.1: reg 20 io port: [0x20a0-0x20bf]
[    0.292874] pci 0000:00:1a.7: reg 10 32bit mmio: [0x90221c00-0x90221fff]
[    0.292874] pci 0000:00:1a.7: PME# supported from D0 D3hot D3cold
[    0.292874] pci 0000:00:1a.7: PME# disabled
[    0.292874] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    0.292874] pci 0000:00:1c.0: PME# disabled
[    0.292874] pci 0000:00:1c.1: PME# supported from D0 D3hot D3cold
[    0.292874] pci 0000:00:1c.1: PME# disabled
[    0.292874] pci 0000:00:1c.2: PME# supported from D0 D3hot D3cold
[    0.292874] pci 0000:00:1c.2: PME# disabled
[    0.292874] pci 0000:00:1d.0: reg 20 io port: [0x2080-0x209f]
[    0.292874] pci 0000:00:1d.1: reg 20 io port: [0x2060-0x207f]
[    0.292874] pci 0000:00:1d.2: reg 20 io port: [0x2040-0x205f]
[    0.292874] pci 0000:00:1d.7: reg 10 32bit mmio: [0x90221800-0x90221bff]
[    0.292874] pci 0000:00:1d.7: PME# supported from D0 D3hot D3cold
[    0.292874] pci 0000:00:1d.7: PME# disabled
[    0.292874] pci 0000:00:1f.0: quirk: region 0400-047f claimed by ICH6 ACPI/GPIO/TCO
[    0.300003] pci 0000:00:1f.0: quirk: region 0500-053f claimed by ICH6 GPIO
[    0.300052] pci 0000:00:1f.0: ICH7 LPC Generic IO decode 1 PIO at 0680 (mask 007f)
[    0.300167] pci 0000:00:1f.2: reg 10 io port: [0x2408-0x240f]
[    0.300172] pci 0000:00:1f.2: reg 14 io port: [0x241c-0x241f]
[    0.300176] pci 0000:00:1f.2: reg 18 io port: [0x2400-0x2407]
[    0.300181] pci 0000:00:1f.2: reg 1c io port: [0x2418-0x241b]
[    0.300186] pci 0000:00:1f.2: reg 20 io port: [0x2020-0x203f]
[    0.300191] pci 0000:00:1f.2: reg 24 32bit mmio: [0x90221000-0x902217ff]
[    0.300214] pci 0000:00:1f.2: PME# supported from D3hot
[    0.300260] pci 0000:00:1f.2: PME# disabled
[    0.300321] pci 0000:00:1f.3: reg 10 32bit mmio: [0x90222000-0x902220ff]
[    0.300335] pci 0000:00:1f.3: reg 20 io port: [0x2000-0x201f]
[    0.300481] pci 0000:03:00.0: reg 10 io port: [0x1018-0x101f]
[    0.300489] pci 0000:03:00.0: reg 14 io port: [0x1024-0x1027]
[    0.300497] pci 0000:03:00.0: reg 18 io port: [0x1010-0x1017]
[    0.300505] pci 0000:03:00.0: reg 1c io port: [0x1020-0x1023]
[    0.300514] pci 0000:03:00.0: reg 20 io port: [0x1000-0x100f]
[    0.300529] pci 0000:03:00.0: reg 30 32bit mmio: [0xffff0000-0xffffffff]
[    0.300607] pci 0000:00:1c.2: bridge io port: [0x1000-0x1fff]
[    0.300655] pci 0000:00:1e.0: transparent bridge
[    0.300720] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[    0.300930] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P32_._PRT]
[    0.301013] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEX0._PRT]
[    0.301073] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEX1._PRT]
[    0.301132] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEX2._PRT]
[    0.301428] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 9 10 *11 12)
[    0.301428] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 7 9 10 11 12) *0, disabled.
[    0.301428] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 7 9 10 *11 12)
[    0.301428] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 7 9 *10 11 12)
[    0.301428] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 7 *9 10 11 12)
[    0.301682] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 7 9 *10 11 12)
[    0.301993] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 7 9 10 11 12) *0, disabled.
[    0.302355] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 7 *9 10 11 12)
[    0.302619] usbcore: registered new interface driver usbfs
[    0.302619] usbcore: registered new interface driver hub
[    0.302619] usbcore: registered new device driver usb
[    0.310017] PCI: Using ACPI for IRQ routing
[    0.330032] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
[    0.330159] hpet0: 3 comparators, 64-bit 14.318180 MHz counter
[    0.360045] pnp: PnP ACPI init
[    0.360100] ACPI: bus type pnp registered
[    0.362584] pnp: PnP ACPI: found 11 devices
[    0.362627] ACPI: ACPI bus type pnp unregistered
[    0.362676] system 00:01: iomem range 0xf0000000-0xf7ffffff has been reserved
[    0.362726] system 00:01: iomem range 0xfed13000-0xfed13fff has been reserved
[    0.362775] system 00:01: iomem range 0xfed14000-0xfed17fff has been reserved
[    0.362824] system 00:01: iomem range 0xfed18000-0xfed18fff has been reserved
[    0.362874] system 00:01: iomem range 0xfed19000-0xfed19fff has been reserved
[    0.362923] system 00:01: iomem range 0xfed1c000-0xfed1ffff has been reserved
[    0.362972] system 00:01: iomem range 0xfed20000-0xfed3ffff has been reserved
[    0.363022] system 00:01: iomem range 0xfed45000-0xfed99fff has been reserved
[    0.363071] system 00:01: iomem range 0xc0000-0xdffff has been reserved
[    0.363119] system 00:01: iomem range 0xe0000-0xfffff could not be reserved
[    0.363172] system 00:06: ioport range 0x500-0x53f has been reserved
[    0.363219] system 00:06: ioport range 0x400-0x47f has been reserved
[    0.363267] system 00:06: ioport range 0x360-0x361 has been reserved
[    0.363315] system 00:06: ioport range 0x680-0x6ff has been reserved
[    0.368306] pci 0000:03:00.0: BAR 6: no parent found for of device [0xffff0000-0xffffffff]
[    0.368399] pci 0000:00:1c.0: PCI bridge, secondary bus 0000:01
[    0.368445] pci 0000:00:1c.0:   IO window: disabled
[    0.368491] pci 0000:00:1c.0:   MEM window: disabled
[    0.368536] pci 0000:00:1c.0:   PREFETCH window: disabled
[    0.368582] pci 0000:00:1c.1: PCI bridge, secondary bus 0000:02
[    0.368628] pci 0000:00:1c.1:   IO window: disabled
[    0.368674] pci 0000:00:1c.1:   MEM window: disabled
[    0.368719] pci 0000:00:1c.1:   PREFETCH window: disabled
[    0.368766] pci 0000:00:1c.2: PCI bridge, secondary bus 0000:03
[    0.368813] pci 0000:00:1c.2:   IO window: 0x1000-0x1fff
[    0.368860] pci 0000:00:1c.2:   MEM window: disabled
[    0.368905] pci 0000:00:1c.2:   PREFETCH window: 0x90300000-0x903fffff
[    0.368954] pci 0000:00:1e.0: PCI bridge, secondary bus 0000:04
[    0.369000] pci 0000:00:1e.0:   IO window: disabled
[    0.369046] pci 0000:00:1e.0:   MEM window: disabled
[    0.369091] pci 0000:00:1e.0:   PREFETCH window: disabled
[    0.369143]   alloc irq_desc for 17 on node 0
[    0.369145]   alloc kstat_irqs on node 0
[    0.369149] pci 0000:00:1c.0: PCI INT A -> GSI 17 (level, low) -> IRQ 17
[    0.369198] pci 0000:00:1c.0: setting latency timer to 64
[    0.369204]   alloc irq_desc for 16 on node 0
[    0.369205]   alloc kstat_irqs on node 0
[    0.369208] pci 0000:00:1c.1: PCI INT B -> GSI 16 (level, low) -> IRQ 16
[    0.369257] pci 0000:00:1c.1: setting latency timer to 64
[    0.369263]   alloc irq_desc for 18 on node 0
[    0.369264]   alloc kstat_irqs on node 0
[    0.369267] pci 0000:00:1c.2: PCI INT C -> GSI 18 (level, low) -> IRQ 18
[    0.369316] pci 0000:00:1c.2: setting latency timer to 64
[    0.369321] pci 0000:00:1e.0: setting latency timer to 64
[    0.369324] pci_bus 0000:00: resource 0 io:  [0x00-0xffff]
[    0.369326] pci_bus 0000:00: resource 1 mem: [0x000000-0xffffffffffffffff]
[    0.369329] pci_bus 0000:03: resource 0 io:  [0x1000-0x1fff]
[    0.369331] pci_bus 0000:03: resource 2 pref mem [0x90300000-0x903fffff]
[    0.369333] pci_bus 0000:04: resource 3 io:  [0x00-0xffff]
[    0.369335] pci_bus 0000:04: resource 4 mem: [0x000000-0xffffffffffffffff]
[    0.369376] NET: Registered protocol family 2
[    0.369527] IP route cache hash table entries: 65536 (order: 7, 524288 bytes)
[    0.370190] TCP established hash table entries: 262144 (order: 10, 4194304 bytes)
[    0.371755] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[    0.372329] TCP: Hash tables configured (established 262144 bind 65536)
[    0.372377] TCP reno registered
[    0.372541] NET: Registered protocol family 1
[    0.372638] Trying to unpack rootfs image as initramfs...
[    0.501876] Switched to high resolution mode on CPU 1
[    0.510055] Switched to high resolution mode on CPU 0
[    0.555978] Freeing initrd memory: 7789k freed
[    0.559653] audit: initializing netlink socket (disabled)
[    0.559720] type=2000 audit(1247757645.551:1): initialized
[    0.559988] HugeTLB registered 2 MB page size, pre-allocated 0 pages
[    0.560174] VFS: Disk quotas dquot_6.5.2
[    0.560241] Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    0.560336] msgmni has been set to 4008
[    0.560514] alg: No test for stdrng (krng)
[    0.560603] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 253)
[    0.560668] io scheduler noop registered
[    0.560710] io scheduler anticipatory registered
[    0.560753] io scheduler deadline registered (default)
[    0.560807] io scheduler cfq registered
[    0.560860] pci 0000:00:02.0: Boot video device
[    0.561300]   alloc irq_desc for 24 on node 0
[    0.561302]   alloc kstat_irqs on node 0
[    0.561311] pcieport-driver 0000:00:1c.0: irq 24 for MSI/MSI-X
[    0.561318] pcieport-driver 0000:00:1c.0: setting latency timer to 64
[    0.561502]   alloc irq_desc for 25 on node 0
[    0.561503]   alloc kstat_irqs on node 0
[    0.561509] pcieport-driver 0000:00:1c.1: irq 25 for MSI/MSI-X
[    0.561516] pcieport-driver 0000:00:1c.1: setting latency timer to 64
[    0.561695]   alloc irq_desc for 26 on node 0
[    0.561696]   alloc kstat_irqs on node 0
[    0.561702] pcieport-driver 0000:00:1c.2: irq 26 for MSI/MSI-X
[    0.561708] pcieport-driver 0000:00:1c.2: setting latency timer to 64
[    0.564657] Linux agpgart interface v0.103
[    0.564702] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    0.564860] serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[    0.565077] Platform driver 'serial8250' needs updating - please use dev_pm_ops
[    0.565378] 00:08: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[    0.567027] brd: module loaded
[    0.567129] input: Macintosh mouse button emulation as /devices/virtual/input/input0
[    0.567361] PNP: PS/2 Controller [PNP0303:PS2K] at 0x60,0x64 irq 1
[    0.567408] PNP: PS/2 appears to have AUX port disabled, if this is incorrect please boot with i8042.nopnp
[    0.567486] Platform driver 'i8042' needs updating - please use dev_pm_ops
[    0.568047] serio: i8042 KBD port at 0x60,0x64 irq 1
[    0.568217] mice: PS/2 mouse device common for all mice
[    0.568310] rtc_cmos 00:03: RTC can wake from S4
[    0.568400] rtc_cmos 00:03: rtc core: registered rtc_cmos as rtc0
[    0.568466] rtc0: alarms up to one month, 114 bytes nvram, hpet irqs
[    0.568541] cpuidle: using governor ladder
[    0.568584] cpuidle: using governor menu
[    0.568628] No iBFT detected.
[    0.568914] TCP cubic registered
[    0.568986] NET: Registered protocol family 10
[    0.569388] lo: Disabled Privacy Extensions
[    0.569645] Mobile IPv6
[    0.569685] NET: Registered protocol family 17
[    0.569850] registered taskstats version 1
[    0.570037] rtc_cmos 00:03: setting system clock to 2009-07-16 15:20:46 UTC (1247757646)
[    0.570155] Freeing unused kernel memory: 512k freed
[    0.594472] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input1
[    0.680674] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    0.681666] uhci_hcd: USB Universal Host Controller Interface driver
[    0.691294] e1000e: Intel(R) PRO/1000 Network Driver - 1.0.2-k2
[    0.691352] e1000e: Copyright (c) 1999-2008 Intel Corporation.
[    0.697480] ehci_hcd 0000:00:1a.7: PCI INT C -> GSI 18 (level, low) -> IRQ 18
[    0.697555] ehci_hcd 0000:00:1a.7: setting latency timer to 64
[    0.697558] ehci_hcd 0000:00:1a.7: EHCI Host Controller
[    0.697664] ehci_hcd 0000:00:1a.7: new USB bus registered, assigned bus number 1
[    0.701660] ehci_hcd 0000:00:1a.7: debug port 1
[    0.701708] ehci_hcd 0000:00:1a.7: cache line size of 32 is not supported
[    0.701725] ehci_hcd 0000:00:1a.7: irq 18, io mem 0x90221c00
[    0.730043] ehci_hcd 0000:00:1a.7: USB 2.0 started, EHCI 1.00
[    0.730117] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
[    0.730165] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    0.730229] usb usb1: Product: EHCI Host Controller
[    0.730273] usb usb1: Manufacturer: Linux 2.6.31-rc3 ehci_hcd
[    0.730318] usb usb1: SerialNumber: 0000:00:1a.7
[    0.730417] usb usb1: configuration #1 chosen from 1 choice
[    0.730489] hub 1-0:1.0: USB hub found
[    0.730535] hub 1-0:1.0: 4 ports detected
[    0.730666] uhci_hcd 0000:00:1a.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
[    0.730727] uhci_hcd 0000:00:1a.0: setting latency timer to 64
[    0.730731] uhci_hcd 0000:00:1a.0: UHCI Host Controller
[    0.730813] uhci_hcd 0000:00:1a.0: new USB bus registered, assigned bus number 2
[    0.730915] uhci_hcd 0000:00:1a.0: irq 16, io base 0x000020c0
[    0.730994] usb usb2: New USB device found, idVendor=1d6b, idProduct=0001
[    0.731044] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    0.731112] usb usb2: Product: UHCI Host Controller
[    0.731158] usb usb2: Manufacturer: Linux 2.6.31-rc3 uhci_hcd
[    0.731206] usb usb2: SerialNumber: 0000:00:1a.0
[    0.731293] usb usb2: configuration #1 chosen from 1 choice
[    0.731367] hub 2-0:1.0: USB hub found
[    0.731421] hub 2-0:1.0: 2 ports detected
[    0.731549]   alloc irq_desc for 20 on node 0
[    0.731551]   alloc kstat_irqs on node 0
[    0.731557] e1000e 0000:00:19.0: PCI INT A -> GSI 20 (level, low) -> IRQ 20
[    0.731610] e1000e 0000:00:19.0: setting latency timer to 64
[    0.731676]   alloc irq_desc for 27 on node 0
[    0.731677]   alloc kstat_irqs on node 0
[    0.731685] e1000e 0000:00:19.0: irq 27 for MSI/MSI-X
[    0.746539] SCSI subsystem initialized
[    0.804628] libata version 3.00 loaded.
[    0.831392] pata_jmicron 0000:03:00.0: PCI INT A -> GSI 18 (level, low) -> IRQ 18
[    0.831485] pata_jmicron 0000:03:00.0: setting latency timer to 64
[    0.831522] scsi0 : pata_jmicron
[    0.831633] scsi1 : pata_jmicron
[    0.832190] ata1: PATA max UDMA/100 cmd 0x1018 ctl 0x1024 bmdma 0x1000 irq 18
[    0.832239] ata2: PATA max UDMA/100 cmd 0x1010 ctl 0x1020 bmdma 0x1008 irq 18
[    1.003677] 0000:00:19.0: eth0: (PCI Express:2.5GB/s:Width x1) 00:1c:c0:5a:d8:ba
[    1.003745] 0000:00:19.0: eth0: Intel(R) PRO/1000 Network Connection
[    1.003813] 0000:00:19.0: eth0: MAC: 6, PHY: 6, PBA No: ffffff-0ff
[    1.003935]   alloc irq_desc for 23 on node 0
[    1.003937]   alloc kstat_irqs on node 0
[    1.003943] ehci_hcd 0000:00:1d.7: PCI INT A -> GSI 23 (level, low) -> IRQ 23
[    1.004009] ehci_hcd 0000:00:1d.7: setting latency timer to 64
[    1.004012] ehci_hcd 0000:00:1d.7: EHCI Host Controller
[    1.004107] ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 3
[    1.008060] ehci_hcd 0000:00:1d.7: debug port 1
[    1.008106] ehci_hcd 0000:00:1d.7: cache line size of 32 is not supported
[    1.008119] ehci_hcd 0000:00:1d.7: irq 23, io mem 0x90221800
[    1.040047] ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00
[    1.040120] usb usb3: New USB device found, idVendor=1d6b, idProduct=0002
[    1.040172] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.040241] usb usb3: Product: EHCI Host Controller
[    1.040299] usb usb3: Manufacturer: Linux 2.6.31-rc3 ehci_hcd
[    1.040344] usb usb3: SerialNumber: 0000:00:1d.7
[    1.040427] usb usb3: configuration #1 chosen from 1 choice
[    1.042287] hub 3-0:1.0: USB hub found
[    1.042332] hub 3-0:1.0: 6 ports detected
[    1.043051]   alloc irq_desc for 21 on node 0
[    1.043053]   alloc kstat_irqs on node 0
[    1.043057] uhci_hcd 0000:00:1a.1: PCI INT B -> GSI 21 (level, low) -> IRQ 21
[    1.043111] uhci_hcd 0000:00:1a.1: setting latency timer to 64
[    1.043114] uhci_hcd 0000:00:1a.1: UHCI Host Controller
[    1.043190] uhci_hcd 0000:00:1a.1: new USB bus registered, assigned bus number 4
[    1.043281] uhci_hcd 0000:00:1a.1: irq 21, io base 0x000020a0
[    1.043353] usb usb4: New USB device found, idVendor=1d6b, idProduct=0001
[    1.043402] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.043466] usb usb4: Product: UHCI Host Controller
[    1.043510] usb usb4: Manufacturer: Linux 2.6.31-rc3 uhci_hcd
[    1.043555] usb usb4: SerialNumber: 0000:00:1a.1
[    1.043633] usb usb4: configuration #1 chosen from 1 choice
[    1.043699] hub 4-0:1.0: USB hub found
[    1.043745] hub 4-0:1.0: 2 ports detected
[    1.044464] ahci 0000:00:1f.2: version 3.0
[    1.044472]   alloc irq_desc for 19 on node 0
[    1.044473]   alloc kstat_irqs on node 0
[    1.044477] ahci 0000:00:1f.2: PCI INT A -> GSI 19 (level, low) -> IRQ 19
[    1.044544]   alloc irq_desc for 28 on node 0
[    1.044546]   alloc kstat_irqs on node 0
[    1.044552] ahci 0000:00:1f.2: irq 28 for MSI/MSI-X
[    1.044606] ahci 0000:00:1f.2: AHCI 0001.0100 32 slots 4 ports 3 Gbps 0x33 impl SATA mode
[    1.044673] ahci 0000:00:1f.2: flags: 64bit ncq sntf led clo pio slum part ems 
[    1.044738] ahci 0000:00:1f.2: setting latency timer to 64
[    1.044784] ata4294967295: XXX port freeze
[    1.070056] ata4294967295: XXX port freeze
[    1.090047] ata4294967295: XXX port freeze
[    1.110046] ata4294967295: XXX port freeze
[    1.110132] scsi2 : ahci
[    1.110579] scsi3 : ahci
[    1.110978] scsi4 : ahci
[    1.111387] scsi5 : ahci
[    1.111816] scsi6 : ahci
[    1.112258] scsi7 : ahci
[    1.112404] ata3: SATA max UDMA/133 abar m2048@0x90221000 port 0x90221100 irq 28
[    1.112470] ata4: SATA max UDMA/133 abar m2048@0x90221000 port 0x90221180 irq 28
[    1.112534] ata5: DUMMY
[    1.112572] ata6: DUMMY
[    1.112611] ata7: SATA max UDMA/133 abar m2048@0x90221000 port 0x90221300 irq 28
[    1.112676] ata8: SATA max UDMA/133 abar m2048@0x90221000 port 0x90221380 irq 28
[    1.112784] ata3: XXX port freeze
[    1.112826] ata3: XXX hardresetting link, stopping engine
[    1.112871] ata3: XXX flipping SControl
[    1.113422] uhci_hcd 0000:00:1d.0: PCI INT A -> GSI 23 (level, low) -> IRQ 23
[    1.113479] uhci_hcd 0000:00:1d.0: setting latency timer to 64
[    1.113482] uhci_hcd 0000:00:1d.0: UHCI Host Controller
[    1.113570] uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 5
[    1.113660] uhci_hcd 0000:00:1d.0: irq 23, io base 0x00002080
[    1.113734] usb usb5: New USB device found, idVendor=1d6b, idProduct=0001
[    1.113782] usb usb5: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.113846] usb usb5: Product: UHCI Host Controller
[    1.113890] usb usb5: Manufacturer: Linux 2.6.31-rc3 uhci_hcd
[    1.113935] usb usb5: SerialNumber: 0000:00:1d.0
[    1.114017] usb usb5: configuration #1 chosen from 1 choice
[    1.114086] hub 5-0:1.0: USB hub found
[    1.114132] hub 5-0:1.0: 2 ports detected
[    1.115079] ata4: XXX port freeze
[    1.115089] uhci_hcd 0000:00:1d.1: PCI INT B -> GSI 19 (level, low) -> IRQ 19
[    1.115094] uhci_hcd 0000:00:1d.1: setting latency timer to 64
[    1.115097] uhci_hcd 0000:00:1d.1: UHCI Host Controller
[    1.115124] uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 6
[    1.115155] uhci_hcd 0000:00:1d.1: irq 19, io base 0x00002060
[    1.115187] usb usb6: New USB device found, idVendor=1d6b, idProduct=0001
[    1.115189] usb usb6: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.115191] usb usb6: Product: UHCI Host Controller
[    1.115192] usb usb6: Manufacturer: Linux 2.6.31-rc3 uhci_hcd
[    1.115193] usb usb6: SerialNumber: 0000:00:1d.1
[    1.115229] usb usb6: configuration #1 chosen from 1 choice
[    1.115251] hub 6-0:1.0: USB hub found
[    1.115256] hub 6-0:1.0: 2 ports detected
[    1.115709] ata4: XXX hardresetting link, stopping engine
[    1.115755] ata4: XXX flipping SControl
[    1.116221] uhci_hcd 0000:00:1d.2: PCI INT C -> GSI 18 (level, low) -> IRQ 18
[    1.116273] uhci_hcd 0000:00:1d.2: setting latency timer to 64
[    1.116275] uhci_hcd 0000:00:1d.2: UHCI Host Controller
[    1.116346] uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 7
[    1.116430] uhci_hcd 0000:00:1d.2: irq 18, io base 0x00002040
[    1.116501] usb usb7: New USB device found, idVendor=1d6b, idProduct=0001
[    1.116549] usb usb7: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.116613] usb usb7: Product: UHCI Host Controller
[    1.116656] usb usb7: Manufacturer: Linux 2.6.31-rc3 uhci_hcd
[    1.116703] usb usb7: SerialNumber: 0000:00:1d.2
[    1.116779] usb usb7: configuration #1 chosen from 1 choice
[    1.116845] hub 7-0:1.0: USB hub found
[    1.116890] hub 7-0:1.0: 2 ports detected
[    1.118292] ata7: XXX port freeze
[    1.118333] ata7: XXX hardresetting link, stopping engine
[    1.118379] ata7: XXX flipping SControl
[    1.118431] ata8: XXX port freeze
[    1.118471] ata8: XXX hardresetting link, stopping engine
[    1.118516] ata8: XXX flipping SControl
[    1.460029] ata7: XXX starting engine
[    1.460076] ata7: XXX rc=0, class=1
[    1.460121] ata7: XXX clearing IRQs for thawing
[    1.460168] ata7: XXX port thawed
[    1.460216] ata7: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    1.460220] ata3: XXX irq_stat=400040 CONN|PHY
[    1.460225] ata3: XXX port freeze
[    1.460229] ata8: XXX irq_stat=400040 CONN|PHY
[    1.460232] ata8: XXX port freeze
[    1.460449] ata3: XXX starting engine
[    1.460491] ata3: XXX rc=0, class=1
[    1.460533] ata3: XXX clearing IRQs for thawing
[    1.460576] ata3: XXX port thawed
[    1.460618] ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    1.460669] ata8: XXX starting engine
[    1.460711] ata8: XXX rc=0, class=1
[    1.460753] ata8: XXX clearing IRQs for thawing
[    1.460796] ata8: XXX port thawed
[    1.460838] ata8: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    1.460888] ata4: XXX starting engine
[    1.460930] ata4: XXX rc=0, class=0
[    1.460972] ata4: XXX clearing IRQs for thawing
[    1.461015] ata4: XXX port thawed
[    1.461057] ata4: SATA link down (SStatus 0 SControl 300)
[    1.461464] ata3.00: ATA-8: WDC WD2502ABYS-01B7A0, 02.03B02, max UDMA/133
[    1.461518] ata3.00: 490350672 sectors, multi 0: LBA48 NCQ (depth 31/32)
[    1.462516] ata3.00: configured for UDMA/133
[    1.462656] scsi 2:0:0:0: Direct-Access     ATA      WDC WD2502ABYS-0 02.0 PQ: 0 ANSI: 5
[    1.502066] ata8.00: ATA-7: ST3400620NS, 3.AEG, max UDMA/133
[    1.502117] ata8.00: 781422768 sectors, multi 0: LBA48 NCQ (depth 31/32)
[    1.504056] ata7.00: ATA-7: ST3400620NS, 3.AEG, max UDMA/133
[    1.504106] ata7.00: 781422768 sectors, multi 0: LBA48 NCQ (depth 31/32)
[    1.560396] ata8.00: configured for UDMA/133
[    1.562387] ata7.00: configured for UDMA/133
[    1.562500] scsi 6:0:0:0: Direct-Access     ATA      ST3400620NS      3.AE PQ: 0 ANSI: 5
[    1.563770] scsi 7:0:0:0: Direct-Access     ATA      ST3400620NS      3.AE PQ: 0 ANSI: 5
[    1.571589] Uniform Multi-Platform E-IDE driver
[    1.620887] sd 2:0:0:0: [sda] 490350672 512-byte logical blocks: (251 GB/233 GiB)
[    1.620907] sd 6:0:0:0: [sdb] 781422768 512-byte logical blocks: (400 GB/372 GiB)
[    1.620938] sd 6:0:0:0: [sdb] Write Protect is off
[    1.620940] sd 6:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[    1.620955] sd 6:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    1.621048]  sdb:
[    1.621086] sd 7:0:0:0: [sdc] 781422768 512-byte logical blocks: (400 GB/372 GiB)
[    1.621115] sd 7:0:0:0: [sdc] Write Protect is off
[    1.621116] sd 7:0:0:0: [sdc] Mode Sense: 00 3a 00 00
[    1.621132] sd 7:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    1.621206]  sdc:
[    1.621439] sd 2:0:0:0: [sda] Write Protect is off
[    1.621520] sd 2:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    1.621536] sd 2:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    1.621687]  sda: sda1 sda2
[    1.624517] sd 2:0:0:0: [sda] Attached SCSI disk
[    1.635338]  sdb1
[    1.635584] sd 6:0:0:0: [sdb] Attached SCSI disk
[    1.641676]  sdc1
[    1.641914] sd 7:0:0:0: [sdc] Attached SCSI disk
[    1.840047] md: raid1 personality registered for level 1
[    1.845312] md: md0 stopped.
[    1.867200] md: bind<sdc1>
[    1.867388] md: bind<sdb1>
[    1.874205] raid1: raid set md0 active with 2 out of 2 mirrors
[    1.874431]  md0: unknown partition table
[    1.938631] device-mapper: uevent: version 1.0.3
[    1.939264] device-mapper: ioctl: 4.15.0-ioctl (2009-04-01) initialised: dm-devel@redhat.com
[   14.034251] kjournald starting.  Commit interval 5 seconds
[   14.034308] EXT3-fs: mounted filesystem with ordered data mode.
[   16.579017] udevd version 125 started
[   16.941351] agpgart-intel 0000:00:00.0: Intel G35 Chipset
[   16.942265] agpgart-intel 0000:00:00.0: detected 7676K stolen memory
[   16.945000] agpgart-intel 0000:00:00.0: AGP aperture is 256M @ 0x80000000
[   16.962856] processor LNXCPU:00: registered as cooling_device0
[   16.962907] ACPI: Processor [CPU0] (supports 8 throttling states)
[   16.963358] processor LNXCPU:01: registered as cooling_device1
[   16.963413] ACPI: Processor [CPU1] (supports 8 throttling states)
[   17.060546] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input2
[   17.060618] ACPI: Power Button [PWRF]
[   17.060708] input: Sleep Button as /devices/LNXSYSTM:00/device:00/PNP0C0E:00/input/input3
[   17.060779] ACPI: Sleep Button [SLPB]
[   17.260941] iTCO_wdt: Intel TCO WatchDog Timer Driver v1.05
[   17.261057] iTCO_wdt: Found a ICH8 or ICH8R TCO device (Version=2, TCOBASE=0x0460)
[   17.261167] iTCO_wdt: initialized. heartbeat=30 sec (nowayout=0)
[   17.287483] Platform driver 'pcspkr' needs updating - please use dev_pm_ops
[   17.287587] input: PC Speaker as /devices/platform/pcspkr/input/input4
[   17.298842] i801_smbus 0000:00:1f.3: PCI INT B -> GSI 21 (level, low) -> IRQ 21
[   17.394722] Platform driver 'pcspkr' needs updating - please use dev_pm_ops
[   17.394778] Error: Driver 'pcspkr' is already registered, aborting...
[   19.500446] EXT3 FS on dm-0, internal journal
[   20.297221] loop: module loaded
[   20.703146] fuse init (API version 7.12)
[   20.821576] kjournald starting.  Commit interval 5 seconds
[   20.821785] EXT3 FS on sda1, internal journal
[   20.821855] EXT3-fs: mounted filesystem with ordered data mode.
[   22.110307] e1000e 0000:00:19.0: irq 27 for MSI/MSI-X
[   22.170083] e1000e 0000:00:19.0: irq 27 for MSI/MSI-X
[   22.170427] ADDRCONF(NETDEV_UP): eth0: link is not ready
[   24.801500] e1000e: eth0 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX/TX
[   24.801798] ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
[   34.810006] eth0: no IPv6 routers present
[  186.481402] RPC: Registered udp transport module.
[  186.481457] RPC: Registered tcp transport module.
[  186.583756] Slow work thread pool: Starting up
[  186.584122] Slow work thread pool: Ready
[  186.584193] FS-Cache: Loaded
[  186.662044] FS-Cache: Netfs 'nfs' registered for caching
[  186.663999] svc: failed to register lockdv1 RPC service (errno 97).

--------------070107020604080304090602--
