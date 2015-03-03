From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 1/1] sata_dwc_460ex: join messages back
Date: Tue,  3 Mar 2015 21:21:58 +0200
Message-ID: <1425410518-15405-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:8440 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755171AbbCCTWE (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 3 Mar 2015 14:22:04 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

It it better to have full message on one line. It simplifies to search for line
in the code by message when debugging.

Note that the lines which will be removed by sequential patch are not fixed
here.

There is no functional change.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/ata/sata_dwc_460ex.c | 103 +++++++++++++++++++++++--------------------
 1 file changed, 54 insertions(+), 49 deletions(-)

diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.c
index fdb0f28..7bc0c12 100644
--- a/drivers/ata/sata_dwc_460ex.c
+++ b/drivers/ata/sata_dwc_460ex.c
@@ -392,14 +392,15 @@ static const char *get_dma_dir_descript(int dma_dir)
 
 static void sata_dwc_tf_dump(struct ata_taskfile *tf)
 {
-	dev_vdbg(host_pvt.dwc_dev, "taskfile cmd: 0x%02x protocol: %s flags:"
-		"0x%lx device: %x\n", tf->command,
-		get_prot_descript(tf->protocol), tf->flags, tf->device);
-	dev_vdbg(host_pvt.dwc_dev, "feature: 0x%02x nsect: 0x%x lbal: 0x%x "
-		"lbam: 0x%x lbah: 0x%x\n", tf->feature, tf->nsect, tf->lbal,
-		 tf->lbam, tf->lbah);
-	dev_vdbg(host_pvt.dwc_dev, "hob_feature: 0x%02x hob_nsect: 0x%x "
-		"hob_lbal: 0x%x hob_lbam: 0x%x hob_lbah: 0x%x\n",
+	dev_vdbg(host_pvt.dwc_dev,
+		"taskfile cmd: 0x%02x protocol: %s flags: 0x%lx device: %x\n",
+		tf->command, get_prot_descript(tf->protocol), tf->flags,
+		tf->device);
+	dev_vdbg(host_pvt.dwc_dev,
+		"feature: 0x%02x nsect: 0x%x lbal: 0x%x lbam: 0x%x lbah: 0x%x\n",
+		tf->feature, tf->nsect, tf->lbal, tf->lbam, tf->lbah);
+	dev_vdbg(host_pvt.dwc_dev,
+		"hob_feature: 0x%02x hob_nsect: 0x%x hob_lbal: 0x%x hob_lbam: 0x%x hob_lbah: 0x%x\n",
 		tf->hob_feature, tf->hob_nsect, tf->hob_lbal, tf->hob_lbam,
 		tf->hob_lbah);
 }
@@ -1003,8 +1004,9 @@ static irqreturn_t sata_dwc_isr(int irq, void *dev_instance)
 
 		/* DEV interrupt w/ no active qc? */
 		if (unlikely(!qc || (qc->tf.flags & ATA_TFLAG_POLLING))) {
-			dev_err(ap->dev, "%s interrupt with no active qc "
-				"qc=%p\n", __func__, qc);
+			dev_err(ap->dev,
+				"%s interrupt with no active qc qc=%p\n",
+				__func__, qc);
 			ap->ops->sff_check_status(ap);
 			handled = 1;
 			goto DONE;
@@ -1034,9 +1036,9 @@ DRVSTILLBUSY:
 			host_pvt.dma_interrupt_count++;
 			if (hsdevp->dma_pending[tag] == \
 					SATA_DWC_DMA_PENDING_NONE) {
-				dev_err(ap->dev, "%s: DMA not pending "
-					"intpr=0x%08x status=0x%08x pending"
-					"=%d\n", __func__, intpr, status,
+				dev_err(ap->dev,
+					"%s: DMA not pending intpr=0x%08x status=0x%08x pending=%d\n",
+					__func__, intpr, status,
 					hsdevp->dma_pending[tag]);
 			}
 
@@ -1068,17 +1070,17 @@ DRVSTILLBUSY:
 
 	if (sactive != 0 || (host_pvt.sata_dwc_sactive_issued) > 1 || \
 							tag_mask > 1) {
-		dev_dbg(ap->dev, "%s NCQ:sactive=0x%08x  sactive_issued=0x%08x"
-			"tag_mask=0x%08x\n", __func__, sactive,
-			host_pvt.sata_dwc_sactive_issued, tag_mask);
+		dev_dbg(ap->dev,
+			"%s NCQ:sactive=0x%08x  sactive_issued=0x%08x tag_mask=0x%08x\n",
+			__func__, sactive, host_pvt.sata_dwc_sactive_issued,
+			tag_mask);
 	}
 
 	if ((tag_mask | (host_pvt.sata_dwc_sactive_issued)) != \
 					(host_pvt.sata_dwc_sactive_issued)) {
-		dev_warn(ap->dev, "Bad tag mask?  sactive=0x%08x "
-			 "(host_pvt.sata_dwc_sactive_issued)=0x%08x  tag_mask"
-			 "=0x%08x\n", sactive, host_pvt.sata_dwc_sactive_issued,
-			  tag_mask);
+		dev_warn(ap->dev,
+			 "Bad tag mask?  sactive=0x%08x (host_pvt.sata_dwc_sactive_issued)=0x%08x  tag_mask=0x%08x\n",
+			 sactive, host_pvt.sata_dwc_sactive_issued, tag_mask);
 	}
 
 	/* read just to clear ... not bad if currently still busy */
@@ -1142,8 +1144,9 @@ STILLBUSY:
 	 */
 	sactive2 = core_scr_read(SCR_ACTIVE);
 	if (sactive2 != sactive) {
-		dev_dbg(ap->dev, "More completed - sactive=0x%x sactive2"
-			"=0x%x\n", sactive, sactive2);
+		dev_dbg(ap->dev,
+			"More completed - sactive=0x%x sactive2=0x%x\n",
+			sactive, sactive2);
 	}
 	handled = 1;
 
@@ -1169,11 +1172,10 @@ static void sata_dwc_clear_dmacr(struct sata_dwc_device_port *hsdevp, u8 tag)
 		 * This should not happen, it indicates the driver is out of
 		 * sync.  If it does happen, clear dmacr anyway.
 		 */
-		dev_err(host_pvt.dwc_dev, "%s DMA protocol RX and"
-			"TX DMA not pending tag=0x%02x pending=%d"
-			" dmacr: 0x%08x\n", __func__, tag,
-			hsdevp->dma_pending[tag],
-			in_le32(&(hsdev->sata_dwc_regs->dmacr)));
+		dev_err(host_pvt.dwc_dev,
+			"%s DMA protocol RX and TX DMA not pending tag=0x%02x pending=%d dmacr: 0x%08x\n",
+			__func__, tag, hsdevp->dma_pending[tag],
+			in_le32(&hsdev->sata_dwc_regs->dmacr));
 		out_le32(&(hsdev->sata_dwc_regs->dmacr),
 			SATA_DWC_DMACR_TXRXCH_CLEAR);
 	}
@@ -1195,8 +1197,9 @@ static void sata_dwc_dma_xfer_complete(struct ata_port *ap, u32 check_status)
 
 #ifdef DEBUG_NCQ
 	if (tag > 0) {
-		dev_info(ap->dev, "%s tag=%u cmd=0x%02x dma dir=%s proto=%s "
-			 "dmacr=0x%08x\n", __func__, qc->tag, qc->tf.command,
+		dev_info(ap->dev,
+			 "%s tag=%u cmd=0x%02x dma dir=%s proto=%s dmacr=0x%08x\n",
+			 __func__, qc->tag, qc->tf.command,
 			 get_dma_dir_descript(qc->dma_dir),
 			 get_prot_descript(qc->tf.protocol),
 			 in_le32(&(hsdev->sata_dwc_regs->dmacr)));
@@ -1205,8 +1208,9 @@ static void sata_dwc_dma_xfer_complete(struct ata_port *ap, u32 check_status)
 
 	if (ata_is_dma(qc->tf.protocol)) {
 		if (hsdevp->dma_pending[tag] == SATA_DWC_DMA_PENDING_NONE) {
-			dev_err(ap->dev, "%s DMA protocol RX and TX DMA not "
-				"pending dmacr: 0x%08x\n", __func__,
+			dev_err(ap->dev,
+				"%s DMA protocol RX and TX DMA not pending dmacr: 0x%08x\n",
+				__func__,
 				in_le32(&(hsdev->sata_dwc_regs->dmacr)));
 		}
 
@@ -1232,9 +1236,9 @@ static int sata_dwc_qc_complete(struct ata_port *ap, struct ata_queued_cmd *qc,
 		dev_err(ap->dev, "TX DMA PENDING\n");
 	else if (hsdevp->dma_pending[tag] == SATA_DWC_DMA_PENDING_RX)
 		dev_err(ap->dev, "RX DMA PENDING\n");
-	dev_dbg(ap->dev, "QC complete cmd=0x%02x status=0x%02x ata%u:"
-		" protocol=%d\n", qc->tf.command, status, ap->print_id,
-		 qc->tf.protocol);
+	dev_dbg(ap->dev,
+		"QC complete cmd=0x%02x status=0x%02x ata%u: protocol=%d\n",
+		qc->tf.command, status, ap->print_id, qc->tf.protocol);
 
 	/* clear active bit */
 	mask = (~(qcmd_tag_to_mask(tag)));
@@ -1458,14 +1462,15 @@ static void sata_dwc_bmdma_start_by_tag(struct ata_queued_cmd *qc, u8 tag)
 		else
 			hsdevp->dma_pending[tag] = SATA_DWC_DMA_PENDING_RX;
 	} else {
-		dev_err(ap->dev, "%s: Command not pending cmd_issued=%d "
-			"(tag=%d) DMA NOT started\n", __func__,
-			hsdevp->cmd_issued[tag], tag);
+		dev_err(ap->dev,
+			"%s: Command not pending cmd_issued=%d (tag=%d) DMA NOT started\n",
+			__func__, hsdevp->cmd_issued[tag], tag);
 		start_dma = 0;
 	}
 
-	dev_dbg(ap->dev, "%s qc=%p tag: %x cmd: 0x%02x dma_dir: %s "
-		"start_dma? %x\n", __func__, qc, tag, qc->tf.command,
+	dev_dbg(ap->dev,
+		"%s qc=%p tag: %x cmd: 0x%02x dma_dir: %s start_dma? %x\n",
+		__func__, qc, tag, qc->tf.command,
 		get_dma_dir_descript(qc->dma_dir), start_dma);
 	sata_dwc_tf_dump(&(qc->tf));
 
@@ -1540,8 +1545,8 @@ static unsigned int sata_dwc_qc_issue(struct ata_queued_cmd *qc)
 
 #ifdef DEBUG_NCQ
 	if (qc->tag > 0 || ap->link.sactive > 1)
-		dev_info(ap->dev, "%s ap id=%d cmd(0x%02x)=%s qc tag=%d "
-			 "prot=%s ap active_tag=0x%08x ap sactive=0x%08x\n",
+		dev_info(ap->dev,
+			 "%s ap id=%d cmd(0x%02x)=%s qc tag=%d prot=%s ap active_tag=0x%08x ap sactive=0x%08x\n",
 			 __func__, ap->print_id, qc->tf.command,
 			 ata_get_cmd_descript(qc->tf.command),
 			 qc->tag, get_prot_descript(qc->tf.protocol),
@@ -1557,9 +1562,9 @@ static unsigned int sata_dwc_qc_issue(struct ata_queued_cmd *qc)
 		sactive |= (0x00000001 << tag);
 		core_scr_write(SCR_ACTIVE, sactive);
 
-		dev_dbg(qc->ap->dev, "%s: tag=%d ap->link.sactive = 0x%08x "
-			"sactive=0x%08x\n", __func__, tag, qc->ap->link.sactive,
-			sactive);
+		dev_dbg(qc->ap->dev,
+			"%s: tag=%d ap->link.sactive = 0x%08x sactive=0x%08x\n",
+			__func__, tag, qc->ap->link.sactive, sactive);
 
 		ap->ops->sff_tf_load(ap, &qc->tf);
 		sata_dwc_exec_command_by_tag(ap, &qc->tf, qc->tag,
@@ -1693,8 +1698,8 @@ static int sata_dwc_probe(struct platform_device *ofdev)
 	/* Ioremap SATA registers */
 	base = of_iomap(np, 0);
 	if (!base) {
-		dev_err(&ofdev->dev, "ioremap failed for SATA register"
-			" address\n");
+		dev_err(&ofdev->dev,
+			"ioremap failed for SATA register address\n");
 		return -ENODEV;
 	}
 	hsdev->reg_base = base;
@@ -1726,8 +1731,8 @@ static int sata_dwc_probe(struct platform_device *ofdev)
 	/* Get physical SATA DMA register base address */
 	host_pvt.sata_dma_regs = (void *)of_iomap(np, 1);
 	if (!(host_pvt.sata_dma_regs)) {
-		dev_err(&ofdev->dev, "ioremap failed for AHBDMA register"
-			" address\n");
+		dev_err(&ofdev->dev,
+			"ioremap failed for AHBDMA register address\n");
 		err = -ENODEV;
 		goto error_iomap;
 	}
@@ -1809,5 +1814,5 @@ module_platform_driver(sata_dwc_driver);
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Mark Miesfeld <mmiesfeld@amcc.com>");
-MODULE_DESCRIPTION("DesignWare Cores SATA controller low lever driver");
+MODULE_DESCRIPTION("DesignWare Cores SATA controller low level driver");
 MODULE_VERSION(DRV_VERSION);
-- 
2.1.4

