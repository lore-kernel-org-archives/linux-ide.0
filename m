From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] libata: fix scsi_host_template in drivers
Date: Wed, 22 Nov 2006 15:04:11 +0900
Message-ID: <20061122060411.GW2184@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.173]:63000 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1756907AbWKVGEV (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 22 Nov 2006 01:04:21 -0500
Received: by ug-out-1314.google.com with SMTP id 44so76221uga
        for <linux-ide@vger.kernel.org>; Tue, 21 Nov 2006 22:04:20 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

This patch fixes the followings regarding sht usage in libata drivers.

* sht->max_sectors is overrided unconditionally in ->slave_configure.
  There's no reason to set it to any value.

* Many LLDs are missing sht->slave_destroy.  The method is mandatory
  to support device warm unplugging (echo 1 > /sys/.../delete).
  Without it, libata might access released scsi device.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---

Another candidate for #upstream-fixes.

 drivers/ata/ata_generic.c       |    2 +-
 drivers/ata/pata_ali.c          |    4 +---
 drivers/ata/pata_amd.c          |    2 +-
 drivers/ata/pata_artop.c        |    2 +-
 drivers/ata/pata_atiixp.c       |    2 +-
 drivers/ata/pata_cmd64x.c       |    2 +-
 drivers/ata/pata_cs5520.c       |    2 +-
 drivers/ata/pata_cs5530.c       |    2 +-
 drivers/ata/pata_cs5535.c       |    2 +-
 drivers/ata/pata_cypress.c      |    2 +-
 drivers/ata/pata_efar.c         |    2 +-
 drivers/ata/pata_hpt366.c       |    2 +-
 drivers/ata/pata_hpt37x.c       |    2 +-
 drivers/ata/pata_hpt3x2n.c      |    2 +-
 drivers/ata/pata_hpt3x3.c       |    2 +-
 drivers/ata/pata_isapnp.c       |    2 +-
 drivers/ata/pata_it821x.c       |    4 +---
 drivers/ata/pata_ixp4xx_cf.c    |    2 +-
 drivers/ata/pata_jmicron.c      |    3 +--
 drivers/ata/pata_legacy.c       |    2 +-
 drivers/ata/pata_marvell.c      |    2 +-
 drivers/ata/pata_mpiix.c        |    2 +-
 drivers/ata/pata_netcell.c      |    3 +--
 drivers/ata/pata_ns87410.c      |    2 +-
 drivers/ata/pata_oldpiix.c      |    2 +-
 drivers/ata/pata_opti.c         |    2 +-
 drivers/ata/pata_optidma.c      |    2 +-
 drivers/ata/pata_pcmcia.c       |    2 +-
 drivers/ata/pata_pdc2027x.c     |    2 +-
 drivers/ata/pata_pdc202xx_old.c |    2 +-
 drivers/ata/pata_platform.c     |    2 +-
 drivers/ata/pata_qdi.c          |    2 +-
 drivers/ata/pata_radisys.c      |    2 +-
 drivers/ata/pata_rz1000.c       |    2 +-
 drivers/ata/pata_sc1200.c       |    2 +-
 drivers/ata/pata_serverworks.c  |    2 +-
 drivers/ata/pata_sil680.c       |    2 +-
 drivers/ata/pata_sis.c          |    2 +-
 drivers/ata/pata_sl82c105.c     |    2 +-
 drivers/ata/pata_triflex.c      |    2 +-
 drivers/ata/pata_via.c          |    2 +-
 drivers/ata/pata_winbond.c      |    2 +-
 drivers/ata/sata_nv.c           |    1 -
 43 files changed, 42 insertions(+), 49 deletions(-)

diff --git a/drivers/ata/ata_generic.c b/drivers/ata/ata_generic.c
index 75e0bb5..b35a375 100644
--- a/drivers/ata/ata_generic.c
+++ b/drivers/ata/ata_generic.c
@@ -109,13 +109,13 @@ static struct scsi_host_template generic
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
 
diff --git a/drivers/ata/pata_ali.c b/drivers/ata/pata_ali.c
index 9860178..ebe2b88 100644
--- a/drivers/ata/pata_ali.c
+++ b/drivers/ata/pata_ali.c
@@ -337,15 +337,13 @@ static struct scsi_host_template ali_sht
 	.can_queue		= ATA_DEF_QUEUE,
 	.this_id		= ATA_SHT_THIS_ID,
 	.sg_tablesize		= LIBATA_MAX_PRD,
-	/* Keep LBA28 counts so large I/O's don't turn LBA48 and PIO
-	   with older controllers. Not locked so will grow on C5 or later */
-	.max_sectors		= 255,
 	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
 	.emulated		= ATA_SHT_EMULATED,
 	.use_clustering		= ATA_SHT_USE_CLUSTERING,
 	.proc_name		= DRV_NAME,
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
+	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
 };
 
diff --git a/drivers/ata/pata_amd.c b/drivers/ata/pata_amd.c
index 5c47a9e..c14abca 100644
--- a/drivers/ata/pata_amd.c
+++ b/drivers/ata/pata_amd.c
@@ -326,13 +326,13 @@ static struct scsi_host_template amd_sht
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
 
diff --git a/drivers/ata/pata_artop.c b/drivers/ata/pata_artop.c
index 96a0980..37bc132 100644
--- a/drivers/ata/pata_artop.c
+++ b/drivers/ata/pata_artop.c
@@ -307,13 +307,13 @@ static struct scsi_host_template artop_s
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
 
diff --git a/drivers/ata/pata_atiixp.c b/drivers/ata/pata_atiixp.c
index 1ce28d2..a6e7a08 100644
--- a/drivers/ata/pata_atiixp.c
+++ b/drivers/ata/pata_atiixp.c
@@ -209,13 +209,13 @@ static struct scsi_host_template atiixp_
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
 
diff --git a/drivers/ata/pata_cmd64x.c b/drivers/ata/pata_cmd64x.c
index b9bbd1d..a98217f 100644
--- a/drivers/ata/pata_cmd64x.c
+++ b/drivers/ata/pata_cmd64x.c
@@ -268,13 +268,13 @@ static struct scsi_host_template cmd64x_
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
 
diff --git a/drivers/ata/pata_cs5520.c b/drivers/ata/pata_cs5520.c
index 2cd3c0f..a3b129c 100644
--- a/drivers/ata/pata_cs5520.c
+++ b/drivers/ata/pata_cs5520.c
@@ -159,13 +159,13 @@ static struct scsi_host_template cs5520_
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
 
diff --git a/drivers/ata/pata_cs5530.c b/drivers/ata/pata_cs5530.c
index a07cc81..c3d2900 100644
--- a/drivers/ata/pata_cs5530.c
+++ b/drivers/ata/pata_cs5530.c
@@ -173,13 +173,13 @@ static struct scsi_host_template cs5530_
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
 
diff --git a/drivers/ata/pata_cs5535.c b/drivers/ata/pata_cs5535.c
index f8def3f..370355c 100644
--- a/drivers/ata/pata_cs5535.c
+++ b/drivers/ata/pata_cs5535.c
@@ -177,13 +177,13 @@ static struct scsi_host_template cs5535_
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
 
diff --git a/drivers/ata/pata_cypress.c b/drivers/ata/pata_cypress.c
index 247b436..b373efd 100644
--- a/drivers/ata/pata_cypress.c
+++ b/drivers/ata/pata_cypress.c
@@ -128,13 +128,13 @@ static struct scsi_host_template cy82c69
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
 
diff --git a/drivers/ata/pata_efar.c b/drivers/ata/pata_efar.c
index ef18c60..4b4f31a 100644
--- a/drivers/ata/pata_efar.c
+++ b/drivers/ata/pata_efar.c
@@ -226,13 +226,13 @@ static struct scsi_host_template efar_sh
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
 
diff --git a/drivers/ata/pata_hpt366.c b/drivers/ata/pata_hpt366.c
index 6d3e4c0..06782f8 100644
--- a/drivers/ata/pata_hpt366.c
+++ b/drivers/ata/pata_hpt366.c
@@ -322,13 +322,13 @@ static struct scsi_host_template hpt36x_
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
 
diff --git a/drivers/ata/pata_hpt37x.c b/drivers/ata/pata_hpt37x.c
index fce3fcd..47082df 100644
--- a/drivers/ata/pata_hpt37x.c
+++ b/drivers/ata/pata_hpt37x.c
@@ -768,13 +768,13 @@ static struct scsi_host_template hpt37x_
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
 
diff --git a/drivers/ata/pata_hpt3x2n.c b/drivers/ata/pata_hpt3x2n.c
index 58cfb2b..f6817b4 100644
--- a/drivers/ata/pata_hpt3x2n.c
+++ b/drivers/ata/pata_hpt3x2n.c
@@ -334,13 +334,13 @@ static struct scsi_host_template hpt3x2n
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
 
diff --git a/drivers/ata/pata_hpt3x3.c b/drivers/ata/pata_hpt3x3.c
index 3334d72..6fe5ff3 100644
--- a/drivers/ata/pata_hpt3x3.c
+++ b/drivers/ata/pata_hpt3x3.c
@@ -111,13 +111,13 @@ static struct scsi_host_template hpt3x3_
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
 
diff --git a/drivers/ata/pata_isapnp.c b/drivers/ata/pata_isapnp.c
index 640b8b0..a97d55a 100644
--- a/drivers/ata/pata_isapnp.c
+++ b/drivers/ata/pata_isapnp.c
@@ -27,13 +27,13 @@ static struct scsi_host_template isapnp_
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
 
diff --git a/drivers/ata/pata_it821x.c b/drivers/ata/pata_it821x.c
index 18ff3e5..d2c6247 100644
--- a/drivers/ata/pata_it821x.c
+++ b/drivers/ata/pata_it821x.c
@@ -666,15 +666,13 @@ static struct scsi_host_template it821x_
 	.can_queue		= ATA_DEF_QUEUE,
 	.this_id		= ATA_SHT_THIS_ID,
 	.sg_tablesize		= LIBATA_MAX_PRD,
-	/* 255 sectors to begin with. This is locked in smart mode but not
-	   in pass through */
-	.max_sectors		= 255,
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
index d2268bf..cb89241 100644
--- a/drivers/ata/pata_ixp4xx_cf.c
+++ b/drivers/ata/pata_ixp4xx_cf.c
@@ -110,13 +110,13 @@ static struct scsi_host_template ixp4xx_
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
 
diff --git a/drivers/ata/pata_jmicron.c b/drivers/ata/pata_jmicron.c
index 52a2bdf..bb0a47c 100644
--- a/drivers/ata/pata_jmicron.c
+++ b/drivers/ata/pata_jmicron.c
@@ -128,14 +128,13 @@ static struct scsi_host_template jmicron
 	.can_queue		= ATA_DEF_QUEUE,
 	.this_id		= ATA_SHT_THIS_ID,
 	.sg_tablesize		= LIBATA_MAX_PRD,
-	/* Special handling needed if you have sector or LBA48 limits */
-	.max_sectors		= ATA_MAX_SECTORS,
 	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
 	.emulated		= ATA_SHT_EMULATED,
 	.use_clustering		= ATA_SHT_USE_CLUSTERING,
 	.proc_name		= DRV_NAME,
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
+	.slave_destroy		= ata_scsi_slave_destroy,
 	/* Use standard CHS mapping rules */
 	.bios_param		= ata_std_bios_param,
 };
diff --git a/drivers/ata/pata_legacy.c b/drivers/ata/pata_legacy.c
index 10231ef..c7d1738 100644
--- a/drivers/ata/pata_legacy.c
+++ b/drivers/ata/pata_legacy.c
@@ -128,13 +128,13 @@ static struct scsi_host_template legacy_
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
 
diff --git a/drivers/ata/pata_marvell.c b/drivers/ata/pata_marvell.c
index 1ea6407..beadef5 100644
--- a/drivers/ata/pata_marvell.c
+++ b/drivers/ata/pata_marvell.c
@@ -94,13 +94,13 @@ static struct scsi_host_template marvell
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
 	/* Use standard CHS mapping rules */
 	.bios_param		= ata_std_bios_param,
 };
diff --git a/drivers/ata/pata_mpiix.c b/drivers/ata/pata_mpiix.c
index 9dfe3e9..976b1cb 100644
--- a/drivers/ata/pata_mpiix.c
+++ b/drivers/ata/pata_mpiix.c
@@ -159,13 +159,13 @@ static struct scsi_host_template mpiix_s
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
 
diff --git a/drivers/ata/pata_netcell.c b/drivers/ata/pata_netcell.c
index f5672de..b2a4a4d 100644
--- a/drivers/ata/pata_netcell.c
+++ b/drivers/ata/pata_netcell.c
@@ -54,14 +54,13 @@ static struct scsi_host_template netcell
 	.can_queue		= ATA_DEF_QUEUE,
 	.this_id		= ATA_SHT_THIS_ID,
 	.sg_tablesize		= LIBATA_MAX_PRD,
-	/* Special handling needed if you have sector or LBA48 limits */
-	.max_sectors		= ATA_MAX_SECTORS,
 	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
 	.emulated		= ATA_SHT_EMULATED,
 	.use_clustering		= ATA_SHT_USE_CLUSTERING,
 	.proc_name		= DRV_NAME,
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
+	.slave_destroy		= ata_scsi_slave_destroy,
 	/* Use standard CHS mapping rules */
 	.bios_param		= ata_std_bios_param,
 };
diff --git a/drivers/ata/pata_ns87410.c b/drivers/ata/pata_ns87410.c
index 2a3dbee..383900b 100644
--- a/drivers/ata/pata_ns87410.c
+++ b/drivers/ata/pata_ns87410.c
@@ -149,13 +149,13 @@ static struct scsi_host_template ns87410
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
 
diff --git a/drivers/ata/pata_oldpiix.c b/drivers/ata/pata_oldpiix.c
index fc947df..8f379e9 100644
--- a/drivers/ata/pata_oldpiix.c
+++ b/drivers/ata/pata_oldpiix.c
@@ -224,13 +224,13 @@ static struct scsi_host_template oldpiix
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
 
diff --git a/drivers/ata/pata_opti.c b/drivers/ata/pata_opti.c
index a7320ba..78e4e8a 100644
--- a/drivers/ata/pata_opti.c
+++ b/drivers/ata/pata_opti.c
@@ -195,13 +195,13 @@ static struct scsi_host_template opti_sh
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
 
diff --git a/drivers/ata/pata_optidma.c b/drivers/ata/pata_optidma.c
index c6906b4..a2648bf 100644
--- a/drivers/ata/pata_optidma.c
+++ b/drivers/ata/pata_optidma.c
@@ -352,13 +352,13 @@ static struct scsi_host_template optidma
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
 
diff --git a/drivers/ata/pata_pcmcia.c b/drivers/ata/pata_pcmcia.c
index e93ea27..4ca6fa5 100644
--- a/drivers/ata/pata_pcmcia.c
+++ b/drivers/ata/pata_pcmcia.c
@@ -62,13 +62,13 @@ static struct scsi_host_template pcmcia_
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
 
diff --git a/drivers/ata/pata_pdc2027x.c b/drivers/ata/pata_pdc2027x.c
index 56e0287..76dd1c9 100644
--- a/drivers/ata/pata_pdc2027x.c
+++ b/drivers/ata/pata_pdc2027x.c
@@ -134,13 +134,13 @@ static struct scsi_host_template pdc2027
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
 
diff --git a/drivers/ata/pata_pdc202xx_old.c b/drivers/ata/pata_pdc202xx_old.c
index 450c6a1..da0d467 100644
--- a/drivers/ata/pata_pdc202xx_old.c
+++ b/drivers/ata/pata_pdc202xx_old.c
@@ -262,13 +262,13 @@ static struct scsi_host_template pdc202x
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
 
diff --git a/drivers/ata/pata_platform.c b/drivers/ata/pata_platform.c
index 63d6687..443b1d8 100644
--- a/drivers/ata/pata_platform.c
+++ b/drivers/ata/pata_platform.c
@@ -71,13 +71,13 @@ static struct scsi_host_template pata_pl
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
 
diff --git a/drivers/ata/pata_qdi.c b/drivers/ata/pata_qdi.c
index 2c3cc0c..36f621a 100644
--- a/drivers/ata/pata_qdi.c
+++ b/drivers/ata/pata_qdi.c
@@ -157,13 +157,13 @@ static struct scsi_host_template qdi_sht
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
 
diff --git a/drivers/ata/pata_radisys.c b/drivers/ata/pata_radisys.c
index 1af83d7..21cd56e 100644
--- a/drivers/ata/pata_radisys.c
+++ b/drivers/ata/pata_radisys.c
@@ -220,13 +220,13 @@ static struct scsi_host_template radisys
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
 
diff --git a/drivers/ata/pata_rz1000.c b/drivers/ata/pata_rz1000.c
index 4533b63..6e009c3 100644
--- a/drivers/ata/pata_rz1000.c
+++ b/drivers/ata/pata_rz1000.c
@@ -83,13 +83,13 @@ static struct scsi_host_template rz1000_
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
 
diff --git a/drivers/ata/pata_sc1200.c b/drivers/ata/pata_sc1200.c
index 067d9d2..3868d02 100644
--- a/drivers/ata/pata_sc1200.c
+++ b/drivers/ata/pata_sc1200.c
@@ -186,13 +186,13 @@ static struct scsi_host_template sc1200_
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
 
diff --git a/drivers/ata/pata_serverworks.c b/drivers/ata/pata_serverworks.c
index 5bbf76e..f3db2ac 100644
--- a/drivers/ata/pata_serverworks.c
+++ b/drivers/ata/pata_serverworks.c
@@ -318,13 +318,13 @@ static struct scsi_host_template serverw
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
 
diff --git a/drivers/ata/pata_sil680.c b/drivers/ata/pata_sil680.c
index 4a2b72b..142aac5 100644
--- a/drivers/ata/pata_sil680.c
+++ b/drivers/ata/pata_sil680.c
@@ -218,13 +218,13 @@ static struct scsi_host_template sil680_
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
 
diff --git a/drivers/ata/pata_sis.c b/drivers/ata/pata_sis.c
index b9ffafb..9d3f55c 100644
--- a/drivers/ata/pata_sis.c
+++ b/drivers/ata/pata_sis.c
@@ -538,13 +538,13 @@ static struct scsi_host_template sis_sht
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
 
diff --git a/drivers/ata/pata_sl82c105.c b/drivers/ata/pata_sl82c105.c
index 08a6dc8..e94f515 100644
--- a/drivers/ata/pata_sl82c105.c
+++ b/drivers/ata/pata_sl82c105.c
@@ -230,13 +230,13 @@ static struct scsi_host_template sl82c10
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
 
diff --git a/drivers/ata/pata_triflex.c b/drivers/ata/pata_triflex.c
index 9640f80..59689cb 100644
--- a/drivers/ata/pata_triflex.c
+++ b/drivers/ata/pata_triflex.c
@@ -185,13 +185,13 @@ static struct scsi_host_template triflex
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
 
diff --git a/drivers/ata/pata_via.c b/drivers/ata/pata_via.c
index 1e7be9e..9d3f9e8 100644
--- a/drivers/ata/pata_via.c
+++ b/drivers/ata/pata_via.c
@@ -288,13 +288,13 @@ static struct scsi_host_template via_sht
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
 
diff --git a/drivers/ata/pata_winbond.c b/drivers/ata/pata_winbond.c
index 48941d0..3ea345c 100644
--- a/drivers/ata/pata_winbond.c
+++ b/drivers/ata/pata_winbond.c
@@ -126,13 +126,13 @@ static struct scsi_host_template winbond
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
 
diff --git a/drivers/ata/sata_nv.c b/drivers/ata/sata_nv.c
index a577101..fd6ee9e 100644
--- a/drivers/ata/sata_nv.c
+++ b/drivers/ata/sata_nv.c
@@ -319,7 +319,6 @@ static struct scsi_host_template nv_adma
 	.can_queue		= NV_ADMA_MAX_CPBS,
 	.this_id		= ATA_SHT_THIS_ID,
 	.sg_tablesize		= NV_ADMA_SGTBL_TOTAL_LEN,
-	.max_sectors		= ATA_MAX_SECTORS,
 	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
 	.emulated		= ATA_SHT_EMULATED,
 	.use_clustering		= ATA_SHT_USE_CLUSTERING,
