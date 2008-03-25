From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 22/27] libata: replace tf_read with qc_fill_rtf for non-SFF drivers
Date: Tue, 25 Mar 2008 22:17:00 +0900
Message-ID: <12064510283026-git-send-email-htejun@gmail.com>
References: <1206451025926-git-send-email-htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.191]:60507 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755037AbYCYNRm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 25 Mar 2008 09:17:42 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1755484rvb.1
        for <linux-ide@vger.kernel.org>; Tue, 25 Mar 2008 06:17:42 -0700 (PDT)
In-Reply-To: <1206451025926-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org, liml@rtr.ca, alan@lxorguk.ukuu.org.uk, James.Bottomley@HansenPartnership.com, brking@us.ibm.com, ashish.kalra@freescale.com, leoli@freescale.com
Cc: Tejun Heo <htejun@gmail.com>

Now that all SFF stuff is separated out of core layer, core layer
doesn't call ops->tf_read directly.  It gets called only via
ops->qc_fill_rtf() for non-SFF drivers.  This patch directly
implements private ops->qc_fill_rtf() for non-SFF controllers and kill
ops->tf_read().

This is much cleaner for non-SFF controllers as some of them have to
cache SFF register values in private data structure and report the
cached values via ops->tf_read().  Also, ops->tf_read() gets nasty for
controllers which don't have clear notion of TF registers when
operation is not in progress.

As this change makes default ops->qc_fill_rtf unnecessary, move
ata_sff_qc_fill_rtf() form ata_base_port_ops to ata_sff_port_ops where
it belongs.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/ahci.c            |   21 +++++++-------
 drivers/ata/libata-core.c     |    1 -
 drivers/ata/libata-sff.c      |    1 +
 drivers/ata/sata_fsl.c        |   24 ++++++++++------
 drivers/ata/sata_sil24.c      |    8 -----
 drivers/scsi/ipr.c            |   59 +++++++++++++++++++++--------------------
 drivers/scsi/libsas/sas_ata.c |   17 ++++++-----
 7 files changed, 66 insertions(+), 65 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 1389c64..ad5b6f3 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -243,9 +243,9 @@ static int ahci_scr_read(struct ata_port *ap, unsigned int sc_reg, u32 *val);
 static int ahci_scr_write(struct ata_port *ap, unsigned int sc_reg, u32 val);
 static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent);
 static unsigned int ahci_qc_issue(struct ata_queued_cmd *qc);
+static bool ahci_qc_fill_rtf(struct ata_queued_cmd *qc);
 static int ahci_port_start(struct ata_port *ap);
 static void ahci_port_stop(struct ata_port *ap);
-static void ahci_tf_read(struct ata_port *ap, struct ata_taskfile *tf);
 static void ahci_qc_prep(struct ata_queued_cmd *qc);
 static u8 ahci_check_status(struct ata_port *ap);
 static void ahci_freeze(struct ata_port *ap);
@@ -295,10 +295,10 @@ static struct ata_port_operations ahci_ops = {
 	.sff_check_status	= ahci_check_status,
 	.sff_check_altstatus	= ahci_check_status,
 
-	.sff_tf_read		= ahci_tf_read,
 	.qc_defer		= sata_pmp_qc_defer_cmd_switch,
 	.qc_prep		= ahci_qc_prep,
 	.qc_issue		= ahci_qc_issue,
+	.qc_fill_rtf		= ahci_qc_fill_rtf,
 
 	.freeze			= ahci_freeze,
 	.thaw			= ahci_thaw,
@@ -1473,14 +1473,6 @@ static u8 ahci_check_status(struct ata_port *ap)
 	return readl(mmio + PORT_TFDATA) & 0xFF;
 }
 
-static void ahci_tf_read(struct ata_port *ap, struct ata_taskfile *tf)
-{
-	struct ahci_port_priv *pp = ap->private_data;
-	u8 *d2h_fis = pp->rx_fis + RX_FIS_D2H_REG;
-
-	ata_tf_from_fis(d2h_fis, tf);
-}
-
 static unsigned int ahci_fill_sg(struct ata_queued_cmd *qc, void *cmd_tbl)
 {
 	struct scatterlist *sg;
@@ -1779,6 +1771,15 @@ static unsigned int ahci_qc_issue(struct ata_queued_cmd *qc)
 	return 0;
 }
 
+static bool ahci_qc_fill_rtf(struct ata_queued_cmd *qc)
+{
+	struct ahci_port_priv *pp = qc->ap->private_data;
+	u8 *d2h_fis = pp->rx_fis + RX_FIS_D2H_REG;
+
+	ata_tf_from_fis(d2h_fis, &qc->result_tf);
+	return true;
+}
+
 static void ahci_freeze(struct ata_port *ap)
 {
 	void __iomem *port_mmio = ahci_port_base(ap);
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 9a14be2..fad12d7 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -74,7 +74,6 @@ const unsigned long sata_deb_timing_hotplug[]		= {  25,  500, 2000 };
 const unsigned long sata_deb_timing_long[]		= { 100, 2000, 5000 };
 
 const struct ata_port_operations ata_base_port_ops = {
-	.qc_fill_rtf		= ata_sff_qc_fill_rtf,
 	.prereset		= ata_std_prereset,
 	.postreset		= ata_std_postreset,
 	.error_handler		= ata_std_error_handler,
diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index 5ae813f..8e6c78a 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -44,6 +44,7 @@ const struct ata_port_operations ata_sff_port_ops = {
 
 	.qc_prep		= ata_sff_qc_prep,
 	.qc_issue		= ata_sff_qc_issue,
+	.qc_fill_rtf		= ata_sff_qc_fill_rtf,
 
 	.freeze			= ata_sff_freeze,
 	.thaw			= ata_sff_thaw,
diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c
index 1996050..646cb28 100644
--- a/drivers/ata/sata_fsl.c
+++ b/drivers/ata/sata_fsl.c
@@ -464,6 +464,20 @@ static unsigned int sata_fsl_qc_issue(struct ata_queued_cmd *qc)
 	return 0;
 }
 
+static bool sata_fsl_qc_fill_rtf(struct ata_queued_cmd *qc)
+{
+	struct sata_fsl_port_priv *pp = qc->ap->private_data;
+	struct sata_fsl_host_priv *host_priv = qc->ap->host->private_data;
+	void __iomem *hcr_base = host_priv->hcr_base;
+	unsigned int tag = sata_fsl_tag(qc->tag, hcr_base);
+	struct command_desc *cd;
+
+	cd = pp->cmdentry + tag;
+
+	ata_tf_from_fis(cd->sfis, &qc->result_tf);
+	return true;
+}
+
 static int sata_fsl_scr_write(struct ata_port *ap, unsigned int sc_reg_in,
 			       u32 val)
 {
@@ -580,13 +594,6 @@ static u8 sata_fsl_check_status(struct ata_port *ap)
 	return pp->tf.command;
 }
 
-static void sata_fsl_tf_read(struct ata_port *ap, struct ata_taskfile *tf)
-{
-	struct sata_fsl_port_priv *pp = ap->private_data;
-
-	*tf = pp->tf;
-}
-
 static int sata_fsl_port_start(struct ata_port *ap)
 {
 	struct device *dev = ap->host->dev;
@@ -1193,10 +1200,9 @@ static const struct ata_port_operations sata_fsl_ops = {
 	.sff_check_status = sata_fsl_check_status,
 	.sff_check_altstatus = sata_fsl_check_status,
 
-	.sff_tf_read = sata_fsl_tf_read,
-
 	.qc_prep = sata_fsl_qc_prep,
 	.qc_issue = sata_fsl_qc_issue,
+	.qc_fill_rtf = sata_fsl_qc_fill_rtf,
 
 	.scr_read = sata_fsl_scr_read,
 	.scr_write = sata_fsl_scr_write,
diff --git a/drivers/ata/sata_sil24.c b/drivers/ata/sata_sil24.c
index 79952f8..51a7c06 100644
--- a/drivers/ata/sata_sil24.c
+++ b/drivers/ata/sata_sil24.c
@@ -344,7 +344,6 @@ static void sil24_dev_config(struct ata_device *dev);
 static u8 sil24_check_status(struct ata_port *ap);
 static int sil24_scr_read(struct ata_port *ap, unsigned sc_reg, u32 *val);
 static int sil24_scr_write(struct ata_port *ap, unsigned sc_reg, u32 val);
-static void sil24_tf_read(struct ata_port *ap, struct ata_taskfile *tf);
 static int sil24_qc_defer(struct ata_queued_cmd *qc);
 static void sil24_qc_prep(struct ata_queued_cmd *qc);
 static unsigned int sil24_qc_issue(struct ata_queued_cmd *qc);
@@ -404,7 +403,6 @@ static struct ata_port_operations sil24_ops = {
 
 	.sff_check_status	= sil24_check_status,
 	.sff_check_altstatus	= sil24_check_status,
-	.sff_tf_read		= sil24_tf_read,
 	.qc_defer		= sil24_qc_defer,
 	.qc_prep		= sil24_qc_prep,
 	.qc_issue		= sil24_qc_issue,
@@ -533,12 +531,6 @@ static int sil24_scr_write(struct ata_port *ap, unsigned sc_reg, u32 val)
 	return -EINVAL;
 }
 
-static void sil24_tf_read(struct ata_port *ap, struct ata_taskfile *tf)
-{
-	struct sil24_port_priv *pp = ap->private_data;
-	*tf = pp->tf;
-}
-
 static void sil24_config_port(struct ata_port *ap)
 {
 	void __iomem *port = ap->ioaddr.cmd_addr;
diff --git a/drivers/scsi/ipr.c b/drivers/scsi/ipr.c
index 2ecd329..b079f6c 100644
--- a/drivers/scsi/ipr.c
+++ b/drivers/scsi/ipr.c
@@ -5041,33 +5041,6 @@ static void ipr_ata_post_internal(struct ata_queued_cmd *qc)
 }
 
 /**
- * ipr_tf_read - Read the current ATA taskfile for the ATA port
- * @ap:	ATA port
- * @tf:	destination ATA taskfile
- *
- * Return value:
- * 	none
- **/
-static void ipr_tf_read(struct ata_port *ap, struct ata_taskfile *tf)
-{
-	struct ipr_sata_port *sata_port = ap->private_data;
-	struct ipr_ioasa_gata *g = &sata_port->ioasa;
-
-	tf->feature = g->error;
-	tf->nsect = g->nsect;
-	tf->lbal = g->lbal;
-	tf->lbam = g->lbam;
-	tf->lbah = g->lbah;
-	tf->device = g->device;
-	tf->command = g->status;
-	tf->hob_nsect = g->hob_nsect;
-	tf->hob_lbal = g->hob_lbal;
-	tf->hob_lbam = g->hob_lbam;
-	tf->hob_lbah = g->hob_lbah;
-	tf->ctl = g->alt_status;
-}
-
-/**
  * ipr_copy_sata_tf - Copy a SATA taskfile to an IOA data structure
  * @regs:	destination
  * @tf:	source ATA taskfile
@@ -5245,6 +5218,35 @@ static unsigned int ipr_qc_issue(struct ata_queued_cmd *qc)
 }
 
 /**
+ * ipr_qc_fill_rtf - Read result TF
+ * @qc: ATA queued command
+ *
+ * Return value:
+ * 	true
+ **/
+static bool ipr_qc_fill_rtf(struct ata_queued_cmd *qc)
+{
+	struct ipr_sata_port *sata_port = qc->ap->private_data;
+	struct ipr_ioasa_gata *g = &sata_port->ioasa;
+	struct ata_taskfile *tf = &qc->result_tf;
+
+	tf->feature = g->error;
+	tf->nsect = g->nsect;
+	tf->lbal = g->lbal;
+	tf->lbam = g->lbam;
+	tf->lbah = g->lbah;
+	tf->device = g->device;
+	tf->command = g->status;
+	tf->hob_nsect = g->hob_nsect;
+	tf->hob_lbal = g->hob_lbal;
+	tf->hob_lbam = g->hob_lbam;
+	tf->hob_lbah = g->hob_lbah;
+	tf->ctl = g->alt_status;
+
+	return true;
+}
+
+/**
  * ipr_ata_check_status - Return last ATA status
  * @ap:	ATA port
  *
@@ -5277,10 +5279,9 @@ static struct ata_port_operations ipr_sata_ops = {
 	.phy_reset = ipr_ata_phy_reset,
 	.hardreset = ipr_sata_reset,
 	.post_internal_cmd = ipr_ata_post_internal,
-	.sff_tf_read = ipr_tf_read,
 	.qc_prep = ata_noop_qc_prep,
 	.qc_issue = ipr_qc_issue,
-	.qc_fill_rtf = ata_sff_qc_fill_rtf,
+	.qc_fill_rtf = ipr_qc_fill_rtf,
 	.port_start = ata_sas_port_start,
 	.port_stop = ata_sas_port_stop
 };
diff --git a/drivers/scsi/libsas/sas_ata.c b/drivers/scsi/libsas/sas_ata.c
index 2ec2558..e81f2fd 100644
--- a/drivers/scsi/libsas/sas_ata.c
+++ b/drivers/scsi/libsas/sas_ata.c
@@ -225,6 +225,14 @@ static unsigned int sas_ata_qc_issue(struct ata_queued_cmd *qc)
 	return 0;
 }
 
+static bool sas_ata_qc_fill_rtf(struct ata_queued_cmd *qc)
+{
+	struct domain_device *dev = qc->ap->private_data;
+
+	memcpy(&qc->result_tf, &dev->sata_dev.tf, sizeof(qc->result_tf));
+	return true;
+}
+
 static u8 sas_ata_check_status(struct ata_port *ap)
 {
 	struct domain_device *dev = ap->private_data;
@@ -292,12 +300,6 @@ static void sas_ata_post_internal(struct ata_queued_cmd *qc)
 	}
 }
 
-static void sas_ata_tf_read(struct ata_port *ap, struct ata_taskfile *tf)
-{
-	struct domain_device *dev = ap->private_data;
-	memcpy(tf, &dev->sata_dev.tf, sizeof (*tf));
-}
-
 static int sas_ata_scr_write(struct ata_port *ap, unsigned int sc_reg_in,
 			      u32 val)
 {
@@ -353,10 +355,9 @@ static struct ata_port_operations sas_sata_ops = {
 	.sff_dev_select		= ata_noop_dev_select,
 	.phy_reset		= sas_ata_phy_reset,
 	.post_internal_cmd	= sas_ata_post_internal,
-	.sff_tf_read		= sas_ata_tf_read,
 	.qc_prep		= ata_noop_qc_prep,
 	.qc_issue		= sas_ata_qc_issue,
-	.qc_fill_rtf		= ata_sff_qc_fill_rtf,
+	.qc_fill_rtf		= sas_ata_qc_fill_rtf,
 	.port_start		= ata_sas_port_start,
 	.port_stop		= ata_sas_port_stop,
 	.scr_read		= sas_ata_scr_read,
-- 
1.5.2.4

