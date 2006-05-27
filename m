From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH] Re: 2.6.17-rc5-git1: regression: resume from suspend(RAM)      fails: libata issue
Date: Sat, 27 May 2006 18:48:53 -0400
Message-ID: <200605271848.53680.liml@rtr.ca>
References: <200605272245.30108.axboe@suse.de> <4478D2B4.2000500@rtr.ca> <20060527223607.GE364@suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:26761 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S964982AbWE0Wsz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 27 May 2006 18:48:55 -0400
In-Reply-To: <20060527223607.GE364@suse.de>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <axboe@suse.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Jeff Garzik <jeff@garzik.org>, "zhao, forrest" <forrest.zhao@intel.com>, Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

On Saturday 27 May 2006 18:36, Jens Axboe wrote:
> On Sat, May 27 2006, Mark Lord wrote:
> > Linus Torvalds wrote:
> > >
> > >On Sun, 28 May 2006, Jens Axboe wrote:
> > >>Works for me too, I changed the delay to match the 200000 above just to
> > >>be on the safe side.
> > >
> > >That's insane. That was _not_ what I expected. That wasn't actually 
> > >supposed to fix anything at all for somebody who had problems.
> > 
> > The newly added ata_wait_idle() call waits on both BUSY and DRQ,
> > so perhaps the wait on DRQ was what "fixed" it this time for Jens?
> 
> It must be, unless the changed delay makes difference (unlikely).
> 

So a better trial for you (to answer Linus) might be this patch:

---
--- stock-2.6.17-rc4-git1/drivers/scsi/libata-core.c	2006-05-27 16:58:05.000000000 -0400
+++ linux/drivers/scsi/libata-core.c	2006-05-27 18:35:02.000000000 -0400
@@ -4297,6 +4297,11 @@
 int ata_device_resume(struct ata_port *ap, struct ata_device *dev)
 {
 	if (ap->flags & ATA_FLAG_SUSPENDED) {
+		u8 status1, status2;
+		status1 = ata_chk_status(ap);
+		ata_busy_wait(ap, ATA_BUSY, 200000);
+		status2 = ata_chk_status(ap);
+		printk("ATA status1=%02x status2=%02x\n", status1, status2);
 		ap->flags &= ~ATA_FLAG_SUSPENDED;
 		ata_set_mode(ap);
 	}
