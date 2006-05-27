From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] Re: 2.6.17-rc5-git1: regression: resume from suspend(RAM)
     fails: libata issue
Date: Sat, 27 May 2006 17:45:55 -0400
Message-ID: <4478C893.60207@garzik.org>
References: <1148634262.2310.7.camel@forrest26.sh.intel.com> <200605271423.40037.liml@rtr.ca> <Pine.LNX.4.64.0605271144430.5623@g5.osdl.org> <200605272245.30108.axboe@suse.de> <4478BD60.40806@garzik.org> <20060527211157.GA31275@suse.de> <4478C1DD.2030204@garzik.org> <20060527212011.GA31551@suse.de> <4478C39A.9060302@garzik.org> <20060527213333.GA32007@suse.de> <4478C5FE.1090306@garzik.org> <4478C799.8000207@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:56466 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S964938AbWE0VqA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 27 May 2006 17:46:00 -0400
In-Reply-To: <4478C799.8000207@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jens Axboe <axboe@suse.de>, Linus Torvalds <torvalds@osdl.org>, Mark Lord <liml@rtr.ca>, "zhao, forrest" <forrest.zhao@intel.com>, linux-ide@vger.kernel.org

Tejun Heo wrote:
> This sounds a lot like hotplug spinup-wait case.  Are those harddisks 
> PATA or SATA?  Also, I think this can be handled better by EH.  ie. 
> register it as hotplug event -> wait for spin up if necessary -> reset & 
> revalidate.

Ultimately this is all a 2.6.17 temp fix that disappears immediately 
with current #upstream work...

So we get to go through all these tests all over again :)

I agree your EH stuff will come in quite handy, but also it should be 
noted that my call to ata_bus_probe() is wrong -- you want to IDLE 
IMMEDIATE before doing some other stuff.

	Jeff


