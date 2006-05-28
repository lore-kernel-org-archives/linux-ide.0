From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Re: 2.6.17-rc5-git1: regression: resume from suspend(RAM)
    fails: libata issue
Date: Sat, 27 May 2006 17:13:59 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605271711100.5623@g5.osdl.org>
References: <1148634262.2310.7.camel@forrest26.sh.intel.com>
 <200605271423.40037.liml@rtr.ca> <Pine.LNX.4.64.0605271144430.5623@g5.osdl.org>
 <200605272245.30108.axboe@suse.de> <4478BD60.40806@garzik.org>
 <20060527211157.GA31275@suse.de> <4478C1DD.2030204@garzik.org>
 <20060527212011.GA31551@suse.de> <Pine.LNX.4.64.0605271444200.5623@g5.osdl.org>
 <4478CD4E.4000506@rtr.ca> <Pine.LNX.4.64.0605271515050.5623@g5.osdl.org>
 <4478D17C.2050300@rtr.ca>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:26536 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964999AbWE1AOZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 27 May 2006 20:14:25 -0400
In-Reply-To: <4478D17C.2050300@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Jens Axboe <axboe@suse.de>, Jeff Garzik <jeff@garzik.org>, "zhao, forrest" <forrest.zhao@intel.com>, Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org



On Sat, 27 May 2006, Mark Lord wrote:
> 
> Yeah, I know that.  Just pointing it out because the original
> discussion suggested we might want the code to also wait for DRDY,
> which would be correct only for ATA disks.

Well, that was my half-arsed theory on why it didn't work for Jens (ie he 
wasn't busy, but instead would wait for READY).

And judging from Jens' report, that was apparently exactly what was going 
on. In some respects, Jens' case is actually the more natural one.

In fact, it seems to be yours too, if I read your next mail correctly. We 
should _first_ wait for !BUSY and then the quick RDY wait is actually 
good.

		Linus
