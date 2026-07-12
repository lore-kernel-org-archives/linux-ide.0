Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112B13845D5
	for <linux-ide@vger.kernel.org>; Sun, 12 Jul 2026 22:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783895933; cv=none; b=n+dA6aUXDoGvzqY9HkMFxkE7ZFBBz9ucBp9lDuZaMdzjO8M/vI1ZB78z/0od4GrjxueMVxrifXgOLY0G3ra16j44oYBx9B91QARCQvyO1BFkSei0CdOqsu0Tw2fBXX4qgjAdMgvCOzQpAcse+KnOONTznbWvkLlwJcTFPvlZ+lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783895933; c=relaxed/simple;
	bh=e5dkpmfBBEziDn/sF/IEki4XDypPQ5eNQyUF4pVB8Yo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Cqzeu1DnVOeRUdAYyt7sMKC6RQ61Xa0cM8Ftc1m71RukIkTxUK0rs8DuGgA5a9I8TYKqCRFxgcLzxSZLmq1ZHjVHz/5DD+L51nUwvmLITUjKIGb7TDS8C+q0TToh/D+tq4RUwHfbmpbZIQ4B1IPS+BgyUt7rorgBnkQ+sHz+nlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BF9L2IO2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BF9L2IO2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 689EF1F000E9;
	Sun, 12 Jul 2026 22:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783895931;
	bh=x5YHzybzNIbGesavAX4+ovvDs1z9rIHan4XpYFEfZaA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BF9L2IO2VTF2oH4e0sWi2TcVCdLHbrOpQ2QU4+Lqi7/IOo3Ts9ad9zLfFYksPzjCU
	 g3qxnDDRdxaG6VcWTBp1bybandn5G2iAFs+hSIUp76DmkA0NxoXlVm1PlyGYmyjIrf
	 Ho6xhg9gWylk5M34j9Y0/xLIEMIW0tGDqFvcsAI2vPkGxosKspnImQbaq+24ojEcgg
	 V7QNAJ1iDxX0km+xHsHUI2iMJ55ZfT1XHsh2EQAEjMaSc0OfWJTy5phkGwH/qud65Z
	 XgDj6anBm9nWwwLFe0mCAObWKN7IGjO/0X/NWS/iX7z4j2FeOyXYUfuvMsu1HrKjMc
	 x78TDHCw/02MA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] ata: sata_mv: accept 1 or 2 resources in platform probe
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rosen Penev" <rosenp@gmail.com>
Cc: linux-ide@vger.kernel.org, cassel@kernel.org, dlemoal@kernel.org
In-Reply-To: <20260712223137.1058531-1-rosenp@gmail.com>
References: <20260712223137.1058531-1-rosenp@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 12 Jul 2026 22:38:50 +0000
Message-Id: <20260712223851.689EF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing error check for port clock clk_prepare_enable() leads to u=
nbalanced disable and potential hardware faults.
--

--- Patch [1]: [PATCH] ata: sata_mv: accept 1 or 2 resources in platform pr=
obe ---
commit 079963d555bbd8a5581f9c80568deb335571afa8
Author: Rosen Penev <rosenp@gmail.com>

ata: sata_mv: accept 1 or 2 resources in platform probe

This commit modifies mv_platform_probe() to accept either 1 or 2 resources,
allowing the SATA driver to probe successfully on legacy Marvell
Orion/Kirkwood-style boards.

> diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
> index 41647a56a9f4e..365454390d7e0 100644
> --- a/drivers/ata/sata_mv.c
> +++ b/drivers/ata/sata_mv.c
> @@ -4027,7 +4027,7 @@ static int mv_platform_probe(struct platform_device=
 *pdev)
>  	/*
>  	 * Simple resource validation ..
>  	 */
> -	if (unlikely(pdev->num_resources !=3D 1)) {
> +	if (unlikely(pdev->num_resources !=3D 1 && pdev->num_resources !=3D 2))=
 {
>  		dev_err(&pdev->dev, "invalid number of resources\n");
>  		return -EINVAL;
>  	}

[Severity: High]
This is a pre-existing issue, but while reviewing this function I noticed
the return value of clk_prepare_enable() for port clocks is ignored further
down in mv_platform_probe():

drivers/ata/sata_mv.c:mv_platform_probe() {
...
        hpriv->port_clks[port] =3D clk_get(&pdev->dev, port_number);
        if (!IS_ERR(hpriv->port_clks[port]))
            clk_prepare_enable(hpriv->port_clks[port]);
...
}

Does this code risk causing a synchronous external abort on ARM systems if
the port clock fails to enable? If the driver proceeds with hardware
initialization while the IP block is unclocked, it could lead to a kernel
panic upon register access.

Additionally, if clk_prepare_enable() fails or another error occurs during
probe, the cleanup loop unconditionally attempts to disable and unprepare
the clock:

drivers/ata/sata_mv.c:mv_platform_probe() {
...
err:
...
    for (port =3D 0; port < hpriv->n_ports; port++) {
        if (!IS_ERR(hpriv->port_clks[port])) {
            clk_disable_unprepare(hpriv->port_clks[port]);
            clk_put(hpriv->port_clks[port]);
        }
...
}

Could this unbalanced disable cause a WARN_ON during the error path since
the clock was never successfully enabled?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260712223137.1058=
531-1-rosenp@gmail.com?part=3D1
