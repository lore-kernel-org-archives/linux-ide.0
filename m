Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0BB93955C4;
	Fri, 10 Jul 2026 05:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783662964; cv=none; b=XIWkM5tWJtygqLk3WIXqKG0aWS6DFfZe1GzBjimr7Q9QRr9Csb8pO2Bjc2av5AGtK8fYvvn3+V0c1MFSCnk0Sgme8r43yP7QiK1MdynaykJ4VEjZUegvHuYvuE0l2WSWjVM9FZm3rsfRkEzPNVFsnIFu2qeM6cyWc9P62e2ZmWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783662964; c=relaxed/simple;
	bh=KeZxwwFyGt63rC86rXCi4qDv4EmmsaULDXn9p3yNHlA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nOloKfv/h151RZtPxb7HrG2H4u3b9I8wszGvPip0/hwSrhTAVynJ/ebFAbXPDI7TyCUVaVmMuEPUnDb4/UAvDWXDQSl8nswmRDRv81fhFFJ2S7Ee1/Y8x6wT6iWHxoS7nQ/0foUJ3+AZcNftfWKzvTz4LNYsZynK+EoFYlNbxco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-c2dff70000001609-a0-6a508970bfb3
Date: Fri, 10 Jul 2026 14:55:55 +0900
From: Byungchul Park <byungchul@sk.com>
To: sashiko-reviews@lists.linux.dev
Cc: Jeff Layton <jlayton@kernel.org>, ojeda@kernel.org, tytso@mit.edu,
	Chuck Lever <cel@kernel.org>, Anna Schumaker <anna@kernel.org>,
	linux-kernel@vger.kernel.org, cassel@kernel.org,
	linux-rt-devel@lists.linux.dev, dri-devel@lists.freedesktop.org,
	dlemoal@kernel.org, linux-ide@vger.kernel.org,
	linux-modules@vger.kernel.org, kernel_team@skhynix.com
Subject: Re: [PATCH v19 38/40] mm: percpu: increase PERCPU_DYNAMIC_SIZE_SHIFT
 on DEPT and large PAGE_SIZE
Message-ID: <20260710055555.GB37630@system.software.com>
References: <20260706061928.66713-1-byungchul@sk.com>
 <20260706061928.66713-39-byungchul@sk.com>
 <20260707073357.1DE2D1F00A3F@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260707073357.1DE2D1F00A3F@smtp.kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupikeLIzCtJLcpLzFFi42LhesuzULewMyDLoJ/VonXnfxaLYxNWMFus
	e3GEzeLBfnuLK1/fs1n8XLaK3eLYjkdMFpd3zWGzaJj9ndXi0uoLLBYr5y9ntGhYehuotecn
	uwOvx6ZVnWwe97uPM3m82DyT0aPpzFFmj8+b5AJYo7hsUlJzMstSi/TtErgypv//wlZwUrzi
	2583TA2MC4S7GDk5JARMJN6e+8rexcgBZj9YFAkSZhFQldi/qpsZxGYTUJe4ceMnmC0ioCwx
	e8dZpi5GLg5mgRdMEs8/HwBLCAtkS+x+dI0dxOYVsJBY9vEYWJGQwCRGide77zBBJAQlTs58
	wgJiMwvoSOzceocNZDGzgLTE8n8cEGF5ieats8FmcgpYSWxp+g/WKgq0+MC240wQNz9nk+h+
	lgZhS0ocXHGDZQKj4CwkG2Yh2TALYcMsJBsWMLKsYhTKzCvLTczMMdHLqMzLrNBLzs/dxAiM
	oWW1f6J3MH66EHyIUYCDUYmH16DeP0uINbGsuDL3EKMEB7OSCO8DGaAQb0piZVVqUX58UWlO
	avEhRmkOFiVxXqNv5SlCAumJJanZqakFqUUwWSYOTqkGxo6QEJ8F2ZVM+83L5uxLZsp/w18U
	aS+1a8qJaP5oZomjNasTbja8mten7nD+/l/+vY++SFjsM+7k7zhdynDhiaCICONdCw8dJrNF
	zZ7X11/7xP/qK+umQhGhxRKnAgJ9jFeKMTos89zTveTDmbarC3+sSayOa13FY5phZqf4i+Pw
	RrcA52cJSizFGYmGWsxFxYkAW4ACRJ0CAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrMLMWRmVeSWpSXmKPExsXC5WfdrFvQGZBlcOaCsUXrzv8sFscmrGC2
	WPfiCJvFg/32Fle+vmez+LlsFbvF4bknWS2O7XjEZHF51xw2i4bZ31ktLq2+wGKxcv5yRouG
	pbdZLVp7frI78HlsWtXJ5nG/+ziTx4vNMxk9ms4cZfZY/OIDk8fnTXIBbFFcNimpOZllqUX6
	dglcGdP/f2ErOCle8e3PG6YGxgXCXYwcHBICJhIPFkV2MXJysAioSuxf1c0MYrMJqEvcuPET
	zBYRUJaYveMsUxcjFwezwAsmieefD4AlhAWyJXY/usYOYvMKWEgs+3gMrEhIYBKjxOvdd5gg
	EoISJ2c+YQGxmQV0JHZuvcMGsphZQFpi+T8OiLC8RPPW2WAzOQWsJLY0/QdrFQVafGDbcaYJ
	jHyzkEyahWTSLIRJs5BMWsDIsopRJDOvLDcxM8dUrzg7ozIvs0IvOT93EyMwKpbV/pm4g/HL
	ZfdDjAIcjEo8vAb1/llCrIllxZW5hxglOJiVRHgfyACFeFMSK6tSi/Lji0pzUosPMUpzsCiJ
	83qFpyYICaQnlqRmp6YWpBbBZJk4OKUaGP0UwhvX1ZUEpFy6MPEt967sq1xS+xYJLY3M4Xzq
	5dBf/Wxxu9KNoDQbpugKPeegm0tEWhRzN3LwTw/6fTfyU8v5KZt4/4r+/Zr1ZdLsJy9urWc2
	2TXfRdyAX3t3/M1Ury+rb0mqH/Za0NJ9Os/Noi4z8jjj5naJdSav247sE79zP+mSkJj4bSWW
	4oxEQy3mouJEAKzaWcKGAgAA
X-CFilter-Loop: Reflected

On Tue, Jul 07, 2026 at 07:33:56AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] The patch addresses a compile-time BUILD_BUG_ON failure that no longer exists, referencing a deleted structure (`struct kmem_cache_cpu`) and function (`alloc_kmem_cache_cpus()`). Both have been removed from the upstream kernel. The only remaining BUILD_BUG_ON checking `PERCPU_DYNAMIC_EARLY_SIZE` in SLUB is in `alloc_kmem_cache_stats()`, which evaluates `sizeof(struct kmem_cache_stats)`. Because `struct kmem_cache_stats` consists solely of an integer array, its size is entirely unaffected by `CONFIG_DEPT` or `local_lock_t`. Thus, this patch needlessly increases the dynamically reserved per-CPU memory based on an obsolete and misleading justification.
> --
> 
> commit 279fb8fb2919a407c18ab625ec67d2a3430b7b4d
> Author: Byungchul Park <byungchul@sk.com>
> 
> mm: percpu: increase PERCPU_DYNAMIC_SIZE_SHIFT on DEPT and large PAGE_SIZE
> 
> This commit increases PERCPU_DYNAMIC_SIZE_SHIFT to 11 when both CONFIG_DEPT
> and a PAGE_SIZE larger than 4KiB are enabled. It aims to prevent a build
> failure related to the size of struct kmem_cache_cpu.
> 
> >     Yunseong reported a build failure due to the BUILD_BUG_ON() statement in
> >     alloc_kmem_cache_cpus().  In the following test:
> >
> >       PERCPU_DYNAMIC_EARLY_SIZE < NR_KMALLOC_TYPES * KMALLOC_SHIFT_HIGH * sizeof(struct kmem_cache_cpu)
> 
> [Severity: Medium]
> Are we referencing structures and functions that have been removed from the
> upstream kernel?
> 
> Both alloc_kmem_cache_cpus() and struct kmem_cache_cpu no longer exist
> upstream. The only remaining BUILD_BUG_ON() checking PERCPU_DYNAMIC_EARLY_SIZE
> in SLUB is in alloc_kmem_cache_stats():
> 
> mm/slub.c:alloc_kmem_cache_stats() {
>         BUILD_BUG_ON(PERCPU_DYNAMIC_EARLY_SIZE <
>                         NR_KMALLOC_TYPES * KMALLOC_SHIFT_HIGH *
>                         sizeof(struct kmem_cache_stats));
> }
> 
> Since struct kmem_cache_stats consists solely of an integer array, its size
> is entirely unaffected by CONFIG_DEPT or local_lock_t. Does this mean the
> increase in dynamically reserved per-CPU memory is no longer needed?

Agree.  It seems no longer needed.  I will fix it.

	Byungchul

> > diff --git a/include/linux/percpu.h b/include/linux/percpu.h
> > index 85bf8dd9f0874..dd74321d4bbd0 100644
> > --- a/include/linux/percpu.h
> > +++ b/include/linux/percpu.h
> > @@ -43,7 +43,11 @@
> >  # define PERCPU_DYNAMIC_SIZE_SHIFT      12
> >  #endif /* LOCKDEP and PAGE_SIZE > 4KiB */
> >  #else
> > +#if defined(CONFIG_DEPT) && !defined(CONFIG_PAGE_SIZE_4KB)
> > +#define PERCPU_DYNAMIC_SIZE_SHIFT      11
> > +#else
> >  #define PERCPU_DYNAMIC_SIZE_SHIFT      10
> > +#endif /* DEPT and PAGE_SIZE > 4KiB */
> >  #endif
> 
> --
> Sashiko AI review · https://sashiko.dev/#/patchset/20260706061928.66713-1-byungchul@sk.com?part=38
