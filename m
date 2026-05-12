Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77ADF395AF6;
	Tue, 12 May 2026 10:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778580984; cv=none; b=QPPQ0xK7mWLRqk/gjONmny/xQvS6TSTI6nsHbuSRUScdmIDe66W9xAcM32JUagerphIFJkgGoAZMqS+QMiJSNo/cAgFEUXv7Q+dcbhg9qwSQDV8pQDqeRQRy2daBaZpnrAg3Rk/T08df/i8OVeXc6YC6teZGBsm6+tkP9UaLqVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778580984; c=relaxed/simple;
	bh=4pF9k+UAkA7vibw9TQGKoW4s0o80NhgjPlh6QAtm3f0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HEv1F/acrMRsf72vlEyD4ki6odSejrP4r/4vmEQoa8mH1252Sr0fq0/7eyRPVAtenlZpcsb+CMQCQhuZokbOYT1yu0CTlodCaZ+CN6Uc5UUJ5BMBR4d3QDcvD+3t8Yv0Wsae1osTQSoSgqw2iMlPkXdmiXdrVXsKd/NzPZh9L9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HGh9sYKS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HGh9sYKS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEFE3C2BCB0;
	Tue, 12 May 2026 10:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778580984;
	bh=4pF9k+UAkA7vibw9TQGKoW4s0o80NhgjPlh6QAtm3f0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HGh9sYKSButGyYizj/HGVOGAEiLNdjO/Ke32uq7kRs815Vd3HlbUHds+QITxKet7I
	 yvn9GSd5KNvasliBxbPXyP00hTnke1tEv8jZbnSvYD2xwnTwGr69MvTkdPFGHKJUM/
	 /AF9SYON+JqQznxDug1Zu/eXlWDqpHh33XomxAUG3D0V194Io5bmPiclLZSqJXEQ6+
	 cZxO59HWickz0RMmh6MH1o79yVLqZi9xY9dUGDu59rvjfFAtEqCOK9+WyIfgfpb1C8
	 nBNEsOW2XTn9MXCb+B/PlkOHp20XuZhj2GmKxSSRhlKRU+BO6k6Nj5QbFgQQJC/c3L
	 TrHwy7VPrZkNw==
Date: Tue, 12 May 2026 12:16:20 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-ide@vger.kernel.org, Viresh Kumar <vireshk@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ata: pata_arasan_cf: simplify ioremap
Message-ID: <agL99NtOLX_4Y8qV@ryzen>
References: <20260510194607.9567-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260510194607.9567-1-rosenp@gmail.com>

On Sun, May 10, 2026 at 12:46:07PM -0700, Rosen Penev wrote:
> Use devm_platform_get_and_ioremap_resource() to combine
> platform_get_resource, request_mem_region, and ioremap.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  drivers/ata/pata_arasan_cf.c | 20 +++++---------------
>  1 file changed, 5 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/ata/pata_arasan_cf.c b/drivers/ata/pata_arasan_cf.c
> index b1e281b64f57..d5cb88ae2b76 100644
> --- a/drivers/ata/pata_arasan_cf.c
> +++ b/drivers/ata/pata_arasan_cf.c
> @@ -803,16 +803,6 @@ static int arasan_cf_probe(struct platform_device *pdev)
>  	irq_handler_t irq_handler = NULL;
>  	int ret;
>  
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	if (!res)
> -		return -EINVAL;
> -
> -	if (!devm_request_mem_region(&pdev->dev, res->start, resource_size(res),
> -				DRIVER_NAME)) {
> -		dev_warn(&pdev->dev, "Failed to get memory region resource\n");
> -		return -ENOENT;
> -	}
> -
>  	acdev = devm_kzalloc(&pdev->dev, sizeof(*acdev), GFP_KERNEL);
>  	if (!acdev)
>  		return -ENOMEM;
> @@ -836,14 +826,14 @@ static int arasan_cf_probe(struct platform_device *pdev)
>  		quirk |= CF_BROKEN_MWDMA | CF_BROKEN_UDMA;
>  	}
>  
> -	acdev->pbase = res->start;
> -	acdev->vbase = devm_ioremap(&pdev->dev, res->start,
> -			resource_size(res));
> -	if (!acdev->vbase) {
> +	acdev->vbase = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
> +	if (IS_ERR(acdev->vbase)) {
>  		dev_warn(&pdev->dev, "ioremap fail\n");

Please remove the dev_warn().

devm_platform_get_and_ioremap_resource() itself already prints an error
on failure.

Then since it will only be a single statement, you can also remove the
braces.


Kind regards,
Niklas


> -		return -ENOMEM;
> +		return PTR_ERR(acdev->vbase);
>  	}
>  
> +	acdev->pbase = res->start;
> +
>  	acdev->clk = devm_clk_get(&pdev->dev, NULL);
>  	if (IS_ERR(acdev->clk)) {
>  		dev_warn(&pdev->dev, "Clock not found\n");
> -- 
> 2.54.0
> 
