Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E173890F1
	for <linux-ide@vger.kernel.org>; Thu,  2 Jul 2026 06:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782975149; cv=none; b=HdSBPPigm8YYWEsuFQ821Spk+/tk7hvFv/X/TasuHVeVmk5ovOzw4B+J2MhNqJYxyN49QoIDhc6iiXWSM8QZr5SO84aLvojZHSTLDGZoHRCGmfBKENUbg0E+ejINOQI2nLgB6sJDl2fdImUoyZNZVCIE8pRnuoUSUdwPrf5sZxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782975149; c=relaxed/simple;
	bh=atFmopGAXBOod0ub1mtl0qFLMcphYubHWcgRxEsSTew=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EIkJEfuoOK7dzJ52uwwS8rW3iLTe99uGIYj/gBc7UKI80LvexA/afEB/vi7n6LH2lbntJCVs4pH8Leq/LKgvTuWmbypH6ozFFsGF4sWdE0IVUruxdLzmD42N5kWlBuq9GxanIdIsUVfcoVkA2mw3aH/DrHUIdUHz+XVOtAqzuk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mUQ0SiI+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mUQ0SiI+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA8671F000E9;
	Thu,  2 Jul 2026 06:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782975148;
	bh=Pd5Iqlvl2h+pE6af7PyIfG8vpLeeTK2YEpi/fJ2iL60=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mUQ0SiI+aMpv/RzX5yKBfzpSCajGYtvgTq7DmKgbEpVtXcdzHoyCV6tGB4HBxSvQi
	 xOg7BH6fYxrK3Q/tbReyAPlbRQgXVEQ1PJHsbhKafca7EVtNYKtTfPP4XmQ4ZBzEnX
	 x05rdShue4gAg+bragYaStD0QA3LG0oKkKCC5XBLHiPWfY/8zAMtQO2njkkMmEu06h
	 lR0mS3fMBeAuGKefVdIUEtuU8jv8NaekrFbD3poBIqBiOFbslh88c3kq6AvitVBbOa
	 pcpOlscRNp+vx7yyEYEQipN/DwBCFkgltKrUj8VdpJCYL/o762EjGwIyPbFVt5xjx8
	 fOyzzBQHo3Ilw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/5] ata: libata-scsi: support reporting options 2 in
 REPORT SUPPORTED OPERATION CODES
Reply-To: sashiko-reviews@lists.linux.dev
To: "Damien Le Moal" <dlemoal@kernel.org>
Cc: dlemoal@kernel.org, cassel@kernel.org, linux-ide@vger.kernel.org
In-Reply-To: <20260702063412.1892584-5-dlemoal@kernel.org>
References: <20260702063412.1892584-1-dlemoal@kernel.org>
 <20260702063412.1892584-5-dlemoal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 06:52:27 +0000
Message-Id: <20260702065227.EA8671F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Reporting options 1 and 2 incorrectly terminate with CHECK CONDI=
TION (INVALID FIELD IN CDB) for valid queries, violating SCSI protocol.
- [Medium] Reporting option 3 incorrectly evaluates the REQUESTED SERVICE A=
CTION field for commands that do not use service actions.
--

commit 8b0fcbdec2fbb5690930a99f6f8a7faf9e8bd511
Author: Damien Le Moal <dlemoal@kernel.org>

ata: libata-scsi: support reporting options 2 in REPORT SUPPORTED OPERATION=
 CODES
   =20
Add support for the reporting options value 2 of the in REPORT SUPPORTED
OPERATION CODES command in ata_scsi_report_supported_opcodes(). With this
reporting option, the specified opcode to check must have a service
action. Use ata_scsi_supported_cmd_has_sa() to check for this and fill the
command reply buffer using the one command format based on the command
support.

> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index 86ac41a7d81ab..e75ed573e234b 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
> @@ -3737,6 +3737,13 @@ static unsigned int ata_scsi_report_supported_opco=
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

[Severity: Medium]
Does this validation check incorrectly abort execution with a SCSI error for
option 2 commands that are unknown?

According to SPC-5, option 2 queries for unsupported commands (and similarl=
y,
option 1 queries for commands with service actions) must return SUPPORT=3D0=
01b.
Instead, this implementation erroneously aborts the command by calling
ata_scsi_set_invalid_field(), preventing the code from falling through and
correctly populating the response buffer.

> +		fallthrough;
>  	case 3:
>  		/* One command format */
>  		sa =3D get_unaligned_be16(&cdb[4]);

[Severity: Medium]
If an initiator issues REPORT SUPPORTED OPERATION CODES with option 3 for a
standard command that lacks service actions, while providing non-zero data =
in
the requested service action field, wouldn't this unconditional extraction =
of
sa cause a regression?

SPC-5 dictates that if the requested opcode does not have service actions, =
the
requested service action field must be ignored. By unconditionally extracti=
ng
sa here, it will fail to match in ata_scsi_get_supported_cmd() since
non-service-action commands expect sa =3D=3D 0, improperly yielding SUPPORT=
=3D001b
for a valid, supported command.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702063412.1892=
584-1-dlemoal@kernel.org?part=3D4
