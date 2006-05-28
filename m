From: Mark Lord <liml@rtr.ca>
Subject: [PATCH] 2.6.17-rc5: the latest consensus libata resume fix
Date: Sun, 28 May 2006 11:28:00 -0400
Message-ID: <200605281128.00532.liml@rtr.ca>
References: <200605272245.30108.axboe@suse.de> <Pine.LNX.4.64.0605271716030.5623@g5.osdl.org> <4478F681.8050607@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:19922 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1750768AbWE1P2C (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 28 May 2006 11:28:02 -0400
In-Reply-To: <4478F681.8050607@garzik.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Jens Axboe <axboe@suse.de>, "zhao, forrest" <forrest.zhao@intel.com>, Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

Okay, just to sum things up.

The patch below is the current "release candidate" for
improving the libata/ata_piix resume functionality in 2.6.17-rc*.

It forces libata to wait for up to 2 seconds for BUSY|DRQ to clear
on resume before continuing.  This is only for 2.6.17 at present.

We are waiting on Jens to test and report back for this specific version.

Signed-off-by:  Mark Lord <liml@rtr.ca>
---
--- linux-2.6.17-rc5/drivers/scsi/libata-core.c
+++ linux/drivers/scsi/libata-core.c
@@ -4296,6 +4296,7 @@ static int ata_start_drive(struct ata_po
  */
 int ata_device_resume(struct ata_port *ap, struct ata_device *dev)
 {
 	if (ap->flags & ATA_FLAG_SUSPENDED) {
+		ata_busy_wait(ap, ATA_BUSY | ATA_DRQ, 200000);
 		ap->flags &= ~ATA_FLAG_SUSPENDED;
 		ata_set_mode(ap);
