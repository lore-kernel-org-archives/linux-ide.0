Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0A23DA5AA
	for <linux-ide@vger.kernel.org>; Mon,  1 Jun 2026 18:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780339452; cv=none; b=Vu8TmpH87lO0NoW/GfPjjTnFkgmt520TWbbYKXnOKF0XIAdUgXsT66RoVM6Ia1aBGZfVWNZr++3BWjiWeMcvDtLGdOV3Ck0CVfpofLrnmMX0yc51ibKdZ7suKYNhX9dAI8s2AnbFMxg7Di3qvwLFvVT25Zn7tPxyBDbiU5fpNnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780339452; c=relaxed/simple;
	bh=BaAx2nrCzNEgFVz9ZqpaW8oMG5vZ7fHR/9ZSXe1krv8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UrFwq45grblXtKvqkE+iCOK5z0e+zF5zJAWBynvdaAUf66cci/EIToTiZz62JMeCpjR00KkbQBFIDKj1EizcgkGyVVQQ/KKii7keGIdDk3t8PjiRzX2EPq5xXf72ETTy1YULTfP2xa/mXXl5xdurXZAPlAHPpeljJytjzefJ0Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aD/OwkSB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aD/OwkSB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1CF21F00893;
	Mon,  1 Jun 2026 18:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780339450;
	bh=FxS15N9AYkCXakqSVET6TTMZrNJXlPPXm3D8ET1P0kA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aD/OwkSBh7EgnVb3rYL2/y4p3d3S9zURUX6dYtbhoMT4LfSkJqx36fpV0IIVCBaWD
	 loT6bQNX+oqPsLJblbf2OUIu+HmV9jpPq+DsCXYiqmxlV8PV3bcuegZXK4TKrdCpX3
	 k1sFC+nYTI+Fev5X2epQz+fdv+D6F8y0gUjWd5wUgdxZR4QqQ74LrVk6R0S1Vt5DXr
	 KWueG1Fl1ii89AiUogsR9VDgMtNePUrzqM1c9p11bROsZyofOfF0w0EL1dwhLMWXGW
	 KInIAlzgnM+lvSDKte963/F11T9PIxiVl3NEcMIXSv+HbVjbkR4h7ytI5QruAmpiOq
	 Em5VI4JDQaaYg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] ata: pata_ep93xx: fix double free and ERR_PTR
 dereference on DMA error path
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rosen Penev" <rosenp@gmail.com>
Cc: linux-ide@vger.kernel.org, dlemoal@kernel.org, cassel@kernel.org
In-Reply-To: <20260601183359.11343-1-rosenp@gmail.com>
References: <20260601183359.11343-1-rosenp@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 01 Jun 2026 18:44:09 +0000
Message-Id: <20260601184409.C1CF21F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The PATA driver fails to initialize if DMA channels are not availa=
ble, breaking the PIO-only fallback mode.
- [High] Trailing byte transfer logic in PIO data transfer truncates 16-bit=
 values, leading to data corruption on big-endian systems.
--

commit 01fbd237d0698dff8591ae6c458732b482391c35
Author: Rosen Penev <rosenp@gmail.com>

ata: pata_ep93xx: fix double free and ERR_PTR dereference on DMA error path

This commit fixes a double free of the rx channel and an invalid pointer
dereference of the tx channel on the DMA initialization error path. By
NULLing the tx channel before calling the release function, the cleanup
is handled correctly.

> diff --git a/drivers/ata/pata_ep93xx.c b/drivers/ata/pata_ep93xx.c
> index b2b9e0058333e..aa6f8172925d5 100644
> --- a/drivers/ata/pata_ep93xx.c
> +++ b/drivers/ata/pata_ep93xx.c
> @@ -688,7 +688,7 @@ static int ep93xx_pata_dma_init(struct ep93xx_pata_da=
ta *drv_data)
>  	return 0;
> =20
>  fail_release_rx:
> -	dma_release_channel(drv_data->dma_rx_channel);
> +	drv_data->dma_tx_channel =3D NULL;

[Severity: High]
This isn't a bug introduced by this patch, but since we are modifying the
error paths in ep93xx_pata_dma_init(), does this initialization failure
unintentionally break the PIO-only fallback?

Looking at the start of ep93xx_pata_dma_init(), if dma_request_chan()
returns -ENODEV because no DMA channels are available in the device tree:

	drv_data->dma_rx_channel =3D dma_request_chan(dev, "rx");
	if (IS_ERR(drv_data->dma_rx_channel))
		return dev_err_probe(dev, PTR_ERR(drv_data->dma_rx_channel),
				     "rx DMA setup failed\n");

This error propagates directly back to ep93xx_pata_probe():

	err =3D ep93xx_pata_dma_init(drv_data);
	if (err)
		return err;

Does this abort the probe entirely on systems without DMA, rather than clea=
nly
dropping DMA support and allowing the driver to fall back to PIO mode?

>  fail_release_dma:
>  	ep93xx_pata_release_dma(drv_data);
> =20

[Severity: High]
This is a pre-existing issue, but could the trailing byte transfer logic in
ep93xx_pata_data_xfer() truncate 16-bit values and cause data corruption on
big-endian systems?

In ep93xx_pata_data_xfer(), the pad variable is an array of 2 bytes:

	unsigned char pad[2] =3D { };

On the READ path, a 16-bit value is assigned directly to *pad:

	if (rw =3D=3D READ) {
		*pad =3D cpu_to_le16(
			ep93xx_pata_read_data(
				drv_data, IDECTRL_ADDR_DATA));
		*buf =3D pad[0];

Doesn't this truncate the 16-bit integer to its lowest 8 bits? On a
little-endian CPU this evaluates to the correct first byte, but on a
big-endian CPU, cpu_to_le16() places the first byte into the upper 8 bits,
which are lost during truncation.

Similarly, on the WRITE path:

	} else {
		pad[0] =3D *buf;
		ep93xx_pata_write_data(drv_data, le16_to_cpu(*pad),
				  IDECTRL_ADDR_DATA);
	}

Will le16_to_cpu(*pad) zero-extend the 8-bit pad[0] value to a 16-bit
integer, resulting in 0x00BB instead of 0xBB00 before byte swapping,
ultimately writing 0x00 as the first byte of the transfer? Would casting
to a 16-bit pointer better manage memory across endianness boundaries here?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260601183359.1134=
3-1-rosenp@gmail.com?part=3D1
