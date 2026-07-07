Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF17D420E96;
	Tue,  7 Jul 2026 07:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783409639; cv=none; b=cQ3Ak7we8cKLBzTBn8r0Wk06D1pANSB1kWrZjJmDdPEDtw2ruWAzXUIvPjKvkH5dCi9f6GhqAmlNXYJQRMiqiudy8ztypjh86XPHTD3j/z7DDq44TrfcYO2UitS8IwNNCE+OmDyCC70KfM9uYxiioG1iFr2JSGfPYc3J+rZhFtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783409639; c=relaxed/simple;
	bh=tJ2kLVjfQkfnCdteDmQxrEMUsFzID5KVW/VUISesMVc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MKT9nc9gl5O82NIZXW3W1B+Wj+pxNhcLHVNFMEi4Wo+UvWBULjbzAuFeAnZqPz+t0B1Ll/PtfZE6NYVDo/kktKUJgzRg98iIVUcKpZB66mt8g+tpXUl91hZ/9OJ0c17YhGjG7HIv9kmxABJKu0EGEfLe2ZbWvvslgxWKpAoJ5rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l3q2zXhZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l3q2zXhZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DE2D1F00A3F;
	Tue,  7 Jul 2026 07:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783409637;
	bh=Gqc0yN61dyCXr/xyiFPr3e6FB9CwzZnnYzAryFZHZZI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=l3q2zXhZmhnLU2y29JqHesS6snhI0xQccelW1TDTBABNOcZoH2srgJ30kyYp01Gfn
	 hFT1bkHEUIE48Vt99HyrHGAohaC8SBC8fXs6B/KCf74fZqdsORgb6ywZQGHh88BMKV
	 i6t+gU5t92lGxSzjiN2vkxEHXQK8/KdNgrDkqB7G8nZEApKNYMEA0r/Fmnfb2x0rOQ
	 QQ53XKjISK+yQLKBAb/31aj6gcML7zHGzpGVAJJGbuV71gbK3k1o+wRDBmZgS8GzBG
	 mrYWYuIaFfeRpN9Eu6N0zSipmj3Q5xXWHDr1FclAUi5+CMbY20OQ4ITRpGWJuiztcl
	 btf5YPeYTEqXg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v19 38/40] mm: percpu: increase
 PERCPU_DYNAMIC_SIZE_SHIFT on DEPT and large PAGE_SIZE
Reply-To: sashiko-reviews@lists.linux.dev
To: "Byungchul Park" <byungchul@sk.com>
Cc: "Jeff Layton" <jlayton@kernel.org>, ojeda@kernel.org, tytso@mit.edu, "Chuck
 Lever" <cel@kernel.org>, "Anna Schumaker" <anna@kernel.org>, linux-kernel@vger.kernel.org, cassel@kernel.org, linux-rt-devel@lists.linux.dev, dri-devel@lists.freedesktop.org, dlemoal@kernel.org, linux-ide@vger.kernel.org, linux-modules@vger.kernel.org
In-Reply-To: <20260706061928.66713-39-byungchul@sk.com>
References: <20260706061928.66713-1-byungchul@sk.com>
 <20260706061928.66713-39-byungchul@sk.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 07:33:56 +0000
Message-Id: <20260707073357.1DE2D1F00A3F@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The patch addresses a compile-time BUILD_BUG_ON failure that no =
longer exists, referencing a deleted structure (`struct kmem_cache_cpu`) an=
d function (`alloc_kmem_cache_cpus()`). Both have been removed from the ups=
tream kernel. The only remaining BUILD_BUG_ON checking `PERCPU_DYNAMIC_EARL=
Y_SIZE` in SLUB is in `alloc_kmem_cache_stats()`, which evaluates `sizeof(s=
truct kmem_cache_stats)`. Because `struct kmem_cache_stats` consists solely=
 of an integer array, its size is entirely unaffected by `CONFIG_DEPT` or `=
local_lock_t`. Thus, this patch needlessly increases the dynamically reserv=
ed per-CPU memory based on an obsolete and misleading justification.
--

commit 279fb8fb2919a407c18ab625ec67d2a3430b7b4d
Author: Byungchul Park <byungchul@sk.com>

mm: percpu: increase PERCPU_DYNAMIC_SIZE_SHIFT on DEPT and large PAGE_SIZE
   =20
This commit increases PERCPU_DYNAMIC_SIZE_SHIFT to 11 when both CONFIG_DEPT
and a PAGE_SIZE larger than 4KiB are enabled. It aims to prevent a build
failure related to the size of struct kmem_cache_cpu.

>     Yunseong reported a build failure due to the BUILD_BUG_ON() statement=
 in
>     alloc_kmem_cache_cpus().  In the following test:
>    =20
>       PERCPU_DYNAMIC_EARLY_SIZE < NR_KMALLOC_TYPES * KMALLOC_SHIFT_HIGH *=
 sizeof(struct kmem_cache_cpu)

[Severity: Medium]
Are we referencing structures and functions that have been removed from the
upstream kernel?

Both alloc_kmem_cache_cpus() and struct kmem_cache_cpu no longer exist
upstream. The only remaining BUILD_BUG_ON() checking PERCPU_DYNAMIC_EARLY_S=
IZE
in SLUB is in alloc_kmem_cache_stats():

mm/slub.c:alloc_kmem_cache_stats() {
	BUILD_BUG_ON(PERCPU_DYNAMIC_EARLY_SIZE <
			NR_KMALLOC_TYPES * KMALLOC_SHIFT_HIGH *
			sizeof(struct kmem_cache_stats));
}

Since struct kmem_cache_stats consists solely of an integer array, its size
is entirely unaffected by CONFIG_DEPT or local_lock_t. Does this mean the
increase in dynamically reserved per-CPU memory is no longer needed?

> diff --git a/include/linux/percpu.h b/include/linux/percpu.h
> index 85bf8dd9f0874..dd74321d4bbd0 100644
> --- a/include/linux/percpu.h
> +++ b/include/linux/percpu.h
> @@ -43,7 +43,11 @@
>  # define PERCPU_DYNAMIC_SIZE_SHIFT      12
>  #endif /* LOCKDEP and PAGE_SIZE > 4KiB */
>  #else
> +#if defined(CONFIG_DEPT) && !defined(CONFIG_PAGE_SIZE_4KB)
> +#define PERCPU_DYNAMIC_SIZE_SHIFT      11
> +#else
>  #define PERCPU_DYNAMIC_SIZE_SHIFT      10
> +#endif /* DEPT and PAGE_SIZE > 4KiB */
>  #endif

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706061928.6671=
3-1-byungchul@sk.com?part=3D38
