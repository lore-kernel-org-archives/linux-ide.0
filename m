From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 05/12] libata-pmp-prep: implement ops->qc_defer()
Date: Sun, 23 Sep 2007 13:14:12 +0900
Message-ID: <119052085260-git-send-email-htejun@gmail.com>
References: <11905208513747-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.176]:63937 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752628AbXIWEOZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 23 Sep 2007 00:14:25 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1545849wah
        for <linux-ide@vger.kernel.org>; Sat, 22 Sep 2007 21:14:25 -0700 (PDT)
In-Reply-To: <11905208513747-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Controllers which support PMP have various restrictions on which
combinations of commands are allowed to what number of devices
concurrently.  This patch implements ops->qc_defer() which determines
whether a qc can be issued at the moment or should be deferred.

If the function returns ATA_DEFER_LINK, the qc will be deferred until
a qc completes on the link.  If ATA_DEFER_PORT, until a qc completes
on any link.  The defer conditions are advisory and in general
ATA_DEFER_LINK can be considered as lower priority deferring than
ATA_DEFER_PORT.

ops->qc_defer() replaces fixed ata_scmd_need_defer().  For standard
NCQ/non-NCQ exclusion, ata_std_qc_defer() is implemented.  ahci and
sata_sil24 are converted to use ata_std_qc_defer().

ops->qc_defer() is heavier than the original mechanism because full qc
is prepped before determining to defer it, but various information is
needed to determine defer conditinos and fully translating a qc is the
only way to supply such information in generic manner.

IMHO, this shouldn't cause any noticeable performance issues as

* for most cases deferring occurs rarely (except for NCQ-aware
  cmd-switching PMP)
* translation itself isn't that expensive
* once deferred the command won't be repeated until another command
  completes which usually is a very long time cpu-wise.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/ahci.c        |    2 +
 drivers/ata/libata-core.c |   31 ++++++++++++++++++++++
 drivers/ata/libata-scsi.c |   62 +++++++++++++++++++--------------------------
 drivers/ata/sata_nv.c     |    1 +
 drivers/ata/sata_sil24.c  |    1 +
 include/linux/libata.h    |    6 ++++
 6 files changed, 67 insertions(+), 36 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 0a6b694..cf34044 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -268,6 +268,7 @@ static const struct ata_port_operations ahci_ops = {
 
 	.tf_read		= ahci_tf_read,
 
+	.qc_defer		= ata_std_qc_defer,
 	.qc_prep		= ahci_qc_prep,
 	.qc_issue		= ahci_qc_issue,
 
@@ -298,6 +299,7 @@ static const struct ata_port_operations ahci_vt8251_ops = {
 
 	.tf_read		= ahci_tf_read,
 
+	.qc_defer		= ata_std_qc_defer,
 	.qc_prep		= ahci_qc_prep,
 	.qc_issue		= ahci_qc_issue,
 
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index c33a1f8..7dd666e 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4348,6 +4348,36 @@ int ata_check_atapi_dma(struct ata_queued_cmd *qc)
 }
 
 /**
+ *	ata_std_qc_defer - Check whether a qc needs to be deferred
+ *	@qc: ATA command in question
+ *
+ *	Non-NCQ commands cannot run with any other command, NCQ or
+ *	not.  As upper layer only knows the queue depth, we are
+ *	responsible for maintaining exclusion.  This function checks
+ *	whether a new command @qc can be issued.
+ *
+ *	LOCKING:
+ *	spin_lock_irqsave(host lock)
+ *
+ *	RETURNS:
+ *	ATA_DEFER_* if deferring is needed, 0 otherwise.
+ */
+int ata_std_qc_defer(struct ata_queued_cmd *qc)
+{
+	struct ata_link *link = qc->dev->link;
+
+	if (qc->tf.protocol == ATA_PROT_NCQ) {
+		if (!ata_tag_valid(link->active_tag))
+			return 0;
+	} else {
+		if (!ata_tag_valid(link->active_tag) && !link->sactive)
+			return 0;
+	}
+
+	return ATA_DEFER_LINK;
+}
+
+/**
  *	ata_qc_prep - Prepare taskfile for submission
  *	@qc: Metadata associated with taskfile to be prepared
  *
@@ -7113,6 +7143,7 @@ EXPORT_SYMBOL_GPL(ata_interrupt);
 EXPORT_SYMBOL_GPL(ata_do_set_mode);
 EXPORT_SYMBOL_GPL(ata_data_xfer);
 EXPORT_SYMBOL_GPL(ata_data_xfer_noirq);
+EXPORT_SYMBOL_GPL(ata_std_qc_defer);
 EXPORT_SYMBOL_GPL(ata_qc_prep);
 EXPORT_SYMBOL_GPL(ata_dumb_qc_prep);
 EXPORT_SYMBOL_GPL(ata_noop_qc_prep);
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 518d475..eb611b4 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -750,6 +750,13 @@ static void ata_scsi_sdev_config(struct scsi_device *sdev)
 {
 	sdev->use_10_for_rw = 1;
 	sdev->use_10_for_ms = 1;
+
+	/* Schedule policy is determined by ->qc_defer() callback and
+	 * it needs to see every deferred qc.  Set dev_blocked to 1 to
+	 * prevent SCSI midlayer from automatically deferring
+	 * requests.
+	 */
+	sdev->max_device_blocked = 1;
 }
 
 static void ata_scsi_dev_config(struct scsi_device *sdev,
@@ -1417,37 +1424,6 @@ static void ata_scsi_qc_complete(struct ata_queued_cmd *qc)
 }
 
 /**
- *	ata_scmd_need_defer - Check whether we need to defer scmd
- *	@dev: ATA device to which the command is addressed
- *	@is_io: Is the command IO (and thus possibly NCQ)?
- *
- *	NCQ and non-NCQ commands cannot run together.  As upper layer
- *	only knows the queue depth, we are responsible for maintaining
- *	exclusion.  This function checks whether a new command can be
- *	issued to @dev.
- *
- *	LOCKING:
- *	spin_lock_irqsave(host lock)
- *
- *	RETURNS:
- *	1 if deferring is needed, 0 otherwise.
- */
-static int ata_scmd_need_defer(struct ata_device *dev, int is_io)
-{
-	struct ata_link *link = dev->link;
-	int is_ncq = is_io && ata_ncq_enabled(dev);
-
-	if (is_ncq) {
-		if (!ata_tag_valid(link->active_tag))
-			return 0;
-	} else {
-		if (!ata_tag_valid(link->active_tag) && !link->sactive)
-			return 0;
-	}
-	return 1;
-}
-
-/**
  *	ata_scsi_translate - Translate then issue SCSI command to ATA device
  *	@dev: ATA device to which the command is addressed
  *	@cmd: SCSI command to execute
@@ -1478,14 +1454,12 @@ static int ata_scsi_translate(struct ata_device *dev, struct scsi_cmnd *cmd,
 			      void (*done)(struct scsi_cmnd *),
 			      ata_xlat_func_t xlat_func)
 {
+	struct ata_port *ap = dev->link->ap;
 	struct ata_queued_cmd *qc;
-	int is_io = xlat_func == ata_scsi_rw_xlat;
+	int rc;
 
 	VPRINTK("ENTER\n");
 
-	if (unlikely(ata_scmd_need_defer(dev, is_io)))
-		goto defer;
-
 	qc = ata_scsi_qc_new(dev, cmd, done);
 	if (!qc)
 		goto err_mem;
@@ -1509,6 +1483,11 @@ static int ata_scsi_translate(struct ata_device *dev, struct scsi_cmnd *cmd,
 	if (xlat_func(qc))
 		goto early_finish;
 
+	if (ap->ops->qc_defer) {
+		if ((rc = ap->ops->qc_defer(qc)))
+			goto defer;
+	}
+
 	/* select device, send command to hardware */
 	ata_qc_issue(qc);
 
@@ -1530,8 +1509,12 @@ err_mem:
 	return 0;
 
 defer:
+	ata_qc_free(qc);
 	DPRINTK("EXIT - defer\n");
-	return SCSI_MLQUEUE_DEVICE_BUSY;
+	if (rc == ATA_DEFER_LINK)
+		return SCSI_MLQUEUE_DEVICE_BUSY;
+	else
+		return SCSI_MLQUEUE_HOST_BUSY;
 }
 
 /**
@@ -2957,6 +2940,13 @@ int ata_scsi_add_hosts(struct ata_host *host, struct scsi_host_template *sht)
 		shost->max_channel = 1;
 		shost->max_cmd_len = 16;
 
+		/* Schedule policy is determined by ->qc_defer()
+		 * callback and it needs to see every deferred qc.
+		 * Set host_blocked to 1 to prevent SCSI midlayer from
+		 * automatically deferring requests.
+		 */
+		shost->max_host_blocked = 1;
+
 		rc = scsi_add_host(ap->scsi_host, ap->host->dev);
 		if (rc)
 			goto err_add;
diff --git a/drivers/ata/sata_nv.c b/drivers/ata/sata_nv.c
index b860f99..40557fe 100644
--- a/drivers/ata/sata_nv.c
+++ b/drivers/ata/sata_nv.c
@@ -423,6 +423,7 @@ static const struct ata_port_operations nv_adma_ops = {
 	.bmdma_start		= ata_bmdma_start,
 	.bmdma_stop		= ata_bmdma_stop,
 	.bmdma_status		= ata_bmdma_status,
+	.qc_defer		= ata_std_qc_defer,
 	.qc_prep		= nv_adma_qc_prep,
 	.qc_issue		= nv_adma_qc_issue,
 	.freeze			= nv_adma_freeze,
diff --git a/drivers/ata/sata_sil24.c b/drivers/ata/sata_sil24.c
index d9c010a..9acfce4 100644
--- a/drivers/ata/sata_sil24.c
+++ b/drivers/ata/sata_sil24.c
@@ -393,6 +393,7 @@ static const struct ata_port_operations sil24_ops = {
 
 	.tf_read		= sil24_tf_read,
 
+	.qc_defer		= ata_std_qc_defer,
 	.qc_prep		= sil24_qc_prep,
 	.qc_issue		= sil24_qc_issue,
 
diff --git a/include/linux/libata.h b/include/linux/libata.h
index c3820f1..b0d4ca0 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -272,6 +272,10 @@ enum {
 	/* ering size */
 	ATA_ERING_SIZE		= 32,
 
+	/* return values for ->qc_defer */
+	ATA_DEFER_LINK		= 1,
+	ATA_DEFER_PORT		= 2,
+
 	/* desc_len for ata_eh_info and context */
 	ATA_EH_DESC_LEN		= 80,
 
@@ -639,6 +643,7 @@ struct ata_port_operations {
 
 	void (*data_xfer) (struct ata_device *, unsigned char *, unsigned int, int);
 
+	int (*qc_defer) (struct ata_queued_cmd *qc);
 	void (*qc_prep) (struct ata_queued_cmd *qc);
 	unsigned int (*qc_issue) (struct ata_queued_cmd *qc);
 
@@ -824,6 +829,7 @@ extern void ata_data_xfer(struct ata_device *adev, unsigned char *buf,
 			  unsigned int buflen, int write_data);
 extern void ata_data_xfer_noirq(struct ata_device *adev, unsigned char *buf,
 				unsigned int buflen, int write_data);
+extern int ata_std_qc_defer(struct ata_queued_cmd *qc);
 extern void ata_dumb_qc_prep(struct ata_queued_cmd *qc);
 extern void ata_qc_prep(struct ata_queued_cmd *qc);
 extern void ata_noop_qc_prep(struct ata_queued_cmd *qc);
-- 
1.5.0.3


