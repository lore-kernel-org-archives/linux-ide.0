Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1793E0C5C;
	Tue,  7 Jul 2026 07:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783409613; cv=none; b=KWeMc5trUeCl8/PLLcfgB/BhN0OnAaz7b36+peCFce/88jpzf67jHYDqYVkeM2qaTVDYE6eN2pl2ygGwe1wGNQT7nqPcch4mpyHGwnuHIbve6w36MvcWT0+Cc5fMPnon1ALasDzq6DSPmI08QJPRjEU59DN16J0jBj9qegqpTl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783409613; c=relaxed/simple;
	bh=5FF8Slk70QluNXrSZKuuHiNhhjRfk6yJMKgbxsGDjfE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JxFjuVUl9p1/QJkwLX5Q2fBxRDzrkr2X4IDDwuCuRWgRsoa7qlG1/kQdv0Zqd8dBZKvwSXMBhXpFJ+1DRDjDr3hWg8HXpd7SbOV2ebkJ4Xxyh251Y/kAKVFPR8eSTBAMbdcvf2KIbYTJ5bWa9pQTiYY+lBswE62tkEgnWkbpSZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P+aibbhA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P+aibbhA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4C831F00A3A;
	Tue,  7 Jul 2026 07:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783409612;
	bh=tAz7VH1zOguzovZNW36XXoVQvMuf0soLxiU1I3t31Fs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=P+aibbhA6h1oT0wK4OhqZW9GBkptV0C1Jj5HcIl/JEbVVyXxniV1pgCH66w3ZF1fB
	 zKBTts/aEvXnn1lbBkwTfEbUHixrtxj6idVzF8ot7LccZByoYPXsanQiYxA75NPpg7
	 +g4KnSqXjB7pgytKWJwJdlAvXClSnAWAsYW4CahqKG9T4yL3+7m4A6qcx0mOHoLpHw
	 JOSnwxKJSVbZJ2F+RjKQSeDN/2gNxJcpaWPraCZsxDgET51BfxaJ0U+y+KhG2r0+5h
	 DHSB48mUfQG8c33FuBD7fD9tQ6ZMQ98En9+9r8LvmjstbboM28/2+5SvWBf6WAVd//
	 tkVDWxt5MSIWw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v19 15/40] dept: track timeout waits separately with a
 new Kconfig
Reply-To: sashiko-reviews@lists.linux.dev
To: "Byungchul Park" <byungchul@sk.com>
Cc: cassel@kernel.org, linux-rt-devel@lists.linux.dev, ojeda@kernel.org, linux-ide@vger.kernel.org, dlemoal@kernel.org, "Chuck
 Lever" <cel@kernel.org>, "Jeff Layton" <jlayton@kernel.org>, linux-modules@vger.kernel.org, "Anna
 Schumaker" <anna@kernel.org>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, tytso@mit.edu
In-Reply-To: <20260706061928.66713-16-byungchul@sk.com>
References: <20260706061928.66713-1-byungchul@sk.com>
 <20260706061928.66713-16-byungchul@sk.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 07:33:31 +0000
Message-Id: <20260707073331.B4C831F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Semantic collision in the timeoutval argument causes 0-timeout try=
-waits to be incorrectly tracked as hard blocking dependencies.
- [High] Enabling CONFIG_DEPT_AGGRESSIVE_TIMEOUT_WAIT masks real deadlocks =
because a timeout wait permanently poisons the dependency edge, causing sub=
sequent strict (non-timeout) waits to be ignored.
--

commit 1b06fc68b17e6c7948f8187e55952d1767e48762
Author: Byungchul Park <byungchul@sk.com>

dept: track timeout waits separately with a new Kconfig

This patch modifies DEPT to track timeout waits separately to avoid
reporting false positive deadlocks for deliberate timeouts. It also
introduces the CONFIG_DEPT_AGGRESSIVE_TIMEOUT_WAIT option to toggle this
tracking behavior.

> diff --git a/kernel/dependency/dept.c b/kernel/dependency/dept.c
> index 3af360ba17d8e..5ef85977e6314 100644
> --- a/kernel/dependency/dept.c
> +++ b/kernel/dependency/dept.c
[ ... ]
> @@ -810,6 +812,24 @@ static void print_dep(struct dept_dep *d)
> =20
>  static void save_current_stack(int skip);
> =20
> +static bool is_timeout_wait_circle(struct dept_class *c)
> +{
> +	struct dept_class *fc =3D c->bfs_parent;
> +	struct dept_class *tc =3D c;
> +
> +	do {
> +		struct dept_dep *d =3D lookup_dep(fc, tc);
> +
> +		if (d->wait->timeout)
> +			return true;

[Severity: High]
If CONFIG_DEPT_AGGRESSIVE_TIMEOUT_WAIT is enabled, does this mask genuine
deadlocks if a strict wait follows a timeout wait?

If a timeout wait between class A and class B occurs first, it creates a
dependency edge with wait->timeout set to true. If a strict (non-timeout)
wait subsequently occurs between the same classes, add_dep() finds the
existing edge and returns early:

kernel/dependency/dept.c:add_dep() {
        if (lookup_dep(fc, tc))
                return;
        ...
}

The edge is never upgraded to reflect the stricter dependency.=20

If a deadlock later happens involving this edge, would is_timeout_wait_circ=
le()
see the stale timeout flag and incorrectly report it as an intended circular
dependency instead of a genuine deadlock?

> +
> +		tc =3D fc;
> +		fc =3D fc->bfs_parent;
> +	} while (tc !=3D c);
> +
> +	return false;
> +}
[ ... ]
> @@ -2355,14 +2381,23 @@ static void __dept_event(struct dept_map *m, stru=
ct dept_map *real_m,
>  }
> =20
>  void dept_wait(struct dept_map *m, unsigned long w_f,
> -	       unsigned long ip, const char *w_fn, int sub_l)
> +	       unsigned long ip, const char *w_fn, int sub_l,
> +	       long timeoutval)
>  {
>  	struct dept_task *dt =3D dept_task();
>  	unsigned long flags;
> +	bool timeout;
> =20
>  	if (unlikely(!dept_working()))
>  		return;
> =20
> +	timeout =3D timeoutval > 0 && timeoutval < MAX_SCHEDULE_TIMEOUT;

[Severity: High]
Does this logic correctly handle try-waits or polling?

When a caller invokes a polling wait like wait_for_completion_timeout(x, 0),
the timeoutval is 0. Because 0 > 0 evaluates to false, this sets timeout to
false. DEPT then tracks this non-blocking poll as an indefinite hard wait.

Can this lead to false positive deadlock reports when no actual blocking
occurs?

> +
> +#if !defined(CONFIG_DEPT_AGGRESSIVE_TIMEOUT_WAIT)
> +	if (timeout)
> +		return;
> +#endif
> +
>  	if (dt->recursive)
>  		return;
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706061928.6671=
3-1-byungchul@sk.com?part=3D15
