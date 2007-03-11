From: Mikael Pettersson <mikpe@it.uu.se>
Subject: [PATCH libata#upstream 2/2] sata_promise: separate SATA and PATA ops
Date: Sun, 11 Mar 2007 21:20:43 +0100 (MET)
Message-ID: <200703112020.l2BKKh5P018685@harpo.it.uu.se>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aun.it.uu.se ([130.238.12.36]:41556 "EHLO aun.it.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750759AbXCKUUt (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 11 Mar 2007 16:20:49 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

This patch changes sata_promise so that the PATA ports
on TX2plus chips are bound to the pdc_pata_ops structure.
This means that operations called from the SATA ops
structures don't need any SATA-vs-PATA tests any more.
Instead, operations that depend on a port being SATA or
PATA are separated into different procedures.

* pdc_cable_type() is split into a PATA version and a
  SATA version
* pdc_error_handler() is split into a PATA version and a
  SATA version, that both call a common version after
  setting up the `hardreset' function pointer
* pdc_old_check_atapi_dma() is now only used for SATAI
  ports, so is renamed to pdc_old_sata_check_atapi_dma()
  and simplified
* pdc_sata_scr_{read,write}() are now only used for SATA
  ports, so their is-not-SATA tests are removed
* pdc_port_start() is split into three procedures: a wrapper
  which performs the ->ops adjustment on TX2plus PATA ports,
  a procedure with the common code, and a procedure with
  the SATA-specific code (this bit might be cleaned up by
  Tejun's new init model)

Tested on 20619, 20575, and 20775 chips.

Signed-off-by: Mikael Pettersson <mikpe@it.uu.se>
---
 drivers/ata/sata_promise.c |  107 +++++++++++++++++++++++++++------------------
 1 files changed, 66 insertions(+), 41 deletions(-)

--- linux-2.6.21-rc3+upstream/drivers/ata/sata_promise.c.~1~	2007-03-11 20:54:10.000000000 +0100
+++ linux-2.6.21-rc3+upstream/drivers/ata/sata_promise.c	2007-03-11 20:54:27.000000000 +0100
@@ -45,7 +45,7 @@
 #include "sata_promise.h"
 
 #define DRV_NAME	"sata_promise"
-#define DRV_VERSION	"2.02"
+#define DRV_VERSION	"2.03"
 
 
 enum {
@@ -124,14 +124,16 @@ static void pdc_qc_prep(struct ata_queue
 static void pdc_tf_load_mmio(struct ata_port *ap, const struct ata_taskfile *tf);
 static void pdc_exec_command_mmio(struct ata_port *ap, const struct ata_taskfile *tf);
 static int pdc_check_atapi_dma(struct ata_queued_cmd *qc);
-static int pdc_old_check_atapi_dma(struct ata_queued_cmd *qc);
+static int pdc_old_sata_check_atapi_dma(struct ata_queued_cmd *qc);
 static void pdc_irq_clear(struct ata_port *ap);
 static unsigned int pdc_qc_issue_prot(struct ata_queued_cmd *qc);
 static void pdc_freeze(struct ata_port *ap);
 static void pdc_thaw(struct ata_port *ap);
-static void pdc_error_handler(struct ata_port *ap);
+static void pdc_pata_error_handler(struct ata_port *ap);
+static void pdc_sata_error_handler(struct ata_port *ap);
 static void pdc_post_internal_cmd(struct ata_queued_cmd *qc);
-static int pdc_cable_detect(struct ata_port *ap);
+static int pdc_pata_cable_detect(struct ata_port *ap);
+static int pdc_sata_cable_detect(struct ata_port *ap);
 
 static struct scsi_host_template pdc_ata_sht = {
 	.module			= THIS_MODULE,
@@ -164,9 +166,9 @@ static const struct ata_port_operations 
 	.qc_issue		= pdc_qc_issue_prot,
 	.freeze			= pdc_freeze,
 	.thaw			= pdc_thaw,
-	.error_handler		= pdc_error_handler,
+	.error_handler		= pdc_sata_error_handler,
 	.post_internal_cmd	= pdc_post_internal_cmd,
-	.cable_detect		= pdc_cable_detect,
+	.cable_detect		= pdc_sata_cable_detect,
 	.data_xfer		= ata_data_xfer,
 	.irq_handler		= pdc_interrupt,
 	.irq_clear		= pdc_irq_clear,
@@ -186,15 +188,15 @@ static const struct ata_port_operations 
 	.check_status		= ata_check_status,
 	.exec_command		= pdc_exec_command_mmio,
 	.dev_select		= ata_std_dev_select,
-	.check_atapi_dma	= pdc_old_check_atapi_dma,
+	.check_atapi_dma	= pdc_old_sata_check_atapi_dma,
 
 	.qc_prep		= pdc_qc_prep,
 	.qc_issue		= pdc_qc_issue_prot,
 	.freeze			= pdc_freeze,
 	.thaw			= pdc_thaw,
-	.error_handler		= pdc_error_handler,
+	.error_handler		= pdc_sata_error_handler,
 	.post_internal_cmd	= pdc_post_internal_cmd,
-	.cable_detect		= pdc_cable_detect,
+	.cable_detect		= pdc_sata_cable_detect,
 	.data_xfer		= ata_data_xfer,
 	.irq_handler		= pdc_interrupt,
 	.irq_clear		= pdc_irq_clear,
@@ -219,9 +221,9 @@ static const struct ata_port_operations 
 	.qc_issue		= pdc_qc_issue_prot,
 	.freeze			= pdc_freeze,
 	.thaw			= pdc_thaw,
-	.error_handler		= pdc_error_handler,
+	.error_handler		= pdc_pata_error_handler,
 	.post_internal_cmd	= pdc_post_internal_cmd,
-	.cable_detect		= pdc_cable_detect,
+	.cable_detect		= pdc_pata_cable_detect,
 	.data_xfer		= ata_data_xfer,
 	.irq_handler		= pdc_interrupt,
 	.irq_clear		= pdc_irq_clear,
@@ -316,18 +318,12 @@ static struct pci_driver pdc_ata_pci_dri
 };
 
 
-static int pdc_port_start(struct ata_port *ap)
+static int pdc_common_port_start(struct ata_port *ap)
 {
 	struct device *dev = ap->host->dev;
-	struct pdc_host_priv *hp = ap->host->private_data;
 	struct pdc_port_priv *pp;
 	int rc;
 
-	/* fix up port flags and cable type for SATA+PATA chips */
-	ap->flags |= hp->port_flags[ap->port_no];
-	if (ap->flags & ATA_FLAG_SATA)
-		ap->cbl = ATA_CBL_SATA;
-
 	rc = ata_port_start(ap);
 	if (rc)
 		return rc;
@@ -342,8 +338,20 @@ static int pdc_port_start(struct ata_por
 
 	ap->private_data = pp;
 
+	return 0;
+}
+
+static int pdc_sata_port_start(struct ata_port *ap)
+{
+	struct pdc_host_priv *hp = ap->host->private_data;
+	int rc;
+
+	rc = pdc_common_port_start(ap);
+	if (rc)
+		return rc;
+
 	/* fix up PHYMODE4 align timing */
-	if ((hp->flags & PDC_FLAG_GEN_II) && sata_scr_valid(ap)) {
+	if (hp->flags & PDC_FLAG_GEN_II) {
 		void __iomem *mmio = (void __iomem *) ap->ioaddr.scr_addr;
 		unsigned int tmp;
 
@@ -355,6 +363,21 @@ static int pdc_port_start(struct ata_por
 	return 0;
 }
 
+static int pdc_port_start(struct ata_port *ap)
+{
+	struct pdc_host_priv *hp = ap->host->private_data;
+
+	/* fix up port flags and cable type for SATA+PATA chips */
+	ap->flags |= hp->port_flags[ap->port_no];
+	if (ap->flags & ATA_FLAG_SATA) {
+		ap->cbl = ATA_CBL_SATA;
+		return pdc_sata_port_start(ap);
+	} else {
+		ap->ops = &pdc_pata_ops;
+		return pdc_common_port_start(ap);
+	}
+}
+
 static void pdc_reset_port(struct ata_port *ap)
 {
 	void __iomem *mmio = ap->ioaddr.cmd_addr + PDC_CTLSTAT;
@@ -377,23 +400,25 @@ static void pdc_reset_port(struct ata_po
 	readl(mmio);	/* flush */
 }
 
-static int pdc_cable_detect(struct ata_port *ap)
+static int pdc_pata_cable_detect(struct ata_port *ap)
 {
 	u8 tmp;
 	void __iomem *mmio = (void __iomem *) ap->ioaddr.cmd_addr + PDC_CTLSTAT + 0x03;
 
-	if (!sata_scr_valid(ap)) {
-		tmp = readb(mmio);
-		if (tmp & 0x01)
-			return ATA_CBL_PATA40;
-		return ATA_CBL_PATA80;
-	}
+	tmp = readb(mmio);
+	if (tmp & 0x01)
+		return ATA_CBL_PATA40;
+	return ATA_CBL_PATA80;
+}
+
+static int pdc_sata_cable_detect(struct ata_port *ap)
+{
 	return ATA_CBL_SATA;
 }
 
 static u32 pdc_sata_scr_read (struct ata_port *ap, unsigned int sc_reg)
 {
-	if (sc_reg > SCR_CONTROL || ap->cbl != ATA_CBL_SATA)
+	if (sc_reg > SCR_CONTROL)
 		return 0xffffffffU;
 	return readl(ap->ioaddr.scr_addr + (sc_reg * 4));
 }
@@ -402,7 +427,7 @@ static u32 pdc_sata_scr_read (struct ata
 static void pdc_sata_scr_write (struct ata_port *ap, unsigned int sc_reg,
 			       u32 val)
 {
-	if (sc_reg > SCR_CONTROL || ap->cbl != ATA_CBL_SATA)
+	if (sc_reg > SCR_CONTROL)
 		return;
 	writel(val, ap->ioaddr.scr_addr + (sc_reg * 4));
 }
@@ -558,22 +583,26 @@ static void pdc_thaw(struct ata_port *ap
 	readl(mmio + PDC_CTLSTAT); /* flush */
 }
 
-static void pdc_error_handler(struct ata_port *ap)
+static void pdc_common_error_handler(struct ata_port *ap, ata_reset_fn_t hardreset)
 {
-	ata_reset_fn_t hardreset;
-
 	if (!(ap->pflags & ATA_PFLAG_FROZEN))
 		pdc_reset_port(ap);
 
-	hardreset = NULL;
-	if (sata_scr_valid(ap))
-		hardreset = sata_std_hardreset;
-
 	/* perform recovery */
 	ata_do_eh(ap, ata_std_prereset, ata_std_softreset, hardreset,
 		  ata_std_postreset);
 }
 
+static void pdc_pata_error_handler(struct ata_port *ap)
+{
+	pdc_common_error_handler(ap, NULL);
+}
+
+static void pdc_sata_error_handler(struct ata_port *ap)
+{
+	pdc_common_error_handler(ap, sata_std_hardreset);
+}
+
 static void pdc_post_internal_cmd(struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
@@ -763,14 +792,10 @@ static int pdc_check_atapi_dma(struct at
 	return pio;
 }
 
-static int pdc_old_check_atapi_dma(struct ata_queued_cmd *qc)
+static int pdc_old_sata_check_atapi_dma(struct ata_queued_cmd *qc)
 {
-	struct ata_port *ap = qc->ap;
-
 	/* First generation chips cannot use ATAPI DMA on SATA ports */
-	if (sata_scr_valid(ap))
-		return 1;
-	return pdc_check_atapi_dma(qc);
+	return 1;
 }
 
 static void pdc_ata_setup_port(struct ata_ioports *port, void __iomem *base,
