From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 14/15] ahci: implement NCQ suppport
Date: Tue, 11 Apr 2006 22:53:37 +0900
Message-ID: <11447636171697-git-send-email-htejun@gmail.com>
References: <1144763616819-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.200]:33886 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750991AbWDKNxp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 11 Apr 2006 09:53:45 -0400
Received: by zproxy.gmail.com with SMTP id o37so1097581nzf
        for <linux-ide@vger.kernel.org>; Tue, 11 Apr 2006 06:53:44 -0700 (PDT)
In-Reply-To: <1144763616819-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, lkosewsk@gmail.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Implement NCQ support.

Original implementation is from Jens Axboe.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/ahci.c |   82 ++++++++++++++++++++++++++++++++++-----------------
 1 files changed, 54 insertions(+), 28 deletions(-)

67b28600437cd9e5c4b55527f73a3be049064a2d
diff --git a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
index 027fea1..3f1fd7c 100644
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
 
 static int ahci_softreset(struct ata_port *ap, unsigned int *class)
@@ -581,7 +587,8 @@ static int ahci_softreset(struct ata_por
 	fis = pp->cmd_tbl;
 
 	/* issue the first D2H Register FIS */
-	ahci_fill_cmd_slot(pp, cmd_fis_len | AHCI_CMD_RESET | AHCI_CMD_CLR_BUSY);
+	ahci_fill_cmd_slot(pp, 0,
+			   cmd_fis_len | AHCI_CMD_RESET | AHCI_CMD_CLR_BUSY);
 
 	tf.ctl |= ATA_SRST;
 	ata_tf_to_fis(&tf, fis, 0);
@@ -600,7 +607,7 @@ static int ahci_softreset(struct ata_por
 	msleep(1);
 
 	/* issue the second D2H Register FIS */
-	ahci_fill_cmd_slot(pp, cmd_fis_len);
+	ahci_fill_cmd_slot(pp, 0, cmd_fis_len);
 
 	tf.ctl &= ~ATA_SRST;
 	ata_tf_to_fis(&tf, fis, 0);
@@ -700,9 +707,8 @@ static void ahci_tf_read(struct ata_port
 	ata_tf_from_fis(d2h_fis, tf);
 }
 
-static unsigned int ahci_fill_sg(struct ata_queued_cmd *qc)
+static unsigned int ahci_fill_sg(struct ata_queued_cmd *qc, void *cmd_tbl)
 {
-	struct ahci_port_priv *pp = qc->ap->private_data;
 	struct scatterlist *sg;
 	struct ahci_sg *ahci_sg;
 	unsigned int n_sg = 0;
@@ -712,7 +718,7 @@ static unsigned int ahci_fill_sg(struct 
 	/*
 	 * Next, the S/G list.
 	 */
-	ahci_sg = pp->cmd_tbl + AHCI_CMD_TBL_HDR_SZ;
+	ahci_sg = cmd_tbl + AHCI_CMD_TBL_HDR_SZ;
 	ata_for_each_sg(sg, qc) {
 		dma_addr_t addr = sg_dma_address(sg);
 		u32 sg_len = sg_dma_len(sg);
@@ -733,6 +739,7 @@ static void ahci_qc_prep(struct ata_queu
 	struct ata_port *ap = qc->ap;
 	struct ahci_port_priv *pp = ap->private_data;
 	int is_atapi = is_atapi_taskfile(&qc->tf);
+	void *cmd_tbl;
 	u32 opts;
 	const u32 cmd_fis_len = 5; /* five dwords */
 	unsigned int n_elem;
@@ -741,16 +748,17 @@ static void ahci_qc_prep(struct ata_queu
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
@@ -761,7 +769,7 @@ static void ahci_qc_prep(struct ata_queu
 	if (is_atapi)
 		opts |= AHCI_CMD_ATAPI | AHCI_CMD_PREFETCH;
 
-	ahci_fill_cmd_slot(pp, opts);
+	ahci_fill_cmd_slot(pp, qc->tag, opts);
 }
 
 static unsigned int ahci_eh_autopsy(struct ata_port *ap, u32 irq_stat,
@@ -846,7 +854,7 @@ static void ahci_error_handler(struct at
 	/* perform recovery */
 	action |= ahci_eh_autopsy(ap, irq_stat, &err_mask, desc, sizeof(desc));
 
-	qc = ata_eh_determine_qc(ap, 0, &tf);
+	qc = ata_eh_determine_qc(ap, err_mask & AC_ERR_DEV, &tf);
 	if (qc)
 		qc->err_mask |= err_mask;
 
@@ -873,10 +881,11 @@ static void ahci_post_internal_cmd(struc
 
 static inline void ahci_host_intr(struct ata_port *ap)
 {
+	static int spurious_cnt = 10;
 	struct ahci_port_priv *pp = ap->private_data;
 	void __iomem *mmio = ap->host_set->mmio_base;
 	void __iomem *port_mmio = ahci_port_base(mmio, ap->port_no);
-	u32 status, serror, ci;
+	u32 status, sactive, serror, ci;
 	unsigned int eh_flags;
 
 	status = readl(port_mmio + PORT_IRQ_STAT);
@@ -900,18 +909,28 @@ static inline void ahci_host_intr(struct
 	if (!(status & PORT_IRQ_ERROR)) {
 		struct ata_queued_cmd *qc;
 
-		if ((qc = ata_qc_from_tag(ap, ap->active_tag))) {
+		if (ap->sactive) {
+			sactive = readl(port_mmio + PORT_SCR_ACT);
+			if (ata_ncq_complete(ap, sactive))
+				return;
+		} else if ((qc = ata_qc_from_tag(ap, ap->active_tag))) {
 			ci = readl(port_mmio + PORT_CMD_ISSUE);
-			if ((ci & 0x1) == 0) {
+			if ((ci & (1 << qc->tag)) == 0) {
 				ata_qc_complete(qc);
 				return;
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
 
 		return;
 	}
@@ -935,7 +954,7 @@ static void ahci_irq_clear(struct ata_po
 	/* TODO */
 }
 
-static irqreturn_t ahci_interrupt (int irq, void *dev_instance, struct pt_regs *regs)
+static irqreturn_t ahci_interrupt(int irq, void *dev_instance, struct pt_regs *regs)
 {
 	struct ata_host_set *host_set = dev_instance;
 	struct ahci_host_priv *hpriv;
@@ -993,7 +1012,9 @@ static unsigned int ahci_qc_issue(struct
 	struct ata_port *ap = qc->ap;
 	void __iomem *port_mmio = (void __iomem *) ap->ioaddr.cmd_addr;
 
-	writel(1, port_mmio + PORT_CMD_ISSUE);
+	if (qc->tf.protocol == ATA_PROT_NCQ)
+		writel(1 << qc->tag, port_mmio + PORT_SCR_ACT);
+	writel(1 << qc->tag, port_mmio + PORT_CMD_ISSUE);
 	readl(port_mmio + PORT_CMD_ISSUE);	/* flush */
 
 	return 0;
@@ -1243,6 +1264,8 @@ static int ahci_init_one (struct pci_dev
 
 	VPRINTK("ENTER\n");
 
+	WARN_ON(ATA_MAX_QUEUE > AHCI_MAX_CMDS);
+
 	if (!printed_version++)
 		dev_printk(KERN_DEBUG, &pdev->dev, "version " DRV_VERSION "\n");
 
@@ -1310,6 +1333,9 @@ static int ahci_init_one (struct pci_dev
 	if (rc)
 		goto err_out_hpriv;
 
+	if (hpriv->cap & HOST_CAP_NCQ)
+		probe_ent->host_flags |= ATA_FLAG_NCQ;
+
 	ahci_print_info(probe_ent);
 
 	/* FIXME: check ata_device_add return value */
-- 
1.2.4


