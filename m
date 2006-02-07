From: David Greaves <david@dgreaves.com>
Subject: SMART on SATA reporting errors? (was Re: regarding bug #5914 - fs
 corruption on SATA)
Date: Tue, 07 Feb 2006 18:35:11 +0000
Message-ID: <43E8E85F.5000905@dgreaves.com>
References: <20060126055050.GA4737@htj.dyndns.org> <43D8FBBD.6070205@dgreaves.com> <43D8FF9A.4020805@pobox.com> <43D903AC.5000309@dgreaves.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from s2.ukfsn.org ([217.158.120.143]:11399 "EHLO mail.ukfsn.org")
	by vger.kernel.org with ESMTP id S964853AbWBGSfN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 7 Feb 2006 13:35:13 -0500
In-Reply-To: <43D903AC.5000309@dgreaves.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linux-ide <linux-ide@vger.kernel.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>, Nicolas.Mailhot@LaPoste.net, Jens Axboe <axboe@suse.de>, Christopher Smith <csmith@nighthawkrad.net>, Erik Slagter <erik@slagter.name>, hahn@physics.mcmaster.ca, mlaks@verizon.net, Soeren Sonnenburg <kernel@nn7.de>, mlaks@verizononline.net, smartmontools-support@lists.sourceforge.net

This is a followon to the email below.

Basically, it seems some SMART commands produce unexpected errrors.

My Debian smartd config has "-o on" and "-S on" for every drive so it
puts out lots of errors every time I boot.

I did a little investigation and I see that when I do:
# smartctl -o on -data /dev/sdb
smartctl version 5.34 [i686-pc-linux-gnu] Copyright (C) 2002-5 Bruce Allen
Home page is http://smartmontools.sourceforge.net/

=== START OF ENABLE/DISABLE COMMANDS SECTION ===
Error SMART Disable Automatic Offline failed: Input/output error
Smartctl: SMART Disable Automatic Offline Failed.

(Which is fine if the drive doesn't support it.)

I unexpectedly get this in dmesg:

ata2: translated ATA stat/err 0x51/04 to SCSI SK/ASC/ASCQ 0xb/00/00
ata2: status=0x51 { DriveReady SeekComplete Error }
ata2: error=0x04 { DriveStatusError }
ata2: no sense translation for status: 0x51
ata2: translated ATA stat/err 0x51/00 to SCSI SK/ASC/ASCQ 0x3/11/04
ata2: status=0x51 { DriveReady SeekComplete Error }
ata2: translated ATA stat/err 0x51/04 to SCSI SK/ASC/ASCQ 0xb/00/00
ata2: status=0x51 { DriveReady SeekComplete Error }
ata2: error=0x04 { DriveStatusError }
ata2: translated ATA stat/err 0x51/04 to SCSI SK/ASC/ASCQ 0xb/00/00
ata2: status=0x51 { DriveReady SeekComplete Error }
ata2: error=0x04 { DriveStatusError }
ata2: translated ATA stat/err 0x51/04 to SCSI SK/ASC/ASCQ 0xb/00/00
ata2: status=0x51 { DriveReady SeekComplete Error }
ata2: error=0x04 { DriveStatusError }


If I try with sda the first time it fails:
# smartctl -o off -data /dev/sda
smartctl version 5.34 [i686-pc-linux-gnu] Copyright (C) 2002-5 Bruce Allen
Home page is http://smartmontools.sourceforge.net/

=== START OF ENABLE/DISABLE COMMANDS SECTION ===
Error SMART Disable Automatic Offline failed: Input/output error
Smartctl: SMART Disable Automatic Offline Failed.

and I get:
ata1: translated ATA stat/err 0x51/04 to SCSI SK/ASC/ASCQ 0xb/00/00
ata1: status=0x51 { DriveReady SeekComplete Error }
ata1: error=0x04 { DriveStatusError }
ata1: translated ATA stat/err 0x51/04 to SCSI SK/ASC/ASCQ 0xb/00/00
ata1: status=0x51 { DriveReady SeekComplete Error }
ata1: error=0x04 { DriveStatusError }
ata1: translated ATA stat/err 0x51/04 to SCSI SK/ASC/ASCQ 0xb/00/00
ata1: status=0x51 { DriveReady SeekComplete Error }
ata1: error=0x04 { DriveStatusError }

thereafter it works:
# smartctl -s on -data /dev/sda
smartctl version 5.34 [i686-pc-linux-gnu] Copyright (C) 2002-5 Bruce Allen
Home page is http://smartmontools.sourceforge.net/

=== START OF ENABLE/DISABLE COMMANDS SECTION ===
SMART Enabled.

# smartctl -s off -data /dev/sda
smartctl version 5.34 [i686-pc-linux-gnu] Copyright (C) 2002-5 Bruce Allen
Home page is http://smartmontools.sourceforge.net/

=== START OF ENABLE/DISABLE COMMANDS SECTION ===
SMART Disabled. Use option -s with argument 'on' to enable it.

(no dmesg output this time)

If I try this on sdc, it succeeds *and* I get error messages:
# smartctl -S off -data /dev/sdc
smartctl version 5.34 [i686-pc-linux-gnu] Copyright (C) 2002-5 Bruce Allen
Home page is http://smartmontools.sourceforge.net/

=== START OF ENABLE/DISABLE COMMANDS SECTION ===
SMART Disabled. Use option -s with argument 'on' to enable it.

I still get this in dmesg:

ata3: translated ATA stat/err 0x51/04 to SCSI SK/ASC/ASCQ 0xb/00/00
ata3: status=0x51 { DriveReady SeekComplete Error }
ata3: error=0x04 { DriveStatusError }
ata3: translated ATA stat/err 0x51/04 to SCSI SK/ASC/ASCQ 0xb/00/00
ata3: status=0x51 { DriveReady SeekComplete Error }
ata3: error=0x04 { DriveStatusError }
ata3: translated ATA stat/err 0x51/04 to SCSI SK/ASC/ASCQ 0xb/00/00
ata3: status=0x51 { DriveReady SeekComplete Error }
ata3: error=0x04 { DriveStatusError }



Some more boot time dmesg info
Linux version 2.6.15 (root@haze) (gcc version 4.0.3 20051201
(prerelease) (Debian 4.0.2-5)) #4 PREEMPT Tue Jan 24 08:30:31 UTC 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009d800 (usable)
 BIOS-e820: 000000000009d800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003fffb000 (usable)
 BIOS-e820: 000000003fffb000 - 000000003ffff000 (ACPI data)
 BIOS-e820: 000000003ffff000 - 0000000040000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
127MB HIGHMEM available.
896MB LOWMEM available.
On node 0 totalpages: 262139
  DMA zone: 4096 pages, LIFO batch:0
  DMA32 zone: 0 pages, LIFO batch:0
  Normal zone: 225280 pages, LIFO batch:31
  HighMem zone: 32763 pages, LIFO batch:7
DMI 2.3 present.
ACPI: RSDP (v000 ASUS                                  ) @ 0x000f5e30
ACPI: RSDT (v001 ASUS   A7V600-X 0x42302e31 MSFT 0x31313031) @ 0x3fffb000
ACPI: FADT (v001 ASUS   A7V600-X 0x42302e31 MSFT 0x31313031) @ 0x3fffb0b2
ACPI: BOOT (v001 ASUS   A7V600-X 0x42302e31 MSFT 0x31313031) @ 0x3fffb030
ACPI: MADT (v001 ASUS   A7V600-X 0x42302e31 MSFT 0x31313031) @ 0x3fffb058
ACPI: DSDT (v001   ASUS A7V600-X 0x00001000 MSFT 0x0100000b) @ 0x00000000
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 6:10 APIC version 16
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 3, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl edge)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 50000000 (gap: 40000000:bec00000)
Built 1 zonelists
Kernel command line: root=/dev/md0 ro
mapped APIC to ffffd000 (fee00000)
mapped IOAPIC to ffffc000 (fec00000)
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 65536 bytes)
Detected 2125.801 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 1035636k/1048556k available (2326k kernel code, 12328k reserved,
576k data, 176k init, 131052k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 4258.01 BogoMIPS
(lpj=8516036)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: 0383fbff c1c3fbff 00000000 00000000
00000000 00000000 00000000
CPU: After vendor identify, caps: 0383fbff c1c3fbff 00000000 00000000
00000000 00000000 00000000
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 512K (64 bytes/line)
CPU: After all inits, caps: 0383fbff c1c3fbff 00000000 00000020 00000000
00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
mtrr: v2.0 (20020519)
CPU: AMD Athlon(TM) XP 3000+ stepping 00
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xf1970, last bus=1
PCI: Using configuration type 1
ACPI: Subsystem revision 20050902
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 10 11 12) *0, disabled.
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 11 12) *0, disabled.
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 10 11 12) *0, disabled.
ACPI: PCI Interrupt Link [LNKE] (IRQs *3 4 5 6 7 9 10 11 12)
ACPI: PCI Interrupt Link [LNKF] (IRQs *3 4 5 6 7 9 10 11 12)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 *7 9 10 11 12)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 9 10 11 12) *15, disabled.
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
ACPI: Assume root bridge [\_SB_.PCI0] bus is 0
Boot video device is 0000:01:00.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
SCSI subsystem initialized
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a
report
PCI: Bridge: 0000:00:01.0
  IO window: d000-dfff
  MEM window: be800000-bfefffff
  PREFETCH window: c0000000-f7ffffff
PCI: Setting latency timer of device 0000:00:01.0 to 64
Simple Boot Flag at 0x3a set to 0x80
Machine check exception polling timer started.
highmem bounce pool size: 64 pages
SGI XFS with no debug enabled
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
PCI: Bypassing VIA 8237 APIC De-Assert Message
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:0f.1
ACPI: PCI Interrupt 0000:00:0f.1[A] -> GSI 20 (level, low) -> IRQ 16
PCI: Via IRQ fixup for 0000:00:0f.1, from 14 to 0
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt8237 (rev 00) IDE UDMA133 controller on pci0000:00:0f.1
    ide0: BM-DMA at 0x7800-0x7807, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0x7808-0x780f, BIOS settings: hdc:pio, hdd:pio
Probing IDE interface ide0...
hda: PLEXTOR DVDR PX-708A, ATAPI CD/DVD-ROM drive
hdb: TSSTcorpCD/DVDW SH-W162C, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hda: ATAPI 40X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
hdb: ATAPI 48X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache, UDMA(33)
libata version 1.20 loaded.
sata_sil 0000:00:0a.0: version 0.9
ACPI: PCI Interrupt 0000:00:0a.0[A] -> GSI 16 (level, low) -> IRQ 17
ata1: SATA max UDMA/100 cmd 0xF8804080 ctl 0xF880408A bmdma 0xF8804000
irq 17
ata2: SATA max UDMA/100 cmd 0xF88040C0 ctl 0xF88040CA bmdma 0xF8804008
irq 17
ata1: dev 0 cfg 49:2f00 82:7869 83:7d09 84:4043 85:7869 86:3c01 87:4043
88:203f
ata1: dev 0 ATA-7, max UDMA/100, 390721968 sectors: LBA48
ata1: dev 0 configured for UDMA/100
scsi0 : sata_sil
ata2: dev 0 cfg 49:2f00 82:7c6b 83:7f09 84:4063 85:7c69 86:3e01 87:4063
88:007f
ata2: dev 0 ATA-7, max UDMA/133, 398297088 sectors: LBA48
ata2: dev 0 configured for UDMA/100
scsi1 : sata_sil
  Vendor: ATA       Model: Maxtor 6B200M0    Rev: BANC
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: ATA       Model: Maxtor 6B200M0    Rev: BANC
  Type:   Direct-Access                      ANSI SCSI revision: 05
sata_via 0000:00:0f.0: version 1.1
ACPI: PCI Interrupt 0000:00:0f.0[B] -> GSI 20 (level, low) -> IRQ 16
sata_via 0000:00:0f.0: routed to hard irq line 0
ata3: SATA max UDMA/133 cmd 0x9800 ctl 0x9402 bmdma 0x8400 irq 16
ata4: SATA max UDMA/133 cmd 0x9000 ctl 0x8802 bmdma 0x8408 irq 16
ata3: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4003 85:3469 86:3c01 87:4003
88:407f
ata3: dev 0 ATA-6, max UDMA/133, 312581808 sectors: LBA48
ata3: dev 0 configured for UDMA/133
scsi2 : sata_via
ata4: dev 0 cfg 49:2f00 82:7c6b 83:7f09 84:4063 85:7c69 86:3e01 87:4063
88:407f
ata4: dev 0 ATA-7, max UDMA/133, 398297088 sectors: LBA48
ata4: dev 0 configured for UDMA/133
scsi3 : sata_via
  Vendor: ATA       Model: ST3160023AS       Rev: 3.18
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: ATA       Model: Maxtor 6B200M0    Rev: BANC
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 390721968 512-byte hdwr sectors (200050 MB)
SCSI device sda: drive cache: write back
SCSI device sda: 390721968 512-byte hdwr sectors (200050 MB)
SCSI device sda: drive cache: write back
 sda: sda1
sd 0:0:0:0: Attached scsi disk sda
SCSI device sdb: 398297088 512-byte hdwr sectors (203928 MB)
SCSI device sdb: drive cache: write back
SCSI device sdb: 398297088 512-byte hdwr sectors (203928 MB)
SCSI device sdb: drive cache: write back
 sdb: sdb1 sdb2
sd 1:0:0:0: Attached scsi disk sdb
SCSI device sdc: 312581808 512-byte hdwr sectors (160042 MB)
SCSI device sdc: drive cache: write back
SCSI device sdc: 312581808 512-byte hdwr sectors (160042 MB)
SCSI device sdc: drive cache: write back
 sdc: sdc1 sdc2 sdc3 sdc4
sd 2:0:0:0: Attached scsi disk sdc
SCSI device sdd: 398297088 512-byte hdwr sectors (203928 MB)
SCSI device sdd: drive cache: write back
SCSI device sdd: 398297088 512-byte hdwr sectors (203928 MB)
SCSI device sdd: drive cache: write back
 sdd: sdd1 sdd2
sd 3:0:0:0: Attached scsi disk sdd
sd 0:0:0:0: Attached scsi generic sg0 type 0
sd 1:0:0:0: Attached scsi generic sg1 type 0
sd 2:0:0:0: Attached scsi generic sg2 type 0
sd 3:0:0:0: Attached scsi generic sg3 type 0

David

David Greaves wrote:

>Jeff Garzik wrote:
>  
>
>>David Greaves wrote:
>>    
>>
>>>  Possible libata/sata/Asus problem (was Re: Need to upgrade to latest
>>>stable mdadm version?)
>>>      
>>>
>>Highly likely to be a motherboard/BIOS issue related to properly
>>tuning and timing the hardware.
>>
>>HOWEVER, libata can help (via Tejun's recent patches) by properly
>>handling the error when throw to us by hardware.
>>    
>>
>OK - I thought my messages:
>
>Jan 20 06:25:04 haze kernel: ata2: status=0x51 { DriveReady SeekComplete
>Error }
>Jan 20 06:25:04 haze kernel: ata2: error=0x04 { DriveStatusError }
>Jan 20 06:25:10 haze kernel: ata2: no sense translation for status: 0x51
>Jan 20 06:25:10 haze kernel: ata2: status=0x51 { DriveReady SeekComplete
>Error }
>Jan 20 06:25:18 haze kernel: ata2: no sense translation for status: 0x51
>Jan 20 06:25:18 haze kernel: ata2: status=0x51 { DriveReady SeekComplete
>Error }
>Jan 20 06:25:18 haze kernel: ata2: no sense translation for status: 0x51
>Jan 20 06:25:18 haze kernel: ata2: status=0x51 { DriveReady SeekComplete
>Error }
>Jan 20 06:25:20 haze kernel: ata2: no sense translation for status: 0x51
>Jan 20 06:25:20 haze kernel: ata2: status=0x51 { DriveReady SeekComplete
>Error }
>Jan 20 06:25:22 haze kernel: ata2: no sense translation for status: 0x51
>Jan 20 06:25:22 haze kernel: ata2: status=0x51 { DriveReady SeekComplete
>Error }
>Jan 20 06:25:52 haze kernel: ata2: no sense translation for status: 0x51
>Jan 20 06:25:52 haze kernel: ata2: status=0x51 { DriveReady SeekComplete
>Error }
>Jan 20 06:25:52 haze kernel: sd 1:0:0:0: SCSI error: return code = 0x8000002
>Jan 20 06:25:52 haze kernel: sdb: Current: sense key: Medium Error
>Jan 20 06:25:52 haze kernel:     Additional sense: Unrecovered read
>error - auto reallocate failed
>Jan 20 06:25:52 haze kernel: end_request: I/O error, dev sdb, sector
>390787713
>
>bore a certain similarity to those in Tejun/Nicolas' mail:
>
>Different problem? as irq might ask: "does anybody care?" :)
>
>(and yes badblocks and SMART reports all is well)
>  
>


-- 

