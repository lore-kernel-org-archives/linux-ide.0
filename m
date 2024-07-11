Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6AD815ADAF;
	Thu, 11 Jul 2024 10:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720693467; cv=none; b=RZuA8kX4J4b75fzXQQT8v8RAQWb3KIdHsTHJb7G2lBRjwY7c4NsACcQCVkpJBs/qEbz+Jh4JwgzgShgQMIhOWFX3l8oNPpBg+S2nobHdEJF2WOI3+lJfCqb2y3n2qp5cCd42O4WPcIi/F6CcRvPFEAmDherVMPySVkYihB4gWlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720693467; c=relaxed/simple;
	bh=jWhtAUzEgmVZFeeYOSGdaSumDDb6FTyygsuBQNC+pjU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n96WQzhfR6n4z7rbpzJGe2xgzgX1rqy3XEUAGNqUzQplb/GhCenO/dv01cI65Yvqf9r/Y2rJ1qSFyshTe6T+lsIaHsWWA599I8trBEc9ydZ5iFQFWkJbiAC9bN9PCZ/XNB8LxupKagt/BSKDq8u7EvjyY5JH9GL7h1u+sHpIdoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rX8g/jvl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rX8g/jvl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A04F9C32786;
	Thu, 11 Jul 2024 10:24:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720693467;
	bh=jWhtAUzEgmVZFeeYOSGdaSumDDb6FTyygsuBQNC+pjU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=rX8g/jvlnX/6yWjPfnMHltlnf+iEzRRE4VEK/Aj4RR52c7WBFqYiZcspGoCbbEZe/
	 nP/19Y3bnvOtAi5Uxr/+b9c71i206wAYPn2V/fx3Fn8xovJU9z9E1U/9Joecqq4Hkg
	 KUKfggXrfnHJUYG3Kg/QDKDmSWDp1eadr+w2GoUklFHWs3jhZ7n1U7S34XRF9Om6r3
	 1KukoGzMXsypOv7eMYSxkpzA/V7S4vuOfCnVpkmCOcBI4z03aUL0AvRRUzy6QlLP9V
	 c+ixaccxPaIKuvW94AwvBAG2muZyJSiUhbb/D1j45Gk5UcIJUCxHll/WnBY61xuH2g
	 ICukaRfw+rXSg==
Message-ID: <92bf088a-ffb4-4b15-ab00-5718d5b3c0ae@kernel.org>
Date: Thu, 11 Jul 2024 19:24:24 +0900
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

[...]

>  static int imx8_sata_enable(struct ahci_host_priv *hpriv)
>  {
> -	u32 val, reg;
> -	int i, ret;
> +	u32 val;
> +	int ret;
>  	struct imx_ahci_priv *imxpriv = hpriv->plat_data;
>  	struct device *dev = &imxpriv->ahci_pdev->dev;
>  
> -	/* configure the hsio for sata */
> -	ret = clk_prepare_enable(imxpriv->phy_pclk0);
> -	if (ret < 0) {
> -		dev_err(dev, "can't enable phy_pclk0.\n");
> +	/*
> +	 * Since "REXT" pin is only present for first lane of i.MX8QM
> +	 * PHY, it's calibration results will be stored, passed

s/it's/its

> +	 * through second lane PHY, and shared with all three lane PHYs.

s/through/through to the

> +	 *
> +	 * Initialize the first two lane PHYs here, although only the
> +	 * third lane PHY is used by SATA.
> +	 */

-- 
Damien Le Moal
Western Digital Research

