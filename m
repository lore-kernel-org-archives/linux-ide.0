Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A9113B58D
	for <linux-ide@vger.kernel.org>; Tue,  7 Jan 2025 10:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736245496; cv=none; b=irMBQHIMVTI03BzqE/mEt0CDMwMF5K9HszumP7Q5YJYn7ZhcEX+ZzNCYvuR0Ye+/yK5r72/sZTwJ49UxgtUxl/cZ3rA88emAWJuRmWENaSQXkAYV3poD3r0PAR7FhfpKmfOG9seennGEFsfLi/suNgKz3XR2AjzOrvFQcFMCc6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736245496; c=relaxed/simple;
	bh=0xRBoxJdN0lYVZzD4Qb98f14OfIiv1xEe+bM1oSsRDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K4Rq+7k9eFM8mi9e6fESXWovpzQmA+tqQeOMSLZ0ZvP+g35Zu8jN6ZG8MS4suN0hTcvAKJXcns3NH/fBk0Bl3JOpp8S8FK7XDAUCG/nlfDntIsBLXGW7IbuniMsQ6bQ7ZYEthtN8sSEHSQJL1dAFUZjWZ4RIP1fN+UKBw/hsq5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HeMlEOw7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HeMlEOw7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59E9CC4CED6;
	Tue,  7 Jan 2025 10:24:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736245496;
	bh=0xRBoxJdN0lYVZzD4Qb98f14OfIiv1xEe+bM1oSsRDI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HeMlEOw7vn8lPGvhYLi82SHCfeaJ5QEA53SMKGBj4mTartTDfIrDc+IWL6kc6NPNH
	 X38ktDU7ceALQo/uFpGDmjOnATM1v3DWsrM8nU28uQGSU7WR7YfYLnjsQzCV5T9jIh
	 HobVq5LW2T80Kbqb/EBKlqX/da0RTPsnMVuFmjEwiMcdF/P06LyOVgE6h+RucN5EhB
	 gjtFYhZaCf6dGbAXvP/xcsd93hpmJT1OZrObCnAhZsk3nWLRXDttZIt5H2LtXDJNN7
	 +S/a/Ky4Dgg7L//CMsO6Ofh9rqKnXPOrvkeWudwH5/Hf++RB9itHhkAqXeT0b1icLf
	 43VuHbgt0ZYEQ==
Date: Tue, 7 Jan 2025 11:24:52 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org
Subject: Re: [PATCH] ahci: Introduce ahci_ignore_port() helper
Message-ID: <Z30A9OL8RInlg_Tn@ryzen>
References: <20250106052701.47246-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250106052701.47246-1-dlemoal@kernel.org>

On Mon, Jan 06, 2025 at 02:27:01PM +0900, Damien Le Moal wrote:
> libahci and AHCI drivers may ignore some ports if the port is invalid
> (its ID does not correspond to a valid physical port) or if the user
> explicitly requested the port to be ignored with the mask_port_map
> ahci module parameter. Such port that shall be ignored can be identified
> by checking that the bit corresponding to the port ID is not set in the
> mask_port_map field of struct ahci_host_priv. E.g. code such as:
> "if (!(hpriv->mask_port_map & (1 << portid)))".
> 
> Replace all direct use of the mask_port_map field to detect such port
> with the new helper inline function ahci_ignore_port() to make the code
> more readable/easier to understand.
> 
> The comment describing the mask_port_map field of struct ahci_host_priv
> is also updated to be more accurate.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>  drivers/ata/ahci.h             | 13 ++++++++++++-
>  drivers/ata/ahci_brcm.c        |  2 +-
>  drivers/ata/ahci_ceva.c        |  4 ++--
>  drivers/ata/libahci_platform.c |  6 +++---
>  4 files changed, 18 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
> index 8f40f75ba08c..aea30df50c58 100644
> --- a/drivers/ata/ahci.h
> +++ b/drivers/ata/ahci.h
> @@ -328,7 +328,7 @@ struct ahci_port_priv {
>  struct ahci_host_priv {
>  	/* Input fields */
>  	unsigned int		flags;		/* AHCI_HFLAG_* */
> -	u32			mask_port_map;	/* mask out particular bits */
> +	u32			mask_port_map;	/* Mask of valid ports */
>  
>  	void __iomem *		mmio;		/* bus-independent mem map */
>  	u32			cap;		/* cap to use */
> @@ -379,6 +379,17 @@ struct ahci_host_priv {
>  						  int port);
>  };
>  
> +/*
> + * Return true if a port should be ignored because it is excluded from
> + * the host port map.
> + */
> +static inline bool ahci_ignore_port(struct ahci_host_priv *hpriv,
> +				    unsigned int portid)
> +{
> +	return portid >= hpriv->nports ||
> +		!(hpriv->mask_port_map & (1 << portid));
> +}
> +
>  extern int ahci_ignore_sss;
>  
>  extern const struct attribute_group *ahci_shost_groups[];
> diff --git a/drivers/ata/ahci_brcm.c b/drivers/ata/ahci_brcm.c
> index 24c471b485ab..29be74fedcf0 100644
> --- a/drivers/ata/ahci_brcm.c
> +++ b/drivers/ata/ahci_brcm.c
> @@ -288,7 +288,7 @@ static unsigned int brcm_ahci_read_id(struct ata_device *dev,
>  
>  	/* Re-initialize and calibrate the PHY */
>  	for (i = 0; i < hpriv->nports; i++) {
> -		if (!(hpriv->mask_port_map & (1 << i)))
> +		if (ahci_ignore_port(hpriv, i))
>  			continue;
>  
>  		rc = phy_init(hpriv->phys[i]);
> diff --git a/drivers/ata/ahci_ceva.c b/drivers/ata/ahci_ceva.c
> index f2e20ed11ec7..2d6a08c23d6a 100644
> --- a/drivers/ata/ahci_ceva.c
> +++ b/drivers/ata/ahci_ceva.c
> @@ -206,7 +206,7 @@ static int ceva_ahci_platform_enable_resources(struct ahci_host_priv *hpriv)
>  		goto disable_clks;
>  
>  	for (i = 0; i < hpriv->nports; i++) {
> -		if (!(hpriv->mask_port_map & (1 << i)))
> +		if (ahci_ignore_port(hpriv, i))
>  			continue;
>  
>  		rc = phy_init(hpriv->phys[i]);
> @@ -218,7 +218,7 @@ static int ceva_ahci_platform_enable_resources(struct ahci_host_priv *hpriv)
>  	ahci_platform_deassert_rsts(hpriv);
>  
>  	for (i = 0; i < hpriv->nports; i++) {
> -		if (!(hpriv->mask_port_map & (1 << i)))
> +		if (ahci_ignore_port(hpriv, i))
>  			continue;
>  
>  		rc = phy_power_on(hpriv->phys[i]);
> diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
> index b68777841f7a..53b2c7719dc5 100644
> --- a/drivers/ata/libahci_platform.c
> +++ b/drivers/ata/libahci_platform.c
> @@ -49,7 +49,7 @@ int ahci_platform_enable_phys(struct ahci_host_priv *hpriv)
>  	int rc, i;
>  
>  	for (i = 0; i < hpriv->nports; i++) {
> -		if (!(hpriv->mask_port_map & (1 << i)))
> +		if (ahci_ignore_port(hpriv, i))
>  			continue;
>  
>  		rc = phy_init(hpriv->phys[i]);
> @@ -73,7 +73,7 @@ int ahci_platform_enable_phys(struct ahci_host_priv *hpriv)
>  
>  disable_phys:
>  	while (--i >= 0) {
> -		if (!(hpriv->mask_port_map & (1 << i)))
> +		if (ahci_ignore_port(hpriv, i))
>  			continue;
>  
>  		phy_power_off(hpriv->phys[i]);
> @@ -94,7 +94,7 @@ void ahci_platform_disable_phys(struct ahci_host_priv *hpriv)
>  	int i;
>  
>  	for (i = 0; i < hpriv->nports; i++) {
> -		if (!(hpriv->mask_port_map & (1 << i)))
> +		if (ahci_ignore_port(hpriv, i))
>  			continue;
>  
>  		phy_power_off(hpriv->phys[i]);
> -- 
> 2.47.1
> 

Reviewed-by: Niklas Cassel <cassel@kernel.org>
