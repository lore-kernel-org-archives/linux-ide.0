Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 593AF533D6
	for <linux-ide@vger.kernel.org>; Thu,  2 Jul 2026 02:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782958298; cv=none; b=Ed3WGiDgwmP8SHpUELa9exbh6lWBbuNwkMvEOIHPS0JQQKLU6HRxnzMOKA2spdZt5uyf1Y973DzqScdSjntt0awunjMruuvDpnO8zto/XQEjpHGnNfBYMNQ8gPaTWKgEcWNJbRGeHdrW4JXNFFkazMHgbSxNJqnroEJuzzqxaf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782958298; c=relaxed/simple;
	bh=RhMNlpCrObgtaAM7xa0L8KyRfzDQV1j8580HmUcPKFs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VEm05z6Cpl3YvBvXO0cBngbfQp8LGqlpmqi+HEmny+ZgPIm+ACC+ujeqPQ54AQ5CAUBgWBSbg0igwllzkINNMJNr4FfBKrSe+tdmctzFtfXFRFmVtaIwiNSA345HEJVa1tQxwK0rLKEquvFKZKDt1UQsO38F9pF4Qr2AWE5pli4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UeqGD0UX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UeqGD0UX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFDE91F000E9;
	Thu,  2 Jul 2026 02:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782958297;
	bh=XelOkmbc3xL2R2h/u50JrEfVW0nwusABi4XFloksYBY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UeqGD0UXD3MCyaRYQFu08LLujIWrnv7DE4gaw4KVlo3heHUvun93gxUtfu1dSJBxp
	 MBB9WE8c8yH03BvgnkjDv2kH6gpIM2OVOhA7r4YueedgXivY8BvXoHyHs2CpWZE9er
	 WlArNOFUpN0IP/pJ0y/kjRtEF2UF4CFE4uaKDjPrb78VDzpcydf9x6XEhhy21+8rvl
	 UIwUdCax8d6bO7NPxI0SjvDfaObPkt1WZlBmBRXbfR1LmDroucLHvVqzbhiob8BOxR
	 IHHWzOdnaQfEEe7KSIjol1x6YjdtGTwUErpx2D2YulBxztuuMGGWv09vQ9UqDa0eKG
	 urLOf45DFHgwQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 6/6] ata: libata-scsi: support the all command format
 for reporting supported commands
Reply-To: sashiko-reviews@lists.linux.dev
To: "Damien Le Moal" <dlemoal@kernel.org>
Cc: cassel@kernel.org, linux-ide@vger.kernel.org, dlemoal@kernel.org
In-Reply-To: <20260702015646.1702539-7-dlemoal@kernel.org>
References: <20260702015646.1702539-1-dlemoal@kernel.org>
 <20260702015646.1702539-7-dlemoal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 02:11:36 +0000
Message-Id: <20260702021136.EFDE91F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Incorrect bit-shifting and field conflation for the CDLP and RWCDL=
P fields corrupts Command Duration Limits (CDL) reporting.
- [Medium] ZBC_IN and VARIABLE_LENGTH_CMD are incorrectly reported as lacki=
ng service actions in the All Commands format.
--

commit f7b18a5d6dd37eabc2de02696bfa0461178f0b87
Author: Damien Le Moal <dlemoal@kernel.org>

ata: libata-scsi: support the all command format for reporting supported co=
mmands

This commit introduces support for the "All Commands" format (reporting opt=
ion 0)
in ata_scsi_report_supported_opcodes(). It adds ata_scsi_report_all_support=
ed_opcodes()
to iterate through ata_supported_cmds and report supported operations.

> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index 3f313050c63f3..30e2cf3b03dc7 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
> @@ -3731,6 +3731,42 @@ static bool ata_scsi_cmd_is_supported(struct ata_d=
evice *dev, u8 op, u16 sa,
[ ... ]
> +static unsigned int
> +ata_scsi_report_all_supported_opcodes(struct ata_device *dev, u8 *rbuf)
> +{
[ ... ]
> +		/* All command format */
> +		if (!ata_scsi_cmd_is_supported(dev, cmd->op, cmd->sa, &sup))
> +			continue;
> +
> +		buf[0] =3D cmd->op;
> +		put_unaligned_be16(cmd->sa, &buf[2]);
> +		buf[5] |=3D (sup.rwcdlp << 6) | (sup.cdlp << 2);

[Severity: High]
Does this code correctly shift and map the CDLP and RWCDLP fields?

It looks like sup.rwcdlp is a 1-bit boolean flag (0 for A/B, 1 for T2A/T2B)
used in the One Command format, not the 2-bit RWCDLP enum (01b=3DRead, 10b=
=3DWrite)
required for the All Commands format. Shifting 1 by 6 sets bit 6, resulting=
 in
10b, which would incorrectly report READ_16 as a Write command.

Additionally, the CDLP field is defined at bits 4-3, but sup.cdlp is shifted
by 2, placing it at bits 3-2. For WRITE_16 (sup.cdlp=3D2), shifting by 2 re=
sults
in setting bit 3, which falls into the CDLP field as 01b instead of 10b.

> +		if (cmd->sa)
> +			buf[5] |=3D 0x01;

[Severity: Medium]
Will this correctly set the SERVACTV bit for all commands that require serv=
ice
actions?

Commands like ZBC_IN (0x95) and VARIABLE_LENGTH_CMD (0x7F) have their servi=
ce
action explicitly defined as 0x00 in ata_supported_cmds. Since cmd->sa eval=
uates
to 0, the SERVACTV bit won't be set. This incorrectly tells the host that t=
hese
commands do not use the SERVICE ACTION field.

> +		put_unaligned_be16(cmd->cdb_len, &buf[6]);
> +
> +		/* CTDP =3D=3D 0 */
> +		len +=3D 8;
> +		buf +=3D 8;
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702015646.1702=
539-1-dlemoal@kernel.org?part=3D6
