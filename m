Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED17839BFED;
	Tue,  7 Jul 2026 07:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783409600; cv=none; b=PIIh0f8diC1Vef7RXG+aiQVUxsSfm2XSkBR0SMvDz1VxX+FUr1KnRUJ+YLhd9ip7mFBf6GPlVQ8FpFzHHxneBYWoRseXc6l/SldkVVEc0X1L4XQmwIdOgBqVI/b3xF8VBhLyphEgzt3odJTJIE8ZRcrr9NXAAde+AV+0pf0upBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783409600; c=relaxed/simple;
	bh=xuVDnHOnlol+hDO8LVc8HGinEJlc9TJ2odjuPgLCWU4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JwF0yvMkX0DcUvC6DDtKJkrWX9Q8pCc+7kZC7Q0EQw0ooxt8spFPDCO88JKINtWzWWq/iAXMt/R6co8/pWiQNcTNH1yjdkTa135gADS197wFhe2iA+oZ1s9Oi2Dk7Kvo6AqkgGN+xz+BqFRc98wvXIm9+A+7RxnugeDJkp5er90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gx68qnDT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gx68qnDT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37C831F000E9;
	Tue,  7 Jul 2026 07:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783409598;
	bh=9mf44biJiePoNWQuGF44qWqC9KC06niE51csrHqMLss=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gx68qnDThE1KqZUlF0/I/Z37aZFJQcIEXAI4J2h6MzFlHgVZwFU8yXTUtjbLaB4jN
	 8Y7uM0LEHvI/LITeDkKcyr/KWmg+ognQSQjJ7FS5NfpApdsg+hqg8ZW1pqRGatmVY3
	 Z9WPX0dAa66lMF074ov+2fX8rlFnS6RFuiPeYrSNCG2qPPvLRS1zuIFqfQjWw45mzi
	 1/R7I3O9FWAoNGEjgq7DsUFWj2XA4upuz00nBdezB3r7lpFvhpAstzd+iJ1MrPrAIJ
	 ffIzO1/JPSwIi3Hx8nnUjz8dM9IEyfs/AD+apHd385tZXvbefKOTDW++YW3xhjNJ7b
	 jcuEmC0SIyQnQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v19 13/40] dept: apply sdt_might_sleep_{start, end}() to
 hashed-waitqueue wait
Reply-To: sashiko-reviews@lists.linux.dev
To: "Byungchul Park" <byungchul@sk.com>
Cc: "Chuck Lever" <cel@kernel.org>, tytso@mit.edu, "Anna Schumaker" <anna@kernel.org>, linux-kernel@vger.kernel.org, dlemoal@kernel.org, dri-devel@lists.freedesktop.org, "Jeff
 Layton" <jlayton@kernel.org>, linux-rt-devel@lists.linux.dev, ojeda@kernel.org, linux-modules@vger.kernel.org, cassel@kernel.org, linux-ide@vger.kernel.org
In-Reply-To: <20260706061928.66713-14-byungchul@sk.com>
References: <20260706061928.66713-1-byungchul@sk.com>
 <20260706061928.66713-14-byungchul@sk.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 07:33:16 +0000
Message-Id: <20260707073317.37C831F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The `sdt_might_sleep_end()` macro is bypassed when `___wait_var_=
event` is interrupted, leaving the DEPT tracker in an inconsistent state.
- [Medium] The `sdt_might_sleep_end()` macro is bypassed when `___wait_even=
t` is interrupted, leaving the DEPT tracker in an inconsistent state.
--

commit 0bd2d42866fa6b852ee5317edcaf6890a90c3c65
Author: Byungchul Park <byungchul@sk.com>

dept: apply sdt_might_sleep_{start,end}() to hashed-waitqueue wait

Make dept able to track dependencies by hashed-waitqueue waits.

> diff --git a/include/linux/wait_bit.h b/include/linux/wait_bit.h
> index 9e29d79fc790a..179a616ad245a 100644
> --- a/include/linux/wait_bit.h
> +++ b/include/linux/wait_bit.h
[ ... ]
> @@ -257,6 +258,7 @@ extern wait_queue_head_t *__var_waitqueue(void *p);
>  	struct wait_bit_queue_entry __wbq_entry;			\
>  	long __ret =3D ret; /* explicit shadow */				\
>  									\
> +	sdt_might_sleep_start(NULL);					\
>  	init_wait_var_entry(&__wbq_entry, var,				\
>  			    exclusive ? WQ_FLAG_EXCLUSIVE : 0);		\
>  	for (;;) {							\
> @@ -274,6 +276,7 @@ extern wait_queue_head_t *__var_waitqueue(void *p);
>  		cmd;							\
>  	}								\
>  	finish_wait(__wq_head, &__wbq_entry.wq_entry);			\
> +	sdt_might_sleep_end();						\
>  __out:	__ret;								\
>  })

[Severity: Medium]
If this wait is interrupted by a signal, the loop executes a goto __out
which bypasses sdt_might_sleep_end(). Does this leave the dept tracker
in an inconsistent state where the task's stage remains permanently armed?

This could cause false positive dependency tracking splats on subsequent
waits, or fail to record new dependencies because the tracker is blinded by
the stale stage.

I noticed the exact same issue is present in ___wait_event():

include/linux/wait.h:___wait_event() {
    ...
		if (___wait_is_interruptible(state) && __int) {
			__ret =3D __int;
			goto __out;
		}
    ...
	sdt_might_sleep_end();
__out:	__ret;
})

[Severity: Medium]
Does ___wait_event() also skip sdt_might_sleep_end() when interrupted?
By missing the paired cleanup call, the task's stage could remain
permanently armed here as well.

Would it make sense to move the __out label above sdt_might_sleep_end(),
or otherwise ensure the state is cleaned up on the interrupted paths for
both of these macros?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706061928.6671=
3-1-byungchul@sk.com?part=3D13
