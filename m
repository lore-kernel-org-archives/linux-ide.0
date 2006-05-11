From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 11/12] ahci: implement NCQ suppport
Date: Thu, 11 May 2006 23:44:43 +0900
Message-ID: <11473586833814-git-send-email-htejun@gmail.com>
References: <1147358682210-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.198]:18204 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751808AbWEKOoy (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 11 May 2006 10:44:54 -0400
Received: by nz-out-0102.google.com with SMTP id 13so216447nzn
        for <linux-ide@vger.kernel.org>; Thu, 11 May 2006 07:44:54 -0700 (PDT)
In-Reply-To: <1147358682210-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, forrest.zhao@intel.com, efalk@google.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Implement NCQ support.

Original implementation is from Jens Axboe.

---

 drivers/scsi/ahci.c |   88 +++++++++++++++++++++++++++++++++------------------
 1 files changed, 57 insertions(+), 31 deletions(-)

8e45ed212780b8ccf089fad7b15dfa23d4046969
diff --git a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
index 49f5101..9f020cd 100644
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
 	.name			= DRV_NAME,
 	.ioctl			= ata_scsi_ioctl,
 	.queuecommand		= ata_scsi_queuecmd,
-	.can_queue		= ATA_DEF_QUEUE,
+	.change_queue_depth	= ata_scsi_change_queue_depth,
+	.can_queue		= AHCI_MAX_CMDS - 1,
 	.this_id		= ATA_SHT_THIS_ID,
 	.sg_tablesize		= AHCI_MAX_SG,
 	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
@@ -528,12 +529,17 @@ static unsigned int ahci_dev_classify(st
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
 
 static int ahci_clo(struct ata_port *ap)
@@ -605,7 +611,8 @@ static int ahci_softreset(struct ata_por
 	fis = pp->cmd_tbl;
 
 	/* issue the first D2H Register FIS */
-	ahci_fill_cmd_slot(pp, cmd_fis_len | AHCI_CMD_RESET | AHCI_CMD_CLR_BUSY);
+	ahci_fill_cmd_slot(pp, 0,
+			   cmd_fis_len | AHCI_CMD_RESET | AHCI_CMD_CLR_BUSY);
 
 	tf.ctl |= ATA_SRST;
 	ata_tf_to_fis(&tf, fis, 0);
@@ -624,7 +631,7 @@ static int ahci_softreset(struct ata_por
 	msleep(1);
 
 	/* issue the second D2H Register FIS */
-	ahci_fill_cmd_slot(pp, cmd_fis_len);
+	ahci_fill_cmd_slot(pp, 0, cmd_fis_len);
 
 	tf.ctl &= ~ATA_SRST;
 	ata_tf_to_fis(&tf, fis, 0);
@@ -735,9 +742,8 @@ static void ahci_tf_read(struct ata_port
 	ata_tf_from_fis(d2h_fis, tf);
 }
 
-static unsigned int ahci_fill_sg(struct ata_queued_cmd *qc)
+static unsigned int ahci_fill_sg(struct ata_queued_cmd *qc, void *cmd_tbl)
 {
-	struct ahci_port_priv *pp = qc->ap->private_data;
 	struct scatterlist *sg;
 	struct ahci_sg *ahci_sg;
 	unsigned int n_sg = 0;
@@ -747,7 +753,7 @@ static unsigned int ahci_fill_sg(struct 
 	/*
 	 * Next, the S/G list.
 	 */
-	ahci_sg = pp->cmd_tbl + AHCI_CMD_TBL_HDR_SZ;
+	ahci_sg = cmd_tbl + AHCI_CMD_TBL_HDR_SZ;
 	ata_for_each_sg(sg, qc) {
 		dma_addr_t addr = sg_dma_address(sg);
 		u32 sg_len = sg_dma_len(sg);
@@ -768,6 +774,7 @@ static void ahci_qc_prep(struct ata_queu
 	struct ata_port *ap = qc->ap;
 	struct ahci_port_priv *pp = ap->private_data;
 	int is_atapi = is_atapi_taskfile(&qc->tf);
+	void *cmd_tbl;
 	u32 opts;
 	const u32 cmd_fis_len = 5; /* five dwords */
 	unsigned int n_elem;
@@ -776,16 +783,17 @@ static void ahci_qc_prep(struct ata_queu
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
@@ -796,7 +804,7 @@ static void ahci_qc_prep(struct ata_queu
 	if (is_atapi)
 		opts |= AHCI_CMD_ATAPI | AHCI_CMD_PREFETCH;
 
-	ahci_fill_cmd_slot(pp, opts);
+	ahci_fill_cmd_slot(pp, qc->tag, opts);
 }
 
 static void ahci_error_intr(struct ata_port *ap, u32 irq_stat)
@@ -867,8 +875,8 @@ static void ahci_host_intr(struct ata_po
 	void __iomem *mmio = ap->host_set->mmio_base;
 	void __iomem *port_mmio = ahci_port_base(mmio, ap->port_no);
 	struct ata_eh_info *ehi = &ap->eh_info;
-	struct ata_queued_cmd *qc;
-	u32 status, serror, ci;
+	u32 status, serror, qc_active;
+	int rc;
 
 	status = readl(port_mmio + PORT_IRQ_STAT);
 	writel(status, port_mmio + PORT_IRQ_STAT);
@@ -892,16 +900,27 @@ static void ahci_host_intr(struct ata_po
 		return;
 	}
 
-	if ((qc = ata_qc_from_tag(ap, ap->active_tag))) {
-		ci = readl(port_mmio + PORT_CMD_ISSUE);
-		if ((ci & 0x1) == 0) {
-			ata_qc_complete(qc);
-			return;
-		}
+	if (ap->sactive)
+		qc_active = readl(port_mmio + PORT_SCR_ACT);
+	else
+		qc_active = readl(port_mmio + PORT_CMD_ISSUE);
+
+	rc = ata_qc_complete_multiple(ap, qc_active, NULL);
+	if (rc > 0)
+		return;
+	if (rc < 0) {
+		ehi->err_mask |= AC_ERR_HSM;
+		ehi->action |= ATA_EH_SOFTRESET;
+		ata_port_freeze(ap);
+		return;
 	}
 
 	/* hmmm... a spurious interupt */
 
+	/* some devices send D2H reg with I bit set during NCQ command phase */
+	if (ap->sactive && status & PORT_IRQ_D2H_REG_FIS)
+		return;
+
 	/* ignore interim PIO setup fis interrupts */
 	if (ata_tag_valid(ap->active_tag)) {
 		struct ata_queued_cmd *qc =
@@ -914,8 +933,8 @@ static void ahci_host_intr(struct ata_po
 
 	if (ata_ratelimit())
 		ata_port_printk(ap, KERN_INFO, "spurious interrupt "
-				"(irq_stat 0x%x active_tag %d)\n",
-				status, ap->active_tag);
+				"(irq_stat 0x%x active_tag %d sactive 0x%x)\n",
+				status, ap->active_tag, ap->sactive);
 }
 
 static void ahci_irq_clear(struct ata_port *ap)
@@ -923,7 +942,7 @@ static void ahci_irq_clear(struct ata_po
 	/* TODO */
 }
 
-static irqreturn_t ahci_interrupt (int irq, void *dev_instance, struct pt_regs *regs)
+static irqreturn_t ahci_interrupt(int irq, void *dev_instance, struct pt_regs *regs)
 {
 	struct ata_host_set *host_set = dev_instance;
 	struct ahci_host_priv *hpriv;
@@ -981,7 +1000,9 @@ static unsigned int ahci_qc_issue(struct
 	struct ata_port *ap = qc->ap;
 	void __iomem *port_mmio = (void __iomem *) ap->ioaddr.cmd_addr;
 
-	writel(1, port_mmio + PORT_CMD_ISSUE);
+	if (qc->tf.protocol == ATA_PROT_NCQ)
+		writel(1 << qc->tag, port_mmio + PORT_SCR_ACT);
+	writel(1 << qc->tag, port_mmio + PORT_CMD_ISSUE);
 	readl(port_mmio + PORT_CMD_ISSUE);	/* flush */
 
 	return 0;
@@ -1257,6 +1278,8 @@ static int ahci_init_one (struct pci_dev
 
 	VPRINTK("ENTER\n");
 
+	WARN_ON(ATA_MAX_QUEUE > AHCI_MAX_CMDS);
+
 	if (!printed_version++)
 		dev_printk(KERN_DEBUG, &pdev->dev, "version " DRV_VERSION "\n");
 
@@ -1324,6 +1347,9 @@ static int ahci_init_one (struct pci_dev
 	if (rc)
 		goto err_out_hpriv;
 
+	if (hpriv->cap & HOST_CAP_NCQ)
+		probe_ent->host_flags |= ATA_FLAG_NCQ;
+
 	ahci_print_info(probe_ent);
 
 	/* FIXME: check ata_device_add return value */
-- 
1.2.4


