Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0775022083
	for <linux-ide@vger.kernel.org>; Thu,  2 Jul 2026 00:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782951223; cv=none; b=tTY/y1voXeEwC4dcwx9kDrIQcxyYB66or78VuV/3rZVk9hpX3byr1JrUvF+wcb6cM8p6zshAzkiJaLB91uquH0cFrATxglegwQM6X2IEwkblMkPh7qRYSYXz/qw4SXKKR6oq2xfbgwuLoooe4ScgEEHESQzbMzlPdS9SzOtLjLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782951223; c=relaxed/simple;
	bh=bEuQQ8jJIGQyuWiz+mY7xQJKoJYnOKSUEptlEfN9uXg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HCJbdE4HB0ASRaDoFMQhJHnNnSfdVLK4ef/uDEn9lYJ9Pv+cdIEpytSdkSb/kX7wEOtWVui54683X8tdELZpz+Bh/Tq4uIJCURA/EXPXsfUb9vwQDvaAvL73PjVcX5+hEPd0mED14+G18j+ENPTDu6PNZUVv5TjYzs1tAOlXCUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OEvi1xf1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OEvi1xf1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD7041F000E9;
	Thu,  2 Jul 2026 00:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782951221;
	bh=I41WqFqXjb5SDTCR9OqgS2NoJdp+rolqRt1pe8nOzTc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OEvi1xf1f3ufx74599n17IPxI2TGoPef66BYjBfFSLy7qcTHNi5lwx8AQomlm/vX/
	 5tG+rJVgZPjt/+VayS/raYo198UIDNjAv8RPkD7ch7/Lo1+e9q3uHFcfKS0rIRmRoA
	 Oyixp9QD/y7d2Qv+tNHhR+HE1RS/h5W9yqxOGBij56U3B4M/Q1g79CQ6IiZcGx25Wa
	 dH0Js1f6JKTHQOP9v7hjI3FaUfscGwBCvj84XFFf748StdTIiWWYylnkr/NLKAlw9K
	 DJYi9a8t/dX1jLGTKO+khOW4nPzyg5mPuOq1pJMH3vG8qY7ocmvpbxB5ZXR5JdBitJ
	 zhf10FoA6jn2Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCHv2 4/8] ata: sata_dwc_460ex: drop redundant struct copy
 of port_info
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rosen Penev" <rosenp@gmail.com>
Cc: linux-ide@vger.kernel.org, cassel@kernel.org, dlemoal@kernel.org
In-Reply-To: <20260702000350.68331-5-rosenp@gmail.com>
References: <20260702000350.68331-1-rosenp@gmail.com>
 <20260702000350.68331-5-rosenp@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 00:13:41 +0000
Message-Id: <20260702001341.AD7041F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Returning success (0) on `ata_host_activate()` failure causes a ke=
rnel panic on device removal.
- [High] Missing cleanup of DMA resources on probe error paths leads to Use=
-After-Free.
--

commit 1231cd1ac0d6ac3ad6a4b61a9f9cf20df21198d9
Author: Rosen Penev <rosenp@gmail.com>
Subject: ata: sata_dwc_460ex: drop redundant struct copy of port_info

This patch optimizes sata_dwc_probe() by dropping an unnecessary local
copy of sata_dwc_port_info[0]. It directly points to the static data
instead, saving stack space and correcting the const qualification.

> diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.c
> index 4fc22ce4bd9aa..f262b00384ac4 100644
> --- a/drivers/ata/sata_dwc_460ex.c
> +++ b/drivers/ata/sata_dwc_460ex.c
> @@ -1134,8 +1134,8 @@ static int sata_dwc_probe(struct platform_device *o=
fdev)
>  	int err =3D 0;
>  	int irq;
>  	struct ata_host *host;
> -	struct ata_port_info pi =3D sata_dwc_port_info[0];
> -	const struct ata_port_info *ppi[] =3D { &pi, NULL };
> +	const struct ata_port_info *pi =3D &sata_dwc_port_info[0];
> +	const struct ata_port_info *ppi[] =3D { pi, NULL };
>  	struct resource *res;
> =20
>  	/* Allocate DWC SATA device */

[Severity: High]
This is a pre-existing issue, but does sata_dwc_probe() correctly handle
ata_host_activate() failures?

Looking further down in drivers/ata/sata_dwc_460ex.c:sata_dwc_probe(), the
driver logs an error but returns 0 if activation fails:

	err =3D ata_host_activate(host, irq, sata_dwc_isr, 0, &sata_dwc_sht);
	if (err)
		dev_err(dev, "failed to activate host");

	return 0;

If ata_host_activate() fails (for example, if devm_request_irq() or
scsi_host_alloc() fails), returning 0 falsely reports successful
initialization to the driver core.

When the device is later unbound or removed, sata_dwc_remove() is invoked
and calls ata_host_detach() which calls ata_port_detach(). Since the
scsi_host was never properly allocated or was freed, scsi_remove_host()
will dereference a null pointer and cause a kernel panic.

Could the return statement be updated to return the error code instead?


[Severity: High]
This is a pre-existing issue, but does sata_dwc_probe() leak dma resources
on error paths?

If CONFIG_SATA_DWC_OLD_DMA is enabled and no "dmas" property is present,
sata_dwc_dma_init_old() is called:

	err =3D sata_dwc_dma_init_old(ofdev, hsdev);
	if (err)
		return err;

This allocates a dma controller via devm_kzalloc, requests an interrupt, and
registers it with the dma engine subsystem.

If a subsequent probe step fails, such as the phy retrieval:

	if (IS_ERR(hsdev->phy))
		return PTR_ERR(hsdev->phy);

or later in the main error path:

error_out:
	phy_exit(hsdev->phy);
	return err;

The function returns without calling sata_dwc_dma_exit_old(). The driver co=
re
will free the devm-managed memory, including the dma controller structures.
However, because explicit teardown was bypassed, the dma engine subsystem a=
nd
the interrupt layer will retain pointers to this freed memory. This can lead
to a use-after-free if the shared interrupt fires or the dma subsystem
accesses the controller.

Should the error paths be updated to call sata_dwc_dma_exit_old() instead?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702000350.6833=
1-5-rosenp@gmail.com?part=3D1
