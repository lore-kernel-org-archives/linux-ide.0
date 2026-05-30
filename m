Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C6D23BCE3
	for <linux-ide@vger.kernel.org>; Sat, 30 May 2026 00:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780102352; cv=none; b=sH7JsasRRTHWf+5E6knuyGfwoQ5XhhyEmyqEEeh8iu7oq0GWzlLvocCZ84bv3F8ddT82fauSjmJ2UrKsBb4qU0nY76VXuyQyXs8XWXvVQQiiHz+yFhYGiOXMte8JjnHNpfcoz6WrvwFMFESPO0tpZ+k0qnxZXvaOZ0EfyiPZor4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780102352; c=relaxed/simple;
	bh=Gnc+mQlbPvlTrEBn+z7gn41sU+dD2WWJQ/VRoahiL1w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SfOEBSfUq8Em8t5ntlpOLj2C667xlRrYFzIOuIkKh3++fr9lZsB/XP6lExauQP3L8G/uxRPCIwSvJvPUK6rwmyxEjqiahUsEzF6hWHxsNV0wsaY9MKSMOuVrrZ9ROPVQLCPZmr/CyCjl2jyIzgz0iaSomGNivzlHxhe+tZPpfbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b47w5nnV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b47w5nnV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A50A11F00893;
	Sat, 30 May 2026 00:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780102351;
	bh=8FDlgoitC6eGyZi9jUi79K1sWzBKi9zY6wlchGOFrkU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=b47w5nnVEGvuw9CpKkDYW8F8hWz/hl+neeLCHcDFjRXZWBCwcFV2a91dLW8OydYsc
	 lRWJMYtYcI5bitxYlie6aJtkrHOCK0NA3tJriifKUlrIncZOhPJvxbdSbn4xl7CB/a
	 /hiutCTKZcjDhI/xOiFxNe8xhcgwOxbCjrgTU6gJSWf4BmliNmo9z3i4hfNufNsUov
	 sAaza1mzIJJOX3mGpmOoR2+f8p0V/In8BbM/55r1iIMHBbAun1luxy1QO8/TnCeap9
	 WjMItmEXyfop0MD3DTuIYzU1Ynt+9amAMBG2gVs7C7EzMgklJAECx438PJB4r+W6gi
	 y1S3+9uNxMw1A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCHv2] ata: ahci_tegra: remove devm_kcalloc()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rosen Penev" <rosenp@gmail.com>
Cc: cassel@kernel.org, linux-ide@vger.kernel.org, dlemoal@kernel.org
In-Reply-To: <20260530004135.43088-1-rosenp@gmail.com>
References: <20260530004135.43088-1-rosenp@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 30 May 2026 00:52:31 +0000
Message-Id: <20260530005231.A50A11F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unchecked dereference of `soc` when retrieving `soc->num_supplies`=
 during memory allocation, leading to an immediate kernel panic if `of_devi=
ce_get_match_data()` returns NULL.
--

commit bf92e6df451c5a93edb05970118c13a24829ffcf
Author: Rosen Penev <rosenp@gmail.com>

ata: ahci_tegra: remove devm_kcalloc()

This commit combines the allocation for the tegra_ahci_priv structure and
its supplies flexible array into a single allocation to remove the use of
devm_kcalloc().

> diff --git a/drivers/ata/ahci_tegra.c b/drivers/ata/ahci_tegra.c
> index 554f05e09f983..142ba2ae1c831 100644
> --- a/drivers/ata/ahci_tegra.c
> +++ b/drivers/ata/ahci_tegra.c

[ ... ]

> @@ -514,6 +515,7 @@ static const struct scsi_host_template ahci_platform_=
sht =3D {
> =20
>  static int tegra_ahci_probe(struct platform_device *pdev)
>  {
> +	const struct tegra_ahci_soc *soc;
>  	struct ahci_host_priv *hpriv;
>  	struct tegra_ahci_priv *tegra;
>  	struct resource *res;
> @@ -523,14 +525,15 @@ static int tegra_ahci_probe(struct platform_device =
*pdev)
>  	if (IS_ERR(hpriv))
>  		return PTR_ERR(hpriv);
> =20
> -	tegra =3D devm_kzalloc(&pdev->dev, sizeof(*tegra), GFP_KERNEL);
> +	soc =3D of_device_get_match_data(&pdev->dev);
> +	tegra =3D devm_kzalloc(&pdev->dev, struct_size(tegra, supplies, soc->nu=
m_supplies), GFP_KERNEL);

[Severity: High]
This isn't a bug introduced by this patch, but can of_device_get_match_data=
()
return NULL if the driver is probed via sysfs bind with driver_override?

If it returns NULL, the immediate dereference of soc->num_supplies in the
struct_size() macro will cause a NULL pointer dereference. While this
vulnerability existed in the codebase before this patch, this patch shifts
the dereference earlier in the probe sequence.

Could a NULL check be added for soc before it is dereferenced?

>  	if (!tegra)
>  		return -ENOMEM;
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260530004135.4308=
8-1-rosenp@gmail.com?part=3D1
