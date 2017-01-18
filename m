From: Tejun Heo <tj@kernel.org>
Subject: Re: command emulation fix
Date: Wed, 18 Jan 2017 11:17:50 -0800
Message-ID: <20170118191750.GA9171@mtj.duckdns.org>
References: <1484412602-11801-1-git-send-email-hch@lst.de>
 <20170115230723.GB14446@mtj.duckdns.org>
 <20170116152120.GA16072@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:34096 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753012AbdART0q (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 18 Jan 2017 14:26:46 -0500
Received: by mail-pg0-f65.google.com with SMTP id t6so2074780pgt.1
        for <linux-ide@vger.kernel.org>; Wed, 18 Jan 2017 11:26:46 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20170116152120.GA16072@lst.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: linux-ide@vger.kernel.org

Hello,

On Mon, Jan 16, 2017 at 04:21:20PM +0100, Christoph Hellwig wrote:
> On Sun, Jan 15, 2017 at 06:07:23PM -0500, Tejun Heo wrote:
> > Ugh... I don't know.  What we had previously is always guaranteed to
> > work.  I'm not really liking the fact that we're adding a possibility
> > of failure here.  Even if we do mempool, we would still have to
> > protect it with a spinlock as mempool only guarantees one allocation
> > at a time.  Until we have a better solution, can we please revert back
> > to where we were at least for the buffers needed from atomic context?
> 
> In that case you'll need to drop all but the first patch from the series
> as ->queuecommand can always be called from atomic context.

I reverted just the last patch.  The rest should be fine, right?

Thanks.

-- 
tejun
