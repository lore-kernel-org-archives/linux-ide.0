From: Hannes Reinecke <hare@suse.de>
Subject: [PATCH 3/6] ata: add ata_is_fpdma() accessor
Date: Mon, 20 Jun 2016 13:39:13 +0200
Message-ID: <1466422756-126637-4-git-send-email-hare@suse.de>
References: <1466422756-126637-1-git-send-email-hare@suse.de>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:35400 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754688AbcFTLyE (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 20 Jun 2016 07:54:04 -0400
In-Reply-To: <1466422756-126637-1-git-send-email-hare@suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Damien Le Moal <damien.lemoal@hgst.com>, linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>, Hannes Reinecke <hare@suse.com>

Add an accessor ata_is_fpdma() and convert drivers to use it.

Signed-off-by: Hannes Reinecke <hare@suse.com>
---
 drivers/ata/sata_fsl.c |  4 ++--
 drivers/ata/sata_mv.c  |  5 ++---
 drivers/ata/sata_nv.c  | 11 +++++------
 include/linux/libata.h |  6 ++++++
 4 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c
index a723ae9..acfb865 100644
--- a/drivers/ata/sata_fsl.c
+++ b/drivers/ata/sata_fsl.c
@@ -534,7 +534,7 @@ static void sata_fsl_qc_prep(struct ata_queued_cmd *qc)
 	VPRINTK("Dumping cfis : 0x%x, 0x%x, 0x%x\n",
 		cd->cfis[0], cd->cfis[1], cd->cfis[2]);
 
-	if (qc->tf.protocol == ATA_PROT_NCQ) {
+	if (ata_is_fpdma(qc->tf.protocol)) {
 		VPRINTK("FPDMA xfer,Sctor cnt[0:7],[8:15] = %d,%d\n",
 			cd->cfis[3], cd->cfis[11]);
 	}
@@ -551,7 +551,7 @@ static void sata_fsl_qc_prep(struct ata_queued_cmd *qc)
 					    &ttl_dwords, cd_paddr,
 					    host_priv->data_snoop);
 
-	if (qc->tf.protocol == ATA_PROT_NCQ)
+	if (ata_is_fpdma(qc->tf.protocol))
 		desc_info |= FPDMA_QUEUED_CMD;
 
 	sata_fsl_setup_cmd_hdr_entry(pp, tag, desc_info, ttl_dwords,
diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
index bd74ee5..a81b1f8 100644
--- a/drivers/ata/sata_mv.c
+++ b/drivers/ata/sata_mv.c
@@ -1173,7 +1173,7 @@ static void mv_set_irq_coalescing(struct ata_host *host,
 static void mv_start_edma(struct ata_port *ap, void __iomem *port_mmio,
 			 struct mv_port_priv *pp, u8 protocol)
 {
-	int want_ncq = (protocol == ATA_PROT_NCQ);
+	int want_ncq = (ata_is_fpdma(protocol));
 
 	if (pp->pp_flags & MV_PP_FLAG_EDMA_EN) {
 		int using_ncq = ((pp->pp_flags & MV_PP_FLAG_NCQ_EN) != 0);
@@ -2156,8 +2156,7 @@ static void mv_qc_prep_iie(struct ata_queued_cmd *qc)
 	unsigned in_index;
 	u32 flags = 0;
 
-	if ((tf->protocol != ATA_PROT_DMA) &&
-	    (tf->protocol != ATA_PROT_NCQ))
+	if (!ata_is_fpdma(tf->protocol))
 		return;
 	if (tf->command == ATA_CMD_DSM)
 		return;  /* use bmdma for this */
diff --git a/drivers/ata/sata_nv.c b/drivers/ata/sata_nv.c
index 734f563..89e36aa 100644
--- a/drivers/ata/sata_nv.c
+++ b/drivers/ata/sata_nv.c
@@ -1407,7 +1407,7 @@ static void nv_adma_qc_prep(struct ata_queued_cmd *qc)
 	cpb->next_cpb_idx	= 0;
 
 	/* turn on NCQ flags for NCQ commands */
-	if (qc->tf.protocol == ATA_PROT_NCQ)
+	if (ata_is_fpdma(qc->tf.protocol))
 		ctl_flags |= NV_CPB_CTL_QUEUE | NV_CPB_CTL_FPDMA;
 
 	VPRINTK("qc->flags = 0x%lx\n", qc->flags);
@@ -1432,15 +1432,14 @@ static unsigned int nv_adma_qc_issue(struct ata_queued_cmd *qc)
 {
 	struct nv_adma_port_priv *pp = qc->ap->private_data;
 	void __iomem *mmio = pp->ctl_block;
-	int curr_ncq = (qc->tf.protocol == ATA_PROT_NCQ);
+	int curr_ncq = ata_is_fpdma(qc->tf.protocol);
 
 	VPRINTK("ENTER\n");
 
 	/* We can't handle result taskfile with NCQ commands, since
 	   retrieving the taskfile switches us out of ADMA mode and would abort
 	   existing commands. */
-	if (unlikely(qc->tf.protocol == ATA_PROT_NCQ &&
-		     (qc->flags & ATA_QCFLAG_RESULT_TF))) {
+	if (unlikely(curr_ncq && (qc->flags & ATA_QCFLAG_RESULT_TF))) {
 		ata_dev_err(qc->dev, "NCQ w/ RESULT_TF not allowed\n");
 		return AC_ERR_SYSTEM;
 	}
@@ -1991,7 +1990,7 @@ static int nv_swncq_port_start(struct ata_port *ap)
 
 static void nv_swncq_qc_prep(struct ata_queued_cmd *qc)
 {
-	if (qc->tf.protocol != ATA_PROT_NCQ) {
+	if (!ata_is_fpdma(qc->tf.protocol)) {
 		ata_bmdma_qc_prep(qc);
 		return;
 	}
@@ -2067,7 +2066,7 @@ static unsigned int nv_swncq_qc_issue(struct ata_queued_cmd *qc)
 	struct ata_port *ap = qc->ap;
 	struct nv_swncq_port_priv *pp = ap->private_data;
 
-	if (qc->tf.protocol != ATA_PROT_NCQ)
+	if (!ata_is_fpdma(qc->tf.protocol))
 		return ata_bmdma_qc_issue(qc);
 
 	DPRINTK("Enter\n");
diff --git a/include/linux/libata.h b/include/linux/libata.h
index d15c19e..264414c 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -152,6 +152,7 @@ enum {
 	ATA_PROT_FLAG_DATA	= ATA_PROT_FLAG_PIO | ATA_PROT_FLAG_DMA,
 	ATA_PROT_FLAG_NCQ	= (1 << 2), /* is NCQ */
 	ATA_PROT_FLAG_ATAPI	= (1 << 3), /* is ATAPI */
+	ATA_PROT_FLAG_FPDMA	= ATA_PROT_FLAG_NCQ | ATA_PROT_FLAG_DMA,
 
 	/* struct ata_device stuff */
 	ATA_DFLAG_LBA		= (1 << 0), /* device supports LBA */
@@ -1093,6 +1094,11 @@ static inline int ata_is_data(u8 prot)
 	return ata_prot_flags(prot) & ATA_PROT_FLAG_DATA;
 }
 
+static inline int ata_is_fpdma(u8 prot)
+{
+	return ata_prot_flags(prot) & ATA_PROT_FLAG_FPDMA;
+}
+
 static inline int is_multi_taskfile(struct ata_taskfile *tf)
 {
 	return (tf->command == ATA_CMD_READ_MULTI) ||
-- 
1.8.5.6

