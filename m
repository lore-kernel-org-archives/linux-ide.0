Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B19547A898
	for <linux-ide@vger.kernel.org>; Thu, 24 Sep 2026 13:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790256820; cv=none; b=RyRq9EZjtrO0EeIGLP+gay8sXdMk0oOV45UQ7QgaqW3PnBBwaFS94+eI9hCIvKn3tJEPMlBPfhdTPNpVSFDtSkh2ggL2tZ3zEWP9d3iS7axE2YefQzNe07FWrGOah4Bjpzuns6XevWLzzZTs+0OGQ9cB6gM3lsC/pFPZ6PJ8h6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790256820; c=relaxed/simple;
	bh=Ee7CbnjCu39tk3yOcsHMIbvq9DDrri7SMYdljXiWAMI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=myLpmCVHn+ey2zLliOFvrEnVLpr/b8KdTiNoAX61UMiXEZGxHT2kCfcJ6ZOybVccfUB3WUzGovfYo1jm7hFflagEbrgxfqFPpadv993t196N7vXizdq/f4M88rJKg5j30S0JCkpNuV2ZT0ooloWTvtum8hyZORK+bg4yGvPMFms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V2QNeJ7N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V2QNeJ7N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D948B1F000FF;
	Thu, 24 Sep 2026 13:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790256815;
	bh=gyTMGh36BfgBazd/zeM6HMZ6QPU6UnoWxOzTEItVST0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=V2QNeJ7NRpwHPWk8DWTZH/wxVxWBjqGCyyysMWE+7Gg98l1/KGpybGw9TDW2xou91
	 cjy7WWxx/Mw8Q0NBYduJENHR04XvdFAjRuenA1dW/1em7y/ICQhu2dmHnwvcGcqA2F
	 X5eMZqPhjqS573ekRyqtmxyGxFSWHDI1QizOhCND0n9PGYxuEx+bWMIFfhgi/wfSN+
	 9ktHIe5IK5Fm6qlSTcYPdvTktD9Nr3oDIW/ESCoyv5CdoTVvRTSwCQsJ429JrtCnSw
	 /u8mRPEZLRJKrwHHJOkFbrVBHYEqT2VVC753nWxLvEoiJC8RY1m73n6ZFDaPvuKdpl
	 KDFcBZUYoIxBg==
Date: Thu, 24 Sep 2026 15:33:32 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Matthias Goergens <matthias.goergens@gmail.com>
Cc: dlemoal@kernel.org, linux-ide@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: name the libata/linux for-next branch
Message-ID: <arUmrIiHwevxjjqK@ryzen>
References: <20260924033545.3624716-1-matthias.goergens@gmail.com>
 <arTuIxpEsaYIQXU4@ryzen>
 <20260924101844.2403008-1-matthias.goergens@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260924101844.2403008-1-matthias.goergens@gmail.com>

Hello Matthias,

On Thu, Sep 24, 2026 at 06:18:44PM +0800, Matthias Goergens wrote:
> On Thu, Sep 24, 2026 at 11:32:19AM +0200, Niklas Cassel wrote:
> > I think this could have been written simpler, without references to dates.
> 
> Agreed, your wording is better.  I'll use it, together with the
> s/tree/branch/ fix, in a v2.
> 
> > But in reality, if you want to clean things up, why limit it to these three?
> >
> > Write a script that clones all trees, compares HEAD against what is
> > is Linux Next (Next/Trees file). If it diverges, add the branch name to
> > the tree entry in MAINTAINERS.
> 
> That script is how I found these: about 160 T: lines diverge.  libata
> isn't a one-off; it's in the first small batch of the plan I described
> in the ext4 thread [1].
> 
> I'm sending them in small batches rather than all at once because I'd
> invariably get something wrong, or miss a subsystem's conventions, and
> I'd rather learn that from a handful of maintainers than from 160.
> Exhibit A is the KVM/arm64 reply [2]: that for-next is purely an
> integration branch and patches there must be based on a tag from
> Linus's tree, so naming it would have sent people to the wrong place.
> Comparing HEAD with Next/Trees can't tell that apart from a branch like
> yours.  So I now also look at how each branch is built, and I'm holding
> back the ones that look like integration branches, block included,
> until I know how to word them.
> 
> As for the other two: SCSI went out in the same first batch [3], and
> nvme.git isn't in Next/Trees at all, so the script never flagged it.
> Thanks for the offered Acked-by; I'll Cc you when block comes up.

Okay, nice to see that you are actually putting in the effort to fix all
entries and not just one.

I guess I would have know if you sent it as a series, but that would
probably have been worse than sending a single patch per subsystem,
as I am sure many people will have comments.

Perhaps mention that you are doing a cleanup of all entries after the:

---

line after the commit message, with the links that you shared just now.
That way maintainers will know that you are actually doing a longer
work and not just a one-off.


Kind regards,
Niklas
