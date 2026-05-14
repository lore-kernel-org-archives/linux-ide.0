Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753EB1531C8
	for <linux-ide@vger.kernel.org>; Thu, 14 May 2026 01:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778721158; cv=none; b=kMFCeMe1EtIqsj5dbs0t928chfEUIscM4sxWlhfCqskhjfY6+xT7LhvDwNtuIWYDnK49HS0VwKEDTRuy6Yp3Zg95p+L66povi9RECzJRNp+2hgeB1fswEduUopjd9M9WI2W8F3/GuwOOIJ7gva8zg3kwi8XLXQuX8468UbLlz/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778721158; c=relaxed/simple;
	bh=Gvo5DiPgEZBZdtdqL5/jVndDjL0ZYVOnK+GrT1KfGnE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nOOPwlr1r5GX7cngoaBfwo7SxGe3tEu70mxL7exTzIrOfRfCBJINAAExHO0mVYJwb+dyqTRTooeNTnt6oeezOsV4B3VMx2ey6cmnGNwgRVkamLxvRlNFTq1Kw7CpSMA+9Ig5fL0tamFrtW9TcBWIhylWzVS6v+3RNX1X8sGR6/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ms4P7ZA2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ms4P7ZA2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDBF3C19425;
	Thu, 14 May 2026 01:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778721158;
	bh=Gvo5DiPgEZBZdtdqL5/jVndDjL0ZYVOnK+GrT1KfGnE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=Ms4P7ZA2lYgnkGvDBEv4ZIL5vj5F2t0MbYLdlGQS7qxM6ek7+KV4mafdazYIC4czG
	 GOf8bcqJGfmE35MGJwVf958J6IFwlLmC80JjlBcTdcACp/8yoFJO0LYg9ZiNyjHKho
	 xChJ3IfaqVH8TpTEYH5SXu7dd/1XspnqLgGvUyhtbUSQGD/ZyvnpZNM2pvqYsj80Oj
	 vzoFfiZT5Q/XkkneduM7Qp1PnIcD83kZpojXGB/OyP1ES7DLRel8ZgUHkWIXxS1cfY
	 3MhRWffKlXE9WfdHCVjWZOa9v3RWhDF7jqaow/oYIfqn4njIhomaENlJsK+agENQBJ
	 T7dZq3pS3msXg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 3/6] ata: libata-scsi: route non-zero LUN commands
 for multi-LUN ATAPI
Reply-To: sashiko-reviews@lists.linux.dev
To: "Phil Pemberton" <philpem@philpem.me.uk>
Cc: linux-ide@vger.kernel.org, cassel@kernel.org, dlemoal@kernel.org
In-Reply-To: <20260512202728.299414-4-philpem@philpem.me.uk>
References: <20260512202728.299414-4-philpem@philpem.me.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 May 2026 01:12:37 +0000
Message-Id: <20260514011237.CDBF3C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Critical] Unconditional LUN injection into CDB byte 1 clobbers command-s=
pecific flags for modern ATAPI commands.
- [Critical] Returning AC_ERR_INVALID from atapi_xlat without setting cmd->=
result causes silent command success (Silent Data Corruption).
- [High] Reachable WARN_ON_ONCE splat and broken LUN > 0 feature due to har=
dcoded dev->nr_luns.
- [High] Lifecycle functions fail to clean up LUNs > 0 when dev->nr_luns re=
mains 1, leading to resource leaks and use-after-free.
--

commit 3063d8fc6690940538378993230bab65cc937027
Author: Phil Pemberton <philpem@philpem.me.uk>

ata: libata-scsi: route non-zero LUN commands for multi-LUN ATAPI

This commit updates __ata_scsi_find_dev() to allow commands directed at
ATAPI devices with non-zero LUNs to proceed. It also modifies atapi_xlat()
to encode the LUN into bits 7:5 of CDB byte 1 to support legacy SCSI-2
era ATAPI devices.

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

In the libata subsystem, dev->nr_luns is statically initialized to 1.
If an administrator triggers a manual SCSI scan to LUN 1 via sysfs, will
this check evaluate to true and trigger a kernel warning splat?

Does returning AC_ERR_INVALID here also block the multi-LUN feature for
standard ATAPI devices that do not have a specific quirk to increment
dev->nr_luns?

If atapi_xlat() returns AC_ERR_INVALID here, ata_scsi_translate() will
detect the non-zero return and directly call scsi_done().

Because cmd->result remains at its initialized value of 0 (SAM_STAT_GOOD),
will the SCSI and block layers treat the dropped I/O as successfully
completed? Could this return uninitialized memory to the caller for
read commands?

Additionally, if a non-zero LUN is instantiated because a manual sysfs
scan silently succeeds due to the AC_ERR_INVALID behavior above, but
dev->nr_luns remains 1, will lifecycle loops in functions like
ata_scsi_remove_dev() fail to process the extra LUNs?

Could this leak the scsi_device structure for LUN 1 and cause a
use-after-free when the underlying ATA port is destroyed?

> +	qc->cdb[1] =3D (qc->cdb[1] & 0x1f) | ((u8)scmd->device->lun << 5);

For modern ATAPI devices using the SCSI-3/MMC command set, bits 7:5 of
CDB byte 1 are repurposed for command-specific parameters, such as the
RDPROTECT and WRPROTECT flags in read/write(10), or the blanking type
bits in the blank command.

Does unconditionally masking and setting these bits silently corrupt
those valid flags?

Also, since the Linux SCSI midlayer automatically performs this injection
based on the sdev->lun_in_cdb flag for legacy SCSI-2 devices, is this
manual injection redundant?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260512202728.2994=
14-1-philpem@philpem.me.uk?part=3D3
