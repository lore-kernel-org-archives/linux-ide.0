Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB203F54C7;
	Tue,  7 Jul 2026 07:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783409621; cv=none; b=giTY/PSDgfeq0ZEgpk5pk5dh3WH82chOvT1aLgZ5EHhnjXIKpR7zI+8FG5V5rc3leVlcaeJ1r0kkQ+wnCXcDTKBF5d5Sz+IZ0O6TLFsU+4wzXSIiYApQbVtuK0B//LqB52FUjZ2Vth4TEptZqYsD51KyWonAMW1Q3pZR6JhB2Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783409621; c=relaxed/simple;
	bh=hONfkVVAm3IhN+bPjXgrRib8gT9Pd2b60+x4JNu3SM0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tQwccLE4RtbFaVzDiMCQQa4FjrLB2OvGgiO1pFlmCy08l7cYjnVE2MWgLNa55jPCS0SVzTRYsXf6QKa0J73DYOQ7O+mp8y2mxUkO9JLOiqkG8Bk/KpE5qbQw6iAHYabJWhIVc0s0urL3mqhDwZ+f17N1IVfq4LYchvv0kyA++2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QTiuyUw8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QTiuyUw8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BA481F000E9;
	Tue,  7 Jul 2026 07:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783409620;
	bh=hONfkVVAm3IhN+bPjXgrRib8gT9Pd2b60+x4JNu3SM0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QTiuyUw8ntIbYajX8TWXAOBQZPymahnXl5vTFjpzg8UuBPAqNLa2P57x6yKdIovYt
	 ObS1/dKhiY6XEcE43kTper+DuvFlSODIhymxWKEcpI7Akq3BhgplsIJq2vzB7n76Ie
	 lUkd8ovflWlKIRn6n03F7x2I9NomoJW6P+33uSVKvvQD8L0+TZqmEFLjwwzt7FxH3d
	 rz7GiPUTTGeHaqPxFos+dMnKAfDMFiYtE2iFzsNgw7nAF/4EI1fVuxU+Iw2TQWOzM9
	 iqiXu+cJnwFx/Kv0s+Tt1V3JuJAMEEHFVW5jKZqXAHiBV+zW2i6zcEUpM0DVG3RVv5
	 q+wOX+iOrOPug==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v19 22/40] dept: track PG_locked with dept
Reply-To: sashiko-reviews@lists.linux.dev
To: "Byungchul Park" <byungchul@sk.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-rt-devel@lists.linux.dev, "Anna
 Schumaker" <anna@kernel.org>, linux-ide@vger.kernel.org, dlemoal@kernel.org, cassel@kernel.org, "Chuck
 Lever" <cel@kernel.org>, tytso@mit.edu, ojeda@kernel.org, linux-modules@vger.kernel.org, "Jeff
 Layton" <jlayton@kernel.org>
In-Reply-To: <20260706061928.66713-23-byungchul@sk.com>
References: <20260706061928.66713-1-byungchul@sk.com>
 <20260706061928.66713-23-byungchul@sk.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 07:33:39 +0000
Message-Id: <20260707073339.6BA481F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:
- [Critical] Unconditional `dept_page_set_bit` in `folio_wait_bit_common` c=
auses Use-After-Free and lock tracking leaks for non-exclusive waits.
- [High] Lock handoff in `wake_page_function` registers lock acquisition in=
 the waker's context instead of the sleeper's.
- [High] A single lock acquisition incorrectly records two events in the th=
read's DEPT tracking stack on the fast path.
- [High] Generic page flag macros clear the lock bit before notifying the d=
ependency tracker, creating a race condition.
- [High] Unconditional addition of `struct dept_ext_wgen` and `struct dept_=
page_usage` directly to `struct page` causes severe memory bloat.
- [Medium] Mismatched DEPT tracking on compound tail pages splits lock acqu=
isition and wait events across different tracking contexts.
--

Note: Due to system recitation restrictions, this review uses a free-form
summary format instead of standard inline patch quoting.

Commit: 1b85b38be891fb326526f230171e29e8fb12a627
Author: Byungchul Park <byungchul@sk.com>
Subject: dept: track PG_locked with dept
Summary: This patch makes dept able to track PG_locked waits and events.
Link: https://lore.kernel.org/lkml/1674268856-31807-1-git-send-email-byungc=
hul.park@lge.com/

[Severity: High]
In include/linux/mm_types.h, the struct page definition is modified to add
the pg_locked_wgen and pg_writeback_wgen fields. Are these structures being
added unconditionally without CONFIG_DEPT guards?

Adding per-page metadata directly to struct page increases the size of the
structure for every physical page, which wastes memory on large systems.
Should this tracking metadata be moved to the dynamically allocated page_ext
framework, or at least be strictly guarded by Kconfig checks?

[Severity: High]
In include/linux/page-flags.h, macros like FOLIO_CLEAR_FLAG clear the target
bit using clear_bit() before notifying the tracker via dept_folio_clear_bit=
().
Could this out-of-order execution create a race condition?

If the lock bit is cleared first, another thread could immediately acquire =
the
lock and call dept_page_set_bit() before the original thread finishes calli=
ng
dept_folio_clear_bit(). This sequence would process the release after the
subsequent acquisition, which might corrupt the tracker state.

[Severity: Medium]
In include/linux/pagemap.h within lock_page(), dept_page_wait_on_bit() is
called on the raw page pointer before converting it to the head folio with
page_folio(page).

If this is called on a tail page, won't the wait event be recorded on the t=
ail
page's tracking metadata, while the subsequent lock acquisition correctly
records on the head page? Splitting the wait and acquisition tracking could
break the dependency graph for large folios.

[Severity: Critical]
In mm/filemap.c within folio_wait_bit_common(), the code unconditionally
calls dept_page_set_bit() if WQ_FLAG_DONE is set in wait->flags. Does this
create a use-after-free for DROP waits?

For DROP waits, folio_put() is called before the wait loop. If the folio is
concurrently freed, dereferencing the page pointer after the loop will cause
a use-after-free.

Additionally, for SHARED non-exclusive waits, folio_trylock_flag() sets
WQ_FLAG_DONE when the bit is clear. Does this cause the unconditional check
in folio_wait_bit_common() to incorrectly register a lock acquisition for a
thread that is merely waiting? This could permanently leak the lock tracking
context.

[Severity: High]
Also in folio_wait_bit_common(), if the fast path successfully acquires the
lock synchronously, folio_trylock_flag() sets the lock bit, calls
dept_page_set_bit(), and sets WQ_FLAG_DONE.

When folio_wait_bit_common() checks WQ_FLAG_DONE at the end of the function,
won't it call dept_page_set_bit() a second time? This appears to push a
duplicate lock acquisition record to the tracker stack for a single lock
operation.

[Severity: High]
In mm/filemap.c within wake_page_function(), during an exclusive lock
handoff, the function sets the lock bit on behalf of the sleeper and calls
dept_page_set_bit().

Since this function executes in the context of the waker thread, won't the
tracker incorrectly record the lock acquisition in the waker's task structu=
re
rather than the sleeper's? This could leak the lock tracking state in the
waker and break the dependency graph for the sleeper.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706061928.6671=
3-1-byungchul@sk.com?part=3D22
