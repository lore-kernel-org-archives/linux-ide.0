Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218063E6DEB
	for <linux-ide@vger.kernel.org>; Tue,  8 Sep 2026 21:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788904528; cv=none; b=Cy0BAXt/VMXN8m98LHviQZIAL1GLsNDmorqrm1tm2se4Z5lZhn50FOZ5lG+japh6UHFSnzcKo8HGi9udDSp8AuehqC9Adls+ETLTww+iWsuBiZpsSH0EVpDrufueMC8BTraajzm5cKD+52prxJfECxvMo8m7mOvqXMNHZOtbFCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788904528; c=relaxed/simple;
	bh=NDaxiO2JWGz+JbPrI0KXj39KtnpWhs4GnTTlHn/3nPA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rfCPHfQiVPNsHPla3rAc5xkbLlsFE9Rrhx9GXtzCaOYHaCJ3Wck6mv082BXQcMK8L92igwNWFSLDT30RwSJRuZL4b18/cpOqKCLLWHuWURfYVE4SFYsWoCpI5MMiVm1iMrsRIm9pQXvRXSky4Lv0hkJgZdZXn10SOPNjEOa3hx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X7wmdK0E; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X7wmdK0E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BDB71F00A3A;
	Tue,  8 Sep 2026 21:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788904526;
	bh=vP/rYLK0NMLVd9OhZAu1jug8va9359FPWejL3GHQNfQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=X7wmdK0ERSzzMn1A54XIWPi0h3B3avj2ksTAx1RFhy8QaFRYJUiz+uZdrlrQ5fBCo
	 6ulsszXfJolobqF9SA8Jda/pXkBVDSHcWiQ7epN5/l1yx8evn7fPmWxvRnb6nAxQOk
	 Oi/mXXCtkysqH3vLIFtpE4zUxDIaHkORNub/1qXIYjw6dYgTwkgZZ5IrE3SH+a9OGj
	 U1sUJw8NLd5xr1Xar22TvMYwO61jGuqSeRjiy9G1bbEWwfCtncPRKBUCr7OyRcpH9W
	 XKlRV/NtlgOmbyNigrtAL2hbVGy9iT4prnmzk2MkuOHC4LvXmcUhFtOfPuDRdkSioJ
	 7oRVUGivKdC0g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCHv2] ata: sata_dwc_460ex: fix PHY lifecycle ordering on
 device removal
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rosen Penev" <rosenp@gmail.com>
Cc: dlemoal@kernel.org, cassel@kernel.org, linux-ide@vger.kernel.org
In-Reply-To: <20260908213957.596103-1-rosenp@gmail.com>
References: <20260908213957.596103-1-rosenp@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 21:55:26 +0000
Message-Id: <20260908215526.6BDB71F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] dma_release_channel() and dmaengine_terminate_sync() access a dest=
royed DMA controller during device removal and probe failure.
--

commit 620563c58971e90128eb05275238e22226efc115
Author: Rosen Penev <rosenp@gmail.com>

ata: sata_dwc_460ex: fix PHY lifecycle ordering on device removal

This patch fixes the PHY lifecycle ordering in sata_dwc_remove() by ensuring
phy_power_off() completes before phy_exit() is called. It moves phy_exit()
into sata_dwc_port_stop() and reworks the error paths in probe accordingly.

> diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.c
> index 8e3fc713891af..8a1d80ac906a7 100644
> --- a/drivers/ata/sata_dwc_460ex.c
> +++ b/drivers/ata/sata_dwc_460ex.c
[ ... ]
> @@ -1171,29 +1182,26 @@ static int sata_dwc_probe(struct platform_device =
*ofdev)
[ ... ]
>  	err =3D ata_host_activate(host, irq, sata_dwc_isr, 0, &sata_dwc_sht);
> -	if (err)
> +	if (err) {
>  		dev_err(dev, "failed to activate host");
> +		goto error_out;
> +	}
> =20
>  	/* Enable SATA Interrupts */
>  	sata_dwc_enable_interrupts(hsdev);
>  	return 0;
> =20
>  error_out:
> -	phy_exit(hsdev->phy);
> +#ifdef CONFIG_SATA_DWC_OLD_DMA
> +	if (!device_property_present(dev, "dmas"))
> +		sata_dwc_dma_exit_old(hsdev);
> +#endif

[Severity: High]
This isn't a bug introduced by this patch, but this patch copies a broken
teardown sequence into the probe error path in drivers/ata/sata_dwc_460ex.c.

If ata_host_activate() fails, the DMA controller is explicitly destroyed he=
re
by sata_dwc_dma_exit_old(). Devres will then later clean up the ATA host by
calling ata_host_stop(), which invokes sata_dwc_port_stop().

sata_dwc_port_stop() calls dmaengine_terminate_sync() and
dma_release_channel(). Will this result in a use-after-free and an invalid
hardware access to the already suspended and destroyed DMA controller?

>  	return err;
>  }
> =20
> @@ -1205,8 +1213,6 @@ static void sata_dwc_remove(struct platform_device =
*ofdev)
> =20
>  	ata_host_detach(host);
> =20
> -	phy_exit(hsdev->phy);
> -
>  #ifdef CONFIG_SATA_DWC_OLD_DMA
>  	/* Free SATA DMA resources */
>  	sata_dwc_dma_exit_old(hsdev);

[Severity: High]
This is a pre-existing issue, but it is present in the device removal path
within sata_dwc_remove() in drivers/ata/sata_dwc_460ex.c.

During device removal, sata_dwc_remove() explicitly tears down the DMA
controller via sata_dwc_dma_exit_old(). When devres subsequently cleans up =
the
ATA host, it invokes sata_dwc_port_stop() which calls
dmaengine_terminate_sync() and dma_release_channel().=20

Could this cause a hardware fault and logical use-after-free by accessing t=
he
unregistered DMA structures?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908213957.5961=
03-1-rosenp@gmail.com?part=3D1
