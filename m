From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 05/12] libata-pmp-prep: implement ops->qc_defer()
Date: Sun, 1 Jul 2007 19:26:08 +0900
Message-ID: <11832855683843-git-send-email-htejun@gmail.com>
References: <11832855672398-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.180]:26395 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755682AbXGAK0P (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 1 Jul 2007 06:26:15 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1884684wah
        for <linux-ide@vger.kernel.org>; Sun, 01 Jul 2007 03:26:15 -0700 (PDT)
In-Reply-To: <11832855672398-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, Forrest Zhao <forrest.zhao@gmail.com>
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
index d3af721..88cfac0 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -267,6 +267,7 @@ static const struct ata_port_operations ahci_ops = {
 
 	.tf_read		= ahci_tf_read,
 
+	.qc_defer		= ata_std_qc_defer,
 	.qc_prep		= ahci_qc_prep,
 	.qc_issue		= ahci_qc_issue,
 
@@ -301,6 +302,7 @@ static const struct ata_port_operations ahci_vt8251_ops = {
 
 	.tf_read		= ahci_tf_read,
 
+	.qc_defer		= ata_std_qc_defer,
 	.qc_prep		= ahci_qc_prep,
 	.qc_issue		= ahci_qc_issue,
 
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index e66f7c0..fb5d7e7 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4160,6 +4160,36 @@ int ata_check_atapi_dma(struct ata_queued_cmd *qc)
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
@@ -6921,6 +6951,7 @@ EXPORT_SYMBOL_GPL(ata_interrupt);
 EXPORT_SYMBOL_GPL(ata_do_set_mode);
 EXPORT_SYMBOL_GPL(ata_data_xfer);
 EXPORT_SYMBOL_GPL(ata_data_xfer_noirq);
+EXPORT_SYMBOL_GPL(ata_std_qc_defer);
 EXPORT_SYMBOL_GPL(ata_qc_prep);
 EXPORT_SYMBOL_GPL(ata_noop_qc_prep);
 EXPORT_SYMBOL_GPL(ata_bmdma_setup);
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index f7a9dc8..680850f 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -755,6 +755,13 @@ static void ata_scsi_sdev_config(struct scsi_device *sdev)
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
@@ -1422,37 +1429,6 @@ static void ata_scsi_qc_complete(struct ata_queued_cmd *qc)
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
@@ -1483,14 +1459,12 @@ static int ata_scsi_translate(struct ata_device *dev, struct scsi_cmnd *cmd,
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
@@ -1518,6 +1492,11 @@ static int ata_scsi_translate(struct ata_device *dev, struct scsi_cmnd *cmd,
 	if (xlat_func(qc))
 		goto early_finish;
 
+	if (ap->ops->qc_defer) {
+		if ((rc = ap->ops->qc_defer(qc)))
+			goto defer;
+	}
+
 	/* select device, send command to hardware */
 	ata_qc_issue(qc);
 
@@ -1539,8 +1518,12 @@ err_mem:
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
@@ -2934,6 +2917,13 @@ int ata_scsi_add_hosts(struct ata_host *host, struct scsi_host_template *sht)
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
index 3a349e0..e9847fe 100644
--- a/drivers/ata/sata_nv.c
+++ b/drivers/ata/sata_nv.c
@@ -429,6 +429,7 @@ static const struct ata_port_operations nv_adma_ops = {
 	.bmdma_start		= ata_bmdma_start,
 	.bmdma_stop		= ata_bmdma_stop,
 	.bmdma_status		= ata_bmdma_status,
+	.qc_defer		= ata_std_qc_defer,
 	.qc_prep		= nv_adma_qc_prep,
 	.qc_issue		= nv_adma_qc_issue,
 	.freeze			= nv_adma_freeze,
diff --git a/drivers/ata/sata_sil24.c b/drivers/ata/sata_sil24.c
index 85fd370..e2a41ff 100644
--- a/drivers/ata/sata_sil24.c
+++ b/drivers/ata/sata_sil24.c
@@ -394,6 +394,7 @@ static const struct ata_port_operations sil24_ops = {
 
 	.tf_read		= sil24_tf_read,
 
+	.qc_defer		= ata_std_qc_defer,
 	.qc_prep		= sil24_qc_prep,
 	.qc_issue		= sil24_qc_issue,
 
diff --git a/include/linux/libata.h b/include/linux/libata.h
index b310af4..fa332e0 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -269,6 +269,10 @@ enum {
 	/* ering size */
 	ATA_ERING_SIZE		= 32,
 
+	/* return values for ->qc_defer */
+	ATA_DEFER_LINK		= 1,
+	ATA_DEFER_PORT		= 2,
+
 	/* desc_len for ata_eh_info and context */
 	ATA_EH_DESC_LEN		= 80,
 
@@ -637,6 +641,7 @@ struct ata_port_operations {
 
 	void (*data_xfer) (struct ata_device *, unsigned char *, unsigned int, int);
 
+	int (*qc_defer) (struct ata_queued_cmd *qc);
 	void (*qc_prep) (struct ata_queued_cmd *qc);
 	unsigned int (*qc_issue) (struct ata_queued_cmd *qc);
 
@@ -821,6 +826,7 @@ extern void ata_data_xfer(struct ata_device *adev, unsigned char *buf,
 			  unsigned int buflen, int write_data);
 extern void ata_data_xfer_noirq(struct ata_device *adev, unsigned char *buf,
 				unsigned int buflen, int write_data);
+extern int ata_std_qc_defer(struct ata_queued_cmd *qc);
 extern void ata_qc_prep(struct ata_queued_cmd *qc);
 extern void ata_noop_qc_prep(struct ata_queued_cmd *qc);
 extern unsigned int ata_qc_issue_prot(struct ata_queued_cmd *qc);
-- 
1.5.0.3


