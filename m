From: Andre Hedrick <andre@linux-ide.org>
Subject: IO/MMIO 2.4 ATA/IDE driver recore near complete
Date: Sat, 18 May 2002 02:37:35 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <Pine.LNX.4.10.10205180230290.774-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-ide@vger.kernel.org


Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes
PIIX3: IDE controller on PCI bus 00 dev 39
PIIX3: chipset revision 0
PIIX3: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:pio, hdd:pio
SiI680: IDE controller on PCI bus 00 dev 90
SiI680: chipset revision 1
SiI680: not 100% native mode: will probe irqs later
SiI680: mmio capable at 0xe080df00
SiI680: BASE CLOCK == 2X PCI
    ide2: MMIO-DMA at 0xe080df00-0xe080df07, BIOS settings: hde:pio, hdf:pio
    ide3: MMIO-DMA at 0xe080df08-0xe080df0f, BIOS settings: hdg:pio, hdh:pio
hda: ATAPI 44X CDROM, ATAPI CD/DVD-ROM drive
hdb: CREATIVEDVD5240E-1, ATAPI CD/DVD-ROM drive
hde: Maxtor 4G160J8, ATA DISK drive
hdg: Maxtor 4G160H8, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide2 at 0xe080dfc0-0xe080dfc7,0xe080dfca on irq 9
ide3 at 0xe080df80-0xe080df87,0xe080df8a on irq 9
hde: host protected area => 1
hde: 320173056 sectors (163929 MB) w/2048KiB Cache, CHS=19929/255/63
hdg: host protected area => 1
hdg: 320173056 sectors (163929 MB) w/2048KiB Cache, CHS=19929/255/63
hda: ATAPI 40X CD-ROM drive, 128kB Cache, (U)DMA
Uniform CD-ROM driver Revision: 3.12
hdb: ATAPI 32X DVD-ROM drive, 512kB Cache, DMA

Please note BMDMA for MMIO is not native since there appears to be
pci-posting errors under x86.

Cheers,

Andre Hedrick
LAD Storage Consulting Group

