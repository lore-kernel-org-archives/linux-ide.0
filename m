From: Andres Meyer <andres.meyer@computer.org>
Subject: Opteron SATA machine check exception (32bit)
Date: Wed, 10 Mar 2004 00:06:36 +0100
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200403100006.36405.andres.meyer@computer.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mxout.hispeed.ch ([62.2.95.247]:49892 "EHLO smtp.hispeed.ch")
	by vger.kernel.org with ESMTP id S262260AbUCIXGp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 9 Mar 2004 18:06:45 -0500
Received: from mail.cputoasters.com (217-162-15-133.dclient.hispeed.ch [217.162.15.133])
	by smtp.hispeed.ch (8.12.6/8.12.6/tornado-1.0) with ESMTP id i29N6g0W004841
	for <linux-ide@vger.kernel.org>; Wed, 10 Mar 2004 00:06:42 +0100
Received: from 192.168.0.252 (unknown [192.168.0.252])
	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(No client certificate requested)
	by mail.cputoasters.com (Postfix) with ESMTP id 927AC2FF9CB
	for <linux-ide@vger.kernel.org>; Wed, 10 Mar 2004 00:06:40 +0100 (CET)
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi,

I am trying to get an 2x Opteron system to work. As long as I use the 80GB 
Maxtor installed on the integrated IDE controller, everything works fine. As 
soon as I try to use the SATA disks, I get a machine check exception and the 
system reboots, with the hw clock reset to some silly date.

This one here happened within ca. 7s when trying to write some zeros 
(cat /dev/zero > test.file) to the first 160GB disk. On the disk, after 
reboot, there was a very small test.file.

Interesting enough, it is possible to read the disks and even do a fsck on the 
fs. It is also possible to run a script that writes a small file (eg the 
current time) every 5s or so for several days. As I found some strange 
behaviour at on port 3&4 on the siimage controller, I did not connect these 
disks for now.

Any ideas? Something I could do to help?

Andres


Serial console output:

ata1: DMA timeout
CP<U0 >0C:P UM a1c: hMianceh iChneec kC hEecxkc eEpxtcioenp:t i0on0:0 
00000000000000000
04B                                                                                   
0
nk B4a:n kb 24:0 0b020000000000070000f007f0f
f                                           0
erKneerl npealn ipca:n icC:P UC PcUon tceoxntte xcto rrcuoprtr
pt                                                            u
In interrupt handler - not syncing

SW:
Linux 2.6.4-rc2 32bit
ReiserFs 3

HW:
2x Opteron 240, 3GB RAM
Tyan 2885ANRF
AMD8111: 1x Maxtor 80GB
Promise SATA 150: 4x Maxtor 4G160J8 160GB with Marvel IDE2SATA adapters
SII3114: 4x Maxtor 7Y250M0 250GB SATA


dmesg:
Feb 29 04:56:06 localhost kernel: Linux version 2.6.4-rc2 (root@dipol) (gcc 
version 3.3.2 20031218 (Gentoo Linux 3.3.2-r5, propolice-3.3-7)) #3 SMP Mon 
Mar 8 21:08:30 CET 2004
Feb 29 04:56:06 localhost kernel: BIOS-provided physical RAM map:
Feb 29 04:56:06 localhost kernel:  BIOS-e820: 0000000000000000 - 
000000000009fc00 (usable)
Feb 29 04:56:06 localhost kernel:  BIOS-e820: 000000000009fc00 - 
00000000000a0000 (reserved)
Feb 29 04:56:06 localhost kernel:  BIOS-e820: 00000000000e0000 - 
0000000000100000 (reserved)
Feb 29 04:56:06 localhost kernel:  BIOS-e820: 0000000000100000 - 
00000000bfff0000 (usable)
Feb 29 04:56:06 localhost kernel:  BIOS-e820: 00000000bfff0000 - 
00000000bffff000 (ACPI data)
Feb 29 04:56:06 localhost kernel:  BIOS-e820: 00000000bffff000 - 
00000000c0000000 (ACPI NVS)
Feb 29 04:56:06 localhost kernel:  BIOS-e820: 00000000ff7c0000 - 
0000000100000000 (reserved)
Feb 29 04:56:06 localhost kernel: 2175MB HIGHMEM available.
Feb 29 04:56:06 localhost kernel: 896MB LOWMEM available.
Feb 29 04:56:06 localhost kernel: found SMP MP-table at 000ff780
Feb 29 04:56:06 localhost kernel: On node 0 totalpages: 786416
Feb 29 04:56:06 localhost kernel:   DMA zone: 4096 pages, LIFO batch:1
Feb 29 04:56:06 localhost kernel:   Normal zone: 225280 pages, LIFO batch:16
Feb 29 04:56:06 localhost kernel:   HighMem zone: 557040 pages, LIFO batch:16
Feb 29 04:56:06 localhost kernel: DMI 2.3 present.
Feb 29 04:56:06 localhost kernel: ACPI: RSDP (v002 
ACPIAM                                    ) @ 0x000f6740
Feb 29 04:56:06 localhost kernel: ACPI: XSDT (v001 A M I  OEMXSDT  0x01000428 
MSFT 0x00000097) @ 0xbfff0100
Feb 29 04:56:06 localhost kernel: ACPI: FADT (v001 A M I  OEMFACP  0x01000428 
MSFT 0x00000097) @ 0xbfff0281
Feb 29 04:56:06 localhost kernel: ACPI: MADT (v001 A M I  OEMAPIC  0x01000428 
MSFT 0x00000097) @ 0xbfff0380
Feb 29 04:56:06 localhost kernel: ACPI: OEMB (v001 A M I  OEMBIOS  0x01000428 
MSFT 0x00000097) @ 0xbffff040
Feb 29 04:56:06 localhost kernel: ACPI: SRAT (v001 A M I  OEMSRAT  0x01000428 
MSFT 0x00000097) @ 0xbfff39f0
Feb 29 04:56:06 localhost kernel: ACPI: ASF! (v001 AMIASF AMDSTRET 0x00000001 
INTL 0x02002026) @ 0xbfff3ae0
Feb 29 04:56:06 localhost kernel: ACPI: DSDT (v001  0ABCF 0ABCF007 0x00000007 
INTL 0x02002026) @ 0x00000000
Feb 29 04:56:06 localhost kernel: ACPI: Local APIC address 0xfee00000
Feb 29 04:56:06 localhost kernel: ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] 
enabled)
Feb 29 04:56:06 localhost kernel: Processor #0 15:5 APIC version 16
Feb 29 04:56:06 localhost kernel: ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] 
enabled)
Feb 29 04:56:06 localhost kernel: Processor #1 15:5 APIC version 16
Feb 29 04:56:06 localhost kernel: Using ACPI for processor (LAPIC) 
configuration information
Feb 29 04:56:06 localhost kernel: Intel MultiProcessor Specification v1.4
Feb 29 04:56:06 localhost kernel:     Virtual Wire compatibility mode.
Feb 29 04:56:06 localhost kernel: OEM ID: TYAN     Product ID: S2885        
APIC at: 0xFEE00000
Feb 29 04:56:06 localhost kernel: I/O APIC #2 Version 17 at 0xFEC00000.
Feb 29 04:56:06 localhost kernel: I/O APIC #3 Version 17 at 0xFF4FF000.
Feb 29 04:56:06 localhost kernel: I/O APIC #4 Version 17 at 0xFF4FE000.
Feb 29 04:56:06 localhost kernel: Enabling APIC mode:  Flat.  Using 3 I/O 
APICs
Feb 29 04:56:06 localhost kernel: Processors: 2
Feb 29 04:56:06 localhost kernel: Built 1 zonelists
Feb 29 04:56:06 localhost kernel: Kernel command line: root=/dev/hdc5 
console=tty0 console=ttyS0,9600n8
Feb 29 04:56:06 localhost kernel: Initializing CPU#0
Feb 29 04:56:06 localhost kernel: PID hash table entries: 4096 (order 12: 
32768 bytes)
Feb 29 04:56:06 localhost kernel: Detected 1394.263 MHz processor.
Feb 29 04:56:06 localhost kernel: Using tsc for high-res timesource
Feb 29 04:56:06 localhost kernel: Console: colour VGA+ 80x25
Feb 29 04:56:06 localhost kernel: Memory: 3107824k/3145664k available (3092k 
kernel code, 36720k reserved, 1035k data, 184k init, 2228160k highmem)
Feb 29 04:56:06 localhost kernel: Checking if this processor honours the WP 
bit even in supervisor mode... Ok.
Feb 29 04:56:06 localhost kernel: Calibrating delay loop... 2736.12 BogoMIPS
Feb 29 04:56:06 localhost kernel: Dentry cache hash table entries: 524288 
(order: 9, 2097152 bytes)
Feb 29 04:56:06 localhost kernel: Inode-cache hash table entries: 262144 
(order: 8, 1048576 bytes)
Feb 29 04:56:06 localhost kernel: Mount-cache hash table entries: 512 (order: 
0, 4096 bytes)
Feb 29 04:56:06 localhost kernel: CPU:     After generic identify, caps: 
078bfbff e1d3fbff 00000000 00000000
Feb 29 04:56:06 localhost kernel: CPU:     After vendor identify, caps: 
078bfbff e1d3fbff 00000000 00000000
Feb 29 04:56:06 localhost kernel: CPU: L1 I Cache: 64K (64 bytes/line), D 
cache 64K (64 bytes/line)
Feb 29 04:56:06 localhost kernel: CPU: L2 Cache: 1024K (64 bytes/line)
Feb 29 04:56:06 localhost kernel: CPU:     After all inits, caps: 078bfbf7 
e1d3fbff 00000000 00000010
Feb 29 04:56:06 localhost kernel: Intel machine check architecture supported.
Feb 29 04:56:06 localhost kernel: Intel machine check reporting enabled on 
CPU#0.
Feb 29 04:56:06 localhost kernel: Enabling fast FPU save and restore... done.
Feb 29 04:56:06 localhost kernel: Enabling unmasked SIMD FPU exception 
support... done.
Feb 29 04:56:06 localhost kernel: Checking 'hlt' instruction... OK.
Feb 29 04:56:06 localhost kernel: POSIX conformance testing by UNIFIX
Feb 29 04:56:06 localhost kernel: CPU0: AMD Opteron(tm) Processor 240 stepping 
01
Feb 29 04:56:06 localhost kernel: per-CPU timeslice cutoff: 2925.00 usecs.
Feb 29 04:56:06 localhost kernel: task migration cache decay timeout: 3 msecs.
Feb 29 04:56:06 localhost kernel: enabled ExtINT on CPU#0
Feb 29 04:56:06 localhost kernel: ESR value before enabling vector: 00000004
Feb 29 04:56:06 localhost kernel: ESR value after enabling vector: 00000000
Feb 29 04:56:06 localhost kernel: Booting processor 1/1 eip 2000
Feb 29 04:56:06 localhost kernel: Initializing CPU#1
Feb 29 04:56:06 localhost kernel: masked ExtINT on CPU#1
Feb 29 04:56:06 localhost kernel: ESR value before enabling vector: 00000000
Feb 29 04:56:06 localhost kernel: ESR value after enabling vector: 00000000
Feb 29 04:56:06 localhost kernel: Calibrating delay loop... 2785.28 BogoMIPS
Feb 29 04:56:06 localhost kernel: CPU:     After generic identify, caps: 
078bfbff e1d3fbff 00000000 00000000
Feb 29 04:56:06 localhost kernel: CPU:     After vendor identify, caps: 
078bfbff e1d3fbff 00000000 00000000
Feb 29 04:56:06 localhost kernel: CPU: L1 I Cache: 64K (64 bytes/line), D 
cache 64K (64 bytes/line)
Feb 29 04:56:06 localhost kernel: CPU: L2 Cache: 1024K (64 bytes/line)
Feb 29 04:56:06 localhost kernel: CPU:     After all inits, caps: 078bfbf7 
e1d3fbff 00000000 00000010
Feb 29 04:56:06 localhost kernel: Intel machine check architecture supported.
Feb 29 04:56:06 localhost kernel: Intel machine check reporting enabled on 
CPU#1.
Feb 29 04:56:06 localhost kernel: CPU1: AMD Opteron(tm) Processor 240 stepping 
01
Feb 29 04:56:06 localhost kernel: Total of 2 processors activated (5521.40 
BogoMIPS).
Feb 29 04:56:06 localhost kernel: ENABLING IO-APIC IRQs
Feb 29 04:56:06 localhost kernel: Setting 2 in the phys_id_present_map
Feb 29 04:56:06 localhost kernel: ...changing IO-APIC physical APIC ID to 
2 ... ok.
Feb 29 04:56:06 localhost kernel: Setting 3 in the phys_id_present_map
Feb 29 04:56:06 localhost kernel: ...changing IO-APIC physical APIC ID to 
3 ... ok.
Feb 29 04:56:06 localhost kernel: Setting 4 in the phys_id_present_map
Feb 29 04:56:06 localhost kernel: ...changing IO-APIC physical APIC ID to 
4 ... ok.
Feb 29 04:56:06 localhost kernel: init IO_APIC IRQs
Feb 29 04:56:06 localhost kernel:  IO-APIC (apicid-pin) 2-0, 2-9, 2-10, 2-11, 
2-18, 2-20, 2-21, 2-22, 2-23, 3-1, 3-2, 3-3, 4-2, 4-3 not connected.
Feb 29 04:56:06 localhost kernel: ..TIMER: vector=0x31 pin1=2 pin2=0
Feb 29 04:56:06 localhost kernel: number of MP IRQ sources: 23.
Feb 29 04:56:06 localhost kernel: number of IO-APIC #2 registers: 24.
Feb 29 04:56:06 localhost kernel: number of IO-APIC #3 registers: 4.
Feb 29 04:56:06 localhost kernel: number of IO-APIC #4 registers: 4.
Feb 29 04:56:06 localhost kernel: testing the IO APIC.......................
Feb 29 04:56:06 localhost kernel: IO APIC #2......
Feb 29 04:56:06 localhost kernel: .... register #00: 02000000
Feb 29 04:56:06 localhost kernel: .......    : physical APIC id: 02
Feb 29 04:56:06 localhost kernel: .......    : Delivery Type: 0
Feb 29 04:56:06 localhost kernel: .......    : LTS          : 0
Feb 29 04:56:06 localhost kernel: .... register #01: 00170011
Feb 29 04:56:06 localhost kernel: .......     : max redirection entries: 0017
Feb 29 04:56:06 localhost kernel: .......     : PRQ implemented: 0
Feb 29 04:56:06 localhost kernel: .......     : IO APIC version: 0011
Feb 29 04:56:06 localhost kernel: .... register #02: 02000000
Feb 29 04:56:06 localhost kernel: .......     : arbitration: 02
Feb 29 04:56:06 localhost kernel: .... IRQ redirection table:
Feb 29 04:56:06 localhost kernel:  NR Log Phy Mask Trig IRR Pol Stat Dest Deli 
Vect:
Feb 29 04:56:06 localhost kernel:  00 000 00  1    0    0   0   0    0    0    
00
Feb 29 04:56:06 localhost kernel:  01 001 01  0    0    0   0   0    1    1    
39
Feb 29 04:56:06 localhost kernel:  02 001 01  0    0    0   0   0    1    1    
31
Feb 29 04:56:06 localhost kernel:  03 001 01  0    0    0   0   0    1    1    
41
Feb 29 04:56:06 localhost kernel:  04 001 01  0    0    0   0   0    1    1    
49
Feb 29 04:56:06 localhost kernel:  05 001 01  0    0    0   0   0    1    1    
51
Feb 29 04:56:06 localhost kernel:  06 001 01  0    0    0   0   0    1    1    
59
Feb 29 04:56:06 localhost kernel:  07 001 01  0    0    0   0   0    1    1    
61
Feb 29 04:56:06 localhost kernel:  08 001 01  0    0    0   0   0    1    1    
69
Feb 29 04:56:06 localhost kernel:  09 000 00  1    0    0   0   0    0    0    
00
Feb 29 04:56:06 localhost kernel:  0a 000 00  1    0    0   0   0    0    0    
00
Feb 29 04:56:06 localhost kernel:  0b 000 00  1    0    0   0   0    0    0    
00
Feb 29 04:56:06 localhost kernel:  0c 001 01  0    0    0   0   0    1    1    
71
Feb 29 04:56:06 localhost kernel:  0d 001 01  0    0    0   0   0    1    1    
79
Feb 29 04:56:06 localhost kernel:  0e 001 01  0    0    0   0   0    1    1    
81
Feb 29 04:56:06 localhost kernel:  0f 001 01  0    0    0   0   0    1    1    
89
Feb 29 04:56:06 localhost kernel:  10 001 01  1    1    0   1   0    1    1    
91
Feb 29 04:56:06 localhost kernel:  11 001 01  1    1    0   1   0    1    1    
99
Feb 29 04:56:06 localhost kernel:  12 000 00  1    0    0   0   0    0    0    
00
Feb 29 04:56:06 localhost kernel:  13 001 01  1    1    0   1   0    1    1    
A1
Feb 29 04:56:06 localhost kernel:  14 000 00  1    0    0   0   0    0    0    
00
Feb 29 04:56:06 localhost kernel:  15 000 00  1    0    0   0   0    0    0    
00
Feb 29 04:56:06 localhost kernel:  16 000 00  1    0    0   0   0    0    0    
00
Feb 29 04:56:06 localhost kernel:  17 000 00  1    0    0   0   0    0    0    
00
Feb 29 04:56:06 localhost kernel: IO APIC #3......
Feb 29 04:56:06 localhost kernel: .... register #00: 03000000
Feb 29 04:56:06 localhost kernel: .......    : physical APIC id: 03
Feb 29 04:56:06 localhost kernel: .......    : Delivery Type: 0
Feb 29 04:56:06 localhost kernel: .......    : LTS          : 0
Feb 29 04:56:06 localhost kernel: .... register #01: 00030011
Feb 29 04:56:06 localhost kernel: .......     : max redirection entries: 0003
Feb 29 04:56:06 localhost kernel: .......     : PRQ implemented: 0
Feb 29 04:56:06 localhost kernel: .......     : IO APIC version: 0011
Feb 29 04:56:06 localhost kernel: .... register #02: 00000000
Feb 29 04:56:06 localhost kernel: .......     : arbitration: 00
Feb 29 04:56:06 localhost kernel: .... IRQ redirection table:
Feb 29 04:56:06 localhost kernel:  NR Log Phy Mask Trig IRR Pol Stat Dest Deli 
Vect:
Feb 29 04:56:06 localhost kernel:  00 001 01  1    1    0   1   0    1    1    
A9
Feb 29 04:56:06 localhost kernel:  01 000 00  1    0    0   0   0    0    0    
00
Feb 29 04:56:06 localhost kernel:  02 000 00  1    0    0   0   0    0    0    
00
Feb 29 04:56:06 localhost kernel:  03 000 00  1    0    0   0   0    0    0    
00
Feb 29 04:56:06 localhost kernel: IO APIC #4......
Feb 29 04:56:06 localhost kernel: .... register #00: 04000000
Feb 29 04:56:06 localhost kernel: .......    : physical APIC id: 04
Feb 29 04:56:06 localhost kernel: .......    : Delivery Type: 0
Feb 29 04:56:06 localhost kernel: .......    : LTS          : 0
Feb 29 04:56:06 localhost kernel: .... register #01: 00030011
Feb 29 04:56:06 localhost kernel: .......     : max redirection entries: 0003
Feb 29 04:56:06 localhost kernel: .......     : PRQ implemented: 0
Feb 29 04:56:06 localhost kernel: .......     : IO APIC version: 0011
Feb 29 04:56:06 localhost kernel: .... register #02: 00000000
Feb 29 04:56:06 localhost kernel: .......     : arbitration: 00
Feb 29 04:56:06 localhost kernel: .... IRQ redirection table:
Feb 29 04:56:06 localhost kernel:  NR Log Phy Mask Trig IRR Pol Stat Dest Deli 
Vect:
Feb 29 04:56:06 localhost kernel:  00 001 01  1    1    0   1   0    1    1    
B1
Feb 29 04:56:06 localhost kernel:  01 001 01  1    1    0   1   0    1    1    
B9
Feb 29 04:56:06 localhost kernel:  02 000 00  1    0    0   0   0    0    0    
00
Feb 29 04:56:06 localhost kernel:  03 000 00  1    0    0   0   0    0    0    
00
Feb 29 04:56:06 localhost kernel: IRQ to pin mappings:
Feb 29 04:56:06 localhost kernel: IRQ0 -> 0:2
Feb 29 04:56:06 localhost kernel: IRQ1 -> 0:1
Feb 29 04:56:06 localhost kernel: IRQ3 -> 0:3
Feb 29 04:56:06 localhost kernel: IRQ4 -> 0:4
Feb 29 04:56:06 localhost kernel: IRQ5 -> 0:5
Feb 29 04:56:06 localhost kernel: IRQ6 -> 0:6
Feb 29 04:56:06 localhost kernel: IRQ7 -> 0:7
Feb 29 04:56:06 localhost kernel: IRQ8 -> 0:8
Feb 29 04:56:06 localhost kernel: IRQ12 -> 0:12
Feb 29 04:56:06 localhost kernel: IRQ13 -> 0:13
Feb 29 04:56:06 localhost kernel: IRQ14 -> 0:14
Feb 29 04:56:06 localhost kernel: IRQ15 -> 0:15
Feb 29 04:56:06 localhost kernel: IRQ16 -> 0:16
Feb 29 04:56:06 localhost kernel: IRQ17 -> 0:17
Feb 29 04:56:06 localhost kernel: IRQ19 -> 0:19
Feb 29 04:56:06 localhost kernel: IRQ24 -> 1:0
Feb 29 04:56:06 localhost kernel: IRQ28 -> 2:0
Feb 29 04:56:06 localhost kernel: IRQ29 -> 2:1
Feb 29 04:56:06 localhost kernel: .................................... done.
Feb 29 04:56:06 localhost kernel: Using local APIC timer interrupts.
Feb 29 04:56:06 localhost kernel: calibrating APIC timer ...
Feb 29 04:56:06 localhost kernel: ..... CPU clock speed is 1393.0798 MHz.
Feb 29 04:56:06 localhost kernel: ..... host bus clock speed is 199.0114 MHz.
Feb 29 04:56:06 localhost kernel: checking TSC synchronization across 2 CPUs: 
passed.
Feb 29 04:56:06 localhost kernel: Brought up 2 CPUs
Feb 29 04:56:06 localhost kernel: NET: Registered protocol family 16
Feb 29 04:56:06 localhost kernel: PCI: PCI BIOS revision 2.10 entry at 
0xf0031, last bus=5
Feb 29 04:56:06 localhost kernel: PCI: Using configuration type 1
Feb 29 04:56:06 localhost kernel: SCSI subsystem initialized
Feb 29 04:56:06 localhost kernel: drivers/usb/core/usb.c: registered new 
driver usbfs
Feb 29 04:56:06 localhost kernel: drivers/usb/core/usb.c: registered new 
driver hub
Feb 29 04:56:06 localhost kernel: PCI: Probing PCI hardware
Feb 29 04:56:06 localhost kernel: PCI: Probing PCI hardware (bus 00)
Feb 29 04:56:06 localhost kernel: PCI: Discovered peer bus 04
Feb 29 04:56:06 localhost kernel: PCI: Using IRQ router default [1022/746b] at 
0000:00:07.3
Feb 29 04:56:06 localhost kernel: PCI->APIC IRQ transform: (B0,I7,P3) -> 19
Feb 29 04:56:06 localhost kernel: PCI->APIC IRQ transform: (B0,I7,P1) -> 17
Feb 29 04:56:06 localhost kernel: PCI->APIC IRQ transform: (B1,I0,P3) -> 19
Feb 29 04:56:06 localhost kernel: PCI->APIC IRQ transform: (B1,I0,P3) -> 19
Feb 29 04:56:06 localhost kernel: PCI->APIC IRQ transform: (B1,I10,P0) -> 16
Feb 29 04:56:06 localhost kernel: PCI->APIC IRQ transform: (B1,I11,P0) -> 17
Feb 29 04:56:06 localhost kernel: PCI->APIC IRQ transform: (B1,I12,P0) -> 19
Feb 29 04:56:06 localhost kernel: PCI->APIC IRQ transform: (B2,I9,P0) -> 24
Feb 29 04:56:06 localhost kernel: PCI->APIC IRQ transform: (B3,I3,P0) -> 28
Feb 29 04:56:06 localhost kernel: PCI->APIC IRQ transform: (B3,I6,P0) -> 29
Feb 29 04:56:06 localhost kernel: PCI->APIC IRQ transform: (B5,I0,P0) -> 16
Feb 29 04:56:06 localhost kernel: Machine check exception polling timer 
started.
Feb 29 04:56:06 localhost kernel: ikconfig 0.7 with /proc/config*
Feb 29 04:56:06 localhost kernel: highmem bounce pool size: 64 pages
Feb 29 04:56:06 localhost kernel: devfs: 2004-01-31 Richard Gooch 
(rgooch@atnf.csiro.au)
Feb 29 04:56:06 localhost kernel: devfs: boot_options: 0x1
Feb 29 04:56:06 localhost kernel: Initializing Cryptographic API
Feb 29 04:56:06 localhost kernel: Real Time Clock Driver v1.12
Feb 29 04:56:06 localhost kernel: hw_random: AMD768 system management I/O 
registers at 0x5000.
Feb 29 04:56:06 localhost kernel: hw_random hardware driver 1.0.0 loaded
Feb 29 04:56:06 localhost kernel: Linux agpgart interface v0.100 (c) Dave 
Jones
Feb 29 04:56:06 localhost kernel: agpgart: Detected AMD 8151 AGP Bridge rev B2
Feb 29 04:56:06 localhost kernel: agpgart: Maximum main memory to use for agp 
memory: 2925M
Feb 29 04:56:06 localhost kernel: agpgart: AGP aperture is 128M @ 0xf0000000
Feb 29 04:56:06 localhost kernel: [drm] Initialized radeon 1.9.0 20020828 on 
minor 0
Feb 29 04:56:06 localhost kernel: Serial: 8250/16550 driver $Revision: 1.90 $ 
8 ports, IRQ sharing disabled
Feb 29 04:56:06 localhost kernel: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Feb 29 04:56:06 localhost kernel: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
Feb 29 04:56:06 localhost kernel: RAMDISK driver initialized: 16 RAM disks of 
4096K size 1024 blocksize
Feb 29 04:56:06 localhost kernel: loop: loaded (max 8 devices)
Feb 29 04:56:06 localhost kernel: Intel(R) PRO/1000 Network Driver - version 
5.2.30.1-k2
Feb 29 04:56:06 localhost kernel: Copyright (c) 1999-2004 Intel Corporation.
Feb 29 04:56:06 localhost kernel: eth0: Intel(R) PRO/1000 Network Connection
Feb 29 04:56:06 localhost kernel: ns83820.c: National Semiconductor DP83820 
10/100/1000 driver.
Feb 29 04:56:06 localhost kernel: tg3.c:v2.8 (February 23, 2004)
Feb 29 04:56:06 localhost kernel: eth1: Tigon3 [partno(BCM95703A30) rev 1002 
PHY(5703)] (PCIX:100MHz:64-bit) 10/100/1000BaseT Ethernet 00:e0:81:27:a1:5f
Feb 29 04:56:06 localhost kernel: Universal TUN/TAP device driver 1.5 (C)
1999-2002 Maxim Krasnyansky
Feb 29 04:56:06 localhost kernel: Linux video capture interface: v1.00
Feb 29 04:56:06 localhost kernel: Uniform Multi-Platform E-IDE driver 
Revision: 7.00alpha2
Feb 29 04:56:06 localhost kernel: ide: Assuming 33MHz system bus speed for PIO 
modes; override with idebus=xx
Feb 29 04:56:06 localhost kernel: AMD8111: IDE controller at PCI slot 
0000:00:07.1
Feb 29 04:56:06 localhost kernel: AMD8111: chipset revision 3
Feb 29 04:56:06 localhost kernel: AMD8111: not 100%% native mode: will probe 
irqs later
Feb 29 04:56:06 localhost kernel: AMD8111: 0000:00:07.1 (rev 03) UDMA133 
controller
Feb 29 04:56:06 localhost kernel:     ide0: BM-DMA at 0xffa0-0xffa7, BIOS 
settings: hda:DMA, hdb:pio
Feb 29 04:56:06 localhost kernel:     ide1: BM-DMA at 0xffa8-0xffaf, BIOS 
settings: hdc:DMA, hdd:pio
Feb 29 04:56:06 localhost kernel: hda: Pioneer DVD-ROM ATAPIModel DVD-120S, 
ATAPI CD/DVD-ROM drive
Feb 29 04:56:06 localhost kernel: Using anticipatory io scheduler
Feb 29 04:56:06 localhost kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Feb 29 04:56:06 localhost kernel: hdc: Maxtor 4D080H4, ATA DISK drive
Feb 29 04:56:06 localhost kernel: ide1 at 0x170-0x177,0x376 on irq 15
Feb 29 04:56:06 localhost kernel: hdc: max request size: 128KiB
Feb 29 04:56:06 localhost kernel: hdc: 160086528 sectors (81964 MB) w/2048KiB 
Cache, CHS=65535/16/63, UDMA(100)
Feb 29 04:56:06 localhost kernel:  /dev/ide/host0/bus1/target0/lun0: p1 p2 < 
p5 p6 p7 p8 p9 >
Feb 29 04:56:06 localhost kernel: hda: ATAPI 126X DVD-ROM drive, 256kB Cache, 
UDMA(66)
Feb 29 04:56:06 localhost kernel: Uniform CD-ROM driver Revision: 3.20
Feb 29 04:56:06 localhost kernel: libata version 1.01 loaded.
Feb 29 04:56:06 localhost kernel: sata_promise version 0.90
Feb 29 04:56:06 localhost kernel: ata1: SATA max UDMA/133 cmd 0xF885C200 ctl 
0xF885C238 bmdma 0x0 irq 29
Feb 29 04:56:06 localhost kernel: ata2: SATA max UDMA/133 cmd 0xF885C280 ctl 
0xF885C2B8 bmdma 0x0 irq 29
Feb 29 04:56:06 localhost kernel: ata3: SATA max UDMA/133 cmd 0xF885C300 ctl 
0xF885C338 bmdma 0x0 irq 29
Feb 29 04:56:06 localhost kernel: ata4: SATA max UDMA/133 cmd 0xF885C380 ctl 
0xF885C3B8 bmdma 0x0 irq 29
Feb 29 04:56:06 localhost kernel: ata1: dev 0 cfg 49:2f00 82:7c69 83:4f09 
84:4003 85:7c69 86:0e01 87:4003 88:207f
Feb 29 04:56:06 localhost kernel: ata1: dev 0 ATA, max UDMA/133, 320173056 
sectors (lba48)
Feb 29 04:56:06 localhost kernel: ata1: dev 0 configured for UDMA/133
Feb 29 04:56:06 localhost kernel: scsi0 : sata_promise
Feb 29 04:56:06 localhost kernel: ata2 is slow to respond, please be patient
Feb 29 04:56:06 localhost kernel: ata2 failed to respond (30 secs)
Feb 29 04:56:06 localhost kernel: ata2: thread exiting
Feb 29 04:56:06 localhost kernel: scsi1 : sata_promise
Feb 29 04:56:06 localhost kernel: ata3: dev 0 cfg 49:2f00 82:7c69 83:4f09 
84:4003 85:7c69 86:0e01 87:4003 88:207f
Feb 29 04:56:06 localhost kernel: ata3: dev 0 ATA, max UDMA/133, 320173056 
sectors (lba48)
Feb 29 04:56:06 localhost kernel: ata3: dev 0 configured for UDMA/133
Feb 29 04:56:06 localhost kernel: scsi2 : sata_promise
Feb 29 04:56:06 localhost kernel: ata4: dev 0 cfg 49:2f00 82:7c69 83:4f09 
84:4003 85:7c69 86:0e01 87:4003 88:207f
Feb 29 04:56:06 localhost kernel: ata4: dev 0 ATA, max UDMA/133, 320173056 
sectors (lba48)
Feb 29 04:56:06 localhost kernel: ata4: dev 0 configured for UDMA/133
Feb 29 04:56:06 localhost kernel: scsi3 : sata_promise
Feb 29 04:56:06 localhost kernel:   Vendor: ATA       Model: Maxtor 4G160J8    
Rev: 1.01
Feb 29 04:56:06 localhost kernel:   Type:   Direct-Access                      
ANSI SCSI revision: 05
Feb 29 04:56:06 localhost kernel:   Vendor: ATA       Model: Maxtor 4G160J8    
Rev: 1.01
Feb 29 04:56:06 localhost kernel:   Type:   Direct-Access                      
ANSI SCSI revision: 05
Feb 29 04:56:06 localhost kernel:   Vendor: ATA       Model: Maxtor 4G160J8    
Rev: 1.01
Feb 29 04:56:06 localhost kernel:   Type:   Direct-Access                      
ANSI SCSI revision: 05
Feb 29 04:56:06 localhost kernel: sata_sil version 0.53
Feb 29 04:56:06 localhost kernel: ata5: SATA max UDMA/133 cmd 0xF885EC80 ctl 
0xF885EC8A bmdma 0xF885EC00 irq 17
Feb 29 04:56:06 localhost kernel: ata6: SATA max UDMA/133 cmd 0xF885ECC0 ctl 
0xF885ECCA bmdma 0xF885EC08 irq 17
Feb 29 04:56:06 localhost kernel: ata7: SATA max UDMA/133 cmd 0xF885EE80 ctl 
0xF885EE8A bmdma 0xF885EE00 irq 17
Feb 29 04:56:06 localhost kernel: ata8: SATA max UDMA/133 cmd 0xF885EEC0 ctl 
0xF885EECA bmdma 0xF885EE08 irq 17
Feb 29 04:56:06 localhost kernel: ata5: dev 0 cfg 49:2f00 82:7c6b 83:7f09 
84:4003 85:7c69 86:3e01 87:4003 88:407f
Feb 29 04:56:06 localhost kernel: ata5: dev 0 ATA, max UDMA/133, 490234752 
sectors (lba48)
Feb 29 04:56:06 localhost kernel: ata5: dev 0 configured for UDMA/133
Feb 29 04:56:06 localhost kernel: scsi4 : sata_sil
Feb 29 04:56:06 localhost kernel: ata6: dev 0 cfg 49:2f00 82:7c6b 83:7f09 
84:4003 85:7c69 86:3e01 87:4003 88:407f
Feb 29 04:56:06 localhost kernel: ata6: dev 0 ATA, max UDMA/133, 490234752 
sectors (lba48)
Feb 29 04:56:06 localhost kernel: ata6: dev 0 configured for UDMA/133
Feb 29 04:56:06 localhost kernel: scsi5 : sata_sil
Feb 29 04:56:06 localhost kernel: ata7: no device found (phy stat 00000000)
Feb 29 04:56:06 localhost kernel: ata7: thread exiting
Feb 29 04:56:06 localhost kernel: scsi6 : sata_sil
Feb 29 04:56:06 localhost kernel: ata8: no device found (phy stat 00000000)
Feb 29 04:56:06 localhost kernel: ata8: thread exiting
Feb 29 04:56:06 localhost kernel: scsi7 : sata_sil
Feb 29 04:56:06 localhost kernel:   Vendor: ATA       Model: Maxtor 7Y250M0    
Rev: 1.01
Feb 29 04:56:06 localhost kernel:   Type:   Direct-Access                      
ANSI SCSI revision: 05
Feb 29 04:56:06 localhost kernel:   Vendor: ATA       Model: Maxtor 7Y250M0    
Rev: 1.01
Feb 29 04:56:06 localhost kernel:   Type:   Direct-Access                      
ANSI SCSI revision: 05
Feb 29 04:56:06 localhost kernel: SCSI device sda: 320173056 512-byte hdwr 
sectors (163929 MB)
Feb 29 04:56:06 localhost kernel: SCSI device sda: drive cache: write through
Feb 29 04:56:06 localhost kernel:  /dev/scsi/host0/bus0/target0/lun0: p1 < p5 
>
Feb 29 04:56:06 localhost kernel: Attached scsi disk sda at scsi0, channel 0, 
id 0, lun 0
Feb 29 04:56:06 localhost kernel: SCSI device sdb: 320173056 512-byte hdwr 
sectors (163929 MB)
Feb 29 04:56:06 localhost kernel: SCSI device sdb: drive cache: write through
Feb 29 04:56:06 localhost kernel:  /dev/scsi/host2/bus0/target0/lun0: p1 < p5 
>
Feb 29 04:56:06 localhost kernel: Attached scsi disk sdb at scsi2, channel 0, 
id 0, lun 0
Feb 29 04:56:06 localhost kernel: SCSI device sdc: 320173056 512-byte hdwr 
sectors (163929 MB)
Feb 29 04:56:06 localhost kernel: SCSI device sdc: drive cache: write through
Feb 29 04:56:06 localhost kernel:  /dev/scsi/host3/bus0/target0/lun0: p1 < p5 
>
Feb 29 04:56:06 localhost kernel: Attached scsi disk sdc at scsi3, channel 0, 
id 0, lun 0
Feb 29 04:56:06 localhost kernel: SCSI device sdd: 490234752 512-byte hdwr 
sectors (251000 MB)
Feb 29 04:56:06 localhost kernel: SCSI device sdd: drive cache: write through
Feb 29 04:56:06 localhost kernel:  /dev/scsi/host4/bus0/target0/lun0: p1 < p5 
>
Feb 29 04:56:06 localhost kernel: Attached scsi disk sdd at scsi4, channel 0, 
id 0, lun 0
Feb 29 04:56:06 localhost kernel: SCSI device sde: 490234752 512-byte hdwr 
sectors (251000 MB)
Feb 29 04:56:06 localhost kernel: SCSI device sde: drive cache: write through
Feb 29 04:56:06 localhost kernel:  /dev/scsi/host5/bus0/target0/lun0: p1 < p5 
>
Feb 29 04:56:06 localhost kernel: Attached scsi disk sde at scsi5, channel 0, 
id 0, lun 0
Feb 29 04:56:06 localhost kernel: Attached scsi generic sg0 at scsi0, channel 
0, id 0, lun 0,  type 0
Feb 29 04:56:06 localhost kernel: Attached scsi generic sg1 at scsi2, channel 
0, id 0, lun 0,  type 0
Feb 29 04:56:06 localhost kernel: Attached scsi generic sg2 at scsi3, channel 
0, id 0, lun 0,  type 0
Feb 29 04:56:06 localhost kernel: Attached scsi generic sg3 at scsi4, channel 
0, id 0, lun 0,  type 0
Feb 29 04:56:06 localhost kernel: Attached scsi generic sg4 at scsi5, channel 
0, id 0, lun 0,  type 0
Feb 29 04:56:06 localhost kernel: ohci1394: $Rev: 1172 $ Ben Collins 
<bcollins@debian.org>
Feb 29 04:56:06 localhost kernel: ohci1394: fw-host0: OHCI-1394 1.1 (PCI): 
IRQ=[19]  MMIO=[ff0fd000-ff0fd7ff]  Max Packet=[2048]
Feb 29 04:56:06 localhost kernel: video1394: Installed video1394 module
Feb 29 04:56:06 localhost kernel: ieee1394: raw1394: /dev/raw1394 device 
initialized
Feb 29 04:56:06 localhost kernel: sbp2: $Rev: 1170 $ Ben Collins 
<bcollins@debian.org>
Feb 29 04:56:06 localhost kernel: ieee1394: Loaded CMP driver
Feb 29 04:56:06 localhost kernel: ohci_hcd: 2004 Feb 02 USB 1.1 'Open' Host 
Controller (OHCI) Driver (PCI)
Feb 29 04:56:06 localhost kernel: ohci_hcd: block sizes: ed 64 td 64
Feb 29 04:56:06 localhost kernel: ohci_hcd 0000:01:00.0: OHCI Host Controller
Feb 29 04:56:06 localhost kernel: ohci_hcd 0000:01:00.0: irq 19, pci mem 
f886e000
Feb 29 04:56:06 localhost kernel: ohci_hcd 0000:01:00.0: new USB bus 
registered, assigned bus number 1
Feb 29 04:56:06 localhost kernel: hub 1-0:1.0: USB hub found
Feb 29 04:56:06 localhost kernel: hub 1-0:1.0: 3 ports detected
Feb 29 04:56:06 localhost kernel: ohci_hcd 0000:01:00.1: OHCI Host Controller
Feb 29 04:56:06 localhost kernel: ohci_hcd 0000:01:00.1: irq 19, pci mem 
f8870000
Feb 29 04:56:06 localhost kernel: ohci_hcd 0000:01:00.1: new USB bus 
registered, assigned bus number 2
Feb 29 04:56:06 localhost kernel: hub 2-0:1.0: USB hub found
Feb 29 04:56:06 localhost kernel: hub 2-0:1.0: 3 ports detected
Feb 29 04:56:06 localhost kernel: mice: PS/2 mouse device common for all mice
Feb 29 04:56:06 localhost kernel: serio: i8042 AUX port at 0x60,0x64 irq 12
Feb 29 04:56:06 localhost kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
Feb 29 04:56:06 localhost kernel: i2c /dev entries driver
Feb 29 04:56:06 localhost kernel: Advanced Linux Sound Architecture Driver 
Version 1.0.2c (Thu Feb 05 15:41:49 2004 UTC).
Feb 29 04:56:06 localhost kernel: usb 2-3: new full speed USB device using 
address 2
Feb 29 04:56:06 localhost kernel: ieee1394: Host added: ID:BUS[0-00:1023]  
GUID[00e0810000300b5c]
Feb 29 04:56:06 localhost kernel: hub 2-3:1.0: USB hub found
Feb 29 04:56:06 localhost kernel: hub 2-3:1.0: 4 ports detected
Feb 29 04:56:06 localhost kernel: AC'97 0 analog subsections not ready
Feb 29 04:56:06 localhost kernel: intel8x0_measure_ac97_clock: measured 49028 
usecs
Feb 29 04:56:06 localhost kernel: intel8x0: clocking to 48000
Feb 29 04:56:06 localhost kernel: usb 2-3.1: new full speed USB device using 
address 3
Feb 29 04:56:06 localhost kernel: hub 2-3.1:1.0: USB hub found
Feb 29 04:56:06 localhost kernel: hub 2-3.1:1.0: 4 ports detected
Feb 29 04:56:06 localhost kernel: ALSA device list:
Feb 29 04:56:06 localhost kernel:   #0: AMD AMD8111 at 0xa800, irq 17
Feb 29 04:56:06 localhost kernel: NET: Registered protocol family 2
Feb 29 04:56:06 localhost kernel: IP: routing cache hash table of 16384 
buckets, 256Kbytes
Feb 29 04:56:06 localhost kernel: usb 2-3.3: new full speed USB device using 
address 4
Feb 29 04:56:06 localhost kernel: hub 2-3.3:1.0: USB hub found
Feb 29 04:56:06 localhost kernel: hub 2-3.3:1.0: 4 ports detected
Feb 29 04:56:06 localhost kernel: TCP: Hash tables configured (established 
262144 bind 43690)
Feb 29 04:56:06 localhost kernel: IPv4 over IPv4 tunneling driver
Feb 29 04:56:06 localhost kernel: NET: Registered protocol family 1
Feb 29 04:56:06 localhost kernel: NET: Registered protocol family 10
Feb 29 04:56:06 localhost kernel: IPv6 over IPv4 tunneling driver
Feb 29 04:56:06 localhost kernel: NET: Registered protocol family 17
Feb 29 04:56:06 localhost kernel: NET: Registered protocol family 15
Feb 29 04:56:06 localhost kernel: found reiserfs format "3.6" with standard 
journal
Feb 29 04:56:06 localhost kernel: usb 2-3.3.1: new low speed USB device using 
address 5
Feb 29 04:56:06 localhost kernel: usb 2-3.3.3: new low speed USB device using 
address 6
Feb 29 04:56:06 localhost kernel: usb 2-3.1.1: new full speed USB device using 
address 7
Feb 29 04:56:06 localhost kernel: usb 2-3.1.3: new low speed USB device using 
address 8
Feb 29 04:56:06 localhost kernel: usb 2-3.1.4: new low speed USB device using 
address 9
Feb 29 04:56:06 localhost kernel: Reiserfs journal params: device hdc5, size 
8192, journal first block 18, max trans len 1024, max batch 900, max commit 
age 30, max trans age 30
Feb 29 04:56:06 localhost kernel: reiserfs: checking transaction log (hdc5) 
for (hdc5)
Feb 29 04:56:06 localhost kernel: reiserfs: replayed 27 transactions in 0 
seconds
Feb 29 04:56:06 localhost kernel: Using r5 hash to sort names
Feb 29 04:56:06 localhost kernel: VFS: Mounted root (reiserfs filesystem) 
readonly.
Feb 29 04:56:06 localhost kernel: Mounted devfs on /dev
Feb 29 04:56:06 localhost kernel: Freeing unused kernel memory: 184k freed
Feb 29 04:56:06 localhost kernel: Adding 1004020k swap on /dev/hdc8.  
Priority:-1 extents:1
Feb 29 04:56:06 localhost kernel: Removing [665669 3328884 0x0 SD]..done
Feb 29 04:56:06 localhost kernel: There were 1 uncompleted unlinks/truncates. 
Completed
Feb 29 04:56:06 localhost kernel: bttv: driver version 0.9.12 loaded
Feb 29 04:56:06 localhost kernel: bttv: using 8 buffers with 2080k (520 pages) 
each for capture
Feb 29 04:56:06 localhost kernel: bttv: Bt8xx card found (0).
Feb 29 04:56:06 localhost kernel: bttv0: Bt848 (rev 17) at 0000:01:0a.0, irq: 
16, latency: 64, mmio: 0xde6ff000
Feb 29 04:56:06 localhost kernel: bttv0: using: Hauppauge (bt848) 
[card=2,insmod option]
Feb 29 04:56:06 localhost kernel: bttv0: gpio: en=00000000, out=00000000 
in=00fffffb [init]
Feb 29 04:56:06 localhost kernel: bttv0: Hauppauge/Voodoo msp34xx: reset line 
init [5]
Feb 29 04:56:06 localhost kernel: msp34xx: setvolume: mute=on 65535:65535  
v=0x00 b=0x00
Feb 29 04:56:06 localhost kernel: msp34xx: init: chip=MSP3400C-C6
Feb 29 04:56:06 localhost kernel: msp3400: daemon started
Feb 29 04:56:06 localhost kernel: msp3400: thread: sleep
Feb 29 04:56:06 localhost kernel: tuner: chip found at addr 0xc2 i2c-bus bt848 
#0 [sw]
Feb 29 04:56:06 localhost kernel: tuner: type set to 1 (Philips PAL_I (FI1246 
and compatibles)) by insmod option
Feb 29 04:56:06 localhost kernel: bttv0: Hauppauge eeprom: model=60324, 
tuner=Philips FM1216 (5), radio=yes
Feb 29 04:56:06 localhost kernel: bttv0: using tuner=5
Feb 29 04:56:06 localhost kernel: tuner: type already set to 1, ignoring 
request for 5
Feb 29 04:56:06 localhost kernel: bttv0: i2c: checking for MSP34xx @ 0x80... 
found
Feb 29 04:56:06 localhost kernel: bttv0: i2c: checking for TDA9875 @ 0xb0... 
not found
Feb 29 04:56:06 localhost kernel: bttv0: i2c: checking for TDA7432 @ 0x8a... 
not found
Feb 29 04:56:06 localhost kernel: tvaudio: TV audio decoder + audio/video mux 
driver
Feb 29 04:56:06 localhost kernel: tvaudio: known chips: 
tda9840,tda9873h,tda9874h/a,tda9850,tda9855,tea6300,tea6420,tda8425,pic16c54 
(PV951),ta8874z
Feb 29 04:56:06 localhost kernel: bttv0: registered device video0
Feb 29 04:56:06 localhost kernel: bttv0: registered device vbi0
Feb 29 04:56:06 localhost kernel: bttv0: registered device radio0
Feb 29 04:56:06 localhost kernel: msp34xx: AUDC_SET_INPUT(4)
Feb 29 04:56:06 localhost kernel: msp34xx: AUDC_SET_INPUT(4)
Feb 29 04:56:06 localhost kernel: found reiserfs format "3.6" with standard 
journal
Feb 29 04:56:06 localhost kernel: Reiserfs journal params: device hdc9, size 
8192, journal first block 18, max trans len 1024, max batch 900, max commit 
age 30, max trans age 30
Feb 29 04:56:06 localhost kernel: reiserfs: checking transaction log (hdc9) 
for (hdc9)
Feb 29 04:56:06 localhost kernel: reiserfs: replayed 1 transactions in 0 
seconds
Feb 29 04:56:06 localhost kernel: Using r5 hash to sort names
Feb 29 04:56:06 localhost kernel: found reiserfs format "3.6" with standard 
journal
Feb 29 04:56:06 localhost kernel: Reiserfs journal params: device sda5, size 
8192, journal first block 18, max trans len 1024, max batch 900, max commit 
age 30, max trans age 30
Feb 29 04:56:06 localhost kernel: reiserfs: checking transaction log (sda5) 
for (sda5)
Feb 29 04:56:06 localhost kernel: Using r5 hash to sort names
Feb 29 04:56:06 localhost kernel: found reiserfs format "3.6" with standard 
journal
Feb 29 04:56:06 localhost kernel: Reiserfs journal params: device sdb5, size 
8192, journal first block 18, max trans len 1024, max batch 900, max commit 
age 30, max trans age 30
Feb 29 04:56:06 localhost kernel: reiserfs: checking transaction log (sdb5) 
for (sdb5)
Feb 29 04:56:06 localhost kernel: Using r5 hash to sort names
Feb 29 04:56:06 localhost kernel: found reiserfs format "3.6" with standard 
journal
Feb 29 04:56:06 localhost kernel: Reiserfs journal params: device sde5, size 
8192, journal first block 18, max trans len 1024, max batch 900, max commit 
age 30, max trans age 30
Feb 29 04:56:06 localhost kernel: reiserfs: checking transaction log (sde5) 
for (sde5)
Feb 29 04:56:06 localhost kernel: Using r5 hash to sort names
Feb 29 04:56:06 localhost kernel: devfs_mk_dev: could not append to parent for 
vcc/1
Feb 29 04:56:06 localhost kernel: devfs_mk_dev: could not append to parent for 
vcc/a1
Feb 29 04:56:06 localhost kernel: Disabled Privacy Extensions on device 
c04b95c0(lo)
Feb 29 04:56:06 localhost kernel: e1000: eth0 NIC Link is Up 100 Mbps Full 
Duplex





.config:
#
# Automatically generated make config: don't edit
#
CONFIG_X86=y
CONFIG_MMU=y
CONFIG_UID16=y
CONFIG_GENERIC_ISA_DMA=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y
CONFIG_BROKEN=y
CONFIG_BROKEN_ON_SMP=y

#
# General setup
#
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_SYSCTL=y
CONFIG_LOG_BUF_SHIFT=15
CONFIG_HOTPLUG=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
CONFIG_KALLSYMS=y
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_AS=y
CONFIG_IOSCHED_DEADLINE=y

#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_OBSOLETE_MODPARM=y
CONFIG_KMOD=y

#
# Processor type and features
#
CONFIG_X86_PC=y
CONFIG_MK8=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
CONFIG_SMP=y
CONFIG_NR_CPUS=8
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_TSC=y
CONFIG_X86_MCE=y
CONFIG_X86_MCE_NONFATAL=y
CONFIG_HIGHMEM4G=y
CONFIG_HIGHMEM=y
CONFIG_HAVE_DEC_LOCK=y

#
# Power management options (ACPI, APM)
#

#
# ACPI (Advanced Configuration and Power Interface) Support
#
CONFIG_ACPI_BOOT=y

#
# CPU Frequency scaling
#

#
# Bus options (PCI, PCMCIA, EISA, MCA, ISA)
#
CONFIG_PCI=y
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_NAMES=y

#
# PCMCIA/CardBus support
#

#
# PCI Hotplug Support
#

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y

#
# Device Drivers
#

#
# Generic Driver Options
#

#
# Memory Technology Devices (MTD)
#

#
# Parallel port support
#

#
# Plug and Play support
#

#
# Block devices
#
CONFIG_BLK_DEV_LOOP=y
CONFIG_BLK_DEV_CRYPTOLOOP=m
CONFIG_BLK_DEV_NBD=m
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_SIZE=4096
CONFIG_BLK_DEV_INITRD=y
CONFIG_LBD=y

#
# ATA/ATAPI/MFM/RLL support
#
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_BLK_DEV_IDECD=y

#
# IDE chipset support/bugfixes
#
CONFIG_IDE_GENERIC=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_GENERIC=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_ADMA=y
CONFIG_BLK_DEV_AMD74XX=y
CONFIG_BLK_DEV_SIIMAGE=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_IDEDMA_AUTO=y

#
# SCSI device support
#
CONFIG_SCSI=y
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=y
CONFIG_BLK_DEV_SR=y
CONFIG_BLK_DEV_SR_VENDOR=y
CONFIG_CHR_DEV_SG=y

#
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
#
CONFIG_SCSI_MULTI_LUN=y
CONFIG_SCSI_REPORT_LUNS=y
CONFIG_SCSI_CONSTANTS=y

#
# SCSI low-level drivers
#
CONFIG_SCSI_SATA=y
CONFIG_SCSI_SATA_PROMISE=y
CONFIG_SCSI_SATA_SIL=y
CONFIG_SCSI_QLA2XXX=y

#
# Multi-device support (RAID and LVM)
#

#
# Fusion MPT device support
#

#
# IEEE 1394 (FireWire) support
#
CONFIG_IEEE1394=y

#
# Subsystem Options
#

#
# Device Drivers
#
CONFIG_IEEE1394_OHCI1394=y

#
# Protocol Drivers
#
CONFIG_IEEE1394_VIDEO1394=y
CONFIG_IEEE1394_SBP2=y
CONFIG_IEEE1394_DV1394=y
CONFIG_IEEE1394_RAWIO=y
CONFIG_IEEE1394_CMP=y

#
# I2O device support
#

#
# Macintosh device drivers
#

#
# Networking support
#
CONFIG_NET=y

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_NETLINK_DEV=y
CONFIG_UNIX=y
CONFIG_NET_KEY=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_IP_MULTIPLE_TABLES=y
CONFIG_IP_ROUTE_FWMARK=y
CONFIG_IP_ROUTE_NAT=y
CONFIG_IP_ROUTE_MULTIPATH=y
CONFIG_IP_ROUTE_TOS=y
CONFIG_IP_ROUTE_VERBOSE=y
CONFIG_NET_IPIP=y
CONFIG_NET_IPGRE=m
CONFIG_NET_IPGRE_BROADCAST=y
CONFIG_IP_MROUTE=y
CONFIG_IP_PIMSM_V1=y
CONFIG_IP_PIMSM_V2=y
CONFIG_ARPD=y
CONFIG_INET_ECN=y
CONFIG_SYN_COOKIES=y
CONFIG_INET_AH=m
CONFIG_INET_ESP=m
CONFIG_INET_IPCOMP=m

#
# IP: Virtual Server Configuration
#
CONFIG_IP_VS=m
CONFIG_IP_VS_TAB_BITS=12

#
# IPVS transport protocol load balancing support
#
CONFIG_IP_VS_PROTO_TCP=y
CONFIG_IP_VS_PROTO_UDP=y
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
CONFIG_IPV6=y
CONFIG_IPV6_PRIVACY=y
CONFIG_INET6_AH=m
CONFIG_INET6_ESP=m
CONFIG_INET6_IPCOMP=m
CONFIG_IPV6_TUNNEL=m
CONFIG_BRIDGE=m
CONFIG_NETFILTER=y
CONFIG_BRIDGE_NETFILTER=y

#
# IP: Netfilter Configuration
#
CONFIG_IP_NF_CONNTRACK=m
CONFIG_IP_NF_FTP=m
CONFIG_IP_NF_IRC=m
CONFIG_IP_NF_TFTP=m
CONFIG_IP_NF_AMANDA=m
CONFIG_IP_NF_QUEUE=m
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_LIMIT=m
CONFIG_IP_NF_MATCH_IPRANGE=m
CONFIG_IP_NF_MATCH_MAC=m
CONFIG_IP_NF_MATCH_PKTTYPE=m
CONFIG_IP_NF_MATCH_MARK=m
CONFIG_IP_NF_MATCH_MULTIPORT=m
CONFIG_IP_NF_MATCH_TOS=m
CONFIG_IP_NF_MATCH_RECENT=m
CONFIG_IP_NF_MATCH_ECN=m
CONFIG_IP_NF_MATCH_DSCP=m
CONFIG_IP_NF_MATCH_AH_ESP=m
CONFIG_IP_NF_MATCH_LENGTH=m
CONFIG_IP_NF_MATCH_TTL=m
CONFIG_IP_NF_MATCH_TCPMSS=m
CONFIG_IP_NF_MATCH_HELPER=m
CONFIG_IP_NF_MATCH_STATE=m
CONFIG_IP_NF_MATCH_CONNTRACK=m
CONFIG_IP_NF_MATCH_OWNER=m
CONFIG_IP_NF_MATCH_PHYSDEV=m
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_REDIRECT=m
CONFIG_IP_NF_TARGET_NETMAP=m
CONFIG_IP_NF_TARGET_SAME=m
CONFIG_IP_NF_NAT_SNMP_BASIC=m
CONFIG_IP_NF_NAT_IRC=m
CONFIG_IP_NF_NAT_FTP=m
CONFIG_IP_NF_NAT_TFTP=m
CONFIG_IP_NF_NAT_AMANDA=m
CONFIG_IP_NF_MANGLE=m
CONFIG_IP_NF_TARGET_TOS=m
CONFIG_IP_NF_TARGET_ECN=m
CONFIG_IP_NF_TARGET_DSCP=m
CONFIG_IP_NF_TARGET_MARK=m
CONFIG_IP_NF_TARGET_CLASSIFY=m
CONFIG_IP_NF_TARGET_LOG=m
CONFIG_IP_NF_TARGET_ULOG=m
CONFIG_IP_NF_TARGET_TCPMSS=m
CONFIG_IP_NF_ARPTABLES=m
CONFIG_IP_NF_ARPFILTER=m
CONFIG_IP_NF_ARP_MANGLE=m

#
# IPv6: Netfilter Configuration
#
CONFIG_IP6_NF_QUEUE=m
CONFIG_IP6_NF_IPTABLES=m
CONFIG_IP6_NF_MATCH_LIMIT=m
CONFIG_IP6_NF_MATCH_MAC=m
CONFIG_IP6_NF_MATCH_RT=m
CONFIG_IP6_NF_MATCH_OPTS=m
CONFIG_IP6_NF_MATCH_FRAG=m
CONFIG_IP6_NF_MATCH_HL=m
CONFIG_IP6_NF_MATCH_MULTIPORT=m
CONFIG_IP6_NF_MATCH_OWNER=m
CONFIG_IP6_NF_MATCH_MARK=m
CONFIG_IP6_NF_MATCH_IPV6HEADER=m
CONFIG_IP6_NF_MATCH_AHESP=m
CONFIG_IP6_NF_MATCH_LENGTH=m
CONFIG_IP6_NF_MATCH_EUI64=m
CONFIG_IP6_NF_FILTER=m
CONFIG_IP6_NF_TARGET_LOG=m
CONFIG_IP6_NF_MANGLE=m
CONFIG_IP6_NF_TARGET_MARK=m

#
# Bridge: Netfilter Configuration
#
CONFIG_BRIDGE_NF_EBTABLES=m
CONFIG_BRIDGE_EBT_BROUTE=m
CONFIG_BRIDGE_EBT_T_FILTER=m
CONFIG_BRIDGE_EBT_T_NAT=m
CONFIG_BRIDGE_EBT_802_3=m
CONFIG_BRIDGE_EBT_AMONG=m
CONFIG_BRIDGE_EBT_ARP=m
CONFIG_BRIDGE_EBT_IP=m
CONFIG_BRIDGE_EBT_LIMIT=m
CONFIG_BRIDGE_EBT_MARK=m
CONFIG_BRIDGE_EBT_PKTTYPE=m
CONFIG_BRIDGE_EBT_STP=m
CONFIG_BRIDGE_EBT_VLAN=m
CONFIG_BRIDGE_EBT_ARPREPLY=m
CONFIG_BRIDGE_EBT_DNAT=m
CONFIG_BRIDGE_EBT_MARK_T=m
CONFIG_BRIDGE_EBT_REDIRECT=m
CONFIG_BRIDGE_EBT_SNAT=m
CONFIG_BRIDGE_EBT_LOG=m
CONFIG_XFRM=y
CONFIG_XFRM_USER=m

#
# SCTP Configuration (EXPERIMENTAL)
#
CONFIG_IPV6_SCTP__=y
CONFIG_IP_SCTP=m
CONFIG_SCTP_DBG_MSG=y
CONFIG_SCTP_DBG_OBJCNT=y
CONFIG_SCTP_HMAC_MD5=y

#
# QoS and/or fair queueing
#
CONFIG_NET_SCHED=y
CONFIG_NET_SCH_CBQ=y
CONFIG_NET_SCH_HTB=y
CONFIG_NET_SCH_HFSC=y
CONFIG_NET_SCH_CSZ=y
CONFIG_NET_SCH_PRIO=y
CONFIG_NET_SCH_RED=y
CONFIG_NET_SCH_SFQ=y
CONFIG_NET_SCH_TEQL=y
CONFIG_NET_SCH_TBF=y
CONFIG_NET_SCH_GRED=y
CONFIG_NET_SCH_DSMARK=y
CONFIG_NET_SCH_INGRESS=m
CONFIG_NET_QOS=y
CONFIG_NET_ESTIMATOR=y
CONFIG_NET_CLS=y
CONFIG_NET_CLS_TCINDEX=y
CONFIG_NET_CLS_ROUTE4=y
CONFIG_NET_CLS_ROUTE=y
CONFIG_NET_CLS_FW=y
CONFIG_NET_CLS_U32=y
CONFIG_NET_CLS_RSVP=y
CONFIG_NET_CLS_RSVP6=y
CONFIG_NET_CLS_POLICE=y

#
# Network testing
#
CONFIG_NETDEVICES=y

#
# ARCnet devices
#
CONFIG_TUN=y

#
# Ethernet (10 or 100Mbit)
#

#
# Ethernet (1000 Mbit)
#
CONFIG_E1000=y
CONFIG_NS83820=y
CONFIG_TIGON3=y

#
# Ethernet (10000 Mbit)
#

#
# Wireless LAN (non-hamradio)
#

#
# Token Ring devices
#

#
# Wan interfaces
#

#
# Amateur Radio support
#

#
# IrDA (infrared) support
#

#
# Bluetooth support
#
CONFIG_BT=m
CONFIG_BT_L2CAP=m
CONFIG_BT_SCO=m
CONFIG_BT_RFCOMM=m
CONFIG_BT_RFCOMM_TTY=y
CONFIG_BT_BNEP=m
CONFIG_BT_BNEP_MC_FILTER=y
CONFIG_BT_BNEP_PROTO_FILTER=y

#
# Bluetooth device drivers
#
CONFIG_BT_HCIUSB=m

#
# ISDN subsystem
#

#
# Telephony Support
#

#
# Input device support
#
CONFIG_INPUT=y

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_JOYDEV=y
CONFIG_INPUT_EVDEV=y

#
# Input I/O drivers
#
CONFIG_SOUND_GAMEPORT=y
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
CONFIG_INPUT_JOYSTICK=y
CONFIG_JOYSTICK_IFORCE=m
CONFIG_JOYSTICK_IFORCE_USB=y
CONFIG_JOYSTICK_WARRIOR=m
CONFIG_JOYSTICK_MAGELLAN=m
CONFIG_INPUT_MISC=y

#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y

#
# Serial drivers
#
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_NR_UARTS=4

#
# Non-8250 serial port support
#
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
CONFIG_UNIX98_PTYS=y
CONFIG_LEGACY_PTYS=y
CONFIG_LEGACY_PTY_COUNT=256

#
# Mice
#

#
# IPMI
#
CONFIG_IPMI_HANDLER=m
CONFIG_IPMI_DEVICE_INTERFACE=m
CONFIG_IPMI_KCS=m

#
# Watchdog Cards
#
CONFIG_HW_RANDOM=y
CONFIG_RTC=y

#
# Ftape, the floppy tape device driver
#
CONFIG_AGP=y
CONFIG_AGP_AMD64=y
CONFIG_DRM=y
CONFIG_DRM_RADEON=y

#
# I2C support
#
CONFIG_I2C=y
CONFIG_I2C_CHARDEV=y

#
# I2C Algorithms
#
CONFIG_I2C_ALGOBIT=y
CONFIG_I2C_ALGOPCF=y

#
# I2C Hardware Bus support
#
CONFIG_I2C_AMD8111=y
CONFIG_I2C_ISA=y

#
# I2C Hardware Sensors Chip support
#
CONFIG_I2C_SENSOR=m
CONFIG_SENSORS_ADM1021=m
CONFIG_SENSORS_ASB100=m
CONFIG_SENSORS_EEPROM=m
CONFIG_SENSORS_FSCHER=m
CONFIG_SENSORS_GL518SM=m
CONFIG_SENSORS_IT87=m
CONFIG_SENSORS_LM75=m
CONFIG_SENSORS_LM78=m
CONFIG_SENSORS_LM83=m
CONFIG_SENSORS_LM85=m
CONFIG_SENSORS_LM90=m
CONFIG_SENSORS_VIA686A=m
CONFIG_SENSORS_W83781D=m
CONFIG_SENSORS_W83L785TS=m

#
# Misc devices
#

#
# Multimedia devices
#
CONFIG_VIDEO_DEV=y

#
# Video For Linux
#

#
# Video Adapters
#
CONFIG_VIDEO_BT848=m

#
# Radio Adapters
#

#
# Digital Video Broadcasting Devices
#
CONFIG_VIDEO_TUNER=m
CONFIG_VIDEO_BUF=m
CONFIG_VIDEO_BTCX=m
CONFIG_VIDEO_IR=m

#
# Graphics support
#

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
CONFIG_DUMMY_CONSOLE=y

#
# Sound
#
CONFIG_SOUND=y

#
# Advanced Linux Sound Architecture
#
CONFIG_SND=y
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=y
CONFIG_SND_PCM_OSS=y
CONFIG_SND_RTCTIMER=y

#
# Generic devices
#

#
# PCI devices
#
CONFIG_SND_BT87X=m
CONFIG_SND_EMU10K1=y
CONFIG_SND_INTEL8X0=y

#
# ALSA USB devices
#
CONFIG_SND_USB_AUDIO=m

#
# Open Sound System
#
CONFIG_SOUND_PRIME=m
CONFIG_SOUND_BT878=m
CONFIG_SOUND_TVMIXER=m

#
# USB support
#
CONFIG_USB=y

#
# Miscellaneous USB options
#
CONFIG_USB_DEVICEFS=y

#
# USB Host Controller Drivers
#
CONFIG_USB_OHCI_HCD=y

#
# USB Device Class drivers
#
CONFIG_USB_AUDIO=m

#
# USB Bluetooth TTY can only be used with disabled Bluetooth subsystem
#
CONFIG_USB_PRINTER=m
CONFIG_USB_STORAGE=m

#
# USB Human Interface Devices (HID)
#
CONFIG_USB_HID=m
CONFIG_USB_HIDINPUT=y
CONFIG_HID_FF=y
CONFIG_HID_PID=y
CONFIG_LOGITECH_FF=y
CONFIG_THRUSTMASTER_FF=y
CONFIG_USB_HIDDEV=y

#
# USB HID Boot Protocol drivers
#

#
# USB Imaging devices
#

#
# USB Multimedia devices
#
CONFIG_USB_PWC=m

#
# USB Network adaptors
#
CONFIG_USB_USBNET=m

#
# USB Host-to-Host Cables
#
CONFIG_USB_AN2720=y
CONFIG_USB_BELKIN=y
CONFIG_USB_GENESYS=y
CONFIG_USB_NET1080=y
CONFIG_USB_PL2301=y

#
# Intelligent USB Devices/Gadgets
#
CONFIG_USB_ARMLINUX=y
CONFIG_USB_EPSON2888=y
CONFIG_USB_ZAURUS=y
CONFIG_USB_CDCETHER=y

#
# USB Network Adapters
#

#
# USB port drivers
#

#
# USB Serial Converter support
#

#
# USB Miscellaneous drivers
#

#
# USB Gadget Support
#
CONFIG_USB_GADGET=m
CONFIG_USB_GADGET_NET2280=y
CONFIG_USB_NET2280=m

#
# File systems
#
CONFIG_EXT2_FS=y
CONFIG_EXT2_FS_XATTR=y
CONFIG_EXT2_FS_POSIX_ACL=y
CONFIG_EXT3_FS=y
CONFIG_EXT3_FS_XATTR=y
CONFIG_EXT3_FS_POSIX_ACL=y
CONFIG_JBD=y
CONFIG_FS_MBCACHE=y
CONFIG_REISERFS_FS=y
CONFIG_FS_POSIX_ACL=y
CONFIG_AUTOFS_FS=y

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
CONFIG_UDF_FS=m

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=m
CONFIG_VFAT_FS=m
CONFIG_NTFS_FS=m
CONFIG_NTFS_RW=y

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_DEVFS_FS=y
CONFIG_DEVFS_MOUNT=y
CONFIG_TMPFS=y
CONFIG_RAMFS=y

#
# Miscellaneous filesystems
#

#
# Network File Systems
#
CONFIG_SMB_FS=m
CONFIG_CIFS=m

#
# Partition Types
#
CONFIG_MSDOS_PARTITION=y

#
# Native Language Support
#
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=m
CONFIG_NLS_CODEPAGE_850=m
CONFIG_NLS_ISO8859_1=m
CONFIG_NLS_UTF8=m

#
# Profiling support
#

#
# Kernel hacking
#
CONFIG_DEBUG_KERNEL=y
CONFIG_EARLY_PRINTK=y
CONFIG_DEBUG_STACKOVERFLOW=y
CONFIG_DEBUG_STACK_USAGE=y
CONFIG_DEBUG_SLAB=y
CONFIG_DEBUG_IOVIRT=y
CONFIG_MAGIC_SYSRQ=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_PAGEALLOC=y
CONFIG_DEBUG_HIGHMEM=y
CONFIG_DEBUG_INFO=y
CONFIG_DEBUG_SPINLOCK_SLEEP=y
CONFIG_FRAME_POINTER=y
CONFIG_X86_FIND_SMP_CONFIG=y
CONFIG_X86_MPPARSE=y

#
# Security options
#

#
# Cryptographic options
#
CONFIG_CRYPTO=y
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_NULL=m
CONFIG_CRYPTO_MD4=m
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_SHA1=m
CONFIG_CRYPTO_SHA256=m
CONFIG_CRYPTO_SHA512=m
CONFIG_CRYPTO_DES=m
CONFIG_CRYPTO_BLOWFISH=m
CONFIG_CRYPTO_TWOFISH=m
CONFIG_CRYPTO_SERPENT=m
CONFIG_CRYPTO_AES=m
CONFIG_CRYPTO_CAST5=m
CONFIG_CRYPTO_CAST6=m
CONFIG_CRYPTO_DEFLATE=m
CONFIG_CRYPTO_TEST=m

#
# Library routines
#
CONFIG_CRC32=m
CONFIG_ZLIB_INFLATE=m
CONFIG_ZLIB_DEFLATE=m
CONFIG_X86_SMP=y
CONFIG_X86_HT=y
CONFIG_X86_BIOS_REBOOT=y
CONFIG_X86_TRAMPOLINE=y
CONFIG_PC=y
