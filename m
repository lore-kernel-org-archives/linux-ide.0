From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] libata DMADIR support
Date: Tue, 18 May 2004 19:50:01 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <40AAA129.7050600@pobox.com>
References: <1084717146.3576.3.camel@patibmrh9> <40A7F641.3070809@pobox.com>	<1084819720.4328.86.camel@patibmrh9>  <40A90D96.2040002@pobox.com><108482 8		840.3211.26.camel@patibmrh9>  <40A92F69.6030309@pobox.com><1084831524.3211	.67.camel@patibmrh9>  <40A93E85.4010904@pobox.com><1084920024.3191.8.camel@	patibmrh9> <1084921676.3135.3.camel@patibmrh9>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:45962 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263740AbUERXuO
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 18 May 2004 19:50:14 -0400
In-Reply-To: <1084921676.3135.3.camel@patibmrh9>
List-Id: linux-ide@vger.kernel.org
To: Pat LaVarre <p.lavarre@ieee.org>
Cc: linux-ide@vger.kernel.org

Pat LaVarre wrote:
> +#ifdef ATAPI_ENABLE_DMADIR
> +	printk(KERN_DEBUG "ata%u: dev %u cfg "
> +	       "62:%04x\n",
> +	       ap->id, device, dev->id[62]);
> +	if (dev->id[62] & (1 << 15)) { /* 0x8000 DMADIR */
> +		u16 * id = dev->id;
> +		if (id[62] & (1 << 10)) { /* 0x0400 DMA */
> +			id[49] |= (1 << 8);
> +			id[63] |= ((id[62] >> 7) & 0x07); /* 0x0380 MWDMA */
> +			id[88] |= ((id[62] >> 0) & 0x3F); /* 0x007F UDMA */
> +		}
> +	}
> +#endif


Yeah, something like this needs to be done for DMADIR bridges.

	Jeff



