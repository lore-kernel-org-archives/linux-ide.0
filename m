Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41713F88AA;
	Tue,  7 Jul 2026 07:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783409624; cv=none; b=QXMEuimuzZZa52ttPuhkoouT1yqq9NHoSytrwie1W7WDUiTMvrLMl85Z6H5yi3saiurMnZDJrvpiVEX9+Mn5dF3kIEcd7T4ZXSW1Q4QP4XfH7TBtN1NlzWI/ZbHRxMNqmCGAbKZNMWo6SQrSCfQ3Q6Yr81r4Ws94jhxNrX5GE0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783409624; c=relaxed/simple;
	bh=AwMJ+lgCOSiBHuONbGKQvTOUfDjPZjNC0oqp8tgwZsQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Z6f3Gsv7/PaAyOqsxkdMuDeZkDz8zHl0VDuoXzJlgpZjZtGoml1knU0kpeRGO0dLJG8D9X7ToE4d8Ddw1C6QULpORxQyMKNYuYjpiOI7ieUx4FQN3HAoHROWBh9rvBdYCFpqDGd2ej+rzFoZJqVAGF5oDNquomc4zZH/B6J64co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xk79Tjws; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xk79Tjws"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 119731F000E9;
	Tue,  7 Jul 2026 07:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783409622;
	bh=iPuerRcuivB+2DuvQ9kuX8ZsIO7TmcRGdbgEsGpDX2g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Xk79Tjws4zk4Nm8wQ9Hlhi1CQHCea9/tYlP70BIzvghLY0WiEkWgwwax11+6ntTLw
	 TDB8i4Wnpe/2Yep4Zp1aJr+WHL3/X5PC6rFUgCOxxjyKVKn6V1OEFRRLUnda9G7aZJ
	 2/yDXTvUg0ZbNChKY5VcRxGBp4jonzPjdcGrnt8YBpJxzV3L2O3T0IxqPHLVQwJ49n
	 YbROZDL5qcv8FpLOC0lY9LIPV/trRl0Vgv/1bBNLAa59VckI1YIQqM4vuJ/DG3j5HF
	 okEhO3e2k2yJiJ0Azm2KCYPbaw76F8EvQXPSoqg+UAuSe+XvRkBZwq1uv/F52KEi5T
	 b6PdvUQOHcbEA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v19 24/40] locking/lockdep: prevent various lockdep
 assertions when lockdep_off()'ed
Reply-To: sashiko-reviews@lists.linux.dev
To: "Byungchul Park" <byungchul@sk.com>
Cc: dri-devel@lists.freedesktop.org, dlemoal@kernel.org, ojeda@kernel.org, tytso@mit.edu, linux-rt-devel@lists.linux.dev, "Jeff
 Layton" <jlayton@kernel.org>, linux-modules@vger.kernel.org, cassel@kernel.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, "Chuck
 Lever" <cel@kernel.org>, "Anna Schumaker" <anna@kernel.org>
In-Reply-To: <20260706061928.66713-25-byungchul@sk.com>
References: <20260706061928.66713-1-byungchul@sk.com>
 <20260706061928.66713-25-byungchul@sk.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 07:33:41 +0000
Message-Id: <20260707073342.119731F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The patch introduces a performance regression on fast paths when=
 CONFIG_PROVE_LOCKING is enabled by adding an out-of-line function call to =
a macro that is unconditionally evaluated before checking if the assertion =
actually fails.
--

commit a2a5c1f9c5f68f19a3e991808b6e812dde3fa53a
Author: Byungchul Park <byungchul@sk.com>
locking/lockdep: prevent various lockdep assertions when lockdep_off()'ed

This commit adds a check for lockdep_recursing(current) to the
__lockdep_enabled macro. To avoid header dependency issues, it introduces
an out-of-line function lockdep_recursing_current().

> diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
> index 60b17a2ff555f..5113b7053b621 100644
> --- a/include/linux/lockdep.h
> +++ b/include/linux/lockdep.h
[ ... ]
> @@ -630,7 +631,7 @@ DECLARE_PER_CPU(int, hardirqs_enabled);
>  DECLARE_PER_CPU(int, hardirq_context);
>  DECLARE_PER_CPU(unsigned int, lockdep_recursion);
> =20
> -#define __lockdep_enabled	(debug_locks && !this_cpu_read(lockdep_recursi=
on))
> +#define __lockdep_enabled	(debug_locks && !this_cpu_read(lockdep_recursi=
on) && !lockdep_recursing_current())
> =20
>  #define lockdep_assert_irqs_enabled()					\
>  do {									\

[Severity: Medium]
Will this out-of-line call introduce measurable overhead on fast paths?

Since debug_locks and !this_cpu_read(lockdep_recursion) are almost always
true in healthy systems, lockdep_recursing_current() will be evaluated every
time __lockdep_enabled is checked.

For example, in lockdep_assert_irqs_enabled():

    WARN_ON_ONCE(__lockdep_enabled && !this_cpu_read(hardirqs_enabled));

Because __lockdep_enabled is the first operand, the out-of-line call execut=
es
before checking if the assertion actually fails.

Could we move __lockdep_enabled to the end of the && chain in these
assertions?

    WARN_ON_ONCE(!this_cpu_read(hardirqs_enabled) && __lockdep_enabled);

Placing the failure condition first would ensure the out-of-line function is
only evaluated on the slow path when the assertion is already failing, avoi=
ding
the function call overhead on hot paths entirely.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706061928.6671=
3-1-byungchul@sk.com?part=3D24
