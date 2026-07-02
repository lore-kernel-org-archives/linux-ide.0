Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C5038D40F
	for <linux-ide@vger.kernel.org>; Thu,  2 Jul 2026 06:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782974831; cv=none; b=mZZBu7Yb/JTUl93nGELAc21cNtbR0GlMM5x5oBbvBKPXTXoBNqCh3Yw8n4FbCQ3DDe1b7SgB3zwS/vIiLJNmmoj3TKGKEYuPsyq59tPcxeot7ZsZS+P2B5KK4nbqmMNr7/taPmzzTYTe70+n8ntz+3/PURNhT03E6ZvVuGKP2pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782974831; c=relaxed/simple;
	bh=UrUVmV7GfGuKP/s0R85C8uCyTI+69iOYN1EkpqEEk9Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IcETbGIGoer7WES/AtQHbgE9ZBKZ8R39x3qFuhQ7cVnKb7pLEpaGqb/YoqBjs5DunD1w0uA/JgSkqNjI0AvGfl794tnCvVAPJ31GRAz03+Y+mlggOSei6itWvs9xBa5OV7sPjaXv/fYvFzeuuEsKWhm6H1f/11uf36TtdLoR5h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S1eVBeDb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S1eVBeDb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E8811F000E9;
	Thu,  2 Jul 2026 06:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782974830;
	bh=J/iGlJhFhl9BNQhEVhtpM///uM3UEgrqVqr7VnsUoxs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=S1eVBeDbH+cJPrVbcup3mOHd9YQQD2YBOtUYrcO6AkuCEJ5h8SLUruRKIKnwHYDmr
	 4luCGG2fI2fclY+XUMMis/UO1T5RhNPxNhUiQ+PKYZ3ZrzsgHZ38xTBOf8+iM8noLV
	 do8ZuuHCUVIagvNB1Z62OtPH4uizVy/KCWx+0wsa0pKyxTMYEaFAZ2tn3gbL7Z/LVy
	 B0a6yjJXsa3lL6+O7tls9EOlzKUEJ7Je4Cb6xpe1eT8exuPLc7WxjdihkQ7QrTDS7h
	 nPy+5cj2bbIvlaMGFDQ8MhGdxLtGiPi+gGHKSWiazwyWdzao5GohHwTkKDxyPGUi8G
	 pdenyBpGlIgzw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/5] ata: libata-scsi: improve service action support
 in ata_scsi_report_supported_opcodes()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Damien Le Moal" <dlemoal@kernel.org>
Cc: dlemoal@kernel.org, linux-ide@vger.kernel.org, cassel@kernel.org
In-Reply-To: <20260702063412.1892584-4-dlemoal@kernel.org>
References: <20260702063412.1892584-1-dlemoal@kernel.org>
 <20260702063412.1892584-4-dlemoal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 06:47:10 +0000
Message-Id: <20260702064710.6E8811F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Improper handling of the REQUESTED SERVICE ACTION field for repo=
rting option 3 in REPORT SUPPORTED OPERATION CODES.
--

commit b3caa191a7aab568905b6cb9a00aa04fd0f6cf62
Author: Damien Le Moal <dlemoal@kernel.org>

ata: libata-scsi: improve service action support in ata_scsi_report_support=
ed_opcodes()

This commit updates ata_scsi_report_supported_opcodes() to consider the
service action specified in the SCSI command CDB. It adds support for faili=
ng
reporting options 1 if the opcode has service actions, and matches opcodes
with their service actions for reporting option 3.

> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index 4f0ae44f59dd2..86ac41a7d81ab 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
> @@ -3642,32 +3642,46 @@ static const struct ata_scsi_cmd ata_supported_cm=
ds[] =3D {
>  	{ SECURITY_PROTOCOL_OUT, 12,	false,	0 },
>  };
> =20
> -static const struct ata_scsi_cmd *ata_scsi_get_supported_cmd(u8 op)
> +static const struct ata_scsi_cmd *ata_scsi_get_supported_cmd(u8 op, u16 =
sa)
>  {
>  	const struct ata_scsi_cmd *cmd;
>  	int i;
> =20
>  	for (i =3D 0; i < ARRAY_SIZE(ata_supported_cmds); i++) {
>  		cmd =3D &ata_supported_cmds[i];
> -		if (cmd->op =3D=3D op)
> +		if (cmd->op =3D=3D op && cmd->sa =3D=3D sa)

[Severity: Medium]
If the queried command does not have a service action, its cmd->sa will be =
0.
If a non-zero service action was passed in through sa, this strict comparis=
on
will fail.

Since SPC-5 states that the REQUESTED SERVICE ACTION field "shall be ignore=
d"
when the operation code does not have service actions, could this result in
valid commands being incorrectly reported as unsupported?

>  			return cmd;
>  	}
> =20
>  	return NULL;
>  }

[ ... ]

> @@ -3713,15 +3727,28 @@ static unsigned int ata_scsi_report_supported_opc=
odes(struct ata_device *dev,
>  {
>  	struct ata_scsi_cmd_support sup;
>  	u8 *cdb =3D cmd->cmnd;
> -
> -	if (cdb[2] !=3D 1 && cdb[2] !=3D 3) {
> +	u16 sa =3D 0;
> +
> +	switch (cdb[2]) {
> +	case 1:
> +		/* One command format with command support data, ignore sa. */
> +		if (ata_scsi_supported_cmd_use_sa(cdb[3])) {
> +			ata_scsi_set_invalid_field(dev, cmd, 3, 0xff);
> +			return 0;
> +		}
> +		break;
> +	case 3:
> +		/* One command format */
> +		sa =3D get_unaligned_be16(&cdb[4]);
> +		break;

[Severity: Medium]
If the queried command (e.g., READ_10) doesn't use service actions, does
extracting the service action unconditionally here pass a non-zero value to
ata_scsi_get_supported_cmd() if the initiator provided one?

Should sa remain 0 if ata_scsi_supported_cmd_use_sa(cdb[3]) is false?

> +	default:
>  		ata_dev_warn(dev, "invalid command format %d\n", cdb[2]);
>  		ata_scsi_set_invalid_field(dev, cmd, 2, 0xff);
>  		return 0;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702063412.1892=
584-1-dlemoal@kernel.org?part=3D3
