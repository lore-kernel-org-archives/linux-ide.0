Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE3B179211
	for <linux-ide@vger.kernel.org>; Fri, 26 Jul 2024 11:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721992431; cv=none; b=CcpKKX7aPEmTxOTubp7A50yL4wfsMzAxLA6JSvkU0RNHcbFq39uFCn+ufYN2DBjtC0c/ObSgGBYOD0sMgIGQLFXGYhivG7ylCTmsdUZ1+0wHUQn/zTFc0FLnrexsH2Hbaq1GCcXDRtuXYOKEVYJ/X6LD7pIGOf4h3g4CBqJ5x34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721992431; c=relaxed/simple;
	bh=M6eACe/V++Irublbdd5Aq+/z8kVA1dmvWQSBxCIo/Ew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WNXIiaC/q9V/msPxlbsX3m6edBJxQmEIG7Ji9U5IfByx/cs8vvhW4qRLvC9QgOQmAajIdDF2xV2VZ+mf7kKM2YeTbdqZMAzORJUYZBzRwq9afZTFugGwi9yIPNdmZlO8Ouu690lxvC7Fnp/DqNgeMEO4QWsdoSMw9bHT79nqwsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KLa0BEXf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KLa0BEXf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2F56C32782;
	Fri, 26 Jul 2024 11:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721992431;
	bh=M6eACe/V++Irublbdd5Aq+/z8kVA1dmvWQSBxCIo/Ew=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KLa0BEXfRXUMaTzRT5YK6bsg8RhhZ7xsTSIDOIOJ7GVvKoyVgiG17R5J68gezra1e
	 GXkqbtFx59dqGibMWgW2cA4P7XXc3QmXc6luLV63IN/SDl9K9SLHhh3ixUV08uCeKJ
	 LH/eq5bl2QOJsyPtU3AwKuSdgPEewAj+kW3glFnD1qg08eI4zvHLU+SgsijV14+N8G
	 h+ltRdTkRjxuuisoUK6z/9bqetTEMCclHE6Cg+SqKenPz7RIfsR7q29u9VbvgHo7o0
	 soMMaXqF7BJhbZ4OZqDkciRH25tY3vNoyqEhZQO17JIFB46XJ9NfQnn8UYdpi9AZCa
	 50piTlbiSeysg==
Date: Fri, 26 Jul 2024 13:13:47 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org
Subject: Re: [PATCH v6 11/11] ata: pata_hpt37x: Rename hpt_dma_blacklisted()
Message-ID: <ZqOE6_lioZywrUyj@ryzen.lan>
References: <20240726031954.566882-1-dlemoal@kernel.org>
 <20240726031954.566882-12-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240726031954.566882-12-dlemoal@kernel.org>

On Fri, Jul 26, 2024 at 12:19:54PM +0900, Damien Le Moal wrote:
> Rename the function hpt_dma_blacklisted() to the more neutral
> hpt_dma_broken().
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>  drivers/ata/pata_hpt37x.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/ata/pata_hpt37x.c b/drivers/ata/pata_hpt37x.c
> index c0329cf01135..4af22b819416 100644
> --- a/drivers/ata/pata_hpt37x.c
> +++ b/drivers/ata/pata_hpt37x.c
> @@ -218,8 +218,8 @@ static u32 hpt37x_find_mode(struct ata_port *ap, int speed)
>  	return 0xffffffffU;	/* silence compiler warning */
>  }
>  
> -static int hpt_dma_blacklisted(const struct ata_device *dev, char *modestr,
> -			       const char * const list[])
> +static int hpt_dma_broken(const struct ata_device *dev, char *modestr,
> +			  const char * const list[])
>  {
>  	unsigned char model_num[ATA_ID_PROD_LEN + 1];
>  	int i;
> @@ -281,9 +281,9 @@ static const char * const bad_ata100_5[] = {
>  static unsigned int hpt370_filter(struct ata_device *adev, unsigned int mask)
>  {
>  	if (adev->class == ATA_DEV_ATA) {
> -		if (hpt_dma_blacklisted(adev, "UDMA", bad_ata33))
> +		if (hpt_dma_broken(adev, "UDMA", bad_ata33))
>  			mask &= ~ATA_MASK_UDMA;
> -		if (hpt_dma_blacklisted(adev, "UDMA100", bad_ata100_5))
> +		if (hpt_dma_broken(adev, "UDMA100", bad_ata100_5))
>  			mask &= ~(0xE0 << ATA_SHIFT_UDMA);
>  	}
>  	return mask;
> @@ -300,7 +300,7 @@ static unsigned int hpt370_filter(struct ata_device *adev, unsigned int mask)
>  static unsigned int hpt370a_filter(struct ata_device *adev, unsigned int mask)
>  {
>  	if (adev->class == ATA_DEV_ATA) {
> -		if (hpt_dma_blacklisted(adev, "UDMA100", bad_ata100_5))
> +		if (hpt_dma_broken(adev, "UDMA100", bad_ata100_5))
>  			mask &= ~(0xE0 << ATA_SHIFT_UDMA);
>  	}
>  	return mask;
> -- 
> 2.45.2
> 

Reviewed-by: Niklas Cassel <cassel@kernel.org>
