From: Dan Hollis <goemon@anime.net>
Subject: kernel 2.6.6 amd8111 dma bugs
Date: Fri, 28 May 2004 15:36:58 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <Pine.LNX.4.44.0405281511020.1326-100000@sasami.anime.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from sasami.anime.net ([207.109.251.120]:43919 "EHLO
	sasami.anime.net") by vger.kernel.org with ESMTP id S264175AbUE1Wg7
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 28 May 2004 18:36:59 -0400
Received: from localhost (goemon@localhost)
	by sasami.anime.net (8.11.6/8.11.6) with ESMTP id i4SMawJ02183
	for <linux-ide@vger.kernel.org>; Fri, 28 May 2004 15:36:58 -0700
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

replies to email as i'm not subscribed to the list.

There seem to be regular dma timeouts:

hdc: dma_timer_expiry: dma status == 0x24
hdc: DMA interrupt recovery
hdc: lost interrupt
hda: dma_timer_expiry: dma status == 0x24
hda: DMA interrupt recovery
hda: lost interrupt

Hardware:

Opteron 140, Tyan Tomcat K8S (S2850)

Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
AMD8111: IDE controller at PCI slot 0000:00:07.1
AMD8111: chipset revision 3
AMD8111: not 100% native mode: will probe irqs later
AMD8111: 0000:00:07.1 (rev 03) UDMA133 controller
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:pio
hda: WDC WD1800JB-00DUA0, ATA DISK drive
Using anticipatory io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: Maxtor 4G160J8, ATA DISK drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 1024KiB
hda: 351651888 sectors (180045 MB) w/8192KiB Cache, CHS=21889/255/63, UDMA(100)
 hda: hda1 hda2 hda3
hdc: max request size: 1024KiB
hdc: 320173056 sectors (163928 MB) w/2048KiB Cache, CHS=19929/255/63, UDMA(133)
 hdc: hdc1

# cat /proc/interrupts 
           CPU0       
  0: 1116917689    IO-APIC-edge  timer
  1:          8    IO-APIC-edge  i8042
  8:          0    IO-APIC-edge  rtc
  9:          0   IO-APIC-level  acpi
 14:    1588110    IO-APIC-edge  ide0
 15:    2164522    IO-APIC-edge  ide1
 19:  109846070   IO-APIC-level  eth0
NMI:     741325 
LOC: 1116778300 
ERR:          0
MIS:          0

/dev/hda:

 Model=WDC WD1800JB-00DUA0, FwRev=70.13G70, SerialNo=WD-WMACK1600856
 Config={ HardSect NotMFM HdSw>15uSec SpinMotCtl Fixed DTR>5Mbs FmtGapReq }
 RawCHS=16383/16/63, TrkSize=57600, SectSize=600, ECCbytes=98
 BuffType=DualPortCache, BuffSize=8192kB, MaxMultSect=16, MultSect=16
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=268435455
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes:  pio0 pio1 pio2 pio3 pio4 
 DMA modes:  mdma0 mdma1 mdma2 
 UDMA modes: udma0 udma1 udma2 udma3 udma4 *udma5 
 AdvancedPM=no WriteCache=enabled
 Drive conforms to: device does not report version: 

/dev/hdc:

 Model=Maxtor 4G160J8, FwRev=GAK819K0, SerialNo=G80929SE
 Config={ Fixed }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=57
 BuffType=DualPortCache, BuffSize=2048kB, MaxMultSect=16, MultSect=16
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=268435455
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes:  pio0 pio1 pio2 pio3 pio4 
 DMA modes:  mdma0 mdma1 mdma2 
 UDMA modes: udma0 udma1 udma2 udma3 udma4 udma5 *udma6 
 AdvancedPM=yes: disabled (255) WriteCache=enabled
 Drive conforms to: ATA/ATAPI-6 T13 1410D revision 0: 

-Dan

