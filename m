Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0BAD14F9E5;
	Thu, 11 Jul 2024 10:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720693346; cv=none; b=rUFvWRExDe0ZT5NWlSG8GWdLviEgOPCFbMRGWoa25wclJRlOuNQxSaMKMe8ldlB19wxzuzcAcjcioW7vk88b8V6o71CPd4/HbGatTRiEierCwwNyRzPEjncF8VQT3pwsU0pu3zOqn7OvT3twT/L/c/qUW6vqvGvUtKfCSw3yLQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720693346; c=relaxed/simple;
	bh=EyWzKZsfMO/99Gx/qMNlFvM30nWMnlAjusAD8RQXwQ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eDq0pvE3JxH8Hyl9K6kfLSygsIOi8t92EwBxzha3FVzXttTswCbUt1pwhwZnFNoCbaAefDH/nnc25EkWgKvW29GXmJK7ZERjOR8BTzk2Fw4zYv8Ty6+FmrKF/hE+e/KYW3Svo6HecfZsyYCKvzWZXeFu9miAs6cgkEuRSz3IUkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kl5jJqhB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kl5jJqhB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65D39C116B1;
	Thu, 11 Jul 2024 10:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720693346;
	bh=EyWzKZsfMO/99Gx/qMNlFvM30nWMnlAjusAD8RQXwQ4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Kl5jJqhBhTHW8QtePtDMuRT5zxJ2kzc1klnKTdYZpbVnH93KJqizGC8IHB4fLYonk
	 Hcmxe9EbfMcVTXyfN9xStZT3SxFPWXfQCLincHnAo6UKR0x4zttXieN5Cds8EFn4RY
	 k4h2gorWjKoFE71dg4PWRTtmE03daranfhvXJbuELRmXA5AUNVp/l3ZCXbzYsSc20D
	 7h4AfDaIKZBdfjDB7FdLp44qqypw7+SPHMlh3Wg1eeWshnxQQbyY5svIYVv9MjWOmq
	 1eNvDnbDAY0kXSKA6f4og6HrI3ooMXKYEtNcB2bnLRQZCMEc7EluBRTjFhtvOFoe8/
	 dvpbSnoGuLyng==
Message-ID: <e6b1c275-9a56-4b1b-becd-89a01cfb51c5@kernel.org>
Date: Thu, 11 Jul 2024 19:22:23 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/4] ata: ahci_imx: Clean up code by using i.MX8Q HSIO
 PHY driver
To: Richard Zhu <hongxing.zhu@nxp.com>, tj@kernel.org, cassel@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com
Cc: linux-ide@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 imx@lists.linux.dev, kernel@pengutronix.de
References: <1720685518-20190-1-git-send-email-hongxing.zhu@nxp.com>
 <1720685518-20190-3-git-send-email-hongxing.zhu@nxp.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <1720685518-20190-3-git-send-email-hongxing.zhu@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/11/24 17:11, Richard Zhu wrote:
> Clean up code by using PHY interface.
> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---


> +	ret = phy_init(imxpriv->cali_phy0);
> +	if (ret) {
> +		dev_err(dev, "cali PHY init failed\n");
>  		return ret;
>  	}
> -	ret = clk_prepare_enable(imxpriv->phy_pclk1);
> -	if (ret < 0) {
> -		dev_err(dev, "can't enable phy_pclk1.\n");
> -		goto disable_phy_pclk0;
> +	ret = phy_power_on(imxpriv->cali_phy0);
> +	if (ret) {
> +		dev_err(dev, "cali PHY power on failed\n");
> +		goto err_cali_phy0_power_on;

Very confusing lable name. "goto err_phy_exit;" would be better.

>  	}
> -	ret = clk_prepare_enable(imxpriv->epcs_tx_clk);
> -	if (ret < 0) {
> -		dev_err(dev, "can't enable epcs_tx_clk.\n");
> -		goto disable_phy_pclk1;
> +	ret = phy_init(imxpriv->cali_phy1);
> +	if (ret) {
> +		dev_err(dev, "cali PHY1 init failed\n");
> +		goto err_cali_phy1_init;

Same here. The usual thing to do is to have a label name descriptive of what is
going to be done at the label definition, so phy1 power off in this case. That
also corresponds to undoing the previous operation, which makes reading the code
and checking it less confusing.

>  	}
> -	ret = clk_prepare_enable(imxpriv->epcs_rx_clk);
> -	if (ret < 0) {
> -		dev_err(dev, "can't enable epcs_rx_clk.\n");
> -		goto disable_epcs_tx_clk;
> +	ret = phy_power_on(imxpriv->cali_phy1);
> +	if (ret) {
> +		dev_err(dev, "cali PHY1 power on failed\n");
> +		goto err_cali_phy1_power_on;

same here.

>  	}
> -	ret = clk_prepare_enable(imxpriv->phy_apbclk);
> -	if (ret < 0) {
> -		dev_err(dev, "can't enable phy_apbclk.\n");
> -		goto disable_epcs_rx_clk;
> +	ret = phy_init(imxpriv->sata_phy);
> +	if (ret) {
> +		dev_err(dev, "sata PHY init failed\n");
> +		goto err_sata_phy_init;

And here too. And many other labels after that.

[...]

> -	imxpriv->phy_apbclk = devm_clk_get(dev, "phy_apbclk");
> -	if (IS_ERR(imxpriv->phy_apbclk)) {
> -		dev_err(dev, "can't get phy_apbclk clock.\n");
> -		return PTR_ERR(imxpriv->phy_apbclk);
> +	if (!(dev->bus_dma_limit)) {
> +		dev->bus_dma_limit = DMA_BIT_MASK(32);
> +		dev_dbg(dev, "imx8qm sata only supports 32bit dma.\n");

I do not think this is a useful debug message.

>  	}
>  
> -	/* Fetch GPIO, then enable the external OSC */
> -	imxpriv->clkreq_gpiod = devm_gpiod_get_optional(dev, "clkreq",
> -				GPIOD_OUT_LOW | GPIOD_FLAGS_BIT_NONEXCLUSIVE);
> -	if (IS_ERR(imxpriv->clkreq_gpiod))
> -		return PTR_ERR(imxpriv->clkreq_gpiod);
> -	if (imxpriv->clkreq_gpiod)
> -		gpiod_set_consumer_name(imxpriv->clkreq_gpiod, "SATA CLKREQ");
> -
> +	imxpriv->sata_phy = devm_phy_get(dev, "sata-phy");
> +	if (IS_ERR(imxpriv->sata_phy))
> +		return dev_err_probe(dev, PTR_ERR(imxpriv->sata_phy),
> +				     "failed to get sata_phy\n");
> +
> +	imxpriv->cali_phy0 = devm_phy_get(dev, "cali-phy0");
> +	if (IS_ERR(imxpriv->cali_phy0))
> +		return dev_err_probe(dev, PTR_ERR(imxpriv->cali_phy0),
> +				     "failed to get cali_phy0\n");
> +	imxpriv->cali_phy1 = devm_phy_get(dev, "cali-phy1");
> +	if (IS_ERR(imxpriv->cali_phy1))
> +		return dev_err_probe(dev, PTR_ERR(imxpriv->cali_phy1),
> +				     "failed to get cali_phy1\n");
>  	return 0;
>  }
>  
> @@ -1077,12 +877,6 @@ static int imx_ahci_probe(struct platform_device *pdev)
>  		return PTR_ERR(imxpriv->sata_ref_clk);
>  	}
>  
> -	imxpriv->ahb_clk = devm_clk_get(dev, "ahb");
> -	if (IS_ERR(imxpriv->ahb_clk)) {
> -		dev_err(dev, "can't get ahb clock.\n");

s/can't/Failed to/

and drop the period.

> -		return PTR_ERR(imxpriv->ahb_clk);
> -	}
> -
>  	if (imxpriv->type == AHCI_IMX6Q || imxpriv->type == AHCI_IMX6QP) {
>  		u32 reg_value;
>  
> @@ -1142,11 +936,8 @@ static int imx_ahci_probe(struct platform_device *pdev)
>  		goto disable_clk;
>  
>  	/*
> -	 * Configure the HWINIT bits of the HOST_CAP and HOST_PORTS_IMPL,
> -	 * and IP vendor specific register IMX_TIMER1MS.
> -	 * Configure CAP_SSS (support stagered spin up).
> -	 * Implement the port0.
> -	 * Get the ahb clock rate, and configure the TIMER1MS register.
> +	 * Configure the HWINIT bits of the HOST_CAP and HOST_PORTS_IMPL.
> +	 * Set CAP_SSS (support stagered spin up) and Implement the port0.
>  	 */
>  	reg_val = readl(hpriv->mmio + HOST_CAP);
>  	if (!(reg_val & HOST_CAP_SSS)) {
> @@ -1159,8 +950,19 @@ static int imx_ahci_probe(struct platform_device *pdev)
>  		writel(reg_val, hpriv->mmio + HOST_PORTS_IMPL);
>  	}
>  
> -	reg_val = clk_get_rate(imxpriv->ahb_clk) / 1000;
> -	writel(reg_val, hpriv->mmio + IMX_TIMER1MS);
> +	if (imxpriv->type != AHCI_IMX8QM) {
> +		/*
> +		 * Get AHB clock rate and configure the vendor specified
> +		 * TIMER1MS register on i.MX53, i.MX6Q and i.MX6QP only.
> +		 */
> +		imxpriv->ahb_clk = devm_clk_get(dev, "ahb");
> +		if (IS_ERR(imxpriv->ahb_clk)) {
> +			dev_err(dev, "can't get ahb clock.\n");

Same here.

> +			goto disable_sata;
> +		}
> +		reg_val = clk_get_rate(imxpriv->ahb_clk) / 1000;
> +		writel(reg_val, hpriv->mmio + IMX_TIMER1MS);
> +	}
>  
>  	ret = ahci_platform_init_host(pdev, hpriv, &ahci_imx_port_info,
>  				      &ahci_platform_sht);

-- 
Damien Le Moal
Western Digital Research

