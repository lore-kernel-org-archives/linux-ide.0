From: Tejun Heo <tj@kernel.org>
Subject: Re: request to revert libata-convert-to-block-tagging patches
Date: Mon, 10 Nov 2008 14:30:05 +0900
Message-ID: <4917C6DD.4010500@kernel.org>
References: <4917C449.2080504@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:46783 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750721AbYKJFaT (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 10 Nov 2008 00:30:19 -0500
In-Reply-To: <4917C449.2080504@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <jens.axboe@oracle.com>, Jeff Garzik <jeff@garzik.org>, Linus Torvalds <torvalds@linux-foundation.org>, IDE/ATA development list <linux-ide@vger.kernel.org>

Tejun Heo wrote:
> #1 is easy to fix but #2 requires either adding a spinlock or two atomic
> variables to struct blk_queue_tag to keep the current behavior while
> guaranteeing that tags are used in order.  Also, there's delay between
> libata marks a request complete and the request actually gets completed
> and the tag is freed.  If another request gets issued inbetween, the tag
> number can't be guaranteed.  This can be worked around by re-mapping tag
> number in libata depending on command type but, well then, it's worse
> than the original implementation.

I think this can be made to work by making tag free synchronous (ie.
doing it when the request is passed over to softirq) but I don't think
things like that should go into 2.6.28 at this point.

Thanks.

-- 
tejun
