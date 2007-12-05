From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 05/15] libata: rename ATA_PROT_ATAPI_* to ATAPI_PROT_*
Date: Wed,  5 Dec 2007 16:43:05 +0900
Message-ID: <1196840596229-git-send-email-htejun@gmail.com>
References: <11968405951262-git-send-email-htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.176]:34723 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751982AbXLEHn5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 5 Dec 2007 02:43:57 -0500
Received: by wa-out-1112.google.com with SMTP id v27so6895985wah
        for <linux-ide@vger.kernel.org>; Tue, 04 Dec 2007 23:43:56 -0800 (PST)
In-Reply-To: <11968405951262-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk, liml@rtr.ca, albertl@mail.com, jens.axboe@oracle.com
Cc: Tejun Heo <htejun@gmail.com>

ATA_PROT_ATAPI_* are ugly and naming schemes between ATA_PROT_* and
ATA_PROT_ATAPI_* are inconsistent causing confusion.  Rename them to
ATAPI_PROT_* and make them consistent with ATA counterpart.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-core.c       |   24 ++++++++++++------------
 drivers/ata/libata-eh.c         |    8 ++++----
 drivers/ata/libata-scsi.c       |   10 +++++-----
 drivers/ata/libata-sff.c        |    2 +-
 drivers/ata/pata_pdc202xx_old.c |    5 ++---
 drivers/ata/pdc_adma.c          |    2 +-
 drivers/ata/sata_inic162x.c     |    2 +-
 drivers/ata/sata_promise.c      |   26 ++++++++++++--------------
 drivers/ata/sata_qstor.c        |    2 +-
 drivers/ata/sata_sx4.c          |    2 +-
 drivers/scsi/ipr.c              |    6 +++---
 drivers/scsi/libsas/sas_ata.c   |    2 +-
 include/linux/ata.h             |   12 ++++++------
 13 files changed, 50 insertions(+), 53 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 88f7637..1af9b84 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -5136,13 +5136,13 @@ static void atapi_send_cdb(struct ata_port *ap, struct ata_queued_cmd *qc)
 	ata_altstatus(ap); /* flush */
 
 	switch (qc->tf.protocol) {
-	case ATA_PROT_ATAPI:
+	case ATAPI_PROT_PIO:
 		ap->hsm_task_state = HSM_ST;
 		break;
-	case ATA_PROT_ATAPI_NODATA:
+	case ATAPI_PROT_NODATA:
 		ap->hsm_task_state = HSM_ST_LAST;
 		break;
-	case ATA_PROT_ATAPI_DMA:
+	case ATAPI_PROT_DMA:
 		ap->hsm_task_state = HSM_ST_LAST;
 		/* initiate bmdma */
 		ap->ops->bmdma_start(qc);
@@ -5488,7 +5488,7 @@ fsm_start:
 
 	case HSM_ST:
 		/* complete command or read/write the data register */
-		if (qc->tf.protocol == ATA_PROT_ATAPI) {
+		if (qc->tf.protocol == ATAPI_PROT_PIO) {
 			/* ATAPI PIO protocol */
 			if ((status & ATA_DRQ) == 0) {
 				/* No more data to transfer or device error.
@@ -6043,11 +6043,11 @@ unsigned int ata_qc_issue_prot(struct ata_queued_cmd *qc)
 		switch (qc->tf.protocol) {
 		case ATA_PROT_PIO:
 		case ATA_PROT_NODATA:
-		case ATA_PROT_ATAPI:
-		case ATA_PROT_ATAPI_NODATA:
+		case ATAPI_PROT_PIO:
+		case ATAPI_PROT_NODATA:
 			qc->tf.flags |= ATA_TFLAG_POLLING;
 			break;
-		case ATA_PROT_ATAPI_DMA:
+		case ATAPI_PROT_DMA:
 			if (qc->dev->flags & ATA_DFLAG_CDB_INTR)
 				/* see ata_dma_blacklisted() */
 				BUG();
@@ -6111,8 +6111,8 @@ unsigned int ata_qc_issue_prot(struct ata_queued_cmd *qc)
 
 		break;
 
-	case ATA_PROT_ATAPI:
-	case ATA_PROT_ATAPI_NODATA:
+	case ATAPI_PROT_PIO:
+	case ATAPI_PROT_NODATA:
 		if (qc->tf.flags & ATA_TFLAG_POLLING)
 			ata_qc_set_polling(qc);
 
@@ -6126,7 +6126,7 @@ unsigned int ata_qc_issue_prot(struct ata_queued_cmd *qc)
 			ata_port_queue_task(ap, ata_pio_task, qc, 0);
 		break;
 
-	case ATA_PROT_ATAPI_DMA:
+	case ATAPI_PROT_DMA:
 		WARN_ON(qc->tf.flags & ATA_TFLAG_POLLING);
 
 		ap->ops->tf_load(ap, &qc->tf);	 /* load tf registers */
@@ -6187,7 +6187,7 @@ inline unsigned int ata_host_intr(struct ata_port *ap,
 		break;
 	case HSM_ST_LAST:
 		if (qc->tf.protocol == ATA_PROT_DMA ||
-		    qc->tf.protocol == ATA_PROT_ATAPI_DMA) {
+		    qc->tf.protocol == ATAPI_PROT_DMA) {
 			/* check status of DMA engine */
 			host_stat = ap->ops->bmdma_status(ap);
 			VPRINTK("ata%u: host_stat 0x%X\n",
@@ -6229,7 +6229,7 @@ inline unsigned int ata_host_intr(struct ata_port *ap,
 	ata_hsm_move(ap, qc, status, 0);
 
 	if (unlikely(qc->err_mask) && (qc->tf.protocol == ATA_PROT_DMA ||
-				       qc->tf.protocol == ATA_PROT_ATAPI_DMA))
+				       qc->tf.protocol == ATAPI_PROT_DMA))
 		ata_ehi_push_desc(ehi, "BMDMA stat 0x%x", host_stat);
 
 	return 1;	/* irq handled */
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 32d7287..3688f21 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -1298,10 +1298,10 @@ static unsigned int atapi_eh_request_sense(struct ata_queued_cmd *qc)
 
 	/* is it pointless to prefer PIO for "safety reasons"? */
 	if (ap->flags & ATA_FLAG_PIO_DMA) {
-		tf.protocol = ATA_PROT_ATAPI_DMA;
+		tf.protocol = ATAPI_PROT_DMA;
 		tf.feature |= ATAPI_PKT_DMA;
 	} else {
-		tf.protocol = ATA_PROT_ATAPI;
+		tf.protocol = ATAPI_PROT_PIO;
 		tf.lbam = SCSI_SENSE_BUFFERSIZE;
 		tf.lbah = 0;
 	}
@@ -1968,8 +1968,8 @@ static void ata_eh_link_report(struct ata_link *link)
 				[ATA_PROT_PIO]		= "pio",
 				[ATA_PROT_DMA]		= "dma",
 				[ATA_PROT_NCQ]		= "ncq",
-				[ATA_PROT_ATAPI]	= "pio",
-				[ATA_PROT_ATAPI_DMA]	= "dma",
+				[ATAPI_PROT_PIO]	= "pio",
+				[ATAPI_PROT_DMA]	= "dma",
 			};
 
 			snprintf(data_buf, sizeof(data_buf), " %s %u %s",
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 29e8336..6251caa 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -2353,10 +2353,10 @@ static void atapi_request_sense(struct ata_queued_cmd *qc)
 	qc->tf.command = ATA_CMD_PACKET;
 
 	if (ata_pio_use_silly(ap)) {
-		qc->tf.protocol = ATA_PROT_ATAPI_DMA;
+		qc->tf.protocol = ATAPI_PROT_DMA;
 		qc->tf.feature |= ATAPI_PKT_DMA;
 	} else {
-		qc->tf.protocol = ATA_PROT_ATAPI;
+		qc->tf.protocol = ATAPI_PROT_PIO;
 		qc->tf.lbam = SCSI_SENSE_BUFFERSIZE;
 		qc->tf.lbah = 0;
 	}
@@ -2527,12 +2527,12 @@ static unsigned int atapi_xlat(struct ata_queued_cmd *qc)
 	if (using_pio || nodata) {
 		/* no data, or PIO data xfer */
 		if (nodata)
-			qc->tf.protocol = ATA_PROT_ATAPI_NODATA;
+			qc->tf.protocol = ATAPI_PROT_NODATA;
 		else
-			qc->tf.protocol = ATA_PROT_ATAPI;
+			qc->tf.protocol = ATAPI_PROT_PIO;
 	} else {
 		/* DMA data xfer */
-		qc->tf.protocol = ATA_PROT_ATAPI_DMA;
+		qc->tf.protocol = ATAPI_PROT_DMA;
 		qc->tf.feature |= ATAPI_PKT_DMA;
 
 		if (atapi_dmadir && (scmd->sc_data_direction != DMA_TO_DEVICE))
diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index fb69476..3b62479 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -417,7 +417,7 @@ void ata_bmdma_drive_eh(struct ata_port *ap, ata_prereset_fn_t prereset,
 	ap->hsm_task_state = HSM_ST_IDLE;
 
 	if (qc && (qc->tf.protocol == ATA_PROT_DMA ||
-		   qc->tf.protocol == ATA_PROT_ATAPI_DMA)) {
+		   qc->tf.protocol == ATAPI_PROT_DMA)) {
 		u8 host_stat;
 
 		host_stat = ap->ops->bmdma_status(ap);
diff --git a/drivers/ata/pata_pdc202xx_old.c b/drivers/ata/pata_pdc202xx_old.c
index bc7c2d5..407dbcf 100644
--- a/drivers/ata/pata_pdc202xx_old.c
+++ b/drivers/ata/pata_pdc202xx_old.c
@@ -168,8 +168,7 @@ static void pdc2026x_bmdma_start(struct ata_queued_cmd *qc)
 	pdc202xx_set_dmamode(ap, qc->dev);
 
 	/* Cases the state machine will not complete correctly without help */
-	if ((tf->flags & ATA_TFLAG_LBA48) ||  tf->protocol == ATA_PROT_ATAPI_DMA)
-	{
+	if ((tf->flags & ATA_TFLAG_LBA48) ||  tf->protocol == ATAPI_PROT_DMA) {
 		len = qc->nbytes / 2;
 
 		if (tf->flags & ATA_TFLAG_WRITE)
@@ -208,7 +207,7 @@ static void pdc2026x_bmdma_stop(struct ata_queued_cmd *qc)
 	void __iomem *atapi_reg = master + 0x20 + (4 * ap->port_no);
 
 	/* Cases the state machine will not complete correctly */
-	if (tf->protocol == ATA_PROT_ATAPI_DMA || ( tf->flags & ATA_TFLAG_LBA48)) {
+	if (tf->protocol == ATAPI_PROT_DMA || (tf->flags & ATA_TFLAG_LBA48)) {
 		iowrite32(0, atapi_reg);
 		iowrite8(ioread8(clock) & ~sel66, clock);
 	}
diff --git a/drivers/ata/pdc_adma.c b/drivers/ata/pdc_adma.c
index bd4c2a3..459cb7b 100644
--- a/drivers/ata/pdc_adma.c
+++ b/drivers/ata/pdc_adma.c
@@ -455,7 +455,7 @@ static unsigned int adma_qc_issue(struct ata_queued_cmd *qc)
 		adma_packet_start(qc);
 		return 0;
 
-	case ATA_PROT_ATAPI_DMA:
+	case ATAPI_PROT_DMA:
 		BUG();
 		break;
 
diff --git a/drivers/ata/sata_inic162x.c b/drivers/ata/sata_inic162x.c
index 323c087..96e614a 100644
--- a/drivers/ata/sata_inic162x.c
+++ b/drivers/ata/sata_inic162x.c
@@ -585,7 +585,7 @@ static struct ata_port_operations inic_port_ops = {
 };
 
 static struct ata_port_info inic_port_info = {
-	/* For some reason, ATA_PROT_ATAPI is broken on this
+	/* For some reason, ATAPI_PROT_PIO is broken on this
 	 * controller, and no, PIO_POLLING does't fix it.  It somehow
 	 * manages to report the wrong ireason and ignoring ireason
 	 * results in machine lock up.  Tell libata to always prefer
diff --git a/drivers/ata/sata_promise.c b/drivers/ata/sata_promise.c
index 9638faa..01738d7 100644
--- a/drivers/ata/sata_promise.c
+++ b/drivers/ata/sata_promise.c
@@ -456,13 +456,13 @@ static void pdc_atapi_pkt(struct ata_queued_cmd *qc)
 	 * and seq id (byte 2)
 	 */
 	switch (qc->tf.protocol) {
-	case ATA_PROT_ATAPI_DMA:
+	case ATAPI_PROT_DMA:
 		if (!(qc->tf.flags & ATA_TFLAG_WRITE))
 			buf32[0] = cpu_to_le32(PDC_PKT_READ);
 		else
 			buf32[0] = 0;
 		break;
-	case ATA_PROT_ATAPI_NODATA:
+	case ATAPI_PROT_NODATA:
 		buf32[0] = cpu_to_le32(PDC_PKT_NODATA);
 		break;
 	default:
@@ -489,7 +489,7 @@ static void pdc_atapi_pkt(struct ata_queued_cmd *qc)
 	buf[19] = qc->tf.lbal;
 
 	/* set feature and byte counter registers */
-	if (qc->tf.protocol != ATA_PROT_ATAPI_DMA)
+	if (qc->tf.protocol != ATAPI_PROT_DMA)
 		feature = PDC_FEATURE_ATAPI_PIO;
 	else
 		feature = PDC_FEATURE_ATAPI_DMA;
@@ -619,14 +619,14 @@ static void pdc_qc_prep(struct ata_queued_cmd *qc)
 		pdc_pkt_footer(&qc->tf, pp->pkt, i);
 		break;
 
-	case ATA_PROT_ATAPI:
+	case ATAPI_PROT_PIO:
 		pdc_fill_sg(qc);
 		break;
 
-	case ATA_PROT_ATAPI_DMA:
+	case ATAPI_PROT_DMA:
 		pdc_fill_sg(qc);
 		/*FALLTHROUGH*/
-	case ATA_PROT_ATAPI_NODATA:
+	case ATAPI_PROT_NODATA:
 		pdc_atapi_pkt(qc);
 		break;
 
@@ -746,8 +746,8 @@ static inline unsigned int pdc_host_intr(struct ata_port *ap,
 	switch (qc->tf.protocol) {
 	case ATA_PROT_DMA:
 	case ATA_PROT_NODATA:
-	case ATA_PROT_ATAPI_DMA:
-	case ATA_PROT_ATAPI_NODATA:
+	case ATAPI_PROT_DMA:
+	case ATAPI_PROT_NODATA:
 		qc->err_mask |= ac_err_mask(ata_wait_idle(ap));
 		ata_qc_complete(qc);
 		handled = 1;
@@ -892,7 +892,7 @@ static inline void pdc_packet_start(struct ata_queued_cmd *qc)
 static unsigned int pdc_qc_issue_prot(struct ata_queued_cmd *qc)
 {
 	switch (qc->tf.protocol) {
-	case ATA_PROT_ATAPI_NODATA:
+	case ATAPI_PROT_NODATA:
 		if (qc->dev->flags & ATA_DFLAG_CDB_INTR)
 			break;
 		/*FALLTHROUGH*/
@@ -900,7 +900,7 @@ static unsigned int pdc_qc_issue_prot(struct ata_queued_cmd *qc)
 		if (qc->tf.flags & ATA_TFLAG_POLLING)
 			break;
 		/*FALLTHROUGH*/
-	case ATA_PROT_ATAPI_DMA:
+	case ATAPI_PROT_DMA:
 	case ATA_PROT_DMA:
 		pdc_packet_start(qc);
 		return 0;
@@ -914,16 +914,14 @@ static unsigned int pdc_qc_issue_prot(struct ata_queued_cmd *qc)
 
 static void pdc_tf_load_mmio(struct ata_port *ap, const struct ata_taskfile *tf)
 {
-	WARN_ON(tf->protocol == ATA_PROT_DMA ||
-		tf->protocol == ATA_PROT_ATAPI_DMA);
+	WARN_ON(tf->protocol == ATA_PROT_DMA || tf->protocol == ATAPI_PROT_DMA);
 	ata_tf_load(ap, tf);
 }
 
 static void pdc_exec_command_mmio(struct ata_port *ap,
 				  const struct ata_taskfile *tf)
 {
-	WARN_ON(tf->protocol == ATA_PROT_DMA ||
-		tf->protocol == ATA_PROT_ATAPI_DMA);
+	WARN_ON(tf->protocol == ATA_PROT_DMA || tf->protocol == ATAPI_PROT_DMA);
 	ata_exec_command(ap, tf);
 }
 
diff --git a/drivers/ata/sata_qstor.c b/drivers/ata/sata_qstor.c
index 2f1de6e..2875549 100644
--- a/drivers/ata/sata_qstor.c
+++ b/drivers/ata/sata_qstor.c
@@ -376,7 +376,7 @@ static unsigned int qs_qc_issue(struct ata_queued_cmd *qc)
 		qs_packet_start(qc);
 		return 0;
 
-	case ATA_PROT_ATAPI_DMA:
+	case ATAPI_PROT_DMA:
 		BUG();
 		break;
 
diff --git a/drivers/ata/sata_sx4.c b/drivers/ata/sata_sx4.c
index 4d85718..3de0c27 100644
--- a/drivers/ata/sata_sx4.c
+++ b/drivers/ata/sata_sx4.c
@@ -700,7 +700,7 @@ static unsigned int pdc20621_qc_issue_prot(struct ata_queued_cmd *qc)
 		pdc20621_packet_start(qc);
 		return 0;
 
-	case ATA_PROT_ATAPI_DMA:
+	case ATAPI_PROT_DMA:
 		BUG();
 		break;
 
diff --git a/drivers/scsi/ipr.c b/drivers/scsi/ipr.c
index 0841df0..3e78bc2 100644
--- a/drivers/scsi/ipr.c
+++ b/drivers/scsi/ipr.c
@@ -5222,12 +5222,12 @@ static unsigned int ipr_qc_issue(struct ata_queued_cmd *qc)
 		regs->flags |= IPR_ATA_FLAG_XFER_TYPE_DMA;
 		break;
 
-	case ATA_PROT_ATAPI:
-	case ATA_PROT_ATAPI_NODATA:
+	case ATAPI_PROT_PIO:
+	case ATAPI_PROT_NODATA:
 		regs->flags |= IPR_ATA_FLAG_PACKET_CMD;
 		break;
 
-	case ATA_PROT_ATAPI_DMA:
+	case ATAPI_PROT_DMA:
 		regs->flags |= IPR_ATA_FLAG_PACKET_CMD;
 		regs->flags |= IPR_ATA_FLAG_XFER_TYPE_DMA;
 		break;
diff --git a/drivers/scsi/libsas/sas_ata.c b/drivers/scsi/libsas/sas_ata.c
index 831294d..f78d060 100644
--- a/drivers/scsi/libsas/sas_ata.c
+++ b/drivers/scsi/libsas/sas_ata.c
@@ -200,7 +200,7 @@ static unsigned int sas_ata_qc_issue(struct ata_queued_cmd *qc)
 	case ATA_PROT_NCQ:
 		task->ata_task.use_ncq = 1;
 		/* fall through */
-	case ATA_PROT_ATAPI_DMA:
+	case ATAPI_PROT_DMA:
 	case ATA_PROT_DMA:
 		task->ata_task.dma_xfer = 1;
 		break;
diff --git a/include/linux/ata.h b/include/linux/ata.h
index 3992557..0c52476 100644
--- a/include/linux/ata.h
+++ b/include/linux/ata.h
@@ -326,9 +326,9 @@ enum ata_tf_protocols {
 	ATA_PROT_PIO,		/* PIO data xfer */
 	ATA_PROT_DMA,		/* DMA */
 	ATA_PROT_NCQ,		/* NCQ */
-	ATA_PROT_ATAPI,		/* packet command, PIO data xfer*/
-	ATA_PROT_ATAPI_NODATA,	/* packet command, no data */
-	ATA_PROT_ATAPI_DMA,	/* packet command with special DMA sauce */
+	ATAPI_PROT_NODATA,	/* packet command, no data */
+	ATAPI_PROT_PIO,		/* packet command, PIO data xfer*/
+	ATAPI_PROT_DMA,		/* packet command with special DMA sauce */
 };
 
 enum ata_ioctls {
@@ -380,11 +380,11 @@ static inline unsigned int ata_prot_flags(u8 prot)
 		return ATA_PROT_FLAG_DMA;
 	case ATA_PROT_NCQ:
 		return ATA_PROT_FLAG_DMA | ATA_PROT_FLAG_NCQ;
-	case ATA_PROT_ATAPI_NODATA:
+	case ATAPI_PROT_NODATA:
 		return ATA_PROT_FLAG_ATAPI;
-	case ATA_PROT_ATAPI:
+	case ATAPI_PROT_PIO:
 		return ATA_PROT_FLAG_ATAPI | ATA_PROT_FLAG_PIO;
-	case ATA_PROT_ATAPI_DMA:
+	case ATAPI_PROT_DMA:
 		return ATA_PROT_FLAG_ATAPI | ATA_PROT_FLAG_DMA;
 	}
 	return 0;
-- 
1.5.2.4

