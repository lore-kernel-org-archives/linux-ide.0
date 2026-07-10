Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA1EA3B1EEE;
	Fri, 10 Jul 2026 06:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783665621; cv=none; b=RLrKx6rDgzxoQYHk11w/fG5cpVH+0zoKHPMBATRpj5cwbcXgfJkvLzup8fYE4C1l6E6sFXJPRIs9ceZ19xydhZgE3E8oL7Iv3yZuOJzVD3cTTJ197+0+mGcHPLoHFaSrtmWmxqeyO7t7mvOKonnxGeege8z7s2cddgxA+ti9NJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783665621; c=relaxed/simple;
	bh=LCu5mNfia66atmgca3pXzqsxGStrRsW3Bxipj7Eivg4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mdsPn98604q5LQrNnPV0x3m8+OBqGDI07jzik5dv5ZEq9Hur+oFGxkW1Ern/P7S3PrnF7RdY6K1aIbkRG+eHa7dObWo+LwZOk0vKCS3WnpEBsvc7dOHbafZ1/IbwgWVZCGfkRcBNCknG/4caPN/bBhDTHfO7hPepzR6xibl+tVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-c45ff70000001609-d2-6a5093cf72db
Date: Fri, 10 Jul 2026 15:40:10 +0900
From: Byungchul Park <byungchul@sk.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-rt-devel@lists.linux.dev, cassel@kernel.org,
	linux-ide@vger.kernel.org, tytso@mit.edu,
	linux-kernel@vger.kernel.org, Anna Schumaker <anna@kernel.org>,
	linux-modules@vger.kernel.org, Chuck Lever <cel@kernel.org>,
	ojeda@kernel.org, dlemoal@kernel.org,
	dri-devel@lists.freedesktop.org, Jeff Layton <jlayton@kernel.org>,
	kernel_team@skhynix.com
Subject: Re: [PATCH v19 07/40] dept: distinguish each work from another
Message-ID: <20260710064010.GG37630@system.software.com>
References: <20260706061928.66713-1-byungchul@sk.com>
 <20260706061928.66713-8-byungchul@sk.com>
 <20260707073334.0E5A61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260707073334.0E5A61F000E9@smtp.kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphkeLIzCtJLcpLzFFi42LhesuzUPf85IAsg+Z36hatO/+zWBybsILZ
	Yt2LI2wWD/bbW1z5+p7N4ueyVewWx3Y8YrK4vGsOm0XD7O+sFpdWX2CxWDl/OaNFw9LbrBat
	PT/ZHXg9Nq3qZPO4332cyePF5pmMHk1njjJ7fN4kF8AaxWWTkpqTWZZapG+XwJWx4uRD5oL1
	IhX33nxkaWDcLdDFyMkhIWAi8Xz1FzYYu+1vDzOIzSKgKvF55TQmEJtNQF3ixo2fYHERAWWJ
	2TvOAsW5OJgFXjFJ7Do0nREkISzgLvHi/WMwm1fAQuLY/x9gQ4UEJjJKzPipDxEXlDg58wkL
	iM0soCOxc+sdoBoOIFtaYvk/DoiwvETz1tlguzgFrCSez/nHDmKLAu09sO042F4JgedsEm8m
	H2aBOFpS4uCKGywTGAVnIVkxC8mKWQgrZiFZsYCRZRWjUGZeWW5iZo6JXkZlXmaFXnJ+7iZG
	YBwtq/0TvYPx04XgQ4wCHIxKPLwG9f5ZQqyJZcWVuYcYJTiYlUR4H8gAhXhTEiurUovy44tK
	c1KLDzFKc7AoifMafStPERJITyxJzU5NLUgtgskycXBKNTA2P3jMmX9Nu+zsF9v5mfdq2RTF
	0zI5evLObLq96ubP75N2O01v/ynh9Kfl9kf37UZeH6PPz/7F45y4rH2CgErdM6YPnTO+CZ4t
	WlRXsWQWw1xO7z5eZkmXnIYrzbs8QzSk8iqXX5z3LHTekumbcu9vc3y4+HzcV34ZKZHdR1fr
	ijlbccuvaF+ixFKckWioxVxUnAgAa3LDdp8CAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrMLMWRmVeSWpSXmKPExsXC5WfdrHt+ckCWwcrJ/BatO/+zWBybsILZ
	Yt2LI2wWD/bbW1z5+p7N4ueyVewWh+eeZLU4tuMRk8XlXXPYLBpmf2e1uLT6AovFyvnLGS0a
	lt5mtWjt+cnuwOexaVUnm8f97uNMHi82z2T0aDpzlNlj8YsPTB6fN8kFsEVx2aSk5mSWpRbp
	2yVwZaw4+ZC5YL1Ixb03H1kaGHcLdDFyckgImEi0/e1hBrFZBFQlPq+cxgRiswmoS9y48RMs
	LiKgLDF7x1mgOBcHs8ArJoldh6YzgiSEBdwlXrx/DGbzClhIHPv/gw3EFhKYyCgx46c+RFxQ
	4uTMJywgNrOAjsTOrXeAajiAbGmJ5f84IMLyEs1bZ4Pt4hSwkng+5x87iC0KtPfAtuNMExj5
	ZiGZNAvJpFkIk2YhmbSAkWUVo0hmXlluYmaOqV5xdkZlXmaFXnJ+7iZGYFQsq/0zcQfjl8vu
	hxgFOBiVeHgN6v2zhFgTy4orcw8xSnAwK4nwPpABCvGmJFZWpRblxxeV5qQWH2KU5mBREuf1
	Ck9NEBJITyxJzU5NLUgtgskycXBKNTAy/ODbsHDVxwO9FrJxx00vFy17PN/VRluU1cq55q1j
	sreraJNu8DPBA4rrpFat6FJ2MIg2Toq7fXWZxN+6Tx47ONd7bYmUflvXzeH/9MU7TeUNu16L
	u73qcnxlrTpbMfff6vJSH+al+i9eZzN9mLv48hGVW39kE965bBN/2rClw2fCe6dzKTlKLMUZ
	iYZazEXFiQAypySkhgIAAA==
X-CFilter-Loop: Reflected

On Tue, Jul 07, 2026 at 07:33:33AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] `dept_update_cxt()` hardcodes the process context ID, failing to track bottom-half (BH) work items in softirq context and corrupting the context of preempted tasks.
> --
> 
> commit b8dda7d95e5377770d28c6712cf8fe7fafa98ade
> Author: Byungchul Park <byungchul@sk.com>
> 
> dept: distinguish each work from another
> 
> This commit updates DEPT to assign a different context ID to each work item.
> Since workqueues provide their own concurrency control, wait operations in a
> work item do not prevent events in other works from executing.
> 
> > diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> > index c6ea96d5b7167..4a4075d0697c7 100644
> > --- a/kernel/workqueue.c
> > +++ b/kernel/workqueue.c
> [ ... ]
> > @@ -3204,6 +3205,8 @@ __acquires(&pool->lock)
> >
> >       lockdep_copy_map(&lockdep_map, &work->lockdep_map);
> >  #endif
> > +     dept_update_cxt();
> > +
> 
> [Severity: Medium]
> Will this unconditionally modify the process context ID, even when tracking
> bottom-half (BH) work items running in softirq context?

Am I missing something?  AFAIK, workqueue's workers run in process
context, not softirq context.

> When a BH workqueue executes multiple work items in a single softirq batch,
> process_one_work() executes them and calls dept_update_cxt(). However,
> dept_update_cxt() is implemented as:

It's becasue its not racing with other contexts.

> kernel/dependency/dept.c:dept_update_cxt() {
>     struct dept_task *dt = dept_task();
>     dt->cxt_id[DEPT_CXT_PROCESS] += 1UL << DEPT_CXTS_NR;
> }
> 
> This hardcodes the increment to DEPT_CXT_PROCESS rather than checking
> cur_cxt() to increment DEPT_CXT_SIRQ. Does this cause DEPT to fail in
> distinguishing sequential BH work items and falsely report dependencies?

Are BH works running in softirq context?  I will check it.

> Also, can this corrupt the continuous dependency tracking context of
> whatever task was preempted by the softirq?

Process context's cxt_id is referred only in the process context, and
irq context's cxt_id is referred only in the irq context.  So no problem.

	Byungchul

> >       /* ensure we're on the correct CPU */
> >       WARN_ON_ONCE(!(pool->flags & POOL_DISASSOCIATED) &&
> >                    raw_smp_processor_id() != pool->cpu);
> 
> --
> Sashiko AI review · https://sashiko.dev/#/patchset/20260706061928.66713-1-byungchul@sk.com?part=7
