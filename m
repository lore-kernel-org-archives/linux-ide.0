From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 06/10] sata_inic162x: use IDMA for non DMA ATA commands
Date: Wed, 30 Apr 2008 16:35:13 +0900
Message-ID: <1209540919786-git-send-email-htejun@gmail.com>
References: <12095409172824-git-send-email-htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0708.google.com ([209.85.198.245]:29897 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755615AbYD3Hf2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 30 Apr 2008 03:35:28 -0400
Received: by rv-out-0506.google.com with SMTP id k29so211406rvb.1
        for <linux-ide@vger.kernel.org>; Wed, 30 Apr 2008 00:35:27 -0700 (PDT)
In-Reply-To: <12095409172824-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Use IDMA for PIO and non-data commands.  This allows sata_inic162x to
safely drive LBA48 devices.  Kill inic_dev_config() which contains
code to reject LBA48 devices.

With this change, status checking in inic_qc_issue() to avoid hard
lock up after hotplug can go away too.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/sata_inic162x.c |   49 +++++++++++++-----------------------------
 1 files changed, 15 insertions(+), 34 deletions(-)

diff --git a/drivers/ata/sata_inic162x.c b/drivers/ata/sata_inic162x.c
index 094b0ed..c132942 100644
--- a/drivers/ata/sata_inic162x.c
+++ b/drivers/ata/sata_inic162x.c
@@ -356,12 +356,12 @@ static void inic_host_intr(struct ata_port *ap)
 	if (unlikely((irq_stat & PIRQ_ERR) || (idma_stat & IDMA_STAT_ERR)))
 		inic_host_err_intr(ap, irq_stat, idma_stat);
 
-	if (unlikely(!qc || (qc->tf.flags & ATA_TFLAG_POLLING))) {
+	if (unlikely(!qc)) {
 		ap->ops->sff_check_status(ap); /* clear ATA interrupt */
 		goto spurious;
 	}
 
-	if (qc->tf.protocol == ATA_PROT_DMA) {
+	if (!ata_is_atapi(qc->tf.protocol)) {
 		if (likely(idma_stat & IDMA_STAT_DONE)) {
 			inic_stop_idma(ap);
 
@@ -425,11 +425,14 @@ static void inic_fill_sg(struct inic_prd *prd, struct ata_queued_cmd *qc)
 {
 	struct scatterlist *sg;
 	unsigned int si;
-	u8 flags = PRD_DMA;
+	u8 flags = 0;
 
 	if (qc->tf.flags & ATA_TFLAG_WRITE)
 		flags |= PRD_WRITE;
 
+	if (ata_is_dma(qc->tf.protocol))
+		flags |= PRD_DMA;
+
 	for_each_sg(qc->sg, sg, qc->n_elem, si) {
 		prd->mad = cpu_to_le32(sg_dma_address(sg));
 		prd->len = cpu_to_le16(sg_dma_len(sg));
@@ -447,16 +450,20 @@ static void inic_qc_prep(struct ata_queued_cmd *qc)
 	struct inic_pkt *pkt = pp->pkt;
 	struct inic_cpb *cpb = &pkt->cpb;
 	struct inic_prd *prd = pkt->prd;
+	bool is_atapi = ata_is_atapi(qc->tf.protocol);
+	bool is_data = ata_is_data(qc->tf.protocol);
 
 	VPRINTK("ENTER\n");
 
-	if (qc->tf.protocol != ATA_PROT_DMA)
+	if (is_atapi)
 		return;
 
 	/* prepare packet, based on initio driver */
 	memset(pkt, 0, sizeof(struct inic_pkt));
 
-	cpb->ctl_flags = CPB_CTL_VALID | CPB_CTL_IEN | CPB_CTL_DATA;
+	cpb->ctl_flags = CPB_CTL_VALID | CPB_CTL_IEN;
+	if (is_data)
+		cpb->ctl_flags |= CPB_CTL_DATA;
 
 	cpb->len = cpu_to_le32(qc->nbytes);
 	cpb->prd = cpu_to_le32(pp->pkt_dma + offsetof(struct inic_pkt, prd));
@@ -480,7 +487,8 @@ static void inic_qc_prep(struct ata_queued_cmd *qc)
 	/* don't load ctl - dunno why.  it's like that in the initio driver */
 
 	/* setup sg table */
-	inic_fill_sg(prd, qc);
+	if (is_data)
+		inic_fill_sg(prd, qc);
 
 	pp->cpb_tbl[0] = pp->pkt_dma;
 }
@@ -490,7 +498,7 @@ static unsigned int inic_qc_issue(struct ata_queued_cmd *qc)
 	struct ata_port *ap = qc->ap;
 	void __iomem *port_base = inic_port_base(ap);
 
-	if (qc->tf.protocol == ATA_PROT_DMA) {
+	if (!ata_is_atapi(qc->tf.protocol)) {
 		/* fire up the ADMA engine */
 		writew(HCTL_FTHD0, port_base + HOST_CTL);
 		writew(IDMA_CTL_GO, port_base + PORT_IDMA_CTL);
@@ -499,18 +507,6 @@ static unsigned int inic_qc_issue(struct ata_queued_cmd *qc)
 		return 0;
 	}
 
-	/* Issuing a command to yet uninitialized port locks up the
-	 * controller.  Most of the time, this happens for the first
-	 * command after reset which are ATA and ATAPI IDENTIFYs.
-	 * Fast fail if stat is 0x7f or 0xff for those commands.
-	 */
-	if (unlikely(qc->tf.command == ATA_CMD_ID_ATA ||
-		     qc->tf.command == ATA_CMD_ID_ATAPI)) {
-		u8 stat = ap->ops->sff_check_status(ap);
-		if (stat == 0x7f || stat == 0xff)
-			return AC_ERR_HSM;
-	}
-
 	return ata_sff_qc_issue(qc);
 }
 
@@ -653,20 +649,6 @@ static void inic_post_internal_cmd(struct ata_queued_cmd *qc)
 		inic_reset_port(inic_port_base(qc->ap));
 }
 
-static void inic_dev_config(struct ata_device *dev)
-{
-	/* inic can only handle upto LBA28 max sectors */
-	if (dev->max_sectors > ATA_MAX_SECTORS)
-		dev->max_sectors = ATA_MAX_SECTORS;
-
-	if (dev->n_sectors >= 1 << 28) {
-		ata_dev_printk(dev, KERN_ERR,
-	"ERROR: This driver doesn't support LBA48 yet and may cause\n"
-	"                data corruption on such devices.  Disabling.\n");
-		ata_dev_disable(dev);
-	}
-}
-
 static void init_port(struct ata_port *ap)
 {
 	void __iomem *port_base = inic_port_base(ap);
@@ -732,7 +714,6 @@ static struct ata_port_operations inic_port_ops = {
 	.hardreset		= inic_hardreset,
 	.error_handler		= inic_error_handler,
 	.post_internal_cmd	= inic_post_internal_cmd,
-	.dev_config		= inic_dev_config,
 
 	.scr_read		= inic_scr_read,
 	.scr_write		= inic_scr_write,
-- 
1.5.2.4

