Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C983A27735;
	Tue, 22 Oct 2024 08:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729586890; cv=none; b=la5GK3xI4rloqg/GJGVFt064yBOUefavRg2nDWkvYYl3eAIJuoaMF8f+BGwBtUB9mgxoYJHjfSomuRq5QJ+6V/VzwO3ib7QN62N6auNSdYikv3W/t0VHMC4/66oGOFIXTEEg7kfehBxEb7f8ctC0ZuRjgoZVYZFgLgDwx8q4yRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729586890; c=relaxed/simple;
	bh=ZaJBE25KPFBQigTRnyWZIQp1hrrAkSpU0jDH7LJwlxM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q++kXNKiGN4mAUEsOEdl0dFfOdvd4LFxnsUMMkzTiGpg+49fDiLMTBZ+p49AdoZIRq1oKP0ZFNvCG06g1pcub53TiJbkaKHnfD7Yi/HEkubpmZFj+3LOzg0WCTMmdy4Z742HZba6tJfllr8zliaOhwjM90YJYIIZp5KG3sphErA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cL6LLFMT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cL6LLFMT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9C25C4CEC3;
	Tue, 22 Oct 2024 08:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729586890;
	bh=ZaJBE25KPFBQigTRnyWZIQp1hrrAkSpU0jDH7LJwlxM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cL6LLFMTmtp80ohwK2agRJCArx6JnqttR6WG8rEWGVLgpWq9LUtPMCE3nVpUOk0H9
	 s3MBr2vrP5VbkEsrWfbtkh3bWv1DY9YFJtJrAs9KQzaB7/V1LXuk00bHdxMIsAweJk
	 f1q9iqZllzJeBPa2Q3ttQCG2xdCVz9hZJEkEXMIvM4ac1gLanWJqUlflEe7U640Von
	 ei2NxZ7GxtsYGEdLP59WbBPiPHRH/qaEtRxa+lFaFnClHkx9j3yl1+zpqs8jWsw42C
	 +IE7pmnKlaWO+btK3ngB9DEoM0ApvHo5CfT96Ezxn4jHKtLXXtcAA70LQaphRVUAkr
	 BdGjHqdqBOdYw==
Date: Tue, 22 Oct 2024 10:48:04 +0200
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
Message-ID: <ZxdmxPAgNh9TNCU+@x1-carbon.wireless.wdc>
References: <20240909154237.3656000-2-cassel@kernel.org>
 <ZxYz871I3Blsi30F@ly-workstation>
 <ZxZD-doogmnZGfRI@ryzen.lan>
 <ZxZxLK7eSQ_bwkLe@ryzen.lan>
 <Zxc7qLHYr60FJrD4@ly-workstation>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zxc7qLHYr60FJrD4@ly-workstation>

On Tue, Oct 22, 2024 at 01:44:08PM +0800, Lai, Yi wrote:
> On Mon, Oct 21, 2024 at 05:20:12PM +0200, Niklas Cassel wrote:
> > On Mon, Oct 21, 2024 at 02:07:21PM +0200, Niklas Cassel wrote:
> > > Hello Yi Lai,
> > > 
> > > On Mon, Oct 21, 2024 at 06:58:59PM +0800, Lai, Yi wrote:
> > > > Hi Niklas Cassel,
> > > > 
> > > > Greetings!
> > > > 
> > > > I used Syzkaller and found that there is INFO: task hung in blk_mq_get_tag in v6.12-rc3
> > > > 
> > > > After bisection and the first bad commit is:
> > > > "
> > > > e5dd410acb34 ata: libata: Clear DID_TIME_OUT for ATA PT commands with sense data
> > > > "
> > > 
> > > It might be that your bisection results are accurate.
> > > 
> > > However, after looking at the stacktraces, I find it way more likely that
> > > bisection has landed on the wrong commit.
> > > 
> > > See this series that was just queued (for 6.13) a few days ago that solves a
> > > similar starvation:
> > > https://lore.kernel.org/linux-block/20241014092934.53630-1-songmuchun@bytedance.com/
> > > https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/log/?h=for-6.13/block
> > > 
> > > You could perhaps run with v6.14-rc4 (which should be able to trigger the bug)
> > > and then try v6.14-rc4 + that series applied, to see if you can still trigger
> > > the bug?
> > 
> > Another patch that might be relevant:
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e972b08b91ef48488bae9789f03cfedb148667fb
> > 
> > Which fixes a use after delete in rq_qos_wake_function().
> > (We can see that the stack trace has rq_qos_wake_function() before
> > getting stuck forever in rq_qos_wait())
> > 
> > Who knows what could go wrong when accessing a deleted entry, in the
> > report there was a crash, but I could image other surprises :)
> > The fix was first included in v6.12-rc4.
> > 
> >
> Hi Niklas,
> 
> Thanks for the info. I have tried using v6.12-rc4 kernel to reproduce
> the issue. Using the same repro binary, the issue still exists.

Thanks a lot for your help with testing!

The first series that I pointed to, which looks most likely to be related:
https://lore.kernel.org/linux-block/20241014092934.53630-1-songmuchun@bytedance.com/

Is only merged in:
https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/log/?h=for-6.13/block

It is not included in v6.12-rc4.

Would it please be possible for you to test with Jens's for-6.13/block branch?


Kind regards,
Niklas
