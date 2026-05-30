Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA1F33A70F
	for <linux-ide@vger.kernel.org>; Sat, 30 May 2026 04:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780117023; cv=none; b=aH33riuMYqSNHCU7JvzpmL8VmER8u9sEUk+9G/U/zbCY7HScPo0m78JnDFsJG++KH1bpUe/JXR5U5P8NXHkG05TcQGwFBeAaBl4z9DKHhfurS+hu3Cl/djeqFh9r+3t3pC3H2Iw5OS4BOAieGn673YB9CVjQKsXhlnWVAl4WOvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780117023; c=relaxed/simple;
	bh=ZXD8GUhg9Gz03M+rBUAT0xxt1HoqDhA+c7m9jipnExo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oDlFlrfoSYQSf43Gv1PMdQoFsx4u2pv5Eidoo+Mcl+z1oT8bkQKbRJCNfVWhoKWbo6dYVoca7BLWyL+5I+ffmZ/vyWapO2sS0Uj0mmXbFhGTFFNmYYVSW46zqY6I1HbO7jy0iAJdP2Unyfq65UJWdj0WijKvi0TkDhUQ4hnFcSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OtIOtj8J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OtIOtj8J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EEFE1F00893;
	Sat, 30 May 2026 04:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780117021;
	bh=AbDPgN1Z28XAVASQb4Dy6su/BfIAVFSNHltT/LllSWQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OtIOtj8Jdru5+P2CexMuqSmYcjJ4MXhAeeDyn+75SVs5HDctnzvrZwhSS3meNB3Ay
	 XiVRRG326aig3qznC70vJ2vs0mNvtduvm0vIGUBIXktX5maKMccakachpEb9Lax1gi
	 +0yjz2RU65fIn9UOCfk2/U4uXnORO0roECPNEuDYyqPZ7O53bmiueSN9HqaK4SGNl6
	 FYzvlJJN64/nWJcfQkmZhhnIr6zaJXmVP7vlhYYSM2MZrjgYFMVOFQ59SOzEbJznz+
	 Kn5uSfX6bqqIQkkcluLYj6Or3w+LasIf4RN2dhJUeg0o6C1YFndd4MQVicIla2yR0D
	 WG7cNN765M18A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] ata: pata_ep93xx: add COMPILE_TEST support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rosen Penev" <rosenp@gmail.com>
Cc: cassel@kernel.org, dlemoal@kernel.org, linux-ide@vger.kernel.org
In-Reply-To: <20260530003627.42473-4-rosenp@gmail.com>
References: <20260530003627.42473-4-rosenp@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 30 May 2026 04:57:01 +0000
Message-Id: <20260530045701.6EEFE1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Double free of 'rx' DMA channel and invalid pointer dereference of=
 `ERR_PTR` in the 'tx' DMA channel error path.
--

commit b636a1b70934f2b41b7dce1e54946eb6d1bed3b4
Author: Rosen Penev <rosenp@gmail.com>

ata: pata_ep93xx: add COMPILE_TEST support

This commit enables COMPILE_TEST support for the Cirrus Logic EP93xx PATA
controller. This allows the buildbots to compile the driver on other
architectures to find potential issues.

> diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
> index fff305ec1e788..28ca856ecc754 100644
> --- a/drivers/ata/Kconfig
> +++ b/drivers/ata/Kconfig
> @@ -692,7 +692,7 @@ config PATA_EFAR
> =20
>  config PATA_EP93XX
>  	tristate "Cirrus Logic EP93xx PATA support"
> -	depends on ARCH_EP93XX
> +	depends on ARCH_EP93XX || COMPILE_TEST

[Severity: High]
This isn't a bug introduced by this patch, but enabling COMPILE_TEST might
expose a pre-existing error handling issue in drivers/ata/pata_ep93xx.c.

In ep93xx_pata_dma_init(), if dma_request_chan() for "tx" fails, it stores
the ERR_PTR in drv_data->dma_tx_channel and jumps to fail_release_rx:

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

	return ret;
}

Could this sequence lead to a double-free and an invalid pointer dereferenc=
e?

The fail_release_rx path releases dma_rx_channel but doesn't clear the
pointer to NULL before falling through to ep93xx_pata_release_dma(). Also,
dma_tx_channel holds an ERR_PTR which is non-NULL.

When ep93xx_pata_release_dma() is called, it checks if the pointers are
non-NULL:

drivers/ata/pata_ep93xx.c:ep93xx_pata_release_dma() {
    ...
	if (drv_data->dma_rx_channel) {
		dma_release_channel(drv_data->dma_rx_channel);
		drv_data->dma_rx_channel =3D NULL;
	}
	if (drv_data->dma_tx_channel) {
		dma_release_channel(drv_data->dma_tx_channel);
		drv_data->dma_tx_channel =3D NULL;
	}
    ...
}

Would this result in dma_release_channel() being called a second time on
the rx channel, and being called with the ERR_PTR for the tx channel?

>  	select PATA_TIMINGS
>  	help
>  	  This option enables support for the PATA controller in

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260530003627.4247=
3-1-rosenp@gmail.com?part=3D3
