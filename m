Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793703914;
	b=R+T1GGu1W4RPJPVpPnxXxpYlFNDN8FHxI5MxKh1igAEY/jJdo9Ge4Qrw2CxXQ0Pb1JqY
	 Xa/DKJ+uS/jEL4rAgSlMYj2ncJvpC6quoa2/ov7MFTryjXWR9F/6Ti+BTjnfTZCuNlXHw
	 Rok6T3/EeR5gtTFPfZQEaQUsITeQlCl0bATaQPgiEWyTL5tIbRk+aKJsfQXTNrY9sIrlE
	 7N4t0mBOxvkY65lBozeN6FGla0tiAZ0gR0jWIv9MTQN2ODkt3PyX+yuxnAdMp/l0fgLmz
	 qUMsf0hDX6Dm+RsMaWZgTbb3CYtji/P+QsGsxmt4yj6uLCqkUJWWkQpalm1yiFo880A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793703914;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=z3H4Ww65n9OSywA4AGfHx8GXMfzLBT2T0dIKlDJr2xU=;
	b=OmHJBhydsnqRH5k4SXkN5U2C19+eoeWgIzKA9dX5z00MElBVZicTp9xT7s/Pt72fVKY0
	 T3Jr7+0EV24Tg6nxy8972/7Ni9rpGPoH/Mme/M18Kp8SScI4MEhJTBPv06pZInpdTGCBI
	 t0YYzjMCyRyX11pClnTDekRLbzv0xiyk87mUPm5gu/k/pexUzpp7cEBEFXZuHKx+w5PtZ
	 SoM4NEqsPdV4innDyR2aldNihX/Fvv/h0++0wMTVLg8HqWSr6l28aC+d8ByHjrYUkMb8K
	 j0iqzXz+8/u+uPwu2fzgjyJQuFBDKt9sDH+5K3h79xlT6vSSTHQfrykdc1edZu7XelQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OQ2purFi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359B9606D80F
	for <linux-ide@vger.kernel.org>; Tue,  3 Nov 2026 11:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OQ2purFi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA5A41F000C1;
	Tue,  3 Nov 2026 11:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793703914;
	bh=z3H4Ww65n9OSywA4AGfHx8GXMfzLBT2T0dIKlDJr2xU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OQ2purFiK9OsczzIUGmlDFppXzgxhvqkjsruMlQswHVM/Sb6NSI6V88VINa1i3psu
	 Tggwbl2LAp+Wy82SErrxBv3yhCknatQv8QvgTyRAcYizy00odnUhqmt8A1h11OdE6r
	 vlEOQu+nsbhBxdw6vlFZiVQyMsgviZSJaKr38A18fdme8Ut471VIWpd1Jb+DGFnG7D
	 ok7yXy7wg+RoMXhCj2F+9GTxFYTI1ORy0fBf3fyetX8sB/Mgp0I1WAxeK/Sfhm2c9t
	 d5mWbAlnaxKJkcP7HLwqS8qAmyA8eMDFCU4Ho0xn9BGUkrJPp7POXw33CivJtIT7q/
	 8tCnJd80cXGUw==
Message-ID: <sashiko-outbox-195104@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] ata: libata-scsi: avoid READ CAPACITY 16 underflow
Reply-To: sashiko-reviews@lists.linux.dev
To: shao.mingyin@zte.com.cn, linux-ide@vger.kernel.org
Cc: dlemoal@kernel.org, cassel@kernel.org
In-Reply-To: <20261103185346937YqEZr3t5lq7FdnTzM3-TY@zte.com.cn>
References: <20261103185346937YqEZr3t5lq7FdnTzM3-TY@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 11:05:13 +0000
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
- [High] ata: libata-scsi: ata_scsiop_read_cap() reports 1 block when n_sec=
tors is 0
--

commit 2baef3c64e10a35b658037f12f8a9575c158e978
Author: shao.mingyin@zte.com.cn <shao.mingyin@zte.com.cn>

ata: libata-scsi: avoid READ CAPACITY 16 underflow

This commit updates ata_scsiop_read_cap() to set last_lba to 0 instead of
underflowing dev->n_sectors - 1 when dev->n_sectors is zero, such as on
security-locked drives.

> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index a61fb03312793..eaf86dc2cefc0 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
> @@ -2984,7 +2984,7 @@ static unsigned int ata_scsiop_read_cap(struct ata_=
device *dev,
>  					struct scsi_cmnd *cmd, u8 *rbuf)
>  {
>  	u8 *scsicmd =3D cmd->cmnd;
> -	u64 last_lba =3D dev->n_sectors - 1; /* LBA of the last block */
> +	u64 last_lba =3D dev->n_sectors ? dev->n_sectors - 1 : 0; /* LBA of the=
 last block */

[Severity: High]
Does setting last_lba to 0 when dev->n_sectors is 0 cause the SCSI disk
driver to report a capacity of 1 block instead of 0 blocks?

In the SCSI READ CAPACITY (10) and READ CAPACITY (16) parameter data, the
returned logical block address is the 0-based LBA of the last logical block
on the medium (capacity - 1), so returning 0 indicates that LBA 0 is a valid
block on a 1-block disk.

When sd_revalidate_disk() -> sd_read_capacity() calls read_capacity_16() or
read_capacity_10() in drivers/scsi/sd.c, both functions add 1 to the
returned LBA:

drivers/scsi/sd.c:read_capacity_16() {
	...
	lba =3D get_unaligned_be64(&buffer[0]);
	...
	sdkp->capacity =3D lba + 1;
}

Previously, when dev->n_sectors was 0, last_lba underflowed to
0xffffffffffffffffULL, and lba + 1 in read_capacity_16() wrapped around in
64-bit unsigned arithmetic to set sdkp->capacity =3D 0.

With last_lba set to 0, sdkp->capacity becomes 1, and sd_revalidate_disk()
sets a non-zero gendisk capacity via set_capacity_and_notify(). In
drivers/ata/libata-core.c, ata_dev_configure() sets dev->n_sectors =3D 0 on
security-locked drives specifically to prevent partition scanning:

drivers/ata/libata-core.c:ata_dev_configure() {
	...
		if (ata_id_is_locked(id)) {
			/*
			 * If Security locked, set capacity to zero to prevent
			 * any I/O, e.g. partition scanning, as any I/O to a
			 * locked drive will result in user visible errors.
			 */
			ata_dev_info(dev,
				"Security locked, setting capacity to zero\n");
			dev->n_sectors =3D 0;
		}
}

Because bdev_disk_changed() in block/partitions/core.c checks
if (get_capacity(disk)) before calling blk_add_partitions(disk), won't a
reported capacity of 1 block cause the block layer to issue partition-scan
reads to LBA 0 on security-locked drives, resulting in I/O errors?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103185346937Yq=
EZr3t5lq7FdnTzM3-TY@zte.com.cn?part=3D1
