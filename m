Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 455893D4129;
	Tue,  7 Jul 2026 07:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783409608; cv=none; b=CmnOQZxaJ02Y7ncu2+02obdXqyuyror8/cPPdaRB4XS+FyEsj4L5yEUcYLJC51JNv2DlnPTp0AF/htimLG+ZnsbWCNyuh1MuDK3lsv0xav4IB9XxEvcZrCrybBq0vipnc+z1ZcAfkM0WHfczfg8k9mEkQ9f2tH06+jLKSUfVuSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783409608; c=relaxed/simple;
	bh=6ArUWFzkcLs92DtEt/hrBiK6HXlm9QrREKUXiqBhTaQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=J5L2zN6ZWVUJ0vJvS6qSQ0FHtnjS4k8nf/EC0Ev4pwRnazvqEC3V2/h5yi3cfJD4dTtlnzrLQ+PQMicCAbtFnuqQPgFfw+ToLJMXez+9+72cugeVmrv8PmTFizfWiXYtgIsvY8MghanKdf2cnt6E+cDXfN+GdTU6VU+okifWwII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g+zbBGTT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g+zbBGTT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3385C1F000E9;
	Tue,  7 Jul 2026 07:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783409606;
	bh=e6Jbl1Vo8f1gX12WmdWjiWdA1RECbGg5xPTlizkg5mQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=g+zbBGTTjxocbtufwqBHJnSNyT2m0p6hjTyOdAVbuRQljZebs3XQIrGo4I7kj7oT0
	 JlDjRnCd3RtgtfjfyqMD0CV5VwJin4EPGPxqzwqvml6+huXgi4jpGZAhB0SAG6bTog
	 yqEwTnoGw0vzdBPnI2hbRr18800+jXBNec3YDMD7uu4AcAxdA6piphwQCWc9xTU9J3
	 8fpiSSdjlfBHdQVCf/gLzwjW8e9f2hao6fCVslAiKo+WRdsOZNLuGVHOhd76x/LbZS
	 FN8AJ+j0KC8Yu7VsSp+L/H11hLaw6w+ueclWMEENmtYl29wE1B3GBJnmS92dcm4QHo
	 JI8uLDGWyC3fg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v19 11/40] dept: apply sdt_might_sleep_{start,end}() to
 swait
Reply-To: sashiko-reviews@lists.linux.dev
To: "Byungchul Park" <byungchul@sk.com>
Cc: linux-rt-devel@lists.linux.dev, dlemoal@kernel.org, "Chuck Lever" <cel@kernel.org>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, ojeda@kernel.org, tytso@mit.edu, dri-devel@lists.freedesktop.org, cassel@kernel.org, linux-modules@vger.kernel.org, "Jeff
 Layton" <jlayton@kernel.org>, "Anna Schumaker" <anna@kernel.org>
In-Reply-To: <20260706061928.66713-12-byungchul@sk.com>
References: <20260706061928.66713-1-byungchul@sk.com>
 <20260706061928.66713-12-byungchul@sk.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 07:33:25 +0000
Message-Id: <20260707073326.3385C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The `___swait_event`, `___wait_event`, and `___wait_var_event` mac=
ros skip the `sdt_might_sleep_end()` cleanup call when returning early due =
to a pending signal, leading to persistent DEPT state corruption that perma=
nently disables dependency tracking for the affected task.
--

commit 7785a2fe54ced42e856f39ece5776f11bca47be8
Author: Byungchul Park <byungchul@sk.com>

dept: apply sdt_might_sleep_{start,end}() to swait

Make dept able to track dependencies by swaits.

> diff --git a/include/linux/swait.h b/include/linux/swait.h
> index d324419482a0f..277ac74f61c39 100644
> --- a/include/linux/swait.h
> +++ b/include/linux/swait.h
[ ... ]
> @@ -161,6 +162,7 @@ extern void finish_swait(struct swait_queue_head *q, =
struct swait_queue *wait);
>  	struct swait_queue __wait;					\
>  	long __ret =3D ret;						\
>  									\
> +	sdt_might_sleep_start(NULL);					\
>  	INIT_LIST_HEAD(&__wait.task_list);				\
>  	for (;;) {							\
>  		long __int =3D prepare_to_swait_event(&wq, &__wait, state);\
> @@ -176,6 +178,7 @@ extern void finish_swait(struct swait_queue_head *q, =
struct swait_queue *wait);
>  		cmd;							\
>  	}								\
>  	finish_swait(&wq, &__wait);					\
> +	sdt_might_sleep_end();						\
>  __out:	__ret;								\
>  })

[Severity: High]
Does this code bypass the sdt_might_sleep_end() cleanup when returning early
due to a pending signal?

Looking at ___swait_event(), if a task waiting interruptibly receives a
signal, prepare_to_swait_event() returns a non-zero error code.=20

The wait loop evaluates ___wait_is_interruptible(state) && __int as true and
executes a goto __out; which jumps completely over this new cleanup call.

If sdt_might_sleep_end() is skipped, does the task's dependency staging map
remain persistently populated, effectively causing subsequent calls to
dept_stage_wait() to silently exit early and disable DEPT tracking for that
task?

It looks like this identical sequence might also occur in the generic
waitqueue macros (___wait_event in include/linux/wait.h) and the hashed
waitqueue macros (___wait_var_event in include/linux/wait_bit.h).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706061928.6671=
3-1-byungchul@sk.com?part=3D11
