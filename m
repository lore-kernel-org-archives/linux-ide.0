From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Re: 2.6.17-rc5-git1: regression: resume from suspend(RAM)
      fails: libata issue
Date: Sat, 27 May 2006 17:24:42 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605271716030.5623@g5.osdl.org>
References: <200605272245.30108.axboe@suse.de> <4478D2B4.2000500@rtr.ca>
 <20060527223607.GE364@suse.de> <200605271848.53680.liml@rtr.ca>
 <20060527225316.GA1075@suse.de> <4478DC67.6050800@rtr.ca>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:38313 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965006AbWE1AYz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 27 May 2006 20:24:55 -0400
In-Reply-To: <4478DC67.6050800@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Jens Axboe <axboe@suse.de>, Jeff Garzik <jeff@garzik.org>, "zhao, forrest" <forrest.zhao@intel.com>, Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org



On Sat, 27 May 2006, Mark Lord wrote:
> 
> So, just the "status1 = ata_chk_status(ap);" seems to be enough
> to make it work for you, in place of the earlier 500msec delay we started
> with?

Not possible, since the "ata_busy_wait()" already did at least _one_

	udelay(10);
	status = ata_chk_status(ap);

as part of the busy wait. So it's not just a single ata_chk_status() that 
matters for Jens, it's a couple. And apparently waiting for DRDY actually
works for him.

In your case, it won't assert DRDY, and that's ok, the "ata_wait_idle()" 
timeout is very short, so even if it doesn't happen, we don't really care.

So I would suggest that for 2.6.17, we do this trivial patch that works 
for both of you, and which does _not_ have any insane half-second 
timeouts.

I think it's much easier to explain this one too. "Try a quick wait for 
idle" to me sounds logical and fine - even if we don't actually _require_ 
it.

If I've understood correctly, this patch (with no additional timeouts or 
anything else) should work for both Mark and Jens, and not make Jeff's 
case noticeably worse either. And I'm certainly fine with it.

Objections? Can everybody confirm that a clean current git tree with just 
this doesnt' have any huge downsides?

		Linus
---
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index fa476e7..6ccfbc9 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -4296,6 +4296,13 @@ static int ata_start_drive(struct ata_po
  */
 int ata_device_resume(struct ata_port *ap, struct ata_device *dev)
 {
+	/*
+	 * Wait for BUSY to go away for up to 2 seconds,
+	 * and then try to wait for idle (up to 1 msec)
+	 */
+	ata_busy_wait(ap, ATA_BUSY, 200000);
+	ata_wait_idle(ap);
+	
 	if (ap->flags & ATA_FLAG_SUSPENDED) {
 		ap->flags &= ~ATA_FLAG_SUSPENDED;
 		ata_set_mode(ap);
