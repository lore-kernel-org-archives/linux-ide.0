From: Mourad De Clerck <mourad@aquazul.com>
Subject: Marvell 6121 AHCI: hotplug not reliable?
Date: Thu, 13 Aug 2009 14:28:30 +0200
Message-ID: <4A8406EE.1040203@aquazul.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_oz-9270-1250166521-0001-2"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gretel.risen.be ([78.46.99.137]:40811 "EHLO gretel.risen.be"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751360AbZHMMdp (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 13 Aug 2009 08:33:45 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_oz-9270-1250166521-0001-2
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit

Hello,

I've got a box with an Asus M2V motherboard and a Marvell 6121 SATA
controller. Kernel version 2.6.30.

It works in general, but from time to time it stops detecting the disks
when I hotplug them. So usually hotplug works, but sometimes it just
stops working.

If I unload the ahci module, and reload it (with the marvell_enable=1
parm), it detects the disks again and works without any further issues -
until the next failed hotplug.

Is there anything that can be done about this?

In attachment, the kernel log with at the end (at [128508.539280]) a
failed hotplug, after which I unload/reload the ahci module and things
work again (starting at [147111.353555]).

Thanks,

-- Mourad DC

--=_oz-9270-1250166521-0001-2
Content-Type: text/plain; name="marvell_ahci_dmesg.txt"; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="marvell_ahci_dmesg.txt"

[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Linux version 2.6.30-bpo.1-amd64 (Debian 2.6.30-5~bpo50+1) (nobse@debian.org) (gcc version 4.3.2 (Debian 4.3.2-1.1) ) #1 SMP Wed Aug 5 11:07:47 UTC 2009
[    0.000000] Command line: BOOT_IMAGE=/vmlinuz-2.6.30-bpo.1-amd64 root=/dev/mapper/vg-root ro
[    0.000000] KERNEL supported cpus:
[    0.000000]   Intel GenuineIntel
[    0.000000]   AMD AuthenticAMD
[    0.000000]   Centaur CentaurHauls
[    0.000000] BIOS-provided physical RAM map:
[    0.000000]  BIOS-e820: 0000000000000000 - 000000000009dc00 (usable)
[    0.000000]  BIOS-e820: 000000000009dc00 - 00000000000a0000 (reserved)
[    0.000000]  BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
[    0.000000]  BIOS-e820: 0000000000100000 - 000000007ffb0000 (usable)
[    0.000000]  BIOS-e820: 000000007ffb0000 - 000000007ffbe000 (ACPI data)
[    0.000000]  BIOS-e820: 000000007ffbe000 - 000000007ffe0000 (ACPI NVS)
[    0.000000]  BIOS-e820: 000000007ffe0000 - 0000000080000000 (reserved)
[    0.000000]  BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
[    0.000000]  BIOS-e820: 00000000fecc0000 - 00000000fecc1000 (reserved)
[    0.000000]  BIOS-e820: 00000000ff780000 - 0000000100000000 (reserved)
[    0.000000] DMI present.
[    0.000000] AMI BIOS detected: BIOS may corrupt low RAM, working around it.
[    0.000000] e820 update range: 0000000000000000 - 0000000000010000 (usable) ==> (reserved)
[    0.000000] last_pfn = 0x7ffb0 max_arch_pfn = 0x100000000
[    0.000000] MTRR default type: uncachable
[    0.000000] MTRR fixed ranges enabled:
[    0.000000]   00000-9FFFF write-back
[    0.000000]   A0000-EFFFF uncachable
[    0.000000]   F0000-FFFFF write-protect
[    0.000000] MTRR variable ranges enabled:
[    0.000000]   0 base 0000000000 mask FF80000000 write-back
[    0.000000]   1 disabled
[    0.000000]   2 disabled
[    0.000000]   3 disabled
[    0.000000]   4 disabled
[    0.000000]   5 disabled
[    0.000000]   6 disabled
[    0.000000]   7 disabled
[    0.000000] x86 PAT enabled: cpu 0, old 0x7040600070406, new 0x7010600070106
[    0.000000] init_memory_mapping: 0000000000000000-000000007ffb0000
[    0.000000]  0000000000 - 007fe00000 page 2M
[    0.000000]  007fe00000 - 007ffb0000 page 4k
[    0.000000] kernel direct mapping tables up to 7ffb0000 @ 10000-14000
[    0.000000] RAMDISK: 377ee000 - 37fef633
[    0.000000] ACPI: RSDP 00000000000fa960 00014 (v00 ACPIAM)
[    0.000000] ACPI: RSDT 000000007ffb0000 00034 (v01 A M I  OEMRSDT  05000624 MSFT 00000097)
[    0.000000] ACPI: FACP 000000007ffb0200 00084 (v02 A M I  OEMFACP  05000624 MSFT 00000097)
[    0.000000] ACPI: DSDT 000000007ffb0440 0603F (v01  A0498 A0498000 00000000 INTL 20060113)
[    0.000000] ACPI: FACS 000000007ffbe000 00040
[    0.000000] ACPI: APIC 000000007ffb0390 00068 (v01 A M I  OEMAPIC  05000624 MSFT 00000097)
[    0.000000] ACPI: MCFG 000000007ffb0400 0003C (v01 A M I  OEMMCFG  05000624 MSFT 00000097)
[    0.000000] ACPI: OEMB 000000007ffbe040 00060 (v01 A M I  AMI_OEM  05000624 MSFT 00000097)
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] Scanning NUMA topology in Northbridge 24
[    0.000000] No NUMA configuration found
[    0.000000] Faking a node at 0000000000000000-000000007ffb0000
[    0.000000] Bootmem setup node 0 0000000000000000-000000007ffb0000
[    0.000000]   NODE_DATA [0000000000012000 - 0000000000019fff]
[    0.000000]   bootmap [000000000001a000 -  0000000000029ff7] pages 10
[    0.000000] (7 early reservations) ==> bootmem [0000000000 - 007ffb0000]
[    0.000000]   #0 [0000000000 - 0000001000]   BIOS data page ==> [0000000000 - 0000001000]
[    0.000000]   #1 [0000006000 - 0000008000]       TRAMPOLINE ==> [0000006000 - 0000008000]
[    0.000000]   #2 [0000200000 - 00007d98cc]    TEXT DATA BSS ==> [0000200000 - 00007d98cc]
[    0.000000]   #3 [00377ee000 - 0037fef633]          RAMDISK ==> [00377ee000 - 0037fef633]
[    0.000000]   #4 [000009dc00 - 0000100000]    BIOS reserved ==> [000009dc00 - 0000100000]
[    0.000000]   #5 [00007da000 - 00007da290]              BRK ==> [00007da000 - 00007da290]
[    0.000000]   #6 [0000010000 - 0000012000]          PGTABLE ==> [0000010000 - 0000012000]
[    0.000000] found SMP MP-table at [ffff8800000ff780] ff780
[    0.000000]  [ffffe20000000000-ffffe20001bfffff] PMD -> [ffff880001200000-ffff880002dfffff] on node 0
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA      0x00000010 -> 0x00001000
[    0.000000]   DMA32    0x00001000 -> 0x00100000
[    0.000000]   Normal   0x00100000 -> 0x00100000
[    0.000000] Movable zone start PFN for each node
[    0.000000] early_node_map[2] active PFN ranges
[    0.000000]     0: 0x00000010 -> 0x0000009d
[    0.000000]     0: 0x00000100 -> 0x0007ffb0
[    0.000000] On node 0 totalpages: 524093
[    0.000000]   DMA zone: 56 pages used for memmap
[    0.000000]   DMA zone: 1600 pages reserved
[    0.000000]   DMA zone: 2325 pages, LIFO batch:0
[    0.000000]   DMA32 zone: 7111 pages used for memmap
[    0.000000]   DMA32 zone: 513001 pages, LIFO batch:31
[    0.000000] Detected use of extended apic ids on hypertransport bus
[    0.000000] ACPI: PM-Timer IO Port: 0x808
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
[    0.000000] ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 2, version 0, address 0xfec00000, GSI 0-23
[    0.000000] ACPI: IOAPIC (id[0x03] address[0xfecc0000] gsi_base[24])
[    0.000000] IOAPIC[1]: apic_id 3, version 0, address 0xfecc0000, GSI 24-47
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ2 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] SMP: Allowing 2 CPUs, 0 hotplug CPUs
[    0.000000] nr_irqs_gsi: 48
[    0.000000] PM: Registered nosave memory: 000000000009d000 - 000000000009e000
[    0.000000] PM: Registered nosave memory: 000000000009e000 - 00000000000a0000
[    0.000000] PM: Registered nosave memory: 00000000000a0000 - 00000000000e0000
[    0.000000] PM: Registered nosave memory: 00000000000e0000 - 0000000000100000
[    0.000000] Allocating PCI resources starting at 88000000 (gap: 80000000:7ec00000)
[    0.000000] NR_CPUS:512 nr_cpumask_bits:512 nr_cpu_ids:2 nr_node_ids:1
[    0.000000] PERCPU: Embedded 26 pages at ffff880001010000, static data 76256 bytes
[    0.000000] Built 1 zonelists in Node order, mobility grouping on.  Total pages: 515326
[    0.000000] Policy zone: DMA32
[    0.000000] Kernel command line: BOOT_IMAGE=/vmlinuz-2.6.30-bpo.1-amd64 root=/dev/mapper/vg-root ro
[    0.000000] Initializing CPU#0
[    0.000000] Experimental hierarchical RCU implementation.
[    0.000000] Experimental hierarchical RCU init done.
[    0.000000] NR_IRQS:4352 nr_irqs:512
[    0.000000] PID hash table entries: 4096 (order: 12, 32768 bytes)
[    0.000000] Fast TSC calibration using PIT
[    0.000000] Detected 1999.393 MHz processor.
[    0.004000] Console: colour VGA+ 80x25
[    0.004000] console [tty0] enabled
[    0.004000] Checking aperture...
[    0.004000] No AGP bridge found
[    0.004000] Node 0: aperture @ 1d4c000000 size 32 MB
[    0.004000] Aperture beyond 4GB. Ignoring.
[    0.004000] Memory: 2053120k/2096832k available (2785k kernel code, 460k absent, 43252k reserved, 1398k data, 560k init)
[    0.004009] Calibrating delay loop (skipped), value calculated using timer frequency.. 3998.78 BogoMIPS (lpj=7997572)
[    0.004290] Security Framework initialized
[    0.004357] SELinux:  Disabled at boot.
[    0.004668] Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
[    0.005820] Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes)
[    0.006425] Mount-cache hash table entries: 256
[    0.006692] Initializing cgroup subsys ns
[    0.006756] Initializing cgroup subsys cpuacct
[    0.006822] Initializing cgroup subsys devices
[    0.006886] Initializing cgroup subsys freezer
[    0.006950] Initializing cgroup subsys net_cls
[    0.007048] CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
[    0.007116] CPU: L2 Cache: 512K (64 bytes/line)
[    0.007180] CPU 0/0x0 -> Node 0
[    0.007242] tseg: 0000000000
[    0.007255] CPU: Physical Processor ID: 0
[    0.007317] CPU: Processor Core ID: 0
[    0.007388] using C1E aware idle routine
[    0.008224] ACPI: Core revision 20090320
[    0.020060] Setting APIC routing to flat
[    0.020490] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=0 pin2=0
[    0.060411] CPU0: AMD Athlon(tm) 64 X2 Dual Core Processor 3800+ stepping 02
[    0.064001] Booting processor 1 APIC 0x1 ip 0x6000
[    0.004000] Initializing CPU#1
[    0.004000] Calibrating delay using timer specific routine.. 3999.79 BogoMIPS (lpj=7999592)
[    0.004000] CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
[    0.004000] CPU: L2 Cache: 512K (64 bytes/line)
[    0.004000] CPU 1/0x1 -> Node 0
[    0.004000] CPU: Physical Processor ID: 0
[    0.004000] CPU: Processor Core ID: 1
[    0.004000] x86 PAT enabled: cpu 1, old 0x7040600070406, new 0x7010600070106
[    0.148415] CPU1: AMD Athlon(tm) 64 X2 Dual Core Processor 3800+ stepping 02
[    0.149092] Brought up 2 CPUs
[    0.149154] Total of 2 processors activated (7998.58 BogoMIPS).
[    0.149295] CPU0 attaching sched-domain:
[    0.149299]  domain 0: span 0-1 level MC
[    0.149301]   groups: 0 1
[    0.149307] CPU1 attaching sched-domain:
[    0.149309]  domain 0: span 0-1 level MC
[    0.149312]   groups: 1 0
[    0.149378] net_namespace: 1936 bytes
[    0.149378] Booting paravirtualized kernel on bare hardware
[    0.149378] regulator: core version 0.5
[    0.149378] NET: Registered protocol family 16
[    0.149378] node 0 link 0: io port [1000, ffffff]
[    0.149378] TOM: 0000000080000000 aka 2048M
[    0.149378] node 0 link 0: mmio [e0000000, efffffff]
[    0.149378] node 0 link 0: mmio [a0000, bffff]
[    0.149378] node 0 link 0: mmio [80000000, ffffffff]
[    0.149378] bus: [00,ff] on node 0 link 0
[    0.149378] bus: 00 index 0 io port: [0, ffff]
[    0.149378] bus: 00 index 1 mmio: [80000000, fcffffffff]
[    0.149378] bus: 00 index 2 mmio: [a0000, bffff]
[    0.149378] ACPI: bus type pci registered
[    0.149378] PCI: MCFG configuration 0: base e0000000 segment 0 buses 0 - 255
[    0.149378] PCI: Not using MMCONFIG.
[    0.149378] PCI: Using configuration type 1 for base access
[    0.152103] bio: create slab <bio-0> at 0
[    0.152557] ACPI: EC: Look up EC in DSDT
[    0.165184] ACPI: Interpreter enabled
[    0.165249] ACPI: (supports S0 S1 S3 S4 S5)
[    0.165573] ACPI: Using IOAPIC for interrupt routing
[    0.165704] PCI: MCFG configuration 0: base e0000000 segment 0 buses 0 - 255
[    0.173108] PCI: MCFG area at e0000000 reserved in ACPI motherboard resources
[    0.182098] PCI: Using MMCONFIG at e0000000 - efffffff
[    0.193102] ACPI Warning (tbutils-0246): Incorrect checksum in table [OEMB] - 77, should be 6A [20090320]
[    0.193102] ACPI: No dock devices found.
[    0.193102] ACPI: PCI Root Bridge [PCI0] (0000:00)
[    0.193102] pci 0000:00:02.0: PME# supported from D0 D3hot D3cold
[    0.193102] pci 0000:00:02.0: PME# disabled
[    0.196043] pci 0000:00:03.0: PME# supported from D0 D3hot D3cold
[    0.196110] pci 0000:00:03.0: PME# disabled
[    0.196229] pci 0000:00:03.1: PME# supported from D0 D3hot D3cold
[    0.196296] pci 0000:00:03.1: PME# disabled
[    0.196415] pci 0000:00:03.2: PME# supported from D0 D3hot D3cold
[    0.196482] pci 0000:00:03.2: PME# disabled
[    0.196601] pci 0000:00:03.3: PME# supported from D0 D3hot D3cold
[    0.196668] pci 0000:00:03.3: PME# disabled
[    0.196783] pci 0000:00:0f.0: reg 10 io port: [0xcc00-0xcc07]
[    0.196790] pci 0000:00:0f.0: reg 14 io port: [0xc880-0xc883]
[    0.196797] pci 0000:00:0f.0: reg 18 io port: [0xc800-0xc807]
[    0.196803] pci 0000:00:0f.0: reg 1c io port: [0xc480-0xc483]
[    0.196810] pci 0000:00:0f.0: reg 20 io port: [0xc400-0xc40f]
[    0.196817] pci 0000:00:0f.0: reg 24 io port: [0xc000-0xc0ff]
[    0.196881] pci 0000:00:0f.1: reg 20 io port: [0xfc00-0xfc0f]
[    0.196954] pci 0000:00:10.0: reg 20 io port: [0xbc00-0xbc1f]
[    0.196977] pci 0000:00:10.0: supports D1 D2
[    0.196980] pci 0000:00:10.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.197048] pci 0000:00:10.0: PME# disabled
[    0.197156] pci 0000:00:10.1: reg 20 io port: [0xb880-0xb89f]
[    0.197179] pci 0000:00:10.1: supports D1 D2
[    0.197181] pci 0000:00:10.1: PME# supported from D0 D1 D2 D3hot D3cold
[    0.197249] pci 0000:00:10.1: PME# disabled
[    0.197353] pci 0000:00:10.2: reg 20 io port: [0xb800-0xb81f]
[    0.197376] pci 0000:00:10.2: supports D1 D2
[    0.197378] pci 0000:00:10.2: PME# supported from D0 D1 D2 D3hot D3cold
[    0.197446] pci 0000:00:10.2: PME# disabled
[    0.197550] pci 0000:00:10.3: reg 20 io port: [0xb480-0xb49f]
[    0.197573] pci 0000:00:10.3: supports D1 D2
[    0.197576] pci 0000:00:10.3: PME# supported from D0 D1 D2 D3hot D3cold
[    0.197644] pci 0000:00:10.3: PME# disabled
[    0.197733] pci 0000:00:10.4: reg 10 32bit mmio: [0xf8fffc00-0xf8fffcff]
[    0.197771] pci 0000:00:10.4: supports D1 D2
[    0.197773] pci 0000:00:10.4: PME# supported from D0 D1 D2 D3hot D3cold
[    0.197841] pci 0000:00:10.4: PME# disabled
[    0.198281] pci 0000:02:00.0: reg 10 32bit mmio: [0xfa000000-0xfaffffff]
[    0.198291] pci 0000:02:00.0: reg 14 64bit mmio: [0xd0000000-0xdfffffff]
[    0.198300] pci 0000:02:00.0: reg 1c 64bit mmio: [0xf9000000-0xf9ffffff]
[    0.198310] pci 0000:02:00.0: reg 30 32bit mmio: [0xfbce0000-0xfbcfffff]
[    0.198378] pci 0000:00:02.0: bridge 32bit mmio: [0xf9000000-0xfbcfffff]
[    0.198384] pci 0000:00:02.0: bridge 64bit mmio pref: [0xd0000000-0xdfffffff]
[    0.198425] pci 0000:03:00.0: reg 10 io port: [0xdc00-0xdc07]
[    0.198433] pci 0000:03:00.0: reg 14 io port: [0xd880-0xd883]
[    0.198440] pci 0000:03:00.0: reg 18 io port: [0xd800-0xd807]
[    0.198447] pci 0000:03:00.0: reg 1c io port: [0xd480-0xd483]
[    0.198455] pci 0000:03:00.0: reg 20 io port: [0xd400-0xd40f]
[    0.198462] pci 0000:03:00.0: reg 24 32bit mmio: [0xfbdffc00-0xfbdfffff]
[    0.198494] pci 0000:03:00.0: supports D1
[    0.198496] pci 0000:03:00.0: PME# supported from D0 D1 D3hot
[    0.198563] pci 0000:03:00.0: PME# disabled
[    0.198673] pci 0000:00:03.0: bridge io port: [0xd000-0xdfff]
[    0.198677] pci 0000:00:03.0: bridge 32bit mmio: [0xfbd00000-0xfbdfffff]
[    0.198732] pci 0000:00:03.1: bridge 64bit mmio pref: [0xf7e00000-0xf7efffff]
[    0.198779] pci 0000:05:00.0: reg 10 64bit mmio: [0xfbec0000-0xfbefffff]
[    0.198806] pci 0000:05:00.0: reg 30 32bit mmio: [0xfbea0000-0xfbebffff]
[    0.198836] pci 0000:05:00.0: PME# supported from D3hot D3cold
[    0.198903] pci 0000:05:00.0: PME# disabled
[    0.199016] pci 0000:00:03.2: bridge 32bit mmio: [0xfbe00000-0xfbefffff]
[    0.199071] pci 0000:00:03.3: bridge 64bit mmio pref: [0xf7f00000-0xf7ffffff]
[    0.199166] pci 0000:08:08.0: reg 10 32bit mmio: [0xfbfe0000-0xfbffffff]
[    0.199173] pci 0000:08:08.0: reg 14 32bit mmio: [0xfbfc0000-0xfbfdffff]
[    0.199179] pci 0000:08:08.0: reg 18 io port: [0xec00-0xec3f]
[    0.199197] pci 0000:08:08.0: reg 30 32bit mmio: [0xfbfa0000-0xfbfbffff]
[    0.199218] pci 0000:08:08.0: PME# supported from D0 D3hot D3cold
[    0.199285] pci 0000:08:08.0: PME# disabled
[    0.199384] pci 0000:08:09.0: reg 10 32bit mmio: [0xfbf80000-0xfbf9ffff]
[    0.199391] pci 0000:08:09.0: reg 14 32bit mmio: [0xfbf60000-0xfbf7ffff]
[    0.199398] pci 0000:08:09.0: reg 18 io port: [0xe880-0xe8bf]
[    0.199416] pci 0000:08:09.0: reg 30 32bit mmio: [0xfbf40000-0xfbf5ffff]
[    0.199436] pci 0000:08:09.0: PME# supported from D0 D3hot D3cold
[    0.199504] pci 0000:08:09.0: PME# disabled
[    0.199596] pci 0000:00:13.1: transparent bridge
[    0.199661] pci 0000:00:13.1: bridge io port: [0xe000-0xefff]
[    0.199665] pci 0000:00:13.1: bridge 32bit mmio: [0xfbf00000-0xfbffffff]
[    0.199707] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[    0.199885] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P1._PRT]
[    0.199959] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.NBPG._PRT]
[    0.200037] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.NBP0._PRT]
[    0.200110] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.NBP1._PRT]
[    0.200182] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.NBP2._PRT]
[    0.200255] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.NBP3._PRT]
[    0.200341] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P7._PRT]
[    0.200418] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0PA._PRT]
[    0.224836] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 *5 6 7 10 11 12 14 15)
[    0.224898] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 *10 11 12 14 15)
[    0.225662] ACPI: PCI Interrupt Link [LNKC] (IRQs *3 4 5 6 7 10 11 12 14 15)
[    0.232146] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 10 *11 12 14 15)
[    0.232911] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
[    0.233779] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
[    0.236585] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
[    0.237649] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 10 *11 12 14 15)
[    0.238335] usbcore: registered new interface driver usbfs
[    0.238335] usbcore: registered new interface driver hub
[    0.238335] usbcore: registered new device driver usb
[    0.238335] PCI: Using ACPI for IRQ routing
[    0.256011] pnp: PnP ACPI init
[    0.256081] ACPI: bus type pnp registered
[    0.261227] pnp: PnP ACPI: found 15 devices
[    0.261227] ACPI: ACPI bus type pnp unregistered
[    0.261227] system 00:07: ioport range 0xc00-0xc0f has been reserved
[    0.261227] system 00:07: ioport range 0xd00-0xd0f has been reserved
[    0.264005] system 00:07: ioport range 0xa20-0xa2f has been reserved
[    0.264071] system 00:07: ioport range 0xa30-0xa3f has been reserved
[    0.264144] system 00:09: ioport range 0x3e0-0x3e7 has been reserved
[    0.264212] system 00:09: ioport range 0x4d0-0x4d1 has been reserved
[    0.264278] system 00:09: ioport range 0x800-0x87f has been reserved
[    0.264345] system 00:09: ioport range 0x400-0x41f has been reserved
[    0.264415] system 00:0a: iomem range 0xfec00000-0xfec00fff could not be reserved
[    0.264493] system 00:0a: iomem range 0xfee00000-0xfee00fff has been reserved
[    0.264564] system 00:0d: iomem range 0xe0000000-0xefffffff has been reserved
[    0.264634] system 00:0e: iomem range 0x0-0x9ffff could not be reserved
[    0.264701] system 00:0e: iomem range 0xc0000-0xcffff has been reserved
[    0.264768] system 00:0e: iomem range 0xe0000-0xfffff could not be reserved
[    0.264835] system 00:0e: iomem range 0x100000-0x7fffffff could not be reserved
[    0.264913] system 00:0e: iomem range 0xff380000-0xffffffff could not be reserved
[    0.270013] pci 0000:00:01.0: PCI bridge, secondary bus 0000:01
[    0.270079] pci 0000:00:01.0:   IO window: disabled
[    0.270146] pci 0000:00:01.0:   MEM window: disabled
[    0.270211] pci 0000:00:01.0:   PREFETCH window: disabled
[    0.270279] pci 0000:00:02.0: PCI bridge, secondary bus 0000:02
[    0.270344] pci 0000:00:02.0:   IO window: disabled
[    0.270410] pci 0000:00:02.0:   MEM window: 0xf9000000-0xfbcfffff
[    0.270477] pci 0000:00:02.0:   PREFETCH window: 0x000000d0000000-0x000000dfffffff
[    0.270557] pci 0000:00:03.0: PCI bridge, secondary bus 0000:03
[    0.270623] pci 0000:00:03.0:   IO window: 0xd000-0xdfff
[    0.270690] pci 0000:00:03.0:   MEM window: 0xfbd00000-0xfbdfffff
[    0.270757] pci 0000:00:03.0:   PREFETCH window: disabled
[    0.270826] pci 0000:00:03.1: PCI bridge, secondary bus 0000:04
[    0.270890] pci 0000:00:03.1:   IO window: disabled
[    0.270956] pci 0000:00:03.1:   MEM window: disabled
[    0.271022] pci 0000:00:03.1:   PREFETCH window: 0x000000f7e00000-0x000000f7efffff
[    0.271103] pci 0000:00:03.2: PCI bridge, secondary bus 0000:05
[    0.271168] pci 0000:00:03.2:   IO window: disabled
[    0.271234] pci 0000:00:03.2:   MEM window: 0xfbe00000-0xfbefffff
[    0.271301] pci 0000:00:03.2:   PREFETCH window: disabled
[    0.271369] pci 0000:00:03.3: PCI bridge, secondary bus 0000:06
[    0.271434] pci 0000:00:03.3:   IO window: disabled
[    0.271500] pci 0000:00:03.3:   MEM window: disabled
[    0.271566] pci 0000:00:03.3:   PREFETCH window: 0x000000f7f00000-0x000000f7ffffff
[    0.271647] pci 0000:00:13.0: PCI bridge, secondary bus 0000:07
[    0.271712] pci 0000:00:13.0:   IO window: disabled
[    0.271778] pci 0000:00:13.0:   MEM window: disabled
[    0.271843] pci 0000:00:13.0:   PREFETCH window: disabled
[    0.271912] pci 0000:00:13.1: PCI bridge, secondary bus 0000:08
[    0.271978] pci 0000:00:13.1:   IO window: 0xe000-0xefff
[    0.272013] Switched to high resolution mode on CPU 0
[    0.272019] pci 0000:00:13.1:   MEM window: 0xfbf00000-0xfbffffff
[    0.272085] pci 0000:00:13.1:   PREFETCH window: 0x00000088000000-0x000000880fffff
[    0.272173] pci 0000:00:01.0: setting latency timer to 64
[    0.272181]   alloc irq_desc for 27 on cpu 0 node 0
[    0.272184]   alloc kstat_irqs on cpu 0 node 0
[    0.272190] pci 0000:00:02.0: PCI INT A -> GSI 27 (level, low) -> IRQ 27
[    0.272258] pci 0000:00:02.0: setting latency timer to 64
[    0.272266]   alloc irq_desc for 31 on cpu 0 node 0
[    0.272268]   alloc kstat_irqs on cpu 0 node 0
[    0.272272] pci 0000:00:03.0: PCI INT A -> GSI 31 (level, low) -> IRQ 31
[    0.272341] pci 0000:00:03.0: setting latency timer to 64
[    0.272349] Switched to high resolution mode on CPU 1
[    0.272353]   alloc irq_desc for 35 on cpu 0 node 0
[    0.272356]   alloc kstat_irqs on cpu 0 node 0
[    0.272361] pci 0000:00:03.1: PCI INT B -> GSI 35 (level, low) -> IRQ 35
[    0.272429] pci 0000:00:03.1: setting latency timer to 64
[    0.272437]   alloc irq_desc for 39 on cpu 0 node 0
[    0.272439]   alloc kstat_irqs on cpu 0 node 0
[    0.272443] pci 0000:00:03.2: PCI INT C -> GSI 39 (level, low) -> IRQ 39
[    0.272511] pci 0000:00:03.2: setting latency timer to 64
[    0.272518]   alloc irq_desc for 43 on cpu 0 node 0
[    0.272520]   alloc kstat_irqs on cpu 0 node 0
[    0.272525] pci 0000:00:03.3: PCI INT D -> GSI 43 (level, low) -> IRQ 43
[    0.272593] pci 0000:00:03.3: setting latency timer to 64
[    0.272599] pci 0000:00:13.0: setting latency timer to 64
[    0.272605] pci 0000:00:13.1: setting latency timer to 64
[    0.272610] pci_bus 0000:00: resource 0 io:  [0x00-0xffff]
[    0.272613] pci_bus 0000:00: resource 1 mem: [0x000000-0xffffffffffffffff]
[    0.272617] pci_bus 0000:02: resource 1 mem: [0xf9000000-0xfbcfffff]
[    0.272620] pci_bus 0000:02: resource 2 pref mem [0xd0000000-0xdfffffff]
[    0.272623] pci_bus 0000:03: resource 0 io:  [0xd000-0xdfff]
[    0.272626] pci_bus 0000:03: resource 1 mem: [0xfbd00000-0xfbdfffff]
[    0.272629] pci_bus 0000:04: resource 2 pref mem [0xf7e00000-0xf7efffff]
[    0.272632] pci_bus 0000:05: resource 1 mem: [0xfbe00000-0xfbefffff]
[    0.272636] pci_bus 0000:06: resource 2 pref mem [0xf7f00000-0xf7ffffff]
[    0.272639] pci_bus 0000:08: resource 0 io:  [0xe000-0xefff]
[    0.272642] pci_bus 0000:08: resource 1 mem: [0xfbf00000-0xfbffffff]
[    0.272645] pci_bus 0000:08: resource 2 pref mem [0x88000000-0x880fffff]
[    0.272647] pci_bus 0000:08: resource 3 io:  [0x00-0xffff]
[    0.272650] pci_bus 0000:08: resource 4 mem: [0x000000-0xffffffffffffffff]
[    0.272761] NET: Registered protocol family 2
[    0.308156] IP route cache hash table entries: 65536 (order: 7, 524288 bytes)
[    0.309350] TCP established hash table entries: 262144 (order: 10, 4194304 bytes)
[    0.311347] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[    0.311914] TCP: Hash tables configured (established 262144 bind 65536)
[    0.311982] TCP reno registered
[    0.320139] NET: Registered protocol family 1
[    0.320268] Trying to unpack rootfs image as initramfs...
[    0.641392] Freeing initrd memory: 8197k freed
[    0.647355] audit: initializing netlink socket (disabled)
[    0.647435] type=2000 audit(1250016895.644:1): initialized
[    0.647832] HugeTLB registered 2 MB page size, pre-allocated 0 pages
[    0.648103] VFS: Disk quotas dquot_6.5.2
[    0.648210] Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    0.648347] msgmni has been set to 4026
[    0.648640] alg: No test for stdrng (krng)
[    0.648781] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 253)
[    0.648859] io scheduler noop registered
[    0.648922] io scheduler anticipatory registered
[    0.648985] io scheduler deadline registered
[    0.649085] io scheduler cfq registered (default)
[    0.649153] pci 0000:00:00.0: MSI quirk detected; MSI disabled
[    0.649232] pci 0000:00:01.0: disabling DAC on VIA PCI bridge
[    0.649398] pci 0000:02:00.0: Boot video device
[    0.649657] pcieport-driver 0000:00:02.0: setting latency timer to 64
[    0.649925] pcieport-driver 0000:00:03.0: setting latency timer to 64
[    0.650198] pcieport-driver 0000:00:03.1: setting latency timer to 64
[    0.650466] pcieport-driver 0000:00:03.2: setting latency timer to 64
[    0.650738] pcieport-driver 0000:00:03.3: setting latency timer to 64
[    0.651046] aer 0000:00:02.0:pcie02: AER service couldn't init device: no _OSC support
[    0.651054] aer 0000:00:03.0:pcie02: AER service couldn't init device: no _OSC support
[    0.651062] aer 0000:00:03.1:pcie02: AER service couldn't init device: no _OSC support
[    0.651069] aer 0000:00:03.2:pcie02: AER service couldn't init device: no _OSC support
[    0.651076] aer 0000:00:03.3:pcie02: AER service couldn't init device: no _OSC support
[    0.655646] Linux agpgart interface v0.103
[    0.655712] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    0.655920] serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[    0.656572] 00:0b: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[    0.658762] brd: module loaded
[    0.658919] input: Macintosh mouse button emulation as /devices/virtual/input/input0
[    0.659221] PNP: PS/2 Controller [PNP0303:PS2K] at 0x60,0x64 irq 1
[    0.659286] PNP: PS/2 appears to have AUX port disabled, if this is incorrect please boot with i8042.nopnp
[    0.659514] serio: i8042 KBD port at 0x60,0x64 irq 1
[    0.659769] mice: PS/2 mouse device common for all mice
[    0.659903] rtc_cmos 00:02: RTC can wake from S4
[    0.660181] rtc_cmos 00:02: rtc core: registered rtc_cmos as rtc0
[    0.660278] rtc0: alarms up to one year, y3k, 114 bytes nvram
[    0.660387] cpuidle: using governor ladder
[    0.660449] cpuidle: using governor menu
[    0.660516] No iBFT detected.
[    0.660952] TCP cubic registered
[    0.661129] NET: Registered protocol family 10
[    0.661741] lo: Disabled Privacy Extensions
[    0.662127] Mobile IPv6
[    0.662189] NET: Registered protocol family 17
[    0.662443] registered taskstats version 1
[    0.662766] rtc_cmos 00:02: setting system clock to 2009-08-11 18:54:56 UTC (1250016896)
[    0.662917] Freeing unused kernel memory: 560k freed
[    0.663310] Write protecting the kernel read-only data: 3796k
[    0.756940] SCSI subsystem initialized
[    0.772714] libata version 3.00 loaded.
[    0.776434] ahci 0000:03:00.0: version 3.0
[    0.776452]   alloc irq_desc for 28 on cpu 0 node 0
[    0.776455]   alloc kstat_irqs on cpu 0 node 0
[    0.776464] ahci 0000:03:00.0: PCI INT A -> GSI 28 (level, low) -> IRQ 28
[    0.776554] ahci 0000:03:00.0: controller can't do NCQ, turning off CAP_NCQ
[    0.776621] ahci 0000:03:00.0: controller can't do PMP, turning off CAP_PMP
[    0.776688] ahci 0000:03:00.0: MV_AHCI HACK: port_map 7 -> 3
[    0.776753] ahci 0000:03:00.0: Disabling your PATA port. Use the boot option 'ahci.marvell_enable=0' to avoid this.
[    0.776873] ahci: SSS flag set, parallel bus scan disabled
[    0.776943] ahci 0000:03:00.0: PCI: Disallowing DAC for device
[    0.777032] ahci 0000:03:00.0: AHCI 0001.0000 32 slots 3 ports 3 Gbps 0x3 impl SATA mode
[    0.777111] ahci 0000:03:00.0: flags: 64bit stag led slum part 
[    0.777179] ahci 0000:03:00.0: setting latency timer to 64
[    0.777408] scsi0 : ahci
[    0.777710] scsi1 : ahci
[    0.777916] scsi2 : ahci
[    0.778094] ata1: SATA max UDMA/133 abar m1024@0xfbdffc00 port 0xfbdffd00 irq 28
[    0.778172] ata2: SATA max UDMA/133 abar m1024@0xfbdffc00 port 0xfbdffd80 irq 28
[    0.778249] ata3: DUMMY
[    1.096024] ata1: SATA link down (SStatus 0 SControl 300)
[    1.416021] ata2: SATA link down (SStatus 0 SControl 300)
[    1.587880] FDC 0 is a post-1991 82077
[    1.674765]   alloc irq_desc for 36 on cpu 0 node 0
[    1.674769]   alloc kstat_irqs on cpu 0 node 0
[    1.674780] atl1 0000:05:00.0: PCI INT A -> GSI 36 (level, low) -> IRQ 36
[    1.674856] atl1 0000:05:00.0: setting latency timer to 64
[    1.674896] atl1 0000:05:00.0: version 2.1.3
[    1.699603] uhci_hcd: USB Universal Host Controller Interface driver
[    1.744670] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    1.744738] Warning! ehci_hcd should always be loaded before uhci_hcd and ohci_hcd, not after
[    1.772789] sata_via 0000:00:0f.0: version 2.4
[    1.772809]   alloc irq_desc for 21 on cpu 0 node 0
[    1.772812]   alloc kstat_irqs on cpu 0 node 0
[    1.772821] sata_via 0000:00:0f.0: PCI INT B -> GSI 21 (level, low) -> IRQ 21
[    1.772940] sata_via 0000:00:0f.0: routed to hard irq line 10
[    1.773211] scsi3 : sata_via
[    1.788683] Intel(R) PRO/1000 Network Driver - version 7.3.21-k3-NAPI
[    1.788752] Copyright (c) 1999-2006 Intel Corporation.
[    1.805119] scsi4 : sata_via
[    1.806868] ata4: SATA max UDMA/133 cmd 0xcc00 ctl 0xc880 bmdma 0xc400 irq 21
[    1.806935] ata5: SATA max UDMA/133 cmd 0xc800 ctl 0xc480 bmdma 0xc408 irq 21
[    1.819648]   alloc irq_desc for 18 on cpu 0 node 0
[    1.819653]   alloc kstat_irqs on cpu 0 node 0
[    1.819664] e1000 0000:08:08.0: PCI INT A -> GSI 18 (level, low) -> IRQ 18
[    1.819735] e1000 0000:08:08.0: PCI: Disallowing DAC for device
[    1.826711]   alloc irq_desc for 20 on cpu 0 node 0
[    1.826715]   alloc kstat_irqs on cpu 0 node 0
[    1.826726] uhci_hcd 0000:00:10.0: PCI INT A -> GSI 20 (level, low) -> IRQ 20
[    1.826804] uhci_hcd 0000:00:10.0: UHCI Host Controller
[    1.826975] uhci_hcd 0000:00:10.0: new USB bus registered, assigned bus number 1
[    1.827086] uhci_hcd 0000:00:10.0: irq 20, io base 0x0000bc00
[    1.827199] usb usb1: New USB device found, idVendor=1d6b, idProduct=0001
[    1.827266] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.827343] usb usb1: Product: UHCI Host Controller
[    1.833142] usb usb1: Manufacturer: Linux 2.6.30-bpo.1-amd64 uhci_hcd
[    1.833207] usb usb1: SerialNumber: 0000:00:10.0
[    1.833329] usb usb1: configuration #1 chosen from 1 choice
[    1.833425] hub 1-0:1.0: USB hub found
[    1.833494] hub 1-0:1.0: 2 ports detected
[    1.833834] ehci_hcd 0000:00:10.4: PCI INT C -> GSI 21 (level, low) -> IRQ 21
[    1.833920] ehci_hcd 0000:00:10.4: EHCI Host Controller
[    1.834036] ehci_hcd 0000:00:10.4: new USB bus registered, assigned bus number 2
[    1.834150] ehci_hcd 0000:00:10.4: irq 21, io mem 0xf8fffc00
[    1.848058] ehci_hcd 0000:00:10.4: USB 2.0 started, EHCI 1.00
[    1.848162] usb usb2: New USB device found, idVendor=1d6b, idProduct=0002
[    1.848230] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.848307] usb usb2: Product: EHCI Host Controller
[    1.848371] usb usb2: Manufacturer: Linux 2.6.30-bpo.1-amd64 ehci_hcd
[    1.848437] usb usb2: SerialNumber: 0000:00:10.4
[    1.848595] usb usb2: configuration #1 chosen from 1 choice
[    1.848697] hub 2-0:1.0: USB hub found
[    1.848767] hub 2-0:1.0: 8 ports detected
[    1.849181]   alloc irq_desc for 22 on cpu 0 node 0
[    1.849183]   alloc kstat_irqs on cpu 0 node 0
[    1.849193] uhci_hcd 0000:00:10.1: PCI INT B -> GSI 22 (level, low) -> IRQ 22
[    1.849268] uhci_hcd 0000:00:10.1: UHCI Host Controller
[    1.849403] uhci_hcd 0000:00:10.1: new USB bus registered, assigned bus number 3
[    1.849516] uhci_hcd 0000:00:10.1: irq 22, io base 0x0000b880
[    1.849625] usb usb3: New USB device found, idVendor=1d6b, idProduct=0001
[    1.849691] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.849768] usb usb3: Product: UHCI Host Controller
[    1.849832] usb usb3: Manufacturer: Linux 2.6.30-bpo.1-amd64 uhci_hcd
[    1.849897] usb usb3: SerialNumber: 0000:00:10.1
[    1.850015] usb usb3: configuration #1 chosen from 1 choice
[    1.850111] hub 3-0:1.0: USB hub found
[    1.850184] hub 3-0:1.0: 2 ports detected
[    1.850405] uhci_hcd 0000:00:10.2: PCI INT C -> GSI 21 (level, low) -> IRQ 21
[    1.850476] uhci_hcd 0000:00:10.2: UHCI Host Controller
[    1.850596] uhci_hcd 0000:00:10.2: new USB bus registered, assigned bus number 4
[    1.850694] uhci_hcd 0000:00:10.2: irq 21, io base 0x0000b800
[    1.850800] usb usb4: New USB device found, idVendor=1d6b, idProduct=0001
[    1.850867] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.850944] usb usb4: Product: UHCI Host Controller
[    1.851007] usb usb4: Manufacturer: Linux 2.6.30-bpo.1-amd64 uhci_hcd
[    1.851073] usb usb4: SerialNumber: 0000:00:10.2
[    1.851190] usb usb4: configuration #1 chosen from 1 choice
[    1.851282] hub 4-0:1.0: USB hub found
[    1.851350] hub 4-0:1.0: 2 ports detected
[    1.851549]   alloc irq_desc for 23 on cpu 0 node 0
[    1.851551]   alloc kstat_irqs on cpu 0 node 0
[    1.851556] uhci_hcd 0000:00:10.3: PCI INT D -> GSI 23 (level, low) -> IRQ 23
[    1.851626] uhci_hcd 0000:00:10.3: UHCI Host Controller
[    1.851743] uhci_hcd 0000:00:10.3: new USB bus registered, assigned bus number 5
[    1.851846] uhci_hcd 0000:00:10.3: irq 23, io base 0x0000b480
[    1.851950] usb usb5: New USB device found, idVendor=1d6b, idProduct=0001
[    1.852067] usb usb5: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.852143] usb usb5: Product: UHCI Host Controller
[    1.852207] usb usb5: Manufacturer: Linux 2.6.30-bpo.1-amd64 uhci_hcd
[    1.852272] usb usb5: SerialNumber: 0000:00:10.3
[    1.852389] usb usb5: configuration #1 chosen from 1 choice
[    1.852481] hub 5-0:1.0: USB hub found
[    1.852548] hub 5-0:1.0: 2 ports detected
[    2.009014] ata4: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    2.079662] e1000: 0000:08:08.0: e1000_probe: (PCI:33MHz:32-bit) 00:0e:0c:b3:a1:65
[    2.173901] ata4.00: ATA-8: WDC WD5002ABYS-01B1B0, 02.03B02, max UDMA/133
[    2.173972] ata4.00: 976773168 sectors, multi 16: LBA48 NCQ (depth 0/32)
[    2.188938] ata4.00: configured for UDMA/133
[    2.189125] scsi 3:0:0:0: Direct-Access     ATA      WDC WD5002ABYS-0 02.0 PQ: 0 ANSI: 5
[    2.258636] e1000: eth1: e1000_probe: Intel(R) PRO/1000 Network Connection
[    2.258811]   alloc irq_desc for 19 on cpu 0 node 0
[    2.258814]   alloc kstat_irqs on cpu 0 node 0
[    2.258823] e1000 0000:08:09.0: PCI INT A -> GSI 19 (level, low) -> IRQ 19
[    2.258891] e1000 0000:08:09.0: PCI: Disallowing DAC for device
[    2.393012] ata5: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    2.515659] e1000: 0000:08:09.0: e1000_probe: (PCI:33MHz:32-bit) 00:0e:0c:b3:a1:33
[    2.557049] ata5.00: ATA-8: WDC WD5002ABYS-01B1B0, 02.03B02, max UDMA/133
[    2.557118] ata5.00: 976773168 sectors, multi 16: LBA48 NCQ (depth 0/32)
[    2.574109] ata5.00: configured for UDMA/133
[    2.582177] scsi 4:0:0:0: Direct-Access     ATA      WDC WD5002ABYS-0 02.0 PQ: 0 ANSI: 5
[    2.593210] Uniform Multi-Platform E-IDE driver
[    2.597172] via82cxxx 0000:00:0f.1: VIA vt8237a (rev 00) IDE UDMA133
[    2.597244] via82cxxx 0000:00:0f.1: IDE controller (0x1106:0x0571 rev 0x07)
[    2.597349] via82cxxx 0000:00:0f.1: not 100% native mode: will probe irqs later
[    2.597430]     ide0: BM-DMA at 0xfc00-0xfc07
[    2.597498]     ide1: BM-DMA at 0xfc08-0xfc0f
[    2.597564] Probing IDE interface ide0...
[    2.686674] e1000: eth2: e1000_probe: Intel(R) PRO/1000 Network Connection
[    2.688984] udev: renamed network interface eth1 to lan
[    2.689664] udev: renamed network interface eth2 to modem
[    3.332116] hda: _NEC DVD_RW ND-4571A, ATAPI CD/DVD-ROM drive
[    4.004062] hda: host max PIO5 wanted PIO255(auto-tune) selected PIO4
[    4.004232] hda: UDMA/33 mode selected
[    4.004442] Probing IDE interface ide1...
[    4.572059] ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
[    4.573209] ide1 at 0x170-0x177,0x376 on irq 15
[    4.591511] ide-cd driver 5.00
[    4.595269] Driver 'sd' needs updating - please use bus_type methods
[    4.595542] sd 3:0:0:0: [sda] 976773168 512-byte hardware sectors: (500 GB/465 GiB)
[    4.595636] sd 3:0:0:0: [sda] Write Protect is off
[    4.595701] sd 3:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    4.595723] sd 3:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    4.595908]  sda:<6>ide-cd: hda: ATAPI 48X DVD-ROM DVD-R/RAM CD-R/RW drive, 2048kB Cache
[    4.596428] Uniform CD-ROM driver Revision: 3.20
[    4.596890] sd 4:0:0:0: [sdb] 976773168 512-byte hardware sectors: (500 GB/465 GiB)
[    4.596985] sd 4:0:0:0: [sdb] Write Protect is off
[    4.597051] sd 4:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[    4.597074] sd 4:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    4.597253]  sdb: sda1 sda2
[    4.614014]  sdb1 sdb2
[    4.628196] sd 3:0:0:0: [sda] Attached SCSI disk
[    4.629712] sd 4:0:0:0: [sdb] Attached SCSI disk
[    4.802503] md: raid1 personality registered for level 1
[    4.813303] md: md0 stopped.
[    4.817542] md: bind<sdb1>
[    4.817803] md: bind<sda1>
[    4.827131] raid1: raid set md0 active with 2 out of 2 mirrors
[    4.827990]  md0: unknown partition table
[    4.870440] device-mapper: uevent: version 1.0.3
[    4.871081] device-mapper: ioctl: 4.14.0-ioctl (2008-04-23) initialised: dm-devel@redhat.com
[    5.132155] kjournald starting.  Commit interval 5 seconds
[    5.132167] EXT3-fs: mounted filesystem with ordered data mode.
[    6.111757] udevd version 125 started
[    6.627933] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[    6.664060] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[    6.893386] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input1
[    6.893470] ACPI: Power Button [PWRF]
[    6.893628] input: Sleep Button as /devices/LNXSYSTM:00/device:00/PNP0C0E:00/input/input2
[    6.893709] ACPI: Sleep Button [SLPB]
[    6.893846] input: Power Button as /devices/LNXSYSTM:00/device:00/PNP0C0C:00/input/input3
[    6.893925] ACPI: Power Button [PWRB]
[    6.909786] processor ACPI_CPU:00: registered as cooling_device0
[    6.909856] ACPI: Processor [P001] (supports 16 throttling states)
[    6.910059] processor ACPI_CPU:01: registered as cooling_device1
[    7.050944] parport_pc 00:06: reported by Plug and Play ACPI
[    7.051057] parport0: PC-style at 0x378, irq 7 [PCSPP,TRISTATE]
[    7.456534] input: PC Speaker as /devices/platform/pcspkr/input/input4
[    7.475853] k8temp 0000:00:18.3: Temperature readouts might be wrong - check erratum #141
[    7.619935] Error: Driver 'pcspkr' is already registered, aborting...
[    8.782426] Adding 1052248k swap on /dev/sda2.  Priority:-1 extents:1 across:1052248k 
[    8.784773] Adding 1052248k swap on /dev/sdb2.  Priority:-2 extents:1 across:1052248k 
[    9.128851] EXT3 FS on dm-1, internal journal
[    9.859803] loop: module loaded
[   11.526178] kjournald starting.  Commit interval 5 seconds
[   11.526519] EXT3 FS on dm-0, internal journal
[   11.526631] EXT3-fs: mounted filesystem with ordered data mode.
[   11.573504] kjournald starting.  Commit interval 5 seconds
[   11.574401] EXT3 FS on dm-2, internal journal
[   11.574512] EXT3-fs: mounted filesystem with ordered data mode.
[   13.187385] ADDRCONF(NETDEV_UP): lan: link is not ready
[   13.210656] e1000: lan NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX/TX
[   13.211217] ADDRCONF(NETDEV_CHANGE): lan: link becomes ready
[   16.965514] PPP generic driver version 2.4.2
[   16.991056] ADDRCONF(NETDEV_UP): modem: link is not ready
[   16.993417] e1000: modem NIC Link is Up 100 Mbps Full Duplex, Flow Control: RX
[   16.993874] ADDRCONF(NETDEV_CHANGE): modem: link becomes ready
[   17.071805] ip_tables: (C) 2000-2006 Netfilter Core Team
[   17.127995] nf_conntrack version 0.5.0 (16384 buckets, 65536 max)
[   17.128287] CONFIG_NF_CT_ACCT is deprecated and will be removed soon. Please use
[   17.128363] nf_conntrack.acct=1 kernel paramater, acct=1 nf_conntrack module option or
[   17.128440] sysctl net.netfilter.nf_conntrack_acct=1 to enable it.
[   17.533639] device modem entered promiscuous mode
[   18.389831] PPP BSD Compression module registered
[   18.457820] PPP Deflate Compression module registered
[   23.848011] lan: no IPv6 routers present
[   27.548011] modem: no IPv6 routers present
[42358.165324] ata1: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0xe frozen
[42358.165360] ata1: irq_stat 0x02400000, PHY RDY changed
[42358.165387] ata1: hard resetting link
[42363.928015] ata1: link is slow to respond, please be patient (ready=0)
[42367.680027] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[42367.691705] ata1.00: ATA-6: HDS722525VLSA80, V36OA60A, max UDMA/100
[42367.691728] ata1.00: 488397168 sectors, multi 0: LBA48 
[42367.695021] ata1.00: configured for UDMA/100
[42367.695045] ata1: EH complete
[42368.816110] scsi 0:0:0:0: Direct-Access     ATA      HDS722525VLSA80  V36O PQ: 0 ANSI: 5
[42368.817968] sd 0:0:0:0: [sdc] 488397168 512-byte hardware sectors: (250 GB/232 GiB)
[42368.818019] sd 0:0:0:0: [sdc] Write Protect is off
[42368.818039] sd 0:0:0:0: [sdc] Mode Sense: 00 3a 00 00
[42368.818063] sd 0:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[42368.818224]  sdc: unknown partition table
[42368.829509] sd 0:0:0:0: [sdc] Attached SCSI disk
[55207.530919] Intel AES-NI instructions are not detected.
[55211.382754] kjournald starting.  Commit interval 5 seconds
[55211.383305] EXT3 FS on dm-3, internal journal
[55211.383328] EXT3-fs: mounted filesystem with ordered data mode.
[57822.269013] Clocksource tsc unstable (delta = 62504653 ns)
[73526.424485] ata1: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0xe frozen
[73526.424511] ata1: irq_stat 0x04400000, PHY RDY changed
[73526.424535] ata1: hard resetting link
[73527.148025] ata1: SATA link down (SStatus 0 SControl 300)
[73532.148017] ata1: hard resetting link
[73532.468024] ata1: SATA link down (SStatus 0 SControl 300)
[73532.468050] ata1: limiting SATA link speed to 1.5 Gbps
[73537.468020] ata1: hard resetting link
[73537.788024] ata1: SATA link down (SStatus 0 SControl 310)
[73537.788049] ata1.00: disabled
[73537.788077] ata1: EH complete
[73537.788102] ata1.00: detaching (SCSI 0:0:0:0)
[73537.788332] sd 0:0:0:0: [sdc] Synchronizing SCSI cache
[73537.788395] sd 0:0:0:0: [sdc] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[73537.788429] sd 0:0:0:0: [sdc] Stopping disk
[73537.788454] sd 0:0:0:0: [sdc] START_STOP FAILED
[73537.788473] sd 0:0:0:0: [sdc] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[77423.876043] PPP MPPE Compression module registered
[128508.539280] ata1: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0xe frozen
[128508.539306] ata1: irq_stat 0x02400000, PHY RDY changed
[128508.539333] ata1: hard resetting link
[128514.300013] ata1: link is slow to respond, please be patient (ready=0)
[128518.556015] ata1: COMRESET failed (errno=-16)
[128518.556040] ata1: hard resetting link
[128524.320015] ata1: link is slow to respond, please be patient (ready=0)
[128528.576014] ata1: COMRESET failed (errno=-16)
[128528.576039] ata1: hard resetting link
[128534.340014] ata1: link is slow to respond, please be patient (ready=0)
[128563.628015] ata1: COMRESET failed (errno=-16)
[128563.628041] ata1: limiting SATA link speed to 1.5 Gbps
[128563.628062] ata1: hard resetting link
[128568.664014] ata1: COMRESET failed (errno=-16)
[128568.664038] ata1: reset failed, giving up
[128568.664059] ata1: EH complete
[147111.353555] ahci 0000:03:00.0: PCI INT A disabled
[147126.926442] ahci 0000:03:00.0: version 3.0
[147126.926461] ahci 0000:03:00.0: PCI INT A -> GSI 28 (level, low) -> IRQ 28
[147126.926589] ahci 0000:03:00.0: controller can't do NCQ, turning off CAP_NCQ
[147126.926611] ahci 0000:03:00.0: controller can't do PMP, turning off CAP_PMP
[147126.926634] ahci 0000:03:00.0: MV_AHCI HACK: port_map 7 -> 3
[147126.926654] ahci 0000:03:00.0: Disabling your PATA port. Use the boot option 'ahci.marvell_enable=0' to avoid this.
[147126.926729] ahci: SSS flag set, parallel bus scan disabled
[147126.926755] ahci 0000:03:00.0: PCI: Disallowing DAC for device
[147126.926797] ahci 0000:03:00.0: AHCI 0001.0000 32 slots 3 ports 3 Gbps 0x3 impl SATA mode
[147126.926831] ahci 0000:03:00.0: flags: 64bit stag led slum part 
[147126.926857] ahci 0000:03:00.0: setting latency timer to 64
[147126.927120] scsi5 : ahci
[147126.927241] scsi6 : ahci
[147126.927319] scsi7 : ahci
[147126.927385] ata6: SATA max UDMA/133 abar m1024@0xfbdffc00 port 0xfbdffd00 irq 28
[147126.927419] ata7: SATA max UDMA/133 abar m1024@0xfbdffc00 port 0xfbdffd80 irq 28
[147126.927451] ata8: DUMMY
[147127.244029] ata6: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[147127.260634] ata6.00: ATA-6: HDS722525VLSA80, V36OA60A, max UDMA/100
[147127.260660] ata6.00: 488397168 sectors, multi 0: LBA48 
[147127.263955] ata6.00: configured for UDMA/100
[147127.264101] scsi 5:0:0:0: Direct-Access     ATA      HDS722525VLSA80  V36O PQ: 0 ANSI: 5
[147127.264340] sd 5:0:0:0: [sdc] 488397168 512-byte hardware sectors: (250 GB/232 GiB)
[147127.264388] sd 5:0:0:0: [sdc] Write Protect is off
[147127.264409] sd 5:0:0:0: [sdc] Mode Sense: 00 3a 00 00
[147127.264435] sd 5:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[147127.270283]  sdc: unknown partition table
[147127.283238] sd 5:0:0:0: [sdc] Attached SCSI disk
[147127.588026] ata7: SATA link down (SStatus 0 SControl 300)
[147157.827655] kjournald starting.  Commit interval 5 seconds
[147157.828175] EXT3 FS on dm-3, internal journal
[147157.828198] EXT3-fs: mounted filesystem with ordered data mode.

--=_oz-9270-1250166521-0001-2--
