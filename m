Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7307F32A3FD
	for <linux-ide@vger.kernel.org>; Fri,  3 Jul 2026 04:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783054797; cv=none; b=EVZHMRgQmeJcMSizBQD0hh1bI+n3o17n82A8e+CSAcl46C2Vohkd42ttnVLdrwL3KyeJ2spBp/gWX952DxoxTw6DMrOEAofOw6xlvJSAVJAYTTUJOdamPI3pRdu8bE150XvtCDAPwuoYfhiyYHadcuW+obYUeCe7jajXBZyoHLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783054797; c=relaxed/simple;
	bh=AFfIJJ6d5C6FTbVwOn8B6nghFLSl/HRvNPVZ+zTN8Pc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=g5MdN7vz8B/KU6wOn8c7YQitdLiC5nPBDpU2bWHt0umcVhQWKqQQaGqtEQZwyCHceEkZP/TscwMb6tfOeUxc6tcEIY3hp4mTN99RGE7u018mKl57xoZVCq6e4dPaIIAd/DOf2Cb+9BYWcweHaJ84qEeiJd/8zJ+/zXBTH8SC/+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j+WHCTEc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j+WHCTEc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA9F11F000E9;
	Fri,  3 Jul 2026 04:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783054786;
	bh=ljDsZfFRsxscCIUXMfZ6rk4vTfGm6U/lU09OFm9P6Tw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=j+WHCTEceVgCjHg/QMb/P9DYuYgou2P9FbpEQQjE5ajgOboEzvc69/DdZ6fD0E5fy
	 qmu+uzA0l8dqERLl/pfiBKu08iNgr2EkmYoyhafvu77R42LWvgsmJxo9SfHkolsj4V
	 NrfQqHF+ulQIUrqE2JpjTXLfXrqkxdiesANTznh58AqKjGIaZxNMrjZXOQdVTMa358
	 fQ1FemxZlGwfCjDF1j/9gtdcj5vXkbUHc/qdAolyvoxI0HJ+Ijjo4B5vuWM/LlxLhG
	 5YLHMuKhyjqIiCOkGA3D1ThTClkG+5VuW4mBvL36D52vNZXHEchpIhdXreYQHZ1Gv3
	 M4PBiqqugA0rQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/5] ata: libata: rename ata_dev_is_zac()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Damien Le Moal" <dlemoal@kernel.org>
Cc: cassel@kernel.org, dlemoal@kernel.org, linux-ide@vger.kernel.org
In-Reply-To: <20260703040532.2152614-2-dlemoal@kernel.org>
References: <20260703040532.2152614-1-dlemoal@kernel.org>
 <20260703040532.2152614-2-dlemoal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 03 Jul 2026 04:59:45 +0000
Message-Id: <20260703045945.BA9F11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The patch introduces an undocumented functional change (implicit=
 bug fix) for Device Managed zoned drives, while the commit message falsely=
 claims the refactor merely replaces identical open-coded tests.
--

commit c24879d1eda5cc422a0b0da776fb6aef5fe25e22
Author: Damien Le Moal <dlemoal@kernel.org>

ata: libata: rename ata_dev_is_zac()

The helper function ata_dev_is_zac() checks if a device is a ZAC class
device (host managed zoned disk) or if it is a host aware zoned disk, that
is, a regular ATA disk that supports the zoned capabilities. So the name
of this helper function is confusing as it hints at the first case only.

Rename this helper function to ata_dev_is_zoned() to avoid confusions and
better reflect the two cases tested. Use this helper in
ata_scsiop_inq_std(), ata_scsiop_read_cap() and
ata_scsi_report_supported_opcodes() instead of having the same tests open
coded.

While at it, to stay consistent with this renaming, also rename
ata_dev_config_zac() to ata_dev_config_zoned().

> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index d54ec1631e9a6..a86721b5df7f6 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
> @@ -2020,7 +2020,7 @@ static unsigned int ata_scsiop_inq_std(struct ata_d=
evice *dev,
>  	if (rbuf[32] =3D=3D 0 || rbuf[32] =3D=3D ' ')
>  		memcpy(&rbuf[32], "n/a ", 4);
> =20
> -	if (ata_id_zoned_cap(dev->id) || dev->class =3D=3D ATA_DEV_ZAC)
> +	if (ata_dev_is_zoned(dev))

[Severity: Medium]
Does this introduce an undocumented functional change for Device Managed
zoned drives?

The commit message states this is a replacement of "the same tests open cod=
ed",
but the old condition would evaluate to true for Device Managed drives,
since ata_id_zoned_cap() returns 0x02 for them.

The new ata_dev_is_zoned() helper checks ata_id_zoned_cap(dev->id) =3D=3D 0=
x01,
which evaluates to false for Device Managed drives.

This appears to alter SCSI emulation for these drives, as they will no long=
er
report ZBC version compatibility here.

Could the commit message be updated to mention this functional bug fix?

>  		memcpy(rbuf + 58, versions_zbc, sizeof(versions_zbc));
>  	else
>  		memcpy(rbuf + 58, versions, sizeof(versions));

[ ... ]

> @@ -2848,7 +2848,7 @@ static unsigned int ata_scsiop_read_cap(struct ata_=
device *dev,
>  	rbuf[10] =3D sector_size >> (8 * 1);
>  	rbuf[11] =3D sector_size;
> =20
> -	if (ata_id_zoned_cap(dev->id) || dev->class =3D=3D ATA_DEV_ZAC)
> +	if (ata_dev_is_zoned(dev))
>  		rbuf[12] =3D (1 << 4); /* RC_BASIS */

[Severity: Medium]
Similarly, does this silently fix Device Managed drives incorrectly
reporting the RC_BASIS bit in READ CAPACITY 16?

>  	rbuf[13] =3D log2_per_phys;
>  	rbuf[14] =3D (lowest_aligned >> 8) & 0x3f;

[ ... ]

> @@ -3656,8 +3656,7 @@ static unsigned int ata_scsi_report_supported_opcod=
es(struct ata_device *dev,
>  		break;
>  	case ZBC_IN:
>  	case ZBC_OUT:
> -		if (ata_id_zoned_cap(dev->id) ||
> -		    dev->class =3D=3D ATA_DEV_ZAC)
> +		if (ata_dev_is_zoned(dev))
>  			supported =3D 3;

[Severity: Medium]
Does this also correctly prevent ZBC_IN and ZBC_OUT from being reported as
supported for Device Managed drives?

If these are intentional bug fixes rather than just refactoring, should the
commit message clarify that the previous open-coded tests incorrectly match=
ed
Device Managed drives?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260703040532.2152=
614-1-dlemoal@kernel.org?part=3D1
