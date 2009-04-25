From: Andrey Gusev <a.gusev1980@mail.ru>
Subject: Delay on intialization ide subsystem(most likely)
Date: Sat, 25 Apr 2009 17:02:03 +0400
Message-ID: <20090425170203.74603b9c@power-debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx73.mail.ru ([94.100.176.87]:56613 "EHLO mx45.mail.ru"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751422AbZDYNUr (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 25 Apr 2009 09:20:47 -0400
Received: from mx75.mail.ru (mx75.mail.ru [94.100.176.90])
	by mx45.mail.ru (mPOP.Fallback_MX) with ESMTP id 51AD6246B11
	for <linux-ide@vger.kernel.org>; Sat, 25 Apr 2009 17:02:52 +0400 (MSD)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com, linux-ide@vger.kernel.org, petkovbb@gmail.com

Hello!

I have tested linux-2.6.30-rc3 on my system and find some problems. One
of them is delaying on initialization IDE subsystem. I don't have this
problem on 2.6.29.1. The difference is looked on log of dmesg.

Information about my system:

andrey@power-debian:~/build/kernel/linux-2.6.30-rc3$ LANG=C sh
scripts/ver_linux If some fields are empty or look unusual you may have
an old version. Compare to the current minimal requirements in
Documentation/Changes. 
Linux power-debian 2.6.29.1 #2 SMP PREEMPT Sun Apr 5 02:21:38 MSD 2009
ppc GNU/Linux 
Gnu C                  4.3.3
Gnu make               3.81
binutils               2.19.1
util-linux             2.13.1.1
mount                  2.13.1.1
module-init-tools      found
Linux C Library        2.9
Dynamic linker (ldd)   2.9
Procps                 3.2.7
Console-tools          0.2.3
Sh-utils               7.2
Modules Loaded         ipv6 cpufreq_stats cpufreq_powersave
cpufreq_ondemand cpufreq_userspace freq_table snd_powermac snd_pcm
snd_seq snd_timer snd_seq_device snd snd_page_alloc therm_windtunnel
sbp2 scsi_mod apm_emu apm_emulation evdev sha256_generic cbc dm_crypt
dm_mirror dm_region_hash dm_log dm_snapshot dm_mod ohci1394 ieee1394

dmesg on 2.6.30-rc3:
[    0.000000] Using PowerMac machine description
[    0.000000] Total memory = 1536MB; using 4096kB for hash table (at cfc00000)
[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Linux version 2.6.30-rc3 (andrey@power-debian) (gcc version 4.3.3 (Debian 4.3.3-3) ) #3 SMP PREEMPT Sat Apr 25 11:24:14 MSD 2009
[    0.000000] Found initrd at 0xc1b00000:0xc2080400
[    0.000000] Found UniNorth memory controller & host bridge @ 0xf8000000 revision: 0x24
[    0.000000] Mapped at 0xff7c0000
[    0.000000] Found a Keylargo mac-io controller, rev: 3, mapped at 0xff740000
[    0.000000] PowerMac motherboard: PowerMac G4 Windtunnel
[    0.000000] CPU maps initialized for 1 thread per core
[    0.000000]  (thread shift is 0)
[    0.000000] console [udbg0] enabled
[    0.000000] Found UniNorth PCI host bridge at 0x00000000f0000000. Firmware bus number: 0->0
[    0.000000] PCI host bridge /pci@f0000000  ranges:
[    0.000000]  MEM 0x00000000f1000000..0x00000000f1ffffff -> 0x00000000f1000000 
[    0.000000]   IO 0x00000000f0000000..0x00000000f07fffff -> 0x0000000000000000
[    0.000000]  MEM 0x0000000090000000..0x00000000afffffff -> 0x0000000090000000 
[    0.000000] Found UniNorth PCI host bridge at 0x00000000f2000000. Firmware bus number: 0->0
[    0.000000] PCI host bridge /pci@f2000000 (primary) ranges:
[    0.000000]  MEM 0x00000000f3000000..0x00000000f3ffffff -> 0x00000000f3000000 
[    0.000000]   IO 0x00000000f2000000..0x00000000f27fffff -> 0x0000000000000000
[    0.000000]  MEM 0x0000000080000000..0x000000008fffffff -> 0x0000000080000000 
[    0.000000] Found UniNorth PCI host bridge at 0x00000000f4000000. Firmware bus number: 0->0
[    0.000000] PCI host bridge /pci@f4000000  ranges:
[    0.000000]  MEM 0x00000000f5000000..0x00000000f5ffffff -> 0x00000000f5000000 
[    0.000000]   IO 0x00000000f4000000..0x00000000f47fffff -> 0x0000000000000000
[    0.000000] via-pmu: Server Mode is disabled
[    0.000000] PMU driver v2 initialized for Core99, firmware: 0c
[    0.000000] nvram: Checking bank 0...
[    0.000000] nvram: gen0=1392, gen1=1391
[    0.000000] nvram: Active bank is: 0
[    0.000000] nvram: OF partition at 0x410
[    0.000000] nvram: XP partition at 0x1020
[    0.000000] nvram: NR partition at 0x1120
[    0.000000] Top of RAM: 0x60000000, Total RAM: 0x60000000
[    0.000000] Memory hole size: 0MB
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA      0x00000000 -> 0x00030000
[    0.000000]   Normal   0x00030000 -> 0x00030000
[    0.000000]   HighMem  0x00030000 -> 0x00060000
[    0.000000] Movable zone start PFN for each node
[    0.000000] early_node_map[1] active PFN ranges
[    0.000000]     0: 0x00000000 -> 0x00060000
[    0.000000] On node 0 totalpages: 393216
[    0.000000] free_area_init_node: node 0, pgdat c0498ec0, node_mem_map c053d000
[    0.000000]   DMA zone: 1536 pages used for memmap
[    0.000000]   DMA zone: 0 pages reserved
[    0.000000]   DMA zone: 195072 pages, LIFO batch:31
[    0.000000]   HighMem zone: 1536 pages used for memmap
[    0.000000]   HighMem zone: 195072 pages, LIFO batch:31
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 390144
[    0.000000] Kernel command line: root=/dev/mapper/power--group-root ro video=ofonly 
[    0.000000] Experimental hierarchical RCU implementation.
[    0.000000] Experimental hierarchical RCU init done.
[    0.000000] NR_IRQS:512
[    0.000000] mpic: Setting up MPIC " MPIC 1   " version 1.2 at 80040000, max 4 CPUs
[    0.000000] mpic: ISU size: 64, shift: 6, mask: 3f
[    0.000000] mpic: Initializing for 64 sources
[    0.000000] irq: irq 55 on host /pci@f2000000/mac-io@17/interrupt-controller@40000 mapped to virtual irq 55
[    0.000000] PID hash table entries: 4096 (order: 12, 16384 bytes)
[    0.000000] GMT Delta read from XPRAM: 240 minutes, DST: on
[    0.000000] time_init: decrementer frequency = 33.304672 MHz
[    0.000000] time_init: processor frequency   = 866.666664 MHz
[    0.000000] clocksource: timebase mult[781a6fe] shift[22] registered
[    0.000000] clockevent: decrementer mult[886] shift[16] cpu[0]
[    0.000429] Console: colour dummy device 80x25
[    0.000722] console handover: boot [udbg0] -> real [tty0]
[    0.001081] irq: irq 22 on host /pci@f2000000/mac-io@17/interrupt-controller@40000 mapped to virtual irq 22
[    0.001121] irq: irq 23 on host /pci@f2000000/mac-io@17/interrupt-controller@40000 mapped to virtual irq 23
[    0.002076] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
[    0.003131] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
[    0.217076] High memory: 786432k
[    0.217089] Memory: 1543164k/1572864k available (4564k kernel code, 28616k reserved, 172k data, 474k bss, 252k init)
[    0.217248] SLUB: Genslabs=13, HWalign=32, Order=0-3, MinObjects=0, CPUs=2, Nodes=1
[    0.217279] Calibrating delay loop... 66.56 BogoMIPS (lpj=332800)
[    0.430594] Security Framework initialized
[    0.430689] Mount-cache hash table entries: 512
[    0.431270] device-tree: Duplicate name in /cpus/PowerPC,G4@0/l2-cache, renamed to "l2-cache#1"
[    0.431375] device-tree: Duplicate name in /cpus/PowerPC,G4@0, renamed to "l2-cache#1"
[    0.431517] device-tree: Duplicate name in /cpus/PowerPC,G4@1/l2-cache, renamed to "l2-cache#1"
[    0.431616] device-tree: Duplicate name in /cpus/PowerPC,G4@1, renamed to "l2-cache#1"
[    0.435054] Initializing cgroup subsys ns
[    0.435073] Initializing cgroup subsys cpuacct
[    0.435100] Initializing cgroup subsys devices
[    0.435113] Initializing cgroup subsys freezer
[    0.435606] PowerMac SMP probe found 2 cpus
[    0.435722] irq: irq 42 on host /pci@f2000000/mac-io@17/interrupt-controller@40000 mapped to virtual irq 42
[    0.435771] KeyWest i2c @0xf8001003 irq 42 /uni-n@f8000000/i2c@f8001000
[    0.435790]  channel 0 bus <multibus>
[    0.435801]  channel 1 bus <multibus>
[    0.435842] irq: irq 26 on host /pci@f2000000/mac-io@17/interrupt-controller@40000 mapped to virtual irq 26
[    0.435858] KeyWest i2c @0x80018000 irq 26 /pci@f2000000/mac-io@17/i2c@18000
[    0.435879]  channel 0 bus <multibus>
[    0.435900] PMU i2c /pci@f2000000/mac-io@17/via-pmu@16000/pmu-i2c
[    0.435918]  channel 1 bus <multibus>
[    0.435932]  channel 2 bus <multibus>
[    0.435958] pmf: no parser for command 17 !
[    0.436021] Processor timebase sync using GPIO 0x73
[    0.436039] mpic: requesting IPIs ... 
[    0.436061] irq: irq 251 on host /pci@f2000000/mac-io@17/interrupt-controller@40000 mapped to virtual irq 251
[    0.436080] irq: irq 252 on host /pci@f2000000/mac-io@17/interrupt-controller@40000 mapped to virtual irq 252
[    0.436097] irq: irq 253 on host /pci@f2000000/mac-io@17/interrupt-controller@40000 mapped to virtual irq 253
[    0.436114] irq: irq 254 on host /pci@f2000000/mac-io@17/interrupt-controller@40000 mapped to virtual irq 254
[    0.436125] CPU0: L2CR is 80080000
[    0.436139] CPU0: L3CR is 8f0b0000
[476246921.960395] CPU1: L2CR was 80000
[476246921.960433] CPU1: L2CR set to 80080000
[476246921.960439] CPU1: L3CR was 0
[476246921.960600] CPU1: L3CR set to 8f0b0000
[    0.438326] Processor 1 found.
[    0.438391] clockevent: decrementer mult[886] shift[16] cpu[1]
[    0.438440] Brought up 2 CPUs
[    0.438736] CPU0 attaching sched-domain:
[    0.438747]  domain 0: span 0-1 level CPU
[    0.438756]   groups: 0 1
[    0.438774] CPU1 attaching sched-domain:
[    0.438781]  domain 0: span 0-1 level CPU
[    0.438789]   groups: 1 0
[    0.449215] net_namespace: 1100 bytes
[    0.449831] NET: Registered protocol family 16
[    0.451566] irq: irq 25 on host /pci@f2000000/mac-io@17/interrupt-controller@40000 mapped to virtual irq 25
[    0.451622] irq: irq 47 on host /pci@f2000000/mac-io@17/interrupt-controller@40000 mapped to virtual irq 47
[    0.452154] PCI: Probing PCI hardware
[    0.452506] pci 0000:00:10.0: reg 10 32bit mmio: [0x91000000-0x91ffffff]
[    0.452520] pci 0000:00:10.0: reg 14 32bit mmio: [0x98000000-0x9fffffff]
[    0.452532] pci 0000:00:10.0: reg 18 32bit mmio: [0x000000-0x07ffff]
[    0.452556] pci 0000:00:10.0: reg 30 32bit mmio: [0x90000000-0x9001ffff]
[    0.452660] irq: irq 48 on host /pci@f2000000/mac-io@17/interrupt-controller@40000 mapped to virtual irq 48
[    0.453233] pci 0001:10:17.0: reg 10 32bit mmio: [0x80000000-0x8007ffff]
[    0.453298] pci 0001:10:18.0: reg 10 32bit mmio: [0x80081000-0x80081fff]
[    0.453364] pci 0001:10:19.0: reg 10 32bit mmio: [0x80080000-0x80080fff]
[    0.453473] irq: irq 27 on host /pci@f2000000/mac-io@17/interrupt-controller@40000 mapped to virtual irq 27
[    0.453519] irq: irq 28 on host /pci@f2000000/mac-io@17/interrupt-controller@40000 mapped to virtual irq 28
[    0.454375] pci 0002:20:0d.0: reg 10 32bit mmio: [0xf5004000-0xf5007fff]
[    0.454442] pci 0002:20:0e.0: reg 10 32bit mmio: [0xf5000000-0xf5000fff]
[    0.454490] pci 0002:20:0e.0: supports D1 D2
[    0.454497] pci 0002:20:0e.0: PME# supported from D0 D1 D2 D3hot
[    0.454524] pci 0002:20:0e.0: PME# disabled
[    0.454563] pci 0002:20:0f.0: reg 10 32bit mmio: [0xf5200000-0xf53fffff]
[    0.454593] pci 0002:20:0f.0: reg 30 32bit mmio: [0xf5100000-0xf51fffff]
[    0.454677] irq: irq 39 on host /pci@f2000000/mac-io@17/interrupt-controller@40000 mapped to virtual irq 39
[    0.454714] irq: irq 40 on host /pci@f2000000/mac-io@17/interrupt-controller@40000 mapped to virtual irq 40
[    0.454755] irq: irq 41 on host /pci@f2000000/mac-io@17/interrupt-controller@40000 mapped to virtual irq 41
[    0.455538] pci_bus 0000:00: resource 0 io:  [0x802000-0x1001fff]
[    0.455548] pci_bus 0000:00: resource 1 mem: [0xf1000000-0xf1ffffff]
[    0.455557] pci_bus 0000:00: resource 2 mem: [0x90000000-0xafffffff]
[    0.455565] pci_bus 0001:10: resource 0 io:  [0x00-0x7fffff]
[    0.455574] pci_bus 0001:10: resource 1 mem: [0xf3000000-0xf3ffffff]
[    0.455583] pci_bus 0001:10: resource 2 mem: [0x80000000-0x8fffffff]
[    0.455591] pci_bus 0002:20: resource 0 io:  [0xff7fe000-0xffffdfff]
[    0.455600] pci_bus 0002:20: resource 1 mem: [0xf5000000-0xf5ffffff]
[    0.500769] bio: create slab <bio-0> at 0
[    0.529065] usbcore: registered new interface driver usbfs
[    0.529308] usbcore: registered new interface driver hub
[    0.538666] usbcore: registered new device driver usb
[    0.578535] Switched to high resolution mode on CPU 1
[    0.578545] Switched to high resolution mode on CPU 0
[    0.589566] NET: Registered protocol family 2
[    0.678695] IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
[    0.679751] TCP established hash table entries: 131072 (order: 8, 1048576 bytes)
[    0.682084] TCP bind hash table entries: 65536 (order: 7, 786432 bytes)
[    0.683796] TCP: Hash tables configured (established 131072 bind 65536)
[    0.683826] TCP reno registered
[    0.708817] NET: Registered protocol family 1
[    0.709057] checking if image is initramfs...
[    1.076102] rootfs image is initramfs; unpacking...
[    1.076153] Freeing initrd memory: 5633k freed
[    1.077275] Thermal assist unit not available
[    1.077816] setup_kcore: restrict size=3fffffff
[    1.089251] audit: initializing netlink socket (disabled)
[    1.089312] type=2000 audit(1240631044.070:1): initialized
[    1.089908] highmem bounce pool size: 64 pages
[    1.108535] VFS: Disk quotas dquot_6.5.2
[    1.111136] Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
[    1.112553] msgmni has been set to 1491
[    1.121586] alg: No test for stdrng (krng)
[    1.121677] alg: No test for stdrng (ansi_cprng)
[    1.121931] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 253)
[    1.121963] io scheduler noop registered
[    1.121978] io scheduler anticipatory registered
[    1.121994] io scheduler deadline registered
[    1.122235] io scheduler cfq registered (default)
[    1.122777] Using unsupported 1440x900 NVDA,Display-B at 98004000, depth=8, pitch=1536
[    1.144171] Console: switching to colour frame buffer device 180x56
[    1.162847] fb0: Open Firmware frame buffer device on /pci@f0000000/NVDA,Parent@10/NVDA,Display-B@1
[    1.163136] Using unsupported 640x480 NVDA,Display-A at 99000000, depth=8, pitch=640
[    1.171157] fb1: Open Firmware frame buffer device on /pci@f0000000/NVDA,Parent@10/NVDA,Display-A@0
[    1.179732] Generic non-volatile memory driver v1.1
[    1.180003] Linux agpgart interface v0.103
[    1.180151] agpgart-uninorth 0000:00:0b.0: Apple UniNorth 2 chipset
[    1.180502] agpgart-uninorth 0000:00:0b.0: configuring for size idx: 8
[    1.180833] agpgart-uninorth 0000:00:0b.0: AGP aperture is 32M @ 0x0
[    1.188654] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
[    1.211569] pmac_zilog: 0.6 (Benjamin Herrenschmidt <benh@kernel.crashing.org>)
[    1.211786] ttyPZ0 at MMIO 0x80013020 (irq = 22) is a Z85c30 ESCC - Serial port
[    1.212118] ttyPZ1 at MMIO 0x80013000 (irq = 23) is a Z85c30 ESCC - Serial port
[    1.217007] brd: module loaded
[    1.219445] loop: module loaded
[    1.219605] MacIO PCI driver attached to Keylargo chipset
[    1.220731] irq: irq 32 on host /pci@f2000000/mac-io@17/interrupt-controller@40000 mapped to virtual irq 32
[    1.228832] irq: irq 19 on host /pci@f2000000/mac-io@17/interrupt-controller@40000 mapped to virtual irq 19
[    1.228857] irq: irq 11 on host /pci@f2000000/mac-io@17/interrupt-controller@40000 mapped to virtual irq 16
[    1.239031] irq: irq 20 on host /pci@f2000000/mac-io@17/interrupt-controller@40000 mapped to virtual irq 20
[    1.239056] irq: irq 12 on host /pci@f2000000/mac-io@17/interrupt-controller@40000 mapped to virtual irq 17
[    1.239325] irq: irq 5 on host /pci@f2000000/mac-io@17/interrupt-controller@40000 mapped to virtual irq 18
[    1.239349] irq: irq 6 on host /pci@f2000000/mac-io@17/interrupt-controller@40000 mapped to virtual irq 21
[    1.248683] irq: irq 7 on host /pci@f2000000/mac-io@17/interrupt-controller@40000 mapped to virtual irq 24
[    1.248707] irq: irq 8 on host /pci@f2000000/mac-io@17/interrupt-controller@40000 mapped to virtual irq 29
[    1.249531] input: Macintosh mouse button emulation as /class/input/input0
[    1.250528] Uniform Multi-Platform E-IDE driver
[    1.250886] adb: starting probe task...
[    1.250997] adb: finished probe task...
[    1.258613] ide-pmac 0002:20:0d.0: enabling device (0000 -> 0002)
[    2.288520] ide-pmac: Found Apple UniNorth ATA-6 controller (PCI), bus ID 3, irq 39
[    2.288744] Probing IDE interface ide0...
[    2.588704] hda: IBM-IC35L060AVVA07-0, ATA DISK drive
[    3.308753] hda: host max PIO4 wanted PIO255(auto-tune) selected PIO4
[    3.308930] hda: UDMA/100 mode selected
[    3.314263] ide0 at 0xf1012000-0xf1012070,0xf1012160 on irq 39
[    4.348519] ide-pmac: Found Apple KeyLargo ATA-4 controller (macio), bus ID 2, irq 19
[    4.353743] Probing IDE interface ide1...
[   68.851321] ide1 at 0xf100e000-0xf100e070,0xf100e160 on irq 19
[   69.878520] ide-pmac: Found Apple KeyLargo ATA-3 controller (macio), bus ID 0, irq 20
[   69.883870] Probing IDE interface ide2...
[  133.858648] hde: PHILIPS CDD5101, ATAPI CD/DVD-ROM drive
[  135.598503] hde: host max PIO4 wanted PIO255(auto-tune) selected PIO4
[  135.598886] hde: MWDMA2 mode selected
[  135.604590] ide2 at 0xf1016000-0xf1016070,0xf1016160 on irq 20
[  135.618666] ide-gd driver 1.18
[  135.624047] hda: max request size: 128KiB
[  135.661182] hda: 120103200 sectors (61492 MB) w/1863KiB Cache, CHS=65535/16/63
[  135.666819] hda: cache flushes supported
[  135.672645]  hda: [mac] hda1 hda2 hda3 hda4
[  135.692419] ide-cd driver 5.00
[  135.708483] ide-cd: hde: ATAPI 32X DVD-ROM CD-R/RW drive, 8192kB Cache
[  135.713905] Uniform CD-ROM driver Revision: 3.20
[  135.801110] sungem.c:v0.98 8/24/03 David S. Miller (davem@redhat.com)
[  135.881373] PHY ID: 2060e1, addr: 0
[  135.882809] eth0: Sun GEM (PCI) 10/100/1000BaseT Ethernet 00:03:93:ab:d1:a6
[  135.888326] eth0: Found BCM5421 PHY
[  135.893991] I2O subsystem v1.325
[  135.899445] i2o: max drivers = 8
[  135.931076] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[  135.938616] ohci_hcd 0001:10:18.0: enabling device (0000 -> 0002)
[  135.944208] ohci_hcd 0001:10:18.0: OHCI Host Controller
[  135.961022] ohci_hcd 0001:10:18.0: new USB bus registered, assigned bus number 1
[  135.966572] ohci_hcd 0001:10:18.0: irq 27, io mem 0x80081000
[  136.050877] usb usb1: New USB device found, idVendor=1d6b, idProduct=0001
[  136.056233] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[  136.061501] usb usb1: Product: OHCI Host Controller
[  136.066642] usb usb1: Manufacturer: Linux 2.6.30-rc3 ohci_hcd
[  136.071815] usb usb1: SerialNumber: 0001:10:18.0
[  136.078022] usb usb1: configuration #1 chosen from 1 choice
[  136.088613] hub 1-0:1.0: USB hub found
[  136.093819] hub 1-0:1.0: 2 ports detected
[  136.102048] ohci_hcd 0001:10:19.0: enabling device (0000 -> 0002)
[  136.107178] ohci_hcd 0001:10:19.0: OHCI Host Controller
[  136.113281] ohci_hcd 0001:10:19.0: new USB bus registered, assigned bus number 2
[  136.118463] ohci_hcd 0001:10:19.0: irq 28, io mem 0x80080000
[  136.200848] usb usb2: New USB device found, idVendor=1d6b, idProduct=0001
[  136.206042] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[  136.211234] usb usb2: Product: OHCI Host Controller
[  136.216349] usb usb2: Manufacturer: Linux 2.6.30-rc3 ohci_hcd
[  136.221455] usb usb2: SerialNumber: 0001:10:19.0
[  136.227114] usb usb2: configuration #1 chosen from 1 choice
[  136.234011] hub 2-0:1.0: USB hub found
[  136.239130] hub 2-0:1.0: 2 ports detected
[  136.247418] mice: PS/2 mouse device common for all mice
[  136.256023] rtc-generic rtc-generic: rtc core: registered rtc-generic as rtc0
[  136.262000] i2c /dev entries driver
[  136.275026] PowerMac i2c bus pmu 2 registered
[  136.282077] PowerMac i2c bus pmu 1 registered
[  136.288016] PowerMac i2c bus mac-io 0 registered
[  136.293999] PowerMac i2c bus uni-n 1 registered
[  136.301076] PowerMac i2c bus uni-n 0 registered
[  136.333284] usbcore: registered new interface driver hiddev
[  136.338997] usbcore: registered new interface driver usbhid
[  136.343589] usbhid: v2.6:USB HID core driver
[  136.350483] TCP cubic registered
[  136.355028] NET: Registered protocol family 17
[  136.360997] registered taskstats version 1
[  136.365955] input: PMU as /class/input/input1
[  136.370638] rtc-generic rtc-generic: setting system clock to 2009-04-25 07:46:20 UTC (1240645580)
[  136.375315] Freeing unused kernel memory: 252k init
[  136.461010] usb 1-1: new full speed USB device using ohci_hcd and address 2
[  136.640014] usb 1-1: New USB device found, idVendor=05e3, idProduct=0608
[  136.640026] usb 1-1: New USB device strings: Mfr=0, Product=1, SerialNumber=0
[  136.640033] usb 1-1: Product: USB2.0 Hub
[  136.641143] usb 1-1: configuration #1 chosen from 1 choice
[  136.663565] hub 1-1:1.0: USB hub found
[  136.669199] hub 1-1:1.0: 4 ports detected
[  136.821046] usb 2-1: new low speed USB device using ohci_hcd and address 2
[  137.005025] usb 2-1: New USB device found, idVendor=0458, idProduct=002e
[  137.010040] usb 2-1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[  137.015067] usb 2-1: Product: NetScroll+ Traveler
[  137.019923] usb 2-1: Manufacturer: KYE
[  137.024984] usb 2-1: configuration #1 chosen from 1 choice
[  137.042282] input: KYE NetScroll+ Traveler as /class/input/input2
[  137.047445] generic-usb 0003:0458:002E.0001: input,hidraw0: USB HID v1.10 Mouse [KYE NetScroll+ Traveler] on usb-0001:10:19.0-1/input0
[  137.132054] usb 1-1.1: new full speed USB device using ohci_hcd and address 3
[  137.260045] usb 1-1.1: New USB device found, idVendor=05e3, idProduct=0608
[  137.265508] usb 1-1.1: New USB device strings: Mfr=0, Product=1, SerialNumber=0
[  137.270791] usb 1-1.1: Product: USB2.0 Hub
[  137.276265] usb 1-1.1: configuration #1 chosen from 1 choice
[  137.282120] hub 1-1.1:1.0: USB hub found
[  137.288015] hub 1-1.1:1.0: 4 ports detected
[  137.592017] usb 1-1.1.1: new low speed USB device using ohci_hcd and address 4
[  137.616700] ohci1394 0002:20:0e.0: enabling device (0000 -> 0002)
[  137.683076] ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[40]  MMIO=[f5000000-f50007ff]  Max Packet=[2048]  IR/IT contexts=[8/8]
[  137.737007] usb 1-1.1.1: New USB device found, idVendor=04d9, idProduct=0022
[  137.742614] usb 1-1.1.1: New USB device strings: Mfr=0, Product=2, SerialNumber=0
[  137.748129] usb 1-1.1.1: Product: USB Keyboard
[  137.753909] usb 1-1.1.1: configuration #1 chosen from 1 choice
[  137.772307] input: USB Keyboard as /class/input/input3
[  137.778062] generic-usb 0003:04D9:0022.0002: input,hidraw1: USB HID v1.10 Keyboard [USB Keyboard] on usb-0001:10:18.0-1.1.1/input0
[  137.805181] input: USB Keyboard as /class/input/input4
[  137.811268] generic-usb 0003:04D9:0022.0003: input,hidraw2: USB HID v1.10 Device [USB Keyboard] on usb-0001:10:18.0-1.1.1/input1
[  137.952705] device-mapper: uevent: version 1.0.3
[  137.960890] device-mapper: ioctl: 4.14.0-ioctl (2008-04-23) initialised: dm-devel@redhat.com
[  138.281373] eth0: Link is up at 100 Mbps, full-duplex.
[  139.024235] ieee1394: Host added: ID:BUS[0-00:1023]  GUID[000393fffeabd1a6]
[  164.795679] EXT3-fs: mounted filesystem with writeback data mode.
[  164.804626] kjournald starting.  Commit interval 5 seconds
[  167.463022] udev: starting version 141
[  167.471763] udev: deprecated sysfs layout; update the kernel or disable CONFIG_SYSFS_DEPRECATED; some udev features will not work correctly
[  171.919555] EXT3 FS on dm-1, internal journal
[  172.633827] apm_emu: PMU APM Emulation initialized.
[  172.756460] SCSI subsystem initialized
[  172.818758] DS1775 digital thermometer [@49]
[  172.826377] Temp: 52.3 C  Hyst: 60.0 C  OS: 65.0 C
[  172.835045] ADM1030 fan controller [@2c]
[  173.054876] irq: irq 1 on host /pci@f2000000/mac-io@17/interrupt-controller@40000 mapped to virtual irq 30
[  173.054939] irq: irq 2 on host /pci@f2000000/mac-io@17/interrupt-controller@40000 mapped to virtual irq 31
[  173.060889] irq: irq 61 on host /pci@f2000000/mac-io@17/interrupt-controller@40000 mapped to virtual irq 61
[  173.060929] irq: irq 60 on host /pci@f2000000/mac-io@17/interrupt-controller@40000 mapped to virtual irq 60
[  173.481487] input: PowerMac Beep as /class/input/input5
[  176.651788] kjournald starting.  Commit interval 5 seconds
[  176.658828] EXT3 FS on dm-3, internal journal
[  176.665632] EXT3-fs: mounted filesystem with writeback data mode.
[  176.701301] REISERFS (device dm-4): found reiserfs format "3.6" with standard journal
[  176.708293] REISERFS (device dm-4): using ordered data mode
[  176.724502] REISERFS (device dm-4): journal params: device dm-4, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
[  176.734936] REISERFS (device dm-4): checking transaction log (dm-4)
[  176.801510] REISERFS (device dm-4): Using r5 hash to sort names
[  176.808792] ------------[ cut here ]------------
[  176.815834] Badness at fs/namei.c:1251
[  176.822880] NIP: c00dbff0 LR: c015527c CTR: 00000000
[  176.829872] REGS: c1dc7bf0 TRAP: 0700   Not tainted  (2.6.30-rc3)
[  176.836824] MSR: 00029032 <EE,ME,CE,IR,DR>  CR: 24084482  XER: 00000000
[  176.843846] TASK = efbca300[2210] 'mount' THREAD: c1dc6000 CPU: 1
[  176.844006] GPR00: 00000001 c1dc7ca0 efbca300 c03dc81c ef549bb0 0000000e c1dc7d48 00002eb8 
[  176.851119] GPR08: ef592070 c0520000 00000000 00000000 24084482 100298f4 10020000 1021f1d0 
[  176.858288] GPR16: 1021f738 1021f8a0 1021f1e0 1021f778 00000000 1021f3e8 00000000 00000000 
[  176.865451] GPR24: c1878780 00000000 c03dc81c 00000000 00000000 c1dc7d28 c19ccc00 ef549bb0 
[  176.879521] NIP [c00dbff0] lookup_one_len+0x38/0xe4
[  176.886609] LR [c015527c] reiserfs_xattr_init+0x74/0x228
[  176.893720] Call Trace:
[  176.900787] [c1dc7ca0] [1021f8a0] 0x1021f8a0 (unreliable)
[  176.907867] [c1dc7cc0] [c015527c] reiserfs_xattr_init+0x74/0x228
[  176.914775] [c1dc7ce0] [c013eaa4] reiserfs_fill_super+0xcb4/0xe28
[  176.921501] [c1dc7e10] [c00d3c54] get_sb_bdev+0x120/0x184
[  176.928209] [c1dc7e60] [c013ba40] get_super_block+0x1c/0x2c
[  176.934892] [c1dc7e70] [c00d381c] vfs_kern_mount+0xa0/0x13c
[  176.941569] [c1dc7ea0] [c00d3908] do_kern_mount+0x40/0xf4
[  176.948268] [c1dc7ec0] [c00ec6b4] do_mount+0x770/0x7cc
[  176.954907] [c1dc7f10] [c00ec7a4] sys_mount+0x94/0xe0
[  176.961415] [c1dc7f40] [c00155c4] ret_from_syscall+0x0/0x38
[  176.967823] --- Exception: c01 at 0xfecec04
[  176.967827]     LR = 0x10004478
[  176.980525] Instruction dump:
[  176.986851] 93e1001c 7c9f2378 90010024 81040014 39280078 80090000 2f800001 40be002c 
[  176.993330] 3d20c052 80090dc8 7c000034 5400d97e <0f000000> 2f800000 41be0010 38000001 
[  177.133183] Adding 1048568k swap on /dev/mapper/power--group-swap_1.  Priority:-1 extents:1 across:1048568k 
[  178.928594] eth0: Link is up at 100 Mbps, full-duplex.
[  178.928764] eth0: Pause is enabled (rxfifo: 10240 off: 7168 on: 5632)
[  180.852826] CPU-temp: 52.3 C, Case: 33.0 C,  Fan: 0 (tuned -11)
[  182.959963] NET: Registered protocol family 10
[  182.968551] lo: Disabled Privacy Extensions
[  192.738013] Process Xorg (pid:2782) mapped non-existing PCI legacy memory for 00000:00
[  193.370993] eth0: no IPv6 routers present

dmesg on 2.6.29.1:
[    0.000000] Using PowerMac machine description
[    0.000000] Total memory = 1536MB; using 4096kB for hash table (at cfc00000)
[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Linux version 2.6.29.1 (andrey@power-debian) (gcc version 4.3.3 (Debian 4.3.3-3) ) #2 SMP PREEMPT Sun Apr 5 02:21:38 MSD 2009
[    0.000000] Found initrd at 0xc1a00000:0xc1f7e000
[    0.000000] Found UniNorth memory controller & host bridge @ 0xf8000000 revision: 0x24
[    0.000000] Mapped at 0xff7c0000
[    0.000000] Found a Keylargo mac-io controller, rev: 3, mapped at 0xff740000
[    0.000000] PowerMac motherboard: PowerMac G4 Windtunnel
[    0.000000] CPU maps initialized for 1 thread per core
[    0.000000]  (thread shift is 0)
[    0.000000] console [udbg0] enabled
[    0.000000] Found UniNorth PCI host bridge at 0x00000000f0000000. Firmware bus number: 0->0
[    0.000000] PCI host bridge /pci@f0000000  ranges:
[    0.000000]  MEM 0x00000000f1000000..0x00000000f1ffffff -> 0x00000000f1000000 
[    0.000000]   IO 0x00000000f0000000..0x00000000f07fffff -> 0x0000000000000000
[    0.000000]  MEM 0x0000000090000000..0x00000000afffffff -> 0x0000000090000000 
[    0.000000] Found UniNorth PCI host bridge at 0x00000000f2000000. Firmware bus number: 0->0
[    0.000000] PCI host bridge /pci@f2000000 (primary) ranges:
[    0.000000]  MEM 0x00000000f3000000..0x00000000f3ffffff -> 0x00000000f3000000 
[    0.000000]   IO 0x00000000f2000000..0x00000000f27fffff -> 0x0000000000000000
[    0.000000]  MEM 0x0000000080000000..0x000000008fffffff -> 0x0000000080000000 
[    0.000000] Found UniNorth PCI host bridge at 0x00000000f4000000. Firmware bus number: 0->0
[    0.000000] PCI host bridge /pci@f4000000  ranges:
[    0.000000]  MEM 0x00000000f5000000..0x00000000f5ffffff -> 0x00000000f5000000 
[    0.000000]   IO 0x00000000f4000000..0x00000000f47fffff -> 0x0000000000000000
[    0.000000] via-pmu: Server Mode is disabled
[    0.000000] PMU driver v2 initialized for Core99, firmware: 0c
[    0.000000] nvram: Checking bank 0...
[    0.000000] nvram: gen0=1392, gen1=1391
[    0.000000] nvram: Active bank is: 0
[    0.000000] nvram: OF partition at 0x410
[    0.000000] nvram: XP partition at 0x1020
[    0.000000] nvram: NR partition at 0x1120
[    0.000000] Top of RAM: 0x60000000, Total RAM: 0x60000000
[    0.000000] Memory hole size: 0MB
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA      0x00000000 -> 0x00030000
[    0.000000]   Normal   0x00030000 -> 0x00030000
[    0.000000]   HighMem  0x00030000 -> 0x00060000
[    0.000000] Movable zone start PFN for each node
[    0.000000] early_node_map[1] active PFN ranges
[    0.000000]     0: 0x00000000 -> 0x00060000
[    0.000000] On node 0 totalpages: 393216
[    0.000000] free_area_init_node: node 0, pgdat c0456ea0, node_mem_map c04f1000
[    0.000000]   DMA zone: 1536 pages used for memmap
[    0.000000]   DMA zone: 0 pages reserved
[    0.000000]   DMA zone: 195072 pages, LIFO batch:31
[    0.000000]   HighMem zone: 1536 pages used for memmap
[    0.000000]   HighMem zone: 195072 pages, LIFO batch:31
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 390144
[    0.000000] Kernel command line: root=/dev/mapper/power--group-root ro video=ofonly 
[    0.000000] Experimental hierarchical RCU implementation.
[    0.000000] Experimental hierarchical RCU init done.
[    0.000000] mpic: Setting up MPIC " MPIC 1   " version 1.2 at 80040000, max 4 CPUs
[    0.000000] mpic: ISU size: 64, shift: 6, mask: 3f
[    0.000000] mpic: Initializing for 64 sources
[    0.000000] PID hash table entries: 4096 (order: 12, 16384 bytes)
[    0.000000] GMT Delta read from XPRAM: 240 minutes, DST: on
[    0.000000] time_init: decrementer frequency = 33.304558 MHz
[    0.000000] time_init: processor frequency   = 866.666664 MHz
[    0.000000] clocksource: timebase mult[781a8ad] shift[22] registered
[    0.000000] clockevent: decrementer mult[886] shift[16] cpu[0]
[    0.000422] Console: colour dummy device 80x25
[    0.000715] console handover: boot [udbg0] -> real [tty0]
[    0.002050] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
[    0.003105] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
[    0.213077] High memory: 786432k
[    0.213086] Memory: 1543420k/1572864k available (4304k kernel code, 28300k reserved, 152k data, 466k bss, 244k init)
[    0.213240] SLUB: Genslabs=12, HWalign=32, Order=0-3, MinObjects=0, CPUs=2, Nodes=1
[    0.213269] Calibrating delay loop... 66.56 BogoMIPS (lpj=332800)
[    0.430586] Security Framework initialized
[    0.430650] Mount-cache hash table entries: 512
[    0.431217] device-tree: Duplicate name in /cpus/PowerPC,G4@0/l2-cache, renamed to "l2-cache#1"
[    0.431322] device-tree: Duplicate name in /cpus/PowerPC,G4@0, renamed to "l2-cache#1"
[    0.431461] device-tree: Duplicate name in /cpus/PowerPC,G4@1/l2-cache, renamed to "l2-cache#1"
[    0.431558] device-tree: Duplicate name in /cpus/PowerPC,G4@1, renamed to "l2-cache#1"
[    0.434975] Initializing cgroup subsys ns
[    0.434992] Initializing cgroup subsys cpuacct
[    0.435005] Initializing cgroup subsys devices
[    0.435017] Initializing cgroup subsys freezer
[    0.435506] PowerMac SMP probe found 2 cpus
[    0.435659] KeyWest i2c @0xf8001003 irq 42 /uni-n@f8000000/i2c@f8001000
[    0.435690]  channel 0 bus <multibus>
[    0.435700]  channel 1 bus <multibus>
[    0.435746] KeyWest i2c @0x80018000 irq 26 /pci@f2000000/mac-io@17/i2c@18000
[    0.435766]  channel 0 bus <multibus>
[    0.435787] PMU i2c /pci@f2000000/mac-io@17/via-pmu@16000/pmu-i2c
[    0.435805]  channel 1 bus <multibus>
[    0.435818]  channel 2 bus <multibus>
[    0.435845] pmf: no parser for command 17 !
[    0.435906] Processor timebase sync using GPIO 0x73
[    0.435923] mpic: requesting IPIs ... 
[    0.435967] CPU0: L2CR is 80080000
[    0.435980] CPU0: L3CR is 8f0b0000
[478142821.179213] CPU1: L2CR was 80000
[478142821.179251] CPU1: L2CR set to 80080000
[478142821.179257] CPU1: L3CR was 0
[478142821.179417] CPU1: L3CR set to 8f0b0000
[    0.439695] Processor 1 found.
[    0.439762] clockevent: decrementer mult[886] shift[16] cpu[1]
[    0.439808] Brought up 2 CPUs
[    0.440102] CPU0 attaching sched-domain:
[    0.440113]  domain 0: span 0-1 level CPU
[    0.440121]   groups: 0 1
[    0.440138] CPU1 attaching sched-domain:
[    0.440143]  domain 0: span 0-1 level CPU
[    0.440150]   groups: 1 0
[    0.441631] net_namespace: 1068 bytes
[    0.442103] NET: Registered protocol family 16
[    0.444433] PCI: Probing PCI hardware
[    0.444773] pci 0000:00:10.0: reg 10 32bit mmio: [0x91000000-0x91ffffff]
[    0.444785] pci 0000:00:10.0: reg 14 32bit mmio: [0x98000000-0x9fffffff]
[    0.444796] pci 0000:00:10.0: reg 18 32bit mmio: [0x000000-0x07ffff]
[    0.444818] pci 0000:00:10.0: reg 30 32bit mmio: [0x90000000-0x9001ffff]
[    0.445470] pci 0001:10:17.0: reg 10 32bit mmio: [0x80000000-0x8007ffff]
[    0.445530] pci 0001:10:18.0: reg 10 32bit mmio: [0x80081000-0x80081fff]
[    0.445590] pci 0001:10:19.0: reg 10 32bit mmio: [0x80080000-0x80080fff]
[    0.446599] pci 0002:20:0d.0: reg 10 32bit mmio: [0xf5004000-0xf5007fff]
[    0.446661] pci 0002:20:0e.0: reg 10 32bit mmio: [0xf5000000-0xf5000fff]
[    0.446706] pci 0002:20:0e.0: supports D1 D2
[    0.446713] pci 0002:20:0e.0: PME# supported from D0 D1 D2 D3hot
[    0.446739] pci 0002:20:0e.0: PME# disabled
[    0.446774] pci 0002:20:0f.0: reg 10 32bit mmio: [0xf5200000-0xf53fffff]
[    0.446802] pci 0002:20:0f.0: reg 30 32bit mmio: [0xf5100000-0xf51fffff]
[    0.447687] pci_bus 0000:00: resource 0 io:  [0x802000-0x1001fff]
[    0.447695] pci_bus 0000:00: resource 1 mem: [0xf1000000-0xf1ffffff]
[    0.447703] pci_bus 0000:00: resource 2 mem: [0x90000000-0xafffffff]
[    0.447710] pci_bus 0001:10: resource 0 io:  [0x00-0x7fffff]
[    0.447717] pci_bus 0001:10: resource 1 mem: [0xf3000000-0xf3ffffff]
[    0.447725] pci_bus 0001:10: resource 2 mem: [0x80000000-0x8fffffff]
[    0.447732] pci_bus 0002:20: resource 0 io:  [0xff7fe000-0xffffdfff]
[    0.447740] pci_bus 0002:20: resource 1 mem: [0xf5000000-0xf5ffffff]
[    0.454508] bio: create slab <bio-0> at 0
[    0.455948] usbcore: registered new interface driver usbfs
[    0.456289] usbcore: registered new interface driver hub
[    0.456542] usbcore: registered new device driver usb
[    0.482910] NET: Registered protocol family 2
[    0.490623] Switched to high resolution mode on CPU 0
[    0.499829] Switched to high resolution mode on CPU 1
[    0.610783] IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
[    0.611809] TCP established hash table entries: 131072 (order: 8, 1048576 bytes)
[    0.614209] TCP bind hash table entries: 65536 (order: 7, 786432 bytes)
[    0.615967] TCP: Hash tables configured (established 131072 bind 65536)
[    0.615998] TCP reno registered
[    0.640929] NET: Registered protocol family 1
[    0.641326] checking if image is initramfs... it is
[    2.869810] Freeing initrd memory: 5624k freed
[    2.871003] Thermal assist unit not available
[    2.871196] setup_kcore: restrict size=3fffffff
[    2.872158] audit: initializing netlink socket (disabled)
[    2.872214] type=2000 audit(1240642340.870:1): initialized
[    2.872867] highmem bounce pool size: 64 pages
[    2.881576] VFS: Disk quotas dquot_6.5.2
[    2.881891] Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
[    2.883276] msgmni has been set to 1491
[    2.884165] alg: No test for stdrng (krng)
[    2.884302] alg: No test for stdrng (ansi_cprng)
[    2.884528] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 253)
[    2.884566] io scheduler noop registered
[    2.884580] io scheduler anticipatory registered
[    2.884596] io scheduler deadline registered
[    2.884637] io scheduler cfq registered (default)
[    2.884993] Using unsupported 1440x900 NVDA,Display-B at 98004000, depth=8, pitch=1536
[    2.906390] Console: switching to colour frame buffer device 180x56
[    2.924982] fb0: Open Firmware frame buffer device on /pci@f0000000/NVDA,Parent@10/NVDA,Display-B@1
[    2.925263] Using unsupported 640x480 NVDA,Display-A at 99000000, depth=8, pitch=640
[    2.925689] fb1: Open Firmware frame buffer device on /pci@f0000000/NVDA,Parent@10/NVDA,Display-A@0
[    2.935979] Generic non-volatile memory driver v1.1
[    2.936250] Linux agpgart interface v0.103
[    2.936393] agpgart-uninorth 0000:00:0b.0: Apple UniNorth 2 chipset
[    2.936729] agpgart-uninorth 0000:00:0b.0: configuring for size idx: 8
[    2.937067] agpgart-uninorth 0000:00:0b.0: AGP aperture is 32M @ 0x0
[    2.937416] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
[    2.938660] pmac_zilog: 0.6 (Benjamin Herrenschmidt <benh@kernel.crashing.org>)
[    2.938866] ttyPZ0 at MMIO 0x80013020 (irq = 22) is a Z85c30 ESCC - Serial port
[    2.939195] ttyPZ1 at MMIO 0x80013000 (irq = 23) is a Z85c30 ESCC - Serial port
[    2.945141] brd: module loaded
[    2.948449] loop: module loaded
[    2.948576] sungem.c:v0.98 8/24/03 David S. Miller (davem@redhat.com)
[    3.031008] PHY ID: 2060e1, addr: 0
[    3.032398] eth0: Sun GEM (PCI) 10/100/1000BaseT Ethernet 00:03:93:ab:d1:a6
[    3.032584] eth0: Found BCM5421 PHY
[    3.032914] MacIO PCI driver attached to Keylargo chipset
[    3.036651] input: Macintosh mouse button emulation as /class/input/input0
[    3.037882] Uniform Multi-Platform E-IDE driver
[    3.038149] adb: starting probe task...
[    3.038323] adb: finished probe task...
[    3.038666] ide-pmac 0002:20:0d.0: enabling device (0000 -> 0002)
[    4.070614] ide-pmac: Found Apple UniNorth ATA-6 controller (PCI), bus ID 3, irq 39
[    4.075869] Probing IDE interface ide0...
[    4.380792] hda: IBM-IC35L060AVVA07-0, ATA DISK drive
[    5.100850] hda: host max PIO4 wanted PIO255(auto-tune) selected PIO4
[    5.101026] hda: UDMA/100 mode selected
[    5.106364] ide0 at 0xf1012000-0xf1012070,0xf1012160 on irq 39
[    5.420982] eth0: Link is up at 100 Mbps, full-duplex.
[    6.140612] ide-pmac: Found Apple KeyLargo ATA-4 controller (macio), bus ID 2, irq 19
[    6.145962] Probing IDE interface ide1...
[    6.750859] ide1 at 0xf100e000-0xf100e070,0xf100e160 on irq 19
[    7.780612] ide-pmac: Found Apple KeyLargo ATA-3 controller (macio), bus ID 0, irq 20
[    7.786081] Probing IDE interface ide2...
[    8.210790] hde: PHILIPS CDD5101, ATAPI CD/DVD-ROM drive
[    8.570841] hde: host max PIO4 wanted PIO255(auto-tune) selected PIO4
[    8.571221] hde: MWDMA2 mode selected
[    8.577030] ide2 at 0xf1016000-0xf1016070,0xf1016160 on irq 20
[    8.582848] ide-gd driver 1.18
[    8.588288] hda: max request size: 128KiB
[    8.620816] hda: 120103200 sectors (61492 MB) w/1863KiB Cache, CHS=65535/16/63
[    8.626530] hda: cache flushes supported
[    8.632450]  hda: [mac] hda1 hda2 hda3 hda4
[    8.648977] ide-cd driver 5.00
[    8.656415] ide-cd: hde: ATAPI 32X DVD-ROM CD-R/RW drive, 8192kB Cache
[    8.662093] Uniform CD-ROM driver Revision: 3.20
[    8.695018] I2O subsystem v1.325
[    8.700671] i2o: max drivers = 8
[    8.707159] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    8.712928] ohci_hcd 0001:10:18.0: enabling device (0000 -> 0002)
[    8.718482] ohci_hcd 0001:10:18.0: OHCI Host Controller
[    8.724333] ohci_hcd 0001:10:18.0: new USB bus registered, assigned bus number 1
[    8.729803] ohci_hcd 0001:10:18.0: irq 27, io mem 0x80081000
[    8.813011] usb usb1: New USB device found, idVendor=1d6b, idProduct=0001
[    8.818280] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    8.823467] usb usb1: Product: OHCI Host Controller
[    8.828628] usb usb1: Manufacturer: Linux 2.6.29.1 ohci_hcd
[    8.833791] usb usb1: SerialNumber: 0001:10:18.0
[    8.839204] usb usb1: configuration #1 chosen from 1 choice
[    8.844651] hub 1-0:1.0: USB hub found
[    8.849818] hub 1-0:1.0: 2 ports detected
[    8.855631] ohci_hcd 0001:10:19.0: enabling device (0000 -> 0002)
[    8.860728] ohci_hcd 0001:10:19.0: OHCI Host Controller
[    8.866201] ohci_hcd 0001:10:19.0: new USB bus registered, assigned bus number 2
[    8.871370] ohci_hcd 0001:10:19.0: irq 28, io mem 0x80080000
[    8.952979] usb usb2: New USB device found, idVendor=1d6b, idProduct=0001
[    8.958167] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    8.963302] usb usb2: Product: OHCI Host Controller
[    8.968373] usb usb2: Manufacturer: Linux 2.6.29.1 ohci_hcd
[    8.973466] usb usb2: SerialNumber: 0001:10:19.0
[    8.978741] usb usb2: configuration #1 chosen from 1 choice
[    8.983949] hub 2-0:1.0: USB hub found
[    8.988932] hub 2-0:1.0: 2 ports detected
[    9.023263] mice: PS/2 mouse device common for all mice
[    9.028782] platform ppc-rtc.0: rtc core: registered ppc_md as rtc0
[    9.033820] i2c /dev entries driver
[    9.039499] PowerMac i2c bus pmu 2 registered
[    9.044819] PowerMac i2c bus pmu 1 registered
[    9.049994] PowerMac i2c bus mac-io 0 registered
[    9.055135] PowerMac i2c bus uni-n 1 registered
[    9.060212] PowerMac i2c bus uni-n 0 registered
[    9.067982] usbcore: registered new interface driver hiddev
[    9.072801] usbcore: registered new interface driver usbhid
[    9.077273] usbhid: v2.6:USB HID core driver
[    9.083311] TCP cubic registered
[    9.087692] NET: Registered protocol family 17
[    9.092613] registered taskstats version 1
[    9.097506] input: PMU as /class/input/input1
[    9.123368] platform ppc-rtc.0: setting system clock to 2009-04-25 10:52:27 UTC (1240656747)
[    9.127841] Freeing unused kernel memory: 244k init
[    9.220748] usb 1-1: new full speed USB device using ohci_hcd and address 2
[    9.419176] usb 1-1: New USB device found, idVendor=05e3, idProduct=0608
[    9.424082] usb 1-1: New USB device strings: Mfr=0, Product=1, SerialNumber=0
[    9.428935] usb 1-1: Product: USB2.0 Hub
[    9.437235] usb 1-1: configuration #1 chosen from 1 choice
[    9.453543] hub 1-1:1.0: USB hub found
[    9.459166] hub 1-1:1.0: 4 ports detected
[    9.616387] usb 2-1: new low speed USB device using ohci_hcd and address 2
[    9.807168] usb 2-1: New USB device found, idVendor=0458, idProduct=002e
[    9.812506] usb 2-1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    9.817377] usb 2-1: Product: NetScroll+ Traveler
[    9.822118] usb 2-1: Manufacturer: KYE
[    9.827626] usb 2-1: configuration #1 chosen from 1 choice
[    9.848151] input: KYE NetScroll+ Traveler as /class/input/input2
[    9.863477] generic-usb 0003:0458:002E.0001: input,hidraw0: USB HID v1.10 Mouse [KYE NetScroll+ Traveler] on usb-0001:10:19.0-1/input0
[    9.954181] usb 1-1.1: new full speed USB device using ohci_hcd and address 3
[   10.072165] usb 1-1.1: New USB device found, idVendor=05e3, idProduct=0608
[   10.077496] usb 1-1.1: New USB device strings: Mfr=0, Product=1, SerialNumber=0
[   10.082693] usb 1-1.1: Product: USB2.0 Hub
[   10.088135] usb 1-1.1: configuration #1 chosen from 1 choice
[   10.094266] hub 1-1.1:1.0: USB hub found
[   10.100147] hub 1-1.1:1.0: 4 ports detected
[   10.332136] ohci1394 0002:20:0e.0: enabling device (0000 -> 0002)
[   10.395221] ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[40]  MMIO=[f5000000-f50007ff]  Max Packet=[2048]  IR/IT contexts=[8/8]
[   10.424174] usb 1-1.1.1: new low speed USB device using ohci_hcd and address 4
[   10.517894] device-mapper: uevent: version 1.0.3
[   10.523833] device-mapper: ioctl: 4.14.0-ioctl (2008-04-23) initialised: dm-devel@redhat.com
[   10.565152] usb 1-1.1.1: New USB device found, idVendor=04d9, idProduct=0022
[   10.571177] usb 1-1.1.1: New USB device strings: Mfr=0, Product=2, SerialNumber=0
[   10.577067] usb 1-1.1.1: Product: USB Keyboard
[   10.583116] usb 1-1.1.1: configuration #1 chosen from 1 choice
[   10.601254] input: USB Keyboard as /class/input/input3
[   10.633378] generic-usb 0003:04D9:0022.0002: input,hidraw1: USB HID v1.10 Keyboard [USB Keyboard] on usb-0001:10:18.0-1.1.1/input0
[   10.659245] input: USB Keyboard as /class/input/input4
[   10.693380] generic-usb 0003:04D9:0022.0003: input,hidraw2: USB HID v1.10 Device [USB Keyboard] on usb-0001:10:18.0-1.1.1/input1
[   11.731155] ieee1394: Host added: ID:BUS[0-00:1023]  GUID[000393fffeabd1a6]
[   33.910781] EXT3-fs: mounted filesystem with ordered data mode.
[   33.918391] kjournald starting.  Commit interval 5 seconds
[   36.863022] udev: starting version 141
[   36.869681] udev: deprecated sysfs layout; update the kernel or disable CONFIG_SYSFS_DEPRECATED; some udev features will not work correctly
[   41.743289] EXT3 FS on dm-1, internal journal
[   42.482813] apm_emu: PMU APM Emulation initialized.
[   42.683739] SCSI subsystem initialized
[   42.763506] DS1775 digital thermometer [@49]
[   42.770187] Temp: 37.0 C  Hyst: 75.0 C  OS: 80.0 C
[   42.777827] ADM1030 fan controller [@2c]
[   42.797649] Reducing overheating limit to 65.0 C (Hyst: 60.0 C)
[   43.623305] input: PowerMac Beep as /class/input/input5
[   47.192868] kjournald starting.  Commit interval 5 seconds
[   47.203245] EXT3 FS on dm-3, internal journal
[   47.209140] EXT3-fs: mounted filesystem with ordered data mode.
[   47.260925] ReiserFS: dm-4: found reiserfs format "3.6" with standard journal
[   47.266968] ReiserFS: dm-4: using ordered data mode
[   47.290135] ReiserFS: dm-4: journal params: device dm-4, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
[   47.298990] ReiserFS: dm-4: checking transaction log (dm-4)
[   47.351082] ReiserFS: dm-4: Using r5 hash to sort names
[   47.492260] Adding 1048568k swap on /dev/mapper/power--group-swap_1.  Priority:-1 extents:1 across:1048568k 
[   49.109465] eth0: Link is up at 100 Mbps, full-duplex.
[   49.109632] eth0: Pause is enabled (rxfifo: 10240 off: 7168 on: 5632)
[   50.811788] CPU-temp: 38.0 C, Case: 28.7 C,  Fan: 0 (tuned -11)
[   54.975189] NET: Registered protocol family 10
[   54.983843] lo: Disabled Privacy Extensions
[   64.458361] Process Xorg (pid:2909) mapped non-existing PCI legacy memory for 00000:00
[   65.650611] eth0: no IPv6 routers present

power-debian:~# cat /proc/interrupts 
           CPU0       CPU1       
 19:          0          0   MPIC 1    Level     ide1
 20:      13972      41224   MPIC 1    Level     ide2
 25:        220        186   MPIC 1    Level     VIA-PMU
 26:        191          0   MPIC 1    Level     keywest i2c
 27:       1462       4469   MPIC 1    Level     ohci_hcd:usb1
 28:       9696      28131   MPIC 1    Level     ohci_hcd:usb2
 30:          0          0   MPIC 1    Edge      PMac Output
 31:          0          0   MPIC 1    Edge      PMac Input
 39:       3997      11882   MPIC 1    Level     ide0
 40:          1          1   MPIC 1    Level     ohci1394
 41:       2173       6416   MPIC 1    Level     eth0
 42:      16247          0   MPIC 1    Level     keywest i2c
 47:          0          0   MPIC 1    Level     GPIO1 ADB
 55:          0          0   MPIC 1    Edge      NMI - XMON
 60:          0          0   MPIC 1    Edge      Sound Lineout Detection
 61:          0          0   MPIC 1    Edge      Sound Headphone Detection
251:          0          0   MPIC 1    Edge      ipi call function
252:      99429      77932   MPIC 1    Edge      ipi reschedule
253:         58         44   MPIC 1    Edge      ipi call function single
254:          0          0   MPIC 1    Edge      ipi debugger
BAD:       4731


power-debian:/proc# cat iomem 
80000000-8fffffff : /pci@f2000000
  80000000-8007ffff : 0001:10:17.0
    80000000-8007ffff : 0.80000000:mac-io
      80000050-8000007f : 0.00000050:gpio
      80008000-800080ff : 0.00010000:i2s
        80008000-800080ff : Sound Tx DMA
      80008100-800081ff : 0.00010000:i2s
        80008100-800081ff : Sound Rx DMA
      80008200-800082ff : 0.00010000:i2s
      80008300-800083ff : 0.00010000:i2s
      80008a00-80008aff : 0.0001f000:ata-4
        80008a00-80008aff : ide-pmac (dma)
      80008b00-80008bff : 0.00020000:ata-3
        80008b00-80008bff : ide-pmac (dma)
      80010000-80010fff : 0.00010000:i2s
        80010000-80010fff : Sound Control
      80013000-80013000 : 0.00013000:ch-b
        80013000-80013000 : pmac_zilog
      80013010-80013010 : 0.00013000:ch-b
        80013010-80013010 : pmac_zilog
      80013020-80013020 : 0.00013020:ch-a
        80013020-80013020 : pmac_zilog
      80013030-80013030 : 0.00013020:ch-a
        80013030-80013030 : pmac_zilog
      80013040-80013040 : 0.00013000:ch-b
        80013040-80013040 : pmac_zilog
      80013050-80013050 : 0.00013020:ch-a
        80013050-80013050 : pmac_zilog
      80015000-80015fff : 0.00015000:timer
      80016000-80017fff : 0.00016000:via-pmu
      80018000-80018fff : 0.00018000:i2c
      8001f000-8001ffff : 0.0001f000:ata-4
        8001f000-8001ffff : ide-pmac (ports)
      80020000-80020fff : 0.00020000:ata-3
        80020000-80020fff : ide-pmac (ports)
      80040000-8007ffff : 0.00040000:interrup
  80080000-80080fff : 0001:10:19.0
    80080000-80080fff : ohci_hcd
  80081000-80081fff : 0001:10:18.0
    80081000-80081fff : ohci_hcd
90000000-afffffff : /pci@f0000000
  91000000-91ffffff : 0000:00:10.0
  98000000-9fffffff : 0000:00:10.0
    98004000-9827ccff : offb
    99000000-9908c9ff : offb
f1000000-f1ffffff : /pci@f0000000
  f1000000-f107ffff : 0000:00:10.0
  f1080000-f109ffff : 0000:00:10.0
f3000000-f3ffffff : /pci@f2000000
f5000000-f5ffffff : /pci@f4000000
  f5000000-f5000fff : 0002:20:0e.0
    f5000000-f50007ff : ohci1394
  f5004000-f5007fff : 0002:20:0d.0
    f5004000-f5007fff : Kauai ATA
  f5100000-f51fffff : 0002:20:0f.0
  f5200000-f53fffff : 0002:20:0f.0
    f5200000-f53fffff : sungem

config:
#
# Automatically generated make config: don't edit
# Linux kernel version: 2.6.30-rc3
# Sat Apr 25 10:35:58 2009
#
# CONFIG_PPC64 is not set

#
# Processor support
#
CONFIG_6xx=y
# CONFIG_PPC_85xx is not set
# CONFIG_PPC_8xx is not set
# CONFIG_40x is not set
# CONFIG_44x is not set
# CONFIG_E200 is not set
CONFIG_PPC_BOOK3S=y
CONFIG_PPC_FPU=y
CONFIG_ALTIVEC=y
CONFIG_PPC_STD_MMU=y
CONFIG_PPC_STD_MMU_32=y
# CONFIG_PPC_MM_SLICES is not set
CONFIG_SMP=y
CONFIG_NR_CPUS=4
CONFIG_PPC32=y
CONFIG_WORD_SIZE=32
# CONFIG_ARCH_PHYS_ADDR_T_64BIT is not set
CONFIG_MMU=y
CONFIG_GENERIC_CMOS_UPDATE=y
CONFIG_GENERIC_TIME=y
CONFIG_GENERIC_TIME_VSYSCALL=y
CONFIG_GENERIC_CLOCKEVENTS=y
CONFIG_GENERIC_HARDIRQS=y
# CONFIG_HAVE_SETUP_PER_CPU_AREA is not set
CONFIG_IRQ_PER_CPU=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_HAVE_LATENCYTOP_SUPPORT=y
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_GENERIC_LOCKBREAK=y
CONFIG_ARCH_HAS_ILOG2_U32=y
CONFIG_GENERIC_HWEIGHT=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_GENERIC_FIND_NEXT_BIT=y
# CONFIG_ARCH_NO_VIRT_TO_BUS is not set
CONFIG_PPC=y
CONFIG_EARLY_PRINTK=y
CONFIG_GENERIC_NVRAM=y
CONFIG_SCHED_OMIT_FRAME_POINTER=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_PPC_OF=y
CONFIG_OF=y
CONFIG_PPC_UDBG_16550=y
CONFIG_GENERIC_TBSYNC=y
CONFIG_AUDIT_ARCH=y
CONFIG_GENERIC_BUG=y
CONFIG_SYS_SUPPORTS_APM_EMULATION=y
# CONFIG_DEFAULT_UIMAGE is not set
CONFIG_ARCH_SUSPEND_POSSIBLE=y
# CONFIG_PPC_DCR_NATIVE is not set
# CONFIG_PPC_DCR_MMIO is not set
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"

#
# General setup
#
CONFIG_EXPERIMENTAL=y
CONFIG_LOCK_KERNEL=y
CONFIG_INIT_ENV_ARG_LIMIT=32
CONFIG_LOCALVERSION=""
# CONFIG_LOCALVERSION_AUTO is not set
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_SYSVIPC_SYSCTL=y
CONFIG_POSIX_MQUEUE=y
CONFIG_POSIX_MQUEUE_SYSCTL=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_BSD_PROCESS_ACCT_V3=y
CONFIG_TASKSTATS=y
CONFIG_TASK_DELAY_ACCT=y
CONFIG_TASK_XACCT=y
CONFIG_TASK_IO_ACCOUNTING=y
CONFIG_AUDIT=y
CONFIG_AUDITSYSCALL=y
CONFIG_AUDIT_TREE=y

#
# RCU Subsystem
#
# CONFIG_CLASSIC_RCU is not set
CONFIG_TREE_RCU=y
# CONFIG_PREEMPT_RCU is not set
# CONFIG_RCU_TRACE is not set
CONFIG_RCU_FANOUT=32
# CONFIG_RCU_FANOUT_EXACT is not set
# CONFIG_TREE_RCU_TRACE is not set
# CONFIG_PREEMPT_RCU_TRACE is not set
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
CONFIG_LOG_BUF_SHIFT=17
CONFIG_GROUP_SCHED=y
CONFIG_FAIR_GROUP_SCHED=y
# CONFIG_RT_GROUP_SCHED is not set
# CONFIG_USER_SCHED is not set
CONFIG_CGROUP_SCHED=y
CONFIG_CGROUPS=y
# CONFIG_CGROUP_DEBUG is not set
CONFIG_CGROUP_NS=y
CONFIG_CGROUP_FREEZER=y
CONFIG_CGROUP_DEVICE=y
CONFIG_CPUSETS=y
CONFIG_PROC_PID_CPUSET=y
CONFIG_CGROUP_CPUACCT=y
# CONFIG_RESOURCE_COUNTERS is not set
CONFIG_SYSFS_DEPRECATED=y
CONFIG_SYSFS_DEPRECATED_V2=y
CONFIG_RELAY=y
CONFIG_NAMESPACES=y
CONFIG_UTS_NS=y
CONFIG_IPC_NS=y
# CONFIG_USER_NS is not set
# CONFIG_PID_NS is not set
# CONFIG_NET_NS is not set
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
CONFIG_RD_BZIP2=y
CONFIG_RD_LZMA=y
CONFIG_CC_OPTIMIZE_FOR_SIZE=y
CONFIG_SYSCTL=y
CONFIG_ANON_INODES=y
# CONFIG_EMBEDDED is not set
CONFIG_SYSCTL_SYSCALL=y
CONFIG_KALLSYMS=y
# CONFIG_KALLSYMS_ALL is not set
# CONFIG_KALLSYMS_EXTRA_PASS is not set
# CONFIG_STRIP_ASM_SYMS is not set
CONFIG_HOTPLUG=y
CONFIG_PRINTK=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
CONFIG_PCSPKR_PLATFORM=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
CONFIG_EVENTFD=y
CONFIG_SHMEM=y
CONFIG_AIO=y
CONFIG_VM_EVENT_COUNTERS=y
CONFIG_PCI_QUIRKS=y
CONFIG_SLUB_DEBUG=y
# CONFIG_COMPAT_BRK is not set
# CONFIG_SLAB is not set
CONFIG_SLUB=y
# CONFIG_SLOB is not set
CONFIG_PROFILING=y
CONFIG_TRACEPOINTS=y
# CONFIG_MARKERS is not set
CONFIG_OPROFILE=m
CONFIG_HAVE_OPROFILE=y
# CONFIG_KPROBES is not set
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
CONFIG_HAVE_IOREMAP_PROT=y
CONFIG_HAVE_KPROBES=y
CONFIG_HAVE_KRETPROBES=y
CONFIG_HAVE_ARCH_TRACEHOOK=y
CONFIG_USE_GENERIC_SMP_HELPERS=y
# CONFIG_SLOW_WORK is not set
# CONFIG_HAVE_GENERIC_DMA_COHERENT is not set
CONFIG_SLABINFO=y
CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
CONFIG_MODULES=y
CONFIG_MODULE_FORCE_LOAD=y
CONFIG_MODULE_UNLOAD=y
CONFIG_MODULE_FORCE_UNLOAD=y
CONFIG_MODVERSIONS=y
# CONFIG_MODULE_SRCVERSION_ALL is not set
CONFIG_STOP_MACHINE=y
CONFIG_BLOCK=y
# CONFIG_LBD is not set
CONFIG_BLK_DEV_BSG=y
# CONFIG_BLK_DEV_INTEGRITY is not set

#
# IO Schedulers
#
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_AS=y
CONFIG_IOSCHED_DEADLINE=y
CONFIG_IOSCHED_CFQ=y
# CONFIG_DEFAULT_AS is not set
# CONFIG_DEFAULT_DEADLINE is not set
CONFIG_DEFAULT_CFQ=y
# CONFIG_DEFAULT_NOOP is not set
CONFIG_DEFAULT_IOSCHED="cfq"
CONFIG_FREEZER=y

#
# Platform support
#
CONFIG_PPC_CHRP=y
# CONFIG_MPC5121_ADS is not set
# CONFIG_MPC5121_GENERIC is not set
# CONFIG_PPC_MPC52xx is not set
CONFIG_PPC_PMAC=y
# CONFIG_PPC_CELL is not set
# CONFIG_PPC_CELL_NATIVE is not set
# CONFIG_PPC_82xx is not set
# CONFIG_PQ2ADS is not set
# CONFIG_PPC_83xx is not set
# CONFIG_PPC_86xx is not set
CONFIG_PPC_NATIVE=y
CONFIG_PPC_OF_BOOT_TRAMPOLINE=y
# CONFIG_UDBG_RTAS_CONSOLE is not set
# CONFIG_IPIC is not set
CONFIG_MPIC=y
# CONFIG_MPIC_WEIRD is not set
CONFIG_PPC_I8259=y
CONFIG_PPC_RTAS=y
# CONFIG_RTAS_ERROR_LOGGING is not set
CONFIG_RTAS_PROC=y
# CONFIG_MMIO_NVRAM is not set
CONFIG_PPC_MPC106=y
# CONFIG_PPC_970_NAP is not set
# CONFIG_PPC_INDIRECT_IO is not set
# CONFIG_GENERIC_IOMAP is not set
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_TABLE=m
# CONFIG_CPU_FREQ_DEBUG is not set
CONFIG_CPU_FREQ_STAT=m
CONFIG_CPU_FREQ_STAT_DETAILS=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND is not set
CONFIG_CPU_FREQ_DEFAULT_GOV_CONSERVATIVE=y
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_POWERSAVE=m
CONFIG_CPU_FREQ_GOV_USERSPACE=m
CONFIG_CPU_FREQ_GOV_ONDEMAND=m
CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y

#
# CPU Frequency drivers
#
# CONFIG_CPU_FREQ_PMAC is not set
# CONFIG_PPC601_SYNC_FIX is not set
CONFIG_TAU=y
# CONFIG_TAU_INT is not set
# CONFIG_TAU_AVERAGE is not set
# CONFIG_FSL_ULI1575 is not set
# CONFIG_SIMPLE_GPIO is not set

#
# Kernel options
#
CONFIG_HIGHMEM=y
CONFIG_TICK_ONESHOT=y
CONFIG_NO_HZ=y
CONFIG_HIGH_RES_TIMERS=y
CONFIG_GENERIC_CLOCKEVENTS_BUILD=y
CONFIG_HZ_100=y
# CONFIG_HZ_250 is not set
# CONFIG_HZ_300 is not set
# CONFIG_HZ_1000 is not set
CONFIG_HZ=100
CONFIG_SCHED_HRTICK=y
# CONFIG_PREEMPT_NONE is not set
# CONFIG_PREEMPT_VOLUNTARY is not set
CONFIG_PREEMPT=y
CONFIG_BINFMT_ELF=y
CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=y
# CONFIG_HAVE_AOUT is not set
CONFIG_BINFMT_MISC=m
# CONFIG_IOMMU_HELPER is not set
CONFIG_HOTPLUG_CPU=y
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
CONFIG_ARCH_HAS_WALK_MEMORY=y
CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=y
# CONFIG_KEXEC is not set
# CONFIG_CRASH_DUMP is not set
# CONFIG_IRQ_ALL_CPUS is not set
CONFIG_ARCH_FLATMEM_ENABLE=y
CONFIG_ARCH_POPULATES_NODE_MAP=y
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_FLATMEM_MANUAL=y
# CONFIG_DISCONTIGMEM_MANUAL is not set
# CONFIG_SPARSEMEM_MANUAL is not set
CONFIG_FLATMEM=y
CONFIG_FLAT_NODE_MEM_MAP=y
CONFIG_PAGEFLAGS_EXTENDED=y
CONFIG_SPLIT_PTLOCK_CPUS=4
# CONFIG_MIGRATION is not set
# CONFIG_PHYS_ADDR_T_64BIT is not set
CONFIG_ZONE_DMA_FLAG=1
CONFIG_BOUNCE=y
CONFIG_VIRT_TO_BUS=y
# CONFIG_UNEVICTABLE_LRU is not set
CONFIG_HAVE_MLOCK=y
CONFIG_PPC_4K_PAGES=y
# CONFIG_PPC_16K_PAGES is not set
# CONFIG_PPC_64K_PAGES is not set
# CONFIG_PPC_256K_PAGES is not set
CONFIG_FORCE_MAX_ZONEORDER=11
CONFIG_PROC_DEVICETREE=y
CONFIG_CMDLINE_BOOL=y
CONFIG_CMDLINE="console=ttyS0,9600 console=tty0"
CONFIG_EXTRA_TARGETS=""
CONFIG_ARCH_WANTS_FREEZER_CONTROL=y
CONFIG_PM=y
# CONFIG_PM_DEBUG is not set
CONFIG_PM_SLEEP_SMP=y
CONFIG_PM_SLEEP=y
CONFIG_SUSPEND=y
CONFIG_SUSPEND_FREEZER=y
CONFIG_APM_EMULATION=m
CONFIG_SECCOMP=y
CONFIG_ISA_DMA_API=y

#
# Bus options
#
# CONFIG_ISA is not set
CONFIG_ZONE_DMA=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_PPC_INDIRECT_PCI=y
CONFIG_PCI=y
CONFIG_PCI_DOMAINS=y
CONFIG_PCI_SYSCALL=y
# CONFIG_PCIEPORTBUS is not set
CONFIG_ARCH_SUPPORTS_MSI=y
# CONFIG_PCI_MSI is not set
CONFIG_PCI_LEGACY=y
# CONFIG_PCI_DEBUG is not set
# CONFIG_PCI_STUB is not set
# CONFIG_PCI_IOV is not set
# CONFIG_PCCARD is not set
# CONFIG_HOTPLUG_PCI is not set
# CONFIG_HAS_RAPIDIO is not set

#
# Advanced setup
#
# CONFIG_ADVANCED_OPTIONS is not set

#
# Default settings for advanced configuration options are used
#
CONFIG_LOWMEM_SIZE=0x30000000
CONFIG_PAGE_OFFSET=0xc0000000
CONFIG_KERNEL_START=0xc0000000
CONFIG_PHYSICAL_START=0x00000000
CONFIG_TASK_SIZE=0xc0000000
CONFIG_NET=y

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_MMAP=y
CONFIG_UNIX=y
CONFIG_XFRM=y
CONFIG_XFRM_USER=m
# CONFIG_XFRM_SUB_POLICY is not set
# CONFIG_XFRM_MIGRATE is not set
# CONFIG_XFRM_STATISTICS is not set
CONFIG_XFRM_IPCOMP=m
CONFIG_NET_KEY=m
# CONFIG_NET_KEY_MIGRATE is not set
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_ASK_IP_FIB_HASH=y
# CONFIG_IP_FIB_TRIE is not set
CONFIG_IP_FIB_HASH=y
CONFIG_IP_MULTIPLE_TABLES=y
CONFIG_IP_ROUTE_MULTIPATH=y
CONFIG_IP_ROUTE_VERBOSE=y
# CONFIG_IP_PNP is not set
CONFIG_NET_IPIP=m
CONFIG_NET_IPGRE=m
CONFIG_NET_IPGRE_BROADCAST=y
CONFIG_IP_MROUTE=y
CONFIG_IP_PIMSM_V1=y
CONFIG_IP_PIMSM_V2=y
# CONFIG_ARPD is not set
CONFIG_SYN_COOKIES=y
CONFIG_INET_AH=m
CONFIG_INET_ESP=m
CONFIG_INET_IPCOMP=m
CONFIG_INET_XFRM_TUNNEL=m
CONFIG_INET_TUNNEL=m
CONFIG_INET_XFRM_MODE_TRANSPORT=m
CONFIG_INET_XFRM_MODE_TUNNEL=m
CONFIG_INET_XFRM_MODE_BEET=m
CONFIG_INET_LRO=m
CONFIG_INET_DIAG=m
CONFIG_INET_TCP_DIAG=m
CONFIG_TCP_CONG_ADVANCED=y
CONFIG_TCP_CONG_BIC=m
CONFIG_TCP_CONG_CUBIC=y
CONFIG_TCP_CONG_WESTWOOD=m
CONFIG_TCP_CONG_HTCP=m
CONFIG_TCP_CONG_HSTCP=m
CONFIG_TCP_CONG_HYBLA=m
CONFIG_TCP_CONG_VEGAS=m
CONFIG_TCP_CONG_SCALABLE=m
CONFIG_TCP_CONG_LP=m
CONFIG_TCP_CONG_VENO=m
CONFIG_TCP_CONG_YEAH=m
CONFIG_TCP_CONG_ILLINOIS=m
# CONFIG_DEFAULT_BIC is not set
CONFIG_DEFAULT_CUBIC=y
# CONFIG_DEFAULT_HTCP is not set
# CONFIG_DEFAULT_VEGAS is not set
# CONFIG_DEFAULT_WESTWOOD is not set
# CONFIG_DEFAULT_RENO is not set
CONFIG_DEFAULT_TCP_CONG="cubic"
CONFIG_TCP_MD5SIG=y
CONFIG_IPV6=m
CONFIG_IPV6_PRIVACY=y
CONFIG_IPV6_ROUTER_PREF=y
CONFIG_IPV6_ROUTE_INFO=y
CONFIG_IPV6_OPTIMISTIC_DAD=y
CONFIG_INET6_AH=m
CONFIG_INET6_ESP=m
CONFIG_INET6_IPCOMP=m
CONFIG_IPV6_MIP6=m
CONFIG_INET6_XFRM_TUNNEL=m
CONFIG_INET6_TUNNEL=m
CONFIG_INET6_XFRM_MODE_TRANSPORT=m
CONFIG_INET6_XFRM_MODE_TUNNEL=m
CONFIG_INET6_XFRM_MODE_BEET=m
CONFIG_INET6_XFRM_MODE_ROUTEOPTIMIZATION=m
CONFIG_IPV6_SIT=m
CONFIG_IPV6_NDISC_NODETYPE=y
CONFIG_IPV6_TUNNEL=m
CONFIG_IPV6_MULTIPLE_TABLES=y
CONFIG_IPV6_SUBTREES=y
CONFIG_IPV6_MROUTE=y
CONFIG_IPV6_PIMSM_V2=y
# CONFIG_NETLABEL is not set
CONFIG_NETWORK_SECMARK=y
CONFIG_NETFILTER=y
# CONFIG_NETFILTER_DEBUG is not set
CONFIG_NETFILTER_ADVANCED=y

#
# Core Netfilter Configuration
#
CONFIG_NETFILTER_NETLINK=m
CONFIG_NETFILTER_NETLINK_QUEUE=m
CONFIG_NETFILTER_NETLINK_LOG=m
CONFIG_NF_CONNTRACK=m
CONFIG_NF_CT_ACCT=y
CONFIG_NF_CONNTRACK_MARK=y
CONFIG_NF_CONNTRACK_SECMARK=y
CONFIG_NF_CONNTRACK_EVENTS=y
CONFIG_NF_CT_PROTO_DCCP=m
CONFIG_NF_CT_PROTO_GRE=m
CONFIG_NF_CT_PROTO_SCTP=m
CONFIG_NF_CT_PROTO_UDPLITE=m
CONFIG_NF_CONNTRACK_AMANDA=m
CONFIG_NF_CONNTRACK_FTP=m
CONFIG_NF_CONNTRACK_H323=m
CONFIG_NF_CONNTRACK_IRC=m
CONFIG_NF_CONNTRACK_NETBIOS_NS=m
CONFIG_NF_CONNTRACK_PPTP=m
CONFIG_NF_CONNTRACK_SANE=m
CONFIG_NF_CONNTRACK_SIP=m
CONFIG_NF_CONNTRACK_TFTP=m
CONFIG_NF_CT_NETLINK=m
# CONFIG_NETFILTER_TPROXY is not set
CONFIG_NETFILTER_XTABLES=m
CONFIG_NETFILTER_XT_TARGET_CLASSIFY=m
CONFIG_NETFILTER_XT_TARGET_CONNMARK=m
CONFIG_NETFILTER_XT_TARGET_CONNSECMARK=m
CONFIG_NETFILTER_XT_TARGET_DSCP=m
CONFIG_NETFILTER_XT_TARGET_HL=m
# CONFIG_NETFILTER_XT_TARGET_LED is not set
CONFIG_NETFILTER_XT_TARGET_MARK=m
CONFIG_NETFILTER_XT_TARGET_NFLOG=m
CONFIG_NETFILTER_XT_TARGET_NFQUEUE=m
CONFIG_NETFILTER_XT_TARGET_NOTRACK=m
CONFIG_NETFILTER_XT_TARGET_RATEEST=m
CONFIG_NETFILTER_XT_TARGET_TRACE=m
CONFIG_NETFILTER_XT_TARGET_SECMARK=m
CONFIG_NETFILTER_XT_TARGET_TCPMSS=m
CONFIG_NETFILTER_XT_TARGET_TCPOPTSTRIP=m
# CONFIG_NETFILTER_XT_MATCH_CLUSTER is not set
CONFIG_NETFILTER_XT_MATCH_COMMENT=m
CONFIG_NETFILTER_XT_MATCH_CONNBYTES=m
CONFIG_NETFILTER_XT_MATCH_CONNLIMIT=m
CONFIG_NETFILTER_XT_MATCH_CONNMARK=m
CONFIG_NETFILTER_XT_MATCH_CONNTRACK=m
CONFIG_NETFILTER_XT_MATCH_DCCP=m
CONFIG_NETFILTER_XT_MATCH_DSCP=m
CONFIG_NETFILTER_XT_MATCH_ESP=m
CONFIG_NETFILTER_XT_MATCH_HASHLIMIT=m
CONFIG_NETFILTER_XT_MATCH_HELPER=m
CONFIG_NETFILTER_XT_MATCH_HL=m
CONFIG_NETFILTER_XT_MATCH_IPRANGE=m
CONFIG_NETFILTER_XT_MATCH_LENGTH=m
CONFIG_NETFILTER_XT_MATCH_LIMIT=m
CONFIG_NETFILTER_XT_MATCH_MAC=m
CONFIG_NETFILTER_XT_MATCH_MARK=m
CONFIG_NETFILTER_XT_MATCH_MULTIPORT=m
CONFIG_NETFILTER_XT_MATCH_OWNER=m
CONFIG_NETFILTER_XT_MATCH_POLICY=m
CONFIG_NETFILTER_XT_MATCH_PKTTYPE=m
CONFIG_NETFILTER_XT_MATCH_QUOTA=m
CONFIG_NETFILTER_XT_MATCH_RATEEST=m
CONFIG_NETFILTER_XT_MATCH_REALM=m
# CONFIG_NETFILTER_XT_MATCH_RECENT is not set
CONFIG_NETFILTER_XT_MATCH_SCTP=m
CONFIG_NETFILTER_XT_MATCH_STATE=m
CONFIG_NETFILTER_XT_MATCH_STATISTIC=m
CONFIG_NETFILTER_XT_MATCH_STRING=m
CONFIG_NETFILTER_XT_MATCH_TCPMSS=m
CONFIG_NETFILTER_XT_MATCH_TIME=m
CONFIG_NETFILTER_XT_MATCH_U32=m
CONFIG_IP_VS=m
# CONFIG_IP_VS_IPV6 is not set
# CONFIG_IP_VS_DEBUG is not set
CONFIG_IP_VS_TAB_BITS=12

#
# IPVS transport protocol load balancing support
#
CONFIG_IP_VS_PROTO_TCP=y
CONFIG_IP_VS_PROTO_UDP=y
CONFIG_IP_VS_PROTO_AH_ESP=y
CONFIG_IP_VS_PROTO_ESP=y
CONFIG_IP_VS_PROTO_AH=y

#
# IPVS scheduler
#
CONFIG_IP_VS_RR=m
CONFIG_IP_VS_WRR=m
CONFIG_IP_VS_LC=m
CONFIG_IP_VS_WLC=m
CONFIG_IP_VS_LBLC=m
CONFIG_IP_VS_LBLCR=m
CONFIG_IP_VS_DH=m
CONFIG_IP_VS_SH=m
CONFIG_IP_VS_SED=m
CONFIG_IP_VS_NQ=m

#
# IPVS application helper
#
CONFIG_IP_VS_FTP=m

#
# IP: Netfilter Configuration
#
CONFIG_NF_DEFRAG_IPV4=m
CONFIG_NF_CONNTRACK_IPV4=m
CONFIG_NF_CONNTRACK_PROC_COMPAT=y
CONFIG_IP_NF_QUEUE=m
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_ADDRTYPE=m
CONFIG_IP_NF_MATCH_AH=m
CONFIG_IP_NF_MATCH_ECN=m
CONFIG_IP_NF_MATCH_TTL=m
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_TARGET_LOG=m
CONFIG_IP_NF_TARGET_ULOG=m
CONFIG_NF_NAT=m
CONFIG_NF_NAT_NEEDED=y
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_NETMAP=m
CONFIG_IP_NF_TARGET_REDIRECT=m
CONFIG_NF_NAT_SNMP_BASIC=m
CONFIG_NF_NAT_PROTO_DCCP=m
CONFIG_NF_NAT_PROTO_GRE=m
CONFIG_NF_NAT_PROTO_UDPLITE=m
CONFIG_NF_NAT_PROTO_SCTP=m
CONFIG_NF_NAT_FTP=m
CONFIG_NF_NAT_IRC=m
CONFIG_NF_NAT_TFTP=m
CONFIG_NF_NAT_AMANDA=m
CONFIG_NF_NAT_PPTP=m
CONFIG_NF_NAT_H323=m
CONFIG_NF_NAT_SIP=m
CONFIG_IP_NF_MANGLE=m
CONFIG_IP_NF_TARGET_CLUSTERIP=m
CONFIG_IP_NF_TARGET_ECN=m
CONFIG_IP_NF_TARGET_TTL=m
CONFIG_IP_NF_RAW=m
# CONFIG_IP_NF_SECURITY is not set
CONFIG_IP_NF_ARPTABLES=m
CONFIG_IP_NF_ARPFILTER=m
CONFIG_IP_NF_ARP_MANGLE=m

#
# IPv6: Netfilter Configuration
#
CONFIG_NF_CONNTRACK_IPV6=m
CONFIG_IP6_NF_QUEUE=m
CONFIG_IP6_NF_IPTABLES=m
CONFIG_IP6_NF_MATCH_AH=m
CONFIG_IP6_NF_MATCH_EUI64=m
CONFIG_IP6_NF_MATCH_FRAG=m
CONFIG_IP6_NF_MATCH_OPTS=m
CONFIG_IP6_NF_MATCH_HL=m
CONFIG_IP6_NF_MATCH_IPV6HEADER=m
CONFIG_IP6_NF_MATCH_MH=m
CONFIG_IP6_NF_MATCH_RT=m
CONFIG_IP6_NF_TARGET_HL=m
CONFIG_IP6_NF_TARGET_LOG=m
CONFIG_IP6_NF_FILTER=m
CONFIG_IP6_NF_TARGET_REJECT=m
CONFIG_IP6_NF_MANGLE=m
CONFIG_IP6_NF_RAW=m
# CONFIG_IP6_NF_SECURITY is not set
CONFIG_IP_DCCP=m
CONFIG_INET_DCCP_DIAG=m

#
# DCCP CCIDs Configuration (EXPERIMENTAL)
#
# CONFIG_IP_DCCP_CCID2_DEBUG is not set
# CONFIG_IP_DCCP_CCID3 is not set

#
# DCCP Kernel Hacking
#
# CONFIG_IP_DCCP_DEBUG is not set
CONFIG_IP_SCTP=m
# CONFIG_SCTP_DBG_MSG is not set
# CONFIG_SCTP_DBG_OBJCNT is not set
# CONFIG_SCTP_HMAC_NONE is not set
# CONFIG_SCTP_HMAC_SHA1 is not set
CONFIG_SCTP_HMAC_MD5=y
CONFIG_TIPC=m
CONFIG_TIPC_ADVANCED=y
CONFIG_TIPC_ZONES=3
CONFIG_TIPC_CLUSTERS=1
CONFIG_TIPC_NODES=255
CONFIG_TIPC_SLAVE_NODES=0
CONFIG_TIPC_PORTS=8191
CONFIG_TIPC_LOG=0
# CONFIG_TIPC_DEBUG is not set
CONFIG_ATM=m
# CONFIG_ATM_CLIP is not set
# CONFIG_ATM_LANE is not set
# CONFIG_ATM_BR2684 is not set
# CONFIG_BRIDGE is not set
# CONFIG_NET_DSA is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_DECNET is not set
# CONFIG_LLC2 is not set
# CONFIG_IPX is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set
# CONFIG_PHONET is not set
CONFIG_NET_SCHED=y

#
# Queueing/Scheduling
#
CONFIG_NET_SCH_CBQ=m
CONFIG_NET_SCH_HTB=m
CONFIG_NET_SCH_HFSC=m
CONFIG_NET_SCH_ATM=m
CONFIG_NET_SCH_PRIO=m
# CONFIG_NET_SCH_MULTIQ is not set
CONFIG_NET_SCH_RED=m
CONFIG_NET_SCH_SFQ=m
CONFIG_NET_SCH_TEQL=m
CONFIG_NET_SCH_TBF=m
CONFIG_NET_SCH_GRED=m
CONFIG_NET_SCH_DSMARK=m
CONFIG_NET_SCH_NETEM=m
# CONFIG_NET_SCH_DRR is not set
CONFIG_NET_SCH_INGRESS=m

#
# Classification
#
CONFIG_NET_CLS=y
CONFIG_NET_CLS_BASIC=m
CONFIG_NET_CLS_TCINDEX=m
CONFIG_NET_CLS_ROUTE4=m
CONFIG_NET_CLS_ROUTE=y
CONFIG_NET_CLS_FW=m
CONFIG_NET_CLS_U32=m
CONFIG_CLS_U32_PERF=y
CONFIG_CLS_U32_MARK=y
CONFIG_NET_CLS_RSVP=m
CONFIG_NET_CLS_RSVP6=m
CONFIG_NET_CLS_FLOW=m
# CONFIG_NET_CLS_CGROUP is not set
CONFIG_NET_EMATCH=y
CONFIG_NET_EMATCH_STACK=32
CONFIG_NET_EMATCH_CMP=m
CONFIG_NET_EMATCH_NBYTE=m
CONFIG_NET_EMATCH_U32=m
CONFIG_NET_EMATCH_META=m
CONFIG_NET_EMATCH_TEXT=m
CONFIG_NET_CLS_ACT=y
CONFIG_NET_ACT_POLICE=m
CONFIG_NET_ACT_GACT=m
CONFIG_GACT_PROB=y
CONFIG_NET_ACT_MIRRED=m
CONFIG_NET_ACT_IPT=m
CONFIG_NET_ACT_NAT=m
CONFIG_NET_ACT_PEDIT=m
CONFIG_NET_ACT_SIMP=m
# CONFIG_NET_ACT_SKBEDIT is not set
CONFIG_NET_CLS_IND=y
CONFIG_NET_SCH_FIFO=y
# CONFIG_DCB is not set

#
# Network testing
#
CONFIG_NET_PKTGEN=m
# CONFIG_NET_DROP_MONITOR is not set
# CONFIG_HAMRADIO is not set
# CONFIG_CAN is not set
CONFIG_IRDA=m

#
# IrDA protocols
#
CONFIG_IRLAN=m
CONFIG_IRCOMM=m
CONFIG_IRDA_ULTRA=y

#
# IrDA options
#
CONFIG_IRDA_CACHE_LAST_LSAP=y
CONFIG_IRDA_FAST_RR=y
# CONFIG_IRDA_DEBUG is not set

#
# Infrared-port device drivers
#

#
# SIR device drivers
#
CONFIG_IRTTY_SIR=m

#
# Dongle support
#
# CONFIG_DONGLE is not set
CONFIG_KINGSUN_DONGLE=m
CONFIG_KSDAZZLE_DONGLE=m
CONFIG_KS959_DONGLE=m

#
# FIR device drivers
#
CONFIG_USB_IRDA=m
# CONFIG_SIGMATEL_FIR is not set
CONFIG_NSC_FIR=m
CONFIG_WINBOND_FIR=m
# CONFIG_TOSHIBA_FIR is not set
CONFIG_SMC_IRCC_FIR=m
CONFIG_ALI_FIR=m
# CONFIG_VLSI_FIR is not set
CONFIG_VIA_FIR=m
CONFIG_MCS_FIR=m
# CONFIG_BT is not set
CONFIG_AF_RXRPC=m
# CONFIG_AF_RXRPC_DEBUG is not set
# CONFIG_RXKAD is not set
CONFIG_FIB_RULES=y
# CONFIG_WIRELESS is not set
CONFIG_WIRELESS_EXT=y
CONFIG_LIB80211=m
CONFIG_LIB80211_CRYPT_WEP=m
CONFIG_LIB80211_CRYPT_CCMP=m
CONFIG_LIB80211_CRYPT_TKIP=m
# CONFIG_WIMAX is not set
# CONFIG_RFKILL is not set
# CONFIG_NET_9P is not set

#
# Device Drivers
#

#
# Generic Driver Options
#
CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y
CONFIG_FW_LOADER=y
# CONFIG_FIRMWARE_IN_KERNEL is not set
CONFIG_EXTRA_FIRMWARE=""
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
# CONFIG_SYS_HYPERVISOR is not set
CONFIG_CONNECTOR=m
# CONFIG_MTD is not set
CONFIG_OF_DEVICE=y
CONFIG_OF_I2C=y
# CONFIG_PARPORT is not set
CONFIG_BLK_DEV=y
# CONFIG_BLK_DEV_FD is not set
# CONFIG_MAC_FLOPPY is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
# CONFIG_BLK_DEV_COW_COMMON is not set
CONFIG_BLK_DEV_LOOP=y
CONFIG_BLK_DEV_CRYPTOLOOP=m
CONFIG_BLK_DEV_NBD=m
# CONFIG_BLK_DEV_SX8 is not set
# CONFIG_BLK_DEV_UB is not set
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE=8192
# CONFIG_BLK_DEV_XIP is not set
CONFIG_CDROM_PKTCDVD=m
CONFIG_CDROM_PKTCDVD_BUFFERS=8
# CONFIG_CDROM_PKTCDVD_WCACHE is not set
# CONFIG_ATA_OVER_ETH is not set
# CONFIG_BLK_DEV_HD is not set
# CONFIG_MISC_DEVICES is not set
CONFIG_HAVE_IDE=y
CONFIG_IDE=y

#
# Please see Documentation/ide/ide.txt for help/info on IDE drives
#
CONFIG_IDE_XFER_MODE=y
CONFIG_IDE_TIMINGS=y
CONFIG_IDE_ATAPI=y
# CONFIG_BLK_DEV_IDE_SATA is not set
CONFIG_IDE_GD=y
CONFIG_IDE_GD_ATA=y
# CONFIG_IDE_GD_ATAPI is not set
CONFIG_BLK_DEV_IDECD=y
CONFIG_BLK_DEV_IDECD_VERBOSE_ERRORS=y
CONFIG_BLK_DEV_IDETAPE=y
# CONFIG_IDE_TASK_IOCTL is not set
CONFIG_IDE_PROC_FS=y

#
# IDE chipset support/bugfixes
#
# CONFIG_BLK_DEV_PLATFORM is not set
CONFIG_BLK_DEV_IDEDMA_SFF=y

#
# PCI IDE chipsets support
#
CONFIG_BLK_DEV_IDEPCI=y
# CONFIG_IDEPCI_PCIBUS_ORDER is not set
# CONFIG_BLK_DEV_OFFBOARD is not set
CONFIG_BLK_DEV_GENERIC=y
# CONFIG_BLK_DEV_OPTI621 is not set
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_TRIFLEX is not set
# CONFIG_BLK_DEV_CS5520 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_HPT366 is not set
# CONFIG_BLK_DEV_JMICRON is not set
# CONFIG_BLK_DEV_SC1200 is not set
# CONFIG_BLK_DEV_PIIX is not set
# CONFIG_BLK_DEV_IT8172 is not set
# CONFIG_BLK_DEV_IT8213 is not set
# CONFIG_BLK_DEV_IT821X is not set
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_PDC202XX_OLD is not set
# CONFIG_BLK_DEV_PDC202XX_NEW is not set
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SIIMAGE is not set
# CONFIG_BLK_DEV_SL82C105 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
# CONFIG_BLK_DEV_VIA82CXXX is not set
# CONFIG_BLK_DEV_TC86C001 is not set
CONFIG_BLK_DEV_IDE_PMAC=y
CONFIG_BLK_DEV_IDE_PMAC_ATA100FIRST=y
CONFIG_BLK_DEV_IDEDMA=y

#
# SCSI device support
#
CONFIG_RAID_ATTRS=m
CONFIG_SCSI=m
CONFIG_SCSI_DMA=y
CONFIG_SCSI_TGT=m
CONFIG_SCSI_NETLINK=y
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=m
CONFIG_CHR_DEV_ST=m
CONFIG_CHR_DEV_OSST=m
CONFIG_BLK_DEV_SR=m
CONFIG_BLK_DEV_SR_VENDOR=y
CONFIG_CHR_DEV_SG=m
CONFIG_CHR_DEV_SCH=m

#
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
#
CONFIG_SCSI_MULTI_LUN=y
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_LOGGING=y
CONFIG_SCSI_SCAN_ASYNC=y
CONFIG_SCSI_WAIT_SCAN=m

#
# SCSI Transports
#
CONFIG_SCSI_SPI_ATTRS=m
CONFIG_SCSI_FC_ATTRS=m
CONFIG_SCSI_FC_TGT_ATTRS=y
CONFIG_SCSI_ISCSI_ATTRS=m
CONFIG_SCSI_SAS_ATTRS=m
CONFIG_SCSI_SAS_LIBSAS=m
CONFIG_SCSI_SAS_HOST_SMP=y
# CONFIG_SCSI_SAS_LIBSAS_DEBUG is not set
CONFIG_SCSI_SRP_ATTRS=m
CONFIG_SCSI_SRP_TGT_ATTRS=y
CONFIG_SCSI_LOWLEVEL=y
CONFIG_ISCSI_TCP=m
CONFIG_BLK_DEV_3W_XXXX_RAID=m
CONFIG_SCSI_3W_9XXX=m
CONFIG_SCSI_ACARD=m
CONFIG_SCSI_AACRAID=m
CONFIG_SCSI_AIC7XXX=m
CONFIG_AIC7XXX_CMDS_PER_DEVICE=32
CONFIG_AIC7XXX_RESET_DELAY_MS=15000
CONFIG_AIC7XXX_DEBUG_ENABLE=y
CONFIG_AIC7XXX_DEBUG_MASK=0
CONFIG_AIC7XXX_REG_PRETTY_PRINT=y
CONFIG_SCSI_AIC7XXX_OLD=m
CONFIG_SCSI_AIC79XX=m
CONFIG_AIC79XX_CMDS_PER_DEVICE=32
CONFIG_AIC79XX_RESET_DELAY_MS=15000
CONFIG_AIC79XX_DEBUG_ENABLE=y
CONFIG_AIC79XX_DEBUG_MASK=0
CONFIG_AIC79XX_REG_PRETTY_PRINT=y
CONFIG_SCSI_AIC94XX=m
# CONFIG_AIC94XX_DEBUG is not set
CONFIG_SCSI_DPT_I2O=m
CONFIG_SCSI_ADVANSYS=m
CONFIG_SCSI_ARCMSR=m
CONFIG_MEGARAID_NEWGEN=y
CONFIG_MEGARAID_MM=m
CONFIG_MEGARAID_MAILBOX=m
# CONFIG_MEGARAID_LEGACY is not set
CONFIG_MEGARAID_SAS=m
# CONFIG_SCSI_MPT2SAS is not set
CONFIG_SCSI_HPTIOP=m
CONFIG_SCSI_BUSLOGIC=m
# CONFIG_LIBFC is not set
# CONFIG_LIBFCOE is not set
# CONFIG_FCOE is not set
CONFIG_SCSI_DMX3191D=m
CONFIG_SCSI_EATA=m
# CONFIG_SCSI_EATA_TAGGED_QUEUE is not set
# CONFIG_SCSI_EATA_LINKED_COMMANDS is not set
CONFIG_SCSI_EATA_MAX_TAGS=16
# CONFIG_SCSI_FUTURE_DOMAIN is not set
# CONFIG_SCSI_GDTH is not set
CONFIG_SCSI_IPS=m
# CONFIG_SCSI_INITIO is not set
CONFIG_SCSI_INIA100=m
CONFIG_SCSI_MVSAS=m
CONFIG_SCSI_STEX=m
CONFIG_SCSI_SYM53C8XX_2=m
CONFIG_SCSI_SYM53C8XX_DMA_ADDRESSING_MODE=1
CONFIG_SCSI_SYM53C8XX_DEFAULT_TAGS=16
CONFIG_SCSI_SYM53C8XX_MAX_TAGS=64
CONFIG_SCSI_SYM53C8XX_MMIO=y
# CONFIG_SCSI_QLOGIC_1280 is not set
CONFIG_SCSI_QLA_FC=m
CONFIG_SCSI_QLA_ISCSI=m
CONFIG_SCSI_LPFC=m
# CONFIG_SCSI_LPFC_DEBUG_FS is not set
CONFIG_SCSI_DC395x=m
CONFIG_SCSI_DC390T=m
CONFIG_SCSI_NSP32=m
# CONFIG_SCSI_DEBUG is not set
CONFIG_SCSI_MESH=m
CONFIG_SCSI_MESH_SYNC_RATE=5
CONFIG_SCSI_MESH_RESET_DELAY_MS=4000
CONFIG_SCSI_MAC53C94=m
CONFIG_SCSI_SRP=m
# CONFIG_SCSI_DH is not set
# CONFIG_SCSI_OSD_INITIATOR is not set
# CONFIG_ATA is not set
CONFIG_MD=y
CONFIG_BLK_DEV_MD=m
CONFIG_MD_LINEAR=m
CONFIG_MD_RAID0=m
CONFIG_MD_RAID1=m
CONFIG_MD_RAID10=m
CONFIG_MD_RAID456=m
CONFIG_MD_RAID6_PQ=m
CONFIG_MD_MULTIPATH=m
CONFIG_MD_FAULTY=m
CONFIG_BLK_DEV_DM=m
# CONFIG_DM_DEBUG is not set
CONFIG_DM_CRYPT=m
CONFIG_DM_SNAPSHOT=m
CONFIG_DM_MIRROR=m
CONFIG_DM_ZERO=m
CONFIG_DM_MULTIPATH=m
CONFIG_DM_DELAY=m
CONFIG_DM_UEVENT=y
CONFIG_FUSION=y
CONFIG_FUSION_SPI=m
CONFIG_FUSION_FC=m
CONFIG_FUSION_SAS=m
CONFIG_FUSION_MAX_SGE=40
CONFIG_FUSION_CTL=m
# CONFIG_FUSION_LOGGING is not set

#
# IEEE 1394 (FireWire) support
#

#
# Enable only one of the two stacks, unless you know what you are doing
#
# CONFIG_FIREWIRE is not set
CONFIG_IEEE1394=m
CONFIG_IEEE1394_OHCI1394=m
CONFIG_IEEE1394_PCILYNX=m
CONFIG_IEEE1394_SBP2=m
# CONFIG_IEEE1394_SBP2_PHYS_DMA is not set
CONFIG_IEEE1394_ETH1394_ROM_ENTRY=y
CONFIG_IEEE1394_ETH1394=m
CONFIG_IEEE1394_RAWIO=m
CONFIG_IEEE1394_VIDEO1394=m
CONFIG_IEEE1394_DV1394=m
# CONFIG_IEEE1394_VERBOSEDEBUG is not set
CONFIG_I2O=y
CONFIG_I2O_LCT_NOTIFY_ON_CHANGES=y
CONFIG_I2O_EXT_ADAPTEC=y
CONFIG_I2O_CONFIG=m
CONFIG_I2O_CONFIG_OLD_IOCTL=y
CONFIG_I2O_BUS=m
CONFIG_I2O_BLOCK=m
CONFIG_I2O_SCSI=m
CONFIG_I2O_PROC=m
CONFIG_MACINTOSH_DRIVERS=y
CONFIG_ADB=y
CONFIG_ADB_CUDA=y
CONFIG_ADB_PMU=y
CONFIG_ADB_PMU_LED=y
# CONFIG_ADB_PMU_LED_IDE is not set
CONFIG_PMAC_APM_EMU=m
CONFIG_PMAC_MEDIABAY=y
CONFIG_PMAC_BACKLIGHT=y
# CONFIG_PMAC_BACKLIGHT_LEGACY is not set
CONFIG_ADB_MACIO=y
CONFIG_INPUT_ADBHID=y
CONFIG_MAC_EMUMOUSEBTN=y
CONFIG_THERM_WINDTUNNEL=m
CONFIG_THERM_ADT746X=m
CONFIG_WINDFARM=m
CONFIG_ANSLCD=m
# CONFIG_PMAC_RACKMETER is not set
CONFIG_NETDEVICES=y
CONFIG_COMPAT_NET_DEV_OPS=y
CONFIG_IFB=m
CONFIG_DUMMY=m
CONFIG_BONDING=m
# CONFIG_MACVLAN is not set
CONFIG_EQUALIZER=m
CONFIG_TUN=m
CONFIG_VETH=m
CONFIG_ARCNET=m
CONFIG_ARCNET_1201=m
CONFIG_ARCNET_1051=m
CONFIG_ARCNET_RAW=m
CONFIG_ARCNET_CAP=m
# CONFIG_ARCNET_COM90xx is not set
CONFIG_ARCNET_COM90xxIO=m
# CONFIG_ARCNET_RIM_I is not set
CONFIG_ARCNET_COM20020=m
CONFIG_ARCNET_COM20020_PCI=m
CONFIG_PHYLIB=m

#
# MII PHY device drivers
#
CONFIG_MARVELL_PHY=m
CONFIG_DAVICOM_PHY=m
CONFIG_QSEMI_PHY=m
CONFIG_LXT_PHY=m
CONFIG_CICADA_PHY=m
CONFIG_VITESSE_PHY=m
CONFIG_SMSC_PHY=m
CONFIG_BROADCOM_PHY=m
CONFIG_ICPLUS_PHY=m
CONFIG_REALTEK_PHY=m
# CONFIG_NATIONAL_PHY is not set
# CONFIG_STE10XP is not set
# CONFIG_LSI_ET1011C_PHY is not set
CONFIG_MDIO_BITBANG=m
CONFIG_NET_ETHERNET=y
CONFIG_MII=y
# CONFIG_MACE is not set
# CONFIG_BMAC is not set
# CONFIG_HAPPYMEAL is not set
CONFIG_SUNGEM=y
# CONFIG_CASSINI is not set
# CONFIG_NET_VENDOR_3COM is not set
# CONFIG_ETHOC is not set
# CONFIG_DNET is not set
# CONFIG_NET_TULIP is not set
# CONFIG_HP100 is not set
# CONFIG_IBM_NEW_EMAC_ZMII is not set
# CONFIG_IBM_NEW_EMAC_RGMII is not set
# CONFIG_IBM_NEW_EMAC_TAH is not set
# CONFIG_IBM_NEW_EMAC_EMAC4 is not set
# CONFIG_IBM_NEW_EMAC_NO_FLOW_CTRL is not set
# CONFIG_IBM_NEW_EMAC_MAL_CLR_ICINTSTAT is not set
# CONFIG_IBM_NEW_EMAC_MAL_COMMON_ERR is not set
# CONFIG_NET_PCI is not set
# CONFIG_B44 is not set
# CONFIG_ATL2 is not set
# CONFIG_NETDEV_1000 is not set
# CONFIG_NETDEV_10000 is not set
# CONFIG_TR is not set

#
# Wireless LAN
#
CONFIG_WLAN_PRE80211=y
CONFIG_STRIP=m
CONFIG_WLAN_80211=y
CONFIG_LIBERTAS=m
CONFIG_LIBERTAS_USB=m
# CONFIG_LIBERTAS_DEBUG is not set
CONFIG_AIRO=m
CONFIG_ATMEL=m
# CONFIG_PCI_ATMEL is not set
# CONFIG_PRISM54 is not set
CONFIG_USB_ZD1201=m
CONFIG_USB_NET_RNDIS_WLAN=m
# CONFIG_IPW2100 is not set
CONFIG_IPW2200=m
CONFIG_IPW2200_MONITOR=y
CONFIG_IPW2200_RADIOTAP=y
CONFIG_IPW2200_PROMISCUOUS=y
CONFIG_IPW2200_QOS=y
# CONFIG_IPW2200_DEBUG is not set
CONFIG_LIBIPW=m
# CONFIG_LIBIPW_DEBUG is not set
CONFIG_HOSTAP=m
CONFIG_HOSTAP_FIRMWARE=y
# CONFIG_HOSTAP_FIRMWARE_NVRAM is not set
CONFIG_HOSTAP_PLX=m
CONFIG_HOSTAP_PCI=m
CONFIG_HERMES=m
# CONFIG_HERMES_CACHE_FW_ON_INIT is not set
CONFIG_APPLE_AIRPORT=m
CONFIG_PLX_HERMES=m
CONFIG_TMD_HERMES=m
CONFIG_NORTEL_HERMES=m
CONFIG_PCI_HERMES=m

#
# Enable WiMAX (Networking options) to see the WiMAX drivers
#

#
# USB Network Adapters
#
CONFIG_USB_CATC=m
CONFIG_USB_KAWETH=m
CONFIG_USB_PEGASUS=m
CONFIG_USB_RTL8150=m
CONFIG_USB_USBNET=m
CONFIG_USB_NET_AX8817X=m
CONFIG_USB_NET_CDCETHER=m
CONFIG_USB_NET_DM9601=m
# CONFIG_USB_NET_SMSC95XX is not set
CONFIG_USB_NET_GL620A=m
CONFIG_USB_NET_NET1080=m
CONFIG_USB_NET_PLUSB=m
CONFIG_USB_NET_MCS7830=m
CONFIG_USB_NET_RNDIS_HOST=m
CONFIG_USB_NET_CDC_SUBSET=m
CONFIG_USB_ALI_M5632=y
CONFIG_USB_AN2720=y
CONFIG_USB_BELKIN=y
CONFIG_USB_ARMLINUX=y
CONFIG_USB_EPSON2888=y
CONFIG_USB_KC2190=y
CONFIG_USB_NET_ZAURUS=m
# CONFIG_WAN is not set
# CONFIG_ATM_DRIVERS is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set
# CONFIG_NET_FC is not set
CONFIG_NETCONSOLE=m
CONFIG_NETCONSOLE_DYNAMIC=y
CONFIG_NETPOLL=y
CONFIG_NETPOLL_TRAP=y
CONFIG_NET_POLL_CONTROLLER=y
# CONFIG_ISDN is not set
# CONFIG_PHONE is not set

#
# Input device support
#
CONFIG_INPUT=y
CONFIG_INPUT_FF_MEMLESS=m
CONFIG_INPUT_POLLDEV=m

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
# CONFIG_INPUT_JOYDEV is not set
CONFIG_INPUT_EVDEV=m
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=m
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_NEWTON is not set
CONFIG_KEYBOARD_STOWAWAY=m
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=m
CONFIG_MOUSE_PS2_ALPS=y
CONFIG_MOUSE_PS2_LOGIPS2PP=y
CONFIG_MOUSE_PS2_SYNAPTICS=y
CONFIG_MOUSE_PS2_TRACKPOINT=y
# CONFIG_MOUSE_PS2_ELANTECH is not set
# CONFIG_MOUSE_PS2_TOUCHKIT is not set
# CONFIG_MOUSE_SERIAL is not set
CONFIG_MOUSE_APPLETOUCH=m
# CONFIG_MOUSE_BCM5974 is not set
# CONFIG_MOUSE_VSXXXAA is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TABLET is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
CONFIG_INPUT_MISC=y
# CONFIG_INPUT_PCSPKR is not set
# CONFIG_INPUT_ATI_REMOTE is not set
# CONFIG_INPUT_ATI_REMOTE2 is not set
# CONFIG_INPUT_KEYSPAN_REMOTE is not set
# CONFIG_INPUT_POWERMATE is not set
# CONFIG_INPUT_YEALINK is not set
# CONFIG_INPUT_CM109 is not set
CONFIG_INPUT_UINPUT=m

#
# Hardware I/O ports
#
CONFIG_SERIO=m
# CONFIG_SERIO_I8042 is not set
CONFIG_SERIO_SERPORT=m
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=m
CONFIG_SERIO_RAW=m
# CONFIG_SERIO_XILINX_XPS_PS2 is not set
# CONFIG_GAMEPORT is not set

#
# Character devices
#
CONFIG_VT=y
CONFIG_CONSOLE_TRANSLATIONS=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
# CONFIG_VT_HW_CONSOLE_BINDING is not set
CONFIG_DEVKMEM=y
# CONFIG_SERIAL_NONSTANDARD is not set
# CONFIG_NOZOMI is not set

#
# Serial drivers
#
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_NR_UARTS=32
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
# CONFIG_SERIAL_8250_EXTENDED is not set

#
# Non-8250 serial port support
#
# CONFIG_SERIAL_UARTLITE is not set
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
CONFIG_SERIAL_PMACZILOG=y
# CONFIG_SERIAL_PMACZILOG_TTYS is not set
CONFIG_SERIAL_PMACZILOG_CONSOLE=y
CONFIG_SERIAL_JSM=m
# CONFIG_SERIAL_OF_PLATFORM is not set
CONFIG_UNIX98_PTYS=y
# CONFIG_DEVPTS_MULTIPLE_INSTANCES is not set
# CONFIG_LEGACY_PTYS is not set
# CONFIG_BRIQ_PANEL is not set
# CONFIG_HVC_RTAS is not set
# CONFIG_HVC_UDBG is not set
CONFIG_IPMI_HANDLER=m
# CONFIG_IPMI_PANIC_EVENT is not set
CONFIG_IPMI_DEVICE_INTERFACE=m
CONFIG_IPMI_SI=m
CONFIG_IPMI_WATCHDOG=m
CONFIG_IPMI_POWEROFF=m
CONFIG_HW_RANDOM=m
CONFIG_HW_RANDOM_TIMERIOMEM=m
CONFIG_NVRAM=y
# CONFIG_R3964 is not set
CONFIG_APPLICOM=m
# CONFIG_RAW_DRIVER is not set
CONFIG_TCG_TPM=m
CONFIG_TCG_NSC=m
CONFIG_TCG_ATMEL=m
CONFIG_DEVPORT=y
CONFIG_I2C=y
CONFIG_I2C_BOARDINFO=y
CONFIG_I2C_CHARDEV=y
CONFIG_I2C_HELPER_AUTO=y
CONFIG_I2C_ALGOBIT=y

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI1563 is not set
# CONFIG_I2C_ALI15X3 is not set
# CONFIG_I2C_AMD756 is not set
# CONFIG_I2C_AMD8111 is not set
# CONFIG_I2C_I801 is not set
# CONFIG_I2C_ISCH is not set
# CONFIG_I2C_PIIX4 is not set
# CONFIG_I2C_NFORCE2 is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
# CONFIG_I2C_SIS96X is not set
# CONFIG_I2C_VIA is not set
# CONFIG_I2C_VIAPRO is not set

#
# Mac SMBus host controller drivers
#
CONFIG_I2C_HYDRA=y
CONFIG_I2C_POWERMAC=y

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
# CONFIG_I2C_MPC is not set
# CONFIG_I2C_OCORES is not set
# CONFIG_I2C_SIMTEC is not set

#
# External I2C/SMBus adapter drivers
#
# CONFIG_I2C_PARPORT_LIGHT is not set
# CONFIG_I2C_TAOS_EVM is not set
# CONFIG_I2C_TINY_USB is not set

#
# Graphics adapter I2C/DDC channel drivers
#
# CONFIG_I2C_VOODOO3 is not set

#
# Other I2C/SMBus bus drivers
#
# CONFIG_I2C_PCA_PLATFORM is not set
# CONFIG_I2C_STUB is not set

#
# Miscellaneous I2C Chip support
#
# CONFIG_DS1682 is not set
# CONFIG_SENSORS_PCF8574 is not set
# CONFIG_PCF8575 is not set
# CONFIG_SENSORS_PCA9539 is not set
# CONFIG_SENSORS_MAX6875 is not set
# CONFIG_SENSORS_TSL2550 is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# CONFIG_I2C_DEBUG_CHIP is not set
# CONFIG_SPI is not set
CONFIG_ARCH_WANT_OPTIONAL_GPIOLIB=y
# CONFIG_GPIOLIB is not set
# CONFIG_W1 is not set
# CONFIG_POWER_SUPPLY is not set
# CONFIG_HWMON is not set
# CONFIG_THERMAL is not set
# CONFIG_THERMAL_HWMON is not set
# CONFIG_WATCHDOG is not set
CONFIG_SSB_POSSIBLE=y

#
# Sonics Silicon Backplane
#
# CONFIG_SSB is not set

#
# Multifunction device drivers
#
# CONFIG_MFD_CORE is not set
# CONFIG_MFD_SM501 is not set
# CONFIG_HTC_PASIC3 is not set
# CONFIG_TWL4030_CORE is not set
# CONFIG_MFD_TMIO is not set
# CONFIG_PMIC_DA903X is not set
# CONFIG_MFD_WM8400 is not set
# CONFIG_MFD_WM8350_I2C is not set
# CONFIG_MFD_PCF50633 is not set
# CONFIG_REGULATOR is not set

#
# Multimedia devices
#

#
# Multimedia core support
#
# CONFIG_VIDEO_DEV is not set
# CONFIG_DVB_CORE is not set
# CONFIG_VIDEO_MEDIA is not set

#
# Multimedia drivers
#
# CONFIG_DAB is not set

#
# Graphics support
#
CONFIG_AGP=y
CONFIG_AGP_UNINORTH=y
CONFIG_DRM=m
# CONFIG_DRM_TDFX is not set
# CONFIG_DRM_R128 is not set
# CONFIG_DRM_RADEON is not set
# CONFIG_DRM_MGA is not set
# CONFIG_DRM_SIS is not set
# CONFIG_DRM_VIA is not set
# CONFIG_DRM_SAVAGE is not set
CONFIG_VGASTATE=y
# CONFIG_VIDEO_OUTPUT_CONTROL is not set
CONFIG_FB=y
CONFIG_FIRMWARE_EDID=y
CONFIG_FB_DDC=y
# CONFIG_FB_BOOT_VESA_SUPPORT is not set
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
# CONFIG_FB_CFB_REV_PIXELS_IN_BYTE is not set
# CONFIG_FB_SYS_FILLRECT is not set
# CONFIG_FB_SYS_COPYAREA is not set
# CONFIG_FB_SYS_IMAGEBLIT is not set
# CONFIG_FB_FOREIGN_ENDIAN is not set
# CONFIG_FB_SYS_FOPS is not set
# CONFIG_FB_SVGALIB is not set
CONFIG_FB_MACMODES=y
CONFIG_FB_BACKLIGHT=y
CONFIG_FB_MODE_HELPERS=y
CONFIG_FB_TILEBLITTING=y

#
# Frame buffer hardware drivers
#
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
CONFIG_FB_OF=y
CONFIG_FB_CONTROL=y
CONFIG_FB_PLATINUM=y
CONFIG_FB_VALKYRIE=y
# CONFIG_FB_CT65550 is not set
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
# CONFIG_FB_UVESA is not set
# CONFIG_FB_S1D13XXX is not set
CONFIG_FB_NVIDIA=y
CONFIG_FB_NVIDIA_I2C=y
# CONFIG_FB_NVIDIA_DEBUG is not set
CONFIG_FB_NVIDIA_BACKLIGHT=y
# CONFIG_FB_RIVA is not set
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_S3 is not set
# CONFIG_FB_SAVAGE is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_VIA is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_KYRO is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_VT8623 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_ARK is not set
# CONFIG_FB_PM3 is not set
# CONFIG_FB_CARMINE is not set
# CONFIG_FB_IBM_GXT4500 is not set
# CONFIG_FB_VIRTUAL is not set
# CONFIG_FB_METRONOME is not set
# CONFIG_FB_MB862XX is not set
# CONFIG_FB_BROADSHEET is not set
CONFIG_BACKLIGHT_LCD_SUPPORT=y
CONFIG_LCD_CLASS_DEVICE=m
# CONFIG_LCD_ILI9320 is not set
CONFIG_LCD_PLATFORM=m
CONFIG_BACKLIGHT_CLASS_DEVICE=y
# CONFIG_BACKLIGHT_GENERIC is not set

#
# Display device support
#
CONFIG_DISPLAY_SUPPORT=m

#
# Display hardware drivers
#

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
# CONFIG_VGACON_SOFT_SCROLLBACK is not set
CONFIG_DUMMY_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE=y
# CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY is not set
CONFIG_FRAMEBUFFER_CONSOLE_ROTATION=y
# CONFIG_FONTS is not set
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y
CONFIG_LOGO=y
# CONFIG_LOGO_LINUX_MONO is not set
CONFIG_LOGO_LINUX_VGA16=y
CONFIG_LOGO_LINUX_CLUT224=y
CONFIG_SOUND=y
CONFIG_SOUND_OSS_CORE=y
CONFIG_SND=m
CONFIG_SND_TIMER=m
CONFIG_SND_PCM=m
CONFIG_SND_RAWMIDI=m
CONFIG_SND_SEQUENCER=m
# CONFIG_SND_SEQ_DUMMY is not set
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=m
CONFIG_SND_PCM_OSS=m
CONFIG_SND_PCM_OSS_PLUGINS=y
CONFIG_SND_SEQUENCER_OSS=y
CONFIG_SND_HRTIMER=m
CONFIG_SND_SEQ_HRTIMER_DEFAULT=y
# CONFIG_SND_DYNAMIC_MINORS is not set
CONFIG_SND_SUPPORT_OLD_API=y
CONFIG_SND_VERBOSE_PROCFS=y
# CONFIG_SND_VERBOSE_PRINTK is not set
# CONFIG_SND_DEBUG is not set
CONFIG_SND_VMASTER=y
CONFIG_SND_DRIVERS=y
# CONFIG_SND_DUMMY is not set
CONFIG_SND_VIRMIDI=m
# CONFIG_SND_MTPAV is not set
# CONFIG_SND_SERIAL_U16550 is not set
# CONFIG_SND_MPU401 is not set
# CONFIG_SND_PCI is not set
CONFIG_SND_PPC=y
CONFIG_SND_POWERMAC=m
# CONFIG_SND_POWERMAC_AUTO_DRC is not set
CONFIG_SND_AOA=m
CONFIG_SND_AOA_FABRIC_LAYOUT=m
CONFIG_SND_AOA_ONYX=m
CONFIG_SND_AOA_TAS=m
# CONFIG_SND_AOA_TOONIE is not set
CONFIG_SND_AOA_SOUNDBUS=m
CONFIG_SND_AOA_SOUNDBUS_I2S=m
# CONFIG_SND_USB is not set
# CONFIG_SND_SOC is not set
# CONFIG_SOUND_PRIME is not set
CONFIG_HID_SUPPORT=y
CONFIG_HID=y
# CONFIG_HID_DEBUG is not set
CONFIG_HIDRAW=y

#
# USB Input Devices
#
CONFIG_USB_HID=y
CONFIG_HID_PID=y
CONFIG_USB_HIDDEV=y

#
# Special HID drivers
#
CONFIG_HID_A4TECH=y
CONFIG_HID_APPLE=y
CONFIG_HID_BELKIN=y
CONFIG_HID_CHERRY=y
CONFIG_HID_CHICONY=y
CONFIG_HID_CYPRESS=y
# CONFIG_DRAGONRISE_FF is not set
CONFIG_HID_EZKEY=y
CONFIG_HID_KYE=y
CONFIG_HID_GYRATION=y
CONFIG_HID_KENSINGTON=y
CONFIG_HID_LOGITECH=y
# CONFIG_LOGITECH_FF is not set
# CONFIG_LOGIRUMBLEPAD2_FF is not set
CONFIG_HID_MICROSOFT=y
CONFIG_HID_MONTEREY=y
CONFIG_HID_NTRIG=y
CONFIG_HID_PANTHERLORD=y
# CONFIG_PANTHERLORD_FF is not set
CONFIG_HID_PETALYNX=y
CONFIG_HID_SAMSUNG=y
CONFIG_HID_SONY=y
CONFIG_HID_SUNPLUS=y
# CONFIG_GREENASIA_FF is not set
CONFIG_HID_TOPSEED=y
# CONFIG_THRUSTMASTER_FF is not set
# CONFIG_ZEROPLUS_FF is not set
CONFIG_USB_SUPPORT=y
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB_ARCH_HAS_OHCI=y
CONFIG_USB_ARCH_HAS_EHCI=y
CONFIG_USB=y
# CONFIG_USB_DEBUG is not set
CONFIG_USB_ANNOUNCE_NEW_DEVICES=y

#
# Miscellaneous USB options
#
CONFIG_USB_DEVICEFS=y
CONFIG_USB_DEVICE_CLASS=y
CONFIG_USB_DYNAMIC_MINORS=y
# CONFIG_USB_SUSPEND is not set
# CONFIG_USB_OTG is not set
CONFIG_USB_MON=y
# CONFIG_USB_WUSB is not set
# CONFIG_USB_WUSB_CBAF is not set

#
# USB Host Controller Drivers
#
CONFIG_USB_C67X00_HCD=m
CONFIG_USB_EHCI_HCD=m
CONFIG_USB_EHCI_ROOT_HUB_TT=y
CONFIG_USB_EHCI_TT_NEWSCHED=y
CONFIG_USB_EHCI_HCD_PPC_OF=y
# CONFIG_USB_OXU210HP_HCD is not set
CONFIG_USB_ISP116X_HCD=m
# CONFIG_USB_ISP1760_HCD is not set
CONFIG_USB_OHCI_HCD=y
CONFIG_USB_OHCI_HCD_PPC_OF=y
CONFIG_USB_OHCI_HCD_PPC_OF_BE=y
CONFIG_USB_OHCI_HCD_PPC_OF_LE=y
CONFIG_USB_OHCI_HCD_PCI=y
CONFIG_USB_OHCI_BIG_ENDIAN_DESC=y
CONFIG_USB_OHCI_BIG_ENDIAN_MMIO=y
CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_UHCI_HCD=m
CONFIG_USB_U132_HCD=m
CONFIG_USB_SL811_HCD=m
CONFIG_USB_R8A66597_HCD=m
# CONFIG_USB_WHCI_HCD is not set
# CONFIG_USB_HWA_HCD is not set

#
# USB Device Class drivers
#
CONFIG_USB_ACM=m
CONFIG_USB_PRINTER=m
CONFIG_USB_WDM=m
# CONFIG_USB_TMC is not set

#
# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
#

#
# also be needed; see USB_STORAGE Help for more info
#
CONFIG_USB_STORAGE=m
# CONFIG_USB_STORAGE_DEBUG is not set
CONFIG_USB_STORAGE_DATAFAB=m
CONFIG_USB_STORAGE_FREECOM=m
CONFIG_USB_STORAGE_ISD200=m
CONFIG_USB_STORAGE_USBAT=m
CONFIG_USB_STORAGE_SDDR09=m
CONFIG_USB_STORAGE_SDDR55=m
CONFIG_USB_STORAGE_JUMPSHOT=m
CONFIG_USB_STORAGE_ALAUDA=m
CONFIG_USB_STORAGE_ONETOUCH=m
CONFIG_USB_STORAGE_KARMA=m
CONFIG_USB_STORAGE_CYPRESS_ATACB=m
# CONFIG_USB_LIBUSUAL is not set

#
# USB Imaging devices
#
CONFIG_USB_MDC800=m
CONFIG_USB_MICROTEK=m

#
# USB port drivers
#
CONFIG_USB_SERIAL=m
CONFIG_USB_EZUSB=y
CONFIG_USB_SERIAL_GENERIC=y
CONFIG_USB_SERIAL_AIRCABLE=m
CONFIG_USB_SERIAL_ARK3116=m
CONFIG_USB_SERIAL_BELKIN=m
CONFIG_USB_SERIAL_CH341=m
# CONFIG_USB_SERIAL_WHITEHEAT is not set
CONFIG_USB_SERIAL_DIGI_ACCELEPORT=m
# CONFIG_USB_SERIAL_CP210X is not set
CONFIG_USB_SERIAL_CYPRESS_M8=m
CONFIG_USB_SERIAL_EMPEG=m
CONFIG_USB_SERIAL_FTDI_SIO=m
CONFIG_USB_SERIAL_FUNSOFT=m
CONFIG_USB_SERIAL_VISOR=m
CONFIG_USB_SERIAL_IPAQ=m
CONFIG_USB_SERIAL_IR=m
CONFIG_USB_SERIAL_EDGEPORT=m
CONFIG_USB_SERIAL_EDGEPORT_TI=m
CONFIG_USB_SERIAL_GARMIN=m
CONFIG_USB_SERIAL_IPW=m
CONFIG_USB_SERIAL_IUU=m
CONFIG_USB_SERIAL_KEYSPAN_PDA=m
CONFIG_USB_SERIAL_KEYSPAN=m
CONFIG_USB_SERIAL_KLSI=m
CONFIG_USB_SERIAL_KOBIL_SCT=m
CONFIG_USB_SERIAL_MCT_U232=m
CONFIG_USB_SERIAL_MOS7720=m
CONFIG_USB_SERIAL_MOS7840=m
CONFIG_USB_SERIAL_MOTOROLA=m
CONFIG_USB_SERIAL_NAVMAN=m
CONFIG_USB_SERIAL_PL2303=m
CONFIG_USB_SERIAL_OTI6858=m
# CONFIG_USB_SERIAL_QUALCOMM is not set
CONFIG_USB_SERIAL_SPCP8X5=m
CONFIG_USB_SERIAL_HP4X=m
CONFIG_USB_SERIAL_SAFE=m
# CONFIG_USB_SERIAL_SAFE_PADDED is not set
# CONFIG_USB_SERIAL_SIEMENS_MPI is not set
CONFIG_USB_SERIAL_SIERRAWIRELESS=m
# CONFIG_USB_SERIAL_SYMBOL is not set
# CONFIG_USB_SERIAL_TI is not set
CONFIG_USB_SERIAL_CYBERJACK=m
CONFIG_USB_SERIAL_XIRCOM=m
CONFIG_USB_SERIAL_OPTION=m
CONFIG_USB_SERIAL_OMNINET=m
# CONFIG_USB_SERIAL_OPTICON is not set
CONFIG_USB_SERIAL_DEBUG=m

#
# USB Miscellaneous drivers
#
# CONFIG_USB_EMI62 is not set
# CONFIG_USB_EMI26 is not set
CONFIG_USB_ADUTUX=m
# CONFIG_USB_SEVSEG is not set
CONFIG_USB_RIO500=m
CONFIG_USB_LEGOTOWER=m
CONFIG_USB_LCD=m
CONFIG_USB_BERRY_CHARGE=m
CONFIG_USB_LED=m
CONFIG_USB_CYPRESS_CY7C63=m
CONFIG_USB_CYTHERM=m
CONFIG_USB_IDMOUSE=m
CONFIG_USB_FTDI_ELAN=m
CONFIG_USB_APPLEDISPLAY=m
CONFIG_USB_SISUSBVGA=m
CONFIG_USB_SISUSBVGA_CON=y
CONFIG_USB_LD=m
CONFIG_USB_TRANCEVIBRATOR=m
CONFIG_USB_IOWARRIOR=m
CONFIG_USB_TEST=m
CONFIG_USB_ISIGHTFW=m
# CONFIG_USB_VST is not set
CONFIG_USB_ATM=m
CONFIG_USB_SPEEDTOUCH=m
CONFIG_USB_CXACRU=m
CONFIG_USB_UEAGLEATM=m
CONFIG_USB_XUSBATM=m
# CONFIG_USB_GADGET is not set

#
# OTG and related infrastructure
#
# CONFIG_NOP_USB_XCEIV is not set
# CONFIG_UWB is not set
# CONFIG_MMC is not set
# CONFIG_MEMSTICK is not set
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y

#
# LED drivers
#
# CONFIG_LEDS_PCA9532 is not set
# CONFIG_LEDS_LP5521 is not set
# CONFIG_LEDS_PCA955X is not set
# CONFIG_LEDS_BD2802 is not set

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
CONFIG_LEDS_TRIGGER_TIMER=m
CONFIG_LEDS_TRIGGER_IDE_DISK=y
CONFIG_LEDS_TRIGGER_HEARTBEAT=m
# CONFIG_LEDS_TRIGGER_BACKLIGHT is not set
CONFIG_LEDS_TRIGGER_DEFAULT_ON=m

#
# iptables trigger is under Netfilter config (LED target)
#
# CONFIG_ACCESSIBILITY is not set
# CONFIG_INFINIBAND is not set
# CONFIG_EDAC is not set
CONFIG_RTC_LIB=y
CONFIG_RTC_CLASS=y
CONFIG_RTC_HCTOSYS=y
CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
# CONFIG_RTC_DEBUG is not set

#
# RTC interfaces
#
CONFIG_RTC_INTF_SYSFS=y
CONFIG_RTC_INTF_PROC=y
CONFIG_RTC_INTF_DEV=y
# CONFIG_RTC_INTF_DEV_UIE_EMUL is not set
# CONFIG_RTC_DRV_TEST is not set

#
# I2C RTC drivers
#
CONFIG_RTC_DRV_DS1307=y
CONFIG_RTC_DRV_DS1374=m
CONFIG_RTC_DRV_DS1672=m
CONFIG_RTC_DRV_MAX6900=m
CONFIG_RTC_DRV_RS5C372=m
CONFIG_RTC_DRV_ISL1208=m
CONFIG_RTC_DRV_X1205=m
CONFIG_RTC_DRV_PCF8563=m
CONFIG_RTC_DRV_PCF8583=m
CONFIG_RTC_DRV_M41T80=m
# CONFIG_RTC_DRV_M41T80_WDT is not set
CONFIG_RTC_DRV_S35390A=m
CONFIG_RTC_DRV_FM3130=m
# CONFIG_RTC_DRV_RX8581 is not set

#
# SPI RTC drivers
#

#
# Platform RTC drivers
#
CONFIG_RTC_DRV_CMOS=m
# CONFIG_RTC_DRV_DS1286 is not set
CONFIG_RTC_DRV_DS1511=m
CONFIG_RTC_DRV_DS1553=m
CONFIG_RTC_DRV_DS1742=m
CONFIG_RTC_DRV_STK17TA8=m
CONFIG_RTC_DRV_M48T86=m
# CONFIG_RTC_DRV_M48T35 is not set
CONFIG_RTC_DRV_M48T59=m
# CONFIG_RTC_DRV_BQ4802 is not set
CONFIG_RTC_DRV_V3020=m

#
# on-CPU RTC drivers
#
CONFIG_RTC_DRV_GENERIC=y
# CONFIG_DMADEVICES is not set
# CONFIG_AUXDISPLAY is not set
# CONFIG_UIO is not set
# CONFIG_STAGING is not set

#
# File systems
#
CONFIG_EXT2_FS=y
CONFIG_EXT2_FS_XATTR=y
CONFIG_EXT2_FS_POSIX_ACL=y
CONFIG_EXT2_FS_SECURITY=y
# CONFIG_EXT2_FS_XIP is not set
CONFIG_EXT3_FS=y
# CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
CONFIG_EXT3_FS_XATTR=y
CONFIG_EXT3_FS_POSIX_ACL=y
CONFIG_EXT3_FS_SECURITY=y
# CONFIG_EXT4_FS is not set
CONFIG_JBD=y
# CONFIG_JBD_DEBUG is not set
CONFIG_JBD2=m
# CONFIG_JBD2_DEBUG is not set
CONFIG_FS_MBCACHE=y
CONFIG_REISERFS_FS=y
# CONFIG_REISERFS_CHECK is not set
# CONFIG_REISERFS_PROC_INFO is not set
CONFIG_REISERFS_FS_XATTR=y
CONFIG_REISERFS_FS_POSIX_ACL=y
CONFIG_REISERFS_FS_SECURITY=y
CONFIG_JFS_FS=m
CONFIG_JFS_POSIX_ACL=y
CONFIG_JFS_SECURITY=y
# CONFIG_JFS_DEBUG is not set
# CONFIG_JFS_STATISTICS is not set
CONFIG_FS_POSIX_ACL=y
CONFIG_FILE_LOCKING=y
CONFIG_XFS_FS=m
CONFIG_XFS_QUOTA=y
CONFIG_XFS_POSIX_ACL=y
CONFIG_XFS_RT=y
# CONFIG_XFS_DEBUG is not set
CONFIG_OCFS2_FS=m
CONFIG_OCFS2_FS_O2CB=m
CONFIG_OCFS2_FS_USERSPACE_CLUSTER=m
# CONFIG_OCFS2_FS_STATS is not set
CONFIG_OCFS2_DEBUG_MASKLOG=y
# CONFIG_OCFS2_DEBUG_FS is not set
# CONFIG_OCFS2_FS_POSIX_ACL is not set
# CONFIG_BTRFS_FS is not set
CONFIG_DNOTIFY=y
CONFIG_INOTIFY=y
CONFIG_INOTIFY_USER=y
CONFIG_QUOTA=y
# CONFIG_QUOTA_NETLINK_INTERFACE is not set
# CONFIG_PRINT_QUOTA_WARNING is not set
CONFIG_QUOTA_TREE=m
# CONFIG_QFMT_V1 is not set
# CONFIG_QFMT_V2 is not set
CONFIG_QUOTACTL=y
CONFIG_AUTOFS_FS=m
CONFIG_AUTOFS4_FS=m
CONFIG_FUSE_FS=m
CONFIG_GENERIC_ACL=y

#
# Caches
#
# CONFIG_FSCACHE is not set

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_UDF_FS=m
CONFIG_UDF_NLS=y

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_FAT_DEFAULT_CODEPAGE=866
CONFIG_FAT_DEFAULT_IOCHARSET="utf8"
CONFIG_NTFS_FS=m
# CONFIG_NTFS_DEBUG is not set
CONFIG_NTFS_RW=y

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
CONFIG_TMPFS_POSIX_ACL=y
# CONFIG_HUGETLB_PAGE is not set
CONFIG_CONFIGFS_FS=m
# CONFIG_MISC_FILESYSTEMS is not set
CONFIG_NETWORK_FILESYSTEMS=y
# CONFIG_NFS_FS is not set
# CONFIG_NFSD is not set
CONFIG_EXPORTFS=m
# CONFIG_SMB_FS is not set
CONFIG_CIFS=m
# CONFIG_CIFS_STATS is not set
CONFIG_CIFS_WEAK_PW_HASH=y
CONFIG_CIFS_UPCALL=y
CONFIG_CIFS_XATTR=y
CONFIG_CIFS_POSIX=y
# CONFIG_CIFS_DEBUG2 is not set
CONFIG_CIFS_DFS_UPCALL=y
CONFIG_CIFS_EXPERIMENTAL=y
# CONFIG_NCP_FS is not set
CONFIG_CODA_FS=m
# CONFIG_AFS_FS is not set

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=y
# CONFIG_ACORN_PARTITION is not set
# CONFIG_OSF_PARTITION is not set
# CONFIG_AMIGA_PARTITION is not set
# CONFIG_ATARI_PARTITION is not set
CONFIG_MAC_PARTITION=y
CONFIG_MSDOS_PARTITION=y
# CONFIG_BSD_DISKLABEL is not set
# CONFIG_MINIX_SUBPARTITION is not set
# CONFIG_SOLARIS_X86_PARTITION is not set
# CONFIG_UNIXWARE_DISKLABEL is not set
# CONFIG_LDM_PARTITION is not set
# CONFIG_SGI_PARTITION is not set
# CONFIG_ULTRIX_PARTITION is not set
# CONFIG_SUN_PARTITION is not set
# CONFIG_KARMA_PARTITION is not set
# CONFIG_EFI_PARTITION is not set
# CONFIG_SYSV68_PARTITION is not set
CONFIG_NLS=m
CONFIG_NLS_DEFAULT="utf8"
CONFIG_NLS_CODEPAGE_437=m
CONFIG_NLS_CODEPAGE_737=m
CONFIG_NLS_CODEPAGE_775=m
CONFIG_NLS_CODEPAGE_850=m
CONFIG_NLS_CODEPAGE_852=m
CONFIG_NLS_CODEPAGE_855=m
CONFIG_NLS_CODEPAGE_857=m
CONFIG_NLS_CODEPAGE_860=m
CONFIG_NLS_CODEPAGE_861=m
CONFIG_NLS_CODEPAGE_862=m
CONFIG_NLS_CODEPAGE_863=m
CONFIG_NLS_CODEPAGE_864=m
CONFIG_NLS_CODEPAGE_865=m
CONFIG_NLS_CODEPAGE_866=m
CONFIG_NLS_CODEPAGE_869=m
CONFIG_NLS_CODEPAGE_936=m
CONFIG_NLS_CODEPAGE_950=m
CONFIG_NLS_CODEPAGE_932=m
CONFIG_NLS_CODEPAGE_949=m
CONFIG_NLS_CODEPAGE_874=m
CONFIG_NLS_ISO8859_8=m
CONFIG_NLS_CODEPAGE_1250=m
CONFIG_NLS_CODEPAGE_1251=m
CONFIG_NLS_ASCII=m
CONFIG_NLS_ISO8859_1=m
CONFIG_NLS_ISO8859_2=m
CONFIG_NLS_ISO8859_3=m
CONFIG_NLS_ISO8859_4=m
CONFIG_NLS_ISO8859_5=m
CONFIG_NLS_ISO8859_6=m
CONFIG_NLS_ISO8859_7=m
CONFIG_NLS_ISO8859_9=m
CONFIG_NLS_ISO8859_13=m
CONFIG_NLS_ISO8859_14=m
CONFIG_NLS_ISO8859_15=m
CONFIG_NLS_KOI8_R=m
CONFIG_NLS_KOI8_U=m
CONFIG_NLS_UTF8=m
CONFIG_DLM=m
CONFIG_DLM_DEBUG=y
CONFIG_BINARY_PRINTF=y

#
# Library routines
#
CONFIG_BITREVERSE=y
CONFIG_GENERIC_FIND_LAST_BIT=y
CONFIG_CRC_CCITT=m
CONFIG_CRC16=m
# CONFIG_CRC_T10DIF is not set
CONFIG_CRC_ITU_T=m
CONFIG_CRC32=y
CONFIG_CRC7=m
CONFIG_LIBCRC32C=m
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=m
CONFIG_LZO_COMPRESS=m
CONFIG_LZO_DECOMPRESS=m
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_BZIP2=y
CONFIG_DECOMPRESS_LZMA=y
CONFIG_TEXTSEARCH=y
CONFIG_TEXTSEARCH_KMP=m
CONFIG_TEXTSEARCH_BM=m
CONFIG_TEXTSEARCH_FSM=m
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT=y
CONFIG_HAS_DMA=y
CONFIG_HAVE_LMB=y
CONFIG_NLATTR=y

#
# Kernel hacking
#
CONFIG_PRINTK_TIME=y
CONFIG_ENABLE_WARN_DEPRECATED=y
CONFIG_ENABLE_MUST_CHECK=y
CONFIG_FRAME_WARN=1024
CONFIG_MAGIC_SYSRQ=y
CONFIG_UNUSED_SYMBOLS=y
CONFIG_DEBUG_FS=y
# CONFIG_HEADERS_CHECK is not set
CONFIG_DEBUG_KERNEL=y
# CONFIG_DEBUG_SHIRQ is not set
CONFIG_DETECT_SOFTLOCKUP=y
# CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC is not set
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=0
CONFIG_DETECT_HUNG_TASK=y
# CONFIG_BOOTPARAM_HUNG_TASK_PANIC is not set
CONFIG_BOOTPARAM_HUNG_TASK_PANIC_VALUE=0
CONFIG_SCHED_DEBUG=y
# CONFIG_SCHEDSTATS is not set
CONFIG_TIMER_STATS=y
# CONFIG_DEBUG_OBJECTS is not set
# CONFIG_SLUB_DEBUG_ON is not set
# CONFIG_SLUB_STATS is not set
# CONFIG_DEBUG_RT_MUTEXES is not set
# CONFIG_RT_MUTEX_TESTER is not set
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_MUTEXES is not set
# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
CONFIG_STACKTRACE=y
# CONFIG_DEBUG_KOBJECT is not set
# CONFIG_DEBUG_HIGHMEM is not set
CONFIG_DEBUG_BUGVERBOSE=y
# CONFIG_DEBUG_INFO is not set
# CONFIG_DEBUG_VM is not set
# CONFIG_DEBUG_WRITECOUNT is not set
CONFIG_DEBUG_MEMORY_INIT=y
# CONFIG_DEBUG_LIST is not set
# CONFIG_DEBUG_SG is not set
# CONFIG_DEBUG_NOTIFIERS is not set
# CONFIG_BOOT_PRINTK_DELAY is not set
# CONFIG_RCU_TORTURE_TEST is not set
# CONFIG_RCU_CPU_STALL_DETECTOR is not set
# CONFIG_BACKTRACE_SELF_TEST is not set
# CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
# CONFIG_FAULT_INJECTION is not set
# CONFIG_LATENCYTOP is not set
CONFIG_SYSCTL_SYSCALL_CHECK=y
# CONFIG_DEBUG_PAGEALLOC is not set
CONFIG_NOP_TRACER=y
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_RING_BUFFER=y
CONFIG_TRACING=y
CONFIG_TRACING_SUPPORT=y

#
# Tracers
#
# CONFIG_FUNCTION_TRACER is not set
# CONFIG_PREEMPT_TRACER is not set
# CONFIG_SCHED_TRACER is not set
# CONFIG_CONTEXT_SWITCH_TRACER is not set
# CONFIG_EVENT_TRACER is not set
# CONFIG_BOOT_TRACER is not set
# CONFIG_TRACE_BRANCH_PROFILING is not set
# CONFIG_STACK_TRACER is not set
# CONFIG_KMEMTRACE is not set
# CONFIG_WORKQUEUE_TRACER is not set
# CONFIG_BLK_DEV_IO_TRACE is not set
# CONFIG_FTRACE_STARTUP_TEST is not set
CONFIG_DYNAMIC_DEBUG=y
# CONFIG_SAMPLES is not set
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
CONFIG_PRINT_STACK_DEPTH=64
# CONFIG_DEBUG_STACKOVERFLOW is not set
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_CODE_PATCHING_SELFTEST is not set
# CONFIG_FTR_FIXUP_SELFTEST is not set
# CONFIG_MSI_BITMAP_SELFTEST is not set
CONFIG_XMON=y
# CONFIG_XMON_DEFAULT is not set
CONFIG_XMON_DISASSEMBLY=y
CONFIG_DEBUGGER=y
# CONFIG_IRQSTACKS is not set
# CONFIG_VIRQ_DEBUG is not set
# CONFIG_BDI_SWITCH is not set
CONFIG_BOOTX_TEXT=y
# CONFIG_PPC_EARLY_DEBUG is not set

#
# Security options
#
CONFIG_KEYS=y
# CONFIG_KEYS_DEBUG_PROC_KEYS is not set
CONFIG_SECURITY=y
CONFIG_SECURITYFS=y
# CONFIG_SECURITY_NETWORK is not set
# CONFIG_SECURITY_PATH is not set
CONFIG_SECURITY_FILE_CAPABILITIES=y
# CONFIG_SECURITY_ROOTPLUG is not set
CONFIG_SECURITY_DEFAULT_MMAP_MIN_ADDR=0
# CONFIG_SECURITY_TOMOYO is not set
CONFIG_XOR_BLOCKS=m
CONFIG_ASYNC_CORE=m
CONFIG_ASYNC_MEMCPY=m
CONFIG_ASYNC_XOR=m
CONFIG_CRYPTO=y

#
# Crypto core or helper
#
CONFIG_CRYPTO_FIPS=y
CONFIG_CRYPTO_ALGAPI=y
CONFIG_CRYPTO_ALGAPI2=y
CONFIG_CRYPTO_AEAD=m
CONFIG_CRYPTO_AEAD2=y
CONFIG_CRYPTO_BLKCIPHER=m
CONFIG_CRYPTO_BLKCIPHER2=y
CONFIG_CRYPTO_HASH=y
CONFIG_CRYPTO_HASH2=y
CONFIG_CRYPTO_RNG=y
CONFIG_CRYPTO_RNG2=y
CONFIG_CRYPTO_PCOMP=y
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
CONFIG_CRYPTO_GF128MUL=m
CONFIG_CRYPTO_NULL=m
CONFIG_CRYPTO_WORKQUEUE=y
# CONFIG_CRYPTO_CRYPTD is not set
CONFIG_CRYPTO_AUTHENC=m
CONFIG_CRYPTO_TEST=m

#
# Authenticated Encryption with Associated Data
#
CONFIG_CRYPTO_CCM=m
CONFIG_CRYPTO_GCM=m
CONFIG_CRYPTO_SEQIV=m

#
# Block modes
#
CONFIG_CRYPTO_CBC=m
CONFIG_CRYPTO_CTR=m
CONFIG_CRYPTO_CTS=m
CONFIG_CRYPTO_ECB=m
CONFIG_CRYPTO_LRW=m
CONFIG_CRYPTO_PCBC=m
CONFIG_CRYPTO_XTS=m

#
# Hash modes
#
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_XCBC=m

#
# Digest
#
CONFIG_CRYPTO_CRC32C=m
CONFIG_CRYPTO_MD4=m
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_MICHAEL_MIC=m
# CONFIG_CRYPTO_RMD128 is not set
# CONFIG_CRYPTO_RMD160 is not set
# CONFIG_CRYPTO_RMD256 is not set
# CONFIG_CRYPTO_RMD320 is not set
CONFIG_CRYPTO_SHA1=m
CONFIG_CRYPTO_SHA256=m
CONFIG_CRYPTO_SHA512=m
CONFIG_CRYPTO_TGR192=m
CONFIG_CRYPTO_WP512=m

#
# Ciphers
#
CONFIG_CRYPTO_AES=y
CONFIG_CRYPTO_ANUBIS=m
CONFIG_CRYPTO_ARC4=m
CONFIG_CRYPTO_BLOWFISH=m
CONFIG_CRYPTO_CAMELLIA=m
CONFIG_CRYPTO_CAST5=m
CONFIG_CRYPTO_CAST6=m
CONFIG_CRYPTO_DES=m
CONFIG_CRYPTO_FCRYPT=m
CONFIG_CRYPTO_KHAZAD=m
CONFIG_CRYPTO_SALSA20=m
CONFIG_CRYPTO_SEED=m
CONFIG_CRYPTO_SERPENT=m
CONFIG_CRYPTO_TEA=m
CONFIG_CRYPTO_TWOFISH=m
CONFIG_CRYPTO_TWOFISH_COMMON=m

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=m
CONFIG_CRYPTO_ZLIB=m
CONFIG_CRYPTO_LZO=m

#
# Random Number Generation
#
CONFIG_CRYPTO_ANSI_CPRNG=y
CONFIG_CRYPTO_HW=y
CONFIG_CRYPTO_DEV_HIFN_795X=m
CONFIG_CRYPTO_DEV_HIFN_795X_RNG=y
# CONFIG_PPC_CLOCK is not set
# CONFIG_VIRTUALIZATION is not set


Best,
Andrey
