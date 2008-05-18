From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 02/10] libata: reorganize ata_eh_reset() no reset method path
Date: Mon, 19 May 2008 01:15:06 +0900
Message-ID: <12111273151006-git-send-email-htejun@gmail.com>
References: <12111273141039-git-send-email-htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.178]:47396 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752363AbYERQPW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 18 May 2008 12:15:22 -0400
Received: by py-out-1112.google.com with SMTP id u52so1493698pyb.10
        for <linux-ide@vger.kernel.org>; Sun, 18 May 2008 09:15:22 -0700 (PDT)
In-Reply-To: <12111273141039-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org
Cc: liml@rtr.ca, Tejun Heo <htejun@gmail.com>

Reorganize ata_eh_reset() such that @prereset() is called even when no
reset method is available and if block is used instead of goto to skip
actual reset.  This makes no reset case behave better (readiness wait)
and future changes easier.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-eh.c |  102 ++++++++++++++++++++++++-----------------------
 1 files changed, 52 insertions(+), 50 deletions(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 62e0331..a34adc2 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -2098,7 +2098,9 @@ int ata_eh_reset(struct ata_link *link, int classify,
 	u32 sstatus;
 	int rc;
 
-	/* about to reset */
+	/*
+	 * Prepare to reset
+	 */
 	spin_lock_irqsave(ap->lock, flags);
 	ap->pflags |= ATA_PFLAG_RESETTING;
 	spin_unlock_irqrestore(ap->lock, flags);
@@ -2124,16 +2126,8 @@ int ata_eh_reset(struct ata_link *link, int classify,
 			ap->ops->set_piomode(ap, dev);
 	}
 
-	if (!softreset && !hardreset) {
-		if (verbose)
-			ata_link_printk(link, KERN_INFO, "no reset method "
-					"available, skipping reset\n");
-		if (!(lflags & ATA_LFLAG_ASSUME_CLASS))
-			lflags |= ATA_LFLAG_ASSUME_ATA;
-		goto done;
-	}
-
 	/* prefer hardreset */
+	reset = NULL;
 	ehc->i.action &= ~ATA_EH_RESET;
 	if (hardreset) {
 		reset = hardreset;
@@ -2141,11 +2135,6 @@ int ata_eh_reset(struct ata_link *link, int classify,
 	} else if (softreset) {
 		reset = softreset;
 		ehc->i.action = ATA_EH_SOFTRESET;
-	} else {
-		ata_link_printk(link, KERN_ERR, "BUG: no reset method, "
-				"please report to linux-ide@vger.kernel.org\n");
-		dump_stack();
-		return -EINVAL;
 	}
 
 	if (prereset) {
@@ -2165,55 +2154,68 @@ int ata_eh_reset(struct ata_link *link, int classify,
 					"prereset failed (errno=%d)\n", rc);
 			goto out;
 		}
-	}
 
-	/* prereset() might have cleared ATA_EH_RESET */
-	if (!(ehc->i.action & ATA_EH_RESET)) {
-		/* prereset told us not to reset, bang classes and return */
-		ata_link_for_each_dev(dev, link)
-			classes[dev->devno] = ATA_DEV_NONE;
-		rc = 0;
-		goto out;
+		/* prereset() might have cleared ATA_EH_RESET.  If so,
+		 * bang classes and return.
+		 */
+		if (reset && !(ehc->i.action & ATA_EH_RESET)) {
+			ata_link_for_each_dev(dev, link)
+				classes[dev->devno] = ATA_DEV_NONE;
+			rc = 0;
+			goto out;
+		}
 	}
 
  retry:
+	/*
+	 * Perform reset
+	 */
 	deadline = jiffies + ata_eh_reset_timeouts[try++];
 
-	/* shut up during boot probing */
-	if (verbose)
-		ata_link_printk(link, KERN_INFO, "%s resetting link\n",
-				reset == softreset ? "soft" : "hard");
+	if (reset) {
+		if (verbose)
+			ata_link_printk(link, KERN_INFO, "%s resetting link\n",
+					reset == softreset ? "soft" : "hard");
 
-	/* mark that this EH session started with reset */
-	if (reset == hardreset)
-		ehc->i.flags |= ATA_EHI_DID_HARDRESET;
-	else
-		ehc->i.flags |= ATA_EHI_DID_SOFTRESET;
+		/* mark that this EH session started with reset */
+		if (reset == hardreset)
+			ehc->i.flags |= ATA_EHI_DID_HARDRESET;
+		else
+			ehc->i.flags |= ATA_EHI_DID_SOFTRESET;
 
-	rc = ata_do_reset(link, reset, classes, deadline);
+		rc = ata_do_reset(link, reset, classes, deadline);
 
-	if (reset == hardreset &&
-	    ata_eh_followup_srst_needed(link, rc, classify, classes)) {
-		/* okay, let's do follow-up softreset */
-		reset = softreset;
+		if (reset == hardreset &&
+		    ata_eh_followup_srst_needed(link, rc, classify, classes)) {
+			/* okay, let's do follow-up softreset */
+			reset = softreset;
 
-		if (!reset) {
-			ata_link_printk(link, KERN_ERR,
-					"follow-up softreset required "
-					"but no softreset avaliable\n");
-			rc = -EINVAL;
-			goto fail;
+			if (!reset) {
+				ata_link_printk(link, KERN_ERR,
+						"follow-up softreset required "
+						"but no softreset avaliable\n");
+				rc = -EINVAL;
+				goto fail;
+			}
+
+			ata_eh_about_to_do(link, NULL, ATA_EH_RESET);
+			rc = ata_do_reset(link, reset, classes, deadline);
 		}
 
-		ata_eh_about_to_do(link, NULL, ATA_EH_RESET);
-		rc = ata_do_reset(link, reset, classes, deadline);
+		/* -EAGAIN can happen if we skipped followup SRST */
+		if (rc && rc != -EAGAIN)
+			goto fail;
+	} else {
+		if (verbose)
+			ata_link_printk(link, KERN_INFO, "no reset method "
+					"available, skipping reset\n");
+		if (!(lflags & ATA_LFLAG_ASSUME_CLASS))
+			lflags |= ATA_LFLAG_ASSUME_ATA;
 	}
 
-	/* -EAGAIN can happen if we skipped followup SRST */
-	if (rc && rc != -EAGAIN)
-		goto fail;
-
- done:
+	/*
+	 * Post-reset processing
+	 */
 	ata_link_for_each_dev(dev, link) {
 		/* After the reset, the device state is PIO 0 and the
 		 * controller state is undefined.  Reset also wakes up
-- 
1.5.2.4

