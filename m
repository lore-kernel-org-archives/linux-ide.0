From: Fallucchi Antonio Giuseppe <fallucch@csr.unibo.it>
Subject: Problem width Promise tx2 udma 133!
Date: Thu, 20 Mar 2003 13:05:01 +0100
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <1048161901.3e79ae6da8fb0@webmail.csr.unibo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.csr.unibo.it (Postfix) with ESMTP id B65F3CE153
	for <linux-ide@vger.kernel.org>; Thu, 20 Mar 2003 13:05:01 +0100 (CET)
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hallo!

I have a problem width a controller promise tx2 udma133 e kernel 2.4.20 on 
matherboard asus P2B and disk maxtor 80gb udma133.

when startup the system, the driver see the disk width udma33.

system log:

 Uniform Multi-Platform E-IDE driver Revision: 6.31
Mar 20 11:27:12 sprite kernel: ide: Assuming 66MHz system bus speed for PIO 
modes
Mar 20 11:27:12 sprite kernel: PIIX4: IDE controller on PCI bus 00 dev 21
Mar 20 11:27:12 sprite kernel: PIIX4: chipset revision 1
Mar 20 11:27:12 sprite kernel: PIIX4: not 100%% native mode: will probe irqs 
later
Mar 20 11:27:12 sprite kernel:     ide0: BM-DMA at 0xb800-0xb807, BIOS 
settings: hda:DMA, hdb:pio
Mar 20 11:27:12 sprite kernel:     ide1: BM-DMA at 0xb808-0xb80f, BIOS 
settings: hdc:DMA, hdd:DMA
Mar 20 11:27:12 sprite kernel: PDC20269: IDE controller on PCI bus 00 dev 48
Mar 20 11:27:12 sprite kernel: PCI: Found IRQ 5 for device 00:09.0
Mar 20 11:27:12 sprite kernel: PCI: Sharing IRQ 5 with 00:04.2
Mar 20 11:27:12 sprite kernel: PDC20269: chipset revision 2
Mar 20 11:27:12 sprite kernel: PDC20269: not 100%% native mode: will probe irqs 
later
Mar 20 11:27:12 sprite kernel: PDC20269: (U)DMA Burst Bit ENABLED Primary 
MASTER Mode Secondary MASTER Mode.
Mar 20 11:27:12 sprite kernel:     ide2: BM-DMA at 0x9800-0x9807, BIOS 
settings: hde:pio, hdf:pio
Mar 20 11:27:12 sprite kernel:     ide3: BM-DMA at 0x9808-0x980f, BIOS 
settings: hdg:pio, hdh:pio
Mar 20 11:27:12 sprite kernel: hda: SAMSUNG SV0844D, ATA DISK drive
Mar 20 11:27:12 sprite kernel: hdc: LTN382, ATAPI CD/DVD-ROM drive
Mar 20 11:27:12 sprite kernel: hdd: PHILIPS CDD6911, ATAPI CD/DVD-ROM drive
Mar 20 11:27:12 sprite kernel: hde: Maxtor 6Y080L0, ATA DISK drive
Mar 20 11:27:12 sprite kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Mar 20 11:27:12 sprite kernel: ide1 at 0x170-0x177,0x376 on irq 15
Mar 20 11:27:12 sprite kernel: ide2 at 0xb000-0xb007,0xa802 on irq 5
Mar 20 11:27:12 sprite kernel: blk: queue c0300284, I/O limit 4095Mb (mask 
0xffffffff)
Mar 20 11:27:12 sprite kernel: hda: setmax LBA 16514065, native  16514064
Mar 20 11:27:12 sprite kernel: hda: 16514064 sectors (8455 MB) w/480KiB Cache, 
CHS=1027/255/63, UDMA(33)
Mar 20 11:27:12 sprite kernel: blk: queue c030094c, I/O limit 4095Mb (mask 
0xffffffff)
Mar 20 11:27:12 sprite kernel: hde: 160086528 sectors (81964 MB) w/2048KiB 
Cache, CHS=158816/16/63, UDMA(33)


sprite:/home/fallucch# hdparm -vi /dev/hde

/dev/hde:
 multcount    = 16 (on)
 I/O support  =  0 (default 16-bit)
 unmaskirq    =  0 (off)
 using_dma    =  1 (on)
 keepsettings =  0 (off)
 nowerr       =  0 (off)
 readonly     =  0 (off)
 readahead    =  8 (on)
 geometry     = 158816/16/63, sectors = 160086528, start = 0

 Model=Maxtor 6Y080L0, FwRev=YAR41VW0, SerialNo=Y3H92SSE
 Config={ Fixed }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=57
 BuffType=DualPortCache, BuffSize=2048kB, MaxMultSect=16, MultSect=16
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=160086528
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes: pio0 pio1 pio2 pio3 pio4
 DMA modes: mdma0 mdma1 mdma2 udma0 udma1 *udma2 udma3 udma4 udma5 udma6
 AdvancedPM=yes: disabled (255) WriteCache=enabled
 Drive Supports : ataATA-1 ATA-2 ATA-3 ATA-4 ATA-5 ATA-6 ATA-7

 busstate     =  1 (on)

what is the problema?

Escuse me for my Englesh..

tanks, bye

-- 
 ---------------------------------------------------------------
| |||||||    ||    |  Fallucchi Antonio Giuseppe  mat. 2282     |
| ||        ||||    |      --> Live free() of die() <--         |
| ||||     ||  ||    |        OpenSource philisophy             |
| ||      ||||||||    |  Universita' di Bologna sede di Cesena  |
| ||     ||      ||    |    Cdl di Scienze dell'Informazione    |
 ---------------------------------------------------------------

-----BEGIN GEEK CODE BLOCK-----
Version: 3.1
GCM/S d? s: a- C++>+++$ UL++ P>++ L++ E-- W+++ 
N- o? K- w--(---) O-- M- V? PS PE PGP-(+) t 5? 
X- !R- tx+ b- DI-- D+ G>++ e+>++ h-(--) r+ y+
------END GEEK CODE BLOCK------

