From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 4/5] [PATCH] libata-pmp-prep: implement ops->qc_defer()
Date: Mon, 16 Oct 2006 08:17:47 +0900
Message-ID: <1160954267375-git-send-email-htejun@gmail.com>
References: <11609542672061-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.187]:35867 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751229AbWJOXRz (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 15 Oct 2006 19:17:55 -0400
Received: by nf-out-0910.google.com with SMTP id c2so631133nfe
        for <linux-ide@vger.kernel.org>; Sun, 15 Oct 2006 16:17:54 -0700 (PDT)
In-Reply-To: <11609542672061-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org
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
 drivers/ata/ahci.c        |    2 ++
 drivers/ata/libata-core.c |   39 +++++++++++++++++++++++++++++++
 drivers/ata/libata-scsi.c |   57 +++++++++++++++------------------------------
 drivers/ata/sata_sil24.c  |    1 +
 include/linux/libata.h    |    6 +++++
 5 files changed, 67 insertions(+), 38 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 3878dea..d2d43cf 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -251,6 +251,7 @@ static const struct ata_port_operations 
 
 	.tf_read		= ahci_tf_read,
 
+	.qc_defer		= ata_std_qc_defer,
 	.qc_prep		= ahci_qc_prep,
 	.qc_issue		= ahci_qc_issue,
 
@@ -284,6 +285,7 @@ static const struct ata_port_operations 
 
 	.tf_read		= ahci_tf_read,
 
+	.qc_defer		= ata_std_qc_defer,
 	.qc_prep		= ahci_qc_prep,
 	.qc_issue		= ahci_qc_issue,
 
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 6b3a013..5f0835d 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -3485,6 +3485,37 @@ int ata_check_atapi_dma(struct ata_queue
 
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
 /**
  *	ata_qc_prep - Prepare taskfile for submission
  *	@qc: Metadata associated with taskfile to be prepared
@@ -5599,6 +5630,13 @@ static struct ata_port * ata_port_add(co
 
 	shost->transportt = &ata_scsi_transport_template;
 
+	/* Schedule policy is determined by ->qc_defer() callback and
+	 * it needs to see every deferred qc.  Set host_blocked to 1
+	 * to prevent SCSI midlayer from automatically deferring
+	 * requests.
+	 */
+	shost->max_host_blocked = 1;
+
 	ap = ata_shost_to_port(shost);
 
 	ata_port_init(ap, host, ent, port_no);
@@ -6299,6 +6337,7 @@ EXPORT_SYMBOL_GPL(ata_interrupt);
 EXPORT_SYMBOL_GPL(ata_mmio_data_xfer);
 EXPORT_SYMBOL_GPL(ata_pio_data_xfer);
 EXPORT_SYMBOL_GPL(ata_pio_data_xfer_noirq);
+EXPORT_SYMBOL_GPL(ata_std_qc_defer);
 EXPORT_SYMBOL_GPL(ata_qc_prep);
 EXPORT_SYMBOL_GPL(ata_noop_qc_prep);
 EXPORT_SYMBOL_GPL(ata_bmdma_setup);
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index feae473..c62992f 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -810,6 +810,13 @@ static void ata_scsi_dev_config(struct s
 {
 	unsigned int max_sectors;
 
+	/* Schedule policy is determined by ->qc_defer() callback and
+	 * it needs to see every deferred qc.  Set dev_blocked to 1 to
+	 * prevent SCSI midlayer from automatically deferring
+	 * requests.
+	 */
+	sdev->max_device_blocked = 1;
+
 	/* TODO: 2048 is an arbitrary number, not the
 	 * hardware maximum.  This should be increased to
 	 * 65534 when Jens Axboe's patch for dynamically
@@ -1500,39 +1507,6 @@ static void ata_scsi_qc_complete(struct 
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
@@ -1563,15 +1537,13 @@ static int ata_scsi_translate(struct ata
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
@@ -1599,6 +1571,11 @@ static int ata_scsi_translate(struct ata
 	if (xlat_func(qc, scsicmd))
 		goto early_finish;
 
+	if (ap->ops->qc_defer) {
+		if ((rc = ap->ops->qc_defer(qc)))
+			goto defer;
+	}
+
 	/* select device, send command to hardware */
 	ata_qc_issue(qc);
 
@@ -1620,8 +1597,12 @@ err_mem:
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
diff --git a/drivers/ata/sata_sil24.c b/drivers/ata/sata_sil24.c
index 1030496..9564e49 100644
--- a/drivers/ata/sata_sil24.c
+++ b/drivers/ata/sata_sil24.c
@@ -396,6 +396,7 @@ static const struct ata_port_operations 
 
 	.tf_read		= sil24_tf_read,
 
+	.qc_defer		= ata_std_qc_defer,
 	.qc_prep		= sil24_qc_prep,
 	.qc_issue		= sil24_qc_issue,
 
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 1b91a7c..12e866d 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -263,6 +263,10 @@ enum {
 	/* ering size */
 	ATA_ERING_SIZE		= 32,
 
+	/* return values for ->qc_defer */
+	ATA_DEFER_LINK		= 1,
+	ATA_DEFER_PORT		= 2,
+
 	/* desc_len for ata_eh_info and context */
 	ATA_EH_DESC_LEN		= 80,
 
@@ -633,6 +637,7 @@ struct ata_port_operations {
 
 	void (*data_xfer) (struct ata_device *, unsigned char *, unsigned int, int);
 
+	int (*qc_defer) (struct ata_queued_cmd *qc);
 	void (*qc_prep) (struct ata_queued_cmd *qc);
 	unsigned int (*qc_issue) (struct ata_queued_cmd *qc);
 
@@ -805,6 +810,7 @@ extern void ata_pio_data_xfer(struct ata
 			      unsigned int buflen, int write_data);
 extern void ata_pio_data_xfer_noirq(struct ata_device *adev, unsigned char *buf,
 			      unsigned int buflen, int write_data);
+extern int ata_std_qc_defer(struct ata_queued_cmd *qc);
 extern void ata_qc_prep(struct ata_queued_cmd *qc);
 extern void ata_noop_qc_prep(struct ata_queued_cmd *qc);
 extern unsigned int ata_qc_issue_prot(struct ata_queued_cmd *qc);
-- 
1.4.2.3


