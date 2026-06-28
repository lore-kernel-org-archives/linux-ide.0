Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B885D372EF1
	for <linux-ide@vger.kernel.org>; Sun, 28 Jun 2026 23:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782688333; cv=none; b=UQaJLiWZSVVTccyUJNGAnGHRAAhkKr6jpGp4bXZHnftzum3cG3iNzEOHF0XZjY0D3SoYe05XHecYwvmNsp5gHqDmVlZgz+/QUOFLC6LuiR/5+Uq/oVFq90jfwbewLeRblqEh/PV0IPvgMmwwAPmurioCfa5mAFhKUVfwmqtE6iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782688333; c=relaxed/simple;
	bh=gJzNbX4hp092pOcvFRCge00A3J42K6/L3QVlCUTIp2U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZJB+b+RdiNTIa0f1TAdxNJlviRlvGVgunKjeRNaCT9PUmKxju5FZK4b86qpmTBn9igI+YjWHcdwynFveEXzagSECD9iKS2nO4zmdepn+g57Z+++IH/agMKmk/PnImgcbdOorE0M41tKF5b4129weNdgMlnkOfQSeVWeDnrfRi1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FDD51F00A3A;
	Sun, 28 Jun 2026 23:12:12 +0000 (UTC)
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] ata: sata_dwc_460ex: use platform_get_irq()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rosen Penev" <rosenp@gmail.com>
Cc: cassel@kernel.org, linux-ide@vger.kernel.org, dlemoal@kernel.org
In-Reply-To: <20260628230310.1214770-1-rosenp@gmail.com>
References: <20260628230310.1214770-1-rosenp@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 28 Jun 2026 23:12:11 +0000
Message-Id: <20260628231212.2FDD51F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Probe error paths leave hardware interrupts unmasked, potentially =
causing an interrupt storm if a subsequent step fails or defers probe.
- [High] `sata_dwc_probe()` silently ignores `ata_host_activate()` failures=
, falsely reporting success and skipping cleanup.
- [High] Probe error path calls `phy_exit()` when `phy_init()` fails, corru=
pting the PHY's internal state.
- [High] Missing cleanup of old DMA resources on probe error paths.
--

commit 38e92fff8b9d315da09f885e72d12d704d5b7b50
Author: Rosen Penev <rosenp@gmail.com>

ata: sata_dwc_460ex: use platform_get_irq()

Replace irq_of_parse_and_map() with platform_get_irq() in both
sata_dwc_dma_init_old() and sata_dwc_probe(). This is the preferred
way to obtain IRQs for platform devices and provides better error
reporting.

> diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.c
> index 4fc22ce4bd9aa..35aa7f9acdf75 100644
> --- a/drivers/ata/sata_dwc_460ex.c
> +++ b/drivers/ata/sata_dwc_460ex.c
[ ... ]
> @@ -1173,11 +1169,9 @@ static int sata_dwc_probe(struct platform_device *=
ofdev)
>  	sata_dwc_enable_interrupts(hsdev);
> =20
>  	/* Get SATA interrupt number */
> -	irq =3D irq_of_parse_and_map(np, 0);
> -	if (!irq) {
> -		dev_err(dev, "no SATA DMA irq\n");
> -		return -ENODEV;
> -	}
> +	irq =3D platform_get_irq(ofdev, 0);
> +	if (irq < 0)
> +		return irq;

[Severity: High]
This is a pre-existing issue, but does returning directly here leave hardwa=
re
interrupts unmasked?

Because sata_dwc_enable_interrupts() is called right before obtaining the
IRQ, if platform_get_irq() returns -EPROBE_DEFER, probe will fail while
interrupts remain enabled on the hardware. Could this lead to an unhandled
interrupt storm?

> =20
>  #ifdef CONFIG_SATA_DWC_OLD_DMA
>  	if (!of_property_present(np, "dmas")) {

[Severity: High]
This isn't a bug introduced by this patch, but is there a missing cleanup
for the old DMA resources on the error paths that follow this block?

If sata_dwc_dma_init_old() succeeds, but a subsequent operation like
phy_init() fails later in sata_dwc_probe(), does the driver leave the DMA
controller active and registered without calling a corresponding cleanup
function?

[Severity: High]
This is a pre-existing issue, but does jumping to the error_out label when
phy_init() fails corrupt the PHY's internal state?

Later in sata_dwc_probe(), when phy_init() fails, it jumps to error_out
which unconditionally calls phy_exit(). Calling phy_exit() will decrement
the internal init_count to -1, which can cause subsequent probe retries to
falsely assume the PHY is already initialized.

[Severity: High]
This isn't a bug introduced by this patch, but does the driver silently
ignore failures from ata_host_activate() at the end of sata_dwc_probe()?

If ata_host_activate() fails, it logs an error but still executes return 0;
instead of jumping to error_out. Does this falsely signal success to the
driver core and skip necessary cleanup, potentially leading to a crash on
unbind?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260628230310.1214=
770-1-rosenp@gmail.com?part=3D1
