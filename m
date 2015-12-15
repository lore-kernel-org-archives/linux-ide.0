From: Mans Rullgard <mans@mansr.com>
Subject: [PATCH 3/3] ata: sata_dwc_460ex: get rid of global data
Date: Tue, 15 Dec 2015 23:25:34 +0000
Message-ID: <1450221935-6034-3-git-send-email-mans@mansr.com>
References: <1450221935-6034-1-git-send-email-mans@mansr.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1450221935-6034-1-git-send-email-mans@mansr.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-ide@vger.kernel.org

This moves all global data into the driver private struct, thus
permitting multiple devices of this type to be used.

Signed-off-by: Mans Rullgard <mans@mansr.com>
---
 drivers/ata/sata_dwc_460ex.c | 80 ++++++++++++++++++++------------------------
 1 file changed, 36 insertions(+), 44 deletions(-)

diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.c
index d07aae1..919f870 100644
--- a/drivers/ata/sata_dwc_460ex.c
+++ b/drivers/ata/sata_dwc_460ex.c
@@ -146,6 +146,8 @@ struct sata_dwc_device {
 	struct ata_host		*host;
 	u8 __iomem		*reg_base;
 	struct sata_dwc_regs	*sata_dwc_regs;	/* DW Synopsys SATA specific */
+	u32			sactive_issued;
+	u32			sactive_queued;
 	struct phy		*phy;
 #ifdef CONFIG_SATA_DWC_OLD_DMA
 	struct dw_dma_chip	*dma;
@@ -190,14 +192,6 @@ enum {
 	SATA_DWC_DMA_PENDING_RX		= 2,
 };
 
-struct sata_dwc_host_priv {
-	void	__iomem	 *scr_addr_sstatus;
-	u32	sata_dwc_sactive_issued ;
-	u32	sata_dwc_sactive_queued ;
-};
-
-static struct sata_dwc_host_priv host_pvt;
-
 /*
  * Prototypes
  */
@@ -448,21 +442,22 @@ static int sata_dwc_scr_write(struct ata_link *link, unsigned int scr, u32 val)
 	return 0;
 }
 
-static u32 core_scr_read(unsigned int scr)
+static u32 core_scr_read(struct sata_dwc_device *hsdev, unsigned int scr)
 {
-	return in_le32(host_pvt.scr_addr_sstatus + (scr * 4));
+	return in_le32(hsdev->reg_base + SATA_DWC_SCR_OFFSET + (scr * 4));
 }
 
-static void core_scr_write(unsigned int scr, u32 val)
+static void core_scr_write(struct sata_dwc_device *hsdev, unsigned int scr,
+			   u32 val)
 {
-	out_le32(host_pvt.scr_addr_sstatus + (scr * 4), val);
+	out_le32(hsdev->reg_base + SATA_DWC_SCR_OFFSET + (scr * 4), val);
 }
 
-static void clear_serror(void)
+static void clear_serror(struct sata_dwc_device *hsdev)
 {
 	u32 val;
-	val = core_scr_read(SCR_ERROR);
-	core_scr_write(SCR_ERROR, val);
+	val = core_scr_read(hsdev, SCR_ERROR);
+	core_scr_write(hsdev, SCR_ERROR, val);
 }
 
 static void clear_interrupt_bit(struct sata_dwc_device *hsdev, u32 bit)
@@ -489,7 +484,7 @@ static void sata_dwc_error_intr(struct ata_port *ap,
 
 	ata_ehi_clear_desc(ehi);
 
-	serror = core_scr_read(SCR_ERROR);
+	serror = core_scr_read(hsdev, SCR_ERROR);
 	status = ap->ops->sff_check_status(ap);
 
 	tag = ap->link.active_tag;
@@ -500,7 +495,7 @@ static void sata_dwc_error_intr(struct ata_port *ap,
 		hsdevp->dma_pending[tag], hsdevp->cmd_issued[tag]);
 
 	/* Clear error register and interrupt bit */
-	clear_serror();
+	clear_serror(hsdev);
 	clear_interrupt_bit(hsdev, SATA_DWC_INTPR_ERR);
 
 	/* This is the only error happening now.  TODO check for exact error */
@@ -539,7 +534,7 @@ static irqreturn_t sata_dwc_isr(int irq, void *dev_instance)
 	int handled, num_processed, port = 0;
 	uint intpr, sactive, sactive2, tag_mask;
 	struct sata_dwc_device_port *hsdevp;
-	host_pvt.sata_dwc_sactive_issued = 0;
+	hsdev->sactive_issued = 0;
 
 	spin_lock_irqsave(&host->lock, flags);
 
@@ -568,7 +563,7 @@ static irqreturn_t sata_dwc_isr(int irq, void *dev_instance)
 		if (hsdevp->cmd_issued[tag] != SATA_DWC_CMD_ISSUED_PEND)
 			dev_warn(ap->dev, "CMD tag=%d not pending?\n", tag);
 
-		host_pvt.sata_dwc_sactive_issued |= qcmd_tag_to_mask(tag);
+		hsdev->sactive_issued |= qcmd_tag_to_mask(tag);
 
 		qc = ata_qc_from_tag(ap, tag);
 		/*
@@ -582,11 +577,11 @@ static irqreturn_t sata_dwc_isr(int irq, void *dev_instance)
 		handled = 1;
 		goto DONE;
 	}
-	sactive = core_scr_read(SCR_ACTIVE);
-	tag_mask = (host_pvt.sata_dwc_sactive_issued | sactive) ^ sactive;
+	sactive = core_scr_read(hsdev, SCR_ACTIVE);
+	tag_mask = (hsdev->sactive_issued | sactive) ^ sactive;
 
 	/* If no sactive issued and tag_mask is zero then this is not NCQ */
-	if (host_pvt.sata_dwc_sactive_issued == 0 && tag_mask == 0) {
+	if (hsdev->sactive_issued == 0 && tag_mask == 0) {
 		if (ap->link.active_tag == ATA_TAG_POISON)
 			tag = 0;
 		else
@@ -656,22 +651,19 @@ DRVSTILLBUSY:
 	 */
 
 	 /* process completed commands */
-	sactive = core_scr_read(SCR_ACTIVE);
-	tag_mask = (host_pvt.sata_dwc_sactive_issued | sactive) ^ sactive;
+	sactive = core_scr_read(hsdev, SCR_ACTIVE);
+	tag_mask = (hsdev->sactive_issued | sactive) ^ sactive;
 
-	if (sactive != 0 || (host_pvt.sata_dwc_sactive_issued) > 1 || \
-							tag_mask > 1) {
+	if (sactive != 0 || hsdev->sactive_issued > 1 ||  tag_mask > 1) {
 		dev_dbg(ap->dev,
 			"%s NCQ:sactive=0x%08x  sactive_issued=0x%08x tag_mask=0x%08x\n",
-			__func__, sactive, host_pvt.sata_dwc_sactive_issued,
-			tag_mask);
+			__func__, sactive, hsdev->sactive_issued, tag_mask);
 	}
 
-	if ((tag_mask | (host_pvt.sata_dwc_sactive_issued)) != \
-					(host_pvt.sata_dwc_sactive_issued)) {
+	if ((tag_mask | hsdev->sactive_issued) != hsdev->sactive_issued) {
 		dev_warn(ap->dev,
-			 "Bad tag mask?  sactive=0x%08x (host_pvt.sata_dwc_sactive_issued)=0x%08x  tag_mask=0x%08x\n",
-			 sactive, host_pvt.sata_dwc_sactive_issued, tag_mask);
+			 "Bad tag mask?  sactive=0x%08x sactive_issued=0x%08x  tag_mask=0x%08x\n",
+			 sactive, hsdev->sactive_issued, tag_mask);
 	}
 
 	/* read just to clear ... not bad if currently still busy */
@@ -733,7 +725,7 @@ STILLBUSY:
 	 * we were processing --we read status as part of processing a completed
 	 * command).
 	 */
-	sactive2 = core_scr_read(SCR_ACTIVE);
+	sactive2 = core_scr_read(hsdev, SCR_ACTIVE);
 	if (sactive2 != sactive) {
 		dev_dbg(ap->dev,
 			"More completed - sactive=0x%x sactive2=0x%x\n",
@@ -819,8 +811,9 @@ static int sata_dwc_qc_complete(struct ata_port *ap, struct ata_queued_cmd *qc,
 	u8 status = 0;
 	u32 mask = 0x0;
 	u8 tag = qc->tag;
+	struct sata_dwc_device *hsdev = HSDEV_FROM_AP(ap);
 	struct sata_dwc_device_port *hsdevp = HSDEVP_FROM_AP(ap);
-	host_pvt.sata_dwc_sactive_queued = 0;
+	hsdev->sactive_queued = 0;
 	dev_dbg(ap->dev, "%s checkstatus? %x\n", __func__, check_status);
 
 	if (hsdevp->dma_pending[tag] == SATA_DWC_DMA_PENDING_TX)
@@ -833,10 +826,8 @@ static int sata_dwc_qc_complete(struct ata_port *ap, struct ata_queued_cmd *qc,
 
 	/* clear active bit */
 	mask = (~(qcmd_tag_to_mask(tag)));
-	host_pvt.sata_dwc_sactive_queued = (host_pvt.sata_dwc_sactive_queued) \
-						& mask;
-	host_pvt.sata_dwc_sactive_issued = (host_pvt.sata_dwc_sactive_issued) \
-						& mask;
+	hsdev->sactive_queued = hsdev->sactive_queued & mask;
+	hsdev->sactive_issued = hsdev->sactive_issued & mask;
 	ata_qc_complete(qc);
 	return 0;
 }
@@ -961,7 +952,7 @@ static int sata_dwc_port_start(struct ata_port *ap)
 	}
 
 	/* Clear any error bits before libata starts issuing commands */
-	clear_serror();
+	clear_serror(hsdev);
 	ap->private_data = hsdevp;
 	dev_dbg(ap->dev, "%s: done\n", __func__);
 	return 0;
@@ -999,6 +990,7 @@ static void sata_dwc_exec_command_by_tag(struct ata_port *ap,
 {
 	unsigned long flags;
 	struct sata_dwc_device_port *hsdevp = HSDEVP_FROM_AP(ap);
+	struct sata_dwc_device *hsdev = HSDEV_FROM_AP(ap);
 
 	dev_dbg(ap->dev, "%s cmd(0x%02x): %s tag=%d\n", __func__, tf->command,
 		ata_get_cmd_descript(tf->command), tag);
@@ -1012,7 +1004,7 @@ static void sata_dwc_exec_command_by_tag(struct ata_port *ap,
 	 * managed SError register for the disk needs to be done before the
 	 * task file is loaded.
 	 */
-	clear_serror();
+	clear_serror(hsdev);
 	ata_sff_exec_command(ap, tf);
 }
 
@@ -1065,7 +1057,7 @@ static void sata_dwc_bmdma_start_by_tag(struct ata_queued_cmd *qc, u8 tag)
 	sata_dwc_tf_dump(ap, &qc->tf);
 
 	if (start_dma) {
-		reg = core_scr_read(SCR_ERROR);
+		reg = core_scr_read(hsdev, SCR_ERROR);
 		if (reg & SATA_DWC_SERROR_ERR_BITS) {
 			dev_err(ap->dev, "%s: ****** SError=0x%08x ******\n",
 				__func__, reg);
@@ -1128,6 +1120,7 @@ static unsigned int sata_dwc_qc_issue(struct ata_queued_cmd *qc)
 	u32 sactive;
 	u8 tag = qc->tag;
 	struct ata_port *ap = qc->ap;
+	struct sata_dwc_device *hsdev = HSDEV_FROM_AP(ap);
 
 #ifdef DEBUG_NCQ
 	if (qc->tag > 0 || ap->link.sactive > 1)
@@ -1144,9 +1137,9 @@ static unsigned int sata_dwc_qc_issue(struct ata_queued_cmd *qc)
 	sata_dwc_qc_prep_by_tag(qc, tag);
 
 	if (ata_is_ncq(qc->tf.protocol)) {
-		sactive = core_scr_read(SCR_ACTIVE);
+		sactive = core_scr_read(hsdev, SCR_ACTIVE);
 		sactive |= (0x00000001 << tag);
-		core_scr_write(SCR_ACTIVE, sactive);
+		core_scr_write(hsdev, SCR_ACTIVE, sactive);
 
 		dev_dbg(qc->ap->dev,
 			"%s: tag=%d ap->link.sactive = 0x%08x sactive=0x%08x\n",
@@ -1289,7 +1282,6 @@ static int sata_dwc_probe(struct platform_device *ofdev)
 	/* Setup port */
 	host->ports[0]->ioaddr.cmd_addr = base;
 	host->ports[0]->ioaddr.scr_addr = base + SATA_DWC_SCR_OFFSET;
-	host_pvt.scr_addr_sstatus = base + SATA_DWC_SCR_OFFSET;
 	sata_dwc_setup_port(&host->ports[0]->ioaddr, (unsigned long)base);
 
 	/* Read the ID and Version Registers */
-- 
2.6.3
