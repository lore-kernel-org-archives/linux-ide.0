From: Jeff Garzik <jgarzik@pobox.com>
Subject: [git patch] 2.6.x libata fix
Date: Tue, 30 Aug 2005 00:49:39 -0400
Message-ID: <20050830044939.GA28136@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from havoc.gtf.org ([69.61.125.42]:5054 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S932134AbVH3Etn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 30 Aug 2005 00:49:43 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: linux-ide@vger.kernel.org


Please pull from the 'upstream' branch of
rsync://rsync.kernel.org/pub/scm/linux/kernel/git/jgarzik/libata-dev.git

to obtain the following fix:


 drivers/scsi/sata_promise.c |   50 +++++++++++++++++++++++++++++++++++++-------
 1 files changed, 43 insertions(+), 7 deletions(-)


commit 2cba582a49f1535c1a12a687cfb3dab713c22cc4
Author: Jeff Garzik <jgarzik@pobox.com>
Date:   Mon Aug 29 05:12:30 2005 -0400

    [libata sata_promise] Do not attempt to use SATA phy on PATA controllers


diff --git a/drivers/scsi/sata_promise.c b/drivers/scsi/sata_promise.c
--- a/drivers/scsi/sata_promise.c
+++ b/drivers/scsi/sata_promise.c
@@ -84,7 +84,8 @@ static irqreturn_t pdc_interrupt (int ir
 static void pdc_eng_timeout(struct ata_port *ap);
 static int pdc_port_start(struct ata_port *ap);
 static void pdc_port_stop(struct ata_port *ap);
-static void pdc_phy_reset(struct ata_port *ap);
+static void pdc_pata_phy_reset(struct ata_port *ap);
+static void pdc_sata_phy_reset(struct ata_port *ap);
 static void pdc_qc_prep(struct ata_queued_cmd *qc);
 static void pdc_tf_load_mmio(struct ata_port *ap, struct ata_taskfile *tf);
 static void pdc_exec_command_mmio(struct ata_port *ap, struct ata_taskfile *tf);
@@ -111,19 +112,22 @@ static Scsi_Host_Template pdc_ata_sht = 
 	.ordered_flush		= 1,
 };
 
-static struct ata_port_operations pdc_ata_ops = {
+static struct ata_port_operations pdc_sata_ops = {
 	.port_disable		= ata_port_disable,
 	.tf_load		= pdc_tf_load_mmio,
 	.tf_read		= ata_tf_read,
 	.check_status		= ata_check_status,
 	.exec_command		= pdc_exec_command_mmio,
 	.dev_select		= ata_std_dev_select,
-	.phy_reset		= pdc_phy_reset,
+
+	.phy_reset		= pdc_sata_phy_reset,
+
 	.qc_prep		= pdc_qc_prep,
 	.qc_issue		= pdc_qc_issue_prot,
 	.eng_timeout		= pdc_eng_timeout,
 	.irq_handler		= pdc_interrupt,
 	.irq_clear		= pdc_irq_clear,
+
 	.scr_read		= pdc_sata_scr_read,
 	.scr_write		= pdc_sata_scr_write,
 	.port_start		= pdc_port_start,
@@ -131,6 +135,27 @@ static struct ata_port_operations pdc_at
 	.host_stop		= ata_host_stop,
 };
 
+static struct ata_port_operations pdc_pata_ops = {
+	.port_disable		= ata_port_disable,
+	.tf_load		= pdc_tf_load_mmio,
+	.tf_read		= ata_tf_read,
+	.check_status		= ata_check_status,
+	.exec_command		= pdc_exec_command_mmio,
+	.dev_select		= ata_std_dev_select,
+
+	.phy_reset		= pdc_pata_phy_reset,
+
+	.qc_prep		= pdc_qc_prep,
+	.qc_issue		= pdc_qc_issue_prot,
+	.eng_timeout		= pdc_eng_timeout,
+	.irq_handler		= pdc_interrupt,
+	.irq_clear		= pdc_irq_clear,
+
+	.port_start		= pdc_port_start,
+	.port_stop		= pdc_port_stop,
+	.host_stop		= ata_host_stop,
+};
+
 static struct ata_port_info pdc_port_info[] = {
 	/* board_2037x */
 	{
@@ -140,7 +165,7 @@ static struct ata_port_info pdc_port_inf
 		.pio_mask	= 0x1f, /* pio0-4 */
 		.mwdma_mask	= 0x07, /* mwdma0-2 */
 		.udma_mask	= 0x7f, /* udma0-6 ; FIXME */
-		.port_ops	= &pdc_ata_ops,
+		.port_ops	= &pdc_sata_ops,
 	},
 
 	/* board_20319 */
@@ -151,7 +176,7 @@ static struct ata_port_info pdc_port_inf
 		.pio_mask	= 0x1f, /* pio0-4 */
 		.mwdma_mask	= 0x07, /* mwdma0-2 */
 		.udma_mask	= 0x7f, /* udma0-6 ; FIXME */
-		.port_ops	= &pdc_ata_ops,
+		.port_ops	= &pdc_sata_ops,
 	},
 
 	/* board_20619 */
@@ -162,7 +187,7 @@ static struct ata_port_info pdc_port_inf
 		.pio_mask	= 0x1f, /* pio0-4 */
 		.mwdma_mask	= 0x07, /* mwdma0-2 */
 		.udma_mask	= 0x7f, /* udma0-6 ; FIXME */
-		.port_ops	= &pdc_ata_ops,
+		.port_ops	= &pdc_pata_ops,
 	},
 };
 
@@ -277,12 +302,23 @@ static void pdc_reset_port(struct ata_po
 	readl(mmio);	/* flush */
 }
 
-static void pdc_phy_reset(struct ata_port *ap)
+static void pdc_sata_phy_reset(struct ata_port *ap)
 {
 	pdc_reset_port(ap);
 	sata_phy_reset(ap);
 }
 
+static void pdc_pata_phy_reset(struct ata_port *ap)
+{
+	/* FIXME: add cable detect.  Don't assume 40-pin cable */
+	ap->cbl = ATA_CBL_PATA40;
+	ap->udma_mask &= ATA_UDMA_MASK_40C;
+
+	pdc_reset_port(ap);
+	ata_port_probe(ap);
+	ata_bus_reset(ap);
+}
+
 static u32 pdc_sata_scr_read (struct ata_port *ap, unsigned int sc_reg)
 {
 	if (sc_reg > SCR_CONTROL)
