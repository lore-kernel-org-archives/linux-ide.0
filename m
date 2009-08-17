From: Mike Hokenson <logan+kernel@gozer.org>
Subject: Long delay when booting with SATA DVD on Marvell 88SE6121
Date: Sun, 16 Aug 2009 19:29:18 -0500
Message-ID: <20090817002918.GA2805@gozer.dminteractive.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gozer.dminteractive.com ([66.18.16.178]:41209 "EHLO
	gozer.dminteractive.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756167AbZHQAgF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 16 Aug 2009 20:36:05 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi list,

I've got a MSI P35 Platinum with a Marvell 88SE6121 (one PATA, one SATA) controller and when I have a SATA DVD drive connected to the port, my system takes a good 30+ seconds longer to boot. The HDD activity LED is solid the whole time and I see a series of messages like this:

[    6.312129] ata2.00: qc timeout (cmd 0xa1)
[    6.312135] ata2.00: failed to IDENTIFY (I/O error, err_mask=0x4)
[   11.352006] ata2: link is slow to respond, please be patient (ready=0)
[   16.336009] ata2: device not ready (errno=-16), forcing hardreset
[   21.532007] ata2: link is slow to respond, please be patient (ready=0)
[   26.348009] ata2: SRST failed (errno=-16)
[   31.544008] ata2: link is slow to respond, please be patient (ready=0)
[   36.360014] ata2: SRST failed (errno=-16)
[   36.544307] ata2.00: ATAPI: ASUS    DRW-2014L1T, 1.02, max UDMA/66
[   36.560317] ata2.00: configured for UDMA/66
[   36.576547] scsi 1:0:0:0: CD-ROM            ASUS     DRW-2014L1T      1.02 PQ: 0 ANSI: 5

And then the system boots normally. I don't have any problems reading or writing and I've seen the same issues with another DVD drive. However, there are some messages that appear when writing a disc (from an older /var/log/messages):

[2136249.058984] sr 1:0:0:0: [sr0] Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE
[2136249.058987] sr 1:0:0:0: [sr0] Sense Key : Illegal Request [current] 
[2136249.058990] sr 1:0:0:0: [sr0] Add. Sense: Logical block address out of range
[2136249.059891] sr 1:0:0:0: [sr0] Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE
[2136249.059893] sr 1:0:0:0: [sr0] Sense Key : Illegal Request [current] 
[2136249.059896] sr 1:0:0:0: [sr0] Add. Sense: Logical block address out of range

These messages don't really concern me, because the discs always test fine. The only reason I mention it is in case there's some relation to the first issue.

The slow boot issue doesn't occur when I'm using my Intel ICH9R controller (not sure anymore about the errors while writing), but all 4 ports are now in use by hard drives and I'd like to keep them on the ICH9R since the controller has been rock solid. This has been happening for as long as I've had this motherboard - January of 2008. It's more of a nuisance than anything else..

I'm not sure if there's an option I could pass to the libata module to help with issues on this port, forcing a specific mode or speed or something, but I thought I'd ask.

Thanks,

Mike

(lspci -vvv for the Marvell controller)

03:00.0 IDE interface: Marvell Technology Group Ltd. 88SE6121 SATA II Controller (rev b1) (prog-if 8f [Master SecP SecO PriP PriO])
         Subsystem: Marvell Technology Group Ltd. 88SE6121 SATA II Controller
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
         Latency: 0, Cache Line Size: 32 bytes
         Interrupt: pin A routed to IRQ 16
         Region 0: I/O ports at cc00 [size=8]
         Region 1: I/O ports at c880 [size=4]
         Region 2: I/O ports at c800 [size=8]
         Region 3: I/O ports at c480 [size=4]
         Region 4: I/O ports at c400 [size=16]
         Region 5: Memory at fe9ffc00 (32-bit, non-prefetchable) [size=1K]
         Capabilities: [48] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA PME(D0+,D1+,D2-,D3hot+,D3cold-)
                 Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=1 PME-
         Capabilities: [50] MSI: Enable- Count=1/1 Maskable- 64bit-
                 Address: 00000000  Data: 0000
         Capabilities: [e0] Express (v1) Legacy Endpoint, MSI 00
                 DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s unlimited, L1 unlimited
                         ExtTag- AttnBtn- AttnInd- PwrInd- RBE- FLReset-
                 DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
                         RlxdOrd- ExtTag- PhantFunc- AuxPwr+ NoSnoop-
                         MaxPayload 128 bytes, MaxReadReq 512 bytes
                 DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq+ AuxPwr- TransPend-
                 LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s, Latency L0 <256ns, L1 unlimited
                         ClockPM- Surprise- LLActRep- BwNot-
                 LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk-
                         ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                 LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
         Capabilities: [100] Advanced Error Reporting
                 UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                 UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                 UESvrt: DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP+ ECRC- UnsupReq- ACSViol-
                 CESta:  RxErr+ BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
                 CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
                 AERCap: First Error Pointer: 1f, GenCap- CGenEn- ChkCap- ChkEn-
         Kernel driver in use: pata_marvell

(full dmesg follows)

[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Linux version 2.6.30-1-686-bigmem (Debian 2.6.30-6) (waldi@debian.org) (gcc version 4.3.4 (Debian 4.3.4-1) ) #1 SMP Sat Aug 15 20:10:47 UTC 2009
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
[    0.000000]  BIOS-e820: 0000000000000000 - 000000000009cc00 (usable)
[    0.000000]  BIOS-e820: 000000000009cc00 - 00000000000a0000 (reserved)
[    0.000000]  BIOS-e820: 00000000000e3000 - 0000000000100000 (reserved)
[    0.000000]  BIOS-e820: 0000000000100000 - 00000000cffb0000 (usable)
[    0.000000]  BIOS-e820: 00000000cffb0000 - 00000000cffbe000 (ACPI data)
[    0.000000]  BIOS-e820: 00000000cffbe000 - 00000000cfff0000 (ACPI NVS)
[    0.000000]  BIOS-e820: 00000000cfff0000 - 00000000d0000000 (reserved)
[    0.000000]  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
[    0.000000]  BIOS-e820: 00000000ffb00000 - 0000000100000000 (reserved)
[    0.000000]  BIOS-e820: 0000000100000000 - 0000000230000000 (usable)
[    0.000000] DMI present.
[    0.000000] AMI BIOS detected: BIOS may corrupt low RAM, working around it.
[    0.000000] e820 update range: 0000000000000000 - 0000000000010000 (usable) ==> (reserved)
[    0.000000] last_pfn = 0x230000 max_arch_pfn = 0x1000000
[    0.000000] MTRR default type: uncachable
[    0.000000] MTRR fixed ranges enabled:
[    0.000000]   00000-9FFFF write-back
[    0.000000]   A0000-BFFFF uncachable
[    0.000000]   C0000-CFFFF write-protect
[    0.000000]   D0000-DFFFF uncachable
[    0.000000]   E0000-EFFFF write-through
[    0.000000]   F0000-FFFFF write-protect
[    0.000000] MTRR variable ranges enabled:
[    0.000000]   0 base 000000000 mask E00000000 write-back
[    0.000000]   1 base 200000000 mask FE0000000 write-back
[    0.000000]   2 base 220000000 mask FF0000000 write-back
[    0.000000]   3 base 0D0000000 mask FF0000000 uncachable
[    0.000000]   4 base 0E0000000 mask FE0000000 uncachable
[    0.000000]   5 disabled
[    0.000000]   6 disabled
[    0.000000]   7 disabled
[    0.000000] x86 PAT enabled: cpu 0, old 0x7040600070406, new 0x7010600070106
[    0.000000] e820 update range: 00000000d0000000 - 0000000100000000 (usable) ==> (reserved)
[    0.000000] init_memory_mapping: 0000000000000000-00000000379fe000
[    0.000000]  0000000000 - 0000200000 page 4k
[    0.000000]  0000200000 - 0037800000 page 2M
[    0.000000]  0037800000 - 00379fe000 page 4k
[    0.000000] kernel direct mapping tables up to 379fe000 @ 10000-16000
[    0.000000] RAMDISK: 37839000 - 37fefb73
[    0.000000] Allocated new RAMDISK: 0056a000 - 00d20b73
[    0.000000] Move RAMDISK from 0000000037839000 - 0000000037fefb72 to 0056a000 - 00d20b72
[    0.000000] ACPI: RSDP 000f9960 00014 (v00 ACPIAM)
[    0.000000] ACPI: RSDT cffb0000 00040 (v01 111008 RSDT1347 20081110 MSFT 00000097)
[    0.000000] ACPI: FACP cffb0200 00084 (v02 111008 FACP1347 20081110 MSFT 00000097)
[    0.000000] ACPI: DSDT cffb0440 052B7 (v01  0AAAA 0AAAA000 00000000 INTL 20051117)
[    0.000000] ACPI: FACS cffbe000 00040
[    0.000000] ACPI: APIC cffb0390 0006C (v01 111008 APIC1347 20081110 MSFT 00000097)
[    0.000000] ACPI: MCFG cffb0400 0003C (v01 111008 OEMMCFG  20081110 MSFT 00000097)
[    0.000000] ACPI: OEMB cffbe040 00061 (v01 111008 OEMB1347 20081110 MSFT 00000097)
[    0.000000] ACPI: HPET cffb5700 00038 (v01 111008 OEMHPET  20081110 MSFT 00000097)
[    0.000000] ACPI: GSCI cffbe0b0 02024 (v01 111008 GMCHSCI  20081110 MSFT 00000097)
[    0.000000] ACPI: SSDT cffc05e0 00A7C (v01 DpgPmm    CpuPm 00000012 INTL 20051117)
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] 8070MB HIGHMEM available.
[    0.000000] 889MB LOWMEM available.
[    0.000000]   mapped low ram: 0 - 379fe000
[    0.000000]   low ram: 0 - 379fe000
[    0.000000]   node 0 low ram: 00000000 - 379fe000
[    0.000000]   node 0 bootmap 00011000 - 00017f40
[    0.000000] (9 early reservations) ==> bootmem [0000000000 - 00379fe000]
[    0.000000]   #0 [0000000000 - 0000001000]   BIOS data page ==> [0000000000 - 0000001000]
[    0.000000]   #1 [0000001000 - 0000002000]    EX TRAMPOLINE ==> [0000001000 - 0000002000]
[    0.000000]   #2 [0000006000 - 0000007000]       TRAMPOLINE ==> [0000006000 - 0000007000]
[    0.000000]   #3 [0000100000 - 0000563290]    TEXT DATA BSS ==> [0000100000 - 0000563290]
[    0.000000]   #4 [000009cc00 - 0000100000]    BIOS reserved ==> [000009cc00 - 0000100000]
[    0.000000]   #5 [0000564000 - 0000569133]              BRK ==> [0000564000 - 0000569133]
[    0.000000]   #6 [0000010000 - 0000011000]          PGTABLE ==> [0000010000 - 0000011000]
[    0.000000]   #7 [000056a000 - 0000d20b73]      NEW RAMDISK ==> [000056a000 - 0000d20b73]
[    0.000000]   #8 [0000011000 - 0000018000]          BOOTMAP ==> [0000011000 - 0000018000]
[    0.000000] found SMP MP-table at [c00ff780] ff780
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA      0x00000010 -> 0x00001000
[    0.000000]   Normal   0x00001000 -> 0x000379fe
[    0.000000]   HighMem  0x000379fe -> 0x00230000
[    0.000000] Movable zone start PFN for each node
[    0.000000] early_node_map[3] active PFN ranges
[    0.000000]     0: 0x00000010 -> 0x0000009c
[    0.000000]     0: 0x00000100 -> 0x000cffb0
[    0.000000]     0: 0x00100000 -> 0x00230000
[    0.000000] On node 0 totalpages: 2096956
[    0.000000] free_area_init_node: node 0, pgdat c041aa00, node_mem_map c1000200
[    0.000000]   DMA zone: 32 pages used for memmap
[    0.000000]   DMA zone: 0 pages reserved
[    0.000000]   DMA zone: 3948 pages, LIFO batch:0
[    0.000000]   Normal zone: 1748 pages used for memmap
[    0.000000]   Normal zone: 221994 pages, LIFO batch:31
[    0.000000]   HighMem zone: 16141 pages used for memmap
[    0.000000]   HighMem zone: 1853093 pages, LIFO batch:31
[    0.000000] Using APIC driver default
[    0.000000] ACPI: PM-Timer IO Port: 0x808
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x03] lapic_id[0x82] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x04] lapic_id[0x83] disabled)
[    0.000000] ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ2 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Enabling APIC mode:  Flat.  Using 1 I/O APICs
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] ACPI: HPET id: 0xffffffff base: 0xfed00000
[    0.000000] SMP: Allowing 4 CPUs, 2 hotplug CPUs
[    0.000000] nr_irqs_gsi: 24
[    0.000000] PM: Registered nosave memory: 000000000009c000 - 000000000009d000
[    0.000000] PM: Registered nosave memory: 000000000009d000 - 00000000000a0000
[    0.000000] PM: Registered nosave memory: 00000000000a0000 - 00000000000e3000
[    0.000000] PM: Registered nosave memory: 00000000000e3000 - 0000000000100000
[    0.000000] Allocating PCI resources starting at d4000000 (gap: d0000000:2ee00000)
[    0.000000] NR_CPUS:32 nr_cpumask_bits:32 nr_cpu_ids:4 nr_node_ids:1
[    0.000000] PERCPU: Embedded 12 pages at c5610000, static data 25532 bytes
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 2079035
[    0.000000] Kernel command line: root=/dev/md0 ro log_buf_len=16 quiet
[    0.000000] Enabling fast FPU save and restore... done.
[    0.000000] Enabling unmasked SIMD FPU exception support... done.
[    0.000000] Initializing CPU#0
[    0.000000] NR_IRQS:1280
[    0.000000] PID hash table entries: 4096 (order: 12, 16384 bytes)
[    0.000000] Fast TSC calibration using PIT
[    0.000000] Detected 3005.140 MHz processor.
[    0.004000] Console: colour VGA+ 80x25
[    0.004000] console [tty0] enabled
[    0.004000] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
[    0.004000] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
[    0.004000] Initializing HighMem for node 0 (000379fe:00230000)
[    0.004000] Memory: 8301700k/9175040k available (2216k kernel code, 85176k reserved, 1184k data, 332k init, 7476936k highmem)
[    0.004000] virtual kernel memory layout:
[    0.004000]     fixmap  : 0xffe16000 - 0xfffff000   (1956 kB)
[    0.004000]     pkmap   : 0xffa00000 - 0xffc00000   (2048 kB)
[    0.004000]     vmalloc : 0xf81fe000 - 0xff9fe000   ( 120 MB)
[    0.004000]     lowmem  : 0xc0000000 - 0xf79fe000   ( 889 MB)
[    0.004000]       .init : 0xc045a000 - 0xc04ad000   ( 332 kB)
[    0.004000]       .data : 0xc032a3d1 - 0xc0452430   (1184 kB)
[    0.004000]       .text : 0xc0100000 - 0xc032a3d1   (2216 kB)
[    0.004000] Checking if this processor honours the WP bit even in supervisor mode...Ok.
[    0.004000] hpet clockevent registered
[    0.004000] HPET: 4 timers in total, 0 timers will be used for per-cpu timer
[    0.004000] Calibrating delay loop (skipped), value calculated using timer frequency.. 6010.28 BogoMIPS (lpj=12020560)
[    0.004000] Security Framework initialized
[    0.004000] SELinux:  Disabled at boot.
[    0.004000] Mount-cache hash table entries: 512
[    0.004000] Initializing cgroup subsys ns
[    0.004000] Initializing cgroup subsys cpuacct
[    0.004000] Initializing cgroup subsys devices
[    0.004000] Initializing cgroup subsys freezer
[    0.004000] Initializing cgroup subsys net_cls
[    0.004000] CPU: L1 I cache: 32K, L1 D cache: 32K
[    0.004000] CPU: L2 cache: 6144K
[    0.004000] CPU: Physical Processor ID: 0
[    0.004000] CPU: Processor Core ID: 0
[    0.004000] Intel machine check architecture supported.
[    0.004000] Intel machine check reporting enabled on CPU#0.
[    0.004000] using mwait in idle threads.
[    0.004000] Checking 'hlt' instruction... OK.
[    0.016741] ACPI: Core revision 20090320
[    0.024393] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.066341] CPU0: Intel(R) Core(TM)2 Duo CPU     E8400  @ 3.00GHz stepping 06
[    0.068001] Booting processor 1 APIC 0x1 ip 0x6000
[    0.004000] Initializing CPU#1
[    0.004000] Calibrating delay using timer specific routine.. 6011.24 BogoMIPS (lpj=12022498)
[    0.004000] CPU: L1 I cache: 32K, L1 D cache: 32K
[    0.004000] CPU: L2 cache: 6144K
[    0.004000] CPU: Physical Processor ID: 0
[    0.004000] CPU: Processor Core ID: 1
[    0.004000] Intel machine check architecture supported.
[    0.004000] Intel machine check reporting enabled on CPU#1.
[    0.004000] x86 PAT enabled: cpu 1, old 0x7040600070406, new 0x7010600070106
[    0.153557] CPU1: Intel(R) Core(TM)2 Duo CPU     E8400  @ 3.00GHz stepping 06
[    0.153565] checking TSC synchronization [CPU#0 -> CPU#1]: passed.
[    0.156046] Brought up 2 CPUs
[    0.156048] Total of 2 processors activated (12021.52 BogoMIPS).
[    0.156088] CPU0 attaching sched-domain:
[    0.156090]  domain 0: span 0-1 level MC
[    0.156091]   groups: 0 1
[    0.156094] CPU1 attaching sched-domain:
[    0.156096]  domain 0: span 0-1 level MC
[    0.156097]   groups: 1 0
[    0.156143] net_namespace: 1088 bytes
[    0.156143] Booting paravirtualized kernel on bare hardware
[    0.156143] regulator: core version 0.5
[    0.156143] NET: Registered protocol family 16
[    0.156143] ACPI: bus type pci registered
[    0.156143] PCI: MCFG configuration 0: base e0000000 segment 0 buses 0 - 255
[    0.156143] PCI: Not using MMCONFIG.
[    0.156155] PCI: PCI BIOS revision 3.00 entry at 0xf0031, last bus=5
[    0.156156] PCI: Using configuration type 1 for base access
[    0.156181] bio: create slab <bio-0> at 0
[    0.156415] ACPI: EC: Look up EC in DSDT
[    0.164793] ACPI: Interpreter enabled
[    0.164800] ACPI: (supports S0 S1 S3 S4 S5)
[    0.164815] ACPI: Using IOAPIC for interrupt routing
[    0.164854] PCI: MCFG configuration 0: base e0000000 segment 0 buses 0 - 255
[    0.166709] PCI: MCFG area at e0000000 reserved in ACPI motherboard resources
[    0.166710] PCI: Using MMCONFIG for extended config space
[    0.170099] ACPI Warning (tbutils-0246): Incorrect checksum in table [OEMB] - 88, should be 80 [20090320]
[    0.172046] ACPI: No dock devices found.
[    0.172195] ACPI: PCI Root Bridge [PCI0] (0000:00)
[    0.172212] pci 0000:00:01.0: PME# supported from D0 D3hot D3cold
[    0.172212] pci 0000:00:01.0: PME# disabled
[    0.172212] pci 0000:00:1a.0: reg 20 io port: [0xac00-0xac1f]
[    0.172212] pci 0000:00:1a.1: reg 20 io port: [0xa880-0xa89f]
[    0.172212] pci 0000:00:1a.7: reg 10 32bit mmio: [0xf9fffc00-0xf9ffffff]
[    0.172253] pci 0000:00:1a.7: PME# supported from D0 D3hot D3cold
[    0.172256] pci 0000:00:1a.7: PME# disabled
[    0.172299] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    0.172302] pci 0000:00:1c.0: PME# disabled
[    0.172347] pci 0000:00:1c.4: PME# supported from D0 D3hot D3cold
[    0.172350] pci 0000:00:1c.4: PME# disabled
[    0.172393] pci 0000:00:1c.5: PME# supported from D0 D3hot D3cold
[    0.172395] pci 0000:00:1c.5: PME# disabled
[    0.172436] pci 0000:00:1d.0: reg 20 io port: [0xa800-0xa81f]
[    0.172488] pci 0000:00:1d.1: reg 20 io port: [0xa480-0xa49f]
[    0.172540] pci 0000:00:1d.2: reg 20 io port: [0xa400-0xa41f]
[    0.172592] pci 0000:00:1d.3: reg 20 io port: [0xa080-0xa09f]
[    0.172646] pci 0000:00:1d.7: reg 10 32bit mmio: [0xf9fff800-0xf9fffbff]
[    0.172688] pci 0000:00:1d.7: PME# supported from D0 D3hot D3cold
[    0.172691] pci 0000:00:1d.7: PME# disabled
[    0.172783] pci 0000:00:1f.0: quirk: region 0800-087f claimed by ICH6 ACPI/GPIO/TCO
[    0.172786] pci 0000:00:1f.0: quirk: region 0480-04bf claimed by ICH6 GPIO
[    0.172789] pci 0000:00:1f.0: ICH7 LPC Generic IO decode 1 PIO at 0a00 (mask 00ff)
[    0.172837] pci 0000:00:1f.2: reg 10 io port: [0xa000-0xa007]
[    0.172842] pci 0000:00:1f.2: reg 14 io port: [0x9c00-0x9c03]
[    0.172846] pci 0000:00:1f.2: reg 18 io port: [0x9880-0x9887]
[    0.172850] pci 0000:00:1f.2: reg 1c io port: [0x9800-0x9803]
[    0.172854] pci 0000:00:1f.2: reg 20 io port: [0x9480-0x949f]
[    0.172859] pci 0000:00:1f.2: reg 24 32bit mmio: [0xf9fff000-0xf9fff7ff]
[    0.172881] pci 0000:00:1f.2: PME# supported from D3hot
[    0.172884] pci 0000:00:1f.2: PME# disabled
[    0.172904] pci 0000:00:1f.3: reg 10 64bit mmio: [0xf9ffec00-0xf9ffecff]
[    0.172915] pci 0000:00:1f.3: reg 20 io port: [0x400-0x41f]
[    0.172948] pci 0000:01:00.0: reg 10 32bit mmio: [0xfd000000-0xfdffffff]
[    0.172955] pci 0000:01:00.0: reg 14 64bit mmio: [0xd0000000-0xdfffffff]
[    0.172961] pci 0000:01:00.0: reg 1c 64bit mmio: [0xfa000000-0xfbffffff]
[    0.172965] pci 0000:01:00.0: reg 24 io port: [0xbc00-0xbc7f]
[    0.172969] pci 0000:01:00.0: reg 30 32bit mmio: [0xfe880000-0xfe8fffff]
[    0.173012] pci 0000:00:01.0: bridge io port: [0xb000-0xbfff]
[    0.173015] pci 0000:00:01.0: bridge 32bit mmio: [0xfa000000-0xfe8fffff]
[    0.173018] pci 0000:00:01.0: bridge 64bit mmio pref: [0xd0000000-0xdfffffff]
[    0.173085] pci 0000:03:00.0: reg 10 io port: [0xcc00-0xcc07]
[    0.173092] pci 0000:03:00.0: reg 14 io port: [0xc880-0xc883]
[    0.173098] pci 0000:03:00.0: reg 18 io port: [0xc800-0xc807]
[    0.173105] pci 0000:03:00.0: reg 1c io port: [0xc480-0xc483]
[    0.173111] pci 0000:03:00.0: reg 20 io port: [0xc400-0xc40f]
[    0.173118] pci 0000:03:00.0: reg 24 32bit mmio: [0xfe9ffc00-0xfe9fffff]
[    0.173151] pci 0000:03:00.0: supports D1
[    0.173152] pci 0000:03:00.0: PME# supported from D0 D1 D3hot
[    0.173156] pci 0000:03:00.0: PME# disabled
[    0.173191] pci 0000:00:1c.4: bridge io port: [0xc000-0xcfff]
[    0.173194] pci 0000:00:1c.4: bridge 32bit mmio: [0xfe900000-0xfe9fffff]
[    0.173244] pci 0000:04:00.0: reg 10 io port: [0xd800-0xd8ff]
[    0.173263] pci 0000:04:00.0: reg 18 64bit mmio: [0xfeaff000-0xfeafffff]
[    0.173282] pci 0000:04:00.0: reg 30 32bit mmio: [0xfeac0000-0xfeadffff]
[    0.173321] pci 0000:04:00.0: supports D1 D2
[    0.173322] pci 0000:04:00.0: PME# supported from D1 D2 D3hot D3cold
[    0.173327] pci 0000:04:00.0: PME# disabled
[    0.173367] pci 0000:00:1c.5: bridge io port: [0xd000-0xdfff]
[    0.173370] pci 0000:00:1c.5: bridge 32bit mmio: [0xfea00000-0xfeafffff]
[    0.173399] pci 0000:05:00.0: reg 10 io port: [0xec00-0xec1f]
[    0.173435] pci 0000:05:00.0: supports D1 D2
[    0.173459] pci 0000:05:00.1: reg 10 io port: [0xe880-0xe887]
[    0.173495] pci 0000:05:00.1: supports D1 D2
[    0.173536] pci 0000:00:1e.0: transparent bridge
[    0.173539] pci 0000:00:1e.0: bridge io port: [0xe000-0xefff]
[    0.173542] pci 0000:00:1e.0: bridge 32bit mmio: [0xfeb00000-0xfebfffff]
[    0.173559] pci_bus 0000:00: on NUMA node 0
[    0.173563] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[    0.173671] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P1._PRT]
[    0.173747] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P4._PRT]
[    0.173793] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P8._PRT]
[    0.173836] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P9._PRT]
[    0.176082] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 6 7 *10 11 12 14 15)
[    0.176150] ACPI: PCI Interrupt Link [LNKB] (IRQs *5)
[    0.176232] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 6 7 10 11 12 *14 15)
[    0.176317] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 6 7 10 *11 12 14 15)
[    0.176402] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 6 7 10 11 12 14 15) *0, disabled.
[    0.176487] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 6 7 10 11 12 14 *15)
[    0.176571] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 6 7 10 11 12 14 15) *0, disabled.
[    0.176656] ACPI: PCI Interrupt Link [LNKH] (IRQs *3 4 6 7 10 11 12 14 15)
[    0.176693] PCI: Using ACPI for IRQ routing
[    0.196012] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0
[    0.196016] hpet0: 4 comparators, 64-bit 14.318180 MHz counter
[    0.220007] pnp: PnP ACPI init
[    0.220012] ACPI: bus type pnp registered
[    0.222270] pnp: PnP ACPI: found 15 devices
[    0.222271] ACPI: ACPI bus type pnp unregistered
[    0.222274] PnPBIOS: Disabled by ACPI PNP
[    0.222281] system 00:01: iomem range 0xfed14000-0xfed19fff has been reserved
[    0.222285] system 00:07: ioport range 0xa00-0xadf has been reserved
[    0.222287] system 00:07: ioport range 0xae0-0xaef has been reserved
[    0.222291] system 00:08: ioport range 0x4d0-0x4d1 has been reserved
[    0.222293] system 00:08: ioport range 0x800-0x87f has been reserved
[    0.222295] system 00:08: ioport range 0x480-0x4bf has been reserved
[    0.222297] system 00:08: iomem range 0xfed1c000-0xfed1ffff has been reserved
[    0.222299] system 00:08: iomem range 0xfed20000-0xfed8ffff has been reserved
[    0.222303] system 00:0b: iomem range 0xffc00000-0xffefffff has been reserved
[    0.222307] system 00:0c: iomem range 0xfec00000-0xfec00fff could not be reserved
[    0.222309] system 00:0c: iomem range 0xfee00000-0xfee00fff has been reserved
[    0.222312] system 00:0d: iomem range 0xe0000000-0xefffffff has been reserved
[    0.222316] system 00:0e: iomem range 0x0-0x9ffff could not be reserved
[    0.222318] system 00:0e: iomem range 0xc0000-0xcffff could not be reserved
[    0.222320] system 00:0e: iomem range 0xe0000-0xfffff could not be reserved
[    0.222322] system 00:0e: iomem range 0x100000-0xcfffffff could not be reserved
[    0.257088] pci 0000:00:01.0: PCI bridge, secondary bus 0000:01
[    0.257090] pci 0000:00:01.0:   IO window: 0xb000-0xbfff
[    0.257093] pci 0000:00:01.0:   MEM window: 0xfa000000-0xfe8fffff
[    0.257095] pci 0000:00:01.0:   PREFETCH window: 0x000000d0000000-0x000000dfffffff
[    0.257098] pci 0000:00:1c.0: PCI bridge, secondary bus 0000:02
[    0.257100] pci 0000:00:1c.0:   IO window: disabled
[    0.257103] pci 0000:00:1c.0:   MEM window: disabled
[    0.257105] pci 0000:00:1c.0:   PREFETCH window: disabled
[    0.257109] pci 0000:00:1c.4: PCI bridge, secondary bus 0000:03
[    0.257112] pci 0000:00:1c.4:   IO window: 0xc000-0xcfff
[    0.257115] pci 0000:00:1c.4:   MEM window: 0xfe900000-0xfe9fffff
[    0.257118] pci 0000:00:1c.4:   PREFETCH window: disabled
[    0.257122] pci 0000:00:1c.5: PCI bridge, secondary bus 0000:04
[    0.257124] pci 0000:00:1c.5:   IO window: 0xd000-0xdfff
[    0.257128] pci 0000:00:1c.5:   MEM window: 0xfea00000-0xfeafffff
[    0.257130] pci 0000:00:1c.5:   PREFETCH window: disabled
[    0.257135] pci 0000:00:1e.0: PCI bridge, secondary bus 0000:05
[    0.257137] pci 0000:00:1e.0:   IO window: 0xe000-0xefff
[    0.257140] pci 0000:00:1e.0:   MEM window: 0xfeb00000-0xfebfffff
[    0.257143] pci 0000:00:1e.0:   PREFETCH window: disabled
[    0.257151] pci 0000:00:01.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
[    0.257154] pci 0000:00:01.0: setting latency timer to 64
[    0.257159] pci 0000:00:1c.0: PCI INT A -> GSI 17 (level, low) -> IRQ 17
[    0.257162] pci 0000:00:1c.0: setting latency timer to 64
[    0.257167] pci 0000:00:1c.4: PCI INT A -> GSI 17 (level, low) -> IRQ 17
[    0.257169] pci 0000:00:1c.4: setting latency timer to 64
[    0.257174] pci 0000:00:1c.5: PCI INT B -> GSI 16 (level, low) -> IRQ 16
[    0.257177] pci 0000:00:1c.5: setting latency timer to 64
[    0.257181] pci 0000:00:1e.0: setting latency timer to 64
[    0.257184] pci_bus 0000:00: resource 0 io:  [0x00-0xffff]
[    0.257186] pci_bus 0000:00: resource 1 mem: [0x000000-0xffffffffffffffff]
[    0.257187] pci_bus 0000:01: resource 0 io:  [0xb000-0xbfff]
[    0.257189] pci_bus 0000:01: resource 1 mem: [0xfa000000-0xfe8fffff]
[    0.257191] pci_bus 0000:01: resource 2 pref mem [0xd0000000-0xdfffffff]
[    0.257193] pci_bus 0000:03: resource 0 io:  [0xc000-0xcfff]
[    0.257194] pci_bus 0000:03: resource 1 mem: [0xfe900000-0xfe9fffff]
[    0.257196] pci_bus 0000:04: resource 0 io:  [0xd000-0xdfff]
[    0.257198] pci_bus 0000:04: resource 1 mem: [0xfea00000-0xfeafffff]
[    0.257200] pci_bus 0000:05: resource 0 io:  [0xe000-0xefff]
[    0.257201] pci_bus 0000:05: resource 1 mem: [0xfeb00000-0xfebfffff]
[    0.257203] pci_bus 0000:05: resource 3 io:  [0x00-0xffff]
[    0.257204] pci_bus 0000:05: resource 4 mem: [0x000000-0xffffffffffffffff]
[    0.257232] NET: Registered protocol family 2
[    0.300055] IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
[    0.300224] TCP established hash table entries: 131072 (order: 8, 1048576 bytes)
[    0.300464] TCP bind hash table entries: 65536 (order: 7, 524288 bytes)
[    0.300580] TCP: Hash tables configured (established 131072 bind 65536)
[    0.300582] TCP reno registered
[    0.312061] NET: Registered protocol family 1
[    0.312088] Trying to unpack rootfs image as initramfs...
[    0.460607] Freeing initrd memory: 7898k freed
[    0.463380] audit: initializing netlink socket (disabled)
[    0.463393] type=2000 audit(1250466352.460:1): initialized
[    0.463965] highmem bounce pool size: 64 pages
[    0.463969] HugeTLB registered 2 MB page size, pre-allocated 0 pages
[    0.464021] VFS: Disk quotas dquot_6.5.2
[    0.464047] Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
[    0.464082] msgmni has been set to 1628
[    0.464180] alg: No test for stdrng (krng)
[    0.464214] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 253)
[    0.464216] io scheduler noop registered
[    0.464217] io scheduler anticipatory registered
[    0.464218] io scheduler deadline registered
[    0.464226] io scheduler cfq registered (default)
[    0.464341] pci 0000:01:00.0: Boot video device
[    0.464429] pcieport-driver 0000:00:01.0: irq 24 for MSI/MSI-X
[    0.464436] pcieport-driver 0000:00:01.0: setting latency timer to 64
[    0.464531] pcieport-driver 0000:00:1c.0: irq 25 for MSI/MSI-X
[    0.464540] pcieport-driver 0000:00:1c.0: setting latency timer to 64
[    0.464664] pcieport-driver 0000:00:1c.4: irq 26 for MSI/MSI-X
[    0.464673] pcieport-driver 0000:00:1c.4: setting latency timer to 64
[    0.464797] pcieport-driver 0000:00:1c.5: irq 27 for MSI/MSI-X
[    0.464806] pcieport-driver 0000:00:1c.5: setting latency timer to 64
[    0.465043] isapnp: Scanning for PnP cards...
[    0.501656] Switched to high resolution mode on CPU 1
[    0.504049] Switched to high resolution mode on CPU 0
[    0.817767] isapnp: No Plug & Play device found
[    0.819508] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    0.820757] brd: module loaded
[    0.820845] PNP: No PS/2 controller found. Probing ports directly.
[    0.822816] serio: i8042 KBD port at 0x60,0x64 irq 1
[    0.822820] serio: i8042 AUX port at 0x60,0x64 irq 12
[    0.822883] mice: PS/2 mouse device common for all mice
[    0.822939] rtc_cmos 00:03: RTC can wake from S4
[    0.822972] rtc_cmos 00:03: rtc core: registered rtc_cmos as rtc0
[    0.822992] rtc0: alarms up to one month, y3k, 114 bytes nvram, hpet irqs
[    0.823015] cpuidle: using governor ladder
[    0.823016] cpuidle: using governor menu
[    0.823019] No iBFT detected.
[    0.823222] TCP cubic registered
[    0.823246] NET: Registered protocol family 10
[    0.823511] lo: Disabled Privacy Extensions
[    0.823688] Mobile IPv6
[    0.823690] NET: Registered protocol family 17
[    0.823694] Using IPI No-Shortcut mode
[    0.823774] registered taskstats version 1
[    0.823869] rtc_cmos 00:03: setting system clock to 2009-08-16 23:45:54 UTC (1250466354)
[    0.823901] Freeing unused kernel memory: 332k freed
[    0.824054] Write protecting the kernel text: 2220k
[    0.824071] Write protecting the kernel read-only data: 796k
[    0.917006] Floppy drive(s): fd0 is 1.44M
[    0.926794] Linux agpgart interface v0.103
[    0.936171] FDC 0 is a post-1991 82077
[    0.937567] usbcore: registered new interface driver usbfs
[    0.937585] usbcore: registered new interface driver hub
[    0.937601] usbcore: registered new device driver usb
[    0.939851] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    0.939869] ehci_hcd 0000:00:1a.7: PCI INT C -> GSI 18 (level, low) -> IRQ 18
[    0.939880] ehci_hcd 0000:00:1a.7: setting latency timer to 64
[    0.939882] ehci_hcd 0000:00:1a.7: EHCI Host Controller
[    0.939904] ehci_hcd 0000:00:1a.7: new USB bus registered, assigned bus number 1
[    0.943791] ehci_hcd 0000:00:1a.7: debug port 1
[    0.943795] ehci_hcd 0000:00:1a.7: cache line size of 32 is not supported
[    0.943805] ehci_hcd 0000:00:1a.7: irq 18, io mem 0xf9fffc00
[    0.947946] SCSI subsystem initialized
[    0.956504] ehci_hcd 0000:00:1a.7: USB 2.0 started, EHCI 1.00
[    0.956514] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
[    0.956516] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    0.956517] usb usb1: Product: EHCI Host Controller
[    0.956519] usb usb1: Manufacturer: Linux 2.6.30-1-686-bigmem ehci_hcd
[    0.956520] usb usb1: SerialNumber: 0000:00:1a.7
[    0.956555] usb usb1: configuration #1 chosen from 1 choice
[    0.956573] hub 1-0:1.0: USB hub found
[    0.956577] hub 1-0:1.0: 4 ports detected
[    0.956646] ehci_hcd 0000:00:1d.7: PCI INT A -> GSI 23 (level, low) -> IRQ 23
[    0.956653] ehci_hcd 0000:00:1d.7: setting latency timer to 64
[    0.956655] ehci_hcd 0000:00:1d.7: EHCI Host Controller
[    0.956668] ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 2
[    0.960557] ehci_hcd 0000:00:1d.7: debug port 1
[    0.960561] ehci_hcd 0000:00:1d.7: cache line size of 32 is not supported
[    0.960570] ehci_hcd 0000:00:1d.7: irq 23, io mem 0xf9fff800
[    0.966901] r8169 Gigabit Ethernet driver 2.3LK-NAPI loaded
[    0.966912] r8169 0000:04:00.0: PCI INT A -> GSI 17 (level, low) -> IRQ 17
[    0.966925] r8169 0000:04:00.0: setting latency timer to 64
[    0.967009] r8169 0000:04:00.0: irq 28 for MSI/MSI-X
[    0.967383] eth0: RTL8168b/8111b at 0xf83f2000, 00:19:db:b4:dd:ce, XID 38000000 IRQ 28
[    0.969610] libata version 3.00 loaded.
[    0.970270] pata_marvell 0000:03:00.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
[    0.970291] pata_marvell 0000:03:00.0: setting latency timer to 64
[    0.970328] scsi0 : pata_marvell
[    0.970380] scsi1 : pata_marvell
[    0.970402] ata1: PATA max UDMA/100 cmd 0xcc00 ctl 0xc880 bmdma 0xc400 irq 16
[    0.970404] ata2: PATA max UDMA/133 cmd 0xc800 ctl 0xc480 bmdma 0xc408 irq 16
[    0.976513] ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00
[    0.976536] usb usb2: New USB device found, idVendor=1d6b, idProduct=0002
[    0.976538] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    0.976539] usb usb2: Product: EHCI Host Controller
[    0.976541] usb usb2: Manufacturer: Linux 2.6.30-1-686-bigmem ehci_hcd
[    0.976542] usb usb2: SerialNumber: 0000:00:1d.7
[    0.976579] usb usb2: configuration #1 chosen from 1 choice
[    0.976597] hub 2-0:1.0: USB hub found
[    0.976602] hub 2-0:1.0: 8 ports detected
[    0.976680] ahci 0000:00:1f.2: version 3.0
[    0.976689] ahci 0000:00:1f.2: PCI INT B -> GSI 19 (level, low) -> IRQ 19
[    0.976713] ahci 0000:00:1f.2: irq 29 for MSI/MSI-X
[    0.976753] ahci: SSS flag set, parallel bus scan disabled
[    0.976780] ahci 0000:00:1f.2: AHCI 0001.0200 32 slots 6 ports 3 Gbps 0x3f impl SATA mode
[    0.976782] ahci 0000:00:1f.2: flags: 64bit ncq sntf stag pm led clo pio slum part ems 
[    0.976786] ahci 0000:00:1f.2: setting latency timer to 64
[    0.982253] scsi2 : ahci
[    0.982293] scsi3 : ahci
[    0.982324] scsi4 : ahci
[    0.982356] scsi5 : ahci
[    0.982387] scsi6 : ahci
[    0.982419] scsi7 : ahci
[    0.982503] ata3: SATA max UDMA/133 abar m2048@0xf9fff000 port 0xf9fff100 irq 29
[    0.982505] ata4: SATA max UDMA/133 abar m2048@0xf9fff000 port 0xf9fff180 irq 29
[    0.982507] ata5: SATA max UDMA/133 abar m2048@0xf9fff000 port 0xf9fff200 irq 29
[    0.982509] ata6: SATA max UDMA/133 abar m2048@0xf9fff000 port 0xf9fff280 irq 29
[    0.982511] ata7: SATA max UDMA/133 abar m2048@0xf9fff000 port 0xf9fff300 irq 29
[    0.982513] ata8: SATA max UDMA/133 abar m2048@0xf9fff000 port 0xf9fff380 irq 29
[    1.044326] uhci_hcd: USB Universal Host Controller Interface driver
[    1.044364] uhci_hcd 0000:00:1a.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
[    1.044371] uhci_hcd 0000:00:1a.0: setting latency timer to 64
[    1.044374] uhci_hcd 0000:00:1a.0: UHCI Host Controller
[    1.044395] uhci_hcd 0000:00:1a.0: new USB bus registered, assigned bus number 3
[    1.044416] uhci_hcd 0000:00:1a.0: irq 16, io base 0x0000ac00
[    1.044442] usb usb3: New USB device found, idVendor=1d6b, idProduct=0001
[    1.044443] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.044445] usb usb3: Product: UHCI Host Controller
[    1.044446] usb usb3: Manufacturer: Linux 2.6.30-1-686-bigmem uhci_hcd
[    1.044448] usb usb3: SerialNumber: 0000:00:1a.0
[    1.044491] usb usb3: configuration #1 chosen from 1 choice
[    1.044544] hub 3-0:1.0: USB hub found
[    1.044548] hub 3-0:1.0: 2 ports detected
[    1.044613] uhci_hcd 0000:00:1a.1: PCI INT B -> GSI 21 (level, low) -> IRQ 21
[    1.044617] uhci_hcd 0000:00:1a.1: setting latency timer to 64
[    1.044620] uhci_hcd 0000:00:1a.1: UHCI Host Controller
[    1.044633] uhci_hcd 0000:00:1a.1: new USB bus registered, assigned bus number 4
[    1.044657] uhci_hcd 0000:00:1a.1: irq 21, io base 0x0000a880
[    1.044675] usb usb4: New USB device found, idVendor=1d6b, idProduct=0001
[    1.044677] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.044679] usb usb4: Product: UHCI Host Controller
[    1.044680] usb usb4: Manufacturer: Linux 2.6.30-1-686-bigmem uhci_hcd
[    1.044681] usb usb4: SerialNumber: 0000:00:1a.1
[    1.044708] usb usb4: configuration #1 chosen from 1 choice
[    1.044724] hub 4-0:1.0: USB hub found
[    1.044727] hub 4-0:1.0: 2 ports detected
[    1.044787] uhci_hcd 0000:00:1d.0: PCI INT A -> GSI 23 (level, low) -> IRQ 23
[    1.044791] uhci_hcd 0000:00:1d.0: setting latency timer to 64
[    1.044793] uhci_hcd 0000:00:1d.0: UHCI Host Controller
[    1.044806] uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 5
[    1.044824] uhci_hcd 0000:00:1d.0: irq 23, io base 0x0000a800
[    1.044842] usb usb5: New USB device found, idVendor=1d6b, idProduct=0001
[    1.044843] usb usb5: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.044845] usb usb5: Product: UHCI Host Controller
[    1.044846] usb usb5: Manufacturer: Linux 2.6.30-1-686-bigmem uhci_hcd
[    1.044848] usb usb5: SerialNumber: 0000:00:1d.0
[    1.044876] usb usb5: configuration #1 chosen from 1 choice
[    1.044892] hub 5-0:1.0: USB hub found
[    1.044896] hub 5-0:1.0: 2 ports detected
[    1.044952] uhci_hcd 0000:00:1d.1: PCI INT B -> GSI 19 (level, low) -> IRQ 19
[    1.044957] uhci_hcd 0000:00:1d.1: setting latency timer to 64
[    1.044959] uhci_hcd 0000:00:1d.1: UHCI Host Controller
[    1.044975] uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 6
[    1.044998] uhci_hcd 0000:00:1d.1: irq 19, io base 0x0000a480
[    1.045017] usb usb6: New USB device found, idVendor=1d6b, idProduct=0001
[    1.045019] usb usb6: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.045021] usb usb6: Product: UHCI Host Controller
[    1.045022] usb usb6: Manufacturer: Linux 2.6.30-1-686-bigmem uhci_hcd
[    1.045023] usb usb6: SerialNumber: 0000:00:1d.1
[    1.045051] usb usb6: configuration #1 chosen from 1 choice
[    1.045068] hub 6-0:1.0: USB hub found
[    1.045072] hub 6-0:1.0: 2 ports detected
[    1.045132] uhci_hcd 0000:00:1d.2: PCI INT C -> GSI 18 (level, low) -> IRQ 18
[    1.045136] uhci_hcd 0000:00:1d.2: setting latency timer to 64
[    1.045139] uhci_hcd 0000:00:1d.2: UHCI Host Controller
[    1.045152] uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 7
[    1.045170] uhci_hcd 0000:00:1d.2: irq 18, io base 0x0000a400
[    1.045189] usb usb7: New USB device found, idVendor=1d6b, idProduct=0001
[    1.045191] usb usb7: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.045193] usb usb7: Product: UHCI Host Controller
[    1.045194] usb usb7: Manufacturer: Linux 2.6.30-1-686-bigmem uhci_hcd
[    1.045195] usb usb7: SerialNumber: 0000:00:1d.2
[    1.045224] usb usb7: configuration #1 chosen from 1 choice
[    1.045242] hub 7-0:1.0: USB hub found
[    1.045246] hub 7-0:1.0: 2 ports detected
[    1.046169] uhci_hcd 0000:00:1d.3: PCI INT D -> GSI 16 (level, low) -> IRQ 16
[    1.046173] uhci_hcd 0000:00:1d.3: setting latency timer to 64
[    1.046175] uhci_hcd 0000:00:1d.3: UHCI Host Controller
[    1.046191] uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 8
[    1.046209] uhci_hcd 0000:00:1d.3: irq 16, io base 0x0000a080
[    1.046229] usb usb8: New USB device found, idVendor=1d6b, idProduct=0001
[    1.046230] usb usb8: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.046232] usb usb8: Product: UHCI Host Controller
[    1.046233] usb usb8: Manufacturer: Linux 2.6.30-1-686-bigmem uhci_hcd
[    1.046235] usb usb8: SerialNumber: 0000:00:1d.3
[    1.046266] usb usb8: configuration #1 chosen from 1 choice
[    1.046283] hub 8-0:1.0: USB hub found
[    1.046286] hub 8-0:1.0: 2 ports detected
[    1.288008] usb 2-1: new high speed USB device using ehci_hcd and address 2
[    1.314625] ata3: SATA link down (SStatus 0 SControl 300)
[    1.421696] usb 2-1: New USB device found, idVendor=05e3, idProduct=0608
[    1.421697] usb 2-1: New USB device strings: Mfr=0, Product=1, SerialNumber=0
[    1.421699] usb 2-1: Product: USB2.0 Hub
[    1.421738] usb 2-1: configuration #1 chosen from 1 choice
[    1.421963] hub 2-1:1.0: USB hub found
[    1.422322] hub 2-1:1.0: 4 ports detected
[    1.588505] usb 2-6: new high speed USB device using ehci_hcd and address 4
[    1.721249] usb 2-6: New USB device found, idVendor=05e3, idProduct=0608
[    1.721251] usb 2-6: New USB device strings: Mfr=0, Product=1, SerialNumber=0
[    1.721253] usb 2-6: Product: USB2.0 Hub
[    1.721281] usb 2-6: configuration #1 chosen from 1 choice
[    1.721515] hub 2-6:1.0: USB hub found
[    1.721875] hub 2-6:1.0: 4 ports detected
[    1.960006] usb 6-2: new low speed USB device using uhci_hcd and address 2
[    2.156213] usb 6-2: New USB device found, idVendor=051d, idProduct=0002
[    2.156215] usb 6-2: New USB device strings: Mfr=3, Product=1, SerialNumber=2
[    2.156217] usb 6-2: Product: Smart-UPS 750 FW:651.13.D USB FW:7.3
[    2.156218] usb 6-2: Manufacturer: American Power Conversion
[    2.156220] usb 6-2: SerialNumber: AS0737140570
[    2.156251] usb 6-2: configuration #1 chosen from 1 choice
[    2.236342] usb 2-6.3: new low speed USB device using ehci_hcd and address 5
[    2.333481] usb 2-6.3: New USB device found, idVendor=046d, idProduct=c51b
[    2.333483] usb 2-6.3: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    2.333485] usb 2-6.3: Product: USB Receiver
[    2.333486] usb 2-6.3: Manufacturer: Logitech
[    2.333518] usb 2-6.3: configuration #1 chosen from 1 choice
[    2.339532] usbcore: registered new interface driver hiddev
[    2.408247] usb 2-6.4: new low speed USB device using ehci_hcd and address 6
[    2.508137] usb 2-6.4: New USB device found, idVendor=047b, idProduct=0011
[    2.508139] usb 2-6.4: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    2.508141] usb 2-6.4: Product: Standard USB Keyboard 
[    2.508143] usb 2-6.4: Manufacturer: Silitek
[    2.508175] usb 2-6.4: configuration #1 chosen from 1 choice
[    3.928594] generic-usb 0003:051D:0002.0001: hiddev96,hidraw0: USB HID v1.10 Device [American Power Conversion Smart-UPS 750 FW:651.13.D USB FW:7.3] on usb-0000:00:1d.1-2/input0
[    3.930899] input: Logitech USB Receiver as /devices/pci0000:00/0000:00:1d.7/usb2/2-6/2-6.3/2-6.3:1.0/input/input0
[    3.930927] generic-usb 0003:046D:C51B.0002: input,hidraw1: USB HID v1.11 Mouse [Logitech USB Receiver] on usb-0000:00:1d.7-6.3/input0
[    3.932915] generic-usb 0003:046D:C51B.0003: hiddev97,hidraw2: USB HID v1.11 Device [Logitech USB Receiver] on usb-0000:00:1d.7-6.3/input1
[    3.936919] input: Silitek Standard USB Keyboard  as /devices/pci0000:00/0000:00:1d.7/usb2/2-6/2-6.4/2-6.4:1.0/input/input1
[    3.936944] generic-usb 0003:047B:0011.0004: input,hidraw3: USB HID v1.00 Keyboard [Silitek Standard USB Keyboard ] on usb-0000:00:1d.7-6.4/input0
[    3.936953] usbcore: registered new interface driver usbhid
[    3.936954] usbhid: v2.6:USB HID core driver
[    6.312129] ata2.00: qc timeout (cmd 0xa1)
[    6.312135] ata2.00: failed to IDENTIFY (I/O error, err_mask=0x4)
[   11.352006] ata2: link is slow to respond, please be patient (ready=0)
[   16.336009] ata2: device not ready (errno=-16), forcing hardreset
[   21.532007] ata2: link is slow to respond, please be patient (ready=0)
[   26.348009] ata2: SRST failed (errno=-16)
[   31.544008] ata2: link is slow to respond, please be patient (ready=0)
[   36.360014] ata2: SRST failed (errno=-16)
[   36.544307] ata2.00: ATAPI: ASUS    DRW-2014L1T, 1.02, max UDMA/66
[   36.560317] ata2.00: configured for UDMA/66
[   36.576547] scsi 1:0:0:0: CD-ROM            ASUS     DRW-2014L1T      1.02 PQ: 0 ANSI: 5
[   36.896010] ata4: SATA link down (SStatus 0 SControl 300)
[   37.232011] ata5: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[   37.233738] ata5.00: ATA-8: ST31000340AS, SD1A, max UDMA/133
[   37.233740] ata5.00: 1953525168 sectors, multi 0: LBA48 NCQ (depth 31/32)
[   37.235928] ata5.00: configured for UDMA/133
[   37.248045] scsi 4:0:0:0: Direct-Access     ATA      ST31000340AS     SD1A PQ: 0 ANSI: 5
[   37.972011] ata6: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[   37.972718] ata6.00: ATA-8: WDC WD1001FALS-00J7B0, 05.00K05, max UDMA/133
[   37.972720] ata6.00: 1953525168 sectors, multi 0: LBA48 NCQ (depth 31/32)
[   37.973516] ata6.00: configured for UDMA/133
[   37.988043] scsi 5:0:0:0: Direct-Access     ATA      WDC WD1001FALS-0 05.0 PQ: 0 ANSI: 5
[   38.712013] ata7: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[   38.712692] ata7.00: ATA-8: WDC WD1001FALS-00J7B0, 05.00K05, max UDMA/133
[   38.712694] ata7.00: 1953525168 sectors, multi 0: LBA48 NCQ (depth 31/32)
[   38.713459] ata7.00: configured for UDMA/133
[   38.728044] scsi 6:0:0:0: Direct-Access     ATA      WDC WD1001FALS-0 05.0 PQ: 0 ANSI: 5
[   39.452013] ata8: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[   39.452674] ata8.00: ATA-8: WDC WD1001FALS-00J7B1, 05.00K05, max UDMA/133
[   39.452676] ata8.00: 1953525168 sectors, multi 0: LBA48 NCQ (depth 31/32)
[   39.453414] ata8.00: configured for UDMA/133
[   39.468045] scsi 7:0:0:0: Direct-Access     ATA      WDC WD1001FALS-0 05.0 PQ: 0 ANSI: 5
[   39.475330] Uniform Multi-Platform E-IDE driver
[   39.491252] Driver 'sr' needs updating - please use bus_type methods
[   39.495066] Driver 'sd' needs updating - please use bus_type methods
[   39.495073] sr0: scsi3-mmc drive: 48x/48x writer dvd-ram cd/rw xa/form2 cdda tray
[   39.495075] Uniform CD-ROM driver Revision: 3.20
[   39.495127] sr 1:0:0:0: Attached scsi CD-ROM sr0
[   39.495244] sd 4:0:0:0: [sda] 1953525168 512-byte hardware sectors: (1.00 TB/931 GiB)
[   39.495253] sd 4:0:0:0: [sda] Write Protect is off
[   39.495255] sd 4:0:0:0: [sda] Mode Sense: 00 3a 00 00
[   39.495268] sd 4:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   39.495317]  sda:<5>sd 5:0:0:0: [sdb] 1953525168 512-byte hardware sectors: (1.00 TB/931 GiB)
[   39.495369] sd 5:0:0:0: [sdb] Write Protect is off
[   39.495371] sd 5:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[   39.495383] sd 5:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   39.495429]  sdb:<5>sd 6:0:0:0: [sdc] 1953525168 512-byte hardware sectors: (1.00 TB/931 GiB)
[   39.495476] sd 6:0:0:0: [sdc] Write Protect is off
[   39.495478] sd 6:0:0:0: [sdc] Mode Sense: 00 3a 00 00
[   39.495490] sd 6:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   39.495535]  sdc:<5>sd 7:0:0:0: [sdd] 1953525168 512-byte hardware sectors: (1.00 TB/931 GiB)
[   39.495586] sd 7:0:0:0: [sdd] Write Protect is off
[   39.495588] sd 7:0:0:0: [sdd] Mode Sense: 00 3a 00 00
[   39.495600] sd 7:0:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   39.495645]  sdd:<5>sr 1:0:0:0: Attached scsi generic sg0 type 5
[   39.501751] sd 4:0:0:0: Attached scsi generic sg1 type 0
[   39.501768] sd 5:0:0:0: Attached scsi generic sg2 type 0
[   39.501784] sd 6:0:0:0: Attached scsi generic sg3 type 0
[   39.501801] sd 7:0:0:0: Attached scsi generic sg4 type 0
[   39.504595]  sda1 sda2 sda3 sda4
[   39.504693] sd 4:0:0:0: [sda] Attached SCSI disk
[   39.505674]  sdb1 sdb2 sdb3 sdb4
[   39.505766] sd 5:0:0:0: [sdb] Attached SCSI disk
[   39.505901]  sdc1 sdc2 sdc3 sdc4
[   39.505999] sd 6:0:0:0: [sdc] Attached SCSI disk
[   39.506299]  unknown partition table
[   39.506332] sd 7:0:0:0: [sdd] Attached SCSI disk
[   39.691729] md: raid1 personality registered for level 1
[   39.692659] xor: automatically using best checksumming function: pIII_sse
[   39.712500]    pIII_sse  : 11210.000 MB/sec
[   39.712502] xor: using function: pIII_sse (11210.000 MB/sec)
[   39.712718] async_tx: api initialized (sync-only)
[   39.780507] raid6: int32x1   1219 MB/s
[   39.848535] raid6: int32x2   1225 MB/s
[   39.916534] raid6: int32x4    897 MB/s
[   39.984513] raid6: int32x8    818 MB/s
[   40.052504] raid6: mmxx1     3758 MB/s
[   40.120512] raid6: mmxx2     4264 MB/s
[   40.188518] raid6: sse1x1    2627 MB/s
[   40.256518] raid6: sse1x2    3282 MB/s
[   40.324507] raid6: sse2x1    4923 MB/s
[   40.392509] raid6: sse2x2    5574 MB/s
[   40.392511] raid6: using algorithm sse2x2 (5574 MB/s)
[   40.394300] md: raid6 personality registered for level 6
[   40.394302] md: raid5 personality registered for level 5
[   40.394303] md: raid4 personality registered for level 4
[   40.466811] md: md0 stopped.
[   40.469374] md: bind<sda1>
[   40.469482] md: bind<sdb1>
[   40.469588] md: bind<sdc1>
[   40.470940] raid1: raid set md0 active with 3 out of 3 mirrors
[   40.477103] md0: bitmap initialized from disk: read 10/10 pages, set 91 bits
[   40.477105] created bitmap (150 pages) for device md0
[   40.517929]  md0: unknown partition table
[   40.539812] md: md1 stopped.
[   40.541346] md: bind<sda2>
[   40.541456] md: bind<sdc2>
[   40.541575] md: bind<sdb2>
[   40.542462] raid5: device sdb2 operational as raid disk 0
[   40.542464] raid5: device sdc2 operational as raid disk 2
[   40.542466] raid5: device sda2 operational as raid disk 1
[   40.542648] raid5: allocated 3178kB for md1
[   40.542665] raid5: raid level 5 set md1 active with 3 out of 3 devices, algorithm 2
[   40.542665] RAID5 conf printout:
[   40.542666]  --- rd:3 wd:3
[   40.542667]  disk 0, o:1, dev:sdb2
[   40.542669]  disk 1, o:1, dev:sda2
[   40.542670]  disk 2, o:1, dev:sdc2
[   40.552129] md1: bitmap initialized from disk: read 15/15 pages, set 9 bits
[   40.552131] created bitmap (228 pages) for device md1
[   40.587180]  md1: unknown partition table
[   40.614946] md: md2 stopped.
[   40.616554] md: bind<sda3>
[   40.616670] md: bind<sdc3>
[   40.616774] md: bind<sdb3>
[   40.617704] raid5: device sdb3 operational as raid disk 0
[   40.617705] raid5: device sdc3 operational as raid disk 2
[   40.617707] raid5: device sda3 operational as raid disk 1
[   40.617899] raid5: allocated 3178kB for md2
[   40.617911] raid5: raid level 5 set md2 active with 3 out of 3 devices, algorithm 2
[   40.617913] RAID5 conf printout:
[   40.617914]  --- rd:3 wd:3
[   40.617915]  disk 0, o:1, dev:sdb3
[   40.617916]  disk 1, o:1, dev:sda3
[   40.617917]  disk 2, o:1, dev:sdc3
[   40.627314] md2: bitmap initialized from disk: read 15/15 pages, set 0 bits
[   40.627316] created bitmap (228 pages) for device md2
[   40.664448]  md2: unknown partition table
[   40.740440] md: md3 stopped.
[   40.742736] md: bind<sdc4>
[   40.742863] md: bind<sdb4>
[   40.743090] md: bind<sda4>
[   40.744084] raid1: raid set md3 active with 2 out of 2 mirrors
[   40.744818]  md3: unknown partition table
[   40.803160] PM: Starting manual resume from disk
[   40.813250] EXT3-fs: INFO: recovery required on readonly filesystem.
[   40.813252] EXT3-fs: write access will be enabled during recovery.
[   43.862859] kjournald starting.  Commit interval 5 seconds
[   43.862869] EXT3-fs: md0: orphan cleanup on readonly fs
[   43.862872] ext3_orphan_cleanup: deleting unreferenced inode 203629
[   43.871712] EXT3-fs: md0: 1 orphan inode deleted
[   43.871714] EXT3-fs: recovery complete.
[   43.894207] EXT3-fs: mounted filesystem with ordered data mode.
[   44.902669] udev: starting version 141
[   45.044817] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input2
[   45.044834] ACPI: Power Button [PWRF]
[   45.044884] input: Power Button as /devices/LNXSYSTM:00/device:00/PNP0C0C:00/input/input3
[   45.044887] ACPI: Power Button [PWRB]
[   45.048478] ACPI: SSDT cffc00e0 00277 (v01 DpgPmm  P001Ist 00000011 INTL 20051117)
[   45.048654] processor ACPI_CPU:00: registered as cooling_device0
[   45.048881] ACPI: SSDT cffc0360 00277 (v01 DpgPmm  P002Ist 00000012 INTL 20051117)
[   45.049040] processor ACPI_CPU:01: registered as cooling_device1
[   45.101760] input: PC Speaker as /devices/platform/pcspkr/input/input4
[   45.112424] gameport: EMU10K1 is pci0000:05:00.1/gameport0, io 0xe880, speed 1084kHz
[   45.120075] i801_smbus 0000:00:1f.3: PCI INT C -> GSI 18 (level, low) -> IRQ 18
[   45.664472] EMU10K1_Audigy 0000:05:00.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
[   46.329201] Adding 4104504k swap on /dev/md3.  Priority:-1 extents:1 across:4104504k 
[   46.578889] EXT3 FS on md0, internal journal
[   46.692336] loop: module loaded
[   46.731034] device-mapper: uevent: version 1.0.3
[   46.731178] device-mapper: ioctl: 4.14.0-ioctl (2008-04-23) initialised: dm-devel@redhat.com
[   46.855941] fuse init (API version 7.11)
[   46.899665] f71882fg: Found f71882fg chip at 0xa00, revision 32
[   46.899898] f71882fg f71882fg.2560: Fan: 1 is in duty-cycle mode
[   46.899901] f71882fg f71882fg.2560: Fan: 2 is in duty-cycle mode
[   46.899903] f71882fg f71882fg.2560: Fan: 3 is in duty-cycle mode
[   46.899906] f71882fg f71882fg.2560: Fan: 4 is in duty-cycle mode
[   46.912457] coretemp coretemp.0: Using relative temperature scale!
[   46.912491] coretemp coretemp.1: Using relative temperature scale!
[   47.081141] SGI XFS with ACLs, security attributes, realtime, large block/inode numbers, no debug enabled
[   47.081835] SGI XFS Quota Management subsystem
[   47.104666] XFS mounting filesystem md1
[   47.295174] Ending clean XFS mount for filesystem: md1
[   48.785561] r8169: eth0: link up
[   48.785567] r8169: eth0: link up
[   57.193809] ip_tables: (C) 2000-2006 Netfilter Core Team
[   57.280309] nf_conntrack version 0.5.0 (16384 buckets, 65536 max)
[   57.280405] CONFIG_NF_CT_ACCT is deprecated and will be removed soon. Please use
[   57.280407] nf_conntrack.acct=1 kernel paramater, acct=1 nf_conntrack module option or
[   57.280409] sysctl net.netfilter.nf_conntrack_acct=1 to enable it.
[   59.468503] eth0: no IPv6 routers present
