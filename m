From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Re: 2.6.17-rc5-git1: regression: resume from suspend(RAM)
    fails: libata issue
Date: Sat, 27 May 2006 14:57:40 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605271453490.5623@g5.osdl.org>
References: <1148634262.2310.7.camel@forrest26.sh.intel.com>
 <200605271423.40037.liml@rtr.ca> <Pine.LNX.4.64.0605271144430.5623@g5.osdl.org>
 <200605272245.30108.axboe@suse.de> <4478BD60.40806@garzik.org>
 <20060527211157.GA31275@suse.de> <4478C1DD.2030204@garzik.org>
 <20060527212011.GA31551@suse.de> <Pine.LNX.4.64.0605271426030.5623@g5.osdl.org>
 <4478C9AF.30405@garzik.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:40085 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964980AbWE0V54 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 27 May 2006 17:57:56 -0400
In-Reply-To: <4478C9AF.30405@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Jens Axboe <axboe@suse.de>, Mark Lord <liml@rtr.ca>, "zhao, forrest" <forrest.zhao@intel.com>, Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org



On Sat, 27 May 2006, Jeff Garzik wrote:
> 
> It is.  But I thought you wanted something that works?  :)

I want something that can be _understood_ to work, and that clearly 
doesn't have any downsides.

Waiting for the target to not be BUSY at resume is such an obviously 
understandable thing that it's not even funny.

In contrast, having an unconditional half-second delay for each SATA port 
is not obvious at all, and has potentially huge downsides for totally 
unrelated users. 

> Your patch + Jens' patch [with the delay MOVED to the end] would get my ACK
> for 2.6.17, and we already have infrastructure queued for 2.6.18 to do a
> better job of kicking the controller and bus.

No way am I adding a random half-second wait. One _millisecond_ or 
something similar clearly won't impact anybody else. But half a second for 
a condition that people don't even understand?

> > discovery, while the other might instead try to see if the state _matches_
> > what it already knows. But the point is that coming back from power-off
> > after a resume should really not be any different than coming back from
> > power-off after a bootup)
> 
> Key difference:  we have no BIOS to give us sane hardware state, so the
> controller is in a different state from bootup.

Note that that is true sometimes on other platforms too, even at bootup. 
Maybe we've not had that issue with SATA, but we've definitely had it with 
just about any other hw config.

		Linus
