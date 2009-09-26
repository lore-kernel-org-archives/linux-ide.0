From: Walter Hutchins <hutchwa@gmail.com>
Subject: Re: [PATCH #upstream-fixes] sata_promise: request follow-up SRST
Date: Sat, 26 Sep 2009 14:42:25 -0400
Message-ID: <898aa1e70909261142xeef5807o5481fca7a052388a@mail.gmail.com>
References: <898aa1e70909242224n19c449b0s959f9f56f3ed63ff@mail.gmail.com>
	 <4ABD8334.2090000@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gx0-f212.google.com ([209.85.217.212]:34936 "EHLO
	mail-gx0-f212.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751446AbZIZStd (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 26 Sep 2009 14:49:33 -0400
Received: by gxk4 with SMTP id 4so1595108gxk.8
        for <linux-ide@vger.kernel.org>; Sat, 26 Sep 2009 11:49:36 -0700 (PDT)
In-Reply-To: <4ABD8334.2090000@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: linux-ide@vger.kernel.org

On Fri, Sep 25, 2009 at 10:57 PM, Robert Hancock <hancockrwd@gmail.com> wrote:
>
> Is the controller you are using designed to work with eSATA? Although a
> non-eSATA compliant controller will often work by connecting an eSATA
> adapter to the internal SATA ports, actually eSATA is supposed to use higher
> signalling voltage and it may not be reliable when used in this way.
>

The full product name is SATA 300 TX4302.
This card has 2 standard internal sata ports and 2 external esata ports.
The detection does not distinguish this card from TX4.

SATA300 TX4302 BIOS Version 1.00.0.36

           (external)
 ____ port 2 _____ port 1 _____|  esata connectors
 |
-M
-o
-b
-d
 |
 |____ port 4 ______ port 3 ____  sata connectors
            (internal)

Actually, the enforced remap order 3102 is wrong for TX4302.
It should be 1302 for this board.
Menuconfig should allow option to remap 1302 for users of this board.
Menuconfig could have option to not remap which would use 0123 which
is the native order and would do nothing.
Or even the option to pick from all possible remap options
0123 0132 0213 0231 0312 0321
1023 1032 1203 1230 1302 1320
2013 2031 2103 2130 2301 2310
3012 3021 3102 3120 3201 3210
since on a given card the remap order is different.

The the enforced remap of 1302 has given me headaches for this board,
ever since 2.6.22.
To ease the headache I would apply a patch reversing the 1 and the 3.
In the output below, I didn't use my 1-3 patch, but instead connected
the cable which becomes sda to Port 2
and the cable which becomes sdb to Port 1.

I have on order, some ide-sata converters which will be used to test the
order on the internal 02 ports (I have no internal sata drives).
Also on order, is a sil 3124 which will tell if errors continue on the
WD or if sata_promise driver is at fault.

Anyway, you asked, and yes it is designed for esata and
yes, you can boot from esata.

>
> Can you post the full dmesg output from bootup and the errors?
>

OK

uname -a
Linux lfs 2.6.31-reset-updates-v1-2.6.28 #1 Sat Sep 26 12:47:27 EDT
2009 i686 pentium3 i386 GNU/Linux

Here is from sys.log and lspci

Sep 26 12:58:38 lfs syslogd 1.5.0: restart.
Sep 26 12:58:38 lfs kernel: klogd 1.5.0, log source = /proc/kmsg started.
Sep 26 12:58:38 lfs kernel: Inspecting
/boot/System.map-2.6.31-reset-updates-v1-2.6.28
Sep 26 12:58:38 lfs kernel: Cannot find map file.
Sep 26 12:58:38 lfs kernel: Loaded 15175 symbols from 3 modules.
Sep 26 12:58:38 lfs kernel:
Sep 26 12:58:38 lfs kernel:   C8000-EFFFF uncachable
Sep 26 12:58:38 lfs kernel:   F0000-FFFFF write-protect
Sep 26 12:58:38 lfs kernel: MTRR variable ranges enabled:
Sep 26 12:58:38 lfs kernel:   0 base 000000000 mask FC0000000 write-back
Sep 26 12:58:38 lfs kernel:   1 base 040000000 mask FE0000000 write-back
Sep 26 12:58:38 lfs kernel:   2 base 0E4000000 mask FFC000000 write-combining
Sep 26 12:58:38 lfs kernel:   3 disabled
Sep 26 12:58:38 lfs kernel:   4 disabled
Sep 26 12:58:38 lfs kernel:   5 disabled
Sep 26 12:58:38 lfs kernel:   6 disabled
Sep 26 12:58:38 lfs kernel:   7 disabled
Sep 26 12:58:38 lfs kernel: initial memory mapped : 0 - 01800000
Sep 26 12:58:38 lfs kernel: init_memory_mapping:
0000000000000000-00000000377fe000
Sep 26 12:58:38 lfs kernel:  0000000000 - 0000400000 page 4k
Sep 26 12:58:38 lfs kernel:  0000400000 - 0037400000 page 2M
Sep 26 12:58:38 lfs kernel:  0037400000 - 00377fe000 page 4k
Sep 26 12:58:38 lfs kernel: kernel direct mapping tables up to
377fe000 @ 7000-c000
Sep 26 12:58:38 lfs kernel: ACPI: RSDP 000f5a60 00014 (v00 ASUS  )
Sep 26 12:58:38 lfs kernel: ACPI: RSDT 5fffc000 0002C (v01 ASUS
P3V_4X   30303031 MSFT 31313031)
Sep 26 12:58:38 lfs kernel: ACPI: FACP 5fffc080 00074 (v01 ASUS
P3V_4X   30303031 MSFT 31313031)
Sep 26 12:58:38 lfs kernel: ACPI: DSDT 5fffc100 02290 (v01   ASUS
P3V_4X   00001000 MSFT 0100000B)
Sep 26 12:58:38 lfs kernel: ACPI: FACS 5ffff000 00040
Sep 26 12:58:38 lfs kernel: ACPI: BOOT 5fffc040 00028 (v01 ASUS
P3V_4X   30303031 MSFT 31313031)
Sep 26 12:58:38 lfs kernel: 647MB HIGHMEM available.
Sep 26 12:58:38 lfs kernel: 887MB LOWMEM available.
Sep 26 12:58:38 lfs kernel:   mapped low ram: 0 - 377fe000
Sep 26 12:58:38 lfs kernel:   low ram: 0 - 377fe000
Sep 26 12:58:38 lfs kernel:   node 0 low ram: 00000000 - 377fe000
Sep 26 12:58:38 lfs kernel:   node 0 bootmap 00008000 - 0000ef00
Sep 26 12:58:38 lfs kernel: (6 early reservations) ==> bootmem
[0000000000 - 00377fe000]
Sep 26 12:58:38 lfs kernel:   #0 [0000000000 - 0000001000]   BIOS data
page ==> [0000000000 - 0000001000]
Sep 26 12:58:38 lfs kernel:   #1 [0001000000 - 000142933c]    TEXT
DATA BSS ==> [0001000000 - 000142933c]
Sep 26 12:58:38 lfs kernel:   #2 [000009d400 - 0000100000]    BIOS
reserved ==> [000009d400 - 0000100000]
Sep 26 12:58:38 lfs kernel:   #3 [000142a000 - 0001430115]
 BRK ==> [000142a000 - 0001430115]
Sep 26 12:58:38 lfs kernel:   #4 [0000007000 - 0000008000]
PGTABLE ==> [0000007000 - 0000008000]
Sep 26 12:58:38 lfs kernel:   #5 [0000008000 - 000000f000]
BOOTMAP ==> [0000008000 - 000000f000]
Sep 26 12:58:38 lfs kernel: Zone PFN ranges:
Sep 26 12:58:38 lfs kernel:   DMA      0x00000000 -> 0x00001000
Sep 26 12:58:38 lfs kernel:   Normal   0x00001000 -> 0x000377fe
Sep 26 12:58:38 lfs kernel:   HighMem  0x000377fe -> 0x0005fffc
Sep 26 12:58:38 lfs kernel: Movable zone start PFN for each node
Sep 26 12:58:38 lfs kernel: early_node_map[2] active PFN ranges
Sep 26 12:58:38 lfs kernel:     0: 0x00000000 -> 0x0000009d
Sep 26 12:58:38 lfs kernel:     0: 0x00000100 -> 0x0005fffc
Sep 26 12:58:38 lfs kernel: On node 0 totalpages: 393113
Sep 26 12:58:38 lfs kernel: free_area_init_node: node 0, pgdat
c13b6450, node_mem_map c1431000
Sep 26 12:58:38 lfs kernel:   DMA zone: 32 pages used for memmap
Sep 26 12:58:38 lfs kernel:   DMA zone: 0 pages reserved
Sep 26 12:58:38 lfs kernel:   DMA zone: 3965 pages, LIFO batch:0
Sep 26 12:58:38 lfs kernel:   Normal zone: 1744 pages used for memmap
Sep 26 12:58:38 lfs kernel:   Normal zone: 221486 pages, LIFO batch:31
Sep 26 12:58:38 lfs kernel:   HighMem zone: 1296 pages used for memmap
Sep 26 12:58:38 lfs kernel:   HighMem zone: 164590 pages, LIFO batch:31
Sep 26 12:58:38 lfs kernel: Using APIC driver default
Sep 26 12:58:38 lfs kernel: ACPI: PM-Timer IO Port: 0xe408
Sep 26 12:58:38 lfs kernel: Local APIC disabled by BIOS -- you can
enable it with "lapic"
Sep 26 12:58:38 lfs kernel: APIC: disable apic facility
Sep 26 12:58:38 lfs kernel: nr_irqs_gsi: 16
Sep 26 12:58:38 lfs kernel: Allocating PCI resources starting at
60000000 (gap: 60000000:9fff0000)
Sep 26 12:58:38 lfs kernel: Built 1 zonelists in Zone order, mobility
grouping on.  Total pages: 390041
Sep 26 12:58:38 lfs kernel: Kernel command line: root=/dev/sda11
ide_core.noprobe=0.0 ide_core.noprobe=0.1
Sep 26 12:58:38 lfs kernel: PID hash table entries: 4096 (order: 12,
16384 bytes)
Sep 26 12:58:38 lfs kernel: Dentry cache hash table entries: 131072
(order: 7, 524288 bytes)
Sep 26 12:58:38 lfs kernel: Inode-cache hash table entries: 65536
(order: 6, 262144 bytes)
Sep 26 12:58:38 lfs kernel: Enabling fast FPU save and restore... done.
Sep 26 12:58:38 lfs kernel: Enabling unmasked SIMD FPU exception
support... done.
Sep 26 12:58:38 lfs kernel: Initializing CPU#0
Sep 26 12:58:38 lfs kernel: Initializing HighMem for node 0 (000377fe:0005fffc)
Sep 26 12:58:38 lfs kernel: Memory: 1554256k/1572848k available (2494k
kernel code, 17408k reserved, 1319k data, 256k init, 663544k highmem)
Sep 26 12:58:38 lfs kernel: virtual kernel memory layout:
Sep 26 12:58:38 lfs kernel:     fixmap  : 0xfffa4000 - 0xfffff000   ( 364 kB)
Sep 26 12:58:38 lfs kernel:     pkmap   : 0xff800000 - 0xffc00000   (4096 kB)
Sep 26 12:58:38 lfs kernel:     vmalloc : 0xf7ffe000 - 0xff7fe000   ( 120 MB)
Sep 26 12:58:38 lfs kernel:     lowmem  : 0xc0000000 - 0xf77fe000   ( 887 MB)
Sep 26 12:58:38 lfs kernel:       .init : 0xc13ba000 - 0xc13fa000   ( 256 kB)
Sep 26 12:58:38 lfs kernel:       .data : 0xc126fa67 - 0xc13b9778   (1319 kB)
Sep 26 12:58:38 lfs kernel:       .text : 0xc1000000 - 0xc126fa67   (2494 kB)
Sep 26 12:58:38 lfs kernel: Checking if this processor honours the WP
bit even in supervisor mode...Ok.
Sep 26 12:58:38 lfs kernel: NR_IRQS:288
Sep 26 12:58:38 lfs kernel: Fast TSC calibration using PIT
Sep 26 12:58:38 lfs kernel: Detected 802.987 MHz processor.
Sep 26 12:58:38 lfs kernel: Console: colour VGA+ 80x25
Sep 26 12:58:38 lfs kernel: console [tty0] enabled
Sep 26 12:58:38 lfs kernel: Calibrating delay loop (skipped), value
calculated using timer frequency.. 1605.97 BogoMIPS (lpj=802987)
Sep 26 12:58:38 lfs kernel: Mount-cache hash table entries: 512
Sep 26 12:58:38 lfs kernel: CPU: L1 I cache: 16K, L1 D cache: 16K
Sep 26 12:58:38 lfs kernel: CPU: L2 cache: 256K
Sep 26 12:58:38 lfs kernel: mce: CPU supports 5 MCE banks
Sep 26 12:58:38 lfs kernel: CPU: Intel Pentium III (Coppermine) stepping 06
Sep 26 12:58:38 lfs kernel: Checking 'hlt' instruction... OK.
Sep 26 12:58:38 lfs kernel: ACPI: Core revision 20090521
Sep 26 12:58:38 lfs kernel: ACPI: setting ELCR to 0200 (from 0e20)
Sep 26 12:58:38 lfs kernel: NET: Registered protocol family 16
Sep 26 12:58:38 lfs kernel: ACPI: bus type pci registered
Sep 26 12:58:38 lfs kernel: PCI: PCI BIOS revision 2.10 entry at
0xf0890, last bus=1
Sep 26 12:58:38 lfs kernel: PCI: Using configuration type 1 for base access
Sep 26 12:58:38 lfs kernel: bio: create slab <bio-0> at 0
Sep 26 12:58:38 lfs kernel: ACPI: EC: Look up EC in DSDT
Sep 26 12:58:38 lfs kernel: ACPI: Interpreter enabled
Sep 26 12:58:38 lfs kernel: ACPI: (supports S0 S1 S5)
Sep 26 12:58:38 lfs kernel: ACPI: Using PIC for interrupt routing
Sep 26 12:58:38 lfs kernel: ACPI: No dock devices found.
Sep 26 12:58:38 lfs kernel: ACPI: PCI Root Bridge [PCI0] (0000:00)
Sep 26 12:58:38 lfs kernel: pci 0000:00:00.0: reg 10 32bit mmio:
[0xe4000000-0xe7ffffff]
Sep 26 12:58:38 lfs kernel: pci 0000:00:01.0: supports D1
Sep 26 12:58:38 lfs kernel: pci 0000:00:04.1: reg 20 io port: [0xd800-0xd80f]
Sep 26 12:58:38 lfs kernel: pci 0000:00:04.2: reg 20 io port: [0xd400-0xd41f]
Sep 26 12:58:38 lfs kernel: pci 0000:00:09.0: reg 10 io port: [0xd000-0xd0ff]
Sep 26 12:58:38 lfs kernel: pci 0000:00:09.0: reg 14 32bit mmio:
[0xd5800000-0xd58003ff]
Sep 26 12:58:38 lfs kernel: pci 0000:00:09.0: reg 30 32bit mmio:
[0x000000-0x01ffff]
Sep 26 12:58:38 lfs kernel: pci 0000:00:09.0: supports D1 D2
Sep 26 12:58:38 lfs kernel: pci 0000:00:09.0: PME# supported from D0
D1 D2 D3hot D3cold
Sep 26 12:58:38 lfs kernel: pci 0000:00:09.0: PME# disabled
Sep 26 12:58:38 lfs kernel: pci 0000:00:0a.0: reg 10 32bit mmio:
[0xd5000000-0xd50fffff]
Sep 26 12:58:38 lfs kernel: pci 0000:00:0b.0: reg 10 io port: [0xb800-0xb83f]
Sep 26 12:58:38 lfs kernel: pci 0000:00:0b.0: supports D2
Sep 26 12:58:38 lfs kernel: pci 0000:00:0c.0: reg 10 io port: [0xb400-0xb407]
Sep 26 12:58:38 lfs kernel: pci 0000:00:0c.0: reg 14 io port: [0xb000-0xb003]
Sep 26 12:58:38 lfs kernel: pci 0000:00:0c.0: reg 18 io port: [0xa800-0xa807]
Sep 26 12:58:38 lfs kernel: pci 0000:00:0c.0: reg 1c io port: [0xa400-0xa403]
Sep 26 12:58:38 lfs kernel: pci 0000:00:0c.0: reg 20 io port: [0xa000-0xa00f]
Sep 26 12:58:38 lfs kernel: pci 0000:00:0c.0: reg 24 32bit mmio:
[0xd4800000-0xd4803fff]
Sep 26 12:58:38 lfs kernel: pci 0000:00:0c.0: reg 30 32bit mmio:
[0x000000-0x003fff]
Sep 26 12:58:38 lfs kernel: pci 0000:00:0c.0: supports D1
Sep 26 12:58:38 lfs kernel: pci 0000:00:0d.0: reg 10 32bit mmio:
[0xd4000000-0xd40000ff]
Sep 26 12:58:38 lfs kernel: pci 0000:00:0d.0: reg 14 io port: [0x9800-0x9807]
Sep 26 12:58:38 lfs kernel: pci 0000:00:0d.0: reg 18 io port: [0x9400-0x94ff]
Sep 26 12:58:38 lfs kernel: pci 0000:00:0d.0: supports D2
Sep 26 12:58:38 lfs kernel: pci 0000:00:0d.0: PME# supported from D2
D3hot D3cold
Sep 26 12:58:38 lfs kernel: pci 0000:00:0d.0: PME# disabled
Sep 26 12:58:38 lfs kernel: pci 0000:00:0e.0: reg 10 io port: [0x9000-0x907f]
Sep 26 12:58:38 lfs kernel: pci 0000:00:0e.0: reg 18 io port: [0x8800-0x88ff]
Sep 26 12:58:38 lfs kernel: pci 0000:00:0e.0: reg 1c 32bit mmio:
[0xd3800000-0xd3800fff]
Sep 26 12:58:38 lfs kernel: pci 0000:00:0e.0: reg 20 32bit mmio:
[0xd3000000-0xd301ffff]
Sep 26 12:58:38 lfs kernel: pci 0000:00:0e.0: reg 30 32bit mmio:
[0x000000-0x007fff]
Sep 26 12:58:38 lfs kernel: pci 0000:00:0e.0: supports D1
Sep 26 12:58:38 lfs kernel: pci 0000:01:00.0: reg 10 32bit mmio:
[0xd6000000-0xd6ffffff]
Sep 26 12:58:38 lfs kernel: pci 0000:01:00.0: reg 14 32bit mmio:
[0xd8000000-0xdfffffff]
Sep 26 12:58:38 lfs kernel: pci 0000:01:00.0: reg 30 32bit mmio:
[0xd7ff0000-0xd7ffffff]
Sep 26 12:58:38 lfs kernel: pci 0000:00:01.0: bridge 32bit mmio:
[0xd6000000-0xd7dfffff]
Sep 26 12:58:38 lfs kernel: pci 0000:00:01.0: bridge 32bit mmio pref:
[0xd7f00000-0xe3ffffff]
Sep 26 12:58:38 lfs kernel: pci_bus 0000:00: on NUMA node 0
Sep 26 12:58:38 lfs kernel: ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
Sep 26 12:58:38 lfs kernel: ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4
5 6 7 9 10 *11 12 14 15)
Sep 26 12:58:38 lfs kernel: ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4
5 6 7 9 *10 11 12 14 15)
Sep 26 12:58:38 lfs kernel: ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4
*5 6 7 9 10 11 12 14 15)
Sep 26 12:58:38 lfs kernel: ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4
5 6 7 *9 10 11 12 14 15)
Sep 26 12:58:38 lfs kernel: SCSI subsystem initialized
Sep 26 12:58:38 lfs kernel: libata version 3.00 loaded.
Sep 26 12:58:38 lfs kernel: usbcore: registered new interface driver usbfs
Sep 26 12:58:38 lfs kernel: usbcore: registered new interface driver hub
Sep 26 12:58:38 lfs kernel: usbcore: registered new device driver usb
Sep 26 12:58:38 lfs kernel: PCI: Using ACPI for IRQ routing
Sep 26 12:58:38 lfs kernel: pnp: PnP ACPI init
Sep 26 12:58:38 lfs kernel: ACPI: bus type pnp registered
Sep 26 12:58:38 lfs kernel: pnp: PnP ACPI: found 14 devices
Sep 26 12:58:38 lfs kernel: ACPI: ACPI bus type pnp unregistered
Sep 26 12:58:38 lfs kernel: system 00:00: iomem range 0x0-0x9ffff
could not be reserved
Sep 26 12:58:38 lfs kernel: system 00:00: iomem range 0xf0000-0xfffff
could not be reserved
Sep 26 12:58:38 lfs kernel: system 00:00: iomem range
0x100000-0x5fffffff could not be reserved
Sep 26 12:58:38 lfs kernel: system 00:00: iomem range
0xfffe0000-0xffffffff could not be reserved
Sep 26 12:58:38 lfs kernel: system 00:02: ioport range 0x3f0-0x3f1 has
been reserved
Sep 26 12:58:38 lfs kernel: system 00:02: ioport range 0x4d0-0x4d1 has
been reserved
Sep 26 12:58:38 lfs kernel: system 00:03: ioport range 0xe400-0xe47f
has been reserved
Sep 26 12:58:38 lfs kernel: system 00:03: ioport range 0xe800-0xe80f
has been reserved
Sep 26 12:58:38 lfs kernel: pci 0000:00:01.0: PCI bridge, secondary bus 0000:01
Sep 26 12:58:38 lfs kernel: pci 0000:00:01.0:   IO window: disabled
Sep 26 12:58:38 lfs kernel: pci 0000:00:01.0:   MEM window:
0xd6000000-0xd7dfffff
Sep 26 12:58:38 lfs kernel: pci 0000:00:01.0:   PREFETCH window:
0xd7f00000-0xe3ffffff
Sep 26 12:58:38 lfs kernel: pci 0000:00:01.0: setting latency timer to 64
Sep 26 12:58:38 lfs kernel: pci_bus 0000:00: resource 0 io:  [0x00-0xffff]
Sep 26 12:58:38 lfs kernel: pci_bus 0000:00: resource 1 mem:
[0x000000-0xffffffff]
Sep 26 12:58:38 lfs kernel: pci_bus 0000:01: resource 1 mem:
[0xd6000000-0xd7dfffff]
Sep 26 12:58:38 lfs kernel: pci_bus 0000:01: resource 2 pref mem
[0xd7f00000-0xe3ffffff]
Sep 26 12:58:38 lfs kernel: NET: Registered protocol family 2
Sep 26 12:58:38 lfs kernel: IP route cache hash table entries: 32768
(order: 5, 131072 bytes)
Sep 26 12:58:38 lfs kernel: TCP established hash table entries: 131072
(order: 8, 1048576 bytes)
Sep 26 12:58:38 lfs kernel: TCP bind hash table entries: 65536 (order:
6, 262144 bytes)
Sep 26 12:58:38 lfs kernel: TCP: Hash tables configured (established
131072 bind 65536)
Sep 26 12:58:38 lfs kernel: TCP reno registered
Sep 26 12:58:38 lfs kernel: NET: Registered protocol family 1
Sep 26 12:58:38 lfs kernel: Simple Boot Flag at 0x3a set to 0x1
Sep 26 12:58:38 lfs kernel: highmem bounce pool size: 64 pages
Sep 26 12:58:38 lfs kernel: msgmni has been set to 1741
Sep 26 12:58:38 lfs kernel: io scheduler noop registered
Sep 26 12:58:38 lfs kernel: io scheduler cfq registered (default)
Sep 26 12:58:38 lfs kernel: pci 0000:00:01.0: disabling DAC on VIA PCI bridge
Sep 26 12:58:38 lfs kernel: pci 0000:00:04.0: Activating ISA DMA hang
workarounds
Sep 26 12:58:38 lfs kernel: pci 0000:01:00.0: Boot video device
Sep 26 12:58:38 lfs kernel: lp: driver loaded but no devices found
Sep 26 12:58:38 lfs kernel: Real Time Clock Driver v1.12b
Sep 26 12:58:38 lfs kernel: Non-volatile memory driver v1.3
Sep 26 12:58:38 lfs kernel: Linux agpgart interface v0.103
Sep 26 12:58:38 lfs kernel: agpgart: Detected VIA Apollo Pro 133 chipset
Sep 26 12:58:38 lfs kernel: agpgart-via 0000:00:00.0: AGP aperture is
64M @ 0xe4000000
Sep 26 12:58:38 lfs kernel: [drm] Initialized drm 1.1.0 20060810
Sep 26 12:58:38 lfs kernel: Serial: 8250/16550 driver, 4 ports, IRQ
sharing disabled
Sep 26 12:58:38 lfs kernel: serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Sep 26 12:58:38 lfs kernel: serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
Sep 26 12:58:38 lfs kernel: 00:0a: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Sep 26 12:58:38 lfs kernel: 00:0b: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
Sep 26 12:58:38 lfs kernel: parport_pc 00:09: reported by Plug and Play ACPI
Sep 26 12:58:38 lfs kernel: parport0: PC-style at 0x378 (0x778), irq 7
[PCSPP,TRISTATE,EPP]
Sep 26 12:58:38 lfs kernel: lp0: using parport0 (interrupt-driven).
Sep 26 12:58:38 lfs kernel: Floppy drive(s): fd0 is 1.44M
Sep 26 12:58:38 lfs kernel: FDC 0 is a post-1991 82077
Sep 26 12:58:38 lfs kernel: loop: module loaded
Sep 26 12:58:38 lfs kernel: Uniform Multi-Platform E-IDE driver
Sep 26 12:58:38 lfs kernel: pdc202xx_new 0000:00:0c.0: IDE controller
(0x105a:0x4d68 rev 0x02)
Sep 26 12:58:38 lfs kernel: ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
Sep 26 12:58:38 lfs kernel: PCI: setting IRQ 11 as level-triggered
Sep 26 12:58:38 lfs kernel: Promise_IDE 0000:00:0c.0: PCI INT A ->
Link[LNKA] -> GSI 11 (level, low) -> IRQ 11
Sep 26 12:58:38 lfs kernel: pdc202xx_new 0000:00:0c.0: PLL input clock
is 16706 kHz
Sep 26 12:58:38 lfs kernel: pdc202xx_new 0000:00:0c.0: 100% native
mode on irq 11
Sep 26 12:58:38 lfs kernel:     ide2: BM-DMA at 0xa000-0xa007
Sep 26 12:58:38 lfs kernel:     ide3: BM-DMA at 0xa008-0xa00f
Sep 26 12:58:38 lfs kernel: Probing IDE interface ide2...
Sep 26 12:58:38 lfs kernel: Switched to high resolution mode on CPU 0
Sep 26 12:58:38 lfs kernel: Probing IDE interface ide3...
Sep 26 12:58:38 lfs kernel: ide2 at 0xb400-0xb407,0xb002 on irq 11
Sep 26 12:58:38 lfs kernel: ide3 at 0xa800-0xa807,0xa402 on irq 11
Sep 26 12:58:38 lfs kernel: via82cxxx 0000:00:04.1: VIA vt82c596b (rev
12) IDE UDMA66
Sep 26 12:58:38 lfs kernel: via82cxxx 0000:00:04.1: IDE controller
(0x1106:0x0571 rev 0x06)
Sep 26 12:58:38 lfs kernel: via82cxxx 0000:00:04.1: not 100% native
mode: will probe irqs later
Sep 26 12:58:38 lfs kernel: ide: skipping probe for hda
Sep 26 12:58:38 lfs kernel: ide: skipping probe for hdb
Sep 26 12:58:38 lfs kernel:     ide0: BM-DMA at 0xd800-0xd807
Sep 26 12:58:38 lfs kernel:     ide1: BM-DMA at 0xd808-0xd80f
Sep 26 12:58:38 lfs kernel: Probing IDE interface ide1...
Sep 26 12:58:38 lfs kernel: hdc: CREATIVE DVD-ROM DVD1243E, ATAPI
CD/DVD-ROM drive
Sep 26 12:58:38 lfs kernel: hdd: LITE-ON LTR-52246S, ATAPI CD/DVD-ROM drive
Sep 26 12:58:38 lfs kernel: hdc: host max PIO5 wanted
PIO255(auto-tune) selected PIO4
Sep 26 12:58:38 lfs kernel: hdc: UDMA/33 mode selected
Sep 26 12:58:38 lfs kernel: hdd: host max PIO5 wanted
PIO255(auto-tune) selected PIO4
Sep 26 12:58:38 lfs kernel: hdd: UDMA/33 mode selected
Sep 26 12:58:38 lfs kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Sep 26 12:58:38 lfs kernel: ide1 at 0x170-0x177,0x376 on irq 15
Sep 26 12:58:38 lfs kernel: ide-gd driver 1.18
Sep 26 12:58:38 lfs kernel: ide-cd driver 5.00
Sep 26 12:58:38 lfs kernel: ide-cd: hdc: ATAPI 40X DVD-ROM drive, 512kB Cache
Sep 26 12:58:38 lfs kernel: Uniform CD-ROM driver Revision: 3.20
Sep 26 12:58:38 lfs kernel: ide-cd: hdd: ATAPI 52X CD-ROM CD-R/RW
drive, 2048kB Cache
Sep 26 12:58:38 lfs kernel: sata_promise 0000:00:0e.0: version 2.12
Sep 26 12:58:38 lfs kernel: ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 5
Sep 26 12:58:38 lfs kernel: PCI: setting IRQ 5 as level-triggered
Sep 26 12:58:38 lfs kernel: sata_promise 0000:00:0e.0: PCI INT A ->
Link[LNKC] -> GSI 5 (level, low) -> IRQ 5
Sep 26 12:58:38 lfs kernel: scsi0 : sata_promise
Sep 26 12:58:38 lfs kernel: scsi1 : sata_promise
Sep 26 12:58:38 lfs kernel: scsi2 : sata_promise
Sep 26 12:58:38 lfs kernel: scsi3 : sata_promise
Sep 26 12:58:38 lfs kernel: ata1: SATA max UDMA/133 mmio
m4096@0xd3800000 ata 0xd3800380 irq 5
Sep 26 12:58:38 lfs kernel: ata2: SATA max UDMA/133 mmio
m4096@0xd3800000 ata 0xd3800280 irq 5
Sep 26 12:58:38 lfs kernel: ata3: SATA max UDMA/133 mmio
m4096@0xd3800000 ata 0xd3800200 irq 5
Sep 26 12:58:38 lfs kernel: ata4: SATA max UDMA/133 mmio
m4096@0xd3800000 ata 0xd3800300 irq 5
Sep 26 12:58:38 lfs kernel: e100: Intel(R) PRO/100 Network Driver,
3.5.24-k2-NAPI
Sep 26 12:58:38 lfs kernel: e100: Copyright(c) 1999-2006 Intel Corporation
Sep 26 12:58:38 lfs kernel: Linux Tulip driver version 1.1.15 (Feb 27, 2007)
Sep 26 12:58:38 lfs kernel: ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 9
Sep 26 12:58:38 lfs kernel: PCI: setting IRQ 9 as level-triggered
Sep 26 12:58:38 lfs kernel: tulip 0000:00:09.0: PCI INT A ->
Link[LNKD] -> GSI 9 (level, low) -> IRQ 9
Sep 26 12:58:38 lfs kernel: tulip0:  MII transceiver #1 config 3000
status 786d advertising 01e1.
Sep 26 12:58:38 lfs kernel: eth0: ADMtek Comet rev 17 at Port 0xd000,
00:03:6d:14:18:92, IRQ 9.
Sep 26 12:58:38 lfs kernel: ehci_hcd: USB 2.0 'Enhanced' Host
Controller (EHCI) Driver
Sep 26 12:58:38 lfs kernel: uhci_hcd: USB Universal Host Controller
Interface driver
Sep 26 12:58:38 lfs kernel: uhci_hcd 0000:00:04.2: PCI INT D ->
Link[LNKD] -> GSI 9 (level, low) -> IRQ 9
Sep 26 12:58:38 lfs kernel: uhci_hcd 0000:00:04.2: UHCI Host Controller
Sep 26 12:58:38 lfs kernel: uhci_hcd 0000:00:04.2: new USB bus
registered, assigned bus number 1
Sep 26 12:58:38 lfs kernel: uhci_hcd 0000:00:04.2: irq 9, io base 0x0000d400
Sep 26 12:58:38 lfs kernel: usb usb1: configuration #1 chosen from 1 choice
Sep 26 12:58:38 lfs kernel: hub 1-0:1.0: USB hub found
Sep 26 12:58:38 lfs kernel: hub 1-0:1.0: 2 ports detected
Sep 26 12:58:38 lfs kernel: Initializing USB Mass Storage driver...
Sep 26 12:58:38 lfs kernel: usbcore: registered new interface driver usb-storage
Sep 26 12:58:38 lfs kernel: USB Mass Storage support registered.
Sep 26 12:58:38 lfs kernel: PNP: PS/2 Controller
[PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
Sep 26 12:58:38 lfs kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
Sep 26 12:58:38 lfs kernel: serio: i8042 AUX port at 0x60,0x64 irq 12
Sep 26 12:58:38 lfs kernel: mice: PS/2 mouse device common for all mice
Sep 26 12:58:38 lfs kernel: input: PC Speaker as
/devices/platform/pcspkr/input/input0
Sep 26 12:58:38 lfs kernel: i2c /dev entries driver
Sep 26 12:58:38 lfs kernel: cpuidle: using governor ladder
Sep 26 12:58:38 lfs kernel: Advanced Linux Sound Architecture Driver
Version 1.0.20.
Sep 26 12:58:38 lfs kernel: ALSA device list:
Sep 26 12:58:38 lfs kernel:   No soundcards found.
Sep 26 12:58:38 lfs kernel: TCP cubic registered
Sep 26 12:58:38 lfs kernel: NET: Registered protocol family 17
Sep 26 12:58:38 lfs kernel: Using IPI Shortcut mode
Sep 26 12:58:38 lfs kernel: input: AT Translated Set 2 keyboard as
/devices/platform/i8042/serio0/input/input1
Sep 26 12:58:38 lfs kernel: usb 1-1: new full speed USB device using
uhci_hcd and address 2
Sep 26 12:58:38 lfs kernel: ata1: SATA link up 3.0 Gbps (SStatus 123
SControl 300)
Sep 26 12:58:38 lfs kernel: usb 1-1: configuration #1 chosen from 1 choice
Sep 26 12:58:38 lfs kernel: ata1.00: ATA-7: ST3500641AS, 3.AAE, max UDMA/133
Sep 26 12:58:38 lfs kernel: ata1.00: 976773168 sectors, multi 0: LBA48
NCQ (depth 0/32)
Sep 26 12:58:38 lfs kernel: ata1.00: configured for UDMA/133
Sep 26 12:58:38 lfs kernel: scsi 0:0:0:0: Direct-Access     ATA
ST3500641AS      3.AA PQ: 0 ANSI: 5
Sep 26 12:58:38 lfs kernel: sd 0:0:0:0: [sda] 976773168 512-byte
logical blocks: (500 GB/465 GiB)
Sep 26 12:58:38 lfs kernel: sd 0:0:0:0: [sda] Write Protect is off
Sep 26 12:58:38 lfs kernel: sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
Sep 26 12:58:38 lfs kernel: sd 0:0:0:0: [sda] Write cache: enabled,
read cache: enabled, doesn't support DPO or FUA
Sep 26 12:58:38 lfs kernel:  sda: sda1 sda2 < sda5 sda6 sda7 sda8 sda9 sda10
Sep 26 12:58:38 lfs kernel: input: ImPS/2 Generic Wheel Mouse as
/devices/platform/i8042/serio1/input/input2
Sep 26 12:58:38 lfs kernel:  sda11 sda12 sda13 sda14 sda15 > sda3
Sep 26 12:58:38 lfs kernel: sd 0:0:0:0: [sda] Attached SCSI disk
Sep 26 12:58:38 lfs kernel: ata2: SATA link up 3.0 Gbps (SStatus 123
SControl 300)
Sep 26 12:58:38 lfs kernel: ata2.00: ATA-6: WD      My Book ES, 012,
max UDMA/133
Sep 26 12:58:38 lfs kernel: ata2.00: 976773168 sectors, multi 0: LBA48
Sep 26 12:58:38 lfs kernel: ata2.00: configured for UDMA/133
Sep 26 12:58:38 lfs kernel: ata2: exception Emask 0x10 SAct 0x0 SErr
0x0 action 0x9 t4
Sep 26 12:58:38 lfs kernel: ata2: hotplug_status 0x22
Sep 26 12:58:38 lfs kernel: ata2.00: configured for UDMA/133
Sep 26 12:58:38 lfs kernel: ata2: EH complete
Sep 26 12:58:38 lfs kernel: scsi 1:0:0:0: Direct-Access     ATA
WD      My Book  012  PQ: 0 ANSI: 5
Sep 26 12:58:38 lfs kernel: sd 1:0:0:0: [sdb] 976773168 512-byte
logical blocks: (500 GB/465 GiB)
Sep 26 12:58:38 lfs kernel: sd 1:0:0:0: [sdb] Write Protect is off
Sep 26 12:58:38 lfs kernel: sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
Sep 26 12:58:38 lfs kernel: sd 1:0:0:0: [sdb] Write cache: enabled,
read cache: enabled, doesn't support DPO or FUA
Sep 26 12:58:38 lfs kernel:  sdb: sdb1 sdb2 < sdb5 sdb6 sdb7 sdb8 sdb9
sdb10 sdb11 > sdb3 sdb4
Sep 26 12:58:38 lfs kernel: sd 1:0:0:0: [sdb] Attached SCSI disk
Sep 26 12:58:38 lfs kernel: ata3: SATA link down (SStatus 0 SControl 300)
Sep 26 12:58:38 lfs kernel: ata4: SATA link down (SStatus 0 SControl 300)
Sep 26 12:58:38 lfs kernel: kjournald starting.  Commit interval 5 seconds
Sep 26 12:58:38 lfs kernel: EXT3-fs: mounted filesystem with writeback
data mode.
Sep 26 12:58:38 lfs kernel: VFS: Mounted root (ext3 filesystem)
readonly on device 8:11.
Sep 26 12:58:38 lfs kernel: Freeing unused kernel memory: 256k freed
Sep 26 12:58:38 lfs kernel: udev: starting version 130
Sep 26 12:58:38 lfs kernel: ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 10
Sep 26 12:58:38 lfs kernel: PCI: setting IRQ 10 as level-triggered
Sep 26 12:58:38 lfs kernel: ENS1371 0000:00:0b.0: PCI INT A ->
Link[LNKB] -> GSI 10 (level, low) -> IRQ 10
Sep 26 12:58:38 lfs kernel: usblp0: USB Bidirectional printer dev 2 if
0 alt 0 proto 2 vid 0x03F0 pid 0x7004
Sep 26 12:58:38 lfs kernel: usbcore: registered new interface driver usblp
Sep 26 12:58:38 lfs kernel: Adding 522072k swap on /dev/sda6.
Priority:1 extents:1 across:522072k
Sep 26 12:58:38 lfs kernel: EXT3 FS on sda11, internal journal
Sep 26 12:58:38 lfs dhcpcd[2069]: eth0: dhcpcd 4.0.7 starting
Sep 26 12:58:38 lfs dhcpcd[2069]: eth0: broadcasting for a lease
Sep 26 12:58:39 lfs dhcpcd[2069]: eth0: offered 192.168.1.97 from 192.168.1.254
Sep 26 12:58:39 lfs dhcpcd[2069]: eth0: checking 192.168.1.97 is
available on attached networks
Sep 26 12:58:41 lfs kernel: 0000:00:09.0: tulip_stop_rxtx() failed
(CSR5 0xfc664010 CSR6 0xff972117)
Sep 26 12:58:41 lfs kernel: eth0: Setting full-duplex based on MII#1
link partner capability of 41e1.
Sep 26 12:58:44 lfs dhcpcd[2069]: eth0: acknowledged 192.168.1.97 from
192.168.1.254
Sep 26 12:58:44 lfs dhcpcd[2069]: eth0: leased 192.168.1.97 for 86400 seconds
Sep 26 13:00:47 lfs kernel: kjournald starting.  Commit interval 5 seconds
Sep 26 13:00:47 lfs kernel: EXT3 FS on sdb4, internal journal
Sep 26 13:00:47 lfs kernel: EXT3-fs: mounted filesystem with writeback
data mode.
Sep 26 13:01:31 lfs kernel: ata2.00: exception Emask 0x0 SAct 0x0 SErr
0x0 action 0x6
Sep 26 13:01:31 lfs kernel: ata2.00: port_status 0x20200000
Sep 26 13:01:31 lfs kernel: ata2.00: cmd
35/00:f8:3f:4c:76/00:03:33:00:00/e0 tag 0 dma 520192 out
Sep 26 13:01:31 lfs kernel:          res
51/84:00:36:50:76/84:00:33:00:00/e0 Emask 0x10 (ATA bus error)
Sep 26 13:01:31 lfs kernel: ata2.00: status: { DRDY ERR }
Sep 26 13:01:31 lfs kernel: ata2.00: error: { ICRC ABRT }
Sep 26 13:01:31 lfs kernel: ata2: hard resetting link
Sep 26 13:01:31 lfs kernel: ata2: SATA link up 3.0 Gbps (SStatus 123
SControl 300)
Sep 26 13:01:31 lfs kernel: ata2.00: configured for UDMA/133
Sep 26 13:01:31 lfs kernel: ata2: EH complete
Sep 26 13:03:05 lfs kernel: ata2.00: exception Emask 0x0 SAct 0x0 SErr
0x0 action 0x6
Sep 26 13:03:05 lfs kernel: ata2.00: port_status 0x20200000
Sep 26 13:03:05 lfs kernel: ata2.00: cmd
35/00:40:07:b2:3c/00:00:38:00:00/e0 tag 0 dma 32768 out
Sep 26 13:03:05 lfs kernel:          res
51/84:00:46:b2:3c/84:00:38:00:00/e0 Emask 0x10 (ATA bus error)
Sep 26 13:03:05 lfs kernel: ata2.00: status: { DRDY ERR }
Sep 26 13:03:05 lfs kernel: ata2.00: error: { ICRC ABRT }
Sep 26 13:03:05 lfs kernel: ata2: hard resetting link
Sep 26 13:03:05 lfs kernel: ata2: SATA link up 3.0 Gbps (SStatus 123
SControl 300)
Sep 26 13:03:05 lfs kernel: ata2.00: configured for UDMA/133
Sep 26 13:03:05 lfs kernel: ata2: limiting SATA link speed to 1.5 Gbps
Sep 26 13:03:05 lfs kernel: ata2: exception Emask 0x10 SAct 0x0 SErr
0x0 action 0xf t4
Sep 26 13:03:05 lfs kernel: ata2: hotplug_status 0x22
Sep 26 13:03:05 lfs kernel: ata2: hard resetting link
Sep 26 13:03:06 lfs kernel: ata2: SATA link up 1.5 Gbps (SStatus 113
SControl 310)
Sep 26 13:03:06 lfs kernel: ata2.00: configured for UDMA/133
Sep 26 13:03:06 lfs kernel: ata2: EH complete
Sep 26 13:03:22 lfs kernel: ata2.00: exception Emask 0x0 SAct 0x0 SErr
0x0 action 0x6
Sep 26 13:03:22 lfs kernel: ata2.00: port_status 0x20200000
Sep 26 13:03:22 lfs kernel: ata2.00: cmd
35/00:60:07:7c:51/00:00:38:00:00/e0 tag 0 dma 49152 out
Sep 26 13:03:22 lfs kernel:          res
51/84:00:66:7c:51/84:00:38:00:00/e0 Emask 0x10 (ATA bus error)
Sep 26 13:03:22 lfs kernel: ata2.00: status: { DRDY ERR }
Sep 26 13:03:22 lfs kernel: ata2.00: error: { ICRC ABRT }
Sep 26 13:03:22 lfs kernel: ata2: hard resetting link
Sep 26 13:03:22 lfs kernel: ata2: SATA link up 1.5 Gbps (SStatus 113
SControl 310)
Sep 26 13:03:22 lfs kernel: ata2.00: configured for UDMA/133
Sep 26 13:03:22 lfs kernel: ata2: exception Emask 0x10 SAct 0x0 SErr
0x0 action 0x9 t4
Sep 26 13:03:22 lfs kernel: ata2: hotplug_status 0x22
Sep 26 13:03:22 lfs kernel: ata2.00: configured for UDMA/133
Sep 26 13:03:22 lfs kernel: ata2: EH complete
Sep 26 13:03:37 lfs kernel: ata2.00: exception Emask 0x0 SAct 0x0 SErr
0x0 action 0x6
Sep 26 13:03:37 lfs kernel: ata2.00: port_status 0x20200000
Sep 26 13:03:37 lfs kernel: ata2.00: cmd
35/00:30:17:db:49/00:00:38:00:00/e0 tag 0 dma 24576 out
Sep 26 13:03:37 lfs kernel:          res
51/84:00:46:db:49/84:00:38:00:00/e0 Emask 0x10 (ATA bus error)
Sep 26 13:03:37 lfs kernel: ata2.00: status: { DRDY ERR }
Sep 26 13:03:37 lfs kernel: ata2.00: error: { ICRC ABRT }
Sep 26 13:03:37 lfs kernel: ata2: hard resetting link
Sep 26 13:03:37 lfs kernel: ata2: SATA link up 1.5 Gbps (SStatus 113
SControl 310)
Sep 26 13:03:38 lfs kernel: ata2.00: configured for UDMA/133
Sep 26 13:03:38 lfs kernel: ata2.00: limiting speed to UDMA/100:PIO4
Sep 26 13:03:38 lfs kernel: ata2: exception Emask 0x10 SAct 0x0 SErr
0x0 action 0xf t4
Sep 26 13:03:38 lfs kernel: ata2: hotplug_status 0x22
Sep 26 13:03:38 lfs kernel: ata2: hard resetting link
Sep 26 13:03:43 lfs kernel: ata2: link is slow to respond, please be
patient (ready=-19)
Sep 26 13:03:48 lfs kernel: ata2: SRST failed (errno=-16)
Sep 26 13:03:48 lfs kernel: ata2: hard resetting link
Sep 26 13:03:48 lfs kernel: ata2: SATA link up 1.5 Gbps (SStatus 113
SControl 310)
Sep 26 13:03:49 lfs kernel: ata2.00: configured for UDMA/100
Sep 26 13:03:49 lfs kernel: ata2: exception Emask 0x10 SAct 0x0 SErr
0x0 action 0x9 t3
Sep 26 13:03:49 lfs kernel: ata2: hotplug_status 0x2
Sep 26 13:03:49 lfs kernel: ata2.00: configured for UDMA/100
Sep 26 13:03:49 lfs kernel: ata2: EH complete
Sep 26 13:04:22 lfs kernel: ata2.00: exception Emask 0x0 SAct 0x0 SErr
0x0 action 0x6
Sep 26 13:04:22 lfs kernel: ata2.00: port_status 0x20200000
Sep 26 13:04:22 lfs kernel: ata2.00: cmd
35/00:08:57:38:24/00:00:37:00:00/e0 tag 0 dma 4096 out
Sep 26 13:04:22 lfs kernel:          res
51/84:00:5e:38:24/84:00:37:00:00/e0 Emask 0x10 (ATA bus error)
Sep 26 13:04:22 lfs kernel: ata2.00: status: { DRDY ERR }
Sep 26 13:04:22 lfs kernel: ata2.00: error: { ICRC ABRT }
Sep 26 13:04:22 lfs kernel: ata2: hard resetting link
Sep 26 13:04:22 lfs kernel: ata2: SATA link up 1.5 Gbps (SStatus 113
SControl 310)
Sep 26 13:04:22 lfs kernel: ata2.00: configured for UDMA/100
Sep 26 13:04:22 lfs kernel: ata2: EH complete
Sep 26 13:05:59 lfs kernel: ata2.00: exception Emask 0x0 SAct 0x0 SErr
0x0 action 0x6
Sep 26 13:05:59 lfs kernel: ata2.00: port_status 0x20200000
Sep 26 13:05:59 lfs kernel: ata2.00: cmd
35/00:50:1f:47:db/00:01:34:00:00/e0 tag 0 dma 172032 out
Sep 26 13:05:59 lfs kernel:          res
51/84:00:6e:48:db/84:00:34:00:00/e0 Emask 0x10 (ATA bus error)
Sep 26 13:05:59 lfs kernel: ata2.00: status: { DRDY ERR }
Sep 26 13:05:59 lfs kernel: ata2.00: error: { ICRC ABRT }
Sep 26 13:05:59 lfs kernel: ata2: hard resetting link
Sep 26 13:05:59 lfs kernel: ata2: SATA link up 1.5 Gbps (SStatus 113
SControl 310)
Sep 26 13:06:00 lfs kernel: ata2.00: configured for UDMA/100
Sep 26 13:06:00 lfs kernel: ata2.00: limiting speed to UDMA/33:PIO4
Sep 26 13:06:00 lfs kernel: ata2: exception Emask 0x10 SAct 0x0 SErr
0x0 action 0xf t4
Sep 26 13:06:00 lfs kernel: ata2: hotplug_status 0x22
Sep 26 13:06:00 lfs kernel: ata2: hard resetting link
Sep 26 13:06:00 lfs kernel: ata2: SATA link up 1.5 Gbps (SStatus 113
SControl 310)
Sep 26 13:06:01 lfs kernel: ata2.00: configured for UDMA/33
Sep 26 13:06:01 lfs kernel: ata2: exception Emask 0x10 SAct 0x0 SErr
0x0 action 0x9 t3
Sep 26 13:06:01 lfs kernel: ata2: hotplug_status 0x20
Sep 26 13:06:01 lfs kernel: ata2.00: configured for UDMA/33
Sep 26 13:06:01 lfs kernel: ata2: EH complete
Sep 26 13:07:50 lfs kernel: ata2.00: exception Emask 0x0 SAct 0x0 SErr
0x0 action 0x6
Sep 26 13:07:50 lfs kernel: ata2.00: port_status 0x20200000
Sep 26 13:07:50 lfs kernel: ata2.00: cmd
35/00:f8:9f:18:6e/00:00:35:00:00/e0 tag 0 dma 126976 out
Sep 26 13:07:50 lfs kernel:          res
51/84:00:96:19:6e/84:00:35:00:00/e0 Emask 0x10 (ATA bus error)
Sep 26 13:07:50 lfs kernel: ata2.00: status: { DRDY ERR }
Sep 26 13:07:50 lfs kernel: ata2.00: error: { ICRC ABRT }
Sep 26 13:07:50 lfs kernel: ata2: hard resetting link
Sep 26 13:07:51 lfs kernel: ata2: SATA link up 1.5 Gbps (SStatus 113
SControl 310)
Sep 26 13:07:51 lfs kernel: ata2.00: configured for UDMA/33
Sep 26 13:07:51 lfs kernel: ata2: exception Emask 0x10 SAct 0x0 SErr
0x0 action 0x9 t4
Sep 26 13:07:51 lfs kernel: ata2: hotplug_status 0x22
Sep 26 13:07:51 lfs kernel: ata2.00: configured for UDMA/33
Sep 26 13:07:51 lfs kernel: ata2: EH complete
Sep 26 13:08:42 lfs kernel: ata2.00: exception Emask 0x0 SAct 0x0 SErr
0x0 action 0x6
Sep 26 13:08:42 lfs kernel: ata2.00: port_status 0x20200000
Sep 26 13:08:42 lfs kernel: ata2.00: cmd
35/00:08:d7:18:69/00:00:35:00:00/e0 tag 0 dma 4096 out
Sep 26 13:08:42 lfs kernel:          res
51/84:00:de:18:69/84:00:35:00:00/e0 Emask 0x10 (ATA bus error)
Sep 26 13:08:42 lfs kernel: ata2.00: status: { DRDY ERR }
Sep 26 13:08:42 lfs kernel: ata2.00: error: { ICRC ABRT }
Sep 26 13:08:42 lfs kernel: ata2: hard resetting link
Sep 26 13:08:42 lfs kernel: ata2: SATA link up 1.5 Gbps (SStatus 113
SControl 310)
Sep 26 13:08:42 lfs kernel: ata2.00: configured for UDMA/33
Sep 26 13:08:42 lfs kernel: ata2: exception Emask 0x10 SAct 0x0 SErr
0x0 action 0x9 t4
Sep 26 13:08:42 lfs kernel: ata2: hotplug_status 0x22
Sep 26 13:08:42 lfs kernel: ata2.00: configured for UDMA/33
Sep 26 13:08:42 lfs kernel: ata2: EH complete
Sep 26 13:08:58 lfs kernel: ata2.00: exception Emask 0x0 SAct 0x0 SErr
0x0 action 0x6
Sep 26 13:08:58 lfs kernel: ata2.00: port_status 0x20200000
Sep 26 13:08:58 lfs kernel: ata2.00: cmd
35/00:08:9f:0a:70/00:00:35:00:00/e0 tag 0 dma 4096 out
Sep 26 13:08:58 lfs kernel:          res
51/84:00:a6:0a:70/84:00:35:00:00/e0 Emask 0x10 (ATA bus error)
Sep 26 13:08:58 lfs kernel: ata2.00: status: { DRDY ERR }
Sep 26 13:08:58 lfs kernel: ata2.00: error: { ICRC ABRT }
Sep 26 13:08:58 lfs kernel: ata2: hard resetting link
Sep 26 13:08:58 lfs kernel: ata2: SATA link up 1.5 Gbps (SStatus 113
SControl 310)
Sep 26 13:08:59 lfs kernel: ata2.00: configured for UDMA/33
Sep 26 13:08:59 lfs kernel: ata2: exception Emask 0x10 SAct 0x0 SErr
0x0 action 0x9 t4
Sep 26 13:08:59 lfs kernel: ata2: hotplug_status 0x22
Sep 26 13:08:59 lfs kernel: ata2.00: configured for UDMA/33
Sep 26 13:08:59 lfs kernel: ata2: EH complete
Sep 26 13:09:03 lfs kernel: ata2.00: exception Emask 0x0 SAct 0x0 SErr
0x0 action 0x6
Sep 26 13:09:03 lfs kernel: ata2.00: port_status 0x20200000
Sep 26 13:09:03 lfs kernel: ata2.00: cmd
35/00:f8:ff:67:8c/00:03:35:00:00/e0 tag 0 dma 520192 out
Sep 26 13:09:03 lfs kernel:          res
51/84:00:f6:6b:8c/84:00:35:00:00/e0 Emask 0x10 (ATA bus error)
Sep 26 13:09:03 lfs kernel: ata2.00: status: { DRDY ERR }
Sep 26 13:09:03 lfs kernel: ata2.00: error: { ICRC ABRT }
Sep 26 13:09:03 lfs kernel: ata2: hard resetting link
Sep 26 13:09:04 lfs kernel: ata2: SATA link up 1.5 Gbps (SStatus 113
SControl 310)
Sep 26 13:09:04 lfs kernel: ata2.00: configured for UDMA/33
Sep 26 13:09:04 lfs kernel: ata2: exception Emask 0x10 SAct 0x0 SErr
0x0 action 0x9 t4
Sep 26 13:09:04 lfs kernel: ata2: hotplug_status 0x22
Sep 26 13:09:04 lfs kernel: ata2.00: configured for UDMA/33
Sep 26 13:09:04 lfs kernel: ata2: EH complete
Sep 26 13:09:12 lfs kernel: ata2.00: exception Emask 0x0 SAct 0x0 SErr
0x0 action 0x6
Sep 26 13:09:12 lfs kernel: ata2.00: port_status 0x20200000
Sep 26 13:09:12 lfs kernel: ata2.00: cmd
35/00:f8:47:c2:8f/00:03:35:00:00/e0 tag 0 dma 520192 out
Sep 26 13:09:12 lfs kernel:          res
51/84:00:3e:c6:8f/84:00:35:00:00/e0 Emask 0x10 (ATA bus error)
Sep 26 13:09:12 lfs kernel: ata2.00: status: { DRDY ERR }
Sep 26 13:09:12 lfs kernel: ata2.00: error: { ICRC ABRT }
Sep 26 13:09:12 lfs kernel: ata2: hard resetting link
Sep 26 13:09:13 lfs kernel: ata2: SATA link up 1.5 Gbps (SStatus 113
SControl 310)
Sep 26 13:09:13 lfs kernel: ata2.00: configured for UDMA/33
Sep 26 13:09:13 lfs kernel: ata2: exception Emask 0x10 SAct 0x0 SErr
0x0 action 0x9 t4
Sep 26 13:09:13 lfs kernel: ata2: hotplug_status 0x20
Sep 26 13:09:13 lfs kernel: ata2.00: configured for UDMA/33
Sep 26 13:09:13 lfs kernel: ata2: EH complete
Sep 26 13:09:23 lfs kernel: ata2.00: exception Emask 0x0 SAct 0x0 SErr
0x0 action 0x6
Sep 26 13:09:23 lfs kernel: ata2.00: port_status 0x20200000
Sep 26 13:09:23 lfs kernel: ata2.00: cmd
35/00:60:67:c6:93/00:00:35:00:00/e0 tag 0 dma 49152 out
Sep 26 13:09:23 lfs kernel:          res
51/84:00:c6:c6:93/84:00:35:00:00/e0 Emask 0x10 (ATA bus error)
Sep 26 13:09:23 lfs kernel: ata2.00: status: { DRDY ERR }
Sep 26 13:09:23 lfs kernel: ata2.00: error: { ICRC ABRT }
Sep 26 13:09:23 lfs kernel: ata2: hard resetting link
Sep 26 13:09:23 lfs kernel: ata2: SATA link up 1.5 Gbps (SStatus 113
SControl 310)
Sep 26 13:09:23 lfs kernel: ata2.00: configured for UDMA/33
Sep 26 13:09:23 lfs kernel: ata2: exception Emask 0x10 SAct 0x0 SErr
0x0 action 0x9 t4
Sep 26 13:09:23 lfs kernel: ata2: hotplug_status 0x22
Sep 26 13:09:23 lfs kernel: ata2.00: configured for UDMA/33
Sep 26 13:09:23 lfs kernel: ata2: EH complete
Sep 26 13:09:28 lfs kernel: ata2.00: exception Emask 0x0 SAct 0x0 SErr
0x0 action 0x6
Sep 26 13:09:28 lfs kernel: ata2.00: port_status 0x20200000
Sep 26 13:09:28 lfs kernel: ata2.00: cmd
35/00:08:97:70:96/00:00:35:00:00/e0 tag 0 dma 4096 out
Sep 26 13:09:28 lfs kernel:          res
51/84:00:9e:70:96/84:00:35:00:00/e0 Emask 0x10 (ATA bus error)
Sep 26 13:09:28 lfs kernel: ata2.00: status: { DRDY ERR }
Sep 26 13:09:28 lfs kernel: ata2.00: error: { ICRC ABRT }
Sep 26 13:09:28 lfs kernel: ata2: hard resetting link
Sep 26 13:09:29 lfs kernel: ata2: SATA link up 1.5 Gbps (SStatus 113
SControl 310)
Sep 26 13:09:29 lfs kernel: ata2.00: configured for UDMA/33
Sep 26 13:09:29 lfs kernel: ata2: exception Emask 0x10 SAct 0x0 SErr
0x0 action 0x9 t4
Sep 26 13:09:29 lfs kernel: ata2: hotplug_status 0x22
Sep 26 13:09:29 lfs kernel: ata2.00: configured for UDMA/33
Sep 26 13:09:29 lfs kernel: ata2: EH complete
Sep 26 13:09:46 lfs kernel: ata2.00: exception Emask 0x0 SAct 0x0 SErr
0x0 action 0x6
Sep 26 13:09:46 lfs kernel: ata2.00: port_status 0x20200000
Sep 26 13:09:46 lfs kernel: ata2.00: cmd
35/00:f8:07:7c:9d/00:03:35:00:00/e0 tag 0 dma 520192 out
Sep 26 13:09:46 lfs kernel:          res
51/84:00:fe:7f:9d/84:00:35:00:00/e0 Emask 0x10 (ATA bus error)
Sep 26 13:09:46 lfs kernel: ata2.00: status: { DRDY ERR }
Sep 26 13:09:46 lfs kernel: ata2.00: error: { ICRC ABRT }
Sep 26 13:09:46 lfs kernel: ata2: hard resetting link
Sep 26 13:09:46 lfs kernel: ata2: SATA link up 1.5 Gbps (SStatus 113
SControl 310)
Sep 26 13:09:46 lfs kernel: ata2.00: configured for UDMA/33
Sep 26 13:09:46 lfs kernel: ata2: exception Emask 0x10 SAct 0x0 SErr
0x0 action 0x9 t4
Sep 26 13:09:46 lfs kernel: ata2: hotplug_status 0x22
Sep 26 13:09:46 lfs kernel: ata2.00: configured for UDMA/33
Sep 26 13:09:46 lfs kernel: ata2: EH complete
Sep 26 13:10:12 lfs kernel: ata2.00: exception Emask 0x0 SAct 0x0 SErr
0x0 action 0x6
Sep 26 13:10:12 lfs kernel: ata2.00: port_status 0x20200000
Sep 26 13:10:12 lfs kernel: ata2.00: cmd
35/00:f8:07:19:a8/00:03:35:00:00/e0 tag 0 dma 520192 out
Sep 26 13:10:12 lfs kernel:          res
51/84:00:fe:1c:a8/84:00:35:00:00/e0 Emask 0x10 (ATA bus error)
Sep 26 13:10:12 lfs kernel: ata2.00: status: { DRDY ERR }
Sep 26 13:10:12 lfs kernel: ata2.00: error: { ICRC ABRT }
Sep 26 13:10:12 lfs kernel: ata2: hard resetting link
Sep 26 13:10:12 lfs kernel: ata2: SATA link up 1.5 Gbps (SStatus 113
SControl 310)
Sep 26 13:10:12 lfs kernel: ata2.00: configured for UDMA/33
Sep 26 13:10:12 lfs kernel: ata2: exception Emask 0x10 SAct 0x0 SErr
0x0 action 0x9 t4
Sep 26 13:10:12 lfs kernel: ata2: hotplug_status 0x22
Sep 26 13:10:12 lfs kernel: ata2.00: configured for UDMA/33
Sep 26 13:10:12 lfs kernel: ata2: EH complete
Sep 26 13:10:50 lfs kernel: ata2.00: exception Emask 0x0 SAct 0x0 SErr
0x0 action 0x6
Sep 26 13:10:50 lfs kernel: ata2.00: port_status 0x20200000
Sep 26 13:10:50 lfs kernel: ata2.00: cmd
35/00:20:67:eb:b0/00:00:35:00:00/e0 tag 0 dma 16384 out
Sep 26 13:10:50 lfs kernel:          res
51/84:00:86:eb:b0/84:00:35:00:00/e0 Emask 0x10 (ATA bus error)
Sep 26 13:10:50 lfs kernel: ata2.00: status: { DRDY ERR }
Sep 26 13:10:50 lfs kernel: ata2.00: error: { ICRC ABRT }
Sep 26 13:10:50 lfs kernel: ata2: hard resetting link
Sep 26 13:10:50 lfs kernel: ata2: SATA link up 1.5 Gbps (SStatus 113
SControl 310)
Sep 26 13:10:50 lfs kernel: ata2.00: configured for UDMA/33
Sep 26 13:10:50 lfs kernel: ata2: exception Emask 0x10 SAct 0x0 SErr
0x0 action 0x9 t4
Sep 26 13:10:50 lfs kernel: ata2: hotplug_status 0x22
Sep 26 13:10:50 lfs kernel: ata2.00: configured for UDMA/33
Sep 26 13:10:50 lfs kernel: ata2: EH complete
Sep 26 13:10:50 lfs kernel: ata2.00: exception Emask 0x0 SAct 0x0 SErr
0x0 action 0x6
Sep 26 13:10:50 lfs kernel: ata2.00: port_status 0x20200000
Sep 26 13:10:50 lfs kernel: ata2.00: cmd
35/00:18:df:70:b1/00:00:35:00:00/e0 tag 0 dma 12288 out
Sep 26 13:10:50 lfs kernel:          res
51/84:00:f6:70:b1/84:00:35:00:00/e0 Emask 0x10 (ATA bus error)
Sep 26 13:10:50 lfs kernel: ata2.00: status: { DRDY ERR }
Sep 26 13:10:50 lfs kernel: ata2.00: error: { ICRC ABRT }
Sep 26 13:10:50 lfs kernel: ata2: hard resetting link
Sep 26 13:10:51 lfs kernel: ata2: SATA link up 1.5 Gbps (SStatus 113
SControl 310)
Sep 26 13:10:51 lfs kernel: ata2.00: configured for UDMA/33
Sep 26 13:10:51 lfs kernel: ata2: exception Emask 0x10 SAct 0x0 SErr
0x0 action 0x9 t4
Sep 26 13:10:51 lfs kernel: ata2: hotplug_status 0x22
Sep 26 13:10:51 lfs kernel: ata2.00: configured for UDMA/33
Sep 26 13:10:51 lfs kernel: ata2: EH complete
Sep 26 13:10:51 lfs kernel: ata2.00: exception Emask 0x0 SAct 0x0 SErr
0x0 action 0x6
Sep 26 13:10:51 lfs kernel: ata2.00: port_status 0x20200000
Sep 26 13:10:51 lfs kernel: ata2.00: cmd
35/00:f8:bf:c6:b1/00:00:35:00:00/e0 tag 0 dma 126976 out
Sep 26 13:10:51 lfs kernel:          res
51/84:00:b6:c7:b1/84:00:35:00:00/e0 Emask 0x10 (ATA bus error)
Sep 26 13:10:51 lfs kernel: ata2.00: status: { DRDY ERR }
Sep 26 13:10:51 lfs kernel: ata2.00: error: { ICRC ABRT }
Sep 26 13:10:51 lfs kernel: ata2: hard resetting link
Sep 26 13:10:52 lfs kernel: ata2: SATA link up 1.5 Gbps (SStatus 113
SControl 310)
Sep 26 13:10:52 lfs kernel: ata2.00: configured for UDMA/33
Sep 26 13:10:52 lfs kernel: ata2: exception Emask 0x10 SAct 0x0 SErr
0x0 action 0x9 t4
Sep 26 13:10:52 lfs kernel: ata2: hotplug_status 0x22
Sep 26 13:10:52 lfs kernel: ata2.00: configured for UDMA/33
Sep 26 13:10:52 lfs kernel: ata2: EH complete
Sep 26 13:11:19 lfs kernel: ata2.00: exception Emask 0x0 SAct 0x0 SErr
0x0 action 0x6
Sep 26 13:11:19 lfs kernel: ata2.00: port_status 0x20200000
Sep 26 13:11:19 lfs kernel: ata2.00: cmd
35/00:08:67:73:bd/00:00:35:00:00/e0 tag 0 dma 4096 out
Sep 26 13:11:19 lfs kernel:          res
51/84:00:6e:73:bd/84:00:35:00:00/e0 Emask 0x10 (ATA bus error)
Sep 26 13:11:19 lfs kernel: ata2.00: status: { DRDY ERR }
Sep 26 13:11:19 lfs kernel: ata2.00: error: { ICRC ABRT }
Sep 26 13:11:19 lfs kernel: ata2: hard resetting link
Sep 26 13:11:19 lfs kernel: ata2: SATA link up 1.5 Gbps (SStatus 113
SControl 310)
Sep 26 13:11:19 lfs kernel: ata2.00: configured for UDMA/33
Sep 26 13:11:19 lfs kernel: ata2: exception Emask 0x10 SAct 0x0 SErr
0x0 action 0x9 t4
Sep 26 13:11:19 lfs kernel: ata2: hotplug_status 0x22
Sep 26 13:11:19 lfs kernel: ata2.00: configured for UDMA/33
Sep 26 13:11:19 lfs kernel: ata2: EH complete
Sep 26 13:11:19 lfs kernel: ata2.00: exception Emask 0x0 SAct 0x0 SErr
0x0 action 0x6
Sep 26 13:11:19 lfs kernel: ata2.00: port_status 0x20200000
Sep 26 13:11:19 lfs kernel: ata2.00: cmd
35/00:f8:67:77:bd/00:03:35:00:00/e0 tag 0 dma 520192 out
Sep 26 13:11:19 lfs kernel:          res
51/84:00:5e:7b:bd/84:00:35:00:00/e0 Emask 0x10 (ATA bus error)
Sep 26 13:11:19 lfs kernel: ata2.00: status: { DRDY ERR }
Sep 26 13:11:19 lfs kernel: ata2.00: error: { ICRC ABRT }
Sep 26 13:11:19 lfs kernel: ata2: hard resetting link
Sep 26 13:11:20 lfs kernel: ata2: SATA link up 1.5 Gbps (SStatus 113
SControl 310)
Sep 26 13:11:20 lfs kernel: ata2.00: configured for UDMA/33
Sep 26 13:11:20 lfs kernel: ata2: exception Emask 0x10 SAct 0x0 SErr
0x0 action 0x9 t4
Sep 26 13:11:20 lfs kernel: ata2: hotplug_status 0x22
Sep 26 13:11:20 lfs kernel: ata2.00: configured for UDMA/33
Sep 26 13:11:20 lfs kernel: ata2: EH complete
Sep 26 13:11:26 lfs kernel: ata2.00: exception Emask 0x0 SAct 0x0 SErr
0x0 action 0x6
Sep 26 13:11:26 lfs kernel: ata2.00: port_status 0x20200000
Sep 26 13:11:26 lfs kernel: ata2.00: cmd
35/00:30:1f:6a:50/00:00:35:00:00/e0 tag 0 dma 24576 out
Sep 26 13:11:26 lfs kernel:          res
51/84:00:4e:6a:50/84:00:35:00:00/e0 Emask 0x10 (ATA bus error)
Sep 26 13:11:26 lfs kernel: ata2.00: status: { DRDY ERR }
Sep 26 13:11:26 lfs kernel: ata2.00: error: { ICRC ABRT }
Sep 26 13:11:26 lfs kernel: ata2: hard resetting link
Sep 26 13:11:26 lfs kernel: ata2: SATA link up 1.5 Gbps (SStatus 113
SControl 310)
Sep 26 13:11:27 lfs kernel: ata2.00: configured for UDMA/33
Sep 26 13:11:27 lfs kernel: ata2: exception Emask 0x10 SAct 0x0 SErr
0x0 action 0x9 t4
Sep 26 13:11:27 lfs kernel: ata2: hotplug_status 0x22
Sep 26 13:11:27 lfs kernel: ata2.00: configured for UDMA/33
Sep 26 13:11:27 lfs kernel: ata2: EH complete
Sep 26 13:11:37 lfs kernel: ata2.00: exception Emask 0x0 SAct 0x0 SErr
0x0 action 0x6
Sep 26 13:11:37 lfs kernel: ata2.00: port_status 0x20200000
Sep 26 13:11:37 lfs kernel: ata2.00: cmd
35/00:f8:0f:0d:76/00:03:33:00:00/e0 tag 0 dma 520192 out
Sep 26 13:11:37 lfs kernel:          res
51/84:00:06:11:76/84:00:33:00:00/e0 Emask 0x10 (ATA bus error)
Sep 26 13:11:37 lfs kernel: ata2.00: status: { DRDY ERR }
Sep 26 13:11:37 lfs kernel: ata2.00: error: { ICRC ABRT }
Sep 26 13:11:37 lfs kernel: ata2: hard resetting link
Sep 26 13:11:37 lfs kernel: ata2: SATA link up 1.5 Gbps (SStatus 113
SControl 310)
Sep 26 13:11:37 lfs kernel: ata2.00: configured for UDMA/33
Sep 26 13:11:37 lfs kernel: ata2: EH complete
Sep 26 13:12:02 lfs kernel: ata2.00: exception Emask 0x0 SAct 0x0 SErr
0x0 action 0x6
Sep 26 13:12:02 lfs kernel: ata2.00: port_status 0x20200000
Sep 26 13:12:02 lfs kernel: ata2.00: cmd
35/00:08:9f:22:70/00:00:35:00:00/e0 tag 0 dma 4096 out
Sep 26 13:12:02 lfs kernel:          res
51/84:00:a6:22:70/84:00:35:00:00/e0 Emask 0x10 (ATA bus error)
Sep 26 13:12:02 lfs kernel: ata2.00: status: { DRDY ERR }
Sep 26 13:12:02 lfs kernel: ata2.00: error: { ICRC ABRT }
Sep 26 13:12:02 lfs kernel: ata2: hard resetting link
Sep 26 13:12:02 lfs kernel: ata2: SATA link up 1.5 Gbps (SStatus 113
SControl 310)
Sep 26 13:12:02 lfs kernel: ata2.00: configured for UDMA/33
Sep 26 13:12:02 lfs kernel: ata2: exception Emask 0x10 SAct 0x0 SErr
0x0 action 0x9 t4
Sep 26 13:12:02 lfs kernel: ata2: hotplug_status 0x20
Sep 26 13:12:02 lfs kernel: ata2.00: configured for UDMA/33
Sep 26 13:12:02 lfs kernel: ata2: EH complete
Sep 26 13:12:23 lfs kernel: ata2.00: exception Emask 0x0 SAct 0x0 SErr
0x0 action 0x6
Sep 26 13:12:23 lfs kernel: ata2.00: port_status 0x20200000
Sep 26 13:12:23 lfs kernel: ata2.00: cmd
35/00:08:97:e6:d9/00:00:35:00:00/e0 tag 0 dma 4096 out
Sep 26 13:12:23 lfs kernel:          res
51/84:00:9e:e6:d9/84:00:35:00:00/e0 Emask 0x10 (ATA bus error)
Sep 26 13:12:23 lfs kernel: ata2.00: status: { DRDY ERR }
Sep 26 13:12:23 lfs kernel: ata2.00: error: { ICRC ABRT }
Sep 26 13:12:23 lfs kernel: ata2: hard resetting link
Sep 26 13:12:24 lfs kernel: ata2: SATA link up 1.5 Gbps (SStatus 113
SControl 310)
Sep 26 13:12:24 lfs kernel: ata2.00: configured for UDMA/33
Sep 26 13:12:24 lfs kernel: ata2: exception Emask 0x10 SAct 0x0 SErr
0x0 action 0x9 t4
Sep 26 13:12:24 lfs kernel: ata2: hotplug_status 0x22
Sep 26 13:12:24 lfs kernel: ata2.00: configured for UDMA/33
Sep 26 13:12:24 lfs kernel: ata2: EH complete
Sep 26 13:12:25 lfs kernel: ata2.00: exception Emask 0x0 SAct 0x0 SErr
0x0 action 0x6
Sep 26 13:12:25 lfs kernel: ata2.00: port_status 0x20200000
Sep 26 13:12:25 lfs kernel: ata2.00: cmd
35/00:d0:e7:83:de/00:01:35:00:00/e0 tag 0 dma 237568 out
Sep 26 13:12:25 lfs kernel:          res
51/84:00:b6:85:de/84:00:35:00:00/e0 Emask 0x10 (ATA bus error)
Sep 26 13:12:25 lfs kernel: ata2.00: status: { DRDY ERR }
Sep 26 13:12:25 lfs kernel: ata2.00: error: { ICRC ABRT }
Sep 26 13:12:25 lfs kernel: ata2: hard resetting link
Sep 26 13:12:25 lfs kernel: ata2: SATA link up 1.5 Gbps (SStatus 113
SControl 310)
Sep 26 13:12:25 lfs kernel: ata2.00: configured for UDMA/33
Sep 26 13:12:25 lfs kernel: ata2: exception Emask 0x10 SAct 0x0 SErr
0x0 action 0x9 t4
Sep 26 13:12:25 lfs kernel: ata2: hotplug_status 0x22
Sep 26 13:12:25 lfs kernel: ata2.00: configured for UDMA/33
Sep 26 13:12:25 lfs kernel: ata2: EH complete
Sep 26 13:12:26 lfs kernel: ata2.00: exception Emask 0x0 SAct 0x0 SErr
0x0 action 0x6
Sep 26 13:12:26 lfs kernel: ata2.00: port_status 0x20200000
Sep 26 13:12:26 lfs kernel: ata2.00: cmd
35/00:a8:c7:06:df/00:01:35:00:00/e0 tag 0 dma 217088 out
Sep 26 13:12:26 lfs kernel:          res
51/84:00:6e:08:df/84:00:35:00:00/e0 Emask 0x10 (ATA bus error)
Sep 26 13:12:26 lfs kernel: ata2.00: status: { DRDY ERR }
Sep 26 13:12:26 lfs kernel: ata2.00: error: { ICRC ABRT }
Sep 26 13:12:26 lfs kernel: ata2: hard resetting link
Sep 26 13:12:26 lfs kernel: ata2: SATA link up 1.5 Gbps (SStatus 113
SControl 310)
Sep 26 13:12:26 lfs kernel: ata2.00: configured for UDMA/33
Sep 26 13:12:26 lfs kernel: ata2: exception Emask 0x10 SAct 0x0 SErr
0x0 action 0x9 t4
Sep 26 13:12:26 lfs kernel: ata2: hotplug_status 0x22
Sep 26 13:12:26 lfs kernel: ata2.00: configured for UDMA/33
Sep 26 13:12:26 lfs kernel: ata2: EH complete
Sep 26 13:13:04 lfs kernel: ata2.00: exception Emask 0x0 SAct 0x0 SErr
0x0 action 0x6
Sep 26 13:13:04 lfs kernel: ata2.00: port_status 0x20200000
Sep 26 13:13:04 lfs kernel: ata2.00: cmd
35/00:40:37:6f:e9/00:01:35:00:00/e0 tag 0 dma 163840 out
Sep 26 13:13:04 lfs kernel:          res
51/84:00:76:70:e9/84:00:35:00:00/e0 Emask 0x10 (ATA bus error)
Sep 26 13:13:04 lfs kernel: ata2.00: status: { DRDY ERR }
Sep 26 13:13:04 lfs kernel: ata2.00: error: { ICRC ABRT }
Sep 26 13:13:04 lfs kernel: ata2: hard resetting link
Sep 26 13:13:04 lfs kernel: ata2: SATA link up 1.5 Gbps (SStatus 113
SControl 310)
Sep 26 13:13:04 lfs kernel: ata2.00: configured for UDMA/33
Sep 26 13:13:04 lfs kernel: ata2: exception Emask 0x10 SAct 0x0 SErr
0x0 action 0x9 t4
Sep 26 13:13:04 lfs kernel: ata2: hotplug_status 0x22
Sep 26 13:13:04 lfs kernel: ata2.00: configured for UDMA/33
Sep 26 13:13:04 lfs kernel: ata2: EH complete
Sep 26 13:13:05 lfs kernel: ata2.00: exception Emask 0x0 SAct 0x0 SErr
0x0 action 0x6
Sep 26 13:13:05 lfs kernel: ata2.00: port_status 0x20200000
Sep 26 13:13:05 lfs kernel: ata2.00: cmd
35/00:50:07:62:ea/00:01:35:00:00/e0 tag 0 dma 172032 out
Sep 26 13:13:05 lfs kernel:          res
51/84:00:56:63:ea/84:00:35:00:00/e0 Emask 0x10 (ATA bus error)
Sep 26 13:13:05 lfs kernel: ata2.00: status: { DRDY ERR }
Sep 26 13:13:05 lfs kernel: ata2.00: error: { ICRC ABRT }
Sep 26 13:13:05 lfs kernel: ata2: hard resetting link
Sep 26 13:13:05 lfs kernel: ata2: SATA link up 1.5 Gbps (SStatus 113
SControl 310)
Sep 26 13:13:05 lfs kernel: ata2.00: configured for UDMA/33
Sep 26 13:13:05 lfs kernel: ata2: exception Emask 0x10 SAct 0x0 SErr
0x0 action 0x9 t4
Sep 26 13:13:05 lfs kernel: ata2: hotplug_status 0x22
Sep 26 13:13:06 lfs kernel: ata2.00: configured for UDMA/33
Sep 26 13:13:06 lfs kernel: ata2: EH complete
Sep 26 13:13:13 lfs kernel: ata2.00: exception Emask 0x0 SAct 0x0 SErr
0x0 action 0x6
Sep 26 13:13:13 lfs kernel: ata2.00: port_status 0x20200000
Sep 26 13:13:13 lfs kernel: ata2.00: cmd
35/00:08:af:4f:bb/00:00:35:00:00/e0 tag 0 dma 4096 out
Sep 26 13:13:13 lfs kernel:          res
51/84:00:b6:4f:bb/84:00:35:00:00/e0 Emask 0x10 (ATA bus error)
Sep 26 13:13:13 lfs kernel: ata2.00: status: { DRDY ERR }
Sep 26 13:13:13 lfs kernel: ata2.00: error: { ICRC ABRT }
Sep 26 13:13:13 lfs kernel: ata2: hard resetting link
Sep 26 13:13:13 lfs kernel: ata2: SATA link up 1.5 Gbps (SStatus 113
SControl 310)
Sep 26 13:13:13 lfs kernel: ata2.00: configured for UDMA/33
Sep 26 13:13:13 lfs kernel: ata2: EH complete
Sep 26 13:13:14 lfs kernel: ata2.00: exception Emask 0x0 SAct 0x0 SErr
0x0 action 0x6
Sep 26 13:13:14 lfs kernel: ata2.00: port_status 0x20200000
Sep 26 13:13:14 lfs kernel: ata2.00: cmd
35/00:08:17:a4:ca/00:00:35:00:00/e0 tag 0 dma 4096 out
Sep 26 13:13:14 lfs kernel:          res
51/84:00:1e:a4:ca/84:00:35:00:00/e0 Emask 0x10 (ATA bus error)
Sep 26 13:13:14 lfs kernel: ata2.00: status: { DRDY ERR }
Sep 26 13:13:14 lfs kernel: ata2.00: error: { ICRC ABRT }
Sep 26 13:13:14 lfs kernel: ata2: hard resetting link
Sep 26 13:13:14 lfs kernel: ata2: SATA link up 1.5 Gbps (SStatus 113
SControl 310)
Sep 26 13:13:14 lfs kernel: ata2.00: configured for UDMA/33
Sep 26 13:13:14 lfs kernel: ata2: EH complete
Sep 26 13:13:14 lfs kernel: ata2.00: exception Emask 0x0 SAct 0x0 SErr
0x0 action 0x6
Sep 26 13:13:14 lfs kernel: ata2.00: port_status 0x20200000
Sep 26 13:13:14 lfs kernel: ata2.00: cmd
35/00:08:27:4d:d1/00:00:35:00:00/e0 tag 0 dma 4096 out
Sep 26 13:13:14 lfs kernel:          res
51/84:00:2e:4d:d1/84:00:35:00:00/e0 Emask 0x10 (ATA bus error)
Sep 26 13:13:14 lfs kernel: ata2.00: status: { DRDY ERR }
Sep 26 13:13:14 lfs kernel: ata2.00: error: { ICRC ABRT }
Sep 26 13:13:14 lfs kernel: ata2: hard resetting link
Sep 26 13:13:20 lfs kernel: ata2: link is slow to respond, please be
patient (ready=-19)
Sep 26 13:13:25 lfs kernel: ata2: SRST failed (errno=-16)
Sep 26 13:13:25 lfs kernel: ata2: hard resetting link
Sep 26 13:13:25 lfs kernel: ata2: SATA link up 1.5 Gbps (SStatus 113
SControl 310)
Sep 26 13:13:25 lfs kernel: ata2.00: configured for UDMA/33
Sep 26 13:13:25 lfs kernel: ata2: exception Emask 0x10 SAct 0x0 SErr
0x0 action 0x9 t4
Sep 26 13:13:25 lfs kernel: ata2: hotplug_status 0x2
Sep 26 13:13:25 lfs kernel: ata2.00: configured for UDMA/33
Sep 26 13:13:25 lfs kernel: ata2: EH complete
Sep 26 13:13:27 lfs kernel: ata2.00: exception Emask 0x0 SAct 0x0 SErr
0x0 action 0x6
Sep 26 13:13:27 lfs kernel: ata2.00: port_status 0x20200000
Sep 26 13:13:27 lfs kernel: ata2.00: cmd
35/00:08:4f:72:d1/00:00:35:00:00/e0 tag 0 dma 4096 out
Sep 26 13:13:27 lfs kernel:          res
51/84:00:56:72:d1/84:00:35:00:00/e0 Emask 0x10 (ATA bus error)
Sep 26 13:13:27 lfs kernel: ata2.00: status: { DRDY ERR }
Sep 26 13:13:27 lfs kernel: ata2.00: error: { ICRC ABRT }
Sep 26 13:13:27 lfs kernel: ata2: hard resetting link
Sep 26 13:13:28 lfs kernel: ata2: SATA link up 1.5 Gbps (SStatus 113
SControl 310)
Sep 26 13:13:28 lfs kernel: ata2.00: configured for UDMA/33
Sep 26 13:13:28 lfs kernel: ata2: exception Emask 0x10 SAct 0x0 SErr
0x0 action 0x9 t4
Sep 26 13:13:28 lfs kernel: ata2: hotplug_status 0x20
Sep 26 13:13:28 lfs kernel: ata2.00: configured for UDMA/33
Sep 26 13:13:28 lfs kernel: ata2: EH complete
Sep 26 13:13:31 lfs kernel: ata2.00: exception Emask 0x0 SAct 0x0 SErr
0x0 action 0x6
Sep 26 13:13:31 lfs kernel: ata2.00: port_status 0x20200000
Sep 26 13:13:31 lfs kernel: ata2.00: cmd
35/00:f8:3f:2b:ed/00:03:35:00:00/e0 tag 0 dma 520192 out
Sep 26 13:13:31 lfs kernel:          res
51/84:00:36:2f:ed/84:00:35:00:00/e0 Emask 0x10 (ATA bus error)
Sep 26 13:13:31 lfs kernel: ata2.00: status: { DRDY ERR }
Sep 26 13:13:31 lfs kernel: ata2.00: error: { ICRC ABRT }
Sep 26 13:13:31 lfs kernel: ata2: hard resetting link
Sep 26 13:13:31 lfs kernel: ata2: SATA link up 1.5 Gbps (SStatus 113
SControl 310)
Sep 26 13:13:31 lfs kernel: ata2.00: configured for UDMA/33
Sep 26 13:13:31 lfs kernel: ata2: exception Emask 0x10 SAct 0x0 SErr
0x0 action 0x9 t4
Sep 26 13:13:31 lfs kernel: ata2: hotplug_status 0x22
Sep 26 13:13:32 lfs kernel: ata2.00: configured for UDMA/33
Sep 26 13:13:32 lfs kernel: ata2: EH complete
Sep 26 13:13:32 lfs kernel: ata2.00: exception Emask 0x0 SAct 0x0 SErr
0x0 action 0x6
Sep 26 13:13:32 lfs kernel: ata2.00: port_status 0x20200000
Sep 26 13:13:32 lfs kernel: ata2.00: cmd
35/00:08:ef:20:d3/00:00:35:00:00/e0 tag 0 dma 4096 out
Sep 26 13:13:32 lfs kernel:          res
51/84:00:f6:20:d3/84:00:35:00:00/e0 Emask 0x10 (ATA bus error)
Sep 26 13:13:32 lfs kernel: ata2.00: status: { DRDY ERR }
Sep 26 13:13:32 lfs kernel: ata2.00: error: { ICRC ABRT }
Sep 26 13:13:32 lfs kernel: ata2: hard resetting link
Sep 26 13:13:32 lfs kernel: ata2: SATA link up 1.5 Gbps (SStatus 113
SControl 310)
Sep 26 13:13:32 lfs kernel: ata2.00: configured for UDMA/33
Sep 26 13:13:32 lfs kernel: ata2: exception Emask 0x10 SAct 0x0 SErr
0x0 action 0x9 t4
Sep 26 13:13:32 lfs kernel: ata2: hotplug_status 0x22
Sep 26 13:13:32 lfs kernel: ata2.00: configured for UDMA/33
Sep 26 13:13:32 lfs kernel: ata2: EH complete
Sep 26 13:13:33 lfs kernel: ata2.00: exception Emask 0x0 SAct 0x0 SErr
0x0 action 0x6
Sep 26 13:13:33 lfs kernel: ata2.00: port_status 0x20200000
Sep 26 13:13:33 lfs kernel: ata2.00: cmd
35/00:38:37:63:ed/00:02:35:00:00/e0 tag 0 dma 290816 out
Sep 26 13:13:33 lfs kernel:          res
51/84:00:6e:65:ed/84:00:35:00:00/e0 Emask 0x10 (ATA bus error)
Sep 26 13:13:33 lfs kernel: ata2.00: status: { DRDY ERR }
Sep 26 13:13:33 lfs kernel: ata2.00: error: { ICRC ABRT }
Sep 26 13:13:33 lfs kernel: ata2: hard resetting link
Sep 26 13:13:33 lfs kernel: ata2: SATA link up 1.5 Gbps (SStatus 113
SControl 310)
Sep 26 13:13:33 lfs kernel: ata2.00: configured for UDMA/33
Sep 26 13:13:33 lfs kernel: ata2: exception Emask 0x10 SAct 0x0 SErr
0x0 action 0x9 t4
Sep 26 13:13:33 lfs kernel: ata2: hotplug_status 0x22
Sep 26 13:13:33 lfs kernel: ata2.00: configured for UDMA/33
Sep 26 13:13:33 lfs kernel: ata2: EH complete
Sep 26 13:13:33 lfs kernel: ata2.00: exception Emask 0x0 SAct 0x0 SErr
0x0 action 0x6
Sep 26 13:13:33 lfs kernel: ata2.00: port_status 0x20200000
Sep 26 13:13:33 lfs kernel: ata2.00: cmd
35/00:98:d7:84:ed/00:00:35:00:00/e0 tag 0 dma 77824 out
Sep 26 13:13:33 lfs kernel:          res
51/84:00:6e:85:ed/84:00:35:00:00/e0 Emask 0x10 (ATA bus error)
Sep 26 13:13:33 lfs kernel: ata2.00: status: { DRDY ERR }
Sep 26 13:13:33 lfs kernel: ata2.00: error: { ICRC ABRT }
Sep 26 13:13:33 lfs kernel: ata2: hard resetting link
Sep 26 13:13:34 lfs kernel: ata2: SATA link up 1.5 Gbps (SStatus 113
SControl 310)
Sep 26 13:13:34 lfs kernel: ata2.00: configured for UDMA/33
Sep 26 13:13:34 lfs kernel: ata2: exception Emask 0x10 SAct 0x0 SErr
0x0 action 0x9 t4
Sep 26 13:13:34 lfs kernel: ata2: hotplug_status 0x22
Sep 26 13:13:34 lfs kernel: ata2.00: configured for UDMA/33
Sep 26 13:13:34 lfs kernel: ata2: EH complete
Sep 26 13:13:34 lfs kernel: ata2.00: exception Emask 0x0 SAct 0x0 SErr
0x0 action 0x6
Sep 26 13:13:34 lfs kernel: ata2.00: port_status 0x20200000
Sep 26 13:13:34 lfs kernel: ata2.00: cmd
35/00:38:5f:9d:ed/00:00:35:00:00/e0 tag 0 dma 28672 out
Sep 26 13:13:34 lfs kernel:          res
51/84:00:96:9d:ed/84:00:35:00:00/e0 Emask 0x10 (ATA bus error)
Sep 26 13:13:34 lfs kernel: ata2.00: status: { DRDY ERR }
Sep 26 13:13:34 lfs kernel: ata2.00: error: { ICRC ABRT }
Sep 26 13:13:34 lfs kernel: ata2: hard resetting link
Sep 26 13:13:35 lfs kernel: ata2: SATA link up 1.5 Gbps (SStatus 113
SControl 310)
Sep 26 13:13:35 lfs kernel: ata2.00: configured for UDMA/33
Sep 26 13:13:35 lfs kernel: ata2: exception Emask 0x10 SAct 0x0 SErr
0x0 action 0x9 t4
Sep 26 13:13:35 lfs kernel: ata2: hotplug_status 0x22
Sep 26 13:13:35 lfs kernel: ata2.00: configured for UDMA/33
Sep 26 13:13:35 lfs kernel: ata2: EH complete
Sep 26 13:13:35 lfs kernel: ata2.00: exception Emask 0x0 SAct 0x0 SErr
0x0 action 0x6
Sep 26 13:13:35 lfs kernel: ata2.00: port_status 0x20200000
Sep 26 13:13:35 lfs kernel: ata2.00: cmd
35/00:08:a7:e7:ed/00:00:35:00:00/e0 tag 0 dma 4096 out
Sep 26 13:13:35 lfs kernel:          res
51/84:00:ae:e7:ed/84:00:35:00:00/e0 Emask 0x10 (ATA bus error)
Sep 26 13:13:35 lfs kernel: ata2.00: status: { DRDY ERR }
Sep 26 13:13:35 lfs kernel: ata2.00: error: { ICRC ABRT }
Sep 26 13:13:35 lfs kernel: ata2: hard resetting link
Sep 26 13:13:36 lfs kernel: ata2: SATA link up 1.5 Gbps (SStatus 113
SControl 310)
Sep 26 13:13:36 lfs kernel: ata2.00: configured for UDMA/33
Sep 26 13:13:36 lfs kernel: ata2: exception Emask 0x10 SAct 0x0 SErr
0x0 action 0x9 t4
Sep 26 13:13:36 lfs kernel: ata2: hotplug_status 0x20
Sep 26 13:13:36 lfs kernel: ata2.00: configured for UDMA/33
Sep 26 13:13:36 lfs kernel: ata2: EH complete
Sep 26 13:13:36 lfs kernel: ata2.00: exception Emask 0x0 SAct 0x0 SErr
0x0 action 0x6
Sep 26 13:13:36 lfs kernel: ata2.00: port_status 0x20200000
Sep 26 13:13:36 lfs kernel: ata2.00: cmd
35/00:f8:17:ff:ed/00:03:35:00:00/e0 tag 0 dma 520192 out
Sep 26 13:13:36 lfs kernel:          res
51/84:00:0e:03:ee/84:00:35:00:00/e0 Emask 0x10 (ATA bus error)
Sep 26 13:13:36 lfs kernel: ata2.00: status: { DRDY ERR }
Sep 26 13:13:36 lfs kernel: ata2.00: error: { ICRC ABRT }
Sep 26 13:13:36 lfs kernel: ata2: hard resetting link
Sep 26 13:13:37 lfs kernel: ata2: SATA link up 1.5 Gbps (SStatus 113
SControl 310)
Sep 26 13:13:37 lfs kernel: ata2.00: configured for UDMA/33
Sep 26 13:13:37 lfs kernel: ata2: exception Emask 0x10 SAct 0x0 SErr
0x0 action 0x9 t4
Sep 26 13:13:37 lfs kernel: ata2: hotplug_status 0x22
Sep 26 13:13:37 lfs kernel: ata2.00: configured for UDMA/33
Sep 26 13:13:37 lfs kernel: ata2: EH complete
Sep 26 13:13:37 lfs kernel: ata2.00: exception Emask 0x0 SAct 0x0 SErr
0x0 action 0x6
Sep 26 13:13:37 lfs kernel: ata2.00: port_status 0x20200000
Sep 26 13:13:37 lfs kernel: ata2.00: cmd
35/00:f8:67:3e:ee/00:03:35:00:00/e0 tag 0 dma 520192 out
Sep 26 13:13:37 lfs kernel:          res
51/84:00:5e:42:ee/84:00:35:00:00/e0 Emask 0x10 (ATA bus error)
Sep 26 13:13:37 lfs kernel: ata2.00: status: { DRDY ERR }
Sep 26 13:13:37 lfs kernel: ata2.00: error: { ICRC ABRT }
Sep 26 13:13:37 lfs kernel: ata2: hard resetting link
Sep 26 13:13:38 lfs kernel: ata2: SATA link up 1.5 Gbps (SStatus 113
SControl 310)
Sep 26 13:13:38 lfs kernel: ata2.00: configured for UDMA/33
Sep 26 13:13:38 lfs kernel: ata2: EH complete
Sep 26 13:13:38 lfs kernel: ata2.00: exception Emask 0x0 SAct 0x0 SErr
0x0 action 0x6
Sep 26 13:13:38 lfs kernel: ata2.00: port_status 0x20200000
Sep 26 13:13:38 lfs kernel: ata2.00: cmd
35/00:f8:6f:49:ef/00:03:35:00:00/e0 tag 0 dma 520192 out
Sep 26 13:13:38 lfs kernel:          res
51/84:00:66:4d:ef/84:00:35:00:00/e0 Emask 0x10 (ATA bus error)
Sep 26 13:13:38 lfs kernel: ata2.00: status: { DRDY ERR }
Sep 26 13:13:38 lfs kernel: ata2.00: error: { ICRC ABRT }
Sep 26 13:13:38 lfs kernel: ata2: hard resetting link
Sep 26 13:13:39 lfs kernel: ata2: SATA link up 1.5 Gbps (SStatus 113
SControl 310)
Sep 26 13:13:39 lfs kernel: ata2.00: configured for UDMA/33
Sep 26 13:13:39 lfs kernel: ata2: EH complete
Sep 26 13:13:39 lfs kernel: ata2.00: exception Emask 0x0 SAct 0x0 SErr
0x0 action 0x6
Sep 26 13:13:39 lfs kernel: ata2.00: port_status 0x20200000
Sep 26 13:13:39 lfs kernel: ata2.00: cmd
35/00:50:f7:4c:ee/00:00:35:00:00/e0 tag 0 dma 40960 out
Sep 26 13:13:39 lfs kernel:          res
51/84:00:46:4d:ee/84:00:35:00:00/e0 Emask 0x10 (ATA bus error)
Sep 26 13:13:39 lfs kernel: ata2.00: status: { DRDY ERR }
Sep 26 13:13:39 lfs kernel: ata2.00: error: { ICRC ABRT }
Sep 26 13:13:39 lfs kernel: ata2: hard resetting link
Sep 26 13:13:40 lfs kernel: ata2: SATA link up 1.5 Gbps (SStatus 113
SControl 310)
Sep 26 13:13:40 lfs kernel: ata2.00: configured for UDMA/33
Sep 26 13:13:40 lfs kernel: ata2: exception Emask 0x10 SAct 0x0 SErr
0x0 action 0x9 t4
Sep 26 13:13:40 lfs kernel: ata2: hotplug_status 0x22
Sep 26 13:13:40 lfs kernel: ata2.00: configured for UDMA/33
Sep 26 13:13:40 lfs kernel: ata2: EH complete
Sep 26 13:13:40 lfs kernel: ata2.00: exception Emask 0x0 SAct 0x0 SErr
0x0 action 0x6
Sep 26 13:13:40 lfs kernel: ata2.00: port_status 0x20200000
Sep 26 13:13:40 lfs kernel: ata2.00: cmd
35/00:f8:77:84:ef/00:03:35:00:00/e0 tag 0 dma 520192 out
Sep 26 13:13:40 lfs kernel:          res
51/84:00:6e:88:ef/84:00:35:00:00/e0 Emask 0x10 (ATA bus error)
Sep 26 13:13:40 lfs kernel: ata2.00: status: { DRDY ERR }
Sep 26 13:13:40 lfs kernel: ata2.00: error: { ICRC ABRT }
Sep 26 13:13:40 lfs kernel: ata2: hard resetting link
Sep 26 13:13:41 lfs kernel: ata2: SATA link up 1.5 Gbps (SStatus 113
SControl 310)
Sep 26 13:13:41 lfs kernel: ata2.00: configured for UDMA/33
Sep 26 13:13:41 lfs kernel: ata2: exception Emask 0x10 SAct 0x0 SErr
0x0 action 0x9 t4
Sep 26 13:13:41 lfs kernel: ata2: hotplug_status 0x22
Sep 26 13:13:41 lfs kernel: ata2.00: configured for UDMA/33
Sep 26 13:13:41 lfs kernel: ata2: EH complete
Sep 26 13:13:41 lfs kernel: ata2.00: exception Emask 0x0 SAct 0x0 SErr
0x0 action 0x6
Sep 26 13:13:41 lfs kernel: ata2.00: port_status 0x20200000
Sep 26 13:13:41 lfs kernel: ata2.00: cmd
35/00:08:3f:71:d4/00:00:35:00:00/e0 tag 0 dma 4096 out
Sep 26 13:13:41 lfs kernel:          res
51/84:00:46:71:d4/84:00:35:00:00/e0 Emask 0x10 (ATA bus error)
Sep 26 13:13:41 lfs kernel: ata2.00: status: { DRDY ERR }
Sep 26 13:13:41 lfs kernel: ata2.00: error: { ICRC ABRT }
Sep 26 13:13:41 lfs kernel: ata2: hard resetting link
Sep 26 13:13:42 lfs kernel: ata2: SATA link up 1.5 Gbps (SStatus 113
SControl 310)
Sep 26 13:13:42 lfs kernel: ata2.00: configured for UDMA/33
Sep 26 13:13:42 lfs kernel: ata2: exception Emask 0x10 SAct 0x0 SErr
0x0 action 0x9 t4
Sep 26 13:13:42 lfs kernel: ata2: hotplug_status 0x20
Sep 26 13:13:42 lfs kernel: ata2.00: configured for UDMA/33
Sep 26 13:13:42 lfs kernel: ata2: EH complete
Sep 26 13:13:42 lfs kernel: ata2.00: exception Emask 0x0 SAct 0x0 SErr
0x0 action 0x6
Sep 26 13:13:42 lfs kernel: ata2.00: port_status 0x20200000
Sep 26 13:13:42 lfs kernel: ata2.00: cmd
35/00:30:97:5f:d4/00:00:35:00:00/e0 tag 0 dma 24576 out
Sep 26 13:13:42 lfs kernel:          res
51/84:00:c6:5f:d4/84:00:35:00:00/e0 Emask 0x10 (ATA bus error)
Sep 26 13:13:42 lfs kernel: ata2.00: status: { DRDY ERR }
Sep 26 13:13:42 lfs kernel: ata2.00: error: { ICRC ABRT }
Sep 26 13:13:42 lfs kernel: ata2: hard resetting link
Sep 26 13:13:43 lfs kernel: ata2: SATA link up 1.5 Gbps (SStatus 113
SControl 310)
Sep 26 13:13:43 lfs kernel: ata2.00: configured for UDMA/33
Sep 26 13:13:43 lfs kernel: ata2: exception Emask 0x10 SAct 0x0 SErr
0x0 action 0x9 t4
Sep 26 13:13:43 lfs kernel: ata2: hotplug_status 0x20
Sep 26 13:13:43 lfs kernel: ata2.00: configured for UDMA/33
Sep 26 13:13:43 lfs kernel: ata2: EH complete
Sep 26 13:13:46 lfs kernel: ata2.00: exception Emask 0x0 SAct 0x0 SErr
0x0 action 0x6
Sep 26 13:13:46 lfs kernel: ata2.00: port_status 0x20200000
Sep 26 13:13:46 lfs kernel: ata2.00: cmd
35/00:f8:f7:fc:f1/00:00:35:00:00/e0 tag 0 dma 126976 out
Sep 26 13:13:46 lfs kernel:          res
51/84:00:ee:fd:f1/84:00:35:00:00/e0 Emask 0x10 (ATA bus error)
Sep 26 13:13:46 lfs kernel: ata2.00: status: { DRDY ERR }
Sep 26 13:13:46 lfs kernel: ata2.00: error: { ICRC ABRT }
Sep 26 13:13:46 lfs kernel: ata2: hard resetting link
Sep 26 13:13:46 lfs kernel: ata2: SATA link up 1.5 Gbps (SStatus 113
SControl 310)
Sep 26 13:13:46 lfs kernel: ata2.00: configured for UDMA/33
Sep 26 13:13:46 lfs kernel: ata2: exception Emask 0x10 SAct 0x0 SErr
0x0 action 0x9 t4
Sep 26 13:13:46 lfs kernel: ata2: hotplug_status 0x22
Sep 26 13:13:46 lfs kernel: ata2.00: configured for UDMA/33
Sep 26 13:13:46 lfs kernel: ata2: EH complete
Sep 26 13:14:32 lfs kernel: ata2.00: exception Emask 0x0 SAct 0x0 SErr
0x0 action 0x6
Sep 26 13:14:32 lfs kernel: ata2.00: port_status 0x20200000
Sep 26 13:14:32 lfs kernel: ata2.00: cmd
35/00:d8:37:41:05/00:01:36:00:00/e0 tag 0 dma 241664 out
Sep 26 13:14:32 lfs kernel:          res
51/84:00:0e:43:05/84:00:36:00:00/e0 Emask 0x10 (ATA bus error)
Sep 26 13:14:32 lfs kernel: ata2.00: status: { DRDY ERR }
Sep 26 13:14:32 lfs kernel: ata2.00: error: { ICRC ABRT }
Sep 26 13:14:32 lfs kernel: ata2: hard resetting link
Sep 26 13:14:38 lfs kernel: ata2: link is slow to respond, please be
patient (ready=-19)
Sep 26 13:14:42 lfs kernel: ata2: SRST failed (errno=-16)
Sep 26 13:14:42 lfs kernel: ata2: hard resetting link
Sep 26 13:14:43 lfs kernel: ata2: SATA link up 1.5 Gbps (SStatus 113
SControl 310)
Sep 26 13:14:43 lfs kernel: ata2.00: configured for UDMA/33
Sep 26 13:14:43 lfs kernel: ata2: exception Emask 0x10 SAct 0x0 SErr
0x0 action 0x9 t4
Sep 26 13:14:43 lfs kernel: ata2: hotplug_status 0x2
Sep 26 13:14:43 lfs kernel: ata2.00: configured for UDMA/33
Sep 26 13:14:43 lfs kernel: ata2: EH complete
Sep 26 13:14:48 lfs kernel: ata2.00: exception Emask 0x0 SAct 0x0 SErr
0x0 action 0x6
Sep 26 13:14:48 lfs kernel: ata2.00: port_status 0x20200000
Sep 26 13:14:48 lfs kernel: ata2.00: cmd
35/00:08:9f:68:19/00:00:35:00:00/e0 tag 0 dma 4096 out
Sep 26 13:14:48 lfs kernel:          res
51/84:00:a6:68:19/84:00:35:00:00/e0 Emask 0x10 (ATA bus error)
Sep 26 13:14:48 lfs kernel: ata2.00: status: { DRDY ERR }
Sep 26 13:14:48 lfs kernel: ata2.00: error: { ICRC ABRT }
Sep 26 13:14:48 lfs kernel: ata2: hard resetting link
Sep 26 13:14:48 lfs kernel: ata2: SATA link up 1.5 Gbps (SStatus 113
SControl 310)
Sep 26 13:14:48 lfs kernel: ata2.00: configured for UDMA/33
Sep 26 13:14:48 lfs kernel: ata2: EH complete
Sep 26 13:15:21 lfs kernel: ata2.00: exception Emask 0x0 SAct 0x0 SErr
0x0 action 0x6
Sep 26 13:15:21 lfs kernel: ata2.00: port_status 0x20200000
Sep 26 13:15:21 lfs kernel: ata2.00: cmd
35/00:f0:bf:3d:1b/00:00:36:00:00/e0 tag 0 dma 122880 out
Sep 26 13:15:21 lfs kernel:          res
51/84:00:ae:3e:1b/84:00:36:00:00/e0 Emask 0x10 (ATA bus error)
Sep 26 13:15:21 lfs kernel: ata2.00: status: { DRDY ERR }
Sep 26 13:15:21 lfs kernel: ata2.00: error: { ICRC ABRT }
Sep 26 13:15:21 lfs kernel: ata2: hard resetting link
Sep 26 13:15:22 lfs kernel: ata2: SATA link up 1.5 Gbps (SStatus 113
SControl 310)
Sep 26 13:15:22 lfs kernel: ata2.00: configured for UDMA/33
Sep 26 13:15:22 lfs kernel: ata2: exception Emask 0x10 SAct 0x0 SErr
0x0 action 0x9 t4
Sep 26 13:15:22 lfs kernel: ata2: hotplug_status 0x22
Sep 26 13:15:22 lfs kernel: ata2.00: configured for UDMA/33
Sep 26 13:15:22 lfs kernel: ata2: EH complete
Sep 26 13:15:22 lfs kernel: ata2.00: exception Emask 0x0 SAct 0x0 SErr
0x0 action 0x6
Sep 26 13:15:22 lfs kernel: ata2.00: port_status 0x20200000
Sep 26 13:15:22 lfs kernel: ata2.00: cmd
35/00:28:17:6e:f8/00:00:35:00:00/e0 tag 0 dma 20480 out
Sep 26 13:15:22 lfs kernel:          res
51/84:00:3e:6e:f8/84:00:35:00:00/e0 Emask 0x10 (ATA bus error)
Sep 26 13:15:22 lfs kernel: ata2.00: status: { DRDY ERR }
Sep 26 13:15:22 lfs kernel: ata2.00: error: { ICRC ABRT }
Sep 26 13:15:22 lfs kernel: ata2: hard resetting link
Sep 26 13:15:28 lfs kernel: ata2: link is slow to respond, please be
patient (ready=-19)
Sep 26 13:15:32 lfs kernel: ata2: SRST failed (errno=-16)
Sep 26 13:15:32 lfs kernel: ata2: hard resetting link
Sep 26 13:15:33 lfs kernel: ata2: SATA link up 1.5 Gbps (SStatus 113
SControl 310)
Sep 26 13:15:33 lfs kernel: ata2.00: configured for UDMA/33
Sep 26 13:15:33 lfs kernel: ata2: exception Emask 0x10 SAct 0x0 SErr
0x0 action 0x9 t4
Sep 26 13:15:33 lfs kernel: ata2: hotplug_status 0x2
Sep 26 13:15:33 lfs kernel: ata2.00: configured for UDMA/33
Sep 26 13:15:33 lfs kernel: ata2: EH complete
Sep 26 13:15:38 lfs kernel: ata2.00: exception Emask 0x0 SAct 0x0 SErr
0x0 action 0x6
Sep 26 13:15:38 lfs kernel: ata2.00: port_status 0x20200000
Sep 26 13:15:38 lfs kernel: ata2.00: cmd
35/00:08:c7:ee:40/00:00:32:00:00/e0 tag 0 dma 4096 out
Sep 26 13:15:38 lfs kernel:          res
51/84:00:ce:ee:40/84:00:32:00:00/e0 Emask 0x10 (ATA bus error)
Sep 26 13:15:38 lfs kernel: ata2.00: status: { DRDY ERR }
Sep 26 13:15:38 lfs kernel: ata2.00: error: { ICRC ABRT }
Sep 26 13:15:38 lfs kernel: ata2: hard resetting link
Sep 26 13:15:39 lfs kernel: ata2: SATA link up 1.5 Gbps (SStatus 113
SControl 310)
Sep 26 13:15:39 lfs kernel: ata2.00: configured for UDMA/33
Sep 26 13:15:39 lfs kernel: ata2: EH complete
Sep 26 13:15:45 lfs kernel: ata2.00: exception Emask 0x0 SAct 0x0 SErr
0x0 action 0x6
Sep 26 13:15:45 lfs kernel: ata2.00: port_status 0x20200000
Sep 26 13:15:45 lfs kernel: ata2.00: cmd
35/00:f8:6f:18:21/00:03:36:00:00/e0 tag 0 dma 520192 out
Sep 26 13:15:45 lfs kernel:          res
51/84:00:66:1c:21/84:00:36:00:00/e0 Emask 0x10 (ATA bus error)
Sep 26 13:15:45 lfs kernel: ata2.00: status: { DRDY ERR }
Sep 26 13:15:45 lfs kernel: ata2.00: error: { ICRC ABRT }
Sep 26 13:15:45 lfs kernel: ata2: hard resetting link
Sep 26 13:15:46 lfs kernel: ata2: SATA link up 1.5 Gbps (SStatus 113
SControl 310)
Sep 26 13:15:46 lfs kernel: ata2.00: configured for UDMA/33
Sep 26 13:15:46 lfs kernel: ata2: exception Emask 0x10 SAct 0x0 SErr
0x0 action 0x9 t4
Sep 26 13:15:46 lfs kernel: ata2: hotplug_status 0x22
Sep 26 13:15:46 lfs kernel: ata2.00: configured for UDMA/33
Sep 26 13:15:46 lfs kernel: ata2: EH complete
Sep 26 13:15:54 lfs kernel: ata2.00: exception Emask 0x0 SAct 0x0 SErr
0x0 action 0x6
Sep 26 13:15:54 lfs kernel: ata2.00: port_status 0x20200000
Sep 26 13:15:54 lfs kernel: ata2.00: cmd
35/00:f8:87:d7:29/00:03:36:00:00/e0 tag 0 dma 520192 out
Sep 26 13:15:54 lfs kernel:          res
51/84:00:7e:db:29/84:00:36:00:00/e0 Emask 0x10 (ATA bus error)
Sep 26 13:15:54 lfs kernel: ata2.00: status: { DRDY ERR }
Sep 26 13:15:54 lfs kernel: ata2.00: error: { ICRC ABRT }
Sep 26 13:15:54 lfs kernel: ata2: hard resetting link
Sep 26 13:15:55 lfs kernel: ata2: SATA link up 1.5 Gbps (SStatus 113
SControl 310)
Sep 26 13:15:55 lfs kernel: ata2.00: configured for UDMA/33
Sep 26 13:15:55 lfs kernel: ata2: exception Emask 0x10 SAct 0x0 SErr
0x0 action 0x9 t4
Sep 26 13:15:55 lfs kernel: ata2: hotplug_status 0x22
Sep 26 13:15:55 lfs kernel: ata2.00: configured for UDMA/33
Sep 26 13:15:55 lfs kernel: ata2: EH complete
Sep 26 13:16:30 lfs kernel: ata2.00: exception Emask 0x0 SAct 0x0 SErr
0x0 action 0x6
Sep 26 13:16:30 lfs kernel: ata2.00: port_status 0x20200000
Sep 26 13:16:30 lfs kernel: ata2.00: cmd
35/00:08:97:1f:1b/00:00:36:00:00/e0 tag 0 dma 4096 out
Sep 26 13:16:30 lfs kernel:          res
51/84:00:9e:1f:1b/84:00:36:00:00/e0 Emask 0x10 (ATA bus error)
Sep 26 13:16:30 lfs kernel: ata2.00: status: { DRDY ERR }
Sep 26 13:16:30 lfs kernel: ata2.00: error: { ICRC ABRT }
Sep 26 13:16:30 lfs kernel: ata2: hard resetting link
Sep 26 13:16:30 lfs kernel: ata2: SATA link up 1.5 Gbps (SStatus 113
SControl 310)
Sep 26 13:16:30 lfs kernel: ata2.00: configured for UDMA/33
Sep 26 13:16:30 lfs kernel: ata2: exception Emask 0x10 SAct 0x0 SErr
0x0 action 0x9 t4
Sep 26 13:16:30 lfs kernel: ata2: hotplug_status 0x22
Sep 26 13:16:30 lfs kernel: ata2.00: configured for UDMA/33
Sep 26 13:16:30 lfs kernel: ata2: EH complete
Sep 26 13:16:35 lfs kernel: ata2.00: exception Emask 0x0 SAct 0x0 SErr
0x0 action 0x6
Sep 26 13:16:35 lfs kernel: ata2.00: port_status 0x20200000
Sep 26 13:16:35 lfs kernel: ata2.00: cmd
35/00:08:4f:75:1d/00:00:36:00:00/e0 tag 0 dma 4096 out
Sep 26 13:16:35 lfs kernel:          res
51/84:00:56:75:1d/84:00:36:00:00/e0 Emask 0x10 (ATA bus error)
Sep 26 13:16:35 lfs kernel: ata2.00: status: { DRDY ERR }
Sep 26 13:16:35 lfs kernel: ata2.00: error: { ICRC ABRT }
Sep 26 13:16:35 lfs kernel: ata2: hard resetting link
Sep 26 13:16:35 lfs kernel: ata2: SATA link up 1.5 Gbps (SStatus 113
SControl 310)
Sep 26 13:16:36 lfs kernel: ata2.00: configured for UDMA/33
Sep 26 13:16:36 lfs kernel: ata2: exception Emask 0x10 SAct 0x0 SErr
0x0 action 0x9 t4
Sep 26 13:16:36 lfs kernel: ata2: hotplug_status 0x22
Sep 26 13:16:36 lfs kernel: ata2.00: configured for UDMA/33
Sep 26 13:16:36 lfs kernel: ata2: EH complete
Sep 26 13:17:09 lfs kernel: ata2.00: exception Emask 0x0 SAct 0x0 SErr
0x0 action 0x6
Sep 26 13:17:09 lfs kernel: ata2.00: port_status 0x20200000
Sep 26 13:17:09 lfs kernel: ata2.00: cmd
35/00:e8:5f:a7:74/00:00:33:00:00/e0 tag 0 dma 118784 out
Sep 26 13:17:09 lfs kernel:          res
51/84:00:46:a8:74/84:00:33:00:00/e0 Emask 0x10 (ATA bus error)
Sep 26 13:17:09 lfs kernel: ata2.00: status: { DRDY ERR }
Sep 26 13:17:09 lfs kernel: ata2.00: error: { ICRC ABRT }
Sep 26 13:17:09 lfs kernel: ata2: hard resetting link
Sep 26 13:17:09 lfs kernel: ata2: SATA link up 1.5 Gbps (SStatus 113
SControl 310)
Sep 26 13:17:09 lfs kernel: ata2.00: configured for UDMA/33
Sep 26 13:17:09 lfs kernel: ata2: EH complete
Sep 26 13:18:04 lfs kernel: ata2.00: exception Emask 0x0 SAct 0x0 SErr
0x0 action 0x6
Sep 26 13:18:04 lfs kernel: ata2.00: port_status 0x20200000
Sep 26 13:18:04 lfs kernel: ata2.00: cmd
35/00:10:0f:65:fb/00:00:35:00:00/e0 tag 0 dma 8192 out
Sep 26 13:18:04 lfs kernel:          res
51/84:00:1e:65:fb/84:00:35:00:00/e0 Emask 0x10 (ATA bus error)
Sep 26 13:18:04 lfs kernel: ata2.00: status: { DRDY ERR }
Sep 26 13:18:04 lfs kernel: ata2.00: error: { ICRC ABRT }
Sep 26 13:18:04 lfs kernel: ata2: hard resetting link
Sep 26 13:18:04 lfs kernel: ata2: SATA link up 1.5 Gbps (SStatus 113
SControl 310)
Sep 26 13:18:04 lfs kernel: ata2.00: configured for UDMA/33
Sep 26 13:18:04 lfs kernel: ata2: exception Emask 0x10 SAct 0x0 SErr
0x0 action 0x9 t4
Sep 26 13:18:04 lfs kernel: ata2: hotplug_status 0x2
Sep 26 13:18:04 lfs kernel: ata2.00: configured for UDMA/33
Sep 26 13:18:04 lfs kernel: ata2: EH complete
Sep 26 13:18:40 lfs kernel: ata2.00: exception Emask 0x0 SAct 0x0 SErr
0x0 action 0x6
Sep 26 13:18:40 lfs kernel: ata2.00: port_status 0x20200000
Sep 26 13:18:40 lfs kernel: ata2.00: cmd
35/00:08:df:03:1d/00:00:36:00:00/e0 tag 0 dma 4096 out
Sep 26 13:18:40 lfs kernel:          res
51/84:00:e6:03:1d/84:00:36:00:00/e0 Emask 0x10 (ATA bus error)
Sep 26 13:18:40 lfs kernel: ata2.00: status: { DRDY ERR }
Sep 26 13:18:40 lfs kernel: ata2.00: error: { ICRC ABRT }
Sep 26 13:18:40 lfs kernel: ata2: hard resetting link
Sep 26 13:18:45 lfs kernel: ata2: link is slow to respond, please be
patient (ready=-19)
Sep 26 13:18:50 lfs kernel: ata2: SRST failed (errno=-16)
Sep 26 13:18:50 lfs kernel: ata2: hard resetting link
Sep 26 13:18:50 lfs kernel: ata2: SATA link up 1.5 Gbps (SStatus 113
SControl 310)
Sep 26 13:18:50 lfs kernel: ata2.00: configured for UDMA/33
Sep 26 13:18:50 lfs kernel: ata2: exception Emask 0x10 SAct 0x0 SErr
0x0 action 0x9 t4
Sep 26 13:18:50 lfs kernel: ata2: hotplug_status 0x22
Sep 26 13:18:50 lfs kernel: ata2.00: configured for UDMA/33
Sep 26 13:18:50 lfs kernel: ata2: EH complete
Sep 26 13:19:20 lfs kernel: ata2.00: exception Emask 0x0 SAct 0x0 SErr
0x0 action 0x6
Sep 26 13:19:20 lfs kernel: ata2.00: port_status 0x20200000
Sep 26 13:19:20 lfs kernel: ata2.00: cmd
35/00:08:cf:57:70/00:00:38:00:00/e0 tag 0 dma 4096 out
Sep 26 13:19:20 lfs kernel:          res
51/84:00:d6:57:70/84:00:38:00:00/e0 Emask 0x10 (ATA bus error)
Sep 26 13:19:20 lfs kernel: ata2.00: status: { DRDY ERR }
Sep 26 13:19:20 lfs kernel: ata2.00: error: { ICRC ABRT }
Sep 26 13:19:20 lfs kernel: ata2: hard resetting link
Sep 26 13:19:21 lfs kernel: ata2: SATA link up 1.5 Gbps (SStatus 113
SControl 310)
Sep 26 13:19:21 lfs kernel: ata2.00: configured for UDMA/33


lspci -x
00:00.0 Host bridge: VIA Technologies, Inc. VT82C693A/694x [Apollo
PRO133x] (rev c4)
00: 06 11 91 06 06 00 10 a2 c4 00 00 06 00 00 00 00
10: 08 00 00 e4 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 43 10 17 80
30: 00 00 00 00 a0 00 00 00 00 00 00 00 00 00 00 00

00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598/694x [Apollo
MVP3/Pro133x AGP]
00: 06 11 98 85 07 00 30 22 00 00 04 06 00 00 01 00
10: 00 00 00 00 00 00 00 00 00 01 01 00 f0 00 00 00
20: 00 d6 d0 d7 f0 d7 f0 e3 00 00 00 00 00 00 00 00
30: 00 00 00 00 80 00 00 00 00 00 00 00 00 00 08 00

00:04.0 ISA bridge: VIA Technologies, Inc. VT82C596 ISA [Mobile South] (rev 12)
00: 06 11 96 05 87 00 00 02 12 00 01 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 43 10 17 80
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:04.1 IDE interface: VIA Technologies, Inc.
VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06)
00: 06 11 71 05 87 00 80 02 06 8a 01 01 00 20 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 d8 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:04.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
Controller (rev 08)
00: 06 11 38 30 17 00 00 02 08 00 03 0c 08 20 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 d4 00 00 00 00 00 00 00 00 00 00 25 09 34 12
30: 00 00 00 00 00 00 00 00 00 00 00 00 09 04 00 00

00:04.3 Host bridge: VIA Technologies, Inc. VT82C596 Power Management (rev 20)
00: 06 11 50 30 00 00 80 02 20 00 00 06 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:09.0 Ethernet controller: Linksys NC100 Network Everywhere Fast
Ethernet 10/100 (rev 11)
00: 17 13 85 09 17 00 90 02 11 00 00 02 08 20 00 00
10: 01 d0 00 00 00 00 80 d5 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 02 02 00 00 17 13 74 05
30: 00 00 00 00 c0 00 00 00 00 00 00 00 09 01 ff ff

00:0a.0 Multimedia controller: Sigma Designs, Inc. REALmagic Hollywood
Plus DVD Decoder (rev 02)
00: 05 11 00 83 06 00 10 02 02 00 80 04 00 20 00 00
10: 00 00 00 d5 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 05 01 00 00

00:0b.0 Multimedia audio controller: Ensoniq 5880 AudioPCI (rev 02)
00: 74 12 80 58 05 00 10 04 02 00 01 04 00 20 00 00
10: 01 b8 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 74 12 00 20
30: 00 00 00 00 dc 00 00 00 00 00 00 00 0a 01 0c 80

00:0c.0 Mass storage controller: Promise Technology, Inc. PDC20268
(Ultra100 TX2) (rev 02)
00: 5a 10 68 4d 07 00 30 04 02 85 80 01 08 20 00 00
10: 01 b4 00 00 01 b0 00 00 01 a8 00 00 01 a4 00 00
20: 01 a0 00 00 00 00 80 d4 00 00 00 00 5a 10 68 4d
30: 00 00 00 00 60 00 00 00 00 00 00 00 0b 01 04 12

00:0d.0 Communication controller: Agere Systems 56k WinModem (rev 01)
00: c1 11 42 04 07 00 90 02 01 00 80 07 00 00 00 00
10: 00 00 00 d4 01 98 00 00 01 94 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 40 00 00 00 1c 14 00 93
30: 00 00 00 00 f8 00 00 00 00 00 00 00 09 01 fc 0e

00:0e.0 Mass storage controller: Promise Technology, Inc. PDC40718
(SATA 300 TX4) (rev 02)
00: 5a 10 17 3d 17 00 30 02 02 00 80 01 01 58 00 00
10: 01 90 00 00 00 00 00 00 01 88 00 00 00 00 80 d3
20: 00 00 00 d3 00 00 00 00 00 00 00 00 5a 10 17 3d
30: 00 00 00 00 60 00 00 00 00 00 00 00 05 01 04 12

01:00.0 VGA compatible controller: nVidia Corporation NV11 [GeForce2
MX/MX 400] (rev a1)
00: de 10 10 01 07 00 b0 02 a1 00 00 03 00 40 00 00
10: 00 00 00 d6 08 00 00 d8 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 a0 a0 33 00
30: 00 00 ff d7 60 00 00 00 00 00 00 00 0b 01 05 01

Sep 26 13:19:21 lfs kernel: ata2: EH complete


lspci -vvvxxx
00:00.0 Host bridge: VIA Technologies, Inc. VT82C693A/694x [Apollo
PRO133x] (rev c4)
	Subsystem: ASUSTeK Computer Inc. Unknown device 8017
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR+
	Latency: 0
	Region 0: Memory at e4000000 (32-bit, prefetchable) [size=64M]
	Capabilities: [a0] AGP version 2.0
		Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit-
FW- AGP3- Rate=x1,x2,x4
		Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=<none>
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 06 11 91 06 06 00 10 a2 c4 00 00 06 00 00 00 00
10: 08 00 00 e4 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 43 10 17 80
30: 00 00 00 00 a0 00 00 00 00 00 00 00 00 00 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: fd d8 c8 f6 04 00 50 60 ee 0e 10 20 30 40 40 40
60: cf aa 02 a0 e6 e6 95 e6 41 7c 86 2f 18 3f 00 77
70: c0 88 cc 0c 0e a1 d2 00 00 f4 01 02 00 00 00 00
80: 0f 40 00 00 c0 00 00 00 03 00 35 37 a0 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 02 c0 20 00 07 02 00 1f 00 00 00 00 6b 02 04 00
b0: 5f ec 10 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 01 00 02 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 0e 22 00 00 00 00 00 00 00

00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598/694x [Apollo
MVP3/Pro133x AGP] (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: d6000000-d7dfffff
	Prefetchable memory behind bridge: d7f00000-e3ffffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 06 11 98 85 07 00 30 22 00 00 04 06 00 00 01 00
10: 00 00 00 00 00 00 00 00 00 01 01 00 f0 00 00 00
20: 00 d6 d0 d7 f0 d7 f0 e3 00 00 00 00 00 00 00 00
30: 00 00 00 00 80 00 00 00 00 00 00 00 00 00 08 00
40: c8 cd 00 44 04 72 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 01 00 02 02 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:04.0 ISA bridge: VIA Technologies, Inc. VT82C596 ISA [Mobile South] (rev 12)
	Subsystem: ASUSTeK Computer Inc. Unknown device 8017
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping+ SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
00: 06 11 96 05 87 00 00 02 12 00 01 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 43 10 17 80
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 00 01 00 00 00 80 60 a0 01 00 84 00 00 00 00 f3
50: 24 00 00 00 00 b0 5a 90 00 04 f4 08 40 00 00 00
60: 00 00 00 00 00 00 00 00 08 00 00 00 00 00 00 00
70: 00 00 00 00 01 00 00 02 04 e4 00 00 00 00 00 00
80: 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:04.1 IDE interface: VIA Technologies, Inc.
VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06)
(prog-if 8a [Master SecP PriP])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping+ SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Region 0: [virtual] Memory at 000001f0 (32-bit, non-prefetchable) [size=8]
	Region 1: [virtual] Memory at 000003f0 (type 3, non-prefetchable) [size=1]
	Region 2: [virtual] Memory at 00000170 (32-bit, non-prefetchable) [size=8]
	Region 3: [virtual] Memory at 00000370 (type 3, non-prefetchable) [size=1]
	Region 4: I/O ports at d800 [size=16]
00: 06 11 71 05 87 00 80 02 06 8a 01 01 00 20 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 d8 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 0b 02 09 3a 08 1c c0 00 20 20 99 99 a0 00 20 a8
50: ea e2 0f 07 14 00 00 00 a8 a8 a8 a8 00 00 00 00
60: 00 02 00 00 00 00 00 00 00 02 00 00 00 00 00 00
70: 82 01 00 00 00 00 00 00 02 01 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 60 1b 37 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 06 00 71 05 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:04.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
Controller (rev 08) (prog-if 00 [UHCI])
	Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, Cache Line Size: 32 bytes
	Interrupt: pin D routed to IRQ 9
	Region 4: I/O ports at d400 [size=32]
00: 06 11 38 30 17 00 00 02 08 00 03 0c 08 20 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 d4 00 00 00 00 00 00 00 00 00 00 25 09 34 12
30: 00 00 00 00 00 00 00 00 00 00 00 00 09 04 00 00
40: 00 02 07 00 c2 00 32 e4 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 10 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 20 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:04.3 Host bridge: VIA Technologies, Inc. VT82C596 Power Management (rev 20)
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
00: 06 11 50 30 00 00 80 02 20 00 00 06 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 20 84 49 00 00 00 00 00 01 e4 00 00 48 00 00 00
50: 00 ff ff 04 00 00 00 00 00 ff ff 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 01 e8 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:09.0 Ethernet controller: Linksys NC100 Network Everywhere Fast
Ethernet 10/100 (rev 11)
	Subsystem: Linksys Unknown device 0574
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (63750ns min, 63750ns max), Cache Line Size: 32 bytes
	Interrupt: pin A routed to IRQ 9
	Region 0: I/O ports at d000 [size=256]
	Region 1: Memory at d5800000 (32-bit, non-prefetchable) [size=1K]
	[virtual] Expansion ROM at 60000000 [disabled] [size=128K]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 17 13 85 09 17 00 90 02 11 00 00 02 08 20 00 00
10: 01 d0 00 00 00 00 80 d5 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 02 02 00 00 17 13 74 05
30: 00 00 00 00 c0 00 00 00 00 00 00 00 09 01 ff ff
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 17 13 81 09 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 01 00 02 fe 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:0a.0 Multimedia controller: Sigma Designs, Inc. REALmagic Hollywood
Plus DVD Decoder (rev 02)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Interrupt: pin A routed to IRQ 5
	Region 0: Memory at d5000000 (32-bit, non-prefetchable) [size=1M]
	Capabilities: [40] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 05 11 00 83 06 00 10 02 02 00 80 04 00 20 00 00
10: 00 00 00 d5 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 05 01 00 00
40: 01 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 05 11 00 83 06 00 10 02 02 00 80 04 00 20 00 00
90: 00 00 00 d5 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 40 00 00 00 00 00 00 00 05 01 00 00
c0: 01 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:0b.0 Multimedia audio controller: Ensoniq 5880 AudioPCI (rev 02)
	Subsystem: Ensoniq Creative Sound Blaster AudioPCI128
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (3000ns min, 32000ns max)
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at b800 [size=64]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI+ D1- D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 74 12 80 58 05 00 10 04 02 00 01 04 00 20 00 00
10: 01 b8 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 74 12 00 20
30: 00 00 00 00 dc 00 00 00 00 00 00 00 0a 01 0c 80
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 01 00 21 04
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:0c.0 Mass storage controller: Promise Technology, Inc. PDC20268
(Ultra100 TX2) (rev 02) (prog-if 85)
	Subsystem: Promise Technology, Inc. Ultra100TX2
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=slow >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (1000ns min, 4500ns max), Cache Line Size: 32 bytes
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at b400 [size=8]
	Region 1: I/O ports at b000 [size=4]
	Region 2: I/O ports at a800 [size=8]
	Region 3: I/O ports at a400 [size=4]
	Region 4: I/O ports at a000 [size=16]
	Region 5: Memory at d4800000 (32-bit, non-prefetchable) [size=16K]
	[virtual] Expansion ROM at 60028000 [disabled] [size=16K]
	Capabilities: [60] Power Management version 1
		Flags: PMEClk- DSI+ D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 5a 10 68 4d 07 00 30 04 02 85 80 01 08 20 00 00
10: 01 b4 00 00 01 b0 00 00 01 a8 00 00 01 a4 00 00
20: 01 a0 00 00 00 00 80 d4 00 00 00 00 5a 10 68 4d
30: 00 00 00 00 60 00 00 00 00 00 00 00 0b 01 04 12
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 01 00 21 02 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:0d.0 Communication controller: Agere Systems 56k WinModem (rev 01)
	Subsystem: Unknown device 141c:9300
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (63000ns min, 3500ns max)
	Interrupt: pin A routed to IRQ 9
	Region 0: Memory at d4000000 (32-bit, non-prefetchable) [size=256]
	Region 1: I/O ports at 9800 [size=8]
	Region 2: I/O ports at 9400 [size=256]
	Capabilities: [f8] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2+ AuxCurrent=0mA PME(D0-,D1-,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: c1 11 42 04 07 00 90 02 01 00 80 07 00 00 00 00
10: 00 00 00 d4 01 98 00 00 01 94 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 40 00 00 00 1c 14 00 93
30: 00 00 00 00 f8 00 00 00 00 00 00 00 09 01 fc 0e
40: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
50: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
60: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
70: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
f0: ff ff ff ff ff ff ff ff 01 00 22 e4 00 00 00 00

00:0e.0 Mass storage controller: Promise Technology, Inc. PDC40718
(SATA 300 TX4) (rev 02)
	Subsystem: Promise Technology, Inc. PDC40718 (SATA 300 TX4)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 88 (1000ns min, 4500ns max), Cache Line Size: 4 bytes
	Interrupt: pin A routed to IRQ 5
	Region 0: I/O ports at 9000 [size=128]
	Region 2: I/O ports at 8800 [size=256]
	Region 3: Memory at d3800000 (32-bit, non-prefetchable) [size=4K]
	Region 4: Memory at d3000000 (32-bit, non-prefetchable) [size=128K]
	[virtual] Expansion ROM at 60020000 [disabled] [size=32K]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 5a 10 17 3d 17 00 30 02 02 00 80 01 01 58 00 00
10: 01 90 00 00 00 00 00 00 01 88 00 00 00 00 80 d3
20: 00 00 00 d3 00 00 00 00 00 00 00 00 5a 10 17 3d
30: 00 00 00 00 60 00 00 00 00 00 00 00 05 01 04 12
40: 00 00 05 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 01 00 22 02 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 04 ff ff 03 00 00 00 00 00 00 00 00 00

01:00.0 VGA compatible controller: nVidia Corporation NV11 [GeForce2
MX/MX 400] (rev a1) (prog-if 00 [VGA])
	Subsystem: AOPEN Inc. Unknown device 0033
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (1250ns min, 250ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at d6000000 (32-bit, non-prefetchable) [size=16M]
	Region 1: Memory at d8000000 (32-bit, prefetchable) [size=128M]
	Expansion ROM at d7ff0000 [disabled] [size=64K]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [44] AGP version 2.0
		Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA- ITACoh- GART64- HTrans- 64bit-
FW+ AGP3- Rate=x1,x2,x4
		Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=<none>
00: de 10 10 01 07 00 b0 02 a1 00 00 03 00 40 00 00
10: 00 00 00 d6 08 00 00 d8 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 a0 a0 33 00
30: 00 00 ff d7 60 00 00 00 00 00 00 00 0b 01 05 01
40: a0 a0 33 00 02 00 20 00 17 00 00 1f 00 00 00 00
50: 01 00 00 00 01 00 00 00 ce d6 23 00 0f 00 00 00
60: 01 44 02 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
