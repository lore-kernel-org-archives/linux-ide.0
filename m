From: Ben Dooks <ben-linux@fluff.org>
Subject: Re: [PATCH] pata_of_platform: fix no irq handling
Date: Mon, 11 Aug 2008 17:36:48 +0100
Message-ID: <20080811163648.GI26082@trinity.fluff.org>
References: <48A05152.7020508@harris.com> <20080811151913.GA14690@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from trinity.fluff.org ([89.145.97.151]:44812 "EHLO
	trinity.fluff.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750989AbYHKQhW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 11 Aug 2008 12:37:22 -0400
Content-Disposition: inline
In-Reply-To: <20080811151913.GA14690@oksana.dev.rtsoft.ru>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, "Steven A. Falco" <sfalco@harris.com>, linuxppc-dev@ozlabs.org, linux-ide@vger.kernel.org


On Mon, Aug 11, 2008 at 07:19:13PM +0400, Anton Vorontsov wrote:
> When no irq specified, pata_of_platform fills irq_res with -1,
> which is wrong to do for two reasons:
> 
> 1. By definition, 'no irq' should be IRQ 0, not some negative integer;

interesting, IRQ 0 is actually valid on some ARM systems.

> 2. pata_platform checks for irq_res.start > 0, but since irq_res.start
>    is unsigned type, the check will be true for `-1'.
> 
> Reported-by: Steven A. Falco <sfalco@harris.com>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
> 
> On Mon, Aug 11, 2008 at 10:48:50AM -0400, Steven A. Falco wrote:
> > I think there is a bug in the communications between pata_of_platform
> > and pata_platform.  I will refer to the master branch of the DENX git
> > tree, which is roughly v2.6.26.1 at this time.  I am using a Sequoia
> > board with a PPC440EPx.
> > 
> > In pata_of_platform, we have:
> > 
> >     ret = of_irq_to_resource(dn, 0, &irq_res);
> >     if (ret == NO_IRQ)
> >         irq_res.start = irq_res.end = -1;
> > 
> > so if there is no interrupt defined, then start and end are -1. 
> > However, __pata_platform_probe has:
> > 
> >     if (irq_res && irq_res->start > 0) {
> >         irq = irq_res->start;
> >         irq_flags = irq_res->flags;
> >     }
> > 
> > You might think that the (irq_res->start > 0) test will fail, as it
> > should in this no-irq case.  But, start is a u64, so the -1 actually
> > looks like a large positive number in the comparison.  So,
> > __pata_platform_probe attempts to use an interrupt when there isn't one.
> > 
> > I think the fix would be to change __pata_platform_probe to:
> > 
> >     if (irq_res && irq_res->start != -1) {
> > 
> > but that might have other unintended consequences, so I'll defer to
> > whomever knows more about the intent of this code.
> 
> Something like this patch should work. Thanks for noticing!
> 
>  drivers/ata/pata_of_platform.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/ata/pata_of_platform.c b/drivers/ata/pata_of_platform.c
> index 408da30..1f18ad9 100644
> --- a/drivers/ata/pata_of_platform.c
> +++ b/drivers/ata/pata_of_platform.c
> @@ -52,7 +52,7 @@ static int __devinit pata_of_platform_probe(struct of_device *ofdev,
>  
>  	ret = of_irq_to_resource(dn, 0, &irq_res);
>  	if (ret == NO_IRQ)
> -		irq_res.start = irq_res.end = -1;
> +		irq_res.start = irq_res.end = 0;
>  	else
>  		irq_res.flags = 0;
>  

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.

