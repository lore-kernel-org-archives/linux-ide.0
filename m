Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2461E47AF60
	for <linux-ide@vger.kernel.org>; Tue, 30 Jun 2026 20:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782851802; cv=none; b=ZQMFuQ26ZOtPZvQBDgkS1x32RT0huE96ZlWFbPJwMPqCo7tCvaO3TYPac4LRcpNg3GchSjlRdu2nt6IGQMozE3frljAbqSm2x8qZQiTUE530Qv8Ri3uXbY3dxM0OwkABM2ewUpw5Kr36vVrA3yLkSESGMikhBm7vY46v3erAXbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782851802; c=relaxed/simple;
	bh=08UmJiQOITBovqVcTu1+eA/R4y5HI4BNBCKf5mZ8xAQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QUd5uA+U/tKPvs5nRXXH26+ibZ3f/dkRXRwLZ1Ywhg03n/PhZqkCYrNn5HzeRwFpmtrZNelry5Ix0o3IYu87mfbdo6sHUlHH82+ZfWP8zSXKOdIwSo6ERneykWhIPlZCE6vWDWfAfT1FwwqDEugqj6k0b6bNQ6gNjL+ASOWoq5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WN8j2z9A; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WN8j2z9A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F1591F000E9;
	Tue, 30 Jun 2026 20:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782851800;
	bh=rMmPfdNWJjFHWAXyigWfWZkrGVLL8084LQL4lzLPyTE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WN8j2z9AmJeIJY8X5ZS56/YrUZFvth9c95FTNrlzz/B0YgXpcMFstujTEBM8paJ9F
	 mzEzZHXFS0yKMBdrMpGm9Z20LoEMdyCaE/4XsGyNDI3zzfwBjrFVIow46nRh07fej1
	 OwqlkDtUKFg5NoLfCKsn6DeYn0vE0E7I9mdXG3D9W1V3yPlGshJ+Xq9FRAPpwOY3MM
	 Vkq3Uux0dFTqzsRuMuZ0xt3motZAdKzYWH59bzwDboBii8VmCmvHQwIl+IS+aAjAnX
	 WxblVFLyAjQ+VgXg/nT9Gsdb/pXmqEPBdmkW0lYZt8uy861xp2wU1pGBgtb5fWsrs0
	 rPKI7x7bWK+YA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/5] ata: sata_dwc_460ex: enable SATA interrupts only
 after IRQ handler is registered
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rosen Penev" <rosenp@gmail.com>
Cc: linux-ide@vger.kernel.org, dlemoal@kernel.org, cassel@kernel.org
In-Reply-To: <20260630202415.234463-5-rosenp@gmail.com>
References: <20260630202415.234463-1-rosenp@gmail.com>
 <20260630202415.234463-5-rosenp@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 20:36:39 +0000
Message-Id: <20260630203640.8F1591F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing SATA interrupt disable in remove path leads to potential i=
nterrupt storm.
- [High] Lifecycle inversion: `phy_power_off()` is executed on an already e=
xited PHY during teardown.
- [High] Data race on `hsdev->sactive_issued` causing state corruption.
--

commit 6c390f90accf9771f2e071160279ee0671a1ecfe
Author: Rosen Penev <rosenp@gmail.com>

ata: sata_dwc_460ex: enable SATA interrupts only after IRQ handler is regis=
tered

This patch moves sata_dwc_enable_interrupts() after ata_host_activate()
in sata_dwc_probe(). This ensures that the controller's interrupt mask is
only enabled once the interrupt handler is successfully registered and the
core is fully initialized.

> diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.c
> index 34d6d0534e308..fb6042b9ac273 100644
> --- a/drivers/ata/sata_dwc_460ex.c
> +++ b/drivers/ata/sata_dwc_460ex.c
> @@ -1168,9 +1168,6 @@ static int sata_dwc_probe(struct platform_device *o=
fdev)
>  	/* Save dev for later use in dev_xxx() routines */
>  	hsdev->dev =3D dev;
> =20
> -	/* Enable SATA Interrupts */
> -	sata_dwc_enable_interrupts(hsdev);
> -
>  	/* Get SATA interrupt number */
>  	irq =3D platform_get_irq(ofdev, 0);
>  	if (irq < 0)
> @@ -1204,6 +1201,8 @@ static int sata_dwc_probe(struct platform_device *o=
fdev)
>  		return err;
>  	}
> =20
> +	/* Enable SATA Interrupts */
> +	sata_dwc_enable_interrupts(hsdev);
>  	return 0;
>  }

While reviewing the interrupt handling changes in sata_dwc_probe(), I
noticed a few other pre-existing issues in the driver that might be worth
addressing.

[Severity: High]
This isn't a bug introduced by this patch, but looking at sata_dwc_remove(),
is there a missing SATA interrupt disable call?

drivers/ata/sata_dwc_460ex.c:sata_dwc_remove() {
        ...
        ata_host_detach(host);
       =20
        phy_exit(hsdev->phy);
        ...
}

The driver detaches the host and exits the PHY, but fails to mask the
controller's interrupts (intmr and errmr registers). When remove() returns,
the driver core cleans up devres allocations, which unregisters the IRQ
handler.

If the hardware asserts an interrupt during teardown, can this lead to an
unhandled interrupt storm and potentially lock up the system or disable a
shared IRQ line?

[Severity: High]
This is a pre-existing issue, but does sata_dwc_remove() have a PHY lifecyc=
le
inversion?

drivers/ata/sata_dwc_460ex.c:sata_dwc_remove() {
        ...
        phy_exit(hsdev->phy);
        ...
}

The driver explicitly calls phy_exit() here. However, phy_power_off() is
handled inside sata_dwc_port_stop(), which is executed later by devres
cleanup:

drivers/ata/sata_dwc_460ex.c:sata_dwc_port_stop() {
        ...
        phy_power_off(hsdev->phy);
        ...
}

Because ata_host_stop() is registered as a devres callback (via
ata_host_start()), it runs after sata_dwc_remove() returns. Does this result
in phy_power_off() operating on a PHY that has already been exited?

[Severity: High]
This isn't a bug introduced by this patch, but is there a data race on
hsdev->sactive_issued in sata_dwc_isr()?

drivers/ata/sata_dwc_460ex.c:sata_dwc_isr() {
        ...
        hsdev->sactive_issued =3D 0;
       =20
        spin_lock_irqsave(&host->lock, flags);
        ...
}

The assignment to hsdev->sactive_issued is executed locklessly before
acquiring host->lock. If a DMA completion interrupt fires concurrently on
another CPU, dma_dwc_xfer_done() acquires host->lock and calls
sata_dwc_qc_complete().

Since sata_dwc_qc_complete() performs a read-modify-write on this same
state under the lock, can this race corrupt the NCQ tag tracking state
and desynchronize the state machine?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260630202415.2344=
63-1-rosenp@gmail.com?part=3D4
