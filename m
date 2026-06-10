Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5523A375F9C
	for <linux-ide@vger.kernel.org>; Wed, 10 Jun 2026 06:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781073677; cv=none; b=QKecmJNDV7otBBlumaeXZeFWahyin3yfVm8juqtvDaUUZcDKyRUbu6qe7QGTRrQ/r7fT48Ev6XApyR0FKzry4iogDTeMHU0S+94scIM3tqrWfbPiMtcZpKQ2A/UfSGIRMmFkGnxQIYV0T8t3My6LN910wvIuTzr59oWk2rGKzIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781073677; c=relaxed/simple;
	bh=ezRbEGew/ysTD+fnZ7Jg8WFmqaqGza2ZL5/MAhsEjeg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FC4jjLbDbLAiZ1izQzrNfApqA7wAi0Eb4AXq9OLIPp1t1ac25usapE+WITBuU2UWY8AYo1NrB1fmrwmiaRUjrgJYmw1/qDKGZex6OOatr+f1Sv7xn6a3Eu38ypnhWnXsd1z5moyLq+SQRM01aPVVRpAMaA3GZXjAeGFq0GvsRP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nWau9JDJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nWau9JDJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5B011F00893;
	Wed, 10 Jun 2026 06:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781073676;
	bh=IoAwsgVsCF2noM5nMct+GXNJoTqFdZuHWRA2daDcCIg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nWau9JDJLIxYakjz9bI9n9bEyU0G8pS3Se9nT1Fc8WQ+/PCuk2fMYE7JfS0xolFtM
	 5aRIA/k/KB7euwfeOk5aJq02myuZlNjoY04WRvm/A/nBBMMSmOuf7wCYkhKOUJYYYY
	 LsAeRd8/CNdLMPpHK2+MU526ilvlOshVyxsqdbLONlGMoMrQXCw5iaDbo9EzS4gfdB
	 cPhKHtbihZTunns93RXCehdw3VsDSwv0/77rfiLkBnzJzLnrirIAYJnQu1fAHAlR2E
	 Qnxnw2gos6gm6+PcknbcQ2HpyywqCCWhSvDZyXPgNh8r8E+BwCmX/+tB1v9R/i+X4w
	 pJSljOOwXB5yQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] ata: sata_mv: use devm clock helpers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rosen Penev" <rosenp@gmail.com>
Cc: cassel@kernel.org, linux-ide@vger.kernel.org, dlemoal@kernel.org
In-Reply-To: <20260610063512.109464-1-rosenp@gmail.com>
References: <20260610063512.109464-1-rosenp@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 10 Jun 2026 06:41:15 +0000
Message-Id: <20260610064115.B5B011F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Direct returns inside the per-port initialization loop bypass the =
`err` cleanup block, leaking the power state of previously initialized PHYs.
--

commit 6348b987b12e84df8076e5646462dde25b2d8234
Author: Rosen Penev <rosenp@gmail.com>

ata: sata_mv: use devm clock helpers

This commit replaces manual clock management with devm_clk_get_optional_ena=
bled
for the main and per-port clocks. The commit message states the err label is
retained for phy_power_off cleanup.

> diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
> --- a/drivers/ata/sata_mv.c
> +++ b/drivers/ata/sata_mv.c

[ ... ]

> @@ -4091,21 +4091,16 @@ static int mv_platform_probe(struct platform_devi=
ce *pdev)

[ ... ]

>  	for (port =3D 0; port < n_ports; port++) {
>  		char port_number[16];
>  		sprintf(port_number, "%d", port);
> -		hpriv->port_clks[port] =3D clk_get(&pdev->dev, port_number);
> -		if (!IS_ERR(hpriv->port_clks[port]))
> -			clk_prepare_enable(hpriv->port_clks[port]);
> +		hpriv->port_clks[port] =3D devm_clk_get_optional_enabled(&pdev->dev, p=
ort_number);
> +		if (IS_ERR(hpriv->port_clks[port]))
> +			return PTR_ERR(hpriv->port_clks[port]);

[Severity: High]
Does this direct return skip the cleanup for PHYs powered on during previous
loop iterations?

If mv_platform_probe() fails to get the port clock on a subsequent port
(port > 0), returning directly bypasses the err label where phy_power_off()
is called. This could leave the earlier PHYs powered on.

>  		sprintf(port_number, "port%d", port);
>  		hpriv->port_phys[port] =3D devm_phy_optional_get(&pdev->dev,
> @@ -4118,9 +4113,9 @@ static int mv_platform_probe(struct platform_device=
 *pdev)
> =20
>  			/* Cleanup only the initialized ports */
>  			hpriv->n_ports =3D port;
> -			goto err;
> -		} else
> -			phy_power_on(hpriv->port_phys[port]);
> +			return rc;
> +		}

[Severity: High]
Is it intentional to replace the goto err with a direct return here?

The original code used goto err to ensure phy_power_off() would be called f=
or
previously initialized ports when devm_phy_optional_get() failed. By
returning directly, could this leak the power state if probe is deferred
or fails for a later port?

> +		phy_power_on(hpriv->port_phys[port]);
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260610063512.1094=
64-1-rosenp@gmail.com?part=3D1
