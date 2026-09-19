Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19C0377023
	for <linux-ide@vger.kernel.org>; Sat, 19 Sep 2026 22:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789858010; cv=none; b=r80Lf7hsaKmAIdjvcQGQp4MHE7s64WlCFPly/nQzZGegnicTbV9b8xRHud7Hb0IGnlcb5yw5lMW6irBpWDyo3+Npx986jOGvPoGpXI01jkjfr+Nw547wYqKMJ1Wa1OBQ4Q5nf6h5eMWwzNH7WtZkLxW6zgEfT6m7SgcA07yHPvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789858010; c=relaxed/simple;
	bh=KddJ2xqtJjLmjHGBi+U1D2o56XJBCsaOMwue1cF+3fQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pImx2Ggj493F/440iQxSic/WIpD3kjzaiMfK+AGA6IEwKGYG8w9vfyw997demHyHEghHGhfc2OaGHwiBwwVDhwX0dtBg6+DlSfRtAuREozvCAaUm2tTMZYKDvTAsV0Ur80b4wkm6C99li0tr+Jw1pVAi4PhoWlU+0aQHgCm3rhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BK6OWGeX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BK6OWGeX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E37DF1F000FF;
	Sat, 19 Sep 2026 22:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789858007;
	bh=8vdpaoz6lbir+kbmaaLazvFR035YQcv/RVg0OeCAyGI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BK6OWGeX++1ESVh/sGrvCZRkCqT8Z4bwtlXhWboY2xfVTrppJhFkQaTe+D6v64+p5
	 WM6kqVI2fABvP/QVM1m2d4DFL3PiObzINypsOzR55Eovh3a9+Q8OtAc2yIQtzj4wgb
	 DR5v5crCoM+uIxirSN+TwBojm2gx1htbo+YnZKbIrtUJqahbkhJDxgevn9nPBdSYHf
	 JRLH/DSROO8TqO0YJH/Ffk/+XEbXOiDp83o2Vd+3nHlaTNIrhs0dUnIvenxwo/GPUo
	 w6NIsIpLCCNwpPJPK27SflMgESTitnnAN4rdzQEtoQbPyNb6p+oydtkt8Np0u5oNy/
	 isRvXVM+Urxkw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] ata: libata-scsi: reject multi-sector taskfile commands
 when dev->multi_count is 0
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hui Peng" <benquike@gmail.com>
Cc: dlemoal@kernel.org, cassel@kernel.org, linux-ide@vger.kernel.org
In-Reply-To: <20260919222625.3797581-1-benquike@gmail.com>
References: <20260919222625.3797581-1-benquike@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 19 Sep 2026 22:46:46 +0000
Message-Id: <20260919224646.E37DF1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] scsi: incorrect error field pointer for ATA_32 variable length CDBs
--

commit 19f1f1458eecf6dc97d38273c4c750d2aff47ab1
Author: Hui Peng <benquike@gmail.com>

ata: libata-scsi: reject multi-sector taskfile commands when dev->multi_cou=
nt is 0

This patch rejects ATA_PROT_PIO multi-sector commands with -EINVAL when=20
dev->multi_count is 0. It does this by catching the condition early and=20
triggering an error path to avoid divide-by-zero or warnings in the=20
taskfile path.

> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index d2160ee7ca7d4..3fc4f0377e991 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
> @@ -3473,6 +3473,11 @@ static unsigned int ata_scsi_pass_thru(struct ata_=
queued_cmd *qc)
>  	if (is_multi_taskfile(tf)) {
>  		unsigned int multi_count =3D 1 << (cdb[1] >> 5);
> =20
> +		if (!dev->multi_count) {
> +			fp =3D (cdb[0] =3D=3D ATA_16) ? 14 : 9;

[Severity: Low]
Does this fallback to 9 incorrectly handle ATA_32 variable length CDBs?

When an ATA_32 pass-through command specifies a multi-sector command in
ata_scsi_pass_thru() but the device does not support it, this code rejects
the command and sets the invalid field pointer (fp) to 9. For an ATA_12
command, byte 9 is the command field, but for an ATA_32 variable length CDB
(opcode 0x7F), byte 9 is the Service Action lower byte, and the command
field is at byte 25.

Could this result in the SCSI sense data incorrectly pointing to byte 9
instead of byte 25 on the error path for ATA_32 commands?

> +			goto invalid_fld;
> +		}
> +
>  		/* compare the passed through multi_count
>  		 * with the cached multi_count of libata
>  		 */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260919222625.3797=
581-1-benquike@gmail.com?part=3D1
