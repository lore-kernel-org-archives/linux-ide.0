From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] atapi request sense work
Date: Thu, 27 May 2004 19:32:09 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <40B67A79.9000706@pobox.com>
References: <1084717146.3576.3.camel@patibmrh9> <40AD7FB2.10506@pobox.com><1	 085153750.6103.33.camel@patibmrh9><200405211746.35015.bzolnier@elka.pw.ed 	u	 .	pl><1085162347.4791.24.camel@patibmrh9><1085170025.3083.91.camel@pati 	bm	r h9> <40AE79E1.9020005@pobox.com><1085182749.3122.15.camel@patibmrh9> <	40AE9493.1040701@pobox.com><1085186021.4510.0.camel@patibmrh9>  <1085188300	.3658.18.camel@patibmrh9><1085608170.4148.138.camel@patibmrh9> <1085699522.3853.1.camel@patibmrh9>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:7315 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265679AbUE0XcW
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 27 May 2004 19:32:22 -0400
In-Reply-To: <1085699522.3853.1.camel@patibmrh9>
List-Id: linux-ide@vger.kernel.org
To: Pat LaVarre <p.lavarre@ieee.org>
Cc: linux-ide@vger.kernel.org

Pat LaVarre wrote:
>  /**
> + *	ata_check_bmdma - read PCI IDE BMDMA status
> + *	@ap: struct ata_port
> + */
> +
> +static u8 ata_check_bmdma(struct ata_port *ap)
> +{
> +	u8 host_stat;
> +	if (ap->flags & ATA_FLAG_MMIO) {
> +		void *mmio = (void *) ap->ioaddr.bmdma_addr;
> +		host_stat = readb(mmio + ATA_DMA_STATUS);
> +	} else
> +		host_stat = inb(ap->ioaddr.bmdma_addr + ATA_DMA_STATUS);
> +	return host_stat;
> +}
> +
> +/**


As a first step, would you be willing to create a patch versus mainline, 
that does nothing but add this function (and uses it)?

	Jeff


