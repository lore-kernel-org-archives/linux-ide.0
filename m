From: dnadan-list <dnadan-list@htu.se>
Subject: Deskstar 180GXP, 2.5.45, TCQ
Date: Sat, 2 Nov 2002 15:36:11 +0100 (CET)
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <Pine.LNX.4.44.0211021501450.13799-100000@agatha.thn.htu.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ravms by thn.htu.se with mail-ok (Exim 4.10)
	id 187zKp-0005CK-00
	for linux-ide@vger.kernel.org; Sat, 02 Nov 2002 15:33:11 +0100
Received: from agatha.thn.htu.se ([193.10.193.88])
	by thn.htu.se with esmtp (Exim 4.10)
	id 187zKp-0005CE-00
	for linux-ide@vger.kernel.org; Sat, 02 Nov 2002 15:33:11 +0100
Received: from dnadan-list (helo=localhost)
	by agatha.thn.htu.se with local-esmtp (Exim 4.10)
	id 187zNj-0003bp-00
	for linux-ide@vger.kernel.org; Sat, 02 Nov 2002 15:36:11 +0100
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

I recently bought a 60GB Deskstar 180GXP, IC35L060AVV207-0, and it seems 
to work just fine with TCQ and DMA, ATA-100 enabled. I'm using an Abit KT133A
mb without RAID controller. The thing is, I get these boot messages, from dmesg:

block request queues:
 128 requests per read queue
 128 requests per write queue
 8 requests per batch
 enter congestion at 31
 exit congestion at 33
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with 
idebus=xx
VP_IDE: IDE controller at PCI slot 00:07.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with 
idebus=xx
VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci00:07.1
    ide0: BM-DMA at 0xe000-0xe007, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0xe008-0xe00f, BIOS settings: hdc:DMA, hdd:pio
hdc: IC35L060AVV207-0, ATA DISK drive
hdc: DMA disabled
hdc: bad special flag: 0x03
hdc: tagged command queueing enabled, command queue depth 32
ide1 at 0x170-0x177,0x376 on irq 15
hdc: host protected area => 1
hdc: 120103200 sectors (61493 MB) w/1821KiB Cache, CHS=7476/255/63, 
UDMA(100)
 hdc: hdc1 hdc2 hdc3 hdc4 < hdc5 hdc6 hdc7 hdc8 >

My hda and hdb are powered down at the moment.

I'm concerned about the hdc: DMA disabled, even though /proc/ide/via 
displays Transfer Mode: UDMA, and /proc/ide/hdc/settings displays 
using_dma=1. I'm using Via driver v. 3.35-ac. And also the "hdc: bad 
special flag: 0x03" message in dmesg. 

The drive feels quicker with TCQ enabled, although I haven't run any 
tests. The drive is configured with quiet seek mode=0, write buffer 
enabled and prefetch data enabled in the HD firmware (using the IBM 
Feature tool), but /proc/ide/hdc/settings display wcache=0. Guess this is 
just the driver default. Using ext3 btw. 


Compiled 2.5.45, without warnings, with these options

CONFIG_BLK_DEV_IDE=y
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_BLK_DEV_IDECD=m
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDE_TCQ=y
CONFIG_BLK_DEV_IDE_TCQ_DEFAULT=y
CONFIG_BLK_DEV_IDE_TCQ_DEPTH=32
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_BLK_DEV_ADMA=y
CONFIG_BLK_DEV_VIA82CXXX=y
CONFIG_IDEDMA_AUTO=y
CONFIG_BLK_DEV_IDE_MODES=y


/Anders Antonsson - dnadan@htu.se, dnadan-list@htu.se


