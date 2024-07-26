Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3506F1EF01
	for <linux-ide@vger.kernel.org>; Fri, 26 Jul 2024 11:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721992424; cv=none; b=NWvjEI24fo3A5JiSKsGfEE/FjTl8Pq36EGzvQGxdf3fgypNSjzKgXaMbHqisD6HcR89zc48ut05qSAZ2KFifhN+tHptWynaHJa684YvAtg/+KjCYJ0bCGVtv3IUTmD06QzDGVTh6olf1Oa/0QrFZX0yKIEaOHbK8+tCkIjCSsgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721992424; c=relaxed/simple;
	bh=Kf8PFMOmMTvfBzO0Y/IvUSOzZbafaaE/o4RzP2ffGBY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X9OTatsigfYFAR1JBix7B/E1yg6KBMGLf3z+QPMwMVd29miCYo16O4lLofIQlSHp+K2XIobMUD3uLDR6ReVPHocer/wk2ScosaibdKGgRSlHEwoLVF6nR4e1U/1mvepvUqMTqnV7kM5zfx2FdMUQsU9cJLxKi3ByS3rTioNfi8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tx4H6kmC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tx4H6kmC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FFDEC4AF09;
	Fri, 26 Jul 2024 11:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721992423;
	bh=Kf8PFMOmMTvfBzO0Y/IvUSOzZbafaaE/o4RzP2ffGBY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Tx4H6kmCEqeS0IwDqd1jlX4vkUVhSl+t+BndI5Aru0JtS4nPbWliHcimGqjA95vDY
	 wH62Yg2Gfk61UdNrGpX/mhQCwIBk97tubfSjFiF7qhI4eZtvtK2hLawD46X68fzaj/
	 K5B+pdt6Bh+rkMaqID0ElR923J7MYzOeHOgNnjOI5fgTiQ7udIcxl8qKMWsqXo8P+W
	 twOb1GJjxONkbbyGUiZJgcotq+MtjfhN9gxJVfgv8piTACC7dooDqmg8FELp3IB6I4
	 7ycSYf4+UUvv3UcJv/DGKFqr0gw7SHTZrhLJjZe04BCNKT9EEKcbz6Zl2r0m7X+5rm
	 0a99OLunTKqtA==
Date: Fri, 26 Jul 2024 13:13:40 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org
Subject: Re: [PATCH v6 10/11] ata: pata_hpt366: Rename hpt_dma_blacklisted()
Message-ID: <ZqOE5JaOe5DLcRgp@ryzen.lan>
References: <20240726031954.566882-1-dlemoal@kernel.org>
 <20240726031954.566882-11-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240726031954.566882-11-dlemoal@kernel.org>

On Fri, Jul 26, 2024 at 12:19:53PM +0900, Damien Le Moal wrote:
> Rename the function hpt_dma_blacklisted() to the more neutral
> hpt_dma_broken().
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>  drivers/ata/pata_hpt366.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/ata/pata_hpt366.c b/drivers/ata/pata_hpt366.c
> index bdccd1ba1524..5280e9960025 100644
> --- a/drivers/ata/pata_hpt366.c
> +++ b/drivers/ata/pata_hpt366.c
> @@ -170,8 +170,8 @@ static const char * const bad_ata66_3[] = {
>  	NULL
>  };
>  
> -static int hpt_dma_blacklisted(const struct ata_device *dev, char *modestr,
> -			       const char * const list[])
> +static int hpt_dma_broken(const struct ata_device *dev, char *modestr,
> +			  const char * const list[])
>  {
>  	unsigned char model_num[ATA_ID_PROD_LEN + 1];
>  	int i;
> @@ -197,11 +197,11 @@ static int hpt_dma_blacklisted(const struct ata_device *dev, char *modestr,
>  static unsigned int hpt366_filter(struct ata_device *adev, unsigned int mask)
>  {
>  	if (adev->class == ATA_DEV_ATA) {
> -		if (hpt_dma_blacklisted(adev, "UDMA",  bad_ata33))
> +		if (hpt_dma_broken(adev, "UDMA",  bad_ata33))
>  			mask &= ~ATA_MASK_UDMA;
> -		if (hpt_dma_blacklisted(adev, "UDMA3", bad_ata66_3))
> +		if (hpt_dma_broken(adev, "UDMA3", bad_ata66_3))
>  			mask &= ~(0xF8 << ATA_SHIFT_UDMA);
> -		if (hpt_dma_blacklisted(adev, "UDMA4", bad_ata66_4))
> +		if (hpt_dma_broken(adev, "UDMA4", bad_ata66_4))
>  			mask &= ~(0xF0 << ATA_SHIFT_UDMA);
>  	} else if (adev->class == ATA_DEV_ATAPI)
>  		mask &= ~(ATA_MASK_MWDMA | ATA_MASK_UDMA);
> -- 
> 2.45.2
> 

Reviewed-by: Niklas Cassel <cassel@kernel.org>
