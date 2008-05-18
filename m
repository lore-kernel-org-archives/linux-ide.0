From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 04/10] libata: kill hotplug related race condition
Date: Mon, 19 May 2008 01:15:08 +0900
Message-ID: <12111273181035-git-send-email-htejun@gmail.com>
References: <12111273141039-git-send-email-htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.181]:47696 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754532AbYERQP0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 18 May 2008 12:15:26 -0400
Received: by py-out-1112.google.com with SMTP id u52so1493694pyb.10
        for <linux-ide@vger.kernel.org>; Sun, 18 May 2008 09:15:26 -0700 (PDT)
In-Reply-To: <12111273141039-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org
Cc: liml@rtr.ca, Tejun Heo <htejun@gmail.com>

Originally, whole reset processing was done while the port is frozen
and SError was cleared during @postreset().  This had two race
conditions.  1: hotplug could occur after reset but before SError is
cleared and libata won't know about it.  2: hotplug could occur after
all the reset is complete but before the port is thawed.  As all
events are cleared on thaw, the hotplug event would be lost.

Commit ac371987a81c61c2efbd6931245cdcaf43baad89 kills the first race
by clearing SError during link resume but before link onlineness test.
However, this doesn't fix race #2 and in some cases clearing SError
after SRST is a good idea.

This patch solves this problem by cross checking link onlineness with
classification result after SError is cleared and port is thawed.
Reset is retried if link is online but all devices attached to the
link are unknown.  As all devices will be revalidated, this one-way
check is enough to ensure that all devices are detected and
revalidated reliably.

This, luckily, also fixes the cases where host controller returns
bogus status while harddrive is spinning up after hotplug making
classification run before the device sends the first FIS and thus
causes misdetection.

Low level drivers can bypass the logic by setting class explicitly to
ATA_DEV_NONE if ever necessary (currently none requires this).

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-core.c |   21 +++++++-----------
 drivers/ata/libata-eh.c   |   52 ++++++++++++++++++++++++++++++++++++--------
 2 files changed, 50 insertions(+), 23 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index c6c316f..ffc689d 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -3490,22 +3490,11 @@ int sata_link_resume(struct ata_link *link, const unsigned long *params,
 	if ((rc = sata_link_debounce(link, params, deadline)))
 		return rc;
 
-	/* Clear SError.  PMP and some host PHYs require this to
-	 * operate and clearing should be done before checking PHY
-	 * online status to avoid race condition (hotplugging between
-	 * link resume and status check).
-	 */
+	/* clear SError, some PHYs require this even for SRST to work */
 	if (!(rc = sata_scr_read(link, SCR_ERROR, &serror)))
 		rc = sata_scr_write(link, SCR_ERROR, serror);
-	if (rc == 0 || rc == -EINVAL) {
-		unsigned long flags;
 
-		spin_lock_irqsave(link->ap->lock, flags);
-		link->eh_info.serror = 0;
-		spin_unlock_irqrestore(link->ap->lock, flags);
-		rc = 0;
-	}
-	return rc;
+	return rc != -EINVAL ? rc : 0;
 }
 
 /**
@@ -3704,8 +3693,14 @@ int sata_std_hardreset(struct ata_link *link, unsigned int *class,
  */
 void ata_std_postreset(struct ata_link *link, unsigned int *classes)
 {
+	u32 serror;
+
 	DPRINTK("ENTER\n");
 
+	/* reset complete, clear SError */
+	if (!sata_scr_read(link, SCR_ERROR, &serror))
+		sata_scr_write(link, SCR_ERROR, serror);
+
 	/* print link status */
 	sata_print_link_status(link);
 
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 06a92c5..751dad0 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -2047,19 +2047,11 @@ static int ata_do_reset(struct ata_link *link, ata_reset_fn_t reset,
 			unsigned int *classes, unsigned long deadline)
 {
 	struct ata_device *dev;
-	int rc;
 
 	ata_link_for_each_dev(dev, link)
 		classes[dev->devno] = ATA_DEV_UNKNOWN;
 
-	rc = reset(link, classes, deadline);
-
-	/* convert all ATA_DEV_UNKNOWN to ATA_DEV_NONE */
-	ata_link_for_each_dev(dev, link)
-		if (classes[dev->devno] == ATA_DEV_UNKNOWN)
-			classes[dev->devno] = ATA_DEV_NONE;
-
-	return rc;
+	return reset(link, classes, deadline);
 }
 
 static int ata_eh_followup_srst_needed(struct ata_link *link,
@@ -2096,7 +2088,7 @@ int ata_eh_reset(struct ata_link *link, int classify,
 	ata_reset_fn_t reset;
 	unsigned long flags;
 	u32 sstatus;
-	int rc;
+	int nr_known, rc;
 
 	/*
 	 * Prepare to reset
@@ -2245,9 +2237,49 @@ int ata_eh_reset(struct ata_link *link, int classify,
 	if (ata_is_host_link(link))
 		ata_eh_thaw_port(ap);
 
+	/* postreset() should clear hardware SError.  Although SError
+	 * is cleared during link resume, clearing SError here is
+	 * necessary as some PHYs raise hotplug events after SRST.
+	 * This introduces race condition where hotplug occurs between
+	 * reset and here.  This race is mediated by cross checking
+	 * link onlineness and classification result later.
+	 */
 	if (postreset)
 		postreset(link, classes);
 
+	/* clear cached SError */
+	spin_lock_irqsave(link->ap->lock, flags);
+	link->eh_info.serror = 0;
+	spin_unlock_irqrestore(link->ap->lock, flags);
+
+	/* Make sure onlineness and classification result correspond.
+	 * Hotplug could have happened during reset and some
+	 * controllers fail to wait while a drive is spinning up after
+	 * being hotplugged causing misdetection.  By cross checking
+	 * link onlineness and classification result, those conditions
+	 * can be reliably detected and retried.
+	 */
+	nr_known = 0;
+	ata_link_for_each_dev(dev, link) {
+		/* convert all ATA_DEV_UNKNOWN to ATA_DEV_NONE */
+		if (classes[dev->devno] == ATA_DEV_UNKNOWN)
+			classes[dev->devno] = ATA_DEV_NONE;
+		else
+			nr_known++;
+	}
+
+	if (classify && !nr_known && ata_link_online(link)) {
+		if (try < max_tries) {
+			ata_link_printk(link, KERN_WARNING, "link online but "
+				       "device misclassified, retrying\n");
+			rc = -EAGAIN;
+			goto fail;
+		}
+		ata_link_printk(link, KERN_WARNING,
+			       "link online but device misclassified, "
+			       "device detection might fail\n");
+	}
+
 	/* reset successful, schedule revalidation */
 	ata_eh_done(link, NULL, ATA_EH_RESET);
 	ehc->i.action |= ATA_EH_REVALIDATE;
-- 
1.5.2.4

