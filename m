From: Borislav Petkov <petkovbb@googlemail.com>
Subject: Re: Bug 11581
Date: Fri, 10 Oct 2008 08:16:10 +0200
Message-ID: <20081010061610.GA5273@gollum.tnic>
References: <20081004091232.GB4160@gollum.tnic> <Pine.LNX.4.64.0810051147470.2543@cantor.unex.es>
Reply-To: petkovbb@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.157]:40772 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750934AbYJJGQV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 10 Oct 2008 02:16:21 -0400
Received: by fg-out-1718.google.com with SMTP id 19so245492fgg.17
        for <linux-ide@vger.kernel.org>; Thu, 09 Oct 2008 23:16:18 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0810051147470.2543@cantor.unex.es>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Santiago Vila <sanvila@unex.es>
Cc: bzolnier@gmail.com, axboe@kernel.dk, linux-ide@vger.kernel.org

Hi,

please hit the "reply-to-all" button on your mail client next time so that all
people/mailing lists on the CC also get included.

Ok, can you now turn off your hdd drive - the CDU5211 one (simply disconnecting
the power cable should suffice) and then reboot and send me dmesg again. See,
there's a lot of verbose output there in the dmesg and I can't differentiate
which comes from which but hdc-only output is relevant.

Thanks.

On Sun, Oct 05, 2008 at 11:50:20AM +0200, Santiago Vila wrote:
> On Sat, 4 Oct 2008, Borislav Petkov wrote:
> 
> > can you please apply the following revised inquiry patch and send me
> > your dmesg so that we get more info on what exactly triggers that
> > begavior with your drive?
> 
> Here it is. Sorry for the delay, I was busy yesterday.
> 
> Still using 2.6.27-rc7 but if you think rc8 might make a difference,
> just say so and I'll repeat it with rc8.
> 
> Thanks.
> [    0.000000] Initializing cgroup subsys cpuset
> [    0.000000] Initializing cgroup subsys cpu
> [    0.000000] Linux version 2.6.27-rc7 (sanvila@salma1) (gcc version 4.3.1 (Debian 4.3.1-9) ) #1 SMP Sun Oct 5 11:29:16 CEST 2008
> [    0.000000] BIOS-provided physical RAM map:
> [    0.000000]  BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
> [    0.000000]  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
> [    0.000000]  BIOS-e820: 0000000000100000 - 000000000fff0000 (usable)
> [    0.000000]  BIOS-e820: 000000000fff0000 - 000000000fff3000 (ACPI NVS)
> [    0.000000]  BIOS-e820: 000000000fff3000 - 0000000010000000 (ACPI data)
> [    0.000000]  BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
> [    0.000000] last_pfn = 0xfff0 max_arch_pfn = 0x100000
> [    0.000000] kernel direct mapping tables up to fff0000 @ 7000-d000
> [    0.000000] RAMDISK: 0fd9e000 - 0ffdf8e7
> [    0.000000] DMI 2.2 present.
> [    0.000000] ACPI: RSDP 000F7610, 0014 (r0 VIA694)
> [    0.000000] ACPI: RSDT 0FFF3000, 0028 (r1 VIA694 MSI ACPI 42302E31 AWRD        0)
> [    0.000000] ACPI: FACP 0FFF3040, 0074 (r1 VIA694 MSI ACPI 42302E31 AWRD        0)
> [    0.000000] ACPI: DSDT 0FFF30C0, 259F (r1 VIA694 AWRDACPI     1000 MSFT  100000C)
> [    0.000000] ACPI: FACS 0FFF0000, 0040
> [    0.000000] 0MB HIGHMEM available.
> [    0.000000] 255MB LOWMEM available.
> [    0.000000]   mapped low ram: 0 - 0fff0000
> [    0.000000]   low ram: 00000000 - 0fff0000
> [    0.000000]   bootmap 00002000 - 00004000
> [    0.000000] (9 early reservations) ==> bootmem [0000000000 - 000fff0000]
> [    0.000000]   #0 [0000000000 - 0000001000]   BIOS data page ==> [0000000000 - 0000001000]
> [    0.000000]   #1 [0000001000 - 0000002000]    EX TRAMPOLINE ==> [0000001000 - 0000002000]
> [    0.000000]   #2 [0000006000 - 0000007000]       TRAMPOLINE ==> [0000006000 - 0000007000]
> [    0.000000]   #3 [0000100000 - 00004268e0]    TEXT DATA BSS ==> [0000100000 - 00004268e0]
> [    0.000000]   #4 [000fd9e000 - 000ffdf8e7]          RAMDISK ==> [000fd9e000 - 000ffdf8e7]
> [    0.000000]   #5 [0000427000 - 000042a000]    INIT_PG_TABLE ==> [0000427000 - 000042a000]
> [    0.000000]   #6 [000009f000 - 0000100000]    BIOS reserved ==> [000009f000 - 0000100000]
> [    0.000000]   #7 [0000007000 - 0000009000]          PGTABLE ==> [0000007000 - 0000009000]
> [    0.000000]   #8 [0000002000 - 0000004000]          BOOTMAP ==> [0000002000 - 0000004000]
> [    0.000000] Zone PFN ranges:
> [    0.000000]   DMA      0x00000000 -> 0x00001000
> [    0.000000]   Normal   0x00001000 -> 0x0000fff0
> [    0.000000]   HighMem  0x0000fff0 -> 0x0000fff0
> [    0.000000] Movable zone start PFN for each node
> [    0.000000] early_node_map[2] active PFN ranges
> [    0.000000]     0: 0x00000000 -> 0x000000a0
> [    0.000000]     0: 0x00000100 -> 0x0000fff0
> [    0.000000] On node 0 totalpages: 65424
> [    0.000000] free_area_init_node: node 0, pgdat c0367000, node_mem_map c1000000
> [    0.000000]   DMA zone: 3968 pages, LIFO batch:0
> [    0.000000]   Normal zone: 60944 pages, LIFO batch:15
> [    0.000000] ACPI: PM-Timer IO Port: 0x4008
> [    0.000000] SMP: Allowing 1 CPUs, 0 hotplug CPUs
> [    0.000000] Local APIC disabled by BIOS -- you can enable it with "lapic"
> [    0.000000] mapped APIC to ffffb000 (01201000)
> [    0.000000] PM: Registered nosave memory: 00000000000a0000 - 00000000000f0000
> [    0.000000] PM: Registered nosave memory: 00000000000f0000 - 0000000000100000
> [    0.000000] Allocating PCI resources starting at 20000000 (gap: 10000000:efff0000)
> [    0.000000] PERCPU: Allocating 37500 bytes of per cpu data
> [    0.000000] NR_CPUS: 8, nr_cpu_ids: 1, nr_node_ids 1
> [    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 64912
> [    0.000000] Kernel command line: root=/dev/hda6 ro vga=4 
> [    0.000000] Enabling fast FPU save and restore... done.
> [    0.000000] Initializing CPU#0
> [    0.000000] PID hash table entries: 1024 (order: 10, 4096 bytes)
> [    0.000000] TSC: PIT calibration confirmed by PMTIMER.
> [    0.000000] TSC: using PIT calibration value
> [    0.000000] Detected 799.590 MHz processor.
> [    0.004000] Console: colour VGA+ 80x30
> [    0.004000] console [tty0] enabled
> [    0.004000] Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
> [    0.004000] Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
> [    0.004000] Memory: 253612k/262080k available (1787k kernel code, 7892k reserved, 733k data, 280k init, 0k highmem)
> [    0.004000] virtual kernel memory layout:
> [    0.004000]     fixmap  : 0xfff50000 - 0xfffff000   ( 700 kB)
> [    0.004000]     pkmap   : 0xff800000 - 0xffc00000   (4096 kB)
> [    0.004000]     vmalloc : 0xd0800000 - 0xff7fe000   ( 751 MB)
> [    0.004000]     lowmem  : 0xc0000000 - 0xcfff0000   ( 255 MB)
> [    0.004000]       .init : 0xc037d000 - 0xc03c3000   ( 280 kB)
> [    0.004000]       .data : 0xc02bec70 - 0xc0376290   ( 733 kB)
> [    0.004000]       .text : 0xc0100000 - 0xc02bec70   (1787 kB)
> [    0.004000] Checking if this processor honours the WP bit even in supervisor mode...Ok.
> [    0.004000] CPA: page pool initialized 1 of 1 pages preallocated
> [    0.004023] Calibrating delay loop (skipped), value calculated using timer frequency.. 1599.18 BogoMIPS (lpj=3198360)
> [    0.004228] Security Framework initialized
> [    0.004292] SELinux:  Disabled at boot.
> [    0.004379] Mount-cache hash table entries: 512
> [    0.004824] Initializing cgroup subsys ns
> [    0.004887] Initializing cgroup subsys cpuacct
> [    0.004944] Initializing cgroup subsys devices
> [    0.005041] CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
> [    0.005111] CPU: L2 Cache: 64K (64 bytes/line)
> [    0.005170] Intel machine check architecture supported.
> [    0.005231] Intel machine check reporting enabled on CPU#0.
> [    0.005324] Checking 'hlt' instruction... OK.
> [    0.020121] SMP alternatives: switching to UP code
> [    0.033549] Freeing SMP alternatives: 10k freed
> [    0.033621] ACPI: Core revision 20080609
> [    0.041708] ACPI: setting ELCR to 0800 (from 1c20)
> [    0.044214] weird, boot CPU (#0) not listedby the BIOS.
> [    0.044278] SMP motherboard not detected.
> [    0.044333] Local APIC not detected. Using dummy APIC emulation.
> [    0.044395] SMP disabled
> [    0.044595] Brought up 1 CPUs
> [    0.044650] Total of 1 processors activated (1599.18 BogoMIPS).
> [    0.044738] CPU0 attaching sched-domain:
> [    0.044745]  domain 0: span 0 level CPU
> [    0.044752]   groups: 0
> [    0.045415] net_namespace: 832 bytes
> [    0.045500] Booting paravirtualized kernel on bare hardware
> [    0.046285] NET: Registered protocol family 16
> [    0.047063] ACPI: bus type pci registered
> [    0.080969] PCI: PCI BIOS revision 2.10 entry at 0xfb160, last bus=1
> [    0.081042] PCI: Using configuration type 1 for base access
> [    0.083664] ACPI: EC: Look up EC in DSDT
> [    0.091638] ACPI: Interpreter enabled
> [    0.091713] ACPI: (supports S0 S1 S4 S5)
> [    0.091931] ACPI: Using PIC for interrupt routing
> [    0.102963] ACPI: PCI Root Bridge [PCI0] (0000:00)
> [    0.103224] PCI: 0000:00:00.0 reg 10 32bit mmio: [d0000000, d3ffffff]
> [    0.103269] pci 0000:00:00.0: Disabling VIA memory write queue (PCI ID 0305, rev 03): [55] 8d & 1f -> 0d
> [    0.103406] pci 0000:00:01.0: supports D1
> [    0.103523] PCI: 0000:00:07.1 reg 20 io port: [a000, a00f]
> [    0.103592] PCI: 0000:00:07.2 reg 20 io port: [a400, a41f]
> [    0.103660] PCI: 0000:00:07.3 reg 20 io port: [a800, a81f]
> [    0.103752] pci 0000:00:07.4: quirk: region 6000-607f claimed by vt82c686 HW-mon
> [    0.103830] pci 0000:00:07.4: quirk: region 5000-500f claimed by vt82c686 SMB
> [    0.103933] PCI: 0000:00:09.0 reg 10 io port: [b000, b0ff]
> [    0.103944] PCI: 0000:00:09.0 reg 14 32bit mmio: [da000000, da0000ff]
> [    0.104024] pci 0000:00:09.0: supports D1
> [    0.104029] pci 0000:00:09.0: supports D2
> [    0.104035] pci 0000:00:09.0: PME# supported from D1 D2 D3hot
> [    0.104100] pci 0000:00:09.0: PME# disabled
> [    0.104197] PCI: 0000:00:0a.0 reg 20 io port: [b400, b41f]
> [    0.104222] pci 0000:00:0a.0: supports D1
> [    0.104226] pci 0000:00:0a.0: supports D2
> [    0.104231] pci 0000:00:0a.0: PME# supported from D0 D1 D2 D3hot D3cold
> [    0.104299] pci 0000:00:0a.0: PME# disabled
> [    0.104397] PCI: 0000:00:0a.1 reg 20 io port: [b800, b81f]
> [    0.104422] pci 0000:00:0a.1: supports D1
> [    0.104426] pci 0000:00:0a.1: supports D2
> [    0.104432] pci 0000:00:0a.1: PME# supported from D0 D1 D2 D3hot D3cold
> [    0.104499] pci 0000:00:0a.1: PME# disabled
> [    0.104578] PCI: 0000:00:0a.2 reg 10 32bit mmio: [da001000, da0010ff]
> [    0.104620] pci 0000:00:0a.2: supports D1
> [    0.104624] pci 0000:00:0a.2: supports D2
> [    0.104629] pci 0000:00:0a.2: PME# supported from D0 D1 D2 D3hot D3cold
> [    0.104696] pci 0000:00:0a.2: PME# disabled
> [    0.104784] PCI: 0000:00:0e.0 reg 10 io port: [bc00, bc1f]
> [    0.104824] pci 0000:00:0e.0: supports D1
> [    0.104829] pci 0000:00:0e.0: supports D2
> [    0.104858] PCI: 0000:00:0e.1 reg 10 io port: [c000, c007]
> [    0.104898] pci 0000:00:0e.1: supports D1
> [    0.104902] pci 0000:00:0e.1: supports D2
> [    0.104976] PCI: 0000:01:00.0 reg 10 32bit mmio: [d4000000, d7ffffff]
> [    0.104987] PCI: 0000:01:00.0 reg 14 io port: [9000, 90ff]
> [    0.104997] PCI: 0000:01:00.0 reg 18 32bit mmio: [d9000000, d9003fff]
> [    0.105021] PCI: 0000:01:00.0 reg 30 32bit mmio: [0, 1ffff]
> [    0.105043] pci 0000:01:00.0: supports D1
> [    0.105080] PCI: bridge 0000:00:01.0 io port: [9000, 9fff]
> [    0.105088] PCI: bridge 0000:00:01.0 32bit mmio: [d8000000, d9ffffff]
> [    0.105097] PCI: bridge 0000:00:01.0 32bit mmio pref: [d4000000, d7ffffff]
> [    0.105109] bus 00 -> node 0
> [    0.105138] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
> [    0.147221] ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 5 6 7 *10 11 12 14 15)
> [    0.148139] ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 *5 6 7 10 11 12 14 15)
> [    0.149006] ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 5 6 7 10 *11 12 14 15)
> [    0.149875] ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 5 6 7 10 11 *12 14 15)
> [    0.150838] Linux Plug and Play Support v0.97 (c) Adam Belay
> [    0.151003] pnp: PnP ACPI init
> [    0.151081] ACPI: bus type pnp registered
> [    0.159359] pnp: PnP ACPI: found 12 devices
> [    0.159428] ACPI: ACPI bus type pnp unregistered
> [    0.159492] PnPBIOS: Disabled by ACPI PNP
> [    0.160386] PCI: Using ACPI for IRQ routing
> [    0.160717] system 00:00: iomem range 0xcb000-0xcbfff has been reserved
> [    0.160717] system 00:00: iomem range 0xf0000-0xf7fff could not be reserved
> [    0.160717] system 00:00: iomem range 0xf8000-0xfbfff could not be reserved
> [    0.160717] system 00:00: iomem range 0xfc000-0xfffff could not be reserved
> [    0.160717] system 00:00: iomem range 0xfff0000-0xfffffff could not be reserved
> [    0.160717] system 00:00: iomem range 0xffff0000-0xffffffff could not be reserved
> [    0.160717] system 00:00: iomem range 0x0-0x9ffff could not be reserved
> [    0.160717] system 00:00: iomem range 0x100000-0xffeffff could not be reserved
> [    0.160717] system 00:00: iomem range 0xfee00000-0xfee00fff has been reserved
> [    0.160744] system 00:02: ioport range 0x4d0-0x4d1 has been reserved
> [    0.197667] pci 0000:00:01.0: PCI bridge, secondary bus 0000:01
> [    0.197743] pci 0000:00:01.0:   IO window: 0x9000-0x9fff
> [    0.197808] pci 0000:00:01.0:   MEM window: 0xd8000000-0xd9ffffff
> [    0.197875] pci 0000:00:01.0:   PREFETCH window: 0x000000d4000000-0x000000d7ffffff
> [    0.197968] pci 0000:00:01.0: setting latency timer to 64
> [    0.197977] bus: 00 index 0 io port: [0, ffff]
> [    0.198034] bus: 00 index 1 mmio: [0, ffffffff]
> [    0.198090] bus: 01 index 0 io port: [9000, 9fff]
> [    0.198148] bus: 01 index 1 mmio: [d8000000, d9ffffff]
> [    0.198207] bus: 01 index 2 mmio: [d4000000, d7ffffff]
> [    0.198266] bus: 01 index 3 mmio: [0, 0]
> [    0.198388] NET: Registered protocol family 2
> [    0.198816] IP route cache hash table entries: 2048 (order: 1, 8192 bytes)
> [    0.199480] TCP established hash table entries: 8192 (order: 4, 65536 bytes)
> [    0.199833] TCP bind hash table entries: 8192 (order: 4, 65536 bytes)
> [    0.200244] TCP: Hash tables configured (established 8192 bind 8192)
> [    0.200312] TCP reno registered
> [    0.200686] NET: Registered protocol family 1
> [    0.201047] checking if image is initramfs... it is
> [    0.651085] Freeing initrd memory: 2310k freed
> [    0.652877] audit: initializing netlink socket (disabled)
> [    0.652983] type=2000 audit(1223199926.652:1): initialized
> [    0.653331] HugeTLB registered 4 MB page size, pre-allocated 0 pages
> [    0.653586] VFS: Disk quotas dquot_6.5.1
> [    0.653720] Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
> [    0.653875] msgmni has been set to 500
> [    0.654331] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 253)
> [    0.654418] io scheduler noop registered
> [    0.654472] io scheduler anticipatory registered
> [    0.654528] io scheduler deadline registered
> [    0.655627] io scheduler cfq registered (default)
> [    0.655713] pci 0000:00:00.0: Applying VIA southbridge workaround
> [    0.655781] PCI: VIA PCI bridge detected.Disabling DAC.
> [    0.655845] pci 0000:00:07.0: Disabling VIA external APIC routing
> [    0.656014] pci 0000:01:00.0: Boot video device
> [    0.657045] isapnp: Scanning for PnP cards...
> [    0.700082] Switched to high resolution mode on CPU 0
> [    1.011396] isapnp: No Plug & Play device found
> [    1.019407] Serial: 8250/16550 driver4 ports, IRQ sharing enabled
> [    1.019753] serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
> [    1.020163] serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
> [    1.021235] 00:08: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
> [    1.021770] 00:09: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
> [    1.026905] brd: module loaded
> [    1.027246] PNP: PS/2 Controller [PNP0303:PS2K] at 0x60,0x64 irq 1
> [    1.027315] PNP: PS/2 appears to have AUX port disabled, if this is incorrect please boot with i8042.nopnp
> [    1.027713] serio: i8042 KBD port at 0x60,0x64 irq 1
> [    1.028268] mice: PS/2 mouse device common for all mice
> [    1.028749] rtc_cmos 00:04: rtc core: registered rtc_cmos as rtc0
> [    1.028857] rtc0: alarms up to one year, y3k
> [    1.029024] cpuidle: using governor ladder
> [    1.029084] cpuidle: using governor menu
> [    1.029147] No iBFT detected.
> [    1.030255] TCP cubic registered
> [    1.030311] NET: Registered protocol family 17
> [    1.030401] Using IPI No-Shortcut mode
> [    1.030900] registered taskstats version 1
> [    1.031285] rtc_cmos 00:04: setting system clock to 2008-10-05 09:45:28 UTC (1223199928)
> [    1.032356] Freeing unused kernel memory: 280k freed
> [    1.062243] input: AT Translated Set 2 keyboard as /class/input/input0
> [    1.221838] ACPI: CPU0 (power states: C1[C1] C2[C2])
> [    1.222149] processor ACPI0007:00: registered as cooling_device0
> [    1.222221] ACPI: Processor [CPU0] (supports 2 throttling states)
> [    2.138757] No dock devices found.
> [    2.261213] SCSI subsystem initialized
> [    2.316899] usbcore: registered new interface driver usbfs
> [    2.317048] usbcore: registered new interface driver hub
> [    2.317233] usbcore: registered new device driver usb
> [    2.326134] 8139too Fast Ethernet driver 0.9.28
> [    2.327212] ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 11
> [    2.327280] PCI: setting IRQ 11 as level-triggered
> [    2.327291] 8139too 0000:00:09.0: PCI INT A -> Link[LNKC] -> GSI 11 (level, low) -> IRQ 11
> [    2.328430] eth0: RealTek RTL8139 at 0xb000, 00:05:1c:04:cf:92, IRQ 11
> [    2.328502] eth0:  Identified 8139 chip type 'RTL-8139C'
> [    2.385477] libata version 3.00 loaded.
> [    2.390667] USB Universal Host Controller Interface driver v3.0
> [    2.391752] ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 10
> [    2.391822] PCI: setting IRQ 10 as level-triggered
> [    2.391835] uhci_hcd 0000:00:07.2: PCI INT D -> Link[LNKA] -> GSI 10 (level, low) -> IRQ 10
> [    2.391932] uhci_hcd 0000:00:07.2: UHCI Host Controller
> [    2.392194] uhci_hcd 0000:00:07.2: new USB bus registered, assigned bus number 1
> [    2.392319] uhci_hcd 0000:00:07.2: irq 10, io base 0x0000a400
> [    2.392635] usb usb1: configuration #1 chosen from 1 choice
> [    2.392769] hub 1-0:1.0: USB hub found
> [    2.392843] hub 1-0:1.0: 2 ports detected
> [    2.406860] 8139cp: 10/100 PCI Ethernet driver v1.3 (Mar 22, 2004)
> [    2.508666] Floppy drive(s): fd0 is 1.44M
> [    2.527943] FDC 0 is a post-1991 82077
> [    2.600502] usb usb1: New USB device found, idVendor=1d6b, idProduct=0001
> [    2.600585] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [    2.600661] usb usb1: Product: UHCI Host Controller
> [    2.600719] usb usb1: Manufacturer: Linux 2.6.27-rc7 uhci_hcd
> [    2.600781] usb usb1: SerialNumber: 0000:00:07.2
> [    2.601041] uhci_hcd 0000:00:07.3: PCI INT D -> Link[LNKA] -> GSI 10 (level, low) -> IRQ 10
> [    2.601140] uhci_hcd 0000:00:07.3: UHCI Host Controller
> [    2.601259] uhci_hcd 0000:00:07.3: new USB bus registered, assigned bus number 2
> [    2.601371] uhci_hcd 0000:00:07.3: irq 10, io base 0x0000a800
> [    2.601679] usb usb2: configuration #1 chosen from 1 choice
> [    2.601820] hub 2-0:1.0: USB hub found
> [    2.601903] hub 2-0:1.0: 2 ports detected
> [    2.636030] Marking TSC unstable due to TSC halts in idle
> [    2.808378] usb usb2: New USB device found, idVendor=1d6b, idProduct=0001
> [    2.808456] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [    2.808533] usb usb2: Product: UHCI Host Controller
> [    2.808591] usb usb2: Manufacturer: Linux 2.6.27-rc7 uhci_hcd
> [    2.808653] usb usb2: SerialNumber: 0000:00:07.3
> [    2.809888] ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 12
> [    2.809960] PCI: setting IRQ 12 as level-triggered
> [    2.809972] uhci_hcd 0000:00:0a.0: PCI INT A -> Link[LNKD] -> GSI 12 (level, low) -> IRQ 12
> [    2.810067] uhci_hcd 0000:00:0a.0: UHCI Host Controller
> [    2.810228] uhci_hcd 0000:00:0a.0: new USB bus registered, assigned bus number 3
> [    2.810343] uhci_hcd 0000:00:0a.0: irq 12, io base 0x0000b400
> [    2.810671] usb usb3: configuration #1 chosen from 1 choice
> [    2.810806] hub 3-0:1.0: USB hub found
> [    2.810881] hub 3-0:1.0: 2 ports detected
> [    2.920054] usb 2-2: new full speed USB device using uhci_hcd and address 2
> [    3.016373] usb usb3: New USB device found, idVendor=1d6b, idProduct=0001
> [    3.016451] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [    3.016528] usb usb3: Product: UHCI Host Controller
> [    3.016586] usb usb3: Manufacturer: Linux 2.6.27-rc7 uhci_hcd
> [    3.016648] usb usb3: SerialNumber: 0000:00:0a.0
> [    3.016820] uhci_hcd 0000:00:0a.1: PCI INT B -> Link[LNKA] -> GSI 10 (level, low) -> IRQ 10
> [    3.016918] uhci_hcd 0000:00:0a.1: UHCI Host Controller
> [    3.017048] uhci_hcd 0000:00:0a.1: new USB bus registered, assigned bus number 4
> [    3.017159] uhci_hcd 0000:00:0a.1: irq 10, io base 0x0000b800
> [    3.017471] usb usb4: configuration #1 chosen from 1 choice
> [    3.017606] hub 4-0:1.0: USB hub found
> [    3.017681] hub 4-0:1.0: 2 ports detected
> [    3.083691] usb 2-2: configuration #1 chosen from 1 choice
> [    3.089925] usb 2-2: New USB device found, idVendor=05e3, idProduct=0502
> [    3.090008] usb 2-2: New USB device strings: Mfr=0, Product=1, SerialNumber=0
> [    3.090080] usb 2-2: Product: USB Host To Host Bridge
> [    3.200063] usb 3-2: new low speed USB device using uhci_hcd and address 2
> [    3.224394] usb usb4: New USB device found, idVendor=1d6b, idProduct=0001
> [    3.224472] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [    3.224547] usb usb4: Product: UHCI Host Controller
> [    3.224605] usb usb4: Manufacturer: Linux 2.6.27-rc7 uhci_hcd
> [    3.224667] usb usb4: SerialNumber: 0000:00:0a.1
> [    3.225798] ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 5
> [    3.225871] PCI: setting IRQ 5 as level-triggered
> [    3.225883] ehci_hcd 0000:00:0a.2: PCI INT C -> Link[LNKB] -> GSI 5 (level, low) -> IRQ 5
> [    3.225986] ehci_hcd 0000:00:0a.2: EHCI Host Controller
> [    3.226159] ehci_hcd 0000:00:0a.2: new USB bus registered, assigned bus number 5
> [    3.226328] ehci_hcd 0000:00:0a.2: irq 5, io mem 0xda001000
> [    3.328145] ehci_hcd 0000:00:0a.2: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
> [    3.328521] usb usb5: configuration #1 chosen from 1 choice
> [    3.328659] hub 5-0:1.0: USB hub found
> [    3.328740] hub 5-0:1.0: 4 ports detected
> [    3.536474] usb usb5: New USB device found, idVendor=1d6b, idProduct=0002
> [    3.536557] usb usb5: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [    3.536632] usb usb5: Product: EHCI Host Controller
> [    3.536693] usb usb5: Manufacturer: Linux 2.6.27-rc7 ehci_hcd
> [    3.536756] usb usb5: SerialNumber: 0000:00:0a.2
> [    3.576246] Uniform Multi-Platform E-IDE driver
> [    3.579209] via82cxxx 0000:00:07.1: VIA vt82c686b (rev 40) IDE UDMA100
> [    3.579292] via82cxxx 0000:00:07.1: IDE controller (0x1106:0x0571 rev 0x06)
> [    3.579416] via82cxxx 0000:00:07.1: not 100% native mode: will probe irqs later
> [    3.579501]     ide0: BM-DMA at 0xa000-0xa007
> [    3.579570]     ide1: BM-DMA at 0xa008-0xa00f
> [    3.579632] Probing IDE interface ide0...
> [    3.724128] usb 3-2: device not accepting address 2, error -71
> [    3.780081] hub 3-0:1.0: unable to enumerate USB device on port 2
> [    3.996248] hda: Maxtor 91021U2, ATA DISK drive
> [    4.112047] usb 3-2: new low speed USB device using uhci_hcd and address 4
> [    4.288654] usb 3-2: configuration #1 chosen from 1 choice
> [    4.291892] usb 3-2: New USB device found, idVendor=046d, idProduct=c00e
> [    4.291974] usb 3-2: New USB device strings: Mfr=1, Product=2, SerialNumber=0
> [    4.292104] usb 3-2: Product: USB-PS/2 Optical Mouse
> [    4.292163] usb 3-2: Manufacturer: Logitech
> [    4.352886] usbcore: registered new interface driver hiddev
> [    4.366410] input: Logitech USB-PS/2 Optical Mouse as /class/input/input1
> [    4.367439] input,hidraw0: USB HID v1.10 Mouse [Logitech USB-PS/2 Optical Mouse] on usb-0000:00:0a.0-2
> [    4.367706] usbcore: registered new interface driver usbhid
> [    4.367773] usbhid: v2.6:USB HID core driver
> [    4.672170] hda: host max PIO5 wanted PIO255(auto-tune) selected PIO4
> [    4.672409] hda: host side 80-wire cable detection failed, limiting max speed to UDMA33
> [    4.672500] hda: UDMA/33 mode selected
> [    4.672769] Probing IDE interface ide1...
> [    5.536263] hdc: AOPEN CD-RW CRW2040, ATAPI CD/DVD-ROM drive
> [    6.320250] hdd: CDU5211, ATAPI CD/DVD-ROM drive
> [    6.376180] hdc: host max PIO5 wanted PIO255(auto-tune) selected PIO4
> [    6.376348] hdc: MWDMA2 mode selected
> [    6.376666] hdd: host max PIO5 wanted PIO255(auto-tune) selected PIO4
> [    6.376743] hdd: UDMA/33 mode selected
> [    6.376947] ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> [    6.377086] ide1 at 0x170-0x177,0x376 on irq 15
> [    6.434121] hda: max request size: 128KiB
> [    6.452592] hda: 20010816 sectors (10245 MB) w/512KiB Cache, CHS=19852/16/63
> [    6.452745] hda: cache flushes not supported
> [    6.452936]  hda:<6>ide-cd driver 5.00
> [    6.464733]  hda1 hda2 hda3 < hda5 hda6 hda7 >
> [    6.533089] ide-cd: Call ide_cdrom_setup
> [    6.533161] ide-cd: Call ide_cdrom_probe_capabilities, drive->media: 0x5, drive->atapi_flags: 0xa
> [    6.534227] ide-cd: Call ide_cdrom_get_capabilities
> [    6.534289] ide-cd: Call ide_cd_queue_pc, rq->cmd[0]: 0x5a, write: 0x0, timeout: 1750, cmd_flags: 0x0
> [    6.534416] ide-cd: Call ide_cd_do_request, rq->cmd_type: 0xb, block: 18446744073709551615
> [    6.534496] ide-cd: Call cdrom_do_block_pc, rq->cmd_type: 0xb
> [    6.534560] ide-cd: Call cdrom_start_packet_command, xferlen: 24
> [    6.534633] ide-cd: Call cdrom_transfer_packet_command
> [    6.535145] ide-cd: Call cdrom_newpc_intr, rq->cmd[0]: 0x5a, write: 0x0
> [    6.535231] ide-cd: cdrom_newpc_intr: DRQ: stat: 0x58, thislen: 24
> [    6.535296] ide-cd: Call ide_cd_check_ireason, ireason: 0x2, rw: 0x0
> [    6.535362] ide-cd: cdrom_newpc_intr: data transfer, rq->cmd_type: 0xb, ireason: 0x2
> [    6.535655] ide-cd: Call cdrom_newpc_intr, rq->cmd[0]: 0x5a, write: 0x0
> [    6.535731] ide-cd: cdrom_newpc_intr: DRQ: stat: 0x50, thislen: 0
> [    6.535794] ide-cd: Call ide_cd_request_sense_fixup
> [    6.535854] ide-cd: Call cdrom_end_request, cmd: 0x5a, uptodate: 0x1, nsectors: 0
> [    6.535930] ide-cd: Exit cdrom_end_request, uptodate: 0x1, nsectors: 1
> [    6.536340] ide-cd: Call ide_cdrom_update_speed
> [    6.536406] ide-cd: hdc: ATAPI 40X CD-ROM CD-R/RW drive, 2048kB Cache
> [    6.536634] ide-cd: Call ide_cdrom_register, nslots: 1
> [    6.536695] Uniform CD-ROM driver Revision: 3.20
> [    6.536760] ide-cd: Call ide_cd_read_toc
> [    6.536813] ide-cd: Call cdrom_check_status
> [    6.536869] ide-cd: Call ide_cd_queue_pc, rq->cmd[0]: 0x0, write: 0x0, timeout: 0, cmd_flags: 0x1000
> [    6.536982] ide-cd: Call ide_cd_do_request, rq->cmd_type: 0xb, block: 18446744073709551615
> [    6.537061] ide-cd: Call cdrom_do_block_pc, rq->cmd_type: 0xb
> [    6.537123] ide-cd: Call cdrom_start_packet_command, xferlen: 0
> [    6.537196] ide-cd: Call cdrom_transfer_packet_command
> [    6.537418] ide-cd: Call cdrom_newpc_intr, rq->cmd[0]: 0x0, write: 0x0
> [    6.537491] ide-cd: cdrom_decode_status: stat: 0x51, good_stat: 0x0, rq->cmd_type: 0xb, err: 0x20
> [    6.537572] ide-cd: Call cdrom_queue_request_sense
> [    6.537629] ide-cd: failed_cmd: 0x0
> [    6.537691] ide-cd: Call ide_cd_do_request, rq->cmd_type: 0x3, block: 18446744073709551615
> [    6.537770] ide-cd: Call cdrom_do_block_pc, rq->cmd_type: 0x3
> [    6.537832] ide-cd: Call cdrom_start_packet_command, xferlen: 18
> [    6.537905] ide-cd: Call cdrom_transfer_packet_command
> [    6.538300] ide-cd: Call cdrom_newpc_intr, rq->cmd[0]: 0x3, write: 0x0
> [    6.538381] ide-cd: cdrom_newpc_intr: DRQ: stat: 0x58, thislen: 18
> [    6.538446] ide-cd: Call ide_cd_check_ireason, ireason: 0x2, rw: 0x0
> [    6.538511] ide-cd: cdrom_newpc_intr: data transfer, rq->cmd_type: 0x3, ireason: 0x2
> [    6.538723] ide-cd: Call cdrom_newpc_intr, rq->cmd[0]: 0x3, write: 0x0
> [    6.538796] ide-cd: cdrom_newpc_intr: DRQ: stat: 0x50, thislen: 0
> [    6.538859] ide-cd: Call ide_cd_request_sense_fixup
> [    6.538918] ide-cd: Call cdrom_end_request, cmd: 0x3, uptodate: 0x1, nsectors: 0
> [    6.538994] ide-cd: Call cdrom_analyze_sense_data, error_code: 0x70, sense_key: 0x2
> [    6.539070] ide-cd: cdrom_analyze_sense_data: failed cmd: 0x0
> [    6.539133] ATAPI device hdc:
> [    6.539182]   Error: Not ready -- (Sense key=0x02)
> [    6.539276]   Medium not present -- (asc=0x3a, ascq=0x00)
> [    6.539336]   The failed "Test Unit Ready" packet command was: 
> [    6.539340]   "00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 "
> [    6.540091] ide-cd: Exit cdrom_end_request, uptodate: 0x1, nsectors: 1
> [    6.540271] ide-cd: Call cdrom_read_capacity
> [    6.540330] ide-cd: Call ide_cd_queue_pc, rq->cmd[0]: 0x25, write: 0x0, timeout: 0, cmd_flags: 0x1000
> [    6.540439] ide-cd: Call ide_cd_do_request, rq->cmd_type: 0xb, block: 18446744073709551615
> [    6.540519] ide-cd: Call cdrom_do_block_pc, rq->cmd_type: 0xb
> [    6.540581] ide-cd: Call cdrom_start_packet_command, xferlen: 8
> [    6.540654] ide-cd: Call cdrom_transfer_packet_command
> [    6.540891] ide-cd: Call cdrom_newpc_intr, rq->cmd[0]: 0x25, write: 0x0
> [    6.540970] ide-cd: cdrom_decode_status: stat: 0x51, good_stat: 0x0, rq->cmd_type: 0xb, err: 0x20
> [    6.541050] ide-cd: Call cdrom_queue_request_sense
> [    6.541107] ide-cd: failed_cmd: 0x25
> [    6.541170] ide-cd: Call ide_cd_do_request, rq->cmd_type: 0x3, block: 18446744073709551615
> [    6.541249] ide-cd: Call cdrom_do_block_pc, rq->cmd_type: 0x3
> [    6.541313] ide-cd: Call cdrom_start_packet_command, xferlen: 18
> [    6.541385] ide-cd: Call cdrom_transfer_packet_command
> [    6.541634] ide-cd: Call cdrom_newpc_intr, rq->cmd[0]: 0x3, write: 0x0
> [    6.541706] ide-cd: cdrom_newpc_intr: DRQ: stat: 0x58, thislen: 18
> [    6.541771] ide-cd: Call ide_cd_check_ireason, ireason: 0x2, rw: 0x0
> [    6.541836] ide-cd: cdrom_newpc_intr: data transfer, rq->cmd_type: 0x3, ireason: 0x2
> [    6.542017] ide-cd: Call cdrom_newpc_intr, rq->cmd[0]: 0x3, write: 0x0
> [    6.542090] ide-cd: cdrom_newpc_intr: DRQ: stat: 0x50, thislen: 0
> [    6.542153] ide-cd: Call ide_cd_request_sense_fixup
> [    6.542211] ide-cd: Call cdrom_end_request, cmd: 0x3, uptodate: 0x1, nsectors: 0
> [    6.542286] ide-cd: Call cdrom_analyze_sense_data, error_code: 0x70, sense_key: 0x2
> [    6.542362] ide-cd: cdrom_analyze_sense_data: failed cmd: 0x25
> [    6.542423] ATAPI device hdc:
> [    6.542472]   Error: Not ready -- (Sense key=0x02)
> [    6.542564]   Medium not present -- (asc=0x3a, ascq=0x00)
> [    6.542625]   The failed "Read Cd/Dvd Capacity" packet command was: 
> [    6.542628]   "25 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 "
> [    6.543323] ide-cd: Exit cdrom_end_request, uptodate: 0x1, nsectors: 1
> [    6.543423] ide-cd: Call cdrom_read_tocentry
> [    6.543480] ide-cd: Call ide_cd_queue_pc, rq->cmd[0]: 0x43, write: 0x0, timeout: 0, cmd_flags: 0x1000
> [    6.543583] ide-cd: Call ide_cd_do_request, rq->cmd_type: 0xb, block: 18446744073709551615
> [    6.543664] ide-cd: Call cdrom_do_block_pc, rq->cmd_type: 0xb
> [    6.543727] ide-cd: Call cdrom_start_packet_command, xferlen: 4
> [    6.543799] ide-cd: Call cdrom_transfer_packet_command
> [    6.544894] ide-cd: Call cdrom_newpc_intr, rq->cmd[0]: 0x43, write: 0x0
> [    6.544986] ide-cd: cdrom_decode_status: stat: 0x51, good_stat: 0x0, rq->cmd_type: 0xb, err: 0x20
> [    6.545068] ide-cd: Call cdrom_queue_request_sense
> [    6.545127] ide-cd: failed_cmd: 0x43
> [    6.545203] ide-cd: Call ide_cd_do_request, rq->cmd_type: 0x3, block: 18446744073709551615
> [    6.545284] ide-cd: Call cdrom_do_block_pc, rq->cmd_type: 0x3
> [    6.545346] ide-cd: Call cdrom_start_packet_command, xferlen: 18
> [    6.545422] ide-cd: Call cdrom_transfer_packet_command
> [    6.545684] ide-cd: Call cdrom_newpc_intr, rq->cmd[0]: 0x3, write: 0x0
> [    6.545761] ide-cd: cdrom_newpc_intr: DRQ: stat: 0x58, thislen: 18
> [    6.545826] ide-cd: Call ide_cd_check_ireason, ireason: 0x2, rw: 0x0
> [    6.545892] ide-cd: cdrom_newpc_intr: data transfer, rq->cmd_type: 0x3, ireason: 0x2
> [    6.546066] ide-cd: Call cdrom_newpc_intr, rq->cmd[0]: 0x3, write: 0x0
> [    6.546141] ide-cd: cdrom_newpc_intr: DRQ: stat: 0x50, thislen: 0
> [    6.546207] ide-cd: Call ide_cd_request_sense_fixup
> [    6.546266] ide-cd: Call cdrom_end_request, cmd: 0x3, uptodate: 0x1, nsectors: 0
> [    6.546341] ide-cd: Call cdrom_analyze_sense_data, error_code: 0x70, sense_key: 0x2
> [    6.546417] ide-cd: cdrom_analyze_sense_data: failed cmd: 0x43
> [    6.546479] ATAPI device hdc:
> [    6.546528]   Error: Not ready -- (Sense key=0x02)
> [    6.546622]   Medium not present -- (asc=0x3a, ascq=0x00)
> [    6.546685]   The failed "Read Table of Contents" packet command was: 
> [    6.546688]   "43 02 00 00 00 00 00 00 04 00 00 00 00 00 00 00 "
> [    6.547392] ide-cd: Exit cdrom_end_request, uptodate: 0x1, nsectors: 1
> [    6.547760] ide-cd: Call ide_cdrom_setup
> [    6.547824] ide-cd: Call ide_cdrom_probe_capabilities, drive->media: 0x5, drive->atapi_flags: 0xa
> [    6.547906] ide-cd: Call ide_cdrom_get_capabilities
> [    6.547966] ide-cd: Call ide_cd_queue_pc, rq->cmd[0]: 0x5a, write: 0x0, timeout: 1750, cmd_flags: 0x0
> [    6.548144] ide-cd: Call ide_cd_do_request, rq->cmd_type: 0xb, block: 18446744073709551615
> [    6.548226] ide-cd: Call cdrom_do_block_pc, rq->cmd_type: 0xb
> [    6.548289] ide-cd: Call cdrom_start_packet_command, xferlen: 24
> [    6.548362] ide-cd: Call cdrom_transfer_packet_command
> [    6.549177] ide-cd: Call cdrom_newpc_intr, rq->cmd[0]: 0x5a, write: 0x0
> [    6.549271] ide-cd: cdrom_newpc_intr: DRQ: stat: 0x58, thislen: 24
> [    6.549336] ide-cd: Call ide_cd_check_ireason, ireason: 0x2, rw: 0x0
> [    6.549402] ide-cd: cdrom_newpc_intr: data transfer, rq->cmd_type: 0xb, ireason: 0x2
> [    6.549533] ide-cd: Call cdrom_newpc_intr, rq->cmd[0]: 0x5a, write: 0x0
> [    6.549608] ide-cd: cdrom_newpc_intr: DRQ: stat: 0x50, thislen: 0
> [    6.549672] ide-cd: Call ide_cd_request_sense_fixup
> [    6.549731] ide-cd: Call cdrom_end_request, cmd: 0x5a, uptodate: 0x1, nsectors: 0
> [    6.549807] ide-cd: Exit cdrom_end_request, uptodate: 0x1, nsectors: 1
> [    6.549988] ide-cd: Call ide_cdrom_update_speed
> [    6.550046] ide-cd: hdd: ATAPI 52X CD-ROM drive, 120kB Cache
> [    6.550239] ide-cd: Call ide_cdrom_register, nslots: 1
> [    6.550306] ide-cd: Call ide_cd_read_toc
> [    6.550360] ide-cd: Call cdrom_check_status
> [    6.550415] ide-cd: Call ide_cd_queue_pc, rq->cmd[0]: 0x0, write: 0x0, timeout: 0, cmd_flags: 0x1000
> [    6.550525] ide-cd: Call ide_cd_do_request, rq->cmd_type: 0xb, block: 18446744073709551615
> [    6.550604] ide-cd: Call cdrom_do_block_pc, rq->cmd_type: 0xb
> [    6.550667] ide-cd: Call cdrom_start_packet_command, xferlen: 0
> [    6.550740] ide-cd: Call cdrom_transfer_packet_command
> [    6.550939] ide-cd: Call cdrom_newpc_intr, rq->cmd[0]: 0x0, write: 0x0
> [    6.551011] ide-cd: cdrom_decode_status: stat: 0x51, good_stat: 0x0, rq->cmd_type: 0xb, err: 0x20
> [    6.551092] ide-cd: Call cdrom_queue_request_sense
> [    6.551149] ide-cd: failed_cmd: 0x0
> [    6.552224] ide-cd: Call ide_cd_do_request, rq->cmd_type: 0x3, block: 18446744073709551615
> [    6.552304] ide-cd: Call cdrom_do_block_pc, rq->cmd_type: 0x3
> [    6.552366] ide-cd: Call cdrom_start_packet_command, xferlen: 18
> [    6.552436] ide-cd: Call cdrom_transfer_packet_command
> [    6.552629] ide-cd: Call cdrom_newpc_intr, rq->cmd[0]: 0x3, write: 0x0
> [    6.552705] ide-cd: cdrom_newpc_intr: DRQ: stat: 0x58, thislen: 18
> [    6.552771] ide-cd: Call ide_cd_check_ireason, ireason: 0x2, rw: 0x0
> [    6.552837] ide-cd: cdrom_newpc_intr: data transfer, rq->cmd_type: 0x3, ireason: 0x2
> [    6.552963] ide-cd: Call cdrom_newpc_intr, rq->cmd[0]: 0x3, write: 0x0
> [    6.553035] ide-cd: cdrom_newpc_intr: DRQ: stat: 0x50, thislen: 0
> [    6.553098] ide-cd: Call ide_cd_request_sense_fixup
> [    6.553155] ide-cd: Call cdrom_end_request, cmd: 0x3, uptodate: 0x1, nsectors: 0
> [    6.553231] ide-cd: Call cdrom_analyze_sense_data, error_code: 0x70, sense_key: 0x2
> [    6.553307] ide-cd: cdrom_analyze_sense_data: failed cmd: 0x0
> [    6.553368] ATAPI device hdd:
> [    6.553417]   Error: Not ready -- (Sense key=0x02)
> [    6.553508]   Medium not present -- (asc=0x3a, ascq=0x00)
> [    6.553569]   The failed "Test Unit Ready" packet command was: 
> [    6.553573]   "00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 "
> [    6.554259] ide-cd: Exit cdrom_end_request, uptodate: 0x1, nsectors: 1
> [    6.554347] ide-cd: Call cdrom_read_capacity
> [    6.554405] ide-cd: Call ide_cd_queue_pc, rq->cmd[0]: 0x25, write: 0x0, timeout: 0, cmd_flags: 0x1000
> [    6.554507] ide-cd: Call ide_cd_do_request, rq->cmd_type: 0xb, block: 18446744073709551615
> [    6.554586] ide-cd: Call cdrom_do_block_pc, rq->cmd_type: 0xb
> [    6.554648] ide-cd: Call cdrom_start_packet_command, xferlen: 8
> [    6.554719] ide-cd: Call cdrom_transfer_packet_command
> [    6.554922] ide-cd: Call cdrom_newpc_intr, rq->cmd[0]: 0x25, write: 0x0
> [    6.554995] ide-cd: cdrom_decode_status: stat: 0x51, good_stat: 0x0, rq->cmd_type: 0xb, err: 0x20
> [    6.555077] ide-cd: Call cdrom_queue_request_sense
> [    6.555133] ide-cd: failed_cmd: 0x25
> [    6.555195] ide-cd: Call ide_cd_do_request, rq->cmd_type: 0x3, block: 18446744073709551615
> [    6.555275] ide-cd: Call cdrom_do_block_pc, rq->cmd_type: 0x3
> [    6.555336] ide-cd: Call cdrom_start_packet_command, xferlen: 18
> [    6.555407] ide-cd: Call cdrom_transfer_packet_command
> [    6.555598] ide-cd: Call cdrom_newpc_intr, rq->cmd[0]: 0x3, write: 0x0
> [    6.555673] ide-cd: cdrom_newpc_intr: DRQ: stat: 0x58, thislen: 18
> [    6.555738] ide-cd: Call ide_cd_check_ireason, ireason: 0x2, rw: 0x0
> [    6.555803] ide-cd: cdrom_newpc_intr: data transfer, rq->cmd_type: 0x3, ireason: 0x2
> [    6.555928] ide-cd: Call cdrom_newpc_intr, rq->cmd[0]: 0x3, write: 0x0
> [    6.556000] ide-cd: cdrom_newpc_intr: DRQ: stat: 0x50, thislen: 0
> [    6.556106] ide-cd: Call ide_cd_request_sense_fixup
> [    6.556165] ide-cd: Call cdrom_end_request, cmd: 0x3, uptodate: 0x1, nsectors: 0
> [    6.556241] ide-cd: Call cdrom_analyze_sense_data, error_code: 0x70, sense_key: 0x2
> [    6.556318] ide-cd: cdrom_analyze_sense_data: failed cmd: 0x25
> [    6.556381] ATAPI device hdd:
> [    6.556431]   Error: Not ready -- (Sense key=0x02)
> [    6.556523]   Medium not present -- (asc=0x3a, ascq=0x00)
> [    6.556583]   The failed "Read Cd/Dvd Capacity" packet command was: 
> [    6.556587]   "25 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 "
> [    6.557281] ide-cd: Exit cdrom_end_request, uptodate: 0x1, nsectors: 1
> [    6.557389] ide-cd: Call cdrom_read_tocentry
> [    6.557447] ide-cd: Call ide_cd_queue_pc, rq->cmd[0]: 0x43, write: 0x0, timeout: 0, cmd_flags: 0x1000
> [    6.557551] ide-cd: Call ide_cd_do_request, rq->cmd_type: 0xb, block: 18446744073709551615
> [    6.557630] ide-cd: Call cdrom_do_block_pc, rq->cmd_type: 0xb
> [    6.557692] ide-cd: Call cdrom_start_packet_command, xferlen: 4
> [    6.557763] ide-cd: Call cdrom_transfer_packet_command
> [    6.557953] ide-cd: Call cdrom_newpc_intr, rq->cmd[0]: 0x43, write: 0x0
> [    6.558028] ide-cd: cdrom_decode_status: stat: 0x51, good_stat: 0x0, rq->cmd_type: 0xb, err: 0x20
> [    6.558108] ide-cd: Call cdrom_queue_request_sense
> [    6.558164] ide-cd: failed_cmd: 0x43
> [    6.558227] ide-cd: Call ide_cd_do_request, rq->cmd_type: 0x3, block: 18446744073709551615
> [    6.558305] ide-cd: Call cdrom_do_block_pc, rq->cmd_type: 0x3
> [    6.558367] ide-cd: Call cdrom_start_packet_command, xferlen: 18
> [    6.558438] ide-cd: Call cdrom_transfer_packet_command
> [    6.558631] ide-cd: Call cdrom_newpc_intr, rq->cmd[0]: 0x3, write: 0x0
> [    6.558708] ide-cd: cdrom_newpc_intr: DRQ: stat: 0x58, thislen: 18
> [    6.558772] ide-cd: Call ide_cd_check_ireason, ireason: 0x2, rw: 0x0
> [    6.558838] ide-cd: cdrom_newpc_intr: data transfer, rq->cmd_type: 0x3, ireason: 0x2
> [    6.558962] ide-cd: Call cdrom_newpc_intr, rq->cmd[0]: 0x3, write: 0x0
> [    6.559034] ide-cd: cdrom_newpc_intr: DRQ: stat: 0x50, thislen: 0
> [    6.559096] ide-cd: Call ide_cd_request_sense_fixup
> [    6.559154] ide-cd: Call cdrom_end_request, cmd: 0x3, uptodate: 0x1, nsectors: 0
> [    6.559229] ide-cd: Call cdrom_analyze_sense_data, error_code: 0x70, sense_key: 0x2
> [    6.559304] ide-cd: cdrom_analyze_sense_data: failed cmd: 0x43
> [    6.559368] ATAPI device hdd:
> [    6.559418]   Error: Not ready -- (Sense key=0x02)
> [    6.559510]   Medium not present -- (asc=0x3a, ascq=0x00)
> [    6.559570]   The failed "Read Table of Contents" packet command was: 
> [    6.559574]   "43 02 00 00 00 00 00 00 04 00 00 00 00 00 00 00 "
> [    6.560319] ide-cd: Exit cdrom_end_request, uptodate: 0x1, nsectors: 1
> [    6.582889] ide-cd: Call cdrom_check_status
> [    6.582968] ide-cd: Call ide_cd_queue_pc, rq->cmd[0]: 0x0, write: 0x0, timeout: 0, cmd_flags: 0x1000
> [    6.583105] ide-cd: Call ide_cd_do_request, rq->cmd_type: 0xb, block: 18446744073709551615
> [    6.583186] ide-cd: Call cdrom_do_block_pc, rq->cmd_type: 0xb
> [    6.583248] ide-cd: Call cdrom_start_packet_command, xferlen: 0
> [    6.583323] ide-cd: Call cdrom_transfer_packet_command
> [    6.583565] ide-cd: Call cdrom_newpc_intr, rq->cmd[0]: 0x0, write: 0x0
> [    6.583639] ide-cd: cdrom_decode_status: stat: 0x51, good_stat: 0x0, rq->cmd_type: 0xb, err: 0x20
> [    6.583721] ide-cd: Call cdrom_queue_request_sense
> [    6.583779] ide-cd: failed_cmd: 0x0
> [    6.583841] ide-cd: Call ide_cd_do_request, rq->cmd_type: 0x3, block: 18446744073709551615
> [    6.583919] ide-cd: Call cdrom_do_block_pc, rq->cmd_type: 0x3
> [    6.583982] ide-cd: Call cdrom_start_packet_command, xferlen: 18
> [    6.584104] ide-cd: Call cdrom_transfer_packet_command
> [    6.584358] ide-cd: Call cdrom_newpc_intr, rq->cmd[0]: 0x3, write: 0x0
> [    6.584435] ide-cd: cdrom_newpc_intr: DRQ: stat: 0x58, thislen: 18
> [    6.584499] ide-cd: Call ide_cd_check_ireason, ireason: 0x2, rw: 0x0
> [    6.584564] ide-cd: cdrom_newpc_intr: data transfer, rq->cmd_type: 0x3, ireason: 0x2
> [    6.584741] ide-cd: Call cdrom_newpc_intr, rq->cmd[0]: 0x3, write: 0x0
> [    6.584814] ide-cd: cdrom_newpc_intr: DRQ: stat: 0x50, thislen: 0
> [    6.584876] ide-cd: Call ide_cd_request_sense_fixup
> [    6.584935] ide-cd: Call cdrom_end_request, cmd: 0x3, uptodate: 0x1, nsectors: 0
> [    6.585010] ide-cd: Call cdrom_analyze_sense_data, error_code: 0x70, sense_key: 0x2
> [    6.585085] ide-cd: cdrom_analyze_sense_data: failed cmd: 0x0
> [    6.585147] ATAPI device hdc:
> [    6.585195]   Error: Not ready -- (Sense key=0x02)
> [    6.585287]   Medium not present -- (asc=0x3a, ascq=0x00)
> [    6.585347]   The failed "Test Unit Ready" packet command was: 
> [    6.585351]   "00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 "
> [    6.586061] ide-cd: Exit cdrom_end_request, uptodate: 0x1, nsectors: 1
> [    6.587918] ide-cd: Call ide_cd_read_toc
> [    6.587983] ide-cd: Call cdrom_check_status
> [    6.588083] ide-cd: Call ide_cd_queue_pc, rq->cmd[0]: 0x0, write: 0x0, timeout: 0, cmd_flags: 0x1000
> [    6.588201] ide-cd: Call ide_cd_do_request, rq->cmd_type: 0xb, block: 18446744073709551615
> [    6.588282] ide-cd: Call cdrom_do_block_pc, rq->cmd_type: 0xb
> [    6.588344] ide-cd: Call cdrom_start_packet_command, xferlen: 0
> [    6.588416] ide-cd: Call cdrom_transfer_packet_command
> [    6.588666] ide-cd: Call cdrom_newpc_intr, rq->cmd[0]: 0x0, write: 0x0
> [    6.588739] ide-cd: cdrom_decode_status: stat: 0x51, good_stat: 0x0, rq->cmd_type: 0xb, err: 0x20
> [    6.588820] ide-cd: Call cdrom_queue_request_sense
> [    6.588877] ide-cd: failed_cmd: 0x0
> [    6.588939] ide-cd: Call ide_cd_do_request, rq->cmd_type: 0x3, block: 18446744073709551615
> [    6.589018] ide-cd: Call cdrom_do_block_pc, rq->cmd_type: 0x3
> [    6.589080] ide-cd: Call cdrom_start_packet_command, xferlen: 18
> [    6.589152] ide-cd: Call cdrom_transfer_packet_command
> [    6.589411] ide-cd: Call cdrom_newpc_intr, rq->cmd[0]: 0x3, write: 0x0
> [    6.589484] ide-cd: cdrom_newpc_intr: DRQ: stat: 0x58, thislen: 18
> [    6.589549] ide-cd: Call ide_cd_check_ireason, ireason: 0x2, rw: 0x0
> [    6.589614] ide-cd: cdrom_newpc_intr: data transfer, rq->cmd_type: 0x3, ireason: 0x2
> [    6.589786] ide-cd: Call cdrom_newpc_intr, rq->cmd[0]: 0x3, write: 0x0
> [    6.589858] ide-cd: cdrom_newpc_intr: DRQ: stat: 0x50, thislen: 0
> [    6.589921] ide-cd: Call ide_cd_request_sense_fixup
> [    6.589979] ide-cd: Call cdrom_end_request, cmd: 0x3, uptodate: 0x1, nsectors: 0
> [    6.590055] ide-cd: Call cdrom_analyze_sense_data, error_code: 0x70, sense_key: 0x2
> [    6.590131] ide-cd: cdrom_analyze_sense_data: failed cmd: 0x0
> [    6.590193] ATAPI device hdc:
> [    6.590242]   Error: Not ready -- (Sense key=0x02)
> [    6.590334]   Medium not present -- (asc=0x3a, ascq=0x00)
> [    6.590398]   The failed "Test Unit Ready" packet command was: 
> [    6.590401]   "00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 "
> [    6.591093] ide-cd: Exit cdrom_end_request, uptodate: 0x1, nsectors: 1
> [    6.592975] ide-cd: Call cdrom_read_capacity
> [    6.593049] ide-cd: Call ide_cd_queue_pc, rq->cmd[0]: 0x25, write: 0x0, timeout: 0, cmd_flags: 0x1000
> [    6.594195] ide-cd: Call ide_cd_do_request, rq->cmd_type: 0xb, block: 18446744073709551615
> [    6.594279] ide-cd: Call cdrom_do_block_pc, rq->cmd_type: 0xb
> [    6.594341] ide-cd: Call cdrom_start_packet_command, xferlen: 8
> [    6.594413] ide-cd: Call cdrom_transfer_packet_command
> [    6.594660] ide-cd: Call cdrom_newpc_intr, rq->cmd[0]: 0x25, write: 0x0
> [    6.594736] ide-cd: cdrom_decode_status: stat: 0x51, good_stat: 0x0, rq->cmd_type: 0xb, err: 0x20
> [    6.594817] ide-cd: Call cdrom_queue_request_sense
> [    6.594874] ide-cd: failed_cmd: 0x25
> [    6.594937] ide-cd: Call ide_cd_do_request, rq->cmd_type: 0x3, block: 18446744073709551615
> [    6.595016] ide-cd: Call cdrom_do_block_pc, rq->cmd_type: 0x3
> [    6.595078] ide-cd: Call cdrom_start_packet_command, xferlen: 18
> [    6.595151] ide-cd: Call cdrom_transfer_packet_command
> [    6.595404] ide-cd: Call cdrom_newpc_intr, rq->cmd[0]: 0x3, write: 0x0
> [    6.595479] ide-cd: cdrom_newpc_intr: DRQ: stat: 0x58, thislen: 18
> [    6.595543] ide-cd: Call ide_cd_check_ireason, ireason: 0x2, rw: 0x0
> [    6.595608] ide-cd: cdrom_newpc_intr: data transfer, rq->cmd_type: 0x3, ireason: 0x2
> [    6.595786] ide-cd: Call cdrom_newpc_intr, rq->cmd[0]: 0x3, write: 0x0
> [    6.595861] ide-cd: cdrom_newpc_intr: DRQ: stat: 0x50, thislen: 0
> [    6.595925] ide-cd: Call ide_cd_request_sense_fixup
> [    6.595983] ide-cd: Call cdrom_end_request, cmd: 0x3, uptodate: 0x1, nsectors: 0
> [    6.596111] ide-cd: Call cdrom_analyze_sense_data, error_code: 0x70, sense_key: 0x2
> [    6.596188] ide-cd: cdrom_analyze_sense_data: failed cmd: 0x25
> [    6.596251] ATAPI device hdc:
> [    6.596301]   Error: Not ready -- (Sense key=0x02)
> [    6.596394]   Medium not present -- (asc=0x3a, ascq=0x00)
> [    6.596454]   The failed "Read Cd/Dvd Capacity" packet command was: 
> [    6.596458]   "25 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 "
> [    6.597156] ide-cd: Exit cdrom_end_request, uptodate: 0x1, nsectors: 1
> [    6.597256] ide-cd: Call cdrom_read_tocentry
> [    6.597317] ide-cd: Call ide_cd_queue_pc, rq->cmd[0]: 0x43, write: 0x0, timeout: 0, cmd_flags: 0x1000
> [    6.597424] ide-cd: Call ide_cd_do_request, rq->cmd_type: 0xb, block: 18446744073709551615
> [    6.597503] ide-cd: Call cdrom_do_block_pc, rq->cmd_type: 0xb
> [    6.597565] ide-cd: Call cdrom_start_packet_command, xferlen: 4
> [    6.597638] ide-cd: Call cdrom_transfer_packet_command
> [    6.598760] ide-cd: Call cdrom_newpc_intr, rq->cmd[0]: 0x43, write: 0x0
> [    6.598851] ide-cd: cdrom_decode_status: stat: 0x51, good_stat: 0x0, rq->cmd_type: 0xb, err: 0x20
> [    6.598933] ide-cd: Call cdrom_queue_request_sense
> [    6.598991] ide-cd: failed_cmd: 0x43
> [    6.599070] ide-cd: Call ide_cd_do_request, rq->cmd_type: 0x3, block: 18446744073709551615
> [    6.599149] ide-cd: Call cdrom_do_block_pc, rq->cmd_type: 0x3
> [    6.599211] ide-cd: Call cdrom_start_packet_command, xferlen: 18
> [    6.599286] ide-cd: Call cdrom_transfer_packet_command
> [    6.599552] ide-cd: Call cdrom_newpc_intr, rq->cmd[0]: 0x3, write: 0x0
> [    6.599629] ide-cd: cdrom_newpc_intr: DRQ: stat: 0x58, thislen: 18
> [    6.599695] ide-cd: Call ide_cd_check_ireason, ireason: 0x2, rw: 0x0
> [    6.599760] ide-cd: cdrom_newpc_intr: data transfer, rq->cmd_type: 0x3, ireason: 0x2
> [    6.599977] ide-cd: Call cdrom_newpc_intr, rq->cmd[0]: 0x3, write: 0x0
> [    6.600103] ide-cd: cdrom_newpc_intr: DRQ: stat: 0x50, thislen: 0
> [    6.600168] ide-cd: Call ide_cd_request_sense_fixup
> [    6.600227] ide-cd: Call cdrom_end_request, cmd: 0x3, uptodate: 0x1, nsectors: 0
> [    6.600302] ide-cd: Call cdrom_analyze_sense_data, error_code: 0x70, sense_key: 0x2
> [    6.600380] ide-cd: cdrom_analyze_sense_data: failed cmd: 0x43
> [    6.600444] ATAPI device hdc:
> [    6.600493]   Error: Not ready -- (Sense key=0x02)
> [    6.600585]   Medium not present -- (asc=0x3a, ascq=0x00)
> [    6.600646]   The failed "Read Table of Contents" packet command was: 
> [    6.600649]   "43 02 00 00 00 00 00 00 04 00 00 00 00 00 00 00 "
> [    6.601359] ide-cd: Exit cdrom_end_request, uptodate: 0x1, nsectors: 1
> [    6.601644] ide-cd: Call ide_cd_do_request, rq->cmd_type: 0x2, block: 18446744073709551615
> [    6.601728] Sending BLOCK_PC to drive! Fixed.
> [    6.601785] Original rq: : dev hdc: type=2, flags=504c8
> [    6.601845]   sector 18446744073709551615, nr/cnr 0/0
> [    6.601905]   bio cf87b5a0, biotail cf87b5a0, buffer 00000000, data 00000000, len 36
> [    6.601979]   cdb: 12 00 00 00 24 00 00 00 00 00 00 00 00 00 00 00 
> [    6.602597] rq->cmd_len: 6
> [    6.602650] Pid: 808, comm: cdrom_id Not tainted 2.6.27-rc7 #1
> [    6.602725]  [<d0900d0b>] ide_cd_do_request+0x4d9/0x6c6 [ide_cd_mod]
> [    6.602848]  [<c01e9b50>] __const_udelay+0x29/0x2a
> [    6.602945]  [<d090bb68>] __ide_wait_stat+0xab/0xd6 [ide_core]
> [    6.603105]  [<d090c68b>] ide_wait_stat+0x3f/0x6c [ide_core]
> [    6.603228]  [<d090adc3>] ide_do_request+0x671/0x876 [ide_core]
> [    6.603355]  [<c02bdc3c>] _spin_lock_irqsave+0x23/0x29
> [    6.603453]  [<c012b978>] lock_timer_base+0x19/0x35
> [    6.603552]  [<c012b978>] lock_timer_base+0x19/0x35
> [    6.603645]  [<c012ba3c>] del_timer+0x4a/0x50
> [    6.603734]  [<c01d855f>] elv_insert+0xc2/0x1d6
> [    6.603827]  [<c01dc491>] blk_execute_rq_nowait+0x5a/0x87
> [    6.603929]  [<c01dc539>] blk_execute_rq+0x7b/0x96
> [    6.604067]  [<c01dc414>] blk_end_sync_rq+0x0/0x23
> [    6.604164]  [<c0199e84>] bio_add_pc_page+0x16/0x1b
> [    6.604259]  [<c019a422>] bio_copy_user_iov+0x10d/0x169
> [    6.604356]  [<c01d8c05>] blk_rq_bio_prep+0x73/0xa6
> [    6.604450]  [<c01dc266>] blk_rq_append_bio+0x11/0x3a
> [    6.604545]  [<c01dc37e>] blk_rq_map_user+0xef/0x185
> [    6.604640]  [<c01deb90>] sg_io+0x1eb/0x2c8
> [    6.604733]  [<c01df0bb>] scsi_cmd_ioctl+0x1b8/0x40d
> [    6.604826]  [<c015a744>] find_get_page+0x1f/0x81
> [    6.604923]  [<c015ab06>] find_lock_page+0x10/0x43
> [    6.605016]  [<c015b12a>] filemap_fault+0x1f3/0x344
> [    6.605110]  [<d08f9c5e>] cdrom_ioctl+0x25/0xb31 [cdrom]
> [    6.605218]  [<c0167d5e>] handle_mm_fault+0x2f5/0x6e9
> [    6.605319]  [<d09004aa>] idecd_ioctl+0x12d/0x142 [ide_cd_mod]
> [    6.605422]  [<c018036c>] do_lookup+0x53/0x153
> [    6.605521]  [<c0188932>] dput+0x16/0x103
> [    6.605615]  [<c01dd0cb>] blkdev_driver_ioctl+0x4b/0x5b
> [    6.605711]  [<c01dd795>] blkdev_ioctl+0x6ba/0x6d9
> [    6.605805]  [<c019b4ae>] blkdev_open+0x0/0x4d
> [    6.605915]  [<c019b4d3>] blkdev_open+0x25/0x4d
> [    6.606007]  [<c0178ae5>] __dentry_open+0x130/0x1fc
> [    6.606108]  [<c0178c2e>] nameidata_to_filp+0x1c/0x2c
> [    6.606203]  [<c0183405>] do_filp_open+0x34b/0x6a0
> [    6.606299]  [<c011511f>] __ptep_modify_prot_start+0x16/0x2e
> [    6.606408]  [<c019aaf9>] block_ioctl+0x13/0x16
> [    6.606500]  [<c019aae6>] block_ioctl+0x0/0x16
> [    6.606590]  [<c01840ac>] vfs_ioctl+0x1c/0x5f
> [    6.606680]  [<c0184331>] do_vfs_ioctl+0x242/0x255
> [    6.606771]  [<c017894e>] do_sys_open+0xaa/0xb2
> [    6.606864]  [<c0184385>] sys_ioctl+0x41/0x58
> [    6.606954]  [<c010398e>] syscall_call+0x7/0xb
> [    6.607049]  =======================
> [    6.607102] ide-cd: Call cdrom_do_block_pc, rq->cmd_type: 0xb
> [    6.607166] ide-cd: Call cdrom_start_packet_command, xferlen: 36
> [    6.607239] ide-cd: Call cdrom_transfer_packet_command
> [    6.607978] ide-cd: Call cdrom_newpc_intr, rq->cmd[0]: 0x12, write: 0x0
> [    6.608117] ide-cd: cdrom_newpc_intr: DRQ: stat: 0x58, thislen: 36
> [    6.608183] ide-cd: Call ide_cd_check_ireason, ireason: 0x2, rw: 0x0
> [    6.608249] ide-cd: cdrom_newpc_intr: data transfer, rq->cmd_type: 0xb, ireason: 0x2
> [    6.608412] ide-cd: Call cdrom_newpc_intr, rq->cmd[0]: 0x12, write: 0x0
> [    6.608485] ide-cd: cdrom_newpc_intr: DRQ: stat: 0x50, thislen: 0
> [    6.608547] ide-cd: Call ide_cd_request_sense_fixup
> [    6.608606] ide-cd: Call cdrom_end_request, cmd: 0x12, uptodate: 0x1, nsectors: 0
> [    6.608682] ide-cd: Exit cdrom_end_request, uptodate: 0x1, nsectors: 1
> [    6.610394] ide-cd: Call ide_cd_do_request, rq->cmd_type: 0x2, block: 18446744073709551615
> [    6.610487] Sending BLOCK_PC to drive! Fixed.
> [    6.610544] Original rq: : dev hdc: type=2, flags=504c8
> [    6.610604]   sector 18446744073709551615, nr/cnr 0/0
> [    6.610664]   bio cf87b5a0, biotail cf87b5a0, buffer 00000000, data 00000000, len 8
> [    6.610739]   cdb: 46 00 00 00 00 00 00 00 08 00 00 00 00 00 00 00 
> [    6.611354] rq->cmd_len: 10
> [    6.611407] Pid: 808, comm: cdrom_id Not tainted 2.6.27-rc7 #1
> [    6.611483]  [<d0900d0b>] ide_cd_do_request+0x4d9/0x6c6 [ide_cd_mod]
> [    6.611605]  [<c01e9b50>] __const_udelay+0x29/0x2a
> [    6.611703]  [<d090bb68>] __ide_wait_stat+0xab/0xd6 [ide_core]
> [    6.611861]  [<d090c68b>] ide_wait_stat+0x3f/0x6c [ide_core]
> [    6.611984]  [<d090adc3>] ide_do_request+0x671/0x876 [ide_core]
> [    6.612167]  [<c02bdc3c>] _spin_lock_irqsave+0x23/0x29
> [    6.612264]  [<c012b978>] lock_timer_base+0x19/0x35
> [    6.612362]  [<c012b978>] lock_timer_base+0x19/0x35
> [    6.612455]  [<c012ba3c>] del_timer+0x4a/0x50
> [    6.612545]  [<c01d855f>] elv_insert+0xc2/0x1d6
> [    6.612639]  [<c01dc491>] blk_execute_rq_nowait+0x5a/0x87
> [    6.612743]  [<c01dc539>] blk_execute_rq+0x7b/0x96
> [    6.612836]  [<c01dc414>] blk_end_sync_rq+0x0/0x23
> [    6.612929]  [<c0199e84>] bio_add_pc_page+0x16/0x1b
> [    6.613025]  [<c019a422>] bio_copy_user_iov+0x10d/0x169
> [    6.613119]  [<c01d8c05>] blk_rq_bio_prep+0x73/0xa6
> [    6.613212]  [<c01dc266>] blk_rq_append_bio+0x11/0x3a
> [    6.613308]  [<c01dc37e>] blk_rq_map_user+0xef/0x185
> [    6.613402]  [<c01deb90>] sg_io+0x1eb/0x2c8
> [    6.613496]  [<c01df0bb>] scsi_cmd_ioctl+0x1b8/0x40d
> [    6.613593]  [<c015a744>] find_get_page+0x1f/0x81
> [    6.613691]  [<c015ab06>] find_lock_page+0x10/0x43
> [    6.613783]  [<c015b12a>] filemap_fault+0x1f3/0x344
> [    6.613880]  [<d08f9c5e>] cdrom_ioctl+0x25/0xb31 [cdrom]
> [    6.613989]  [<c0167d5e>] handle_mm_fault+0x2f5/0x6e9
> [    6.615114]  [<d09004aa>] idecd_ioctl+0x12d/0x142 [ide_cd_mod]
> [    6.615218]  [<c018036c>] do_lookup+0x53/0x153
> [    6.615316]  [<c0188932>] dput+0x16/0x103
> [    6.615409]  [<c01dd0cb>] blkdev_driver_ioctl+0x4b/0x5b
> [    6.615504]  [<c01dd795>] blkdev_ioctl+0x6ba/0x6d9
> [    6.615597]  [<c019b4ae>] blkdev_open+0x0/0x4d
> [    6.615688]  [<c019b4d3>] blkdev_open+0x25/0x4d
> [    6.615781]  [<c0178ae5>] __dentry_open+0x130/0x1fc
> [    6.615901]  [<c0178c2e>] nameidata_to_filp+0x1c/0x2c
> [    6.615996]  [<c0183405>] do_filp_open+0x34b/0x6a0
> [    6.616118]  [<c011511f>] __ptep_modify_prot_start+0x16/0x2e
> [    6.616228]  [<c019aaf9>] block_ioctl+0x13/0x16
> [    6.616319]  [<c019aae6>] block_ioctl+0x0/0x16
> [    6.616409]  [<c01840ac>] vfs_ioctl+0x1c/0x5f
> [    6.616499]  [<c0184331>] do_vfs_ioctl+0x242/0x255
> [    6.616589]  [<c017894e>] do_sys_open+0xaa/0xb2
> [    6.616680]  [<c0184385>] sys_ioctl+0x41/0x58
> [    6.616769]  [<c010398e>] syscall_call+0x7/0xb
> [    6.616864]  =======================
> [    6.616918] ide-cd: Call cdrom_do_block_pc, rq->cmd_type: 0xb
> [    6.616981] ide-cd: Call cdrom_start_packet_command, xferlen: 8
> [    6.617055] ide-cd: Call cdrom_transfer_packet_command
> [    6.619223] ide-cd: Call cdrom_newpc_intr, rq->cmd[0]: 0x46, write: 0x0
> [    6.619314] ide-cd: cdrom_decode_status: stat: 0x59, good_stat: 0x0, rq->cmd_type: 0xb, err: 0x20
> [    6.619396] ide-cd: Call cdrom_queue_request_sense
> [    6.619455] ide-cd: failed_cmd: 0x46
> [    6.619548] hdc: status error: status=0x59 { DriveReady SeekComplete DataRequest Error }
> [    6.619790] hdc: status error: error=0x20 { LastFailedSense=0x02 }
> [    6.619952] ide: failed opcode was: unknown
> [    6.620101] hdc: drive not ready for command 0x3
> [    6.622487] ide-cd: Call cdrom_check_status
> [    6.622565] ide-cd: Call ide_cd_queue_pc, rq->cmd[0]: 0x0, write: 0x0, timeout: 0, cmd_flags: 0x1000
> [    6.622702] ide-cd: Call ide_cd_do_request, rq->cmd_type: 0xb, block: 18446744073709551615
> [    6.622782] ide-cd: Call cdrom_do_block_pc, rq->cmd_type: 0xb
> [    6.622845] ide-cd: Call cdrom_start_packet_command, xferlen: 0
> [    6.622917] ide-cd: Call cdrom_transfer_packet_command
> [    6.623125] ide-cd: Call cdrom_newpc_intr, rq->cmd[0]: 0x0, write: 0x0
> [    6.623199] ide-cd: cdrom_decode_status: stat: 0x51, good_stat: 0x0, rq->cmd_type: 0xb, err: 0x20
> [    6.623281] ide-cd: Call cdrom_queue_request_sense
> [    6.623337] ide-cd: failed_cmd: 0x0
> [    6.623399] ide-cd: Call ide_cd_do_request, rq->cmd_type: 0x3, block: 18446744073709551615
> [    6.623477] ide-cd: Call cdrom_do_block_pc, rq->cmd_type: 0x3
> [    6.623539] ide-cd: Call cdrom_start_packet_command, xferlen: 18
> [    6.623610] ide-cd: Call cdrom_transfer_packet_command
> [    6.623801] ide-cd: Call cdrom_newpc_intr, rq->cmd[0]: 0x3, write: 0x0
> [    6.623876] ide-cd: cdrom_newpc_intr: DRQ: stat: 0x58, thislen: 18
> [    6.623941] ide-cd: Call ide_cd_check_ireason, ireason: 0x2, rw: 0x0
> [    6.624005] ide-cd: cdrom_newpc_intr: data transfer, rq->cmd_type: 0x3, ireason: 0x2
> [    6.624179] ide-cd: Call cdrom_newpc_intr, rq->cmd[0]: 0x3, write: 0x0
> [    6.624254] ide-cd: cdrom_newpc_intr: DRQ: stat: 0x50, thislen: 0
> [    6.624319] ide-cd: Call ide_cd_request_sense_fixup
> [    6.624378] ide-cd: Call cdrom_end_request, cmd: 0x3, uptodate: 0x1, nsectors: 0
> [    6.624488] ide-cd: Call cdrom_analyze_sense_data, error_code: 0x70, sense_key: 0x2
> [    6.624564] ide-cd: cdrom_analyze_sense_data: failed cmd: 0x0
> [    6.624626] ATAPI device hdd:
> [    6.624674]   Error: Not ready -- (Sense key=0x02)
> [    6.624767]   Medium not present -- (asc=0x3a, ascq=0x00)
> [    6.624829]   The failed "Test Unit Ready" packet command was: 
> [    6.624833]   "00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 "
> [    6.625530] ide-cd: Exit cdrom_end_request, uptodate: 0x1, nsectors: 1
> [    6.625631] ide-cd: Call ide_cd_read_toc
> [    6.625686] ide-cd: Call cdrom_check_status
> [    6.625741] ide-cd: Call ide_cd_queue_pc, rq->cmd[0]: 0x0, write: 0x0, timeout: 0, cmd_flags: 0x1000
> [    6.625842] ide-cd: Call ide_cd_do_request, rq->cmd_type: 0xb, block: 18446744073709551615
> [    6.625921] ide-cd: Call cdrom_do_block_pc, rq->cmd_type: 0xb
> [    6.625982] ide-cd: Call cdrom_start_packet_command, xferlen: 0
> [    6.626053] ide-cd: Call cdrom_transfer_packet_command
> [    6.626241] ide-cd: Call cdrom_newpc_intr, rq->cmd[0]: 0x0, write: 0x0
> [    6.626316] ide-cd: cdrom_decode_status: stat: 0x51, good_stat: 0x0, rq->cmd_type: 0xb, err: 0x20
> [    6.626396] ide-cd: Call cdrom_queue_request_sense
> [    6.626453] ide-cd: failed_cmd: 0x0
> [    6.626515] ide-cd: Call ide_cd_do_request, rq->cmd_type: 0x3, block: 18446744073709551615
> [    6.626593] ide-cd: Call cdrom_do_block_pc, rq->cmd_type: 0x3
> [    6.626655] ide-cd: Call cdrom_start_packet_command, xferlen: 18
> [    6.626727] ide-cd: Call cdrom_transfer_packet_command
> [    6.626918] ide-cd: Call cdrom_newpc_intr, rq->cmd[0]: 0x3, write: 0x0
> [    6.626996] ide-cd: cdrom_newpc_intr: DRQ: stat: 0x58, thislen: 18
> [    6.627060] ide-cd: Call ide_cd_check_ireason, ireason: 0x2, rw: 0x0
> [    6.627125] ide-cd: cdrom_newpc_intr: data transfer, rq->cmd_type: 0x3, ireason: 0x2
> [    6.627251] ide-cd: Call cdrom_newpc_intr, rq->cmd[0]: 0x3, write: 0x0
> [    6.627324] ide-cd: cdrom_newpc_intr: DRQ: stat: 0x50, thislen: 0
> [    6.627386] ide-cd: Call ide_cd_request_sense_fixup
> [    6.627444] ide-cd: Call cdrom_end_request, cmd: 0x3, uptodate: 0x1, nsectors: 0
> [    6.627520] ide-cd: Call cdrom_analyze_sense_data, error_code: 0x70, sense_key: 0x2
> [    6.627595] ide-cd: cdrom_analyze_sense_data: failed cmd: 0x0
> [    6.627657] ATAPI device hdd:
> [    6.627705]   Error: Not ready -- (Sense key=0x02)
> [    6.627798]   Medium not present -- (asc=0x3a, ascq=0x00)
> [    6.627857]   The failed "Test Unit Ready" packet command was: 
> [    6.627861]   "00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 "
> [    6.628603] ide-cd: Exit cdrom_end_request, uptodate: 0x1, nsectors: 1
> [    6.631600] ide-cd: Call cdrom_read_capacity
> [    6.631681] ide-cd: Call ide_cd_queue_pc, rq->cmd[0]: 0x25, write: 0x0, timeout: 0, cmd_flags: 0x1000
> [    6.631807] ide-cd: Call ide_cd_do_request, rq->cmd_type: 0xb, block: 18446744073709551615
> [    6.631887] ide-cd: Call cdrom_do_block_pc, rq->cmd_type: 0xb
> [    6.631950] ide-cd: Call cdrom_start_packet_command, xferlen: 8
> [    6.632125] ide-cd: Call cdrom_transfer_packet_command
> [    6.632319] ide-cd: Call cdrom_newpc_intr, rq->cmd[0]: 0x25, write: 0x0
> [    6.632393] ide-cd: cdrom_decode_status: stat: 0x51, good_stat: 0x0, rq->cmd_type: 0xb, err: 0x20
> [    6.632474] ide-cd: Call cdrom_queue_request_sense
> [    6.632530] ide-cd: failed_cmd: 0x25
> [    6.632593] ide-cd: Call ide_cd_do_request, rq->cmd_type: 0x3, block: 18446744073709551615
> [    6.632672] ide-cd: Call cdrom_do_block_pc, rq->cmd_type: 0x3
> [    6.632734] ide-cd: Call cdrom_start_packet_command, xferlen: 18
> [    6.632805] ide-cd: Call cdrom_transfer_packet_command
> [    6.632994] ide-cd: Call cdrom_newpc_intr, rq->cmd[0]: 0x3, write: 0x0
> [    6.633069] ide-cd: cdrom_newpc_intr: DRQ: stat: 0x58, thislen: 18
> [    6.633133] ide-cd: Call ide_cd_check_ireason, ireason: 0x2, rw: 0x0
> [    6.633199] ide-cd: cdrom_newpc_intr: data transfer, rq->cmd_type: 0x3, ireason: 0x2
> [    6.633323] ide-cd: Call cdrom_newpc_intr, rq->cmd[0]: 0x3, write: 0x0
> [    6.633396] ide-cd: cdrom_newpc_intr: DRQ: stat: 0x50, thislen: 0
> [    6.633459] ide-cd: Call ide_cd_request_sense_fixup
> [    6.633517] ide-cd: Call cdrom_end_request, cmd: 0x3, uptodate: 0x1, nsectors: 0
> [    6.633592] ide-cd: Call cdrom_analyze_sense_data, error_code: 0x70, sense_key: 0x2
> [    6.633667] ide-cd: cdrom_analyze_sense_data: failed cmd: 0x25
> [    6.633730] ATAPI device hdd:
> [    6.633780]   Error: Not ready -- (Sense key=0x02)
> [    6.633873]   Medium not present -- (asc=0x3a, ascq=0x00)
> [    6.633933]   The failed "Read Cd/Dvd Capacity" packet command was: 
> [    6.633937]   "25 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 "
> [    6.634634] ide-cd: Exit cdrom_end_request, uptodate: 0x1, nsectors: 1
> [    6.636178] ide-cd: Call cdrom_read_tocentry
> [    6.636250] ide-cd: Call ide_cd_queue_pc, rq->cmd[0]: 0x43, write: 0x0, timeout: 0, cmd_flags: 0x1000
> [    6.636372] ide-cd: Call ide_cd_do_request, rq->cmd_type: 0xb, block: 18446744073709551615
> [    6.636451] ide-cd: Call cdrom_do_block_pc, rq->cmd_type: 0xb
> [    6.636513] ide-cd: Call cdrom_start_packet_command, xferlen: 4
> [    6.636587] ide-cd: Call cdrom_transfer_packet_command
> [    6.636777] ide-cd: Call cdrom_newpc_intr, rq->cmd[0]: 0x43, write: 0x0
> [    6.636852] ide-cd: cdrom_decode_status: stat: 0x51, good_stat: 0x0, rq->cmd_type: 0xb, err: 0x20
> [    6.636932] ide-cd: Call cdrom_queue_request_sense
> [    6.636989] ide-cd: failed_cmd: 0x43
> [    6.637052] ide-cd: Call ide_cd_do_request, rq->cmd_type: 0x3, block: 18446744073709551615
> [    6.637131] ide-cd: Call cdrom_do_block_pc, rq->cmd_type: 0x3
> [    6.637195] ide-cd: Call cdrom_start_packet_command, xferlen: 18
> [    6.637269] ide-cd: Call cdrom_transfer_packet_command
> [    6.637459] ide-cd: Call cdrom_newpc_intr, rq->cmd[0]: 0x3, write: 0x0
> [    6.637534] ide-cd: cdrom_newpc_intr: DRQ: stat: 0x58, thislen: 18
> [    6.637598] ide-cd: Call ide_cd_check_ireason, ireason: 0x2, rw: 0x0
> [    6.637663] ide-cd: cdrom_newpc_intr: data transfer, rq->cmd_type: 0x3, ireason: 0x2
> [    6.637787] ide-cd: Call cdrom_newpc_intr, rq->cmd[0]: 0x3, write: 0x0
> [    6.637859] ide-cd: cdrom_newpc_intr: DRQ: stat: 0x50, thislen: 0
> [    6.637922] ide-cd: Call ide_cd_request_sense_fixup
> [    6.637981] ide-cd: Call cdrom_end_request, cmd: 0x3, uptodate: 0x1, nsectors: 0
> [    6.638057] ide-cd: Call cdrom_analyze_sense_data, error_code: 0x70, sense_key: 0x2
> [    6.638132] ide-cd: cdrom_analyze_sense_data: failed cmd: 0x43
> [    6.639216] ATAPI device hdd:
> [    6.639266]   Error: Not ready -- (Sense key=0x02)
> [    6.639358]   Medium not present -- (asc=0x3a, ascq=0x00)
> [    6.639420]   The failed "Read Table of Contents" packet command was: 
> [    6.639424]   "43 02 00 00 00 00 00 00 04 00 00 00 00 00 00 00 "
> [    6.640170] ide-cd: Exit cdrom_end_request, uptodate: 0x1, nsectors: 1
> [    6.640439] ide-cd: Call ide_cd_do_request, rq->cmd_type: 0x2, block: 18446744073709551615
> [    6.640521] Sending BLOCK_PC to drive! Fixed.
> [    6.640578] Original rq: : dev hdd: type=2, flags=504c8
> [    6.640637]   sector 18446744073709551615, nr/cnr 0/0
> [    6.640697]   bio cf87b540, biotail cf87b540, buffer 00000000, data 00000000, len 36
> [    6.640772]   cdb: 12 00 00 00 24 00 00 00 00 00 00 00 00 00 00 00 
> [    6.641390] rq->cmd_len: 6
> [    6.641443] Pid: 812, comm: cdrom_id Not tainted 2.6.27-rc7 #1
> [    6.641519]  [<d0900d0b>] ide_cd_do_request+0x4d9/0x6c6 [ide_cd_mod]
> [    6.641642]  [<c01e9b50>] __const_udelay+0x29/0x2a
> [    6.641741]  [<d090bb68>] __ide_wait_stat+0xab/0xd6 [ide_core]
> [    6.641900]  [<d090c68b>] ide_wait_stat+0x3f/0x6c [ide_core]
> [    6.642027]  [<d090adc3>] ide_do_request+0x671/0x876 [ide_core]
> [    6.642154]  [<c02bdc3c>] _spin_lock_irqsave+0x23/0x29
> [    6.642250]  [<c012b978>] lock_timer_base+0x19/0x35
> [    6.642351]  [<c012b978>] lock_timer_base+0x19/0x35
> [    6.642444]  [<c012ba3c>] del_timer+0x4a/0x50
> [    6.642535]  [<c01d855f>] elv_insert+0xc2/0x1d6
> [    6.642630]  [<c01dc491>] blk_execute_rq_nowait+0x5a/0x87
> [    6.642731]  [<c01dc539>] blk_execute_rq+0x7b/0x96
> [    6.642824]  [<c01dc414>] blk_end_sync_rq+0x0/0x23
> [    6.642917]  [<c0199e84>] bio_add_pc_page+0x16/0x1b
> [    6.643013]  [<c019a422>] bio_copy_user_iov+0x10d/0x169
> [    6.643108]  [<c01d8c05>] blk_rq_bio_prep+0x73/0xa6
> [    6.643202]  [<c01dc266>] blk_rq_append_bio+0x11/0x3a
> [    6.643298]  [<c01dc37e>] blk_rq_map_user+0xef/0x185
> [    6.643393]  [<c01deb90>] sg_io+0x1eb/0x2c8
> [    6.643485]  [<c01df0bb>] scsi_cmd_ioctl+0x1b8/0x40d
> [    6.643579]  [<c015a744>] find_get_page+0x1f/0x81
> [    6.643676]  [<c015ab06>] find_lock_page+0x10/0x43
> [    6.643768]  [<c015b12a>] filemap_fault+0x1f3/0x344
> [    6.643862]  [<d08f9c5e>] cdrom_ioctl+0x25/0xb31 [cdrom]
> [    6.643971]  [<c0167d5e>] handle_mm_fault+0x2f5/0x6e9
> [    6.644123]  [<d09004aa>] idecd_ioctl+0x12d/0x142 [ide_cd_mod]
> [    6.644226]  [<c0188932>] dput+0x16/0x103
> [    6.644322]  [<c01dd0cb>] blkdev_driver_ioctl+0x4b/0x5b
> [    6.644417]  [<c01dd795>] blkdev_ioctl+0x6ba/0x6d9
> [    6.644510]  [<c019b4ae>] blkdev_open+0x0/0x4d
> [    6.644602]  [<c019b4d3>] blkdev_open+0x25/0x4d
> [    6.644693]  [<c0178ae5>] __dentry_open+0x130/0x1fc
> [    6.644794]  [<c0178c2e>] nameidata_to_filp+0x1c/0x2c
> [    6.644889]  [<c0183405>] do_filp_open+0x34b/0x6a0
> [    6.644989]  [<c011511f>] __ptep_modify_prot_start+0x16/0x2e
> [    6.645099]  [<c019aaf9>] block_ioctl+0x13/0x16
> [    6.645190]  [<c019aae6>] block_ioctl+0x0/0x16
> [    6.645281]  [<c01840ac>] vfs_ioctl+0x1c/0x5f
> [    6.645370]  [<c0184331>] do_vfs_ioctl+0x242/0x255
> [    6.645461]  [<c017894e>] do_sys_open+0xaa/0xb2
> [    6.645555]  [<c0184385>] sys_ioctl+0x41/0x58
> [    6.645644]  [<c010398e>] syscall_call+0x7/0xb
> [    6.645739]  =======================
> [    6.645793] ide-cd: Call cdrom_do_block_pc, rq->cmd_type: 0xb
> [    6.645857] ide-cd: Call cdrom_start_packet_command, xferlen: 36
> [    6.645949] ide-cd: Call cdrom_transfer_packet_command
> [    6.646100] ide-cd: Call cdrom_newpc_intr, rq->cmd[0]: 0x12, write: 0x0
> [    6.646175] ide-cd: cdrom_newpc_intr: DRQ: stat: 0x58, thislen: 36
> [    6.646239] ide-cd: Call ide_cd_check_ireason, ireason: 0x2, rw: 0x0
> [    6.646303] ide-cd: cdrom_newpc_intr: data transfer, rq->cmd_type: 0xb, ireason: 0x2
> [    6.646434] ide-cd: Call cdrom_newpc_intr, rq->cmd[0]: 0x12, write: 0x0
> [    6.646506] ide-cd: cdrom_newpc_intr: DRQ: stat: 0x50, thislen: 0
> [    6.646569] ide-cd: Call ide_cd_request_sense_fixup
> [    6.646627] ide-cd: Call cdrom_end_request, cmd: 0x12, uptodate: 0x1, nsectors: 0
> [    6.646702] ide-cd: Exit cdrom_end_request, uptodate: 0x1, nsectors: 1
> [    6.648296] ide-cd: Call ide_cd_do_request, rq->cmd_type: 0x2, block: 18446744073709551615
> [    6.648389] Sending BLOCK_PC to drive! Fixed.
> [    6.648446] Original rq: : dev hdd: type=2, flags=504c8
> [    6.648506]   sector 18446744073709551615, nr/cnr 0/0
> [    6.648567]   bio cf87b540, biotail cf87b540, buffer 00000000, data 00000000, len 8
> [    6.648642]   cdb: 46 00 00 00 00 00 00 00 08 00 00 00 00 00 00 00 
> [    6.649252] rq->cmd_len: 10
> [    6.649306] Pid: 812, comm: cdrom_id Not tainted 2.6.27-rc7 #1
> [    6.649381]  [<d0900d0b>] ide_cd_do_request+0x4d9/0x6c6 [ide_cd_mod]
> [    6.649501]  [<c01e9b50>] __const_udelay+0x29/0x2a
> [    6.649598]  [<d090bb68>] __ide_wait_stat+0xab/0xd6 [ide_core]
> [    6.649755]  [<d090c68b>] ide_wait_stat+0x3f/0x6c [ide_core]
> [    6.649880]  [<d090adc3>] ide_do_request+0x671/0x876 [ide_core]
> [    6.650006]  [<c02bdc3c>] _spin_lock_irqsave+0x23/0x29
> [    6.650102]  [<c012b978>] lock_timer_base+0x19/0x35
> [    6.650200]  [<c012b978>] lock_timer_base+0x19/0x35
> [    6.650295]  [<c012ba3c>] del_timer+0x4a/0x50
> [    6.650388]  [<c01d855f>] elv_insert+0xc2/0x1d6
> [    6.650483]  [<c01dc491>] blk_execute_rq_nowait+0x5a/0x87
> [    6.650583]  [<c01dc539>] blk_execute_rq+0x7b/0x96
> [    6.650675]  [<c01dc414>] blk_end_sync_rq+0x0/0x23
> [    6.650767]  [<c0199e84>] bio_add_pc_page+0x16/0x1b
> [    6.650863]  [<c019a422>] bio_copy_user_iov+0x10d/0x169
> [    6.650957]  [<c01d8c05>] blk_rq_bio_prep+0x73/0xa6
> [    6.651049]  [<c01dc266>] blk_rq_append_bio+0x11/0x3a
> [    6.651142]  [<c01dc37e>] blk_rq_map_user+0xef/0x185
> [    6.651236]  [<c01deb90>] sg_io+0x1eb/0x2c8
> [    6.651329]  [<c01df0bb>] scsi_cmd_ioctl+0x1b8/0x40d
> [    6.651423]  [<c015a744>] find_get_page+0x1f/0x81
> [    6.651519]  [<c015ab06>] find_lock_page+0x10/0x43
> [    6.651612]  [<c015b12a>] filemap_fault+0x1f3/0x344
> [    6.651705]  [<d08f9c5e>] cdrom_ioctl+0x25/0xb31 [cdrom]
> [    6.651814]  [<c0167d5e>] handle_mm_fault+0x2f5/0x6e9
> [    6.651913]  [<d09004aa>] idecd_ioctl+0x12d/0x142 [ide_cd_mod]
> [    6.652067]  [<c0188932>] dput+0x16/0x103
> [    6.652161]  [<c01dd0cb>] blkdev_driver_ioctl+0x4b/0x5b
> [    6.652256]  [<c01dd795>] blkdev_ioctl+0x6ba/0x6d9
> [    6.652351]  [<c019b4ae>] blkdev_open+0x0/0x4d
> [    6.652442]  [<c019b4d3>] blkdev_open+0x25/0x4d
> [    6.652534]  [<c0178ae5>] __dentry_open+0x130/0x1fc
> [    6.652637]  [<c0178c2e>] nameidata_to_filp+0x1c/0x2c
> [    6.652731]  [<c0183405>] do_filp_open+0x34b/0x6a0
> [    6.652832]  [<c011511f>] __ptep_modify_prot_start+0x16/0x2e
> [    6.652939]  [<c019aaf9>] block_ioctl+0x13/0x16
> [    6.653029]  [<c019aae6>] block_ioctl+0x0/0x16
> [    6.653122]  [<c01840ac>] vfs_ioctl+0x1c/0x5f
> [    6.653211]  [<c0184331>] do_vfs_ioctl+0x242/0x255
> [    6.653304]  [<c017894e>] do_sys_open+0xaa/0xb2
> [    6.653395]  [<c0184385>] sys_ioctl+0x41/0x58
> [    6.653486]  [<c010398e>] syscall_call+0x7/0xb
> [    6.653580]  =======================
> [    6.653632] ide-cd: Call cdrom_do_block_pc, rq->cmd_type: 0xb
> [    6.653696] ide-cd: Call cdrom_start_packet_command, xferlen: 8
> [    6.653769] ide-cd: Call cdrom_transfer_packet_command
> [    6.653980] ide-cd: Call cdrom_newpc_intr, rq->cmd[0]: 0x46, write: 0x0
> [    6.654055] ide-cd: cdrom_decode_status: stat: 0x51, good_stat: 0x0, rq->cmd_type: 0xb, err: 0x20
> [    6.654137] ide-cd: Call cdrom_queue_request_sense
> [    6.654194] ide-cd: failed_cmd: 0x46
> [    6.654260] ide-cd: Call ide_cd_do_request, rq->cmd_type: 0x3, block: 18446744073709551615
> [    6.654338] ide-cd: Call cdrom_do_block_pc, rq->cmd_type: 0x3
> [    6.654400] ide-cd: Call cdrom_start_packet_command, xferlen: 18
> [    6.654472] ide-cd: Call cdrom_transfer_packet_command
> [    6.654662] ide-cd: Call cdrom_newpc_intr, rq->cmd[0]: 0x3, write: 0x0
> [    6.654738] ide-cd: cdrom_newpc_intr: DRQ: stat: 0x58, thislen: 18
> [    6.654802] ide-cd: Call ide_cd_check_ireason, ireason: 0x2, rw: 0x0
> [    6.654868] ide-cd: cdrom_newpc_intr: data transfer, rq->cmd_type: 0x3, ireason: 0x2
> [    6.654993] ide-cd: Call cdrom_newpc_intr, rq->cmd[0]: 0x3, write: 0x0
> [    6.655067] ide-cd: cdrom_newpc_intr: DRQ: stat: 0x50, thislen: 0
> [    6.655129] ide-cd: Call ide_cd_request_sense_fixup
> [    6.655189] ide-cd: Call cdrom_end_request, cmd: 0x3, uptodate: 0x1, nsectors: 0
> [    6.655267] ide-cd: Call cdrom_analyze_sense_data, error_code: 0x70, sense_key: 0x2
> [    6.655343] ide-cd: cdrom_analyze_sense_data: failed cmd: 0x46
> [    6.655405] ATAPI device hdd:
> [    6.655453]   Error: Not ready -- (Sense key=0x02)
> [    6.655545]   Medium not present -- (asc=0x3a, ascq=0x00)
> [    6.655606]   The failed "Get Configuration" packet command was: 
> [    6.655610]   "46 00 00 00 00 00 00 00 08 00 00 00 00 00 00 00 "
> [    6.656351] ide-cd: Exit cdrom_end_request, uptodate: 0x1, nsectors: 1
> [    6.663012] ide-cd: Call ide_cd_queue_pc, rq->cmd[0]: 0x1e, write: 0x0, timeout: 0, cmd_flags: 0x0
> [    6.663149] ide-cd: Call ide_cd_do_request, rq->cmd_type: 0xb, block: 18446744073709551615
> [    6.663229] ide-cd: Call cdrom_do_block_pc, rq->cmd_type: 0xb
> [    6.663292] ide-cd: Call cdrom_start_packet_command, xferlen: 0
> [    6.663365] ide-cd: Call cdrom_transfer_packet_command
> [    6.663532] ide-cd: Call cdrom_newpc_intr, rq->cmd[0]: 0x1e, write: 0x0
> [    6.663610] ide-cd: cdrom_newpc_intr: DRQ: stat: 0x50, thislen: 0
> [    6.663676] ide-cd: Call ide_cd_request_sense_fixup
> [    6.663735] ide-cd: Call cdrom_end_request, cmd: 0x1e, uptodate: 0x1, nsectors: 0
> [    6.663811] ide-cd: Exit cdrom_end_request, uptodate: 0x1, nsectors: 1
> [    6.667286] ide-cd: Call cdrom_check_status
> [    6.667366] ide-cd: Call ide_cd_queue_pc, rq->cmd[0]: 0x0, write: 0x0, timeout: 0, cmd_flags: 0x1000
> [    6.667503] ide-cd: Call ide_cd_do_request, rq->cmd_type: 0xb, block: 18446744073709551615
> [    6.668592] ide-cd: Call cdrom_do_block_pc, rq->cmd_type: 0xb
> [    6.668656] ide-cd: Call cdrom_start_packet_command, xferlen: 0
> [    6.668729] ide-cd: Call cdrom_transfer_packet_command
> [    6.668941] ide-cd: Call cdrom_newpc_intr, rq->cmd[0]: 0x0, write: 0x0
> [    6.669014] ide-cd: cdrom_decode_status: stat: 0x51, good_stat: 0x0, rq->cmd_type: 0xb, err: 0x20
> [    6.669094] ide-cd: Call cdrom_queue_request_sense
> [    6.669151] ide-cd: failed_cmd: 0x0
> [    6.669214] ide-cd: Call ide_cd_do_request, rq->cmd_type: 0x3, block: 18446744073709551615
> [    6.669291] ide-cd: Call cdrom_do_block_pc, rq->cmd_type: 0x3
> [    6.669353] ide-cd: Call cdrom_start_packet_command, xferlen: 18
> [    6.669423] ide-cd: Call cdrom_transfer_packet_command
> [    6.669683] ide-cd: Call cdrom_newpc_intr, rq->cmd[0]: 0x3, write: 0x0
> [    6.669757] ide-cd: cdrom_newpc_intr: DRQ: stat: 0x58, thislen: 18
> [    6.669822] ide-cd: Call ide_cd_check_ireason, ireason: 0x2, rw: 0x0
> [    6.669887] ide-cd: cdrom_newpc_intr: data transfer, rq->cmd_type: 0x3, ireason: 0x2
> [    6.670016] ide-cd: Call cdrom_newpc_intr, rq->cmd[0]: 0x3, write: 0x0
> [    6.670088] ide-cd: cdrom_newpc_intr: DRQ: stat: 0x50, thislen: 0
> [    6.670151] ide-cd: Call ide_cd_request_sense_fixup
> [    6.670210] ide-cd: Call cdrom_end_request, cmd: 0x3, uptodate: 0x1, nsectors: 0
> [    6.670286] ide-cd: Call cdrom_analyze_sense_data, error_code: 0x70, sense_key: 0x2
> [    6.670362] ide-cd: cdrom_analyze_sense_data: failed cmd: 0x0
> [    6.670425] ATAPI device hdd:
> [    6.670473]   Error: Not ready -- (Sense key=0x02)
> [    6.670565]   Medium not present -- (asc=0x3a, ascq=0x00)
> [    6.670625]   The failed "Test Unit Ready" packet command was: 
> [    6.670629]   "00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 "
> [    6.671319] ide-cd: Exit cdrom_end_request, uptodate: 0x1, nsectors: 1
> [    6.671420] ide-cd: Call ide_cd_read_toc
> [    6.671473] ide-cd: Call cdrom_check_status
> [    6.671531] ide-cd: Call ide_cd_queue_pc, rq->cmd[0]: 0x0, write: 0x0, timeout: 0, cmd_flags: 0x1000
> [    6.671629] ide-cd: Call ide_cd_do_request, rq->cmd_type: 0xb, block: 18446744073709551615
> [    6.671707] ide-cd: Call cdrom_do_block_pc, rq->cmd_type: 0xb
> [    6.671768] ide-cd: Call cdrom_start_packet_command, xferlen: 0
> [    6.671839] ide-cd: Call cdrom_transfer_packet_command
> [    6.672050] ide-cd: Call cdrom_newpc_intr, rq->cmd[0]: 0x0, write: 0x0
> [    6.672121] ide-cd: cdrom_decode_status: stat: 0x51, good_stat: 0x0, rq->cmd_type: 0xb, err: 0x20
> [    6.672201] ide-cd: Call cdrom_queue_request_sense
> [    6.672262] ide-cd: failed_cmd: 0x0
> [    6.672322] ide-cd: Call ide_cd_do_request, rq->cmd_type: 0x3, block: 18446744073709551615
> [    6.672400] ide-cd: Call cdrom_do_block_pc, rq->cmd_type: 0x3
> [    6.672463] ide-cd: Call cdrom_start_packet_command, xferlen: 18
> [    6.672534] ide-cd: Call cdrom_transfer_packet_command
> [    6.672729] ide-cd: Call cdrom_newpc_intr, rq->cmd[0]: 0x3, write: 0x0
> [    6.672801] ide-cd: cdrom_newpc_intr: DRQ: stat: 0x58, thislen: 18
> [    6.672865] ide-cd: Call ide_cd_check_ireason, ireason: 0x2, rw: 0x0
> [    6.672929] ide-cd: cdrom_newpc_intr: data transfer, rq->cmd_type: 0x3, ireason: 0x2
> [    6.673058] ide-cd: Call cdrom_newpc_intr, rq->cmd[0]: 0x3, write: 0x0
> [    6.673130] ide-cd: cdrom_newpc_intr: DRQ: stat: 0x50, thislen: 0
> [    6.673192] ide-cd: Call ide_cd_request_sense_fixup
> [    6.673249] ide-cd: Call cdrom_end_request, cmd: 0x3, uptodate: 0x1, nsectors: 0
> [    6.673326] ide-cd: Call cdrom_analyze_sense_data, error_code: 0x70, sense_key: 0x2
> [    6.673402] ide-cd: cdrom_analyze_sense_data: failed cmd: 0x0
> [    6.673463] ATAPI device hdd:
> [    6.673511]   Error: Not ready -- (Sense key=0x02)
> [    6.673601]   Medium not present -- (asc=0x3a, ascq=0x00)
> [    6.673661]   The failed "Test Unit Ready" packet command was: 
> [    6.673664]   "00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 "
> [    6.674340] ide-cd: Exit cdrom_end_request, uptodate: 0x1, nsectors: 1
> [    6.674427] ide-cd: Call cdrom_read_capacity
> [    6.674483] ide-cd: Call ide_cd_queue_pc, rq->cmd[0]: 0x25, write: 0x0, timeout: 0, cmd_flags: 0x1000
> [    6.674578] ide-cd: Call ide_cd_do_request, rq->cmd_type: 0xb, block: 18446744073709551615
> [    6.674656] ide-cd: Call cdrom_do_block_pc, rq->cmd_type: 0xb
> [    6.674718] ide-cd: Call cdrom_start_packet_command, xferlen: 8
> [    6.674789] ide-cd: Call cdrom_transfer_packet_command
> [    6.674981] ide-cd: Call cdrom_newpc_intr, rq->cmd[0]: 0x25, write: 0x0
> [    6.675052] ide-cd: cdrom_decode_status: stat: 0x51, good_stat: 0x0, rq->cmd_type: 0xb, err: 0x20
> [    6.675131] ide-cd: Call cdrom_queue_request_sense
> [    6.675188] ide-cd: failed_cmd: 0x25
> [    6.675248] ide-cd: Call ide_cd_do_request, rq->cmd_type: 0x3, block: 18446744073709551615
> [    6.675327] ide-cd: Call cdrom_do_block_pc, rq->cmd_type: 0x3
> [    6.675391] ide-cd: Call cdrom_start_packet_command, xferlen: 18
> [    6.675462] ide-cd: Call cdrom_transfer_packet_command
> [    6.675656] ide-cd: Call cdrom_newpc_intr, rq->cmd[0]: 0x3, write: 0x0
> [    6.675728] ide-cd: cdrom_newpc_intr: DRQ: stat: 0x58, thislen: 18
> [    6.675792] ide-cd: Call ide_cd_check_ireason, ireason: 0x2, rw: 0x0
> [    6.675856] ide-cd: cdrom_newpc_intr: data transfer, rq->cmd_type: 0x3, ireason: 0x2
> [    6.675984] ide-cd: Call cdrom_newpc_intr, rq->cmd[0]: 0x3, write: 0x0
> [    6.676056] ide-cd: cdrom_newpc_intr: DRQ: stat: 0x50, thislen: 0
> [    6.676119] ide-cd: Call ide_cd_request_sense_fixup
> [    6.676203] ide-cd: Call cdrom_end_request, cmd: 0x3, uptodate: 0x1, nsectors: 0
> [    6.676279] ide-cd: Call cdrom_analyze_sense_data, error_code: 0x70, sense_key: 0x2
> [    6.676355] ide-cd: cdrom_analyze_sense_data: failed cmd: 0x25
> [    6.676416] ATAPI device hdd:
> [    6.676464]   Error: Not ready -- (Sense key=0x02)
> [    6.676555]   Medium not present -- (asc=0x3a, ascq=0x00)
> [    6.676617]   The failed "Read Cd/Dvd Capacity" packet command was: 
> [    6.676620]   "25 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 "
> [    6.677307] ide-cd: Exit cdrom_end_request, uptodate: 0x1, nsectors: 1
> [    6.677435] ide-cd: Call cdrom_read_tocentry
> [    6.677493] ide-cd: Call ide_cd_queue_pc, rq->cmd[0]: 0x43, write: 0x0, timeout: 0, cmd_flags: 0x1000
> [    6.677588] ide-cd: Call ide_cd_do_request, rq->cmd_type: 0xb, block: 18446744073709551615
> [    6.677665] ide-cd: Call cdrom_do_block_pc, rq->cmd_type: 0xb
> [    6.677729] ide-cd: Call cdrom_start_packet_command, xferlen: 4
> [    6.677801] ide-cd: Call cdrom_transfer_packet_command
> [    6.678014] ide-cd: Call cdrom_newpc_intr, rq->cmd[0]: 0x43, write: 0x0
> [    6.678084] ide-cd: cdrom_decode_status: stat: 0x51, good_stat: 0x0, rq->cmd_type: 0xb, err: 0x20
> [    6.678163] ide-cd: Call cdrom_queue_request_sense
> [    6.678220] ide-cd: failed_cmd: 0x43
> [    6.678283] ide-cd: Call ide_cd_do_request, rq->cmd_type: 0x3, block: 18446744073709551615
> [    6.678361] ide-cd: Call cdrom_do_block_pc, rq->cmd_type: 0x3
> [    6.678423] ide-cd: Call cdrom_start_packet_command, xferlen: 18
> [    6.678495] ide-cd: Call cdrom_transfer_packet_command
> [    6.678689] ide-cd: Call cdrom_newpc_intr, rq->cmd[0]: 0x3, write: 0x0
> [    6.678761] ide-cd: cdrom_newpc_intr: DRQ: stat: 0x58, thislen: 18
> [    6.678825] ide-cd: Call ide_cd_check_ireason, ireason: 0x2, rw: 0x0
> [    6.678889] ide-cd: cdrom_newpc_intr: data transfer, rq->cmd_type: 0x3, ireason: 0x2
> [    6.679017] ide-cd: Call cdrom_newpc_intr, rq->cmd[0]: 0x3, write: 0x0
> [    6.679088] ide-cd: cdrom_newpc_intr: DRQ: stat: 0x50, thislen: 0
> [    6.679152] ide-cd: Call ide_cd_request_sense_fixup
> [    6.679210] ide-cd: Call cdrom_end_request, cmd: 0x3, uptodate: 0x1, nsectors: 0
> [    6.679288] ide-cd: Call cdrom_analyze_sense_data, error_code: 0x70, sense_key: 0x2
> [    6.679365] ide-cd: cdrom_analyze_sense_data: failed cmd: 0x43
> [    6.679426] ATAPI device hdd:
> [    6.679477]   Error: Not ready -- (Sense key=0x02)
> [    6.679567]   Medium not present -- (asc=0x3a, ascq=0x00)
> [    6.679628]   The failed "Read Table of Contents" packet command was: 
> [    6.679631]   "43 02 00 00 00 00 00 00 04 00 00 00 00 00 00 00 "
> [    6.680315] ide-cd: Exit cdrom_end_request, uptodate: 0x1, nsectors: 1
> [    6.680599] ide-cd: Call ide_cd_queue_pc, rq->cmd[0]: 0x1e, write: 0x0, timeout: 0, cmd_flags: 0x0
> [    6.680708] ide-cd: Call ide_cd_do_request, rq->cmd_type: 0xb, block: 18446744073709551615
> [    6.680788] ide-cd: Call cdrom_do_block_pc, rq->cmd_type: 0xb
> [    6.680850] ide-cd: Call cdrom_start_packet_command, xferlen: 0
> [    6.680921] ide-cd: Call cdrom_transfer_packet_command
> [    6.681087] ide-cd: Call cdrom_newpc_intr, rq->cmd[0]: 0x1e, write: 0x0
> [    6.681161] ide-cd: cdrom_newpc_intr: DRQ: stat: 0x50, thislen: 0
> [    6.681226] ide-cd: Call ide_cd_request_sense_fixup
> [    6.681283] ide-cd: Call cdrom_end_request, cmd: 0x1e, uptodate: 0x1, nsectors: 0
> [    6.681358] ide-cd: Exit cdrom_end_request, uptodate: 0x1, nsectors: 1
> [   11.391902] PM: Starting manual resume from disk
> [   11.508430] kjournald starting.  Commit interval 5 seconds
> [   11.508533] EXT3-fs: mounted filesystem with ordered data mode.
> [   14.423412] udevd version 125 started
> [   14.991933] ide-cd: Call cdrom_check_status
> [   14.992089] ide-cd: Call ide_cd_queue_pc, rq->cmd[0]: 0x0, write: 0x0, timeout: 0, cmd_flags: 0x1000
> [   14.992242] hdc: status error: status=0x58 { DriveReady SeekComplete DataRequest }
> [   14.992453] ide: failed opcode was: unknown
> [   14.992552] hdc: drive not ready for command 0x0
> [   14.992623] ide-cd: Call ide_cd_read_toc
> [   14.992676] ide-cd: Call cdrom_check_status
> [   14.992732] ide-cd: Call ide_cd_queue_pc, rq->cmd[0]: 0x0, write: 0x0, timeout: 0, cmd_flags: 0x1000
> [   14.992841] hdc: status error: status=0x58 { DriveReady SeekComplete DataRequest }
> [   14.993050] ide: failed opcode was: unknown
> [   14.993139] hdc: drive not ready for command 0x0
> [   14.993197] ide-cd: Call cdrom_read_capacity
> [   14.993254] ide-cd: Call ide_cd_queue_pc, rq->cmd[0]: 0x25, write: 0x0, timeout: 0, cmd_flags: 0x1000
> [   14.993364] hdc: status error: status=0x58 { DriveReady SeekComplete DataRequest }
> [   14.993571] ide: failed opcode was: unknown
> [   14.993661] hdc: drive not ready for command 0x25
> [   14.993720] ide-cd: hdc: weird block size 0
> [   14.993774] ide-cd: hdc: default to 2kb block size
> [   14.993831] ide-cd: Call cdrom_read_tocentry
> [   14.993887] ide-cd: Call ide_cd_queue_pc, rq->cmd[0]: 0x43, write: 0x0, timeout: 0, cmd_flags: 0x1000
> [   14.993996] hdc: status error: status=0x58 { DriveReady SeekComplete DataRequest }
> [   14.994200] ide: failed opcode was: unknown
> [   14.994287] hdc: drive not ready for command 0x43
> [   14.994346] ide-cd: Call cdrom_read_tocentry
> [   14.994401] ide-cd: Call ide_cd_queue_pc, rq->cmd[0]: 0x43, write: 0x0, timeout: 0, cmd_flags: 0x1000
> [   14.994510] hdc: status error: status=0x58 { DriveReady SeekComplete DataRequest }
> [   14.994714] ide: failed opcode was: unknown
> [   14.994802] hdc: drive not ready for command 0x43
> [   14.994861] ide-cd: Call cdrom_read_tocentry
> [   14.994916] ide-cd: Call ide_cd_queue_pc, rq->cmd[0]: 0x43, write: 0x0, timeout: 0, cmd_flags: 0x1000
> [   14.995049] hdc: status error: status=0x58 { DriveReady SeekComplete DataRequest }
> [   14.995255] ide: failed opcode was: unknown
> [   14.995344] hdc: drive not ready for command 0x43
> [   14.995407] ide-cd: Call ide_cd_queue_pc, rq->cmd[0]: 0x51, write: 0x0, timeout: 1750, cmd_flags: 0x1000
> [   14.995515] hdc: status error: status=0x58 { DriveReady SeekComplete DataRequest }
> [   14.995722] ide: failed opcode was: unknown
> [   14.995814] hdc: drive not ready for command 0x51
> [   14.995873] ide-cd: Call ide_cd_queue_pc, rq->cmd[0]: 0x51, write: 0x0, timeout: 1750, cmd_flags: 0x1000
> [   14.995982] hdc: status error: status=0x58 { DriveReady SeekComplete DataRequest }
> [   14.996057] ide: failed opcode was: unknown
> [   14.996350] hdc: drive not ready for command 0x51
> [   14.997915] ide-cd: Call cdrom_check_status
> [   14.997994] ide-cd: Call ide_cd_queue_pc, rq->cmd[0]: 0x0, write: 0x0, timeout: 0, cmd_flags: 0x1000
> [   14.998125] ide-cd: Call ide_cd_do_request, rq->cmd_type: 0xb, block: 18446744073709551615
> [   14.998206] ide-cd: Call cdrom_do_block_pc, rq->cmd_type: 0xb
> [   14.998268] ide-cd: Call cdrom_start_packet_command, xferlen: 0
> [   14.998341] ide-cd: Call cdrom_transfer_packet_command
> [   14.998543] ide-cd: Call cdrom_newpc_intr, rq->cmd[0]: 0x0, write: 0x0
> [   14.998616] ide-cd: cdrom_decode_status: stat: 0x51, good_stat: 0x0, rq->cmd_type: 0xb, err: 0x20
> [   14.998696] ide-cd: Call cdrom_queue_request_sense
> [   14.998754] ide-cd: failed_cmd: 0x0
> [   14.998818] ide-cd: Call ide_cd_do_request, rq->cmd_type: 0x3, block: 18446744073709551615
> [   14.998897] ide-cd: Call cdrom_do_block_pc, rq->cmd_type: 0x3
> [   14.998958] ide-cd: Call cdrom_start_packet_command, xferlen: 18
> [   14.999030] ide-cd: Call cdrom_transfer_packet_command
> [   14.999219] ide-cd: Call cdrom_newpc_intr, rq->cmd[0]: 0x3, write: 0x0
> [   14.999293] ide-cd: cdrom_newpc_intr: DRQ: stat: 0x58, thislen: 18
> [   14.999358] ide-cd: Call ide_cd_check_ireason, ireason: 0x2, rw: 0x0
> [   14.999423] ide-cd: cdrom_newpc_intr: data transfer, rq->cmd_type: 0x3, ireason: 0x2
> [   14.999547] ide-cd: Call cdrom_newpc_intr, rq->cmd[0]: 0x3, write: 0x0
> [   14.999618] ide-cd: cdrom_newpc_intr: DRQ: stat: 0x50, thislen: 0
> [   14.999681] ide-cd: Call ide_cd_request_sense_fixup
> [   14.999740] ide-cd: Call cdrom_end_request, cmd: 0x3, uptodate: 0x1, nsectors: 0
> [   14.999816] ide-cd: Call cdrom_analyze_sense_data, error_code: 0x70, sense_key: 0x2
> [   14.999891] ide-cd: cdrom_analyze_sense_data: failed cmd: 0x0
> [   14.999952] ATAPI device hdd:
> [   15.000001]   Error: Not ready -- (Sense key=0x02)
> [   15.000143]   Medium not present -- (asc=0x3a, ascq=0x00)
> [   15.000205]   The failed "Test Unit Ready" packet command was: 
> [   15.000209]   "00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 "
> [   15.000919] ide-cd: Exit cdrom_end_request, uptodate: 0x1, nsectors: 1
> [   15.003426] ide-cd: Call ide_cd_read_toc
> [   15.003498] ide-cd: Call cdrom_check_status
> [   15.003555] ide-cd: Call ide_cd_queue_pc, rq->cmd[0]: 0x0, write: 0x0, timeout: 0, cmd_flags: 0x1000
> [   15.003653] ide-cd: Call ide_cd_do_request, rq->cmd_type: 0xb, block: 18446744073709551615
> [   15.003732] ide-cd: Call cdrom_do_block_pc, rq->cmd_type: 0xb
> [   15.003794] ide-cd: Call cdrom_start_packet_command, xferlen: 0
> [   15.003867] ide-cd: Call cdrom_transfer_packet_command
> [   15.004074] ide-cd: Call cdrom_newpc_intr, rq->cmd[0]: 0x0, write: 0x0
> [   15.004148] ide-cd: cdrom_decode_status: stat: 0x51, good_stat: 0x0, rq->cmd_type: 0xb, err: 0x20
> [   15.004229] ide-cd: Call cdrom_queue_request_sense
> [   15.004286] ide-cd: failed_cmd: 0x0
> [   15.004348] ide-cd: Call ide_cd_do_request, rq->cmd_type: 0x3, block: 18446744073709551615
> [   15.004427] ide-cd: Call cdrom_do_block_pc, rq->cmd_type: 0x3
> [   15.004489] ide-cd: Call cdrom_start_packet_command, xferlen: 18
> [   15.004560] ide-cd: Call cdrom_transfer_packet_command
> [   15.004757] ide-cd: Call cdrom_newpc_intr, rq->cmd[0]: 0x3, write: 0x0
> [   15.004833] ide-cd: cdrom_newpc_intr: DRQ: stat: 0x58, thislen: 18
> [   15.004897] ide-cd: Call ide_cd_check_ireason, ireason: 0x2, rw: 0x0
> [   15.004962] ide-cd: cdrom_newpc_intr: data transfer, rq->cmd_type: 0x3, ireason: 0x2
> [   15.005088] ide-cd: Call cdrom_newpc_intr, rq->cmd[0]: 0x3, write: 0x0
> [   15.005161] ide-cd: cdrom_newpc_intr: DRQ: stat: 0x50, thislen: 0
> [   15.005224] ide-cd: Call ide_cd_request_sense_fixup
> [   15.005282] ide-cd: Call cdrom_end_request, cmd: 0x3, uptodate: 0x1, nsectors: 0
> [   15.005358] ide-cd: Call cdrom_analyze_sense_data, error_code: 0x70, sense_key: 0x2
> [   15.005433] ide-cd: cdrom_analyze_sense_data: failed cmd: 0x0
> [   15.005495] ATAPI device hdd:
> [   15.005544]   Error: Not ready -- (Sense key=0x02)
> [   15.005636]   Medium not present -- (asc=0x3a, ascq=0x00)
> [   15.005698]   The failed "Test Unit Ready" packet command was: 
> [   15.005701]   "00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 "
> [   15.006387] ide-cd: Exit cdrom_end_request, uptodate: 0x1, nsectors: 1
> [   15.006491] hdc: status error: status=0x58 { DriveReady SeekComplete DataRequest }
> [   15.006701] ide: failed opcode was: unknown
> [   15.006794] hdc: drive not ready for command 0x12
> [   15.007126] ide-cd: Call cdrom_read_capacity
> [   15.007190] ide-cd: Call ide_cd_queue_pc, rq->cmd[0]: 0x25, write: 0x0, timeout: 0, cmd_flags: 0x1000
> [   15.007298] ide-cd: Call ide_cd_do_request, rq->cmd_type: 0xb, block: 18446744073709551615
> [   15.007378] ide-cd: Call cdrom_do_block_pc, rq->cmd_type: 0xb
> [   15.007440] ide-cd: Call cdrom_start_packet_command, xferlen: 8
> [   15.007512] ide-cd: Call cdrom_transfer_packet_command
> [   15.007707] ide-cd: Call cdrom_newpc_intr, rq->cmd[0]: 0x25, write: 0x0
> [   15.007781] ide-cd: cdrom_decode_status: stat: 0x51, good_stat: 0x0, rq->cmd_type: 0xb, err: 0x20
> [   15.007864] ide-cd: Call cdrom_queue_request_sense
> [   15.007922] ide-cd: failed_cmd: 0x25
> [   15.007984] ide-cd: Call ide_cd_do_request, rq->cmd_type: 0x3, block: 18446744073709551615
> [   15.008108] ide-cd: Call cdrom_do_block_pc, rq->cmd_type: 0x3
> [   15.008171] ide-cd: Call cdrom_start_packet_command, xferlen: 18
> [   15.008242] ide-cd: Call cdrom_transfer_packet_command
> [   15.008434] ide-cd: Call cdrom_newpc_intr, rq->cmd[0]: 0x3, write: 0x0
> [   15.008509] ide-cd: cdrom_newpc_intr: DRQ: stat: 0x58, thislen: 18
> [   15.008573] ide-cd: Call ide_cd_check_ireason, ireason: 0x2, rw: 0x0
> [   15.008639] ide-cd: cdrom_newpc_intr: data transfer, rq->cmd_type: 0x3, ireason: 0x2
> [   15.008765] ide-cd: Call cdrom_newpc_intr, rq->cmd[0]: 0x3, write: 0x0
> [   15.008838] ide-cd: cdrom_newpc_intr: DRQ: stat: 0x50, thislen: 0
> [   15.008901] ide-cd: Call ide_cd_request_sense_fixup
> [   15.008962] ide-cd: Call cdrom_end_request, cmd: 0x3, uptodate: 0x1, nsectors: 0
> [   15.009041] ide-cd: Call cdrom_analyze_sense_data, error_code: 0x70, sense_key: 0x2
> [   15.010196] ide-cd: cdrom_analyze_sense_data: failed cmd: 0x25
> [   15.010262] ATAPI device hdd:
> [   15.010311]   Error: Not ready -- (Sense key=0x02)
> [   15.010404]   Medium not present -- (asc=0x3a, ascq=0x00)
> [   15.010465]   The failed "Read Cd/Dvd Capacity" packet command was: 
> [   15.010468]   "25 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 "
> [   15.011159] ide-cd: Exit cdrom_end_request, uptodate: 0x1, nsectors: 1
> [   15.013829] ide-cd: Call cdrom_check_status
> [   15.013906] ide-cd: Call ide_cd_queue_pc, rq->cmd[0]: 0x0, write: 0x0, timeout: 0, cmd_flags: 0x1000
> [   15.014058] hdc: status error: status=0x58 { DriveReady SeekComplete DataRequest }
> [   15.014267] ide: failed opcode was: unknown
> [   15.014364] hdc: drive not ready for command 0x0
> [   15.014800] ide-cd: Call cdrom_read_tocentry
> [   15.014869] ide-cd: Call ide_cd_queue_pc, rq->cmd[0]: 0x43, write: 0x0, timeout: 0, cmd_flags: 0x1000
> [   15.014981] ide-cd: Call ide_cd_do_request, rq->cmd_type: 0xb, block: 18446744073709551615
> [   15.015062] ide-cd: Call cdrom_do_block_pc, rq->cmd_type: 0xb
> [   15.015127] ide-cd: Call cdrom_start_packet_command, xferlen: 4
> [   15.015200] ide-cd: Call cdrom_transfer_packet_command
> [   15.015401] ide-cd: Call cdrom_newpc_intr, rq->cmd[0]: 0x43, write: 0x0
> [   15.015475] ide-cd: cdrom_decode_status: stat: 0x51, good_stat: 0x0, rq->cmd_type: 0xb, err: 0x20
> [   15.015556] ide-cd: Call cdrom_queue_request_sense
> [   15.015613] ide-cd: failed_cmd: 0x43
> [   15.015676] ide-cd: Call ide_cd_do_request, rq->cmd_type: 0x3, block: 18446744073709551615
> [   15.015755] ide-cd: Call cdrom_do_block_pc, rq->cmd_type: 0x3
> [   15.015816] ide-cd: Call cdrom_start_packet_command, xferlen: 18
> [   15.015887] ide-cd: Call cdrom_transfer_packet_command
> [   15.016080] ide-cd: Call cdrom_newpc_intr, rq->cmd[0]: 0x3, write: 0x0
> [   15.016155] ide-cd: cdrom_newpc_intr: DRQ: stat: 0x58, thislen: 18
> [   15.016218] ide-cd: Call ide_cd_check_ireason, ireason: 0x2, rw: 0x0
> [   15.016282] ide-cd: cdrom_newpc_intr: data transfer, rq->cmd_type: 0x3, ireason: 0x2
> [   15.016405] ide-cd: Call cdrom_newpc_intr, rq->cmd[0]: 0x3, write: 0x0
> [   15.016475] ide-cd: cdrom_newpc_intr: DRQ: stat: 0x50, thislen: 0
> [   15.016537] ide-cd: Call ide_cd_request_sense_fixup
> [   15.016596] ide-cd: Call cdrom_end_request, cmd: 0x3, uptodate: 0x1, nsectors: 0
> [   15.016670] ide-cd: Call cdrom_analyze_sense_data, error_code: 0x70, sense_key: 0x2
> [   15.016748] ide-cd: cdrom_analyze_sense_data: failed cmd: 0x43
> [   15.016813] ATAPI device hdd:
> [   15.016862]   Error: Not ready -- (Sense key=0x02)
> [   15.016957]   Medium not present -- (asc=0x3a, ascq=0x00)
> [   15.017017]   The failed "Read Table of Contents" packet command was: 
> [   15.017021]   "43 02 00 00 00 00 00 00 04 00 00 00 00 00 00 00 "
> [   15.017734] ide-cd: Exit cdrom_end_request, uptodate: 0x1, nsectors: 1
> [   15.018097] ide-cd: Call ide_cd_do_request, rq->cmd_type: 0x2, block: 18446744073709551615
> [   15.018181] Sending BLOCK_PC to drive! Fixed.
> [   15.018238] Original rq: : dev hdd: type=2, flags=504c8
> [   15.018297]   sector 18446744073709551615, nr/cnr 0/0
> [   15.018357]   bio cf87bcc0, biotail cf87bcc0, buffer 00000000, data 00000000, len 36
> [   15.018431]   cdb: 12 00 00 00 24 00 00 00 00 00 00 00 00 00 00 00 
> [   15.019050] rq->cmd_len: 6
> [   15.019103] Pid: 1013, comm: cdrom_id Not tainted 2.6.27-rc7 #1
> [   15.019183]  [<d0900d0b>] ide_cd_do_request+0x4d9/0x6c6 [ide_cd_mod]
> [   15.019307]  [<c01e9b50>] __const_udelay+0x29/0x2a
> [   15.019408]  [<d090bb68>] __ide_wait_stat+0xab/0xd6 [ide_core]
> [   15.019569]  [<d090c68b>] ide_wait_stat+0x3f/0x6c [ide_core]
> [   15.019694]  [<d090adc3>] ide_do_request+0x671/0x876 [ide_core]
> [   15.019817]  [<c02bdc3c>] _spin_lock_irqsave+0x23/0x29
> [   15.019916]  [<c012b978>] lock_timer_base+0x19/0x35
> [   15.020089]  [<c012b978>] lock_timer_base+0x19/0x35
> [   15.020183]  [<c012ba3c>] del_timer+0x4a/0x50
> [   15.020277]  [<c01d855f>] elv_insert+0xc2/0x1d6
> [   15.020372]  [<c01dc491>] blk_execute_rq_nowait+0x5a/0x87
> [   15.020473]  [<c01dc539>] blk_execute_rq+0x7b/0x96
> [   15.020565]  [<c01dc414>] blk_end_sync_rq+0x0/0x23
> [   15.020658]  [<c0199e84>] bio_add_pc_page+0x16/0x1b
> [   15.020754]  [<c019a422>] bio_copy_user_iov+0x10d/0x169
> [   15.020850]  [<c01d8c05>] blk_rq_bio_prep+0x73/0xa6
> [   15.020944]  [<c01dc266>] blk_rq_append_bio+0x11/0x3a
> [   15.021039]  [<c01dc37e>] blk_rq_map_user+0xef/0x185
> [   15.021135]  [<c01deb90>] sg_io+0x1eb/0x2c8
> [   15.021228]  [<c01df0bb>] scsi_cmd_ioctl+0x1b8/0x40d
> [   15.021321]  [<c015a744>] find_get_page+0x1f/0x81
> [   15.021421]  [<c015ab06>] find_lock_page+0x10/0x43
> [   15.021517]  [<c015b12a>] filemap_fault+0x1f3/0x344
> [   15.021630]  [<d08f9c5e>] cdrom_ioctl+0x25/0xb31 [cdrom]
> [   15.021743]  [<c0167d5e>] handle_mm_fault+0x2f5/0x6e9
> [   15.021844]  [<d09004aa>] idecd_ioctl+0x12d/0x142 [ide_cd_mod]
> [   15.021948]  [<c0188932>] dput+0x16/0x103
> [   15.022044]  [<c01dd0cb>] blkdev_driver_ioctl+0x4b/0x5b
> [   15.022140]  [<c01dd795>] blkdev_ioctl+0x6ba/0x6d9
> [   15.022234]  [<c019b4ae>] blkdev_open+0x0/0x4d
> [   15.022327]  [<c019b4d3>] blkdev_open+0x25/0x4d
> [   15.022418]  [<c0178ae5>] __dentry_open+0x130/0x1fc
> [   15.022520]  [<c0178c2e>] nameidata_to_filp+0x1c/0x2c
> [   15.022617]  [<c0183405>] do_filp_open+0x34b/0x6a0
> [   15.022718]  [<c01692d0>] free_pgtables+0x7d/0x91
> [   15.022812]  [<c02bdce6>] _spin_lock+0x5/0x7
> [   15.022900]  [<c01e4d7e>] _atomic_dec_and_lock+0x26/0x48
> [   15.023004]  [<c02bdce6>] _spin_lock+0x5/0x7
> [   15.023093]  [<c019aaf9>] block_ioctl+0x13/0x16
> [   15.023184]  [<c019aae6>] block_ioctl+0x0/0x16
> [   15.023274]  [<c01840ac>] vfs_ioctl+0x1c/0x5f
> [   15.023363]  [<c0184331>] do_vfs_ioctl+0x242/0x255
> [   15.023455]  [<c017894e>] do_sys_open+0xaa/0xb2
> [   15.023550]  [<c0184385>] sys_ioctl+0x41/0x58
> [   15.023638]  [<c01038a3>] sysenter_do_call+0x12/0x2f
> [   15.023736]  =======================
> [   15.023788] ide-cd: Call cdrom_do_block_pc, rq->cmd_type: 0xb
> [   15.023853] ide-cd: Call cdrom_start_packet_command, xferlen: 36
> [   15.023927] ide-cd: Call cdrom_transfer_packet_command
> [   15.024079] ide-cd: Call cdrom_newpc_intr, rq->cmd[0]: 0x12, write: 0x0
> [   15.024155] ide-cd: cdrom_newpc_intr: DRQ: stat: 0x58, thislen: 36
> [   15.024220] ide-cd: Call ide_cd_check_ireason, ireason: 0x2, rw: 0x0
> [   15.024285] ide-cd: cdrom_newpc_intr: data transfer, rq->cmd_type: 0xb, ireason: 0x2
> [   15.024416] ide-cd: Call cdrom_newpc_intr, rq->cmd[0]: 0x12, write: 0x0
> [   15.024489] ide-cd: cdrom_newpc_intr: DRQ: stat: 0x50, thislen: 0
> [   15.024552] ide-cd: Call ide_cd_request_sense_fixup
> [   15.024610] ide-cd: Call cdrom_end_request, cmd: 0x12, uptodate: 0x1, nsectors: 0
> [   15.024686] ide-cd: Exit cdrom_end_request, uptodate: 0x1, nsectors: 1
> [   15.031087] ide-cd: Call ide_cd_do_request, rq->cmd_type: 0x2, block: 18446744073709551615
> [   15.031181] Sending BLOCK_PC to drive! Fixed.
> [   15.031238] Original rq: : dev hdd: type=2, flags=504c8
> [   15.031298]   sector 18446744073709551615, nr/cnr 0/0
> [   15.031358]   bio cf87bcc0, biotail cf87bcc0, buffer 00000000, data 00000000, len 8
> [   15.031433]   cdb: 46 00 00 00 00 00 00 00 08 00 00 00 00 00 00 00 
> [   15.032118] rq->cmd_len: 10
> [   15.032172] Pid: 1013, comm: cdrom_id Not tainted 2.6.27-rc7 #1
> [   15.032247]  [<d0900d0b>] ide_cd_do_request+0x4d9/0x6c6 [ide_cd_mod]
> [   15.032368]  [<c01e9b50>] __const_udelay+0x29/0x2a
> [   15.032468]  [<d090bb68>] __ide_wait_stat+0xab/0xd6 [ide_core]
> [   15.032629]  [<d090c68b>] ide_wait_stat+0x3f/0x6c [ide_core]
> [   15.032753]  [<d090adc3>] ide_do_request+0x671/0x876 [ide_core]
> [   15.032877]  [<c02bdc3c>] _spin_lock_irqsave+0x23/0x29
> [   15.032975]  [<c012b978>] lock_timer_base+0x19/0x35
> [   15.033074]  [<c012b978>] lock_timer_base+0x19/0x35
> [   15.033167]  [<c012ba3c>] del_timer+0x4a/0x50
> [   15.033256]  [<c01d855f>] elv_insert+0xc2/0x1d6
> [   15.033349]  [<c01dc491>] blk_execute_rq_nowait+0x5a/0x87
> [   15.033450]  [<c01dc539>] blk_execute_rq+0x7b/0x96
> [   15.033542]  [<c01dc414>] blk_end_sync_rq+0x0/0x23
> [   15.033635]  [<c0199e84>] bio_add_pc_page+0x16/0x1b
> [   15.033729]  [<c019a422>] bio_copy_user_iov+0x10d/0x169
> [   15.033824]  [<c01d8c05>] blk_rq_bio_prep+0x73/0xa6
> [   15.033915]  [<c01dc266>] blk_rq_append_bio+0x11/0x3a
> [   15.034010]  [<c01dc37e>] blk_rq_map_user+0xef/0x185
> [   15.034106]  [<c01deb90>] sg_io+0x1eb/0x2c8
> [   15.034199]  [<c01df0bb>] scsi_cmd_ioctl+0x1b8/0x40d
> [   15.034293]  [<c015a744>] find_get_page+0x1f/0x81
> [   15.034391]  [<c015ab06>] find_lock_page+0x10/0x43
> [   15.034486]  [<c015b12a>] filemap_fault+0x1f3/0x344
> [   15.034602]  [<d08f9c5e>] cdrom_ioctl+0x25/0xb31 [cdrom]
> [   15.034713]  [<c0167d5e>] handle_mm_fault+0x2f5/0x6e9
> [   15.034813]  [<d09004aa>] idecd_ioctl+0x12d/0x142 [ide_cd_mod]
> [   15.034918]  [<c0188932>] dput+0x16/0x103
> [   15.035015]  [<c01dd0cb>] blkdev_driver_ioctl+0x4b/0x5b
> [   15.035111]  [<c01dd795>] blkdev_ioctl+0x6ba/0x6d9
> [   15.035205]  [<c019b4ae>] blkdev_open+0x0/0x4d
> [   15.035297]  [<c019b4d3>] blkdev_open+0x25/0x4d
> [   15.035388]  [<c0178ae5>] __dentry_open+0x130/0x1fc
> [   15.035490]  [<c0178c2e>] nameidata_to_filp+0x1c/0x2c
> [   15.035587]  [<c0183405>] do_filp_open+0x34b/0x6a0
> [   15.035689]  [<c01692d0>] free_pgtables+0x7d/0x91
> [   15.035781]  [<c02bdce6>] _spin_lock+0x5/0x7
> [   15.035871]  [<c01e4d7e>] _atomic_dec_and_lock+0x26/0x48
> [   15.035971]  [<c02bdce6>] _spin_lock+0x5/0x7
> [   15.036110]  [<c019aaf9>] block_ioctl+0x13/0x16
> [   15.036201]  [<c019aae6>] block_ioctl+0x0/0x16
> [   15.036290]  [<c01840ac>] vfs_ioctl+0x1c/0x5f
> [   15.036379]  [<c0184331>] do_vfs_ioctl+0x242/0x255
> [   15.036470]  [<c017894e>] do_sys_open+0xaa/0xb2
> [   15.036561]  [<c0184385>] sys_ioctl+0x41/0x58
> [   15.037675]  [<c01038a3>] sysenter_do_call+0x12/0x2f
> [   15.037773]  =======================
> [   15.037826] ide-cd: Call cdrom_do_block_pc, rq->cmd_type: 0xb
> [   15.037890] ide-cd: Call cdrom_start_packet_command, xferlen: 8
> [   15.037963] ide-cd: Call cdrom_transfer_packet_command
> [   15.038186] ide-cd: Call cdrom_newpc_intr, rq->cmd[0]: 0x46, write: 0x0
> [   15.038261] ide-cd: cdrom_decode_status: stat: 0x51, good_stat: 0x0, rq->cmd_type: 0xb, err: 0x20
> [   15.038342] ide-cd: Call cdrom_queue_request_sense
> [   15.038399] ide-cd: failed_cmd: 0x46
> [   15.038467] ide-cd: Call ide_cd_do_request, rq->cmd_type: 0x3, block: 18446744073709551615
> [   15.038546] ide-cd: Call cdrom_do_block_pc, rq->cmd_type: 0x3
> [   15.038607] ide-cd: Call cdrom_start_packet_command, xferlen: 18
> [   15.038678] ide-cd: Call cdrom_transfer_packet_command
> [   15.038869] ide-cd: Call cdrom_newpc_intr, rq->cmd[0]: 0x3, write: 0x0
> [   15.038944] ide-cd: cdrom_newpc_intr: DRQ: stat: 0x58, thislen: 18
> [   15.039008] ide-cd: Call ide_cd_check_ireason, ireason: 0x2, rw: 0x0
> [   15.039073] ide-cd: cdrom_newpc_intr: data transfer, rq->cmd_type: 0x3, ireason: 0x2
> [   15.039201] ide-cd: Call cdrom_newpc_intr, rq->cmd[0]: 0x3, write: 0x0
> [   15.039272] ide-cd: cdrom_newpc_intr: DRQ: stat: 0x50, thislen: 0
> [   15.039335] ide-cd: Call ide_cd_request_sense_fixup
> [   15.039394] ide-cd: Call cdrom_end_request, cmd: 0x3, uptodate: 0x1, nsectors: 0
> [   15.039470] ide-cd: Call cdrom_analyze_sense_data, error_code: 0x70, sense_key: 0x2
> [   15.039545] ide-cd: cdrom_analyze_sense_data: failed cmd: 0x46
> [   15.039608] ATAPI device hdd:
> [   15.039656]   Error: Not ready -- (Sense key=0x02)
> [   15.039751]   Medium not present -- (asc=0x3a, ascq=0x00)
> [   15.039813]   The failed "Get Configuration" packet command was: 
> [   15.039816]   "46 00 00 00 00 00 00 00 08 00 00 00 00 00 00 00 "
> [   15.040569] ide-cd: Exit cdrom_end_request, uptodate: 0x1, nsectors: 1
> [   15.054974] ide-cd: Call ide_cd_queue_pc, rq->cmd[0]: 0x1e, write: 0x0, timeout: 0, cmd_flags: 0x0
> [   15.055113] ide-cd: Call ide_cd_do_request, rq->cmd_type: 0xb, block: 18446744073709551615
> [   15.055194] ide-cd: Call cdrom_do_block_pc, rq->cmd_type: 0xb
> [   15.055257] ide-cd: Call cdrom_start_packet_command, xferlen: 0
> [   15.055331] ide-cd: Call cdrom_transfer_packet_command
> [   15.055496] ide-cd: Call cdrom_newpc_intr, rq->cmd[0]: 0x1e, write: 0x0
> [   15.055572] ide-cd: cdrom_newpc_intr: DRQ: stat: 0x50, thislen: 0
> [   15.055636] ide-cd: Call ide_cd_request_sense_fixup
> [   15.055695] ide-cd: Call cdrom_end_request, cmd: 0x1e, uptodate: 0x1, nsectors: 0
> [   15.055770] ide-cd: Exit cdrom_end_request, uptodate: 0x1, nsectors: 1
> [   15.063557] ide-cd: Call cdrom_check_status
> [   15.063636] ide-cd: Call ide_cd_queue_pc, rq->cmd[0]: 0x0, write: 0x0, timeout: 0, cmd_flags: 0x1000
> [   15.063771] ide-cd: Call ide_cd_do_request, rq->cmd_type: 0xb, block: 18446744073709551615
> [   15.063851] ide-cd: Call cdrom_do_block_pc, rq->cmd_type: 0xb
> [   15.063914] ide-cd: Call cdrom_start_packet_command, xferlen: 0
> [   15.063987] ide-cd: Call cdrom_transfer_packet_command
> [   15.064266] ide-cd: Call cdrom_newpc_intr, rq->cmd[0]: 0x0, write: 0x0
> [   15.064340] ide-cd: cdrom_decode_status: stat: 0x51, good_stat: 0x0, rq->cmd_type: 0xb, err: 0x20
> [   15.064421] ide-cd: Call cdrom_queue_request_sense
> [   15.064477] ide-cd: failed_cmd: 0x0
> [   15.064541] ide-cd: Call ide_cd_do_request, rq->cmd_type: 0x3, block: 18446744073709551615
> [   15.064619] ide-cd: Call cdrom_do_block_pc, rq->cmd_type: 0x3
> [   15.064681] ide-cd: Call cdrom_start_packet_command, xferlen: 18
> [   15.064752] ide-cd: Call cdrom_transfer_packet_command
> [   15.064945] ide-cd: Call cdrom_newpc_intr, rq->cmd[0]: 0x3, write: 0x0
> [   15.065019] ide-cd: cdrom_newpc_intr: DRQ: stat: 0x58, thislen: 18
> [   15.065086] ide-cd: Call ide_cd_check_ireason, ireason: 0x2, rw: 0x0
> [   15.065151] ide-cd: cdrom_newpc_intr: data transfer, rq->cmd_type: 0x3, ireason: 0x2
> [   15.065276] ide-cd: Call cdrom_newpc_intr, rq->cmd[0]: 0x3, write: 0x0
> [   15.065349] ide-cd: cdrom_newpc_intr: DRQ: stat: 0x50, thislen: 0
> [   15.065413] ide-cd: Call ide_cd_request_sense_fixup
> [   15.065471] ide-cd: Call cdrom_end_request, cmd: 0x3, uptodate: 0x1, nsectors: 0
> [   15.065548] ide-cd: Call cdrom_analyze_sense_data, error_code: 0x70, sense_key: 0x2
> [   15.065625] ide-cd: cdrom_analyze_sense_data: failed cmd: 0x0
> [   15.065687] ATAPI device hdd:
> [   15.065737]   Error: Not ready -- (Sense key=0x02)
> [   15.065829]   Medium not present -- (asc=0x3a, ascq=0x00)
> [   15.065890]   The failed "Test Unit Ready" packet command was: 
> [   15.065894]   "00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 "
> [   15.066608] ide-cd: Exit cdrom_end_request, uptodate: 0x1, nsectors: 1
> [   15.066716] ide-cd: Call ide_cd_read_toc
> [   15.066771] ide-cd: Call cdrom_check_status
> [   15.066826] ide-cd: Call ide_cd_queue_pc, rq->cmd[0]: 0x0, write: 0x0, timeout: 0, cmd_flags: 0x1000
> [   15.066927] ide-cd: Call ide_cd_do_request, rq->cmd_type: 0xb, block: 18446744073709551615
> [   15.067006] ide-cd: Call cdrom_do_block_pc, rq->cmd_type: 0xb
> [   15.067068] ide-cd: Call cdrom_start_packet_command, xferlen: 0
> [   15.067139] ide-cd: Call cdrom_transfer_packet_command
> [   15.067350] ide-cd: Call cdrom_newpc_intr, rq->cmd[0]: 0x0, write: 0x0
> [   15.067422] ide-cd: cdrom_decode_status: stat: 0x51, good_stat: 0x0, rq->cmd_type: 0xb, err: 0x20
> [   15.067502] ide-cd: Call cdrom_queue_request_sense
> [   15.067559] ide-cd: failed_cmd: 0x0
> [   15.067623] ide-cd: Call ide_cd_do_request, rq->cmd_type: 0x3, block: 18446744073709551615
> [   15.067702] ide-cd: Call cdrom_do_block_pc, rq->cmd_type: 0x3
> [   15.067763] ide-cd: Call cdrom_start_packet_command, xferlen: 18
> [   15.067834] ide-cd: Call cdrom_transfer_packet_command
> [   15.068060] ide-cd: Call cdrom_newpc_intr, rq->cmd[0]: 0x3, write: 0x0
> [   15.068136] ide-cd: cdrom_newpc_intr: DRQ: stat: 0x58, thislen: 18
> [   15.068202] ide-cd: Call ide_cd_check_ireason, ireason: 0x2, rw: 0x0
> [   15.068268] ide-cd: cdrom_newpc_intr: data transfer, rq->cmd_type: 0x3, ireason: 0x2
> [   15.068393] ide-cd: Call cdrom_newpc_intr, rq->cmd[0]: 0x3, write: 0x0
> [   15.068465] ide-cd: cdrom_newpc_intr: DRQ: stat: 0x50, thislen: 0
> [   15.068527] ide-cd: Call ide_cd_request_sense_fixup
> [   15.068585] ide-cd: Call cdrom_end_request, cmd: 0x3, uptodate: 0x1, nsectors: 0
> [   15.068660] ide-cd: Call cdrom_analyze_sense_data, error_code: 0x70, sense_key: 0x2
> [   15.068736] ide-cd: cdrom_analyze_sense_data: failed cmd: 0x0
> [   15.068799] ATAPI device hdd:
> [   15.068847]   Error: Not ready -- (Sense key=0x02)
> [   15.068937]   Medium not present -- (asc=0x3a, ascq=0x00)
> [   15.068997]   The failed "Test Unit Ready" packet command was: 
> [   15.069000]   "00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 "
> [   15.069703] ide-cd: Exit cdrom_end_request, uptodate: 0x1, nsectors: 1
> [   15.069809] ide-cd: Call cdrom_read_capacity
> [   15.069868] ide-cd: Call ide_cd_queue_pc, rq->cmd[0]: 0x25, write: 0x0, timeout: 0, cmd_flags: 0x1000
> [   15.069968] ide-cd: Call ide_cd_do_request, rq->cmd_type: 0xb, block: 18446744073709551615
> [   15.070046] ide-cd: Call cdrom_do_block_pc, rq->cmd_type: 0xb
> [   15.070108] ide-cd: Call cdrom_start_packet_command, xferlen: 8
> [   15.070179] ide-cd: Call cdrom_transfer_packet_command
> [   15.070380] ide-cd: Call cdrom_newpc_intr, rq->cmd[0]: 0x25, write: 0x0
> [   15.070454] ide-cd: cdrom_decode_status: stat: 0x51, good_stat: 0x0, rq->cmd_type: 0xb, err: 0x20
> [   15.070533] ide-cd: Call cdrom_queue_request_sense
> [   15.070590] ide-cd: failed_cmd: 0x25
> [   15.070651] ide-cd: Call ide_cd_do_request, rq->cmd_type: 0x3, block: 18446744073709551615
> [   15.070729] ide-cd: Call cdrom_do_block_pc, rq->cmd_type: 0x3
> [   15.070793] ide-cd: Call cdrom_start_packet_command, xferlen: 18
> [   15.070864] ide-cd: Call cdrom_transfer_packet_command
> [   15.071054] ide-cd: Call cdrom_newpc_intr, rq->cmd[0]: 0x3, write: 0x0
> [   15.071129] ide-cd: cdrom_newpc_intr: DRQ: stat: 0x58, thislen: 18
> [   15.071193] ide-cd: Call ide_cd_check_ireason, ireason: 0x2, rw: 0x0
> [   15.071259] ide-cd: cdrom_newpc_intr: data transfer, rq->cmd_type: 0x3, ireason: 0x2
> [   15.071384] ide-cd: Call cdrom_newpc_intr, rq->cmd[0]: 0x3, write: 0x0
> [   15.071457] ide-cd: cdrom_newpc_intr: DRQ: stat: 0x50, thislen: 0
> [   15.071519] ide-cd: Call ide_cd_request_sense_fixup
> [   15.071578] ide-cd: Call cdrom_end_request, cmd: 0x3, uptodate: 0x1, nsectors: 0
> [   15.071653] ide-cd: Call cdrom_analyze_sense_data, error_code: 0x70, sense_key: 0x2
> [   15.071729] ide-cd: cdrom_analyze_sense_data: failed cmd: 0x25
> [   15.071791] ATAPI device hdd:
> [   15.071841]   Error: Not ready -- (Sense key=0x02)
> [   15.071931]   Medium not present -- (asc=0x3a, ascq=0x00)
> [   15.071991]   The failed "Read Cd/Dvd Capacity" packet command was: 
> [   15.071995]   "25 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 "
> [   15.072750] ide-cd: Exit cdrom_end_request, uptodate: 0x1, nsectors: 1
> [   15.072852] ide-cd: Call cdrom_read_tocentry
> [   15.072910] ide-cd: Call ide_cd_queue_pc, rq->cmd[0]: 0x43, write: 0x0, timeout: 0, cmd_flags: 0x1000
> [   15.073013] ide-cd: Call ide_cd_do_request, rq->cmd_type: 0xb, block: 18446744073709551615
> [   15.073092] ide-cd: Call cdrom_do_block_pc, rq->cmd_type: 0xb
> [   15.073154] ide-cd: Call cdrom_start_packet_command, xferlen: 4
> [   15.073225] ide-cd: Call cdrom_transfer_packet_command
> [   15.073411] ide-cd: Call cdrom_newpc_intr, rq->cmd[0]: 0x43, write: 0x0
> [   15.073485] ide-cd: cdrom_decode_status: stat: 0x51, good_stat: 0x0, rq->cmd_type: 0xb, err: 0x20
> [   15.073566] ide-cd: Call cdrom_queue_request_sense
> [   15.073623] ide-cd: failed_cmd: 0x43
> [   15.073684] ide-cd: Call ide_cd_do_request, rq->cmd_type: 0x3, block: 18446744073709551615
> [   15.073761] ide-cd: Call cdrom_do_block_pc, rq->cmd_type: 0x3
> [   15.074846] ide-cd: Call cdrom_start_packet_command, xferlen: 18
> [   15.074917] ide-cd: Call cdrom_transfer_packet_command
> [   15.075106] ide-cd: Call cdrom_newpc_intr, rq->cmd[0]: 0x3, write: 0x0
> [   15.075180] ide-cd: cdrom_newpc_intr: DRQ: stat: 0x58, thislen: 18
> [   15.075243] ide-cd: Call ide_cd_check_ireason, ireason: 0x2, rw: 0x0
> [   15.075336] ide-cd: cdrom_newpc_intr: data transfer, rq->cmd_type: 0x3, ireason: 0x2
> [   15.075462] ide-cd: Call cdrom_newpc_intr, rq->cmd[0]: 0x3, write: 0x0
> [   15.075535] ide-cd: cdrom_newpc_intr: DRQ: stat: 0x50, thislen: 0
> [   15.075598] ide-cd: Call ide_cd_request_sense_fixup
> [   15.075657] ide-cd: Call cdrom_end_request, cmd: 0x3, uptodate: 0x1, nsectors: 0
> [   15.075732] ide-cd: Call cdrom_analyze_sense_data, error_code: 0x70, sense_key: 0x2
> [   15.075809] ide-cd: cdrom_analyze_sense_data: failed cmd: 0x43
> [   15.075871] ATAPI device hdd:
> [   15.075920]   Error: Not ready -- (Sense key=0x02)
> [   15.076043]   Medium not present -- (asc=0x3a, ascq=0x00)
> [   15.076104]   The failed "Read Table of Contents" packet command was: 
> [   15.076108]   "43 02 00 00 00 00 00 00 04 00 00 00 00 00 00 00 "
> [   15.076806] ide-cd: Exit cdrom_end_request, uptodate: 0x1, nsectors: 1
> [   15.077158] ide-cd: Call ide_cd_queue_pc, rq->cmd[0]: 0x1e, write: 0x0, timeout: 0, cmd_flags: 0x0
> [   15.077275] ide-cd: Call ide_cd_do_request, rq->cmd_type: 0xb, block: 18446744073709551615
> [   15.077355] ide-cd: Call cdrom_do_block_pc, rq->cmd_type: 0xb
> [   15.077416] ide-cd: Call cdrom_start_packet_command, xferlen: 0
> [   15.077488] ide-cd: Call cdrom_transfer_packet_command
> [   15.077651] ide-cd: Call cdrom_newpc_intr, rq->cmd[0]: 0x1e, write: 0x0
> [   15.077726] ide-cd: cdrom_newpc_intr: DRQ: stat: 0x50, thislen: 0
> [   15.077788] ide-cd: Call ide_cd_request_sense_fixup
> [   15.077852] ide-cd: Call cdrom_end_request, cmd: 0x1e, uptodate: 0x1, nsectors: 0
> [   15.077929] ide-cd: Exit cdrom_end_request, uptodate: 0x1, nsectors: 1
> [   16.481512] input: Power Button (FF) as /class/input/input2
> [   16.512268] ACPI: Power Button (FF) [PWRF]
> [   16.512531] input: Power Button (CM) as /class/input/input3
> [   16.548339] ACPI: Power Button (CM) [PWRB]
> [   16.548604] input: Sleep Button (CM) as /class/input/input4
> [   16.580286] ACPI: Sleep Button (CM) [SLPB]
> [   16.646077] parport_pc: VIA 686A/8231 detected
> [   16.646085] parport_pc: probing current configuration
> [   16.646110] parport_pc: Current parallel port base: 0x378
> [   16.646166] parport0: PC-style at 0x378, irq 7 [PCSPP,TRISTATE,EPP]
> [   16.740316] parport_pc: VIA parallel port: io=0x378, irq=7
> [   16.773502] Linux agpgart interface v0.103
> [   16.797181] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
> [   16.804721] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
> [   16.822705] agpgart: Detected VIA Twister-K/KT133x/KM133 chipset
> [   16.829286] agpgart-via 0000:00:00.0: AGP aperture is 64M @ 0xd0000000
> [   17.040854] usb0: register 'gl620a' at usb-0000:00:07.3-2, Genesys GeneLink, ce:c4:e8:42:5c:57
> [   17.040991] usbcore: registered new interface driver gl620a
> [   17.241957] gameport: EMU10K1 is pci0000:00:0e.1/gameport0, io 0xc000, speed 1242kHz
> [   17.243758] input: PC Speaker as /class/input/input5
> [   17.626519] EMU10K1_Audigy 0000:00:0e.0: PCI INT A -> Link[LNKD] -> GSI 12 (level, low) -> IRQ 12
> [   20.118327] Adding 489940k swap on /dev/hda1.  Priority:-1 extents:1 across:489940k
> [   20.567926] EXT3 FS on hda6, internal journal
> [   21.287578] loop: module loaded
> [   22.501882] kjournald starting.  Commit interval 5 seconds
> [   22.502283] EXT3 FS on hda5, internal journal
> [   22.502380] EXT3-fs: mounted filesystem with ordered data mode.
> [   22.546309] kjournald starting.  Commit interval 5 seconds
> [   22.546713] EXT3 FS on hda2, internal journal
> [   22.546811] EXT3-fs: mounted filesystem with ordered data mode.
> [   22.582435] kjournald starting.  Commit interval 5 seconds
> [   22.582832] EXT3 FS on hda7, internal journal
> [   22.582929] EXT3-fs: mounted filesystem with ordered data mode.
> [   24.232777] NET: Registered protocol family 10
> [   24.234244] lo: Disabled Privacy Extensions
> [   24.366467] eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
> [   28.282983] nf_conntrack version 0.5.0 (4096 buckets, 16384 max)
> [   28.283337] CONFIG_NF_CT_ACCT is deprecated and will be removed soon. Plase use
> [   28.283415] nf_conntrack.acct=1 kernel paramater, acct=1 nf_conntrack module option or
> [   28.283491] sysctl net.netfilter.nf_conntrack_acct=1 to enable it.
> [   28.394551] ip_tables: (C) 2000-2006 Netfilter Core Team
> [   31.728651] lp0: using parport0 (interrupt-driven).
> [   31.752174] ppdev: user-space parallel port driver
> [   34.960070] eth0: no IPv6 routers present
> [   35.269801] warning: `ntpd' uses 32-bit capabilities (legacy support in use)


-- 
Regards/Gruss,
    Boris.
