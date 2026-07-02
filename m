Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE287081A
	for <linux-ide@vger.kernel.org>; Thu,  2 Jul 2026 02:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782958406; cv=none; b=J+/dlhdJNwfNLhDrfSoojkQwoeYoTP7EuPgFfkT0C0JJmgOZBdYdBXl+jyf29VSM05wS/IKws8TTV6fIsBr/vOo8wHZQh+sKFIzGbk/lyTKvpqyF27+dcnsYEoH2PNRt4lHF5UirE6JWj5eNrMKHtS07es6EH5I56PrPgqrn2MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782958406; c=relaxed/simple;
	bh=NNoa3c1YRv7SuF9SlDe7+NhA/SnLBrEIZx9ymcU8I08=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=alxB/RlzuELNM+a8URRycaLdBSbCLZpF1xCJFeBHy6PaWlgQ6xstwYQX1gbNBm2azvHvrz3qoNDq2FuReLLG/H3iEy84eac1hEEsLPEoQwaZevunFw7cF4GZUh8HKzkor+9sgu46S/iamuUImaPxRhL3OWpqo6kG9c2fDgbxI50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hAskJ3YA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hAskJ3YA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3872A1F000E9;
	Thu,  2 Jul 2026 02:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782958405;
	bh=YhF1Ms7/+EuWHmPDO1g4Gz4smNp/mmv5vOmt1YOwps8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hAskJ3YAdrcmETaw0+VttxF9aO7GsKTqAvslITMBmrpLAH7JDkOiVc+PNUD1JhpRr
	 lQO2W2IpKPiE1p+2FkzJ6+qR9+5ROZnTqe13KEbloBo1dEP2JPDCYI73vgnmkGmo89
	 oP8/mNvLWeHAyky296E1HFDrzqod8Vlaf8qilVH/pUVmpwKDdGUVGxQWCfurnYzXF7
	 GMUOMOV/o+ooU5yrL1fDLSuKJUAsh3IkAp5XBVCSxn9CNx1Z/uY5aFdoI1MAKIX5iH
	 EY+NFuKwgDk611eNewGTnquHar5DApaFHNkKCiZ/kYXmbP5pLG2sq09aFrHxXLN2xQ
	 203irZYAo20XA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 5/6] ata: libata-scsi: support reporting options 2 in
 REPORT SUPPORTED OPERATION CODES
Reply-To: sashiko-reviews@lists.linux.dev
To: "Damien Le Moal" <dlemoal@kernel.org>
Cc: cassel@kernel.org, dlemoal@kernel.org, linux-ide@vger.kernel.org
In-Reply-To: <20260702015646.1702539-6-dlemoal@kernel.org>
References: <20260702015646.1702539-1-dlemoal@kernel.org>
 <20260702015646.1702539-6-dlemoal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 02:13:24 +0000
Message-Id: <20260702021325.3872A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The helper `ata_scsi_supported_cmd_has_sa()` incorrectly assumes t=
hat a command with `sa =3D=3D 0` does not take service actions, causing Rep=
orting Option 2 to reject valid queries for commands like `ZBC_IN`.
- [High] Reporting Option 3 incorrectly fails to ignore the REQUESTED SERVI=
CE ACTION field for commands without service actions.
--

commit ae74931c866547ba834a0558a06a2d04d82842f2
Author: Damien Le Moal <dlemoal@kernel.org>
ata: libata-scsi: support reporting options 2 in REPORT SUPPORTED OPERATION=
 CODES

This commit adds support for the reporting options value 2 of the REPORT
SUPPORTED OPERATION CODES command in ata_scsi_report_supported_opcodes().
It verifies that the opcode to check has a service action using the new
ata_scsi_supported_cmd_has_sa() helper. If supported, it replies using the
one command format based on the command support.

> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index d54ec1631e9a6..3f313050c63f3 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c

[ ... ]

> +static bool ata_scsi_supported_cmd_has_sa(u8 op)
> +{
> +	const struct ata_scsi_cmd *cmd;
> +	int i;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(ata_supported_cmds); i++) {
> +		cmd =3D &ata_supported_cmds[i];
> +		if (cmd->op =3D=3D op)
> +			return cmd->sa !=3D 0;

[Severity: High]
Does this incorrectly assume that commands with a service action of 0 don't
have a service action at all?=20

For example, ZBC_IN has op =3D=3D 0x53 and its service action ZI_REPORT_ZON=
ES
is 0x00. This helper will return false for ZBC_IN.

> +	}
> +
> +	return false;
> +}

[ ... ]

> +static unsigned int ata_scsi_report_supported_opcodes(struct ata_device =
*dev,
> +						      struct scsi_cmnd *cmd,
> +						      u8 *rbuf)
> +{
> +	struct ata_scsi_cmd_support sup;
> +	u8 *cdb =3D cmd->cmnd;
> +	u16 sa =3D 0;
> +
> +	switch (cdb[2]) {
> +	case 1:
> +		/* One command format with command support data, ignore sa. */
> +		if (ata_scsi_supported_cmd_has_sa(cdb[3])) {
> +			ata_scsi_set_invalid_field(dev, cmd, 3, 0xff);
> +			return 0;
> +		}
> +		break;
> +	case 2:
> +		/* One command format, must have sa. */
> +		if (!ata_scsi_supported_cmd_has_sa(cdb[3])) {
> +			ata_scsi_set_invalid_field(dev, cmd, 3, 0xff);
> +			return 0;
> +		}

[Severity: High]
Because of the logic in ata_scsi_supported_cmd_has_sa(), if a host issues a
REPORT SUPPORTED OPERATION CODES command with Option 2 and CDB[3] =3D ZBC_I=
N,
won't this actively reject a valid zone capabilities query with an Invalid
Field in CDB error?

> +		fallthrough;
> +	case 3:
> +		/* One command format */
> +		sa =3D get_unaligned_be16(&cdb[4]);

[Severity: High]
When processing Reporting Option 3, is it safe to unconditionally extract t=
he
requested service action without verifying if the command actually takes
service actions?

The SPC specification requires ignoring this field for commands that do not
take service actions. If a host sends an Option 3 query for a command like
READ_16 and leaves uninitialized non-zero data in the ignored service action
field, the exact match lookup in ata_scsi_get_supported_cmd() will fail and
incorrectly report the command as unsupported.

> +		break;
> +	default:
> +		ata_dev_warn(dev, "invalid command format %d\n", cdb[2]);
> +		ata_scsi_set_invalid_field(dev, cmd, 2, 0xff);
> +		return 0;
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702015646.1702=
539-1-dlemoal@kernel.org?part=3D5
