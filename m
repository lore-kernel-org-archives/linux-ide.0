Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA5738A728
	for <linux-ide@vger.kernel.org>; Sun, 13 Sep 2026 14:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789308488; cv=none; b=igsPAc6d/6JMCbp4fvM9hpdnpRoj1bzcTulrOHmyPe3ZEhCBNEETjpftyvnu15we2teWl6F2bpA50r75rjfQYr89CB3gVVNEJ3TkhQes4mR+hfyAY/CRigrInT+yCkhzzvIWVJBv/srPbw46marKjUnAhgzfV6VBBjHoGSyFFno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789308488; c=relaxed/simple;
	bh=C38IxyJem4n0opmvIo0xdhsIL0W4Q/pVsfkT4QDfTaU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lJbnFq5Dokf3oQpWXEZWJYzTRjCyn6Ys88peO7g4f+lAVllHwJXkQLODt5FAzQvu5uQKpKVTDK9NP8ibaMbX/e0uyWJCQ6PPsmbe/mY4ZAKgQmnVyf17kGJdJJKAy1Jz8+U9nd9LE94UJ6coMmqcBqsqfgmP9yER8hFeSsR3iHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g62ZS4Me; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g62ZS4Me"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 546C91F000FF;
	Sun, 13 Sep 2026 14:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789308486;
	bh=pKS3kzfTR4fRXby7TXwbl2ewgl8+rJu0KXfrQix69A8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=g62ZS4Meq6vwy5BCQN6GBdNxu9rzzkuWstTQ77fSSHhMOj0XhiErQA8LTMdtUd96/
	 pNdfwbclm6a7ubBbwkCB7OddlcMwDA0aQVI3mbChPFYd4v1ceoBvv6mRFHcnA5wM/X
	 F39EUg9qEJZIOLEZXaYKfVBPH86PcMXgDcYBV1JJHOWkI8kULycIzEv1QqyeA/fWQc
	 wYRNjAnG4vkiY5vy7Eb538NMhzKyFdvyk+4gD6dNLzFdANfdpv7GINKqAr1185AF3o
	 nk1Kyrr+hEQdjUx6/q9Nxolnyz7YE5QQheDPslJ8Oe2GlurslpIjnMPMo0DUbHcWDr
	 S6Vhl9wCieWqw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] libata: Fix HPA horkage to target whole model series
 not just a few devices
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ioannis Barkas" <jnyb.de@gmail.com>
Cc: cassel@kernel.org, linux-ide@vger.kernel.org, dlemoal@kernel.org
In-Reply-To: <20260913135650.14244-1-jnyb.de@gmail.com>
References: <20260913135650.14244-1-jnyb.de@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 13 Sep 2026 14:08:05 +0000
Message-Id: <20260913140806.546C91F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Fixing the HPA quirk matching causes these drives to lose their re=
quired ATA_QUIRK_WD_BROKEN_LPM flag due to early loop termination.
- [Low] Malformed Fixes and Signed-off-by tags in the commit message.
--

commit 38c888241e3a93997eedcbdd5bda6cc7281c77f5
Author: Ioannis Barkas <jnyb.de@gmail.com>

libata: Fix HPA horkage to target whole model series not just a few devices

This commit updates the __ata_dev_quirks table to target an entire model
series for the ATA_QUIRK_BROKEN_HPA quirk instead of specific device serial
numbers. It resolves an issue where the HPA horkage was not applied to all
affected drives.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D8888

> Fixes: 16c55b038033 (\libata: implement BROKEN_HPA horkage and apply it t=
o affected drives")
>=20
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D8888
>=20
> Signed-off-by: Nick Barkas nickbgrk@gmail.com

[Severity: Low]
Does this commit message violate formatting guidelines?

Automated tooling might fail to parse the Fixes tag due to the invalid
backslash escape instead of an opening quote, and the Signed-off-by tag is
missing angle brackets around the email address.

> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 59e87b987d73e..b23e1c3e4cd99 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -4248,8 +4248,8 @@ static const struct ata_dev_quirks_entry __ata_dev_=
quirks[] =3D {
> =20
>  	/* devices which puke on READ_NATIVE_MAX */
>  	{ "HDS724040KLSA80",	"KFAOA20N",	ATA_QUIRK_BROKEN_HPA },
> -	{ "WDC WD3200JD-00KLB0", "WD-WCAMR1130137", ATA_QUIRK_BROKEN_HPA },
> -	{ "WDC WD2500JD-00HBB0", "WD-WMAL71490727", ATA_QUIRK_BROKEN_HPA },
> +	{ "WDC WD3200JD-00KLB0", "08.05J08", ATA_QUIRK_BROKEN_HPA },
> +	{ "WDC WD2500JD-00HBB0", "08.02D08", ATA_QUIRK_BROKEN_HPA },

[Severity: High]
Does this change cause these drives to lose their required
ATA_QUIRK_WD_BROKEN_LPM flag?

During device initialization, ata_dev_quirks() iterates through the
__ata_dev_quirks table and returns immediately upon the first match. By fix=
ing
the firmware string to correctly match these devices here, the function will
now exit early and skip the subsequent ATA_QUIRK_WD_BROKEN_LPM entry that
these drives previously relied on:

    { "WDC WD3200JD-*",     NULL,   ATA_QUIRK_WD_BROKEN_LPM },

Without this flag, Link Power Management issues on these specific WD drives
could cause command timeouts, NCQ errors, and potential drive dropouts.

>  	{ "MAXTOR 6L080L4",	"A93.0500",	ATA_QUIRK_BROKEN_HPA },

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260913135650.1424=
4-1-jnyb.de@gmail.com?part=3D1
