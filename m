From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: Promise PDC20269 - PIO Only?
Date: Sun, 19 Oct 2003 22:45:19 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200310192245.19122.bzolnier@elka.pw.edu.pl>
References: <200310181819.08930.jeremyhu@uclink4.berkeley.edu> <200310191200.26656.jeremyhu@uclink4.berkeley.edu> <200310192101.28170.gardiol@libero.it>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:35529 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S262223AbTJSUkx
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 19 Oct 2003 16:40:53 -0400
In-Reply-To: <200310192101.28170.gardiol@libero.it>
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: gardiol@libero.it
Cc: Jeremy Huddleston <jeremyhu@uclink4.berkeley.edu>, Mark Hahn <hahn@physics.mcmaster.ca>, linux-ide@vger.kernel.org


Here is a hint.  UDMA2 is a max if you don't use 80-wire cable.
If you can't force mode by "hdparm -X" driver might be misdetecting
cable type.   Please change "#define PDC202_DEBUG_CABLE 0"
to "#define PDC202_DEBUG_CABLE 1" in pdc202_new.c, recompile
and retest.  It should give some useful information.

thanks,
--bartlomiej

On Sunday 19 of October 2003 21:01, Willy Gardiol wrote:
> Well, in this case, i cant help more.
> Lets hope some "guru" from this list will give an hint !
>
> Alle Sunday 19 October 2003 21:00, Jeremy Huddleston ha scritto:
> > It's still in mode2 after the explicit -X69 or -X70.  I have a 20267 on
> > my other system, and it goes to mode5 with just the -d1...
> >
> > 11:53:45 Sun Oct 19 2003 root@eradicator)
> > ~ $ hdparm -d1 -X69 /dev/hde
> >
> > /dev/hde:
> >  setting using_dma to 1 (on)
> >  setting xfermode to 69 (UltraDMA mode5)
> >  using_dma    =  1 (on)
> >
> > (11:53:51 Sun Oct 19 2003 root@eradicator)
> > ~ $ hdparm -i /dev/hde
> >
> > /dev/hde:
> >
> >  Model=Maxtor 6Y120P0, FwRev=YAR41VW0, SerialNo=Y40BMM7E
> >  Config={ Fixed }
> >  RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=57
> >  BuffType=DualPortCache, BuffSize=7936kB, MaxMultSect=16, MultSect=off
> >  CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=240121728
> >  IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
> >  PIO modes:  pio0 pio1 pio2 pio3 pio4
> >  DMA modes:  mdma0 mdma1 mdma2
> >  UDMA modes: udma0 udma1 *udma2 udma3 udma4 udma5 udma6
> >  AdvancedPM=yes: disabled (255) WriteCache=enabled
> >  Drive conforms to: (null):
> >
> >  * signifies the current active mode
> >
> > (11:55:38 Sun Oct 19 2003 root@eradicator)
> > ~ $ hdparm -d1 -X70 /dev/hde
> >
> > /dev/hde:
> >  setting using_dma to 1 (on)
> >  setting xfermode to 70 (UltraDMA mode6)
> >  using_dma    =  1 (on)
> >
> > (11:55:44 Sun Oct 19 2003 root@eradicator)
> > ~ $ hdparm -i /dev/hde
> >
> > /dev/hde:
> >
> >  Model=Maxtor 6Y120P0, FwRev=YAR41VW0, SerialNo=Y40BMM7E
> >  Config={ Fixed }
> >  RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=57
> >  BuffType=DualPortCache, BuffSize=7936kB, MaxMultSect=16, MultSect=off
> >  CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=240121728
> >  IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
> >  PIO modes:  pio0 pio1 pio2 pio3 pio4
> >  DMA modes:  mdma0 mdma1 mdma2
> >  UDMA modes: udma0 udma1 *udma2 udma3 udma4 udma5 udma6
> >  AdvancedPM=yes: disabled (255) WriteCache=enabled
> >  Drive conforms to: (null):
> >
> >  * signifies the current active mode
> >
> > On Sunday October 19 2003 02:39, Willy Gardiol wrote:
> > > Ok, you should also set explicitly the dma mode:
> > > hdparm -d1 -X69
> > > (69=udma100...)
> > >
> > > Alle Sunday 19 October 2003 12:11, Jeremy Huddleston ha scritto:
> > > > I have done this, and the result is that it still doesn't use the
> > > > drive to its full potential:
> > > >
> > > > (03:07:19 Sun Oct 19 2003 root@eradicator)
> > > > ~ $ hdparm -d1 /dev/hde
> > > >
> > > > /dev/hde:
> > > >  setting using_dma to 1 (on)
> > > >  using_dma    =  1 (on)
> > > >
> > > > (03:07:25 Sun Oct 19 2003 root@eradicator)
> > > > ~ $ hdparm -i /dev/hde
> > > >
> > > > /dev/hde:
> > > >
> > > >  Model=Maxtor 6Y120P0, FwRev=YAR41VW0, SerialNo=Y40BMM7E
> > > >  Config={ Fixed }
> > > >  RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=57
> > > >  BuffType=DualPortCache, BuffSize=7936kB, MaxMultSect=16,
> > > > MultSect=off CurCHS=16383/16/63, CurSects=16514064, LBA=yes,
> > > > LBAsects=240121728 IORDY=on/off, tPIO={min:120,w/IORDY:120},
> > > > tDMA={min:120,rec:120} PIO modes:  pio0 pio1 pio2 pio3 pio4
> > > >  DMA modes:  mdma0 mdma1 mdma2
> > > >  UDMA modes: udma0 udma1 *udma2 udma3 udma4 udma5 udma6
> > > >  AdvancedPM=yes: disabled (255) WriteCache=enabled
> > > >  Drive conforms to: (null):
> > > >
> > > >  * signifies the current active mode
> > > >
> > > > The PDC-Specific drivers are all compiled into the kernel
> > > >
> > > > On Sunday October 19 2003 00:08, Willy Gardiol wrote:
> > > > > Have you tried to enable uDMA using hdpard after boot?
> > > > > hdparm -d1 /dev/hdX
> > > > >
> > > > > There are also some options in kernel configurations which
> > > > > addresses when you have more than one promise comtrollers, have you
> > > > > tried them? Last, also in the ide section of kernel config you can
> > > > > find an option which should enable by default UDMA, have you
> > > > > enabled it?
> > > > >
> > > > > bye!
> > > > >
> > > > > Alle Sunday 19 October 2003 03:19, Jeremy Huddleston ha scritto:
> > > > > > Hi,
> > > > > >
> > > > > > I've been using two Promise PDC20269 cards for almost a year now
> > > > > > in my system. The cards are U133, but when the kernel boots up, I
> > > > > > see the message that all the drives are operating in pio mode. 
> > > > > > All the drives are U133 drives, and they are shown as operating
> > > > > > in DMA mode when I put them on another controller.
> > > > > >
> > > > > > I've noticed this deficiency with vanilla linux-2.4.19 through
> > > > > > linux-2.4.21, linux-2.4.22-ac4 as well as 2.6.0-test6-mm4...
> > > > > >
> > > > > > Is there a patch to the 2.4 kernels availible to enable this
> > > > > > support? Is this problem being addressed?  Is there any way I can
> > > > > > help out?
> > > > > >
> > > > > > Thanks,
> > > > > > Jeremy
> > > > > > -
> > > > > > To unsubscribe from this list: send the line "unsubscribe
> > > > > > linux-ide" in the body of a message to majordomo@vger.kernel.org
> > > > > > More majordomo info at 
> > > > > > http://vger.kernel.org/majordomo-info.html
> > > >
> > > > -
> > > > To unsubscribe from this list: send the line "unsubscribe linux-ide"
> > > > in the body of a message to majordomo@vger.kernel.org
> > > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html

