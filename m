Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A0D435AAE
	for <linux-ide@vger.kernel.org>; Tue, 28 Jul 2026 11:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785239618; cv=none; b=cv+rosq0klwHdSwjwj0YCO9O63/4+HdIbaLMco8UhDGRIIy/N7oHmo0iZ8uATyMBnuhbwdQvbgJ73sIFbrXnuZCD57va/Udo8NGdUFnLEhJaGi9zFiTyzB5ZiPJvX3rPdoC9AaOFraab/W29BEJQ3Dc1M1yXZ9WkIUEU2QW/jw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785239618; c=relaxed/simple;
	bh=Efbvr7fPP9sTlJ7l+Moz6DX5NE8Evj4x83g3HsIjmmg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SSLE8TI69UnIge9tEM4V5Y3aVGqcMi3aIEWhwsJ2eHkcVZgvz3dziOCN9i25Hn6bHR2zBZHd6D9kD0Vhx+NbaMzB51O7ApTbakBoPVBrxR4ndfLe2wJ0xvZ3FSgA1LA1P2BkBUrS4txPdtiMbtWhyHcm4L6KfpIY/q583q6b+Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JV+/Xllv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JV+/Xllv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B4861F00A3D;
	Tue, 28 Jul 2026 11:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785239616;
	bh=jg/FCw+UhNvhQpujvFegpLDH3pzONhRzSnOfcWFWRJg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JV+/XllvNnCsFPniDAArz34fhlFlsPBvQ6W7qWK8j0vKC+zS+3kxiwJ5MyhwwZT1j
	 cvjnsn627Rs4oHZXmd6sX7WQKo5Vqifsth7fiPLluJ2uOaNZ0KcwNDk5ajaM1wABkc
	 eu/FvAtJ2tW4Ktx9HWTerNeyqjoVIZzWHtUJGzrXEVbrrBZVliko+Rs7MBkeEjUX2P
	 ESZRx4GtMd+ZUgQj5p20XdLzIo3FYXl93EHNcTMJZCtCxVUjcMHDgEfhsdm3LvOufB
	 cNVoIgtlWMW7aB7SxA1URDHh6TD3nWn62GyRqSc2coS0vo/zjiNdQ9IyCcHACwOlQm
	 l+YwxM1l5Q+hA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] ata: libata-sata: fix ata_scsi_lpm_supported()
 iteration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Niklas Cassel" <cassel@kernel.org>
Cc: cassel@kernel.org, dlemoal@kernel.org, linux-ide@vger.kernel.org
In-Reply-To: <20260728113841.727256-2-cassel@kernel.org>
References: <20260728113841.727256-2-cassel@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 11:53:36 +0000
Message-Id: <20260728115336.9B4861F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] ata_scsi_lpm_supported() skips checking devices on the slave link =
because it uses the ATA_LITER_EDGE iterator. This allows userspace to enabl=
e Link Power Management (LPM) on a port where the slave device does not sup=
port it (has ATA_QUIRK_NOLPM).
--

--- Patch [1]: [PATCH] ata: libata-sata: fix ata_scsi_lpm_supported() itera=
tion ---
commit 32bd728de2e1b6025504205f3ade16813231e703
Author: Niklas Cassel <cassel@kernel.org>

ata: libata-sata: fix ata_scsi_lpm_supported() iteration

This commit fixes the inner loop of ata_scsi_lpm_supported() to iterate
over the specific link being evaluated rather than always using the host
link. This prevents the LPM policy from being incorrectly applied or denied.

Link: https://lore.kernel.org/linux-ide/20260728112200.B99F21F000E9@smtp.ke=
rnel.org/

> diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
> index b0706c30da052..ad40f516c6d43 100644
> --- a/drivers/ata/libata-sata.c
> +++ b/drivers/ata/libata-sata.c
> @@ -913,7 +913,7 @@ static bool ata_scsi_lpm_supported(struct ata_port *a=
p)
>  		return false;
> =20
>  	ata_for_each_link(link, ap, EDGE) {
> -		ata_for_each_dev(dev, &ap->link, ENABLED) {
> +		ata_for_each_dev(dev, link, ENABLED) {

[Severity: High]
This is a pre-existing issue, but does using the ATA_LITER_EDGE iterator
here in ata_scsi_lpm_supported() skip checking devices on the slave link?

Since the EDGE iterator skips ap->slave_link, it appears this loop misses
devices on the slave link that might have the ATA_QUIRK_NOLPM quirk.=20

If a user or power-management tool writes to the sysfs attribute
link_power_management_policy, ata_scsi_lpm_supported() would incorrectly
return true. Then ata_port_schedule_eh() triggers Error Handling, and
ata_eh_link_set_lpm() might blindly apply the unsupported policy to the
slave link.=20

Can this result in the slave drive becoming unresponsive, leading to
command timeouts or dropped devices?

>  			if (dev->quirks & ATA_QUIRK_NOLPM)
>  				return false;
>  		}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728113841.7272=
56-2-cassel@kernel.org?part=3D1
