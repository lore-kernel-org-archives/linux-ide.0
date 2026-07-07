Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356F94028F5;
	Tue,  7 Jul 2026 07:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783409626; cv=none; b=s4x0M9jvSapjF+MmLyDkSFmfe30PfHpVJRpihTKfGX98EPClSRU0AODX0EiIxQg/tNla92MKoOcBV9/CXFwtI30II//GQgPqif2qwtTnu+kSdlf02JG+UgmYI8h6ZOqt+4VJtsg7YkOBUrwmtnOd76rYETrhlUlHQfz1a6OPMeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783409626; c=relaxed/simple;
	bh=EtlbtzG4Cuo4WefMIHmj9osyvNp/AuWjixGzJaeaRXA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gcF9ZD/tlsnfLKtlGk4NgUVJfWpC383dtTnbmlOBmO2+1WMqbj6RIah/itXwcONB3e88p0I2MgEbDJz4cHy2PrGo3nxw+PpFfgxMnjNF3aDytbqaI6S0hkGZEi/C8UuKnQz3Zvwd3JtKcOz4kRO8s38Wg2B3Zx57lZ4O2Rpiia4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OHyYsmkI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OHyYsmkI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7392B1F000E9;
	Tue,  7 Jul 2026 07:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783409625;
	bh=2BFynzDzCliPcjcFgwiOh4hD0fCZGiv9eLbuu/gfUXo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OHyYsmkI7NYbdwoQrNWbSbms/DzBipykfBZ7lAnRkMunfbXBmHFP0gNXZ7xTS9wH/
	 De4imz4DvADDrhXdUwJFux5F6CxCRd8BiQ5Uzz7ojI/f+cGb56YfgFmPwsIQo+aW2U
	 C+bi+beXehGZw+osAjtTvzMwLaS2Aj1ndFOHQ3Mj4orGW9VXQ9ZXRkux2fvA4++aOf
	 VezXaJdK+0bzu45bxCugFycIVyuzxCnA1DAliLQx5s1FUyrfHPDkjpPfkDJLeNT29i
	 JmAPn0F2otsNkkViuxxpJmQarkcURiRon4j+eo8awH4RtbNCRY6D/ghE8EPerwHplf
	 ZdML0TtfGXGiA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v19 28/40] dept: assign unique dept_key to each distinct
 dma fence caller
Reply-To: sashiko-reviews@lists.linux.dev
To: "Byungchul Park" <byungchul@sk.com>
Cc: "Chuck Lever" <cel@kernel.org>, dlemoal@kernel.org, "Jeff Layton" <jlayton@kernel.org>, linux-rt-devel@lists.linux.dev, linux-modules@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-ide@vger.kernel.org, tytso@mit.edu, cassel@kernel.org, ojeda@kernel.org, "Anna
 Schumaker" <anna@kernel.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20260706061928.66713-29-byungchul@sk.com>
References: <20260706061928.66713-1-byungchul@sk.com>
 <20260706061928.66713-29-byungchul@sk.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 07:33:44 +0000
Message-Id: <20260707073344.7392B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The newly introduced statement expression macros for DMA fence w=
aiting evaluate their timeout argument (`t`) multiple times.
- [Medium] Local variable shadowing in the statement expression macros due =
to the unhygienic `__ret` variable declaration.
--

commit 4d4caad8d173eededcba1493c060f5ddecbd6b70
Author: Byungchul Park <byungchul@sk.com>

dept: assign unique dept_key to each distinct dma fence caller

dma fence can be used at various points in the code and it's very hard
to distinguish dma fences between different usages.  Using a single
dept_key for all the dma fences could trigger false positive reports.

> diff --git a/include/linux/dma-fence.h b/include/linux/dma-fence.h
> index d4c92fd350924..3732849a30b7e 100644
> --- a/include/linux/dma-fence.h
> +++ b/include/linux/dma-fence.h

[ ... ]

> @@ -370,8 +370,22 @@ bool dma_fence_check_and_signal_locked(struct dma_fe=
nce *fence);
>  void dma_fence_signal_locked(struct dma_fence *fence);
>  void dma_fence_signal_timestamp(struct dma_fence *fence, ktime_t timesta=
mp);
>  void dma_fence_signal_timestamp_locked(struct dma_fence *fence, ktime_t =
timestamp);
> -signed long dma_fence_default_wait(struct dma_fence *fence,
> +signed long __dma_fence_default_wait(struct dma_fence *fence,
>  				   bool intr, signed long timeout);
> +
> +/*
> + * Associate every caller with its own dept map.
> + */
> +#define dma_fence_default_wait(f, intr, t)				\
> +({									\
> +	signed long __ret;						\

[Severity: Medium]
Could this local variable declaration lead to shadowing issues? If a caller
passes arguments that reference a variable named __ret in their own scope,
this uninitialized local variable will shadow the caller's variable, causing
undefined behavior.

> +									\
> +	sdt_might_sleep_start_timeout(NULL, t);				\
> +	__ret =3D __dma_fence_default_wait(f, intr, t);			\

[Severity: Medium]
Is it safe to evaluate the timeout argument t multiple times here?

If a caller passes an expression with side effects, such as timeout--, it
would be evaluated twice, which could lead to incorrect timeout logic.

> +	sdt_might_sleep_end();						\
> +	__ret;								\
> +})
> +

[ ... ]

> @@ -628,12 +642,37 @@ static inline ktime_t dma_fence_timestamp(struct dm=
a_fence *fence)
>  	return fence->timestamp;
>  }
> =20
> -signed long dma_fence_wait_timeout(struct dma_fence *,
> +signed long __dma_fence_wait_timeout(struct dma_fence *,
>  				   bool intr, signed long timeout);
> -signed long dma_fence_wait_any_timeout(struct dma_fence **fences,
> +signed long __dma_fence_wait_any_timeout(struct dma_fence **fences,
>  				       uint32_t count,
>  				       bool intr, signed long timeout,
>  				       uint32_t *idx);
> +/*
> + * Associate every caller with its own dept map.
> + */
> +#define dma_fence_wait_timeout(f, intr, t)				\
> +({									\
> +	signed long __ret;						\
> +									\
> +	sdt_might_sleep_start_timeout(NULL, t);				\
> +	__ret =3D __dma_fence_wait_timeout(f, intr, t);			\

[Severity: Medium]
Does this code also suffer from the same macro hygiene issues with shadowing
__ret and evaluating the t argument twice?

> +	sdt_might_sleep_end();						\
> +	__ret;								\
> +})
> +
> +/*
> + * Associate every caller with its own dept map.
> + */
> +#define dma_fence_wait_any_timeout(fpp, count, intr, t, idx)		\
> +({									\
> +	signed long __ret;						\
> +									\
> +	sdt_might_sleep_start_timeout(NULL, t);				\
> +	__ret =3D __dma_fence_wait_any_timeout(fpp, count, intr, t, idx);	\

[Severity: Medium]
Would it be safer to use a more unique variable name instead of __ret, and
evaluate t only once before passing it to sdt_might_sleep_start_timeout()
and __dma_fence_wait_any_timeout(), similar to the other macros?

> +	sdt_might_sleep_end();						\
> +	__ret;								\
> +})

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706061928.6671=
3-1-byungchul@sk.com?part=3D28
