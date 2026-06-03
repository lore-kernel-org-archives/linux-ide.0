Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26FFA40F8D3
	for <linux-ide@vger.kernel.org>; Wed,  3 Jun 2026 10:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780483611; cv=none; b=ZaBIQ39Tw6B+ZSZ7Re+iElHnB3kdnEBnPmSSL13aoSEbOPZnKsG8mBrPUxjpU6BG2d2jg0+TbyxrStsuMGV+4+i/e2d573trB9v0iJFT8nOQaEfbzFI2mTWB9m1bQix09+wm873PvKU0g9cABoxLgDZpnZLKxI8WeFhyBFashKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780483611; c=relaxed/simple;
	bh=jfyZdH9LMO8R8x7YYyX+nrKmYx6mT/H4WspDcKbDg6I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tM0ISfo9LppUyepBM6ns8Pc9/S4L7K71GNYXbyl0lHtrKzMOwBrkAc6SL8S1oUgDEUXJAB2IYDY5+mieXSuwc3gluDafWTxIh9zgHiRt509PlS3TUutcguQBb8NROgNoOPhCFPQxKoX06sprv06kFbDNiM0woOH+8D9SyrfYrCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aKDuqN6n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aKDuqN6n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7252A1F00898;
	Wed,  3 Jun 2026 10:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780483608;
	bh=rgSb+Bs1jwWGgAli6JIlsh9hmUnSV53ncSCq57a9NAc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aKDuqN6ne4txsmDIVgdzYZ2Txtj2JM/Sx+IdkFx0FS6u2HiJ8IyyoKu8XjOvt5nM9
	 D4Si24rKtIuq9IcVAW2exptKmlT4eRI3s2PbbPd2JreCkR3Tu1gOD7n3+aPZa/wy31
	 gK4Ho6esOVErsdpxL4FixqHDjpakDCdhuBqjwy4AcbdpgjOdRiq+1e8KsK/77eihAE
	 8SAFiUpkDULBlagL6718j943pAsjxKDqHx3DgppJTR6NkrJ1jhLfBhMYY1BxACCZZr
	 /K1YM5uMHZZVupEVkhfpXcOjXDdf5COiiXhzfmF60ojX6TeQepIzctAh5vughWgJCK
	 rEdxpc+zO6Yqw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] ata: ahci_brcm: fix refcount leak in brcm_ahci_probe()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wentao Liang" <vulab@iscas.ac.cn>
Cc: linux-ide@vger.kernel.org, dlemoal@kernel.org, cassel@kernel.org
In-Reply-To: <20260603103008.3741481-1-vulab@iscas.ac.cn>
References: <20260603103008.3741481-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 03 Jun 2026 10:46:48 +0000
Message-Id: <20260603104648.7252A1F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing shared reset control cleanup in brcm_ahci_remove() permane=
ntly leaks the triggered state.
- [High] Missing shared reset control cleanup in the error paths of brcm_ah=
ci_resume() leads to a state leak.
- [High] Unconditional reset assertion in brcm_ahci_suspend() on failure pa=
ths leaves the device in an unrecoverable broken state.
--

commit cb11553edeb17c9d408e236defe15a4cb5e6ff9e
Author: Wentao Liang <vulab@iscas.ac.cn>

ata: ahci_brcm: fix refcount leak in brcm_ahci_probe()

This commit fixes a refcount leak by properly routing the error path of
reset_control_deassert() to the out_reset label. This ensures the shared
reset control is correctly rearmed in brcm_ahci_probe().

> diff --git a/drivers/ata/ahci_brcm.c b/drivers/ata/ahci_brcm.c
> index 29be74fedcf01..e759e99b54be3 100644
> --- a/drivers/ata/ahci_brcm.c
> +++ b/drivers/ata/ahci_brcm.c
> @@ -491,7 +491,7 @@ static int brcm_ahci_probe(struct platform_device *pd=
ev)
>  		return ret;
>  	ret =3D reset_control_deassert(priv->rcdev_ahci);
>  	if (ret)
> -		return ret;
> +		goto out_reset;
> =20
>  	ret =3D ahci_platform_enable_clks(hpriv);
>  	if (ret)

While reviewing this fix, I noticed a few other related pre-existing issues
in this driver.

[Severity: High]
This is a pre-existing issue, but missing shared reset control cleanup in
brcm_ahci_remove() appears to permanently leak the triggered state:

drivers/ata/ahci_brcm.c:brcm_ahci_remove() {
    struct ata_host *host =3D dev_get_drvdata(&pdev->dev);
    struct ahci_host_priv *hpriv =3D host->private_data;
    struct brcm_ahci_priv *priv =3D hpriv->plat_data;

    brcm_sata_phys_disable(priv);

    ata_platform_remove_one(pdev);
}

Does this function fail to symmetrically rearm the shared reset control
acquired during probe?

If any other driver on the SoC holds a reference to this shared reset line,
wouldn't the triggered count be permanently leaked and never drop back to
zero?

Subsequent bind attempts or other drivers might then silently skip issuing
the hardware reset pulse.

[Severity: High]
This is also a pre-existing issue, but I have a question about the error
handling in brcm_ahci_resume():

drivers/ata/ahci_brcm.c:brcm_ahci_resume() {
    ...
    ret =3D reset_control_reset(priv->rcdev_rescal);
    if (ret)
        return ret;

    /* Make sure clocks are turned on before re-configuration */
    ret =3D ahci_platform_enable_clks(hpriv);
    if (ret)
        return ret;

    ret =3D ahci_platform_enable_regulators(hpriv);
    if (ret)
        goto out_disable_clks;
    ...
}

Do the error paths after reset_control_reset() return from the resume
sequence without properly rearming the shared reset control?

Like the issue addressed in brcm_ahci_probe(), could this cause the exact
same triggered count leak on the shared reset control, breaking the reset
functionality on subsequent resumes?

[Severity: High]
Finally, this is a pre-existing issue, but looking at brcm_ahci_suspend():

drivers/ata/ahci_brcm.c:brcm_ahci_suspend() {
    ...
    if (IS_ENABLED(CONFIG_PM_SLEEP))
        ret =3D ahci_platform_suspend(dev);
    else
        ret =3D 0;

    reset_control_assert(priv->rcdev_ahci);
    reset_control_rearm(priv->rcdev_rescal);

    return ret;
}

Are the reset controls unconditionally asserted and rearmed even when
ahci_platform_suspend() returns an error?

If the system suspend sequence is aborted (and resume won't be called),
does this forcefully leave the controller in reset while the rest of the
kernel expects it to be active?

Could this lead to I/O hangs if the root filesystem is on the affected driv=
e?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260603103008.3741=
481-1-vulab@iscas.ac.cn?part=3D1
