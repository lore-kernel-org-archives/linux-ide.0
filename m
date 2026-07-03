Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D908839E6F8
	for <linux-ide@vger.kernel.org>; Fri,  3 Jul 2026 09:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783069526; cv=none; b=mh0w6CapIjuVntAIFwTU7/t8DUzfNr7mx/AWRf9IAmzZ15R5kYz7ECeW1YJyjn6QJBgv5PAbYp4gZ+DTrggCTP4SiznbpSggQD6V0V/7bfLeUmnTlxMT84DB1J+OudmMTQqo0mERSLfNH6SFSPBTDPdZTBLrodYjogpjOdZkV6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783069526; c=relaxed/simple;
	bh=NWW8NDz+SIb7kFwjSbff8icIRqgpRbwSX36wJwSNnxY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RhbivaZUyZSKozsNmACeJPtaSukz3WRdYuJvEr+cg+fqA32S3ylrk0uTdJQTR6zM4Rl57k8nuD/91nOQiC0ZIT31SRIL1GCOVy9GUlx+HVwJ4J2WFetf09wOWiIgH81cYqBqMa/T3KaU5+vN4Gleo5eGlFEpakTIDlrHGPApS10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=amqrU2Xa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="amqrU2Xa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77B941F000E9;
	Fri,  3 Jul 2026 09:05:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783069524;
	bh=fSl9loVi6BMV7NOqpFLpikUlbLt3H3SbFnM+4QD9HKM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=amqrU2XaqqlbxHru/LCaZ61+WQwx9jYrxb0z7Msr1acFrgUbx69wVRL8kGBMyNtZi
	 rapB/bXJfRfkxDulgsa2i7bDLCo4JRp2UKZUY5qRMnXWLWDlrZCwkfhhmzerGDyeLt
	 1A2V4yeHZ3p+8xdB9Bh5xKjI0G/5pNI/adze73S46Cx897imrT+DGwNaJlA1CUYY6u
	 XlOHf4k3VYYUVVyEhLFoZ2tl26f3iqImtE6BaQCArRt59uDVre8Sn9sxoBlbPTVEQb
	 rZ8xmA7x8ID3tHx+XCWhznC6556rXf4GhwdV6WJErViXD16L+Bsi6mrIlxkSNGZLj1
	 D1Dr24YvN41Sw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 4/5] ata: libata-scsi: support reporting options 2 in
 REPORT SUPPORTED OPERATION CODES
Reply-To: sashiko-reviews@lists.linux.dev
To: "Damien Le Moal" <dlemoal@kernel.org>
Cc: dlemoal@kernel.org, cassel@kernel.org, linux-ide@vger.kernel.org
In-Reply-To: <20260703085152.2350034-5-dlemoal@kernel.org>
References: <20260703085152.2350034-1-dlemoal@kernel.org>
 <20260703085152.2350034-5-dlemoal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 03 Jul 2026 09:05:23 +0000
Message-Id: <20260703090524.77B941F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Reporting option 3 fails to ignore the REQUESTED SERVICE ACTION =
field for commands that do not have service actions.
- [Medium] Validation for reporting options 1 and 2 incorrectly handles uns=
upported commands by conflating 'unsupported' with 'no service action'.
--

commit f779ad68951058a9ef94049680f8a5d3f0d0be1e
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
> index dca46e7779b64..157a4b6979a89 100644
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

[Severity: Medium]
Does ata_scsi_supported_cmd_use_sa() accurately distinguish between an
unsupported command and a command that lacks a service action?

If a host queries an unsupported command that architecturally does have
a service action (such as opcode 0x5e), it appears the helper would return
false because the command is simply not in the supported list.

For option 2, this causes the command to incorrectly fail with a check
condition (invalid field in cdb) instead of gracefully returning 'Not
supported' in the data phase.

> +			ata_scsi_set_invalid_field(dev, cmd, 3, 0xff);
> +			return 0;
> +		}
> +		fallthrough;
>  	case 3:
>  		/* One command format */
>  		sa =3D get_unaligned_be16(&cdb[4]);

[Severity: Medium]
Will this unconditionally read and use the service action field for
reporting option 3 even when the command doesn't have a service action?

According to the specification, the requested service action field should
be ignored for commands without service actions. If a host provides a
non-zero garbage value in this field for a command without a service action,
passing this value into ata_scsi_cmd_is_supported() might cause the lookup
to fail and incorrectly report the command as unsupported.

>  		break;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260703085152.2350=
034-1-dlemoal@kernel.org?part=3D4
