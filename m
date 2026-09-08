Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D55478859
	for <linux-ide@vger.kernel.org>; Tue,  8 Sep 2026 09:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788860331; cv=none; b=ZNBd6DJ1PF+NniptawZCysOosqHY058/mHNthYpR8YS2/e2C1+7bOvbfkYBLZhqgEoBfadt+HjaiZjQDzL/J/dJhg6ft4Ug9rPM5uTxRg1FveA2swvpVoDqpaoC7k00rbpcJ1MKaUbIgUX/X/4WLi2QAunyNFWEffisBbTlQBAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788860331; c=relaxed/simple;
	bh=YBT29ZsGaLNgPYWWXymQ/228mtDYhD9Ci2acJD52ogo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uKYn1VufSGdopJFcdqJ8lbOLbG+paD3T3IoTSqll1AsQO2cNfSBF1KRNChBVm0ycWBT5PVnVq2NkYDh3RdB5gFSKXgGwP3PHVcVYlHq7O1oBZNyvHOq56ZsO4O45r6b0udc/fvgFYq0JY0sdaiuiqSw5DeWiigjGT4LYPAF5NQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dgDDKCVS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dgDDKCVS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF9AA1F00A3A;
	Tue,  8 Sep 2026 09:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788860329;
	bh=rg+b8wv3ZmV6/16yQXX+3ZgsjysAHycVYreNBRGRtO8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dgDDKCVSNS7v/CjrE0onq6AykY2R+eaaht5Hi7tBcwiw30yVHI8aTeHIfQc9cLTTv
	 n3FvXEQjENbNXLaBqW9wRigg/r17+hsv7TD4SFWXf6/9d/GhKWGxOG+yLsqZjecFSV
	 KFYSLs78mjLqRTnH7x2dcvgGFT8JdjhPNPJJB0HTj4z564Xo7+xGheqLv8ea9JnhlV
	 +AkBWBn0y9vUYDk+hr/tzoqNoVJcjqupgiz71t9UDNBpT8CgMfeAnnl1SjxJKpMWJl
	 XoKX7BFr0OBsF/caFkklcSLHRHCwDEr3R+M62WYFxv0NK1ms1vUkmEkZiHXpqpHSdc
	 tEB2UqDwjNXqw==
Date: Tue, 8 Sep 2026 11:38:46 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Li Jun <lijun01@kylinos.cn>
Cc: dlemoal@kernel.org, linux-ide@vger.kernel.org
Subject: Re: [PATCH v4] ata: ahci_da850: switch to DEFINE_SIMPLE_DEV_PM_OPS
Message-ID: <ap_Xplv4nXb5SsxY@ryzen>
References: <20260908090936.1961634-1-lijun01@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260908090936.1961634-1-lijun01@kylinos.cn>

On Tue, Sep 08, 2026 at 05:09:36PM +0800, Li Jun wrote:
> Replace the deprecated SIMPLE_DEV_PM_OPS macro with the recommended
> DEFINE_SIMPLE_DEV_PM_OPS. Use pm_ptr(&ahci_da850_pm_ops) to complete
> the API migration and allow the structure to be correctly dropped
> when CONFIG_PM=n.
> 
> Signed-off-by: Li Jun <lijun01@kylinos.cn>
> Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
> ---
> changelogs:
> -add pm_ptr for ahci_da850_pm_ops in ahci_da850_driver.
> -revise grammar and alignment issues.
> -Align parentheses
> ---
>  drivers/ata/ahci_da850.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/ata/ahci_da850.c b/drivers/ata/ahci_da850.c
> index 4e53ff96d712..febebf713748 100644
> --- a/drivers/ata/ahci_da850.c
> +++ b/drivers/ata/ahci_da850.c
> @@ -218,8 +218,8 @@ static int ahci_da850_probe(struct platform_device *pdev)
>  	return rc;
>  }
>  
> -static SIMPLE_DEV_PM_OPS(ahci_da850_pm_ops, ahci_platform_suspend,
> -			 ahci_platform_resume);
> +static DEFINE_SIMPLE_DEV_PM_OPS(ahci_da850_pm_ops, ahci_platform_suspend,
> +				ahci_platform_resume);
>  
>  static const struct of_device_id ahci_da850_of_match[] = {
>  	{ .compatible = "ti,da850-ahci", },
> @@ -233,7 +233,7 @@ static struct platform_driver ahci_da850_driver = {
>  	.driver = {
>  		.name = DRV_NAME,
>  		.of_match_table = ahci_da850_of_match,
> -		.pm = &ahci_da850_pm_ops,
> +		.pm = pm_ptr(&ahci_da850_pm_ops),

pm_ptr() is for drivers implementing Runtime PM or a mix of
runtime and sleep PM.

The proper macro seems to be to use pm_sleep_ptr() for drivers
only implementing system sleep callbacks (suspend/resume).

See e.g.
408ba1d06ee1 ("spi: bcm63xx-hsspi: use modern PM macros")
65172b5d381a ("spi: dw-pci: use modern PM macros")


Kind regards,
Niklas
