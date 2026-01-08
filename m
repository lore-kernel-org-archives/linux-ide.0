Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A661157A5A
	for <linux-ide@vger.kernel.org>; Thu,  8 Jan 2026 14:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767883695; cv=none; b=J6khFPSpPSgymeqpb71QW0J8VcP+T8zTCaGHlgh5fAsq2uYvj/as1kTZD0JlkI1YJN3G3VgI/7u26TUYpp1SGoN/5j/ccW4hd0vAT/e/AW4yWMIKJd5akDRfpcv5iiR+Uqj2w3qj1chy9E5Izc2VvLL9/yb60qolF7+2GHrap7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767883695; c=relaxed/simple;
	bh=okSr7KB7wYGt/GTALFn9mQ+tt5FVB1TxSaQJCgRnhEo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HQrSycYuXu8qbjQ5973d6wY7HvnSFuCD+264WU4M2uzHkBk2rr+dWoL5OJI+5IzuCP6tT8yfJ2W/GqFh8bDX6lYOO+cx6Lm4o+19zL0x0Igu+g/n2Z91PupdI+gnSR8/EVEsOIwt3Kp5bSu/dQugOeRkd0AZEAF5z7dzdLC9+po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ffe7yqhb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ffe7yqhb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6578FC116C6;
	Thu,  8 Jan 2026 14:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767883694;
	bh=okSr7KB7wYGt/GTALFn9mQ+tt5FVB1TxSaQJCgRnhEo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ffe7yqhb+ThPfweOQzOd0JutwUan+1IlhzuO9ZLlCTa5wbjltYTdat/pH3yfW6ohe
	 RCdGG0N8DiXMOtdewwo7bi50+ZOmA5mAfMkd7nDDMQEpkASp239+Vqto01RbZZ7CXQ
	 ruZLsShrR+U5k8ovMD1dexuQ7YPaHMzz99Q7n+HuAwIno/qcsGcl80Ln98ZXaRoSqs
	 rCDYf54VZy2Uaw+Y6KtA7ZHp0VXhbeYDZdMHV46gvWl+hjzQ5ROhx73YCFkHYG2wk8
	 4mTCkrhSLsMhMKDzE2xjHDQ+BXw8rSmCB/BmTLFrOl7hWDPW/8XIsmbjIEWh7RGFT2
	 rw4nRDvksk16Q==
Date: Thu, 8 Jan 2026 15:48:10 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org
Subject: Re: [PATCH] ata: libata: Advertize device support for DIPM and HIPM
 features for ATAPI
Message-ID: <aV_DqvnmcjoTXPKr@ryzen>
References: <20260108141234.2837566-2-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260108141234.2837566-2-cassel@kernel.org>

On Thu, Jan 08, 2026 at 03:12:34PM +0100, Niklas Cassel wrote:
> Commit b1f5af54f1f5 ("ata: libata-core: Advertize device support for DIPM
> and HIPM features") added prints if the device supports DIPM and HIPM,
> however, it forgot to update the same print for ATAPI devices.
> 
> Before changes:
> ata1.00: ATAPI: Slimtype DVD A  DU8AESH, 6C2M, max UDMA/133
> 
> After changes:
> ata1.00: ATAPI: Slimtype DVD A  DU8AESH, 6C2M, max UDMA/133 HIPM DIPM
> 
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Don't merge this.
I think I have a nicer way.


Kind regards,
Niklas

> ---
>  drivers/ata/libata-core.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index b96105481784..20d539730553 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -3143,11 +3143,13 @@ int ata_dev_configure(struct ata_device *dev)
>  		/* print device info to dmesg */
>  		if (print_info)
>  			ata_dev_info(dev,
> -				     "ATAPI: %s, %s, max %s%s%s%s\n",
> +				     "ATAPI: %s, %s, max %s%s%s%s%s%s\n",
>  				     modelbuf, fwrevbuf,
>  				     ata_mode_string(xfer_mask),
>  				     cdb_intr_string, atapi_an_string,
> -				     dma_dir_string);
> +				     dma_dir_string,
> +				     ata_id_has_hipm(dev->id) ? " HIPM" : "",
> +				     ata_id_has_dipm(dev->id) ? " DIPM" : "");
>  	}
>  
>  	/* determine max_sectors */
> -- 
> 2.52.0
> 
