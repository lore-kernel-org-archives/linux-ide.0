From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH] Re: 2.6.17-rc5-git1: regression: resume from suspend(RAM)
     fails: libata issue
Date: Sat, 27 May 2006 18:15:27 -0400
Message-ID: <4478CF7F.2080303@rtr.ca>
References: <1148634262.2310.7.camel@forrest26.sh.intel.com> <200605271423.40037.liml@rtr.ca> <Pine.LNX.4.64.0605271144430.5623@g5.osdl.org> <200605272245.30108.axboe@suse.de> <4478BD60.40806@garzik.org> <20060527211157.GA31275@suse.de> <4478C1DD.2030204@garzik.org> <20060527212011.GA31551@suse.de> <Pine.LNX.4.64.0605271444200.5623@g5.osdl.org> <4478CD4E.4000506@rtr.ca> <20060527221131.GA364@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:18587 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S964999AbWE0WP3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 27 May 2006 18:15:29 -0400
In-Reply-To: <20060527221131.GA364@suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <axboe@suse.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Jeff Garzik <jeff@garzik.org>, "zhao, forrest" <forrest.zhao@intel.com>, Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

Jens Axboe wrote:
> On Sat, May 27 2006, Mark Lord wrote:
>
>> Resume worked, with this output:
>>
>> May 27 18:03:33 localhost kernel: ATA status 80
>> May 27 18:03:33 localhost kernel: ata1: dev 0 configured for UDMA/100
>> May 27 18:03:33 localhost kernel: ATA status 00
>> May 27 18:03:33 localhost kernel: ata2: dev 0 configured for UDMA/33
>>
>> Note that the second set are for the DVD-RW drive,
>> which (being ATAPI) doesn't assert ATA_DRDY.
> 
> Works for me too, I changed the delay to match the 200000 above just to
> be on the safe side.


But what was the kernel output for the status value?

It's important here --> the printk() probably introduced enough delay
to compensate for the removal of your other delay.

You did remove the other delay, right?

Cheers

