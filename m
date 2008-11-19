From: fdc-lide@cutlass.ping.de (Frank D. Cringle)
Subject: Re: AHCI backplane errors in 2.6.27
Date: Wed, 19 Nov 2008 21:21:44 +0100
Message-ID: <871vx7a2lj.fsf@cutlass.ping.de>
References: <efeafa350811180733h6115dbc9t5a33abf55e774388@mail.gmail.com>
	<87abbw9hm1.fsf@cutlass.ping.de> <4924665D.4090300@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from lilly.ping.de ([83.97.42.2]:4004 "HELO lilly.ping.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752927AbYKSUWS (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 19 Nov 2008 15:22:18 -0500
In-Reply-To: <4924665D.4090300@redhat.com> (David Milburn's message of "Wed, 19 Nov 2008 13:17:49 -0600")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

--=-=-=

David Milburn writes:
> Frank D. Cringle wrote:
>> Lazy <lazy404@gmail.com> writes:
>>> When booting 2.6.27-rc1 kernel on out intel SR1530HSH ( Quad core Xeon X3320)
>>> Sata controller is ICH9r running in AHCI mode with newest bios.
>>>
>>> After loading ahci driver backplane leds go amber which indicates a
>>> non fatal error according to my intel resseller.
>> I see the same effect on a "FUJITSU SIEMENS PRIMERGY TX150 S6" which
>> also has a ICH9r, running with the fake megaraid disabled in the bios.
>> This has 4 hotswap drive bays. When I boot from drive 0, the remaining
>> drives all blink their orange fault led.
>
> ahci_sw_activity_blink should only be changing the state of
> the activity led only when emp->activity has changed.
>
> From the sata ahci spec for Byte 2-3 of the led message
>
> The LED bit locations are:
>        Bits 2:0 - Activity LED (may be driven by hardware)
>        Bits 5:3 - Vendor Specific LED (e.g. locate)
>        Bits 8:6 - Vendor Specific LED (e.g. fault)
>        Bits 15:9 - Reserved
>
> Does this patch (against 2.6.27) make a difference?

Afraid not. When I boot without ahci.ahci_em_messages=0, the LEDs on
drives 1,2,3 all blink continuously. Other than that, there does not
seem to be a problem.


--=-=-=
Content-Disposition: inline; filename=dmesg
Content-Description: boot log

[    0.000000] Linux version 2.6.27-gentoo-r3 (root@bowie) (gcc version 4.3.2 (Gentoo 4.3.2 p1.0) ) #3 SMP Wed Nov 19 21:03:46 CET 2008
[    0.000000] Command line: root=/dev/md3 vga=0x31a video=vesafb:ypan
[    0.000000] KERNEL supported cpus:
[    0.000000]   Intel GenuineIntel
[    0.000000]   AMD AuthenticAMD
[    0.000000]   Centaur CentaurHauls
[    0.000000] BIOS-provided physical RAM map:
[    0.000000]  BIOS-e820: 0000000000000000 - 000000000009cc00 (usable)
[    0.000000]  BIOS-e820: 000000000009cc00 - 00000000000a0000 (reserved)
[    0.000000]  BIOS-e820: 00000000000e4000 - 0000000000100000 (reserved)
[    0.000000]  BIOS-e820: 0000000000100000 - 000000007feb0000 (usable)
[    0.000000]  BIOS-e820: 000000007feb0000 - 000000007feb7000 (ACPI data)
[    0.000000]  BIOS-e820: 000000007feb7000 - 000000007feba000 (ACPI NVS)
[    0.000000]  BIOS-e820: 000000007feba000 - 0000000080000000 (reserved)
[    0.000000]  BIOS-e820: 00000000e0000000 - 00000000e4000000 (reserved)
[    0.000000]  BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
[    0.000000]  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
[    0.000000]  BIOS-e820: 00000000ffb00000 - 0000000100000000 (reserved)
[    0.000000]  BIOS-e820: 0000000100000000 - 0000000200000000 (usable)
[    0.000000] DMI present.
[    0.000000] last_pfn = 0x200000 max_arch_pfn = 0x3ffffffff
[    0.000000] x86 PAT enabled: cpu 0, old 0x7040600070406, new 0x7010600070106
[    0.000000] last_pfn = 0x7feb0 max_arch_pfn = 0x3ffffffff
[    0.000000] init_memory_mapping
[    0.000000]  0000000000 - 007fe00000 page 2M
[    0.000000]  007fe00000 - 007feb0000 page 4k
[    0.000000] kernel direct mapping tables up to 7feb0000 @ 8000-c000
[    0.000000] last_map_addr: 7feb0000 end: 7feb0000
[    0.000000] init_memory_mapping
[    0.000000]  0100000000 - 0200000000 page 2M
[    0.000000] kernel direct mapping tables up to 200000000 @ a000-13000
[    0.000000] last_map_addr: 200000000 end: 200000000
[    0.000000] ACPI: RSDP 000F79D0, 0014 (r0 PTLTD )
[    0.000000] ACPI: RSDT 7FEB19D2, 005C (r1 PTLTD    RSDT      60000  LTP        0)
[    0.000000] ACPI: FACP 7FEB6579, 0074 (r1 FSC                60000         F4240)
[    0.000000] ACPI: DSDT 7FEB1A2E, 4B4B (r1 FSC    D2559       60000 MSFT  3000001)
[    0.000000] ACPI: FACS 7FEB9FC0, 0040
[    0.000000] ACPI: TCPA 7FEB65ED, 0032 (r1 Phoeni  x          60000  TL         0)
[    0.000000] ACPI: EINJ 7FEB661F, 01B0 (r1 PTL    WHEAPTL     60000 PTL         1)
[    0.000000] ACPI: HEST 7FEB67CF, 0268 (r1 PTL    WHEAPTL     60000 PTL         1)
[    0.000000] ACPI: BERT 7FEB6A37, 0030 (r1 PTL    WHEAPTL     60000 PTL         1)
[    0.000000] ACPI: SSDT 7FEB6A67, 00E1 (r1 wheaos  wheaosc    60000 INTL 20050624)
[    0.000000] ACPI: ERST 7FEB6B48, 0270 (r1 PTL    WHEAPTL     60000 PTL         1)
[    0.000000] ACPI: SSDT 7FEB6DB8, 007A (r1 FSC    CST_CPU0    60000  CSF        1)
[    0.000000] ACPI: SSDT 7FEB6E32, 007A (r1 FSC    CST_CPU1    60000  CSF        1)
[    0.000000] ACPI: SPCR 7FEB6EAC, 0050 (r1 PTLTD  $UCRTBL$    60000 PTL         1)
[    0.000000] ACPI: MCFG 7FEB6EFC, 003C (r1 PTLTD    MCFG      60000  LTP        0)
[    0.000000] ACPI: HPET 7FEB6F38, 0038 (r1 PTLTD  HPETTBL     60000  LTP        1)
[    0.000000] ACPI: APIC 7FEB6F70, 0068 (r1 PTLTD  	 APIC      60000  LTP        0)
[    0.000000] ACPI: BOOT 7FEB6FD8, 0028 (r1 PTLTD  $SBFTBL$    60000  LTP        1)
[    0.000000] ACPI: DMI detected: Fujitsu Siemens
[    0.000000] (6 early reservations) ==> bootmem [0000000000 - 0200000000]
[    0.000000]   #0 [0000000000 - 0000001000]   BIOS data page ==> [0000000000 - 0000001000]
[    0.000000]   #1 [0000006000 - 0000008000]       TRAMPOLINE ==> [0000006000 - 0000008000]
[    0.000000]   #2 [0000200000 - 00009c3898]    TEXT DATA BSS ==> [0000200000 - 00009c3898]
[    0.000000]   #3 [000009cc00 - 0000100000]    BIOS reserved ==> [000009cc00 - 0000100000]
[    0.000000]   #4 [0000008000 - 000000a000]          PGTABLE ==> [0000008000 - 000000a000]
[    0.000000]   #5 [000000a000 - 000000e000]          PGTABLE ==> [000000a000 - 000000e000]
[    0.000000]  [ffffe20000000000-ffffe20006ffffff] PMD -> [ffff880028200000-ffff88002f1fffff] on node 0
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA      0x00000000 -> 0x00001000
[    0.000000]   DMA32    0x00001000 -> 0x00100000
[    0.000000]   Normal   0x00100000 -> 0x00200000
[    0.000000] Movable zone start PFN for each node
[    0.000000] early_node_map[3] active PFN ranges
[    0.000000]     0: 0x00000000 -> 0x0000009c
[    0.000000]     0: 0x00000100 -> 0x0007feb0
[    0.000000]     0: 0x00100000 -> 0x00200000
[    0.000000] On node 0 totalpages: 1572428
[    0.000000]   DMA zone: 1845 pages, LIFO batch:0
[    0.000000]   DMA32 zone: 505576 pages, LIFO batch:31
[    0.000000]   Normal zone: 1034240 pages, LIFO batch:31
[    0.000000] ACPI: PM-Timer IO Port: 0x1008
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
[    0.000000] ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 2, version 0, address 0xfec00000, GSI 0-23
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 high edge)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ2 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Setting APIC routing to flat
[    0.000000] ACPI: HPET id: 0xffffffff base: 0xfed00000
[    0.000000] SMP: Allowing 2 CPUs, 0 hotplug CPUs
[    0.000000] PM: Registered nosave memory: 000000000009c000 - 000000000009d000
[    0.000000] PM: Registered nosave memory: 000000000009d000 - 00000000000a0000
[    0.000000] PM: Registered nosave memory: 00000000000a0000 - 00000000000e4000
[    0.000000] PM: Registered nosave memory: 00000000000e4000 - 0000000000100000
[    0.000000] PM: Registered nosave memory: 000000007feb0000 - 000000007feb7000
[    0.000000] PM: Registered nosave memory: 000000007feb7000 - 000000007feba000
[    0.000000] PM: Registered nosave memory: 000000007feba000 - 0000000080000000
[    0.000000] PM: Registered nosave memory: 0000000080000000 - 00000000e0000000
[    0.000000] PM: Registered nosave memory: 00000000e0000000 - 00000000e4000000
[    0.000000] PM: Registered nosave memory: 00000000e4000000 - 00000000fec00000
[    0.000000] PM: Registered nosave memory: 00000000fec00000 - 00000000fec10000
[    0.000000] PM: Registered nosave memory: 00000000fec10000 - 00000000fee00000
[    0.000000] PM: Registered nosave memory: 00000000fee00000 - 00000000fee01000
[    0.000000] PM: Registered nosave memory: 00000000fee01000 - 00000000ffb00000
[    0.000000] PM: Registered nosave memory: 00000000ffb00000 - 0000000100000000
[    0.000000] Allocating PCI resources starting at 88000000 (gap: 80000000:60000000)
[    0.000000] PERCPU: Allocating 56096 bytes of per cpu data
[    0.000000] NR_CPUS: 4, nr_cpu_ids: 2, nr_node_ids 1
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 1541661
[    0.000000] Kernel command line: root=/dev/md3 vga=0x31a video=vesafb:ypan
[    0.000000] Initializing CPU#0
[    0.000000] PID hash table entries: 4096 (order: 12, 32768 bytes)
[    0.000000] TSC: PIT calibration confirmed by PMTIMER.
[    0.000000] TSC: using PIT calibration value
[    0.000000] Detected 2992.472 MHz processor.
[    0.000999] Console: colour dummy device 80x25
[    0.000999] console [tty0] enabled
[    0.000999] Dentry cache hash table entries: 1048576 (order: 11, 8388608 bytes)
[    0.000999] Inode-cache hash table entries: 524288 (order: 10, 4194304 bytes)
[    0.000999] Checking aperture...
[    0.000999] No AGP bridge found
[    0.000999] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    0.000999] Placing software IO TLB between 0x20000000 - 0x24000000
[    0.000999] Memory: 6087468k/8388608k available (4615k kernel code, 201300k reserved, 1926k data, 452k init)
[    0.000999] CPA: page pool initialized 1 of 1 pages preallocated
[    0.000999] SLUB: Genslabs=12, HWalign=64, Order=0-3, MinObjects=0, CPUs=2, Nodes=1
[    0.000999] hpet clockevent registered
[    0.000999] Calibrating delay loop (skipped), value calculated using timer frequency.. 5984.94 BogoMIPS (lpj=2992472)
[    0.000999] Mount-cache hash table entries: 256
[    0.000999] CPU: L1 I cache: 32K, L1 D cache: 32K
[    0.000999] CPU: L2 cache: 6144K
[    0.000999] CPU: Physical Processor ID: 0
[    0.000999] CPU: Processor Core ID: 0
[    0.000999] CPU0: Thermal monitoring enabled (TM2)
[    0.000999] using mwait in idle threads.
[    0.002115] ACPI: Core revision 20080609
[    0.009150] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.019158] CPU0: Intel(R) Xeon(R) CPU           E3110  @ 3.00GHz stepping 06
[    0.019163] Using local APIC timer interrupts.
[    0.020002] APIC timer calibration result 20781094
[    0.020004] Detected 20.781 MHz APIC timer.
[    0.020084] Booting processor 1/1 ip 6000
[    0.000999] Initializing CPU#1
[    0.000999] Calibrating delay using timer specific routine.. 5984.96 BogoMIPS (lpj=2992482)
[    0.000999] CPU: L1 I cache: 32K, L1 D cache: 32K
[    0.000999] CPU: L2 cache: 6144K
[    0.000999] CPU: Physical Processor ID: 0
[    0.000999] CPU: Processor Core ID: 1
[    0.000999] CPU1: Thermal monitoring enabled (TM2)
[    0.000999] x86 PAT enabled: cpu 1, old 0x7040600070406, new 0x7010600070106
[    0.092394] CPU1: Intel(R) Xeon(R) CPU           E3110  @ 3.00GHz stepping 06
[    0.092419] checking TSC synchronization [CPU#0 -> CPU#1]: passed.
[    0.093000] Brought up 2 CPUs
[    0.093003] Total of 2 processors activated (11969.90 BogoMIPS).
[    0.093063] net_namespace: 1440 bytes
[    0.093063] Booting paravirtualized kernel on bare hardware
[    0.093094] Time: 20:07:11  Date: 11/19/08
[    0.093094] NET: Registered protocol family 16
[    0.093094] No dock devices found.
[    0.093094] ACPI: bus type pci registered
[    0.093998] PCI: MCFG configuration 0: base e0000000 segment 0 buses 0 - 3
[    0.094002] PCI: MCFG area at e0000000 reserved in E820
[    0.094080] PCI: Using MMCONFIG at e0000000 - e03fffff
[    0.094082] PCI: Using configuration type 1 for base access
[    0.096075] ACPI: EC: Look up EC in DSDT
[    0.098869] ACPI: Interpreter enabled
[    0.098873] ACPI: (supports S0 S1 S4 S5)
[    0.098882] ACPI: Using IOAPIC for interrupt routing
[    0.101140] ACPI: Device [FDC] status [00000008]: functional but not present; setting present
[    0.101140] ACPI: Device [LPT] status [00000008]: functional but not present; setting present
[    0.101140] ACPI: Device [ECP] status [00000008]: functional but not present; setting present
[    0.102067] ACPI: Device [KCS1] status [00000008]: functional but not present; setting present
[    0.102067] ACPI: PCI Root Bridge [PCI0] (0000:00)
[    0.102067] PCI: 0000:00:1a.0 reg 20 io port: [1820, 183f]
[    0.102103] PCI: 0000:00:1a.1 reg 20 io port: [1840, 185f]
[    0.102149] PCI: 0000:00:1a.2 reg 20 io port: [1860, 187f]
[    0.102199] PCI: 0000:00:1a.7 reg 10 32bit mmio: [dfc00800, dfc00bff]
[    0.102235] pci 0000:00:1a.7: PME# supported from D0 D3hot D3cold
[    0.102240] pci 0000:00:1a.7: PME# disabled
[    0.102276] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    0.102279] pci 0000:00:1c.0: PME# disabled
[    0.102316] pci 0000:00:1c.4: PME# supported from D0 D3hot D3cold
[    0.102319] pci 0000:00:1c.4: PME# disabled
[    0.102354] pci 0000:00:1c.5: PME# supported from D0 D3hot D3cold
[    0.102358] pci 0000:00:1c.5: PME# disabled
[    0.102391] PCI: 0000:00:1d.0 reg 20 io port: [1880, 189f]
[    0.102437] PCI: 0000:00:1d.1 reg 20 io port: [18a0, 18bf]
[    0.102484] PCI: 0000:00:1d.2 reg 20 io port: [18c0, 18df]
[    0.102533] PCI: 0000:00:1d.7 reg 10 32bit mmio: [dfc00c00, dfc00fff]
[    0.102569] pci 0000:00:1d.7: PME# supported from D0 D3hot D3cold
[    0.102574] pci 0000:00:1d.7: PME# disabled
[    0.103068] pci 0000:00:1f.0: quirk: region 1000-107f claimed by ICH6 ACPI/GPIO/TCO
[    0.103072] pci 0000:00:1f.0: quirk: region 1180-11bf claimed by ICH6 GPIO
[    0.103107] PCI: 0000:00:1f.2 reg 10 io port: [1c50, 1c57]
[    0.103111] PCI: 0000:00:1f.2 reg 14 io port: [1c44, 1c47]
[    0.103115] PCI: 0000:00:1f.2 reg 18 io port: [1c48, 1c4f]
[    0.103118] PCI: 0000:00:1f.2 reg 1c io port: [1c40, 1c43]
[    0.103122] PCI: 0000:00:1f.2 reg 20 io port: [18e0, 18ff]
[    0.103126] PCI: 0000:00:1f.2 reg 24 32bit mmio: [dfc00000, dfc007ff]
[    0.103143] pci 0000:00:1f.2: PME# supported from D3hot
[    0.103146] pci 0000:00:1f.2: PME# disabled
[    0.103161] PCI: 0000:00:1f.3 reg 10 64bit mmio: [dfc01000, dfc010ff]
[    0.103170] PCI: 0000:00:1f.3 reg 20 io port: [1c00, 1c1f]
[    0.103209] PCI: bridge 0000:00:1c.0 io port: [0, fff]
[    0.103212] PCI: bridge 0000:00:1c.0 32bit mmio: [0, fffff]
[    0.103216] PCI: bridge 0000:00:1c.0 64bit mmio pref: [0, fffff]
[    0.103270] PCI: 0000:02:00.0 reg 10 64bit mmio: [df900000, df90ffff]
[    0.103313] pci 0000:02:00.0: PME# supported from D3hot D3cold
[    0.103317] pci 0000:02:00.0: PME# disabled
[    0.103343] PCI: bridge 0000:00:1c.4 32bit mmio: [df900000, df9fffff]
[    0.103387] PCI: 0000:03:00.0 reg 10 32bit mmio: [de000000, deffffff]
[    0.103395] PCI: 0000:03:00.0 reg 14 32bit mmio: [df800000, df803fff]
[    0.103403] PCI: 0000:03:00.0 reg 18 32bit mmio: [df000000, df7fffff]
[    0.103477] PCI: bridge 0000:00:1c.5 32bit mmio: [df000000, df8fffff]
[    0.103481] PCI: bridge 0000:00:1c.5 64bit mmio pref: [de000000, deffffff]
[    0.103518] pci 0000:00:1e.0: transparent bridge
[    0.103538] bus 00 -> node 0
[    0.103541] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[    0.103827] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PESA._PRT]
[    0.103910] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PESB._PRT]
[    0.103998] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PESC._PRT]
[    0.104090] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIH._PRT]
[    0.105068] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 7 9 *10 11 12 14 15)
[    0.106024] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 7 9 10 *11 12 14 15)
[    0.106097] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 7 *9 10 11 12 14 15)
[    0.106160] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 7 9 10 11 12 14 15) *0, disabled.
[    0.106225] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 7 9 10 11 12 14 15) *0, disabled.
[    0.106289] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 7 9 10 11 12 14 15) *0, disabled.
[    0.106353] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 7 9 10 11 12 14 15) *0, disabled.
[    0.106417] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 7 9 10 11 12 14 15) *0, disabled.
[    0.106456] Linux Plug and Play Support v0.97 (c) Adam Belay
[    0.106456] pnp: PnP ACPI init
[    0.106456] ACPI: bus type pnp registered
[    0.106456] pnp 00:00: parse allocated resources
[    0.106456] pnp 00:00:   add mem 0xe0000000-0xefffffff flags 0x1
[    0.106456] pnp 00:00: PNP0c02: calling quirk_system_pci_resources+0x0/0x182
[    0.106456] pnp 00:00: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.106456] pnp 00:01: parse allocated resources
[    0.107458] pnp 00:01:   add io  0xcf8-0xcff flags 0x1
[    0.107482] pnp 00:01: Plug and Play ACPI device, IDs PNP0a08 PNP0a03 (active)
[    0.107482] pnp 00:02: parse allocated resources
[    0.107482] pnp 00:02:   add mem 0xfed40000-0xfed44fff flags 0x1
[    0.107482] pnp 00:02: Plug and Play ACPI device, IDs IFX0102 PNP0c31 (active)
[    0.107482] pnp 00:03: parse allocated resources
[    0.107482] pnp 00:03:   add mem 0xffb00000-0xffbfffff flags 0x0
[    0.107482] pnp 00:03: Plug and Play ACPI device, IDs INT0800 (active)
[    0.107482] pnp 00:04: parse allocated resources
[    0.107482] pnp 00:04:   add io  0x10-0x1f flags 0x1
[    0.107482] pnp 00:04:   add io  0x22-0x2d flags 0x1
[    0.107482] pnp 00:04:   add io  0x2e-0x2f flags 0x1
[    0.107482] pnp 00:04:   add io  0x30-0x3f flags 0x1
[    0.107482] pnp 00:04:   add io  0x4e-0x4f flags 0x1
[    0.107482] pnp 00:04:   add io  0x50-0x53 flags 0x1
[    0.107482] pnp 00:04:   add io  0x62-0x63 flags 0x1
[    0.107482] pnp 00:04:   add io  0x65-0x6f flags 0x1
[    0.107482] pnp 00:04:   add io  0x72-0x73 flags 0x1
[    0.107482] pnp 00:04:   add io  0x74-0x7f flags 0x1
[    0.107482] pnp 00:04:   add io  0x90-0x9f flags 0x1
[    0.107482] pnp 00:04:   add io  0xa2-0xb1 flags 0x1
[    0.107482] pnp 00:04:   add io  0xb2-0xb3 flags 0x1
[    0.107482] pnp 00:04:   add io  0xb4-0xbf flags 0x1
[    0.107482] pnp 00:04:   add io  0xec-0xef flags 0x1
[    0.107482] pnp 00:04:   add io  0x400-0x40f flags 0x1
[    0.107482] pnp 00:04:   add io  0x4d0-0x4d1 flags 0x1
[    0.107482] pnp 00:04:   add io  0x500-0x57f flags 0x1
[    0.107482] pnp 00:04:   add io  0x800-0x80f flags 0x1
[    0.107482] pnp 00:04:   add io  0xca0-0xca1 flags 0x1
[    0.107482] pnp 00:04:   add io  0xca4-0xca7 flags 0x1
[    0.107482] pnp 00:04:   add io  0xcae-0xcaf flags 0x1
[    0.107482] pnp 00:04:   add io  0xe00-0xe7f flags 0x1
[    0.107482] pnp 00:04:   add io  0x1000-0x107f flags 0x1
[    0.107482] pnp 00:04:   add io  0x1100-0x110f flags 0x1
[    0.107482] pnp 00:04:   add io  0x1180-0x11bf flags 0x1
[    0.107482] pnp 00:04:   add io  0xfe00-0xfe00 flags 0x1
[    0.107482] pnp 00:04:   add io  0xff00-0xff00 flags 0x1
[    0.107482] pnp 00:04:   add mem 0xfec00000-0xfecfffff flags 0x0
[    0.107482] pnp 00:04:   add mem 0xfee00000-0xfeefffff flags 0x0
[    0.107482] pnp 00:04:   add mem 0xfed1c000-0xfed1ffff flags 0x1
[    0.107482] pnp 00:04:   add mem 0xfed13000-0xfed13fff flags 0x1
[    0.107482] pnp 00:04:   add mem 0xe0000000-0xefffffff flags 0x1
[    0.107482] pnp 00:04:   add mem 0xfed19000-0xfed19fff flags 0x1
[    0.107482] pnp 00:04:   add mem 0xfed14000-0xfed17fff flags 0x1
[    0.107482] pnp 00:04:   add mem 0xfed18000-0xfed18fff flags 0x1
[    0.107482] pnp 00:04: PNP0c02: calling quirk_system_pci_resources+0x0/0x182
[    0.107482] pnp 00:04: io resource (0x10-0x1f) overlaps 0000:00:1c.0 BAR 7 (0x0-0xfff), disabling
[    0.107482] pnp 00:04: io resource (0x22-0x2d) overlaps 0000:00:1c.0 BAR 7 (0x0-0xfff), disabling
[    0.107482] pnp 00:04: io resource (0x2e-0x2f) overlaps 0000:00:1c.0 BAR 7 (0x0-0xfff), disabling
[    0.107482] pnp 00:04: io resource (0x30-0x3f) overlaps 0000:00:1c.0 BAR 7 (0x0-0xfff), disabling
[    0.107482] pnp 00:04: io resource (0x4e-0x4f) overlaps 0000:00:1c.0 BAR 7 (0x0-0xfff), disabling
[    0.107482] pnp 00:04: io resource (0x50-0x53) overlaps 0000:00:1c.0 BAR 7 (0x0-0xfff), disabling
[    0.107482] pnp 00:04: io resource (0x62-0x63) overlaps 0000:00:1c.0 BAR 7 (0x0-0xfff), disabling
[    0.107482] pnp 00:04: io resource (0x65-0x6f) overlaps 0000:00:1c.0 BAR 7 (0x0-0xfff), disabling
[    0.107482] pnp 00:04: io resource (0x72-0x73) overlaps 0000:00:1c.0 BAR 7 (0x0-0xfff), disabling
[    0.107482] pnp 00:04: io resource (0x74-0x7f) overlaps 0000:00:1c.0 BAR 7 (0x0-0xfff), disabling
[    0.107482] pnp 00:04: io resource (0x90-0x9f) overlaps 0000:00:1c.0 BAR 7 (0x0-0xfff), disabling
[    0.107482] pnp 00:04: io resource (0xa2-0xb1) overlaps 0000:00:1c.0 BAR 7 (0x0-0xfff), disabling
[    0.107482] pnp 00:04: io resource (0xb2-0xb3) overlaps 0000:00:1c.0 BAR 7 (0x0-0xfff), disabling
[    0.107482] pnp 00:04: io resource (0xb4-0xbf) overlaps 0000:00:1c.0 BAR 7 (0x0-0xfff), disabling
[    0.107482] pnp 00:04: io resource (0xec-0xef) overlaps 0000:00:1c.0 BAR 7 (0x0-0xfff), disabling
[    0.107482] pnp 00:04: io resource (0x400-0x40f) overlaps 0000:00:1c.0 BAR 7 (0x0-0xfff), disabling
[    0.107482] pnp 00:04: io resource (0x4d0-0x4d1) overlaps 0000:00:1c.0 BAR 7 (0x0-0xfff), disabling
[    0.107482] pnp 00:04: io resource (0x500-0x57f) overlaps 0000:00:1c.0 BAR 7 (0x0-0xfff), disabling
[    0.107482] pnp 00:04: io resource (0x800-0x80f) overlaps 0000:00:1c.0 BAR 7 (0x0-0xfff), disabling
[    0.107985] pnp 00:04: io resource (0xca0-0xca1) overlaps 0000:00:1c.0 BAR 7 (0x0-0xfff), disabling
[    0.107988] pnp 00:04: io resource (0xca4-0xca7) overlaps 0000:00:1c.0 BAR 7 (0x0-0xfff), disabling
[    0.107992] pnp 00:04: io resource (0xcae-0xcaf) overlaps 0000:00:1c.0 BAR 7 (0x0-0xfff), disabling
[    0.107995] pnp 00:04: io resource (0xe00-0xe7f) overlaps 0000:00:1c.0 BAR 7 (0x0-0xfff), disabling
[    0.108042] pnp 00:04: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.108042] pnp 00:05: parse allocated resources
[    0.108042] pnp 00:05:   add io  0x0-0xf flags 0x1
[    0.108042] pnp 00:05:   add io  0x80-0x8f flags 0x1
[    0.108042] pnp 00:05:   add io  0xc0-0xdf flags 0x1
[    0.108042] pnp 00:05:   add dma 4 flags 0x2
[    0.108042] pnp 00:05: Plug and Play ACPI device, IDs PNP0200 (active)
[    0.108042] pnp 00:06: parse allocated resources
[    0.108042] pnp 00:06:   add io  0x70-0x71 flags 0x1
[    0.108042] pnp 00:06:   add irq 8 flags 0x1
[    0.108042] pnp 00:06: Plug and Play ACPI device, IDs PNP0b00 (active)
[    0.108042] pnp 00:07: parse allocated resources
[    0.108042] pnp 00:07:   add io  0xf0-0xfe flags 0x1
[    0.108042] pnp 00:07:   add irq 13 flags 0x1
[    0.108042] pnp 00:07: Plug and Play ACPI device, IDs PNP0c04 (active)
[    0.108042] pnp 00:08: parse allocated resources
[    0.108042] pnp 00:08:   add io  0x61-0x61 flags 0x1
[    0.108042] pnp 00:08: Plug and Play ACPI device, IDs PNP0800 (active)
[    0.108042] pnp 00:09: parse allocated resources
[    0.108064] pnp 00:09:   add mem 0xfed00000-0xfed003ff flags 0x1
[    0.108084] pnp 00:09: Plug and Play ACPI device, IDs PNP0103 (active)
[    0.108084] pnp 00:0a: parse allocated resources
[    0.108084] pnp 00:0a:   add io  0x60-0x60 flags 0x1
[    0.108084] pnp 00:0a:   add io  0x64-0x64 flags 0x1
[    0.108084] pnp 00:0a:   add irq 1 flags 0x1
[    0.108084] pnp 00:0a: Plug and Play ACPI device, IDs PNP0303 (active)
[    0.108084] pnp 00:0b: parse allocated resources
[    0.108084] pnp 00:0b:   add irq 12 flags 0x1
[    0.108084] pnp 00:0b: Plug and Play ACPI device, IDs PNP0f13 (active)
[    0.108084] pnp 00:0c: parse resource options
[    0.108084] pnp 00:0c:   independent io  min 0x3f0 max 0x3f0 align 1 size 6 flags 0x1
[    0.108084] pnp 00:0c:   independent io  min 0x3f7 max 0x3f7 align 1 size 1 flags 0x1
[    0.108084] pnp 00:0c:   independent dma 2 (bitmask 0x4) flags 0x2
[    0.108084] pnp 00:0c:   independent irq 6 flags 0x1
[    0.108084] pnp 00:0c: Plug and Play ACPI device, IDs PNP0700 (disabled)
[    0.108084] pnp 00:0d: parse resource options
[    0.108102] pnp 00:0d:   dependent set 0 (preferred) io  min 0x378 max 0x378 align 4 size 4 flags 0x1
[    0.108105] pnp 00:0d:   dependent set 0 (preferred) irq 7 flags 0x1
[    0.108107] pnp 00:0d:   dependent set 1 (acceptable) io  min 0x278 max 0x278 align 4 size 4 flags 0x1
[    0.108109] pnp 00:0d:   dependent set 1 (acceptable) irq 5 flags 0x1
[    0.108111] pnp 00:0d:   dependent set 2 (functional) io  min 0x3bc max 0x3bc align 4 size 4 flags 0x1
[    0.108114] pnp 00:0d:   dependent set 2 (functional) irq 7 flags 0x1
[    0.108135] pnp 00:0d: Plug and Play ACPI device, IDs PNP0400 (disabled)
[    0.108135] pnp 00:0e: parse resource options
[    0.108135] pnp 00:0e:   dependent set 0 (preferred) io  min 0x378 max 0x378 align 4 size 4 flags 0x1
[    0.108135] pnp 00:0e:   dependent set 0 (preferred) io  min 0x778 max 0x778 align 4 size 4 flags 0x1
[    0.108135] pnp 00:0e:   dependent set 0 (preferred) irq 5 7 flags 0x1
[    0.108135] pnp 00:0e:   dependent set 0 (preferred) dma 1 3 (bitmask 0xa) flags 0x2
[    0.108135] pnp 00:0e:   dependent set 1 (acceptable) io  min 0x278 max 0x278 align 4 size 4 flags 0x1
[    0.108135] pnp 00:0e:   dependent set 1 (acceptable) io  min 0x678 max 0x678 align 4 size 4 flags 0x1
[    0.108135] pnp 00:0e:   dependent set 1 (acceptable) irq 5 7 flags 0x1
[    0.108135] pnp 00:0e:   dependent set 1 (acceptable) dma 1 3 (bitmask 0xa) flags 0x2
[    0.108135] pnp 00:0e: Plug and Play ACPI device, IDs PNP0401 (disabled)
[    0.108986] pnp 00:0f: parse allocated resources
[    0.109116] pnp 00:0f:   add io  0x3f8-0x3ff flags 0x1
[    0.109120] pnp 00:0f:   add irq 4 flags 0x1
[    0.109121] pnp 00:0f: parse resource options
[    0.109125] pnp 00:0f:   dependent set 0 (preferred) io  min 0x3f8 max 0x3f8 align 8 size 8 flags 0x1
[    0.109128] pnp 00:0f:   dependent set 0 (preferred) irq 4 flags 0x1
[    0.109130] pnp 00:0f:   dependent set 1 (acceptable) io  min 0x3e8 max 0x3e8 align 8 size 8 flags 0x1
[    0.109132] pnp 00:0f:   dependent set 1 (acceptable) irq 4 flags 0x1
[    0.109134] pnp 00:0f:   dependent set 2 (functional) io  min 0x2f8 max 0x2f8 align 8 size 8 flags 0x1
[    0.109136] pnp 00:0f:   dependent set 2 (functional) irq 3 flags 0x1
[    0.109138] pnp 00:0f:   dependent set 3 (functional) io  min 0x2e8 max 0x2e8 align 8 size 8 flags 0x1
[    0.109141] pnp 00:0f:   dependent set 3 (functional) irq 3 flags 0x1
[    0.109163] pnp 00:0f: Plug and Play ACPI device, IDs PNP0501 (active)
[    0.109163] pnp 00:10: parse allocated resources
[    0.109186] pnp 00:10:   add io  0x2f8-0x2ff flags 0x1
[    0.109189] pnp 00:10:   add irq 3 flags 0x1
[    0.109190] pnp 00:10: parse resource options
[    0.109195] pnp 00:10:   dependent set 0 (preferred) io  min 0x2f8 max 0x2f8 align 8 size 8 flags 0x1
[    0.109197] pnp 00:10:   dependent set 0 (preferred) irq 3 flags 0x1
[    0.109199] pnp 00:10:   dependent set 1 (acceptable) io  min 0x2e8 max 0x2e8 align 8 size 8 flags 0x1
[    0.109201] pnp 00:10:   dependent set 1 (acceptable) irq 3 flags 0x1
[    0.109203] pnp 00:10:   dependent set 2 (functional) io  min 0x3f8 max 0x3f8 align 8 size 8 flags 0x1
[    0.109206] pnp 00:10:   dependent set 2 (functional) irq 4 flags 0x1
[    0.109208] pnp 00:10:   dependent set 3 (functional) io  min 0x3e8 max 0x3e8 align 8 size 8 flags 0x1
[    0.109210] pnp 00:10:   dependent set 3 (functional) irq 4 flags 0x1
[    0.109232] pnp 00:10: Plug and Play ACPI device, IDs PNP0501 (active)
[    0.109232] pnp 00:11: parse allocated resources
[    0.109232] pnp 00:11:   add io  0xca2-0xca3 flags 0x1
[    0.109232] pnp 00:11: Plug and Play ACPI device, IDs IPI0001 (active)
[    0.109232] pnp 00:12: PNP0c02: calling quirk_system_pci_resources+0x0/0x182
[    0.109232] pnp 00:12: Plug and Play ACPI device, IDs PNP0c02 (disabled)
[    0.109232] pnp: PnP ACPI: found 19 devices
[    0.109232] ACPI: ACPI bus type pnp unregistered
[    0.109232] SCSI subsystem initialized
[    0.109232] libata version 3.00 loaded.
[    0.109232] usbcore: registered new interface driver usbfs
[    0.109232] usbcore: registered new interface driver hub
[    0.109232] usbcore: registered new device driver usb
[    0.109999] PCI: Using ACPI for IRQ routing
[    0.109999] pci 0000:00:1c.0: BAR 7: can't allocate resource
[    0.109999] pci 0000:00:1c.0: BAR 8: can't allocate resource
[    0.109999] pci 0000:00:1c.0: BAR 9: can't allocate resource
[    0.121001] PCI-GART: No AMD northbridge found.
[    0.121007] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0
[    0.121013] hpet0: 4 64-bit timers, 14318180 Hz
[    0.121998] ACPI: RTC can wake from S4
[    0.126988] pnp: the driver 'system' has been registered
[    0.126996] system 00:00: iomem range 0xe0000000-0xefffffff could not be reserved
[    0.127000] system 00:00: driver attached
[    0.127008] system 00:04: ioport range 0x1000-0x107f has been reserved
[    0.127012] system 00:04: ioport range 0x1100-0x110f has been reserved
[    0.127016] system 00:04: ioport range 0x1180-0x11bf has been reserved
[    0.127020] system 00:04: ioport range 0xfe00-0xfe00 has been reserved
[    0.127024] system 00:04: ioport range 0xff00-0xff00 has been reserved
[    0.127029] system 00:04: iomem range 0xfec00000-0xfecfffff could not be reserved
[    0.127034] system 00:04: iomem range 0xfee00000-0xfeefffff could not be reserved
[    0.127039] system 00:04: iomem range 0xfed1c000-0xfed1ffff has been reserved
[    0.127043] system 00:04: iomem range 0xfed13000-0xfed13fff has been reserved
[    0.127047] system 00:04: iomem range 0xe0000000-0xefffffff could not be reserved
[    0.127052] system 00:04: iomem range 0xfed19000-0xfed19fff has been reserved
[    0.127057] system 00:04: iomem range 0xfed14000-0xfed17fff has been reserved
[    0.127061] system 00:04: iomem range 0xfed18000-0xfed18fff has been reserved
[    0.127064] system 00:04: driver attached
[    0.127074] system 00:12: driver attached
[    0.131703] pci 0000:00:1c.0: PCI bridge, secondary bus 0000:01
[    0.131706] pci 0000:00:1c.0:   IO window: disabled
[    0.131710] pci 0000:00:1c.0:   MEM window: disabled
[    0.131713] pci 0000:00:1c.0:   PREFETCH window: disabled
[    0.131718] pci 0000:00:1c.4: PCI bridge, secondary bus 0000:02
[    0.131720] pci 0000:00:1c.4:   IO window: disabled
[    0.131724] pci 0000:00:1c.4:   MEM window: 0xdf900000-0xdf9fffff
[    0.131728] pci 0000:00:1c.4:   PREFETCH window: disabled
[    0.131733] pci 0000:00:1c.5: PCI bridge, secondary bus 0000:03
[    0.131735] pci 0000:00:1c.5:   IO window: disabled
[    0.131739] pci 0000:00:1c.5:   MEM window: 0xdf000000-0xdf8fffff
[    0.131743] pci 0000:00:1c.5:   PREFETCH window: 0x000000de000000-0x000000deffffff
[    0.131749] pci 0000:00:1e.0: PCI bridge, secondary bus 0000:04
[    0.131751] pci 0000:00:1e.0:   IO window: disabled
[    0.131755] pci 0000:00:1e.0:   MEM window: disabled
[    0.131758] pci 0000:00:1e.0:   PREFETCH window: disabled
[    0.131769] pci 0000:00:1c.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
[    0.131773] pci 0000:00:1c.0: setting latency timer to 64
[    0.131778] pci 0000:00:1c.4: PCI INT A -> GSI 16 (level, low) -> IRQ 16
[    0.131782] pci 0000:00:1c.4: setting latency timer to 64
[    0.131787] pci 0000:00:1c.5: PCI INT B -> GSI 17 (level, low) -> IRQ 17
[    0.131790] pci 0000:00:1c.5: setting latency timer to 64
[    0.131795] pci 0000:00:1e.0: setting latency timer to 64
[    0.131797] bus: 00 index 0 io port: [0, ffff]
[    0.131799] bus: 00 index 1 mmio: [0, ffffffffffffffff]
[    0.131801] bus: 01 index 0 mmio: [0, fff]
[    0.131803] bus: 01 index 1 mmio: [0, fffff]
[    0.131805] bus: 01 index 2 mmio: [0, fffff]
[    0.131807] bus: 01 index 3 mmio: [0, 0]
[    0.131809] bus: 02 index 0 mmio: [0, 0]
[    0.131811] bus: 02 index 1 mmio: [df900000, df9fffff]
[    0.131813] bus: 02 index 2 mmio: [0, 0]
[    0.131814] bus: 02 index 3 mmio: [0, 0]
[    0.131816] bus: 03 index 0 mmio: [0, 0]
[    0.131818] bus: 03 index 1 mmio: [df000000, df8fffff]
[    0.131820] bus: 03 index 2 mmio: [de000000, deffffff]
[    0.131822] bus: 03 index 3 mmio: [0, 0]
[    0.131824] bus: 04 index 0 mmio: [0, 0]
[    0.131826] bus: 04 index 1 mmio: [0, 0]
[    0.131828] bus: 04 index 2 mmio: [0, 0]
[    0.131830] bus: 04 index 3 io port: [0, ffff]
[    0.131832] bus: 04 index 4 mmio: [0, ffffffffffffffff]
[    0.131838] NET: Registered protocol family 2
[    0.141028] IP route cache hash table entries: 262144 (order: 9, 2097152 bytes)
[    0.141374] TCP established hash table entries: 262144 (order: 10, 4194304 bytes)
[    0.142583] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[    0.143111] TCP: Hash tables configured (established 262144 bind 65536)
[    0.143114] TCP reno registered
[    0.146057] NET: Registered protocol family 1
[    0.146169] Simple Boot Flag at 0x44 set to 0x1
[    0.146604] IA-32 Microcode Update Driver: v1.14a <tigran@aivazian.fsnet.co.uk>
[    0.146879] audit: initializing netlink socket (disabled)
[    0.146893] type=2000 audit(1227125230.145:1): initialized
[    0.147323] HugeTLB registered 2 MB page size, pre-allocated 0 pages
[    0.148781] DLM (built Nov 19 2008 20:59:16) installed
[    0.149215] Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
[    0.149296] NTFS driver 2.1.29 [Flags: R/W].
[    0.149455] JFS: nTxBlock = 8192, nTxLock = 65536
[    0.152993] msgmni has been set to 11891
[    0.153188] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 253)
[    0.153192] io scheduler noop registered
[    0.153194] io scheduler anticipatory registered
[    0.153196] io scheduler deadline registered
[    0.153234] io scheduler cfq registered (default)
[    0.153248] pci 0000:00:1a.0: uhci_check_and_reset_hc: legsup = 0x003b
[    0.153249] pci 0000:00:1a.0: Performing full reset
[    0.153262] pci 0000:00:1a.1: uhci_check_and_reset_hc: legsup = 0x0010
[    0.153263] pci 0000:00:1a.1: Performing full reset
[    0.153276] pci 0000:00:1a.2: uhci_check_and_reset_hc: legsup = 0x0010
[    0.153277] pci 0000:00:1a.2: Performing full reset
[    0.153309] pci 0000:00:1d.0: uhci_check_and_reset_hc: legsup = 0x003b
[    0.153310] pci 0000:00:1d.0: Performing full reset
[    0.153323] pci 0000:00:1d.1: uhci_check_and_reset_hc: legsup = 0x0010
[    0.153324] pci 0000:00:1d.1: Performing full reset
[    0.153336] pci 0000:00:1d.2: uhci_check_and_reset_hc: legsup = 0x0010
[    0.153337] pci 0000:00:1d.2: Performing full reset
[    0.153363] pci 0000:03:00.0: Boot video device
[    0.153423] pcieport-driver 0000:00:1c.0: setting latency timer to 64
[    0.153448] pcieport-driver 0000:00:1c.0: found MSI capability
[    0.153475] pci_express 0000:00:1c.0:pcie00: allocate port service
[    0.153499] pci_express 0000:00:1c.0:pcie02: allocate port service
[    0.153519] pci_express 0000:00:1c.0:pcie03: allocate port service
[    0.153572] pcieport-driver 0000:00:1c.4: setting latency timer to 64
[    0.153594] pcieport-driver 0000:00:1c.4: found MSI capability
[    0.153618] pci_express 0000:00:1c.4:pcie00: allocate port service
[    0.153642] pci_express 0000:00:1c.4:pcie02: allocate port service
[    0.153662] pci_express 0000:00:1c.4:pcie03: allocate port service
[    0.153716] pcieport-driver 0000:00:1c.5: setting latency timer to 64
[    0.153738] pcieport-driver 0000:00:1c.5: found MSI capability
[    0.153762] pci_express 0000:00:1c.5:pcie00: allocate port service
[    0.153783] pci_express 0000:00:1c.5:pcie02: allocate port service
[    0.153803] pci_express 0000:00:1c.5:pcie03: allocate port service
[    0.155559] hpet_resources: 0xfed00000 is busy
[    0.155614] Non-volatile memory driver v1.2
[    0.155658] Linux agpgart interface v0.103
[    0.155703] ipmi message handler version 39.2
[    0.155707] ipmi device interface
[    0.155746] IPMI System Interface driver.
[    0.155750] ipmi_si: Trying SMBIOS-specified kcs state machine at i/o address 0xca2, slave address 0x20, irq 0
[    0.184497] ipmi: Found new BMC (man_id: 0x002880,  prod_id: 0x0226, dev_id: 0x02)
[    0.184526] IPMI kcs interface initialized
[    0.185777] IPMI Watchdog: driver initialized
[    0.185780] Copyright (C) 2004 MontaVista Software - IPMI Powerdown via sys_reboot.
[    0.187688] IPMI poweroff: ATCA Detect mfg 0x2880 prod 0x226
[    0.187691] IPMI poweroff: Found a chassis style poweroff function
[    0.187694] pnp: the driver 'tpm_tis' has been registered
[    0.187736] tpm_tis 00:02: 1.2 TPM (device-id 0xB, rev-id 16)
[    0.289515] tpm_tis 00:02: driver attached
[    0.289738] vesafb: framebuffer at 0xde000000, mapped to 0xffffc20000a80000, using 5120k, total 8128k
[    0.289741] vesafb: mode is 1280x1024x16, linelength=2560, pages=2
[    0.289743] vesafb: scrolling: redraw
[    0.289746] vesafb: Truecolor: size=0:5:6:5, shift=0:11:5:0
[    0.479449] Console: switching to colour frame buffer device 160x64
[    0.500489] Switched to high resolution mode on CPU 1
[    0.501043] Switched to high resolution mode on CPU 0
[    0.657494] fb0: VESA VGA frame buffer device
[    0.658556] input: Power Button (FF) as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input0
[    0.662256] ACPI: Power Button (FF) [PWRF]
[    0.663170] input: Power Button (CM) as /devices/LNXSYSTM:00/device:00/PNP0C0C:00/input/input1
[    0.667255] ACPI: Power Button (CM) [PWRB]
[    0.668273] ACPI: CPU0 (power states: C1[C1] C2[C2])
[    0.669462] processor ACPI0007:00: registered as cooling_device0
[    0.670776] ACPI: CPU1 (power states: C1[C1] C2[C2])
[    0.671964] processor ACPI0007:01: registered as cooling_device1
[    0.674347] [drm] Initialized drm 1.1.0 20060810
[    0.675331] Serial: 8250/16550 driver4 ports, IRQ sharing enabled
[    0.920366] serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[    1.165365] serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
[    1.166740] pnp: the driver 'serial' has been registered
[    1.166935] 00:0f: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[    1.168147] serial 00:0f: driver attached
[    1.168253] 00:10: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
[    1.169462] serial 00:10: driver attached
[    1.170288] brd: module loaded
[    1.171339] loop: module loaded
[    1.172032] tg3.c:v3.94 (August 14, 2008)
[    1.172892] tg3 0000:02:00.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
[    1.174327] tg3 0000:02:00.0: setting latency timer to 64
[    1.182412] eth0: Tigon3 [partno(BCM95755) rev a002 PHY(5755)] (PCI Express) 10/100/1000Base-T Ethernet 00:19:99:42:55:c0
[    1.184747] eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] WireSpeed[1] TSOcap[1]
[    1.186339] eth0: dma_rwctrl[76180000] dma_mask[64-bit]
[    1.187566] PPP generic driver version 2.4.2
[    1.188515] NET: Registered protocol family 24
[    1.189568] megaraid cmm: 2.20.2.7 (Release Date: Sun Jul 16 00:01:03 EST 2006)
[    1.191145] megaraid: 2.20.5.1 (Release Date: Thu Nov 16 15:32:35 EST 2006)
[    1.192667] Driver 'sd' needs updating - please use bus_type methods
[    1.194036] Driver 'sr' needs updating - please use bus_type methods
[    1.195423] SCSI Media Changer driver v0.25 
[    1.196347] Driver 'ch' needs updating - please use bus_type methods
[    1.197715] Driver 'ses' needs updating - please use bus_type methods
[    1.199115] ahci 0000:00:1f.2: version 3.0
[    1.199121] ahci 0000:00:1f.2: PCI INT B -> GSI 17 (level, low) -> IRQ 17
[    1.200642] ahci 0000:00:1f.2: AHCI 0001.0200 32 slots 6 ports ? Gbps 0x3f impl SATA mode
[    1.202384] ahci 0000:00:1f.2: flags: 64bit led pio ems 
[    1.240361] ahci 0000:00:1f.2: setting latency timer to 64
[    1.240647] scsi0 : ahci
[    1.278876] scsi1 : ahci
[    1.317218] scsi2 : ahci
[    1.355673] scsi3 : ahci
[    1.394238] scsi4 : ahci
[    1.432912] scsi5 : ahci
[    1.471753] ata1: SATA max UDMA/133 abar m2048@0xdfc00000 port 0xdfc00100 irq 380
[    1.512778] ata2: SATA max UDMA/133 abar m2048@0xdfc00000 port 0xdfc00180 irq 380
[    1.553931] ata3: SATA max UDMA/133 abar m2048@0xdfc00000 port 0xdfc00200 irq 380
[    1.595229] ata4: SATA max UDMA/133 abar m2048@0xdfc00000 port 0xdfc00280 irq 380
[    1.636656] ata5: SATA max UDMA/133 abar m2048@0xdfc00000 port 0xdfc00300 irq 380
[    1.678247] ata6: SATA max UDMA/133 abar m2048@0xdfc00000 port 0xdfc00380 irq 380
[    2.025021] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    2.125420] ata1.00: ATA-7: ST3160815AS, 4.AAA, max UDMA/133
[    2.168811] ata1.00: 312581808 sectors, multi 0: LBA48 NCQ (depth 0/32)
[    2.242042] ata1.00: configured for UDMA/133
[    3.010012] ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    3.103217] ata2.00: ATA-7: ST3160815AS, 4.AAA, max UDMA/133
[    3.150471] ata2.00: 312581808 sectors, multi 0: LBA48 NCQ (depth 0/32)
[    3.228175] ata2.00: configured for UDMA/133
[    4.000263] ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    4.053242] ata3.00: ATA-8: ST31000340AS, SD15, max UDMA/133
[    4.104342] ata3.00: 1953525168 sectors, multi 0: LBA48 NCQ (depth 0/32)
[    4.158570] ata3.00: configured for UDMA/133
[    4.933012] ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    4.986530] ata4.00: ATA-8: ST31000340AS, SD15, max UDMA/133
[    5.037949] ata4.00: 1953525168 sectors, multi 0: LBA48 NCQ (depth 0/32)
[    5.091145] ata4.00: configured for UDMA/133
[    5.864261] ata5: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    5.914941] ata5.00: ATAPI: HL-DT-STDVD-ROM DH10N, 0F03, max UDMA/100
[    5.966289] ata5.00: configured for UDMA/100
[    6.321011] ata6: SATA link down (SStatus 0 SControl 300)
[    6.370930] scsi 0:0:0:0: Direct-Access     ATA      ST3160815AS      4.AA PQ: 0 ANSI: 5
[    6.421674] sd 0:0:0:0: [sda] 312581808 512-byte hardware sectors (160042 MB)
[    6.472472] sd 0:0:0:0: [sda] Write Protect is off
[    6.522589] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    6.522604] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    6.573815] sd 0:0:0:0: [sda] 312581808 512-byte hardware sectors (160042 MB)
[    6.625717] sd 0:0:0:0: [sda] Write Protect is off
[    6.677055] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    6.677071] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    6.730242]  sda: sda1 sda2 sda3 sda4
[    6.814125] sd 0:0:0:0: [sda] Attached SCSI disk
[    6.867422] sd 0:0:0:0: Attached scsi generic sg0 type 0
[    6.920908] scsi 1:0:0:0: Direct-Access     ATA      ST3160815AS      4.AA PQ: 0 ANSI: 5
[    6.975224] sd 1:0:0:0: [sdb] 312581808 512-byte hardware sectors (160042 MB)
[    7.028591] sd 1:0:0:0: [sdb] Write Protect is off
[    7.080520] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[    7.080538] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    7.133275] sd 1:0:0:0: [sdb] 312581808 512-byte hardware sectors (160042 MB)
[    7.186028] sd 1:0:0:0: [sdb] Write Protect is off
[    7.238512] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[    7.238530] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    7.291868]  sdb: sdb1 sdb2 sdb3 sdb4
[    7.377151] sd 1:0:0:0: [sdb] Attached SCSI disk
[    7.429520] sd 1:0:0:0: Attached scsi generic sg1 type 0
[    7.482586] scsi 2:0:0:0: Direct-Access     ATA      ST31000340AS     SD15 PQ: 0 ANSI: 5
[    7.536384] sd 2:0:0:0: [sdc] 1953525168 512-byte hardware sectors (1000205 MB)
[    7.590182] sd 2:0:0:0: [sdc] Write Protect is off
[    7.643390] sd 2:0:0:0: [sdc] Mode Sense: 00 3a 00 00
[    7.643414] sd 2:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    7.697508] sd 2:0:0:0: [sdc] 1953525168 512-byte hardware sectors (1000205 MB)
[    7.751341] sd 2:0:0:0: [sdc] Write Protect is off
[    7.804566] sd 2:0:0:0: [sdc] Mode Sense: 00 3a 00 00
[    7.804583] sd 2:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    7.859052]  sdc: sdc1 sdc2 sdc3 sdc4
[    7.933982] sd 2:0:0:0: [sdc] Attached SCSI disk
[    7.989534] sd 2:0:0:0: Attached scsi generic sg2 type 0
[    8.045750] scsi 3:0:0:0: Direct-Access     ATA      ST31000340AS     SD15 PQ: 0 ANSI: 5
[    8.103695] sd 3:0:0:0: [sdd] 1953525168 512-byte hardware sectors (1000205 MB)
[    8.162578] sd 3:0:0:0: [sdd] Write Protect is off
[    8.220636] sd 3:0:0:0: [sdd] Mode Sense: 00 3a 00 00
[    8.220653] sd 3:0:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    8.280632] sd 3:0:0:0: [sdd] 1953525168 512-byte hardware sectors (1000205 MB)
[    8.341293] sd 3:0:0:0: [sdd] Write Protect is off
[    8.341294] sd 3:0:0:0: [sdd] Mode Sense: 00 3a 00 00
[    8.341308] sd 3:0:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    8.341309]  sdd: sdd1 sdd2 sdd3 sdd4
[    8.527997] sd 3:0:0:0: [sdd] Attached SCSI disk
[    8.590734] sd 3:0:0:0: Attached scsi generic sg3 type 0
[    8.654699] scsi 4:0:0:0: CD-ROM            HL-DT-ST DVD-ROM DH10N    0F03 PQ: 0 ANSI: 5
[    8.721406] sr0: scsi3-mmc drive: 48x/48x cd/rw xa/form2 cdda tray
[    8.784690] Uniform CD-ROM driver Revision: 3.20
[    8.847786] sr 4:0:0:0: Attached scsi CD-ROM sr0
[    8.847831] sr 4:0:0:0: Attached scsi generic sg4 type 5
[    8.910795] sr 4:0:0:0: Embedded Enclosure Device
[    8.974005] sr 4:0:0:0: Failed to get diagnostic page 0x8000002
[    9.036493] sr 4:0:0:0: Failed to bind enclosure -19
[    9.098439] ehci_hcd: block sizes: qh 160 qtd 96 itd 192 sitd 96
[    9.098452] ehci_hcd 0000:00:1a.7: PCI INT C -> GSI 18 (level, low) -> IRQ 18
[    9.161013] ehci_hcd 0000:00:1a.7: setting latency timer to 64
[    9.161016] ehci_hcd 0000:00:1a.7: EHCI Host Controller
[    9.222991] drivers/usb/core/inode.c: creating file 'devices'
[    9.222993] drivers/usb/core/inode.c: creating file '001'
[    9.223028] ehci_hcd 0000:00:1a.7: new USB bus registered, assigned bus number 1
[    9.285332] ehci_hcd 0000:00:1a.7: reset hcs_params 0x103206 dbg=1 cc=3 pcc=2 ordered !ppc ports=6
[    9.285334] ehci_hcd 0000:00:1a.7: reset hcc_params 16871 thresh 7 uframes 1024 64 bit addr
[    9.285353] ehci_hcd 0000:00:1a.7: reset command 080022 (park)=0 ithresh=8 Async period=1024 Reset HALT
[    9.289234] ehci_hcd 0000:00:1a.7: debug port 1
[    9.350755] ehci_hcd 0000:00:1a.7: cache line size of 32 is not supported
[    9.350756] ehci_hcd 0000:00:1a.7: supports USB remote wakeup
[    9.350764] ehci_hcd 0000:00:1a.7: irq 18, io mem 0xdfc00800
[    9.412116] ehci_hcd 0000:00:1a.7: reset command 080002 (park)=0 ithresh=8 period=1024 Reset HALT
[    9.416008] ehci_hcd 0000:00:1a.7: init command 010001 (park)=0 ithresh=1 period=1024 RUN
[    9.422008] ehci_hcd 0000:00:1a.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
[    9.483550] usb usb1: default language 0x0409
[    9.483574] usb usb1: uevent
[    9.483593] usb usb1: usb_probe_device
[    9.483594] usb usb1: configuration #1 chosen from 1 choice
[    9.545063] usb usb1: adding 1-0:1.0 (config #1, interface 0)
[    9.545072] usb 1-0:1.0: uevent
[    9.545090] hub 1-0:1.0: usb_probe_interface
[    9.545091] hub 1-0:1.0: usb_probe_interface - got id
[    9.545093] hub 1-0:1.0: USB hub found
[    9.606021] hub 1-0:1.0: 6 ports detected
[    9.666354] hub 1-0:1.0: standalone hub
[    9.666355] hub 1-0:1.0: no power switching (usb 1.0)
[    9.666356] hub 1-0:1.0: individual port over-current protection
[    9.666357] hub 1-0:1.0: power on to power good time: 20ms
[    9.666360] hub 1-0:1.0: local power source is good
[    9.666361] hub 1-0:1.0: trying to enable port power on non-switchable hub
[    9.767032] ehci_hcd 0000:00:1a.7: GetStatus port 2 status 001803 POWER sig=j CSC CONNECT
[    9.767035] hub 1-0:1.0: port 2: status 0501 change 0001
[    9.868045] hub 1-0:1.0: state 7 ports 6 chg 0004 evt 0000
[    9.868096] drivers/usb/core/inode.c: creating file '001'
[    9.868139] hub 1-0:1.0: port 2, status 0501, change 0000, 480 Mb/s
[    9.868156] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
[    9.929404] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    9.929405] usb usb1: Product: EHCI Host Controller
[    9.929406] usb usb1: Manufacturer: Linux 2.6.27-gentoo-r3 ehci_hcd
[    9.929407] usb usb1: SerialNumber: 0000:00:1a.7
[    9.929420] ehci_hcd 0000:00:1d.7: PCI INT A -> GSI 16 (level, low) -> IRQ 16
[    9.929426] ehci_hcd 0000:00:1d.7: setting latency timer to 64
[    9.929428] ehci_hcd 0000:00:1d.7: EHCI Host Controller
[    9.929665] ehci_hcd 0000:00:1a.7: port 2 full speed --> companion
[    9.929667] ehci_hcd 0000:00:1a.7: GetStatus port 2 status 003801 POWER OWNER sig=j CONNECT
[    9.929669] hub 1-0:1.0: port 2 not reset yet, waiting 50ms
[    9.929682] drivers/usb/core/inode.c: creating file '002'
[    9.929713] ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 2
[    9.929718] ehci_hcd 0000:00:1d.7: reset hcs_params 0x104208 dbg=1 cc=4 pcc=2 ordered !ppc ports=8
[    9.929721] ehci_hcd 0000:00:1d.7: reset hcc_params 16871 thresh 7 uframes 1024 64 bit addr
[    9.929735] ehci_hcd 0000:00:1d.7: reset command 080022 (park)=0 ithresh=8 Async period=1024 Reset HALT
[    9.933638] ehci_hcd 0000:00:1d.7: debug port 1
[    9.933643] ehci_hcd 0000:00:1d.7: cache line size of 32 is not supported
[    9.933644] ehci_hcd 0000:00:1d.7: supports USB remote wakeup
[    9.933652] ehci_hcd 0000:00:1d.7: irq 16, io mem 0xdfc00c00
[    9.933655] ehci_hcd 0000:00:1d.7: reset command 080002 (park)=0 ithresh=8 period=1024 Reset HALT
[    9.937535] ehci_hcd 0000:00:1d.7: init command 010001 (park)=0 ithresh=1 period=1024 RUN
[   10.172010] ehci_hcd 0000:00:1a.7: GetStatus port 2 status 003002 POWER OWNER sig=se0 CSC
[   10.172025] hub 1-0:1.0: state 7 ports 6 chg 0000 evt 0004
[   10.469014] ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
[   10.527640] usb usb2: default language 0x0409
[   10.527662] usb usb2: uevent
[   10.527680] usb usb2: usb_probe_device
[   10.527681] usb usb2: configuration #1 chosen from 1 choice
[   10.586609] usb usb2: adding 2-0:1.0 (config #1, interface 0)
[   10.586618] usb 2-0:1.0: uevent
[   10.586636] hub 2-0:1.0: usb_probe_interface
[   10.586637] hub 2-0:1.0: usb_probe_interface - got id
[   10.586638] hub 2-0:1.0: USB hub found
[   10.644827] hub 2-0:1.0: 8 ports detected
[   10.702181] hub 2-0:1.0: standalone hub
[   10.702182] hub 2-0:1.0: no power switching (usb 1.0)
[   10.702182] hub 2-0:1.0: individual port over-current protection
[   10.702183] hub 2-0:1.0: power on to power good time: 20ms
[   10.702186] hub 2-0:1.0: local power source is good
[   10.702187] hub 2-0:1.0: trying to enable port power on non-switchable hub
[   10.803053] hub 2-0:1.0: state 7 ports 8 chg 0000 evt 0000
[   10.803064] drivers/usb/core/inode.c: creating file '001'
[   10.803116] usb usb2: New USB device found, idVendor=1d6b, idProduct=0002
[   10.861287] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   10.919325] usb usb2: Product: EHCI Host Controller
[   10.919326] usb usb2: Manufacturer: Linux 2.6.27-gentoo-r3 ehci_hcd
[   10.919327] usb usb2: SerialNumber: 0000:00:1d.7
[   10.919351] ohci_hcd: 2006 August 04 USB 1.1 'Open' Host Controller (OHCI) Driver
[   10.919352] ohci_hcd: block sizes: ed 80 td 96
[   10.919377] USB Universal Host Controller Interface driver v3.0
[   10.919391] uhci_hcd 0000:00:1a.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
[   10.919396] uhci_hcd 0000:00:1a.0: setting latency timer to 64
[   10.919399] uhci_hcd 0000:00:1a.0: UHCI Host Controller
[   10.919425] drivers/usb/core/inode.c: creating file '003'
[   10.919451] uhci_hcd 0000:00:1a.0: new USB bus registered, assigned bus number 3
[   10.919457] uhci_hcd 0000:00:1a.0: detected 2 ports
[   10.919461] uhci_hcd 0000:00:1a.0: uhci_check_and_reset_hc: cmd = 0x0000
[   10.919462] uhci_hcd 0000:00:1a.0: Performing full reset
[   10.919476] uhci_hcd 0000:00:1a.0: supports USB remote wakeup
[   10.919478] uhci_hcd 0000:00:1a.0: irq 16, io base 0x00001820
[   10.919507] usb usb3: default language 0x0409
[   10.919527] usb usb3: uevent
[   10.919546] usb usb3: usb_probe_device
[   10.919547] usb usb3: configuration #1 chosen from 1 choice
[   10.919550] usb usb3: adding 3-0:1.0 (config #1, interface 0)
[   10.919558] usb 3-0:1.0: uevent
[   10.919576] hub 3-0:1.0: usb_probe_interface
[   10.919577] hub 3-0:1.0: usb_probe_interface - got id
[   10.919578] hub 3-0:1.0: USB hub found
[   10.919583] hub 3-0:1.0: 2 ports detected
[   10.919584] hub 3-0:1.0: standalone hub
[   10.919585] hub 3-0:1.0: no power switching (usb 1.0)
[   10.919586] hub 3-0:1.0: individual port over-current protection
[   10.919586] hub 3-0:1.0: power on to power good time: 2ms
[   10.919588] hub 3-0:1.0: local power source is good
[   10.919589] hub 3-0:1.0: trying to enable port power on non-switchable hub
[   11.092015] uhci_hcd 0000:00:1a.0: port 2 portsc 0093,00
[   11.092016] hub 3-0:1.0: port 2: status 0101 change 0001
[   11.594056] drivers/usb/core/inode.c: creating file '001'
[   11.594105] usb usb3: New USB device found, idVendor=1d6b, idProduct=0001
[   11.648688] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   11.702708] usb usb3: Product: UHCI Host Controller
[   11.756618] usb usb3: Manufacturer: Linux 2.6.27-gentoo-r3 uhci_hcd
[   11.811267] usb usb3: SerialNumber: 0000:00:1a.0
[   11.811285] uhci_hcd 0000:00:1a.1: PCI INT B -> GSI 17 (level, low) -> IRQ 17
[   11.811290] uhci_hcd 0000:00:1a.1: setting latency timer to 64
[   11.811292] uhci_hcd 0000:00:1a.1: UHCI Host Controller
[   11.811305] hub 3-0:1.0: state 7 ports 2 chg 0004 evt 0000
[   11.811312] hub 3-0:1.0: port 2, status 0101, change 0000, 12 Mb/s
[   11.866034] drivers/usb/core/inode.c: creating file '004'
[   11.866061] uhci_hcd 0000:00:1a.1: new USB bus registered, assigned bus number 4
[   11.866067] uhci_hcd 0000:00:1a.1: detected 2 ports
[   11.866070] uhci_hcd 0000:00:1a.1: uhci_check_and_reset_hc: cmd = 0x0000
[   11.866071] uhci_hcd 0000:00:1a.1: Performing full reset
[   11.866085] uhci_hcd 0000:00:1a.1: supports USB remote wakeup
[   11.866093] uhci_hcd 0000:00:1a.1: irq 17, io base 0x00001840
[   11.866116] usb usb4: default language 0x0409
[   11.866138] usb usb4: uevent
[   11.866156] usb usb4: usb_probe_device
[   11.866157] usb usb4: configuration #1 chosen from 1 choice
[   11.866159] usb usb4: adding 4-0:1.0 (config #1, interface 0)
[   11.866168] usb 4-0:1.0: uevent
[   11.866185] hub 4-0:1.0: usb_probe_interface
[   11.866186] hub 4-0:1.0: usb_probe_interface - got id
[   11.866187] hub 4-0:1.0: USB hub found
[   11.866191] hub 4-0:1.0: 2 ports detected
[   11.866191] hub 4-0:1.0: standalone hub
[   11.866192] hub 4-0:1.0: no power switching (usb 1.0)
[   11.866193] hub 4-0:1.0: individual port over-current protection
[   11.866194] hub 4-0:1.0: power on to power good time: 2ms
[   11.866196] hub 4-0:1.0: local power source is good
[   11.866197] hub 4-0:1.0: trying to enable port power on non-switchable hub
[   11.973051] drivers/usb/core/inode.c: creating file '001'
[   11.973086] usb usb4: New USB device found, idVendor=1d6b, idProduct=0001
[   11.973087] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   11.973088] usb usb4: Product: UHCI Host Controller
[   11.973089] usb usb4: Manufacturer: Linux 2.6.27-gentoo-r3 uhci_hcd
[   11.973090] usb usb4: SerialNumber: 0000:00:1a.1
[   11.973105] uhci_hcd 0000:00:1a.2: PCI INT C -> GSI 18 (level, low) -> IRQ 18
[   11.973110] uhci_hcd 0000:00:1a.2: setting latency timer to 64
[   11.973113] uhci_hcd 0000:00:1a.2: UHCI Host Controller
[   11.973136] drivers/usb/core/inode.c: creating file '005'
[   11.973168] uhci_hcd 0000:00:1a.2: new USB bus registered, assigned bus number 5
[   11.973175] uhci_hcd 0000:00:1a.2: detected 2 ports
[   11.973178] uhci_hcd 0000:00:1a.2: uhci_check_and_reset_hc: cmd = 0x0000
[   11.973179] uhci_hcd 0000:00:1a.2: Performing full reset
[   11.973193] uhci_hcd 0000:00:1a.2: supports USB remote wakeup
[   11.973196] uhci_hcd 0000:00:1a.2: irq 18, io base 0x00001860
[   11.973221] usb usb5: default language 0x0409
[   11.973243] usb usb5: uevent
[   11.973261] usb usb5: usb_probe_device
[   11.973262] usb usb5: configuration #1 chosen from 1 choice
[   11.973264] usb usb5: adding 5-0:1.0 (config #1, interface 0)
[   11.973273] usb 5-0:1.0: uevent
[   11.973290] hub 5-0:1.0: usb_probe_interface
[   11.973291] hub 5-0:1.0: usb_probe_interface - got id
[   11.973292] hub 5-0:1.0: USB hub found
[   11.973296] hub 5-0:1.0: 2 ports detected
[   11.973296] hub 5-0:1.0: standalone hub
[   11.973297] hub 5-0:1.0: no power switching (usb 1.0)
[   11.973298] hub 5-0:1.0: individual port over-current protection
[   11.973299] hub 5-0:1.0: power on to power good time: 2ms
[   11.973301] hub 5-0:1.0: local power source is good
[   11.973302] hub 5-0:1.0: trying to enable port power on non-switchable hub
[   11.973305] usb 3-2: new full speed USB device using uhci_hcd and address 2
[   12.285083] drivers/usb/core/inode.c: creating file '001'
[   12.285115] usb usb5: New USB device found, idVendor=1d6b, idProduct=0001
[   12.285116] usb usb5: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   12.285117] usb usb5: Product: UHCI Host Controller
[   12.285118] usb usb5: Manufacturer: Linux 2.6.27-gentoo-r3 uhci_hcd
[   12.285119] usb usb5: SerialNumber: 0000:00:1a.2
[   12.285136] uhci_hcd 0000:00:1d.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
[   12.285141] uhci_hcd 0000:00:1d.0: setting latency timer to 64
[   12.285144] uhci_hcd 0000:00:1d.0: UHCI Host Controller
[   12.285168] drivers/usb/core/inode.c: creating file '006'
[   12.285198] uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 6
[   12.285203] uhci_hcd 0000:00:1d.0: detected 2 ports
[   12.285207] uhci_hcd 0000:00:1d.0: uhci_check_and_reset_hc: cmd = 0x0000
[   12.285208] uhci_hcd 0000:00:1d.0: Performing full reset
[   12.285222] uhci_hcd 0000:00:1d.0: supports USB remote wakeup
[   12.285224] uhci_hcd 0000:00:1d.0: irq 16, io base 0x00001880
[   12.285250] usb usb6: default language 0x0409
[   12.285270] usb usb6: uevent
[   12.285288] usb usb6: usb_probe_device
[   12.285289] usb usb6: configuration #1 chosen from 1 choice
[   12.285292] usb usb6: adding 6-0:1.0 (config #1, interface 0)
[   12.285300] usb 6-0:1.0: uevent
[   12.285320] hub 6-0:1.0: usb_probe_interface
[   12.285321] hub 6-0:1.0: usb_probe_interface - got id
[   12.285321] hub 6-0:1.0: USB hub found
[   12.285325] hub 6-0:1.0: 2 ports detected
[   12.285326] hub 6-0:1.0: standalone hub
[   12.285327] hub 6-0:1.0: no power switching (usb 1.0)
[   12.285328] hub 6-0:1.0: individual port over-current protection
[   12.285328] hub 6-0:1.0: power on to power good time: 2ms
[   12.285330] hub 6-0:1.0: local power source is good
[   12.285331] hub 6-0:1.0: trying to enable port power on non-switchable hub
[   12.999021] usb usb4: suspend_rh (auto-stop)
[   12.999051] hub 1-0:1.0: hub_suspend
[   12.999053] usb usb1: bus auto-suspend
[   12.999054] ehci_hcd 0000:00:1a.7: suspend root hub
[   12.999072] hub 2-0:1.0: hub_suspend
[   12.999073] usb usb2: bus auto-suspend
[   12.999074] ehci_hcd 0000:00:1d.7: suspend root hub
[   12.999135] drivers/usb/core/inode.c: creating file '001'
[   12.999176] usb usb6: New USB device found, idVendor=1d6b, idProduct=0001
[   12.999177] usb usb6: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   12.999178] usb usb6: Product: UHCI Host Controller
[   12.999179] usb usb6: Manufacturer: Linux 2.6.27-gentoo-r3 uhci_hcd
[   12.999180] usb usb6: SerialNumber: 0000:00:1d.0
[   12.999197] uhci_hcd 0000:00:1d.1: PCI INT B -> GSI 17 (level, low) -> IRQ 17
[   12.999202] uhci_hcd 0000:00:1d.1: setting latency timer to 64
[   12.999204] uhci_hcd 0000:00:1d.1: UHCI Host Controller
[   12.999233] drivers/usb/core/inode.c: creating file '007'
[   12.999266] uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 7
[   12.999271] uhci_hcd 0000:00:1d.1: detected 2 ports
[   12.999275] uhci_hcd 0000:00:1d.1: uhci_check_and_reset_hc: cmd = 0x0000
[   12.999276] uhci_hcd 0000:00:1d.1: Performing full reset
[   12.999291] uhci_hcd 0000:00:1d.1: supports USB remote wakeup
[   12.999293] uhci_hcd 0000:00:1d.1: irq 17, io base 0x000018a0
[   12.999319] usb usb7: default language 0x0409
[   12.999339] usb usb7: uevent
[   12.999357] usb usb7: usb_probe_device
[   12.999358] usb usb7: configuration #1 chosen from 1 choice
[   12.999361] usb usb7: adding 7-0:1.0 (config #1, interface 0)
[   12.999371] usb 7-0:1.0: uevent
[   12.999389] hub 7-0:1.0: usb_probe_interface
[   12.999390] hub 7-0:1.0: usb_probe_interface - got id
[   12.999391] hub 7-0:1.0: USB hub found
[   12.999395] hub 7-0:1.0: 2 ports detected
[   12.999396] hub 7-0:1.0: standalone hub
[   12.999396] hub 7-0:1.0: no power switching (usb 1.0)
[   12.999397] hub 7-0:1.0: individual port over-current protection
[   12.999398] hub 7-0:1.0: power on to power good time: 2ms
[   12.999400] hub 7-0:1.0: local power source is good
[   12.999401] hub 7-0:1.0: trying to enable port power on non-switchable hub
[   13.656028] usb usb5: suspend_rh (auto-stop)
[   13.656086] drivers/usb/core/inode.c: creating file '001'
[   13.656121] usb usb7: New USB device found, idVendor=1d6b, idProduct=0001
[   13.656122] usb usb7: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   13.656123] usb usb7: Product: UHCI Host Controller
[   13.656124] usb usb7: Manufacturer: Linux 2.6.27-gentoo-r3 uhci_hcd
[   13.656125] usb usb7: SerialNumber: 0000:00:1d.1
[   13.656140] uhci_hcd 0000:00:1d.2: PCI INT C -> GSI 18 (level, low) -> IRQ 18
[   13.656145] uhci_hcd 0000:00:1d.2: setting latency timer to 64
[   13.656147] uhci_hcd 0000:00:1d.2: UHCI Host Controller
[   13.656175] drivers/usb/core/inode.c: creating file '008'
[   13.656203] uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 8
[   13.656209] uhci_hcd 0000:00:1d.2: detected 2 ports
[   13.656212] uhci_hcd 0000:00:1d.2: uhci_check_and_reset_hc: cmd = 0x0000
[   13.656213] uhci_hcd 0000:00:1d.2: Performing full reset
[   13.656227] uhci_hcd 0000:00:1d.2: supports USB remote wakeup
[   13.656230] uhci_hcd 0000:00:1d.2: irq 18, io base 0x000018c0
[   13.656256] usb usb8: default language 0x0409
[   13.656278] usb usb8: uevent
[   13.656295] usb usb8: usb_probe_device
[   13.656296] usb usb8: configuration #1 chosen from 1 choice
[   13.656299] usb usb8: adding 8-0:1.0 (config #1, interface 0)
[   13.656307] usb 8-0:1.0: uevent
[   13.656326] hub 8-0:1.0: usb_probe_interface
[   13.656327] hub 8-0:1.0: usb_probe_interface - got id
[   13.656328] hub 8-0:1.0: USB hub found
[   13.656335] hub 8-0:1.0: 2 ports detected
[   13.656336] hub 8-0:1.0: standalone hub
[   13.656336] hub 8-0:1.0: no power switching (usb 1.0)
[   13.656337] hub 8-0:1.0: individual port over-current protection
[   13.656338] hub 8-0:1.0: power on to power good time: 2ms
[   13.656340] hub 8-0:1.0: local power source is good
[   13.656341] hub 8-0:1.0: trying to enable port power on non-switchable hub
[   14.304011] usb usb6: suspend_rh (auto-stop)
[   14.304086] drivers/usb/core/inode.c: creating file '001'
[   14.304125] usb usb8: New USB device found, idVendor=1d6b, idProduct=0001
[   14.304127] usb usb8: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   14.304128] usb usb8: Product: UHCI Host Controller
[   14.304129] usb usb8: Manufacturer: Linux 2.6.27-gentoo-r3 uhci_hcd
[   14.304129] usb usb8: SerialNumber: 0000:00:1d.2
[   14.948029] usb usb7: suspend_rh (auto-stop)
[   15.194352] usb 3-2: skipped 16 descriptors after interface
[   15.194353] usb 3-2: skipped 2 descriptors after interface
[   15.194354] usb 3-2: skipped 1 descriptor after endpoint
[   15.194355] usb 3-2: skipped 2 descriptors after interface
[   15.194358] usb 3-2: skipped 1 descriptor after endpoint
[   15.194359] usb 3-2: skipped 2 descriptors after interface
[   15.194360] usb 3-2: skipped 1 descriptor after endpoint
[   15.194361] usb 3-2: skipped 1 descriptor after interface
[   15.198549] usb 3-2: default language 0x0409
[   15.203576] usb 3-2: uevent
[   15.203606] usb 3-2: usb_probe_device
[   15.203608] usb 3-2: configuration #1 chosen from 1 choice
[   15.255552] usb 3-2: adding 3-2:1.0 (config #1, interface 0)
[   15.255567] usb 3-2:1.0: uevent
[   15.255594] usb 3-2: adding 3-2:1.1 (config #1, interface 1)
[   15.255609] usb 3-2:1.1: uevent
[   15.255634] usb 3-2: adding 3-2:1.2 (config #1, interface 2)
[   15.255647] usb 3-2:1.2: uevent
[   15.255676] usb 3-2: adding 3-2:1.3 (config #1, interface 3)
[   15.255684] usb 3-2:1.3: uevent
[   15.255727] drivers/usb/core/inode.c: creating file '002'
[   15.255761] usb 3-2: New USB device found, idVendor=0ccd, idProduct=0028
[   15.305735] usb 3-2: New USB device strings: Mfr=0, Product=1, SerialNumber=0
[   15.355590] usb 3-2: Product: USB Audio
[   15.404983] hub 4-0:1.0: state 7 ports 2 chg 0000 evt 0000
[   15.404985] hub 5-0:1.0: state 7 ports 2 chg 0000 evt 0000
[   15.404987] hub 6-0:1.0: state 7 ports 2 chg 0000 evt 0000
[   15.404988] hub 7-0:1.0: state 7 ports 2 chg 0000 evt 0000
[   15.404990] hub 8-0:1.0: state 7 ports 2 chg 0000 evt 0000
[   15.405017] usbcore: registered new interface driver usblp
[   15.454809] usb usb8: suspend_rh (auto-stop)
[   15.454827] Initializing USB Mass Storage driver...
[   15.504252] usbcore: registered new interface driver usb-storage
[   15.554165] USB Mass Storage support registered.
[   15.604024] usbcore: registered new interface driver libusual
[   15.654296] usbcore: registered new interface driver usbserial
[   15.704275] usbserial: USB Serial support registered for generic
[   15.754322] usbserial_generic 3-2:1.0: usb_probe_interface
[   15.754323] usbserial_generic 3-2:1.0: usb_probe_interface - got id
[   15.754327] usbserial_generic 3-2:1.1: usb_probe_interface
[   15.754328] usbserial_generic 3-2:1.1: usb_probe_interface - got id
[   15.754331] usbserial_generic 3-2:1.2: usb_probe_interface
[   15.754332] usbserial_generic 3-2:1.2: usb_probe_interface - got id
[   15.754335] usbserial_generic 3-2:1.3: usb_probe_interface
[   15.754336] usbserial_generic 3-2:1.3: usb_probe_interface - got id
[   15.754362] usbcore: registered new interface driver usbserial_generic
[   15.804774] usbserial: USB Serial Driver core
[   15.855444] pnp: the driver 'i8042 kbd' has been registered
[   15.855454] i8042 kbd 00:0a: driver attached
[   15.855477] pnp: the driver 'i8042 aux' has been registered
[   15.855489] i8042 aux 00:0b: driver attached
[   15.855509] PNP: PS/2 Controller [PNP0303:KEYB,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
[   15.909855] serio: i8042 KBD port at 0x60,0x64 irq 1
[   15.961122] serio: i8042 AUX port at 0x60,0x64 irq 12
[   16.011829] mice: PS/2 mouse device common for all mice
[   16.091089] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input2
[   16.154292] input: PC Speaker as /devices/platform/pcspkr/input/input3
[   16.568075] input: ImPS/2 Generic Wheel Mouse as /devices/platform/i8042/serio1/input/input4
[   16.630016] pnp: the driver 'rtc_cmos' has been registered
[   16.630071] rtc_cmos 00:06: rtc core: registered rtc_cmos as rtc0
[   16.683191] rtc0: alarms up to one month, y3k, hpet irqs
[   16.736289] rtc_cmos 00:06: driver attached
[   16.736311] i2c /dev entries driver
[   16.736356] i801_smbus 0000:00:1f.3: PCI INT B -> GSI 17 (level, low) -> IRQ 17
[   16.760049] coretemp coretemp.0: Using relative temperature scale!
[   16.789067] coretemp coretemp.1: Using relative temperature scale!
[   16.799009] md: raid1 personality registered for level 1
[   16.799047] device-mapper: uevent: version 1.0.3
[   16.799115] device-mapper: ioctl: 4.14.0-ioctl (2008-04-23) initialised: dm-devel@redhat.com
[   16.799124] CAPI Subsystem Rev 1.1.2.8
[   16.799916] capi20: Rev 1.1.2.7: started up with major 68 (no capifs)
[   16.799939] b1pci: revision 1.1.2.2
[   16.799940] b1: revision 1.1.2.2
[   16.799941] b1dma: revision 1.1.2.3
[   16.799942] EDAC MC: Ver: 2.1.0 Nov 19 2008
[   16.800161] cpuidle: using governor ladder
[   17.019201] cpuidle: using governor menu
[   17.019242] usbcore: registered new interface driver hiddev
[   17.019251] usbhid 3-2:1.3: usb_probe_interface
[   17.019252] usbhid 3-2:1.3: usb_probe_interface - got id
[   17.020558] Marking TSC unstable due to TSC halts in idle
[   17.649479] input: USB Audio as /devices/pci0000:00/0000:00:1a.0/usb3/3-2/3-2:1.3/input/input5
[   17.704673] hub 4-0:1.0: hub_suspend
[   17.704675] usb usb4: bus auto-suspend
[   17.704676] usb usb4: suspend_rh
[   17.704688] hub 5-0:1.0: hub_suspend
[   17.704690] usb usb5: bus auto-suspend
[   17.704691] usb usb5: suspend_rh
[   17.704701] hub 6-0:1.0: hub_suspend
[   17.704703] usb usb6: bus auto-suspend
[   17.704703] usb usb6: suspend_rh
[   17.704714] hub 7-0:1.0: hub_suspend
[   17.704715] usb usb7: bus auto-suspend
[   17.704716] usb usb7: suspend_rh
[   17.704727] hub 8-0:1.0: hub_suspend
[   17.704729] usb usb8: bus auto-suspend
[   17.704729] usb usb8: suspend_rh
[   17.709024] uhci_hcd 0000:00:1a.0: reserve dev 2 ep83-INT, period 32, phase 16, 13 us
[   17.712110] input,hidraw0: USB HID v1.00 Device [USB Audio] on usb-0000:00:1a.0-2
[   17.767556] usbcore: registered new interface driver usbhid
[   17.822932] usbhid: v2.6:USB HID core driver
[   17.877941] Advanced Linux Sound Architecture Driver Version 1.0.17.
[   17.933755] snd-usb-audio 3-2:1.0: usb_probe_interface
[   17.933758] snd-usb-audio 3-2:1.0: usb_probe_interface - got id
[   18.030986] usbcore: registered new interface driver snd-usb-audio
[   18.086740] ALSA device list:
[   18.141671]   #0: USB Audio at usb-0000:00:1a.0-2, full speed
[   18.197479] Netfilter messages via NETLINK v0.30.
[   18.253206] nf_conntrack version 0.5.0 (16384 buckets, 65536 max)
[   18.309565] ctnetlink v0.93: registering with nfnetlink.
[   18.366616] ip_tables: (C) 2000-2006 Netfilter Core Team
[   18.423269] TCP cubic registered
[   18.479517] Initializing XFRM netlink socket
[   18.536401] NET: Registered protocol family 10
[   18.593391] ip6_tables: (C) 2000-2006 Netfilter Core Team
[   18.650094] IPv6 over IPv4 tunneling driver
[   18.706756] NET: Registered protocol family 17
[   18.763100] RPC: Registered udp transport module.
[   18.819162] RPC: Registered tcp transport module.
[   18.875513] SCTP: Hash tables configured (established 65536 bind 65536)
[   18.939217] registered taskstats version 1
[   18.994859]   Magic number: 0:645:144
[   19.049935] block ram9: hash matches
[   19.104774] acpi device:15: hash matches
[   19.159557] md: Autodetecting RAID arrays.
[   19.476457] md: Scanned 16 and added 16 devices.
[   19.530579] md: autorun ...
[   19.584011] md: considering sdd4 ...
[   19.637814] md:  adding sdd4 ...
[   19.691042] md: sdd3 has different UUID to sdd4
[   19.744097] md: sdd2 has different UUID to sdd4
[   19.744099] md: sdd1 has different UUID to sdd4
[   19.744102] md:  adding sdc4 ...
[   19.744103] md: sdc3 has different UUID to sdd4
[   19.744105] md: sdc2 has different UUID to sdd4
[   19.744107] md: sdc1 has different UUID to sdd4
[   19.744108] md: sdb4 has different UUID to sdd4
[   19.744110] md: sdb3 has different UUID to sdd4
[   19.744112] md: sdb2 has different UUID to sdd4
[   19.744113] md: sdb1 has different UUID to sdd4
[   19.744115] md: sda4 has different UUID to sdd4
[   19.744117] md: sda3 has different UUID to sdd4
[   19.744118] md: sda2 has different UUID to sdd4
[   19.744120] md: sda1 has different UUID to sdd4
[   20.388848] md: created md8
[   20.428248] md: bind<sdc4>
[   20.467142] md: bind<sdd4>
[   20.504901] md: running: <sdd4><sdc4>
[   20.542101] raid1: raid set md8 active with 2 out of 2 mirrors
[   20.579456] md: considering sdd3 ...
[   20.616230] md:  adding sdd3 ...
[   20.652948] md: sdd2 has different UUID to sdd3
[   20.652950] md: sdd1 has different UUID to sdd3
[   20.652953] md:  adding sdc3 ...
[   20.652954] md: sdc2 has different UUID to sdd3
[   20.652956] md: sdc1 has different UUID to sdd3
[   20.652957] md: sdb4 has different UUID to sdd3
[   20.652959] md: sdb3 has different UUID to sdd3
[   20.652961] md: sdb2 has different UUID to sdd3
[   20.652962] md: sdb1 has different UUID to sdd3
[   20.652964] md: sda4 has different UUID to sdd3
[   20.652966] md: sda3 has different UUID to sdd3
[   20.652967] md: sda2 has different UUID to sdd3
[   20.652969] md: sda1 has different UUID to sdd3
[   20.653042] md: created md7
[   20.653043] md: bind<sdc3>
[   20.653048] md: bind<sdd3>
[   20.653053] md: running: <sdd3><sdc3>
[   20.653122] raid1: raid set md7 active with 2 out of 2 mirrors
[   20.653148] md: considering sdd2 ...
[   20.653150] md:  adding sdd2 ...
[   20.653152] md: sdd1 has different UUID to sdd2
[   20.653154] md:  adding sdc2 ...
[   20.653156] md: sdc1 has different UUID to sdd2
[   20.653158] md: sdb4 has different UUID to sdd2
[   20.653159] md: sdb3 has different UUID to sdd2
[   20.653161] md: sdb2 has different UUID to sdd2
[   20.653163] md: sdb1 has different UUID to sdd2
[   20.653164] md: sda4 has different UUID to sdd2
[   20.653166] md: sda3 has different UUID to sdd2
[   20.653167] md: sda2 has different UUID to sdd2
[   20.653169] md: sda1 has different UUID to sdd2
[   20.653232] md: created md6
[   20.653233] md: bind<sdc2>
[   20.653237] md: bind<sdd2>
[   20.653241] md: running: <sdd2><sdc2>
[   20.653306] raid1: raid set md6 active with 2 out of 2 mirrors
[   20.653333] md: considering sdd1 ...
[   20.653336] md:  adding sdd1 ...
[   20.653338] md:  adding sdc1 ...
[   20.653339] md: sdb4 has different UUID to sdd1
[   20.653341] md: sdb3 has different UUID to sdd1
[   20.653343] md: sdb2 has different UUID to sdd1
[   20.653344] md: sdb1 has different UUID to sdd1
[   20.653346] md: sda4 has different UUID to sdd1
[   20.653348] md: sda3 has different UUID to sdd1
[   20.653349] md: sda2 has different UUID to sdd1
[   20.653351] md: sda1 has different UUID to sdd1
[   20.653409] md: created md5
[   20.653410] md: bind<sdc1>
[   20.653417] md: bind<sdd1>
[   20.653422] md: running: <sdd1><sdc1>
[   20.653488] raid1: raid set md5 active with 2 out of 2 mirrors
[   20.653513] md: considering sdb4 ...
[   20.653516] md:  adding sdb4 ...
[   20.653517] md: sdb3 has different UUID to sdb4
[   20.653519] md: sdb2 has different UUID to sdb4
[   20.653520] md: sdb1 has different UUID to sdb4
[   20.653523] md:  adding sda4 ...
[   20.653524] md: sda3 has different UUID to sdb4
[   20.653526] md: sda2 has different UUID to sdb4
[   20.653528] md: sda1 has different UUID to sdb4
[   20.653587] md: created md4
[   20.653588] md: bind<sda4>
[   20.653593] md: bind<sdb4>
[   20.653597] md: running: <sdb4><sda4>
[   20.653662] raid1: raid set md4 active with 2 out of 2 mirrors
[   20.653688] md: considering sdb3 ...
[   20.653690] md:  adding sdb3 ...
[   20.653692] md: sdb2 has different UUID to sdb3
[   20.653694] md: sdb1 has different UUID to sdb3
[   20.653696] md:  adding sda3 ...
[   20.653698] md: sda2 has different UUID to sdb3
[   20.653699] md: sda1 has different UUID to sdb3
[   20.653761] md: created md3
[   20.653762] md: bind<sda3>
[   20.653767] md: bind<sdb3>
[   20.653773] md: running: <sdb3><sda3>
[   20.653838] raid1: raid set md3 active with 2 out of 2 mirrors
[   20.653863] md: considering sdb2 ...
[   20.653865] md:  adding sdb2 ...
[   20.653867] md: sdb1 has different UUID to sdb2
[   20.653869] md:  adding sda2 ...
[   20.653871] md: sda1 has different UUID to sdb2
[   20.653931] md: created md2
[   20.653932] md: bind<sda2>
[   20.653937] md: bind<sdb2>
[   20.653941] md: running: <sdb2><sda2>
[   20.654017] raid1: raid set md2 active with 2 out of 2 mirrors
[   20.654042] md: considering sdb1 ...
[   20.654045] md:  adding sdb1 ...
[   20.654047] md:  adding sda1 ...
[   20.654108] md: created md1
[   20.654109] md: bind<sda1>
[   20.654114] md: bind<sdb1>
[   20.654118] md: running: <sdb1><sda1>
[   20.654185] raid1: raid set md1 active with 2 out of 2 mirrors
[   20.654211] md: ... autorun DONE.
[   22.792447] kjournald starting.  Commit interval 5 seconds
[   22.792457] EXT3-fs: mounted filesystem with ordered data mode.
[   22.792464] VFS: Mounted root (ext3 filesystem) readonly.
[   22.792476] Freeing unused kernel memory: 452k freed
[   25.419727] usb usb3: uevent
[   25.419832] usb 3-0:1.0: uevent
[   25.420024] usb 3-2: uevent
[   25.420123] usb 3-2:1.0: uevent
[   25.420967] usb 3-2:1.1: uevent
[   25.421082] usb 3-2:1.2: uevent
[   25.421214] usb 3-2:1.3: uevent
[   25.422434] usb usb4: uevent
[   25.422583] usb 4-0:1.0: uevent
[   25.423593] usb usb5: uevent
[   25.423772] usb 5-0:1.0: uevent
[   25.425200] usb usb1: uevent
[   25.425211] usb 1-0:1.0: uevent
[   25.425393] usb usb6: uevent
[   25.425401] usb 6-0:1.0: uevent
[   25.425447] usb usb7: uevent
[   25.425455] usb 7-0:1.0: uevent
[   25.425501] usb usb8: uevent
[   25.425510] usb 8-0:1.0: uevent
[   25.425555] usb usb2: uevent
[   25.425564] usb 2-0:1.0: uevent
[   30.511321] EXT3 FS on md3, internal journal
[   30.732985] kjournald starting.  Commit interval 5 seconds
[   30.783879] EXT3 FS on dm-0, internal journal
[   30.783883] EXT3-fs: mounted filesystem with ordered data mode.
[   30.974092] kjournald starting.  Commit interval 5 seconds
[   30.974304] EXT3 FS on dm-3, internal journal
[   30.974307] EXT3-fs: mounted filesystem with ordered data mode.
[   31.043295] kjournald starting.  Commit interval 5 seconds
[   31.043518] EXT3 FS on dm-4, internal journal
[   31.043521] EXT3-fs: mounted filesystem with ordered data mode.
[   31.137418] kjournald starting.  Commit interval 5 seconds
[   31.137619] EXT3 FS on dm-5, internal journal
[   31.137622] EXT3-fs: mounted filesystem with ordered data mode.

--=-=-=



-- 
Frank Cringle

--=-=-=--
