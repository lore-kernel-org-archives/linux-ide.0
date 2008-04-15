From: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [2.6 patch] PCMCIA mustn't select HAVE_IDE
Date: Tue, 15 Apr 2008 22:26:16 +0100
Message-ID: <20080415212616.GD5676@flint.arm.linux.org.uk>
References: <20080414141659.GF6695@cs181133002.pp.htv.fi> <20080414175344.GA15028@uranus.ravnborg.org> <200804152215.34904.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:37008 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754692AbYDOV0t (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 15 Apr 2008 17:26:49 -0400
Content-Disposition: inline
In-Reply-To: <200804152215.34904.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Sam Ravnborg <sam@ravnborg.org>, Adrian Bunk <bunk@kernel.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pcmcia@lists.infradead.org

On Tue, Apr 15, 2008 at 10:15:34PM +0200, Bartlomiej Zolnierkiewicz wrote:
> On Monday 14 April 2008, Sam Ravnborg wrote:
> > On Mon, Apr 14, 2008 at 05:16:59PM +0300, Adrian Bunk wrote:
> > > It's plain wrong for PCMCIA to select HAVE_IDE that implies e.g. the 
> > > availability of an asm/ide.h
> > > 
> > > Signed-off-by: Adrian Bunk <bunk@kernel.org>
> > > 
> > > ---
> > > 9cdb66112488bc0c6e1d528444d3ba30d5b0487f diff --git a/drivers/pcmcia/Kconfig b/drivers/pcmcia/Kconfig
> > > index 8b22281..519b4ff 100644
> > > --- a/drivers/pcmcia/Kconfig
> > > +++ b/drivers/pcmcia/Kconfig
> > > @@ -38,7 +38,6 @@ config PCMCIA_DEBUG
> > >  config PCMCIA
> > >  	tristate "16-bit PCMCIA support"
> > >  	select CRC32
> > > -	select HAVE_IDE
> > >  	default y
> > 
> > I did this when introducing HAVE_IDE.
> > But I do not recall why and the rationale for removing it
> > seems fine to me.
> 
> IIRC it was needed for some arm platforms which don't select HAVE_IDE
> explicetely but I don't know if this is still the case, pinging Russell.

If that is so then it is so - the only way to find out is work out
why we ended up with HAVE_IDE and what it was transformed from.

To just ask me whether it's still the case, I've absolutely no idea -
there's no way in hell for me to be able to track these kinds of
dependencies.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
