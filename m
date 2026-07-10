Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B4931A5B9D;
	Fri, 10 Jul 2026 06:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783666465; cv=none; b=XxClwrkpH3Sr0wEeMFw4GeUlAhxChfrcxAtKiAiIQIoqOmUj+lWw8E8W/f/l9TQRcJbwC7Edga2As5Y2vE/Xidrlj5Zttyb2g5tVjDO5iQ73ZKI1LcUTJpWlqgHZpt16W7M7EOKehaKrahMJZ+VqxYpFK0I03U4Q5bDkZOsDqhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783666465; c=relaxed/simple;
	bh=qwuY/jOE1TXuiazsJttTRY5x7u4BkEWPbW/olbj7tlo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uy5Z04Ssa5baD2meidK8VrBt7fZ5u4FSndCD/v2UunTUvS3klcxG3p8jqduGYIIuxq1xHwBF0mZ/s8Lx46M3tuH8XpodKy6g99qrmvhLDV09n6yc5T41ihwi/mFtglPYLGmXG892aCryyOq3OWtlmejoE+ULQcRBNFUi0HDXDbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-c45ff70000001609-7d-6a509719cd52
Date: Fri, 10 Jul 2026 15:54:12 +0900
From: Byungchul Park <byungchul@sk.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
	dlemoal@kernel.org, cassel@kernel.org, tytso@mit.edu,
	Chuck Lever <cel@kernel.org>, Anna Schumaker <anna@kernel.org>,
	linux-modules@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
	ojeda@kernel.org, dri-devel@lists.freedesktop.org,
	linux-ide@vger.kernel.org, kernel_team@skhynix.com
Subject: Re: [PATCH v19 04/40] dept: tie to lockdep and IRQ tracing
Message-ID: <20260710065412.GJ37630@system.software.com>
References: <20260706061928.66713-1-byungchul@sk.com>
 <20260706061928.66713-5-byungchul@sk.com>
 <20260707073322.A9C851F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260707073322.A9C851F000E9@smtp.kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupmkeLIzCtJLcpLzFFi42LhesuzUFdyekCWwbQefYvWnf9ZLI5NWMFs
	se7FETaLB/vtLa58fc9m8XPZKnaLYzseMVlc3jWHzaJh9ndWi0urL7BYrJy/nNGiYeltVovW
	np/sDrwem1Z1snnc7z7O5PFi80xGj6YzR5k9Pm+SC2CN4rJJSc3JLEst0rdL4Mo4f1el4JJl
	xf4pnewNjB+1uhg5OSQETCTent/BDmPfffmSGcRmEVCVOLvgL5jNJqAucePGTzBbREBZYvaO
	s0xdjFwczAIvmCTuTWgBaxYWcJZYfnclUBEHB6+AhcSSeyUgNUICExklrnc+ZgWp4RUQlDg5
	8wkLiM0soCOxc+sdNpB6ZgFpieX/OCDC8hLNW2eD7eIUsJJY8qMLrFwUaO+BbcfB9koIvGaT
	eDZ5ChPE0ZISB1fcYJnAKDgLyYpZSFbMQlgxC8mKBYwsqxiFMvPKchMzc0z0MirzMiv0kvNz
	NzECo2hZ7Z/oHYyfLgQfYhTgYFTi4TWo988SYk0sK67MPcQowcGsJML7QAYoxJuSWFmVWpQf
	X1Sak1p8iFGag0VJnNfoW3mKkEB6YklqdmpqQWoRTJaJg1OqgVH6f7bErS2zTW2PlAfkGrwu
	1Cr5rruz9LvCST6WzZppjWv22JRO/jD1doduzebU43/+X926+1GpRuCb++ctRQ6vzXr9SnUp
	W0SI5PKp2+dMdj3OnXjUN++CT766j4k/U/T6MyyHSw+9OKZ5ODuGa98BXl7v/MaqRd/Y604J
	Pull6TzmW9l9d7kSS3FGoqEWc1FxIgBUKO9jngIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrELMWRmVeSWpSXmKPExsXC5WfdrCs5PSDL4Mx7OYvWnf9ZLI5NWMFs
	se7FETaLB/vtLa58fc9m8XPZKnaLw3NPsloc2/GIyeLyrjlsFg2zv7NaXFp9gcVi5fzljBYN
	S2+zWrT2/GR34PPYtKqTzeN+93EmjxebZzJ6NJ05yuyx+MUHJo/Pm+QC2KK4bFJSczLLUov0
	7RK4Ms7fVSm4ZFmxf0onewPjR60uRk4OCQETibsvXzKD2CwCqhJnF/wFs9kE1CVu3PgJZosI
	KEvM3nGWqYuRi4NZ4AWTxL0JLewgCWEBZ4nld1cCFXFw8ApYSCy5VwJSIyQwkVHieudjVpAa
	XgFBiZMzn7CA2MwCOhI7t95hA6lnFpCWWP6PAyIsL9G8dTbYLk4BK4klP7rAykWB9h7Ydpxp
	AiPfLCSTZiGZNAth0iwkkxYwsqxiFMnMK8tNzMwx1SvOzqjMy6zQS87P3cQIjIlltX8m7mD8
	ctn9EKMAB6MSD69BvX+WEGtiWXFl7iFGCQ5mJRHeBzJAId6UxMqq1KL8+KLSnNTiQ4zSHCxK
	4rxe4akJQgLpiSWp2ampBalFMFkmDk6pBsbtIn1n5rQ8nfjmjVyDsMKE+snvJx9emhny0/y7
	5fIHr5+8qDtXvfyi5kfnjh/fo1O8BA0O722YUvDQcvpjgbOyRctOs872u2kU0X+uQ/Zmv+SM
	MxrTZ140LrpzQ2He8vsJBwv5T91VEHmxoS++UoRHtVNtW+2nkKrTxkvWF099JRV5RPMRg0ec
	EktxRqKhFnNRcSIA7ef2wYUCAAA=
X-CFilter-Loop: Reflected

On Tue, Jul 07, 2026 at 07:33:22AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 5 potential issue(s) to consider:
> - [Critical] dept_key_destroy() synchronously recycles dept_class objects to the lockless pool before the RCU grace period completes, causing UAF and list traversal corruption for concurrent lockless readers.
> - [High] rwsem_acquire_read and rwsem_acquire incorrectly use ldt_lock(), breaking reader-writer dependency tracking and causing false-positive deadlocks.
> - [High] ldt_init() is called before the `key` parameter is validated, causing DEPT to dereference a garbage pointer if `key` is NULL.
> - [Medium] dept_key_init() and dept_key_destroy() are called on static keys before validation, erroneously disabling DEPT or corrupting tracking state.
> - [Low] STATIC_LOCKDEP_MAP_INIT creates double-quoted strings for map names due to `#n` stringification in DEPT_MAP_INITIALIZER.
> --
> 
> commit 6c1a95ee3182a2a82a1d61196d75acd387d7f3e3
> Author: Byungchul Park <byungchul@sk.com>
> 
> dept: tie to lockdep and IRQ tracing
> 
> This patch integrates DEPT (Dependency Tracker) into the lockdep framework
> and IRQ tracing paths. It modifies various locking primitives and lockdep
> interfaces to initialize and track DEPT maps alongside lockdep maps.
> 
> > diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
> > index 621566345406d..60b17a2ff555f 100644
> > --- a/include/linux/lockdep.h
> > +++ b/include/linux/lockdep.h
> [ ... ]
> > @@ -428,7 +431,8 @@ enum xhlock_context_t {
> >   * Note that _name must not be NULL.
> >   */
> >  #define STATIC_LOCKDEP_MAP_INIT(_name, _key) \
> > -     { .name = (_name), .key = (void *)(_key), }
> > +     { .name = (_name), .key = (void *)(_key), \
> > +       .dmap = DEPT_MAP_INITIALIZER(_name, _key) }
> 
> [Severity: Low]
> Since _name is usually passed as a string literal to
> STATIC_LOCKDEP_MAP_INIT, does passing it to DEPT_MAP_INITIALIZER, which
> uses the stringification operator on its first argument, result in
> double-quoted strings for map names in DEPT's debug output?

I will check it.  Thanks.

> [ ... ]
> > -#define rwsem_acquire(l, s, t, i)            lock_acquire_exclusive(l, s, t, NULL, i)
> > -#define rwsem_acquire_nest(l, s, t, n, i)    lock_acquire_exclusive(l, s, t, n, i)
> > -#define rwsem_acquire_read(l, s, t, i)               lock_acquire_shared(l, s, t, NULL, i)
> > -#define rwsem_release(l, i)                  lock_release(l, i)
> [ ... ]
> > +#define rwsem_acquire(l, s, t, i)                                    \
> > +do {                                                                 \
> > +     ldt_lock(&(l)->dmap, s, t, NULL, i);                            \
> > +     lock_acquire_exclusive(l, s, t, NULL, i);                       \
> > +} while (0)
> > +#define rwsem_acquire_nest(l, s, t, n, i)                            \
> > +do {                                                                 \
> > +     ldt_lock(&(l)->dmap, s, t, n, i);                               \
> > +     lock_acquire_exclusive(l, s, t, n, i);                          \
> > +} while (0)
> > +#define rwsem_acquire_read(l, s, t, i)                                       \
> > +do {                                                                 \
> > +     ldt_lock(&(l)->dmap, s, t, NULL, i);                            \
> > +     lock_acquire_shared(l, s, t, NULL, i);                          \
> > +} while (0)
> 
> [Severity: High]
> Is it intentional that rwsem_acquire_read() uses ldt_lock() instead of
> ldt_rlock(), and rwsem_acquire() uses ldt_lock() instead of ldt_wlock()?

It's intended.  rwsem is a queued lock for fairness.  So it should be
considered as a normal lock to detect a potential deadlock.

> This appears to mistakenly model a shared lock as an exclusive lock. Does
> this cause DEPT to incorrectly model concurrent read locks as mutually
> exclusive, leading to false-positive circular dependency (deadlock) reports
> when concurrent readers take an rwsem and interact with other locks?

As I told you, rwsem is a queued lock.  So this is not true.

> > diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
> > index 2d4c5bab5af88..dc97f2753ef81 100644
> > --- a/kernel/locking/lockdep.c
> > +++ b/kernel/locking/lockdep.c
> > @@ -1224,6 +1224,8 @@ void lockdep_register_key(struct lock_class_key *key)
> >       struct hlist_head *hash_head;
> >       struct lock_class_key *k;
> >       unsigned long flags;
> >
> > +     dept_key_init(&key->dkey);
> > +
> >       if (WARN_ON_ONCE(static_obj(key)))
> >               return;
> 
> [Severity: Medium]
> In lockdep_register_key(), dept_key_init() is called before the
> static_obj() check. If a static key is improperly passed, lockdep gracefully
> rejects it by warning and returning early.
> 
> However, processing a static key in dept_key_init() triggers a DEPT_STOP
> abort. Should the DEPT initialization occur after validating the key?

I will check it.

> [ ... ]
> > @@ -4940,6 +4950,8 @@ void lockdep_init_map_type(struct lockdep_map *lock, const char *name,
> >  {
> >       int i;
> >
> > +     ldt_init(&lock->dmap, &key->dkey, subclass, name);
> > +
> >       for (i = 0; i < NR_LOCKDEP_CACHING_CLASSES; i++)
> >               lock->class_cache[i] = NULL;
> 
> [Severity: High]
> In lockdep_init_map_type(), ldt_init() is called before the parameter
> validation checks for a NULL key further down in the function.
> 
> If key is NULL, &key->dkey yields a non-NULL offset pointer. Does DEPT accept
> this garbage pointer in valid_key(), causing a kernel panic when
> check_new_class() dereferences it?

I will check it.

> [ ... ]
> > @@ -6588,6 +6608,8 @@ void lockdep_unregister_key(struct lock_class_key *key)
> >       bool found = false;
> >       bool need_callback = false;
> >
> > +     dept_key_destroy(&key->dkey);
> > +
> >       might_sleep();
> >
> >       if (WARN_ON_ONCE(static_obj(key)))
> >               return;
> 
> [Severity: Medium]
> Similarly to lockdep_register_key(), dept_key_destroy() is called here
> unconditionally before the static_obj() check. If a driver incorrectly calls
> dynamic lock destruction on a static key, it eagerly destroys its DEPT state
> while lockdep retains it. Should this also be moved after the static_obj()
> check?

Sure.  I will.

> [Severity: Critical]
> Additionally, in dept_key_destroy() called here, the function removes a class
> from the RCU hash table and drops its refcount to 0 via del_class(). This
> recycles the object to the DEPT pool before synchronize_rcu() is called.

No.

del_class() never drops refcount to 0.  That happens only through:

   disconnect_class()->call_rcu(del_dep_rcu)

   // after the grace period

   del_dep_rcu()->del_dep()->put_ecxt()->put_class()
   del_dep_rcu()->del_dep()->put_wait()->put_class()

So it's safe.

> Can a concurrent lockless reader in hash_lookup_class() traversing the same
> bucket via hlist_for_each_entry_rcu() access this recycled object, leading to
> a use-after-free and hash list corruption?

No.

	Byungchul
> 
> --
> Sashiko AI review · https://sashiko.dev/#/patchset/20260706061928.66713-1-byungchul@sk.com?part=4
