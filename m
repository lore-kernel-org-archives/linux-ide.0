Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068D814F70;
	Thu, 31 Jul 2025 04:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753935349; cv=none; b=eTnmGJJqe1yOJWIFIdim0rCzeAOnCjXvpROyefKkQAGiIKcuMKG7C7i55REjNS8K78D8/bwFLtpAUmPAUBbC9BgEdV4OKXQoN6IQzeI8doIP6iyEFTtaNu/hdArS/Pnsda7+5yLmfVdE35ZcUBno8B/boqRXh18WwMQge+4OX/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753935349; c=relaxed/simple;
	bh=uPS4nCNFTEXDXf5Rwa8kirD31VmiLL1h6madTORbdgs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YW4rbE6fGeLHkFwfcaExZ6NsZQ/ooSzKrXmLV0Gog211mXC+SvFpeZFmAlDqYXK6Q8o6tY2r/vOJ3H2rrtuidJBscZjN2fU///YW9i9tLq9MRTJx+pym7UV2qr7I1XSSRsJeyN9janD/JbBIVFr7SyijnRgw5eVBnFxFXzGhvFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AdSqdBaF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AdSqdBaF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A584EC4CEEF;
	Thu, 31 Jul 2025 04:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753935348;
	bh=uPS4nCNFTEXDXf5Rwa8kirD31VmiLL1h6madTORbdgs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=AdSqdBaFmAZqEgBWotCGOTZPjNyv4YiDBaSblBXJtXOmHBbGRbX3Dmh1c+gdn+QRx
	 5oOZaqMQOOZwvwb5zKeI93WgTTXn8dHs16ns6mdgSi+OCtbrMVXziTpdJF4sxe+ZcW
	 nwPrKpqbS5j6WAjTR3yw/RS6dXhJt8UvrC8PL8WL0Qqjv5S68P9/mMnkBdOgtOoUIG
	 isjL2SFREFG7qpPN0v6R3AYZn/SCE6WLG7XGFy+2f0eeA+rubqFKjJAS8dbYE0I8th
	 uZgk/SBwGSU8wJOem92rcrDfh4ouNW0DnBIhbtPLHF6erckh/I9HVJE2/JdQcThg4r
	 1UOGaRVoTM0Uw==
Message-ID: <bd906cd8-a278-4b07-a6b8-947865c6267a@kernel.org>
Date: Thu, 31 Jul 2025 13:13:14 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] ata: pata_pdc2027x: Remove space before newline
To: Colin Ian King <colin.i.king@gmail.com>, Niklas Cassel
 <cassel@kernel.org>, linux-ide@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250730110813.2059223-1-colin.i.king@gmail.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20250730110813.2059223-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/30/25 8:08 PM, Colin Ian King wrote:
> There is a extraneous space before a newline in handful of ata_port_dbg
> messages. Remove the spaces.

While at it, please capitalize pio, udma and mdma in these messages. These are
abreviations and capital letters make that clear.

> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  drivers/ata/pata_pdc2027x.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/ata/pata_pdc2027x.c b/drivers/ata/pata_pdc2027x.c
> index d792ce6d97bf..021b38ed794d 100644
> --- a/drivers/ata/pata_pdc2027x.c
> +++ b/drivers/ata/pata_pdc2027x.c
> @@ -295,7 +295,7 @@ static void pdc2027x_set_piomode(struct ata_port *ap, struct ata_device *adev)
>  	}
>  
>  	/* Set the PIO timing registers using value table for 133MHz */
> -	ata_port_dbg(ap, "Set pio regs... \n");
> +	ata_port_dbg(ap, "Set pio regs...\n");
>  
>  	ctcr0 = ioread32(dev_mmio(ap, adev, PDC_CTCR0));
>  	ctcr0 &= 0xffff0000;
> @@ -308,7 +308,7 @@ static void pdc2027x_set_piomode(struct ata_port *ap, struct ata_device *adev)
>  	ctcr1 |= (pdc2027x_pio_timing_tbl[pio].value2 << 24);
>  	iowrite32(ctcr1, dev_mmio(ap, adev, PDC_CTCR1));
>  
> -	ata_port_dbg(ap, "Set to pio mode[%u] \n", pio);
> +	ata_port_dbg(ap, "Set to pio mode[%u]\n", pio);
>  }
>  
>  /**
> @@ -341,7 +341,7 @@ static void pdc2027x_set_dmamode(struct ata_port *ap, struct ata_device *adev)
>  			iowrite32(ctcr1 & ~(1 << 7), dev_mmio(ap, adev, PDC_CTCR1));
>  		}
>  
> -		ata_port_dbg(ap, "Set udma regs... \n");
> +		ata_port_dbg(ap, "Set udma regs...\n");
>  
>  		ctcr1 = ioread32(dev_mmio(ap, adev, PDC_CTCR1));
>  		ctcr1 &= 0xff000000;
> @@ -350,14 +350,14 @@ static void pdc2027x_set_dmamode(struct ata_port *ap, struct ata_device *adev)
>  			(pdc2027x_udma_timing_tbl[udma_mode].value2 << 16);
>  		iowrite32(ctcr1, dev_mmio(ap, adev, PDC_CTCR1));
>  
> -		ata_port_dbg(ap, "Set to udma mode[%u] \n", udma_mode);
> +		ata_port_dbg(ap, "Set to udma mode[%u]\n", udma_mode);
>  
>  	} else  if ((dma_mode >= XFER_MW_DMA_0) &&
>  		   (dma_mode <= XFER_MW_DMA_2)) {
>  		/* Set the MDMA timing registers with value table for 133MHz */
>  		unsigned int mdma_mode = dma_mode & 0x07;
>  
> -		ata_port_dbg(ap, "Set mdma regs... \n");
> +		ata_port_dbg(ap, "Set mdma regs...\n");
>  		ctcr0 = ioread32(dev_mmio(ap, adev, PDC_CTCR0));
>  
>  		ctcr0 &= 0x0000ffff;
> @@ -366,7 +366,7 @@ static void pdc2027x_set_dmamode(struct ata_port *ap, struct ata_device *adev)
>  
>  		iowrite32(ctcr0, dev_mmio(ap, adev, PDC_CTCR0));
>  
> -		ata_port_dbg(ap, "Set to mdma mode[%u] \n", mdma_mode);
> +		ata_port_dbg(ap, "Set to mdma mode[%u]\n", mdma_mode);
>  	} else {
>  		ata_port_err(ap, "Unknown dma mode [%u] ignored\n", dma_mode);
>  	}


-- 
Damien Le Moal
Western Digital Research
