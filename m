From: Anders Widman <andewid@tnonline.net>
Subject: Promise U100TX2
Date: Thu, 23 May 2002 15:12:24 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <10419361171.20020523151224@tnonline.net>
Reply-To: Anders Widman <andewid@tnonline.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


   Hello,

   I  hope this got to the correct mailinglist. If not, please help me
   find the correct one.

   This is my current setup:

   Asus P2B motherboard with Intel PIIX DMA33 IDE controller.
   512MB RAM, Intel PIII 500MHz
   3 Promise Ultra 100TX2 cards
   14 IDE harddrives, All DMA100 or DMA-133.

   There  are two issues I have atm. The first is that I cannot enable
   higher  DMA-mode than UDMA-33. The other is that I get DMA timeouts
   and IRQ problems.

   I  have  been testing with kernels 2.4.17 through 2.4.19-8 with GCC
   2.95, 2.96 and 3.01-3.1 with APIC and ACPI enabled and dissabled.
   
   This is the output from /var/log/dmesg:

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller on PCI bus 00 dev 21
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xb800-0xb807, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xb808-0xb80f, BIOS settings: hdc:DMA, hdd:DMA
PDC20268: IDE controller on PCI bus 00 dev 48
PCI: Found IRQ 3 for device 00:09.0
PCI: Sharing IRQ 3 with 00:04.2
PDC20268: chipset revision 2
PDC20268: not 100% native mode: will probe irqs later
    ide2: BM-DMA at 0x9800-0x9807, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0x9808-0x980f, BIOS settings: hdg:pio, hdh:pio
PDC20268: IDE controller on PCI bus 00 dev 50
PCI: Found IRQ 4 for device 00:0a.0
PDC20268: chipset revision 1
PDC20268: not 100% native mode: will probe irqs later
    ide4: BM-DMA at 0x8000-0x8007, BIOS settings: hdi:pio, hdj:pio
    ide5: BM-DMA at 0x8008-0x800f, BIOS settings: hdk:pio, hdl:pio
PDC20268: IDE controller on PCI bus 00 dev 58
PCI: Found IRQ 10 for device 00:0b.0
PDC20268: chipset revision 2
PDC20268: not 100% native mode: will probe irqs later
    ide6: BM-DMA at 0x6400-0x6407, BIOS settings: hdm:pio, hdn:pio
    ide7: BM-DMA at 0x6408-0x640f, BIOS settings: hdo:pio, hdp:pio

hda: 18041184 sectors (9237 MB) w/371KiB Cache, CHS=1123/255/63, UDMA(33)
hdb: 160086528 sectors (81964 MB) w/2048KiB Cache, CHS=9964/255/63, UDMA(33)
hdc: 150136560 sectors (76870 MB) w/1916KiB Cache, CHS=148945/16/63, UDMA(33)
hdd: 150136560 sectors (76870 MB) w/1916KiB Cache, CHS=148945/16/63, UDMA(33)
hde: 117231408 sectors (60022 MB) w/2048KiB Cache, CHS=116301/16/63, UDMA(33)
hdf: 120103200 sectors (61493 MB) w/1916KiB Cache, CHS=119150/16/63, UDMA(33)
hdg: 160086528 sectors (81964 MB) w/2048KiB Cache, CHS=158816/16/63, UDMA(33)
hdh: 60030432 sectors (30736 MB) w/2048KiB Cache, CHS=59554/16/63, UDMA(33)
hdi: 117231408 sectors (60022 MB) w/2048KiB Cache, CHS=116301/16/63, UDMA(33)
hdj: 120060864 sectors (61471 MB) w/2048KiB Cache, CHS=119108/16/63, UDMA(33)
hdk: 80043264 sectors (40982 MB) w/2048KiB Cache, CHS=79408/16/63, UDMA(33)
hdl: 240121728 sectors (122942 MB) w/2048KiB Cache, CHS=238216/255/63, UDMA(33)
hdm: 117266688 sectors (60041 MB) w/2000KiB Cache, CHS=116336/16/63, UDMA(33)
hdn: 117266688 sectors (60041 MB) w/2000KiB Cache, CHS=116336/16/63, UDMA(33)

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

    This  is  very  odd,  as all drives are capable of at least DMA100
    (except  for  HDA, which is an older drive). hda-hdd are connected
    to  the  onboard  DMA-33 controller and the other are connected to
    the Promise cards.

    The other error is about:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

May 22 10:57:16 server kernel: hdh: timeout waiting for DMA
May 22 10:57:16 server kernel: PDC202XX: Secondary channel reset.
May 22 10:57:16 server kernel: hdh: ide_dma_timeout: Lets do it again!stat = 0xd0, dma_stat = 0x40
May 22 10:57:16 server kernel: hdh: DMA disabled
May 22 10:57:16 server kernel: PDC202XX: Secondary channel reset.
May 22 10:57:16 server kernel: hdh: ide_set_handler: handler not null; old=c0204190, new=c020a0f0
May 22 10:57:16 server kernel: bug: kernel timer added twice at c0203f5e.

May 22 20:48:58 server kernel: hdh: DMA disabled
May 22 20:49:04 server kernel: hdh: DMA disabled
May 22 16:09:16 server kernel: hdh: lost interrupt

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

    Now,  this  might  look  as a generic hardware failure, but I have
    already  tried  to  replace  the drives that were reported in this
    manner.  If  I  swap  places,  the  error  remains, mainly, on the
    same  ide  channel  (hdh, hdi, hdg etc) and does not move with the
    drives.

    I have also tried swapping the Promise cards.

    What can be wrong? And how do I correct this?

    Thanks,
    Anders Widman

