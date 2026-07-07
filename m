Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4FD3C8C74;
	Tue,  7 Jul 2026 07:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783409631; cv=none; b=oml75N4G18pDlP5FdHi16FEy6rEpppTz8ZhrcEC4WQKL8L1H1JnyLRtsxIw0UBalSClK6E6Y0W0omVB9TptkDFPxswq1R2o1Tm98jM9yCg9BhBed3Wx1V1GmrCde7We0/EIu2gJuLJwZ5c26cIllAr70nSYNO4l2nXDBVKq7cP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783409631; c=relaxed/simple;
	bh=u7kRQEHM8kIGFvKTELIn+PczYDHb9ozzkSxWYeaxuss=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NTMdeDRnz0mJiyygyMGsY2aGCdeKLDQadwjCnm2ZDMK1rhozFC7pPMe5KSv3SZN1Hv5ce1kn0YZTSAJYBr9CL2dIBDe/M7hxM15s8NuSswBDD1qXBMq7f/xlK7OMufODNgfnD9wMBBacP9uzD8AA6iFFA0gZsgxL0l1C+eYLbxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ForedeT4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ForedeT4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3FD41F000E9;
	Tue,  7 Jul 2026 07:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783409629;
	bh=airgbxL1sKuMal1d1K2gcZrKH108O2x+A+oa7Ozs7L4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ForedeT47kO0wBQhKgthZ7tn0tN4JC6GHOJxBuqdQLVSc/dBuDuWlv+7x6Zhp/i7O
	 9aFNz0503vIJ2EsZHgcsF1sxh43X6agklD4xrRMVQ3V9khWQWTGm/WZkcZxY0UetCA
	 x5EukxIJLT1L1k3a2yXMvwwEtI1OVVyzRv78BIdBIUSMv033kFMkZzszGUr3yny2zy
	 HiS7k/8b5iCaQ7ivf7fGHCnXQ7nHZyvT0tAWwbISbbeZn7K2XopEkiU8vdZrUGLdSH
	 e+JyqiMxQumtd0kDIv3g6l2oHzVSyNkVxdgd95YL3tvTTZpLhU0s30ARC7Z7pd+INm
	 hjDtyerYy/uPA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v19 31/40] dept: assign unique dept_key to each distinct
 wait_for_completion() caller
Reply-To: sashiko-reviews@lists.linux.dev
To: "Byungchul Park" <byungchul@sk.com>
Cc: "Anna Schumaker" <anna@kernel.org>, linux-rt-devel@lists.linux.dev, dri-devel@lists.freedesktop.org, linux-modules@vger.kernel.org, dlemoal@kernel.org, "Jeff
 Layton" <jlayton@kernel.org>, ojeda@kernel.org, "Chuck Lever" <cel@kernel.org>, cassel@kernel.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, tytso@mit.edu
In-Reply-To: <20260706061928.66713-32-byungchul@sk.com>
References: <20260706061928.66713-1-byungchul@sk.com>
 <20260706061928.66713-32-byungchul@sk.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 07:33:48 +0000
Message-Id: <20260707073348.D3FD41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] The `wait_for_completion_*_timeout` macros evaluate their timeout =
argument `t` multiple times, creating a side-effect vulnerability.
- [High] The `wait_for_completion_*` wrapper macros declare local variables=
 (`__ret` and `__m`) that shadow variables in the caller's scope, leading t=
o uninitialized memory usage.
- [High] The `wait_for_completion` macros now implicitly depend on GPL-only=
 exported symbols, breaking non-GPL module compilation when CONFIG_DEPT is =
enabled.
- [Medium] The C helper function `rust_helper_wait_for_completion` defeats =
the primary goal of the patch for the Rust subsystem by mapping all Rust ca=
llers to a single `dept_key`.
--

commit 18fd6796eb79fb0d0201e71c6791aa80955604b2
Author: Byungchul Park <byungchul@sk.com>

dept: assign unique dept_key to each distinct wait_for_completion() caller

This patch assigns a unique dept_key to each distinct wait_for_completion()
caller to avoid false positive reports from DEPT. It also adds a C helper
for the Rust subsystem to avoid build errors.

> diff --git a/include/linux/completion.h b/include/linux/completion.h
> --- a/include/linux/completion.h
> +++ b/include/linux/completion.h
[ ... ]
> +#define wait_for_completion(x)						\
> +({									\
> +	sdt_might_sleep_start_timeout(NULL, -1L);			\
> +	__wait_for_completion(x);					\
> +	sdt_might_sleep_end();						\
> +})

[Severity: High]
Will these macros implicitly depend on GPL-only exported symbols, breaking
non-GPL module compilation when CONFIG_DEPT is enabled?

The original wait_for_completion() functions are exported via EXPORT_SYMBOL,
making them available to non-GPL modules.

The new macros wrap these primitives with calls to dept_stage_wait() and
dept_clean_stage() via sdt_might_sleep_start_timeout().

Since those tracker functions are exported via EXPORT_SYMBOL_GPL, could this
cause linkage failures for non-GPL modules using the macro?

[ ... ]
> +#define wait_for_completion_timeout(x, t)				\
> +({									\
> +	unsigned long __ret;						\
> +									\
> +	sdt_might_sleep_start_timeout(NULL, t);				\
> +	__ret =3D __wait_for_completion_timeout(x, t);			\
> +	sdt_might_sleep_end();						\
> +	__ret;								\
> +})

[Severity: High]
Does this macro evaluate the timeout argument t twice?

If a caller passes an expression with side effects (like a stateful
function call or a pre/post-increment) as the timeout argument, the
expression will be executed multiple times.

Would this lead to incorrect timeouts or potential kernel crashes if the
expression modifies sensitive state?

[Severity: High]
Could the internal __ret variable shadow a variable in the caller's scope?

If a caller passes an expression for the timeout t or the completion x
that relies on a variable named __ret in their own scope, the macro's
inner uninitialized __ret might shadow the caller's variable.

Would this result in the underlying wait functions receiving uninitialized
stack memory instead of the intended parameter?

[ ... ]
> diff --git a/rust/helpers/completion.c b/rust/helpers/completion.c
> --- a/rust/helpers/completion.c
> +++ b/rust/helpers/completion.c
[ ... ]
> +void rust_helper_wait_for_completion(struct completion *x)
> +{
> +	wait_for_completion(x);
> +}

[Severity: Medium]
Does this C helper function defeat the primary goal of the patch for the
Rust subsystem?

The patch explicitly changes wait_for_completion() to a macro so that a
unique static dept_key is instantiated at each distinct call site, avoiding
false positive dependency reports.

However, by wrapping the macro into a single out-of-line C function,
wouldn't all Rust callers of completions share the exact same dept_key,
reintroducing the false positive reports?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706061928.6671=
3-1-byungchul@sk.com?part=3D31
