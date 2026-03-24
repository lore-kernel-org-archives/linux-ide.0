Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ABBB3C13FF;
	Tue, 24 Mar 2026 22:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774390257; cv=none; b=DihWTBz7fDfLwRwqtcXFzlU261oiaiYWI1+EW7LjbMTksZioDYNB5mwn5CYBPNCtmAh/qJf8ev5sBkOSG3G4FQH90lOzsVxVE0Zgp5bwjzOZgDcvUHluo2ZiZYWjtAu7W7FnvIlL3RCRxy+t6QmNbUgSMRR/8BABbitt2S8+CYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774390257; c=relaxed/simple;
	bh=+kehYrYV5udI79UZsWv7ehxJx9W8hKs0w0BfEAayIRI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q9f3Wb7FQPZ3yo0uFmqWG3UkMTTHRU5xmgdDoULSxjAWoS8ozQN5Yp2xtNnfM0jEBR3EuaNPkcuVVoFFh0MMKEdYLnbYrdtFhtOpuBuaH73KigARhBRQfhUWpJT1xNeDq/UKAhIZKg8o9Wa5K5jgmBcDNIk+7zYHiwRoBJvQa54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uY1VaRdV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uY1VaRdV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C3D7C2BCB1;
	Tue, 24 Mar 2026 22:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774390256;
	bh=+kehYrYV5udI79UZsWv7ehxJx9W8hKs0w0BfEAayIRI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=uY1VaRdVZCIt15Gt+rKiGi/CFuAnyA5Lf61/KvONN48uuWE1zQEZ2QppektWO7Eux
	 gEyZzFOMnxJHLbSSPtJrVZx0bH0vHGcJAybzOjhlVEPfgRpQTu/mMFOHhoGv2q/vzf
	 Q9aPh2FK+R7Zy1iiVE+oGK5NCGpD/9JKF916hYCwwKHUQBJUinqTHfkrGPZdIABTdl
	 7C4qSY4ihvLMz7zyPUFMygQgP4amUJ0Cdo6YWgd84pWltL5hR0pc2yeEDFGYRhRK/n
	 DkpvS6ZbkxgYCZPwWU7ddbVV+q/8SoS5RogVF60ebTRloGO7VEV1srDbqVIOL6DPKB
	 jVxbTi29UQDCw==
Message-ID: <a27f4314-f7dc-445d-ae24-909ac6b45b5e@kernel.org>
Date: Tue, 24 Mar 2026 15:10:50 -0700
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: ahci_tegra: remove kcalloc
To: Rosen Penev <rosenp@gmail.com>, linux-ide@vger.kernel.org
Cc: Niklas Cassel <cassel@kernel.org>,
 Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 "open list:TEGRA ARCHITECTURE SUPPORT" <linux-tegra@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20260324211629.26924-1-rosenp@gmail.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260324211629.26924-1-rosenp@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026/03/24 14:16, Rosen Penev wrote:
> Combine allocations into one by using a flexible array member.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  drivers/ata/ahci_tegra.c | 15 ++++++---------
>  1 file changed, 6 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/ata/ahci_tegra.c b/drivers/ata/ahci_tegra.c
> index 44584eed6374..5972fe04ff3f 100644
> --- a/drivers/ata/ahci_tegra.c
> +++ b/drivers/ata/ahci_tegra.c
> @@ -175,8 +175,9 @@ struct tegra_ahci_priv {
>  	struct reset_control	   *sata_cold_rst;
>  	/* Needs special handling, cannot use ahci_platform */
>  	struct clk		   *sata_clk;
> -	struct regulator_bulk_data *supplies;
>  	const struct tegra_ahci_soc *soc;
> +
> +	struct regulator_bulk_data supplies[];

I think this needs a __counted_by() annotation, but not sure if that is possible
given that soc->num_supplies is not in this structure. Might need a copy of it.

>  };
>  
>  static void tegra_ahci_handle_quirks(struct ahci_host_priv *hpriv)
> @@ -512,6 +513,7 @@ static const struct scsi_host_template ahci_platform_sht = {
>  
>  static int tegra_ahci_probe(struct platform_device *pdev)
>  {
> +	const struct tegra_ahci_soc *soc;
>  	struct ahci_host_priv *hpriv;
>  	struct tegra_ahci_priv *tegra;
>  	struct resource *res;
> @@ -521,14 +523,15 @@ static int tegra_ahci_probe(struct platform_device *pdev)
>  	if (IS_ERR(hpriv))
>  		return PTR_ERR(hpriv);
>  
> -	tegra = devm_kzalloc(&pdev->dev, sizeof(*tegra), GFP_KERNEL);
> +	soc = of_device_get_match_data(&pdev->dev);
> +	tegra = devm_kzalloc(&pdev->dev, struct_size(tegra, supplies, soc->num_supplies), GFP_KERNEL);
>  	if (!tegra)
>  		return -ENOMEM;
>  
>  	hpriv->plat_data = tegra;
>  
>  	tegra->pdev = pdev;
> -	tegra->soc = of_device_get_match_data(&pdev->dev);
> +	tegra->soc = soc;
>  
>  	tegra->sata_regs = devm_platform_ioremap_resource(pdev, 1);
>  	if (IS_ERR(tegra->sata_regs))
> @@ -571,12 +574,6 @@ static int tegra_ahci_probe(struct platform_device *pdev)
>  		return PTR_ERR(tegra->sata_clk);
>  	}
>  
> -	tegra->supplies = devm_kcalloc(&pdev->dev,
> -				       tegra->soc->num_supplies,
> -				       sizeof(*tegra->supplies), GFP_KERNEL);
> -	if (!tegra->supplies)
> -		return -ENOMEM;
> -
>  	regulator_bulk_set_supply_names(tegra->supplies,
>  					tegra->soc->supply_names,
>  					tegra->soc->num_supplies);


-- 
Damien Le Moal
Western Digital Research
