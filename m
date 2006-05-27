From: Jens Axboe <axboe@suse.de>
Subject: Re: [PATCH] Re: 2.6.17-rc5-git1: regression: resume from suspend(RAM)      fails: libata issue
Date: Sun, 28 May 2006 00:53:16 +0200
Message-ID: <20060527225316.GA1075@suse.de>
References: <200605272245.30108.axboe@suse.de> <4478D2B4.2000500@rtr.ca> <20060527223607.GE364@suse.de> <200605271848.53680.liml@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns.virtualhost.dk ([195.184.98.160]:13380 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S964995AbWE0Wx1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 27 May 2006 18:53:27 -0400
Content-Disposition: inline
In-Reply-To: <200605271848.53680.liml@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Linus Torvalds <torvalds@osdl.org>, Jeff Garzik <jeff@garzik.org>, "zhao, forrest" <forrest.zhao@intel.com>, Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

On Sat, May 27 2006, Mark Lord wrote:
> On Saturday 27 May 2006 18:36, Jens Axboe wrote:
> > On Sat, May 27 2006, Mark Lord wrote:
> > > Linus Torvalds wrote:
> > > >
> > > >On Sun, 28 May 2006, Jens Axboe wrote:
> > > >>Works for me too, I changed the delay to match the 200000 above just to
> > > >>be on the safe side.
> > > >
> > > >That's insane. That was _not_ what I expected. That wasn't actually 
> > > >supposed to fix anything at all for somebody who had problems.
> > > 
> > > The newly added ata_wait_idle() call waits on both BUSY and DRQ,
> > > so perhaps the wait on DRQ was what "fixed" it this time for Jens?
> > 
> > It must be, unless the changed delay makes difference (unlikely).
> > 
> 
> So a better trial for you (to answer Linus) might be this patch:
> 
> ---
> --- stock-2.6.17-rc4-git1/drivers/scsi/libata-core.c	2006-05-27 16:58:05.000000000 -0400
> +++ linux/drivers/scsi/libata-core.c	2006-05-27 18:35:02.000000000 -0400
> @@ -4297,6 +4297,11 @@
>  int ata_device_resume(struct ata_port *ap, struct ata_device *dev)
>  {
>  	if (ap->flags & ATA_FLAG_SUSPENDED) {
> +		u8 status1, status2;
> +		status1 = ata_chk_status(ap);
> +		ata_busy_wait(ap, ATA_BUSY, 200000);
> +		status2 = ata_chk_status(ap);
> +		printk("ATA status1=%02x status2=%02x\n", status1, status2);
>  		ap->flags &= ~ATA_FLAG_SUSPENDED;
>  		ata_set_mode(ap);
>  	}

Inspired by your last posting, I already booted this:

+               u8 status1, status2, status3;
+               status1 = ata_chk_status(ap);
+               ata_busy_wait(ap, ATA_BUSY, 200000);
+               status2 = ata_chk_status(ap);
+               status3 = ata_wait_idle(ap);
+               printk("s 1/2/3 %x/%x/%x\n", status1, status2, status3);

with the rest being as posted before. It gives me:

s 1/2/3 80/50/50

on resume.

-- 
Jens Axboe

