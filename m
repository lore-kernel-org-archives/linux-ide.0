From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 5/5] libata: kill sht->max_sectors
Date: Fri, 27 Jan 2006 00:24:03 +0900
Message-ID: <11382890431142-git-send-email-htejun@gmail.com>
References: <11382890422935-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.204]:5002 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932363AbWAZPYO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 26 Jan 2006 10:24:14 -0500
Received: by zproxy.gmail.com with SMTP id 34so368590nzf
        for <linux-ide@vger.kernel.org>; Thu, 26 Jan 2006 07:24:14 -0800 (PST)
In-Reply-To: <11382890422935-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org, albertcc@tw.ibm.com, alan@lxorguk.ukuu.org.uk
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

6b496aa47c50e4586ac1b1a20ab1d28667a91139
diff --git a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
index c8d82cc..0e88cb5 100644
--- a/drivers/scsi/ahci.c
+++ b/drivers/scsi/ahci.c
@@ -210,7 +210,6 @@ static struct scsi_host_template ahci_sh
 	.can_queue		= ATA_DEF_QUEUE,
 	.this_id		= ATA_SHT_THIS_ID,
 	.sg_tablesize		= AHCI_MAX_SG,
-	.max_sectors		= ATA_MAX_SECTORS,
 	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
 	.emulated		= ATA_SHT_EMULATED,
 	.use_clustering		= AHCI_USE_CLUSTERING,
diff --git a/drivers/scsi/ata_piix.c b/drivers/scsi/ata_piix.c
index f312ea9..6d32f70 100644
--- a/drivers/scsi/ata_piix.c
+++ b/drivers/scsi/ata_piix.c
@@ -182,7 +182,6 @@ static struct scsi_host_template piix_sh
 	.can_queue		= ATA_DEF_QUEUE,
 	.this_id		= ATA_SHT_THIS_ID,
 	.sg_tablesize		= LIBATA_MAX_PRD,
-	.max_sectors		= ATA_MAX_SECTORS,
 	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
 	.emulated		= ATA_SHT_EMULATED,
 	.use_clustering		= ATA_SHT_USE_CLUSTERING,
diff --git a/drivers/scsi/pdc_adma.c b/drivers/scsi/pdc_adma.c
index 3a6bf58..b3dc5f8 100644
--- a/drivers/scsi/pdc_adma.c
+++ b/drivers/scsi/pdc_adma.c
@@ -147,7 +147,6 @@ static struct scsi_host_template adma_at
 	.can_queue		= ATA_DEF_QUEUE,
 	.this_id		= ATA_SHT_THIS_ID,
 	.sg_tablesize		= LIBATA_MAX_PRD,
-	.max_sectors		= ATA_MAX_SECTORS,
 	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
 	.emulated		= ATA_SHT_EMULATED,
 	.use_clustering		= ENABLE_CLUSTERING,
diff --git a/drivers/scsi/sata_mv.c b/drivers/scsi/sata_mv.c
index 9b56f9b..49347e2 100644
--- a/drivers/scsi/sata_mv.c
+++ b/drivers/scsi/sata_mv.c
@@ -366,7 +366,6 @@ static struct scsi_host_template mv_sht 
 	.can_queue		= MV_USE_Q_DEPTH,
 	.this_id		= ATA_SHT_THIS_ID,
 	.sg_tablesize		= MV_MAX_SG_CT / 2,
-	.max_sectors		= ATA_MAX_SECTORS,
 	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
 	.emulated		= ATA_SHT_EMULATED,
 	.use_clustering		= ATA_SHT_USE_CLUSTERING,
diff --git a/drivers/scsi/sata_nv.c b/drivers/scsi/sata_nv.c
index bbbb55e..e5b20c6 100644
--- a/drivers/scsi/sata_nv.c
+++ b/drivers/scsi/sata_nv.c
@@ -233,7 +233,6 @@ static struct scsi_host_template nv_sht 
 	.can_queue		= ATA_DEF_QUEUE,
 	.this_id		= ATA_SHT_THIS_ID,
 	.sg_tablesize		= LIBATA_MAX_PRD,
-	.max_sectors		= ATA_MAX_SECTORS,
 	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
 	.emulated		= ATA_SHT_EMULATED,
 	.use_clustering		= ATA_SHT_USE_CLUSTERING,
diff --git a/drivers/scsi/sata_promise.c b/drivers/scsi/sata_promise.c
index 9fc9cbf..56f2250 100644
--- a/drivers/scsi/sata_promise.c
+++ b/drivers/scsi/sata_promise.c
@@ -107,7 +107,6 @@ static struct scsi_host_template pdc_ata
 	.can_queue		= ATA_DEF_QUEUE,
 	.this_id		= ATA_SHT_THIS_ID,
 	.sg_tablesize		= LIBATA_MAX_PRD,
-	.max_sectors		= ATA_MAX_SECTORS,
 	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
 	.emulated		= ATA_SHT_EMULATED,
 	.use_clustering		= ATA_SHT_USE_CLUSTERING,
diff --git a/drivers/scsi/sata_qstor.c b/drivers/scsi/sata_qstor.c
index 2afbeb7..47f3d62 100644
--- a/drivers/scsi/sata_qstor.c
+++ b/drivers/scsi/sata_qstor.c
@@ -136,7 +136,6 @@ static struct scsi_host_template qs_ata_
 	.can_queue		= ATA_DEF_QUEUE,
 	.this_id		= ATA_SHT_THIS_ID,
 	.sg_tablesize		= QS_MAX_PRD,
-	.max_sectors		= ATA_MAX_SECTORS,
 	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
 	.emulated		= ATA_SHT_EMULATED,
 	//FIXME .use_clustering		= ATA_SHT_USE_CLUSTERING,
diff --git a/drivers/scsi/sata_sil.c b/drivers/scsi/sata_sil.c
index 4d6d75a..7c28f38 100644
--- a/drivers/scsi/sata_sil.c
+++ b/drivers/scsi/sata_sil.c
@@ -139,7 +139,6 @@ static struct scsi_host_template sil_sht
 	.can_queue		= ATA_DEF_QUEUE,
 	.this_id		= ATA_SHT_THIS_ID,
 	.sg_tablesize		= LIBATA_MAX_PRD,
-	.max_sectors		= ATA_MAX_SECTORS,
 	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
 	.emulated		= ATA_SHT_EMULATED,
 	.use_clustering		= ATA_SHT_USE_CLUSTERING,
diff --git a/drivers/scsi/sata_sil24.c b/drivers/scsi/sata_sil24.c
index 95352db..080866b 100644
--- a/drivers/scsi/sata_sil24.c
+++ b/drivers/scsi/sata_sil24.c
@@ -284,7 +284,6 @@ static struct scsi_host_template sil24_s
 	.can_queue		= ATA_DEF_QUEUE,
 	.this_id		= ATA_SHT_THIS_ID,
 	.sg_tablesize		= LIBATA_MAX_PRD,
-	.max_sectors		= ATA_MAX_SECTORS,
 	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
 	.emulated		= ATA_SHT_EMULATED,
 	.use_clustering		= ATA_SHT_USE_CLUSTERING,
diff --git a/drivers/scsi/sata_sis.c b/drivers/scsi/sata_sis.c
index 2df8c56..acc8439 100644
--- a/drivers/scsi/sata_sis.c
+++ b/drivers/scsi/sata_sis.c
@@ -91,7 +91,6 @@ static struct scsi_host_template sis_sht
 	.can_queue		= ATA_DEF_QUEUE,
 	.this_id		= ATA_SHT_THIS_ID,
 	.sg_tablesize		= ATA_MAX_PRD,
-	.max_sectors		= ATA_MAX_SECTORS,
 	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
 	.emulated		= ATA_SHT_EMULATED,
 	.use_clustering		= ATA_SHT_USE_CLUSTERING,
diff --git a/drivers/scsi/sata_svw.c b/drivers/scsi/sata_svw.c
index d847256..051e47d 100644
--- a/drivers/scsi/sata_svw.c
+++ b/drivers/scsi/sata_svw.c
@@ -292,7 +292,6 @@ static struct scsi_host_template k2_sata
 	.can_queue		= ATA_DEF_QUEUE,
 	.this_id		= ATA_SHT_THIS_ID,
 	.sg_tablesize		= LIBATA_MAX_PRD,
-	.max_sectors		= ATA_MAX_SECTORS,
 	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
 	.emulated		= ATA_SHT_EMULATED,
 	.use_clustering		= ATA_SHT_USE_CLUSTERING,
diff --git a/drivers/scsi/sata_sx4.c b/drivers/scsi/sata_sx4.c
index b4ffa3f..86b28cc 100644
--- a/drivers/scsi/sata_sx4.c
+++ b/drivers/scsi/sata_sx4.c
@@ -186,7 +186,6 @@ static struct scsi_host_template pdc_sat
 	.can_queue		= ATA_DEF_QUEUE,
 	.this_id		= ATA_SHT_THIS_ID,
 	.sg_tablesize		= LIBATA_MAX_PRD,
-	.max_sectors		= ATA_MAX_SECTORS,
 	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
 	.emulated		= ATA_SHT_EMULATED,
 	.use_clustering		= ATA_SHT_USE_CLUSTERING,
diff --git a/drivers/scsi/sata_uli.c b/drivers/scsi/sata_uli.c
index 9635ca7..8f50257 100644
--- a/drivers/scsi/sata_uli.c
+++ b/drivers/scsi/sata_uli.c
@@ -79,7 +79,6 @@ static struct scsi_host_template uli_sht
 	.can_queue		= ATA_DEF_QUEUE,
 	.this_id		= ATA_SHT_THIS_ID,
 	.sg_tablesize		= LIBATA_MAX_PRD,
-	.max_sectors		= ATA_MAX_SECTORS,
 	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
 	.emulated		= ATA_SHT_EMULATED,
 	.use_clustering		= ATA_SHT_USE_CLUSTERING,
diff --git a/drivers/scsi/sata_via.c b/drivers/scsi/sata_via.c
index 6d5b0a7..791bf65 100644
--- a/drivers/scsi/sata_via.c
+++ b/drivers/scsi/sata_via.c
@@ -98,7 +98,6 @@ static struct scsi_host_template svia_sh
 	.can_queue		= ATA_DEF_QUEUE,
 	.this_id		= ATA_SHT_THIS_ID,
 	.sg_tablesize		= LIBATA_MAX_PRD,
-	.max_sectors		= ATA_MAX_SECTORS,
 	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
 	.emulated		= ATA_SHT_EMULATED,
 	.use_clustering		= ATA_SHT_USE_CLUSTERING,
diff --git a/drivers/scsi/sata_vsc.c b/drivers/scsi/sata_vsc.c
index 2e2c3b7..86adb23 100644
--- a/drivers/scsi/sata_vsc.c
+++ b/drivers/scsi/sata_vsc.c
@@ -227,7 +227,6 @@ static struct scsi_host_template vsc_sat
 	.can_queue		= ATA_DEF_QUEUE,
 	.this_id		= ATA_SHT_THIS_ID,
 	.sg_tablesize		= LIBATA_MAX_PRD,
-	.max_sectors		= ATA_MAX_SECTORS,
 	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
 	.emulated		= ATA_SHT_EMULATED,
 	.use_clustering		= ATA_SHT_USE_CLUSTERING,
-- 
1.1.3


