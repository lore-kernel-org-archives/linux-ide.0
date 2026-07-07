Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FDBB3E5EC2;
	Tue,  7 Jul 2026 07:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783409614; cv=none; b=ZO2JEfbi9oWvB6KtS/oe8dhNNmsSy4Iv1YnPisd6FkrAiXGsipuq+2PMbTxv9KliC/BQYm+PzFscbr06DWXjjDJDa+LFVjOTE4LNrTxPvXTQ++ryrbrjvEfYzg5R8UnIsqY6/KVvzrHQBZuvfBbqzzMi1lUf6pUrqusSLqPzhvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783409614; c=relaxed/simple;
	bh=VzAP7qanhLQVu4me13wkALuw0YXHUL1pSIOGecDyXrc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=isxLsURB2rvScdgXDxMJb3Rc9nmFQYRJJ4Pdegpx6brzk6QgbuaBEeSG3YBfHOFC34K7KZzO7/XtlRoeHAD4Zm/Q7FEPvYN4TGKYRlM6Ffq1WAcEp5MoY86YU52KuL9h/qm3rbrimwRM/a7AXNptYJkmBPHRgAPFOvDDKssm+wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QSfw3KvU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QSfw3KvU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB4E11F00A3F;
	Tue,  7 Jul 2026 07:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783409613;
	bh=v1oOPeTvAISVGM6dIZHjUhBxaruZEjK+yszFzabP8u4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QSfw3KvUGNZyD7K+Ri51UddKzPhCdjdOv03qy7E+nKKgDOsoW3/CQ8Mf81PzRpIia
	 EbmDLmX9p9ll7l5XkJfT8XUfBYnpRdDLRHwZL36we+Oh3zPNUeLaFCTuqQnmNWLhLs
	 aWzAG8Jqhd7kyNJsjzUTg1/xyI/m3a8TDszXv52OcmXtPkFGNHwf/EFFr7N05IHSiD
	 FrmSQS2vop7nP0YO+eG+IlYnaB6jf8vNsKbuC7XKjVDMjqyx47Fp36h/bb4fEOXTwa
	 bC6S0keNYhDt20jg/Vg0x1n9HJ2pZPpcc8/xyqBOMXnuicNXJc9TiTu201NVxmO3Mf
	 oCefMA6azR8tw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v19 06/40] dept: distinguish each kernel context from
 another
Reply-To: sashiko-reviews@lists.linux.dev
To: "Byungchul Park" <byungchul@sk.com>
Cc: cassel@kernel.org, dri-devel@lists.freedesktop.org, "Anna Schumaker" <anna@kernel.org>, ojeda@kernel.org, tytso@mit.edu, linux-modules@vger.kernel.org, "Jeff
 Layton" <jlayton@kernel.org>, "Chuck Lever" <cel@kernel.org>, dlemoal@kernel.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
In-Reply-To: <20260706061928.66713-7-byungchul@sk.com>
References: <20260706061928.66713-1-byungchul@sk.com>
 <20260706061928.66713-7-byungchul@sk.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 07:33:32 +0000
Message-Id: <20260707073332.DB4E11F00A3F@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] cur_cxt() incorrectly identifies a hardirq interrupting a softirq =
as a softirq context, mixing dependencies between unrelated execution conte=
xts.
--

commit 504ac1eb7d0a4081c645648037ec455b5ec741d7
Author: Byungchul Park <byungchul@sk.com>

dept: distinguish each kernel context from another

Each unique kernel context, in dept's point of view, should be
identified on every entrance to kernel mode e.g. system call or user
oriented fault.  Otherwise, dept may track meaningless dependencies
across different kernel context.

> diff --git a/kernel/dependency/dept.c b/kernel/dependency/dept.c
> index fd091ae28ae27..1c4de1b55730a 100644
> --- a/kernel/dependency/dept.c
> +++ b/kernel/dependency/dept.c
[ ... ]
> -static int cur_irq(void)
> +static int cur_cxt(void)
>  {
>  	if (lockdep_softirq_context(current))
> -		return DEPT_SIRQ;
> +		return DEPT_CXT_SIRQ;
>  	if (lockdep_hardirq_context())
> -		return DEPT_HIRQ;
> -	return DEPT_IRQS_NR;
> +		return DEPT_CXT_HIRQ;
> +	return DEPT_CXT_PROCESS;
>  }

[Severity: High]
This is a pre-existing issue, but does cur_cxt() incorrectly prioritize sof=
tirq
over hardirq context here?

If a softirq is executing and is interrupted by a hardirq, both
lockdep_softirq_context(current) and lockdep_hardirq_context() evaluate to
true. Because the softirq check comes first, cur_cxt() will return
DEPT_CXT_SIRQ instead of DEPT_CXT_HIRQ.

Could this cause the waits and events triggered inside the interrupting har=
dirq
to be erroneously attributed to the interrupted softirq's context, potentia=
lly
mixing unrelated dependencies and leading to false positive circular depend=
ency
reports?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706061928.6671=
3-1-byungchul@sk.com?part=3D6
