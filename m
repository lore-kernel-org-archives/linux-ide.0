From: Willy Gardiol <gardiol@libero.it>
Subject: Re: Promise PDC20269 - PIO Only?
Date: Sun, 19 Oct 2003 21:01:27 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200310192101.28170.gardiol@libero.it>
References: <200310181819.08930.jeremyhu@uclink4.berkeley.edu> <200310191139.21718.gardiol@libero.it> <200310191200.26656.jeremyhu@uclink4.berkeley.edu>
Reply-To: gardiol@libero.it
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from alfa.fastwebnet.it ([213.140.2.42]:13741 "EHLO
	alfa.fastwebnet.it") by vger.kernel.org with ESMTP id S262198AbTJSUB3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 19 Oct 2003 16:01:29 -0400
In-Reply-To: <200310191200.26656.jeremyhu@uclink4.berkeley.edu>
Content-Description: clearsigned data
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: Jeremy Huddleston <jeremyhu@uclink4.berkeley.edu>, linux-ide@vger.kernel.org
Cc: Mark Hahn <hahn@physics.mcmaster.ca>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


Well, in this case, i cant help more.
Lets hope some "guru" from this list will give an hint !



Alle Sunday 19 October 2003 21:00, Jeremy Huddleston ha scritto:
> It's still in mode2 after the explicit -X69 or -X70.  I have a 20267 =
on my
> other system, and it goes to mode5 with just the -d1...
>
> 11:53:45 Sun Oct 19 2003 root@eradicator)
> ~ $ hdparm -d1 -X69 /dev/hde
>
> /dev/hde:
>  setting using_dma to 1 (on)
>  setting xfermode to 69 (UltraDMA mode5)
>  using_dma    =3D  1 (on)
>
> (11:53:51 Sun Oct 19 2003 root@eradicator)
> ~ $ hdparm -i /dev/hde
>
> /dev/hde:
>
>  Model=3DMaxtor 6Y120P0, FwRev=3DYAR41VW0, SerialNo=3DY40BMM7E
>  Config=3D{ Fixed }
>  RawCHS=3D16383/16/63, TrkSize=3D0, SectSize=3D0, ECCbytes=3D57
>  BuffType=3DDualPortCache, BuffSize=3D7936kB, MaxMultSect=3D16, MultS=
ect=3Doff
>  CurCHS=3D16383/16/63, CurSects=3D16514064, LBA=3Dyes, LBAsects=3D240=
121728
>  IORDY=3Don/off, tPIO=3D{min:120,w/IORDY:120}, tDMA=3D{min:120,rec:12=
0}
>  PIO modes:  pio0 pio1 pio2 pio3 pio4
>  DMA modes:  mdma0 mdma1 mdma2
>  UDMA modes: udma0 udma1 *udma2 udma3 udma4 udma5 udma6
>  AdvancedPM=3Dyes: disabled (255) WriteCache=3Denabled
>  Drive conforms to: (null):
>
>  * signifies the current active mode
>
> (11:55:38 Sun Oct 19 2003 root@eradicator)
> ~ $ hdparm -d1 -X70 /dev/hde
>
> /dev/hde:
>  setting using_dma to 1 (on)
>  setting xfermode to 70 (UltraDMA mode6)
>  using_dma    =3D  1 (on)
>
> (11:55:44 Sun Oct 19 2003 root@eradicator)
> ~ $ hdparm -i /dev/hde
>
> /dev/hde:
>
>  Model=3DMaxtor 6Y120P0, FwRev=3DYAR41VW0, SerialNo=3DY40BMM7E
>  Config=3D{ Fixed }
>  RawCHS=3D16383/16/63, TrkSize=3D0, SectSize=3D0, ECCbytes=3D57
>  BuffType=3DDualPortCache, BuffSize=3D7936kB, MaxMultSect=3D16, MultS=
ect=3Doff
>  CurCHS=3D16383/16/63, CurSects=3D16514064, LBA=3Dyes, LBAsects=3D240=
121728
>  IORDY=3Don/off, tPIO=3D{min:120,w/IORDY:120}, tDMA=3D{min:120,rec:12=
0}
>  PIO modes:  pio0 pio1 pio2 pio3 pio4
>  DMA modes:  mdma0 mdma1 mdma2
>  UDMA modes: udma0 udma1 *udma2 udma3 udma4 udma5 udma6
>  AdvancedPM=3Dyes: disabled (255) WriteCache=3Denabled
>  Drive conforms to: (null):
>
>  * signifies the current active mode
>
> On Sunday October 19 2003 02:39, Willy Gardiol wrote:
> > Ok, you should also set explicitly the dma mode:
> > hdparm -d1 -X69
> > (69=3Dudma100...)
> >
> > Alle Sunday 19 October 2003 12:11, Jeremy Huddleston ha scritto:
> > > I have done this, and the result is that it still doesn't use the=
 drive
> > > to its full potential:
> > >
> > > (03:07:19 Sun Oct 19 2003 root@eradicator)
> > > ~ $ hdparm -d1 /dev/hde
> > >
> > > /dev/hde:
> > >  setting using_dma to 1 (on)
> > >  using_dma    =3D  1 (on)
> > >
> > > (03:07:25 Sun Oct 19 2003 root@eradicator)
> > > ~ $ hdparm -i /dev/hde
> > >
> > > /dev/hde:
> > >
> > >  Model=3DMaxtor 6Y120P0, FwRev=3DYAR41VW0, SerialNo=3DY40BMM7E
> > >  Config=3D{ Fixed }
> > >  RawCHS=3D16383/16/63, TrkSize=3D0, SectSize=3D0, ECCbytes=3D57
> > >  BuffType=3DDualPortCache, BuffSize=3D7936kB, MaxMultSect=3D16, M=
ultSect=3Doff
> > >  CurCHS=3D16383/16/63, CurSects=3D16514064, LBA=3Dyes, LBAsects=3D=
240121728
> > >  IORDY=3Don/off, tPIO=3D{min:120,w/IORDY:120}, tDMA=3D{min:120,re=
c:120}
> > >  PIO modes:  pio0 pio1 pio2 pio3 pio4
> > >  DMA modes:  mdma0 mdma1 mdma2
> > >  UDMA modes: udma0 udma1 *udma2 udma3 udma4 udma5 udma6
> > >  AdvancedPM=3Dyes: disabled (255) WriteCache=3Denabled
> > >  Drive conforms to: (null):
> > >
> > >  * signifies the current active mode
> > >
> > > The PDC-Specific drivers are all compiled into the kernel
> > >
> > > On Sunday October 19 2003 00:08, Willy Gardiol wrote:
> > > > Have you tried to enable uDMA using hdpard after boot?
> > > > hdparm -d1 /dev/hdX
> > > >
> > > > There are also some options in kernel configurations which addr=
esses
> > > > when you have more than one promise comtrollers, have you tried=
 them?
> > > > Last, also in the ide section of kernel config you can find an =
option
> > > > which should enable by default UDMA, have you enabled it?
> > > >
> > > > bye!
> > > >
> > > > Alle Sunday 19 October 2003 03:19, Jeremy Huddleston ha scritto=
:
> > > > > Hi,
> > > > >
> > > > > I've been using two Promise PDC20269 cards for almost a year =
now in
> > > > > my system. The cards are U133, but when the kernel boots up, =
I see
> > > > > the message that all the drives are operating in pio mode.  A=
ll the
> > > > > drives are U133 drives, and they are shown as operating in DM=
A mode
> > > > > when I put them on another controller.
> > > > >
> > > > > I've noticed this deficiency with vanilla linux-2.4.19 throug=
h
> > > > > linux-2.4.21, linux-2.4.22-ac4 as well as 2.6.0-test6-mm4...
> > > > >
> > > > > Is there a patch to the 2.4 kernels availible to enable this
> > > > > support? Is this problem being addressed?  Is there any way I=
 can
> > > > > help out?
> > > > >
> > > > > Thanks,
> > > > > Jeremy
> > > > > -
> > > > > To unsubscribe from this list: send the line "unsubscribe
> > > > > linux-ide" in the body of a message to majordomo@vger.kernel.=
org
> > > > > More majordomo info at  http://vger.kernel.org/majordomo-info=
=2Ehtml
> > >
> > > -
> > > To unsubscribe from this list: send the line "unsubscribe linux-i=
de" in
> > > the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.htm=
l
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-ide" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

- --=20

!=20
 Willy Gardiol - gardiol@libero.it
 gardiol.eu.org
 Use linux for your freedom.

   "La guerra non far=E0 mai finire=20
    alcuna guerra, nel migliore dei
    casi sar=E0 stata una guerra in pi=F9."

      Gino Strada, Buskash=EC

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE/kt+HQ9qolN/zUk4RArmiAJ9bidHaJnrj69o8+GPnxlG6kiIODgCeM7gq
Z3ZzkFeyFFRfbdNcTnyJjKQ=3D
=3Df62N
-----END PGP SIGNATURE-----

