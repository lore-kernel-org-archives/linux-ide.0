From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 05/13] libata-hp: hook warmplug
Date: Sat, 20 May 2006 00:48:27 +0900
Message-ID: <11480537071188-git-send-email-htejun@gmail.com>
References: <11480537063293-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.182]:1649 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932399AbWESPsk (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 19 May 2006 11:48:40 -0400
Received: by py-out-1112.google.com with SMTP id z59so966321pyg
        for <linux-ide@vger.kernel.org>; Fri, 19 May 2006 08:48:40 -0700 (PDT)
In-Reply-To: <11480537063293-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, mlord@pobox.com, albertcc@tw.ibm.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, forrest.zhao@intel.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Hook transportt->user_scan() and hostt->slave_destroy().

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/ahci.c         |    1 +
 drivers/scsi/ata_piix.c     |    1 +
 drivers/scsi/libata-scsi.c  |    1 +
 drivers/scsi/pdc_adma.c     |    1 +
 drivers/scsi/sata_mv.c      |    1 +
 drivers/scsi/sata_nv.c      |    1 +
 drivers/scsi/sata_promise.c |    1 +
 drivers/scsi/sata_qstor.c   |    1 +
 drivers/scsi/sata_sil.c     |    1 +
 drivers/scsi/sata_sil24.c   |    1 +
 drivers/scsi/sata_sis.c     |    1 +
 drivers/scsi/sata_svw.c     |    1 +
 drivers/scsi/sata_sx4.c     |    1 +
 drivers/scsi/sata_uli.c     |    1 +
 drivers/scsi/sata_via.c     |    1 +
 drivers/scsi/sata_vsc.c     |    1 +
 16 files changed, 16 insertions(+), 0 deletions(-)

52246377f6dc7887c1e5ead27312955b74729fd3
diff --git a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
index 8493b02..afb3805 100644
--- a/drivers/scsi/ahci.c
+++ b/drivers/scsi/ahci.c
@@ -228,6 +228,7 @@ static struct scsi_host_template ahci_sh
 	.proc_name		= DRV_NAME,
 	.dma_boundary		= AHCI_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
+	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
 };
 
diff --git a/drivers/scsi/ata_piix.c b/drivers/scsi/ata_piix.c
index e3184a7..f2d71e7 100644
--- a/drivers/scsi/ata_piix.c
+++ b/drivers/scsi/ata_piix.c
@@ -218,6 +218,7 @@ static struct scsi_host_template piix_sh
 	.proc_name		= DRV_NAME,
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
+	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
 	.resume			= ata_scsi_device_resume,
 	.suspend		= ata_scsi_device_suspend,
diff --git a/drivers/scsi/libata-scsi.c b/drivers/scsi/libata-scsi.c
index 0415fd2..c2e0bce 100644
--- a/drivers/scsi/libata-scsi.c
+++ b/drivers/scsi/libata-scsi.c
@@ -107,6 +107,7 @@ static const u8 def_control_mpage[CONTRO
 struct scsi_transport_template ata_scsi_transport_template = {
 	.eh_strategy_handler	= ata_scsi_error,
 	.eh_timed_out		= ata_scsi_timed_out,
+	.user_scan		= ata_scsi_user_scan,
 };
 
 
diff --git a/drivers/scsi/pdc_adma.c b/drivers/scsi/pdc_adma.c
index a341fa8..eb910e4 100644
--- a/drivers/scsi/pdc_adma.c
+++ b/drivers/scsi/pdc_adma.c
@@ -152,6 +152,7 @@ static struct scsi_host_template adma_at
 	.proc_name		= DRV_NAME,
 	.dma_boundary		= ADMA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
+	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
 };
 
diff --git a/drivers/scsi/sata_mv.c b/drivers/scsi/sata_mv.c
index e6d141d..72db067 100644
--- a/drivers/scsi/sata_mv.c
+++ b/drivers/scsi/sata_mv.c
@@ -387,6 +387,7 @@ static struct scsi_host_template mv_sht 
 	.proc_name		= DRV_NAME,
 	.dma_boundary		= MV_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
+	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
 };
 
diff --git a/drivers/scsi/sata_nv.c b/drivers/scsi/sata_nv.c
index 70c5108..2a840f5 100644
--- a/drivers/scsi/sata_nv.c
+++ b/drivers/scsi/sata_nv.c
@@ -210,6 +210,7 @@ static struct scsi_host_template nv_sht 
 	.proc_name		= DRV_NAME,
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
+	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
 };
 
diff --git a/drivers/scsi/sata_promise.c b/drivers/scsi/sata_promise.c
index bb00043..9c70018 100644
--- a/drivers/scsi/sata_promise.c
+++ b/drivers/scsi/sata_promise.c
@@ -121,6 +121,7 @@ static struct scsi_host_template pdc_ata
 	.proc_name		= DRV_NAME,
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
+	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
 };
 
diff --git a/drivers/scsi/sata_qstor.c b/drivers/scsi/sata_qstor.c
index 54283e0..3fc1003 100644
--- a/drivers/scsi/sata_qstor.c
+++ b/drivers/scsi/sata_qstor.c
@@ -142,6 +142,7 @@ static struct scsi_host_template qs_ata_
 	.proc_name		= DRV_NAME,
 	.dma_boundary		= QS_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
+	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
 };
 
diff --git a/drivers/scsi/sata_sil.c b/drivers/scsi/sata_sil.c
index cbced4b..96fbeb6 100644
--- a/drivers/scsi/sata_sil.c
+++ b/drivers/scsi/sata_sil.c
@@ -174,6 +174,7 @@ static struct scsi_host_template sil_sht
 	.proc_name		= DRV_NAME,
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
+	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
 };
 
diff --git a/drivers/scsi/sata_sil24.c b/drivers/scsi/sata_sil24.c
index def1378..e92230a 100644
--- a/drivers/scsi/sata_sil24.c
+++ b/drivers/scsi/sata_sil24.c
@@ -367,6 +367,7 @@ static struct scsi_host_template sil24_s
 	.proc_name		= DRV_NAME,
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
+	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
 };
 
diff --git a/drivers/scsi/sata_sis.c b/drivers/scsi/sata_sis.c
index 3097821..8297335 100644
--- a/drivers/scsi/sata_sis.c
+++ b/drivers/scsi/sata_sis.c
@@ -96,6 +96,7 @@ static struct scsi_host_template sis_sht
 	.proc_name		= DRV_NAME,
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
+	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
 };
 
diff --git a/drivers/scsi/sata_svw.c b/drivers/scsi/sata_svw.c
index d5eb537..b2fe0bc 100644
--- a/drivers/scsi/sata_svw.c
+++ b/drivers/scsi/sata_svw.c
@@ -299,6 +299,7 @@ static struct scsi_host_template k2_sata
 	.proc_name		= DRV_NAME,
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
+	.slave_destroy		= ata_scsi_slave_destroy,
 #ifdef CONFIG_PPC_OF
 	.proc_info		= k2_sata_proc_info,
 #endif
diff --git a/drivers/scsi/sata_sx4.c b/drivers/scsi/sata_sx4.c
index 70a6954..fb69fc2 100644
--- a/drivers/scsi/sata_sx4.c
+++ b/drivers/scsi/sata_sx4.c
@@ -191,6 +191,7 @@ static struct scsi_host_template pdc_sat
 	.proc_name		= DRV_NAME,
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
+	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
 };
 
diff --git a/drivers/scsi/sata_uli.c b/drivers/scsi/sata_uli.c
index 15f81bf..4b4094f 100644
--- a/drivers/scsi/sata_uli.c
+++ b/drivers/scsi/sata_uli.c
@@ -90,6 +90,7 @@ static struct scsi_host_template uli_sht
 	.proc_name		= DRV_NAME,
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
+	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
 };
 
diff --git a/drivers/scsi/sata_via.c b/drivers/scsi/sata_via.c
index 17aefab..6e3effe 100644
--- a/drivers/scsi/sata_via.c
+++ b/drivers/scsi/sata_via.c
@@ -103,6 +103,7 @@ static struct scsi_host_template svia_sh
 	.proc_name		= DRV_NAME,
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
+	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
 };
 
diff --git a/drivers/scsi/sata_vsc.c b/drivers/scsi/sata_vsc.c
index 0372be7..d51c8d6 100644
--- a/drivers/scsi/sata_vsc.c
+++ b/drivers/scsi/sata_vsc.c
@@ -279,6 +279,7 @@ static struct scsi_host_template vsc_sat
 	.proc_name		= DRV_NAME,
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
+	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
 };
 
-- 
1.3.2


