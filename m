From: "Andrew Herdman" <andrew@whine.com>
Subject: Re: Promise IDE controller crashes 2.4.22
Date: Sat, 29 Nov 2003 00:57:48 -0500
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <004101c3b63d$b7fe1c10$1080a8c0@littlewxp>
References: <slrnbsche8.2ir.jgoerzen@christoph.complete.org> <20031128022439.GA8333@complete.org> <3FC6BF5A.6050204@stesmi.com> <200311281400.55500.bzolnier@elka.pw.edu.pl> <20031129015230.GA3124@complete.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from why.whine.com ([192.197.159.1]:3772 "EHLO why.whine.com")
	by vger.kernel.org with ESMTP id S263650AbTK2F5t (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 29 Nov 2003 00:57:49 -0500
List-Id: linux-ide@vger.kernel.org
To: John Goerzen <jgoerzen@complete.org>, Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Stefan Smietanowski <stesmi@stesmi.com>, linux-ide@vger.kernel.org

to determine the UDMA mode the drive is currently operating in perform a
hdparm -i /dev/hde

an example from my system, Promise TX133 Card

hdparm -i /dev/hde

/dev/hde:

 Model=WDC WD800JB-00DUA3, FwRev=75.13B75, SerialNo=WD-WMACM1696962
 Config={ HardSect NotMFM HdSw>15uSec SpinMotCtl Fixed DTR>5Mbs FmtGapReq }
 RawCHS=16383/16/63, TrkSize=57600, SectSize=600, ECCbytes=74
 BuffType=DualPortCache, BuffSize=8192kB, MaxMultSect=16, MultSect=16
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=156301488
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes:  pio0 pio1 pio2 pio3 pio4
 DMA modes:  mdma0 mdma1 mdma2
 UDMA modes: udma0 udma1 udma2 udma3 *udma4
 AdvancedPM=no WriteCache=enabled
 Drive conforms to: device does not report version:

 * signifies the current active mode

As you can see, my drive is currently operating using udam4 (i turned off
udma5 on the drives themselves because of dma errors, bad cabling).

Andrew

----- Original Message ----- 
From: "John Goerzen" <jgoerzen@complete.org>
To: "Bartlomiej Zolnierkiewicz" <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: "Stefan Smietanowski" <stesmi@stesmi.com>; <linux-ide@vger.kernel.org>
Sent: Friday, November 28, 2003 8:52 PM
Subject: Re: Promise IDE controller crashes 2.4.22


> On Fri, Nov 28, 2003 at 02:00:55PM +0100, Bartlomiej Zolnierkiewicz wrote:
> >
> > My mistake, it should have been -Xudma5 :-).
>
> I tried the ide2=dma in the kernel and then:
>
> hdparm -d 1 -u 1 -X 69 /dev/hde
>
> That did seem to solve the problem.  Output of hdparm after that
> command:
>
> pi:~# hdparm /dev/hde
>
> /dev/hde:
>  multcount    = 16 (on)
>  IO_support   =  0 (default 16-bit)
>  unmaskirq    =  0 (off)
>  using_dma    =  1 (on)
>  keepsettings =  0 (off)
>  readonly     =  0 (off)
>  readahead    =  8 (on)
>  geometry     = 19929/255/63, sectors = 320173056, start = 0
>
> What does that mean?
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

