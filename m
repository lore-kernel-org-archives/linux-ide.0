Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 777DB43CEF0
	for <linux-ide@vger.kernel.org>; Mon, 11 May 2026 16:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778518394; cv=none; b=EQh+3w2Qezbti+lJL8g2IHt8/1aA/CeBfVcSdNyO7JGSHXroRzwDwmzpelMPh9c4uJ/Sex76ZNPUKTq7FFv4LDMJwTXbQmLPctNonlvQ6QdKG16RC891RWvtwZY5I7Qz+AtW8ChPtipNadDiE86wxTBoCsj+GIJ4EujwY93kzS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778518394; c=relaxed/simple;
	bh=vB5aY1DyzsRtmjQ53AWD6G1IZGgAL+fjtSzWDQ14Lcg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H8VQP/+ZWP3fp+PWxVTZu/m+1xl2xl820x3z3U8M/jRzD78B77SKM49YFRHc+JYMnKftZJqQVkn6zEblLBnmw2D2X6JnMUvMvWxdZGxj/SqNqpeyzF0gKhWIqRgA7pxm2GNCyKW8F/FHu3mjRZdrX18XLHV9WLtDU1i+qYbSMyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MLe5C7sj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MLe5C7sj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A628C2BCB0;
	Mon, 11 May 2026 16:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778518394;
	bh=vB5aY1DyzsRtmjQ53AWD6G1IZGgAL+fjtSzWDQ14Lcg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MLe5C7sjFV9YAJI8jjadrJtcpnQIQv86CyC2Tlxjdf3/P4YTfDRmfQerfrC/AU8Bp
	 bzerf5Gd1g015avFbEfmw0If88+Onw6ltruzL4TID+hvFMpViLnmAMOXwIVU/k11OU
	 65rM7MlhUuTNNseDTT0lhtvlbtm/xfHRFvRhGNYzPCuoI1XZSLCUZhE4QJl/uNt05a
	 qzt/y1+3OtpN8f5Tla7j9m012rJi8OqsSqGMgIoljg3r2VgyS1mDe5LJTdV7o288Wi
	 BcVqdmHnrpKAvjLPqV3838BM4xFSOjKQUpDPncMnDalyaynFNEj12sCiI3LYMtKBxb
	 vpPKT2+y6xXbg==
Date: Mon, 11 May 2026 18:53:10 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, Marco Elver <elver@google.com>,
	linux-ide@vger.kernel.org
Subject: Re: [PATCH] ata: libata-core: Enable context analysis
Message-ID: <agIJdj0vUGLAWsg1@ryzen>
References: <20260505042227.909666-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260505042227.909666-1-bvanassche@acm.org>

On Tue, May 05, 2026 at 06:22:27AM +0200, Bart Van Assche wrote:
> Enable Clang's context analysis. This will cause the build to fail if
> e.g. a locking bug would be introduced in an error path. This patch
> should not affect the generated assembler code.
> 
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  drivers/ata/Makefile      |  2 ++
>  drivers/ata/libata-core.c | 28 ++++++++++++++++++++++++++++
>  drivers/ata/libata-eh.c   |  6 ++++++
>  drivers/ata/libata.h      |  6 ++++--
>  4 files changed, 40 insertions(+), 2 deletions(-)


Hello Bart,

Thank you for doing this work!
It looks nice to me.


I did notice two things:

1) It seems that you are only checking for the EH mutex.

$ git grep -A 1 "LOCKING" drivers/ata/

Does have many functions with:
	LOCKING:
	spin_lock_irqsave(host lock)

Would it be possible to add __must_hold() annotations for these functions
too, but for ap->lock instead of EH mutex ?


2) There seems to be some files that did not get any annotations, e.g.
drivers/ata/libata-scsi.c, drivers/ata/libata-sata.c,
drivers/ata/libata-acpi.c, drivers/ata/libata-pmp.c.

Would it be possible to add annotations for these files too?


Kind regards,
Niklas
