From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Re: 2.6.17-rc5-git1: regression: resume from suspend(RAM)
      fails: libata issue
Date: Sat, 27 May 2006 18:01:32 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605271757380.5623@g5.osdl.org>
References: <200605272245.30108.axboe@suse.de> <4478D2B4.2000500@rtr.ca>
 <20060527223607.GE364@suse.de> <200605271848.53680.liml@rtr.ca>
 <20060527225316.GA1075@suse.de> <4478DC67.6050800@rtr.ca>
 <Pine.LNX.4.64.0605271716030.5623@g5.osdl.org> <4478F484.4080908@garzik.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:61356 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965145AbWE1BBq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 27 May 2006 21:01:46 -0400
In-Reply-To: <4478F484.4080908@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Mark Lord <liml@rtr.ca>, Jens Axboe <axboe@suse.de>, "zhao, forrest" <forrest.zhao@intel.com>, Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org



On Sat, 27 May 2006, Jeff Garzik wrote:
> 
> I don't object, but ata_wait_idle() is completely pointless.

Ahh, you're right. I used it originally because I wanted just the value 
for ata_ok(), and the other ata_ok() user got it that way.

Jens - willing to test one more thing? Instead of using ata_wait_idle, 
what about just

	ata_busy_wait(ap, ATA_BUSY | ATA_DRQ, 200000);

in case your issue actually comes from DRQ being on for some strange 
reason (DMA in progress for some bootup inquiry command by the bios?)

Gaah.

		Linus
