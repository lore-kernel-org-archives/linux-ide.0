Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3421A6816
	for <linux-ide@vger.kernel.org>; Thu, 23 Jul 2026 00:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784766682; cv=none; b=R/FQ/aSj4Sq3bjyAmN8D3uBoRftBCiu5fNEPfw3kvHF0JD5hB901G+t9QfkiiRhGfwlkxHkolbpWbQ09sMzupRozgBKZA7LhRrMDc1SB6IHOPKUgh2O8zT3/4cWXm9GUAkl17pw22JQvwfh2g0aUHLc4kQXJpsFbJVzjNR9j4+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784766682; c=relaxed/simple;
	bh=Q602p1UE56JAMD0qvZdvRE2cBPxHXCQ7ikPWgYZT1aA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MzJt+bnoPD09MNoo2eNZjGa3H6AdrE3FHwSKSKYQxwlgMzPPt82AipKBLssgHrSavKfp5FwshyiCULSZOWowtRlGr0VJl52U54jz5dOMtIAPooaCiuQIilvIy0JLOVzXTSMiPxBqa+XQ2GUbe1ysN/B85XrkOTFBTB88CgwjkfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L8t1GYGQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L8t1GYGQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 295581F000E9;
	Thu, 23 Jul 2026 00:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784766681;
	bh=P6EjpMbMVsMrsWYeiQ7Sc51saXA8KfkhCywkdkduFps=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=L8t1GYGQ8nder3nkdQ/iBewQjmv06cmq2C3wqf916hbNe1wlYFIxK70NDdNyybuj/
	 CYzdy0vnkJpQw4XAHSawEhBbl4FM4Q8qHu8oiA/S7dJtjfs5IroaMCMpHldxl6eP74
	 H56e+jnlNtotFE2aF0DNWaWtdwfzVIt/NzCzcQfq9fyQIQqixEn8Y8aoQLjWLLmFvo
	 OsUZaG1DCzc4cEWrJFEzLZzKxP4txlUEj3Q7hF7ohOIvk1SSj8Iu3zW1CLFW+DTcgQ
	 R2cAnm0JCnhT5TLx9FseeP0KvWZgiLJaN9x+9eW0EIpGQwniytyhGQmwkULjwJSIGu
	 /VuIcRVEKQQMA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] ata: sata_dwc_460ex: preserve sactive_issued state
 across ISR invocations
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rosen Penev" <rosenp@gmail.com>
Cc: dlemoal@kernel.org, cassel@kernel.org, linux-ide@vger.kernel.org
In-Reply-To: <20260723001208.1469323-4-rosenp@gmail.com>
References: <20260723001208.1469323-1-rosenp@gmail.com>
 <20260723001208.1469323-4-rosenp@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 00:31:20 +0000
Message-Id: <20260723003121.295581F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [Critical] Stale tags in `hsdev->sactive_issued` cause a permanent port l=
ockup after any command timeout.
- [High] Infinite re-processing of partially completed NCQ tags corrupts DM=
A interrupt tracking.
- [High] Time-Of-Check to Time-Of-Use race drops NCQ completions, causing c=
ommand timeouts.

Pre-existing issues:
- [Critical] Out-of-bounds array access in DMA callback when using multiple=
 NCQ tags.
--

--- Patch [3]: [PATCH 3/3] ata: sata_dwc_460ex: preserve sactive_issued sta=
te across ISR invocations ---
commit 2d2c8f6bc7683fcd41033d9263799c80943fc1d0
Author: Rosen Penev <rosenp@gmail.com>

ata: sata_dwc_460ex: preserve sactive_issued state across ISR invocations

Zeroing hsdev->sactive_issued on every ISR entry destroys the NCQ tag
tracking that must persist across interrupts. This field is populated
in the NEWFP (DMA Setup FIS) handler and used in subsequent DMAT (DMA
Transfer Complete) interrupts to determine which tags have completed.

> diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.c
> index 73bacdfd0bd31..025b5d968c780 100644
> --- a/drivers/ata/sata_dwc_460ex.c
> +++ b/drivers/ata/sata_dwc_460ex.c
> @@ -467,7 +467,6 @@ static irqreturn_t sata_dwc_isr(int irq, void *dev_in=
stance)
>  	struct sata_dwc_device_port *hsdevp;
> =20
>  	spin_lock_irqsave(&host->lock, flags);
> -	hsdev->sactive_issued =3D 0;

[Severity: Critical]
Since sactive_issued is no longer cleared here, does it accumulate stale ta=
gs?

If a tag completes and is never cleared from hsdev->sactive_issued, it could
trigger a permanent port lockup after any command timeout. The ISR loop wou=
ld
process the stale tag:

drivers/ata/sata_dwc_460ex.c:sata_dwc_isr() {
    ...
    while (tag_mask) {
        tag =3D __ffs(tag_mask);
        tag_mask &=3D ~(1U << tag);
        qc =3D ata_qc_from_tag(ap, tag);
        if (unlikely(!qc)) {
            dev_err(ap->dev, "failed to get qc");
            handled =3D 1;
            goto DONE;
        }
    ...
}

Will encountering a stale tag cause ata_qc_from_tag() to return NULL, hitti=
ng
this unlikely(!qc) path, and permanently drop all valid completions?

[ ... ]
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
Does this create a Time-Of-Check to Time-Of-Use race?

By clearing the host interrupt with ap->ops->sff_check_status(ap) and
immediately jumping to DONE without re-evaluating SCR_ACTIVE, could this
silently drop NCQ completions that arrived just after the earlier SCR_ACTIVE
read, resulting in command timeouts?

[ ... ]

[Severity: High]
Does the ISR continually re-process partially completed NCQ tags?

drivers/ata/sata_dwc_460ex.c:sata_dwc_isr() {
    ...
    if (ata_is_dma(qc->tf.protocol)) {
        hsdevp->dma_interrupt_count++;
        ...
        if ((hsdevp->dma_interrupt_count % 2) =3D=3D 0)
            sata_dwc_dma_xfer_complete(ap);
    ...
}

If the DMA transfer isn't complete, it fails to clear the tag from the
tracking state. Will this asymmetric clearing routine force the ISR to
continually pop and double-increment the same tag on subsequent interrupts,
corrupting the DMA interrupt tracking?

[Severity: Critical]
This is a pre-existing issue, but does using the scalar ap->link.active_tag
in concurrent NCQ environments cause an out-of-bounds array access?

drivers/ata/sata_dwc_460ex.c:dma_dwc_xfer_done() {
    ...
    tag =3D ap->link.active_tag;
    ...
    sata_dwc_clear_dmacr(hsdevp, tag);
}

drivers/ata/sata_dwc_460ex.c:sata_dwc_clear_dmacr() {
    ...
    if (hsdevp->dma_pending[tag] =3D=3D SATA_DWC_DMA_PENDING_RX) {
    ...
}

When using multiple NCQ tags, ap->link.active_tag can be ATA_TAG_POISON
which has a value of 253. Will this evaluate an out-of-bounds index of 253
and execute an invalid memory read or write?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723001208.1469=
323-1-rosenp@gmail.com?part=3D3
