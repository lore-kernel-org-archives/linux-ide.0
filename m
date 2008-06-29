From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: ide_release_lock: bug
Date: Sun, 29 Jun 2008 12:10:02 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0806291201530.29339@anakin>
References: <20080623160539.GA8565@marenka.net>
 <alpine.DEB.1.00.0806240219260.30759@zirkon.biophys.uni-duesseldorf.de>
 <alpine.DEB.1.00.0806271036050.14458@zirkon.biophys.uni-duesseldorf.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from yorgi.telenet-ops.be ([195.130.133.69]:43340 "EHLO
	yorgi.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754348AbYF2KLV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 29 Jun 2008 06:11:21 -0400
Received: from wilson.telenet-ops.be (wilson.telenet-ops.be [195.130.132.42])
	by yorgi.telenet-ops.be (Postfix) with ESMTP id C60096818D3
	for <linux-ide@vger.kernel.org>; Sun, 29 Jun 2008 12:10:34 +0200 (CEST)
In-Reply-To: <alpine.DEB.1.00.0806271036050.14458@zirkon.biophys.uni-duesseldorf.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
Cc: Stephen R Marenka <stephen@marenka.net>, linux-m68k@vger.kernel.org, linux-ide@vger.kernel.org


[ Background for linux-ide: ide_release_lock() spits out lots of

    ide_release_lock: bug

  warnings on Atari Falcon ]

On Fri, 27 Jun 2008, Michael Schmitz wrote:
> The following patch does, indeed, fix the ide_release_lock imbalance. No more
> warnings.
> 
> --- drivers/ide/ide-io.c.orig	2008-06-27 20:11:42.000000000 +1200
> +++ drivers/ide/ide-io.c	2008-06-27 20:32:50.000000000 +1200
> @@ -1075,14 +1075,13 @@
>  	ide_startstop_t	startstop;
>  	int             loops = 0;
> 
> -	/* for atari only: POSSIBLY BROKEN HERE(?) */
> -	ide_get_lock(ide_intr, hwgroup);
> -
>  	/* caller must own ide_lock */
>  	BUG_ON(!irqs_disabled());
> 
>  	while (!hwgroup->busy) {
>  		hwgroup->busy = 1;
> +		/* for atari only */
> +		ide_get_lock(ide_intr, hwgroup);
>  		drive = choose_drive(hwgroup);
>  		if (drive == NULL) {
>  			int sleeping = 0;
> 
> Signed-off-by: <schmitz@biophys.uni-duesseldorf.de>

> > We release the lock just before hwgroup->busy is cleared, so it should be
> > logical to get hold of the lock just after hwgroup->busy was set, no?

If hwgroup->busy serves a similar purpose to falconide_intr_lock, what about
moving the setting/clearing of hwgroup->busy into ide_{get,release}_lock()
(and possibly renaming ide_{get,release}_lock() to e.g.
ide_hwgroup_{set,clear}_busy())?

What about the other places where hwgroup->busy is set/cleared?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
