From: Tejun Heo <tj@kernel.org>
Subject: [PATCH 2/8] libata: move ata_dev_disable() to libata-eh.c
Date: Thu, 29 Jan 2009 20:31:30 +0900
Message-ID: <1233228696-10562-3-git-send-email-tj@kernel.org>
References: <1233228696-10562-1-git-send-email-tj@kernel.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:34095 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752507AbZA2LcA (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 29 Jan 2009 06:32:00 -0500
In-Reply-To: <1233228696-10562-1-git-send-email-tj@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>

ata_dev_disable() is about to be more tightly integrated into EH
logic.  Move it to libata-eh.c.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 drivers/ata/libata-core.c |   12 ------------
 drivers/ata/libata-eh.c   |   21 +++++++++++++++++++++
 drivers/ata/libata.h      |    2 +-
 3 files changed, 22 insertions(+), 13 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 71218d7..20d0e27 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -1015,18 +1015,6 @@ static const char *sata_spd_string(unsigned int spd)
 	return spd_str[spd - 1];
 }
 
-void ata_dev_disable(struct ata_device *dev)
-{
-	if (ata_dev_enabled(dev)) {
-		if (ata_msg_drv(dev->link->ap))
-			ata_dev_printk(dev, KERN_WARNING, "disabled\n");
-		ata_acpi_on_disable(dev);
-		ata_down_xfermask_limit(dev, ATA_DNXFER_FORCE_PIO0 |
-					     ATA_DNXFER_QUIET);
-		dev->class++;
-	}
-}
-
 static int ata_dev_set_dipm(struct ata_device *dev, enum link_pm policy)
 {
 	struct ata_link *link = dev->link;
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index c15572d..aafe82b 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -1176,6 +1176,27 @@ void ata_eh_qc_retry(struct ata_queued_cmd *qc)
 }
 
 /**
+ *	ata_dev_disable - disable ATA device
+ *	@dev: ATA device to disable
+ *
+ *	Disable @dev.
+ *
+ *	Locking:
+ *	EH context.
+ */
+void ata_dev_disable(struct ata_device *dev)
+{
+	if (!ata_dev_enabled(dev))
+		return;
+
+	if (ata_msg_drv(dev->link->ap))
+		ata_dev_printk(dev, KERN_WARNING, "disabled\n");
+	ata_acpi_on_disable(dev);
+	ata_down_xfermask_limit(dev, ATA_DNXFER_FORCE_PIO0 | ATA_DNXFER_QUIET);
+	dev->class++;
+}
+
+/**
  *	ata_eh_detach_dev - detach ATA device
  *	@dev: ATA device to detach
  *
diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
index fe2839e..0a6f5be 100644
--- a/drivers/ata/libata.h
+++ b/drivers/ata/libata.h
@@ -79,7 +79,6 @@ extern int ata_build_rw_tf(struct ata_taskfile *tf, struct ata_device *dev,
 			   u64 block, u32 n_block, unsigned int tf_flags,
 			   unsigned int tag);
 extern u64 ata_tf_read_block(struct ata_taskfile *tf, struct ata_device *dev);
-extern void ata_dev_disable(struct ata_device *dev);
 extern void ata_pio_queue_task(struct ata_port *ap, void *data,
 			       unsigned long delay);
 extern void ata_port_flush_task(struct ata_port *ap);
@@ -160,6 +159,7 @@ extern void ata_scsi_error(struct Scsi_Host *host);
 extern void ata_port_wait_eh(struct ata_port *ap);
 extern void ata_eh_fastdrain_timerfn(unsigned long arg);
 extern void ata_qc_schedule_eh(struct ata_queued_cmd *qc);
+extern void ata_dev_disable(struct ata_device *dev);
 extern void ata_eh_detach_dev(struct ata_device *dev);
 extern void ata_eh_about_to_do(struct ata_link *link, struct ata_device *dev,
 			       unsigned int action);
-- 
1.6.0.2

