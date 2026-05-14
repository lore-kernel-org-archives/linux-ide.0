Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 278021C84D7
	for <linux-ide@vger.kernel.org>; Thu, 14 May 2026 00:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778717539; cv=none; b=G0A9CSy1rdQl16Wq1IqbYcs7V293Dn655/M1lPPugCppsJ0piTIXhV0Ypmqu+ex06pOShktFzMw+RPSHssEU0Q4JH66KJxLcqAslAXXCNrdwHwqc2slNDHtG3dVRxBybHof8XWMeI0VvkfAJjBBcX4zS91hejMwHrHyqpAFo5X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778717539; c=relaxed/simple;
	bh=itUvQc6SHifVf5/iG2YGQ7b4LEGjRDPg4seHTDS240E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=a4Yf91mXDWsVp9cBqMc4PdT5GQXLJNd2K+ag6H2Jfc9P9KRkJsFb9xERTxzaGvWWm0MIKNTnlF9dTtiJA/HpbX3v9cTBiUG9G7dwcYz11wUKqvUKM1qKTnKjfrweLfckLOJLbEbj6qLousDz/nUxoPl/1Hi2nUmKFCQwfvzQp8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hprClYby; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hprClYby"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86235C19425;
	Thu, 14 May 2026 00:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778717538;
	bh=itUvQc6SHifVf5/iG2YGQ7b4LEGjRDPg4seHTDS240E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=hprClYbyGOYB6n/Adg62eC2a51k9SAiVWxUv0uc9uDf1vKl3ZVDSv7qBlHiQfcVti
	 CYNkLgbZYrVm1OzQUajD3FFsk6j7Lm8dPmg8kjKc7pPINyRy/TNEwrhaVfPgdra/kH
	 fMa7U0u4NQY6+/5sT64YZo7Q/17lm9BAiQHQWkW6RsTgyovpugMLZXklz2lJGwZ5fd
	 wH5f1i40vp8FpdPqIVE3dXtquFaeVVb/wBZuOboDl9QYdYDXayHuiKVwlf4GxwEQwm
	 DTNRaZqrw+ashqHorqqvt479lWq1Cp/N8nNnaVGi88uH92z6ay2AXCE8U1K9cnPi8l
	 yXM/HfvfwK1DA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 1/6] ata: libata-scsi: add atapi_max_lun module
 parameter
Reply-To: sashiko-reviews@lists.linux.dev
To: "Phil Pemberton" <philpem@philpem.me.uk>
Cc: linux-ide@vger.kernel.org, cassel@kernel.org, dlemoal@kernel.org
In-Reply-To: <20260512202728.299414-2-philpem@philpem.me.uk>
References: <20260512202728.299414-2-philpem@philpem.me.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 May 2026 00:12:18 +0000
Message-Id: <20260514001218.86235C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Unnecessary introduction of a global module parameter for a hard=
ware quirk.
- [Medium] Off-by-one mismatch between the `atapi_max_lun` parameter descri=
ption and its application as an exclusive upper bound.
--

commit 4a1228303dd79171832c9f9e8bbe33af4d0fc449
Author: Phil Pemberton <philpem@philpem.me.uk>

ata: libata-scsi: add atapi_max_lun module parameter

This commit introduces the atapi_max_lun module parameter to control the
upper bound of the per-host SCSI LUN scan for ATAPI devices. This enables
scanning past LUN 0 for multi-LUN devices.

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

Is this module parameter strictly necessary?

The commit message notes that LUN>0 probing is securely gated behind the
BLIST_FORCELUN SCSI device quirk. Because this safeguard exists, requiring a
global kernel command-line parameter in addition to the quirk seems redunda=
nt
and defeats the automatic detection philosophy of the quirk system.

Could the code dynamically increase shost->max_lun when the BLIST_FORCELUN
quirk is detected on LUN 0, eliminating the need for a global parameter?

Furthermore, does the documentation introduce an off-by-one mismatch?

The parameter is documented as "Maximum LUN to scan ... (1 [default] .. 7)",
which implies an inclusive maximum LUN ID. However, this value is assigned
directly to shost->max_lun:

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

Because the SCSI midlayer treats shost->max_lun as an exclusive limit,
setting atapi_max_lun=3D7 based on the documentation will cause a regression
where the scanner stops at LUN 6, completely missing LUN 7.

> diff --git a/include/linux/libata.h b/include/linux/libata.h
> index 5c085ef4eda7b..3e33ee30628d0 100644
> --- a/include/linux/libata.h
> +++ b/include/linux/libata.h
[ ... ]
> @@ -131,6 +131,7 @@ enum {
>  	ATA_SHORT_PAUSE		=3D 16,
> =20
>  	ATAPI_MAX_DRAIN		=3D 16 << 10,
> +	ATAPI_MAX_LUN		=3D 8,	/* SCSI-2 cap (LUN values 0..7) */

Since the clamp function bounds the value to ATAPI_MAX_LUN (which is 8), the
value 8 is required to scan all 8 SCSI-2 LUNs, making the documentation
suggesting 7 as the maximum misleading.

Should the documentation be updated to clarify that it controls the total
number of LUNs (an exclusive bound), or should the parameter be treated as =
an
inclusive maximum?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260512202728.2994=
14-1-philpem@philpem.me.uk?part=3D1
