Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9938B2797AE;
	Wed, 20 Aug 2025 16:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755706063; cv=none; b=FjVJyiT4ecSzS+9wDKtc8HTn3GBpecPx6k34FuA7HhAf33DEQByfdehAUfJxRW0VqeMzQuyAl3Myt5wLCLwTAgxG6T0zLi6gCraxYSkbInJ2hvSX4iPS1LaJhYuBmdy4n+5sDHkOh/iHstyXH1GxVlbSVkGhFMFz62mLhvKuf84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755706063; c=relaxed/simple;
	bh=Fc6Djx8B9AyLUd9B+FppF5No5ax5Rsl2+whttkvW4ps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EGmM+UmvtRrRmZb2rMgA93OjM/nsNu7Kr/1N+jaXPk4JYM0+QLybXREW44+kutde7OmSqJd1TbcL6NOFtv3U09hOKf5DGFe2WnoCJu8fyVDYKFnm3i10yMkjtpnC9rczYc7WvlfcY3lvuBmVwcggtUUi2Z5YVlmtZERRUajnITo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SdYg4dng; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SdYg4dng"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39AFDC4CEE7;
	Wed, 20 Aug 2025 16:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755706062;
	bh=Fc6Djx8B9AyLUd9B+FppF5No5ax5Rsl2+whttkvW4ps=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SdYg4dng5SJPT6E+XjYcNIxfPAKCyJ9Ma7ZguYWwFhh2yhFJyMgyhP0ZH3aAicOxE
	 AtkAsPmudNikzTaA3UvB6/Yt2FgkUP2uVHPbyuh6irNEKtqmd6633yG0LXRA8xn7bf
	 FsbX17YAY5k08e+JpWuNuqedoEr+KzZ48UMqv4T60r+ct3FJ4hgCRmASxrwaHnX91t
	 UpwVtQT4NwEyibJfweA15QmoeCfpRLTBDIh1XXqbrc1n7m45ODBi/apkFF+dBcsCfH
	 gz6hdrGVbjIATtgoD88fmOVgB8Kl0W66znKJtOF/s3zDNgoxYEMQGt8wXgDFgbt+Cz
	 B1o+wU8Yb8/Bg==
Date: Wed, 20 Aug 2025 21:37:36 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Yulin Lu <luyulin@eswincomputing.com>
Cc: dlemoal@kernel.org, cassel@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, linux-ide@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	kishon@kernel.org, linux-phy@lists.infradead.org,
	ningyu@eswincomputing.com, zhengyu@eswincomputing.com,
	linmin@eswincomputing.com, huangyifeng@eswincomputing.com,
	fenglin@eswincomputing.com, lianghujun@eswincomputing.com
Subject: Re: [PATCH v2 3/3] phy: eswin: Create eswin directory and add
 EIC7700 SATA PHY driver
Message-ID: <aKXyyAT-xRPhoYDx@vaman>
References: <20250819134722.220-1-luyulin@eswincomputing.com>
 <20250819140043.1862-1-luyulin@eswincomputing.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250819140043.1862-1-luyulin@eswincomputing.com>

On 19-08-25, 22:00, Yulin Lu wrote:
> From: luyulin <luyulin@eswincomputing.com>
> 
> Created the eswin phy driver directory and added support for
> the SATA phy driver on the EIC7700 SoC platform.
> 
> Signed-off-by: luyulin <luyulin@eswincomputing.com>

Please use full name as you have used in the copyright notices


> +#define SATA_P0_PHY_TX_PREEMPH_GEN2	(0x05 << 8)
> +#define SATA_P0_PHY_TX_PREEMPH_GEN3	(0x08 << 16)
> +#define SATA_MPLL_MULTIPLIER		(0x3c << 16)

Use GENMASK for these

> +static int eic7700_sata_phy_init(struct phy *phy)
> +{
> +	struct eic7700_sata_phy *sata_phy = phy_get_drvdata(phy);
> +	u32 val = 0;
> +	int ret = 0;

both initializations are superfluous

> +static int eic7700_sata_phy_exit(struct phy *phy)
> +{
> +	struct eic7700_sata_phy *sata_phy = phy_get_drvdata(phy);
> +	u32 val = 0;

here and other places

> +static struct platform_driver eic7700_sata_phy_driver = {
> +	.probe	= eic7700_sata_phy_probe,
> +	.driver = {
> +		.of_match_table	= eic7700_sata_phy_of_match,
> +		.name  = "eswin,sata-phy",
> +		.suppress_bind_attrs = true,

why?

-- 
~Vinod
