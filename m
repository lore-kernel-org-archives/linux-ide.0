From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [2.6 patch] PCMCIA mustn't select HAVE_IDE
Date: Tue, 15 Apr 2008 22:15:34 +0200
Message-ID: <200804152215.34904.bzolnier@gmail.com>
References: <20080414141659.GF6695@cs181133002.pp.htv.fi> <20080414175344.GA15028@uranus.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.156]:30875 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932739AbYDOVTp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 15 Apr 2008 17:19:45 -0400
Received: by fg-out-1718.google.com with SMTP id l27so2140210fgb.17
        for <linux-ide@vger.kernel.org>; Tue, 15 Apr 2008 14:19:44 -0700 (PDT)
In-Reply-To: <20080414175344.GA15028@uranus.ravnborg.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Adrian Bunk <bunk@kernel.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pcmcia@lists.infradead.org, Russell King <rmk@arm.linux.org.uk>

On Monday 14 April 2008, Sam Ravnborg wrote:
> On Mon, Apr 14, 2008 at 05:16:59PM +0300, Adrian Bunk wrote:
> > It's plain wrong for PCMCIA to select HAVE_IDE that implies e.g. the 
> > availability of an asm/ide.h
> > 
> > Signed-off-by: Adrian Bunk <bunk@kernel.org>
> > 
> > ---
> > 9cdb66112488bc0c6e1d528444d3ba30d5b0487f diff --git a/drivers/pcmcia/Kconfig b/drivers/pcmcia/Kconfig
> > index 8b22281..519b4ff 100644
> > --- a/drivers/pcmcia/Kconfig
> > +++ b/drivers/pcmcia/Kconfig
> > @@ -38,7 +38,6 @@ config PCMCIA_DEBUG
> >  config PCMCIA
> >  	tristate "16-bit PCMCIA support"
> >  	select CRC32
> > -	select HAVE_IDE
> >  	default y
> 
> I did this when introducing HAVE_IDE.
> But I do not recall why and the rationale for removing it
> seems fine to me.

IIRC it was needed for some arm platforms which don't select HAVE_IDE
explicetely but I don't know if this is still the case, pinging Russell.

> So patch looks good - but I have not investigated in detail.
> 
> 	Sam
