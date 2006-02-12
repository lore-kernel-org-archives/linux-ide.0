From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 4/4] libata: kill sht->max_sectors
Date: Sun, 12 Feb 2006 23:32:59 +0900
Message-ID: <11397547791214-git-send-email-htejun@gmail.com>
References: <11397547782407-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pproxy.gmail.com ([64.233.166.177]:28562 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751131AbWBLOdC (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 12 Feb 2006 09:33:02 -0500
Received: by pproxy.gmail.com with SMTP id d42so438623pyd
        for <linux-ide@vger.kernel.org>; Sun, 12 Feb 2006 06:33:02 -0800 (PST)
In-Reply-To: <11397547782407-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, albertcc@tw.ibm.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

The previous dev->max_sectors patch made sht->max_sectors meaningless.
Kill all initializations of sht->max_sectors.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/ahci.c         |    1 -
 drivers/scsi/ata_piix.c     |    1 -
 drivers/scsi/pdc_adma.c     |    1 -
 drivers/scsi/sata_mv.c      |    1 -
 drivers/scsi/sata_nv.c      |    1 -
 drivers/scsi/sata_promise.c |    1 -
 drivers/scsi/sata_qstor.c   |    1 -
 drivers/scsi/sata_sil.c     |    1 -
 drivers/scsi/sata_sil24.c   |    1 -
 drivers/scsi/sata_sis.c     |    1 -
 drivers/scsi/sata_svw.c     |    1 -
 drivers/scsi/sata_sx4.c     |    1 -
 drivers/scsi/sata_uli.c     |    1 -
 drivers/scsi/sata_via.c     |    1 -
 drivers/scsi/sata_vsc.c     |    1 -
 15 files changed, 0 insertions(+), 15 deletions(-)

05115b54cfe2458ef077e1168533bc14f102fdb3
diff --git a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
index 23caa0c..1c2ab3d 100644
--- a/drivers/scsi/ahci.c
+++ b/drivers/scsi/ahci.c
@@ -211,7 +211,6 @@ static struct scsi_host_template ahci_sh
 	.can_queue		= ATA_DEF_QUEUE,
 	.this_id		= ATA_SHT_THIS_ID,
 	.sg_tablesize		= AHCI_MAX_SG,
-	.max_sectors		= ATA_MAX_SECTORS,
 	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
 	.emulated		= ATA_SHT_EMULATED,
 	.use_clustering		= AHCI_USE_CLUSTERING,
diff --git a/drivers/scsi/ata_piix.c b/drivers/scsi/ata_piix.c
index 4933ba2..289be58 100644
--- a/drivers/scsi/ata_piix.c
+++ b/drivers/scsi/ata_piix.c
@@ -185,7 +185,6 @@ static struct scsi_host_template piix_sh
 	.can_queue		= ATA_DEF_QUEUE,
 	.this_id		= ATA_SHT_THIS_ID,
 	.sg_tablesize		= LIBATA_MAX_PRD,
-	.max_sectors		= ATA_MAX_SECTORS,
 	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
 	.emulated		= ATA_SHT_EMULATED,
 	.use_clustering		= ATA_SHT_USE_CLUSTERING,
diff --git a/drivers/scsi/pdc_adma.c b/drivers/scsi/pdc_adma.c
index d0ad3eb..5f33cc9 100644
--- a/drivers/scsi/pdc_adma.c
+++ b/drivers/scsi/pdc_adma.c
@@ -148,7 +148,6 @@ static struct scsi_host_template adma_at
 	.can_queue		= ATA_DEF_QUEUE,
 	.this_id		= ATA_SHT_THIS_ID,
 	.sg_tablesize		= LIBATA_MAX_PRD,
-	.max_sectors		= ATA_MAX_SECTORS,
 	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
 	.emulated		= ATA_SHT_EMULATED,
 	.use_clustering		= ENABLE_CLUSTERING,
diff --git a/drivers/scsi/sata_mv.c b/drivers/scsi/sata_mv.c
index 732cb64..c158de2 100644
--- a/drivers/scsi/sata_mv.c
+++ b/drivers/scsi/sata_mv.c
@@ -383,7 +383,6 @@ static struct scsi_host_template mv_sht 
 	.can_queue		= MV_USE_Q_DEPTH,
 	.this_id		= ATA_SHT_THIS_ID,
 	.sg_tablesize		= MV_MAX_SG_CT / 2,
-	.max_sectors		= ATA_MAX_SECTORS,
 	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
 	.emulated		= ATA_SHT_EMULATED,
 	.use_clustering		= ATA_SHT_USE_CLUSTERING,
diff --git a/drivers/scsi/sata_nv.c b/drivers/scsi/sata_nv.c
index cdfeb9a..caffadc 100644
--- a/drivers/scsi/sata_nv.c
+++ b/drivers/scsi/sata_nv.c
@@ -234,7 +234,6 @@ static struct scsi_host_template nv_sht 
 	.can_queue		= ATA_DEF_QUEUE,
 	.this_id		= ATA_SHT_THIS_ID,
 	.sg_tablesize		= LIBATA_MAX_PRD,
-	.max_sectors		= ATA_MAX_SECTORS,
 	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
 	.emulated		= ATA_SHT_EMULATED,
 	.use_clustering		= ATA_SHT_USE_CLUSTERING,
diff --git a/drivers/scsi/sata_promise.c b/drivers/scsi/sata_promise.c
index c9dfd93..ba2b7a0 100644
--- a/drivers/scsi/sata_promise.c
+++ b/drivers/scsi/sata_promise.c
@@ -116,7 +116,6 @@ static struct scsi_host_template pdc_ata
 	.can_queue		= ATA_DEF_QUEUE,
 	.this_id		= ATA_SHT_THIS_ID,
 	.sg_tablesize		= LIBATA_MAX_PRD,
-	.max_sectors		= ATA_MAX_SECTORS,
 	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
 	.emulated		= ATA_SHT_EMULATED,
 	.use_clustering		= ATA_SHT_USE_CLUSTERING,
diff --git a/drivers/scsi/sata_qstor.c b/drivers/scsi/sata_qstor.c
index 955131b..2864826 100644
--- a/drivers/scsi/sata_qstor.c
+++ b/drivers/scsi/sata_qstor.c
@@ -137,7 +137,6 @@ static struct scsi_host_template qs_ata_
 	.can_queue		= ATA_DEF_QUEUE,
 	.this_id		= ATA_SHT_THIS_ID,
 	.sg_tablesize		= QS_MAX_PRD,
-	.max_sectors		= ATA_MAX_SECTORS,
 	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
 	.emulated		= ATA_SHT_EMULATED,
 	//FIXME .use_clustering		= ATA_SHT_USE_CLUSTERING,
diff --git a/drivers/scsi/sata_sil.c b/drivers/scsi/sata_sil.c
index 6c482c8..1534688 100644
--- a/drivers/scsi/sata_sil.c
+++ b/drivers/scsi/sata_sil.c
@@ -140,7 +140,6 @@ static struct scsi_host_template sil_sht
 	.can_queue		= ATA_DEF_QUEUE,
 	.this_id		= ATA_SHT_THIS_ID,
 	.sg_tablesize		= LIBATA_MAX_PRD,
-	.max_sectors		= ATA_MAX_SECTORS,
 	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
 	.emulated		= ATA_SHT_EMULATED,
 	.use_clustering		= ATA_SHT_USE_CLUSTERING,
diff --git a/drivers/scsi/sata_sil24.c b/drivers/scsi/sata_sil24.c
index 24020c6..a0e35a2 100644
--- a/drivers/scsi/sata_sil24.c
+++ b/drivers/scsi/sata_sil24.c
@@ -285,7 +285,6 @@ static struct scsi_host_template sil24_s
 	.can_queue		= ATA_DEF_QUEUE,
 	.this_id		= ATA_SHT_THIS_ID,
 	.sg_tablesize		= LIBATA_MAX_PRD,
-	.max_sectors		= ATA_MAX_SECTORS,
 	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
 	.emulated		= ATA_SHT_EMULATED,
 	.use_clustering		= ATA_SHT_USE_CLUSTERING,
diff --git a/drivers/scsi/sata_sis.c b/drivers/scsi/sata_sis.c
index 2f18157..7fd45f8 100644
--- a/drivers/scsi/sata_sis.c
+++ b/drivers/scsi/sata_sis.c
@@ -92,7 +92,6 @@ static struct scsi_host_template sis_sht
 	.can_queue		= ATA_DEF_QUEUE,
 	.this_id		= ATA_SHT_THIS_ID,
 	.sg_tablesize		= ATA_MAX_PRD,
-	.max_sectors		= ATA_MAX_SECTORS,
 	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
 	.emulated		= ATA_SHT_EMULATED,
 	.use_clustering		= ATA_SHT_USE_CLUSTERING,
diff --git a/drivers/scsi/sata_svw.c b/drivers/scsi/sata_svw.c
index f369c30..4aaccd5 100644
--- a/drivers/scsi/sata_svw.c
+++ b/drivers/scsi/sata_svw.c
@@ -293,7 +293,6 @@ static struct scsi_host_template k2_sata
 	.can_queue		= ATA_DEF_QUEUE,
 	.this_id		= ATA_SHT_THIS_ID,
 	.sg_tablesize		= LIBATA_MAX_PRD,
-	.max_sectors		= ATA_MAX_SECTORS,
 	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
 	.emulated		= ATA_SHT_EMULATED,
 	.use_clustering		= ATA_SHT_USE_CLUSTERING,
diff --git a/drivers/scsi/sata_sx4.c b/drivers/scsi/sata_sx4.c
index e158f7a..9f8a768 100644
--- a/drivers/scsi/sata_sx4.c
+++ b/drivers/scsi/sata_sx4.c
@@ -187,7 +187,6 @@ static struct scsi_host_template pdc_sat
 	.can_queue		= ATA_DEF_QUEUE,
 	.this_id		= ATA_SHT_THIS_ID,
 	.sg_tablesize		= LIBATA_MAX_PRD,
-	.max_sectors		= ATA_MAX_SECTORS,
 	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
 	.emulated		= ATA_SHT_EMULATED,
 	.use_clustering		= ATA_SHT_USE_CLUSTERING,
diff --git a/drivers/scsi/sata_uli.c b/drivers/scsi/sata_uli.c
index c500f24..37a487b 100644
--- a/drivers/scsi/sata_uli.c
+++ b/drivers/scsi/sata_uli.c
@@ -80,7 +80,6 @@ static struct scsi_host_template uli_sht
 	.can_queue		= ATA_DEF_QUEUE,
 	.this_id		= ATA_SHT_THIS_ID,
 	.sg_tablesize		= LIBATA_MAX_PRD,
-	.max_sectors		= ATA_MAX_SECTORS,
 	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
 	.emulated		= ATA_SHT_EMULATED,
 	.use_clustering		= ATA_SHT_USE_CLUSTERING,
diff --git a/drivers/scsi/sata_via.c b/drivers/scsi/sata_via.c
index 2e20887..ff65a0b 100644
--- a/drivers/scsi/sata_via.c
+++ b/drivers/scsi/sata_via.c
@@ -99,7 +99,6 @@ static struct scsi_host_template svia_sh
 	.can_queue		= ATA_DEF_QUEUE,
 	.this_id		= ATA_SHT_THIS_ID,
 	.sg_tablesize		= LIBATA_MAX_PRD,
-	.max_sectors		= ATA_MAX_SECTORS,
 	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
 	.emulated		= ATA_SHT_EMULATED,
 	.use_clustering		= ATA_SHT_USE_CLUSTERING,
diff --git a/drivers/scsi/sata_vsc.c b/drivers/scsi/sata_vsc.c
index cf1f8a6..e124db8 100644
--- a/drivers/scsi/sata_vsc.c
+++ b/drivers/scsi/sata_vsc.c
@@ -228,7 +228,6 @@ static struct scsi_host_template vsc_sat
 	.can_queue		= ATA_DEF_QUEUE,
 	.this_id		= ATA_SHT_THIS_ID,
 	.sg_tablesize		= LIBATA_MAX_PRD,
-	.max_sectors		= ATA_MAX_SECTORS,
 	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
 	.emulated		= ATA_SHT_EMULATED,
 	.use_clustering		= ATA_SHT_USE_CLUSTERING,
-- 
1.1.5


