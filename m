Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064AD3EFFCC;
	Tue,  7 Jul 2026 07:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783409620; cv=none; b=WPlhCQKGfM42bihKdiyf2Nbo32JzCtzgS+/Wm//8099m/fKXN2mD6bWiJ9+5nF1l+prRU84UBvzbvDXuXmuvGSdSWG+IwuXDgl0D8tuVKF3iDgiKaixYSVeu4jSslKi2w/baz+p0eyJrH8INRFh1ycTKOKQPtTnXRk4dqI5LGJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783409620; c=relaxed/simple;
	bh=4Llw74/8pdLwiUBdHIs+hgWbAFZpY7ESpefY3zS7qrw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TbTS5IqB4FleZ+nh13amK73j5G+BR8PNBf7wZXV2O3vlwOEE3ha1dzgaY2XEmhSn6b/u8Zkat9Gc0WXLYI4ksLfVDFbw2sU5T6m0lrNsYDxTmmixE88dJObD9MzvUFKXofeHJM9Ju1LdcQ25cb4ck/HvQ6mNwwKaEQFXxxdpkqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lf800/S0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lf800/S0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39B4E1F00A3A;
	Tue,  7 Jul 2026 07:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783409618;
	bh=Uc0u90mt9DiSxYmqJCY+v19zaWOhjJVpb7G9ciFmL1M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lf800/S0I8K7TJXB85fCEdcy7+xkMWAAII3w8vUxDjCjTDJVXeiA2HR5mV94CPOOO
	 kHdNuTOAe+s68eHkPejz5vEAnigNYryd/sZhNy9RuFSXZgXyFdzZSSAA9HRrnDEfI/
	 aw6teGqAaLFtvSzaF+ts7bW7WFke6oLLUNei2b+bB+soUljEZi1O4R9Nj6HY7lR9nO
	 sGXqDC7R6JRuBhlbOLx11X9LZVnyyUoUgvr8JMUee2ZBVJ3KkHCTeCQseFuD0RqaSu
	 fA0TM6zTryLC5+VjGrX4XBjqly4C7uuffSp03cmvSRZ1c3SPT5dWugk80W8ZjC+eit
	 WPsb6D90ubkug==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v19 21/40] dept: make dept able to work with an external
 wgen
Reply-To: sashiko-reviews@lists.linux.dev
To: "Byungchul Park" <byungchul@sk.com>
Cc: tytso@mit.edu, dri-devel@lists.freedesktop.org, "Chuck Lever" <cel@kernel.org>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, dlemoal@kernel.org, linux-rt-devel@lists.linux.dev, linux-modules@vger.kernel.org, ojeda@kernel.org, "Anna
 Schumaker" <anna@kernel.org>, "Jeff Layton" <jlayton@kernel.org>, cassel@kernel.org
In-Reply-To: <20260706061928.66713-22-byungchul@sk.com>
References: <20260706061928.66713-1-byungchul@sk.com>
 <20260706061928.66713-22-byungchul@sk.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 07:33:37 +0000
Message-Id: <20260707073338.39B4E1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unconditional zeroing of `wgen` in `dept_event` creates a race con=
dition that systematically loses dependencies for shared locks, blinding th=
e deadlock detector.
--

commit f7ae795e924d8a4b1154e57adaf0e878e810272c
Author: Byungchul Park <byungchul@sk.com>

dept: make dept able to work with an external wgen

This commit introduces an external wait generation structure, struct
dept_ext_wgen, to allow subsystems with memory constraints to use DEPT
without embedding a full struct dept_map. It modifies dept_request_event()
and dept_event() to optionally accept and operate on this external wgen
instead of the one embedded in struct dept_map.

> diff --git a/kernel/dependency/dept.c b/kernel/dependency/dept.c
> index 5ef85977e6314..e425d3ab05e5a 100644
> --- a/kernel/dependency/dept.c
> +++ b/kernel/dependency/dept.c
[ ... ]
> @@ -2816,24 +2826,26 @@ void dept_event(struct dept_map *m, unsigned long=
 e_f,
>  	if (m->nocheck)
>  		return;
> =20
> +	wg_p =3D ewg ? &ewg->wgen : &m->wgen;
> +
>  	if (dt->recursive) {
>  		/*
>  		 * Dept won't work with this even though an event
>  		 * context has been asked. Don't make it confused at
>  		 * handling the event. Disable it until the next.
>  		 */
> -		WRITE_ONCE(m->wgen, 0U);
> +		WRITE_ONCE(*wg_p, 0U);
>  		return;
>  	}
> =20
>  	flags =3D dept_enter();
> =20
> -	__dept_event(m, m, e_f, ip, e_fn, false);
> +	__dept_event(m, m, e_f, ip, e_fn, false, READ_ONCE(*wg_p));
> =20
>  	/*
>  	 * Keep the map diabled until the next sleep.
>  	 */
> -	WRITE_ONCE(m->wgen, 0U);
> +	WRITE_ONCE(*wg_p, 0U);

[Severity: High]
This is a pre-existing issue, but does unconditionally clearing the wgen he=
re
in dept_event() create a race condition that loses dependencies for shared
locks?

When multiple threads hold a shared lock (e.g., a read-lock like
rw_semaphore), and a writer begins waiting, the writer calls
dept_request_event() which sets the lock's wgen. The first reader to unlock
calls dept_event(), which reads the wgen, processes the wait dependency for
its own context, and then unconditionally clears wgen to 0 here.

All subsequent readers unlocking will read 0 and fail to record the depende=
ncy
between the writer's wait and their own read-side critical sections, which
could blind the deadlock detector.

Since this issue affects the newly introduced ewg->wgen as well, could this
be addressed to ensure dependencies aren't lost when multiple threads share
the lock?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706061928.6671=
3-1-byungchul@sk.com?part=3D21
