From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Re: 2.6.17-rc5-git1: regression: resume from suspend(RAM)
    fails: libata issue
Date: Sat, 27 May 2006 15:14:23 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605271509320.5623@g5.osdl.org>
References: <1148634262.2310.7.camel@forrest26.sh.intel.com>
 <200605271423.40037.liml@rtr.ca> <Pine.LNX.4.64.0605271144430.5623@g5.osdl.org>
 <200605272245.30108.axboe@suse.de> <4478BD60.40806@garzik.org>
 <20060527211157.GA31275@suse.de> <4478C1DD.2030204@garzik.org>
 <20060527212011.GA31551@suse.de> <Pine.LNX.4.64.0605271444200.5623@g5.osdl.org>
 <4478CA5A.4000100@garzik.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:5784 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965000AbWE0WQi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 27 May 2006 18:16:38 -0400
In-Reply-To: <4478CA5A.4000100@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Jens Axboe <axboe@suse.de>, Mark Lord <liml@rtr.ca>, "zhao, forrest" <forrest.zhao@intel.com>, Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org



On Sat, 27 May 2006, Jeff Garzik wrote:
>
> Linus Torvalds wrote:
> > 	u8 status = ata_wait_idle(ap);
> 
> Vastly decreased wait probably won't work, since we had to increase the wait
> otherwise.
> 
> > 	if (!ata_ok(status))
> 
> Correct (re DRQ etc.).

I actually just want to see what the bits are here.

In other words, we already have a good solution for Mark's problem. I 
don't think the suggested solution on top of that for Jens is any good, 
and I'd like to see what bits are set for Jens here.

So I _expect_ (or rather, hope) it to fail for his setup. 

Jens doesn't seem to have the ATA_BUSY bit set, because if he did, then 
the ata_busy_wait() thing should basically have done the wait for him. 

That's why I did the wait-idle() + ata_ok() check. It should all work 
beautifully on machines that didn't have trouble before - but it should 
hopefully print out something interesting for machines that are potential 
trouble-spots.

			Linus
