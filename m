Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD20416117;
	Tue,  7 Jul 2026 07:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783409632; cv=none; b=meM/ivSDek1RyE12TXn8ShlH3QYqkKrMBIXWUlV3UpBTH7C01klmkFSS15XQiU1I+7bCidZxX4hzJeHCpfcBQIJKZw+G3BEIlP79jSfsOEvXubUHoE0ROBNKGmAmzJm4K/7rCEpi6YVM11bXJGOeLTZi6+dFbAszy3376yET5H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783409632; c=relaxed/simple;
	bh=xq7g7me3sYLudB3cfDK5NvAvWeXmXX7rBq/JLLczh40=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=k3wsas3tU2oPSxAxmErzMQw4Q9YN5RkT6q6aGe7HJ6wRq9AEOnnZR3xA2z7+7wKh48kQi38ThXLnEhifvFSDXhmj5fWMLn1yJklSGAad4iAjYFBfr8F1wTMIVEo5g8DAN/Io2znrqOmFf+SaKGF5nO/zrmmQW59VC/SyS3MmeHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=becB94z1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="becB94z1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0965F1F00A3E;
	Tue,  7 Jul 2026 07:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783409630;
	bh=c+VSnSjFRcFL2UYOIKKOUNT7KazPYUK7QU08PtQTxxM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=becB94z18LgfMpYXzuHELj6ZtB6sKdTUr8mZ2PW4SgPauseZ1dFRDkU8i8BDTKgYb
	 exG3677WXn7VOpoQQQOwCcuCrOslNSSv7hED2xinrObDCIelvuv9M8vLq91ITxJkbe
	 SmloJHXHbeO/eKpObxjD74SLSrS8p7Ky8VjyWt4AhWkNgPSnThA3xzGvD4h7UVg/GG
	 HJIEZ08WmgNfS8+qwrAgDuchnG+Uo0kd/nnoQsI7SF+8l9QOchA9wFfA+6Il23iuH/
	 3HfylDskRvSVrxct5vdwBSuJg+37FyFKAToss0JvwmZPcQNtNEkrsZYuvHCxABzr9Y
	 3JqTC0VfXq52Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v19 32/40] completion, dept: introduce
 init_completion_dmap() API
Reply-To: sashiko-reviews@lists.linux.dev
To: "Byungchul Park" <byungchul@sk.com>
Cc: dlemoal@kernel.org, "Jeff Layton" <jlayton@kernel.org>, linux-modules@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-rt-devel@lists.linux.dev, cassel@kernel.org, linux-kernel@vger.kernel.org, tytso@mit.edu, "Chuck
 Lever" <cel@kernel.org>, linux-ide@vger.kernel.org, "Anna Schumaker" <anna@kernel.org>, ojeda@kernel.org
In-Reply-To: <20260706061928.66713-33-byungchul@sk.com>
References: <20260706061928.66713-1-byungchul@sk.com>
 <20260706061928.66713-33-byungchul@sk.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 07:33:49 +0000
Message-Id: <20260707073350.0965F1F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Double evaluation of arguments in wait_for_completion macros leads=
 to skipped array indices and memory corruption.
- [Medium] Unconditional struct growth of a widely used primitive for a deb=
ug feature.
- [Medium] Wait event macros skip calling sdt_might_sleep_end() on signal i=
nterruptions, leaking DEPT tracking state and stacks.
--

commit 5b626a37ee940081b6d37187cde51c2f272e370c
Author: Byungchul Park <byungchul@sk.com>

completion, dept: introduce init_completion_dmap() API

Currently, dept uses dept's map embedded in task_struct to track
dependencies related to wait_for_completion() and its family.  So it
doesn't need an explicit map basically.

However, for those who want to set the maps with customized class or
key, introduce a new API to use external maps.

> diff --git a/include/linux/completion.h b/include/linux/completion.h
> index 4d8fb1d95c0a6..e50f7d9b4b974 100644
> --- a/include/linux/completion.h
> +++ b/include/linux/completion.h
> @@ -27,17 +27,15 @@
>  struct completion {
>  	unsigned int done;
>  	struct swait_queue_head wait;
> +	struct dept_map *dmap;
>  };

[Severity: Medium]
Since struct completion is heavily embedded in many kernel data structures,
does unconditionally adding the dmap pointer increase the global memory
footprint even on production non-debug kernels? Should this new field be
guarded by an #ifdef?

[ ... ]

> @@ -136,13 +140,13 @@ extern void complete_all(struct completion *);
> =20
>  #define wait_for_completion(x)						\
>  ({									\
> -	sdt_might_sleep_start_timeout(NULL, -1L);			\
> +	sdt_might_sleep_start_timeout((x)->dmap, -1L);			\
>  	__wait_for_completion(x);					\
>  	sdt_might_sleep_end();						\
>  })

[Severity: High]
Does evaluating the argument x multiple times in this macro lead to issues
if callers pass an expression with side effects?

For example, if a caller like mlx5_vdpa_exec_async_cmds() does:

	while (completed < issued)
		wait_for_completion(&cmds[completed++].cmd_done);

Would completed++ be executed twice per iteration, skipping array elements
and potentially causing out-of-bounds memory accesses?

[ ... ]

[Severity: Medium]
Do wait event macros such as ___wait_event() in include/linux/wait.h skip
calling sdt_might_sleep_end() when interrupted by a signal?

In include/linux/wait.h:___wait_event():

		if (___wait_is_interruptible(state) && __int) { \
			__ret =3D __int; \
			goto __out; \
		}
        ...
	sdt_might_sleep_end(); \
__out:	__ret; \
})

If the wait is interrupted by a signal, it escapes via goto __out. Because
__out is placed after sdt_might_sleep_end(), it seems the cleanup is
skipped.

Does this permanently leak the tracking state and its underlying stack
objects?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706061928.6671=
3-1-byungchul@sk.com?part=3D32
