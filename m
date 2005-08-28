From: Francois Romieu <romieu@fr.zoreil.com>
Subject: Re: [PATCH] sata_sil: enable Large Block Transfers
Date: Sun, 28 Aug 2005 12:39:59 +0200
Message-ID: <20050828103959.GA19154@electric-eye.fr.zoreil.com>
References: <20050828093404.GA29039@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:50050 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S1751131AbVH1Kmj
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 28 Aug 2005 06:42:39 -0400
Content-Disposition: inline
In-Reply-To: <20050828093404.GA29039@havoc.gtf.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

Jeff Garzik <jgarzik@pobox.com> :
[...]
> diff --git a/drivers/scsi/sata_sil.c b/drivers/scsi/sata_sil.c
> --- a/drivers/scsi/sata_sil.c
> +++ b/drivers/scsi/sata_sil.c
[...]
> @@ -210,6 +214,37 @@ MODULE_LICENSE("GPL");
>  MODULE_DEVICE_TABLE(pci, sil_pci_tbl);
>  MODULE_VERSION(DRV_VERSION);
>  
> +
> +static inline void sil_fill_sg(struct ata_queued_cmd *qc)
> +{
> +	struct scatterlist *sg = qc->sg;
> +	struct ata_port *ap = qc->ap;
> +	unsigned int idx, nelem;
> +
> +	assert(sg != NULL);
> +	assert(qc->n_elem > 0);
> +
> +	idx = 0;
> +	for (nelem = qc->n_elem; nelem; nelem--,sg++) {
> +		u32 addr = sg_dma_address(sg);
> +		u32 sg_len = sg_dma_len(sg);
> +
> +		ap->prd[idx].addr = cpu_to_le32(addr);
> +		ap->prd[idx].flags_len = cpu_to_le32(sg_len);
> +	}
> +
> +	if (idx)
> +		ap->prd[idx - 1].flags_len |= cpu_to_le32(ATA_PRD_EOT);
> +}

Does it not lack an 'idx++' somewhere ?

--
Ueimor
