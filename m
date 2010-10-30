From: Wolfgang Karall <lists+linux-ide@karall-edv.at>
Subject: Re: Possible regression when going from 2.6.26 to 2.6.32
Date: Sun, 31 Oct 2010 00:20:58 +0200
Message-ID: <20101030222058.GA12315@lenny.spiney.org>
References: <20101029082612.GA6525@lenny.spiney.org> <4CCB3F65.60302@teksavvy.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="AqsLC8rIMeq19msA"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from lenny.fqdn.at ([188.40.128.251]:44982 "EHLO lenny.spiney.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751876Ab0J3WVJ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 30 Oct 2010 18:21:09 -0400
Content-Disposition: inline
In-Reply-To: <4CCB3F65.60302@teksavvy.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <kernel@teksavvy.com>
Cc: linux-ide@vger.kernel.org, saeed.bishara@gmail.com, mlord@pobox.com, tbm@cyrius.com


--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

On Fri, Oct 29, 2010 at 05:40:53PM -0400, Mark Lord wrote:
> Try again with a 2.6.35 kernel -- several sata_mv regressions fixed in 
> there.

I tried plain 2.6.36 (Martin kindly provided me with an already built
image), but no luck, attached is the dmesg output.

One thing I forgot to mention in the intial mail is that what I think the
problem might be is that the disks spin up one after the other in this
NAS box (both when powering on, but also at reboots there is a audible
delay), and the old version 2.6.26 waited long enough while the newer
versions don't. At least that's what I gather from the "retrying in 
5 secs" lines.

Best
Wolfgang

--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dmesg-2.6.36-trunk-orion5x"

[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Linux version 2.6.36-trunk-orion5x (Debian 2.6.36-1~experimental.1) (max@stro.at) (gcc version 4.3.2 (Debian 4.3.2-1.1) ) #1 Sat Oct 30 14:21:25 UTC 2010
[    0.000000] CPU: Feroceon [41069260] revision 0 (ARMv5TEJ), cr=00053177
[    0.000000] CPU: VIVT data cache, VIVT instruction cache
[    0.000000] Machine: QNAP TS-409
[    0.000000] Clearing invalid memory bank 0KB@0x00000000
[    0.000000] Clearing invalid memory bank 0KB@0x00000000
[    0.000000] Clearing invalid memory bank 0KB@0x00000000
[    0.000000] Ignoring unrecognised tag 0x00000000
[    0.000000] Ignoring unrecognised tag 0x00000000
[    0.000000] Ignoring unrecognised tag 0x00000000
[    0.000000] Ignoring unrecognised tag 0x41000403
[    0.000000] Memory policy: ECC disabled, Data cache writeback
[    0.000000] On node 0 totalpages: 65536
[    0.000000] free_area_init_node: node 0, pgdat c03b18d4, node_mem_map c041b000
[    0.000000]   Normal zone: 512 pages used for memmap
[    0.000000]   Normal zone: 0 pages reserved
[    0.000000]   Normal zone: 65024 pages, LIFO batch:15
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 65024
[    0.000000] Kernel command line: console=ttyS0,115200n8 root=/dev/ram rw initrd=0x800000,0x3fffff
[    0.000000] PID hash table entries: 1024 (order: 0, 4096 bytes)
[    0.000000] Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
[    0.000000] Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
[    0.000000] Memory: 256MB = 256MB total
[    0.000000] Memory: 251600k/251600k available, 10544k reserved, 0K highmem
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
[    0.000000]     DMA     : 0xffc00000 - 0xffe00000   (   2 MB)
[    0.000000]     vmalloc : 0xd0800000 - 0xfd800000   ( 720 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xd0000000   ( 256 MB)
[    0.000000]     modules : 0xbf000000 - 0xc0000000   (  16 MB)
[    0.000000]       .init : 0xc0008000 - 0xc0029000   ( 132 kB)
[    0.000000]       .text : 0xc0029000 - 0xc036f000   (3352 kB)
[    0.000000]       .data : 0xc038a000 - 0xc03b5ba0   ( 175 kB)
[    0.000000] SLUB: Genslabs=11, HWalign=32, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
[    0.000000] Hierarchical RCU implementation.
[    0.000000] 	RCU-based detection of stalled CPUs is disabled.
[    0.000000] 	Verbose stalled-CPUs detection is disabled.
[    0.000000] NR_IRQS:64
[    0.000000] Console: colour dummy device 80x30
[    0.000206] Calibrating delay loop... 498.07 BogoMIPS (lpj=2490368)
[    0.250060] pid_max: default: 32768 minimum: 301
[    0.250173] Security Framework initialized
[    0.250207] SELinux:  Disabled at boot.
[    0.250270] Mount-cache hash table entries: 512
[    0.250890] Initializing cgroup subsys ns
[    0.250921] Initializing cgroup subsys cpuacct
[    0.250944] Initializing cgroup subsys devices
[    0.250966] Initializing cgroup subsys freezer
[    0.250987] Initializing cgroup subsys net_cls
[    0.251008] Initializing cgroup subsys blkio
[    0.251146] CPU: Testing write buffer coherency: ok
[    0.253268] devtmpfs: initialized
[    0.255098] regulator: core version 0.5
[    0.255417] NET: Registered protocol family 16
[    0.256459] Orion ID: MV88F5281-D0. TCLK=166666667.
[    0.256491] Orion: Applying 5281 D0 WFI workaround.
[    0.318428] pci 0000:00:00.0: reg 10: [mem 0xf1000000-0xf10fffff 64bit pref]
[    0.318467] pci 0000:00:00.0: reg 18: [mem 0x00000000-0x1fffffff]
[    0.318602] pci 0000:00:01.0: reg 10: [mem 0x40000000-0x400fffff 64bit]
[    0.318643] pci 0000:00:01.0: reg 18: [io  0xf0000000-0xf00000ff]
[    0.318796] PCI: bus0: Fast back to back transfers disabled
[    0.319473] pci 0000:01:00.0: reg 10: [mem 0x00000000-0x0fffffff 64bit pref]
[    0.319519] pci 0000:01:00.0: reg 18: [mem 0x10000000-0x1fffffff 64bit pref]
[    0.319562] pci 0000:01:00.0: reg 20: [mem 0xf1000000-0xf10fffff 64bit]
[    0.319600] pci 0000:01:00.0: reg 30: [mem 0xe0000000-0xe7ffffff pref]
[    0.319656] pci 0000:01:00.0: supports D1 D2
[    0.319683] pci 0000:01:00.0: PME# supported from D0 D1 D2 D3hot
[    0.319710] pci 0000:01:00.0: PME# disabled
[    0.319815] PCI: bus1: Fast back to back transfers enabled
[    0.320145] pci 0000:00:01.0: BAR 0: assigned [mem 0xe0000000-0xe00fffff 64bit]
[    0.320196] pci 0000:00:01.0: BAR 0: set to [mem 0xe0000000-0xe00fffff 64bit] (PCI address [0xe0000000-0xe00fffff]
[    0.320238] pci 0000:00:01.0: BAR 2: assigned [io  0x1000-0x10ff]
[    0.320277] pci 0000:00:01.0: BAR 2: set to [io  0x1000-0x10ff] (PCI address [0x1000-0x10ff]
[    0.323649] bio: create slab <bio-0> at 0
[    0.324407] vgaarb: loaded
[    0.325881] Switching to clocksource orion_clocksource
[    0.347326] NET: Registered protocol family 2
[    0.347622] IP route cache hash table entries: 2048 (order: 1, 8192 bytes)
[    0.348634] TCP established hash table entries: 8192 (order: 4, 65536 bytes)
[    0.349064] TCP bind hash table entries: 8192 (order: 3, 32768 bytes)
[    0.349278] TCP: Hash tables configured (established 8192 bind 8192)
[    0.349301] TCP reno registered
[    0.349330] UDP hash table entries: 256 (order: 0, 4096 bytes)
[    0.349385] UDP-Lite hash table entries: 256 (order: 0, 4096 bytes)
[    0.349753] NET: Registered protocol family 1
[    0.349860] PCI: CLS 32 bytes, default 32
[    0.350137] Unpacking initramfs...
[    1.059077] Freeing initrd memory: 4092K
[    1.059241] NetWinder Floating Point Emulator V0.97 (double precision)
[    1.059900] audit: initializing netlink socket (disabled)
[    1.059976] type=2000 audit(1.050:1): initialized
[    1.076074] VFS: Disk quotas dquot_6.5.2
[    1.076572] Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
[    1.076844] msgmni has been set to 499
[    1.078256] alg: No test for stdrng (krng)
[    1.078887] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 253)
[    1.078922] io scheduler noop registered
[    1.078943] io scheduler deadline registered
[    1.079058] io scheduler cfq registered (default)
[    1.079765] Serial: 8250/16550 driver, 2 ports, IRQ sharing disabled
[    1.100799] serial8250.0: ttyS0 at MMIO 0xf1012000 (irq = 3) is a 16550A
[    1.565987] console [ttyS0] enabled
[    1.590160] serial8250.1: ttyS1 at MMIO 0xf1012100 (irq = 4) is a 16550A
[    1.598060] physmap platform flash device: 00800000 at ff800000
[    1.604222] physmap-flash.0: Found 1 x16 devices at 0x0 in 8-bit bank. Manufacturer ID 0x000089 Chip ID 0x000017
[    1.614463] Intel/Sharp Extended Query Table at 0x0031
[    1.619637] Intel/Sharp Extended Query Table at 0x0031
[    1.624777] Using buffer write method
[    1.628455] cfi_cmdset_0001: Erase suspend on write enabled
[    1.634059] erase region 0: offset=0x0,size=0x20000,blocks=64
[    1.676708] RedBoot partition parsing not available
[    1.681583] Using physmap partition information
[    1.686171] Creating 6 MTD partitions on "physmap-flash.0":
[    1.691815] 0x000000780000-0x000000800000 : "U-Boot"
[    1.698518] 0x000000000000-0x000000200000 : "Kernel"
[    1.705086] 0x000000200000-0x000000600000 : "RootFS1"
[    1.711874] 0x000000600000-0x000000700000 : "RootFS2"
[    1.718718] 0x000000760000-0x000000780000 : "U-Boot Config"
[    1.726027] 0x000000700000-0x000000760000 : "NAS Config"
[    1.733739] mice: PS/2 mouse device common for all mice
[    1.739645] i2c /dev entries driver
[    1.746400] rtc-s35390a 0-0030: rtc core: registered rtc-s35390a as rtc0
[    1.753648] Registered led device: ts409:red:sata1
[    1.753795] Registered led device: ts409:red:sata2
[    1.753959] Registered led device: ts409:red:sata3
[    1.754104] Registered led device: ts409:red:sata4
[    1.755740] TCP cubic registered
[    1.759032] NET: Registered protocol family 17
[    1.763499] Registering the dns_resolver key type
[    1.768274] VFP support v0.3: implementor 41 architecture 1 part 10 variant 9 rev 0
[    1.776729] registered taskstats version 1
[    1.781888] rtc-s35390a 0-0030: setting system clock to 2010-10-30 15:08:15 UTC (1288451295)
[    1.790350] Initalizing network drop monitor service
[    1.795650] Freeing init memory: 132K
[    2.306087] SCSI subsystem initialized
[    2.515201] libata version 3.00 loaded.
[    2.560129] sata_mv 0000:00:01.0: version 1.28
[    2.565364] sata_mv 0000:00:01.0: Gen-IIE 32 slots 4 ports SCSI mode IRQ via INTx
[    2.576375] scsi0 : sata_mv
[    2.579870] scsi1 : sata_mv
[    2.583182] scsi2 : sata_mv
[    2.586554] scsi3 : sata_mv
[    2.589693] ata1: SATA max UDMA/133 mmio m1048576@0xe0000000 port 0xe0022000 irq 11
[    2.597392] ata2: SATA max UDMA/133 mmio m1048576@0xe0000000 port 0xe0024000 irq 11
[    2.605039] ata3: SATA max UDMA/133 mmio m1048576@0xe0000000 port 0xe0026000 irq 11
[    2.612715] ata4: SATA max UDMA/133 mmio m1048576@0xe0000000 port 0xe0028000 irq 11
[    5.466005] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    5.486491] ata1.00: ATA-7: SAMSUNG HD154UI, 1AG01118, max UDMA7
[    5.492500] ata1.00: 2930277168 sectors, multi 0: LBA48 NCQ (depth 31/32)
[    5.516501] ata1.00: configured for UDMA/133
[    5.521408] scsi 0:0:0:0: Direct-Access     ATA      SAMSUNG HD154UI  1AG0 PQ: 0 ANSI: 5
[    6.036009] ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    6.056487] ata2.00: ATA-7: SAMSUNG HD154UI, 1AG01118, max UDMA7
[    6.062490] ata2.00: 2930277168 sectors, multi 0: LBA48 NCQ (depth 31/32)
[    6.086501] ata2.00: configured for UDMA/133
[    6.091417] scsi 1:0:0:0: Direct-Access     ATA      SAMSUNG HD154UI  1AG0 PQ: 0 ANSI: 5
[    8.553670] ata2: exception Emask 0x10 SAct 0x0 SErr 0x180000 action 0x6 frozen
[    8.561052] ata2: edma_err_cause=00000020 pp_flags=00000000, SError=00180000
[    8.568129] ata2: SError: { 10B8B Dispar }
[    8.572245] ata2: hard resetting link
[    8.576420] ata1: exception Emask 0x10 SAct 0x0 SErr 0x190002 action 0xe frozen
[    8.583713] ata1: edma_err_cause=00000028 pp_flags=00000000, dev disconnect, SError=00190002
[    8.592185] ata1: SError: { RecovComm PHYRdyChg 10B8B Dispar }
[    8.598065] ata1: hard resetting link
[    8.602256] ata3: SATA link down (SStatus 0 SControl 300)
[    8.607693] ata3.00: link offline, clearing class 1 to NONE
[    8.936010] ata2: SATA link down (SStatus 0 SControl 300)
[    8.955985] ata4: SATA link down (SStatus 0 SControl 300)
[    9.143494] udevd (95): /proc/95/oom_adj is deprecated, please use /proc/95/oom_score_adj instead.
[    9.346108] ata1: SATA link down (SStatus 0 SControl 300)
[    9.532495] ata2: hard resetting link
[    9.536755] ata4: exception Emask 0x10 SAct 0x0 SErr 0x4010000 action 0xe frozen
[    9.544179] ata4: edma_err_cause=00000010 pp_flags=00000000, dev connect
[    9.550972] ata4: SError: { PHYRdyChg DevExch }
[    9.555531] ata4: hard resetting link
[    9.559703] ata1: hard resetting link
[   10.556099] ata4: SATA link down (SStatus 0 SControl 300)
[   10.561526] ata4: EH complete
[   15.095971] ata2: link is slow to respond, please be patient (ready=0)
[   15.105968] ata1: link is slow to respond, please be patient (ready=0)
[   15.396034] ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[   15.436541] ata2.00: configured for UDMA/133
[   15.440829] ata2: EH complete
[   15.444252] sd 1:0:0:0: [sdb] 2930277168 512-byte logical blocks: (1.50 TB/1.36 TiB)
[   15.452088] sd 1:0:0:0: [sdb] 2930277168 512-byte logical blocks: (1.50 TB/1.36 TiB)
[   15.461205] sd 1:0:0:0: [sdb] Write Protect is off
[   15.466062] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[   15.466126] sd 1:0:0:0: [sdb] Write Protect is off
[   15.470914] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[   15.471502] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   15.480614] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   15.526014] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[   15.566532] ata1.00: configured for UDMA/133
[   15.570821] ata1: EH complete
[   15.574236] sd 0:0:0:0: [sda] 2930277168 512-byte logical blocks: (1.50 TB/1.36 TiB)
[   15.582063] sd 0:0:0:0: [sda] 2930277168 512-byte logical blocks: (1.50 TB/1.36 TiB)
[   15.591258] sd 0:0:0:0: [sda] Write Protect is off
[   15.596108] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[   15.596155] sd 0:0:0:0: [sda] Write Protect is off
[   15.600947] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[   15.601526] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   15.610633] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   15.619723] sda: detected capacity change from 0 to 1500301910016
[   15.798337]  sdb: sdb1 sdb2 sdb3 sdb4
[   15.812915] sd 1:0:0:0: [sdb] Attached SCSI disk
[   15.918209]  sda: sda1 sda2 sda3 sda4
[   15.932602] sd 0:0:0:0: [sda] Attached SCSI disk
[   18.188864] md: raid1 personality registered for level 1
[   18.232368] async_tx: api initialized (async)
[   18.259116] xor: measuring software checksum speed
[   18.305954]    arm4regs  :   429.200 MB/sec
[   18.355946]    8regs     :   377.200 MB/sec
[   18.405947]    32regs    :   416.800 MB/sec
[   18.410126] xor: using function: arm4regs (429.200 MB/sec)
[   18.608260] raid6: int32x1     24 MB/s
[   18.777138] raid6: int32x2     35 MB/s
[   18.946589] raid6: int32x4     46 MB/s
[   19.116996] raid6: int32x8     42 MB/s
[   19.120745] raid6: using algorithm int32x4 (46 MB/s)
[   19.219955] md: raid6 personality registered for level 6
[   19.225264] md: raid5 personality registered for level 5
[   19.230629] md: raid4 personality registered for level 4
[   19.313616] md: md0 stopped.
[   19.370020] md: bind<sdb1>
[   19.373267] md: bind<sda1>
[   19.400784] md/raid1:md0: active with 2 out of 2 mirrors
[   19.406383] md0: detected capacity change from 0 to 1998585856
[   19.422055] md: md1 stopped.
[   19.453249]  md0: unknown partition table
[   19.661258] md: md2 stopped.
[   19.804425] md: bind<sdb2>
[   19.807853] md: bind<sda2>
[   19.840099] md/raid:md2: device sda2 operational as raid disk 0
[   19.846087] md/raid:md2: device sdb2 operational as raid disk 1
[   19.860428] md/raid:md2: allocated 4228kB
[   19.864626] md/raid:md2: not enough operational devices (2/4 failed)
[   19.871095] RAID conf printout:
[   19.871119]  --- level:5 rd:4 wd:2
[   19.871144]  disk 0, o:1, dev:sda2
[   19.871169]  disk 1, o:1, dev:sdb2
[   19.874995] md/raid:md2: failed to run raid set.
[   19.879704] md: pers->run() failed ...
[   19.892505] md: md3 stopped.
[   19.941276] md: bind<sdb3>
[   19.944544] md: bind<sda3>
[   19.976850] md/raid:md3: device sda3 operational as raid disk 0
[   19.982773] md/raid:md3: device sdb3 operational as raid disk 1
[   19.993689] md/raid:md3: allocated 4228kB
[   20.001396] md/raid:md3: not enough operational devices (2/4 failed)
[   20.007857] RAID conf printout:
[   20.007880]  --- level:5 rd:4 wd:2
[   20.007905]  disk 0, o:1, dev:sda3
[   20.007929]  disk 1, o:1, dev:sdb3
[   20.011710] md/raid:md3: failed to run raid set.
[   20.016415] md: pers->run() failed ...
[   20.314285] device-mapper: uevent: version 1.0.3
[   20.332951] device-mapper: ioctl: 4.18.0-ioctl (2010-06-29) initialised: dm-devel@redhat.com
[   20.825841] EXT3-fs: barriers not enabled
[   21.133650] kjournald starting.  Commit interval 5 seconds
[   21.536543] EXT3-fs (md0): using internal journal
[   21.541274] EXT3-fs (md0): mounted filesystem with ordered data mode
[   30.690249] NET: Registered protocol family 10
[   30.696959] lo: Disabled Privacy Extensions
[   31.159930] udevd version 125 started
[   41.033767] MV-643xx 10/100/1000 ethernet driver version 1.4
[   41.047318] mv643xx_eth smi: probed
[   41.144352] usbcore: registered new interface driver usbfs
[   41.189195] usbcore: registered new interface driver hub
[   41.206240] usbcore: registered new device driver usb
[   41.336049] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[   41.962264] net eth0: port 0 with MAC address 00:00:00:00:51:81
[   41.968393] orion-ehci orion-ehci.0: Marvell Orion EHCI
[   41.973723] orion-ehci orion-ehci.0: new USB bus registered, assigned bus number 1
[   42.056129] orion-ehci orion-ehci.0: irq 17, io mem 0xf1050000
[   42.076101] orion-ehci orion-ehci.0: USB 2.0 started, EHCI 1.00
[   42.082122] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
[   42.088985] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   42.096224] usb usb1: Product: Marvell Orion EHCI
[   42.100919] usb usb1: Manufacturer: Linux 2.6.36-trunk-orion5x ehci_hcd
[   42.107556] usb usb1: SerialNumber: orion-ehci.0
[   42.135727] hub 1-0:1.0: USB hub found
[   42.139595] hub 1-0:1.0: 1 port detected
[   42.148622] input: gpio-keys as /devices/platform/gpio-keys/input/input0
[   42.466128] usb 1-1: new high speed USB device using orion-ehci and address 2
[   42.647778] usb 1-1: New USB device found, idVendor=05e3, idProduct=0608
[   42.654481] usb 1-1: New USB device strings: Mfr=0, Product=1, SerialNumber=0
[   42.661653] usb 1-1: Product: USB2.0 Hub
[   42.731964] hub 1-1:1.0: USB hub found
[   42.756058] hub 1-1:1.0: 4 ports detected
[   43.076486] usb 1-1.1: new full speed USB device using orion-ehci and address 3
[   43.326829] usb 1-1.1: New USB device found, idVendor=04f9, idProduct=000e
[   43.333708] usb 1-1.1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[   43.341051] usb 1-1.1: Product: HL-1450 series
[   43.345494] usb 1-1.1: Manufacturer: Brother
[   43.349837] usb 1-1.1: SerialNumber: K2J988892
[   44.745740] usbcore: registered new interface driver usbserial
[   44.786235] USB Serial support registered for generic
[   44.825707] usbcore: registered new interface driver usbserial_generic
[   44.832313] usbserial: USB Serial Driver core
[   45.096249] USB Serial support registered for GSM modem (1-port)
[   45.149205] usbcore: registered new interface driver option
[   45.154775] option: v0.7.2:USB Driver for GSM modems
[   45.731518] usblp0: USB Bidirectional printer dev 3 if 0 alt 0 proto 2 vid 0x04F9 pid 0x000E
[   45.774213] usbcore: registered new interface driver usblp
[   49.552436] loop: module loaded
[   50.521884] md: md1 stopped.
[   54.239048] ADDRCONF(NETDEV_UP): eth0: link is not ready
[   57.415844] eth0: link up, 1000 Mb/s, full duplex, flow control disabled
[   57.422740] ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
[   69.652809] RPC: Registered udp transport module.
[   69.657581] RPC: Registered tcp transport module.
[   69.662283] RPC: Registered tcp NFSv4.1 backchannel transport module.
[   70.091345] FS-Cache: Loaded
[   70.346094] FS-Cache: Netfs 'nfs' registered for caching
[   70.880988] Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
[   92.940116] IPv6 over IPv4 tunneling driver
[   92.957196] sit0: Disabled Privacy Extensions
[   93.365047] tun: Universal TUN/TAP device driver, 1.6
[   93.370097] tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
[   94.074868] sixxs: Disabled Privacy Extensions
[  102.758107] svc: failed to register lockdv1 RPC service (errno 97).
[  102.765721] NFSD: Using /var/lib/nfs/v4recovery as the NFSv4 state recovery directory
[  102.786784] NFSD: starting 90-second grace period
[  110.268269] warning: `ntpd' uses 32-bit capabilities (legacy support in use)

--AqsLC8rIMeq19msA--
