From: Jens Axboe <axboe@suse.de>
Subject: Re: [BK PATCH] 2.6.x libata bug fix
Date: Tue, 26 Oct 2004 19:56:19 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20041026175619.GE15290@suse.de>
References: <20041026160247.GA23459@havoc.gtf.org> <20041026173025.GA15290@suse.de> <417E8D4B.8030203@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns.virtualhost.dk ([195.184.98.160]:52101 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261403AbUJZR44 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 26 Oct 2004 13:56:56 -0400
Content-Disposition: inline
In-Reply-To: <417E8D4B.8030203@pobox.com>
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>, linux-ide@vger.kernel.org

On Tue, Oct 26 2004, Jeff Garzik wrote:
> Jens Axboe wrote:
> >On Tue, Oct 26 2004, Jeff Garzik wrote:
> >>So, we return the proper return code, and ioctls we don't handle
> >>start to work again.  Overall, though, this is a fragile way to do
> >>things in the block layer, IMHO.
> >
> >
> >Well, it's pretty much the universally accepted way of signalling this
> >information, I'm not sure I agree. The crappy part is that EINVAL is so
> >wide spread as well.
> 
> 
> My point is that most Linux APIs don't apply default behavior by means 
> of a magic return code.
> 
> Each block/scsi/etc. driver should provide their own ioctl handler as 
> the highest-level callback.  Then, each individual driver decides its 
> fallback strategy for unknown ioctls -- in most cases, by calling 
> "libata_ioctl" or "scsi_ioctl" or "block_ioctl".
> 
> In this manner, ioctl handling cascades naturally up through the layers, 
> without magic return codes.

But it doesn't quite work so well if you are a device/driver that needs
to call several of these functions - you get the same problem, you need
to know when it was accepted or when to pass it on. Or you need to know
every single ioctl. Maybe you can kill it in the driver, but you need it
at least some place in the stack.

> The current "top-down" ioctl handling implementation leads to the 
> current situation:  a bunch of ->ioctl() callsites scattered through the 
> generic block ioctl handling code.

It is a bit messy in places, I agree. But I don't think this has
anything to do with it using -ENOTTY as a special magic "I dunno what
you are talking about", rather it just needs a little cleanup action.

Honestly, I don't think -ENOTTY is so nasty. It's been described a
number of times in various places, it should be common knowledge for
anyone doing a linux/unix driver.

-- 
Jens Axboe

