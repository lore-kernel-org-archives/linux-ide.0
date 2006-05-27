From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Re: 2.6.17-rc5-git1: regression: resume from suspend(RAM)
    fails: libata issue
Date: Sat, 27 May 2006 15:18:29 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605271515050.5623@g5.osdl.org>
References: <1148634262.2310.7.camel@forrest26.sh.intel.com>
 <200605271423.40037.liml@rtr.ca> <Pine.LNX.4.64.0605271144430.5623@g5.osdl.org>
 <200605272245.30108.axboe@suse.de> <4478BD60.40806@garzik.org>
 <20060527211157.GA31275@suse.de> <4478C1DD.2030204@garzik.org>
 <20060527212011.GA31551@suse.de> <Pine.LNX.4.64.0605271444200.5623@g5.osdl.org>
 <4478CD4E.4000506@rtr.ca>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:39320 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965005AbWE0WUd (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 27 May 2006 18:20:33 -0400
In-Reply-To: <4478CD4E.4000506@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Jens Axboe <axboe@suse.de>, Jeff Garzik <jeff@garzik.org>, "zhao, forrest" <forrest.zhao@intel.com>, Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org



On Sat, 27 May 2006, Mark Lord wrote:
> 
> I got rid of the 500msec delay (not needed on my machine anyway),
> and then added the above code *in front of* the ata_busy_wait().
> 
> Resume worked, with this output:
> 
> May 27 18:03:33 localhost kernel: ATA status 80

Ok, we already knew you had ATA_BUSY set, so bit 7 being set isn't 
surprising at all.

> May 27 18:03:33 localhost kernel: ATA status 00
> 
> Note that the second set are for the DVD-RW drive,
> which (being ATAPI) doesn't assert ATA_DRDY.

Neither of them do. 80 is just your old ATA_BUSY (that you needed to wait 
a long time for to disappear).

Can you move the two new lines to *after* the ata_busy_wait? I'd like to 
see if ATA_DRDY ever comes on (it quite possibly will not, just humor me)

			Linus
