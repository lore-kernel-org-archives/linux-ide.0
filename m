From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Re: 2.6.17-rc5-git1: regression: resume from suspend(RAM)
 fails: libata issue
Date: Sat, 27 May 2006 11:47:39 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605271144430.5623@g5.osdl.org>
References: <1148634262.2310.7.camel@forrest26.sh.intel.com>
 <Pine.LNX.4.64.0605262028460.5623@g5.osdl.org> <4477CEF5.9000908@garzik.org>
 <200605271423.40037.liml@rtr.ca>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:47325 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964932AbWE0Srx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 27 May 2006 14:47:53 -0400
In-Reply-To: <200605271423.40037.liml@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Jeff Garzik <jeff@garzik.org>, Jens Axboe <axboe@suse.de>, "zhao, forrest" <forrest.zhao@intel.com>, Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org



On Sat, 27 May 2006, Mark Lord wrote:
> 
> The original "bad layering" patch still works perfectly in it's place.
> Repeated below for Linus's benefit.

Why isn't the right fix the minimal one?

What's the layering violation in just having ATA resume make sure it's not 
ATA_BUSY? 

Why are you guys fighting over this?

And why the hell is Mark's patch not being accepted if it fixes something, 
and the alternate patches do not?

		Linus
---
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index fa476e7..0ef4cf4 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -4296,6 +4296,7 @@ static int ata_start_drive(struct ata_po
  */
 int ata_device_resume(struct ata_port *ap, struct ata_device *dev)
 {
+	ata_busy_wait(ap, ATA_BUSY, 200000);
 	if (ap->flags & ATA_FLAG_SUSPENDED) {
 		ap->flags &= ~ATA_FLAG_SUSPENDED;
 		ata_set_mode(ap);
