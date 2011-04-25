From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 1/2]block: optimize non-queueable flush request drive
Date: Mon, 25 Apr 2011 10:58:27 +0200
Message-ID: <20110425085827.GB17734@mtj.dyndns.org>
References: <1303202686.3981.216.camel@sli10-conroe>
 <20110422233204.GB1576@mtj.dyndns.org>
 <20110425013328.GA17315@sli10-conroe.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:54589 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758125Ab1DYI6b (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 25 Apr 2011 04:58:31 -0400
Content-Disposition: inline
In-Reply-To: <20110425013328.GA17315@sli10-conroe.sh.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Shaohua Li <shaohua.li@intel.com>
Cc: lkml <linux-kernel@vger.kernel.org>, linux-ide <linux-ide@vger.kernel.org>, Jens Axboe <jaxboe@fusionio.com>, Jeff Garzik <jgarzik@pobox.com>, Christoph Hellwig <hch@infradead.org>, "Darrick J. Wong" <djwong@us.ibm.com>

Hello,

(cc'ing Darrick)

On Mon, Apr 25, 2011 at 09:33:28AM +0800, Shaohua Li wrote:
> Say in one operation of fs, we issue write r1 and r2, after they finishes,
> we issue flush f1. In another operation, we issue write r3 and r4, after
> they finishes, we issue flush f2.
> operation 1: r1 r2  f1
> operation 2:  r3 r4  f2
> At the time f1 finishes and f2 is in queue, we can make sure two things:
> 1. r3 and r4 is already finished, otherwise f2 will not be queued.
> 2. r3 and r4 should be finished before f1. We can only deliver one request
> out for non-queueable request, so either f1 is dispatched after r3 and r4
> are finished or before r3 and r4 are finished. Because of item1, f1 is
> dispatched after r3 and r4 are finished.
> From the two items, when f1 is finished, we can let f2 finished, because
> f1 should flush disk cache out for all requests from r1 to r4.

What I was saying is that request completion is decoupled from driver
fetching requests from block layer and that the order of completion
doesn't necessarily follow the order of execution.  IOW, nothing
guarantees that FLUSH completion code would run before the low level
driver fetches the next command and _completes_ it, in which case your
code would happily mark flush complete after write without actually
doing it.

And, in general, I feel uncomfortable with this type of approach, it's
extremely fragile and difficult to understand and verify, and doesn't
match at all with the rest of the code.  If you think you can exploit
certain ordering constraint, reflect it into the overall design.
Don't stuff the magic into five line out-of-place code.

> If flush is queueable, I'm not sure if we can do the
> optimization. For example, we dispatch 32 requests in the
> meantime. and the last request is flush, can the hardware guarantee
> the cache for the first 31 requests are flushed out?  On the other
> hand, my optimization works even there are write requests in between
> the back-to-back flush.

Eh, wasn't your optimization only applicable if flush is not
queueable?  IIUC, what your optimization achieves is merging
back-to-back flushes and you're achieving that in a _very_ non-obvious
round-about way.  Do it in straight-forward way even if that costs
more lines of code.

Darrick, do you see flush performance regression between rc1 and rc2?
You're testing on higher end, so maybe it's still okay for you?

Thanks.

-- 
tejun
