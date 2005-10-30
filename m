From: Stefan <gentoopower@yahoo.de>
Subject: Re: Serious IDE problem still present in 2.6.14
Date: Mon, 31 Oct 2005 00:02:52 +0100
Message-ID: <4365511C.7040903@yahoo.de>
References: <Pine.LNX.4.44.0510301030120.26176-100000@coffee.psychology.mcmaster.ca> <1130689871.6348.3.camel@montroll.chem.mcgill.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp018.mail.yahoo.com ([216.136.174.115]:31859 "HELO
	smtp018.mail.yahoo.com") by vger.kernel.org with SMTP
	id S932387AbVJ3XC5 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 30 Oct 2005 18:02:57 -0500
In-Reply-To: <1130689871.6348.3.camel@montroll.chem.mcgill.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David.Ronis@mcgill.ca
Cc: Mark Hahn <hahn@physics.mcmaster.ca>, linux-ide@vger.kernel.org

David Ronis wrote:


Hi David, I just checked the diffs of ide and atiixp from 2.6.12.6 to
2.6.14, I don't think those changes caused the problem.

Can you provide some more info?

I would like to see if there are differences in lspci -v output of your
old and your new kernel.
Also could you check if it makes any difference if you switch down to
udma4 udma2 and then test speeds?

>Hi Mark,
>
>I've copied the information you wanted below.
>
>First in 2.6.12.6:
>
>cat /proc/interrupts
>           CPU0       CPU1       
>  0:      53375          1    IO-APIC-edge  timer
>  1:         47          2    IO-APIC-edge  i8042
>  5:          1          0   IO-APIC-level  ATI IXP
>  8:          1          0    IO-APIC-edge  rtc
> 12:        127          0    IO-APIC-edge  i8042
> 14:       4970          0    IO-APIC-edge  ide0
> 15:          0          0    IO-APIC-edge  ide1
> 16:         28          0   IO-APIC-level  ohci_hcd:usb4, yenta,
>ohci1394
> 17:          1          0   IO-APIC-level  yenta
> 18:          0          0   IO-APIC-level  ohci_hcd:usb5
> 19:          2          0   IO-APIC-level  eth0, ehci_hcd:usb1,
>ohci_hcd:usb2, ohci_hcd:usb3
> 21:         43          0   IO-APIC-level  acpi
>NMI:          0          0 
>LOC:      53271      53277 
>ERR:          0
>MIS:          0
>
>lspci -v
>00:00.0 Host bridge: ATI Technologies Inc Radeon 9100 IGP Host Bridge
>(rev 02)
>	Subsystem: ATI Technologies Inc: Unknown device 1234
>	Flags: bus master, 66Mhz, medium devsel, latency 64
>	Memory at d2000000 (32-bit, prefetchable) [size=32M]
>	Memory at d0000000 (32-bit, non-prefetchable) [size=4K]
>	Capabilities: [a0] AGP version 3.0
>
>00:01.0 PCI bridge: ATI Technologies Inc Radeon 9100 IGP AGP Bridge
>(prog-if 00 [Normal decode])
>	Flags: bus master, 66Mhz, medium devsel, latency 99
>	Bus: primary=00, secondary=01, subordinate=01, sec-latency=68
>	I/O behind bridge: 00009000-00009fff
>	Memory behind bridge: d0100000-d01fffff
>	Prefetchable memory behind bridge: e0000000-efffffff
>
>00:13.0 USB Controller: ATI Technologies Inc OHCI USB Controller #1 (rev
>01) (prog-if 10 [OHCI])
>	Subsystem: ATI Technologies Inc: Unknown device 434c
>	Flags: bus master, 66Mhz, medium devsel, latency 64, IRQ 19
>	Memory at d0001000 (32-bit, non-prefetchable) [size=4K]
>
>00:13.1 USB Controller: ATI Technologies Inc OHCI USB Controller #2 (rev
>01) (prog-if 10 [OHCI])
>	Subsystem: ATI Technologies Inc: Unknown device 434c
>	Flags: bus master, 66Mhz, medium devsel, latency 64, IRQ 19
>	Memory at d0002000 (32-bit, non-prefetchable) [size=4K]
>
>00:14.0 SMBus: ATI Technologies Inc ATI SMBus (rev 16)
>	Subsystem: Hewlett-Packard Company: Unknown device 006b
>	Flags: 66Mhz, medium devsel
>	I/O ports at 8040 [size=16]
>	Memory at 58000000 (32-bit, non-prefetchable) [size=1K]
>
>00:14.1 IDE interface: ATI Technologies Inc ATI Dual Channel Bus Master
>PCI IDE Controller (prog-if 8a [Master SecP PriP])
>	Subsystem: ATI Technologies Inc ATI Dual Channel Bus Master PCI IDE
>Controller
>	Flags: bus master, medium devsel, latency 64, IRQ 16
>	I/O ports at <ignored>
>	I/O ports at <ignored>
>	I/O ports at <ignored>
>	I/O ports at <ignored>
>	I/O ports at 8060 [size=16]
>
>00:14.3 ISA bridge: ATI Technologies Inc: Unknown device 434c
>	Subsystem: ATI Technologies Inc: Unknown device 434c
>	Flags: bus master, 66Mhz, medium devsel, latency 0
>
>00:14.4 PCI bridge: ATI Technologies Inc: Unknown device 4342 (prog-if
>01 [Subtractive decode])
>	Flags: bus master, 66Mhz, medium devsel, latency 64
>	Bus: primary=00, secondary=02, subordinate=04, sec-latency=69
>	I/O behind bridge: 0000a000-0000afff
>	Memory behind bridge: d0200000-d02fffff
>
>00:14.5 Multimedia audio controller: ATI Technologies Inc IXP150 AC'97
>Audio Controller
>	Subsystem: Hewlett-Packard Company: Unknown device 006b
>	Flags: bus master, 66Mhz, slow devsel, latency 64, IRQ 5
>	Memory at d0003000 (32-bit, non-prefetchable) [size=256]
>
>00:14.6 Modem: ATI Technologies Inc IXP AC'97 Modem (rev 01) (prog-if 00
>[Generic])
>	Subsystem: Hewlett-Packard Company: Unknown device 006b
>	Flags: 66Mhz, slow devsel, IRQ 5
>	Memory at d0003400 (32-bit, non-prefetchable) [size=256]
>
>01:05.0 VGA compatible controller: ATI Technologies Inc RS300M AGP
>[Radeon Mobility 9100IGP] (prog-if 00 [VGA])
>	Subsystem: Hewlett-Packard Company: Unknown device 006b
>	Flags: bus master, fast Back2Back, 66Mhz, medium devsel, latency 66,
>IRQ 10
>	Memory at e0000000 (32-bit, prefetchable) [size=256M]
>	I/O ports at 9000 [size=256]
>	Memory at d0100000 (32-bit, non-prefetchable) [size=64K]
>	Expansion ROM at <unassigned> [disabled] [size=128K]
>	Capabilities: [58] AGP version 3.0
>	Capabilities: [50] Power Management version 2
>
>02:00.0 FireWire (IEEE 1394): Texas Instruments TSB43AB21
>IEEE-1394a-2000 Controller (PHY/Link) (prog-if 10 [OHCI])
>	Subsystem: Hewlett-Packard Company: Unknown device 006b
>	Flags: bus master, medium devsel, latency 64, IRQ 16
>	Memory at d0208000 (32-bit, non-prefetchable) [size=2K]
>	Memory at d0200000 (32-bit, non-prefetchable) [size=16K]
>	Capabilities: [44] Power Management version 2
>
>02:02.0 Network controller: Broadcom Corporation BCM4306 802.11b/g
>Wireless LAN Controller (rev 03)
>	Subsystem: Hewlett-Packard Company: Unknown device 12f4
>	Flags: bus master, fast devsel, latency 64, IRQ 5
>	Memory at d0204000 (32-bit, non-prefetchable) [size=8K]
>
>02:03.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
>RTL-8139/8139C/8139C+ (rev 10)
>	Subsystem: Hewlett-Packard Company: Unknown device 006b
>	Flags: bus master, medium devsel, latency 128, IRQ 19
>	I/O ports at a000 [size=256]
>	Memory at d0208800 (32-bit, non-prefetchable) [size=256]
>	Capabilities: [50] Power Management version 2
>
>02:04.0 CardBus bridge: Texas Instruments PCI1620 PC Card Controller
>(rev 01)
>	Subsystem: Hewlett-Packard Company: Unknown device 006b
>	Flags: bus master, medium devsel, latency 168, IRQ 17
>	Memory at 58001000 (32-bit, non-prefetchable) [size=4K]
>	Bus: primary=02, secondary=03, subordinate=06, sec-latency=176
>	Memory window 0: 58400000-587ff000 (prefetchable)
>	Memory window 1: 58800000-58bff000
>	I/O window 0: 00004000-000040ff
>	I/O window 1: 00004400-000044ff
>	16-bit legacy interface ports at 0001
>
>02:04.1 CardBus bridge: Texas Instruments PCI1620 PC Card Controller
>(rev 01)
>	Subsystem: Hewlett-Packard Company: Unknown device 006b
>	Flags: bus master, medium devsel, latency 168, IRQ 16
>	Memory at 58002000 (32-bit, non-prefetchable) [size=4K]
>	Bus: primary=02, secondary=07, subordinate=0a, sec-latency=176
>	Memory window 0: 58c00000-58fff000 (prefetchable)
>	Memory window 1: 59000000-593ff000
>	I/O window 0: 00004800-000048ff
>	I/O window 1: 00004c00-00004cff
>	16-bit legacy interface ports at 0001
>
>02:04.2 System peripheral: Texas Instruments PCI1620 Firmware Loading
>Function (rev 01)
>	Subsystem: Hewlett-Packard Company: Unknown device 006b
>	Flags: bus master, medium devsel, latency 64
>	I/O ports at a400 [size=64]
>	Capabilities: [44] Power Management version 2
>
>02:07.0 USB Controller: NEC Corporation USB (rev 43) (prog-if 10 [OHCI])
>	Subsystem: NEC Corporation USB
>	Flags: bus master, medium devsel, latency 64, IRQ 16
>	Memory at d0206000 (32-bit, non-prefetchable) [size=4K]
>	Capabilities: [40] Power Management version 2
>
>02:07.1 USB Controller: NEC Corporation USB (rev 43) (prog-if 10 [OHCI])
>	Subsystem: NEC Corporation USB
>	Flags: bus master, medium devsel, latency 64, IRQ 18
>	Memory at d0207000 (32-bit, non-prefetchable) [size=4K]
>	Capabilities: [40] Power Management version 2
>
>02:07.2 USB Controller: NEC Corporation USB 2.0 (rev 04) (prog-if 20
>[EHCI])
>	Subsystem: NEC Corporation USB 2.0
>	Flags: bus master, medium devsel, latency 64, IRQ 19
>	Memory at d0208c00 (32-bit, non-prefetchable) [size=256]
>	Capabilities: [40] Power Management version 2
>
>
>dmesg
>Linux version 2.6.12.6 (root@montroll.lan) (gcc version 3.4.4) #4 SMP
>Tue Aug 30 20:38:22 EDT 2005
>BIOS-provided physical RAM map:
> BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
> BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
> BIOS-e820: 00000000000d0000 - 00000000000d8000 (reserved)
> BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
> BIOS-e820: 0000000000100000 - 0000000047f70000 (usable)
> BIOS-e820: 0000000047f70000 - 0000000047f7d000 (ACPI data)
> BIOS-e820: 0000000047f7d000 - 0000000047f80000 (ACPI NVS)
> BIOS-e820: 0000000047f80000 - 0000000048000000 (reserved)
> BIOS-e820: 0000000057f80000 - 0000000058000000 (reserved)
> BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
> BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
> BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
>Warning only 896MB will be used.
>Use a HIGHMEM enabled kernel.
>896MB LOWMEM available.
>found SMP MP-table at 000f6570
>On node 0 totalpages: 229376
>  DMA zone: 4096 pages, LIFO batch:1
>  Normal zone: 225280 pages, LIFO batch:31
>  HighMem zone: 0 pages, LIFO batch:1
>DMI present.
>ACPI: RSDP (v000 PTLTD                                 ) @ 0x000f6600
>ACPI: RSDT (v001 PTLTD    RSDT   0x06040000  LTP 0x00000000) @
>0x47f791c8
>ACPI: FADT (v001 HP     Chinook  0x06040000 ATI  0x000f4240) @
>0x47f7ceed
>ACPI: MADT (v001 PTLTD  	 APIC   0x06040000  LTP 0x00000000) @
>0x47f7cf61
>ACPI: SSDT (v001 PTLTD  ACPIHT   0x06040000  LTP 0x00000001) @
>0x47f7cfc9
>ACPI: DSDT (v001     HP    SB200 0x06040000 INTL 0x20030509) @
>0x00000000
>ACPI: PM-Timer IO Port: 0x8008
>ACPI: Local APIC address 0xfee00000
>ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
>Processor #0 15:2 APIC version 20
>ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
>Processor #1 15:2 APIC version 20
>ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
>ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
>ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
>IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, GSI 0-23
>ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 high edge)
>ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 21 low level)
>ACPI: IRQ0 used by override.
>ACPI: IRQ2 used by override.
>Enabling APIC mode:  Flat.  Using 1 I/O APICs
>Using ACPI (MADT) for SMP configuration information
>Allocating PCI resources starting at 58000000 (gap: 58000000:a6c00000)
>Built 1 zonelists
>Kernel command line: BOOT_IMAGE=2.6.12.6 ro root=302
>mapped APIC to ffffd000 (fee00000)
>mapped IOAPIC to ffffc000 (fec00000)
>Initializing CPU#0
>PID hash table entries: 4096 (order: 12, 65536 bytes)
>Detected 3000.728 MHz processor.
>Using pmtmr for high-res timesource
>Console: colour VGA+ 80x25
>Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
>Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
>Memory: 906084k/917504k available (1695k kernel code, 10908k reserved,
>737k data, 192k init, 0k highmem)
>Checking if this processor honours the WP bit even in supervisor mode...
>Ok.
>Calibrating delay loop... 5963.77 BogoMIPS (lpj=2981888)
>Mount-cache hash table entries: 512
>CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000
>00004400 00000000 00000000
>CPU: After vendor identify, caps: bfebfbff 00000000 00000000 00000000
>00004400 00000000 00000000
>CPU: Trace cache: 12K uops, L1 D cache: 8K
>CPU: L2 cache: 512K
>CPU: Physical Processor ID: 0
>CPU: After all inits, caps: bfebfbff 00000000 00000000 00000080 00004400
>00000000 00000000
>Intel machine check architecture supported.
>Intel machine check reporting enabled on CPU#0.
>CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
>CPU0: Thermal monitoring enabled
>Enabling fast FPU save and restore... done.
>Enabling unmasked SIMD FPU exception support... done.
>Checking 'hlt' instruction... OK.
>CPU0: Intel(R) Pentium(R) 4 CPU 3.00GHz stepping 09
>Booting processor 1/1 eip 3000
>Initializing CPU#1
>Calibrating delay loop... 5996.54 BogoMIPS (lpj=2998272)
>CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000
>00004400 00000000 00000000
>CPU: After vendor identify, caps: bfebfbff 00000000 00000000 00000000
>00004400 00000000 00000000
>CPU: Trace cache: 12K uops, L1 D cache: 8K
>CPU: L2 cache: 512K
>CPU: Physical Processor ID: 0
>CPU: After all inits, caps: bfebfbff 00000000 00000000 00000080 00004400
>00000000 00000000
>Intel machine check architecture supported.
>Intel machine check reporting enabled on CPU#1.
>CPU1: Intel P4/Xeon Extended MCE MSRs (12) available
>CPU1: Thermal monitoring enabled
>CPU1: Intel(R) Pentium(R) 4 CPU 3.00GHz stepping 09
>Total of 2 processors activated (11960.32 BogoMIPS).
>ENABLING IO-APIC IRQs
>..TIMER: vector=0x31 pin1=2 pin2=-1
>checking TSC synchronization across 2 CPUs: passed.
>Brought up 2 CPUs
>CPU0 attaching sched-domain:
> domain 0: span 3
>  groups: 1 2
>  domain 1: span 3
>   groups: 3
>CPU1 attaching sched-domain:
> domain 0: span 3
>  groups: 2 1
>  domain 1: span 3
>   groups: 3
>NET: Registered protocol family 16
>PCI: PCI BIOS revision 2.10 entry at 0xfd968, last bus=2
>PCI: Using configuration type 1
>mtrr: v2.0 (20020519)
>ACPI: Subsystem revision 20050309
>ACPI: Interpreter enabled
>ACPI: Using IOAPIC for interrupt routing
>ACPI: PCI Root Bridge [PCI0] (0000:00)
>PCI: Probing PCI hardware (bus 00)
>PCI: Ignoring BAR0-3 of IDE controller 0000:00:14.1
>Boot video device is 0000:01:05.0
>PCI: Transparent bridge - 0000:00:14.4
>ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
>ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGPB._PRT]
>ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P2P_._PRT]
>ACPI: PCI Interrupt Link [LNK0] (IRQs 5 10 11) *0, disabled.
>ACPI: PCI Interrupt Link [LNK1] (IRQs 5 10 11) *0, disabled.
>ACPI: PCI Interrupt Link [LNK2] (IRQs 5 10 11) *0, disabled.
>ACPI: PCI Interrupt Link [LNK3] (IRQs 5 10 11) *0, disabled.
>ACPI: Embedded Controller [EC0] (gpe 6)
>PCI: Using ACPI for IRQ routing
>PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a
>report
>Machine check exception polling timer started.
>Initializing Cryptographic API
>ACPI: AC Adapter [ACAD] (on-line)
>ACPI: Battery Slot [BAT1] (battery present)
>ACPI: Power Button (FF) [PWRF]
>ACPI: Lid Switch [LID]
>ACPI: Thermal Zone [THRM] (52 C)
>Real Time Clock Driver v1.12
>i8042.c: Detected active multiplexing controller, rev 1.1.
>serio: i8042 AUX0 port at 0x60,0x64 irq 12
>serio: i8042 AUX1 port at 0x60,0x64 irq 12
>serio: i8042 AUX2 port at 0x60,0x64 irq 12
>serio: i8042 AUX3 port at 0x60,0x64 irq 12
>serio: i8042 KBD port at 0x60,0x64 irq 1
>io scheduler noop registered
>io scheduler anticipatory registered
>io scheduler deadline registered
>io scheduler cfq registered
>Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
>ide: Assuming 33MHz system bus speed for PIO modes; override with
>idebus=xx
>ATIIXP: IDE controller at PCI slot 0000:00:14.1
>ACPI: PCI Interrupt 0000:00:14.1[A] -> GSI 16 (level, low) -> IRQ 16
>ATIIXP: chipset revision 0
>ATIIXP: not 100% native mode: will probe irqs later
>    ide0: BM-DMA at 0x8060-0x8067, BIOS settings: hda:DMA, hdb:pio
>    ide1: BM-DMA at 0x8068-0x806f, BIOS settings: hdc:DMA, hdd:pio
>Probing IDE interface ide0...
>hda: ST9100823A, ATA DISK drive
>ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
>Probing IDE interface ide1...
>hdc: SD-R2512, ATAPI CD/DVD-ROM drive
>ide1 at 0x170-0x177,0x376 on irq 15
>Probing IDE interface ide2...
>Probing IDE interface ide3...
>Probing IDE interface ide4...
>Probing IDE interface ide5...
>hda: max request size: 128KiB
>hda: 195371568 sectors (100030 MB) w/8192KiB Cache, CHS=65535/16/63,
>UDMA(100)
>hda: cache flushes supported
> hda: hda1 hda2
>mice: PS/2 mouse device common for all mice
>input: PC Speaker
>NET: Registered protocol family 2
>IP: routing cache hash table of 4096 buckets, 64Kbytes
>TCP established hash table entries: 131072 (order: 9, 2097152 bytes)
>TCP bind hash table entries: 65536 (order: 7, 786432 bytes)
>TCP: Hash tables configured (established 131072 bind 65536)
>NET: Registered protocol family 1
>NET: Registered protocol family 15
>ACPI wakeup devices: 
>ELAN USB0 USB1 USB2 KBC0 MSE0 
>ACPI: (supports S0 S3 S4 S5)
>kjournald starting.  Commit interval 5 seconds
>EXT3-fs: mounted filesystem with ordered data mode.
>VFS: Mounted root (ext3 filesystem) readonly.
>Freeing unused kernel memory: 192k freed
>input: AT Translated Set 2 keyboard on isa0060/serio0
>alps.c: Enabling hardware tapping
>input: PS/2 Mouse on isa0060/serio4
>input: AlpsPS/2 ALPS GlidePoint on isa0060/serio4
>Adding 977216k swap on /dev/hda1.  Priority:-1 extents:1
>EXT3 FS on hda2, internal journal
>Linux agpgart interface v0.101 (c) Dave Jones
>8139too Fast Ethernet driver 0.9.27
>ACPI: PCI Interrupt 0000:02:03.0[A] -> GSI 19 (level, low) -> IRQ 19
>eth0: RealTek RTL8139 at 0xa000, 00:0f:b0:01:82:2d, IRQ 19
>eth0:  Identified 8139 chip type 'RTL-8101'
>eth0: link up, 10Mbps, half-duplex, lpa 0x0000
>usbcore: registered new driver usbfs
>usbcore: registered new driver hub
>ACPI: PCI Interrupt 0000:02:07.2[C] -> GSI 19 (level, low) -> IRQ 19
>ehci_hcd 0000:02:07.2: NEC Corporation USB 2.0
>ehci_hcd 0000:02:07.2: new USB bus registered, assigned bus number 1
>ehci_hcd 0000:02:07.2: irq 19, io mem 0xd0208c00
>ehci_hcd 0000:02:07.2: park 0
>ehci_hcd 0000:02:07.2: USB 2.0 initialized, EHCI 1.00, driver 10 Dec
>2004
>hub 1-0:1.0: USB hub found
>hub 1-0:1.0: 5 ports detected
>ohci_hcd: 2004 Nov 08 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
>ACPI: PCI Interrupt 0000:00:13.0[A] -> GSI 19 (level, low) -> IRQ 19
>ohci_hcd 0000:00:13.0: ATI Technologies Inc OHCI USB Controller #1
>ohci_hcd 0000:00:13.0: new USB bus registered, assigned bus number 2
>ohci_hcd 0000:00:13.0: irq 19, io mem 0xd0001000
>hub 2-0:1.0: USB hub found
>hub 2-0:1.0: 3 ports detected
>ACPI: PCI Interrupt 0000:00:13.1[A] -> GSI 19 (level, low) -> IRQ 19
>ohci_hcd 0000:00:13.1: ATI Technologies Inc OHCI USB Controller #2
>ohci_hcd 0000:00:13.1: new USB bus registered, assigned bus number 3
>ohci_hcd 0000:00:13.1: irq 19, io mem 0xd0002000
>hub 3-0:1.0: USB hub found
>hub 3-0:1.0: 3 ports detected
>ACPI: PCI Interrupt 0000:02:07.0[A] -> GSI 16 (level, low) -> IRQ 16
>ohci_hcd 0000:02:07.0: NEC Corporation USB
>ohci_hcd 0000:02:07.0: new USB bus registered, assigned bus number 4
>ohci_hcd 0000:02:07.0: irq 16, io mem 0xd0206000
>hub 4-0:1.0: USB hub found
>hub 4-0:1.0: 3 ports detected
>ACPI: PCI Interrupt 0000:02:07.1[B] -> GSI 18 (level, low) -> IRQ 18
>ohci_hcd 0000:02:07.1: NEC Corporation USB (#2)
>ohci_hcd 0000:02:07.1: new USB bus registered, assigned bus number 5
>ohci_hcd 0000:02:07.1: irq 18, io mem 0xd0207000
>hub 5-0:1.0: USB hub found
>hub 5-0:1.0: 2 ports detected
>usb 4-1: new low speed USB device using ohci_hcd and address 2
>Linux Kernel Card Services
>  options:  [pci] [cardbus] [pm]
>ACPI: PCI Interrupt 0000:02:04.0[A] -> GSI 17 (level, low) -> IRQ 17
>Yenta: CardBus bridge found at 0000:02:04.0 [103c:006b]
>Yenta: Enabling burst memory read transactions
>Yenta: Using CSCINT to route CSC interrupts to PCI
>Yenta: Routing CardBus interrupts to PCI
>Yenta TI: socket 0000:02:04.0, mfunc 0x01111d22, devctl 0x64
>Yenta: ISA IRQ mask 0x0ed8, PCI irq 17
>Socket status: 30000006
>ACPI: PCI Interrupt 0000:02:04.1[B] -> GSI 16 (level, low) -> IRQ 16
>Yenta: CardBus bridge found at 0000:02:04.1 [103c:006b]
>Yenta: Using CSCINT to route CSC interrupts to PCI
>Yenta: Routing CardBus interrupts to PCI
>Yenta TI: socket 0000:02:04.1, mfunc 0x01111d22, devctl 0x64
>input: USB HID v1.10 Mouse [Logitech USB Receiver] on usb-0000:02:07.0-1
>usbcore: registered new driver usbhid
>drivers/usb/input/hid-core.c: v2.01:USB HID core driver
>Yenta: ISA IRQ mask 0x0ed8, PCI irq 16
>Socket status: 30000006
>ieee1394: Initialized config rom entry `ip1394'
>ohci1394: $Rev: 1250 $ Ben Collins <bcollins@debian.org>
>ACPI: PCI Interrupt 0000:02:00.0[A] -> GSI 16 (level, low) -> IRQ 16
>ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[16]
>MMIO=[d0208000-d02087ff]  Max Packet=[2048]
>Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing
>disabled
>ACPI: PCI Interrupt 0000:00:14.6[B] -> GSI 5 (level, low) -> IRQ 5
>ACPI: PCI Interrupt 0000:00:14.5[B] -> GSI 5 (level, low) -> IRQ 5
>agpgart: Detected Ati IGP9100/M chipset
>agpgart: AGP aperture is 32M @ 0xd2000000
>ieee1394: Host added: ID:BUS[0-00:1023]  GUID[463f02005c594058]
>eth1394: $Rev: 1247 $ Ben Collins <bcollins@debian.org>
>eth1394: eth1: IEEE-1394 IPv4 over 1394 Ethernet (fw-host0)
>USB Universal Host Controller Interface driver v2.2
>ip_tables: (C) 2000-2002 Netfilter core team
>ip_conntrack version 2.1 (7168 buckets, 57344 max) - 256 bytes per
>conntrack
>Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
>
>Now in 2.6.14:
>
>cat /proc/interrupts
>           CPU0       CPU1       
>  0:     345156          3    IO-APIC-edge  timer
>  1:         51          2    IO-APIC-edge  i8042
>  5:          1          0   IO-APIC-level  ATI IXP
>  8:          1          0    IO-APIC-edge  rtc
> 12:        121          0    IO-APIC-edge  i8042
> 14:       5474          0    IO-APIC-edge  ide0
> 15:          0          0    IO-APIC-edge  ide1
> 16:          1          0   IO-APIC-level  yenta
> 17:         29          0   IO-APIC-level  ohci_hcd:usb4, yenta,
>ohci1394
> 18:          2          0   IO-APIC-level  eth0, ehci_hcd:usb1,
>ohci_hcd:usb2, ohci_hcd:usb3
> 19:          0          0   IO-APIC-level  ohci_hcd:usb5
> 21:         40          0   IO-APIC-level  acpi
>NMI:          0          0 
>LOC:     345004     345037 
>ERR:          0
>MIS:          0
>
>lspci -v
>00:00.0 Host bridge: ATI Technologies Inc Radeon 9100 IGP Host Bridge
>(rev 02)
>	Subsystem: ATI Technologies Inc: Unknown device 1234
>	Flags: bus master, 66Mhz, medium devsel, latency 64
>	Memory at d2000000 (32-bit, prefetchable) [size=32M]
>	Memory at d0000000 (32-bit, non-prefetchable) [size=4K]
>	Capabilities: [a0] AGP version 3.0
>
>00:01.0 PCI bridge: ATI Technologies Inc Radeon 9100 IGP AGP Bridge
>(prog-if 00 [Normal decode])
>	Flags: bus master, 66Mhz, medium devsel, latency 99
>	Bus: primary=00, secondary=01, subordinate=01, sec-latency=68
>	I/O behind bridge: 00009000-00009fff
>	Memory behind bridge: d0100000-d01fffff
>	Prefetchable memory behind bridge: e0000000-efffffff
>
>00:13.0 USB Controller: ATI Technologies Inc OHCI USB Controller #1 (rev
>01) (prog-if 10 [OHCI])
>	Subsystem: ATI Technologies Inc: Unknown device 434c
>	Flags: bus master, 66Mhz, medium devsel, latency 64, IRQ 18
>	Memory at d0001000 (32-bit, non-prefetchable) [size=4K]
>
>00:13.1 USB Controller: ATI Technologies Inc OHCI USB Controller #2 (rev
>01) (prog-if 10 [OHCI])
>	Subsystem: ATI Technologies Inc: Unknown device 434c
>	Flags: bus master, 66Mhz, medium devsel, latency 64, IRQ 18
>	Memory at d0002000 (32-bit, non-prefetchable) [size=4K]
>
>00:14.0 SMBus: ATI Technologies Inc ATI SMBus (rev 16)
>	Subsystem: Hewlett-Packard Company: Unknown device 006b
>	Flags: 66Mhz, medium devsel
>	I/O ports at 8040 [size=16]
>	Memory at 64000000 (32-bit, non-prefetchable) [size=1K]
>
>00:14.1 IDE interface: ATI Technologies Inc ATI Dual Channel Bus Master
>PCI IDE Controller (prog-if 8a [Master SecP PriP])
>	Subsystem: ATI Technologies Inc ATI Dual Channel Bus Master PCI IDE
>Controller
>	Flags: bus master, medium devsel, latency 64, IRQ 17
>	I/O ports at <ignored>
>	I/O ports at <ignored>
>	I/O ports at <ignored>
>	I/O ports at <ignored>
>	I/O ports at 8060 [size=16]
>
>00:14.3 ISA bridge: ATI Technologies Inc: Unknown device 434c
>	Subsystem: ATI Technologies Inc: Unknown device 434c
>	Flags: bus master, 66Mhz, medium devsel, latency 0
>
>00:14.4 PCI bridge: ATI Technologies Inc: Unknown device 4342 (prog-if
>01 [Subtractive decode])
>	Flags: bus master, 66Mhz, medium devsel, latency 64
>	Bus: primary=00, secondary=02, subordinate=04, sec-latency=69
>	I/O behind bridge: 0000a000-0000afff
>	Memory behind bridge: d0200000-d02fffff
>	Prefetchable memory behind bridge: 60000000-63ffffff
>
>00:14.5 Multimedia audio controller: ATI Technologies Inc IXP150 AC'97
>Audio Controller
>	Subsystem: Hewlett-Packard Company: Unknown device 006b
>	Flags: bus master, 66Mhz, slow devsel, latency 64, IRQ 5
>	Memory at d0003000 (32-bit, non-prefetchable) [size=256]
>
>00:14.6 Modem: ATI Technologies Inc IXP AC'97 Modem (rev 01) (prog-if 00
>[Generic])
>	Subsystem: Hewlett-Packard Company: Unknown device 006b
>	Flags: 66Mhz, slow devsel, IRQ 5
>	Memory at d0003400 (32-bit, non-prefetchable) [size=256]
>
>01:05.0 VGA compatible controller: ATI Technologies Inc RS300M AGP
>[Radeon Mobility 9100IGP] (prog-if 00 [VGA])
>	Subsystem: Hewlett-Packard Company: Unknown device 006b
>	Flags: bus master, fast Back2Back, 66Mhz, medium devsel, latency 66,
>IRQ 10
>	Memory at e0000000 (32-bit, prefetchable) [size=256M]
>	I/O ports at 9000 [size=256]
>	Memory at d0100000 (32-bit, non-prefetchable) [size=64K]
>	Expansion ROM at d0120000 [disabled] [size=128K]
>	Capabilities: [58] AGP version 3.0
>	Capabilities: [50] Power Management version 2
>
>02:00.0 FireWire (IEEE 1394): Texas Instruments TSB43AB21
>IEEE-1394a-2000 Controller (PHY/Link) (prog-if 10 [OHCI])
>	Subsystem: Hewlett-Packard Company: Unknown device 006b
>	Flags: bus master, medium devsel, latency 64, IRQ 17
>	Memory at d0208000 (32-bit, non-prefetchable) [size=2K]
>	Memory at d0200000 (32-bit, non-prefetchable) [size=16K]
>	Capabilities: [44] Power Management version 2
>
>02:02.0 Network controller: Broadcom Corporation BCM4306 802.11b/g
>Wireless LAN Controller (rev 03)
>	Subsystem: Hewlett-Packard Company: Unknown device 12f4
>	Flags: bus master, fast devsel, latency 64, IRQ 5
>	Memory at d0204000 (32-bit, non-prefetchable) [size=8K]
>
>02:03.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
>RTL-8139/8139C/8139C+ (rev 10)
>	Subsystem: Hewlett-Packard Company: Unknown device 006b
>	Flags: bus master, medium devsel, latency 128, IRQ 18
>	I/O ports at a000 [size=256]
>	Memory at d0208800 (32-bit, non-prefetchable) [size=256]
>	Capabilities: [50] Power Management version 2
>
>02:04.0 CardBus bridge: Texas Instruments PCI1620 PC Card Controller
>(rev 01)
>	Subsystem: Hewlett-Packard Company: Unknown device 006b
>	Flags: bus master, medium devsel, latency 168, IRQ 16
>	Memory at d0209000 (32-bit, non-prefetchable) [size=4K]
>	Bus: primary=02, secondary=03, subordinate=06, sec-latency=176
>	Memory window 0: 60000000-61fff000 (prefetchable)
>	Memory window 1: 66000000-67fff000
>	I/O window 0: 0000a800-0000a8ff
>	I/O window 1: 0000ac00-0000acff
>	16-bit legacy interface ports at 0001
>
>02:04.1 CardBus bridge: Texas Instruments PCI1620 PC Card Controller
>(rev 01)
>	Subsystem: Hewlett-Packard Company: Unknown device 006b
>	Flags: bus master, medium devsel, latency 168, IRQ 17
>	Memory at d020a000 (32-bit, non-prefetchable) [size=4K]
>	Bus: primary=02, secondary=07, subordinate=0a, sec-latency=176
>	Memory window 0: 62000000-63fff000 (prefetchable)
>	Memory window 1: 68000000-69fff000
>	I/O window 0: 00001400-000014ff
>	I/O window 1: 00001800-000018ff
>	16-bit legacy interface ports at 0001
>
>02:04.2 System peripheral: Texas Instruments PCI1620 Firmware Loading
>Function (rev 01)
>	Subsystem: Hewlett-Packard Company: Unknown device 006b
>	Flags: bus master, medium devsel, latency 64
>	I/O ports at a400 [size=64]
>	Capabilities: [44] Power Management version 2
>
>02:07.0 USB Controller: NEC Corporation USB (rev 43) (prog-if 10 [OHCI])
>	Subsystem: NEC Corporation USB
>	Flags: bus master, medium devsel, latency 64, IRQ 17
>	Memory at d0206000 (32-bit, non-prefetchable) [size=4K]
>	Capabilities: [40] Power Management version 2
>
>02:07.1 USB Controller: NEC Corporation USB (rev 43) (prog-if 10 [OHCI])
>	Subsystem: NEC Corporation USB
>	Flags: bus master, medium devsel, latency 64, IRQ 19
>	Memory at d0207000 (32-bit, non-prefetchable) [size=4K]
>	Capabilities: [40] Power Management version 2
>
>02:07.2 USB Controller: NEC Corporation USB 2.0 (rev 04) (prog-if 20
>[EHCI])
>	Subsystem: NEC Corporation USB 2.0
>	Flags: bus master, medium devsel, latency 64, IRQ 18
>	Memory at d0208c00 (32-bit, non-prefetchable) [size=256]
>	Capabilities: [40] Power Management version 2
>
>
>dmesg
>Linux version 2.6.14 (root@montroll) (gcc version 4.0.2) #10 SMP Fri Oct
>28 15:56:01 EDT 2005
>BIOS-provided physical RAM map:
> BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
> BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
> BIOS-e820: 00000000000d0000 - 00000000000d8000 (reserved)
> BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
> BIOS-e820: 0000000000100000 - 0000000047f70000 (usable)
> BIOS-e820: 0000000047f70000 - 0000000047f7d000 (ACPI data)
> BIOS-e820: 0000000047f7d000 - 0000000047f80000 (ACPI NVS)
> BIOS-e820: 0000000047f80000 - 0000000048000000 (reserved)
> BIOS-e820: 0000000057f80000 - 0000000058000000 (reserved)
> BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
> BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
> BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
>Warning only 896MB will be used.
>Use a HIGHMEM enabled kernel.
>896MB LOWMEM available.
>found SMP MP-table at 000f6570
>On node 0 totalpages: 229376
>  DMA zone: 4096 pages, LIFO batch:1
>  Normal zone: 225280 pages, LIFO batch:31
>  HighMem zone: 0 pages, LIFO batch:1
>DMI present.
>ACPI: RSDP (v000 PTLTD                                 ) @ 0x000f6600
>ACPI: RSDT (v001 PTLTD    RSDT   0x06040000  LTP 0x00000000) @
>0x47f791c8
>ACPI: FADT (v001 HP     Chinook  0x06040000 ATI  0x000f4240) @
>0x47f7ceed
>ACPI: MADT (v001 PTLTD  	 APIC   0x06040000  LTP 0x00000000) @
>0x47f7cf61
>ACPI: SSDT (v001 PTLTD  ACPIHT   0x06040000  LTP 0x00000001) @
>0x47f7cfc9
>ACPI: DSDT (v001     HP    SB200 0x06040000 INTL 0x20030509) @
>0x00000000
>ACPI: PM-Timer IO Port: 0x8008
>ACPI: Local APIC address 0xfee00000
>ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
>Processor #0 15:2 APIC version 20
>ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
>Processor #1 15:2 APIC version 20
>ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
>ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
>ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
>IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, GSI 0-23
>ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 high edge)
>ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 21 low level)
>ACPI: IRQ0 used by override.
>ACPI: IRQ2 used by override.
>Enabling APIC mode:  Flat.  Using 1 I/O APICs
>Using ACPI (MADT) for SMP configuration information
>Allocating PCI resources starting at 60000000 (gap: 58000000:a6c00000)
>Built 1 zonelists
>Kernel command line: BOOT_IMAGE=2.6.14 ro root=302
>mapped APIC to ffffd000 (fee00000)
>mapped IOAPIC to ffffc000 (fec00000)
>Initializing CPU#0
>PID hash table entries: 4096 (order: 12, 65536 bytes)
>Detected 3000.911 MHz processor.
>Using pmtmr for high-res timesource
>Console: colour VGA+ 80x25
>Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
>Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
>Memory: 906284k/917504k available (1696k kernel code, 10708k reserved,
>531k data, 188k init, 0k highmem)
>Checking if this processor honours the WP bit even in supervisor mode...
>Ok.
>Calibrating delay using timer specific routine.. 6002.40 BogoMIPS
>(lpj=3001201)
>Mount-cache hash table entries: 512
>CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000
>00004400 00000000 00000000
>CPU: After vendor identify, caps: bfebfbff 00000000 00000000 00000000
>00004400 00000000 00000000
>CPU: Trace cache: 12K uops, L1 D cache: 8K
>CPU: L2 cache: 512K
>CPU: Physical Processor ID: 0
>CPU: After all inits, caps: bfebfbff 00000000 00000000 00000080 00004400
>00000000 00000000
>Intel machine check architecture supported.
>Intel machine check reporting enabled on CPU#0.
>CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
>CPU0: Thermal monitoring enabled
>mtrr: v2.0 (20020519)
>Enabling fast FPU save and restore... done.
>Enabling unmasked SIMD FPU exception support... done.
>Checking 'hlt' instruction... OK.
>CPU0: Intel(R) Pentium(R) 4 CPU 3.00GHz stepping 09
>Booting processor 1/1 eip 2000
>Initializing CPU#1
>Calibrating delay using timer specific routine.. 5999.46 BogoMIPS
>(lpj=2999730)
>CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000
>00004400 00000000 00000000
>CPU: After vendor identify, caps: bfebfbff 00000000 00000000 00000000
>00004400 00000000 00000000
>CPU: Trace cache: 12K uops, L1 D cache: 8K
>CPU: L2 cache: 512K
>CPU: Physical Processor ID: 0
>CPU: After all inits, caps: bfebfbff 00000000 00000000 00000080 00004400
>00000000 00000000
>Intel machine check architecture supported.
>Intel machine check reporting enabled on CPU#1.
>CPU1: Intel P4/Xeon Extended MCE MSRs (12) available
>CPU1: Thermal monitoring enabled
>CPU1: Intel(R) Pentium(R) 4 CPU 3.00GHz stepping 09
>Total of 2 processors activated (12001.86 BogoMIPS).
>ENABLING IO-APIC IRQs
>..TIMER: vector=0x31 pin1=2 pin2=-1
>checking TSC synchronization across 2 CPUs: passed.
>softlockup thread 0 started up.
>Brought up 2 CPUs
>softlockup thread 1 started up.
>NET: Registered protocol family 16
>ACPI: bus type pci registered
>PCI: PCI BIOS revision 2.10 entry at 0xfd968, last bus=2
>PCI: Using configuration type 1
>ACPI: Subsystem revision 20050902
>ACPI: Interpreter enabled
>ACPI: Using IOAPIC for interrupt routing
>ACPI: PCI Root Bridge [PCI0] (0000:00)
>PCI: Probing PCI hardware (bus 00)
>ACPI: Assume root bridge [\_SB_.PCI0] bus is 0
>PCI: Ignoring BAR0-3 of IDE controller 0000:00:14.1
>Boot video device is 0000:01:05.0
>PCI: Transparent bridge - 0000:00:14.4
>ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
>ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGPB._PRT]
>ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P2P_._PRT]
>ACPI: PCI Interrupt Link [LNK0] (IRQs 5 10 11) *0, disabled.
>ACPI: PCI Interrupt Link [LNK1] (IRQs 5 10 11) *0, disabled.
>ACPI: PCI Interrupt Link [LNK2] (IRQs 5 10 11) *0, disabled.
>ACPI: PCI Interrupt Link [LNK3] (IRQs 5 10 11) *0, disabled.
>ACPI: Embedded Controller [EC0] (gpe 6)
>PCI: Using ACPI for IRQ routing
>PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a
>report
>PCI: Bridge: 0000:00:01.0
>  IO window: 9000-9fff
>  MEM window: d0100000-d01fffff
>  PREFETCH window: e0000000-efffffff
>PCI: Bus 3, cardbus bridge: 0000:02:04.0
>  IO window: 0000a800-0000a8ff
>  IO window: 0000ac00-0000acff
>  PREFETCH window: 60000000-61ffffff
>  MEM window: 66000000-67ffffff
>PCI: Bus 7, cardbus bridge: 0000:02:04.1
>  IO window: 00001400-000014ff
>  IO window: 00001800-000018ff
>  PREFETCH window: 62000000-63ffffff
>  MEM window: 68000000-69ffffff
>PCI: Bridge: 0000:00:14.4
>  IO window: a000-afff
>  MEM window: d0200000-d02fffff
>  PREFETCH window: 60000000-63ffffff
>ACPI: PCI Interrupt 0000:02:04.0[A] -> GSI 17 (level, low) -> IRQ 16
>ACPI: PCI Interrupt 0000:02:04.1[B] -> GSI 16 (level, low) -> IRQ 17
>Machine check exception polling timer started.
>Initializing Cryptographic API
>ACPI: AC Adapter [ACAD] (on-line)
>ACPI: Battery Slot [BAT1] (battery present)
>ACPI: Power Button (FF) [PWRF]
>ACPI: Lid Switch [LID]
>ACPI: Power Button (CM) [PWRB]
>ACPI: CPU0 (power states: C1[C1] C2[C2])
>ACPI: CPU1 (power states: C1[C1] C2[C2])
>ACPI: Thermal Zone [THRM] (52 C)
>Real Time Clock Driver v1.12
>i8042.c: Detected active multiplexing controller, rev 1.1.
>serio: i8042 AUX0 port at 0x60,0x64 irq 12
>serio: i8042 AUX1 port at 0x60,0x64 irq 12
>serio: i8042 AUX2 port at 0x60,0x64 irq 12
>serio: i8042 AUX3 port at 0x60,0x64 irq 12
>serio: i8042 KBD port at 0x60,0x64 irq 1
>io scheduler noop registered
>io scheduler anticipatory registered
>io scheduler deadline registered
>io scheduler cfq registered
>Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
>ide: Assuming 33MHz system bus speed for PIO modes; override with
>idebus=xx
>ATIIXP: IDE controller at PCI slot 0000:00:14.1
>ACPI: PCI Interrupt 0000:00:14.1[A] -> GSI 16 (level, low) -> IRQ 17
>ATIIXP: chipset revision 0
>ATIIXP: not 100% native mode: will probe irqs later
>    ide0: BM-DMA at 0x8060-0x8067, BIOS settings: hda:DMA, hdb:pio
>    ide1: BM-DMA at 0x8068-0x806f, BIOS settings: hdc:DMA, hdd:pio
>Probing IDE interface ide0...
>hda: ST9100823A, ATA DISK drive
>ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
>Probing IDE interface ide1...
>hdc: SD-R2512, ATAPI CD/DVD-ROM drive
>ide1 at 0x170-0x177,0x376 on irq 15
>hda: max request size: 128KiB
>hda: 195371568 sectors (100030 MB) w/8192KiB Cache, CHS=65535/16/63,
>UDMA(100)
>hda: cache flushes supported
> hda: hda1 hda2
>mice: PS/2 mouse device common for all mice
>input: PC Speaker
>NET: Registered protocol family 2
>IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
>TCP established hash table entries: 131072 (order: 8, 1048576 bytes)
>TCP bind hash table entries: 65536 (order: 7, 524288 bytes)
>TCP: Hash tables configured (established 131072 bind 65536)
>TCP reno registered
>TCP bic registered
>NET: Registered protocol family 1
>NET: Registered protocol family 15
>Using IPI Shortcut mode
>kjournald starting.  Commit interval 5 seconds
>input: AT Translated Set 2 keyboard on isa0060/serio0
>EXT3-fs: mounted filesystem with ordered data mode.
>VFS: Mounted root (ext3 filesystem) readonly.
>Freeing unused kernel memory: 188k freed
>input: PS/2 Mouse on isa0060/serio4
>input: AlpsPS/2 ALPS GlidePoint on isa0060/serio4
>Adding 977216k swap on /dev/hda1.  Priority:-1 extents:1 across:977216k
>EXT3 FS on hda2, internal journal
>Linux agpgart interface v0.101 (c) Dave Jones
>8139too Fast Ethernet driver 0.9.27
>ACPI: PCI Interrupt 0000:02:03.0[A] -> GSI 19 (level, low) -> IRQ 18
>eth0: RealTek RTL8139 at 0xa000, 00:0f:b0:01:82:2d, IRQ 18
>eth0:  Identified 8139 chip type 'RTL-8101'
>eth0: link up, 10Mbps, half-duplex, lpa 0x0000
>usbcore: registered new driver usbfs
>usbcore: registered new driver hub
>ACPI: PCI Interrupt 0000:02:07.2[C] -> GSI 19 (level, low) -> IRQ 18
>ehci_hcd 0000:02:07.2: EHCI Host Controller
>ehci_hcd 0000:02:07.2: new USB bus registered, assigned bus number 1
>ehci_hcd 0000:02:07.2: irq 18, io mem 0xd0208c00
>ehci_hcd 0000:02:07.2: park 0
>ehci_hcd 0000:02:07.2: USB 2.0 initialized, EHCI 1.00, driver 10 Dec
>2004
>hub 1-0:1.0: USB hub found
>hub 1-0:1.0: 5 ports detected
>ohci_hcd: 2005 April 22 USB 1.1 'Open' Host Controller (OHCI) Driver
>(PCI)
>ACPI: PCI Interrupt 0000:00:13.0[A] -> GSI 19 (level, low) -> IRQ 18
>ohci_hcd 0000:00:13.0: OHCI Host Controller
>ohci_hcd 0000:00:13.0: new USB bus registered, assigned bus number 2
>ohci_hcd 0000:00:13.0: irq 18, io mem 0xd0001000
>hub 2-0:1.0: USB hub found
>hub 2-0:1.0: 3 ports detected
>ACPI: PCI Interrupt 0000:00:13.1[A] -> GSI 19 (level, low) -> IRQ 18
>ohci_hcd 0000:00:13.1: OHCI Host Controller
>ohci_hcd 0000:00:13.1: new USB bus registered, assigned bus number 3
>ohci_hcd 0000:00:13.1: irq 18, io mem 0xd0002000
>hub 3-0:1.0: USB hub found
>hub 3-0:1.0: 3 ports detected
>ACPI: PCI Interrupt 0000:02:07.0[A] -> GSI 16 (level, low) -> IRQ 17
>ohci_hcd 0000:02:07.0: OHCI Host Controller
>ohci_hcd 0000:02:07.0: new USB bus registered, assigned bus number 4
>ohci_hcd 0000:02:07.0: irq 17, io mem 0xd0206000
>hub 4-0:1.0: USB hub found
>hub 4-0:1.0: 3 ports detected
>ACPI: PCI Interrupt 0000:02:07.1[B] -> GSI 18 (level, low) -> IRQ 19
>ohci_hcd 0000:02:07.1: OHCI Host Controller
>ohci_hcd 0000:02:07.1: new USB bus registered, assigned bus number 5
>ohci_hcd 0000:02:07.1: irq 19, io mem 0xd0207000
>hub 5-0:1.0: USB hub found
>hub 5-0:1.0: 2 ports detected
>usb 4-1: new low speed USB device using ohci_hcd and address 2
>ACPI: PCI Interrupt 0000:02:04.0[A] -> GSI 17 (level, low) -> IRQ 16
>Yenta: CardBus bridge found at 0000:02:04.0 [103c:006b]
>Yenta: Enabling burst memory read transactions
>Yenta: Using CSCINT to route CSC interrupts to PCI
>Yenta: Routing CardBus interrupts to PCI
>Yenta TI: socket 0000:02:04.0, mfunc 0x01111d22, devctl 0x64
>Yenta: ISA IRQ mask 0x0ed8, PCI irq 16
>Socket status: 30000086
>pcmcia: parent PCI bridge I/O window: 0xa000 - 0xafff
>pcmcia: parent PCI bridge Memory window: 0xd0200000 - 0xd02fffff
>pcmcia: parent PCI bridge Memory window: 0x60000000 - 0x63ffffff
>ACPI: PCI Interrupt 0000:02:04.1[B] -> GSI 16 (level, low) -> IRQ 17
>Yenta: CardBus bridge found at 0000:02:04.1 [103c:006b]
>Yenta: Using CSCINT to route CSC interrupts to PCI
>Yenta: Routing CardBus interrupts to PCI
>Yenta TI: socket 0000:02:04.1, mfunc 0x01111d22, devctl 0x64
>input: USB HID v1.10 Mouse [Logitech USB Receiver] on usb-0000:02:07.0-1
>usbcore: registered new driver usbhid
>drivers/usb/input/hid-core.c: v2.6:USB HID core driver
>Yenta: ISA IRQ mask 0x0ed8, PCI irq 17
>Socket status: 30000006
>pcmcia: parent PCI bridge I/O window: 0xa000 - 0xafff
>pcmcia: parent PCI bridge Memory window: 0xd0200000 - 0xd02fffff
>pcmcia: parent PCI bridge Memory window: 0x60000000 - 0x63ffffff
>ieee1394: Initialized config rom entry `ip1394'
>ohci1394: $Rev: 1313 $ Ben Collins <bcollins@debian.org>
>ACPI: PCI Interrupt 0000:02:00.0[A] -> GSI 16 (level, low) -> IRQ 17
>ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[17]
>MMIO=[d0208000-d02087ff]  Max Packet=[2048]
>ieee1394: Host added: ID:BUS[0-00:1023]  GUID[463f02005c594058]
>eth1394: $Rev: 1312 $ Ben Collins <bcollins@debian.org>
>eth1394: eth1: IEEE-1394 IPv4 over 1394 Ethernet (fw-host0)
>Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing
>disabled
>ACPI: PCI Interrupt 0000:00:14.6[B] -> GSI 5 (level, low) -> IRQ 5
>ACPI: PCI interrupt for device 0000:00:14.6 disabled
>ACPI: PCI Interrupt 0000:00:14.5[B] -> GSI 5 (level, low) -> IRQ 5
>agpgart: Detected Ati IGP9100/M chipset
>agpgart: AGP aperture is 32M @ 0xd2000000
>USB Universal Host Controller Interface driver v2.3
>ip_tables: (C) 2000-2002 Netfilter core team
>ip_conntrack version 2.3 (7168 buckets, 57344 max) - 236 bytes per
>conntrack
>Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
>NFSD: Using /var/lib/nfs/v4recovery as the NFSv4 state recovery
>directory
>NFSD: recovery directory /var/lib/nfs/v4recovery doesn't exist
>NFSD: starting 90-second grace period
>nfsd: last server has exited
>nfsd: unexporting all filesystems
>NFSD: Using /var/lib/nfs/v4recovery as the NFSv4 state recovery
>directory
>NFSD: recovery directory /var/lib/nfs/v4recovery doesn't exist
>NFSD: starting 90-second grace period
>
>Hope this helps.
>
>David
>
>
>On Sun, 2005-10-30 at 10:33 -0500, Mark Hahn wrote:
>  
>
>>>The problem I reported on the linux-kernel list and later here.  See
>>>      
>>>
>>you mentioned posting the full dmesg(s).  in particular,
>>are there differences in /proc/interrupts in working and 
>>non-working kernels?  lspci -v might also be interesting.
>>
>>    
>>
>>>laptop has a P4 Hyperthreaded chip (someone mentioned that there was an
>>>ACPI problem related to hyperthreading).
>>>      
>>>
>>conceivable, but HT is hardly a new phenomenon.
>>
>>
>>    
>>
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-ide" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>  
>


	

	
		
___________________________________________________________ 
Gesendet von Yahoo! Mail - Jetzt mit 1GB Speicher kostenlos - Hier anmelden: http://mail.yahoo.de

