From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 05/13] libata-hp: hook warmplug
Date: Mon, 29 May 2006 15:38:56 +0900
Message-ID: <1148884736494-git-send-email-htejun@gmail.com>
References: <11488847352050-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.224]:36544 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751298AbWE2GjN (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 29 May 2006 02:39:13 -0400
Received: by wr-out-0506.google.com with SMTP id i7so819183wra
        for <linux-ide@vger.kernel.org>; Sun, 28 May 2006 23:39:13 -0700 (PDT)
In-Reply-To: <11488847352050-git-send-email-htejun@gmail.com>
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

506098b74882b8fde1f9904cd5050a63160529ff
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
index ad41dfd..54c2e52 100644
--- a/drivers/scsi/ata_piix.c
+++ b/drivers/scsi/ata_piix.c
@@ -219,6 +219,7 @@ static struct scsi_host_template piix_sh
 	.proc_name		= DRV_NAME,
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
+	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
 	.resume			= ata_scsi_device_resume,
 	.suspend		= ata_scsi_device_suspend,
diff --git a/drivers/scsi/libata-scsi.c b/drivers/scsi/libata-scsi.c
index 230cd20..bf6802b 100644
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
index 624983c..634bab1 100644
--- a/drivers/scsi/sata_mv.c
+++ b/drivers/scsi/sata_mv.c
@@ -390,6 +390,7 @@ static struct scsi_host_template mv_sht 
 	.proc_name		= DRV_NAME,
 	.dma_boundary		= MV_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
+	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
 };
 
diff --git a/drivers/scsi/sata_nv.c b/drivers/scsi/sata_nv.c
index d93513e..9055124 100644
--- a/drivers/scsi/sata_nv.c
+++ b/drivers/scsi/sata_nv.c
@@ -216,6 +216,7 @@ static struct scsi_host_template nv_sht 
 	.proc_name		= DRV_NAME,
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
+	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
 };
 
diff --git a/drivers/scsi/sata_promise.c b/drivers/scsi/sata_promise.c
index 0111159..b2b6ed5 100644
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
index 68737ca..98ddc25 100644
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
index 695c06c..d420495 100644
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
index 4a83090..d4ca6d6 100644
--- a/drivers/scsi/sata_sil24.c
+++ b/drivers/scsi/sata_sil24.c
@@ -370,6 +370,7 @@ static struct scsi_host_template sil24_s
 	.proc_name		= DRV_NAME,
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
+	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
 };
 
diff --git a/drivers/scsi/sata_sis.c b/drivers/scsi/sata_sis.c
index 82a07bf..a07e6e5 100644
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
index 7a4703b..d9b5168 100644
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
index c4db6bf..7f86441 100644
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
index 7fae3e0..e69ba22 100644
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
index 1c9e2f3..c6975c5 100644
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
index 438e7c6..22ca7b8 100644
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


