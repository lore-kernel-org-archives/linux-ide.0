From: Li Yang <leoli@freescale.com>
Subject: [PATCH 01/12] ata/sata_fsl: Update for ata_link introduction
Date: Wed, 31 Oct 2007 19:27:53 +0800
Message-ID: <1193830084-22298-1-git-send-email-leoli@freescale.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from de01egw01.freescale.net ([192.88.165.102]:56703 "EHLO
	de01egw01.freescale.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753641AbXJaLRo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 31 Oct 2007 07:17:44 -0400
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id l9VBHfHm004825
	for <linux-ide@vger.kernel.org>; Wed, 31 Oct 2007 04:17:41 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net [10.192.129.221])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l9VBHdH5005583
	for <linux-ide@vger.kernel.org>; Wed, 31 Oct 2007 06:17:40 -0500 (CDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org
Cc: Li Yang <leoli@freescale.com>

Update the driver to use the newly added ata_link structure.

Signed-off-by: Li Yang <leoli@freescale.com>
---
 drivers/ata/sata_fsl.c |   31 ++++++++++++++++++-------------
 1 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c
index b4c37b9..8a8ce9d 100644
--- a/drivers/ata/sata_fsl.c
+++ b/drivers/ata/sata_fsl.c
@@ -34,7 +34,8 @@ enum {
 
 	SATA_FSL_HOST_FLAGS	= (ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
 				ATA_FLAG_MMIO | ATA_FLAG_PIO_DMA |
-				ATA_FLAG_NCQ  | ATA_FLAG_SKIP_D2H_BSY),
+				ATA_FLAG_NCQ),
+	SATA_FSL_HOST_LFLAGS	= ATA_LFLAG_SKIP_D2H_BSY,
 
 	SATA_FSL_MAX_CMDS	= SATA_FSL_QUEUE_DEPTH,
 	SATA_FSL_CMD_HDR_SIZE	= 16,	/* 4 DWORDS */
@@ -728,9 +729,10 @@ static unsigned int sata_fsl_dev_classify(struct ata_port *ap)
 	return ata_dev_classify(&tf);
 }
 
-static int sata_fsl_softreset(struct ata_port *ap, unsigned int *class,
+static int sata_fsl_softreset(struct ata_link *link, unsigned int *class,
 			      unsigned long deadline)
 {
+	struct ata_port *ap = link->ap;
 	struct sata_fsl_port_priv *pp = ap->private_data;
 	struct sata_fsl_host_priv *host_priv = ap->host->private_data;
 	void __iomem *hcr_base = host_priv->hcr_base;
@@ -811,7 +813,7 @@ try_offline_again:
 	 */
 
 	temp = ata_wait_register(hcr_base + HSTATUS, 0xFF, 0, 1, 500);
-	if ((!(temp & 0x10)) || ata_port_offline(ap)) {
+	if ((!(temp & 0x10)) || ata_link_offline(link)) {
 		ata_port_printk(ap, KERN_WARNING,
 				"No Device OR PHYRDY change,Hstatus = 0x%x\n",
 				ioread32(hcr_base + HSTATUS));
@@ -842,12 +844,12 @@ try_offline_again:
 	 * reached here, we can send a command to the target device
 	 */
 
-	if (ap->sactive)
+	if (link->sactive)
 		goto skip_srst_do_ncq_error_handling;
 
 	DPRINTK("Sending SRST/device reset\n");
 
-	ata_tf_init(ap->device, &tf);
+	ata_tf_init(link->device, &tf);
 	cfis = (u8 *) & pp->cmdentry->cfis;
 
 	/* device reset/SRST is a control register update FIS, uses tag0 */
@@ -919,7 +921,7 @@ skip_srst_do_ncq_error_handling:
 	VPRINTK("Sending read log ext(10h) command\n");
 
 	memset(&qc, 0, sizeof(struct ata_queued_cmd));
-	ata_tf_init(ap->device, &tf);
+	ata_tf_init(link->device, &tf);
 
 	tf.command = ATA_CMD_READ_LOG_EXT;
 	tf.lbal = ATA_LOG_SATA_NCQ;
@@ -931,7 +933,7 @@ skip_srst_do_ncq_error_handling:
 	qc.tag = ATA_TAG_INTERNAL;
 	qc.scsicmd = NULL;
 	qc.ap = ap;
-	qc.dev = ap->device;
+	qc.dev = link->device;
 
 	qc.tf = tf;
 	qc.flags |= ATA_QCFLAG_RESULT_TF;
@@ -981,7 +983,7 @@ skip_srst_do_ncq_error_handling:
 	*class = ATA_DEV_NONE;
 
 	/* Verify if SStatus indicates device presence */
-	if (ata_port_online(ap)) {
+	if (ata_link_online(link)) {
 		/*
 		 * if we are here, device presence has been detected,
 		 * 1st D2H FIS would have been received, but sfis in
@@ -1042,7 +1044,8 @@ static void sata_fsl_irq_clear(struct ata_port *ap)
 
 static void sata_fsl_error_intr(struct ata_port *ap)
 {
-	struct ata_eh_info *ehi = &ap->eh_info;
+	struct ata_link *link = &ap->link;
+	struct ata_eh_info *ehi = &link->eh_info;
 	struct sata_fsl_host_priv *host_priv = ap->host->private_data;
 	void __iomem *hcr_base = host_priv->hcr_base;
 	u32 hstatus, dereg, cereg = 0, SError = 0;
@@ -1111,7 +1114,7 @@ static void sata_fsl_error_intr(struct ata_port *ap)
 	}
 
 	/* record error info */
-	qc = ata_qc_from_tag(ap, ap->active_tag);
+	qc = ata_qc_from_tag(ap, link->active_tag);
 
 	if (qc) {
 		sata_fsl_cache_taskfile_from_d2h_fis(qc, qc->ap);
@@ -1139,6 +1142,7 @@ static void sata_fsl_qc_complete(struct ata_queued_cmd *qc)
 
 static void sata_fsl_host_intr(struct ata_port *ap)
 {
+	struct ata_link *link = &ap->link;
 	struct sata_fsl_host_priv *host_priv = ap->host->private_data;
 	void __iomem *hcr_base = host_priv->hcr_base;
 	u32 hstatus, qc_active = 0;
@@ -1161,7 +1165,7 @@ static void sata_fsl_host_intr(struct ata_port *ap)
 		return;
 	}
 
-	if (ap->sactive) {	/* only true for NCQ commands */
+	if (link->sactive) {	/* only true for NCQ commands */
 		int i;
 		/* Read command completed register */
 		qc_active = ioread32(hcr_base + CC);
@@ -1190,10 +1194,10 @@ static void sata_fsl_host_intr(struct ata_port *ap)
 
 	} else if (ap->qc_active) {
 		iowrite32(1, hcr_base + CC);
-		qc = ata_qc_from_tag(ap, ap->active_tag);
+		qc = ata_qc_from_tag(ap, link->active_tag);
 
 		DPRINTK("completing non-ncq cmd, tag=%d,CC=0x%x\n",
-			ap->active_tag, ioread32(hcr_base + CC));
+			link->active_tag, ioread32(hcr_base + CC));
 
 		if (qc) {
 			sata_fsl_qc_complete(qc);
@@ -1348,6 +1352,7 @@ static const struct ata_port_operations sata_fsl_ops = {
 static const struct ata_port_info sata_fsl_port_info[] = {
 	{
 	 .flags = SATA_FSL_HOST_FLAGS,
+	 .link_flags = SATA_FSL_HOST_LFLAGS,
 	 .pio_mask = 0x1f,	/* pio 0-4 */
 	 .udma_mask = 0x7f,	/* udma 0-6 */
 	 .port_ops = &sata_fsl_ops,
-- 
1.5.3.2.104.g41ef

