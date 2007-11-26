From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [RFC][PATCH 0/3] OF-platform PATA driver
Date: Mon, 26 Nov 2007 10:40:51 +0900
Message-ID: <20071126014051.GA23760@linux-sh.org>
References: <20071123175229.GA27143@localhost.localdomain> <4747751D.4060802@garzik.org> <20071124072613.GA7303@linux-sh.org> <20071126002314.GA20104@zarina>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pip9.gyao.ne.jp ([61.122.117.247]:14047 "EHLO mx.gate01.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754475AbXKZBlH (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 25 Nov 2007 20:41:07 -0500
Content-Disposition: inline
In-Reply-To: <20071126002314.GA20104@zarina>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Anton Vorontsov <cbou@mail.ru>
Cc: Jeff Garzik <jeff@garzik.org>, linuxppc-dev@ozlabs.org, linux-ide@vger.kernel.org

On Mon, Nov 26, 2007 at 03:23:14AM +0300, Anton Vorontsov wrote:
> On Sat, Nov 24, 2007 at 04:26:13PM +0900, Paul Mundt wrote:
> > On Fri, Nov 23, 2007 at 07:49:33PM -0500, Jeff Garzik wrote:
> > > Anton Vorontsov wrote:
> > > >Here is the PATA Platform driver using OF infrastructure.
> > > >
> > > >Mostly it's just a wrapper around a bit modified pata_platform
> > > >driver.
> > > >
> > > >Patches are well split for the easier review:
> > > >
> > > >First one factors out platform_device specific bits and modifies
> > > >pata_platform to be a library-alike driver (with platform_device
> > > >default binding).
> > > >
> > The only issue I have here is that this library-like version has subtle
> > semantic changes that will break existing drivers.
> 
> Actually I've tried to keep semantics intact:
> 
> +static int __devinit pata_platform_probe(struct platform_device *pdev)
> [...]
> +       /*
> +        * And the IRQ
> +        */
> +       irq_res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
> +       if (irq_res)
> +               irq_res->flags = pp_info ? pp_info->irq_flags : 0;
> [...]
> 
> So, I'm passing flags from the platform data. Did you overlook these
> bits, or I'm still changing semantics somewhere else?
> 
Oh, I overlooked that. Using irq_res->flags as a temporary for
pp_info->irq_flags seems a bit hacky, but as long as pp_info->irq_flags
semantics are intact, I'm not too violently opposed to this anyways.

> > Incidentally, we already have an include/linux/pata_platform.h. If this
> > is going to be library-like, through the prototypes in there, rather than
> > splitting them up betewen include/linux and drivers/ata. We don't need
> > two headers.
> 
> My intention was: keep "private" declarations in the drivers/ata/ and
> "public" in the include/linux/ -- to not confuse pata_platform users
> by __pata_platform_* internal stuff. But okay, I'll merge them.
> 
I suppose that depends on whether the intent is that all pata_platform
users will be stuck in drivers/ata or not. If this is treated as more of
a library, implementations can simply bury themselves in arch/ land if
they feel like it.
