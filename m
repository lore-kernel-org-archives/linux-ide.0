Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44342386441
	for <linux-ide@vger.kernel.org>; Sun, 12 Jul 2026 22:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783896341; cv=none; b=HE67omkYWZT0XyYoxnghEt4V6Fuh+8Mp3KKGuoxP2dY7FWXXexvfkEthUG4j0O+zMfhgUEy0XinmUN0yfM5dmz5QxRucYyphIPzAL6aXx1VP/6SyXy7IL0pydku/Kp1yy/Bfwd1yyHilYrSzz+2Xf/VCq0qC1KfncisZv6RS7xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783896341; c=relaxed/simple;
	bh=x0GqrxTlbxq6Gc8RxVGFKjtNAHptmIUoDvcYp4b3IPE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pqk0c/OGZ6rdPu+wJVlaZB9dd7No8zGyCeR/P/Dx49U7HuoOLhB1wz4dpG4VC7kZjCwWfQLoWIPKlKS8hGwT4QOJG0JxnfKJ4HLZO/ya/xkeSvshWHdDlIto/MT5eeDcsz8xjwhbO9GXdtxd4im+R562tiBAj7dutUsfyB3gm6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=avkLtDI6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="avkLtDI6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECFDC1F000E9;
	Sun, 12 Jul 2026 22:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783896339;
	bh=C1mqbWi2c1U5UnIGTi06hSfNfg39iL/g0vDJWUPOz4w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=avkLtDI6UK2dbEj/W1zt425k8ksGL0qX0ArvM+LBXUnO+GJ4+AkNT63SPhBPBbfHf
	 a/RCQoiQeaNIum8xz9re+xaFSzOrowpW3AeCj9k+Ad/AOdzjoxMFrxtq/n5fPWhQpu
	 jSqiNfS8+gl9t/XNVDY9K3ehS9VYJ4G3N6sw8U96Fqu9JnO3S70aewwDGK9iD5XF1d
	 oYaHpbXy3lauG03jO62uJpVf18ABGcgrxeefUfNUVYDam4rldNL98KCtRrMpmTjF3g
	 VVYDcG/79ua2+0+KaIUcMAROWqNW0D2Yvra+TXAXwwpz9dolcrRsIWCsCv5F7fKcm9
	 fGL7IbLom/bmg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCHv2] ata: sata_mv: use devm clock helpers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rosen Penev" <rosenp@gmail.com>
Cc: dlemoal@kernel.org, cassel@kernel.org, linux-ide@vger.kernel.org
In-Reply-To: <20260712223733.1084077-1-rosenp@gmail.com>
References: <20260712223733.1084077-1-rosenp@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 12 Jul 2026 22:45:38 +0000
Message-Id: <20260712224538.ECFDC1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The return value of `phy_power_on()` is ignored, which can lead to=
 hardware faults and unbalanced `phy_power_off()` execution during teardown.
--

--- Patch [1]: [PATCHv2] ata: sata_mv: use devm clock helpers ---
commit 4da9c2641dc6134cc0fc1f75c23bcc95ae5882fd
Author: Rosen Penev <rosenp@gmail.com>

ata: sata_mv: use devm clock helpers

This commit replaces manual clock acquisition and enablement with
devm_clk_get_optional_enabled() for the main and per-port clocks. It
simplifies the error handling and remove paths by removing the manual clock
cleanup.

> diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
> index 41647a56a9f4e..eafd1e6b827dd 100644
> --- a/drivers/ata/sata_mv.c
> +++ b/drivers/ata/sata_mv.c

[ ... ]

> @@ -4120,8 +4118,8 @@ static int mv_platform_probe(struct platform_device=
 *pdev)
>  			/* Cleanup only the initialized ports */
>  			hpriv->n_ports =3D port;
>  			goto err;
> -		} else
> -			phy_power_on(hpriv->port_phys[port]);
> +		}
> +		phy_power_on(hpriv->port_phys[port]);

[Severity: High]
This is a pre-existing issue, but is it safe to ignore the return value of
phy_power_on() here?

If powering on the PHY fails, the SATA controller might still attempt to
initialize and use the unpowered port. Could this result in hardware
lockups or register access faults?

[ ... ]

> @@ -4190,17 +4179,8 @@ static void mv_platform_remove(struct platform_dev=
ice *pdev)
>  	int port;
>  	ata_host_detach(host);
> =20
> -	if (!IS_ERR(hpriv->clk)) {
> -		clk_disable_unprepare(hpriv->clk);
> -		clk_put(hpriv->clk);
> -	}
> -	for (port =3D 0; port < host->n_ports; port++) {
> -		if (!IS_ERR(hpriv->port_clks[port])) {
> -			clk_disable_unprepare(hpriv->port_clks[port]);
> -			clk_put(hpriv->port_clks[port]);
> -		}
> +	for (port =3D 0; port < host->n_ports; port++)
>  		phy_power_off(hpriv->port_phys[port]);

[Severity: High]
This is a pre-existing issue, but does this code unconditionally power off
ports even if phy_power_on() failed during mv_platform_probe()?

If the earlier power on operation failed and was ignored, calling
phy_power_off() here could decrement the PHY's power count and runtime PM
usage count below zero, potentially causing unbalanced lifecycle operations
in the PM framework.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260712223733.1084=
077-1-rosenp@gmail.com?part=3D1
