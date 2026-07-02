Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2DB533D6
	for <linux-ide@vger.kernel.org>; Thu,  2 Jul 2026 02:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782958292; cv=none; b=OtfLWUIkk+MrTx1hB1wQHlztjWNSy2J3WQ86eq3bgDxPfmWfw7en+3cYUyZl5ogJXWnhrrKsdEjVqGWSRooz10iu2BqC1IRNYcoGm5PZvMeKUdHRhTOCmHmB7+Iy81Mzf7vvc6Y38BZDX1dDpMgqDE+9S/b8j6OOh4rP0yVsz4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782958292; c=relaxed/simple;
	bh=cShUDfc2wohhpEQpK7EjEISgCUyDMncKUE87MzGgrXY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MXlLdMw2gnx1+7c9SxAeYScBbcdW9f/os+2oNH7sm4gFtlenDCU7R9uxKlUQ9ANepvp9ftKRMpD5OrsVoDc08pOJUwvVG3+PVCSr8yTuaOROl/45yYU3tPvbgTHlnaj8zmeYHPab2s8QwdRXrBOyGJuP9PXlcL0L6Dno+eJy+AU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XghOZS8N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XghOZS8N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12F101F000E9;
	Thu,  2 Jul 2026 02:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782958291;
	bh=/WZiNlui5/aFwg13SneWqbmJmJ2v6yPZv/joIpvjdHc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XghOZS8NUIP9qHfhKuOVuU/aNQu7l7jpCXwmaKUP81rolJXBXshvz4rBL43+1Noq4
	 tejKPDOPgf3QrhYSqFMCQddh9Q2o4fU+WkuNtoB0jTwozdamR7KFwjWto3OOZBi9nn
	 gAjpmc49bRKGpX2b0LlLgH9AqkinDa1mYdwEUDm3pdAdWyjPyDqA3v3Ag//GBk96Qe
	 j1+dTxpJnoxecRchdDQfa69I8rkLPV+U7lj+PwEyU9t896ubR9F9+wi0qPHh1/hyEp
	 +tk0h9/TzeNWz1zAXjmBM6zsJFhkFbNKXGkW5efD2H9tnX0rfU9QGw7J1iU3pIW1Lb
	 A+ElBupykRbTg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 3/6] ata: libata-scsi: improve service action support
 in ata_scsi_report_supported_opcodes()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Damien Le Moal" <dlemoal@kernel.org>
Cc: dlemoal@kernel.org, linux-ide@vger.kernel.org, cassel@kernel.org
In-Reply-To: <20260702015646.1702539-4-dlemoal@kernel.org>
References: <20260702015646.1702539-1-dlemoal@kernel.org>
 <20260702015646.1702539-4-dlemoal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 02:11:30 +0000
Message-Id: <20260702021131.12F101F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] ata_scsi_supported_cmd_has_sa() and ata_supported_cmds incorrect=
ly handle service actions of value 0, breaking REPORT SUPPORTED OPERATION C=
ODES.
--

commit 976ae28e21b5ac80b95af84b459ff3561417568d
Author: Damien Le Moal <dlemoal@kernel.org>

ata: libata-scsi: improve service action support in ata_scsi_report_support=
ed_opcodes()

This commit updates ata_scsi_report_supported_opcodes() to take service act=
ions
into consideration. It adds ata_scsi_supported_cmd_has_sa() to check if an
opcode has service actions and uses both opcode and service action to look =
up
supported commands.

> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index 380ca3886a777..e432e521ad318 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
[ ... ]
> @@ -3641,32 +3641,46 @@ static const struct ata_scsi_cmd ata_supported_cm=
ds[] =3D {
>  	{ ZBC_OUT,		16,	ZO_RESET_WRITE_POINTER },
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
Does this strict service action matching cause issues for VARIABLE_LENGTH_C=
MD?

Looking at the ata_supported_cmds array, VARIABLE_LENGTH_CMD uses service
actions (e.g., ATA_32 =3D 0x1FF0) but is mapped with sa =3D 0. Will this ca=
use the
matching here to fail for valid service actions under reporting option 3?

>  			return cmd;
>  	}
> =20
>  	return NULL;
>  }
> =20
> +static bool ata_scsi_supported_cmd_has_sa(u8 op)
> +{
> +	const struct ata_scsi_cmd *cmd;
> +	int i;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(ata_supported_cmds); i++) {
> +		cmd =3D &ata_supported_cmds[i];
> +		if (cmd->op =3D=3D op)
> +			return cmd->sa !=3D 0;

[Severity: Medium]
Will this incorrectly handle service actions with a value of 0?

Because 0 is a valid service action (e.g., ZBC_IN uses ZI_REPORT_ZONES =3D =
0),
this condition will incorrectly cause ata_scsi_supported_cmd_has_sa() to
return false for ZBC_IN.

> +	}
> +
> +	return false;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702015646.1702=
539-1-dlemoal@kernel.org?part=3D3
