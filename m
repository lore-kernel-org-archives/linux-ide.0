Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5DC3F166E;
	Tue,  7 Jul 2026 07:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783409619; cv=none; b=NkOWYondNa8l0YTOudfs2ZMOgzFYfp+DPPAGQWE73NI8YpByAlVzrY8SFbC648ZuJ5SM4YFMd17LYyDt5bskypRLMuqZvP8eRrXWB7ObttWzWI95DJKjPCOPOjg9ziinVVghGZVXW1gT9CQVVHT6j1XTruvMdKJJfPDGISF0li4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783409619; c=relaxed/simple;
	bh=cpdezPRszCD6Xz4Hg7CBehTDO3yOIYlwDRhwp4nEL2U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FJXcgM9fp0q/ILDlYTZy1TpSwXjg/TDFmSLfITdTP55o1Hq4LCCVFABqyLvdeez+lUuDGaAXixodiO6MbNT4RaLrOhhTBukJTLv4TKLAY2QgiulVMfLuQe9w9hM7keiz6rLFlEr1OFP15e1TRutOTVxGdbAlVnD0VOAuRk7xLow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mGLQ/QN8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mGLQ/QN8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 097CA1F000E9;
	Tue,  7 Jul 2026 07:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783409617;
	bh=wRQA4HN5T0ZFW64B//7tkOJufQeVLQgQkGRx8y4cc3c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mGLQ/QN8JHoguRWt5gP2UHwGvqRVlH2lFUb6w3IVwGABTOTWAOBb05jOwYaC1B4fn
	 bLAUJO1TiDnKsVLTLyu3XJ2UfaEg7aQerlcX3QSDIAClBJ1bi15LKtw+e9tZ0mJ33c
	 OhdQAhgqXwAsemRotBSMFYvvDIDokUQU3binyvw1ZmaAV6RgPUMP/DzwSVGyzDC7gS
	 MIwzMePanL/XrmF1UEUU622tCzdkvJ+wuFJTBxsVLG7aiPvL28h4Y91aMeZ3RMxCXP
	 +oUSUYBQDGrQDXA7Cpga3RcAv0V32ARLy98qqifbLbh+pHZlOnYbySMikzmimnovMP
	 F++/rDPOhMjHg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v19 19/40] dept: apply timeout consideration to
 hashed-waitqueue wait
Reply-To: sashiko-reviews@lists.linux.dev
To: "Byungchul Park" <byungchul@sk.com>
Cc: ojeda@kernel.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, "Anna
 Schumaker" <anna@kernel.org>, "Chuck Lever" <cel@kernel.org>, dlemoal@kernel.org, linux-rt-devel@lists.linux.dev, "Jeff
 Layton" <jlayton@kernel.org>, tytso@mit.edu, cassel@kernel.org, linux-modules@vger.kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260706061928.66713-20-byungchul@sk.com>
References: <20260706061928.66713-1-byungchul@sk.com>
 <20260706061928.66713-20-byungchul@sk.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 07:33:36 +0000
Message-Id: <20260707073337.097CA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Missing `sdt_might_sleep_end()` cleanup in the error path of wait =
macros (e.g., `___wait_var_event`, `___wait_event`, `___swait_event`) bypas=
ses `dept_clean_stage()`, leaking the staged wait event state and corruptin=
g DEPT tracking.
--

commit cf04720896ab037609320947c88e8faa57dbddd7
Author: Byungchul Park <byungchul@sk.com>

dept: apply timeout consideration to hashed-waitqueue wait

Now that CONFIG_DEPT_AGGRESSIVE_TIMEOUT_WAIT was introduced, apply the
consideration to hashed-waitqueue wait, assuming an input 'ret' in
___wait_var_event() macro is used as a timeout value.

> diff --git a/include/linux/wait_bit.h b/include/linux/wait_bit.h
> index 179a616ad245a..9885ac4e1ded5 100644
> --- a/include/linux/wait_bit.h
> +++ b/include/linux/wait_bit.h
> @@ -258,7 +258,7 @@ extern wait_queue_head_t *__var_waitqueue(void *p);
>  	struct wait_bit_queue_entry __wbq_entry;			\
>  	long __ret =3D ret; /* explicit shadow */				\
>  									\
> -	sdt_might_sleep_start(NULL);					\
> +	sdt_might_sleep_start_timeout(NULL, __ret);			\

[Severity: High]
Does this error path properly clean up the dept wait state?

Lower in the ___wait_var_event() macro, if a signal is received it jumps to
__out:

		if (___wait_is_interruptible(state) && __int) {		\
			__ret =3D __int;					\
			goto __out;					\
		}							\
	=09
		...
	=09
	sdt_might_sleep_end();						\
__out:	__ret;								\

Because the goto __out branch skips sdt_might_sleep_end(), does it leave a=
=20
dangling stage context in the dept subsystem's tracking graph? =20

If the stage context remains populated, could a subsequent wait on the same
task be incorrectly seen as a nested stage, potentially corrupting dept
tracking or leading to false deadlock reports?

(Note: A similar goto __out pattern skipping sdt_might_sleep_end() also
exists in ___wait_event() in include/linux/wait.h and ___swait_event() in
include/linux/swait.h).

>  	init_wait_var_entry(&__wbq_entry, var,				\
>  			    exclusive ? WQ_FLAG_EXCLUSIVE : 0);		\
>  	for (;;) {							\

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706061928.6671=
3-1-byungchul@sk.com?part=3D19
