From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Re: 2.6.17-rc5-git1: regression: resume from suspend(RAM)
      fails: libata issue
Date: Sat, 27 May 2006 17:35:03 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605271734070.5623@g5.osdl.org>
References: <200605272245.30108.axboe@suse.de> <4478D2B4.2000500@rtr.ca>
 <20060527223607.GE364@suse.de> <200605271848.53680.liml@rtr.ca>
 <20060527225316.GA1075@suse.de> <4478DC67.6050800@rtr.ca>
 <Pine.LNX.4.64.0605271716030.5623@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:50346 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965013AbWE1AfN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 27 May 2006 20:35:13 -0400
In-Reply-To: <Pine.LNX.4.64.0605271716030.5623@g5.osdl.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Jens Axboe <axboe@suse.de>, Jeff Garzik <jeff@garzik.org>, "zhao, forrest" <forrest.zhao@intel.com>, Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org



On Sat, 27 May 2006, Linus Torvalds wrote:
> +	/*
> +	 * Wait for BUSY to go away for up to 2 seconds,
> +	 * and then try to wait for idle (up to 1 msec)
> +	 */
> +	ata_busy_wait(ap, ATA_BUSY, 200000);
> +	ata_wait_idle(ap);

The comment is wrong by an order of magnitude. "ata_wait_idle()" will wait 
for up to "10" msec, not "1" msec.

I'll fix that and commit, if people are ok with this.

		Linus
