Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04AFC409E1B
	for <linux-ide@vger.kernel.org>; Thu, 21 May 2026 20:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779394628; cv=none; b=jt3pAXIPvRZPbQrbzM1ilJCa6raMOBeFGjTs7F4B612G8+GjGwKpWZjNphzcJ5FlSRhZq0b2m1vPHQGcRAImR4iWY+uIcHnzfi41y/sfjXgmZWIG24GYU4WjhbUSSD6OpBskeedeMc8M5cZXA6PHveFrbtazOhKXm5powtvX2M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779394628; c=relaxed/simple;
	bh=mNNToozIKSopKXxnyJJ//3Mv9xSeLgOHhBzH7Tyn72k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=G1XmJLz1D5KnisOotqSTGwhPS57/rruXLPV/6uCvVvSd8/5WghP81QdtfQddFkmMO0oh1O1b3BUkhjoWTyfE7YzVrKESGfxNob+mKO7IxiHxiA+klDVHt2AjUwtwBUO2ItwdIld6SmeX5sAHdplx9N4VIvOD8fXv3/uI3oOXZNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pr+7d8yj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pr+7d8yj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EBC71F000E9;
	Thu, 21 May 2026 20:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779394626;
	bh=WckLUuKPjedA60Pkfj4jbukFzMFxtySDN0mbJ+l1tcI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Pr+7d8yjgEl6ijbCyg3hY39qwUqLc6PS38DpdgURuGeLAr9J7N7ptDNtveI7NZ9/s
	 oRpjpB1q+enyU5AzLsnQtLqfqcCT1AqH/L3IyhS6hn8JsFFdQ9e/TlCTVSxARTVmtK
	 pGMJ5y0T4ksPWMLM5FYeJaa/hS0a1tz0T6KUlPDk9TmmMTARbhipOXlmOXNvsLgLSZ
	 8ZYVLQ7R3Ve/lgcYqtJBQqejNtTDb/wwaHOhEnusx62vTKhZxtSdv7lyL0S5G97GDl
	 axUlVZwgwz18Gaou2TNc+fG2N5nRvbHIe+PbhNBwAMQjRj2Dym2wj93y+zEeCFPvgy
	 JC9xdmlQeoCXQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 8/9] ata: libata: Enable context analysis
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bart Van Assche" <bvanassche@acm.org>
Cc: dlemoal@kernel.org, linux-ide@vger.kernel.org, cassel@kernel.org
In-Reply-To: <20260521173347.2079560-9-bvanassche@acm.org>
References: <20260521173347.2079560-9-bvanassche@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 21 May 2026 20:17:05 +0000
Message-Id: <20260521201706.5EBC71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

New issues:
- [High] The patch introduces incomplete or mismatched thread safety annota=
tions, which will cause compilation failures under Clang Context Analysis.
- [High] Adding `__assume_ctx_lock` inside a loop causes a lockset mismatch=
 compilation error.

Pre-existing issues:
- [High] `ata_port_freeze()` is called locklessly from `mv_pmp_error_handle=
r()`, which can corrupt the port's freeze state and race with other hardwar=
e state modifications.
- [High] `__ata_bmdma_stop()` and active command masks are accessed lockles=
sly in the NVIDIA SWNCQ error handler, leading to potential hardware and st=
ate corruption.
- [High] Promise and SX4 error handlers perform a lockless TOCTOU check of =
the port freeze state followed by an unprotected read-modify-write (RMW) on=
 the PDC_CTLSTAT hardware register.
--

commit 9cf4f2610433aecbb931b34a78ec27ff09ed3edb
Author: Bart Van Assche <bvanassche@acm.org>
Subject: ata: libata: Enable context analysis

This patch enables Clang's context analysis in the ATA subsystem to
catch locking bugs in error paths. It adds thread safety annotations
such as __must_hold and __assume_ctx_lock to various functions.

Link: https://lore.kernel.org/all/177926568868.711.3058599932884307249.tip-=
bot2@tip-bot2/

> diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
> index 7528831bb59a4..5930735bb901c 100644
> --- a/drivers/ata/libata-eh.c
> +++ b/drivers/ata/libata-eh.c
> @@ -3877,6 +3877,9 @@ int ata_eh_recover(struct ata_port *ap, struct ata_=
reset_operations *reset_ops,
>  	ata_for_each_link(link, ap, EDGE) {
>  		struct ata_eh_context *ehc =3D &link->eh_context;
> =20
> +		/* Tell the compiler that link->ap =3D=3D ap. */
> +		__assume_ctx_lock(&link->ap->host->eh_mutex);

[Severity: High]
Will adding this __assume_ctx_lock() inside a loop cause a lockset
mismatch compilation error?

Clang's context analysis expects the lockset at a loop header to match the
lockset at the loop back-edge. Since we are asserting the lock state inside
the loop without releasing it before the iteration ends, could this trigger
a lockset divergence warning that breaks the build?

>  		if (!(ehc->i.action & ATA_EH_RESET))
>  			continue;
> =20

[ ... ]

> diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
> index 84c1abd4d0ac4..ea10c12f449c7 100644
> --- a/drivers/ata/sata_mv.c
> +++ b/drivers/ata/sata_mv.c
> @@ -2398,6 +2398,7 @@ static struct ata_queued_cmd *mv_get_active_qc(stru=
ct ata_port *ap)
>  }
> =20
>  static void mv_pmp_error_handler(struct ata_port *ap)
> +	__must_hold(&ap->host->eh_mutex)
>  {
>  	unsigned int pmp, pmp_map;
>  	struct mv_port_priv *pp =3D ap->private_data;

[Severity: High]
This is a pre-existing issue, but does calling ata_port_freeze() locklessly
from mv_pmp_error_handler() risk corrupting the port's freeze state?

ata_port_freeze() modifies the port's internal state (ap->pflags) and
requires the host spinlock (ap->lock) to be held. Since
mv_pmp_error_handler() runs in the EH thread holding only the sleepable
eh_mutex, this lockless call could allow concurrent modification of
ap->pflags and command structures from interrupt handlers.

Should ata_eh_freeze_port(ap) be used here instead, as it acquires the
spinlock internally?

[ ... ]

> diff --git a/drivers/ata/sata_nv.c b/drivers/ata/sata_nv.c
> index 841e7de2bba6e..19b9270658686 100644
> --- a/drivers/ata/sata_nv.c
> +++ b/drivers/ata/sata_nv.c
> @@ -1795,6 +1796,7 @@ static void nv_swncq_ncq_stop(struct ata_port *ap)
>  }
> =20
>  static void nv_swncq_error_handler(struct ata_port *ap)
> +	__must_hold(&ap->host->eh_mutex)
>  {
>  	struct ata_eh_context *ehc =3D &ap->link.eh_context;
> =20

[Severity: High]
This is a pre-existing issue, but are we accessing __ata_bmdma_stop() and
active command masks locklessly here, potentially causing state corruption?

nv_swncq_error_handler() executes holding only eh_mutex. It calls
nv_swncq_ncq_stop(), which modifies hardware registers via
__ata_bmdma_stop(ap) and nv_swncq_irq_clear(ap) without holding ap->lock.

Could this create a data race with nv_swncq_interrupt() running concurrently
on another CPU, which acquires ap->lock to modify DMA and IRQ states?

[ ... ]

> diff --git a/drivers/ata/sata_promise.c b/drivers/ata/sata_promise.c
> index 18d1eda69a4a8..c980e609b246e 100644
> --- a/drivers/ata/sata_promise.c
> +++ b/drivers/ata/sata_promise.c
> @@ -816,6 +816,7 @@ static int pdc_sata_hardreset(struct ata_link *link, =
unsigned int *class,
>  }
> =20
>  static void pdc_error_handler(struct ata_port *ap)
> +	__must_hold(&ap->host->eh_mutex)
>  {
>  	if (!ata_port_is_frozen(ap))
>  		pdc_reset_port(ap);

[Severity: High]
This is a pre-existing issue, but does this pattern perform an unprotected
read-modify-write on the PDC_CTLSTAT hardware register?

We locklessly check !ata_port_is_frozen(ap) and then call pdc_reset_port(ap=
).
Because ap->lock is not held and we explicitly check that the port is not
frozen (meaning interrupts are not masked), an interrupt could fire
concurrently and execute pdc_freeze() or pdc_thaw().

Since those also perform read-modify-writes on PDC_CTLSTAT under ap->lock,
could this race silently overwrite hardware states and unintentionally unma=
sk
interrupts?

[ ... ]

> diff --git a/include/linux/libata.h b/include/linux/libata.h
> index e953a9c8e660b..bf113e66f0691 100644
> --- a/include/linux/libata.h
> +++ b/include/linux/libata.h
> @@ -983,7 +983,8 @@ struct ata_port_operations {
>  	void (*thaw)(struct ata_port *ap);
>  	struct ata_reset_operations reset;
>  	struct ata_reset_operations pmp_reset;
> -	void (*error_handler)(struct ata_port *ap);
> +	void (*error_handler)(struct ata_port *ap)
> +		__must_hold(&ap->host->eh_mutex);
>  	void (*lost_interrupt)(struct ata_port *ap);
>  	void (*post_internal_cmd)(struct ata_queued_cmd *qc);
>  	void (*sched_eh)(struct ata_port *ap);

[Severity: High]
Does this struct definition miss a __must_hold(ap->lock) annotation for
sched_eh?

The assigned ata_std_sched_eh function includes __must_hold(ap->lock),
but the struct member here does not.

Additionally, will adding __must_hold() to error_handler break the build
for ata_dummy_error_handler and forward declarations (like
sil24_error_handler) if they are not also updated with these annotations?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260521173347.2079=
560-1-bvanassche@acm.org?part=3D8
