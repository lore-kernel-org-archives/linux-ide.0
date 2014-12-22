From: Jens Axboe <axboe@fb.com>
Subject: Re: [PATCH v2 2/3] blk-mq: add tag allocation policy
Date: Mon, 22 Dec 2014 16:25:19 -0700
Message-ID: <5498A85F.7090508@fb.com>
References: <e8fb0a8f15f291f6dae88d51295432a2fa7ad71b.1418928090.git.shli@fb.com> <be6eb099c483f26e63dc43080055e7644bc2bcad.1418928090.git.shli@fb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:22943 "EHLO
	mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754020AbaLVXZr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 22 Dec 2014 18:25:47 -0500
In-Reply-To: <be6eb099c483f26e63dc43080055e7644bc2bcad.1418928090.git.shli@fb.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Shaohua Li <shli@fb.com>, linux-ide@vger.kernel.org
Cc: Kernel-team@fb.com, Tejun Heo <tj@kernel.org>, Christoph Hellwig <hch@infradead.org>

On 12/18/2014 11:46 AM, Shaohua Li wrote:
> This is the blk-mq part to support tag allocation policy. The default
> allocation policy isn't changed (though it's not a strict FIFO). The new
> policy is round-robin for libata. But it's a try-best implementation. If
> multiple tasks are competing, the tags returned will be mixed (which is
> unavoidable even with !mq, as requests from different tasks can be
> mixed in queue)

Can we get rid of the atomic_read() on non-rr? It's never set outside of 
initialization there.

-- 
Jens Axboe

