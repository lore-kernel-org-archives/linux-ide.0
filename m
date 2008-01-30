From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 4/9] libata: normalize port_info, port_operations and sht tables
Date: Wed, 30 Jan 2008 18:28:58 +0900
Message-ID: <12016853433225-git-send-email-htejun@gmail.com>
References: <12016853433196-git-send-email-htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.179]:37130 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754916AbYA3J3N (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 30 Jan 2008 04:29:13 -0500
Received: by wa-out-1112.google.com with SMTP id v27so277519wah.23
        for <linux-ide@vger.kernel.org>; Wed, 30 Jan 2008 01:29:12 -0800 (PST)
In-Reply-To: <12016853433196-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org, liml@rtr.ca, alan@lxorguk.ukuu.org.uk, kngregertsen@norway.atmel.com, sonic.adi@gmail.com, rmk@dyn-67.arm.linux.org.uk, alessandro.zummo@to
Cc: Tejun Heo <htejun@gmail.com>

Over the time, port info, ops and sht structures developed quite a bit
of inconsistencies.  This patch updates drivers.

* Enable/disable_pm callbacks added to all ahci ops tables.

* Every driver for SFF controllers now uses ata_sff_port_start()
  instead of ata_port_start() unless the driver has custom
  implementation.

* Every driver for SFF controllers now uses ata_pci_default_filter()
  unless the driver has custom implementation.

* Removed an odd port_info->sht initialization from ata_piix.c.
  Likely a merge byproduct.

* A port which has ATA_FLAG_SATA set doesn't need to set cable_detect
  to ata_cable_sata().  Remove it from vt6421_port_ops.

* Some drivers had unnecessary .max_sectors initialization which is
  ignored and was missing .slave_destroy callback.  Fixed.

* Removed unnecessary sht initializations port_info's.

* Removed onsolete scsi device suspend/resume callbacks from
  pata_bf54x.

* No reason to set ata_pci_default_filter() for PIO-only drivers.

* pata_platform sets port_start to ata_dummy_ret0.  port_start can
  just be set to NULL.

* sata_fsl supports NCQ but was missing qc_defer.  Fixed.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/ahci.c           |    4 ++++
 drivers/ata/ata_generic.c    |    1 +
 drivers/ata/ata_piix.c       |   13 +++++++------
 drivers/ata/pata_artop.c     |    1 +
 drivers/ata/pata_bf54x.c     |    5 -----
 drivers/ata/pata_cmd64x.c    |    6 +++---
 drivers/ata/pata_cs5520.c    |    1 +
 drivers/ata/pata_cs5536.c    |    2 +-
 drivers/ata/pata_hpt3x3.c    |    1 -
 drivers/ata/pata_it8213.c    |    2 +-
 drivers/ata/pata_ixp4xx_cf.c |    3 +--
 drivers/ata/pata_jmicron.c   |    3 ++-
 drivers/ata/pata_marvell.c   |    1 +
 drivers/ata/pata_mpc52xx.c   |    4 ++--
 drivers/ata/pata_netcell.c   |    1 +
 drivers/ata/pata_opti.c      |    1 +
 drivers/ata/pata_optidma.c   |    2 ++
 drivers/ata/pata_platform.c  |    4 ----
 drivers/ata/pata_rz1000.c    |    1 +
 drivers/ata/sata_fsl.c       |    1 +
 drivers/ata/sata_nv.c        |   11 ++++++++---
 drivers/ata/sata_sil.c       |    3 ++-
 drivers/ata/sata_sis.c       |    3 ++-
 drivers/ata/sata_svw.c       |    3 ++-
 drivers/ata/sata_uli.c       |    3 ++-
 drivers/ata/sata_via.c       |   12 ++++++++----
 drivers/ata/sata_vsc.c       |    3 ++-
 27 files changed, 57 insertions(+), 38 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 07dcaf6..08301ca 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -351,6 +351,8 @@ static const struct ata_port_operations ahci_vt8251_ops = {
 	.port_suspend		= ahci_port_suspend,
 	.port_resume		= ahci_port_resume,
 #endif
+	.enable_pm		= ahci_enable_alpm,
+	.disable_pm		= ahci_disable_alpm,
 
 	.port_start		= ahci_port_start,
 	.port_stop		= ahci_port_stop,
@@ -385,6 +387,8 @@ static const struct ata_port_operations ahci_p5wdh_ops = {
 	.port_suspend		= ahci_port_suspend,
 	.port_resume		= ahci_port_resume,
 #endif
+	.enable_pm		= ahci_enable_alpm,
+	.disable_pm		= ahci_disable_alpm,
 
 	.port_start		= ahci_port_start,
 	.port_stop		= ahci_port_stop,
diff --git a/drivers/ata/ata_generic.c b/drivers/ata/ata_generic.c
index 2053420..db4c3cb 100644
--- a/drivers/ata/ata_generic.c
+++ b/drivers/ata/ata_generic.c
@@ -114,6 +114,7 @@ static struct scsi_host_template generic_sht = {
 
 static struct ata_port_operations generic_port_ops = {
 	.set_mode	= generic_set_mode,
+	.mode_filter	= ata_pci_default_filter,
 
 	.tf_load	= ata_tf_load,
 	.tf_read	= ata_tf_read,
diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
index a65c8ae..129d682 100644
--- a/drivers/ata/ata_piix.c
+++ b/drivers/ata/ata_piix.c
@@ -328,7 +328,7 @@ static const struct ata_port_operations piix_pata_ops = {
 	.irq_clear		= ata_bmdma_irq_clear,
 	.irq_on			= ata_irq_on,
 
-	.port_start		= ata_port_start,
+	.port_start		= ata_sff_port_start,
 };
 
 static const struct ata_port_operations ich_pata_ops = {
@@ -359,7 +359,7 @@ static const struct ata_port_operations ich_pata_ops = {
 	.irq_clear		= ata_bmdma_irq_clear,
 	.irq_on			= ata_irq_on,
 
-	.port_start		= ata_port_start,
+	.port_start		= ata_sff_port_start,
 };
 
 static const struct ata_port_operations piix_sata_ops = {
@@ -377,6 +377,7 @@ static const struct ata_port_operations piix_sata_ops = {
 	.qc_issue		= ata_qc_issue_prot,
 	.data_xfer		= ata_data_xfer,
 
+	.mode_filter		= ata_pci_default_filter,
 	.freeze			= ata_bmdma_freeze,
 	.thaw			= ata_bmdma_thaw,
 	.error_handler		= ata_bmdma_error_handler,
@@ -385,7 +386,7 @@ static const struct ata_port_operations piix_sata_ops = {
 	.irq_clear		= ata_bmdma_irq_clear,
 	.irq_on			= ata_irq_on,
 
-	.port_start		= ata_port_start,
+	.port_start		= ata_sff_port_start,
 };
 
 static const struct ata_port_operations piix_vmw_ops = {
@@ -417,7 +418,7 @@ static const struct ata_port_operations piix_vmw_ops = {
 	.irq_clear		= ata_bmdma_irq_clear,
 	.irq_on			= ata_irq_on,
 
-	.port_start		= ata_port_start,
+	.port_start		= ata_sff_port_start,
 };
 
 static const struct ata_port_operations piix_sidpr_sata_ops = {
@@ -438,6 +439,7 @@ static const struct ata_port_operations piix_sidpr_sata_ops = {
 	.scr_read		= piix_sidpr_scr_read,
 	.scr_write		= piix_sidpr_scr_write,
 
+	.mode_filter		= ata_pci_default_filter,
 	.freeze			= ata_bmdma_freeze,
 	.thaw			= ata_bmdma_thaw,
 	.error_handler		= piix_sidpr_error_handler,
@@ -446,7 +448,7 @@ static const struct ata_port_operations piix_sidpr_sata_ops = {
 	.irq_clear		= ata_bmdma_irq_clear,
 	.irq_on			= ata_irq_on,
 
-	.port_start		= ata_port_start,
+	.port_start		= ata_sff_port_start,
 };
 
 static const struct piix_map_db ich5_map_db = {
@@ -675,7 +677,6 @@ static struct ata_port_info piix_port_info[] = {
 
 	[piix_pata_vmw] =
 	{
-		.sht		= &piix_sht,
 		.flags		= PIIX_PATA_FLAGS,
 		.pio_mask	= 0x1f,	/* pio0-4 */
 		.mwdma_mask	= 0x06, /* mwdma1-2 ?? CHECK 0 should be ok but slow */
diff --git a/drivers/ata/pata_artop.c b/drivers/ata/pata_artop.c
index 2f81480..a238c7b 100644
--- a/drivers/ata/pata_artop.c
+++ b/drivers/ata/pata_artop.c
@@ -367,6 +367,7 @@ static const struct ata_port_operations artop6210_ops = {
 static const struct ata_port_operations artop6260_ops = {
 	.set_piomode		= artop6260_set_piomode,
 	.set_dmamode		= artop6260_set_dmamode,
+	.mode_filter		= ata_pci_default_filter,
 
 	.tf_load		= ata_tf_load,
 	.tf_read		= ata_tf_read,
diff --git a/drivers/ata/pata_bf54x.c b/drivers/ata/pata_bf54x.c
index a32e3c4..0a6fa94 100644
--- a/drivers/ata/pata_bf54x.c
+++ b/drivers/ata/pata_bf54x.c
@@ -1373,10 +1373,6 @@ static struct scsi_host_template bfin_sht = {
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
-#ifdef CONFIG_PM
-	.resume			= ata_scsi_device_resume,
-	.suspend		= ata_scsi_device_suspend,
-#endif
 };
 
 static const struct ata_port_operations bfin_pata_ops = {
@@ -1414,7 +1410,6 @@ static const struct ata_port_operations bfin_pata_ops = {
 
 static struct ata_port_info bfin_port_info[] = {
 	{
-		.sht		= &bfin_sht,
 		.flags		= ATA_FLAG_SLAVE_POSS
 				| ATA_FLAG_MMIO
 				| ATA_FLAG_NO_LEGACY,
diff --git a/drivers/ata/pata_cmd64x.c b/drivers/ata/pata_cmd64x.c
index 1c9a8d9..e8c1262 100644
--- a/drivers/ata/pata_cmd64x.c
+++ b/drivers/ata/pata_cmd64x.c
@@ -313,7 +313,7 @@ static struct ata_port_operations cmd64x_port_ops = {
 	.irq_clear	= ata_bmdma_irq_clear,
 	.irq_on		= ata_irq_on,
 
-	.port_start	= ata_port_start,
+	.port_start	= ata_sff_port_start,
 };
 
 static struct ata_port_operations cmd646r1_port_ops = {
@@ -346,7 +346,7 @@ static struct ata_port_operations cmd646r1_port_ops = {
 	.irq_clear	= ata_bmdma_irq_clear,
 	.irq_on		= ata_irq_on,
 
-	.port_start	= ata_port_start,
+	.port_start	= ata_sff_port_start,
 };
 
 static struct ata_port_operations cmd648_port_ops = {
@@ -379,7 +379,7 @@ static struct ata_port_operations cmd648_port_ops = {
 	.irq_clear	= ata_bmdma_irq_clear,
 	.irq_on		= ata_irq_on,
 
-	.port_start	= ata_port_start,
+	.port_start	= ata_sff_port_start,
 };
 
 static int cmd64x_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
diff --git a/drivers/ata/pata_cs5520.c b/drivers/ata/pata_cs5520.c
index 972ed9f..5614e76 100644
--- a/drivers/ata/pata_cs5520.c
+++ b/drivers/ata/pata_cs5520.c
@@ -160,6 +160,7 @@ static struct scsi_host_template cs5520_sht = {
 static struct ata_port_operations cs5520_port_ops = {
 	.set_piomode		= cs5520_set_piomode,
 	.set_dmamode		= cs5520_set_dmamode,
+	.mode_filter		= ata_pci_default_filter,
 
 	.tf_load		= ata_tf_load,
 	.tf_read		= ata_tf_read,
diff --git a/drivers/ata/pata_cs5536.c b/drivers/ata/pata_cs5536.c
index d753e56..c59c806 100644
--- a/drivers/ata/pata_cs5536.c
+++ b/drivers/ata/pata_cs5536.c
@@ -269,7 +269,7 @@ static struct ata_port_operations cs5536_port_ops = {
 	.irq_clear		= ata_bmdma_irq_clear,
 	.irq_on			= ata_irq_on,
 
-	.port_start		= ata_port_start,
+	.port_start		= ata_sff_port_start,
 };
 
 /**
diff --git a/drivers/ata/pata_hpt3x3.c b/drivers/ata/pata_hpt3x3.c
index cb8bdb6..c09f95a 100644
--- a/drivers/ata/pata_hpt3x3.c
+++ b/drivers/ata/pata_hpt3x3.c
@@ -189,7 +189,6 @@ static int hpt3x3_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	static int printed_version;
 	static const struct ata_port_info info = {
-		.sht = &hpt3x3_sht,
 		.flags = ATA_FLAG_SLAVE_POSS,
 		.pio_mask = 0x1f,
 #if defined(CONFIG_PATA_HPT3X3_DMA)
diff --git a/drivers/ata/pata_it8213.c b/drivers/ata/pata_it8213.c
index 1eda821..60c30dc 100644
--- a/drivers/ata/pata_it8213.c
+++ b/drivers/ata/pata_it8213.c
@@ -250,13 +250,13 @@ static struct scsi_host_template it8213_sht = {
 	.can_queue		= ATA_DEF_QUEUE,
 	.this_id		= ATA_SHT_THIS_ID,
 	.sg_tablesize		= LIBATA_MAX_PRD,
-	.max_sectors		= ATA_MAX_SECTORS,
 	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
 	.emulated		= ATA_SHT_EMULATED,
 	.use_clustering		= ATA_SHT_USE_CLUSTERING,
 	.proc_name		= DRV_NAME,
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
+	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
 };
 
diff --git a/drivers/ata/pata_ixp4xx_cf.c b/drivers/ata/pata_ixp4xx_cf.c
index 83e38cc..6eb8cc9 100644
--- a/drivers/ata/pata_ixp4xx_cf.c
+++ b/drivers/ata/pata_ixp4xx_cf.c
@@ -107,7 +107,6 @@ static struct scsi_host_template ixp4xx_sht = {
 
 static struct ata_port_operations ixp4xx_port_ops = {
 	.set_mode		= ixp4xx_set_mode,
-	.mode_filter		= ata_pci_default_filter,
 
 	.tf_load		= ata_tf_load,
 	.tf_read		= ata_tf_read,
@@ -129,7 +128,7 @@ static struct ata_port_operations ixp4xx_port_ops = {
 	.irq_clear		= ata_noop_irq_clear,
 	.irq_on			= ata_irq_on,
 
-	.port_start		= ata_port_start,
+	.port_start		= ata_sff_port_start,
 };
 
 static void ixp4xx_setup_port(struct ata_port *ap,
diff --git a/drivers/ata/pata_jmicron.c b/drivers/ata/pata_jmicron.c
index 5b8174d..4d25c45 100644
--- a/drivers/ata/pata_jmicron.c
+++ b/drivers/ata/pata_jmicron.c
@@ -147,6 +147,7 @@ static const struct ata_port_operations jmicron_ops = {
 	.exec_command		= ata_exec_command,
 	.dev_select		= ata_std_dev_select,
 
+	.mode_filter		= ata_pci_default_filter,
 	.freeze			= ata_bmdma_freeze,
 	.thaw			= ata_bmdma_thaw,
 	.error_handler		= jmicron_error_handler,
@@ -167,7 +168,7 @@ static const struct ata_port_operations jmicron_ops = {
 	.irq_on			= ata_irq_on,
 
 	/* Generic PATA PCI ATA helpers */
-	.port_start		= ata_port_start,
+	.port_start		= ata_sff_port_start,
 };
 
 
diff --git a/drivers/ata/pata_marvell.c b/drivers/ata/pata_marvell.c
index 9afc8a3..113be4f 100644
--- a/drivers/ata/pata_marvell.c
+++ b/drivers/ata/pata_marvell.c
@@ -118,6 +118,7 @@ static const struct ata_port_operations marvell_ops = {
 	.exec_command		= ata_exec_command,
 	.dev_select		= ata_std_dev_select,
 
+	.mode_filter		= ata_pci_default_filter,
 	.freeze			= ata_bmdma_freeze,
 	.thaw			= ata_bmdma_thaw,
 	.error_handler		= marvell_error_handler,
diff --git a/drivers/ata/pata_mpc52xx.c b/drivers/ata/pata_mpc52xx.c
index bc5259e..9383efb 100644
--- a/drivers/ata/pata_mpc52xx.c
+++ b/drivers/ata/pata_mpc52xx.c
@@ -272,13 +272,13 @@ static struct scsi_host_template mpc52xx_ata_sht = {
 	.can_queue		= ATA_DEF_QUEUE,
 	.this_id		= ATA_SHT_THIS_ID,
 	.sg_tablesize		= LIBATA_MAX_PRD,
-	.max_sectors		= ATA_MAX_SECTORS,
 	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
 	.emulated		= ATA_SHT_EMULATED,
 	.use_clustering		= ATA_SHT_USE_CLUSTERING,
 	.proc_name		= DRV_NAME,
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
+	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
 };
 
@@ -298,7 +298,7 @@ static struct ata_port_operations mpc52xx_ata_port_ops = {
 	.data_xfer		= ata_data_xfer,
 	.irq_clear		= ata_noop_irq_clear,
 	.irq_on			= ata_irq_on,
-	.port_start		= ata_port_start,
+	.port_start		= ata_sff_port_start,
 };
 
 static int __devinit
diff --git a/drivers/ata/pata_netcell.c b/drivers/ata/pata_netcell.c
index 0e4a08e..9fd1a84 100644
--- a/drivers/ata/pata_netcell.c
+++ b/drivers/ata/pata_netcell.c
@@ -47,6 +47,7 @@ static const struct ata_port_operations netcell_ops = {
 	.exec_command		= ata_exec_command,
 	.dev_select		= ata_std_dev_select,
 
+	.mode_filter		= ata_pci_default_filter,
 	.freeze			= ata_bmdma_freeze,
 	.thaw			= ata_bmdma_thaw,
 	.error_handler		= ata_bmdma_error_handler,
diff --git a/drivers/ata/pata_opti.c b/drivers/ata/pata_opti.c
index 8f79447..ebb9dc1 100644
--- a/drivers/ata/pata_opti.c
+++ b/drivers/ata/pata_opti.c
@@ -184,6 +184,7 @@ static struct scsi_host_template opti_sht = {
 
 static struct ata_port_operations opti_port_ops = {
 	.set_piomode	= opti_set_piomode,
+	.mode_filter	= ata_pci_default_filter,
 	.tf_load	= ata_tf_load,
 	.tf_read	= ata_tf_read,
 	.check_status 	= ata_check_status,
diff --git a/drivers/ata/pata_optidma.c b/drivers/ata/pata_optidma.c
index be8c421..3f9d035 100644
--- a/drivers/ata/pata_optidma.c
+++ b/drivers/ata/pata_optidma.c
@@ -370,6 +370,7 @@ static struct scsi_host_template optidma_sht = {
 static struct ata_port_operations optidma_port_ops = {
 	.set_piomode	= optidma_set_pio_mode,
 	.set_dmamode	= optidma_set_dma_mode,
+	.mode_filter	= ata_pci_default_filter,
 
 	.tf_load	= ata_tf_load,
 	.tf_read	= ata_tf_read,
@@ -404,6 +405,7 @@ static struct ata_port_operations optidma_port_ops = {
 static struct ata_port_operations optiplus_port_ops = {
 	.set_piomode	= optiplus_set_pio_mode,
 	.set_dmamode	= optiplus_set_dma_mode,
+	.mode_filter	= ata_pci_default_filter,
 
 	.tf_load	= ata_tf_load,
 	.tf_read	= ata_tf_read,
diff --git a/drivers/ata/pata_platform.c b/drivers/ata/pata_platform.c
index 07b024a..d2edcbf 100644
--- a/drivers/ata/pata_platform.c
+++ b/drivers/ata/pata_platform.c
@@ -46,8 +46,6 @@ static int pata_platform_set_mode(struct ata_link *link, struct ata_device **unu
 	return 0;
 }
 
-static int ata_dummy_ret0(struct ata_port *ap)	{ return 0; }
-
 static struct scsi_host_template pata_platform_sht = {
 	.module			= THIS_MODULE,
 	.name			= DRV_NAME,
@@ -88,8 +86,6 @@ static struct ata_port_operations pata_platform_port_ops = {
 
 	.irq_clear		= ata_noop_irq_clear,
 	.irq_on			= ata_irq_on,
-
-	.port_start		= ata_dummy_ret0,
 };
 
 static void pata_platform_setup_port(struct ata_ioports *ioaddr,
diff --git a/drivers/ata/pata_rz1000.c b/drivers/ata/pata_rz1000.c
index ba8a31c..d922698 100644
--- a/drivers/ata/pata_rz1000.c
+++ b/drivers/ata/pata_rz1000.c
@@ -72,6 +72,7 @@ static struct scsi_host_template rz1000_sht = {
 
 static struct ata_port_operations rz1000_port_ops = {
 	.set_mode	= rz1000_set_mode,
+	.mode_filter	= ata_pci_default_filter,
 
 	.tf_load	= ata_tf_load,
 	.tf_read	= ata_tf_read,
diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c
index e798c4c..7778fd3 100644
--- a/drivers/ata/sata_fsl.c
+++ b/drivers/ata/sata_fsl.c
@@ -1227,6 +1227,7 @@ static const struct ata_port_operations sata_fsl_ops = {
 
 	.tf_read = sata_fsl_tf_read,
 
+	.qc_defer = ata_std_qc_defer,
 	.qc_prep = sata_fsl_qc_prep,
 	.qc_issue = sata_fsl_qc_issue,
 	.irq_clear = ata_noop_irq_clear,
diff --git a/drivers/ata/sata_nv.c b/drivers/ata/sata_nv.c
index e1d05a2..8eb588e 100644
--- a/drivers/ata/sata_nv.c
+++ b/drivers/ata/sata_nv.c
@@ -451,6 +451,7 @@ static const struct ata_port_operations nv_generic_ops = {
 	.bmdma_status		= ata_bmdma_status,
 	.qc_prep		= ata_qc_prep,
 	.qc_issue		= ata_qc_issue_prot,
+	.mode_filter		= ata_pci_default_filter,
 	.freeze			= ata_bmdma_freeze,
 	.thaw			= ata_bmdma_thaw,
 	.error_handler		= nv_error_handler,
@@ -460,7 +461,7 @@ static const struct ata_port_operations nv_generic_ops = {
 	.irq_on			= ata_irq_on,
 	.scr_read		= nv_scr_read,
 	.scr_write		= nv_scr_write,
-	.port_start		= ata_port_start,
+	.port_start		= ata_sff_port_start,
 };
 
 static const struct ata_port_operations nv_nf2_ops = {
@@ -475,6 +476,7 @@ static const struct ata_port_operations nv_nf2_ops = {
 	.bmdma_status		= ata_bmdma_status,
 	.qc_prep		= ata_qc_prep,
 	.qc_issue		= ata_qc_issue_prot,
+	.mode_filter		= ata_pci_default_filter,
 	.freeze			= nv_nf2_freeze,
 	.thaw			= nv_nf2_thaw,
 	.error_handler		= nv_error_handler,
@@ -484,7 +486,7 @@ static const struct ata_port_operations nv_nf2_ops = {
 	.irq_on			= ata_irq_on,
 	.scr_read		= nv_scr_read,
 	.scr_write		= nv_scr_write,
-	.port_start		= ata_port_start,
+	.port_start		= ata_sff_port_start,
 };
 
 static const struct ata_port_operations nv_ck804_ops = {
@@ -499,6 +501,7 @@ static const struct ata_port_operations nv_ck804_ops = {
 	.bmdma_status		= ata_bmdma_status,
 	.qc_prep		= ata_qc_prep,
 	.qc_issue		= ata_qc_issue_prot,
+	.mode_filter		= ata_pci_default_filter,
 	.freeze			= nv_ck804_freeze,
 	.thaw			= nv_ck804_thaw,
 	.error_handler		= nv_error_handler,
@@ -508,7 +511,7 @@ static const struct ata_port_operations nv_ck804_ops = {
 	.irq_on			= ata_irq_on,
 	.scr_read		= nv_scr_read,
 	.scr_write		= nv_scr_write,
-	.port_start		= ata_port_start,
+	.port_start		= ata_sff_port_start,
 	.host_stop		= nv_ck804_host_stop,
 };
 
@@ -526,6 +529,7 @@ static const struct ata_port_operations nv_adma_ops = {
 	.qc_defer		= ata_std_qc_defer,
 	.qc_prep		= nv_adma_qc_prep,
 	.qc_issue		= nv_adma_qc_issue,
+	.mode_filter		= ata_pci_default_filter,
 	.freeze			= nv_adma_freeze,
 	.thaw			= nv_adma_thaw,
 	.error_handler		= nv_adma_error_handler,
@@ -557,6 +561,7 @@ static const struct ata_port_operations nv_swncq_ops = {
 	.qc_defer		= ata_std_qc_defer,
 	.qc_prep		= nv_swncq_qc_prep,
 	.qc_issue		= nv_swncq_qc_issue,
+	.mode_filter		= ata_pci_default_filter,
 	.freeze			= nv_mcp55_freeze,
 	.thaw			= nv_mcp55_thaw,
 	.error_handler		= nv_swncq_error_handler,
diff --git a/drivers/ata/sata_sil.c b/drivers/ata/sata_sil.c
index 7052915..53f0bae 100644
--- a/drivers/ata/sata_sil.c
+++ b/drivers/ata/sata_sil.c
@@ -192,6 +192,7 @@ static const struct ata_port_operations sil_ops = {
 	.exec_command		= ata_exec_command,
 	.dev_select		= ata_std_dev_select,
 	.set_mode		= sil_set_mode,
+	.mode_filter		= ata_pci_default_filter,
 	.bmdma_setup            = ata_bmdma_setup,
 	.bmdma_start            = ata_bmdma_start,
 	.bmdma_stop		= ata_bmdma_stop,
@@ -207,7 +208,7 @@ static const struct ata_port_operations sil_ops = {
 	.irq_on			= ata_irq_on,
 	.scr_read		= sil_scr_read,
 	.scr_write		= sil_scr_write,
-	.port_start		= ata_port_start,
+	.port_start		= ata_sff_port_start,
 };
 
 static const struct ata_port_info sil_port_info[] = {
diff --git a/drivers/ata/sata_sis.c b/drivers/ata/sata_sis.c
index a01260a..a8adef9 100644
--- a/drivers/ata/sata_sis.c
+++ b/drivers/ata/sata_sis.c
@@ -116,6 +116,7 @@ static const struct ata_port_operations sis_ops = {
 	.qc_prep		= ata_qc_prep,
 	.qc_issue		= ata_qc_issue_prot,
 	.data_xfer		= ata_data_xfer,
+	.mode_filter		= ata_pci_default_filter,
 	.freeze			= ata_bmdma_freeze,
 	.thaw			= ata_bmdma_thaw,
 	.error_handler		= ata_bmdma_error_handler,
@@ -124,7 +125,7 @@ static const struct ata_port_operations sis_ops = {
 	.irq_on			= ata_irq_on,
 	.scr_read		= sis_scr_read,
 	.scr_write		= sis_scr_write,
-	.port_start		= ata_port_start,
+	.port_start		= ata_sff_port_start,
 };
 
 static const struct ata_port_info sis_port_info = {
diff --git a/drivers/ata/sata_svw.c b/drivers/ata/sata_svw.c
index 69f651e..302854c 100644
--- a/drivers/ata/sata_svw.c
+++ b/drivers/ata/sata_svw.c
@@ -342,6 +342,7 @@ static const struct ata_port_operations k2_sata_ops = {
 	.qc_prep		= ata_qc_prep,
 	.qc_issue		= ata_qc_issue_prot,
 	.data_xfer		= ata_data_xfer,
+	.mode_filter		= ata_pci_default_filter,
 	.freeze			= ata_bmdma_freeze,
 	.thaw			= ata_bmdma_thaw,
 	.error_handler		= ata_bmdma_error_handler,
@@ -350,7 +351,7 @@ static const struct ata_port_operations k2_sata_ops = {
 	.irq_on			= ata_irq_on,
 	.scr_read		= k2_sata_scr_read,
 	.scr_write		= k2_sata_scr_write,
-	.port_start		= ata_port_start,
+	.port_start		= ata_sff_port_start,
 };
 
 static const struct ata_port_info k2_port_info[] = {
diff --git a/drivers/ata/sata_uli.c b/drivers/ata/sata_uli.c
index e710e71..f7fc045 100644
--- a/drivers/ata/sata_uli.c
+++ b/drivers/ata/sata_uli.c
@@ -108,6 +108,7 @@ static const struct ata_port_operations uli_ops = {
 	.qc_issue		= ata_qc_issue_prot,
 	.data_xfer		= ata_data_xfer,
 
+	.mode_filter		= ata_pci_default_filter,
 	.freeze			= ata_bmdma_freeze,
 	.thaw			= ata_bmdma_thaw,
 	.error_handler		= ata_bmdma_error_handler,
@@ -119,7 +120,7 @@ static const struct ata_port_operations uli_ops = {
 	.scr_read		= uli_scr_read,
 	.scr_write		= uli_scr_write,
 
-	.port_start		= ata_port_start,
+	.port_start		= ata_sff_port_start,
 };
 
 static const struct ata_port_info uli_port_info = {
diff --git a/drivers/ata/sata_via.c b/drivers/ata/sata_via.c
index f16f8f7..8d64a3d 100644
--- a/drivers/ata/sata_via.c
+++ b/drivers/ata/sata_via.c
@@ -120,6 +120,8 @@ static struct scsi_host_template svia_sht = {
 };
 
 static const struct ata_port_operations vt6420_sata_ops = {
+	.mode_filter		= ata_pci_default_filter,
+
 	.tf_load		= ata_tf_load,
 	.tf_read		= ata_tf_read,
 	.check_status		= ata_check_status,
@@ -143,12 +145,13 @@ static const struct ata_port_operations vt6420_sata_ops = {
 	.irq_clear		= ata_bmdma_irq_clear,
 	.irq_on			= ata_irq_on,
 
-	.port_start		= ata_port_start,
+	.port_start		= ata_sff_port_start,
 };
 
 static const struct ata_port_operations vt6421_pata_ops = {
 	.set_piomode		= vt6421_set_pio_mode,
 	.set_dmamode		= vt6421_set_dma_mode,
+	.mode_filter		= ata_pci_default_filter,
 
 	.tf_load		= ata_tf_load,
 	.tf_read		= ata_tf_read,
@@ -174,10 +177,12 @@ static const struct ata_port_operations vt6421_pata_ops = {
 	.irq_clear		= ata_bmdma_irq_clear,
 	.irq_on			= ata_irq_on,
 
-	.port_start		= ata_port_start,
+	.port_start		= ata_sff_port_start,
 };
 
 static const struct ata_port_operations vt6421_sata_ops = {
+	.mode_filter		= ata_pci_default_filter,
+
 	.tf_load		= ata_tf_load,
 	.tf_read		= ata_tf_read,
 	.check_status		= ata_check_status,
@@ -197,7 +202,6 @@ static const struct ata_port_operations vt6421_sata_ops = {
 	.thaw			= ata_bmdma_thaw,
 	.error_handler		= ata_bmdma_error_handler,
 	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
-	.cable_detect		= ata_cable_sata,
 
 	.irq_clear		= ata_bmdma_irq_clear,
 	.irq_on			= ata_irq_on,
@@ -205,7 +209,7 @@ static const struct ata_port_operations vt6421_sata_ops = {
 	.scr_read		= svia_scr_read,
 	.scr_write		= svia_scr_write,
 
-	.port_start		= ata_port_start,
+	.port_start		= ata_sff_port_start,
 };
 
 static const struct ata_port_info vt6420_port_info = {
diff --git a/drivers/ata/sata_vsc.c b/drivers/ata/sata_vsc.c
index 95ae3ed..099a2ba 100644
--- a/drivers/ata/sata_vsc.c
+++ b/drivers/ata/sata_vsc.c
@@ -331,6 +331,7 @@ static const struct ata_port_operations vsc_sata_ops = {
 	.qc_prep		= ata_qc_prep,
 	.qc_issue		= ata_qc_issue_prot,
 	.data_xfer		= ata_data_xfer,
+	.mode_filter		= ata_pci_default_filter,
 	.freeze			= vsc_freeze,
 	.thaw			= vsc_thaw,
 	.error_handler		= ata_bmdma_error_handler,
@@ -339,7 +340,7 @@ static const struct ata_port_operations vsc_sata_ops = {
 	.irq_on			= ata_irq_on,
 	.scr_read		= vsc_sata_scr_read,
 	.scr_write		= vsc_sata_scr_write,
-	.port_start		= ata_port_start,
+	.port_start		= ata_sff_port_start,
 };
 
 static void __devinit vsc_sata_setup_port(struct ata_ioports *port,
-- 
1.5.2.4

