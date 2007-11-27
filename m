From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 2/8] libata: implement protocol tests
Date: Tue, 27 Nov 2007 19:28:53 +0900
Message-ID: <11961593392138-git-send-email-htejun@gmail.com>
References: <11961593392491-git-send-email-htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.179]:11782 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754716AbXK0K3R (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 27 Nov 2007 05:29:17 -0500
Received: by wa-out-1112.google.com with SMTP id v27so1179628wah
        for <linux-ide@vger.kernel.org>; Tue, 27 Nov 2007 02:29:17 -0800 (PST)
In-Reply-To: <11961593392491-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org
Cc: bzolnier@gmail.com, Tejun Heo <htejun@gmail.com>

Implement protocol tests - ata_is_atapi(), ata_is_nodata(),
ata_is_pio(), ata_is_dma(), ata_is_ncq() and ata_is_data() and use
them to replace is_atapi_taskfile() and hard coded protocol tests.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/ahci.c            |    2 +-
 drivers/ata/libata-core.c     |   36 ++++-----------------
 drivers/ata/sata_fsl.c        |    2 +-
 drivers/ata/sata_sil.c        |   10 ++---
 drivers/ata/sata_sil24.c      |   26 ++-------------
 drivers/scsi/libsas/sas_ata.c |    2 +-
 include/linux/ata.h           |   71 +++++++++++++++++++++++++++++++++++++----
 7 files changed, 82 insertions(+), 67 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 2c686b4..a8fc9c0 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1505,7 +1505,7 @@ static void ahci_qc_prep(struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
 	struct ahci_port_priv *pp = ap->private_data;
-	int is_atapi = is_atapi_taskfile(&qc->tf);
+	int is_atapi = ata_is_atapi(qc->tf.protocol);
 	void *cmd_tbl;
 	u32 opts;
 	const u32 cmd_fis_len = 5; /* five dwords */
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 5eb5983..8d5cd16 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -5325,7 +5325,7 @@ static inline int ata_hsm_ok_in_wq(struct ata_port *ap, struct ata_queued_cmd *q
 		    (qc->tf.flags & ATA_TFLAG_WRITE))
 		    return 1;
 
-		if (is_atapi_taskfile(&qc->tf) &&
+		if (ata_is_atapi(qc->tf.protocol) &&
 		    !(qc->dev->flags & ATA_DFLAG_CDB_INTR))
 			return 1;
 	}
@@ -5922,30 +5922,6 @@ int ata_qc_complete_multiple(struct ata_port *ap, u32 qc_active,
 	return nr_done;
 }
 
-static inline int ata_should_dma_map(struct ata_queued_cmd *qc)
-{
-	struct ata_port *ap = qc->ap;
-
-	switch (qc->tf.protocol) {
-	case ATA_PROT_NCQ:
-	case ATA_PROT_DMA:
-	case ATA_PROT_ATAPI_DMA:
-		return 1;
-
-	case ATA_PROT_ATAPI:
-	case ATA_PROT_PIO:
-		if (ap->flags & ATA_FLAG_PIO_DMA)
-			return 1;
-
-		/* fall through */
-
-	default:
-		return 0;
-	}
-
-	/* never reached */
-}
-
 /**
  *	ata_qc_issue - issue taskfile to device
  *	@qc: command to issue to device
@@ -5962,6 +5938,7 @@ void ata_qc_issue(struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
 	struct ata_link *link = qc->dev->link;
+	u8 prot = qc->tf.protocol;
 
 	/* Make sure only one non-NCQ command is outstanding.  The
 	 * check is skipped for old EH because it reuses active qc to
@@ -5969,7 +5946,7 @@ void ata_qc_issue(struct ata_queued_cmd *qc)
 	 */
 	WARN_ON(ap->ops->error_handler && ata_tag_valid(link->active_tag));
 
-	if (qc->tf.protocol == ATA_PROT_NCQ) {
+	if (prot == ATA_PROT_NCQ) {
 		WARN_ON(link->sactive & (1 << qc->tag));
 
 		if (!link->sactive)
@@ -5985,7 +5962,8 @@ void ata_qc_issue(struct ata_queued_cmd *qc)
 	qc->flags |= ATA_QCFLAG_ACTIVE;
 	ap->qc_active |= 1 << qc->tag;
 
-	if (ata_should_dma_map(qc)) {
+	if (ata_is_dma(prot) || (ata_is_pio(prot) &&
+				 (ap->flags & ATA_FLAG_PIO_DMA))) {
 		if (qc->flags & ATA_QCFLAG_SG) {
 			if (ata_sg_setup(qc))
 				goto sg_err;
@@ -6184,8 +6162,8 @@ inline unsigned int ata_host_intr(struct ata_port *ap,
 		 */
 
 		/* Check the ATA_DFLAG_CDB_INTR flag is enough here.
-		 * The flag was turned on only for atapi devices.
-		 * No need to check is_atapi_taskfile(&qc->tf) again.
+		 * The flag was turned on only for atapi devices.  No
+		 * need to check ata_is_atapi(qc->tf.protocol) again.
 		 */
 		if (!(qc->dev->flags & ATA_DFLAG_CDB_INTR))
 			goto idle_irq;
diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c
index d015b4a..a3c33f1 100644
--- a/drivers/ata/sata_fsl.c
+++ b/drivers/ata/sata_fsl.c
@@ -417,7 +417,7 @@ static void sata_fsl_qc_prep(struct ata_queued_cmd *qc)
 	}
 
 	/* setup "ACMD - atapi command" in cmd. desc. if this is ATAPI cmd */
-	if (is_atapi_taskfile(&qc->tf)) {
+	if (ata_is_atapi(qc->tf.protocol)) {
 		desc_info |= ATAPI_CMD;
 		memset((void *)&cd->acmd, 0, 32);
 		memcpy((void *)&cd->acmd, qc->cdb, qc->dev->cdb_len);
diff --git a/drivers/ata/sata_sil.c b/drivers/ata/sata_sil.c
index 4e6e381..4f31481 100644
--- a/drivers/ata/sata_sil.c
+++ b/drivers/ata/sata_sil.c
@@ -420,15 +420,14 @@ static void sil_host_intr(struct ata_port *ap, u32 bmdma2)
 		 */
 
 		/* Check the ATA_DFLAG_CDB_INTR flag is enough here.
-		 * The flag was turned on only for atapi devices.
-		 * No need to check is_atapi_taskfile(&qc->tf) again.
+		 * The flag was turned on only for atapi devices.  No
+		 * need to check ata_is_atapi(qc->tf.protocol) again.
 		 */
 		if (!(qc->dev->flags & ATA_DFLAG_CDB_INTR))
 			goto err_hsm;
 		break;
 	case HSM_ST_LAST:
-		if (qc->tf.protocol == ATA_PROT_DMA ||
-		    qc->tf.protocol == ATA_PROT_ATAPI_DMA) {
+		if (ata_is_dma(qc->tf.protocol)) {
 			/* clear DMA-Start bit */
 			ap->ops->bmdma_stop(qc);
 
@@ -455,8 +454,7 @@ static void sil_host_intr(struct ata_port *ap, u32 bmdma2)
 	/* kick HSM in the ass */
 	ata_hsm_move(ap, qc, status, 0);
 
-	if (unlikely(qc->err_mask) && (qc->tf.protocol == ATA_PROT_DMA ||
-				       qc->tf.protocol == ATA_PROT_ATAPI_DMA))
+	if (unlikely(qc->err_mask) && ata_is_dma(qc->tf.protocol))
 		ata_ehi_push_desc(ehi, "BMDMA2 stat 0x%x", bmdma2);
 
 	return;
diff --git a/drivers/ata/sata_sil24.c b/drivers/ata/sata_sil24.c
index 96fd526..4f25209 100644
--- a/drivers/ata/sata_sil24.c
+++ b/drivers/ata/sata_sil24.c
@@ -831,10 +831,6 @@ static int sil24_qc_defer(struct ata_queued_cmd *qc)
 {
 	struct ata_link *link = qc->dev->link;
 	struct ata_port *ap = link->ap;
-	u8 prot = qc->tf.protocol;
-	int is_atapi = (prot == ATA_PROT_ATAPI ||
-			prot == ATA_PROT_ATAPI_NODATA ||
-			prot == ATA_PROT_ATAPI_DMA);
 
 	/* ATAPI commands completing with CHECK_SENSE cause various
 	 * weird problems if other commands are active.  PMP DMA CS
@@ -849,7 +845,7 @@ static int sil24_qc_defer(struct ata_queued_cmd *qc)
 			qc->flags |= ATA_QCFLAG_CLEAR_EXCL;
 		} else
 			return ATA_DEFER_PORT;
-	} else if (unlikely(is_atapi)) {
+	} else if (unlikely(ata_is_atapi(qc->tf.protocol))) {
 		ap->excl_link = link;
 		if (ap->nr_active_links)
 			return ATA_DEFER_PORT;
@@ -870,35 +866,21 @@ static void sil24_qc_prep(struct ata_queued_cmd *qc)
 
 	cb = &pp->cmd_block[sil24_tag(qc->tag)];
 
-	switch (qc->tf.protocol) {
-	case ATA_PROT_PIO:
-	case ATA_PROT_DMA:
-	case ATA_PROT_NCQ:
-	case ATA_PROT_NODATA:
+	if (!ata_is_atapi(qc->tf.protocol)) {
 		prb = &cb->ata.prb;
 		sge = cb->ata.sge;
-		break;
-
-	case ATA_PROT_ATAPI:
-	case ATA_PROT_ATAPI_DMA:
-	case ATA_PROT_ATAPI_NODATA:
+	} else {
 		prb = &cb->atapi.prb;
 		sge = cb->atapi.sge;
 		memset(cb->atapi.cdb, 0, 32);
 		memcpy(cb->atapi.cdb, qc->cdb, qc->dev->cdb_len);
 
-		if (qc->tf.protocol != ATA_PROT_ATAPI_NODATA) {
+		if (ata_is_data(qc->tf.protocol)) {
 			if (qc->tf.flags & ATA_TFLAG_WRITE)
 				ctrl = PRB_CTRL_PACKET_WRITE;
 			else
 				ctrl = PRB_CTRL_PACKET_READ;
 		}
-		break;
-
-	default:
-		prb = NULL;	/* shut up, gcc */
-		sge = NULL;
-		BUG();
 	}
 
 	prb->ctrl = cpu_to_le16(ctrl);
diff --git a/drivers/scsi/libsas/sas_ata.c b/drivers/scsi/libsas/sas_ata.c
index 0829b55..831294d 100644
--- a/drivers/scsi/libsas/sas_ata.c
+++ b/drivers/scsi/libsas/sas_ata.c
@@ -176,7 +176,7 @@ static unsigned int sas_ata_qc_issue(struct ata_queued_cmd *qc)
 
 	ata_tf_to_fis(&qc->tf, 1, 0, (u8*)&task->ata_task.fis);
 	task->uldd_task = qc;
-	if (is_atapi_taskfile(&qc->tf)) {
+	if (ata_is_atapi(qc->tf.protocol)) {
 		memcpy(task->ata_task.atapi_packet, qc->cdb, qc->dev->cdb_len);
 		task->total_xfer_len = qc->nbytes + qc->pad_len;
 		task->num_scatter = qc->pad_len ? qc->n_elem + 1 : qc->n_elem;
diff --git a/include/linux/ata.h b/include/linux/ata.h
index f08a9ba..e35c740 100644
--- a/include/linux/ata.h
+++ b/include/linux/ata.h
@@ -309,6 +309,13 @@ enum {
 	ATA_TFLAG_LBA		= (1 << 4), /* enable LBA */
 	ATA_TFLAG_FUA		= (1 << 5), /* enable FUA */
 	ATA_TFLAG_POLLING	= (1 << 6), /* set nIEN to 1 and use polling */
+
+	/* protocol flags */
+	ATA_PROT_FLAG_PIO	= (1 << 0), /* is PIO */
+	ATA_PROT_FLAG_DMA	= (1 << 1), /* is DMA */
+	ATA_PROT_FLAG_DATA	= ATA_PROT_FLAG_PIO | ATA_PROT_FLAG_DMA,
+	ATA_PROT_FLAG_NCQ	= (1 << 2), /* is NCQ */
+	ATA_PROT_FLAG_ATAPI	= (1 << 3), /* is ATAPI */
 };
 
 enum ata_tf_protocols {
@@ -358,6 +365,63 @@ struct ata_taskfile {
 	u8			command;	/* IO operation */
 };
 
+/*
+ * protocol tests
+ */
+static inline unsigned int ata_prot_flags(u8 prot)
+{
+	switch (prot) {
+	case ATA_PROT_NODATA:
+		return 0;
+	case ATA_PROT_PIO:
+		return ATA_PROT_FLAG_PIO;
+	case ATA_PROT_DMA:
+		return ATA_PROT_FLAG_DMA;
+	case ATA_PROT_NCQ:
+		return ATA_PROT_FLAG_DMA | ATA_PROT_FLAG_NCQ;
+	case ATA_PROT_ATAPI_NODATA:
+		return ATA_PROT_FLAG_ATAPI;
+	case ATA_PROT_ATAPI:
+		return ATA_PROT_FLAG_ATAPI | ATA_PROT_FLAG_PIO;
+	case ATA_PROT_ATAPI_DMA:
+		return ATA_PROT_FLAG_ATAPI | ATA_PROT_FLAG_DMA;
+	}
+	return 0;
+}
+
+static inline int ata_is_atapi(u8 prot)
+{
+	return ata_prot_flags(prot) & ATA_PROT_FLAG_ATAPI;
+}
+
+static inline int ata_is_nodata(u8 prot)
+{
+	return !(ata_prot_flags(prot) & ATA_PROT_FLAG_DATA);
+}
+
+static inline int ata_is_pio(u8 prot)
+{
+	return ata_prot_flags(prot) & ATA_PROT_FLAG_PIO;
+}
+
+static inline int ata_is_dma(u8 prot)
+{
+	return ata_prot_flags(prot) & ATA_PROT_FLAG_DMA;
+}
+
+static inline int ata_is_ncq(u8 prot)
+{
+	return ata_prot_flags(prot) & ATA_PROT_FLAG_NCQ;
+}
+
+static inline int ata_is_data(u8 prot)
+{
+	return ata_prot_flags(prot) & ATA_PROT_FLAG_DATA;
+}
+
+/*
+ * id tests
+ */
 #define ata_id_is_ata(id)	(((id)[0] & (1 << 15)) == 0)
 #define ata_id_has_lba(id)	((id)[49] & (1 << 9))
 #define ata_id_has_dma(id)	((id)[49] & (1 << 8))
@@ -581,13 +645,6 @@ static inline int atapi_command_packet_set(const u16 *dev_id)
 	return (dev_id[0] >> 8) & 0x1f;
 }
 
-static inline int is_atapi_taskfile(const struct ata_taskfile *tf)
-{
-	return (tf->protocol == ATA_PROT_ATAPI) ||
-	       (tf->protocol == ATA_PROT_ATAPI_NODATA) ||
-	       (tf->protocol == ATA_PROT_ATAPI_DMA);
-}
-
 static inline int is_multi_taskfile(struct ata_taskfile *tf)
 {
 	return (tf->command == ATA_CMD_READ_MULTI) ||
-- 
1.5.2.4

