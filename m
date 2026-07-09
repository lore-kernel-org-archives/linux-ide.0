Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3604342501
	for <linux-ide@vger.kernel.org>; Thu,  9 Jul 2026 02:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783565235; cv=none; b=R6QpllfAYR8ARoTO3EDhibkspentX15/d7K/4AY6mLL+brkbkuN5/RHmm39nHjUSb/lJgKtdssTeOxsT+DVO56Ggs7pgYkyivijBN9EkglfLaMjWeOYNOIkuYJnFFixXhlAhV/EITvOhLU6l0+gZumeJiQ0GWQi67fJGnWixYs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783565235; c=relaxed/simple;
	bh=g+K7bN1LyjHPXd6Qrgxk4PzR8FZxoHd0uwnym4osIrg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dcgdt7Cb6RZ9g5vHIIRWwUUbcB+54kVD56uNLam7uRnuJugLs2iK2r1FcV8M3Zfy8dZzGMUc+O+kZr8sEAoafIAKiYW9bNdmQW+yAp93/BnMup6l5v/a42ZbvrvpJWYLyZeqwO9hFr3cdQs8Ljn/c1QzMV/lWCtdJ28B3F5E0Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GT8aU5PE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GT8aU5PE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58EC71F000E9;
	Thu,  9 Jul 2026 02:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783565233;
	bh=aF2DmE6PQ0Kccwq5VfZcwKAt4PYpZeN8rERVTQBivhw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GT8aU5PE0ZA31TEmENbK+z6bPY+c2yKREuyarJ+PEsp1QjOuexIepRXK/x7HI85cG
	 XTsbrKzGKYkJANote0UBCCxBPgSACX/GNAhRQgcRTLIC7KNNLf1U5KS/0c68jx+1Dr
	 MThgg9AhKnsHhl1eY8NgsRj60vymO03iJZq7QfH5pPoG2ZkvD+ZWoFqUZfwh3tu7uz
	 X1yhOPM4slMcgdoxuYzlzbKAFf6VA+55oMwTUCLiSdlgn5F0m/DmzebdhqhxbmQeOB
	 0Qbz8RQHk+wDXpxejDzj8JO9x7pgBj0lU9W9IBOHXLEFfjPReY1NVlzPmCfSiihQXs
	 BYICteHvbnW1A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCHv3 1/5] ata: sata_dwc_460ex: use platform_get_irq()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rosen Penev" <rosenp@gmail.com>
Cc: cassel@kernel.org, linux-ide@vger.kernel.org, dlemoal@kernel.org
In-Reply-To: <20260709023202.2132165-2-rosenp@gmail.com>
References: <20260709023202.2132165-1-rosenp@gmail.com>
 <20260709023202.2132165-2-rosenp@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 02:47:12 +0000
Message-Id: <20260709024713.58EC71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The patch removes the local variable `np` from `sata_dwc_probe()`, =
causing a build failure when `CONFIG_SATA_DWC_OLD_DMA` is enabled.
--

--- Patch [1]: [PATCHv3 1/5] ata: sata_dwc_460ex: use platform_get_irq() ---
commit 74bc1be9c4385029a4079d000bf78ff4452fc266
Author: Rosen Penev <rosenp@gmail.com>

ata: sata_dwc_460ex: use platform_get_irq()

This commit replaces irq_of_parse_and_map() with platform_get_irq() in both
sata_dwc_dma_init_old() and sata_dwc_probe(). It improves error handling for
IRQs and removes the unnecessary include of of_irq.h.

> diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.c
> index 4fc22ce4bd9aa..442c6e9d06e0a 100644
> --- a/drivers/ata/sata_dwc_460ex.c
> +++ b/drivers/ata/sata_dwc_460ex.c

[ ... ]

> @@ -1126,7 +1122,6 @@ static const struct ata_port_info sata_dwc_port_inf=
o[] =3D {
>  static int sata_dwc_probe(struct platform_device *ofdev)
>  {
>  	struct device *dev =3D &ofdev->dev;
> -	struct device_node *np =3D dev->of_node;
>  	struct sata_dwc_device *hsdev;
>  	u32 idr, versionr;
>  	char *ver =3D (char *)&versionr;

[ ... ]

> @@ -1173,11 +1168,9 @@ static int sata_dwc_probe(struct platform_device *=
ofdev)
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
> =20
>  #ifdef CONFIG_SATA_DWC_OLD_DMA
>  	if (!of_property_present(np, "dmas")) {

[Severity: Low]
Will this cause a build failure when compiling with CONFIG_SATA_DWC_OLD_DMA
enabled?

The earlier hunk removes the declaration of the np variable, but it appears
to still be referenced here in sata_dwc_probe(). Could dev->of_node be pass=
ed
to of_property_present() instead to avoid an undeclared identifier error?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709023202.2132=
165-2-rosenp@gmail.com?part=3D1
