Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A7E524EF8E;
	Tue, 11 Mar 2025 10:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741689944; cv=none; b=fTg9xx0YmeVsl5uo+StE/9eXWdyAuu6IF4G8gtTwuedoBQ8e/PV3oMUJ/AEo3mBVj+OyOyGfCQUvzqVliOPjAUqYDPi0vIqRK+cHWH03ywo7sz6L0zoRcmCT1BvvUOmjJMmvJyJ7d4l4GgudvoAS7kq8ieSDKjhTlvSr+S21j88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741689944; c=relaxed/simple;
	bh=fD3r6z7e6HcfQgOi10wve1Oi9uKtT2jOA0L0pllcXKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bkDpaMiWDhCIWkS/oNMAk2dfAUhqobafBIIqLTpa0VC0Qary63J4bggiReZRR23+u3dlTeWvfunYYg+3b77lcOd9nEEyzk8y9JMZ/NK7/kNNqxCsdxnZewnKm1YLS3ER1FChnAkd74E78NWDzdU9/xO306rZfYVQE5n61tyzej8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O8YxJCI4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O8YxJCI4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78603C4CEE9;
	Tue, 11 Mar 2025 10:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741689943;
	bh=fD3r6z7e6HcfQgOi10wve1Oi9uKtT2jOA0L0pllcXKQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O8YxJCI42PaqFVX9Q9s1084n/qJWyZBTw3N+2jpU7rgzhecH6fKpmoHqhgK99vYLr
	 MV7cqTxOvR57m+9wAQtv+TZ+HX5w61bRYrMIrELi9FQ5136avq1Zwxw/snCwuVa5Mr
	 d/zW+9YDNBqnvVaF+r+ff2n4/G8SJwRgMKzxzy0laZUd4Xh8I0nMfIrmew4412lovZ
	 jqjEPNKxhflAIVvgIcgaV5uEYX2km8esC1KmDpUNiCy6apJ1D/DyHZjE3J99NO6Vdg
	 uUBV0qzweOE1MDcIggZvp76FKd5Z8lZch2FUJCrrtxrIajyE3f+yM3PhIri3KsPyNm
	 s+Ie2c2dx/tFQ==
Date: Tue, 11 Mar 2025 11:45:38 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Huacai Chen <chenhuacai@loongson.cn>
Cc: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org,
	Huacai Chen <chenhuacai@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>, linux-kernel@vger.kernel.org,
	Yuli Wang <wangyuli@uniontech.com>, Jie Fan <fanjie@uniontech.com>,
	Erpeng Xu <xuerpeng@uniontech.com>
Subject: Re: [PATCH V2] ahci: Marvell 88SE9215 controllers prefer DMA for
 ATAPI
Message-ID: <Z9AUUvfId9J66zWS@ryzen>
References: <20250311030217.4177569-1-chenhuacai@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250311030217.4177569-1-chenhuacai@loongson.cn>

Hello Huacai Chen,

On Tue, Mar 11, 2025 at 11:02:17AM +0800, Huacai Chen wrote:
> We use CD/DVD drives under Marvell 88SE9215 SATA controller on many
> Loongson-based machines. We found its PIO doesn't work well, and on the
> opposite its DMA seems work very well. We don't know the detail of the
> 88SE9215 SATA controller, but we have tested different CD/DVD drives
> and they all have problems under 88SE9215 (but they all work well under
> an Intel SATA controller). So we can define a new AHCI board id named
> board_ahci_atapi_dma, and for this id we set the ATA_FLAG_ATAPI_DMA and
> ATA_QUIRK_ATAPI_MOD16_DMA flags on the SATA controller to prefer ATAPI
> DMA.

This patch does not apply.
It conflicts with:
https://web.git.kernel.org/pub/scm/linux/kernel/git/libata/linux.git/commit/?h=for-6.15&id=885251dc35767b1c992f6909532ca366c830814a

Please add Daniel to CC when you respin, so that he might also be able
to test.


> 
> BTW, return -EOPNOTSUPP instead of 1 if ATAPI DMA is not supported in
> atapi_check_dma().

Please create a separate patch (e.g patch 1/2) for this with a proper
commit log. (A proper commit log should always answer the question: Why?)


> 
> Reported-by: Yuli Wang <wangyuli@uniontech.com>
> Tested-by: Jie Fan <fanjie@uniontech.com>
> Tested-by: Erpeng Xu <xuerpeng@uniontech.com>
> Tested-by: Yuli Wang <wangyuli@uniontech.com>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
>  drivers/ata/ahci.c        | 12 ++++++++++++
>  drivers/ata/libata-core.c |  6 +++++-
>  include/linux/libata.h    |  1 +
>  3 files changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index f813dbdc2346..a64db28549d8 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -49,6 +49,7 @@ enum board_ids {
>  	/* board IDs by feature in alphabetical order */
>  	board_ahci,
>  	board_ahci_43bit_dma,
> +	board_ahci_atapi_dma,
>  	board_ahci_ign_iferr,
>  	board_ahci_no_debounce_delay,
>  	board_ahci_no_msi,
> @@ -137,6 +138,12 @@ static const struct ata_port_info ahci_port_info[] = {
>  		.udma_mask	= ATA_UDMA6,
>  		.port_ops	= &ahci_ops,
>  	},
> +	[board_ahci_atapi_dma] = {
> +		.flags		= AHCI_FLAG_COMMON,
> +		.pio_mask	= ATA_PIO4,
> +		.udma_mask	= ATA_UDMA6,
> +		.port_ops	= &ahci_ops,
> +	},
>  	[board_ahci_ign_iferr] = {
>  		AHCI_HFLAGS	(AHCI_HFLAG_IGN_IRQ_IF_ERR),
>  		.flags		= AHCI_FLAG_COMMON,
> @@ -591,6 +598,8 @@ static const struct pci_device_id ahci_pci_tbl[] = {
>  	  .driver_data = board_ahci_yes_fbs },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_MARVELL_EXT, 0x9230),
>  	  .driver_data = board_ahci_yes_fbs },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_MARVELL_EXT, 0x9215),
> +	  .driver_data = board_ahci_atapi_dma },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_MARVELL_EXT, 0x9235),
>  	  .driver_data = board_ahci_no_debounce_delay },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_TTI, 0x0642), /* highpoint rocketraid 642L */
> @@ -1917,6 +1926,9 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>  	/* save initial config */
>  	ahci_pci_save_initial_config(pdev, hpriv);
>  
> +	if (board_id == board_ahci_atapi_dma)
> +		pi.flags |= ATA_FLAG_ATAPI_DMA;
> +

No need for these three lines, just rename your board_ahci_atapi_dma
board to board_ahci_atapi_dma_quirk_yes_fbs

and in the initialization of ahci_atapi_dma_quirk_yes_fbs, set:
AHCI_HFLAGS     (AHCI_HFLAG_ATAPI_DMA_QUIRK |
		 AHCI_HFLAG_YES_FBS),
.flags          = AHCI_FLAG_COMMON,


And rename ATA_FLAG_ATAPI_DMA to AHCI_HFLAG_ATAPI_DMA_QUIRK and put it in
AHCI_HFLAGS instead.



>  	/* prepare host */
>  	if (hpriv->cap & HOST_CAP_NCQ) {
>  		pi.flags |= ATA_FLAG_NCQ;
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index c085dd81ebe7..87a3dbf3ac93 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -3029,6 +3029,10 @@ int ata_dev_configure(struct ata_device *dev)
>  		dev->max_sectors = ATA_MAX_SECTORS;
>  	}
>  
> +	if ((dev->class == ATA_DEV_ATAPI) &&
> +	    (ap->flags & ATA_FLAG_ATAPI_DMA))
> +		dev->quirks |= ATA_QUIRK_ATAPI_MOD16_DMA;
> +
>  	if ((dev->class == ATA_DEV_ATAPI) &&
>  	    (atapi_command_packet_set(id) == TYPE_TAPE)) {
>  		dev->max_sectors = ATA_MAX_SECTORS_TAPE;
> @@ -4544,7 +4548,7 @@ int atapi_check_dma(struct ata_queued_cmd *qc)
>  	 */
>  	if (!(qc->dev->quirks & ATA_QUIRK_ATAPI_MOD16_DMA) &&
>  	    unlikely(qc->nbytes & 15))
> -		return 1;
> +		return -EOPNOTSUPP;
>  
>  	if (ap->ops->check_atapi_dma)
>  		return ap->ops->check_atapi_dma(qc);
> diff --git a/include/linux/libata.h b/include/linux/libata.h
> index c1c57f814b98..67d374279a65 100644
> --- a/include/linux/libata.h
> +++ b/include/linux/libata.h
> @@ -194,6 +194,7 @@ enum {
>  					    /* (doesn't imply presence) */
>  	ATA_FLAG_SATA		= (1 << 1),
>  	ATA_FLAG_NO_LPM		= (1 << 2), /* host not happy with LPM */
> +	ATA_FLAG_ATAPI_DMA	= (1 << 4), /* ATAPI use DMA */

s/ATAPI use DMA/force ATAPI to use DMA/


>  	ATA_FLAG_NO_LOG_PAGE	= (1 << 5), /* do not issue log page read */
>  	ATA_FLAG_NO_ATAPI	= (1 << 6), /* No ATAPI support */
>  	ATA_FLAG_PIO_DMA	= (1 << 7), /* PIO cmds via DMA */
> -- 
> 2.47.1
> 

Kind regards,
Niklas
