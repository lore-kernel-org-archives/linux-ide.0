From: Adrian Bunk <bunk@kernel.org>
Subject: Re: [2.6 patch] PCMCIA mustn't select HAVE_IDE
Date: Wed, 16 Apr 2008 00:23:26 +0300
Message-ID: <20080415212326.GF1677@cs181133002.pp.htv.fi>
References: <20080414141659.GF6695@cs181133002.pp.htv.fi> <20080414175344.GA15028@uranus.ravnborg.org> <200804152215.34904.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932903AbYDOVYy@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <200804152215.34904.bzolnier@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Sam Ravnborg <sam@ravnborg.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pcmcia@lists.infradead.org, Russell King <rmk@arm.linux.org.uk>
List-Id: linux-ide@vger.kernel.org

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

It's definitely bogus since it can cause compile breakage on 
architectures like avr32.

And whatever it should have fixed should be fixed properly.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed
