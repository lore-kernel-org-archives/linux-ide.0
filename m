Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 759894252AD;
	Tue,  7 Jul 2026 07:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783409641; cv=none; b=hMMun8DoWvu+HdjTrc7dGCMONaJ7T6NOdjghs9YUaUEm145jcImDZi2jr5S367bKuW2nBTCiubmt0f0gIQ8gm5j9LFt4d3AAtjTCQa9HyCmHs0vWhjyk3sp6jbxrfF4CIFCgmYNZ7gfQ2cBY7h83Ibnlfp4e9iPk7uTCwgpSrkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783409641; c=relaxed/simple;
	bh=axvmtYacZzdXzwTvhYsv7217M4rSRezdK8GDLe6wL1o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rwh7NQbX8PXP0mlM4OeJlUEw8e1zy3NKoiC6pbFrTEVSa6dAqEjW9UaoPzCZ1YML6lM2WaXKwrn6UG0Lige+WWKanaStVR4AEaltpVafB7E+Szh6R+I9/AsKypqXZdA07fCELG9XjO/Kq9b+rdtblrsKd6xDBPF1KQMVXpL07no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l9AlrQ6U; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l9AlrQ6U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 626DE1F00A3D;
	Tue,  7 Jul 2026 07:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783409640;
	bh=WSjju01qITlRREihj9UnmYy2mNsYb5lkSCXyhbNH/mc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=l9AlrQ6U6JSdJormMeIj/QOX5AfTtFDxiGZqyZBzQSJcBpPCxWLMqOgpwh9jcx/WC
	 LJBDJs2cX3Nw3P3CfK0Z9Gjmt/4AF+hBlf1PCJ526lNdTF0LH8Rt9bF9/K2KAXSw7I
	 89Z0M65XLSTCJb7Yo/SAQvSspTjH5nfgRQ54ASWg/ZAMC1yItPGwVi/RszI7z2OIQi
	 rQ5b7L+4+xaEmdwqPdWEoo8hvCx/EVsgBnXIjFnC2jZfJxf/fHPcp6tq4YUeh7K850
	 IkDuQ2vXTuzm9+8nV03PxQgCb2ojVTIoPNhgd6VgeUvpJhVgADatsz99nphJq6beWW
	 LbpEsMuSPErVw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v19 40/40] dept: implement a basic unit test for dept
Reply-To: sashiko-reviews@lists.linux.dev
To: "Byungchul Park" <byungchul@sk.com>
Cc: cassel@kernel.org, dri-devel@lists.freedesktop.org, "Jeff Layton" <jlayton@kernel.org>, dlemoal@kernel.org, tytso@mit.edu, ojeda@kernel.org, linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org, "Anna
 Schumaker" <anna@kernel.org>, linux-ide@vger.kernel.org, "Chuck Lever" <cel@kernel.org>, linux-rt-devel@lists.linux.dev
In-Reply-To: <20260706061928.66713-41-byungchul@sk.com>
References: <20260706061928.66713-1-byungchul@sk.com>
 <20260706061928.66713-41-byungchul@sk.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 07:33:58 +0000
Message-Id: <20260707073359.626DE1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Data race on lockless global `dept_ut_results` test counters.
--

commit ed16879949bb8cfa840ac89b2502567868a42cfe
Author: Byungchul Park <byungchul@sk.com>

dept: implement a basic unit test for dept

This commit introduces CONFIG_DEPT_UNIT_TEST and a corresponding kernel
module that runs basic unit tests for the Dependency Tracker (DEPT).

> diff --git a/include/linux/dept_unit_test.h b/include/linux/dept_unit_tes=
t.h
> new file mode 100644
> index 0000000000000..753ac9ac727c6
> --- /dev/null
> +++ b/include/linux/dept_unit_test.h
[ ... ]
> +static inline void dept_ut_ecxt_stack_account(bool valid)
> +{
> +	dept_ut_results.ecxt_stack_total_cnt++;

[Severity: Medium]
Since this global counter is incremented non-atomically, can it race with
concurrent DEPT evaluations (e.g., from print_dep()) on other CPUs? A stand=
ard
data race here might lead to corrupted test counters or trigger KCSAN warni=
ngs.

[ ... ]
> diff --git a/kernel/dependency/dept_unit_test.c b/kernel/dependency/dept_=
unit_test.c
> new file mode 100644
> index 0000000000000..e8dada2e3dfba
> --- /dev/null
> +++ b/kernel/dependency/dept_unit_test.c
[ ... ]
> +static DEFINE_SPINLOCK(s1);
> +static DEFINE_SPINLOCK(s2);
> +static bool test_spin_lock_deadlock(void)
> +{
> +	dept_ut_results.circle_detected =3D false;

[Severity: Medium]
Is it safe to reset this flag without protection? If a genuine dependency
issue triggers DEPT on another CPU and calls print_circle() concurrently,
could it set circle_detected to true and interfere with this test's result?

[ ... ]
> +static int __init dept_ut_init(void)
> +{
> +	int i;
> +
> +	lockdep_off();
> +
> +	dept_ut_results.ecxt_stack_valid_cnt =3D 0;
> +	dept_ut_results.ecxt_stack_total_cnt =3D 0;
> +	dept_ut_results.wait_stack_valid_cnt =3D 0;
> +	dept_ut_results.wait_stack_total_cnt =3D 0;
> +	dept_ut_results.evnt_stack_valid_cnt =3D 0;
> +	dept_ut_results.evnt_stack_total_cnt =3D 0;

[Severity: Medium]
Could resetting these global counters locklessly and without accessors like
WRITE_ONCE cause issues? It appears this setup could race with concurrent
DEPT reports modifying them simultaneously in print_dep().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706061928.6671=
3-1-byungchul@sk.com?part=3D40
