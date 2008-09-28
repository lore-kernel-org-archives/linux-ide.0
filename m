From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] IDE: Fix platform device registration in Swarm IDE driver
Date: Sun, 28 Sep 2008 19:18:36 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0809281913040.5681@anakin>
References: <20080922122853.GA15210@linux-mips.org> <48DA1F9D.6000501@ru.mvista.com>
 <20080928114711.GB9207@linux-mips.org> <48DF7DBC.1080804@ru.mvista.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from yergi.telenet-ops.be ([195.130.132.36]:50968 "EHLO
	yergi.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752431AbYI1RTN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 28 Sep 2008 13:19:13 -0400
Received: from harold.telenet-ops.be (unknown [195.130.133.65])
	by yergi.telenet-ops.be (Postfix) with ESMTP id C10825CAC8F
	for <linux-ide@vger.kernel.org>; Sun, 28 Sep 2008 19:19:42 +0200 (CEST)
In-Reply-To: <48DF7DBC.1080804@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Ralf Baechle <ralf@linux-mips.org>, bzolnier@gmail.com, linux-ide@vger.kernel.org, "Maciej W. Rozycki" <macro@linux-mips.org>, linux-mips@linux-mips.org

On Sun, 28 Sep 2008, Sergei Shtylyov wrote:
> Ralf Baechle wrote:
> 
> > > > +{
> 
> > > [...]
> 
> > > > +	pdev = platform_device_register_simple(DEV_NAME, -1,
> > > > +		       swarm_ide_resource, ARRAY_SIZE(swarm_ide_resource));
> 
> > >  If you have the resources as static array anyway, why not have the
> > > device in the static variable too and use platform_device_register()?
> 
> > It saves a few lines of code.
> 
>    And wastes few words of static data since platform_device_register_simple()
> will kmalloc() the resources and do a copy from these resources after which
> they are not needed -- so, it's worth making swarm_ide_resource[] __initdata
> at least.
>    If you were using platform_device_register() with static platform device,
> no memory allocation would have happened, and no data would have been wasted.

Indeed, there are different static/dynamic memory usage patterns for the
various ways to register platform devices. Unfortunately (AFAIK) it's not
properly documented which to use when.

E.g. if some devices may be present (as indicated by e.g. firmware),
which one is the most optimal to use?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
