From: Chuck Ebbert <cebbert@redhat.com>
Subject: Re: [PATCH] fix dma_unmap_sg misuse
Date: Wed, 18 Feb 2009 17:12:35 -0500
Message-ID: <20090218171235.721d241a@dhcp-100-2-144.bos.redhat.com>
References: <20090217133432M.fujita.tomonori@lab.ntt.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx2.redhat.com ([66.187.237.31]:48763 "EHLO mx2.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752061AbZBRWPR (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 18 Feb 2009 17:15:17 -0500
In-Reply-To: <20090217133432M.fujita.tomonori@lab.ntt.co.jp>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Cc: linux-ide@vger.kernel.org

On Tue, 17 Feb 2009 13:35:27 +0900
FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp> wrote:

> From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
> Subject: [PATCH] fix dma_unmap_sg misuse
> 
> DMA-mapping.txt says:
> 
> To unmap a scatterlist, just call:
> 
> 	pci_unmap_sg(pdev, sglist, nents, direction);
> 
> Again, make sure DMA activity has already finished.
> 
> PLEASE NOTE:  The 'nents' argument to the pci_unmap_sg call must be
>               the _same_ one you passed into the pci_map_sg call,
> 	      it should _NOT_ be the 'count' value _returned_ from the
>               pci_map_sg call.
> 
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
> ---
>  drivers/ata/libata-core.c |    4 ++--
>  include/linux/libata.h    |    1 +
>  2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 9fbf059..5e324ce 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -4612,7 +4612,7 @@ void ata_sg_clean(struct ata_queued_cmd *qc)
>  	VPRINTK("unmapping %u sg elements\n", qc->n_elem);
>  
>  	if (qc->n_elem)

	if (qc->orig_n_elem)
?

> -		dma_unmap_sg(ap->dev, sg, qc->n_elem, dir);
> +		dma_unmap_sg(ap->dev, sg, qc->orig_n_elem, dir);
>  
>  	qc->flags &= ~ATA_QCFLAG_DMAMAP;
>  	qc->sg = NULL;
