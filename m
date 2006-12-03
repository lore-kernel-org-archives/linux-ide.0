From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 2.6.19 2/3] sata_promise: new EH conversion
Date: Sun, 03 Dec 2006 22:00:42 +0900
Message-ID: <4572CA7A.6010103@gmail.com>
References: <200612010958.kB19wGbg002454@alkaid.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.232]:7491 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1758607AbWLCNAt (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 3 Dec 2006 08:00:49 -0500
Received: by nz-out-0102.google.com with SMTP id s1so1727081nze
        for <linux-ide@vger.kernel.org>; Sun, 03 Dec 2006 05:00:48 -0800 (PST)
In-Reply-To: <200612010958.kB19wGbg002454@alkaid.it.uu.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Hello, Mikael.

Thanks for doing this.

Mikael Pettersson wrote:
[--snip--]
> +static void pdc_freeze(struct ata_port *ap)
> +{
> +	void __iomem *mmio = (void __iomem *) ap->ioaddr.cmd_addr;
> +	u32 tmp;
> +
> +	tmp = readl(mmio + PDC_CTLSTAT);
> +	tmp |= PDC_IRQ_DISABLE;
> +	tmp &= ~PDC_DMA_ENABLE;
> +	writel(tmp, mmio + PDC_CTLSTAT);
> +	readl(mmio + PDC_CTLSTAT); /* flush *//* XXX: needed? sata_sil does this */

Just drop the above line.

> +}
> +
> +static void pdc_thaw(struct ata_port *ap)
> +{
> +	void __iomem *mmio = (void __iomem *) ap->ioaddr.cmd_addr;
> +	u32 tmp;
> +
> +	/* clear IRQ */
> +	readl(mmio + PDC_INT_SEQMASK);
> +
> +	/* turn IRQ back on */
> +	tmp = readl(mmio + PDC_CTLSTAT);
> +	tmp &= ~PDC_IRQ_DISABLE;
> +	writel(tmp, mmio + PDC_CTLSTAT);
> +	readl(mmio + PDC_CTLSTAT); /* flush *//* XXX: needed? */

Ditto.

> +}
> +
> +static void pdc_error_handler(struct ata_port *ap)
> +{
> +	struct ata_eh_context *ehc = &ap->eh_context;
> +	ata_reset_fn_t hardreset;
> +
> +	/* stop DMA, mask IRQ, don't clobber anything else */
> +	ata_eh_freeze_port(ap);

Don't freeze port unconditionally.  You'll end up hardresetting on every
error.  Just make sure DMA engine is stopped and the controller is in a
sane state.  If that fails, then, the port should be frozen.

> +	hardreset = NULL;
> +	if (sata_scr_valid(ap)) {
> +		ehc->i.action |= ATA_EH_HARDRESET;

Why always force HARDRESET?

> +		hardreset = sata_std_hardreset;
> +	}

-- 
tejun
