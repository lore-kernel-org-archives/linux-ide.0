From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 4/9] libata: implement and use SHT initializers
Date: Tue, 11 Mar 2008 21:06:00 +0900
Message-ID: <12052371673311-git-send-email-htejun@gmail.com>
References: <12052371651181-git-send-email-htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.179]:45030 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753396AbYCKMGR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 11 Mar 2008 08:06:17 -0400
Received: by wa-out-1112.google.com with SMTP id v27so2814319wah.23
        for <linux-ide@vger.kernel.org>; Tue, 11 Mar 2008 05:06:16 -0700 (PDT)
In-Reply-To: <12052371651181-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org, liml@rtr.ca, alan@lxorguk.ukuu.org.uk, kngregertsen@norway.atmel.com, sonic.adi@gmail.com, rmk@arm.linux.org.uk, alessandro.zummo@towertech
Cc: Tejun Heo <htejun@gmail.com>

libata lets low level drivers build scsi_host_template and register it
to the SCSI layer.  This allows low level drivers high level of
flexibility but also burdens them with lots of boilerplate entries.

This patch implements SHT initializers which can be used to initialize
all the boilerplate entries in a sht.  Three variants of them are
implemented - BASE, BMDMA and NCQ - for different types of drivers.
Note that entries can be overriden by putting individual initializers
after the helper macro.

All sht tables are identical before and after this patch.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/ahci.c              |   15 +---------
 drivers/ata/ata_generic.c       |   16 +----------
 drivers/ata/ata_piix.c          |   16 +----------
 drivers/ata/pata_acpi.c         |   17 +-----------
 drivers/ata/pata_ali.c          |   16 +----------
 drivers/ata/pata_amd.c          |   16 +----------
 drivers/ata/pata_artop.c        |   16 +----------
 drivers/ata/pata_at32.c         |   16 +----------
 drivers/ata/pata_atiixp.c       |   15 +---------
 drivers/ata/pata_bf54x.c        |   14 +---------
 drivers/ata/pata_cmd640.c       |   16 +----------
 drivers/ata/pata_cmd64x.c       |   16 +----------
 drivers/ata/pata_cs5520.c       |   15 +---------
 drivers/ata/pata_cs5530.c       |   17 +----------
 drivers/ata/pata_cs5535.c       |   16 +----------
 drivers/ata/pata_cs5536.c       |   16 +----------
 drivers/ata/pata_cypress.c      |   16 +----------
 drivers/ata/pata_efar.c         |   16 +----------
 drivers/ata/pata_hpt366.c       |   16 +----------
 drivers/ata/pata_hpt37x.c       |   16 +----------
 drivers/ata/pata_hpt3x2n.c      |   16 +----------
 drivers/ata/pata_hpt3x3.c       |   16 +----------
 drivers/ata/pata_icside.c       |   14 +---------
 drivers/ata/pata_isapnp.c       |   16 +----------
 drivers/ata/pata_it8213.c       |   16 +----------
 drivers/ata/pata_it821x.c       |   16 +----------
 drivers/ata/pata_ixp4xx_cf.c    |   16 +----------
 drivers/ata/pata_jmicron.c      |   17 +-----------
 drivers/ata/pata_legacy.c       |   16 +----------
 drivers/ata/pata_marvell.c      |   17 +-----------
 drivers/ata/pata_mpc52xx.c      |   16 +----------
 drivers/ata/pata_mpiix.c        |   16 +----------
 drivers/ata/pata_netcell.c      |   17 +-----------
 drivers/ata/pata_ninja32.c      |   16 +----------
 drivers/ata/pata_ns87410.c      |   16 +----------
 drivers/ata/pata_ns87415.c      |   16 +----------
 drivers/ata/pata_oldpiix.c      |   16 +----------
 drivers/ata/pata_opti.c         |   16 +----------
 drivers/ata/pata_optidma.c      |   16 +----------
 drivers/ata/pata_pcmcia.c       |   16 +----------
 drivers/ata/pata_pdc2027x.c     |   16 +----------
 drivers/ata/pata_pdc202xx_old.c |   16 +----------
 drivers/ata/pata_platform.c     |   16 +----------
 drivers/ata/pata_qdi.c          |   16 +----------
 drivers/ata/pata_radisys.c      |   16 +----------
 drivers/ata/pata_rb500_cf.c     |   17 +-----------
 drivers/ata/pata_rz1000.c       |   16 +----------
 drivers/ata/pata_sc1200.c       |   17 +----------
 drivers/ata/pata_scc.c          |   16 +----------
 drivers/ata/pata_serverworks.c  |   16 +----------
 drivers/ata/pata_sil680.c       |   16 +----------
 drivers/ata/pata_sis.c          |   16 +----------
 drivers/ata/pata_sl82c105.c     |   16 +----------
 drivers/ata/pata_triflex.c      |   16 +----------
 drivers/ata/pata_via.c          |   16 +----------
 drivers/ata/pata_winbond.c      |   16 +----------
 drivers/ata/pdc_adma.c          |   14 +---------
 drivers/ata/sata_fsl.c          |   14 +---------
 drivers/ata/sata_inic162x.c     |   16 +----------
 drivers/ata/sata_mv.c           |   28 +-----------------
 drivers/ata/sata_nv.c           |   42 ++--------------------------
 drivers/ata/sata_promise.c      |   14 +---------
 drivers/ata/sata_qstor.c        |   14 +---------
 drivers/ata/sata_sil.c          |   16 +----------
 drivers/ata/sata_sil24.c        |   14 +---------
 drivers/ata/sata_sis.c          |   16 +----------
 drivers/ata/sata_svw.c          |   16 +----------
 drivers/ata/sata_sx4.c          |   14 +---------
 drivers/ata/sata_uli.c          |   16 +----------
 drivers/ata/sata_via.c          |   16 +----------
 drivers/ata/sata_vsc.c          |   16 +----------
 include/linux/libata.h          |   57 +++++++++++++++++++++++++++++++++++++++
 72 files changed, 133 insertions(+), 1086 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 16a21b8..9999258 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -58,7 +58,6 @@ enum {
 	AHCI_MAX_PORTS		= 32,
 	AHCI_MAX_SG		= 168, /* hardware max is 64K */
 	AHCI_DMA_BOUNDARY	= 0xffffffff,
-	AHCI_USE_CLUSTERING	= 1,
 	AHCI_MAX_CMDS		= 32,
 	AHCI_CMD_SZ		= 32,
 	AHCI_CMD_SLOT_SZ	= AHCI_MAX_CMDS * AHCI_CMD_SZ,
@@ -270,22 +269,10 @@ static struct class_device_attribute *ahci_shost_attrs[] = {
 };
 
 static struct scsi_host_template ahci_sht = {
-	.module			= THIS_MODULE,
-	.name			= DRV_NAME,
-	.ioctl			= ata_scsi_ioctl,
-	.queuecommand		= ata_scsi_queuecmd,
-	.change_queue_depth	= ata_scsi_change_queue_depth,
+	ATA_NCQ_SHT(DRV_NAME),
 	.can_queue		= AHCI_MAX_CMDS - 1,
-	.this_id		= ATA_SHT_THIS_ID,
 	.sg_tablesize		= AHCI_MAX_SG,
-	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
-	.emulated		= ATA_SHT_EMULATED,
-	.use_clustering		= AHCI_USE_CLUSTERING,
-	.proc_name		= DRV_NAME,
 	.dma_boundary		= AHCI_DMA_BOUNDARY,
-	.slave_configure	= ata_scsi_slave_config,
-	.slave_destroy		= ata_scsi_slave_destroy,
-	.bios_param		= ata_std_bios_param,
 	.shost_attrs		= ahci_shost_attrs,
 };
 
diff --git a/drivers/ata/ata_generic.c b/drivers/ata/ata_generic.c
index db4c3cb..5c64ce1 100644
--- a/drivers/ata/ata_generic.c
+++ b/drivers/ata/ata_generic.c
@@ -95,21 +95,7 @@ static int generic_set_mode(struct ata_link *link, struct ata_device **unused)
 }
 
 static struct scsi_host_template generic_sht = {
-	.module			= THIS_MODULE,
-	.name			= DRV_NAME,
-	.ioctl			= ata_scsi_ioctl,
-	.queuecommand		= ata_scsi_queuecmd,
-	.can_queue		= ATA_DEF_QUEUE,
-	.this_id		= ATA_SHT_THIS_ID,
-	.sg_tablesize		= LIBATA_MAX_PRD,
-	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
-	.emulated		= ATA_SHT_EMULATED,
-	.use_clustering		= ATA_SHT_USE_CLUSTERING,
-	.proc_name		= DRV_NAME,
-	.dma_boundary		= ATA_DMA_BOUNDARY,
-	.slave_configure	= ata_scsi_slave_config,
-	.slave_destroy		= ata_scsi_slave_destroy,
-	.bios_param		= ata_std_bios_param,
+	ATA_BMDMA_SHT(DRV_NAME),
 };
 
 static struct ata_port_operations generic_port_ops = {
diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
index 067760a..9f887b2 100644
--- a/drivers/ata/ata_piix.c
+++ b/drivers/ata/ata_piix.c
@@ -291,21 +291,7 @@ static struct pci_driver piix_pci_driver = {
 };
 
 static struct scsi_host_template piix_sht = {
-	.module			= THIS_MODULE,
-	.name			= DRV_NAME,
-	.ioctl			= ata_scsi_ioctl,
-	.queuecommand		= ata_scsi_queuecmd,
-	.can_queue		= ATA_DEF_QUEUE,
-	.this_id		= ATA_SHT_THIS_ID,
-	.sg_tablesize		= LIBATA_MAX_PRD,
-	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
-	.emulated		= ATA_SHT_EMULATED,
-	.use_clustering		= ATA_SHT_USE_CLUSTERING,
-	.proc_name		= DRV_NAME,
-	.dma_boundary		= ATA_DMA_BOUNDARY,
-	.slave_configure	= ata_scsi_slave_config,
-	.slave_destroy		= ata_scsi_slave_destroy,
-	.bios_param		= ata_std_bios_param,
+	ATA_BMDMA_SHT(DRV_NAME),
 };
 
 static const struct ata_port_operations piix_pata_ops = {
diff --git a/drivers/ata/pata_acpi.c b/drivers/ata/pata_acpi.c
index bdc3b9d..187545c 100644
--- a/drivers/ata/pata_acpi.c
+++ b/drivers/ata/pata_acpi.c
@@ -232,22 +232,7 @@ static int pacpi_port_start(struct ata_port *ap)
 }
 
 static struct scsi_host_template pacpi_sht = {
-	.module			= THIS_MODULE,
-	.name			= DRV_NAME,
-	.ioctl			= ata_scsi_ioctl,
-	.queuecommand		= ata_scsi_queuecmd,
-	.can_queue		= ATA_DEF_QUEUE,
-	.this_id		= ATA_SHT_THIS_ID,
-	.sg_tablesize		= LIBATA_MAX_PRD,
-	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
-	.emulated		= ATA_SHT_EMULATED,
-	.use_clustering		= ATA_SHT_USE_CLUSTERING,
-	.proc_name		= DRV_NAME,
-	.dma_boundary		= ATA_DMA_BOUNDARY,
-	.slave_configure	= ata_scsi_slave_config,
-	.slave_destroy		= ata_scsi_slave_destroy,
-	/* Use standard CHS mapping rules */
-	.bios_param		= ata_std_bios_param,
+	ATA_BMDMA_SHT(DRV_NAME),
 };
 
 static const struct ata_port_operations pacpi_ops = {
diff --git a/drivers/ata/pata_ali.c b/drivers/ata/pata_ali.c
index 8a9044c..af028a6 100644
--- a/drivers/ata/pata_ali.c
+++ b/drivers/ata/pata_ali.c
@@ -301,21 +301,7 @@ static int ali_check_atapi_dma(struct ata_queued_cmd *qc)
 }
 
 static struct scsi_host_template ali_sht = {
-	.module			= THIS_MODULE,
-	.name			= DRV_NAME,
-	.ioctl			= ata_scsi_ioctl,
-	.queuecommand		= ata_scsi_queuecmd,
-	.can_queue		= ATA_DEF_QUEUE,
-	.this_id		= ATA_SHT_THIS_ID,
-	.sg_tablesize		= LIBATA_MAX_PRD,
-	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
-	.emulated		= ATA_SHT_EMULATED,
-	.use_clustering		= ATA_SHT_USE_CLUSTERING,
-	.proc_name		= DRV_NAME,
-	.dma_boundary		= ATA_DMA_BOUNDARY,
-	.slave_configure	= ata_scsi_slave_config,
-	.slave_destroy		= ata_scsi_slave_destroy,
-	.bios_param		= ata_std_bios_param,
+	ATA_BMDMA_SHT(DRV_NAME),
 };
 
 /*
diff --git a/drivers/ata/pata_amd.c b/drivers/ata/pata_amd.c
index 5e1bc13..90d786d 100644
--- a/drivers/ata/pata_amd.c
+++ b/drivers/ata/pata_amd.c
@@ -353,21 +353,7 @@ static void nv_host_stop(struct ata_host *host)
 }
 
 static struct scsi_host_template amd_sht = {
-	.module			= THIS_MODULE,
-	.name			= DRV_NAME,
-	.ioctl			= ata_scsi_ioctl,
-	.queuecommand		= ata_scsi_queuecmd,
-	.can_queue		= ATA_DEF_QUEUE,
-	.this_id		= ATA_SHT_THIS_ID,
-	.sg_tablesize		= LIBATA_MAX_PRD,
-	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
-	.emulated		= ATA_SHT_EMULATED,
-	.use_clustering		= ATA_SHT_USE_CLUSTERING,
-	.proc_name		= DRV_NAME,
-	.dma_boundary		= ATA_DMA_BOUNDARY,
-	.slave_configure	= ata_scsi_slave_config,
-	.slave_destroy		= ata_scsi_slave_destroy,
-	.bios_param		= ata_std_bios_param,
+	ATA_BMDMA_SHT(DRV_NAME),
 };
 
 static struct ata_port_operations amd33_port_ops = {
diff --git a/drivers/ata/pata_artop.c b/drivers/ata/pata_artop.c
index a238c7b..7bfb7e8 100644
--- a/drivers/ata/pata_artop.c
+++ b/drivers/ata/pata_artop.c
@@ -314,21 +314,7 @@ static void artop6260_set_dmamode (struct ata_port *ap, struct ata_device *adev)
 }
 
 static struct scsi_host_template artop_sht = {
-	.module			= THIS_MODULE,
-	.name			= DRV_NAME,
-	.ioctl			= ata_scsi_ioctl,
-	.queuecommand		= ata_scsi_queuecmd,
-	.can_queue		= ATA_DEF_QUEUE,
-	.this_id		= ATA_SHT_THIS_ID,
-	.sg_tablesize		= LIBATA_MAX_PRD,
-	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
-	.emulated		= ATA_SHT_EMULATED,
-	.use_clustering		= ATA_SHT_USE_CLUSTERING,
-	.proc_name		= DRV_NAME,
-	.dma_boundary		= ATA_DMA_BOUNDARY,
-	.slave_configure	= ata_scsi_slave_config,
-	.slave_destroy		= ata_scsi_slave_destroy,
-	.bios_param		= ata_std_bios_param,
+	ATA_BMDMA_SHT(DRV_NAME),
 };
 
 static const struct ata_port_operations artop6210_ops = {
diff --git a/drivers/ata/pata_at32.c b/drivers/ata/pata_at32.c
index 27c959f..d7b7b7f 100644
--- a/drivers/ata/pata_at32.c
+++ b/drivers/ata/pata_at32.c
@@ -167,21 +167,7 @@ static void pata_at32_set_piomode(struct ata_port *ap, struct ata_device *adev)
 }
 
 static struct scsi_host_template at32_sht = {
-	.module			= THIS_MODULE,
-	.name			= DRV_NAME,
-	.ioctl			= ata_scsi_ioctl,
-	.queuecommand		= ata_scsi_queuecmd,
-	.can_queue		= ATA_DEF_QUEUE,
-	.this_id		= ATA_SHT_THIS_ID,
-	.sg_tablesize		= LIBATA_MAX_PRD,
-	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
-	.emulated		= ATA_SHT_EMULATED,
-	.use_clustering		= ATA_SHT_USE_CLUSTERING,
-	.proc_name		= DRV_NAME,
-	.dma_boundary		= ATA_DMA_BOUNDARY,
-	.slave_configure	= ata_scsi_slave_config,
-	.slave_destroy		= ata_scsi_slave_destroy,
-	.bios_param		= ata_std_bios_param,
+	ATA_PIO_SHT(DRV_NAME),
 };
 
 static struct ata_port_operations at32_port_ops = {
diff --git a/drivers/ata/pata_atiixp.c b/drivers/ata/pata_atiixp.c
index 408bdc1..645c472 100644
--- a/drivers/ata/pata_atiixp.c
+++ b/drivers/ata/pata_atiixp.c
@@ -221,21 +221,8 @@ static void atiixp_bmdma_stop(struct ata_queued_cmd *qc)
 }
 
 static struct scsi_host_template atiixp_sht = {
-	.module			= THIS_MODULE,
-	.name			= DRV_NAME,
-	.ioctl			= ata_scsi_ioctl,
-	.queuecommand		= ata_scsi_queuecmd,
-	.can_queue		= ATA_DEF_QUEUE,
-	.this_id		= ATA_SHT_THIS_ID,
+	ATA_BMDMA_SHT(DRV_NAME),
 	.sg_tablesize		= LIBATA_DUMB_MAX_PRD,
-	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
-	.emulated		= ATA_SHT_EMULATED,
-	.use_clustering		= ATA_SHT_USE_CLUSTERING,
-	.proc_name		= DRV_NAME,
-	.dma_boundary		= ATA_DMA_BOUNDARY,
-	.slave_configure	= ata_scsi_slave_config,
-	.slave_destroy		= ata_scsi_slave_destroy,
-	.bios_param		= ata_std_bios_param,
 };
 
 static struct ata_port_operations atiixp_port_ops = {
diff --git a/drivers/ata/pata_bf54x.c b/drivers/ata/pata_bf54x.c
index 146c202..6c75fca 100644
--- a/drivers/ata/pata_bf54x.c
+++ b/drivers/ata/pata_bf54x.c
@@ -1357,21 +1357,9 @@ static int bfin_port_start(struct ata_port *ap)
 }
 
 static struct scsi_host_template bfin_sht = {
-	.module			= THIS_MODULE,
-	.name			= DRV_NAME,
-	.ioctl			= ata_scsi_ioctl,
-	.queuecommand		= ata_scsi_queuecmd,
-	.can_queue		= ATA_DEF_QUEUE,
-	.this_id		= ATA_SHT_THIS_ID,
+	ATA_BASE_SHT(DRV_NAME),
 	.sg_tablesize		= SG_NONE,
-	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
-	.emulated		= ATA_SHT_EMULATED,
-	.use_clustering		= ATA_SHT_USE_CLUSTERING,
-	.proc_name		= DRV_NAME,
 	.dma_boundary		= ATA_DMA_BOUNDARY,
-	.slave_configure	= ata_scsi_slave_config,
-	.slave_destroy		= ata_scsi_slave_destroy,
-	.bios_param		= ata_std_bios_param,
 };
 
 static const struct ata_port_operations bfin_pata_ops = {
diff --git a/drivers/ata/pata_cmd640.c b/drivers/ata/pata_cmd640.c
index 0ef1d1d..26562b8 100644
--- a/drivers/ata/pata_cmd640.c
+++ b/drivers/ata/pata_cmd640.c
@@ -166,21 +166,7 @@ static int cmd640_port_start(struct ata_port *ap)
 }
 
 static struct scsi_host_template cmd640_sht = {
-	.module			= THIS_MODULE,
-	.name			= DRV_NAME,
-	.ioctl			= ata_scsi_ioctl,
-	.queuecommand		= ata_scsi_queuecmd,
-	.can_queue		= ATA_DEF_QUEUE,
-	.this_id		= ATA_SHT_THIS_ID,
-	.sg_tablesize		= LIBATA_MAX_PRD,
-	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
-	.emulated		= ATA_SHT_EMULATED,
-	.use_clustering		= ATA_SHT_USE_CLUSTERING,
-	.proc_name		= DRV_NAME,
-	.dma_boundary		= ATA_DMA_BOUNDARY,
-	.slave_configure	= ata_scsi_slave_config,
-	.slave_destroy		= ata_scsi_slave_destroy,
-	.bios_param		= ata_std_bios_param,
+	ATA_BMDMA_SHT(DRV_NAME),
 };
 
 static struct ata_port_operations cmd640_port_ops = {
diff --git a/drivers/ata/pata_cmd64x.c b/drivers/ata/pata_cmd64x.c
index e8c1262..6aea05c 100644
--- a/drivers/ata/pata_cmd64x.c
+++ b/drivers/ata/pata_cmd64x.c
@@ -266,21 +266,7 @@ static void cmd646r1_bmdma_stop(struct ata_queued_cmd *qc)
 }
 
 static struct scsi_host_template cmd64x_sht = {
-	.module			= THIS_MODULE,
-	.name			= DRV_NAME,
-	.ioctl			= ata_scsi_ioctl,
-	.queuecommand		= ata_scsi_queuecmd,
-	.can_queue		= ATA_DEF_QUEUE,
-	.this_id		= ATA_SHT_THIS_ID,
-	.sg_tablesize		= LIBATA_MAX_PRD,
-	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
-	.emulated		= ATA_SHT_EMULATED,
-	.use_clustering		= ATA_SHT_USE_CLUSTERING,
-	.proc_name		= DRV_NAME,
-	.dma_boundary		= ATA_DMA_BOUNDARY,
-	.slave_configure	= ata_scsi_slave_config,
-	.slave_destroy		= ata_scsi_slave_destroy,
-	.bios_param		= ata_std_bios_param,
+	ATA_BMDMA_SHT(DRV_NAME),
 };
 
 static struct ata_port_operations cmd64x_port_ops = {
diff --git a/drivers/ata/pata_cs5520.c b/drivers/ata/pata_cs5520.c
index 44ad2c9..7e64309 100644
--- a/drivers/ata/pata_cs5520.c
+++ b/drivers/ata/pata_cs5520.c
@@ -140,21 +140,8 @@ static void cs5520_set_piomode(struct ata_port *ap, struct ata_device *adev)
 }
 
 static struct scsi_host_template cs5520_sht = {
-	.module			= THIS_MODULE,
-	.name			= DRV_NAME,
-	.ioctl			= ata_scsi_ioctl,
-	.queuecommand		= ata_scsi_queuecmd,
-	.can_queue		= ATA_DEF_QUEUE,
-	.this_id		= ATA_SHT_THIS_ID,
+	ATA_BMDMA_SHT(DRV_NAME),
 	.sg_tablesize		= LIBATA_DUMB_MAX_PRD,
-	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
-	.emulated		= ATA_SHT_EMULATED,
-	.use_clustering		= ATA_SHT_USE_CLUSTERING,
-	.proc_name		= DRV_NAME,
-	.dma_boundary		= ATA_DMA_BOUNDARY,
-	.slave_configure	= ata_scsi_slave_config,
-	.slave_destroy		= ata_scsi_slave_destroy,
-	.bios_param		= ata_std_bios_param,
 };
 
 static struct ata_port_operations cs5520_port_ops = {
diff --git a/drivers/ata/pata_cs5530.c b/drivers/ata/pata_cs5530.c
index f876aed..0bb03da 100644
--- a/drivers/ata/pata_cs5530.c
+++ b/drivers/ata/pata_cs5530.c
@@ -161,21 +161,8 @@ static unsigned int cs5530_qc_issue_prot(struct ata_queued_cmd *qc)
 }
 
 static struct scsi_host_template cs5530_sht = {
-	.module			= THIS_MODULE,
-	.name			= DRV_NAME,
-	.ioctl			= ata_scsi_ioctl,
-	.queuecommand		= ata_scsi_queuecmd,
-	.can_queue		= ATA_DEF_QUEUE,
-	.this_id		= ATA_SHT_THIS_ID,
-	.sg_tablesize		= LIBATA_DUMB_MAX_PRD,
-	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
-	.emulated		= ATA_SHT_EMULATED,
-	.use_clustering		= ATA_SHT_USE_CLUSTERING,
-	.proc_name		= DRV_NAME,
-	.dma_boundary		= ATA_DMA_BOUNDARY,
-	.slave_configure	= ata_scsi_slave_config,
-	.slave_destroy		= ata_scsi_slave_destroy,
-	.bios_param		= ata_std_bios_param,
+	ATA_BMDMA_SHT(DRV_NAME),
+	.sg_tablesize	= LIBATA_DUMB_MAX_PRD,
 };
 
 static struct ata_port_operations cs5530_port_ops = {
diff --git a/drivers/ata/pata_cs5535.c b/drivers/ata/pata_cs5535.c
index 0132453..48a1834 100644
--- a/drivers/ata/pata_cs5535.c
+++ b/drivers/ata/pata_cs5535.c
@@ -158,21 +158,7 @@ static void cs5535_set_dmamode(struct ata_port *ap, struct ata_device *adev)
 }
 
 static struct scsi_host_template cs5535_sht = {
-	.module			= THIS_MODULE,
-	.name			= DRV_NAME,
-	.ioctl			= ata_scsi_ioctl,
-	.queuecommand		= ata_scsi_queuecmd,
-	.can_queue		= ATA_DEF_QUEUE,
-	.this_id		= ATA_SHT_THIS_ID,
-	.sg_tablesize		= LIBATA_MAX_PRD,
-	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
-	.emulated		= ATA_SHT_EMULATED,
-	.use_clustering		= ATA_SHT_USE_CLUSTERING,
-	.proc_name		= DRV_NAME,
-	.dma_boundary		= ATA_DMA_BOUNDARY,
-	.slave_configure	= ata_scsi_slave_config,
-	.slave_destroy		= ata_scsi_slave_destroy,
-	.bios_param		= ata_std_bios_param,
+	ATA_BMDMA_SHT(DRV_NAME),
 };
 
 static struct ata_port_operations cs5535_port_ops = {
diff --git a/drivers/ata/pata_cs5536.c b/drivers/ata/pata_cs5536.c
index 391aa88..f02d910 100644
--- a/drivers/ata/pata_cs5536.c
+++ b/drivers/ata/pata_cs5536.c
@@ -221,21 +221,7 @@ static void cs5536_set_dmamode(struct ata_port *ap, struct ata_device *adev)
 }
 
 static struct scsi_host_template cs5536_sht = {
-	.module			= THIS_MODULE,
-	.name			= DRV_NAME,
-	.ioctl			= ata_scsi_ioctl,
-	.queuecommand		= ata_scsi_queuecmd,
-	.can_queue		= ATA_DEF_QUEUE,
-	.this_id		= ATA_SHT_THIS_ID,
-	.sg_tablesize		= LIBATA_MAX_PRD,
-	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
-	.emulated		= ATA_SHT_EMULATED,
-	.use_clustering		= ATA_SHT_USE_CLUSTERING,
-	.proc_name		= DRV_NAME,
-	.dma_boundary		= ATA_DMA_BOUNDARY,
-	.slave_configure	= ata_scsi_slave_config,
-	.slave_destroy		= ata_scsi_slave_destroy,
-	.bios_param		= ata_std_bios_param,
+	ATA_BMDMA_SHT(DRV_NAME),
 };
 
 static struct ata_port_operations cs5536_port_ops = {
diff --git a/drivers/ata/pata_cypress.c b/drivers/ata/pata_cypress.c
index fc5f9c4..07fa1ab 100644
--- a/drivers/ata/pata_cypress.c
+++ b/drivers/ata/pata_cypress.c
@@ -110,21 +110,7 @@ static void cy82c693_set_dmamode(struct ata_port *ap, struct ata_device *adev)
 }
 
 static struct scsi_host_template cy82c693_sht = {
-	.module			= THIS_MODULE,
-	.name			= DRV_NAME,
-	.ioctl			= ata_scsi_ioctl,
-	.queuecommand		= ata_scsi_queuecmd,
-	.can_queue		= ATA_DEF_QUEUE,
-	.this_id		= ATA_SHT_THIS_ID,
-	.sg_tablesize		= LIBATA_MAX_PRD,
-	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
-	.emulated		= ATA_SHT_EMULATED,
-	.use_clustering		= ATA_SHT_USE_CLUSTERING,
-	.proc_name		= DRV_NAME,
-	.dma_boundary		= ATA_DMA_BOUNDARY,
-	.slave_configure	= ata_scsi_slave_config,
-	.slave_destroy		= ata_scsi_slave_destroy,
-	.bios_param		= ata_std_bios_param,
+	ATA_BMDMA_SHT(DRV_NAME),
 };
 
 static struct ata_port_operations cy82c693_port_ops = {
diff --git a/drivers/ata/pata_efar.c b/drivers/ata/pata_efar.c
index dc33220..8700d9d 100644
--- a/drivers/ata/pata_efar.c
+++ b/drivers/ata/pata_efar.c
@@ -233,21 +233,7 @@ static void efar_set_dmamode (struct ata_port *ap, struct ata_device *adev)
 }
 
 static struct scsi_host_template efar_sht = {
-	.module			= THIS_MODULE,
-	.name			= DRV_NAME,
-	.ioctl			= ata_scsi_ioctl,
-	.queuecommand		= ata_scsi_queuecmd,
-	.can_queue		= ATA_DEF_QUEUE,
-	.this_id		= ATA_SHT_THIS_ID,
-	.sg_tablesize		= LIBATA_MAX_PRD,
-	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
-	.emulated		= ATA_SHT_EMULATED,
-	.use_clustering		= ATA_SHT_USE_CLUSTERING,
-	.proc_name		= DRV_NAME,
-	.dma_boundary		= ATA_DMA_BOUNDARY,
-	.slave_configure	= ata_scsi_slave_config,
-	.slave_destroy		= ata_scsi_slave_destroy,
-	.bios_param		= ata_std_bios_param,
+	ATA_BMDMA_SHT(DRV_NAME),
 };
 
 static const struct ata_port_operations efar_ops = {
diff --git a/drivers/ata/pata_hpt366.c b/drivers/ata/pata_hpt366.c
index a820890..a30028d 100644
--- a/drivers/ata/pata_hpt366.c
+++ b/drivers/ata/pata_hpt366.c
@@ -290,21 +290,7 @@ static void hpt366_set_dmamode(struct ata_port *ap, struct ata_device *adev)
 }
 
 static struct scsi_host_template hpt36x_sht = {
-	.module			= THIS_MODULE,
-	.name			= DRV_NAME,
-	.ioctl			= ata_scsi_ioctl,
-	.queuecommand		= ata_scsi_queuecmd,
-	.can_queue		= ATA_DEF_QUEUE,
-	.this_id		= ATA_SHT_THIS_ID,
-	.sg_tablesize		= LIBATA_MAX_PRD,
-	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
-	.emulated		= ATA_SHT_EMULATED,
-	.use_clustering		= ATA_SHT_USE_CLUSTERING,
-	.proc_name		= DRV_NAME,
-	.dma_boundary		= ATA_DMA_BOUNDARY,
-	.slave_configure	= ata_scsi_slave_config,
-	.slave_destroy		= ata_scsi_slave_destroy,
-	.bios_param		= ata_std_bios_param,
+	ATA_BMDMA_SHT(DRV_NAME),
 };
 
 /*
diff --git a/drivers/ata/pata_hpt37x.c b/drivers/ata/pata_hpt37x.c
index 2ddcd07..7d6fac4 100644
--- a/drivers/ata/pata_hpt37x.c
+++ b/drivers/ata/pata_hpt37x.c
@@ -619,21 +619,7 @@ static void hpt37x_bmdma_stop(struct ata_queued_cmd *qc)
 
 
 static struct scsi_host_template hpt37x_sht = {
-	.module			= THIS_MODULE,
-	.name			= DRV_NAME,
-	.ioctl			= ata_scsi_ioctl,
-	.queuecommand		= ata_scsi_queuecmd,
-	.can_queue		= ATA_DEF_QUEUE,
-	.this_id		= ATA_SHT_THIS_ID,
-	.sg_tablesize		= LIBATA_MAX_PRD,
-	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
-	.emulated		= ATA_SHT_EMULATED,
-	.use_clustering		= ATA_SHT_USE_CLUSTERING,
-	.proc_name		= DRV_NAME,
-	.dma_boundary		= ATA_DMA_BOUNDARY,
-	.slave_configure	= ata_scsi_slave_config,
-	.slave_destroy		= ata_scsi_slave_destroy,
-	.bios_param		= ata_std_bios_param,
+	ATA_BMDMA_SHT(DRV_NAME),
 };
 
 /*
diff --git a/drivers/ata/pata_hpt3x2n.c b/drivers/ata/pata_hpt3x2n.c
index 3a517cb..aa380c4 100644
--- a/drivers/ata/pata_hpt3x2n.c
+++ b/drivers/ata/pata_hpt3x2n.c
@@ -339,21 +339,7 @@ static unsigned int hpt3x2n_qc_issue_prot(struct ata_queued_cmd *qc)
 }
 
 static struct scsi_host_template hpt3x2n_sht = {
-	.module			= THIS_MODULE,
-	.name			= DRV_NAME,
-	.ioctl			= ata_scsi_ioctl,
-	.queuecommand		= ata_scsi_queuecmd,
-	.can_queue		= ATA_DEF_QUEUE,
-	.this_id		= ATA_SHT_THIS_ID,
-	.sg_tablesize		= LIBATA_MAX_PRD,
-	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
-	.emulated		= ATA_SHT_EMULATED,
-	.use_clustering		= ATA_SHT_USE_CLUSTERING,
-	.proc_name		= DRV_NAME,
-	.dma_boundary		= ATA_DMA_BOUNDARY,
-	.slave_configure	= ata_scsi_slave_config,
-	.slave_destroy		= ata_scsi_slave_destroy,
-	.bios_param		= ata_std_bios_param,
+	ATA_BMDMA_SHT(DRV_NAME),
 };
 
 /*
diff --git a/drivers/ata/pata_hpt3x3.c b/drivers/ata/pata_hpt3x3.c
index c09f95a..9837ab0 100644
--- a/drivers/ata/pata_hpt3x3.c
+++ b/drivers/ata/pata_hpt3x3.c
@@ -102,21 +102,7 @@ static int hpt3x3_atapi_dma(struct ata_queued_cmd *qc)
 }
 
 static struct scsi_host_template hpt3x3_sht = {
-	.module			= THIS_MODULE,
-	.name			= DRV_NAME,
-	.ioctl			= ata_scsi_ioctl,
-	.queuecommand		= ata_scsi_queuecmd,
-	.can_queue		= ATA_DEF_QUEUE,
-	.this_id		= ATA_SHT_THIS_ID,
-	.sg_tablesize		= LIBATA_MAX_PRD,
-	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
-	.emulated		= ATA_SHT_EMULATED,
-	.use_clustering		= ATA_SHT_USE_CLUSTERING,
-	.proc_name		= DRV_NAME,
-	.dma_boundary		= ATA_DMA_BOUNDARY,
-	.slave_configure	= ata_scsi_slave_config,
-	.slave_destroy		= ata_scsi_slave_destroy,
-	.bios_param		= ata_std_bios_param,
+	ATA_BMDMA_SHT(DRV_NAME),
 };
 
 static struct ata_port_operations hpt3x3_port_ops = {
diff --git a/drivers/ata/pata_icside.c b/drivers/ata/pata_icside.c
index e1230ca..88a1c7a 100644
--- a/drivers/ata/pata_icside.c
+++ b/drivers/ata/pata_icside.c
@@ -305,21 +305,9 @@ static int icside_dma_init(struct pata_icside_info *info)
 
 
 static struct scsi_host_template pata_icside_sht = {
-	.module			= THIS_MODULE,
-	.name			= DRV_NAME,
-	.ioctl			= ata_scsi_ioctl,
-	.queuecommand		= ata_scsi_queuecmd,
-	.can_queue		= ATA_DEF_QUEUE,
-	.this_id		= ATA_SHT_THIS_ID,
+	ATA_BASE_SHT(DRV_NAME),
 	.sg_tablesize		= PATA_ICSIDE_MAX_SG,
-	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
-	.emulated		= ATA_SHT_EMULATED,
-	.use_clustering		= ATA_SHT_USE_CLUSTERING,
-	.proc_name		= DRV_NAME,
 	.dma_boundary		= ~0, /* no dma boundaries */
-	.slave_configure	= ata_scsi_slave_config,
-	.slave_destroy		= ata_scsi_slave_destroy,
-	.bios_param		= ata_std_bios_param,
 };
 
 static void pata_icside_postreset(struct ata_link *link, unsigned int *classes)
diff --git a/drivers/ata/pata_isapnp.c b/drivers/ata/pata_isapnp.c
index ef561de..91ca4d5 100644
--- a/drivers/ata/pata_isapnp.c
+++ b/drivers/ata/pata_isapnp.c
@@ -20,21 +20,7 @@
 #define DRV_VERSION "0.2.2"
 
 static struct scsi_host_template isapnp_sht = {
-	.module			= THIS_MODULE,
-	.name			= DRV_NAME,
-	.ioctl			= ata_scsi_ioctl,
-	.queuecommand		= ata_scsi_queuecmd,
-	.can_queue		= ATA_DEF_QUEUE,
-	.this_id		= ATA_SHT_THIS_ID,
-	.sg_tablesize		= LIBATA_MAX_PRD,
-	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
-	.emulated		= ATA_SHT_EMULATED,
-	.use_clustering		= ATA_SHT_USE_CLUSTERING,
-	.proc_name		= DRV_NAME,
-	.dma_boundary		= ATA_DMA_BOUNDARY,
-	.slave_configure	= ata_scsi_slave_config,
-	.slave_destroy		= ata_scsi_slave_destroy,
-	.bios_param		= ata_std_bios_param,
+	ATA_PIO_SHT(DRV_NAME),
 };
 
 static struct ata_port_operations isapnp_port_ops = {
diff --git a/drivers/ata/pata_it8213.c b/drivers/ata/pata_it8213.c
index 25c49c2..678a05b 100644
--- a/drivers/ata/pata_it8213.c
+++ b/drivers/ata/pata_it8213.c
@@ -243,21 +243,7 @@ static void it8213_set_dmamode (struct ata_port *ap, struct ata_device *adev)
 }
 
 static struct scsi_host_template it8213_sht = {
-	.module			= THIS_MODULE,
-	.name			= DRV_NAME,
-	.ioctl			= ata_scsi_ioctl,
-	.queuecommand		= ata_scsi_queuecmd,
-	.can_queue		= ATA_DEF_QUEUE,
-	.this_id		= ATA_SHT_THIS_ID,
-	.sg_tablesize		= LIBATA_MAX_PRD,
-	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
-	.emulated		= ATA_SHT_EMULATED,
-	.use_clustering		= ATA_SHT_USE_CLUSTERING,
-	.proc_name		= DRV_NAME,
-	.dma_boundary		= ATA_DMA_BOUNDARY,
-	.slave_configure	= ata_scsi_slave_config,
-	.slave_destroy		= ata_scsi_slave_destroy,
-	.bios_param		= ata_std_bios_param,
+	ATA_BMDMA_SHT(DRV_NAME),
 };
 
 static const struct ata_port_operations it8213_ops = {
diff --git a/drivers/ata/pata_it821x.c b/drivers/ata/pata_it821x.c
index 3181e2c..491ea69 100644
--- a/drivers/ata/pata_it821x.c
+++ b/drivers/ata/pata_it821x.c
@@ -632,21 +632,7 @@ static int it821x_port_start(struct ata_port *ap)
 }
 
 static struct scsi_host_template it821x_sht = {
-	.module			= THIS_MODULE,
-	.name			= DRV_NAME,
-	.ioctl			= ata_scsi_ioctl,
-	.queuecommand		= ata_scsi_queuecmd,
-	.can_queue		= ATA_DEF_QUEUE,
-	.this_id		= ATA_SHT_THIS_ID,
-	.sg_tablesize		= LIBATA_MAX_PRD,
-	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
-	.emulated		= ATA_SHT_EMULATED,
-	.use_clustering		= ATA_SHT_USE_CLUSTERING,
-	.proc_name		= DRV_NAME,
-	.dma_boundary		= ATA_DMA_BOUNDARY,
-	.slave_configure	= ata_scsi_slave_config,
-	.slave_destroy		= ata_scsi_slave_destroy,
-	.bios_param		= ata_std_bios_param,
+	ATA_BMDMA_SHT(DRV_NAME),
 };
 
 static struct ata_port_operations it821x_smart_port_ops = {
diff --git a/drivers/ata/pata_ixp4xx_cf.c b/drivers/ata/pata_ixp4xx_cf.c
index 6eb8cc9..b7e8e82 100644
--- a/drivers/ata/pata_ixp4xx_cf.c
+++ b/drivers/ata/pata_ixp4xx_cf.c
@@ -88,21 +88,7 @@ static unsigned int ixp4xx_mmio_data_xfer(struct ata_device *dev,
 }
 
 static struct scsi_host_template ixp4xx_sht = {
-	.module			= THIS_MODULE,
-	.name			= DRV_NAME,
-	.ioctl			= ata_scsi_ioctl,
-	.queuecommand		= ata_scsi_queuecmd,
-	.can_queue		= ATA_DEF_QUEUE,
-	.this_id		= ATA_SHT_THIS_ID,
-	.sg_tablesize		= LIBATA_MAX_PRD,
-	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
-	.emulated		= ATA_SHT_EMULATED,
-	.use_clustering		= ATA_SHT_USE_CLUSTERING,
-	.proc_name		= DRV_NAME,
-	.dma_boundary		= ATA_DMA_BOUNDARY,
-	.slave_configure	= ata_scsi_slave_config,
-	.slave_destroy		= ata_scsi_slave_destroy,
-	.bios_param		= ata_std_bios_param,
+	ATA_PIO_SHT(DRV_NAME),
 };
 
 static struct ata_port_operations ixp4xx_port_ops = {
diff --git a/drivers/ata/pata_jmicron.c b/drivers/ata/pata_jmicron.c
index 7d36fa8..69781af 100644
--- a/drivers/ata/pata_jmicron.c
+++ b/drivers/ata/pata_jmicron.c
@@ -122,22 +122,7 @@ static void jmicron_error_handler(struct ata_port *ap)
 /* No PIO or DMA methods needed for this device */
 
 static struct scsi_host_template jmicron_sht = {
-	.module			= THIS_MODULE,
-	.name			= DRV_NAME,
-	.ioctl			= ata_scsi_ioctl,
-	.queuecommand		= ata_scsi_queuecmd,
-	.can_queue		= ATA_DEF_QUEUE,
-	.this_id		= ATA_SHT_THIS_ID,
-	.sg_tablesize		= LIBATA_MAX_PRD,
-	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
-	.emulated		= ATA_SHT_EMULATED,
-	.use_clustering		= ATA_SHT_USE_CLUSTERING,
-	.proc_name		= DRV_NAME,
-	.dma_boundary		= ATA_DMA_BOUNDARY,
-	.slave_configure	= ata_scsi_slave_config,
-	.slave_destroy		= ata_scsi_slave_destroy,
-	/* Use standard CHS mapping rules */
-	.bios_param		= ata_std_bios_param,
+	ATA_BMDMA_SHT(DRV_NAME),
 };
 
 static const struct ata_port_operations jmicron_ops = {
diff --git a/drivers/ata/pata_legacy.c b/drivers/ata/pata_legacy.c
index 6ac02f7..5329b95 100644
--- a/drivers/ata/pata_legacy.c
+++ b/drivers/ata/pata_legacy.c
@@ -208,21 +208,7 @@ static int legacy_set_mode(struct ata_link *link, struct ata_device **unused)
 }
 
 static struct scsi_host_template legacy_sht = {
-	.module			= THIS_MODULE,
-	.name			= DRV_NAME,
-	.ioctl			= ata_scsi_ioctl,
-	.queuecommand		= ata_scsi_queuecmd,
-	.can_queue		= ATA_DEF_QUEUE,
-	.this_id		= ATA_SHT_THIS_ID,
-	.sg_tablesize		= LIBATA_MAX_PRD,
-	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
-	.emulated		= ATA_SHT_EMULATED,
-	.use_clustering		= ATA_SHT_USE_CLUSTERING,
-	.proc_name		= DRV_NAME,
-	.dma_boundary		= ATA_DMA_BOUNDARY,
-	.slave_configure	= ata_scsi_slave_config,
-	.slave_destroy		= ata_scsi_slave_destroy,
-	.bios_param		= ata_std_bios_param,
+	ATA_PIO_SHT(DRV_NAME),
 };
 
 /*
diff --git a/drivers/ata/pata_marvell.c b/drivers/ata/pata_marvell.c
index c4ee9b4..9de6e42 100644
--- a/drivers/ata/pata_marvell.c
+++ b/drivers/ata/pata_marvell.c
@@ -92,22 +92,7 @@ static void marvell_error_handler(struct ata_port *ap)
 /* No PIO or DMA methods needed for this device */
 
 static struct scsi_host_template marvell_sht = {
-	.module			= THIS_MODULE,
-	.name			= DRV_NAME,
-	.ioctl			= ata_scsi_ioctl,
-	.queuecommand		= ata_scsi_queuecmd,
-	.can_queue		= ATA_DEF_QUEUE,
-	.this_id		= ATA_SHT_THIS_ID,
-	.sg_tablesize		= LIBATA_MAX_PRD,
-	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
-	.emulated		= ATA_SHT_EMULATED,
-	.use_clustering		= ATA_SHT_USE_CLUSTERING,
-	.proc_name		= DRV_NAME,
-	.dma_boundary		= ATA_DMA_BOUNDARY,
-	.slave_configure	= ata_scsi_slave_config,
-	.slave_destroy		= ata_scsi_slave_destroy,
-	/* Use standard CHS mapping rules */
-	.bios_param		= ata_std_bios_param,
+	ATA_BMDMA_SHT(DRV_NAME),
 };
 
 static const struct ata_port_operations marvell_ops = {
diff --git a/drivers/ata/pata_mpc52xx.c b/drivers/ata/pata_mpc52xx.c
index fefe71d..4117b61 100644
--- a/drivers/ata/pata_mpc52xx.c
+++ b/drivers/ata/pata_mpc52xx.c
@@ -265,21 +265,7 @@ mpc52xx_ata_error_handler(struct ata_port *ap)
 
 
 static struct scsi_host_template mpc52xx_ata_sht = {
-	.module			= THIS_MODULE,
-	.name			= DRV_NAME,
-	.ioctl			= ata_scsi_ioctl,
-	.queuecommand		= ata_scsi_queuecmd,
-	.can_queue		= ATA_DEF_QUEUE,
-	.this_id		= ATA_SHT_THIS_ID,
-	.sg_tablesize		= LIBATA_MAX_PRD,
-	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
-	.emulated		= ATA_SHT_EMULATED,
-	.use_clustering		= ATA_SHT_USE_CLUSTERING,
-	.proc_name		= DRV_NAME,
-	.dma_boundary		= ATA_DMA_BOUNDARY,
-	.slave_configure	= ata_scsi_slave_config,
-	.slave_destroy		= ata_scsi_slave_destroy,
-	.bios_param		= ata_std_bios_param,
+	ATA_PIO_SHT(DRV_NAME),
 };
 
 static struct ata_port_operations mpc52xx_ata_port_ops = {
diff --git a/drivers/ata/pata_mpiix.c b/drivers/ata/pata_mpiix.c
index ced6372..e8e6837 100644
--- a/drivers/ata/pata_mpiix.c
+++ b/drivers/ata/pata_mpiix.c
@@ -151,21 +151,7 @@ static unsigned int mpiix_qc_issue_prot(struct ata_queued_cmd *qc)
 }
 
 static struct scsi_host_template mpiix_sht = {
-	.module			= THIS_MODULE,
-	.name			= DRV_NAME,
-	.ioctl			= ata_scsi_ioctl,
-	.queuecommand		= ata_scsi_queuecmd,
-	.can_queue		= ATA_DEF_QUEUE,
-	.this_id		= ATA_SHT_THIS_ID,
-	.sg_tablesize		= LIBATA_MAX_PRD,
-	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
-	.emulated		= ATA_SHT_EMULATED,
-	.use_clustering		= ATA_SHT_USE_CLUSTERING,
-	.proc_name		= DRV_NAME,
-	.dma_boundary		= ATA_DMA_BOUNDARY,
-	.slave_configure	= ata_scsi_slave_config,
-	.slave_destroy		= ata_scsi_slave_destroy,
-	.bios_param		= ata_std_bios_param,
+	ATA_PIO_SHT(DRV_NAME),
 };
 
 static struct ata_port_operations mpiix_port_ops = {
diff --git a/drivers/ata/pata_netcell.c b/drivers/ata/pata_netcell.c
index 9fd1a84..11f200a 100644
--- a/drivers/ata/pata_netcell.c
+++ b/drivers/ata/pata_netcell.c
@@ -21,22 +21,7 @@
 /* No PIO or DMA methods needed for this device */
 
 static struct scsi_host_template netcell_sht = {
-	.module			= THIS_MODULE,
-	.name			= DRV_NAME,
-	.ioctl			= ata_scsi_ioctl,
-	.queuecommand		= ata_scsi_queuecmd,
-	.can_queue		= ATA_DEF_QUEUE,
-	.this_id		= ATA_SHT_THIS_ID,
-	.sg_tablesize		= LIBATA_MAX_PRD,
-	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
-	.emulated		= ATA_SHT_EMULATED,
-	.use_clustering		= ATA_SHT_USE_CLUSTERING,
-	.proc_name		= DRV_NAME,
-	.dma_boundary		= ATA_DMA_BOUNDARY,
-	.slave_configure	= ata_scsi_slave_config,
-	.slave_destroy		= ata_scsi_slave_destroy,
-	/* Use standard CHS mapping rules */
-	.bios_param		= ata_std_bios_param,
+	ATA_BMDMA_SHT(DRV_NAME),
 };
 
 static const struct ata_port_operations netcell_ops = {
diff --git a/drivers/ata/pata_ninja32.c b/drivers/ata/pata_ninja32.c
index 15dd649..ce3b07c 100644
--- a/drivers/ata/pata_ninja32.c
+++ b/drivers/ata/pata_ninja32.c
@@ -79,21 +79,7 @@ static void ninja32_dev_select(struct ata_port *ap, unsigned int device)
 }
 
 static struct scsi_host_template ninja32_sht = {
-	.module			= THIS_MODULE,
-	.name			= DRV_NAME,
-	.ioctl			= ata_scsi_ioctl,
-	.queuecommand		= ata_scsi_queuecmd,
-	.can_queue		= ATA_DEF_QUEUE,
-	.this_id		= ATA_SHT_THIS_ID,
-	.sg_tablesize		= LIBATA_MAX_PRD,
-	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
-	.emulated		= ATA_SHT_EMULATED,
-	.use_clustering		= ATA_SHT_USE_CLUSTERING,
-	.proc_name		= DRV_NAME,
-	.dma_boundary		= ATA_DMA_BOUNDARY,
-	.slave_configure	= ata_scsi_slave_config,
-	.slave_destroy		= ata_scsi_slave_destroy,
-	.bios_param		= ata_std_bios_param,
+	ATA_BMDMA_SHT(DRV_NAME),
 };
 
 static struct ata_port_operations ninja32_port_ops = {
diff --git a/drivers/ata/pata_ns87410.c b/drivers/ata/pata_ns87410.c
index d182bdf..d2f85f1 100644
--- a/drivers/ata/pata_ns87410.c
+++ b/drivers/ata/pata_ns87410.c
@@ -144,21 +144,7 @@ static unsigned int ns87410_qc_issue_prot(struct ata_queued_cmd *qc)
 }
 
 static struct scsi_host_template ns87410_sht = {
-	.module			= THIS_MODULE,
-	.name			= DRV_NAME,
-	.ioctl			= ata_scsi_ioctl,
-	.queuecommand		= ata_scsi_queuecmd,
-	.can_queue		= ATA_DEF_QUEUE,
-	.this_id		= ATA_SHT_THIS_ID,
-	.sg_tablesize		= LIBATA_MAX_PRD,
-	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
-	.emulated		= ATA_SHT_EMULATED,
-	.use_clustering		= ATA_SHT_USE_CLUSTERING,
-	.proc_name		= DRV_NAME,
-	.dma_boundary		= ATA_DMA_BOUNDARY,
-	.slave_configure	= ata_scsi_slave_config,
-	.slave_destroy		= ata_scsi_slave_destroy,
-	.bios_param		= ata_std_bios_param,
+	ATA_PIO_SHT(DRV_NAME),
 };
 
 static struct ata_port_operations ns87410_port_ops = {
diff --git a/drivers/ata/pata_ns87415.c b/drivers/ata/pata_ns87415.c
index 93eb958..78d6344 100644
--- a/drivers/ata/pata_ns87415.c
+++ b/drivers/ata/pata_ns87415.c
@@ -366,21 +366,7 @@ static const struct ata_port_operations ns87415_pata_ops = {
 };
 
 static struct scsi_host_template ns87415_sht = {
-	.module			= THIS_MODULE,
-	.name			= DRV_NAME,
-	.ioctl			= ata_scsi_ioctl,
-	.queuecommand		= ata_scsi_queuecmd,
-	.can_queue		= ATA_DEF_QUEUE,
-	.this_id		= ATA_SHT_THIS_ID,
-	.sg_tablesize		= LIBATA_MAX_PRD,
-	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
-	.emulated		= ATA_SHT_EMULATED,
-	.use_clustering		= ATA_SHT_USE_CLUSTERING,
-	.proc_name		= DRV_NAME,
-	.dma_boundary		= ATA_DMA_BOUNDARY,
-	.slave_configure	= ata_scsi_slave_config,
-	.slave_destroy		= ata_scsi_slave_destroy,
-	.bios_param		= ata_std_bios_param,
+	ATA_BMDMA_SHT(DRV_NAME),
 };
 
 
diff --git a/drivers/ata/pata_oldpiix.c b/drivers/ata/pata_oldpiix.c
index 44da09a..45f9b3e 100644
--- a/drivers/ata/pata_oldpiix.c
+++ b/drivers/ata/pata_oldpiix.c
@@ -220,21 +220,7 @@ static unsigned int oldpiix_qc_issue_prot(struct ata_queued_cmd *qc)
 
 
 static struct scsi_host_template oldpiix_sht = {
-	.module			= THIS_MODULE,
-	.name			= DRV_NAME,
-	.ioctl			= ata_scsi_ioctl,
-	.queuecommand		= ata_scsi_queuecmd,
-	.can_queue		= ATA_DEF_QUEUE,
-	.this_id		= ATA_SHT_THIS_ID,
-	.sg_tablesize		= LIBATA_MAX_PRD,
-	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
-	.emulated		= ATA_SHT_EMULATED,
-	.use_clustering		= ATA_SHT_USE_CLUSTERING,
-	.proc_name		= DRV_NAME,
-	.dma_boundary		= ATA_DMA_BOUNDARY,
-	.slave_configure	= ata_scsi_slave_config,
-	.slave_destroy		= ata_scsi_slave_destroy,
-	.bios_param		= ata_std_bios_param,
+	ATA_BMDMA_SHT(DRV_NAME),
 };
 
 static const struct ata_port_operations oldpiix_pata_ops = {
diff --git a/drivers/ata/pata_opti.c b/drivers/ata/pata_opti.c
index 1e865f1..1deacfa 100644
--- a/drivers/ata/pata_opti.c
+++ b/drivers/ata/pata_opti.c
@@ -165,21 +165,7 @@ static void opti_set_piomode(struct ata_port *ap, struct ata_device *adev)
 }
 
 static struct scsi_host_template opti_sht = {
-	.module			= THIS_MODULE,
-	.name			= DRV_NAME,
-	.ioctl			= ata_scsi_ioctl,
-	.queuecommand		= ata_scsi_queuecmd,
-	.can_queue		= ATA_DEF_QUEUE,
-	.this_id		= ATA_SHT_THIS_ID,
-	.sg_tablesize		= LIBATA_MAX_PRD,
-	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
-	.emulated		= ATA_SHT_EMULATED,
-	.use_clustering		= ATA_SHT_USE_CLUSTERING,
-	.proc_name		= DRV_NAME,
-	.dma_boundary		= ATA_DMA_BOUNDARY,
-	.slave_configure	= ata_scsi_slave_config,
-	.slave_destroy		= ata_scsi_slave_destroy,
-	.bios_param		= ata_std_bios_param,
+	ATA_PIO_SHT(DRV_NAME),
 };
 
 static struct ata_port_operations opti_port_ops = {
diff --git a/drivers/ata/pata_optidma.c b/drivers/ata/pata_optidma.c
index 3f9d035..7495758 100644
--- a/drivers/ata/pata_optidma.c
+++ b/drivers/ata/pata_optidma.c
@@ -350,21 +350,7 @@ static int optidma_set_mode(struct ata_link *link, struct ata_device **r_failed)
 }
 
 static struct scsi_host_template optidma_sht = {
-	.module			= THIS_MODULE,
-	.name			= DRV_NAME,
-	.ioctl			= ata_scsi_ioctl,
-	.queuecommand		= ata_scsi_queuecmd,
-	.can_queue		= ATA_DEF_QUEUE,
-	.this_id		= ATA_SHT_THIS_ID,
-	.sg_tablesize		= LIBATA_MAX_PRD,
-	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
-	.emulated		= ATA_SHT_EMULATED,
-	.use_clustering		= ATA_SHT_USE_CLUSTERING,
-	.proc_name		= DRV_NAME,
-	.dma_boundary		= ATA_DMA_BOUNDARY,
-	.slave_configure	= ata_scsi_slave_config,
-	.slave_destroy		= ata_scsi_slave_destroy,
-	.bios_param		= ata_std_bios_param,
+	ATA_BMDMA_SHT(DRV_NAME),
 };
 
 static struct ata_port_operations optidma_port_ops = {
diff --git a/drivers/ata/pata_pcmcia.c b/drivers/ata/pata_pcmcia.c
index 9881a9e..c05b36c 100644
--- a/drivers/ata/pata_pcmcia.c
+++ b/drivers/ata/pata_pcmcia.c
@@ -128,21 +128,7 @@ static unsigned int ata_data_xfer_8bit(struct ata_device *dev,
 
 
 static struct scsi_host_template pcmcia_sht = {
-	.module			= THIS_MODULE,
-	.name			= DRV_NAME,
-	.ioctl			= ata_scsi_ioctl,
-	.queuecommand		= ata_scsi_queuecmd,
-	.can_queue		= ATA_DEF_QUEUE,
-	.this_id		= ATA_SHT_THIS_ID,
-	.sg_tablesize		= LIBATA_MAX_PRD,
-	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
-	.emulated		= ATA_SHT_EMULATED,
-	.use_clustering		= ATA_SHT_USE_CLUSTERING,
-	.proc_name		= DRV_NAME,
-	.dma_boundary		= ATA_DMA_BOUNDARY,
-	.slave_configure	= ata_scsi_slave_config,
-	.slave_destroy		= ata_scsi_slave_destroy,
-	.bios_param		= ata_std_bios_param,
+	ATA_PIO_SHT(DRV_NAME),
 };
 
 static struct ata_port_operations pcmcia_port_ops = {
diff --git a/drivers/ata/pata_pdc2027x.c b/drivers/ata/pata_pdc2027x.c
index 511c89b..229d9ac 100644
--- a/drivers/ata/pata_pdc2027x.c
+++ b/drivers/ata/pata_pdc2027x.c
@@ -129,21 +129,7 @@ static struct pci_driver pdc2027x_pci_driver = {
 };
 
 static struct scsi_host_template pdc2027x_sht = {
-	.module			= THIS_MODULE,
-	.name			= DRV_NAME,
-	.ioctl			= ata_scsi_ioctl,
-	.queuecommand		= ata_scsi_queuecmd,
-	.can_queue		= ATA_DEF_QUEUE,
-	.this_id		= ATA_SHT_THIS_ID,
-	.sg_tablesize		= LIBATA_MAX_PRD,
-	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
-	.emulated		= ATA_SHT_EMULATED,
-	.use_clustering		= ATA_SHT_USE_CLUSTERING,
-	.proc_name		= DRV_NAME,
-	.dma_boundary		= ATA_DMA_BOUNDARY,
-	.slave_configure	= ata_scsi_slave_config,
-	.slave_destroy		= ata_scsi_slave_destroy,
-	.bios_param		= ata_std_bios_param,
+	ATA_BMDMA_SHT(DRV_NAME),
 };
 
 static struct ata_port_operations pdc2027x_pata100_ops = {
diff --git a/drivers/ata/pata_pdc202xx_old.c b/drivers/ata/pata_pdc202xx_old.c
index 3ed8667..564ee07 100644
--- a/drivers/ata/pata_pdc202xx_old.c
+++ b/drivers/ata/pata_pdc202xx_old.c
@@ -262,21 +262,7 @@ static int pdc2026x_check_atapi_dma(struct ata_queued_cmd *qc)
 }
 
 static struct scsi_host_template pdc202xx_sht = {
-	.module			= THIS_MODULE,
-	.name			= DRV_NAME,
-	.ioctl			= ata_scsi_ioctl,
-	.queuecommand		= ata_scsi_queuecmd,
-	.can_queue		= ATA_DEF_QUEUE,
-	.this_id		= ATA_SHT_THIS_ID,
-	.sg_tablesize		= LIBATA_MAX_PRD,
-	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
-	.emulated		= ATA_SHT_EMULATED,
-	.use_clustering		= ATA_SHT_USE_CLUSTERING,
-	.proc_name		= DRV_NAME,
-	.dma_boundary		= ATA_DMA_BOUNDARY,
-	.slave_configure	= ata_scsi_slave_config,
-	.slave_destroy		= ata_scsi_slave_destroy,
-	.bios_param		= ata_std_bios_param,
+	ATA_BMDMA_SHT(DRV_NAME),
 };
 
 static struct ata_port_operations pdc2024x_port_ops = {
diff --git a/drivers/ata/pata_platform.c b/drivers/ata/pata_platform.c
index 602f556..cd2d03a 100644
--- a/drivers/ata/pata_platform.c
+++ b/drivers/ata/pata_platform.c
@@ -47,21 +47,7 @@ static int pata_platform_set_mode(struct ata_link *link, struct ata_device **unu
 }
 
 static struct scsi_host_template pata_platform_sht = {
-	.module			= THIS_MODULE,
-	.name			= DRV_NAME,
-	.ioctl			= ata_scsi_ioctl,
-	.queuecommand		= ata_scsi_queuecmd,
-	.can_queue		= ATA_DEF_QUEUE,
-	.this_id		= ATA_SHT_THIS_ID,
-	.sg_tablesize		= LIBATA_MAX_PRD,
-	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
-	.emulated		= ATA_SHT_EMULATED,
-	.use_clustering		= ATA_SHT_USE_CLUSTERING,
-	.proc_name		= DRV_NAME,
-	.dma_boundary		= ATA_DMA_BOUNDARY,
-	.slave_configure	= ata_scsi_slave_config,
-	.slave_destroy		= ata_scsi_slave_destroy,
-	.bios_param		= ata_std_bios_param,
+	ATA_PIO_SHT(DRV_NAME),
 };
 
 static struct ata_port_operations pata_platform_port_ops = {
diff --git a/drivers/ata/pata_qdi.c b/drivers/ata/pata_qdi.c
index 60238d5..ccb8682 100644
--- a/drivers/ata/pata_qdi.c
+++ b/drivers/ata/pata_qdi.c
@@ -154,21 +154,7 @@ static unsigned int qdi_data_xfer(struct ata_device *dev, unsigned char *buf,
 }
 
 static struct scsi_host_template qdi_sht = {
-	.module			= THIS_MODULE,
-	.name			= DRV_NAME,
-	.ioctl			= ata_scsi_ioctl,
-	.queuecommand		= ata_scsi_queuecmd,
-	.can_queue		= ATA_DEF_QUEUE,
-	.this_id		= ATA_SHT_THIS_ID,
-	.sg_tablesize		= LIBATA_MAX_PRD,
-	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
-	.emulated		= ATA_SHT_EMULATED,
-	.use_clustering		= ATA_SHT_USE_CLUSTERING,
-	.proc_name		= DRV_NAME,
-	.dma_boundary		= ATA_DMA_BOUNDARY,
-	.slave_configure	= ata_scsi_slave_config,
-	.slave_destroy		= ata_scsi_slave_destroy,
-	.bios_param		= ata_std_bios_param,
+	ATA_PIO_SHT(DRV_NAME),
 };
 
 static struct ata_port_operations qdi6500_port_ops = {
diff --git a/drivers/ata/pata_radisys.c b/drivers/ata/pata_radisys.c
index 8109b08..3981bf8 100644
--- a/drivers/ata/pata_radisys.c
+++ b/drivers/ata/pata_radisys.c
@@ -185,21 +185,7 @@ static unsigned int radisys_qc_issue_prot(struct ata_queued_cmd *qc)
 
 
 static struct scsi_host_template radisys_sht = {
-	.module			= THIS_MODULE,
-	.name			= DRV_NAME,
-	.ioctl			= ata_scsi_ioctl,
-	.queuecommand		= ata_scsi_queuecmd,
-	.can_queue		= ATA_DEF_QUEUE,
-	.this_id		= ATA_SHT_THIS_ID,
-	.sg_tablesize		= LIBATA_MAX_PRD,
-	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
-	.emulated		= ATA_SHT_EMULATED,
-	.use_clustering		= ATA_SHT_USE_CLUSTERING,
-	.proc_name		= DRV_NAME,
-	.dma_boundary		= ATA_DMA_BOUNDARY,
-	.slave_configure	= ata_scsi_slave_config,
-	.slave_destroy		= ata_scsi_slave_destroy,
-	.bios_param		= ata_std_bios_param,
+	ATA_BMDMA_SHT(DRV_NAME),
 };
 
 static const struct ata_port_operations radisys_pata_ops = {
diff --git a/drivers/ata/pata_rb500_cf.c b/drivers/ata/pata_rb500_cf.c
index 22cb9e1..4543c98 100644
--- a/drivers/ata/pata_rb500_cf.c
+++ b/drivers/ata/pata_rb500_cf.c
@@ -142,22 +142,7 @@ static struct ata_port_operations rb500_pata_port_ops = {
 /* ------------------------------------------------------------------------ */
 
 static struct scsi_host_template rb500_pata_sht = {
-	.module			= THIS_MODULE,
-	.name			= DRV_NAME,
-	.ioctl			= ata_scsi_ioctl,
-	.queuecommand		= ata_scsi_queuecmd,
-	.slave_configure	= ata_scsi_slave_config,
-	.slave_destroy		= ata_scsi_slave_destroy,
-	.bios_param		= ata_std_bios_param,
-	.proc_name		= DRV_NAME,
-
-	.can_queue		= ATA_DEF_QUEUE,
-	.this_id		= ATA_SHT_THIS_ID,
-	.sg_tablesize		= LIBATA_MAX_PRD,
-	.dma_boundary		= ATA_DMA_BOUNDARY,
-	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
-	.emulated		= ATA_SHT_EMULATED,
-	.use_clustering		= ATA_SHT_USE_CLUSTERING,
+	ATA_PIO_SHT(DRV_NAME),
 };
 
 /* ------------------------------------------------------------------------ */
diff --git a/drivers/ata/pata_rz1000.c b/drivers/ata/pata_rz1000.c
index 75b2521..80909a6 100644
--- a/drivers/ata/pata_rz1000.c
+++ b/drivers/ata/pata_rz1000.c
@@ -53,21 +53,7 @@ static int rz1000_set_mode(struct ata_link *link, struct ata_device **unused)
 
 
 static struct scsi_host_template rz1000_sht = {
-	.module			= THIS_MODULE,
-	.name			= DRV_NAME,
-	.ioctl			= ata_scsi_ioctl,
-	.queuecommand		= ata_scsi_queuecmd,
-	.can_queue		= ATA_DEF_QUEUE,
-	.this_id		= ATA_SHT_THIS_ID,
-	.sg_tablesize		= LIBATA_MAX_PRD,
-	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
-	.emulated		= ATA_SHT_EMULATED,
-	.use_clustering		= ATA_SHT_USE_CLUSTERING,
-	.proc_name		= DRV_NAME,
-	.dma_boundary		= ATA_DMA_BOUNDARY,
-	.slave_configure	= ata_scsi_slave_config,
-	.slave_destroy		= ata_scsi_slave_destroy,
-	.bios_param		= ata_std_bios_param,
+	ATA_PIO_SHT(DRV_NAME),
 };
 
 static struct ata_port_operations rz1000_port_ops = {
diff --git a/drivers/ata/pata_sc1200.c b/drivers/ata/pata_sc1200.c
index 725a858..38ce6e1 100644
--- a/drivers/ata/pata_sc1200.c
+++ b/drivers/ata/pata_sc1200.c
@@ -179,21 +179,8 @@ static unsigned int sc1200_qc_issue_prot(struct ata_queued_cmd *qc)
 }
 
 static struct scsi_host_template sc1200_sht = {
-	.module			= THIS_MODULE,
-	.name			= DRV_NAME,
-	.ioctl			= ata_scsi_ioctl,
-	.queuecommand		= ata_scsi_queuecmd,
-	.can_queue		= ATA_DEF_QUEUE,
-	.this_id		= ATA_SHT_THIS_ID,
-	.sg_tablesize		= LIBATA_DUMB_MAX_PRD,
-	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
-	.emulated		= ATA_SHT_EMULATED,
-	.use_clustering		= ATA_SHT_USE_CLUSTERING,
-	.proc_name		= DRV_NAME,
-	.dma_boundary		= ATA_DMA_BOUNDARY,
-	.slave_configure	= ata_scsi_slave_config,
-	.slave_destroy		= ata_scsi_slave_destroy,
-	.bios_param		= ata_std_bios_param,
+	ATA_BMDMA_SHT(DRV_NAME),
+	.sg_tablesize	= LIBATA_DUMB_MAX_PRD,
 };
 
 static struct ata_port_operations sc1200_port_ops = {
diff --git a/drivers/ata/pata_scc.c b/drivers/ata/pata_scc.c
index 6c016de..1833e9e 100644
--- a/drivers/ata/pata_scc.c
+++ b/drivers/ata/pata_scc.c
@@ -968,21 +968,7 @@ static void scc_port_stop (struct ata_port *ap)
 }
 
 static struct scsi_host_template scc_sht = {
-	.module			= THIS_MODULE,
-	.name			= DRV_NAME,
-	.ioctl			= ata_scsi_ioctl,
-	.queuecommand		= ata_scsi_queuecmd,
-	.can_queue		= ATA_DEF_QUEUE,
-	.this_id		= ATA_SHT_THIS_ID,
-	.sg_tablesize		= LIBATA_MAX_PRD,
-	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
-	.emulated		= ATA_SHT_EMULATED,
-	.use_clustering		= ATA_SHT_USE_CLUSTERING,
-	.proc_name		= DRV_NAME,
-	.dma_boundary		= ATA_DMA_BOUNDARY,
-	.slave_configure	= ata_scsi_slave_config,
-	.slave_destroy		= ata_scsi_slave_destroy,
-	.bios_param		= ata_std_bios_param,
+	ATA_BMDMA_SHT(DRV_NAME),
 };
 
 static const struct ata_port_operations scc_pata_ops = {
diff --git a/drivers/ata/pata_serverworks.c b/drivers/ata/pata_serverworks.c
index 6702df3..318a369 100644
--- a/drivers/ata/pata_serverworks.c
+++ b/drivers/ata/pata_serverworks.c
@@ -298,21 +298,7 @@ static void serverworks_set_dmamode(struct ata_port *ap, struct ata_device *adev
 }
 
 static struct scsi_host_template serverworks_sht = {
-	.module			= THIS_MODULE,
-	.name			= DRV_NAME,
-	.ioctl			= ata_scsi_ioctl,
-	.queuecommand		= ata_scsi_queuecmd,
-	.can_queue		= ATA_DEF_QUEUE,
-	.this_id		= ATA_SHT_THIS_ID,
-	.sg_tablesize		= LIBATA_MAX_PRD,
-	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
-	.emulated		= ATA_SHT_EMULATED,
-	.use_clustering		= ATA_SHT_USE_CLUSTERING,
-	.proc_name		= DRV_NAME,
-	.dma_boundary		= ATA_DMA_BOUNDARY,
-	.slave_configure	= ata_scsi_slave_config,
-	.slave_destroy		= ata_scsi_slave_destroy,
-	.bios_param		= ata_std_bios_param,
+	ATA_BMDMA_SHT(DRV_NAME),
 };
 
 static struct ata_port_operations serverworks_osb4_port_ops = {
diff --git a/drivers/ata/pata_sil680.c b/drivers/ata/pata_sil680.c
index ecdaebe..6ebf6f7 100644
--- a/drivers/ata/pata_sil680.c
+++ b/drivers/ata/pata_sil680.c
@@ -192,21 +192,7 @@ static void sil680_set_dmamode(struct ata_port *ap, struct ata_device *adev)
 }
 
 static struct scsi_host_template sil680_sht = {
-	.module			= THIS_MODULE,
-	.name			= DRV_NAME,
-	.ioctl			= ata_scsi_ioctl,
-	.queuecommand		= ata_scsi_queuecmd,
-	.can_queue		= ATA_DEF_QUEUE,
-	.this_id		= ATA_SHT_THIS_ID,
-	.sg_tablesize		= LIBATA_MAX_PRD,
-	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
-	.emulated		= ATA_SHT_EMULATED,
-	.use_clustering		= ATA_SHT_USE_CLUSTERING,
-	.proc_name		= DRV_NAME,
-	.dma_boundary		= ATA_DMA_BOUNDARY,
-	.slave_configure	= ata_scsi_slave_config,
-	.slave_destroy		= ata_scsi_slave_destroy,
-	.bios_param		= ata_std_bios_param,
+	ATA_BMDMA_SHT(DRV_NAME),
 };
 
 static struct ata_port_operations sil680_port_ops = {
diff --git a/drivers/ata/pata_sis.c b/drivers/ata/pata_sis.c
index abda90f..dcd8457 100644
--- a/drivers/ata/pata_sis.c
+++ b/drivers/ata/pata_sis.c
@@ -514,21 +514,7 @@ static void sis_133_set_dmamode (struct ata_port *ap, struct ata_device *adev)
 }
 
 static struct scsi_host_template sis_sht = {
-	.module			= THIS_MODULE,
-	.name			= DRV_NAME,
-	.ioctl			= ata_scsi_ioctl,
-	.queuecommand		= ata_scsi_queuecmd,
-	.can_queue		= ATA_DEF_QUEUE,
-	.this_id		= ATA_SHT_THIS_ID,
-	.sg_tablesize		= LIBATA_MAX_PRD,
-	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
-	.emulated		= ATA_SHT_EMULATED,
-	.use_clustering		= ATA_SHT_USE_CLUSTERING,
-	.proc_name		= DRV_NAME,
-	.dma_boundary		= ATA_DMA_BOUNDARY,
-	.slave_configure	= ata_scsi_slave_config,
-	.slave_destroy		= ata_scsi_slave_destroy,
-	.bios_param		= ata_std_bios_param,
+	ATA_BMDMA_SHT(DRV_NAME),
 };
 
 static const struct ata_port_operations sis_133_ops = {
diff --git a/drivers/ata/pata_sl82c105.c b/drivers/ata/pata_sl82c105.c
index 6c37181..ece366b 100644
--- a/drivers/ata/pata_sl82c105.c
+++ b/drivers/ata/pata_sl82c105.c
@@ -235,21 +235,7 @@ static int sl82c105_qc_defer(struct ata_queued_cmd *qc)
 }
 
 static struct scsi_host_template sl82c105_sht = {
-	.module			= THIS_MODULE,
-	.name			= DRV_NAME,
-	.ioctl			= ata_scsi_ioctl,
-	.queuecommand		= ata_scsi_queuecmd,
-	.can_queue		= ATA_DEF_QUEUE,
-	.this_id		= ATA_SHT_THIS_ID,
-	.sg_tablesize		= LIBATA_MAX_PRD,
-	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
-	.emulated		= ATA_SHT_EMULATED,
-	.use_clustering		= ATA_SHT_USE_CLUSTERING,
-	.proc_name		= DRV_NAME,
-	.dma_boundary		= ATA_DMA_BOUNDARY,
-	.slave_configure	= ata_scsi_slave_config,
-	.slave_destroy		= ata_scsi_slave_destroy,
-	.bios_param		= ata_std_bios_param,
+	ATA_BMDMA_SHT(DRV_NAME),
 };
 
 static struct ata_port_operations sl82c105_port_ops = {
diff --git a/drivers/ata/pata_triflex.c b/drivers/ata/pata_triflex.c
index 403eafc..5105699 100644
--- a/drivers/ata/pata_triflex.c
+++ b/drivers/ata/pata_triflex.c
@@ -180,21 +180,7 @@ static void triflex_bmdma_stop(struct ata_queued_cmd *qc)
 }
 
 static struct scsi_host_template triflex_sht = {
-	.module			= THIS_MODULE,
-	.name			= DRV_NAME,
-	.ioctl			= ata_scsi_ioctl,
-	.queuecommand		= ata_scsi_queuecmd,
-	.can_queue		= ATA_DEF_QUEUE,
-	.this_id		= ATA_SHT_THIS_ID,
-	.sg_tablesize		= LIBATA_MAX_PRD,
-	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
-	.emulated		= ATA_SHT_EMULATED,
-	.use_clustering		= ATA_SHT_USE_CLUSTERING,
-	.proc_name		= DRV_NAME,
-	.dma_boundary		= ATA_DMA_BOUNDARY,
-	.slave_configure	= ata_scsi_slave_config,
-	.slave_destroy		= ata_scsi_slave_destroy,
-	.bios_param		= ata_std_bios_param,
+	ATA_BMDMA_SHT(DRV_NAME),
 };
 
 static struct ata_port_operations triflex_port_ops = {
diff --git a/drivers/ata/pata_via.c b/drivers/ata/pata_via.c
index 24430f7..a7bc860 100644
--- a/drivers/ata/pata_via.c
+++ b/drivers/ata/pata_via.c
@@ -335,21 +335,7 @@ static void via_set_dmamode(struct ata_port *ap, struct ata_device *adev)
 }
 
 static struct scsi_host_template via_sht = {
-	.module			= THIS_MODULE,
-	.name			= DRV_NAME,
-	.ioctl			= ata_scsi_ioctl,
-	.queuecommand		= ata_scsi_queuecmd,
-	.can_queue		= ATA_DEF_QUEUE,
-	.this_id		= ATA_SHT_THIS_ID,
-	.sg_tablesize		= LIBATA_MAX_PRD,
-	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
-	.emulated		= ATA_SHT_EMULATED,
-	.use_clustering		= ATA_SHT_USE_CLUSTERING,
-	.proc_name		= DRV_NAME,
-	.dma_boundary		= ATA_DMA_BOUNDARY,
-	.slave_configure	= ata_scsi_slave_config,
-	.slave_destroy		= ata_scsi_slave_destroy,
-	.bios_param		= ata_std_bios_param,
+	ATA_BMDMA_SHT(DRV_NAME),
 };
 
 static struct ata_port_operations via_port_ops = {
diff --git a/drivers/ata/pata_winbond.c b/drivers/ata/pata_winbond.c
index 5318248..9bafae9 100644
--- a/drivers/ata/pata_winbond.c
+++ b/drivers/ata/pata_winbond.c
@@ -122,21 +122,7 @@ static unsigned int winbond_data_xfer(struct ata_device *dev,
 }
 
 static struct scsi_host_template winbond_sht = {
-	.module			= THIS_MODULE,
-	.name			= DRV_NAME,
-	.ioctl			= ata_scsi_ioctl,
-	.queuecommand		= ata_scsi_queuecmd,
-	.can_queue		= ATA_DEF_QUEUE,
-	.this_id		= ATA_SHT_THIS_ID,
-	.sg_tablesize		= LIBATA_MAX_PRD,
-	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
-	.emulated		= ATA_SHT_EMULATED,
-	.use_clustering		= ATA_SHT_USE_CLUSTERING,
-	.proc_name		= DRV_NAME,
-	.dma_boundary		= ATA_DMA_BOUNDARY,
-	.slave_configure	= ata_scsi_slave_config,
-	.slave_destroy		= ata_scsi_slave_destroy,
-	.bios_param		= ata_std_bios_param,
+	ATA_PIO_SHT(DRV_NAME),
 };
 
 static struct ata_port_operations winbond_port_ops = {
diff --git a/drivers/ata/pdc_adma.c b/drivers/ata/pdc_adma.c
index bc2d12a..fdf62de 100644
--- a/drivers/ata/pdc_adma.c
+++ b/drivers/ata/pdc_adma.c
@@ -143,21 +143,9 @@ static void adma_thaw(struct ata_port *ap);
 static void adma_error_handler(struct ata_port *ap);
 
 static struct scsi_host_template adma_ata_sht = {
-	.module			= THIS_MODULE,
-	.name			= DRV_NAME,
-	.ioctl			= ata_scsi_ioctl,
-	.queuecommand		= ata_scsi_queuecmd,
-	.slave_configure	= ata_scsi_slave_config,
-	.slave_destroy		= ata_scsi_slave_destroy,
-	.bios_param		= ata_std_bios_param,
-	.proc_name		= DRV_NAME,
-	.can_queue		= ATA_DEF_QUEUE,
-	.this_id		= ATA_SHT_THIS_ID,
+	ATA_BASE_SHT(DRV_NAME),
 	.sg_tablesize		= LIBATA_MAX_PRD,
 	.dma_boundary		= ADMA_DMA_BOUNDARY,
-	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
-	.use_clustering		= ENABLE_CLUSTERING,
-	.emulated		= ATA_SHT_EMULATED,
 };
 
 static const struct ata_port_operations adma_ata_ops = {
diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c
index 53ea883..f616ff8 100644
--- a/drivers/ata/sata_fsl.c
+++ b/drivers/ata/sata_fsl.c
@@ -1191,22 +1191,10 @@ static int sata_fsl_init_controller(struct ata_host *host)
  * scsi mid-layer and libata interface structures
  */
 static struct scsi_host_template sata_fsl_sht = {
-	.module = THIS_MODULE,
-	.name = "sata_fsl",
-	.ioctl = ata_scsi_ioctl,
-	.queuecommand = ata_scsi_queuecmd,
-	.change_queue_depth = ata_scsi_change_queue_depth,
+	ATA_NCQ_SHT("sata_fsl"),
 	.can_queue = SATA_FSL_QUEUE_DEPTH,
-	.this_id = ATA_SHT_THIS_ID,
 	.sg_tablesize = SATA_FSL_MAX_PRD_USABLE,
-	.cmd_per_lun = ATA_SHT_CMD_PER_LUN,
-	.emulated = ATA_SHT_EMULATED,
-	.use_clustering = ATA_SHT_USE_CLUSTERING,
-	.proc_name = "sata_fsl",
 	.dma_boundary = ATA_DMA_BOUNDARY,
-	.slave_configure = ata_scsi_slave_config,
-	.slave_destroy = ata_scsi_slave_destroy,
-	.bios_param = ata_std_bios_param,
 };
 
 static const struct ata_port_operations sata_fsl_ops = {
diff --git a/drivers/ata/sata_inic162x.c b/drivers/ata/sata_inic162x.c
index 74f1436..bb853df 100644
--- a/drivers/ata/sata_inic162x.c
+++ b/drivers/ata/sata_inic162x.c
@@ -109,21 +109,7 @@ struct inic_port_priv {
 };
 
 static struct scsi_host_template inic_sht = {
-	.module			= THIS_MODULE,
-	.name			= DRV_NAME,
-	.ioctl			= ata_scsi_ioctl,
-	.queuecommand		= ata_scsi_queuecmd,
-	.can_queue		= ATA_DEF_QUEUE,
-	.this_id		= ATA_SHT_THIS_ID,
-	.sg_tablesize		= LIBATA_MAX_PRD,
-	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
-	.emulated		= ATA_SHT_EMULATED,
-	.use_clustering		= ATA_SHT_USE_CLUSTERING,
-	.proc_name		= DRV_NAME,
-	.dma_boundary		= ATA_DMA_BOUNDARY,
-	.slave_configure	= ata_scsi_slave_config,
-	.slave_destroy		= ata_scsi_slave_destroy,
-	.bios_param		= ata_std_bios_param,
+	ATA_BMDMA_SHT(DRV_NAME),
 };
 
 static const int scr_map[] = {
diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
index 4685bce..52d41ed 100644
--- a/drivers/ata/sata_mv.c
+++ b/drivers/ata/sata_mv.c
@@ -514,40 +514,16 @@ static int __mv_stop_dma(struct ata_port *ap);
  * PRDs for 64K boundaries in mv_fill_sg().
  */
 static struct scsi_host_template mv5_sht = {
-	.module			= THIS_MODULE,
-	.name			= DRV_NAME,
-	.ioctl			= ata_scsi_ioctl,
-	.queuecommand		= ata_scsi_queuecmd,
-	.can_queue		= ATA_DEF_QUEUE,
-	.this_id		= ATA_SHT_THIS_ID,
+	ATA_BASE_SHT(DRV_NAME),
 	.sg_tablesize		= MV_MAX_SG_CT / 2,
-	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
-	.emulated		= ATA_SHT_EMULATED,
-	.use_clustering		= 1,
-	.proc_name		= DRV_NAME,
 	.dma_boundary		= MV_DMA_BOUNDARY,
-	.slave_configure	= ata_scsi_slave_config,
-	.slave_destroy		= ata_scsi_slave_destroy,
-	.bios_param		= ata_std_bios_param,
 };
 
 static struct scsi_host_template mv6_sht = {
-	.module			= THIS_MODULE,
-	.name			= DRV_NAME,
-	.ioctl			= ata_scsi_ioctl,
-	.queuecommand		= ata_scsi_queuecmd,
-	.change_queue_depth	= ata_scsi_change_queue_depth,
+	ATA_NCQ_SHT(DRV_NAME),
 	.can_queue		= MV_MAX_Q_DEPTH - 1,
-	.this_id		= ATA_SHT_THIS_ID,
 	.sg_tablesize		= MV_MAX_SG_CT / 2,
-	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
-	.emulated		= ATA_SHT_EMULATED,
-	.use_clustering		= 1,
-	.proc_name		= DRV_NAME,
 	.dma_boundary		= MV_DMA_BOUNDARY,
-	.slave_configure	= ata_scsi_slave_config,
-	.slave_destroy		= ata_scsi_slave_destroy,
-	.bios_param		= ata_std_bios_param,
 };
 
 static const struct ata_port_operations mv5_ops = {
diff --git a/drivers/ata/sata_nv.c b/drivers/ata/sata_nv.c
index bd5b6c3..9e2b4ce 100644
--- a/drivers/ata/sata_nv.c
+++ b/drivers/ata/sata_nv.c
@@ -385,59 +385,23 @@ static struct pci_driver nv_pci_driver = {
 };
 
 static struct scsi_host_template nv_sht = {
-	.module			= THIS_MODULE,
-	.name			= DRV_NAME,
-	.ioctl			= ata_scsi_ioctl,
-	.queuecommand		= ata_scsi_queuecmd,
-	.can_queue		= ATA_DEF_QUEUE,
-	.this_id		= ATA_SHT_THIS_ID,
-	.sg_tablesize		= LIBATA_MAX_PRD,
-	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
-	.emulated		= ATA_SHT_EMULATED,
-	.use_clustering		= ATA_SHT_USE_CLUSTERING,
-	.proc_name		= DRV_NAME,
-	.dma_boundary		= ATA_DMA_BOUNDARY,
-	.slave_configure	= ata_scsi_slave_config,
-	.slave_destroy		= ata_scsi_slave_destroy,
-	.bios_param		= ata_std_bios_param,
+	ATA_BMDMA_SHT(DRV_NAME),
 };
 
 static struct scsi_host_template nv_adma_sht = {
-	.module			= THIS_MODULE,
-	.name			= DRV_NAME,
-	.ioctl			= ata_scsi_ioctl,
-	.queuecommand		= ata_scsi_queuecmd,
-	.change_queue_depth	= ata_scsi_change_queue_depth,
+	ATA_NCQ_SHT(DRV_NAME),
 	.can_queue		= NV_ADMA_MAX_CPBS,
-	.this_id		= ATA_SHT_THIS_ID,
 	.sg_tablesize		= NV_ADMA_SGTBL_TOTAL_LEN,
-	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
-	.emulated		= ATA_SHT_EMULATED,
-	.use_clustering		= ATA_SHT_USE_CLUSTERING,
-	.proc_name		= DRV_NAME,
 	.dma_boundary		= NV_ADMA_DMA_BOUNDARY,
 	.slave_configure	= nv_adma_slave_config,
-	.slave_destroy		= ata_scsi_slave_destroy,
-	.bios_param		= ata_std_bios_param,
 };
 
 static struct scsi_host_template nv_swncq_sht = {
-	.module			= THIS_MODULE,
-	.name			= DRV_NAME,
-	.ioctl			= ata_scsi_ioctl,
-	.queuecommand		= ata_scsi_queuecmd,
-	.change_queue_depth	= ata_scsi_change_queue_depth,
+	ATA_NCQ_SHT(DRV_NAME),
 	.can_queue		= ATA_MAX_QUEUE,
-	.this_id		= ATA_SHT_THIS_ID,
 	.sg_tablesize		= LIBATA_MAX_PRD,
-	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
-	.emulated		= ATA_SHT_EMULATED,
-	.use_clustering		= ATA_SHT_USE_CLUSTERING,
-	.proc_name		= DRV_NAME,
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= nv_swncq_slave_config,
-	.slave_destroy		= ata_scsi_slave_destroy,
-	.bios_param		= ata_std_bios_param,
 };
 
 static const struct ata_port_operations nv_generic_ops = {
diff --git a/drivers/ata/sata_promise.c b/drivers/ata/sata_promise.c
index f251a5f..a6d0196 100644
--- a/drivers/ata/sata_promise.c
+++ b/drivers/ata/sata_promise.c
@@ -153,21 +153,9 @@ static int pdc_pata_cable_detect(struct ata_port *ap);
 static int pdc_sata_cable_detect(struct ata_port *ap);
 
 static struct scsi_host_template pdc_ata_sht = {
-	.module			= THIS_MODULE,
-	.name			= DRV_NAME,
-	.ioctl			= ata_scsi_ioctl,
-	.queuecommand		= ata_scsi_queuecmd,
-	.can_queue		= ATA_DEF_QUEUE,
-	.this_id		= ATA_SHT_THIS_ID,
+	ATA_BASE_SHT(DRV_NAME),
 	.sg_tablesize		= PDC_MAX_PRD,
-	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
-	.emulated		= ATA_SHT_EMULATED,
-	.use_clustering		= ATA_SHT_USE_CLUSTERING,
-	.proc_name		= DRV_NAME,
 	.dma_boundary		= ATA_DMA_BOUNDARY,
-	.slave_configure	= ata_scsi_slave_config,
-	.slave_destroy		= ata_scsi_slave_destroy,
-	.bios_param		= ata_std_bios_param,
 };
 
 static const struct ata_port_operations pdc_sata_ops = {
diff --git a/drivers/ata/sata_qstor.c b/drivers/ata/sata_qstor.c
index 3c8e97f..2566d09 100644
--- a/drivers/ata/sata_qstor.c
+++ b/drivers/ata/sata_qstor.c
@@ -126,21 +126,9 @@ static void qs_thaw(struct ata_port *ap);
 static void qs_error_handler(struct ata_port *ap);
 
 static struct scsi_host_template qs_ata_sht = {
-	.module			= THIS_MODULE,
-	.name			= DRV_NAME,
-	.ioctl			= ata_scsi_ioctl,
-	.queuecommand		= ata_scsi_queuecmd,
-	.can_queue		= ATA_DEF_QUEUE,
-	.this_id		= ATA_SHT_THIS_ID,
+	ATA_BASE_SHT(DRV_NAME),
 	.sg_tablesize		= QS_MAX_PRD,
-	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
-	.emulated		= ATA_SHT_EMULATED,
-	.use_clustering		= ENABLE_CLUSTERING,
-	.proc_name		= DRV_NAME,
 	.dma_boundary		= QS_DMA_BOUNDARY,
-	.slave_configure	= ata_scsi_slave_config,
-	.slave_destroy		= ata_scsi_slave_destroy,
-	.bios_param		= ata_std_bios_param,
 };
 
 static const struct ata_port_operations qs_ata_ops = {
diff --git a/drivers/ata/sata_sil.c b/drivers/ata/sata_sil.c
index 53f0bae..738c1a8 100644
--- a/drivers/ata/sata_sil.c
+++ b/drivers/ata/sata_sil.c
@@ -167,21 +167,7 @@ static struct pci_driver sil_pci_driver = {
 };
 
 static struct scsi_host_template sil_sht = {
-	.module			= THIS_MODULE,
-	.name			= DRV_NAME,
-	.ioctl			= ata_scsi_ioctl,
-	.queuecommand		= ata_scsi_queuecmd,
-	.can_queue		= ATA_DEF_QUEUE,
-	.this_id		= ATA_SHT_THIS_ID,
-	.sg_tablesize		= LIBATA_MAX_PRD,
-	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
-	.emulated		= ATA_SHT_EMULATED,
-	.use_clustering		= ATA_SHT_USE_CLUSTERING,
-	.proc_name		= DRV_NAME,
-	.dma_boundary		= ATA_DMA_BOUNDARY,
-	.slave_configure	= ata_scsi_slave_config,
-	.slave_destroy		= ata_scsi_slave_destroy,
-	.bios_param		= ata_std_bios_param,
+	ATA_BMDMA_SHT(DRV_NAME),
 };
 
 static const struct ata_port_operations sil_ops = {
diff --git a/drivers/ata/sata_sil24.c b/drivers/ata/sata_sil24.c
index b85464d..7fa6395 100644
--- a/drivers/ata/sata_sil24.c
+++ b/drivers/ata/sata_sil24.c
@@ -384,22 +384,10 @@ static struct pci_driver sil24_pci_driver = {
 };
 
 static struct scsi_host_template sil24_sht = {
-	.module			= THIS_MODULE,
-	.name			= DRV_NAME,
-	.ioctl			= ata_scsi_ioctl,
-	.queuecommand		= ata_scsi_queuecmd,
-	.change_queue_depth	= ata_scsi_change_queue_depth,
+	ATA_NCQ_SHT(DRV_NAME),
 	.can_queue		= SIL24_MAX_CMDS,
-	.this_id		= ATA_SHT_THIS_ID,
 	.sg_tablesize		= SIL24_MAX_SGE,
-	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
-	.emulated		= ATA_SHT_EMULATED,
-	.use_clustering		= ATA_SHT_USE_CLUSTERING,
-	.proc_name		= DRV_NAME,
 	.dma_boundary		= ATA_DMA_BOUNDARY,
-	.slave_configure	= ata_scsi_slave_config,
-	.slave_destroy		= ata_scsi_slave_destroy,
-	.bios_param		= ata_std_bios_param,
 };
 
 static const struct ata_port_operations sil24_ops = {
diff --git a/drivers/ata/sata_sis.c b/drivers/ata/sata_sis.c
index a8adef9..4becb7f 100644
--- a/drivers/ata/sata_sis.c
+++ b/drivers/ata/sata_sis.c
@@ -86,21 +86,7 @@ static struct pci_driver sis_pci_driver = {
 };
 
 static struct scsi_host_template sis_sht = {
-	.module			= THIS_MODULE,
-	.name			= DRV_NAME,
-	.ioctl			= ata_scsi_ioctl,
-	.queuecommand		= ata_scsi_queuecmd,
-	.can_queue		= ATA_DEF_QUEUE,
-	.this_id		= ATA_SHT_THIS_ID,
-	.sg_tablesize		= LIBATA_MAX_PRD,
-	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
-	.emulated		= ATA_SHT_EMULATED,
-	.use_clustering		= ATA_SHT_USE_CLUSTERING,
-	.proc_name		= DRV_NAME,
-	.dma_boundary		= ATA_DMA_BOUNDARY,
-	.slave_configure	= ata_scsi_slave_config,
-	.slave_destroy		= ata_scsi_slave_destroy,
-	.bios_param		= ata_std_bios_param,
+	ATA_BMDMA_SHT(DRV_NAME),
 };
 
 static const struct ata_port_operations sis_ops = {
diff --git a/drivers/ata/sata_svw.c b/drivers/ata/sata_svw.c
index 5ee0abb..b87343b 100644
--- a/drivers/ata/sata_svw.c
+++ b/drivers/ata/sata_svw.c
@@ -327,24 +327,10 @@ static int k2_sata_proc_info(struct Scsi_Host *shost, char *page, char **start,
 
 
 static struct scsi_host_template k2_sata_sht = {
-	.module			= THIS_MODULE,
-	.name			= DRV_NAME,
-	.ioctl			= ata_scsi_ioctl,
-	.queuecommand		= ata_scsi_queuecmd,
-	.can_queue		= ATA_DEF_QUEUE,
-	.this_id		= ATA_SHT_THIS_ID,
-	.sg_tablesize		= LIBATA_MAX_PRD,
-	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
-	.emulated		= ATA_SHT_EMULATED,
-	.use_clustering		= ATA_SHT_USE_CLUSTERING,
-	.proc_name		= DRV_NAME,
-	.dma_boundary		= ATA_DMA_BOUNDARY,
-	.slave_configure	= ata_scsi_slave_config,
-	.slave_destroy		= ata_scsi_slave_destroy,
+	ATA_BMDMA_SHT(DRV_NAME),
 #ifdef CONFIG_PPC_OF
 	.proc_info		= k2_sata_proc_info,
 #endif
-	.bios_param		= ata_std_bios_param,
 };
 
 
diff --git a/drivers/ata/sata_sx4.c b/drivers/ata/sata_sx4.c
index e3d56bc..1802f92 100644
--- a/drivers/ata/sata_sx4.c
+++ b/drivers/ata/sata_sx4.c
@@ -236,21 +236,9 @@ static unsigned int pdc20621_qc_issue_prot(struct ata_queued_cmd *qc);
 
 
 static struct scsi_host_template pdc_sata_sht = {
-	.module			= THIS_MODULE,
-	.name			= DRV_NAME,
-	.ioctl			= ata_scsi_ioctl,
-	.queuecommand		= ata_scsi_queuecmd,
-	.can_queue		= ATA_DEF_QUEUE,
-	.this_id		= ATA_SHT_THIS_ID,
+	ATA_BASE_SHT(DRV_NAME),
 	.sg_tablesize		= LIBATA_MAX_PRD,
-	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
-	.emulated		= ATA_SHT_EMULATED,
-	.use_clustering		= ATA_SHT_USE_CLUSTERING,
-	.proc_name		= DRV_NAME,
 	.dma_boundary		= ATA_DMA_BOUNDARY,
-	.slave_configure	= ata_scsi_slave_config,
-	.slave_destroy		= ata_scsi_slave_destroy,
-	.bios_param		= ata_std_bios_param,
 };
 
 static const struct ata_port_operations pdc_20621_ops = {
diff --git a/drivers/ata/sata_uli.c b/drivers/ata/sata_uli.c
index f7fc045..764d706 100644
--- a/drivers/ata/sata_uli.c
+++ b/drivers/ata/sata_uli.c
@@ -76,21 +76,7 @@ static struct pci_driver uli_pci_driver = {
 };
 
 static struct scsi_host_template uli_sht = {
-	.module			= THIS_MODULE,
-	.name			= DRV_NAME,
-	.ioctl			= ata_scsi_ioctl,
-	.queuecommand		= ata_scsi_queuecmd,
-	.can_queue		= ATA_DEF_QUEUE,
-	.this_id		= ATA_SHT_THIS_ID,
-	.sg_tablesize		= LIBATA_MAX_PRD,
-	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
-	.emulated		= ATA_SHT_EMULATED,
-	.use_clustering		= ATA_SHT_USE_CLUSTERING,
-	.proc_name		= DRV_NAME,
-	.dma_boundary		= ATA_DMA_BOUNDARY,
-	.slave_configure	= ata_scsi_slave_config,
-	.slave_destroy		= ata_scsi_slave_destroy,
-	.bios_param		= ata_std_bios_param,
+	ATA_BMDMA_SHT(DRV_NAME),
 };
 
 static const struct ata_port_operations uli_ops = {
diff --git a/drivers/ata/sata_via.c b/drivers/ata/sata_via.c
index f66ffd7..9be877c 100644
--- a/drivers/ata/sata_via.c
+++ b/drivers/ata/sata_via.c
@@ -100,21 +100,7 @@ static struct pci_driver svia_pci_driver = {
 };
 
 static struct scsi_host_template svia_sht = {
-	.module			= THIS_MODULE,
-	.name			= DRV_NAME,
-	.ioctl			= ata_scsi_ioctl,
-	.queuecommand		= ata_scsi_queuecmd,
-	.can_queue		= ATA_DEF_QUEUE,
-	.this_id		= ATA_SHT_THIS_ID,
-	.sg_tablesize		= LIBATA_MAX_PRD,
-	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
-	.emulated		= ATA_SHT_EMULATED,
-	.use_clustering		= ATA_SHT_USE_CLUSTERING,
-	.proc_name		= DRV_NAME,
-	.dma_boundary		= ATA_DMA_BOUNDARY,
-	.slave_configure	= ata_scsi_slave_config,
-	.slave_destroy		= ata_scsi_slave_destroy,
-	.bios_param		= ata_std_bios_param,
+	ATA_BMDMA_SHT(DRV_NAME),
 };
 
 static const struct ata_port_operations vt6420_sata_ops = {
diff --git a/drivers/ata/sata_vsc.c b/drivers/ata/sata_vsc.c
index 099a2ba..fd6855f 100644
--- a/drivers/ata/sata_vsc.c
+++ b/drivers/ata/sata_vsc.c
@@ -300,21 +300,7 @@ out:
 
 
 static struct scsi_host_template vsc_sata_sht = {
-	.module			= THIS_MODULE,
-	.name			= DRV_NAME,
-	.ioctl			= ata_scsi_ioctl,
-	.queuecommand		= ata_scsi_queuecmd,
-	.can_queue		= ATA_DEF_QUEUE,
-	.this_id		= ATA_SHT_THIS_ID,
-	.sg_tablesize		= LIBATA_MAX_PRD,
-	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
-	.emulated		= ATA_SHT_EMULATED,
-	.use_clustering		= ATA_SHT_USE_CLUSTERING,
-	.proc_name		= DRV_NAME,
-	.dma_boundary		= ATA_DMA_BOUNDARY,
-	.slave_configure	= ata_scsi_slave_config,
-	.slave_destroy		= ata_scsi_slave_destroy,
-	.bios_param		= ata_std_bios_param,
+	ATA_BMDMA_SHT(DRV_NAME),
 };
 
 
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 7e211cd..45c40a2 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -1068,6 +1068,63 @@ extern void ata_do_eh(struct ata_port *ap, ata_prereset_fn_t prereset,
 		      ata_postreset_fn_t postreset);
 
 /*
+ * Base operations to inherit from and initializers for sht
+ *
+ * Operations
+ *
+ * base  : Common to all libata drivers.
+ * sata  : SATA controllers w/ native interface.
+ * pmp   : SATA controllers w/ PMP support.
+ * sff   : SFF ATA controllers w/o BMDMA support.
+ * bmdma : SFF ATA controllers w/ BMDMA support.
+ *
+ * sht initializers
+ *
+ * BASE  : Common to all libata drivers.  The user must set
+ *	   sg_tablesize and dma_boundary.
+ * PIO   : SFF ATA controllers w/ only PIO support.
+ * BMDMA : SFF ATA controllers w/ BMDMA support.  sg_tablesize and
+ *	   dma_boundary are set to BMDMA limits.
+ * NCQ   : SATA controllers supporting NCQ.  The user must set
+ *	   sg_tablesize, dma_boundary and can_queue.
+ */
+extern const struct ata_port_operations ata_base_port_ops;
+extern const struct ata_port_operations sata_port_ops;
+extern const struct ata_port_operations sata_pmp_port_ops;
+extern const struct ata_port_operations ata_sff_port_ops;
+extern const struct ata_port_operations ata_bmdma_port_ops;
+
+#define ATA_BASE_SHT(drv_name)					\
+	.module			= THIS_MODULE,			\
+	.name			= drv_name,			\
+	.ioctl			= ata_scsi_ioctl,		\
+	.queuecommand		= ata_scsi_queuecmd,		\
+	.can_queue		= ATA_DEF_QUEUE,		\
+	.this_id		= ATA_SHT_THIS_ID,		\
+	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,		\
+	.emulated		= ATA_SHT_EMULATED,		\
+	.use_clustering		= ATA_SHT_USE_CLUSTERING,	\
+	.proc_name		= drv_name,			\
+	.slave_configure	= ata_scsi_slave_config,	\
+	.slave_destroy		= ata_scsi_slave_destroy,	\
+	.bios_param		= ata_std_bios_param
+
+/* PIO only, sg_tablesize and dma_boundary limits can be removed */
+#define ATA_PIO_SHT(drv_name)					\
+	ATA_BASE_SHT(drv_name),					\
+	.sg_tablesize		= LIBATA_MAX_PRD,		\
+	.dma_boundary		= ATA_DMA_BOUNDARY
+
+#define ATA_BMDMA_SHT(drv_name)					\
+	ATA_BASE_SHT(drv_name),					\
+	.sg_tablesize		= LIBATA_MAX_PRD,		\
+	.dma_boundary		= ATA_DMA_BOUNDARY
+
+#define ATA_NCQ_SHT(drv_name)					\
+	ATA_BASE_SHT(drv_name),					\
+	.change_queue_depth	= ata_scsi_change_queue_depth
+
+/*
  * printk helpers
  */
 #define ata_port_printk(ap, lv, fmt, args...) \
-- 
1.5.2.4

