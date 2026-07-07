Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4CB13EFFA9;
	Tue,  7 Jul 2026 07:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783409618; cv=none; b=XHJ0xSTM4HbK9QcLgCHm6NaAba6KPhvAfqUy158jyYfN1/ffK/jnBnVyIU/V6N5EVPAVN2xC/CwLSdJzqy1d71iI2jM6RuWMNpXbiL58f9Q0B2WDp/bw9f27sGnJ1xSipSmOJ+tU2xi05IkVbA5kqileqrk5zDkrZ2bTBf8ml+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783409618; c=relaxed/simple;
	bh=u3hxrQ0ja/BmueMjjJQs2g0KyJ7zskNezmz6ch8cpsg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iTVTdNVtqwYUveORooBnVTCwS50zWZOv8sLcU/lqpB24HLjyFcOpk1XYQczQ4YZyccd63/Pn76W3tB7gQWf9/o5s7SNNAQBsss3Wo3pC8/R3NHhLu8Tmfv54jX32AUnw044x3kcFO+E5upO5vsSSX0+4ztfNSvKdclr+ijk/mjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GinPt3bi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GinPt3bi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAB931F00A3D;
	Tue,  7 Jul 2026 07:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783409616;
	bh=vyFEOBXlgjE04Kx9jnLW7Vk5RAaqy/+G5fDiKQUYAk0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GinPt3biey0RWOVw/w5D1DqUM4OrLxBddnq6W+p7JQDMfUFdp+Y/fagkQQZiDMAYD
	 b/DGG1MC6YXTzaCEzQDUEJgrGkSxH/sQ7klqckaJ94wIyJN/PozT9/zcOZVxePydTr
	 lrzjsQtTVQatp/jX9LVYdV0VICfw80qWcvwmJE+6c5OTPCnvM/vkDElieFFIqNcxKA
	 7BXt5r8Jbq5NJBqIzp8wn2cN2CvgY3ii49kbhvjXzLLp5BePHGgpaB8jEtGjRvV85E
	 x3JHTq8QPyDhr8I5L4gr9hY3d7Ft5J9cnhaed13AVuBN4SYZ3bRkav2BiqSEdc6pRo
	 m55SfWcjMH1CA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v19 18/40] dept: apply timeout consideration to
 waitqueue wait
Reply-To: sashiko-reviews@lists.linux.dev
To: "Byungchul Park" <byungchul@sk.com>
Cc: cassel@kernel.org, tytso@mit.edu, ojeda@kernel.org, linux-kernel@vger.kernel.org, dlemoal@kernel.org, "Jeff
 Layton" <jlayton@kernel.org>, linux-rt-devel@lists.linux.dev, "Anna
 Schumaker" <anna@kernel.org>, linux-modules@vger.kernel.org, dri-devel@lists.freedesktop.org, "Chuck
 Lever" <cel@kernel.org>, linux-ide@vger.kernel.org
In-Reply-To: <20260706061928.66713-19-byungchul@sk.com>
References: <20260706061928.66713-1-byungchul@sk.com>
 <20260706061928.66713-19-byungchul@sk.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 07:33:34 +0000
Message-Id: <20260707073335.CAB931F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The timeout consideration logic fails for wait_event_hrtimeout()=
, hashed-waitqueues, and DMA fences, causing them to be falsely treated as =
infinite waits.
- [Medium] The ___wait_event() and ___wait_var_event() macros skip the DEPT=
 sleep end annotation on the signal interruption error path, leaking the DE=
PT tracking stage context.
--

commit 25089e0217c82211740316928fec38c6d2b7e4fa
Author: Byungchul Park <byungchul@sk.com>

dept: apply timeout consideration to waitqueue wait

This commit applies timeout consideration to waitqueue waits by using the
ret parameter in ___wait_event() as a timeout value for DEPT tracking. It
leverages CONFIG_DEPT_AGGRESSIVE_TIMEOUT_WAIT to help reduce false positive
deadlock reports for waits that are meant to expire.

> diff --git a/include/linux/wait.h b/include/linux/wait.h
> index c8f8b44060fb9..a9524bc8630b7 100644
> --- a/include/linux/wait.h
> +++ b/include/linux/wait.h
> @@ -306,7 +306,7 @@ extern void init_wait_entry(struct wait_queue_entry *=
wq_entry, int flags);
>  	struct wait_queue_entry __wq_entry;					\
>  	long __ret =3D ret;	/* explicit shadow */				\
>  										\
> -	sdt_might_sleep_start(NULL);						\
> +	sdt_might_sleep_start_timeout(NULL, __ret);				\

[Severity: Medium]
Does this logic also need to be applied to __wait_event_hrtimeout(),
hashed-waitqueues, and DMA fences?

For example, __wait_event_hrtimeout() passes 0 as the 'ret' parameter to
___wait_event(), causing sdt_might_sleep_start_timeout() to treat it as an
infinite wait.

Additionally, hashed-waitqueues (in ___wait_var_event) and DMA fences
(in dma_fence_default_wait and dma_fence_wait_any_timeout) still hardcode
sdt_might_sleep_start(NULL) even when taking a timeout. This seems to cause
DEPT to falsely report deadlocks for these bounded waits.

>  	init_wait_entry(&__wq_entry, exclusive ? WQ_FLAG_EXCLUSIVE : 0);	\
>  	for (;;) {								\
>  		long __int =3D prepare_to_wait_event(&wq_head, &__wq_entry, state);\

[Severity: Medium]
Can the DEPT sleep end annotation be skipped on the signal interruption
error path?

Looking further down in the ___wait_event() macro, if the wait is
interruptible and interrupted by a signal, it takes the goto __out branch:

		if (___wait_is_interruptible(state) && __int) {
			__ret =3D __int;
			goto __out;
		}
		...
	}
	finish_wait(&wq_head, &__wq_entry);
	sdt_might_sleep_end();
__out:	__ret;

This skips over sdt_might_sleep_end(), which leaks the DEPT wait stage
context. As a result, DEPT will mistakenly treat subsequent wait events for
this task as nested waits.

The same issue appears to exist in ___wait_var_event() for
hashed-waitqueues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706061928.6671=
3-1-byungchul@sk.com?part=3D18
