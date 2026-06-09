Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60CA83BE16F
	for <linux-ide@vger.kernel.org>; Tue,  9 Jun 2026 19:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781035017; cv=none; b=mP6F8QdJo2xFFZsTw6W6kbXY7Re/QvzkrhR0opd3HWXHwYzHKjbUMxjTfyLPYXh2jDhxUIFJVq5V/WyF9yC20RBdnL2Y0hu1FjZSv7f3dVMhOlOMsmQQkBe+Rjb6UmW2knpLcvD0FHlsOphX0vBXw/qCrAZQpP9jP+8RGR3dNhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781035017; c=relaxed/simple;
	bh=svSO92hAArlmYr4vjAfy1qKAEZyj8QupZPQr19nTFDE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=A9AHeTUJ8SVprRksb077E4BKDnM2p3Dj1zeyGpIvpzftxJh5ktX27fjQTqPQq8B7jFwHR3vG/AA8DCkc0XGnVkxDUY5b/1SN89AVLKLWoGYnXhXJqAq11HzlfkRsX6KXCJiUeOw2uaAZ00rQlEcYP4dQ+l4De6LAEcWQ5Cu3oC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MUbwma8V; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MUbwma8V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38DFF1F00898;
	Tue,  9 Jun 2026 19:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781035016;
	bh=FiH7a4UC2Qk0pClqOeVOFmKmdZl1rb8Lu0Mn/xAIi+U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MUbwma8VIuAeEnR0X8W4catK1MuNLUUyVUYCGiBXvbOmexbt53pQbBnJrYaEY9Rmh
	 WJ+ypk1WCIgUyQyiOPrgKO/OdakYtZS4ljNiN8lx7L6BCaN308SiN4o/YwrnFUGg4T
	 cXPK7rJX3A5rX7/gVoIh54iNGvAN2PNlnhww0F6hm4Q5ec08ff6rqW0rDUFo8ViHeA
	 TkaM/+CxNrueNHH+7jOrFL73o3dcbltd2jxBVpYQX1BsIgM+knOaSZkgwnjQmAzy1t
	 tYwqLfqcV48vLdfwjqQT1GNdsAerULy+3splzkbohAVmCss5V3jQIXGYPj/SrWncVp
	 nrduWDvfpNSdA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCHv2 1/5] ata: pata_mpc52xx: fix NULL pointer dereference
 in IRQ handler
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rosen Penev" <rosenp@gmail.com>
Cc: linux-ide@vger.kernel.org, cassel@kernel.org, dlemoal@kernel.org
In-Reply-To: <20260609194311.6217-2-rosenp@gmail.com>
References: <20260609194311.6217-2-rosenp@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 19:56:54 +0000
Message-Id: <20260609195655.38DFF1F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Double free of the `task_irq` mapping due to redundant `irq_dispos=
e_mapping()` calls during error handling and removal.
- [High] Premature destruction of devres-managed IRQ mappings (`task_irq` a=
nd `ata_irq`), causing Use-After-Free of `irq_desc` and memory leaks of `st=
ruct irqaction`.
- [High] The `dmatsk` structure is freed during driver removal or probe fai=
lure while the devres-managed `task_irq` handler is still active, causing a=
 potential Use-After-Free.
- [High] Data race between the BestComm IRQ handler (`mpc52xx_ata_task_irq`=
) and `mpc52xx_bmdma_stop`.
- [High] The DMA FIFO configuration state is not reset upon system resume, =
causing potential DMA transfer failures.
--

commit f162c405b149dd0edca235c5f6814afd5a7a1efd
Author: Rosen Penev <rosenp@gmail.com>

ata: pata_mpc52xx: fix NULL pointer dereference in IRQ handler

Assign priv->dmatsk before request_irq() to ensure the IRQ handler
does not dereference a NULL pointer. The handler accesses priv->dmatsk
via bcom_retrieve_buffer().

> diff --git a/drivers/ata/pata_mpc52xx.c b/drivers/ata/pata_mpc52xx.c
> index 210a63283f62b..fe445d6aaff62 100644
> --- a/drivers/ata/pata_mpc52xx.c
> +++ b/drivers/ata/pata_mpc52xx.c
> @@ -766,6 +766,8 @@ static int mpc52xx_ata_probe(struct platform_device *=
op)
>  		goto err1;
>  	}
> =20
> +	priv->dmatsk =3D dmatsk;
> +
>  	task_irq =3D bcom_get_task_irq(dmatsk);
>  	rv =3D devm_request_irq(&op->dev, task_irq, &mpc52xx_ata_task_irq, 0,
>  				"ATA task", priv);

[Severity: High]
This isn't a bug introduced by this patch, but looking at the error path
for devm_request_irq(), does the cleanup order create a use-after-free?

If the probe fails and jumps to err2, or during driver removal in
mpc52xx_ata_remove(), bcom_ata_release(dmatsk) is called while the IRQ
is still managed by devres.

Because devm_request_irq() won't unregister the handler until after probe
returns or the device is removed, could a spurious interrupt trigger during
this window and cause mpc52xx_ata_task_irq() to dereference the freed
priv->dmatsk pointer?

[Severity: High]
This is a pre-existing issue, but does manually disposing of devm-managed
IRQ mappings cause a use-after-free of the IRQ descriptor?

Both task_irq and ata_irq are requested using devm_request_irq().
However, the driver explicitly calls irq_dispose_mapping() on both IRQs
during err2, err1, and in mpc52xx_ata_remove().

Because irq_dispose_mapping() destroys the underlying irq_desc while the
devres-managed handler is still active, could this lead to a use-after-free
when devres eventually executes free_irq()?

[Severity: High]
This isn't a bug introduced by this patch, but does the cleanup code cause
a double free of the task_irq mapping?

In both the err2 path and mpc52xx_ata_remove(), the driver does:

	irq_dispose_mapping(task_irq);
	bcom_ata_release(dmatsk);

Since bcom_ata_release() calls bcom_task_free(), which also executes
irq_dispose_mapping(tsk->irq) for the same IRQ, doesn't this result in
the irqdomain API being called twice for the same mapping?

[Severity: High]
This is a pre-existing issue, but is there a data race between the DMA
stop function and the IRQ handler?

The mpc52xx_ata_task_irq() handler accesses the task descriptors without
locks and performs a read-modify-write on priv->waiting_for_dma:

mpc52xx_ata_task_irq() {
    ...
	while (bcom_buffer_done(priv->dmatsk))
		bcom_retrieve_buffer(priv->dmatsk, NULL, NULL);

	priv->waiting_for_dma |=3D ATA_DMA_INTR;
    ...
}

Concurrently, mpc52xx_bmdma_stop() can reset the DMA buffers and zero
out priv->waiting_for_dma:

mpc52xx_bmdma_stop() {
    ...
	bcom_disable(priv->dmatsk);
	bcom_ata_reset_bd(priv->dmatsk);
	priv->waiting_for_dma =3D 0;
    ...
}

If these run concurrently without synchronization, could they corrupt the
DMA descriptor state or lose updates to waiting_for_dma?

[Severity: High]
This is a pre-existing issue, but does the resume path properly reset the
DMA FIFO direction cache?

During normal operation, mpc52xx_bmdma_setup() caches the transfer direction
to avoid unnecessary register writes:

mpc52xx_bmdma_setup() {
    ...
		/* Setup FIFO if direction changed */
		if (priv->mpc52xx_ata_dma_last_write !=3D 0) {
    ...
}

When the system suspends, the hardware loses this FIFO state. On resume,
mpc52xx_ata_resume() calls mpc52xx_ata_hw_init() to reconfigure the
hardware, but it does not invalidate priv->mpc52xx_ata_dma_last_write
(e.g., setting it to -1).

If the first DMA transfer after resume matches the pre-suspend direction,
could this skip writing the necessary FIFO configuration registers and
break ATA I/O?

> @@ -773,7 +775,6 @@ static int mpc52xx_ata_probe(struct platform_device *=
op)
>  		dev_err(&op->dev, "error requesting DMA IRQ\n");
>  		goto err2;
>  	}
> -	priv->dmatsk =3D dmatsk;
> =20
>  	/* Init the hw */
>  	rv =3D mpc52xx_ata_hw_init(priv);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260609194311.6217=
-2-rosenp@gmail.com?part=3D1
