From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 07/10] sata_inic162x: use IDMA for ATAPI commands
Date: Wed, 30 Apr 2008 16:35:14 +0900
Message-ID: <12095409193866-git-send-email-htejun@gmail.com>
References: <12095409172824-git-send-email-htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0708.google.com ([209.85.198.245]:29897 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755642AbYD3Hf3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 30 Apr 2008 03:35:29 -0400
Received: by rv-out-0506.google.com with SMTP id k29so211406rvb.1
        for <linux-ide@vger.kernel.org>; Wed, 30 Apr 2008 00:35:29 -0700 (PDT)
In-Reply-To: <12095409172824-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Use IDMA for ATAPI commands.  Write and some misc commands time out
when executed using ATAPI_PROT_DMA but ATAPI_PROT_PIO works fine.  As
PIO is driven by DMA too, it doesn't make any noticeable difference
for native SATA devices.  inic_check_atapi_dma() is implemented to
force PIO for those ATAPI commands.

After this change, sata_inic162x issues all commands using IDMA.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/sata_inic162x.c |   81 +++++++++++++++++++++++++------------------
 1 files changed, 47 insertions(+), 34 deletions(-)

diff --git a/drivers/ata/sata_inic162x.c b/drivers/ata/sata_inic162x.c
index c132942..a31dc24 100644
--- a/drivers/ata/sata_inic162x.c
+++ b/drivers/ata/sata_inic162x.c
@@ -192,7 +192,8 @@ struct inic_prd {
 
 struct inic_pkt {
 	struct inic_cpb	cpb;
-	struct inic_prd	prd[LIBATA_MAX_PRD];
+	struct inic_prd	prd[LIBATA_MAX_PRD + 1];	/* + 1 for cdb */
+	u8		cdb[ATAPI_CDB_LEN];
 } __packed;
 
 struct inic_host_priv {
@@ -361,23 +362,18 @@ static void inic_host_intr(struct ata_port *ap)
 		goto spurious;
 	}
 
-	if (!ata_is_atapi(qc->tf.protocol)) {
-		if (likely(idma_stat & IDMA_STAT_DONE)) {
-			inic_stop_idma(ap);
+	if (likely(idma_stat & IDMA_STAT_DONE)) {
+		inic_stop_idma(ap);
 
-			/* Depending on circumstances, device error
-			 * isn't reported by IDMA, check it explicitly.
-			 */
-			if (unlikely(readb(port_base + PORT_TF_COMMAND) &
-				     (ATA_DF | ATA_ERR)))
-				qc->err_mask |= AC_ERR_DEV;
+		/* Depending on circumstances, device error
+		 * isn't reported by IDMA, check it explicitly.
+		 */
+		if (unlikely(readb(port_base + PORT_TF_COMMAND) &
+			     (ATA_DF | ATA_ERR)))
+			qc->err_mask |= AC_ERR_DEV;
 
-			ata_qc_complete(qc);
-			return;
-		}
-	} else {
-		if (likely(ata_sff_host_intr(ap, qc)))
-			return;
+		ata_qc_complete(qc);
+		return;
 	}
 
  spurious:
@@ -421,6 +417,19 @@ static irqreturn_t inic_interrupt(int irq, void *dev_instance)
 	return IRQ_RETVAL(handled);
 }
 
+static int inic_check_atapi_dma(struct ata_queued_cmd *qc)
+{
+	/* For some reason ATAPI_PROT_DMA doesn't work for some
+	 * commands including writes and other misc ops.  Use PIO
+	 * protocol instead, which BTW is driven by the DMA engine
+	 * anyway, so it shouldn't make much difference for native
+	 * SATA devices.
+	 */
+	if (atapi_cmd_type(qc->cdb[0]) == READ)
+		return 0;
+	return 1;
+}
+
 static void inic_fill_sg(struct inic_prd *prd, struct ata_queued_cmd *qc)
 {
 	struct scatterlist *sg;
@@ -452,20 +461,21 @@ static void inic_qc_prep(struct ata_queued_cmd *qc)
 	struct inic_prd *prd = pkt->prd;
 	bool is_atapi = ata_is_atapi(qc->tf.protocol);
 	bool is_data = ata_is_data(qc->tf.protocol);
+	unsigned int cdb_len = 0;
 
 	VPRINTK("ENTER\n");
 
 	if (is_atapi)
-		return;
+		cdb_len = qc->dev->cdb_len;
 
 	/* prepare packet, based on initio driver */
 	memset(pkt, 0, sizeof(struct inic_pkt));
 
 	cpb->ctl_flags = CPB_CTL_VALID | CPB_CTL_IEN;
-	if (is_data)
+	if (is_atapi || is_data)
 		cpb->ctl_flags |= CPB_CTL_DATA;
 
-	cpb->len = cpu_to_le32(qc->nbytes);
+	cpb->len = cpu_to_le32(qc->nbytes + cdb_len);
 	cpb->prd = cpu_to_le32(pp->pkt_dma + offsetof(struct inic_pkt, prd));
 
 	cpb->device = qc->tf.device;
@@ -486,6 +496,18 @@ static void inic_qc_prep(struct ata_queued_cmd *qc)
 	cpb->command = qc->tf.command;
 	/* don't load ctl - dunno why.  it's like that in the initio driver */
 
+	/* setup PRD for CDB */
+	if (is_atapi) {
+		memcpy(pkt->cdb, qc->cdb, ATAPI_CDB_LEN);
+		prd->mad = cpu_to_le32(pp->pkt_dma +
+				       offsetof(struct inic_pkt, cdb));
+		prd->len = cpu_to_le16(cdb_len);
+		prd->flags = PRD_CDB | PRD_WRITE;
+		if (!is_data)
+			prd->flags |= PRD_END;
+		prd++;
+	}
+
 	/* setup sg table */
 	if (is_data)
 		inic_fill_sg(prd, qc);
@@ -498,16 +520,12 @@ static unsigned int inic_qc_issue(struct ata_queued_cmd *qc)
 	struct ata_port *ap = qc->ap;
 	void __iomem *port_base = inic_port_base(ap);
 
-	if (!ata_is_atapi(qc->tf.protocol)) {
-		/* fire up the ADMA engine */
-		writew(HCTL_FTHD0, port_base + HOST_CTL);
-		writew(IDMA_CTL_GO, port_base + PORT_IDMA_CTL);
-		writeb(0, port_base + PORT_CPB_PTQFIFO);
+	/* fire up the ADMA engine */
+	writew(HCTL_FTHD0, port_base + HOST_CTL);
+	writew(IDMA_CTL_GO, port_base + PORT_IDMA_CTL);
+	writeb(0, port_base + PORT_CPB_PTQFIFO);
 
-		return 0;
-	}
-
-	return ata_sff_qc_issue(qc);
+	return 0;
 }
 
 static void inic_tf_read(struct ata_port *ap, struct ata_taskfile *tf)
@@ -704,6 +722,7 @@ static int inic_port_start(struct ata_port *ap)
 static struct ata_port_operations inic_port_ops = {
 	.inherits		= &ata_sff_port_ops,
 
+	.check_atapi_dma	= inic_check_atapi_dma,
 	.qc_prep		= inic_qc_prep,
 	.qc_issue		= inic_qc_issue,
 	.qc_fill_rtf		= inic_qc_fill_rtf,
@@ -723,12 +742,6 @@ static struct ata_port_operations inic_port_ops = {
 };
 
 static struct ata_port_info inic_port_info = {
-	/* For some reason, ATAPI_PROT_PIO is broken on this
-	 * controller, and no, PIO_POLLING does't fix it.  It somehow
-	 * manages to report the wrong ireason and ignoring ireason
-	 * results in machine lock up.  Tell libata to always prefer
-	 * DMA.
-	 */
 	.flags			= ATA_FLAG_SATA | ATA_FLAG_PIO_DMA,
 	.pio_mask		= 0x1f,	/* pio0-4 */
 	.mwdma_mask		= 0x07, /* mwdma0-2 */
-- 
1.5.2.4

