From: Stefan <gentoopower@yahoo.de>
Subject: Harddrives poweroff on reboot, kernel 2.6.6
Date: Wed, 12 May 2004 12:01:08 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <40A1F5E4.8050507@yahoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp011.mail.yahoo.com ([216.136.173.31]:22908 "HELO
	smtp011.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263173AbUELJyP (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 12 May 2004 05:54:15 -0400
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hallo folks,

Since kernel 2.6.6 my harddrives are shut down on a reboot, you can hear 
they get switched off all the way.
I also know a couple of people that told me that this happens also on 
their boxes with 2.6.6
Is this neccessary?
Anybody know why this happens, I have never experienced this before, if 
I boot with 2.6.5 it doesn't happen.

Thanks R.S.

dmesg:
May 12 09:47:41 nihao kernel: klogd 1.4.1, log source = /proc/kmsg started.
May 12 09:47:41 nihao kernel: Cannot find map file.
May 12 09:47:41 nihao kernel: No module symbols loaded - kernel modules 
not enabled.
May 12 09:47:41 nihao kernel: Linux version 2.6.6 (root@xxx.xxx.xxx) 
(gcc version 3.3.2 20031218 (Gentoo Linux 3.3.2-r5,
propolice-3.3-7)) #1 Mon May 10 12:01:49 CEST 2004
May 12 09:47:41 nihao kernel: BIOS-provided physical RAM map:
May 12 09:47:41 nihao kernel:  BIOS-e820: 0000000000000000 - 
000000000009fc00 (usable)
May 12 09:47:41 nihao kernel:  BIOS-e820: 000000000009fc00 - 
00000000000a0000 (reserved)
May 12 09:47:41 nihao kernel:  BIOS-e820: 00000000000f0000 - 
0000000000100000 (reserved)
May 12 09:47:41 nihao kernel:  BIOS-e820: 0000000000100000 - 
000000001fff0000 (usable)
May 12 09:47:41 nihao kernel:  BIOS-e820: 000000001fff0000 - 
000000001fff8000 (ACPI data)
May 12 09:47:41 nihao kernel:  BIOS-e820: 000000001fff8000 - 
0000000020000000 (ACPI NVS)
May 12 09:47:41 nihao kernel:  BIOS-e820: 00000000fec00000 - 
00000000fec01000 (reserved)
May 12 09:47:41 nihao kernel:  BIOS-e820: 00000000fee00000 - 
00000000fee01000 (reserved)
May 12 09:47:41 nihao kernel:  BIOS-e820: 00000000ffee0000 - 
00000000fff00000 (reserved)
May 12 09:47:41 nihao kernel:  BIOS-e820: 00000000fffc0000 - 
0000000100000000 (reserved)
May 12 09:47:41 nihao kernel: 511MB LOWMEM available.
May 12 09:47:41 nihao kernel: On node 0 totalpages: 131056
May 12 09:47:41 nihao kernel:   DMA zone: 4096 pages, LIFO batch:1
May 12 09:47:41 nihao kernel:   Normal zone: 126960 pages, LIFO batch:16
May 12 09:47:41 nihao kernel:   HighMem zone: 0 pages, LIFO batch:1
May 12 09:47:41 nihao kernel: DMI 2.3 present.
May 12 09:47:41 nihao kernel: ACPI: RSDP (v000 
AMI                                       ) @ 0x000faae0
May 12 09:47:41 nihao kernel: ACPI: RSDT (v001 AMIINT SiS740XX 
0x00001000 MSFT 0x0100000b) @ 0x1fff0000
May 12 09:47:41 nihao kernel: ACPI: FADT (v001 AMIINT SiS740XX 
0x00000011 MSFT 0x0100000b) @ 0x1fff0030
May 12 09:47:41 nihao kernel: ACPI: MADT (v001 AMIINT SiS740XX 
0x00001000 MSFT 0x0100000b) @ 0x1fff00c0
May 12 09:47:41 nihao kernel: ACPI: DSDT (v001    SiS      748 
0x00000100 MSFT 0x0100000d) @ 0x00000000
May 12 09:47:41 nihao kernel: ACPI: Local APIC address 0xfee00000
May 12 09:47:41 nihao kernel: ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] 
enabled)
May 12 09:47:41 nihao kernel: Processor #0 6:8 APIC version 16
May 12 09:47:41 nihao kernel: ACPI: LAPIC_NMI (acpi_id[0x01] high edge 
lint[0x1])
May 12 09:47:41 nihao kernel: ACPI: IOAPIC (id[0x02] address[0xfec00000] 
global_irq_base[0x0])
May 12 09:47:41 nihao kernel: IOAPIC[0]: Assigned apic_id 2
May 12 09:47:41 nihao kernel: IOAPIC[0]: apic_id 2, version 20, address 
0xfec00000, GSI 0-23
May 12 09:47:41 nihao kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 0 
global_irq 2 high edge)
May 12 09:47:41 nihao kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 9 
global_irq 9 low level)
May 12 09:47:41 nihao kernel: Enabling APIC mode:  Flat.  Using 1 I/O APICs
May 12 09:47:41 nihao kernel: Using ACPI (MADT) for SMP configuration 
information
May 12 09:47:41 nihao kernel: Built 1 zonelists
May 12 09:47:41 nihao kernel: Kernel command line: root=/dev/hdb5 vga=794
May 12 09:47:41 nihao kernel: Initializing CPU#0
May 12 09:47:41 nihao kernel: PID hash table entries: 2048 (order 11: 
16384 bytes)
May 12 09:47:41 nihao kernel: Detected 2000.223 MHz processor.
May 12 09:47:41 nihao kernel: Using tsc for high-res timesource
May 12 09:47:41 nihao kernel: Console: colour dummy device 80x25
May 12 09:47:41 nihao kernel: Memory: 515892k/524224k available (2158k 
kernel code, 7568k reserved, 690k data, 348k init, 0
k highmem)
May 12 09:47:41 nihao kernel: Checking if this processor honours the WP 
bit even in supervisor mode... Ok.
May 12 09:47:41 nihao kernel: Calibrating delay loop... 3964.92 BogoMIPS
May 12 09:47:41 nihao kernel: Security Scaffold v1.0.0 initialized
May 12 09:47:41 nihao kernel: Dentry cache hash table entries: 65536 
(order: 6, 262144 bytes)
May 12 09:47:41 nihao kernel: Inode-cache hash table entries: 32768 
(order: 5, 131072 bytes)
May 12 09:47:41 nihao kernel: Mount-cache hash table entries: 512 
(order: 0, 4096 bytes)
May 12 09:47:41 nihao kernel: CPU:     After generic identify, caps: 
0383fbff c1c3fbff 00000000 00000000
May 12 09:47:41 nihao kernel: CPU:     After vendor identify, caps: 
0383fbff c1c3fbff 00000000 00000000
May 12 09:47:41 nihao kernel: CPU: L1 I Cache: 64K (64 bytes/line), D 
cache 64K (64 bytes/line)
May 12 09:47:41 nihao kernel: CPU: L2 Cache: 256K (64 bytes/line)
May 12 09:47:41 nihao kernel: CPU:     After all inits, caps: 0383fbff 
c1c3fbff 00000000 00000020
May 12 09:47:41 nihao kernel: Intel machine check architecture supported.
May 12 09:47:41 nihao kernel: Intel machine check reporting enabled on 
CPU#0.
May 12 09:47:41 nihao kernel: CPU: AMD Athlon(tm) XP 2400+ stepping 01
May 12 09:47:41 nihao kernel: Enabling fast FPU save and restore... done.
May 12 09:47:41 nihao kernel: Enabling unmasked SIMD FPU exception 
support... done.
May 12 09:47:41 nihao kernel: Checking 'hlt' instruction... OK.
May 12 09:47:41 nihao kernel: POSIX conformance testing by UNIFIX
May 12 09:47:41 nihao kernel: enabled ExtINT on CPU#0
May 12 09:47:41 nihao kernel: ESR value before enabling vector: 00000000
May 12 09:47:41 nihao kernel: ESR value after enabling vector: 00000000
May 12 09:47:41 nihao kernel: ENABLING IO-APIC IRQs
May 12 09:47:41 nihao kernel: init IO_APIC IRQs
May 12 09:47:41 nihao kernel:  IO-APIC (apicid-pin) 2-0, 2-16, 2-17, 
2-18, 2-19, 2-20, 2-21, 2-22, 2-23 not connected.
May 12 09:47:41 nihao kernel: ..TIMER: vector=0x31 pin1=2 pin2=-1
May 12 09:47:41 nihao kernel: Using local APIC timer interrupts.
May 12 09:47:41 nihao kernel: calibrating APIC timer ...
May 12 09:47:41 nihao kernel: ..... CPU clock speed is 1999.0753 MHz.
May 12 09:47:41 nihao kernel: ..... host bus clock speed is 399.0950 MHz.
May 12 09:47:41 nihao kernel: NET: Registered protocol family 16
May 12 09:47:41 nihao kernel: PCI: PCI BIOS revision 2.10 entry at 
0xfdb31, last bus=2
May 12 09:47:41 nihao kernel: mtrr: v2.0 (20020519)
May 12 09:47:41 nihao kernel: ACPI: Subsystem revision 20040326
May 12 09:47:41 nihao kernel: ACPI: Interpreter enabled
May 12 09:47:41 nihao kernel: ACPI: Using IOAPIC for interrupt routing
May 12 09:47:41 nihao kernel: ACPI: PCI Root Bridge [PCI0] (00:00)
May 12 09:47:41 nihao kernel: PCI: Probing PCI hardware (bus 00)
May 12 09:47:41 nihao kernel: ACPI: PCI Interrupt Routing Table 
[\_SB_.PCI0._PRT]
May 12 09:47:41 nihao kernel: ACPI: Power Resource [URP1] (off)
May 12 09:47:41 nihao kernel: ACPI: Power Resource [URP2] (off)
May 12 09:47:41 nihao kernel: ACPI: Power Resource [FDDP] (off)
May 12 09:47:41 nihao kernel: ACPI: Power Resource [LPTP] (off)
May 12 09:47:41 nihao kernel: ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 
5 6 7 10 *11 12 14 15)
May 12 09:47:41 nihao kernel: ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 
5 6 7 10 11 12 14 15) *0, disabled.
May 12 09:47:41 nihao kernel: ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 
5 6 7 *10 11 12 14 15)
May 12 09:47:41 nihao kernel: ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 
5 6 7 10 11 *12 14 15)
May 12 09:47:41 nihao kernel: ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 
5 6 *7 10 11 12 14 15)
May 12 09:47:41 nihao kernel: ACPI: PCI Interrupt Link [LNKF] (IRQs *3 4 
5 6 7 10 11 12 14 15)
May 12 09:47:41 nihao kernel: ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 
*5 6 7 10 11 12 14 15)
May 12 09:47:41 nihao kernel: ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 
5 6 7 10 11 *12 14 15)
May 12 09:47:41 nihao kernel: Linux Plug and Play Support v0.97 (c) Adam 
Belay
May 12 09:47:41 nihao kernel: SCSI subsystem initialized
May 12 09:47:41 nihao kernel: usbcore: registered new driver usbfs
May 12 09:47:41 nihao kernel: usbcore: registered new driver hub
May 12 09:47:41 nihao kernel: 00:00:01[A] -> 2-16 -> IRQ 16 level low
May 12 09:47:41 nihao kernel: 00:00:01[B] -> 2-17 -> IRQ 17 level low
May 12 09:47:41 nihao kernel: 00:00:01[C] -> 2-18 -> IRQ 18 level low
May 12 09:47:41 nihao kernel: 00:00:01[D] -> 2-19 -> IRQ 19 level low
May 12 09:47:41 nihao kernel: 00:00:03[A] -> 2-20 -> IRQ 20 level low
May 12 09:47:41 nihao kernel: 00:00:03[B] -> 2-21 -> IRQ 21 level low
May 12 09:47:41 nihao kernel: 00:00:03[C] -> 2-22 -> IRQ 22 level low
May 12 09:47:41 nihao kernel: 00:00:03[D] -> 2-23 -> IRQ 23 level low
May 12 09:47:41 nihao kernel: number of MP IRQ sources: 15.
May 12 09:47:41 nihao kernel: number of IO-APIC #2 registers: 24.
May 12 09:47:41 nihao kernel: testing the IO APIC.......................
May 12 09:47:41 nihao kernel: IO APIC #2......
May 12 09:47:41 nihao kernel: .... register #00: 02000000
May 12 09:47:41 nihao kernel: .......    : physical APIC id: 02
May 12 09:47:41 nihao kernel: .......    : Delivery Type: 0
May 12 09:47:41 nihao kernel: .......    : LTS          : 0
May 12 09:47:41 nihao kernel: .... register #01: 00178014
May 12 09:47:41 nihao kernel: .......     : max redirection entries: 0017
May 12 09:47:41 nihao kernel: .......     : PRQ implemented: 1
May 12 09:47:41 nihao kernel: .......     : IO APIC version: 0014
May 12 09:47:41 nihao kernel: .... register #02: 00000000
May 12 09:47:41 nihao kernel: .......     : arbitration: 00
May 12 09:47:41 nihao kernel: .... IRQ redirection table:
May 12 09:47:41 nihao kernel:  NR Log Phy Mask Trig IRR Pol Stat Dest 
Deli Vect:
May 12 09:47:41 nihao kernel:  00 000 00  1    0    0   0   0    0    
0    00
May 12 09:47:41 nihao kernel:  01 001 01  0    0    0   0   0    1    
1    39
May 12 09:47:41 nihao kernel:  02 001 01  0    0    0   0   0    1    
1    31
May 12 09:47:41 nihao kernel:  03 001 01  0    0    0   0   0    1    
1    41
May 12 09:47:41 nihao kernel:  04 001 01  0    0    0   0   0    1    
1    49
May 12 09:47:41 nihao kernel:  05 001 01  0    0    0   0   0    1    
1    51
May 12 09:47:41 nihao kernel:  06 001 01  0    0    0   0   0    1    
1    59
May 12 09:47:41 nihao kernel:  07 001 01  0    0    0   0   0    1    
1    61
May 12 09:47:41 nihao kernel:  08 001 01  0    0    0   0   0    1    
1    69
May 12 09:47:41 nihao kernel:  09 001 01  0    1    0   1   0    1    
1    71
May 12 09:47:41 nihao kernel:  0a 001 01  0    0    0   0   0    1    
1    79
May 12 09:47:41 nihao kernel:  0b 001 01  0    0    0   0   0    1    
1    81
May 12 09:47:41 nihao kernel:  0c 001 01  0    0    0   0   0    1    
1    89
May 12 09:47:41 nihao kernel:  0d 001 01  0    0    0   0   0    1    
1    91
May 12 09:47:41 nihao kernel:  0e 001 01  0    0    0   0   0    1    
1    99
May 12 09:47:41 nihao kernel:  0f 001 01  0    0    0   0   0    1    
1    A1
May 12 09:47:41 nihao kernel:  10 001 01  1    1    0   1   0    1    
1    A9
May 12 09:47:41 nihao kernel:  11 001 01  1    1    0   1   0    1    
1    B1
May 12 09:47:41 nihao kernel:  12 001 01  1    1    0   1   0    1    
1    B9
May 12 09:47:41 nihao kernel:  13 001 01  1    1    0   1   0    1    
1    C1
May 12 09:47:41 nihao kernel:  14 001 01  1    1    0   1   0    1    
1    C9
May 12 09:47:41 nihao kernel:  15 001 01  1    1    0   1   0    1    
1    D1
May 12 09:47:41 nihao kernel:  16 001 01  1    1    0   1   0    1    
1    D9
May 12 09:47:41 nihao kernel:  17 001 01  1    1    0   1   0    1    
1    E1
May 12 09:47:41 nihao kernel: IRQ to pin mappings:
May 12 09:47:41 nihao kernel: IRQ0 -> 0:2
May 12 09:47:41 nihao kernel: IRQ1 -> 0:1
May 12 09:47:41 nihao kernel: IRQ3 -> 0:3
May 12 09:47:41 nihao kernel: IRQ4 -> 0:4
May 12 09:47:41 nihao kernel: IRQ5 -> 0:5
May 12 09:47:41 nihao kernel: IRQ6 -> 0:6
May 12 09:47:41 nihao kernel: IRQ7 -> 0:7
May 12 09:47:41 nihao kernel: IRQ8 -> 0:8
May 12 09:47:41 nihao kernel: IRQ9 -> 0:9
May 12 09:47:41 nihao kernel: IRQ10 -> 0:10
May 12 09:47:41 nihao kernel: IRQ11 -> 0:11
May 12 09:47:41 nihao kernel: IRQ12 -> 0:12
May 12 09:47:41 nihao kernel: IRQ13 -> 0:13
May 12 09:47:41 nihao kernel: IRQ14 -> 0:14
May 12 09:47:41 nihao kernel: IRQ15 -> 0:15
May 12 09:47:41 nihao kernel: IRQ16 -> 0:16
May 12 09:47:41 nihao kernel: IRQ17 -> 0:17
May 12 09:47:41 nihao kernel: IRQ18 -> 0:18
May 12 09:47:41 nihao kernel: IRQ19 -> 0:19
May 12 09:47:41 nihao kernel: IRQ20 -> 0:20
May 12 09:47:41 nihao kernel: IRQ21 -> 0:21
May 12 09:47:41 nihao kernel: IRQ22 -> 0:22
May 12 09:47:41 nihao kernel: IRQ23 -> 0:23
May 12 09:47:41 nihao kernel: .................................... done.
May 12 09:47:41 nihao kernel: PCI: Using ACPI for IRQ routing
May 12 09:47:41 nihao kernel: vesafb: framebuffer at 0xc0000000, mapped 
to 0xe0807000, size 16384k
May 12 09:47:41 nihao kernel: vesafb: mode is 1280x1024x16, 
linelength=2560, pages=1
May 12 09:47:41 nihao kernel: vesafb: protected mode interface info at 
c000:f880
May 12 09:47:41 nihao kernel: vesafb: scrolling: redraw
May 12 09:47:41 nihao kernel: vesafb: directcolor: size=0:5:6:5, 
shift=0:11:5:0
May 12 09:47:41 nihao kernel: fb0: VESA VGA frame buffer device
May 12 09:47:41 nihao kernel: Machine check exception polling timer started.
May 12 09:47:41 nihao kernel: devfs: 2004-01-31 Richard Gooch 
(rgooch@atnf.csiro.au)
May 12 09:47:41 nihao kernel: devfs: boot_options: 0x1
May 12 09:47:41 nihao kernel: NTFS driver 2.1.8 [Flags: R/O].
May 12 09:47:41 nihao kernel: udf: registering filesystem
May 12 09:47:41 nihao kernel: Initializing Cryptographic API
May 12 09:47:41 nihao kernel: ACPI: Power Button (FF) [PWRF]
May 12 09:47:41 nihao kernel: Console: switching to colour frame buffer 
device 160x64
May 12 09:47:41 nihao kernel: Linux agpgart interface v0.100 (c) Dave Jones
May 12 09:47:41 nihao kernel: agpgart: Detected SiS 746 chipset
May 12 09:47:41 nihao kernel: agpgart: Maximum main memory to use for 
agp memory: 439M
May 12 09:47:41 nihao kernel: agpgart: AGP aperture is 64M @ 0xd0000000
May 12 09:47:41 nihao kernel: Serial: 8250/16550 driver $Revision: 1.90 
$ 8 ports, IRQ sharing disabled
May 12 09:47:41 nihao kernel: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
May 12 09:47:41 nihao kernel: Using anticipatory io scheduler
May 12 09:47:41 nihao kernel: Floppy drive(s): fd0 is 1.44M
May 12 09:47:41 nihao kernel: FDC 0 is a post-1991 82077
May 12 09:47:41 nihao kernel: 8139too Fast Ethernet driver 0.9.27
May 12 09:47:41 nihao kernel: eth0: RealTek RTL8139 at 0xe182bf00, 
00:e0:7d:c0:68:91, IRQ 18
May 12 09:47:41 nihao kernel: eth0:  Identified 8139 chip type 'RTL-8139C'
May 12 09:47:41 nihao kernel: Uniform Multi-Platform E-IDE driver 
Revision: 7.00alpha2
May 12 09:47:41 nihao kernel: ide: Assuming 33MHz system bus speed for 
PIO modes; override with idebus=xx
May 12 09:47:41 nihao kernel: SIS5513: IDE controller at PCI slot 
0000:00:02.5
May 12 09:47:41 nihao kernel: SIS5513: chipset revision 1
May 12 09:47:41 nihao kernel: SIS5513: not 100%% native mode: will probe 
irqs later
May 12 09:47:41 nihao kernel: SIS5513: SiS 962/963 MuTIOL IDE UDMA133 
controller
May 12 09:47:41 nihao kernel:     ide0: BM-DMA at 0xff00-0xff07, BIOS 
settings: hda:DMA, hdb:DMA
May 12 09:47:41 nihao kernel:     ide1: BM-DMA at 0xff08-0xff0f, BIOS 
settings: hdc:DMA, hdd:DMA
May 12 09:47:41 nihao kernel: hda: WDC WD600AB-00CBA1, ATA DISK drive
May 12 09:47:41 nihao kernel: hdb: WDC WD800BB-00DKA0, ATA DISK drive
May 12 09:47:41 nihao kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
May 12 09:47:41 nihao kernel: hdc: RICOH DVD+RW MP5240, ATAPI CD/DVD-ROM 
drive
May 12 09:47:41 nihao kernel: hdd: HL-DT-ST GCE-8320B, ATAPI CD/DVD-ROM 
drive
May 12 09:47:41 nihao kernel: ide1 at 0x170-0x177,0x376 on irq 15
May 12 09:47:41 nihao kernel: hda: max request size: 128KiB
May 12 09:47:41 nihao kernel: hda: 117231408 sectors (60022 MB) 
w/2048KiB Cache, CHS=65535/16/63, UDMA(100)
May 12 09:47:41 nihao kernel:  /dev/ide/host0/bus0/target0/lun0: p1 p2 < 
p5 >
May 12 09:47:41 nihao kernel: hdb: max request size: 1024KiB
May 12 09:47:41 nihao kernel: hdb: 156301488 sectors (80026 MB) 
w/2048KiB Cache, CHS=16383/255/63, UDMA(100)
May 12 09:47:41 nihao kernel:  /dev/ide/host0/bus0/target1/lun0: p1 p2 
p3 < p5 p6 > p4
May 12 09:47:41 nihao kernel: hdc: ATAPI 40X DVD-ROM CD-R/RW drive, 
2048kB Cache, UDMA(33)
May 12 09:47:41 nihao kernel: Uniform CD-ROM driver Revision: 3.20
May 12 09:47:41 nihao kernel: hdd: ATAPI 40X CD-ROM CD-R/RW drive, 
2048kB Cache, DMA
May 12 09:47:41 nihao kernel: usbcore: registered new driver usblp
May 12 09:47:41 nihao kernel: drivers/usb/class/usblp.c: v0.13: USB 
Printer Device Class driver
May 12 09:47:41 nihao kernel: Initializing USB Mass Storage driver...
May 12 09:47:41 nihao kernel: usbcore: registered new driver usb-storage
May 12 09:47:41 nihao kernel: USB Mass Storage support registered.
May 12 09:47:41 nihao kernel: usbcore: registered new driver hid
May 12 09:47:41 nihao kernel: drivers/usb/input/hid-core.c: v2.0:USB HID 
core driver
May 12 09:47:41 nihao kernel: usbcore: registered new driver microtekX6
May 12 09:47:41 nihao kernel: mice: PS/2 mouse device common for all mice
May 12 09:47:41 nihao kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
May 12 09:47:41 nihao kernel: input: AT Translated Set 2 keyboard on 
isa0060/serio0
May 12 09:47:41 nihao kernel: NET: Registered protocol family 2
May 12 09:47:41 nihao kernel: IP: routing cache hash table of 4096 
buckets, 32Kbytes
May 12 09:47:41 nihao kernel: TCP: Hash tables configured (established 
32768 bind 65536)
May 12 09:47:41 nihao kernel: NET: Registered protocol family 1
May 12 09:47:41 nihao kernel: NET: Registered protocol family 17
May 12 09:47:41 nihao kernel: found reiserfs format "3.6" with standard 
journal
May 12 09:47:41 nihao kernel: reiserfs: using ordered data mode
May 12 09:47:41 nihao kernel: Reiserfs journal params: device hdb5, size 
8192, journal first block 18, max trans len 1024,
max batch 900, max commit age 30, max trans age 30
May 12 09:47:41 nihao kernel: reiserfs: checking transaction log (hdb5) 
for (hdb5)
May 12 09:47:41 nihao kernel: Using r5 hash to sort names
May 12 09:47:41 nihao kernel: VFS: Mounted root (reiserfs filesystem) 
readonly.
May 12 09:47:41 nihao kernel: Mounted devfs on /dev
May 12 09:47:41 nihao kernel: Freeing unused kernel memory: 348k freed
May 12 09:47:41 nihao kernel: Adding 530108k swap on /dev/hdb1.  
Priority:-1 extents:1
May 12 09:47:41 nihao kernel: ohci_hcd: 2004 Feb 02 USB 1.1 'Open' Host 
Controller (OHCI) Driver (PCI)
May 12 09:47:41 nihao kernel: ohci_hcd: block sizes: ed 64 td 64
May 12 09:47:41 nihao kernel: ohci_hcd 0000:00:03.0: Silicon Integrated 
Systems [SiS] USB 1.0 Controller
May 12 09:47:41 nihao kernel: ohci_hcd 0000:00:03.0: irq 20, pci mem 
e1926000
May 12 09:47:41 nihao kernel: ohci_hcd 0000:00:03.0: new USB bus 
registered, assigned bus number 1
May 12 09:47:41 nihao kernel: hub 1-0:1.0: USB hub found
May 12 09:47:41 nihao kernel: hub 1-0:1.0: 3 ports detected
May 12 09:47:41 nihao kernel: ohci_hcd 0000:00:03.1: Silicon Integrated 
Systems [SiS] USB 1.0 Controller (#2)
May 12 09:47:41 nihao kernel: ohci_hcd 0000:00:03.1: irq 21, pci mem 
e192f000
May 12 09:47:41 nihao kernel: ohci_hcd 0000:00:03.1: new USB bus 
registered, assigned bus number 2
May 12 09:47:41 nihao kernel: hub 2-0:1.0: USB hub found
May 12 09:47:41 nihao kernel: hub 2-0:1.0: 3 ports detected
May 12 09:47:41 nihao kernel: ohci_hcd 0000:00:03.2: Silicon Integrated 
Systems [SiS] USB 1.0 Controller (#3)
May 12 09:47:41 nihao kernel: ohci_hcd 0000:00:03.2: irq 22, pci mem 
e1931000
May 12 09:47:41 nihao kernel: ohci_hcd 0000:00:03.2: new USB bus 
registered, assigned bus number 3
May 12 09:47:41 nihao kernel: hub 3-0:1.0: USB hub found
May 12 09:47:41 nihao kernel: hub 3-0:1.0: 2 ports detected
May 12 09:47:41 nihao kernel: ehci_hcd 0000:00:03.3: Silicon Integrated 
Systems [SiS] USB 2.0 Controller
May 12 09:47:41 nihao kernel: ehci_hcd 0000:00:03.3: irq 23, pci mem 
e1949000
May 12 09:47:41 nihao kernel: ehci_hcd 0000:00:03.3: new USB bus 
registered, assigned bus number 4
May 12 09:47:41 nihao kernel: PCI: cache line size of 64 is not 
supported by device 0000:00:03.3
May 12 09:47:41 nihao kernel: ehci_hcd 0000:00:03.3: USB 2.0 enabled, 
EHCI 1.00, driver 2003-Dec-29
May 12 09:47:41 nihao kernel: hub 4-0:1.0: USB hub found
May 12 09:47:41 nihao kernel: hub 4-0:1.0: 8 ports detected
May 12 09:47:41 nihao kernel: i2c-sis96x version 1.0.0
May 12 09:47:41 nihao kernel: loop: loaded (max 8 devices)
May 12 09:47:41 nihao kernel: NTFS volume version 3.0.
May 12 09:47:41 nihao kernel: usb 3-2: new full speed USB device using 
address 2
May 12 09:47:41 nihao kernel: drivers/usb/class/usblp.c: usblp0: USB 
Bidirectional printer dev 2 if 0 alt 0 proto 2 vid 0x0
3F0 pid 0x7204
May 12 09:47:41 nihao kernel: usb 2-3: new low speed USB device using 
address 2
May 12 09:47:41 nihao kernel: input: USB HID v1.10 Joystick [Logitech 
WingMan Precision USB] on usb-0000:00:03.1-3
May 12 09:47:41 nihao kernel: Real Time Clock Driver v1.12
May 12 09:47:41 nihao kernel: usb 1-2: new low speed USB device using 
address 2
May 12 09:47:41 nihao kernel: drivers/usb/input/hid-core.c: ctrl urb 
status -32 received
May 12 09:47:41 nihao kernel: input: USB HID v1.11 Mouse [Microsoft 
Microsoft Wireless Optical Mouse<AE> 1.0A] on usb-0000:
00:03.0-2

hdparm -i /dev/hda

/dev/hda:

 Model=WDC WD600AB-00CBA1, FwRev=04.07B04, SerialNo=WD-WMAA61240560
 Config={ HardSect NotMFM HdSw>15uSec SpinMotCtl Fixed DTR>5Mbs FmtGapReq }
 RawCHS=16383/16/63, TrkSize=57600, SectSize=600, ECCbytes=40
 BuffType=DualPortCache, BuffSize=2048kB, MaxMultSect=16, MultSect=16
 CurCHS=4047/16/255, CurSects=16511760, LBA=yes, LBAsects=117231408
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes:  pio0 pio1 pio2 pio3 pio4
 DMA modes:  mdma0 mdma1 mdma2
 UDMA modes: udma0 udma1 udma2 udma3 udma4 *udma5
 AdvancedPM=no WriteCache=enabled
 Drive conforms to: device does not report version:

 * signifies the current active mode

hdparm  /dev/hda

/dev/hda:
 multcount    = 16 (on)
 IO_support   =  0 (default 16-bit)
 unmaskirq    =  1 (on)
 using_dma    =  1 (on)
 keepsettings =  0 (off)
 readonly     =  0 (off)
 readahead    = 256 (on)
 geometry     = 65535/16/63, sectors = 117231408, start = 0


hdparm -i /dev/hdb

/dev/hdb:

 Model=WDC WD800BB-00DKA0, FwRev=77.07W77, SerialNo=WD-WMAHL3449343
 Config={ HardSect NotMFM HdSw>15uSec SpinMotCtl Fixed DTR>5Mbs FmtGapReq }
 RawCHS=16383/16/63, TrkSize=57600, SectSize=600, ECCbytes=74
 BuffType=DualPortCache, BuffSize=2048kB, MaxMultSect=16, MultSect=16
 CurCHS=4047/16/255, CurSects=16511760, LBA=yes, LBAsects=156301488
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes:  pio0 pio1 pio2 pio3 pio4
 DMA modes:  mdma0 mdma1 mdma2
 UDMA modes: udma0 udma1 udma2 udma3 udma4 *udma5
 AdvancedPM=no WriteCache=enabled
 Drive conforms to: device does not report version:

 * signifies the current active mode

hdparm  /dev/hdb

/dev/hdb:
 multcount    = 16 (on)
 IO_support   =  0 (default 16-bit)
 unmaskirq    =  1 (on)
 using_dma    =  1 (on)
 keepsettings =  0 (off)
 readonly     =  0 (off)
 readahead    = 256 (on)
 geometry     = 16383/255/63, sectors = 156301488, start = 0



