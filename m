Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A126334575D;
	Tue,  9 Jun 2026 07:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780989640; cv=none; b=sAOGWOuiO42lu4iXgd9iqAlW5IDfeBn+1VwXIDA/YW9WFz3MoF/AiTwgFVK750JCjIEQIKBn3ia4fE393SKQG2B48DbtmPr1WTSqAKjc02SvcwDta6otP2PBCw1m/wGOG3kKxLCu/FYXKb1xoMRtumhz1ijEct3a6nttk7MEbw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780989640; c=relaxed/simple;
	bh=jRG4wKuC9DkIkKkgivVeOIVbVifVOCUzIzr6pjp11mo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mOibfujPh0aslti7ntWFfTa46VNK/Y4xYvxL0bUOx/lcY9tDm8QE/5DklcRUdTm5xD6uK/oxdwCs2vrrk4JiCTUvHx15WOpaTgvzGRvSE2s+NisA1A9a/LdaBtCfliA07cN5JhMO5dxCOLc5TrNkXlMhXxcPfHoHVJ8AxqIw1Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kYBk0RDO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kYBk0RDO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D35B91F00898;
	Tue,  9 Jun 2026 07:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780989639;
	bh=vFwYFkE4sPS10jMX8K8GhftfeH3DxNryadpr84Oj9UQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kYBk0RDOFyTFW4XtxR7BVZGIJLOQsbiTnujKmSua1xEQ7hZbUXG8cFPTcjQjY4Edq
	 qhEz1SDAD1PdqPmhZZyufeTxNozIM0qHwJdu5LY/ahID85MZE89oJ6tEq+08IXNhSG
	 +IfIhjJTPj3VS2cltBA2qzk+ZOEkjuiyyZX+uxFbTDhDZJnYW2qhZy8dgk6cZgCP5Z
	 Y2OGbtfWn30OXwcQAagbAWPpkoVk9TMhdjoYWkX/OOG5lVIntQsrVi6Q0sG1Ie5Ia6
	 VZda/7wUxYhxx0qhcx4HgGp1xMZJI+ty/DRDlE/pB2uMiYaG9QB/LkEReJ+LXDIN2e
	 j7mXq7hRwhCMg==
Date: Tue, 9 Jun 2026 09:20:35 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Rosen Penev <rosenp@gmail.com>, Andy Shevchenko <andy@kernel.org>
Cc: linux-ide@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>,
	Julia Lawall <Julia.Lawall@lip6.fr>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/4] ata: pata_mpc52xx: switch to non-devm request_irq
 for proper ordering
Message-ID: <aie-w7BTHYYwTKvq@ryzen>
References: <20260608214718.49503-1-rosenp@gmail.com>
 <20260608214718.49503-2-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260608214718.49503-2-rosenp@gmail.com>

On Mon, Jun 08, 2026 at 02:47:15PM -0700, Rosen Penev wrote:
> The BestComm task IRQ handler accesses priv->dmatsk, which is freed
> by bcom_ata_release().  With devm_request_irq(), the handler remains
> registered until devres unwinds after the error/remove function
> returns, creating a window where the handler can access freed memory.
> 
> Switch to request_irq() / free_irq() so that the interrupt is
> unregistered before bcom_ata_release() tears down the task.
> 
> Assisted-by: opencode:big-pickle
> Fixes: d01159dffa15 ("drivers/ata/pata_mpc52xx.c: clean up error handling code")
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  drivers/ata/pata_mpc52xx.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/ata/pata_mpc52xx.c b/drivers/ata/pata_mpc52xx.c
> index 210a63283f62..9af0aa89a5c6 100644
> --- a/drivers/ata/pata_mpc52xx.c
> +++ b/drivers/ata/pata_mpc52xx.c
> @@ -767,11 +767,11 @@ static int mpc52xx_ata_probe(struct platform_device *op)
>  	}
>  
>  	task_irq = bcom_get_task_irq(dmatsk);
> -	rv = devm_request_irq(&op->dev, task_irq, &mpc52xx_ata_task_irq, 0,
> -				"ATA task", priv);
> +	rv = request_irq(task_irq, &mpc52xx_ata_task_irq, 0,
> +			  "ATA task", priv);
>  	if (rv) {
>  		dev_err(&op->dev, "error requesting DMA IRQ\n");
> -		goto err2;
> +		goto err_free_task;
>  	}
>  	priv->dmatsk = dmatsk;
>  
> @@ -779,7 +779,7 @@ static int mpc52xx_ata_probe(struct platform_device *op)
>  	rv = mpc52xx_ata_hw_init(priv);
>  	if (rv) {
>  		dev_err(&op->dev, "error initializing hardware\n");
> -		goto err2;
> +		goto err_free_irq;
>  	}
>  
>  	/* Register ourselves to libata */
> @@ -787,13 +787,15 @@ static int mpc52xx_ata_probe(struct platform_device *op)
>  				  mwdma_mask, udma_mask);
>  	if (rv) {
>  		dev_err(&op->dev, "error registering with ATA layer\n");
> -		goto err2;
> +		goto err_free_irq;
>  	}
>  
>  	return 0;
>  
> - err2:
> + err_free_irq:
> +	free_irq(task_irq, priv);
>  	irq_dispose_mapping(task_irq);
> + err_free_task:
>  	bcom_ata_release(dmatsk);
>   err1:
>  	irq_dispose_mapping(ata_irq);
> @@ -811,6 +813,7 @@ static void mpc52xx_ata_remove(struct platform_device *op)
>  
>  	/* Clean up DMA */
>  	task_irq = bcom_get_task_irq(priv->dmatsk);
> +	free_irq(task_irq, priv);
>  	irq_dispose_mapping(task_irq);
>  	bcom_ata_release(priv->dmatsk);
>  	irq_dispose_mapping(priv->ata_irq);
> -- 
> 2.54.0
> 

+ Andy

Andy, since you gave a talk about this recently.
Surely there must be a better way than to migrate away from the device
managed APIs.

Do you have some suggestion?


Kind regards,
Niklas
