From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 03/14] block: implement blk_rq_map_kern_prealloc()
Date: Thu, 26 Mar 2009 16:42:19 +0900
Message-ID: <49CB31DB.2040608@gmail.com>
References: <1237910776-10983-1-git-send-email-tj@kernel.org> <1237910776-10983-4-git-send-email-tj@kernel.org> <49CA4B4B.50408@panasas.com> <49CAE425.5050009@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.185]:54344 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751397AbZCZHlr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 26 Mar 2009 03:41:47 -0400
In-Reply-To: <49CAE425.5050009@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Boaz Harrosh <bharrosh@panasas.com>
Cc: bzolnier@gmail.com, linux-kernel@vger.kernel.org, axboe@kernel.dk, linux-ide@vger.kernel.org

Hello,

A few issues.

Tejun Heo wrote:
>> Perhaps you could reorder the code below a bit?
>>
>> My proposal is:
>> * blk_rq_map_kern_prealloc => is simplified to be
>>     int blk_rq_map_bio(struct request_queue *q, struct request *rq,
>> 		       struct bio *bio);

The thing is that the prealloc variant should be allowed to be called
from IRQ context and blk_queue_bounce() shouldn't be called.
Hmmm... well, the caller is supposed to know what it's doing and maybe
we can just add a comment that it shouldn't be called with buffers
which might get bounced from IRQ context.

>> * The extra checks currently inside blk_rq_map_kern_prealloc are moved
>>   to bio_map_kern_prealloc()
>>
>> * Users call bio_map_kern_prealloc() directly and then use blk_rq_map_bio()
>>   in a two stage process.

This breaks consistency with blk_rq_map_*() family of functions.  Do
you have a plan to make them all consistent?  I think we really need
to maintain API consistency.

Thanks.

-- 
tejun
