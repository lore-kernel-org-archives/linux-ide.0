From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 1/2] block: support different tag allocation policy
Date: Mon, 15 Dec 2014 00:08:13 -0800
Message-ID: <20141215080813.GA3982@infradead.org>
References: <e0ea802ef0d4170ad409e5dbf814c28581c091ac.1418613253.git.shli@fb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:37682 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750865AbaLOIIQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 15 Dec 2014 03:08:16 -0500
Content-Disposition: inline
In-Reply-To: <e0ea802ef0d4170ad409e5dbf814c28581c091ac.1418613253.git.shli@fb.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Shaohua Li <shli@fb.com>
Cc: linux-ide@vger.kernel.org, Kernel-team@fb.com, Jens Axboe <axboe@fb.com>, Tejun Heo <tj@kernel.org>

On Sun, Dec 14, 2014 at 07:21:49PM -0800, Shaohua Li wrote:
> The libata tag allocation is using a round-robin policy. Next patch will
> make libata use block generic tag allocation, so let's add a policy to
> tag allocation.
> 
> Currently two policies: FIFO (default) and round-robin.

What's the benefit of round robin allocation?  Why do you only need
it for the old simple allocator, and no policy control for the more
complex blkpmq allocator?
