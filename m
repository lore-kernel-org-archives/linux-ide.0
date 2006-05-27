From: Jens Axboe <axboe@suse.de>
Subject: Re: [PATCH] Re: 2.6.17-rc5-git1: regression: resume from suspend(RAM)     fails: libata issue
Date: Sat, 27 May 2006 23:25:36 +0200
Message-ID: <20060527212536.GA31752@suse.de>
References: <1148634262.2310.7.camel@forrest26.sh.intel.com> <200605271423.40037.liml@rtr.ca> <Pine.LNX.4.64.0605271144430.5623@g5.osdl.org> <200605272245.30108.axboe@suse.de> <4478BD60.40806@garzik.org> <20060527211157.GA31275@suse.de> <4478C1DD.2030204@garzik.org> <20060527212011.GA31551@suse.de> <4478C36E.8080107@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns.virtualhost.dk ([195.184.98.160]:36357 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S964996AbWE0VZq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 27 May 2006 17:25:46 -0400
Content-Disposition: inline
In-Reply-To: <4478C36E.8080107@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Jeff Garzik <jeff@garzik.org>, Linus Torvalds <torvalds@osdl.org>, "zhao, forrest" <forrest.zhao@intel.com>, Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

On Sat, May 27 2006, Mark Lord wrote:
> Jens Axboe wrote:
> ..
> >ata_busy_wait() is _not_ enough for me, what seems to be happening is
> >that prematurely decides that BSY is cleared while it just hasn't been
> >asserted yet.
> ..
> 
> Ahh.. at last, something that even makes sense!
> 
> This whole thing has seemed very fiddly and timing dependent,
> and this discovery (above) explains it a bit.

Yep, it should also make the 'better' fixes work I think, but I have no
real time to test that right now. I think what exposed the timing
problem is the part that Hugh originally uncovered.

-- 
Jens Axboe

