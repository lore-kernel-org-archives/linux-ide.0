From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] libata: convert several bmdma-style controllers to new EH, take #3
Date: Fri, 16 Jun 2006 15:00:18 +0900
Message-ID: <20060616060018.GC10142@htj.dyndns.org>
References: <20060613115131.GA17964@htj.dyndns.org> <20060613214313.GA10142@htj.dyndns.org> <448F5BD2.6060905@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.206]:7976 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750914AbWFPGA0 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 16 Jun 2006 02:00:26 -0400
Received: by nz-out-0102.google.com with SMTP id s18so741221nze
        for <linux-ide@vger.kernel.org>; Thu, 15 Jun 2006 23:00:25 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <448F5BD2.6060905@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

Convert sata_sis, svw, uli and vsc drivers to new EH.  All the drivers
used to specify ATA_FLAG_SATA_RESET to tell libata to use SATA
hardreset instead of SRST.  This patch makes all the converted drivers
use the standard bmdma error handler which uses both SRST and SATA
hardreset.

All the controllers should be able to perform SRST but still needs
verification.  If some of the controllers can't do SRST, it will be
very easy to spot as it will show up during boot probing.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/sata_sis.c |    9 +++++----
 drivers/scsi/sata_svw.c |   10 ++++++----
 drivers/scsi/sata_uli.c |   10 +++++-----
 drivers/scsi/sata_vsc.c |    8 +++++---
 4 files changed, 21 insertions(+), 16 deletions(-)

eb59dcb94d562917d22ec0c3a820ae6ae9f22910
diff --git a/drivers/scsi/sata_sis.c b/drivers/scsi/sata_sis.c
index a07e6e5..809d337 100644
--- a/drivers/scsi/sata_sis.c
+++ b/drivers/scsi/sata_sis.c
@@ -107,7 +107,6 @@ static const struct ata_port_operations 
 	.check_status		= ata_check_status,
 	.exec_command		= ata_exec_command,
 	.dev_select		= ata_std_dev_select,
-	.phy_reset		= sata_phy_reset,
 	.bmdma_setup            = ata_bmdma_setup,
 	.bmdma_start            = ata_bmdma_start,
 	.bmdma_stop		= ata_bmdma_stop,
@@ -115,7 +114,10 @@ static const struct ata_port_operations 
 	.qc_prep		= ata_qc_prep,
 	.qc_issue		= ata_qc_issue_prot,
 	.data_xfer		= ata_pio_data_xfer,
-	.eng_timeout		= ata_eng_timeout,
+	.freeze			= ata_bmdma_freeze,
+	.thaw			= ata_bmdma_thaw,
+	.error_handler		= ata_bmdma_error_handler,
+	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
 	.irq_handler		= ata_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
 	.scr_read		= sis_scr_read,
@@ -127,8 +129,7 @@ static const struct ata_port_operations 
 
 static struct ata_port_info sis_port_info = {
 	.sht		= &sis_sht,
-	.host_flags	= ATA_FLAG_SATA | ATA_FLAG_SATA_RESET |
-			  ATA_FLAG_NO_LEGACY,
+	.host_flags	= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY,
 	.pio_mask	= 0x1f,
 	.mwdma_mask	= 0x7,
 	.udma_mask	= 0x7f,
diff --git a/drivers/scsi/sata_svw.c b/drivers/scsi/sata_svw.c
index d9b5168..c94b870 100644
--- a/drivers/scsi/sata_svw.c
+++ b/drivers/scsi/sata_svw.c
@@ -314,7 +314,6 @@ static const struct ata_port_operations 
 	.check_status		= k2_stat_check_status,
 	.exec_command		= ata_exec_command,
 	.dev_select		= ata_std_dev_select,
-	.phy_reset		= sata_phy_reset,
 	.bmdma_setup		= k2_bmdma_setup_mmio,
 	.bmdma_start		= k2_bmdma_start_mmio,
 	.bmdma_stop		= ata_bmdma_stop,
@@ -322,7 +321,10 @@ static const struct ata_port_operations 
 	.qc_prep		= ata_qc_prep,
 	.qc_issue		= ata_qc_issue_prot,
 	.data_xfer		= ata_mmio_data_xfer,
-	.eng_timeout		= ata_eng_timeout,
+	.freeze			= ata_bmdma_freeze,
+	.thaw			= ata_bmdma_thaw,
+	.error_handler		= ata_bmdma_error_handler,
+	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
 	.irq_handler		= ata_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
 	.scr_read		= k2_sata_scr_read,
@@ -422,8 +424,8 @@ static int k2_sata_init_one (struct pci_
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
index e69ba22..f668c99 100644
--- a/drivers/scsi/sata_uli.c
+++ b/drivers/scsi/sata_uli.c
@@ -103,8 +103,6 @@ static const struct ata_port_operations 
 	.exec_command		= ata_exec_command,
 	.dev_select		= ata_std_dev_select,
 
-	.phy_reset		= sata_phy_reset,
-
 	.bmdma_setup            = ata_bmdma_setup,
 	.bmdma_start            = ata_bmdma_start,
 	.bmdma_stop		= ata_bmdma_stop,
@@ -113,7 +111,10 @@ static const struct ata_port_operations 
 	.qc_issue		= ata_qc_issue_prot,
 	.data_xfer		= ata_pio_data_xfer,
 
-	.eng_timeout		= ata_eng_timeout,
+	.freeze			= ata_bmdma_freeze,
+	.thaw			= ata_bmdma_thaw,
+	.error_handler		= ata_bmdma_error_handler,
+	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
 
 	.irq_handler		= ata_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
@@ -128,8 +129,7 @@ static const struct ata_port_operations 
 
 static struct ata_port_info uli_port_info = {
 	.sht            = &uli_sht,
-	.host_flags     = ATA_FLAG_SATA | ATA_FLAG_SATA_RESET |
-			  ATA_FLAG_NO_LEGACY,
+	.host_flags     = ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY,
 	.pio_mask       = 0x1f,		/* pio0-4 */
 	.udma_mask      = 0x7f,		/* udma0-6 */
 	.port_ops       = &uli_ops,
diff --git a/drivers/scsi/sata_vsc.c b/drivers/scsi/sata_vsc.c
index 22ca7b8..d92e3dd 100644
--- a/drivers/scsi/sata_vsc.c
+++ b/drivers/scsi/sata_vsc.c
@@ -291,7 +291,6 @@ static const struct ata_port_operations 
 	.exec_command		= ata_exec_command,
 	.check_status		= ata_check_status,
 	.dev_select		= ata_std_dev_select,
-	.phy_reset		= sata_phy_reset,
 	.bmdma_setup            = ata_bmdma_setup,
 	.bmdma_start            = ata_bmdma_start,
 	.bmdma_stop		= ata_bmdma_stop,
@@ -299,7 +298,10 @@ static const struct ata_port_operations 
 	.qc_prep		= ata_qc_prep,
 	.qc_issue		= ata_qc_issue_prot,
 	.data_xfer		= ata_pio_data_xfer,
-	.eng_timeout		= ata_eng_timeout,
+	.freeze			= ata_bmdma_freeze,
+	.thaw			= ata_bmdma_thaw,
+	.error_handler		= ata_bmdma_error_handler,
+	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
 	.irq_handler		= vsc_sata_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
 	.scr_read		= vsc_sata_scr_read,
@@ -394,7 +396,7 @@ static int __devinit vsc_sata_init_one (
 
 	probe_ent->sht = &vsc_sata_sht;
 	probe_ent->host_flags = ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
-				ATA_FLAG_MMIO | ATA_FLAG_SATA_RESET;
+				ATA_FLAG_MMIO;
 	probe_ent->port_ops = &vsc_sata_ops;
 	probe_ent->n_ports = 4;
 	probe_ent->irq = pdev->irq;
-- 
1.3.2

