Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5500854EEAE
	for <linux-ide@vger.kernel.org>; Thu, 10 Sep 2026 17:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789061353; cv=none; b=HotaFuCcoe9GSvkKX+iC1xDPyuJ322ZUAZjKMemIVPVuwLBJ2hLNlle3x1MFdHzgohp4DkmH422flViF2FLXlYKso4sb131LR2ECq//aw5iq1/KLZa1ZD5lfioTmhlliiol7R1y2aeAzQ8x1i5n+rPAgdzigz0JhpSm8U8woNd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789061353; c=relaxed/simple;
	bh=P8BWgxiPI3sZkOgsO5+xuI2eQ2SR0LK6NCZ2vdvjDk8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ILq+zfU5ggzgi3MGb1jVhaaIKcB3s2EhwQHEh+PJh/6K+vbd8DXLhUXKPO6JHY9qgk68SKPyYzRMqJm0eGu7rLWoAPWpZI5fu2xYVHzyohedckgYnCkTxhmFoc3a208YVRrPALQ07BjlFwg4drVTyPf213yW1DRwoN3/Nz5aBP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IrEfKyq8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IrEfKyq8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 397C41F000FF;
	Thu, 10 Sep 2026 17:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789061344;
	bh=skCUaBy2VbnE+2CCIkbwEZqVSV68F9I4Au5vskZpJnI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IrEfKyq8NcezorMAmwzVtbFvRCSy5yfvJdp3bEpVR1SzZcUdYSqsfPX8ap3h/mrEX
	 X0ClGxUqdkITa/nkCL44z0fGM8fRbeTZ7uG1Igu62x2OS9xiYPxEn/IhKRXhL50PXc
	 kib2V0S2GrMTtoYXKOxZKsWZMUL2tPihgNutr/lCG8KmXPIBjdsWoqVB6zh49nW/Iq
	 Ve9R9rCYEZo2a9FilKmblPg56h7GDo5ZT4xWsHAgqpeXEWEFfjVNtXXhLnDb8P19pQ
	 m53av74nCuU4UYmzfkJocmPmL1Hx496nLjWHVjdHuFeubWYtRQtK/OU7mqAeun6Dul
	 JJuLbc+aqnEhg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/5] ata: ahci_st: Assert the power down reset in the
 probe() error path
Reply-To: sashiko-reviews@lists.linux.dev
To: "Niklas Cassel" <cassel@kernel.org>
Cc: dlemoal@kernel.org, linux-ide@vger.kernel.org, cassel@kernel.org
In-Reply-To: <20260910171406.131211-8-cassel@kernel.org>
References: <20260910171406.131211-7-cassel@kernel.org>
 <20260910171406.131211-8-cassel@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 17:29:03 +0000
Message-Id: <20260910172904.397C41F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] st_ahci_probe_resets() blindly masks all errors from devm_reset_co=
ntrol_get(), breaking probe deferral and leading to kernel panics.
--

commit aedfb0423cffc301a78c793e7a81df6e88c712e0
Author: Niklas Cassel <cassel@kernel.org>

ata: ahci_st: Assert the power down reset in the probe() error path

This commit updates the probe error path and host stop functions in the
ahci_st driver to properly assert the power down reset. It extracts the res=
et
assertion logic into a helper function and ensures the SATA IP is not left
powered up if initialization fails after resets are deasserted.

> diff --git a/drivers/ata/ahci_st.c b/drivers/ata/ahci_st.c
> index 4336c8a6e2087..39ebedf93344d 100644
> --- a/drivers/ata/ahci_st.c
> +++ b/drivers/ata/ahci_st.c
[ ... ]
> @@ -162,38 +171,38 @@ static int st_ahci_probe(struct platform_device *pd=
ev)
> =20
>  	err =3D ahci_platform_enable_resources(hpriv);
>  	if (err)
> -		return err;
> +		goto assert_pwrdwn;

[Severity: High]
This isn't a bug introduced by this patch, but while reviewing the probe pa=
th
here, I noticed a pre-existing issue in st_ahci_probe_resets(), which
executes just before ahci_platform_enable_resources().

Does st_ahci_probe_resets() blindly mask all errors from
devm_reset_control_get(), breaking probe deferral?

drivers/ata/ahci_st.c:st_ahci_probe_resets() {
    ...
    drv_data->pwr =3D devm_reset_control_get(dev, "pwr-dwn");
    if (IS_ERR(drv_data->pwr)) {
        dev_info(dev, "power reset control not defined\n");
        drv_data->pwr =3D NULL;
    }
    ...
}

If the reset controller driver probes after the SATA driver,
devm_reset_control_get() returns -EPROBE_DEFER.  Because the code treats th=
is
as a missing optional reset, it continues initialization.

Will this cause an imprecise external abort (kernel panic) when
st_ahci_configure_oob() subsequently attempts to access the MMIO registers =
of
a hardware block that is still held in reset?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910171406.1312=
11-7-cassel@kernel.org?part=3D1
