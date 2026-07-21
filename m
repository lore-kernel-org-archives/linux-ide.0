Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587501B4F09
	for <linux-ide@vger.kernel.org>; Tue, 21 Jul 2026 00:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784592761; cv=none; b=eZtgdIJUT1ALGP90B6EKeLqx+RYcTvsv82DJ4nTdd9Y1ieE356uTCGCsKzYjubsb2YjffHqYnuFDvaEZGdTz/WERQLRQcfufbJrU36TGEMzT6lLcOSvDKAaV3JsmzyvImSvBJ4AW1Q7cu5iMXS+eqofRdkkgXq8nEaj0YuHTCus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784592761; c=relaxed/simple;
	bh=R5bM8WxylgG5QmM6dCcPx8az6tf9YVcvML4ibK+r1YA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TnUa4hds+OmcHx/mGdTvyn+qG1PGtIl7JvbWfi1y8xIveNu86kyYdW69sp0Ve85qAjm4ic2xUexZRXsAtJXHAd07eWYxnGgIyjl+hX01557kDl3k4NcRcTQGehjBIMiour5NX5yPXZWU2SsuYZG3O+1x8Kjhnx36EowsCkZrgws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l7P+N8qX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l7P+N8qX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CD4B1F000E9;
	Tue, 21 Jul 2026 00:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784592758;
	bh=rf03fdnum5v00SaYmzJ9Zv3t3wxz6oKi8s9jtdYhpYA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=l7P+N8qXsrGcYqjBv7fhlVuA9J/UG2WgLAUnagNU2nsTn4EYyzRvGXsZHkZbey2tb
	 G0G5TQeDrgiVoxo90ewWOut8Wa8Z3AmqVhxzuaXSS+r4YhlK8bR61a04C2WIHeOwp5
	 tlsAYnH8Fz2hQHgC+w7lGuPSiIZo7n0u4MPPXN4FHsavK2uQAqI3336yIDTHjVzhV+
	 OIx8l+eyeSCy4pRa5Jfa2mN+erMifGioYju6OlbsKqgcORE6YPCheQ3gTQXPnHgUYs
	 8cMg5upEWB8emzC1S18lh6lLESHI2Sw3xieQF5c92F0eoJFc7JbKiZCkscCRvRB11Q
	 Tr/HnX/nA9TyA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCHv2] ata: pata_ep93xx: add missing "cc" clobber to inline
 asm
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rosen Penev" <rosenp@gmail.com>
Cc: linux-ide@vger.kernel.org, dlemoal@kernel.org, cassel@kernel.org
In-Reply-To: <20260720235952.1334318-1-rosenp@gmail.com>
References: <20260720235952.1334318-1-rosenp@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 00:12:38 +0000
Message-Id: <20260721001238.8CD4B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Trailing byte transfers in `ep93xx_pata_data_xfer()` silently =
corrupt data on big-endian systems due to incorrect endian swapping and var=
iable truncation. For READ, the code assigns the 16-bit swapped result of `=
cpu_to_le16(ep93xx_pata_read_data(...))` to `*pad`, which is an 8-bit `unsi=
gned char`. This truncates the 16-bit value. On big-endian systems, `cpu_to=
_le16()` swaps the bytes, so this truncation discards the lower byte (the c=
orrect data from the bus) and saves the upper byte to the buffer. For WRITE=
, `le16_to_cpu(*pad)` promotes the 8-bit byte to an integer before swapping=
 it, resulting in a shifted 16-bit value, which causes the device to receiv=
e corrupted data on the wrong data lines.
- [High] The inline assembly delay loop `ep93xx_pata_delay()` lacks a `"mem=
ory"` clobber, permitting the compiler to reorder it with respect to I/O ac=
cesses, which violates ATA PIO timing requirements. On older ARM architectu=
res like ARMv4T (used in EP93xx) where `CONFIG_ARM_DMA_MEM_BUFFERABLE` is n=
ot selected, the standard I/O macros (`__iormb()` and `__iowmb()`) evaluate=
 to empty, meaning `writel()` and `readl()` provide no compiler memory barr=
iers at all. Because `__raw_readl()` and `__raw_writel()` are implemented u=
sing `asm volatile` without `"memory"` clobbers, GCC's instruction schedule=
r is completely free to reorder these volatile I/O accesses across the `ep9=
3xx_pata_delay()` loop. Even if memory barriers were present after the read=
 or before the write, the `asm volatile` instructions themselves lack depen=
dencies and can be swapped.
--

--- Patch [1]: [PATCHv2] ata: pata_ep93xx: add missing "cc" clobber to inli=
ne asm ---
commit e8afdf774c87485ee82a0fe97b982fc47fc827bc
Author: Rosen Penev <rosenp@gmail.com>

ata: pata_ep93xx: add missing "cc" clobber to inline asm

This commit adds a missing cc clobber to the inline assembly in
ep93xx_pata_delay() to prevent the compiler from reordering flag-dependent
instructions.

> diff --git a/drivers/ata/pata_ep93xx.c b/drivers/ata/pata_ep93xx.c
> index 42a24dc51d26b..0bb748a86ac6e 100644
> --- a/drivers/ata/pata_ep93xx.c
> +++ b/drivers/ata/pata_ep93xx.c
> @@ -211,6 +211,7 @@ static void ep93xx_pata_delay(unsigned long count)
>  		"bge 0b\n"
>  		: "=3Dr" (count)
>  		: "0" (count)
> +		: "cc"

[Severity: High]
This isn't a bug introduced by this patch, but since you are updating the
clobbers in ep93xx_pata_delay(), should this inline assembly also include a
"memory" clobber?

On older ARM architectures like ARMv4T used in EP93xx, standard I/O macros
can evaluate to empty, providing no compiler memory barriers.=20

Without a memory clobber here, the compiler optimizer might be free to
reorder independent I/O accesses across this delay loop, which could violate
ATA PIO timing requirements.

>  	);
>  #else
>  	while (count--)

[ ... ]

[Severity: Critical]
This is a pre-existing issue in the same file, but could the trailing byte
transfers in ep93xx_pata_data_xfer() silently corrupt data on big-endian
systems due to truncation?

For READ transfers, the code assigns a swapped value to an 8-bit variable:

drivers/ata/pata_ep93xx.c:ep93xx_pata_data_xfer() {
    ...
    *pad =3D cpu_to_le16(ep93xx_pata_read_data(drv_data, IDECTRL_ADDR_DATA)=
);
    ...
}

Since pad is an unsigned char pointer, this truncates the 16-bit swapped
result. On big-endian systems, cpu_to_le16() swaps the bytes, so truncating
it to 8 bits discards the lower byte containing the correct data and saves
the upper byte instead.

Similarly for WRITE transfers:

drivers/ata/pata_ep93xx.c:ep93xx_pata_data_xfer() {
    ...
    ep93xx_pata_write_data(drv_data, le16_to_cpu(*pad), IDECTRL_ADDR_DATA);
    ...
}

Promoting the 8-bit pad value to an integer before swapping it on a
big-endian system seems to shift the byte to the wrong data lines, sending
corrupted data to the device.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720235952.1334=
318-1-rosenp@gmail.com?part=3D1
