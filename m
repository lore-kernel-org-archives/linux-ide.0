Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77BC23C10A9;
	Tue,  7 Jul 2026 07:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783409604; cv=none; b=svgHmU7Itd3F7z3pjY/1a1eJl/r4pwd35fHCvaP/Gy6LYkjllHB6ReZsPu78ZBYZP/gbri+10Rr399Lgs+yzHaF2MtFmmzT1hwM+Dnjg4hUhG4x4CHz0FynHq/b47Paa5MpLVVdC1vSrLaLfZWHC3AwkDOsOyQLJAOzCxf4qY0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783409604; c=relaxed/simple;
	bh=RI4Ku3RimjA1JhKiigkz3RghWcDVsa0aR/7ekehhARI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PmiOcZJqXoHFQVZPc055P7sBunbork7ybia3og6en052w2KSV07I7afEo+4ExqBymE+Mjo6HUhObIMgs+w7J0I74F1puY+7gk4R5Y8IhO2yqJsKFNyJNI0gxabTJnBBGX1eeHxbzToJsXFCBUMm06u+nX5hIEmckkpzEnq55AMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gmmqh3vI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gmmqh3vI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9C851F000E9;
	Tue,  7 Jul 2026 07:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783409603;
	bh=9c+vt754Pk6cMlRlOmsx4ica/b8RCY+1SKaxoOYq6Qo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gmmqh3vIa3poA1wj0Mv3xuqP7G7nPNZUuW3ZeHcgh83uavicLhi5e3hwMAzYZDsi3
	 nV12dgrUc0Mr1Z9SOVchArxYfVsAQ3ZB4gTZUurcPy18VwiYuAEvrJ/w6jhr+vxNdG
	 tBEFhmMjVRZybSXhDIEaz2K/LvlQJa1b6tenfS9nTg08xQFyYqOpm1B5k4nsIeLwT/
	 htNGqqNqLHStgZZOcCV+ukCCMlSp36T/NyV6v0GhQ0b33vDSQYDVCm3FjOmeyrLsQy
	 VuxqYgQe+stDVyGy6WNJs+PSTa+IumUD4Ubu6gG5RBWrRx/OAbdtFfZkgwiq5SPlMU
	 aHtFD7T6WLvVQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v19 04/40] dept: tie to lockdep and IRQ tracing
Reply-To: sashiko-reviews@lists.linux.dev
To: "Byungchul Park" <byungchul@sk.com>
Cc: linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org, dlemoal@kernel.org, cassel@kernel.org, tytso@mit.edu, "Chuck
 Lever" <cel@kernel.org>, "Anna Schumaker" <anna@kernel.org>, linux-modules@vger.kernel.org, "Jeff
 Layton" <jlayton@kernel.org>, ojeda@kernel.org, dri-devel@lists.freedesktop.org, linux-ide@vger.kernel.org
In-Reply-To: <20260706061928.66713-5-byungchul@sk.com>
References: <20260706061928.66713-1-byungchul@sk.com>
 <20260706061928.66713-5-byungchul@sk.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 07:33:22 +0000
Message-Id: <20260707073322.A9C851F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [Critical] dept_key_destroy() synchronously recycles dept_class objects t=
o the lockless pool before the RCU grace period completes, causing UAF and =
list traversal corruption for concurrent lockless readers.
- [High] rwsem_acquire_read and rwsem_acquire incorrectly use ldt_lock(), b=
reaking reader-writer dependency tracking and causing false-positive deadlo=
cks.
- [High] ldt_init() is called before the `key` parameter is validated, caus=
ing DEPT to dereference a garbage pointer if `key` is NULL.
- [Medium] dept_key_init() and dept_key_destroy() are called on static keys=
 before validation, erroneously disabling DEPT or corrupting tracking state.
- [Low] STATIC_LOCKDEP_MAP_INIT creates double-quoted strings for map names=
 due to `#n` stringification in DEPT_MAP_INITIALIZER.
--

commit 6c1a95ee3182a2a82a1d61196d75acd387d7f3e3
Author: Byungchul Park <byungchul@sk.com>

dept: tie to lockdep and IRQ tracing

This patch integrates DEPT (Dependency Tracker) into the lockdep framework
and IRQ tracing paths. It modifies various locking primitives and lockdep
interfaces to initialize and track DEPT maps alongside lockdep maps.

> diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
> index 621566345406d..60b17a2ff555f 100644
> --- a/include/linux/lockdep.h
> +++ b/include/linux/lockdep.h
[ ... ]
> @@ -428,7 +431,8 @@ enum xhlock_context_t {
>   * Note that _name must not be NULL.
>   */
>  #define STATIC_LOCKDEP_MAP_INIT(_name, _key) \
> -	{ .name =3D (_name), .key =3D (void *)(_key), }
> +	{ .name =3D (_name), .key =3D (void *)(_key), \
> +	  .dmap =3D DEPT_MAP_INITIALIZER(_name, _key) }

[Severity: Low]
Since _name is usually passed as a string literal to
STATIC_LOCKDEP_MAP_INIT, does passing it to DEPT_MAP_INITIALIZER, which
uses the stringification operator on its first argument, result in
double-quoted strings for map names in DEPT's debug output?

[ ... ]
> -#define rwsem_acquire(l, s, t, i)		lock_acquire_exclusive(l, s, t, NULL,=
 i)
> -#define rwsem_acquire_nest(l, s, t, n, i)	lock_acquire_exclusive(l, s, t=
, n, i)
> -#define rwsem_acquire_read(l, s, t, i)		lock_acquire_shared(l, s, t, NUL=
L, i)
> -#define rwsem_release(l, i)			lock_release(l, i)
[ ... ]
> +#define rwsem_acquire(l, s, t, i)					\
> +do {									\
> +	ldt_lock(&(l)->dmap, s, t, NULL, i);				\
> +	lock_acquire_exclusive(l, s, t, NULL, i);			\
> +} while (0)
> +#define rwsem_acquire_nest(l, s, t, n, i)				\
> +do {									\
> +	ldt_lock(&(l)->dmap, s, t, n, i);				\
> +	lock_acquire_exclusive(l, s, t, n, i);				\
> +} while (0)
> +#define rwsem_acquire_read(l, s, t, i)					\
> +do {									\
> +	ldt_lock(&(l)->dmap, s, t, NULL, i);				\
> +	lock_acquire_shared(l, s, t, NULL, i);				\
> +} while (0)

[Severity: High]
Is it intentional that rwsem_acquire_read() uses ldt_lock() instead of
ldt_rlock(), and rwsem_acquire() uses ldt_lock() instead of ldt_wlock()?

This appears to mistakenly model a shared lock as an exclusive lock. Does
this cause DEPT to incorrectly model concurrent read locks as mutually
exclusive, leading to false-positive circular dependency (deadlock) reports
when concurrent readers take an rwsem and interact with other locks?

> diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
> index 2d4c5bab5af88..dc97f2753ef81 100644
> --- a/kernel/locking/lockdep.c
> +++ b/kernel/locking/lockdep.c
> @@ -1224,6 +1224,8 @@ void lockdep_register_key(struct lock_class_key *ke=
y)
>  	struct hlist_head *hash_head;
>  	struct lock_class_key *k;
>  	unsigned long flags;
> =20
> +	dept_key_init(&key->dkey);
> +
>  	if (WARN_ON_ONCE(static_obj(key)))
>  		return;

[Severity: Medium]
In lockdep_register_key(), dept_key_init() is called before the
static_obj() check. If a static key is improperly passed, lockdep gracefully
rejects it by warning and returning early.=20

However, processing a static key in dept_key_init() triggers a DEPT_STOP
abort. Should the DEPT initialization occur after validating the key?

[ ... ]
> @@ -4940,6 +4950,8 @@ void lockdep_init_map_type(struct lockdep_map *lock=
, const char *name,
>  {
>  	int i;
> =20
> +	ldt_init(&lock->dmap, &key->dkey, subclass, name);
> +
>  	for (i =3D 0; i < NR_LOCKDEP_CACHING_CLASSES; i++)
>  		lock->class_cache[i] =3D NULL;

[Severity: High]
In lockdep_init_map_type(), ldt_init() is called before the parameter
validation checks for a NULL key further down in the function.

If key is NULL, &key->dkey yields a non-NULL offset pointer. Does DEPT acce=
pt
this garbage pointer in valid_key(), causing a kernel panic when
check_new_class() dereferences it?

[ ... ]
> @@ -6588,6 +6608,8 @@ void lockdep_unregister_key(struct lock_class_key *=
key)
>  	bool found =3D false;
>  	bool need_callback =3D false;
> =20
> +	dept_key_destroy(&key->dkey);
> +
>  	might_sleep();
> =20
>  	if (WARN_ON_ONCE(static_obj(key)))
>  		return;

[Severity: Medium]
Similarly to lockdep_register_key(), dept_key_destroy() is called here
unconditionally before the static_obj() check. If a driver incorrectly calls
dynamic lock destruction on a static key, it eagerly destroys its DEPT state
while lockdep retains it. Should this also be moved after the static_obj()
check?

[Severity: Critical]
Additionally, in dept_key_destroy() called here, the function removes a cla=
ss
from the RCU hash table and drops its refcount to 0 via del_class(). This
recycles the object to the DEPT pool before synchronize_rcu() is called.

Can a concurrent lockless reader in hash_lookup_class() traversing the same
bucket via hlist_for_each_entry_rcu() access this recycled object, leading =
to
a use-after-free and hash list corruption?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706061928.6671=
3-1-byungchul@sk.com?part=3D4
