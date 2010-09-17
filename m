From: Greg Oliver <oliver.greg@gmail.com>
Subject: Either PMP issues, or SB700/800 Issues ??
Date: Fri, 17 Sep 2010 12:05:08 -0500
Message-ID: <AANLkTikMLg2Uweeszw7pU9ZKWA0wTdLS5Y3NovOsb0fa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:33036 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752573Ab0IQRFK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 17 Sep 2010 13:05:10 -0400
Received: by bwz11 with SMTP id 11so2820036bwz.19
        for <linux-ide@vger.kernel.org>; Fri, 17 Sep 2010 10:05:08 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi,

I'm not sure where to go with this since there are no googl'ings I can
find with this exact issue.

I have a:

00:11.0 SATA controller: ATI Technologies Inc SB700/SB800 SATA
Controller [AHCI mode] (prog-if 01)
	Subsystem: ATI Technologies Inc SB700/SB800 SATA Controller [AHCI mode]
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B- DisINTx-
	Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 64, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 22
	Region 0: I/O ports at c000 [size=8]
	Region 1: I/O ports at b000 [size=4]
	Region 2: I/O ports at a000 [size=8]
	Region 3: I/O ports at 9000 [size=4]
	Region 4: I/O ports at 8000 [size=16]
	Region 5: Memory at fe8ffc00 (32-bit, non-prefetchable) [size=1K]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [70] SATA HBA <?>
	Kernel driver in use: ahci
	Kernel modules: ahci

I am trying to install an older 2.6.19 (CentOS) kernel, but it is failing:

<4>ata1.01: failed to read SCR 2 (Emask=0x40)
<3>ata1.01: COMRESET failed (errno=-5)
<4>ata1.01: failed to read SCR 0 (Emask=0x40)
<4>ata1.01: failed to read SCR 0 (Emask=0x40)
<3>ata1.01: reset failed, giving up
<6>ata1.15: hard resetting link
<6>ata1.15: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
<6>ata1.00: hard resetting link
<4>ata1.15: qc timeout (cmd 0xe4)
<4>ata1.00: failed to read SCR 0 (Emask=0x4)
<4>ata1.00: failed to read SCR 0 (Emask=0x40)
<4>ata1.00: failed to read SCR 0 (Emask=0x40)
<4>ata1.00: failed to read SCR 1 (Emask=0x40)
<4>ata1.00: failed to read SCR 0 (Emask=0x40)
<6>ata1.01: hard resetting link
<4>ata1.01: failed to read SCR 2 (Emask=0x40)
<4>ata1.01: failed to read SCR 2 (Emask=0x40)
<3>ata1.01: COMRESET failed (errno=-5)
<4>ata1.01: failed to read SCR 0 (Emask=0x40)
<4>ata1.01: failed to read SCR 0 (Emask=0x40)
<3>ata1.01: reset failed, giving up
<4>ata1.01: failed to recover link after 3 tries, disabling

Over and over until it finally times out and gets ignored.

It is connected to an external raid NAS over esata.  It first sees the
external device with PMP capabilities, but I have it configured for
raid-5, so once it is detected and initialized correctly (with another
kernel), it comes up as a single device properly.  With a 2.6.32
kernel, it comes up, but gets plenty of errors, and eventually ends in
ext4 filesystem corruption.


Sep  9 01:19:20 backend-0 kernel: [  799.980198] ata1.14: failed to
read SCR 1 (Emask=0x40)
Sep  9 01:19:20 backend-0 kernel: [  799.980213] ata1.15: exception
Emask 0x6 SAct 0x0 SErr 0x280401 action 0x6 frozen
Sep  9 01:19:20 backend-0 kernel: [  799.980223] ata1.15: SError: {
RecovData Proto 10B8B BadCRC }
Sep  9 01:19:20 backend-0 kernel: [  799.980232] ata1.00: exception
Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
Sep  9 01:19:20 backend-0 kernel: [  799.980240] ata1.00: failed
command: WRITE DMA EXT
Sep  9 01:19:20 backend-0 kernel: [  799.980254] ata1.00: cmd
35/00:08:78:0c:9d/00:00:9a:02:00/e0 tag 0 dma 4096 out
Sep  9 01:19:20 backend-0 kernel: [  799.980257]          res
40/00:fe:00:00:00/00:00:00:00:00/40 Emask 0x4 (timeout)
Sep  9 01:19:20 backend-0 kernel: [  799.980263] ata1.00: status: { DRDY }
Sep  9 01:19:20 backend-0 kernel: [  799.980270] ata1.01: exception
Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
Sep  9 01:19:20 backend-0 kernel: [  799.980278] ata1.02: exception
Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
Sep  9 01:19:20 backend-0 kernel: [  799.980286] ata1.03: exception
Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen

I might add I have had 2 of these now - I initially thought the first
one was bad, so had it replaced from the manufacturer to end up with
the same issues on the replacement.

So, I then tried with a 2.6.35.4 kernel and have the same issue, but
it is 50/50 whether it has the boot error and unrecognizes the device,
or boots, and then has the errors.  I have not experienced the file
system corruption with 2.6.35, but it will hang the system for
extended periods of "waits" for disk access.

So, I tried a 2.6.36-rc3 kernel, and for 3 days and several boots now,
all of the issues are gone and the system is running perfect.  I have
no git fu, but I browsed the linux-ide repository to see if I could
find a specific patch and try to backport it, but it seems that the
entire ahci/libahci code changed/merged sometime in 2.6.35, and no
specific patches for my chipset.  There were some patches related to
(not)resetting the link and PMP, etc though.

My only issue is I cannot run a 2.6.36 kernel since it breaks my UPS
driver, VMWare server modules, and LIRC modules..

Does anyone know how far back I can take this working libahci/ahci
code?  I would really like to get it running in centos - 2.6.19, but I
assume that's a no go..  2.6.32 would be ideal, but I guess I could
live with 2.6.35 since there are patches floating around to make all
of my aforementioned stuff work.

I'm no coder, so modifying patches is not really an option for me
either.  Most I can do is patch and make some config changes and
compile if need be.

Thanks for any insight.  Full dmesg on successful 2.6.36-rc3 follows
in case it help in any way.

Thanks!

-Greg

[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Linux version 2.6.36-020636rc3-generic (root@zinc) (gcc
version 4.2.3 (Ubuntu 4.2.3-2ubuntu7)) #201008300905 SMP Mon Aug 30
09:08:54 UTC 2010
[    0.000000] Command line:
BOOT_IMAGE=/vmlinuz-2.6.36-020636rc3-generic
root=/dev/mapper/VG_OS-ROOT ro
[    0.000000] BIOS-provided physical RAM map:
[    0.000000]  BIOS-e820: 0000000000000000 - 000000000009f000 (usable)
[    0.000000]  BIOS-e820: 000000000009f000 - 00000000000a0000 (reserved)
[    0.000000]  BIOS-e820: 00000000000e6000 - 0000000000100000 (reserved)
[    0.000000]  BIOS-e820: 0000000000100000 - 00000000dfeb0000 (usable)
[    0.000000]  BIOS-e820: 00000000dfeb0000 - 00000000dfebe000 (ACPI data)
[    0.000000]  BIOS-e820: 00000000dfebe000 - 00000000dfee0000 (ACPI NVS)
[    0.000000]  BIOS-e820: 00000000dfee0000 - 00000000dff00000 (reserved)
[    0.000000]  BIOS-e820: 00000000fff00000 - 0000000100000000 (reserved)
[    0.000000]  BIOS-e820: 0000000100000000 - 000000011c000000 (usable)
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] DMI present.
[    0.000000] AMI BIOS detected: BIOS may corrupt low RAM, working around it.
[    0.000000] e820 update range: 0000000000000000 - 0000000000010000
(usable) ==> (reserved)
[    0.000000] e820 update range: 0000000000000000 - 0000000000001000
(usable) ==> (reserved)
[    0.000000] e820 remove range: 00000000000a0000 - 0000000000100000 (usable)
[    0.000000] No AGP bridge found
[    0.000000] last_pfn = 0x11c000 max_arch_pfn = 0x400000000
[    0.000000] MTRR default type: uncachable
[    0.000000] MTRR fixed ranges enabled:
[    0.000000]   00000-9FFFF write-back
[    0.000000]   A0000-EFFFF uncachable
[    0.000000]   F0000-FFFFF write-protect
[    0.000000] MTRR variable ranges enabled:
[    0.000000]   0 base 000000000000 mask FFFF80000000 write-back
[    0.000000]   1 base 000080000000 mask FFFFC0000000 write-back
[    0.000000]   2 base 0000C0000000 mask FFFFE0000000 write-back
[    0.000000]   3 disabled
[    0.000000]   4 disabled
[    0.000000]   5 disabled
[    0.000000]   6 disabled
[    0.000000]   7 disabled
[    0.000000] TOM2: 0000000120000000 aka 4608M
[    0.000000] x86 PAT enabled: cpu 0, old 0x7040600070406, new 0x7010600070106
[    0.000000] e820 update range: 00000000e0000000 - 0000000100000000
(usable) ==> (reserved)
[    0.000000] last_pfn = 0xdfeb0 max_arch_pfn = 0x400000000
[    0.000000] Scanning 0 areas for low memory corruption
[    0.000000] modified physical RAM map:
[    0.000000]  modified: 0000000000000000 - 0000000000010000 (reserved)
[    0.000000]  modified: 0000000000010000 - 000000000009f000 (usable)
[    0.000000]  modified: 000000000009f000 - 00000000000a0000 (reserved)
[    0.000000]  modified: 00000000000e6000 - 0000000000100000 (reserved)
[    0.000000]  modified: 0000000000100000 - 00000000dfeb0000 (usable)
[    0.000000]  modified: 00000000dfeb0000 - 00000000dfebe000 (ACPI data)
[    0.000000]  modified: 00000000dfebe000 - 00000000dfee0000 (ACPI NVS)
[    0.000000]  modified: 00000000dfee0000 - 00000000dff00000 (reserved)
[    0.000000]  modified: 00000000fff00000 - 0000000100000000 (reserved)
[    0.000000]  modified: 0000000100000000 - 000000011c000000 (usable)
[    0.000000] initial memory mapped : 0 - 20000000
[    0.000000] found SMP MP-table at [ffff8800000ff780] ff780
[    0.000000] Using GB pages for direct mapping
[    0.000000] init_memory_mapping: 0000000000000000-00000000dfeb0000
[    0.000000]  0000000000 - 00c0000000 page 1G
[    0.000000]  00c0000000 - 00dfe00000 page 2M
[    0.000000]  00dfe00000 - 00dfeb0000 page 4k
[    0.000000] kernel direct mapping tables up to dfeb0000 @ 16000-19000
[    0.000000] init_memory_mapping: 0000000100000000-000000011c000000
[    0.000000]  0100000000 - 011c000000 page 2M
[    0.000000] kernel direct mapping tables up to 11c000000 @ 18000-1a000
[    0.000000] RAMDISK: 37696000 - 37ff0000
[    0.000000] ACPI: RSDP 00000000000faed0 00024 (v02 ACPIAM)
[    0.000000] ACPI: XSDT 00000000dfeb0100 0005C (v01 070210 XSDT1821
20100702 MSFT 00000097)
[    0.000000] ACPI: FACP 00000000dfeb0290 000F4 (v03 070210 FACP1821
20100702 MSFT 00000097)
[    0.000000] ACPI Warning: Optional field Pm2ControlBlock has zero
address or length: 0x0000000000000000/0x1 (20100702/tbfadt-557)
[    0.000000] ACPI: DSDT 00000000dfeb0450 09E38 (v01  88PEP 88PEP702
00000001 INTL 20051117)
[    0.000000] ACPI: FACS 00000000dfebe000 00040
[    0.000000] ACPI: APIC 00000000dfeb0390 0007C (v01 070210 APIC1821
20100702 MSFT 00000097)
[    0.000000] ACPI: MCFG 00000000dfeb0410 0003C (v01 070210 OEMMCFG
20100702 MSFT 00000097)
[    0.000000] ACPI: OEMB 00000000dfebe040 00072 (v01 070210 OEMB1821
20100702 MSFT 00000097)
[    0.000000] ACPI: SRAT 00000000dfeba290 000E8 (v03 AMD    FAM_F_10
00000002 AMD  00000001)
[    0.000000] ACPI: HPET 00000000dfeba380 00038 (v01 070210 OEMHPET
20100702 MSFT 00000097)
[    0.000000] ACPI: SSDT 00000000dfeba3c0 0088C (v01 A M I  POWERNOW
00000001 AMD  00000001)
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] SRAT: PXM 0 -> APIC 0x00 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x01 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x02 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x03 -> Node 0
[    0.000000] SRAT: Node 0 PXM 0 0-a0000
[    0.000000] SRAT: Node 0 PXM 0 100000-e0000000
[    0.000000] SRAT: Node 0 PXM 0 100000000-120000000
[    0.000000] SRAT: Node 0 [0,a0000) + [100000,e0000000) -> [0,e0000000)
[    0.000000] SRAT: Node 0 [0,e0000000) + [100000000,120000000) ->
[0,120000000)
[    0.000000] NUMA: Using 63 for the hash shift.
[    0.000000] Initmem setup node 0 0000000000000000-000000011c000000
[    0.000000]   NODE_DATA [0000000100000000 - 0000000100004fff]
[    0.000000]  [ffffea0000000000-ffffea0003ffffff] PMD ->
[ffff880100200000-ffff880103bfffff] on node 0
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA      0x00000010 -> 0x00001000
[    0.000000]   DMA32    0x00001000 -> 0x00100000
[    0.000000]   Normal   0x00100000 -> 0x0011c000
[    0.000000] Movable zone start PFN for each node
[    0.000000] early_node_map[3] active PFN ranges
[    0.000000]     0: 0x00000010 -> 0x0000009f
[    0.000000]     0: 0x00000100 -> 0x000dfeb0
[    0.000000]     0: 0x00100000 -> 0x0011c000
[    0.000000] On node 0 totalpages: 1031743
[    0.000000]   DMA zone: 56 pages used for memmap
[    0.000000]   DMA zone: 0 pages reserved
[    0.000000]   DMA zone: 3927 pages, LIFO batch:0
[    0.000000]   DMA32 zone: 14280 pages used for memmap
[    0.000000]   DMA32 zone: 898792 pages, LIFO batch:31
[    0.000000]   Normal zone: 1568 pages used for memmap
[    0.000000]   Normal zone: 113120 pages, LIFO batch:31
[    0.000000] ACPI: PM-Timer IO Port: 0x808
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x03] lapic_id[0x02] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x04] lapic_id[0x03] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x05] lapic_id[0x84] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x06] lapic_id[0x85] disabled)
[    0.000000] ACPI: IOAPIC (id[0x04] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 4, version 33, address 0xfec00000, GSI 0-23
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ2 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] ACPI: HPET id: 0x8300 base: 0xfed00000
[    0.000000] SMP: Allowing 6 CPUs, 2 hotplug CPUs
[    0.000000] nr_irqs_gsi: 40
[    0.000000] early_res array is doubled to 64 at [19000 - 197ff]
[    0.000000] PM: Registered nosave memory: 000000000009f000 - 00000000000a0000
[    0.000000] PM: Registered nosave memory: 00000000000a0000 - 00000000000e6000
[    0.000000] PM: Registered nosave memory: 00000000000e6000 - 0000000000100000
[    0.000000] PM: Registered nosave memory: 00000000dfeb0000 - 00000000dfebe000
[    0.000000] PM: Registered nosave memory: 00000000dfebe000 - 00000000dfee0000
[    0.000000] PM: Registered nosave memory: 00000000dfee0000 - 00000000dff00000
[    0.000000] PM: Registered nosave memory: 00000000dff00000 - 00000000fff00000
[    0.000000] PM: Registered nosave memory: 00000000fff00000 - 0000000100000000
[    0.000000] Allocating PCI resources starting at dff00000 (gap:
dff00000:20000000)
[    0.000000] Booting paravirtualized kernel on bare hardware
[    0.000000] setup_percpu: NR_CPUS:64 nr_cpumask_bits:64
nr_cpu_ids:6 nr_node_ids:1
[    0.000000] PERCPU: Embedded 29 pages/cpu @ffff880001e00000 s88384
r8192 d22208 u262144
[    0.000000] pcpu-alloc: s88384 r8192 d22208 u262144 alloc=1*2097152
[    0.000000] pcpu-alloc: [0] 0 1 2 3 4 5 - -
[    0.000000] Built 1 zonelists in Node order, mobility grouping on.
Total pages: 1015839
[    0.000000] Policy zone: Normal
[    0.000000] Kernel command line:
BOOT_IMAGE=/vmlinuz-2.6.36-020636rc3-generic
root=/dev/mapper/VG_OS-ROOT ro
[    0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
[    0.000000] Checking aperture...
[    0.000000] No AGP bridge found
[    0.000000] Node 0: aperture @ 4000000 size 32 MB
[    0.000000] Aperture pointing to e820 RAM. Ignoring.
[    0.000000] Your BIOS doesn't leave a aperture memory hole
[    0.000000] Please enable the IOMMU option in the BIOS setup
[    0.000000] This costs you 64 MB of RAM
[    0.000000] Mapping aperture over 65536 KB of RAM @ 20000000
[    0.000000] PM: Registered nosave memory: 0000000020000000 - 0000000024000000
[    0.000000] early_res array is doubled to 128 at [19800 - 1a7ff]
[    0.000000] Subtract (59 early reservations)
[    0.000000]   #1 [0001000000 - 0001d2bde0]   TEXT DATA BSS
[    0.000000]   #2 [0037696000 - 0037ff0000]         RAMDISK
[    0.000000]   #3 [0001d2c000 - 0001d2c177]             BRK
[    0.000000]   #4 [00000ff790 - 0000100000]   BIOS reserved
[    0.000000]   #5 [00000ff780 - 00000ff790]    MP-table mpf
[    0.000000]   #6 [000009f000 - 00000fd670]   BIOS reserved
[    0.000000]   #7 [00000fd7dc - 00000ff780]   BIOS reserved
[    0.000000]   #8 [00000fd670 - 00000fd7dc]    MP-table mpc
[    0.000000]   #9 [0000010000 - 0000012000]      TRAMPOLINE
[    0.000000]   #10 [0000012000 - 0000016000]     ACPI WAKEUP
[    0.000000]   #11 [0000016000 - 0000018000]         PGTABLE
[    0.000000]   #12 [0000018000 - 0000019000]         PGTABLE
[    0.000000]   #13 [0100000000 - 0100005000]       NODE_DATA
[    0.000000]   #14 [0001d2c180 - 0001d2d180]         BOOTMEM
[    0.000000]   #15 [000212d180 - 000212d480]         BOOTMEM
[    0.000000]   #16 [0100005000 - 0100006000]         BOOTMEM
[    0.000000]   #17 [0100006000 - 0100007000]         BOOTMEM
[    0.000000]   #18 [0100200000 - 0103c00000]        MEMMAP 0
[    0.000000]   #19 [0001d2be00 - 0001d2bf80]         BOOTMEM
[    0.000000]   #20 [0001d2d180 - 0001d45180]         BOOTMEM
[    0.000000]   #21 [0001d45180 - 0001d48180]         BOOTMEM
[    0.000000]   #22 [0001d49000 - 0001d4a000]         BOOTMEM
[    0.000000]   #23 [0001d2bf80 - 0001d2bfc1]         BOOTMEM
[    0.000000]   #24 [0001d48180 - 0001d481c3]         BOOTMEM
[    0.000000]   #25 [0001d48200 - 0001d48430]         BOOTMEM
[    0.000000]   #26 [0001d48440 - 0001d484a8]         BOOTMEM
[    0.000000]   #27 [0001d484c0 - 0001d48528]         BOOTMEM
[    0.000000]   #28 [0001d48540 - 0001d485a8]         BOOTMEM
[    0.000000]   #29 [0001d485c0 - 0001d48628]         BOOTMEM
[    0.000000]   #30 [0001d48640 - 0001d486a8]         BOOTMEM
[    0.000000]   #31 [0001d486c0 - 0001d48728]         BOOTMEM
[    0.000000]   #32 [0001d48740 - 0001d487a8]         BOOTMEM
[    0.000000]   #33 [0001d487c0 - 0001d48828]         BOOTMEM
[    0.000000]   #34 [0001d48840 - 0001d488a8]         BOOTMEM
[    0.000000]   #35 [0001d488c0 - 0001d488e0]         BOOTMEM
[    0.000000]   #36 [0001d48900 - 0001d48920]         BOOTMEM
[    0.000000]   #37 [0001d48940 - 0001d4898c]         BOOTMEM
[    0.000000]   #38 [0001d489c0 - 0001d48a0c]         BOOTMEM
[    0.000000]   #39 [0001e00000 - 0001e1d000]         BOOTMEM
[    0.000000]   #40 [0001e40000 - 0001e5d000]         BOOTMEM
[    0.000000]   #41 [0001e80000 - 0001e9d000]         BOOTMEM
[    0.000000]   #42 [0001ec0000 - 0001edd000]         BOOTMEM
[    0.000000]   #43 [0001f00000 - 0001f1d000]         BOOTMEM
[    0.000000]   #44 [0001f40000 - 0001f5d000]         BOOTMEM
[    0.000000]   #45 [0001d48a40 - 0001d48a48]         BOOTMEM
[    0.000000]   #46 [0001d48a80 - 0001d48a88]         BOOTMEM
[    0.000000]   #47 [0001d48ac0 - 0001d48ad8]         BOOTMEM
[    0.000000]   #48 [0001d48b00 - 0001d48b30]         BOOTMEM
[    0.000000]   #49 [0001d48b40 - 0001d48c60]         BOOTMEM
[    0.000000]   #50 [0001d48c80 - 0001d48cc8]         BOOTMEM
[    0.000000]   #51 [0001d48d00 - 0001d48d48]         BOOTMEM
[    0.000000]   #52 [0001d4a000 - 0001d52000]         BOOTMEM
[    0.000000]   #53 [0020000000 - 0024000000]         BOOTMEM
[    0.000000]   #54 [0001d48d80 - 0001d48da0]         BOOTMEM
[    0.000000]   #55 [000212e000 - 000612e000]         BOOTMEM
[    0.000000]   #56 [0001d52000 - 0001d72000]         BOOTMEM
[    0.000000]   #57 [0001d72000 - 0001db2000]         BOOTMEM
[    0.000000]   #58 [000001a800 - 0000022800]         BOOTMEM
[    0.000000] Memory: 3912108k/4653056k available (5696k kernel code,
526084k absent, 214864k reserved, 5377k data, 988k init)
[    0.000000] SLUB: Genslabs=14, HWalign=64, Order=0-3, MinObjects=0,
CPUs=6, Nodes=1
[    0.000000] Hierarchical RCU implementation.
[    0.000000] 	RCU dyntick-idle grace-period acceleration is enabled.
[    0.000000] 	RCU-based detection of stalled CPUs is disabled.
[    0.000000] 	Verbose stalled-CPUs detection is disabled.
[    0.000000] NR_IRQS:4352 nr_irqs:728
[    0.000000] Extended CMOS year: 2000
[    0.000000] spurious 8259A interrupt: IRQ7.
[    0.000000] Console: colour VGA+ 80x25
[    0.000000] console [tty0] enabled
[    0.000000] allocated 41943040 bytes of page_cgroup
[    0.000000] please try 'cgroup_disable=memory' option if you don't
want memory cgroups
[    0.000000] hpet clockevent registered
[    0.000000] Fast TSC calibration using PIT
[    0.000000] Detected 2999.951 MHz processor.
[    0.030008] Calibrating delay loop (skipped), value calculated
using timer frequency.. 5999.89 BogoMIPS (lpj=29999470)
[    0.030074] pid_max: default: 32768 minimum: 301
[    0.030122] Security Framework initialized
[    0.030168] AppArmor: AppArmor initialized
[    0.030507] Dentry cache hash table entries: 524288 (order: 10,
4194304 bytes)
[    0.031746] Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes)
[    0.032317] Mount-cache hash table entries: 256
[    0.032448] Initializing cgroup subsys ns
[    0.032486] Initializing cgroup subsys cpuacct
[    0.032519] Initializing cgroup subsys memory
[    0.032558] Initializing cgroup subsys devices
[    0.032590] Initializing cgroup subsys freezer
[    0.032622] Initializing cgroup subsys net_cls
[    0.032675] tseg: 0000000000
[    0.032685] CPU: Physical Processor ID: 0
[    0.032717] CPU: Processor Core ID: 0
[    0.032750] mce: CPU supports 6 MCE banks
[    0.032788] Performance Events: AMD PMU driver.
[    0.032850] ... version:                0
[    0.032882] ... bit width:              48
[    0.032914] ... generic registers:      4
[    0.032946] ... value mask:             0000ffffffffffff
[    0.032978] ... max period:             00007fffffffffff
[    0.033011] ... fixed-purpose events:   0
[    0.033043] ... event mask:             000000000000000f
[    0.034466] ACPI: Core revision 20100702
[    0.050006] ftrace: converting mcount calls to 0f 1f 44 00 00
[    0.050041] ftrace: allocating 27106 entries in 107 pages
[    0.056519] Setting APIC routing to flat
[    0.056855] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.159828] CPU0: AMD Phenom(tm) II X4 945 Processor stepping 03
[    0.160000] Booting Node   0, Processors  #1 #2 #3
[    0.660005] Brought up 4 CPUs
[    0.660069] Total of 4 processors activated (24001.01 BogoMIPS).
[    0.661898] devtmpfs: initialized
[    0.661898] regulator: core version 0.5
[    0.661898] Time: 16:38:11  Date: 09/17/10
[    0.661898] NET: Registered protocol family 16
[    0.661898] node 0 link 0: io port [1000, ffffff]
[    0.661898] TOM: 00000000e0000000 aka 3584M
[    0.661898] Fam 10h mmconf [e0000000, efffffff]
[    0.661898] node 0 link 0: mmio [a0000, bffff]
[    0.661898] node 0 link 0: mmio [e0000000, efffffff] ==> none
[    0.661898] node 0 link 0: mmio [f0000000, f7ffffff]
[    0.661898] node 0 link 0: mmio [f8000000, fbffffff]
[    0.661898] node 0 link 0: mmio [fc000000, fe8fffff]
[    0.661898] node 0 link 0: mmio [fe900000, feafffff]
[    0.661898] node 0 link 0: mmio [feb00000, ffefffff]
[    0.661898] TOM2: 0000000120000000 aka 4608M
[    0.661898] bus: [00, 07] on node 0 link 0
[    0.661898] bus: 00 index 0 [io  0x0000-0xffff]
[    0.661898] bus: 00 index 1 [mem 0x000a0000-0x000bffff]
[    0.661898] bus: 00 index 2 [mem 0xf0000000-0xffffffff]
[    0.661898] bus: 00 index 3 [mem 0x120000000-0xfcffffffff]
[    0.661898] ACPI: bus type pci registered
[    0.661898] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem
0xe0000000-0xefffffff] (base 0xe0000000)
[    0.661898] PCI: not using MMCONFIG
[    0.661898] PCI: Using configuration type 1 for base access
[    0.661898] PCI: Using configuration type 1 for extended access
[    0.661898] bio: create slab <bio-0> at 0
[    0.661898] ACPI: EC: Look up EC in DSDT
[    0.661944] ACPI: Executed 4 blocks of module-level executable AML code
[    0.670417] ACPI: Interpreter enabled
[    0.670450] ACPI: (supports S0 S3 S4 S5)
[    0.670606] ACPI: Using IOAPIC for interrupt routing
[    0.670665] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem
0xe0000000-0xefffffff] (base 0xe0000000)
[    0.672419] PCI: MMCONFIG at [mem 0xe0000000-0xefffffff] reserved
in ACPI motherboard resources
[    0.693136] ACPI: No dock devices found.
[    0.693174] PCI: Using host bridge windows from ACPI; if necessary,
use "pci=nocrs" and report a bug
[    0.693306] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.693535] pci_root PNP0A03:00: host bridge window [io  0x0000-0x0cf7]
[    0.693581] pci_root PNP0A03:00: host bridge window [io  0x0d00-0xffff]
[    0.693615] pci_root PNP0A03:00: host bridge window [mem
0x000a0000-0x000bffff]
[    0.693650] pci_root PNP0A03:00: host bridge window [mem
0x000d0000-0x000dffff]
[    0.693685] pci_root PNP0A03:00: host bridge window [mem
0xdff00000-0xdfffffff]
[    0.693720] pci_root PNP0A03:00: host bridge window [mem
0xf0000000-0xfebfffff]
[    0.693854] pci 0000:00:07.0: PME# supported from D0 D3hot D3cold
[    0.693856] pci 0000:00:07.0: PME# disabled
[    0.693901] pci 0000:00:11.0: reg 10: [io  0xc000-0xc007]
[    0.693910] pci 0000:00:11.0: reg 14: [io  0xb000-0xb003]
[    0.693919] pci 0000:00:11.0: reg 18: [io  0xa000-0xa007]
[    0.693928] pci 0000:00:11.0: reg 1c: [io  0x9000-0x9003]
[    0.693937] pci 0000:00:11.0: reg 20: [io  0x8000-0x800f]
[    0.693946] pci 0000:00:11.0: reg 24: [mem 0xfe8ffc00-0xfe8fffff]
[    0.693998] pci 0000:00:12.0: reg 10: [mem 0xfe8fe000-0xfe8fefff]
[    0.694069] pci 0000:00:12.1: reg 10: [mem 0xfe8fd000-0xfe8fdfff]
[    0.694151] pci 0000:00:12.2: reg 10: [mem 0xfe8ff800-0xfe8ff8ff]
[    0.694216] pci 0000:00:12.2: supports D1 D2
[    0.694218] pci 0000:00:12.2: PME# supported from D0 D1 D2 D3hot
[    0.694221] pci 0000:00:12.2: PME# disabled
[    0.694252] pci 0000:00:13.0: reg 10: [mem 0xfe8fc000-0xfe8fcfff]
[    0.694322] pci 0000:00:13.1: reg 10: [mem 0xfe8f7000-0xfe8f7fff]
[    0.694402] pci 0000:00:13.2: reg 10: [mem 0xfe8ff400-0xfe8ff4ff]
[    0.694468] pci 0000:00:13.2: supports D1 D2
[    0.694469] pci 0000:00:13.2: PME# supported from D0 D1 D2 D3hot
[    0.694473] pci 0000:00:13.2: PME# disabled
[    0.694594] pci 0000:00:14.1: reg 10: [io  0x0000-0x0007]
[    0.694603] pci 0000:00:14.1: reg 14: [io  0x0000-0x0003]
[    0.694611] pci 0000:00:14.1: reg 18: [io  0x0000-0x0007]
[    0.694620] pci 0000:00:14.1: reg 1c: [io  0x0000-0x0003]
[    0.694629] pci 0000:00:14.1: reg 20: [io  0xff00-0xff0f]
[    0.694693] pci 0000:00:14.2: reg 10: [mem 0xfe8f0000-0xfe8f3fff 64bit]
[    0.694748] pci 0000:00:14.2: PME# supported from D0 D3hot D3cold
[    0.694752] pci 0000:00:14.2: PME# disabled
[    0.694879] pci 0000:00:14.5: reg 10: [mem 0xfe8f6000-0xfe8f6fff]
[    0.695020] pci 0000:01:05.0: reg 10: [mem 0xf8000000-0xfbffffff pref]
[    0.695024] pci 0000:01:05.0: reg 14: [io  0xd000-0xd0ff]
[    0.695028] pci 0000:01:05.0: reg 18: [mem 0xfeaf0000-0xfeafffff]
[    0.695037] pci 0000:01:05.0: reg 24: [mem 0xfe900000-0xfe9fffff]
[    0.695047] pci 0000:01:05.0: supports D1 D2
[    0.695061] pci 0000:01:05.1: reg 10: [mem 0xfeae8000-0xfeaebfff]
[    0.695083] pci 0000:01:05.1: supports D1 D2
[    0.695121] pci 0000:00:01.0: PCI bridge to [bus 01-01]
[    0.695155] pci 0000:00:01.0:   bridge window [io  0xd000-0xdfff]
[    0.695157] pci 0000:00:01.0:   bridge window [mem 0xfe900000-0xfeafffff]
[    0.695161] pci 0000:00:01.0:   bridge window [mem
0xf8000000-0xfbffffff 64bit pref]
[    0.695202] pci 0000:02:00.0: reg 10: [io  0xe800-0xe8ff]
[    0.695221] pci 0000:02:00.0: reg 18: [mem 0xfdfff000-0xfdffffff 64bit pref]
[    0.695234] pci 0000:02:00.0: reg 20: [mem 0xfdff8000-0xfdffbfff 64bit pref]
[    0.695243] pci 0000:02:00.0: reg 30: [mem 0xfebe0000-0xfebfffff pref]
[    0.695269] pci 0000:02:00.0: supports D1 D2
[    0.695270] pci 0000:02:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.695274] pci 0000:02:00.0: PME# disabled
[    0.710018] pci 0000:00:07.0: PCI bridge to [bus 02-02]
[    0.710059] pci 0000:00:07.0:   bridge window [io  0xe000-0xefff]
[    0.710062] pci 0000:00:07.0:   bridge window [mem 0xfeb00000-0xfebfffff]
[    0.710065] pci 0000:00:07.0:   bridge window [mem
0xfdf00000-0xfdffffff 64bit pref]
[    0.710129] pci 0000:00:14.4: PCI bridge to [bus 03-03] (subtractive decode)
[    0.710165] pci 0000:00:14.4:   bridge window [io  0xf000-0x0000] (disabled)
[    0.710169] pci 0000:00:14.4:   bridge window [mem
0xfff00000-0x000fffff] (disabled)
[    0.710173] pci 0000:00:14.4:   bridge window [mem
0xfff00000-0x000fffff pref] (disabled)
[    0.710175] pci 0000:00:14.4:   bridge window [io  0x0000-0x0cf7]
(subtractive decode)
[    0.710177] pci 0000:00:14.4:   bridge window [io  0x0d00-0xffff]
(subtractive decode)
[    0.710179] pci 0000:00:14.4:   bridge window [mem
0x000a0000-0x000bffff] (subtractive decode)
[    0.710180] pci 0000:00:14.4:   bridge window [mem
0x000d0000-0x000dffff] (subtractive decode)
[    0.710182] pci 0000:00:14.4:   bridge window [mem
0xdff00000-0xdfffffff] (subtractive decode)
[    0.710184] pci 0000:00:14.4:   bridge window [mem
0xf0000000-0xfebfffff] (subtractive decode)
[    0.710196] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[    0.710346] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P1._PRT]
[    0.710393] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0PC._PRT]
[    0.710441] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCE7._PRT]
[    0.710462] Unable to assume PCIe control: Disabling ASPM
[    0.713405] ACPI: PCI Interrupt Link [LNKA] (IRQs 4 *7 10 11 12 14 15)
[    0.713729] ACPI: PCI Interrupt Link [LNKB] (IRQs *4 7 10 11 12 14 15)
[    0.714050] ACPI: PCI Interrupt Link [LNKC] (IRQs 4 7 10 *11 12 14 15)
[    0.714370] ACPI: PCI Interrupt Link [LNKD] (IRQs 4 7 *10 11 12 14 15)
[    0.714689] ACPI: PCI Interrupt Link [LNKE] (IRQs 4 7 10 11 12 14
15) *0, disabled.
[    0.715067] ACPI: PCI Interrupt Link [LNKF] (IRQs 4 7 10 11 12 14
15) *0, disabled.
[    0.715445] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 *9 10 11 12 14 15)
[    0.715821] ACPI: PCI Interrupt Link [LNKH] (IRQs 4 7 10 11 12 14
15) *0, disabled.
[    0.716177] HEST: Table is not found!
[    0.716257] vgaarb: device added:
PCI:0000:01:05.0,decodes=io+mem,owns=io+mem,locks=none
[    0.716296] vgaarb: loaded
[    0.716408] SCSI subsystem initialized
[    0.716453] libata version 3.00 loaded.
[    0.716453] usbcore: registered new interface driver usbfs
[    0.716453] usbcore: registered new interface driver hub
[    0.716453] usbcore: registered new device driver usb
[    0.716453] ACPI: WMI: Mapper loaded
[    0.716453] PCI: Using ACPI for IRQ routing
[    0.716453] PCI: pci_cache_line_size set to 64 bytes
[    0.716453] reserve RAM buffer: 000000000009f000 - 000000000009ffff
[    0.716453] reserve RAM buffer: 00000000dfeb0000 - 00000000dfffffff
[    0.716453] NetLabel: Initializing
[    0.716453] NetLabel:  domain hash size = 128
[    0.716453] NetLabel:  protocols = UNLABELED CIPSOv4
[    0.716453] NetLabel:  unlabeled traffic allowed by default
[    0.716453] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0
[    0.716453] hpet0: 4 comparators, 32-bit 14.318180 MHz counter
[    0.716453] Switching to clocksource tsc
[    0.716453] AppArmor: AppArmor Filesystem Enabled
[    0.716453] pnp: PnP ACPI init
[    0.716453] ACPI: bus type pnp registered
[    0.716453] pnp: PnP ACPI: found 12 devices
[    0.716453] ACPI: ACPI bus type pnp unregistered
[    0.716453] system 00:07: [mem 0xfec00000-0xfec00fff] could not be reserved
[    0.716453] system 00:07: [mem 0xfee00000-0xfee00fff] has been reserved
[    0.716453] system 00:08: [io  0x04d0-0x04d1] has been reserved
[    0.716453] system 00:08: [io  0x040b] has been reserved
[    0.716453] system 00:08: [io  0x04d6] has been reserved
[    0.716453] system 00:08: [io  0x0c00-0x0c01] has been reserved
[    0.716457] system 00:08: [io  0x0c14] has been reserved
[    0.716490] system 00:08: [io  0x0c50-0x0c51] has been reserved
[    0.716523] system 00:08: [io  0x0c52] has been reserved
[    0.716556] system 00:08: [io  0x0c6c] has been reserved
[    0.716589] system 00:08: [io  0x0c6f] has been reserved
[    0.716622] system 00:08: [io  0x0cd0-0x0cd1] has been reserved
[    0.716656] system 00:08: [io  0x0cd2-0x0cd3] has been reserved
[    0.716689] system 00:08: [io  0x0cd4-0x0cd5] has been reserved
[    0.716723] system 00:08: [io  0x0cd6-0x0cd7] has been reserved
[    0.716756] system 00:08: [io  0x0cd8-0x0cdf] has been reserved
[    0.716789] system 00:08: [io  0x0800-0x089f] has been reserved
[    0.716823] system 00:08: [io  0x0b00-0x0b0f] has been reserved
[    0.716856] system 00:08: [io  0x0b20-0x0b3f] has been reserved
[    0.716889] system 00:08: [io  0x0900-0x090f] has been reserved
[    0.716923] system 00:08: [io  0x0910-0x091f] has been reserved
[    0.716956] system 00:08: [io  0xfe00-0xfefe] has been reserved
[    0.716990] system 00:08: [mem 0xffb80000-0xffbfffff] has been reserved
[    0.717024] system 00:08: [mem 0xfec10000-0xfec1001f] has been reserved
[    0.717059] system 00:09: [io  0x0a00-0x0a0f] has been reserved
[    0.717093] system 00:09: [io  0x0a10-0x0a1f] has been reserved
[    0.717126] system 00:09: [io  0x0a20-0x0a2f] has been reserved
[    0.717159] system 00:09: [io  0x0a30-0x0a3f] has been reserved
[    0.717194] system 00:0a: [mem 0xe0000000-0xefffffff] has been reserved
[    0.717229] system 00:0b: [mem 0x00000000-0x0009ffff] could not be reserved
[    0.717263] system 00:0b: [mem 0x000c0000-0x000cffff] has been reserved
[    0.717297] system 00:0b: [mem 0x000e0000-0x000fffff] could not be reserved
[    0.717331] system 00:0b: [mem 0x00100000-0xdfefffff] could not be reserved
[    0.717365] system 00:0b: [mem 0xfec00000-0xffffffff] could not be reserved
[    0.722809] pci 0000:00:01.0: PCI bridge to [bus 01-01]
[    0.722843] pci 0000:00:01.0:   bridge window [io  0xd000-0xdfff]
[    0.722877] pci 0000:00:01.0:   bridge window [mem 0xfe900000-0xfeafffff]
[    0.722912] pci 0000:00:01.0:   bridge window [mem
0xf8000000-0xfbffffff 64bit pref]
[    0.722948] pci 0000:00:07.0: PCI bridge to [bus 02-02]
[    0.722981] pci 0000:00:07.0:   bridge window [io  0xe000-0xefff]
[    0.723015] pci 0000:00:07.0:   bridge window [mem 0xfeb00000-0xfebfffff]
[    0.723049] pci 0000:00:07.0:   bridge window [mem
0xfdf00000-0xfdffffff 64bit pref]
[    0.723086] pci 0000:00:14.4: PCI bridge to [bus 03-03]
[    0.723118] pci 0000:00:14.4:   bridge window [io  disabled]
[    0.723153] pci 0000:00:14.4:   bridge window [mem disabled]
[    0.723188] pci 0000:00:14.4:   bridge window [mem pref disabled]
[    0.723232]   alloc irq_desc for 19 on node 0
[    0.723233]   alloc kstat_irqs on node 0
[    0.723238] pci 0000:00:07.0: PCI INT A -> GSI 19 (level, low) -> IRQ 19
[    0.723271] pci 0000:00:07.0: setting latency timer to 64
[    0.723278] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7]
[    0.723279] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff]
[    0.723281] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff]
[    0.723283] pci_bus 0000:00: resource 7 [mem 0x000d0000-0x000dffff]
[    0.723284] pci_bus 0000:00: resource 8 [mem 0xdff00000-0xdfffffff]
[    0.723286] pci_bus 0000:00: resource 9 [mem 0xf0000000-0xfebfffff]
[    0.723287] pci_bus 0000:01: resource 0 [io  0xd000-0xdfff]
[    0.723289] pci_bus 0000:01: resource 1 [mem 0xfe900000-0xfeafffff]
[    0.723291] pci_bus 0000:01: resource 2 [mem 0xf8000000-0xfbffffff
64bit pref]
[    0.723292] pci_bus 0000:02: resource 0 [io  0xe000-0xefff]
[    0.723294] pci_bus 0000:02: resource 1 [mem 0xfeb00000-0xfebfffff]
[    0.723296] pci_bus 0000:02: resource 2 [mem 0xfdf00000-0xfdffffff
64bit pref]
[    0.723298] pci_bus 0000:03: resource 4 [io  0x0000-0x0cf7]
[    0.723299] pci_bus 0000:03: resource 5 [io  0x0d00-0xffff]
[    0.723301] pci_bus 0000:03: resource 6 [mem 0x000a0000-0x000bffff]
[    0.723302] pci_bus 0000:03: resource 7 [mem 0x000d0000-0x000dffff]
[    0.723304] pci_bus 0000:03: resource 8 [mem 0xdff00000-0xdfffffff]
[    0.723306] pci_bus 0000:03: resource 9 [mem 0xf0000000-0xfebfffff]
[    0.723328] NET: Registered protocol family 2
[    0.723466] IP route cache hash table entries: 131072 (order: 8,
1048576 bytes)
[    0.724371] TCP established hash table entries: 524288 (order: 11,
8388608 bytes)
[    0.726658] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[    0.726973] TCP: Hash tables configured (established 524288 bind 65536)
[    0.727007] TCP reno registered
[    0.727045] UDP hash table entries: 2048 (order: 4, 65536 bytes)
[    0.727107] UDP-Lite hash table entries: 2048 (order: 4, 65536 bytes)
[    0.727238] NET: Registered protocol family 1
[    0.727282] pci 0000:00:01.0: MSI quirk detected; subordinate MSI disabled
[    0.890634] pci 0000:01:05.0: Boot video device
[    0.890646] PCI: CLS 64 bytes, default 64
[    0.890692] Trying to unpack rootfs image as initramfs...
[    1.045606] Freeing initrd memory: 9576k freed
[    1.048843] PCI-DMA: Disabling AGP.
[    1.049398] PCI-DMA: aperture base @ 20000000 size 65536 KB
[    1.049431] PCI-DMA: using GART IOMMU.
[    1.049463] PCI-DMA: Reserving 64MB of IOMMU area in the AGP aperture
[    1.052853] Scanning for low memory corruption every 60 seconds
[    1.052990] audit: initializing netlink socket (disabled)
[    1.053035] type=2000 audit(1284741492.050:1): initialized
[    1.063602] HugeTLB registered 2 MB page size, pre-allocated 0 pages
[    1.064589] VFS: Disk quotas dquot_6.5.2
[    1.064660] Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    1.065110] fuse init (API version 7.15)
[    1.065197] msgmni has been set to 7788
[    1.066914] Block layer SCSI generic (bsg) driver version 0.4
loaded (major 253)
[    1.066956] io scheduler noop registered
[    1.066988] io scheduler deadline registered
[    1.067042] io scheduler cfq registered (default)
[    1.067196] pcieport 0000:00:07.0: setting latency timer to 64
[    1.067215]   alloc irq_desc for 40 on node 0
[    1.067217]   alloc kstat_irqs on node 0
[    1.067224] pcieport 0000:00:07.0: irq 40 for MSI/MSI-X
[    1.067289] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[    1.067333] pciehp: PCI Express Hot Plug Controller Driver version: 0.4
[    1.067476] input: Power Button as
/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input0
[    1.067522] ACPI: Power Button [PWRB]
[    1.067580] input: Power Button as
/devices/LNXSYSTM:00/LNXPWRBN:00/input/input1
[    1.067615] ACPI: Power Button [PWRF]
[    1.067762] ACPI: acpi_idle registered with cpuidle
[    1.069601] thermal LNXTHERM:01: registered as thermal_zone0
[    1.069640] ACPI: Thermal Zone [THRM] (41 C)
[    1.069706] ERST: Table is not found!
[    1.069851] Linux agpgart interface v0.103
[    1.069889] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    1.070722] brd: module loaded
[    1.071045] loop: module loaded
[    1.071251]   alloc irq_desc for 16 on node 0
[    1.071253]   alloc kstat_irqs on node 0
[    1.071259] pata_acpi 0000:00:14.1: PCI INT A -> GSI 16 (level,
low) -> IRQ 16
[    1.071315] pata_acpi 0000:00:14.1: setting latency timer to 64
[    1.071550] Fixed MDIO Bus: probed
[    1.071604] PPP generic driver version 2.4.2
[    1.071663] tun: Universal TUN/TAP device driver, 1.6
[    1.071696] tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
[    1.071781] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    1.071863]   alloc irq_desc for 17 on node 0
[    1.071865]   alloc kstat_irqs on node 0
[    1.071870] ehci_hcd 0000:00:12.2: PCI INT B -> GSI 17 (level, low) -> IRQ 17
[    1.071932] ehci_hcd 0000:00:12.2: EHCI Host Controller
[    1.071996] ehci_hcd 0000:00:12.2: new USB bus registered, assigned
bus number 1
[    1.072059] ehci_hcd 0000:00:12.2: debug port 1
[    1.072111] ehci_hcd 0000:00:12.2: irq 17, io mem 0xfe8ff800
[    1.090036] ehci_hcd 0000:00:12.2: USB 2.0 started, EHCI 1.00
[    1.090150] hub 1-0:1.0: USB hub found
[    1.090187] hub 1-0:1.0: 6 ports detected
[    1.090304] ehci_hcd 0000:00:13.2: PCI INT B -> GSI 19 (level, low) -> IRQ 19
[    1.090349] ehci_hcd 0000:00:13.2: EHCI Host Controller
[    1.090402] ehci_hcd 0000:00:13.2: new USB bus registered, assigned
bus number 2
[    1.090460] ehci_hcd 0000:00:13.2: debug port 1
[    1.090511] ehci_hcd 0000:00:13.2: irq 19, io mem 0xfe8ff400
[    1.110030] ehci_hcd 0000:00:13.2: USB 2.0 started, EHCI 1.00
[    1.110136] hub 2-0:1.0: USB hub found
[    1.110173] hub 2-0:1.0: 6 ports detected
[    1.110275] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    1.110345] ohci_hcd 0000:00:12.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
[    1.110391] ohci_hcd 0000:00:12.0: OHCI Host Controller
[    1.110450] ohci_hcd 0000:00:12.0: new USB bus registered, assigned
bus number 3
[    1.110508] ohci_hcd 0000:00:12.0: irq 16, io mem 0xfe8fe000
[    1.174118] hub 3-0:1.0: USB hub found
[    1.174158] hub 3-0:1.0: 3 ports detected
[    1.174276] ohci_hcd 0000:00:12.1: PCI INT A -> GSI 16 (level, low) -> IRQ 16
[    1.174320] ohci_hcd 0000:00:12.1: OHCI Host Controller
[    1.174373] ohci_hcd 0000:00:12.1: new USB bus registered, assigned
bus number 4
[    1.174422] ohci_hcd 0000:00:12.1: irq 16, io mem 0xfe8fd000
[    1.234108] hub 4-0:1.0: USB hub found
[    1.234149] hub 4-0:1.0: 3 ports detected
[    1.234266]   alloc irq_desc for 18 on node 0
[    1.234268]   alloc kstat_irqs on node 0
[    1.234272] ohci_hcd 0000:00:13.0: PCI INT A -> GSI 18 (level, low) -> IRQ 18
[    1.234317] ohci_hcd 0000:00:13.0: OHCI Host Controller
[    1.234370] ohci_hcd 0000:00:13.0: new USB bus registered, assigned
bus number 5
[    1.234425] ohci_hcd 0000:00:13.0: irq 18, io mem 0xfe8fc000
[    1.294134] hub 5-0:1.0: USB hub found
[    1.294175] hub 5-0:1.0: 3 ports detected
[    1.294291] ohci_hcd 0000:00:13.1: PCI INT A -> GSI 18 (level, low) -> IRQ 18
[    1.294335] ohci_hcd 0000:00:13.1: OHCI Host Controller
[    1.294389] ohci_hcd 0000:00:13.1: new USB bus registered, assigned
bus number 6
[    1.294438] ohci_hcd 0000:00:13.1: irq 18, io mem 0xfe8f7000
[    1.354110] hub 6-0:1.0: USB hub found
[    1.354151] hub 6-0:1.0: 3 ports detected
[    1.354269] ohci_hcd 0000:00:14.5: PCI INT C -> GSI 18 (level, low) -> IRQ 18
[    1.354314] ohci_hcd 0000:00:14.5: OHCI Host Controller
[    1.354368] ohci_hcd 0000:00:14.5: new USB bus registered, assigned
bus number 7
[    1.354416] ohci_hcd 0000:00:14.5: irq 18, io mem 0xfe8f6000
[    1.414114] hub 7-0:1.0: USB hub found
[    1.414155] hub 7-0:1.0: 2 ports detected
[    1.414250] uhci_hcd: USB Universal Host Controller Interface driver
[    1.414354] PNP: No PS/2 controller found. Probing ports directly.
[    1.414768] serio: i8042 KBD port at 0x60,0x64 irq 1
[    1.414811] serio: i8042 AUX port at 0x60,0x64 irq 12
[    1.414901] mice: PS/2 mouse device common for all mice
[    1.415011] rtc_cmos 00:03: RTC can wake from S4
[    1.415066] rtc_cmos 00:03: rtc core: registered rtc_cmos as rtc0
[    1.415121] rtc0: alarms up to one month, y3k, 114 bytes nvram, hpet irqs
[    1.415217] device-mapper: uevent: version 1.0.3
[    1.415319] device-mapper: ioctl: 4.18.0-ioctl (2010-06-29)
initialised: dm-devel@redhat.com
[    1.415394] device-mapper: multipath: version 1.1.1 loaded
[    1.415427] device-mapper: multipath round-robin: version 1.0.0 loaded
[    1.415548] cpuidle: using governor ladder
[    1.415580] cpuidle: using governor menu
[    1.415804] TCP cubic registered
[    1.415914] NET: Registered protocol family 10
[    1.416204] lo: Disabled Privacy Extensions
[    1.416386] NET: Registered protocol family 17
[    1.416431] Registering the dns_resolver key type
[    1.416503] powernow-k8: Found 1 AMD Phenom(tm) II X4 945 Processor
(4 cpu cores) (version 2.20.00)
[    1.416563] powernow-k8:    0 : pstate 0 (3000 MHz)
[    1.416595] powernow-k8:    1 : pstate 1 (2300 MHz)
[    1.416627] powernow-k8:    2 : pstate 2 (1800 MHz)
[    1.416659] powernow-k8:    3 : pstate 3 (800 MHz)
[    1.417246] PM: Resume from disk failed.
[    1.417252] registered taskstats version 1
[    1.417466]   Magic number: 10:573:641
[    1.417564] rtc_cmos 00:03: setting system clock to 2010-09-17
16:38:12 UTC (1284741492)
[    1.417600] BIOS EDD facility v0.16 2004-Jun-25, 0 devices found
[    1.417633] EDD information not available.
[    1.417707] Freeing unused kernel memory: 988k freed
[    1.417943] Write protecting the kernel read-only data: 10240k
[    1.418095] Freeing unused kernel memory: 428k freed
[    1.418299] Freeing unused kernel memory: 1536k freed
[    1.429294] udev: starting version 151
[    1.429363] udevd (106): /proc/106/oom_adj is deprecated, please
use /proc/106/oom_score_adj instead.
[    1.452761] ahci 0000:00:11.0: version 3.0
[    1.452782]   alloc irq_desc for 22 on node 0
[    1.452784]   alloc kstat_irqs on node 0
[    1.452791] ahci 0000:00:11.0: PCI INT A -> GSI 22 (level, low) -> IRQ 22
[    1.452972] ahci 0000:00:11.0: AHCI 0001.0100 32 slots 6 ports 3
Gbps 0x3f impl SATA mode
[    1.453010] ahci 0000:00:11.0: flags: 64bit ncq sntf ilck pm led
clo pmp pio slum part ccc
[    1.453440] r8169 Gigabit Ethernet driver 2.3LK-NAPI loaded
[    1.453488] r8169 0000:02:00.0: PCI INT A -> GSI 19 (level, low) -> IRQ 19
[    1.453544] r8169 0000:02:00.0: setting latency timer to 64
[    1.453548] r8169 0000:02:00.0: (unregistered net_device): unknown
MAC, using family default
[    1.453610]   alloc irq_desc for 41 on node 0
[    1.453611]   alloc kstat_irqs on node 0
[    1.453620] r8169 0000:02:00.0: irq 41 for MSI/MSI-X
[    1.453977] r8169 0000:02:00.0: eth0: RTL8168b/8111b at
0xffffc9001108c000, 00:30:67:71:f9:a7, XID 0c100000 IRQ 41
[    1.462138] scsi0 : ahci
[    1.466085] scsi1 : ahci
[    1.466186] scsi2 : ahci
[    1.466265] scsi3 : ahci
[    1.466346] scsi4 : ahci
[    1.466424] scsi5 : ahci
[    1.466489] ata1: SATA max UDMA/133 abar m1024@0xfe8ffc00 port
0xfe8ffd00 irq 22
[    1.466526] ata2: SATA max UDMA/133 abar m1024@0xfe8ffc00 port
0xfe8ffd80 irq 22
[    1.466562] ata3: SATA max UDMA/133 abar m1024@0xfe8ffc00 port
0xfe8ffe00 irq 22
[    1.466599] ata4: SATA max UDMA/133 abar m1024@0xfe8ffc00 port
0xfe8ffe80 irq 22
[    1.466635] ata5: SATA max UDMA/133 abar m1024@0xfe8ffc00 port
0xfe8fff00 irq 22
[    1.466672] ata6: SATA max UDMA/133 abar m1024@0xfe8ffc00 port
0xfe8fff80 irq 22
[    1.467329] scsi6 : pata_atiixp
[    1.467408] scsi7 : pata_atiixp
[    1.468141] ata7: PATA max UDMA/100 cmd 0x1f0 ctl 0x3f6 bmdma 0xff00 irq 14
[    1.468178] ata8: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0xff08 irq 15
[    1.720025] usb 3-3: new low speed USB device using ohci_hcd and address 2
[    1.810071] ata2: SATA link down (SStatus 0 SControl 300)
[    1.810081] ata6: SATA link down (SStatus 0 SControl 300)
[    1.810105] ata3: SATA link down (SStatus 0 SControl 300)
[    1.810130] ata5: SATA link down (SStatus 0 SControl 300)
[    1.810151] ata4: SATA link down (SStatus 0 SControl 300)
[    1.990038] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    1.990362] ata1.15: Port Multiplier 1.2, 0x197b:0x0325 r0, 15
ports, feat 0x5/0xf
[    1.991374] ata1.00: hard resetting link
[    2.300023] usb 4-1: new low speed USB device using ohci_hcd and address 2
[    2.513348] usbcore: registered new interface driver hiddev
[    2.517233] input: Logitech USB Optical Mouse as
/devices/pci0000:00/0000:00:12.0/usb3/3-3/3-3:1.0/input/input2
[    2.517336] generic-usb 0003:046D:C058.0001: input,hidraw0: USB HID
v1.11 Mouse [Logitech USB Optical Mouse] on usb-0000:00:12.0-3/input0
[    2.520276] ata1.00: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
[    2.520347] ata1.01: hard resetting link
[    2.528234] input: Chicony USB Keyboard as
/devices/pci0000:00/0000:00:12.1/usb4/4-1/4-1:1.0/input/input3
[    2.528317] generic-usb 0003:04F2:0402.0002: input,hidraw1: USB HID
v1.11 Keyboard [Chicony USB Keyboard] on usb-0000:00:12.1-1/input0
[    2.557131] input: Chicony USB Keyboard as
/devices/pci0000:00/0000:00:12.1/usb4/4-1/4-1:1.1/input/input4
[    2.557243] generic-usb 0003:04F2:0402.0003: input,hiddev0,hidraw2:
USB HID v1.11 Device [Chicony USB Keyboard] on
usb-0000:00:12.1-1/input1
[    2.557294] usbcore: registered new interface driver usbhid
[    2.557327] usbhid: USB HID core driver
[    2.810026] usb 5-2: new low speed USB device using ohci_hcd and address 2
[    2.870030] hub 5-0:1.0: unable to enumerate USB device on port 2
[    3.400022] usb 5-2: new low speed USB device using ohci_hcd and address 3
[    3.590057] ata1.01: failed to resume link (SControl 0)
[    3.590389] ata1.01: SATA link down (SStatus 0 SControl 0)
[    3.590488] ata1.02: hard resetting link
[    4.660077] ata1.02: failed to resume link (SControl 0)
[    4.660434] ata1.02: SATA link down (SStatus 0 SControl 0)
[    4.660533] ata1.03: hard resetting link
[    5.239223] generic-usb 0003:09AE:2009.0004: hiddev0,hidraw3: USB
HID v1.10 Device [Tripp Lite  TRIPP LITE UPS ] on
usb-0000:00:13.0-2/input0
[    5.730073] ata1.03: failed to resume link (SControl 0)
[    5.730405] ata1.03: SATA link down (SStatus 0 SControl 0)
[    5.730504] ata1.04: hard resetting link
[    6.800076] ata1.04: failed to resume link (SControl 0)
[    6.800412] ata1.04: SATA link down (SStatus 0 SControl 0)
[    6.800511] ata1.05: hard resetting link
[    7.870075] ata1.05: failed to resume link (SControl 0)
[    7.870411] ata1.05: SATA link down (SStatus 0 SControl 0)
[    7.870510] ata1.06: hard resetting link
[    8.940065] ata1.06: failed to resume link (SControl 0)
[    8.940405] ata1.06: SATA link down (SStatus 0 SControl 0)
[    8.940506] ata1.07: hard resetting link
[   10.010078] ata1.07: failed to resume link (SControl 0)
[   10.010410] ata1.07: SATA link down (SStatus 0 SControl 0)
[   10.010509] ata1.08: hard resetting link
[   11.080072] ata1.08: failed to resume link (SControl 0)
[   11.080413] ata1.08: SATA link down (SStatus 0 SControl 0)
[   11.080512] ata1.09: hard resetting link
[   12.150073] ata1.09: failed to resume link (SControl 0)
[   12.150406] ata1.09: SATA link down (SStatus 0 SControl 0)
[   12.150505] ata1.10: hard resetting link
[   13.220085] ata1.10: failed to resume link (SControl 0)
[   13.220421] ata1.10: SATA link down (SStatus 0 SControl 0)
[   13.220520] ata1.11: hard resetting link
[   14.290073] ata1.11: failed to resume link (SControl 0)
[   14.290411] ata1.11: SATA link down (SStatus 0 SControl 0)
[   14.290510] ata1.12: hard resetting link
[   15.360071] ata1.12: failed to resume link (SControl 0)
[   15.360408] ata1.12: SATA link down (SStatus 0 SControl 0)
[   15.360507] ata1.13: hard resetting link
[   16.430065] ata1.13: failed to resume link (SControl 0)
[   16.430405] ata1.13: SATA link down (SStatus 0 SControl 0)
[   16.430505] ata1.14: hard resetting link
[   17.500079] ata1.14: failed to resume link (SControl 0)
[   17.500411] ata1.14: SATA link down (SStatus 0 SControl 0)
[   17.500941] ata1.00: ATA-7: H/W RAID5, 0956, max UDMA/133
[   17.500974] ata1.00: 15627714560 sectors, multi 16: LBA48
[   17.501480] ata1.00: configured for UDMA/133
[   17.501590] ata1: EH complete
[   17.501741] scsi 0:0:0:0: Direct-Access     ATA      H/W RAID5
  0956 PQ: 0 ANSI: 5
[   17.501880] sd 0:0:0:0: Attached scsi generic sg0 type 0
[   17.501898] sd 0:0:0:0: [sda] 15627714560 512-byte logical blocks:
(8.00 TB/7.27 TiB)
[   17.501961] sd 0:0:0:0: [sda] Write Protect is off
[   17.501998] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[   17.502081] sd 0:0:0:0: [sda] Write cache: disabled, read cache:
enabled, doesn't support DPO or FUA
[   17.554024]  sda: sda1 sda2 sda3 sda4
[   17.554390] sd 0:0:0:0: [sda] Attached SCSI disk
[   18.271564] EXT4-fs (dm-2): INFO: recovery required on readonly filesystem
[   18.271664] EXT4-fs (dm-2): write access will be enabled during recovery
[   19.339765] EXT4-fs (dm-2): recovery complete
[   19.340827] EXT4-fs (dm-2): mounted filesystem with ordered data
mode. Opts: (null)
[   20.754229] Adding 8191996k swap on /dev/mapper/VG_OS-SWAP.
Priority:-1 extents:1 across:8191996k
[   21.131598] udev: starting version 151
[   21.923033] apparmor_parser[643]: segfault at 0 ip 00007fb08209e5f6
sp 00007fff928343a8 error 4 in libc-2.11.1.so[7fb08201d000+17a000]
[   21.923852] apparmor_parser[676]: segfault at 0 ip 00007f64d84125f6
sp 00007fff30a71288 error 4 in libc-2.11.1.so[7f64d8391000+17a000]
[   22.124942] EDAC MC: Ver: 2.1.0 Aug 30 2010
[   22.234406] shpchp 0000:00:01.0: HPC vendor_id 1022 device_id 9602
ss_vid 1022 ss_did 9602
[   22.234409] shpchp 0000:00:01.0: Cannot reserve MMIO region
[   22.234487] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[   22.243206] ACPI: resource piix4_smbus [io  0x0b00-0x0b07]
conflicts with ACPI region SOR1 [io  0x0b00-0x0b0f 64bit pref window
disabled]
[   22.243209] ACPI: If an ACPI driver is available for this device,
you should use it instead of the native driver
[   22.281632] EDAC amd64_edac:  Ver: 3.3.0 Aug 30 2010
[   22.281730] EDAC amd64: This node reports that Memory ECC is
currently disabled, set F3x44[22] (0000:00:18.3).
[   22.281737] EDAC amd64: ECC disabled in the BIOS or no ECC
capability, module will not load.
[   22.281738]  Either enable ECC checking or force module loading by
setting 'ecc_enable_override'.
[   22.281739]  (Note that use of the override may cause unknown side effects.)
[   22.281750] amd64_edac: probe of 0000:00:18.2 failed with error -22
[   22.473231] HDA Intel 0000:00:14.2: PCI INT A -> GSI 16 (level,
low) -> IRQ 16
[   22.652737] lp: driver loaded but no devices found
[   22.670778] [drm] Initialized drm 1.1.0 20060810
[   22.676593] hda_codec: ALC892: BIOS auto-probing.
[   22.677116] hda_codec: Too many connections 4 for NID 0x1b
[   22.681437] HDA Intel 0000:01:05.1: PCI INT B -> GSI 19 (level,
low) -> IRQ 19
[   22.681475] HDA Intel 0000:01:05.1: setting latency timer to 64
[   22.808330] RPC: Registered udp transport module.
[   22.808333] RPC: Registered tcp transport module.
[   22.808334] RPC: Registered tcp NFSv4.1 backchannel transport module.
[   22.893353] [drm] radeon defaulting to kernel modesetting.
[   22.893355] [drm] radeon kernel modesetting enabled.
[   22.893447] radeon 0000:01:05.0: PCI INT A -> GSI 18 (level, low) -> IRQ 18
[   22.893452] radeon 0000:01:05.0: setting latency timer to 64
[   22.894821] [drm] initializing kernel modesetting (RS880 0x1002:0x9715).
[   22.894901] [drm] register mmio base: 0xFEAF0000
[   22.894903] [drm] register mmio size: 65536
[   22.895503] ATOM BIOS: B43106
[   22.895515] [drm] Clocks initialized !
[   22.895523] radeon 0000:01:05.0: VRAM: 64M 0xC0000000 - 0xC3FFFFFF (64M used)
[   22.895526] radeon 0000:01:05.0: GTT: 512M 0xA0000000 - 0xBFFFFFFF
[   22.897686] [drm] Detected VRAM RAM=64M, BAR=64M
[   22.897690] [drm] RAM width 32bits DDR
[   22.897761] [TTM] Zone  kernel: Available graphics memory: 1995292 kiB.
[   22.897763] [TTM] Initializing pool allocator.
[   22.897781] [drm] radeon: 64M of VRAM memory ready
[   22.897782] [drm] radeon: 512M of GTT memory ready.
[   22.897819] [drm] radeon: irq initialized.
[   22.897821] [drm] GART: num cpu pages 131072, num gpu pages 131072
[   22.898442] [drm] Loading RS780 Microcode
[   23.151883] [drm] ring test succeeded in 1 usecs
[   23.151967] [drm] radeon: ib pool ready.
[   23.152021] [drm] ib test succeeded in 0 usecs
[   23.152027] [drm] Enabling audio support
[   23.152222] [drm] Unknown TV standard; defaulting to NTSC
[   23.152344] [drm] Radeon Display Connectors
[   23.152346] [drm] Connector 0:
[   23.152347] [drm]   VGA
[   23.152349] [drm]   DDC: 0x7e40 0x7e40 0x7e44 0x7e44 0x7e48 0x7e48
0x7e4c 0x7e4c
[   23.152350] [drm]   Encoders:
[   23.152351] [drm]     CRT1: INTERNAL_KLDSCP_DAC1
[   23.152352] [drm] Connector 1:
[   23.152353] [drm]   HDMI-A
[   23.152354] [drm]   HPD3
[   23.152356] [drm]   DDC: 0x7e50 0x7e50 0x7e54 0x7e54 0x7e58 0x7e58
0x7e5c 0x7e5c
[   23.152357] [drm]   Encoders:
[   23.152358] [drm]     DFP1: INTERNAL_KLDSCP_LVTMA
[   23.257133] [drm] radeon: power management initialized
[   23.392737] [drm] fb mappable at 0xF8141000
[   23.392739] [drm] vram apper at 0xF8000000
[   23.392740] [drm] size 8294400
[   23.392741] [drm] fb depth is 24
[   23.392742] [drm]    pitch is 7680
[   23.448684] Console: switching to colour frame buffer device 240x67
[   23.466872] fb0: radeondrmfb frame buffer device
[   23.466873] drm: registered panic notifier
[   23.466889] [drm] Initialized radeon 2.6.0 20080528 for
0000:01:05.0 on minor 0
[   24.481375] EXT4-fs (dm-2): re-mounted. Opts: errors=remount-ro
[   24.575961] EXT3-fs: barriers not enabled
[   24.576140] kjournald starting.  Commit interval 5 seconds
[   24.576369] EXT3-fs (sda1): using internal journal
[   24.576373] EXT3-fs (sda1): mounted filesystem with ordered data mode
[   25.168058] EXT4-fs (dm-4): mounted filesystem with ordered data
mode. Opts: (null)
[   25.541838] EXT4-fs (dm-1): mounted filesystem with ordered data
mode. Opts: (null)
[   25.754341] EXT4-fs (dm-3): mounted filesystem with ordered data
mode. Opts: (null)
[   26.110135] EXT4-fs (dm-5): mounted filesystem with ordered data
mode. Opts: (null)
[   26.248274] FS-Cache: Loaded
[   26.277324] FS-Cache: Netfs 'nfs' registered for caching
[   26.298397] Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
[   28.621994] apparmor_parser[1030]: segfault at 0 ip
00007f6ef65485f6 sp 00007fff7a289638 error 4 in
libc-2.11.1.so[7f6ef64c7000+17a000]
[   29.841008] r8169 0000:02:00.0: eth0: link up
[   29.841015] r8169 0000:02:00.0: eth0: link up
[   32.035071] ip_tables: (C) 2000-2006 Netfilter Core Team
[   34.074983] nf_conntrack version 0.5.0 (16384 buckets, 65536 max)
[   34.935149] svc: failed to register lockdv1 RPC service (errno 97).
[   34.935193] NFSD: Using /var/lib/nfs/v4recovery as the NFSv4 state
recovery directory
[   34.950361] NFSD: starting 90-second grace period
[   36.522218] ppdev: user-space parallel port driver
[   36.813959] LOGDROP: IN=eth0 OUT=
MAC=00:30:67:71:f9:a7:00:1c:c3:57:f5:80:08:00 SRC=192.168.100.202
DST=192.168.100.150 LEN=60 TOS=0x00 PREC=0x00 TTL=64 ID=34301 DF
PROTO=TCP SPT=36727 DPT=6549 WINDOW=5840 RES=0x00 SYN URGP=0
[   40.350009] eth0: no IPv6 routers present
[   41.252054] hda-intel: IRQ timing workaround is activated for card
#1. Suggest a bigger bdl_pos_adj.




Thanks

-Greg
