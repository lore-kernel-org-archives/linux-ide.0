From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: [PATCH v2.6.38-rc5 2/2] block: blk-flush shouldn't call directly into q->request_fn() __blk_run_queue()
Date: Mon, 07 Mar 2011 14:50:28 -0500
Message-ID: <x49ipvusoaj.fsf@segfault.boston.devel.redhat.com>
References: <20110217111511.GQ19830@htj.dyndns.org>
	<20110217111619.GR19830@htj.dyndns.org>
	<AANLkTi=rPKN25yZTziv1dz=Ke0db8ZOwUgKFNzWn9+x7@mail.gmail.com>
	<20110218094903.GF21209@htj.dyndns.org> <4D6E4A46.1040709@kernel.dk>
	<20110304182507.GY20499@htj.dyndns.org>
	<x49r5aisp23.fsf@segfault.boston.devel.redhat.com>
	<4D7533B1.3070308@kernel.dk>
	<x49mxl6sot4.fsf@segfault.boston.devel.redhat.com>
	<4D7534D6.7020000@kernel.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:7512 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755274Ab1CGTui (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 7 Mar 2011 14:50:38 -0500
In-Reply-To: <4D7534D6.7020000@kernel.dk> (Jens Axboe's message of "Mon, 07
	Mar 2011 20:41:10 +0100")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <axboe@kernel.dk>
Cc: Tejun Heo <tj@kernel.org>, Mike Snitzer <snitzer@gmail.com>, Jan Beulich <JBeulich@novell.com>, "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Jens Axboe <axboe@kernel.dk> writes:

> On 2011-03-07 20:39, Jeff Moyer wrote:
>>>> I think the real issue may just be that the ide driver is blocking in
>>>> its request function.  What have I missed?
>>>
>>> So the only case where the request_fn is called and you cannot block, is
>>> if you call it from your completion function. Any other invocation
>>> should be from process context. As long as you remember to drop the
>>> queue lock and re-enable interrupts, it should work. It's not great
>>> style and I would not recommend it for a performance environment, but it
>>> should work.
>> 
>> So are you agreeing with me or disagreeing?  ;-)  It sounds to me like
>> you're saying that the ide driver should be able to cope with being
>> called from softirq context.
>
> I'm just stating how it should work :-)
>
> But yes, it sounds like IDE is violating this rule and that's why it was
> broken. Even with that, having explicit control of the queue running
> does make sense.

Well, I wonder if it makes sense *in this case*.  With all of the work
going into optimizing the flushing, is deferring work to kblockd really
the best idea?  Tejun, do you know if it has any measurable impact?

Cheers,
Jeff
