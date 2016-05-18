From: Damien Le Moal <Damien.LeMoal@hgst.com>
Subject: [PATCH 3/3] libata: Fix ATA_CMD_NCQ_NON_DATA processing
Date: Wed, 18 May 2016 00:53:32 +0000
Message-ID: <BL2PR04MB19695B3F06C3DFC85D102A629F490@BL2PR04MB1969.namprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from sjc00mx2.hgst.com ([199.255.44.37]:32371 "EHLO
	sjc00mx2.hgst.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751513AbcERAxf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 17 May 2016 20:53:35 -0400
Content-Language: en-US
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Hannes Reinecke <hare@suse.com>

For this NCQ command, ata_is_data and ata_is_dma
always return true since its protocol is ATA_PROT_NCQ.
Since this command has no data, both should return false.
This is fixed by changing the interface of these two
functions to take a pointer to the command task file
so that the command code can be tested in addition to
the command protocol value.

Signed-off-by: Damien Le Moal <damien.lemoal@hgst.com>
---
  drivers/ata/libata-core.c    |  4 ++--
  drivers/ata/libata-sff.c     | 10 +++++-----
  drivers/ata/pata_arasan_cf.c |  4 ++--
  drivers/ata/sata_dwc_460ex.c |  6 +++---
  drivers/ata/sata_inic162x.c  |  4 ++--
  drivers/ata/sata_sil.c       |  4 ++--
  drivers/ata/sata_sil24.c     |  4 ++--
  include/linux/libata.h       | 18 ++++++++++++++----
  8 files changed, 32 insertions(+), 22 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 97f3170..54acdb0 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -5246,11 +5246,11 @@ void ata_qc_issue(struct ata_queued_cmd *qc)
  	 * We guarantee to LLDs that they will have at least one
  	 * non-zero sg if the command is a data command.
  	 */
-	if (WARN_ON_ONCE(ata_is_data(prot) &&
+	if (WARN_ON_ONCE(ata_is_data(&qc->tf) &&
  			 (!qc->sg || !qc->n_elem || !qc->nbytes)))
  		goto sys_err;

-	if (ata_is_dma(prot) || (ata_is_pio(prot) &&
+	if (ata_is_dma(&qc->tf) || (ata_is_pio(prot) &&
  				 (ap->flags & ATA_FLAG_PIO_DMA)))
  		if (ata_sg_setup(qc))
  			goto sys_err;
diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index 051b615..82ee879 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -2784,7 +2784,7 @@ unsigned int ata_bmdma_qc_issue(struct 
ata_queued_cmd *qc)
  	struct ata_link *link = qc->dev->link;

  	/* defer PIO handling to sff_qc_issue */
-	if (!ata_is_dma(qc->tf.protocol))
+	if (!ata_is_dma(&qc->tf))
  		return ata_sff_qc_issue(qc);

  	/* select the device */
@@ -2842,7 +2842,7 @@ unsigned int ata_bmdma_port_intr(struct ata_port 
*ap, struct ata_queued_cmd *qc)
  	bool bmdma_stopped = false;
  	unsigned int handled;

-	if (ap->hsm_task_state == HSM_ST_LAST && ata_is_dma(qc->tf.protocol)) {
+	if (ap->hsm_task_state == HSM_ST_LAST && ata_is_dma(&qc->tf)) {
  		/* check status of DMA engine */
  		host_stat = ap->ops->bmdma_status(ap);
  		VPRINTK("ata%u: host_stat 0x%X\n", ap->print_id, host_stat);
@@ -2864,7 +2864,7 @@ unsigned int ata_bmdma_port_intr(struct ata_port 
*ap, struct ata_queued_cmd *qc)

  	handled = __ata_sff_port_intr(ap, qc, bmdma_stopped);

-	if (unlikely(qc->err_mask) && ata_is_dma(qc->tf.protocol))
+	if (unlikely(qc->err_mask) && ata_is_dma(&qc->tf))
  		ata_ehi_push_desc(ehi, "BMDMA stat 0x%x", host_stat);

  	return handled;
@@ -2916,7 +2916,7 @@ void ata_bmdma_error_handler(struct ata_port *ap)
  	/* reset PIO HSM and stop DMA engine */
  	spin_lock_irqsave(ap->lock, flags);

-	if (qc && ata_is_dma(qc->tf.protocol)) {
+	if (qc && ata_is_dma(&qc->tf)) {
  		u8 host_stat;

  		host_stat = ap->ops->bmdma_status(ap);
@@ -2962,7 +2962,7 @@ void ata_bmdma_post_internal_cmd(struct 
ata_queued_cmd *qc)
  	struct ata_port *ap = qc->ap;
  	unsigned long flags;

-	if (ata_is_dma(qc->tf.protocol)) {
+	if (ata_is_dma(&qc->tf)) {
  		spin_lock_irqsave(ap->lock, flags);
  		ap->ops->bmdma_stop(qc);
  		spin_unlock_irqrestore(ap->lock, flags);
diff --git a/drivers/ata/pata_arasan_cf.c b/drivers/ata/pata_arasan_cf.c
index 80fe0f6..9c92ac2 100644
--- a/drivers/ata/pata_arasan_cf.c
+++ b/drivers/ata/pata_arasan_cf.c
@@ -370,7 +370,7 @@ static inline void dma_complete(struct arasan_cf_dev 
*acdev)
  	ata_sff_interrupt(acdev->irq, acdev->host);

  	spin_lock_irqsave(&acdev->host->lock, flags);
-	if (unlikely(qc->err_mask) && ata_is_dma(qc->tf.protocol))
+	if (unlikely(qc->err_mask) && ata_is_dma(&qc->tf))
  		ata_ehi_push_desc(&qc->ap->link.eh_info, "DMA Failed: Timeout");
  	spin_unlock_irqrestore(&acdev->host->lock, flags);
  }
@@ -689,7 +689,7 @@ static unsigned int arasan_cf_qc_issue(struct 
ata_queued_cmd *qc)
  	struct arasan_cf_dev *acdev = ap->host->private_data;

  	/* defer PIO handling to sff_qc_issue */
-	if (!ata_is_dma(qc->tf.protocol))
+	if (!ata_is_dma(&qc->tf))
  		return ata_sff_qc_issue(qc);

  	/* select the device */
diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.c
index 9020349..3a183b1 100644
--- a/drivers/ata/sata_dwc_460ex.c
+++ b/drivers/ata/sata_dwc_460ex.c
@@ -540,7 +540,7 @@ static irqreturn_t sata_dwc_isr(int irq, void 
*dev_instance)
  		dev_dbg(ap->dev, "%s non-NCQ cmd interrupt, protocol: %s\n",
  			__func__, get_prot_descript(qc->tf.protocol));
  DRVSTILLBUSY:
-		if (ata_is_dma(qc->tf.protocol)) {
+		if (ata_is_dma(&qc->tf)) {
  			/*
  			 * Each DMA transaction produces 2 interrupts. The DMAC
  			 * transfer complete interrupt and the SATA controller
@@ -629,7 +629,7 @@ DRVSTILLBUSY:
  		/* Process completed command */
  		dev_dbg(ap->dev, "%s NCQ command, protocol: %s\n", __func__,
  			get_prot_descript(qc->tf.protocol));
-		if (ata_is_dma(qc->tf.protocol)) {
+		if (ata_is_dma(&qc->tf)) {
  			hsdevp->dma_interrupt_count++;
  			if (hsdevp->dma_pending[tag] == \
  					SATA_DWC_DMA_PENDING_NONE)
@@ -720,7 +720,7 @@ static void sata_dwc_dma_xfer_complete(struct 
ata_port *ap, u32 check_status)
  	}
  #endif

-	if (ata_is_dma(qc->tf.protocol)) {
+	if (ata_is_dma(&qc->tf)) {
  		if (hsdevp->dma_pending[tag] == SATA_DWC_DMA_PENDING_NONE) {
  			dev_err(ap->dev,
  				"%s DMA protocol RX and TX DMA not pending dmacr: 0x%08x\n",
diff --git a/drivers/ata/sata_inic162x.c b/drivers/ata/sata_inic162x.c
index e81a821..49d6a3d 100644
--- a/drivers/ata/sata_inic162x.c
+++ b/drivers/ata/sata_inic162x.c
@@ -458,7 +458,7 @@ static void inic_fill_sg(struct inic_prd *prd, 
struct ata_queued_cmd *qc)
  	if (qc->tf.flags & ATA_TFLAG_WRITE)
  		flags |= PRD_WRITE;

-	if (ata_is_dma(qc->tf.protocol))
+	if (ata_is_dma(&qc->tf))
  		flags |= PRD_DMA;

  	for_each_sg(qc->sg, sg, qc->n_elem, si) {
@@ -479,7 +479,7 @@ static void inic_qc_prep(struct ata_queued_cmd *qc)
  	struct inic_cpb *cpb = &pkt->cpb;
  	struct inic_prd *prd = pkt->prd;
  	bool is_atapi = ata_is_atapi(qc->tf.protocol);
-	bool is_data = ata_is_data(qc->tf.protocol);
+	bool is_data = ata_is_data(&qc->tf);
  	unsigned int cdb_len = 0;

  	VPRINTK("ENTER\n");
diff --git a/drivers/ata/sata_sil.c b/drivers/ata/sata_sil.c
index 29bcff0..d762221 100644
--- a/drivers/ata/sata_sil.c
+++ b/drivers/ata/sata_sil.c
@@ -480,7 +480,7 @@ static void sil_host_intr(struct ata_port *ap, u32 
bmdma2)
  			goto err_hsm;
  		break;
  	case HSM_ST_LAST:
-		if (ata_is_dma(qc->tf.protocol)) {
+		if (ata_is_dma(&qc->tf)) {
  			/* clear DMA-Start bit */
  			ap->ops->bmdma_stop(qc);

@@ -507,7 +507,7 @@ static void sil_host_intr(struct ata_port *ap, u32 
bmdma2)
  	/* kick HSM in the ass */
  	ata_sff_hsm_move(ap, qc, status, 0);

-	if (unlikely(qc->err_mask) && ata_is_dma(qc->tf.protocol))
+	if (unlikely(qc->err_mask) && ata_is_dma(&qc->tf))
  		ata_ehi_push_desc(ehi, "BMDMA2 stat 0x%x", bmdma2);

  	return;
diff --git a/drivers/ata/sata_sil24.c b/drivers/ata/sata_sil24.c
index 4b1995e..fa9a848 100644
--- a/drivers/ata/sata_sil24.c
+++ b/drivers/ata/sata_sil24.c
@@ -854,7 +854,7 @@ static void sil24_qc_prep(struct ata_queued_cmd *qc)
  	if (!ata_is_atapi(qc->tf.protocol)) {
  		prb = &cb->ata.prb;
  		sge = cb->ata.sge;
-		if (ata_is_data(qc->tf.protocol)) {
+		if (ata_is_data(&qc->tf)) {
  			u16 prot = 0;
  			ctrl = PRB_CTRL_PROTOCOL;
  			if (ata_is_ncq(qc->tf.protocol))
@@ -871,7 +871,7 @@ static void sil24_qc_prep(struct ata_queued_cmd *qc)
  		memset(cb->atapi.cdb, 0, sizeof(cb->atapi.cdb));
  		memcpy(cb->atapi.cdb, qc->cdb, qc->dev->cdb_len);

-		if (ata_is_data(qc->tf.protocol)) {
+		if (ata_is_data(&qc->tf)) {
  			if (qc->tf.flags & ATA_TFLAG_WRITE)
  				ctrl = PRB_CTRL_PACKET_WRITE;
  			else
diff --git a/include/linux/libata.h b/include/linux/libata.h
index d15c19e..e4952c7 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -1078,9 +1078,14 @@ static inline int ata_is_pio(u8 prot)
  	return ata_prot_flags(prot) & ATA_PROT_FLAG_PIO;
  }

-static inline int ata_is_dma(u8 prot)
+static inline int ata_is_dma(struct ata_taskfile *tf)
  {
-	return ata_prot_flags(prot) & ATA_PROT_FLAG_DMA;
+	switch(tf->command) {
+	case ATA_CMD_NCQ_NON_DATA:
+		return 0;
+	default:
+		return ata_prot_flags(tf->protocol) & ATA_PROT_FLAG_DMA;
+	}
  }

  static inline int ata_is_ncq(u8 prot)
@@ -1088,9 +1093,14 @@ static inline int ata_is_ncq(u8 prot)
  	return ata_prot_flags(prot) & ATA_PROT_FLAG_NCQ;
  }

-static inline int ata_is_data(u8 prot)
+static inline int ata_is_data(struct ata_taskfile *tf)
  {
-	return ata_prot_flags(prot) & ATA_PROT_FLAG_DATA;
+	switch(tf->command) {
+	case ATA_CMD_NCQ_NON_DATA:
+		return 0;
+	default:
+		return ata_prot_flags(tf->protocol) & ATA_PROT_FLAG_DATA;
+	}
  }

  static inline int is_multi_taskfile(struct ata_taskfile *tf)
-- 
2.5.5


-- 
Damien Le Moal, Ph.D.
Sr. Manager, System Software Group, HGST Research,
HGST, a Western Digital company
Damien.LeMoal@hgst.com
(+81) 0466-98-3593 (ext. 513593)
1 kirihara-cho, Fujisawa,
Kanagawa, 252-0888 Japan
www.hgst.com
Western Digital Corporation (and its subsidiaries) E-mail Confidentiality Notice & Disclaimer:

This e-mail and any files transmitted with it may contain confidential or legally privileged information of WDC and/or its affiliates, and are intended solely for the use of the individual or entity to which they are addressed. If you are not the intended recipient, any disclosure, copying, distribution or any action taken or omitted to be taken in reliance on it, is prohibited. If you have received this e-mail in error, please notify the sender immediately and delete the e-mail in its entirety from your system.

