Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487733E6DEC
	for <linux-ide@vger.kernel.org>; Fri, 26 Jun 2026 09:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782465009; cv=none; b=i51AWmcYRTHIZJnyfRElKGO3k2kvjMna5ZBKf5kxDfCUQ5wRXnbXzPLZJsYjW3IE8S9Z0OAnMWhbXtcezkJwO4iM2foQymSM+J8qgkPhGZoQXQwqD1dU2+ArluGLduJGn4F3Nshw+zOQcyAzrT53p65swEdD4Wegjj+XEOVu8xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782465009; c=relaxed/simple;
	bh=6pf/J4I2Cbz2dDQb1E5c7UDVq0A/jETXS/65q7gqNsI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SKIe++AjGDKEup0jfF07djkLeb62vbkf2ioyVSTLxokBBob3ZQciqCz7zpt1rl0iJoZs7ZhybtXcXf6xEBsyjE3qeqeKPkeU8ScpGLt7BiLJSt1rXgWMx0sWAtJUTnDeJpfpPg2uEfoBduERdJvshzxlN9fXO2upda/4u1Vydyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JhyvZ8Pb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JhyvZ8Pb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A2C11F00A3A;
	Fri, 26 Jun 2026 09:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782465006;
	bh=CCRSQzI543bBI2uf3AHR2V/tdygfYZcZdWRb5grDhak=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JhyvZ8PbqfTuIiV5Z7O1L+3lCPzLqhiD30k570ufRfGAFiQ/I0bdTli3LgLgtlS8K
	 KjoM36cvwkBsoCMJJ06AXxyf5+kNlHrATxNDPRwknrzrmwVaS9VDnoCw+l7z62PAJ8
	 ttBoVziwmiovsOOXX8VVE1cEW46D6pEzvvVKUbqXfAXF5M3mOVm+EdD4xo6faxc0pJ
	 pG/XZTMfwLsXwLDopkdNO7G0wl0E5mBBSS+8QJ/lc3FkUY7nONIjVL5CESoplGa8nZ
	 FxZrIoKdfGfxTEN6yAOhfksdYOZH9ll56kk4Cva/7DZ2EaPgWBDi0nO1SrKuIMQ9Lw
	 zCBL79Ka98jUA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] ata: sata_gemini: unwind clocks on IDE pinctrl errors
Reply-To: sashiko-reviews@lists.linux.dev
To: "Myeonghun Pak" <mhun512@gmail.com>
Cc: dlemoal@kernel.org, cassel@kernel.org, linux-ide@vger.kernel.org
In-Reply-To: <20260626085848.40199-1-mhun512@gmail.com>
References: <20260626085848.40199-1-mhun512@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Jun 2026 09:10:05 +0000
Message-Id: <20260626091006.5A2C11F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Probe deferral is permanently masked because devm_clk_get errors a=
re converted to -ENODEV.
- [High] The sata_gemini bridge state (sg) can be freed while still in use =
by consumers like pata_ftide010, leading to a Use-After-Free on driver unbi=
nd.
- [High] Unconditional clock disable during port stop can lead to negative =
enable counts if port start partially fails.
--

commit 41dfc4226f4d13085ec0bbac5ed9062fd893a436
Author: Myeonghun Pak <mhun512@gmail.com>

ata: sata_gemini: unwind clocks on IDE pinctrl errors

gemini_sata_bridge_init() prepares and enables both SATA PCLKs, then
disables them again while keeping the clocks prepared for later bridge
start and stop operations. This patch routes the IDE pinctrl failure
through out_unprep_clk so the clocks prepared by gemini_sata_bridge_init()
are correctly unprepared before probe fails.

> diff --git a/drivers/ata/sata_gemini.c b/drivers/ata/sata_gemini.c
> --- a/drivers/ata/sata_gemini.c
> +++ b/drivers/ata/sata_gemini.c
> @@ -353,7 +353,7 @@ static int gemini_sata_probe(struct platform_device *=
pdev)
>  	if (sg->ide_pins) {
>  		ret =3D gemini_setup_ide_pins(dev);
>  		if (ret)
> -			return ret;
> +			goto out_unprep_clk;

[Severity: High]
This is a pre-existing issue, but I noticed that probe deferral is
permanently masked when getting the clocks.

In gemini_sata_bridge_init(), which is called earlier in probe, errors
from devm_clk_get() are overwritten:

drivers/ata/sata_gemini.c:gemini_sata_bridge_init() {
    sg->sata0_pclk =3D devm_clk_get(dev, "SATA0_PCLK");
    if (IS_ERR(sg->sata0_pclk)) {
        dev_err(dev, "no SATA0 PCLK");
        return -ENODEV;
    }
    ...
}

If devm_clk_get() returns -EPROBE_DEFER because the clock provider isn't
ready, does returning -ENODEV cause the SATA controller to permanently
fail to probe?

[Severity: High]
This isn't a bug introduced by this patch, but there appears to be a
lifetime issue between sata_gemini and pata_ftide010.

When pata_ftide010 retrieves the bridge state:

drivers/ata/pata_ftide010.c:pata_ftide010_gemini_init() {
    ...
    sg =3D gemini_sata_bridge_get();
    if (IS_ERR(sg))
        return PTR_ERR(sg);
    ftide->sg =3D sg;
    ...
}

The bridge is returned from a singleton:

drivers/ata/sata_gemini.c:gemini_sata_bridge_get() {
    if (sg_singleton)
        return sg_singleton;
    ...
}

Since the memory is allocated with devm_kzalloc() in gemini_sata_probe()
and no device link or reference count is taken, can this lead to a
use-after-free if sata_gemini is unbound via sysfs while pata_ftide010
is still active?

[Severity: High]
This is also a pre-existing issue, but the clock disable logic might become
unbalanced during port stop.

In pata_ftide010_gemini_port_stop(), the bridge is unconditionally
stopped:

drivers/ata/pata_ftide010.c:pata_ftide010_gemini_port_stop() {
    ...
    if (ftide->master_to_sata1) {
        dev_info(dev, "SATA1 (master) stop\n");
        gemini_sata_stop_bridge(sg, 1);
    }
    ...
}

Which disables the clock:

drivers/ata/sata_gemini.c:gemini_sata_stop_bridge() {
    ...
    else if (bridge =3D=3D 1)
        clk_disable(sg->sata1_pclk);
    ...
}

If port start partially fails (e.g., due to a PHY timeout in
gemini_sata_setup_bridge()) and the clock was already disabled in the
error path of gemini_sata_start_bridge(), does this unconditional stop
cause a kernel warning or panic due to negative enable counts?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260626085848.4019=
9-1-mhun512@gmail.com?part=3D1
