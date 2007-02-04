From: Mikael Pettersson <mikpe@it.uu.se>
Subject: [PATCH] sata_promise: new EH conversion for 20619 chips
Date: Sun, 4 Feb 2007 22:44:54 +0100 (MET)
Message-ID: <200702042144.l14LisBO003772@harpo.it.uu.se>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aun.it.uu.se ([130.238.12.36]:38216 "EHLO aun.it.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752571AbXBDVpI (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 4 Feb 2007 16:45:08 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org

This patch updates the sata_promise driver to use new-style
libata error handling for 20619 (TX4000) chips. sata_promise
already uses new EH for the other chips it supports, so the
patch is quite simple:

* remove ->phy_reset and ->eng_timeout ops from pdc_pata_ops,
  and instead bind ->freeze, ->thaw, ->error_handler, and
  ->post_internal_cmd to existing new EH functions
* drop ATA_FLAG_SRST from board_20619's flags
* remove now unused pdc_pata_phy_reset() and pdc_eng_timeout()
* pdc_pata_cbl_detect() is now unused, but it contains a cable
  detection procedure that I don't think is mentioned in public
  documentation, so for now I just wrapped it with #if 0/#endif

Tested on a TX4000 with both modern working disks and old/quirky
disks. Also used a CD-RW drive to test reading and writing CDs.

Signed-off-by: Mikael Pettersson <mikpe@it.uu.se>

---

 drivers/ata/sata_promise.c |   58 +++++----------------------------------------
 1 files changed, 7 insertions(+), 51 deletions(-)

--- linux-2.6.20-rc7.upstream/drivers/ata/sata_promise.c.~1~	2007-02-04 15:12:46.000000000 +0100
+++ linux-2.6.20-rc7.upstream/drivers/ata/sata_promise.c	2007-02-04 15:43:53.000000000 +0100
@@ -120,9 +120,7 @@ static u32 pdc_sata_scr_read (struct ata
 static void pdc_sata_scr_write (struct ata_port *ap, unsigned int sc_reg, u32 val);
 static int pdc_ata_init_one (struct pci_dev *pdev, const struct pci_device_id *ent);
 static irqreturn_t pdc_interrupt (int irq, void *dev_instance);
-static void pdc_eng_timeout(struct ata_port *ap);
 static int pdc_port_start(struct ata_port *ap);
-static void pdc_pata_phy_reset(struct ata_port *ap);
 static void pdc_qc_prep(struct ata_queued_cmd *qc);
 static void pdc_tf_load_mmio(struct ata_port *ap, const struct ata_taskfile *tf);
 static void pdc_exec_command_mmio(struct ata_port *ap, const struct ata_taskfile *tf);
@@ -212,12 +210,13 @@ static const struct ata_port_operations 
 	.dev_select		= ata_std_dev_select,
 	.check_atapi_dma	= pdc_check_atapi_dma,
 
-	.phy_reset		= pdc_pata_phy_reset,
-
 	.qc_prep		= pdc_qc_prep,
 	.qc_issue		= pdc_qc_issue_prot,
+	.freeze			= pdc_freeze,
+	.thaw			= pdc_thaw,
+	.error_handler		= pdc_error_handler,
+	.post_internal_cmd	= pdc_post_internal_cmd,
 	.data_xfer		= ata_data_xfer,
-	.eng_timeout		= pdc_eng_timeout,
 	.irq_handler		= pdc_interrupt,
 	.irq_clear		= pdc_irq_clear,
 
@@ -248,7 +247,7 @@ static const struct ata_port_info pdc_po
 	/* board_20619 */
 	{
 		.sht		= &pdc_ata_sht,
-		.flags		= PDC_COMMON_FLAGS | ATA_FLAG_SRST | ATA_FLAG_SLAVE_POSS,
+		.flags		= PDC_COMMON_FLAGS | ATA_FLAG_SLAVE_POSS,
 		.pio_mask	= 0x1f, /* pio0-4 */
 		.mwdma_mask	= 0x07, /* mwdma0-2 */
 		.udma_mask	= 0x7f, /* udma0-6 ; FIXME */
@@ -370,6 +369,7 @@ static void pdc_reset_port(struct ata_po
 	readl(mmio);	/* flush */
 }
 
+#if 0 /* unused, but potentially useful? */
 static void pdc_pata_cbl_detect(struct ata_port *ap)
 {
 	u8 tmp;
@@ -383,14 +383,7 @@ static void pdc_pata_cbl_detect(struct a
 	} else
 		ap->cbl = ATA_CBL_PATA80;
 }
-
-static void pdc_pata_phy_reset(struct ata_port *ap)
-{
-	pdc_pata_cbl_detect(ap);
-	pdc_reset_port(ap);
-	ata_port_probe(ap);
-	ata_bus_reset(ap);
-}
+#endif
 
 static u32 pdc_sata_scr_read (struct ata_port *ap, unsigned int sc_reg)
 {
@@ -587,43 +580,6 @@ static void pdc_post_internal_cmd(struct
 		pdc_reset_port(ap);
 }
 
-static void pdc_eng_timeout(struct ata_port *ap)
-{
-	struct ata_host *host = ap->host;
-	u8 drv_stat;
-	struct ata_queued_cmd *qc;
-	unsigned long flags;
-
-	DPRINTK("ENTER\n");
-
-	spin_lock_irqsave(&host->lock, flags);
-
-	qc = ata_qc_from_tag(ap, ap->active_tag);
-
-	switch (qc->tf.protocol) {
-	case ATA_PROT_DMA:
-	case ATA_PROT_NODATA:
-		ata_port_printk(ap, KERN_ERR, "command timeout\n");
-		drv_stat = ata_wait_idle(ap);
-		qc->err_mask |= __ac_err_mask(drv_stat);
-		break;
-
-	default:
-		drv_stat = ata_busy_wait(ap, ATA_BUSY | ATA_DRQ, 1000);
-
-		ata_port_printk(ap, KERN_ERR,
-				"unknown timeout, cmd 0x%x stat 0x%x\n",
-				qc->tf.command, drv_stat);
-
-		qc->err_mask |= ac_err_mask(drv_stat);
-		break;
-	}
-
-	spin_unlock_irqrestore(&host->lock, flags);
-	ata_eh_qc_complete(qc);
-	DPRINTK("EXIT\n");
-}
-
 static inline unsigned int pdc_host_intr( struct ata_port *ap,
                                           struct ata_queued_cmd *qc)
 {
