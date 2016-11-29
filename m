From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] pata_legacy: Allow disabling of legacy PATA device
 probes on non-PCI systems
Date: Tue, 29 Nov 2016 15:46:02 -0500
Message-ID: <20161129204602.GD4959@htj.duckdns.org>
References: <1480441982-20992-1-git-send-email-tedheadster@gmail.com>
 <20161129194158.GB4959@htj.duckdns.org>
 <CAP8WD_ZxS0TMzHB+=3Gohw39+S2hQbm-pucuYPYK6JUhFWVd5A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yw0-f196.google.com ([209.85.161.196]:34693 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751991AbcK2UqE (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 29 Nov 2016 15:46:04 -0500
Received: by mail-yw0-f196.google.com with SMTP id a10so13167271ywa.1
        for <linux-ide@vger.kernel.org>; Tue, 29 Nov 2016 12:46:04 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAP8WD_ZxS0TMzHB+=3Gohw39+S2hQbm-pucuYPYK6JUhFWVd5A@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: whiteheadm@acm.org
Cc: linux-ide@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Hello,

On Tue, Nov 29, 2016 at 03:12:31PM -0500, tedheadster wrote:
> > Can you please give a concrete example of a machine and situation
> > where this would be useful?
> >
> 
> 
> Sure, my regression testing i486 system has this problem. It only has
> an EISA bus, no PCI. I had to apply the patch to be able to put even
> 2-3 cards in it. It had run out of IRQs.
> 
> This testing helped uncover a long time kernel bug that now has a patch.
> 
> http://git.kernel.org/cgit/linux/kernel/git/tip/tip.git/commit/?id=fc0e81b2bea0ebceb71889b61d2240856141c9ee
> 
> Please check the linux-kernel mailing list thread "What exactly do
> 32-bit x86 exceptions push on the stack in the CS slot?" for more
> details.
> 
> https://lkml.org/lkml/2016/11/19/308

I see.  Yeah, I don't have any objections to the change although I do
wish it were easier / automatic.  That said, given how niche it is, it
most likely won't matter.  Bartlomiej, what do you think?

Thanks.

-- 
tejun
