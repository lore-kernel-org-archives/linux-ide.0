From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 1/8] sata_mv more cosmetics
Date: Fri, 25 Apr 2008 01:15:19 -0400
Message-ID: <481168E7.50402@pobox.com>
References: <480A3D2E.4040503@rtr.ca> <480A3D5E.8090206@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:47143 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752555AbYDYFP0 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 25 Apr 2008 01:15:26 -0400
In-Reply-To: <480A3D5E.8090206@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Tejun Heo <htejun@gmail.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Mark Lord wrote:


applied patches 1-8...



> @@ -1789,30 +1794,28 @@
>     struct mv_host_priv *hpriv = host->private_data;
>     unsigned int hc, handled = 0, n_hcs;
>     void __iomem *mmio = hpriv->base;
> -    u32 irq_stat, irq_mask;
> +    u32 main_cause, main_mask;
> 
> -    /* Note to self: &host->lock == &ap->host->lock == ap->lock */
>     spin_lock(&host->lock);
> -
> -    irq_stat = readl(hpriv->main_cause_reg_addr);
> -    irq_mask = readl(hpriv->main_mask_reg_addr);
> -
> -    /* check the cases where we either have nothing pending or have read
> -     * a bogus register value which can indicate HW removal or PCI fault
> +    main_cause = readl(hpriv->main_cause_reg_addr);
> +    main_mask  = readl(hpriv->main_mask_reg_addr);
> +    /*
> +     * Deal with cases where we either have nothing pending, or have read
> +     * a bogus register value which can indicate HW removal or PCI fault.
>      */

  ...but I am sad to see this.  irq_stat and irq_mask naming make the 
driver more accessible to outsiders, because the purpose of the 
registers is immediately apparent even without having the docs at hand 
-- which is the case for everybody in the world except me and you :)

I applied the patch anyway because you are defacto maintainer of sata_mv.

However, I _request_ a reconsideration of some of these renames when 
viewed in that light.  It's your prerogative as maintainer to ignore or 
honor that request as you see fit...  We all have to balance making our 
own job easier with making the driver accessible to outsiders, 
particularly those without NDA'd docs.

	Jeff



