From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 06/15] libata-hp: use ata_scsi_slave_destroy() in low level drivers
Date: Tue, 11 Apr 2006 23:14:07 +0900
Message-ID: <11447648471724-git-send-email-htejun@gmail.com>
References: <1144764846705-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.203]:45939 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751291AbWDKOOO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 11 Apr 2006 10:14:14 -0400
Received: by zproxy.gmail.com with SMTP id o37so1102581nzf
        for <linux-ide@vger.kernel.org>; Tue, 11 Apr 2006 07:14:13 -0700 (PDT)
In-Reply-To: <1144764846705-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, lkosewsk@gmail.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Use ata_scsi_slave_destroy() in all libata low level drivers.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/ahci.c         |    1 +
 drivers/scsi/ata_piix.c     |    1 +
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
 15 files changed, 15 insertions(+), 0 deletions(-)

ad8e69e7f7a668b6d60583cb4bfeb1f690331ca7
diff --git a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
index 3f1fd7c..a8b699a 100644
--- a/drivers/scsi/ahci.c
+++ b/drivers/scsi/ahci.c
@@ -226,6 +226,7 @@ static struct scsi_host_template ahci_sh
 	.proc_name		= DRV_NAME,
 	.dma_boundary		= AHCI_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
+	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
 };
 
diff --git a/drivers/scsi/ata_piix.c b/drivers/scsi/ata_piix.c
index 382ea51..d8ea3f2 100644
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
diff --git a/drivers/scsi/pdc_adma.c b/drivers/scsi/pdc_adma.c
index 1364b1d..603460e 100644
--- a/drivers/scsi/pdc_adma.c
+++ b/drivers/scsi/pdc_adma.c
@@ -153,6 +153,7 @@ static struct scsi_host_template adma_at
 	.proc_name		= DRV_NAME,
 	.dma_boundary		= ADMA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
+	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
 };
 
diff --git a/drivers/scsi/sata_mv.c b/drivers/scsi/sata_mv.c
index e9152f8..ffb86f4 100644
--- a/drivers/scsi/sata_mv.c
+++ b/drivers/scsi/sata_mv.c
@@ -388,6 +388,7 @@ static struct scsi_host_template mv_sht 
 	.proc_name		= DRV_NAME,
 	.dma_boundary		= MV_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
+	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
 };
 
diff --git a/drivers/scsi/sata_nv.c b/drivers/scsi/sata_nv.c
index c92fbd0..ad030d9 100644
--- a/drivers/scsi/sata_nv.c
+++ b/drivers/scsi/sata_nv.c
@@ -211,6 +211,7 @@ static struct scsi_host_template nv_sht 
 	.proc_name		= DRV_NAME,
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
+	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
 };
 
diff --git a/drivers/scsi/sata_promise.c b/drivers/scsi/sata_promise.c
index 000844a..63503ed 100644
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
index 0b5446a..b1876c6 100644
--- a/drivers/scsi/sata_qstor.c
+++ b/drivers/scsi/sata_qstor.c
@@ -143,6 +143,7 @@ static struct scsi_host_template qs_ata_
 	.proc_name		= DRV_NAME,
 	.dma_boundary		= QS_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
+	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
 };
 
diff --git a/drivers/scsi/sata_sil.c b/drivers/scsi/sata_sil.c
index 4b9b2d1..3853c46 100644
--- a/drivers/scsi/sata_sil.c
+++ b/drivers/scsi/sata_sil.c
@@ -159,6 +159,7 @@ static struct scsi_host_template sil_sht
 	.proc_name		= DRV_NAME,
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
+	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
 };
 
diff --git a/drivers/scsi/sata_sil24.c b/drivers/scsi/sata_sil24.c
index 6a7ea97..9acf7a4 100644
--- a/drivers/scsi/sata_sil24.c
+++ b/drivers/scsi/sata_sil24.c
@@ -371,6 +371,7 @@ static struct scsi_host_template sil24_s
 	.proc_name		= DRV_NAME,
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
+	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
 };
 
diff --git a/drivers/scsi/sata_sis.c b/drivers/scsi/sata_sis.c
index eb3cf5b..b66a320 100644
--- a/drivers/scsi/sata_sis.c
+++ b/drivers/scsi/sata_sis.c
@@ -97,6 +97,7 @@ static struct scsi_host_template sis_sht
 	.proc_name		= DRV_NAME,
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
+	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
 };
 
diff --git a/drivers/scsi/sata_svw.c b/drivers/scsi/sata_svw.c
index a20bc81..6fc5b73 100644
--- a/drivers/scsi/sata_svw.c
+++ b/drivers/scsi/sata_svw.c
@@ -300,6 +300,7 @@ static struct scsi_host_template k2_sata
 	.proc_name		= DRV_NAME,
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
+	.slave_destroy		= ata_scsi_slave_destroy,
 #ifdef CONFIG_PPC_OF
 	.proc_info		= k2_sata_proc_info,
 #endif
diff --git a/drivers/scsi/sata_sx4.c b/drivers/scsi/sata_sx4.c
index 801ac37..3600420 100644
--- a/drivers/scsi/sata_sx4.c
+++ b/drivers/scsi/sata_sx4.c
@@ -192,6 +192,7 @@ static struct scsi_host_template pdc_sat
 	.proc_name		= DRV_NAME,
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
+	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
 };
 
diff --git a/drivers/scsi/sata_uli.c b/drivers/scsi/sata_uli.c
index 513dd78..682747a 100644
--- a/drivers/scsi/sata_uli.c
+++ b/drivers/scsi/sata_uli.c
@@ -91,6 +91,7 @@ static struct scsi_host_template uli_sht
 	.proc_name		= DRV_NAME,
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
+	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
 };
 
diff --git a/drivers/scsi/sata_via.c b/drivers/scsi/sata_via.c
index de4e0eb..023aa75 100644
--- a/drivers/scsi/sata_via.c
+++ b/drivers/scsi/sata_via.c
@@ -104,6 +104,7 @@ static struct scsi_host_template svia_sh
 	.proc_name		= DRV_NAME,
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
+	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
 };
 
diff --git a/drivers/scsi/sata_vsc.c b/drivers/scsi/sata_vsc.c
index cecc1f7..10cd202 100644
--- a/drivers/scsi/sata_vsc.c
+++ b/drivers/scsi/sata_vsc.c
@@ -273,6 +273,7 @@ static struct scsi_host_template vsc_sat
 	.proc_name		= DRV_NAME,
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
+	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
 };
 
-- 
1.2.4


