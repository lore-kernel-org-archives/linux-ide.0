From: Jens Axboe <axboe@suse.de>
Subject: Re: [PATCH] Re: 2.6.17-rc5-git1: regression: resume from suspend(RAM)   fails: libata issue
Date: Sat, 27 May 2006 23:11:57 +0200
Message-ID: <20060527211157.GA31275@suse.de>
References: <1148634262.2310.7.camel@forrest26.sh.intel.com> <200605271423.40037.liml@rtr.ca> <Pine.LNX.4.64.0605271144430.5623@g5.osdl.org> <200605272245.30108.axboe@suse.de> <4478BD60.40806@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns.virtualhost.dk ([195.184.98.160]:58219 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S964984AbWE0VMF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 27 May 2006 17:12:05 -0400
Content-Disposition: inline
In-Reply-To: <4478BD60.40806@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Mark Lord <liml@rtr.ca>, "zhao, forrest" <forrest.zhao@intel.com>, Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

On Sat, May 27 2006, Jeff Garzik wrote:
> Jens Axboe wrote:
> >This is fine with me, Jeff originally complained it was a layering 
> >violation. Unless he really objects, I'd say go for that for 2.6.17 - well 
> >actually moving it inside the ATA_FLAG_SUSPENDED case is clearly better.
> 
> It breaks 2.6.1[89] stuff, but whatever.  Go ahead and apply Linus's 
> patch.  I'll pick up the pieces post 2.6.17.

Linus' patch doesn't work for me, seems I still need a little delay
before waiting for BSY clear. I'm testing a small additional hack to the
pci resume function.

-- 
Jens Axboe

