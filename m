From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Subject: Re: [PATCH 03/14] block: implement blk_rq_map_kern_prealloc()
Date: Mon, 13 Apr 2009 19:07:56 +0900
Message-ID: <20090413190400H.fujita.tomonori@lab.ntt.co.jp>
References: <49CAE425.5050009@kernel.org>
	<49CB31DB.2040608@gmail.com>
	<49CB3765.4070406@panasas.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from sh.osrg.net ([192.16.179.4]:59469 "EHLO sh.osrg.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755405AbZDMKII (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 13 Apr 2009 06:08:08 -0400
In-Reply-To: <49CB3765.4070406@panasas.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bharrosh@panasas.com
Cc: htejun@gmail.com, bzolnier@gmail.com, linux-kernel@vger.kernel.org, axboe@kernel.dk, linux-ide@vger.kernel.org

On Thu, 26 Mar 2009 10:05:57 +0200
Boaz Harrosh <bharrosh@panasas.com> wrote:

> On 03/26/2009 09:42 AM, Tejun Heo wrote:
> > Hello,
> > 
> > A few issues.
> > 
> > Tejun Heo wrote:
> >>> Perhaps you could reorder the code below a bit?
> >>>
> >>> My proposal is:
> >>> * blk_rq_map_kern_prealloc => is simplified to be
> >>>     int blk_rq_map_bio(struct request_queue *q, struct request *rq,
> >>> 		       struct bio *bio);
> > 
> > The thing is that the prealloc variant should be allowed to be called
> > from IRQ context and blk_queue_bounce() shouldn't be called.
> > Hmmm... well, the caller is supposed to know what it's doing and maybe
> > we can just add a comment that it shouldn't be called with buffers
> > which might get bounced from IRQ context.
> > 
> 
> Hmm that is a problem. I would suggest a flag or a check. My bios come
> from VFS they need bouncing.
> 
> Can you think of a solution?
> 
> We could just call blk_queue_bounce(). IRQ callers need to make sure their
> buffers don't need bouncing anyway, so there is no such bug right? If a programmer
> gets it wrong he will get a BUG check that tells him that.

If I understand the old IDE code, it's broken about the kernel buffer
bouncing.

Fixing this in the old ide needs a big surgery, I think. When I
converted the old ide code to use the block layer API to allocate a
request, I gave up the requests on the stack (used in IRQ).


