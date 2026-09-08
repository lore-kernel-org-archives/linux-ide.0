Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E184C563FA2
	for <linux-ide@vger.kernel.org>; Tue,  8 Sep 2026 22:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788904952; cv=none; b=QXtLCHK8JcCb6WsBkT1oMw+B+NmCXihHTYKQsq35RvTZkTyCLJTsVbR4y0vM3K/NRbdsthVZ/p+sp+3EgFvkg47dzURUk/3m5a+abHp3qpnm0NC/JvsNXW32bDWyPOoBvI1XfbjYHRpaI+9o3p3mvy/YM4CyG7g+hItuK3nj1bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788904952; c=relaxed/simple;
	bh=C4nHoiu4d2CEdkBju3lsAfbWWnh/roo37bhkfDj4Hkw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PMaGTpl8f2s91z02B8gkavUH2GXActroSCsuJx/VsWWHrnbqdDIYqjUdm0ID0I2qRyXNKVzA2fGDhzhNv3jtG3TsQu++eAczhco9M+zbLIDD3eGlZgtXtw6k4u46VSrgvTJliHFIGMNAVf0WiY9LIOWZJLOFoCUJUZjbaWm/OJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TVmAGpqK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TVmAGpqK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0DE11F00A3D;
	Tue,  8 Sep 2026 22:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788904949;
	bh=EAJlhESiJZWB2gxmVn/vjSkmQEvzlx481KD3tqcX884=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TVmAGpqKFlBwuZU+KDCvM/950RwOrTJsS6XTRRyYVMJcdUi6CoidPb+VFWSGJBikm
	 kO72xfXr3TQXTKWWf2/qWxynhFon7cCl/ChM1UX3k+R/gBK5b4t5uP27BoHxjjx9N1
	 h7Qvmm69w4DCyC5+XKOCnZWrpM7HwG51W6hRsN3JSBFknWdRtnqXKZP9trhMSO2btR
	 qbe55hlP7F+/66f//8s4tdZ0OOF65+bKPudB4KxRFEkcswxe4WDfVUd+bdsYKxfGXF
	 G21qO2RR6ym7b7CZJbAxgxJ1wp7hXFc7+Zxeka6wLuR/LUyMO7fdRB1X+ATPNEupxL
	 P/z4o1mra36HQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCHv2] ata: sata_dwc_460ex: preserve sactive_issued state
 across ISR invocations
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rosen Penev" <rosenp@gmail.com>
Cc: cassel@kernel.org, dlemoal@kernel.org, linux-ide@vger.kernel.org
In-Reply-To: <20260908214536.598823-1-rosenp@gmail.com>
References: <20260908214536.598823-1-rosenp@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 22:02:28 +0000
Message-Id: <20260908220228.B0DE11F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [Critical] Preserving `sactive_issued` across ISR invocations causes repe=
ated re-processing of completed DEV phases, prematurely completing NCQ comm=
ands.
- [High] NCQ DMAC interrupts are dropped when arriving before DEV interrupt=
s, causing hangs.
- [High] Missing cleanup of `sactive_issued` for stale tags leads to infini=
te log spam and permanently breaks subsequent non-NCQ commands.

Pre-existing issues:
- [High] Out-of-bounds heap read when `ap->link.active_tag` is `ATA_TAG_POI=
SON`.
--

commit 7a3914f790a5ca1a682aa2a68e7936ab121bdb65
Author: Rosen Penev <rosenp@gmail.com>

ata: sata_dwc_460ex: preserve sactive_issued state across ISR invocations

This patch stops zeroing hsdev->sactive_issued on every ISR entry to=20
preserve NCQ tag tracking across interrupts. It also updates the NCQ/non-NC=
Q=20
discrimination logic to prevent completion processing when tag_mask is zero=
=20
but the active command is NCQ.

> diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.c
> index 8e3fc713891af..a8eec3dc7eb17 100644
> --- a/drivers/ata/sata_dwc_460ex.c
> +++ b/drivers/ata/sata_dwc_460ex.c
[ ... ]
> @@ -517,8 +516,11 @@ static irqreturn_t sata_dwc_isr(int irq, void *dev_i=
nstance)
>  	sata_dwc_scr_read(&ap->link, SCR_ACTIVE, &sactive);
>  	tag_mask =3D (hsdev->sactive_issued | sactive) ^ sactive;
> =20
> -	/* If no sactive issued and tag_mask is zero then this is not NCQ */
> -	if (hsdev->sactive_issued =3D=3D 0 && tag_mask =3D=3D 0) {
> +	/*
> +	 * If tag_mask is zero and the active command is not NCQ this is a
> +	 * non-NCQ completion.
> +	 */
> +	if (tag_mask =3D=3D 0) {
>  		if (ap->link.active_tag =3D=3D ATA_TAG_POISON)
>  			tag =3D 0;
>  		else

[Severity: High]
This is a pre-existing issue, but since you are checking for ATA_TAG_POISON
here, I noticed that sata_dwc_error_intr() doesn't seem to do this.

When an error interrupt fires while no command is active, active_tag is
ATA_TAG_POISON (253). Does this out-of-bounds heap read leak memory into the
kernel log?

drivers/ata/sata_dwc_460ex.c:sata_dwc_error_intr() {
    ...
    tag =3D ap->link.active_tag;

    dev_err(ap->dev,
        "... pending=3D%d issued=3D%d",
        ..., hsdevp->dma_pending[tag], hsdevp->cmd_issued[tag]);
    ...
}

> @@ -534,6 +536,12 @@ static irqreturn_t sata_dwc_isr(int irq, void *dev_i=
nstance)
>  			handled =3D 1;
>  			goto DONE;
>  		}
> +		if (ata_is_ncq(qc->tf.protocol)) {
> +			/* NCQ commands still in flight; no tag completed. */
> +			ap->ops->sff_check_status(ap);
> +			handled =3D 1;
> +			goto DONE;
> +		}

[Severity: High]
Does this early exit path drop NCQ DMAC interrupts when they arrive before =
DEV
interrupts?

In SATA DMA transactions, the DMAC (transfer complete) interrupt can arrive
before the device sends the SDB FIS (DEV interrupt). When this happens,
sactive still matches sactive_issued, so tag_mask is 0.

By exiting early here, it appears dma_interrupt_count will not be increment=
ed
for the DMAC interrupt. When the DEV interrupt later arrives, the count will
only reach 1, potentially causing the NCQ command to permanently hang.

[ ... ]
> @@ -612,9 +620,9 @@ static irqreturn_t sata_dwc_isr(int irq, void *dev_in=
stance)
>  		tag_mask &=3D ~(1U << tag);
>  		qc =3D ata_qc_from_tag(ap, tag);
>  		if (unlikely(!qc)) {
> -			dev_err(ap->dev, "failed to get qc");
> -			handled =3D 1;
> -			goto DONE;
> +			dev_err(ap->dev, "stale tag %d in NCQ completion",
> +				tag);
> +			continue;
>  		}

[Severity: High]
Because sactive_issued is persistent across ISR invocations now, does skipp=
ing
cleanup here permanently break the port?

If continue is taken (e.g., from a spurious hardware interrupt with an inva=
lid
tag), the stale tag is never cleared from hsdev->sactive_issued. This seems
to cause tag_mask to evaluate to non-zero on all subsequent interrupts,
permanently breaking the non-NCQ early fallback path (which expects tag_mask
=3D=3D 0) and potentially causing endless log spam.

[Severity: Critical]
Since sactive_issued is no longer cleared on ISR entry, does this loop need
to clear the completed tags from hsdev->sactive_issued?

Because pending tags are not cleared from sactive_issued until they fully
complete, they appear to be repeatedly processed on subsequent interrupts. =
If
multiple NCQ tags are active, a DEV interrupt for Tag A increments the glob=
al
dma_interrupt_count to 1 but does not clear sactive_issued.

If a DEV interrupt for Tag B arrives next, tag_mask still contains Tag A. T=
he
loop processes Tag A again, increments the count to 2, and erroneously
completes Tag A before its DMAC interrupt arrives:

drivers/ata/sata_dwc_460ex.c:sata_dwc_isr() {
    ...
    if (ata_is_dma(qc->tf.protocol)) {
        hsdevp->dma_interrupt_count++;
        ...
        if ((hsdevp->dma_interrupt_count % 2) =3D=3D 0)
            sata_dwc_dma_xfer_complete(ap);
    ...
}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908214536.5988=
23-1-rosenp@gmail.com?part=3D1
