From: Dan Williams <dan.j.williams@intel.com>
Subject: [bz87101 PATCH] libata: allow sata_sil24 to opt-out of tag ordered
 submission
Date: Wed, 29 Oct 2014 10:21:08 -0700
Message-ID: <20141029171402.17994.16801.stgit@viggo.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:19484 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934130AbaJ2RVP (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 29 Oct 2014 13:21:15 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>, Ronny Hegewald <Ronny.Hegewald@online.de>, stable@vger.kernel.org

Ronny reports: https://bugzilla.kernel.org/show_bug.cgi?id=87101
    "Since commit 8a4aeec8d 'libata/ahci: accommodate tag ordered
    controllers' the access to the harddisk on the first SATA-port is
    failing on its first access. The access to the harddisk on the
    second port is working normal.

    When reverting the above commit, access to both harddisks is working
    fine again."

Maintain tag ordered submission as the default, but allow sata_sil24 to
continue with the old behavior.

Cc: <stable@vger.kernel.org>
Cc: Tejun Heo <tj@kernel.org>
Reported-by: Ronny Hegewald <Ronny.Hegewald@online.de>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---

There's an open question if the tag ordering is just exposing a separate
bug in sata_sil24, similar to how xgene identified a separate fix when
it tripped over commit 8a4aeec8d "libata/ahci: accommodate tag ordered
controllers": http://marc.info/?l=linux-ide&m=140323674630985&w=2

 drivers/ata/libata-core.c |   42 +++++++++++++++++++++++++++++++++++++++---
 drivers/ata/libata.h      |    2 ++
 drivers/ata/sata_sil24.c  |   14 ++++++++------
 include/linux/libata.h    |    1 +
 4 files changed, 50 insertions(+), 9 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index c5ba15af87d3..8d1df11af1a4 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -84,6 +84,7 @@ const struct ata_port_operations ata_base_port_ops = {
 	.error_handler		= ata_std_error_handler,
 	.sched_eh		= ata_std_sched_eh,
 	.end_eh			= ata_std_end_eh,
+	.qc_new			= ata_qc_new_tag_order,
 };
 
 const struct ata_port_operations sata_port_ops = {
@@ -4718,9 +4719,12 @@ void swap_buf_le16(u16 *buf, unsigned int buf_words)
 }
 
 /**
- *	ata_qc_new - Request an available ATA command, for queueing
+ *	ata_qc_new_tag_order - Request an available ATA command, for queueing
  *	@ap: target port
  *
+ *	Accomodates controllers that issue commands in tag order rather
+ *	than FIFO order (Intel AHCI).
+ *
  *	Some ATA host controllers may implement a queue depth which is less
  *	than ATA_MAX_QUEUE. So we shouldn't allocate a tag which is beyond
  *	the hardware limitation.
@@ -4729,7 +4733,7 @@ void swap_buf_le16(u16 *buf, unsigned int buf_words)
  *	None.
  */
 
-static struct ata_queued_cmd *ata_qc_new(struct ata_port *ap)
+struct ata_queued_cmd *ata_qc_new_tag_order(struct ata_port *ap)
 {
 	struct ata_queued_cmd *qc = NULL;
 	unsigned int max_queue = ap->host->n_tags;
@@ -4758,6 +4762,38 @@ static struct ata_queued_cmd *ata_qc_new(struct ata_port *ap)
 }
 
 /**
+ *	ata_qc_new_fifo_order - Request an available ATA command, for queueing
+ *	@ap: target port
+ *
+ *	Allocate first available tag, for hosts that maintain fifo issue
+ *	order on the wire, or otherwise cannot handle tag order.
+ *
+ *	LOCKING:
+ *	None.
+ */
+
+struct ata_queued_cmd *ata_qc_new_fifo_order(struct ata_port *ap)
+{
+	struct ata_queued_cmd *qc = NULL;
+	unsigned int i;
+
+	/* no command while frozen */
+	if (unlikely(ap->pflags & ATA_PFLAG_FROZEN))
+		return NULL;
+
+	/* the last tag is reserved for internal command. */
+	for (i = 0; i < ATA_MAX_QUEUE - 1; i++)
+		if (!test_and_set_bit(i, &ap->qc_allocated)) {
+			qc = __ata_qc_from_tag(ap, i);
+			qc->tag = i;
+			break;
+		}
+
+	return qc;
+}
+EXPORT_SYMBOL_GPL(ata_qc_new_fifo_order);
+
+/**
  *	ata_qc_new_init - Request an available ATA command, and initialize it
  *	@dev: Device from whom we request an available command structure
  *
@@ -4770,7 +4806,7 @@ struct ata_queued_cmd *ata_qc_new_init(struct ata_device *dev)
 	struct ata_port *ap = dev->link->ap;
 	struct ata_queued_cmd *qc;
 
-	qc = ata_qc_new(ap);
+	qc = ap->ops->qc_new(ap);
 	if (qc) {
 		qc->scsicmd = NULL;
 		qc->ap = ap;
diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
index 5f4e0cca56ec..16f75854cd99 100644
--- a/drivers/ata/libata.h
+++ b/drivers/ata/libata.h
@@ -90,6 +90,8 @@ extern int ata_down_xfermask_limit(struct ata_device *dev, unsigned int sel);
 extern unsigned int ata_dev_set_feature(struct ata_device *dev,
 					u8 enable, u8 feature);
 extern void ata_sg_clean(struct ata_queued_cmd *qc);
+extern struct ata_queued_cmd *ata_qc_new_tag_order(struct ata_port *ap);
+extern struct ata_queued_cmd *ata_qc_new_fifo_order(struct ata_port *ap);
 extern void ata_qc_free(struct ata_queued_cmd *qc);
 extern void ata_qc_issue(struct ata_queued_cmd *qc);
 extern void __ata_qc_complete(struct ata_queued_cmd *qc);
diff --git a/drivers/ata/sata_sil24.c b/drivers/ata/sata_sil24.c
index d81b20ddb527..59719ded8ef1 100644
--- a/drivers/ata/sata_sil24.c
+++ b/drivers/ata/sata_sil24.c
@@ -30,8 +30,9 @@
 #include <scsi/scsi_cmnd.h>
 #include <linux/libata.h>
 
-#define DRV_NAME	"sata_sil24"
-#define DRV_VERSION	"1.1"
+#include "libata.h"
+
+#define SATA_SIL24_DRV_VERSION "1.1"
 
 /*
  * Port request block (PRB) 32 bytes
@@ -373,7 +374,7 @@ static const struct pci_device_id sil24_pci_tbl[] = {
 };
 
 static struct pci_driver sil24_pci_driver = {
-	.name			= DRV_NAME,
+	.name			= KBUILD_MODNAME,
 	.id_table		= sil24_pci_tbl,
 	.probe			= sil24_init_one,
 	.remove			= ata_pci_remove_one,
@@ -384,7 +385,7 @@ static struct pci_driver sil24_pci_driver = {
 };
 
 static struct scsi_host_template sil24_sht = {
-	ATA_NCQ_SHT(DRV_NAME),
+	ATA_NCQ_SHT(KBUILD_MODNAME),
 	.can_queue		= SIL24_MAX_CMDS,
 	.sg_tablesize		= SIL24_MAX_SGE,
 	.dma_boundary		= ATA_DMA_BOUNDARY,
@@ -397,6 +398,7 @@ static struct ata_port_operations sil24_ops = {
 	.qc_prep		= sil24_qc_prep,
 	.qc_issue		= sil24_qc_issue,
 	.qc_fill_rtf		= sil24_qc_fill_rtf,
+	.qc_new			= ata_qc_new_fifo_order,
 
 	.freeze			= sil24_freeze,
 	.thaw			= sil24_thaw,
@@ -1279,7 +1281,7 @@ static int sil24_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (sizeof(union sil24_cmd_block) != PAGE_SIZE)
 		__MARKER__sil24_cmd_block_is_sized_wrongly = 1;
 
-	ata_print_version_once(&pdev->dev, DRV_VERSION);
+	ata_print_version_once(&pdev->dev, SATA_SIL24_DRV_VERSION);
 
 	/* acquire resources */
 	rc = pcim_enable_device(pdev);
@@ -1288,7 +1290,7 @@ static int sil24_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	rc = pcim_iomap_regions(pdev,
 				(1 << SIL24_HOST_BAR) | (1 << SIL24_PORT_BAR),
-				DRV_NAME);
+				KBUILD_MODNAME);
 	if (rc)
 		return rc;
 	iomap = pcim_iomap_table(pdev);
diff --git a/include/linux/libata.h b/include/linux/libata.h
index bd5fefeaf548..dd94e06ba91a 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -881,6 +881,7 @@ struct ata_port_operations {
 	void (*qc_prep)(struct ata_queued_cmd *qc);
 	unsigned int (*qc_issue)(struct ata_queued_cmd *qc);
 	bool (*qc_fill_rtf)(struct ata_queued_cmd *qc);
+	struct ata_queued_cmd *(*qc_new)(struct ata_port *ap);
 
 	/*
 	 * Configuration and exception handling

