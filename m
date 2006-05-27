From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] Re: 2.6.17-rc5-git1: regression: resume from suspend(RAM)
      fails: libata issue
Date: Sat, 27 May 2006 18:55:04 -0400
Message-ID: <4478D8C8.1080109@garzik.org>
References: <200605272245.30108.axboe@suse.de> <4478D2B4.2000500@rtr.ca> <20060527223607.GE364@suse.de> <200605271848.53680.liml@rtr.ca> <20060527225316.GA1075@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:44437 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S965000AbWE0WzK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 27 May 2006 18:55:10 -0400
In-Reply-To: <20060527225316.GA1075@suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <axboe@suse.de>
Cc: Mark Lord <liml@rtr.ca>, Linus Torvalds <torvalds@osdl.org>, "zhao, forrest" <forrest.zhao@intel.com>, Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

Jens Axboe wrote:
> Inspired by your last posting, I already booted this:
> 
> +               u8 status1, status2, status3;
> +               status1 = ata_chk_status(ap);
> +               ata_busy_wait(ap, ATA_BUSY, 200000);
> +               status2 = ata_chk_status(ap);
> +               status3 = ata_wait_idle(ap);
> +               printk("s 1/2/3 %x/%x/%x\n", status1, status2, status3);
> 
> with the rest being as posted before. It gives me:
> 
> s 1/2/3 80/50/50

Yep, that's consistent with ata_piix's PATA emulation during device 
discovery.

DRDY on this hardware is 100% emulated...

	Jeff


