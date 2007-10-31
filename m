From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 2/6] libata: cosmetic clean up / reorganization of ata_eh_reset()
Date: Wed, 31 Oct 2007 10:17:03 +0900
Message-ID: <1193793427810-git-send-email-htejun@gmail.com>
References: <11937934273607-git-send-email-htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [222.235.223.38] ([222.235.223.38]:1275 "EHLO htj.dyndns.org"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751375AbXJaBdq (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 30 Oct 2007 21:33:46 -0400
In-Reply-To: <11937934273607-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Clean up and reorganize ata_eh_reset() to ease further changes.

* Cache ARRAY_SIZE(ata_eh_reset_timeouts) in @max_tries.
* Cache link->flags in @lflags.
* Move failure handling block to the end of the function and unnest
  both success and failure handling blocks.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-eh.c |  112 +++++++++++++++++++++++-----------------------
 1 files changed, 56 insertions(+), 56 deletions(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index f1c0117..e0de689 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -2064,16 +2064,19 @@ int ata_eh_reset(struct ata_link *link, int classify,
 		 ata_prereset_fn_t prereset, ata_reset_fn_t softreset,
 		 ata_reset_fn_t hardreset, ata_postreset_fn_t postreset)
 {
+	const int max_tries = ARRAY_SIZE(ata_eh_reset_timeouts);
 	struct ata_port *ap = link->ap;
 	struct ata_eh_context *ehc = &link->eh_context;
 	unsigned int *classes = ehc->classes;
+	unsigned int lflags = link->flags;
 	int verbose = !(ehc->i.flags & ATA_EHI_QUIET);
 	int try = 0;
 	struct ata_device *dev;
-	unsigned long deadline;
+	unsigned long deadline, now;
 	unsigned int tmp_action;
 	ata_reset_fn_t reset;
 	unsigned long flags;
+	u32 sstatus;
 	int rc;
 
 	/* about to reset */
@@ -2086,7 +2089,7 @@ int ata_eh_reset(struct ata_link *link, int classify,
 	/* Determine which reset to use and record in ehc->i.action.
 	 * prereset() may examine and modify it.
 	 */
-	if (softreset && (!hardreset || (!(link->flags & ATA_LFLAG_NO_SRST) &&
+	if (softreset && (!hardreset || (!(lflags & ATA_LFLAG_NO_SRST) &&
 					 !sata_set_spd_needed(link) &&
 					 !(ehc->i.action & ATA_EH_HARDRESET))))
 		tmp_action = ATA_EH_SOFTRESET;
@@ -2168,7 +2171,7 @@ int ata_eh_reset(struct ata_link *link, int classify,
 		rc = ata_do_reset(link, reset, classes, deadline);
 
 		if (rc == 0 && classify && classes[0] == ATA_DEV_UNKNOWN &&
-		    !(link->flags & ATA_LFLAG_ASSUME_CLASS)) {
+		    !(lflags & ATA_LFLAG_ASSUME_CLASS)) {
 			ata_link_printk(link, KERN_ERR,
 					"classification failed\n");
 			rc = -EINVAL;
@@ -2176,67 +2179,42 @@ int ata_eh_reset(struct ata_link *link, int classify,
 		}
 	}
 
-	/* if we skipped follow-up srst, clear rc */
-	if (rc == -EAGAIN)
-		rc = 0;
-
-	if (rc && rc != -ERESTART && try < ARRAY_SIZE(ata_eh_reset_timeouts)) {
-		unsigned long now = jiffies;
+	/* -EAGAIN can happen if we skipped followup SRST */
+	if (rc && rc != -EAGAIN)
+		goto fail;
 
-		if (time_before(now, deadline)) {
-			unsigned long delta = deadline - now;
-
-			ata_link_printk(link, KERN_WARNING, "reset failed "
-				"(errno=%d), retrying in %u secs\n",
-				rc, (jiffies_to_msecs(delta) + 999) / 1000);
+	ata_link_for_each_dev(dev, link) {
+		/* After the reset, the device state is PIO 0 and the
+		 * controller state is undefined.  Reset also wakes up
+		 * drives from sleeping mode.
+		 */
+		dev->pio_mode = XFER_PIO_0;
+		dev->flags &= ~ATA_DFLAG_SLEEPING;
 
-			while (delta)
-				delta = schedule_timeout_uninterruptible(delta);
-		}
+		if (ata_link_offline(link))
+			continue;
 
-		if (rc == -EPIPE ||
-		    try == ARRAY_SIZE(ata_eh_reset_timeouts) - 1)
-			sata_down_spd_limit(link);
-		if (hardreset)
-			reset = hardreset;
-		goto retry;
+		/* apply class override and convert UNKNOWN to NONE */
+		if (lflags & ATA_LFLAG_ASSUME_ATA)
+			classes[dev->devno] = ATA_DEV_ATA;
+		else if (lflags & ATA_LFLAG_ASSUME_SEMB)
+			classes[dev->devno] = ATA_DEV_SEMB_UNSUP; /* not yet */
+		else if (classes[dev->devno] == ATA_DEV_UNKNOWN)
+			classes[dev->devno] = ATA_DEV_NONE;
 	}
 
-	if (rc == 0) {
-		u32 sstatus;
+	/* record current link speed */
+	if (sata_scr_read(link, SCR_STATUS, &sstatus) == 0)
+		link->sata_spd = (sstatus >> 4) & 0xf;
 
-		ata_link_for_each_dev(dev, link) {
-			/* After the reset, the device state is PIO 0
-			 * and the controller state is undefined.
-			 * Reset also wakes up drives from sleeping
-			 * mode.
-			 */
-			dev->pio_mode = XFER_PIO_0;
-			dev->flags &= ~ATA_DFLAG_SLEEPING;
+	if (postreset)
+		postreset(link, classes);
 
-			if (ata_link_offline(link))
-				continue;
+	/* reset successful, schedule revalidation */
+	ata_eh_done(link, NULL, ehc->i.action & ATA_EH_RESET_MASK);
+	ehc->i.action |= ATA_EH_REVALIDATE;
 
-			/* apply class override and convert UNKNOWN to NONE */
-			if (link->flags & ATA_LFLAG_ASSUME_ATA)
-				classes[dev->devno] = ATA_DEV_ATA;
-			else if (link->flags & ATA_LFLAG_ASSUME_SEMB)
-				classes[dev->devno] = ATA_DEV_SEMB_UNSUP; /* not yet */
-			else if (classes[dev->devno] == ATA_DEV_UNKNOWN)
-				classes[dev->devno] = ATA_DEV_NONE;
-		}
-
-		/* record current link speed */
-		if (sata_scr_read(link, SCR_STATUS, &sstatus) == 0)
-			link->sata_spd = (sstatus >> 4) & 0xf;
-
-		if (postreset)
-			postreset(link, classes);
-
-		/* reset successful, schedule revalidation */
-		ata_eh_done(link, NULL, ehc->i.action & ATA_EH_RESET_MASK);
-		ehc->i.action |= ATA_EH_REVALIDATE;
-	}
+	rc = 0;
  out:
 	/* clear hotplug flag */
 	ehc->i.flags &= ~ATA_EHI_HOTPLUGGED;
@@ -2246,6 +2224,28 @@ int ata_eh_reset(struct ata_link *link, int classify,
 	spin_unlock_irqrestore(ap->lock, flags);
 
 	return rc;
+
+ fail:
+	if (rc == -ERESTART || try >= max_tries)
+		goto out;
+
+	now = jiffies;
+	if (time_before(now, deadline)) {
+		unsigned long delta = deadline - now;
+
+		ata_link_printk(link, KERN_WARNING, "reset failed "
+				"(errno=%d), retrying in %u secs\n",
+				rc, (jiffies_to_msecs(delta) + 999) / 1000);
+
+		while (delta)
+			delta = schedule_timeout_uninterruptible(delta);
+	}
+
+	if (rc == -EPIPE || try == max_tries - 1)
+		sata_down_spd_limit(link);
+	if (hardreset)
+		reset = hardreset;
+	goto retry;
 }
 
 static int ata_eh_revalidate_and_attach(struct ata_link *link,
-- 
1.5.2.4

