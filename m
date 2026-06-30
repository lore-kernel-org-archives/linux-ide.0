Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230542E7F2C;
	Tue, 30 Jun 2026 02:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782785196; cv=none; b=fSMP36zCCPFmX/sttrBasUP8ztj0kQYQ7Ueadu61AtJ8jusvCq/uBkSafQJ6xfbO5Ctf5lxR2bquUQJ2n9+eM6pK5rxhcrfvDHRrYPovdazDKzjKT8749b5P8DFiRCqXOwOmiE4KO6C3AS8ZnIfDWL1pKHTSgqAKEOQ1RzAA1lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782785196; c=relaxed/simple;
	bh=Zb0+6tIoBOQc1SL1k8A0wLxRSfjhVC0TbW7QR943m6Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dpwnC4knePYbWH9RkOOyVAhwN8pybMYAtiD4e/embzs4+KeA6UxHL9k9x9MGpHSbk6SCVaDROL6ozePTop1WH/ptNJs2lWGMZrJ+wQ7Yut/raAXAlz/Z5q/CJ9R26tiE/59ebl1Cq6DGjCvc/H58/OWRFVkeriP6+w9tTqDESrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JS4WUdY1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JS4WUdY1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25C9C1F000E9;
	Tue, 30 Jun 2026 02:06:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782785194;
	bh=xBKrcwR+drJVqRfcrB5li7YVYMBaEbNLsfMhoJms9TQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=JS4WUdY19TpUF6IY3ziAEghqhEDIH0Pv6xHSQXN4Gqk8JSwiv692pteIC1dgUDtsQ
	 WTnIZNZO8rnQDhdHidvWrk8Co/8xHRg7T4HCCuwJjzjI0RRrhls07JCO3EMVx80o+E
	 r6+dHxqxl+1a/DHHoS8uAyNMyf8Hw9XCU3P4jt2OJHlgcjI+CvHmFgW6qlFcNqIUNp
	 awOGgXwzYpkl42eFr5C1eoh6B6ujyue5I2LXjFUWJNaSI2LEGLwu2HKm+wbeJwSp37
	 I7ijD83WxvgrUmbqurVD1gE9YcgVpaEq+OlZUJfcPuuICVQIrB4+600ZkjwMEdZEF/
	 dK81Ft9+7RbMQ==
Message-ID: <5b03d0b4-1961-498f-a720-f764b14fc1e9@kernel.org>
Date: Tue, 30 Jun 2026 11:06:32 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: sata_dwc_460ex: use devm for old DMA resource
 lifetime management
To: Rosen Penev <rosenp@gmail.com>, linux-ide@vger.kernel.org
Cc: Niklas Cassel <cassel@kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20260630001731.1174739-1-rosenp@gmail.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260630001731.1174739-1-rosenp@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 6/30/26 09:17, Rosen Penev wrote:
> Convert sata_dwc_dma_exit_old() to a devm action callback and register
> it via devm_add_action_or_reset() after dw_dma_probe() succeeds.  This
> lets the devm framework handle DMA controller teardown automatically on
> probe failure and driver removal.
> 
> As a result the probe function can use plain return-on-error for all
> failure paths — the dma_initialized flag, the goto labels, and the
> explicit sata_dwc_dma_exit_old() call in sata_dwc_remove() are all
> eliminated.
> 
> Assisted-by: opencode:big-pickle
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  drivers/ata/sata_dwc_460ex.c | 35 ++++++++++++++++-------------------
>  1 file changed, 16 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.c
> index 35aa7f9acdf7..a1e319deb0b4 100644
> --- a/drivers/ata/sata_dwc_460ex.c
> +++ b/drivers/ata/sata_dwc_460ex.c
> @@ -221,10 +221,18 @@ static int sata_dwc_dma_get_channel_old(struct sata_dwc_device_port *hsdevp)
>  	return 0;
>  }
>  
> +static void sata_dwc_dma_exit_old(void *data)
> +{
> +	struct sata_dwc_device *hsdev = data;
> +
> +	dw_dma_remove(hsdev->dma);
> +}
> +
>  static int sata_dwc_dma_init_old(struct platform_device *pdev,
>  				 struct sata_dwc_device *hsdev)
>  {
>  	struct device *dev = &pdev->dev;
> +	int err;
>  
>  	hsdev->dma = devm_kzalloc(dev, sizeof(*hsdev->dma), GFP_KERNEL);
>  	if (!hsdev->dma)
> @@ -244,15 +252,11 @@ static int sata_dwc_dma_init_old(struct platform_device *pdev,
>  		return PTR_ERR(hsdev->dma->regs);
>  
>  	/* Initialize AHB DMAC */
> -	return dw_dma_probe(hsdev->dma);
> -}
> -
> -static void sata_dwc_dma_exit_old(struct sata_dwc_device *hsdev)
> -{
> -	if (!hsdev->dma)
> -		return;
> +	err = dw_dma_probe(hsdev->dma);
> +	if (err)
> +		return err;
>  
> -	dw_dma_remove(hsdev->dma);
> +	return devm_add_action_or_reset(dev, sata_dwc_dma_exit_old, hsdev);
>  }
>  
>  #endif
> @@ -1187,7 +1191,7 @@ static int sata_dwc_probe(struct platform_device *ofdev)
>  
>  	err = phy_init(hsdev->phy);
>  	if (err)
> -		goto error_out;
> +		return err;
>  
>  	/*
>  	 * Now, register with libATA core, this will also initiate the
> @@ -1195,12 +1199,10 @@ static int sata_dwc_probe(struct platform_device *ofdev)
>  	 * error_handler() to execute a dummy Softreset EH session
>  	 */
>  	err = ata_host_activate(host, irq, sata_dwc_isr, 0, &sata_dwc_sht);
> -	if (err)
> -		dev_err(dev, "failed to activate host");
> +	if (!err)
> +		return err;

What about the generic error check pattern:

	err = ata_host_activate(host, irq, sata_dwc_isr, 0, &sata_dwc_sht);
	if (err) {
		dev_err(dev, "failed to activate host");
		phy_exit(hsdev->phy);
		return err;
	}

	return 0;

Which I find personally much nicer to read.

>  
> -	return 0;
> -
> -error_out:
> +	dev_err(dev, "failed to activate host");
>  	phy_exit(hsdev->phy);
>  	return err;
>  }
> @@ -1215,11 +1217,6 @@ static void sata_dwc_remove(struct platform_device *ofdev)
>  
>  	phy_exit(hsdev->phy);
>  
> -#ifdef CONFIG_SATA_DWC_OLD_DMA
> -	/* Free SATA DMA resources */
> -	sata_dwc_dma_exit_old(hsdev);
> -#endif
> -
>  	dev_dbg(dev, "done\n");
>  }
>  


-- 
Damien Le Moal
Western Digital Research
