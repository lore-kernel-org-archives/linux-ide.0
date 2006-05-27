From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Re: 2.6.17-rc5-git1: regression: resume from suspend(RAM)
     fails: libata issue
Date: Sat, 27 May 2006 15:21:56 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605271519250.5623@g5.osdl.org>
References: <1148634262.2310.7.camel@forrest26.sh.intel.com>
 <200605271423.40037.liml@rtr.ca> <Pine.LNX.4.64.0605271144430.5623@g5.osdl.org>
 <200605272245.30108.axboe@suse.de> <4478BD60.40806@garzik.org>
 <20060527211157.GA31275@suse.de> <4478C1DD.2030204@garzik.org>
 <20060527212011.GA31551@suse.de> <Pine.LNX.4.64.0605271444200.5623@g5.osdl.org>
 <4478CD4E.4000506@rtr.ca> <20060527221131.GA364@suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:53144 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965011AbWE0WYA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 27 May 2006 18:24:00 -0400
In-Reply-To: <20060527221131.GA364@suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <axboe@suse.de>
Cc: Mark Lord <liml@rtr.ca>, Jeff Garzik <jeff@garzik.org>, "zhao, forrest" <forrest.zhao@intel.com>, Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org



On Sun, 28 May 2006, Jens Axboe wrote:
> 
> Works for me too, I changed the delay to match the 200000 above just to
> be on the safe side.

That's insane. That was _not_ what I expected. That wasn't actually 
supposed to fix anything at all for somebody who had problems.

Maybe you didn't remove the half-second delay (which is why it still works 
for you)? I'd like to see what bits are set when it _isn't_ there, to see 
if there's something we can trigger on..

		Linus
