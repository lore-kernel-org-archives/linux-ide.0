From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: Promise PDC20269 - PIO Only?
Date: Mon, 20 Oct 2003 19:49:39 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200310201949.39826.bzolnier@elka.pw.edu.pl>
References: <200310181819.08930.jeremyhu@uclink4.berkeley.edu> <200310192245.19122.bzolnier@elka.pw.edu.pl> <200310191603.40227.jeremyhu@uclink4.berkeley.edu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:25232 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S262750AbTJTRqz
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 20 Oct 2003 13:46:55 -0400
In-Reply-To: <200310191603.40227.jeremyhu@uclink4.berkeley.edu>
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: Jeremy Huddleston <jeremyhu@uclink4.berkeley.edu>
Cc: linux-ide@vger.kernel.org

On Monday 20 of October 2003 01:03, Jeremy Huddleston wrote:
> I have a lot of md output to the kernel logger when my system starts, so
> the IDE initialization output doesn't appear when I do my initial
> 'dmesg'... How do I increase the buffer size?  I tried doing 'dmesg -s
> <really high numbers>', but I still can't get the output...

/var/log/messages ?

> Anyhow, I was trying the -X70 option to force udma6 on my 2.4.20 kernel
> (which was with the old driver), but when I do the force on 2.4.22-ac4, it
> works now, so thanks.
>
> What is the reason that the drive starts in pio mode when it is attatched
> to the promise controller, but it starts in DMA mode when it is on the
> other controller?

Was the other controller on the same machine and with the same kernel?
If not check if you have CONFIG_IDEDMA_PCI_AUTO set to Y in your .config file.
Also please try to extract boot log...

thanks,
--bartlomiej

> Thanks again,
> Jeremy
>
> On Sunday October 19 2003 13:45, you wrote:
> > Here is a hint.  UDMA2 is a max if you don't use 80-wire cable.
> > If you can't force mode by "hdparm -X" driver might be misdetecting
> > cable type.   Please change "#define PDC202_DEBUG_CABLE 0"
> > to "#define PDC202_DEBUG_CABLE 1" in pdc202_new.c, recompile
> > and retest.  It should give some useful information.
> >
> > thanks,
> > --bartlomiej
> >
> > On Sunday 19 of October 2003 21:01, Willy Gardiol wrote:
> > > Well, in this case, i cant help more.
> > > Lets hope some "guru" from this list will give an hint !
> > >
> > > Alle Sunday 19 October 2003 21:00, Jeremy Huddleston ha scritto:
> > > > It's still in mode2 after the explicit -X69 or -X70.  I have a 20267
> > > > on my other system, and it goes to mode5 with just the -d1...
> > > >
> > > > 11:53:45 Sun Oct 19 2003 root@eradicator)
> > > > ~ $ hdparm -d1 -X69 /dev/hde
> > > >
> > > > /dev/hde:
> > > >  setting using_dma to 1 (on)
> > > >  setting xfermode to 69 (UltraDMA mode5)
> > > >  using_dma    =  1 (on)
> > > >
> > > > (11:53:51 Sun Oct 19 2003 root@eradicator)
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
> > > > (11:55:38 Sun Oct 19 2003 root@eradicator)
> > > > ~ $ hdparm -d1 -X70 /dev/hde
> > > >
> > > > /dev/hde:
> > > >  setting using_dma to 1 (on)
> > > >  setting xfermode to 70 (UltraDMA mode6)
> > > >  using_dma    =  1 (on)
> > > >
> > > > (11:55:44 Sun Oct 19 2003 root@eradicator)
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
> > > > On Sunday October 19 2003 02:39, Willy Gardiol wrote:
> > > > > Ok, you should also set explicitly the dma mode:
> > > > > hdparm -d1 -X69
> > > > > (69=udma100...)
> > > > >
> > > > > Alle Sunday 19 October 2003 12:11, Jeremy Huddleston ha scritto:
> > > > > > I have done this, and the result is that it still doesn't use the
> > > > > > drive to its full potential:
> > > > > >
> > > > > > (03:07:19 Sun Oct 19 2003 root@eradicator)
> > > > > > ~ $ hdparm -d1 /dev/hde
> > > > > >
> > > > > > /dev/hde:
> > > > > >  setting using_dma to 1 (on)
> > > > > >  using_dma    =  1 (on)
> > > > > >
> > > > > > (03:07:25 Sun Oct 19 2003 root@eradicator)
> > > > > > ~ $ hdparm -i /dev/hde
> > > > > >
> > > > > > /dev/hde:
> > > > > >
> > > > > >  Model=Maxtor 6Y120P0, FwRev=YAR41VW0, SerialNo=Y40BMM7E
> > > > > >  Config={ Fixed }
> > > > > >  RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=57
> > > > > >  BuffType=DualPortCache, BuffSize=7936kB, MaxMultSect=16,
> > > > > > MultSect=off CurCHS=16383/16/63, CurSects=16514064, LBA=yes,
> > > > > > LBAsects=240121728 IORDY=on/off, tPIO={min:120,w/IORDY:120},
> > > > > > tDMA={min:120,rec:120} PIO modes:  pio0 pio1 pio2 pio3 pio4
> > > > > >  DMA modes:  mdma0 mdma1 mdma2
> > > > > >  UDMA modes: udma0 udma1 *udma2 udma3 udma4 udma5 udma6
> > > > > >  AdvancedPM=yes: disabled (255) WriteCache=enabled
> > > > > >  Drive conforms to: (null):
> > > > > >
> > > > > >  * signifies the current active mode
> > > > > >
> > > > > > The PDC-Specific drivers are all compiled into the kernel
> > > > > >
> > > > > > On Sunday October 19 2003 00:08, Willy Gardiol wrote:
> > > > > > > Have you tried to enable uDMA using hdpard after boot?
> > > > > > > hdparm -d1 /dev/hdX
> > > > > > >
> > > > > > > There are also some options in kernel configurations which
> > > > > > > addresses when you have more than one promise comtrollers, have
> > > > > > > you tried them? Last, also in the ide section of kernel config
> > > > > > > you can find an option which should enable by default UDMA,
> > > > > > > have you enabled it?
> > > > > > >
> > > > > > > bye!
> > > > > > >
> > > > > > > Alle Sunday 19 October 2003 03:19, Jeremy Huddleston ha scritto:
> > > > > > > > Hi,
> > > > > > > >
> > > > > > > > I've been using two Promise PDC20269 cards for almost a year
> > > > > > > > now in my system. The cards are U133, but when the kernel
> > > > > > > > boots up, I see the message that all the drives are operating
> > > > > > > > in pio mode. All the drives are U133 drives, and they are
> > > > > > > > shown as operating in DMA mode when I put them on another
> > > > > > > > controller.
> > > > > > > >
> > > > > > > > I've noticed this deficiency with vanilla linux-2.4.19
> > > > > > > > through linux-2.4.21, linux-2.4.22-ac4 as well as
> > > > > > > > 2.6.0-test6-mm4...
> > > > > > > >
> > > > > > > > Is there a patch to the 2.4 kernels availible to enable this
> > > > > > > > support? Is this problem being addressed?  Is there any way I
> > > > > > > > can help out?
> > > > > > > >
> > > > > > > > Thanks,
> > > > > > > > Jeremy

