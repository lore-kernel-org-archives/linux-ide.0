From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH] Re: 2.6.17-rc5-git1: regression: resume from suspend(RAM)
     fails: libata issue
Date: Sat, 27 May 2006 18:29:08 -0400
Message-ID: <4478D2B4.2000500@rtr.ca>
References: <1148634262.2310.7.camel@forrest26.sh.intel.com> <200605271423.40037.liml@rtr.ca> <Pine.LNX.4.64.0605271144430.5623@g5.osdl.org> <200605272245.30108.axboe@suse.de> <4478BD60.40806@garzik.org> <20060527211157.GA31275@suse.de> <4478C1DD.2030204@garzik.org> <20060527212011.GA31551@suse.de> <Pine.LNX.4.64.0605271444200.5623@g5.osdl.org> <4478CD4E.4000506@rtr.ca> <20060527221131.GA364@suse.de> <Pine.LNX.4.64.0605271519250.5623@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:55760 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S964960AbWE0W3K (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 27 May 2006 18:29:10 -0400
In-Reply-To: <Pine.LNX.4.64.0605271519250.5623@g5.osdl.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jens Axboe <axboe@suse.de>, Jeff Garzik <jeff@garzik.org>, "zhao, forrest" <forrest.zhao@intel.com>, Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

Linus Torvalds wrote:
> 
> On Sun, 28 May 2006, Jens Axboe wrote:
>> Works for me too, I changed the delay to match the 200000 above just to
>> be on the safe side.
> 
> That's insane. That was _not_ what I expected. That wasn't actually 
> supposed to fix anything at all for somebody who had problems.

The newly added ata_wait_idle() call waits on both BUSY and DRQ,
so perhaps the wait on DRQ was what "fixed" it this time for Jens?

-ml
