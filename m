From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] libata: convert several bmdma-style controllers to new EH
Date: Tue, 13 Jun 2006 20:51:31 +0900
Message-ID: <20060613115131.GA17964@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.201]:48273 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932069AbWFMLwC (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 13 Jun 2006 07:52:02 -0400
Received: by nz-out-0102.google.com with SMTP id s18so1874211nze
        for <linux-ide@vger.kernel.org>; Tue, 13 Jun 2006 04:52:00 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

Convert sata_sis, svw, uli and vsc drivers to new EH.  All the drivers
used to specify ATA_FLAG_SATA_RESET to tell libata to use SATA
hardreset instead of SRST.

This patch preserves the behavior by defining private error handler
for each driver which only supports SATA hardreset.  It is likely that
all these controllers support SRST and can simply use the stock bmdma
EH.  The private EH methods will be removed after each driver is
tested w/ the stock bmdma EH.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/sata_sis.c |   14 ++++++++++----
 drivers/scsi/sata_svw.c |   16 ++++++++++++----
 drivers/scsi/sata_uli.c |   15 ++++++++++-----
 drivers/scsi/sata_vsc.c |   12 +++++++++---
 4 files changed, 41 insertions(+), 16 deletions(-)

f8619ec9d9eb62a5b730c69836f7333f7f69661d
diff --git a/drivers/scsi/sata_sis.c b/drivers/scsi/sata_sis.c
index a07e6e5..9d305be 100644
--- a/drivers/scsi/sata_sis.c
+++ b/drivers/scsi/sata_sis.c
@@ -64,6 +64,7 @@ enum {
 };
 
 static int sis_init_one (struct pci_dev *pdev, const struct pci_device_id *ent);
+static void sis_error_handler (struct ata_port *ap);
 static u32 sis_scr_read (struct ata_port *ap, unsigned int sc_reg);
 static void sis_scr_write (struct ata_port *ap, unsigned int sc_reg, u32 val);
 
@@ -107,7 +108,6 @@ static const struct ata_port_operations 
 	.check_status		= ata_check_status,
 	.exec_command		= ata_exec_command,
 	.dev_select		= ata_std_dev_select,
-	.phy_reset		= sata_phy_reset,
 	.bmdma_setup            = ata_bmdma_setup,
 	.bmdma_start            = ata_bmdma_start,
 	.bmdma_stop		= ata_bmdma_stop,
@@ -115,7 +115,8 @@ static const struct ata_port_operations 
 	.qc_prep		= ata_qc_prep,
 	.qc_issue		= ata_qc_issue_prot,
 	.data_xfer		= ata_pio_data_xfer,
-	.eng_timeout		= ata_eng_timeout,
+	.error_handler		= sis_error_handler,
+	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
 	.irq_handler		= ata_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
 	.scr_read		= sis_scr_read,
@@ -127,8 +128,7 @@ static const struct ata_port_operations 
 
 static struct ata_port_info sis_port_info = {
 	.sht		= &sis_sht,
-	.host_flags	= ATA_FLAG_SATA | ATA_FLAG_SATA_RESET |
-			  ATA_FLAG_NO_LEGACY,
+	.host_flags	= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY,
 	.pio_mask	= 0x1f,
 	.mwdma_mask	= 0x7,
 	.udma_mask	= 0x7f,
@@ -234,6 +234,12 @@ static void sis_scr_write (struct ata_po
 	}
 }
 
+static void sis_error_handler (struct ata_port *ap)
+{
+	ata_bmdma_drive_eh(ap, ata_std_prereset, NULL, sata_std_hardreset,
+			   ata_std_postreset);
+}
+
 static int sis_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	static int printed_version;
diff --git a/drivers/scsi/sata_svw.c b/drivers/scsi/sata_svw.c
index d9b5168..e46ed41 100644
--- a/drivers/scsi/sata_svw.c
+++ b/drivers/scsi/sata_svw.c
@@ -237,6 +237,14 @@ static u8 k2_stat_check_status(struct at
        	return readl((void *) ap->ioaddr.status_addr);
 }
 
+
+static void k2_error_handler(struct ata_port *ap)
+{
+	ata_bmdma_drive_eh(ap, ata_std_prereset, NULL, sata_std_hardreset,
+			   ata_std_postreset);
+}
+
+
 #ifdef CONFIG_PPC_OF
 /*
  * k2_sata_proc_info
@@ -314,7 +322,6 @@ static const struct ata_port_operations 
 	.check_status		= k2_stat_check_status,
 	.exec_command		= ata_exec_command,
 	.dev_select		= ata_std_dev_select,
-	.phy_reset		= sata_phy_reset,
 	.bmdma_setup		= k2_bmdma_setup_mmio,
 	.bmdma_start		= k2_bmdma_start_mmio,
 	.bmdma_stop		= ata_bmdma_stop,
@@ -322,7 +329,8 @@ static const struct ata_port_operations 
 	.qc_prep		= ata_qc_prep,
 	.qc_issue		= ata_qc_issue_prot,
 	.data_xfer		= ata_mmio_data_xfer,
-	.eng_timeout		= ata_eng_timeout,
+	.error_handler		= k2_error_handler,
+	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
 	.irq_handler		= ata_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
 	.scr_read		= k2_sata_scr_read,
@@ -422,8 +430,8 @@ static int k2_sata_init_one (struct pci_
 	writel(0x0, mmio_base + K2_SATA_SIM_OFFSET);
 
 	probe_ent->sht = &k2_sata_sht;
-	probe_ent->host_flags = ATA_FLAG_SATA | ATA_FLAG_SATA_RESET |
-				ATA_FLAG_NO_LEGACY | ATA_FLAG_MMIO;
+	probe_ent->host_flags = ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
+				ATA_FLAG_MMIO;
 	probe_ent->port_ops = &k2_sata_ops;
 	probe_ent->n_ports = 4;
 	probe_ent->irq = pdev->irq;
diff --git a/drivers/scsi/sata_uli.c b/drivers/scsi/sata_uli.c
index e69ba22..48d26ce 100644
--- a/drivers/scsi/sata_uli.c
+++ b/drivers/scsi/sata_uli.c
@@ -58,6 +58,7 @@ struct uli_priv {
 };
 
 static int uli_init_one (struct pci_dev *pdev, const struct pci_device_id *ent);
+static void uli_error_handler (struct ata_port *ap);
 static u32 uli_scr_read (struct ata_port *ap, unsigned int sc_reg);
 static void uli_scr_write (struct ata_port *ap, unsigned int sc_reg, u32 val);
 
@@ -103,8 +104,6 @@ static const struct ata_port_operations 
 	.exec_command		= ata_exec_command,
 	.dev_select		= ata_std_dev_select,
 
-	.phy_reset		= sata_phy_reset,
-
 	.bmdma_setup            = ata_bmdma_setup,
 	.bmdma_start            = ata_bmdma_start,
 	.bmdma_stop		= ata_bmdma_stop,
@@ -113,7 +112,8 @@ static const struct ata_port_operations 
 	.qc_issue		= ata_qc_issue_prot,
 	.data_xfer		= ata_pio_data_xfer,
 
-	.eng_timeout		= ata_eng_timeout,
+	.error_handler		= uli_error_handler,
+	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
 
 	.irq_handler		= ata_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
@@ -128,8 +128,7 @@ static const struct ata_port_operations 
 
 static struct ata_port_info uli_port_info = {
 	.sht            = &uli_sht,
-	.host_flags     = ATA_FLAG_SATA | ATA_FLAG_SATA_RESET |
-			  ATA_FLAG_NO_LEGACY,
+	.host_flags     = ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY,
 	.pio_mask       = 0x1f,		/* pio0-4 */
 	.udma_mask      = 0x7f,		/* udma0-6 */
 	.port_ops       = &uli_ops,
@@ -182,6 +181,12 @@ static void uli_scr_write (struct ata_po
 	uli_scr_cfg_write(ap, sc_reg, val);
 }
 
+static void uli_error_handler (struct ata_port *ap)
+{
+	ata_bmdma_drive_eh(ap, ata_std_prereset, NULL, sata_std_hardreset,
+			   ata_std_postreset);
+}
+
 static int uli_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	static int printed_version;
diff --git a/drivers/scsi/sata_vsc.c b/drivers/scsi/sata_vsc.c
index 22ca7b8..5c909c2 100644
--- a/drivers/scsi/sata_vsc.c
+++ b/drivers/scsi/sata_vsc.c
@@ -264,6 +264,12 @@ static irqreturn_t vsc_sata_interrupt (i
 	return IRQ_RETVAL(handled);
 }
 
+static void vsc_error_handler(struct ata_port *ap)
+{
+	ata_bmdma_drive_eh(ap, ata_std_prereset, NULL, sata_std_hardreset,
+			   ata_std_postreset);
+}
+
 
 static struct scsi_host_template vsc_sata_sht = {
 	.module			= THIS_MODULE,
@@ -291,7 +297,6 @@ static const struct ata_port_operations 
 	.exec_command		= ata_exec_command,
 	.check_status		= ata_check_status,
 	.dev_select		= ata_std_dev_select,
-	.phy_reset		= sata_phy_reset,
 	.bmdma_setup            = ata_bmdma_setup,
 	.bmdma_start            = ata_bmdma_start,
 	.bmdma_stop		= ata_bmdma_stop,
@@ -299,7 +304,8 @@ static const struct ata_port_operations 
 	.qc_prep		= ata_qc_prep,
 	.qc_issue		= ata_qc_issue_prot,
 	.data_xfer		= ata_pio_data_xfer,
-	.eng_timeout		= ata_eng_timeout,
+	.error_handler		= vsc_error_handler,
+	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
 	.irq_handler		= vsc_sata_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
 	.scr_read		= vsc_sata_scr_read,
@@ -394,7 +400,7 @@ static int __devinit vsc_sata_init_one (
 
 	probe_ent->sht = &vsc_sata_sht;
 	probe_ent->host_flags = ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
-				ATA_FLAG_MMIO | ATA_FLAG_SATA_RESET;
+				ATA_FLAG_MMIO;
 	probe_ent->port_ops = &vsc_sata_ops;
 	probe_ent->n_ports = 4;
 	probe_ent->irq = pdev->irq;
-- 
1.3.2

