Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0884D37A4BC
	for <linux-ide@vger.kernel.org>; Thu,  2 Jul 2026 07:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782976616; cv=none; b=jVX9W7OUJOE1jGxYWIgqx4wXDKXk2jPvvv9qEOLCGHq9AxkiKtQzF8hviFjfB47XA0l6u+P28OCjfbIyvTUCd060flCuLw6JsVWDSJG6pf1rjKWFFbcun4KLi/Fo1S1uZgaQyqpXl5DIvkXHBGFzysn93l3F1rv5MyNJqcN4wo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782976616; c=relaxed/simple;
	bh=aKSaEY3kmUa4tRT0hCCOOtzRInmt0/YMmi/asAn9WVI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WSxlFaNc6Sju5outbVc+eqaegOCuTsalTQD+QrYrScG2LYtkNxkmMITX6NuPfyztOvxWO4Gi1rlKdvtzv+St0GbPK5Q5pGPDzPTuVjtvr7YQK2UmY05h0d1EMYUT32vHrudfp/AsGlhg8ULwlz3OqHCsrMsJoO6EI6tc2aY4D2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gK4/1MYK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gK4/1MYK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 009531F000E9;
	Thu,  2 Jul 2026 07:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782976613;
	bh=1sVELj+M7xIVPWnxQPyCDJIPrNzs8lkFCUMwlTS5gx4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gK4/1MYKAV1ejVfN/dOgGgAWkhkidJPoCfYfwNc/DJ4v5DCX32qiECK7LraW+Fni6
	 4W+lZIrLPNGEwvmQmvoxSs4EdZcRvOitEJlaTJzP4UL3i5sld23sGcdtfCGMpWCEyT
	 x4sh8G06z/Hbw+DRNKZarUM8esr3d3GXjdh8mq5yTF1V/0KPyEXmzzwKQOQUOHJiR9
	 p7mXXf9u79V9ZHxA2kOTjkqrG3ASwFV5Sl0gT+pYMLIy3eZqB3c5CivaI8ncnNC/Wu
	 19Bt8450kHyxvozXz4dxOWfukArzjN47H6IEQLt3Xc6IRV6X2N03g9Yy+aXFfxT1zA
	 KoeVrflHMB9Ww==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/5] ata: libata: rename ata_dev_is_zac()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Damien Le Moal" <dlemoal@kernel.org>
Cc: cassel@kernel.org, linux-ide@vger.kernel.org, dlemoal@kernel.org
In-Reply-To: <20260702063412.1892584-2-dlemoal@kernel.org>
References: <20260702063412.1892584-1-dlemoal@kernel.org>
 <20260702063412.1892584-2-dlemoal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 07:16:52 +0000
Message-Id: <20260702071653.009531F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Incomplete refactoring of ZBC checks leaves SCSI emulation in an i=
nconsistent state for Device Managed drives.
--

commit 8a69ac9e4f68da535d403caef5279dfdb19419f2
Author: Damien Le Moal <dlemoal@kernel.org>

ata: libata: rename ata_dev_is_zac()

The helper function ata_dev_is_zac() is renamed to ata_dev_is_zoned() to
better reflect its checks. Existing callers and an open-coded check are
updated to use the renamed helper.

> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index d54ec1631e9a6..8811bfc373697 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c

[ ... ]

> @@ -3656,8 +3656,7 @@ static unsigned int ata_scsi_report_supported_opcod=
es(struct ata_device *dev,
>  		break;
>  	case ZBC_IN:
>  	case ZBC_OUT:
> -		if (ata_id_zoned_cap(dev->id) ||
> -		    dev->class =3D=3D ATA_DEV_ZAC)
> +		if (ata_dev_is_zoned(dev))

[Severity: High]
Should this refactoring also be applied to ata_scsiop_inq_std() and
ata_scsiop_read_cap() to prevent an inconsistent state for Device Managed
drives?

They still use the identical open-coded check:

drivers/ata/libata-scsi.c:ata_scsiop_inq_std() {
        ...
        if (ata_id_zoned_cap(dev->id) || dev->class =3D=3D ATA_DEV_ZAC)
                memcpy(rbuf + 58, versions_zbc, sizeof(versions_zbc));
        ...
}

drivers/ata/libata-scsi.c:ata_scsiop_read_cap() {
        ...
        if (ata_id_zoned_cap(dev->id) || dev->class =3D=3D ATA_DEV_ZAC)
                rbuf[12] =3D (1 << 4); /* RC_BASIS */
        ...
}

By only replacing the check here in ata_scsi_report_supported_opcodes(),
Device Managed zoned drives (ata_id_zoned_cap =3D=3D 0x02) will correctly no
longer report support for ZBC commands, but will still incorrectly claim ZBC
capabilities in standard INQUIRY and set the ZBC-specific RC_BASIS bit in
READ CAPACITY (16).

>  			supported =3D 3;
>  		break;
>  	case SECURITY_PROTOCOL_IN:

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702063412.1892=
584-1-dlemoal@kernel.org?part=3D1
