Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185B822370A
	for <linux-ide@vger.kernel.org>; Thu,  3 Sep 2026 23:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788479681; cv=none; b=fn8Sf01eqqUUmhMi/pztQSUfVGsthRRnr6SKoQM6cM/okBnFmex0J4conIsNWOVBO4xN3gCd96dEHx8WJoO7pWzJtPpgotWdAzE4OQa6B/ySIuQveVu7SG79t6RJGl277NYNvZG2BTk0rfO1yso1cZWwnxwlO7OqPG6MALFa/nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788479681; c=relaxed/simple;
	bh=gQNUGGNPhCamWPH5CKGlGvVVEnsuIp9vbJTpSejCkxY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=StqjaRwLHxR1CTdbLj8lyRvDPR4KTI14oXh/4IJoOhDg01wIv0jd9czGzc31k7fPns4sck981pwxl2IeiUrumJXWMi77KuTzfbGa4NS/Y0CbJTb9UwyTA+TxsAtFDIdCx1FEkvxbrpG2dnPmUjUWUhIOFGT5/4ab7CYRec3RbmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R+mGKAU9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R+mGKAU9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A2EB1F000E9;
	Thu,  3 Sep 2026 23:54:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788479680;
	bh=Rhi33AX+gVhtapbeT+9w4DELXOqeW3L8CAV1I4s2Jvg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=R+mGKAU9O+woPwqrlmt9kdMcQkGirgwtaUvyH21FJetMJMCClLpV1ggsRdmQkMoyn
	 pkAPwC+ArMz2kRIGWvaZYchYQgj/vh++0/CEjkrn5rQQahJ7l6eNxfjmhl1HWThkFs
	 XEUWlCrqOpcRFvarR2vS0lUmTV8c2FyhNT11p894FqZyRduwBgQv9DRQBeQSx9FT4U
	 XzppSRCe1cfgiQBvoHiV4OsmE8OcsnxSGbFY5eGtoU67kG8cpIcSqmtp3SZ5ehOemD
	 StIjWP3NieDYFgQEG6iSt5FSPustZ6QnstH25hjP1wdqAm6uaTqZE78PPyHpB/RtcZ
	 0WUVaC8YI9jwA==
Message-ID: <1a39c034-ecee-42cb-beea-c15f32c831c0@kernel.org>
Date: Fri, 4 Sep 2026 08:54:37 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: libahci: clear PxCLBU and PxFBU for
 AHCI_HFLAG_32BIT_ONLY
To: Niklas Cassel <cassel@kernel.org>
Cc: Roland Waltersson <roland.waltersson@netinsight.net>,
 linux-ide@vger.kernel.org
References: <20260903200349.1316460-2-cassel@kernel.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260903200349.1316460-2-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/4/26 05:03, Niklas Cassel wrote:
> A user reported that commit 105c42566a55 ("ata: ahci: force 32-bit DMA for
> JMicron JMB582/JMB585") made the JMicron JMB585 unusable on his board.
> 
> The failure is seen as soon as the ahci driver is probed, and booting with
> iommu=off does not solve the problem.
> 
> Looking at the AHCI specification, PxCLBU and PxFBU are both read only '0'
> for HBAs that do not support 64-bit addressing.
> 
> For HBAs that support 64-bit addressing, the registers are read write,
> with a reset value that is Implementation Specific.
> 
> When using the AHCI_HFLAG_32BIT_ONLY flag, the HBA does support 64-bit
> addressing, but we are simply setting a 32-bit DMA mask. Thus, in this
> case, we need to explicitly clear the registers to 0.
> 
> Fixes: c7a42156d99b ("ahci: disable 64bit dma on sb600")
> Reported-by: Roland Waltersson <roland.waltersson@netinsight.net>
> Closes: https://lore.kernel.org/linux-ide/IA0PR17MB668730A4ECCD65F7A1DC3EDC9EB62@IA0PR17MB6687.namprd17.prod.outlook.com/
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
>  drivers/ata/libahci.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
> index 6d72eb017b49..3a40ea926588 100644
> --- a/drivers/ata/libahci.c
> +++ b/drivers/ata/libahci.c
> @@ -748,11 +748,25 @@ void ahci_start_fis_rx(struct ata_port *ap)
>  	if (hpriv->cap & HOST_CAP_64)
>  		writel((pp->cmd_slot_dma >> 16) >> 16,
>  		       port_mmio + PORT_LST_ADDR_HI);
> +	/*
> +	 * On HBAs that do not support 64-bit addressing PxCLBU is read only,
> +	 * however, when forcing a HBA that has CAP.S64A in 32-bit only mode,
> +	 * the register is RW, and the reset value is Implementation Specific.
> +	 */
> +	else if (hpriv->flags & AHCI_HFLAG_32BIT_ONLY)
> +		writel(0, port_mmio + PORT_LST_ADDR_HI);

I find the comment very confusing as it is not directly describing what is being
done here. Furthermore, it says "when forcing a HBA that has CAP.S64A in 32-bit
only mode", but the added code is an "else" of "if (hpriv->cap & HOST_CAP_64))",
so that is for the case where the adapter is not 64-bits DMA capable. I am not
understanding something here...

Could you clarify please ? Also, please move the code comment above the "if" so
that it describes both the "if" and "else". Having the comment in the middle of
this if/else makes things hard to read.

>  	writel(pp->cmd_slot_dma & 0xffffffff, port_mmio + PORT_LST_ADDR);
>  
>  	if (hpriv->cap & HOST_CAP_64)
>  		writel((pp->rx_fis_dma >> 16) >> 16,
>  		       port_mmio + PORT_FIS_ADDR_HI);
> +	/*
> +	 * On HBAs that do not support 64-bit addressing PxFBU is read only,
> +	 * however, when forcing a HBA that has CAP.S64A in 32-bit only mode,
> +	 * the register is RW, and the reset value is Implementation Specific.
> +	 */
> +	else if (hpriv->flags & AHCI_HFLAG_32BIT_ONLY)
> +		writel(0, port_mmio + PORT_FIS_ADDR_HI);

Same thing here. Comment needs to move up and needs to be improved because (at
least I) find it not clear.

>  	writel(pp->rx_fis_dma & 0xffffffff, port_mmio + PORT_FIS_ADDR);
>  
>  	/* enable FIS reception */


-- 
Damien Le Moal
Western Digital Research
