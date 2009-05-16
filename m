From: Mark de Wever <koraq@xs4all.nl>
Subject: Re: [bug#12874] Seagate STT20000A no longer works
Date: Sat, 16 May 2009 10:25:40 +0200
Message-ID: <20090516082540.GA2760@localhost>
References: <9ea470500904200230k5f0ea050u7411b7c9d9be7098@mail.gmail.com> <20090505211259.GA2723@localhost> <20090506061121.GB3406@liondog.tnic>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Dxnq1zWXvFF0Q93v"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp-vbr5.xs4all.nl ([194.109.24.25]:3596 "EHLO
	smtp-vbr5.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752734AbZEPI3c (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 16 May 2009 04:29:32 -0400
Content-Disposition: inline
In-Reply-To: <20090506061121.GB3406@liondog.tnic>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: petkovbb@gmail.com
Cc: Mark de Wever <koraq@xs4all.nl>, sshtylyov@ru.mvista.com, bzolnier@gmail.com, linux-ide@vger.kernel.org, TejunHeo <tj@kernel.org>


--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 06, 2009 at 08:11:21AM +0200, Borislav Petkov wrote:
> On Tue, May 05, 2009 at 11:12:59PM +0200, Mark de Wever wrote:
> > > In the mean time, Tejun has fixed some ide-tape bugs and has a git
> > > tree so if you don't want to wait for the fixes to trickle upstream
> > > and are eager to test :) you could pull from
> > > 
> > > git://git.kernel.org/pub/scm/linux/kernel/git/tj/misc.git ide-phase2
> > 
> > I compiled 2.6.30-rc4 + ide-phase2 +  your 'tmp fix 2' patch +
> > IDETAPE_DEBUG_LOG set to 1
> 
> Actually, I meant only the Tejun tree without my patches. Please retry again if
> you have the time or just wait a bit - I finally got an ide tape myself :) :

That's good to hear :-)

I also managed retested the drive, this time with
2.6.30-rc5 + ide-phase2 + my ide-phase2 compilation fix patch
+ IDETAPE_DEBUG_LOG

This combination seems to work :-) I wrote a small file to the tape and
could read it again.

After this test I played and tried some more things and got another
kernel warning. I haven't been able to reproduce this consistently but
it seems to occur after playing a bit with:
- writing a file to the drive
- use rewind on the drive
- use fsf 1 on the drive
- reading a file from the drive
(I know fsf 1 on /dev/ht0 is rather useless ;-))
I think this problem is not related with the problems I had before,
attached the entire dmesg, from boot to the kernel message. If you
want I can try to find a way to reproduce it.

Thanks for your effort to get the drive working again.

-- 
Regards,
Mark de Wever

--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=dmesg

[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Linux version 2.6.30-rc5 (root@spearhead) (gcc version 4.1.3 20080704 (prerelease) (Debian 4.1.2-25)) #1 Mon May 11 20:11:51 CEST 2009
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
[    0.000000] RAMDISK: 1fc6f000 - 1ffdf792
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
[    0.000000]   #2 [001fc6f000 - 001ffdf792]          RAMDISK ==> [001fc6f000 - 001ffdf792]
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
[    0.000000] free_area_init_node: node 0, pgdat c03942a0, node_mem_map c1000000
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
[    0.004000] Memory: 512084k/524224k available (1783k kernel code, 11524k reserved, 894k data, 268k init, 0k highmem)
[    0.004000] virtual kernel memory layout:
[    0.004000]     fixmap  : 0xfffaa000 - 0xfffff000   ( 340 kB)
[    0.004000]     pkmap   : 0xff800000 - 0xffc00000   (4096 kB)
[    0.004000]     vmalloc : 0xe07f0000 - 0xff7fe000   ( 496 MB)
[    0.004000]     lowmem  : 0xc0000000 - 0xdfff0000   ( 511 MB)
[    0.004000]       .init : 0xc03a0000 - 0xc03e3000   ( 268 kB)
[    0.004000]       .data : 0xc02bdf39 - 0xc039da08   ( 894 kB)
[    0.004000]       .text : 0xc0100000 - 0xc02bdf39   (1783 kB)
[    0.004000] Checking if this processor honours the WP bit even in supervisor mode...Ok.
[    0.004014] Calibrating delay loop (skipped), value calculated using timer frequency.. 2423.83 BogoMIPS (lpj=4847676)
[    0.004164] Security Framework initialized
[    0.004219] SELinux:  Disabled at boot.
[    0.004282] Mount-cache hash table entries: 512
[    0.004516] Initializing cgroup subsys ns
[    0.004568] Initializing cgroup subsys cpuacct
[    0.004617] Initializing cgroup subsys devices
[    0.004686] CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
[    0.004740] CPU: L2 Cache: 256K (64 bytes/line)
[    0.004791] Intel machine check architecture supported.
[    0.004840] Intel machine check reporting enabled on CPU#0.
[    0.004903] CPU: AMD Athlon(tm) XP stepping 02
[    0.005018] Checking 'hlt' instruction... OK.
[    0.020292] ACPI: Core revision 20090320
[    0.026235] ACPI: setting ELCR to 0200 (from 0e28)
[    0.028062] net_namespace: 1076 bytes
[    0.028570] NET: Registered protocol family 16
[    0.029203] ACPI: bus type pci registered
[    0.047941] PCI: PCI BIOS revision 2.10 entry at 0xfb3b0, last bus=1
[    0.048005] PCI: Using configuration type 1 for base access
[    0.049914] bio: create slab <bio-0> at 0
[    0.050540] ACPI: EC: Look up EC in DSDT
[    0.055531] ACPI: Interpreter enabled
[    0.055584] ACPI: (supports S0 S1 S4 S5)
[    0.055786] ACPI: Using PIC for interrupt routing
[    0.062014] ACPI: No dock devices found.
[    0.062087] ACPI: PCI Root Bridge [PCI0] (0000:00)
[    0.062257] pci 0000:00:00.0: reg 10 32bit mmio: [0xd0000000-0xd7ffffff]
[    0.062267] pci 0000:00:00.0: reg 14 32bit mmio: [0xe3001000-0xe3001fff]
[    0.062276] pci 0000:00:00.0: reg 18 io port: [0xc000-0xc003]
[    0.062365] pci 0000:00:09.0: reg 10 io port: [0xc400-0xc47f]
[    0.062374] pci 0000:00:09.0: reg 14 32bit mmio: [0xe3000000-0xe300007f]
[    0.062395] pci 0000:00:09.0: reg 30 32bit mmio: [0x000000-0x01ffff]
[    0.062412] pci 0000:00:09.0: supports D1 D2
[    0.062417] pci 0000:00:09.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.062472] pci 0000:00:09.0: PME# disabled
[    0.062546] pci 0000:00:0a.0: reg 10 io port: [0xc800-0xc81f]
[    0.062581] pci 0000:00:0a.0: supports D1 D2
[    0.062613] pci 0000:00:0a.1: reg 10 io port: [0xcc00-0xcc07]
[    0.062647] pci 0000:00:0a.1: supports D1 D2
[    0.062683] pci 0000:00:0b.0: reg 10 io port: [0xd000-0xd07f]
[    0.062692] pci 0000:00:0b.0: reg 14 32bit mmio: [0xe3002000-0xe300207f]
[    0.062713] pci 0000:00:0b.0: reg 30 32bit mmio: [0x000000-0x01ffff]
[    0.062729] pci 0000:00:0b.0: supports D1 D2
[    0.062734] pci 0000:00:0b.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.062788] pci 0000:00:0b.0: PME# disabled
[    0.062939] pci 0000:00:11.1: reg 20 io port: [0xd400-0xd40f]
[    0.063005] pci 0000:00:11.2: reg 20 io port: [0xd800-0xd81f]
[    0.063066] pci 0000:00:11.3: reg 20 io port: [0xdc00-0xdc1f]
[    0.063204] pci 0000:01:05.0: reg 10 32bit mmio: [0xe0000000-0xe0ffffff]
[    0.063213] pci 0000:01:05.0: reg 14 32bit mmio: [0xd8000000-0xdfffffff]
[    0.063233] pci 0000:01:05.0: reg 30 32bit mmio: [0x000000-0x00ffff]
[    0.063281] pci 0000:00:01.0: bridge 32bit mmio: [0xe0000000-0xe1ffffff]
[    0.063289] pci 0000:00:01.0: bridge 32bit mmio pref: [0xd8000000-0xdfffffff]
[    0.063299] pci_bus 0000:00: on NUMA node 0
[    0.063311] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[    0.084529] ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 *5 6 7 10 11 12 14 15)
[    0.085259] ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 5 6 7 *10 11 12 14 15)
[    0.085982] ACPI: PCI Interrupt Link [LNKC] (IRQs 1 *3 4 5 6 7 10 11 12 14 15)
[    0.086703] ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 5 6 7 10 *11 12 14 15)
[    0.087690] PCI: Using ACPI for IRQ routing
[    0.088219] pnp: PnP ACPI init
[    0.088277] ACPI: bus type pnp registered
[    0.092851] pnp: PnP ACPI: found 12 devices
[    0.092904] ACPI: ACPI bus type pnp unregistered
[    0.092956] PnPBIOS: Disabled by ACPI PNP
[    0.093023] system 00:00: iomem range 0xd1800-0xd3fff has been reserved
[    0.093079] system 00:00: iomem range 0xf0000-0xf7fff could not be reserved
[    0.093134] system 00:00: iomem range 0xf8000-0xfbfff could not be reserved
[    0.093190] system 00:00: iomem range 0xfc000-0xfffff could not be reserved
[    0.093246] system 00:00: iomem range 0x1fff0000-0x1fffffff could not be reserved
[    0.093308] system 00:00: iomem range 0xffff0000-0xffffffff has been reserved
[    0.093364] system 00:00: iomem range 0xffc00000-0xfffe8fff has been reserved
[    0.093420] system 00:00: iomem range 0x0-0x9ffff could not be reserved
[    0.093475] system 00:00: iomem range 0x100000-0x1ffeffff could not be reserved
[    0.093536] system 00:00: iomem range 0xfee00000-0xfee00fff has been reserved
[    0.093600] system 00:02: ioport range 0x4d0-0x4d1 has been reserved
[    0.128886] pci 0000:00:01.0: PCI bridge, secondary bus 0000:01
[    0.128939] pci 0000:00:01.0:   IO window: disabled
[    0.128993] pci 0000:00:01.0:   MEM window: 0xe0000000-0xe1ffffff
[    0.129047] pci 0000:00:01.0:   PREFETCH window: 0x000000d8000000-0x000000dfffffff
[    0.129123] pci_bus 0000:00: resource 0 io:  [0x00-0xffff]
[    0.129129] pci_bus 0000:00: resource 1 mem: [0x000000-0xffffffff]
[    0.129135] pci_bus 0000:01: resource 1 mem: [0xe0000000-0xe1ffffff]
[    0.129141] pci_bus 0000:01: resource 2 pref mem [0xd8000000-0xdfffffff]
[    0.129232] NET: Registered protocol family 2
[    0.129454] IP route cache hash table entries: 4096 (order: 2, 16384 bytes)
[    0.130053] TCP established hash table entries: 16384 (order: 5, 131072 bytes)
[    0.130452] TCP bind hash table entries: 16384 (order: 4, 65536 bytes)
[    0.130676] TCP: Hash tables configured (established 16384 bind 16384)
[    0.130729] TCP reno registered
[    0.130889] NET: Registered protocol family 1
[    0.131058] Trying to unpack rootfs image as initramfs...
[    0.317330] Freeing initrd memory: 3521k freed
[    0.326928] audit: initializing netlink socket (disabled)
[    0.327011] type=2000 audit(1242459091.324:1): initialized
[    0.327335] HugeTLB registered 4 MB page size, pre-allocated 0 pages
[    0.327481] VFS: Disk quotas dquot_6.5.2
[    0.327592] Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
[    0.327727] msgmni has been set to 1007
[    0.328064] alg: No test for stdrng (krng)
[    0.328211] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 253)
[    0.328274] io scheduler noop registered
[    0.328321] io scheduler anticipatory registered
[    0.328369] io scheduler deadline registered
[    0.328426] io scheduler cfq registered (default)
[    0.328537] pci 0000:01:05.0: Boot video device
[    0.329201] isapnp: Scanning for PnP cards...
[    0.632055] Switched to high resolution mode on CPU 0
[    0.682609] isapnp: No Plug & Play device found
[    0.687515] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    0.687771] serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[    0.689526] 00:08: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[    0.692364] brd: module loaded
[    0.692592] PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
[    0.693038] serio: i8042 KBD port at 0x60,0x64 irq 1
[    0.693797] serio: i8042 AUX port at 0x60,0x64 irq 12
[    0.694146] mice: PS/2 mouse device common for all mice
[    0.694327] rtc_cmos 00:04: RTC can wake from S4
[    0.694522] rtc_cmos 00:04: rtc core: registered rtc_cmos as rtc0
[    0.694601] rtc0: alarms up to one year, y3k, 242 bytes nvram
[    0.694713] cpuidle: using governor ladder
[    0.694762] cpuidle: using governor menu
[    0.694815] No iBFT detected.
[    0.695583] TCP cubic registered
[    0.695632] NET: Registered protocol family 17
[    0.695701] Using IPI Shortcut mode
[    0.695987] registered taskstats version 1
[    0.696313] rtc_cmos 00:04: setting system clock to 2009-05-16 07:31:32 UTC (1242459092)
[    0.696459] Freeing unused kernel memory: 268k freed
[    0.713460] input: AT Translated Set 2 keyboard as /class/input/input0
[    1.588125] Uniform Multi-Platform E-IDE driver
[    1.603757] ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 10
[    1.603820] PCI: setting IRQ 10 as level-triggered
[    1.603832] 3c59x 0000:00:09.0: PCI INT A -> Link[LNKB] -> GSI 10 (level, low) -> IRQ 10
[    1.603917] 3c59x: Donald Becker and others.
[    1.603975] 0000:00:09.0: 3Com PCI 3c905C Tornado at e08d8000.
[    1.856346] usbcore: registered new interface driver usbfs
[    1.856462] usbcore: registered new interface driver hub
[    1.856591] usbcore: registered new device driver usb
[    1.860444] uhci_hcd: USB Universal Host Controller Interface driver
[    1.865155] Floppy drive(s): fd0 is 1.44M
[    1.883632] FDC 0 is a post-1991 82077
[    1.900740] ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
[    1.900804] PCI: setting IRQ 11 as level-triggered
[    1.900816] 3c59x 0000:00:0b.0: PCI INT A -> Link[LNKD] -> GSI 11 (level, low) -> IRQ 11
[    1.900915] 0000:00:0b.0: 3Com PCI 3c905C Tornado at e091c000.
[    1.922835] uhci_hcd 0000:00:11.2: PCI INT D -> Link[LNKD] -> GSI 11 (level, low) -> IRQ 11
[    1.922911] uhci_hcd 0000:00:11.2: UHCI Host Controller
[    1.923046] uhci_hcd 0000:00:11.2: new USB bus registered, assigned bus number 1
[    1.923139] uhci_hcd 0000:00:11.2: irq 11, io base 0x0000d800
[    1.923270] usb usb1: New USB device found, idVendor=1d6b, idProduct=0001
[    1.923325] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.923385] usb usb1: Product: UHCI Host Controller
[    1.923434] usb usb1: Manufacturer: Linux 2.6.30-rc5 uhci_hcd
[    1.923484] usb usb1: SerialNumber: 0000:00:11.2
[    1.923652] usb usb1: configuration #1 chosen from 1 choice
[    1.923763] hub 1-0:1.0: USB hub found
[    1.923826] hub 1-0:1.0: 2 ports detected
[    1.924112] uhci_hcd 0000:00:11.3: PCI INT D -> Link[LNKD] -> GSI 11 (level, low) -> IRQ 11
[    1.924182] uhci_hcd 0000:00:11.3: UHCI Host Controller
[    1.924274] uhci_hcd 0000:00:11.3: new USB bus registered, assigned bus number 2
[    1.924354] uhci_hcd 0000:00:11.3: irq 11, io base 0x0000dc00
[    1.924470] usb usb2: New USB device found, idVendor=1d6b, idProduct=0001
[    1.924525] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.924584] usb usb2: Product: UHCI Host Controller
[    1.924633] usb usb2: Manufacturer: Linux 2.6.30-rc5 uhci_hcd
[    1.924684] usb usb2: SerialNumber: 0000:00:11.3
[    1.924818] usb usb2: configuration #1 chosen from 1 choice
[    1.924924] hub 2-0:1.0: USB hub found
[    1.924985] hub 2-0:1.0: 2 ports detected
[    1.929346] via82cxxx 0000:00:11.1: VIA vt8231 (rev 10) IDE UDMA100
[    1.929412] via82cxxx 0000:00:11.1: IDE controller (0x1106:0x0571 rev 0x06)
[    1.929518] via82cxxx 0000:00:11.1: not 100% native mode: will probe irqs later
[    1.929584]     ide0: BM-DMA at 0xd400-0xd407
[    1.929642]     ide1: BM-DMA at 0xd408-0xd40f
[    1.929699] Probing IDE interface ide0...
[    2.244229] hda: Maxtor 6L160P0, ATA DISK drive
[    2.916125] hda: host max PIO5 wanted PIO255(auto-tune) selected PIO4
[    2.917653] hda: UDMA/100 mode selected
[    2.919216] Probing IDE interface ide1...
[    3.656229] hdc: PLEXTOR CD-R PX-W4824A, ATAPI CD/DVD-ROM drive
[    4.496022] hdd: Seagate STT20000A, ATAPI TAPE drive
[    4.496187] hdc: host max PIO5 wanted PIO255(auto-tune) selected PIO4
[    4.496467] hdc: MWDMA2 mode selected
[    4.496600] hdd: host max PIO5 wanted PIO255(auto-tune) selected PIO4
[    4.497380] hdd: Disabling (U)DMA for Seagate STT20000A (blacklisted)
[    4.497433] hdd: host max PIO5 wanted PIO255(auto-tune) selected PIO4
[    4.498680] ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
[    4.498795] ide1 at 0x170-0x177,0x376 on irq 15
[    4.534502] ide-gd driver 1.18
[    4.534619] hda: max request size: 512KiB
[    4.572062] hda: 320173056 sectors (163928 MB) w/8192KiB Cache, CHS=19929/255/63
[    4.579468] hda: cache flushes supported
[    4.579629]  hda:<6>ide-cd driver 5.00
[    4.588573]  hda1 hda2 < hda5 hda6 hda7 hda8 hda9 hda10 >
[    4.666985] ide-cd: hdc: ATAPI 40X CD-ROM CD-R/RW drive, 4096kB Cache
[    4.667206] Uniform CD-ROM driver Revision: 3.20
[    5.078782] PM: Starting manual resume from disk
[    5.137935] kjournald starting.  Commit interval 5 seconds
[    5.138009] EXT3-fs: mounted filesystem with writeback data mode.
[    7.232831] udevd version 125 started
[    9.423771] input: PC Speaker as /class/input/input1
[    9.459607] EDAC MC: Ver: 2.1.0 May 11 2009
[    9.636512] gameport: EMU10K1 is pci0000:00:0a.1/gameport0, io 0xcc00, speed 1217kHz
[    9.644326] parport_pc: VIA 686A/8231 detected
[    9.644332] parport_pc: probing current configuration
[    9.644350] parport_pc: Current parallel port base: 0x378
[    9.644399] parport0: PC-style at 0x378, irq 7 [PCSPP,EPP]
[    9.657871] EDAC MC0: Giving out device to 'amd76x_edac' 'AMD761': DEV 0000:00:00.0
[    9.657977] EDAC PCI0: Giving out device to module 'amd76x_edac' controller 'EDAC PCI controller': DEV '0000:00:00.0' (POLLED)
[    9.736179] parport_pc: VIA parallel port: io=0x378, irq=7
[   10.015786] Linux agpgart interface v0.103
[   10.397933] input: Power Button as /class/input/input2
[   10.398066] ACPI: Power Button [PWRF]
[   10.398235] input: Power Button as /class/input/input3
[   10.398326] ACPI: Power Button [PWRB]
[   10.398492] input: Sleep Button as /class/input/input4
[   10.398583] ACPI: Sleep Button [SLPB]
[   10.416485] Marking TSC unstable due to TSC halts in idle
[   10.416600] processor ACPI_CPU:00: registered as cooling_device0
[   10.416656] ACPI: Processor [CPU0] (supports 2 throttling states)
[   11.077343] input: PS/2 Logitech Mouse as /class/input/input5
[   12.100580] ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 3
[   12.100643] PCI: setting IRQ 3 as level-triggered
[   12.100655] EMU10K1_Audigy 0000:00:0a.0: PCI INT A -> Link[LNKC] -> GSI 3 (level, low) -> IRQ 3
[   12.114126] Control name 'Sigmatel Surround Phase Inversion Playback Switch' truncated to 'Sigmatel Surround Phase Inversion Playback '
[   14.316158] Adding 497972k swap on /dev/hda5.  Priority:-1 extents:1 across:497972k 
[   14.603123] EXT3 FS on hda6, internal journal
[   16.395164] kjournald starting.  Commit interval 5 seconds
[   16.395383] EXT3 FS on hda7, internal journal
[   16.395466] EXT3-fs: mounted filesystem with writeback data mode.
[   16.460532] kjournald starting.  Commit interval 5 seconds
[   16.460763] EXT3 FS on hda8, internal journal
[   16.460847] EXT3-fs: mounted filesystem with writeback data mode.
[   16.517020] kjournald starting.  Commit interval 5 seconds
[   16.517259] EXT3 FS on hda10, internal journal
[   16.517340] EXT3-fs: mounted filesystem with writeback data mode.
[   17.502584] nf_conntrack version 0.5.0 (8191 buckets, 32764 max)
[   17.502910] CONFIG_NF_CT_ACCT is deprecated and will be removed soon. Please use
[   17.502972] nf_conntrack.acct=1 kernel paramater, acct=1 nf_conntrack module option or
[   17.503032] sysctl net.netfilter.nf_conntrack_acct=1 to enable it.
[   17.585785] ip_tables: (C) 2000-2006 Netfilter Core Team
[   18.512911] eth0:  setting full-duplex.
[   24.019943] NET: Registered protocol family 10
[   24.021288] lo: Disabled Privacy Extensions
[   26.829183] lp0: using parport0 (interrupt-driven).
[   26.865203] ppdev: user-space parallel port driver
[   34.708015] eth0: no IPv6 routers present
[   76.872737] ide-tape: hdd <-> ht0: Seagate STT20000A rev 8A51
[   76.885052] ide-tape: hdd <-> ht0: 232KBps, 6*54kB buffer, 400ms tDSC
[  428.899115] ------------[ cut here ]------------
[  428.899173] WARNING: at fs/proc/generic.c:847 remove_proc_entry+0x118/0x134()
[  428.899227] Hardware name:  
[  428.899273] remove_proc_entry: removing non-empty directory 'ide1/hdd', leaking at least 'name'
[  428.899336] Modules linked in: ide_tape ppdev lp ipv6 ipt_LOG nf_conntrack_ipv4 nf_defrag_ipv4 xt_state xt_tcpudp iptable_filter ip_tables x_tables nf_conntrack_ftp nf_conntrack snd_emu10k1_synth snd_emux_synth snd_seq_virmidi snd_seq_midi_emul snd_emu10k1 snd_ac97_codec ac97_bus snd_pcm_oss snd_mixer_oss snd_pcm snd_page_alloc snd_util_mem snd_hwdep snd_seq_dummy snd_seq_oss snd_seq_midi processor button psmouse vt8231 snd_rawmidi snd_seq_midi_event amd_k7_agp snd_seq i2c_viapro agpgart serio_raw i2c_core snd_timer snd_seq_device amd76x_edac parport_pc emu10k1_gp gameport snd parport edac_core pcspkr soundcore evdev ext3 jbd mbcache ide_cd_mod cdrom ide_gd_mod via82cxxx floppy uhci_hcd ide_pci_generic ide_core 3c59x usbcore mii thermal fan thermal_sys
[  428.901822] Pid: 2606, comm: mt Not tainted 2.6.30-rc5 #1
[  428.901874] Call Trace:
[  428.901930]  [<c011b1a6>] ? warn_slowpath_fmt+0x7c/0xa0
[  428.901984]  [<c011b1b2>] ? warn_slowpath_fmt+0x88/0xa0
[  428.902039]  [<c0119201>] ? check_preempt_wakeup+0x139/0x166
[  428.902095]  [<c017ee47>] ? pollwake+0x33/0x39
[  428.902147]  [<c01167e8>] ? default_wake_function+0x0/0x8
[  428.902200]  [<c0115168>] ? __wake_up_common+0x2d/0x52
[  428.902254]  [<c0180ffa>] ? clear_inode+0x53/0xb3
[  428.902306]  [<c01a2aee>] ? remove_proc_entry+0x118/0x134
[  428.902414]  [<e08c4d2a>] ? ide_proc_unregister_device+0x2e/0x37 [ide_core]
[  428.902488]  [<e08bf305>] ? drive_release_dev+0x17/0x42 [ide_core]
[  428.902549]  [<c02445e5>] ? device_release+0x32/0x53
[  428.902605]  [<c01e1e29>] ? kobject_release+0x3d/0x4f
[  428.902657]  [<c01e1dec>] ? kobject_release+0x0/0x4f
[  428.902709]  [<c01e28cc>] ? kref_put+0x35/0x3f
[  428.902767]  [<e0f3c20a>] ? ide_tape_put+0x21/0x2d [ide_tape]
[  428.902826]  [<e0f3d278>] ? idetape_chrdev_release+0x185/0x18f [ide_tape]
[  428.902884]  [<c01744a2>] ? __fput+0xa6/0x14d
[  428.902935]  [<c0171e3a>] ? filp_close+0x4e/0x54
[  428.902987]  [<c0171e8e>] ? sys_close+0x4e/0x74
[  428.903039]  [<c01026a4>] ? sysenter_do_call+0x12/0x22
[  428.903090] ---[ end trace c00660128585149c ]---

--Dxnq1zWXvFF0Q93v--
