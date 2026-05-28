Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BFA3340293
	for <linux-ide@vger.kernel.org>; Thu, 28 May 2026 19:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779994853; cv=none; b=tBRxYbxXtTMg+A412W0tlAmlm4pKjLOmPJnaM9fizCE02sBFUxIRO9nlwY4RoGDdemCjS9LJtLK+0exgSNwA3IeK2GLXbf6UhnpXQzdOPcBtMZnmkEjKs/0GtxTnGFQHZ5Sh2u7nm+IYIlYbjaHatE4mMZCXZXeAU+QzZO1wBmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779994853; c=relaxed/simple;
	bh=SfZaABMhiOsy8JXpzdC4phUSBXxdfFYpP0GiDkvNDOs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ryrfUhNh6FPq9fqyvPdblVslnnBwyovs44sEbyoddwtmd0Xka9p41ICyoccnf3I2BPZswHaJV2C4ZuD5pQu22bB2zSOKW1pOvTxEwtE+iR4Ni8J7FZDIrEdfHd5vU3CLI3PYfPrFRULXRlnfDUcyju0kBehVywbGejJSfvw6EqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ngi5dXJ6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ngi5dXJ6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A70951F000E9;
	Thu, 28 May 2026 19:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779994834;
	bh=10vJVwgPNqs5ZV5/yMpov5CK61BbOl8HNId/wDYoHHM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ngi5dXJ6YRFJyY6hpfCanjmIVXSL2Cpl8BiK/njukYay99OXmR7IlP8RQkrqC+6N1
	 FlHJRQXKitdCqdnSR8FvZGHI9VNm+FS3hSPmo48RegKE4pXoVX0qv4tddlUhfd9yFM
	 zSbIySGFS8Nk3hCdGOd6nMkUZsgWflg7bhYpr0xEiBG9BwjunPm8heoHs6WusGIGw+
	 MizMm78nn42RIdEfykx+kr/LFFUlnsQMRk9f3cSU4WdgZGi0xDsec3lOtjvNVT8/WM
	 1exNaQh2ifFMnkVfBx9C0Rc51v6+JWsqzH/wj2jFRefxDWpo3NQYGs+lRKMPYpNK3A
	 Iy29PdZAJvJzw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4] ata: libata: Document when host->eh_mutex should be
 held
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bart Van Assche" <bvanassche@acm.org>
Cc: linux-ide@vger.kernel.org, dlemoal@kernel.org, cassel@kernel.org
In-Reply-To: <230fb523796cd9c1643c5673bddb45fc48eb9514.1779990228.git.bvanassche@acm.org>
References: <230fb523796cd9c1643c5673bddb45fc48eb9514.1779990228.git.bvanassche@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 28 May 2026 19:00:34 +0000
Message-Id: <20260528190034.A70951F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Low] Missing context analysis annotation on ata_exec_internal() causing =
a build failure.
- [Low] Convoluted and redundant pointer traversal in lockdep_assert_held().

Pre-existing issues:
- [High] Read-modify-write race on pp->pp_flags in mv_pmp_error_handler().
--

commit d2826b7a41176ba50abfe15ca5e18e09e68b29d4
Author: Bart Van Assche <bvanassche@acm.org>

ata: libata: Document when host->eh_mutex should be held

Annotate error handler implementations and helpers with __must_hold,
__acquires, and __releases for host->eh_mutex. Enable Clang's context analy=
sis
to prevent locking bugs in error paths.

Link: https://lore.kernel.org/all/177926568868.711.3058599932884307249.tip-=
bot2@tip-bot2/

> diff --git a/drivers/ata/Makefile b/drivers/ata/Makefile
> index 20e6645ab7371..b96025abd45e3 100644
> --- a/drivers/ata/Makefile
> +++ b/drivers/ata/Makefile
> @@ -1,5 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0
> =20
> +CONTEXT_ANALYSIS :=3D y
> +

[Severity: Low]
Does enabling context analysis here cause a build failure?

ata_exec_internal() in drivers/ata/libata-core.c unconditionally calls
ata_eh_release() and ata_eh_acquire() without being annotated. Since Clang's
analysis assumes no locks are held at the start of an unannotated function,
calling ata_eh_release() triggers a compiler error for releasing a mutex th=
at
was not held.

Could ata_exec_internal() be annotated to fix this?

[ ... ]

> diff --git a/drivers/ata/libata-pmp.c b/drivers/ata/libata-pmp.c
> index e3adc008fed1e..bf40633f8fb23 100644
> --- a/drivers/ata/libata-pmp.c
> +++ b/drivers/ata/libata-pmp.c
> @@ -750,6 +751,8 @@ static int sata_pmp_eh_recover_pmp(struct ata_port *a=
p,
>  	int detach =3D 0, rc =3D 0;
>  	int reval_failed =3D 0;
> =20
> +	lockdep_assert_held(&ap->link.ap->host->eh_mutex);

[Severity: Low]
Could this pointer traversal be simplified?

Since the variable ap is already a pointer to struct ata_port, traversing
through its embedded link struct to resolve back to the exact same ap point=
er
seems redundant.

Could this be simplified to lockdep_assert_held(&ap->host->eh_mutex)?

[ ... ]

> diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
> index ffb396f61731f..f6942fd80bae7 100644
> --- a/drivers/ata/sata_mv.c
> +++ b/drivers/ata/sata_mv.c
> @@ -2398,6 +2398,7 @@ static struct ata_queued_cmd *mv_get_active_qc(stru=
ct ata_port *ap)
>  }
> =20
>  static void mv_pmp_error_handler(struct ata_port *ap)
> +	__must_hold(&ap->host->eh_mutex)
>  {
>  	unsigned int pmp, pmp_map;
>  	struct mv_port_priv *pp =3D ap->private_data;

[Severity: High]
This is a pre-existing issue, but does this function have a read-modify-wri=
te
race on pp->pp_flags?

This function runs in process context (EH thread) and modifies pp->pp_flags
without holding ap->lock:

	if (pp->pp_flags & MV_PP_FLAG_DELAYED_EH) {
		pmp_map =3D pp->delayed_eh_pmp_map;
		pp->pp_flags &=3D ~MV_PP_FLAG_DELAYED_EH;

Concurrently, the hardware interrupt handler (mv_interrupt) can execute,
acquire ap->lock, and modify pp->pp_flags (e.g., setting
MV_PP_FLAG_FAKE_ATA_BUSY).

If the interrupt fires between the read and the write of pp->pp_flags in
mv_pmp_error_handler(), will the interrupt's modifications be silently
overwritten and lost?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/230fb523796cd9c1643=
c5673bddb45fc48eb9514.1779990228.git.bvanassche@acm.org?part=3D1
