From: qdot@SAFe-mail.net
Subject: Problem: DMA on PIIX4 controller for LiteON 851S DVDRW Drive
Date: Mon, 14 Jun 2004 11:17:37 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <N1-OQ8ech2f@SAFe-mail.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from tapuz.safe-mail.net ([212.68.149.115]:16542 "EHLO
	tapuz.safe-mail.net") by vger.kernel.org with ESMTP id S261252AbUFNPRj
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 14 Jun 2004 11:17:39 -0400
Received: from qdot@SAFe-mail.net by tapuz.safe-mail.net with SAFe-mail (Exim 4.30)
	id 1BZtDN-00050P-Gk
	for linux-ide@vger.kernel.org; Mon, 14 Jun 2004 11:17:37 -0400
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi

Sorry to bother you with such a question but I got into some sort of trouble with DMA settings on PIIX4 controller for LiteON 851S DVDRW Drive on Linux 2.6.6 (vanilla).

When dma has been setup (either using bios, boot parameters or hdparm) on first access to drive system ends up with:

Jun 14 11:50:10 valkyrie hdc: cdrom_decode_status: status=0x51 { DriveReady SeekCom
plete Error }
Jun 14 11:50:10 valkyrie hdc: cdrom_decode_status: error=0x40LastFailedSense 0x04
Jun 14 11:50:10 valkyrie hdc: cdrom_decode_status: status=0x51 { DriveReady SeekCom
plete Error }
Jun 14 11:50:10 valkyrie hdc: cdrom_decode_status: error=0x40LastFailedSense 0x04
Jun 14 11:50:10 valkyrie hdc: cdrom_decode_status: status=0x51 { DriveReady SeekCom
plete Error }
Jun 14 11:50:10 valkyrie hdc: cdrom_decode_status: error=0x40LastFailedSense 0x04
Jun 14 11:50:10 valkyrie hdc: cdrom_decode_status: status=0x51 { DriveReady SeekCom
plete Error }
Jun 14 11:50:10 valkyrie hdc: cdrom_decode_status: error=0x40LastFailedSense 0x04
Jun 14 11:50:10 valkyrie hdc: DMA disabled
Jun 14 11:50:10 valkyrie hdc: ide_intr: huh? expected NULL handler on exit
Jun 14 11:50:10 valkyrie hdc: ATAPI reset complete

And as you see falls back to non-dma mode.

Dma works perfectly on this machine with two other drives: SAMSUNG SP0802N and FUJITSU MPD3043AT

Also LITE-ON DVDRW LDW-851S works perfectly with dma on Via IDE controller (via 8233 I guess) and on some Amd motherboard (I dont remember chipset). 

So theoretically it should work.


Thanks in advance,

Tomasz Mloduchowski

### 
nopcode: No, it isn't. Win32 lacks the equivalent of fork().  
Deek:    windoze is not meant for people who should have access to sharp objects, 
         hence no fork() instead, you must rely on spoon()


Details: 
Controler:

0000:00:07.1 IDE interface: Intel Corp. 82371AB/EB/MB PIIX4 IDE (rev 01) (prog-if 80 [Master])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Region 4: I/O ports at 1080 [size=16]


Drive:
valkyrie kwant # hdparm -i /dev/hdc

/dev/hdc:

 Model=LITE-ON DVDRW LDW-851S, FwRev=GS0H, SerialNo=2004020700023057
 Config={ Fixed Removeable DTR<=5Mbs DTR>10Mbs nonMagnetic }
 RawCHS=0/0/0, TrkSize=0, SectSize=0, ECCbytes=0
 BuffType=unknown, BuffSize=0kB, MaxMultSect=0
 (maybe): CurCHS=0/0/0, CurSects=0, LBA=yes, LBAsects=0
 IORDY=yes, tPIO={min:227,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes:  pio0 pio1 pio2 pio3 pio4
 DMA modes:  mdma0 mdma1 mdma2
 UDMA modes: udma0 udma1 *udma2
 AdvancedPM=no
 Drive conforms to: device does not report version:

 * signifies the current active mode

Boot-up:
Jun  7 11:40:20 valkyrie Linux version 2.6.6 (root@valkyrie) (gcc version 3.3.2 200312
18 (Gentoo Linux 3.3.2-r5, propolice-3.3-7)) #2 Wed May 26 10:59:10 UTC 2004
Jun  7 11:40:20 valkyrie BIOS-provided physical RAM map:
Jun  7 11:40:20 valkyrie BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
Jun  7 11:40:20 valkyrie BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
Jun  7 11:40:20 valkyrie BIOS-e820: 00000000000e7000 - 0000000000100000 (reserved)
Jun  7 11:40:20 valkyrie BIOS-e820: 0000000000100000 - 000000000fffdc00 (usable)
Jun  7 11:40:20 valkyrie BIOS-e820: 000000000fffdc00 - 000000000ffffc00 (ACPI data)
Jun  7 11:40:20 valkyrie BIOS-e820: 000000000ffffc00 - 0000000010000000 (ACPI NVS)
Jun  7 11:40:20 valkyrie BIOS-e820: 00000000fffe7000 - 0000000100000000 (reserved)
Jun  7 11:40:20 valkyrie 255MB LOWMEM available.
Jun  7 11:40:20 valkyrie On node 0 totalpages: 65533
Jun  7 11:40:20 valkyrie DMA zone: 4096 pages, LIFO batch:1
Jun  7 11:40:20 valkyrie Normal zone: 61437 pages, LIFO batch:14
Jun  7 11:40:20 valkyrie HighMem zone: 0 pages, LIFO batch:1
Jun  7 11:40:20 valkyrie DMI 2.1 present.
Jun  7 11:40:20 valkyrie ACPI disabled because your bios is from 2000 and too old
Jun  7 11:40:20 valkyrie You can enable it with acpi=force
Jun  7 11:40:20 valkyrie Built 1 zonelists
Jun  7 11:40:20 valkyrie Kernel command line: root=/dev/hda2
Jun  7 11:40:20 valkyrie Initializing CPU#0
Jun  7 11:40:20 valkyrie PID hash table entries: 1024 (order 10: 8192 bytes)
Jun  7 11:40:20 valkyrie Detected 449.092 MHz processor.
Jun  7 11:40:20 valkyrie Using tsc for high-res timesource
Jun  7 11:40:20 valkyrie Console: colour VGA+ 80x25
Jun  7 11:40:20 valkyrie Memory: 257044k/262132k available (1326k kernel code, 4348
k reserved, 657k data, 112k init, 0k highmem)
Jun  7 11:40:20 valkyrie Checking if this processor honours the WP bit even in supe
rvisor mode... Ok.
Jun  7 11:40:20 valkyrie Calibrating delay loop... 886.78 BogoMIPS
Jun  7 11:40:20 valkyrie Dentry cache hash table entries: 32768 (order: 5, 131072 b
ytes)
Jun  7 11:40:20 valkyrie Inode-cache hash table entries: 16384 (order: 4, 65536 byt
es)
Jun  7 11:40:20 valkyrie Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
Jun  7 11:40:20 valkyrie CPU:     After generic identify, caps: 0383f9ff 00000000 0
0000000 00000000
Jun  7 11:40:20 valkyrie CPU:     After vendor identify, caps: 0383f9ff 00000000 00
000000 00000000
Jun  7 11:40:20 valkyrie CPU: L1 I cache: 16K, L1 D cache: 16K
Jun  7 11:40:20 valkyrie CPU: L2 cache: 512K
Jun  7 11:40:20 valkyrie CPU:     After all inits, caps: 0383f9ff 00000000 00000000
 00000040
Jun  7 11:40:20 valkyrie CPU: Intel Pentium III (Katmai) stepping 03
Jun  7 11:40:20 valkyrie Enabling fast FPU save and restore... done.
Jun  7 11:40:20 valkyrie Enabling unmasked SIMD FPU exception support... done.
Jun  7 11:40:20 valkyrie Checking 'hlt' instruction... OK.
Jun  7 11:40:20 valkyrie POSIX conformance testing by UNIFIX
Jun  7 11:40:20 valkyrie NET: Registered protocol family 16
Jun  7 11:40:20 valkyrie PCI: PCI BIOS revision 2.10 entry at 0xfd9b4, last bus=1
Jun  7 11:40:20 valkyrie PCI: Using configuration type 1
Jun  7 11:40:20 valkyrie mtrr: v2.0 (20020519)
Jun  7 11:40:20 valkyrie Linux Plug and Play Support v0.97 (c) Adam Belay
Jun  7 11:40:20 valkyrie SCSI subsystem initialized
Jun  7 11:40:20 valkyrie PCI: Probing PCI hardware
Jun  7 11:40:20 valkyrie PCI: Probing PCI hardware (bus 00)
Jun  7 11:40:20 valkyrie PCI: Using IRQ router PIIX/ICH [8086/7110] at 0000:00:07.0
Jun  7 11:40:20 valkyrie devfs: 2004-01-31 Richard Gooch (rgooch@atnf.csiro.au)
Jun  7 11:40:20 valkyrie devfs: boot_options: 0x0
Jun  7 11:40:20 valkyrie Initializing Cryptographic API
Jun  7 11:40:20 valkyrie Limiting direct PCI/PCI transfers.
Jun  7 11:40:20 valkyrie isapnp: Scanning for PnP cards...
Jun  7 11:40:20 valkyrie isapnp: No Plug & Play device found
Jun  7 11:40:20 valkyrie Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
Jun  7 11:40:20 valkyrie ide: Assuming 33MHz system bus speed for PIO modes; overri
de with idebus=xx
Jun  7 11:40:20 valkyrie PIIX4: IDE controller at PCI slot 0000:00:07.1
Jun  7 11:40:20 valkyrie PIIX4: chipset revision 1
Jun  7 11:40:20 valkyrie PIIX4: not 100% native mode: will probe irqs later
Jun  7 11:40:20 valkyrie ide0: BM-DMA at 0x1060-0x1067, BIOS settings: hda:DMA, hdb
:DMA
Jun  7 11:40:20 valkyrie ide1: BM-DMA at 0x1068-0x106f, BIOS settings: hdc:DMA, hdd
:pio
Jun  7 11:40:20 valkyrie hda: SAMSUNG SP0802N, ATA DISK drive
Jun  7 11:40:20 valkyrie hdb: FUJITSU MPD3043AT, ATA DISK drive
Jun  7 11:40:20 valkyrie Using anticipatory io scheduler
Jun  7 11:40:20 valkyrie ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Jun  7 11:40:20 valkyrie hdc: LITE-ON DVDRW LDW-851S, ATAPI CD/DVD-ROM drive
Jun  7 11:40:20 valkyrie ide1 at 0x170-0x177,0x376 on irq 15
Jun  7 11:40:20 valkyrie hda: max request size: 1024KiB
Jun  7 11:40:20 valkyrie hda: 156368016 sectors (80060 MB) w/2048KiB Cache, CHS=163
83/255/63, UDMA(33)
Jun  7 11:40:20 valkyrie /dev/ide/host0/bus0/target0/lun0: p1 p2 p3
Jun  7 11:40:20 valkyrie hdb: max request size: 128KiB
Jun  7 11:40:20 valkyrie hdb: 8448300 sectors (4325 MB) w/512KiB Cache, CHS=8940/15
/63, UDMA(33)
Jun  7 11:40:20 valkyrie /dev/ide/host0/bus0/target1/lun0: p1
Jun  7 11:40:20 valkyrie hdc: ATAPI 63X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache,
UDMA(33)
Jun  7 11:40:20 valkyrie Uniform CD-ROM driver Revision: 3.20





