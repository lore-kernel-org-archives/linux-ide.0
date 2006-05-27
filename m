From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] Re: 2.6.17-rc5-git1: regression: resume from suspend(RAM)
  fails: libata issue
Date: Sat, 27 May 2006 16:58:08 -0400
Message-ID: <4478BD60.40806@garzik.org>
References: <1148634262.2310.7.camel@forrest26.sh.intel.com> <200605271423.40037.liml@rtr.ca> <Pine.LNX.4.64.0605271144430.5623@g5.osdl.org> <200605272245.30108.axboe@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:12689 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S964966AbWE0U6Q (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 27 May 2006 16:58:16 -0400
In-Reply-To: <200605272245.30108.axboe@suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <axboe@suse.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Mark Lord <liml@rtr.ca>, "zhao, forrest" <forrest.zhao@intel.com>, Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

Jens Axboe wrote:
> This is fine with me, Jeff originally complained it was a layering violation. 
> Unless he really objects, I'd say go for that for 2.6.17 - well actually 
> moving it inside the ATA_FLAG_SUSPENDED case is clearly better.

It breaks 2.6.1[89] stuff, but whatever.  Go ahead and apply Linus's 
patch.  I'll pick up the pieces post 2.6.17.

	Jeff

