Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68BCC41F7D9;
	Tue,  7 Jul 2026 07:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783409636; cv=none; b=GZQNgVqmBq/pR5AOQUqPq9Z7Uznn2Wk5nXkn3n5baZlgGjhFHS7rQ6FAax4k3utjJDmBgP/zIwwmEsXVcKpR4IX75Hx1ls0eS6EGYzptRenORjsUGWZwi0dS+eWxodzHf/U01YINNkJgspSPj9sr7S/mgGRFkLVz8keJ49IHtgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783409636; c=relaxed/simple;
	bh=JT177X4ZvQa5T8s+QvSLapnU1NWozCil1BSGH4yHqcA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ViFfbWOv2WTb9LXqa6U4EiHM8vk0aoBFf7raJxjXnQ62a06Puoj693U/PE40Nek7naFgorysNeJReP9rikWI8ownzLgtr4nTXE2GFG+8DTs6juyJ6PkVClh374a/M6aRMfwx1nPh8UGI+eiNNTCbs+iZC5n4lO/uF9EOAFwR4Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RNeX6PJL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RNeX6PJL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 544911F000E9;
	Tue,  7 Jul 2026 07:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783409635;
	bh=LLQjPx7P/NIh8MZ8YJz21lcouXfdxTTT0alZQ4cHy64=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RNeX6PJLOhaBSGGQnjoIdFgMEYjriEClnCw+itUdbNcQF4AWqRfPzW82R9GzlycDY
	 /chzcdnxxhmgqxV9tntWJZuNjLcTYH4JA66CzraOHEhNWtDxqQtvHq6jrCBGsPcaQn
	 iV7yX3dXCdKJTk0Ji6+2PW/zebr/ud1wLpMJi0Ifl92jdjgF0u32NwAovaWozdmiar
	 6/GvEXJlLb1iBNuh0oqFHRkaQ3KLi35hgCYP0oiwsrLfH4zDBH8PC/R8V9/lM95nqr
	 jk8OITp7RNAFykXwKwWZ6Dfvz0A41iid69V9S9yrRFjrpQudVQqvnxfGGqWJ486CFj
	 ufy4jDwpGDcLg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v19 35/40] dept: introduce APIs to set page usage and
 use subclasses_evt for the usage
Reply-To: sashiko-reviews@lists.linux.dev
To: "Byungchul Park" <byungchul@sk.com>
Cc: linux-kernel@vger.kernel.org, "Chuck Lever" <cel@kernel.org>, ojeda@kernel.org, dri-devel@lists.freedesktop.org, linux-modules@vger.kernel.org, cassel@kernel.org, tytso@mit.edu, linux-rt-devel@lists.linux.dev, linux-ide@vger.kernel.org, dlemoal@kernel.org, "Jeff
 Layton" <jlayton@kernel.org>, "Anna Schumaker" <anna@kernel.org>
In-Reply-To: <20260706061928.66713-36-byungchul@sk.com>
References: <20260706061928.66713-1-byungchul@sk.com>
 <20260706061928.66713-36-byungchul@sk.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 07:33:53 +0000
Message-Id: <20260707073354.544911F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:
- [High] Page usage state (`usage.type`) is not cleared upon page free, lea=
king stale DEPT classes.
- [High] Premature usage type update in waiters breaks the DEPT_PAGE_DEFAUL=
T fallback mechanism.
- [Medium] The newly introduced APIs for setting page usage are never calle=
d.
- [Low] Passing unsigned int* to atomic_try_cmpxchg violates pointer compat=
ibility.
- [Low] Redundant bitwise operations in dept_set_page_usage.
- [Low] Missing dummy implementations for dept_set_folio_usage and dept_res=
et_folio_usage.
--

commit ded2d968cb8933d3c60792b69d4f3c8618c64ffa
Author: Byungchul Park <byungchul@sk.com>

dept: introduce APIs to set page usage and use subclasses_evt for the usage

False positive reports have been observed since dept assumes that all
the pages have the same dept class, but the class should be split since
the call paths are different depending on what the page is used for.
This commit introduces APIs to track these usages via struct page to
avoid false positive DEPT reports.

> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 5b3f54ee0d381..e25d09f3dfa9b 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -220,6 +220,7 @@ struct page {
>  	struct page *kmsan_shadow;
>  	struct page *kmsan_origin;
>  #endif
> +	struct dept_page_usage usage;

[Severity: High]
Does this leak stale DEPT classes when pages are freed and reallocated?

The new usage field is added to struct page, but it doesn't appear to be
cleared during page free. If a page with a specific usage type is freed and
later reallocated for a different purpose, it might retain the old usage
type, leading to graph pollution and false positives.

Should this state be scrubbed in mm/page_alloc.c:__free_pages_prepare()?

>  	struct dept_ext_wgen pg_locked_wgen;
>  } _struct_page_alignment;
> =20

> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> index 8ab39823ea313..0b0655354b084 100644
> --- a/include/linux/page-flags.h
> +++ b/include/linux/page-flags.h
[ ... ]
> @@ -204,6 +204,80 @@ enum pageflags {
> =20
>  extern struct dept_map pg_locked_map;
> =20
> +static inline void dept_set_page_usage(struct page *p,
> +		unsigned int new_type)
> +{

[Severity: Medium]
This isn't a bug, but are there missing callers for these newly introduced
APIs?

The commit message mentions splitting usages for block and file caches,
but dept_set_page_usage() and dept_set_folio_usage() do not seem to be
invoked anywhere in this patch.

> +	/*
> +	 * Consider the page as DEPT_PAGE_DEFAULT until the next use of
> +	 * PG flags e.g. folio_lock().
> +	 */
> +	unsigned int type =3D DEPT_PAGE_DEFAULT;
> +
> +	if (WARN_ON_ONCE(new_type >=3D DEPT_PAGE_USAGE_NR))
> +		return;
> +
> +	new_type <<=3D DEPT_PAGE_USAGE_SHIFT;
> +	new_type |=3D type & DEPT_PAGE_USAGE_MASK;

[Severity: Low]
Does this bitwise OR operation have any effect?

Since type is unconditionally initialized to DEPT_PAGE_DEFAULT (which is 0)
just above, masking and ORing it with new_type seems redundant.

> +	atomic_set(&p->usage.type, new_type);
> +}
[ ... ]
> +static inline void dept_update_page_usage(struct page *p)
> +{
> +	unsigned int type =3D atomic_read(&p->usage.type);
> +	unsigned int new_type;
> +
> +retry:
> +	new_type =3D type & DEPT_PAGE_USAGE_PENDING_MASK;
> +	new_type >>=3D DEPT_PAGE_USAGE_SHIFT;
> +	new_type |=3D type & DEPT_PAGE_USAGE_PENDING_MASK;
> +
> +	/*
> +	 * Already updated by others.
> +	 */
> +	if (type =3D=3D new_type)
> +		return;
> +
> +	if (!atomic_try_cmpxchg(&p->usage.type, &type, new_type))

[Severity: Low]
Can this trigger a -Wpointer-sign build warning?

The type variable is declared as unsigned int, but atomic_try_cmpxchg()
expects an int * for its second argument.

> +		goto retry;
> +}
[ ... ]
>  static inline void dept_page_set_bit(struct page *p, int bit_nr)
>  {
> +	dept_update_page_usage(p);
> +
>  	if (bit_nr =3D=3D PG_locked)
>  		dept_request_event(&pg_locked_map, &p->pg_locked_wgen);
>  }
[ ... ]
>  static inline void dept_page_wait_on_bit(struct page *p, int bit_nr)
>  {
> +	unsigned long evt_f;
> +
> +	dept_update_page_usage(p);

[Severity: High]
Does calling dept_update_page_usage() in these flag update/wait functions
prematurely overwrite the page usage, breaking the DEPT_PAGE_DEFAULT fallba=
ck
mechanism?

If waiters or setters trigger dept_update_page_usage() unconditionally, they
could clobber the current state with the pending state before the lock is
released. When the lock is subsequently released, it might emit the wrong
event type, which could cause early DEFAULT waiters to hang indefinitely
and trigger false positive reports.

> +	evt_f =3D dept_event_flags(p, true);
> +
>  	if (bit_nr =3D=3D PG_locked)
> -		dept_wait(&pg_locked_map, 1UL, _RET_IP_, __func__, 0, -1L);
> +		dept_wait(&pg_locked_map, evt_f, _RET_IP_, __func__, 0, -1L);
>  }
[ ... ]
> @@ -245,6 +328,8 @@ static inline void dept_folio_wait_on_bit(struct foli=
o *f, int bit_nr)
>  	dept_page_wait_on_bit(&f->page, bit_nr);
>  }
>  #else
> +#define dept_set_page_usage(p, t)		do { } while (0)
> +#define dept_reset_page_usage(p)		do { } while (0)

[Severity: Low]
Will this break the build for users of dept_set_folio_usage() and
dept_reset_folio_usage() when CONFIG_DEPT is disabled?

The #else block provides dummy macros for page variants, but seems to be
missing the folio equivalents.

>  #define dept_page_set_bit(p, bit_nr)		do { } while (0)
>  #define dept_page_clear_bit(p, bit_nr)		do { } while (0)
>  #define dept_page_wait_on_bit(p, bit_nr)	do { } while (0)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706061928.6671=
3-1-byungchul@sk.com?part=3D35
