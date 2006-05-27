From: Jeff Garzik <jeff@garzik.org>
Subject: Re: 2.6.17-rc5-git1: regression: resume from suspend(RAM) fails:
 libata issue
Date: Fri, 26 May 2006 23:41:53 -0400
Message-ID: <4477CA81.5080107@garzik.org>
References: <1148634262.2310.7.camel@forrest26.sh.intel.com> <20060526230534.GA3640@suse.de> <4477C60E.1070106@rtr.ca> <Pine.LNX.4.64.0605262028460.5623@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:37862 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751785AbWE0Dl6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 26 May 2006 23:41:58 -0400
In-Reply-To: <Pine.LNX.4.64.0605262028460.5623@g5.osdl.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linus Torvalds <torvalds@osdl.org>
Cc: Mark Lord <liml@rtr.ca>, Jens Axboe <axboe@suse.de>, "zhao, forrest" <forrest.zhao@intel.com>, Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

Linus Torvalds wrote:
> 
> On Fri, 26 May 2006, Mark Lord wrote:
>> Well, this problem has been with us all for a year now,
>> and at this point it impacts practically *every* new "centrino"
>> notebook out there.
>>
>> We have a very simple workaround (previous post) that addresses it
>> for 2.6.17, and it's about damn time it got fixed.
>>
>> If there's a better solution for *2.6.17*, then *please* post it.
>> Otherwise, we have a fix.  Maybe Linus or Andrew should just apply it?
> 
> I'm definitely in the "at some point, protesting a patch that works 
> becomes an untenably position to take, no matter _how_ ugly the patch is" 
> camp.
> 
> If the people who complain that it is ugly cannot come up with an 
> alternate solution that works and isn't ugly, at some point the "ugly" 
> complaint just becomes totally pointless. 
> 
> Of course, I'm not on linux-ide, and I didn't see this particular 
> discussion from the start (or even the alledged simple workaround in the 
> "previous post"), but can people please fill me in? And if the choice is 
> not between "ugly" vs "pretty", but between "ugly" vs "nonworking", I 
> think we know what the answer should be.

Mark is just a slacker, like the rest of us ;-)

The solution, described in [1], is basically "move the delay from <here> 
to <there>."

The current code does
	resume PCI device
	kick the ATA device
when it should do
	resume PCI device
	bring up the ATA bus
	kick the ATA device

Regards,

	Jeff


[1] http://marc.theaimsgroup.com/?l=linux-ide&m=114868613527204&w=2


