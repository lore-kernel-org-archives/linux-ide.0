From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: 2.6.17-rc5-git1: regression: resume from suspend(RAM) fails:
 libata issue
Date: Fri, 26 May 2006 20:32:04 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605262028460.5623@g5.osdl.org>
References: <1148634262.2310.7.camel@forrest26.sh.intel.com>
 <20060526230534.GA3640@suse.de> <4477C60E.1070106@rtr.ca>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:7622 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751779AbWE0DcQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 26 May 2006 23:32:16 -0400
In-Reply-To: <4477C60E.1070106@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Jens Axboe <axboe@suse.de>, "zhao, forrest" <forrest.zhao@intel.com>, Jeff Garzik <jeff@garzik.org>, Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org



On Fri, 26 May 2006, Mark Lord wrote:
> 
> Well, this problem has been with us all for a year now,
> and at this point it impacts practically *every* new "centrino"
> notebook out there.
> 
> We have a very simple workaround (previous post) that addresses it
> for 2.6.17, and it's about damn time it got fixed.
> 
> If there's a better solution for *2.6.17*, then *please* post it.
> Otherwise, we have a fix.  Maybe Linus or Andrew should just apply it?

I'm definitely in the "at some point, protesting a patch that works 
becomes an untenably position to take, no matter _how_ ugly the patch is" 
camp.

If the people who complain that it is ugly cannot come up with an 
alternate solution that works and isn't ugly, at some point the "ugly" 
complaint just becomes totally pointless. 

Of course, I'm not on linux-ide, and I didn't see this particular 
discussion from the start (or even the alledged simple workaround in the 
"previous post"), but can people please fill me in? And if the choice is 
not between "ugly" vs "pretty", but between "ugly" vs "nonworking", I 
think we know what the answer should be.

			Linus
