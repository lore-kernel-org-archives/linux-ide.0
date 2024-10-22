Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A96B19538D;
	Tue, 22 Oct 2024 11:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729595055; cv=none; b=GrR0wNSgoNsWaE31uCayWTuBHZydPYaNwh2Kt8onrCmZ5NWL3wqq1TnOaYTW+9LyKgH0Mi8IvwvytijW7kUMytRc5zlLZsn8eEgZcaYv3GaPi4pq5WHzvfzKMCnoFb18oDB/sL8lWN/xCG3sve5ljptn2WcYId6kJlilT4ue6CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729595055; c=relaxed/simple;
	bh=J+47TW3ovbfywZwTg4xmo7Fvj37AaXDC3sBx/4oJcto=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hXcQ5kj0QLfU5Ls2P0kjNoD5yFpECmj6U1NGQiB/ifPuNlyw0MJ1oJwb14f/V2IH5cHwvKOU+9UU1fC2ZB4W0kBrmZa0SWFGzjrKsZL3Mvd7v8pwySvdyZPlmkR/offNG+el9yuptbFt0GQYS3jcdLvzQHs4UG5pO1pB2nglH7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n1K8FiXx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n1K8FiXx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F08BDC4CEC3;
	Tue, 22 Oct 2024 11:04:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729595055;
	bh=J+47TW3ovbfywZwTg4xmo7Fvj37AaXDC3sBx/4oJcto=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n1K8FiXxsaEc7DLq7U9FIVTDgWziSt+HEeM7S4pSFWzWqI3d3cfCjsaI0f76AerbP
	 ZGEW4ot2DuZUtqZI9iU2+P3eZXJqVRb9QWylC7T4GYjLO0XYsXCfMBwFDp8hjMBktL
	 BoJ++hZbmEct4hEN3hKKGleqc+pJivb8Mhbqic21GQ5QMlFGKYpkqyaKiQGhjH4nZK
	 b6abZEn4ZX34j9TzAOQGXn1pNhRDa5BgvYuRgzpERgkhO8YGLUlYnIj7h7bj2//XSi
	 dR1n2hqLFKzqpxGyakZOZretoznA1R+icKe58AyJ1FlqVT7XUN4hyG+iRNvvBBZLrB
	 XMzLLn25hF5sw==
Date: Tue, 22 Oct 2024 13:04:10 +0200
From: Niklas Cassel <cassel@kernel.org>
To: "Lai, Yi" <yi1.lai@linux.intel.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, Hannes Reinecke <hare@suse.de>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Igor Pylypiv <ipylypiv@google.com>,
	Niklas Cassel <niklas.cassel@wdc.com>, linux-ide@vger.kernel.org,
	yi1.lai@intel.com, syzkaller-bugs@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] ata: libata: Clear DID_TIME_OUT for ATA PT commands
 with sense data
Message-ID: <ZxeGqrEpdg9Df5FS@ryzen>
References: <20240909154237.3656000-2-cassel@kernel.org>
 <ZxYz871I3Blsi30F@ly-workstation>
 <ZxZD-doogmnZGfRI@ryzen.lan>
 <ZxZxLK7eSQ_bwkLe@ryzen.lan>
 <Zxc7qLHYr60FJrD4@ly-workstation>
 <ZxdmxPAgNh9TNCU+@x1-carbon.wireless.wdc>
 <Zxd2hZWt1zm4eW2q@ly-workstation>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zxd2hZWt1zm4eW2q@ly-workstation>

On Tue, Oct 22, 2024 at 05:55:17PM +0800, Lai, Yi wrote:
> On Tue, Oct 22, 2024 at 10:48:04AM +0200, Niklas Cassel wrote:
> > On Tue, Oct 22, 2024 at 01:44:08PM +0800, Lai, Yi wrote:
> > > On Mon, Oct 21, 2024 at 05:20:12PM +0200, Niklas Cassel wrote:
> > > > On Mon, Oct 21, 2024 at 02:07:21PM +0200, Niklas Cassel wrote:
> > > > > Hello Yi Lai,
> > > > > 
> > > > > On Mon, Oct 21, 2024 at 06:58:59PM +0800, Lai, Yi wrote:
> > > > > > Hi Niklas Cassel,
> > > > > > 
> > > > > > Greetings!
> > > > > > 
> > > > > > I used Syzkaller and found that there is INFO: task hung in blk_mq_get_tag in v6.12-rc3
> > > > > > 
> > > > > > After bisection and the first bad commit is:
> > > > > > "
> > > > > > e5dd410acb34 ata: libata: Clear DID_TIME_OUT for ATA PT commands with sense data
> > > > > > "
> > > > > 
> > > > > It might be that your bisection results are accurate.
> > > > > 
> > > > > However, after looking at the stacktraces, I find it way more likely that
> > > > > bisection has landed on the wrong commit.
> > > > > 
> > > > > See this series that was just queued (for 6.13) a few days ago that solves a
> > > > > similar starvation:
> > > > > https://lore.kernel.org/linux-block/20241014092934.53630-1-songmuchun@bytedance.com/
> > > > > https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/log/?h=for-6.13/block
> > > > > 
> > > > > You could perhaps run with v6.14-rc4 (which should be able to trigger the bug)
> > > > > and then try v6.14-rc4 + that series applied, to see if you can still trigger
> > > > > the bug?
> > > >
> 
> I tried kernel linux-block
> https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git
> branch for-6.13/block commit c97f91b1807a7966077b69b24f28c2dbcde664e9.
> 
> Issue can still be reproduced.

Thanks again for your testing!

I will try to reproduce using your reproducer (repo.c),
and see if I can make any sense of this.


Kind regards,
Niklas
