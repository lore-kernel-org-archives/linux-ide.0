From: Willy Gardiol <gardiol@libero.it>
Subject: Re: Promise PDC20269 - PIO Only?
Date: Sun, 19 Oct 2003 11:39:17 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200310191139.21718.gardiol@libero.it>
References: <200310181819.08930.jeremyhu@uclink4.berkeley.edu> <200310190908.54762.gardiol@libero.it> <200310190311.40229.jeremyhu@uclink4.berkeley.edu>
Reply-To: gardiol@libero.it
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from eta.fastwebnet.it ([213.140.2.50]:44462 "EHLO eta.fastwebnet.it")
	by vger.kernel.org with ESMTP id S261476AbTJSKjX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 19 Oct 2003 06:39:23 -0400
In-Reply-To: <200310190311.40229.jeremyhu@uclink4.berkeley.edu>
Content-Description: clearsigned data
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: Jeremy Huddleston <jeremyhu@uclink4.berkeley.edu>, linux-ide@vger.kernel.org
Cc: Mark Hahn <hahn@physics.mcmaster.ca>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


Ok, you should also set explicitly the dma mode:
hdparm -d1 -X69
(69=3Dudma100...)

Alle Sunday 19 October 2003 12:11, Jeremy Huddleston ha scritto:
> I have done this, and the result is that it still doesn't use the dri=
ve to
> its full potential:
>
> (03:07:19 Sun Oct 19 2003 root@eradicator)
> ~ $ hdparm -d1 /dev/hde
>
> /dev/hde:
>  setting using_dma to 1 (on)
>  using_dma    =3D  1 (on)
>
> (03:07:25 Sun Oct 19 2003 root@eradicator)
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
> The PDC-Specific drivers are all compiled into the kernel
>
> On Sunday October 19 2003 00:08, Willy Gardiol wrote:
> > Have you tried to enable uDMA using hdpard after boot?
> > hdparm -d1 /dev/hdX
> >
> > There are also some options in kernel configurations which addresse=
s when
> > you have more than one promise comtrollers, have you tried them?
> > Last, also in the ide section of kernel config you can find an opti=
on
> > which should enable by default UDMA, have you enabled it?
> >
> > bye!
> >
> > Alle Sunday 19 October 2003 03:19, Jeremy Huddleston ha scritto:
> > > Hi,
> > >
> > > I've been using two Promise PDC20269 cards for almost a year now =
in my
> > > system. The cards are U133, but when the kernel boots up, I see t=
he
> > > message that all the drives are operating in pio mode.  All the d=
rives
> > > are U133 drives, and they are shown as operating in DMA mode when=
 I put
> > > them on another controller.
> > >
> > > I've noticed this deficiency with vanilla linux-2.4.19 through
> > > linux-2.4.21, linux-2.4.22-ac4 as well as 2.6.0-test6-mm4...
> > >
> > > Is there a patch to the 2.4 kernels availible to enable this supp=
ort?=20
> > > Is this problem being addressed?  Is there any way I can help out=
?
> > >
> > > Thanks,
> > > Jeremy
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

   "L'altrove =E8 uno specchio in negativo.=20
    Il viaggiatore riconosce il poco che =E8 suo,=20
    scoprendo il molto che non ha avuto e non avr=E0"

      Italo Calvino - Le citt=E0 invisibili

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE/klvJQ9qolN/zUk4RAgE8AKCMBgQg02ZONcteAKD97yr5l2h5XQCdELaz
bhUUEPuD6F3JW2LCBZ8oaJg=3D
=3DjJyT
-----END PGP SIGNATURE-----

