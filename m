From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [RFC][PATCH] at91_ide driver
Date: Sun, 18 Jan 2009 18:29:19 +0300
Message-ID: <49734ACF.1080508@ru.mvista.com>
References: <200901141345.42583.stf_xl@wp.pl>	<20090114131727.5b0e5193@lxorguk.ukuu.org.uk>	<49708C55.1020204@ru.mvista.com>	<200901161603.03699.stf_xl@wp.pl>	<4970A8FF.4080404@ru.mvista.com> <20090116161342.4229667f@lxorguk.ukuu.org.uk> <49723AB5.7000809@ru.mvista.com> <49730B63.4080500@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:23601 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1765627AbZARP2t (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 18 Jan 2009 10:28:49 -0500
In-Reply-To: <49730B63.4080500@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Stanislaw Gruszka <stf_xl@wp.pl>, Andrew Victor <linux@maxim.org.za>, Nicolas Ferre <nicolas.ferre@atmel.com>, Haavard Skinnemoen <haavard.skinnemoen@atmel.com>, linux-ide@vger.kernel.org, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, ddaney@caviumnetworks.com

Hello, I wrote:

>>>> the PIO transfer speeds (very significantly) though I'm not sure of 
>>>> the current state of affairs...

>>> 16bit only performance is identical (as you'd expect)

>>   Well, I don't know what to expect, having seen figures like 0.5 (or 
>> 1.5) MB/s cited on this list...

>   Instead of going to bed, I tried booting FC8 (2.6.23.y) off DVD in 
> rescue mode and suppressing libata's DMA use: hdparm -t topped at around 
> 1 MB/s from both SATA hard drive and PATA DVD drive with sata_sil driven 
> the former and pata_atiixp the latter... I wasn't able to compare 
> results with IDE core of course.

>>> identical with the 32bit pio patches applied

>> 32bit is now

>>   Hm, I didn't realize 32-bit I/O really can really boost the IDE 
>> speed. I vaguely remember (or misremember) benchmarking drives under 
>> DOS (many years ago) with and without 32-bit access enabled in the 
>> BIOS Setup and not seeing any significant differences. Perhpas it's 
>> worth to re-benchmark this in Linux if I find the time...

>   With hdparm being able to control that via its -c option when using 
> IDE driver, it shouldn't take much time...

    Here's the results I got on my work PC having 2 hard disks on 82801DB, 
still running the ancient RH9 (which included hdparm 5.5):

[root@wasted etc]# /sbin/hdparm -i /dev/hda

/dev/hda:

  Model=ST380011A, FwRev=3.06, SerialNo=5JV4FZNT
  Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs RotSpdTol>.5% }
  RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=4
  BuffType=unknown, BuffSize=2048kB, MaxMultSect=16, MultSect=16
  CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=156301488
  IORDY=on/off, tPIO={min:240,w/IORDY:120}, tDMA={min:120,rec:120}
  PIO modes:  pio0 pio1 pio2 pio3 pio4
  DMA modes:  mdma0 mdma1 mdma2
  UDMA modes: udma0 udma1 udma2 udma3 udma4 *udma5
  AdvancedPM=no WriteCache=enabled
  Drive conforms to: ATA/ATAPI-6 T13 1410D revision 2:  1 2 3 4 5 6

[root@wasted etc]# /sbin/hdparm -c /dev/hda

/dev/hda:
  IO_support   =  0 (default 16-bit)

[root@wasted etc]# /sbin/hdparm -d0 -p4 /dev/hda

/dev/hda:
  setting using_dma to 0 (off)
  using_dma    =  0 (off)

/dev/hda:
  attempting to set PIO mode to 4

[root@wasted etc]# /sbin/hdparm -t /dev/hda

/dev/hda:
  Timing buffered disk reads:  64 MB in 22.65 seconds =  2.83 MB/sec

[root@wasted etc]# /sbin/hdparm -c1 /dev/hda

/dev/hda:
  setting 32-bit IO_support flag to 1
  IO_support   =  1 (default 32-bit)

[root@wasted etc]# /sbin/hdparm -t /dev/hda

  Timing buffered disk reads:  64 MB in 18.19 seconds =  3.52 MB/sec

[root@wasted etc]# /sbin/hdparm -i /dev/hdb

/dev/hdb:

  Model=Maxtor 2F030J0, FwRev=VAM51JJ0, SerialNo=F11HZPNE
  Config={ Fixed }
  RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=57
  BuffType=DualPortCache, BuffSize=2048kB, MaxMultSect=16, MultSect=16
  CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=60056543
  IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
  PIO modes:  pio0 pio1 pio2 pio3 pio4
  DMA modes:  mdma0 mdma1 mdma2
  UDMA modes: udma0 udma1 udma2 udma3 udma4 *udma5 udma6
  AdvancedPM=yes: disabled (255) WriteCache=enabled
  Drive conforms to: (null):  1 2 3 4 5 6 7

[root@wasted etc]# /sbin/hdparm -c /dev/hdb

/dev/hdb:
  IO_support   =  0 (default 16-bit)

[root@wasted etc]# /sbin/hdparm -d0 -p4 /dev/hdb

/dev/hdb:
  setting using_dma to 0 (off)
  using_dma    =  0 (off)

/dev/hdb:
  attempting to set PIO mode to 4

[root@wasted etc]# /sbin/hdparm -t /dev/hdb

/dev/hdb:
  Timing buffered disk reads:  64 MB in 20.80 seconds =  3.08 MB/sec

[root@wasted etc]# /sbin/hdparm -c1 /dev/hdb

/dev/hdb:
  setting 32-bit IO_support flag to 1
  IO_support   =  1 (default 32-bit)

[root@wasted etc]# /sbin/hdparm -t /dev/hdb

  Timing buffered disk reads:  64 MB in 12.69 seconds =  5.04 MB/sec

    As you can see, although the speed increase can certainly be seen, it's 
not really that big for the (cheapo :-) Seagate drive while Maxtor 
demonstrated 1.6x increase. I need to try somewhat newer kernel though (don't 
want to reboot to CentOS)...

MBR, Sergei
