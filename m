From: Jens Axboe <axboe@suse.de>
Subject: Re: [BK PATCH] 2.6.x libata bug fix
Date: Tue, 26 Oct 2004 19:30:26 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20041026173025.GA15290@suse.de>
References: <20041026160247.GA23459@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns.virtualhost.dk ([195.184.98.160]:36332 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261342AbUJZRbE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 26 Oct 2004 13:31:04 -0400
Content-Disposition: inline
In-Reply-To: <20041026160247.GA23459@havoc.gtf.org>
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>, linux-ide@vger.kernel.org

On Tue, Oct 26 2004, Jeff Garzik wrote:
> 
> When I added ioctl handling, I returned EOPNOTSUPP for the "I didn't
> recognize that ioctl you wanted to execute" return code.
> 
> The block layer will execute certain ioctl operations IFF the low-level
> driver returns ENOTTY, signalling to the block layer that that driver
> does not support the specified ioctl.
> 
> The net effect of libata returning EOPNOTSUPP was such that it
> __broke__ BLSFLSBUF ioctl, simply by implementing ->ioctl.
> 
> So, we return the proper return code, and ioctls we don't handle
> start to work again.  Overall, though, this is a fragile way to do
> things in the block layer, IMHO.

Well, it's pretty much the universally accepted way of signalling this
information, I'm not sure I agree. The crappy part is that EINVAL is so
wide spread as well.

And EOPNOTSUPP just shows you are a networking whore as well :-)

-- 
Jens Axboe

