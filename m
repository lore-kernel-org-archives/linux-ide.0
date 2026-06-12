Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF7822B8DF
	for <linux-ide@vger.kernel.org>; Fri, 12 Jun 2026 18:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781290005; cv=none; b=Uvi4GpfMPmn7zU5GadfWPYJVbEhpUHePHnu0vZjGLowjBlFkrDMGCx5aCRPcJ7QYe0nwe/oQ8md9sIf4Xc/u5Sn0JghjibWwMS9ruPTJfvcPdgJ0nEwuWviAWjBTlhh1/ean3vlXPue3Kz/X0b6HYBUrOAZTLgn/LruHH906mNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781290005; c=relaxed/simple;
	bh=GvuzuYPt1xxjg0nQOtVOh3iO/Dq5hu/UT37Zh6z9hG4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nYtr30NBGqdssmgGQvyLcSmBm5m/5Y1sWRGcIlQL0+rfGWB1FlOu3C3/HZp4wI0vZZtxhqlMI5s6rFuBnTFmRDQuoygCIO2383JOUBgvMAjRMCgAcjoGeURfdB/6Upv719tu4R5HM9xqQTT2Ke0EkcuQ6shf5h9gwrcb0xp+jnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JXPOWZ8h; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JXPOWZ8h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF93C1F000E9;
	Fri, 12 Jun 2026 18:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781290004;
	bh=bcoKiYnRk11BLId2NXM1SggEIAfMOdRoiKQGk9atIjo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JXPOWZ8hgDdavoaEP0WndlBL4gGV0NRkzNRFWaOqKTBGrzXyr6pzvbGXIh4upT/8L
	 Nmk+dpinkiDq4Y0+cAzQYvpCkqNc1b5r2f7abJmjx5WvK4BxrFYclmh/fjR0vvC7En
	 BHPXtMVdPsUp17AoEVGJVpFsLSU7QQ9NiUjd+YtyzkmP097qgKJdPPDHgKLzJd88LL
	 sd/dE5PUMG8NTAfzBMK0IOz2OgpwHqrjPyB8UX90sQjxmzaoV53Uia67rFs5Np3/3v
	 P2atsfks/001SMTHaM2H+oph4B3vKj7xsIEi7vP+GgVBc/IVFUf/dKyJ6tP5NxtdeD
	 v1yl7meQ4vNeA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCHv3 1/6] ata: pata_mpc52xx: fix NULL pointer dereference
 in IRQ handler
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rosen Penev" <rosenp@gmail.com>
Cc: cassel@kernel.org, dlemoal@kernel.org, linux-ide@vger.kernel.org
In-Reply-To: <20260612183227.20446-2-rosenp@gmail.com>
References: <20260612183227.20446-2-rosenp@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 Jun 2026 18:46:43 +0000
Message-Id: <20260612184643.CF93C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Improper resource teardown of the devm-managed BestComm DMA task I=
RQ, leading to Double Dispose and devres Use-After-Free.
--

commit a85012a47d328b796b5de199b02e054be9b1d391
Author: Rosen Penev <rosenp@gmail.com>

ata: pata_mpc52xx: fix NULL pointer dereference in IRQ handler

Assign priv->dmatsk before request_irq() to ensure the IRQ handler does not
dereference a NULL pointer. The handler accesses priv->dmatsk via
bcom_retrieve_buffer().

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
> @@ -773,7 +775,6 @@ static int mpc52xx_ata_probe(struct platform_device *=
op)
>  		dev_err(&op->dev, "error requesting DMA IRQ\n");
>  		goto err2;

[Severity: High]
This is a pre-existing issue, but I noticed a potential problem with the
resource teardown when jumping to the err2 label.

When failures occur later in mpc52xx_ata_probe() (like hw_init failing), the
code jumps to the err2 label and manually disposes the IRQ mapping:

drivers/ata/pata_mpc52xx.c:mpc52xx_ata_probe() {
    ...
 err2:
	irq_dispose_mapping(task_irq);
	bcom_ata_release(dmatsk);
    ...
}

Because the IRQ was successfully requested with devm_request_irq() earlier,
does manual disposal destroy the IRQ descriptor before devres runs its own
cleanup, leading to a use-after-free when the IRQ core attempts to free
the action?

Additionally, right after this manual disposal, bcom_ata_release() is calle=
d,
which delegates to bcom_task_free(). This function also disposes the mapping
natively:

drivers/dma/bestcomm/bestcomm.c:bcom_task_free() {
    ...
	/* Free everything */
	irq_dispose_mapping(tsk->irq);
	bcom_sram_free(tsk->bd);
    ...
}

Since task_irq and tsk->irq are the same, could this double disposal of the
IRQ mapping corrupt the IRQ domain state and trigger internal kernel warnin=
gs?
The same pattern appears to exist in mpc52xx_ata_remove() during module
removal.

>  	}
> -	priv->dmatsk =3D dmatsk;
> =20
>  	/* Init the hw */
>  	rv =3D mpc52xx_ata_hw_init(priv);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260612183227.2044=
6-2-rosenp@gmail.com?part=3D1
