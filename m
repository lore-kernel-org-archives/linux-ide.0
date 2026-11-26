Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795670649;
	b=itrdMhqM58KBY/QnRNseLDydI9d/VXsjC2HL/9vsTEa6Vu3Em0qBjiid+JSFZcbwZj56
	 DruFwNs0+Ormmgap+4pSb4vtQQMphtoEjMs0KwU90e93oD9FMDYyJmV8yqo79sPmz+jli
	 L/X6GjE0BX4MFqTdsQN+LWmPLhoi+gNCgjHAdHJWOx7Zq726/YPJIXZBGLyVgp+1yRKSs
	 R5YhGgjidwCBsaNg93A5Gt6xp0CEDRccBE6pULvd79+AKWAxskfdNLf1wEbDdFsqr6p9V
	 v3nNUEC403ymYQ7KX+gDQBarP+amjzPDYZrXLq7OSgepcVW8IW8U3NBz97n76EwPr6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795670649;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=JR5T89mU7I97fJYjfRglnpy96ReWCzZY7COjw/E/keE=;
	b=RGb9rN75zuebZ4+AAnWXAhF9TR0K0HUaZfcjs3SqbyZRYyjLlG+mMo/RvPCOiv+nc/4n
	 ijPAoFEv48dz7Jdpzer5DM118s3bGUB1IGLM71EGfPtYh03Ia1KbJYYZgpwZvOxfqk9tX
	 c1uRGbZKv1oSzTNoaZov6HjXoQQzTgkF7VUZRWy41pqxcYsJuRzWJ3QF8sMR7nm62GqUD
	 ZjHEWu9IdF/a+7EVfBA0R1VAPvVANWpvJe2exoCd9IDjVjVdqyP8ARdVhCI1NFLC/GsWL
	 Vr2TOIXCQQgmazrNviH4Ysl3TdeVjITzPnt5J3jpewizWVzEPagp4Qh/OtiIE+s84nA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L4k2BHM8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59E9606A31C
	for <linux-ide@vger.kernel.org>; Thu, 26 Nov 2026 05:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L4k2BHM8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B05871F000C0;
	Thu, 26 Nov 2026 05:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795670648;
	bh=JR5T89mU7I97fJYjfRglnpy96ReWCzZY7COjw/E/keE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=L4k2BHM8IUPyM0bxRB6TTuj9OVmvVMYoltJQ8BgcxUkKe6ZpaERVwOJWZSTuUZHJH
	 uWowJvus32rfbz+EQuf/QgHic8B9tgVi4Hd0CBWyDn1c29zAmCFv+SsAhv2fdCwuHH
	 TpbacWxZmC46Bs1aB603D/j2kfxBMcky25I1tiHqslmYzz84t2Qa85nTMcbJYwU5e/
	 3qdEAEUhAzs5rYbpIFH3nsY0V4nzXbisfAi4x4Ps9sS093HrwhqifrzL/AC4Kvl+zm
	 BY17s44YNfnZxrURhJ1MRRqEFWGpThaE5G4EZerbqqL79S9CW26vsvCINcr4nvOaJy
	 xc0qK5rRRgGHA==
Message-ID: <sashiko-outbox-234781@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/4] ata: sata_dwc_460ex: add missing newlines to error
 messages
Reply-To: sashiko-reviews@lists.linux.dev
To: "Artem Novak" <artem122novak@gmail.com>
Cc: linux-ide@vger.kernel.org, dlemoal@kernel.org, cassel@kernel.org
In-Reply-To: <20261126051523.14431-4-artem122novak@gmail.com>
References: <20261126051523.14431-1-artem122novak@gmail.com>
 <20261126051523.14431-4-artem122novak@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 05:24:08 +0000
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Post: <mailto:linux-ide@vger.kernel.org>
List-Help: <mailto:linux-ide+help@vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-ide+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] ata: sata_dwc_460ex: missing trailing newline in
  sata_dwc_error_intr()
--

commit e320508318c2ef9123f949386b3a88f44a470ebe
Author: Artem Novak <artem122novak@gmail.com>

ata: sata_dwc_460ex: add missing newlines to error messages

This commit adds missing trailing newlines to error messages in
sata_dwc_isr(), sata_dwc_dma_xfer_complete(), and sata_dwc_probe().

> diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.c
> index 486ea94a0184b..f1237bb20a4aa 100644
> --- a/drivers/ata/sata_dwc_460ex.c
> +++ b/drivers/ata/sata_dwc_460ex.c
> @@ -498,7 +498,7 @@ static irqreturn_t sata_dwc_isr(int irq, void *dev_in=
stance)
> =20
>  		qc =3D ata_qc_from_tag(ap, tag);
>  		if (unlikely(!qc)) {
> -			dev_err(ap->dev, "failed to get qc");
> +			dev_err(ap->dev, "failed to get qc\n");
>  			handled =3D 1;
>  			goto DONE;
>  		}

[Severity: Low]
Should the dev_err() call in sata_dwc_error_intr(), which is called from
sata_dwc_isr() on error interrupts, also have a trailing newline added?

drivers/ata/sata_dwc_460ex.c:sata_dwc_error_intr() {
    ...
	dev_err(ap->dev,
		"%s SCR_ERROR=3D0x%08x intpr=3D0x%08x status=3D0x%08x dma_intp=3D%d pendi=
ng=3D%d issued=3D%d",
		__func__, serror, intpr, status, hsdevp->dma_interrupt_count,
		hsdevp->dma_pending[tag], hsdevp->cmd_issued[tag]);
    ...
}

Without it, subsequent kernel log messages after a SATA error interrupt
will still be concatenated onto the same line.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261126051523.1443=
1-1-artem122novak@gmail.com?part=3D3
