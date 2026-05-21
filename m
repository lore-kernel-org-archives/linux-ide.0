Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0982250BEC
	for <linux-ide@vger.kernel.org>; Thu, 21 May 2026 20:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779395886; cv=none; b=BFgxCqYKlaDufkgzzNYfLBaGjbLle4/BmNJieq/WJ+FXSvLqtJVTSjxoUcvnnWgJVGn/yNLG0wJB25ENlqdRjheCu6TtEWyQ0NmiQJpcuBLkKhHmBPoyUKtynsWPef/x0wj77DjMSnzblEiXmwlGiUcrPabDkCqP98lzGlycKtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779395886; c=relaxed/simple;
	bh=wAC9yoipWOxjv0drVoCMlUC6gdgSueQnnx/cP/gbb/4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RpFOtc9+1OKj/qHBoRfpPI2ntSehasOPJczb2Xpre214wEjG7eSd6VDdLcRHW/Fh+m6j/NEhXSWaLCj5QZuWrPAQvnY6GfXYk4wpKXo+GhJe7yr0ji9Y/cwEyAnSNJGwcktd/p+tiHDeLjrlo6JcClh2N9UXS4E0DBiFZymw+m8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g13UDb5b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g13UDb5b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3F2B1F000E9;
	Thu, 21 May 2026 20:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779395884;
	bh=cJeGOaP0ooGUhz22l6+zoCZpvnb1P9ZBpphJLQCbsDY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=g13UDb5b41jRj8/9IPkmyDdnjX71Skbtno7up2HDxjDsK4GbIVX1z2Hou+Ddxu9KW
	 /bG7CD7qnebhMSqNwdfz3aEJr4DM/WhXxjnFfw8IS9oiwQoGaW06te7aIHpCV7Fuzs
	 Y7Mbxrdn/p5ipxOa5HlgGcnXefZTm0tWD2Fd1toZYVeWUW97aSac+c4jg0cL/upzo5
	 zD3VVO2qWrTxdSsOIPkkFBCC1SAETD7lMY9sbceVJrEUQY6VGFq82vNreZeZXvIMDY
	 uVTRZYgsrevFBBuoFs9dr8pp91a9jAbkIR6ePdBQiKJb8g6cWHfyaw4tSekaZBBg9A
	 5rncRjhnoBIYA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 9/9] ata: Annotate the code that uses the host lock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bart Van Assche" <bvanassche@acm.org>
Cc: dlemoal@kernel.org, cassel@kernel.org, linux-ide@vger.kernel.org
In-Reply-To: <20260521173347.2079560-10-bvanassche@acm.org>
References: <20260521173347.2079560-10-bvanassche@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 21 May 2026 20:38:03 +0000
Message-Id: <20260521203803.B3F2B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] Evasion of static analysis through `__assume_ctx_lock` and dangero=
us TO DO comments.
- [Medium] The `qc_issue` annotation incorrectly takes the address of a loc=
k pointer, creating a double pointer.
- [Medium] Missing address-of operator in `__must_hold(host->lock)` annotat=
ions.
- [Medium] `ata_do_link_abort` asserts the wrong lock (`eh_mutex` instead o=
f the port lock).
- [Low] Misleading comment refers to `scsi_host` instead of `lock`.
--

commit 1c3594816cc461100251a14c8ea9e6b3febb1a63
Author: Bart Van Assche <bvanassche@acm.org>

ata: Annotate the code that uses the host lock

This commit adds __must_hold() annotations for functions requiring the host
lock, along with context assertions to help the compiler understand lock
equivalencies. It identifies missing locks in ata_port_freeze() and
nv_do_interrupt().

> diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
> --- a/drivers/ata/ahci.h
> +++ b/drivers/ata/ahci.h
[ ... ]
> @@ -450,7 +450,8 @@ void ahci_error_handler(struct ata_port *ap)
>  	__must_hold(&ap->host->eh_mutex);
> -u32 ahci_handle_port_intr(struct ata_host *host, u32 irq_masked);
> +u32 ahci_handle_port_intr(struct ata_host *host, u32 irq_masked)
> +	__must_hold(host->lock);

[Severity: Medium]
Since host->lock is an embedded struct (spinlock_t lock) rather than a
pointer, should this be __must_hold(&host->lock)? As written, passing the
struct by value might cause the static analyzer to fail when matching it
against spin_lock(&host->lock). This same pattern appears in
xgene_ahci_handle_broken_edge_irq, adma_intr_pkt, and other host->lock
annotations in this patch.

> diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
> --- a/drivers/ata/libata-eh.c
> +++ b/drivers/ata/libata-eh.c
[ ... ]
> @@ -1057,6 +1059,9 @@ static int ata_do_link_abort(struct ata_port *ap, s=
truct ata_link *link)
>  	/* include internal tag in iteration */
>  	ata_qc_for_each_with_internal(ap, qc, tag) {
>  		if (qc && (!link || qc->dev->link =3D=3D link)) {
> +			/* Tell the compiler that link->ap =3D=3D ap. */
> +			__assume_ctx_lock(&link->ap->host->eh_mutex);
> +
>  			qc->flags |=3D ATA_QCFLAG_EH;
>  			ata_qc_complete(ap, qc);

[Severity: Medium]
The comment indicates the intent is to assert that link->ap =3D=3D ap for t=
he
port lock, but the code asserts the sleepable eh_mutex is held instead.
Could this be a copy-paste error that will prevent the static analyzer from
verifying ap->lock for the inner ata_qc_complete() call?

> @@ -1149,6 +1154,9 @@ static void __ata_port_freeze(struct ata_port *ap)
>   */
>  int ata_port_freeze(struct ata_port *ap)
>  {
> +	/* TO DO: fix all callers of this function that do not hold ap->lock. */
> +	__assume_ctx_lock(ap->lock);
> +
>  	__ata_port_freeze(ap);

[Severity: High]
Does using __assume_ctx_lock() here and in nv_do_interrupt() to silence
static analysis warnings defeat the purpose of the locking annotations?
If there are missing locks, it might be safer to fix the actual locking
bugs or use __must_hold() to properly flag the missing lock context.

> diff --git a/drivers/ata/sata_nv.c b/drivers/ata/sata_nv.c
> --- a/drivers/ata/sata_nv.c
> +++ b/drivers/ata/sata_nv.c
[ ... ]
> @@ -1465,7 +1473,10 @@ static irqreturn_t nv_do_interrupt(struct ata_host=
 *host, u8 irq_stat)
>  {
>  	int i, handled =3D 0;
> =20
> +	/* TO DO: protect the code below with &host->lock. */
> +
>  	for (i =3D 0; i < host->n_ports; i++) {
> +		__assume_ctx_lock(host->ports[i]->lock);
>  		handled +=3D nv_host_intr(host->ports[i], irq_stat);
>  		irq_stat >>=3D NV_INT_PORT_SHIFT;
>  	}

[Severity: High]
If future developers follow this TO DO comment and add a lock acquisition
here, will it introduce a guaranteed hard deadlock? Existing callers like
nv_nf2_interrupt and nv_ck804_interrupt already hold host->lock before
calling this function, as it is a non-recursive spinlock.

> diff --git a/drivers/ata/sata_qstor.c b/drivers/ata/sata_qstor.c
> --- a/drivers/ata/sata_qstor.c
> +++ b/drivers/ata/sata_qstor.c
[ ... ]
> @@ -376,6 +381,11 @@ static inline unsigned int qs_intr_pkt(struct ata_ho=
st *host)
>  				continue;
>  			qc =3D ata_qc_from_tag(ap, ap->link.active_tag);
>  			if (qc && (!(qc->tf.flags & ATA_TFLAG_POLLING))) {
> +				/*
> +				 * Tell the compiler that qc->dev->link->ap->
> +				 * scsi_host =3D=3D host.
> +				 */
> +				__assume_ctx_lock(qc->dev->link->ap->lock);

[Severity: Low]
This isn't a bug, but the comment mentions scsi_host =3D=3D host while the
code asserts the lock context. Is this a leftover copy-paste from another
annotation?

> diff --git a/include/linux/libata.h b/include/linux/libata.h
> --- a/include/linux/libata.h
> +++ b/include/linux/libata.h
[ ... ]
> @@ -962,7 +962,8 @@ struct ata_port_operations {
>  	int (*qc_defer)(struct ata_queued_cmd *qc);
>  	int (*check_atapi_dma)(struct ata_queued_cmd *qc);
>  	enum ata_completion_errors (*qc_prep)(struct ata_queued_cmd *qc);
> -	unsigned int (*qc_issue)(struct ata_queued_cmd *qc);
> +	unsigned int (*qc_issue)(struct ata_queued_cmd *qc)
> +		__must_hold(&qc->dev->link->ap->lock);

[Severity: Medium]
Since ap->lock is already a pointer (spinlock_t *lock), does taking its
address with & here yield a spinlock_t **? This double pointer won't
match the lock context expression expected by the static analyzer when
spin_lock(ap->lock) is used. Should this be updated to drop the & operator?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260521173347.2079=
560-1-bvanassche@acm.org?part=3D9
