From: Michael Tokarev <mjt@tls.msk.ru>
Subject: Re: [PATCH] pata_mpc52xx: NO_IRQ is zero
Date: Thu, 03 Jan 2008 19:57:49 +0300
Message-ID: <477D140D.8020104@msgid.tls.msk.ru>
References: <20080103165014.483fcf10@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hobbit.corpit.ru ([81.13.94.6]:21128 "EHLO hobbit.corpit.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752562AbYACQ5v (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 3 Jan 2008 11:57:51 -0500
In-Reply-To: <20080103165014.483fcf10@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: jeff@garzik.org, linux-ide@vger.kernel.org

Alan Cox wrote:
> Signed-off-by: Alan Cox <alan@redhat.com>

The comment is misleading at best...

It doesn't matter if NO_IRQ is zero or not here, because ata_irq
is not a static/global variable, but a local one.  By removing the
initializer, here, the semantics changes.

But in this very case, it's safe to remove the initializer,
because this variable gets initialized a few lines below this
code snipped, in:

        ata_irq = irq_of_parse_and_map(op->node, 0);

(and there's no other goto's before that, either).

/mjt

> diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.24-rc6-mm1/drivers/ata/pata_mpc52xx.c linux-2.6.24-rc6-mm1/drivers/ata/pata_mpc52xx.c
> --- linux.vanilla-2.6.24-rc6-mm1/drivers/ata/pata_mpc52xx.c	2008-01-02 16:03:58.000000000 +0000
> +++ linux-2.6.24-rc6-mm1/drivers/ata/pata_mpc52xx.c	2008-01-02 16:13:08.000000000 +0000
> @@ -364,7 +364,7 @@
>  {
>  	unsigned int ipb_freq;
>  	struct resource res_mem;
> -	int ata_irq = NO_IRQ;
> +	int ata_irq;
>  	struct mpc52xx_ata __iomem *ata_regs;
>  	struct mpc52xx_ata_priv *priv;
>  	int rv;

