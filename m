Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794417133;
	b=OcKJgyUI9k94E1iqDmsdhS8OWrgzngZqwimpaDk8yHAp6QMd2hnSfdLCrbXNVzzH48Ie
	 xqonAOgWcs1cG7Niai9CtES/ceAo/hZHruSET7R35SafXYt4Mqzsdv15UQw6inEWI6wn8
	 dkK+T0WysriJUbjewz2k9hax9umcd4tXj0kkXbdHT5pAsDNYTMLe5goe8+KAdAqy8Movc
	 sdpRnASXi4tqigUu7XICeiSW5HQW9XC6sTe8teOAqV5ySOICtsxllIvIgU3xlouQ/pnKB
	 vSGA97MYgOB9B9P5mD7aWNPG8DJkbSCk21PplZLDjnsOoecEMEVtSL0oB+ogiYZ2TGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794417133;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=A1dy58a3XbHUqT+nSKlUJY3AkEj6GkN+EA2AAQ+FlU4=;
	b=vFBaD/x4UmFoUzasG7dBWq9LHsMGoLB2JNsn6uLqTtDm5iEN/gWvK9U70cIlc6PpuoxI
	 YImYGkuVFjr1nUqb/I+D3GYtgPP9fal9xd2k+5Hf/E7PbIevTF/vAxTZEySBRiWEk5OLJ
	 hzV8LnPmZZyQ/Uw/4pTd8OzeR1yXDDCB3GAQBkcdG23v3fHvSK2NTZD2zzcY1Hmon1Qtt
	 Zpf+CQR1z/MSDL295u+eZ/RRQ2B2BosJNijGAfa7NWb/sjA5fBcyz5xBQrlmz7VEwWhi4
	 PU4hQ0Pk0zz+GvwRa94cQT1VlBvbGGrgUTljoSD09sjo0wKeFKEZYA64R8iBmJOMC1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fIDBmOMi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55246606A31C;
	Wed, 11 Nov 2026 17:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fIDBmOMi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3EBB1F00A05;
	Wed, 11 Nov 2026 17:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794417133;
	bh=A1dy58a3XbHUqT+nSKlUJY3AkEj6GkN+EA2AAQ+FlU4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fIDBmOMijgne+xy+ZDEPlStGsAFKtLX42VZV4p//zIVKFWV+tfidL0JF3bdVxzXec
	 YbsvOVYmj5YXuMZxhfc2tehN5caBqY0BnlPK7fUp+bNdJDpi++/JI+IPtOfcdTJxk6
	 wGlNuDltisB855Ea4YfqKaODi6coTnHhYm6it1kAtwhZpEk9lBLB1EqAq8nibicGtl
	 PnHbwvWKxSONWPGYkWjHWg9iy+c/XkqCAKtlowp3ffTvit5lSHv8H9Qx4fK1KIXZ2c
	 rHxzbYuhZNTDup+QcxzkyLLyRKsf46zVzFEUTHE6sAleJNPvUqUMWZboycP9vl/vSB
	 jpqH/SXNZATUw==
Message-ID: <sashiko-outbox-209383@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 2/7] ata: pata_cswarp: bind to the Warp mfd cell
 instead of the Zorro device
Reply-To: sashiko-reviews@lists.linux.dev
To: "Paolo Pisati" <p.pisati@gmail.com>
Cc: linux-ide@vger.kernel.org, mfd@lists.linux.dev, dlemoal@kernel.org, cassel@kernel.org, lee@kernel.org
In-Reply-To: <20261111163735.227286-3-p.pisati@gmail.com>
References: <20261111163735.227286-1-p.pisati@gmail.com>
 <20261111163735.227286-3-p.pisati@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 17:12:12 +0000
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Post: <mailto:linux-ide@vger.kernel.org>
List-Help: <mailto:linux-ide+help@vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-ide+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] ata: pata_cswarp: duplicate ata_platform_remove_one() and
  module_platform_driver()
--

commit 0358845c5d4b9568f67a2b55aedc3acc1ebbdef0
Author: Paolo Pisati <p.pisati@gmail.com>

ata: pata_cswarp: bind to the Warp mfd cell instead of the Zorro device

This commit converts pata_cswarp from a Zorro driver into a platform driver
that binds to the "warp-pata" MFD cell provided by warp-mfd.

> diff --git a/drivers/ata/pata_cswarp.c b/drivers/ata/pata_cswarp.c
> index 58fe6d0012dc5..41b4c93052cfd 100644
> --- a/drivers/ata/pata_cswarp.c
> +++ b/drivers/ata/pata_cswarp.c

[ ... ]

> @@ -145,34 +135,29 @@ static int pata_cswarp_probe(struct zorro_dev *z,
>  			  IRQF_SHARED, &pata_cswarp_sht);
>  }
> =20
> -static void pata_cswarp_remove(struct zorro_dev *z)
> +static void pata_cswarp_remove(struct platform_device *pdev)
>  {
> -	struct ata_host *host =3D dev_get_drvdata(&z->dev);
> +	struct ata_host *host =3D dev_get_drvdata(&pdev->dev);
> =20
>  	ata_host_detach(host);
>  }
> =20
> -static const struct zorro_device_id pata_cswarp_zorro_tbl[] =3D {
> -	{ .id =3D ZORRO_PROD_CSLAB_WARP_1260 },
> -	{ }
> -};
> -MODULE_DEVICE_TABLE(zorro, pata_cswarp_zorro_tbl);
> -
> -static struct zorro_driver pata_cswarp_driver =3D {
> -	.name           =3D "pata_cswarp",
> -	.id_table       =3D pata_cswarp_zorro_tbl,
> +static struct platform_driver pata_cswarp_driver =3D {
> +	.driver =3D {
> +		.name	=3D "warp-pata",
> +	},
>  	.probe          =3D pata_cswarp_probe,
>  	.remove         =3D pata_cswarp_remove,
>  };
> =20
>  static int __init pata_cswarp_init(void)
>  {
> -	return zorro_register_driver(&pata_cswarp_driver);
> +	return platform_driver_register(&pata_cswarp_driver);
>  }
> =20
>  static void __exit pata_cswarp_unregister(void)
>  {
> -	zorro_unregister_driver(&pata_cswarp_driver);
> +	platform_driver_unregister(&pata_cswarp_driver);
>  }

[Severity: Low]
Now that pata_cswarp is a platform_driver, could pata_cswarp_remove() be
replaced with libata's ata_platform_remove_one(), and pata_cswarp_init() /
pata_cswarp_unregister() with module_platform_driver(pata_cswarp_driver)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111163735.2272=
86-1-p.pisati@gmail.com?part=3D2
