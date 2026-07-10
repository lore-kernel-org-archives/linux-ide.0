Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE9363254A2;
	Fri, 10 Jul 2026 06:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783663474; cv=none; b=lt+Ovxng3+ltqSX5iCvLF5OW4lXAoUH/Piqb8O+mx9XPuSxa+vvWwq8+z4TpORzby2FPj5Yt6TBdq4trgmcxXcJlgH0f5/3p5NNY+uYFj25+bn75YcsJzjdPbZosTpHILDD2kQpwKax5QRfTjlfW2e4OJx6SLcMZN9joQhBMOgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783663474; c=relaxed/simple;
	bh=frsAzs6Fns3ml4wFMAWfL0126lZPotfz0Z5KGZ2p4ok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GuEbxVGSwXwYS+ZXBunA9y83EkkIkqPQWjZOJ6slrAD0G7WfSGNBqO0ymRn8yqfBkywRz4v0EswLtQFWJ64riUkBHFiwlWdWJ0yKpPkKuTdayk/IeVaRw7EP0WkuoS4yhmq/GLrKTWN4+PPugooPRQ76QNfRwRGRmjwavuZZEcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-c2dff70000001609-24-6a508b6af58b
Date: Fri, 10 Jul 2026 15:04:21 +0900
From: Byungchul Park <byungchul@sk.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-modules@vger.kernel.org, Chuck Lever <cel@kernel.org>,
	Anna Schumaker <anna@kernel.org>, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	dlemoal@kernel.org, cassel@kernel.org, tytso@mit.edu,
	Jeff Layton <jlayton@kernel.org>, ojeda@kernel.org,
	linux-ide@vger.kernel.org, kernel_team@skhynix.com
Subject: Re: [PATCH v19 29/40] dept: make dept aware of
 lockdep_set_lock_cmp_fn() annotation
Message-ID: <20260710060421.GC37630@system.software.com>
References: <20260706061928.66713-1-byungchul@sk.com>
 <20260706061928.66713-30-byungchul@sk.com>
 <20260707073345.A320A1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260707073345.A320A1F00A3D@smtp.kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupikeLIzCtJLcpLzFFi42LhesuzSDerOyDL4MEmQ4vWnf9ZLI5NWMFs
	se7FETaLB/vtLa58fc9m8XPZKnaLYzseMVlc3jWHzaJh9ndWi0urL7BYrJy/nNGiYeltVovW
	np/sDrwem1Z1snnc7z7O5PFi80xGj6YzR5k9Pm+SC2CN4rJJSc3JLEst0rdL4Mo4+OUVc0GL
	WMXSv4uYGxgfCXQxcnJICJhIPF0wnw3G3n7vEDuIzSKgKtH1ey4riM0moC5x48ZPZhBbREBZ
	YvaOs0xdjFwczAIvmCQ+3t4PlhAWiJP4fmwSC4jNK2AhsffLd7BBQgKTGCVWvmeFiAtKnJz5
	BKyGWUBHYufWO0CLOYBsaYnl/zggwvISzVtnM4OEOQWsJI78SQEJiwKtPbDtOBPEmc/ZJFZe
	cYWwJSUOrrjBMoFRcBaSBbOQLJiFsGAWkgULGFlWMQpl5pXlJmbmmOhlVOZlVugl5+duYgTG
	0LLaP9E7GD9dCD7EKMDBqMTDa1DvnyXEmlhWXJl7iFGCg1lJhPeBDFCINyWxsiq1KD++qDQn
	tfgQozQHi5I4r9G38hQhgfTEktTs1NSC1CKYLBMHp1QDY3ZpzTM/QaXqxH8OJxs/1nCZ/m3i
	XemvFbt+n9bnHMfk6s5/JtLWPTMf7LVReyRhsSpZgKXrkbHfj4CvsTfKHWtcd6YdrLxVz/Zx
	An9Ge01So9XSG2s36b7S26oQ8izjleXvS5y1v9MqVl3ewXTvy3E9sdR/+Y7/zGeJfZN9+vPy
	pdIjd8U0lViKMxINtZiLihMBvzyBZZ0CAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrELMWRmVeSWpSXmKPExsXC5WfdrJvVHZBl0Pdb0aJ1538Wi2MTVjBb
	rHtxhM3iwX57iytf37NZ/Fy2it3i8NyTrBbHdjxisri8aw6bRcPs76wWl1ZfYLFYOX85o0XD
	0tusFq09P9kd+Dw2repk87jffZzJ48XmmYweTWeOMnssfvGByePzJrkAtigum5TUnMyy1CJ9
	uwSujINfXjEXtIhVLP27iLmB8ZFAFyMnh4SAicT2e4fYQWwWAVWJrt9zWUFsNgF1iRs3fjKD
	2CICyhKzd5xl6mLk4mAWeMEk8fH2frCEsECcxPdjk1hAbF4BC4m9X76DDRISmMQosfI9K0Rc
	UOLkzCdgNcwCOhI7t95h62LkALKlJZb/44AIy0s0b53NDBLmFLCSOPInBSQsCrT2wLbjTBMY
	+WYhGTQLyaBZCINmIRm0gJFlFaNIZl5ZbmJmjqlecXZGZV5mhV5yfu4mRmBMLKv9M3EH45fL
	7ocYBTgYlXh4Der9s4RYE8uKK3MPMUpwMCuJ8D6QAQrxpiRWVqUW5ccXleakFh9ilOZgURLn
	9QpPTRASSE8sSc1OTS1ILYLJMnFwSjUwHknTVrSzM2L+nntvba+6qhezZIzEgoYCoScthTE+
	F3lOLjnTdsJgkm9TXsbfgiebP1gujz2VoFVfdDTKc8HboOT6rC+qQcLLlb82vHx20VD/4Rvd
	pUa7p2xfXtD0+XbAJc/7gdkXZ0mf7zhz89fktbmFpfLeibdm7GrclGpzneNSz8XDG7T2KbEU
	ZyQaajEXFScCAMjdpqiFAgAA
X-CFilter-Loop: Reflected

On Tue, Jul 07, 2026 at 07:33:45AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] DEPT falsely reports a deadlock when a task sequentially acquires three or more locks of the same class (or interleaves them with other locks), because the `lockdep_cmp_fn` bypass is improperly restricted to only the immediately preceding lock.
> --
> 
> commit d03c5b926a945b89f5a90fd98986386e113df5af
> Author: Byungchul Park <byungchul@sk.com>
> 
> dept: make dept aware of lockdep_set_lock_cmp_fn() annotation
> 
> This commit updates the DEPT (Dependency Tracker) subsystem to respect the
> lockdep_set_lock_cmp_fn() annotation. It allows DEPT to avoid false positive
> deadlock reports by using the custom comparison function when evaluating
> dependencies between locks of the same class.
> 
> > diff --git a/kernel/dependency/dept.c b/kernel/dependency/dept.c
> > --- a/kernel/dependency/dept.c
> > +++ b/kernel/dependency/dept.c
> 
> [ ... ]
> 
> > @@ -1658,8 +1688,13 @@ static void add_wait(struct dept_class *c, unsigned long ip,
> >               if (!eh->ecxt)
> >                       continue;
> >
> > -             if (eh->ecxt->class != c || eh->sub_l == sub_l)
> > -                     add_dep(eh->ecxt, w);
> > +             if (eh->ecxt->class == c && eh->sub_l != sub_l)
> > +                     continue;
> > +
> > +             if (i == dt->ecxt_held_pos - 1 && lockdep_cmp_fn(eh->map, m))
> > +                     continue;
> 
> [Severity: Medium]
> Will this condition incorrectly bypass the comparison for earlier locks in
> the chain?
> 
> By restricting the lockdep_cmp_fn() check to only the most recently
> acquired lock (i == dt->ecxt_held_pos - 1), it seems we might miss valid
> comparisons for older contexts.

No.

It's how lockdep works and it's intended by lockdep.  The temporary code
just follows the rule.

> For example, if a task acquires lock A1, then lock B, and then lock A2
> (where A1 and A2 are the same class), the check against A1 will be skipped
> because A1 is no longer at dt->ecxt_held_pos - 1.
> 
> This would result in a call to add_dep(A1, A2), creating a
> self-referential class dependency that triggers a false positive deadlock
> report.

No.

It's a real deadlock.

> Should lockdep_cmp_fn() be allowed to evaluate against any previously held
> lock in the chain, rather than just the immediate predecessor?

No.

Check the lockdep code first.  See check_deadlock() and check_prev_add().

	Byungchul

> > +
> > +             add_dep(eh->ecxt, w);
> >       }
> >
> >       wg = next_wgen();
> 
> --
> Sashiko AI review · https://sashiko.dev/#/patchset/20260706061928.66713-1-byungchul@sk.com?part=29
