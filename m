Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF7A436A367;
	Tue,  7 Jul 2026 07:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783409601; cv=none; b=FYgclfZZiIY09TX3Zr7u9srskL4M97h4B0djNTkIBlURRIvtf0CJqUeLEP3259Z4ieZT/1FA2U03YPtSa7hZPSkICihtzBZc39s/TKyeuNZlrjMmKvaMJy3hg2wEsQJwLk9odLZdkO3EDSyhOECndfaYf+V6MQyitHReyk1X8RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783409601; c=relaxed/simple;
	bh=+Uw9H97I/fSdci4LJRzARtofGfG6IJjHaAYsA+XcuiA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cT2n0N39HGR66LuYaEEpQCzWBWrVOYCuHB3aPwgiTULFnS/yPINDIQEoRlGXwpFHu7QJo3NECH2hJPCpA0oGc4EQBpuFD2WykmRsvOEFD/ePnLc4yfR1h13MKwtxZluO57WfvjcXfp8yCgFlSDytfw6XCWxSj+AlVYTqLzIu3OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XvSloKeA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XvSloKeA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F6451F00A3A;
	Tue,  7 Jul 2026 07:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783409599;
	bh=4/aAmXmBM292sb1fy/Xa0c2CtVLheP6ppJHVASIQF+o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XvSloKeAgOVHM3Pde6BeMGwYgFIDy/SkTDjK0ensspucouugfMOp8w60JmPoOaSht
	 8tH70lvt0+a3S0e/GoLmFL7RUirBloHNnTU8x5R29siJapGSi5wip6YbPujWreZ2m0
	 UHuOapTzXK2Uo5haoRVbDN7yZLJ4fa/qL2iiDTHF9rVyCVS3hKpObxEgIsiTPdc/VV
	 cYSnDBGgW7P3lAe9hZcDTWzrXaQigM1duICgIGH7wtkYLNOIHQ/nhs99yrQ9lGqZP/
	 duGsooyl9WYptDFBa/zO4TtDxFsqob0Bj8gyS5II08K+atFywxwvMG9ZVCbxWAnO+X
	 4bISWvfbCVimw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v19 10/40] dept: apply sdt_might_sleep_{start, end}() to
 wait_for_completion()/complete()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Byungchul Park" <byungchul@sk.com>
Cc: "Jeff Layton" <jlayton@kernel.org>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, "Anna
 Schumaker" <anna@kernel.org>, tytso@mit.edu, dlemoal@kernel.org, linux-modules@vger.kernel.org, "Chuck
 Lever" <cel@kernel.org>, dri-devel@lists.freedesktop.org, ojeda@kernel.org, cassel@kernel.org, linux-rt-devel@lists.linux.dev
In-Reply-To: <20260706061928.66713-11-byungchul@sk.com>
References: <20260706061928.66713-1-byungchul@sk.com>
 <20260706061928.66713-11-byungchul@sk.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 07:33:18 +0000
Message-Id: <20260707073319.0F6451F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The `init_completion_map()` macro ignores the provided lockdep map=
 argument `m` and sets `dmap` to `NULL`. This forces all generic wrappers l=
ike `flush_work()` to share a single, monolithic dependency class generated=
 at the `wait_for_completion` macro call site.
--

commit c25e7af1e00aa68cd5900db21d080eadb8fccd71
Author: Byungchul Park <byungchul@sk.com>

dept: apply sdt_might_sleep_{start,end}() to wait_for_completion()/complete=
()

This commit enables the DEPT (Dependency Tracker) to track dependencies
introduced by wait_for_completion() and complete() calls. It adds a
dept_map to the completion structure and applies the appropriate sleep
start and end annotations.

> diff --git a/include/linux/completion.h b/include/linux/completion.h
> index fb29156765743..bd2c207481d68 100644
> --- a/include/linux/completion.h
> +++ b/include/linux/completion.h
[ ... ]
> @@ -26,14 +27,33 @@
>  struct completion {
>  	unsigned int done;
>  	struct swait_queue_head wait;
> +	struct dept_map dmap;
>  };
> =20
> +#define init_completion(x)				\
> +do {							\
> +	sdt_map_init(&(x)->dmap);			\
> +	__init_completion(x);				\
> +} while (0)
> +
> +/*
> + * XXX: No use cases for now. Fill the body when needed.
> + */
>  #define init_completion_map(x, m) init_completion(x)

[Severity: High]
Does this macro cause independent dependency graphs to merge? By ignoring t=
he
lockdep map argument m and calling init_completion(x) instead, it seems
generic wrappers like flush_work() will be forced to share a single
monolithic dependency class generated at the wait site.

Could this lead DEPT to report false-positive deadlocks during normal
operations? For example, if Work A flushes Work B, and Work B flushes
Work C, both use the same flush_work() completion class. DEPT might see
Work B both waiting on and satisfying this global class, erroneously
detecting a self-cycle.

> -static inline void complete_acquire(struct completion *x) {}
> -static inline void complete_release(struct completion *x) {}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706061928.6671=
3-1-byungchul@sk.com?part=3D10
