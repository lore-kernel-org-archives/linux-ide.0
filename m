From: Alessandro Bono <a.bono@libero.it>
Subject: big delay on boot with new pata drivers
Date: Sun, 24 Sep 2006 23:56:49 +0200
Message-ID: <ef6uv1$63r$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:34202 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751628AbWIXV5F (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 24 Sep 2006 17:57:05 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GRby3-0002JK-TY
	for linux-ide@vger.kernel.org; Sun, 24 Sep 2006 23:56:55 +0200
Received: from host-84-221-85-252.cust-adsl.tiscali.it ([84.221.85.252])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Sun, 24 Sep 2006 23:56:55 +0200
Received: from a.bono by host-84-221-85-252.cust-adsl.tiscali.it with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Sun, 24 Sep 2006 23:56:55 +0200
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi

I'm trying new libata pata support from linux-2.6.18-git3
system seems working but on startup there is a big delay while probing for
ata devices

these are relevant log from kernel

libata version 2.00 loaded.
ata_piix 0000:00:1f.1: version 2.00ac6
PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 7
PCI: setting IRQ 7 as level-triggered
ACPI: PCI Interrupt 0000:00:1f.1[A] -> Link [LNKC] -> GSI 7 (level, low) ->
IRQ 7
PCI: Setting latency timer of device 0000:00:1f.1 to 64
ata1: PATA max UDMA/100 cmd 0x1F0 ctl 0x3F6 bmdma 0xFFA0 irq 14
ata2: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0xFFA8 irq 15
scsi0 : ata_piix
ata1.00: ATA-6, max UDMA/100, 195371568 sectors: LBA
ata1.00: ata1: dev 0 multi count 16
ata1.00: configured for UDMA/100
scsi1 : ata_piix
ata2.00: ATAPI, max UDMA/33
ata2.01: qc timeout (cmd 0xa1)
ata2.01: failed to IDENTIFY (I/O error, err_mask=0x4)
ata2: failed to recover some devices, retrying in 5 secs
ata2.01: qc timeout (cmd 0xa1)
ata2.01: failed to IDENTIFY (I/O error, err_mask=0x4)
ata2: failed to recover some devices, retrying in 5 secs
ata2.01: qc timeout (cmd 0xa1)
ata2.01: failed to IDENTIFY (I/O error, err_mask=0x4)
ata2: failed to recover some devices, retrying in 5 secs
ata2.00: configured for UDMA/33
scsi 0:0:0:0: Direct access     ATA      FUJITSU MHV2100A 0000 PQ: 0 ANSI: 5
SCSI device sda: 195371568 512-byte hdwr sectors (100030 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sda: 195371568 512-byte hdwr sectors (100030 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
 sda: sda1 sda2
sd 0:0:0:0: Attached scsi disk sda
scsi 1:0:0:0: CD/DVD            MATSHITA UJ-820D          1.01 PQ: 0 ANSI: 5
......
sd 0:0:0:0: Attached scsi generic sg0 type 0
sr 1:0:0:0: Attached scsi generic sg1 type 5

same machine with 2.6.18 and old ide modules

Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH4: IDE controller at PCI slot 0000:00:1f.1
PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 7
PCI: setting IRQ 7 as level-triggered
ACPI: PCI Interrupt 0000:00:1f.1[A] -> Link [LNKC] -> GSI 7 (level, low) ->
IRQ 7
ICH4: chipset revision 3
ICH4: not 100%% native mode: will probe irqs later
ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:pio
ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide0...
hda: FUJITSU MHV2100AH, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: MATSHITAUJ-820D, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 195371568 sectors (100030 MB) w/8192KiB Cache, CHS=65535/16/63
hda: cache flushes supported
hda: hda1 hda2
......
hdc: ATAPI 24X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache
Uniform CD-ROM driver Revision: 3.20


from lspci
0000:00:1f.1 IDE interface: Intel Corporation 82801DBM (ICH4-M) IDE
Controller (rev 03) (prog-if 8a [Master SecP PriP])
        Subsystem: Sony Corporation: Unknown device 8188
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 7
        Region 0: I/O ports at <unassigned>
        Region 1: I/O ports at <unassigned>
        Region 2: I/O ports at <unassigned>
        Region 3: I/O ports at <unassigned>
        Region 4: I/O ports at ffa0 [size=16]
        Region 5: Memory at 88000000 (32-bit, non-prefetchable) [size=1K]



