From: Peter Chubb <peter@chubb.wattle.id.au>
Subject: PIIX ide driver can't disable DMA
Date: Wed, 19 Nov 2003 21:29:13 +1100
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <16315.17913.982049.700867@wombat.chubb.wattle.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org


Hi Folks,
   On an I2000 there's a PIIX5 IDE controller and a pci bridge that
identifies as a 450NX rev 5.  This causes the ide driver to attempt to
disable DMA, to work around a limitation in the old 450NX chipset.

Unfortunately, this doesn't work, and on boot I see these messages:

piix: 450NX errata present, disabling IDE DMA.
piix: A BIOS update may resolve this.
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller at PCI slot 0000:00:03.1
PCI: Found IRQ 0 for device 0000:00:03.1
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1070-0x1077, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0x1078-0x107f, BIOS settings: hdc:pio, hdd:pio
hda: HITACHI DVD-ROM GD-7500, ATAPI CD/DVD-ROM drive
hdb: LS-120/240 00 UHD Floppy, ATAPI FLOPPY drive
Using anticipatory io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 34
hdc: Maxtor 6Y080L0, ATA DISK drive
ide1 at 0x170-0x177,0x376 on irq 33
hdc: max request size: 128KiB
hdc: 160086528 sectors (81964 MB) w/2048KiB Cache, CHS=65535/16/63, (U)DMA
hdc:<4>hdc: dma_timer_expiry: dma status == 0x21
hdc: DMA timeout error

If I boot with ide1=nodma things work.

It's currently broken to try to unconfigure IDE DMA with kconfig.

Note that:
     1. The PIIX5 at is not on the same PCI bus as the 450NX PXB.
     From lspci:

     00:03.1 IDE interface: Intel Corp. 82372FB PIIX5 IDE (rev 01)
     04:10.1 Host bridge: Intel Corp. 450NX - 82454NX/84460GX PCI Expander
     Bridge (rev 05)

     2.  As far as I can tell from Intel's website, the device that
     identifies as a 450NX is actually part of the 460GX chipset; and it's
     only rev 0 through 3 that have the problem (the `real' 450NX
chips) (although I could easily be wrong there; it's hard to work out
what the PCI revision field corresponds to in Intel's stepping chart.
The bug is in steppings A0, B0 and C0.)


--
Dr Peter Chubb  http://www.gelato.unsw.edu.au  peterc AT gelato.unsw.edu.au
The technical we do immediately,  the political takes *forever*
