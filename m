From: Tim Valenzuela <tim@deadlyninja.com>
Subject: sata_via, 2.6.22-rc1, VT6421A
Date: Thu, 17 May 2007 03:09:32 -0700
Message-ID: <464C29DC.80901@deadlyninja.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------090608090205050902060103"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:62356 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754713AbXEQKll (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 17 May 2007 06:41:41 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070517100934.GJQM14313.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>
          for <linux-ide@vger.kernel.org>; Thu, 17 May 2007 06:09:34 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: ", linux-ide@vger.kernel.org"@centauri.lan

This is a multi-part message in MIME format.
--------------090608090205050902060103
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Recently, I acquired a
"SYBA SY-VIA-150 PCI SATA / IDE Combo Controller Card, Non Raid"
The physical chip reads "VT6421A 0651CD TAIWAN 21A0028971".

Each SATA channel has a drive plugged in, the PATA does not.

When using 2.6.22-rc1 I get some IO errors:
[   32.177782] Bad IO access at port 8 (return inl(port))
[   32.177866] BUG: at lib/iomap.c:44 bad_io_access()
[   32.177950]  [<c02b7801>] ioread32+0x21/0x30
[   32.178078]  [<c038839c>] sata_scr_read+0x2c/0x50
Neither drive shows up in /dev.

 When using earlier kernels (2.6.20, 2.6.21) the first SATA channel 
seems to work, however the second channel has some IO errors:
"failed to IDENTIFY (I/O error, err_mask=0x1)"

Attached is a complete dmesg log of the 2.6.22-rc1 kernel and a partial 
log from a 2.6.21.1 boot.

- Tim Valenzuela

--------------090608090205050902060103
Content-Type: text/plain;
 name="dmesg_complete-2.6.22-rc1.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg_complete-2.6.22-rc1.txt"

[    0.000000] Linux version 2.6.22-rc1 (root@centauri) (gcc version 4.1.1 (Gentoo 4.1.1-r3)) #2 PREEMPT Thu May 17 02:25:09 MST 2007
[    0.000000] BIOS-provided physical RAM map:
[    0.000000]  BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
[    0.000000]  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
[    0.000000]  BIOS-e820: 0000000000100000 - 000000001fff0000 (usable)
[    0.000000]  BIOS-e820: 000000001fff0000 - 000000001fff3000 (ACPI NVS)
[    0.000000]  BIOS-e820: 000000001fff3000 - 0000000020000000 (ACPI data)
[    0.000000]  BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
[    0.000000]  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
[    0.000000]  BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
[    0.000000] 0MB HIGHMEM available.
[    0.000000] 511MB LOWMEM available.
[    0.000000] Entering add_active_range(0, 0, 131056) 0 entries of 256 used
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA             0 ->     4096
[    0.000000]   Normal       4096 ->   131056
[    0.000000]   HighMem    131056 ->   131056
[    0.000000] early_node_map[1] active PFN ranges
[    0.000000]     0:        0 ->   131056
[    0.000000] On node 0 totalpages: 131056
[    0.000000]   DMA zone: 32 pages used for memmap
[    0.000000]   DMA zone: 0 pages reserved
[    0.000000]   DMA zone: 4064 pages, LIFO batch:0
[    0.000000]   Normal zone: 991 pages used for memmap
[    0.000000]   Normal zone: 125969 pages, LIFO batch:31
[    0.000000]   HighMem zone: 0 pages used for memmap
[    0.000000] DMI 2.2 present.
[    0.000000] ACPI: RSDP 000F75E0, 0014 (r0 Nvidia)
[    0.000000] ACPI: RSDT 1FFF3000, 002C (r1 Nvidia AWRDACPI 42302E31 AWRD        0)
[    0.000000] ACPI: FACP 1FFF3040, 0074 (r1 Nvidia AWRDACPI 42302E31 AWRD        0)
[    0.000000] ACPI: DSDT 1FFF30C0, 4561 (r1 NVIDIA AWRDACPI     1000 MSFT  100000E)
[    0.000000] ACPI: FACS 1FFF0000, 0040
[    0.000000] ACPI: APIC 1FFF7640, 006E (r1 Nvidia AWRDACPI 42302E31 AWRD        0)
[    0.000000] ACPI: PM-Timer IO Port: 0x4008
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
[    0.000000] Processor #0 6:8 APIC version 16
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
[    0.000000] Allocating PCI resources starting at 30000000 (gap: 20000000:dec00000)
[    0.000000] Built 1 zonelists.  Total pages: 130033
[    0.000000] Kernel command line: root=/dev/hda2
[    0.000000] Found and enabled local APIC!
[    0.000000] mapped APIC to ffffd000 (fee00000)
[    0.000000] Enabling fast FPU save and restore... done.
[    0.000000] Enabling unmasked SIMD FPU exception support... done.
[    0.000000] Initializing CPU#0
[    0.000000] PID hash table entries: 2048 (order: 11, 8192 bytes)
[    0.000000] Detected 1997.061 MHz processor.
[   28.065144] Console: colour VGA+ 80x25
[   28.068445] Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
[   28.068799] Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
[   28.082176] Memory: 511996k/524224k available (3627k kernel code, 11672k reserved, 1072k data, 208k init, 0k highmem)
[   28.082313] virtual kernel memory layout:
[   28.082314]     fixmap  : 0xfffea000 - 0xfffff000   (  84 kB)
[   28.082315]     pkmap   : 0xff800000 - 0xffc00000   (4096 kB)
[   28.082317]     vmalloc : 0xe0800000 - 0xff7fe000   ( 495 MB)
[   28.082318]     lowmem  : 0xc0000000 - 0xdfff0000   ( 511 MB)
[   28.082319]       .init : 0xc059a000 - 0xc05ce000   ( 208 kB)
[   28.082321]       .data : 0xc048afc8 - 0xc059738c   (1072 kB)
[   28.082322]       .text : 0xc0100000 - 0xc048afc8   (3627 kB)
[   28.082986] Checking if this processor honours the WP bit even in supervisor mode... Ok.
[   28.163118] Calibrating delay using timer specific routine.. 3996.99 BogoMIPS (lpj=7993994)
[   28.163319] Mount-cache hash table entries: 512
[   28.163517] CPU: After generic identify, caps: 0383fbff c1c3fbff 00000000 00000000 00000000 00000000 00000000
[   28.163525] CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
[   28.163616] CPU: L2 Cache: 256K (64 bytes/line)
[   28.163698] CPU: After all inits, caps: 0383fbff c1c3fbff 00000000 00000420 00000000 00000000 00000000
[   28.163704] Intel machine check architecture supported.
[   28.163788] Intel machine check reporting enabled on CPU#0.
[   28.163877] Compat vDSO mapped to ffffe000.
[   28.163966] CPU: AMD Athlon(tm) XP 2400+ stepping 01
[   28.164130] Checking 'hlt' instruction... OK.
[   28.179280] ACPI: Core revision 20070126
[   28.181411] ACPI: setting ELCR to 0200 (from 1a20)
[   28.287109] NET: Registered protocol family 16
[   28.287300] ACPI: bus type pci registered
[   28.319530] PCI: PCI BIOS revision 2.10 entry at 0xfb410, last bus=3
[   28.319619] PCI: Using configuration type 1
[   28.319699] Setting up standard PCI resources
[   28.328961] ACPI: Interpreter enabled
[   28.329047] ACPI: (supports S0 S1 S4 S5)
[   28.329341] ACPI: Using PIC for interrupt routing
[   28.338242] ACPI: PCI Root Bridge [PCI0] (0000:00)
[   28.338341] PCI: Probing PCI hardware (bus 00)
[   28.338422] PCI: nForce2 C1 Halt Disconnect fixup
[   28.339468] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[   28.339678] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB0._PRT]
[   28.339947] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGPB._PRT]
[   28.390051] ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
[   28.390930] ACPI: PCI Interrupt Link [LNK2] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
[   28.391707] ACPI: PCI Interrupt Link [LNK3] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
[   28.392486] ACPI: PCI Interrupt Link [LNK4] (IRQs 3 4 5 6 7 9 10 11 *12 14 15)
[   28.393262] ACPI: PCI Interrupt Link [LNK5] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
[   28.394120] ACPI: PCI Interrupt Link [LUBA] (IRQs 3 4 5 6 7 9 10 11 *12 14 15)
[   28.394905] ACPI: PCI Interrupt Link [LUBB] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
[   28.395683] ACPI: PCI Interrupt Link [LMAC] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
[   28.396461] ACPI: PCI Interrupt Link [LAPU] (IRQs 3 4 5 6 7 9 10 11 *12 14 15)
[   28.397394] ACPI: PCI Interrupt Link [LACI] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
[   28.398169] ACPI: PCI Interrupt Link [LMCI] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
[   28.399035] ACPI: PCI Interrupt Link [LSMB] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
[   28.399816] ACPI: PCI Interrupt Link [LUB2] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
[   28.400597] ACPI: PCI Interrupt Link [LFIR] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
[   28.401374] ACPI: PCI Interrupt Link [L3CM] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
[   28.402234] ACPI: PCI Interrupt Link [LIDE] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
[   28.403081] ACPI: PCI Interrupt Link [APC1] (IRQs *16), disabled.
[   28.403440] ACPI: PCI Interrupt Link [APC2] (IRQs *17)
[   28.403756] ACPI: PCI Interrupt Link [APC3] (IRQs *18)
[   28.404070] ACPI: PCI Interrupt Link [APC4] (IRQs *19)
[   28.404383] ACPI: PCI Interrupt Link [APC5] (IRQs *16), disabled.
[   28.404794] ACPI: PCI Interrupt Link [APCF] (IRQs 20 21 22) *0
[   28.405281] ACPI: PCI Interrupt Link [APCG] (IRQs 20 21 22) *0
[   28.405767] ACPI: PCI Interrupt Link [APCH] (IRQs 20 21 22) *0
[   28.406253] ACPI: PCI Interrupt Link [APCI] (IRQs 20 21 22) *0
[   28.406740] ACPI: PCI Interrupt Link [APCJ] (IRQs 20 21 22) *0
[   28.407229] ACPI: PCI Interrupt Link [APCK] (IRQs 20 21 22) *0, disabled.
[   28.407710] ACPI: PCI Interrupt Link [APCS] (IRQs *23)
[   28.408074] ACPI: PCI Interrupt Link [APCL] (IRQs 20 21 22) *0
[   28.408559] ACPI: PCI Interrupt Link [APCM] (IRQs 20 21 22) *0
[   28.409045] ACPI: PCI Interrupt Link [AP3C] (IRQs 20 21 22) *0, disabled.
[   28.409574] ACPI: PCI Interrupt Link [APCZ] (IRQs 20 21 22) *0, disabled.
[   28.410051] Linux Plug and Play Support v0.97 (c) Adam Belay
[   28.410148] pnp: PnP ACPI init
[   28.410234] ACPI: bus type pnp registered
[   28.415128] pnp: PnP ACPI: found 16 devices
[   28.415212] ACPI: ACPI bus type pnp unregistered
[   28.415405] SCSI subsystem initialized
[   28.415511] libata version 2.20 loaded.
[   28.415579] usbcore: registered new interface driver usbfs
[   28.415695] usbcore: registered new interface driver hub
[   28.415814] usbcore: registered new device driver usb
[   28.415936] PCI: Using ACPI for IRQ routing
[   28.416021] PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
[   28.473768] pnp: 00:00: ioport range 0x4000-0x407f has been reserved
[   28.473858] pnp: 00:00: ioport range 0x4080-0x40ff has been reserved
[   28.473946] pnp: 00:00: ioport range 0x4400-0x447f has been reserved
[   28.474034] pnp: 00:00: ioport range 0x4480-0x44ff has been reserved
[   28.474122] pnp: 00:00: ioport range 0x4200-0x427f has been reserved
[   28.474210] pnp: 00:00: ioport range 0x4280-0x42ff has been reserved
[   28.474304] pnp: 00:01: ioport range 0x5000-0x503f has been reserved
[   28.474392] pnp: 00:01: ioport range 0x5500-0x553f has been reserved
[   28.474485] pnp: 00:02: iomem range 0xf0000-0xf3fff could not be reserved
[   28.474574] pnp: 00:02: iomem range 0xf4000-0xf7fff could not be reserved
[   28.474664] pnp: 00:02: iomem range 0xf8000-0xfbfff could not be reserved
[   28.474754] Time: tsc clocksource has been installed.
[   28.474840] pnp: 00:02: iomem range 0xfc000-0xfffff could not be reserved
[   28.475570] ACPI: PCI Interrupt Link [LFIR] enabled at IRQ 9
[   28.475659] PCI: setting IRQ 9 as level-triggered
[   28.475662] ACPI: PCI Interrupt 0000:00:0d.0[A] -> Link [LFIR] -> GSI 9 (level, low) -> IRQ 9
[   28.475867] PCI: Setting latency timer of device 0000:00:0d.0 to 64
[   28.527715] ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[9]  MMIO=[e8086000-e80867ff]  Max Packet=[2048]  IR/IT contexts=[4/4]
[   28.562868] PCI: Bridge: 0000:00:08.0
[   28.562948]   IO window: 9000-bfff
[   28.563028]   MEM window: e4000000-e6ffffff
[   28.563110]   PREFETCH window: 30000000-300fffff
[   28.563194] PCI: Bridge: 0000:00:1e.0
[   28.563271]   IO window: disabled.
[   28.563350]   MEM window: disabled.
[   28.563429]   PREFETCH window: disabled.
[   28.563518] PCI: Setting latency timer of device 0000:00:08.0 to 64
[   28.563558] NET: Registered protocol family 2
[   28.598533] IP route cache hash table entries: 4096 (order: 2, 16384 bytes)
[   28.598696] TCP established hash table entries: 16384 (order: 5, 131072 bytes)
[   28.599008] TCP bind hash table entries: 16384 (order: 4, 65536 bytes)
[   28.599197] TCP: Hash tables configured (established 16384 bind 16384)
[   28.599286] TCP reno registered
[   28.610733] Machine check exception polling timer started.
[   28.610959] audit: initializing netlink socket (disabled)
[   28.611053] audit(1179368785.420:1): initialized
[   28.611322] Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
[   28.611626] NTFS driver 2.1.28 [Flags: R/W].
[   28.611728] fuse init (API version 7.8)
[   28.611907] io scheduler noop registered
[   28.611988] io scheduler anticipatory registered (default)
[   28.612073] io scheduler deadline registered
[   28.612166] io scheduler cfq registered
[   28.666422] Boot video device is 0000:01:0a.0
[   28.666744] input: Power Button (FF) as /class/input/input0
[   28.666831] ACPI: Power Button (FF) [PWRF]
[   28.666971] input: Power Button (CM) as /class/input/input1
[   28.667057] ACPI: Power Button (CM) [PWRB]
[   28.694108] lp: driver loaded but no devices found
[   28.694262] Real Time Clock Driver v1.12ac
[   28.694342] Linux agpgart interface v0.102 (c) Dave Jones
[   28.694515] agpgart: Detected NVIDIA nForce2 chipset
[   28.699238] agpgart: AGP aperture is 64M @ 0xe0000000
[   28.699353] Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
[   28.700388] 00:0a: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[   28.702876] 00:0b: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
[   28.703561] parport_pc 00:0c: reported by Plug and Play ACPI
[   28.703672] parport0: PC-style at 0x378 (0x778), irq 7 [PCSPP(,...)]
[   28.704050] lp0: using parport0 (interrupt-driven).
[   28.722014] FDC 0 is a post-1991 82077
[   28.723503] RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
[   28.723622] loop: module loaded
[   28.723753] sk98lin: driver has been replaced by the skge driver and is scheduled for removal
[   28.724233] ACPI: PCI Interrupt Link [LNK2] enabled at IRQ 5
[   28.724320] PCI: setting IRQ 5 as level-triggered
[   28.724324] ACPI: PCI Interrupt 0000:01:04.0[A] -> Link [LNK2] -> GSI 5 (level, low) -> IRQ 5
[   28.811747] eth0: Yukon Gigabit Ethernet 10/100/1000Base-T Adapter
[   28.811836]       PrefPort:A  RlmtMode:Check Link State
[   28.812011] forcedeth.c: Reverse Engineered nForce ethernet driver. Version 0.60.
[   28.812419] ACPI: PCI Interrupt Link [LMAC] enabled at IRQ 5
[   28.812506] ACPI: PCI Interrupt 0000:00:04.0[A] -> Link [LMAC] -> GSI 5 (level, low) -> IRQ 5
[   28.812710] PCI: Setting latency timer of device 0000:00:04.0 to 64
[   29.329671] eth1: forcedeth.c: subsystem: 01043:80a7 bound to 0000:00:04.0
[   29.329777] Linux video capture interface: v2.00
[   29.329876] Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
[   29.329966] ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
[   29.330146] NFORCE2: IDE controller at PCI slot 0000:00:09.0
[   29.330245] NFORCE2: chipset revision 162
[   29.330324] NFORCE2: not 100% native mode: will probe irqs later
[   29.330413] NFORCE2: BIOS didn't set cable bits correctly. Enabling workaround.
[   29.330529] NFORCE2: BIOS didn't set cable bits correctly. Enabling workaround.
[   29.330649] NFORCE2: 0000:00:09.0 (rev a2) UDMA133 controller
[   29.330740]     ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:DMA
[   29.330945]     ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA
[   29.331149] Probing IDE interface ide0...
[   29.617133] hda: WDC WD1000JB-00CRA1, ATA DISK drive
[   29.738492] ohci1394: fw-host0: SelfID received outside of bus reset sequence
[   29.960628] hdb: MAXTOR 6L080L4, ATA DISK drive
[   30.008597] ieee1394: Host added: ID:BUS[0-00:1023]  GUID[6e56696469610000]
[   30.018414] ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
[   30.018604] Probing IDE interface ide1...
[   30.751469] hdc: LITE-ON LTR-48125W, ATAPI CD/DVD-ROM drive
[   31.031059] hdd: MAXTOR 6L080J4, ATA DISK drive
[   31.090564] ide1 at 0x170-0x177,0x376 on irq 15
[   31.091009] hda: max request size: 128KiB
[   31.103796] hda: 195371568 sectors (100030 MB) w/8192KiB Cache, CHS=65535/16/63, UDMA(100)
[   31.104078] hda: cache flushes not supported
[   31.104194]  hda: hda1 hda2 hda3
[   31.107330] hdb: max request size: 128KiB
[   31.108443] hdb: 156355584 sectors (80054 MB) w/1819KiB Cache, CHS=65535/16/63, UDMA(133)
[   31.108865] hdb: cache flushes supported
[   31.108959]  hdb: hdb1
[   31.112988] hdd: max request size: 128KiB
[   31.114090] hdd: 156355584 sectors (80054 MB) w/1819KiB Cache, CHS=65535/16/63, UDMA(133)
[   31.114516] hdd: cache flushes supported
[   31.114608]  hdd: hdd1
[   31.127946] hdc: ATAPI 48X CD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
[   31.128317] Uniform CD-ROM driver Revision: 3.20
[   31.167473] sata_sil 0000:01:0b.0: version 2.2
[   31.167832] ACPI: PCI Interrupt Link [LNK3] enabled at IRQ 11
[   31.167920] PCI: setting IRQ 11 as level-triggered
[   31.167924] ACPI: PCI Interrupt 0000:01:0b.0[A] -> Link [LNK3] -> GSI 11 (level, low) -> IRQ 11
[   31.168212] scsi0 : sata_sil
[   31.168356] scsi1 : sata_sil
[   31.168475] ata1: SATA max UDMA/100 cmd 0xe0818080 ctl 0xe081808a bmdma 0xe0818000 irq 0
[   31.168597] ata2: SATA max UDMA/100 cmd 0xe08180c0 ctl 0xe08180ca bmdma 0xe0818008 irq 0
[   31.634076] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[   31.661140] ata1.00: ata_hpa_resize 1: sectors = 625142448, hpa_sectors = 625142448
[   31.661262] ata1.00: ATA-7: WDC WD3200AAKS-00SBA0, 12.01B01, max UDMA/133
[   31.661351] ata1.00: 625142448 sectors, multi 16: LBA48 NCQ (depth 0/32)
[   31.667154] ata1.00: ata_hpa_resize 1: sectors = 625142448, hpa_sectors = 625142448
[   31.667274] ata1.00: configured for UDMA/100
[   32.133343] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[   32.155927] ata2.00: ata_hpa_resize 1: sectors = 625142448, hpa_sectors = 625142448
[   32.156047] ata2.00: ATA-7: WDC WD3200AAKS-00SBA0, 12.01B01, max UDMA/133
[   32.156136] ata2.00: 625142448 sectors, multi 16: LBA48 NCQ (depth 0/32)
[   32.162278] ata2.00: ata_hpa_resize 1: sectors = 625142448, hpa_sectors = 625142448
[   32.162398] ata2.00: configured for UDMA/100
[   32.162580] scsi 0:0:0:0: Direct-Access     ATA      WDC WD3200AAKS-0 12.0 PQ: 0 ANSI: 5
[   32.162805] sd 0:0:0:0: [sda] 625142448 512-byte hardware sectors (320073 MB)
[   32.162906] sd 0:0:0:0: [sda] Write Protect is off
[   32.162989] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[   32.163003] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   32.163174] sd 0:0:0:0: [sda] 625142448 512-byte hardware sectors (320073 MB)
[   32.163271] sd 0:0:0:0: [sda] Write Protect is off
[   32.163354] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[   32.163366] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   32.163491]  sda: unknown partition table
[   32.172184] sd 0:0:0:0: [sda] Attached SCSI disk
[   32.172328] sd 0:0:0:0: Attached scsi generic sg0 type 0
[   32.172474] scsi 1:0:0:0: Direct-Access     ATA      WDC WD3200AAKS-0 12.0 PQ: 0 ANSI: 5
[   32.172676] sd 1:0:0:0: [sdb] 625142448 512-byte hardware sectors (320073 MB)
[   32.172773] sd 1:0:0:0: [sdb] Write Protect is off
[   32.172856] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[   32.172868] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   32.173016] sd 1:0:0:0: [sdb] 625142448 512-byte hardware sectors (320073 MB)
[   32.173112] sd 1:0:0:0: [sdb] Write Protect is off
[   32.173195] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[   32.173206] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   32.173336]  sdb: sdb1 sdb2
[   32.176266] sd 1:0:0:0: [sdb] Attached SCSI disk
[   32.176405] sd 1:0:0:0: Attached scsi generic sg1 type 0
[   32.176567] sata_via 0000:01:07.0: version 2.1
[   32.176878] ACPI: PCI Interrupt Link [LNK4] enabled at IRQ 12
[   32.176966] PCI: setting IRQ 12 as level-triggered
[   32.176970] ACPI: PCI Interrupt 0000:01:07.0[A] -> Link [LNK4] -> GSI 12 (level, low) -> IRQ 12
[   32.177246] sata_via 0000:01:07.0: routed to hard irq line 12
[   32.177404] scsi2 : sata_via
[   32.177544] scsi3 : sata_via
[   32.177667] scsi4 : sata_via
[   32.177782] Bad IO access at port 8 (return inl(port))
[   32.177866] BUG: at lib/iomap.c:44 bad_io_access()
[   32.177950]  [<c02b7801>] ioread32+0x21/0x30
[   32.178078]  [<c038839c>] sata_scr_read+0x2c/0x50
[   32.178202]  [<c038f260>] ata_interrupt+0x0/0x250
[   32.178327]  [<c038e631>] ata_host_register+0x171/0x2d0
[   32.178457]  [<c038f260>] ata_interrupt+0x0/0x250
[   32.178580]  [<c0145a95>] request_irq+0xb5/0xd0
[   32.178702]  [<c0146f20>] devm_irq_release+0x0/0x10
[   32.178827]  [<c0147010>] devm_request_irq+0x70/0x90
[   32.178950]  [<c038f260>] ata_interrupt+0x0/0x250
[   32.179073]  [<c038e802>] ata_host_activate+0x72/0x90
[   32.179197]  [<c0398b06>] svia_init_one+0x396/0x540
[   32.179323]  [<c01a8cd6>] sysfs_dirent_exist+0x46/0x80
[   32.179448]  [<c01a8e3f>] sysfs_make_dirent+0x2f/0x50
[   32.179572]  [<c02b13b2>] kobject_get+0x12/0x20
[   32.179698]  [<c02c3636>] pci_device_probe+0x56/0x80
[   32.179822]  [<c0320c91>] driver_probe_device+0x91/0x1a0
[   32.179949]  [<c0487a4f>] klist_next+0x6f/0xd0
[   32.180074]  [<c0320edc>] __driver_attach+0x7c/0x80
[   32.180197]  [<c0320074>] bus_for_each_dev+0x44/0x70
[   32.180321]  [<c02b13b2>] kobject_get+0x12/0x20
[   32.180443]  [<c0320b06>] driver_attach+0x16/0x20
[   32.180565]  [<c0320e60>] __driver_attach+0x0/0x80
[   32.180687]  [<c032045a>] bus_add_driver+0x8a/0x1a0
[   32.180811]  [<c01a21df>] create_proc_entry+0x5f/0xd0
[   32.180937]  [<c02c37e9>] __pci_register_driver+0x49/0x90
[   32.181063]  [<c059a740>] kernel_init+0x90/0x260
[   32.181186]  [<c01166df>] schedule_tail+0x2f/0xa0
[   32.181324]  [<c0102de8>] __switch_to+0x28/0x1a0
[   32.181448]  [<c0103f6e>] ret_from_fork+0x6/0x1c
[   32.181570]  [<c059a6b0>] kernel_init+0x0/0x260
[   32.181691]  [<c059a6b0>] kernel_init+0x0/0x260
[   32.181813]  [<c010440f>] kernel_thread_helper+0x7/0x18
[   32.181938]  =======================
[   32.182017] ata3: SATA max UDMA/133 cmd 0x00019400 ctl 0x0001940a bmdma 0x0001a400 irq 0
[   32.182136] Bad IO access at port 48 (return inl(port))
[   32.182220] BUG: at lib/iomap.c:44 bad_io_access()
[   32.182301]  [<c02b7801>] ioread32+0x21/0x30
[   32.182423]  [<c038839c>] sata_scr_read+0x2c/0x50
[   32.182545]  [<c038e631>] ata_host_register+0x171/0x2d0
[   32.182670]  [<c0146f20>] devm_irq_release+0x0/0x10
[   32.182792]  [<c0147010>] devm_request_irq+0x70/0x90
[   32.182915]  [<c038f260>] ata_interrupt+0x0/0x250
[   32.183038]  [<c038e802>] ata_host_activate+0x72/0x90
[   32.183161]  [<c0398b06>] svia_init_one+0x396/0x540
[   32.183286]  [<c01a8cd6>] sysfs_dirent_exist+0x46/0x80
[   32.183410]  [<c01a8e3f>] sysfs_make_dirent+0x2f/0x50
[   32.183534]  [<c02b13b2>] kobject_get+0x12/0x20
[   32.183656]  [<c02c3636>] pci_device_probe+0x56/0x80
[   32.183779]  [<c0320c91>] driver_probe_device+0x91/0x1a0
[   32.183904]  [<c0487a4f>] klist_next+0x6f/0xd0
[   32.184026]  [<c0320edc>] __driver_attach+0x7c/0x80
[   32.184149]  [<c0320074>] bus_for_each_dev+0x44/0x70
[   32.184273]  [<c02b13b2>] kobject_get+0x12/0x20
[   32.184395]  [<c0320b06>] driver_attach+0x16/0x20
[   32.184518]  [<c0320e60>] __driver_attach+0x0/0x80
[   32.184641]  [<c032045a>] bus_add_driver+0x8a/0x1a0
[   32.184764]  [<c01a21df>] create_proc_entry+0x5f/0xd0
[   32.184888]  [<c02c37e9>] __pci_register_driver+0x49/0x90
[   32.187075]  [<c059a740>] kernel_init+0x90/0x260
[   32.187197]  [<c01166df>] schedule_tail+0x2f/0xa0
[   32.187319]  [<c0102de8>] __switch_to+0x28/0x1a0
[   32.187442]  [<c0103f6e>] ret_from_fork+0x6/0x1c
[   32.187564]  [<c059a6b0>] kernel_init+0x0/0x260
[   32.187686]  [<c059a6b0>] kernel_init+0x0/0x260
[   32.187807]  [<c010440f>] kernel_thread_helper+0x7/0x18
[   32.187931]  =======================
[   32.188010] ata4: SATA max UDMA/133 cmd 0x00019800 ctl 0x0001980a bmdma 0x0001a408 irq 0
[   32.188130] ata5: PATA max UDMA/133 cmd 0x00019c00 ctl 0x00019c0a bmdma 0x0001a410 irq 0
[   32.188268] Bad IO access at port 8 (return inl(port))
[   32.188351] BUG: at lib/iomap.c:44 bad_io_access()
[   32.188434]  [<c02b7801>] ioread32+0x21/0x30
[   32.188555]  [<c017f9c6>] mntput_no_expire+0x16/0xa0
[   32.188681]  [<c038839c>] sata_scr_read+0x2c/0x50
[   32.188803]  [<c038b710>] ata_std_softreset+0x0/0x110
[   32.188926]  [<c03883dd>] sata_set_spd_needed+0x1d/0x40
[   32.189050]  [<c0394cce>] ata_do_eh+0x84e/0x1aa0
[   32.189173]  [<c02b091f>] _atomic_dec_and_lock+0x2f/0x50
[   32.189300]  [<c017f9c6>] mntput_no_expire+0x16/0xa0
[   32.189424]  [<c0172655>] link_path_walk+0x65/0xc0
[   32.189548]  [<c01728be>] do_path_lookup+0x8e/0x250
[   32.189671]  [<c01697df>] get_empty_filp+0x5f/0x120
[   32.189796]  [<c038b710>] ata_std_softreset+0x0/0x110
[   32.189920]  [<c038ed30>] ata_std_prereset+0x0/0xe0
[   32.190043]  [<c02b50ee>] vsnprintf+0x34e/0x5d0
[   32.190168]  [<c0102de8>] __switch_to+0x28/0x1a0
[   32.190290]  [<c03938e5>] ata_bmdma_irq_clear+0x15/0x30
[   32.190415]  [<c039379c>] ata_bmdma_drive_eh+0xac/0x140
[   32.190541]  [<c0378fe0>] scsi_error_handler+0x0/0x310
[   32.190669]  [<c038b430>] ata_std_postreset+0x0/0xb0
[   32.190793]  [<c038bbe0>] sata_std_hardreset+0x0/0xc0
[   32.190916]  [<c038ed30>] ata_std_prereset+0x0/0xe0
[   32.191039]  [<c0393863>] ata_bmdma_error_handler+0x33/0x40
[   32.191165]  [<c038bbe0>] sata_std_hardreset+0x0/0xc0
[   32.191289]  [<c038b430>] ata_std_postreset+0x0/0xb0
[   32.191412]  [<c03965a0>] ata_scsi_error+0x260/0x690
[   32.191536]  [<c0488123>] __sched_text_start+0x283/0x650
[   32.191661]  [<c0378fe0>] scsi_error_handler+0x0/0x310
[   32.191785]  [<c0379080>] scsi_error_handler+0xa0/0x310
[   32.191911]  [<c0378fe0>] scsi_error_handler+0x0/0x310
[   32.192035]  [<c0378fe0>] scsi_error_handler+0x0/0x310
[   32.192160]  [<c012ca82>] kthread+0x42/0x70
[   32.192281]  [<c012ca40>] kthread+0x0/0x70
[   32.192402]  [<c010440f>] kernel_thread_helper+0x7/0x18
[   32.192526]  =======================
[   32.192604] Bad IO access at port 8 (return inl(port))
[   32.192688] BUG: at lib/iomap.c:44 bad_io_access()
[   32.192770]  [<c02b7801>] ioread32+0x21/0x30
[   32.192891]  [<c038839c>] sata_scr_read+0x2c/0x50
[   32.193013]  [<c038bab3>] sata_phy_resume+0x23/0x80
[   32.193136]  [<c017f9c6>] mntput_no_expire+0x16/0xa0
[   32.193269]  [<c038839c>] sata_scr_read+0x2c/0x50
[   32.193392]  [<c038ede1>] ata_std_prereset+0xb1/0xe0
[   32.193515]  [<c038b710>] ata_std_softreset+0x0/0x110
[   32.193640]  [<c0394d18>] ata_do_eh+0x898/0x1aa0
[   32.193762]  [<c02b091f>] _atomic_dec_and_lock+0x2f/0x50
[   32.193887]  [<c017f9c6>] mntput_no_expire+0x16/0xa0
[   32.194011]  [<c0172655>] link_path_walk+0x65/0xc0
[   32.194134]  [<c01728be>] do_path_lookup+0x8e/0x250
[   32.194257]  [<c01697df>] get_empty_filp+0x5f/0x120
[   32.194380]  [<c038b710>] ata_std_softreset+0x0/0x110
[   32.194505]  [<c038ed30>] ata_std_prereset+0x0/0xe0
[   32.194628]  [<c02b50ee>] vsnprintf+0x34e/0x5d0
[   32.194750]  [<c0102de8>] __switch_to+0x28/0x1a0
[   32.194872]  [<c03938e5>] ata_bmdma_irq_clear+0x15/0x30
[   32.194996]  [<c039379c>] ata_bmdma_drive_eh+0xac/0x140
[   32.195121]  [<c0378fe0>] scsi_error_handler+0x0/0x310
[   32.195245]  [<c038b430>] ata_std_postreset+0x0/0xb0
[   32.195368]  [<c038bbe0>] sata_std_hardreset+0x0/0xc0
[   32.195491]  [<c038ed30>] ata_std_prereset+0x0/0xe0
[   32.195614]  [<c0393863>] ata_bmdma_error_handler+0x33/0x40
[   32.195740]  [<c038bbe0>] sata_std_hardreset+0x0/0xc0
[   32.195864]  [<c038b430>] ata_std_postreset+0x0/0xb0
[   32.195987]  [<c03965a0>] ata_scsi_error+0x260/0x690
[   32.196111]  [<c0488123>] __sched_text_start+0x283/0x650
[   32.196236]  [<c0378fe0>] scsi_error_handler+0x0/0x310
[   32.196361]  [<c0379080>] scsi_error_handler+0xa0/0x310
[   32.196487]  [<c0378fe0>] scsi_error_handler+0x0/0x310
[   32.196611]  [<c0378fe0>] scsi_error_handler+0x0/0x310
[   32.196735]  [<c012ca82>] kthread+0x42/0x70
[   32.196856]  [<c012ca40>] kthread+0x0/0x70
[   32.196976]  [<c010440f>] kernel_thread_helper+0x7/0x18
[   32.197102]  =======================
[   32.197180] Bad IO access at port 8 (outl(val,port))
[   32.197263] BUG: at lib/iomap.c:44 bad_io_access()
[   32.197345]  [<c0388433>] sata_scr_write+0x33/0x50
[   32.197468]  [<c038bae4>] sata_phy_resume+0x54/0x80
[   32.197592]  [<c017f9c6>] mntput_no_expire+0x16/0xa0
[   32.197716]  [<c038ede1>] ata_std_prereset+0xb1/0xe0
[   32.197840]  [<c038b710>] ata_std_softreset+0x0/0x110
[   32.197963]  [<c0394d18>] ata_do_eh+0x898/0x1aa0
[   32.198086]  [<c02b091f>] _atomic_dec_and_lock+0x2f/0x50
[   32.198212]  [<c017f9c6>] mntput_no_expire+0x16/0xa0
[   32.198335]  [<c0172655>] link_path_walk+0x65/0xc0
[   32.198458]  [<c01728be>] do_path_lookup+0x8e/0x250
[   32.198583]  [<c01697df>] get_empty_filp+0x5f/0x120
[   32.198706]  [<c038b710>] ata_std_softreset+0x0/0x110
[   32.198831]  [<c038ed30>] ata_std_prereset+0x0/0xe0
[   32.198954]  [<c02b50ee>] vsnprintf+0x34e/0x5d0
[   32.199076]  [<c0102de8>] __switch_to+0x28/0x1a0
[   32.199198]  [<c03938e5>] ata_bmdma_irq_clear+0x15/0x30
[   32.199323]  [<c039379c>] ata_bmdma_drive_eh+0xac/0x140
[   32.199448]  [<c0378fe0>] scsi_error_handler+0x0/0x310
[   32.199573]  [<c038b430>] ata_std_postreset+0x0/0xb0
[   32.199696]  [<c038bbe0>] sata_std_hardreset+0x0/0xc0
[   32.199819]  [<c038ed30>] ata_std_prereset+0x0/0xe0
[   32.199942]  [<c0393863>] ata_bmdma_error_handler+0x33/0x40
[   32.200068]  [<c038bbe0>] sata_std_hardreset+0x0/0xc0
[   32.200192]  [<c038b430>] ata_std_postreset+0x0/0xb0
[   32.200315]  [<c03965a0>] ata_scsi_error+0x260/0x690
[   32.200439]  [<c0488123>] __sched_text_start+0x283/0x650
[   32.200564]  [<c0378fe0>] scsi_error_handler+0x0/0x310
[   32.200688]  [<c0379080>] scsi_error_handler+0xa0/0x310
[   32.200814]  [<c0378fe0>] scsi_error_handler+0x0/0x310
[   32.200939]  [<c0378fe0>] scsi_error_handler+0x0/0x310
[   32.201063]  [<c012ca82>] kthread+0x42/0x70
[   32.201184]  [<c012ca40>] kthread+0x0/0x70
[   32.201304]  [<c010440f>] kernel_thread_helper+0x7/0x18
[   32.201429]  =======================
[   32.404922] Bad IO access at port 0 (return inl(port))
[   32.405006] BUG: at lib/iomap.c:44 bad_io_access()
[   32.405088]  [<c02b7801>] ioread32+0x21/0x30
[   32.405209]  [<c038839c>] sata_scr_read+0x2c/0x50
[   32.405331]  [<c038b9ff>] sata_phy_debounce+0x4f/0xe0
[   32.405455]  [<c038bafa>] sata_phy_resume+0x6a/0x80
[   32.405578]  [<c017f9c6>] mntput_no_expire+0x16/0xa0
[   32.405701]  [<c038ede1>] ata_std_prereset+0xb1/0xe0
[   32.405827]  [<c038b710>] ata_std_softreset+0x0/0x110
[   32.405950]  [<c0394d18>] ata_do_eh+0x898/0x1aa0
[   32.406072]  [<c02b091f>] _atomic_dec_and_lock+0x2f/0x50
[   32.406198]  [<c017f9c6>] mntput_no_expire+0x16/0xa0
[   32.406322]  [<c0172655>] link_path_walk+0x65/0xc0
[   32.406445]  [<c01728be>] do_path_lookup+0x8e/0x250
[   32.406568]  [<c01697df>] get_empty_filp+0x5f/0x120
[   32.406692]  [<c038b710>] ata_std_softreset+0x0/0x110
[   32.406816]  [<c038ed30>] ata_std_prereset+0x0/0xe0
[   32.406939]  [<c02b50ee>] vsnprintf+0x34e/0x5d0
[   32.407061]  [<c0102de8>] __switch_to+0x28/0x1a0
[   32.407183]  [<c03938e5>] ata_bmdma_irq_clear+0x15/0x30
[   32.407308]  [<c039379c>] ata_bmdma_drive_eh+0xac/0x140
[   32.407432]  [<c0378fe0>] scsi_error_handler+0x0/0x310
[   32.407557]  [<c038b430>] ata_std_postreset+0x0/0xb0
[   32.407680]  [<c038bbe0>] sata_std_hardreset+0x0/0xc0
[   32.407804]  [<c038ed30>] ata_std_prereset+0x0/0xe0
[   32.407927]  [<c0393863>] ata_bmdma_error_handler+0x33/0x40
[   32.408054]  [<c038bbe0>] sata_std_hardreset+0x0/0xc0
[   32.408179]  [<c038b430>] ata_std_postreset+0x0/0xb0
[   32.408302]  [<c03965a0>] ata_scsi_error+0x260/0x690
[   32.408426]  [<c0488123>] __sched_text_start+0x283/0x650
[   32.408551]  [<c0378fe0>] scsi_error_handler+0x0/0x310
[   32.408676]  [<c0379080>] scsi_error_handler+0xa0/0x310
[   32.408801]  [<c0378fe0>] scsi_error_handler+0x0/0x310
[   32.408927]  [<c0378fe0>] scsi_error_handler+0x0/0x310
[   32.409051]  [<c012ca82>] kthread+0x42/0x70
[   32.409172]  [<c012ca40>] kthread+0x0/0x70
[   32.409292]  [<c010440f>] kernel_thread_helper+0x7/0x18
[   32.409417]  =======================
[   32.420898] Bad IO access at port 0 (return inl(port))
[   32.420981] BUG: at lib/iomap.c:44 bad_io_access()
[   32.421062]  [<c01226b0>] process_timeout+0x0/0x10
[   32.421185]  [<c02b7801>] ioread32+0x21/0x30
[   32.421308]  [<c038839c>] sata_scr_read+0x2c/0x50
[   32.421430]  [<c038ba45>] sata_phy_debounce+0x95/0xe0
[   32.421553]  [<c038bafa>] sata_phy_resume+0x6a/0x80
[   32.421676]  [<c017f9c6>] mntput_no_expire+0x16/0xa0
[   32.421799]  [<c038ede1>] ata_std_prereset+0xb1/0xe0
[   32.421923]  [<c038b710>] ata_std_softreset+0x0/0x110
[   32.422048]  [<c0394d18>] ata_do_eh+0x898/0x1aa0
[   32.422171]  [<c02b091f>] _atomic_dec_and_lock+0x2f/0x50
[   32.422295]  [<c017f9c6>] mntput_no_expire+0x16/0xa0
[   32.422419]  [<c0172655>] link_path_walk+0x65/0xc0
[   32.422542]  [<c01728be>] do_path_lookup+0x8e/0x250
[   32.422665]  [<c01697df>] get_empty_filp+0x5f/0x120
[   32.422788]  [<c038b710>] ata_std_softreset+0x0/0x110
[   32.422912]  [<c038ed30>] ata_std_prereset+0x0/0xe0
[   32.423035]  [<c02b50ee>] vsnprintf+0x34e/0x5d0
[   32.423158]  [<c0102de8>] __switch_to+0x28/0x1a0
[   32.425335]  [<c03938e5>] ata_bmdma_irq_clear+0x15/0x30
[   32.425459]  [<c039379c>] ata_bmdma_drive_eh+0xac/0x140
[   32.425584]  [<c0378fe0>] scsi_error_handler+0x0/0x310
[   32.425709]  [<c038b430>] ata_std_postreset+0x0/0xb0
[   32.425833]  [<c038bbe0>] sata_std_hardreset+0x0/0xc0
[   32.425956]  [<c038ed30>] ata_std_prereset+0x0/0xe0
[   32.426079]  [<c0393863>] ata_bmdma_error_handler+0x33/0x40
[   32.426205]  [<c038bbe0>] sata_std_hardreset+0x0/0xc0
[   32.426329]  [<c038b430>] ata_std_postreset+0x0/0xb0
[   32.426452]  [<c03965a0>] ata_scsi_error+0x260/0x690
[   32.426576]  [<c0488123>] __sched_text_start+0x283/0x650
[   32.426701]  [<c0378fe0>] scsi_error_handler+0x0/0x310
[   32.426826]  [<c0379080>] scsi_error_handler+0xa0/0x310
[   32.426951]  [<c0378fe0>] scsi_error_handler+0x0/0x310
[   32.427075]  [<c0378fe0>] scsi_error_handler+0x0/0x310
[   32.427200]  [<c012ca82>] kthread+0x42/0x70
[   32.427320]  [<c012ca40>] kthread+0x0/0x70
[   32.427441]  [<c010440f>] kernel_thread_helper+0x7/0x18
[   32.427565]  =======================
[   32.436875] Bad IO access at port 0 (return inl(port))
[   32.436958] BUG: at lib/iomap.c:44 bad_io_access()
[   32.437040]  [<c01226b0>] process_timeout+0x0/0x10
[   32.437162]  [<c02b7801>] ioread32+0x21/0x30
[   32.437283]  [<c038839c>] sata_scr_read+0x2c/0x50
[   32.437406]  [<c038ba45>] sata_phy_debounce+0x95/0xe0
[   32.437530]  [<c038bafa>] sata_phy_resume+0x6a/0x80
[   32.437653]  [<c017f9c6>] mntput_no_expire+0x16/0xa0
[   32.437776]  [<c038ede1>] ata_std_prereset+0xb1/0xe0
[   32.437900]  [<c038b710>] ata_std_softreset+0x0/0x110
[   32.438023]  [<c0394d18>] ata_do_eh+0x898/0x1aa0
[   32.438145]  [<c02b091f>] _atomic_dec_and_lock+0x2f/0x50
[   32.438270]  [<c017f9c6>] mntput_no_expire+0x16/0xa0
[   32.438393]  [<c0172655>] link_path_walk+0x65/0xc0
[   32.438519]  [<c01728be>] do_path_lookup+0x8e/0x250
[   32.438642]  [<c01697df>] get_empty_filp+0x5f/0x120
[   32.438766]  [<c038b710>] ata_std_softreset+0x0/0x110
[   32.438889]  [<c038ed30>] ata_std_prereset+0x0/0xe0
[   32.439013]  [<c02b50ee>] vsnprintf+0x34e/0x5d0
[   32.439135]  [<c0102de8>] __switch_to+0x28/0x1a0
[   32.439257]  [<c03938e5>] ata_bmdma_irq_clear+0x15/0x30
[   32.439382]  [<c039379c>] ata_bmdma_drive_eh+0xac/0x140
[   32.439507]  [<c0378fe0>] scsi_error_handler+0x0/0x310
[   32.439631]  [<c038b430>] ata_std_postreset+0x0/0xb0
[   32.439755]  [<c038bbe0>] sata_std_hardreset+0x0/0xc0
[   32.439879]  [<c038ed30>] ata_std_prereset+0x0/0xe0
[   32.440002]  [<c0393863>] ata_bmdma_error_handler+0x33/0x40
[   32.440128]  [<c038bbe0>] sata_std_hardreset+0x0/0xc0
[   32.440252]  [<c038b430>] ata_std_postreset+0x0/0xb0
[   32.440375]  [<c03965a0>] ata_scsi_error+0x260/0x690
[   32.440499]  [<c0488123>] __sched_text_start+0x283/0x650
[   32.440624]  [<c0378fe0>] scsi_error_handler+0x0/0x310
[   32.440749]  [<c0379080>] scsi_error_handler+0xa0/0x310
[   32.440876]  [<c0378fe0>] scsi_error_handler+0x0/0x310
[   32.441000]  [<c0378fe0>] scsi_error_handler+0x0/0x310
[   32.441124]  [<c012ca82>] kthread+0x42/0x70
[   32.441245]  [<c012ca40>] kthread+0x0/0x70
[   32.441365]  [<c010440f>] kernel_thread_helper+0x7/0x18
[   32.441489]  =======================
[   32.452851] Bad IO access at port 0 (return inl(port))
[   32.452934] BUG: at lib/iomap.c:44 bad_io_access()
[   32.453016]  [<c01226b0>] process_timeout+0x0/0x10
[   32.453139]  [<c02b7801>] ioread32+0x21/0x30
[   32.453260]  [<c038839c>] sata_scr_read+0x2c/0x50
[   32.453383]  [<c038ba45>] sata_phy_debounce+0x95/0xe0
[   32.453506]  [<c038bafa>] sata_phy_resume+0x6a/0x80
[   32.453629]  [<c017f9c6>] mntput_no_expire+0x16/0xa0
[   32.453754]  [<c038ede1>] ata_std_prereset+0xb1/0xe0
[   32.453878]  [<c038b710>] ata_std_softreset+0x0/0x110
[   32.454002]  [<c0394d18>] ata_do_eh+0x898/0x1aa0
[   32.454125]  [<c02b091f>] _atomic_dec_and_lock+0x2f/0x50
[   32.454250]  [<c017f9c6>] mntput_no_expire+0x16/0xa0
[   32.454373]  [<c0172655>] link_path_walk+0x65/0xc0
[   32.454496]  [<c01728be>] do_path_lookup+0x8e/0x250
[   32.454620]  [<c01697df>] get_empty_filp+0x5f/0x120
[   32.454743]  [<c038b710>] ata_std_softreset+0x0/0x110
[   32.454867]  [<c038ed30>] ata_std_prereset+0x0/0xe0
[   32.454990]  [<c02b50ee>] vsnprintf+0x34e/0x5d0
[   32.455113]  [<c0102de8>] __switch_to+0x28/0x1a0
[   32.455234]  [<c03938e5>] ata_bmdma_irq_clear+0x15/0x30
[   32.455359]  [<c039379c>] ata_bmdma_drive_eh+0xac/0x140
[   32.455484]  [<c0378fe0>] scsi_error_handler+0x0/0x310
[   32.455608]  [<c038b430>] ata_std_postreset+0x0/0xb0
[   32.455731]  [<c038bbe0>] sata_std_hardreset+0x0/0xc0
[   32.455855]  [<c038ed30>] ata_std_prereset+0x0/0xe0
[   32.455979]  [<c0393863>] ata_bmdma_error_handler+0x33/0x40
[   32.456104]  [<c038bbe0>] sata_std_hardreset+0x0/0xc0
[   32.456228]  [<c038b430>] ata_std_postreset+0x0/0xb0
[   32.456351]  [<c03965a0>] ata_scsi_error+0x260/0x690
[   32.456476]  [<c0488123>] __sched_text_start+0x283/0x650
[   32.456601]  [<c0378fe0>] scsi_error_handler+0x0/0x310
[   32.456725]  [<c0379080>] scsi_error_handler+0xa0/0x310
[   32.456851]  [<c0378fe0>] scsi_error_handler+0x0/0x310
[   32.456976]  [<c0378fe0>] scsi_error_handler+0x0/0x310
[   32.457101]  [<c012ca82>] kthread+0x42/0x70
[   32.457221]  [<c012ca40>] kthread+0x0/0x70
[   32.457341]  [<c010440f>] kernel_thread_helper+0x7/0x18
[   32.457465]  =======================
[   32.468828] Bad IO access at port 0 (return inl(port))
[   32.468911] BUG: at lib/iomap.c:44 bad_io_access()
[   32.468993]  [<c01226b0>] process_timeout+0x0/0x10
[   32.469117]  [<c02b7801>] ioread32+0x21/0x30
[   32.469238]  [<c038839c>] sata_scr_read+0x2c/0x50
[   32.469362]  [<c038ba45>] sata_phy_debounce+0x95/0xe0
[   32.469486]  [<c038bafa>] sata_phy_resume+0x6a/0x80
[   32.469609]  [<c017f9c6>] mntput_no_expire+0x16/0xa0
[   32.469733]  [<c038ede1>] ata_std_prereset+0xb1/0xe0
[   32.469857]  [<c038b710>] ata_std_softreset+0x0/0x110
[   32.469981]  [<c0394d18>] ata_do_eh+0x898/0x1aa0
[   32.470104]  [<c02b091f>] _atomic_dec_and_lock+0x2f/0x50
[   32.470228]  [<c017f9c6>] mntput_no_expire+0x16/0xa0
[   32.470352]  [<c0172655>] link_path_walk+0x65/0xc0
[   32.470475]  [<c01728be>] do_path_lookup+0x8e/0x250
[   32.470598]  [<c01697df>] get_empty_filp+0x5f/0x120
[   32.470720]  [<c038b710>] ata_std_softreset+0x0/0x110
[   32.470844]  [<c038ed30>] ata_std_prereset+0x0/0xe0
[   32.470967]  [<c02b50ee>] vsnprintf+0x34e/0x5d0
[   32.471090]  [<c0102de8>] __switch_to+0x28/0x1a0
[   32.471211]  [<c03938e5>] ata_bmdma_irq_clear+0x15/0x30
[   32.471336]  [<c039379c>] ata_bmdma_drive_eh+0xac/0x140
[   32.471460]  [<c0378fe0>] scsi_error_handler+0x0/0x310
[   32.471585]  [<c038b430>] ata_std_postreset+0x0/0xb0
[   32.471709]  [<c038bbe0>] sata_std_hardreset+0x0/0xc0
[   32.471832]  [<c038ed30>] ata_std_prereset+0x0/0xe0
[   32.471955]  [<c0393863>] ata_bmdma_error_handler+0x33/0x40
[   32.472082]  [<c038bbe0>] sata_std_hardreset+0x0/0xc0
[   32.472205]  [<c038b430>] ata_std_postreset+0x0/0xb0
[   32.472328]  [<c03965a0>] ata_scsi_error+0x260/0x690
[   32.472453]  [<c0488123>] __sched_text_start+0x283/0x650
[   32.472577]  [<c0378fe0>] scsi_error_handler+0x0/0x310
[   32.472702]  [<c0379080>] scsi_error_handler+0xa0/0x310
[   32.472828]  [<c0378fe0>] scsi_error_handler+0x0/0x310
[   32.472954]  [<c0378fe0>] scsi_error_handler+0x0/0x310
[   32.473079]  [<c012ca82>] kthread+0x42/0x70
[   32.473199]  [<c012ca40>] kthread+0x0/0x70
[   32.473319]  [<c010440f>] kernel_thread_helper+0x7/0x18
[   32.473444]  =======================
[   32.520755] ata3: SATA link down (SStatus FFFFFFFF SControl FFFFFFFF)
[   32.832296] ata4: SATA link down (SStatus FFFFFFFF SControl FFFFFFFF)
[   32.999603] ATA: abnormal status 0x8 on port 0x00019c07
[   32.999745] ieee1394: raw1394: /dev/raw1394 device initialized
[   32.999986] eth1394: eth2: IPv4 over IEEE 1394 (fw-host0)
[   33.000555] ACPI: PCI Interrupt Link [LUB2] enabled at IRQ 9
[   33.000643] ACPI: PCI Interrupt 0000:00:02.2[C] -> Link [LUB2] -> GSI 9 (level, low) -> IRQ 9
[   33.000854] PCI: Setting latency timer of device 0000:00:02.2 to 64
[   33.000858] ehci_hcd 0000:00:02.2: EHCI Host Controller
[   33.001004] ehci_hcd 0000:00:02.2: new USB bus registered, assigned bus number 1
[   33.001161] ehci_hcd 0000:00:02.2: debug port 1
[   33.001245] PCI: cache line size of 64 is not supported by device 0000:00:02.2
[   33.001254] ehci_hcd 0000:00:02.2: irq 9, io mem 0xe8085000
[   33.001345] ehci_hcd 0000:00:02.2: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
[   33.001618] usb usb1: configuration #1 chosen from 1 choice
[   33.001747] hub 1-0:1.0: USB hub found
[   33.001837] hub 1-0:1.0: 6 ports detected
[   33.103961] ohci_hcd: 2006 August 04 USB 1.1 'Open' Host Controller (OHCI) Driver
[   33.104247] ACPI: PCI Interrupt Link [LUBA] enabled at IRQ 12
[   33.104334] ACPI: PCI Interrupt 0000:00:02.0[A] -> Link [LUBA] -> GSI 12 (level, low) -> IRQ 12
[   33.104544] PCI: Setting latency timer of device 0000:00:02.0 to 64
[   33.104548] ohci_hcd 0000:00:02.0: OHCI Host Controller
[   33.104667] ohci_hcd 0000:00:02.0: new USB bus registered, assigned bus number 2
[   33.104796] ohci_hcd 0000:00:02.0: irq 12, io mem 0xe8081000
[   33.161904] usb usb2: configuration #1 chosen from 1 choice
[   33.162024] hub 2-0:1.0: USB hub found
[   33.162114] hub 2-0:1.0: 3 ports detected
[   33.263929] ACPI: PCI Interrupt Link [LUBB] enabled at IRQ 11
[   33.264016] ACPI: PCI Interrupt 0000:00:02.1[B] -> Link [LUBB] -> GSI 11 (level, low) -> IRQ 11
[   33.264224] PCI: Setting latency timer of device 0000:00:02.1 to 64
[   33.264227] ohci_hcd 0000:00:02.1: OHCI Host Controller
[   33.264347] ohci_hcd 0000:00:02.1: new USB bus registered, assigned bus number 3
[   33.264473] ohci_hcd 0000:00:02.1: irq 11, io mem 0xe8084000
[   33.321677] usb usb3: configuration #1 chosen from 1 choice
[   33.321803] hub 3-0:1.0: USB hub found
[   33.321892] hub 3-0:1.0: 3 ports detected
[   33.423489] USB Universal Host Controller Interface driver v3.0
[   33.782903] usb 3-1: new low speed USB device using ohci_hcd and address 2
[   33.949621] usb 3-1: configuration #1 chosen from 1 choice
[   34.108086] ohci1394: fw-host0: SelfID received outside of bus reset sequence
[   34.298147] usb 3-2: new full speed USB device using ohci_hcd and address 3
[   34.465758] usb 3-2: configuration #1 chosen from 1 choice
[   34.475708] drivers/usb/class/usblp.c: usblp0: USB Bidirectional printer dev 3 if 0 alt 0 proto 2 vid 0x04E8 pid 0x326C
[   34.475850] usbcore: registered new interface driver usblp
[   34.475936] drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
[   34.476027] Initializing USB Mass Storage driver...
[   34.476148] usbcore: registered new interface driver usb-storage
[   34.476235] USB Mass Storage support registered.
[   34.476388] PNP: PS/2 Controller [PNP0303:PS2K] at 0x60,0x64 irq 1
[   34.476476] PNP: PS/2 controller doesn't have AUX irq; using default 12
[   34.725901] serio: i8042 KBD port at 0x60,0x64 irq 1
[   34.726079] mice: PS/2 mouse device common for all mice
[   34.752830] input: AT Translated Set 2 keyboard as /class/input/input2
[   34.752935] md: raid0 personality registered for level 0
[   34.753086] device-mapper: ioctl: 4.11.0-ioctl (2006-10-12) initialised: dm-devel@redhat.com
[   34.760441] input: Logitech USB-PS/2 Mouse as /class/input/input3
[   34.760564] input: USB HID v1.00 Mouse [Logitech USB-PS/2 Mouse] on usb-0000:00:02.1-1
[   34.760779] usbcore: registered new interface driver usbhid
[   34.760866] drivers/hid/usbhid/hid-core.c: v2.6:USB HID core driver
[   34.760981] Advanced Linux Sound Architecture Driver Version 1.0.14rc4 (Wed May 09 09:51:39 2007 UTC).
[   34.761105] ALSA device list:
[   34.761193]   No soundcards found.
[   34.761292] IPv4 over IPv4 tunneling driver
[   34.761445] GRE over IPv4 tunneling driver
[   34.761604] TCP cubic registered
[   34.761688] NET: Registered protocol family 1
[   34.761771] NET: Registered protocol family 17
[   34.761889] Testing NMI watchdog ... OK.
[   34.841339] Using IPI Shortcut mode
[   34.841716] md: Autodetecting RAID arrays.
[   34.841798] md: autorun ...
[   34.841873] md: ... autorun DONE.
[   34.858241] ReiserFS: hda2: found reiserfs format "3.6" with standard journal
[   34.858339] ReiserFS: hda2: using ordered data mode
[   34.863578] ReiserFS: hda2: journal params: device hda2, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
[   34.865233] ReiserFS: hda2: checking transaction log (hda2)
[   34.910846] ReiserFS: hda2: Using r5 hash to sort names
[   34.910956] VFS: Mounted root (reiserfs filesystem) readonly.
[   34.911341] Freeing unused kernel memory: 208k freed
[   37.908491] i2c-adapter i2c-0: nForce2 SMBus adapter at 0x5000
[   37.908514] i2c-adapter i2c-1: nForce2 SMBus adapter at 0x5500
[   38.441337] ACPI: PCI Interrupt Link [LACI] enabled at IRQ 11
[   38.441343] ACPI: PCI Interrupt 0000:00:06.0[A] -> Link [LACI] -> GSI 11 (level, low) -> IRQ 11
[   38.441372] PCI: Setting latency timer of device 0000:00:06.0 to 64
[   38.759638] intel8x0_measure_ac97_clock: measured 52781 usecs
[   38.759644] intel8x0: clocking to 47503
[   56.760486] ReiserFS: dm-0: found reiserfs format "3.6" with standard journal
[   56.760507] ReiserFS: dm-0: using ordered data mode
[   56.760684] ReiserFS: dm-0: journal params: device dm-0, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
[   56.762260] ReiserFS: dm-0: checking transaction log (dm-0)
[   56.779528] ReiserFS: dm-0: Using r5 hash to sort names
[   60.316791] Adding 2097144k swap on /mnt/raidchunk/swapfile.bin.  Priority:-1 extents:457 across:2100884k
[   65.504930] eth1: no link during initialization.
[   91.651175] eth0: network connection up using port A
[   91.651182]     speed:           1000
[   91.651184]     autonegotiation: yes
[   91.651185]     duplex mode:     full
[   91.651187]     flowctrl:        symmetric
[   91.651189]     role:            slave
[   91.651190]     irq moderation:  disabled
[   91.651192]     scatter-gather:  disabled
[   91.651194]     tx-checksum:     disabled
[   91.651195]     rx-checksum:     disabled

--------------090608090205050902060103
Content-Type: text/plain;
 name="dmesg_subsection-2.6.21.1.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg_subsection-2.6.21.1.txt"

[   30.980942] sata_via 0000:01:07.0: version 2.1
[   30.981275] ACPI: PCI Interrupt Link [LNK4] enabled at IRQ 12
[   30.981279] ACPI: PCI Interrupt 0000:01:07.0[A] -> Link [LNK4] -> GSI 12 (level, low) -> IRQ 12
[   30.981298] sata_via 0000:01:07.0: routed to hard irq line 12
[   30.981367] ata3: SATA max UDMA/133 cmd 0x00019400 ctl 0x0001940a bmdma 0x0001a400 irq 12
[   30.981403] ata4: SATA max UDMA/133 cmd 0x00019800 ctl 0x0001980a bmdma 0x0001a408 irq 12
[   30.981437] ata5: PATA max UDMA/133 cmd 0x00019c00 ctl 0x00019c0a bmdma 0x0001a410 irq 12
[   30.981454] scsi2 : sata_via
[   31.120479] ACPI: PCI Interrupt Link [LACI] enabled at IRQ 11
[   31.120486] ACPI: PCI Interrupt 0000:00:06.0[A] -> Link [LACI] -> GSI 11 (level, low) -> IRQ 11
[   31.120520] PCI: Setting latency timer of device 0000:00:06.0 to 64
[   31.135776] ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[   31.144016] ata3.00: ATA-7: WDC WD3200AAKS-00SBA0, 12.01B01, max UDMA/133
[   31.144021] ata3.00: 625142448 sectors, multi 0: LBA48 NCQ (depth 0/32)
[   31.152025] ata3.00: configured for UDMA/133
[   31.152047] scsi3 : sata_via
[   31.307512] ata4: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[   31.324869] ata4.00: failed to IDENTIFY (I/O error, err_mask=0x1)
[   31.443258] intel8x0_measure_ac97_clock: measured 52722 usecs
[   31.443264] intel8x0: clocking to 47450
[   31.982496] ata4: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[   31.995489] ata4.00: failed to IDENTIFY (I/O error, err_mask=0x1)
[   31.995495] ata4.00: limiting speed to UDMA7:PIO5
[   32.653509] ata4: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[   32.666118] ata4.00: ATA-7: WDC WD3200AAKS-00SBA0, 12.01B01, max UDMA/133
[   32.666122] ata4.00: 625142448 sectors, multi 0: LBA48 NCQ (depth 0/32)
[   32.680112] ata4.00: failed to IDENTIFY (I/O error, err_mask=0x1)
[   32.680115] ata4.00: revalidation failed (errno=-5)
[   32.680117] ata4.00: disabled
[   33.180715] scsi4 : sata_via
[   33.348013] ATA: abnormal status 0x8 on port 0x00019c07
[   33.348122] scsi 2:0:0:0: Direct-Access     ATA      WDC WD3200AAKS-0 12.0 PQ: 0 ANSI: 5
[   33.348313] SCSI device sdc: 625142448 512-byte hdwr sectors (320073 MB)
[   33.348327] sdc: Write Protect is off
[   33.348329] sdc: Mode Sense: 00 3a 00 00
[   33.348344] SCSI device sdc: write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   33.348412] SCSI device sdc: 625142448 512-byte hdwr sectors (320073 MB)
[   33.348422] sdc: Write Protect is off
[   33.348424] sdc: Mode Sense: 00 3a 00 00
[   33.348438] SCSI device sdc: write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   33.348442]  sdc: unknown partition table
[   33.364613] sd 2:0:0:0: Attached scsi disk sdc
[   33.364769] sd 2:0:0:0: Attached scsi generic sg2 type 0

--------------090608090205050902060103--
