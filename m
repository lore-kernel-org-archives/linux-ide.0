From: Michal 'hramrach' Suchanek <hramrach@centrum.cz>
Subject: Via SATA not working here
Date: Sun, 12 Sep 2004 21:15:42 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20040912191542.GO21202@uvt316-2.ruk.cuni.cz>
Reply-To: Michal 'hramrach' Suchanek <hramrach@centrum.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from dec59.ruk.cuni.cz ([195.113.2.17]:52241 "HELO dec59.ruk.cuni.cz")
	by vger.kernel.org with SMTP id S268805AbUILTSE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 12 Sep 2004 15:18:04 -0400
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org

Hello

I got a mainboard with a Via SATA controller, a Maxtor UATA 133 drive,
and an Asus SATA dongle (probably a Marvell chip).

When I was installing Linux the SATA controller got detected as IDE and
basically worked. I would see occasional messages about DMA timeout
while running from the install cd but the installation finished without
errors.

After building a 2.6.7 kernel I would get pretty much the same result.
I get a few messages about DMA timeout at startup and then it runs. But
I found it would eventually lock up with the hdd led shining steadily.

After inspecting the state of the drive with hdparm I found the DMA is
turned off, probably because the drive was reset after the DMA timeout.
The driver would then only allow setting udma2, saying udma 3/4/5 would
not work. But the DMA timeout would occur with udma2 mode too.

After searching the web I found I could enable the libata drivers to get
native support for the controller. But after booting the new kernel I get
a write error and the system would not boot. The write error is bogus
because the drive and controller works with the standard ide driver.

I cannot easily reproduce the messages of the libata driver because the
system would not boot. The message of the ide driver is pasted below.

I will probably change the cabling and put the primary drive on the
parallel ata controller so that the system runs better and more
experiments can be eventually done with the sata drivers.

Thanks

Michal Suchanek


Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
VIA8237SATA: IDE controller at PCI slot 0000:00:0f.0
VIA8237SATA: chipset revision 128
VIA8237SATA: 100% native mode on irq 185
    ide0: BM-DMA at 0xdc00-0xdc07, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0xdc08-0xdc0f, BIOS settings: hdc:pio, hdd:pio
hda: Maxtor 6Y200P0, ATA DISK drive
Using anticipatory io scheduler
ide0 at 0xec00-0xec07,0xe802 on irq 185
VP_IDE: IDE controller at PCI slot 0000:00:0f.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt8237 (rev 00) IDE UDMA133 controller on pci0000:00:0f.1
    ide2: BM-DMA at 0xfc00-0xfc07, BIOS settings: hde:DMA, hdf:pio
    ide3: BM-DMA at 0xfc08-0xfc0f, BIOS settings: hdg:DMA, hdh:pio
hde: Pioneer DVD-ROM ATAPIModel DVD-120S, ATAPI CD/DVD-ROM drive
ide2 at 0x1f0-0x1f7,0x3f6 on irq 14
hdg: YAMAHA CRW-F1E, ATAPI CD/DVD-ROM drive
ide3 at 0x170-0x177,0x376 on irq 15
hda: max request size: 1024KiB
hda: 398297088 sectors (203928 MB) w/7936KiB Cache, CHS=24792/255/63

<snip>

hda: dma_timer_expiry: dma status == 0x20
hda: DMA timeout retry
hda: timeout waiting for DMA
hda: status timeout: status=0xd0 { Busy }

hda: drive not ready for command
ide0: reset: success


lspci view of the controller:

00:0f.0 Class 0104: 1106:3149 (rev 80)
00:0f.0 RAID bus controller: VIA Technologies, Inc.: Unknown device 3149
(rev 80)
        Subsystem: Micro-star International Co Ltd: Unknown device 5901
        Flags: bus master, medium devsel, latency 32, IRQ 185
        I/O ports at ec00 [size=8]
        I/O ports at e800 [size=4]
        I/O ports at e400 [size=8]
        I/O ports at e000 [size=4]
        I/O ports at dc00 [size=16]
        I/O ports at d800 [size=256]
        Capabilities: [c0] Power Management version 2

00:0f.1 Class 0101: 1106:0571 (rev 06)
00:0f.1 IDE interface: VIA Technologies, Inc. VT82C586/B/686A/B PIPC Bus
Master
IDE (rev 06) (prog-if 8a [Master SecP PriP])
        Subsystem: Micro-star International Co Ltd: Unknown device 5901
        Flags: bus master, medium devsel, latency 32, IRQ 185
        I/O ports at fc00 [size=16]
        Capabilities: [c0] Power Management version 2


hdparm view of the drive:

 Model=Maxtor 6Y200P0, FwRev=YAR41BW0, SerialNo=Y63G7CJE
 Config={ Fixed }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=57
 BuffType=DualPortCache, BuffSize=7936kB, MaxMultSect=16, MultSect=off
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=268435455
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes:  pio0 pio1 pio2 pio3 pio4
 DMA modes:  mdma0 mdma1 mdma2
 UDMA modes: udma0 udma1 *udma2 udma3 udma4 udma5 udma6
 AdvancedPM=yes: disabled (255) WriteCache=enabled
 Drive conforms to: (null):

