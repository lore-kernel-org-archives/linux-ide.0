Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8137B2D838E
	for <linux-ide@vger.kernel.org>; Sat, 10 Oct 2026 08:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791620213; cv=none; b=pPV0Ct95tE6EKYCGKctUDB+XfVkuygMr0G4QNpZ5Gdty39CnLB865/bef/NbVzKSIfYEXBr/exzrqPuSzZ/C0M6E+kkZifSNP7afidXJ+IZzIumFJPoXhciVB++8wbyKhjNnp+Oy7AFqsW8CXVCW4k8OWGkn5rHVPbZ4XktdPb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791620213; c=relaxed/simple;
	bh=SlZF8Id3gVIo+LgEKcGHFLWlD/WRNahZSFuXFalYff8=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=Ng9blSHEVSKv08UB4svis7Zx/YFtj6JTgg/I3miFBGawyy4ZCv7nMwc11sYzOLda4PHka4LbrVZoZDLHEXizdVr6K620yJEhv3ukykArs9gpYqGvcxT4Z0z2UVIJ6PBN8Gl30DLwFFnL0fnVSyNw1qcuzTYlDoAkjTU1bDeVC4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E07HMkv/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E07HMkv/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDAD31F000FF;
	Sat, 10 Oct 2026 08:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791620212;
	bh=lO6C7nmCKrD0jdAyJFBjeg2clUyKjSUjB6ZKrhp2GaU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=E07HMkv/Njdtdl2F6rgGZQsGcfp5EOPmYFhYsQ16IbFnaiYZrXsQS+ATbxUUtxpVU
	 cUs9Hi2XYpAWPhLsVw8gYaGnxsT0W3EmdoJKgF4hZTrVuiUeCSz15VBa+oW6ioz1Qr
	 2Z4XLRXRQ4VRlFKRQWsCqvT8TKK0PtH1GJ2govRhePwcfdMDyc7CgDVaWIDEuUpYro
	 jQBwtf3RLR1COMBbZXKOEjeS5A9eJHv6rx/8dt8nvG9CvgaderatPY+gcs242T2r8I
	 zrhhLZRSnDiTvPQIMdgqeJLV4rG9PuFANdiJJ3djw9eA8weDmJ4KgIeltvTtYQNvfH
	 NGChAZAZMeuWQ==
Message-ID: <sashiko-outbox-166329@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] ata: libata: preserve sata_spd link cache across
 ata_dev_init
Reply-To: sashiko-reviews@lists.linux.dev
To: tongzhiwei <tongzhiwei@cmss.chinamobile.com>
Cc: dlemoal@kernel.org, linux-ide@vger.kernel.org, cassel@kernel.org
In-Reply-To: <20261010075457.882-1-tongzhiwei@cmss.chinamobile.com>
References: <20261010075457.882-1-tongzhiwei@cmss.chinamobile.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 10 Oct 2026 08:16:51 +0000
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] ata: state leakage of sata_spd across hotplugs breaks link speed d=
owngrade
- [Medium] ata: libata: sata_spd patch fails to prevent 1.5 Gbps speed drop=
 on replug
--

commit 2309da39e62c734fad9901e897e29150a0def7eb
Author: tongzhiwei <tongzhiwei@cmss.chinamobile.com>

ata: libata: preserve sata_spd link cache across ata_dev_init

This patch modifies ata_dev_init() to preserve the link->sata_spd cache
across device resets. The intent is to prevent the link speed limit from
being permanently lowered by failed probes when a device is unplugged and
later replugged.

> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 682c588897159..27217673fbb13 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -5659,7 +5659,7 @@ void ata_dev_init(struct ata_device *dev)
> =20
>  	/* SATA spd limit is bound to the attached device, reset together */
>  	link->sata_spd_limit =3D link->hw_sata_spd_limit;
> -	link->sata_spd =3D 0;
> +	/* link->sata_spd caches last negotiated link speed; not zeroed here */

[Severity: High]
Does preserving link->sata_spd here leak the old device's speed state to a
newly hotplugged device?

If a Gen1 SATA device is unplugged, link->sata_spd remains 1. If a Gen3
device is then plugged in, its link->sata_spd_limit is reset to Gen3 here.
If the new device fails to come online at Gen3, error handling calls
sata_down_spd_limit() which consumes this leaked state:

drivers/ata/libata-sata.c:sata_down_spd_limit() {
	...
	if (rc =3D=3D 0 && ata_sstatus_online(sstatus))
		spd =3D (sstatus >> 4) & 0xf;
	else
		spd =3D link->sata_spd;
	...
	if (spd > 1)
		mask &=3D (1 << (spd - 1)) - 1;
	else if (link->sata_spd)
		return -EINVAL;
	...
}

Could this return -EINVAL when spd is 1, and permanently prevent the limit
from being lowered to Gen2 for the new device, resulting in an infinite
loop of failed probes?

[Severity: Medium]
This problem wasn't introduced by this patch, but does this change actually
prevent the 1.5 Gbps speed drop on replug as intended?

The speed drop appears to be caused by dev->ering persisting across
ata_dev_init() because it is located after ATA_DEVICE_CLEAR_END in
struct ata_device. Probe failures during the unplug phase accumulate in
this uncleared ering.

When replugged, the accumulated errors cause ata_eh_schedule_probe() to
force the limit to 1.5 Gbps:

drivers/ata/libata-eh.c:ata_eh_schedule_probe() {
	...
	ata_dev_init(dev);
	...
	ata_ering_record(&dev->ering, 0, AC_ERR_OTHER);
	ata_ering_map(&dev->ering, ata_count_probe_trials_cb, &trials);

	if (trials > ATA_EH_PROBE_TRIALS)
		sata_down_spd_limit(link, 1);
	...
}

Does sata_down_spd_limit(link, 1) unconditionally force the limit to 1.5
Gbps regardless of whether link->sata_spd was preserved?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261010075457.882-=
1-tongzhiwei@cmss.chinamobile.com?part=3D1
