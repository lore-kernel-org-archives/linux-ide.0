Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F653DD866;
	Tue,  7 Jul 2026 07:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783409611; cv=none; b=EePJrlfeYWFVPyR3byLlKiin+CO4rANNdaR7rZMxo1s5lAj86B4vixCR5DpoghVbMJ0yNJ62YiBhIsbbQwPA2xRnLiFXoWk1/rcXAAmzfcBylZ4Bb4pP9CS/HtwViaWyD4GlBZ62qBIlEoU6L0DRi05Rke0yzuAADo3IL63G2AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783409611; c=relaxed/simple;
	bh=0QtGpZ5hsw3qjteBUfipW0q1CErQDxgwi2IkZTeAw70=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=m5O/75mWNeWPKZKqDuvtl+O+NLIi8bH3qmSXrYJNifYjSVeQzNogOHNUB2q+mZPCWXcImz+3ZbrZpW3HZyJans4ucJZznIcQ3Y+lHRO+S90KkTnJNsAp3woT8cBl3BiueoUU617VxZY0PIxMqR8GTBaTpsT6UvPG3zYKR3b8uGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i6SRejcT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i6SRejcT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4CE41F00A3D;
	Tue,  7 Jul 2026 07:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783409610;
	bh=4HO9NTC2IIFbYOH0gv4YNtH+ly33tb1GqBVw0WwfVWU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=i6SRejcTyfs1vj6La4zFnYx5R9fC3HOSqKDwoSonnzoQBhJgMF4y4z61bXtwYY6m/
	 fF8xcIQHCM4szZAEPG4NtK4d0ImheL8ek9uh6+t5Dn0REdumrqFx1SQQtqmP/5fvmK
	 wsrDWVd45JwkNpUXMU2gbV+jHY2hQR5k0LFMn23M7qvJ3+zkMb+Q/WuYTZ/JrNp6Jq
	 DgTHr/gH2g/Jc45XusSmKkqziIMCsmEy5HFbTSdqIC4jdTby29RMDwocQSUdbOHXHN
	 KZVHh+FEkn+eIhnqghH8jzINQNZMQBop2Y9YymGsaz2oJZhKs6J94PiZWwYoGshjMT
	 VdTh69UYojrBA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v19 17/40] dept: apply timeout consideration to swait
Reply-To: sashiko-reviews@lists.linux.dev
To: "Byungchul Park" <byungchul@sk.com>
Cc: cassel@kernel.org, "Jeff Layton" <jlayton@kernel.org>, "Anna Schumaker" <anna@kernel.org>, ojeda@kernel.org, dri-devel@lists.freedesktop.org, linux-rt-devel@lists.linux.dev, tytso@mit.edu, dlemoal@kernel.org, linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, "Chuck
 Lever" <cel@kernel.org>
In-Reply-To: <20260706061928.66713-18-byungchul@sk.com>
References: <20260706061928.66713-1-byungchul@sk.com>
 <20260706061928.66713-18-byungchul@sk.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 07:33:28 +0000
Message-Id: <20260707073328.A4CE41F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] When a wait event is interrupted by a signal, it bypasses sdt_migh=
t_sleep_end(), permanently leaking the DEPT wait stage.
--

commit 264d829a8f72641205caea8b130ee3c25557563a
Author: Byungchul Park <byungchul@sk.com>

dept: apply timeout consideration to swait
   =20
Now that CONFIG_DEPT_AGGRESSIVE_TIMEOUT_WAIT was introduced, apply the
consideration to swait, assuming an input 'ret' in ___swait_event()
macro is used as a timeout value.

> diff --git a/include/linux/swait.h b/include/linux/swait.h
> index 277ac74f61c39..233acdf55e9bc 100644
> --- a/include/linux/swait.h
> +++ b/include/linux/swait.h
> @@ -162,7 +162,7 @@ extern void finish_swait(struct swait_queue_head *q, =
struct swait_queue *wait);
>  	struct swait_queue __wait;					\
>  	long __ret =3D ret;						\
>  									\
> -	sdt_might_sleep_start(NULL);					\
> +	sdt_might_sleep_start_timeout(NULL, __ret);			\

[Severity: High]
Is this a regression where a signal-interrupted wait event permanently leaks
the dept wait stage tracking state?

Looking at ___swait_event(), if the task receives a signal while waiting, it
evaluates ___wait_is_interruptible(state) && __int as true and takes the
goto __out path:

		if (___wait_is_interruptible(state) && __int) {
			__ret =3D __int;
			goto __out;
		}

This jumps completely over the cleanup call:

	finish_swait(&wq, &__wait);
	sdt_might_sleep_end();
__out:	__ret;

Without calling sdt_might_sleep_end() and its underlying dept_clean_stage(),
the dept state isn't cleaned up for the current task. Subsequent waits by t=
his
task will fail to register new dependency maps and instead repeatedly commit
the stale wait map during __schedule(). This irreversibly corrupts the lock
dependency graph and triggers false deadlock reports.

The exact same bypass flaw appears to be present in ___wait_event() in
include/linux/wait.h and ___wait_var_event() in include/linux/wait_bit.h.

>  	INIT_LIST_HEAD(&__wait.task_list);				\
>  	for (;;) {							\
>  		long __int =3D prepare_to_swait_event(&wq, &__wait, state);\

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706061928.6671=
3-1-byungchul@sk.com?part=3D17
