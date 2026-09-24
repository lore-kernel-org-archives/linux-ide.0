Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7CF731E845
	for <linux-ide@vger.kernel.org>; Thu, 24 Sep 2026 09:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790242344; cv=none; b=o/pAB6PoQA3htYPoaloj0TyBg7ff9mLGZfw9BFG+en9/eKy+cgoZfa10S7aeeVQaCbPyIqyeA//pF4EQsWpMHikdPZAFMjy4Y+kpHKw9arYZueL0gMPbqV/frK/16DvgG4bdIVqYmQFzpIvbn47gAK/rnfQ/f1kEsHXWG3GDeLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790242344; c=relaxed/simple;
	bh=QrxL67FiUpu+Gv1Vm1A0l4S3P+dgoykWvE+gt/8mqdc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HkEJ7EB53Oignh/INFm4Bb/Lp11kHdtmFnYQo2+P0RaKMYk8Sqo8s/b/mZZDkxLLBWQ5czCv54dq0DeEsZQgur3A4NHB9khHhVLFmHkgjTmAOgFdfFolEg+FUPRlS3vxGKC91f1GIVM5EDGwDbs+6OpcpUGbGFRb8xS32Bp4Um4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jqmBJ0yt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jqmBJ0yt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9485C1F00893;
	Thu, 24 Sep 2026 09:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790242342;
	bh=kx7r96a8vNtnpOyEjKsrbnT6/qSAi0eyyIaMj2pd3yg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jqmBJ0ytxHQefQvk3ztSQASP35QpWe5ZU1bKQOvldY9E+/YSVwPwWLBcYEs0Ly2e5
	 wBCq1jc45KffqjwKotv03pw4Wy3r1FufDR99GPablVzZaXuybTBio2KF/fLWfVt4Tx
	 qH0G9l2w5SDIGBE9L28WR17R4j7B7woQmQFmTrr1JNVmdnJCBYCx0y8ZgLeQxVLC2N
	 ANhbhpLKzg2ZRYOYv9dV1JrbR2X+xXxgvMIKYvhn4STnve284BR3DnVBCyBgpKdRXB
	 tq6tGrnJvuBwLTRY3nCoeqIBNCCjmjzb4TH3EDMxQ4wL2UDKln3UPoMztqt7n7bcXf
	 dHcYXids04J2A==
Date: Thu, 24 Sep 2026 11:32:19 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Matthias Goergens <matthias.goergens@gmail.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: name the libata/linux for-next branch
Message-ID: <arTuIxpEsaYIQXU4@ryzen>
References: <20260924033545.3624716-1-matthias.goergens@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260924033545.3624716-1-matthias.goergens@gmail.com>

Hello Matthias,

On Thu, Sep 24, 2026 at 11:35:45AM +0800, Matthias Goergens wrote:
> The T: entry for LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)
> names libata/linux without a branch.  The repository's HEAD (master,
> 8d3ae59288f1) is a commit from 2026-08-16 that mainline already
> contains.  linux-next pulls for-next from this repository (Next/Trees,
> next-20260923), and on 2026-09-24 that branch carried work not yet in
> mainline.  Name the branch so the entry identifies where development
> happens.

I think this could have been written simpler, without references to dates.
Something like:
"
The T: entry for LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)
names libata/linux without a branch. The repository's HEAD pointer
points to branch master, which has no active development.
Active development is on the for-next branch. Name the branch so the
entry identifies where development happens.
"

That said, if you are only sending a patch for libata, I don't see why we
should pick this up.

If I look at some entries for other trees (block, scsi, nvme):

T:      git git://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git
T:      git git://git.kernel.org/pub/scm/linux/kernel/git/mkp/scsi.git
T:      git git://git.infradead.org/nvme.git


$ git symbolic-ref refs/remotes/block/HEAD
refs/remotes/block/master

$ git symbolic-ref refs/remotes/scsi/HEAD
refs/remotes/scsi/master

$ git symbolic-ref refs/remotes/nvme/HEAD
refs/remotes/nvme/master

They all point to branch master, which is a copy of Linus's master branch
(often some really copy too).

My point is that, only changing libata seems to make things more inconsistent.

Send a series to Jens fixing all of them, and I would give my Acked-by,
so that he can pick up the patch.


But in reality, if you want to clean things up, why limit it to these three?

Write a script that clones all trees, compares HEAD against what is
is Linux Next (Next/Trees file). If it diverges, add the branch name to
the tree entry in MAINTAINERS.


> 
> Documentation/process/submitting-patches.rst sends contributors to the
> T: entry to find the tree to prepare patches against, so a branch-less
> entry whose HEAD is already in mainline points them at the wrong tree.

s/points them to the wrong tree/points them to the wrong branch/


Kind regards,
Niklas
