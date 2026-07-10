Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF77E33C52F
	for <linux-ide@vger.kernel.org>; Fri, 10 Jul 2026 11:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783682149; cv=none; b=ZW1FVhD5d0H7ich8GZVNijuBdqJIDFO/PUQT/3JAfLKThGbGA4GgsE3nvcgNtu1FCfPgBYigggqb4y0jidQMqdgY57sjTOnJaMWzYqngJgl3ICJjWU0PHHdLjzH275T7GW3ZiBjVUxFtU3BR7ZDGbdMWqNqmOkoboXlgiln6rDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783682149; c=relaxed/simple;
	bh=HVrstwj7CliDnYrpq3UVgYAbw7+tAL5/fT8dHFVMPwU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dz6++bp/9UAF/yt7Rfm7Zpyy40KvcS9vVanA7MBw1nVj0IclZl1LmFsrQjHmF5dlfFknofLg95GCI2AiNHbCBxkWO68/wnPJa0uXGseNgeJM3wrgv2Za0AKptNDXL2IDr5zlCVuNW/OnSDB2nYPcHujcpFXkqeJ793pETexjMwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XkL34D8o; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XkL34D8o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C3061F01559;
	Fri, 10 Jul 2026 11:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783682147;
	bh=B1/KYyh5lwv/QU5rCL9NLHG4PT3cMdJ9+NlADFm7xQc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XkL34D8o2U5ociTn1HixJLIBtu+YNHrh913JGD502/nWzcezoPdluoJkYWyyLxrud
	 ZiEQmlz0AUYk0dIpzBQAlFTzY0c9Qx9UMrem0ifDAhA9cYurHWHVPOKXWy7/Q3VNdg
	 XT92A9jBllR54EB/Cr09AMtfS+zC5mFwraToh3wwo2+NyAyg66fbWaxTm7PVj0cE80
	 UGGaatEW3uzZ2ZXMNsOrkGKYYCB0j5K3ZsN5ZaBmlgnrxJzN1EGqpT2D9mVBK5oCjD
	 OHuMT3sRU59rnRdIz37GxeREyF8FPWswej5IEAzp3KBybeSD/OFklACHatDt0gYtNj
	 ErFWt7OcSmWUQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] ata: Remove redundant dev_err()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pan Chuang" <panchuang@vivo.com>
Cc: linux-ide@vger.kernel.org, dlemoal@kernel.org, cassel@kernel.org
In-Reply-To: <20260710110247.426444-1-panchuang@vivo.com>
References: <20260710110247.426444-1-panchuang@vivo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 11:15:46 +0000
Message-Id: <20260710111547.1C3061F01559@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Double Free of IRQ Mapping
- [High] Memory Leak of irqaction (Devres Conflict)
--

--- Patch [1]: [PATCH] ata: Remove redundant dev_err() ---
commit c11d795c8457981d78fb45735e5126724a48c0df
Author: Pan Chuang <panchuang@vivo.com>

ata: Remove redundant dev_err()

Since devm_request_irq() automatically logs error messages on failure,
this commit removes the redundant driver-specific dev_err() call from
the probe path.

> diff --git a/drivers/ata/pata_mpc52xx.c b/drivers/ata/pata_mpc52xx.c
> index 210a63283f62b..1739743427cfc 100644
> --- a/drivers/ata/pata_mpc52xx.c
> +++ b/drivers/ata/pata_mpc52xx.c
> @@ -769,10 +769,8 @@ static int mpc52xx_ata_probe(struct platform_device =
*op)
>  	task_irq =3D bcom_get_task_irq(dmatsk);
>  	rv =3D devm_request_irq(&op->dev, task_irq, &mpc52xx_ata_task_irq, 0,
>  				"ATA task", priv);
> -	if (rv) {
> -		dev_err(&op->dev, "error requesting DMA IRQ\n");
> +	if (rv)
>  		goto err2;

[Severity: High]
This is a pre-existing issue, but I noticed a potential double free of the
IRQ mapping and a memory leak related to this error path.

If devm_request_irq() fails, the code jumps to the err2 label:

 err2:
	irq_dispose_mapping(task_irq);
	bcom_ata_release(dmatsk);

Does this cause a double free of the IRQ mapping? The bcom_ata_release()
function internally calls bcom_task_free(), which also unconditionally calls
irq_dispose_mapping(tsk->irq) on the same task_irq.

Additionally, can these manual irq_dispose_mapping() calls in the err1 and =
err2
paths (and similarly in mpc52xx_ata_remove()) cause the irqaction structures
to leak?

Because devm_request_irq() is used, the devres cleanup runs after the probe
function returns. If the IRQ mapping is already manually disposed of here,
irq_dispose_mapping() removes the descriptor. When devres later invokes
free_irq(), it will find a NULL descriptor and return early, skipping the
kfree() for the irqaction structure.

> -	}
>  	priv->dmatsk =3D dmatsk;
> =20
>  	/* Init the hw */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710110247.4264=
44-1-panchuang@vivo.com?part=3D1
