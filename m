Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A965478D
	for <linux-ide@vger.kernel.org>; Tue,  8 Sep 2026 02:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788835215; cv=none; b=l7PCFGKJ0Tpb0s5A4CDo7sZuErxx0aBZwRZUCWkio/HfeIjYALC/Dz1tTZ/Z1DlK1wh312f//0Syygq09e/S70YixHp0PBmtKswXlezaL/vovZsglGVOjvNHuVQbvBqYq3Wah9Cd+QSuOg1YQEhqH97o+3gskDa2PWotWbeNGus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788835215; c=relaxed/simple;
	bh=n+KGP1+O+F9qM7aY+fDOjq5knmoLqDbxjQayROC5KXQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=b3s8ae59U0P6Llg2MPM5lMco/EU0cBJS1xGc3VA4Fn8yu545H0iO2SFiuLKIdSSWVNk1AR3wtksAT17HmiKAViIEeaqliWJmkYGPC5H8ZgmeXCwc9Xb7btBBrasaZ/MryDkRbFEg5caZ2UQNlY37XzgR0vyuTAqRrpuMo6YX7xQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xq8aFeMb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xq8aFeMb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E57E1F00A3A;
	Tue,  8 Sep 2026 02:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788835213;
	bh=xEp8NICo18mYNeCNuLMOhODWx8871QgjCIF+grv6xAQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Xq8aFeMbqHbHRlYyVEElWrDuNGTWH5jJeRARCk9qYL5J3bTPTLza9nDKuMFfyY2Wu
	 R9IuFQUVFNRRWTmoro/Yqmnr5NxXwfYi3+QHvb694AIKbGYg83EVpz6bP2P4Pyb8Lk
	 Ty0LdhOBxNAXk+9U5Fskhobq+bReWpz86+t3y4gn+BpJiA4bf0+4C5/Pw8OnVTteIQ
	 BmPfLCHsNBGFj19MefBUbfhjFCPhiVoEJFRH3X8gfVFGiAAtBhDLcoHpX064KWTVwy
	 YW/YFySVAkeBGTIFhT6/fuhPng7IhGnUNFEsq6jX1OpncigVf2EhC2tpR3/vehz0lW
	 VH0DKRKR7cALQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] ata: ahci_da850: switch to DEFINE_SIMPLE_DEV_PM_OPS
Reply-To: sashiko-reviews@lists.linux.dev
To: "Li Jun" <lijun01@kylinos.cn>
Cc: cassel@kernel.org, linux-ide@vger.kernel.org, dlemoal@kernel.org
In-Reply-To: <20260908023054.574049-1-lijun01@kylinos.cn>
References: <20260908023054.574049-1-lijun01@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 02:40:12 +0000
Message-Id: <20260908024013.6E57E1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Missing pm_ptr() wrapper when assigning dev_pm_ops, causing an inco=
mplete API migration and dead code retention when PM is disabled.
--

commit 4fb37d41387c46fd87ad058aea812f8fa3640dc6
Author: Li Jun <lijun01@kylinos.cn>

ata: ahci_da850: switch to DEFINE_SIMPLE_DEV_PM_OPS
   =20
Replace the deprecated SIMPLE_DEV_PM_OPS macro with the recommended
DEFINE_SIMPLE_DEV_PM_OPS.

> diff --git a/drivers/ata/ahci_da850.c b/drivers/ata/ahci_da850.c
> index f97566c420f84..ca874f097c2b1 100644
> --- a/drivers/ata/ahci_da850.c
> +++ b/drivers/ata/ahci_da850.c
> @@ -227,7 +227,7 @@ static int ahci_da850_probe(struct platform_device *p=
dev)
>  	return rc;
>  }
> =20
> -static SIMPLE_DEV_PM_OPS(ahci_da850_pm_ops, ahci_platform_suspend,
> +static DEFINE_SIMPLE_DEV_PM_OPS(ahci_da850_pm_ops, ahci_platform_suspend,
>  			 ahci_platform_resume);

[Severity: Low]
Should this change also update the driver definition to use the pm_ptr()
macro?

The goal of migrating to DEFINE_SIMPLE_DEV_PM_OPS is to allow dead code
elimination when PM is disabled. However, ahci_da850_pm_ops is still
unconditionally referenced in the ahci_da850_driver structure:

static struct platform_driver ahci_da850_driver =3D {
	...
	.driver =3D {
		.name =3D DRV_NAME,
		.of_match_table =3D ahci_da850_of_match,
		.pm =3D &ahci_da850_pm_ops,
	},
};

Can we wrap the assignment with pm_ptr(&ahci_da850_pm_ops) to complete the
API migration and allow the structure to be correctly dropped when CONFIG_P=
M=3Dn?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908023054.5740=
49-1-lijun01@kylinos.cn?part=3D1
