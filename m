From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 3/5] cmd64x: implement serialization as per notes
Date: Tue, 17 Nov 2009 18:35:05 +0100
Message-ID: <200911171835.05232.bzolnier@gmail.com>
References: <20091117144450.15430.83450.stgit@localhost.localdomain> <20091117145122.15430.70080.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f227.google.com ([209.85.218.227]:48285 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751198AbZKQRiV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 17 Nov 2009 12:38:21 -0500
In-Reply-To: <20091117145122.15430.70080.stgit@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Tuesday 17 November 2009 15:51:32 Alan Cox wrote:

> +struct cmd_priv
> +{
> +	int dma_live;		/* Channel using DMA */
> +	int irq_t[2];		/* Register to check for IRQ */
> +	int irq_m[2];		/* Bit to check */
> +};

irq_t and irq_m content will be identical for all host instances
so you may as well add one instance for it, use ->private_data to
store dma_live information and remove cmd_priv allocation

> +	/* If the other port is not live then issue the command */
> +	if (alt == NULL || !alt->qc_active) {
> +		if (dma)
> +			priv->dma_live = qc->ap->port_no;
> +		return 0;
> +	}
> +	/* If there is a live DMA command then wait */
> +	if (priv->dma_live != -1)
> +		return 	ATA_DEFER_PORT;
> +	if (dma) {
> +		/* Cannot overlap our DMA command */
> +		if (alt->qc_active)
> +			return ATA_DEFER_PORT;

no need to check alt->qc_active again here

-- 
Bartlomiej Zolnierkiewicz
