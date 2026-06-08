Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF6A4A23
	for <linux-ide@vger.kernel.org>; Mon,  8 Jun 2026 22:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780956625; cv=none; b=axKqoMPY5gny4I6bXA33HJun3ia9qn7nCvcmmUXqPsAnnpeGbPYg0kLhV0FsjqyYrhW6svu+emLcaz8RM3OKL7D6usx4AIJlYSzqLnLvCzVgyl5TNNICXIhkjsHQe3hCQ+/z4w03X+tqwcWoIZDE3l3FXcv+GEuQmWrBzMsFeG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780956625; c=relaxed/simple;
	bh=KE1URthg5wPXrsimnxgPXV0b5MyZHPh1nLN0I6zv4QU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jYNF6f9ODB+/3cc83ymuhEqGvF+WYG2jw/7gwQ/TyICRUbqesdx1Tc5RJk0eBC08dzweOk5k1ttVEwc4Cgm1UGoKUVkjY/pq0+KHWUyOpmRo5xZeiyCY4rhYhcDcmMyXrhgZN00Y44FFBJ8RtE/S9sSBTGQKNTqEx66+IN+dXso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j4PMv42T; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j4PMv42T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28F491F00893;
	Mon,  8 Jun 2026 22:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780956624;
	bh=kRN2X75VKptvNld7Kd5FwaL3kKo+miMUMuBtM+2MTOQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=j4PMv42TI8SyUuIxRBtE/xGX7huFIgAk/3A+zeamekZCnSVf2SPhv7+2NFwUzSvW3
	 8gflTBo9Ukmpfz0xrB+PAwluKG97LDnZBxT66Am9yTI8cJLHC0j6FWYpu0+nBh68/a
	 2YN8kXv/EA6MYPqweqKabCj9gok/O1dZr3cIqG43mpSxVVujFzmF417YFklG4IPQZe
	 hxAPIotCkFCWFD6oC86ZhygtBEwmvRDo3OVQIKtoDQ3uF8pJSTC8p06KPVeE+bj2EO
	 dUs4Lm9qTW0frxl3aoBMWJ9Nu31YWCVslEoNpXpVz4VQQNQlogcpSwtMBRtAIepEOx
	 u+Ax+U/+2wS8g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 1/6] ata: libata-scsi: add atapi_max_lun module
 parameter
Reply-To: sashiko-reviews@lists.linux.dev
To: "Phil Pemberton" <philpem@philpem.me.uk>
Cc: linux-ide@vger.kernel.org, dlemoal@kernel.org, cassel@kernel.org
In-Reply-To: <20260608213443.2296614-2-philpem@philpem.me.uk>
References: <20260608213443.2296614-2-philpem@philpem.me.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 22:10:23 +0000
Message-Id: <20260608221024.28F491F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Logic and documentation mismatch in `atapi_max_lun` leading to a=
n off-by-one configuration error.
--

commit 62d1cf766cb69ddd660120719652195586b409e8
Author: Phil Pemberton <philpem@philpem.me.uk>

ata: libata-scsi: add atapi_max_lun module parameter

This commit introduces a libata module parameter atapi_max_lun to control
the upper bound of the per-host SCSI LUN scan for ATAPI devices. The
default is 1 to preserve existing behavior, but can be clamped up to
ATAPI_MAX_LUN (8) to support multi-LUN ATAPI devices.

> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index e76d15411e2ae..4408b1fb48c77 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c

[ ... ]

> @@ -122,6 +122,11 @@ int atapi_passthru16 =3D 1;
>  module_param(atapi_passthru16, int, 0444);
>  MODULE_PARM_DESC(atapi_passthru16, "Enable ATA_16 passthru for ATAPI dev=
ices (0=3Doff, 1=3Don [default])");
> =20
> +int atapi_max_lun =3D 1;
> +module_param(atapi_max_lun, int, 0444);
> +MODULE_PARM_DESC(atapi_max_lun,
> +	"Maximum LUN to scan on ATAPI devices flagged BLIST_FORCELUN (1 [defaul=
t] .. 7)");

[Severity: Medium]
Is this documentation correct about the upper limit being 7?

The SCSI core treats shost->max_lun as an exclusive upper bound, meaning it
represents the total count of LUNs to scan. If a user sets atapi_max_lun to=
 7
based on this description, only LUNs 0 through 6 will be scanned, missing
LUN 7.

> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index f44612e269a4d..32c6a0e497cf9 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c

[ ... ]

> @@ -4627,7 +4627,7 @@ int ata_scsi_add_hosts(struct ata_host *host, const=
 struct scsi_host_template *s
>  		shost->transportt =3D &ata_scsi_transportt;
>  		shost->unique_id =3D ap->print_id;
>  		shost->max_id =3D 16;
> -		shost->max_lun =3D 1;
> +		shost->max_lun =3D clamp(atapi_max_lun, 1, ATAPI_MAX_LUN);

[Severity: Medium]
Since ATAPI_MAX_LUN is 8, the clamp allows a value of 8. To correctly scan =
up
to LUN 7, should the module parameter description be updated to indicate the
maximum value is 8? Or does atapi_max_lun require a +1 adjustment when
assigning it to shost->max_lun in ata_scsi_add_hosts()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608213443.2296=
614-1-philpem@philpem.me.uk?part=3D1
