From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Re: 2.6.17-rc5-git1: regression: resume from suspend(RAM)
      fails: libata issue
Date: Sat, 27 May 2006 17:26:43 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605271724560.5623@g5.osdl.org>
References: <200605272245.30108.axboe@suse.de> <4478D2B4.2000500@rtr.ca>
 <20060527223607.GE364@suse.de> <200605271848.53680.liml@rtr.ca>
 <20060527225316.GA1075@suse.de> <4478DC67.6050800@rtr.ca>
 <Pine.LNX.4.64.0605271716030.5623@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:47273 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965011AbWE1A0w (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 27 May 2006 20:26:52 -0400
In-Reply-To: <Pine.LNX.4.64.0605271716030.5623@g5.osdl.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Jens Axboe <axboe@suse.de>, Jeff Garzik <jeff@garzik.org>, "zhao, forrest" <forrest.zhao@intel.com>, Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org



On Sat, 27 May 2006, Linus Torvalds wrote:
> 
> Objections? Can everybody confirm that a clean current git tree with just 
> this doesnt' have any huge downsides?

Perhaps more importantly, can anybody imagine any realistic possible 
downsides at all? Both waits have an _eventual_ timeout (although the busy 
wait is pretty damn long), so even the most perverse controller should at 
worst just wait a fairly long time.

And we're doing nothing but reading the status register, so I don't see 
any reasonable breakage.

Hmm?

		Linus
