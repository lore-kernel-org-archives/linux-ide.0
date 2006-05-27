From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] Re: 2.6.17-rc5-git1: regression: resume from suspend(RAM)
    fails: libata issue
Date: Sat, 27 May 2006 17:32:45 -0400
Message-ID: <4478C57D.50701@garzik.org>
References: <1148634262.2310.7.camel@forrest26.sh.intel.com> <200605271423.40037.liml@rtr.ca> <Pine.LNX.4.64.0605271144430.5623@g5.osdl.org> <200605272245.30108.axboe@suse.de> <4478BD60.40806@garzik.org> <20060527211157.GA31275@suse.de> <4478C1DD.2030204@garzik.org> <20060527212011.GA31551@suse.de> <4478C39A.9060302@garzik.org> <4478C544.3090404@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:30354 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S964942AbWE0Vcv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 27 May 2006 17:32:51 -0400
In-Reply-To: <4478C544.3090404@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Jens Axboe <axboe@suse.de>, Linus Torvalds <torvalds@osdl.org>, "zhao, forrest" <forrest.zhao@intel.com>, Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

Mark Lord wrote:
> Jeff Garzik wrote:
> ..
>>
>> Does it work if you move msleep() below pci_restore_state()?
>> "    "     "    "      below pci_enable_device()?
>>
>> I think the delay makes more sense after you wake up the controller...
>>
>> The fact that the above patch works most likely indicates the device, 
>> not the controller, needs the delay.
> 
> Another question here:  I really would have expected the new EH code
> to eventually recover from this, by resetting the chip/drive/whatever.
> 
> It doesn't.
> 
> ??

Maybe that's because 2.6.17 doesn't have the new EH code?  ;-)

	Jeff



