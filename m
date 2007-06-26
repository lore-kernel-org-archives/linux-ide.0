From: "Andrew Hall" <andrew.a.hall@gmail.com>
Subject: CF flash PATA on libata failure to attach
Date: Tue, 26 Jun 2007 18:51:00 +1000
Message-ID: <4680d387.24528c0a.3634.69bd@mx.google.com>
References: <11172839.post@talk.nabble.com>	<46766BD3.4040702@gmail.com> <20070618125742.28a0bc57@the-village.bc.nu> <46770edc.101d640a.4fdf.4eae@mx.google.com> <46776306.5030300@gmail.com> <4679cefc.06d7720a.0280.ffff9cce@mx.google.com> <4679EA43.4040002@gmail.com> <467a2692.17bb720a.5a14.ffffa80c@mx.google.com> <467A8F17.1080608@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.234]:20976 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751925AbXFZIvY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 26 Jun 2007 04:51:24 -0400
Received: by nz-out-0506.google.com with SMTP id n1so1636061nzf
        for <linux-ide@vger.kernel.org>; Tue, 26 Jun 2007 01:51:24 -0700 (PDT)
In-Reply-To: <467A8F17.1080608@rtr.ca>
Content-Language: en-au
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: 'Tejun Heo' <htejun@gmail.com>, 'Alan Cox' <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, 'Jeff Garzik' <jeff@garzik.org>

Hello,

I have been wrestling now for several days trying to get a Compact Flash
(IDE) card detected and mounted properly under any version of Linux 2.6.x.
using ICH8 hardware. My understanding is that this hardware uses a SATA to
PATA bridge, and so I have tried unsuccessfully to use the newer Intel ESB,
ICH, PIIX3, PIIX4 PATA/SATA drivers and the older Intel PATA old PIIX
drivers with and without the older standard ATA support compiled in.

I have spoken with the hardware manufacturer who tells me there are Intel
specific issues that "may" break support for compact flash. Is this true? I
have tried the latest 2.6.22rc6 still with no success. I include the output
from dmesg here and can provide any information that someone may need to
help me isolate and fix this issue. I am not a kernel developer and have no
idea about the structure of the ATA interface but am willing to help in
whatever way to help get this issue resolved, as our product depends on CF
working.

If someone can at least please tell me if this is supposed to work ( I refer
to comments from the hardware manufacturer and comments on the libata
development site about issues with 32bit I/O mode and CF), that would be
great.

Dmesg:

<5>Linux version 2.6.22-rc6 (root@localhost) (gcc version 4.1.1 20070105
(Red Hat 4.1.1-51)) #1 SMP Tue Jun 26 19:10:55 EST 2007
<6>BIOS-provided physical RAM map:
<4> BIOS-e820: 0000000000000000 - 000000000009f400 (usable)
<4> BIOS-e820: 000000000009f400 - 00000000000a0000 (reserved)
<4> BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
<4> BIOS-e820: 0000000000100000 - 000000007fde0000 (usable)
<4> BIOS-e820: 000000007fde0000 - 000000007fde3000 (ACPI NVS)
<4> BIOS-e820: 000000007fde3000 - 000000007fdf0000 (ACPI data)
<4> BIOS-e820: 000000007fdf0000 - 000000007fe00000 (reserved)
<4> BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
<4> BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
<5>1149MB HIGHMEM available.
<5>896MB LOWMEM available.
<6>found SMP MP-table at 000f3330
<4>NX (Execute Disable) protection: active
<7>Entering add_active_range(0, 0, 523744) 0 entries of 256 used
<4>Zone PFN ranges:
<4>  DMA             0 ->     4096
<4>  Normal       4096 ->   229376
<4>  HighMem    229376 ->   523744
<4>early_node_map[1] active PFN ranges
<4>    0:        0 ->   523744
<7>On node 0 totalpages: 523744
<7>  DMA zone: 32 pages used for memmap
<7>  DMA zone: 0 pages reserved
<7>  DMA zone: 4064 pages, LIFO batch:0
<7>  Normal zone: 1760 pages used for memmap
<7>  Normal zone: 223520 pages, LIFO batch:31
<7>  HighMem zone: 2299 pages used for memmap
<7>  HighMem zone: 292069 pages, LIFO batch:31
<6>DMI 2.3 present.
<4>ACPI: RSDP 000F6D50, 0014 (r0 IntelR)
<4>ACPI: RSDT 7FDE3040, 0030 (r1 IntelR AWRDACPI 42302E31 AWRD        0)
<4>ACPI: FACP 7FDE30C0, 0074 (r1 IntelR AWRDACPI 42302E31 AWRD        0)
<4>ACPI: DSDT 7FDE3180, 44BA (r1 INTELR AWRDACPI     1000 MSFT  3000000)
<4>ACPI: FACS 7FDE0000, 0040
<4>ACPI: MCFG 7FDE7780, 003C (r1 IntelR AWRDACPI 42302E31 AWRD        0)
<4>ACPI: APIC 7FDE7680, 0084 (r1 IntelR AWRDACPI 42302E31 AWRD        0)
<6>ACPI: PM-Timer IO Port: 0x408
<7>ACPI: Local APIC address 0xfee00000
<6>ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
<4>Processor #0 6:15 APIC version 20
<6>ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
<4>Processor #1 6:15 APIC version 20
<6>ACPI: LAPIC (acpi_id[0x02] lapic_id[0x02] disabled)
<6>ACPI: LAPIC (acpi_id[0x03] lapic_id[0x03] disabled)
<6>ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
<6>ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
<6>ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
<6>ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
<6>ACPI: IOAPIC (id[0x04] address[0xfec00000] gsi_base[0])
<4>IOAPIC[0]: apic_id 4, version 32, address 0xfec00000, GSI 0-23
<6>ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
<6>ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
<7>ACPI: IRQ0 used by override.
<7>ACPI: IRQ2 used by override.
<7>ACPI: IRQ9 used by override.
<4>Enabling APIC mode:  Flat.  Using 1 I/O APICs
<6>Using ACPI (MADT) for SMP configuration information
<4>Allocating PCI resources starting at 80000000 (gap: 7fe00000:60200000)
<4>Built 1 zonelists.  Total pages: 519653
<5>Kernel command line: root=/dev/ram0 ramdisk=65535 single
<7>mapped APIC to ffffd000 (fee00000)
<7>mapped IOAPIC to ffffc000 (fec00000)
<6>Enabling fast FPU save and restore... done.
<6>Enabling unmasked SIMD FPU exception support... done.
<6>Initializing CPU#0
<4>PID hash table entries: 4096 (order: 12, 16384 bytes)
<4>Detected 1862.098 MHz processor.
<4>Console: colour VGA+ 80x25
<4>Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
<4>Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
<6>Memory: 2060720k/2094976k available (4104k kernel code, 33012k reserved,
1729k data, 336k init, 1177472k highmem)
<4>virtual kernel memory layout:
<4>    fixmap  : 0xfff50000 - 0xfffff000   ( 700 kB)
<4>    pkmap   : 0xffc00000 - 0xffe00000   (2048 kB)
<4>    vmalloc : 0xf8800000 - 0xffbfe000   ( 115 MB)
<4>    lowmem  : 0xc0000000 - 0xf8000000   ( 896 MB)
<4>      .init : 0xc06bb000 - 0xc070f000   ( 336 kB)
<4>      .data : 0xc0502061 - 0xc06b2858   (1729 kB)
<4>      .text : 0xc0100000 - 0xc0502061   (4104 kB)
<4>Checking if this processor honours the WP bit even in supervisor mode...
Ok.
<4>Calibrating delay using timer specific routine.. 3726.92 BogoMIPS
(lpj=7453842)
<4>Mount-cache hash table entries: 512
<7>CPU: After generic identify, caps: bfebfbff 20100000 00000000 00000000
0000e3bd 00000000 00000001
<4>monitor/mwait feature present.
<4>using mwait in idle threads.
<6>CPU: L1 I cache: 32K, L1 D cache: 32K
<6>CPU: L2 cache: 4096K
<6>CPU: Physical Processor ID: 0
<6>CPU: Processor Core ID: 0
<7>CPU: After all inits, caps: bfebfbff 20100000 00000000 00003940 0000e3bd
00000000 00000001
<6>Intel machine check architecture supported.
<6>Intel machine check reporting enabled on CPU#0.
<4>Compat vDSO mapped to ffffe000.
<6>Checking 'hlt' instruction... OK.
<6>Freeing SMP alternatives: 18k freed
<6>ACPI: Core revision 20070126
<4>CPU0: Intel(R) Core(TM)2 CPU          6320  @ 1.86GHz stepping 06
<4>Booting processor 1/1 eip 2000
<6>Initializing CPU#1
<4>Calibrating delay using timer specific routine.. 3724.29 BogoMIPS
(lpj=7448583)
<7>CPU: After generic identify, caps: bfebfbff 20100000 00000000 00000000
0000e3bd 00000000 00000001
<4>monitor/mwait feature present.
<6>CPU: L1 I cache: 32K, L1 D cache: 32K
<6>CPU: L2 cache: 4096K
<6>CPU: Physical Processor ID: 0
<6>CPU: Processor Core ID: 1
<7>CPU: After all inits, caps: bfebfbff 20100000 00000000 00003940 0000e3bd
00000000 00000001
<6>Intel machine check architecture supported.
<6>Intel machine check reporting enabled on CPU#1.
<4>CPU1: Intel(R) Core(TM)2 CPU          6320  @ 1.86GHz stepping 06
<6>Total of 2 processors activated (7451.21 BogoMIPS).
<4>ENABLING IO-APIC IRQs
<6>..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
<6>checking TSC synchronization [CPU#0 -> CPU#1]: passed.
<6>Brought up 2 CPUs
<4>migration_cost=74
<6>NET: Registered protocol family 16
<6>ACPI: bus type pci registered
<6>PCI: Using configuration type 1
<4>Setting up standard PCI resources
<6>ACPI: Interpreter enabled
<6>ACPI: Using IOAPIC for interrupt routing
<6>ACPI: PCI Root Bridge [PCI0] (0000:00)
<7>PCI: Probing PCI hardware (bus 00)
<4>PCI quirk: region 0400-047f claimed by ICH6 ACPI/GPIO/TCO
<4>PCI quirk: region 0480-04bf claimed by ICH6 GPIO
<4>PCI: PXH quirk detected, disabling MSI for SHPC device
<4>PCI: PXH quirk detected, disabling MSI for SHPC device
<6>PCI: Transparent bridge - 0000:00:1e.0
<7>ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
<7>ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEX0._PRT]
<7>ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEX1._PRT]
<7>ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEX2._PRT]
<7>ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEX3._PRT]
<7>ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEX4._PRT]
<7>ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEX5._PRT]
<7>ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB0._PRT]
<4>ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 11 12 *14 15)
<4>ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
<4>ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
<4>ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 10 11 12 14 *15)
<4>ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0,
disabled.
<4>ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0,
disabled.
<4>ACPI: PCI Interrupt Link [LNK0] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0,
disabled.
<4>ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
<6>Linux Plug and Play Support v0.97 (c) Adam Belay
<6>pnp: PnP ACPI init
<6>ACPI: bus type pnp registered
<6>pnp: PnP ACPI: found 13 devices
<6>ACPI: ACPI bus type pnp unregistered
<5>SCSI subsystem initialized
<7>libata version 2.21 loaded.
<6>usbcore: registered new interface driver usbfs
<6>usbcore: registered new interface driver hub
<6>usbcore: registered new device driver usb
<6>PCI: Using ACPI for IRQ routing
<6>PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a
report
<6>pnp: 00:09: ioport range 0x400-0x4bf could not be reserved
<6>pnp: 00:0b: iomem range 0xe0000000-0xefffffff could not be reserved
<6>pnp: 00:0c: iomem range 0xf0000-0xfffff could not be reserved
<6>pnp: 00:0c: iomem range 0x7fe00000-0x7fefffff has been reserved
<6>pnp: 00:0c: iomem range 0x7fde0000-0x7fdfffff could not be reserved
<6>pnp: 00:0c: iomem range 0x0-0x9ffff could not be reserved
<6>Time: tsc clocksource has been installed.
<6>PCI: Bridge: 0000:01:00.0
<6>  IO window: 7000-7fff
<6>  MEM window: fd200000-fd2fffff
<6>  PREFETCH window: fce00000-fcefffff
<6>PCI: Bridge: 0000:01:00.2
<6>  IO window: 6000-6fff
<6>  MEM window: fd100000-fd1fffff
<6>  PREFETCH window: fcd00000-fcdfffff
<6>PCI: Bridge: 0000:00:01.0
<6>  IO window: 6000-7fff
<6>  MEM window: fd100000-fd2fffff
<6>  PREFETCH window: fcd00000-fcefffff
<6>PCI: Bridge: 0000:00:1c.0
<6>  IO window: 5000-5fff
<6>  MEM window: fde00000-fdefffff
<6>  PREFETCH window: fdd00000-fddfffff
<6>PCI: Bridge: 0000:00:1c.1
<6>  IO window: d000-dfff
<6>  MEM window: fdc00000-fdcfffff
<6>  PREFETCH window: fdb00000-fdbfffff
<6>PCI: Bridge: 0000:00:1c.2
<6>  IO window: c000-cfff
<6>  MEM window: fda00000-fdafffff
<6>  PREFETCH window: fd900000-fd9fffff
<6>PCI: Bridge: 0000:00:1c.3
<6>  IO window: a000-afff
<6>  MEM window: fd800000-fd8fffff
<6>  PREFETCH window: fd700000-fd7fffff
<6>PCI: Bridge: 0000:00:1c.4
<6>  IO window: 9000-9fff
<6>  MEM window: fd600000-fd6fffff
<6>  PREFETCH window: fd500000-fd5fffff
<6>PCI: Bridge: 0000:00:1c.5
<6>  IO window: 8000-8fff
<6>  MEM window: fd400000-fd4fffff
<6>  PREFETCH window: fd300000-fd3fffff
<6>PCI: Bridge: 0000:00:1e.0
<6>  IO window: b000-bfff
<6>  MEM window: fd000000-fd0fffff
<6>  PREFETCH window: fcf00000-fcffffff
<6>ACPI: PCI Interrupt 0000:00:01.0[A] -> GSI 16 (level, low) -> IRQ 16
<7>PCI: Setting latency timer of device 0000:00:01.0 to 64
<7>PCI: Setting latency timer of device 0000:01:00.0 to 64
<7>PCI: Setting latency timer of device 0000:01:00.2 to 64
<6>ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 16 (level, low) -> IRQ 16
<7>PCI: Setting latency timer of device 0000:00:1c.0 to 64
<6>ACPI: PCI Interrupt 0000:00:1c.1[B] -> GSI 17 (level, low) -> IRQ 17
<7>PCI: Setting latency timer of device 0000:00:1c.1 to 64
<6>ACPI: PCI Interrupt 0000:00:1c.2[C] -> GSI 18 (level, low) -> IRQ 18
<7>PCI: Setting latency timer of device 0000:00:1c.2 to 64
<6>ACPI: PCI Interrupt 0000:00:1c.3[D] -> GSI 19 (level, low) -> IRQ 19
<7>PCI: Setting latency timer of device 0000:00:1c.3 to 64
<6>ACPI: PCI Interrupt 0000:00:1c.4[A] -> GSI 16 (level, low) -> IRQ 16
<7>PCI: Setting latency timer of device 0000:00:1c.4 to 64
<6>ACPI: PCI Interrupt 0000:00:1c.5[B] -> GSI 17 (level, low) -> IRQ 17
<7>PCI: Setting latency timer of device 0000:00:1c.5 to 64
<7>PCI: Setting latency timer of device 0000:00:1e.0 to 64
<6>NET: Registered protocol family 2
<4>IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
<4>TCP established hash table entries: 131072 (order: 8, 1572864 bytes)
<4>TCP bind hash table entries: 65536 (order: 7, 524288 bytes)
<6>TCP: Hash tables configured (established 131072 bind 65536)
<6>TCP reno registered
<6>checking if image is initramfs...<6>Switched to high resolution mode on
CPU 1
<6>Switched to high resolution mode on CPU 0
<4>it isn't (no cpio magic); looks like an initrd
<6>Freeing initrd memory: 9197k freed
<6>Machine check exception polling timer started.
<4>highmem bounce pool size: 64 pages
<6>SGI XFS with no debug enabled
<6>io scheduler noop registered
<6>io scheduler anticipatory registered (default)
<6>io scheduler deadline registered
<6>io scheduler cfq registered
<7>Boot video device is 0000:00:02.0
<7>PCI: Setting latency timer of device 0000:00:01.0 to 64
<4>assign_interrupt_mode Found MSI capability
<7>Allocate Port Service[0000:00:01.0:pcie00]
<7>PCI: Setting latency timer of device 0000:00:1c.0 to 64
<4>assign_interrupt_mode Found MSI capability
<7>Allocate Port Service[0000:00:1c.0:pcie00]
<7>Allocate Port Service[0000:00:1c.0:pcie02]
<7>PCI: Setting latency timer of device 0000:00:1c.1 to 64
<4>assign_interrupt_mode Found MSI capability
<7>Allocate Port Service[0000:00:1c.1:pcie00]
<7>Allocate Port Service[0000:00:1c.1:pcie02]
<7>PCI: Setting latency timer of device 0000:00:1c.2 to 64
<4>assign_interrupt_mode Found MSI capability
<7>Allocate Port Service[0000:00:1c.2:pcie00]
<7>Allocate Port Service[0000:00:1c.2:pcie02]
<7>PCI: Setting latency timer of device 0000:00:1c.3 to 64
<4>assign_interrupt_mode Found MSI capability
<7>Allocate Port Service[0000:00:1c.3:pcie00]
<7>Allocate Port Service[0000:00:1c.3:pcie02]
<7>PCI: Setting latency timer of device 0000:00:1c.4 to 64
<4>assign_interrupt_mode Found MSI capability
<7>Allocate Port Service[0000:00:1c.4:pcie00]
<7>Allocate Port Service[0000:00:1c.4:pcie02]
<7>PCI: Setting latency timer of device 0000:00:1c.5 to 64
<4>assign_interrupt_mode Found MSI capability
<7>Allocate Port Service[0000:00:1c.5:pcie00]
<7>Allocate Port Service[0000:00:1c.5:pcie02]
<6>input: Power Button (FF) as /class/input/input0
<6>ACPI: Power Button (FF) [PWRF]
<6>input: Power Button (CM) as /class/input/input1
<6>ACPI: Power Button (CM) [PWRB]
<6>ACPI: Thermal Zone [THRM] (40 C)
<6>Real Time Clock Driver v1.12ac
<6>Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
<6>00:06: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
<6>00:07: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
<6>Floppy drive(s): fd0 is unknown type 13 (usb?), fd1 is unknown type 15
(usb?)
<4>floppy0: no floppy controllers found
<4>RAMDISK driver initialized: 16 RAM disks of 65535K size 1024 blocksize
<6>loop: module loaded
<4>Compaq SMART2 Driver (v 2.6.0)
<6>HP CISS Driver (v 3.6.14)
<6>Intel(R) PRO/1000 Network Driver - version 7.3.20-k2-NAPI
<6>Copyright (c) 1999-2006 Intel Corporation.
<6>ACPI: PCI Interrupt 0000:04:00.0[A] -> GSI 16 (level, low) -> IRQ 16
<7>PCI: Setting latency timer of device 0000:04:00.0 to 64
<6>e1000: 0000:04:00.0: e1000_probe: (PCI Express:2.5Gb/s:Width x1)
00:10:f3:10:53:e8
<6>e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
<6>ACPI: PCI Interrupt 0000:05:00.0[A] -> GSI 17 (level, low) -> IRQ 17
<7>PCI: Setting latency timer of device 0000:05:00.0 to 64
<6>e1000: 0000:05:00.0: e1000_probe: (PCI Express:2.5Gb/s:Width x1)
00:10:f3:10:53:e9
<6>e1000: eth1: e1000_probe: Intel(R) PRO/1000 Network Connection
<6>ACPI: PCI Interrupt 0000:06:00.0[A] -> GSI 18 (level, low) -> IRQ 18
<7>PCI: Setting latency timer of device 0000:06:00.0 to 64
<6>e1000: 0000:06:00.0: e1000_probe: (PCI Express:2.5Gb/s:Width x1)
00:10:f3:10:53:ea
<6>e1000: eth2: e1000_probe: Intel(R) PRO/1000 Network Connection
<6>ACPI: PCI Interrupt 0000:07:00.0[A] -> GSI 19 (level, low) -> IRQ 19
<7>PCI: Setting latency timer of device 0000:07:00.0 to 64
<6>e1000: 0000:07:00.0: e1000_probe: (PCI Express:2.5Gb/s:Width x1)
00:10:f3:10:53:eb
<6>e1000: eth3: e1000_probe: Intel(R) PRO/1000 Network Connection
<6>ACPI: PCI Interrupt 0000:08:00.0[A] -> GSI 16 (level, low) -> IRQ 16
<7>PCI: Setting latency timer of device 0000:08:00.0 to 64
<6>e1000: 0000:08:00.0: e1000_probe: (PCI Express:2.5Gb/s:Width x1)
00:10:f3:10:53:ec
<6>e1000: eth4: e1000_probe: Intel(R) PRO/1000 Network Connection
<6>ACPI: PCI Interrupt 0000:09:00.0[A] -> GSI 17 (level, low) -> IRQ 17
<7>PCI: Setting latency timer of device 0000:09:00.0 to 64
<6>e1000: 0000:09:00.0: e1000_probe: (PCI Express:2.5Gb/s:Width x1)
00:10:f3:10:53:ed
<6>e1000: eth5: e1000_probe: Intel(R) PRO/1000 Network Connection
<6>ACPI: PCI Interrupt 0000:0a:0e.0[A] -> GSI 18 (level, low) -> IRQ 18
<6>e1000: 0000:0a:0e.0: e1000_probe: (PCI:33MHz:32-bit) 00:10:f3:10:53:ee
<6>e1000: eth6: e1000_probe: Intel(R) PRO/1000 Network Connection
<6>ACPI: PCI Interrupt 0000:0a:0f.0[A] -> GSI 17 (level, low) -> IRQ 17
<6>e1000: 0000:0a:0f.0: e1000_probe: (PCI:33MHz:32-bit) 00:10:f3:10:53:ef
<6>e1000: eth7: e1000_probe: Intel(R) PRO/1000 Network Connection
<6>pcnet32.c:v1.33 27.Jun.2006 tsbogend@alpha.franken.de
<6>e100: Intel(R) PRO/100 Network Driver, 3.5.17-k4-NAPI
<6>e100: Copyright(c) 1999-2006 Intel Corporation
<6>ns83820.c: National Semiconductor DP83820 10/100/1000 driver.
<6>PPP generic driver version 2.4.2
<6>PPP Deflate Compression module registered
<6>PPP BSD Compression module registered
<6>PPP MPPE Compression module registered
<6>NET: Registered protocol family 24
<6>tun: Universal TUN/TAP device driver, 1.6
<6>tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
<4>Loading Adaptec I2O RAID: Version 2.4 Build 5go
<6>Detecting Adaptec I2O RAID controllers...
<6>Adaptec aacraid driver (1.1-5[2437]-mh4)
<5>aic94xx: Adaptec aic94xx SAS/SATA driver version 1.0.3 loaded
<4>scsi: <fdomain> Detection failed (no card)
<6>DC390: clustering now enabled by default. If you get problems load
<4>	with "disable_clustering=1" and report to maintainers
<6>megaraid cmm: 2.20.2.7 (Release Date: Sun Jul 16 00:01:03 EST 2006)
<6>megaraid: 2.20.5.1 (Release Date: Thu Nov 16 15:32:35 EST 2006)
<6>megasas: 00.00.03.10-rc5 Thu May 17 10:09:32 PDT 2007
<4>GDT-HA: Storage RAID Controller Driver. Version: 3.05
<4>GDT-HA: Found 0 PCI Storage RAID Controllers
<4>3ware Storage Controller device driver for Linux v1.26.02.002.
<4>3ware 9000 Storage Controller device driver for Linux v2.26.02.008.
<6>nsp32: loading...
<7>ata_piix 0000:00:1f.2: version 2.11
<6>ata_piix 0000:00:1f.2: MAP [ P0 P2 P1 P3 ]
<6>ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 19 (level, low) -> IRQ 19
<7>PCI: Setting latency timer of device 0000:00:1f.2 to 64
<6>scsi0 : ata_piix
<6>scsi1 : ata_piix
<6>ata1: SATA max UDMA/133 cmd 0x0001fa00 ctl 0x0001f902 bmdma 0x0001f600
irq 0
<6>ata2: SATA max UDMA/133 cmd 0x0001f800 ctl 0x0001f702 bmdma 0x0001f608
irq 0
<6>ata1.00: ATA-0: CF CARD 512MB, 20070131, max MWDMA2
<6>ata1.00: 990864 sectors, multi 0: LBA 
<6>ata1.00: applying bridge limits
<6>ata1.00: configured for MWDMA2
<4>ATA: abnormal status 0x7F on port 0x0001f807
<5>scsi 0:0:0:0: Direct-Access     ATA      CF CARD 512MB    2007 PQ: 0
ANSI: 5
<5>sd 0:0:0:0: [sda] 990864 512-byte hardware sectors (507 MB)
<5>sd 0:0:0:0: [sda] Write Protect is off
<7>sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
<5>sd 0:0:0:0: [sda] Write cache: disabled, read cache: enabled, doesn't
support DPO or FUA
<5>sd 0:0:0:0: [sda] 990864 512-byte hardware sectors (507 MB)
<5>sd 0:0:0:0: [sda] Write Protect is off
<7>sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
<5>sd 0:0:0:0: [sda] Write cache: disabled, read cache: enabled, doesn't
support DPO or FUA
<6> sda:<3>ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
<3>ata1.00: cmd c8/00:08:00:00:00/00:00:00:00:00/e0 tag 0 cdb 0x0 data 4096
in
<4>         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
<4>ata1: port is slow to respond, please be patient (Status 0xd0)
<4>ata1: device not ready (errno=-16), forcing hardreset
<3>ata1: BUG: prereset() requested invalid reset type
<6>ata1: soft resetting port
<4>ata1.00: failed to IDENTIFY (INIT_DEV_PARAMS failed, err_mask=0x80)
<3>ata1.00: revalidation failed (errno=-5)
<4>ata1: failed to recover some devices, retrying in 5 secs
<6>ata1: soft resetting port
<4>ata1.00: failed to IDENTIFY (INIT_DEV_PARAMS failed, err_mask=0x80)
<3>ata1.00: revalidation failed (errno=-5)
<4>ata1.00: limiting speed to MWDMA2:PIO3
<4>ata1: failed to recover some devices, retrying in 5 secs
<6>ata1: soft resetting port
<4>ata1.00: failed to IDENTIFY (INIT_DEV_PARAMS failed, err_mask=0x80)
<3>ata1.00: revalidation failed (errno=-5)
<4>ata1.00: disabled
<6>ata1: EH complete
<6>sd 0:0:0:0: [sda] Result: hostbyte=0x04 driverbyte=0x00
<4>end_request: I/O error, dev sda, sector 0
<3>Buffer I/O error on device sda, logical block 0
<6>sd 0:0:0:0: [sda] Result: hostbyte=0x04 driverbyte=0x00
<4>end_request: I/O error, dev sda, sector 0
<3>Buffer I/O error on device sda, logical block 0
<4> unable to read partition table
<5>sd 0:0:0:0: [sda] Attached SCSI disk
<5>sd 0:0:0:0: Attached scsi generic sg0 type 0
<6>ata_piix 0000:00:1f.5: MAP [ P0 P2 P1 P3 ]
<6>ACPI: PCI Interrupt 0000:00:1f.5[B] -> GSI 19 (level, low) -> IRQ 19
<7>PCI: Setting latency timer of device 0000:00:1f.5 to 64
<6>scsi2 : ata_piix
<6>scsi3 : ata_piix
<6>ata3: SATA max UDMA/133 cmd 0x0001f300 ctl 0x0001f202 bmdma 0x0001ef00
irq 0
<6>ata4: SATA max UDMA/133 cmd 0x0001f100 ctl 0x0001f002 bmdma 0x0001ef08
irq 0
<4>ATA: abnormal status 0x7F on port 0x0001f307
<4>ATA: abnormal status 0x7F on port 0x0001f107

