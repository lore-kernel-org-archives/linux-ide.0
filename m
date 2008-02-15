From: "Richard Liu" <richliu.tw@gmail.com>
Subject: Fwd: ST31000340NS (1000G) Capacity equal 33MB issue.
Date: Fri, 15 Feb 2008 14:14:01 +0800
Message-ID: <d0d565260802142214g6e508902sa856beaa7168c4af@mail.gmail.com>
References: <d0d565260802141013q61cb5e7fh7dcf04d7729213f7@mail.gmail.com>
	 <d0d565260802141018y63a988bbpc6aecf771baacb84@mail.gmail.com>
	 <47B499F2.1010306@rtr.ca>
	 <d0d565260802141931r2b6296c0l6c223b703e3407f5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.184]:45077 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757715AbYBOGOC (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 15 Feb 2008 01:14:02 -0500
Received: by rv-out-0910.google.com with SMTP id k20so415528rvb.1
        for <linux-ide@vger.kernel.org>; Thu, 14 Feb 2008 22:14:01 -0800 (PST)
In-Reply-To: <d0d565260802141931r2b6296c0l6c223b703e3407f5@mail.gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Dear Mark:

 2008/2/15, Mark Lord <liml@rtr.ca>:

> Richard Liu wrote:
 >  > Hello all:
 >  >
 >  >      I bought a Seagate ES.2 ST31000340NS (1000GB) and run at Gentoo
 >  > Linux kernel 2.6.24.
 >  > But Linux kernel report the disk size only 33MB.
 >  > I tried Intel ICH5 and Sil3112, but get the same result.
 >  >
 >  > I don't know this issue was caused by libsata or scsi layer .
 >
 > ..
 >
 > > hdparm
 >  >  ==
 >  > hdparm -i /dev/sdc
 >  >
 >  > /dev/sdc:
 >  >
 >  >  Model=ST31000340NS                            , FwRev=SN04    ,
 >  > SerialNo=            9QJ09BJ4
 >  >  Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs RotSpdTol>.5% }
 >  >   RawCHS=64/16/63, TrkSize=0, SectSize=0, ECCbytes=4
 >  >  BuffType=unknown, BuffSize=0kB, MaxMultSect=16, MultSect=?16?
 >  >  CurCHS=64/16/63, CurSects=64512, LBA=yes, LBAsects=65134
 >  >  IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 >  >   PIO modes:  pio0 pio1 pio2 pio3 pio4
 >  >  DMA modes:  mdma0 mdma1 mdma2
 >  >  UDMA modes: udma0 udma1 udma2 udma3 udma4 *udma5
 >  >  AdvancedPM=no WriteCache=enabled
 >  >  Drive conforms to: ATA/ATAPI-6 T13 1410D revision 2:  ATA/ATAPI-4,5,6
 >  >
 >  >  * signifies the current active mode
 >
 > ..
 >
 >  Nothing wrong there, but I would really like/prefer to see the output from:
 >
 >     hdparm --Istdout /dev/sdc
 >
 >
 >  thanks.
 >


 # hdparm --Istdout /dev/sdc

 /dev/sdc:
 0c5a 0040 c837 0010 0000 0000 003f 0000
 0000 0000 2020 2020 2020 2020 2020 2020
 3951 4a30 3942 4a34 0000 0000 0004 534e
 3034 2020 2020 5354 3331 3030 3033 3430
 4e53 2020 2020 2020 2020 2020 2020 2020
 2020 2020 2020 2020 2020 2020 2020 8010
 0000 2f00 4000 0200 0200 0007 0040 0010
 003f fc00 0000 0110 fe6e 0000 0000 0007
 0003 0078 0078 0078 0078 0000 0000 0000
 0000 0000 0000 001f 0502 0000 0040 0040
 0070 001b 346b 7d01 4123 3468 bc01 4103
 207f 0000 0000 fefe fffe 0000 fe00 0000
 0000 0000 0000 0000 fe6e 0000 0000 0000
 0000 0000 0000 0000 5000 c500 09b9 0136
 0000 0000 0000 0000 0000 0000 0000 4006
 4006 0000 0000 0000 0000 0000 0000 0000
 0021 6db0 7470 6db0 7470 0000 0002 0140
 0100 5000 3c06 3c0a 0000 003c 0000 0008
 0000 0000 000f 0280 0000 0000 000a 0000
 0000 0000 0000 0000 0000 0000 2700 8000
 0000 0000 0000 0000 0000 0000 0000 0000
 0000 0000 0000 0000 0000 0000 0000 0000
 0000 0000 0000 0000 0000 0000 0000 0000
 0000 0000 0000 0000 0000 0000 0000 0000
 0000 0000 0000 0000 0000 0000 0000 0000
 0000 0000 0000 0000 0000 0000 003d 0000
 0000 0000 0000 0000 0000 0000 0000 0000
 0000 1c20 0000 0000 0000 0000 0000 0000
 0000 0000 0000 0000 0000 0000 0000 0000
 0000 0000 0000 0000 0000 0000 0000 0000
 0000 0000 0000 0000 0000 0000 0000 0000
 0000 0000 0000 0000 0000 0000 0000 e9a5
