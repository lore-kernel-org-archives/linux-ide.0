From: Lars Michael Jogback <lm@jogback.se>
Subject: Re: Problem w/ hotplug on sata_sil24 w/ PMP (sil3726)
Date: Tue, 14 Oct 2008 22:19:18 +0200
Message-ID: <20081014201917.GA5974@cleopatra.jogback.se>
References: <20081011142735.GB5904@cleopatra.jogback.se> <48F4337A.50307@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="cWoXeonUoKmBZSoM"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.jogback.se ([192.165.82.10]:46091 "EHLO mail.jogback.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751532AbYJNUVI (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 14 Oct 2008 16:21:08 -0400
Content-Disposition: inline
In-Reply-To: <48F4337A.50307@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org


--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline

* Tejun Heo <tj@kernel.org> [2008-10-14 14:51:54]:

> Hmmm.. drives usually make reset wait while they're spinning up so
> that's where the spin wait logic is implemented.  Strange.  Can you
> post full boot log and the result of "hdparm -I" on the drive?  Also,
> if you first spin up the drive by conneciting only the power connector
> and then connect the SATA cable a bit later, does it work?

OK, The drives are placed in hotswap-cages in an external enclosure with
it's own powersupply. I have no possibility to connect the power to the
actual drive before signal when I'm hotswapping. I don't think that'll
make a difference though, since I have the same issue when I do a "cold
boot".

With "cold boot" I mean that I turn the power on the enclosure first and
then boot the PC. With a "warm boot" I reboot the PC a second time 
without powercycling the disc enclosure or the discs.

When I boot the first drive on the PMP is detected by the Sil3124. If
it's a "cold boot", the second drive is not detected in Linux with the
same error as when I hotplug the drive.

When I "warm boot" everything detects and is fine until I hotplug a
disc.

Attached is dmesg from cold and warm boot, and hdparm -I on one of the
disks.

BR,
/LM

--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: attachment; filename="warm_boot_dmesg.txt"

[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Linux version 2.6.26-1-xen-amd64 (Debian 2.6.26-8) (waldi@debian.org) (gcc version 4.1.3 20080623 (prerelease) (Debian 4.1.2-23)) #1 SMP Thu Oct 9 17:11:22 UTC 2008
[    0.000000] Command line: root=/dev/mapper/cleopatra-root ro console=tty0 elevator=deadline
[    0.000000] BIOS-provided physical RAM map:
[    0.000000]  Xen: 0000000000000000 - 0000000080800000 (usable)
[    0.000000] Entering add_active_range(0, 0, 526336) 0 entries of 256 used
[    0.000000] max_pfn_mapped = 526336
[    0.000000] init_memory_mapping
[    0.000000] DMI present.
[    0.000000] Entering add_active_range(0, 0, 526336) 0 entries of 256 used
[    0.000000]   early res: 0 [200000-631917] TEXT DATA BSS
[    0.000000]   early res: 1 [632000-1f53fff] Xen provided
[    0.000000]   early res: 2 [1f54000-1f55fff] INITMAP
[    0.000000]   early res: 3 [1f56000-235efff] PGTABLE
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA             0 ->     4096
[    0.000000]   DMA32        4096 ->  1048576
[    0.000000]   Normal    1048576 ->  1048576
[    0.000000] Movable zone start PFN for each node
[    0.000000] early_node_map[1] active PFN ranges
[    0.000000]     0:        0 ->   526336
[    0.000000] On node 0 totalpages: 526336
[    0.000000]   DMA zone: 56 pages used for memmap
[    0.000000]   DMA zone: 0 pages reserved
[    0.000000]   DMA zone: 4040 pages, LIFO batch:0
[    0.000000]   DMA32 zone: 7140 pages used for memmap
[    0.000000]   DMA32 zone: 515100 pages, LIFO batch:31
[    0.000000]   Normal zone: 0 pages used for memmap
[    0.000000]   Movable zone: 0 pages used for memmap
[    0.000000] ACPI: RSDP 000F5F00, 0014 (r0 PTLTD )
[    0.000000] ACPI: RSDT DFEE3831, 003C (r1 PTLTD    RSDT    6040000  LTP        0)
[    0.000000] ACPI: FACP DFEE9E70, 0074 (r1 INTEL            6040000 PTL         3)
[    0.000000] ACPI: DSDT DFEE4C59, 5217 (r1  INTEL GLENWOOD  6040000 MSFT  100000E)
[    0.000000] ACPI: FACS DFEEAFC0, 0040
[    0.000000] ACPI: MCFG DFEE9EE4, 003C (r1 PTLTD    MCFG    6040000  LTP        0)
[    0.000000] ACPI: HPET DFEE9F20, 0038 (r1 PTLTD  HPETTBL   6040000  LTP        1)
[    0.000000] ACPI: APIC DFEE9F58, 0080 (r1 PTLTD  	 APIC    6040000  LTP        0)
[    0.000000] ACPI: BOOT DFEE9FD8, 0028 (r1 PTLTD  $SBFTBL$  6040000  LTP        1)
[    0.000000] ACPI: SSDT DFEE386D, 13EC (r1  PmRef    CpuPm     3000 INTL 20050228)
[    0.000000] ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
[    0.000000] ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 2, version 0, address 0xfec00000, GSI 0-23
[    0.000000] ACPI: IOAPIC (id[0x03] address[0xfecc0000] gsi_base[24])
[    0.000000] IOAPIC[1]: apic_id 3, version 0, address 0xfecc0000, GSI 24-47
[    0.000000] ACPI: IOAPIC (id[0x04] address[0xfecc0400] gsi_base[48])
[    0.000000] IOAPIC[2]: apic_id 4, version 0, address 0xfecc0400, GSI 48-71
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 high edge)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ2 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Setting APIC routing to xen
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] Allocating PCI resources starting at e1000000 (gap: e0000000:10000000)
[    0.000000] PERCPU: Allocating 22192 bytes of per cpu data
[    0.000000] NR_CPUS: 32, nr_cpu_ids: 2
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 519140
[    0.000000] Kernel command line: root=/dev/mapper/cleopatra-root ro console=tty0 elevator=deadline
[    0.000000] Initializing CPU#0
[    0.000000] PID hash table entries: 4096 (order: 12, 32768 bytes)
[    0.000000] Xen reported: 2394.012 MHz processor.
[    0.004000] Console: colour VGA+ 80x25
[    0.004000] console [tty0] enabled
[    0.004000] console [xvc-1] enabled
[    0.004000] Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
[    0.004000] Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes)
[    0.004000] Software IO TLB enabled: 
[    0.004000]  Aperture:     64 megabytes
[    0.004000]  Kernel range: ffff88000438f000 - ffff88000838f000
[    0.004000]  Address size: 27 bits
[    0.004000] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    0.004000] Memory: 1964436k/2105344k available (2277k kernel code, 132504k reserved, 1021k data, 216k init)
[    0.004000] CPA: page pool initialized 1 of 1 pages preallocated
[    0.788053] Calibrating delay using timer specific routine.. 4790.06 BogoMIPS (lpj=9580137)
[    0.788262] Security Framework initialized
[    0.788353] SELinux:  Disabled at boot.
[    0.788440] Capability LSM initialized
[    0.788540] Mount-cache hash table entries: 256
[    0.788756] Initializing cgroup subsys ns
[    0.788845] Initializing cgroup subsys cpuacct
[    0.788932] Initializing cgroup subsys devices
[    0.789043] CPU: L1 I cache: 32K, L1 D cache: 32K
[    0.789193] CPU: L2 cache: 4096K
[    0.789280] CPU: Physical Processor ID: 0
[    0.789365] CPU: Processor Core ID: 0
[    0.789461] ACPI: Core revision 20080321
[    0.797499] Brought up 2 CPUs
[    0.797499] Initializing CPU#1
[    0.797499] CPU: L1 I cache: 32K, L1 D cache: 32K
[    0.797499] CPU: L2 cache: 4096K
[    0.797499] CPU: Physical Processor ID: 0
[    0.797499] CPU: Processor Core ID: 1
[    0.798030] CPU0 attaching sched-domain:
[    0.798033]  domain 0: span 0-1
[    0.798035]   groups: 0 1
[    0.798038] CPU1 attaching sched-domain:
[    0.798040]  domain 0: span 0-1
[    0.798041]   groups: 1 0
[    0.800137] net_namespace: 1224 bytes
[    0.800374] NET: Registered protocol family 16
[    0.800734] ACPI: bus type pci registered
[    0.800917] PCI: MCFG configuration 0: base f0000000 segment 0 buses 0 - 19
[    0.801009] PCI: MCFG area at f0000000 reserved in E820
[    0.802447] PCI: Using MMCONFIG at f0000000 - f13fffff
[    0.802536] PCI: Using configuration type 1 for base access
[    0.805382] ACPI: EC: Look up EC in DSDT
[    0.808052] ACPI: Interpreter enabled
[    0.808139] ACPI: (supports S0 S1 S5)
[    0.808421] ACPI: Using IOAPIC for interrupt routing
[    0.813075] ACPI: PCI Root Bridge [PCI0] (0000:00)
[    0.814329] pci 0000:00:1f.0: quirk: region 1000-107f claimed by ICH6 ACPI/GPIO/TCO
[    0.814440] pci 0000:00:1f.0: quirk: region 1180-11bf claimed by ICH6 GPIO
[    0.814785] pci 0000:01:00.0: PXH quirk detected; SHPC device MSI disabled
[    0.815053] pci 0000:01:00.2: PXH quirk detected; SHPC device MSI disabled
[    0.816582] PCI: Transparent bridge - 0000:00:1e.0
[    0.816727] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[    0.816940] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.DEV1.PXHA._PRT]
[    0.817101] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.DEV1.PXHB._PRT]
[    0.817269] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.EXP1._PRT]
[    0.817364] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.EXP5._PRT]
[    0.817425] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.EXP6._PRT]
[    0.817485] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIB._PRT]
[    0.822117] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 10 11 14 15) *7
[    0.822117] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 10 *11 14 15)
[    0.822735] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 10 11 14 15) *5
[    0.823410] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 10 *11 14 15)
[    0.824024] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 10 11 14 15) *0, disabled.
[    0.824788] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 10 11 14 15) *0, disabled.
[    0.825546] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 10 11 14 15) *0, disabled.
[    0.826311] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 *10 11 14 15)
[    0.830115] Linux Plug and Play Support v0.97 (c) Adam Belay
[    0.830115] pnp: PnP ACPI init
[    0.830115] ACPI: bus type pnp registered
[    0.830115] pnp 00:00: parse allocated resources
[    0.830115] pnp 00:00:   add io  0xcf8-0xcff flags 0x1
[    0.830115] pnp 00:00: Plug and Play ACPI device, IDs PNP0a03 (active)
[    0.830115] pnp 00:01: parse allocated resources
[    0.830115] pnp 00:01:   add io  0x10-0x1f flags 0x1
[    0.830115] pnp 00:01:   add io  0x24-0x25 flags 0x1
[    0.830115] pnp 00:01:   add io  0x28-0x29 flags 0x1
[    0.830115] pnp 00:01:   add io  0x2c-0x2d flags 0x1
[    0.830115] pnp 00:01:   add io  0x30-0x31 flags 0x1
[    0.830115] pnp 00:01:   add io  0x34-0x35 flags 0x1
[    0.830115] pnp 00:01:   add io  0x38-0x39 flags 0x1
[    0.830115] pnp 00:01:   add io  0x3c-0x3d flags 0x1
[    0.830115] pnp 00:01:   add io  0x72-0x77 flags 0x1
[    0.830115] pnp 00:01:   add io  0x80-0x80 flags 0x1
[    0.830115] pnp 00:01:   add io  0x90-0x9f flags 0x1
[    0.830115] pnp 00:01:   add io  0xa4-0xa5 flags 0x1
[    0.830115] pnp 00:01:   add io  0xa8-0xa9 flags 0x1
[    0.830115] pnp 00:01:   add io  0xac-0xad flags 0x1
[    0.830115] pnp 00:01:   add io  0xb0-0xb5 flags 0x1
[    0.830115] pnp 00:01:   add io  0xb8-0xb9 flags 0x1
[    0.830115] pnp 00:01:   add io  0xbc-0xbd flags 0x1
[    0.830115] pnp 00:01:   add io  0x295-0x296 flags 0x1
[    0.830115] pnp 00:01:   add io  0x800-0x83f flags 0x1
[    0.830115] pnp 00:01:   add io  0x900-0x90f flags 0x1
[    0.830115] pnp 00:01:   add io  0x1000-0x107f flags 0x1
[    0.830115] pnp 00:01:   add io  0x1180-0x11bf flags 0x1
[    0.830115] pnp 00:01:   add io  0x2e-0x2f flags 0x1
[    0.830115] pnp 00:01:   add io  0x4d0-0x4d1 flags 0x1
[    0.830115] pnp 00:01:   add io  0xfe00-0xfe00 flags 0x1
[    0.830115] pnp 00:01:   add mem 0xfed14000-0xfed17fff flags 0x1
[    0.830115] pnp 00:01:   add mem 0xfed13000-0xfed13fff flags 0x1
[    0.830115] pnp 00:01:   add mem 0xfed18000-0xfed1bfff flags 0x1
[    0.830115] pnp 00:01:   add mem 0xf0000000-0xf3ffffff flags 0x1
[    0.830115] pnp 00:01:   add mem 0xfed20000-0xfed8ffff flags 0x1
[    0.830115] pnp 00:01:   add mem 0xfef00000-0xfeffffff flags 0x1
[    0.830115] pnp 00:01: PNP0c02: calling quirk_system_pci_resources+0x0/0x15c
[    0.830115] pnp 00:01: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.830115] pnp 00:02: parse allocated resources
[    0.830115] pnp 00:02:   add io  0x0-0xf flags 0x1
[    0.830115] pnp 00:02:   add io  0x81-0x8f flags 0x1
[    0.830115] pnp 00:02:   add io  0xc0-0xdf flags 0x1
[    0.830115] pnp 00:02:   add dma 4 flags 0x2
[    0.830115] pnp 00:02: Plug and Play ACPI device, IDs PNP0200 (active)
[    0.830115] pnp 00:03: parse allocated resources
[    0.830115] pnp 00:03:   add io  0xf0-0xfe flags 0x1
[    0.830115] pnp 00:03:   add irq 13 flags 0x1
[    0.830115] pnp 00:03: Plug and Play ACPI device, IDs PNP0c04 (active)
[    0.830115] pnp 00:04: parse allocated resources
[    0.830115] pnp 00:04:   add io  0x70-0x71 flags 0x1
[    0.830115] pnp 00:04: Plug and Play ACPI device, IDs PNP0b00 (active)
[    0.830115] pnp 00:05: parse allocated resources
[    0.830115] pnp 00:05:   add io  0x61-0x61 flags 0x1
[    0.830115] pnp 00:05: Plug and Play ACPI device, IDs PNP0800 (active)
[    0.830115] pnp 00:06: parse allocated resources
[    0.830115] pnp 00:06:   add irq 8 flags 0x1
[    0.830115] pnp 00:06:   add mem 0xfed00000-0xfed003ff flags 0x0
[    0.830115] pnp 00:06: Plug and Play ACPI device, IDs PNP0103 (active)
[    0.830115] pnp 00:07: parse allocated resources
[    0.830115] pnp 00:07:   add mem 0xff800000-0xffffffff flags 0x0
[    0.830115] pnp 00:07: Plug and Play ACPI device, IDs INT0800 (active)
[    0.830115] pnp 00:08: parse allocated resources
[    0.830115] pnp 00:08:   add io  0x60-0x60 flags 0x1
[    0.830115] pnp 00:08:   add io  0x64-0x64 flags 0x1
[    0.830115] pnp 00:08:   add irq 1 flags 0x1
[    0.830115] pnp 00:08: Plug and Play ACPI device, IDs PNP0303 PNP030b (active)
[    0.830115] pnp 00:09: parse allocated resources
[    0.830115] pnp 00:09:   add irq 12 flags 0x1
[    0.830115] pnp 00:09: Plug and Play ACPI device, IDs PNP0f13 PNP0f13 (active)
[    0.830115] pnp 00:0a: parse allocated resources
[    0.830115] pnp 00:0a:   add io  0x3f8-0x3ff flags 0x1
[    0.830115] pnp 00:0a:   add irq 4 flags 0x1
[    0.830115] pnp 00:0a: parse resource options
[    0.830115] pnp 00:0a: new independent option
[    0.830115] pnp 00:0a: new dependent option (priority 0x0)
[    0.830115] pnp 00:0a:   io  min 0x3f8 max 0x3f8 align 1 size 8 flags 0x1
[    0.830115] pnp 00:0a:   irq bitmask 00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000010 flags 0x1
[    0.830115] pnp 00:0a: new dependent option (priority 0x1)
[    0.830115] pnp 00:0a:   io  min 0x2f8 max 0x2f8 align 1 size 8 flags 0x1
[    0.830115] pnp 00:0a:   irq bitmask 00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000008 flags 0x1
[    0.830115] pnp 00:0a: new dependent option (priority 0x1)
[    0.830115] pnp 00:0a:   io  min 0x3e8 max 0x3e8 align 1 size 8 flags 0x1
[    0.830115] pnp 00:0a:   irq bitmask 00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000010 flags 0x1
[    0.830115] pnp 00:0a: new dependent option (priority 0x1)
[    0.830115] pnp 00:0a:   io  min 0x2e8 max 0x2e8 align 1 size 8 flags 0x1
[    0.830115] pnp 00:0a:   irq bitmask 00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000008 flags 0x1
[    0.830115] pnp 00:0a: new dependent option (priority 0x2)
[    0.830115] pnp 00:0a:   io  min 0x3f8 max 0x3f8 align 1 size 8 flags 0x1
[    0.830115] pnp 00:0a:   irq bitmask 00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000008 flags 0x1
[    0.830115] pnp 00:0a: new dependent option (priority 0x2)
[    0.830115] pnp 00:0a:   io  min 0x2f8 max 0x2f8 align 1 size 8 flags 0x1
[    0.830115] pnp 00:0a:   irq bitmask 00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000010 flags 0x1
[    0.830115] pnp 00:0a: new dependent option (priority 0x2)
[    0.830115] pnp 00:0a:   io  min 0x3e8 max 0x3e8 align 1 size 8 flags 0x1
[    0.830115] pnp 00:0a:   irq bitmask 00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000008 flags 0x1
[    0.830115] pnp 00:0a: new dependent option (priority 0x2)
[    0.830115] pnp 00:0a:   io  min 0x2e8 max 0x2e8 align 1 size 8 flags 0x1
[    0.830115] pnp 00:0a:   irq bitmask 00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000010 flags 0x1
[    0.830115] pnp 00:0a: end dependent options
[    0.830115] pnp 00:0a: Plug and Play ACPI device, IDs PNP0501 (active)
[    0.830115] pnp 00:0b: parse allocated resources
[    0.830115] pnp 00:0b:   add io  0x2f8-0x2ff flags 0x1
[    0.830126] pnp 00:0b:   add irq 3 flags 0x1
[    0.830127] pnp 00:0b: parse resource options
[    0.830129] pnp 00:0b: new independent option
[    0.830137] pnp 00:0b: new dependent option (priority 0x1)
[    0.830139] pnp 00:0b:   io  min 0x3f8 max 0x3f8 align 1 size 8 flags 0x1
[    0.830142] pnp 00:0b:   irq bitmask 00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000010 flags 0x1
[    0.830145] pnp 00:0b: new dependent option (priority 0x0)
[    0.830147] pnp 00:0b:   io  min 0x2f8 max 0x2f8 align 1 size 8 flags 0x1
[    0.830150] pnp 00:0b:   irq bitmask 00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000008 flags 0x1
[    0.830152] pnp 00:0b: new dependent option (priority 0x1)
[    0.830155] pnp 00:0b:   io  min 0x3e8 max 0x3e8 align 1 size 8 flags 0x1
[    0.830158] pnp 00:0b:   irq bitmask 00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000010 flags 0x1
[    0.830160] pnp 00:0b: new dependent option (priority 0x1)
[    0.830162] pnp 00:0b:   io  min 0x2e8 max 0x2e8 align 1 size 8 flags 0x1
[    0.830165] pnp 00:0b:   irq bitmask 00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000008 flags 0x1
[    0.830168] pnp 00:0b: new dependent option (priority 0x2)
[    0.830170] pnp 00:0b:   io  min 0x3f8 max 0x3f8 align 1 size 8 flags 0x1
[    0.830173] pnp 00:0b:   irq bitmask 00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000008 flags 0x1
[    0.830175] pnp 00:0b: new dependent option (priority 0x2)
[    0.830177] pnp 00:0b:   io  min 0x2f8 max 0x2f8 align 1 size 8 flags 0x1
[    0.830180] pnp 00:0b:   irq bitmask 00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000010 flags 0x1
[    0.830183] pnp 00:0b: new dependent option (priority 0x2)
[    0.830185] pnp 00:0b:   io  min 0x3e8 max 0x3e8 align 1 size 8 flags 0x1
[    0.830188] pnp 00:0b:   irq bitmask 00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000008 flags 0x1
[    0.830190] pnp 00:0b: new dependent option (priority 0x2)
[    0.830192] pnp 00:0b:   io  min 0x2e8 max 0x2e8 align 1 size 8 flags 0x1
[    0.830195] pnp 00:0b:   irq bitmask 00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000010 flags 0x1
[    0.830198] pnp 00:0b: end dependent options
[    0.830244] pnp 00:0b: Plug and Play ACPI device, IDs PNP0501 (active)
[    0.830369] pnp 00:0c: parse allocated resources
[    0.830640] pnp 00:0c:   add io  0x3f0-0x3f5 flags 0x1
[    0.830643] pnp 00:0c:   add io  0x3f7-0x3f7 flags 0x1
[    0.830647] pnp 00:0c:   add irq 6 flags 0x1
[    0.830649] pnp 00:0c:   add dma 2 flags 0x0
[    0.830650] pnp 00:0c: parse resource options
[    0.830652] pnp 00:0c: new independent option
[    0.830657] pnp 00:0c: new dependent option (priority 0x0)
[    0.830659] pnp 00:0c:   io  min 0x3f0 max 0x3f0 align 1 size 6 flags 0x1
[    0.830661] pnp 00:0c:   io  min 0x3f7 max 0x3f7 align 1 size 1 flags 0x1
[    0.830665] pnp 00:0c:   irq bitmask 00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000040 flags 0x1
[    0.830667] pnp 00:0c:   dma bitmask 0x4 flags 0x0
[    0.830669] pnp 00:0c: new dependent option (priority 0x0)
[    0.830671] pnp 00:0c:   io  min 0x370 max 0x370 align 1 size 6 flags 0x1
[    0.830673] pnp 00:0c:   io  min 0x377 max 0x377 align 1 size 1 flags 0x1
[    0.830676] pnp 00:0c:   irq bitmask 00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000040 flags 0x1
[    0.830679] pnp 00:0c:   dma bitmask 0x4 flags 0x0
[    0.830680] pnp 00:0c: end dependent options
[    0.830728] pnp 00:0c: Plug and Play ACPI device, IDs PNP0700 (active)
[    0.830888] pnp: PnP ACPI: found 13 devices
[    0.830979] ACPI: ACPI bus type pnp unregistered
[    0.831097] xen_mem: Initialising balloon driver.
[    0.834114] usbcore: registered new interface driver usbfs
[    0.834114] usbcore: registered new interface driver hub
[    0.834114] usbcore: registered new device driver usb
[    0.834115] PCI: Using ACPI for IRQ routing
[    0.834115] PCI: Cannot allocate resource region 7 of bridge 0000:00:1c.0
[    0.840313] PCI: Cannot allocate resource region 8 of bridge 0000:00:1c.0
[    0.840405] PCI: Cannot allocate resource region 9 of bridge 0000:00:1c.0
[    0.878197] ACPI: RTC can wake from S4
[    0.889989] pnp: the driver 'system' has been registered
[    0.890008] system 00:01: ioport range 0x295-0x296 has been reserved
[    0.890113] system 00:01: ioport range 0x800-0x83f has been reserved
[    0.890197] system 00:01: ioport range 0x900-0x90f has been reserved
[    0.890197] system 00:01: ioport range 0x1000-0x107f has been reserved
[    0.890197] system 00:01: ioport range 0x1180-0x11bf has been reserved
[    0.890197] system 00:01: ioport range 0x4d0-0x4d1 has been reserved
[    0.890197] system 00:01: ioport range 0xfe00-0xfe00 has been reserved
[    0.890197] system 00:01: iomem range 0xfed14000-0xfed17fff has been reserved
[    0.890197] system 00:01: iomem range 0xfed13000-0xfed13fff has been reserved
[    0.890197] system 00:01: iomem range 0xfed18000-0xfed1bfff has been reserved
[    0.890197] system 00:01: iomem range 0xf0000000-0xf3ffffff could not be reserved
[    0.890197] system 00:01: iomem range 0xfed20000-0xfed8ffff has been reserved
[    0.890197] system 00:01: iomem range 0xfef00000-0xfeffffff has been reserved
[    0.890197] system 00:01: driver attached
[    0.890197] PCI: Failed to allocate mem resource #9:100000@e1800000 for 0000:01:00.2
[    0.890197] PCI: Bridge: 0000:01:00.0
[    0.890197]   IO window: 4000-4fff
[    0.890197]   MEM window: 0xe0200000-0xe02fffff
[    0.890197]   PREFETCH window: 0x00000000e1000000-0x00000000e17fffff
[    0.890197] PCI: Bridge: 0000:01:00.2
[    0.890197]   IO window: 5000-5fff
[    0.890197]   MEM window: 0xe0300000-0xe03fffff
[    0.890197]   PREFETCH window: disabled.
[    0.890197] PCI: Bridge: 0000:00:01.0
[    0.890197]   IO window: 4000-5fff
[    0.890197]   MEM window: 0xe0100000-0xe03fffff
[    0.890197]   PREFETCH window: 0x00000000e1000000-0x00000000e17fffff
[    0.890197] PCI: Bridge: 0000:00:1c.0
[    0.890197]   IO window: disabled.
[    0.890197]   MEM window: disabled.
[    0.890197]   PREFETCH window: disabled.
[    0.890197] PCI: Bridge: 0000:00:1c.4
[    0.890197]   IO window: 6000-6fff
[    0.890197]   MEM window: 0xe0400000-0xe04fffff
[    0.890197]   PREFETCH window: disabled.
[    0.890197] PCI: Bridge: 0000:00:1c.5
[    0.890197]   IO window: 7000-7fff
[    0.895446]   MEM window: 0xe0500000-0xe05fffff
[    0.895540]   PREFETCH window: disabled.
[    0.895637] PCI: Bridge: 0000:00:1e.0
[    0.895727]   IO window: 8000-8fff
[    0.895820]   MEM window: 0xe0600000-0xe06fffff
[    0.895914]   PREFETCH window: 0x00000000e8000000-0x00000000efffffff
[    0.896041] ACPI: PCI Interrupt 0000:00:01.0[A] -> GSI 16 (level, low) -> IRQ 16
[    0.896222] PCI: Setting latency timer of device 0000:00:01.0 to 64
[    0.896252] PCI: Setting latency timer of device 0000:01:00.0 to 64
[    0.896282] PCI: Setting latency timer of device 0000:01:00.2 to 64
[    0.896315] ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 17 (level, low) -> IRQ 17
[    0.896498] PCI: Setting latency timer of device 0000:00:1c.0 to 64
[    0.896529] ACPI: PCI Interrupt 0000:00:1c.4[A] -> GSI 17 (level, low) -> IRQ 17
[    0.896710] PCI: Setting latency timer of device 0000:00:1c.4 to 64
[    0.896741] ACPI: PCI Interrupt 0000:00:1c.5[B] -> GSI 16 (level, low) -> IRQ 16
[    0.896921] PCI: Setting latency timer of device 0000:00:1c.5 to 64
[    0.896940] PCI: Setting latency timer of device 0000:00:1e.0 to 64
[    0.896973] NET: Registered protocol family 2
[    0.943648] IP route cache hash table entries: 65536 (order: 7, 524288 bytes)
[    0.944058] TCP established hash table entries: 262144 (order: 10, 4194304 bytes)
[    0.945552] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[    0.946209] TCP: Hash tables configured (established 262144 bind 65536)
[    0.946300] TCP reno registered
[    0.955754] NET: Registered protocol family 1
[    0.955960] checking if image is initramfs... it is
[    0.975589] Freeing initrd memory: 21558k freed
[    0.984084] Simple Boot Flag at 0x38 set to 0x1
[    0.986562] audit: initializing netlink socket (disabled)
[    0.986562] type=2000 audit(1224002821.976:1): initialized
[    0.986562] VFS: Disk quotas dquot_6.5.1
[    0.986562] Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    0.986562] msgmni has been set to 4138
[    0.986562] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 253)
[    0.986562] io scheduler noop registered
[    0.986562] io scheduler anticipatory registered
[    0.986562] io scheduler deadline registered (default)
[    0.986562] io scheduler cfq registered
[    0.986562] pci 0000:14:04.0: Boot video device
[    0.986562] PCI: Setting latency timer of device 0000:00:01.0 to 64
[    0.986562] assign_interrupt_mode Found MSI capability
[    0.986562] no ownder
[    0.986562] map irq failed
[    0.986562] Allocate Port Service[0000:00:01.0:pcie00]
[    0.986562] Allocate Port Service[0000:00:01.0:pcie03]
[    0.986562] PCI: Setting latency timer of device 0000:00:1c.0 to 64
[    0.986562] assign_interrupt_mode Found MSI capability
[    0.986562] no ownder
[    0.986653] map irq failed
[    0.987908] Allocate Port Service[0000:00:1c.0:pcie00]
[    0.988343] Allocate Port Service[0000:00:1c.0:pcie02]
[    0.988747] Allocate Port Service[0000:00:1c.0:pcie03]
[    0.989217] PCI: Setting latency timer of device 0000:00:1c.4 to 64
[    0.989283] assign_interrupt_mode Found MSI capability
[    0.989411] no ownder
[    0.989496] map irq failed
[    0.989582] Allocate Port Service[0000:00:1c.4:pcie00]
[    0.990904] Allocate Port Service[0000:00:1c.4:pcie02]
[    0.991722] Allocate Port Service[0000:00:1c.4:pcie03]
[    0.991722] PCI: Setting latency timer of device 0000:00:1c.5 to 64
[    0.991722] assign_interrupt_mode Found MSI capability
[    0.991722] no ownder
[    0.991722] map irq failed
[    0.991722] Allocate Port Service[0000:00:1c.5:pcie00]
[    0.991722] Allocate Port Service[0000:00:1c.5:pcie02]
[    0.991722] Allocate Port Service[0000:00:1c.5:pcie03]
[    0.995722] Linux agpgart interface v0.103
[    0.995722] Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
[    0.995722] serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[    0.995722] serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
[    0.995722] pnp: the driver 'serial' has been registered
[    0.995722] 00:0a: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[    0.995722] serial 00:0a: driver attached
[    0.995722] 00:0b: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
[    0.995722] serial 00:0b: driver attached
[    0.995722] brd: module loaded
[    0.995722] input: Macintosh mouse button emulation as /class/input/input0
[    0.995954] Xen virtual console successfully installed as xvc0
[    0.996794] Event-channel device installed.
[    0.999723] netfront: Initialising virtual ethernet driver.
[    0.999723] pnp: the driver 'i8042 kbd' has been registered
[    0.999723] i8042 kbd 00:08: driver attached
[    0.999723] pnp: the driver 'i8042 aux' has been registered
[    0.999723] i8042 aux 00:09: driver attached
[    0.999723] PNP: PS/2 Controller [PNP0303:KBC0,PNP0f13:MSE0] at 0x60,0x64 irq 1,12
[    1.002835] serio: i8042 KBD port at 0x60,0x64 irq 1
[    1.002931] serio: i8042 AUX port at 0x60,0x64 irq 12
[    1.030935] mice: PS/2 mouse device common for all mice
[    1.031218] pnp: the driver 'rtc_cmos' has been registered
[    1.031399] rtc_cmos 00:04: rtc core: registered rtc_cmos as rtc0
[    1.031512] rtc0: alarms up to one month, y3k
[    1.031602] rtc_cmos 00:04: driver attached
[    1.031765] No iBFT detected.
[    1.032107] TCP cubic registered
[    1.032107] NET: Registered protocol family 17
[    1.032107] registered taskstats version 1
[    1.032107] rtc_cmos 00:04: setting system clock to 2008-10-14 16:47:02 UTC (1224002822)
[    1.032107] Freeing unused kernel memory: 216k freed
[    1.052730] input: AT Translated Set 2 keyboard as /class/input/input1
[    1.134498] ACPI: ACPI0007:00 is registered as cooling_device0
[    1.136134] ACPI: ACPI0007:01 is registered as cooling_device1
[    1.136545] ACPI: ACPI0007:02 is registered as cooling_device2
[    1.136953] ACPI: ACPI0007:03 is registered as cooling_device3
[    1.137360] ACPI: ACPI0007:04 is registered as cooling_device4
[    1.137769] ACPI: ACPI0007:05 is registered as cooling_device5
[    1.138179] ACPI: ACPI0007:06 is registered as cooling_device6
[    1.138585] ACPI: ACPI0007:07 is registered as cooling_device7
[    1.402389] SCSI subsystem initialized
[    1.403304] 3ware 9000 Storage Controller device driver for Linux v2.26.02.010.
[    1.403461] ACPI: PCI Interrupt 0000:02:01.0[A] -> GSI 24 (level, low) -> IRQ 24
[    1.405473] No dock devices found.
[    1.413656] libata version 3.00 loaded.
[    1.426215] e1000e: Intel(R) PRO/1000 Network Driver - 0.3.3.3-k2
[    1.426315] e1000e: Copyright (c) 1999-2008 Intel Corporation.
[    1.431707] USB Universal Host Controller Interface driver v3.0
[    1.518256] floppy0: Unable to grab DMA2 for the floppy driver
[    1.544618] FDC 0 is a post-1991 82077
[    1.632660] scsi0 : 3ware 9000 Storage Controller
[    1.632853] 3w-9xxx: scsi0: Found a 3ware 9000 Storage Controller at 0xe0200000, IRQ: 24.
[    1.968585] 3w-9xxx: scsi0: Firmware FE9X 2.08.00.009, BIOS BE9X 2.03.01.052, Ports: 12.
[    1.969625] sata_sil24 0000:03:01.0: version 1.1
[    1.969983] ACPI: PCI Interrupt 0000:03:01.0[A] -> GSI 48 (level, low) -> IRQ 48
[    1.970179] sata_sil24 0000:03:01.0: Applying completion IRQ loss on PCI-X errata fix
[    1.970684] scsi1 : sata_sil24
[    1.970810] scsi2 : sata_sil24
[    1.970932] scsi3 : sata_sil24
[    1.971052] scsi4 : sata_sil24
[    1.971163] ata1: SATA max UDMA/100 host m128@0xe0308000 port 0xe0300000 irq 48
[    1.971274] ata2: SATA max UDMA/100 host m128@0xe0308000 port 0xe0302000 irq 48
[    1.971384] ata3: SATA max UDMA/100 host m128@0xe0308000 port 0xe0304000 irq 48
[    1.971495] ata4: SATA max UDMA/100 host m128@0xe0308000 port 0xe0306000 irq 48
[    1.972714] ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 23 (level, low) -> IRQ 23
[    1.972714] PCI: Setting latency timer of device 0000:00:1d.0 to 64
[    1.972714] uhci_hcd 0000:00:1d.0: UHCI Host Controller
[    1.972714] uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
[    1.972714] uhci_hcd 0000:00:1d.0: irq 23, io base 0x00003000
[    1.972714] usb usb1: configuration #1 chosen from 1 choice
[    1.972714] hub 1-0:1.0: USB hub found
[    1.972714] hub 1-0:1.0: 2 ports detected
[    2.073496] usb usb1: New USB device found, idVendor=1d6b, idProduct=0001
[    2.073604] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.073729] usb usb1: Product: UHCI Host Controller
[    2.073818] usb usb1: Manufacturer: Linux 2.6.26-1-xen-amd64 uhci_hcd
[    2.073909] usb usb1: SerialNumber: 0000:00:1d.0
[    2.074101] ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 19
[    2.074284] PCI: Setting latency timer of device 0000:00:1d.1 to 64
[    2.074288] uhci_hcd 0000:00:1d.1: UHCI Host Controller
[    2.074413] uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 2
[    2.074551] uhci_hcd 0000:00:1d.1: irq 19, io base 0x00003020
[    2.081305] usb usb2: configuration #1 chosen from 1 choice
[    2.081416] hub 2-0:1.0: USB hub found
[    2.081510] hub 2-0:1.0: 2 ports detected
[    2.186026] usb usb2: New USB device found, idVendor=1d6b, idProduct=0001
[    2.186132] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.186255] usb usb2: Product: UHCI Host Controller
[    2.186343] usb usb2: Manufacturer: Linux 2.6.26-1-xen-amd64 uhci_hcd
[    2.186433] usb usb2: SerialNumber: 0000:00:1d.1
[    2.187777] ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 18
[    2.187955] PCI: Setting latency timer of device 0000:00:1d.2 to 64
[    2.187959] uhci_hcd 0000:00:1d.2: UHCI Host Controller
[    2.188080] uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 3
[    2.188216] uhci_hcd 0000:00:1d.2: irq 18, io base 0x00003040
[    2.188376] usb usb3: configuration #1 chosen from 1 choice
[    2.188485] hub 3-0:1.0: USB hub found
[    2.188579] hub 3-0:1.0: 2 ports detected
[    2.291019] usb usb3: New USB device found, idVendor=1d6b, idProduct=0001
[    2.291125] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.291249] usb usb3: Product: UHCI Host Controller
[    2.291336] usb usb3: Manufacturer: Linux 2.6.26-1-xen-amd64 uhci_hcd
[    2.291426] usb usb3: SerialNumber: 0000:00:1d.2
[    2.292772] ACPI: PCI Interrupt 0000:00:1d.3[D] -> GSI 16 (level, low) -> IRQ 16
[    2.292949] PCI: Setting latency timer of device 0000:00:1d.3 to 64
[    2.292953] uhci_hcd 0000:00:1d.3: UHCI Host Controller
[    2.293074] uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 4
[    2.293211] uhci_hcd 0000:00:1d.3: irq 16, io base 0x00003060
[    2.293269] usb usb4: configuration #1 chosen from 1 choice
[    2.293269] hub 4-0:1.0: USB hub found
[    2.293269] hub 4-0:1.0: 2 ports detected
[    2.394870] usb usb4: New USB device found, idVendor=1d6b, idProduct=0001
[    2.394977] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.395100] usb usb4: Product: UHCI Host Controller
[    2.395188] usb usb4: Manufacturer: Linux 2.6.26-1-xen-amd64 uhci_hcd
[    2.395278] usb usb4: SerialNumber: 0000:00:1d.3
[    2.397313] ACPI: PCI Interrupt 0000:00:1d.7[A] -> GSI 23 (level, low) -> IRQ 23
[    2.397505] PCI: Setting latency timer of device 0000:00:1d.7 to 64
[    2.397510] ehci_hcd 0000:00:1d.7: EHCI Host Controller
[    2.397636] ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 5
[    2.401659] ehci_hcd 0000:00:1d.7: debug port 1
[    2.401756] PCI: cache line size of 32 is not supported by device 0000:00:1d.7
[    2.401760] ehci_hcd 0000:00:1d.7: irq 23, io mem 0xe0000000
[    2.416650] ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
[    2.416837] usb usb5: configuration #1 chosen from 1 choice
[    2.416969] hub 5-0:1.0: USB hub found
[    2.417067] hub 5-0:1.0: 8 ports detected
[    2.520759] usb usb5: New USB device found, idVendor=1d6b, idProduct=0002
[    2.520870] usb usb5: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.520994] usb usb5: Product: EHCI Host Controller
[    2.521084] usb usb5: Manufacturer: Linux 2.6.26-1-xen-amd64 ehci_hcd
[    2.521177] usb usb5: SerialNumber: 0000:00:1d.7
[    4.084772] ata1: SATA link down (SStatus 0 SControl 0)
[    6.196947] ata2: SATA link down (SStatus 0 SControl 0)
[    8.340912] ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
[    8.341049] ata3.15: Port Multiplier 1.1, 0x1095:0x3726 r23, 6 ports, feat 0x1/0x9
[    8.356999] ata3.00: hard resetting link
[    8.693037] ata3.00: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
[    8.693149] ata3.01: hard resetting link
[    9.029033] ata3.01: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    9.029145] ata3.02: hard resetting link
[    9.364951] ata3.02: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    9.365064] ata3.03: hard resetting link
[    9.700966] ata3.03: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    9.701079] ata3.04: hard resetting link
[   10.036928] ata3.04: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[   10.037040] ata3.05: hard resetting link
[   10.372938] ata3.05: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
[   10.380748] ata3.00: FORCE: horkage modified (noncq)
[   10.380910] ata3.00: ATA-7: SAMSUNG HD103UJ, 1AA01112, max UDMA7
[   10.381021] ata3.00: 1953525168 sectors, multi 16: LBA48 NCQ (not used)
[   10.387354] ata3.00: configured for UDMA/100
[   10.393983] ata3.01: FORCE: horkage modified (noncq)
[   10.394145] ata3.01: ATA-7: SAMSUNG HD103UJ, 1AA01112, max UDMA7
[   10.394248] ata3.01: 1953525168 sectors, multi 0: LBA48 NCQ (not used)
[   10.400756] ata3.01: configured for UDMA/100
[   10.407119] ata3.02: FORCE: horkage modified (noncq)
[   10.407279] ata3.02: ATA-7: SAMSUNG HD103UJ, 1AA01112, max UDMA7
[   10.407391] ata3.02: 1953525168 sectors, multi 0: LBA48 NCQ (not used)
[   10.413894] ata3.02: configured for UDMA/100
[   10.420249] ata3.03: FORCE: horkage modified (noncq)
[   10.420410] ata3.03: ATA-7: SAMSUNG HD103UJ, 1AA01112, max UDMA7
[   10.420521] ata3.03: 1953525168 sectors, multi 0: LBA48 NCQ (not used)
[   10.427013] ata3.03: configured for UDMA/100
[   10.433387] ata3.04: FORCE: horkage modified (noncq)
[   10.433547] ata3.04: ATA-7: SAMSUNG HD103UJ, 1AA01113, max UDMA7
[   10.433650] ata3.04: 1953525168 sectors, multi 0: LBA48 NCQ (not used)
[   10.439892] ata3.04: configured for UDMA/100
[   10.440027] ata3: EH complete
[   12.550294] ata4: SATA link down (SStatus 0 SControl 0)
[   12.550489] scsi 3:0:0:0: Direct-Access     ATA      SAMSUNG HD103UJ  1AA0 PQ: 0 ANSI: 5
[   12.550719] scsi 3:1:0:0: Direct-Access     ATA      SAMSUNG HD103UJ  1AA0 PQ: 0 ANSI: 5
[   12.550917] scsi 3:2:0:0: Direct-Access     ATA      SAMSUNG HD103UJ  1AA0 PQ: 0 ANSI: 5
[   12.551115] scsi 3:3:0:0: Direct-Access     ATA      SAMSUNG HD103UJ  1AA0 PQ: 0 ANSI: 5
[   12.551313] scsi 3:4:0:0: Direct-Access     ATA      SAMSUNG HD103UJ  1AA0 PQ: 0 ANSI: 5
[   12.552827] ACPI: PCI Interrupt 0000:12:00.0[A] -> GSI 16 (level, low) -> IRQ 16
[   12.552827] PCI: Setting latency timer of device 0000:12:00.0 to 64
[   12.568654] Driver 'sd' needs updating - please use bus_type methods
[   12.568654] sd 3:0:0:0: [sda] 1953525168 512-byte hardware sectors (1000205 MB)
[   12.568654] sd 3:0:0:0: [sda] Write Protect is off
[   12.568654] sd 3:0:0:0: [sda] Mode Sense: 00 3a 00 00
[   12.568654] sd 3:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   12.568654] sd 3:0:0:0: [sda] 1953525168 512-byte hardware sectors (1000205 MB)
[   12.568654] sd 3:0:0:0: [sda] Write Protect is off
[   12.568654] sd 3:0:0:0: [sda] Mode Sense: 00 3a 00 00
[   12.568654] sd 3:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   12.568654]  sda: sda1 sda2
[   12.591301] sd 3:0:0:0: [sda] Attached SCSI disk
[   12.591438] sd 3:1:0:0: [sdb] 1953525168 512-byte hardware sectors (1000205 MB)
[   12.591558] sd 3:1:0:0: [sdb] Write Protect is off
[   12.591650] sd 3:1:0:0: [sdb] Mode Sense: 00 3a 00 00
[   12.591668] sd 3:1:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   12.591816] sd 3:1:0:0: [sdb] 1953525168 512-byte hardware sectors (1000205 MB)
[   12.591935] sd 3:1:0:0: [sdb] Write Protect is off
[   12.592026] sd 3:1:0:0: [sdb] Mode Sense: 00 3a 00 00
[   12.592044] sd 3:1:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   12.592157]  sdb: sdb1 sdb2
[   12.606434] sd 3:1:0:0: [sdb] Attached SCSI disk
[   12.606441] sd 3:2:0:0: [sdc] 1953525168 512-byte hardware sectors (1000205 MB)
[   12.606561] sd 3:2:0:0: [sdc] Write Protect is off
[   12.606652] sd 3:2:0:0: [sdc] Mode Sense: 00 3a 00 00
[   12.606670] sd 3:2:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   12.606816] sd 3:2:0:0: [sdc] 1953525168 512-byte hardware sectors (1000205 MB)
[   12.606935] sd 3:2:0:0: [sdc] Write Protect is off
[   12.607027] sd 3:2:0:0: [sdc] Mode Sense: 00 3a 00 00
[   12.607045] sd 3:2:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   12.607158]  sdc: sdc1 sdc2
[   12.622303] sd 3:2:0:0: [sdc] Attached SCSI disk
[   12.622303] sd 3:3:0:0: [sdd] 1953525168 512-byte hardware sectors (1000205 MB)
[   12.622303] sd 3:3:0:0: [sdd] Write Protect is off
[   12.622635] sd 3:3:0:0: [sdd] Mode Sense: 00 3a 00 00
[   12.622654] sd 3:3:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   12.622798] sd 3:3:0:0: [sdd] 1953525168 512-byte hardware sectors (1000205 MB)
[   12.622918] sd 3:3:0:0: [sdd] Write Protect is off
[   12.623009] sd 3:3:0:0: [sdd] Mode Sense: 00 3a 00 00
[   12.623027] sd 3:3:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   12.623141]  sdd: sdd1 sdd2
[   12.634020] sd 3:3:0:0: [sdd] Attached SCSI disk
[   12.634146] sd 3:4:0:0: [sde] 1953525168 512-byte hardware sectors (1000205 MB)
[   12.634266] sd 3:4:0:0: [sde] Write Protect is off
[   12.634357] sd 3:4:0:0: [sde] Mode Sense: 00 3a 00 00
[   12.634375] sd 3:4:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   12.634467] sd 3:4:0:0: [sde] 1953525168 512-byte hardware sectors (1000205 MB)
[   12.634592] sd 3:4:0:0: [sde] Write Protect is off
[   12.634692] sd 3:4:0:0: [sde] Mode Sense: 00 3a 00 00
[   12.634711] sd 3:4:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   12.634823]  sde: sde1 sde2
[   12.648639] sd 3:4:0:0: [sde] Attached SCSI disk
[   12.674483] eth0: (PCI Express:2.5GB/s:Width x1) 00:30:48:8f:59:b6
[   12.674812] eth0: Intel(R) PRO/1000 Network Connection
[   12.675076] eth0: MAC: 2, PHY: 2, PBA No: ffffff-0ff
[   12.675240] ACPI: PCI Interrupt 0000:13:00.0[A] -> GSI 17 (level, low) -> IRQ 17
[   12.675433] PCI: Setting latency timer of device 0000:13:00.0 to 64
[   12.801251] eth1: (PCI Express:2.5GB/s:Width x1) 00:30:48:8f:59:b7
[   12.801353] eth1: Intel(R) PRO/1000 Network Connection
[   12.801511] eth1: MAC: 2, PHY: 2, PBA No: ffffff-0ff
[   12.804898] ata_piix 0000:00:1f.2: version 2.12
[   12.804931] ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 19 (level, low) -> IRQ 19
[   12.805119] ata_piix 0000:00:1f.2: MAP [ P0 P2 P1 P3 ]
[   12.971325] PCI: Setting latency timer of device 0000:00:1f.2 to 64
[   12.971899] scsi5 : ata_piix
[   12.972545] scsi6 : ata_piix
[   12.973391] ata5: SATA max UDMA/133 cmd 0x1f0 ctl 0x3f6 bmdma 0x30a0 irq 14
[   12.973484] ata6: SATA max UDMA/133 cmd 0x170 ctl 0x376 bmdma 0x30a8 irq 15
[   13.136414] ata5.00: FORCE: horkage modified (noncq)
[   13.138356] ata5.00: ATA-8: SAMSUNG HM121HI, LZ100-08, max UDMA7
[   13.138460] ata5.00: 234441648 sectors, multi 16: LBA48 NCQ (not used)
[   13.154277] ata5.00: configured for UDMA/133
[   13.316425] ata6.00: FORCE: horkage modified (noncq)
[   13.318362] ata6.00: ATA-8: SAMSUNG HM121HI, LZ100-08, max UDMA7
[   13.318466] ata6.00: 234441648 sectors, multi 16: LBA48 NCQ (not used)
[   13.334269] ata6.00: configured for UDMA/133
[   13.334463] scsi 5:0:0:0: Direct-Access     ATA      SAMSUNG HM121HI  LZ10 PQ: 0 ANSI: 5
[   13.334654] sd 5:0:0:0: [sdf] 234441648 512-byte hardware sectors (120034 MB)
[   13.334760] sd 5:0:0:0: [sdf] Write Protect is off
[   13.334851] sd 5:0:0:0: [sdf] Mode Sense: 00 3a 00 00
[   13.334869] sd 5:0:0:0: [sdf] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   13.335023] sd 5:0:0:0: [sdf] 234441648 512-byte hardware sectors (120034 MB)
[   13.335030] sd 5:0:0:0: [sdf] Write Protect is off
[   13.335030] sd 5:0:0:0: [sdf] Mode Sense: 00 3a 00 00
[   13.335030] sd 5:0:0:0: [sdf] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   13.335030]  sdf: sdf1 sdf2
[   13.931999] sd 5:0:0:0: [sdf] Attached SCSI disk
[   13.932162] scsi 6:0:0:0: Direct-Access     ATA      SAMSUNG HM121HI  LZ10 PQ: 0 ANSI: 5
[   13.932329] sd 6:0:0:0: [sdg] 234441648 512-byte hardware sectors (120034 MB)
[   13.932434] sd 6:0:0:0: [sdg] Write Protect is off
[   13.932525] sd 6:0:0:0: [sdg] Mode Sense: 00 3a 00 00
[   13.932543] sd 6:0:0:0: [sdg] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   13.932690] sd 6:0:0:0: [sdg] 234441648 512-byte hardware sectors (120034 MB)
[   13.932795] sd 6:0:0:0: [sdg] Write Protect is off
[   13.932886] sd 6:0:0:0: [sdg] Mode Sense: 00 3a 00 00
[   13.932903] sd 6:0:0:0: [sdg] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   13.933017]  sdg: sdg1 sdg2
[   14.570553] sd 6:0:0:0: [sdg] Attached SCSI disk
[   14.577082] Uniform Multi-Platform E-IDE driver
[   14.577082] ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
[   14.807015] md: raid1 personality registered for level 1
[   14.811907] xor: automatically using best checksumming function: generic_sse
[   14.828986]    generic_sse:  5708.000 MB/sec
[   14.828988] xor: using function: generic_sse (5708.000 MB/sec)
[   14.830490] async_tx: api initialized (async)
[   14.900184] raid6: int64x1   2224 MB/s
[   14.968199] raid6: int64x2   3011 MB/s
[   15.036212] raid6: int64x4   2640 MB/s
[   15.104225] raid6: int64x8   1718 MB/s
[   15.172246] raid6: sse2x1    3278 MB/s
[   15.240263] raid6: sse2x2    3458 MB/s
[   15.308276] raid6: sse2x4    7026 MB/s
[   15.308276] raid6: using algorithm sse2x4 (7026 MB/s)
[   15.308344] md: raid6 personality registered for level 6
[   15.308435] md: raid5 personality registered for level 5
[   15.308527] md: raid4 personality registered for level 4
[   15.323279] md: md0 stopped.
[   15.335116] md: bind<sdg1>
[   15.336052] md: bind<sdf1>
[   15.343167] raid1: raid set md0 active with 2 out of 2 mirrors
[   15.345281] md0: bitmap initialized from disk: read 4/4 pages, set 0 bits
[   15.345373] created bitmap (61 pages) for device md0
[   15.398448] md: md1 stopped.
[   15.430427] md: bind<sdg2>
[   15.430745] md: bind<sdf2>
[   15.437979] raid1: raid set md1 active with 2 out of 2 mirrors
[   15.445315] md1: bitmap initialized from disk: read 14/14 pages, set 82 bits
[   15.445421] created bitmap (223 pages) for device md1
[   15.514327] md: md2 stopped.
[   15.516073] md: md4 stopped.
[   15.553178] md: md3 stopped.
[   15.629129] device-mapper: uevent: version 1.0.3
[   15.629129] device-mapper: ioctl: 4.13.0-ioctl (2007-10-18) initialised: dm-devel@redhat.com
[   15.845439] kjournald starting.  Commit interval 5 seconds
[   15.845554] EXT3-fs: mounted filesystem with ordered data mode.
[   17.695612] udevd version 125 started
[   18.386357] EDAC MC: Ver: 2.1.0 Oct  9 2008
[   18.387685] EDAC MC0: Giving out device to 'i3000_edac' 'i3000': DEV 0000:00:00.0
[   18.387812] EDAC PCI0: Giving out device to module 'i3000_edac' controller 'EDAC PCI controller': DEV '0000:00:00.0' (POLLED)
[   18.442301] input: Power Button (FF) as /class/input/input2
[   18.474192] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[   18.488487] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[   18.510587] ACPI: Power Button (FF) [PWRF]
[   18.510759] input: Power Button (CM) as /class/input/input3
[   18.574941] ACPI: Power Button (CM) [PWRB]
[   18.785352] intel_rng: FWH not detected
[   18.817877] ACPI: PCI Interrupt 0000:00:1f.3[B] -> GSI 19 (level, low) -> IRQ 19
[   18.832969] input: PC Speaker as /class/input/input4
[   18.853427] iTCO_wdt: Intel TCO WatchDog Timer Driver v1.03 (30-Apr-2008)
[   19.337047] input: ImExPS/2 Generic Explorer Mouse as /class/input/input5
[   19.363849] iTCO_wdt: Found a ICH7 or ICH7R TCO device (Version=2, TCOBASE=0x1060)
[   19.363849] iTCO_wdt: initialized. heartbeat=30 sec (nowayout=0)
[   21.122217] EXT3 FS on dm-0, internal journal
[   22.430017] loop: module loaded
[   22.505335] md: md2 stopped.
[   22.575811] md: md4 stopped.
[   22.739161] md: bind<sdb2>
[   22.739395] md: bind<sdc2>
[   22.739622] md: bind<sdd2>
[   22.741955] md: bind<sde2>
[   22.742210] md: bind<sda2>
[   22.833279] raid5: device sda2 operational as raid disk 0
[   22.833374] raid5: device sde2 operational as raid disk 4
[   22.833466] raid5: device sdd2 operational as raid disk 3
[   22.833557] raid5: device sdc2 operational as raid disk 2
[   22.833648] raid5: device sdb2 operational as raid disk 1
[   22.833764] raid5: allocated 5324kB for md11
[   22.833764] raid5: raid level 5 set md11 active with 5 out of 5 devices, algorithm 2
[   22.833764] RAID5 conf printout:
[   22.833764]  --- rd:5 wd:5
[   22.833764]  disk 0, o:1, dev:sda2
[   22.833764]  disk 1, o:1, dev:sdb2
[   22.833764]  disk 2, o:1, dev:sdc2
[   22.833764]  disk 3, o:1, dev:sdd2
[   22.833764]  disk 4, o:1, dev:sde2
[   22.855137] md: bind<sdb1>
[   22.855384] md: bind<sdc1>
[   22.855614] md: bind<sdd1>
[   22.855841] md: bind<sde1>
[   22.856062] md: bind<sda1>
[   22.888052] raid5: device sda1 operational as raid disk 0
[   22.888144] raid5: device sde1 operational as raid disk 4
[   22.888233] raid5: device sdd1 operational as raid disk 3
[   22.888322] raid5: device sdc1 operational as raid disk 2
[   22.888410] raid5: device sdb1 operational as raid disk 1
[   22.888836] raid5: allocated 5324kB for md10
[   22.888924] raid5: raid level 6 set md10 active with 5 out of 5 devices, algorithm 2
[   22.889031] RAID5 conf printout:
[   22.889116]  --- rd:5 wd:5
[   22.889200]  disk 0, o:1, dev:sda1
[   22.889285]  disk 1, o:1, dev:sdb1
[   22.889369]  disk 2, o:1, dev:sdc1
[   22.889454]  disk 3, o:1, dev:sdd1
[   22.889539]  disk 4, o:1, dev:sde1
[   24.425636] SGI XFS with ACLs, security attributes, realtime, large block/inode numbers, no debug enabled
[   24.425636] SGI XFS Quota Management subsystem
[   24.555015] Adding 4972536k swap on /dev/mapper/cleopatra-swap_1.  Priority:-1 extents:1 across:4972536k
[   26.036483] NET: Registered protocol family 10
[   26.036483] lo: Disabled Privacy Extensions
[   26.210010] no ownder
[   26.210113] map irq failed
[   26.211788] ADDRCONF(NETDEV_UP): eth0: link is not ready
[   28.062713] RPC: Registered udp transport module.
[   28.062825] RPC: Registered tcp transport module.
[   28.413655] Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
[   29.335150] eth0: Link is Up 1000 Mbps Full Duplex, Flow Control: None
[   29.335622] ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
[   34.303864] NFSD: Using /var/lib/nfs/v4recovery as the NFSv4 state recovery directory
[   34.333004] NFSD: starting 90-second grace period
[   37.763115] Bridge firewalling registered
[   37.763986] tmpbridge: Dropping NETIF_F_UFO since no NETIF_F_HW_CSUM feature.
[   38.066787] no ownder
[   38.066881] map irq failed
[   38.069574] ADDRCONF(NETDEV_UP): peth0: link is not ready
[   40.964632] peth0: Link is Up 1000 Mbps Full Duplex, Flow Control: None
[   40.965866] ADDRCONF(NETDEV_CHANGE): peth0: link becomes ready
[   41.161573] device peth0 entered promiscuous mode
[   41.181626] eth0: port 1(peth0) entering learning state
[   41.184954] eth0: topology change detected, propagating
[   41.185052] eth0: port 1(peth0) entering forwarding state
[   41.735776] suspend: event channel 26
[   51.951855] peth0: no IPv6 routers present

--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: attachment; filename="cold_boot_dmesg.txt"

[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Linux version 2.6.26-1-xen-amd64 (Debian 2.6.26-8) (waldi@debian.org) (gcc version 4.1.3 20080623 (prerelease) (Debian 4.1.2-23)) #1 SMP Thu Oct 9 17:11:22 UTC 2008
[    0.000000] Command line: root=/dev/mapper/cleopatra-root ro console=tty0 elevator=deadline
[    0.000000] BIOS-provided physical RAM map:
[    0.000000]  Xen: 0000000000000000 - 0000000080800000 (usable)
[    0.000000] Entering add_active_range(0, 0, 526336) 0 entries of 256 used
[    0.000000] max_pfn_mapped = 526336
[    0.000000] init_memory_mapping
[    0.000000] DMI present.
[    0.000000] Entering add_active_range(0, 0, 526336) 0 entries of 256 used
[    0.000000]   early res: 0 [200000-631917] TEXT DATA BSS
[    0.000000]   early res: 1 [632000-1f53fff] Xen provided
[    0.000000]   early res: 2 [1f54000-1f55fff] INITMAP
[    0.000000]   early res: 3 [1f56000-235efff] PGTABLE
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA             0 ->     4096
[    0.000000]   DMA32        4096 ->  1048576
[    0.000000]   Normal    1048576 ->  1048576
[    0.000000] Movable zone start PFN for each node
[    0.000000] early_node_map[1] active PFN ranges
[    0.000000]     0:        0 ->   526336
[    0.000000] On node 0 totalpages: 526336
[    0.000000]   DMA zone: 56 pages used for memmap
[    0.000000]   DMA zone: 0 pages reserved
[    0.000000]   DMA zone: 4040 pages, LIFO batch:0
[    0.000000]   DMA32 zone: 7140 pages used for memmap
[    0.000000]   DMA32 zone: 515100 pages, LIFO batch:31
[    0.000000]   Normal zone: 0 pages used for memmap
[    0.000000]   Movable zone: 0 pages used for memmap
[    0.000000] ACPI: RSDP 000F5F00, 0014 (r0 PTLTD )
[    0.000000] ACPI: RSDT DFEE3831, 003C (r1 PTLTD    RSDT    6040000  LTP        0)
[    0.000000] ACPI: FACP DFEE9E70, 0074 (r1 INTEL            6040000 PTL         3)
[    0.000000] ACPI: DSDT DFEE4C59, 5217 (r1  INTEL GLENWOOD  6040000 MSFT  100000E)
[    0.000000] ACPI: FACS DFEEAFC0, 0040
[    0.000000] ACPI: MCFG DFEE9EE4, 003C (r1 PTLTD    MCFG    6040000  LTP        0)
[    0.000000] ACPI: HPET DFEE9F20, 0038 (r1 PTLTD  HPETTBL   6040000  LTP        1)
[    0.000000] ACPI: APIC DFEE9F58, 0080 (r1 PTLTD  	 APIC    6040000  LTP        0)
[    0.000000] ACPI: BOOT DFEE9FD8, 0028 (r1 PTLTD  $SBFTBL$  6040000  LTP        1)
[    0.000000] ACPI: SSDT DFEE386D, 13EC (r1  PmRef    CpuPm     3000 INTL 20050228)
[    0.000000] ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
[    0.000000] ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 2, version 0, address 0xfec00000, GSI 0-23
[    0.000000] ACPI: IOAPIC (id[0x03] address[0xfecc0000] gsi_base[24])
[    0.000000] IOAPIC[1]: apic_id 3, version 0, address 0xfecc0000, GSI 24-47
[    0.000000] ACPI: IOAPIC (id[0x04] address[0xfecc0400] gsi_base[48])
[    0.000000] IOAPIC[2]: apic_id 4, version 0, address 0xfecc0400, GSI 48-71
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 high edge)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ2 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Setting APIC routing to xen
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] Allocating PCI resources starting at e1000000 (gap: e0000000:10000000)
[    0.000000] PERCPU: Allocating 22192 bytes of per cpu data
[    0.000000] NR_CPUS: 32, nr_cpu_ids: 2
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 519140
[    0.000000] Kernel command line: root=/dev/mapper/cleopatra-root ro console=tty0 elevator=deadline
[    0.000000] Initializing CPU#0
[    0.000000] PID hash table entries: 4096 (order: 12, 32768 bytes)
[    0.000000] Xen reported: 2394.012 MHz processor.
[    0.004000] Console: colour VGA+ 80x25
[    0.004000] console [tty0] enabled
[    0.004000] console [xvc-1] enabled
[    0.004000] Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
[    0.004000] Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes)
[    0.004000] Software IO TLB enabled: 
[    0.004000]  Aperture:     64 megabytes
[    0.004000]  Kernel range: ffff88000438f000 - ffff88000838f000
[    0.004000]  Address size: 27 bits
[    0.004000] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    0.004000] Memory: 1964436k/2105344k available (2277k kernel code, 132504k reserved, 1021k data, 216k init)
[    0.004000] CPA: page pool initialized 1 of 1 pages preallocated
[    0.788052] Calibrating delay using timer specific routine.. 4796.97 BogoMIPS (lpj=9593953)
[    0.788261] Security Framework initialized
[    0.788352] SELinux:  Disabled at boot.
[    0.788439] Capability LSM initialized
[    0.788538] Mount-cache hash table entries: 256
[    0.788756] Initializing cgroup subsys ns
[    0.788844] Initializing cgroup subsys cpuacct
[    0.788931] Initializing cgroup subsys devices
[    0.789042] CPU: L1 I cache: 32K, L1 D cache: 32K
[    0.789192] CPU: L2 cache: 4096K
[    0.789279] CPU: Physical Processor ID: 0
[    0.789365] CPU: Processor Core ID: 0
[    0.789460] ACPI: Core revision 20080321
[    0.797504] Brought up 2 CPUs
[    0.797504] Initializing CPU#1
[    0.797504] CPU: L1 I cache: 32K, L1 D cache: 32K
[    0.797504] CPU: L2 cache: 4096K
[    0.797504] CPU: Physical Processor ID: 0
[    0.797504] CPU: Processor Core ID: 1
[    0.798035] CPU0 attaching sched-domain:
[    0.798038]  domain 0: span 0-1
[    0.798040]   groups: 0 1
[    0.798043] CPU1 attaching sched-domain:
[    0.798045]  domain 0: span 0-1
[    0.798046]   groups: 1 0
[    0.800145] net_namespace: 1224 bytes
[    0.800383] NET: Registered protocol family 16
[    0.800743] ACPI: bus type pci registered
[    0.800926] PCI: MCFG configuration 0: base f0000000 segment 0 buses 0 - 19
[    0.801018] PCI: MCFG area at f0000000 reserved in E820
[    0.802456] PCI: Using MMCONFIG at f0000000 - f13fffff
[    0.802545] PCI: Using configuration type 1 for base access
[    0.805481] ACPI: EC: Look up EC in DSDT
[    0.807438] ACPI: Interpreter enabled
[    0.807528] ACPI: (supports S0 S1 S5)
[    0.807819] ACPI: Using IOAPIC for interrupt routing
[    0.813653] ACPI: PCI Root Bridge [PCI0] (0000:00)
[    0.815356] pci 0000:00:1f.0: quirk: region 1000-107f claimed by ICH6 ACPI/GPIO/TCO
[    0.815466] pci 0000:00:1f.0: quirk: region 1180-11bf claimed by ICH6 GPIO
[    0.815812] pci 0000:01:00.0: PXH quirk detected; SHPC device MSI disabled
[    0.816079] pci 0000:01:00.2: PXH quirk detected; SHPC device MSI disabled
[    0.817588] PCI: Transparent bridge - 0000:00:1e.0
[    0.817732] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[    0.817948] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.DEV1.PXHA._PRT]
[    0.818105] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.DEV1.PXHB._PRT]
[    0.818273] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.EXP1._PRT]
[    0.818370] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.EXP5._PRT]
[    0.818431] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.EXP6._PRT]
[    0.818491] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIB._PRT]
[    0.822621] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 10 11 14 15) *7
[    0.823336] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 10 *11 14 15)
[    0.823946] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 10 11 14 15) *5
[    0.824620] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 10 *11 14 15)
[    0.825234] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 10 11 14 15) *0, disabled.
[    0.825991] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 10 11 14 15) *0, disabled.
[    0.826620] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 10 11 14 15) *0, disabled.
[    0.827408] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 *10 11 14 15)
[    0.829049] Linux Plug and Play Support v0.97 (c) Adam Belay
[    0.829645] pnp: PnP ACPI init
[    0.829737] ACPI: bus type pnp registered
[    0.829836] pnp 00:00: parse allocated resources
[    0.830619] pnp 00:00:   add io  0xcf8-0xcff flags 0x1
[    0.830619] pnp 00:00: Plug and Play ACPI device, IDs PNP0a03 (active)
[    0.830619] pnp 00:01: parse allocated resources
[    0.830619] pnp 00:01:   add io  0x10-0x1f flags 0x1
[    0.830619] pnp 00:01:   add io  0x24-0x25 flags 0x1
[    0.830619] pnp 00:01:   add io  0x28-0x29 flags 0x1
[    0.830619] pnp 00:01:   add io  0x2c-0x2d flags 0x1
[    0.830619] pnp 00:01:   add io  0x30-0x31 flags 0x1
[    0.830619] pnp 00:01:   add io  0x34-0x35 flags 0x1
[    0.830619] pnp 00:01:   add io  0x38-0x39 flags 0x1
[    0.830619] pnp 00:01:   add io  0x3c-0x3d flags 0x1
[    0.830619] pnp 00:01:   add io  0x72-0x77 flags 0x1
[    0.830619] pnp 00:01:   add io  0x80-0x80 flags 0x1
[    0.830619] pnp 00:01:   add io  0x90-0x9f flags 0x1
[    0.830619] pnp 00:01:   add io  0xa4-0xa5 flags 0x1
[    0.830619] pnp 00:01:   add io  0xa8-0xa9 flags 0x1
[    0.830619] pnp 00:01:   add io  0xac-0xad flags 0x1
[    0.830619] pnp 00:01:   add io  0xb0-0xb5 flags 0x1
[    0.830619] pnp 00:01:   add io  0xb8-0xb9 flags 0x1
[    0.830619] pnp 00:01:   add io  0xbc-0xbd flags 0x1
[    0.830619] pnp 00:01:   add io  0x295-0x296 flags 0x1
[    0.830619] pnp 00:01:   add io  0x800-0x83f flags 0x1
[    0.830619] pnp 00:01:   add io  0x900-0x90f flags 0x1
[    0.830619] pnp 00:01:   add io  0x1000-0x107f flags 0x1
[    0.830619] pnp 00:01:   add io  0x1180-0x11bf flags 0x1
[    0.830619] pnp 00:01:   add io  0x2e-0x2f flags 0x1
[    0.830619] pnp 00:01:   add io  0x4d0-0x4d1 flags 0x1
[    0.830619] pnp 00:01:   add io  0xfe00-0xfe00 flags 0x1
[    0.830619] pnp 00:01:   add mem 0xfed14000-0xfed17fff flags 0x1
[    0.830619] pnp 00:01:   add mem 0xfed13000-0xfed13fff flags 0x1
[    0.830619] pnp 00:01:   add mem 0xfed18000-0xfed1bfff flags 0x1
[    0.830619] pnp 00:01:   add mem 0xf0000000-0xf3ffffff flags 0x1
[    0.830619] pnp 00:01:   add mem 0xfed20000-0xfed8ffff flags 0x1
[    0.830619] pnp 00:01:   add mem 0xfef00000-0xfeffffff flags 0x1
[    0.830619] pnp 00:01: PNP0c02: calling quirk_system_pci_resources+0x0/0x15c
[    0.830619] pnp 00:01: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.830619] pnp 00:02: parse allocated resources
[    0.830619] pnp 00:02:   add io  0x0-0xf flags 0x1
[    0.830619] pnp 00:02:   add io  0x81-0x8f flags 0x1
[    0.830619] pnp 00:02:   add io  0xc0-0xdf flags 0x1
[    0.830619] pnp 00:02:   add dma 4 flags 0x2
[    0.830619] pnp 00:02: Plug and Play ACPI device, IDs PNP0200 (active)
[    0.830619] pnp 00:03: parse allocated resources
[    0.830619] pnp 00:03:   add io  0xf0-0xfe flags 0x1
[    0.830619] pnp 00:03:   add irq 13 flags 0x1
[    0.830619] pnp 00:03: Plug and Play ACPI device, IDs PNP0c04 (active)
[    0.830619] pnp 00:04: parse allocated resources
[    0.830619] pnp 00:04:   add io  0x70-0x71 flags 0x1
[    0.830619] pnp 00:04: Plug and Play ACPI device, IDs PNP0b00 (active)
[    0.830619] pnp 00:05: parse allocated resources
[    0.830619] pnp 00:05:   add io  0x61-0x61 flags 0x1
[    0.830619] pnp 00:05: Plug and Play ACPI device, IDs PNP0800 (active)
[    0.830619] pnp 00:06: parse allocated resources
[    0.830619] pnp 00:06:   add irq 8 flags 0x1
[    0.830619] pnp 00:06:   add mem 0xfed00000-0xfed003ff flags 0x0
[    0.830619] pnp 00:06: Plug and Play ACPI device, IDs PNP0103 (active)
[    0.830619] pnp 00:07: parse allocated resources
[    0.830619] pnp 00:07:   add mem 0xff800000-0xffffffff flags 0x0
[    0.830619] pnp 00:07: Plug and Play ACPI device, IDs INT0800 (active)
[    0.830619] pnp 00:08: parse allocated resources
[    0.830619] pnp 00:08:   add io  0x60-0x60 flags 0x1
[    0.830619] pnp 00:08:   add io  0x64-0x64 flags 0x1
[    0.830619] pnp 00:08:   add irq 1 flags 0x1
[    0.830619] pnp 00:08: Plug and Play ACPI device, IDs PNP0303 PNP030b (active)
[    0.830619] pnp 00:09: parse allocated resources
[    0.830619] pnp 00:09:   add irq 12 flags 0x1
[    0.830619] pnp 00:09: Plug and Play ACPI device, IDs PNP0f13 PNP0f13 (active)
[    0.830759] pnp 00:0a: parse allocated resources
[    0.830943] pnp 00:0a:   add io  0x3f8-0x3ff flags 0x1
[    0.830947] pnp 00:0a:   add irq 4 flags 0x1
[    0.830949] pnp 00:0a: parse resource options
[    0.830951] pnp 00:0a: new independent option
[    0.830959] pnp 00:0a: new dependent option (priority 0x0)
[    0.830961] pnp 00:0a:   io  min 0x3f8 max 0x3f8 align 1 size 8 flags 0x1
[    0.830965] pnp 00:0a:   irq bitmask 00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000010 flags 0x1
[    0.830968] pnp 00:0a: new dependent option (priority 0x1)
[    0.830970] pnp 00:0a:   io  min 0x2f8 max 0x2f8 align 1 size 8 flags 0x1
[    0.830973] pnp 00:0a:   irq bitmask 00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000008 flags 0x1
[    0.830975] pnp 00:0a: new dependent option (priority 0x1)
[    0.830979] pnp 00:0a:   io  min 0x3e8 max 0x3e8 align 1 size 8 flags 0x1
[    0.830982] pnp 00:0a:   irq bitmask 00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000010 flags 0x1
[    0.830984] pnp 00:0a: new dependent option (priority 0x1)
[    0.830986] pnp 00:0a:   io  min 0x2e8 max 0x2e8 align 1 size 8 flags 0x1
[    0.830990] pnp 00:0a:   irq bitmask 00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000008 flags 0x1
[    0.830992] pnp 00:0a: new dependent option (priority 0x2)
[    0.830994] pnp 00:0a:   io  min 0x3f8 max 0x3f8 align 1 size 8 flags 0x1
[    0.830997] pnp 00:0a:   irq bitmask 00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000008 flags 0x1
[    0.831000] pnp 00:0a: new dependent option (priority 0x2)
[    0.831002] pnp 00:0a:   io  min 0x2f8 max 0x2f8 align 1 size 8 flags 0x1
[    0.831005] pnp 00:0a:   irq bitmask 00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000010 flags 0x1
[    0.831008] pnp 00:0a: new dependent option (priority 0x2)
[    0.831010] pnp 00:0a:   io  min 0x3e8 max 0x3e8 align 1 size 8 flags 0x1
[    0.831013] pnp 00:0a:   irq bitmask 00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000008 flags 0x1
[    0.831016] pnp 00:0a: new dependent option (priority 0x2)
[    0.831018] pnp 00:0a:   io  min 0x2e8 max 0x2e8 align 1 size 8 flags 0x1
[    0.831021] pnp 00:0a:   irq bitmask 00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000010 flags 0x1
[    0.831023] pnp 00:0a: end dependent options
[    0.834618] pnp 00:0a: Plug and Play ACPI device, IDs PNP0501 (active)
[    0.834618] pnp 00:0b: parse allocated resources
[    0.834618] pnp 00:0b:   add io  0x2f8-0x2ff flags 0x1
[    0.834618] pnp 00:0b:   add irq 3 flags 0x1
[    0.834618] pnp 00:0b: parse resource options
[    0.834618] pnp 00:0b: new independent option
[    0.834618] pnp 00:0b: new dependent option (priority 0x1)
[    0.834618] pnp 00:0b:   io  min 0x3f8 max 0x3f8 align 1 size 8 flags 0x1
[    0.834618] pnp 00:0b:   irq bitmask 00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000010 flags 0x1
[    0.834618] pnp 00:0b: new dependent option (priority 0x0)
[    0.834618] pnp 00:0b:   io  min 0x2f8 max 0x2f8 align 1 size 8 flags 0x1
[    0.834618] pnp 00:0b:   irq bitmask 00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000008 flags 0x1
[    0.834618] pnp 00:0b: new dependent option (priority 0x1)
[    0.834618] pnp 00:0b:   io  min 0x3e8 max 0x3e8 align 1 size 8 flags 0x1
[    0.834618] pnp 00:0b:   irq bitmask 00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000010 flags 0x1
[    0.834618] pnp 00:0b: new dependent option (priority 0x1)
[    0.834618] pnp 00:0b:   io  min 0x2e8 max 0x2e8 align 1 size 8 flags 0x1
[    0.834618] pnp 00:0b:   irq bitmask 00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000008 flags 0x1
[    0.834618] pnp 00:0b: new dependent option (priority 0x2)
[    0.834618] pnp 00:0b:   io  min 0x3f8 max 0x3f8 align 1 size 8 flags 0x1
[    0.834618] pnp 00:0b:   irq bitmask 00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000008 flags 0x1
[    0.834618] pnp 00:0b: new dependent option (priority 0x2)
[    0.834618] pnp 00:0b:   io  min 0x2f8 max 0x2f8 align 1 size 8 flags 0x1
[    0.834618] pnp 00:0b:   irq bitmask 00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000010 flags 0x1
[    0.834618] pnp 00:0b: new dependent option (priority 0x2)
[    0.834618] pnp 00:0b:   io  min 0x3e8 max 0x3e8 align 1 size 8 flags 0x1
[    0.834618] pnp 00:0b:   irq bitmask 00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000008 flags 0x1
[    0.834618] pnp 00:0b: new dependent option (priority 0x2)
[    0.834618] pnp 00:0b:   io  min 0x2e8 max 0x2e8 align 1 size 8 flags 0x1
[    0.834618] pnp 00:0b:   irq bitmask 00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000010 flags 0x1
[    0.834618] pnp 00:0b: end dependent options
[    0.834618] pnp 00:0b: Plug and Play ACPI device, IDs PNP0501 (active)
[    0.834618] pnp 00:0c: parse allocated resources
[    0.834618] pnp 00:0c:   add io  0x3f0-0x3f5 flags 0x1
[    0.834618] pnp 00:0c:   add io  0x3f7-0x3f7 flags 0x1
[    0.834618] pnp 00:0c:   add irq 6 flags 0x1
[    0.834618] pnp 00:0c:   add dma 2 flags 0x0
[    0.834618] pnp 00:0c: parse resource options
[    0.834618] pnp 00:0c: new independent option
[    0.834618] pnp 00:0c: new dependent option (priority 0x0)
[    0.834618] pnp 00:0c:   io  min 0x3f0 max 0x3f0 align 1 size 6 flags 0x1
[    0.834618] pnp 00:0c:   io  min 0x3f7 max 0x3f7 align 1 size 1 flags 0x1
[    0.834618] pnp 00:0c:   irq bitmask 00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000040 flags 0x1
[    0.834618] pnp 00:0c:   dma bitmask 0x4 flags 0x0
[    0.834618] pnp 00:0c: new dependent option (priority 0x0)
[    0.834618] pnp 00:0c:   io  min 0x370 max 0x370 align 1 size 6 flags 0x1
[    0.834618] pnp 00:0c:   io  min 0x377 max 0x377 align 1 size 1 flags 0x1
[    0.834618] pnp 00:0c:   irq bitmask 00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000040 flags 0x1
[    0.834618] pnp 00:0c:   dma bitmask 0x4 flags 0x0
[    0.834618] pnp 00:0c: end dependent options
[    0.834618] pnp 00:0c: Plug and Play ACPI device, IDs PNP0700 (active)
[    0.834618] pnp: PnP ACPI: found 13 devices
[    0.834618] ACPI: ACPI bus type pnp unregistered
[    0.834618] xen_mem: Initialising balloon driver.
[    0.834618] usbcore: registered new interface driver usbfs
[    0.834618] usbcore: registered new interface driver hub
[    0.834618] usbcore: registered new device driver usb
[    0.834618] PCI: Using ACPI for IRQ routing
[    0.834618] PCI: Cannot allocate resource region 7 of bridge 0000:00:1c.0
[    0.844634] PCI: Cannot allocate resource region 8 of bridge 0000:00:1c.0
[    0.844728] PCI: Cannot allocate resource region 9 of bridge 0000:00:1c.0
[    0.864776] ACPI: RTC can wake from S4
[    0.884689] pnp: the driver 'system' has been registered
[    0.884700] system 00:01: ioport range 0x295-0x296 has been reserved
[    0.884805] system 00:01: ioport range 0x800-0x83f has been reserved
[    0.884909] system 00:01: ioport range 0x900-0x90f has been reserved
[    0.885016] system 00:01: ioport range 0x1000-0x107f has been reserved
[    0.885107] system 00:01: ioport range 0x1180-0x11bf has been reserved
[    0.885198] system 00:01: ioport range 0x4d0-0x4d1 has been reserved
[    0.885289] system 00:01: ioport range 0xfe00-0xfe00 has been reserved
[    0.885381] system 00:01: iomem range 0xfed14000-0xfed17fff has been reserved
[    0.885473] system 00:01: iomem range 0xfed13000-0xfed13fff has been reserved
[    0.885565] system 00:01: iomem range 0xfed18000-0xfed1bfff has been reserved
[    0.885658] system 00:01: iomem range 0xf0000000-0xf3ffffff could not be reserved
[    0.885765] system 00:01: iomem range 0xfed20000-0xfed8ffff has been reserved
[    0.885857] system 00:01: iomem range 0xfef00000-0xfeffffff has been reserved
[    0.885949] system 00:01: driver attached
[    0.886480] PCI: Failed to allocate mem resource #9:100000@e1800000 for 0000:01:00.2
[    0.886480] PCI: Bridge: 0000:01:00.0
[    0.886480]   IO window: 4000-4fff
[    0.886480]   MEM window: 0xe0200000-0xe02fffff
[    0.886480]   PREFETCH window: 0x00000000e1000000-0x00000000e17fffff
[    0.886480] PCI: Bridge: 0000:01:00.2
[    0.886480]   IO window: 5000-5fff
[    0.886480]   MEM window: 0xe0300000-0xe03fffff
[    0.886480]   PREFETCH window: disabled.
[    0.886480] PCI: Bridge: 0000:00:01.0
[    0.886480]   IO window: 4000-5fff
[    0.886480]   MEM window: 0xe0100000-0xe03fffff
[    0.886480]   PREFETCH window: 0x00000000e1000000-0x00000000e17fffff
[    0.886480] PCI: Bridge: 0000:00:1c.0
[    0.886480]   IO window: disabled.
[    0.886480]   MEM window: disabled.
[    0.886480]   PREFETCH window: disabled.
[    0.886480] PCI: Bridge: 0000:00:1c.4
[    0.886480]   IO window: 6000-6fff
[    0.886480]   MEM window: 0xe0400000-0xe04fffff
[    0.886480]   PREFETCH window: disabled.
[    0.886480] PCI: Bridge: 0000:00:1c.5
[    0.886480]   IO window: 7000-7fff
[    0.886574]   MEM window: 0xe0500000-0xe05fffff
[    0.886580]   PREFETCH window: disabled.
[    0.891268] PCI: Bridge: 0000:00:1e.0
[    0.891358]   IO window: 8000-8fff
[    0.891451]   MEM window: 0xe0600000-0xe06fffff
[    0.891545]   PREFETCH window: 0x00000000e8000000-0x00000000efffffff
[    0.891669] ACPI: PCI Interrupt 0000:00:01.0[A] -> GSI 16 (level, low) -> IRQ 16
[    0.891849] PCI: Setting latency timer of device 0000:00:01.0 to 64
[    0.891879] PCI: Setting latency timer of device 0000:01:00.0 to 64
[    0.891909] PCI: Setting latency timer of device 0000:01:00.2 to 64
[    0.891942] ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 17 (level, low) -> IRQ 17
[    0.892124] PCI: Setting latency timer of device 0000:00:1c.0 to 64
[    0.892156] ACPI: PCI Interrupt 0000:00:1c.4[A] -> GSI 17 (level, low) -> IRQ 17
[    0.892336] PCI: Setting latency timer of device 0000:00:1c.4 to 64
[    0.892367] ACPI: PCI Interrupt 0000:00:1c.5[B] -> GSI 16 (level, low) -> IRQ 16
[    0.892548] PCI: Setting latency timer of device 0000:00:1c.5 to 64
[    0.892566] PCI: Setting latency timer of device 0000:00:1e.0 to 64
[    0.892603] NET: Registered protocol family 2
[    0.939494] IP route cache hash table entries: 65536 (order: 7, 524288 bytes)
[    0.939873] TCP established hash table entries: 262144 (order: 10, 4194304 bytes)
[    0.941505] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[    0.942215] TCP: Hash tables configured (established 262144 bind 65536)
[    0.942307] TCP reno registered
[    0.951517] NET: Registered protocol family 1
[    0.951725] checking if image is initramfs... it is
[    0.971406] Freeing initrd memory: 21558k freed
[    0.979853] Simple Boot Flag at 0x38 set to 0x1
[    0.982401] audit: initializing netlink socket (disabled)
[    0.982401] type=2000 audit(1224002540.968:1): initialized
[    0.982401] VFS: Disk quotas dquot_6.5.1
[    0.982401] Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    0.982401] msgmni has been set to 4138
[    0.982401] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 253)
[    0.982401] io scheduler noop registered
[    0.982401] io scheduler anticipatory registered
[    0.982401] io scheduler deadline registered (default)
[    0.982401] io scheduler cfq registered
[    0.982401] pci 0000:14:04.0: Boot video device
[    0.982401] PCI: Setting latency timer of device 0000:00:01.0 to 64
[    0.982401] assign_interrupt_mode Found MSI capability
[    0.982401] no ownder
[    0.982401] map irq failed
[    0.982401] Allocate Port Service[0000:00:01.0:pcie00]
[    0.982401] Allocate Port Service[0000:00:01.0:pcie03]
[    0.982401] PCI: Setting latency timer of device 0000:00:1c.0 to 64
[    0.982401] assign_interrupt_mode Found MSI capability
[    0.982401] no ownder
[    0.982493] map irq failed
[    0.983778] Allocate Port Service[0000:00:1c.0:pcie00]
[    0.984211] Allocate Port Service[0000:00:1c.0:pcie02]
[    0.984613] Allocate Port Service[0000:00:1c.0:pcie03]
[    0.985081] PCI: Setting latency timer of device 0000:00:1c.4 to 64
[    0.985147] assign_interrupt_mode Found MSI capability
[    0.985275] no ownder
[    0.985361] map irq failed
[    0.985447] Allocate Port Service[0000:00:1c.4:pcie00]
[    0.986797] Allocate Port Service[0000:00:1c.4:pcie02]
[    0.987592] Allocate Port Service[0000:00:1c.4:pcie03]
[    0.987592] PCI: Setting latency timer of device 0000:00:1c.5 to 64
[    0.987592] assign_interrupt_mode Found MSI capability
[    0.987592] no ownder
[    0.987592] map irq failed
[    0.987592] Allocate Port Service[0000:00:1c.5:pcie00]
[    0.987592] Allocate Port Service[0000:00:1c.5:pcie02]
[    0.987592] Allocate Port Service[0000:00:1c.5:pcie03]
[    0.991592] Linux agpgart interface v0.103
[    0.991592] Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
[    0.991592] serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[    0.991592] serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
[    0.991592] pnp: the driver 'serial' has been registered
[    0.991592] 00:0a: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[    0.991592] serial 00:0a: driver attached
[    0.991592] 00:0b: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
[    0.991592] serial 00:0b: driver attached
[    0.991593] brd: module loaded
[    0.991593] input: Macintosh mouse button emulation as /class/input/input0
[    0.991761] Xen virtual console successfully installed as xvc0
[    0.992518] Event-channel device installed.
[    0.995593] netfront: Initialising virtual ethernet driver.
[    0.995593] pnp: the driver 'i8042 kbd' has been registered
[    0.995593] i8042 kbd 00:08: driver attached
[    0.995593] pnp: the driver 'i8042 aux' has been registered
[    0.995593] i8042 aux 00:09: driver attached
[    0.995593] PNP: PS/2 Controller [PNP0303:KBC0,PNP0f13:MSE0] at 0x60,0x64 irq 1,12
[    0.997831] serio: i8042 KBD port at 0x60,0x64 irq 1
[    0.997922] serio: i8042 AUX port at 0x60,0x64 irq 12
[    1.016855] mice: PS/2 mouse device common for all mice
[    1.016990] pnp: the driver 'rtc_cmos' has been registered
[    1.017048] rtc_cmos 00:04: rtc core: registered rtc_cmos as rtc0
[    1.017158] rtc0: alarms up to one month, y3k
[    1.017245] rtc_cmos 00:04: driver attached
[    1.017274] No iBFT detected.
[    1.017671] TCP cubic registered
[    1.017757] NET: Registered protocol family 17
[    1.017938] registered taskstats version 1
[    1.018150] rtc_cmos 00:04: setting system clock to 2008-10-14 16:42:21 UTC (1224002541)
[    1.018265] Freeing unused kernel memory: 216k freed
[    1.040665] input: AT Translated Set 2 keyboard as /class/input/input1
[    1.122890] ACPI: ACPI0007:00 is registered as cooling_device0
[    1.123258] ACPI: ACPI0007:01 is registered as cooling_device1
[    1.123606] ACPI: ACPI0007:02 is registered as cooling_device2
[    1.123954] ACPI: ACPI0007:03 is registered as cooling_device3
[    1.124301] ACPI: ACPI0007:04 is registered as cooling_device4
[    1.124651] ACPI: ACPI0007:05 is registered as cooling_device5
[    1.125001] ACPI: ACPI0007:06 is registered as cooling_device6
[    1.125357] ACPI: ACPI0007:07 is registered as cooling_device7
[    1.383912] No dock devices found.
[    1.388931] SCSI subsystem initialized
[    1.402806] libata version 3.00 loaded.
[    1.402856] 3ware 9000 Storage Controller device driver for Linux v2.26.02.010.
[    1.403017] ACPI: PCI Interrupt 0000:02:01.0[A] -> GSI 24 (level, low) -> IRQ 24
[    1.419617] e1000e: Intel(R) PRO/1000 Network Driver - 0.3.3.3-k2
[    1.419716] e1000e: Copyright (c) 1999-2008 Intel Corporation.
[    1.431513] USB Universal Host Controller Interface driver v3.0
[    1.523034] floppy0: Unable to grab DMA2 for the floppy driver
[    1.541613] FDC 0 is a post-1991 82077
[    1.630458] scsi0 : 3ware 9000 Storage Controller
[    1.630641] 3w-9xxx: scsi0: Found a 3ware 9000 Storage Controller at 0xe0200000, IRQ: 24.
[    1.966457] 3w-9xxx: scsi0: Firmware FE9X 2.08.00.009, BIOS BE9X 2.03.01.052, Ports: 12.
[    1.968018] sata_sil24 0000:03:01.0: version 1.1
[    1.968046] ACPI: PCI Interrupt 0000:03:01.0[A] -> GSI 48 (level, low) -> IRQ 48
[    1.968236] sata_sil24 0000:03:01.0: Applying completion IRQ loss on PCI-X errata fix
[    1.968280] scsi1 : sata_sil24
[    1.968280] scsi2 : sata_sil24
[    1.968280] ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 23 (level, low) -> IRQ 23
[    1.968280] PCI: Setting latency timer of device 0000:00:1d.0 to 64
[    1.968280] uhci_hcd 0000:00:1d.0: UHCI Host Controller
[    1.968280] uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
[    1.968280] uhci_hcd 0000:00:1d.0: irq 23, io base 0x00003000
[    1.968280] usb usb1: configuration #1 chosen from 1 choice
[    1.968280] hub 1-0:1.0: USB hub found
[    1.968280] hub 1-0:1.0: 2 ports detected
[    1.968280] scsi3 : sata_sil24
[    1.968280] scsi4 : sata_sil24
[    1.968280] ata1: SATA max UDMA/100 host m128@0xe0308000 port 0xe0300000 irq 48
[    1.968280] ata2: SATA max UDMA/100 host m128@0xe0308000 port 0xe0302000 irq 48
[    1.968280] ata3: SATA max UDMA/100 host m128@0xe0308000 port 0xe0304000 irq 48
[    1.968280] ata4: SATA max UDMA/100 host m128@0xe0308000 port 0xe0306000 irq 48
[    2.071272] usb usb1: New USB device found, idVendor=1d6b, idProduct=0001
[    2.071380] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.071503] usb usb1: Product: UHCI Host Controller
[    2.071590] usb usb1: Manufacturer: Linux 2.6.26-1-xen-amd64 uhci_hcd
[    2.071680] usb usb1: SerialNumber: 0000:00:1d.0
[    2.073094] ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 19
[    2.073271] PCI: Setting latency timer of device 0000:00:1d.1 to 64
[    2.073275] uhci_hcd 0000:00:1d.1: UHCI Host Controller
[    2.073399] uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 2
[    2.073536] uhci_hcd 0000:00:1d.1: irq 19, io base 0x00003020
[    2.079771] usb usb2: configuration #1 chosen from 1 choice
[    2.079881] hub 2-0:1.0: USB hub found
[    2.079975] hub 2-0:1.0: 2 ports detected
[    2.184509] usb usb2: New USB device found, idVendor=1d6b, idProduct=0001
[    2.184615] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.184739] usb usb2: Product: UHCI Host Controller
[    2.184826] usb usb2: Manufacturer: Linux 2.6.26-1-xen-amd64 uhci_hcd
[    2.184916] usb usb2: SerialNumber: 0000:00:1d.1
[    2.186273] ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 18
[    2.186451] PCI: Setting latency timer of device 0000:00:1d.2 to 64
[    2.186455] uhci_hcd 0000:00:1d.2: UHCI Host Controller
[    2.186577] uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 3
[    2.186715] uhci_hcd 0000:00:1d.2: irq 18, io base 0x00003040
[    2.186877] usb usb3: configuration #1 chosen from 1 choice
[    2.186985] hub 3-0:1.0: USB hub found
[    2.186985] hub 3-0:1.0: 2 ports detected
[    2.288723] usb usb3: New USB device found, idVendor=1d6b, idProduct=0001
[    2.288836] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.288943] usb usb3: Product: UHCI Host Controller
[    2.289030] usb usb3: Manufacturer: Linux 2.6.26-1-xen-amd64 uhci_hcd
[    2.289121] usb usb3: SerialNumber: 0000:00:1d.2
[    2.290451] ACPI: PCI Interrupt 0000:00:1d.3[D] -> GSI 16 (level, low) -> IRQ 16
[    2.290627] PCI: Setting latency timer of device 0000:00:1d.3 to 64
[    2.290632] uhci_hcd 0000:00:1d.3: UHCI Host Controller
[    2.290753] uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 4
[    2.290890] uhci_hcd 0000:00:1d.3: irq 16, io base 0x00003060
[    2.290985] usb usb4: configuration #1 chosen from 1 choice
[    2.290985] hub 4-0:1.0: USB hub found
[    2.290985] hub 4-0:1.0: 2 ports detected
[    2.393691] usb usb4: New USB device found, idVendor=1d6b, idProduct=0001
[    2.393797] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.393920] usb usb4: Product: UHCI Host Controller
[    2.394007] usb usb4: Manufacturer: Linux 2.6.26-1-xen-amd64 uhci_hcd
[    2.394098] usb usb4: SerialNumber: 0000:00:1d.3
[    2.395468] ACPI: PCI Interrupt 0000:00:1d.7[A] -> GSI 23 (level, low) -> IRQ 23
[    2.395653] PCI: Setting latency timer of device 0000:00:1d.7 to 64
[    2.395657] ehci_hcd 0000:00:1d.7: EHCI Host Controller
[    2.395781] ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 5
[    2.399808] ehci_hcd 0000:00:1d.7: debug port 1
[    2.399902] PCI: cache line size of 32 is not supported by device 0000:00:1d.7
[    2.399906] ehci_hcd 0000:00:1d.7: irq 23, io mem 0xe0000000
[    2.414732] ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
[    2.414914] usb usb5: configuration #1 chosen from 1 choice
[    2.415042] hub 5-0:1.0: USB hub found
[    2.415138] hub 5-0:1.0: 8 ports detected
[    2.518837] usb usb5: New USB device found, idVendor=1d6b, idProduct=0002
[    2.518944] usb usb5: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.519067] usb usb5: Product: EHCI Host Controller
[    2.519154] usb usb5: Manufacturer: Linux 2.6.26-1-xen-amd64 ehci_hcd
[    2.519245] usb usb5: SerialNumber: 0000:00:1d.7
[    4.087104] ata1: SATA link down (SStatus 0 SControl 0)
[    6.199345] ata2: SATA link down (SStatus 0 SControl 0)
[    8.343532] ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
[    8.343757] ata3.15: Port Multiplier 1.1, 0x1095:0x3726 r23, 6 ports, feat 0x1/0x9
[    8.359613] ata3.00: hard resetting link
[    8.695610] ata3.00: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
[    8.695723] ata3.01: hard resetting link
[    9.031587] ata3.01: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    9.031699] ata3.02: hard resetting link
[    9.367582] ata3.02: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    9.367694] ata3.03: hard resetting link
[    9.703578] ata3.03: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    9.703690] ata3.04: hard resetting link
[   10.039574] ata3.04: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[   10.039687] ata3.05: hard resetting link
[   10.375537] ata3.05: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
[   10.383308] ata3.00: FORCE: horkage modified (noncq)
[   10.383471] ata3.00: ATA-7: SAMSUNG HD103UJ, 1AA01112, max UDMA7
[   10.383574] ata3.00: 1953525168 sectors, multi 16: LBA48 NCQ (not used)
[   10.389920] ata3.00: configured for UDMA/100
[   10.404563] ata3.01: failed to IDENTIFY (I/O error, err_mask=0x11)
[   10.404668] ata3.15: hard resetting link
[   12.532590] ata3.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
[   12.532818] ata3.00: hard resetting link
[   12.868695] ata3.00: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
[   12.868807] ata3.01: hard resetting link
[   13.204711] ata3.01: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[   13.204823] ata3.02: hard resetting link
[   13.540650] ata3.02: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[   13.540763] ata3.03: hard resetting link
[   13.876662] ata3.03: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[   13.876775] ata3.04: hard resetting link
[   14.212691] ata3.04: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[   14.212801] ata3.05: hard resetting link
[   14.548666] ata3.05: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
[   14.561833] ata3.00: configured for UDMA/100
[   14.576783] ata3.01: failed to IDENTIFY (I/O error, err_mask=0x11)
[   14.577849] ata3.15: hard resetting link
[   16.705791] ata3.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
[   16.706018] ata3.00: hard resetting link
[   17.041916] ata3.00: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
[   17.042028] ata3.01: hard resetting link
[   17.377911] ata3.01: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[   17.378024] ata3.02: hard resetting link
[   17.713834] ata3.02: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[   17.713938] ata3.03: hard resetting link
[   18.049813] ata3.03: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[   18.049925] ata3.04: hard resetting link
[   18.385941] ata3.04: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[   18.386054] ata3.05: hard resetting link
[   18.721898] ata3.05: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
[   18.735003] ata3.00: configured for UDMA/100
[   18.749948] ata3.01: failed to IDENTIFY (I/O error, err_mask=0x11)
[   18.750052] ata3.01: failed to recover link after 3 tries, disabling
[   18.750155] ata3: failed to recover PMP, retrying in 5 secs
[   23.753975] ata3.15: hard resetting link
[   25.881927] ata3.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
[   26.201981] ata3.00: hard resetting link
[   26.538070] ata3.00: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
[   26.538178] ata3.02: hard resetting link
[   26.874030] ata3.02: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[   26.874143] ata3.03: hard resetting link
[   27.210041] ata3.03: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[   27.210145] ata3.04: hard resetting link
[   27.545988] ata3.04: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[   27.546100] ata3.05: hard resetting link
[   27.881968] ata3.05: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
[   27.894998] ata3.00: configured for UDMA/100
[   27.901497] ata3.02: FORCE: horkage modified (noncq)
[   27.901658] ata3.02: ATA-7: SAMSUNG HD103UJ, 1AA01112, max UDMA7
[   27.901769] ata3.02: 1953525168 sectors, multi 0: LBA48 NCQ (not used)
[   27.908257] ata3.02: configured for UDMA/100
[   27.914623] ata3.03: FORCE: horkage modified (noncq)
[   27.914784] ata3.03: ATA-7: SAMSUNG HD103UJ, 1AA01112, max UDMA7
[   27.914895] ata3.03: 1953525168 sectors, multi 0: LBA48 NCQ (not used)
[   27.921389] ata3.03: configured for UDMA/100
[   27.927753] ata3.04: FORCE: horkage modified (noncq)
[   27.927913] ata3.04: ATA-7: SAMSUNG HD103UJ, 1AA01113, max UDMA7
[   27.928016] ata3.04: 1953525168 sectors, multi 0: LBA48 NCQ (not used)
[   27.934519] ata3.04: configured for UDMA/100
[   28.270164] ata3: EH complete
[   30.382321] ata4: SATA link down (SStatus 0 SControl 0)
[   30.382450] scsi 3:0:0:0: Direct-Access     ATA      SAMSUNG HD103UJ  1AA0 PQ: 0 ANSI: 5
[   30.382681] scsi 3:2:0:0: Direct-Access     ATA      SAMSUNG HD103UJ  1AA0 PQ: 0 ANSI: 5
[   30.382880] scsi 3:3:0:0: Direct-Access     ATA      SAMSUNG HD103UJ  1AA0 PQ: 0 ANSI: 5
[   30.383079] scsi 3:4:0:0: Direct-Access     ATA      SAMSUNG HD103UJ  1AA0 PQ: 0 ANSI: 5
[   30.384310] ACPI: PCI Interrupt 0000:12:00.0[A] -> GSI 16 (level, low) -> IRQ 16
[   30.384498] PCI: Setting latency timer of device 0000:12:00.0 to 64
[   30.395994] Driver 'sd' needs updating - please use bus_type methods
[   30.404791] sd 3:0:0:0: [sda] 1953525168 512-byte hardware sectors (1000205 MB)
[   30.404925] sd 3:0:0:0: [sda] Write Protect is off
[   30.405017] sd 3:0:0:0: [sda] Mode Sense: 00 3a 00 00
[   30.405036] sd 3:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   30.405196] sd 3:0:0:0: [sda] 1953525168 512-byte hardware sectors (1000205 MB)
[   30.405315] sd 3:0:0:0: [sda] Write Protect is off
[   30.405407] sd 3:0:0:0: [sda] Mode Sense: 00 3a 00 00
[   30.405427] sd 3:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   30.405542]  sda: sda1 sda2
[   30.450713] sd 3:0:0:0: [sda] Attached SCSI disk
[   30.450863] sd 3:2:0:0: [sdb] 1953525168 512-byte hardware sectors (1000205 MB)
[   30.450984] sd 3:2:0:0: [sdb] Write Protect is off
[   30.451075] sd 3:2:0:0: [sdb] Mode Sense: 00 3a 00 00
[   30.451093] sd 3:2:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   30.451238] sd 3:2:0:0: [sdb] 1953525168 512-byte hardware sectors (1000205 MB)
[   30.451358] sd 3:2:0:0: [sdb] Write Protect is off
[   30.451449] sd 3:2:0:0: [sdb] Mode Sense: 00 3a 00 00
[   30.451467] sd 3:2:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   30.451580]  sdb: sdb1 sdb2
[   30.462216] sd 3:2:0:0: [sdb] Attached SCSI disk
[   30.462346] sd 3:3:0:0: [sdc] 1953525168 512-byte hardware sectors (1000205 MB)
[   30.462466] sd 3:3:0:0: [sdc] Write Protect is off
[   30.462557] sd 3:3:0:0: [sdc] Mode Sense: 00 3a 00 00
[   30.462575] sd 3:3:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   30.468807] sd 3:3:0:0: [sdc] 1953525168 512-byte hardware sectors (1000205 MB)
[   30.468926] sd 3:3:0:0: [sdc] Write Protect is off
[   30.469018] sd 3:3:0:0: [sdc] Mode Sense: 00 3a 00 00
[   30.469036] sd 3:3:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   30.469149]  sdc: sdc1 sdc2
[   30.482928] sd 3:3:0:0: [sdc] Attached SCSI disk
[   30.483446] sd 3:4:0:0: [sdd] 1953525168 512-byte hardware sectors (1000205 MB)
[   30.483566] sd 3:4:0:0: [sdd] Write Protect is off
[   30.483657] sd 3:4:0:0: [sdd] Mode Sense: 00 3a 00 00
[   30.483675] sd 3:4:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   30.483820] sd 3:4:0:0: [sdd] 1953525168 512-byte hardware sectors (1000205 MB)
[   30.483939] sd 3:4:0:0: [sdd] Write Protect is off
[   30.484030] sd 3:4:0:0: [sdd] Mode Sense: 00 3a 00 00
[   30.484048] sd 3:4:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   30.484161]  sdd: sdd1 sdd2
[   30.498842] sd 3:4:0:0: [sdd] Attached SCSI disk
[   30.507249] eth0: (PCI Express:2.5GB/s:Width x1) 00:30:48:8f:59:b6
[   30.507353] eth0: Intel(R) PRO/1000 Network Connection
[   30.507615] eth0: MAC: 2, PHY: 2, PBA No: ffffff-0ff
[   30.507770] ACPI: PCI Interrupt 0000:13:00.0[A] -> GSI 17 (level, low) -> IRQ 17
[   30.507959] PCI: Setting latency timer of device 0000:13:00.0 to 64
[   30.630491] eth1: (PCI Express:2.5GB/s:Width x1) 00:30:48:8f:59:b7
[   30.630589] eth1: Intel(R) PRO/1000 Network Connection
[   30.630745] eth1: MAC: 2, PHY: 2, PBA No: ffffff-0ff
[   30.635561] ata_piix 0000:00:1f.2: version 2.12
[   30.635561] ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 19 (level, low) -> IRQ 19
[   30.635561] ata_piix 0000:00:1f.2: MAP [ P0 P2 P1 P3 ]
[   30.789665] PCI: Setting latency timer of device 0000:00:1f.2 to 64
[   30.790040] scsi5 : ata_piix
[   30.790211] scsi6 : ata_piix
[   30.791060] ata5: SATA max UDMA/133 cmd 0x1f0 ctl 0x3f6 bmdma 0x30a0 irq 14
[   30.791156] ata6: SATA max UDMA/133 cmd 0x170 ctl 0x376 bmdma 0x30a8 irq 15
[   30.954946] ata5.00: FORCE: horkage modified (noncq)
[   30.956884] ata5.00: ATA-8: SAMSUNG HM121HI, LZ100-08, max UDMA7
[   30.956988] ata5.00: 234441648 sectors, multi 16: LBA48 NCQ (not used)
[   30.972764] ata5.00: configured for UDMA/133
[   31.139542] ata6.00: FORCE: horkage modified (noncq)
[   31.141661] ata6.00: ATA-8: SAMSUNG HM121HI, LZ100-08, max UDMA7
[   31.141661] ata6.00: 234441648 sectors, multi 16: LBA48 NCQ (not used)
[   31.161601] ata6.00: configured for UDMA/133
[   31.161659] scsi 5:0:0:0: Direct-Access     ATA      SAMSUNG HM121HI  LZ10 PQ: 0 ANSI: 5
[   31.161659] sd 5:0:0:0: [sde] 234441648 512-byte hardware sectors (120034 MB)
[   31.161659] sd 5:0:0:0: [sde] Write Protect is off
[   31.161659] sd 5:0:0:0: [sde] Mode Sense: 00 3a 00 00
[   31.161659] sd 5:0:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   31.161659] sd 5:0:0:0: [sde] 234441648 512-byte hardware sectors (120034 MB)
[   31.161659] sd 5:0:0:0: [sde] Write Protect is off
[   31.161659] sd 5:0:0:0: [sde] Mode Sense: 00 3a 00 00
[   31.161659] sd 5:0:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   31.161659]  sde: sde1 sde2
[   31.814038] sd 5:0:0:0: [sde] Attached SCSI disk
[   31.814201] scsi 6:0:0:0: Direct-Access     ATA      SAMSUNG HM121HI  LZ10 PQ: 0 ANSI: 5
[   31.814365] sd 6:0:0:0: [sdf] 234441648 512-byte hardware sectors (120034 MB)
[   31.814469] sd 6:0:0:0: [sdf] Write Protect is off
[   31.814561] sd 6:0:0:0: [sdf] Mode Sense: 00 3a 00 00
[   31.814578] sd 6:0:0:0: [sdf] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   31.814722] sd 6:0:0:0: [sdf] 234441648 512-byte hardware sectors (120034 MB)
[   31.814827] sd 6:0:0:0: [sdf] Write Protect is off
[   31.814918] sd 6:0:0:0: [sdf] Mode Sense: 00 3a 00 00
[   31.814935] sd 6:0:0:0: [sdf] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   31.815049]  sdf: sdf1 sdf2
[   32.491794] sd 6:0:0:0: [sdf] Attached SCSI disk
[   32.494108] Uniform Multi-Platform E-IDE driver
[   32.494108] ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
[   32.728630] md: raid1 personality registered for level 1
[   32.733849] xor: automatically using best checksumming function: generic_sse
[   32.750906]    generic_sse:  5720.000 MB/sec
[   32.750906] xor: using function: generic_sse (5720.000 MB/sec)
[   32.750906] async_tx: api initialized (async)
[   32.822546] raid6: int64x1   2240 MB/s
[   32.890559] raid6: int64x2   3012 MB/s
[   32.958571] raid6: int64x4   2643 MB/s
[   33.026583] raid6: int64x8   1720 MB/s
[   33.094600] raid6: sse2x1    3275 MB/s
[   33.162615] raid6: sse2x2    3568 MB/s
[   33.230627] raid6: sse2x4    7050 MB/s
[   33.230627] raid6: using algorithm sse2x4 (7050 MB/s)
[   33.230627] md: raid6 personality registered for level 6
[   33.230627] md: raid5 personality registered for level 5
[   33.230627] md: raid4 personality registered for level 4
[   33.242464] md: md0 stopped.
[   33.256246] md: bind<sdf1>
[   33.256574] md: bind<sde1>
[   33.264344] raid1: raid set md0 active with 2 out of 2 mirrors
[   33.266445] md0: bitmap initialized from disk: read 4/4 pages, set 0 bits
[   33.266537] created bitmap (61 pages) for device md0
[   33.310420] md: md1 stopped.
[   33.319791] md: bind<sdf2>
[   33.319791] md: bind<sde2>
[   33.327606] raid1: raid set md1 active with 2 out of 2 mirrors
[   33.337696] md1: bitmap initialized from disk: read 14/14 pages, set 82 bits
[   33.337792] created bitmap (223 pages) for device md1
[   33.384725] md: md2 stopped.
[   33.387372] md: md4 stopped.
[   33.423094] md: md3 stopped.
[   33.481275] device-mapper: uevent: version 1.0.3
[   33.481275] device-mapper: ioctl: 4.13.0-ioctl (2007-10-18) initialised: dm-devel@redhat.com
[   33.712637] kjournald starting.  Commit interval 5 seconds
[   33.712756] EXT3-fs: mounted filesystem with ordered data mode.
[   35.658257] udevd version 125 started
[   36.357557] EDAC MC: Ver: 2.1.0 Oct  9 2008
[   36.380399] input: Power Button (FF) as /class/input/input2
[   36.385009] EDAC MC0: Giving out device to 'i3000_edac' 'i3000': DEV 0000:00:00.0
[   36.385009] EDAC PCI0: Giving out device to module 'i3000_edac' controller 'EDAC PCI controller': DEV '0000:00:00.0' (POLLED)
[   36.429066] ACPI: Power Button (FF) [PWRF]
[   36.429234] input: Power Button (CM) as /class/input/input3
[   36.501472] ACPI: Power Button (CM) [PWRB]
[   36.657100] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[   36.667726] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[   36.782686] intel_rng: FWH not detected
[   36.802131] ACPI: PCI Interrupt 0000:00:1f.3[B] -> GSI 19 (level, low) -> IRQ 19
[   36.814264] input: PC Speaker as /class/input/input4
[   36.853791] iTCO_wdt: Intel TCO WatchDog Timer Driver v1.03 (30-Apr-2008)
[   37.236354] input: ImExPS/2 Generic Explorer Mouse as /class/input/input5
[   37.264723] iTCO_wdt: Found a ICH7 or ICH7R TCO device (Version=2, TCOBASE=0x1060)
[   37.264865] iTCO_wdt: initialized. heartbeat=30 sec (nowayout=0)
[   39.163310] EXT3 FS on dm-0, internal journal
[   40.477642] loop: module loaded
[   40.545727] md: md2 stopped.
[   40.617272] md: md4 stopped.
[   40.760450] md: bind<sdb2>
[   40.761655] md: bind<sdc2>
[   40.761883] md: bind<sdd2>
[   40.762104] md: bind<sda2>
[   40.847721] raid5: device sda2 operational as raid disk 0
[   40.847721] raid5: device sdd2 operational as raid disk 4
[   40.847721] raid5: device sdc2 operational as raid disk 3
[   40.847721] raid5: device sdb2 operational as raid disk 2
[   40.847721] raid5: allocated 5324kB for md11
[   40.847721] raid5: raid level 5 set md11 active with 4 out of 5 devices, algorithm 2
[   40.847721] RAID5 conf printout:
[   40.847721]  --- rd:5 wd:4
[   40.847721]  disk 0, o:1, dev:sda2
[   40.847721]  disk 2, o:1, dev:sdb2
[   40.847721]  disk 3, o:1, dev:sdc2
[   40.853869]  disk 4, o:1, dev:sdd2
[   40.857847] md: bind<sdb1>
[   40.858057] md: bind<sdc1>
[   40.858261] md: bind<sdd1>
[   40.858464] md: bind<sda1>
[   40.888956] raid5: device sda1 operational as raid disk 0
[   40.889054] raid5: device sdd1 operational as raid disk 4
[   40.889146] raid5: device sdc1 operational as raid disk 3
[   40.889238] raid5: device sdb1 operational as raid disk 2
[   40.891733] raid5: allocated 5324kB for md10
[   40.891733] raid5: raid level 6 set md10 active with 4 out of 5 devices, algorithm 2
[   40.891733] RAID5 conf printout:
[   40.891733]  --- rd:5 wd:4
[   40.891733]  disk 0, o:1, dev:sda1
[   40.891733]  disk 2, o:1, dev:sdb1
[   40.891733]  disk 3, o:1, dev:sdc1
[   40.891733]  disk 4, o:1, dev:sdd1
[   42.296413] SGI XFS with ACLs, security attributes, realtime, large block/inode numbers, no debug enabled
[   42.296413] SGI XFS Quota Management subsystem
[   42.423652] Adding 4972536k swap on /dev/mapper/cleopatra-swap_1.  Priority:-1 extents:1 across:4972536k
[   43.910868] NET: Registered protocol family 10
[   43.910868] lo: Disabled Privacy Extensions
[   44.057216] no ownder
[   44.057308] map irq failed
[   44.058743] ADDRCONF(NETDEV_UP): eth0: link is not ready
[   45.912555] RPC: Registered udp transport module.
[   45.912555] RPC: Registered tcp transport module.
[   46.251245] Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
[   46.749950] eth0: Link is Up 1000 Mbps Full Duplex, Flow Control: None
[   46.750443] ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
[   52.125226] NFSD: Using /var/lib/nfs/v4recovery as the NFSv4 state recovery directory
[   52.171087] NFSD: starting 90-second grace period
[   55.827905] Bridge firewalling registered
[   55.828777] tmpbridge: Dropping NETIF_F_UFO since no NETIF_F_HW_CSUM feature.
[   56.138353] no ownder
[   56.138462] map irq failed
[   56.139864] ADDRCONF(NETDEV_UP): peth0: link is not ready
[   58.739116] peth0: Link is Up 1000 Mbps Full Duplex, Flow Control: None
[   58.739729] ADDRCONF(NETDEV_CHANGE): peth0: link becomes ready
[   59.186009] device peth0 entered promiscuous mode
[   59.464293] eth0: port 1(peth0) entering learning state
[   59.468010] eth0: topology change detected, propagating
[   59.468292] eth0: port 1(peth0) entering forwarding state
[   60.052183] suspend: event channel 26
[   69.073711] peth0: no IPv6 routers present

--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: attachment; filename="hdparm.txt"


/dev/sdb:

ATA device, with non-removable media
	Model Number:       SAMSUNG HD103UJ                         
	Serial Number:      S13PJ1EQ505832      
	Firmware Revision:  1AA01112
Standards:
	Used: ATA-8-ACS revision 3b 
	Supported: 7 6 5 4 
Configuration:
	Logical		max	current
	cylinders	16383	16383
	heads		16	16
	sectors/track	63	63
	--
	CHS current addressable sectors:   16514064
	LBA    user addressable sectors:  268435455
	LBA48  user addressable sectors: 1953525168
	device size with M = 1024*1024:      953869 MBytes
	device size with M = 1000*1000:     1000204 MBytes (1000 GB)
Capabilities:
	LBA, IORDY(can be disabled)
	Queue depth: 32
	Standby timer values: spec'd by Standard, no device specific minimum
	R/W multiple sector transfer: Max = 16	Current = 0
	Advanced power management level: disabled
	Recommended acoustic management value: 254, current value: 0
	DMA: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 *udma5 udma6 udma7 
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
	    	Advanced Power Management feature set
	    	Power-Up In Standby feature set
	   *	SET_FEATURES required to spinup after power up
	    	SET_MAX security extension
	    	Automatic Acoustic Management feature set
	   *	48-bit Address feature set
	   *	Device Configuration Overlay feature set
	   *	Mandatory FLUSH_CACHE
	   *	FLUSH_CACHE_EXT
	   *	SMART error logging
	   *	SMART self-test
	    	Media Card Pass-Through
	   *	General Purpose Logging feature set
	   *	64-bit World wide name
	   *	WRITE_UNCORRECTABLE_EXT command
	   *	{READ,WRITE}_DMA_EXT_GPL commands
	   *	Segmented DOWNLOAD_MICROCODE
	   *	SATA-I signaling speed (1.5Gb/s)
	   *	SATA-II signaling speed (3.0Gb/s)
	   *	Native Command Queueing (NCQ)
	   *	Host-initiated interface power management
	   *	Phy event counters
	   *	unknown 76[12]
	    	DMA Setup Auto-Activate optimization
	    	Device-initiated interface power management
	   *	Software settings preservation
	   *	SMART Command Transport (SCT) feature set
	   *	SCT Long Sector Access (AC1)
	   *	SCT LBA Segment Access (AC2)
	   *	SCT Error Recovery Control (AC3)
	   *	SCT Features Control (AC4)
	   *	SCT Data Tables (AC5)
Security: 
	Master password revision code = 65534
		supported
	not	enabled
	not	locked
	not	frozen
	not	expired: security count
		supported: enhanced erase
	178min for SECURITY ERASE UNIT. 178min for ENHANCED SECURITY ERASE UNIT.
Logical Unit WWN Device Identifier: 5000f00b058523
	NAA		: 5
	IEEE OUI	: f0
	Unique ID	: 0b058523
Checksum: correct

--cWoXeonUoKmBZSoM--
