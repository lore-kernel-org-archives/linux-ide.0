Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6599357739
	for <linux-ide@vger.kernel.org>; Fri, 31 Jul 2026 21:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785531893; cv=none; b=dpQIThSLzjHPkGf4SbA4Gpjxp6ItCy4WK22NYAO4JD5H6leY19lygMb5QdopDKMFGgGOXlGXUEfK7o/dgsTAy8iuymSzKowDyIg/yAfaMESxWK7yMdwtyjG33NwJF7rZa6UBwMSWuaU1uJAXIiqiua6nTAVa24XnqHb4yRipj98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785531893; c=relaxed/simple;
	bh=oGweLmh5jqBx+ek9F8whXs0D5bV8TfrPH22BdquEPW8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nwWWMt/Zf2dgPCVmBCLPalsPwXFQCu+3VI8ZIAdR0mn9pGBHt/wRgn5ygqJPobejxjziDnjUAqhAVLU/Z7UvTiD2JV37Df/t5k6jYJarxv0AD8RR/zHQncsYI0SbyvCLXbdQggBkTn2Mz+7XP18DE5UiP0zOxNT4F/K5Xdi8Emc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JthbM6gn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JthbM6gn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B0891F00AC4;
	Fri, 31 Jul 2026 21:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785531891;
	bh=Rf3C3zz1RSuFfGVRo/CN4b7LvICAj5riW7GcmeOeHcw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JthbM6gnupBVDrp3yq7i5EbKeDFCML+gkMguP3s+S0r1bp2gfZmKGQ66QzTQoJb4S
	 BTmhL20SlOdPrVpWJazLYUIjtnuEAhWLgSP1B+b/9GROv2OtsUMcNSMv68uDBSnQ5S
	 K1a6O3wBssYbHfRlYv0WhsLcZW1vlcJfclNYEf7iIjNch5GSJzKkOWWHxj+w/oY9+U
	 ExkWPq/hFgAXHLS+UNHImCCQT//dYCPwt/MvCdddozEpjE++e3TsLdsSPQQ23yNOlG
	 iY7TbwpVGOAPqgWoVjz/WGBt/YMbuTjh3/AbwpUxcQk0pHCuNZ9WlI0TiOr4lShpsG
	 EmAyRY/VyWNWw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCHv3] ata: pata_ep93xx: add missing "cc" and "memory"
 clobbers to inline asm
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rosen Penev" <rosenp@gmail.com>
Cc: cassel@kernel.org, dlemoal@kernel.org, linux-ide@vger.kernel.org
In-Reply-To: <20260731205338.8011-1-rosenp@gmail.com>
References: <20260731205338.8011-1-rosenp@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 21:04:50 +0000
Message-Id: <20260731210451.3B0891F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Double free and ERR_PTR dereference in DMA initialization error pa=
th.
--

--- Patch [1]: [PATCHv3] ata: pata_ep93xx: add missing "cc" and "memory" cl=
obbers to inline asm ---
commit 05e8a0e6eff7bdb5719b3840e3f01ca22df401f7
Author: Rosen Penev <rosenp@gmail.com>

ata: pata_ep93xx: add missing "cc" and "memory" clobbers to inline asm

This commit adds "cc" and "memory" clobbers to the inline assembly in
ep93xx_pata_delay(). It prevents compiler optimizations from incorrectly
reordering flag-dependent instructions or I/O accesses.

> diff --git a/drivers/ata/pata_ep93xx.c b/drivers/ata/pata_ep93xx.c
> index 42a24dc51d26b..813e72425e6f7 100644
> --- a/drivers/ata/pata_ep93xx.c
> +++ b/drivers/ata/pata_ep93xx.c

[ ... ]

[Severity: High]
This is a pre-existing issue, but does the error path in
ep93xx_pata_dma_init() result in a double-free and an invalid pointer
dereference if tx DMA setup fails?

When dma_request_chan(&pdev->dev, "tx") fails, it returns an ERR_PTR
which is assigned to drv_data->dma_tx_channel. The code then jumps to
fail_release_rx:

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

In fail_release_rx, dma_release_channel() is called but
drv_data->dma_rx_channel is not set to NULL.

The code then falls through to ep93xx_pata_release_dma():

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

Will this cause dma_release_channel() to be called a second time for
dma_rx_channel since the pointer is still truthy?

Additionally, since dma_tx_channel contains an ERR_PTR rather than NULL,
won't the truthy check pass and cause an invalid pointer dereference in
dma_release_channel()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731205338.8011=
-1-rosenp@gmail.com?part=3D1
