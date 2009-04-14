From: Mark de Wever <koraq@xs4all.nl>
Subject: Re: [bug#12874] Seagate STT20000A no longer works
Date: Tue, 14 Apr 2009 23:41:37 +0200
Message-ID: <20090414214137.GA7278@localhost>
References: <20090410174247.GA12885@liondog.tnic>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="J/dobhs11T7y2rNN"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp-vbr13.xs4all.nl ([194.109.24.33]:4229 "EHLO
	smtp-vbr13.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752561AbZDNVoI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 14 Apr 2009 17:44:08 -0400
Content-Disposition: inline
In-Reply-To: <20090410174247.GA12885@liondog.tnic>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: petkovbb@gmail.com
Cc: sshtylyov@ru.mvista.com, bzolnier@gmail.com, linux-ide@vger.kernel.org


--J/dobhs11T7y2rNN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 10, 2009 at 07:42:47PM +0200, Borislav Petkov wrote:
> (moving discussion to mail and adding Bart to CC)
> 
> (In reply to comment #24)
> > (In reply to comment #20)
> > > Hmm, seems like the buffer is quite botched or the drive replies with some mode
> > > parameter headers I cannot correlate.
> > 
> > If you mean this line:
> > 
> > [   42.272638] caps:  70 0 6 0 0 0 0 a 0 0 0 0 29 0 0 0 0 0 0 0 0 0 0 0
> > 
> > 
> > this is the extended sense data with its characteristic 1st byte of 0x70,
> > 8-byte header with sense key UNIT ATTENTION, 10 bytes of additinal length and
> > ASC of 0x29 meaning "reset hs occured".
> 
> Haa, thanks for catching that, although the QIC157d document I'm staring
> at here states that the drive might return sense data instead of the
> requested page, it seems that we don't get any CHECK CONDITION status
> otherwise ide_pc_intr would've caught it (stat & ATA_ERR) and retried
> the command.
> 
> Now, without having tested it since I don't have the hardware, would
> something in the lines below be a sensible kludge for now? I guess we
> should have similar error handling for the other MODE SENSE call sites
> and propagate some error status from idetape_get_mode_sense_results()
> upwards to idetape_setup()? Yeah, I know, the driver needs a lot of
> massaging in order even to start looking ok... :)

This time with the dmesg attached.

-- 
Regards,
Mark de Wever

--J/dobhs11T7y2rNN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=dmesg

[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Linux version 2.6.29-rc7 (root@spearhead) (gcc version 4.1.3 20080704 (prerelease) (Debian 4.1.2-25)) #1 Tue Apr 14 21:12:02 CEST 2009
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
[    0.000000]  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
[    0.000000]  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
[    0.000000]  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
[    0.000000]  BIOS-e820: 0000000000100000 - 000000001fff0000 (usable)
[    0.000000]  BIOS-e820: 000000001fff0000 - 000000001fff3000 (ACPI NVS)
[    0.000000]  BIOS-e820: 000000001fff3000 - 0000000020000000 (ACPI data)
[    0.000000]  BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
[    0.000000] DMI 2.2 present.
[    0.000000] last_pfn = 0x1fff0 max_arch_pfn = 0x100000
[    0.000000] kernel direct mapping tables up to 1fff0000 @ 7000-c000
[    0.000000] RAMDISK: 1fc5b000 - 1ffdfb76
[    0.000000] ACPI: RSDP 000F7000, 0014 (r0 AMDVIA)
[    0.000000] ACPI: RSDT 1FFF3000, 0028 (r1 AMDVIA AWRDACPI 42302E31 AWRD        0)
[    0.000000] ACPI: FACP 1FFF3040, 0074 (r1 AMDVIA AWRDACPI 42302E31 AWRD        0)
[    0.000000] FADT: X_PM1a_EVT_BLK.bit_width (16) does not match PM1_EVT_LEN (4)
[    0.000000] ACPI: DSDT 1FFF30C0, 22E0 (r1 AMDVIA AWRDACPI     1000 MSFT  100000C)
[    0.000000] ACPI: FACS 1FFF0000, 0040
[    0.000000] 0MB HIGHMEM available.
[    0.000000] 511MB LOWMEM available.
[    0.000000]   mapped low ram: 0 - 1fff0000
[    0.000000]   low ram: 00000000 - 1fff0000
[    0.000000]   bootmap 00001000 - 00005000
[    0.000000] (7 early reservations) ==> bootmem [0000000000 - 001fff0000]
[    0.000000]   #0 [0000000000 - 0000001000]   BIOS data page ==> [0000000000 - 0000001000]
[    0.000000]   #1 [0000100000 - 000043a7ac]    TEXT DATA BSS ==> [0000100000 - 000043a7ac]
[    0.000000]   #2 [001fc5b000 - 001ffdfb76]          RAMDISK ==> [001fc5b000 - 001ffdfb76]
[    0.000000]   #3 [000043b000 - 000043e000]    INIT_PG_TABLE ==> [000043b000 - 000043e000]
[    0.000000]   #4 [000009fc00 - 0000100000]    BIOS reserved ==> [000009fc00 - 0000100000]
[    0.000000]   #5 [0000007000 - 0000008000]          PGTABLE ==> [0000007000 - 0000008000]
[    0.000000]   #6 [0000001000 - 0000005000]          BOOTMAP ==> [0000001000 - 0000005000]
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA      0x00000000 -> 0x00001000
[    0.000000]   Normal   0x00001000 -> 0x0001fff0
[    0.000000]   HighMem  0x0001fff0 -> 0x0001fff0
[    0.000000] Movable zone start PFN for each node
[    0.000000] early_node_map[2] active PFN ranges
[    0.000000]     0: 0x00000000 -> 0x0000009f
[    0.000000]     0: 0x00000100 -> 0x0001fff0
[    0.000000] On node 0 totalpages: 130959
[    0.000000] free_area_init_node: node 0, pgdat c0375d60, node_mem_map c1000000
[    0.000000]   DMA zone: 32 pages used for memmap
[    0.000000]   DMA zone: 0 pages reserved
[    0.000000]   DMA zone: 3967 pages, LIFO batch:0
[    0.000000]   Normal zone: 992 pages used for memmap
[    0.000000]   Normal zone: 125968 pages, LIFO batch:31
[    0.000000] ACPI: PM-Timer IO Port: 0x4008
[    0.000000] Local APIC disabled by BIOS -- you can enable it with "lapic"
[    0.000000] PM: Registered nosave memory: 000000000009f000 - 00000000000a0000
[    0.000000] PM: Registered nosave memory: 00000000000a0000 - 00000000000f0000
[    0.000000] PM: Registered nosave memory: 00000000000f0000 - 0000000000100000
[    0.000000] Allocating PCI resources starting at 30000000 (gap: 20000000:dfff0000)
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 129935
[    0.000000] Kernel command line: root=/dev/hda6 ro 
[    0.000000] Enabling fast FPU save and restore... done.
[    0.000000] Enabling unmasked SIMD FPU exception support... done.
[    0.000000] Initializing CPU#0
[    0.000000] PID hash table entries: 2048 (order: 11, 8192 bytes)
[    0.000000] Fast TSC calibration using PIT
[    0.000000] Detected 1211.998 MHz processor.
[    0.004000] Console: colour VGA+ 80x25
[    0.004000] console [tty0] enabled
[    0.004000] Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
[    0.004000] Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
[    0.004000] Memory: 512104k/524224k available (1723k kernel code, 11456k reserved, 837k data, 252k init, 0k highmem)
[    0.004000] virtual kernel memory layout:
[    0.004000]     fixmap  : 0xfffec000 - 0xfffff000   (  76 kB)
[    0.004000]     pkmap   : 0xff800000 - 0xffc00000   (4096 kB)
[    0.004000]     vmalloc : 0xe07f0000 - 0xff7fe000   ( 496 MB)
[    0.004000]     lowmem  : 0xc0000000 - 0xdfff0000   ( 511 MB)
[    0.004000]       .init : 0xc0384000 - 0xc03c3000   ( 252 kB)
[    0.004000]       .data : 0xc02aeebc - 0xc03805a8   ( 837 kB)
[    0.004000]       .text : 0xc0100000 - 0xc02aeebc   (1723 kB)
[    0.004000] Checking if this processor honours the WP bit even in supervisor mode...Ok.
[    0.004013] Calibrating delay loop (skipped), value calculated using timer frequency.. 2423.99 BogoMIPS (lpj=4847992)
[    0.004163] Security Framework initialized
[    0.004217] SELinux:  Disabled at boot.
[    0.004279] Mount-cache hash table entries: 512
[    0.004506] Initializing cgroup subsys ns
[    0.004556] Initializing cgroup subsys cpuacct
[    0.004604] Initializing cgroup subsys devices
[    0.004671] CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
[    0.004725] CPU: L2 Cache: 256K (64 bytes/line)
[    0.004775] Intel machine check architecture supported.
[    0.004824] Intel machine check reporting enabled on CPU#0.
[    0.004886] CPU: AMD Athlon(tm) XP stepping 02
[    0.005001] Checking 'hlt' instruction... OK.
[    0.020300] Freeing SMP alternatives: 0k freed
[    0.020350] ACPI: Core revision 20081204
[    0.026153] ACPI: setting ELCR to 0200 (from 0e28)
[    0.028159] net_namespace: 1044 bytes
[    0.028604] NET: Registered protocol family 16
[    0.029180] ACPI: bus type pci registered
[    0.047893] PCI: PCI BIOS revision 2.10 entry at 0xfb3b0, last bus=1
[    0.047947] PCI: Using configuration type 1 for base access
[    0.049703] bio: create slab <bio-0> at 0
[    0.050287] ACPI: EC: Look up EC in DSDT
[    0.053650] ACPI: Denied BIOS AML access to invalid port 0x4d0+0x2 (ELCR)
[    0.053708] ACPI Exception (dsopcode-0419): AE_AML_ILLEGAL_ADDRESS, During address validation of OpRegion [ELCR] [20081204]
[    0.055141] ACPI: Interpreter enabled
[    0.055191] ACPI: (supports S0 S1 S4 S5)
[    0.055385] ACPI: Using PIC for interrupt routing
[    0.060919] ACPI: No dock devices found.
[    0.060988] ACPI: PCI Root Bridge [PCI0] (0000:00)
[    0.061147] pci 0000:00:00.0: reg 10 32bit mmio: [0xd0000000-0xd7ffffff]
[    0.061155] pci 0000:00:00.0: reg 14 32bit mmio: [0xe3001000-0xe3001fff]
[    0.061163] pci 0000:00:00.0: reg 18 io port: [0xc000-0xc003]
[    0.061244] pci 0000:00:09.0: reg 10 io port: [0xc400-0xc47f]
[    0.061251] pci 0000:00:09.0: reg 14 32bit mmio: [0xe3000000-0xe300007f]
[    0.061271] pci 0000:00:09.0: reg 30 32bit mmio: [0x000000-0x01ffff]
[    0.061288] pci 0000:00:09.0: supports D1 D2
[    0.061291] pci 0000:00:09.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.061346] pci 0000:00:09.0: PME# disabled
[    0.061416] pci 0000:00:0a.0: reg 10 io port: [0xc800-0xc81f]
[    0.061450] pci 0000:00:0a.0: supports D1 D2
[    0.061476] pci 0000:00:0a.1: reg 10 io port: [0xcc00-0xcc07]
[    0.061510] pci 0000:00:0a.1: supports D1 D2
[    0.061542] pci 0000:00:0b.0: reg 10 io port: [0xd000-0xd07f]
[    0.061549] pci 0000:00:0b.0: reg 14 32bit mmio: [0xe3002000-0xe300207f]
[    0.061569] pci 0000:00:0b.0: reg 30 32bit mmio: [0x000000-0x01ffff]
[    0.061584] pci 0000:00:0b.0: supports D1 D2
[    0.061588] pci 0000:00:0b.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.061641] pci 0000:00:0b.0: PME# disabled
[    0.061786] pci 0000:00:11.1: reg 20 io port: [0xd400-0xd40f]
[    0.061862] pci 0000:00:11.2: reg 20 io port: [0xd800-0xd81f]
[    0.061920] pci 0000:00:11.3: reg 20 io port: [0xdc00-0xdc1f]
[    0.062047] pci 0000:01:05.0: reg 10 32bit mmio: [0xe0000000-0xe0ffffff]
[    0.062055] pci 0000:01:05.0: reg 14 32bit mmio: [0xd8000000-0xdfffffff]
[    0.062073] pci 0000:01:05.0: reg 30 32bit mmio: [0x000000-0x00ffff]
[    0.062119] pci 0000:00:01.0: bridge 32bit mmio: [0xe0000000-0xe1ffffff]
[    0.062125] pci 0000:00:01.0: bridge 32bit mmio pref: [0xd8000000-0xdfffffff]
[    0.062134] pci_bus 0000:00: on NUMA node 0
[    0.062145] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[    0.081193] ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 *5 6 7 10 11 12 14 15)
[    0.081894] ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 5 6 7 *10 11 12 14 15)
[    0.082592] ACPI: PCI Interrupt Link [LNKC] (IRQs 1 *3 4 5 6 7 10 11 12 14 15)
[    0.083288] ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 5 6 7 10 *11 12 14 15)
[    0.084376] PCI: Using ACPI for IRQ routing
[    0.084807] pnp: PnP ACPI init
[    0.084865] ACPI: bus type pnp registered
[    0.089053] pnp: PnP ACPI: found 12 devices
[    0.089103] ACPI: ACPI bus type pnp unregistered
[    0.089155] PnPBIOS: Disabled by ACPI PNP
[    0.089225] system 00:00: iomem range 0xd1800-0xd3fff has been reserved
[    0.089280] system 00:00: iomem range 0xf0000-0xf7fff could not be reserved
[    0.089334] system 00:00: iomem range 0xf8000-0xfbfff could not be reserved
[    0.089388] system 00:00: iomem range 0xfc000-0xfffff could not be reserved
[    0.089442] system 00:00: iomem range 0x1fff0000-0x1fffffff could not be reserved
[    0.089503] system 00:00: iomem range 0xffff0000-0xffffffff has been reserved
[    0.089557] system 00:00: iomem range 0xffc00000-0xfffe8fff has been reserved
[    0.089612] system 00:00: iomem range 0x0-0x9ffff could not be reserved
[    0.089665] system 00:00: iomem range 0x100000-0x1ffeffff could not be reserved
[    0.089727] system 00:00: iomem range 0xfee00000-0xfee00fff has been reserved
[    0.089788] system 00:02: ioport range 0x4d0-0x4d1 has been reserved
[    0.125007] pci 0000:00:01.0: PCI bridge, secondary bus 0000:01
[    0.125060] pci 0000:00:01.0:   IO window: disabled
[    0.125112] pci 0000:00:01.0:   MEM window: 0xe0000000-0xe1ffffff
[    0.125165] pci 0000:00:01.0:   PREFETCH window: 0x000000d8000000-0x000000dfffffff
[    0.125239] pci_bus 0000:00: resource 0 io:  [0x00-0xffff]
[    0.125244] pci_bus 0000:00: resource 1 mem: [0x000000-0xffffffff]
[    0.125249] pci_bus 0000:01: resource 0 mem: [0x0-0x0]
[    0.125253] pci_bus 0000:01: resource 1 mem: [0xe0000000-0xe1ffffff]
[    0.125257] pci_bus 0000:01: resource 2 mem: [0xd8000000-0xdfffffff]
[    0.125261] pci_bus 0000:01: resource 3 mem: [0x0-0x0]
[    0.125344] NET: Registered protocol family 2
[    0.125556] IP route cache hash table entries: 4096 (order: 2, 16384 bytes)
[    0.126133] TCP established hash table entries: 16384 (order: 5, 131072 bytes)
[    0.126555] TCP bind hash table entries: 16384 (order: 4, 65536 bytes)
[    0.126776] TCP: Hash tables configured (established 16384 bind 16384)
[    0.126829] TCP reno registered
[    0.126987] NET: Registered protocol family 1
[    0.127266] checking if image is initramfs... it is
[    0.609830] Freeing initrd memory: 3602k freed
[    0.610978] audit: initializing netlink socket (disabled)
[    0.611054] type=2000 audit(1239743312.607:1): initialized
[    0.611360] HugeTLB registered 4 MB page size, pre-allocated 0 pages
[    0.611499] VFS: Disk quotas dquot_6.5.2
[    0.611611] Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
[    0.611744] msgmni has been set to 1007
[    0.612037] alg: No test for stdrng (krng)
[    0.612174] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 253)
[    0.612237] io scheduler noop registered
[    0.612283] io scheduler anticipatory registered
[    0.612331] io scheduler deadline registered
[    0.612387] io scheduler cfq registered (default)
[    0.612494] pci 0000:01:05.0: Boot video device
[    0.613097] isapnp: Scanning for PnP cards...
[    0.628018] Switched to high resolution mode on CPU 0
[    0.966611] isapnp: No Plug & Play device found
[    0.971179] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    0.971431] serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[    0.972758] 00:08: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[    0.975356] brd: module loaded
[    0.975578] PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
[    0.976752] serio: i8042 KBD port at 0x60,0x64 irq 1
[    0.976807] serio: i8042 AUX port at 0x60,0x64 irq 12
[    0.977147] mice: PS/2 mouse device common for all mice
[    0.977319] rtc_cmos 00:04: RTC can wake from S4
[    0.977501] rtc_cmos 00:04: rtc core: registered rtc_cmos as rtc0
[    0.977576] rtc0: alarms up to one year, y3k, 242 bytes nvram
[    0.977683] cpuidle: using governor ladder
[    0.977731] cpuidle: using governor menu
[    0.977783] No iBFT detected.
[    0.978560] TCP cubic registered
[    0.978609] NET: Registered protocol family 17
[    0.978678] Using IPI Shortcut mode
[    0.978948] registered taskstats version 1
[    0.979224] rtc_cmos 00:04: setting system clock to 2009-04-14 21:08:33 UTC (1239743313)
[    0.979852] Freeing unused kernel memory: 252k freed
[    1.004147] input: AT Translated Set 2 keyboard as /class/input/input0
[    1.117561] processor ACPI_CPU:00: registered as cooling_device0
[    1.117630] ACPI: Processor [CPU0] (supports 2 throttling states)
[    2.092504] ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 10
[    2.092566] PCI: setting IRQ 10 as level-triggered
[    2.092576] 3c59x 0000:00:09.0: PCI INT A -> Link[LNKB] -> GSI 10 (level, low) -> IRQ 10
[    2.092685] 3c59x: Donald Becker and others.
[    2.092742] 0000:00:09.0: 3Com PCI 3c905C Tornado at e08ba000.
[    2.113911] eth0 (3c59x): not using net_device_ops yet
[    2.141510] Uniform Multi-Platform E-IDE driver
[    2.216485] Floppy drive(s): fd0 is 1.44M
[    2.239681] FDC 0 is a post-1991 82077
[    2.255388] ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
[    2.255450] PCI: setting IRQ 11 as level-triggered
[    2.255460] 3c59x 0000:00:0b.0: PCI INT A -> Link[LNKD] -> GSI 11 (level, low) -> IRQ 11
[    2.255571] 0000:00:0b.0: 3Com PCI 3c905C Tornado at e0834000.
[    2.276740] eth1 (3c59x): not using net_device_ops yet
[    2.280920] via82cxxx 0000:00:11.1: VIA vt8231 (rev 10) IDE UDMA100
[    2.280983] via82cxxx 0000:00:11.1: IDE controller (0x1106:0x0571 rev 0x06)
[    2.281083] via82cxxx 0000:00:11.1: not 100% native mode: will probe irqs later
[    2.281148]     ide0: BM-DMA at 0xd400-0xd407
[    2.281206]     ide1: BM-DMA at 0xd408-0xd40f
[    2.281258] Probing IDE interface ide0...
[    2.290296] usbcore: registered new interface driver usbfs
[    2.290406] usbcore: registered new interface driver hub
[    2.290536] usbcore: registered new device driver usb
[    2.294383] uhci_hcd: USB Universal Host Controller Interface driver
[    2.696219] hda: Maxtor 6L160P0, ATA DISK drive
[    3.368117] hda: host max PIO5 wanted PIO255(auto-tune) selected PIO4
[    3.369629] hda: UDMA/100 mode selected
[    3.372322] Probing IDE interface ide1...
[    4.236224] hdc: PLEXTOR CD-R PX-W4824A, ATAPI CD/DVD-ROM drive
[    5.020222] hdd: Seagate STT20000A, ATAPI TAPE drive
[    5.076075] hdc: host max PIO5 wanted PIO255(auto-tune) selected PIO4
[    5.076161] hdc: MWDMA2 mode selected
[    5.076298] hdd: host max PIO5 wanted PIO255(auto-tune) selected PIO4
[    5.076994] hdd: Disabling (U)DMA for Seagate STT20000A (blacklisted)
[    5.077046] hdd: host max PIO5 wanted PIO255(auto-tune) selected PIO4
[    5.078122] ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
[    5.078235] ide1 at 0x170-0x177,0x376 on irq 15
[    5.078542] uhci_hcd 0000:00:11.2: PCI INT D -> Link[LNKD] -> GSI 11 (level, low) -> IRQ 11
[    5.078619] uhci_hcd 0000:00:11.2: UHCI Host Controller
[    5.078757] uhci_hcd 0000:00:11.2: new USB bus registered, assigned bus number 1
[    5.078841] uhci_hcd 0000:00:11.2: irq 11, io base 0x0000d800
[    5.078979] usb usb1: New USB device found, idVendor=1d6b, idProduct=0001
[    5.079033] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    5.079093] usb usb1: Product: UHCI Host Controller
[    5.079141] usb usb1: Manufacturer: Linux 2.6.29-rc7 uhci_hcd
[    5.079191] usb usb1: SerialNumber: 0000:00:11.2
[    5.079354] usb usb1: configuration #1 chosen from 1 choice
[    5.079452] hub 1-0:1.0: USB hub found
[    5.079513] hub 1-0:1.0: 2 ports detected
[    5.079728] uhci_hcd 0000:00:11.3: PCI INT D -> Link[LNKD] -> GSI 11 (level, low) -> IRQ 11
[    5.079797] uhci_hcd 0000:00:11.3: UHCI Host Controller
[    5.079877] uhci_hcd 0000:00:11.3: new USB bus registered, assigned bus number 2
[    5.079956] uhci_hcd 0000:00:11.3: irq 11, io base 0x0000dc00
[    5.080099] usb usb2: New USB device found, idVendor=1d6b, idProduct=0001
[    5.080153] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    5.080211] usb usb2: Product: UHCI Host Controller
[    5.080259] usb usb2: Manufacturer: Linux 2.6.29-rc7 uhci_hcd
[    5.080309] usb usb2: SerialNumber: 0000:00:11.3
[    5.080439] usb usb2: configuration #1 chosen from 1 choice
[    5.080529] hub 2-0:1.0: USB hub found
[    5.080587] hub 2-0:1.0: 2 ports detected
[    5.114635] ide-gd driver 1.18
[    5.114746] hda: max request size: 512KiB
[    5.164043] hda: 320173056 sectors (163928 MB) w/8192KiB Cache, CHS=19929/255/63
[    5.168863] hda: cache flushes supported
[    5.169015]  hda: hda1 hda2 < hda5<6>ide-cd driver 5.00
[    5.186594]  hda6 hda7 hda8 hda9 hda10 >
[    5.242541] ide-cd: hdc: ATAPI 40X CD-ROM CD-R/RW drive, 4096kB Cache
[    5.242757] Uniform CD-ROM driver Revision: 3.20
[    5.647131] PM: Starting manual resume from disk
[    5.706373] kjournald starting.  Commit interval 5 seconds
[    5.706447] EXT3-fs: mounted filesystem with ordered data mode.
[    7.734436] udevd version 125 started
[    9.663084] EDAC MC: Ver: 2.1.0 Apr 14 2009
[    9.733885] EDAC MC0: Giving out device to 'amd76x_edac' 'AMD761': DEV 0000:00:00.0
[    9.733989] EDAC PCI0: Giving out device to module 'amd76x_edac' controller 'EDAC PCI controller': DEV '0000:00:00.0' (POLLED)
[    9.925249] gameport: EMU10K1 is pci0000:00:0a.1/gameport0, io 0xcc00, speed 1217kHz
[    9.989206] parport_pc: VIA 686A/8231 detected
[    9.989212] parport_pc: probing current configuration
[    9.989229] parport_pc: Current parallel port base: 0x378
[    9.989276] parport0: PC-style at 0x378, irq 7 [PCSPP,EPP]
[   10.060642] Linux agpgart interface v0.103
[   10.144203] parport_pc: VIA parallel port: io=0x378, irq=7
[   10.400991] input: PC Speaker as /class/input/input1
[   10.482480] input: Power Button (FF) as /class/input/input2
[   10.482605] ACPI: Power Button (FF) [PWRF]
[   10.482764] input: Power Button (CM) as /class/input/input3
[   10.482851] ACPI: Power Button (CM) [PWRB]
[   10.483004] input: Sleep Button (CM) as /class/input/input4
[   10.483091] ACPI: Sleep Button (CM) [SLPB]
[   11.342506] input: PS/2 Logitech Mouse as /class/input/input5
[   11.896557] ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 3
[   11.896621] PCI: setting IRQ 3 as level-triggered
[   11.896631] EMU10K1_Audigy 0000:00:0a.0: PCI INT A -> Link[LNKC] -> GSI 3 (level, low) -> IRQ 3
[   11.910010] Control name 'Sigmatel Surround Phase Inversion Playback Switch' truncated to 'Sigmatel Surround Phase Inversion Playback '
[   14.175488] Adding 497972k swap on /dev/hda5.  Priority:-1 extents:1 across:497972k 
[   14.506793] EXT3 FS on hda6, internal journal
[   16.246155] kjournald starting.  Commit interval 5 seconds
[   16.246436] EXT3 FS on hda7, internal journal
[   16.246518] EXT3-fs: mounted filesystem with ordered data mode.
[   16.311482] kjournald starting.  Commit interval 5 seconds
[   16.311699] EXT3 FS on hda8, internal journal
[   16.311779] EXT3-fs: mounted filesystem with ordered data mode.
[   16.367962] kjournald starting.  Commit interval 5 seconds
[   16.368226] EXT3 FS on hda10, internal journal
[   16.368309] EXT3-fs: mounted filesystem with ordered data mode.
[   17.335997] nf_conntrack version 0.5.0 (8191 buckets, 32764 max)
[   17.336350] CONFIG_NF_CT_ACCT is deprecated and will be removed soon. Please use
[   17.336411] nf_conntrack.acct=1 kernel paramater, acct=1 nf_conntrack module option or
[   17.336473] sysctl net.netfilter.nf_conntrack_acct=1 to enable it.
[   17.411491] ip_tables: (C) 2000-2006 Netfilter Core Team
[   18.322063] eth0:  setting full-duplex.
[   22.888583] NET: Registered protocol family 10
[   22.889925] lo: Disabled Privacy Extensions
[   25.816504] lp0: using parport0 (interrupt-driven).
[   25.852405] ppdev: user-space parallel port driver
[   33.092034] eth0: no IPv6 routers present
[   49.611347] idetape_do_request: cmd: 0x12, 13: 0x1, sector: 18446744073709551615, nr_sectors: 0, current_nr_sectors: 0
[   49.611425] idetape_do_request: tape->failed_pc: (null), pc->c[0]: 0x12
[   49.611479] this rq: dev hdd: type=7, flags=82640
[   49.611529]   sector 18446744073709551615, nr/cnr 0/0
[   49.611578]   bio (null), biotail (null), buffer def45d58, data (null), len 0
[   49.614501] ide-tape: hdd <-> ht0: Seagate STT20000A rev 8A51
[   49.614592] idetape_do_request: cmd: 0x1a, 13: 0x1, sector: 18446744073709551615, nr_sectors: 0, current_nr_sectors: 0
[   49.614660] idetape_do_request: tape->failed_pc: (null), pc->c[0]: 0x1a
[   49.614713] this rq: dev hdd: type=7, flags=82640
[   49.614761]   sector 18446744073709551615, nr/cnr 0/0
[   49.614811]   bio (null), biotail (null), buffer def45d58, data (null), len 0
[   49.616723] idetape_do_request: cmd: 0x3, 13: 0x1, sector: 18446744073709551615, nr_sectors: 0, current_nr_sectors: 0
[   49.616801] idetape_do_request: tape->failed_pc: def45d58, pc->c[0]: 0x3
[   49.616855] this rq: dev hdd: type=7, flags=10440
[   49.616903]   sector 18446744073709551615, nr/cnr 0/0
[   49.616952]   bio (null), biotail (null), buffer de877db4, data (null), len 0
[   49.620556] idetape_do_request: cmd: 0x1a, 13: 0x2, sector: 18446744073709551615, nr_sectors: 0, current_nr_sectors: 0
[   49.620633] idetape_do_request: tape->failed_pc: (null), pc->c[0]: 0x1a
[   49.620686] this rq: dev hdd: type=7, flags=82640
[   49.620734]   sector 18446744073709551615, nr/cnr 0/0
[   49.620783]   bio (null), biotail (null), buffer def45d58, data (null), len 0
[   49.620863] caps:  70 0 6 0 0 0 0 a 0 0 0 0 29 0 0 0 0 0 0 0 0 0 0 0
[   49.621672] ide-tape: hdd: invalid tape speed (assuming 650KB/sec)
[   49.621723] ide-tape: hdd: invalid max_speed (assuming 650KB/sec)
[   49.621789] idetape_do_request: cmd: 0x3, 13: 0x1, sector: 18446744073709551615, nr_sectors: 0, current_nr_sectors: 0
[   49.621857] idetape_do_request: tape->failed_pc: def45d58, pc->c[0]: 0x3
[   49.621909] this rq: dev hdd: type=7, flags=10440
[   49.621957]   sector 18446744073709551615, nr/cnr 0/0
[   49.622005]   bio (null), biotail (null), buffer de877db4, data (null), len 0
[   49.624819] idetape_do_request: cmd: 0x1a, 13: 0x1, sector: 18446744073709551615, nr_sectors: 0, current_nr_sectors: 0
[   49.624890] idetape_do_request: tape->failed_pc: (null), pc->c[0]: 0x1a
[   49.624942] this rq: dev hdd: type=7, flags=82640
[   49.624990]   sector 18446744073709551615, nr/cnr 0/0
[   49.625038]   bio (null), biotail (null), buffer def45bd4, data (null), len 0
[   49.627240] divide error: 0000 [#1] 
[   49.627317] last sysfs file: /sys/class/net/lo/operstate
[   49.627366] Modules linked in: ide_tape(+) ppdev lp ipv6 ipt_LOG nf_conntrack_ipv4 nf_defrag_ipv4 xt_state xt_tcpudp iptable_filter ip_tables x_tables nf_conntrack_ftp nf_conntrack snd_emu10k1_synth snd_emux_synth snd_seq_virmidi snd_seq_midi_emul snd_emu10k1 snd_ac97_codec ac97_bus snd_pcm_oss snd_mixer_oss snd_pcm snd_page_alloc snd_util_mem snd_hwdep snd_seq_dummy snd_seq_oss snd_seq_midi psmouse snd_rawmidi button snd_seq_midi_event vt8231 pcspkr serio_raw snd_seq amd_k7_agp i2c_viapro snd_timer snd_seq_device agpgart parport_pc i2c_core emu10k1_gp snd parport gameport amd76x_edac edac_core soundcore evdev ext3 jbd mbcache ide_cd_mod cdrom ide_gd_mod uhci_hcd via82cxxx ide_pci_generic floppy ide_core usbcore 3c59x mii thermal processor fan thermal_sys
[   49.629800] 
[   49.629843] Pid: 2482, comm: modprobe Not tainted (2.6.29-rc7 #1)  
[   49.629895] EIP: 0060:[<e0e8ac67>] EFLAGS: 00010256 CPU: 0
[   49.629957] EIP is at ide_tape_probe+0x594/0x641 [ide_tape]
[   49.630007] EAX: 00000000 EBX: decd1aac ECX: 00000000 EDX: 00000000
[   49.630061] ESI: 00002ee0 EDI: 00000400 EBP: de877c00 ESP: def45d20
[   49.630113]  DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 0068
[   49.630163] Process modprobe (pid: 2482, ti=def44000 task=deff1400 task.ti=def44000)
[   49.630222] Stack:
[   49.630262]  00000000 00000030 e0e8ce03 decd1ac6 decd1aac def45ec4 de877c90 df244000
[   49.630531]  00000000 decd1800 decd1ac4 decd1ab8 00000006 decd1800 002a081a 000000ff
[   49.630864]  00000000 00000003 00000000 00000018 00000014 def45d8c def45da0 00000100
[   49.631190] Call Trace:
[   49.631190]  [<c02383b7>] __driver_attach+0x0/0x67
[   49.631190]  [<e08bd0a0>] generic_ide_probe+0x1c/0x1d [ide_core]
[   49.631190]  [<c0238344>] driver_probe_device+0xb0/0x123
[   49.631190]  [<c0238400>] __driver_attach+0x49/0x67
[   49.631190]  [<c0237a88>] bus_for_each_dev+0x37/0x58
[   49.631190]  [<c02381e4>] driver_attach+0x11/0x13
[   49.631190]  [<c02383b7>] __driver_attach+0x0/0x67
[   49.631190]  [<c0237edf>] bus_add_driver+0x8a/0x1a5
[   49.631190]  [<c01d9b10>] kset_find_obj+0x18/0x40
[   49.631190]  [<e0e91000>] idetape_init+0x0/0x8f [ide_tape]
[   49.631190]  [<c0238575>] driver_register+0x6d/0xc1
[   49.631190]  [<e0e91000>] idetape_init+0x0/0x8f [ide_tape]
[   49.631190]  [<e0e91071>] idetape_init+0x71/0x8f [ide_tape]
[   49.631190]  [<c010112b>] _stext+0x43/0x107
[   49.631190]  [<c014a371>] tracepoint_module_notify+0x21/0x24
[   49.631190]  [<c012a868>] notifier_call_chain+0x2a/0x47
[   49.631190]  [<c012aa3e>] __blocking_notifier_call_chain+0x3f/0x49
[   49.631190]  [<c013572b>] sys_init_module+0x87/0x184
[   49.631190]  [<c0102a01>] sysenter_do_call+0x12/0x21
[   49.631190] Code: 03 00 00 52 ba fa 00 00 00 89 d7 31 d2 89 f0 f7 f7 ba 00 04 00 00 89 d7 50 89 c8 99 f7 ff 50 8b 54 24 2c 0f b7 42 10 c1 e0 09 99 <f7> f9 50 8b 4c 24 10 0f b7 01 50 53 55 68 04 ce e8 e0 e8 87 ff 
[   49.631190] EIP: [<e0e8ac67>] ide_tape_probe+0x594/0x641 [ide_tape] SS:ESP 0068:def45d20
[   49.635145] ---[ end trace 2904393b94cd648a ]---

--J/dobhs11T7y2rNN--
