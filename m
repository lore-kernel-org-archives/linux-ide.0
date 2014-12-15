From: Shaohua Li <shli@fb.com>
Subject: Re: [PATCH 1/2] block: support different tag allocation policy
Date: Mon, 15 Dec 2014 08:24:43 -0800
Message-ID: <20141215162443.GA3147371@devbig257.prn2.facebook.com>
References: <e0ea802ef0d4170ad409e5dbf814c28581c091ac.1418613253.git.shli@fb.com>
 <20141215080813.GA3982@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:19103 "EHLO
	mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751147AbaLOQZX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 15 Dec 2014 11:25:23 -0500
Content-Disposition: inline
In-Reply-To: <20141215080813.GA3982@infradead.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-ide@vger.kernel.org, Kernel-team@fb.com, Jens Axboe <axboe@fb.com>, Tejun Heo <tj@kernel.org>

On Mon, Dec 15, 2014 at 12:08:13AM -0800, Christoph Hellwig wrote:
> On Sun, Dec 14, 2014 at 07:21:49PM -0800, Shaohua Li wrote:
> > The libata tag allocation is using a round-robin policy. Next patch will
> > make libata use block generic tag allocation, so let's add a policy to
> > tag allocation.
> > 
> > Currently two policies: FIFO (default) and round-robin.
> 
> What's the benefit of round robin allocation?  Why do you only need
> it for the old simple allocator, and no policy control for the more
> complex blkpmq allocator?

See 8a4aeec8d2d6a3edeffbdfa.

The policy for blkmq will be added later.

Thanks,
Shaohua
