From: Michael Tokarev <mjt@tls.msk.ru>
Subject: Re: pata_via refuses to detect one drive
Date: Wed, 17 Oct 2007 22:26:12 +0400
Message-ID: <471653C4.9090709@msgid.tls.msk.ru>
References: <47161F09.3040003@msgid.tls.msk.ru> <20071017165007.77471e8d@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hobbit.corpit.ru ([81.13.94.6]:23205 "EHLO hobbit.corpit.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758960AbXJQS0P (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 17 Oct 2007 14:26:15 -0400
In-Reply-To: <20071017165007.77471e8d@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org

Alan Cox wrote:
>> Oct 17 18:30:59 linux kernel: ata2: port is slow to respond, please be patient (Status 0x80)
>> Oct 17 18:30:59 linux kernel: ata2: SRST failed (errno=-16)
> 
> So it failed to reset and come back to sanity.
> 
>> Oct 17 18:30:59 linux kernel: ata2.01: ATAPI: FX4830T, R02E, max UDMA/33
>> Oct 17 18:30:59 linux kernel: ata2.01: configured for UDMA/33
>> Oct 17 18:30:59 linux kernel: scsi 0:0:0:0: Direct-Access     ATA      Hitachi HDS72168 P21O PQ: 0 ANSI: 5
>> Oct 17 18:30:59 linux kernel: ata2.01: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2
>> Oct 17 18:30:59 linux kernel: ata2.01: cmd a0/00:00:00:00:20/00:00:00:00:00/b0 tag 0 cdb 0x12 data 36 in
>> Oct 17 18:30:59 linux kernel:          res 00/00:00:00:00:00/00:00:00:00:00/00 Emask 0x2 (HSM violation)
> 
> This looks like both drives end up trying to be the slave ? Its certainly
> very vey confused at this point. Interesting it works with the BIOS doing
> the reset, wonder what the difference is.

Not only it works with BIOS, it also works with via82cxxx just fine.

hdc: Hitachi HDS721680PLAT80, ATA DISK drive
hdc: max request size: 512KiB
hdc: 160836480 sectors (82348 MB) w/7384KiB Cache, CHS=16383/255/63, UDMA(33)
hdc: cache flushes supported
 hdc: hdc1 hdc2 hdc3 hdc4 < hdc5 hdc6 hdc7 >

hdd: FX4830T, ATAPI CD/DVD-ROM drive
hdd: ATAPI 48X CD-ROM drive, 128kB Cache, UDMA(33)

# hdparm -i /dev/hdc

/dev/hdc:

 Model=Hitachi HDS721680PLAT80, FwRev=P21OA60A, SerialNo=PV2100Z106Z9EF
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=51
 BuffType=DualPortCache, BuffSize=7384kB, MaxMultSect=16, MultSect=16
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=160836480
 IORDY=on/off, tPIO={min:240,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes:  pio0 pio1 pio2 pio3 pio4
 DMA modes:  mdma0 mdma1 mdma2
 UDMA modes: udma0 udma1 *udma2 udma3 udma4 udma5 udma3 udma4 udma5 udma6
 AdvancedPM=yes: disabled (255) WriteCache=enabled
 Drive conforms to: ATA/ATAPI-7 T13 1532D revision 1:  ATA/ATAPI-2 ATA/ATAPI-3 ATA/ATAPI-4 ATA/ATAPI-5 ATA/ATAPI-6 ATA/ATAPI-7

# hdparm -i /dev/hdd

/dev/hdd:

 Model=FX4830T, FwRev=R02E, SerialNo=
 Config={ Fixed Removeable DTR<=5Mbs DTR>10Mbs nonMagnetic }
 RawCHS=0/0/0, TrkSize=0, SectSize=0, ECCbytes=0
 BuffType=unknown, BuffSize=128kB, MaxMultSect=0
 (maybe): CurCHS=0/0/0, CurSects=0, LBA=yes, LBAsects=0
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes:  pio0 pio1 pio2 pio3 pio4
 DMA modes:  sdma0 sdma1 sdma2 mdma0 mdma1 mdma2
 UDMA modes: udma0 udma1 *udma2
 AdvancedPM=no

(both drives are on "plain" IDE cable, second IDE channel).

> How are the drives jumpered and does it work with just one of the two
> present ?

That's an interesting question.  The machine is remote, and there's
no one on site who's able to check it.  I'll try to get reach of it,
hopefully it will be soon enough.  In any case, it looks like the
jumpers are OK, or else it shouldnt work with IDE module as well.

/mjt
