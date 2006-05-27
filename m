From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] Re: 2.6.17-rc5-git1: regression: resume from suspend(RAM)
 fails: libata issue
Date: Sat, 27 May 2006 15:01:09 -0400
Message-ID: <4478A1F5.6030406@garzik.org>
References: <1148634262.2310.7.camel@forrest26.sh.intel.com> <Pine.LNX.4.64.0605262028460.5623@g5.osdl.org> <4477CEF5.9000908@garzik.org> <200605271423.40037.liml@rtr.ca> <Pine.LNX.4.64.0605271144430.5623@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:29837 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S964935AbWE0TBP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 27 May 2006 15:01:15 -0400
In-Reply-To: <Pine.LNX.4.64.0605271144430.5623@g5.osdl.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linus Torvalds <torvalds@osdl.org>
Cc: Mark Lord <liml@rtr.ca>, Jens Axboe <axboe@suse.de>, "zhao, forrest" <forrest.zhao@intel.com>, Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

Linus Torvalds wrote:
> On Sat, 27 May 2006, Mark Lord wrote:
>> The original "bad layering" patch still works perfectly in it's place.
>> Repeated below for Linus's benefit.
> 
> Why isn't the right fix the minimal one?

Your minimal patch is FAR better than the other working patch.


> What's the layering violation in just having ATA resume make sure it's not 
> ATA_BUSY? 

> Why are you guys fighting over this?

As soon as we start powering on the SATA phy (code exists, 2.6.18), or 
dealing with port multipliers (code exists, 2.6.19), the "working patch" 
stops working.

So we have to start this all over again.


> And why the hell is Mark's patch not being accepted if it fixes something, 
> and the alternate patches do not?

The alternate only appeared 12 hours ago, when people started yelling?

But whatever.  Life goes on.  I'll fix whatever gets merged.

	Jeff


