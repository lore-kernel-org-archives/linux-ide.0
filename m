From: Willy Gardiol <gardiol@libero.it>
Subject: Re: Promise PDC20269 - PIO Only?
Date: Sun, 19 Oct 2003 09:08:50 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200310190908.54762.gardiol@libero.it>
References: <200310181819.08930.jeremyhu@uclink4.berkeley.edu>
Reply-To: gardiol@libero.it
Mime-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ms002msg.fastwebnet.it ([213.140.2.52]:36768 "EHLO
	ms002msg.fastwebnet.it") by vger.kernel.org with ESMTP
	id S262069AbTJSII5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 19 Oct 2003 04:08:57 -0400
In-Reply-To: <200310181819.08930.jeremyhu@uclink4.berkeley.edu>
Content-Description: clearsigned data
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: Jeremy Huddleston <jeremyhu@uclink4.berkeley.edu>, linux-ide@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


Have you tried to enable uDMA using hdpard after boot?
hdparm -d1 /dev/hdX

There are also some options in kernel configurations which addresses when you 
have more than one promise comtrollers, have you tried them?
Last, also in the ide section of kernel config you can find an option which 
should enable by default UDMA, have you enabled it?

bye!



Alle Sunday 19 October 2003 03:19, Jeremy Huddleston ha scritto:
> Hi,
>
> I've been using two Promise PDC20269 cards for almost a year now in my
> system. The cards are U133, but when the kernel boots up, I see the message
> that all the drives are operating in pio mode.  All the drives are U133
> drives, and they are shown as operating in DMA mode when I put them on
> another controller.
>
> I've noticed this deficiency with vanilla linux-2.4.19 through
> linux-2.4.21, linux-2.4.22-ac4 as well as 2.6.0-test6-mm4...
>
> Is there a patch to the 2.4 kernels availible to enable this support?  Is
> this problem being addressed?  Is there any way I can help out?
>
> Thanks,
> Jeremy
> -
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

- -- 

! 
 Willy Gardiol - gardiol@libero.it
 gardiol.eu.org
 Use linux for your freedom.

   "Tutti hanno dei pregiudizi, solo 
    che i nostri sono giusti."

      Stefano Bagnasco  (2002)

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE/kjiGQ9qolN/zUk4RAjHQAJ4pVt4LbM05DrgZA5xTmh9oeiRdRwCcCQ0D
0u8gzcHyx0wjLbA1jW/Zov0=
=sGn9
-----END PGP SIGNATURE-----

