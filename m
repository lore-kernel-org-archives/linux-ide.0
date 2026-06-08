Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B31837AA9E
	for <linux-ide@vger.kernel.org>; Mon,  8 Jun 2026 21:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780955969; cv=none; b=oOn/dRyf/9ChqVCHt7LL4EansQYNvbQ8SUJ7B6xniwP/b9RCPjhc25W7WMqJFHv4FwWEdsmbLa4uswRP2JlPHO+ixkZnLTK4yGAacX4nMmKeVsW9zUhcHinRvoeh8TDiB39VNibj7ooERJmGJmBGRhkZcVlTI+SfVqQdYlK3dq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780955969; c=relaxed/simple;
	bh=sEmYonIqEX80gQ+bTX7o5XF2YbrA8F8CTNVuw3qWfJs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=h/Qnqhlpw9zEiPJCZkDQ77eSF8upvpFJHceqXbRF+k/CiAKqEJaskCqKor97+1Pf1QpEiuRvpwyxTRlpGhAECjN1lZoHepVJz9FhQSOr/2Zkrr5+2ZAX+/zTWL39e6QikPfRcERvGBd22sa3wxYwHfKJZLthkVii9ED0eDnYV6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j+r6QpEa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j+r6QpEa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D625B1F00893;
	Mon,  8 Jun 2026 21:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780955968;
	bh=vnXdiQXK60JHjmZTKSGasvmiuO0PkNgXPPZLc/5Xeqc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=j+r6QpEabphX66ePTSugmKPsGEXWp3ifZ46EzJtOJFm35GFrrZTTomQVaPd/IRV1p
	 r4YveOMnR6H2d4/W9PACEH/CPDfpTAnP6o4d9GeWVI574ozA3zTrEn49Drnzy3ub8X
	 m5ZeLIVSrjFx2RGxjFmnv8BJ7kboEv1HfvqhxQrZWllb/9QyRn4sAMJJE4xUC+RA5U
	 k6GEgvDnbEZClQ4yTLSCiS4DnRvV+FLuizQCC/ltGj1Qy5QcwQpXSymBG/IYyHnwOd
	 9OGgl6PHBtI1R/KnUM7ue6HlmsGWazoObma7MTbO+C2Qzvwzlx8lkGYOibsUS72XN4
	 7kfviaHumHorA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/4] ata: pata_mpc52xx: switch to non-devm request_irq
 for proper ordering
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rosen Penev" <rosenp@gmail.com>
Cc: linux-ide@vger.kernel.org, dlemoal@kernel.org, cassel@kernel.org
In-Reply-To: <20260608214718.49503-2-rosenp@gmail.com>
References: <20260608214718.49503-2-rosenp@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 21:59:26 +0000
Message-Id: <20260608215927.D625B1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The IRQ handler `mpc52xx_ata_task_irq` is registered and unmasked =
before the driver's private state (`priv->dmatsk`) is fully initialized, cr=
eating a window where an immediate interrupt could trigger a NULL pointer d=
ereference.
--

commit 51800f0b7ed178011074a74c7015353a1624d9fd
Author: Rosen Penev <rosenp@gmail.com>

ata: pata_mpc52xx: switch to non-devm request_irq for proper ordering

This patch replaces devm_request_irq with request_irq for the BestComm
task IRQ to ensure the interrupt is unregistered before bcom_ata_release()
tears down the task. This fixes a race condition during device removal or
error paths where the handler could access freed memory.

> diff --git a/drivers/ata/pata_mpc52xx.c b/drivers/ata/pata_mpc52xx.c
> index 210a63283f62b..9af0aa89a5c66 100644
> --- a/drivers/ata/pata_mpc52xx.c
> +++ b/drivers/ata/pata_mpc52xx.c
> @@ -767,11 +767,11 @@ static int mpc52xx_ata_probe(struct platform_device=
 *op)
>  	}
> =20
>  	task_irq =3D bcom_get_task_irq(dmatsk);
> -	rv =3D devm_request_irq(&op->dev, task_irq, &mpc52xx_ata_task_irq, 0,
> -				"ATA task", priv);
> +	rv =3D request_irq(task_irq, &mpc52xx_ata_task_irq, 0,
> +			  "ATA task", priv);
>  	if (rv) {
>  		dev_err(&op->dev, "error requesting DMA IRQ\n");
> -		goto err2;
> +		goto err_free_task;
>  	}
>  	priv->dmatsk =3D dmatsk;

[Severity: High]
This is a pre-existing issue, but could this ordering cause a NULL pointer
dereference if an interrupt fires immediately after registration?

In mpc52xx_ata_probe(), the IRQ is requested and enabled before the DMA
task pointer is assigned to the driver's private state. Since priv is
allocated with devm_kzalloc(), priv->dmatsk is NULL during the
request_irq() call.

If a pending or spurious interrupt fires before the priv->dmatsk assignment
completes, the handler is invoked and dereferences the uninitialized pointe=
r:

mpc52xx_ata_task_irq()
    while (bcom_buffer_done(priv->dmatsk))
        bcom_retrieve_buffer(priv->dmatsk, NULL, NULL);

Should priv->dmatsk be assigned to the private structure before registering
the interrupt handler to avoid this window?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608214718.4950=
3-1-rosenp@gmail.com?part=3D1
