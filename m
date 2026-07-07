Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91EAF414A10;
	Tue,  7 Jul 2026 07:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783409628; cv=none; b=eeU8TI/PUjNqntc7tmfvpCbNw0rUksebxb0SoMM4JkjOlnsyG0a+YfGNyPYIn+uryhF3dTXw+HMj5hphr3pyIXvtK+bMCYdeSxx0C25kkKYmrYXjPfna1InIgiHgWGfy/6ygti1KRFMxHgOo9LWO1EK8M9CAwFmMyffm0VjloHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783409628; c=relaxed/simple;
	bh=dlEEBVmvICxTMLOL76+9rjDaDAfGXFNHc1vMQ5okYNc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mR4UH02ktAvSu2Yby8OYnffkfP4oyCimsb2lsd7bSnRNnr1idg7DzRyzu9838BBJTrHWK9LoqEMvqwPJ0BWAvV4clgQ6EmYSaUv81baz9sJoWwe2yPKIArx/jsr3dUS6Yn3TAXOd4U/auRQtCRjOSWal2kUgtOzraCj2tSK2H2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m0pYkUlF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m0pYkUlF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A320A1F00A3D;
	Tue,  7 Jul 2026 07:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783409627;
	bh=mj2BqZFLC1Qe+QrDrzIG3TwlkOkq3c2gx510rdnmI3k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=m0pYkUlFrRvISeoZcOf6/qm5EAhVAGO2ke0E4NHHevrIo4vg9x4wa+qxSKgIZfULy
	 cTJX9T0Y2qqDQc7uSoit3ezT/ujBJAKr0dKCGvEe675oyrxohdH62Rvb3FlirCCjvB
	 ukZUe8RejZ/HUpE4m3ipen2qt/olGdcm/GlsOC2OOJu7HIOgW80YAa1z+urRCNadaa
	 fdwpkFWdeX0P2rFxDurWwmPxgZgD//wHBQ4bQR9e46gWKr0KcCdGSIkwI2Qi2U7RQs
	 /c+Aqcsg0dtB1HXksFxaYmffb+CZdTbhrce9EvNfh/ukAo/PyW5PsOObigMwps+Ya1
	 02pD0x71jrYHg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v19 29/40] dept: make dept aware of
 lockdep_set_lock_cmp_fn() annotation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Byungchul Park" <byungchul@sk.com>
Cc: linux-modules@vger.kernel.org, "Chuck Lever" <cel@kernel.org>, "Anna
 Schumaker" <anna@kernel.org>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, dlemoal@kernel.org, cassel@kernel.org, tytso@mit.edu, "Jeff
 Layton" <jlayton@kernel.org>, ojeda@kernel.org, linux-ide@vger.kernel.org
In-Reply-To: <20260706061928.66713-30-byungchul@sk.com>
References: <20260706061928.66713-1-byungchul@sk.com>
 <20260706061928.66713-30-byungchul@sk.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 07:33:45 +0000
Message-Id: <20260707073345.A320A1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] DEPT falsely reports a deadlock when a task sequentially acquire=
s three or more locks of the same class (or interleaves them with other loc=
ks), because the `lockdep_cmp_fn` bypass is improperly restricted to only t=
he immediately preceding lock.
--

commit d03c5b926a945b89f5a90fd98986386e113df5af
Author: Byungchul Park <byungchul@sk.com>

dept: make dept aware of lockdep_set_lock_cmp_fn() annotation
   =20
This commit updates the DEPT (Dependency Tracker) subsystem to respect the
lockdep_set_lock_cmp_fn() annotation. It allows DEPT to avoid false positive
deadlock reports by using the custom comparison function when evaluating
dependencies between locks of the same class.

> diff --git a/kernel/dependency/dept.c b/kernel/dependency/dept.c
> --- a/kernel/dependency/dept.c
> +++ b/kernel/dependency/dept.c

[ ... ]

> @@ -1658,8 +1688,13 @@ static void add_wait(struct dept_class *c, unsigne=
d long ip,
>  		if (!eh->ecxt)
>  			continue;
> =20
> -		if (eh->ecxt->class !=3D c || eh->sub_l =3D=3D sub_l)
> -			add_dep(eh->ecxt, w);
> +		if (eh->ecxt->class =3D=3D c && eh->sub_l !=3D sub_l)
> +			continue;
> +
> +		if (i =3D=3D dt->ecxt_held_pos - 1 && lockdep_cmp_fn(eh->map, m))
> +			continue;

[Severity: Medium]
Will this condition incorrectly bypass the comparison for earlier locks in
the chain?

By restricting the lockdep_cmp_fn() check to only the most recently
acquired lock (i =3D=3D dt->ecxt_held_pos - 1), it seems we might miss valid
comparisons for older contexts.

For example, if a task acquires lock A1, then lock B, and then lock A2
(where A1 and A2 are the same class), the check against A1 will be skipped
because A1 is no longer at dt->ecxt_held_pos - 1.

This would result in a call to add_dep(A1, A2), creating a
self-referential class dependency that triggers a false positive deadlock
report.

Should lockdep_cmp_fn() be allowed to evaluate against any previously held
lock in the chain, rather than just the immediate predecessor?

> +
> +		add_dep(eh->ecxt, w);
>  	}
> =20
>  	wg =3D next_wgen();

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706061928.6671=
3-1-byungchul@sk.com?part=3D29
