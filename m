Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B1B30E85B
	for <linux-ide@vger.kernel.org>; Fri,  3 Jul 2026 04:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783052892; cv=none; b=Ot3L6SLih1NfjaEN95IrRgyQfyTeU819An9RTwVirTc1gnltV+1hYzuy/GE5qbZtmyWwrlHzouerkQVWeg2OoxJwGTasc9/McEgt0zpUcTVeu5pcQ8R+4pu2Bx4pMyVIZbKv15jgx2hWD5KtdOFLXGD0fuq/WSYO2H4mjFzh9bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783052892; c=relaxed/simple;
	bh=f7ON5ZwOs6WrexZEwSLjw2fC4Bdtd/PvRvjKHtW4idw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=s4l3Gajk50RkxOil/jWSeQKxme4N468WbNUzPujPNWGy/itEPs1uPhF/vjACvh/F04/PwP2yqNaOZxFx3bLtAwK7a9h6c8aQ8pSE4ZjtcLGmASFzqT/zKy1HQ6oyXZIzxnoU6MC2zg+h9MCl9JsrnOazS/KegMkz0mObfmYjx/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IMXZcVqK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IMXZcVqK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FC8D1F000E9;
	Fri,  3 Jul 2026 04:27:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783052877;
	bh=7Ln04DmHTomRLytSVVLStxpolxz9kb45S97HqOEcKFM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IMXZcVqKh1beTS5CVFSdU2ny+s3c/t4A6FWOxuWs0jb9tHR7SMpGaD/hYFg9X8/uM
	 1qD3XZ88QaLgOpLy1pwTAIJO9iahrOiHDcBTdBLHbt64TCzXwurx3QCx/lC+nUkddK
	 pL6exxZ/8zwpaQptF15SHbvfQcBcxyVRzDW459XegLihOAXWav5F/7pBvr4p7uN7Ar
	 40cLhLjxTHkLdtKgL8qYtwFf23k5T1yIdR1VTLr4I1tEKOLM7afxnjksQb0Hg8BOnC
	 InXH87hVz4Z74wrgGUbqDR34Vam+YKkN7oBIecB3t9ie3ZiTWQfdNmjDhdrMmovrMC
	 fotBcz2jWQMoA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/5] ata: libata-scsi: support reporting options 2 in
 REPORT SUPPORTED OPERATION CODES
Reply-To: sashiko-reviews@lists.linux.dev
To: "Damien Le Moal" <dlemoal@kernel.org>
Cc: dlemoal@kernel.org, cassel@kernel.org, linux-ide@vger.kernel.org
In-Reply-To: <20260703040532.2152614-5-dlemoal@kernel.org>
References: <20260703040532.2152614-1-dlemoal@kernel.org>
 <20260703040532.2152614-5-dlemoal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 03 Jul 2026 04:27:56 +0000
Message-Id: <20260703042757.2FC8D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Reporting Option 3 fails to ignore the REQUESTED SERVICE ACTION =
field for commands that do not have service actions, causing supported comm=
ands to be reported as unsupported.
--

commit dc113e618a2abb6f7c7b971f3095bb3e3f08a158
Author: Damien Le Moal <dlemoal@kernel.org>

ata: libata-scsi: support reporting options 2 in REPORT SUPPORTED OPERATION=
 CODES

Add support for the reporting options value 2 of the in REPORT SUPPORTED
OPERATION CODES command in ata_scsi_report_supported_opcodes(). With this
reporting option, the specified opcode to check must have a service
action. Use ata_scsi_supported_cmd_has_sa() to check for this and fill the
command reply buffer using the one command format based on the command
support.

> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index 4d4cdf3047405..5dd76579327e9 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
> @@ -3774,6 +3774,13 @@ static unsigned int ata_scsi_report_supported_opco=
des(struct ata_device *dev,
>  			return 0;
>  		}
>  		break;
> +	case 2:
> +		/* One command format, must have sa. */
> +		if (!ata_scsi_supported_cmd_use_sa(cdb[3])) {
> +			ata_scsi_set_invalid_field(dev, cmd, 3, 0xff);
> +			return 0;
> +		}
> +		fallthrough;
>  	case 3:
>  		/* One command format */
>  		sa =3D get_unaligned_be16(&cdb[4]);

[Severity: Medium]
Does this code incorrectly fail to ignore the REQUESTED SERVICE ACTION field
for commands without service actions under Option 3?

If a legitimate SCSI query uses Option 3 with a non-zero service action fie=
ld
for a command that does not use service actions, this block extracts the
non-zero sa value from the CDB.

Later in ata_scsi_get_supported_cmd(), the code enforces a strict match:

	for (i =3D 0; i < ARRAY_SIZE(ata_supported_cmds); i++) {
		cmd =3D &ata_supported_cmds[i];
		if (cmd->op =3D=3D op && cmd->sa =3D=3D sa)
			return cmd;
	}

Because cmd->sa is 0 for commands without service actions, this strict match
will fail. Will this cause valid commands (like READ_10) to be incorrectly
reported as unsupported?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260703040532.2152=
614-1-dlemoal@kernel.org?part=3D4
