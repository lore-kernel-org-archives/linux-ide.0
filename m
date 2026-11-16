Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794862854;
	b=j/2XRNp4mF5m3oeQvEm2QH5iLMjlhhhGKcwu9kyHOhXBx4E4ahjEJg4d+x8BmL/rXivp
	 PIDPXtDujogbwH2lrUOetPo0JtDWh9lPWR3cIMq4Dlr5ZleP1JxWzqiQ/oMKH/Dlss/yg
	 GwsO5s5GDymXcW1l7z6P3EYSLkquh9pWrSHuP/5L/zwnS5kx9FaTy5B9sqXUJ2ajAzgFa
	 EJk5hfXjHCU6cozGCQFNJLIq1OFa/9emvKAQi1kMYw1jAas2G/yTIM5kiwbW9H6jvO3w6
	 Ij+EuWRscISuDQEvyHoMvyAu18+uA44uol6qqsasMB0XtYbxPrdIr2EhO8IauDMj8kA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794862854;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=R4qYF/FRZgmaZXLQBwa1+xTFABC7O7e+kloX5MlDiCY=;
	b=kYc+m5lDfFTXmc+Rnx8+qVaR2DSaFMfhXKR7lLcjrCUfKHuWBizE/MR9FcHrphkwgRDW
	 B/F1+h77ZRrw41qHygvkEebsbb86Gxc5OrDio3QAfeb0lYy1SjMIyHD3PvIwx1UuBPCZa
	 nhzLvSxlwOm0A3zWF4IWOu6FIbwtpigpLJO7n/1GR7yeRCSt1chSB8jN7nLrVH7rsgJ9Z
	 EHcZu+1S2B0TNBCcDImhy2FMYl3Pg5BI5Qb/Uxt7UKLQ7uiQLPowfh4k7TG0eC6VZl+CE
	 NR/uQD/iPdkRrolgnCOFWGemas4I38vR+iiBy4mARIOoKM3Xk0G9jD7GgpspPaHl4Eg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oUSP0IAF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B83B606A322
	for <linux-ide@vger.kernel.org>; Mon, 16 Nov 2026 21:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oUSP0IAF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1679C1F000C4;
	Mon, 16 Nov 2026 21:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794862854;
	bh=R4qYF/FRZgmaZXLQBwa1+xTFABC7O7e+kloX5MlDiCY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oUSP0IAFWNGn6gl/qZQtQ0u8YSyclPNevqFviDhuNcCEe/Nq4JbZaO7UKkUJajf/v
	 qVwKk3H37mYWsIc+EQPZ5Om7IG8xbb4wAPvMkF/XsYxC09gkjR5V5gwTUAbA7dzFAi
	 gdTM1PeX9d8USmMJvp3QBbfV+t1ERemc+TBVvtsSX563Cw3UMKXgSV3dBNJ9Kqk3Dp
	 kr3C3HUNlxF2IcddxqrGoyOWlveyjI/EvlL3q0yGKzKzueKbS2j8jYKwfku7ufcQra
	 G/wGANZftWPWyTYry1AE5LsiWhgDTJQj8iJ1uLMMSPd3IYslfhftUa78alG4dg9x/U
	 lzhXIkGU25eAg==
Message-ID: <sashiko-outbox-217686@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] ata: libata-core: Add max sector quirk to INTEL
 SSDSCKKB240G8
Reply-To: sashiko-reviews@lists.linux.dev
To: "Justinien Bouron" <jbouron@amazon.com>, linux-ide@vger.kernel.org
Cc: dlemoal@kernel.org, cassel@kernel.org
In-Reply-To: <20261116205430.44305-1-jbouron@amazon.com>
References: <20261116205430.44305-1-jbouron@amazon.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 21:00:53 +0000
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Post: <mailto:linux-ide@vger.kernel.org>
List-Help: <mailto:linux-ide+help@vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-ide+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 1 related pre-existing issue it does not
introduce:
- [High] ata: libata: quirk shadowing in ata_dev_quirks() [1]
--

commit 139b2f80d245bb5cb2eb4919933ec350b21131cd
Author: Justinien Bouron <jbouron@amazon.com>

ata: libata-core: Add max sector quirk to INTEL SSDSCKKB240G8

This commit adds an 8191 max_sectors quirk for INTEL SSDSCKKB240G8 drives
with firmware XC311102 to avoid FPDMA timeout errors.

> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 5ff45a5cbfe4a..2a5ca1b9ee5c0 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c

[ ... ]

> @@ -4474,6 +4475,8 @@ static const struct ata_dev_quirks_entry __ata_dev_=
quirks[] =3D {
>  						ATA_QUIRK_MAX_SEC },
>  	{ "INTEL*SSDSC2CT*",		NULL,	ATA_QUIRK_ZERO_AFTER_TRIM |
>  						ATA_QUIRK_NO_FUA },
> +	{ "INTEL SSDSCKKB240G8", "XC311102",	ATA_QUIRK_ZERO_AFTER_TRIM |
> +						ATA_QUIRK_MAX_SEC },

[Severity: High]
This problem wasn't introduced by this patch, but does the early exact match
in __ata_dev_quirks[] shadow the later wildcard entries for
WDC WD2500JD-00HBB0 and WDC WD3200JD-00KLB0 [1]?

Because ata_dev_quirks() returns on the first matching entry in
__ata_dev_quirks[], this new entry includes ATA_QUIRK_ZERO_AFTER_TRIM ahead
of the INTEL*SSD* wildcard.  Earlier in the same table, the exact-match
entries for WDC WD3200JD-00KLB0 and WDC WD2500JD-00HBB0 specify only
ATA_QUIRK_BROKEN_HPA:

drivers/ata/libata-core.c:__ata_dev_quirks[] =3D {
	...
	{ "WDC WD3200JD-00KLB0", "WD-WCAMR1130137", ATA_QUIRK_BROKEN_HPA },
	{ "WDC WD2500JD-00HBB0", "WD-WMAL71490727", ATA_QUIRK_BROKEN_HPA },
	...
	{ "WDC WD2500JD-*",		NULL,	ATA_QUIRK_WD_BROKEN_LPM |
						ATA_QUIRK_NO_FUA },
	{ "WDC WD3000JD-*",		NULL,	ATA_QUIRK_WD_BROKEN_LPM },
	{ "WDC WD3200JD-*",		NULL,	ATA_QUIRK_WD_BROKEN_LPM },
	...
};

When either drive matches its exact entry, ata_dev_quirks() returns without
reaching the WDC WD2500JD-* or WDC WD3200JD-* wildcard entries, leaving
ATA_QUIRK_WD_BROKEN_LPM and ATA_QUIRK_NO_FUA unapplied and exposing those
drives to broken LPM link instability and unsupported FUA I/O errors.

[1] https://sashiko.dev/#/bug/linux-1d8177db-a3fc-48ef-adce-d0515b20b43a

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116205430.4430=
5-1-jbouron@amazon.com?part=3D1
