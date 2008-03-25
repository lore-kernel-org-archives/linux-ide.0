From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 23/27] libata: remove check_status from non-SFF drivers
Date: Tue, 25 Mar 2008 22:17:01 +0900
Message-ID: <1206451029812-git-send-email-htejun@gmail.com>
References: <1206451025926-git-send-email-htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.184]:62821 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755392AbYCYNRo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 25 Mar 2008 09:17:44 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1755541rvb.1
        for <linux-ide@vger.kernel.org>; Tue, 25 Mar 2008 06:17:44 -0700 (PDT)
In-Reply-To: <1206451025926-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org, liml@rtr.ca, alan@lxorguk.ukuu.org.uk, James.Bottomley@HansenPartnership.com, brking@us.ibm.com, ashish.kalra@freescale.com, leoli@freescale.com
Cc: Tejun Heo <htejun@gmail.com>

Now that all SFF stuff is separated out of core layer, core layer
doesn't call ops->[alt_]check_status().  In fact, no one calls them
for non-SFF drivers anymore.  Kill them.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/ahci.c            |   14 +--------
 drivers/ata/sata_fsl.c        |   60 +++--------------------------------------
 drivers/ata/sata_sil24.c      |   17 +----------
 drivers/scsi/ipr.c            |   28 -------------------
 drivers/scsi/libsas/sas_ata.c |    8 -----
 5 files changed, 8 insertions(+), 119 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index ad5b6f3..9642a71 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -247,7 +247,6 @@ static bool ahci_qc_fill_rtf(struct ata_queued_cmd *qc);
 static int ahci_port_start(struct ata_port *ap);
 static void ahci_port_stop(struct ata_port *ap);
 static void ahci_qc_prep(struct ata_queued_cmd *qc);
-static u8 ahci_check_status(struct ata_port *ap);
 static void ahci_freeze(struct ata_port *ap);
 static void ahci_thaw(struct ata_port *ap);
 static void ahci_pmp_attach(struct ata_port *ap);
@@ -292,9 +291,6 @@ static struct scsi_host_template ahci_sht = {
 static struct ata_port_operations ahci_ops = {
 	.inherits		= &sata_pmp_port_ops,
 
-	.sff_check_status	= ahci_check_status,
-	.sff_check_altstatus	= ahci_check_status,
-
 	.qc_defer		= sata_pmp_qc_defer_cmd_switch,
 	.qc_prep		= ahci_qc_prep,
 	.qc_issue		= ahci_qc_issue,
@@ -1185,11 +1181,12 @@ static int ahci_kick_engine(struct ata_port *ap, int force_restart)
 {
 	void __iomem *port_mmio = ap->ioaddr.cmd_addr;
 	struct ahci_host_priv *hpriv = ap->host->private_data;
+	u8 status = readl(port_mmio + PORT_TFDATA) & 0xFF;
 	u32 tmp;
 	int busy, rc;
 
 	/* do we need to kick the port? */
-	busy = ahci_check_status(ap) & (ATA_BUSY | ATA_DRQ);
+	busy = status & (ATA_BUSY | ATA_DRQ);
 	if (!busy && !force_restart)
 		return 0;
 
@@ -1466,13 +1463,6 @@ static int ahci_pmp_softreset(struct ata_link *link, unsigned int *class,
 	return ahci_do_softreset(link, class, link->pmp, deadline);
 }
 
-static u8 ahci_check_status(struct ata_port *ap)
-{
-	void __iomem *mmio = ap->ioaddr.cmd_addr;
-
-	return readl(mmio + PORT_TFDATA) & 0xFF;
-}
-
 static unsigned int ahci_fill_sg(struct ata_queued_cmd *qc, void *cmd_tbl)
 {
 	struct scatterlist *sg;
diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c
index 646cb28..cfe4677 100644
--- a/drivers/ata/sata_fsl.c
+++ b/drivers/ata/sata_fsl.c
@@ -244,17 +244,6 @@ struct sata_fsl_port_priv {
 	dma_addr_t cmdslot_paddr;
 	struct command_desc *cmdentry;
 	dma_addr_t cmdentry_paddr;
-
-	/*
-	 * SATA FSL controller has a Status FIS which should contain the
-	 * received D2H FIS & taskfile registers. This SFIS is present in
-	 * the command descriptor, and to have a ready reference to it,
-	 * we are caching it here, quite similar to what is done in H/W on
-	 * AHCI compliant devices by copying taskfile fields to a 32-bit
-	 * register.
-	 */
-
-	struct ata_taskfile tf;
 };
 
 /*
@@ -569,31 +558,6 @@ static void sata_fsl_thaw(struct ata_port *ap)
 		ioread32(hcr_base + HCONTROL), ioread32(hcr_base + HSTATUS));
 }
 
-/*
- * NOTE : 1st D2H FIS from device does not update sfis in command descriptor.
- */
-static inline void sata_fsl_cache_taskfile_from_d2h_fis(struct ata_queued_cmd
-							*qc,
-							struct ata_port *ap)
-{
-	struct sata_fsl_port_priv *pp = ap->private_data;
-	struct sata_fsl_host_priv *host_priv = ap->host->private_data;
-	void __iomem *hcr_base = host_priv->hcr_base;
-	unsigned int tag = sata_fsl_tag(qc->tag, hcr_base);
-	struct command_desc *cd;
-
-	cd = pp->cmdentry + tag;
-
-	ata_tf_from_fis(cd->sfis, &pp->tf);
-}
-
-static u8 sata_fsl_check_status(struct ata_port *ap)
-{
-	struct sata_fsl_port_priv *pp = ap->private_data;
-
-	return pp->tf.command;
-}
-
 static int sata_fsl_port_start(struct ata_port *ap)
 {
 	struct device *dev = ap->host->dev;
@@ -1004,10 +968,9 @@ static void sata_fsl_error_intr(struct ata_port *ap)
 	/* record error info */
 	qc = ata_qc_from_tag(ap, link->active_tag);
 
-	if (qc) {
-		sata_fsl_cache_taskfile_from_d2h_fis(qc, qc->ap);
+	if (qc)
 		qc->err_mask |= err_mask;
-	} else
+	else
 		ehi->err_mask |= err_mask;
 
 	ehi->action |= action;
@@ -1020,14 +983,6 @@ static void sata_fsl_error_intr(struct ata_port *ap)
 		ata_port_abort(ap);
 }
 
-static void sata_fsl_qc_complete(struct ata_queued_cmd *qc)
-{
-	if (qc->flags & ATA_QCFLAG_RESULT_TF) {
-		DPRINTK("xx_qc_complete called\n");
-		sata_fsl_cache_taskfile_from_d2h_fis(qc, qc->ap);
-	}
-}
-
 static void sata_fsl_host_intr(struct ata_port *ap)
 {
 	struct ata_link *link = &ap->link;
@@ -1068,10 +1023,8 @@ static void sata_fsl_host_intr(struct ata_port *ap)
 		for (i = 0; i < SATA_FSL_QUEUE_DEPTH; i++) {
 			if (qc_active & (1 << i)) {
 				qc = ata_qc_from_tag(ap, i);
-				if (qc) {
-					sata_fsl_qc_complete(qc);
+				if (qc)
 					ata_qc_complete(qc);
-				}
 				DPRINTK
 				    ("completing ncq cmd,tag=%d,CC=0x%x,CA=0x%x\n",
 				     i, ioread32(hcr_base + CC),
@@ -1087,10 +1040,8 @@ static void sata_fsl_host_intr(struct ata_port *ap)
 		DPRINTK("completing non-ncq cmd, tag=%d,CC=0x%x\n",
 			link->active_tag, ioread32(hcr_base + CC));
 
-		if (qc) {
-			sata_fsl_qc_complete(qc);
+		if (qc)
 			ata_qc_complete(qc);
-		}
 	} else {
 		/* Spurious Interrupt!! */
 		DPRINTK("spurious interrupt!!, CC = 0x%x\n",
@@ -1197,9 +1148,6 @@ static struct scsi_host_template sata_fsl_sht = {
 static const struct ata_port_operations sata_fsl_ops = {
 	.inherits = &sata_port_ops,
 
-	.sff_check_status = sata_fsl_check_status,
-	.sff_check_altstatus = sata_fsl_check_status,
-
 	.qc_prep = sata_fsl_qc_prep,
 	.qc_issue = sata_fsl_qc_issue,
 	.qc_fill_rtf = sata_fsl_qc_fill_rtf,
diff --git a/drivers/ata/sata_sil24.c b/drivers/ata/sata_sil24.c
index 51a7c06..15a4067 100644
--- a/drivers/ata/sata_sil24.c
+++ b/drivers/ata/sata_sil24.c
@@ -336,12 +336,10 @@ static struct sil24_cerr_info {
 struct sil24_port_priv {
 	union sil24_cmd_block *cmd_block;	/* 32 cmd blocks */
 	dma_addr_t cmd_block_dma;		/* DMA base addr for them */
-	struct ata_taskfile tf;			/* Cached taskfile registers */
 	int do_port_rst;
 };
 
 static void sil24_dev_config(struct ata_device *dev);
-static u8 sil24_check_status(struct ata_port *ap);
 static int sil24_scr_read(struct ata_port *ap, unsigned sc_reg, u32 *val);
 static int sil24_scr_write(struct ata_port *ap, unsigned sc_reg, u32 val);
 static int sil24_qc_defer(struct ata_queued_cmd *qc);
@@ -401,8 +399,6 @@ static struct scsi_host_template sil24_sht = {
 static struct ata_port_operations sil24_ops = {
 	.inherits		= &sata_pmp_port_ops,
 
-	.sff_check_status	= sil24_check_status,
-	.sff_check_altstatus	= sil24_check_status,
 	.qc_defer		= sil24_qc_defer,
 	.qc_prep		= sil24_qc_prep,
 	.qc_issue		= sil24_qc_issue,
@@ -492,12 +488,6 @@ static void sil24_read_tf(struct ata_port *ap, int tag, struct ata_taskfile *tf)
 	ata_tf_from_fis(fis, tf);
 }
 
-static u8 sil24_check_status(struct ata_port *ap)
-{
-	struct sil24_port_priv *pp = ap->private_data;
-	return pp->tf.command;
-}
-
 static int sil24_scr_map[] = {
 	[SCR_CONTROL]	= 0,
 	[SCR_STATUS]	= 1,
@@ -1074,10 +1064,9 @@ static void sil24_error_intr(struct ata_port *ap)
 		}
 
 		/* record error info */
-		if (qc) {
-			sil24_read_tf(ap, qc->tag, &pp->tf);
+		if (qc)
 			qc->err_mask |= err_mask;
-		} else
+		else
 			ehi->err_mask |= err_mask;
 
 		ehi->action |= action;
@@ -1210,8 +1199,6 @@ static int sil24_port_start(struct ata_port *ap)
 	if (!pp)
 		return -ENOMEM;
 
-	pp->tf.command = ATA_DRDY;
-
 	cb = dmam_alloc_coherent(dev, cb_size, &cb_dma, GFP_KERNEL);
 	if (!cb)
 		return -ENOMEM;
diff --git a/drivers/scsi/ipr.c b/drivers/scsi/ipr.c
index b079f6c..5a95ea7 100644
--- a/drivers/scsi/ipr.c
+++ b/drivers/scsi/ipr.c
@@ -5246,35 +5246,7 @@ static bool ipr_qc_fill_rtf(struct ata_queued_cmd *qc)
 	return true;
 }
 
-/**
- * ipr_ata_check_status - Return last ATA status
- * @ap:	ATA port
- *
- * Return value:
- * 	ATA status
- **/
-static u8 ipr_ata_check_status(struct ata_port *ap)
-{
-	struct ipr_sata_port *sata_port = ap->private_data;
-	return sata_port->ioasa.status;
-}
-
-/**
- * ipr_ata_check_altstatus - Return last ATA altstatus
- * @ap:	ATA port
- *
- * Return value:
- * 	Alt ATA status
- **/
-static u8 ipr_ata_check_altstatus(struct ata_port *ap)
-{
-	struct ipr_sata_port *sata_port = ap->private_data;
-	return sata_port->ioasa.alt_status;
-}
-
 static struct ata_port_operations ipr_sata_ops = {
-	.sff_check_status = ipr_ata_check_status,
-	.sff_check_altstatus = ipr_ata_check_altstatus,
 	.sff_dev_select = ata_noop_dev_select,
 	.phy_reset = ipr_ata_phy_reset,
 	.hardreset = ipr_sata_reset,
diff --git a/drivers/scsi/libsas/sas_ata.c b/drivers/scsi/libsas/sas_ata.c
index e81f2fd..5c114bb 100644
--- a/drivers/scsi/libsas/sas_ata.c
+++ b/drivers/scsi/libsas/sas_ata.c
@@ -233,12 +233,6 @@ static bool sas_ata_qc_fill_rtf(struct ata_queued_cmd *qc)
 	return true;
 }
 
-static u8 sas_ata_check_status(struct ata_port *ap)
-{
-	struct domain_device *dev = ap->private_data;
-	return dev->sata_dev.tf.command;
-}
-
 static void sas_ata_phy_reset(struct ata_port *ap)
 {
 	struct domain_device *dev = ap->private_data;
@@ -350,8 +344,6 @@ static int sas_ata_scr_read(struct ata_port *ap, unsigned int sc_reg_in,
 }
 
 static struct ata_port_operations sas_sata_ops = {
-	.sff_check_status	= sas_ata_check_status,
-	.sff_check_altstatus	= sas_ata_check_status,
 	.sff_dev_select		= ata_noop_dev_select,
 	.phy_reset		= sas_ata_phy_reset,
 	.post_internal_cmd	= sas_ata_post_internal,
-- 
1.5.2.4

