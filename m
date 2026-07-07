Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4083E92B5;
	Tue,  7 Jul 2026 07:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783409615; cv=none; b=d/o+Tc1isu/hMRV88sTM0fMf9dXcWkngQPiIMeCE7/WfHfrD0L9T58hd80Dqr6SMUUeAVUUup6z+IT1gKhuI452lVuyTfzsZWOP3FlM9zKm/Cq3BVaqIbv7J+UVkB9SS4FhEJpRDvS1A8fCRdKC0oeGCvDBOL+OXECtxRwO2HR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783409615; c=relaxed/simple;
	bh=PfN7fR5sv084KvOhLn1XW/Lw1qwh0GidwWdc2CyeYeU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iz/hJii0sPqCbAq4LcibpgXaN0nwXpXpDo+tv+pIyqgXT4XXYrL7ZsbujTwidax987siFixZ77qdzbVgAl65oFzVYnrqB73mMN5rQVliwHvA2ELrRfkoxG+gV+GxCFtZSwxJv/Jhj14z/UoFOGbvDTvRoeZMSn3cYcegdEaFUTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eRpw9U/n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eRpw9U/n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E5A61F000E9;
	Tue,  7 Jul 2026 07:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783409614;
	bh=6raXW6tTfXqLQeqQS8TRI54npNDxeghgUG26veqYNbM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eRpw9U/nhJusw4HUKV66OsxwuiaoEbrC1gdaz2HQVDmAeHntR1C8/dtXwR7W00YC6
	 8/f2CqEFY2z2Iy+B5u8Sp+A8Wm4Hx3C3nBJ3s1LzdYuCbTnF6CXveNbMzOpZyYdU6g
	 CduLSoEzfK7yvr+8vp6QsxJvySO5XPbefS+zL/URxbd6Sig5EqmELXynrxvALXedpB
	 301qVULhA5K8ZR+KkQy3oopB/1j1L8FIZH5IX4rMHvpnjrwnVAZ/LjnUEGoE0X6fJE
	 d4YYiY1h6d248F1jsSLin0brAdCKayH/WorZ9w8nDMvAAS0BJuix9WJYfV/526wCeo
	 y7W2okuJDQF1g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v19 07/40] dept: distinguish each work from another
Reply-To: sashiko-reviews@lists.linux.dev
To: "Byungchul Park" <byungchul@sk.com>
Cc: linux-rt-devel@lists.linux.dev, cassel@kernel.org, linux-ide@vger.kernel.org, tytso@mit.edu, linux-kernel@vger.kernel.org, "Anna
 Schumaker" <anna@kernel.org>, linux-modules@vger.kernel.org, "Chuck Lever" <cel@kernel.org>, ojeda@kernel.org, dlemoal@kernel.org, dri-devel@lists.freedesktop.org, "Jeff
 Layton" <jlayton@kernel.org>
In-Reply-To: <20260706061928.66713-8-byungchul@sk.com>
References: <20260706061928.66713-1-byungchul@sk.com>
 <20260706061928.66713-8-byungchul@sk.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 07:33:33 +0000
Message-Id: <20260707073334.0E5A61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] `dept_update_cxt()` hardcodes the process context ID, failing to=
 track bottom-half (BH) work items in softirq context and corrupting the co=
ntext of preempted tasks.
--

commit b8dda7d95e5377770d28c6712cf8fe7fafa98ade
Author: Byungchul Park <byungchul@sk.com>

dept: distinguish each work from another

This commit updates DEPT to assign a different context ID to each work item.
Since workqueues provide their own concurrency control, wait operations in a
work item do not prevent events in other works from executing.

> diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> index c6ea96d5b7167..4a4075d0697c7 100644
> --- a/kernel/workqueue.c
> +++ b/kernel/workqueue.c
[ ... ]
> @@ -3204,6 +3205,8 @@ __acquires(&pool->lock)
> =20
>  	lockdep_copy_map(&lockdep_map, &work->lockdep_map);
>  #endif
> +	dept_update_cxt();
> +

[Severity: Medium]
Will this unconditionally modify the process context ID, even when tracking
bottom-half (BH) work items running in softirq context?

When a BH workqueue executes multiple work items in a single softirq batch,
process_one_work() executes them and calls dept_update_cxt(). However,
dept_update_cxt() is implemented as:

kernel/dependency/dept.c:dept_update_cxt() {
    struct dept_task *dt =3D dept_task();
    dt->cxt_id[DEPT_CXT_PROCESS] +=3D 1UL << DEPT_CXTS_NR;
}

This hardcodes the increment to DEPT_CXT_PROCESS rather than checking
cur_cxt() to increment DEPT_CXT_SIRQ. Does this cause DEPT to fail in
distinguishing sequential BH work items and falsely report dependencies?

Also, can this corrupt the continuous dependency tracking context of
whatever task was preempted by the softirq?

>  	/* ensure we're on the correct CPU */
>  	WARN_ON_ONCE(!(pool->flags & POOL_DISASSOCIATED) &&
>  		     raw_smp_processor_id() !=3D pool->cpu);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706061928.6671=
3-1-byungchul@sk.com?part=3D7
