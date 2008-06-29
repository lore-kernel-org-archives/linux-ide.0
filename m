From: "Aneurin Price" <aneurin.price@gmail.com>
Subject: Promise SATA 300 TX2plus: disk stops responding
Date: Sun, 29 Jun 2008 17:14:12 +0100
Message-ID: <501db8660806290914t469ebad6p4dc0b0a189f5aefc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.169]:56481 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753429AbYF2QOO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 29 Jun 2008 12:14:14 -0400
Received: by wf-out-1314.google.com with SMTP id 27so1165539wfd.4
        for <linux-ide@vger.kernel.org>; Sun, 29 Jun 2008 09:14:14 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi all,

I have a 500GB Seagate disk[0] attached to an el-cheapo PCI-plugin
Promise SATA controller[1], which I've had for a couple of years. Every
so often, the disk stops responding and is eventually disabled. I'm
trying to determine whether this is a hardware fault or not - and if so,
whether the disk or the controller is at fault; any insight would be
appreciated.

When the problem happens, the entries for that disk in /dev are removed,
and so far as I know, the only way to restore the disk is by
rebooting. I've tried things like "rmmod sata_promise && modpobe
sata_promise", and restarting udev, because it seemed like a good idea
at the time, but to be honest I haven't a clue what I should be looking
at. After rebooting, the disk works fine again for a while.
I've included the output of dmesg from the most recent occurrence.

The controller card was previously in use in another system without
issue, with a 300GB disk which is otherwise similar (the current disk is
essentially the upgraded model). That system was less frequently left
running for the length of time that the problematic machine is though.

The machine in question acts as a fileserver, which was initially using
Samba to share the disk. A couple of months ago I decided to use
nfs-kernel-server instead, and the disk stopped responding within a few
minutes of starting to access it. Up to that point the machine had had
no disk problems, and IIRC it had had a couple of runs of about a
month's uptime. SMART self-tests *claim* that there's nothing wrong with
the disk, and the problem only seemed to happen in conjuction with NFS,
so I decided to give up on NFS until I had more time to look into it.

Even without using NFS however, the problem occurs occasionally, usually
after about a fortnight of operation. (And to muddy things slightly,
sometimes it can go for at least a few hours even with NFS).

At first I tried making sure that it was adequately cooled, the cables
were all firmly in, etc. I also set the jumper on the disk to limit it
to 1.5gbps, having read about a couple of potential problems with 3gbps
access using some controllers supported by sata_promise [2]. I've even
moved the disk and the controller card into a new machine, to eliminate
any other possible causes, so the problem must be either with the disk,
the controller, some interaction between them, or a software issue.

So, I'm at a loss now when it comes to what to do next. Might there be
any way to re-enable the disk without rebooting? Does anybody have any
suggestions what else I might try, or any idea why NFS seems to trigger
the problem? To be honest, even if the answer is 'this is clearly a
hardware problem. Buy a SATA controller that doesn't suck', then it
would be helpful, because I'm still stuck deciding if it could be
software or not.

Thanks for your time,
Aneurin Price

[0] I believe it is a Barracuda ST3500630AS, but as it's currently
inaccessible I can't be sure until I reboot.

[1] lspci says:
00:09.0 Mass storage controller: Promise Technology, Inc. PDC40775
(SATA 300 TX2plus) (rev 02)
        Subsystem: Promise Technology, Inc. PDC40775 (SATA 300 TX2plus)
        Flags: bus master, 66MHz, medium devsel, latency 72, IRQ 19
        I/O ports at dc00 [size=128]
        I/O ports at d800 [size=256]
        Memory at dfffb000 (32-bit, non-prefetchable) [size=4K]
        Memory at dffc0000 (32-bit, non-prefetchable) [size=128K]
        Expansion ROM at dffe0000 [disabled] [size=32K]
        Capabilities: [60] Power Management version 2


[2] I couldn't find anything quite like my problem, but did find things
like http://marc.info/?l=linux-ide&m=120134441006713&w=2

dmesg output:

[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Linux version 2.6.24-18-server (buildd@terranova) (gcc
version 4.2.3 (Ubuntu 4.2.3-2ubuntu7)) #1 SMP Wed May 28 21:25:52 UTC
2008 (Ubuntu 2.6.24-18.32-server)
[    0.000000] BIOS-provided physical RAM map:
[    0.000000]  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
[    0.000000]  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
[    0.000000]  BIOS-e820: 00000000000ce000 - 00000000000d2000 (reserved)
[    0.000000]  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
[    0.000000]  BIOS-e820: 0000000000100000 - 000000005fbf0000 (usable)
[    0.000000]  BIOS-e820: 000000005fbf0000 - 000000005fbf8000 (ACPI data)
[    0.000000]  BIOS-e820: 000000005fbf8000 - 000000005fc00000 (ACPI NVS)
[    0.000000]  BIOS-e820: 00000000fec00000 - 00000000fed00000 (reserved)
[    0.000000]  BIOS-e820: 00000000fee00000 - 00000000fef00000 (reserved)
[    0.000000]  BIOS-e820: 00000000ffee0000 - 00000000fff00000 (reserved)
[    0.000000]  BIOS-e820: 00000000fffc0000 - 0000000100000000 (reserved)
[    0.000000] 635MB HIGHMEM available.
[    0.000000] 896MB LOWMEM available.
[    0.000000] found SMP MP-table at 000fbd40
[    0.000000] Entering add_active_range(0, 0, 392176) 0 entries of 256 used
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA             0 ->     4096
[    0.000000]   Normal       4096 ->   229376
[    0.000000]   HighMem    229376 ->   392176
[    0.000000] Movable zone start PFN for each node
[    0.000000] early_node_map[1] active PFN ranges
[    0.000000]     0:        0 ->   392176
[    0.000000] On node 0 totalpages: 392176
[    0.000000]   DMA zone: 32 pages used for memmap
[    0.000000]   DMA zone: 0 pages reserved
[    0.000000]   DMA zone: 4064 pages, LIFO batch:0
[    0.000000]   Normal zone: 1760 pages used for memmap
[    0.000000]   Normal zone: 223520 pages, LIFO batch:31
[    0.000000]   HighMem zone: 1271 pages used for memmap
[    0.000000]   HighMem zone: 161529 pages, LIFO batch:31
[    0.000000]   Movable zone: 0 pages used for memmap
[    0.000000] DMI 2.3 present.
[    0.000000] ACPI: RSDP signature @ 0xC00FAA20 checksum 0
[    0.000000] ACPI: RSDP 000FAA20, 0014 (r0 AMI   )
[    0.000000] ACPI: RSDT 5FBF0000, 002C (r1 AMIINT AMIINI09       10
MSFT  100000D)
[    0.000000] ACPI: FACP 5FBF0030, 0081 (r1 AMIINT AMIINI09       11
MSFT  100000D)
[    0.000000] ACPI: DSDT 5FBF0120, 36B9 (r1    SiS      645     1000
MSFT  100000D)
[    0.000000] ACPI: FACS 5FBF8000, 0040
[    0.000000] ACPI: APIC 5FBF00C0, 0054 (r1 AMIINT AMIINI09       11
MSFT  100000D)
[    0.000000] ACPI: PM-Timer IO Port: 0x808
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
[    0.000000] Processor #0 15:2 APIC version 20
[    0.000000] ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, GSI 0-23
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ2 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Enabling APIC mode:  Flat.  Using 1 I/O APICs
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] Allocating PCI resources starting at 60000000 (gap:
5fc00000:9f000000)
[    0.000000] swsusp: Registered nosave memory region:
000000000009f000 - 00000000000a0000
[    0.000000] swsusp: Registered nosave memory region:
00000000000a0000 - 00000000000ce000
[    0.000000] swsusp: Registered nosave memory region:
00000000000ce000 - 00000000000d2000
[    0.000000] swsusp: Registered nosave memory region:
00000000000d2000 - 00000000000f0000
[    0.000000] swsusp: Registered nosave memory region:
00000000000f0000 - 0000000000100000
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.
Total pages: 389113
[    0.000000] Kernel command line:
root=UUID=daf0166e-cb5c-482b-acc1-d9e6c50eb0ce ro quiet splash
[    0.000000] mapped APIC to ffffb000 (fee00000)
[    0.000000] mapped IOAPIC to ffffa000 (fec00000)
[    0.000000] Enabling fast FPU save and restore... done.
[    0.000000] Enabling unmasked SIMD FPU exception support... done.
[    0.000000] Initializing CPU#0
[    0.000000] PID hash table entries: 4096 (order: 12, 16384 bytes)
[    0.000000] Detected 2191.157 MHz processor.
[   19.530051] Console: colour VGA+ 80x25
[   19.530059] console [tty0] enabled
[   19.531401] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
[   19.533539] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
[   19.647591] Memory: 1542896k/1568704k available (2255k kernel code,
24552k reserved, 1032k data, 384k init, 651200k highmem)
[   19.647609] virtual kernel memory layout:
[   19.647611]     fixmap  : 0xfff4c000 - 0xfffff000   ( 716 kB)
[   19.647612]     pkmap   : 0xffc00000 - 0xffe00000   (2048 kB)
[   19.647613]     vmalloc : 0xf8800000 - 0xffbfe000   ( 115 MB)
[   19.647614]     lowmem  : 0xc0000000 - 0xf8000000   ( 896 MB)
[   19.647616]       .init : 0xc043c000 - 0xc049c000   ( 384 kB)
[   19.647617]       .data : 0xc0333fb5 - 0xc0435fe4   (1032 kB)
[   19.647618]       .text : 0xc0100000 - 0xc0333fb5   (2255 kB)
[   19.647622] Checking if this processor honours the WP bit even in
supervisor mode... Ok.
[   19.647741] SLUB: Genslabs=11, HWalign=64, Order=0-1, MinObjects=4,
CPUs=1, Nodes=1
[   19.797674] Calibrating delay using timer specific routine..
4385.47 BogoMIPS (lpj=21927369)
[   19.797754] Security Framework initialized
[   19.797778] SELinux:  Disabled at boot.
[   19.797818] AppArmor: AppArmor initialized
[   19.797828] Failure registering capabilities with primary security module.
[   19.797860] Mount-cache hash table entries: 512
[   19.798201] Initializing cgroup subsys ns
[   19.798219] Initializing cgroup subsys cpuacct
[   19.798254] CPU: After generic identify, caps: bfebfbff 00000000
00000000 00000000 00000400 00000000 00000000 00000000
[   19.798273] CPU: Trace cache: 12K uops, L1 D cache: 8K
[   19.798276] CPU: L2 cache: 128K
[   19.798281] CPU: Hyper-Threading is disabled
[   19.798284] CPU: After all inits, caps: bfebfbff 00000000 00000000
0000b080 00000400 00000000 00000000 00000000
[   19.798305] Compat vDSO mapped to ffffe000.
[   19.798334] Checking 'hlt' instruction... OK.
[   19.838272] SMP alternatives: switching to UP code
[   19.840599] Freeing SMP alternatives: 12k freed
[   19.840860] Early unpacking initramfs... done
[   20.264311] ACPI: Core revision 20070126
[   20.264431] ACPI: Looking for DSDT in initramfs... error, file
/DSDT.aml not found.
[   20.266963] CPU0: Intel(R) Celeron(R) CPU 2.20GHz stepping 07
[   20.267030] Total of 1 processors activated (4385.47 BogoMIPS).
[   20.267157] ENABLING IO-APIC IRQs
[   20.267371] ..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
[   20.487390] Brought up 1 CPUs
[   20.487439] CPU0 attaching sched-domain:
[   20.487446]  domain 0: span 01
[   20.487449]   groups: 01
[   20.488088] net_namespace: 64 bytes
[   20.488109] Booting paravirtualized kernel on bare hardware
[   20.489119] Time: 13:51:57  Date: 06/13/08
[   20.489205] NET: Registered protocol family 16
[   20.490449] EISA bus registered
[   20.490509] ACPI: bus type pci registered
[   20.494963] PCI: PCI BIOS revision 2.10 entry at 0xfdaf1, last bus=1
[   20.494971] PCI: Using configuration type 1
[   20.494976] Setting up standard PCI resources
[   20.506401] ACPI: EC: Look up EC in DSDT
[   20.511362] ACPI: Interpreter enabled
[   20.511377] ACPI: (supports S0 S3 S4 S5)
[   20.511404] ACPI: Using IOAPIC for interrupt routing
[   20.525201] ACPI: PCI Root Bridge [PCI0] (0000:00)
[   20.525637] Enabling SiS 96x SMBus.
[   20.526639] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[   20.532218] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 *10
11 12 14 15)
[   20.532420] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 10
*11 12 14 15)
[   20.532628] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 11
12 14 15) *0, disabled.
[   20.532817] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 10 11
12 14 15) *0, disabled.
[   20.533012] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 *9 10
11 12 14 15)
[   20.533199] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 *10
11 12 14 15)
[   20.533399] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 9 10 11
12 14 15) *0, disabled.
[   20.533590] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 *9 10
11 12 14 15)
[   20.533997] ACPI: Power Resource [URP1] (off)
[   20.534076] ACPI: Power Resource [URP2] (off)
[   20.534150] ACPI: Power Resource [FDDP] (off)
[   20.534220] ACPI: Power Resource [LPTP] (off)
[   20.534471] Linux Plug and Play Support v0.97 (c) Adam Belay
[   20.534670] pnp: PnP ACPI init
[   20.534701] ACPI: bus type pnp registered
[   20.542691] pnp: PnP ACPI: found 11 devices
[   20.542702] ACPI: ACPI bus type pnp unregistered
[   20.542711] PnPBIOS: Disabled by ACPI PNP
[   20.544171] PCI: Using ACPI for IRQ routing
[   20.544185] PCI: If a device doesn't work, try "pci=routeirq".  If
it helps, post a report
[   20.567240] NET: Registered protocol family 8
[   20.567250] NET: Registered protocol family 20
[   20.567460] NetLabel: Initializing
[   20.567467] NetLabel:  domain hash size = 128
[   20.567471] NetLabel:  protocols = UNLABELED CIPSOv4
[   20.567508] NetLabel:  unlabeled traffic allowed by default
[   20.567616] AppArmor: AppArmor Filesystem Enabled
[   20.577137] Time: tsc clocksource has been installed.
[   20.629621] PCI: Bridge: 0000:00:01.0
[   20.629635]   IO window: 2000-3fff
[   20.629643]   MEM window: dfe00000-dfefffff
[   20.629648]   PREFETCH window: cfc00000-dfcfffff
[   20.629701] NET: Registered protocol family 2
[   20.727193] IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
[   20.728004] TCP established hash table entries: 131072 (order: 8,
1048576 bytes)
[   20.730777] TCP bind hash table entries: 65536 (order: 7, 524288 bytes)
[   20.732137] TCP: Hash tables configured (established 131072 bind 65536)
[   20.732149] TCP reno registered
[   20.757376] checking if image is initramfs... it is
[   21.136790] Switched to high resolution mode on CPU 0
[   21.564587] Freeing initrd memory: 7187k freed
[   21.567258] audit: initializing netlink socket (disabled)
[   21.567295] audit(1213365116.810:1): initialized
[   21.567858] highmem bounce pool size: 64 pages
[   21.567873] Total HugeTLB memory allocated, 0
[   21.575956] VFS: Disk quotas dquot_6.5.1
[   21.576273] Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
[   21.577123] io scheduler noop registered
[   21.577132] io scheduler anticipatory registered
[   21.577136] io scheduler deadline registered (default)
[   21.577188] io scheduler cfq registered
[   21.616438] Boot video device is 0000:01:00.0
[   21.617822] isapnp: Scanning for PnP cards...
[   21.974377] isapnp: No Plug & Play device found
[   22.204237] Real Time Clock Driver v1.12ac
[   22.204678] Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports,
IRQ sharing enabled
[   22.205019] serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[   22.205592] serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
[   22.208301] 00:06: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[   22.209577] 00:07: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
[   22.210390] ACPI: PCI Interrupt 0000:00:02.6[C] -> GSI 21 (level,
low) -> IRQ 16
[   22.210406] ACPI: PCI interrupt for device 0000:00:02.6 disabled
[   22.213656] RAMDISK driver initialized: 16 RAM disks of 65536K size
1024 blocksize
[   22.213946] input: Macintosh mouse button emulation as
/devices/virtual/input/input0
[   22.214726] PNP: No PS/2 controller found. Probing ports directly.
[   22.252420] serio: i8042 KBD port at 0x60,0x64 irq 1
[   22.276319] mice: PS/2 mouse device common for all mice
[   22.276967] EISA: Probing bus 0 at eisa.0
[   22.276990] Cannot allocate resource for EISA slot 1
[   22.276995] Cannot allocate resource for EISA slot 2
[   22.276998] Cannot allocate resource for EISA slot 3
[   22.277022] EISA: Detected 0 cards.
[   22.277028] cpuidle: using governor ladder
[   22.277032] cpuidle: using governor menu
[   22.277243] NET: Registered protocol family 1
[   22.277315] Using IPI No-Shortcut mode
[   22.277424] registered taskstats version 1
[   22.277579]   Magic number: 12:692:887
[   22.277716]   hash matches device ptyue
[   22.277794] BIOS EDD facility v0.16 2004-Jun-25, 6 devices found
[   22.279952] Freeing unused kernel memory: 384k freed
[   22.739643] fuse init (API version 7.9)
[   22.795736] ACPI: Thermal Zone [THRM] (10 C)
[   24.016290] usbcore: registered new interface driver usbfs
[   24.016365] usbcore: registered new interface driver hub
[   24.045373] SCSI subsystem initialized
[   24.058527] usbcore: registered new device driver usb
[   24.137260] ohci_hcd: 2006 August 04 USB 1.1 'Open' Host Controller
(OHCI) Driver
[   24.137377] ACPI: PCI Interrupt 0000:00:02.2[D] -> GSI 20 (level,
low) -> IRQ 17
[   24.137415] ohci_hcd 0000:00:02.2: OHCI Host Controller
[   24.138166] ohci_hcd 0000:00:02.2: new USB bus registered, assigned
bus number 1
[   24.138214] ohci_hcd 0000:00:02.2: irq 17, io mem 0xdfffa000
[   24.147056] libata version 3.00 loaded.
[   24.168617] 8139too Fast Ethernet driver 0.9.28
[   24.196968] usb usb1: configuration #1 chosen from 1 choice
[   24.197055] hub 1-0:1.0: USB hub found
[   24.197082] hub 1-0:1.0: 2 ports detected
[   24.257086] Floppy drive(s): fd0 is 1.44M
[   24.278384] FDC 0 is a post-1991 82077
[   24.304730] ACPI: PCI Interrupt 0000:00:02.3[A] -> GSI 23 (level,
low) -> IRQ 18
[   24.304769] ohci_hcd 0000:00:02.3: OHCI Host Controller
[   24.304853] ohci_hcd 0000:00:02.3: new USB bus registered, assigned
bus number 2
[   24.304894] ohci_hcd 0000:00:02.3: irq 18, io mem 0xdfff9000
[   24.366761] usb usb2: configuration #1 chosen from 1 choice
[   24.366839] hub 2-0:1.0: USB hub found
[   24.366862] hub 2-0:1.0: 2 ports detected
[   24.474998] ACPI: PCI Interrupt 0000:00:10.0[A] -> GSI 17 (level,
low) -> IRQ 19
[   24.475874] eth0: RealTek RTL8139 at 0xd400, 00:20:ed:6a:70:28, IRQ 19
[   24.475879] eth0:  Identified 8139 chip type 'RTL-8100B/8139D'
[   24.479455] sata_promise 0000:00:09.0: version 2.11
[   24.479495] ACPI: PCI Interrupt 0000:00:09.0[A] -> GSI 17 (level,
low) -> IRQ 19
[   24.483100] 8139cp: 10/100 PCI Ethernet driver v1.3 (Mar 22, 2004)
[   24.486651] scsi0 : sata_promise
[   24.489369] scsi1 : sata_promise
[   24.490837] scsi2 : sata_promise
[   24.490979] ata1: SATA max UDMA/133 mmio m4096@0xdfffb000 port
0xdfffb200 irq 19
[   24.490986] ata2: SATA max UDMA/133 mmio m4096@0xdfffb000 port
0xdfffb280 irq 19
[   24.490989] ata3: PATA max UDMA/133 mmio m4096@0xdfffb000 port
0xdfffb300 irq 19
[   24.974147] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[   24.994699] ata1.00: ATA-7: ST3500320AS, SD04, max UDMA/133
[   24.994707] ata1.00: 976773168 sectors, multi 0: LBA48 NCQ (depth 0/32)
[   25.034715] ata1.00: configured for UDMA/133
[   25.363788] ata2: SATA link down (SStatus 0 SControl 300)
[   25.524286] scsi 0:0:0:0: Direct-Access     ATA      ST3500320AS
  SD04 PQ: 0 ANSI: 5
[   25.525287] pata_sis 0000:00:02.5: version 0.5.2
[   25.530885] scsi3 : pata_sis
[   25.535308] scsi4 : pata_sis
[   25.536000] ata4: PATA max UDMA/100 cmd 0x1f0 ctl 0x3f6 bmdma 0xff00 irq 14
[   25.536009] ata5: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0xff08 irq 15
[   25.774285] ata4.00: ATA-6: ST360012A, 3.31, max UDMA/100
[   25.774292] ata4.00: 117231408 sectors, multi 16: LBA
[   25.813907] ata4.00: configured for UDMA/100
[   25.814004] ata5: port disabled. ignoring.
[   25.814283] scsi 3:0:0:0: Direct-Access     ATA      ST360012A
  3.31 PQ: 0 ANSI: 5
[   26.094795] Driver 'sd' needs updating - please use bus_type methods
[   26.097381] sd 0:0:0:0: [sda] 976773168 512-byte hardware sectors (500108 MB)
[   26.097482] sd 0:0:0:0: [sda] Write Protect is off
[   26.097488] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[   26.097566] sd 0:0:0:0: [sda] Write cache: enabled, read cache:
enabled, doesn't support DPO or FUA
[   26.097766] sd 0:0:0:0: [sda] 976773168 512-byte hardware sectors (500108 MB)
[   26.097808] sd 0:0:0:0: [sda] Write Protect is off
[   26.097813] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[   26.097876] sd 0:0:0:0: [sda] Write cache: enabled, read cache:
enabled, doesn't support DPO or FUA
[   26.097888]  sda: sda1
[   26.107984] sd 0:0:0:0: [sda] Attached SCSI disk
[   26.108201] sd 3:0:0:0: [sdb] 117231408 512-byte hardware sectors (60022 MB)
[   26.108255] sd 3:0:0:0: [sdb] Write Protect is off
[   26.108260] sd 3:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[   26.108342] sd 3:0:0:0: [sdb] Write cache: enabled, read cache:
enabled, doesn't support DPO or FUA
[   26.108510] sd 3:0:0:0: [sdb] 117231408 512-byte hardware sectors (60022 MB)
[   26.108559] sd 3:0:0:0: [sdb] Write Protect is off
[   26.108564] sd 3:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[   26.108641] sd 3:0:0:0: [sdb] Write cache: enabled, read cache:
enabled, doesn't support DPO or FUA
[   26.108654]  sdb: sdb1 sdb2 < sdb5 >
[   26.148272] sd 3:0:0:0: [sdb] Attached SCSI disk
[   26.168777] sd 0:0:0:0: Attached scsi generic sg0 type 0
[   26.168827] sd 3:0:0:0: Attached scsi generic sg1 type 0
[   32.167392] EXT3-fs: INFO: recovery required on readonly filesystem.
[   32.167401] EXT3-fs: write access will be enabled during recovery.
[   35.550187] kjournald starting.  Commit interval 5 seconds
[   35.550234] EXT3-fs: sdb1: orphan cleanup on readonly fs
[   35.578379] ext3_orphan_cleanup: deleting unreferenced inode 295174
[   35.578442] ext3_orphan_cleanup: deleting unreferenced inode 295173
[   35.578456] ext3_orphan_cleanup: deleting unreferenced inode 295172
[   35.578464] ext3_orphan_cleanup: deleting unreferenced inode 295171
[   35.578737] ext3_orphan_cleanup: deleting unreferenced inode 295092
[   35.578772] EXT3-fs: sdb1: 5 orphan inodes deleted
[   35.578775] EXT3-fs: recovery complete.
[   35.622162] EXT3-fs: mounted filesystem with ordered data mode.
[   41.212454] input: PC Speaker as /devices/platform/pcspkr/input/input1
[   41.623034] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[   41.702021] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[   41.752017] parport_pc 00:08: reported by Plug and Play ACPI
[   41.752140] parport0: PC-style at 0x378 (0x778), irq 7, dma 3
[PCSPP,TRISTATE,COMPAT,EPP,ECP,DMA]
[   42.091671] Linux agpgart interface v0.102
[   42.118851] agpgart: Detected SiS chipset - id:1616
[   42.119518] agpgart: AGP aperture is 4M @ 0xe0000000
[   42.354689] sis96x_smbus 0000:00:02.1: SiS96x SMBus base address: 0x1000
[   42.384266] input: Power Button (FF) as /devices/virtual/input/input2
[   42.421418] ACPI: Power Button (FF) [PWRF]
[   42.421563] input: Power Button (CM) as /devices/virtual/input/input3
[   42.501355] ACPI: Power Button (CM) [PWRB]
[   42.611406] ACPI: PCI Interrupt 0000:00:02.7[C] -> GSI 21 (level,
low) -> IRQ 16
[   43.339089] eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
[   43.460616] intel8x0_measure_ac97_clock: measured 59294 usecs
[   43.460624] intel8x0: clocking to 48000
[   45.043245] NET: Registered protocol family 17
[   47.648090] loop: module loaded
[   47.693422] lp0: using parport0 (interrupt-driven).
[   48.109907] Adding 2433808k swap on /dev/sdb5.  Priority:-1
extents:1 across:2433808k
[   48.477955] EXT3 FS on sdb1, internal journal
[   49.905291] NET: Registered protocol family 10
[   49.905854] lo: Disabled Privacy Extensions
[   51.333434] ip_tables: (C) 2000-2006 Netfilter Core Team
[   60.288552] eth0: no IPv6 routers present
[199962.478058] kjournald starting.  Commit interval 5 seconds
[199962.480334] EXT3 FS on sda1, internal journal
[199962.480350] EXT3-fs: recovery complete.
[199962.481288] EXT3-fs: mounted filesystem with ordered data mode.
[1382260.429883] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action
0x2 frozen
[1382260.429931] ata1.00: cmd 25/00:50:27:6e:cd/00:00:15:00:00/e0 tag
0 dma 40960 in
[1382260.429933]          res 40/00:00:00:00:00/00:00:00:00:00/00
Emask 0x4 (timeout)
[1382260.429956] ata1.00: status: { DRDY }
[1382265.796276] ata1: port is slow to respond, please be patient (Status 0xff)
[1382270.473163] ata1: device not ready (errno=-16), forcing hardreset
[1382270.473179] ata1: hard resetting link
[1382276.679024] ata1: port is slow to respond, please be patient (Status 0xff)
[1382280.476592] ata1: COMRESET failed (errno=-16)
[1382280.476626] ata1: hard resetting link
[1382286.692400] ata1: port is slow to respond, please be patient (Status 0xff)
[1382290.529795] ata1: COMRESET failed (errno=-16)
[1382290.529829] ata1: hard resetting link
[1382296.745702] ata1: port is slow to respond, please be patient (Status 0xff)
[1382325.566448] ata1: COMRESET failed (errno=-16)
[1382325.566484] ata1: limiting SATA link speed to 1.5 Gbps
[1382325.566487] ata1: hard resetting link
[1382330.573112] ata1: COMRESET failed (errno=-16)
[1382330.573146] ata1: reset failed, giving up
[1382330.573162] ata1.00: disabled
[1382330.573188] ata1: exception Emask 0x10 SAct 0x0 SErr 0x190002
action 0xa frozen t4
[1382330.573212] ata1: hotplug_status 0x10
[1382330.573226] ata1: SError: { RecovComm PHYRdyChg 10B8B Dispar }
[1382330.573257] ata1: hard resetting link
[1382337.178714] ata1: port is slow to respond, please be patient (Status 0xff)
[1382340.596435] ata1: COMRESET failed (errno=-16)
[1382340.596471] ata1: hard resetting link
[1382347.202039] ata1: port is slow to respond, please be patient (Status 0xff)
[1382350.619798] ata1: COMRESET failed (errno=-16)
[1382350.619832] ata1: hard resetting link
[1382357.225357] ata1: port is slow to respond, please be patient (Status 0xff)
[1382385.646452] ata1: COMRESET failed (errno=-16)
[1382385.646492] ata1: limiting SATA link speed to 1.5 Gbps
[1382385.646496] ata1: hard resetting link
[1382390.693053] ata1: COMRESET failed (errno=-16)
[1382390.693085] ata1: reset failed, giving up
[1382390.693114] ata1: exception Emask 0x10 SAct 0x0 SErr 0x190002
action 0xa frozen t3
[1382390.693138] ata1: hotplug_status 0x10
[1382390.693152] ata1: SError: { RecovComm PHYRdyChg 10B8B Dispar }
[1382390.693182] ata1: hard resetting link
[1382397.308646] ata1: port is slow to respond, please be patient (Status 0xff)
[1382400.726369] ata1: COMRESET failed (errno=-16)
[1382400.726402] ata1: hard resetting link
[1382407.332040] ata1: port is slow to respond, please be patient (Status 0xff)
[1382410.749690] ata1: COMRESET failed (errno=-16)
[1382410.749732] ata1: hard resetting link
[1382417.365279] ata1: port is slow to respond, please be patient (Status 0xff)
[1382445.758067] ata1: COMRESET failed (errno=-16)
[1382445.758105] ata1: limiting SATA link speed to 1.5 Gbps
[1382445.758109] ata1: hard resetting link
[1382450.803012] ata1: COMRESET failed (errno=-16)
[1382450.803048] ata1: reset failed, giving up
[1382450.803078] ata1: exception Emask 0x10 SAct 0x0 SErr 0x190002
action 0xa frozen t2
[1382450.803101] ata1: hotplug_status 0x10
[1382450.803115] ata1: SError: { RecovComm PHYRdyChg 10B8B Dispar }
[1382450.803146] ata1: hard resetting link
[1382457.408601] ata1: port is slow to respond, please be patient (Status 0xff)
[1382460.826332] ata1: COMRESET failed (errno=-16)
[1382460.826368] ata1: hard resetting link
[1382467.431919] ata1: port is slow to respond, please be patient (Status 0xff)
[1382470.849642] ata1: COMRESET failed (errno=-16)
[1382470.849676] ata1: hard resetting link
[1382477.455239] ata1: port is slow to respond, please be patient (Status 0xff)
[1382505.876306] ata1: COMRESET failed (errno=-16)
[1382505.876339] ata1: limiting SATA link speed to 1.5 Gbps
[1382505.876343] ata1: hard resetting link
[1382510.922939] ata1: COMRESET failed (errno=-16)
[1382510.922974] ata1: reset failed, giving up
[1382510.923004] ata1: exception Emask 0x10 SAct 0x0 SErr 0x190002
action 0xa frozen t1
[1382510.923026] ata1: hotplug_status 0x10
[1382510.923040] ata1: SError: { RecovComm PHYRdyChg 10B8B Dispar }
[1382510.923072] ata1: hard resetting link
[1382517.528539] ata1: port is slow to respond, please be patient (Status 0xff)
[1382520.946260] ata1: COMRESET failed (errno=-16)
[1382520.946294] ata1: hard resetting link
[1382527.551861] ata1: port is slow to respond, please be patient (Status 0xff)
[1382530.969583] ata1: COMRESET failed (errno=-16)
[1382530.969619] ata1: hard resetting link
[1382537.575180] ata1: port is slow to respond, please be patient (Status 0xff)
[1382566.006238] ata1: COMRESET failed (errno=-16)
[1382566.006271] ata1: limiting SATA link speed to 1.5 Gbps
[1382566.006275] ata1: hard resetting link
[1382571.052882] ata1: COMRESET failed (errno=-16)
[1382571.052918] ata1: reset failed, giving up
[1382571.052939] ata1: EH pending after 5 tries, giving up
[1382571.052976] sd 0:0:0:0: [sda] Result: hostbyte=DID_OK
driverbyte=DRIVER_SENSE,SUGGEST_OK
[1382571.052982] sd 0:0:0:0: [sda] Sense Key : Aborted Command
[current] [descriptor]
[1382571.052991] Descriptor sense data with sense descriptors (in hex):
[1382571.052993]         72 0b 00 00 00 00 00 0c 00 0a 80 00 00 00 00 00
[1382571.053004]         00 00 00 00
[1382571.053009] sd 0:0:0:0: [sda] Add. Sense: No additional sense information
[1382571.053015] end_request: I/O error, dev sda, sector 365784615
[1382571.053058] sd 0:0:0:0: rejecting I/O to offline device
[1382571.053090] sd 0:0:0:0: rejecting I/O to offline device
[1382571.053129] sd 0:0:0:0: rejecting I/O to offline device
[1382571.053159] sd 0:0:0:0: rejecting I/O to offline device
[1382571.053180] Buffer I/O error on device sda1, logical block 98205697
[1382571.053195] lost page write due to I/O error on sda1
[1382571.053209] Buffer I/O error on device sda1, logical block 98205698
[1382571.053228] lost page write due to I/O error on sda1
[1382571.053237] sd 0:0:0:0: rejecting I/O to offline device
[1382571.053253] Buffer I/O error on device sda1, logical block 24
[1382571.053268] lost page write due to I/O error on sda1
[1382571.053277] sd 0:0:0:0: rejecting I/O to offline device
[1382571.053299] Buffer I/O error on device sda1, logical block 37322855
[1382571.053314] lost page write due to I/O error on sda1
[1382571.053324] sd 0:0:0:0: rejecting I/O to offline device
[1382571.053343] Buffer I/O error on device sda1, logical block 45702335
[1382571.053358] lost page write due to I/O error on sda1
[1382571.053382] ata1: EH complete
[1382571.057240] sd 0:0:0:0: rejecting I/O to offline device
[1382571.057299] sd 0:0:0:0: [sda] Result: hostbyte=DID_NO_CONNECT
driverbyte=DRIVER_OK,SUGGEST_OK
[1382571.057307] end_request: I/O error, dev sda, sector 365784791
[1382571.058632] ata1.00: detaching (SCSI 0:0:0:0)
[1382571.063741] Buffer I/O error on device sda1, logical block 5338
[1382571.063773] lost page write due to I/O error on sda1
[1382571.068046] Aborting journal on device sda1.
[1382571.068125] Buffer I/O error on device sda1, logical block 1545
[1382571.068148] lost page write due to I/O error on sda1
[1382571.068951] journal commit I/O error
[1382571.069096] Buffer I/O error on device sda1, logical block 99647507
[1382571.069121] lost page write due to I/O error on sda1
[1382571.110130] ext3_abort called.
[1382571.110172] EXT3-fs error (device sda1): ext3_journal_start_sb:
Detected aborted journal
[1382571.110199] Remounting filesystem read-only
[1382571.144275] EXT3-fs error (device sda1): ext3_find_entry: reading
directory #49824312 offset 0
[1382571.144916] EXT3-fs error (device sda1): ext3_find_entry: reading
directory #49824312 offset 0
[1382571.145483] EXT3-fs error (device sda1): ext3_find_entry: reading
directory #49824311 offset 0
[1382571.145962] EXT3-fs error (device sda1): ext3_find_entry: reading
directory #49824311 offset 0
[1382571.259622] EXT3-fs error (device sda1): ext3_find_entry: reading
directory #18664627 offset 0
[1382571.267476] sd 0:0:0:0: [sda] Synchronizing SCSI cache
[1382571.270067] sd 0:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK
[1382571.270084] sd 0:0:0:0: [sda] Stopping disk
[1382571.271160] sd 0:0:0:0: [sda] START_STOP FAILED
[1382571.271178] sd 0:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK
[1382571.984481] EXT3-fs error (device sda1): ext3_find_entry: reading
directory #49824312 offset 0
