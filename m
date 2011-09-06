From: Hector Oron <hector.oron@gmail.com>
Subject: Re: [PATCH V7 1/5] AHCI Add the AHCI SATA feature on the MX53 platforms
Date: Tue, 6 Sep 2011 09:46:33 +0100
Message-ID: <CAODfWeHTRuFZtnYZOD-mFonyjBvjhid4=0=a_mYXdjXAOQYejA@mail.gmail.com>
References: <1314698171-7937-1-git-send-email-richard.zhu@linaro.org>
	<CAODfWeEm8bkySXxb1qopbH1VMu-V+33k5x+0+qjABzesT0amOA@mail.gmail.com>
	<CAJNCFV+XFGEba1J2dXDa4YVwqduAPV5y=5JYEXAZ0uv+S60vvw@mail.gmail.com>
	<CAODfWeEueF45_yvPV5Zxbva6K2gEfKZbY2qoqySYFPZWnSgLsg@mail.gmail.com>
	<CAJNCFVLP7gA_7vBjwVNkQaSg8LZ4hROLdNCx8SBVah=F1ptrhQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:43605 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753296Ab1IFIqe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 6 Sep 2011 04:46:34 -0400
Received: by qyk34 with SMTP id 34so3554715qyk.19
        for <linux-ide@vger.kernel.org>; Tue, 06 Sep 2011 01:46:33 -0700 (PDT)
In-Reply-To: <CAJNCFVLP7gA_7vBjwVNkQaSg8LZ4hROLdNCx8SBVah=F1ptrhQ@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Richard Zhu <richard.zhu@linaro.org>
Cc: Wolfram Sang <w.sang@pengutronix.de>, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de, eric.miao@linaro.org, linux-ide@vger.kernel.org, eric@eukrea.com, avorontsov@ru.mvista.com, jgarzik@pobox.com

Hi,

2011/9/1 Richard Zhu <richard.zhu@linaro.org>:
> Hi Hector:
> What's happen before "> [ =C2=A0 =C2=A07.073106] EXT4-fs (sda2): re-m=
ounted.
> Opts: errors=3Dremount-ro"?

Here is my complete dmesg. The system seems to work fine, it is a
1.0TB WD10TPVT SATA disk in a case which provides eSATA and connected
to mx53 LOCO with eSATA-to-SATA cable. I have around a Lacie eSATA
disk which I might attempt to connect.

Linux version 3.1.0-rc3-mx5 (zumbi@enorme) (gcc version 4.4.5 (Debian
4.4.5-8) ) #7 Tue Aug 30 13:17:14 BST 2011
CPU: ARMv7 Processor [412fc085] revision 5 (ARMv7), cr=3D10c53c7f
CPU: VIPT nonaliasing data cache, VIPT aliasing instruction cache
Machine: Freescale MX53 LOCO Board
Ignoring RAM at b0000000-cfffffff (vmalloc region overlap).
Memory policy: ECC disabled, Data cache writeback
On node 0 totalpages: 131072
free_area_init_node: node 0, pgdat c0461e08, node_mem_map c04b2000
  Normal zone: 1024 pages used for memmap
  Normal zone: 0 pages reserved
  Normal zone: 130048 pages, LIFO batch:31
pcpu-alloc: s0 r0 d32768 u32768 alloc=3D1*32768
pcpu-alloc: [0] 0
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 13=
0048
Kernel command line: console=3Dttymxc0,115200 console=3Dtty1
root=3D/dev/sda2 video=3Dmxcdi1fb:GBR24,XGA di1_primary tve  printk.tim=
e=3D1
[    0.000000] PID hash table entries: 2048 (order: 1, 8192 bytes)
[    0.000000] Dentry cache hash table entries: 65536 (order: 6, 262144=
 bytes)
[    0.000000] Inode-cache hash table entries: 32768 (order: 5, 131072 =
bytes)
[    0.000000] Memory: 512MB =3D 512MB total
[    0.000000] Memory: 514948k/514948k available, 9340k reserved, 0K hi=
ghmem
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
[    0.000000]     DMA     : 0xffc00000 - 0xffe00000   (   2 MB)
[    0.000000]     vmalloc : 0xe0800000 - 0xf4000000   ( 312 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xe0000000   ( 512 MB)
[    0.000000]     modules : 0xbf000000 - 0xc0000000   (  16 MB)
[    0.000000]       .text : 0xc0008000 - 0xc0412000   (4136 kB)
[    0.000000]       .init : 0xc0412000 - 0xc0437000   ( 148 kB)
[    0.000000]       .data : 0xc0438000 - 0xc0462480   ( 170 kB)
[    0.000000]        .bss : 0xc04624a4 - 0xc04b1380   ( 316 kB)
[    0.000000] SLUB: Genslabs=3D11, HWalign=3D64, Order=3D0-3, MinObjec=
ts=3D0,
CPUs=3D1, Nodes=3D1
[    0.000000] NR_IRQS:400
[    0.000000] TrustZone Interrupt Controller (TZIC) initialized
[    0.000000] CPU identified as i.MX53, silicon rev 2.1
[    0.000000] sched_clock: 32 bits at 55MHz, resolution 18ns, wraps
every 77386ms
[    0.000000] Console: colour dummy device 80x30
[    0.000000] console [tty1] enabled
[    0.000556] Calibrating delay loop... 795.44 BogoMIPS (lpj=3D3977216=
)
[    0.040182] pid_max: default: 32768 minimum: 301
[    0.040450] Mount-cache hash table entries: 512
[    0.041059] CPU: Testing write buffer coherency: ok
[    0.042459] devtmpfs: initialized
[    0.044791] print_constraints: dummy:
[    0.045120] NET: Registered protocol family 16
[    0.065856] bio: create slab <bio-0> at 0
[    0.067168] SCSI subsystem initialized
[    0.067580] libata version 3.00 loaded.
[    0.067989] usbcore: registered new interface driver usbfs
[    0.068174] usbcore: registered new interface driver hub
[    0.068488] usbcore: registered new device driver usb
[    0.070182] Switching to clocksource mxc_timer1
[    0.080403] Switched to NOHz mode on CPU #0
[    0.088737] NET: Registered protocol family 2
[    0.089034] IP route cache hash table entries: 4096 (order: 2, 16384=
 bytes)
[    0.089503] TCP established hash table entries: 16384 (order: 5,
131072 bytes)
[    0.089861] TCP bind hash table entries: 16384 (order: 4, 65536 byte=
s)
[    0.090067] TCP: Hash tables configured (established 16384 bind 1638=
4)
[    0.090096] TCP reno registered
[    0.090128] UDP hash table entries: 256 (order: 0, 4096 bytes)
[    0.090168] UDP-Lite hash table entries: 256 (order: 0, 4096 bytes)
[    0.090626] NET: Registered protocol family 1
[    0.091318] RPC: Registered named UNIX socket transport module.
[    0.091381] RPC: Registered udp transport module.
[    0.091407] RPC: Registered tcp transport module.
[    0.091429] RPC: Registered tcp NFSv4.1 backchannel transport module=
=2E
[    0.115113] VFS: Disk quotas dquot_6.5.2
[    0.115483] Dquot-cache hash table entries: 1024 (order 0, 4096 byte=
s)
[    0.120839] fuse init (API version 7.16)
[    0.121919] msgmni has been set to 1005
[    0.122544] Block layer SCSI generic (bsg) driver version 0.4
loaded (major 253)
[    0.122618] io scheduler noop registered
[    0.122646] io scheduler deadline registered
[    0.122920] io scheduler cfq registered (default)
[    0.123527] Serial: IMX driver
[    0.123787] imx21-uart.0: ttymxc0 at MMIO 0x53fbc000 (irq =3D 31) is=
 a IMX
[    0.489212] console [ttymxc0] enabled
[    0.502624] brd: module loaded
[    0.511401] loop: module loaded
[    0.515060] nbd: registered device at major 43
[    0.532271] ahci: SSS flag set, parallel bus scan disabled
[    0.537878] ahci imx53-ahci.0: AHCI 0001.0100 32 slots 1 ports 3
Gbps 0x1 impl platform mode
[    0.546452] ahci imx53-ahci.0: flags: ncq sntf stag pm led clo only
pmp pio slum part ccc
[    0.556008] scsi0 : ahci_platform
[    0.560052] ata1: SATA max UDMA/133 mmio [mem
0x10000000-0x10000fff] port 0x100 irq 28
[    0.568788] FEC Ethernet Driver
[    0.575892] fec_enet_mii_bus: probed
[    0.580170] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driv=
er
[    0.587109] Initializing USB Mass Storage driver...
[    0.592309] usbcore: registered new interface driver usb-storage
[    0.598353] USB Mass Storage support registered.
[    0.603499] mousedev: PS/2 mouse device common for all mice
[    0.609483] i2c /dev entries driver
[    0.614322] imx2-wdt imx2-wdt.0: IMX2+ Watchdog Timer enabled.
timeout=3D60s (nowayout=3D0)
[    0.623615] device-mapper: uevent: version 1.0.3
[    0.629223] device-mapper: ioctl: 4.21.0-ioctl (2011-07-06)
initialised: dm-devel@redhat.com
[    0.637827] sdhci: Secure Digital Host Controller Interface driver
[    0.644080] sdhci: Copyright(c) Pierre Ossman
[    0.648461] sdhci-pltfm: SDHCI platform and OF driver helper
[    0.654585] mmc0: no vmmc regulator found
[    0.658808] Registered led device: mmc0::
[    0.659016] mmc0: SDHCI controller on sdhci-esdhc-imx53.0
[sdhci-esdhc-imx53.0] using DMA
[    0.667691] mmc1: no vmmc regulator found
[    0.672020] Registered led device: mmc1::
[    0.672265] mmc1: SDHCI controller on sdhci-esdhc-imx53.2
[sdhci-esdhc-imx53.2] using DMA
[    0.681037] usbcore: registered new interface driver usbhid
[    0.686655] usbhid: USB HID core driver
[    0.790254] TCP cubic registered
[    0.793596] NET: Registered protocol family 17
[    0.798190] Registering the dns_resolver key type
[    0.803078] VFP support v0.3: implementor 41 architecture 3 part 30
variant c rev 2
[    0.813279] input: gpio-keys as /devices/platform/gpio-keys/input/in=
put0
[    0.820805] drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
[    0.863099] mmc0: host does not support reading read-only switch.
assuming write-enable.
[    0.970967] mmc0: new SD card at address 1234
[    1.540405] ata1: softreset failed (device not ready)
[    1.545514] ata1: applying PMP SRST workaround and retrying
[    1.750408] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    1.764169] ata1.00: ATA-8: WDC WD10TPVT-00U4RT1, 01.01A01, max UDMA=
/133
[    1.770981] ata1.00: 1953525168 sectors, multi 0: LBA48 NCQ (depth 3=
1/32)
[    1.786154] ata1.00: configured for UDMA/133
[    1.791272] scsi 0:0:0:0: Direct-Access     ATA      WDC
WD10TPVT-00U 01.0 PQ: 0 ANSI: 5
[    1.800460] sd 0:0:0:0: [sda] 1953525168 512-byte logical blocks:
(1.00 TB/931 GiB)
[    1.808190] sd 0:0:0:0: [sda] 4096-byte physical blocks
[    1.815016] sd 0:0:0:0: [sda] Write Protect is off
[    1.819878] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    1.820201] sd 0:0:0:0: [sda] Write cache: enabled, read cache:
enabled, doesn't support DPO or FUA
[    1.856631]  sda: sda1 sda2 sda3 sda4
[    1.863666] sd 0:0:0:0: [sda] Attached SCSI disk
[    1.880189] EXT3-fs (sda2): error: couldn't mount because of
unsupported optional features (240)
[    1.890482] EXT2-fs (sda2): error: couldn't mount because of
unsupported optional features (240)
[    1.932146] EXT4-fs (sda2): warning: maximal mount count reached,
running e2fsck is recommended
[    1.959428] EXT4-fs (sda2): mounted filesystem with ordered data
mode. Opts: (null)
[    1.967300] VFS: Mounted root (ext4 filesystem) on device 8:2.
[    1.989215] devtmpfs: mounted
[    1.992660] Freeing init memory: 148K
[    3.913577] udev[67]: starting version 164
[    4.877589] mmcblk0: mmc0:1234 SA02G 1.83 GiB
[    5.040661]  mmcblk0: p1 p2 p3
[    6.847039] Adding 9767516k swap on /dev/sda3.  Priority:-1
extents:1 across:9767516k
[    6.987841] EXT4-fs (sda2): re-mounted. Opts: errors=3Dremount-ro
[   13.647889] kjournald starting.  Commit interval 5 seconds
[   13.654619] EXT3-fs (dm-0): using internal journal
[   13.659490] EXT3-fs (dm-0): mounted filesystem with ordered data mod=
e
[   15.143077] eth0: Freescale FEC PHY driver [Generic PHY]
(mii_bus:phy_addr=3D1:00, irq=3D-1)
[   17.140873] PHY: 1:00 - Link is Up - 100/Full
[   17.329274] kjournald starting.  Commit interval 5 seconds
[   17.335840] EXT3-fs (dm-3): using internal journal
[   17.340799] EXT3-fs (dm-3): mounted filesystem with ordered data mod=
e
[   33.313977] sshd (855): /proc/855/oom_adj is deprecated, please use
/proc/855/oom_score_adj instead.
[ 3867.337774] kjournald starting.  Commit interval 5 seconds
[ 3867.344328] EXT3-fs (dm-7): using internal journal
[ 3867.349195] EXT3-fs (dm-7): mounted filesystem with ordered data mod=
e
[ 3882.857122] ata1.00: exception Emask 0x12 SAct 0x1 SErr 0x1280501
action 0x6 frozen
[ 3882.864931] ata1.00: irq_stat 0x08000000, interface fatal error
[ 3882.870928] ata1: SError: { RecovData UnrecovData Proto 10B8B
BadCRC TrStaTrns }
[ 3882.878367] ata1.00: failed command: READ FPDMA QUEUED
[ 3882.883582] ata1.00: cmd 60/c8:00:d0:8a:c4/00:00:0f:00:00/40 tag 0
ncq 102400 in
[ 3882.883590]          res 40/00:04:d0:8a:c4/00:00:0f:00:00/40 Emask
0x12 (ATA bus error)
[ 3882.899063] ata1.00: status: { DRDY }
[ 3882.902802] ata1: hard resetting link
[ 3883.870400] ata1: softreset failed (device not ready)
[ 3883.875515] ata1: applying PMP SRST workaround and retrying
[ 3884.080465] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[ 3884.102097] ata1.00: configured for UDMA/133
[ 3884.106635] ata1: EH complete
[ 3934.010542] ata1.00: exception Emask 0x0 SAct 0xff SErr 0x0 action 0=
x6 frozen
[ 3934.017759] ata1.00: failed command: READ FPDMA QUEUED
[ 3934.023030] ata1.00: cmd 60/88:00:18:66:c7/00:00:0f:00:00/40 tag 0
ncq 69632 in
[ 3934.023037]          res 40/00:04:d0:8a:c4/00:00:0f:00:00/40 Emask
0x4 (timeout)
[ 3934.038014] ata1.00: status: { DRDY }
[ 3934.041769] ata1.00: failed command: WRITE FPDMA QUEUED
[ 3934.047042] ata1.00: cmd 61/38:08:d8:2c:5a/00:00:12:00:00/40 tag 1
ncq 28672 out
[ 3934.047051]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask
0x4 (timeout)
[ 3934.062081] ata1.00: status: { DRDY }
[ 3934.065782] ata1.00: failed command: WRITE FPDMA QUEUED
[ 3934.071103] ata1.00: cmd 61/20:10:90:67:90/00:00:09:00:00/40 tag 2
ncq 16384 out
[ 3934.071113]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask
0x4 (timeout)
[ 3934.085984] ata1.00: status: { DRDY }
[ 3934.089671] ata1.00: failed command: WRITE FPDMA QUEUED
[ 3934.094963] ata1.00: cmd 61/08:18:40:a7:8e/00:00:09:00:00/40 tag 3
ncq 4096 out
[ 3934.094971]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask
0x4 (timeout)
[ 3934.109735] ata1.00: status: { DRDY }
[ 3934.113450] ata1.00: failed command: WRITE FPDMA QUEUED
[ 3934.118711] ata1.00: cmd 61/08:20:40:27:8f/00:00:09:00:00/40 tag 4
ncq 4096 out
[ 3934.118721]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask
0x4 (timeout)
[ 3934.133489] ata1.00: status: { DRDY }
[ 3934.137172] ata1.00: failed command: WRITE FPDMA QUEUED
[ 3934.142457] ata1.00: cmd 61/08:28:40:67:8f/00:00:09:00:00/40 tag 5
ncq 4096 out
[ 3934.142465]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask
0x4 (timeout)
[ 3934.157251] ata1.00: status: { DRDY }
[ 3934.160972] ata1.00: failed command: WRITE FPDMA QUEUED
[ 3934.166239] ata1.00: cmd 61/08:30:40:a7:8f/00:00:09:00:00/40 tag 6
ncq 4096 out
[ 3934.166245]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask
0x4 (timeout)
[ 3934.181013] ata1.00: status: { DRDY }
[ 3934.184700] ata1.00: failed command: WRITE FPDMA QUEUED
[ 3934.189959] ata1.00: cmd 61/60:38:4a:f3:e1/00:00:02:00:00/40 tag 7
ncq 49152 out
[ 3934.189966]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask
0x4 (timeout)
[ 3934.204822] ata1.00: status: { DRDY }
[ 3934.208535] ata1: hard resetting link
[ 3935.180443] ata1: softreset failed (device not ready)
[ 3935.185548] ata1: applying PMP SRST workaround and retrying
[ 3935.390417] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[ 3935.412020] ata1.00: configured for UDMA/133
[ 3935.416479] ata1.00: device reported invalid CHS sector 0
[ 3935.421985] ata1.00: device reported invalid CHS sector 0
[ 3935.427424] ata1.00: device reported invalid CHS sector 0
[ 3935.432893] ata1.00: device reported invalid CHS sector 0
[ 3935.438326] ata1.00: device reported invalid CHS sector 0
[ 3935.443788] ata1.00: device reported invalid CHS sector 0
[ 3935.449221] ata1.00: device reported invalid CHS sector 0
[ 3935.454728] ata1: EH complete
[ 3950.155859] ata1.00: exception Emask 0x12 SAct 0x1 SErr 0x80500
action 0x6 frozen
[ 3950.163510] ata1.00: irq_stat 0x08000000, interface fatal error
[ 3950.169469] ata1: SError: { UnrecovData Proto 10B8B }
[ 3950.174597] ata1.00: failed command: READ FPDMA QUEUED
[ 3950.179788] ata1.00: cmd 60/00:00:28:97:71/01:00:0f:00:00/40 tag 0
ncq 131072 in
[ 3950.179796]          res 40/00:04:28:97:71/00:00:0f:00:00/40 Emask
0x12 (ATA bus error)
[ 3950.195275] ata1.00: status: { DRDY }
[ 3950.198992] ata1: hard resetting link
[ 3951.380403] ata1: softreset failed (device not ready)
[ 3951.385523] ata1: applying PMP SRST workaround and retrying
[ 3951.590410] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[ 3951.612472] ata1.00: configured for UDMA/133
[ 3951.617042] ata1: EH complete
[ 3952.305676] ata1: limiting SATA link speed to 1.5 Gbps
[ 3952.310994] ata1.00: exception Emask 0x12 SAct 0x1 SErr 0x1280500
action 0x6 frozen
[ 3952.318692] ata1.00: irq_stat 0x08000000, interface fatal error
[ 3952.324685] ata1: SError: { UnrecovData Proto 10B8B BadCRC TrStaTrns=
 }
[ 3952.331283] ata1.00: failed command: READ FPDMA QUEUED
[ 3952.336469] ata1.00: cmd 60/00:00:28:9f:71/01:00:0f:00:00/40 tag 0
ncq 131072 in
[ 3952.336477]          res 40/00:04:28:9f:71/00:00:0f:00:00/40 Emask
0x12 (ATA bus error)
[ 3952.351953] ata1.00: status: { DRDY }
[ 3952.355667] ata1: hard resetting link
[ 3953.360414] ata1: softreset failed (device not ready)
[ 3953.365537] ata1: applying PMP SRST workaround and retrying
[ 3953.570412] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 3953.592363] ata1.00: configured for UDMA/133
[ 3953.596938] ata1: EH complete
[ 4479.040495] ata1.00: exception Emask 0x0 SAct 0x2 SErr 0x0 action 0x=
6 frozen
[ 4479.047622] ata1.00: failed command: WRITE FPDMA QUEUED
[ 4479.052947] ata1.00: cmd 61/10:08:4a:f9:e1/00:00:02:00:00/40 tag 1
ncq 8192 out
[ 4479.052955]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask
0x4 (timeout)
[ 4479.067740] ata1.00: status: { DRDY }
[ 4479.071480] ata1: hard resetting link
[ 4480.040403] ata1: softreset failed (device not ready)
[ 4480.045513] ata1: applying PMP SRST workaround and retrying
[ 4480.250423] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 4480.272519] ata1.00: configured for UDMA/133
[ 4480.276866] ata1.00: device reported invalid CHS sector 0
[ 4480.282410] ata1: EH complete
[52367.370517] ata1.00: exception Emask 0x10 SAct 0x1 SErr 0x280100
action 0x6 frozen
[52367.378167] ata1.00: irq_stat 0x08000000, interface fatal error
[52367.384188] ata1: SError: { UnrecovData 10B8B BadCRC }
[52367.389366] ata1.00: failed command: READ FPDMA QUEUED
[52367.394582] ata1.00: cmd 60/00:00:fa:c6:36/02:00:00:00:00/40 tag 0
ncq 262144 in
[52367.394592]          res 40/00:04:fa:c6:36/00:00:00:00:00/40 Emask
0x10 (ATA bus error)
[52367.410065] ata1.00: status: { DRDY }
[52367.413800] ata1: hard resetting link
[52368.380402] ata1: softreset failed (device not ready)
[52368.385506] ata1: applying PMP SRST workaround and retrying
[52368.590410] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[52368.612592] ata1.00: configured for UDMA/133
[52368.617347] ata1: EH complete



Best regards,
--=20
=C2=A0H=C3=A9ctor Or=C3=B3n =C2=A0-.. . -... .. .- -. =C2=A0 -.. . ...-=
 . .-.. --- .--. . .-.
