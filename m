From: "Gregory Youngblood" <gyoungblood@incentivelogic.com>
Subject: Silicon Image 3124 problems with Norco DS-1220 (Sil3726 port multipliers?)
Date: Mon, 26 Feb 2007 23:57:26 -0700
Message-ID: <A5F9EDF3C51A884B8732C10154F1020906040B@ilsaw03.corp.incentivelogic.com>
References: <A5F9EDF3C51A884B8732C10154F10209010467F3@ilsaw03.corp.incentivelogic.com> <45DE756B.2050201@gmail.com> <A5F9EDF3C51A884B8732C10154F10209060401@ilsaw03.corp.incentivelogic.com> <A5F9EDF3C51A884B8732C10154F10209060409@ilsaw03.corp.incentivelogic.com> <45E3A632.20204@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from dmail001.incentivelogic.com ([63.241.135.198]:18493 "HELO
	mail.incentivelogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751425AbXB0HQp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 27 Feb 2007 02:16:45 -0500
Received: from localhost (localhost [127.0.0.1])
	by mail.incentivelogic.com (Postfix) with ESMTP id 194E62E82CD
	for <linux-ide@vger.kernel.org>; Mon, 26 Feb 2007 23:57:31 -0700 (MST)
Received: from mail.incentivelogic.com ([127.0.0.1])
	by localhost (mail.incentivelogic.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3ChBAKmGdHud for <linux-ide@vger.kernel.org>;
	Mon, 26 Feb 2007 23:57:25 -0700 (MST)
Received: from ilsaw03.corp.incentivelogic.com (ILSAW003 [192.168.101.243])
	by mail.incentivelogic.com (Postfix) with SMTP id 08A862E8294
	for <linux-ide@vger.kernel.org>; Mon, 26 Feb 2007 23:57:24 -0700 (MST)
Content-class: urn:content-classes:message
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Hello,

As requested, I'm also CCing the linux-ide list.

I'm seeing several problems with a Silicon Image 3124 and Norco DS-1220 external sata shelf with two Silicon Image 3726 port multipliers and 8 500gb 7200.10 Seagate sata hard drives. The hardware is known to be good. Or at least the Dell server is. The only new hardware added to this server is the Norco DS-1220, Norco 4618 (Sil3124) controller, and the 8 drives. These problems are causing file operations with remote servers (via Samba) to fail intermittently. 

Any advice or help to get this working reliably is appreciated. 
Thanks,
Greg

Configuration:
Dell PowerEdge 850 w/D940 3.2 ghz dual core CPU, 1 gig RAM, 2 80 gig internal SATA (sda, sdb)
Norco DS-1220, Sil3124 sata controller, 8 seagate 7200.10 500gb drives (sdc - sdj)
openSUSE 10.2
Generic Linux 2.6.18.1 kernel (from kernel.org) with libata-tj patch (applied cleanly)

Drives are in slots: 1, 2, 5, 6, 7, 10, 11, and 12. Ports 5 and 10 are the primary ports on the port multipliers.

sdc to sdj are setup with raid6 on /dev/md0
LVM on /dev/md0
XFS on single lvm (2.8 TB total)

The sata ports connected to the port multipliers keep resetting. I spoke with someone at Norcotek and was told to make sure drives are at least in slots 5 and 10 to prevent problems.

/var/log/messages sees the following every 3 to 5 minutes there is disk activity. This only happens on the sata channels connected to the port multipliers.

Feb 26 23:01:26 snas001 kernel: ata5.03: exception Emask 0x0 SAct 0x2 SErr 0x0 action 0x2 frozen
Feb 26 23:01:26 snas001 kernel: ata5.03: tag 1 cmd 0x60 Emask 0x4 stat 0x40 err
0x0 (timeout)
Feb 26 23:01:26 snas001 kernel: ata5.15: hard resetting port
Feb 26 23:01:28 snas001 kernel: ata5.15: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Feb 26 23:01:28 snas001 kernel: ata5.00: hard resetting port
Feb 26 23:01:29 snas001 kernel: ata5.00: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Feb 26 23:01:29 snas001 kernel: ata5.01: hard resetting port
Feb 26 23:01:29 snas001 kernel: ata5.01: SATA link down (SStatus 0 SControl 300)
Feb 26 23:01:29 snas001 kernel: ata5.02: hard resetting port
Feb 26 23:01:30 snas001 kernel: ata5.02: SATA link down (SStatus 0 SControl 300)
Feb 26 23:01:30 snas001 kernel: ata5.03: hard resetting port
Feb 26 23:01:31 snas001 kernel: ata5.03: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Feb 26 23:01:31 snas001 kernel: ata5.04: hard resetting port
Feb 26 23:01:31 snas001 kernel: ata5.04: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Feb 26 23:01:31 snas001 kernel: ata5.00: configured for UDMA/100
Feb 26 23:01:31 snas001 kernel: ata5.03: configured for UDMA/100
Feb 26 23:01:31 snas001 kernel: ata5.04: configured for UDMA/100
Feb 26 23:01:31 snas001 kernel: ata5: EH complete
Feb 26 23:01:31 snas001 kernel: SCSI device sdc: 976773168 512-byte hdwr sectors (500108 MB)
Feb 26 23:01:31 snas001 kernel: sdc: Write Protect is off
Feb 26 23:01:31 snas001 kernel: sdc: Mode Sense: 00 3a 00 00
Feb 26 23:01:31 snas001 kernel: SCSI device sdc: drive cache: write back
Feb 26 23:01:31 snas001 kernel: SCSI device sdd: 976773168 512-byte hdwr sectors (500108 MB)
Feb 26 23:01:31 snas001 kernel: sdd: Write Protect is off
Feb 26 23:01:31 snas001 kernel: sdd: Mode Sense: 00 3a 00 00
Feb 26 23:01:31 snas001 kernel: SCSI device sdd: drive cache: write back
Feb 26 23:01:31 snas001 kernel: SCSI device sde: 976773168 512-byte hdwr sectors (500108 MB)
Feb 26 23:01:31 snas001 kernel: sde: Write Protect is off
Feb 26 23:01:31 snas001 kernel: sde: Mode Sense: 00 3a 00 00
Feb 26 23:01:31 snas001 kernel: SCSI device sde: drive cache: write back
Feb 26 23:01:31 snas001 kernel: SCSI device sdc: 976773168 512-byte hdwr sectors (500108 MB)
Feb 26 23:01:31 snas001 kernel: sdc: Write Protect is off
Feb 26 23:01:31 snas001 kernel: sdc: Mode Sense: 00 3a 00 00
Feb 26 23:01:31 snas001 kernel: SCSI device sdc: drive cache: write back
Feb 26 23:01:31 snas001 kernel: SCSI device sdd: 976773168 512-byte hdwr sectors (500108 MB)
Feb 26 23:01:31 snas001 kernel: sdd: Write Protect is off
Feb 26 23:01:31 snas001 kernel: sdd: Mode Sense: 00 3a 00 00
Feb 26 23:01:31 snas001 kernel: SCSI device sdd: drive cache: write back
Feb 26 23:01:31 snas001 kernel: SCSI device sde: 976773168 512-byte hdwr sectors (500108 MB)
Feb 26 23:01:31 snas001 kernel: sde: Write Protect is off
Feb 26 23:01:31 snas001 kernel: sde: Mode Sense: 00 3a 00 00
Feb 26 23:01:31 snas001 kernel: SCSI device sde: drive cache: write back

When this happens, there are also some swap errors reported. Here's an excerpt:

swapper: page allocation failure. order:0, mode:0x20

Call Trace:
 <IRQ> [<ffffffff8020dbb6>] __alloc_pages+0x299/0x2b2
 [<ffffffff80238cea>] tcp_v4_do_rcv+0x2a/0x300
 [<ffffffff802152d6>] cache_grow+0x137/0x343
 [<ffffffff803c33cf>] ip_local_deliver_finish+0x0/0x1e9
 [<ffffffff80256a9e>] cache_alloc_refill+0x17e/0x1cc
 [<ffffffff802bceef>] __kmalloc+0x95/0x9f
 [<ffffffff8022c081>] __alloc_skb+0x5c/0x123
 [<ffffffff803a6a53>] __netdev_alloc_skb+0x12/0x2d
 [<ffffffff88173174>] :tg3:tg3_alloc_rx_skb+0xc4/0x14f
 [<ffffffff8817994c>] :tg3:tg3_poll+0x413/0x97b
 [<ffffffff8020b997>] net_rx_action+0xa4/0x1b0
 [<ffffffff881775b6>] :tg3:tg3_interrupt_tagged+0x79/0x85
 [<ffffffff8020fe87>] __do_softirq+0x5e/0xd5
 [<ffffffff8026fa0e>] end_level_ioapic_vector+0x9/0x16
 [<ffffffff802588a4>] call_softirq+0x1c/0x28
 [<ffffffff80265450>] do_softirq+0x2c/0x7d
 [<ffffffff8026541b>] do_IRQ+0x6a/0x73
 [<ffffffff80252400>] mwait_idle+0x0/0x4a
 [<ffffffff80257bc9>] ret_from_intr+0x0/0xa
 <EOI> [<ffffffff803d5baf>] udp_poll+0x0/0xf3
 [<ffffffff80252436>] mwait_idle+0x36/0x4a
 [<ffffffff80244997>] cpu_idle+0x95/0xb8
 [<ffffffff805987a8>] start_kernel+0x220/0x225
 [<ffffffff8059828a>] _sinittext+0x28a/0x28e

Mem-info:
Node 0 DMA per-cpu:
cpu 0 hot: high 0, batch 1 used:0
cpu 0 cold: high 0, batch 1 used:0
cpu 1 hot: high 0, batch 1 used:0
cpu 1 cold: high 0, batch 1 used:0
Node 0 DMA32 per-cpu:
cpu 0 hot: high 186, batch 31 used:30
cpu 0 cold: high 62, batch 15 used:55
cpu 1 hot: high 186, batch 31 used:156
cpu 1 cold: high 62, batch 15 used:58
Node 0 Normal per-cpu: empty
Node 0 HighMem per-cpu: empty
Free pages:        5452kB (0kB HighMem)
Active:37009 inactive:199012 dirty:101875 writeback:2521 unstable:0 free:1363 slab:13451 mapped:2893 pagetables:846
Node 0 DMA free:3992kB min:44kB low:52kB high:64kB active:32kB inactive:7156kB present:11832kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 993 993 993
Node 0 DMA32 free:1460kB min:4008kB low:5008kB high:6012kB active:148004kB inactive:788892kB present:1017828kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0 0
Node 0 Normal free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0 0
Node 0 HighMem free:0kB min:128kB low:128kB high:128kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0 0
Node 0 DMA: 0*4kB 1*8kB 1*16kB 0*32kB 0*64kB 1*128kB 1*256kB 1*512kB 1*1024kB 1*2048kB 0*4096kB = 3992kB
Node 0 DMA32: 1*4kB 0*8kB 1*16kB 1*32kB 2*64kB 0*128kB 1*256kB 0*512kB 1*1024kB
0*2048kB 0*4096kB = 1460kB
Node 0 Normal: empty
Node 0 HighMem: empty
Swap cache: add 42, delete 42, find 0/0, race 0+0
Free swap  = 1052084kB
Total swap = 1052248kB
Free swap:       1052084kB
262080 pages of RAM
5042 reserved pages
240668 pages shared
0 pages swap cached

I disabled swap, reformatted the swap partition, and turned it back on. The problem persists. The system is not used for anything except a file server and samba. 

# free
             total       used       free     shared    buffers     cached
Mem:       1028152    1016384      11768          0         16     917240
-/+ buffers/cache:      99128     929024
Swap:      1052248        164    1052084
# vmstat 1 2
procs -----------memory---------- ---swap-- -----io---- -system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in   cs us sy id wa
 0  0    164  11776     16 917264    0    0     7   656   27   42  0  4 96  0
 0  0    164  11776     16 917300    0    0     0     0  256   16  0  0 100  0


Here's the top of /var/log/boot.msg (system has been running for too long to get from dmesg):

Inspecting /boot/System.map-2.6.18.1-ili
Loaded 24995 symbols from /boot/System.map-2.6.18.1-ili.
Symbols match kernel version 2.6.18.
No module symbols loaded - kernel modules not enabled.

klogd 1.4.1, log source = ksyslog started.
<4>Bootdata ok (command line is root=/dev/sda3 vga=0x314 resume=/dev/sda2 splash=silent)
<5>Linux version 2.6.18.1-ili (root@snas001) (gcc version 4.1.2 20061115 (prerelease) (SUSE Linux)) #2 SMP Thu Feb 22 17:24:24 MST 2007
<6>BIOS-provided physical RAM map:
<4> BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
<4> BIOS-e820: 0000000000100000 - 000000003ffc0000 (usable)
<4> BIOS-e820: 000000003ffc0000 - 000000003ffcfc00 (ACPI data)
<4> BIOS-e820: 000000003ffcfc00 - 000000003ffff000 (reserved)
<4> BIOS-e820: 00000000f0000000 - 00000000f4000000 (reserved)
<4> BIOS-e820: 00000000fec00000 - 00000000fed00400 (reserved)
<4> BIOS-e820: 00000000fed13000 - 00000000feda0000 (reserved)
<4> BIOS-e820: 00000000fee00000 - 00000000fee10000 (reserved)
<4> BIOS-e820: 00000000ffb00000 - 0000000100000000 (reserved)
<6>DMI 2.3 present.
<7>ACPI: RSDP (v000 DELL                                  ) @ 0x00000000000fd160<7>ACPI: RSDT (v001 DELL   PE850    0x00000001 MSFT 0x0100000a) @ 0x00000000000fd174
<7>ACPI: FADT (v001 DELL   PE850    0x00000001 MSFT 0x0100000a) @ 0x00000000000fd1b8
<7>ACPI: MADT (v001 DELL   PE850    0x00000001 MSFT 0x0100000a) @ 0x00000000000fd22c
<7>ACPI: SPCR (v001 DELL   PE850    0x00000001 MSFT 0x0100000a) @ 0x00000000000fd2a0
<7>ACPI: HPET (v001 DELL   PE830    0x00000001 MSFT 0x0100000a) @ 0x00000000000fd2f0
<7>ACPI: MCFG (v001 DELL   PE830    0x00000001 MSFT 0x0100000a) @ 0x00000000000fd328
<7>ACPI: SSDT (v001 DpgPmm  Cpu0Ist 0x00000011 INTL 0x20040527) @ 0x000000003ffc1c19
<7>ACPI: SSDT (v001 DpgPmm  Cpu1Ist 0x00000011 INTL 0x20040527) @ 0x000000003ffc2022
<7>ACPI: SSDT (v001 DpgPmm    CpuPm 0x00000010 INTL 0x20040527) @ 0x000000003ffc242b
<7>ACPI: DSDT (v001 DELL   PE830    0x00000001 MSFT 0x0100000e) @ 0x0000000000000000
<6>No NUMA configuration found
<6>Faking a node at 0000000000000000-000000003ffc0000
<6>Bootmem setup node 0 0000000000000000-000000003ffc0000
<7>On node 0 totalpages: 257415
<7>  DMA zone: 2958 pages, LIFO batch:0
<7>  DMA32 zone: 254457 pages, LIFO batch:31
<6>ACPI: PM-Timer IO Port: 0x808
<7>ACPI: Local APIC address 0xfee00000
<6>ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
<6>Processor #0 15:6 APIC version 20
<6>ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
<6>Processor #1 15:6 APIC version 20
<6>ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
<6>ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
<6>ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
<6>IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
<6>ACPI: IOAPIC (id[0x03] address[0xfec10000] gsi_base[32])
<6>IOAPIC[1]: apic_id 3, version 32, address 0xfec10000, GSI 32-55
<6>ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
<6>ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
<7>ACPI: IRQ0 used by override.
<7>ACPI: IRQ2 used by override.
<7>ACPI: IRQ9 used by override.
<6>Setting APIC routing to physical flat
<6>ACPI: HPET id: 0xffffffff base: 0xfed00000
<6>Using ACPI (MADT) for SMP configuration information
<6>Allocating PCI resources starting at 40000000 (gap: 3ffff000:b0001000)
<6>SMP: Allowing 2 CPUs, 0 hotplug CPUs
<4>Built 1 zonelists.  Total pages: 257415
<5>Kernel command line: root=/dev/sda3 vga=0x314 resume=/dev/sda2 splash=silent
<4>Initializing CPU#0
<4>PID hash table entries: 4096 (order: 12, 32768 bytes)
<6>time.c: Using 14.318180 MHz WALL HPET GTOD HPET/TSC timer.
<6>time.c: Detected 3200.255 MHz processor.
<4>Console: colour dummy device 80x25
<4>Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
<4>Inode-cache hash table entries: 65536 (order: 7, 524288 bytes)
<4>Checking aperture...
<4>Memory: 1024740k/1048320k available (1984k kernel code, 23196k reserved, 966k data, 192k init)
<4>Calibrating delay using timer specific routine.. 6406.94 BogoMIPS (lpj=12813888)
<6>Security Framework v1.0.0 initialized
<4>Mount-cache hash table entries: 256
<6>CPU: Trace cache: 12K uops, L1 D cache: 16K
<6>CPU: L2 cache: 2048K
<4>using mwait in idle threads.
<6>CPU: Physical Processor ID: 0
<6>CPU: Processor Core ID: 0
<6>CPU0: Thermal monitoring enabled (TM1)
<6>SMP alternatives: switching to UP code
<6>ACPI: Core revision 20060707
<6>Using local APIC timer interrupts.
<4>result 12500916
<6>Detected 12.500 MHz APIC timer.
<6>SMP alternatives: switching to SMP code
<6>Booting processor 1/2 APIC 0x1
<4>Initializing CPU#1
<4>Calibrating delay using timer specific routine.. 6400.08 BogoMIPS (lpj=12800163)
<6>CPU: Trace cache: 12K uops, L1 D cache: 16K
<6>CPU: L2 cache: 2048K
<6>CPU: Physical Processor ID: 0
<6>CPU: Processor Core ID: 1
<6>CPU1: Thermal monitoring enabled (TM1)
<4>              Intel(R) Pentium(R) D CPU 3.20GHz stepping 04
<6>Brought up 2 CPUs
<6>testing NMI watchdog ... OK.
<4>migration_cost=1300
<6>checking if image is initramfs... it is
<6>Freeing initrd memory: 3218k freed
<6>NET: Registered protocol family 16
<6>ACPI: bus type pci registered
<6>PCI: Using MMCONFIG at f0000000
<6>ACPI: Interpreter enabled
<6>ACPI: Using IOAPIC for interrupt routing
<6>ACPI: PCI Root Bridge [PCI0] (0000:00)
<7>PCI: Probing PCI hardware (bus 00)
<6>PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
<4>PCI: PXH quirk detected, disabling MSI for SHPC device
<7>Boot video device is 0000:06:05.0
<6>PCI: Transparent bridge - 0000:00:1e.0
<7>ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
<7>ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PES1._PRT]
<7>ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEP0._PRT]
<7>ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEP0.PXHA._PRT]
<7>ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEP1._PRT]
<7>ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEP2._PRT]
<7>ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIS._PRT]
<4>ACPI: PCI Interrupt Link [LNKA] (IRQs *3 4 5 6 7 9 10 11 12)
<4>ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 10 *11 12)
<4>ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 11 12) *0, disabled.
<4>ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 *5 6 7 9 10 11 12)
<4>ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 *11 12)
<4>ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 *10 11 12)
<4>ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 *6 7 9 10 11 12)
<4>ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 9 10 11 12) *0, disabled.
<5>SCSI subsystem initialized
<6>PCI: Using ACPI for IRQ routing
<6>PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
<6>hpet0: at MMIO 0xfed00000 (virtual 0xffffffffff5fe000), IRQs 2, 8, 0
<6>hpet0: 3 64-bit timers, 14318180 Hz
<6>PCI-GART: No AMD northbridge found.
<6>PCI: Bridge: 0000:00:01.0
<6>  IO window: disabled.
<6>  MEM window: disabled.
<6>  PREFETCH window: disabled.
<6>PCI: Bridge: 0000:02:00.0
<6>  IO window: e000-efff
<6>  MEM window: fe900000-feafffff
<6>  PREFETCH window: disabled.
<6>PCI: Bridge: 0000:00:1c.0
<6>  IO window: e000-efff
<6>  MEM window: fe800000-feafffff
<6>  PREFETCH window: disabled.
<6>PCI: Bridge: 0000:00:1c.4
<6>  IO window: d000-dfff
<6>  MEM window: fe600000-fe7fffff
<6>  PREFETCH window: disabled.
<6>PCI: Bridge: 0000:00:1c.5
<6>  IO window: c000-cfff
<6>  MEM window: fe400000-fe5fffff
<6>  PREFETCH window: disabled.
<4>PCI: Ignore bogus resource 6 [0:0] of 0000:06:05.0
<6>PCI: Bridge: 0000:00:1e.0
<6>  IO window: b000-bfff
<6>  MEM window: fe200000-fe3fffff
<6>  PREFETCH window: fd000000-fdffffff
<6>GSI 16 sharing vector 0xA9 and IRQ 16
<6>ACPI: PCI Interrupt 0000:00:01.0[A] -> GSI 16 (level, low) -> IRQ 169
<7>PCI: Setting latency timer of device 0000:00:01.0 to 64
<6>GSI 17 sharing vector 0xB1 and IRQ 17
<6>ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 21 (level, low) -> IRQ 177
<7>PCI: Setting latency timer of device 0000:00:1c.0 to 64
<7>PCI: Setting latency timer of device 0000:02:00.0 to 64
<6>GSI 18 sharing vector 0xB9 and IRQ 18
<6>ACPI: PCI Interrupt 0000:00:1c.4[B] -> GSI 22 (level, low) -> IRQ 185
<7>PCI: Setting latency timer of device 0000:00:1c.4 to 64
<6>GSI 19 sharing vector 0xC1 and IRQ 19
<6>ACPI: PCI Interrupt 0000:00:1c.5[C] -> GSI 23 (level, low) -> IRQ 193
<7>PCI: Setting latency timer of device 0000:00:1c.5 to 64
<7>PCI: Setting latency timer of device 0000:00:1e.0 to 64
<6>NET: Registered protocol family 2
<4>IP route cache hash table entries: 32768 (order: 6, 262144 bytes)
<4>TCP established hash table entries: 131072 (order: 9, 2097152 bytes)
<4>TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
<6>TCP: Hash tables configured (established 131072 bind 65536)
<6>TCP reno registered
<6>audit: initializing netlink socket (disabled)
<5>audit(1172195261.948:1): initialized
<4>Total HugeTLB memory allocated, 0
<5>VFS: Disk quotas dquot_6.5.1
<4>Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
<6>Initializing Cryptographic API
<6>io scheduler noop registered
<6>io scheduler anticipatory registered
<6>io scheduler deadline registered
<6>io scheduler cfq registered (default)
<7>PCI: Setting latency timer of device 0000:00:01.0 to 64
<4>assign_interrupt_mode Found MSI capability
<7>Allocate Port Service[0000:00:01.0:pcie00]
<7>Allocate Port Service[0000:00:01.0:pcie03]
<7>PCI: Setting latency timer of device 0000:00:1c.0 to 64
<4>assign_interrupt_mode Found MSI capability
<7>Allocate Port Service[0000:00:1c.0:pcie00]
<7>Allocate Port Service[0000:00:1c.0:pcie03]
<7>PCI: Setting latency timer of device 0000:00:1c.4 to 64
<4>assign_interrupt_mode Found MSI capability
<7>Allocate Port Service[0000:00:1c.4:pcie00]
<7>Allocate Port Service[0000:00:1c.4:pcie03]
<7>PCI: Setting latency timer of device 0000:00:1c.5 to 64
<4>assign_interrupt_mode Found MSI capability
<7>Allocate Port Service[0000:00:1c.5:pcie00]
<7>Allocate Port Service[0000:00:1c.5:pcie03]
<6>vesafb: framebuffer at 0xfd000000, mapped to 0xffffc20010100000, using 1875k, total 16384k
<6>vesafb: mode is 800x600x16, linelength=1600, pages=7
<6>vesafb: scrolling: redraw
<6>vesafb: Truecolor: size=0:5:6:5, shift=0:11:5:0
<4>Console: switching to colour frame buffer device 100x37
<6>fb0: VESA VGA frame buffer device
<6>Real Time Clock Driver v1.12ac
<7>hpet_resources: 0xfed00000 is busy
<6>Non-volatile memory driver v1.2
<6>Linux agpgart interface v0.101 (c) Dave Jones
<6>Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
<6>serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
<4>RAMDISK driver initialized: 16 RAM disks of 128000K size 1024 blocksize
<7>libata version 2.00 loaded.
<7>ata_piix 0000:00:1f.1: version 2.00ac7
<4>ACPI: Unable to derive IRQ for device 0000:00:1f.1
<4>ACPI: PCI Interrupt 0000:00:1f.1[A]: no GSI
<7>PCI: Setting latency timer of device 0000:00:1f.1 to 64
<6>ata1: PATA max UDMA/133 cmd 0x1F0 ctl 0x3F6 bmdma 0xFC00 irq 14
<6>ata2: PATA max UDMA/133 cmd 0x170 ctl 0x376 bmdma 0xFC08 irq 15
<6>scsi0 : ata_piix
<6>ata1.00: ATAPI, max UDMA/33
<6>ata1.00: configured for UDMA/33
<6>scsi1 : ata_piix
<6>ata2: port disabled. ignoring.
<4>ATA: abnormal status 0xFF on port 0x177
<5>  Vendor: TSSTcorp  Model: CDRW/DVD TSL462C  Rev: DE05
<5>  Type:   CD-ROM                             ANSI SCSI revision: 05
<6>ata_piix 0000:00:1f.2: MAP [ P0 P2 P1 P3 ]
<6>GSI 20 sharing vector 0x32 and IRQ 20
<6>ACPI: PCI Interrupt 0000:00:1f.2[C] -> GSI 20 (level, low) -> IRQ 50
<7>PCI: Setting latency timer of device 0000:00:1f.2 to 64
<6>ata3: SATA max UDMA/133 cmd 0xAC98 ctl 0xAC92 bmdma 0xAC60 irq 50
<6>ata4: SATA max UDMA/133 cmd 0xAC80 ctl 0xAC7A bmdma 0xAC68 irq 50
<6>scsi2 : ata_piix
<6>ata3.00: ATA-7, max UDMA/133, 156250000 sectors: LBA48 NCQ (depth 0/32)
<6>ata3.00: ata3: dev 0 multi count 8
<6>ata3.00: configured for UDMA/133
<6>scsi3 : ata_piix
<6>ata4.00: ATA-7, max UDMA/133, 156250000 sectors: LBA48 NCQ (depth 0/32)
<6>ata4.00: ata4: dev 0 multi count 8
<6>ata4.00: configured for UDMA/133
<5>  Vendor: ATA       Model: ST3808110AS       Rev: 3.AD
<5>  Type:   Direct-Access                      ANSI SCSI revision: 05
<5>  Vendor: ATA       Model: ST3808110AS       Rev: 3.AD
<5>  Type:   Direct-Access                      ANSI SCSI revision: 05
<7>sata_sil24 0000:03:02.0: version 0.4
<6>GSI 21 sharing vector 0x3A and IRQ 21
<6>ACPI: PCI Interrupt 0000:03:02.0[A] -> GSI 35 (level, low) -> IRQ 58
<6>sata_sil24 0000:03:02.0: Applying completion IRQ loss on PCI-X errata fix
<6>ata5: SATA max UDMA/100 cmd 0xFFFFC20000020000 ctl 0x0 bmdma 0x0 irq 58
<6>ata6: SATA max UDMA/100 cmd 0xFFFFC20000022000 ctl 0x0 bmdma 0x0 irq 58
<6>ata7: SATA max UDMA/100 cmd 0xFFFFC20000024000 ctl 0x0 bmdma 0x0 irq 58
<6>ata8: SATA max UDMA/100 cmd 0xFFFFC20000026000 ctl 0x0 bmdma 0x0 irq 58
<6>scsi4 : sata_sil24
<6>ata5: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
<6>ata5.15: Port Multiplier 1.1, 0x1095:0x3726 r23, 5 ports, feat 0x9/0x9
<6>ata5.00: hard resetting port
<6>ata5.00: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
<6>ata5.01: hard resetting port
<6>ata5.01: SATA link down (SStatus 0 SControl 300)
<6>ata5.02: hard resetting port
<6>ata5.02: SATA link down (SStatus 0 SControl 300)
<6>ata5.03: hard resetting port
<6>ata5.03: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
<6>ata5.04: hard resetting port
<6>ata5.04: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
<6>ata5.00: ATA-7, max UDMA/133, 976773168 sectors: LBA48 NCQ (depth 31/32)
<7>Losing some ticks... checking if CPU frequency changed.
<6>ata5.00: ata5: dev 0 multi count 16
<6>ata5.00: configured for UDMA/100
<6>ata5.03: ATA-7, max UDMA/133, 976773168 sectors: LBA48 NCQ (depth 31/32)
<6>ata5.03: configured for UDMA/100
<6>ata5.04: ATA-7, max UDMA/133, 976773168 sectors: LBA48 NCQ (depth 31/32)
<6>ata5.04: configured for UDMA/100
<6>ata5: EH complete
<6>scsi5 : sata_sil24
<6>ata6: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
<6>ata6.15: Port Multiplier 1.1, 0x1095:0x3726 r23, 5 ports, feat 0x9/0x9
<6>ata6.00: hard resetting port
<6>ata6.00: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
<6>ata6.01: hard resetting port
<6>ata6.01: SATA link down (SStatus 0 SControl 300)
<6>ata6.02: hard resetting port
<6>ata6.02: SATA link down (SStatus 0 SControl 300)
<6>ata6.03: hard resetting port
<6>ata6.03: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
<6>ata6.04: hard resetting port
<6>ata6.04: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
<6>ata6.00: ATA-7, max UDMA/133, 976773168 sectors: LBA48 NCQ (depth 31/32)
<6>ata6.00: ata6: dev 0 multi count 16
<6>ata6.00: configured for UDMA/100
<6>ata6.03: ATA-7, max UDMA/133, 976773168 sectors: LBA48 NCQ (depth 31/32)
<6>ata6.03: configured for UDMA/100
<6>ata6.04: ATA-7, max UDMA/133, 976773168 sectors: LBA48 NCQ (depth 31/32)
<6>ata6.04: configured for UDMA/100
<6>ata6: EH complete
<6>scsi6 : sata_sil24
<6>ata7: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
<6>ata7.00: ATA-7, max UDMA/133, 976773168 sectors: LBA48 NCQ (depth 31/32)
<6>ata7.00: ata7: dev 0 multi count 16
<6>ata7.00: configured for UDMA/100
<6>scsi7 : sata_sil24
<6>ata8: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
<6>ata8.00: ATA-7, max UDMA/133, 976773168 sectors: LBA48 NCQ (depth 31/32)
<6>ata8.00: ata8: dev 0 multi count 16
<6>ata8.00: configured for UDMA/100
<5>  Vendor: ATA       Model: ST3500630AS       Rev: 3.AA
<5>  Type:   Direct-Access                      ANSI SCSI revision: 05
<5>  Vendor: ATA       Model: ST3500630AS       Rev: 3.AA
<5>  Type:   Direct-Access                      ANSI SCSI revision: 05
<5>  Vendor: ATA       Model: ST3500630AS       Rev: 3.AA
<5>  Type:   Direct-Access                      ANSI SCSI revision: 05
<5>  Vendor: ATA       Model: ST3500630AS       Rev: 3.AA
<5>  Type:   Direct-Access                      ANSI SCSI revision: 05
<5>  Vendor: ATA       Model: ST3500630AS       Rev: 3.AA
<5>  Type:   Direct-Access                      ANSI SCSI revision: 05
<5>  Vendor: ATA       Model: ST3500630AS       Rev: 3.AA
<5>  Type:   Direct-Access                      ANSI SCSI revision: 05
<5>  Vendor: ATA       Model: ST3500630AS       Rev: 3.AA
<5>  Type:   Direct-Access                      ANSI SCSI revision: 05
<5>  Vendor: ATA       Model: ST3500630AS       Rev: 3.AA
<5>  Type:   Direct-Access                      ANSI SCSI revision: 05
<6>serio: i8042 AUX port at 0x60,0x64 irq 12
<6>serio: i8042 KBD port at 0x60,0x64 irq 1
<6>mice: PS/2 mouse device common for all mice
<6>input: PC Speaker as /class/input/input0
<6>input: AT Translated Set 2 keyboard as /class/input/input1
<6>md: md driver 0.90.3 MAX_MD_DEVS=256, MD_SB_DISKS=27
<6>md: bitmap version 4.39
<6>NET: Registered protocol family 1
<6>ACPI: (supports S0 S4 S5)
<6>Freeing unused kernel memory: 192k freed
<4>logips2pp: Detected unknown logitech mouse model 11
<4>sr0: scsi3-mmc drive: 10x/24x writer cd/rw xa/form2 cdda tray
<6>Uniform CD-ROM driver Revision: 3.20
<7>sr 0:0:0:0: Attached scsi CD-ROM sr0
<5>SCSI device sda: 156250000 512-byte hdwr sectors (80000 MB)
<5>sda: Write Protect is off
<7>sda: Mode Sense: 00 3a 00 00
<5>SCSI device sda: drive cache: write back
<5>sr 0:0:0:0: Attached scsi generic sg0 type 5
<5>SCSI device sda: 156250000 512-byte hdwr sectors (80000 MB)
<5>sda: Write Protect is off
<7>sda: Mode Sense: 00 3a 00 00
<5>SCSI device sda: drive cache: write back
<6> sda: sda1 sda2 sda3
<5>sd 2:0:0:0: Attached scsi generic sg1 type 0
<5>sd 2:0:0:0: Attached scsi disk sda
<5>SCSI device sdb: 156250000 512-byte hdwr sectors (80000 MB)
<5>sdb: Write Protect is off
<7>sdb: Mode Sense: 00 3a 00 00
<5>SCSI device sdb: drive cache: write back
<5>SCSI device sdb: 156250000 512-byte hdwr sectors (80000 MB)
<5>sdb: Write Protect is off
<7>sdb: Mode Sense: 00 3a 00 00
<5>SCSI device sdb: drive cache: write back
<6> sdb: sdb1
<5>sd 3:0:0:0: Attached scsi generic sg2 type 0
<5>sd 3:0:0:0: Attached scsi disk sdb
<5>SCSI device sdc: 976773168 512-byte hdwr sectors (500108 MB)
<5>sdc: Write Protect is off
<7>sdc: Mode Sense: 00 3a 00 00
<5>SCSI device sdc: drive cache: write back
<5>SCSI device sdc: 976773168 512-byte hdwr sectors (500108 MB)
<5>sdc: Write Protect is off
<7>sdc: Mode Sense: 00 3a 00 00
<5>SCSI device sdc: drive cache: write back
<6> sdc: sdc1
<5>sd 4:0:0:0: Attached scsi generic sg3 type 0
<5>sd 4:0:0:0: Attached scsi disk sdc
<5>SCSI device sdd: 976773168 512-byte hdwr sectors (500108 MB)
<5>sdd: Write Protect is off
<7>sdd: Mode Sense: 00 3a 00 00
<5>SCSI device sdd: drive cache: write back
<5>SCSI device sdd: 976773168 512-byte hdwr sectors (500108 MB)
<5>sdd: Write Protect is off
<7>sdd: Mode Sense: 00 3a 00 00
<5>SCSI device sdd: drive cache: write back
<6> sdd: sdd1
<5>sd 4:0:3:0: Attached scsi generic sg4 type 0
<5>sd 4:0:3:0: Attached scsi disk sdd
<5>SCSI device sde: 976773168 512-byte hdwr sectors (500108 MB)
<5>sde: Write Protect is off
<7>sde: Mode Sense: 00 3a 00 00
<5>SCSI device sde: drive cache: write back
<5>SCSI device sde: 976773168 512-byte hdwr sectors (500108 MB)
<5>sde: Write Protect is off
<7>sde: Mode Sense: 00 3a 00 00
<5>SCSI device sde: drive cache: write back
<6> sde: sde1
<5>sd 4:0:4:0: Attached scsi generic sg5 type 0
<5>sd 4:0:4:0: Attached scsi disk sde
<5>SCSI device sdf: 976773168 512-byte hdwr sectors (500108 MB)
<5>sdf: Write Protect is off
<7>sdf: Mode Sense: 00 3a 00 00
<5>SCSI device sdf: drive cache: write back
<5>SCSI device sdf: 976773168 512-byte hdwr sectors (500108 MB)
<5>sdf: Write Protect is off
<7>sdf: Mode Sense: 00 3a 00 00
<5>SCSI device sdf: drive cache: write back
<6> sdf: sdf1
<5>sd 5:0:0:0: Attached scsi generic sg6 type 0
<5>sd 5:0:0:0: Attached scsi disk sdf
<5>SCSI device sdg: 976773168 512-byte hdwr sectors (500108 MB)
<5>sdg: Write Protect is off
<7>sdg: Mode Sense: 00 3a 00 00
<5>SCSI device sdg: drive cache: write back
<5>SCSI device sdg: 976773168 512-byte hdwr sectors (500108 MB)
<5>sdg: Write Protect is off
<7>sdg: Mode Sense: 00 3a 00 00
<5>SCSI device sdg: drive cache: write back
<6> sdg: sdg1
<5>sd 5:0:3:0: Attached scsi generic sg7 type 0
<5>sd 5:0:3:0: Attached scsi disk sdg
<5>sd 5:0:4:0: Attached scsi generic sg8 type 0
<5>SCSI device sdh: 976773168 512-byte hdwr sectors (500108 MB)
<5>sdh: Write Protect is off
<7>sdh: Mode Sense: 00 3a 00 00
<5>SCSI device sdh: drive cache: write back
<5>SCSI device sdh: 976773168 512-byte hdwr sectors (500108 MB)
<5>sdh: Write Protect is off
<7>sdh: Mode Sense: 00 3a 00 00
<5>SCSI device sdh: drive cache: write back
<6> sdh:<5>scsi 6:0:0:0: Attached scsi generic sg9 type 0
<4> sdh1
<5>scsi 7:0:0:0: Attached scsi generic sg10 type 0
<5>sd 5:0:4:0: Attached scsi disk sdh
<5>SCSI device sdi: 976773168 512-byte hdwr sectors (500108 MB)
<5>sdi: Write Protect is off
<7>sdi: Mode Sense: 00 3a 00 00
<5>SCSI device sdi: drive cache: write back
<5>SCSI device sdi: 976773168 512-byte hdwr sectors (500108 MB)
<5>sdi: Write Protect is off
<7>sdi: Mode Sense: 00 3a 00 00
<5>SCSI device sdi: drive cache: write back
<6> sdi: sdi1
<5>sd 6:0:0:0: Attached scsi disk sdi
<6>input: ImPS/2 Logitech Wheel Mouse as /class/input/input2
<5>SCSI device sdj: 976773168 512-byte hdwr sectors (500108 MB)
<5>sdj: Write Protect is off
<7>sdj: Mode Sense: 00 3a 00 00
<5>SCSI device sdj: drive cache: write back
<5>SCSI device sdj: 976773168 512-byte hdwr sectors (500108 MB)
<5>sdj: Write Protect is off
<7>sdj: Mode Sense: 00 3a 00 00
<5>SCSI device sdj: drive cache: write back
<6> sdj: sdj1
<5>sd 7:0:0:0: Attached scsi disk sdj
<6>Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
<6>ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
<6>BIOS EDD facility v0.16 2004-Jun-25, 6 devices found
<6>SGI XFS with ACLs, security attributes, realtime, large block/inode numbers,
no debug enabled
<6>SGI XFS Quota Management subsystem
<4>Attempting manual resume
<5>XFS mounting filesystem sda3
<7>Ending clean XFS mount for filesystem: sda3
<6>Floppy drive(s): fd0 is 1.44M
<4>ACPI: Unable to derive IRQ for device 0000:00:1f.3
<4>ACPI: PCI Interrupt 0000:00:1f.3[B]: no GSI
<6>usbcore: registered new driver usbfs
<6>usbcore: registered new driver hub
<6>pci_hotplug: PCI Hot Plug PCI Core version: 0.5
<6>tg3.c:v3.65 (August 07, 2006)
<6>ACPI: PCI Interrupt 0000:04:00.0[A] -> GSI 16 (level, low) -> IRQ 169
<7>PCI: Setting latency timer of device 0000:04:00.0 to 64
<6>eth0: Tigon3 [partno(BCM95721) rev 4101 PHY(5750)] (PCI Express) 10/100/1000BaseT Ethernet 00:15:c5:e1:08:de
<6>eth0: RXcsums[1] LinkChgREG[1] MIirq[1] ASF[1] Split[0] WireSpeed[1] TSOcap[1]
<6>eth0: dma_rwctrl[76180000] dma_mask[64-bit]
<6>GSI 22 sharing vector 0x42 and IRQ 22
<6>ACPI: PCI Interrupt 0000:05:00.0[A] -> GSI 17 (level, low) -> IRQ 66
<7>PCI: Setting latency timer of device 0000:05:00.0 to 64
<6>eth1: Tigon3 [partno(BCM95721) rev 4101 PHY(5750)] (PCI Express) 10/100/1000BaseT Ethernet 00:15:c5:e1:08:df
<6>eth1: RXcsums[1] LinkChgREG[1] MIirq[1] ASF[1] Split[0] WireSpeed[1] TSOcap[1]
<6>eth1: dma_rwctrl[76180000] dma_mask[64-bit]
<6>USB Universal Host Controller Interface driver v3.0
<6>ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 20 (level, low) -> IRQ 50
<7>PCI: Setting latency timer of device 0000:00:1d.0 to 64
<6>uhci_hcd 0000:00:1d.0: UHCI Host Controller
<6>uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
<6>uhci_hcd 0000:00:1d.0: irq 50, io base 0x0000ace0
<6>usb usb1: configuration #1 chosen from 1 choice
<6>hub 1-0:1.0: USB hub found
<6>hub 1-0:1.0: 2 ports detected
<6>ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 21 (level, low) -> IRQ 177
<7>PCI: Setting latency timer of device 0000:00:1d.1 to 64
<6>uhci_hcd 0000:00:1d.1: UHCI Host Controller
<6>uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 2
<6>uhci_hcd 0000:00:1d.1: irq 177, io base 0x0000acc0
<6>usb usb2: configuration #1 chosen from 1 choice
<6>hub 2-0:1.0: USB hub found
<6>hub 2-0:1.0: 2 ports detected
<6>ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 22 (level, low) -> IRQ 185
<7>PCI: Setting latency timer of device 0000:00:1d.2 to 64
<6>uhci_hcd 0000:00:1d.2: UHCI Host Controller
<6>uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 3
<6>uhci_hcd 0000:00:1d.2: irq 185, io base 0x0000aca0
<6>usb usb3: configuration #1 chosen from 1 choice
<6>hub 3-0:1.0: USB hub found
<6>hub 3-0:1.0: 2 ports detected
<6>ACPI: PCI Interrupt 0000:00:1d.7[A] -> GSI 20 (level, low) -> IRQ 50
<7>PCI: Setting latency timer of device 0000:00:1d.7 to 64
<6>ehci_hcd 0000:00:1d.7: EHCI Host Controller
<6>ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 4
<6>ehci_hcd 0000:00:1d.7: debug port 1
<7>PCI: cache line size of 128 is not supported by device 0000:00:1d.7
<6>ehci_hcd 0000:00:1d.7: irq 50, io mem 0xfeb00400
<6>ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
<6>usb usb4: configuration #1 chosen from 1 choice
<6>hub 4-0:1.0: USB hub found
<6>hub 4-0:1.0: 6 ports detected
<6>shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
<4>floppy0: no floppy controllers found
<6>Adding 1052248k swap on /dev/sda2.  Priority:-1 extents:1 across:1052248k
<6>device-mapper: ioctl: 4.7.0-ioctl (2006-06-24) initialised: dm-devel@redhat.com
<6>md: md0 stopped.
<6>md: bind<sdd1>
<6>md: bind<sde1>
<6>md: bind<sdf1>
<6>md: bind<sdg1>
<6>md: bind<sdh1>
<6>md: bind<sdi1>
<6>md: bind<sdj1>
<6>md: bind<sdc1>
<3>md: md0: raid array is not clean -- starting background reconstruction
<6>raid5: automatically using best checksumming function: generic_sse
<4>   generic_sse:  4879.000 MB/sec
<4>raid5: using function: generic_sse (4879.000 MB/sec)
<4>raid6: int64x1   1547 MB/s
<4>raid6: int64x2   1864 MB/s
<4>raid6: int64x4   2297 MB/s
<4>raid6: int64x8   1676 MB/s
<4>raid6: sse2x1    2041 MB/s
<4>raid6: sse2x2    2134 MB/s
<4>raid6: sse2x4    3070 MB/s
<4>raid6: using algorithm sse2x4 (3070 MB/s)
<6>md: raid6 personality registered for level 6
<6>md: raid5 personality registered for level 5
<6>md: raid4 personality registered for level 4
<6>raid5: device sdc1 operational as raid disk 0
<6>raid5: device sdj1 operational as raid disk 7
<6>raid5: device sdi1 operational as raid disk 6
<6>raid5: device sdh1 operational as raid disk 5
<6>raid5: device sdg1 operational as raid disk 4
<6>raid5: device sdf1 operational as raid disk 3
<6>raid5: device sde1 operational as raid disk 2
<6>raid5: device sdd1 operational as raid disk 1
<6>raid5: allocated 8462kB for md0
<4>raid5: raid level 6 set md0 active with 8 out of 8 devices, algorithm 2
<4>RAID5 conf printout:
<4> --- rd:8 wd:8 fd:0
<4> disk 0, o:1, dev:sdc1
<4> disk 1, o:1, dev:sdd1
<4> disk 2, o:1, dev:sde1
<4> disk 3, o:1, dev:sdf1
<4> disk 4, o:1, dev:sdg1
<4> disk 5, o:1, dev:sdh1
<4> disk 6, o:1, dev:sdi1
<4> disk 7, o:1, dev:sdj1
<6>md: syncing RAID array md0
<6>md: minimum _guaranteed_ reconstruction speed: 1000 KB/sec/disc.
<6>md: using maximum available idle IO bandwidth (but not more than 200000 KB/sec) for reconstruction.
<6>md: using 128k window, over a total of 488379904 blocks.
<6>md: resuming recovery of md0 from checkpoint.
<6>loop: loaded (max 8 devices)
<6>kjournald starting.  Commit interval 5 seconds
<6>EXT3 FS on sda1, internal journal
<6>EXT3-fs: mounted filesystem with ordered data mode.
<5>XFS mounting filesystem sdb1
<7>Ending clean XFS mount for filesystem: sdb1
<5>Filesystem "md0": Disabling barriers, not supported by the underlying device
<5>XFS mounting filesystem md0
<7>Ending clean XFS mount for filesystem: md0
Kernel logging (ksyslog) stopped.
Kernel log daemon terminating.

Boot logging started on /dev/tty1(/dev/console) at Fri Feb 23 01:47:52 2007

Trying manual resume from /dev/sda2
Creating device nodes with udev
Loading ide-core
Loading ide-disk
Loading processor
Loading thermal
Loading piix
Loading fan
Loading edd
Loading xfs
Invoking userspace resume from /dev/sda2
resume: Could not stat configuration file
resume: libgcrypt version: 1.2.3
resume: Could not read the image
Invoking in-kernel resume from /dev/sda2
Waiting for device /dev/sda3 to appear:  ok
showconsole: Warning: the ioctl TIOCGDEV is not known by the kernel
fsck 1.39 (29-May-2006)
[/bin/fsck.xfs (1) -- /] fsck.xfs -a /dev/sda3
/bin/fsck.xfs: XFS file system.
fsck succeeded. Mounting root device read-write.
Mounting root /dev/sda3

Boot logging started on /dev/tty1(/dev/console) at Thu Feb 22 18:48:19 2007

Master Resource Control: previous runlevel: N, switching to runlevel: 3
<notice>startproc: execve (/sbin/resmgrd) [ /sbin/resmgrd ], [ CONSOLE=/dev/console ROOTFS_FSTYPE=xfs SHELL=/bin/sh TERM=linux ROOTFS_FSCK=0 LC_ALL=POSIX INIT_VERSION=sysvinit-2.86 REDIRECT=/dev/tty1 COLUMNS=100 PATH=/bin:/sbin:/usr/bin:/usr/sbin vga=0x314 RUNLEVEL=3 PWD=/ SPLASHCFG= PREVLEVEL=N LINES=37 HOME=/ SHLVL=2 splash=silent SPLASH=no ROOTFS_BLKDEV=/dev/sda3 _=/sbin/startproc DAEMON=/sbin/resmgrd ]
<notice>startproc: execve (/usr/bin/dbus-daemon) [ /usr/bin/dbus-daemon --system ], [ CONSOLE=/dev/console ROOTFS_FSTYPE=xfs SHELL=/bin/sh TERM=linux ROOTFS_FSCK=0 LC_ALL=POSIX INIT_VERSION=sysvinit-2.86 REDIRECT=/dev/tty1 COLUMNS=100 PATH=/bin:/sbin:/usr/bin:/usr/sbin vga=0x314 RUNLEVEL=3 PWD=/ SPLASHCFG= PREVLEVEL=N
LINES=37 HOME=/ SHLVL=2 splash=silent SPLASH=no ROOTFS_BLKDEV=/dev/sda3 _=/sbin/startproc DAEMON=/usr/bin/dbus-daemon ]
Starting resource managerdone
Starting D-Bus daemondone
Starting irqbalance unused
Initializing random number generatordone
acpid: loading ACPI modules ( ac battery button ) done
acpid: will not skip unsupported modules
acpid: loading ACPI laptop modules ( ) done
Starting acpid <notice>startproc: execve (/sbin/acpid) [ /sbin/acpid ], [ CONSOLE=/dev/console ROOTFS_FSTYPE=xfs SHELL=/bin/sh TERM=linux ROOTFS_FSCK=0 LC_ALL=POSIX INIT_VERSION=sysvinit-2.86 REDIRECT=/dev/tty1 COLUMNS=100 PATH=/bin:/sbin:/usr/bin:/usr/sbin vga=0x314 RUNLEVEL=3 PWD=/ SPLASHCFG= PREVLEVEL=N LINES=37 HOME=/ SHLVL=2 splash=silent SPLASH=no ROOTFS_BLKDEV=/dev/sda3 _=/sbin/startproc DAEMON=/sbin/acpid ]
[acpid]: starting up


done
[acpid]: 0 rules loaded
