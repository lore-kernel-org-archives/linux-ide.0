Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CABB44BC9F;
	Mon, 28 Sep 2026 06:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790578302; cv=none; b=nO6Kr08JrBC/ht16x6gQSjHrz39sJTVrBaEw8fK0KPhfSBaBR677Wm+gPV5HPg1Gg+B9p89rOsG0Kg7KJ5XpxTFekEHi4zl8TizCnvWTVQQGUpG73ax5MxZwLptGTSmW2GGnjKS8GQZJkbHyTB8ffIQ8Lr23ExDvRSPbXx2yhCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790578302; c=relaxed/simple;
	bh=Ez0d4eOHHT61xFj2X/Pqm640K08kx2Nv1fnblcsLjZQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AAb5NbmaVogfzR14h898mxmLdNZk+4IIvxiHyF05iQpCY7gxVbwN4R+x9CWvpLcnrP6vJwJCKnLUYQEeMic6l9vfxEtjNDTSxq2m4o4VuZknMmNfFfCYcd2Suc17WTeLMQP2YMmwS9l7bESGZ4tcGWTztW2p3v6/kgt29LEOZd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=awNh6g4O; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="awNh6g4O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB2E91F000FF;
	Mon, 28 Sep 2026 06:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790578300;
	bh=6bvi0aJZpJvjo0wU2SIzdv09OOUt/sxLlLQUAkQgNOI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=awNh6g4OXoa1ED09pWBOW/Swdn62dQkiK9Rl/hmqvuYf+igytl1fwpP7vQgLaqz6b
	 zcwRoHpJOLhcpm9tWKd20yi8UFTQjEua4ov/zaT2nJxluw+jdrksHifTpedIUV6eCK
	 usSOzkprAKb7UtlT63DpL6NFK7CpEC6Mz0SJhzDiWPxSzvOZHBass9nIXD/sHAlrae
	 cJdfRaExGPDQsMYeO25qC0Yvc/lpA/fOe7IV5yAaDhwSjJTEgE8fJHheW1EzRvI9fG
	 TFC93+oF5UZVR6EF9kgqTOoFnezkUhiZdmjl6dRqDuGLSSp+IGhJxhGQtLzgXuuN0Q
	 f5YzxRlzt2I3Q==
Message-ID: <c30d0b74-c133-40f8-970a-e15566507820@kernel.org>
Date: Mon, 28 Sep 2026 08:51:38 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ata: sata_mv: enable SoC SATA LED presence indication
To: Carlos Junior <cjuniorfox@gmail.com>
Cc: cassel@kernel.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260925193134.114566-1-cjuniorfox@gmail.com>
 <20260925212823.121415-1-cjuniorfox@gmail.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20260925212823.121415-1-cjuniorfox@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026/09/25 23:28, Carlos Junior wrote:
> Enable the SoC SATA LED controller in mv_soc_enable_leds().
> 
> Set the LED controller enable and device presence multiplexing bits
> in the SoC SATA host-controller register. This enables SATA device
> presence indication on boards using the SoC SATA controller.
> 
> Signed-off-by: Carlos Junior <cjuniorfox@gmail.com>
> ---
> Changes in v2:
> - Do not initialize the SoC SATA LED blink bit; leave it to the
>   existing NCQ LED blink handling.
> 
>  drivers/ata/sata_mv.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
> index d260f04e6..52e33485b 100644
> --- a/drivers/ata/sata_mv.c
> +++ b/drivers/ata/sata_mv.c
> @@ -252,6 +252,7 @@ enum {
>  	SOC_LED_CTRL_BLINK	= (1 << 0),	/* Active LED blink */
>  	SOC_LED_CTRL_ACT_PRESENCE = (1 << 2),	/* Multiplex dev presence */
>  						/*  with dev activity LED */
> +	SOC_LED_CTRL_ENABLE	= (1 << 3),	/* Enable SATA LED control */
>  
>  	/* Shadow block registers */
>  	SHD_BLK			= 0x100,
> @@ -3382,12 +3383,20 @@ static void mv6_phy_errata(struct mv_host_priv *hpriv, void __iomem *mmio,
>  	writel(m2, port_mmio + PHY_MODE2);
>  }
>  
> -/* TODO: use the generic LED interface to configure the SATA Presence */
> -/* & Acitivy LEDs on the board */
> +/*
> + * Enable the SoC SATA LED controller and device presence
> + * indication on the board's SATA LEDs.
> + */
>  static void mv_soc_enable_leds(struct mv_host_priv *hpriv,
>  				      void __iomem *mmio)
>  {
> -	return;
> +	void __iomem *hc_mmio;
> +
> +	hc_mmio = mv_hc_base(mmio, 0);

This can be done in a single line with the declaration of the variable:

	void __iomem *hc_mmio = mv_hc_base(mmio, 0);

> +
> +	writel(SOC_LED_CTRL_ENABLE |
> +		SOC_LED_CTRL_ACT_PRESENCE,

No need to have this on 2 lines:

	writel(SOC_LED_CTRL_ENABLE | SOC_LED_CTRL_ACT_PRESENCE,
	       hc_mmio + SOC_LED_CTRL);

is nicer. And you can also get rid of the local variable:

	writel(SOC_LED_CTRL_ENABLE | SOC_LED_CTRL_ACT_PRESENCE,
	       mv_hc_base(mmio, 0) + SOC_LED_CTRL);

But if you prefer keeping the variable for readability, that's fine too.

With these nits fixed, feel free to add:

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

> +		hc_mmio + SOC_LED_CTRL);
>  }
>  
>  static void mv_soc_read_preamp(struct mv_host_priv *hpriv, int idx,


-- 
Damien Le Moal
Western Digital Research
