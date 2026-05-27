Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4AEE313520
	for <linux-ide@vger.kernel.org>; Wed, 27 May 2026 20:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779915344; cv=none; b=X51f2okl134UZuQ7C53yWOrAtHM5dyN62YApeQsdDp02hJQvQmK8HGg1nw6SXd2uVqWoLSETboGzbwWswxchPIFMy4t7s4zl55W5itOY/3jL2RuGIfdE2owhIOGgaHYLYYjq71qGnhWjSDiEOxRyXQJzU4a30L36fEQrGJrGYlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779915344; c=relaxed/simple;
	bh=NW4VnemGHNhJMr2xWkMeG1ruuXhIkSjvUTACNMiIpz8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OW8Tp94Ieu3UeFWA/PNVgz/INKu/eNZ5a1Xr2zxrobpV6UecI1vHlrrUN5LvWFmfllhz+8N6SZKZJO1O35+l0/vqr4GtP9bLxuZP7+tA4nOFipw+HTOvG/icQG493twFWZ54rX9/m2RSG1pu2y1IL11xCpxPECnVnEK8TAtivLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JXdho6mk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JXdho6mk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93DCA1F000E9;
	Wed, 27 May 2026 20:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779915343;
	bh=TmhowxbCv4R/S7Z5k+lGVyyWtP2PixuuU0Of7dZcYXQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JXdho6mkZs3/iyzeUqCdRdcKfaK9Jy2e8au4e1vhPVahh/idIGl/dLJB3cwdkn88x
	 GV71WhTs0crCqfcVUMA4M/JkpKbeq/v3vM3SRCaemtFdwgX0K+HMq7uG5XTI30A2Mb
	 98MD+pEz1k4k9tAEmFAXtoCKW+hQDkyYCMXzUru0r21w9BKHsG3F5Sw678fD3JK55N
	 rCPqayR6Vy4IW2Hz/hp08y8kyfXOxa7AwnBQ1BKRkWwW+QqjQ4cpUUs7Na2LcZPu2y
	 f5hK0z18WC42eYNucQoqAkCrgWHl7V73jkFwAdHgYJDPG5G4DkTK3YXe5YyqQdZ/8P
	 EVcMmB6lvGOKA==
Date: Wed, 27 May 2026 22:55:38 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: linux-ide@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>,
	Marco Elver <elver@google.com>, Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Viresh Kumar <vireshk@kernel.org>,
	Mikael Pettersson <mikpelinux@gmail.com>,
	Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH v3] ata: libata: Document when host->eh_mutex should be
 held
Message-ID: <ahdaSvf_ydZ8TdiR@ryzen>
References: <e95c0eb43a8297c9ab5e220341512882f8648512.1779913278.git.bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e95c0eb43a8297c9ab5e220341512882f8648512.1779913278.git.bvanassche@acm.org>

Hello Bart,

On Wed, May 27, 2026 at 01:25:20PM -0700, Bart Van Assche wrote:
> Annotate the following functions with __must_hold(&host->eh_mutex):
>  * All ata_port_operations.error_handler() implementations.
>  * ata_eh_reset() and ata_eh_recover() because these functions call
>    ata_eh_release() and ata_eh_acquire().
>  * All callers of ata_eh_reset() and ata_eh_recover().
> 
> Enable Clang's context analysis. This will cause the build to fail if
> e.g. a locking bug would be introduced in an error path. This patch
> should not affect the generated assembler code.
> 
> Note: although the Linux kernel documentation specifies 22 as minimal
> version for Clang for context analysis support, annotating function
> pointers is a Clang 23 feature. As one can see here, a patch has been
> queued that fixes the kernel documentation:
> https://lore.kernel.org/all/177926568868.711.3058599932884307249.tip-bot2@tip-bot2/
> 
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
> 
> Changes compared to v2:
>  - Instead of annotating only function declarations, annotate both function
>    declarations and function definitions.
>  - Changed __assume_ctx_lock() into lockdep_assert_held().
>  - Left out the host lock changes because there is no agreement about how to
>    annotate functions that expect that the host lock is held.

I am happy with this patch, and think that it is basically ready to be
merged as it is.

It only adds two lockdep_assert_held() calls, so that seems okay,
considering that it is not a crazy amount.


Now for ap->lock: It would be a shame if the work you did on ap->lock
annotations were to go to waste.

In:
https://lore.kernel.org/linux-ide/fcc80572-88da-4e16-ad09-69819f43cd73@acm.org/

You said that you would leave out the patches that adds an "ap" argument to
several functions. That sounds good.

If we go with the option to not add "ap" arguments everywhere, how many
lockdep_assert_held() calls would a patch that adds ap->lock annotations
need to add?

If it is not a crazy number, I think we should just do it.


Kind regards,
Niklas
