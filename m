From: Patrick Voegeli Olivera <patrick.voegeli@gmail.com>
Subject: Re: Sata link_power_management_policy questions
Date: Tue, 23 Jun 2009 14:00:25 +0200
Message-ID: <4A40C3D9.7060602@gmail.com>
References: <4A3FD261.7060903@gmail.com> <4A40643B.7090805@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------020403090709060300030601"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ew0-f210.google.com ([209.85.219.210]:52193 "EHLO
	mail-ew0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752598AbZFWMA2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 23 Jun 2009 08:00:28 -0400
In-Reply-To: <4A40643B.7090805@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Cc: linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------020403090709060300030601
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Here they go,

I attach them as log files, since dmesg is quite long.


--------------020403090709060300030601
Content-Type: text/x-log;
 name="dmesg.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg.log"

[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Linux version 2.6.30-4 (root@patrick-laptop) (gcc version 4.3.3 (Ubuntu 4.3.3-5ubuntu4) ) #1 SMP Mon Jun 22 21:31:14 CEST 2009
[    0.000000] Command line: root=UUID=cfdbc761-596b-4edc-a3ec-a11daff9db1f ro quiet splash usbcore.autosuspend=0 pcie_aspm=force acpi_osi="Linux" resume=/dev/sda5 video.brightness_switch_enabled=0 
[    0.000000] KERNEL supported cpus:
[    0.000000]   Intel GenuineIntel
[    0.000000]   AMD AuthenticAMD
[    0.000000]   Centaur CentaurHauls
[    0.000000] BIOS-provided physical RAM map:
[    0.000000]  BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
[    0.000000]  BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
[    0.000000]  BIOS-e820: 00000000000dc000 - 0000000000100000 (reserved)
[    0.000000]  BIOS-e820: 0000000000100000 - 000000007f680000 (usable)
[    0.000000]  BIOS-e820: 000000007f680000 - 000000007f690000 (ACPI NVS)
[    0.000000]  BIOS-e820: 000000007f690000 - 0000000080000000 (reserved)
[    0.000000]  BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
[    0.000000]  BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
[    0.000000]  BIOS-e820: 00000000fed14000 - 00000000fed1a000 (reserved)
[    0.000000]  BIOS-e820: 00000000fed1c000 - 00000000fed90000 (reserved)
[    0.000000]  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
[    0.000000]  BIOS-e820: 00000000ff000000 - 0000000100000000 (reserved)
[    0.000000] DMI present.
[    0.000000] last_pfn = 0x7f680 max_arch_pfn = 0x100000000
[    0.000000] MTRR default type: uncachable
[    0.000000] MTRR fixed ranges enabled:
[    0.000000]   00000-9FFFF write-back
[    0.000000]   A0000-BFFFF uncachable
[    0.000000]   C0000-FFFFF write-protect
[    0.000000] MTRR variable ranges enabled:
[    0.000000]   0 base 000000000 mask F80000000 write-back
[    0.000000]   1 base 07F700000 mask FFFF00000 uncachable
[    0.000000]   2 base 07F800000 mask FFF800000 uncachable
[    0.000000]   3 disabled
[    0.000000]   4 disabled
[    0.000000]   5 disabled
[    0.000000]   6 disabled
[    0.000000]   7 disabled
[    0.000000] e820 update range: 0000000000001000 - 0000000000006000 (usable) ==> (reserved)
[    0.000000] Scanning 1 areas for low memory corruption
[    0.000000] modified physical RAM map:
[    0.000000]  modified: 0000000000000000 - 0000000000001000 (usable)
[    0.000000]  modified: 0000000000001000 - 0000000000006000 (reserved)
[    0.000000]  modified: 0000000000006000 - 000000000009f800 (usable)
[    0.000000]  modified: 000000000009f800 - 00000000000a0000 (reserved)
[    0.000000]  modified: 00000000000dc000 - 0000000000100000 (reserved)
[    0.000000]  modified: 0000000000100000 - 000000007f680000 (usable)
[    0.000000]  modified: 000000007f680000 - 000000007f690000 (ACPI NVS)
[    0.000000]  modified: 000000007f690000 - 0000000080000000 (reserved)
[    0.000000]  modified: 00000000e0000000 - 00000000f0000000 (reserved)
[    0.000000]  modified: 00000000fec00000 - 00000000fec10000 (reserved)
[    0.000000]  modified: 00000000fed14000 - 00000000fed1a000 (reserved)
[    0.000000]  modified: 00000000fed1c000 - 00000000fed90000 (reserved)
[    0.000000]  modified: 00000000fee00000 - 00000000fee01000 (reserved)
[    0.000000]  modified: 00000000ff000000 - 0000000100000000 (reserved)
[    0.000000] init_memory_mapping: 0000000000000000-000000007f680000
[    0.000000]  0000000000 - 007f600000 page 2M
[    0.000000]  007f600000 - 007f680000 page 4k
[    0.000000] kernel direct mapping tables up to 7f680000 @ 8000-c000
[    0.000000] RAMDISK: 37c3f000 - 37fef403
[    0.000000] ACPI: RSDP 00000000000f7710 00024 (v02 PTLTD )
[    0.000000] ACPI: XSDT 000000007f686f03 00094 (v01 FSC    PC       06040000  LTP 00000000)
[    0.000000] ACPI: FACP 000000007f68eb96 000F4 (v03 INTEL  CRESTLNE 06040000 ALAN 00000001)
[    0.000000] ACPI: Override [DSDT-S11_____], this is unsafe: tainting kernel
[    0.000000] Disabling lock debugging due to kernel taint
[    0.000000] ACPI: DSDT @ 0x000000007f68838c Table override, replaced with:
[    0.000000] ACPI: DSDT ffffffff80892990 06787 (v02 IEC___ S11_____ 06040000 INTL 20081204)
[    0.000000] ACPI: FACS 000000007f68ffc0 00040
[    0.000000] ACPI: APIC 000000007f68ec8a 00068 (v01 INTEL  CRESTLNE 06040000 LOHR 0000005A)
[    0.000000] ACPI: HPET 000000007f68ecf2 00038 (v01 INTEL  CRESTLNE 06040000 LOHR 0000005A)
[    0.000000] ACPI: MCFG 000000007f68ed2a 0003C (v01 INTEL  CRESTLNE 06040000 LOHR 0000005A)
[    0.000000] ACPI: SLIT 000000007f68ed66 0003C (v01 INTEL  CRESTLNE 06040000 LOHR 0000005A)
[    0.000000] ACPI: TCPA 000000007f68eda2 00032 (v01 Intel   CRESTLN 06040000      00005A52)
[    0.000000] ACPI: TMOR 000000007f68edd4 00026 (v01 PTLTD           06040000 PTL  00000003)
[    0.000000] ACPI: SLIC 000000007f68edfa 00176 (v01 FSC    PC       06040000 PTL_ 00000000)
[    0.000000] ACPI: APIC 000000007f68ef70 00068 (v01 PTLTD  	 APIC   06040000  LTP 00000000)
[    0.000000] ACPI: BOOT 000000007f68efd8 00028 (v01 PTLTD  $SBFTBL$ 06040000  LTP 00000001)
[    0.000000] ACPI: SSDT 000000007f6880af 002DD (v01 SataRe SataAhci 00001000 INTL 20050624)
[    0.000000] ACPI: SSDT 000000007f687523 0025F (v01  PmRef  Cpu0Tst 00003000 INTL 20050624)
[    0.000000] ACPI: SSDT 000000007f68747d 000A6 (v01  PmRef  Cpu1Tst 00003000 INTL 20050624)
[    0.000000] ACPI: SSDT 000000007f686f97 004E6 (v01  PmRef    CpuPm 00003000 INTL 20050624)
[    0.000000] ACPI: BIOS bug: multiple APIC/MADT found, using 0
[    0.000000] ACPI: If "acpi_apic_instance=2" works better, notify linux-acpi@vger.kernel.org
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] (7 early reservations) ==> bootmem [0000000000 - 007f680000]
[    0.000000]   #0 [0000000000 - 0000001000]   BIOS data page ==> [0000000000 - 0000001000]
[    0.000000]   #1 [0000006000 - 0000008000]       TRAMPOLINE ==> [0000006000 - 0000008000]
[    0.000000]   #2 [0000200000 - 0000af00b8]    TEXT DATA BSS ==> [0000200000 - 0000af00b8]
[    0.000000]   #3 [0037c3f000 - 0037fef403]          RAMDISK ==> [0037c3f000 - 0037fef403]
[    0.000000]   #4 [000009f800 - 0000100000]    BIOS reserved ==> [000009f800 - 0000100000]
[    0.000000]   #5 [0000af1000 - 0000af116c]              BRK ==> [0000af1000 - 0000af116c]
[    0.000000]   #6 [0000008000 - 000000a000]          PGTABLE ==> [0000008000 - 000000a000]
[    0.000000] found SMP MP-table at [ffff8800000f77a0] f77a0
[    0.000000]  [ffffe20000000000-ffffe20001bfffff] PMD -> [ffff880001200000-ffff880002dfffff] on node 0
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA      0x00000000 -> 0x00001000
[    0.000000]   DMA32    0x00001000 -> 0x00100000
[    0.000000]   Normal   0x00100000 -> 0x00100000
[    0.000000] Movable zone start PFN for each node
[    0.000000] early_node_map[3] active PFN ranges
[    0.000000]     0: 0x00000000 -> 0x00000001
[    0.000000]     0: 0x00000006 -> 0x0000009f
[    0.000000]     0: 0x00000100 -> 0x0007f680
[    0.000000] On node 0 totalpages: 521754
[    0.000000]   DMA zone: 56 pages used for memmap
[    0.000000]   DMA zone: 2389 pages reserved
[    0.000000]   DMA zone: 1549 pages, LIFO batch:0
[    0.000000]   DMA32 zone: 7079 pages used for memmap
[    0.000000]   DMA32 zone: 510681 pages, LIFO batch:31
[    0.000000] ACPI: PM-Timer IO Port: 0x1008
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
[    0.000000] ACPI: IOAPIC (id[0x01] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 1, version 0, address 0xfec00000, GSI 0-23
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ2 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.000000] SMP: Allowing 2 CPUs, 0 hotplug CPUs
[    0.000000] nr_irqs_gsi: 24
[    0.000000] PM: Registered nosave memory: 0000000000001000 - 0000000000006000
[    0.000000] PM: Registered nosave memory: 000000000009f000 - 00000000000a0000
[    0.000000] PM: Registered nosave memory: 00000000000a0000 - 00000000000dc000
[    0.000000] PM: Registered nosave memory: 00000000000dc000 - 0000000000100000
[    0.000000] Allocating PCI resources starting at 88000000 (gap: 80000000:60000000)
[    0.000000] NR_CPUS:64 nr_cpumask_bits:64 nr_cpu_ids:2 nr_node_ids:1
[    0.000000] PERCPU: Embedded 25 pages at ffff880001010000, static data 72992 bytes
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 512230
[    0.000000] Kernel command line: root=UUID=cfdbc761-596b-4edc-a3ec-a11daff9db1f ro quiet splash usbcore.autosuspend=0 pcie_aspm=force acpi_osi="Linux" resume=/dev/sda5 video.brightness_switch_enabled=0 
[    0.000000] PCIe ASPM is forcedly enabled
[    0.000000] ACPI: Added _OSI(Linux)
[    0.000000] Initializing CPU#0
[    0.000000] NR_IRQS:2304
[    0.000000] PID hash table entries: 4096 (order: 12, 32768 bytes)
[    0.000000] Extended CMOS year: 2000
[    0.000000] Fast TSC calibration using PIT
[    0.000000] Detected 1662.547 MHz processor.
[    0.004000] Console: colour VGA+ 80x25
[    0.004000] console [tty0] enabled
[    0.004000] Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
[    0.004000] Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes)
[    0.004000] allocated 20971520 bytes of page_cgroup
[    0.004000] please try cgroup_disable=memory option if you don't want
[    0.004000] Checking aperture...
[    0.004000] No AGP bridge found
[    0.004000] Calgary: detecting Calgary via BIOS EBDA area
[    0.004000] Calgary: Unable to locate Rio Grande table in EBDA - bailing!
[    0.004000] Memory: 2020848k/2087424k available (4612k kernel code, 408k absent, 65516k reserved, 2352k data, 420k init)
[    0.004000] SLUB: Genslabs=13, HWalign=64, Order=0-3, MinObjects=0, CPUs=2, Nodes=1
[    0.004000] HPET config register value = 0xFFFFFFFF. Disabling HPET
[    0.004015] Calibrating delay loop (skipped), value calculated using timer frequency.. 3325.09 BogoMIPS (lpj=6650188)
[    0.004047] Security Framework initialized
[    0.004056] SELinux:  Disabled at boot.
[    0.004065] Mount-cache hash table entries: 256
[    0.004248] Initializing cgroup subsys ns
[    0.004253] Initializing cgroup subsys cpuacct
[    0.004257] Initializing cgroup subsys memory
[    0.004266] Initializing cgroup subsys freezer
[    0.004282] CPU: L1 I cache: 32K, L1 D cache: 32K
[    0.004285] CPU: L2 cache: 2048K
[    0.004288] CPU: Physical Processor ID: 0
[    0.004289] CPU: Processor Core ID: 0
[    0.004293] using mwait in idle threads.
[    0.004319] ACPI: Core revision 20090320
[    0.012075] Setting APIC routing to flat
[    0.012674] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.054978] CPU0: Intel(R) Core(TM)2 Duo CPU     T5450  @ 1.66GHz stepping 0d
[    0.056001] Booting processor 1 APIC 0x1 ip 0x6000
[    0.004000] Initializing CPU#1
[    0.004000] Calibrating delay using timer specific routine.. 3325.17 BogoMIPS (lpj=6650350)
[    0.004000] CPU: L1 I cache: 32K, L1 D cache: 32K
[    0.004000] CPU: L2 cache: 2048K
[    0.004000] CPU: Physical Processor ID: 0
[    0.004000] CPU: Processor Core ID: 1
[    0.140419] CPU1: Intel(R) Core(TM)2 Duo CPU     T5450  @ 1.66GHz stepping 0d
[    0.140449] checking TSC synchronization [CPU#0 -> CPU#1]: passed.
[    0.144115] Brought up 2 CPUs
[    0.144118] Total of 2 processors activated (6650.26 BogoMIPS).
[    0.144167] CPU0 attaching sched-domain:
[    0.144171]  domain 0: span 0-1 level MC
[    0.144173]   groups: 0 1
[    0.144179] CPU1 attaching sched-domain:
[    0.144181]  domain 0: span 0-1 level MC
[    0.144184]   groups: 1 0
[    0.144264] net_namespace: 1872 bytes
[    0.144289] Time: 11:52:54  Date: 06/23/09
[    0.144289] NET: Registered protocol family 16
[    0.144289] ACPI: bus type pci registered
[    0.144295] PCI: MCFG configuration 0: base e0000000 segment 0 buses 0 - 255
[    0.144298] PCI: MCFG area at e0000000 reserved in E820
[    0.148064] PCI: Using MMCONFIG at e0000000 - efffffff
[    0.148066] PCI: Using configuration type 1 for base access
[    0.148772] bio: create slab <bio-0> at 0
[    0.148857] ACPI: EC: Look up EC in DSDT
[    0.651312] ACPI: BIOS _OSI(Linux) query honored via cmdline
[    0.652022] ACPI: EC: non-query interrupt received, switching to interrupt mode
[    0.660026] ACPI: EC: GPE storm detected, transactions will use polling mode
[    1.160006] ACPI: EC: missing confirmations, switch off interrupt mode.
[    1.168105] ACPI: Interpreter enabled
[    1.168109] ACPI: (supports S0 S3 S4 S5)
[    1.168141] ACPI: Using IOAPIC for interrupt routing
[    1.898444] ACPI: EC: GPE = 0x18, I/O: command/status = 0x66, data = 0x62
[    1.898447] ACPI: EC: driver started in poll mode
[    1.898531] ACPI: Power Resource [FN00] (on)
[    2.396326] ACPI: ACPI Dock Station Driver: 1 docks/bays found
[    2.396339] ACPI: PCI Root Bridge [PCI0] (0000:00)
[    2.396446] pci 0000:00:02.0: reg 10 64bit mmio: [0xfc000000-0xfc0fffff]
[    2.396455] pci 0000:00:02.0: reg 18 64bit mmio: [0xd0000000-0xdfffffff]
[    2.396461] pci 0000:00:02.0: reg 20 io port: [0x18f8-0x18ff]
[    2.396508] pci 0000:00:02.1: reg 10 64bit mmio: [0xfc100000-0xfc1fffff]
[    2.396623] pci 0000:00:1a.0: reg 20 io port: [0x1840-0x185f]
[    2.396690] pci 0000:00:1a.1: reg 20 io port: [0x1860-0x187f]
[    2.396761] pci 0000:00:1a.7: reg 10 32bit mmio: [0xfc406000-0xfc4063ff]
[    2.396825] pci 0000:00:1a.7: PME# supported from D0 D3hot D3cold
[    2.396831] pci 0000:00:1a.7: PME# disabled
[    2.396885] pci 0000:00:1b.0: reg 10 64bit mmio: [0xfc400000-0xfc403fff]
[    2.396947] pci 0000:00:1b.0: PME# supported from D0 D3hot D3cold
[    2.396953] pci 0000:00:1b.0: PME# disabled
[    2.397037] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    2.397043] pci 0000:00:1c.0: PME# disabled
[    2.397129] pci 0000:00:1c.1: PME# supported from D0 D3hot D3cold
[    2.397135] pci 0000:00:1c.1: PME# disabled
[    2.397220] pci 0000:00:1c.2: PME# supported from D0 D3hot D3cold
[    2.397226] pci 0000:00:1c.2: PME# disabled
[    2.397292] pci 0000:00:1d.0: reg 20 io port: [0x1880-0x189f]
[    2.397360] pci 0000:00:1d.1: reg 20 io port: [0x18a0-0x18bf]
[    2.397425] pci 0000:00:1d.2: reg 20 io port: [0x18c0-0x18df]
[    2.397496] pci 0000:00:1d.7: reg 10 32bit mmio: [0xfc406400-0xfc4067ff]
[    2.397559] pci 0000:00:1d.7: PME# supported from D0 D3hot D3cold
[    2.397565] pci 0000:00:1d.7: PME# disabled
[    2.397727] pci 0000:00:1f.0: Force enabled HPET at 0xfed00000
[    2.397734] pci 0000:00:1f.0: quirk: region 1000-107f claimed by ICH6 ACPI/GPIO/TCO
[    2.397739] pci 0000:00:1f.0: quirk: region 1180-11bf claimed by ICH6 GPIO
[    2.397743] pci 0000:00:1f.0: ICH7 LPC Generic IO decode 1 PIO at 0400 (mask 000f)
[    2.397748] pci 0000:00:1f.0: ICH7 LPC Generic IO decode 2 PIO at 0300 (mask 000f)
[    2.397801] pci 0000:00:1f.1: reg 10 io port: [0x00-0x07]
[    2.397810] pci 0000:00:1f.1: reg 14 io port: [0x00-0x03]
[    2.397818] pci 0000:00:1f.1: reg 18 io port: [0x00-0x07]
[    2.397826] pci 0000:00:1f.1: reg 1c io port: [0x00-0x03]
[    2.397834] pci 0000:00:1f.1: reg 20 io port: [0x1830-0x183f]
[    2.397907] pci 0000:00:1f.2: reg 10 io port: [0x1c50-0x1c57]
[    2.397915] pci 0000:00:1f.2: reg 14 io port: [0x1c44-0x1c47]
[    2.397923] pci 0000:00:1f.2: reg 18 io port: [0x1c48-0x1c4f]
[    2.397931] pci 0000:00:1f.2: reg 1c io port: [0x1c40-0x1c43]
[    2.397939] pci 0000:00:1f.2: reg 20 io port: [0x1c20-0x1c3f]
[    2.397947] pci 0000:00:1f.2: reg 24 32bit mmio: [0xfc405000-0xfc4057ff]
[    2.397990] pci 0000:00:1f.2: PME# supported from D3hot
[    2.397996] pci 0000:00:1f.2: PME# disabled
[    2.398029] pci 0000:00:1f.3: reg 10 32bit mmio: [0x000000-0x0000ff]
[    2.398055] pci 0000:00:1f.3: reg 20 io port: [0x1c00-0x1c1f]
[    2.398139] pci 0000:00:1c.0: bridge io port: [0x2000-0x2fff]
[    2.398145] pci 0000:00:1c.0: bridge 32bit mmio: [0xf6000000-0xf7ffffff]
[    2.398155] pci 0000:00:1c.0: bridge 64bit mmio pref: [0xf0000000-0xf1ffffff]
[    2.398235] pci 0000:04:00.0: reg 10 64bit mmio: [0xf8000000-0xf8003fff]
[    2.398245] pci 0000:04:00.0: reg 18 io port: [0x3000-0x30ff]
[    2.398280] pci 0000:04:00.0: reg 30 32bit mmio: [0x000000-0x01ffff]
[    2.398333] pci 0000:04:00.0: supports D1 D2
[    2.398336] pci 0000:04:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    2.398342] pci 0000:04:00.0: PME# disabled
[    2.404153] pci 0000:00:1c.1: bridge io port: [0x3000-0x3fff]
[    2.404160] pci 0000:00:1c.1: bridge 32bit mmio: [0xf8000000-0xf9ffffff]
[    2.404170] pci 0000:00:1c.1: bridge 64bit mmio pref: [0xf2000000-0xf3ffffff]
[    2.404312] pci 0000:06:00.0: reg 10 32bit mmio: [0xfa000000-0xfa000fff]
[    2.404548] pci 0000:06:00.0: PME# supported from D0 D3hot D3cold
[    2.404560] pci 0000:06:00.0: PME# disabled
[    2.412246] pci 0000:00:1c.2: bridge io port: [0x4000-0x4fff]
[    2.412252] pci 0000:00:1c.2: bridge 32bit mmio: [0xfa000000-0xfbffffff]
[    2.412261] pci 0000:00:1c.2: bridge 64bit mmio pref: [0xf4000000-0xf5ffffff]
[    2.412328] pci 0000:00:1e.0: transparent bridge
[    2.412367] pci_bus 0000:00: on NUMA node 0
[    2.412374] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[    2.412596] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP01._PRT]
[    2.412682] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP02._PRT]
[    2.412767] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP03._PRT]
[    2.412874] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIB._PRT]
[    2.427134] ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 5 6 7 10 12 14 15) *11
[    2.427261] ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 5 6 7 11 12 14 15) *10
[    2.427385] ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 5 6 *7 10 12 14 15)
[    2.427508] ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 5 6 7 *11 12 14 15)
[    2.427631] ACPI: PCI Interrupt Link [LNKE] (IRQs 1 3 4 5 6 7 10 12 14 15) *0, disabled.
[    2.427754] ACPI: PCI Interrupt Link [LNKF] (IRQs 1 3 4 5 6 7 11 12 14 15) *10
[    2.427877] ACPI: PCI Interrupt Link [LNKG] (IRQs 1 3 4 5 6 7 10 12 14 15) *0, disabled.
[    2.428010] ACPI: PCI Interrupt Link [LNKH] (IRQs 1 3 4 5 6 7 11 12 14 15) *10
[    2.428205] SCSI subsystem initialized
[    2.428213] libata version 3.00 loaded.
[    2.428213] usbcore: registered new interface driver usbfs
[    2.428213] usbcore: registered new interface driver hub
[    2.428213] usbcore: registered new device driver usb
[    2.428213] ACPI: WMI: Mapper loaded
[    2.428213] PCI: Using ACPI for IRQ routing
[    2.440013] Bluetooth: Core ver 2.15
[    2.440018] NET: Registered protocol family 31
[    2.440019] Bluetooth: HCI device and connection manager initialized
[    2.440022] Bluetooth: HCI socket layer initialized
[    2.440025] NET: Registered protocol family 8
[    2.440027] NET: Registered protocol family 20
[    2.440041] NetLabel: Initializing
[    2.440043] NetLabel:  domain hash size = 128
[    2.440045] NetLabel:  protocols = UNLABELED CIPSOv4
[    2.440061] NetLabel:  unlabeled traffic allowed by default
[    2.440230] hpet clockevent registered
[    2.440236] HPET: 3 timers in total, 0 timers will be used for per-cpu timer
[    2.440242] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
[    2.440247] hpet0: 3 comparators, 64-bit 14.318180 MHz counter
[    2.456562] pnp: PnP ACPI init
[    2.456572] ACPI: bus type pnp registered
[    2.940563] Switched to high resolution mode on CPU 1
[    2.944012] Switched to high resolution mode on CPU 0
[    3.072513] pnp: PnP ACPI: found 12 devices
[    3.072516] ACPI: ACPI bus type pnp unregistered
[    3.072527] system 00:01: iomem range 0xfed1c000-0xfed1ffff has been reserved
[    3.072531] system 00:01: iomem range 0xfed14000-0xfed17fff has been reserved
[    3.072535] system 00:01: iomem range 0xfed18000-0xfed18fff has been reserved
[    3.072538] system 00:01: iomem range 0xfed19000-0xfed19fff has been reserved
[    3.072541] system 00:01: iomem range 0xe0000000-0xefffffff has been reserved
[    3.072545] system 00:01: iomem range 0xfed20000-0xfed3ffff has been reserved
[    3.072548] system 00:01: iomem range 0xfed40000-0xfed44fff has been reserved
[    3.072552] system 00:01: iomem range 0xfed45000-0xfed8ffff has been reserved
[    3.072561] system 00:05: ioport range 0x200-0x20f has been reserved
[    3.072564] system 00:05: ioport range 0x400-0x40f has been reserved
[    3.072567] system 00:05: ioport range 0x680-0x69f has been reserved
[    3.072571] system 00:05: ioport range 0x800-0x80f has been reserved
[    3.072574] system 00:05: ioport range 0x1000-0x107f has been reserved
[    3.072578] system 00:05: ioport range 0x1180-0x11bf has been reserved
[    3.072581] system 00:05: ioport range 0x1640-0x164f has been reserved
[    3.072585] system 00:05: ioport range 0xfe00-0xfe00 has been reserved
[    3.072591] system 00:06: ioport range 0x6a0-0x6af has been reserved
[    3.072594] system 00:06: ioport range 0x6b0-0x6ff has been reserved
[    3.077328] pci 0000:00:1c.0: PCI bridge, secondary bus 0000:02
[    3.077332] pci 0000:00:1c.0:   IO window: 0x2000-0x2fff
[    3.077339] pci 0000:00:1c.0:   MEM window: 0xf6000000-0xf7ffffff
[    3.077344] pci 0000:00:1c.0:   PREFETCH window: 0x000000f0000000-0x000000f1ffffff
[    3.077353] pci 0000:00:1c.1: PCI bridge, secondary bus 0000:04
[    3.077357] pci 0000:00:1c.1:   IO window: 0x3000-0x3fff
[    3.077363] pci 0000:00:1c.1:   MEM window: 0xf8000000-0xf9ffffff
[    3.077369] pci 0000:00:1c.1:   PREFETCH window: 0x000000f2000000-0x000000f3ffffff
[    3.077377] pci 0000:00:1c.2: PCI bridge, secondary bus 0000:06
[    3.077380] pci 0000:00:1c.2:   IO window: 0x4000-0x4fff
[    3.077387] pci 0000:00:1c.2:   MEM window: 0xfa000000-0xfbffffff
[    3.077392] pci 0000:00:1c.2:   PREFETCH window: 0x000000f4000000-0x000000f5ffffff
[    3.077401] pci 0000:00:1e.0: PCI bridge, secondary bus 0000:08
[    3.077403] pci 0000:00:1e.0:   IO window: disabled
[    3.077408] pci 0000:00:1e.0:   MEM window: disabled
[    3.077413] pci 0000:00:1e.0:   PREFETCH window: disabled
[    3.077427] pci 0000:00:1c.0: enabling device (0000 -> 0003)
[    3.077435] pci 0000:00:1c.0: PCI INT A -> GSI 17 (level, low) -> IRQ 17
[    3.077442] pci 0000:00:1c.0: setting latency timer to 64
[    3.077452] pci 0000:00:1c.1: PCI INT B -> GSI 16 (level, low) -> IRQ 16
[    3.077458] pci 0000:00:1c.1: setting latency timer to 64
[    3.077466] pci 0000:00:1c.2: enabling device (0000 -> 0003)
[    3.077471] pci 0000:00:1c.2: PCI INT C -> GSI 18 (level, low) -> IRQ 18
[    3.077478] pci 0000:00:1c.2: setting latency timer to 64
[    3.077485] pci 0000:00:1e.0: setting latency timer to 64
[    3.077490] pci_bus 0000:00: resource 0 io:  [0x00-0xffff]
[    3.077493] pci_bus 0000:00: resource 1 mem: [0x000000-0xffffffffffffffff]
[    3.077496] pci_bus 0000:02: resource 0 io:  [0x2000-0x2fff]
[    3.077499] pci_bus 0000:02: resource 1 mem: [0xf6000000-0xf7ffffff]
[    3.077502] pci_bus 0000:02: resource 2 pref mem [0xf0000000-0xf1ffffff]
[    3.077505] pci_bus 0000:04: resource 0 io:  [0x3000-0x3fff]
[    3.077507] pci_bus 0000:04: resource 1 mem: [0xf8000000-0xf9ffffff]
[    3.077510] pci_bus 0000:04: resource 2 pref mem [0xf2000000-0xf3ffffff]
[    3.077513] pci_bus 0000:06: resource 0 io:  [0x4000-0x4fff]
[    3.077515] pci_bus 0000:06: resource 1 mem: [0xfa000000-0xfbffffff]
[    3.077518] pci_bus 0000:06: resource 2 pref mem [0xf4000000-0xf5ffffff]
[    3.077521] pci_bus 0000:08: resource 3 io:  [0x00-0xffff]
[    3.077523] pci_bus 0000:08: resource 4 mem: [0x000000-0xffffffffffffffff]
[    3.077554] NET: Registered protocol family 2
[    3.113066] IP route cache hash table entries: 65536 (order: 7, 524288 bytes)
[    3.113597] TCP established hash table entries: 262144 (order: 10, 4194304 bytes)
[    3.116562] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[    3.117324] TCP: Hash tables configured (established 262144 bind 65536)
[    3.117328] TCP reno registered
[    3.129146] NET: Registered protocol family 1
[    3.129226] Trying to unpack rootfs image as initramfs...
[    3.237095] Freeing initrd memory: 3777k freed
[    3.239840] Simple Boot Flag at 0x36 set to 0x1
[    3.239995] Scanning for low memory corruption every 60 seconds
[    3.240178] audit: initializing netlink socket (disabled)
[    3.240201] type=2000 audit(1245757977.237:1): initialized
[    3.250004] HugeTLB registered 2 MB page size, pre-allocated 0 pages
[    3.251436] VFS: Disk quotas dquot_6.5.2
[    3.251500] Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    3.251952] fuse init (API version 7.11)
[    3.252040] msgmni has been set to 3955
[    3.252332] alg: No test for stdrng (krng)
[    3.252342] io scheduler noop registered
[    3.252345] io scheduler anticipatory registered
[    3.252347] io scheduler deadline registered
[    3.252360] io scheduler cfq registered (default)
[    3.252374] pci 0000:00:02.0: Boot video device
[    3.252660] pcieport-driver 0000:00:1c.0: irq 24 for MSI/MSI-X
[    3.252678] pcieport-driver 0000:00:1c.0: setting latency timer to 64
[    3.252846] pcieport-driver 0000:00:1c.1: irq 25 for MSI/MSI-X
[    3.252863] pcieport-driver 0000:00:1c.1: setting latency timer to 64
[    3.253035] pcieport-driver 0000:00:1c.2: irq 26 for MSI/MSI-X
[    3.253053] pcieport-driver 0000:00:1c.2: setting latency timer to 64
[    3.308105] ACPI: AC Adapter [ADP1] (on-line)
[    3.308197] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input0
[    3.308201] ACPI: Power Button [PWRF]
[    3.308258] input: Lid Switch as /devices/LNXSYSTM:00/device:00/PNP0C0D:00/input/input1
[    3.364068] ACPI: Lid Switch [LID0]
[    3.364124] input: Sleep Button as /devices/LNXSYSTM:00/device:00/PNP0C0E:00/input/input2
[    3.364127] ACPI: Sleep Button [SLPB]
[    3.364175] input: Power Button as /devices/LNXSYSTM:00/device:00/PNP0C0C:00/input/input3
[    3.364178] ACPI: Power Button [PWRB]
[    3.364401] fan PNP0C0B:00: registered as cooling_device0
[    3.364407] ACPI: Fan [FAN0] (on)
[    3.364864] acpi device:07: registered as cooling_device1
[    3.364986] input: Video Bus as /devices/LNXSYSTM:00/device:00/PNP0A03:00/device:03/input/input4
[    3.364990] ACPI: Video Device [GFX0] (multi-head: yes  rom: no  post: no)
[    3.365472] ACPI: SSDT 000000007f687df1 001F6 (v01  PmRef  Cpu0Ist 00003000 INTL 20050624)
[    3.365969] ACPI: SSDT 000000007f687782 005EA (v01  PmRef  Cpu0Cst 00003001 INTL 20050624)
[    3.368369] ACPI Warning (processor_throttling-0843): Invalid throttling state, reset [20090320]
[    3.368738] Monitor-Mwait will be used to enter C-1 state
[    3.368762] Monitor-Mwait will be used to enter C-2 state
[    3.368771] Marking TSC unstable due to TSC halts in idle
[    3.368788] ACPI: CPU0 (power states: C1[C1] C2[C2])
[    3.368809] processor ACPI_CPU:00: registered as cooling_device2
[    3.368813] ACPI: Processor [CPU0] (supports 8 throttling states)
[    3.369217] ACPI: SSDT 000000007f687fe7 000C8 (v01  PmRef  Cpu1Ist 00003000 INTL 20050624)
[    3.369573] ACPI: SSDT 000000007f687d6c 00085 (v01  PmRef  Cpu1Cst 00003000 INTL 20050624)
[    3.370201] ACPI Warning (processor_throttling-0843): Invalid throttling state, reset [20090320]
[    3.370664] ACPI: CPU1 (power states: C1[C1] C2[C2])
[    3.370685] processor ACPI_CPU:01: registered as cooling_device3
[    3.370690] ACPI: Processor [CPU1] (supports 8 throttling states)
[    3.982747] thermal LNXTHERM:01: registered as thermal_zone0
[    3.982758] ACPI: Thermal Zone [TZ00] (27 C)
[    3.983221] ACPI: Invalid active1 threshold
[    3.983492] ACPI: Device [FAN0] failed to transition to D3
[    3.983498] thermal LNXTHERM:02: registered as thermal_zone1
[    3.983508] ACPI: Thermal Zone [TZ01] (32 C)
[    3.984641] Linux agpgart interface v0.103
[    3.984657] agpgart-intel 0000:00:00.0: Intel 965GM Chipset
[    3.985297] agpgart-intel 0000:00:00.0: detected 7676K stolen memory
[    3.988176] agpgart-intel 0000:00:00.0: AGP aperture is 256M @ 0xd0000000
[    3.988232] [drm] Initialized drm 1.1.0 20060810
[    3.988254] i915 0000:00:02.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
[    3.988259] i915 0000:00:02.0: setting latency timer to 64
[    3.994970] i915 0000:00:02.0: irq 27 for MSI/MSI-X
[    4.044104] ACPI: Battery Slot [BAT0] (battery absent)
[    4.104076] ACPI: Battery Slot [BAT1] (battery absent)
[    5.149847] [drm] TV-15: set mode NTSC 480i 0
[    5.286998] allocated 1280x800 fb: 0x007df000, bo ffff88007db1b480
[    5.360524] [drm] LVDS-8: set mode 1280x800 17
[    5.612194] Console: switching to colour frame buffer device 160x50
[    5.615592] fb0: inteldrmfb frame buffer device
[    5.615594] registered panic notifier
[    5.615601] [drm] Initialized i915 1.6.0 20080730 for 0000:00:02.0 on minor 0
[    5.615636] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    5.615757] serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[    5.616136] 00:08: ttyS0 at I/O 0x3f8 (irq = 3) is a 16550A
[    5.616988] brd: module loaded
[    5.617371] loop: module loaded
[    5.617422] Driver 'sd' needs updating - please use bus_type methods
[    5.617433] Driver 'sr' needs updating - please use bus_type methods
[    5.617477] ahci 0000:00:1f.2: version 3.0
[    5.617496] ahci 0000:00:1f.2: PCI INT B -> GSI 19 (level, low) -> IRQ 19
[    5.617541] ahci 0000:00:1f.2: irq 28 for MSI/MSI-X
[    5.617602] ahci 0000:00:1f.2: AHCI 0001.0100 32 slots 3 ports 3 Gbps 0x7 impl SATA mode
[    5.617606] ahci 0000:00:1f.2: flags: 64bit ncq sntf led clo pio slum part 
[    5.617612] ahci 0000:00:1f.2: setting latency timer to 64
[    5.617841] scsi0 : ahci
[    5.617939] scsi1 : ahci
[    5.618000] scsi2 : ahci
[    5.618122] ata1: SATA max UDMA/133 abar m2048@0xfc405000 port 0xfc405100 irq 28
[    5.618126] ata2: SATA max UDMA/133 abar m2048@0xfc405000 port 0xfc405180 irq 28
[    5.618129] ata3: SATA max UDMA/133 abar m2048@0xfc405000 port 0xfc405200 irq 28
[    5.618166] ata_piix 0000:00:1f.1: version 2.13
[    5.618175] ata_piix 0000:00:1f.1: PCI INT A -> GSI 19 (level, low) -> IRQ 19
[    5.618212] ata_piix 0000:00:1f.1: setting latency timer to 64
[    5.618284] scsi3 : ata_piix
[    5.618347] scsi4 : ata_piix
[    5.618994] ata4: PATA max UDMA/100 cmd 0x1f0 ctl 0x3f6 bmdma 0x1830 irq 14
[    5.618998] ata5: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0x1838 irq 15
[    5.619091] PPP generic driver version 2.4.2
[    5.619211] usbcore: registered new interface driver libusual
[    5.619258] PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
[    5.622730] i8042.c: Detected active multiplexing controller, rev 1.1.
[    5.625364] serio: i8042 KBD port at 0x60,0x64 irq 1
[    5.625370] serio: i8042 AUX0 port at 0x60,0x64 irq 12
[    5.625374] serio: i8042 AUX1 port at 0x60,0x64 irq 12
[    5.625377] serio: i8042 AUX2 port at 0x60,0x64 irq 12
[    5.625381] serio: i8042 AUX3 port at 0x60,0x64 irq 12
[    5.625431] mice: PS/2 mouse device common for all mice
[    5.625667] cpuidle: using governor ladder
[    5.625763] cpuidle: using governor menu
[    5.626140] TCP cubic registered
[    5.626270] NET: Registered protocol family 10
[    5.626732] lo: Disabled Privacy Extensions
[    5.627037] NET: Registered protocol family 17
[    5.627045] Bluetooth: L2CAP ver 2.13
[    5.627047] Bluetooth: L2CAP socket layer initialized
[    5.627050] Bluetooth: SCO (Voice Link) ver 0.6
[    5.627052] Bluetooth: SCO socket layer initialized
[    5.627084] Bluetooth: RFCOMM socket layer initialized
[    5.627093] Bluetooth: RFCOMM TTY layer initialized
[    5.627094] Bluetooth: RFCOMM ver 1.11
[    5.627797] TuxOnIce 3.0.1 (http://tuxonice.net)
[    5.661814] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input5
[    5.796365] ata4.00: ATAPI: TSSTcorp CDDVDW TS-L632H, fs03, max UDMA/33
[    5.828274] ata4.00: configured for UDMA/33
[    5.936064] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    5.936087] ata2: SATA link down (SStatus 0 SControl 300)
[    5.936114] ata3: SATA link down (SStatus 0 SControl 300)
[    5.936790] ACPI Warning (nspredef-0943): \_SB_.PCI0.SATA.PRT0._GTF: Return type mismatch - found Integer, expected Buffer [20090320]
[    5.936803] ata1.00: _GTF unexpected object type 0x1
[    5.986155] ata1.00: ATA-8: WDC WD1200BEVS-22UST0, 01.01A01, max UDMA/133
[    5.986161] ata1.00: 234441648 sectors, multi 16: LBA48 NCQ (depth 31/32)
[    5.987219] ata1.00: _GTF unexpected object type 0x1
[    5.987362] ata1.00: configured for UDMA/133
[    5.987548] scsi 0:0:0:0: Direct-Access     ATA      WDC WD1200BEVS-2 01.0 PQ: 0 ANSI: 5
[    5.987737] sd 0:0:0:0: Attached scsi generic sg0 type 0
[    5.987835] sd 0:0:0:0: [sda] 234441648 512-byte hardware sectors: (120 GB/111 GiB)
[    5.987862] sd 0:0:0:0: [sda] Write Protect is off
[    5.987867] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    5.987906] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    5.988077]  sda:<5>scsi 3:0:0:0: CD-ROM            TSSTcorp CDDVDW TS-L632H  fs03 PQ: 0 ANSI: 5
[    5.992413]  sda1 sda2 <sr0: scsi3-mmc drive: 24x/24x writer dvd-ram cd/rw xa/form2 cdda tray
[    6.007274] Uniform CD-ROM driver Revision: 3.20
[    6.007395] sr 3:0:0:0: Attached scsi CD-ROM sr0
[    6.007468] sr 3:0:0:0: Attached scsi generic sg1 type 5
[    6.008782]  sda5 sda6 sda7 >
[    6.042781] sd 0:0:0:0: [sda] Attached SCSI disk
[    6.198508] TuxOnIce: Normal swapspace found.
[    6.199013] PM: Checking image partition /dev/sda5
[    6.199030] PM: Resume from partition 8:5
[    6.199033] PM: Checking hibernation image.
[    6.199246] PM: Resume from disk failed.
[    6.199271] registered taskstats version 1
[    6.199473]   Magic number: 13:233:884
[    6.199560] BIOS EDD facility v0.16 2004-Jun-25, 0 devices found
[    6.199564] EDD information not available.
[    6.199674] Freeing unused kernel memory: 420k freed
[    6.199904] Write protecting the kernel read-only data: 6464k
[    6.343403] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    6.343451] ehci_hcd 0000:00:1a.7: PCI INT C -> GSI 18 (level, low) -> IRQ 18
[    6.343477] ehci_hcd 0000:00:1a.7: setting latency timer to 64
[    6.343484] ehci_hcd 0000:00:1a.7: EHCI Host Controller
[    6.343617] ehci_hcd 0000:00:1a.7: new USB bus registered, assigned bus number 1
[    6.347548] ehci_hcd 0000:00:1a.7: debug port 1
[    6.347558] ehci_hcd 0000:00:1a.7: cache line size of 32 is not supported
[    6.347586] ehci_hcd 0000:00:1a.7: irq 18, io mem 0xfc406000
[    6.360025] ehci_hcd 0000:00:1a.7: USB 2.0 started, EHCI 1.00
[    6.360152] usb usb1: configuration #1 chosen from 1 choice
[    6.360204] hub 1-0:1.0: USB hub found
[    6.360216] hub 1-0:1.0: 4 ports detected
[    6.360392] ehci_hcd 0000:00:1d.7: PCI INT A -> GSI 23 (level, low) -> IRQ 23
[    6.360410] ehci_hcd 0000:00:1d.7: setting latency timer to 64
[    6.360416] ehci_hcd 0000:00:1d.7: EHCI Host Controller
[    6.360493] ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 2
[    6.364398] ehci_hcd 0000:00:1d.7: debug port 1
[    6.364407] ehci_hcd 0000:00:1d.7: cache line size of 32 is not supported
[    6.364427] ehci_hcd 0000:00:1d.7: irq 23, io mem 0xfc406400
[    6.380021] ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00
[    6.380132] usb usb2: configuration #1 chosen from 1 choice
[    6.380184] hub 2-0:1.0: USB hub found
[    6.380195] hub 2-0:1.0: 6 ports detected
[    6.387152] uhci_hcd: USB Universal Host Controller Interface driver
[    6.387278] uhci_hcd 0000:00:1a.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
[    6.387291] uhci_hcd 0000:00:1a.0: setting latency timer to 64
[    6.387298] uhci_hcd 0000:00:1a.0: UHCI Host Controller
[    6.387416] uhci_hcd 0000:00:1a.0: new USB bus registered, assigned bus number 3
[    6.387469] uhci_hcd 0000:00:1a.0: irq 16, io base 0x00001840
[    6.387616] usb usb3: configuration #1 chosen from 1 choice
[    6.387668] hub 3-0:1.0: USB hub found
[    6.387679] hub 3-0:1.0: 2 ports detected
[    6.387835] uhci_hcd 0000:00:1a.1: PCI INT B -> GSI 21 (level, low) -> IRQ 21
[    6.387846] uhci_hcd 0000:00:1a.1: setting latency timer to 64
[    6.387852] uhci_hcd 0000:00:1a.1: UHCI Host Controller
[    6.387938] uhci_hcd 0000:00:1a.1: new USB bus registered, assigned bus number 4
[    6.387981] uhci_hcd 0000:00:1a.1: irq 21, io base 0x00001860
[    6.388135] usb usb4: configuration #1 chosen from 1 choice
[    6.388185] hub 4-0:1.0: USB hub found
[    6.388195] hub 4-0:1.0: 2 ports detected
[    6.388342] uhci_hcd 0000:00:1d.0: PCI INT A -> GSI 23 (level, low) -> IRQ 23
[    6.388353] uhci_hcd 0000:00:1d.0: setting latency timer to 64
[    6.388359] uhci_hcd 0000:00:1d.0: UHCI Host Controller
[    6.388435] uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 5
[    6.388469] uhci_hcd 0000:00:1d.0: irq 23, io base 0x00001880
[    6.388596] usb usb5: configuration #1 chosen from 1 choice
[    6.388645] hub 5-0:1.0: USB hub found
[    6.388654] hub 5-0:1.0: 2 ports detected
[    6.388787] uhci_hcd 0000:00:1d.1: PCI INT B -> GSI 19 (level, low) -> IRQ 19
[    6.388797] uhci_hcd 0000:00:1d.1: setting latency timer to 64
[    6.388802] uhci_hcd 0000:00:1d.1: UHCI Host Controller
[    6.388883] uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 6
[    6.388927] uhci_hcd 0000:00:1d.1: irq 19, io base 0x000018a0
[    6.389058] usb usb6: configuration #1 chosen from 1 choice
[    6.389105] hub 6-0:1.0: USB hub found
[    6.389115] hub 6-0:1.0: 2 ports detected
[    6.389252] uhci_hcd 0000:00:1d.2: PCI INT C -> GSI 18 (level, low) -> IRQ 18
[    6.389262] uhci_hcd 0000:00:1d.2: setting latency timer to 64
[    6.389268] uhci_hcd 0000:00:1d.2: UHCI Host Controller
[    6.389344] uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 7
[    6.389381] uhci_hcd 0000:00:1d.2: irq 18, io base 0x000018c0
[    6.389509] usb usb7: configuration #1 chosen from 1 choice
[    6.389555] hub 7-0:1.0: USB hub found
[    6.389565] hub 7-0:1.0: 2 ports detected
[    6.672045] usb 1-2: new high speed USB device using ehci_hcd and address 2
[    6.811250] usb 1-2: configuration #1 chosen from 1 choice
[    6.902825] PM: Starting manual resume from disk
[    6.903294] PM: Resume from partition 8:5
[    6.903297] PM: Checking hibernation image.
[    6.903464] PM: Resume from disk failed.
[    6.916977] EXT4-fs: barriers enabled
[    6.920037] usb 1-3: new high speed USB device using ehci_hcd and address 3
[    6.924385] kjournald2 starting: pid 782, dev sda1:8, commit interval 5 seconds
[    6.924417] EXT4-fs: delayed allocation enabled
[    6.924421] EXT4-fs: file extents enabled
[    6.924513] EXT4-fs: mballoc enabled
[    6.924537] EXT4-fs: mounted filesystem sda1 with ordered data mode
[    7.157406] usb 1-3: configuration #1 chosen from 1 choice
[    7.680033] usb 4-2: new full speed USB device using uhci_hcd and address 2
[    7.926201] usb 4-2: configuration #1 chosen from 1 choice
[    8.168046] usb 5-1: new full speed USB device using uhci_hcd and address 2
[    8.347650] usb 5-1: configuration #1 chosen from 1 choice
[   13.119934] udev: starting version 141
[   13.747369] sky2 driver version 1.22
[   13.747430] sky2 0000:04:00.0: PCI INT A -> GSI 17 (level, low) -> IRQ 17
[   13.747449] sky2 0000:04:00.0: setting latency timer to 64
[   13.747484] sky2 0000:04:00.0: Yukon-2 EC Ultra chip revision 3
[   13.747629] sky2 0000:04:00.0: irq 29 for MSI/MSI-X
[   13.748762] sky2 eth0: addr 00:a0:d1:cc:91:17
[   13.780112] cfg80211: Calling CRDA to update world regulatory domain
[   13.802115] cfg80211: World regulatory domain updated:
[   13.802121] 	(start_freq - end_freq @ bandwidth), (max_antenna_gain, max_eirp)
[   13.802127] 	(2402000 KHz - 2472000 KHz @ 40000 KHz), (300 mBi, 2000 mBm)
[   13.802133] 	(2457000 KHz - 2482000 KHz @ 20000 KHz), (300 mBi, 2000 mBm)
[   13.802138] 	(2474000 KHz - 2494000 KHz @ 20000 KHz), (300 mBi, 2000 mBm)
[   13.802143] 	(5170000 KHz - 5250000 KHz @ 40000 KHz), (300 mBi, 2000 mBm)
[   13.802148] 	(5735000 KHz - 5835000 KHz @ 40000 KHz), (300 mBi, 2000 mBm)
[   13.818981] input: PC Speaker as /devices/platform/pcspkr/input/input6
[   13.849607] usbcore: registered new interface driver hiddev
[   13.854072] input: Logitech USB Receiver as /devices/pci0000:00/0000:00:1d.0/usb5/5-1/5-1:1.0/input/input7
[   13.854225] generic-usb 0003:046D:C526.0001: input,hidraw0: USB HID v1.11 Mouse [Logitech USB Receiver] on usb-0000:00:1d.0-1/input0
[   13.859707] input: Logitech USB Receiver as /devices/pci0000:00/0000:00:1d.0/usb5/5-1/5-1:1.1/input/input8
[   13.859888] generic-usb 0003:046D:C526.0002: input,hiddev96,hidraw1: USB HID v1.11 Device [Logitech USB Receiver] on usb-0000:00:1d.0-1/input1
[   13.859922] usbcore: registered new interface driver usbhid
[   13.859927] usbhid: v2.6:USB HID core driver
[   13.872666] Bluetooth: Generic Bluetooth USB driver ver 0.5
[   13.872818] usbcore: registered new interface driver btusb
[   14.016162] Linux video capture interface: v2.00
[   14.417227] Synaptics Touchpad, model: 1, fw: 6.2, id: 0x81a0b1, caps: 0xa04753/0x200000
[   14.446994] uvcvideo: Found UVC 1.00 device FO13FF-65-1 PC-CAM (05c8:0103)
[   14.448879] input: SynPS/2 Synaptics TouchPad as /devices/platform/i8042/serio4/input/input9
[   14.450581] input: FO13FF-65-1 PC-CAM as /devices/pci0000:00/0000:00:1a.7/usb1/1-3/1-3:1.0/input/input10
[   14.450701] usbcore: registered new interface driver uvcvideo
[   14.450707] USB Video Class driver (v0.1.0)
[   14.620665] iwl3945: Intel(R) PRO/Wireless 3945ABG/BG Network Connection driver for Linux, 1.2.26ks
[   14.620672] iwl3945: Copyright(c) 2003-2009 Intel Corporation
[   14.620802] iwl3945 0000:06:00.0: enabling device (0104 -> 0106)
[   14.620817] iwl3945 0000:06:00.0: PCI INT A -> GSI 18 (level, low) -> IRQ 18
[   14.620834] iwl3945 0000:06:00.0: setting latency timer to 64
[   14.675882] iwl3945 0000:06:00.0: Tunable channels: 13 802.11bg, 23 802.11a channels
[   14.675888] iwl3945 0000:06:00.0: Detected Intel Wireless WiFi Link 3945ABG
[   14.676275] iwl3945 0000:06:00.0: irq 30 for MSI/MSI-X
[   14.806287] phy0: Selected rate control algorithm 'iwl-3945-rs'
[   14.913080] HDA Intel 0000:00:1b.0: enabling device (0104 -> 0106)
[   14.913093] HDA Intel 0000:00:1b.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
[   14.913132] HDA Intel 0000:00:1b.0: setting latency timer to 64
[   15.019837] input: HDA Digital PCBeep as /devices/pci0000:00/0000:00:1b.0/input/input11
[   15.272891] Adding 4883720k swap on /dev/sda5.  Priority:-1 extents:1 across:4883720k 
[   15.949656] EXT4 FS on sda1, internal journal on sda1:8
[   16.912678] EXT4-fs: barriers enabled
[   16.935316] kjournald2 starting: pid 2050, dev sda6:8, commit interval 5 seconds
[   16.935553] EXT4 FS on sda6, internal journal on sda6:8
[   16.935557] EXT4-fs: delayed allocation enabled
[   16.935561] EXT4-fs: file extents enabled
[   16.935855] EXT4-fs: mballoc enabled
[   16.935879] EXT4-fs: mounted filesystem sda6 with ordered data mode
[   19.148742] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[   19.148746] Bluetooth: BNEP filters: protocol multicast
[   19.483228] [drm] TV-15: set mode NTSC 480i 0
[   19.648300] [drm] TV-15: set mode NTSC 480i 0
[   19.749192] Bridge firewalling registered
[   20.121349] [drm] TV-15: set mode NTSC 480i 0
[   20.286793] [drm] TV-15: set mode NTSC 480i 0
[   23.005269] sky2 eth0: enabling interface
[   23.005726] ADDRCONF(NETDEV_UP): eth0: link is not ready
[   23.006811] iwl3945 0000:06:00.0: firmware: requesting iwlwifi-3945-2.ucode
[   23.119883] iwl3945 0000:06:00.0: loaded firmware version 15.32.2.9
[   23.186044] ADDRCONF(NETDEV_UP): wlan0: link is not ready
[   28.386392] atkbd.c: Unknown key pressed (translated set 2, code 0x83 on isa0060/serio0).
[   28.386399] atkbd.c: Use 'setkeycodes e003 <keycode>' to make it known.
[   29.136135] [drm] TV-15: set mode NTSC 480i 0
[   29.302138] [drm] TV-15: set mode NTSC 480i 0
[   29.791540] [drm] TV-15: set mode NTSC 480i 0
[   29.956983] [drm] TV-15: set mode NTSC 480i 0
[   30.447346] [drm] TV-15: set mode NTSC 480i 0
[   30.613257] [drm] TV-15: set mode NTSC 480i 0
[   33.519410] [drm] TV-15: set mode NTSC 480i 0
[   33.685521] [drm] TV-15: set mode NTSC 480i 0
[   38.255058] wlan0: authenticate with AP 00:12:bf:1d:d6:6e
[   38.256764] wlan0: authenticated
[   38.256768] wlan0: associate with AP 00:12:bf:1d:d6:6e
[   38.258993] wlan0: RX AssocResp from 00:12:bf:1d:d6:6e (capab=0x431 status=0 aid=3)
[   38.259000] wlan0: associated
[   38.260665] ADDRCONF(NETDEV_CHANGE): wlan0: link becomes ready
[   48.420024] wlan0: no IPv6 routers present

--------------020403090709060300030601
Content-Type: text/x-log;
 name="hdparm.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="hdparm.log"


/dev/sda:

ATA device, with non-removable media
	Model Number:       WDC WD1200BEVS-22UST0                   
	Serial Number:      WD-WXEX07E49571
	Firmware Revision:  01.01A01
Standards:
	Supported: 8 7 6 5 
	Likely used: 8
Configuration:
	Logical		max	current
	cylinders	16383	16383
	heads		16	16
	sectors/track	63	63
	--
	CHS current addressable sectors:   16514064
	LBA    user addressable sectors:  234441648
	LBA48  user addressable sectors:  234441648
	device size with M = 1024*1024:      114473 MBytes
	device size with M = 1000*1000:      120034 MBytes (120 GB)
Capabilities:
	LBA, IORDY(can be disabled)
	Queue depth: 32
	Standby timer values: spec'd by Standard, with device specific minimum
	R/W multiple sector transfer: Max = 16	Current = 16
	Advanced power management level: 200
	Recommended acoustic management value: 128, current value: 254
	DMA: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 udma5 *udma6 
	     Cycle time: min=120ns recommended=120ns
	PIO: pio0 pio1 pio2 pio3 pio4 
	     Cycle time: no flow control=120ns  IORDY flow control=120ns
Commands/features:
	Enabled	Supported:
	   *	SMART feature set
	    	Security Mode feature set
	   *	Power Management feature set
	   *	Write cache
	   *	Look-ahead
	   *	Host Protected Area feature set
	   *	WRITE_BUFFER command
	   *	READ_BUFFER command
	   *	NOP cmd
	   *	DOWNLOAD_MICROCODE
	   *	Advanced Power Management feature set
	   *	SET_MAX security extension
	   *	Automatic Acoustic Management feature set
	   *	48-bit Address feature set
	   *	Device Configuration Overlay feature set
	   *	Mandatory FLUSH_CACHE
	   *	FLUSH_CACHE_EXT
	   *	SMART error logging
	   *	SMART self-test
	   *	General Purpose Logging feature set
	   *	WRITE_{DMA|MULTIPLE}_FUA_EXT
	   *	64-bit World wide name
	   *	IDLE_IMMEDIATE with UNLOAD
	   *	Segmented DOWNLOAD_MICROCODE
	   *	SATA-I signaling speed (1.5Gb/s)
	   *	Native Command Queueing (NCQ)
	   *	Host-initiated interface power management
	   *	Phy event counters
	    	DMA Setup Auto-Activate optimization
	    	Device-initiated interface power management
	   *	Software settings preservation
	   *	SMART Command Transport (SCT) feature set
	   *	SCT Long Sector Access (AC1)
	   *	SCT LBA Segment Access (AC2)
	   *	SCT Error Recovery Control (AC3)
	   *	SCT Features Control (AC4)
	   *	SCT Data Tables (AC5)
	    	unknown 206[12] (vendor specific)
	    	unknown 206[13] (vendor specific)
Security: 
	Master password revision code = 65534
		supported
	not	enabled
	not	locked
		frozen
	not	expired: security count
	not	supported: enhanced erase
	48min for SECURITY ERASE UNIT. 
Logical Unit WWN Device Identifier: 50014ee256053632
	NAA		: 5
	IEEE OUI	: 14ee
	Unique ID	: 256053632
Checksum: correct

--------------020403090709060300030601--
