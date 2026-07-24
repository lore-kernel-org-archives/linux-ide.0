Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876AD342146
	for <linux-ide@vger.kernel.org>; Fri, 24 Jul 2026 23:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784934025; cv=none; b=mtOY2+R2O2UuxTei74uvMMYK1pOuQ2RsTbLM3Y9Y0auR4uMNMOaDcAbAt9BVQv6sBL92zpbH7J9r6ah/PSrzdTegFEAhHaQ610K8bL9aEsIoSJTOSjYbzHBCFy64JZPQA4FKtXiZh6PeAMvosCXXl4FWhTuKazso0LiCXdkNHic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784934025; c=relaxed/simple;
	bh=jLArFEjYgxk8I2ds3tAgDcWAR9aGrXNL6hT6c2p9Wis=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rnIBd77xZorXvZ+jQJCTruJ4ob26v4EV7BJp/V4OoDaiyoSlkwbD4aGMK0k+5TG6IGOXJq3RdKYEjNHNapmFPsyjLR/Wzsh7KcQs5JBra5KPVNliQwDkHzh55HmpgVIMdwyWFUlxnVC/+plQkmFpA90m77nm1R9ELQ2cQ4TTOe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JOUKnZ2M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JOUKnZ2M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F01AE1F000E9;
	Fri, 24 Jul 2026 23:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784934021;
	bh=h6myTGHOWVV8XMH0Mvd0XWNcXda/FQaAHJzJpECS15s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JOUKnZ2MG5R2uVZ2mls+DIm51UAx6OTv/nNw0X7PgTKEb4eAXdAZBh9zEGKfK/5WI
	 yzBinw0vSPEkgnwLVfDhAi1+rTm90IH3y+otKlYh25WkifSJmDy3PHJzUa53Mj+yq0
	 WfYHiXFsNIpf1GNyv6Rh+/LMMZplrOUH8zgkt8Za/WN/qLBwQ1sF4iSej+IIMND087
	 gd7jKBM9CKaMU9pvocJ+T64uteElnIM44aJ1zrKBF/FZJJOUgJb32BwMztRP3+XLNZ
	 6gHTAbFHvlVi02QRXwaptS+04kUPoEfrfXlsQ6b+k0MxEsafr9SwCntHoKriOvt2XF
	 7SJ1ZwHdSRhAA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCHv2] ata: pata_ep93xx: use devm_dma_request_chan for DMA
 channels
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rosen Penev" <rosenp@gmail.com>
Cc: dlemoal@kernel.org, cassel@kernel.org, linux-ide@vger.kernel.org
In-Reply-To: <20260724225232.41149-1-rosenp@gmail.com>
References: <20260724225232.41149-1-rosenp@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Jul 2026 23:00:20 +0000
Message-Id: <20260724230020.F01AE1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] DMA channels are permanently leaked (hoarded) for the lifetime o=
f the device if DMA initialization fails and the driver falls back to PIO m=
ode.
--

--- Patch [1]: [PATCHv2] ata: pata_ep93xx: use devm_dma_request_chan for DM=
A channels ---
commit 7ea9c0e84416db40b47acb17ec9bf21459755ef3
Author: Rosen Penev <rosenp@gmail.com>

ata: pata_ep93xx: use devm_dma_request_chan for DMA channels

This patch converts the manual DMA channel request and release paths in
ep93xx_pata_dma_init() to use the managed devm_dma_request_chan() API. It
removes the explicit release helpers and cleanup paths to simplify the code.

> diff --git a/drivers/ata/pata_ep93xx.c b/drivers/ata/pata_ep93xx.c
> index 339ee5e43e9f3..c99b8c49a1cec 100644
> --- a/drivers/ata/pata_ep93xx.c
> +++ b/drivers/ata/pata_ep93xx.c
[ ... ]
> @@ -665,14 +653,14 @@ static int ep93xx_pata_dma_init(struct ep93xx_pata_=
data *drv_data)
>  		return 0;
>  	}
> =20
> -	drv_data->dma_tx_channel =3D dma_request_chan(&pdev->dev, "tx");
> +	drv_data->dma_tx_channel =3D devm_dma_request_chan(&pdev->dev, "tx");
>  	if (IS_ERR(drv_data->dma_tx_channel)) {
>  		ret =3D PTR_ERR(drv_data->dma_tx_channel);
>  		drv_data->dma_tx_channel =3D NULL;
>  		if (ret =3D=3D -EPROBE_DEFER)
> -			goto fail_release_rx;
> +			return ret;
>  		dev_warn(dev, "tx DMA unavailable, using PIO\n");
> -		goto fail_release_rx;
> +		return 0;

[Severity: Medium]
When falling back to PIO mode due to the TX channel request failing, the
driver returns 0 and probe succeeds. Since this uses devres-managed
allocations, does this mean the successfully requested RX channel will be
permanently hoarded by devres for the lifetime of the device without being
used?=20

>  	}
> =20
>  	/* Configure receive channel direction and source address */
> @@ -683,7 +671,9 @@ static int ep93xx_pata_dma_init(struct ep93xx_pata_da=
ta *drv_data)
>  	ret =3D dmaengine_slave_config(drv_data->dma_rx_channel, &conf);
>  	if (ret) {
>  		dev_warn(dev, "failed to configure rx dma channel, using PIO\n");
> -		goto fail_release_dma;
> +		drv_data->dma_rx_channel =3D NULL;
> +		drv_data->dma_tx_channel =3D NULL;
> +		return 0;

[Severity: Medium]
If RX slave configuration fails, the driver nullifies the pointers but retu=
rns
0 to gracefully fall back to PIO mode. Since the device successfully binds =
in
PIO mode, will both the devm-managed RX and TX DMA channels remain permanen=
tly
allocated and unavailable to other devices?

>  	}
> =20
>  	/* Configure transmit channel direction and destination address */
> @@ -694,21 +684,12 @@ static int ep93xx_pata_dma_init(struct ep93xx_pata_=
data *drv_data)
>  	ret =3D dmaengine_slave_config(drv_data->dma_tx_channel, &conf);
>  	if (ret) {
>  		dev_warn(dev, "failed to configure tx dma channel, using PIO\n");
> -		goto fail_release_dma;
> +		drv_data->dma_rx_channel =3D NULL;
> +		drv_data->dma_tx_channel =3D NULL;
> +		return 0;

[Severity: Medium]
As with the RX configuration failure, will returning 0 here leave the
allocated devm DMA channels leaked while operating in PIO mode? Since devres
only frees these resources on device unbind, should these fallback paths
explicitly release the hardware DMA channels first?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260724225232.4114=
9-1-rosenp@gmail.com?part=3D1
