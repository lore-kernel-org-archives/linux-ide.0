Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B52E962809
	for <linux-ide@vger.kernel.org>; Wed,  5 Aug 2026 01:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785892352; cv=none; b=tLeUhWtAVJ5ssKEKBOhzNYa7OGujk0npnhlDB23GcZmf8WadGEX0kztq2Lf83Jj0SHIWtSFmNlRTJHzwFXVcLHsZwC7LcT99DYyGzXRm/83KDqfspj+EBkQxrEiB/Bw07GsC+gwcHXl4Oe45LWR8YNrrRO/KTIsJ657XvfaZZkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785892352; c=relaxed/simple;
	bh=u8t1XG3zQVroVhiBzcGuPvb9KMG05UlQUKOUJnt/l7Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KlRZ5R9qdjqLXixrDK7JQ6sBk2RfADtbXXm+NAUWJ7LE1wSkVHxxO7maBR2k6w1F70u58qVcC1o0kLTM3owuxq1Snn8lD2Ub2Yw/scGCT/2kTdMIcSZxrSZCJ7+dgdvRBdJZOi6qJvNEfdabxSyLHlBPqzjDaiZYiTU2DR/go9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lvKGWxrI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lvKGWxrI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D03F1F000E9;
	Wed,  5 Aug 2026 01:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785892351;
	bh=wzTcaPh6Z6MTKnIjYwLNcPTwSlb6M2+jwV/kBokhKVc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lvKGWxrIFv/VxSWOQiLBJYZUoHVMKwcdGtfnWGMVqS6ZBoMRzj7bWz8m1xtKO8C5D
	 urtfECGCcK0oEvZg1AC9ud23ofwglSnoTcQ3urZwMa1hsL1ep4UZpkey+99R6AM7XB
	 7XRhP8KbrwyOrykaujeSZWSAyiJhcuVW6uc/+9y6D/EBCsO3dql3fGu9JhCICVvS0W
	 sbgjD6S7DNtOCuaa5uruqFHSF/DtxxrvRV5szabUgMB0lSvpDmuWYa0qGUsrQwt9GU
	 CCni1hNdZXdtabhZXITbiypEaLFkS7018/UktE/TNwCr5SGh5W/QjGe7i/hHy71SHP
	 jADK9BdIYXRAA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] ata: sata_mv: init and power phy per-port in port_start
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rosen Penev" <rosenp@gmail.com>
Cc: linux-ide@vger.kernel.org, cassel@kernel.org, dlemoal@kernel.org
In-Reply-To: <20260805010128.90171-1-rosenp@gmail.com>
References: <20260805010128.90171-1-rosenp@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 01:12:30 +0000
Message-Id: <20260805011231.1D03F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Hardware hangs due to unpowered PHY register access.
--

--- Patch [1]: [PATCH] ata: sata_mv: init and power phy per-port in port_st=
art ---
commit f57a0363f1ffdddb1a743417b19db2e65b2fcb67
Author: Rosen Penev <rosenp@gmail.com>

ata: sata_mv: init and power phy per-port in port_start

This commit moves PHY initialization and power management from the probe
and remove paths to the per-port start and stop paths. It also reworks
error handling in probe to rely on devres cleanup.

> diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
> index d260f04e6384b..e811202a68735 100644
> --- a/drivers/ata/sata_mv.c
> +++ b/drivers/ata/sata_mv.c
> @@ -1711,11 +1713,23 @@ static int mv_port_start(struct ata_port *ap)
>  	mv_edma_cfg(ap, 0, 0);
>  	spin_unlock_irqrestore(ap->lock, flags);
> =20
> +	if (phy) {
> +		rc =3D phy_init(phy);
> +		if (rc)
> +			goto out_port_free_dma_mem;
> +
> +		rc =3D phy_power_on(phy);

[Severity: High]
Will this cause hardware hangs or external aborts on access?

It looks like we are calling mv_save_cached_regs() and mv_edma_cfg()
just before this block, while the PHY is still unpowered.=20

Since those functions read and write MAC interface registers, could this
access unpowered hardware?

[ ... ]

> @@ -4144,39 +4157,12 @@ static int mv_platform_probe(struct platform_devi=
ce *pdev)
>  	/* initialize adapter */
>  	rc =3D mv_init_host(host);
>  	if (rc)
> -		goto err;
> +		return rc;

[Severity: High]
Does moving the PHY power on step to port start break host initialization?

When mv_platform_probe() calls mv_init_host() here, the PHY is no longer
powered. However, mv_init_host() can execute PHY register accesses:

mv_platform_probe() -> mv_init_host():
        for (port =3D 0; port < host->n_ports; port++)
                if (hpriv->ops->read_preamp)
                        hpriv->ops->read_preamp(hpriv, port, mmio);

Since operations like read_preamp read and write PHY registers, will this
cause a synchronous external abort during boot?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805010128.9017=
1-1-rosenp@gmail.com?part=3D1
