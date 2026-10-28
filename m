Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793192063;
	b=cCAzqEc8YP7kIsaWWcG0vg4sfovUUk5A+Ao+xHdDox9FIKeqO/fMK4m9zNqP3UTJAkXF
	 jLv2wuKeqfFuvZGzywiWrasBQVxTN43jP0hloOGaZ2IDrqQcgr20GTgj7ggZCIxaZgBSE
	 JkUGhq8sQnlPjdZx9SyipDAcHxm9YrRv7ESLsDdf5R6WvcJv8YtPLBwTMHpOau4rD3qZV
	 AOkytQc1Er4ODAAJLiRaaQ0d+xTBHA2Odukz7wVkHdKBik4cnp6VWdc+AvXugWkJZzuNy
	 hZ9rhZDLF6a64ZR7O1zyMeJsOGAdJyGgvQS+e+oUYnKH8OvotCBafCOoOabdrNCT7Jg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793192063;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=HyRU213FvJ5IaQMb0j4HxGQl1SwRnUdjeW++uibCssw=;
	b=UUE3tTbVT1zuDQhuJNBCJgAAwZQcSdk3DxCD54PBF8/eOIFpkFKeHxTvO9a05DUvu4KX
	 GkUL1Hd7MvF4losQeCC4y7GZ9Mwm/kBuyk4tGixVyxBjvXamHwUGP72XC1wtJQ1SvQyKS
	 OqmcLSm2+XZ6SjWRGF/JvsL+cwnPKZoZVfcTv6ZCKK2eqJ+AiyZy0hVErzrdRajtq6/Pj
	 kVx9OWxkipfhACKwubBhixKkw1Tp6GMj9lnqxemoHS3jyM1wgSDc3tzsGWcxwnotk1Myf
	 hnKu+kezyKSQFFwrnxy4rqXyVM+KdtnY8KuQiXqghOIwoMXjAuWi4yPGZGpCyl+JYXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l02KnY6e;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D89E3606A31A
	for <linux-ide@vger.kernel.org>; Wed, 28 Oct 2026 12:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l02KnY6e
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ABBE1F01828;
	Wed, 28 Oct 2026 12:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793192062;
	bh=HyRU213FvJ5IaQMb0j4HxGQl1SwRnUdjeW++uibCssw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=l02KnY6eOmJB81q/Emzi5DuX/EaP3IP7NGqxjC0/spUvQjL9XiUrZWCHVxg3sF9Q1
	 OgLD5ukqKVVqbZcuhivvEWGdJIxdWtPYJO0yV18IBBhlzFnkmmU9gin3Y3KSR8lWb4
	 XMAsdPt9aTR+KvBEv+QeJbIoFsU6xPnbD7NTBrrx2FR51y0OykKZKs3AmwBDEgPO8X
	 nmyYpEAzp1pMPvFkcxX3sXjSax/Uc6ah9p3geJPSMQiDFIGnK9w72XteZfTqUnGduj
	 GgplSNQ6UzJrPLADqM/dce2/3Lh5/pUEKgjnH9yVRzMjhE+01MKkDnpacmHUm3c/CP
	 CjRtzoSVHnZIA==
Message-ID: <sashiko-outbox-187886@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] ata: libata-core: Add NOLPM quirk for PNY 1TB SATA SSD
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thierry Vignaud" <tvignaud@redhat.com>, linux-ide@vger.kernel.org
Cc: dlemoal@kernel.org, cassel@kernel.org
In-Reply-To: <20261028124328.597603-1-tvignaud@redhat.com>
References: <[PATCH]> <ata:> <libata-core:> <Add> <quirks> <for> <PNY> <1TB>
 <SATA> <SSD> <916a> <20261028124328.597603-1-tvignaud@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 12:54:21 +0000
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Post: <mailto:linux-ide@vger.kernel.org>
List-Help: <mailto:linux-ide+help@vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-ide+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] ata: libata-core: overly broad 1.5Gbps and NONCQ quirks for PNY 1T=
B SATA SSD
--

commit 0d9a8ef67d5864f02d54ceedd7d99487c051f554
Author: Thierry Vignaud <tvignaud@redhat.com>

ata: libata-core: Add NOLPM quirk for PNY 1TB SATA SSD

This commit adds an entry to __ata_dev_quirks[] for the "PNY 1TB SATA SSD"
drive with ATA_QUIRK_NOLPM, ATA_QUIRK_1_5_GBPS, and ATA_QUIRK_NONCQ across
all firmware revisions.

> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index dadcaf9ff4622..cf36f2638fab3 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -4398,6 +4398,11 @@ static const struct ata_dev_quirks_entry __ata_dev=
_quirks[] =3D {
>  	/* PNY CS900 (Phison PS3111-S11, DRAM-less) drops the link on DIPM */
>  	{ "PNY CS900 1TB SSD",		NULL,	ATA_QUIRK_NOLPM },
> =20
> +	/* PNY CS900 (variant) drops the link on DIPM and NCQ */
> +	{ "PNY 1TB SATA SSD",		NULL,	ATA_QUIRK_NOLPM |
> +						ATA_QUIRK_1_5_GBPS |
> +						ATA_QUIRK_NONCQ },

[Severity: High]
Could applying ATA_QUIRK_1_5_GBPS and ATA_QUIRK_NONCQ across all firmware
revisions (NULL) of "PNY 1TB SATA SSD" cause a severe performance regression
for other users of this drive?

During ata_dev_configure() -> ata_dev_quirks(), every "PNY 1TB SATA SSD" wi=
ll
match this entry regardless of firmware revision. In ata_do_link_spd_quirk(=
),
ATA_QUIRK_1_5_GBPS clamps the physical SATA link speed limit to 1.5 Gbps:

drivers/ata/libata-core.c:ata_do_link_spd_quirk() {
	if (dev->quirks & ATA_QUIRK_1_5_GBPS)
		target =3D 1;
	else
		return 0;

	target_limit =3D (1 << target) - 1;

	/* if already on stricter limit, no need to push further */
	if (plink->sata_spd_limit <=3D target_limit)
		return 0;

	plink->sata_spd_limit =3D target_limit;
}

Unlike ATA_QUIRK_NOLPM and ATA_QUIRK_NONCQ, force_tbl[] has no on/off entry
for ATA_QUIRK_1_5_GBPS, so users with working drives cannot override this
1.5 Gbps cap via libata.force. Meanwhile, ata_dev_config_ncq() also disables
NCQ completely when ATA_QUIRK_NONCQ is set.

Additionally, the commit title and opening description state:

  For a year, I workaround it by disabling NCQ & reducing the speed by
  booting with "libata.force=3D0:3.0Gbps,0:noncq".
  It turns out disabling LPM fixes it without the huge performance hit.

while the embedded "v2:" changelog notes and the code itself instead drop t=
he
speed to 1.5 Gbps, disable NCQ, and remove the firmware revision filter, and
the code comment above the entry does not mention the 1.5 Gbps limit.

Note also that in ata_port_alloc(), port IDs (ap->print_id) are allocated
starting at 1:

drivers/ata/libata-core.c:ata_port_alloc() {
	id =3D ida_alloc_min(&ata_ida, 1, GFP_KERNEL);
	if (id < 0) {
		kfree(ap);
		return NULL;
	}
	ap->print_id =3D id;
}

Because port numbering starts at 1, "libata.force=3D0:3.0Gbps,0:noncq" never
matched any port in ata_force_link_limits() or ata_force_quirks(), which ma=
tches
the commit message logs on sda still showing queued commands (tag#2 through
tag#9).

If a specific drive requires 1.5 Gbps, no NCQ, and no LPM simultaneously to
avoid link timeouts, could that indicate a local cable, controller, or hard=
ware
unit issue rather than a quirk that should be applied unconditionally to all
"PNY 1TB SATA SSD" drives and firmware revisions?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261028124328.5976=
03-1-tvignaud@redhat.com?part=3D1
