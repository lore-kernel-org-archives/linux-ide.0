From: Mark Lord <kernel@teksavvy.com>
Subject: Re: [PATCH] sata_mv: fix broken DSM/TRIM support (v2)
Date: Fri, 20 Aug 2010 09:56:56 -0400
Message-ID: <4C6E89A8.2000600@teksavvy.com>
References: <1282267195.8909.6.camel@corey> <1282268444.9628.4.camel@corey>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ironport2-out.teksavvy.com ([206.248.154.181]:15053 "EHLO
	ironport2-out.pppoe.ca" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751375Ab0HTN45 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 20 Aug 2010 09:56:57 -0400
In-Reply-To: <1282268444.9628.4.camel@corey>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: tj@kernel.org, jeff@garzik.org

On 10-08-19 09:40 PM, Mark Lord wrote:
> Fix DSM/TRIM commands in sata_mv (v2).
> These need to be issued using old-school "BM DMA",
> rather than via the EDMA host queue.
>
> Since the chips don't have proper BM DMA status,
> we need to be more careful with setting the ATA_DMA_INTR bit,
> since DSM/TRIM often has a long delay between "DMA complete"
> and "command complete".
..

Speaking of which.. it appears that BM DMA support for sata_mv
is intentionally broken by 2.6.35 kernels, with the addition of
this code in libata-sff.c:

unsigned int ata_bmdma_qc_issue(struct ata_queued_cmd *qc)
{
         struct ata_port *ap = qc->ap;

         /* see ata_dma_blacklisted() */
         BUG_ON((ap->flags & ATA_FLAG_PIO_POLLING) &&
                qc->tf.protocol == ATAPI_PROT_DMA);


Is that BUG_ON even necessary??
It really should be looking only at tf.flags, not qp->flags there,
as it actually does redundantly further on:

    WARN_ON_ONCE(qc->tf.flags & ATA_TFLAG_POLLING);

sata_mv has ATA_FLAG_PIO_POLLING set for all ports,
but doesn't set ATA_TFLAG_POLLING when doing BM DMA.

???
