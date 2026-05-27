Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728133C0A16
	for <linux-ide@vger.kernel.org>; Wed, 27 May 2026 20:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779915433; cv=none; b=P75ViQ/iY3uAnKz2Hjo7TzUGG4c7UWFhy1OBTlAEZtYMqO7AxXiraMvjTFxnxfIHynW+D9/JULnQ3mL6ixfz8up2cWgjZ0nMC9r8OemVWlk2oNnRXYZI2OY4/+5azyWzgr1koQQsfbUHRux3eZez2NKAsH9pkF/w/jhz/UKfTtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779915433; c=relaxed/simple;
	bh=BWNvaUQmXvrMMAlCMk/Kxs7A/T4sE9Ooq9K/Q16BthE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SMnYvxbNTqlZSuIyf54G+VEmKST+57s6yTWuEQd8YT1MksoxzR4TjHmogumtKx89dg2jk2Ggq1k3MzYQsQQqXHqQkXvSyTjCwyEmbza0dnf5HMoyryQkcos2tQ6tv7QF1fucsjH1XPf00eDCZOvVaIME4GEZRaW3x4MzKWiVs24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mJdiUCrk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mJdiUCrk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCA141F000E9;
	Wed, 27 May 2026 20:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779915432;
	bh=0boOf6ZBNXcqV9CVVauuMpxWre3mk890KlwL4eA1Xog=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mJdiUCrk75msw+rC9T2aPwVbIyfRqXQtl1AyoQs2PXx0diGg1wRnH+XCoq40tqrCw
	 dSa3rRWfewnLsDWqQ+elGZQdVn2zUWGkV4wOUZwrZyMUsveLTKkoLTswp7nd8Rgmo/
	 Web6ChpwKViu9978+MjKYZumLMEtncfDjIgpCvThOkoY6/UrSD4R1HsSLLQlzWYxje
	 7KvXQDC6faeUqQzPzfKRC4+e4zUPjoNlshYmxYKddQqW/v42EwKSzrydVpcsnNjcG5
	 We6hfelHaMwd8OK7kpHRqrPfKi2hNL4RqqCYJcvOwj3G3/eyz+/QJShWIYJ1RvIaDf
	 ynZlgJGQVKIxw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] ata: libata: Document when host->eh_mutex should be
 held
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bart Van Assche" <bvanassche@acm.org>
Cc: linux-ide@vger.kernel.org, dlemoal@kernel.org, cassel@kernel.org
In-Reply-To: <e95c0eb43a8297c9ab5e220341512882f8648512.1779913278.git.bvanassche@acm.org>
References: <e95c0eb43a8297c9ab5e220341512882f8648512.1779913278.git.bvanassche@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 27 May 2026 20:57:11 +0000
Message-Id: <20260527205711.BCA141F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [Low] Missing '&' operator in lock capability expression for `__acquires`=
 and `__releases` annotations on `ata_eh_acquire` and `ata_eh_release`.
- [Low] The `ata_dummy_error_handler` function is missing the `__must_hold(=
&ap->host->eh_mutex)` annotation.

Pre-existing issues:
- [High] The `mv_pmp_error_handler` modifies `pp->pp_flags` and calls `ata_=
port_freeze(ap)` without holding the host spinlock, leading to data races w=
ith the interrupt handler and lockdep/API contract violations.
- [High] The `sil24_error_handler` clears `pp->do_port_rst` without holding=
 the host spinlock after the port has been thawed, creating a race conditio=
n with the interrupt handler.
--

commit 5548604538b7f00a0cf37a02b72ef6176653ab1e
Author: Bart Van Assche <bvanassche@acm.org>

ata: libata: Document when host->eh_mutex should be held

Annotate various error handling functions with __must_hold(&host->eh_mutex)
to enable Clang's context analysis. This helps catch locking bugs in error
paths at compile time.

> diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
> index 9a4b67b90b17b..7b3c3e20115e5 100644
> --- a/drivers/ata/libata-eh.c
> +++ b/drivers/ata/libata-eh.c
> @@ -469,6 +469,7 @@ static void ata_eh_clear_action(struct ata_link *link=
, struct ata_device *dev,
>   *	EH context.
>   */
>  void ata_eh_acquire(struct ata_port *ap)
> +	__acquires(ap->host->eh_mutex)
>  {

[Severity: Low]
Since the internal locking functions and __must_hold expect a pointer,
should this use the address-of operator like __acquires(&ap->host->eh_mutex=
)?
Without it, this might cause a capability mismatch in Clang's Thread Safety
Analysis and lead to build failures since CONTEXT_ANALYSIS is enabled.

[ ... ]

> @@ -486,6 +487,7 @@ void ata_eh_acquire(struct ata_port *ap)
>   *	EH context.
>   */
>  void ata_eh_release(struct ata_port *ap)
> +	__releases(ap->host->eh_mutex)
>  {

[Severity: Low]
Similarly, should this be __releases(&ap->host->eh_mutex) instead?

[ ... ]

> diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
> index ffb396f61731f..f6942fd80bae7 100644
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
This is a pre-existing issue, but does this function modify pp->pp_flags
and call ata_port_freeze() without holding the host spinlock?

The error_handler callback is invoked with ap->host->eh_mutex held, but
without the host spinlock (ap->lock). However, mv_pmp_error_handler()
performs a read-modify-write on pp->pp_flags:

	if (pp->pp_flags & MV_PP_FLAG_DELAYED_EH) {
		pmp_map =3D pp->delayed_eh_pmp_map;
		pp->pp_flags &=3D ~MV_PP_FLAG_DELAYED_EH;

This can race with mv_err_intr() which modifies the same flags from the
interrupt handler while holding the spinlock.

Additionally, this calls ata_port_freeze(ap) directly, which requires
the host lock to be held according to its locking contract.

[ ... ]

> diff --git a/drivers/ata/sata_sil24.c b/drivers/ata/sata_sil24.c
> index d642ece9f07a1..89a10704e98e5 100644
> --- a/drivers/ata/sata_sil24.c
> +++ b/drivers/ata/sata_sil24.c
> @@ -1167,6 +1167,7 @@ static irqreturn_t sil24_interrupt(int irq, void *d=
ev_instance)
>  }
> =20
>  static void sil24_error_handler(struct ata_port *ap)
> +	__must_hold(&ap->host->eh_mutex)
>  {
>  	struct sil24_port_priv *pp =3D ap->private_data;

[Severity: High]
This is a pre-existing issue, but does clearing pp->do_port_rst here
race with the interrupt handler?

sil24_error_handler() delegates to sata_pmp_error_handler(), which recovers
the port and re-enables hardware interrupts:

	sata_pmp_error_handler(ap);
	pp->do_port_rst =3D 0;

If an error interrupt fires after the port is thawed but before
pp->do_port_rst =3D 0 executes, sil24_interrupt() could set pp->do_port_rst=
 =3D 1
to request a controller reset. The EH thread would then overwrite this with=
 0
without holding the ap->lock spinlock, discarding the reset request.

[ ... ]

> diff --git a/include/linux/libata.h b/include/linux/libata.h
> index 5c085ef4eda7b..5f6bbe5d504fa 100644
> --- a/include/linux/libata.h
> +++ b/include/linux/libata.h
> @@ -983,7 +983,8 @@ struct ata_port_operations {
>  	void (*thaw)(struct ata_port *ap);
>  	struct ata_reset_operations reset;
>  	struct ata_reset_operations pmp_reset;
> -	void (*error_handler)(struct ata_port *ap);
> +	void (*error_handler)(struct ata_port *ap)
> +		__must_hold(&ap->host->eh_mutex);

[Severity: Low]
Does ata_dummy_error_handler() also need to be annotated with __must_hold?

Since ata_dummy_error_handler() lacks this annotation, assigning it to
ata_dummy_port_ops.error_handler will cause a type/capability mismatch in
Clang's Thread Safety Analysis and break the build.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/e95c0eb43a8297c9ab5=
e220341512882f8648512.1779913278.git.bvanassche@acm.org?part=3D1
