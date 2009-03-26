From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 03/14] block: implement blk_rq_map_kern_prealloc()
Date: Thu, 26 Mar 2009 19:19:25 +0900
Message-ID: <49CB56AD.3080101@gmail.com>
References: <1237910776-10983-1-git-send-email-tj@kernel.org> <1237910776-10983-4-git-send-email-tj@kernel.org> <49CA4B4B.50408@panasas.com> <49CAE425.5050009@kernel.org> <49CB31DB.2040608@gmail.com> <49CB3765.4070406@panasas.com> <49CB387A.3000006@panasas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.186]:18151 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751075AbZCZKTd (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 26 Mar 2009 06:19:33 -0400
In-Reply-To: <49CB387A.3000006@panasas.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Boaz Harrosh <bharrosh@panasas.com>
Cc: bzolnier@gmail.com, linux-kernel@vger.kernel.org, axboe@kernel.dk, linux-ide@vger.kernel.org

Boaz Harrosh wrote:
> On 03/26/2009 10:05 AM, Boaz Harrosh wrote:
>> On 03/26/2009 09:42 AM, Tejun Heo wrote:
>>> The thing is that the prealloc variant should be allowed to be called
>>> from IRQ context and blk_queue_bounce() shouldn't be called.
>>> Hmmm... well, the caller is supposed to know what it's doing and maybe
>>> we can just add a comment that it shouldn't be called with buffers
>>> which might get bounced from IRQ context.
>>>
>> Hmm that is a problem. I would suggest a flag or a check. My bios come
>> from VFS they need bouncing.
>>
>> Can you think of a solution?
>>
>> We could just call blk_queue_bounce(). IRQ callers need to make sure their
>> buffers don't need bouncing anyway, so there is no such bug right? If a programmer
>> gets it wrong he will get a BUG check that tells him that.
>>
> 
> I just realized that in your original call you had the "force" flag,
> we can keep that flag for the blk_rq_set_bio(), or what ever we
> should name it.

Eh...  Currently, fs requests are built from bio whereas PC/kernel
requests are usually mapped into the requset the driver already
allocated, so there are two different directions of initiaializing a
request.

For the latter, the APIs are blk_rq_map_{user[_iov]|kern}().  To add
to the fun, we have blk_rq_map_sg() which does a completely different
thing of mapping an rq's bios to sg and is usually called from low
level do_request() when starting to process a request.

You're suggesting to add blk_rq_map_bio() which doesn't really map
anything but rather allocates and initializes an rq from bio and
basically boils down to blk_rq_bio_prep() and blk_queue_bounce().

I think it's about time to cool it a bit and try to see what's going
on.  We don't really want blk_rq_map_*() to do three completely
different things, right?  Usage of blk_rq_map_{user[_iov]|kern}()
isn't too wide spread, so cleaning up the API shouldn't be difficult.

So, let's think about the whole API.

There is fundamental difference between fs and pc requests.  For fs
requests, rq (struct request) doesn't really matter.  bio is the final
goal of fs requests and rq is just the carrier of bios into the block
layer and drivers.  For pc requests, this isn't true.  Here, bios are
used as data carrier and the issuer cares much more about the rq
itself which will be configured to carry the command the issuer wants
to execute.  This is also true for completion too.  For fs requests,
rq error status doesn't matter.  For pc requests, the other way
around.  The difference explains why we have two different
initialization directions, so to me, the current API seems logical
although we really should be using different names.

Can you please explain what your need is?  Why do you want
blk_make_request()?

Thanks.

-- 
tejun
