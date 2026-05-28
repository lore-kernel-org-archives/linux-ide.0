Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A203F7A83
	for <linux-ide@vger.kernel.org>; Thu, 28 May 2026 17:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779990678; cv=none; b=FddQ+RTM+X40Aofzt0iAyY1pAMXUN23ZK5TrqyeZZBQQtGi4n3utCEr8Npb/I8jnq8jdKyL0O/MVnsIm/+dvHLSal7ybaXqgh/sLV3j8vw0N+I/XUa4/DR1U9yz4kU1YcDMEGDK6oEcaaWfInSggBgN/SMN27NUWsDkMXdoFzVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779990678; c=relaxed/simple;
	bh=EZ0i7j/DuXZP1BQixSeLNcZ9u/pDFqNWbDlygTWL+qo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OKwe55NuL+9W76Hsn2oa0yRtW7lBvPgnESuWQ7Dq8tbKBqOGY4+VaOQA5MdMXNeY0yAHSFYa4cEKvSH10QwkE/W6D97jmClj2bDwhOgIuoQTp5HfMxgIhroDyx/Qey1gi7ovVVQQIuGla1lfrnEJuxLi2MtcyE1fXei6amVDUyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k98qgAgl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k98qgAgl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4408A1F000E9;
	Thu, 28 May 2026 17:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779990676;
	bh=qm/McJiuZB8zTwZAJRTFLezCbhkVPr2zJx62rVvKJ/A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=k98qgAglmVJQE1r6SUApDPiKLi0tSJwkcaBREnbXt5lznoF12gnOtYt4pgeznu3cU
	 jagaNT/bywSe1nR5slVep+g0MpwmXM5Gp66o3QO9sjSG/LrA1Y4HC/CgWVYTgQRfoX
	 /+2X8YcpGxWk7Om3TW7Eo2cgjohz2GXdvE2w8GmPaNIPkwLbibIEApu3klXVfDBVLI
	 QgeMSXGgWSPwpWjegjxv2wwQBRAZjX/926BBY6bfgt/otS5Cwq/parHwKzQwLB6tjA
	 bvjfusnhdxthEmCiZJrvwPhuL2SI/S7461291LReJZXRg3hxsgQHLKpCPvhqMHj4zo
	 bBaHfLrnBx0JQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] ata: libata-scsi: Remove lockdep_assert_held() in
 ata_scsi_translate()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Niklas Cassel" <cassel@kernel.org>
Cc: cassel@kernel.org, dlemoal@kernel.org, linux-ide@vger.kernel.org
In-Reply-To: <20260528172855.703631-6-cassel@kernel.org>
References: <20260528172855.703631-6-cassel@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 28 May 2026 17:51:15 +0000
Message-Id: <20260528175116.4408A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Removing the runtime `lockdep_assert_held()` assertion weakens d=
ynamic lock verification in favor of static analysis.
--

commit 5b34afedb186c216f09eff8d76c27e0b405885ea
Author: Niklas Cassel <cassel@kernel.org>

ata: libata-scsi: Remove lockdep_assert_held() in ata_scsi_translate()

This commit removes the lockdep_assert_held() check from
ata_scsi_translate(), stating that it suppresses context analysis by
indirectly calling __assume_ctx_lock(). The commit message notes this
will be replaced with context analysis in a follow-up commit.

> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index f44612e269a4d..c31267091662a 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
> @@ -1852,8 +1852,6 @@ static int ata_scsi_translate(struct ata_device *de=
v, struct scsi_cmnd *cmd,
>  	struct ata_port *ap =3D dev->link->ap;
>  	struct ata_queued_cmd *qc;
> =20
> -	lockdep_assert_held(ap->lock);
> -

[Severity: Medium]
Is it safe to completely remove this runtime assertion instead of combining
it with the static analysis annotation?

While __assume_ctx_lock() tells the compiler the lock is assumed held inside
the function, the standard practice to statically enforce that the caller
holds the lock is to add __must_hold(ap->lock) to the function signature
while retaining lockdep_assert_held() in the body. Retaining both provides
valuable run-time validation alongside compile-time checks.

Additionally, does removing this check here and introducing the static cont=
ext
analysis in a follow-up commit temporarily leave this function without any
locking verification during intermediate bisect steps?

>  	/*
>  	 * ata_scsi_qc_new() calls scsi_done(cmd) in case of failure. So we
>  	 * have nothing further to do when allocating a qc fails.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260528172855.7036=
31-5-cassel@kernel.org?part=3D1
