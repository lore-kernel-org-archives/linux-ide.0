From: Balazs Ree <ree@ree.hu>
Subject: Samsung SP0822N does not go over UDMA 33 (2.6.11)
Date: Fri, 03 Jun 2005 15:18:44 +0200
Message-ID: <pan.2005.06.03.13.18.36.818342@ree.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:41646 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S261262AbVFCNrC (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 3 Jun 2005 09:47:02 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1DeCPl-0002eB-EF
	for linux-ide@vger.kernel.org; Fri, 03 Jun 2005 15:40:45 +0200
Received: from 3e44aa8f.adsl.enternet.hu ([62.68.170.143])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Fri, 03 Jun 2005 15:40:45 +0200
Received: from ree by 3e44aa8f.adsl.enternet.hu with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Fri, 03 Jun 2005 15:40:45 +0200
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


I have a new Samsung SP0822N. This is a 80G (P)ATA disk that is supposed
to support ATA133. It is connected to a SiI680 PCI controller. I am using
kernel 2.6.11.

But at bootup, the disk is identified as ATA33:

Jun  3 12:49:08 brumi kernel: SiI680: chipset revision 2
Jun  3 12:49:08 brumi kernel: SiI680: BASE CLOCK == 133
Jun  3 12:49:08 brumi kernel: SiI680: 100% native mode on irq 10
Jun  3 12:49:08 brumi kernel: ide2: MMIO-DMA , BIOS settings: hde:pio, hdf:pio
Jun  3 12:49:08 brumi kernel: ide3: MMIO-DMA , BIOS settings: hdg:pio, hdh:pio
Jun  3 12:49:08 brumi kernel: Probing IDE interface ide2...
Jun  3 12:49:08 brumi kernel: hde: SAMSUNG SP0822N, ATA DISK drive
Jun  3 12:49:08 brumi kernel: ide2 at 0xf8802080-0xf8802087,0xf880208a on irq 10
Jun  3 12:49:08 brumi kernel: hde: max request size: 64KiB
Jun  3 12:49:08 brumi kernel: hde: 156368016 sectors (80060 MB) w/2048KiB Cache, CHS=16383/255/63, UDMA(33)
Jun  3 12:49:08 brumi kernel: hde: cache flushes supported

Later, if I try to go beyond udma2 with hdparm, it pretends as if it
changed the setting, but the setting actually stays on udma2. With
hdparm -i I get the following output:

 Model=SAMSUNG SP0822N, FwRev=WA100-10, SerialNo=S06QJ10Y458485
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
 RawCHS=16383/16/63, TrkSize=31374, SectSize=498, ECCbytes=4
 BuffType=DualPortCache, BuffSize=2048kB, MaxMultSect=16, MultSect=16
 CurCHS=65535/1/63, CurSects=4128705, LBA=yes, LBAsects=156368016
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes:  pio0 pio1 pio2 pio3 pio4
 DMA modes:  mdma0 mdma1 mdma2
 UDMA modes: udma0 udma1 *udma2 udma3 udma4 udma5 udma6
 AdvancedPM=no WriteCache=enabled
 Drive conforms to: ATA/ATAPI-6 T13 1410D revision 1:

It seems as if the cable would be wrong. This can be, however, excluded: I
am using 80 pin cables and changed the cable as well, with no success. I
also tried to boot with ide2=ata66: this did not help either.

There is an older SAMSUMG (0802N) sitting on the other channel of the same
interface (same type of cable) and it goes fine with udma5. I got this
new disk as a replacement for a similar unit that fried itself. Now I am a
bit worried. I tried to look at the ide sources but I am lost
about why it figures out this timing restriction. Any clue would be
appreciated!

Thanks a lot,

-- 
Balazs REE


