From: Paul Klapperich <paul.klapperich@packetdigital.com>
Subject: Re: ata device numbers
Date: Fri, 12 Nov 2010 18:38:04 -0600
Message-ID: <4CDDDDEC.9090707@packetdigital.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060207080802020701050407"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.packetdigital.com ([64.122.85.36]:44019 "EHLO
	waterson.packetdigital.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753586Ab0KMAiE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 12 Nov 2010 19:38:04 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------060207080802020701050407
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Harri Olin wrote:

/
> Alan Cox wrote:
> /
>> /Harri Olin wrote:
>>> ata13: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
>>> ata13.00: ATA-7: WDC WD7500AYYS-01RCA0, 30.04G30, max UDMA/133
>>> ata13.00: 1465149168 sectors, multi 0: LBA48 NCQ (depth 31/32)
>>> ata13.00: configured for UDMA/133
>>> scsi 12:0:0:0: Direct-Access     ATA      WDC WD7500AYYS-0 30.0 PQ: 0
>>> ANSI: 5
>>> sd 12:0:0:0: [sdm] 1465149168 512-byte logical blocks: (750 GB/698 GiB)
>>> sd 12:0:0:0: Attached scsi generic sg12 type 0
>>> sd 12:0:0:0: [sdm] Write Protect is off
>>> sd 12:0:0:0: [sdm] Mode Sense: 00 3a 00 00
>>> sd 12:0:0:0: [sdm] Write cache: enabled, read cache: enabled, doesn't
>>> support DPO or FUA
>>>    sdm: sdm1
>>> sd 12:0:0:0: [sdm] Attached SCSI disk/
>> So /dev/sdm
> /
> Sorry, I mistyped. Error was on ata23, not on ata13, as seen at the end
> of dmesg. And I'm more interested on some kind of reliable way to make 
> the translation - is there anything on /sys where ata device number 
> could be checked?
> I suppose ata23 could still be sd22/


I'm struggling with this same issue, and unfortunately, dmesg output 
(attached) isn't ordered nicely. I'm interested in knowing which ATA# a 
given device lines up with. For example, /dev/sdd. By hotplugging the 
device, I know it to be ata7. From dmesg I know it's scsi address is 
3:0:0:0: and udevadm tells me it is host 3.

Without hotplugging the drive, the only way I can map ataX to a given 
device is by matching the manufacturer and model number. This works in 
my setup, but I really need a solution that would allow me to have 
multiple of the same drive model attached, as Harri has. Harri's dmesg, 
at least with ata13, nicely shows consistency from one line to the next. 
Mine does not, as in:

[    2.021205] ata5.00: ATA-8: Hitachi HTS542516K9SA00, BBCOC31P, max 
UDMA/133
[    2.021210] ata5.00: 312581808 sectors, multi 8: LBA48 NCQ (depth 
31/32), AA
[    2.022565] ata5.00: configured for UDMA/133
[    2.024065] ata9: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[    2.024156] ata7: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[    2.024226] ata6: SATA link down (SStatus 0 SControl 300)
[    2.032423] ata7.00: ATA-8: FUJITSU MHZ2160BH G2, 00000009, max UDMA/100
[    2.032427] ata7.00: 312581808 sectors, multi 16: LBA48 NCQ (depth 0/32)
[    2.032655] ata9.00: ATA-7: ST9160823AS, 3.AAB, max UDMA/133
[    2.032659] ata9.00: 312581808 sectors, multi 16: LBA48 NCQ (depth 0/32)
[    2.040367] ata7.00: configured for UDMA/100
[    2.048395] ata9.00: configured for UDMA/100
   ...snip....
[   57.081774] ata4.00: ATA-8: SAMSUNG HM251JJ, 2AA00_00, max UDMA7
[   57.081780] ata4.00: 488397168 sectors, multi 8: LBA48 NCQ (depth 
31/32), AA
[   57.087649] ata4.00: configured for UDMA/133
[   57.100168] scsi 4:0:0:0: Direct-Access     ATA      SAMSUNG HM251JJ  
2AA0 PQ: 0 ANSI: 5
[   57.100456] sd 4:0:0:0: Attached scsi generic sg2 type 0
[   57.100727] scsi 5:0:0:0: Direct-Access     ATA      Hitachi HTS54251 
BBCO PQ: 0 ANSI: 5
[   57.100983] sd 5:0:0:0: Attached scsi generic sg3 type 0
[   57.101723] scsi 3:0:0:0: Direct-Access     ATA      FUJITSU MHZ2160B 
0000 PQ: 0 ANSI: 5
[   57.101914] sd 3:0:0:0: Attached scsi generic sg4 type 0
[   57.102435] sd 3:0:0:0: [sdd] 312581808 512-byte logical blocks: (160 
GB/149 GiB)
[   57.102517] sd 3:0:0:0: [sdd] Write Protect is off
[   57.102521] sd 3:0:0:0: [sdd] Mode Sense: 00 3a 00 00
[   57.102598] sd 3:0:0:0: [sdd] Write cache: enabled, read cache: 
enabled, doesn't support DPO or FUA

Host4 (scsi 4:0:0:0:) is, indeed, ata4. I've verified this by 
hotplugging. Host3 (scsi 3:0:0:0:) however has shown up long after any 
ata7 messages. How am I to correlate them?

Everything I've seen in /sys/ seems related to the host# or the scsi 
address. The only place I see ata#s are in dmesg, and the only error 
message I've seen that contains both ata# and scsi address is a detach 
message ([ 3358.584098] ata7.00: detaching (SCSI 3:0:0:0)"

How useful is knowing "ata7: exception Emask 0x10 SAct 0x0 SErr 0x50000 
action 0xe frozen" if I don't know what ata7 is? And the reliable method 
I've thusly found (connect and disconnect sata cables on drives while 
monitoring dmesg) doesn't seem like the safest way of doing things.

--
Paul Klapperich

--------------060207080802020701050407
Content-Type: text/plain;
 name="dmesg-output"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="dmesg-output"

[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Linux version 2.6.32-25-generic (buildd@rothera) (gcc version 4.4.3 (Ubuntu 4.4.3-4ubuntu5) ) #44-Ubuntu SMP Fri Sep 17 20:26:08 UTC 2010 (Ubuntu 2.6.32-25.44-generic 2.6.32.21+drm33.7)
[    0.000000] KERNEL supported cpus:
[    0.000000]   Intel GenuineIntel
[    0.000000]   AMD AuthenticAMD
[    0.000000]   NSC Geode by NSC
[    0.000000]   Cyrix CyrixInstead
[    0.000000]   Centaur CentaurHauls
[    0.000000]   Transmeta GenuineTMx86
[    0.000000]   Transmeta TransmetaCPU
[    0.000000]   UMC UMC UMC UMC
[    0.000000] BIOS-provided physical RAM map:
[    0.000000]  BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
[    0.000000]  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
[    0.000000]  BIOS-e820: 0000000000100000 - 000000003fe8ac00 (usable)
[    0.000000]  BIOS-e820: 000000003fe8ac00 - 000000003fe8cc00 (ACPI NVS)
[    0.000000]  BIOS-e820: 000000003fe8cc00 - 000000003fe8ec00 (ACPI data)
[    0.000000]  BIOS-e820: 000000003fe8ec00 - 0000000040000000 (reserved)
[    0.000000]  BIOS-e820: 00000000f0000000 - 00000000f4000000 (reserved)
[    0.000000]  BIOS-e820: 00000000fec00000 - 00000000fed00400 (reserved)
[    0.000000]  BIOS-e820: 00000000fed20000 - 00000000feda0000 (reserved)
[    0.000000]  BIOS-e820: 00000000fee00000 - 00000000fef00000 (reserved)
[    0.000000]  BIOS-e820: 00000000ffb00000 - 0000000100000000 (reserved)
[    0.000000] DMI 2.3 present.
[    0.000000] last_pfn = 0x3fe8a max_arch_pfn = 0x100000
[    0.000000] MTRR default type: uncachable
[    0.000000] MTRR fixed ranges enabled:
[    0.000000]   00000-9FFFF write-back
[    0.000000]   A0000-BFFFF uncachable
[    0.000000]   C0000-D7FFF write-protect
[    0.000000]   D8000-EFFFF uncachable
[    0.000000]   F0000-FFFFF write-protect
[    0.000000] MTRR variable ranges enabled:
[    0.000000]   0 base 000000000 mask FC0000000 write-back
[    0.000000]   1 base 03FF00000 mask FFFF00000 uncachable
[    0.000000]   2 disabled
[    0.000000]   3 disabled
[    0.000000]   4 disabled
[    0.000000]   5 disabled
[    0.000000]   6 disabled
[    0.000000]   7 disabled
[    0.000000] x86 PAT enabled: cpu 0, old 0x7040600070406, new 0x7010600070106
[    0.000000] e820 update range: 0000000000002000 - 0000000000006000 (usable) ==> (reserved)
[    0.000000] Scanning 1 areas for low memory corruption
[    0.000000] modified physical RAM map:
[    0.000000]  modified: 0000000000000000 - 0000000000002000 (usable)
[    0.000000]  modified: 0000000000002000 - 0000000000006000 (reserved)
[    0.000000]  modified: 0000000000006000 - 00000000000a0000 (usable)
[    0.000000]  modified: 00000000000f0000 - 0000000000100000 (reserved)
[    0.000000]  modified: 0000000000100000 - 000000003fe8ac00 (usable)
[    0.000000]  modified: 000000003fe8ac00 - 000000003fe8cc00 (ACPI NVS)
[    0.000000]  modified: 000000003fe8cc00 - 000000003fe8ec00 (ACPI data)
[    0.000000]  modified: 000000003fe8ec00 - 0000000040000000 (reserved)
[    0.000000]  modified: 00000000f0000000 - 00000000f4000000 (reserved)
[    0.000000]  modified: 00000000fec00000 - 00000000fed00400 (reserved)
[    0.000000]  modified: 00000000fed20000 - 00000000feda0000 (reserved)
[    0.000000]  modified: 00000000fee00000 - 00000000fef00000 (reserved)
[    0.000000]  modified: 00000000ffb00000 - 0000000100000000 (reserved)
[    0.000000] initial memory mapped : 0 - 00c00000
[    0.000000] init_memory_mapping: 0000000000000000-00000000377fe000
[    0.000000] Using x86 segment limits to approximate NX protection
[    0.000000]  0000000000 - 0000400000 page 4k
[    0.000000]  0000400000 - 0037400000 page 2M
[    0.000000]  0037400000 - 00377fe000 page 4k
[    0.000000] kernel direct mapping tables up to 377fe000 @ 7000-c000
[    0.000000] RAMDISK: 2f790000 - 2ff2769e
[    0.000000] ACPI: RSDP 000feb00 00024 (v02 DELL  )
[    0.000000] ACPI: XSDT 000fd260 00074 (v01 DELL    WS 380  00000007 ASL  00000061)
[    0.000000] ACPI: FACP 000fd358 000F4 (v03 DELL    WS 380  00000007 ASL  00000061)
[    0.000000] ACPI: DSDT fffca5f2 030D7 (v01   DELL    dt_ex 00001000 INTL 20050309)
[    0.000000] ACPI: FACS 3fe8ac00 00040
[    0.000000] ACPI: SSDT fffcd7ea 000AC (v01   DELL    st_ex 00001000 INTL 20050309)
[    0.000000] ACPI: APIC 000fd44c 00072 (v01 DELL    WS 380  00000007 ASL  00000061)
[    0.000000] ACPI: BOOT 000fd4be 00028 (v01 DELL    WS 380  00000007 ASL  00000061)
[    0.000000] ACPI: ASF! 000fd4e6 00067 (v16 DELL    WS 380  00000007 ASL  00000061)
[    0.000000] ACPI: MCFG 000fd54d 0003E (v01 DELL    WS 380  00000007 ASL  00000061)
[    0.000000] ACPI: HPET 000fd58b 00038 (v01 DELL    WS 380  00000007 ASL  00000061)
[    0.000000] ACPI: SSDT 3fe8ac40 00175 (v01 DpgPmm  Cpu0Ist 00000011 INTL 20050309)
[    0.000000] ACPI: SSDT 3fe8b049 00175 (v01 DpgPmm  Cpu1Ist 00000011 INTL 20050309)
[    0.000000] ACPI: SSDT 3fe8b452 00140 (v01 DpgPmm    CpuPm 00000010 INTL 20050309)
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] 134MB HIGHMEM available.
[    0.000000] 887MB LOWMEM available.
[    0.000000]   mapped low ram: 0 - 377fe000
[    0.000000]   low ram: 0 - 377fe000
[    0.000000]   node 0 low ram: 00000000 - 377fe000
[    0.000000]   node 0 bootmap 00008000 - 0000ef00
[    0.000000] (9 early reservations) ==> bootmem [0000000000 - 00377fe000]
[    0.000000]   #0 [0000000000 - 0000001000]   BIOS data page ==> [0000000000 - 0000001000]
[    0.000000]   #1 [0000001000 - 0000002000]    EX TRAMPOLINE ==> [0000001000 - 0000002000]
[    0.000000]   #2 [0000006000 - 0000007000]       TRAMPOLINE ==> [0000006000 - 0000007000]
[    0.000000]   #3 [0000100000 - 00008dced8]    TEXT DATA BSS ==> [0000100000 - 00008dced8]
[    0.000000]   #4 [002f790000 - 002ff2769e]          RAMDISK ==> [002f790000 - 002ff2769e]
[    0.000000]   #5 [000009ec00 - 0000100000]    BIOS reserved ==> [000009ec00 - 0000100000]
[    0.000000]   #6 [00008dd000 - 00008e019c]              BRK ==> [00008dd000 - 00008e019c]
[    0.000000]   #7 [0000007000 - 0000008000]          PGTABLE ==> [0000007000 - 0000008000]
[    0.000000]   #8 [0000008000 - 000000f000]          BOOTMAP ==> [0000008000 - 000000f000]
[    0.000000] found SMP MP-table at [c00fe710] fe710
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA      0x00000000 -> 0x00001000
[    0.000000]   Normal   0x00001000 -> 0x000377fe
[    0.000000]   HighMem  0x000377fe -> 0x0003fe8a
[    0.000000] Movable zone start PFN for each node
[    0.000000] early_node_map[3] active PFN ranges
[    0.000000]     0: 0x00000000 -> 0x00000002
[    0.000000]     0: 0x00000006 -> 0x000000a0
[    0.000000]     0: 0x00000100 -> 0x0003fe8a
[    0.000000] On node 0 totalpages: 261670
[    0.000000] free_area_init_node: node 0, pgdat c079a760, node_mem_map c1001000
[    0.000000]   DMA zone: 32 pages used for memmap
[    0.000000]   DMA zone: 0 pages reserved
[    0.000000]   DMA zone: 3964 pages, LIFO batch:0
[    0.000000]   Normal zone: 1744 pages used for memmap
[    0.000000]   Normal zone: 221486 pages, LIFO batch:31
[    0.000000]   HighMem zone: 270 pages used for memmap
[    0.000000]   HighMem zone: 34174 pages, LIFO batch:7
[    0.000000] Using APIC driver default
[    0.000000] ACPI: PM-Timer IO Port: 0x808
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x03] lapic_id[0x05] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x04] lapic_id[0x07] disabled)
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xff] high level lint[0x1])
[    0.000000] ACPI: IOAPIC (id[0x08] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 8, version 32, address 0xfec00000, GSI 0-23
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ2 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.000000] SMP: Allowing 4 CPUs, 2 hotplug CPUs
[    0.000000] nr_irqs_gsi: 24
[    0.000000] PM: Registered nosave memory: 0000000000002000 - 0000000000006000
[    0.000000] PM: Registered nosave memory: 00000000000a0000 - 00000000000f0000
[    0.000000] PM: Registered nosave memory: 00000000000f0000 - 0000000000100000
[    0.000000] Allocating PCI resources starting at 40000000 (gap: 40000000:b0000000)
[    0.000000] Booting paravirtualized kernel on bare hardware
[    0.000000] NR_CPUS:8 nr_cpumask_bits:8 nr_cpu_ids:4 nr_node_ids:1
[    0.000000] PERCPU: Embedded 14 pages/cpu @c1c00000 s36056 r0 d21288 u1048576
[    0.000000] pcpu-alloc: s36056 r0 d21288 u1048576 alloc=1*4194304
[    0.000000] pcpu-alloc: [0] 0 1 2 3 
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 259624
[    0.000000] Kernel command line: BOOT_IMAGE=/boot/vmlinuz-2.6.32-25-generic root=UUID=be7bb49d-932d-45a0-8dd0-4fdfef937420 ro quiet splash
[    0.000000] PID hash table entries: 4096 (order: 2, 16384 bytes)
[    0.000000] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
[    0.000000] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
[    0.000000] Enabling fast FPU save and restore... done.
[    0.000000] Enabling unmasked SIMD FPU exception support... done.
[    0.000000] Initializing CPU#0
[    0.000000] allocated 5235400 bytes of page_cgroup
[    0.000000] please try 'cgroup_disable=memory' option if you don't want memory cgroups
[    0.000000] Initializing HighMem for node 0 (000377fe:0003fe8a)
[    0.000000] Memory: 1015640k/1047080k available (4680k kernel code, 30232k reserved, 2122k data, 656k init, 137776k highmem)
[    0.000000] virtual kernel memory layout:
[    0.000000]     fixmap  : 0xfff1d000 - 0xfffff000   ( 904 kB)
[    0.000000]     pkmap   : 0xff800000 - 0xffc00000   (4096 kB)
[    0.000000]     vmalloc : 0xf7ffe000 - 0xff7fe000   ( 120 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xf77fe000   ( 887 MB)
[    0.000000]       .init : 0xc07a5000 - 0xc0849000   ( 656 kB)
[    0.000000]       .data : 0xc05922c7 - 0xc07a4e68   (2122 kB)
[    0.000000]       .text : 0xc0100000 - 0xc05922c7   (4680 kB)
[    0.000000] Checking if this processor honours the WP bit even in supervisor mode...Ok.
[    0.000000] SLUB: Genslabs=13, HWalign=128, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
[    0.000000] Hierarchical RCU implementation.
[    0.000000] NR_IRQS:2304 nr_irqs:440
[    0.000000] Console: colour VGA+ 80x25
[    0.000000] console [tty0] enabled
[    0.000000] hpet clockevent registered
[    0.000000] HPET: 3 timers in total, 0 timers will be used for per-cpu timer
[    0.000000] Fast TSC calibration using PIT
[    0.000000] Detected 2793.322 MHz processor.
[    0.004006] Calibrating delay loop (skipped), value calculated using timer frequency.. 5586.64 BogoMIPS (lpj=11173288)
[    0.004026] Security Framework initialized
[    0.004047] AppArmor: AppArmor initialized
[    0.004056] Mount-cache hash table entries: 512
[    0.004211] Initializing cgroup subsys ns
[    0.004216] Initializing cgroup subsys cpuacct
[    0.004223] Initializing cgroup subsys memory
[    0.004232] Initializing cgroup subsys devices
[    0.004235] Initializing cgroup subsys freezer
[    0.004238] Initializing cgroup subsys net_cls
[    0.004268] CPU: Trace cache: 12K uops, L1 D cache: 16K
[    0.004273] CPU: L2 cache: 2048K
[    0.004276] CPU: Physical Processor ID: 0
[    0.004279] CPU: Processor Core ID: 0
[    0.004283] mce: CPU supports 4 MCE banks
[    0.004298] CPU0: Thermal monitoring enabled (TM1)
[    0.004303] using mwait in idle threads.
[    0.004311] Performance Events: no PMU driver, software events only.
[    0.004319] Checking 'hlt' instruction... OK.
[    0.024098] ACPI: Core revision 20090903
[    0.142096] ftrace: converting mcount calls to 0f 1f 44 00 00
[    0.142103] ftrace: allocating 21789 entries in 43 pages
[    0.144065] Enabling APIC mode:  Flat.  Using 1 I/O APICs
[    0.144392] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.186837] CPU0: Intel(R) Pentium(R) D CPU 2.80GHz stepping 04
[    0.188001] Booting processor 1 APIC 0x1 ip 0x6000
[    0.008000] Initializing CPU#1
[    0.008000] CPU: Trace cache: 12K uops, L1 D cache: 16K
[    0.008000] CPU: L2 cache: 2048K
[    0.008000] CPU: Physical Processor ID: 0
[    0.008000] CPU: Processor Core ID: 1
[    0.008000] CPU1: Thermal monitoring enabled (TM1)
[    0.272122] CPU1: Intel(R) Pentium(R) D CPU 2.80GHz stepping 04
[    0.272139] checking TSC synchronization [CPU#0 -> CPU#1]: passed.
[    0.276022] Brought up 2 CPUs
[    0.276026] Total of 2 processors activated (11172.73 BogoMIPS).
[    0.276635] CPU0 attaching sched-domain:
[    0.276640]  domain 0: span 0-1 level CPU
[    0.276643]   groups: 0 1
[    0.276651] CPU1 attaching sched-domain:
[    0.276654]  domain 0: span 0-1 level CPU
[    0.276658]   groups: 1 0
[    0.276759] devtmpfs: initialized
[    0.276759] regulator: core version 0.5
[    0.276759] Time: 13:38:21  Date: 11/12/10
[    0.276759] NET: Registered protocol family 16
[    0.276759] Trying to unpack rootfs image as initramfs...
[    0.276759] EISA bus registered
[    0.276759] ACPI: bus type pci registered
[    0.276759] PCI: MCFG configuration 0: base f0000000 segment 0 buses 0 - 63
[    0.276759] PCI: MCFG area at f0000000 reserved in E820
[    0.276759] PCI: Using MMCONFIG for extended config space
[    0.276759] PCI: Using configuration type 1 for base access
[    0.284145] bio: create slab <bio-0> at 0
[    0.284950] ACPI: EC: Look up EC in DSDT
[    0.317236] ACPI: BIOS _OSI(Linux) query ignored
[    0.329178] ACPI: Interpreter enabled
[    0.329185] ACPI: (supports S0 S1 S3 S4 S5)
[    0.329221] ACPI: Using IOAPIC for interrupt routing
[    0.389411] ACPI: No dock devices found.
[    0.393158] ACPI: PCI Root Bridge [PCI0] (0000:00)
[    0.393317] pci 0000:00:01.0: PME# supported from D0 D3hot D3cold
[    0.393322] pci 0000:00:01.0: PME# disabled
[    0.393406] pci 0000:00:1b.0: reg 10 64bit mmio: [0xfebfc000-0xfebfffff]
[    0.393462] pci 0000:00:1b.0: PME# supported from D0 D3hot D3cold
[    0.393467] pci 0000:00:1b.0: PME# disabled
[    0.393551] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    0.393556] pci 0000:00:1c.0: PME# disabled
[    0.393644] pci 0000:00:1c.4: PME# supported from D0 D3hot D3cold
[    0.393649] pci 0000:00:1c.4: PME# disabled
[    0.393733] pci 0000:00:1c.5: PME# supported from D0 D3hot D3cold
[    0.393738] pci 0000:00:1c.5: PME# disabled
[    0.393796] pci 0000:00:1d.0: reg 20 io port: [0xff80-0xff9f]
[    0.393859] pci 0000:00:1d.1: reg 20 io port: [0xff60-0xff7f]
[    0.393920] pci 0000:00:1d.2: reg 20 io port: [0xff40-0xff5f]
[    0.393984] pci 0000:00:1d.3: reg 20 io port: [0xff20-0xff3f]
[    0.394052] pci 0000:00:1d.7: reg 10 32bit mmio: [0xffa80800-0xffa80bff]
[    0.394115] pci 0000:00:1d.7: PME# supported from D0 D3hot D3cold
[    0.394121] pci 0000:00:1d.7: PME# disabled
[    0.394272] pci 0000:00:1f.0: quirk: region 0800-087f claimed by ICH6 ACPI/GPIO/TCO
[    0.394278] pci 0000:00:1f.0: quirk: region 0880-08bf claimed by ICH6 GPIO
[    0.394283] pci 0000:00:1f.0: ICH7 LPC Generic IO decode 1 PIO at 0c00 (mask 007f)
[    0.394288] pci 0000:00:1f.0: ICH7 LPC Generic IO decode 2 PIO at 00e0 (mask 0007)
[    0.394346] pci 0000:00:1f.1: reg 10 io port: [0x1f0-0x1f7]
[    0.394355] pci 0000:00:1f.1: reg 14 io port: [0x3f4-0x3f7]
[    0.394364] pci 0000:00:1f.1: reg 18 io port: [0x170-0x177]
[    0.394372] pci 0000:00:1f.1: reg 1c io port: [0x374-0x377]
[    0.394381] pci 0000:00:1f.1: reg 20 io port: [0xffa0-0xffaf]
[    0.394443] pci 0000:00:1f.2: reg 10 io port: [0xfe00-0xfe07]
[    0.394452] pci 0000:00:1f.2: reg 14 io port: [0xfe10-0xfe13]
[    0.394460] pci 0000:00:1f.2: reg 18 io port: [0xfe20-0xfe27]
[    0.394468] pci 0000:00:1f.2: reg 1c io port: [0xfe30-0xfe33]
[    0.394476] pci 0000:00:1f.2: reg 20 io port: [0xfea0-0xfeaf]
[    0.394484] pci 0000:00:1f.2: reg 24 32bit mmio: [0xfebfbc00-0xfebfbfff]
[    0.394516] pci 0000:00:1f.2: PME# supported from D3hot
[    0.394521] pci 0000:00:1f.2: PME# disabled
[    0.394579] pci 0000:00:1f.3: reg 20 io port: [0xece0-0xecff]
[    0.394648] pci 0000:01:00.0: reg 10 32bit mmio: [0xfc000000-0xfcffffff]
[    0.394661] pci 0000:01:00.0: reg 14 64bit mmio pref: [0xe0000000-0xefffffff]
[    0.394673] pci 0000:01:00.0: reg 1c 64bit mmio: [0xfd000000-0xfdffffff]
[    0.394685] pci 0000:01:00.0: reg 30 32bit mmio pref: [0xfea00000-0xfea1ffff]
[    0.394766] pci 0000:00:01.0: bridge 32bit mmio: [0xfc000000-0xfeafffff]
[    0.394773] pci 0000:00:01.0: bridge 64bit mmio pref: [0xe0000000-0xefffffff]
[    0.394829] pci 0000:00:1c.0: bridge 32bit mmio: [0xfbf00000-0xfbffffff]
[    0.394964] pci 0000:04:00.0: reg 10 64bit mmio: [0xfbef0000-0xfbefffff]
[    0.395049] pci 0000:04:00.0: PME# supported from D3hot D3cold
[    0.395056] pci 0000:04:00.0: PME# disabled
[    0.395118] pci 0000:00:1c.5: bridge 32bit mmio: [0xfbe00000-0xfbefffff]
[    0.395169] pci 0000:05:02.0: reg 10 io port: [0xdcc0-0xdcc7]
[    0.395179] pci 0000:05:02.0: reg 14 io port: [0xdcb0-0xdcb3]
[    0.395189] pci 0000:05:02.0: reg 18 io port: [0xdcc8-0xdccf]
[    0.395198] pci 0000:05:02.0: reg 1c io port: [0xdcb4-0xdcb7]
[    0.395208] pci 0000:05:02.0: reg 20 io port: [0xdce0-0xdcef]
[    0.395217] pci 0000:05:02.0: reg 24 32bit mmio: [0xfbcffc00-0xfbcffdff]
[    0.395226] pci 0000:05:02.0: reg 30 32bit mmio pref: [0xfbd00000-0xfbd7ffff]
[    0.395250] pci 0000:05:02.0: supports D1 D2
[    0.395294] pci 0000:05:04.0: reg 10 io port: [0xdcd0-0xdcd7]
[    0.395303] pci 0000:05:04.0: reg 14 io port: [0xdcb8-0xdcbb]
[    0.395312] pci 0000:05:04.0: reg 18 io port: [0xdcd8-0xdcdf]
[    0.395321] pci 0000:05:04.0: reg 1c io port: [0xdcbc-0xdcbf]
[    0.395330] pci 0000:05:04.0: reg 20 io port: [0xdcf0-0xdcff]
[    0.395339] pci 0000:05:04.0: reg 24 32bit mmio: [0xfbcffe00-0xfbcfffff]
[    0.395349] pci 0000:05:04.0: reg 30 32bit mmio pref: [0xfbd00000-0xfbd7ffff]
[    0.395372] pci 0000:05:04.0: supports D1 D2
[    0.395423] pci 0000:00:1e.0: transparent bridge
[    0.395428] pci 0000:00:1e.0: bridge io port: [0xd000-0xdfff]
[    0.395434] pci 0000:00:1e.0: bridge 32bit mmio: [0xfbc00000-0xfbdfffff]
[    0.395468] pci_bus 0000:00: on NUMA node 0
[    0.395474] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[    0.395907] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI4._PRT]
[    0.396360] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI2._PRT]
[    0.396656] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
[    0.396874] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI5._PRT]
[    0.397121] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI6._PRT]
[    0.828294] Freeing initrd memory: 7773k freed
[    0.989437] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12 15)
[    0.989865] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 *10 11 12 15)
[    0.990258] ACPI: PCI Interrupt Link [LNKC] (IRQs *3 4 5 6 7 9 10 11 12 15)
[    0.990683] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 10 11 12 15) *0, disabled.
[    0.991091] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 *5 6 7 9 10 11 12 15)
[    0.991496] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 *9 10 11 12 15)
[    0.991943] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 *5 6 7 9 10 11 12 15)
[    0.992346] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 9 *10 11 12 15)
[    0.992565] vgaarb: device added: PCI:0000:01:00.0,decodes=io+mem,owns=io+mem,locks=none
[    0.992573] vgaarb: loaded
[    0.992738] SCSI subsystem initialized
[    0.992775] libata version 3.00 loaded.
[    0.992775] usbcore: registered new interface driver usbfs
[    0.992775] usbcore: registered new interface driver hub
[    0.992775] usbcore: registered new device driver usb
[    0.992775] ACPI: WMI: Mapper loaded
[    0.992775] PCI: Using ACPI for IRQ routing
[    0.992775] NetLabel: Initializing
[    0.992775] NetLabel:  domain hash size = 128
[    0.992775] NetLabel:  protocols = UNLABELED CIPSOv4
[    0.992775] NetLabel:  unlabeled traffic allowed by default
[    0.992775] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
[    0.992775] hpet0: 3 comparators, 64-bit 14.318180 MHz counter
[    0.996033] Switching to clocksource tsc
[    0.998858] AppArmor: AppArmor Filesystem Enabled
[    0.998875] pnp: PnP ACPI init
[    0.998887] ACPI: bus type pnp registered
[    1.005049] pnp 00:01: io resource (0x800-0x85f) overlaps 0000:00:1f.0 BAR 13 (0x800-0x87f), disabling
[    1.005055] pnp 00:01: io resource (0x860-0x8ff) overlaps 0000:00:1f.0 BAR 13 (0x800-0x87f), disabling
[    1.030749] pnp: PnP ACPI: found 10 devices
[    1.030752] ACPI: ACPI bus type pnp unregistered
[    1.030758] PnPBIOS: Disabled by ACPI PNP
[    1.030772] system 00:01: ioport range 0xc00-0xc7f has been reserved
[    1.030786] system 00:08: iomem range 0x0-0x9ffff could not be reserved
[    1.030791] system 00:08: iomem range 0x100000-0xffffff could not be reserved
[    1.030797] system 00:08: iomem range 0x1000000-0x3fe8abff could not be reserved
[    1.030801] system 00:08: iomem range 0xf0000-0xfffff could not be reserved
[    1.030805] system 00:08: iomem range 0xc0000-0xd7fff could not be reserved
[    1.030809] system 00:08: iomem range 0xfec00000-0xfecfffff could not be reserved
[    1.030813] system 00:08: iomem range 0xfee00000-0xfeefffff has been reserved
[    1.030817] system 00:08: iomem range 0xfed20000-0xfed9ffff has been reserved
[    1.030821] system 00:08: iomem range 0xffb00000-0xffbfffff has been reserved
[    1.030825] system 00:08: iomem range 0xffc00000-0xffffffff has been reserved
[    1.030834] system 00:09: iomem range 0xf0000000-0xf3ffffff has been reserved
[    1.030838] system 00:09: iomem range 0xfeda0000-0xfedacfff has been reserved
[    1.065610] pci 0000:05:02.0: BAR 6: address space collision on of device [0xfbd00000-0xfbd7ffff]
[    1.065617] pci 0000:05:04.0: BAR 6: address space collision on of device [0xfbd00000-0xfbd7ffff]
[    1.065670] pci 0000:00:01.0: PCI bridge, secondary bus 0000:01
[    1.065673] pci 0000:00:01.0:   IO window: disabled
[    1.065679] pci 0000:00:01.0:   MEM window: 0xfc000000-0xfeafffff
[    1.065684] pci 0000:00:01.0:   PREFETCH window: 0x000000e0000000-0x000000efffffff
[    1.065691] pci 0000:00:1c.0: PCI bridge, secondary bus 0000:02
[    1.065695] pci 0000:00:1c.0:   IO window: 0x1000-0x1fff
[    1.065701] pci 0000:00:1c.0:   MEM window: 0xfbf00000-0xfbffffff
[    1.065707] pci 0000:00:1c.0:   PREFETCH window: 0x00000040000000-0x000000401fffff
[    1.065715] pci 0000:00:1c.4: PCI bridge, secondary bus 0000:03
[    1.065719] pci 0000:00:1c.4:   IO window: 0x2000-0x2fff
[    1.065725] pci 0000:00:1c.4:   MEM window: 0x40200000-0x403fffff
[    1.065731] pci 0000:00:1c.4:   PREFETCH window: 0x00000040400000-0x000000405fffff
[    1.065739] pci 0000:00:1c.5: PCI bridge, secondary bus 0000:04
[    1.065743] pci 0000:00:1c.5:   IO window: 0x3000-0x3fff
[    1.065749] pci 0000:00:1c.5:   MEM window: 0xfbe00000-0xfbefffff
[    1.065755] pci 0000:00:1c.5:   PREFETCH window: 0x00000040600000-0x000000407fffff
[    1.065764] pci 0000:00:1e.0: PCI bridge, secondary bus 0000:05
[    1.065769] pci 0000:00:1e.0:   IO window: 0xd000-0xdfff
[    1.065775] pci 0000:00:1e.0:   MEM window: 0xfbc00000-0xfbdfffff
[    1.065780] pci 0000:00:1e.0:   PREFETCH window: 0x40800000-0x408fffff
[    1.065797]   alloc irq_desc for 16 on node -1
[    1.065800]   alloc kstat_irqs on node -1
[    1.065807] pci 0000:00:01.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
[    1.065813] pci 0000:00:01.0: setting latency timer to 64
[    1.065824] pci 0000:00:1c.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
[    1.065830] pci 0000:00:1c.0: setting latency timer to 64
[    1.065841] pci 0000:00:1c.4: PCI INT A -> GSI 16 (level, low) -> IRQ 16
[    1.065846] pci 0000:00:1c.4: setting latency timer to 64
[    1.065857]   alloc irq_desc for 17 on node -1
[    1.065859]   alloc kstat_irqs on node -1
[    1.065865] pci 0000:00:1c.5: PCI INT B -> GSI 17 (level, low) -> IRQ 17
[    1.065870] pci 0000:00:1c.5: setting latency timer to 64
[    1.065879] pci 0000:00:1e.0: setting latency timer to 64
[    1.065885] pci_bus 0000:00: resource 0 io:  [0x00-0xffff]
[    1.065889] pci_bus 0000:00: resource 1 mem: [0x000000-0xffffffff]
[    1.065892] pci_bus 0000:01: resource 1 mem: [0xfc000000-0xfeafffff]
[    1.065896] pci_bus 0000:01: resource 2 pref mem [0xe0000000-0xefffffff]
[    1.065900] pci_bus 0000:02: resource 0 io:  [0x1000-0x1fff]
[    1.065903] pci_bus 0000:02: resource 1 mem: [0xfbf00000-0xfbffffff]
[    1.065907] pci_bus 0000:02: resource 2 pref mem [0x40000000-0x401fffff]
[    1.065910] pci_bus 0000:03: resource 0 io:  [0x2000-0x2fff]
[    1.065914] pci_bus 0000:03: resource 1 mem: [0x40200000-0x403fffff]
[    1.065917] pci_bus 0000:03: resource 2 pref mem [0x40400000-0x405fffff]
[    1.065921] pci_bus 0000:04: resource 0 io:  [0x3000-0x3fff]
[    1.065924] pci_bus 0000:04: resource 1 mem: [0xfbe00000-0xfbefffff]
[    1.065928] pci_bus 0000:04: resource 2 pref mem [0x40600000-0x407fffff]
[    1.065931] pci_bus 0000:05: resource 0 io:  [0xd000-0xdfff]
[    1.065935] pci_bus 0000:05: resource 1 mem: [0xfbc00000-0xfbdfffff]
[    1.065938] pci_bus 0000:05: resource 2 pref mem [0x40800000-0x408fffff]
[    1.065942] pci_bus 0000:05: resource 3 io:  [0x00-0xffff]
[    1.065945] pci_bus 0000:05: resource 4 mem: [0x000000-0xffffffff]
[    1.065993] NET: Registered protocol family 2
[    1.066128] IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
[    1.066578] TCP established hash table entries: 131072 (order: 8, 1048576 bytes)
[    1.067198] TCP bind hash table entries: 65536 (order: 7, 524288 bytes)
[    1.067507] TCP: Hash tables configured (established 131072 bind 65536)
[    1.067510] TCP reno registered
[    1.067612] NET: Registered protocol family 1
[    1.067750] pci 0000:01:00.0: Boot video device
[    1.067788] Simple Boot Flag at 0x7a set to 0x1
[    1.068025] cpufreq-nforce2: No nForce2 chipset.
[    1.068067] Scanning for low memory corruption every 60 seconds
[    1.068217] audit: initializing netlink socket (disabled)
[    1.068229] type=2000 audit(1289569101.068:1): initialized
[    1.077939] highmem bounce pool size: 64 pages
[    1.077951] HugeTLB registered 4 MB page size, pre-allocated 0 pages
[    1.080127] VFS: Disk quotas dquot_6.5.2
[    1.080214] Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
[    1.081079] fuse init (API version 7.13)
[    1.081210] msgmni has been set to 1731
[    1.081577] alg: No test for stdrng (krng)
[    1.081664] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 253)
[    1.081668] io scheduler noop registered
[    1.081671] io scheduler anticipatory registered
[    1.081674] io scheduler deadline registered
[    1.081735] io scheduler cfq registered (default)
[    1.081925]   alloc irq_desc for 24 on node -1
[    1.081929]   alloc kstat_irqs on node -1
[    1.081940] pcieport 0000:00:01.0: irq 24 for MSI/MSI-X
[    1.081949] pcieport 0000:00:01.0: setting latency timer to 64
[    1.082085]   alloc irq_desc for 25 on node -1
[    1.082088]   alloc kstat_irqs on node -1
[    1.082098] pcieport 0000:00:1c.0: irq 25 for MSI/MSI-X
[    1.082108] pcieport 0000:00:1c.0: setting latency timer to 64
[    1.082262]   alloc irq_desc for 26 on node -1
[    1.082265]   alloc kstat_irqs on node -1
[    1.082275] pcieport 0000:00:1c.4: irq 26 for MSI/MSI-X
[    1.082285] pcieport 0000:00:1c.4: setting latency timer to 64
[    1.082441]   alloc irq_desc for 27 on node -1
[    1.082444]   alloc kstat_irqs on node -1
[    1.082455] pcieport 0000:00:1c.5: irq 27 for MSI/MSI-X
[    1.082466] pcieport 0000:00:1c.5: setting latency timer to 64
[    1.082600] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[    1.082738] pciehp: PCI Express Hot Plug Controller Driver version: 0.4
[    1.082857] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input0
[    1.082867] ACPI: Power Button [VBTN]
[    1.082939] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input1
[    1.082943] ACPI: Power Button [PWRF]
[    1.083769] processor LNXCPU:00: registered as cooling_device0
[    1.083874] processor LNXCPU:01: registered as cooling_device1
[    1.134418] isapnp: Scanning for PnP cards...
[    1.136447] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    1.136561] serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[    1.137018] 00:07: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[    1.138559] brd: module loaded
[    1.139265] loop: module loaded
[    1.139379] input: Macintosh mouse button emulation as /devices/virtual/input/input2
[    1.139494] ata_piix 0000:00:1f.1: version 2.13
[    1.139509] ata_piix 0000:00:1f.1: PCI INT A -> GSI 16 (level, low) -> IRQ 16
[    1.139557] ata_piix 0000:00:1f.1: setting latency timer to 64
[    1.139647] scsi0 : ata_piix
[    1.139747] scsi1 : ata_piix
[    1.139798] ata1: PATA max UDMA/100 cmd 0x1f0 ctl 0x3f6 bmdma 0xffa0 irq 14
[    1.139803] ata2: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0xffa8 irq 15
[    1.140337] Fixed MDIO Bus: probed
[    1.140391] PPP generic driver version 2.4.2
[    1.140447] tun: Universal TUN/TAP device driver, 1.6
[    1.140450] tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
[    1.140567] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    1.140591]   alloc irq_desc for 21 on node -1
[    1.140594]   alloc kstat_irqs on node -1
[    1.140602] ehci_hcd 0000:00:1d.7: PCI INT A -> GSI 21 (level, low) -> IRQ 21
[    1.140619] ehci_hcd 0000:00:1d.7: setting latency timer to 64
[    1.140623] ehci_hcd 0000:00:1d.7: EHCI Host Controller
[    1.140669] ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
[    1.140691] ehci_hcd 0000:00:1d.7: using broken periodic workaround
[    1.140704] ehci_hcd 0000:00:1d.7: debug port 1
[    1.144597] ehci_hcd 0000:00:1d.7: cache line size of 128 is not supported
[    1.144614] ehci_hcd 0000:00:1d.7: irq 21, io mem 0xffa80800
[    1.160019] ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00
[    1.160151] usb usb1: configuration #1 chosen from 1 choice
[    1.160193] hub 1-0:1.0: USB hub found
[    1.160203] hub 1-0:1.0: 8 ports detected
[    1.160292] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    1.160313] uhci_hcd: USB Universal Host Controller Interface driver
[    1.160343] uhci_hcd 0000:00:1d.0: PCI INT A -> GSI 21 (level, low) -> IRQ 21
[    1.160352] uhci_hcd 0000:00:1d.0: setting latency timer to 64
[    1.160356] uhci_hcd 0000:00:1d.0: UHCI Host Controller
[    1.160403] uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
[    1.160430] uhci_hcd 0000:00:1d.0: irq 21, io base 0x0000ff80
[    1.160551] usb usb2: configuration #1 chosen from 1 choice
[    1.160591] hub 2-0:1.0: USB hub found
[    1.160600] hub 2-0:1.0: 2 ports detected
[    1.160664]   alloc irq_desc for 22 on node -1
[    1.160667]   alloc kstat_irqs on node -1
[    1.160673] uhci_hcd 0000:00:1d.1: PCI INT B -> GSI 22 (level, low) -> IRQ 22
[    1.160683] uhci_hcd 0000:00:1d.1: setting latency timer to 64
[    1.160687] uhci_hcd 0000:00:1d.1: UHCI Host Controller
[    1.160739] uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
[    1.160773] uhci_hcd 0000:00:1d.1: irq 22, io base 0x0000ff60
[    1.160892] usb usb3: configuration #1 chosen from 1 choice
[    1.160933] hub 3-0:1.0: USB hub found
[    1.160942] hub 3-0:1.0: 2 ports detected
[    1.161001]   alloc irq_desc for 18 on node -1
[    1.161005]   alloc kstat_irqs on node -1
[    1.161010] uhci_hcd 0000:00:1d.2: PCI INT C -> GSI 18 (level, low) -> IRQ 18
[    1.161018] uhci_hcd 0000:00:1d.2: setting latency timer to 64
[    1.161022] uhci_hcd 0000:00:1d.2: UHCI Host Controller
[    1.161066] uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
[    1.161100] uhci_hcd 0000:00:1d.2: irq 18, io base 0x0000ff40
[    1.161222] usb usb4: configuration #1 chosen from 1 choice
[    1.161264] hub 4-0:1.0: USB hub found
[    1.161273] hub 4-0:1.0: 2 ports detected
[    1.161332]   alloc irq_desc for 23 on node -1
[    1.161335]   alloc kstat_irqs on node -1
[    1.161341] uhci_hcd 0000:00:1d.3: PCI INT D -> GSI 23 (level, low) -> IRQ 23
[    1.161348] uhci_hcd 0000:00:1d.3: setting latency timer to 64
[    1.161352] uhci_hcd 0000:00:1d.3: UHCI Host Controller
[    1.161400] uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 5
[    1.161434] uhci_hcd 0000:00:1d.3: irq 23, io base 0x0000ff20
[    1.161560] usb usb5: configuration #1 chosen from 1 choice
[    1.161600] hub 5-0:1.0: USB hub found
[    1.161608] hub 5-0:1.0: 2 ports detected
[    1.161743] PNP: No PS/2 controller found. Probing ports directly.
[    1.164552] serio: i8042 KBD port at 0x60,0x64 irq 1
[    1.164562] serio: i8042 AUX port at 0x60,0x64 irq 12
[    1.164674] mice: PS/2 mouse device common for all mice
[    1.164824] rtc_cmos 00:05: RTC can wake from S4
[    1.164877] rtc_cmos 00:05: rtc core: registered rtc_cmos as rtc0
[    1.164908] rtc0: alarms up to one day, 242 bytes nvram, hpet irqs
[    1.165065] device-mapper: uevent: version 1.0.3
[    1.165220] device-mapper: ioctl: 4.15.0-ioctl (2009-04-01) initialised: dm-devel@redhat.com
[    1.165310] device-mapper: multipath: version 1.1.0 loaded
[    1.165314] device-mapper: multipath round-robin: version 1.0.0 loaded
[    1.165468] EISA: Probing bus 0 at eisa.0
[    1.165475] Cannot allocate resource for EISA slot 1
[    1.165478] Cannot allocate resource for EISA slot 2
[    1.165481] Cannot allocate resource for EISA slot 3
[    1.165499] EISA: Detected 0 cards.
[    1.165596] cpuidle: using governor ladder
[    1.165601] cpuidle: using governor menu
[    1.166291] TCP cubic registered
[    1.166479] NET: Registered protocol family 10
[    1.167161] lo: Disabled Privacy Extensions
[    1.167746] NET: Registered protocol family 17
[    1.168242] Using IPI No-Shortcut mode
[    1.168347] PM: Resume from disk failed.
[    1.168363] registered taskstats version 1
[    1.168793]   Magic number: 2:890:634
[    1.168859] rtc_cmos 00:05: setting system clock to 2010-11-12 13:38:22 UTC (1289569102)
[    1.168863] BIOS EDD facility v0.16 2004-Jun-25, 0 devices found
[    1.168866] EDD information not available.
[    1.168991] ata2: port disabled. ignoring.
[    1.332576] ata1.00: ATAPI: PHILIPS DVD+/-RW DVD8801, 4D28, max UDMA/33
[    1.332805] ata1.01: ATA-7: Maxtor 6Y080L0, YAR41BW0, max UDMA/133
[    1.332810] ata1.01: 156250000 sectors, multi 8: LBA 
[    1.348499] ata1.00: configured for UDMA/33
[    1.364435] ata1.01: configured for UDMA/100
[    1.487548] isapnp: No Plug & Play device found
[    1.489803] scsi 0:0:0:0: CD-ROM            PHILIPS  DVD+-RW DVD8801  4D28 PQ: 0 ANSI: 5
[    1.498412] sr0: scsi3-mmc drive: 48x/48x writer cd/rw xa/form2 cdda tray
[    1.498416] Uniform CD-ROM driver Revision: 3.20
[    1.498551] sr 0:0:0:0: Attached scsi CD-ROM sr0
[    1.498620] sr 0:0:0:0: Attached scsi generic sg0 type 5
[    1.498770] scsi 0:0:1:0: Direct-Access     ATA      Maxtor 6Y080L0   YAR4 PQ: 0 ANSI: 5
[    1.498940] sd 0:0:1:0: Attached scsi generic sg1 type 0
[    1.498984] sd 0:0:1:0: [sda] 156250000 512-byte logical blocks: (80.0 GB/74.5 GiB)
[    1.499088] sd 0:0:1:0: [sda] Write Protect is off
[    1.499092] sd 0:0:1:0: [sda] Mode Sense: 00 3a 00 00
[    1.499130] sd 0:0:1:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    1.499360]  sda: sda2 sda3
[    1.547084] sd 0:0:1:0: [sda] Attached SCSI disk
[    1.547130] Freeing unused kernel memory: 656k freed
[    1.547696] Write protecting the kernel text: 4684k
[    1.547759] Write protecting the kernel read-only data: 1840k
[    1.572656] udev: starting version 151
[    1.694166] ahci 0000:00:1f.2: version 3.0
[    1.694187]   alloc irq_desc for 20 on node -1
[    1.694191]   alloc kstat_irqs on node -1
[    1.694201] ahci 0000:00:1f.2: PCI INT C -> GSI 20 (level, low) -> IRQ 20
[    1.694242]   alloc irq_desc for 28 on node -1
[    1.694245]   alloc kstat_irqs on node -1
[    1.694256] ahci 0000:00:1f.2: irq 28 for MSI/MSI-X
[    1.694345] ahci 0000:00:1f.2: AHCI 0001.0100 32 slots 4 ports 3 Gbps 0xf impl SATA mode
[    1.694351] ahci 0000:00:1f.2: flags: 64bit ncq pm led clo pio slum part 
[    1.694357] ahci 0000:00:1f.2: setting latency timer to 64
[    1.694945] tg3.c:v3.102 (September 1, 2009)
[    1.694962] tg3 0000:04:00.0: PCI INT A -> GSI 17 (level, low) -> IRQ 17
[    1.694971] tg3 0000:04:00.0: setting latency timer to 64
[    1.698120] sata_sil 0000:05:02.0: version 2.4
[    1.698156] sata_sil 0000:05:02.0: PCI INT A -> GSI 18 (level, low) -> IRQ 18
[    1.702792] scsi2 : ahci
[    1.703011] scsi4 : ahci
[    1.703184] scsi5 : ahci
[    1.703337] scsi6 : ahci
[    1.703404] ata3: SATA max UDMA/133 abar m1024@0xfebfbc00 port 0xfebfbd00 irq 28
[    1.703409] ata4: SATA max UDMA/133 abar m1024@0xfebfbc00 port 0xfebfbd80 irq 28
[    1.703413] ata5: SATA max UDMA/133 abar m1024@0xfebfbc00 port 0xfebfbe00 irq 28
[    1.703418] ata6: SATA max UDMA/133 abar m1024@0xfebfbc00 port 0xfebfbe80 irq 28
[    1.703749] scsi3 : sata_sil
[    1.704201] scsi7 : sata_sil
[    1.704271] ata7: SATA max UDMA/100 mmio m512@0xfbcffc00 tf 0xfbcffc80 irq 18
[    1.704276] ata8: SATA max UDMA/100 mmio m512@0xfbcffc00 tf 0xfbcffcc0 irq 18
[    1.704337] sata_sil 0000:05:04.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
[    1.704732] scsi8 : sata_sil
[    1.704888] scsi9 : sata_sil
[    1.704947] ata9: SATA max UDMA/100 mmio m512@0xfbcffe00 tf 0xfbcffe80 irq 16
[    1.704953] ata10: SATA max UDMA/100 mmio m512@0xfbcffe00 tf 0xfbcffec0 irq 16
[    1.713937] eth0: Tigon3 [partno(BCM5751PKFBG) rev 4001] (PCI Express) MAC address 00:13:72:1c:f2:6a
[    1.713942] eth0: attached PHY is 5750 (10/100/1000Base-T Ethernet) (WireSpeed[1])
[    1.713946] eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] TSOcap[1]
[    1.713950] eth0: dma_rwctrl[76180000] dma_mask[64-bit]
[    1.768019] usb 4-1: new low speed USB device using uhci_hcd and address 2
[    1.942175] usb 4-1: configuration #1 chosen from 1 choice
[    2.020052] ata3: SATA link down (SStatus 0 SControl 300)
[    2.020094] ata5: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    2.021205] ata5.00: ATA-8: Hitachi HTS542516K9SA00, BBCOC31P, max UDMA/133
[    2.021210] ata5.00: 312581808 sectors, multi 8: LBA48 NCQ (depth 31/32), AA
[    2.022565] ata5.00: configured for UDMA/133
[    2.024065] ata9: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[    2.024156] ata7: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[    2.024226] ata6: SATA link down (SStatus 0 SControl 300)
[    2.032423] ata7.00: ATA-8: FUJITSU MHZ2160BH G2, 00000009, max UDMA/100
[    2.032427] ata7.00: 312581808 sectors, multi 16: LBA48 NCQ (depth 0/32)
[    2.032655] ata9.00: ATA-7: ST9160823AS, 3.AAB, max UDMA/133
[    2.032659] ata9.00: 312581808 sectors, multi 16: LBA48 NCQ (depth 0/32)
[    2.040367] ata7.00: configured for UDMA/100
[    2.048395] ata9.00: configured for UDMA/100
[    2.083794] EXT4-fs (sda2): mounted filesystem with ordered data mode
[    2.184033] usb 5-1: new low speed USB device using uhci_hcd and address 2
[    2.338471] usb 5-1: configuration #1 chosen from 1 choice
[    7.060033] ata4: link is slow to respond, please be patient (ready=0)
[   11.708026] ata4: COMRESET failed (errno=-16)
[   15.670709] udev: starting version 151
[   15.730519] intel_rng: Firmware space is locked read-only. If you can't or
[   15.730522] intel_rng: don't want to disable this in firmware setup, and if
[   15.730524] intel_rng: you are certain that your system has a functional
[   15.730525] intel_rng: RNG, try using the 'no_fwh_detect' option.
[   15.789335] Adding 1951888k swap on /dev/sda3.  Priority:-1 extents:1 across:1951888k 
[   15.854841] dcdbas dcdbas: Dell Systems Management Base Driver (version 5.6.0-3.2)
[   15.911309] parport_pc 00:06: reported by Plug and Play ACPI
[   15.911371] parport0: PC-style at 0x378 (0x778), irq 7, using FIFO [PCSPP,TRISTATE,COMPAT,ECP]
[   15.921995] ppdev: user-space parallel port driver
[   15.987558] usbcore: registered new interface driver hiddev
[   16.002877] input: DELL DELL USB Keyboard as /devices/pci0000:00/0000:00:1d.2/usb4/4-1/4-1:1.0/input/input3
[   16.003201] generic-usb 0003:413C:2005.0001: input,hidraw0: USB HID v1.10 Keyboard [DELL DELL USB Keyboard] on usb-0000:00:1d.2-1/input0
[   16.016085] input: HID 413c:3010 as /devices/pci0000:00/0000:00:1d.3/usb5/5-1/5-1:1.0/input/input4
[   16.016248] generic-usb 0003:413C:3010.0002: input,hidraw1: USB HID v1.00 Mouse [HID 413c:3010] on usb-0000:00:1d.3-1/input0
[   16.016289] usbcore: registered new interface driver usbhid
[   16.016294] usbhid: v2.6:USB HID core driver
[   16.030577] type=1505 audit(1289590717.359:2):  operation="profile_load" pid=523 name="/sbin/dhclient3"
[   16.031317] type=1505 audit(1289590717.359:3):  operation="profile_load" pid=523 name="/usr/lib/NetworkManager/nm-dhcp-client.action"
[   16.031719] type=1505 audit(1289590717.359:4):  operation="profile_load" pid=523 name="/usr/lib/connman/scripts/dhclient-script"
[   16.287572] type=1505 audit(1289590717.615:5):  operation="profile_load" pid=636 name="/usr/share/gdm/guest-session/Xsession"
[   16.296280] type=1505 audit(1289590717.627:6):  operation="profile_replace" pid=639 name="/sbin/dhclient3"
[   16.297097] type=1505 audit(1289590717.627:7):  operation="profile_replace" pid=639 name="/usr/lib/NetworkManager/nm-dhcp-client.action"
[   16.297509] type=1505 audit(1289590717.627:8):  operation="profile_replace" pid=639 name="/usr/lib/connman/scripts/dhclient-script"
[   16.301129] type=1505 audit(1289590717.631:9):  operation="profile_load" pid=640 name="/usr/bin/evince"
[   16.313388] type=1505 audit(1289590717.643:10):  operation="profile_load" pid=640 name="/usr/bin/evince-previewer"
[   16.319270] type=1505 audit(1289590717.647:11):  operation="profile_load" pid=640 name="/usr/bin/evince-thumbnailer"
[   16.338016] ADDRCONF(NETDEV_UP): eth0: link is not ready
[   17.068017] ata4: link is slow to respond, please be patient (ready=0)
[   18.028186] tg3: eth0: Link is up at 100 Mbps, full duplex.
[   18.028190] tg3: eth0: Flow control is on for TX and on for RX.
[   18.028332] ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
[   21.716018] ata4: COMRESET failed (errno=-16)
[   27.076017] ata4: link is slow to respond, please be patient (ready=0)
[   28.112006] eth0: no IPv6 routers present
[   56.756014] ata4: COMRESET failed (errno=-16)
[   56.756064] ata4: limiting SATA link speed to 1.5 Gbps
[   57.076024] ata4: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[   57.081774] ata4.00: ATA-8: SAMSUNG HM251JJ, 2AA00_00, max UDMA7
[   57.081780] ata4.00: 488397168 sectors, multi 8: LBA48 NCQ (depth 31/32), AA
[   57.087649] ata4.00: configured for UDMA/133
[   57.100168] scsi 4:0:0:0: Direct-Access     ATA      SAMSUNG HM251JJ  2AA0 PQ: 0 ANSI: 5
[   57.100456] sd 4:0:0:0: Attached scsi generic sg2 type 0
[   57.100727] scsi 5:0:0:0: Direct-Access     ATA      Hitachi HTS54251 BBCO PQ: 0 ANSI: 5
[   57.100983] sd 5:0:0:0: Attached scsi generic sg3 type 0
[   57.101723] scsi 3:0:0:0: Direct-Access     ATA      FUJITSU MHZ2160B 0000 PQ: 0 ANSI: 5
[   57.101914] sd 3:0:0:0: Attached scsi generic sg4 type 0
[   57.102435] sd 3:0:0:0: [sdd] 312581808 512-byte logical blocks: (160 GB/149 GiB)
[   57.102517] sd 3:0:0:0: [sdd] Write Protect is off
[   57.102521] sd 3:0:0:0: [sdd] Mode Sense: 00 3a 00 00
[   57.102598] sd 3:0:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   57.102751] sd 5:0:0:0: [sdc] 312581808 512-byte logical blocks: (160 GB/149 GiB)
[   57.102830] sd 5:0:0:0: [sdc] Write Protect is off
[   57.102834] sd 5:0:0:0: [sdc] Mode Sense: 00 3a 00 00
[   57.102913] sd 5:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   57.106476]  sdd:
[   57.106702]  sdc:
[   57.106909] sd 4:0:0:0: [sdb] 488397168 512-byte logical blocks: (250 GB/232 GiB)
[   57.106980] sd 4:0:0:0: [sdb] Write Protect is off
[   57.106984] sd 4:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[   57.107021] sd 4:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   57.107213]  sdb: sdb1 sdb2
[   57.137157] sd 4:0:0:0: [sdb] Attached SCSI disk
[   57.424043] ata8: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[   57.446378]  sdd1
[   57.447323] sd 3:0:0:0: [sdd] Attached SCSI disk
[   57.478563]  sdc1
[   57.479115] sd 5:0:0:0: [sdc] Attached SCSI disk
[   57.845328] ata8.00: ATA-8: TOSHIBA MK8052GSX, LV011D, max UDMA/100
[   57.845334] ata8.00: 156301488 sectors, multi 16: LBA48 NCQ (depth 0/32)
[   57.852445] ata8.00: configured for UDMA/100
[   57.852629] scsi 7:0:0:0: Direct-Access     ATA      TOSHIBA MK8052GS LV01 PQ: 0 ANSI: 5
[   57.852981] sd 7:0:0:0: [sde] 156301488 512-byte logical blocks: (80.0 GB/74.5 GiB)
[   57.853016] sd 7:0:0:0: Attached scsi generic sg5 type 0
[   57.853239] scsi 8:0:0:0: Direct-Access     ATA      ST9160823AS      3.AA PQ: 0 ANSI: 5
[   57.853509] sd 8:0:0:0: Attached scsi generic sg6 type 0
[   57.853548] sd 8:0:0:0: [sdf] 312581808 512-byte logical blocks: (160 GB/149 GiB)
[   57.853688] sd 8:0:0:0: [sdf] Write Protect is off
[   57.853693] sd 8:0:0:0: [sdf] Mode Sense: 00 3a 00 00
[   57.853735] sd 8:0:0:0: [sdf] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   57.853957]  sdf:
[   57.854158] sd 7:0:0:0: [sde] Write Protect is off
[   57.854164] sd 7:0:0:0: [sde] Mode Sense: 00 3a 00 00
[   57.854211] sd 7:0:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   57.855679]  sde: sde1
[   57.907722] sd 7:0:0:0: [sde] Attached SCSI disk
[   57.993120]  sdf1
[   57.993652] sd 8:0:0:0: [sdf] Attached SCSI disk
[   58.284040] ata10: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[   58.325298] ata10.00: ATA-8: WDC WD800BEVS-22VAT0, 11.01A11, max UDMA/133
[   58.325304] ata10.00: 156301488 sectors, multi 16: LBA48 NCQ (depth 0/32)
[   58.340552] ata10.00: configured for UDMA/100
[   58.340723] scsi 9:0:0:0: Direct-Access     ATA      WDC WD800BEVS-22 11.0 PQ: 0 ANSI: 5
[   58.340994] sd 9:0:0:0: Attached scsi generic sg7 type 0
[   58.341286] sd 9:0:0:0: [sdg] 156301488 512-byte logical blocks: (80.0 GB/74.5 GiB)
[   58.341365] sd 9:0:0:0: [sdg] Write Protect is off
[   58.341369] sd 9:0:0:0: [sdg] Mode Sense: 00 3a 00 00
[   58.341410] sd 9:0:0:0: [sdg] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   58.341916]  sdg: sdg1
[   58.345084] sd 9:0:0:0: [sdg] Attached SCSI disk
[   58.346919] vga16fb: initializing
[   58.346925] vga16fb: mapped to 0xc00a0000
[   58.347006] fb0: VGA16 VGA frame buffer device
[   58.356870] dell-wmi: No known WMI GUID found
[   58.363217] lp0: using parport0 (interrupt-driven).
[   58.367533] Linux agpgart interface v0.103
[   58.412877] nvidia: module license 'NVIDIA' taints kernel.
[   58.412883] Disabling lock debugging due to kernel taint
[   59.576120] nvidia 0000:01:00.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
[   59.576132] nvidia 0000:01:00.0: setting latency timer to 64
[   59.576138] vgaarb: device changed decodes: PCI:0000:01:00.0,olddecodes=io+mem,decodes=none:owns=io+mem
[   59.577703] NVRM: loading NVIDIA UNIX x86 Kernel Module  195.36.24  Thu Apr 22 09:18:20 PDT 2010
[   59.589937] HDA Intel 0000:00:1b.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
[   59.589974] HDA Intel 0000:00:1b.0: setting latency timer to 64
[   59.641510] Console: switching to colour frame buffer device 80x30
[   59.677394] input: HDA Intel Line In at Ext Rear Jack as /devices/pci0000:00/0000:00:1b.0/sound/card0/input5
[   59.677709] input: HDA Intel Mic at Ext Front Jack as /devices/pci0000:00/0000:00:1b.0/sound/card0/input6
[   59.677910] input: HDA Intel Mic at Ext Rear Jack as /devices/pci0000:00/0000:00:1b.0/sound/card0/input7
[   59.678102] input: HDA Intel Line Out at Ext Rear Jack as /devices/pci0000:00/0000:00:1b.0/sound/card0/input8
[   59.678295] input: HDA Intel HP Out at Ext Front Jack as /devices/pci0000:00/0000:00:1b.0/sound/card0/input9
[   64.862327] CPU0 attaching NULL sched-domain.
[   64.862336] CPU1 attaching NULL sched-domain.
[   64.892598] CPU0 attaching sched-domain:
[   64.892604]  domain 0: span 0-1 level CPU
[   64.892608]   groups: 0 1
[   64.892618] CPU1 attaching sched-domain:
[   64.892621]  domain 0: span 0-1 level CPU
[   64.892624]   groups: 1 0


--------------060207080802020701050407--
