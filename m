From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 05/15] libata-hp: implement ata_scsi_slave_destroy()
Date: Tue, 11 Apr 2006 23:14:07 +0900
Message-ID: <11447648471249-git-send-email-htejun@gmail.com>
References: <1144764846705-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pproxy.gmail.com ([64.233.166.176]:16055 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751289AbWDKOOQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 11 Apr 2006 10:14:16 -0400
Received: by pproxy.gmail.com with SMTP id i49so1396236pye
        for <linux-ide@vger.kernel.org>; Tue, 11 Apr 2006 07:14:15 -0700 (PDT)
In-Reply-To: <1144764846705-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, lkosewsk@gmail.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

This function is called during sdev removal by SCSI midlayer.  For
user-initiated removals, this is the only indication we get from SCSI
midlayer that the sdev is going away.  In such cases, schedule ATA
detach and invoke EH.  For libata-initiated removal, nothing needs to
be done.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |    1 +
 drivers/scsi/libata-eh.c   |   15 ++++++++++++---
 drivers/scsi/libata-scsi.c |   33 +++++++++++++++++++++++++++++++++
 include/linux/libata.h     |    1 +
 4 files changed, 47 insertions(+), 3 deletions(-)

50661abaf2563e89f2277c7e39c817123459779f
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 91a01ca..87a6579 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -5452,6 +5452,7 @@ EXPORT_SYMBOL_GPL(ata_port_queue_task);
 EXPORT_SYMBOL_GPL(ata_scsi_ioctl);
 EXPORT_SYMBOL_GPL(ata_scsi_queuecmd);
 EXPORT_SYMBOL_GPL(ata_scsi_slave_config);
+EXPORT_SYMBOL_GPL(ata_scsi_slave_destroy);
 EXPORT_SYMBOL_GPL(ata_scsi_change_queue_depth);
 EXPORT_SYMBOL_GPL(ata_scsi_release);
 EXPORT_SYMBOL_GPL(ata_host_intr);
diff --git a/drivers/scsi/libata-eh.c b/drivers/scsi/libata-eh.c
index 64edf48..6a61c5c 100644
--- a/drivers/scsi/libata-eh.c
+++ b/drivers/scsi/libata-eh.c
@@ -175,7 +175,7 @@ int ata_scsi_error(struct Scsi_Host *hos
 {
 	struct ata_port *ap = (struct ata_port *)&host->hostdata[0];
 	spinlock_t *hs_lock = &ap->host_set->lock;
-	int repeat_cnt = ATA_EH_MAX_REPEAT;
+	int i, repeat_cnt = ATA_EH_MAX_REPEAT;
 	unsigned long flags;
 
 	DPRINTK("ENTER\n");
@@ -185,10 +185,19 @@ int ata_scsi_error(struct Scsi_Host *hos
 	spin_unlock_wait(hs_lock);
 	ata_port_flush_task(ap);
 
+	/* Scheduled to be detached but not disabled status happens
+	 * only for devices user requested to be detached via
+	 * slave_destroy.  Make sure they are disabled.
+	 */
+	for (i = 0; i < ATA_MAX_DEVICES; i++) {
+		struct ata_device *dev = &ap->device[i];
+
+		if (dev->flags & ATA_DFLAG_DETACH_ATA)
+			ata_dev_disable(ap, dev);
+	}
+
 	/* invoke error handler */
 	if (ap->ops->error_handler) {
-		int i;
-
 		/* for new EH, all the qc's are ours now */
 		for (i = 0; i < ATA_MAX_QUEUE; i++) {
 			struct ata_queued_cmd *qc;
diff --git a/drivers/scsi/libata-scsi.c b/drivers/scsi/libata-scsi.c
index fac37cd..5e68305 100644
--- a/drivers/scsi/libata-scsi.c
+++ b/drivers/scsi/libata-scsi.c
@@ -723,6 +723,39 @@ int ata_scsi_slave_config(struct scsi_de
 }
 
 /**
+ *	ata_scsi_slave_destroy - SCSI device is about to be destroyed
+ *	@sdev: SCSI device to be destroyed
+ *
+ *	@sdev is about to be destroyed for hot/warm unplugging.  If
+ *	this unplugging was initiated by libata as indicated by NULL
+ *	dev->sdev, this function doesn't have to do anything.
+ *	Otherwise, SCSI layer initiated warm-unplug is in progress.
+ *	Clear dev->sdev, schedule the device for ATA detach and invoke
+ *	EH.
+ *
+ *	LOCKING:
+ *	Defined by SCSI layer.  We don't really care.
+ */
+void ata_scsi_slave_destroy(struct scsi_device *sdev)
+{
+	struct ata_port *ap = (struct ata_port *)&sdev->host->hostdata[0];
+	unsigned long flags;
+	struct ata_device *dev;
+
+	if (!ap->ops->error_handler)
+		return;
+
+	spin_lock_irqsave(&ap->host_set->lock, flags);
+	dev = __ata_scsi_find_dev(ap, sdev);
+	if (dev && dev->sdev) {
+		dev->sdev = NULL;
+		dev->flags |= ATA_DFLAG_DETACH_ATA;
+		ata_eh_schedule_port(ap, ATA_EH_FREEZE);
+	}
+	spin_unlock_irqrestore(&ap->host_set->lock, flags);
+}
+
+/**
  *	ata_scsi_change_queue_depth - SCSI callback for queue depth config
  *	@sdev: SCSI device to configure queue depth for
  *	@queue_depth: new queue depth
diff --git a/include/linux/libata.h b/include/linux/libata.h
index f145f0e..84162b2 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -663,6 +663,7 @@ extern int ata_std_bios_param(struct scs
 			      struct block_device *bdev,
 			      sector_t capacity, int geom[]);
 extern int ata_scsi_slave_config(struct scsi_device *sdev);
+extern void ata_scsi_slave_destroy(struct scsi_device *sdev);
 extern int ata_scsi_change_queue_depth(struct scsi_device *sdev,
 				       int queue_depth);
 extern struct ata_device *ata_dev_pair(struct ata_port *ap, 
-- 
1.2.4


