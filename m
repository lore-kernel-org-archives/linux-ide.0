From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 3/9] libata: normalize port_info, port_operations and sht tables
Date: Tue, 11 Mar 2008 21:05:59 +0900
Message-ID: <12052371672468-git-send-email-htejun@gmail.com>
References: <12052371651181-git-send-email-htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.178]:45118 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753390AbYCKMGS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 11 Mar 2008 08:06:18 -0400
Received: by wa-out-1112.google.com with SMTP id v27so2814323wah.23
        for <linux-ide@vger.kernel.org>; Tue, 11 Mar 2008 05:06:16 -0700 (PDT)
In-Reply-To: <12052371651181-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org, liml@rtr.ca, alan@lxorguk.ukuu.org.uk, kngregertsen@norway.atmel.com, sonic.adi@gmail.com, rmk@arm.linux.org.uk, alessandro.zummo@towertech
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
  to ata_cable_sata().  Remove it from via and mv port ops.

* Some drivers had unnecessary .max_sectors initialization which is
  ignored and was missing .slave_destroy callback.  Fixed.

* Removed unnecessary sht initializations port_info's.

* Removed onsolete scsi device suspend/resume callbacks from
  pata_bf54x.

* No reason to set ata_pci_default_filter() and bmdma functions for
  PIO-only drivers.  Remove those callbacks and replace
  ata_bmdma_irq_clear with ata_noop_irq_clear.

* pata_platform sets port_start to ata_dummy_ret0.  port_start can
  just be set to NULL.

* sata_fsl supports NCQ but was missing qc_defer.  Fixed.

* pata_rb600_cf implements dummy port_start.  Removed.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/ahci.c           |    8 ++++++++
 drivers/ata/ata_generic.c    |    1 +
 drivers/ata/ata_piix.c       |   13 +++++++------
 drivers/ata/pata_artop.c     |    1 +
 drivers/ata/pata_bf54x.c     |    1 -
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
 drivers/ata/pata_opti.c      |    7 +------
 drivers/ata/pata_optidma.c   |    2 ++
 drivers/ata/pata_platform.c  |    4 ----
 drivers/ata/pata_rb500_cf.c  |    9 +--------
 drivers/ata/pata_rz1000.c    |    7 +------
 drivers/ata/sata_fsl.c       |    1 +
 drivers/ata/sata_mv.c        |    6 ------
 drivers/ata/sata_nv.c        |   11 ++++++++---
 drivers/ata/sata_sil.c       |    3 ++-
 drivers/ata/sata_sis.c       |    3 ++-
 drivers/ata/sata_svw.c       |    3 ++-
 drivers/ata/sata_uli.c       |    3 ++-
 drivers/ata/sata_via.c       |   12 ++++++++----
 drivers/ata/sata_vsc.c       |    3 ++-
 29 files changed, 62 insertions(+), 60 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 5696f46..16a21b8 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -332,6 +332,8 @@ static const struct ata_port_operations ahci_vt8251_ops = {
 	.check_altstatus	= ahci_check_status,
 	.dev_select		= ata_noop_dev_select,
 
+	.dev_config		= ahci_dev_config,
+
 	.tf_read		= ahci_tf_read,
 
 	.qc_defer		= sata_pmp_qc_defer_cmd_switch,
@@ -356,6 +358,8 @@ static const struct ata_port_operations ahci_vt8251_ops = {
 	.port_suspend		= ahci_port_suspend,
 	.port_resume		= ahci_port_resume,
 #endif
+	.enable_pm		= ahci_enable_alpm,
+	.disable_pm		= ahci_disable_alpm,
 
 	.port_start		= ahci_port_start,
 	.port_stop		= ahci_port_stop,
@@ -366,6 +370,8 @@ static const struct ata_port_operations ahci_p5wdh_ops = {
 	.check_altstatus	= ahci_check_status,
 	.dev_select		= ata_noop_dev_select,
 
+	.dev_config		= ahci_dev_config,
+
 	.tf_read		= ahci_tf_read,
 
 	.qc_defer		= sata_pmp_qc_defer_cmd_switch,
@@ -390,6 +396,8 @@ static const struct ata_port_operations ahci_p5wdh_ops = {
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
index fae8404..067760a 100644
--- a/drivers/ata/ata_piix.c
+++ b/drivers/ata/ata_piix.c
@@ -336,7 +336,7 @@ static const struct ata_port_operations piix_pata_ops = {
 	.irq_clear		= ata_bmdma_irq_clear,
 	.irq_on			= ata_irq_on,
 
-	.port_start		= ata_port_start,
+	.port_start		= ata_sff_port_start,
 };
 
 static const struct ata_port_operations ich_pata_ops = {
@@ -367,7 +367,7 @@ static const struct ata_port_operations ich_pata_ops = {
 	.irq_clear		= ata_bmdma_irq_clear,
 	.irq_on			= ata_irq_on,
 
-	.port_start		= ata_port_start,
+	.port_start		= ata_sff_port_start,
 };
 
 static const struct ata_port_operations piix_sata_ops = {
@@ -385,6 +385,7 @@ static const struct ata_port_operations piix_sata_ops = {
 	.qc_issue		= ata_qc_issue_prot,
 	.data_xfer		= ata_data_xfer,
 
+	.mode_filter		= ata_pci_default_filter,
 	.freeze			= ata_bmdma_freeze,
 	.thaw			= ata_bmdma_thaw,
 	.error_handler		= ata_bmdma_error_handler,
@@ -393,7 +394,7 @@ static const struct ata_port_operations piix_sata_ops = {
 	.irq_clear		= ata_bmdma_irq_clear,
 	.irq_on			= ata_irq_on,
 
-	.port_start		= ata_port_start,
+	.port_start		= ata_sff_port_start,
 };
 
 static const struct ata_port_operations piix_vmw_ops = {
@@ -425,7 +426,7 @@ static const struct ata_port_operations piix_vmw_ops = {
 	.irq_clear		= ata_bmdma_irq_clear,
 	.irq_on			= ata_irq_on,
 
-	.port_start		= ata_port_start,
+	.port_start		= ata_sff_port_start,
 };
 
 static const struct ata_port_operations piix_sidpr_sata_ops = {
@@ -446,6 +447,7 @@ static const struct ata_port_operations piix_sidpr_sata_ops = {
 	.scr_read		= piix_sidpr_scr_read,
 	.scr_write		= piix_sidpr_scr_write,
 
+	.mode_filter		= ata_pci_default_filter,
 	.freeze			= ata_bmdma_freeze,
 	.thaw			= ata_bmdma_thaw,
 	.error_handler		= piix_sidpr_error_handler,
@@ -454,7 +456,7 @@ static const struct ata_port_operations piix_sidpr_sata_ops = {
 	.irq_clear		= ata_bmdma_irq_clear,
 	.irq_on			= ata_irq_on,
 
-	.port_start		= ata_port_start,
+	.port_start		= ata_sff_port_start,
 };
 
 static const struct piix_map_db ich5_map_db = {
@@ -683,7 +685,6 @@ static struct ata_port_info piix_port_info[] = {
 
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
index 7f87f10..146c202 100644
--- a/drivers/ata/pata_bf54x.c
+++ b/drivers/ata/pata_bf54x.c
@@ -1409,7 +1409,6 @@ static const struct ata_port_operations bfin_pata_ops = {
 
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
index dd6b235..44ad2c9 100644
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
index 1c4ff9b..391aa88 100644
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
index e0c2cc2..25c49c2 100644
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
index 00bbbbd..7d36fa8 100644
--- a/drivers/ata/pata_jmicron.c
+++ b/drivers/ata/pata_jmicron.c
@@ -148,6 +148,7 @@ static const struct ata_port_operations jmicron_ops = {
 	.exec_command		= ata_exec_command,
 	.dev_select		= ata_std_dev_select,
 
+	.mode_filter		= ata_pci_default_filter,
 	.freeze			= ata_bmdma_freeze,
 	.thaw			= ata_bmdma_thaw,
 	.error_handler		= jmicron_error_handler,
@@ -168,7 +169,7 @@ static const struct ata_port_operations jmicron_ops = {
 	.irq_on			= ata_irq_on,
 
 	/* Generic PATA PCI ATA helpers */
-	.port_start		= ata_port_start,
+	.port_start		= ata_sff_port_start,
 };
 
 
diff --git a/drivers/ata/pata_marvell.c b/drivers/ata/pata_marvell.c
index a81f25d..c4ee9b4 100644
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
index d84e0c8..fefe71d 100644
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
index 8f79447..1e865f1 100644
--- a/drivers/ata/pata_opti.c
+++ b/drivers/ata/pata_opti.c
@@ -196,18 +196,13 @@ static struct ata_port_operations opti_port_ops = {
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
 	.cable_detect	= ata_cable_40wire,
 
-	.bmdma_setup 	= ata_bmdma_setup,
-	.bmdma_start 	= ata_bmdma_start,
-	.bmdma_stop	= ata_bmdma_stop,
-	.bmdma_status 	= ata_bmdma_status,
-
 	.qc_prep 	= ata_qc_prep,
 	.qc_issue	= ata_qc_issue_prot,
 
 	.data_xfer	= ata_data_xfer,
 
 	.irq_handler	= ata_interrupt,
-	.irq_clear	= ata_bmdma_irq_clear,
+	.irq_clear	= ata_noop_irq_clear,
 	.irq_on		= ata_irq_on,
 
 	.port_start	= ata_sff_port_start,
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
index a8429f5..602f556 100644
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
diff --git a/drivers/ata/pata_rb500_cf.c b/drivers/ata/pata_rb500_cf.c
index 08c32af..22cb9e1 100644
--- a/drivers/ata/pata_rb500_cf.c
+++ b/drivers/ata/pata_rb500_cf.c
@@ -117,11 +117,6 @@ static irqreturn_t rb500_pata_irq_handler(int irq, void *dev_instance)
 	return IRQ_HANDLED;
 }
 
-static int rb500_pata_port_start(struct ata_port *ap)
-{
-	return 0;
-}
-
 static struct ata_port_operations rb500_pata_port_ops = {
 	.tf_load		= ata_tf_load,
 	.tf_read		= ata_tf_read,
@@ -138,12 +133,10 @@ static struct ata_port_operations rb500_pata_port_ops = {
 	.freeze			= rb500_pata_freeze,
 	.thaw			= rb500_pata_thaw,
 	.error_handler		= ata_bmdma_error_handler,
+	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
 
-	.irq_handler		= rb500_pata_irq_handler,
 	.irq_clear		= ata_noop_irq_clear,
 	.irq_on			= ata_irq_on,
-
-	.port_start		= rb500_pata_port_start,
 };
 
 /* ------------------------------------------------------------------------ */
diff --git a/drivers/ata/pata_rz1000.c b/drivers/ata/pata_rz1000.c
index ba8a31c..75b2521 100644
--- a/drivers/ata/pata_rz1000.c
+++ b/drivers/ata/pata_rz1000.c
@@ -79,11 +79,6 @@ static struct ata_port_operations rz1000_port_ops = {
 	.exec_command	= ata_exec_command,
 	.dev_select 	= ata_std_dev_select,
 
-	.bmdma_setup 	= ata_bmdma_setup,
-	.bmdma_start 	= ata_bmdma_start,
-	.bmdma_stop	= ata_bmdma_stop,
-	.bmdma_status 	= ata_bmdma_status,
-
 	.qc_prep 	= ata_qc_prep,
 	.qc_issue	= ata_qc_issue_prot,
 
@@ -96,7 +91,7 @@ static struct ata_port_operations rz1000_port_ops = {
 	.cable_detect	= ata_cable_40wire,
 
 	.irq_handler	= ata_interrupt,
-	.irq_clear	= ata_bmdma_irq_clear,
+	.irq_clear	= ata_noop_irq_clear,
 	.irq_on		= ata_irq_on,
 
 	.port_start	= ata_sff_port_start,
diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c
index 078f757..53ea883 100644
--- a/drivers/ata/sata_fsl.c
+++ b/drivers/ata/sata_fsl.c
@@ -1216,6 +1216,7 @@ static const struct ata_port_operations sata_fsl_ops = {
 
 	.tf_read = sata_fsl_tf_read,
 
+	.qc_defer = ata_std_qc_defer,
 	.qc_prep = sata_fsl_qc_prep,
 	.qc_issue = sata_fsl_qc_issue,
 	.irq_clear = ata_noop_irq_clear,
diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
index b3b3da4..4685bce 100644
--- a/drivers/ata/sata_mv.c
+++ b/drivers/ata/sata_mv.c
@@ -557,8 +557,6 @@ static const struct ata_port_operations mv5_ops = {
 	.exec_command		= ata_exec_command,
 	.dev_select		= ata_std_dev_select,
 
-	.cable_detect		= ata_cable_sata,
-
 	.qc_prep		= mv_qc_prep,
 	.qc_issue		= mv_qc_issue,
 	.data_xfer		= ata_data_xfer,
@@ -585,8 +583,6 @@ static const struct ata_port_operations mv6_ops = {
 	.exec_command		= ata_exec_command,
 	.dev_select		= ata_std_dev_select,
 
-	.cable_detect		= ata_cable_sata,
-
 	.qc_prep		= mv_qc_prep,
 	.qc_issue		= mv_qc_issue,
 	.data_xfer		= ata_data_xfer,
@@ -613,8 +609,6 @@ static const struct ata_port_operations mv_iie_ops = {
 	.exec_command		= ata_exec_command,
 	.dev_select		= ata_std_dev_select,
 
-	.cable_detect		= ata_cable_sata,
-
 	.qc_prep		= mv_qc_prep_iie,
 	.qc_issue		= mv_qc_issue,
 	.data_xfer		= ata_data_xfer,
diff --git a/drivers/ata/sata_nv.c b/drivers/ata/sata_nv.c
index 75b7653..bd5b6c3 100644
--- a/drivers/ata/sata_nv.c
+++ b/drivers/ata/sata_nv.c
@@ -452,6 +452,7 @@ static const struct ata_port_operations nv_generic_ops = {
 	.bmdma_status		= ata_bmdma_status,
 	.qc_prep		= ata_qc_prep,
 	.qc_issue		= ata_qc_issue_prot,
+	.mode_filter		= ata_pci_default_filter,
 	.freeze			= ata_bmdma_freeze,
 	.thaw			= ata_bmdma_thaw,
 	.error_handler		= nv_error_handler,
@@ -461,7 +462,7 @@ static const struct ata_port_operations nv_generic_ops = {
 	.irq_on			= ata_irq_on,
 	.scr_read		= nv_scr_read,
 	.scr_write		= nv_scr_write,
-	.port_start		= ata_port_start,
+	.port_start		= ata_sff_port_start,
 };
 
 static const struct ata_port_operations nv_nf2_ops = {
@@ -476,6 +477,7 @@ static const struct ata_port_operations nv_nf2_ops = {
 	.bmdma_status		= ata_bmdma_status,
 	.qc_prep		= ata_qc_prep,
 	.qc_issue		= ata_qc_issue_prot,
+	.mode_filter		= ata_pci_default_filter,
 	.freeze			= nv_nf2_freeze,
 	.thaw			= nv_nf2_thaw,
 	.error_handler		= nv_error_handler,
@@ -485,7 +487,7 @@ static const struct ata_port_operations nv_nf2_ops = {
 	.irq_on			= ata_irq_on,
 	.scr_read		= nv_scr_read,
 	.scr_write		= nv_scr_write,
-	.port_start		= ata_port_start,
+	.port_start		= ata_sff_port_start,
 };
 
 static const struct ata_port_operations nv_ck804_ops = {
@@ -500,6 +502,7 @@ static const struct ata_port_operations nv_ck804_ops = {
 	.bmdma_status		= ata_bmdma_status,
 	.qc_prep		= ata_qc_prep,
 	.qc_issue		= ata_qc_issue_prot,
+	.mode_filter		= ata_pci_default_filter,
 	.freeze			= nv_ck804_freeze,
 	.thaw			= nv_ck804_thaw,
 	.error_handler		= nv_error_handler,
@@ -509,7 +512,7 @@ static const struct ata_port_operations nv_ck804_ops = {
 	.irq_on			= ata_irq_on,
 	.scr_read		= nv_scr_read,
 	.scr_write		= nv_scr_write,
-	.port_start		= ata_port_start,
+	.port_start		= ata_sff_port_start,
 	.host_stop		= nv_ck804_host_stop,
 };
 
@@ -527,6 +530,7 @@ static const struct ata_port_operations nv_adma_ops = {
 	.qc_defer		= ata_std_qc_defer,
 	.qc_prep		= nv_adma_qc_prep,
 	.qc_issue		= nv_adma_qc_issue,
+	.mode_filter		= ata_pci_default_filter,
 	.freeze			= nv_adma_freeze,
 	.thaw			= nv_adma_thaw,
 	.error_handler		= nv_adma_error_handler,
@@ -558,6 +562,7 @@ static const struct ata_port_operations nv_swncq_ops = {
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
index 840d1c4..5ee0abb 100644
--- a/drivers/ata/sata_svw.c
+++ b/drivers/ata/sata_svw.c
@@ -362,6 +362,7 @@ static const struct ata_port_operations k2_sata_ops = {
 	.qc_prep		= ata_qc_prep,
 	.qc_issue		= ata_qc_issue_prot,
 	.data_xfer		= ata_data_xfer,
+	.mode_filter		= ata_pci_default_filter,
 	.freeze			= ata_bmdma_freeze,
 	.thaw			= ata_bmdma_thaw,
 	.error_handler		= ata_bmdma_error_handler,
@@ -370,7 +371,7 @@ static const struct ata_port_operations k2_sata_ops = {
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
index c0e0f1d..f66ffd7 100644
--- a/drivers/ata/sata_via.c
+++ b/drivers/ata/sata_via.c
@@ -118,6 +118,8 @@ static struct scsi_host_template svia_sht = {
 };
 
 static const struct ata_port_operations vt6420_sata_ops = {
+	.mode_filter		= ata_pci_default_filter,
+
 	.tf_load		= ata_tf_load,
 	.tf_read		= ata_tf_read,
 	.check_status		= ata_check_status,
@@ -141,12 +143,13 @@ static const struct ata_port_operations vt6420_sata_ops = {
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
@@ -172,10 +175,12 @@ static const struct ata_port_operations vt6421_pata_ops = {
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
@@ -195,7 +200,6 @@ static const struct ata_port_operations vt6421_sata_ops = {
 	.thaw			= ata_bmdma_thaw,
 	.error_handler		= ata_bmdma_error_handler,
 	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
-	.cable_detect		= ata_cable_sata,
 
 	.irq_clear		= ata_bmdma_irq_clear,
 	.irq_on			= ata_irq_on,
@@ -203,7 +207,7 @@ static const struct ata_port_operations vt6421_sata_ops = {
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

