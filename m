From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 5/6] libata-pmp-prep: implement ops->qc_defer()
Date: Sat, 8 Jul 2006 14:51:18 +0900
Message-ID: <11523378783771-git-send-email-htejun@gmail.com>
References: <11523378773934-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.231]:6514 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S964799AbWGHFub (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 8 Jul 2006 01:50:31 -0400
Received: by wr-out-0506.google.com with SMTP id 36so1484430wra
        for <linux-ide@vger.kernel.org>; Fri, 07 Jul 2006 22:50:30 -0700 (PDT)
In-Reply-To: <11523378773934-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, lkml@rtr.ca, forrest.zhao@intel.com, linux-ide@vger.kernel.org
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

 drivers/scsi/ahci.c        |    1 +
 drivers/scsi/libata-core.c |   32 ++++++++++++++++++++++++++++
 drivers/scsi/libata-scsi.c |   50 +++++++++++---------------------------------
 drivers/scsi/sata_sil24.c  |    1 +
 include/linux/libata.h     |    6 +++++
 5 files changed, 52 insertions(+), 38 deletions(-)

bdc03a79abfa9d30a7cb1c06c6038a0a5eb65095
diff --git a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
index 9f2f66a..17b459f 100644
--- a/drivers/scsi/ahci.c
+++ b/drivers/scsi/ahci.c
@@ -242,6 +242,7 @@ static const struct ata_port_operations 
 
 	.tf_read		= ahci_tf_read,
 
+	.qc_defer		= ata_std_qc_defer,
 	.qc_prep		= ahci_qc_prep,
 	.qc_issue		= ahci_qc_issue,
 
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 38ddeff..f9644db 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -3425,6 +3425,37 @@ int ata_check_atapi_dma(struct ata_queue
 
 	return rc;
 }
+
+/**
+ *	ata_std_qc_defer - Check whether a qc needs to be deferred
+ *	@qc: ATA command in question
+ *
+ *	Non-NCQ commands cannot run with any other command, NCQ or
+ *	not.  As upper layer only knows the queue depth, we are
+ *	responsible for maintaining exclusion.  This function checks
+ *	whether a new command @qc can be issued.
+ *
+ *	LOCKING:
+ *	spin_lock_irqsave(host_set lock)
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
 /**
  *	ata_qc_prep - Prepare taskfile for submission
  *	@qc: Metadata associated with taskfile to be prepared
@@ -6150,6 +6181,7 @@ EXPORT_SYMBOL_GPL(ata_interrupt);
 EXPORT_SYMBOL_GPL(ata_mmio_data_xfer);
 EXPORT_SYMBOL_GPL(ata_pio_data_xfer);
 EXPORT_SYMBOL_GPL(ata_pio_data_xfer_noirq);
+EXPORT_SYMBOL_GPL(ata_std_qc_defer);
 EXPORT_SYMBOL_GPL(ata_qc_prep);
 EXPORT_SYMBOL_GPL(ata_noop_qc_prep);
 EXPORT_SYMBOL_GPL(ata_bmdma_setup);
diff --git a/drivers/scsi/libata-scsi.c b/drivers/scsi/libata-scsi.c
index 7e33506..d446a86 100644
--- a/drivers/scsi/libata-scsi.c
+++ b/drivers/scsi/libata-scsi.c
@@ -1458,39 +1458,6 @@ static void ata_scsi_qc_complete(struct 
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
- *	spin_lock_irqsave(host_set lock)
- *
- *	RETURNS:
- *	1 if deferring is needed, 0 otherwise.
- */
-static int ata_scmd_need_defer(struct ata_device *dev, int is_io)
-{
-	struct ata_link *link = dev->link;
-
-	if (!(dev->flags & ATA_DFLAG_NCQ))
-		return 0;
-
-	if (is_io) {
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
@@ -1521,15 +1488,13 @@ static int ata_scsi_translate(struct ata
 			      void (*done)(struct scsi_cmnd *),
 			      ata_xlat_func_t xlat_func)
 {
+	struct ata_port *ap = dev->link->ap;
 	struct ata_queued_cmd *qc;
 	u8 *scsicmd = cmd->cmnd;
-	int is_io = xlat_func == ata_scsi_rw_xlat;
+	int rc;
 
 	VPRINTK("ENTER\n");
 
-	if (unlikely(ata_scmd_need_defer(dev, is_io)))
-		goto defer;
-
 	qc = ata_scsi_qc_new(dev, cmd, done);
 	if (!qc)
 		goto err_mem;
@@ -1557,6 +1522,11 @@ static int ata_scsi_translate(struct ata
 	if (xlat_func(qc, scsicmd))
 		goto early_finish;
 
+	if (ap->ops->qc_defer) {
+		if ((rc = ap->ops->qc_defer(qc)))
+			goto defer;
+	}
+
 	/* select device, send command to hardware */
 	ata_qc_issue(qc);
 
@@ -1578,8 +1548,12 @@ err_mem:
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
diff --git a/drivers/scsi/sata_sil24.c b/drivers/scsi/sata_sil24.c
index b1ae88d..68a3fc1 100644
--- a/drivers/scsi/sata_sil24.c
+++ b/drivers/scsi/sata_sil24.c
@@ -391,6 +391,7 @@ static const struct ata_port_operations 
 
 	.tf_read		= sil24_tf_read,
 
+	.qc_defer		= ata_std_qc_defer,
 	.qc_prep		= sil24_qc_prep,
 	.qc_issue		= sil24_qc_issue,
 
diff --git a/include/linux/libata.h b/include/linux/libata.h
index f46b215..8a4adce 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -249,6 +249,10 @@ enum {
 	/* ering size */
 	ATA_ERING_SIZE		= 32,
 
+	/* return values for ->qc_defer */
+	ATA_DEFER_LINK		= 1,
+	ATA_DEFER_PORT		= 2,
+
 	/* desc_len for ata_eh_info and context */
 	ATA_EH_DESC_LEN		= 80,
 
@@ -606,6 +610,7 @@ struct ata_port_operations {
 
 	void (*data_xfer) (struct ata_device *, unsigned char *, unsigned int, int);
 
+	int (*qc_defer) (struct ata_queued_cmd *qc);
 	void (*qc_prep) (struct ata_queued_cmd *qc);
 	unsigned int (*qc_issue) (struct ata_queued_cmd *qc);
 
@@ -759,6 +764,7 @@ extern void ata_pio_data_xfer(struct ata
 			      unsigned int buflen, int write_data);
 extern void ata_pio_data_xfer_noirq(struct ata_device *adev, unsigned char *buf,
 			      unsigned int buflen, int write_data);
+extern int ata_std_qc_defer(struct ata_queued_cmd *qc);
 extern void ata_qc_prep(struct ata_queued_cmd *qc);
 extern void ata_noop_qc_prep(struct ata_queued_cmd *qc);
 extern unsigned int ata_qc_issue_prot(struct ata_queued_cmd *qc);
-- 
1.3.2


