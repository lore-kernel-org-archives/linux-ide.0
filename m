From: =?ISO-8859-15?Q?Kasimir_M=FCller?= <kjm@kasimir-mueller.de>
Subject: libata , Silicon Image 3124
Date: Mon, 12 Nov 2007 19:57:53 +0100
Message-ID: <4738A231.5010700@kasimir-mueller.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------010307090001020806050500"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cg-p07-fb.rzone.de ([81.169.146.215]:38305 "EHLO
	cg-p07-fb.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751734AbXKLS72 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 12 Nov 2007 13:59:28 -0500
Received: from mo-p00-ob.rzone.de (fruni-mo-p00-ob.mail [192.168.63.71])
	by gibbsson-fb-02.store (RZmta 14.0) with ESMTP id r02868jACH9Kmt
	for <linux-ide@vger.kernel.org>; Mon, 12 Nov 2007 19:59:25 +0100 (MET)
	(envelope-from: <kjm@kasimir-mueller.de>)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: htejun@gmail.com, linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------010307090001020806050500
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8bit

Hi tejun,

Since I am using portmultiplier on sil 3124, I see the following errors
in /var/log/messages
Presently I'm using kernel 2.6.23.1 with libata-patch
libata-tj-2.6.23-20071011
on Suse 10.3
First I saw this messages every 5-10 minutes.
After putting all Disks in the Blacklist of libata-core.c
 
        { "SAMSUNG HD501LJ",    "CR100-10",     ATA_HORKAGE_NONCQ, },
        { "SAMSUNG HD300LJ",    "ZT100-12",     ATA_HORKAGE_NONCQ, },
        { "SAMSUNG SP2504C",    "ZT100-41",     ATA_HORKAGE_NONCQ, },
        { "SAMSUNG HD160JJ",    "WU100-33",     ATA_HORKAGE_NONCQ, },

this messages appear every 3-4 hours.

I append the output of dmesg also.
I did not see any data loss or corruption until now.

Can you please give any hints on the errors ?

mfg
K. Müller
/var/log/messages:

Nov 12 19:28:42 linux kernel: ata6.00: failed to read SCR 1 (Emask=0x40)
Nov 12 19:28:42 linux kernel: ata6.01: failed to read SCR 1 (Emask=0x40)
Nov 12 19:28:42 linux kernel: ata6.02: failed to read SCR 1 (Emask=0x40)
Nov 12 19:28:42 linux kernel: ata6.03: failed to read SCR 1 (Emask=0x40)
Nov 12 19:28:42 linux kernel: ata6.04: failed to read SCR 1 (Emask=0x40)
Nov 12 19:28:42 linux kernel: ata6.05: failed to read SCR 1 (Emask=0x40)
Nov 12 19:28:42 linux kernel: ata6.00: exception Emask 0x100 SAct 0x0
SErr 0x0 action 0x6 frozen
Nov 12 19:28:42 linux kernel: ata6.01: exception Emask 0x100 SAct 0x0
SErr 0x0 action 0x6 frozen
Nov 12 19:28:42 linux kernel: ata6.02: exception Emask 0x100 SAct 0x0
SErr 0x0 action 0x6 frozen
Nov 12 19:28:42 linux kernel: ata6.02: cmd
ea/00:00:00:00:00/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0
Nov 12 19:28:42 linux kernel:          res
40/00:00:09:4f:c2/00:00:00:00:00/00 Emask 0x4 (timeout)
Nov 12 19:28:42 linux kernel: ata6.02: status: { DRDY }
Nov 12 19:28:42 linux kernel: ata6.03: exception Emask 0x100 SAct 0x0
SErr 0x0 action 0x6 frozen
Nov 12 19:28:42 linux kernel: ata6.04: exception Emask 0x100 SAct 0x0
SErr 0x0 action 0x6 frozen
Nov 12 19:28:42 linux kernel: ata6.05: exception Emask 0x100 SAct 0x0
SErr 0x0 action 0x6 frozen
Nov 12 19:28:42 linux kernel: ata6.15: hard resetting link
Nov 12 19:28:44 linux kernel: ata6.15: SATA link up 3.0 Gbps (SStatus
123 SControl 0)
Nov 12 19:28:44 linux kernel: ata6.00: hard resetting link
Nov 12 19:28:45 linux kernel: ata6.00: SATA link up 3.0 Gbps (SStatus
123 SControl 300)
Nov 12 19:28:45 linux kernel: ata6.01: hard resetting link
Nov 12 19:28:45 linux kernel: ata6.01: SATA link up 3.0 Gbps (SStatus
123 SControl 300)
Nov 12 19:28:45 linux kernel: ata6.02: hard resetting link
Nov 12 19:28:45 linux kernel: ata6.02: SATA link up 3.0 Gbps (SStatus
123 SControl 300)
Nov 12 19:28:45 linux kernel: ata6.03: hard resetting link
Nov 12 19:28:46 linux kernel: ata6.03: SATA link up 1.5 Gbps (SStatus
113 SControl 300)
Nov 12 19:28:46 linux kernel: ata6.04: hard resetting link
Nov 12 19:28:46 linux kernel: ata6.04: SATA link up 3.0 Gbps (SStatus
123 SControl 300)
Nov 12 19:28:46 linux kernel: ata6.05: hard resetting link
Nov 12 19:28:46 linux kernel: ata6.05: SATA link up 1.5 Gbps (SStatus
113 SControl 300)
Nov 12 19:28:46 linux kernel: ata6.00: configured for UDMA/100
Nov 12 19:28:46 linux kernel: ata6.01: configured for UDMA/100
Nov 12 19:28:46 linux kernel: ata6.02: configured for UDMA/100
Nov 12 19:28:46 linux kernel: ata6.03: configured for UDMA/100
Nov 12 19:28:47 linux kernel: ata6.04: configured for UDMA/100
Nov 12 19:28:47 linux kernel: ata6: EH complete
Nov 12 19:28:47 linux kernel: sd 5:0:0:0: [sdb] 586072368 512-byte
hardware sectors (300069 MB)
Nov 12 19:28:47 linux kernel: sd 5:0:0:0: [sdb] Write Protect is off
Nov 12 19:28:47 linux kernel: sd 5:0:0:0: [sdb] Mode Sense: 00 3a 00 00
Nov 12 19:28:47 linux kernel: sd 5:0:0:0: [sdb] Write cache: enabled,
read cache: enabled, doesn't support DPO or FUA
Nov 12 19:28:47 linux kernel: sd 5:1:0:0: [sdc] 488397168 512-byte
hardware sectors (250059 MB)
Nov 12 19:28:47 linux kernel: sd 5:1:0:0: [sdc] Write Protect is off
Nov 12 19:28:47 linux kernel: sd 5:1:0:0: [sdc] Mode Sense: 00 3a 00 00
Nov 12 19:28:47 linux kernel: sd 5:1:0:0: [sdc] Write cache: enabled,
read cache: enabled, doesn't support DPO or FUA
Nov 12 19:28:47 linux kernel: sd 5:2:0:0: [sdd] 488397168 512-byte
hardware sectors (250059 MB)
Nov 12 19:28:47 linux kernel: sd 5:2:0:0: [sdd] Write Protect is off
Nov 12 19:28:47 linux kernel: sd 5:2:0:0: [sdd] Mode Sense: 00 3a 00 00
Nov 12 19:28:47 linux kernel: sd 5:2:0:0: [sdd] Write cache: enabled,
read cache: enabled, doesn't support DPO or FUA
Nov 12 19:28:47 linux kernel: sd 5:3:0:0: [sde] 312581808 512-byte
hardware sectors (160042 MB)
Nov 12 19:28:47 linux kernel: sd 5:3:0:0: [sde] Write Protect is off
Nov 12 19:28:47 linux kernel: sd 5:3:0:0: [sde] Mode Sense: 00 3a 00 00
Nov 12 19:28:47 linux kernel: sd 5:3:0:0: [sde] Write cache: enabled,
read cache: enabled, doesn't support DPO or FUA
Nov 12 19:28:47 linux kernel: sd 5:4:0:0: [sdf] 976773168 512-byte
hardware sectors (500108 MB)
Nov 12 19:28:47 linux kernel: sd 5:4:0:0: [sdf] Write Protect is off
Nov 12 19:28:47 linux kernel: sd 5:4:0:0: [sdf] Mode Sense: 00 3a 00 00
Nov 12 19:28:47 linux kernel: sd 5:4:0:0: [sdf] Write cache: enabled,
read cache: enabled, doesn't support DPO or FUA
Nov 12 19:28:47 linux kernel: sd 5:0:0:0: [sdb] 586072368 512-byte
hardware sectors (300069 MB)
Nov 12 19:28:47 linux kernel: sd 5:0:0:0: [sdb] Write Protect is off
Nov 12 19:28:47 linux kernel: sd 5:0:0:0: [sdb] Mode Sense: 00 3a 00 00
Nov 12 19:28:47 linux kernel: sd 5:0:0:0: [sdb] Write cache: enabled,
read cache: enabled, doesn't support DPO or FUA
Nov 12 19:28:47 linux kernel: sd 5:1:0:0: [sdc] 488397168 512-byte
hardware sectors (250059 MB)
Nov 12 19:28:47 linux kernel: sd 5:1:0:0: [sdc] Write Protect is off
Nov 12 19:28:47 linux kernel: sd 5:1:0:0: [sdc] Mode Sense: 00 3a 00 00
Nov 12 19:28:47 linux kernel: sd 5:1:0:0: [sdc] Write cache: enabled,
read cache: enabled, doesn't support DPO or FUA
Nov 12 19:28:47 linux kernel: sd 5:2:0:0: [sdd] 488397168 512-byte
hardware sectors (250059 MB)
Nov 12 19:28:47 linux kernel: sd 5:2:0:0: [sdd] Write Protect is off
Nov 12 19:28:47 linux kernel: sd 5:2:0:0: [sdd] Mode Sense: 00 3a 00 00
Nov 12 19:28:47 linux kernel: sd 5:2:0:0: [sdd] Write cache: enabled,
read cache: enabled, doesn't support DPO or FUA
Nov 12 19:28:47 linux kernel: sd 5:3:0:0: [sde] 312581808 512-byte
hardware sectors (160042 MB)
Nov 12 19:28:47 linux kernel: sd 5:3:0:0: [sde] Write Protect is off
Nov 12 19:28:47 linux kernel: sd 5:3:0:0: [sde] Mode Sense: 00 3a 00 00
Nov 12 19:28:47 linux kernel: sd 5:3:0:0: [sde] Write cache: enabled,
read cache: enabled, doesn't support DPO or FUA
Nov 12 19:28:47 linux kernel: sd 5:4:0:0: [sdf] 976773168 512-byte
hardware sectors (500108 MB)
Nov 12 19:28:47 linux kernel: sd 5:4:0:0: [sdf] Write Protect is off
Nov 12 19:28:47 linux kernel: sd 5:4:0:0: [sdf] Mode Sense: 00 3a 00 00
Nov 12 19:28:47 linux kernel: sd 5:4:0:0: [sdf] Write cache: enabled,
read cache: enabled, doesn't support DPO or FUA




--------------010307090001020806050500
Content-Type: text/plain;
 name="dmesg.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg.txt"

Linux version 2.6.23.1-xen (root@linux) (gcc version 4.1.2 20061115 (prerelease) (SUSE Linux)) #2 SMP Sun Nov 11 14:37:51 CET 2007
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e8000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000007ffc0000 (usable)
 BIOS-e820: 000000007ffc0000 - 000000007ffce000 (ACPI data)
 BIOS-e820: 000000007ffce000 - 000000007fff0000 (ACPI NVS)
 BIOS-e820: 000000007fff0000 - 0000000080000000 (reserved)
 BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fecc0000 - 00000000fecc1000 (reserved)
 BIOS-e820: 00000000ff780000 - 0000000100000000 (reserved)
1151MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000ff780
Entering add_active_range(0, 0, 524224) 0 entries of 256 used
Zone PFN ranges:
  DMA             0 ->     4096
  Normal       4096 ->   229376
  HighMem    229376 ->   524224
Movable zone start PFN for each node
early_node_map[1] active PFN ranges
    0:        0 ->   524224
On node 0 totalpages: 524224
  DMA zone: 32 pages used for memmap
  DMA zone: 0 pages reserved
  DMA zone: 4064 pages, LIFO batch:0
  Normal zone: 1760 pages used for memmap
  Normal zone: 223520 pages, LIFO batch:31
  HighMem zone: 2303 pages used for memmap
  HighMem zone: 292545 pages, LIFO batch:31
  Movable zone: 0 pages used for memmap
DMI 2.3 present.
ACPI: RSDP 000F87C0, 0014 (r0 ACPIAM)
ACPI: RSDT 7FFC0000, 0034 (r1 A M I  OEMRSDT   9000528 MSFT       97)
ACPI: FACP 7FFC0200, 0084 (r2 A M I  OEMFACP   9000528 MSFT       97)
ACPI: DSDT 7FFC0440, 45ED (r1  12345 12345123      123 INTL  2002026)
ACPI: FACS 7FFCE000, 0040
ACPI: APIC 7FFC0390, 0068 (r1 A M I  OEMAPIC   9000528 MSFT       97)
ACPI: MCFG 7FFC0400, 003C (r1 A M I  OEMMCFG   9000528 MSFT       97)
ACPI: OEMB 7FFCE040, 0046 (r1 A M I  AMI_OEM   9000528 MSFT       97)
ACPI: PM-Timer IO Port: 0x808
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 15:15 APIC version 16
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x81] disabled)
ACPI: Skipping IOAPIC probe due to 'noapic' option.
Using ACPI for processor (LAPIC) configuration information
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: TEMPLATE Product ID: ETEMPLATE    APIC at: 0xFEE00000
I/O APIC #1 Version 3 at 0xFEC00000.
I/O APIC #2 Version 3 at 0xFECC0000.
Enabling APIC mode:  Flat.  Using 2 I/O APICs
Processors: 1
Allocating PCI resources starting at 88000000 (gap: 80000000:60000000)
Built 1 zonelists in Zone order.  Total pages: 520129
Kernel command line: root=/dev/sda5 vga=0x317 resume=/dev/sda1 splash=silent showopts noapic 3
mapped APIC to ffffb000 (fee00000)
mapped IOAPIC to ffffa000 (fec00000)
mapped IOAPIC to ffff9000 (fecc0000)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 16384 bytes)
Detected 2000.148 MHz processor.
Console: colour dummy device 80x25
console [tty0] enabled
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 2066956k/2096896k available (1665k kernel code, 28804k reserved, 705k data, 188k init, 1179392k highmem)
virtual kernel memory layout:
    fixmap  : 0xffe15000 - 0xfffff000   (1960 kB)
    pkmap   : 0xff800000 - 0xffc00000   (4096 kB)
    vmalloc : 0xf8800000 - 0xff7fe000   ( 111 MB)
    lowmem  : 0xc0000000 - 0xf8000000   ( 896 MB)
      .init : 0xc0357000 - 0xc0386000   ( 188 kB)
      .data : 0xc02a0742 - 0xc0350ba4   ( 705 kB)
      .text : 0xc0100000 - 0xc02a0742   (1665 kB)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 4005.05 BogoMIPS (lpj=8010115)
Security Framework v1.0.0 initialized
Mount-cache hash table entries: 512
CPU: After generic identify, caps: 078bfbff e3d3fbff 00000000 00000000 00000001 00000000 00000001 00000000
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 512K (64 bytes/line)
CPU: After all inits, caps: 078bfbff e3d3fbff 00000000 00000410 00000001 00000000 00000001 00000000
Compat vDSO mapped to ffffe000.
Checking 'hlt' instruction... OK.
SMP alternatives: switching to UP code
Freeing SMP alternatives: 11k freed
ACPI: Core revision 20070126
ACPI: setting ELCR to 0200 (from 0c28)
CPU0: AMD Athlon(tm) 64 Processor 3200+ stepping 02
Total of 1 processors activated (4005.05 BogoMIPS).
Brought up 1 CPUs
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: Using MMCONFIG
PCI: No mmconfig possible on device 00:18
Setting up standard PCI resources
ACPI: EC: Look up EC in DSDT
ACPI: Interpreter enabled
ACPI: (supports S0 S1 S3 S5)
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P1._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.NBPG._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.NBP0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.NBP1._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.NBP2._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.NBP3._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs *3 4 5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI Warning (tbutils-0217): Incorrect checksum in table [OEMB] -  95, should be 8C [20070126]
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
ACPI: bus type pnp registered
pnp: PnP ACPI: found 13 devices
ACPI: ACPI bus type pnp unregistered
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
ACPI: RTC can wake from S4
Time: tsc clocksource has been installed.
pnp: 00:07: ioport range 0xa00-0xa0f has been reserved
pnp: 00:07: ioport range 0x290-0x29f has been reserved
pnp: 00:07: ioport range 0xa20-0xa2f has been reserved
pnp: 00:07: ioport range 0xa30-0xa3f has been reserved
pnp: 00:07: ioport range 0xa40-0xa4f has been reserved
pnp: 00:08: iomem range 0xffb80000-0xffbfffff could not be reserved
pnp: 00:08: iomem range 0xfff00000-0xfff7fffe could not be reserved
pnp: 00:09: iomem range 0xfec00000-0xfec00fff could not be reserved
pnp: 00:09: iomem range 0xfee00000-0xfee00fff has been reserved
pnp: 00:0b: iomem range 0xe0000000-0xefffffff could not be reserved
pnp: 00:0c: iomem range 0x0-0x9ffff could not be reserved
pnp: 00:0c: iomem range 0xc0000-0xcffff could not be reserved
pnp: 00:0c: iomem range 0xe0000-0xfffff could not be reserved
pnp: 00:0c: iomem range 0x100000-0x7fffffff could not be reserved
PCI: Bridge: 0000:00:01.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:02.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:03.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:03.1
  IO window: a000-afff
  MEM window: fc900000-fcafffff
  PREFETCH window: b7e00000-b7efffff
PCI: Bridge: 0000:00:03.2
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:03.3
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Setting latency timer of device 0000:00:01.0 to 64
ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 10
PCI: setting IRQ 10 as level-triggered
ACPI: PCI Interrupt 0000:00:02.0[A] -> Link [LNKH] -> GSI 10 (level, low) -> IRQ 10
PCI: Setting latency timer of device 0000:00:02.0 to 64
ACPI: PCI Interrupt 0000:00:03.0[A] -> Link [LNKH] -> GSI 10 (level, low) -> IRQ 10
PCI: Setting latency timer of device 0000:00:03.0 to 64
ACPI: PCI Interrupt 0000:00:03.1[B] -> Link [LNKH] -> GSI 10 (level, low) -> IRQ 10
PCI: Setting latency timer of device 0000:00:03.1 to 64
ACPI: PCI Interrupt 0000:00:03.2[C] -> Link [LNKH] -> GSI 10 (level, low) -> IRQ 10
PCI: Setting latency timer of device 0000:00:03.2 to 64
ACPI: PCI Interrupt 0000:00:03.3[D] -> Link [LNKH] -> GSI 10 (level, low) -> IRQ 10
PCI: Setting latency timer of device 0000:00:03.3 to 64
NET: Registered protocol family 2
IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
TCP established hash table entries: 131072 (order: 8, 1572864 bytes)
TCP bind hash table entries: 65536 (order: 7, 524288 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
TCP reno registered
Unpacking initramfs... done
Freeing initrd memory: 8500k freed
audit: initializing netlink socket (disabled)
audit(1194871887.560:1): initialized
highmem bounce pool size: 64 pages
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
PCI: VIA PCI bridge detected. Disabling DAC.
Boot video device is 0000:00:05.0
PCI: Setting latency timer of device 0000:00:02.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:02.0:pcie00]
Allocate Port Service[0000:00:02.0:pcie01]
Allocate Port Service[0000:00:02.0:pcie02]
Allocate Port Service[0000:00:02.0:pcie03]
PCI: Setting latency timer of device 0000:00:03.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:03.0:pcie00]
Allocate Port Service[0000:00:03.0:pcie01]
Allocate Port Service[0000:00:03.0:pcie02]
Allocate Port Service[0000:00:03.0:pcie03]
PCI: Setting latency timer of device 0000:00:03.1 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:03.1:pcie00]
Allocate Port Service[0000:00:03.1:pcie01]
Allocate Port Service[0000:00:03.1:pcie02]
Allocate Port Service[0000:00:03.1:pcie03]
PCI: Setting latency timer of device 0000:00:03.2 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:03.2:pcie00]
Allocate Port Service[0000:00:03.2:pcie01]
Allocate Port Service[0000:00:03.2:pcie02]
Allocate Port Service[0000:00:03.2:pcie03]
PCI: Setting latency timer of device 0000:00:03.3 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:03.3:pcie00]
Allocate Port Service[0000:00:03.3:pcie01]
Allocate Port Service[0000:00:03.3:pcie02]
Allocate Port Service[0000:00:03.3:pcie03]
AER service couldn't init device 0000:00:02.0:pcie01 - no _OSC support
AER service couldn't init device 0000:00:03.0:pcie01 - no _OSC support
AER service couldn't init device 0000:00:03.1:pcie01 - no _OSC support
AER service couldn't init device 0000:00:03.2:pcie01 - no _OSC support
AER service couldn't init device 0000:00:03.3:pcie01 - no _OSC support
vesafb: framebuffer at 0xc8000000, mapped to 0xf8880000, using 3072k, total 65536k
vesafb: mode is 1024x768x16, linelength=2048, pages=1
vesafb: protected mode interface info at c000:e4e0
vesafb: pmi: set display start = c00ce516, set palette = c00ce580
vesafb: pmi: ports = 3b4 3b5 3ba 3c0 3c1 3c4 3c5 3c6 3c7 3c8 3c9 3cc 3ce 3cf 3d0 3d1 3d2 3d3 3d4 3d5 3da 
vesafb: scrolling: redraw
vesafb: Truecolor: size=0:5:6:5, shift=0:11:5:0
Console: switching to colour frame buffer device 128x48
fb0: VESA VGA frame buffer device
Real Time Clock Driver v1.12ac
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
PNP: PS/2 Controller [PNP0303:PS2K] at 0x60,0x64 irq 1
PNP: PS/2 appears to have AUX port disabled, if this is incorrect please boot with i8042.nopnp
serio: i8042 KBD port at 0x60,0x64 irq 1
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input0
input: PC Speaker as /devices/platform/pcspkr/input/input1
NET: Registered protocol family 1
Using IPI No-Shortcut mode
Freeing unused kernel memory: 188k freed
ACPI: Processor [CPU1] (supports 16 throttling states)
ACPI Exception (processor_core-0818): AE_NOT_FOUND, Processor Device is not present [20070126]
SCSI subsystem initialized
libata version 3.00 loaded.
sata_via 0000:00:0f.0: version 2.3
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 5
PCI: setting IRQ 5 as level-triggered
ACPI: PCI Interrupt 0000:00:0f.0[B] -> Link [LNKC] -> GSI 5 (level, low) -> IRQ 5
sata_via 0000:00:0f.0: routed to hard irq line 5
scsi0 : sata_via
scsi1 : sata_via
ata1: SATA max UDMA/133 cmd 0xec00 ctl 0xe800 bmdma 0xdc00 irq 5
ata2: SATA max UDMA/133 cmd 0xe400 ctl 0xe000 bmdma 0xdc08 irq 5
ata1: SATA link down 1.5 Gbps (SStatus 0 SControl 300)
ata2: SATA link down 1.5 Gbps (SStatus 0 SControl 300)
pata_via 0000:00:0f.1: version 0.3.2
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 3
PCI: setting IRQ 3 as level-triggered
ACPI: PCI Interrupt 0000:00:0f.1[A] -> Link [LNKB] -> GSI 3 (level, low) -> IRQ 3
PCI: VIA VLink IRQ fixup for 0000:00:0f.1, from 255 to 3
scsi2 : pata_via
scsi3 : pata_via
ata3: PATA max UDMA/133 cmd 0x1f0 ctl 0x3f6 bmdma 0xfc00 irq 14
ata4: PATA max UDMA/133 cmd 0x170 ctl 0x376 bmdma 0xfc08 irq 15
ata3.00: ATA-7: SAMSUNG SP1654N, BV100-37, max UDMA/100
ata3.00: 312581808 sectors, multi 16: LBA48 
ata3.00: configured for UDMA/100
ata4.00: ATAPI: HL-DT-ST DVDRAM GSA-H10N, JL10, max UDMA/33
ata4.00: configured for UDMA/33
scsi 2:0:0:0: Direct-Access     ATA      SAMSUNG SP1654N  BV10 PQ: 0 ANSI: 5
scsi 3:0:0:0: CD-ROM            HL-DT-ST DVDRAM GSA-H10N  JL10 PQ: 0 ANSI: 5
sata_sil24 0000:04:00.0: version 1.1
ACPI: PCI Interrupt 0000:04:00.0[A] -> Link [LNKH] -> GSI 10 (level, low) -> IRQ 10
PCI: Setting latency timer of device 0000:04:00.0 to 64
scsi4 : sata_sil24
scsi5 : sata_sil24
ata5: SATA max UDMA/100 host m128@0xfcaffc00 port 0xfcaf8000 irq 10
ata6: SATA max UDMA/100 host m128@0xfcaffc00 port 0xfcafa000 irq 10
ata5: SATA link down (SStatus 0 SControl 0)
ata6: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
ata6.15: Port Multiplier 1.1, 0x1095:0x3726 r23, 6 ports, feat 0x1/0x9
ata6.00: hard resetting link
ata6.00: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata6.01: hard resetting link
ata6.01: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata6.02: hard resetting link
ata6.02: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata6.03: hard resetting link
ata6.03: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata6.04: hard resetting link
ata6.04: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata6.05: hard resetting link
ata6.05: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata6.00: ATA-7: SAMSUNG HD300LJ, ZT100-12, max UDMA7
ata6.00: 586072368 sectors, multi 16: LBA48 NCQ (depth 31/32)
ata6.00: configured for UDMA/100
ata6.01: ATA-7: SAMSUNG SP2504C, VT100-41, max UDMA7
ata6.01: 488397168 sectors, multi 0: LBA48 NCQ (depth 31/32)
ata6.01: configured for UDMA/100
ata6.02: ATA-7: SAMSUNG SP2504C, VT100-41, max UDMA7
ata6.02: 488397168 sectors, multi 0: LBA48 NCQ (depth 31/32)
ata6.02: configured for UDMA/100
ata6.03: ATA-7: SAMSUNG HD160JJ, WU100-33, max UDMA7
ata6.03: 312581808 sectors, multi 0: LBA48 NCQ (depth 31/32)
ata6.03: configured for UDMA/100
ata6.04: ATA-8: SAMSUNG HD501LJ, CR100-10, max UDMA7
ata6.04: 976773168 sectors, multi 0: LBA48 NCQ (depth 31/32)
ata6.04: configured for UDMA/100
ata6: EH complete
scsi 5:0:0:0: Direct-Access     ATA      SAMSUNG HD300LJ  ZT10 PQ: 0 ANSI: 5
scsi 5:1:0:0: Direct-Access     ATA      SAMSUNG SP2504C  VT10 PQ: 0 ANSI: 5
scsi 5:2:0:0: Direct-Access     ATA      SAMSUNG SP2504C  VT10 PQ: 0 ANSI: 5
scsi 5:3:0:0: Direct-Access     ATA      SAMSUNG HD160JJ  WU10 PQ: 0 ANSI: 5
scsi 5:4:0:0: Direct-Access     ATA      SAMSUNG HD501LJ  CR10 PQ: 0 ANSI: 5
BIOS EDD facility v0.16 2004-Jun-25, 6 devices found
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Capability LSM initialized
ide0: I/O resource 0x3F6-0x3F6 not free.
ide0: ports already in use, skipping probe
ide1: I/O resource 0x376-0x376 not free.
ide1: ports already in use, skipping probe
sd 2:0:0:0: [sda] 312581808 512-byte hardware sectors (160042 MB)
sd 2:0:0:0: [sda] Write Protect is off
sd 2:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 2:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 2:0:0:0: [sda] 312581808 512-byte hardware sectors (160042 MB)
usbcore: registered new interface driver usbfs
sd 2:0:0:0: [sda] Write Protect is off
sd 2:0:0:0: [sda] Mode Sense: 00 3a 00 00
usbcore: registered new interface driver hub
sd 2:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
usbcore: registered new device driver usb
 sda: sda1 sda2 sda3 <<6>USB Universal Host Controller Interface driver v3.0
 sda5ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
PCI: setting IRQ 11 as level-triggered
ACPI: PCI Interrupt 0000:00:10.0[A] -> Link [LNKA] -> GSI 11 (level, low) -> IRQ 11
 sda6 sda7 >
sd 2:0:0:0: [sda] Attached SCSI disk
sd 5:0:0:0: [sdb] 586072368 512-byte hardware sectors (300069 MB)
sd 5:0:0:0: [sdb] Write Protect is off
sd 5:0:0:0: [sdb] Mode Sense: 00 3a 00 00
uhci_hcd 0000:00:10.0: UHCI Host Controller
sd 5:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
uhci_hcd 0000:00:10.0: new USB bus registered, assigned bus number 1
sd 5:0:0:0: [sdb] 586072368 512-byte hardware sectors (300069 MB)
uhci_hcd 0000:00:10.0: irq 11, io base 0x0000d000
sd 5:0:0:0: [sdb] Write Protect is off
sd 5:0:0:0: [sdb] Mode Sense: 00 3a 00 00
usb usb1: configuration #1 chosen from 1 choice
sd 5:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
 sdb: sdb1 sdb2 sdb3
sd 5:0:0:0: [sdb] Attached SCSI disk
sd 5:1:0:0: [sdc] 488397168 512-byte hardware sectors (250059 MB)
sd 5:1:0:0: [sdc] Write Protect is off
sd 5:1:0:0: [sdc] Mode Sense: 00 3a 00 00
sd 5:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 5:1:0:0: [sdc] 488397168 512-byte hardware sectors (250059 MB)
sd 5:1:0:0: [sdc] Write Protect is off
sd 5:1:0:0: [sdc] Mode Sense: 00 3a 00 00
sd 5:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sdc: sdc1 sdc2
sd 5:1:0:0: [sdc] Attached SCSI disk
sd 5:2:0:0: [sdd] 488397168 512-byte hardware sectors (250059 MB)
sd 5:2:0:0: [sdd] Write Protect is off
sd 5:2:0:0: [sdd] Mode Sense: 00 3a 00 00
sd 5:2:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 5:2:0:0: [sdd] 488397168 512-byte hardware sectors (250059 MB)
sd 5:2:0:0: [sdd] Write Protect is off
sd 5:2:0:0: [sdd] Mode Sense: 00 3a 00 00
sd 5:2:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sdd: sdd1 sdd2
ACPI: PCI Interrupt 0000:00:10.1[A] -> Link [LNKA] -> GSI 11 (level, low) -> IRQ 11
uhci_hcd 0000:00:10.1: UHCI Host Controller
uhci_hcd 0000:00:10.1: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:10.1: irq 11, io base 0x0000cc00
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
sd 5:2:0:0: [sdd] Attached SCSI disk
sd 5:3:0:0: [sde] 312581808 512-byte hardware sectors (160042 MB)
sd 5:3:0:0: [sde] Write Protect is off
sd 5:3:0:0: [sde] Mode Sense: 00 3a 00 00
sd 5:3:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 5:3:0:0: [sde] 312581808 512-byte hardware sectors (160042 MB)
sd 5:3:0:0: [sde] Write Protect is off
sd 5:3:0:0: [sde] Mode Sense: 00 3a 00 00
sd 5:3:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sde: sde1 sde2
sd 5:3:0:0: [sde] Attached SCSI disk
sd 5:4:0:0: [sdf] 976773168 512-byte hardware sectors (500108 MB)
sd 5:4:0:0: [sdf] Write Protect is off
sd 5:4:0:0: [sdf] Mode Sense: 00 3a 00 00
sd 5:4:0:0: [sdf] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 5:4:0:0: [sdf] 976773168 512-byte hardware sectors (500108 MB)
sd 5:4:0:0: [sdf] Write Protect is off
sd 5:4:0:0: [sdf] Mode Sense: 00 3a 00 00
sd 5:4:0:0: [sdf] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sdf:<6>ACPI: PCI Interrupt 0000:00:10.2[B] -> Link [LNKB] -> GSI 3 (level, low) -> IRQ 3
uhci_hcd 0000:00:10.2: UHCI Host Controller
uhci_hcd 0000:00:10.2: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:10.2: irq 3, io base 0x0000c800
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
 sdf1
sd 5:4:0:0: [sdf] Attached SCSI disk
usb 1-1: new low speed USB device using uhci_hcd and address 2
ACPI: PCI Interrupt 0000:00:10.4[C] -> Link [LNKC] -> GSI 5 (level, low) -> IRQ 5
ehci_hcd 0000:00:10.4: EHCI Host Controller
ehci_hcd 0000:00:10.4: new USB bus registered, assigned bus number 4
ehci_hcd 0000:00:10.4: irq 5, io mem 0xfebdf800
ehci_hcd 0000:00:10.4: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb4: configuration #1 chosen from 1 choice
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 8 ports detected
ACPI: PCI Interrupt 0000:00:10.3[B] -> Link [LNKB] -> GSI 3 (level, low) -> IRQ 3
uhci_hcd 0000:00:10.3: UHCI Host Controller
uhci_hcd 0000:00:10.3: new USB bus registered, assigned bus number 5
uhci_hcd 0000:00:10.3: irq 3, io base 0x0000c400
usb usb5: configuration #1 chosen from 1 choice
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 2 ports detected
usb 1-1: new low speed USB device using uhci_hcd and address 3
usb 1-1: configuration #1 chosen from 1 choice
usb 2-2: new low speed USB device using uhci_hcd and address 2
usb 2-2: configuration #1 chosen from 1 choice
usbcore: registered new interface driver hiddev
hiddev96: USB HID v1.11 Device [OMRON 87XXUPS] on usb-0000:00:10.0-1
input: Logitech USB-PS/2 Optical Mouse as /devices/pci0000:00/0000:00:10.1/usb2/2-2/2-2:1.0/input/input2
input: USB HID v1.10 Mouse [Logitech USB-PS/2 Optical Mouse] on usb-0000:00:10.1-2
usbcore: registered new interface driver usbhid
drivers/hid/usbhid/hid-core.c: v2.6:USB HID core driver
ReiserFS: sda5: found reiserfs format "3.6" with standard journal
ReiserFS: sda5: using ordered data mode
ReiserFS: sda5: journal params: device sda5, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: sda5: checking transaction log (sda5)
ReiserFS: sda5: Using r5 hash to sort names
sd 2:0:0:0: Attached scsi generic sg0 type 0
scsi 3:0:0:0: Attached scsi generic sg1 type 5
sd 5:0:0:0: Attached scsi generic sg2 type 0
sd 5:1:0:0: Attached scsi generic sg3 type 0
sd 5:2:0:0: Attached scsi generic sg4 type 0
sd 5:3:0:0: Attached scsi generic sg5 type 0
sd 5:4:0:0: Attached scsi generic sg6 type 0
via-rhine.c:v1.10-LK1.4.3 2007-03-06 Written by Donald Becker
ACPI: PCI Interrupt 0000:00:12.0[A] -> Link [LNKC] -> GSI 5 (level, low) -> IRQ 5
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
eth0: VIA Rhine II at 0x1b800, 00:14:2a:f1:f7:7d, IRQ 5.
eth0: MII PHY found at address 1, status 0x786d advertising 05e1 Link 45e1.
Linux agpgart interface v0.102
agpgart: Detected AGP bridge 0
agpgart: AGP aperture is 64M @ 0xc4000000
shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
input: Power Button (FF) as /devices/virtual/input/input3
ACPI: Power Button (FF) [PWRF]
input: Sleep Button (CM) as /devices/virtual/input/input4
ACPI: Sleep Button (CM) [SLPB]
input: Power Button (CM) as /devices/virtual/input/input5
ACPI: Power Button (CM) [PWRB]
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
00:0a: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
sr0: scsi3-mmc drive: 125x/125x writer dvd-ram cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.20
sr 3:0:0:0: Attached scsi CD-ROM sr0
spurious 8259A interrupt: IRQ7.
ACPI: PCI Interrupt 0000:00:11.5[C] -> Link [LNKC] -> GSI 5 (level, low) -> IRQ 5
PCI: Setting latency timer of device 0000:00:11.5 to 64
rtc_cmos 00:02: rtc core: registered rtc_cmos as rtc0
rtc_cmos: probe of 00:02 failed with error -16
md: md1 stopped.
device-mapper: ioctl: 4.11.0-ioctl (2006-10-12) initialised: dm-devel@redhat.com
md: bind<sdd2>
md: bind<sdc2>
md: bind<sdb2>
xor: automatically using best checksumming function: pIII_sse
   pIII_sse  :  6102.000 MB/sec
xor: using function: pIII_sse (6102.000 MB/sec)
async_tx: api initialized (async)
raid6: int32x1    786 MB/s
raid6: int32x2    818 MB/s
raid6: int32x4    758 MB/s
raid6: int32x8    563 MB/s
raid6: mmxx1     1653 MB/s
raid6: mmxx2     3042 MB/s
raid6: sse1x1    1312 MB/s
raid6: sse1x2    1983 MB/s
raid6: sse2x1    1912 MB/s
raid6: sse2x2    2811 MB/s
raid6: using algorithm sse2x2 (2811 MB/s)
md: raid6 personality registered for level 6
md: raid5 personality registered for level 5
md: raid4 personality registered for level 4
raid5: device sdb2 operational as raid disk 0
raid5: device sdc2 operational as raid disk 2
raid5: device sdd2 operational as raid disk 1
raid5: allocated 3170kB for md1
raid5: raid level 5 set md1 active with 3 out of 3 devices, algorithm 2
RAID5 conf printout:
 --- rd:3 wd:3
 disk 0, o:1, dev:sdb2
 disk 1, o:1, dev:sdd2
 disk 2, o:1, dev:sdc2
md: md0 stopped.
md: bind<sdd1>
md: bind<sdc1>
md: bind<sde1>
md: bind<sdb1>
raid5: device sdb1 operational as raid disk 0
raid5: device sdc1 operational as raid disk 2
raid5: device sdd1 operational as raid disk 1
raid5: allocated 3170kB for md0
raid5: raid level 5 set md0 active with 3 out of 3 devices, algorithm 2
RAID5 conf printout:
 --- rd:3 wd:3
 disk 0, o:1, dev:sdb1
 disk 1, o:1, dev:sdd1
 disk 2, o:1, dev:sdc1
loop: module loaded
ReiserFS: md1: found reiserfs format "3.6" with standard journal
ReiserFS: md1: using ordered data mode
ReiserFS: md1: journal params: device md1, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: md1: checking transaction log (md1)
ReiserFS: md1: Using r5 hash to sort names
fuse init (API version 7.8)
Adding 265032k swap on /dev/sda6.  Priority:-1 extents:1 across:265032k
CAPI Subsystem Rev 1.1.2.8
capifs: Rev 1.1.2.3
capi20: Rev 1.1.2.7: started up with major 68 (middleware+capifs)
fcpci: module license 'Proprietary' taints kernel.
fcpci: AVM FRITZ!Card PCI driver, revision 0.7.2
fcpci: (fcpci built on Nov 11 2007 at 16:37:14)
fcpci: -- 32 bit CAPI driver --
ACPI: PCI Interrupt 0000:00:09.0[A] -> Link [LNKC] -> GSI 5 (level, low) -> IRQ 5
fcpci: AVM FRITZ!Card PCI found: port 0xd400, irq 5
fcpci: Loading...
fcpci: Driver 'fcpci' attached to fcpci-stack. (152)
fcpci: Stack version 3.11-07
kcapi: Controller [001]: fcpci-d400-05 attached
kcapi: card [001] "fcpci-d400-05" ready.
fcpci: Loaded.
ISDN subsystem Rev: 1.1.2.3/1.1.2.3/1.1.2.2/1.1.2.3/1.1.2.2/1.1.2.2 loaded
capidrv-1: now up (0 B channels)
capidrv-1: not from AVM, no d-channel trace possible ()
capidrv: Rev 1.1.2.2: loaded
eth0: link down
eth0: link down
ip6_tables: (C) 2000-2006 Netfilter Core Team
ip_tables: (C) 2000-2006 Netfilter Core Team
eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
audit(1194871990.501:2): audit_pid=3561 old=0 by auid=4294967295
it87: Found IT8705F chip at 0x290, revision 3
NET: Registered protocol family 17
tun: Universal TUN/TAP device driver, 1.6
tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
NFSD: Using /var/lib/nfs/v4recovery as the NFSv4 state recovery directory
NFSD: starting 90-second grace period
ReiserFS: md0: found reiserfs format "3.6" with standard journal
ReiserFS: md0: using ordered data mode
ReiserFS: md0: journal params: device md0, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: md0: checking transaction log (md0)
ReiserFS: md0: Using r5 hash to sort names
ReiserFS: sdb3: found reiserfs format "3.6" with standard journal
ReiserFS: sdb3: using ordered data mode
ReiserFS: sdb3: journal params: device sdb3, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: sdb3: checking transaction log (sdb3)
ReiserFS: sdb3: Using r5 hash to sort names
ReiserFS: sdf1: found reiserfs format "3.6" with standard journal
ReiserFS: sdf1: using ordered data mode
ReiserFS: sdf1: journal params: device sdf1, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: sdf1: checking transaction log (sdf1)
ReiserFS: sdf1: Using r5 hash to sort names
ata6.00: failed to read SCR 1 (Emask=0x40)
ata6.01: failed to read SCR 1 (Emask=0x40)
ata6.02: failed to read SCR 1 (Emask=0x40)
ata6.03: failed to read SCR 1 (Emask=0x40)
ata6.04: failed to read SCR 1 (Emask=0x40)
ata6.05: failed to read SCR 1 (Emask=0x40)
ata6.00: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata6.01: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata6.02: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata6.02: cmd ea/00:00:00:00:00/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata6.02: status: { DRDY }
ata6.03: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata6.04: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata6.05: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata6.15: hard resetting link
ata6.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
ata6.00: hard resetting link
ata6.00: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata6.01: hard resetting link
ata6.01: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata6.02: hard resetting link
ata6.02: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata6.03: hard resetting link
ata6.03: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata6.04: hard resetting link
ata6.04: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata6.05: hard resetting link
ata6.05: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata6.00: configured for UDMA/100
ata6.01: configured for UDMA/100
ata6.02: configured for UDMA/100
ata6.03: configured for UDMA/100
ata6.04: configured for UDMA/100
ata6: EH complete
sd 5:0:0:0: [sdb] 586072368 512-byte hardware sectors (300069 MB)
sd 5:0:0:0: [sdb] Write Protect is off
sd 5:0:0:0: [sdb] Mode Sense: 00 3a 00 00
sd 5:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 5:1:0:0: [sdc] 488397168 512-byte hardware sectors (250059 MB)
sd 5:1:0:0: [sdc] Write Protect is off
sd 5:1:0:0: [sdc] Mode Sense: 00 3a 00 00
sd 5:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 5:2:0:0: [sdd] 488397168 512-byte hardware sectors (250059 MB)
sd 5:2:0:0: [sdd] Write Protect is off
sd 5:2:0:0: [sdd] Mode Sense: 00 3a 00 00
sd 5:2:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 5:3:0:0: [sde] 312581808 512-byte hardware sectors (160042 MB)
sd 5:3:0:0: [sde] Write Protect is off
sd 5:3:0:0: [sde] Mode Sense: 00 3a 00 00
sd 5:3:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 5:4:0:0: [sdf] 976773168 512-byte hardware sectors (500108 MB)
sd 5:4:0:0: [sdf] Write Protect is off
sd 5:4:0:0: [sdf] Mode Sense: 00 3a 00 00
sd 5:4:0:0: [sdf] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 5:0:0:0: [sdb] 586072368 512-byte hardware sectors (300069 MB)
sd 5:0:0:0: [sdb] Write Protect is off
sd 5:0:0:0: [sdb] Mode Sense: 00 3a 00 00
sd 5:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 5:1:0:0: [sdc] 488397168 512-byte hardware sectors (250059 MB)
sd 5:1:0:0: [sdc] Write Protect is off
sd 5:1:0:0: [sdc] Mode Sense: 00 3a 00 00
sd 5:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 5:2:0:0: [sdd] 488397168 512-byte hardware sectors (250059 MB)
sd 5:2:0:0: [sdd] Write Protect is off
sd 5:2:0:0: [sdd] Mode Sense: 00 3a 00 00
sd 5:2:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 5:3:0:0: [sde] 312581808 512-byte hardware sectors (160042 MB)
sd 5:3:0:0: [sde] Write Protect is off
sd 5:3:0:0: [sde] Mode Sense: 00 3a 00 00
sd 5:3:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 5:4:0:0: [sdf] 976773168 512-byte hardware sectors (500108 MB)
sd 5:4:0:0: [sdf] Write Protect is off
sd 5:4:0:0: [sdf] Mode Sense: 00 3a 00 00
sd 5:4:0:0: [sdf] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
capidrv-1: incoming call on not existing bchan ?
capidrv-1: DISCONNECT_RESP: plci 0x101 not found
capidrv-1: incoming call on not existing bchan ?
capidrv-1: DISCONNECT_RESP: plci 0x101 not found
capidrv-1: incoming call on not existing bchan ?
capidrv-1: DISCONNECT_RESP: plci 0x101 not found
ata6.00: failed to read SCR 1 (Emask=0x40)
ata6.01: failed to read SCR 1 (Emask=0x40)
ata6.02: failed to read SCR 1 (Emask=0x40)
ata6.03: failed to read SCR 1 (Emask=0x40)
ata6.04: failed to read SCR 1 (Emask=0x40)
ata6.05: failed to read SCR 1 (Emask=0x40)
ata6.00: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata6.01: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata6.01: cmd ea/00:00:00:00:00/00:00:00:00:00/a0 tag 1 cdb 0x0 data 0 
         res 40/00:00:01:4f:c2/00:00:00:00:00/00 Emask 0x4 (timeout)
ata6.01: status: { DRDY }
ata6.02: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata6.03: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata6.04: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata6.05: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata6.15: hard resetting link
ata6.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
ata6.00: hard resetting link
ata6.00: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata6.01: hard resetting link
ata6.01: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata6.02: hard resetting link
ata6.02: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata6.03: hard resetting link
ata6.03: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata6.04: hard resetting link
ata6.04: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata6.05: hard resetting link
ata6.05: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata6.00: configured for UDMA/100
ata6.01: configured for UDMA/100
ata6.02: configured for UDMA/100
ata6.03: configured for UDMA/100
ata6.04: configured for UDMA/100
ata6: EH complete
sd 5:0:0:0: [sdb] 586072368 512-byte hardware sectors (300069 MB)
sd 5:0:0:0: [sdb] Write Protect is off
sd 5:0:0:0: [sdb] Mode Sense: 00 3a 00 00
sd 5:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 5:1:0:0: [sdc] 488397168 512-byte hardware sectors (250059 MB)
sd 5:1:0:0: [sdc] Write Protect is off
sd 5:1:0:0: [sdc] Mode Sense: 00 3a 00 00
sd 5:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 5:2:0:0: [sdd] 488397168 512-byte hardware sectors (250059 MB)
sd 5:2:0:0: [sdd] Write Protect is off
sd 5:2:0:0: [sdd] Mode Sense: 00 3a 00 00
sd 5:2:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 5:3:0:0: [sde] 312581808 512-byte hardware sectors (160042 MB)
sd 5:3:0:0: [sde] Write Protect is off
sd 5:3:0:0: [sde] Mode Sense: 00 3a 00 00
sd 5:3:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 5:4:0:0: [sdf] 976773168 512-byte hardware sectors (500108 MB)
sd 5:4:0:0: [sdf] Write Protect is off
sd 5:4:0:0: [sdf] Mode Sense: 00 3a 00 00
sd 5:4:0:0: [sdf] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 5:0:0:0: [sdb] 586072368 512-byte hardware sectors (300069 MB)
sd 5:0:0:0: [sdb] Write Protect is off
sd 5:0:0:0: [sdb] Mode Sense: 00 3a 00 00
sd 5:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 5:1:0:0: [sdc] 488397168 512-byte hardware sectors (250059 MB)
sd 5:1:0:0: [sdc] Write Protect is off
sd 5:1:0:0: [sdc] Mode Sense: 00 3a 00 00
sd 5:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 5:2:0:0: [sdd] 488397168 512-byte hardware sectors (250059 MB)
sd 5:2:0:0: [sdd] Write Protect is off
sd 5:2:0:0: [sdd] Mode Sense: 00 3a 00 00
sd 5:2:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 5:3:0:0: [sde] 312581808 512-byte hardware sectors (160042 MB)
sd 5:3:0:0: [sde] Write Protect is off
sd 5:3:0:0: [sde] Mode Sense: 00 3a 00 00
sd 5:3:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 5:4:0:0: [sdf] 976773168 512-byte hardware sectors (500108 MB)
sd 5:4:0:0: [sdf] Write Protect is off
sd 5:4:0:0: [sdf] Mode Sense: 00 3a 00 00
sd 5:4:0:0: [sdf] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
ata6.00: failed to read SCR 1 (Emask=0x40)
ata6.01: failed to read SCR 1 (Emask=0x40)
ata6.02: failed to read SCR 1 (Emask=0x40)
ata6.03: failed to read SCR 1 (Emask=0x40)
ata6.04: failed to read SCR 1 (Emask=0x40)
ata6.05: failed to read SCR 1 (Emask=0x40)
ata6.00: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata6.01: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata6.02: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata6.02: cmd ea/00:00:00:00:00/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
         res 40/00:00:09:4f:c2/00:00:00:00:00/00 Emask 0x4 (timeout)
ata6.02: status: { DRDY }
ata6.03: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata6.04: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata6.05: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata6.15: hard resetting link
ata6.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
ata6.00: hard resetting link
ata6.00: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata6.01: hard resetting link
ata6.01: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata6.02: hard resetting link
ata6.02: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata6.03: hard resetting link
ata6.03: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata6.04: hard resetting link
ata6.04: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata6.05: hard resetting link
ata6.05: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata6.00: configured for UDMA/100
ata6.01: configured for UDMA/100
ata6.02: configured for UDMA/100
ata6.03: configured for UDMA/100
ata6.04: configured for UDMA/100
ata6: EH complete
sd 5:0:0:0: [sdb] 586072368 512-byte hardware sectors (300069 MB)
sd 5:0:0:0: [sdb] Write Protect is off
sd 5:0:0:0: [sdb] Mode Sense: 00 3a 00 00
sd 5:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 5:1:0:0: [sdc] 488397168 512-byte hardware sectors (250059 MB)
sd 5:1:0:0: [sdc] Write Protect is off
sd 5:1:0:0: [sdc] Mode Sense: 00 3a 00 00
sd 5:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 5:2:0:0: [sdd] 488397168 512-byte hardware sectors (250059 MB)
sd 5:2:0:0: [sdd] Write Protect is off
sd 5:2:0:0: [sdd] Mode Sense: 00 3a 00 00
sd 5:2:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 5:3:0:0: [sde] 312581808 512-byte hardware sectors (160042 MB)
sd 5:3:0:0: [sde] Write Protect is off
sd 5:3:0:0: [sde] Mode Sense: 00 3a 00 00
sd 5:3:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 5:4:0:0: [sdf] 976773168 512-byte hardware sectors (500108 MB)
sd 5:4:0:0: [sdf] Write Protect is off
sd 5:4:0:0: [sdf] Mode Sense: 00 3a 00 00
sd 5:4:0:0: [sdf] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 5:0:0:0: [sdb] 586072368 512-byte hardware sectors (300069 MB)
sd 5:0:0:0: [sdb] Write Protect is off
sd 5:0:0:0: [sdb] Mode Sense: 00 3a 00 00
sd 5:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 5:1:0:0: [sdc] 488397168 512-byte hardware sectors (250059 MB)
sd 5:1:0:0: [sdc] Write Protect is off
sd 5:1:0:0: [sdc] Mode Sense: 00 3a 00 00
sd 5:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 5:2:0:0: [sdd] 488397168 512-byte hardware sectors (250059 MB)
sd 5:2:0:0: [sdd] Write Protect is off
sd 5:2:0:0: [sdd] Mode Sense: 00 3a 00 00
sd 5:2:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 5:3:0:0: [sde] 312581808 512-byte hardware sectors (160042 MB)
sd 5:3:0:0: [sde] Write Protect is off
sd 5:3:0:0: [sde] Mode Sense: 00 3a 00 00
sd 5:3:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 5:4:0:0: [sdf] 976773168 512-byte hardware sectors (500108 MB)
sd 5:4:0:0: [sdf] Write Protect is off
sd 5:4:0:0: [sdf] Mode Sense: 00 3a 00 00
sd 5:4:0:0: [sdf] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
ReiserFS: sda2: found reiserfs format "3.6" with standard journal
ReiserFS: sda2: using ordered data mode
ReiserFS: sda2: journal params: device sda2, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: sda2: checking transaction log (sda2)
ReiserFS: sda2: Using r5 hash to sort names
ata6.00: failed to read SCR 1 (Emask=0x40)
ata6.01: failed to read SCR 1 (Emask=0x40)
ata6.02: failed to read SCR 1 (Emask=0x40)
ata6.03: failed to read SCR 1 (Emask=0x40)
ata6.04: failed to read SCR 1 (Emask=0x40)
ata6.05: failed to read SCR 1 (Emask=0x40)
ata6.00: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata6.01: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata6.02: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata6.02: cmd ea/00:00:00:00:00/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
         res 40/00:00:09:4f:c2/00:00:00:00:00/00 Emask 0x4 (timeout)
ata6.02: status: { DRDY }
ata6.03: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata6.04: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata6.05: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata6.15: hard resetting link
ata6.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
ata6.00: hard resetting link
ata6.00: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata6.01: hard resetting link
ata6.01: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata6.02: hard resetting link
ata6.02: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata6.03: hard resetting link
ata6.03: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata6.04: hard resetting link
ata6.04: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata6.05: hard resetting link
ata6.05: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata6.00: configured for UDMA/100
ata6.01: configured for UDMA/100
ata6.02: configured for UDMA/100
ata6.03: configured for UDMA/100
ata6.04: configured for UDMA/100
ata6: EH complete
sd 5:0:0:0: [sdb] 586072368 512-byte hardware sectors (300069 MB)
sd 5:0:0:0: [sdb] Write Protect is off
sd 5:0:0:0: [sdb] Mode Sense: 00 3a 00 00
sd 5:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 5:1:0:0: [sdc] 488397168 512-byte hardware sectors (250059 MB)
sd 5:1:0:0: [sdc] Write Protect is off
sd 5:1:0:0: [sdc] Mode Sense: 00 3a 00 00
sd 5:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 5:2:0:0: [sdd] 488397168 512-byte hardware sectors (250059 MB)
sd 5:2:0:0: [sdd] Write Protect is off
sd 5:2:0:0: [sdd] Mode Sense: 00 3a 00 00
sd 5:2:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 5:3:0:0: [sde] 312581808 512-byte hardware sectors (160042 MB)
sd 5:3:0:0: [sde] Write Protect is off
sd 5:3:0:0: [sde] Mode Sense: 00 3a 00 00
sd 5:3:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 5:4:0:0: [sdf] 976773168 512-byte hardware sectors (500108 MB)
sd 5:4:0:0: [sdf] Write Protect is off
sd 5:4:0:0: [sdf] Mode Sense: 00 3a 00 00
sd 5:4:0:0: [sdf] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 5:0:0:0: [sdb] 586072368 512-byte hardware sectors (300069 MB)
sd 5:0:0:0: [sdb] Write Protect is off
sd 5:0:0:0: [sdb] Mode Sense: 00 3a 00 00
sd 5:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 5:1:0:0: [sdc] 488397168 512-byte hardware sectors (250059 MB)
sd 5:1:0:0: [sdc] Write Protect is off
sd 5:1:0:0: [sdc] Mode Sense: 00 3a 00 00
sd 5:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 5:2:0:0: [sdd] 488397168 512-byte hardware sectors (250059 MB)
sd 5:2:0:0: [sdd] Write Protect is off
sd 5:2:0:0: [sdd] Mode Sense: 00 3a 00 00
sd 5:2:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 5:3:0:0: [sde] 312581808 512-byte hardware sectors (160042 MB)
sd 5:3:0:0: [sde] Write Protect is off
sd 5:3:0:0: [sde] Mode Sense: 00 3a 00 00
sd 5:3:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 5:4:0:0: [sdf] 976773168 512-byte hardware sectors (500108 MB)
sd 5:4:0:0: [sdf] Write Protect is off
sd 5:4:0:0: [sdf] Mode Sense: 00 3a 00 00
sd 5:4:0:0: [sdf] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
capidrv-1: incoming call on not existing bchan ?
capidrv-1: DISCONNECT_RESP: plci 0x101 not found

--------------010307090001020806050500--
