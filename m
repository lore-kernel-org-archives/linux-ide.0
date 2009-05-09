From: Tejun Heo <tj@kernel.org>
Subject: [PATCH #upstream-fixes] libata: fix attach error handling
Date: Sun, 10 May 2009 01:06:54 +0900
Message-ID: <4A05AA1E.3070700@kernel.org>
References: <alpine.DEB.2.00.0905060004100.15177@dirac.rather.puzzling.org> <4A00DA98.5060201@kernel.org> <alpine.DEB.2.00.0905061038340.14678@dirac.rather.puzzling.org> <alpine.DEB.2.00.0905090005560.24222@dirac.rather.puzzling.org> <4A04DF32.4050305@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:49899 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751553AbZEIQKO (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 9 May 2009 12:10:14 -0400
In-Reply-To: <4A04DF32.4050305@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tim Connors <tconnors+linuxkml@astro.swin.edu.au>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Jeff Garzik <jeff@garzik.org>

New device attach path in ata_eh_revalidate_and_attach() is divided
into two separate loops because ATA requires IDENTIFY to be issued to
slave first while the user expects to see device probe messages from
the master device.  new_mask is used to track which devices are the
new ones between the first loop and the second.

This usually works well but if an error occurs during configuration
stage, ata_dev_revalidate_and_attach() returns with error code and
forgets new_mask.  On the retry run, dev->class is set and new_mask
for the device is clear, so the device just gets revalidated and thus
ends up skipping post-configuration procedure including scheduling of
SCSI_HOTPLUG for the device.  When this occurs, ATA part of probing
works fine but SCSI probing usually doesn't happen and makes the
device unreachable.

The behavior has been around for a very long time but it has been
uncovered with the recent addition of 1_5_GBPS horkage which uses
-EAGAIN return value from ata_dev_configure() to restart the probing
sequence after forcing cable speed.

This can be fixed by making sure dev->class is permanently set only
after all configurations are successfully complete.  Fix it.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reported-by: Tim Connors <tconnors+linuxkml@astro.swin.edu.au>
---
 drivers/ata/libata-eh.c |   21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 0183131..eb8b940 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -2783,6 +2783,12 @@ static int ata_eh_revalidate_and_attach(struct ata_link *link,
 		} else if (dev->class == ATA_DEV_UNKNOWN &&
 			   ehc->tries[dev->devno] &&
 			   ata_class_enabled(ehc->classes[dev->devno])) {
+			/* Temporarily set dev->class, it will be
+			 * permanently set once all configurations are
+			 * complete.  This is necessary because new
+			 * device configuration is done in two
+			 * separate loops.
+			 */
 			dev->class = ehc->classes[dev->devno];
 
 			if (dev->class == ATA_DEV_PMP)
@@ -2790,6 +2796,11 @@ static int ata_eh_revalidate_and_attach(struct ata_link *link,
 			else
 				rc = ata_dev_read_id(dev, &dev->class,
 						     readid_flags, dev->id);
+
+			/* read_id might have changed class, store and reset */
+			ehc->classes[dev->devno] = dev->class;
+			dev->class = ATA_DEV_UNKNOWN;
+
 			switch (rc) {
 			case 0:
 				/* clear error info accumulated during probe */
@@ -2799,13 +2810,11 @@ static int ata_eh_revalidate_and_attach(struct ata_link *link,
 			case -ENOENT:
 				/* IDENTIFY was issued to non-existent
 				 * device.  No need to reset.  Just
-				 * thaw and kill the device.
+				 * thaw and ignore the device.
 				 */
 				ata_eh_thaw_port(ap);
-				dev->class = ATA_DEV_UNKNOWN;
 				break;
 			default:
-				dev->class = ATA_DEV_UNKNOWN;
 				goto err;
 			}
 		}
@@ -2826,11 +2835,15 @@ static int ata_eh_revalidate_and_attach(struct ata_link *link,
 		    dev->class == ATA_DEV_PMP)
 			continue;
 
+		dev->class = ehc->classes[dev->devno];
+
 		ehc->i.flags |= ATA_EHI_PRINTINFO;
 		rc = ata_dev_configure(dev);
 		ehc->i.flags &= ~ATA_EHI_PRINTINFO;
-		if (rc)
+		if (rc) {
+			dev->class = ATA_DEV_UNKNOWN;
 			goto err;
+		}
 
 		spin_lock_irqsave(ap->lock, flags);
 		ap->pflags |= ATA_PFLAG_SCSI_HOTPLUG;
