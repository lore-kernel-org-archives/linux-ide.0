From: Jens Axboe <axboe@suse.de>
Subject: Re: [PATCH] Re: 2.6.17-rc5-git1: regression: resume from suspend(RAM)      fails: libata issue
Date: Sun, 28 May 2006 00:36:07 +0200
Message-ID: <20060527223607.GE364@suse.de>
References: <200605272245.30108.axboe@suse.de> <4478BD60.40806@garzik.org> <20060527211157.GA31275@suse.de> <4478C1DD.2030204@garzik.org> <20060527212011.GA31551@suse.de> <Pine.LNX.4.64.0605271444200.5623@g5.osdl.org> <4478CD4E.4000506@rtr.ca> <20060527221131.GA364@suse.de> <Pine.LNX.4.64.0605271519250.5623@g5.osdl.org> <4478D2B4.2000500@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns.virtualhost.dk ([195.184.98.160]:21047 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S964966AbWE0WgV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 27 May 2006 18:36:21 -0400
Content-Disposition: inline
In-Reply-To: <4478D2B4.2000500@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Linus Torvalds <torvalds@osdl.org>, Jeff Garzik <jeff@garzik.org>, "zhao, forrest" <forrest.zhao@intel.com>, Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

On Sat, May 27 2006, Mark Lord wrote:
> Linus Torvalds wrote:
> >
> >On Sun, 28 May 2006, Jens Axboe wrote:
> >>Works for me too, I changed the delay to match the 200000 above just to
> >>be on the safe side.
> >
> >That's insane. That was _not_ what I expected. That wasn't actually 
> >supposed to fix anything at all for somebody who had problems.
> 
> The newly added ata_wait_idle() call waits on both BUSY and DRQ,
> so perhaps the wait on DRQ was what "fixed" it this time for Jens?

It must be, unless the changed delay makes difference (unlikely).

-- 
Jens Axboe

