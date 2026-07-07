Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E0F33FCB05;
	Tue,  7 Jul 2026 07:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783409625; cv=none; b=IGzBopc0rhq72H3gTYSaAvKrRYiLwoK/s+RbSzBzBxt8Suq2meKh2NeoqRuS/Dmk2eCK4l3XHKRbh7iewO1T2MhYVW/jlZgR0QaNBmcL0dl5vYSUO1D996YkEJNlBzWSPiBacHy6MWjCTaSfnSUV2imvJEQJIydxB7kbmALJxLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783409625; c=relaxed/simple;
	bh=RQu5aIuSJxquSLqBdPzL6RjtkYa8o1q2IvAkjhSyido=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=E5qp638GjDrvd1/PGAieccmGIWsE2w4BMMh/YrBMxadXchtj3Dt71NumUt9chA+KTnOBrOq8uUtv+wz/wi5HmPpZve0iE7mrxAncKObeGECsuQUpFAfjYMqBzrwfuHzI0uO6B/AlfSjGpUIDTaENtw6qxxoQYMq4qry7/oin8+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f84UEAOi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f84UEAOi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43ECD1F00A3A;
	Tue,  7 Jul 2026 07:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783409624;
	bh=jPs3K0/sbtyyQ4BTexD861LzKdzWfnpZmMddb3M3x+A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=f84UEAOilWNtAVfMrOWu2s5LhtwnTl5QCQXoTm/Ab6OSin0aLrceaAdK01xVUYM9Y
	 nTnBOzh2cQlW6YP0IHG5xuawwovWRXtBDryMLssmYArMiomuAdQYGMIAs/ovK4vYtz
	 yOgFN1zo6BpYrfnZ9vuIhxEEn/hJBciArrAtMfMElU7YEqgouQwPGTv+DFzB4povR+
	 AQHBEzAZoPhIeuLVSXvEc3msO7mIt/M4n9xZ3FhONtq/VC5t8WzB604N0lLLDPFNVw
	 cj1/FOomrd/++p+gn6eG660XTGHT5TzIL/UbMjOmr/VYRFcBSxdTRn91unFnxGv8kQ
	 sm5JAa1z8WfrQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v19 27/40] dept: assign dept map to mmu notifier
 invalidation synchronization
Reply-To: sashiko-reviews@lists.linux.dev
To: "Byungchul Park" <byungchul@sk.com>
Cc: linux-modules@vger.kernel.org, cassel@kernel.org, linux-kernel@vger.kernel.org, tytso@mit.edu, "Chuck
 Lever" <cel@kernel.org>, linux-rt-devel@lists.linux.dev, dri-devel@lists.freedesktop.org, "Jeff
 Layton" <jlayton@kernel.org>, "Anna Schumaker" <anna@kernel.org>, ojeda@kernel.org, linux-ide@vger.kernel.org, dlemoal@kernel.org
In-Reply-To: <20260706061928.66713-28-byungchul@sk.com>
References: <20260706061928.66713-1-byungchul@sk.com>
 <20260706061928.66713-28-byungchul@sk.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 07:33:42 +0000
Message-Id: <20260707073343.43ECD1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Unbalanced DEPT tracking context leak in mmu_notifier_invalidate=
_range_start_nonblock()
--

commit 10f75b8cdecfe9a5cbc6804a1d8ae1770fc9fe67
Author: Byungchul Park <byungchul@sk.com>

dept: assign dept map to mmu notifier invalidation synchronization

This commit introduces explicit DEPT tracking contexts to resolve false
positive deadlock reports in mmu_notifier invalidation synchronization.
It annotates the start and end of the event contexts delimited by
mmu_notifier_invalidate_range_start() and _end().

> diff --git a/include/linux/mmu_notifier.h b/include/linux/mmu_notifier.h
> --- a/include/linux/mmu_notifier.h
> +++ b/include/linux/mmu_notifier.h
[ ... ]
> @@ -460,6 +474,12 @@ mmu_notifier_invalidate_range_start_nonblock(struct =
mmu_notifier_range *range)
>  		ret =3D __mmu_notifier_invalidate_range_start(range);
>  	}
>  	lock_map_release(&__mmu_notifier_invalidate_range_start_map);
> +
> +	/*
> +	 * From now on, waiters could be there by this start until
> +	 * mmu_notifier_invalidate_range_end().
> +	 */
> +	mmu_notifier_invalidate_dept_ecxt_start(range);
>  	return ret;
>  }

[Severity: Medium]
Does this unconditionally start the DEPT event context even if the
non-blocking start fails?

If mmu_notifier_invalidate_range_start_nonblock() returns an error, callers
typically abort and skip calling mmu_notifier_invalidate_range_end(). For
example, in mm/oom_kill.c:__oom_reap_task_mm():

    if (mmu_notifier_invalidate_range_start_nonblock(&range)) {
        tlb_finish_mmu(&tlb);
        ret =3D false;
        continue;
    }

Could this lead to an unbalanced DEPT context being leaked, as the
corresponding mmu_notifier_invalidate_dept_ecxt_end() will never be called
on the error path?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706061928.6671=
3-1-byungchul@sk.com?part=3D27
