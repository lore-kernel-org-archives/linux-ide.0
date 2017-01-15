From: Tejun Heo <tj@kernel.org>
Subject: Re: command emulation fix
Date: Sun, 15 Jan 2017 18:07:23 -0500
Message-ID: <20170115230723.GB14446@mtj.duckdns.org>
References: <1484412602-11801-1-git-send-email-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-io0-f194.google.com ([209.85.223.194]:33246 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751087AbdAOXHb (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 15 Jan 2017 18:07:31 -0500
Received: by mail-io0-f194.google.com with SMTP id 101so11010699iom.0
        for <linux-ide@vger.kernel.org>; Sun, 15 Jan 2017 15:07:30 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1484412602-11801-1-git-send-email-hch@lst.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: linux-ide@vger.kernel.org

Hello, Christoph.

On Sat, Jan 14, 2017 at 05:50:01PM +0100, Christoph Hellwig wrote:
> Of course we can't just do a blind GFP_NOIO from ->queuecommand,
> mea culpa.  For most of the commands GFP_ATOMIC should be absolutely
> fine as they are only called from the probe path.  If you're
> paranoid TRIM might want a sector-sized mempool, but other common
> drivers like NVMe rely on plain GFP_ATOMIC allocations for those
> as well.  Let me know, and I'll send a mempool patch on top of it.

Ugh... I don't know.  What we had previously is always guaranteed to
work.  I'm not really liking the fact that we're adding a possibility
of failure here.  Even if we do mempool, we would still have to
protect it with a spinlock as mempool only guarantees one allocation
at a time.  Until we have a better solution, can we please revert back
to where we were at least for the buffers needed from atomic context?

Thanks.

-- 
tejun
