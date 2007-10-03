From: Mikael Pettersson <mikpe@it.uu.se>
Subject: Re: Re[2]: Sata Sil3512 bug?
Date: Wed, 3 Oct 2007 09:26:33 +0200 (MEST)
Message-ID: <200710030726.l937QXuV026661@harpo.it.uu.se>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aun.it.uu.se ([130.238.12.36]:55232 "EHLO aun.it.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752007AbXJCH1G (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 3 Oct 2007 03:27:06 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: MisterE2002@zonnet.nl, htejun@gmail.com
Cc: alan@lxorguk.ukuu.org.uk, benh@kernel.crashing.org, jgarzik@pobox.com, linux-ide@vger.kernel.org

On Tue, 2 Oct 2007 21:20:23 +0200, MisterE wrote:
> I build another setup with almost the same hardware.
> This motherboard had already the latest bios.
> I notice that the computer does almost never find the hard drive
> although the controller is found every time (with lspci). So i get no
> drive (sda) assigned. I don't always see the "bios" screen from the
> controller at startup. And in the past it showed the hard drive.
> So i could not experiment with this motherboard.
> 
> After that i installed Windows XP and used the orginal (sweex)
> drivers with the first motherboard. This also makes the data corrupt.
> So it seems not to be an linux problem. So there is something wrong with
> the motherboard or the 3512 controller.
> 
> After that i plugged both hard drives (ide with windows and sata disk)
> to the Asus board. No data corruption. So the hard disks are'nt the
> problem either.
> 
> I'm thinking of replacing both 3512 controllers with a Promise SATA300
> TX4. Do you know if there are problems with this device?

(please don't top-post)

There are no known data-corruption issues with Promise SATA cards.
However, some of them, especially the 2nd generation SATA300 TX4,
are known to trigger intermittent error interrupts (that are dealt
with but may cause a speed reduction) in some systems. We're still
scratching our heads on that issue.

/Mikael

> Friday, September 28, 2007, 6:55:47 PM, you wrote:
> 
> > Alan Cox wrote:
> >>> sda1 are corrupted (2 to 4 blocks missing). Copying that data back to
> >>> Windows and it give the same results in Quickpar. So reading does not
> >>> have problems. The data written to hda1 is correct.
> >> 
> >> We've got a whole pile of reports like this with the 3512 and almost
> >> always Nvidia chipset, plus reports of BIOS updates fixing it. That you
> >> see something similar on intel boards is a bit worrying.
> 
> > Multiple sil3112/3512 + nvidia chipset problem doesn't usually involve
> > device errors or timeouts.  It usually corrupts data silently.  And,
> > yeah, data corruption on intel board is really disturbing.
> 
> > MisterE, do you have any processor powersaving mechanism enabled?  If
> > so, can you disable all and see whether that changes anything?
