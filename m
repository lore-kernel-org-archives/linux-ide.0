From: Shaohua Li <shaohua.li@intel.com>
Subject: Re: [PATCH block:for-3.3/core] cfq: merged request shouldn't jump
 to a different cfqq
Date: Fri, 06 Jan 2012 11:34:38 +0800
Message-ID: <1325820878.22361.518.camel@sli10-conroe>
References: <20120103200906.GG31746@google.com> <4F03631C.8080501@kernel.dk>
	 <20120103221301.GH31746@google.com> <20120103223505.GI31746@google.com>
	 <20120105012445.GP31746@google.com>
	 <alpine.LSU.2.00.1201051026090.2009@eggly.anvils>
	 <20120105183842.GF18486@google.com> <20120106021707.GA6276@google.com>
	 <20120106023638.GC6276@google.com>
	 <1325819655.22361.513.camel@sli10-conroe>
	 <20120106030406.GD6276@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:57841 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758432Ab2AFDT5 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 5 Jan 2012 22:19:57 -0500
In-Reply-To: <20120106030406.GD6276@google.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Hugh Dickins <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, linux-scsi@vger.kernel.org, linux-ide@vger.kernel.org, x86@kernel.org

On Thu, 2012-01-05 at 19:04 -0800, Tejun Heo wrote:
> Hello,
> 
> On Fri, Jan 06, 2012 at 11:14:15AM +0800, Shaohua Li wrote:
> > > So, yeah, the right fix would be using elv_former/latter_request()
> > > instead.  Maybe we should strip out rqhash altogether and change
> > > elevator handle everything?  I don't know.  I'll prepare a different
> > > fix patch soon.
> >
> > So not allow merge from two cfq queues strictly? This will impact
> > performance. I don't know how important the strict isolation is. we even
> > allow two cfq queues merge to improve performance.
> 
> That's how cfq has behaved before this recent plug merge breakage and
> IIRC why the cooperating queue thing is there.  If you want to change
> the behavior, that should be an explicit separate patch.
My point is both cooperating merge and the plug merge of different cfq
are merge, no reason we allow one but disallow the other. plug merge
isn't a breakage to me.

Thanks,
Shaohua

