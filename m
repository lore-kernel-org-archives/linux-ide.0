Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A8F36B928
	for <linux-ide@vger.kernel.org>; Thu, 23 Jul 2026 21:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784843238; cv=none; b=QQnxKJaQUW93Qb8rsp0mTIgKyxByVYC/UWT+Bdxh7gjwD3jzUlZw62crDXfzIf5g1SEoKfeMnkLtf5ziu8cr52veDetAGPL69xQWuumVznGe10WFLLKepD+UIk83MiBKm/y2Fm8/gvCEzrkKqBFuDgynbeN0TGxz6bfaTYsDkFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784843238; c=relaxed/simple;
	bh=tj9rgk6jUyMHBXNO0C7uz8L4W3bvepni/+xDXvYUszw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Ep91sX8Vz4EpM9uRstGL/9zX/Kin17ZYPQULdpbfqrQliTHj8iY4PesSBHbyKDzv7QJjXwIWmNIn15rumsShcZbN+SVN76UYH/UkCFjEm+sF4neXh5aEAtxPWeSxEeRsMhh29BRtWPTIKCaRozY7fOqRRpUrUvBioU2X1YhwKQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mJcLSANy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mJcLSANy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67B201F000E9;
	Thu, 23 Jul 2026 21:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784843236;
	bh=mkgcTatVz5sn8KduNPoBRTE5FJDI5IamoMsUYyxwtHM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mJcLSANy4TKyvEE1/ZXYEqmgrq60ggFeBbOChWCMvisxh4owrLp+vjMDFJVlUKNNe
	 RYbO+LKSWQV6fOlUuGOUQWLVA1IV38jM5oIjAGYW7SCVOOxqG+NvY/4z4DwWryrFNH
	 p0EVc088yHU+wAFuzq0sahMukoVE4fPISG7rjg28Q2t23vkCS68kAP+KS7qgAneQTg
	 BpMmXLXzgue6BE3Ob89aKsuakcE+eUu+bDjsJcT9hVEll2Dw3bQRRanEJ/OihiKlBr
	 1whpb59Sdqd2KxWqotE1iTYXlzqkTCLbj8LxSKLM+CdC80BBnaf+dBYupUpLIQ7jL4
	 f1AKTLCpaetiQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] ata: pata_ep93xx: use devm_dma_request_chan for DMA
 channels
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rosen Penev" <rosenp@gmail.com>
Cc: cassel@kernel.org, dlemoal@kernel.org, linux-ide@vger.kernel.org
In-Reply-To: <20260723214128.356942-1-rosenp@gmail.com>
References: <20260723214128.356942-1-rosenp@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 21:47:15 +0000
Message-Id: <20260723214716.67B201F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Failure to clear DMA channel pointers on configuration error cause=
s incorrect UDMA enablement.
--

--- Patch [1]: [PATCH] ata: pata_ep93xx: use devm_dma_request_chan for DMA =
channels ---
commit 320ef19a1b3a76deb7df0daa1ed0cdbb72e88bfa
Author: Rosen Penev <rosenp@gmail.com>

ata: pata_ep93xx: use devm_dma_request_chan for DMA channels

This commit converts the manual DMA channel request/release in
ep93xx_pata_dma_init() to the managed devm_dma_request_chan() API. It remov=
es
the now-unused ep93xx_pata_release_dma() helper and simplifies the error pa=
th
cleanup.

> diff --git a/drivers/ata/pata_ep93xx.c b/drivers/ata/pata_ep93xx.c
> index 339ee5e43e9f3..04ab37134fb20 100644
> --- a/drivers/ata/pata_ep93xx.c
> +++ b/drivers/ata/pata_ep93xx.c

[ ... ]

> @@ -683,7 +671,7 @@ static int ep93xx_pata_dma_init(struct ep93xx_pata_da=
ta *drv_data)
>  	ret =3D dmaengine_slave_config(drv_data->dma_rx_channel, &conf);
>  	if (ret) {
>  		dev_warn(dev, "failed to configure rx dma channel, using PIO\n");
> -		goto fail_release_dma;
> +		return 0;
>  	}
> =20
>  	/* Configure transmit channel direction and destination address */

[Severity: High]
If dmaengine_slave_config() fails, will this leave drv_data->dma_rx_channel
non-NULL?

The old fail_release_dma path called ep93xx_pata_release_dma(), which expli=
citly
freed the channel and set drv_data->dma_rx_channel to NULL. Without nullify=
ing
it here, the driver might incorrectly assume the channel is fully configure=
d.

> @@ -694,21 +682,10 @@ static int ep93xx_pata_dma_init(struct ep93xx_pata_=
data *drv_data)
>  	ret =3D dmaengine_slave_config(drv_data->dma_tx_channel, &conf);
>  	if (ret) {
>  		dev_warn(dev, "failed to configure tx dma channel, using PIO\n");
> -		goto fail_release_dma;
> +		return 0;
>  	}
> =20
>  	return 0;

[Severity: High]
Similarly, does returning early here without clearing drv_data->dma_tx_chan=
nel
leave the pointer set?

Later in ep93xx_pata_probe(), the code relies on these pointers to check
if UDMA should be enabled:

	if (drv_data->dma_rx_channel && drv_data->dma_tx_channel) {
		const struct soc_device_attribute *match;

		match =3D soc_device_match(ep93xx_soc_table);
		if (match)
			ap->udma_mask =3D (unsigned long) match->data;
		else
			ap->udma_mask =3D ATA_UDMA2;
	}

If the pointers are left non-NULL after a configuration failure, will the d=
river
incorrectly advertise UDMA capabilities and attempt to use unconfigured
channels for I/O?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723214128.3569=
42-1-rosenp@gmail.com?part=3D1
