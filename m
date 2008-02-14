From: Mark Lord <liml@rtr.ca>
Subject: Re: ST31000340NS (1000G) Capacity equal 33MB issue.
Date: Thu, 14 Feb 2008 14:43:46 -0500
Message-ID: <47B499F2.1010306@rtr.ca>
References: <d0d565260802141013q61cb5e7fh7dcf04d7729213f7@mail.gmail.com> <d0d565260802141018y63a988bbpc6aecf771baacb84@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:3776 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755614AbYBNTns (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 14 Feb 2008 14:43:48 -0500
In-Reply-To: <d0d565260802141018y63a988bbpc6aecf771baacb84@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Richard Liu <richliu.tw@gmail.com>
Cc: linux-ide@vger.kernel.org

Richard Liu wrote:
> Hello all:
> 
>      I bought a Seagate ES.2 ST31000340NS (1000GB) and run at Gentoo
> Linux kernel 2.6.24.
> But Linux kernel report the disk size only 33MB.
> I tried Intel ICH5 and Sil3112, but get the same result.
> 
> I don't know this issue was caused by libsata or scsi layer .
..
> hdparm
>  ==
> hdparm -i /dev/sdc
> 
> /dev/sdc:
> 
>  Model=ST31000340NS                            , FwRev=SN04    ,
> SerialNo=            9QJ09BJ4
>  Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs RotSpdTol>.5% }
>   RawCHS=64/16/63, TrkSize=0, SectSize=0, ECCbytes=4
>  BuffType=unknown, BuffSize=0kB, MaxMultSect=16, MultSect=?16?
>  CurCHS=64/16/63, CurSects=64512, LBA=yes, LBAsects=65134
>  IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
>   PIO modes:  pio0 pio1 pio2 pio3 pio4
>  DMA modes:  mdma0 mdma1 mdma2
>  UDMA modes: udma0 udma1 udma2 udma3 udma4 *udma5
>  AdvancedPM=no WriteCache=enabled
>  Drive conforms to: ATA/ATAPI-6 T13 1410D revision 2:  ATA/ATAPI-4,5,6
> 
>  * signifies the current active mode
..

Nothing wrong there, but I would really like/prefer to see the output from:

    hdparm --Istdout /dev/sdc


thanks.
