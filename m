Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C144189AC;
	Tue,  7 Jul 2026 07:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783409633; cv=none; b=mDsk8t5QFJ6LiyKqu8YTBrMT2M7XIrQHUgSFLfLvvmPwVGuIk7gTxE32zgDcHvRoW2hmKF5e7dZWteYgIJY8uyrTEik+fpeje0ySm065qEDaZt+HW11SjNhT+oRPvlWGUv7u96avXYqwkCtkB8tq0QoveJehVo9Eiwvzzk9EgIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783409633; c=relaxed/simple;
	bh=4sIwc83ixaz4TUV2SZlXi8ngJHN7SQzSwiDBg0GBbY4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Sh44Tv5TxykksNGBBPVlmzv2GsH/ccBQSqDzVZLPe4O51aAQsslPvWWQsl35DJaL+XG5hgErjaWQ+A78+7nflLgmFf1HExYErTC+9FEobVgwHZN0qlYWqwkgag4RMEc2QPgXCGypOf46popwCumumBOSDWnivX041+qcg981ss0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LSCQtqyv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LSCQtqyv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 384E71F000E9;
	Tue,  7 Jul 2026 07:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783409631;
	bh=d78FYg/cIzWC/W00YTFzSsPORye58PHTDC+ZSZCPZEc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LSCQtqyvJAkgRhTDMUiDOAtLWo6i1y8W7LHe3zwktScTwsffFXh1Eutl900KVHJak
	 13kL2HrXX2Q5Qn4a9LhT3J/5SzYZ377drHzR52PxnTUzD+yW7FpdFSTInWYjjye1Sm
	 p3wfhuwYIJ3M6Ynia5Lb3Nadm0LNkBGVkL9jcB3cJWa1w4nE8b7kTQL5N3OJxfyT9C
	 6mvVHmbqFkJPgR6ikGs1VfIYMlM48o2DO3pIHUCuIDPqt6yLHzdCC3mm13MYHGzWII
	 V90OCh2VycTENqHXqV+8IQMVNmwVh3z/hVbF6UimZdoF3rgqsDmsENq6whMb7Lzhqb
	 H5Ay2Ezrs+3Bg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v19 33/40] dept: call dept_hardirqs_off() in
 local_irq_*() regardless of irq state
Reply-To: sashiko-reviews@lists.linux.dev
To: "Byungchul Park" <byungchul@sk.com>
Cc: linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org, "Jeff
 Layton" <jlayton@kernel.org>, linux-ide@vger.kernel.org, cassel@kernel.org, "Chuck
 Lever" <cel@kernel.org>, "Anna Schumaker" <anna@kernel.org>, dri-devel@lists.freedesktop.org, tytso@mit.edu, linux-rt-devel@lists.linux.dev, dlemoal@kernel.org, ojeda@kernel.org
In-Reply-To: <20260706061928.66713-34-byungchul@sk.com>
References: <20260706061928.66713-1-byungchul@sk.com>
 <20260706061928.66713-34-byungchul@sk.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 07:33:50 +0000
Message-Id: <20260707073351.384E71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Hides missing assembly trace annotations, causing DEPT and Lockdep=
 states to diverge and allowing NMIs to silently revert the workaround.
- [Medium] Exporting `dept_hardirqs_off` as GPL-only breaks the build/loadi=
ng of non-GPL modules that use `local_irq_save()` or `local_irq_disable()`.
--

commit 3f12c8d53e9de3037ef421690b95c2ca6667e3a1
Author: Byungchul Park <byungchul@sk.com>

dept: call dept_hardirqs_off() in local_irq_*() regardless of irq state

For dept to function properly, dept_task()->hardirqs_enabled must be set
correctly.  If it fails to set this value to false, for example, dept
may mistakenly think irq is still enabled even when it's not.

> diff --git a/include/linux/irqflags.h b/include/linux/irqflags.h
> index d8b9cf093f83d..586f5bad4da78 100644
> --- a/include/linux/irqflags.h
> +++ b/include/linux/irqflags.h
> @@ -214,6 +214,13 @@ extern void warn_bogus_irq_restore(void);
>  		raw_local_irq_disable();		\
>  		if (!was_disabled)			\
>  			trace_hardirqs_off();		\
> +		/*					\
> +		 * Just in case that C code has missed	\
> +		 * trace_hardirqs_off() at the first	\
> +		 * place e.g. disabling irq at asm code.\
> +		 */					\
> +		else					\
> +			dept_hardirqs_off();		\
>  	} while (0)

[Severity: High]
Can NMIs silently revert this workaround?

If assembly code disables IRQs but misses the trace_hardirqs_off() annotati=
on,
and then C code calls local_irq_disable(), this skips trace_hardirqs_off()
but executes the new dept_hardirqs_off() branch. Lockdep still thinks IRQs
are enabled, while DEPT thinks they are disabled.

If an NMI occurs while in this state, irqentry_nmi_enter() saves the Lockdep
state (which is incorrectly 'enabled'). Upon NMI exit, irqentry_nmi_exit()
restores the saved Lockdep state by calling lockdep_hardirqs_on(), which
unconditionally calls dept_hardirqs_on().

Will this force DEPT back into an incorrect 'enabled' state while hardware
IRQs are actually disabled, potentially leading to false-positive circular
dependency reports?

[ ... ]

> diff --git a/kernel/dependency/dept.c b/kernel/dependency/dept.c
> index 007e1bc7d201e..35a3667ac8b3c 100644
> --- a/kernel/dependency/dept.c
> +++ b/kernel/dependency/dept.c
> @@ -2095,6 +2095,7 @@ void noinstr dept_hardirqs_off(void)
>  	 */
>  	dept_task()->hardirqs_enabled =3D false;
>  }
> +EXPORT_SYMBOL_GPL(dept_hardirqs_off);

[Severity: Medium]
Will this break the build or loading of non-GPL modules?

Because dept_hardirqs_off() is now called directly from universal inline
macros like local_irq_disable() and local_irq_save(), any out-of-tree
module marked with a non-GPL license that invokes these macros will fail
to link or load when CONFIG_DEPT is enabled.

Standard trace_hardirqs_off() avoids this issue by being exported via
EXPORT_SYMBOL.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706061928.6671=
3-1-byungchul@sk.com?part=3D33
