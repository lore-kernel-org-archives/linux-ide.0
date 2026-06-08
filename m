Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E715330C157
	for <linux-ide@vger.kernel.org>; Mon,  8 Jun 2026 22:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780956799; cv=none; b=a099TeAr3zzQ5GwDNROWZ5qHQtcWbLlIIwXAa69rstOTisJx3ZW/9y1Nk2D6rRRe7SlLIdIijAuXpKZLoE7zIeyBGX5D88tBP6K4QjB1UFgaRN3xOxytVS2RYerDxdw9+yCEURd1dcKf5Ds+wBK4aMMa6jQJMcidyNXru4tzUmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780956799; c=relaxed/simple;
	bh=PvsOcSQ8PA1qTv/5MOwsBS23J7y3He9wwxGWx07A1N4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lUUlcU3+4pzcAD3lr4IMwN88fraQM+cj3ZhmvOdROMukT8j/qt7vEJNSi7ey6N4yjIoSV+FcW7tmMiM9Nl+FIOyyLIGtQHXEFxbfILDswLM9Def5Nmc04bkwSUb2nHTGc4NxfjUfaZIUH0GphKTpJm+zffvLgs5ah1XWr2w3aT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fhvd3x80; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fhvd3x80"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C5F11F00893;
	Mon,  8 Jun 2026 22:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780956797;
	bh=f0IxgdYlZ+R7rIcCags0BawOzF9adNTLp9tXViC8tpw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Fhvd3x80HuGQSDP3Tp48LKyqeLh94xNx0xpWKdSHIrmcHPej8/w00wG5ZguXb+4kh
	 mjSgML4SvDtuc3jfFdtcoBAm9JRVMfT0jW2WnQlWcY0ulz5lTtMBhziK481/fYdesP
	 QKibb3lKT/2wTmMwQPs+9IaPU7X+UMj75hyTWUP+ddkoplXP6F9lIVy9Q0MFbu+/EA
	 I9b5tDvbtEyYWs235HnpnGDkgi64wqnlTsCCzYHpWZixM0/Pgl4kqk6U2m6bvaW87U
	 zC3OJOuvyjXnvU2KRWdBYK5Y8ywXMf3SoVOzon6KBiCxVkXIlfMnHBEKfTrb04+3XW
	 j0WGx1NxHg1TA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 3/6] ata: libata-scsi: route non-zero LUN commands
 for multi-LUN ATAPI
Reply-To: sashiko-reviews@lists.linux.dev
To: "Phil Pemberton" <philpem@philpem.me.uk>
Cc: dlemoal@kernel.org, linux-ide@vger.kernel.org, cassel@kernel.org
In-Reply-To: <20260608213443.2296614-4-philpem@philpem.me.uk>
References: <20260608213443.2296614-4-philpem@philpem.me.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 22:13:17 +0000
Message-Id: <20260608221317.9C5F11F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Returning AC_ERR_INVALID without setting scmd->result causes the S=
CSI layer to treat the aborted command as a success.
- [High] Unconditional modification of CDB byte 1 clears parameter bits for=
 valid MMC and SCSI commands, corrupting them.
- [Medium] The __ata_scsi_find_dev() function accepts non-zero LUNs for all=
 ATAPI devices, leading to WARN_ON_ONCE triggers and phantom devices during=
 manual SCSI scans.
--

commit 23cd1ea8143d086cbe9cf8a4825c18b4ede2d943
Author: Phil Pemberton <philpem@philpem.me.uk>

ata: libata-scsi: route non-zero LUN commands for multi-LUN ATAPI

This patch updates libata-scsi to route commands to non-zero LUNs for ATAPI
devices. It modifies __ata_scsi_find_dev() to allow non-zero LUNs for ATAPI
devices and updates atapi_xlat() to encode the LUN into bits 7:5 of CDB byt=
e 1.

> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index 7c3d31dc49a17..2d714efc855f0 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
> @@ -2953,6 +2953,15 @@ static unsigned int atapi_xlat(struct ata_queued_c=
md *qc)
>  	memset(qc->cdb, 0, dev->cdb_len);
>  	memcpy(qc->cdb, scmd->cmnd, scmd->cmd_len);
> =20
> +	/*
> +	 * SCSI-2 CDB LUN encoding: bits 7:5 of byte 1 (3-bit field).
> +	 * The SCSI layer caps the LUN at shost->max_lun (<=3D ATAPI_MAX_LUN),
> +	 * so this should never trip; warn and reject if it does.
> +	 */
> +	if (WARN_ON_ONCE(scmd->device->lun >=3D dev->nr_luns))
> +		return AC_ERR_INVALID;

[Severity: High]
Does returning AC_ERR_INVALID here without setting scmd->result cause the
SCSI layer to treat the aborted command as a success?

The caller, ata_scsi_translate(), drops the command and calls scsi_done(cmd)
when xlat_func returns an error, but it doesn't set cmd->result to an error
status:

drivers/ata/libata-scsi.c:ata_scsi_translate() {
    ...
done:
    ata_qc_free(qc);
    scsi_done(cmd);
    return 0;
}

Since scmd->result defaults to SAM_STAT_GOOD (0), the SCSI midlayer will
believe the command succeeded.

This can cause the INQUIRY command to succeed, resulting in phantom LUNs.
For write operations, it can cause silent data corruption as the data is
dropped but reported as successfully written.

> +	qc->cdb[1] =3D (qc->cdb[1] & 0x1f) | ((u8)scmd->device->lun << 5);

[Severity: High]
Does this unconditionally overwrite CDB byte 1 and corrupt parameter bits f=
or
valid MMC and SCSI commands?

Some modern SCSI commands use bits 7:5 of byte 1 for actual parameters, such
as RDPROTECT in READ (16) and WRITE (16), or MULTIPLE_COUNT in ATA
PASS-THROUGH (16).

If this overwrites those bits, the parameters will be silently corrupted. Is
it possible to rely on sdev->lun_in_cdb which the SCSI midlayer uses to
handle LUN injection safely for legacy devices?

[ ... ]

> @@ -3063,6 +3072,29 @@ static struct ata_device *__ata_scsi_find_dev(stru=
ct ata_port *ap,
>  {
>  	int devno;
> =20
> +	/*
> +	 * Non-zero LUN is only legal for ATAPI devices, since they can
> +	 * legitimately expose more than one LUN (PD/CD combos, CD changers).
> +	 * Handle that case up front so the LUN-0 path below stays unchanged.
> +	 */
> +	if (unlikely(scsidev->lun)) {
> +		struct ata_device *dev;
> +
> +		if (!sata_pmp_attached(ap)) {
> +			if (unlikely(scsidev->channel))
> +				return NULL;
> +			devno =3D scsidev->id;
> +		} else {
> +			if (unlikely(scsidev->id))
> +				return NULL;
> +			devno =3D scsidev->channel;
> +		}
> +		dev =3D ata_find_dev(ap, devno);
> +		if (!dev || dev->class !=3D ATA_DEV_ATAPI)
> +			return NULL;
> +		return dev;

[Severity: Medium]
Does permitting non-zero LUNs for all ATAPI devices here allow users to
trigger the WARN_ON_ONCE() in atapi_xlat()?

Since dev->nr_luns remains 1 for standard single-LUN ATAPI devices that do
not have the BLIST_FORCELUN quirk, a manual SCSI scan (e.g., via sysfs) on a
non-zero LUN will reach atapi_xlat() and hit the WARN_ON_ONCE().

> +	}
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608213443.2296=
614-1-philpem@philpem.me.uk?part=3D3
