Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B6B1405F7;
	Fri,  4 Apr 2025 03:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743739156; cv=none; b=C8WqE7QiVnD0eHbiG0rLpC6f5Co17bNkrF1bzt9cDRfI2o20/9Fp+wSyJ8pEiMcPDq0BAJ6n/NcF0gtWbBj23lXcOAtobHfy2VGf2y/EaDM1VMTvRUdbqM9WtPcTx3TQ7diwGlwH7HOrIqEtzJw8B+LqKpzVt1QgbRVHpDG1eK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743739156; c=relaxed/simple;
	bh=BdLwHZsBU40P30YGvPPMhHq723Qt2ONBSSFEhJb9tRY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GwuipDvDu9o7Svef+J8s6ZpIOh3FPR3+MRpK1K9kTw1+f6mys5uCPMCrJTnxazmPCQj/nwhq5SEAgrert+OmL7cHdHy2/57UMcdiaqGSOq2ZuW7xKW+o3Up/MxMJ7BNgwI3CUp2STv7vRQk/29HcxGhHIjhehZiIULXRAZZ5XCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vw0pqb6Y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vw0pqb6Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7158AC4CEDD;
	Fri,  4 Apr 2025 03:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743739154;
	bh=BdLwHZsBU40P30YGvPPMhHq723Qt2ONBSSFEhJb9tRY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Vw0pqb6YpukDc+TtA+qINtP+sG1dQtD5swSgyNFmHp8loJ0GSsjNIDp8+ZjcJIblt
	 RuAgc9/jpvHFw1s7bN+ud8OPZKUSD+BZaE+QPlUWij+SnwdyRx2OwuJKpKuT/4DwWu
	 6W9NwSKFa9d2EmzNu3c9kpDuF2qzuBKowXMe/CNPM35MIr84aTm5DEDsHJYvGJRroG
	 Rw6/9T8k590b3TI5Ypa5ItDirDWYc/+HUnpTS2DkioNJb3J14wWSuEFRyaaMtl505k
	 fLVW9pEAlYqsU9QvWg43upw/jYrOKNQJGQ5EyBkoeiDs3Ia5nko24ngeti0s7Bv201
	 EIN3I5TvDsrbA==
Message-ID: <f1e0683a-579f-470b-afa9-4869ac3ced98@kernel.org>
Date: Fri, 4 Apr 2025 12:58:30 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] [ARM] pata_pxa: Fix null-ptr-deref in pxa_ata_probe()
To: Henry Martin <bsdhenrymartin@gmail.com>, cassel@kernel.org,
 linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
References: <20250403034520.59597-1-bsdhenrymartin@gmail.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20250403034520.59597-1-bsdhenrymartin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/3/25 12:45 PM, Henry Martin wrote:
> devm_ioremap() returns NULL on error. Currently, pxa_ata_probe() does
> not check for this case, which results in a NULL pointer dereference.

, which can result in...

> 
> Add NULL check after devm_ioremap() to prevent this issue.
> 
> Fixes: 2dc6c6f15da9 ("[ARM] pata_pxa: DMA-capable PATA driver")
> Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
> ---
>  drivers/ata/pata_pxa.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/pata_pxa.c b/drivers/ata/pata_pxa.c
> index 434f380114af..cc76290a3b1a 100644
> --- a/drivers/ata/pata_pxa.c
> +++ b/drivers/ata/pata_pxa.c
> @@ -223,11 +223,16 @@ static int pxa_ata_probe(struct platform_device *pdev)
>  
>  	ap->ioaddr.cmd_addr	= devm_ioremap(&pdev->dev, cmd_res->start,
>  						resource_size(cmd_res));
> +	if (!ap->ioaddr.cmd_addr)
> +		return -ENOMEM;
>  	ap->ioaddr.ctl_addr	= devm_ioremap(&pdev->dev, ctl_res->start,
>  						resource_size(ctl_res));
> +	if (!ap->ioaddr.ctl_addr)
> +		return -ENOMEM;
>  	ap->ioaddr.bmdma_addr	= devm_ioremap(&pdev->dev, dma_res->start,
>  						resource_size(dma_res));
> -
> +	if (!ap->ioaddr.bmdma_addr)
> +		return -ENOMEM;

Please keep the blank line here.

>  	/*
>  	 * Adjust register offsets
>  	 */


-- 
Damien Le Moal
Western Digital Research
