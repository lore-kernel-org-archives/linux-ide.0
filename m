From: Jeremy Huddleston <jeremyhu@uclink4.berkeley.edu>
Subject: Re: Promise PDC20269 - PIO Only?
Date: Sun, 19 Oct 2003 03:11:29 -0700
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200310190311.40229.jeremyhu@uclink4.berkeley.edu>
References: <200310181819.08930.jeremyhu@uclink4.berkeley.edu> <200310190908.54762.gardiol@libero.it>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 12-233-44-179.client.attbi.com ([12.233.44.179]:16815 "EHLO
	terminator.outersquare.org") by vger.kernel.org with ESMTP
	id S261309AbTJSKH3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 19 Oct 2003 06:07:29 -0400
In-Reply-To: <200310190908.54762.gardiol@libero.it>
Content-Description: clearsigned data
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: gardiol@libero.it, linux-ide@vger.kernel.org
Cc: Mark Hahn <hahn@physics.mcmaster.ca>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I have done this, and the result is that it still doesn't use the drive to its 
full potential:

(03:07:19 Sun Oct 19 2003 root@eradicator)
~ $ hdparm -d1 /dev/hde

/dev/hde:
 setting using_dma to 1 (on)
 using_dma    =  1 (on)

(03:07:25 Sun Oct 19 2003 root@eradicator)
~ $ hdparm -i /dev/hde

/dev/hde:

 Model=Maxtor 6Y120P0, FwRev=YAR41VW0, SerialNo=Y40BMM7E
 Config={ Fixed }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=57
 BuffType=DualPortCache, BuffSize=7936kB, MaxMultSect=16, MultSect=off
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=240121728
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes:  pio0 pio1 pio2 pio3 pio4
 DMA modes:  mdma0 mdma1 mdma2
 UDMA modes: udma0 udma1 *udma2 udma3 udma4 udma5 udma6
 AdvancedPM=yes: disabled (255) WriteCache=enabled
 Drive conforms to: (null):

 * signifies the current active mode

The PDC-Specific drivers are all compiled into the kernel

On Sunday October 19 2003 00:08, Willy Gardiol wrote:
> Have you tried to enable uDMA using hdpard after boot?
> hdparm -d1 /dev/hdX
>
> There are also some options in kernel configurations which addresses when
> you have more than one promise comtrollers, have you tried them?
> Last, also in the ide section of kernel config you can find an option which
> should enable by default UDMA, have you enabled it?
>
> bye!
>
> Alle Sunday 19 October 2003 03:19, Jeremy Huddleston ha scritto:
> > Hi,
> >
> > I've been using two Promise PDC20269 cards for almost a year now in my
> > system. The cards are U133, but when the kernel boots up, I see the
> > message that all the drives are operating in pio mode.  All the drives
> > are U133 drives, and they are shown as operating in DMA mode when I put
> > them on another controller.
> >
> > I've noticed this deficiency with vanilla linux-2.4.19 through
> > linux-2.4.21, linux-2.4.22-ac4 as well as 2.6.0-test6-mm4...
> >
> > Is there a patch to the 2.4 kernels availible to enable this support?  Is
> > this problem being addressed?  Is there any way I can help out?
> >
> > Thanks,
> > Jeremy
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/kmNZgKpk8srJOlIRAlLgAKCDWijmkKXss4WSXcGDCfYGU41G0gCfW4x6
7ZEifZTYjX5OUqvoBB/+jxs=
=0J1q
-----END PGP SIGNATURE-----
