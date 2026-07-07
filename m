Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CACD3D5C2A;
	Tue,  7 Jul 2026 07:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783409609; cv=none; b=KzFDM7ESYY3Bb+JhOsUjBXh7Zvhs/XHqzkdsTmFhucx0F4xzAZKMOtdtScXkxfH9cEAROAAIkLppPbCpC63LpmVyhranAufTxSL55dUVloJEXTo6JFL+EwcR7wNpU33sQTfn8fLRjejXK4624TRUwV8+cKGtzGxyVM+unOIlNy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783409609; c=relaxed/simple;
	bh=ri0LLll9MxN5MF8UpuhRKYOFnnT6Z78pMd6oRYL5/CE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iSDrcSyd3KMJOwyClFxz5HhyE4c1ELeKXpx+EM11nkqfQ+28aWzK9qf7CfpYH0mLHTHRJAOKgu1Vx2jCGRFkmld5uJmMWwJgwXM1Wup7rzl2+Lz0qQgCMe3VdWka3nOAU4e9Y233JmU/CROweMw4dHFNaDteFFgU/e+s3QTlY4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IW9rHV+n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IW9rHV+n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6884A1F00A3A;
	Tue,  7 Jul 2026 07:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783409608;
	bh=C6BrclpeMUX9NdqadQiDE/6OMUyvZTgUT79QIUG+pk4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IW9rHV+nZZ/E4alhViGt4RN0zGvSFSsXeNavOZV95nrzQKwpNqoMRkF3ds3sb1a/n
	 neZRENSRQnh+JlHZCuRrQiPtGAFzK3x5lYajKUroj7nRrLVoMbC4rwPNHYLnyptGC8
	 im3YWfgrWfTX+VZQKEqb3j5d0bGxGtooHnqxB4bWdRtwuRkTUmz7wF22Q298fXVRYg
	 +c1EtElTrekEQgu+NQBLeXXM6+V6w3sXERM5woHt/bYg2xRAYsu5ZS01M1f12vmu/J
	 hVP/UsJmsSSazrugEHvtHopjx1lDfXVT0eFKBOlzhvucOodSuwYBe1rtNxZcbIEWlN
	 qG2dDj1ddUuiQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v19 01/40] dept: implement DEPT(DEPendency Tracker)
Reply-To: sashiko-reviews@lists.linux.dev
To: "Byungchul Park" <byungchul@sk.com>
Cc: ojeda@kernel.org, tytso@mit.edu, "Anna Schumaker" <anna@kernel.org>, cassel@kernel.org, dlemoal@kernel.org, "Jeff
 Layton" <jlayton@kernel.org>, dri-devel@lists.freedesktop.org, linux-ide@vger.kernel.org, linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org, "Chuck
 Lever" <cel@kernel.org>, linux-modules@vger.kernel.org
In-Reply-To: <20260706061928.66713-2-byungchul@sk.com>
References: <20260706061928.66713-1-byungchul@sk.com>
 <20260706061928.66713-2-byungchul@sk.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 07:33:27 +0000
Message-Id: <20260707073327.6884A1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Data race and Use-After-Clear on `dt->stage_m` between `dept_reque=
st_event_wait_commit()` and `dept_ttwu_stage_wait()`
- [High] Use-after-free and RCU list corruption because `dept_class` object=
s are freed before the RCU grace period elapses
- [High] Deadlock on PREEMPT_RT due to `local_irq_disable()` being used wit=
h a raw spinlock (`dept_pool_spin`)
--

commit 1fd2695b58a470d54e232dcaaf112ad8a807718e
Author: Byungchul Park <byungchul@sk.com>

dept: implement DEPT(DEPendency Tracker)

This commit implements DEPT (Dependency Tracker) to monitor waits and
events for deadlock detection. It addresses Lockdep's limitations
regarding read locks and cross-event scenarios.

> diff --git a/kernel/dependency/dept.c b/kernel/dependency/dept.c
> new file mode 100644
> index 0000000000000..52b9669fe0179
> --- /dev/null
> +++ b/kernel/dependency/dept.c
> @@ -0,0 +1,2977 @@

[ ... ]

> +static void dept_wq_work_fn(struct work_struct *work)
> +{
> +	int i;
> +
> +	for (i =3D 0; i < OBJECT_NR; i++) {
> +		struct dept_pool *p =3D dept_pool + i;
> +		int sz =3D p->tot_nr * p->obj_sz;
> +		void *rpool;
> +		bool need;
> +
> +		local_irq_disable();
> +		arch_spin_lock(&dept_pool_spin);

[Severity: High]
Is this locking pattern safe on PREEMPT_RT?

By using local_irq_disable() with a raw spinlock (dept_pool_spin), hardware
interrupts aren't disabled on PREEMPT_RT. Since DEPT instruments hardirq
paths via dept_enter(), could a hardware interrupt fire here, attempt to
acquire the exact same lock in from_pool(), and cause a hard deadlock?

Should raw_local_irq_disable() or arch_local_irq_save() be used instead?

[ ... ]

> +	list_for_each_entry_safe(c, n, &dept_classes, all_node) {
> +		if (!within((void *)c->key, start, sz) &&
> +		    !within(c->name, start, sz))
> +			continue;
> +
> +		hash_del_class(c);
> +		disconnect_class(c);
> +		list_del(&c->all_node);
> +		invalidate_class(c);
> +
> +		/*
> +		 * Actual deletion will happen on the rcu callback
> +		 * that has been added in disconnect_class().
> +		 */
> +		del_class(c);
> +	}
> +	dept_unlock();
> +	dept_exit(flags);
> +
> +	/*
> +	 * Wait until even lockless hash_lookup_class() for the class
> +	 * returns NULL.
> +	 */
> +	might_sleep();
> +	synchronize_rcu();

[Severity: High]
Does this sequence safely handle RCU lifetimes for the dept_class objects?

Although the comment states actual deletion happens in the RCU callback,
disconnect_class() only queues callbacks for dept_dep objects, not the
class itself. By calling del_class(c) directly before synchronize_rcu(),
the object is pushed to the freelist synchronously via to_pool().

If a concurrent lockless RCU reader like hash_lookup_class() traverses
the bucket and reads hash_node.next after the class is reallocated,
wouldn't this result in list corruption or use-after-free crashes?

[ ... ]

> +void dept_request_event_wait_commit(void)
> +{
> +	struct dept_task *dt =3D dept_task();
> +	unsigned long flags;
> +	unsigned int wg;
> +	unsigned long ip;
> +	const char *w_fn;
> +	bool sched_map;

[ ... ]

> +	wg =3D next_wgen();
> +	WRITE_ONCE(dt->stage_m.wgen, wg);
> +	arch_spin_unlock(&dt->stage_lock);
> +
> +	__dept_wait(&dt->stage_m, 1UL, ip, w_fn, 0, true, sched_map);

[Severity: High]
Can this sequence lead to a use-after-clear of dt->stage_m?

Once dt->stage_lock is dropped, a concurrent wakeup can execute
dept_ttwu_stage_wait() which acquires the same stage_lock and calls
__dept_clean_stage(), clearing the original stage_m using memset().

Since __dept_wait() is called here with a reference to &dt->stage_m
after the lock is released, could it read memory that is actively being
zeroed out, resulting in a NULL pointer dereference for fields like
keys or name in check_new_class()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706061928.6671=
3-1-byungchul@sk.com?part=3D1
