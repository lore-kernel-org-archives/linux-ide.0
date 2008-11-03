From: Tejun Heo <tj@kernel.org>
Subject: [PATCH #upstream 3/3] libata: perform port detach in EH
Date: Mon, 03 Nov 2008 20:04:37 +0900
Message-ID: <490EDAC5.7090402@kernel.org>
References: <490EDA75.5060703@kernel.org> <490EDA95.6070409@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:40201 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754981AbYKCLEu (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 3 Nov 2008 06:04:50 -0500
In-Reply-To: <490EDA95.6070409@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik l <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, Mark Lord <liml@rtr.ca>, Elias Oltmanns <eo@nebensachen.de>

ata_port_detach() first made sure EH saw ATA_PFLAG_UNLOADING and then
assumed EH context belongs to it and performed detach operation
itself.  However, UNLOADING doesn't disable all of EH and this could
lead to problems including triggering WARN_ON()'s in EH path.

This patch makes port detach behave more like other EH actions such
that ata_port_detach() requests EH to detach and waits for completion.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 drivers/ata/libata-core.c |   23 ++++-------------------
 drivers/ata/libata-eh.c   |   32 +++++++++++++++++++++++++++++++-
 include/linux/libata.h    |    3 ++-
 3 files changed, 37 insertions(+), 21 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 0e03644..faf796e 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -5979,8 +5979,6 @@ int ata_host_activate(struct ata_host *host, int irq,
 static void ata_port_detach(struct ata_port *ap)
 {
 	unsigned long flags;
-	struct ata_link *link;
-	struct ata_device *dev;
 
 	if (!ap->ops->error_handler)
 		goto skip_eh;
@@ -5988,28 +5986,15 @@ static void ata_port_detach(struct ata_port *ap)
 	/* tell EH we're leaving & flush EH */
 	spin_lock_irqsave(ap->lock, flags);
 	ap->pflags |= ATA_PFLAG_UNLOADING;
+	ata_port_schedule_eh(ap);
 	spin_unlock_irqrestore(ap->lock, flags);
 
+	/* wait till EH commits suicide */
 	ata_port_wait_eh(ap);
 
-	/* EH is now guaranteed to see UNLOADING - EH context belongs
-	 * to us.  Restore SControl and disable all existing devices.
-	 */
-	ata_for_each_link(link, ap, PMP_FIRST) {
-		sata_scr_write(link, SCR_CONTROL, link->saved_scontrol & 0xff0);
-		ata_for_each_dev(dev, link, ALL)
-			ata_dev_disable(dev);
-	}
-
-	/* Final freeze & EH.  All in-flight commands are aborted.  EH
-	 * will be skipped and retrials will be terminated with bad
-	 * target.
-	 */
-	spin_lock_irqsave(ap->lock, flags);
-	ata_port_freeze(ap);	/* won't be thawed */
-	spin_unlock_irqrestore(ap->lock, flags);
+	/* it better be dead now */
+	WARN_ON(!(ap->pflags & ATA_PFLAG_UNLOADED));
 
-	ata_port_wait_eh(ap);
 	cancel_rearming_delayed_work(&ap->hotplug_task);
 
  skip_eh:
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 82f4be3..6b05809 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -491,6 +491,31 @@ enum blk_eh_timer_return ata_scsi_timed_out(struct scsi_cmnd *cmd)
 	return ret;
 }
 
+static void ata_eh_unload(struct ata_port *ap)
+{
+	struct ata_link *link;
+	struct ata_device *dev;
+	unsigned long flags;
+
+	/* Restore SControl IPM and SPD for the next driver and
+	 * disable attached devices.
+	 */
+	ata_for_each_link(link, ap, PMP_FIRST) {
+		sata_scr_write(link, SCR_CONTROL, link->saved_scontrol & 0xff0);
+		ata_for_each_dev(dev, link, ALL)
+			ata_dev_disable(dev);
+	}
+
+	/* freeze and set UNLOADED */
+	spin_lock_irqsave(ap->lock, flags);
+
+	ata_port_freeze(ap);			/* won't be thawed */
+	ap->pflags &= ~ATA_PFLAG_EH_PENDING;	/* clear pending from freeze */
+	ap->pflags |= ATA_PFLAG_UNLOADED;
+
+	spin_unlock_irqrestore(ap->lock, flags);
+}
+
 /**
  *	ata_scsi_error - SCSI layer error handler callback
  *	@host: SCSI host on which error occurred
@@ -621,8 +646,13 @@ void ata_scsi_error(struct Scsi_Host *host)
 		/* invoke EH, skip if unloading or suspended */
 		if (!(ap->pflags & (ATA_PFLAG_UNLOADING | ATA_PFLAG_SUSPENDED)))
 			ap->ops->error_handler(ap);
-		else
+		else {
+			/* if unloading, commence suicide */
+			if ((ap->pflags & ATA_PFLAG_UNLOADING) &&
+			    !(ap->pflags & ATA_PFLAG_UNLOADED))
+				ata_eh_unload(ap);
 			ata_eh_finish(ap);
+		}
 
 		/* process port suspend request */
 		ata_eh_handle_port_suspend(ap);
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 49cca60..8b0ee24 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -215,10 +215,11 @@ enum {
 	ATA_PFLAG_FROZEN	= (1 << 2), /* port is frozen */
 	ATA_PFLAG_RECOVERED	= (1 << 3), /* recovery action performed */
 	ATA_PFLAG_LOADING	= (1 << 4), /* boot/loading probe */
-	ATA_PFLAG_UNLOADING	= (1 << 5), /* module is unloading */
 	ATA_PFLAG_SCSI_HOTPLUG	= (1 << 6), /* SCSI hotplug scheduled */
 	ATA_PFLAG_INITIALIZING	= (1 << 7), /* being initialized, don't touch */
 	ATA_PFLAG_RESETTING	= (1 << 8), /* reset in progress */
+	ATA_PFLAG_UNLOADING	= (1 << 9), /* driver is being unloaded */
+	ATA_PFLAG_UNLOADED	= (1 << 10), /* driver is unloaded */
 
 	ATA_PFLAG_SUSPENDED	= (1 << 17), /* port is suspended (power) */
 	ATA_PFLAG_PM_PENDING	= (1 << 18), /* PM operation pending */
-- 
1.5.4.5

