From: Christoph Hellwig <hch@lst.de>
Subject: Re: command emulation fix
Date: Mon, 16 Jan 2017 16:21:20 +0100
Message-ID: <20170116152120.GA16072@lst.de>
References: <1484412602-11801-1-git-send-email-hch@lst.de> <20170115230723.GB14446@mtj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:54216 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750826AbdAPPVW (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Mon, 16 Jan 2017 10:21:22 -0500
Content-Disposition: inline
In-Reply-To: <20170115230723.GB14446@mtj.duckdns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org

On Sun, Jan 15, 2017 at 06:07:23PM -0500, Tejun Heo wrote:
> Ugh... I don't know.  What we had previously is always guaranteed to
> work.  I'm not really liking the fact that we're adding a possibility
> of failure here.  Even if we do mempool, we would still have to
> protect it with a spinlock as mempool only guarantees one allocation
> at a time.  Until we have a better solution, can we please revert back
> to where we were at least for the buffers needed from atomic context?

In that case you'll need to drop all but the first patch from the series
as ->queuecommand can always be called from atomic context.
