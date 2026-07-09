Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B32991B4224
	for <linux-ide@vger.kernel.org>; Thu,  9 Jul 2026 02:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783563919; cv=none; b=G/MLVZ0Iiv96mouzZZy/+6D3vz+yC5hmrRw3vjAYVZlHGzGv7zgWtFWoGd8yZOmJ6+lctGkCp+WFWy0oOv149cRJPScwJYVRpzBy/gDGJ0xm5nkTBVYrpfIhZ1LzSsvrNUwzMea2ZJy+VpWSx2mFB7gWBBQ86uQodaO+eaCAe30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783563919; c=relaxed/simple;
	bh=QXsjV4NaYVGei1H5/S8D/ykEpyubqKjLsaih656Iu98=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WA4MUmE4XWBUy56fIGXc4rZSo7w7C4rxx1QTcPi42ZhI8UXvec69Jpp8MMqIgpxtlsS03qUowPwNkLRoqBnEIMWlR+zrI7wbXaG0QgIhG9zlXJ8/ZnyN9iWCKogTy7i6HJAb9XAVl0MYwCbiWBAiYVGRKX3fzlgqaUz9G6k9YFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E8WMl3BQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E8WMl3BQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21DC01F000E9;
	Thu,  9 Jul 2026 02:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783563918;
	bh=4vmf1i6xNkT3gu+kg6jFfcHw++woI6LTWcPUDQWDk68=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=E8WMl3BQar5pxJmyNHSJt5EtdKzdMtcw/NM7230DfoXQykp1aHEOaX2j8JotFkiX6
	 E4GUPq9k2gsQLfWYeS+RY7I2v7j8zHKGJCfDuZj6gDsyTbUkFp5O+QM86KWpQnFTeG
	 HYUyW20dTkHZ0qsSp9SRcX02pZgl4qZlntMo7T9/IvT0IQdzdKBLZNKkHDs0k0PW33
	 ngVSDXOdLDXcMll6qlS2P6asbuWK4fvxJKVJAF6h1N47oCYYn24mZ2oH25NZJxULt1
	 3gs43lmvPGZaVMkJSw+lXosKuJT67ZmBhKzeMQhu56B2CRFg6ua0dix6A4MrFodZA3
	 eNodk2kWw10nA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] ata: sata_mv: Use platform_get_irq() to get interrupt
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rosen Penev" <rosenp@gmail.com>
Cc: linux-ide@vger.kernel.org, dlemoal@kernel.org, cassel@kernel.org
In-Reply-To: <20260709021232.2042777-1-rosenp@gmail.com>
References: <20260709021232.2042777-1-rosenp@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 02:25:17 +0000
Message-Id: <20260709022518.21DC01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [Low] The `if (!irq)` check after calling `platform_get_irq()` is dead co=
de.

Pre-existing issues:
- [High] The sanity check `pdev->num_resources !=3D 1` unconditionally brea=
ks probing for legacy non-DT platforms.
- [High] Unconditional dereference of `mv_platform_data` for non-DT platfor=
m devices.
- [High] Port clock reference and enable state are leaked if PHY initializa=
tion fails.
--

--- Patch [1]: [PATCH] ata: sata_mv: Use platform_get_irq() to get interrup=
t ---
commit f1861b64daa8effebc2bb7261bbf40da10b32a2b
Author: Rosen Penev <rosenp@gmail.com>

ata: sata_mv: Use platform_get_irq() to get interrupt

This commit simplifies the driver's probe logic by using platform_get_irq()
unconditionally to fetch the interrupt. It replaces the direct use of
irq_of_parse_and_map() on DT-based systems.

> diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
> index 41647a56a9f4e..b109eb4ef995d 100644
> --- a/drivers/ata/sata_mv.c
> +++ b/drivers/ata/sata_mv.c
> @@ -4054,13 +4054,11 @@ static int mv_platform_probe(struct platform_devi=
ce *pdev)
>  				n_ports);
>  			return -EINVAL;
>  		}
> -
> -		irq =3D irq_of_parse_and_map(pdev->dev.of_node, 0);
>  	} else {
>  		mv_platform_data =3D dev_get_platdata(&pdev->dev);
>  		n_ports =3D mv_platform_data->n_ports;

[Severity: High]
This isn't a bug introduced by this patch, but could mv_platform_data be NU=
LL
here in mv_platform_probe()? If a non-DT device is probed without valid
platform data (e.g., bound manually via sysfs), dereferencing it
unconditionally would cause a NULL pointer dereference.

> -		irq =3D platform_get_irq(pdev, 0);
>  	}
> +	irq =3D platform_get_irq(pdev, 0);
>  	if (irq < 0)
>  		return irq;
>  	if (!irq)

[Severity: Low]
Since platform_get_irq() returns negative error codes on failure and interc=
epts
0 internally to return -EINVAL, is the if (!irq) check in mv_platform_probe=
()
now dead code?

>  		return -EINVAL;

While reviewing this probe function, I noticed a couple of other
pre-existing issues.

[Severity: High]
This is a pre-existing issue, but I am wondering if this sanity check
unconditionally breaks probing for legacy non-DT platforms:

drivers/ata/sata_mv.c:mv_platform_probe() {
	/*
	 * Simple resource validation ..
	 */
	if (unlikely(pdev->num_resources !=3D 1)) {
		dev_err(&pdev->dev, "invalid number of resources\n");
		return -EINVAL;
	}
...
}

Legacy board files initializing the sata_mv device add both an IORESOURCE_M=
EM
and an IORESOURCE_IRQ resource, making num_resources =3D=3D 2. It looks lik=
e this
would cause the probe to immediately abort with -EINVAL.

[Severity: High]
This is another pre-existing issue, but it appears that the clock reference
and enable state might be leaked if PHY initialization fails:

drivers/ata/sata_mv.c:mv_platform_probe() {
...
		hpriv->port_phys[port] =3D devm_phy_optional_get(&pdev->dev,
							       port_number);
		if (IS_ERR(hpriv->port_phys[port])) {
			rc =3D PTR_ERR(hpriv->port_phys[port]);
			hpriv->port_phys[port] =3D NULL;
			if (rc !=3D -EPROBE_DEFER)
				dev_warn(&pdev->dev, "error getting phy %d", rc);

			/* Cleanup only the initialized ports */
			hpriv->n_ports =3D port;
			goto err;
		}
...
}

If clk_get() and clk_prepare_enable() succeed for a port, but the subsequent
devm_phy_optional_get() fails (e.g., returning -EPROBE_DEFER), the error
handler sets hpriv->n_ports =3D port.

Since the cleanup loop uses a for-loop up to hpriv->n_ports, the current
port index is excluded. Would this bypass clk_disable_unprepare() and
clk_put() for the currently failing port?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709021232.2042=
777-1-rosenp@gmail.com?part=3D1
