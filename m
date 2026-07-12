Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C28B381EA1
	for <linux-ide@vger.kernel.org>; Sun, 12 Jul 2026 22:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783895515; cv=none; b=gMib4lOe+RNcHeWwmtOFbegzUbNPHuGudtCQROUVZGCpgS/2/GnBuq3LWpJSdOC1CgkGof7aAFQxr58gzBAewlf7i+5QD01Y6QwD6QpK97BLhqIeOHCrSHcHZPf7DpDMgVLjH9znUW6Kh2sx1t492Lql1mg8ShMGmG00t+7Xu18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783895515; c=relaxed/simple;
	bh=Xyti5/isC0lBpkk+UmgVCT60LoXbNQ1E2pjM8BRkZv0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ciymdpSDd8MSfOzLwO36JBSkZ224OrCV6gHXv+DPGOksGssub4H4PswN+0vj0WNipwNUTZJL5xVU4YqBT2BSfu24FJxc0SJ8aBjHOjoPgOBTNUktpIHG5Mr4NhxdwdSepJH3Fkmxm363l1qwktMFs6VIxP478orr/gAVD3OkiFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=knMsII5Q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="knMsII5Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B24241F000E9;
	Sun, 12 Jul 2026 22:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783895514;
	bh=+ejq14DqTsCHICzruEBn5wWrfu9kJkygeOpTlx8E+2k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=knMsII5QlAe2l+SWCd/bmHvlcJ8/88UqU+Xp8Ih2BxIhG8BTTy4/LFZtXLRR+Cr8i
	 nlQV5hlleUxQno1wkzFBjUw14oA1FmUB5xzhOtUuY9IJCmza4ON7m+NEYcJvgw7JRp
	 aamZsD4frJW89GFPuV27g7Z9m7nyO7sHBO8Ar5acJIhsLIDbHB8MZ7MNkkkMYx4BHn
	 Z1mBW6y9K8OWbuRdXiqMrSv3WutGtpdddp6j6J2TnDCg8YNO2gJ6le9lFoBV0la7CI
	 D1K5dPIC4JMoxk3CpkOr7wXDKPNPSw8Jfgn12kU+WCfqkE2M4pXoIS/TYj7Jz6uVr9
	 Rk6G8cYUN8Yyg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCHv2] ata: sata_mv: Use platform_get_irq() to get interrupt
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rosen Penev" <rosenp@gmail.com>
Cc: dlemoal@kernel.org, cassel@kernel.org, linux-ide@vger.kernel.org
In-Reply-To: <20260712222003.1008136-1-rosenp@gmail.com>
References: <20260712222003.1008136-1-rosenp@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 12 Jul 2026 22:31:53 +0000
Message-Id: <20260712223153.B24241F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing NULL check for `mv_platform_data` causes a kernel panic if=
 the driver is bound to a device without platform data.
- [High] The `pdev->num_resources !=3D 1` check prevents initialization on =
legacy platforms that provide multiple resources.
- [High] Unbalanced clock cleanup in error path triggers CCF warnings.
- [High] Clock resource leak when port PHY retrieval fails.
--

--- Patch [1]: [PATCHv2] ata: sata_mv: Use platform_get_irq() to get interr=
upt ---
commit a89dd91d3fc9df13b699dc2ac8e0b99f240449bf
Author: Rosen Penev <rosenp@gmail.com>

ata: sata_mv: Use platform_get_irq() to get interrupt

Extract platform_get_irq() out of the conditional block to run it
unconditionally, replacing the direct use of irq_of_parse_and_map()
for DT-based systems. This simplifies the probe logic and avoids the
need for irq_dispose_mapping. Remove dead branch for platform_get_irq().

> diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
> index 41647a56a9f4e..a2bf9551a6008 100644
> --- a/drivers/ata/sata_mv.c
> +++ b/drivers/ata/sata_mv.c
> @@ -4054,17 +4054,13 @@ static int mv_platform_probe(struct platform_devi=
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
This is a pre-existing issue, but is there a missing NULL check here?

If the driver is manually bound via sysfs to a platform device lacking plat=
form
data (and without a device tree node), dev_get_platdata() returns NULL, whi=
ch
is immediately dereferenced when accessing n_ports. Could this cause a pani=
c?

> -		irq =3D platform_get_irq(pdev, 0);
>  	}
> +	irq =3D platform_get_irq(pdev, 0);
>  	if (irq < 0)
>  		return irq;
> -	if (!irq)
> -		return -EINVAL;
> =20
>  	host =3D ata_host_alloc_pinfo(&pdev->dev, ppi, n_ports);
>  	hpriv =3D devm_kzalloc(&pdev->dev, sizeof(*hpriv), GFP_KERNEL);

[Severity: High]
This isn't a bug introduced by this patch, but does the strict resource=20
validation in mv_platform_probe() prevent initialization on legacy platform=
s?

drivers/ata/sata_mv.c:mv_platform_probe() {
    ...
	if (unlikely(pdev->num_resources !=3D 1)) {
		dev_err(&pdev->dev, "invalid number of resources\n");
		return -EINVAL;
	}
    ...
}

Legacy board files instantiate the sata_mv platform device with two resourc=
es=20
(an IORESOURCE_MEM and an IORESOURCE_IRQ). This validation causes the probe=
 to
immediately abort with -EINVAL. Could this render the SATA controller unusa=
ble=20
on legacy Orion boards?


[Severity: High]
This is a pre-existing issue, but does the cleanup path in mv_platform_prob=
e()
unbalance the clock enable count?

drivers/ata/sata_mv.c:mv_platform_probe() {
    ...
	hpriv->clk =3D clk_get(&pdev->dev, NULL);
	if (IS_ERR(hpriv->clk)) {
		dev_notice(&pdev->dev, "cannot get optional clkdev\n");
	} else {
		rc =3D clk_prepare_enable(hpriv->clk);
		if (rc)
			goto err;
	}
    ...
err:
	if (!IS_ERR(hpriv->clk)) {
		clk_disable_unprepare(hpriv->clk);
		clk_put(hpriv->clk);
	}
    ...
}

If clk_prepare_enable(hpriv->clk) fails, the code branches to the err label.
Because !IS_ERR(hpriv->clk) evaluates to true (the pointer is valid), the=20
cleanup path attempts to disable the clock despite the initialization failu=
re.=20
Does this trigger a WARN_ON in the Common Clock Framework?


[Severity: High]
This is a pre-existing issue, but is there a clock resource leak in
mv_platform_probe() when port PHY retrieval fails?

drivers/ata/sata_mv.c:mv_platform_probe() {
    ...
	for (port =3D 0; port < n_ports; port++) {
        ...
		hpriv->port_clks[port] =3D clk_get(&pdev->dev, port_number);
		if (!IS_ERR(hpriv->port_clks[port]))
			clk_prepare_enable(hpriv->port_clks[port]);

		sprintf(port_number, "port%d", port);
		hpriv->port_phys[port] =3D devm_phy_optional_get(&pdev->dev,
							       port_number);
		if (IS_ERR(hpriv->port_phys[port])) {
			rc =3D PTR_ERR(hpriv->port_phys[port]);
			hpriv->port_phys[port] =3D NULL;
            ...
			hpriv->n_ports =3D port;
			goto err;
		} else
    ...
err:
    ...
	for (port =3D 0; port < hpriv->n_ports; port++) {
		if (!IS_ERR(hpriv->port_clks[port])) {
			clk_disable_unprepare(hpriv->port_clks[port]);
			clk_put(hpriv->port_clks[port]);
		}
		phy_power_off(hpriv->port_phys[port]);
	}
    ...
}

Inside the per-port initialization loop, hpriv->port_clks[port] is obtained=
=20
and enabled. Immediately after, devm_phy_optional_get() is called. If this=
=20
fails (e.g., returning -EPROBE_DEFER), the error handler sets=20
hpriv->n_ports =3D port and jumps to the err label.=20

The cleanup loop iterates up to hpriv->n_ports - 1, thereby skipping the=20
current port and failing to call clk_disable_unprepare() and clk_put() on t=
he
successfully acquired clock. Can this cause a clock reference leak that
accumulates if the PHY driver defers probing?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260712222003.1008=
136-1-rosenp@gmail.com?part=3D1
