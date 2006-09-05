From: Ric Wheeler <ric@emc.com>
Subject: faulty disk testing
Date: Mon, 04 Sep 2006 21:30:16 -0400
Message-ID: <44FCD328.3020800@emc.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------010607070103030305000903"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mexforward.lss.emc.com ([128.222.32.20]:37573 "EHLO
	mexforward.lss.emc.com") by vger.kernel.org with ESMTP
	id S1751511AbWIEBcY (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 4 Sep 2006 21:32:24 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>, Linux-ide <linux-ide@vger.kernel.org>
Cc: Mark Lord <mlord@pobox.com>

This is a multi-part message in MIME format.
--------------010607070103030305000903
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi Tejun,

We have been trying to inject some errors on some drives & validate that 
the new error handling kicks out drives.

Using 2.6.18rc3 on a box with 4 drives - 3 good & one with an 
artificially created ecc error in the 4-way MD RAID1 partition.

The error handling worked through the various transitions, but did not 
give up on the drive well enough to let the boot continue using the other 3.

I plan to look at the state of the drive with an analyzer tomorrow to 
make sure that the drive is not holding the bus or something & try your 
latest "new init" git tree code.

What it looks like is a soft hang - maybe the box is stuck in 
ata_port_wait_eh() which never seems to timeout on a bus that does not 
recover?

Attached is the console log,

ric



--------------010607070103030305000903
Content-Type: text/plain;
 name="2-6-18-rc3.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2-6-18-rc3.txt"

Linux version 2.6.18-rc3 (ric@SLES10) (gcc version 4.1.0 (SUSE Linux)) #2 SMP Fri Sep 1 11:11:24 EDT 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f400 (usable)
 BIOS-e820: 000000000009f400 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003f6e0000 (usable)
 BIOS-e820: 000000003f6e0000 - 000000003f6e3000 (ACPI NVS)
 BIOS-e820: 000000003f6e3000 - 000000003f6f0000 (ACPI data)
 BIOS-e820: 000000003f6f0000 - 000000003f700000 (reserved)
 BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
 BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
118MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000f4c30
DMI 2.2 present.
ACPI: PM-Timer IO Port: 0x408
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 15:3 APIC version 20
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
Processor #1 15:3 APIC version 20
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 40000000 (gap: 3f700000:a0900000)
Detected 2800.219 MHz processor.
Built 1 zonelists.  Total pages: 259808
Kernel command line: root=/dev/md3 BOOT_IMAGE=production-m elevator=as console=tty0 console=ttyS0,115200n8
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 16384 bytes)
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 1026444k/1039232k available (2029k kernel code, 12164k reserved, 662k data, 200k init, 121728k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 5605.26 BogoMIPS (lpj=11210526)
Mount-cache hash table entries: 512
monitor/mwait feature present.
using mwait in idle threads.
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU: Physical Processor ID: 0
Compat vDSO mapped to ffffe000.
Checking 'hlt' instruction... OK.
Freeing SMP alternatives: 16k freed
ACPI: Core revision 20060707
CPU0: Intel(R) Pentium(R) 4 CPU 2.80GHz stepping 04
Booting processor 1/1 eip 2000
Initializing CPU#1
Calibrating delay using timer specific routine.. 5600.66 BogoMIPS (lpj=11201324)
monitor/mwait feature present.
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU: Physical Processor ID: 0
CPU1: Intel(R) Pentium(R) 4 CPU 2.80GHz stepping 04
Total of 2 processors activated (11205.92 BogoMIPS).
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
checking TSC synchronization across 2 CPUs: passed.
Brought up 2 CPUs
migration_cost=104
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: Using MMCONFIG
Setting up standard PCI resources
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: PXH quirk detected, disabling MSI for SHPC device
PCI: PXH quirk detected, disabling MSI for SHPC device
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 9 10 *12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 *5 7 9 10 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 *7 9 10 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 7 9 *10 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 7 9 10 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 7 9 10 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNK0] (IRQs 3 4 5 7 9 10 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNK1] (IRQs *3 4 5 7 9 10 12 14 15)
SCSI subsystem initialized
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq". PCI: Ignore bogus resource 6 [0:0] of 0000:00:02.0
PCI: Bridge: 0000:01:00.0
  IO window: c000-cfff
  MEM window: d0000000-d00fffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:01:00.2
  IO window: d000-dfff
  MEM window: d0100000-d01fffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:01.0
  IO window: c000-dfff
  MEM window: d0000000-d02fffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:1e.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
ACPI: PCI Interrupt 0000:00:01.0[A] -> GSI 16 (level, low) -> IRQ 16
NET: Registered protocol family 2
IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
TCP established hash table entries: 131072 (order: 8, 1048576 bytes)
TCP bind hash table entries: 65536 (order: 7, 524288 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
TCP reno registered
IA-32 Microcode Update Driver: v1.14a <tigran@veritas.com>
highmem bounce pool size: 64 pages
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
assign_interrupt_mode Found MSI capability
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 32768K size 1024 blocksize
loop: loaded (max 8 devices)
Intel(R) PRO/1000 Network Driver - version 7.1.9-k4
Copyright (c) 1999-2006 Intel Corporation.
ACPI: PCI Interrupt 0000:02:06.0[A] -> GSI 19 (level, low) -> IRQ 17
e1000: 0000:02:06.0: e1000_probe: (PCI-X:133MHz:64-bit) 00:e0:81:65:62:50
e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
ACPI: PCI Interrupt 0000:02:06.1[B] -> GSI 18 (level, low) -> IRQ 18
e1000: 0000:02:06.1: e1000_probe: (PCI-X:133MHz:64-bit) 00:e0:81:65:62:51
e1000: eth1: e1000_probe: Intel(R) PRO/1000 Network Connection
ACPI: PCI Interrupt 0000:03:07.0[A] -> GSI 17 (level, low) -> IRQ 19
e1000: 0000:03:07.0: e1000_probe: (PCI-X:133MHz:64-bit) 00:e0:81:65:62:52
e1000: eth2: e1000_probe: Intel(R) PRO/1000 Network Connection
ACPI: PCI Interrupt 0000:03:07.1[B] -> GSI 16 (level, low) -> IRQ 16
e1000: 0000:03:07.1: e1000_probe: (PCI-X:133MHz:64-bit) 00:e0:81:65:62:53
e1000: eth3: e1000_probe: Intel(R) PRO/1000 Network Connection
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 19 (level, low) -> IRQ 17
ahci 0000:00:1f.2: AHCI 0001.0000 32 slots 4 ports 1.5 Gbps 0xf impl IDE mode
ahci 0000:00:1f.2: flags: 64bit ncq pm led 
ata1: SATA max UDMA/133 cmd 0xF8802100 ctl 0x0 bmdma 0x0 irq 17
ata2: SATA max UDMA/133 cmd 0xF8802180 ctl 0x0 bmdma 0x0 irq 17
ata3: SATA max UDMA/133 cmd 0xF8802200 ctl 0x0 bmdma 0x0 irq 17
ata4: SATA max UDMA/133 cmd 0xF8802280 ctl 0x0 bmdma 0x0 irq 17
scsi0 : ahci
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.00: ATA-7, max UDMA/133, 625142448 sectors: LBA48 NCQ (depth 31/32)
ata1.00: ata1: dev 0 multi count 0
ata1.00: configured for UDMA/133
scsi1 : ahci
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata2.00: ATA-7, max UDMA/133, 625142448 sectors: LBA48 NCQ (depth 31/32)
ata2.00: ata2: dev 0 multi count 0
ata2.00: configured for UDMA/133
scsi2 : ahci
ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata3.00: ATA-7, max UDMA/133, 625142448 sectors: LBA48 NCQ (depth 31/32)
ata3.00: ata3: dev 0 multi count 0
ata3.00: configured for UDMA/133
scsi3 : ahci
ata4: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata4.00: ATA-7, max UDMA/133, 625142448 sectors: LBA48 NCQ (depth 31/32)
ata4.00: ata4: dev 0 multi count 0
ata4.00: configured for UDMA/133
  Vendor: ATA       Model: Maxtor 7B320S0    Rev: BANC
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: ATA       Model: Maxtor 7B320S0    Rev: BANC
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: ATA       Model: Maxtor 7B320S0    Rev: BANC
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: ATA       Model: Maxtor 7B320S0    Rev: BANC
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 625142448 512-byte hdwr sectors (320073 MB)
sda: Write Protect is off
SCSI device sda: drive cache: write through
SCSI device sda: 625142448 512-byte hdwr sectors (320073 MB)
sda: Write Protect is off
SCSI device sda: drive cache: write through
 sda: sda1 sda2 sda3 sda4 < sda5 sda6 sda7 sda8 sda9 sda10 sda11 sda12 sda13 sda14 >
sd 0:0:0:0: Attached scsi disk sda
SCSI device sdb: 625142448 512-byte hdwr sectors (320073 MB)
sdb: Write Protect is off
SCSI device sdb: drive cache: write through
SCSI device sdb: 625142448 512-byte hdwr sectors (320073 MB)
sdb: Write Protect is off
SCSI device sdb: drive cache: write through
 sdb: sdb1 sdb2 sdb3 sdb4 < sdb5 sdb6 sdb7 sdb8 sdb9 sdb10 sdb11 sdb12 sdb13 sdb14 >
sd 1:0:0:0: Attached scsi disk sdb
SCSI device sdc: 625142448 512-byte hdwr sectors (320073 MB)
sdc: Write Protect is off
SCSI device sdc: drive cache: write through
SCSI device sdc: 625142448 512-byte hdwr sectors (320073 MB)
sdc: Write Protect is off
SCSI device sdc: drive cache: write through
 sdc: sdc1 sdc2 sdc3 sdc4 < sdc5 sdc6 sdc7 sdc8 sdc9 sdc10 sdc11 sdc12 sdc13 sdc14 >
sd 2:0:0:0: Attached scsi disk sdc
SCSI device sdd: 625142448 512-byte hdwr sectors (320073 MB)
sdd: Write Protect is off
SCSI device sdd: drive cache: write through
SCSI device sdd: 625142448 512-byte hdwr sectors (320073 MB)
sdd: Write Protect is off
SCSI device sdd: drive cache: write through
 sdd: sdd1 sdd2 sdd3 sdd4 < sdd5 sdd6 sdd7 sdd8 sdd9 sdd10 sdd11 sdd12 sdd13 sdd14 >
sd 3:0:0:0: Attached scsi disk sdd
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
mice: PS/2 mouse device common for all mice
i2c /dev entries driver
md: raid1 personality registered for level 1
md: md driver 0.90.3 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: bitmap version 4.39
TCP bic registered
NET: Registered protocol family 1
Starting balanced_irq
Using IPI Shortcut mode
md: Autodetecting RAID arrays.
Time: tsc clocksource has been installed.
input: AT Translated Set 2 keyboard as /class/input/input0
ata2: failed to read log page 10h (errno=-2)
ata2.00: exception Emask 0x1 SAct 0x1 SErr 0x0 action 0x0
ata2.00: (irq_stat 0x40000008)
ata2.00: tag 0 cmd 0x60 Emask 0x1 stat 0x40 err 0x0 (device error)
ata2: EH complete
SCSI device sdb: 625142448 512-byte hdwr sectors (320073 MB)
sdb: Write Protect is off
SCSI device sdb: drive cache: write through
ata2: failed to read log page 10h (errno=-2)
ata2.00: exception Emask 0x1 SAct 0x1 SErr 0x0 action 0x0
ata2.00: (irq_stat 0x40000008)
ata2.00: tag 0 cmd 0x60 Emask 0x1 stat 0x40 err 0x0 (device error)
ata2: EH complete
SCSI device sdb: 625142448 512-byte hdwr sectors (320073 MB)
sdb: Write Protect is off
SCSI device sdb: drive cache: write through
ata2: failed to read log page 10h (errno=-2)
ata2.00: exception Emask 0x1 SAct 0x1 SErr 0x0 action 0x0
ata2.00: (irq_stat 0x40000008)
ata2.00: tag 0 cmd 0x60 Emask 0x1 stat 0x40 err 0x0 (device error)
ata2: EH complete
SCSI device sdb: 625142448 512-byte hdwr sectors (320073 MB)
sdb: Write Protect is off
SCSI device sdb: drive cache: write through
ata2: failed to read log page 10h (errno=-2)
ata2.00: exception Emask 0x1 SAct 0x1 SErr 0x0 action 0x0
ata2.00: (irq_stat 0x40000008)
ata2.00: tag 0 cmd 0x60 Emask 0x1 stat 0x40 err 0x0 (device error)
ata2: EH complete
SCSI device sdb: 625142448 512-byte hdwr sectors (320073 MB)
sdb: Write Protect is off
SCSI device sdb: drive cache: write through
ata2: failed to read log page 10h (errno=-2)
ata2.00: exception Emask 0x1 SAct 0x1 SErr 0x0 action 0x0
ata2.00: (irq_stat 0x40000008)
ata2.00: tag 0 cmd 0x60 Emask 0x1 stat 0x40 err 0x0 (device error)
ata2: EH complete
SCSI device sdb: 625142448 512-byte hdwr sectors (320073 MB)
sdb: Write Protect is off
SCSI device sdb: drive cache: write through
ata2: failed to read log page 10h (errno=-2)
ata2.00: exception Emask 0x1 SAct 0x1 SErr 0x0 action 0x0
ata2.00: (irq_stat 0x40000008)
ata2.00: tag 0 cmd 0x60 Emask 0x1 stat 0x40 err 0x0 (device error)
sd 1:0:0:0: SCSI error: return code = 0x08000002
sdb: Current: sense key: Aborted Command
    Additional sense: No additional sense information
end_request: I/O error, dev sdb, sector 272900
md: disabled device sdb3, could not read superblock.
ata2: EH complete
SCSI device sdb: 625142448 512-byte hdwr sectors (320073 MB)
sdb: Write Protect is off
SCSI device sdb: drive cache: write through
md: sdb3 has invalid sb, not importing!
md: autorun ...
md: considering sdd8 ...
md:  adding sdd8 ...
md: sdd7 has different UUID to sdd8
md: sdd6 has different UUID to sdd8
md: sdd5 has different UUID to sdd8
md: sdd3 has different UUID to sdd8
md:  adding sdc8 ...
md: sdc7 has different UUID to sdd8
md: sdc6 has different UUID to sdd8
md: sdc5 has different UUID to sdd8
md: sdc3 has different UUID to sdd8
md: sdb8 has different UUID to sdd8
md: sdb7 has different UUID to sdd8
md: sdb6 has different UUID to sdd8
md: sdb5 has different UUID to sdd8
md:  adding sda8 ...
md: sda7 has different UUID to sdd8
md: sda6 has different UUID to sdd8
md: sda5 has different UUID to sdd8
md: sda3 has different UUID to sdd8
md: created md8
md: bind<sda8>
md: bind<sdc8>
md: bind<sdd8>
md: running: <sdd8><sdc8><sda8>
raid1: raid set md8 active with 3 out of 4 mirrors
md: considering sdd7 ...
md:  adding sdd7 ...
md: sdd6 has different UUID to sdd7
md: sdd5 has different UUID to sdd7
md: sdd3 has different UUID to sdd7
md:  adding sdc7 ...
md: sdc6 has different UUID to sdd7
md: sdc5 has different UUID to sdd7
md: sdc3 has different UUID to sdd7
md: sdb8 has different UUID to sdd7
md: sdb7 has different UUID to sdd7
md: sdb6 has different UUID to sdd7
md: sdb5 has different UUID to sdd7
md:  adding sda7 ...
md: sda6 has different UUID to sdd7
md: sda5 has different UUID to sdd7
md: sda3 has different UUID to sdd7
md: created md7
md: bind<sda7>
md: bind<sdc7>
md: bind<sdd7>
md: running: <sdd7><sdc7><sda7>
raid1: raid set md7 active with 3 out of 4 mirrors
md: considering sdd6 ...
md:  adding sdd6 ...
md: sdd5 has different UUID to sdd6
md: sdd3 has different UUID to sdd6
md:  adding sdc6 ...
md: sdc5 has different UUID to sdd6
md: sdc3 has different UUID to sdd6
md: sdb8 has different UUID to sdd6
md: sdb7 has different UUID to sdd6
md: sdb6 has different UUID to sdd6
md: sdb5 has different UUID to sdd6
md:  adding sda6 ...
md: sda5 has different UUID to sdd6
md: sda3 has different UUID to sdd6
md: created md6
md: bind<sda6>
md: bind<sdc6>
md: bind<sdd6>
md: running: <sdd6><sdc6><sda6>
raid1: raid set md6 active with 3 out of 4 mirrors
md: considering sdd5 ...
md:  adding sdd5 ...
md: sdd3 has different UUID to sdd5
md:  adding sdc5 ...
md: sdc3 has different UUID to sdd5
md: sdb8 has different UUID to sdd5
md: sdb7 has different UUID to sdd5
md: sdb6 has different UUID to sdd5
md: sdb5 has different UUID to sdd5
md:  adding sda5 ...
md: sda3 has different UUID to sdd5
md: created md5
md: bind<sda5>
md: bind<sdc5>
md: bind<sdd5>
md: running: <sdd5><sdc5><sda5>
raid1: raid set md5 active with 3 out of 4 mirrors
md: considering sdd3 ...
md:  adding sdd3 ...
md:  adding sdc3 ...
md: sdb8 has different UUID to sdd3
md: sdb7 has different UUID to sdd3
md: sdb6 has different UUID to sdd3
md: sdb5 has different UUID to sdd3
md:  adding sda3 ...
md: created md3
md: bind<sda3>
md: bind<sdc3>
md: bind<sdd3>
md: running: <sdd3><sdc3><sda3>
raid1: raid set md3 active with 3 out of 4 mirrors
md: considering sdb8 ...
md:  adding sdb8 ...
md: sdb7 has different UUID to sdb8
md: sdb6 has different UUID to sdb8
md: sdb5 has different UUID to sdb8
md: md8 already running, cannot run sdb8
md: export_rdev(sdb8)
md: considering sdb7 ...
md:  adding sdb7 ...
md: sdb6 has different UUID to sdb7
md: sdb5 has different UUID to sdb7
md: md7 already running, cannot run sdb7
md: export_rdev(sdb7)
md: considering sdb6 ...
md:  adding sdb6 ...
md: sdb5 has different UUID to sdb6
md: md6 already running, cannot run sdb6
md: export_rdev(sdb6)
md: considering sdb5 ...
md:  adding sdb5 ...
md: md5 already running, cannot run sdb5
md: export_rdev(sdb5)
md: ... autorun DONE.
ReiserFS: md3: found reiserfs format "3.6" with standard journal
ReiserFS: md3: using ordered data mode
ReiserFS: md3: journal params: device md3, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: md3: checking transaction log (md3)
ReiserFS: md3: Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly.
Freeing unused kernel memory: 200k freed
INIT: version 2.86 booting
System Boot Control: Running /etc/init.d/boot
Mounting procfs at /procdone
Mounting sysfs at /sysdone
Mounting debugfs at /sys/kernel/debugdone
Mounting tmpfs at /devdone
Initializing /devdone
Mounting devpts at /dev/ptsdone
showconsole: Warning: the ioctl TIOCGDEV is not known by the kernel
/bin/mknod -m600 /dev/shm/root b 9 3
Checking root file system...
fsck 1.34 (25-Jul-2003)
[/sbin/fsck.reiserfs (1) -- /dev/shm/root] fsck.reiserfs -a /dev/shm/root 
Reiserfs super block in block 16 on 0x903 of format 3.6 with standard journal
Blocks (total/free): 26080/6435 by 4096 bytes
Filesystem is clean
Filesystem seems mounted read-only. Skipping journal replay.
Checking internal tree..finished
doneLoading NEI modulesFATAL: Module neismbus not found.
failed
Starting NEI servicedone
Starting udevd ata2: failed to read log page 10h (errno=-2)
ata2.00: exception Emask 0x1 SAct 0xc SErr 0x0 action 0x0
ata2.00: (irq_stat 0x40000008)
ata2.00: tag 2 cmd 0x60 Emask 0x1 stat 0x40 err 0x0 (device error)
ata2.00: tag 3 cmd 0x60 Emask 0x1 stat 0x40 err 0x0 (device error)
ata2: EH complete
SCSI device sdb: 625142448 512-byte hdwr sectors (320073 MB)
sdb: Write Protect is off
SCSI device sdb: drive cache: write through
ata2: failed to read log page 10h (errno=-2)
ata2.00: exception Emask 0x1 SAct 0x3 SErr 0x0 action 0x0
ata2.00: (irq_stat 0x40000008)
ata2.00: tag 0 cmd 0x60 Emask 0x1 stat 0x40 err 0x0 (device error)
ata2.00: tag 1 cmd 0x60 Emask 0x1 stat 0x40 err 0x0 (device error)
ata2: EH complete
SCSI device sdb: 625142448 512-byte hdwr sectors (320073 MB)
sdb: Write Protect is off
SCSI device sdb: drive cache: write through
ata2: failed to read log page 10h (errno=-2)
ata2.00: exception Emask 0x1 SAct 0x3 SErr 0x0 action 0x0
ata2.00: (irq_stat 0x40000008)
ata2.00: tag 0 cmd 0x60 Emask 0x1 stat 0x40 err 0x0 (device error)
ata2.00: tag 1 cmd 0x60 Emask 0x1 stat 0x40 err 0x0 (device error)
ata2: EH complete
SCSI device sdb: 625142448 512-byte hdwr sectors (320073 MB)
sdb: Write Protect is off
SCSI device sdb: drive cache: write through
ata2: failed to read log page 10h (errno=-2)
ata2.00: exception Emask 0x1 SAct 0x3 SErr 0x0 action 0x0
ata2.00: (irq_stat 0x40000008)
ata2.00: tag 0 cmd 0x60 Emask 0x1 stat 0x40 err 0x0 (device error)
ata2.00: tag 1 cmd 0x60 Emask 0x1 stat 0x40 err 0x0 (device error)
ata2: EH complete
SCSI device sdb: 625142448 512-byte hdwr sectors (320073 MB)
sdb: Write Protect is off
SCSI device sdb: drive cache: write through
ata2: failed to read log page 10h (errno=-2)
ata2.00: limiting speed to UDMA/100
ata2.00: exception Emask 0x1 SAct 0x3 SErr 0x0 action 0x2
ata2.00: (irq_stat 0x40000008)
ata2.00: tag 0 cmd 0x60 Emask 0x1 stat 0x40 err 0x0 (device error)
ata2.00: tag 1 cmd 0x60 Emask 0x1 stat 0x40 err 0x0 (device error)
ata2: soft resetting port
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata2.00: configured for UDMA/100
ata2: EH complete
SCSI device sdb: 625142448 512-byte hdwr sectors (320073 MB)
sdb: Write Protect is off
SCSI device sdb: drive cache: write through
ata2: failed to read log page 10h (errno=-2)
ata2.00: limiting speed to UDMA/66
ata2.00: exception Emask 0x1 SAct 0x7 SErr 0x0 action 0x2
ata2.00: (irq_stat 0x40000008)
ata2.00: tag 0 cmd 0x60 Emask 0x1 stat 0x40 err 0x0 (device error)
ata2.00: tag 1 cmd 0x60 Emask 0x1 stat 0x40 err 0x0 (device error)
ata2.00: tag 2 cmd 0x60 Emask 0x1 stat 0x40 err 0x0 (device error)
ata2: soft resetting port
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata2.00: configured for UDMA/66
sd 1:0:0:0: SCSI error: return code = 0x08000002
sdb: Current: sense key: Aborted Command
    Additional sense: No additional sense information
end_request: I/O error, dev sdb, sector 272900
Buffer I/O error on device sdb3, logical block 208640
Buffer I/O error on device sdb3, logical block 208641
Buffer I/O error on device sdb3, logical block 208642
Buffer I/O error on device sdb3, logical block 208643
Buffer I/O error on device sdb3, logical block 208644
Buffer I/O error on device sdb3, logical block 208645
Buffer I/O error on device sdb3, logical block 208646
Buffer I/O error on device sdb3, logical block 208647
ata2: EH complete
SCSI device sdb: 625142448 512-byte hdwr sectors (320073 MB)
sdb: Write Protect is off
SCSI device sdb: drive cache: write through
ata2: failed to read log page 10h (errno=-2)
ata2.00: limiting speed to UDMA/44
ata2.00: exception Emask 0x1 SAct 0x3 SErr 0x0 action 0x2
ata2.00: (irq_stat 0x40000008)
ata2.00: tag 0 cmd 0x60 Emask 0x1 stat 0x40 err 0x0 (device error)
ata2.00: tag 1 cmd 0x60 Emask 0x1 stat 0x40 err 0x0 (device error)
ata2: soft resetting port
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata2.00: configured for UDMA/44
ata2: EH complete
SCSI device sdb: 625142448 512-byte hdwr sectors (320073 MB)
sdb: Write Protect is off
SCSI device sdb: drive cache: write through
ata2: failed to read log page 10h (errno=-2)
ata2.00: limiting speed to UDMA/33
ata2.00: exception Emask 0x1 SAct 0x1e SErr 0x0 action 0x2
ata2.00: (irq_stat 0x40000008)
ata2.00: tag 1 cmd 0x60 Emask 0x1 stat 0x40 err 0x0 (device error)
ata2.00: tag 2 cmd 0x60 Emask 0x1 stat 0x40 err 0x0 (device error)
ata2.00: tag 3 cmd 0x60 Emask 0x1 stat 0x40 err 0x0 (device error)
ata2.00: tag 4 cmd 0x60 Emask 0x1 stat 0x40 err 0x0 (device error)
ata2: soft resetting port
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata2.00: configured for UDMA/33
ata2: EH complete
SCSI device sdb: 625142448 512-byte hdwr sectors (320073 MB)
sdb: Write Protect is off
SCSI device sdb: drive cache: write through
ata2: failed to read log page 10h (errno=-2)
ata2.00: limiting speed to UDMA/25
ata2.00: exception Emask 0x1 SAct 0xa SErr 0x0 action 0x2
ata2.00: (irq_stat 0x40000008)
ata2.00: tag 1 cmd 0x60 Emask 0x1 stat 0x40 err 0x0 (device error)
ata2.00: tag 3 cmd 0x60 Emask 0x1 stat 0x40 err 0x0 (device error)
ata2: soft resetting port
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata2.00: configured for UDMA/25
ata2: EH complete
SCSI device sdb: 625142448 512-byte hdwr sectors (320073 MB)
sdb: Write Protect is off
SCSI device sdb: drive cache: write through
ata2: failed to read log page 10h (errno=-2)
ata2.00: limiting speed to UDMA/16
ata2.00: exception Emask 0x1 SAct 0x3 SErr 0x0 action 0x2
ata2.00: (irq_stat 0x40000008)
ata2.00: tag 0 cmd 0x60 Emask 0x1 stat 0x40 err 0x0 (device error)
ata2.00: tag 1 cmd 0x60 Emask 0x1 stat 0x40 err 0x0 (device error)
ata2: soft resetting port
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata2.00: configured for UDMA/16
ata2: EH complete
SCSI device sdb: 625142448 512-byte hdwr sectors (320073 MB)
sdb: Write Protect is off
SCSI device sdb: drive cache: write through
ata2: failed to read log page 10h (errno=-2)
ata2.00: limiting speed to PIO4
ata2.00: exception Emask 0x1 SAct 0x3 SErr 0x0 action 0x2
ata2.00: (irq_stat 0x40000008)
ata2.00: tag 0 cmd 0x60 Emask 0x1 stat 0x40 err 0x0 (device error)
ata2.00: tag 1 cmd 0x60 Emask 0x1 stat 0x40 err 0x0 (device error)
ata2: soft resetting port
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata2.00: configured for PIO4
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: (irq_stat 0x40000001)
ata2.00: tag 0 cmd 0x20 Emask 0x9 stat 0x51 err 0x40 (media error)
sd 1:0:0:0: SCSI error: return code = 0x08000002
sdb: Current: sense key: Medium Error
    Additional sense: Unrecovered read error - auto reallocate failed
end_request: I/O error, dev sdb, sector 272900
Buffer I/O error on device sdb3, logical block 208640
Buffer I/O error on device sdb3, logical block 208641
Buffer I/O error on device sdb3, logical block 208642
Buffer I/O error on device sdb3, logical block 208643
Buffer I/O error on device sdb3, logical block 208644
Buffer I/O error on device sdb3, logical block 208645
Buffer I/O error on device sdb3, logical block 208646
Buffer I/O error on device sdb3, logical block 208647
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata2.00: tag 0 cmd 0x24 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata2: soft resetting port
ata2: softreset failed (1st FIS failed)
ata2: softreset failed, retrying in 5 secs
ata2: hard resetting port
ata2: port is slow to respond, please be patient
ata2: port failed to respond (30 secs)
ata2: COMRESET failed (device not ready)
ata2: hardreset failed, retrying in 5 secs
ata2: hard resetting port
done
e100: Intel(R) PRO/100 Network Driver, 3.5.10-k2-NAPI
e100: Copyright(c) 1999-2005 Intel Corporation
ipmi message handler version 39.0
ipmi device interface
IPMI System Interface driver.
ipmi: Found new BMC (man_id: 0x0019fd,  prod_id: 0x1426, dev_id: 0x00)
 IPMI KCS interface initialized
ipmi_si: Found default KCS state machine at I/O address 0xca2
Loading required kernel modules
doneStarting MD Raid ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata2.00: configured for PIO4
ata2: EH complete
SCSI device sdb: 625142448 512-byte hdwr sectors (320073 MB)
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata2.00: tag 0 cmd 0x24 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata2: soft resetting port
ata2: softreset failed (1st FIS failed)
ata2: softreset failed, retrying in 5 secs
ata2: hard resetting port
ata2: port is slow to respond, please be patient
ata2: port failed to respond (30 secs)
ata2: COMRESET failed (device not ready)
ata2: hardreset failed, retrying in 5 secs
ata2: hard resetting port
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata2.00: configured for PIO4
ata2: EH complete
sdb: Write Protect is off
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata2.00: tag 0 cmd 0x24 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata2: soft resetting port
ata2: softreset failed (1st FIS failed)
ata2: softreset failed, retrying in 5 secs
ata2: hard resetting port
ata2: port is slow to respond, please be patient
ata2: port failed to respond (30 secs)
ata2: COMRESET failed (device not ready)
ata2: hardreset failed, retrying in 5 secs
ata2: hard resetting port
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata2.00: configured for PIO4
ata2: EH complete
ata2.00: limiting speed to PIO3
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata2.00: tag 0 cmd 0x24 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata2: soft resetting port
ata2: softreset failed (1st FIS failed)
ata2: softreset failed, retrying in 5 secs
ata2: hard resetting port
ata2: port is slow to respond, please be patient
ata2: port failed to respond (30 secs)
ata2: COMRESET failed (device not ready)
ata2: hardreset failed, retrying in 5 secs
ata2: hard resetting port
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata2.00: configured for PIO3
ata2: EH complete
SCSI device sdb: drive cache: write through
ata2.00: limiting speed to PIO2
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata2.00: tag 0 cmd 0x24 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata2: soft resetting port
ata2: softreset failed (1st FIS failed)
ata2: softreset failed, retrying in 5 secs
ata2: hard resetting port
ata2: port is slow to respond, please be patient
ata2: port failed to respond (30 secs)
ata2: COMRESET failed (device not ready)
ata2: hardreset failed, retrying in 5 secs
ata2: hard resetting port
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata2.00: configured for PIO2
sd 1:0:0:0: SCSI error: return code = 0x08000002
sdb: Current: sense key: Aborted Command
    Additional sense: No additional sense information
end_request: I/O error, dev sdb, sector 625073067
Buffer I/O error on device sdb14, logical block 61970728
Buffer I/O error on device sdb14, logical block 61970729
Buffer I/O error on device sdb14, logical block 61970730
Buffer I/O error on device sdb14, logical block 61970731
ata2: EH complete
ata2.00: limiting speed to PIO1
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata2.00: tag 0 cmd 0x24 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata2: soft resetting port
ata2: softreset failed (1st FIS failed)
ata2: softreset failed, retrying in 5 secs
ata2: hard resetting port
ata2: port is slow to respond, please be patient
ata2: port failed to respond (30 secs)
ata2: COMRESET failed (device not ready)
ata2: hardreset failed, retrying in 5 secs
ata2: hard resetting port
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata2.00: configured for PIO1
ata2: EH complete
SCSI device sdb: 625142448 512-byte hdwr sectors (320073 MB)
ata2.00: limiting speed to PIO0
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata2.00: tag 0 cmd 0x24 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata2: soft resetting port
ata2: softreset failed (1st FIS failed)
ata2: softreset failed, retrying in 5 secs
ata2: hard resetting port
ata2: port is slow to respond, please be patient
ata2: port failed to respond (30 secs)
ata2: COMRESET failed (device not ready)
ata2: hardreset failed, retrying in 5 secs
ata2: hard resetting port
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata2.00: configured for PIO0
ata2: EH complete
sdb: Write Protect is off
ata2.00: speed down requested but no transfer mode left
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata2.00: tag 0 cmd 0x24 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata2: soft resetting port
ata2: softreset failed (1st FIS failed)
ata2: softreset failed, retrying in 5 secs
ata2: hard resetting port
ata2: port is slow to respond, please be patient
ata2: port failed to respond (30 secs)
ata2: COMRESET failed (device not ready)
ata2: hardreset failed, retrying in 5 secs
ata2: hard reset
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata2.00: configured for PIO0
ata2: EH complete
ata2.00: speed down requested but no transfer mode left
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata2.00: tag 0 cmd 0x24 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata2: soft resetting port
ata2: softreset failed (1st FIS failed)
ata2: softreset failed, retrying in 5 secs
ata2: hard resetting port
ata2: port is slow to respond, please be patient
ata2: port failed to respond (30 secs)
ata2: COMRESET failed (device not ready)
ata2: hardreset failed, retrying in 5 secs
ata2: hard resetting port
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata2.00: configured for PIO0
ata2: EH complete
SCSI device sdb: drive cache: write through
ata2.00: speed down requested but no transfer mode left
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata2.00: tag 0 cmd 0x24 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata2: soft resetting port
ata2: softreset failed (1st FIS failed)
ata2: softreset failed, retrying in 5 secs
ata2: hard resetting port
ata2: port is slow to respond, please be patient
ata2: port failed to respond (30 secs)
ata2: COMRESET failed (device not ready)
ata2: hardreset failed, retrying in 5 secs
ata2: hard resetting port
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata2.00: configured for PIO0
ata2: EH complete
ata2.00: speed down requested but no transfer mode left
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata2.00: tag 0 cmd 0x24 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata2: soft resetting port
ata2: softreset failed (1st FIS failed)
ata2: softreset failed, retrying in 5 secs
ata2: hard resetting port
ata2: port is slow to respond, please be patient
ata2: port failed to respond (30 secs)
ata2: COMRESET failed (device not ready)
ata2: hardreset failed, retrying in 5 secs
ata2: hard resetting port
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata2.00: configured for PIO0
sd 1:0:0:0: SCSI error: return code = 0x08000002
sdb: Current: sense key: Aborted Command
    Additional sense: No additional sense information
end_request: I/O error, dev sdb, sector 377189877
Buffer I/O error on device sdb12, logical block 61970608
Buffer I/O error on device sdb12, logical block 61970609
Buffer I/O error on device sdb12, logical block 61970610
Buffer I/O error on device sdb12, logical block 61970611
ata2: EH complete
SCSI device sdb: 625142448 512-byte hdwr sectors (320073 MB)
ata2.00: speed down requested but no transfer mode left
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata2.00: tag 0 cmd 0x20 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata2: soft resetting port
ata2: softreset failed (1st FIS failed)
ata2: softreset failed, retrying in 5 secs
ata2: hard resetting port
ata2: port is slow to respond, please be patient
ata2: port failed to respond (30 secs)
ata2: COMRESET failed (device not ready)
ata2: hardreset failed, retrying in 5 secs
ata2: hard resetting port
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata2.00: configured for PIO0
ata2: EH complete
sdb: Write Protect is off
ata2.00: speed down requested but no transfer mode left
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata2.00: tag 0 cmd 0x20 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata2: soft resetting port
ata2: softreset failed (1st FIS failed)
ata2: softreset failed, retrying in 5 secs
ata2: hard resetting port
ata2: port is slow to respond, please be patient
ata2: port failed to respond (30 secs)
ata2: COMRESET failed (device not ready)
ata2: hardreset failed, retrying in 5 secs
ata2: hard resetting port
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata2.00: configured for PIO0
ata2: EH complete
ata2.00: speed down requested but no transfer mode left
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata2.00: tag 0 cmd 0x20 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata2: soft resetting port
ata2: softreset failed (1st FIS failed)
ata2: softreset failed, retrying in 5 secs
ata2: hard resetting port
ata2: port is slow to respond, please be patient
ata2: port failed to respond (30 secs)
ata2: COMRESET failed (device not ready)
ata2: hardreset failed, retrying in 5 secs
ata2: hard resetting port
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata2.00: configured for PIO0
ata2: EH complete
SCSI device sdb: drive cache: write through
ata2.00: speed down requested but no transfer mode left
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata2.00: tag 0 cmd 0x20 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata2: soft resetting port
ata2: softreset failed (1st FIS failed)
ata2: softreset failed, retrying in 5 secs
ata2: hard resetting port
ata2: port is slow to respond, please be patient
ata2: port failed to respond (30 secs)
ata2: COMRESET failed (device not ready)
ata2: hardreset failed, retrying in 5 secs
ata2: hard resetting port
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata2.00: configured for PIO0
ata2: EH complete
ata2.00: speed down requested but no transfer mode left
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata2.00: tag 0 cmd 0x20 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata2: soft resetting port
ata2: softreset failed (1st FIS failed)
ata2: softreset failed, retrying in 5 secs
ata2: hard resetting port
ata2: port is slow to respond, please be patient
ata2: port failed to respond (30 secs)
ata2: COMRESET failed (device not ready)
ata2: hardreset failed, retrying in 5 secs
ata2: hard resetting port
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata2.00: configured for PIO0
ata2: EH complete
SCSI device sdb: 625142448 512-byte hdwr sectors (320073 MB)
ata2.00: speed down requested but no transfer mode left
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata2.00: tag 0 cmd 0x20 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata2: soft resetting port
ata2: softreset failed (1st FIS failed)
ata2: softreset failed, retrying in 5 secs
ata2: hard resetting port
ata2: port is slow to respond, please be patient
ata2: port failed to respond (30 secs)
ata2: COMRESET failed (device not ready)
ata2: hardreset failed, retrying in 5 secs
ata2: hard resetting port
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata2.00: configured for PIO0
sd 1:0:0:0: SCSI error: return code = 0x08000002
sdb: Current: sense key: Aborted Command
    Additional sense: No additional sense information
end_request: I/O error, dev sdb, sector 253248402
Buffer I/O error on device sdb11, logical block 61970608
Buffer I/O error on device sdb11, logical block 61970609
Buffer I/O error on device sdb11, logical block 61970610
Buffer I/O error on device sdb11, logical block 61970611
ata2: EH complete
sdb: Write Protect is off
ata2.00: speed down requested but no transfer mode left
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata2.00: tag 0 cmd 0x24 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata2: soft resetting port
ata2: softreset failed (1st FIS failed)
ata2: softreset failed, retrying in 5 secs
ata2: hard resetting port
ata2: port is slow to respond, please be patient
ata2: port failed to respond (30 secs)
ata2: COMRESET failed (device not ready)
ata2: hardreset failed, retrying in 5 secs
ata2: hard resetting port
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata2.00: configured for PIO0
ata2: EH complete
ata2.00: speed down requested but no transfer mode left
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata2.00: tag 0 cmd 0x24 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata2: soft resetting port
ata2: softreset failed (1st FIS failed)
ata2: softreset failed, retrying in 5 secs
ata2: hard resetting port
ata2: port is slow to respond, please be patient
ata2: port failed to respond (30 secs)
ata2: COMRESET failed (device not ready)
ata2: hardreset failed, retrying in 5 secs
ata2: hard resetting port
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata2.00: configured for PIO0
ata2: EH complete
SCSI device sdb: drive cache: write through
ata2.00: speed down requested but no transfer mode left
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata2.00: tag 0 cmd 0x24 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata2: soft resetting port
ata2: softreset failed (1st FIS failed)
ata2: softreset failed, retrying in 5 secs
ata2: hard resetting port
ata2: port is slow to respond, please be patient
ata2: port failed to respond (30 secs)
ata2: COMRESET failed (device not ready)
ata2: hardreset failed, retrying in 5 secs
ata2: hard resetting port
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata2.00: configured for PIO0
ata2: EH complete
ata2.00: speed down requested but no transfer mode left
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata2.00: tag 0 cmd 0x24 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata2: soft resetting port
ata2: softreset failed (1st FIS failed)
ata2: softreset failed, retrying in 5 secs
ata2: hard resetting port
ata2: port is slow to respond, please be patient
ata2: port failed to respond (30 secs)
ata2: COMRESET failed (device not ready)
ata2: hardreset failed, retrying in 5 secs
ata2: hard resetting port
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata2.00: configured for PIO0
ata2: EH complete
SCSI device sdb: 625142448 512-byte hdwr sectors (320073 MB)
ata2.00: speed down requested but no transfer mode left
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata2.00: tag 0 cmd 0x24 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata2: soft resetting port
ata2: softreset failed (1st FIS failed)
ata2: softreset failed, retrying in 5 secs
ata2: hard resetting port
ata2: port is slow to respond, please be patient
ata2: port failed to respond (30 secs)
ata2: COMRESET failed (device not ready)
ata2: hardreset failed, retrying in 5 secs
ata2: hard resetting port
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata2.00: configured for PIO0
ata2: EH complete
sdb: Write Protect is off
ata2.00: speed down requested but no transfer mode left
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata2.00: tag 0 cmd 0x24 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata2: soft resetting port
ata2: softreset failed (1st FIS failed)
ata2: softreset failed, retrying in 5 secs
ata2: hard resetting port
ata2: port is slow to respond, please be patient
ata2: port failed to respond (30 secs)
ata2: COMRESET failed (device not ready)
ata2: hardreset failed, retrying in 5 secs
ata2: hard resetting port
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata2.00: configured for PIO0
sd 1:0:0:0: SCSI error: return code = 0x08000002
sdb: Current: sense key: Aborted Command
    Additional sense: No additional sense information
end_request: I/O error, dev sdb, sector 377190136
Buffer I/O error on device sdb13, logical block 0
Buffer I/O error on device sdb13, logical block 1
Buffer I/O error on device sdb13, logical block 2
Buffer I/O error on device sdb13, logical block 3
ata2: EH complete
ata2.00: speed down requested but no transfer mode left
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata2.00: tag 0 cmd 0x20 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata2: soft resetting port
ata2: softreset failed (1st FIS failed)
ata2: softreset failed, retrying in 5 secs
ata2: hard resetting port
ata2: port is slow to respond, please be patient
ata2: port failed to respond (30 secs)
ata2: COMRESET failed (device not ready)
ata2: hardreset failed, retrying in 5 secs
ata2: hard resetting port
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata2.00: configured for PIO0
ata2: EH complete
SCSI device sdb: drive cache: write through
ata2.00: speed down requested but no transfer mode left
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata2.00: tag 0 cmd 0x20 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata2: soft resetting port
ata2: softreset failed (1st FIS failed)
ata2: softreset failed, retrying in 5 secs
ata2: hard resetting port
ata2: port is slow to respond, please be patient
ata2: port failed to respond (30 secs)
ata2: COMRESET failed (device not ready)
ata2: hardreset failed, retrying in 5 secs
ata2: hard resetting port
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata2.00: configured for PIO0
ata2: EH complete
ata2.00: speed down requested but no transfer mode left
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata2.00: tag 0 cmd 0x20 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata2: soft resetting port
ata2: softreset failed (1st FIS failed)
ata2: softreset failed, retrying in 5 secs
ata2: hard resetting port
ata2: port is slow to respond, please be patient
ata2: port failed to respond (30 secs)
ata2: COMRESET failed (device not ready)
ata2: hardreset failed, retrying in 5 secs
ata2: hard resetting port
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata2.00: configured for PIO0
ata2: EH complete
SCSI device sdb: 625142448 512-byte hdwr sectors (320073 MB)
ata2.00: speed down requested but no transfer mode left
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata2.00: tag 0 cmd 0x20 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata2: soft resetting port
ata2: softreset failed (1st FIS failed)
ata2: softreset failed, retrying in 5 secs
ata2: hard resetting port
ata2: port is slow to respond, please be patient
ata2: port failed to respond (30 secs)
ata2: COMRESET failed (device not ready)
ata2: hardreset failed, retrying in 5 secs
ata2: hard resetting port
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata2.00: configured for PIO0
ata2: EH complete
sdb: Write Protect is off
ata2.00: speed down requested but no transfer mode left
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata2.00: tag 0 cmd 0x20 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata2: soft resetting port
ata2: softreset failed (1st FIS failed)
ata2: softreset failed, retrying in 5 secs
ata2: hard resetting port
ata2: port is slow to respond, please be patient
ata2: port failed to respond (30 secs)
ata2: COMRESET failed (device not ready)
ata2: hardreset failed, retrying in 5 secs
ata2: hard resetting port
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata2.00: configured for PIO0
ata2: EH complete
ata2.00: speed down requested but no transfer mode left
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata2.00: tag 0 cmd 0x20 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata2: soft resetting port
ata2: softreset failed (1st FIS failed)
ata2: softreset failed, retrying in 5 secs
ata2: hard resetting port
ata2: port is slow to respond, please be patient
ata2: port failed to respond (30 secs)
ata2: COMRESET failed (device not ready)
ata2: hardreset failed, retrying in 5 secs
ata2: hard resetting port
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata2.00: configured for PIO0
sd 1:0:0:0: SCSI error: return code = 0x08000002
sdb: Current: sense key: Aborted Command
    Additional sense: No additional sense information
end_request: I/O error, dev sdb, sector 5365450
Buffer I/O error on device sdb9, logical block 501966
Buffer I/O error on device sdb9, logical block 501967
ata2: EH complete
SCSI device sdb: drive cache: write through
ata2.00: speed down requested but no transfer mode left
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata2.00: tag 0 cmd 0x20 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata2: soft resetting port
ata2: softreset failed (1st FIS failed)
ata2: softreset failed, retrying in 5 secs
ata2: hard resetting port
ata2: port is slow to respond, please be patient
ata2: port failed to respond (30 secs)
ata2: COMRESET failed (device not ready)
ata2: hardreset failed, retrying in 5 secs
ata2: hard resetting port
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata2.00: configured for PIO0
ata2: EH complete
ata2.00: speed down requested but no transfer mode left
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata2.00: tag 0 cmd 0x20 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata2: soft resetting port
ata2: softreset failed (1st FIS failed)
ata2: softreset failed, retrying in 5 secs
ata2: hard resetting port
ata2: port is slow to respond, please be patient
ata2: port failed to respond (30 secs)
ata2: COMRESET failed (device not ready)
ata2: hardreset failed, retrying in 5 secs
ata2: hard resetting port
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata2.00: configured for PIO0
ata2: EH complete
SCSI device sdb: 625142448 512-byte hdwr sectors (320073 MB)
ata2.00: speed down requested but no transfer mode left
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata2.00: tag 0 cmd 0x20 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata2: soft resetting port
ata2: softreset failed (1st FIS failed)
ata2: softreset failed, retrying in 5 secs
ata2: hard resetting port
ata2: port is slow to respond, please be patient
ata2: port failed to respond (30 secs)
ata2: COMRESET failed (device not ready)
ata2: hardreset failed, retrying in 5 secs
ata2: hard resetting port
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata2.00: configured for PIO0
ata2: EH complete
sdb: Write Protect is off
ata2.00: speed down requested but no transfer mode left
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata2.00: tag 0 cmd 0x20 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata2: soft resetting port
ata2: softreset failed (1st FIS failed)
ata2: softreset failed, retrying in 5 secs
ata2: hard resetting port
ata2: port is slow to respond, please be patient
ata2: port failed to respond (30 secs)
ata2: COMRESET failed (device not ready)
ata2: hardreset failed, retrying in 5 secs
ata2: hard resetting port
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata2.00: configured for PIO0
ata2: EH complete
ata2.00: speed down requested but no transfer mode left
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata2.00: tag 0 cmd 0x20 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata2: soft resetting port
ata2: softreset failed (1st FIS failed)
ata2: softreset failed, retrying in 5 secs
ata2: hard resetting port
ata2: port is slow to respond, please be patient
ata2: port failed to respond (30 secs)
ata2: COMRESET failed (device not ready)
ata2: hardreset failed, retrying in 5 secs
ata2: hard resetting port
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata2.00: configured for PIO0
ata2: EH complete
SCSI device sdb: drive cache: write through
ata2.00: speed dbut no transfer mode left
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata2.00: tag 0 cmd 0x20 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata2: soft resetting port
ata2: softreset failed (1st FIS failed)
ata2: softreset failed, retrying in 5 secs
ata2: hard resetting port
ata2: port is slow to respond, please be patient
ata2: port failed to respond (30 secs)
ata2: COMRESET failed (device not ready)
ata2: hardreset failed, retrying in 5 secs
ata2: hard resetting port
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata2.00: configured for PIO0
sd 1:0:0:0: SCSI error: return code = 0x08000002
sdb: Current: sense key: Aborted Command
    Additional sense: No additional sense information
end_request: I/O error, dev sdb, sector 129307167
Buffer I/O error on device sdb10, logical block 61970728
Buffer I/O error on device sdb10, logical block 61970729
Buffer I/O error on device sdb10, logical block 61970730
Buffer I/O error on device sdb10, logical block 61970731
ata2: EH complete
ata2.00: speed down requested but no transfer mode left
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata2.00: tag 0 cmd 0x20 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata2: soft resetting port
ata2: softreset failed (1st FIS failed)
ata2: softreset failed, retrying in 5 secs
ata2: hard resetting port
ata2: port is slow to respond, please be patient
ata2: port failed to respond (30 secs)
ata2: COMRESET failed (device not ready)
ata2: hardreset failed, retrying in 5 secs
ata2: hard resetting port
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata2.00: configured for PIO0
ata2: EH complete
SCSI device sdb: 625142448 512-byte hdwr sectors (320073 MB)
ata2.00: speed down requested but no transfer mode left
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata2.00: tag 0 cmd 0x20 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata2: soft resetting port
ata2: softreset failed (1st FIS failed)
ata2: softreset failed, retrying in 5 secs
ata2: hard resetting port
ata2: port is slow to respond, please be patient
ata2: port failed to respond (30 secs)
ata2: COMRESET failed (device not ready)
ata2: hardreset failed, retrying in 5 secs
ata2: hard resetting port
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata2.00: configured for PIO0
ata2: EH complete
sdb: Write Protect is off
ata2.00: speed down requested but no transfer mode left
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata2.00: tag 0 cmd 0x20 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata2: soft resetting port
ata2: softreset failed (1st FIS failed)
ata2: softreset failed, retrying in 5 secs
ata2: hard resetting port
ata2: port is slow to respond, please be patient
ata2: port failed to respond (30 secs)
ata2: COMRESET failed (device not ready)
ata2: hardreset failed, retrying in 5 secs
ata2: hard resetting port
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata2.00: configured for PIO0
ata2: EH complete
ata2.00: speed down requested but no transfer mode left
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata2.00: tag 0 cmd 0x20 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata2: soft resetting port
ata2: softreset failed (1st FIS failed)
ata2: softreset failed, retrying in 5 secs
ata2: hard resetting port
ata2: port is slow to respond, please be patient
ata2: port failed to respond (30 secs)
ata2: COMRESET failed (device not ready)
ata2: hardreset failed, retrying in 5 secs
ata2: hard resetting port
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata2.00: configured for PIO0
ata2: EH complete
SCSI device sdb: drive cache: write through
ata2.00: speed down requested but no transfer mode left
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata2.00: tag 0 cmd 0x20 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata2: soft resetting port
ata2: softreset failed (1st FIS failed)
ata2: softreset failed, retrying in 5 secs
ata2: hard resetting port
ata2: port is slow to respond, please be patient
ata2: port failed to respond (30 secs)
ata2: COMRESET failed (device not ready)
ata2: hardreset failed, retrying in 5 secs
ata2: hard resetting port
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata2.00: configured for PIO0
ata2: EH complete
ata2.00: speed down requested but no transfer mode left
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata2.00: tag 0 cmd 0x20 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata2: soft resetting port
ata2: softreset failed (1st FIS failed)
ata2: softreset failed, retrying in 5 secs
ata2: hard resetting port
ata2: port is slow to respond, please be patient
ata2: port failed to respond (30 secs)
ata2: COMRESET failed (device not ready)
ata2: hardreset failed, retrying in 5 secs
ata2: hard resetting port
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata2.00: configured for PIO0
sd 1:0:0:0: SCSI error: return code = 0x08000002
sdb: Current: sense key: Aborted Command
    Additional sense: No additional sense information
end_request: I/O error, dev sdb, sector 273100
Buffer I/O error on device sdb3, logical block 208840
Buffer I/O error on device sdb3, logical block 208841
Buffer I/O error on device sdb3, logical block 208842
Buffer I/O error on device sdb3, logical block 208843
Buffer I/O error on device sdb3, logical block 208844
ata2: EH complete
SCSI device sdb: 625142448 512-byte hdwr sectors (320073 MB)
ata2.00: speed down requested but no transfer mode left
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata2.00: tag 0 cmd 0x24 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata2: soft resetting port
ata2: softreset failed (1st FIS failed)
ata2: softreset failed, retrying in 5 secs
ata2: hard resetting port
ata2: port is slow to respond, please be patient
ata2: port failed to respond (30 secs)
ata2: COMRESET failed (device not ready)
ata2: hardreset failed, retrying in 5 secs
ata2: hard resetting port
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata2.00: configured for PIO0
ata2: EH complete
sdb: Write Protect is off
ata2.00: speed down requested but no transfer mode left
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata2.00: tag 0 cmd 0x24 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata2: soft resetting port
ata2: softreset failed (1st FIS failed)
ata2: softreset failed, retrying in 5 secs
ata2: hard resetting port
ata2: port is slow to respond, please be patient
ata2: port failed to respond (30 secs)
ata2: COMRESET failed (device not ready)
ata2: hardreset failed, retrying in 5 secs
ata2: hard resetting port
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata2.00: configured for PIO0
ata2: EH complete
ata2.00: speed down requested but no transfer mode left
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata2.00: tag 0 cmd 0x24 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata2: soft resetting port
ata2: softreset failed (1st FIS failed)
ata2: softreset failed, retrying in 5 secs
ata2: hard resetting port
ata2: port is slow to respond, please be patient
ata2: port failed to respond (30 secs)
ata2: COMRESET failed (device not ready)
ata2: hardreset failed, retrying in 5 secs
ata2: hard resetting port
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata2.00: configured for PIO0
ata2: EH complete
SCSI device sdb: drive cache: write through
ata2.00: speed down requested but no transfer mode left
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata2.00: tag 0 cmd 0x24 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata2: soft resetting port
ata2: softreset failed (1st FIS failed)
ata2: softreset failed, retrying in 5 secs
ata2: hard resetting port
ata2: port is slow to respond, please be patient
ata2: port failed to respond (30 secs)
ata2: COMRESET failed (device not ready)
ata2: hardreset failed, retrying in 5 secs
ata2: hard resetting port
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata2.00: configured for PIO0
ata2: EH complete
ata2.00: speed down requested but no transfer mode left
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata2.00: tag 0 cmd 0x24 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata2: soft resetting port
ata2: softreset failed (1st FIS failed)
ata2: softreset failed, retrying in 5 secs
ata2: hard resetting port
ata2: port is slow to respond, please be patient
ata2: port failed to respond (30 secs)
ata2: COMRESET failed (device not ready)
ata2: hardreset failed, retrying in 5 secs
ata2: hard resetting port
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata2.00: configured for PIO0
ata2: EH complete
SCSI device sdb: 625142448 512-byte hdwr sectors (320073 MB)


--------------010607070103030305000903--
