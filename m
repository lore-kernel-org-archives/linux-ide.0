Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0643198E7F;
	Tue, 22 Oct 2024 09:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729590976; cv=none; b=kFEbyVD/TeME8ZpHpwVCkgzA9U00xsZnWguOxUxrAfnM/M1z8BxHPekIvq4zVAQt9e/lEw2PhPStLtPURauXy+nmqIVfEUYsmOwqwT6wMbAMxMcaQWGS03x+8XTJmubVNCd6u8JYUdG4zakeNBpHsWmFqpPQqDYMPuRJGVDmk/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729590976; c=relaxed/simple;
	bh=89GaZV9clZoGjAP19EbcBNmPKkvbswUHxHd7i+4mvzU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QDScZEaHGH4Zc2yaYUcyM4EgkvFbnG4A2dsJ8LZAJdA7PcGzj9p0FNpZvIDVDQnmGFobfmsgnZKcjMcFWp7Nsn7w50w2mHA7D8GpWOvnQfFtZCy+iKIIVR7v7pTsHN7CqUx4WcLH7csUlgeT6kZYDs1aj80oxyXYNs9xwmNMVdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gcK3w6DK; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gcK3w6DK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729590975; x=1761126975;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=89GaZV9clZoGjAP19EbcBNmPKkvbswUHxHd7i+4mvzU=;
  b=gcK3w6DKVh2uX1tdBdQUNPrpHpI6smKHt7F875ngUEc05YnV7xXFDo0f
   puLFQYmXpBiLRGPInz2RsKggTmsOCWAouwYnedFz8CarbKX57BuvA2lLf
   tPlg0TEabyQFT75ofgulXW5uFX0P1vfNRcek1197OpbFuzInlBJRmhHt0
   33TMlbJyDuArMBPMWoRKzbnjrgqvvvDilhMXI2O/oVlXJAt+OqnOvqHvY
   cPozCjg510El1AQCE5iqTwduN46fR2PDlthGVj9hFLCS2qibUxYkgDugc
   8yT6fNPe2PDXY/Ahx5UxH2NN08p1FRLFJGK0j3uOgbgGylCU8B+kxm3a1
   w==;
X-CSE-ConnectionGUID: 24GNP3tiT2KxjF4w1N7ecQ==
X-CSE-MsgGUID: 66wdN83jRGqc7j92RQ/z1A==
X-IronPort-AV: E=McAfee;i="6700,10204,11232"; a="28547263"
X-IronPort-AV: E=Sophos;i="6.11,222,1725346800"; 
   d="scan'208";a="28547263"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 02:56:14 -0700
X-CSE-ConnectionGUID: Wj6era+pQbqPvDugTD3kPQ==
X-CSE-MsgGUID: sfQcr42dRsi/gQ93oB22Iw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,222,1725346800"; 
   d="scan'208";a="80627770"
Received: from ly-workstation.sh.intel.com (HELO ly-workstation) ([10.239.161.23])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 02:56:11 -0700
Date: Tue, 22 Oct 2024 17:55:17 +0800
From: "Lai, Yi" <yi1.lai@linux.intel.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, Hannes Reinecke <hare@suse.de>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Igor Pylypiv <ipylypiv@google.com>,
	Niklas Cassel <niklas.cassel@wdc.com>, linux-ide@vger.kernel.org,
	yi1.lai@intel.com, syzkaller-bugs@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] ata: libata: Clear DID_TIME_OUT for ATA PT commands
 with sense data
Message-ID: <Zxd2hZWt1zm4eW2q@ly-workstation>
References: <20240909154237.3656000-2-cassel@kernel.org>
 <ZxYz871I3Blsi30F@ly-workstation>
 <ZxZD-doogmnZGfRI@ryzen.lan>
 <ZxZxLK7eSQ_bwkLe@ryzen.lan>
 <Zxc7qLHYr60FJrD4@ly-workstation>
 <ZxdmxPAgNh9TNCU+@x1-carbon.wireless.wdc>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxdmxPAgNh9TNCU+@x1-carbon.wireless.wdc>

On Tue, Oct 22, 2024 at 10:48:04AM +0200, Niklas Cassel wrote:
> On Tue, Oct 22, 2024 at 01:44:08PM +0800, Lai, Yi wrote:
> > On Mon, Oct 21, 2024 at 05:20:12PM +0200, Niklas Cassel wrote:
> > > On Mon, Oct 21, 2024 at 02:07:21PM +0200, Niklas Cassel wrote:
> > > > Hello Yi Lai,
> > > > 
> > > > On Mon, Oct 21, 2024 at 06:58:59PM +0800, Lai, Yi wrote:
> > > > > Hi Niklas Cassel,
> > > > > 
> > > > > Greetings!
> > > > > 
> > > > > I used Syzkaller and found that there is INFO: task hung in blk_mq_get_tag in v6.12-rc3
> > > > > 
> > > > > After bisection and the first bad commit is:
> > > > > "
> > > > > e5dd410acb34 ata: libata: Clear DID_TIME_OUT for ATA PT commands with sense data
> > > > > "
> > > > 
> > > > It might be that your bisection results are accurate.
> > > > 
> > > > However, after looking at the stacktraces, I find it way more likely that
> > > > bisection has landed on the wrong commit.
> > > > 
> > > > See this series that was just queued (for 6.13) a few days ago that solves a
> > > > similar starvation:
> > > > https://lore.kernel.org/linux-block/20241014092934.53630-1-songmuchun@bytedance.com/
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/log/?h=for-6.13/block
> > > > 
> > > > You could perhaps run with v6.14-rc4 (which should be able to trigger the bug)
> > > > and then try v6.14-rc4 + that series applied, to see if you can still trigger
> > > > the bug?
> > >

I tried kernel linux-block
https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git
branch for-6.13/block commit c97f91b1807a7966077b69b24f28c2dbcde664e9.

Issue can still be reproduced.

> > > Another patch that might be relevant:
> > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e972b08b91ef48488bae9789f03cfedb148667fb
> > > 
> > > Which fixes a use after delete in rq_qos_wake_function().
> > > (We can see that the stack trace has rq_qos_wake_function() before
> > > getting stuck forever in rq_qos_wait())
> > > 
> > > Who knows what could go wrong when accessing a deleted entry, in the
> > > report there was a crash, but I could image other surprises :)
> > > The fix was first included in v6.12-rc4.
> > > 
> > >
> > Hi Niklas,
> > 
> > Thanks for the info. I have tried using v6.12-rc4 kernel to reproduce
> > the issue. Using the same repro binary, the issue still exists.
> 
> Thanks a lot for your help with testing!
> 
> The first series that I pointed to, which looks most likely to be related:
> https://lore.kernel.org/linux-block/20241014092934.53630-1-songmuchun@bytedance.com/
> 
> Is only merged in:
> https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/log/?h=for-6.13/block
> 
> It is not included in v6.12-rc4.
> 
> Would it please be possible for you to test with Jens's for-6.13/block branch?
> 
> 
> Kind regards,
> Niklas
