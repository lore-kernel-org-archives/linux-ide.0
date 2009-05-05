From: Mark de Wever <koraq@xs4all.nl>
Subject: Re: [bug#12874] Seagate STT20000A no longer works
Date: Tue, 5 May 2009 23:12:59 +0200
Message-ID: <20090505211259.GA2723@localhost>
References: <9ea470500904200230k5f0ea050u7411b7c9d9be7098@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="7AUc2qLy4jB3hD7Z"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp-vbr10.xs4all.nl ([194.109.24.30]:4443 "EHLO
	smtp-vbr10.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751290AbZEEVQy (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 5 May 2009 17:16:54 -0400
Content-Disposition: inline
In-Reply-To: <9ea470500904200230k5f0ea050u7411b7c9d9be7098@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: petkovbb@gmail.com
Cc: sshtylyov@ru.mvista.com, bzolnier@gmail.com, linux-ide@vger.kernel.org, TejunHeo <tj@kernel.org>, Mark de Wever <koraq@xs4all.nl>


--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 20, 2009 at 11:30:08AM +0200, Borislav Petkov wrote:
> Hi,

Hi,

> sorry for the delay but I was busy with ide stuff. 

No problem, I've been quite busy myself as well.

> In the mean time, Tejun has fixed some ide-tape bugs and has a git
> tree so if you don't want to wait for the fixes to trickle upstream
> and are eager to test :) you could pull from
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/tj/misc.git ide-phase2

I compiled 2.6.30-rc4 + ide-phase2 +  your 'tmp fix 2' patch +
IDETAPE_DEBUG_LOG set to 1

Your other patches gave merge and compilation problems. ide-phase2 also
has a problem when I set IDETAPE_DEBUG_LOG to 1, but that one was
trivial to fix. (I'll send the patch as reply to this post.)

The dmesg contains some errors about hdc and after a modprobe of
ide-tape the system freezes and I need to use SysRq to reboot the
system. So the attached dmesg contains no info about the modprobe.
So I fear the dmesg is not too useful, what would you like me to test
next?

Regards,
Mark de Wever

--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=dmesg

[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Linux version 2.6.30-rc4 (root@spearhead) (gcc version 4.1.3 20080704 (prerelease) (Debian 4.1.2-25)) #1 Mon May 4 20:33:47 CEST 2009
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
[    0.000000] MTRR default type: uncachable
[    0.000000] MTRR fixed ranges enabled:
[    0.000000]   00000-9FFFF write-back
[    0.000000]   A0000-BFFFF uncachable
[    0.000000]   C0000-C7FFF write-protect
[    0.000000]   C8000-FFFFF uncachable
[    0.000000] MTRR variable ranges enabled:
[    0.000000]   0 base 000000000 mask FE0000000 write-back
[    0.000000]   1 disabled
[    0.000000]   2 disabled
[    0.000000]   3 disabled
[    0.000000]   4 disabled
[    0.000000]   5 base 0D0000000 mask FF8000000 write-combining
[    0.000000]   6 disabled
[    0.000000]   7 disabled
[    0.000000] init_memory_mapping: 0000000000000000-000000001fff0000
[    0.000000]  0000000000 - 0000400000 page 4k
[    0.000000]  0000400000 - 001fc00000 page 2M
[    0.000000]  001fc00000 - 001fff0000 page 4k
[    0.000000] kernel direct mapping tables up to 1fff0000 @ 7000-c000
[    0.000000] RAMDISK: 1fc6f000 - 1ffdf298
[    0.000000] ACPI: RSDP 000f7000 00014 (v00 AMDVIA)
[    0.000000] ACPI: RSDT 1fff3000 00028 (v01 AMDVIA AWRDACPI 42302E31 AWRD 00000000)
[    0.000000] ACPI: FACP 1fff3040 00074 (v01 AMDVIA AWRDACPI 42302E31 AWRD 00000000)
[    0.000000] ACPI: DSDT 1fff30c0 022E0 (v01 AMDVIA AWRDACPI 00001000 MSFT 0100000C)
[    0.000000] ACPI: FACS 1fff0000 00040
[    0.000000] 0MB HIGHMEM available.
[    0.000000] 511MB LOWMEM available.
[    0.000000]   mapped low ram: 0 - 1fff0000
[    0.000000]   low ram: 0 - 1fff0000
[    0.000000]   node 0 low ram: 00000000 - 1fff0000
[    0.000000]   node 0 bootmap 00001000 - 00005000
[    0.000000] (7 early reservations) ==> bootmem [0000000000 - 001fff0000]
[    0.000000]   #0 [0000000000 - 0000001000]   BIOS data page ==> [0000000000 - 0000001000]
[    0.000000]   #1 [0000100000 - 000045fa2c]    TEXT DATA BSS ==> [0000100000 - 000045fa2c]
[    0.000000]   #2 [001fc6f000 - 001ffdf298]          RAMDISK ==> [001fc6f000 - 001ffdf298]
[    0.000000]   #3 [000009fc00 - 0000100000]    BIOS reserved ==> [000009fc00 - 0000100000]
[    0.000000]   #4 [0000460000 - 0000462076]              BRK ==> [0000460000 - 0000462076]
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
[    0.000000] free_area_init_node: node 0, pgdat c0394280, node_mem_map c1000000
[    0.000000]   DMA zone: 32 pages used for memmap
[    0.000000]   DMA zone: 0 pages reserved
[    0.000000]   DMA zone: 3967 pages, LIFO batch:0
[    0.000000]   Normal zone: 992 pages used for memmap
[    0.000000]   Normal zone: 125968 pages, LIFO batch:31
[    0.000000] Using APIC driver default
[    0.000000] ACPI: PM-Timer IO Port: 0x4008
[    0.000000] Local APIC disabled by BIOS -- you can enable it with "lapic"
[    0.000000] nr_irqs_gsi: 16
[    0.000000] PM: Registered nosave memory: 000000000009f000 - 00000000000a0000
[    0.000000] PM: Registered nosave memory: 00000000000a0000 - 00000000000f0000
[    0.000000] PM: Registered nosave memory: 00000000000f0000 - 0000000000100000
[    0.000000] Allocating PCI resources starting at 30000000 (gap: 20000000:dfff0000)
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 129935
[    0.000000] Kernel command line: root=/dev/hda6 ro 
[    0.000000] Enabling fast FPU save and restore... done.
[    0.000000] Enabling unmasked SIMD FPU exception support... done.
[    0.000000] Initializing CPU#0
[    0.000000] NR_IRQS:288
[    0.000000] PID hash table entries: 2048 (order: 11, 8192 bytes)
[    0.000000] Fast TSC calibration using PIT
[    0.000000] Detected 1211.919 MHz processor.
[    0.004000] Console: colour VGA+ 80x25
[    0.004000] console [tty0] enabled
[    0.004000] Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
[    0.004000] Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
[    0.004000] Initializing HighMem for node 0 (00000000:00000000)
[    0.004000] Memory: 512084k/524224k available (1785k kernel code, 11524k reserved, 893k data, 268k init, 0k highmem)
[    0.004000] virtual kernel memory layout:
[    0.004000]     fixmap  : 0xfffaa000 - 0xfffff000   ( 340 kB)
[    0.004000]     pkmap   : 0xff800000 - 0xffc00000   (4096 kB)
[    0.004000]     vmalloc : 0xe07f0000 - 0xff7fe000   ( 496 MB)
[    0.004000]     lowmem  : 0xc0000000 - 0xdfff0000   ( 511 MB)
[    0.004000]       .init : 0xc03a0000 - 0xc03e3000   ( 268 kB)
[    0.004000]       .data : 0xc02be4f1 - 0xc039da08   ( 893 kB)
[    0.004000]       .text : 0xc0100000 - 0xc02be4f1   (1785 kB)
[    0.004000] Checking if this processor honours the WP bit even in supervisor mode...Ok.
[    0.004015] Calibrating delay loop (skipped), value calculated using timer frequency.. 2423.83 BogoMIPS (lpj=4847676)
[    0.004165] Security Framework initialized
[    0.004219] SELinux:  Disabled at boot.
[    0.004284] Mount-cache hash table entries: 512
[    0.004522] Initializing cgroup subsys ns
[    0.004574] Initializing cgroup subsys cpuacct
[    0.004623] Initializing cgroup subsys devices
[    0.004692] CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
[    0.004747] CPU: L2 Cache: 256K (64 bytes/line)
[    0.004798] Intel machine check architecture supported.
[    0.004848] Intel machine check reporting enabled on CPU#0.
[    0.004911] CPU: AMD Athlon(tm) XP stepping 02
[    0.005026] Checking 'hlt' instruction... OK.
[    0.020291] ACPI: Core revision 20090320
[    0.026213] ACPI: setting ELCR to 0200 (from 0e28)
[    0.028032] net_namespace: 1076 bytes
[    0.028538] NET: Registered protocol family 16
[    0.029170] ACPI: bus type pci registered
[    0.047921] PCI: PCI BIOS revision 2.10 entry at 0xfb3b0, last bus=1
[    0.047975] PCI: Using configuration type 1 for base access
[    0.049877] bio: create slab <bio-0> at 0
[    0.050469] ACPI: EC: Look up EC in DSDT
[    0.055268] ACPI: Interpreter enabled
[    0.055321] ACPI: (supports S0 S1 S4 S5)
[    0.055526] ACPI: Using PIC for interrupt routing
[    0.061578] ACPI: No dock devices found.
[    0.061650] ACPI: PCI Root Bridge [PCI0] (0000:00)
[    0.061821] pci 0000:00:00.0: reg 10 32bit mmio: [0xd0000000-0xd7ffffff]
[    0.061831] pci 0000:00:00.0: reg 14 32bit mmio: [0xe3001000-0xe3001fff]
[    0.061840] pci 0000:00:00.0: reg 18 io port: [0xc000-0xc003]
[    0.061929] pci 0000:00:09.0: reg 10 io port: [0xc400-0xc47f]
[    0.061938] pci 0000:00:09.0: reg 14 32bit mmio: [0xe3000000-0xe300007f]
[    0.061959] pci 0000:00:09.0: reg 30 32bit mmio: [0x000000-0x01ffff]
[    0.061976] pci 0000:00:09.0: supports D1 D2
[    0.061981] pci 0000:00:09.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.062036] pci 0000:00:09.0: PME# disabled
[    0.062111] pci 0000:00:0a.0: reg 10 io port: [0xc800-0xc81f]
[    0.062145] pci 0000:00:0a.0: supports D1 D2
[    0.062176] pci 0000:00:0a.1: reg 10 io port: [0xcc00-0xcc07]
[    0.062210] pci 0000:00:0a.1: supports D1 D2
[    0.062246] pci 0000:00:0b.0: reg 10 io port: [0xd000-0xd07f]
[    0.062255] pci 0000:00:0b.0: reg 14 32bit mmio: [0xe3002000-0xe300207f]
[    0.062276] pci 0000:00:0b.0: reg 30 32bit mmio: [0x000000-0x01ffff]
[    0.062292] pci 0000:00:0b.0: supports D1 D2
[    0.062296] pci 0000:00:0b.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.062350] pci 0000:00:0b.0: PME# disabled
[    0.062502] pci 0000:00:11.1: reg 20 io port: [0xd400-0xd40f]
[    0.062566] pci 0000:00:11.2: reg 20 io port: [0xd800-0xd81f]
[    0.062627] pci 0000:00:11.3: reg 20 io port: [0xdc00-0xdc1f]
[    0.062764] pci 0000:01:05.0: reg 10 32bit mmio: [0xe0000000-0xe0ffffff]
[    0.062773] pci 0000:01:05.0: reg 14 32bit mmio: [0xd8000000-0xdfffffff]
[    0.062793] pci 0000:01:05.0: reg 30 32bit mmio: [0x000000-0x00ffff]
[    0.062842] pci 0000:00:01.0: bridge 32bit mmio: [0xe0000000-0xe1ffffff]
[    0.062849] pci 0000:00:01.0: bridge 32bit mmio pref: [0xd8000000-0xdfffffff]
[    0.062860] pci_bus 0000:00: on NUMA node 0
[    0.062871] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[    0.083082] ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 *5 6 7 10 11 12 14 15)
[    0.083795] ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 5 6 7 *10 11 12 14 15)
[    0.084537] ACPI: PCI Interrupt Link [LNKC] (IRQs 1 *3 4 5 6 7 10 11 12 14 15)
[    0.085249] ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 5 6 7 10 *11 12 14 15)
[    0.086224] PCI: Using ACPI for IRQ routing
[    0.086723] pnp: PnP ACPI init
[    0.086782] ACPI: bus type pnp registered
[    0.091178] pnp: PnP ACPI: found 12 devices
[    0.091230] ACPI: ACPI bus type pnp unregistered
[    0.091283] PnPBIOS: Disabled by ACPI PNP
[    0.091349] system 00:00: iomem range 0xd1800-0xd3fff has been reserved
[    0.091405] system 00:00: iomem range 0xf0000-0xf7fff could not be reserved
[    0.091460] system 00:00: iomem range 0xf8000-0xfbfff could not be reserved
[    0.091517] system 00:00: iomem range 0xfc000-0xfffff could not be reserved
[    0.091573] system 00:00: iomem range 0x1fff0000-0x1fffffff could not be reserved
[    0.091635] system 00:00: iomem range 0xffff0000-0xffffffff has been reserved
[    0.091691] system 00:00: iomem range 0xffc00000-0xfffe8fff has been reserved
[    0.091747] system 00:00: iomem range 0x0-0x9ffff could not be reserved
[    0.091804] system 00:00: iomem range 0x100000-0x1ffeffff could not be reserved
[    0.091867] system 00:00: iomem range 0xfee00000-0xfee00fff has been reserved
[    0.091930] system 00:02: ioport range 0x4d0-0x4d1 has been reserved
[    0.127256] pci 0000:00:01.0: PCI bridge, secondary bus 0000:01
[    0.127309] pci 0000:00:01.0:   IO window: disabled
[    0.127363] pci 0000:00:01.0:   MEM window: 0xe0000000-0xe1ffffff
[    0.127417] pci 0000:00:01.0:   PREFETCH window: 0x000000d8000000-0x000000dfffffff
[    0.127493] pci_bus 0000:00: resource 0 io:  [0x00-0xffff]
[    0.127498] pci_bus 0000:00: resource 1 mem: [0x000000-0xffffffff]
[    0.127505] pci_bus 0000:01: resource 1 mem: [0xe0000000-0xe1ffffff]
[    0.127511] pci_bus 0000:01: resource 2 pref mem [0xd8000000-0xdfffffff]
[    0.127599] NET: Registered protocol family 2
[    0.127802] IP route cache hash table entries: 4096 (order: 2, 16384 bytes)
[    0.128360] TCP established hash table entries: 16384 (order: 5, 131072 bytes)
[    0.128761] TCP bind hash table entries: 16384 (order: 4, 65536 bytes)
[    0.128983] TCP: Hash tables configured (established 16384 bind 16384)
[    0.129036] TCP reno registered
[    0.129195] NET: Registered protocol family 1
[    0.129360] checking if image is initramfs...
[    0.315101] rootfs image is initramfs; unpacking...
[    0.315239] Freeing initrd memory: 3520k freed
[    0.324860] audit: initializing netlink socket (disabled)
[    0.324945] type=2000 audit(1241554849.324:1): initialized
[    0.325268] HugeTLB registered 4 MB page size, pre-allocated 0 pages
[    0.325416] VFS: Disk quotas dquot_6.5.2
[    0.325516] Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
[    0.325653] msgmni has been set to 1007
[    0.325951] alg: No test for stdrng (krng)
[    0.326094] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 253)
[    0.326157] io scheduler noop registered
[    0.326204] io scheduler anticipatory registered
[    0.326253] io scheduler deadline registered
[    0.326310] io scheduler cfq registered (default)
[    0.326417] pci 0000:01:05.0: Boot video device
[    0.327080] isapnp: Scanning for PnP cards...
[    0.628055] Switched to high resolution mode on CPU 0
[    0.680525] isapnp: No Plug & Play device found
[    0.685415] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    0.685671] serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[    0.686453] 00:08: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[    0.690344] brd: module loaded
[    0.690573] PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
[    0.691709] serio: i8042 KBD port at 0x60,0x64 irq 1
[    0.691766] serio: i8042 AUX port at 0x60,0x64 irq 12
[    0.692142] mice: PS/2 mouse device common for all mice
[    0.692320] rtc_cmos 00:04: RTC can wake from S4
[    0.692508] rtc_cmos 00:04: rtc core: registered rtc_cmos as rtc0
[    0.692584] rtc0: alarms up to one year, y3k, 242 bytes nvram
[    0.692694] cpuidle: using governor ladder
[    0.692742] cpuidle: using governor menu
[    0.692795] No iBFT detected.
[    0.693475] TCP cubic registered
[    0.693522] NET: Registered protocol family 17
[    0.693592] Using IPI Shortcut mode
[    0.693874] registered taskstats version 1
[    0.694160] rtc_cmos 00:04: setting system clock to 2009-05-05 20:20:49 UTC (1241554849)
[    0.694307] Freeing unused kernel memory: 268k freed
[    0.711523] input: AT Translated Set 2 keyboard as /class/input/input0
[    1.533600] Uniform Multi-Platform E-IDE driver
[    1.588697] ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 10
[    1.588762] PCI: setting IRQ 10 as level-triggered
[    1.588774] 3c59x 0000:00:09.0: PCI INT A -> Link[LNKB] -> GSI 10 (level, low) -> IRQ 10
[    1.588860] 3c59x: Donald Becker and others.
[    1.588919] 0000:00:09.0: 3Com PCI 3c905C Tornado at e08d8000.
[    1.820161] usbcore: registered new interface driver usbfs
[    1.820278] usbcore: registered new interface driver hub
[    1.820406] usbcore: registered new device driver usb
[    1.824235] uhci_hcd: USB Universal Host Controller Interface driver
[    1.850216] ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
[    1.850279] PCI: setting IRQ 11 as level-triggered
[    1.850291] 3c59x 0000:00:0b.0: PCI INT A -> Link[LNKD] -> GSI 11 (level, low) -> IRQ 11
[    1.850388] 0000:00:0b.0: 3Com PCI 3c905C Tornado at e08f8000.
[    1.872260] uhci_hcd 0000:00:11.2: PCI INT D -> Link[LNKD] -> GSI 11 (level, low) -> IRQ 11
[    1.872334] uhci_hcd 0000:00:11.2: UHCI Host Controller
[    1.872464] uhci_hcd 0000:00:11.2: new USB bus registered, assigned bus number 1
[    1.872557] uhci_hcd 0000:00:11.2: irq 11, io base 0x0000d800
[    1.872688] usb usb1: New USB device found, idVendor=1d6b, idProduct=0001
[    1.872745] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.872804] usb usb1: Product: UHCI Host Controller
[    1.872854] usb usb1: Manufacturer: Linux 2.6.30-rc4 uhci_hcd
[    1.872904] usb usb1: SerialNumber: 0000:00:11.2
[    1.873073] usb usb1: configuration #1 chosen from 1 choice
[    1.873182] hub 1-0:1.0: USB hub found
[    1.873251] hub 1-0:1.0: 2 ports detected
[    1.873498] uhci_hcd 0000:00:11.3: PCI INT D -> Link[LNKD] -> GSI 11 (level, low) -> IRQ 11
[    1.873567] uhci_hcd 0000:00:11.3: UHCI Host Controller
[    1.873657] uhci_hcd 0000:00:11.3: new USB bus registered, assigned bus number 2
[    1.873737] uhci_hcd 0000:00:11.3: irq 11, io base 0x0000dc00
[    1.873849] usb usb2: New USB device found, idVendor=1d6b, idProduct=0001
[    1.873904] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.873964] usb usb2: Product: UHCI Host Controller
[    1.874014] usb usb2: Manufacturer: Linux 2.6.30-rc4 uhci_hcd
[    1.874065] usb usb2: SerialNumber: 0000:00:11.3
[    1.874200] usb usb2: configuration #1 chosen from 1 choice
[    1.874305] hub 2-0:1.0: USB hub found
[    1.874364] hub 2-0:1.0: 2 ports detected
[    1.878603] via82cxxx 0000:00:11.1: VIA vt8231 (rev 10) IDE UDMA100
[    1.878671] via82cxxx 0000:00:11.1: IDE controller (0x1106:0x0571 rev 0x06)
[    1.878772] via82cxxx 0000:00:11.1: not 100% native mode: will probe irqs later
[    1.878838]     ide0: BM-DMA at 0xd400-0xd407
[    1.878897]     ide1: BM-DMA at 0xd408-0xd40f
[    1.878949] Probing IDE interface ide0...
[    1.940651] Floppy drive(s): fd0 is 1.44M
[    1.959719] FDC 0 is a post-1991 82077
[    2.164242] hda: Maxtor 6L160P0, ATA DISK drive
[    2.836125] hda: host max PIO5 wanted PIO255(auto-tune) selected PIO4
[    2.837630] hda: UDMA/100 mode selected
[    2.839189] Probing IDE interface ide1...
[    3.576219] hdc: PLEXTOR CD-R PX-W4824A, ATAPI CD/DVD-ROM drive
[    4.416032] hdd: Seagate STT20000A, ATAPI TAPE drive
[    4.416196] hdc: host max PIO5 wanted PIO255(auto-tune) selected PIO4
[    4.416298] hdc: MWDMA2 mode selected
[    4.416416] hdd: host max PIO5 wanted PIO255(auto-tune) selected PIO4
[    4.417112] hdd: Disabling (U)DMA for Seagate STT20000A (blacklisted)
[    4.417165] hdd: host max PIO5 wanted PIO255(auto-tune) selected PIO4
[    4.418245] ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
[    4.418360] ide1 at 0x170-0x177,0x376 on irq 15
[    4.459862] ide-gd driver 1.18
[    4.459980] hda: max request size: 512KiB
[    4.496052] hda: 320173056 sectors (163928 MB) w/8192KiB Cache, CHS=19929/255/63
[    4.503908] ide-cd driver 5.00
[    4.504839] hda: cache flushes supported
[    4.504993]  hda: hda1 hda2 < hda5 hda6 hda7 hda8 hda9 hda10 >
[    4.587557] ide-cd: hdc: ATAPI 40X CD-ROM CD-R/RW drive, 4096kB Cache
[    4.587776] Uniform CD-ROM driver Revision: 3.20
[    4.588491] hdc: command error: status=0x51 { DriveReady SeekComplete Error }
[    4.588671] hdc: command error: error=0x54 <3>{ AbortedCommand LastFailedSense=0x05 }
[    4.588855] ide: failed opcode was: unknown
[    4.631232] hdc: command error: status=0x51 { DriveReady SeekComplete Error }
[    4.631420] hdc: command error: error=0x54 <3>{ AbortedCommand LastFailedSense=0x05 }
[    4.631603] ide: failed opcode was: unknown
[    4.636069] hdc: command error: status=0x51 { DriveReady SeekComplete Error }
[    4.636255] hdc: command error: error=0x54 <3>{ AbortedCommand LastFailedSense=0x05 }
[    4.636438] ide: failed opcode was: unknown
[    5.012601] PM: Starting manual resume from disk
[    5.061063] EXT3-fs: INFO: recovery required on readonly filesystem.
[    5.061126] EXT3-fs: write access will be enabled during recovery.
[    5.121919] kjournald starting.  Commit interval 5 seconds
[    5.122000] EXT3-fs: recovery complete.
[    5.122325] EXT3-fs: mounted filesystem with writeback data mode.
[    7.366757] udevd version 125 started
[    7.806125] hdc: command error: status=0x51 { DriveReady SeekComplete Error }
[    7.806318] hdc: command error: error=0x54 <3>{ AbortedCommand LastFailedSense=0x05 }
[    7.806501] ide: failed opcode was: unknown
[    9.597571] input: PC Speaker as /class/input/input1
[    9.628458] gameport: EMU10K1 is pci0000:00:0a.1/gameport0, io 0xcc00, speed 1242kHz
[    9.647249] EDAC MC: Ver: 2.1.0 May  4 2009
[    9.656670] parport_pc: VIA 686A/8231 detected
[    9.656677] parport_pc: probing current configuration
[    9.656695] parport_pc: Current parallel port base: 0x378
[    9.656744] parport0: PC-style at 0x378, irq 7 [PCSPP,EPP]
[    9.736154] parport_pc: VIA parallel port: io=0x378, irq=7
[    9.743563] EDAC MC0: Giving out device to 'amd76x_edac' 'AMD761': DEV 0000:00:00.0
[    9.743677] EDAC PCI0: Giving out device to module 'amd76x_edac' controller 'EDAC PCI controller': DEV '0000:00:00.0' (POLLED)
[   10.108821] Linux agpgart interface v0.103
[   10.582751] Marking TSC unstable due to TSC halts in idle
[   10.582864] processor ACPI_CPU:00: registered as cooling_device0
[   10.582919] ACPI: Processor [CPU0] (supports 2 throttling states)
[   10.761722] input: Power Button as /class/input/input2
[   10.761853] ACPI: Power Button [PWRF]
[   10.762027] input: Power Button as /class/input/input3
[   10.762111] ACPI: Power Button [PWRB]
[   10.762270] input: Sleep Button as /class/input/input4
[   10.762357] ACPI: Sleep Button [SLPB]
[   11.155377] input: PS/2 Logitech Mouse as /class/input/input5
[   12.125343] ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 3
[   12.125408] PCI: setting IRQ 3 as level-triggered
[   12.125420] EMU10K1_Audigy 0000:00:0a.0: PCI INT A -> Link[LNKC] -> GSI 3 (level, low) -> IRQ 3
[   12.138944] Control name 'Sigmatel Surround Phase Inversion Playback Switch' truncated to 'Sigmatel Surround Phase Inversion Playback '
[   13.866546] Adding 497972k swap on /dev/hda5.  Priority:-1 extents:1 across:497972k 
[   14.146428] EXT3 FS on hda6, internal journal
[   15.970595] kjournald starting.  Commit interval 5 seconds
[   15.970816] EXT3 FS on hda7, internal journal
[   15.970899] EXT3-fs: mounted filesystem with writeback data mode.
[   16.035971] kjournald starting.  Commit interval 5 seconds
[   16.036223] EXT3 FS on hda8, internal journal
[   16.036305] EXT3-fs: mounted filesystem with writeback data mode.
[   16.100799] kjournald starting.  Commit interval 5 seconds
[   16.101037] EXT3 FS on hda10, internal journal
[   16.101119] EXT3-fs: mounted filesystem with writeback data mode.
[   16.928656] nf_conntrack version 0.5.0 (8191 buckets, 32764 max)
[   16.928974] CONFIG_NF_CT_ACCT is deprecated and will be removed soon. Please use
[   16.929034] nf_conntrack.acct=1 kernel paramater, acct=1 nf_conntrack module option or
[   16.929094] sysctl net.netfilter.nf_conntrack_acct=1 to enable it.
[   17.015809] ip_tables: (C) 2000-2006 Netfilter Core Team
[   17.904935] eth0:  setting full-duplex.
[   23.544567] NET: Registered protocol family 10
[   23.545638] lo: Disabled Privacy Extensions
[   26.266225] lp0: using parport0 (interrupt-driven).
[   26.301621] ppdev: user-space parallel port driver
[   33.600030] eth0: no IPv6 routers present

--7AUc2qLy4jB3hD7Z--
