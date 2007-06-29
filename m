From: "Andrew Hall" <andrew.a.hall@gmail.com>
Subject: RE: CF flash PATA on libata failure to attach
Date: Fri, 29 Jun 2007 12:15:58 +1000
Message-ID: <46846b72.15588c0a.4c19.ffffeeb9@mx.google.com>
References: <11172839.post@talk.nabble.com>	<46766BD3.4040702@gmail.com> <20070618125742.28a0bc57@the-village.bc.nu> <46770edc.101d640a.4fdf.4eae@mx.google.com> <46776306.5030300@gmail.com> <4679cefc.06d7720a.0280.ffff9cce@mx.google.com> <4679EA43.4040002@gmail.com> <467a2692.17bb720a.5a14.ffffa80c@mx.google.com> <467A8F17.1080608@rtr.ca> <4680d387.24528c0a.3634.69bd@mx.google.com> <46815FF4.9040001@rtr.ca> <4681e04b.22b38c0a.78ec.6f76@mx.google.com> <46826F42.70405@rtr.ca> <4682f7a3.15538c0a.2e12.ffff8676@mx.google.com> <4683F1C9.2060505@rtr.ca> <468453f8.13578c0a.3c99.ffffa514@mx.google.com> <46845BEE.90801@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.239]:17807 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765124AbXF2CQU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 28 Jun 2007 22:16:20 -0400
Received: by wx-out-0506.google.com with SMTP id h31so711914wxd
        for <linux-ide@vger.kernel.org>; Thu, 28 Jun 2007 19:16:19 -0700 (PDT)
In-Reply-To: <46845BEE.90801@rtr.ca>
Content-Language: en-au
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: 'Mark Lord' <liml@rtr.ca>
Cc: linux-ide@vger.kernel.org, 'Tejun Heo' <htejun@gmail.com>, 'Alan Cox' <alan@redhat.com>

> Here's a slightly modified hack, which should leave your SATA
> drive working as well as the CF card.
> 
> Tejun / Alan : do we really want to continue attempting mdma2
> on a modern chipset such as ICH8 ???
> 
> The best mdma2 can do is the same throughput as pio4,
> and the bus occupancy is so high for mdma2 that it really
> probably isn't worthwhile -- only CF cards seem to use it
> in modern systems anyway.
> 
> Signed-off-by:  Mark Lord <mlord@pobox.com>
> ---
> --- linux/drivers/ata/ata_piix.c.orig	2007-06-10 18:58:27.000000000
> -0400
> +++ linux/drivers/ata/ata_piix.c	2007-06-28 21:09:04.000000000 -0400
> @@ -537,7 +537,7 @@
>  		.flags		= PIIX_SATA_FLAGS | PIIX_FLAG_SCR |
>  				  PIIX_FLAG_AHCI,
>  		.pio_mask	= 0x1f,	/* pio0-4 */
> -		.mwdma_mask	= 0x07, /* mwdma0-2 */
> +		.mwdma_mask	= 0x00, /* mwdma0-2 */
>  		.udma_mask	= 0x7f,	/* udma0-6 */
>  		.port_ops	= &piix_sata_ops,
>  	},

That worked a treat! CF is flagged as PIO4 and HDD is now UDMA. I can't tell
you how grateful I am that you were able to point out the fix / modification
but I can certainly now sleep a bit easier.

Furthermore, if there is anything else I can do or would like me to test
while we have this type of hardware, please let me know.

Thanks again, Mark..

