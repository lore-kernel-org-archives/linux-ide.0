From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] libata atapi work #2
Date: Fri, 14 May 2004 11:01:13 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <40A4DF39.8050409@pobox.com>
References: <40A42218.5040905@pobox.com> <200405141444.21700.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:38318 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261421AbUENPBc
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 14 May 2004 11:01:32 -0400
In-Reply-To: <200405141444.21700.bzolnier@elka.pw.edu.pl>
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: linux-ide@vger.kernel.org, Pat LaVarre <p.lavarre@ieee.org>

Bartlomiej Zolnierkiewicz wrote:
> Jeff, is this intentional?
> 
> @@ -2457,6 +2457,13 @@
>  		queue_work(ata_wq, &ap->pio_task);
>  		break;
>  
> +	case ATA_PROT_ATAPI:
> +	case ATA_PROT_ATAPI_DMA:
> +		ap->ops->tf_load(ap, &qc->tf);	 /* load tf registers */
> +		ap->ops->bmdma_setup(qc);	    /* set up bmdma */
> +		queue_work(ata_wq, &ap->packet_task);
> +		break;

yeah, caught and fixed that...

	Jeff




