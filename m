Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B3622367DF
	for <linux-ide@vger.kernel.org>; Sat, 30 May 2026 04:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780116568; cv=none; b=lgCF21Ox6lTeLiL1ewbZnBqo/EeAsa0VIOeYFhbIjmh+u+r2V7Wfge153a70uwP+HAbFroYAFw1YHTlekSMNLERlgeE64AlbQPFTLUrzJk39Gs7z75qVA0pyiOhwZUoEKvZNVbsYMAD1pyDMbokg/wllN/WvQcDAcXKjO1CNLlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780116568; c=relaxed/simple;
	bh=Qpq5tLICs3cIZ4Lvhd4K3zW2ptt5CMA3QW7CXsVsRz8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bXasDkjSbwsiiD5+wgVvob76mVUHcqDK+oWQxotLM4KkhAyRY9ire/YPuIKLLBEudhT/bJ7MjA/iLUcofH4gi0dZzIWxp7xiEcawybabfOIF0VzKYe30WzqWJfaBHLZlmdFc79b+jsH/5+AhDC257BSQt6IMAbKBspVYYAQKuEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B52EYTU8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B52EYTU8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 674851F00893;
	Sat, 30 May 2026 04:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780116566;
	bh=YjvB7lnVzcE9kiSS9L/N2JCWer6QjJ/tp5pFbjfSZsE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=B52EYTU8XF2aAuqla14/BxXb4fJlBNWFJkGPiupBEbvqnKfszCRh+NObSELaaB7k5
	 WxBgltCA3ibiefrWcs1Nm4WMRVFoO29tWYmKncKGtLzr9SVwWuBcAf5cY91MLLKwu+
	 F+eQmtfzOBc5Kbr6ladSugOtCHtnqw3TWwJTIYbuW0b3c3T/vJvimx55IcXB7R7nqt
	 7jyUltF2R28G3KUILTf4LbifYXaWEdlywadPPP5XaFulBQJRmKQ2rN7ouzvM49VXwK
	 /jvmfExYzVoQTdfhJd1ZFqpSEDyhtXNxlugtPJfefFhhD230AXESEFOoNKTrZWs/f2
	 r+XD+Acx3S5yQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] ata: pata_ep93xx: use unsigned long for data
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rosen Penev" <rosenp@gmail.com>
Cc: dlemoal@kernel.org, cassel@kernel.org, linux-ide@vger.kernel.org
In-Reply-To: <20260530003627.42473-3-rosenp@gmail.com>
References: <20260530003627.42473-3-rosenp@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 30 May 2026 04:49:26 +0000
Message-Id: <20260530044926.674851F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Double free and invalid pointer dereference on DMA TX channel requ=
est failure
--

commit 29937e8c8082c869105691e9f38d16e45bbd37fb
Author: Rosen Penev <rosenp@gmail.com>

ata: pata_ep93xx: use unsigned long for data

An int is being encoded as a void pointer but that breaks on 64-bit
systems as the type needs to match pointer size.

> diff --git a/drivers/ata/pata_ep93xx.c b/drivers/ata/pata_ep93xx.c
> index f7e87d6af2641..1663dcd00a932 100644
> --- a/drivers/ata/pata_ep93xx.c
> +++ b/drivers/ata/pata_ep93xx.c
> @@ -977,7 +977,7 @@ static int ep93xx_pata_probe(struct platform_device *=
pdev)
> =20
>  		match =3D soc_device_match(ep93xx_soc_table);
>  		if (match)
> -			ap->udma_mask =3D (unsigned int) match->data;
> +			ap->udma_mask =3D (unsigned long) match->data;

[Severity: High]
This is a pre-existing issue, but while reviewing this file I noticed a
potential double free and invalid pointer dereference in the DMA error
handling paths.

If dma_request_chan() for the "tx" channel fails in ep93xx_pata_dma_init(),
it returns an ERR_PTR which is stored in drv_data->dma_tx_channel, and jumps
to fail_release_rx:

drivers/ata/pata_ep93xx.c:ep93xx_pata_dma_init() {
    ...
	drv_data->dma_tx_channel =3D dma_request_chan(&pdev->dev, "tx");
	if (IS_ERR(drv_data->dma_tx_channel)) {
		ret =3D dev_err_probe(dev, PTR_ERR(drv_data->dma_tx_channel),
				    "tx DMA setup failed\n");
		goto fail_release_rx;
	}
    ...
fail_release_rx:
	dma_release_channel(drv_data->dma_rx_channel);
fail_release_dma:
	ep93xx_pata_release_dma(drv_data);
}

The fail_release_rx path calls dma_release_channel() on the rx channel but
doesn't set drv_data->dma_rx_channel to NULL. It then falls through to
fail_release_dma which calls ep93xx_pata_release_dma():

drivers/ata/pata_ep93xx.c:ep93xx_pata_release_dma() {
	if (drv_data->dma_rx_channel) {
		dma_release_channel(drv_data->dma_rx_channel);
		drv_data->dma_rx_channel =3D NULL;
	}
	if (drv_data->dma_tx_channel) {
		dma_release_channel(drv_data->dma_tx_channel);
		drv_data->dma_tx_channel =3D NULL;
	}
}

Will this cause dma_release_channel() to be called a second time on the rx
channel?

Also, since drv_data->dma_tx_channel holds an ERR_PTR rather than NULL,
won't the second if block try to dereference that ERR_PTR when
dma_release_channel() is called on it?

>  		else
>  			ap->udma_mask =3D ATA_UDMA2;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260530003627.4247=
3-1-rosenp@gmail.com?part=3D2
