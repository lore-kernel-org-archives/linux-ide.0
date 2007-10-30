From: Ben Court <ben.r.court@googlemail.com>
Subject: Slow hard drives
Date: Tue, 30 Oct 2007 22:44:54 +0000
Message-ID: <1193784294.5955.2.camel@jimin-desktop>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.175]:23507 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753400AbXJ3Wp2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 30 Oct 2007 18:45:28 -0400
Received: by ug-out-1314.google.com with SMTP id z38so214858ugc
        for <linux-ide@vger.kernel.org>; Tue, 30 Oct 2007 15:45:26 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

I've had this problem since edgy, the whole system seems to be really
slow and i think it's the hard drives causing it, everything slows down
even more when doing certain tasks (such as checking a torrent file or
amarok updating my music collection).
In system log whenever i boot up i get the following messages in
"kern.log" "messages" and "syslog"

Oct 30 20:45:26 jimin-desktop kernel: [ 55.312000] hda: dma_intr: bad
DMA status (dma_stat=76) 

Oct 30 20:45:26 jimin-desktop kernel: [ 55.312000] hda: dma_intr:
status=0x50 { DriveReady SeekComplete } 

Oct 30 20:45:26 jimin-desktop kernel: [ 55.312000] ide: failed opcode
was: unknown 

The same comes up for hdb (i have two hard drives installed) and those 3
messages repeat for a while and then this comes up

Oct 30 20:45:41 jimin-desktop kernel: [ 69.256000] hda: DMA disabled 

Oct 30 20:45:41 jimin-desktop kernel: [ 69.592000] ide0: reset: success 

Here is some information about my hard drives:


jimin@jimin-desktop:~$ hdparm -i /dev/hda
/dev/hda:

 Model=ST3160021A, FwRev=8.01, SerialNo=5MT25XGH
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs RotSpdTol>.5% }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=4
 BuffType=unknown, BuffSize=2048kB, MaxMultSect=16, MultSect=off
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=268435455
 IORDY=on/off, tPIO={min:240,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes:  pio0 pio1 pio2 pio3 pio4 
 DMA modes:  mdma0 mdma1 mdma2 
 UDMA modes: udma0 udma1 udma2 udma3 udma4 *udma5 
 AdvancedPM=no WriteCache=enabled
 Drive conforms to: ATA/ATAPI-6 T13 1410D revision 2:  ATA/ATAPI-1,2,3,4,5,6

 * signifies the current active mode

jimin@jimin-desktop:~$ sudo hdparm -Tt /dev/hda

/dev/hda:
 Timing cached reads:   1622 MB in  2.00 seconds = 811.74 MB/sec
 Timing buffered disk reads:    4 MB in  3.82 seconds =   1.05 MB/sec
Code:
jimin@jimin-desktop:~$ sudo hdparm -i /dev/hdb

/dev/hdb:

 Model=Maxtor 4D080H4, FwRev=DAH017K0, SerialNo=D41VKJ3E
 Config={ Fixed }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=57
 BuffType=DualPortCache, BuffSize=2048kB, MaxMultSect=16, MultSect=off
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=160086528
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes:  pio0 pio1 pio2 pio3 pio4 
 DMA modes:  mdma0 mdma1 mdma2 
 UDMA modes: udma0 udma1 udma2 udma3 udma4 *udma5 
 AdvancedPM=yes: disabled (255) WriteCache=enabled
 Drive conforms to: ATA/ATAPI-6 T13 1410D revision 0:  ATA/ATAPI-1,2,3,4,5,6

 * signifies the current active mode

jimin@jimin-desktop:~$ sudo hdparm -Tt /dev/hdb

/dev/hdb:
 Timing cached reads:   1592 MB in  2.00 seconds = 795.73 MB/sec
 Timing buffered disk reads:    4 MB in  3.76 seconds =   1.06 MB/sec

Does anyone know what could be causing this? If you need more information please let me know.
Also could i be CC'ed on this please. Thanks


