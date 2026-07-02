Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5FC41EFFA1
	for <linux-ide@vger.kernel.org>; Thu,  2 Jul 2026 06:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782975202; cv=none; b=ub0rKgz7tUHtoVXhHAe26cqPXEbpVJpD2xCPX5VXGx9gfc9/FK/CAT05MiJ8t1NAmFVoPBEfI+sEg9B/J0gdL7yOHirhK9GsCQ4itKn48smLHmYPp3125ExfScIONgqqjglTWX558GtgFxW7a6oK9iSt/9Sx6hOExNlUwd46Dqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782975202; c=relaxed/simple;
	bh=WStDPmCTV/3m9W/UkwiTO0hLktLYzl2m2PWoCM8hobs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MkhUCXkle/BMBGyZKNlKC7p26kOKqyu/d8bG/5gUm4nlPv3njwN6DpVlt9CCTRe7rmrndkCt2ni9jdRfMoQFVs6Yc9z7d8gcclPh8T2mMB/XuyjTXrUMpdsmBTkQ5QYi968HyYZ1pCddFjY97lj4yZlTLfsrvt9dhrM+Ysb3ClI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GGS3f4XJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GGS3f4XJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07EB51F000E9;
	Thu,  2 Jul 2026 06:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782975201;
	bh=E0wc+emHcarlDN8k3GKSIcUZ48py2K8us1DK+9qHzQg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GGS3f4XJtbOZUfh08pXxQZBYCH9XVpkE2ya9hgr9ZmivWeawjr7lN+pi8q8ZT3AKh
	 iNrwd1SX7EPSAiTH8H5p5QmwVzkVRVu4BALQfn5hn3pcbFXfHqMOD9/Kfes7fEMn3x
	 mvgKs/5EZg/2wkO9sYmEyZ4QCDT/c/gyS5+wF5b0nxjXkgvqg/yvEqvKqxzRMEZmWi
	 ZRUPv/ZOOugVrQoDGJE7j1c31Q7gb6DM8RUhXXDHK0JlIt1i7/6c/ZUgTw5tbvMBR4
	 iafRO6EIUra56MOL9wy3KVf7GAfFEdJc5S1AvJprADqjyO4lsqbr+w8OSmumGvNraE
	 sOQt91gqOzOMg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/5] ata: libata-scsi: refactor
 ata_scsi_report_supported_opcodes()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Damien Le Moal" <dlemoal@kernel.org>
Cc: dlemoal@kernel.org, linux-ide@vger.kernel.org, cassel@kernel.org
In-Reply-To: <20260702063412.1892584-3-dlemoal@kernel.org>
References: <20260702063412.1892584-1-dlemoal@kernel.org>
 <20260702063412.1892584-3-dlemoal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 06:53:20 +0000
Message-Id: <20260702065321.07EB51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] WRITE_SAME_16 is unconditionally reported as supported via REPOR=
T SUPPORTED OPERATION CODES, even for devices that do not support TRIM.
--

commit b8e6e9f4e6e3177fe0e766704af6b504468c2de3
Author: Damien Le Moal <dlemoal@kernel.org>

ata: libata-scsi: refactor ata_scsi_report_supported_opcodes()

This commit refactors ata_scsi_report_supported_opcodes() to use an array
of supported commands for easier modifications and extensions. It also adds
handling for WRITE_SAME_16 and VARIABLE_LENGTH_CMD to the list of commands
which libata-scsi translates.

> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index 8811bfc373697..4f0ae44f59dd2 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
[ ... ]
> +static bool ata_scsi_cmd_is_supported(struct ata_device *dev, u8 op,
> +				      struct ata_scsi_cmd_support *sup)
> +{
> +	const struct ata_scsi_cmd *cmd;
> +
> +	/* First, see if we support the command. */
> +	cmd =3D ata_scsi_get_supported_cmd(op);
> +	if (!cmd)
> +		return false;
> +
> +	/* Now refine the support report depending on the device features. */
> +	memset(sup, 0, sizeof(*sup));
> +	switch (op) {
> +	case READ_16:
[ ... ]
> +	case ZBC_IN:
> +	case ZBC_OUT:
> +		return ata_dev_is_zoned(dev);
> +	case SECURITY_PROTOCOL_IN:
> +	case SECURITY_PROTOCOL_OUT:
> +		return dev->flags & ATA_DFLAG_TRUSTED;
> +	default:
> +		break;
> +	}
> +
> +	return true;
> +}

[Severity: Medium]
Should WRITE_SAME_16 be refined here to check for TRIM support?

The commit message mentions adding WRITE_SAME_16 to the supported array,
so it falls through to the default case in this switch statement and
unconditionally returns true.

However, looking at ata_scsi_write_same_xlat(), the command is unconditiona=
lly
rejected if the device lacks TRIM capabilities:

ata_scsi_write_same_xlat()
    ...
    if (!unmap || (dev->quirks & ATA_QUIRK_NOTRIM) ||
        !ata_id_has_trim(dev->id)) {
        fp =3D 1;
        bp =3D 3;
        goto invalid_fld;
    }

Does this cause the report supported operation codes query to incorrectly
inform the SCSI layer that WRITE_SAME_16 is supported on ATA devices that
do not actually support TRIM?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702063412.1892=
584-1-dlemoal@kernel.org?part=3D2
