Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8FBF2475D0
	for <linux-ide@vger.kernel.org>; Thu, 23 Jul 2026 00:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784766714; cv=none; b=Cq43+E9Wte4Y1oNCoHPTEO0xugcVKLEorILVr1Ac7S32S4aFO+qw/PzT3dWSvj8tiW2+1rLAn+95lOV1r+ljB9f+K0e33ljuI2Q2bglED1rRv3wG+BsYDZzA9a002fuYCO03rxDJtoHMFXc557lQNeM+gF1PR4+iLI6/ONZwgPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784766714; c=relaxed/simple;
	bh=ITUvQbJKeQKEkenZ9bHRrrKrxl8/9X4whQ6avmYiPyQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BikiWfPCrzbHFxRjB7SB9LiIfhSISa1uL9rjWb11SdG8SscQ7bOzUesQlI94V5X+ZmV4PhfUB3XinCfQctraaP3++d6Wi7NWGiNtph0l/XH6ineuBflYtUutJH4GFKLZX57KVCIO9t9CZEQEPr9y1nOxuuvH9zfn8ge4AZpy5o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MPY2c4+v; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MPY2c4+v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 206A31F000E9;
	Thu, 23 Jul 2026 00:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784766713;
	bh=CsUatscftc7mJ6ZfC9K1dWYU0oSjTV4J5r78QI3Y4p4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MPY2c4+vtYX5AhyIKV1ORG80cZjKfMn/VCSlbVo/Pc4H9OZoqYe82kLqQNq4d5i7m
	 UH+vuO/fmC64RXgwrXzhIH3QEkUEICWY9xkpTzKlV6uwPjcS0fEUGrSUr/cM6hWIrN
	 hHs+/1z/0CFvnBEI+VljzZxHiUPvyqRnghUhLNWNmG6iD3Dmq/NBkHVvcgIlufFqiq
	 vc6pNoN8L88U8u/jYYUwUThNt5j6AT4pjGgYCHAl36FIl+dckNJrU+HU9aSMKXsEDR
	 XSaL4bjBTf8/1m1OvWYF62PLfqGq/HTpoG5vCLvupsj2tgpCDjOIRmKUm2Uk3r37jr
	 wB6RVRTaaVN6w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] ata: sata_dwc_460ex: fix PHY lifecycle ordering on
 device removal
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rosen Penev" <rosenp@gmail.com>
Cc: dlemoal@kernel.org, linux-ide@vger.kernel.org, cassel@kernel.org
In-Reply-To: <20260723001208.1469323-2-rosenp@gmail.com>
References: <20260723001208.1469323-1-rosenp@gmail.com>
 <20260723001208.1469323-2-rosenp@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 00:31:52 +0000
Message-Id: <20260723003153.206A31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Inverted teardown sequence destroys the legacy DMA controller befo=
re its channels are released, causing a use-after-free and crash during dev=
ice removal and probe error handling.
--

--- Patch [1]: [PATCH 1/3] ata: sata_dwc_460ex: fix PHY lifecycle ordering =
on device removal ---
commit dd1760ffad9026f965244b679ddbacf4ae16f4e6
Author: Rosen Penev <rosenp@gmail.com>

ata: sata_dwc_460ex: fix PHY lifecycle ordering on device removal

This commit fixes PHY teardown ordering by calling phy_exit() after
phy_power_off() instead of before, ensuring the PHY is properly powered
down prior to destruction. It also adjusts the error handling in
sata_dwc_probe() to clean up legacy DMA resources if activation fails.

> diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.c
> index 8e3fc713891af..8a1d80ac906a7 100644
> --- a/drivers/ata/sata_dwc_460ex.c
> +++ b/drivers/ata/sata_dwc_460ex.c

[ ... ]

> @@ -1171,29 +1182,26 @@ static int sata_dwc_probe(struct platform_device =
*ofdev)

[ ... ]

>  error_out:
> -	phy_exit(hsdev->phy);
> +#ifdef CONFIG_SATA_DWC_OLD_DMA
> +	if (!device_property_present(dev, "dmas"))
> +		sata_dwc_dma_exit_old(hsdev);

[Severity: High]
This is a pre-existing issue, but does this manual teardown sequence create=
 a
use-after-free for the legacy DMA controller?

By calling sata_dwc_dma_exit_old() here in the probe error path (and
similarly in sata_dwc_remove()), the legacy DMA controller is explicitly
destroyed before the devres unwind actions run.

However, when devres later triggers the ata_host_stop action, it calls
sata_dwc_port_stop(), which does this:

    dmaengine_terminate_sync(hsdevp->chan);
    dma_release_channel(hsdevp->chan);

Since the legacy DMA controller has already been deactivated and removed by
sata_dwc_dma_exit_old(), won't these channel operations in
sata_dwc_port_stop() access the destroyed controller and cause a crash?

> +#endif
>  	return err;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723001208.1469=
323-1-rosenp@gmail.com?part=3D1
