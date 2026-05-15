Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47DF3FB046
	for <linux-ide@vger.kernel.org>; Fri, 15 May 2026 12:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778847071; cv=none; b=gR+h//I6T7e/LCTZjnfr0UfQ07Ix8cYWYMkPvdXCkWnwjDWQyGVB2JmBYvgzrDLAovkOFVCnGa2+calEuunE74wshTVEdVm19vop5Y4K43LmpTG7Y0WFVyP0kDTYo6IEV4dcqbknZVSqDOkgrJAgbkGSsisRK/9y79rf0UYAso4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778847071; c=relaxed/simple;
	bh=04GA+heDC/2sB3emy6Fh1ETRkk9rGilPGKzquD3Wfd0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MHnOmT44C8oRk8/t0Jez/j+xFyuhM1zgEZnoNitIsWGiUxIUGtiSzWeWO80AcMjkqvyh7u/vqzJFDkQOCw+cw333uy+M4iWoPoAo4bpEM7Hmu7KbDkKZxdk30DCembpNKoqp++Mjc88s3sxZD195RLvtPTjDn2CQXf/lmIHDe40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jCoRE46Q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jCoRE46Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52CAEC2BCB0;
	Fri, 15 May 2026 12:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778847071;
	bh=04GA+heDC/2sB3emy6Fh1ETRkk9rGilPGKzquD3Wfd0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jCoRE46Qayi2iM2WlgecpeTwklIb21hH6pQ1nXqIt6XRSDl08TJES9aB18H40e0UZ
	 7oEb8MpR1v233HZILhWSjqiLHDa2VYuBLR4VizzVW7LVsQ90T+S0TQRjxNdL+rY2Xf
	 C1m8JpL+vebfjP/bYhw4X4xe2C8BpJcoMn45wwL5hXZqRsRH9aj4QeIC2zLrJ8UrLN
	 P5PGr2/1Z/G5lOtzDZeblhjAxFhKrcYF5mUORKi9LiFPHIgMeQR7pwfR0FTpirYkP+
	 TwlsqJ4DyQN0u968ii3CFrMByNU63aFkYfaB6s9OUmhDMpOdKHb0GbPmPvy6NhH/GB
	 A/byzWmB5oA5A==
Date: Fri, 15 May 2026 14:11:07 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, Marco Elver <elver@google.com>,
	linux-ide@vger.kernel.org
Subject: Re: [PATCH] ata: libata-core: Enable context analysis
Message-ID: <agcNW8pFnALXHW3Q@ryzen>
References: <20260505042227.909666-1-bvanassche@acm.org>
 <agIJdj0vUGLAWsg1@ryzen>
 <8a831bdf-6d32-45c4-bddc-9b14d6367407@acm.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a831bdf-6d32-45c4-bddc-9b14d6367407@acm.org>

Hello Bart,

On Tue, May 12, 2026 at 01:00:58PM -0700, Bart Van Assche wrote:
> On 5/11/26 9:53 AM, Niklas Cassel wrote:
> > 1) It seems that you are only checking for the EH mutex.
> > 
> > $ git grep -A 1 "LOCKING" drivers/ata/
> > 
> > Does have many functions with:
> > 	LOCKING:
> > 	spin_lock_irqsave(host lock)
> > 
> > Would it be possible to add __must_hold() annotations for these functions
> > too, but for ap->lock instead of EH mutex ?
> 
> This is something I can't do myself. This is something that should be done
> by an ATA expert. I'm not an ATA expert.

In my mind you are as much of an ATA expert as me and Damien :)


> 
> > 2) There seems to be some files that did not get any annotations, e.g.
> > drivers/ata/libata-scsi.c, drivers/ata/libata-sata.c,
> > drivers/ata/libata-acpi.c, drivers/ata/libata-pmp.c.
> > 
> > Would it be possible to add annotations for these files too?
> 
> Just like for (1), since there are inconsistencies between the
> "LOCKING:" documentation and the implementation, this is best done by
> an ATA expert.

Are there really a lot of inconsistencies though?

If you simply add annotations to e.g. drivers/ata/libata-scsi.c and
drivers/ata/libata-sata.c, which matches the kdoc, how many functions are
there that will not compile?

Considering how old and mostly unchanged most of these functions are, I
would expect the vast majority to actually be consistent with the kdoc.


> 
> The goal of the annotations in this patch is to make sure that the build
> doesn't break with CONTEXT_ANALYSIS := y. Any additional annotations can
> be implemented as follow-up patches.

Sure, doing so in follow-up patches would also be fine, although,
personally I would prefer to include at least a few ap->lock annotations
in this patch, so that people can see that it is possible to have
annotations also for ap->lock and not only EH mutex.


I could see in another thread that function pointer annotations require
clang 23:
https://lore.kernel.org/all/acqELlVC6vEeEF-W@elver.google.com/

Do you want us to pick up the patch in $subject now, or wait for the above
to land first?


Oh, there were some Sashiko review comments on the patch in $subject:
https://sashiko.dev/#/patchset/20260505042227.909666-1-bvanassche%40acm.org

Could you please check if they are valid review comments?


Kind regards,
Niklas
