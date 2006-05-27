From: Jens Axboe <axboe@suse.de>
Subject: Re: [PATCH] Re: 2.6.17-rc5-git1: regression: resume from suspend(RAM)      fails: libata issue
Date: Sun, 28 May 2006 00:17:22 +0200
Message-ID: <20060527221722.GC364@suse.de>
References: <Pine.LNX.4.64.0605271144430.5623@g5.osdl.org> <200605272245.30108.axboe@suse.de> <4478BD60.40806@garzik.org> <20060527211157.GA31275@suse.de> <4478C1DD.2030204@garzik.org> <20060527212011.GA31551@suse.de> <Pine.LNX.4.64.0605271444200.5623@g5.osdl.org> <4478CD4E.4000506@rtr.ca> <20060527221131.GA364@suse.de> <4478CF7F.2080303@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns.virtualhost.dk ([195.184.98.160]:53294 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S965006AbWE0WTf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 27 May 2006 18:19:35 -0400
Content-Disposition: inline
In-Reply-To: <4478CF7F.2080303@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Linus Torvalds <torvalds@osdl.org>, Jeff Garzik <jeff@garzik.org>, "zhao, forrest" <forrest.zhao@intel.com>, Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

On Sat, May 27 2006, Mark Lord wrote:
> Jens Axboe wrote:
> >On Sat, May 27 2006, Mark Lord wrote:
> >
> >>Resume worked, with this output:
> >>
> >>May 27 18:03:33 localhost kernel: ATA status 80
> >>May 27 18:03:33 localhost kernel: ata1: dev 0 configured for UDMA/100
> >>May 27 18:03:33 localhost kernel: ATA status 00
> >>May 27 18:03:33 localhost kernel: ata2: dev 0 configured for UDMA/33
> >>
> >>Note that the second set are for the DVD-RW drive,
> >>which (being ATAPI) doesn't assert ATA_DRDY.
> >
> >Works for me too, I changed the delay to match the 200000 above just to
> >be on the safe side.
> 
> 
> But what was the kernel output for the status value?

None, I got no output. I resumed 4 times here, worked every time and no
ATA status messages.

> It's important here --> the printk() probably introduced enough delay
> to compensate for the removal of your other delay.

Not when there's no printk :)

> You did remove the other delay, right?

of course, in fact it resumes noticably faster.

-- 
Jens Axboe

