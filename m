From: Rasmus Melgaard <rme@image.dk>
Subject: sata_sil + Maxtor
Date: Fri, 8 Oct 2004 09:48:45 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200410080948.45286.rme@image.dk>
Reply-To: rme@image.dk
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp120.tiscali.dk ([62.79.79.111]:42227 "EHLO
	smtp120.tiscali.dk") by vger.kernel.org with ESMTP id S268206AbUJHHss
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 8 Oct 2004 03:48:48 -0400
Received: from cpmail.dk.tiscali.com (mail.tiscali.dk [212.54.64.159])
	by smtp120.tiscali.dk (8.12.10/8.12.10) with ESMTP id i987mjPC011583
	for <linux-ide@vger.kernel.org>; Fri, 8 Oct 2004 09:48:47 +0200 (CEST)
	(envelope-from rme@image.dk)
Received: from [192.168.1.11] (213.237.41.235) by cpmail.dk.tiscali.com (6.7.018)
        id 41612EDD000D7F6E for linux-ide@vger.kernel.org; Fri, 8 Oct 2004 09:48:46 +0200
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi,

I have a IDE/SATA problem. I have a Silicon Image 3112 sata-controller with a 
Maxtor 160 Gb drive connected. Controller and drive is detected in the 
kernel-boot process, but an error happens during boot, I think the linux 
driver gets an response it doesn't expect.

I'm using for testing the mm-kernel: 2.6.9-rc1-mm1. Every thing seems to work 
in Windows, but since I mainly use Linux (Gentoo), I would like it to work 
here.

Does anybody have an ideer of how to proceed to solve this problem ? 

Mvh
Rasmus

Important part of log:
Sep  5 15:55:39 rasmus scsi1 : sata_sil
Sep  5 15:55:39 rasmus ata2: no device found (phy stat 00000000)
Sep  5 15:55:39 rasmus scsi2 : sata_sil
Sep  5 15:55:39 rasmus Vendor: ATA       Model: Maxtor 6Y160M0    Rev: YAR5
Sep  5 15:55:39 rasmus Type:   Direct-Access                      ANSI SCSI 
revision: 05
Sep  5 15:55:39 rasmus SCSI device sda: 320173056 512-byte hdwr sectors 
(163929 MB)
Sep  5 15:55:39 rasmus SCSI device sda: drive cache: write back
Sep  5 15:55:39 rasmus /dev/scsi/host1/bus0/target0/lun0:<3>ata1: command 0x25 
timeout, stat 0x58 host_stat 0x60
Sep  5 15:55:39 rasmus ata1: status=0x58 { DriveReady SeekComplete 
DataRequest }
Sep  5 15:55:39 rasmus SCSI error : <1 0 0 0> return code = 0x8000002
Sep  5 15:55:39 rasmus Current sda: sense = 70 10
Sep  5 15:55:39 rasmus end_request: I/O error, dev sda, sector 0
Sep  5 15:55:39 rasmus Buffer I/O error on device sda, logical block 0
Sep  5 15:55:39 rasmus ATA: abnormal status 0x58 on port 0xE882E087
Sep  5 15:55:39 rasmus ATA: abnormal status 0x58 on port 0xE882E087
Sep  5 15:55:39 rasmus ATA: abnormal status 0x58 on port 0xE882E087
Sep  5 15:55:39 rasmus ata1: command 0x25 timeout, stat 0xd8 host_stat 0x61
Sep  5 15:55:39 rasmus ata1: status=0xd8 { Busy }
Sep  5 15:55:39 rasmus SCSI error : <1 0 0 0> return code = 0x8000002
Sep  5 15:55:39 rasmus Current sda: sense = 70 10
Sep  5 15:55:39 rasmus end_request: I/O error, dev sda, sector 0
Sep  5 15:55:39 rasmus Buffer I/O error on device sda, logical block 0



Whole Boot Log:

Sep  5 15:55:39 rasmus Linux version 2.6.9-rc1-mm1 (root@rasmus) (gcc version 
3.3.4 20040623 (Gentoo Linux 3.3.4-r1, ssp-3.3.2-2, pie-8.7.6)) #4 Sun Aug 29 
20:10:50 CEST 2004
Sep  5 15:55:39 rasmus BIOS-provided physical RAM map:
Sep  5 15:55:39 rasmus BIOS-e820: 0000000000000000 - 000000000009e400 (usable)
Sep  5 15:55:39 rasmus BIOS-e820: 000000000009e400 - 00000000000a0000 
(reserved)
Sep  5 15:55:39 rasmus BIOS-e820: 00000000000f0000 - 0000000000100000 
(reserved)
Sep  5 15:55:39 rasmus BIOS-e820: 0000000000100000 - 0000000027fec000 (usable)
Sep  5 15:55:39 rasmus BIOS-e820: 0000000027fec000 - 0000000027fef000 (ACPI 
data)
Sep  5 15:55:39 rasmus BIOS-e820: 0000000027fef000 - 0000000027fff000 
(reserved)
Sep  5 15:55:39 rasmus BIOS-e820: 0000000027fff000 - 0000000028000000 (ACPI 
NVS)
Sep  5 15:55:39 rasmus BIOS-e820: 00000000ffff0000 - 0000000100000000 
(reserved)
Sep  5 15:55:39 rasmus 639MB LOWMEM available.
Sep  5 15:55:39 rasmus On node 0 totalpages: 163820
Sep  5 15:55:39 rasmus DMA zone: 4096 pages, LIFO batch:1
Sep  5 15:55:39 rasmus Normal zone: 159724 pages, LIFO batch:16
Sep  5 15:55:39 rasmus HighMem zone: 0 pages, LIFO batch:1
Sep  5 15:55:39 rasmus DMI 2.3 present.
Sep  5 15:55:39 rasmus ACPI: RSDP (v000 
ASUS                                  ) @ 0x000f6a90
Sep  5 15:55:39 rasmus ACPI: RSDT (v001 ASUS   A7V      0x30303031 MSFT 
0x31313031) @ 0x27fec000
Sep  5 15:55:39 rasmus ACPI: FADT (v001 ASUS   A7V      0x30303031 MSFT 
0x31313031) @ 0x27fec080
Sep  5 15:55:39 rasmus ACPI: BOOT (v001 ASUS   A7V      0x30303031 MSFT 
0x31313031) @ 0x27fec040
Sep  5 15:55:39 rasmus ACPI: DSDT (v001   ASUS A7V      0x00001000 MSFT 
0x0100000b) @ 0x00000000
Sep  5 15:55:39 rasmus Built 1 zonelists
Sep  5 15:55:39 rasmus Initializing CPU#0
Sep  5 15:55:39 rasmus Kernel command line: root=/dev/hde7 vga=0x346 
hda=ide-scsi hdalun=0 splash=silent
Sep  5 15:55:39 rasmus ide_setup: hda=ide-scsi
Sep  5 15:55:39 rasmus ide_setup: hdalun=0 -- BAD OPTION
Sep  5 15:55:39 rasmus PID hash table entries: 4096 (order: 12, 65536 bytes)
Sep  5 15:55:39 rasmus Detected 1261.217 MHz processor.
Sep  5 15:55:39 rasmus Using tsc for high-res timesource
Sep  5 15:55:39 rasmus Console: colour VGA+ 80x25
Sep  5 15:55:39 rasmus Dentry cache hash table entries: 131072 (order: 7, 
524288 bytes)
Sep  5 15:55:39 rasmus Inode-cache hash table entries: 65536 (order: 6, 262144 
bytes)
Sep  5 15:55:39 rasmus Memory: 643284k/655280k available (3764k kernel code, 
11444k reserved, 1215k data, 176k init, 0k highmem)
Sep  5 15:55:39 rasmus Checking if this processor honours the WP bit even in 
supervisor mode... Ok.
Sep  5 15:55:39 rasmus Calibrating delay loop... 2482.17 BogoMIPS 
(lpj=1241088)
Sep  5 15:55:39 rasmus Mount-cache hash table entries: 512 (order: 0, 4096 
bytes)
Sep  5 15:55:39 rasmus CPU: After generic identify, caps: 0383f9ff c1c3f9ff 
00000000 00000000
Sep  5 15:55:39 rasmus CPU: After vendor identify, caps:  0383f9ff c1c3f9ff 
00000000 00000000
Sep  5 15:55:39 rasmus CPU: CLK_CTL MSR was 6003d22f. Reprogramming to 
2003d22f
Sep  5 15:55:39 rasmus CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 
bytes/line)
Sep  5 15:55:39 rasmus CPU: L2 Cache: 64K (64 bytes/line)
Sep  5 15:55:39 rasmus CPU: After all inits, caps:        0383f9ff c1c3f9ff 
00000000 00000020
Sep  5 15:55:39 rasmus Intel machine check architecture supported.
Sep  5 15:55:39 rasmus Intel machine check reporting enabled on CPU#0.
Sep  5 15:55:39 rasmus CPU: AMD Athlon(TM) XP 2000+ stepping 01
Sep  5 15:55:39 rasmus Enabling fast FPU save and restore... done.
Sep  5 15:55:39 rasmus Enabling unmasked SIMD FPU exception support... done.
Sep  5 15:55:39 rasmus Checking 'hlt' instruction... OK.
Sep  5 15:55:39 rasmus ACPI: IRQ9 SCI: Level Trigger.
Sep  5 15:55:39 rasmus NET: Registered protocol family 16
Sep  5 15:55:39 rasmus PCI: PCI BIOS revision 2.10 entry at 0xf1180, last 
bus=1
Sep  5 15:55:39 rasmus PCI: Using configuration type 1
Sep  5 15:55:39 rasmus mtrr: v2.0 (20020519)
Sep  5 15:55:39 rasmus ACPI: Subsystem revision 20040816
Sep  5 15:55:39 rasmus ACPI: Interpreter enabled
Sep  5 15:55:39 rasmus ACPI: Using PIC for interrupt routing
Sep  5 15:55:39 rasmus ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 
*11 12 14 15)
Sep  5 15:55:39 rasmus ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 *10 
11 12 14 15)
Sep  5 15:55:39 rasmus ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 *9 10 
11 12 14 15)
Sep  5 15:55:39 rasmus ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 *9 10 
11 12 14 15)
Sep  5 15:55:39 rasmus ACPI: PCI Root Bridge [PCI0] (00:00)
Sep  5 15:55:39 rasmus PCI: Probing PCI hardware (bus 00)
Sep  5 15:55:39 rasmus Disabling VIA memory write queue (PCI ID 0305, rev 02): 
[55] 89 & 1f -> 09
Sep  5 15:55:39 rasmus ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
Sep  5 15:55:39 rasmus SCSI subsystem initialized
Sep  5 15:55:39 rasmus usbcore: registered new driver usbfs
Sep  5 15:55:39 rasmus usbcore: registered new driver hub
Sep  5 15:55:39 rasmus PCI: Using ACPI for IRQ routing
Sep  5 15:55:39 rasmus ** PCI interrupts are no longer routed automatically.  
If this
Sep  5 15:55:39 rasmus ** causes a device to stop working, it is probably 
because the
Sep  5 15:55:39 rasmus ** driver failed to call pci_enable_device().  As a 
temporary
Sep  5 15:55:39 rasmus ** workaround, the "pci=routeirq" argument restores the 
old
Sep  5 15:55:39 rasmus ** behavior.  If this argument makes the device work 
again,
Sep  5 15:55:39 rasmus ** please email the output of "lspci" to 
bjorn.helgaas@hp.com
Sep  5 15:55:39 rasmus ** so I can fix the driver.
Sep  5 15:55:39 rasmus get_random_bytes called before random driver 
initialization
Sep  5 15:55:39 rasmus Simple Boot Flag at 0x3a set to 0x1
Sep  5 15:55:39 rasmus Machine check exception polling timer started.
Sep  5 15:55:39 rasmus devfs: 2004-01-31 Richard Gooch (rgooch@atnf.csiro.au)
Sep  5 15:55:39 rasmus devfs: boot_options: 0x1
Sep  5 15:55:39 rasmus Installing knfsd (copyright (C) 1996 
okir@monad.swb.de).
Sep  5 15:55:39 rasmus NTFS driver 2.1.17 [Flags: R/W].
Sep  5 15:55:39 rasmus Initializing Cryptographic API
Sep  5 15:55:39 rasmus pci_hotplug: PCI Hot Plug PCI Core version: 0.5
Sep  5 15:55:39 rasmus ACPI: Power Button (FF) [PWRF]
Sep  5 15:55:39 rasmus ACPI: Processor [CPU0] (supports C1 C2, 16 throttling 
states)
Sep  5 15:55:39 rasmus lp: driver loaded but no devices found
Sep  5 15:55:39 rasmus Linux agpgart interface v0.100 (c) Dave Jones
Sep  5 15:55:39 rasmus agpgart: Detected VIA Twister-K/KT133x/KM133 chipset
Sep  5 15:55:39 rasmus agpgart: Maximum main memory to use for agp memory: 
564M
Sep  5 15:55:39 rasmus agpgart: AGP aperture is 256M @ 0xd0000000
Sep  5 15:55:39 rasmus serio: i8042 AUX port at 0x60,0x64 irq 12
Sep  5 15:55:39 rasmus serio: i8042 KBD port at 0x60,0x64 irq 1
Sep  5 15:55:39 rasmus Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, 
IRQ sharing disabled
Sep  5 15:55:39 rasmus ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Sep  5 15:55:39 rasmus ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
Sep  5 15:55:39 rasmus parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE]
Sep  5 15:55:39 rasmus parport0: Legacy device
Sep  5 15:55:39 rasmus lp0: using parport0 (polling).
Sep  5 15:55:39 rasmus parport_pc: Via 686A parallel port: io=0x378
Sep  5 15:55:39 rasmus acpi_floppy_resource: 4 ioports at 0x3f2
Sep  5 15:55:39 rasmus acpi_floppy_resource: 1 ioports at 0x3f7
Sep  5 15:55:39 rasmus floppy: controller ACPI FDC0 at I/O 0x3f2-0x3f5, 
0x3f7-0x3f7 irq 6 dma channel 2
Sep  5 15:55:39 rasmus Using anticipatory io scheduler
Sep  5 15:55:39 rasmus Floppy drive(s): fd0 is 1.44M
Sep  5 15:55:39 rasmus FDC 0 is a post-1991 82077
Sep  5 15:55:39 rasmus eepro100.c:v1.09j-t 9/29/99 Donald Becker 
http://www.scyld.com/network/eepro100.html
Sep  5 15:55:39 rasmus eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by 
Andrey V. Savochkin <saw@saw.sw.com.sg> and others
Sep  5 15:55:39 rasmus ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 9
Sep  5 15:55:39 rasmus ACPI: PCI interrupt 0000:00:0a.0[A] -> GSI 9 (level, 
low) -> IRQ 9
Sep  5 15:55:39 rasmus eth0: OEM i82557/i82558 10/100 Ethernet, 
00:08:C7:25:44:35, IRQ 9.
Sep  5 15:55:39 rasmus Receiver lock-up bug exists -- enabling work-around.
Sep  5 15:55:39 rasmus Board assembly 702536-006, Physical connectors present: 
RJ45
Sep  5 15:55:39 rasmus Primary interface chip i82555 PHY #1.
Sep  5 15:55:39 rasmus General self-test: passed.
Sep  5 15:55:39 rasmus Serial sub-system self-test: passed.
Sep  5 15:55:39 rasmus Internal registers self-test: passed.
Sep  5 15:55:39 rasmus ROM checksum self-test: passed (0x24c9f043).
Sep  5 15:55:39 rasmus Receiver lock-up workaround activated.
Sep  5 15:55:39 rasmus e100: Intel(R) PRO/100 Network Driver, 3.0.27-k2-NAPI
Sep  5 15:55:39 rasmus e100: Copyright(c) 1999-2004 Intel Corporation
Sep  5 15:55:39 rasmus Linux video capture interface: v1.00
Sep  5 15:55:39 rasmus Uniform Multi-Platform E-IDE driver Revision: 
7.00alpha2
Sep  5 15:55:39 rasmus ide: Assuming 33MHz system bus speed for PIO modes; 
override with idebus=xx
Sep  5 15:55:39 rasmus VP_IDE: IDE controller at PCI slot 0000:00:04.1
Sep  5 15:55:39 rasmus VP_IDE: chipset revision 16
Sep  5 15:55:39 rasmus VP_IDE: not 100% native mode: will probe irqs later
Sep  5 15:55:39 rasmus VP_IDE: VIA vt82c686a (rev 22) IDE UDMA66 controller on 
pci0000:00:04.1
Sep  5 15:55:39 rasmus ide0: BM-DMA at 0xd800-0xd807, BIOS settings: hda:DMA, 
hdb:DMA
Sep  5 15:55:39 rasmus ide1: BM-DMA at 0xd808-0xd80f, BIOS settings: hdc:DMA, 
hdd:pio
Sep  5 15:55:39 rasmus Probing IDE interface ide0...
Sep  5 15:55:39 rasmus hda: PLEXTOR CD-R PX-W1210A, ATAPI CD/DVD-ROM drive
Sep  5 15:55:39 rasmus hdb: COMPAQ DVD-ROM SR-8583, ATAPI CD/DVD-ROM drive
Sep  5 15:55:39 rasmus ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Sep  5 15:55:39 rasmus Probing IDE interface ide1...
Sep  5 15:55:39 rasmus hdc: TOSHIBA CD-ROM XM-6402B, ATAPI CD/DVD-ROM drive
Sep  5 15:55:39 rasmus ide1 at 0x170-0x177,0x376 on irq 15
Sep  5 15:55:39 rasmus PDC20265: IDE controller at PCI slot 0000:00:11.0
Sep  5 15:55:39 rasmus ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 10
Sep  5 15:55:39 rasmus ACPI: PCI interrupt 0000:00:11.0[A] -> GSI 10 (level, 
low) -> IRQ 10
Sep  5 15:55:39 rasmus PDC20265: chipset revision 2
Sep  5 15:55:39 rasmus PDC20265: 100% native mode on irq 10
Sep  5 15:55:39 rasmus PDC20265: (U)DMA Burst Bit ENABLED Primary PCI Mode 
Secondary PCI Mode.
Sep  5 15:55:39 rasmus ide2: BM-DMA at 0x6400-0x6407, BIOS settings: hde:pio, 
hdf:pio
Sep  5 15:55:39 rasmus ide3: BM-DMA at 0x6408-0x640f, BIOS settings: hdg:pio, 
hdh:pio
Sep  5 15:55:39 rasmus Probing IDE interface ide2...
Sep  5 15:55:39 rasmus hde: IBM-DPTA-372730, ATA DISK drive
Sep  5 15:55:39 rasmus ide2 at 0x7800-0x7807,0x7402 on irq 10
Sep  5 15:55:39 rasmus Probing IDE interface ide3...
Sep  5 15:55:39 rasmus hdg: Maxtor 6Y060L0, ATA DISK drive
Sep  5 15:55:39 rasmus ide3 at 0x7000-0x7007,0x6802 on irq 10
Sep  5 15:55:39 rasmus Probing IDE interface ide4...
Sep  5 15:55:39 rasmus ide4: Wait for ready failed before probe !
Sep  5 15:55:39 rasmus Probing IDE interface ide5...
Sep  5 15:55:39 rasmus ide5: Wait for ready failed before probe !
Sep  5 15:55:39 rasmus hde: max request size: 128KiB
Sep  5 15:55:39 rasmus hde: 53464320 sectors (27373 MB) w/1961KiB Cache, 
CHS=53040/16/63, UDMA(66)
Sep  5 15:55:39 rasmus hde: cache flushes supported
Sep  5 15:55:39 rasmus /dev/ide/host2/bus0/target0/lun0: p1 p2 < p5 p6 p7 >
Sep  5 15:55:39 rasmus hdg: max request size: 128KiB
Sep  5 15:55:39 rasmus hdg: 120103200 sectors (61492 MB) w/2048KiB Cache, 
CHS=65535/16/63, UDMA(100)
Sep  5 15:55:39 rasmus hdg: cache flushes supported
Sep  5 15:55:39 rasmus /dev/ide/host2/bus1/target0/lun0: p1
Sep  5 15:55:39 rasmus hdb: ATAPI 32X DVD-ROM drive, 512kB Cache, DMA
Sep  5 15:55:39 rasmus Uniform CD-ROM driver Revision: 3.20
Sep  5 15:55:39 rasmus hdc: ATAPI 32X CD-ROM drive, 256kB Cache, UDMA(33)
Sep  5 15:55:39 rasmus ide-scsi is deprecated for cd burning! Use ide-cd and 
give dev=/dev/hdX as device
Sep  5 15:55:39 rasmus scsi0 : SCSI host adapter emulation for IDE ATAPI 
devices
Sep  5 15:55:39 rasmus Vendor: PLEXTOR   Model: CD-R   PX-W1210A  Rev: 1.10
Sep  5 15:55:39 rasmus Type:   CD-ROM                             ANSI SCSI 
revision: 02
Sep  5 15:55:39 rasmus libata version 1.02 loaded.
Sep  5 15:55:39 rasmus sata_sil version 0.54
Sep  5 15:55:39 rasmus ACPI: PCI interrupt 0000:00:0b.0[A] -> GSI 10 (level, 
low) -> IRQ 10
Sep  5 15:55:39 rasmus ata1: SATA max UDMA/100 cmd 0xE882E080 ctl 0xE882E08A 
bmdma 0xE882E000 irq 10
Sep  5 15:55:39 rasmus ata2: SATA max UDMA/100 cmd 0xE882E0C0 ctl 0xE882E0CA 
bmdma 0xE882E008 irq 10
Sep  5 15:55:39 rasmus ata1: dev 0 cfg 49:2f00 82:7c6b 83:7f09 84:4003 85:7c69 
86:3e01 87:4003 88:207f
Sep  5 15:55:39 rasmus ata1: dev 0 ATA, max UDMA/133, 320173056 sectors: lba48
Sep  5 15:55:39 rasmus ata1: dev 0 configured for UDMA/100
Sep  5 15:55:39 rasmus scsi1 : sata_sil
Sep  5 15:55:39 rasmus ata2: no device found (phy stat 00000000)
Sep  5 15:55:39 rasmus scsi2 : sata_sil
Sep  5 15:55:39 rasmus Vendor: ATA       Model: Maxtor 6Y160M0    Rev: YAR5
Sep  5 15:55:39 rasmus Type:   Direct-Access                      ANSI SCSI 
revision: 05
Sep  5 15:55:39 rasmus SCSI device sda: 320173056 512-byte hdwr sectors 
(163929 MB)
Sep  5 15:55:39 rasmus SCSI device sda: drive cache: write back
Sep  5 15:55:39 rasmus /dev/scsi/host1/bus0/target0/lun0:<3>ata1: command 0x25 
timeout, stat 0x58 host_stat 0x60
Sep  5 15:55:39 rasmus ata1: status=0x58 { DriveReady SeekComplete 
DataRequest }
Sep  5 15:55:39 rasmus SCSI error : <1 0 0 0> return code = 0x8000002
Sep  5 15:55:39 rasmus Current sda: sense = 70 10
Sep  5 15:55:39 rasmus end_request: I/O error, dev sda, sector 0
Sep  5 15:55:39 rasmus Buffer I/O error on device sda, logical block 0
Sep  5 15:55:39 rasmus ATA: abnormal status 0x58 on port 0xE882E087
Sep  5 15:55:39 rasmus ATA: abnormal status 0x58 on port 0xE882E087
Sep  5 15:55:39 rasmus ATA: abnormal status 0x58 on port 0xE882E087
Sep  5 15:55:39 rasmus ata1: command 0x25 timeout, stat 0xd8 host_stat 0x61
Sep  5 15:55:39 rasmus ata1: status=0xd8 { Busy }
Sep  5 15:55:39 rasmus SCSI error : <1 0 0 0> return code = 0x8000002
Sep  5 15:55:39 rasmus Current sda: sense = 70 10
Sep  5 15:55:39 rasmus end_request: I/O error, dev sda, sector 0
Sep  5 15:55:39 rasmus Buffer I/O error on device sda, logical block 0
Sep  5 15:55:39 rasmus unable to read partition table
Sep  5 15:55:39 rasmus Attached scsi disk sda at scsi1, channel 0, id 0, lun 0
Sep  5 15:55:39 rasmus sr0: scsi3-mmc drive: 32x/32x writer cd/rw xa/form2 
cdda tray
Sep  5 15:55:39 rasmus Attached scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 
0
Sep  5 15:55:39 rasmus Attached scsi generic sg0 at scsi0, channel 0, id 0, 
lun 0,  type 5
Sep  5 15:55:39 rasmus Attached scsi generic sg1 at scsi1, channel 0, id 0, 
lun 0,  type 0
Sep  5 15:55:39 rasmus USB Universal Host Controller Interface driver v2.2
Sep  5 15:55:39 rasmus ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 9
Sep  5 15:55:39 rasmus ACPI: PCI interrupt 0000:00:04.2[D] -> GSI 9 (level, 
low) -> IRQ 9
Sep  5 15:55:39 rasmus uhci_hcd 0000:00:04.2: VIA Technologies, Inc. VT82xxxxx 
UHCI USB 1.1 Controller
Sep  5 15:55:39 rasmus uhci_hcd 0000:00:04.2: irq 9, io base 0000d400
Sep  5 15:55:39 rasmus uhci_hcd 0000:00:04.2: new USB bus registered, assigned 
bus number 1
Sep  5 15:55:39 rasmus hub 1-0:1.0: USB hub found
Sep  5 15:55:39 rasmus hub 1-0:1.0: 2 ports detected
Sep  5 15:55:39 rasmus ACPI: PCI interrupt 0000:00:04.3[D] -> GSI 9 (level, 
low) -> IRQ 9
Sep  5 15:55:39 rasmus uhci_hcd 0000:00:04.3: VIA Technologies, Inc. VT82xxxxx 
UHCI USB 1.1 Controller (#2)
Sep  5 15:55:39 rasmus uhci_hcd 0000:00:04.3: irq 9, io base 0000d000
Sep  5 15:55:39 rasmus uhci_hcd 0000:00:04.3: new USB bus registered, assigned 
bus number 2
Sep  5 15:55:39 rasmus hub 2-0:1.0: USB hub found
Sep  5 15:55:39 rasmus hub 2-0:1.0: 2 ports detected
Sep  5 15:55:39 rasmus usbcore: registered new driver usblp
Sep  5 15:55:39 rasmus drivers/usb/class/usblp.c: v0.13: USB Printer Device 
Class driver
Sep  5 15:55:39 rasmus Initializing USB Mass Storage driver...
Sep  5 15:55:39 rasmus usbcore: registered new driver usb-storage
Sep  5 15:55:39 rasmus USB Mass Storage support registered.
Sep  5 15:55:39 rasmus usbcore: registered new driver usbhid
Sep  5 15:55:39 rasmus drivers/usb/input/hid-core.c: v2.0:USB HID core driver
Sep  5 15:55:39 rasmus mice: PS/2 mouse device common for all mice
Sep  5 15:55:39 rasmus input: AT Translated Set 2 keyboard on isa0060/serio0
Sep  5 15:55:39 rasmus PCI: Enabling device 0000:00:09.1 (0004 -> 0005)
Sep  5 15:55:39 rasmus gameport: pci0000:00:09.1 speed 1217 kHz
Sep  5 15:55:39 rasmus Creative EMU10K1 PCI Audio Driver, version 0.20a, 
19:40:52 Aug 29 2004
Sep  5 15:55:39 rasmus PCI: Enabling device 0000:00:09.0 (0004 -> 0005)
Sep  5 15:55:39 rasmus ACPI: PCI interrupt 0000:00:09.0[A] -> GSI 9 (level, 
low) -> IRQ 9
Sep  5 15:55:39 rasmus emu10k1: EMU10K1 rev 7 model 0x8027 found, IO at 
0xa400-0xa41f, IRQ 9
Sep  5 15:55:39 rasmus ac97_codec: AC97  codec, id: TRA35 (TriTech TR A5)
Sep  5 15:55:39 rasmus Advanced Linux Sound Architecture Driver Version 1.0.6 
(Sun Aug 15 07:17:53 2004 UTC).
Sep  5 15:55:39 rasmus ALSA device list:
Sep  5 15:55:39 rasmus No soundcards found.
Sep  5 15:55:39 rasmus NET: Registered protocol family 2
Sep  5 15:55:39 rasmus IP: routing cache hash table of 8192 buckets, 64Kbytes
Sep  5 15:55:39 rasmus TCP: Hash tables configured (established 262144 bind 
65536)
Sep  5 15:55:39 rasmus ip_conntrack version 2.1 (5119 buckets, 40952 max) - 
332 bytes per conntrack
Sep  5 15:55:39 rasmus ip_tables: (C) 2000-2002 Netfilter core team
Sep  5 15:55:39 rasmus ipt_recent v0.3.1: Stephen Frost <sfrost@snowman.net>.  
http://snowman.net/projects/ipt_recent/
Sep  5 15:55:39 rasmus arp_tables: (C) 2002 David S. Miller
Sep  5 15:55:39 rasmus NET: Registered protocol family 1
Sep  5 15:55:39 rasmus NET: Registered protocol family 17
Sep  5 15:55:39 rasmus Started krxtimod 690
Sep  5 15:55:39 rasmus 
Sep  5 15:55:39 rasmus 
Sep  5 15:55:39 rasmus 
Sep  5 15:55:39 rasmus kAFS: Red Hat AFS client v0.1 registering.
Sep  5 15:55:39 rasmus Started krxiod 691
Sep  5 15:55:39 rasmus Started krxsecd 692
Sep  5 15:55:39 rasmus kAFS: Started kafstimod 693
Sep  5 15:55:39 rasmus kAFS: Started kafsasyncd 694
Sep  5 15:55:39 rasmus <== afs_fs_init() = 0
Sep  5 15:55:39 rasmus ACPI: (supports S0 S1 S4 S5)
Sep  5 15:55:39 rasmus ACPI wakeup devices: 
Sep  5 15:55:39 rasmus PWRB PCI0 UAR1 UAR2 USB0 USB1 
Sep  5 15:55:39 rasmus VFS: Mounted root (ext2 filesystem) readonly.
Sep  5 15:55:39 rasmus Mounted devfs on /dev
Sep  5 15:55:39 rasmus Freeing unused kernel memory: 176k freed
Sep  5 15:55:39 rasmus usb 1-2: new low speed USB device using address 2
Sep  5 15:55:39 rasmus input: USB HID v1.10 Mouse [Logitech USB-PS/2 Optical 
Mouse] on usb-0000:00:04.2-2
Sep  5 15:55:39 rasmus usb 2-2: new full speed USB device using address 2
Sep  5 15:55:39 rasmus hub 2-2:1.0: USB hub found
Sep  5 15:55:39 rasmus hub 2-2:1.0: 4 ports detected
Sep  5 15:55:39 rasmus Adding 1052216k swap on /dev/hde6.  Priority:-1 
extents:1
Sep  5 15:55:39 rasmus nvidia: module license 'NVIDIA' taints kernel.
Sep  5 15:55:39 rasmus ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
Sep  5 15:55:39 rasmus ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 11 (level, 
low) -> IRQ 11
Sep  5 15:55:39 rasmus NVRM: loading NVIDIA Linux x86 NVIDIA Kernel Module  
1.0-6111  Tue Jul 27 07:55:38 PDT 2004
Sep  5 15:55:39 rasmus ReiserFS: hdg1: found reiserfs format "3.6" with 
standard journal
Sep  5 15:55:39 rasmus ReiserFS: hdg1: using ordered data mode
Sep  5 15:55:39 rasmus ReiserFS: hdg1: journal params: device hdg1, size 8192, 
journal first block 18, max trans len 1024, max batch 900, max commit age 30, 
max trans age 30
Sep  5 15:55:39 rasmus ReiserFS: hdg1: checking transaction log (hdg1)
Sep  5 15:55:39 rasmus ReiserFS: hdg1: Using r5 hash to sort names
Sep  5 15:55:39 rasmus Real Time Clock Driver v1.12
Sep  5 15:56:44 rasmus cron[7782]: (CRON) STARTUP (fork ok)
Sep  5 15:56:47 rasmus init: Activating demand-procedures for 'A'
Sep  5 15:56:48 rasmus xfs: ignoring font path 
element /usr/X11R6/lib/X11/fonts/freefont (unreadable)
Sep  5 15:56:48 rasmus xfs: ignoring font path 
element /usr/X11R6/lib/X11/fonts/sharefont (unreadable)
Sep  5 15:56:48 rasmus xfs: ignoring font path 
element /usr/share/fonts/default/Type1 (unreadable)
Sep  5 15:56:48 rasmus xfs: ignoring font path 
element /usr/share/fonts/ttf/decoratives (unreadable)
Sep  5 15:56:48 rasmus xfs: ignoring font path 
element /usr/share/fonts/ttf/western (unreadable)
Sep  5 15:56:51 rasmus agpgart: Found an AGP 2.0 compliant device at 
0000:00:00.0.
Sep  5 15:56:51 rasmus agpgart: Putting AGP V2 device at 0000:00:00.0 into 4x 
mode
Sep  5 15:56:51 rasmus agpgart: Putting AGP V2 device at 0000:01:00.0 into 4x 
mode
Sep  5 15:56:52 rasmus agpgart: Found an AGP 2.0 compliant device at 
0000:00:00.0.
Sep  5 15:56:52 rasmus agpgart: Putting AGP V2 device at 0000:00:00.0 into 4x 
mode
Sep  5 15:56:52 rasmus agpgart: Putting AGP V2 device at 0000:01:00.0 into 4x 
mode
Sep  5 15:56:53 rasmus atkbd.c: Spurious ACK on isa0060/serio0. Some program, 
like XFree86, might be trying access hardware directly.
Sep  5 15:56:53 rasmus atkbd.c: Spurious ACK on isa0060/serio0. Some program, 
like XFree86, might be trying access hardware directly.
Sep  5 15:56:59 rasmus kdm_greet[8039]: Can't open default user face
Sep  5 15:57:00 rasmus CRON[8044]: (root) CMD (test -x /usr/sbin/run-crons 
&& /usr/sbin/run-crons )
Sep  5 15:58:00 rasmus CRON[8052]: (root) CMD (test -x /usr/sbin/run-crons 
&& /usr/sbin/run-crons )
Sep  5 15:59:00 rasmus CRON[8068]: (root) CMD (test -x /usr/sbin/run-crons 
&& /usr/sbin/run-crons )
