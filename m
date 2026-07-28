Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2793909AE
	for <linux-ide@vger.kernel.org>; Tue, 28 Jul 2026 11:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785237722; cv=none; b=EVBtz8vufLmMiBNwYmkH6s5Ey9OZxCdxDpMLHWkspCIVQ0f7B40HuPs7HOYfJbhjiVh5X7XVp83nHc/MCwCbHdnyM7i8sdLNqEITDMOjNMJoHTfjC6jwCZH29+13tK/RQQYkKQ4MWwVDkJvx59RJr/5x33RTewYg85bfaWh516Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785237722; c=relaxed/simple;
	bh=Ybywct0UwPlgro/msZ3UvhXID5Md60CM8R7+fFWAwJg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kGEBPHMBKPzUYmXbMOFKUGCNraU2Oj0ikO+9ES1+nSWXcUHVzU+8BV2LsI7n0vyJRc1qgEYKSuW5qc2QbCjYKQtdgxG/HszSFBrhROdTNKFjA+dHSgH6jSi1pwod4W8id/M6Zv2EEySy0en84s2yz9MUyEOl0I6MzARFOq4YKeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hzb2iS2g; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hzb2iS2g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B99F21F000E9;
	Tue, 28 Jul 2026 11:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785237721;
	bh=29yES9c9/5Fno/0YHocUOUmG2iLV/k8x0spIreGg0EE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hzb2iS2gufLku9YY4hGjfrHg8YSvlAUoFTrCoMHsIk0cASr52in3ycmUF4KVerSSp
	 uYS4/H04elYt4kmPp/8457fE1540O6lAdvT1xMFacx4ZLgtu8EtNa0FXo55i1LljJb
	 r4TNfNuebAJjvPhnnhQMonKaKGiuoNJHkJo9iwiu7r0PPy1SnMb1VJxvpDStO2C5Yr
	 CT0C39c+Ksk8/rghzxTaPtxPrtuJy+6KAukPcg330QGwfHtLSaZCvGlAzcQF4imRYy
	 QF/E7MnG6n8d5NpZUi/iBa6hMeORCV5AIrtO3nY8y0Q2HaWXaQdmMHdaYQKhLEmW6s
	 QXTLUDSqj2VmQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] ata: libata-core: Disable LPM on some WD drives
Reply-To: sashiko-reviews@lists.linux.dev
To: "Niklas Cassel" <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org, dlemoal@kernel.org, cassel@kernel.org
In-Reply-To: <20260728111310.722450-5-cassel@kernel.org>
References: <20260728111310.722450-4-cassel@kernel.org>
 <20260728111310.722450-5-cassel@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 11:22:00 +0000
Message-Id: <20260728112200.B99F21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Incorrect loop iteration in `ata_scsi_lpm_supported` completely ig=
nores `ATA_QUIRK_NOLPM` for devices attached via a Port Multiplier.
--

--- Patch [1]: [PATCH 1/2] ata: libata-core: Disable LPM on some WD drives =
---
commit ddcafc7d1d056ed46964475cc9dcb5abcb0d3b87
Author: Niklas Cassel <cassel@kernel.org>

ata: libata-core: Disable LPM on some WD drives

This commit adds the ATA_QUIRK_NOLPM quirk for specific WD drives that
have problems with Link Power Management (LPM).

Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D220693

> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index c43bd28b20b1a..15781b4f04897 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -4413,6 +4413,14 @@ static const struct ata_dev_quirks_entry __ata_dev=
_quirks[] =3D {
>  	{ "WDC WD3000JD-*",		NULL,	ATA_QUIRK_WD_BROKEN_LPM },
>  	{ "WDC WD3200JD-*",		NULL,	ATA_QUIRK_WD_BROKEN_LPM },
> =20
> +	/*
> +	 * WD drives with LPM issues (irrespective of supported SATA speeds).
> +	 * (Unlike ATA_QUIRK_WD_BROKEN_LPM, which is only applied if the drive
> +	 * exposes SATA Gen1 speed support, and SATA Gen1 speed support only.)
> +	 */
> +	{ "WDC WD100EFGX-68CPLN0",	NULL,	ATA_QUIRK_NOLPM },
> +	{ "WDC WD102KFBX-68M95N0",	NULL,	ATA_QUIRK_NOLPM },

[Severity: High]
This is a pre-existing issue, but will these devices still experience LPM
issues if they are attached via a Port Multiplier?

Looking at ata_scsi_lpm_supported() in drivers/ata/libata-sata.c:

static bool ata_scsi_lpm_supported(struct ata_port *ap)
{
	struct ata_link *link;
	struct ata_device *dev;

	if ((ap->flags & ATA_FLAG_NO_LPM) || !ap->ops->set_lpm)
		return false;

	ata_for_each_link(link, ap, EDGE) {
		ata_for_each_dev(dev, &ap->link, ENABLED) {
			if (dev->quirks & ATA_QUIRK_NOLPM)
				return false;
		}
	}

	return true;
}

The outer loop correctly iterates over all links, including PMP links, but
the inner loop iterates over &ap->link instead of the current link being
evaluated.

Could this cause the code to repeatedly check the host link's devices while
entirely ignoring devices on PMP links? If so, the ATA_QUIRK_NOLPM quirk
might be bypassed for these buggy drives when they are attached via a Port
Multiplier and power management is configured.

> +
>  	/*
>  	 * This sata dom device goes on a walkabout when the ATA_LOG_DIRECTORY
>  	 * log page is accessed. Ensure we never ask for this log page with

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728111310.7224=
50-4-cassel@kernel.org?part=3D1
