Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472085476D1
	for <linux-ide@vger.kernel.org>; Tue,  8 Sep 2026 14:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788877854; cv=none; b=m3C1PPydzR4mTmXTanQJSMYA2EPrErMwCGpld7NnNDkcPTgCY84i2MlQNo5BISVoqCEGeERomiFNf4bhJDginjQPvfwk2H0O+CsjU2AKy6h71eCyH2d7ZztdldVtYMUjef7Ssj8VhvpsW4V0ACx8FZD5WiIIS2MN/Bt6CPoforM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788877854; c=relaxed/simple;
	bh=83bCcCYzU+tCGGiq6j1/NGbit4da5Dx1tWQ7RFR+mAk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aN/gIgV5GHIIm7fYflKa2bSTuBuExR7wksMhdHhSjaOQZ7izz5jo818wEJT2Jopq0OSQHlgk4anfAMMc3Joy/f62tXEjYimMd2ZacfDQgVMls4MwDdW9lZcsYeNs/oxTUA/Ua4IitpOru/pFlZCuw6B/RckduCoN+mQG2OCn/Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 964151F00A3D;
	Tue,  8 Sep 2026 14:30:42 +0000 (UTC)
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] ata: sata_dwc_460ex: Don't enable interrupt if libATA
 core registration fails
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nikolay Borisov" <nik.borisov@suse.com>
Cc: dlemoal@kernel.org, linux-ide@vger.kernel.org, cassel@kernel.org
In-Reply-To: <20260908141538.731237-1-nik.borisov@suse.com>
References: <20260908141538.731237-1-nik.borisov@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 14:30:39 +0000
Message-Id: <20260908143042.964151F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

New issues:
- [Low] The patch introduces a `goto err;` statement in `sata_dwc_probe()`,=
 but there is no label named `err:` defined in the function, resulting in a=
 compilation error.

Pre-existing issues:
- [High] Missing cleanup of legacy DMA controller registration on error pat=
hs in `sata_dwc_probe()` leads to leaked DMA resources and a Use-After-Free=
 in the dmaengine subsystem.
- [High] The error path unconditionally calls `phy_exit()` even if `phy_ini=
t()` fails, corrupting the PHY initialization reference count.
- [High] The allocated DMA channel is not released if `phy_power_on()` fail=
s in `sata_dwc_port_start()`.
- [Medium] The host is registered and exposed to libata before hardware int=
errupts are enabled, causing a potential race condition with the asynchrono=
us probe thread.
--

commit 3b0d1baec2d2645cdd4b2283d5c10d4927e37dd2
Author: Nikolay Borisov <nik.borisov@suse.com>
Subject: ata: sata_dwc_460ex: Don't enable interrupt if libATA core registr=
ation fails

This commit updates the probe function to fail the registration process if
ata_host_activate() fails. It aims to prevent interrupts from being enabled
when the device is not registered with the libATA core.

> diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.c
> index 8e3fc713891af..c3df2fce4af73 100644
> --- a/drivers/ata/sata_dwc_460ex.c
> +++ b/drivers/ata/sata_dwc_460ex.c
> @@ -1185,8 +1185,10 @@ static int sata_dwc_probe(struct platform_device *=
ofdev)
>  	 * error_handler() to execute a dummy Softreset EH session
>  	 */
>  	err =3D ata_host_activate(host, irq, sata_dwc_isr, 0, &sata_dwc_sht);
> -	if (err)
> +	if (err) {
>  		dev_err(dev, "failed to activate host");
> +		goto err;

[Severity: Low]
Does this code attempt to jump to an undefined label? There is no label
named "err" in this function, which will cause a compilation failure.
Should this jump to "error_out" instead?

> +	}
> =20
>  	/* Enable SATA Interrupts */
>  	sata_dwc_enable_interrupts(hsdev);

[Severity: Medium]
This is a pre-existing issue, but does this order of operations expose the
port to the asynchronous EH worker before the hardware interrupt mask is
configured?

ata_host_activate() registers the host with libata and schedules the
async_port_probe thread, which issues a softreset. If the async thread
issues a command relying on hardware interrupts before
sata_dwc_enable_interrupts() is called, could this result in a command
timeout during device detection?

[Severity: High]
This is a pre-existing issue, but does the error exit path in
sata_dwc_probe() miss cleaning up the legacy DMA controller?

If sata_dwc_dma_init_old() succeeds, the controller is registered via
dw_dma_probe(). If a subsequent initialization step fails and the code
jumps to the error path:

drivers/ata/sata_dwc_460ex.c:sata_dwc_probe()
    ...
error_out:
	phy_exit(hsdev->phy);
	return err;

Can bypassing sata_dwc_dma_exit_old() cause a use-after-free when devres
frees the memory but the dmaengine device remains registered?

[Severity: High]
This is a pre-existing issue, but does the error path unconditionally exit
the PHY even if phy_init() fails?

drivers/ata/sata_dwc_460ex.c:sata_dwc_probe()
	err =3D phy_init(hsdev->phy);
	if (err)
		goto error_out;
    ...
error_out:
	phy_exit(hsdev->phy);
	return err;

If phy_init() fails, it leaves phy->init_count at 0. Calling phy_exit() will
decrement the count to -1, which could lead to a permanent initialization
failure on subsequent probe attempts since phy_init() will see a non-zero
count and skip initialization.

[Severity: High]
This is a pre-existing issue, but is there a potential resource leak in
sata_dwc_port_start() if phy_power_on() fails?

drivers/ata/sata_dwc_460ex.c:sata_dwc_port_start()
	err =3D sata_dwc_dma_get_channel(hsdevp);
	if (err)
		goto CLEANUP_ALLOC;
    ...
	err =3D phy_power_on(hsdev->phy);
	if (err)
		goto CLEANUP_ALLOC;
    ...
CLEANUP_ALLOC:
	kfree(hsdevp);

If phy_power_on() fails, the code jumps to CLEANUP_ALLOC but misses a call
to dma_release_channel(), which could eventually exhaust all available DMA
channels.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908141538.7312=
37-1-nik.borisov@suse.com?part=3D1
