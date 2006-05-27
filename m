From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] Re: 2.6.17-rc5-git1: regression: resume from suspend(RAM)
   fails: libata issue
Date: Sat, 27 May 2006 17:17:17 -0400
Message-ID: <4478C1DD.2030204@garzik.org>
References: <1148634262.2310.7.camel@forrest26.sh.intel.com> <200605271423.40037.liml@rtr.ca> <Pine.LNX.4.64.0605271144430.5623@g5.osdl.org> <200605272245.30108.axboe@suse.de> <4478BD60.40806@garzik.org> <20060527211157.GA31275@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:61329 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S964980AbWE0VRX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 27 May 2006 17:17:23 -0400
In-Reply-To: <20060527211157.GA31275@suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <axboe@suse.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Mark Lord <liml@rtr.ca>, "zhao, forrest" <forrest.zhao@intel.com>, Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

Jens Axboe wrote:
> On Sat, May 27 2006, Jeff Garzik wrote:
>> Jens Axboe wrote:
>>> This is fine with me, Jeff originally complained it was a layering 
>>> violation. Unless he really objects, I'd say go for that for 2.6.17 - well 
>>> actually moving it inside the ATA_FLAG_SUSPENDED case is clearly better.
>> It breaks 2.6.1[89] stuff, but whatever.  Go ahead and apply Linus's 
>> patch.  I'll pick up the pieces post 2.6.17.
> 
> Linus' patch doesn't work for me, seems I still need a little delay
> before waiting for BSY clear. I'm testing a small additional hack to the
> pci resume function.

If it works better for people, just doing an msleep() or mdelay() in 
device suspend would be better than polling BSY.

A delay at least works for FIS-based controllers and PMs...

Post 2.6.17, a lot of work needs to go into actually re-initing the 
hardware, since the current suspend resumes to silicon defaults rather 
than BIOS defaults (and ata_piix doesn't have a controller reset).

	Jeff



