From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 14/14] ahci: implement NCQ suppport
Date: Mon, 3 Apr 2006 17:32:40 +0900
Message-ID: <11440531604004-git-send-email-htejun@gmail.com>
References: <1144053158183-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from xproxy.gmail.com ([66.249.82.203]:7526 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751661AbWDCIc6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 3 Apr 2006 04:32:58 -0400
Received: by xproxy.gmail.com with SMTP id t10so764247wxc
        for <linux-ide@vger.kernel.org>; Mon, 03 Apr 2006 01:32:58 -0700 (PDT)
In-Reply-To: <1144053158183-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, albertcc@tw.ibm.com, axboe@suse.de, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Implement NCQ support.

Original implementation is from Jens Axboe.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/ahci.c |   82 ++++++++++++++++++++++++++++++++++-----------------
 1 files changed, 54 insertions(+), 28 deletions(-)

4d81afc6685879024602ce293215a70a3fe0a441
diff --git a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
index 8201a06..fb89fca 100644
--- a/drivers/scsi/ahci.c
+++ b/drivers/scsi/ahci.c
@@ -56,9 +56,9 @@ enum {
 	AHCI_MAX_SG		= 168, /* hardware max is 64K */
 	AHCI_DMA_BOUNDARY	= 0xffffffff,
 	AHCI_USE_CLUSTERING	= 0,
-	AHCI_MAX_CMDS		= 1,
+	AHCI_MAX_CMDS		= 32,
 	AHCI_CMD_SZ		= 32,
-	AHCI_CMD_SLOT_SZ	= 32 * AHCI_CMD_SZ,
+	AHCI_CMD_SLOT_SZ	= AHCI_MAX_CMDS * AHCI_CMD_SZ,
 	AHCI_RX_FIS_SZ		= 256,
 	AHCI_CMD_TBL_CDB	= 0x40,
 	AHCI_CMD_TBL_HDR_SZ	= 0x80,
@@ -216,7 +216,8 @@ static struct scsi_host_template ahci_sh
 	.ioctl			= ata_scsi_ioctl,
 	.queuecommand		= ata_scsi_queuecmd,
 	.eh_strategy_handler	= ata_scsi_error,
-	.can_queue		= ATA_DEF_QUEUE,
+	.change_queue_depth	= ata_scsi_change_queue_depth,
+	.can_queue		= AHCI_MAX_CMDS - 1,
 	.this_id		= ATA_SHT_THIS_ID,
 	.sg_tablesize		= AHCI_MAX_SG,
 	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
@@ -516,12 +517,17 @@ static unsigned int ahci_dev_classify(st
 	return ata_dev_classify(&tf);
 }
 
-static void ahci_fill_cmd_slot(struct ahci_port_priv *pp, u32 opts)
+static void ahci_fill_cmd_slot(struct ahci_port_priv *pp, unsigned int tag,
+			       u32 opts)
 {
-	pp->cmd_slot[0].opts = cpu_to_le32(opts);
-	pp->cmd_slot[0].status = 0;
-	pp->cmd_slot[0].tbl_addr = cpu_to_le32(pp->cmd_tbl_dma & 0xffffffff);
-	pp->cmd_slot[0].tbl_addr_hi = cpu_to_le32((pp->cmd_tbl_dma >> 16) >> 16);
+	dma_addr_t cmd_tbl_dma;
+
+	cmd_tbl_dma = pp->cmd_tbl_dma + tag * AHCI_CMD_TBL_SZ;
+
+	pp->cmd_slot[tag].opts = cpu_to_le32(opts);
+	pp->cmd_slot[tag].status = 0;
+	pp->cmd_slot[tag].tbl_addr = cpu_to_le32(cmd_tbl_dma & 0xffffffff);
+	pp->cmd_slot[tag].tbl_addr_hi = cpu_to_le32((cmd_tbl_dma >> 16) >> 16);
 }
 
 static int ahci_poll_register(void __iomem *reg, u32 mask, u32 val,
@@ -600,7 +606,8 @@ static int ahci_softreset(struct ata_por
 	fis = pp->cmd_tbl;
 
 	/* issue the first D2H Register FIS */
-	ahci_fill_cmd_slot(pp, cmd_fis_len | AHCI_CMD_RESET | AHCI_CMD_CLR_BUSY);
+	ahci_fill_cmd_slot(pp, 0,
+			   cmd_fis_len | AHCI_CMD_RESET | AHCI_CMD_CLR_BUSY);
 
 	tf.ctl |= ATA_SRST;
 	ata_tf_to_fis(&tf, fis, 0);
@@ -619,7 +626,7 @@ static int ahci_softreset(struct ata_por
 	msleep(1);
 
 	/* issue the second D2H Register FIS */
-	ahci_fill_cmd_slot(pp, cmd_fis_len);
+	ahci_fill_cmd_slot(pp, 0, cmd_fis_len);
 
 	tf.ctl &= ~ATA_SRST;
 	ata_tf_to_fis(&tf, fis, 0);
@@ -722,9 +729,8 @@ static void ahci_tf_read(struct ata_port
 	ata_tf_from_fis(d2h_fis, tf);
 }
 
-static unsigned int ahci_fill_sg(struct ata_queued_cmd *qc)
+static unsigned int ahci_fill_sg(struct ata_queued_cmd *qc, void *cmd_tbl)
 {
-	struct ahci_port_priv *pp = qc->ap->private_data;
 	struct scatterlist *sg;
 	struct ahci_sg *ahci_sg;
 	unsigned int n_sg = 0;
@@ -734,7 +740,7 @@ static unsigned int ahci_fill_sg(struct 
 	/*
 	 * Next, the S/G list.
 	 */
-	ahci_sg = pp->cmd_tbl + AHCI_CMD_TBL_HDR_SZ;
+	ahci_sg = cmd_tbl + AHCI_CMD_TBL_HDR_SZ;
 	ata_for_each_sg(sg, qc) {
 		dma_addr_t addr = sg_dma_address(sg);
 		u32 sg_len = sg_dma_len(sg);
@@ -755,6 +761,7 @@ static void ahci_qc_prep(struct ata_queu
 	struct ata_port *ap = qc->ap;
 	struct ahci_port_priv *pp = ap->private_data;
 	int is_atapi = is_atapi_taskfile(&qc->tf);
+	void *cmd_tbl;
 	u32 opts;
 	const u32 cmd_fis_len = 5; /* five dwords */
 	unsigned int n_elem;
@@ -763,16 +770,17 @@ static void ahci_qc_prep(struct ata_queu
 	 * Fill in command table information.  First, the header,
 	 * a SATA Register - Host to Device command FIS.
 	 */
-	ata_tf_to_fis(&qc->tf, pp->cmd_tbl, 0);
+	cmd_tbl = pp->cmd_tbl + qc->tag * AHCI_CMD_TBL_SZ;
+
+	ata_tf_to_fis(&qc->tf, cmd_tbl, 0);
 	if (is_atapi) {
-		memset(pp->cmd_tbl + AHCI_CMD_TBL_CDB, 0, 32);
-		memcpy(pp->cmd_tbl + AHCI_CMD_TBL_CDB, qc->cdb,
-		       qc->dev->cdb_len);
+		memset(cmd_tbl + AHCI_CMD_TBL_CDB, 0, 32);
+		memcpy(cmd_tbl + AHCI_CMD_TBL_CDB, qc->cdb, qc->dev->cdb_len);
 	}
 
 	n_elem = 0;
 	if (qc->flags & ATA_QCFLAG_DMAMAP)
-		n_elem = ahci_fill_sg(qc);
+		n_elem = ahci_fill_sg(qc, cmd_tbl);
 
 	/*
 	 * Fill in command slot information.
@@ -783,7 +791,7 @@ static void ahci_qc_prep(struct ata_queu
 	if (is_atapi)
 		opts |= AHCI_CMD_ATAPI | AHCI_CMD_PREFETCH;
 
-	ahci_fill_cmd_slot(pp, opts);
+	ahci_fill_cmd_slot(pp, qc->tag, opts);
 }
 
 static unsigned int ahci_eh_autopsy(struct ata_port *ap,
@@ -863,7 +871,7 @@ static void ahci_error_handler(struct at
 	}
 
 	/* perform recovery */
-	qc = ata_eh_determine_qc(ap, 0, &tf);
+	qc = ata_eh_determine_qc(ap, irq_stat & PORT_IRQ_TF_ERR, &tf);
 
 	action |= ahci_eh_autopsy(ap, qc, irq_stat, desc, sizeof(desc));
 	action |= ata_eh_autopsy(ap, qc, &tf, serror);
@@ -893,10 +901,11 @@ static void ahci_post_internal_cmd(struc
 
 static inline int ahci_host_intr(struct ata_port *ap)
 {
+	static int spurious_cnt = 10;
 	struct ahci_port_priv *pp = ap->private_data;
 	void __iomem *mmio = ap->host_set->mmio_base;
 	void __iomem *port_mmio = ahci_port_base(mmio, ap->port_no);
-	u32 status, serror, ci;
+	u32 status, sactive, serror, ci;
 	unsigned int eh_flags;
 
 	status = readl(port_mmio + PORT_IRQ_STAT);
@@ -914,18 +923,28 @@ static inline int ahci_host_intr(struct 
 	if (!(status & PORT_IRQ_ERROR)) {
 		struct ata_queued_cmd *qc;
 
-		if ((qc = ata_qc_from_tag(ap, ap->active_tag))) {
+		if (ap->sactive) {
+			sactive = readl(port_mmio + PORT_SCR_ACT);
+			if (ata_ncq_complete(ap, sactive))
+				return 1;
+		} else if ((qc = ata_qc_from_tag(ap, ap->active_tag))) {
 			ci = readl(port_mmio + PORT_CMD_ISSUE);
-			if ((ci & 0x1) == 0) {
+			if ((ci & (1 << qc->tag)) == 0) {
 				ata_qc_complete(qc);
 				return 1;
 			}
 		}
 
-		if (ata_ratelimit())
+		/* Some drives spuriously generate D2H FISes w/ I bit
+		 * set during NCQ command phase.
+		 */
+		if (spurious_cnt && ata_ratelimit()) {
+			spurious_cnt--;
 			printk(KERN_INFO "ata%u: spurious interrupt "
-			       "(irq_stat 0x%x active_tag %d)\n",
-			       ap->id, status, ap->active_tag);
+			       "(irq_stat 0x%x active_tag %d sactive 0x%x%s)\n",
+			       ap->id, status, ap->active_tag, ap->sactive,
+			       spurious_cnt ? "" : ", shutting up");
+		}
 
 		return 1;
 	}
@@ -951,7 +970,7 @@ static void ahci_irq_clear(struct ata_po
 	/* TODO */
 }
 
-static irqreturn_t ahci_interrupt (int irq, void *dev_instance, struct pt_regs *regs)
+static irqreturn_t ahci_interrupt(int irq, void *dev_instance, struct pt_regs *regs)
 {
 	struct ata_host_set *host_set = dev_instance;
 	struct ahci_host_priv *hpriv;
@@ -1014,7 +1033,9 @@ static unsigned int ahci_qc_issue(struct
 	struct ata_port *ap = qc->ap;
 	void __iomem *port_mmio = (void __iomem *) ap->ioaddr.cmd_addr;
 
-	writel(1, port_mmio + PORT_CMD_ISSUE);
+	if (qc->tf.protocol == ATA_PROT_NCQ)
+		writel(1 << qc->tag, port_mmio + PORT_SCR_ACT);
+	writel(1 << qc->tag, port_mmio + PORT_CMD_ISSUE);
 	readl(port_mmio + PORT_CMD_ISSUE);	/* flush */
 
 	return 0;
@@ -1264,6 +1285,8 @@ static int ahci_init_one (struct pci_dev
 
 	VPRINTK("ENTER\n");
 
+	WARN_ON(ATA_MAX_QUEUE > AHCI_MAX_CMDS);
+
 	if (!printed_version++)
 		dev_printk(KERN_DEBUG, &pdev->dev, "version " DRV_VERSION "\n");
 
@@ -1331,6 +1354,9 @@ static int ahci_init_one (struct pci_dev
 	if (rc)
 		goto err_out_hpriv;
 
+	if (hpriv->cap & HOST_CAP_NCQ)
+		probe_ent->host_flags |= ATA_FLAG_NCQ;
+
 	ahci_print_info(probe_ent);
 
 	/* FIXME: check ata_device_add return value */
-- 
1.2.4


