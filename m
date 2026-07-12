Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BBAA23393B
	for <linux-ide@vger.kernel.org>; Sun, 12 Jul 2026 21:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783892791; cv=none; b=gWx9NBF1GUNdOZXhyxR2tm6eUqj3EzmHHtQEeDn2w6/MklXVImzYTi0Wo18iueh+W/2mlqxk9eAFuH1P1UCVl+W211Is37/gXRVGGUdARKtf2UVGTw0nCVGt6FeM2ny4X8F5VvzSRzoSD2aSAJg9vBxHXu9x3sUK5gxyhnrMSJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783892791; c=relaxed/simple;
	bh=A7YIy8RCUowT4vUzoYwyrQPldJG/6uuf0a45sPpuxOw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=G9WV/DHsNUcw8znnKFyjDLUpqGxtP0rI8V0WyE8rodrxdNhOFL7uNOTqNLNOJaFfYEs0/MMAVGMqe31rkkgdXuxy/z9o2/W+shc7y7M7JLrppWCfrjUbKtChXrbxf6Ref2bkT09QSYL2RvERN2rhXSFwdMYITSB2HQMlPPz8ATI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QzGFyvvl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QzGFyvvl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B334A1F000E9;
	Sun, 12 Jul 2026 21:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783892790;
	bh=sCR1pKluixSsfHDjiGc/V+VS1hEYXzxlxjRadkAHBoM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QzGFyvvlk/veMjpEtJf9QCo84gb5JzjtfkLEnVpRivBaDMSAJq8Z+gF/HqiCABC8E
	 tfQv98TKw6i7QPhBaFZZBIb7Fh9V/6s667ToT9JTOhpc5JQmbZnYyNtaRPgq9hDj2m
	 i7ilJt3r4cNiIAnYdIYqEH9rnghWit46z67R7ayIOL9dJeBaRK7FDfAyoeWxUSVEC9
	 w5aq1Zx47/RIpJrpCGIPHXHm93PK2eMiaY+oGNkRE0FXz7bMtP3yprdqo7lDhPf2XZ
	 nMmBfcvxBLkN1AJnQEkJ0Vg73iXwgA5/yb1xXLMt3U4lpcDWyWAWvU1Ypf3p/SrtLk
	 ei9CFqW2ReWcQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCHv4 1/4] ata: sata_dwc_460ex: use platform_get_irq()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rosen Penev" <rosenp@gmail.com>
Cc: linux-ide@vger.kernel.org, dlemoal@kernel.org, cassel@kernel.org
In-Reply-To: <20260712213728.824420-2-rosenp@gmail.com>
References: <20260712213728.824420-1-rosenp@gmail.com>
 <20260712213728.824420-2-rosenp@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 12 Jul 2026 21:46:29 +0000
Message-Id: <20260712214629.B334A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] sata_dwc_probe() ignores the return value from ata_host_activate()=
 and incorrectly returns 0 (success) on failure.
- [High] sata_dwc_probe() fails to clean up DMA resources initialized by sa=
ta_dwc_dma_init_old() on error paths, leading to a use-after-free.
- [High] Hardware interrupts are enabled early in probe without being disab=
led on error paths, potentially causing unhandled interrupt storms.
--

--- Patch [1]: [PATCHv4 1/4] ata: sata_dwc_460ex: use platform_get_irq() ---
commit c2c0e5be0a165f590877664b3703065d59cc686e
Author: Rosen Penev <rosenp@gmail.com>

ata: sata_dwc_460ex: use platform_get_irq()

This commit replaces irq_of_parse_and_map() with platform_get_irq() in both
sata_dwc_dma_init_old() and sata_dwc_probe() to improve error reporting. It
also removes the unnecessary of_irq.h include and fixes an unused variable
when CONFIG_SATA_DWC_OLD_DMA is disabled.

> diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.c
> index 4fc22ce4bd9aa..092272753749c 100644
> --- a/drivers/ata/sata_dwc_460ex.c
> +++ b/drivers/ata/sata_dwc_460ex.c
[ ... ]
> @@ -1173,14 +1168,12 @@ static int sata_dwc_probe(struct platform_device =
*ofdev)
>  	sata_dwc_enable_interrupts(hsdev);
> =20
>  	/* Get SATA interrupt number */
> -	irq =3D irq_of_parse_and_map(np, 0);
> -	if (!irq) {
> -		dev_err(dev, "no SATA DMA irq\n");
> -		return -ENODEV;
> -	}
> +	irq =3D platform_get_irq(ofdev, 0);
> +	if (irq < 0)
> +		return irq;

[Severity: High]
This isn't a bug introduced by this patch, but hardware interrupts are enab=
led
just before this by calling sata_dwc_enable_interrupts().=20

If platform_get_irq() fails and returns an error code like -EPROBE_DEFER, t=
he
function returns early without masking the hardware interrupts again.

Could this lead to an unhandled interrupt storm since the hardware registers
are unmasked but no handler is registered yet?

> =20
>  #ifdef CONFIG_SATA_DWC_OLD_DMA
> -	if (!of_property_present(np, "dmas")) {
> +	if (!of_property_present(dev->of_node, "dmas")) {
>  		err =3D sata_dwc_dma_init_old(ofdev, hsdev);
>  		if (err)
>  			return err;

[Severity: High]
This is a pre-existing issue, but looking further down in sata_dwc_probe(),
there is a potential cleanup issue on error paths:

	hsdev->phy =3D devm_phy_optional_get(dev, "sata-phy");
	if (IS_ERR(hsdev->phy))
		return PTR_ERR(hsdev->phy);

	err =3D phy_init(hsdev->phy);
	if (err)
		goto error_out;

If getting or initializing the PHY fails, the function exits without cleani=
ng
up the DMA resources that were just initialized by sata_dwc_dma_init_old().

Because sata_dwc_dma_init_old() sets up the DMA engine, does returning here
leave the DMA subsystem with dangling pointers, leading to a use-after-free
when devres cleans up hsdev->dma?

[Severity: High]
This is another pre-existing issue further down in sata_dwc_probe(). The
return value from ata_host_activate() is logged but then discarded:

	err =3D ata_host_activate(host, irq, sata_dwc_isr, 0, &sata_dwc_sht);
	if (err)
		dev_err(dev, "failed to activate host");

	return 0;

If ata_host_activate() fails, the function unconditionally returns 0, meani=
ng
the driver core considers the device successfully bound.=20

When the driver is unbound later, scsi_remove_host() will be called on an
uninitialized SCSI host. Does this return value need to be propagated inste=
ad
of returning 0 to prevent a NULL pointer dereference during teardown?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260712213728.8244=
20-2-rosenp@gmail.com?part=3D1
