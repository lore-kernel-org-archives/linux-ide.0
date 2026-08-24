Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC4544C646
	for <linux-ide@vger.kernel.org>; Mon, 24 Aug 2026 15:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787586108; cv=none; b=G2O0PU4ObapJ1at6WoS1U7dauwa9DQchp2uj7W2dakqowTR5EW/O2aiXH6ug3RxsnIPTdY+2itYXEvdmujhsuVCCxl6NdT3EmLDBC1PH08OMmvhi2DG1j6mzInAvEDv0mHbKozhfZPn32K8ZYM2cIkkapr7rakU+y4mz/aZehsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787586108; c=relaxed/simple;
	bh=9+Yvygrt69lTrgUw/CKXaLqmcrRTgl6z3O2Fwft3FEc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tmdNWU43AtdTDpxh1z2Xlo2dP0znFrRdQW0LDh/JGdBJ8YI5peyBpeRnyB7lWlSIhhca/7LZUNNpNGKTtSXLHK6dq1kowrj7Qe9kPXVtjp3Baf8yCd0jfm1izuKZM0lFISo975BNsr1TnqsN/f4jOSTbVMFAPeot2ynUn/dQ3pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b5puhkId; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b5puhkId"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF46E1F00A3A;
	Mon, 24 Aug 2026 15:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787586101;
	bh=H+97iVxAK2H6DAMLYMrJCphUGAu7EDG4IKiMA23krDE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=b5puhkIdJSvOuw6t6vBnPuMxziE3hM9ho8i/B+0q33X38qncClz1szdvCIxF4CDq4
	 vFP8W291t7YguwH5cWBs7Kx2zLZn0ZFVLx3XIJF9XfUXv1VoOZ/XR6hXQIiKm4ouhv
	 4TTEzHUCkum589rRg6eeEMJ8N2xyYtKoURxi20tzMfJqhKHHgeERZdBgLqgnYP4/l7
	 MoxjyBQ3HtFBipo0UWpNzGaTgub+K0tvzqsLlqeokxcvjIvbLNw8BV/1hT3VcKKohj
	 2l47M19+YAp9Y6+tYHhuDIjMGTN1X4yDaYp+MR93fnNy52O9P04NlCqk2qPpjAjIIB
	 ocZSaeOcZAW4Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 2/2] m68k: defconfig: enable PATA_CSWARP
Reply-To: sashiko-reviews@lists.linux.dev
To: "Paolo Pisati" <p.pisati@gmail.com>
Cc: cassel@kernel.org, linux-ide@vger.kernel.org, dlemoal@kernel.org
In-Reply-To: <20260824153339.512487-3-p.pisati@gmail.com>
References: <20260824153339.512487-1-p.pisati@gmail.com>
 <20260824153339.512487-3-p.pisati@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 15:41:40 +0000
Message-Id: <20260824154140.CF46E1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Missing check for ioremap() failure in pata_cswarp_probe().
- [Medium] Missing iounmap() on the ata_host_activate() error path.
--

--- Patch [2]: [PATCH v5 2/2] m68k: defconfig: enable PATA_CSWARP ---
commit 50c3007b9ddccb0c0a488126c545810ad538a593
Author: Paolo Pisati <p.pisati@gmail.com>

ata: pata_cswarp: Add Amiga cslab ata support

This commit introduces the pata_cswarp driver to provide support for
the on-board IDE interface on the CS-Lab Warp Expansion Card.

> diff --git a/drivers/ata/pata_cswarp.c b/drivers/ata/pata_cswarp.c
> new file mode 100644
> index 0000000000000..55f000f427384
> --- /dev/null
> +++ b/drivers/ata/pata_cswarp.c
> @@ -0,0 +1,180 @@

[ ... ]

> +static int pata_cswarp_probe(struct zorro_dev *z,
> +			     const struct zorro_device_id *ent)
> +{

[ ... ]

> +	host =3D ata_host_alloc(&z->dev, 1);
> +	if (!host)
> +		return -ENXIO;
> +
> +	ap =3D host->ports[0];
> +	base =3D ioremap(board + WARP_OFFSET_ATA, 0x1800);
> +
> +	ap->ops =3D &pata_cswarp_ops;

[Severity: High]
Is it possible for ioremap() to fail and return a NULL pointer here?

If memory mapping fails during device probe, base would be NULL.

This NULL pointer is then used to calculate and assign various ATA port I/O
addresses (e.g., ap->ioaddr.error_addr =3D base + 1 * 4).

When the block layer or ATA framework later attempts to access these I/O
ports, will this result in a kernel panic due to an invalid pointer
dereference?

> +
> +	ap->pio_mask =3D ATA_PIO4;

[ ... ]

> +	ata_port_desc(ap, "  cmd 0x%lx ctl 0x%lx", (unsigned long)base,
> +		      (unsigned long)ap->ioaddr.ctl_addr);
> +
> +	return ata_host_activate(host, 0, NULL,
> +			  IRQF_SHARED, &pata_cswarp_sht);
> +}

[Severity: Medium]
Does this error path leak the I/O memory mapping?

If ata_host_activate() fails, it returns a non-zero error code which is
immediately returned by pata_cswarp_probe().

Since this driver uses manual memory mapping rather than devm_ioremap()
(as seen by the manual iounmap() call in pata_cswarp_remove()), should
iounmap(base) be called before returning the error?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824153339.5124=
87-1-p.pisati@gmail.com?part=3D2
