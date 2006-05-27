From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH] Re: 2.6.17-rc5-git1: regression: resume from suspend(RAM)
      fails: libata issue
Date: Sat, 27 May 2006 19:10:31 -0400
Message-ID: <4478DC67.6050800@rtr.ca>
References: <200605272245.30108.axboe@suse.de> <4478D2B4.2000500@rtr.ca> <20060527223607.GE364@suse.de> <200605271848.53680.liml@rtr.ca> <20060527225316.GA1075@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:49586 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S964938AbWE0XKd (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 27 May 2006 19:10:33 -0400
In-Reply-To: <20060527225316.GA1075@suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <axboe@suse.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Jeff Garzik <jeff@garzik.org>, "zhao, forrest" <forrest.zhao@intel.com>, Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

Jens Axboe wrote:
> +               u8 status1, status2, status3;
> +               status1 = ata_chk_status(ap);
> +               ata_busy_wait(ap, ATA_BUSY, 200000);
> +               status2 = ata_chk_status(ap);
> +               status3 = ata_wait_idle(ap);
> +               printk("s 1/2/3 %x/%x/%x\n", status1, status2, status3);
> 
> with the rest being as posted before. It gives me:
> 
> s 1/2/3 80/50/50 on resume.
...

> With that hunk restored to normal, no change. Resume still works, status
> is still 80/50/50.

So, just the "status1 = ata_chk_status(ap);" seems to be enough
to make it work for you, in place of the earlier 500msec delay we started with?

Curious.

Does it still work when the "status1 = ata_chk_status(ap);" is replaced with udelay(1) ??

