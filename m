Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC6F419310
	for <linux-ide@vger.kernel.org>; Wed,  8 Jul 2026 09:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783503319; cv=none; b=WZSOJhDJQ+eDNYl+yy2YS+Uq0tp83q55Az4NOlL5GI/jDRJFiuV+c5aRVD+8OQnSsv4Xb8XrgcSuC3Bh5jOGnCxKueQNxPmygujhTuunoANeYJiJpDDgtPqP4tUO0PQJfO0Ogmr5D+yqBnbIfV2vLi9NwwvNnAGB1fRoEV7if8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783503319; c=relaxed/simple;
	bh=sNXwauNzD+flAtkNqQ27Do6IVSPEJIlTde/IeH4XHq8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NptN0G0yO5Q0ggIvCs9MEkJoyNo8HcmN15+96D7vMErCWQBpdJ0TwaM6/HguQ7iDgPcgN/weyrQunStqfzHhnz7anrBj8f8/KX0rpkxODOxPTyjlnieh7UWeAGYy0pcCPMfEUdIT11SgUynlYBaqZcGgsVjJnh8deQa2IJmFXq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bg+1aezm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bg+1aezm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 829931F000E9;
	Wed,  8 Jul 2026 09:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783503316;
	bh=JrH1FqiWWc5i7DngvqILNAJFhx2uDRN9wo/wITIAphg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Bg+1aezmDCAn42clf/xz/Hs83mQI2q7IA9ktIIdkCjT+07USLxCDxkRgRJiRk4iNZ
	 FproV6WXSthGlCHMGTu84IBQ9lghQl73bTYLj6I+hoZ4nWA+tsldfvuMhXrPZSJWk0
	 08+ZHF6gBVi8Bfg007smLYDslT0yBtVeciXa7bii8j2+mdU26oJnUox5oEQCD7Xl0U
	 kcmDCJNZymZggosttBi3XB4dod1iB8KiFO0v104UAfNPZ9WaIQxwGyV9WP7zh5o7ZH
	 WEvBNV8hJU2FFkspkRg8n56wqc04Eg2vjZ9jQRyn2ip2fJR7KWxsyH6zq8LcVn77mj
	 4OSMmCRa4fznQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] ata: pata_ep93xx: fix double-free of DMA channel on
 error path
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chen Changcheng" <chenchangcheng@kylinos.cn>
Cc: linux-ide@vger.kernel.org, dlemoal@kernel.org, cassel@kernel.org
In-Reply-To: <20260708092704.60815-1-chenchangcheng@kylinos.cn>
References: <20260708092704.60815-1-chenchangcheng@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 09:35:16 +0000
Message-Id: <20260708093516.829931F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Probe fails entirely instead of falling back to PIO mode when DMA =
channels are not available.
--

--- Patch [1]: [PATCH] ata: pata_ep93xx: fix double-free of DMA channel on =
error path ---
commit 5d77ddcea9fce813ec9dad68a5d5fe3f97dacb61
Author: Chen Changcheng <chenchangcheng@kylinos.cn>

ata: pata_ep93xx: fix double-free of DMA channel on error path

This commit fixes a double-free of the rx DMA channel and a potential inval=
id
release of an ERR_PTR tx channel in the ep93xx_pata_dma_init() error path.
It achieves this by updating ep93xx_pata_release_dma() to safely check using
IS_ERR_OR_NULL() and adjusting the error jump labels.

> diff --git a/drivers/ata/pata_ep93xx.c b/drivers/ata/pata_ep93xx.c
> index 42a24dc51d26b..b4fb89481b7ee 100644
> --- a/drivers/ata/pata_ep93xx.c
> +++ b/drivers/ata/pata_ep93xx.c
[ ... ]
> @@ -664,7 +664,7 @@ static int ep93xx_pata_dma_init(struct ep93xx_pata_da=
ta *drv_data)
>  	if (IS_ERR(drv_data->dma_tx_channel)) {
>  		ret =3D dev_err_probe(dev, PTR_ERR(drv_data->dma_tx_channel),
>  				    "tx DMA setup failed\n");
> -		goto fail_release_rx;
> +		goto fail_release_dma;

[Severity: High]
This is a pre-existing issue, but does this error path prevent the driver
from falling back to PIO mode?

In ep93xx_pata_probe(), the driver aborts entirely if ep93xx_pata_dma_init()
returns an error:

ep93xx_pata_probe() {
    ...
    err =3D ep93xx_pata_dma_init(drv_data);
    if (err)
        return err;
    ...
}

If dma_request_chan() returns an error (like -ENODEV when DMA is not
configured in the Device Tree), the error is propagated via dev_err_probe().

Would it be better to treat missing DMA channels as a soft failure so the
device can still initialize and operate in PIO mode?

>  	}
> =20
>  	/* Configure receive channel direction and source address */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708092704.6081=
5-1-chenchangcheng@kylinos.cn?part=3D1
