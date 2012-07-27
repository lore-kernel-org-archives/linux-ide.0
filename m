From: Stirling Westrup <swestrup@gmail.com>
Subject: IRQ issues with multiple SiI3114's on Kernel 3.2
Date: Fri, 27 Jul 2012 12:40:33 -0400
Message-ID: <CAJt7KB8-yPm7RX8doKw1WjYwxfvVQ8Af7GNmu=QVsM_sAtYKiQ@mail.gmail.com>
Reply-To: swestrup@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gg0-f174.google.com ([209.85.161.174]:42441 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751924Ab2G0Qkf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 27 Jul 2012 12:40:35 -0400
Received: by gglu4 with SMTP id u4so3377666ggl.19
        for <linux-ide@vger.kernel.org>; Fri, 27 Jul 2012 09:40:34 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

I recently purchased a large system for use as a backup server for a
pair of small businesses. It contains a boot drive plus 10 more
storage drives. Despite having three onboard SATA controllers, the
motherboard didn't have enough SATA connectors for all the drives, so
I installed a pair of identical SiI3114 raid cards to handle the extra
connections. It has a Sandy Bridge chipset, so I installed a 3.2
kernel.

# uname -a
Linux ttt 3.2.0-0.bpo.2-amd64 #1 SMP Fri Jun 29 20:42:29 UTC 2012
x86_64 GNU/Linux

# lspci
00:00.0 Host bridge: Intel Corporation Sandy Bridge DRAM Controller (rev 09)
00:01.0 PCI bridge: Intel Corporation Sandy Bridge PCI Express Root
Port (rev 09)
00:02.0 VGA compatible controller: Intel Corporation Sandy Bridge
Integrated Graphics Controller (rev 09)
00:16.0 Communication controller: Intel Corporation Cougar Point HECI
Controller #1 (rev 04)
00:19.0 Ethernet controller: Intel Corporation 82579V Gigabit Network
Connection (rev 05)
00:1a.0 USB Controller: Intel Corporation Cougar Point USB Enhanced
Host Controller #2 (rev 05)
00:1b.0 Audio device: Intel Corporation Cougar Point High Definition
Audio Controller (rev 05)
00:1c.0 PCI bridge: Intel Corporation Cougar Point PCI Express Root
Port 1 (rev b5)
00:1c.1 PCI bridge: Intel Corporation Cougar Point PCI Express Root
Port 2 (rev b5)
00:1c.3 PCI bridge: Intel Corporation Cougar Point PCI Express Root
Port 4 (rev b5)
00:1c.4 PCI bridge: Intel Corporation Cougar Point PCI Express Root
Port 5 (rev b5)
00:1c.6 PCI bridge: Intel Corporation 82801 PCI Bridge (rev b5)
00:1c.7 PCI bridge: Intel Corporation Cougar Point PCI Express Root
Port 8 (rev b5)
00:1d.0 USB Controller: Intel Corporation Cougar Point USB Enhanced
Host Controller #1 (rev 05)
00:1f.0 ISA bridge: Intel Corporation Cougar Point LPC Controller (rev 05)
00:1f.2 SATA controller: Intel Corporation Cougar Point 6 port SATA
AHCI Controller (rev 05)
00:1f.3 SMBus: Intel Corporation Cougar Point SMBus Controller (rev 05)
03:00.0 USB Controller: Device 1b21:1042
04:00.0 SATA controller: JMicron Technology Corp. JMB362 AHCI
Controller (rev 10)
05:00.0 USB Controller: Device 1b21:1042
06:00.0 PCI bridge: Device 1b21:1080 (rev 01)
07:00.0 RAID bus controller: Silicon Image, Inc. SiI 3114
[SATALink/SATARaid] Serial ATA Controller (rev 02)
07:01.0 RAID bus controller: Silicon Image, Inc. SiI 3114
[SATALink/SATARaid] Serial ATA Controller (rev 02)
07:02.0 FireWire (IEEE 1394): VIA Technologies, Inc. VT6306/7/8 [Fire
II(M)] IEEE 1394 OHCI Controller (rev c0)
08:00.0 SATA controller: Marvell Technology Group Ltd. Device 9172 (rev 11)

The drives are connect in the following layout:

# ls -la /dev/disk/by-path/
total 0
drwxr-xr-x 2 root root 340 Jul 27 00:11 .
drwxr-xr-x 6 root root 120 Jul 27 00:11 ..
lrwxrwxrwx 1 root root   9 Jul 27 00:11 pci-0000:00:1f.2-scsi-0:0:0:0
-> ../../sr0
lrwxrwxrwx 1 root root   9 Jul 27 00:11 pci-0000:00:1f.2-scsi-1:0:0:0
-> ../../sda
lrwxrwxrwx 1 root root  10 Jul 27 00:11
pci-0000:00:1f.2-scsi-1:0:0:0-part1 -> ../../sda1
lrwxrwxrwx 1 root root  10 Jul 27 00:11
pci-0000:00:1f.2-scsi-1:0:0:0-part2 -> ../../sda2
lrwxrwxrwx 1 root root  10 Jul 27 00:11
pci-0000:00:1f.2-scsi-1:0:0:0-part3 -> ../../sda3
lrwxrwxrwx 1 root root   9 Jul 27 00:11 pci-0000:00:1f.2-scsi-2:0:0:0
-> ../../sdb
lrwxrwxrwx 1 root root   9 Jul 27 00:11 pci-0000:07:00.0-scsi-0:0:0:0
-> ../../sdd
lrwxrwxrwx 1 root root   9 Jul 27 00:11 pci-0000:07:00.0-scsi-1:0:0:0
-> ../../sde
lrwxrwxrwx 1 root root   9 Jul 27 00:11 pci-0000:07:00.0-scsi-2:0:0:0
-> ../../sdf
lrwxrwxrwx 1 root root   9 Jul 27 00:11 pci-0000:07:00.0-scsi-3:0:0:0
-> ../../sdg
lrwxrwxrwx 1 root root   9 Jul 27 00:11 pci-0000:07:01.0-scsi-0:0:0:0
-> ../../sdh
lrwxrwxrwx 1 root root   9 Jul 27 00:11 pci-0000:07:01.0-scsi-1:0:0:0
-> ../../sdi
lrwxrwxrwx 1 root root   9 Jul 27 00:11 pci-0000:07:01.0-scsi-2:0:0:0
-> ../../sdj
lrwxrwxrwx 1 root root   9 Jul 27 00:11 pci-0000:07:01.0-scsi-3:0:0:0
-> ../../sdk
lrwxrwxrwx 1 root root   9 Jul 27 00:11 pci-0000:08:00.0-scsi-0:0:0:0
-> ../../sdc

/dev/sda is the boot drive, and along with /dev/sdb is controlled by
the onboard Cougar Point controller.
/dev/sdc is controlled via the Marvell Technology controller.
/dev/sdd through /dev/sdg is controlled by the first SiI3114
/dev/sdh through /dev/sdk is controlled by the first SiI3114

Now, since I've been burned by hardware raid controllers dying in the
past, and taking their drives with them, I did a (perhaps foolish)
thing, and I
striped my raids ACROSS the two SiI3114s. That is, I built two raid6's
with the following components:

raid6: /dev/md0: /dev/sdb, /dev/sdd, /dev/sde, /dev/sdh, /dev/sdi
raid6: /dev/md1: /dev/sdc, /dev/sdf, /dev/sdg, /dev/sdj, /dev/sdk

Thus, each raid is built upon three different SATA controllers, and
loss of any one controller and all attached drives is recoverable.

Okay, enough background. Here's the issue: I had no trouble building
and sync'ing the first array, but when I try to sync the second array,
I always get the following dmesg an hour or so into the process:

irq 19: nobody cared (try booting with the "irqpoll" option)
[  346.120572] Pid: 1100, comm: md1_resync Not tainted 3.2.0-0.bpo.2-amd64 #1
[  346.120573] Call Trace:
...
[  346.120697] handlers:
[  346.120699] [<ffffffffa00479e0>] ahci_interrupt
[  346.120702] [<ffffffffa02f17ec>] sil_interrupt
[  346.120703] Disabling IRQ #19
[  346.122145] sched: RT throttling activated

>From this point onward syncing drops to a tiny fraction of its
previous speed. I've tried booting with 'irqpoll' as the error message
suggests, but it has had no effect. I'm really not sure if there is a
conflict between my two SiI3114's or between the SiI's and the Marvell
controller (although I've never had an issue with Marvell in the
past), nor how to go about diagnosing or fixing this.  I'll include a
full dmesg dump below, as well as my currently loaded modules. If
anyone wants any further info, just ask.

# dmesg
[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Linux version 3.2.0-0.bpo.2-amd64 (Debian
3.2.20-1~bpo60+1) (debian-kernel@lists.debian.org) (gcc version 4.4.5
(Debian 4.4.5-8) ) #1 SMP Fri Jun 29 20:42:29 UTC 2012
[    0.000000] Command line: BOOT_IMAGE=/vmlinuz-3.2.0-0.bpo.2-amd64
root=UUID=118651d8-368b-4b99-b34f-54d30ec810cd ro irqpoll quiet
[    0.000000] BIOS-provided physical RAM map:
[    0.000000]  BIOS-e820: 0000000000000000 - 0000000000099000 (usable)
[    0.000000]  BIOS-e820: 0000000000099000 - 00000000000a0000 (reserved)
[    0.000000]  BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
[    0.000000]  BIOS-e820: 0000000000100000 - 0000000020000000 (usable)
[    0.000000]  BIOS-e820: 0000000020000000 - 0000000020200000 (reserved)
[    0.000000]  BIOS-e820: 0000000020200000 - 0000000040000000 (usable)
[    0.000000]  BIOS-e820: 0000000040000000 - 0000000040200000 (reserved)
[    0.000000]  BIOS-e820: 0000000040200000 - 00000000da391000 (usable)
[    0.000000]  BIOS-e820: 00000000da391000 - 00000000da941000 (reserved)
[    0.000000]  BIOS-e820: 00000000da941000 - 00000000dab86000 (ACPI NVS)
[    0.000000]  BIOS-e820: 00000000dab86000 - 00000000dab94000 (ACPI data)
[    0.000000]  BIOS-e820: 00000000dab94000 - 00000000dabc1000 (ACPI NVS)
[    0.000000]  BIOS-e820: 00000000dabc1000 - 00000000dabc6000 (ACPI data)
[    0.000000]  BIOS-e820: 00000000dabc6000 - 00000000dac09000 (ACPI NVS)
[    0.000000]  BIOS-e820: 00000000dac09000 - 00000000db000000 (usable)
[    0.000000]  BIOS-e820: 00000000db800000 - 00000000dfa00000 (reserved)
[    0.000000]  BIOS-e820: 00000000f8000000 - 00000000fc000000 (reserved)
[    0.000000]  BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
[    0.000000]  BIOS-e820: 00000000fed00000 - 00000000fed04000 (reserved)
[    0.000000]  BIOS-e820: 00000000fed1c000 - 00000000fed20000 (reserved)
[    0.000000]  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
[    0.000000]  BIOS-e820: 00000000ff000000 - 0000000100000000 (reserved)
[    0.000000]  BIOS-e820: 0000000100000000 - 000000021f600000 (usable)
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] DMI 2.6 present.
[    0.000000] DMI: System manufacturer System Product Name/P8Z68-V
PRO GEN3, BIOS 3202 02/17/2012
[    0.000000] e820 update range: 0000000000000000 - 0000000000010000
(usable) ==> (reserved)
[    0.000000] e820 remove range: 00000000000a0000 - 0000000000100000 (usable)
[    0.000000] No AGP bridge found
[    0.000000] last_pfn = 0x21f600 max_arch_pfn = 0x400000000
[    0.000000] MTRR default type: uncachable
[    0.000000] MTRR fixed ranges enabled:
[    0.000000]   00000-9FFFF write-back
[    0.000000]   A0000-BFFFF uncachable
[    0.000000]   C0000-CFFFF write-protect
[    0.000000]   D0000-E7FFF uncachable
[    0.000000]   E8000-FFFFF write-protect
[    0.000000] MTRR variable ranges enabled:
[    0.000000]   0 base 000000000 mask E00000000 write-back
[    0.000000]   1 base 200000000 mask FE0000000 write-back
[    0.000000]   2 base 0E0000000 mask FE0000000 uncachable
[    0.000000]   3 base 0DC000000 mask FFC000000 uncachable
[    0.000000]   4 base 0DB800000 mask FFF800000 uncachable
[    0.000000]   5 base 21F800000 mask FFF800000 uncachable
[    0.000000]   6 base 21F600000 mask FFFE00000 uncachable
[    0.000000]   7 disabled
[    0.000000]   8 disabled
[    0.000000]   9 disabled
[    0.000000] x86 PAT enabled: cpu 0, old 0x7040600070406, new 0x7010600070106
[    0.000000] e820 update range: 00000000db800000 - 0000000100000000
(usable) ==> (reserved)
[    0.000000] last_pfn = 0xdb000 max_arch_pfn = 0x400000000
[    0.000000] found SMP MP-table at [ffff8800000fcde0] fcde0
[    0.000000] initial memory mapped : 0 - 20000000
[    0.000000] Base memory trampoline at [ffff880000094000] 94000 size 20480
[    0.000000] init_memory_mapping: 0000000000000000-00000000db000000
[    0.000000]  0000000000 - 00db000000 page 2M
[    0.000000] kernel direct mapping tables up to db000000 @ 1fffb000-20000000
[    0.000000] init_memory_mapping: 0000000100000000-000000021f600000
[    0.000000]  0100000000 - 021f600000 page 2M
[    0.000000] kernel direct mapping tables up to 21f600000 @ daff6000-db000000
[    0.000000] RAMDISK: 17d91000 - 18040000
[    0.000000] ACPI: RSDP 00000000000f0450 00024 (v02 ALASKA)
[    0.000000] ACPI: XSDT 00000000dab86070 00064 (v01 ALASKA    A M I
01072009 AMI  00010013)
[    0.000000] ACPI: FACP 00000000dab91c68 000F4 (v04 ALASKA    A M I
01072009 AMI  00010013)
[    0.000000] ACPI: DSDT 00000000dab86168 0BAFE (v02 ALASKA    A M I
00000015 INTL 20051117)
[    0.000000] ACPI: FACS 00000000dabbff80 00040
[    0.000000] ACPI: APIC 00000000dab91d60 00072 (v03 ALASKA    A M I
01072009 AMI  00010013)
[    0.000000] ACPI: MCFG 00000000dab91dd8 0003C (v01 ALASKA    A M I
01072009 MSFT 00000097)
[    0.000000] ACPI: HPET 00000000dab91e18 00038 (v01 ALASKA    A M I
01072009 AMI. 00000005)
[    0.000000] ACPI: SSDT 00000000dab91e50 0036D (v01 SataRe SataTabl
00001000 INTL 20091112)
[    0.000000] ACPI: SSDT 00000000dab921c0 009AA (v01  PmRef  Cpu0Ist
00003000 INTL 20051117)
[    0.000000] ACPI: SSDT 00000000dab92b70 00A92 (v01  PmRef    CpuPm
00003000 INTL 20051117)
[    0.000000] ACPI: BGRT 00000000dab93608 00038 (v00 ALASKA    A M I
01072009 AMI  00010013)
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] No NUMA configuration found
[    0.000000] Faking a node at 0000000000000000-000000021f600000
[    0.000000] Initmem setup node 0 0000000000000000-000000021f600000
[    0.000000]   NODE_DATA [000000021f5fb000 - 000000021f5fffff]
[    0.000000]  [ffffea0000000000-ffffea00077fffff] PMD ->
[ffff880216c00000-ffff88021ddfffff] on node 0
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA      0x00000010 -> 0x00001000
[    0.000000]   DMA32    0x00001000 -> 0x00100000
[    0.000000]   Normal   0x00100000 -> 0x0021f600
[    0.000000] Movable zone start PFN for each node
[    0.000000] early_node_map[6] active PFN ranges
[    0.000000]     0: 0x00000010 -> 0x00000099
[    0.000000]     0: 0x00000100 -> 0x00020000
[    0.000000]     0: 0x00020200 -> 0x00040000
[    0.000000]     0: 0x00040200 -> 0x000da391
[    0.000000]     0: 0x000dac09 -> 0x000db000
[    0.000000]     0: 0x00100000 -> 0x0021f600
[    0.000000] On node 0 totalpages: 2070801
[    0.000000]   DMA zone: 56 pages used for memmap
[    0.000000]   DMA zone: 5 pages reserved
[    0.000000]   DMA zone: 3916 pages, LIFO batch:0
[    0.000000]   DMA32 zone: 14280 pages used for memmap
[    0.000000]   DMA32 zone: 875456 pages, LIFO batch:31
[    0.000000]   Normal zone: 16093 pages used for memmap
[    0.000000]   Normal zone: 1160995 pages, LIFO batch:31
[    0.000000] ACPI: PM-Timer IO Port: 0x408
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x02] lapic_id[0x02] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x03] lapic_id[0x01] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x04] lapic_id[0x03] enabled)
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xff] high edge lint[0x1])
[    0.000000] ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ2 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] ACPI: HPET id: 0x8086a701 base: 0xfed00000
[    0.000000] SMP: Allowing 4 CPUs, 0 hotplug CPUs
[    0.000000] nr_irqs_gsi: 40
[    0.000000] PM: Registered nosave memory: 0000000000099000 - 00000000000a0000
[    0.000000] PM: Registered nosave memory: 00000000000a0000 - 00000000000e0000
[    0.000000] PM: Registered nosave memory: 00000000000e0000 - 0000000000100000
[    0.000000] PM: Registered nosave memory: 0000000020000000 - 0000000020200000
[    0.000000] PM: Registered nosave memory: 0000000040000000 - 0000000040200000
[    0.000000] PM: Registered nosave memory: 00000000da391000 - 00000000da941000
[    0.000000] PM: Registered nosave memory: 00000000da941000 - 00000000dab86000
[    0.000000] PM: Registered nosave memory: 00000000dab86000 - 00000000dab94000
[    0.000000] PM: Registered nosave memory: 00000000dab94000 - 00000000dabc1000
[    0.000000] PM: Registered nosave memory: 00000000dabc1000 - 00000000dabc6000
[    0.000000] PM: Registered nosave memory: 00000000dabc6000 - 00000000dac09000
[    0.000000] PM: Registered nosave memory: 00000000db000000 - 00000000db800000
[    0.000000] PM: Registered nosave memory: 00000000db800000 - 00000000dfa00000
[    0.000000] PM: Registered nosave memory: 00000000dfa00000 - 00000000f8000000
[    0.000000] PM: Registered nosave memory: 00000000f8000000 - 00000000fc000000
[    0.000000] PM: Registered nosave memory: 00000000fc000000 - 00000000fec00000
[    0.000000] PM: Registered nosave memory: 00000000fec00000 - 00000000fec01000
[    0.000000] PM: Registered nosave memory: 00000000fec01000 - 00000000fed00000
[    0.000000] PM: Registered nosave memory: 00000000fed00000 - 00000000fed04000
[    0.000000] PM: Registered nosave memory: 00000000fed04000 - 00000000fed1c000
[    0.000000] PM: Registered nosave memory: 00000000fed1c000 - 00000000fed20000
[    0.000000] PM: Registered nosave memory: 00000000fed20000 - 00000000fee00000
[    0.000000] PM: Registered nosave memory: 00000000fee00000 - 00000000fee01000
[    0.000000] PM: Registered nosave memory: 00000000fee01000 - 00000000ff000000
[    0.000000] PM: Registered nosave memory: 00000000ff000000 - 0000000100000000
[    0.000000] Allocating PCI resources starting at dfa00000 (gap:
dfa00000:18600000)
[    0.000000] Booting paravirtualized kernel on bare hardware
[    0.000000] setup_percpu: NR_CPUS:512 nr_cpumask_bits:512
nr_cpu_ids:4 nr_node_ids:1
[    0.000000] PERCPU: Embedded 28 pages/cpu @ffff88021f200000 s82304
r8192 d24192 u524288
[    0.000000] pcpu-alloc: s82304 r8192 d24192 u524288 alloc=1*2097152
[    0.000000] pcpu-alloc: [0] 0 1 2 3
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.
Total pages: 2040367
[    0.000000] Policy zone: Normal
[    0.000000] Kernel command line:
BOOT_IMAGE=/vmlinuz-3.2.0-0.bpo.2-amd64
root=UUID=118651d8-368b-4b99-b34f-54d30ec810cd ro irqpoll quiet
[    0.000000] Misrouted IRQ fixup and polling support enabled
[    0.000000] This may significantly impact system performance
[    0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
[    0.000000] xsave/xrstor: enabled xstate_bv 0x7, cntxt size 0x340
[    0.000000] Checking aperture...
[    0.000000] No AGP bridge found
[    0.000000] Calgary: detecting Calgary via BIOS EBDA area
[    0.000000] Calgary: Unable to locate Rio Grande table in EBDA - bailing!
[    0.000000] Memory: 8088628k/8902656k available (3517k kernel code,
619452k absent, 194576k reserved, 3216k data, 612k init)
[    0.000000] Hierarchical RCU implementation.
[    0.000000] 	RCU dyntick-idle grace-period acceleration is enabled.
[    0.000000] NR_IRQS:33024 nr_irqs:712 16
[    0.000000] Extended CMOS year: 2000
[    0.000000] Console: colour VGA+ 80x25
[    0.000000] console [tty0] enabled
[    0.000000] hpet clockevent registered
[    0.000000] Fast TSC calibration using PIT
[    0.004000] Detected 3110.150 MHz processor.
[    0.000001] Calibrating delay loop (skipped), value calculated
using timer frequency.. 6220.30 BogoMIPS (lpj=12440600)
[    0.000004] pid_max: default: 32768 minimum: 301
[    0.000031] Security Framework initialized
[    0.000034] AppArmor: AppArmor disabled by boot time parameter
[    0.000525] Dentry cache hash table entries: 1048576 (order: 11,
8388608 bytes)
[    0.001852] Inode-cache hash table entries: 524288 (order: 10, 4194304 bytes)
[    0.002408] Mount-cache hash table entries: 256
[    0.002487] Initializing cgroup subsys cpuacct
[    0.002490] Initializing cgroup subsys memory
[    0.002498] Initializing cgroup subsys devices
[    0.002500] Initializing cgroup subsys freezer
[    0.002501] Initializing cgroup subsys net_cls
[    0.002503] Initializing cgroup subsys blkio
[    0.002507] Initializing cgroup subsys perf_event
[    0.002527] CPU: Physical Processor ID: 0
[    0.002528] CPU: Processor Core ID: 0
[    0.002532] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
[    0.002532] ENERGY_PERF_BIAS: View and update with x86_energy_perf_policy(8)
[    0.002534] mce: CPU supports 7 MCE banks
[    0.002543] CPU0: Thermal monitoring enabled (TM1)
[    0.002548] using mwait in idle threads.
[    0.003385] ACPI: Core revision 20110623
[    0.220687] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.260341] CPU0: Intel(R) Core(TM) i3-2100 CPU @ 3.10GHz stepping 07
[    0.368106] Performance Events: PEBS fmt1+, SandyBridge events,
Intel PMU driver.
[    0.368110] PEBS disabled due to CPU errata.
[    0.368112] ... version:                3
[    0.368113] ... bit width:              48
[    0.368113] ... generic registers:      4
[    0.368114] ... value mask:             0000ffffffffffff
[    0.368115] ... max period:             000000007fffffff
[    0.368116] ... fixed-purpose events:   3
[    0.368117] ... event mask:             000000070000000f
[    0.368203] NMI watchdog enabled, takes one hw-pmu counter.
[    0.368272] Booting Node   0, Processors  #1
[    0.368273] smpboot cpu 1: start_ip = 94000
[    0.476133] NMI watchdog enabled, takes one hw-pmu counter.
[    0.476206]  #2
[    0.476207] smpboot cpu 2: start_ip = 94000
[    0.584022] NMI watchdog enabled, takes one hw-pmu counter.
[    0.584099]  #3 Ok.
[    0.584100] smpboot cpu 3: start_ip = 94000
[    0.691952] NMI watchdog enabled, takes one hw-pmu counter.
[    0.691974] Brought up 4 CPUs
[    0.691976] Total of 4 processors activated (24880.69 BogoMIPS).
[    0.694444] devtmpfs: initialized
[    0.696696] PM: Registering ACPI NVS region at da941000 (2379776 bytes)
[    0.696774] PM: Registering ACPI NVS region at dab94000 (184320 bytes)
[    0.696781] PM: Registering ACPI NVS region at dabc6000 (274432 bytes)
[    0.696890] print_constraints: dummy:
[    0.696932] NET: Registered protocol family 16
[    0.696997] ACPI FADT declares the system doesn't support PCIe
ASPM, so disable it
[    0.696999] ACPI: bus type pci registered
[    0.697049] PCI: MMCONFIG for domain 0000 [bus 00-3f] at [mem
0xf8000000-0xfbffffff] (base 0xf8000000)
[    0.697051] PCI: MMCONFIG at [mem 0xf8000000-0xfbffffff] reserved in E820
[    0.702100] PCI: Using configuration type 1 for base access
[    0.702613] bio: create slab <bio-0> at 0
[    0.702678] ACPI: Added _OSI(Module Device)
[    0.702680] ACPI: Added _OSI(Processor Device)
[    0.702681] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.702682] ACPI: Added _OSI(Processor Aggregator Device)
[    0.703769] ACPI: EC: Look up EC in DSDT
[    0.704809] ACPI: Executed 1 blocks of module-level executable AML code
[    0.720258] ACPI: SSDT 00000000da8ee018 0083B (v01  PmRef  Cpu0Cst
00003001 INTL 20051117)
[    0.720545] ACPI: Dynamic OEM Table Load:
[    0.720547] ACPI: SSDT           (null) 0083B (v01  PmRef  Cpu0Cst
00003001 INTL 20051117)
[    0.732102] ACPI: SSDT 00000000da8efa98 00303 (v01  PmRef    ApIst
00003000 INTL 20051117)
[    0.732421] ACPI: Dynamic OEM Table Load:
[    0.732423] ACPI: SSDT           (null) 00303 (v01  PmRef    ApIst
00003000 INTL 20051117)
[    0.743955] ACPI: SSDT 00000000da8f0c18 00119 (v01  PmRef    ApCst
00003000 INTL 20051117)
[    0.744230] ACPI: Dynamic OEM Table Load:
[    0.744231] ACPI: SSDT           (null) 00119 (v01  PmRef    ApCst
00003000 INTL 20051117)
[    0.756403] ACPI: Interpreter enabled
[    0.756406] ACPI: (supports S0 S1 S3 S4 S5)
[    0.756428] ACPI: Using IOAPIC for interrupt routing
[    0.762044] ACPI: Power Resource [FN00] (off)
[    0.762111] ACPI: Power Resource [FN01] (off)
[    0.762177] ACPI: Power Resource [FN02] (off)
[    0.762242] ACPI: Power Resource [FN03] (off)
[    0.762308] ACPI: Power Resource [FN04] (off)
[    0.762541] ACPI: EC: GPE = 0x18, I/O: command/status = 0x66, data = 0x62
[    0.762712] ACPI: No dock devices found.
[    0.762713] HEST: Table not found.
[    0.762716] PCI: Using host bridge windows from ACPI; if necessary,
use "pci=nocrs" and report a bug
[    0.763000] \_SB_.PCI0:_OSC invalid UUID
[    0.763001] _OSC request data:1 8 1f
[    0.763004] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-3e])
[    0.763463] pci_root PNP0A08:00: host bridge window [io  0x0000-0x0cf7]
[    0.763465] pci_root PNP0A08:00: host bridge window [io  0x0d00-0xffff]
[    0.763467] pci_root PNP0A08:00: host bridge window [mem
0x000a0000-0x000bffff]
[    0.763468] pci_root PNP0A08:00: host bridge window [mem
0x000d0000-0x000d3fff]
[    0.763470] pci_root PNP0A08:00: host bridge window [mem
0x000d4000-0x000d7fff]
[    0.763471] pci_root PNP0A08:00: host bridge window [mem
0x000d8000-0x000dbfff]
[    0.763472] pci_root PNP0A08:00: host bridge window [mem
0x000dc000-0x000dffff]
[    0.763474] pci_root PNP0A08:00: host bridge window [mem
0x000e0000-0x000e3fff]
[    0.763475] pci_root PNP0A08:00: host bridge window [mem
0x000e4000-0x000e7fff]
[    0.763477] pci_root PNP0A08:00: host bridge window [mem
0xdfa00000-0xfeafffff]
[    0.763486] pci 0000:00:00.0: [8086:0100] type 0 class 0x000600
[    0.763515] pci 0000:00:01.0: [8086:0101] type 1 class 0x000604
[    0.763538] pci 0000:00:01.0: PME# supported from D0 D3hot D3cold
[    0.763540] pci 0000:00:01.0: PME# disabled
[    0.763555] pci 0000:00:02.0: [8086:0102] type 0 class 0x000300
[    0.763563] pci 0000:00:02.0: reg 10: [mem 0xf7400000-0xf77fffff 64bit]
[    0.763567] pci 0000:00:02.0: reg 18: [mem 0xe0000000-0xefffffff 64bit pref]
[    0.763571] pci 0000:00:02.0: reg 20: [io  0xf000-0xf03f]
[    0.763616] pci 0000:00:16.0: [8086:1c3a] type 0 class 0x000780
[    0.763637] pci 0000:00:16.0: reg 10: [mem 0xf7e2c000-0xf7e2c00f 64bit]
[    0.763708] pci 0000:00:16.0: PME# supported from D0 D3hot D3cold
[    0.763711] pci 0000:00:16.0: PME# disabled
[    0.763738] pci 0000:00:19.0: [8086:1503] type 0 class 0x000200
[    0.763755] pci 0000:00:19.0: reg 10: [mem 0xf7e00000-0xf7e1ffff]
[    0.763762] pci 0000:00:19.0: reg 14: [mem 0xf7e29000-0xf7e29fff]
[    0.763770] pci 0000:00:19.0: reg 18: [io  0xf080-0xf09f]
[    0.763832] pci 0000:00:19.0: PME# supported from D0 D3hot D3cold
[    0.763835] pci 0000:00:19.0: PME# disabled
[    0.763858] pci 0000:00:1a.0: [8086:1c2d] type 0 class 0x000c03
[    0.763878] pci 0000:00:1a.0: reg 10: [mem 0xf7e28000-0xf7e283ff]
[    0.763964] pci 0000:00:1a.0: PME# supported from D0 D3hot D3cold
[    0.763968] pci 0000:00:1a.0: PME# disabled
[    0.763991] pci 0000:00:1b.0: [8086:1c20] type 0 class 0x000403
[    0.764004] pci 0000:00:1b.0: reg 10: [mem 0xf7e20000-0xf7e23fff 64bit]
[    0.764068] pci 0000:00:1b.0: PME# supported from D0 D3hot D3cold
[    0.764071] pci 0000:00:1b.0: PME# disabled
[    0.764091] pci 0000:00:1c.0: [8086:1c10] type 1 class 0x000604
[    0.764165] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    0.764169] pci 0000:00:1c.0: PME# disabled
[    0.764191] pci 0000:00:1c.1: [8086:1c12] type 1 class 0x000604
[    0.764265] pci 0000:00:1c.1: PME# supported from D0 D3hot D3cold
[    0.764268] pci 0000:00:1c.1: PME# disabled
[    0.764291] pci 0000:00:1c.3: [8086:1c16] type 1 class 0x000604
[    0.764365] pci 0000:00:1c.3: PME# supported from D0 D3hot D3cold
[    0.764369] pci 0000:00:1c.3: PME# disabled
[    0.764391] pci 0000:00:1c.4: [8086:1c18] type 1 class 0x000604
[    0.764464] pci 0000:00:1c.4: PME# supported from D0 D3hot D3cold
[    0.764468] pci 0000:00:1c.4: PME# disabled
[    0.764491] pci 0000:00:1c.6: [8086:244e] type 1 class 0x000604
[    0.764565] pci 0000:00:1c.6: PME# supported from D0 D3hot D3cold
[    0.764568] pci 0000:00:1c.6: PME# disabled
[    0.764590] pci 0000:00:1c.7: [8086:1c1e] type 1 class 0x000604
[    0.764664] pci 0000:00:1c.7: PME# supported from D0 D3hot D3cold
[    0.764667] pci 0000:00:1c.7: PME# disabled
[    0.764693] pci 0000:00:1d.0: [8086:1c26] type 0 class 0x000c03
[    0.764713] pci 0000:00:1d.0: reg 10: [mem 0xf7e27000-0xf7e273ff]
[    0.764798] pci 0000:00:1d.0: PME# supported from D0 D3hot D3cold
[    0.764802] pci 0000:00:1d.0: PME# disabled
[    0.764824] pci 0000:00:1f.0: [8086:1c44] type 0 class 0x000601
[    0.764942] pci 0000:00:1f.2: [8086:1c02] type 0 class 0x000106
[    0.764959] pci 0000:00:1f.2: reg 10: [io  0xf0d0-0xf0d7]
[    0.764966] pci 0000:00:1f.2: reg 14: [io  0xf0c0-0xf0c3]
[    0.764973] pci 0000:00:1f.2: reg 18: [io  0xf0b0-0xf0b7]
[    0.764980] pci 0000:00:1f.2: reg 1c: [io  0xf0a0-0xf0a3]
[    0.764987] pci 0000:00:1f.2: reg 20: [io  0xf060-0xf07f]
[    0.764994] pci 0000:00:1f.2: reg 24: [mem 0xf7e26000-0xf7e267ff]
[    0.765036] pci 0000:00:1f.2: PME# supported from D3hot
[    0.765038] pci 0000:00:1f.2: PME# disabled
[    0.765054] pci 0000:00:1f.3: [8086:1c22] type 0 class 0x000c05
[    0.765067] pci 0000:00:1f.3: reg 10: [mem 0xf7e25000-0xf7e250ff 64bit]
[    0.765086] pci 0000:00:1f.3: reg 20: [io  0xf040-0xf05f]
[    0.765126] pci 0000:00:01.0: PCI bridge to [bus 01-01]
[    0.765169] pci 0000:00:1c.0: PCI bridge to [bus 02-02]
[    0.765246] pci 0000:03:00.0: [1b21:1042] type 0 class 0x000c03
[    0.765274] pci 0000:03:00.0: reg 10: [mem 0xf7d00000-0xf7d07fff 64bit]
[    0.765418] pci 0000:03:00.0: PME# supported from D3hot D3cold
[    0.765423] pci 0000:03:00.0: PME# disabled
[    0.771812] pci 0000:00:1c.1: PCI bridge to [bus 03-03]
[    0.771821] pci 0000:00:1c.1:   bridge window [mem 0xf7d00000-0xf7dfffff]
[    0.771914] pci 0000:04:00.0: [197b:2362] type 0 class 0x000101
[    0.771949] pci 0000:04:00.0: reg 10: [io  0xe040-0xe047]
[    0.771965] pci 0000:04:00.0: reg 14: [io  0xe030-0xe033]
[    0.771980] pci 0000:04:00.0: reg 18: [io  0xe020-0xe027]
[    0.771996] pci 0000:04:00.0: reg 1c: [io  0xe010-0xe013]
[    0.772012] pci 0000:04:00.0: reg 20: [io  0xe000-0xe00f]
[    0.772027] pci 0000:04:00.0: reg 24: [mem 0xf7c10000-0xf7c101ff]
[    0.772101] pci 0000:04:00.0: PME# supported from D3hot
[    0.772107] pci 0000:04:00.0: PME# disabled
[    0.779804] pci 0000:00:1c.3: PCI bridge to [bus 04-04]
[    0.779809] pci 0000:00:1c.3:   bridge window [io  0xe000-0xefff]
[    0.779815] pci 0000:00:1c.3:   bridge window [mem 0xf7c00000-0xf7cfffff]
[    0.779915] pci 0000:05:00.0: [1b21:1042] type 0 class 0x000c03
[    0.779943] pci 0000:05:00.0: reg 10: [mem 0xf7b00000-0xf7b07fff 64bit]
[    0.780088] pci 0000:05:00.0: PME# supported from D3hot D3cold
[    0.780093] pci 0000:05:00.0: PME# disabled
[    0.787797] pci 0000:00:1c.4: PCI bridge to [bus 05-05]
[    0.787805] pci 0000:00:1c.4:   bridge window [mem 0xf7b00000-0xf7bfffff]
[    0.787895] pci 0000:06:00.0: [1b21:1080] type 1 class 0x000604
[    0.788015] pci 0000:00:1c.6: PCI bridge to [bus 06-07] (subtractive decode)
[    0.788019] pci 0000:00:1c.6:   bridge window [io  0xd000-0xdfff]
[    0.788023] pci 0000:00:1c.6:   bridge window [mem 0xf7800000-0xf79fffff]
[    0.788029] pci 0000:00:1c.6:   bridge window [io  0x0000-0x0cf7]
(subtractive decode)
[    0.788031] pci 0000:00:1c.6:   bridge window [io  0x0d00-0xffff]
(subtractive decode)
[    0.788032] pci 0000:00:1c.6:   bridge window [mem
0x000a0000-0x000bffff] (subtractive decode)
[    0.788034] pci 0000:00:1c.6:   bridge window [mem
0x000d0000-0x000d3fff] (subtractive decode)
[    0.788035] pci 0000:00:1c.6:   bridge window [mem
0x000d4000-0x000d7fff] (subtractive decode)
[    0.788037] pci 0000:00:1c.6:   bridge window [mem
0x000d8000-0x000dbfff] (subtractive decode)
[    0.788038] pci 0000:00:1c.6:   bridge window [mem
0x000dc000-0x000dffff] (subtractive decode)
[    0.788040] pci 0000:00:1c.6:   bridge window [mem
0x000e0000-0x000e3fff] (subtractive decode)
[    0.788042] pci 0000:00:1c.6:   bridge window [mem
0x000e4000-0x000e7fff] (subtractive decode)
[    0.788043] pci 0000:00:1c.6:   bridge window [mem
0xdfa00000-0xfeafffff] (subtractive decode)
[    0.788102] pci 0000:07:00.0: [1095:3114] type 0 class 0x000104
[    0.788132] pci 0000:07:00.0: reg 10: [io  0xd110-0xd117]
[    0.788149] pci 0000:07:00.0: reg 14: [io  0xd100-0xd103]
[    0.788166] pci 0000:07:00.0: reg 18: [io  0xd0f0-0xd0f7]
[    0.788183] pci 0000:07:00.0: reg 1c: [io  0xd0e0-0xd0e3]
[    0.788200] pci 0000:07:00.0: reg 20: [io  0xd0d0-0xd0df]
[    0.788216] pci 0000:07:00.0: reg 24: [mem 0xf7902000-0xf79023ff]
[    0.788234] pci 0000:07:00.0: reg 30: [mem 0xf7880000-0xf78fffff pref]
[    0.788284] pci 0000:07:00.0: supports D1 D2
[    0.788312] pci 0000:07:01.0: [1095:3114] type 0 class 0x000104
[    0.788342] pci 0000:07:01.0: reg 10: [io  0xd0c0-0xd0c7]
[    0.788359] pci 0000:07:01.0: reg 14: [io  0xd0b0-0xd0b3]
[    0.788375] pci 0000:07:01.0: reg 18: [io  0xd0a0-0xd0a7]
[    0.788392] pci 0000:07:01.0: reg 1c: [io  0xd090-0xd093]
[    0.788409] pci 0000:07:01.0: reg 20: [io  0xd080-0xd08f]
[    0.788426] pci 0000:07:01.0: reg 24: [mem 0xf7901000-0xf79013ff]
[    0.788443] pci 0000:07:01.0: reg 30: [mem 0xf7800000-0xf787ffff pref]
[    0.788493] pci 0000:07:01.0: supports D1 D2
[    0.788522] pci 0000:07:02.0: [1106:3044] type 0 class 0x000c00
[    0.788552] pci 0000:07:02.0: reg 10: [mem 0xf7900000-0xf79007ff]
[    0.788570] pci 0000:07:02.0: reg 14: [io  0xd000-0xd07f]
[    0.788699] pci 0000:07:02.0: supports D2
[    0.788701] pci 0000:07:02.0: PME# supported from D2 D3hot D3cold
[    0.788707] pci 0000:07:02.0: PME# disabled
[    0.788783] pci 0000:06:00.0: PCI bridge to [bus 07-07] (subtractive decode)
[    0.788792] pci 0000:06:00.0:   bridge window [io  0xd000-0xdfff]
[    0.788798] pci 0000:06:00.0:   bridge window [mem 0xf7800000-0xf79fffff]
[    0.788808] pci 0000:06:00.0:   bridge window [io  0xd000-0xdfff]
(subtractive decode)
[    0.788809] pci 0000:06:00.0:   bridge window [mem
0xf7800000-0xf79fffff] (subtractive decode)
[    0.788811] pci 0000:06:00.0:   bridge window [??? 0x00000000 flags
0x0] (subtractive decode)
[    0.788813] pci 0000:06:00.0:   bridge window [??? 0x00000000 flags
0x0] (subtractive decode)
[    0.788814] pci 0000:06:00.0:   bridge window [io  0x0000-0x0cf7]
(subtractive decode)
[    0.788816] pci 0000:06:00.0:   bridge window [io  0x0d00-0xffff]
(subtractive decode)
[    0.788817] pci 0000:06:00.0:   bridge window [mem
0x000a0000-0x000bffff] (subtractive decode)
[    0.788819] pci 0000:06:00.0:   bridge window [mem
0x000d0000-0x000d3fff] (subtractive decode)
[    0.788821] pci 0000:06:00.0:   bridge window [mem
0x000d4000-0x000d7fff] (subtractive decode)
[    0.788822] pci 0000:06:00.0:   bridge window [mem
0x000d8000-0x000dbfff] (subtractive decode)
[    0.788824] pci 0000:06:00.0:   bridge window [mem
0x000dc000-0x000dffff] (subtractive decode)
[    0.788825] pci 0000:06:00.0:   bridge window [mem
0x000e0000-0x000e3fff] (subtractive decode)
[    0.788827] pci 0000:06:00.0:   bridge window [mem
0x000e4000-0x000e7fff] (subtractive decode)
[    0.788829] pci 0000:06:00.0:   bridge window [mem
0xdfa00000-0xfeafffff] (subtractive decode)
[    0.788900] pci 0000:08:00.0: [1b4b:9172] type 0 class 0x000106
[    0.788917] pci 0000:08:00.0: reg 10: [io  0xc040-0xc047]
[    0.788929] pci 0000:08:00.0: reg 14: [io  0xc030-0xc033]
[    0.788941] pci 0000:08:00.0: reg 18: [io  0xc020-0xc027]
[    0.788954] pci 0000:08:00.0: reg 1c: [io  0xc010-0xc013]
[    0.788966] pci 0000:08:00.0: reg 20: [io  0xc000-0xc00f]
[    0.788978] pci 0000:08:00.0: reg 24: [mem 0xf7a10000-0xf7a101ff]
[    0.788991] pci 0000:08:00.0: reg 30: [mem 0xf7a00000-0xf7a0ffff pref]
[    0.789048] pci 0000:08:00.0: PME# supported from D3hot
[    0.789053] pci 0000:08:00.0: PME# disabled
[    0.795790] pci 0000:00:1c.7: PCI bridge to [bus 08-08]
[    0.795795] pci 0000:00:1c.7:   bridge window [io  0xc000-0xcfff]
[    0.795801] pci 0000:00:1c.7:   bridge window [mem 0xf7a00000-0xf7afffff]
[    0.795851] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[    0.796034] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP01._PRT]
[    0.796068] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP02._PRT]
[    0.796105] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP04._PRT]
[    0.796147] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP05._PRT]
[    0.796183] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP08._PRT]
[    0.796217] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEG0._PRT]
[    0.796259] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP07._PRT]
[    0.796291] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP07.PXSX._PRT]
[    0.796414] \_SB_.PCI0:_OSC invalid UUID
[    0.796415] _OSC request data:1 1f 1f
[    0.796418]  pci0000:00: Requesting ACPI _OSC control (0x1d)
[    0.796462] \_SB_.PCI0:_OSC invalid UUID
[    0.796462] _OSC request data:1 0 1d
[    0.796465]  pci0000:00: ACPI _OSC request failed (AE_ERROR),
returned control mask: 0x1d
[    0.796466] ACPI _OSC control for PCIe not granted, disabling ASPM
[    0.802038] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 10 *11 12 14 15)
[    0.802081] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 10 *11 12 14 15)
[    0.802122] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 6 10 11 12 14 15)
[    0.802164] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 *10 11 12 14 15)
[    0.802204] ACPI: PCI Interrupt Link [LNKE] (IRQs *3 4 5 6 10 11 12 14 15)
[    0.802245] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 10 11 12
14 15) *0, disabled.
[    0.802285] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 *4 5 6 10 11 12 14 15)
[    0.802326] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 *10 11 12 14 15)
[    0.802403] vgaarb: device added:
PCI:0000:00:02.0,decodes=io+mem,owns=io+mem,locks=none
[    0.802412] vgaarb: loaded
[    0.802413] vgaarb: bridge control possible 0000:00:02.0
[    0.802438] PCI: Using ACPI for IRQ routing
[    0.803780] PCI: pci_cache_line_size set to 64 bytes
[    0.803891] reserve RAM buffer: 0000000000099000 - 000000000009ffff
[    0.803893] reserve RAM buffer: 00000000da391000 - 00000000dbffffff
[    0.803896] reserve RAM buffer: 00000000db000000 - 00000000dbffffff
[    0.803897] reserve RAM buffer: 000000021f600000 - 000000021fffffff
[    0.803977] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0, 0, 0, 0, 0
[    0.803981] hpet0: 8 comparators, 64-bit 14.318180 MHz counter
[    0.805995] Switching to clocksource hpet
[    0.807345] pnp: PnP ACPI init
[    0.807357] ACPI: bus type pnp registered
[    0.807600] pnp 00:00: [bus 00-3e]
[    0.807601] pnp 00:00: [io  0x0000-0x0cf7 window]
[    0.807603] pnp 00:00: [io  0x0cf8-0x0cff]
[    0.807604] pnp 00:00: [io  0x0d00-0xffff window]
[    0.807606] pnp 00:00: [mem 0x000a0000-0x000bffff window]
[    0.807607] pnp 00:00: [mem 0x000c0000-0x000c3fff window]
[    0.807608] pnp 00:00: [mem 0x000c4000-0x000c7fff window]
[    0.807609] pnp 00:00: [mem 0x000c8000-0x000cbfff window]
[    0.807611] pnp 00:00: [mem 0x000cc000-0x000cffff window]
[    0.807612] pnp 00:00: [mem 0x000d0000-0x000d3fff window]
[    0.807613] pnp 00:00: [mem 0x000d4000-0x000d7fff window]
[    0.807615] pnp 00:00: [mem 0x000d8000-0x000dbfff window]
[    0.807616] pnp 00:00: [mem 0x000dc000-0x000dffff window]
[    0.807617] pnp 00:00: [mem 0x000e0000-0x000e3fff window]
[    0.807619] pnp 00:00: [mem 0x000e4000-0x000e7fff window]
[    0.807620] pnp 00:00: [mem 0x000e8000-0x000ebfff window]
[    0.807621] pnp 00:00: [mem 0x000ec000-0x000effff window]
[    0.807622] pnp 00:00: [mem 0x000f0000-0x000fffff window]
[    0.807624] pnp 00:00: [mem 0xdfa00000-0xfeafffff window]
[    0.807625] pnp 00:00: [mem 0x00010000-0x0001ffff window]
[    0.807675] pnp 00:00: Plug and Play ACPI device, IDs PNP0a08
PNP0a03 (active)
[    0.807692] pnp 00:01: [mem 0xfed40000-0xfed44fff]
[    0.807724] system 00:01: [mem 0xfed40000-0xfed44fff] has been reserved
[    0.807726] system 00:01: Plug and Play ACPI device, IDs PNP0c01 (active)
[    0.807735] pnp 00:02: [io  0x0000-0x001f]
[    0.807737] pnp 00:02: [io  0x0081-0x0091]
[    0.807738] pnp 00:02: [io  0x0093-0x009f]
[    0.807739] pnp 00:02: [io  0x00c0-0x00df]
[    0.807741] pnp 00:02: [dma 4]
[    0.807756] pnp 00:02: Plug and Play ACPI device, IDs PNP0200 (active)
[    0.807762] pnp 00:03: [mem 0xff000000-0xffffffff]
[    0.807806] pnp 00:03: Plug and Play ACPI device, IDs INT0800 (active)
[    0.807874] pnp 00:04: [mem 0xfed00000-0xfed003ff]
[    0.807892] pnp 00:04: Plug and Play ACPI device, IDs PNP0103 (active)
[    0.807901] pnp 00:05: [io  0x002e-0x002f]
[    0.807902] pnp 00:05: [io  0x004e-0x004f]
[    0.807903] pnp 00:05: [io  0x0061]
[    0.807904] pnp 00:05: [io  0x0063]
[    0.807905] pnp 00:05: [io  0x0065]
[    0.807906] pnp 00:05: [io  0x0067]
[    0.807908] pnp 00:05: [io  0x0070]
[    0.807908] pnp 00:05: [io  0x0080]
[    0.807909] pnp 00:05: [io  0x0092]
[    0.807911] pnp 00:05: [io  0x00b2-0x00b3]
[    0.807912] pnp 00:05: [io  0x0680-0x069f]
[    0.807913] pnp 00:05: [io  0x0200-0x020f]
[    0.807914] pnp 00:05: [io  0xffff]
[    0.807915] pnp 00:05: [io  0xffff]
[    0.807916] pnp 00:05: [io  0x0400-0x0453]
[    0.807917] pnp 00:05: [io  0x0458-0x047f]
[    0.807918] pnp 00:05: [io  0x0500-0x057f]
[    0.807919] pnp 00:05: [io  0x164e-0x164f]
[    0.807959] system 00:05: [io  0x0680-0x069f] has been reserved
[    0.807960] system 00:05: [io  0x0200-0x020f] has been reserved
[    0.807962] system 00:05: [io  0xffff] has been reserved
[    0.807964] system 00:05: [io  0xffff] has been reserved
[    0.807965] system 00:05: [io  0x0400-0x0453] has been reserved
[    0.807967] system 00:05: [io  0x0458-0x047f] has been reserved
[    0.807968] system 00:05: [io  0x0500-0x057f] has been reserved
[    0.807970] system 00:05: [io  0x164e-0x164f] has been reserved
[    0.807972] system 00:05: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.807978] pnp 00:06: [io  0x0070-0x0077]
[    0.807985] pnp 00:06: [irq 8]
[    0.808001] pnp 00:06: Plug and Play ACPI device, IDs PNP0b00 (active)
[    0.808024] pnp 00:07: [io  0x0454-0x0457]
[    0.808053] system 00:07: [io  0x0454-0x0457] has been reserved
[    0.808055] system 00:07: Plug and Play ACPI device, IDs INT3f0d
PNP0c02 (active)
[    0.808110] pnp 00:08: [io  0x0000-0xffffffffffffffff disabled]
[    0.808111] pnp 00:08: [io  0x0000-0xffffffffffffffff disabled]
[    0.808113] pnp 00:08: [io  0x0290-0x029f]
[    0.808114] pnp 00:08: [io  0x0000-0xffffffffffffffff disabled]
[    0.808145] system 00:08: [io  0x0290-0x029f] has been reserved
[    0.808147] system 00:08: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.808165] pnp 00:09: [io  0x0010-0x001f]
[    0.808166] pnp 00:09: [io  0x0022-0x003f]
[    0.808168] pnp 00:09: [io  0x0044-0x005f]
[    0.808169] pnp 00:09: [io  0x0062-0x0063]
[    0.808171] pnp 00:09: [io  0x0065-0x006f]
[    0.808172] pnp 00:09: [io  0x0072-0x007f]
[    0.808173] pnp 00:09: [io  0x0080]
[    0.808174] pnp 00:09: [io  0x0084-0x0086]
[    0.808175] pnp 00:09: [io  0x0088]
[    0.808176] pnp 00:09: [io  0x008c-0x008e]
[    0.808177] pnp 00:09: [io  0x0090-0x009f]
[    0.808178] pnp 00:09: [io  0x00a2-0x00bf]
[    0.808179] pnp 00:09: [io  0x00e0-0x00ef]
[    0.808180] pnp 00:09: [io  0x04d0-0x04d1]
[    0.808217] system 00:09: [io  0x04d0-0x04d1] has been reserved
[    0.808219] system 00:09: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.808225] pnp 00:0a: [io  0x00f0-0x00ff]
[    0.808229] pnp 00:0a: [irq 13]
[    0.808249] pnp 00:0a: Plug and Play ACPI device, IDs PNP0c04 (active)
[    0.808479] pnp 00:0b: [mem 0xfed1c000-0xfed1ffff]
[    0.808480] pnp 00:0b: [mem 0xfed10000-0xfed17fff]
[    0.808481] pnp 00:0b: [mem 0xfed18000-0xfed18fff]
[    0.808482] pnp 00:0b: [mem 0xfed19000-0xfed19fff]
[    0.808484] pnp 00:0b: [mem 0xf8000000-0xfbffffff]
[    0.808485] pnp 00:0b: [mem 0xfed20000-0xfed3ffff]
[    0.808486] pnp 00:0b: [mem 0xfed90000-0xfed93fff]
[    0.808487] pnp 00:0b: [mem 0xfed45000-0xfed8ffff]
[    0.808488] pnp 00:0b: [mem 0xff000000-0xffffffff]
[    0.808489] pnp 00:0b: [mem 0xfee00000-0xfeefffff]
[    0.808491] pnp 00:0b: [mem 0xdfa00000-0xdfa00fff]
[    0.808541] system 00:0b: [mem 0xfed1c000-0xfed1ffff] has been reserved
[    0.808543] system 00:0b: [mem 0xfed10000-0xfed17fff] has been reserved
[    0.808545] system 00:0b: [mem 0xfed18000-0xfed18fff] has been reserved
[    0.808546] system 00:0b: [mem 0xfed19000-0xfed19fff] has been reserved
[    0.808548] system 00:0b: [mem 0xf8000000-0xfbffffff] has been reserved
[    0.808550] system 00:0b: [mem 0xfed20000-0xfed3ffff] has been reserved
[    0.808552] system 00:0b: [mem 0xfed90000-0xfed93fff] has been reserved
[    0.808553] system 00:0b: [mem 0xfed45000-0xfed8ffff] has been reserved
[    0.808555] system 00:0b: [mem 0xff000000-0xffffffff] has been reserved
[    0.808557] system 00:0b: [mem 0xfee00000-0xfeefffff] could not be reserved
[    0.808559] system 00:0b: [mem 0xdfa00000-0xdfa00fff] has been reserved
[    0.808560] system 00:0b: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.808684] pnp 00:0c: [mem 0x20000000-0x201fffff]
[    0.808685] pnp 00:0c: [mem 0x40000000-0x401fffff]
[    0.808733] system 00:0c: [mem 0x20000000-0x201fffff] has been reserved
[    0.808734] system 00:0c: [mem 0x40000000-0x401fffff] has been reserved
[    0.808736] system 00:0c: Plug and Play ACPI device, IDs PNP0c01 (active)
[    0.808755] pnp: PnP ACPI: found 13 devices
[    0.808756] ACPI: ACPI bus type pnp unregistered
[    0.814998] PCI: max bus depth: 2 pci_try_num: 3
[    0.815063] pci 0000:00:1c.0: BAR 14: assigned [mem 0xdfb00000-0xdfcfffff]
[    0.815066] pci 0000:00:1c.0: BAR 15: assigned [mem
0xdfd00000-0xdfefffff 64bit pref]
[    0.815069] pci 0000:00:1c.0: BAR 13: assigned [io  0x2000-0x2fff]
[    0.815070] pci 0000:00:01.0: PCI bridge to [bus 01-01]
[    0.815074] pci 0000:00:1c.0: PCI bridge to [bus 02-02]
[    0.815077] pci 0000:00:1c.0:   bridge window [io  0x2000-0x2fff]
[    0.815082] pci 0000:00:1c.0:   bridge window [mem 0xdfb00000-0xdfcfffff]
[    0.815086] pci 0000:00:1c.0:   bridge window [mem
0xdfd00000-0xdfefffff 64bit pref]
[    0.815091] pci 0000:00:1c.1: PCI bridge to [bus 03-03]
[    0.815095] pci 0000:00:1c.1:   bridge window [mem 0xf7d00000-0xf7dfffff]
[    0.815103] pci 0000:00:1c.3: PCI bridge to [bus 04-04]
[    0.815106] pci 0000:00:1c.3:   bridge window [io  0xe000-0xefff]
[    0.815110] pci 0000:00:1c.3:   bridge window [mem 0xf7c00000-0xf7cfffff]
[    0.815118] pci 0000:00:1c.4: PCI bridge to [bus 05-05]
[    0.815122] pci 0000:00:1c.4:   bridge window [mem 0xf7b00000-0xf7bfffff]
[    0.815130] pci 0000:06:00.0: PCI bridge to [bus 07-07]
[    0.815134] pci 0000:06:00.0:   bridge window [io  0xd000-0xdfff]
[    0.815142] pci 0000:06:00.0:   bridge window [mem 0xf7800000-0xf79fffff]
[    0.815155] pci 0000:00:1c.6: PCI bridge to [bus 06-07]
[    0.815158] pci 0000:00:1c.6:   bridge window [io  0xd000-0xdfff]
[    0.815162] pci 0000:00:1c.6:   bridge window [mem 0xf7800000-0xf79fffff]
[    0.815170] pci 0000:00:1c.7: PCI bridge to [bus 08-08]
[    0.815173] pci 0000:00:1c.7:   bridge window [io  0xc000-0xcfff]
[    0.815177] pci 0000:00:1c.7:   bridge window [mem 0xf7a00000-0xf7afffff]
[    0.815193] pci 0000:00:01.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
[    0.815195] pci 0000:00:01.0: setting latency timer to 64
[    0.815200] pci 0000:00:1c.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
[    0.815204] pci 0000:00:1c.0: setting latency timer to 64
[    0.815213] pci 0000:00:1c.1: PCI INT B -> GSI 17 (level, low) -> IRQ 17
[    0.815216] pci 0000:00:1c.1: setting latency timer to 64
[    0.815223] pci 0000:00:1c.3: PCI INT D -> GSI 19 (level, low) -> IRQ 19
[    0.815227] pci 0000:00:1c.3: setting latency timer to 64
[    0.815232] pci 0000:00:1c.4: PCI INT A -> GSI 16 (level, low) -> IRQ 16
[    0.815236] pci 0000:00:1c.4: setting latency timer to 64
[    0.815243] pci 0000:00:1c.6: PCI INT C -> GSI 18 (level, low) -> IRQ 18
[    0.815247] pci 0000:00:1c.6: setting latency timer to 64
[    0.815253] pci 0000:06:00.0: PCI INT A -> GSI 18 (level, low) -> IRQ 18
[    0.815258] pci 0000:06:00.0: setting latency timer to 64
[    0.815265] pci 0000:00:1c.7: PCI INT D -> GSI 19 (level, low) -> IRQ 19
[    0.815268] pci 0000:00:1c.7: setting latency timer to 64
[    0.815272] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7]
[    0.815273] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff]
[    0.815274] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff]
[    0.815276] pci_bus 0000:00: resource 7 [mem 0x000d0000-0x000d3fff]
[    0.815277] pci_bus 0000:00: resource 8 [mem 0x000d4000-0x000d7fff]
[    0.815278] pci_bus 0000:00: resource 9 [mem 0x000d8000-0x000dbfff]
[    0.815279] pci_bus 0000:00: resource 10 [mem 0x000dc000-0x000dffff]
[    0.815281] pci_bus 0000:00: resource 11 [mem 0x000e0000-0x000e3fff]
[    0.815282] pci_bus 0000:00: resource 12 [mem 0x000e4000-0x000e7fff]
[    0.815283] pci_bus 0000:00: resource 13 [mem 0xdfa00000-0xfeafffff]
[    0.815285] pci_bus 0000:02: resource 0 [io  0x2000-0x2fff]
[    0.815286] pci_bus 0000:02: resource 1 [mem 0xdfb00000-0xdfcfffff]
[    0.815288] pci_bus 0000:02: resource 2 [mem 0xdfd00000-0xdfefffff
64bit pref]
[    0.815289] pci_bus 0000:03: resource 1 [mem 0xf7d00000-0xf7dfffff]
[    0.815290] pci_bus 0000:04: resource 0 [io  0xe000-0xefff]
[    0.815292] pci_bus 0000:04: resource 1 [mem 0xf7c00000-0xf7cfffff]
[    0.815293] pci_bus 0000:05: resource 1 [mem 0xf7b00000-0xf7bfffff]
[    0.815294] pci_bus 0000:06: resource 0 [io  0xd000-0xdfff]
[    0.815295] pci_bus 0000:06: resource 1 [mem 0xf7800000-0xf79fffff]
[    0.815297] pci_bus 0000:06: resource 4 [io  0x0000-0x0cf7]
[    0.815298] pci_bus 0000:06: resource 5 [io  0x0d00-0xffff]
[    0.815299] pci_bus 0000:06: resource 6 [mem 0x000a0000-0x000bffff]
[    0.815301] pci_bus 0000:06: resource 7 [mem 0x000d0000-0x000d3fff]
[    0.815302] pci_bus 0000:06: resource 8 [mem 0x000d4000-0x000d7fff]
[    0.815303] pci_bus 0000:06: resource 9 [mem 0x000d8000-0x000dbfff]
[    0.815304] pci_bus 0000:06: resource 10 [mem 0x000dc000-0x000dffff]
[    0.815306] pci_bus 0000:06: resource 11 [mem 0x000e0000-0x000e3fff]
[    0.815307] pci_bus 0000:06: resource 12 [mem 0x000e4000-0x000e7fff]
[    0.815308] pci_bus 0000:06: resource 13 [mem 0xdfa00000-0xfeafffff]
[    0.815310] pci_bus 0000:07: resource 0 [io  0xd000-0xdfff]
[    0.815311] pci_bus 0000:07: resource 1 [mem 0xf7800000-0xf79fffff]
[    0.815312] pci_bus 0000:07: resource 4 [io  0xd000-0xdfff]
[    0.815313] pci_bus 0000:07: resource 5 [mem 0xf7800000-0xf79fffff]
[    0.815315] pci_bus 0000:07: resource 8 [io  0x0000-0x0cf7]
[    0.815316] pci_bus 0000:07: resource 9 [io  0x0d00-0xffff]
[    0.815317] pci_bus 0000:07: resource 10 [mem 0x000a0000-0x000bffff]
[    0.815318] pci_bus 0000:07: resource 11 [mem 0x000d0000-0x000d3fff]
[    0.815320] pci_bus 0000:07: resource 12 [mem 0x000d4000-0x000d7fff]
[    0.815321] pci_bus 0000:07: resource 13 [mem 0x000d8000-0x000dbfff]
[    0.815322] pci_bus 0000:07: resource 14 [mem 0x000dc000-0x000dffff]
[    0.815324] pci_bus 0000:07: resource 15 [mem 0x000e0000-0x000e3fff]
[    0.815325] pci_bus 0000:07: resource 16 [mem 0x000e4000-0x000e7fff]
[    0.815326] pci_bus 0000:07: resource 17 [mem 0xdfa00000-0xfeafffff]
[    0.815327] pci_bus 0000:08: resource 0 [io  0xc000-0xcfff]
[    0.815329] pci_bus 0000:08: resource 1 [mem 0xf7a00000-0xf7afffff]
[    0.815381] NET: Registered protocol family 2
[    0.815545] IP route cache hash table entries: 262144 (order: 9,
2097152 bytes)
[    0.816290] TCP established hash table entries: 524288 (order: 11,
8388608 bytes)
[    0.817300] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[    0.817415] TCP: Hash tables configured (established 524288 bind 65536)
[    0.817417] TCP reno registered
[    0.817428] UDP hash table entries: 4096 (order: 5, 131072 bytes)
[    0.817453] UDP-Lite hash table entries: 4096 (order: 5, 131072 bytes)
[    0.817550] NET: Registered protocol family 1
[    0.817962] pci 0000:00:02.0: BIOS left Intel GPU interrupts
enabled; disabling
[    0.818170] pci 0000:00:02.0: Boot video device
[    0.818185] pci 0000:00:1a.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
[    0.945896] pci 0000:00:1a.0: PCI INT A disabled
[    0.945937] pci 0000:00:1d.0: PCI INT A -> GSI 23 (level, low) -> IRQ 23
[    1.069798] pci 0000:00:1d.0: PCI INT A disabled
[    1.069821] pci 0000:03:00.0: PCI INT A -> GSI 17 (level, low) -> IRQ 17
[    1.069872] pci 0000:03:00.0: PCI INT A disabled
[    1.069886] pci 0000:05:00.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
[    1.069917] pci 0000:05:00.0: PCI INT A disabled
[    1.069938] PCI: CLS 64 bytes, default 64
[    1.069973] Unpacking initramfs...
[    1.109933] Freeing initrd memory: 2748k freed
[    1.110190] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    1.110194] Placing 64MB software IO TLB between ffff8800d6391000 -
ffff8800da391000
[    1.110195] software IO TLB at phys 0xd6391000 - 0xda391000
[    1.110583] audit: initializing netlink socket (disabled)
[    1.110590] type=2000 audit(1343362262.748:1): initialized
[    1.126988] HugeTLB registered 2 MB page size, pre-allocated 0 pages
[    1.141556] VFS: Disk quotas dquot_6.5.2
[    1.141580] Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    1.141636] msgmni has been set to 15803
[    1.141760] alg: No test for stdrng (krng)
[    1.141785] Block layer SCSI generic (bsg) driver version 0.4
loaded (major 253)
[    1.141787] io scheduler noop registered
[    1.141788] io scheduler deadline registered
[    1.141803] io scheduler cfq registered (default)
[    1.141873] pcieport 0000:00:01.0: setting latency timer to 64
[    1.141892] pcieport 0000:00:01.0: irq 40 for MSI/MSI-X
[    1.142135] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[    1.142152] pciehp: PCI Express Hot Plug Controller Driver version: 0.4
[    1.142153] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    1.142484] intel_idle: MWAIT substates: 0x1120
[    1.142485] intel_idle: v0.4 model 0x2A
[    1.142486] intel_idle: lapic_timer_reliable_states 0xffffffff
[    1.142520] ERST: Table is not found!
[    1.142521] GHES: HEST is not enabled!
[    1.142565] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    1.309938] Linux agpgart interface v0.103
[    1.309997] agpgart-intel 0000:00:00.0: Intel Sandybridge Chipset
[    1.310057] agpgart-intel 0000:00:00.0: detected gtt size: 2097152K
total, 262144K mappable
[    1.310782] agpgart-intel 0000:00:00.0: detected 65536K stolen memory
[    1.310871] agpgart-intel 0000:00:00.0: AGP aperture is 256M @ 0xe0000000
[    1.310957] i8042: PNP: No PS/2 controller found. Probing ports directly.
[    1.313590] serio: i8042 KBD port at 0x60,0x64 irq 1
[    1.313594] serio: i8042 AUX port at 0x60,0x64 irq 12
[    1.313696] mousedev: PS/2 mouse device common for all mice
[    1.313728] rtc_cmos 00:06: RTC can wake from S4
[    1.313824] rtc_cmos 00:06: rtc core: registered rtc_cmos as rtc0
[    1.313849] rtc0: alarms up to one month, y3k, 242 bytes nvram, hpet irqs
[    1.313940] cpuidle: using governor ladder
[    1.314062] cpuidle: using governor menu
[    1.314175] TCP cubic registered
[    1.314256] NET: Registered protocol family 10
[    1.314632] Mobile IPv6
[    1.314633] NET: Registered protocol family 17
[    1.314636] Registering the dns_resolver key type
[    1.314740] PM: Hibernation image not present or could not be loaded.
[    1.314748] registered taskstats version 1
[    1.322426] rtc_cmos 00:06: setting system clock to 2012-07-27
04:11:03 UTC (1343362263)
[    1.322482] Initializing network drop monitor service
[    1.323214] Freeing unused kernel memory: 612k freed
[    1.323273] Write protecting the kernel read-only data: 6144k
[    1.324587] Freeing unused kernel memory: 560k freed
[    1.326161] Freeing unused kernel memory: 720k freed
[    1.334738] udev[56]: starting version 164
[    1.351366] ACPI: Fan [FAN0] (off)
[    1.351405] ACPI: Fan [FAN1] (off)
[    1.351442] ACPI: Fan [FAN2] (off)
[    1.351481] ACPI: Fan [FAN3] (off)
[    1.351516] ACPI: Fan [FAN4] (off)
[    1.355456] SCSI subsystem initialized
[    1.362502] libata version 3.00 loaded.
[    1.363106] ahci 0000:00:1f.2: version 3.0
[    1.363120] ahci 0000:00:1f.2: PCI INT B -> GSI 19 (level, low) -> IRQ 19
[    1.363169] ahci 0000:00:1f.2: irq 41 for MSI/MSI-X
[    1.373929] thermal LNXTHERM:00: registered as thermal_zone0
[    1.373931] ACPI: Thermal Zone [TZ00] (28 C)
[    1.374055] thermal LNXTHERM:01: registered as thermal_zone1
[    1.374057] ACPI: Thermal Zone [TZ01] (30 C)
[    1.377715] ahci 0000:00:1f.2: AHCI 0001.0300 32 slots 6 ports 6
Gbps 0x7 impl SATA mode
[    1.377718] ahci 0000:00:1f.2: flags: 64bit ncq pm led clo pio slum
part ems apst
[    1.377722] ahci 0000:00:1f.2: setting latency timer to 64
[    1.394016] scsi0 : ahci
[    1.394119] scsi1 : ahci
[    1.394178] scsi2 : ahci
[    1.394232] scsi3 : ahci
[    1.394284] scsi4 : ahci
[    1.394328] scsi5 : ahci
[    1.394550] ata1: SATA max UDMA/133 abar m2048@0xf7e26000 port
0xf7e26100 irq 41
[    1.394553] ata2: SATA max UDMA/133 abar m2048@0xf7e26000 port
0xf7e26180 irq 41
[    1.394556] ata3: SATA max UDMA/133 abar m2048@0xf7e26000 port
0xf7e26200 irq 41
[    1.394557] ata4: DUMMY
[    1.394558] ata5: DUMMY
[    1.394559] ata6: DUMMY
[    1.394580] ahci 0000:04:00.0: PCI INT A -> GSI 19 (level, low) -> IRQ 19
[    1.394705] ahci 0000:04:00.0: AHCI 0001.0100 32 slots 2 ports 3
Gbps 0x3 impl SATA mode
[    1.394708] ahci 0000:04:00.0: flags: 64bit ncq pm led clo pmp pio slum part
[    1.394716] ahci 0000:04:00.0: setting latency timer to 64
[    1.394930] scsi6 : ahci
[    1.394977] scsi7 : ahci
[    1.395033] ata7: SATA max UDMA/133 abar m512@0xf7c10000 port
0xf7c10100 irq 19
[    1.395037] ata8: SATA max UDMA/133 abar m512@0xf7c10000 port
0xf7c10180 irq 19
[    1.395054] ahci 0000:08:00.0: PCI INT A -> GSI 19 (level, low) -> IRQ 19
[    1.395125] ahci 0000:08:00.0: irq 42 for MSI/MSI-X
[    1.395179] ahci 0000:08:00.0: AHCI 0001.0000 32 slots 2 ports 6
Gbps 0x3 impl SATA mode
[    1.395181] ahci 0000:08:00.0: flags: 64bit ncq sntf led only pmp
fbs pio slum part sxs
[    1.395186] ahci 0000:08:00.0: setting latency timer to 64
[    1.395377] scsi8 : ahci
[    1.395423] scsi9 : ahci
[    1.395455] ata9: SATA max UDMA/133 abar m512@0xf7a10000 port
0xf7a10100 irq 42
[    1.395458] ata10: SATA max UDMA/133 abar m512@0xf7a10000 port
0xf7a10180 irq 42
[    1.713416] ata7: SATA link down (SStatus 0 SControl 300)
[    1.713419] ata2: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    1.713467] ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    1.713477] ata8: SATA link down (SStatus 0 SControl 300)
[    1.713485] ata10: SATA link down (SStatus 0 SControl 300)
[    1.713512] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    1.713972] ACPI Error: [DSSP] Namespace lookup failure,
AE_NOT_FOUND (20110623/psargs-359)
[    1.713977] ACPI Error: Method parse/execution failed
[\_SB_.PCI0.SAT0.SPT2._GTF] (Node ffff88021649a6f0), AE_NOT_FOUND
(20110623/psparse-536)
[    1.715065] ACPI Error: [DSSP] Namespace lookup failure,
AE_NOT_FOUND (20110623/psargs-359)
[    1.715074] ACPI Error: Method parse/execution failed
[\_SB_.PCI0.SAT0.SPT1._GTF] (Node ffff88021649a768), AE_NOT_FOUND
(20110623/psparse-536)
[    1.715814] ata2.00: ATA-8: WDC WD1002FAEX-00Y9A0, 05.01D05, max UDMA/133
[    1.715818] ata2.00: 1953525168 sectors, multi 16: LBA48 NCQ (depth
31/32), AA
[    1.717050] ACPI Error: [DSSP] Namespace lookup failure,
AE_NOT_FOUND (20110623/psargs-359)
[    1.717059] ACPI Error: Method parse/execution failed
[\_SB_.PCI0.SAT0.SPT0._GTF] (Node ffff88021649a7e0), AE_NOT_FOUND
(20110623/psparse-536)
[    1.717078] ata1.00: ATAPI: HL-DT-ST DVDRAM GH24NS90, IN01, max UDMA/100
[    1.717518] ACPI Error: [DSSP] Namespace lookup failure,
AE_NOT_FOUND (20110623/psargs-359)
[    1.717527] ACPI Error: Method parse/execution failed
[\_SB_.PCI0.SAT0.SPT1._GTF] (Node ffff88021649a768), AE_NOT_FOUND
(20110623/psparse-536)
[    1.717719] ata2.00: configured for UDMA/133
[    1.723950] ACPI Error: [DSSP] Namespace lookup failure,
AE_NOT_FOUND (20110623/psargs-359)
[    1.723959] ACPI Error: Method parse/execution failed
[\_SB_.PCI0.SAT0.SPT0._GTF] (Node ffff88021649a7e0), AE_NOT_FOUND
(20110623/psparse-536)
[    1.723978] ata1.00: configured for UDMA/100
[    1.736830] scsi 0:0:0:0: CD-ROM            HL-DT-ST DVDRAM
GH24NS90  IN01 PQ: 0 ANSI: 5
[    1.737007] scsi 1:0:0:0: Direct-Access     ATA      WDC
WD1002FAEX-0 05.0 PQ: 0 ANSI: 5
[    1.739850] ata3.00: ATA-8: ST2000DM001-9YN164, CC4C, max UDMA/133
[    1.739855] ata3.00: 3907029168 sectors, multi 16: LBA48 NCQ (depth
31/32), AA
[    1.740335] ACPI Error: [DSSP] Namespace lookup failure,
AE_NOT_FOUND (20110623/psargs-359)
[    1.740343] ACPI Error: Method parse/execution failed
[\_SB_.PCI0.SAT0.SPT2._GTF] (Node ffff88021649a6f0), AE_NOT_FOUND
(20110623/psparse-536)
[    1.740654] ata3.00: configured for UDMA/133
[    1.740780] scsi 2:0:0:0: Direct-Access     ATA
ST2000DM001-9YN1 CC4C PQ: 0 ANSI: 5
[    1.741914] sd 1:0:0:0: [sda] 1953525168 512-byte logical blocks:
(1.00 TB/931 GiB)
[    1.741946] sd 2:0:0:0: [sdb] 3907029168 512-byte logical blocks:
(2.00 TB/1.81 TiB)
[    1.741949] sd 2:0:0:0: [sdb] 4096-byte physical blocks
[    1.741969] sd 1:0:0:0: [sda] Write Protect is off
[    1.741971] sd 1:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    1.741992] sd 2:0:0:0: [sdb] Write Protect is off
[    1.741994] sd 1:0:0:0: [sda] Write cache: enabled, read cache:
enabled, doesn't support DPO or FUA
[    1.741997] sd 2:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[    1.742016] sd 2:0:0:0: [sdb] Write cache: enabled, read cache:
enabled, doesn't support DPO or FUA
[    1.759948]  sda: sda1 sda2 sda3
[    1.760286] sd 1:0:0:0: [sda] Attached SCSI disk
[    1.761585]  sdb: sdb1
[    1.761878] sd 2:0:0:0: [sdb] Attached SCSI disk
[    1.885238] ata9: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    1.898816] ata9.00: ATA-8: ST2000DM001-9YN164, CC4C, max UDMA/133
[    1.898821] ata9.00: 3907029168 sectors, multi 0: LBA48 NCQ (depth 31/32), AA
[    2.109050] Refined TSC clocksource calibration: 3110.146 MHz.
[    2.109055] Switching to clocksource tsc
[    2.133621] ata9.00: configured for UDMA/133
[    2.133817] scsi 8:0:0:0: Direct-Access     ATA
ST2000DM001-9YN1 CC4C PQ: 0 ANSI: 5
[    2.133908] sd 8:0:0:0: [sdc] 3907029168 512-byte logical blocks:
(2.00 TB/1.81 TiB)
[    2.133911] sd 8:0:0:0: [sdc] 4096-byte physical blocks
[    2.133975] sd 8:0:0:0: [sdc] Write Protect is off
[    2.133977] sd 8:0:0:0: [sdc] Mode Sense: 00 3a 00 00
[    2.134049] sd 8:0:0:0: [sdc] Write cache: enabled, read cache:
enabled, doesn't support DPO or FUA
[    2.143577]  sdc: sdc1
[    2.143841] sd 8:0:0:0: [sdc] Attached SCSI disk
[    2.423806] async_tx: api initialized (async)
[    2.423983] xor: automatically using best checksumming function: generic_sse
[    2.440758]    generic_sse: 13891.000 MB/sec
[    2.440763] xor: using function: generic_sse (13891.000 MB/sec)
[    2.508716] raid6: int64x1   3326 MB/s
[    2.576669] raid6: int64x2   3262 MB/s
[    2.644609] raid6: int64x4   2993 MB/s
[    2.712565] raid6: int64x8   2321 MB/s
[    2.780512] raid6: sse2x1    8388 MB/s
[    2.848461] raid6: sse2x2   10300 MB/s
[    2.916407] raid6: sse2x4   11857 MB/s
[    2.916408] raid6: using algorithm sse2x4 (11857 MB/s)
[    2.917476] md: raid6 personality registered for level 6
[    2.917477] md: raid5 personality registered for level 5
[    2.917479] md: raid4 personality registered for level 4
[    2.919301] mdadm: sending ioctl 1261 to a partition!
[    2.919303] mdadm: sending ioctl 1261 to a partition!
[    2.919866] mdadm: sending ioctl 1261 to a partition!
[    2.919869] mdadm: sending ioctl 1261 to a partition!
[    2.927265] mdadm: sending ioctl 1261 to a partition!
[    2.927269] mdadm: sending ioctl 1261 to a partition!
[    2.927380] mdadm: sending ioctl 1261 to a partition!
[    2.927382] mdadm: sending ioctl 1261 to a partition!
[    2.927479] mdadm: sending ioctl 1261 to a partition!
[    2.927481] mdadm: sending ioctl 1261 to a partition!
[    2.986826] kjournald starting.  Commit interval 5 seconds
[    2.986961] EXT3-fs (sda3): mounted filesystem with ordered data mode
[    3.965497] udev[335]: starting version 164
[    4.075072] wmi: Mapper loaded
[    4.171168] input: PC Speaker as /devices/platform/pcspkr/input/input0
[    4.176232] input: Power Button as
/devices/LNXSYSTM:00/device:00/PNP0C0C:00/input/input1
[    4.176268] ACPI: Power Button [PWRB]
[    4.176316] input: Power Button as
/devices/LNXSYSTM:00/LNXPWRBN:00/input/input2
[    4.176345] ACPI: Power Button [PWRF]
[    4.195967] i801_smbus 0000:00:1f.3: PCI INT C -> GSI 18 (level,
low) -> IRQ 18
[    4.195973] ACPI: resource 0000:00:1f.3 [io  0xf040-0xf05f]
conflicts with ACPI region SMBI [io 0xf040-0xf04f]
[    4.195975] ACPI: If an ACPI driver is available for this device,
you should use it instead of the native driver
[    4.205863] [drm] Initialized drm 1.1.0 20060810
[    4.240713] i915 0000:00:02.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
[    4.240717] i915 0000:00:02.0: setting latency timer to 64
[    4.246792] asus_wmi: ASUS WMI generic driver loaded
[    4.247292] asus_wmi: Initialization: 0x0
[    4.247314] asus_wmi: BIOS WMI version: 0.9
[    4.247366] asus_wmi: SFUN value: 0x0
[    4.247730] input: Eee PC WMI hotkeys as
/devices/platform/eeepc-wmi/input/input3
[    4.248637] asus_wmi: Backlight controlled by ACPI video driver
[    4.268283] mtrr: type mismatch for e0000000,10000000 old:
write-back new: write-combining
[    4.268285] [drm] MTRR allocation failed.  Graphics performance may suffer.
[    4.268490] i915 0000:00:02.0: irq 43 for MSI/MSI-X
[    4.268494] [drm] Supports vblank timestamp caching Rev 1 (10.10.2010).
[    4.268495] [drm] Driver supports precise vblank timestamp query.
[    4.268521] vgaarb: device changed decodes:
PCI:0000:00:02.0,olddecodes=io+mem,decodes=io+mem:owns=io+mem
[    4.302448] e1000e: Intel(R) PRO/1000 Network Driver - 1.5.1-k
[    4.302449] e1000e: Copyright(c) 1999 - 2011 Intel Corporation.
[    4.357824] firewire_ohci 0000:07:02.0: PCI INT A -> GSI 17 (level,
low) -> IRQ 17
[    4.367843] usbcore: registered new interface driver usbfs
[    4.367886] usbcore: registered new interface driver hub
[    4.367914] usbcore: registered new device driver usb
[    4.419355] firewire_ohci: Added fw-ohci device 0000:07:02.0, OHCI
v1.10, 4 IR + 8 IT contexts, quirks 0x11
[    4.426085] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    4.460049] xhci_hcd 0000:03:00.0: PCI INT A -> GSI 17 (level, low) -> IRQ 17
[    4.460079] xhci_hcd 0000:03:00.0: setting latency timer to 64
[    4.460084] xhci_hcd 0000:03:00.0: xHCI Host Controller
[    4.460104] xhci_hcd 0000:03:00.0: new USB bus registered, assigned
bus number 1
[    4.488868] sata_sil 0000:07:00.0: version 2.4
[    4.488895] sata_sil 0000:07:00.0: PCI INT A -> GSI 18 (level, low) -> IRQ 18
[    4.488930] sata_sil 0000:07:00.0: Applying R_ERR on DMA activate
FIS errata fix
[    4.489348] scsi10 : sata_sil
[    4.489409] scsi11 : sata_sil
[    4.489914] scsi12 : sata_sil
[    4.489967] scsi13 : sata_sil
[    4.490006] ata11: SATA max UDMA/100 mmio m1024@0xf7902000 tf
0xf7902080 irq 18
[    4.490013] ata12: SATA max UDMA/100 mmio m1024@0xf7902000 tf
0xf79020c0 irq 18
[    4.490017] ata13: SATA max UDMA/100 mmio m1024@0xf7902000 tf
0xf7902280 irq 18
[    4.490022] ata14: SATA max UDMA/100 mmio m1024@0xf7902000 tf
0xf79022c0 irq 18
[    4.490055] sata_sil 0000:07:01.0: PCI INT A -> GSI 19 (level, low) -> IRQ 19
[    4.490093] sata_sil 0000:07:01.0: Applying R_ERR on DMA activate
FIS errata fix
[    4.490507] scsi14 : sata_sil
[    4.490561] scsi15 : sata_sil
[    4.490616] scsi16 : sata_sil
[    4.490663] scsi17 : sata_sil
[    4.490703] ata15: SATA max UDMA/100 mmio m1024@0xf7901000 tf
0xf7901080 irq 19
[    4.490708] ata16: SATA max UDMA/100 mmio m1024@0xf7901000 tf
0xf79010c0 irq 19
[    4.490713] ata17: SATA max UDMA/100 mmio m1024@0xf7901000 tf
0xf7901280 irq 19
[    4.490718] ata18: SATA max UDMA/100 mmio m1024@0xf7901000 tf
0xf79012c0 irq 19
[    4.513805] fbcon: inteldrmfb (fb0) is primary device
[    4.521203] xhci_hcd 0000:03:00.0: irq 17, io mem 0xf7d00000
[    4.521265] xhci_hcd 0000:03:00.0: irq 44 for MSI/MSI-X
[    4.521268] xhci_hcd 0000:03:00.0: irq 45 for MSI/MSI-X
[    4.521271] xhci_hcd 0000:03:00.0: irq 46 for MSI/MSI-X
[    4.521274] xhci_hcd 0000:03:00.0: irq 47 for MSI/MSI-X
[    4.521277] xhci_hcd 0000:03:00.0: irq 48 for MSI/MSI-X
[    4.521370] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
[    4.521371] usb usb1: New USB device strings: Mfr=3, Product=2,
SerialNumber=1
[    4.521373] usb usb1: Product: xHCI Host Controller
[    4.521374] usb usb1: Manufacturer: Linux 3.2.0-0.bpo.2-amd64 xhci_hcd
[    4.521375] usb usb1: SerialNumber: 0000:03:00.0
[    4.521445] xHCI xhci_add_endpoint called for root hub
[    4.521446] xHCI xhci_check_bandwidth called for root hub
[    4.521476] hub 1-0:1.0: USB hub found
[    4.521484] hub 1-0:1.0: 2 ports detected
[    4.521541] xhci_hcd 0000:03:00.0: xHCI Host Controller
[    4.521546] xhci_hcd 0000:03:00.0: new USB bus registered, assigned
bus number 2
[    4.521571] usb usb2: New USB device found, idVendor=1d6b, idProduct=0003
[    4.521572] usb usb2: New USB device strings: Mfr=3, Product=2,
SerialNumber=1
[    4.521574] usb usb2: Product: xHCI Host Controller
[    4.521575] usb usb2: Manufacturer: Linux 3.2.0-0.bpo.2-amd64 xhci_hcd
[    4.521577] usb usb2: SerialNumber: 0000:03:00.0
[    4.521631] xHCI xhci_add_endpoint called for root hub
[    4.521632] xHCI xhci_check_bandwidth called for root hub
[    4.521660] hub 2-0:1.0: USB hub found
[    4.521667] hub 2-0:1.0: 2 ports detected
[    4.535256] xhci_hcd 0000:05:00.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
[    4.535288] xhci_hcd 0000:05:00.0: setting latency timer to 64
[    4.535291] xhci_hcd 0000:05:00.0: xHCI Host Controller
[    4.535298] xhci_hcd 0000:05:00.0: new USB bus registered, assigned
bus number 3
[    4.596398] xhci_hcd 0000:05:00.0: irq 16, io mem 0xf7b00000
[    4.596491] xhci_hcd 0000:05:00.0: irq 49 for MSI/MSI-X
[    4.596495] xhci_hcd 0000:05:00.0: irq 50 for MSI/MSI-X
[    4.596497] xhci_hcd 0000:05:00.0: irq 51 for MSI/MSI-X
[    4.596500] xhci_hcd 0000:05:00.0: irq 52 for MSI/MSI-X
[    4.596503] xhci_hcd 0000:05:00.0: irq 53 for MSI/MSI-X
[    4.596589] usb usb3: New USB device found, idVendor=1d6b, idProduct=0002
[    4.596591] usb usb3: New USB device strings: Mfr=3, Product=2,
SerialNumber=1
[    4.596592] usb usb3: Product: xHCI Host Controller
[    4.596593] usb usb3: Manufacturer: Linux 3.2.0-0.bpo.2-amd64 xhci_hcd
[    4.596594] usb usb3: SerialNumber: 0000:05:00.0
[    4.596675] xHCI xhci_add_endpoint called for root hub
[    4.596676] xHCI xhci_check_bandwidth called for root hub
[    4.596696] hub 3-0:1.0: USB hub found
[    4.596702] hub 3-0:1.0: 2 ports detected
[    4.596755] xhci_hcd 0000:05:00.0: xHCI Host Controller
[    4.596760] xhci_hcd 0000:05:00.0: new USB bus registered, assigned
bus number 4
[    4.596780] usb usb4: New USB device found, idVendor=1d6b, idProduct=0003
[    4.596781] usb usb4: New USB device strings: Mfr=3, Product=2,
SerialNumber=1
[    4.596782] usb usb4: Product: xHCI Host Controller
[    4.596783] usb usb4: Manufacturer: Linux 3.2.0-0.bpo.2-amd64 xhci_hcd
[    4.596784] usb usb4: SerialNumber: 0000:05:00.0
[    4.596836] xHCI xhci_add_endpoint called for root hub
[    4.596837] xHCI xhci_check_bandwidth called for root hub
[    4.596863] hub 4-0:1.0: USB hub found
[    4.596870] hub 4-0:1.0: 2 ports detected
[    4.688002] Console: switching to colour frame buffer device 128x48
[    4.689644] fb0: inteldrmfb frame buffer device
[    4.689645] drm: registered panic notifier
[    4.711404] acpi device:63: registered as cooling_device9
[    4.711556] input: Video Bus as
/devices/LNXSYSTM:00/device:00/PNP0A08:00/LNXVIDEO:00/input/input4
[    4.711624] ACPI: Video Device [GFX0] (multi-head: yes  rom: no  post: no)
[    4.711676] [drm] Initialized i915 1.6.0 20080730 for 0000:00:02.0 on minor 0
[    4.711710] e1000e 0000:00:19.0: PCI INT A -> GSI 20 (level, low) -> IRQ 20
[    4.711720] e1000e 0000:00:19.0: setting latency timer to 64
[    4.711816] e1000e 0000:00:19.0: irq 54 for MSI/MSI-X
[    4.807971] ata15: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[    4.808060] ata11: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[    4.815920] ata11.00: ATA-8: ST2000DM001-9YN164, CC4C, max UDMA/133
[    4.815922] ata11.00: 3907029168 sectors, multi 16: LBA48 NCQ (depth 0/32)
[    4.815940] ata15.00: ATA-8: ST2000DM001-9YN164, CC4C, max UDMA/133
[    4.815942] ata15.00: 3907029168 sectors, multi 16: LBA48 NCQ (depth 0/32)
[    4.847855] ata11.00: configured for UDMA/100
[    4.847876] ata15.00: configured for UDMA/100
[    4.847942] scsi 10:0:0:0: Direct-Access     ATA
ST2000DM001-9YN1 CC4C PQ: 0 ANSI: 5
[    4.848080] sd 10:0:0:0: [sdd] 3907029168 512-byte logical blocks:
(2.00 TB/1.81 TiB)
[    4.848083] sd 10:0:0:0: [sdd] 4096-byte physical blocks
[    4.848140] sd 10:0:0:0: [sdd] Write Protect is off
[    4.848142] sd 10:0:0:0: [sdd] Mode Sense: 00 3a 00 00
[    4.848160] sd 10:0:0:0: [sdd] Write cache: enabled, read cache:
enabled, doesn't support DPO or FUA
[    4.871035]  sdd: unknown partition table
[    4.871210] sd 10:0:0:0: [sdd] Attached SCSI disk
[    4.919032] firewire_core: created device fw0: GUID 001fc600001c5cd1, S400
[    5.017679] e1000e 0000:00:19.0: eth0: (PCI Express:2.5GT/s:Width
x1) c8:60:00:31:91:20
[    5.017681] e1000e 0000:00:19.0: eth0: Intel(R) PRO/1000 Network Connection
[    5.017730] e1000e 0000:00:19.0: eth0: MAC: 10, PHY: 11, PBA No: FFFFFF-0FF
[    5.017753] ehci_hcd 0000:00:1a.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
[    5.017785] ehci_hcd 0000:00:1a.0: setting latency timer to 64
[    5.017788] ehci_hcd 0000:00:1a.0: EHCI Host Controller
[    5.017796] ehci_hcd 0000:00:1a.0: new USB bus registered, assigned
bus number 5
[    5.017810] ehci_hcd 0000:00:1a.0: broken D3 during system sleep on ASUS
[    5.017826] ehci_hcd 0000:00:1a.0: debug port 2
[    5.021703] ehci_hcd 0000:00:1a.0: Enabling legacy PCI PM
[    5.021711] ehci_hcd 0000:00:1a.0: cache line size of 64 is not supported
[    5.021723] ehci_hcd 0000:00:1a.0: irq 16, io mem 0xf7e28000
[    5.034839] ehci_hcd 0000:00:1a.0: USB 2.0 started, EHCI 1.00
[    5.034876] usb usb5: New USB device found, idVendor=1d6b, idProduct=0002
[    5.034878] usb usb5: New USB device strings: Mfr=3, Product=2,
SerialNumber=1
[    5.034879] usb usb5: Product: EHCI Host Controller
[    5.034880] usb usb5: Manufacturer: Linux 3.2.0-0.bpo.2-amd64 ehci_hcd
[    5.034881] usb usb5: SerialNumber: 0000:00:1a.0
[    5.035012] hub 5-0:1.0: USB hub found
[    5.035016] hub 5-0:1.0: 2 ports detected
[    5.035070] ehci_hcd 0000:00:1d.0: PCI INT A -> GSI 23 (level, low) -> IRQ 23
[    5.035084] ehci_hcd 0000:00:1d.0: setting latency timer to 64
[    5.035087] ehci_hcd 0000:00:1d.0: EHCI Host Controller
[    5.035093] ehci_hcd 0000:00:1d.0: new USB bus registered, assigned
bus number 6
[    5.035105] ehci_hcd 0000:00:1d.0: broken D3 during system sleep on ASUS
[    5.035118] ehci_hcd 0000:00:1d.0: debug port 2
[    5.038994] ehci_hcd 0000:00:1d.0: Enabling legacy PCI PM
[    5.039003] ehci_hcd 0000:00:1d.0: cache line size of 64 is not supported
[    5.039019] ehci_hcd 0000:00:1d.0: irq 23, io mem 0xf7e27000
[    5.054825] ehci_hcd 0000:00:1d.0: USB 2.0 started, EHCI 1.00
[    5.054859] usb usb6: New USB device found, idVendor=1d6b, idProduct=0002
[    5.054861] usb usb6: New USB device strings: Mfr=3, Product=2,
SerialNumber=1
[    5.054862] usb usb6: Product: EHCI Host Controller
[    5.054863] usb usb6: Manufacturer: Linux 3.2.0-0.bpo.2-amd64 ehci_hcd
[    5.054865] usb usb6: SerialNumber: 0000:00:1d.0
[    5.054993] hub 6-0:1.0: USB hub found
[    5.054997] hub 6-0:1.0: 2 ports detected
[    5.055067] snd_hda_intel 0000:00:1b.0: PCI INT A -> GSI 22 (level,
low) -> IRQ 22
[    5.055113] snd_hda_intel 0000:00:1b.0: irq 55 for MSI/MSI-X
[    5.055132] snd_hda_intel 0000:00:1b.0: setting latency timer to 64
[    5.166806] ata12: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[    5.175369] ata12.00: ATA-8: ST2000DM001-9YN164, CC4B, max UDMA/133
[    5.175371] ata12.00: 3907029168 sectors, multi 16: LBA48 NCQ (depth 0/32)
[    5.215327] ata12.00: configured for UDMA/100
[    5.215484] scsi 11:0:0:0: Direct-Access     ATA
ST2000DM001-9YN1 CC4B PQ: 0 ANSI: 5
[    5.215587] sd 11:0:0:0: [sde] 3907029168 512-byte logical blocks:
(2.00 TB/1.81 TiB)
[    5.215590] sd 11:0:0:0: [sde] 4096-byte physical blocks
[    5.215665] sd 11:0:0:0: [sde] Write Protect is off
[    5.215668] sd 11:0:0:0: [sde] Mode Sense: 00 3a 00 00
[    5.215689] sd 11:0:0:0: [sde] Write cache: enabled, read cache:
enabled, doesn't support DPO or FUA
[    5.236677]  sde: unknown partition table
[    5.236838] sd 11:0:0:0: [sde] Attached SCSI disk
[    5.346609] usb 5-1: new high-speed USB device number 2 using ehci_hcd
[    5.478953] usb 5-1: New USB device found, idVendor=8087, idProduct=0024
[    5.478956] usb 5-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    5.479236] hub 5-1:1.0: USB hub found
[    5.479324] hub 5-1:1.0: 6 ports detected
[    5.534544] ata13: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[    5.543097] ata13.00: ATA-8: ST2000DM001-9YN164, CC4C, max UDMA/133
[    5.543100] ata13.00: 3907029168 sectors, multi 16: LBA48 NCQ (depth 0/32)
[    5.575058] ata13.00: configured for UDMA/100
[    5.575204] scsi 12:0:0:0: Direct-Access     ATA
ST2000DM001-9YN1 CC4C PQ: 0 ANSI: 5
[    5.575306] sd 12:0:0:0: [sdf] 3907029168 512-byte logical blocks:
(2.00 TB/1.81 TiB)
[    5.575309] sd 12:0:0:0: [sdf] 4096-byte physical blocks
[    5.575347] sd 12:0:0:0: [sdf] Write Protect is off
[    5.575349] sd 12:0:0:0: [sdf] Mode Sense: 00 3a 00 00
[    5.575369] sd 12:0:0:0: [sdf] Write cache: enabled, read cache:
enabled, doesn't support DPO or FUA
[    5.590427] usb 6-1: new high-speed USB device number 2 using ehci_hcd
[    5.601390]  sdf: unknown partition table
[    5.601550] sd 12:0:0:0: [sdf] Attached SCSI disk
[    5.722771] usb 6-1: New USB device found, idVendor=8087, idProduct=0024
[    5.722773] usb 6-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    5.723060] hub 6-1:1.0: USB hub found
[    5.723138] hub 6-1:1.0: 8 ports detected
[    5.794465] usb 5-1.1: new low-speed USB device number 3 using ehci_hcd
[    5.893392] usb 5-1.1: New USB device found, idVendor=046d, idProduct=c313
[    5.893394] usb 5-1.1: New USB device strings: Mfr=1, Product=2,
SerialNumber=0
[    5.893396] usb 5-1.1: Product: USB Multimedia Keyboard
[    5.893397] usb 5-1.1: Manufacturer: LITEON Technology
[    5.894245] ata14: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[    5.902831] ata14.00: ATA-8: ST2000DM001-9YN164, CC4C, max UDMA/133
[    5.902833] ata14.00: 3907029168 sectors, multi 16: LBA48 NCQ (depth 0/32)
[    5.934789] ata14.00: configured for UDMA/100
[    5.934935] scsi 13:0:0:0: Direct-Access     ATA
ST2000DM001-9YN1 CC4C PQ: 0 ANSI: 5
[    5.935040] sd 13:0:0:0: [sdg] 3907029168 512-byte logical blocks:
(2.00 TB/1.81 TiB)
[    5.935042] sd 13:0:0:0: [sdg] 4096-byte physical blocks
[    5.935080] sd 13:0:0:0: [sdg] Write Protect is off
[    5.935082] sd 13:0:0:0: [sdg] Mode Sense: 00 3a 00 00
[    5.935098] sd 13:0:0:0: [sdg] Write cache: enabled, read cache:
enabled, doesn't support DPO or FUA
[    5.935163] scsi 14:0:0:0: Direct-Access     ATA
ST2000DM001-9YN1 CC4C PQ: 0 ANSI: 5
[    5.935363] sd 14:0:0:0: [sdh] 3907029168 512-byte logical blocks:
(2.00 TB/1.81 TiB)
[    5.935366] sd 14:0:0:0: [sdh] 4096-byte physical blocks
[    5.935415] sd 14:0:0:0: [sdh] Write Protect is off
[    5.935416] sd 14:0:0:0: [sdh] Mode Sense: 00 3a 00 00
[    5.935434] sd 14:0:0:0: [sdh] Write cache: enabled, read cache:
enabled, doesn't support DPO or FUA
[    5.949457] input: LITEON Technology USB Multimedia Keyboard as
/devices/pci0000:00/0000:00:1a.0/usb5/5-1/5-1.1/5-1.1:1.0/input/input5
[    5.949522] generic-usb 0003:046D:C313.0001: input,hidraw0: USB HID
v1.10 Keyboard [LITEON Technology USB Multimedia Keyboard] on
usb-0000:00:1a.0-1.1/input0
[    5.952397] input: LITEON Technology USB Multimedia Keyboard as
/devices/pci0000:00/0000:00:1a.0/usb5/5-1/5-1.1/5-1.1:1.1/input/input6
[    5.952464] generic-usb 0003:046D:C313.0002: input,hidraw1: USB HID
v1.10 Device [LITEON Technology USB Multimedia Keyboard] on
usb-0000:00:1a.0-1.1/input1
[    5.952474] usbcore: registered new interface driver usbhid
[    5.952475] usbhid: USB HID core driver
[    5.954683]  sdh: unknown partition table
[    5.954991] sd 14:0:0:0: [sdh] Attached SCSI disk
[    5.955691]  sdg: unknown partition table
[    5.955831] sd 13:0:0:0: [sdg] Attached SCSI disk
[    5.994321] usb 6-1.7: new full-speed USB device number 3 using ehci_hcd
[    6.086748] usb 6-1.7: New USB device found, idVendor=0cf3, idProduct=3000
[    6.086751] usb 6-1.7: New USB device strings: Mfr=0, Product=0,
SerialNumber=0
[    6.253994] ata16: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[    6.262558] ata16.00: ATA-8: ST2000DM001-9YN164, CC4C, max UDMA/133
[    6.262560] ata16.00: 3907029168 sectors, multi 16: LBA48 NCQ (depth 0/32)
[    6.294526] ata16.00: configured for UDMA/100
[    6.294682] scsi 15:0:0:0: Direct-Access     ATA
ST2000DM001-9YN1 CC4C PQ: 0 ANSI: 5
[    6.294792] sd 15:0:0:0: [sdi] 3907029168 512-byte logical blocks:
(2.00 TB/1.81 TiB)
[    6.294795] sd 15:0:0:0: [sdi] 4096-byte physical blocks
[    6.294889] sd 15:0:0:0: [sdi] Write Protect is off
[    6.294891] sd 15:0:0:0: [sdi] Mode Sense: 00 3a 00 00
[    6.294968] sd 15:0:0:0: [sdi] Write cache: enabled, read cache:
enabled, doesn't support DPO or FUA
[    6.320690]  sdi: unknown partition table
[    6.321017] sd 15:0:0:0: [sdi] Attached SCSI disk
[    6.613725] ata17: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[    6.622290] ata17.00: ATA-8: ST2000DM001-9YN164, CC4C, max UDMA/133
[    6.622292] ata17.00: 3907029168 sectors, multi 16: LBA48 NCQ (depth 0/32)
[    6.662250] ata17.00: configured for UDMA/100
[    6.662393] scsi 16:0:0:0: Direct-Access     ATA
ST2000DM001-9YN1 CC4C PQ: 0 ANSI: 5
[    6.662488] sd 16:0:0:0: [sdj] 3907029168 512-byte logical blocks:
(2.00 TB/1.81 TiB)
[    6.662491] sd 16:0:0:0: [sdj] 4096-byte physical blocks
[    6.662549] sd 16:0:0:0: [sdj] Write Protect is off
[    6.662551] sd 16:0:0:0: [sdj] Mode Sense: 00 3a 00 00
[    6.662626] sd 16:0:0:0: [sdj] Write cache: enabled, read cache:
enabled, doesn't support DPO or FUA
[    6.681319]  sdj: unknown partition table
[    6.681471] sd 16:0:0:0: [sdj] Attached SCSI disk
[    6.981449] ata18: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[    6.990018] ata18.00: ATA-8: ST2000DM001-9YN164, CC4C, max UDMA/133
[    6.990021] ata18.00: 3907029168 sectors, multi 16: LBA48 NCQ (depth 0/32)
[    7.029978] ata18.00: configured for UDMA/100
[    7.030096] scsi 17:0:0:0: Direct-Access     ATA
ST2000DM001-9YN1 CC4C PQ: 0 ANSI: 5
[    7.030187] sd 17:0:0:0: [sdk] 3907029168 512-byte logical blocks:
(2.00 TB/1.81 TiB)
[    7.030189] sd 17:0:0:0: [sdk] 4096-byte physical blocks
[    7.030313] sd 17:0:0:0: [sdk] Write Protect is off
[    7.030316] sd 17:0:0:0: [sdk] Mode Sense: 00 3a 00 00
[    7.030393] sd 17:0:0:0: [sdk] Write cache: enabled, read cache:
enabled, doesn't support DPO or FUA
[    7.051090]  sdk: unknown partition table
[    7.051410] sd 17:0:0:0: [sdk] Attached SCSI disk
[    7.066363] sr0: scsi3-mmc drive: 48x/12x writer dvd-ram cd/rw
xa/form2 cdda tray
[    7.066366] cdrom: Uniform CD-ROM driver Revision: 3.20
[    7.066492] sr 0:0:0:0: Attached scsi CD-ROM sr0
[    7.138206] HDMI status: Codec=3 Pin=7 Presence_Detect=0 ELD_Valid=0
[    7.138346] input: HDA Intel PCH HDMI/DP,pcm=3 as
/devices/pci0000:00/0000:00:1b.0/sound/card0/input7
[    7.138506] input: HDA Intel PCH Headphone as
/devices/pci0000:00/0000:00:1b.0/sound/card0/input8
[    7.171430] sr 0:0:0:0: Attached scsi generic sg0 type 5
[    7.171473] sd 1:0:0:0: Attached scsi generic sg1 type 0
[    7.171513] sd 2:0:0:0: Attached scsi generic sg2 type 0
[    7.171552] sd 8:0:0:0: Attached scsi generic sg3 type 0
[    7.171595] sd 10:0:0:0: Attached scsi generic sg4 type 0
[    7.171987] sd 11:0:0:0: Attached scsi generic sg5 type 0
[    7.172039] sd 12:0:0:0: Attached scsi generic sg6 type 0
[    7.172138] sd 13:0:0:0: Attached scsi generic sg7 type 0
[    7.172181] sd 14:0:0:0: Attached scsi generic sg8 type 0
[    7.172217] sd 15:0:0:0: Attached scsi generic sg9 type 0
[    7.172255] sd 16:0:0:0: Attached scsi generic sg10 type 0
[    7.172300] sd 17:0:0:0: Attached scsi generic sg11 type 0
[    7.217612] Bluetooth: Core ver 2.16
[    7.217622] NET: Registered protocol family 31
[    7.217624] Bluetooth: HCI device and connection manager initialized
[    7.217625] Bluetooth: HCI socket layer initialized
[    7.217626] Bluetooth: L2CAP socket layer initialized
[    7.217629] Bluetooth: SCO socket layer initialized
[    7.261840] Bluetooth: Atheros AR30xx firmware driver ver 1.0
[    7.449650] Bluetooth: Error loading firmware
[    7.449683] ath3k: probe of 6-1.7:1.0 failed with error -5
[    7.449702] usbcore: registered new interface driver ath3k
[    8.092515] Adding 31250428k swap on /dev/sda2.  Priority:-1
extents:1 across:31250428k
[    8.375202] EXT3-fs (sda3): using internal journal
[    8.531468] loop: module loaded
[    8.557506] md: md1 stopped.
[    8.561218] md: bind<sdf>
[    8.561443] md: bind<sdg>
[    8.561669] md: bind<sdj>
[    8.562104] md: bind<sdk>
[    8.562248] md: bind<sdc>
[    8.563795] bio: create slab <bio-1> at 1
[    8.563802] md/raid:md1: not clean -- starting background reconstruction
[    8.563812] md/raid:md1: device sdc operational as raid disk 0
[    8.563814] md/raid:md1: device sdk operational as raid disk 4
[    8.563815] md/raid:md1: device sdj operational as raid disk 3
[    8.563817] md/raid:md1: device sdg operational as raid disk 2
[    8.563819] md/raid:md1: device sdf operational as raid disk 1
[    8.564244] md/raid:md1: allocated 5332kB
[    8.565191] md/raid:md1: raid level 6 active with 5 out of 5
devices, algorithm 2
[    8.565193] RAID conf printout:
[    8.565195]  --- level:6 rd:5 wd:5
[    8.565196]  disk 0, o:1, dev:sdc
[    8.565198]  disk 1, o:1, dev:sdf
[    8.565200]  disk 2, o:1, dev:sdg
[    8.565201]  disk 3, o:1, dev:sdj
[    8.565203]  disk 4, o:1, dev:sdk
[    8.565238] md1: detected capacity change from 0 to 6001191813120
[    8.576664] md: md0 stopped.
[    8.578433] md: bind<sdd>
[    8.579509] md: bind<sde>
[    8.579878] md: bind<sdh>
[    8.580910] md: bind<sdi>
[    8.581028] md: bind<sdb>
[    8.581461]  md1: unknown partition table
[    8.584352] md/raid:md0: device sdb operational as raid disk 0
[    8.584355] md/raid:md0: device sdi operational as raid disk 4
[    8.584357] md/raid:md0: device sdh operational as raid disk 3
[    8.584359] md/raid:md0: device sde operational as raid disk 2
[    8.584361] md/raid:md0: device sdd operational as raid disk 1
[    8.584795] md/raid:md0: allocated 5332kB
[    8.584822] md/raid:md0: raid level 6 active with 5 out of 5
devices, algorithm 2
[    8.584824] RAID conf printout:
[    8.584825]  --- level:6 rd:5 wd:5
[    8.584826]  disk 0, o:1, dev:sdb
[    8.584827]  disk 1, o:1, dev:sdd
[    8.584828]  disk 2, o:1, dev:sde
[    8.584829]  disk 3, o:1, dev:sdh
[    8.584830]  disk 4, o:1, dev:sdi
[    8.584852] md0: detected capacity change from 0 to 6001191813120
[    8.587172]  md0: unknown partition table
[    8.926356] kjournald starting.  Commit interval 5 seconds
[    8.926517] EXT3-fs (sda1): using internal journal
[    8.926520] EXT3-fs (sda1): mounted filesystem with ordered data mode
[    8.975245] SGI XFS with ACLs, security attributes, realtime, large
block/inode numbers, no debug enabled
[    8.975421] SGI XFS Quota Management subsystem
[    8.996893] XFS (md0): Mounting Filesystem
[    9.338163] XFS (md0): Ending clean mount
[    9.365108] XFS (md1): Mounting Filesystem
[    9.612625] md: resync of RAID array md1
[    9.612628] md: minimum _guaranteed_  speed: 1000 KB/sec/disk.
[    9.612630] md: using maximum available idle IO bandwidth (but not
more than 200000 KB/sec) for resync.
[    9.612634] md: using 128k window, over a total of 1953512960k.
[    9.612635] md: resuming resync of md1 from checkpoint.
[    9.774855] XFS (md1): Ending clean mount
[   10.544176] fuse init (API version 7.17)
[   11.192332] RPC: Registered named UNIX socket transport module.
[   11.192334] RPC: Registered udp transport module.
[   11.192335] RPC: Registered tcp transport module.
[   11.192336] RPC: Registered tcp NFSv4.1 backchannel transport module.
[   11.564209] Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
[   11.611884] svc: failed to register lockdv1 RPC service (errno 97).
[   11.611909] NFSD: Using /var/lib/nfs/v4recovery as the NFSv4 state
recovery directory
[   12.116657] e1000e 0000:00:19.0: irq 54 for MSI/MSI-X
[   12.169607] e1000e 0000:00:19.0: irq 54 for MSI/MSI-X
[   12.170093] ADDRCONF(NETDEV_UP): eth0: link is not ready
[   13.587445] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[   13.587447] Bluetooth: BNEP filters: protocol multicast
[   13.602250] Bluetooth: RFCOMM TTY layer initialized
[   13.602254] Bluetooth: RFCOMM socket layer initialized
[   13.602256] Bluetooth: RFCOMM ver 1.11
[   13.661202] Bridge firewalling registered
[   13.727256] e1000e: eth0 NIC Link is Up 100 Mbps Half Duplex, Flow
Control: None
[   13.727259] e1000e 0000:00:19.0: eth0: 10/100 speed: disabling TSO
[   13.731780] ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
[   14.402318] lp: driver loaded but no devices found
[   14.404276] ppdev: user-space parallel port driver
[   19.322951] sshd (2110): /proc/2110/oom_adj is deprecated, please
use /proc/2110/oom_score_adj instead.
[   24.244525] eth0: no IPv6 routers present
[  346.120568] irq 19: nobody cared (try booting with the "irqpoll" option)
[  346.120572] Pid: 1100, comm: md1_resync Not tainted 3.2.0-0.bpo.2-amd64 #1
[  346.120573] Call Trace:
[  346.120575]  <IRQ>  [<ffffffff8109950b>] ? __report_bad_irq+0x2c/0xb7
[  346.120582]  [<ffffffff8109970e>] ? note_interrupt+0x178/0x1fa
[  346.120584]  [<ffffffff81097aad>] ? handle_irq_event_percpu+0x166/0x184
[  346.120587]  [<ffffffff81024f7f>] ? lapic_next_event+0x18/0x1d
[  346.120588]  [<ffffffff81097aff>] ? handle_irq_event+0x34/0x55
[  346.120590]  [<ffffffff81099d76>] ? handle_fasteoi_irq+0x8d/0xdb
[  346.120593]  [<ffffffff8100fa93>] ? handle_irq+0x1a/0x23
[  346.120595]  [<ffffffff8100f33b>] ? do_IRQ+0x45/0xaa
[  346.120598]  [<ffffffff813655ee>] ? common_interrupt+0x6e/0x6e
[  346.120601]  [<ffffffff811adf9a>] ? blk_done_softirq+0x3e/0x78
[  346.120604]  [<ffffffff8104f1a2>] ? __do_softirq+0xc4/0x1a0
[  346.120605]  [<ffffffff81097aad>] ? handle_irq_event_percpu+0x166/0x184
[  346.120607]  [<ffffffff8104f21b>] ? __do_softirq+0x13d/0x1a0
[  346.120610]  [<ffffffff8136cb6c>] ? call_softirq+0x1c/0x30
[  346.120612]  [<ffffffff8100fa3f>] ? do_softirq+0x3f/0x79
[  346.120613]  [<ffffffff8104ef72>] ? irq_exit+0x44/0xb5
[  346.120615]  [<ffffffff8100f38a>] ? do_IRQ+0x94/0xaa
[  346.120616]  [<ffffffff813655ee>] ? common_interrupt+0x6e/0x6e
[  346.120617]  <EOI>  [<ffffffff813652b0>] ?
_raw_spin_unlock_irqrestore+0xb/0x11
[  346.120638]  [<ffffffffa00634b3>] ? ata_scsi_queuecmd+0x65/0x74 [libata]
[  346.120643]  [<ffffffffa001f555>] ? scsi_dispatch_cmd+0x181/0x21c [scsi_mod]
[  346.120649]  [<ffffffffa00247a9>] ? scsi_request_fn+0x338/0x48f [scsi_mod]
[  346.120651]  [<ffffffff811aacb2>] ? blk_queue_bio+0x2ac/0x2ce
[  346.120653]  [<ffffffff811aa026>] ? generic_make_request+0x8e/0xcd
[  346.120657]  [<ffffffffa00e5970>] ? handle_stripe+0x1ab3/0x1bcd [raid456]
[  346.120661]  [<ffffffffa00e622b>] ? sync_request+0x2af/0x1084 [raid456]
[  346.120666]  [<ffffffffa00c26a0>] ? is_mddev_idle+0xb5/0x10b [md_mod]
[  346.120670]  [<ffffffffa00c2e80>] ? md_do_sync+0x78a/0xb98 [md_mod]
[  346.120673]  [<ffffffff8100d65c>] ? __switch_to+0x175/0x2b1
[  346.120675]  [<ffffffff81044620>] ? update_curr+0xbc/0x160
[  346.120679]  [<ffffffffa00c3513>] ? md_thread+0x105/0x123 [md_mod]
[  346.120683]  [<ffffffffa00c340e>] ? md_rdev_init+0xea/0xea [md_mod]
[  346.120687]  [<ffffffffa00c340e>] ? md_rdev_init+0xea/0xea [md_mod]
[  346.120689]  [<ffffffff810633c5>] ? kthread+0x7a/0x82
[  346.120692]  [<ffffffff8136ca74>] ? kernel_thread_helper+0x4/0x10
[  346.120694]  [<ffffffff8106334b>] ? kthread_worker_fn+0x147/0x147
[  346.120696]  [<ffffffff8136ca70>] ? gs_change+0x13/0x13
[  346.120697] handlers:
[  346.120699] [<ffffffffa00479e0>] ahci_interrupt
[  346.120702] [<ffffffffa02f17ec>] sil_interrupt
[  346.120703] Disabling IRQ #19
[  346.122145] sched: RT throttling activated

# lsmod
Module                  Size  Used by
acpi_cpufreq           12893  0
mperf                  12411  1 acpi_cpufreq
cpufreq_userspace      12576  0
cpufreq_stats          12762  0
cpufreq_conservative    13147  0
cpufreq_powersave      12454  0
parport_pc             22191  0
ppdev                  12725  0
lp                     17190  0
parport                31650  3 parport_pc,ppdev,lp
bridge                 69831  0
stp                    12392  1 bridge
rfcomm                 32745  0
bnep                   17386  2
nfsd                  218618  11
lockd                  66785  1 nfsd
nfs_acl                12511  1 nfsd
auth_rpcgss            36848  1 nfsd
sunrpc                175670  12 nfsd,lockd,nfs_acl,auth_rpcgss
binfmt_misc            12914  1
fuse                   61427  1
xfs                   599918  1
loop                   22699  0
firewire_sbp2          17741  0
ath3k                  12629  0
bluetooth             122093  11 rfcomm,bnep,ath3k
crc16                  12343  1 bluetooth
sg                     25769  0
snd_hda_codec_hdmi     30578  1
sr_mod                 21824  0
usbhid                 39946  0
hid                    80937  1 usbhid
snd_hda_codec_realtek   188417  1
cdrom                  35139  1 sr_mod
xhci_hcd               72574  0
snd_hda_intel          26023  0
snd_hda_codec          81579  3
snd_hda_codec_hdmi,snd_hda_codec_realtek,snd_hda_intel
ehci_hcd               39586  0
usbcore               127444  5 ath3k,usbhid,xhci_hcd,ehci_hcd
snd_hwdep              13148  1 snd_hda_codec
snd_pcm                67465  3 snd_hda_codec_hdmi,snd_hda_intel,snd_hda_codec
firewire_ohci          35248  0
snd_seq                44678  0
snd_timer              22658  2 snd_pcm,snd_seq
snd_seq_device         13155  1 snd_seq
firewire_core          47887  2 firewire_sbp2,firewire_ohci
snd                    52458  9
snd_hda_codec_hdmi,snd_hda_codec_realtek,snd_hda_intel,snd_hda_codec,snd_hwdep,snd_pcm,snd_seq,snd_timer,snd_seq_device
soundcore              13014  1 snd
snd_page_alloc         12969  2 snd_hda_intel,snd_pcm
e1000e                128116  0
eeepc_wmi              12564  0
asus_wmi               18670  1 eeepc_wmi
sparse_keymap          12760  1 asus_wmi
i915                  357970  2
drm_kms_helper         26950  1 i915
drm                   167089  3 i915,drm_kms_helper
rfkill                 18970  3 bluetooth,asus_wmi
i2c_i801               16870  0
crc_itu_t              12347  1 firewire_core
i2c_algo_bit           12834  1 i915
usb_common             12354  1 usbcore
i2c_core               23766  5 i915,drm_kms_helper,drm,i2c_i801,i2c_algo_bit
button                 12895  1 i915
evdev                  17512  12
processor              27588  1 acpi_cpufreq
pcspkr                 12579  0
tpm_tis                17315  0
tpm                    17841  1 tpm_tis
tpm_bios               12903  1 tpm
video                  17553  1 i915
mxm_wmi                12473  0
psmouse                64191  0
serio_raw              12875  0
wmi                    13243  2 asus_wmi,mxm_wmi
ext3                  160741  2
jbd                    55645  1 ext3
mbcache                12930  1 ext3
raid456                51931  1
md_mod                 87021  2 raid456
async_raid6_recov      12507  1 raid456
async_pq               12559  2 raid456,async_raid6_recov
raid6_pq               86619  2 async_raid6_recov,async_pq
async_xor              12385  3 raid456,async_raid6_recov,async_pq
xor                    12556  1 async_xor
async_memcpy           12350  2 raid456,async_raid6_recov
async_tx               12566  5
raid456,async_raid6_recov,async_pq,async_xor,async_memcpy
sd_mod                 35644  9
crc_t10dif             12348  1 sd_mod
ahci                   24997  4
libahci                22714  1 ahci
libata                139579  3 sata_sil,ahci,libahci
scsi_mod              161684  5 firewire_sbp2,sg,sr_mod,sd_mod,libata
thermal                17330  0
fan                    12674  0
thermal_sys            17992  4 processor,video,thermal,fan

-- 
Stirling Westrup
Programmer, Entrepreneur.
https://www.linkedin.com/e/fpf/77228
http://www.linkedin.com/in/swestrup
http://technaut.livejournal.com
http://sourceforge.net/users/stirlingwestrup
