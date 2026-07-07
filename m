Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460E23AE6E5;
	Tue,  7 Jul 2026 07:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783409603; cv=none; b=quK8XkKfJGjV8ybgEvsTXkXIDpEQPFcWp9QhMNhQhIEHojla3pTsbnJPWpGUJBxZz4MZbWZk/R40IPysuossZ/wsN5aym3dz5CjwI3VwmJxM+ib9rqCduDpL8retIjG3az14ZxYadNUl3dfXklxjWpYuPg0IAbeH581oENte+50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783409603; c=relaxed/simple;
	bh=pGYCyXRK2yYV5Ttr7avkJ6eShZsXTI1NNIavnFmWzcw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=B52/tpt0XNvEw1946TtIJXE9seyVf3+pKk61CWk1xN6aCMLfx5T2jQJiUxvX3jb6v5ei698P139/a6odlR/sosHZMxGJgbcvGL0bDzaLlvhnBJeTwDXnEYrPJBV6sFDlVpLek8lVrEXcPOH8gTAV09kgtpirWXTup5rnnvkLlLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G1tFwiSL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G1tFwiSL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 731D11F00A3F;
	Tue,  7 Jul 2026 07:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783409602;
	bh=B+/XC3pWnPrw6raRJdBi8Hg3nc0HCH4EyJEtBIzzqSk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=G1tFwiSLEda+byN8nnSKVdu3qVjBOOZYzY2j16VjNJigoIn3WwphRuPeCyNBpvyvw
	 99zgbLByOUlVwf0F1OOtjiW6gYWSx4dhImgxj9fFaneYt1YQ9kPB6H4IPpbhKslTUi
	 oGZtz1Hf2P7k+5APd7MkLlOF4cREHrvpHC+K61mhvZMSu8uNk4+MLZPTN9mAjhzSVY
	 bZd7Dec6fOUyXk1M0godpj8iRUNS77AajVsYR7Ytrt4sjMoVNRcXXb5XDrIG9SrdYF
	 qSNScWun/V/ow2Qnvfj50W0uabFczVfumIusXx9ptKmCAN3YkJ3L2uY9N86XynN04s
	 porkYJkw4jCGQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v19 12/40] dept: apply sdt_might_sleep_{start, end}() to
 waitqueue wait
Reply-To: sashiko-reviews@lists.linux.dev
To: "Byungchul Park" <byungchul@sk.com>
Cc: dri-devel@lists.freedesktop.org, linux-rt-devel@lists.linux.dev, cassel@kernel.org, "Chuck
 Lever" <cel@kernel.org>, linux-kernel@vger.kernel.org, dlemoal@kernel.org, linux-modules@vger.kernel.org, linux-ide@vger.kernel.org, ojeda@kernel.org, "Jeff
 Layton" <jlayton@kernel.org>, tytso@mit.edu, "Anna Schumaker" <anna@kernel.org>
In-Reply-To: <20260706061928.66713-13-byungchul@sk.com>
References: <20260706061928.66713-1-byungchul@sk.com>
 <20260706061928.66713-13-byungchul@sk.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 07:33:21 +0000
Message-Id: <20260707073321.731D11F00A3F@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The `sdt_might_sleep_end()` cleanup macro is bypassed when wait lo=
ops (`___wait_event`, `___swait_event`) are interrupted by a signal, perman=
ently leaking a DEPT dependency stage.
--

commit 1300cac9c94eeb3955744b6d40ed8dce8cfc059f
Author: Byungchul Park <byungchul@sk.com>

dept: apply sdt_might_sleep_{start,end}() to waitqueue wait
   =20
Make dept able to track dependencies by waitqueue waits.

> diff --git a/include/linux/wait.h b/include/linux/wait.h
> index dce055e6add39..c8f8b44060fb9 100644
> --- a/include/linux/wait.h
> +++ b/include/linux/wait.h

[ ... ]

> @@ -305,6 +306,7 @@ extern void init_wait_entry(struct wait_queue_entry *=
wq_entry, int flags);
>  	struct wait_queue_entry __wq_entry;					\
>  	long __ret =3D ret;	/* explicit shadow */				\
>  										\
> +	sdt_might_sleep_start(NULL);						\
>  	init_wait_entry(&__wq_entry, exclusive ? WQ_FLAG_EXCLUSIVE : 0);	\
>  	for (;;) {								\
>  		long __int =3D prepare_to_wait_event(&wq_head, &__wq_entry, state);\
> @@ -323,6 +325,7 @@ extern void init_wait_entry(struct wait_queue_entry *=
wq_entry, int flags);
>  			break;							\
>  	}									\
>  	finish_wait(&wq_head, &__wq_entry);					\
> +	sdt_might_sleep_end();							\
>  __out:	__ret;									\
>  })

[Severity: High]
Does this bypass sdt_might_sleep_end() when interrupted by a signal?

Looking at ___wait_event(), if ___wait_is_interruptible(state) and __int is
set, it will take the goto __out path:

		if (___wait_is_interruptible(state) && __int) {			\
			__ret =3D __int;						\
			goto __out;						\
		}								\

If that path is taken, sdt_might_sleep_end() is bypassed, which permanently
leaks a DEPT dependency stage. A stale wait context remains in the task's
dependency tracker state. When the task later sleeps for unrelated reasons,
the scheduler might attribute the sleep to the leaked context, leading to
false-positive lockup splats.

Also, does this same structural issue exist in ___swait_event() in
include/linux/swait.h for simple waitqueues?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706061928.6671=
3-1-byungchul@sk.com?part=3D12
