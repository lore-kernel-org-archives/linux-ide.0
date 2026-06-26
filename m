Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E386F2EDD6C;
	Fri, 26 Jun 2026 11:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782472514; cv=none; b=r5zGnqlzYQOfcvKCScgJGf+QB8pIcqzvWjMfGWIxASp27ECMsy74KUaCQtPMAElZ0/uE/oXjf/ahvYZmICoIpZ9gjE55dTP1xA0Jj4E9uJEYljiBhVBH1tgf7qtxwVqyPc+wybQWAe3aGwYvw9YXf6qa5wdPoOnbINFXx9UHLYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782472514; c=relaxed/simple;
	bh=DN9WLZF6EdexeBBGOTnI1zZeY8bVKw3B/YXKHNO5xKs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UWUOEjmCjwj32aPlsF+8vKgmoVMXZ91L1pQgjNizFTCfoQdi2vtA1UTG1h69N2zv3sLsHbxwEPTla9AHrw226ZNEB5MLRX+6OYoX/CEBYtccdIPXQb+Ni7s8Hha9vA5qdow3wAcp7SMNVpIljEnfBCh60K/ZdS/o6ClJJb1ysMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BlB0+t3B; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BlB0+t3B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C0A11F000E9;
	Fri, 26 Jun 2026 11:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782472513;
	bh=e0LyXAZoKcaekBF2FmALBSowoBwtUYst4U0N0uB/imU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BlB0+t3BYOOXodGsh9dt401qI2r12enUapO7SZ69CLCtPQWGIiwe2PFznLFYqkt8M
	 cCOn8tgsS6gMRCwVqs2E6DxdhhA+XVPnJEIM2pgxrwz+ef5yJ1C0LEkjVgMr/2gh/3
	 ukxkO21nub5Pd4Z4zJIUxG3KPlY7z2TpyNAzFdXBWnssmA5gRkI0aW7RDn5DSHXD0G
	 sRkJh5WJReV4h4W25oonwU6f3RCZhj6LlvgJb0u857AjH7cDPRltpayjkRYnik93GN
	 bwUmzduHutX7YB7v64mxTL1GcKqOslNM3XZXVXp+wliUL93CH0RBzixt7imq0DK/wC
	 Iw0zbMC1zPo4A==
Date: Fri, 26 Jun 2026 13:15:09 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Myeonghun Pak <mhun512@gmail.com>
Cc: Linus Walleij <linusw@kernel.org>, Damien Le Moal <dlemoal@kernel.org>,
	linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ijae Kim <ae878000@gmail.com>
Subject: Re: [PATCH] ata: sata_gemini: unwind clocks on IDE pinctrl errors
Message-ID: <aj5fPZADwPCvDu3d@ryzen>
References: <20260626085848.40199-1-mhun512@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260626085848.40199-1-mhun512@gmail.com>

On Fri, Jun 26, 2026 at 05:58:37PM +0900, Myeonghun Pak wrote:
> gemini_sata_bridge_init() prepares and enables both SATA PCLKs, then
> disables them again while keeping the clocks prepared for later bridge
> start and stop operations. If gemini_setup_ide_pins() fails after that,
> gemini_sata_probe() returns directly and skips the existing
> out_unprep_clk unwind path.
> 
> Route the IDE pinctrl failure through out_unprep_clk so the clocks
> prepared by gemini_sata_bridge_init() are unprepared before probe
> fails.
> 
> Fixes: d872ced29d5f ("ata: sata_gemini: Introduce explicit IDE pin control")
> Co-developed-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
> ---
>  drivers/ata/sata_gemini.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/sata_gemini.c b/drivers/ata/sata_gemini.c
> index 582c9708275c..92984b34fd3b 100644
> --- a/drivers/ata/sata_gemini.c
> +++ b/drivers/ata/sata_gemini.c
> @@ -355,7 +355,7 @@ static int gemini_sata_probe(struct platform_device *pdev)
>  	if (sg->ide_pins) {
>  		ret = gemini_setup_ide_pins(dev);
>  		if (ret)
> -			return ret;
> +			goto out_unprep_clk;
>  	}
>  
>  	dev_info(dev, "set up the Gemini IDE/SATA nexus\n");
> -- 
> 2.47.1
> 

Reviewed-by: Niklas Cassel <cassel@kernel.org>
