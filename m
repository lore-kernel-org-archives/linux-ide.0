From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 3/4] libata: use ata_scsi_timed_out()
Date: Fri, 10 Feb 2006 15:10:48 +0900
Message-ID: <11395518483304-git-send-email-htejun@gmail.com>
References: <11395518482722-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.203]:9721 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751161AbWBJGKx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 10 Feb 2006 01:10:53 -0500
Received: by zproxy.gmail.com with SMTP id 14so369990nzn
        for <linux-ide@vger.kernel.org>; Thu, 09 Feb 2006 22:10:53 -0800 (PST)
In-Reply-To: <11395518482722-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, albertcc@tw.ibm.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Make all libata low level drivers use ata_scsi_timed_out().

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

f8ba8f199f983312d2d2191e8af1e18954f410a3
diff --git a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
index c840d5e..c67189a 100644
--- a/drivers/scsi/ahci.c
+++ b/drivers/scsi/ahci.c
@@ -206,6 +206,7 @@ static struct scsi_host_template ahci_sh
 	.name			= DRV_NAME,
 	.ioctl			= ata_scsi_ioctl,
 	.queuecommand		= ata_scsi_queuecmd,
+	.eh_timed_out		= ata_scsi_timed_out,
 	.eh_strategy_handler	= ata_scsi_error,
 	.can_queue		= ATA_DEF_QUEUE,
 	.this_id		= ATA_SHT_THIS_ID,
diff --git a/drivers/scsi/ata_piix.c b/drivers/scsi/ata_piix.c
index 49cc420..4933ba2 100644
--- a/drivers/scsi/ata_piix.c
+++ b/drivers/scsi/ata_piix.c
@@ -180,6 +180,7 @@ static struct scsi_host_template piix_sh
 	.name			= DRV_NAME,
 	.ioctl			= ata_scsi_ioctl,
 	.queuecommand		= ata_scsi_queuecmd,
+	.eh_timed_out		= ata_scsi_timed_out,
 	.eh_strategy_handler	= ata_scsi_error,
 	.can_queue		= ATA_DEF_QUEUE,
 	.this_id		= ATA_SHT_THIS_ID,
diff --git a/drivers/scsi/pdc_adma.c b/drivers/scsi/pdc_adma.c
index 3a6bf58..d0ad3eb 100644
--- a/drivers/scsi/pdc_adma.c
+++ b/drivers/scsi/pdc_adma.c
@@ -143,6 +143,7 @@ static struct scsi_host_template adma_at
 	.name			= DRV_NAME,
 	.ioctl			= ata_scsi_ioctl,
 	.queuecommand		= ata_scsi_queuecmd,
+	.eh_timed_out		= ata_scsi_timed_out,
 	.eh_strategy_handler	= ata_scsi_error,
 	.can_queue		= ATA_DEF_QUEUE,
 	.this_id		= ATA_SHT_THIS_ID,
diff --git a/drivers/scsi/sata_mv.c b/drivers/scsi/sata_mv.c
index 3e91632..1db05f2 100644
--- a/drivers/scsi/sata_mv.c
+++ b/drivers/scsi/sata_mv.c
@@ -378,6 +378,7 @@ static struct scsi_host_template mv_sht 
 	.name			= DRV_NAME,
 	.ioctl			= ata_scsi_ioctl,
 	.queuecommand		= ata_scsi_queuecmd,
+	.eh_timed_out		= ata_scsi_timed_out,
 	.eh_strategy_handler	= ata_scsi_error,
 	.can_queue		= MV_USE_Q_DEPTH,
 	.this_id		= ATA_SHT_THIS_ID,
diff --git a/drivers/scsi/sata_nv.c b/drivers/scsi/sata_nv.c
index bbbb55e..cdfeb9a 100644
--- a/drivers/scsi/sata_nv.c
+++ b/drivers/scsi/sata_nv.c
@@ -229,6 +229,7 @@ static struct scsi_host_template nv_sht 
 	.name			= DRV_NAME,
 	.ioctl			= ata_scsi_ioctl,
 	.queuecommand		= ata_scsi_queuecmd,
+	.eh_timed_out		= ata_scsi_timed_out,
 	.eh_strategy_handler	= ata_scsi_error,
 	.can_queue		= ATA_DEF_QUEUE,
 	.this_id		= ATA_SHT_THIS_ID,
diff --git a/drivers/scsi/sata_promise.c b/drivers/scsi/sata_promise.c
index 0950a8e..5d4ed54 100644
--- a/drivers/scsi/sata_promise.c
+++ b/drivers/scsi/sata_promise.c
@@ -111,6 +111,7 @@ static struct scsi_host_template pdc_ata
 	.name			= DRV_NAME,
 	.ioctl			= ata_scsi_ioctl,
 	.queuecommand		= ata_scsi_queuecmd,
+	.eh_timed_out		= ata_scsi_timed_out,
 	.eh_strategy_handler	= ata_scsi_error,
 	.can_queue		= ATA_DEF_QUEUE,
 	.this_id		= ATA_SHT_THIS_ID,
diff --git a/drivers/scsi/sata_qstor.c b/drivers/scsi/sata_qstor.c
index 2afbeb7..82c3df7 100644
--- a/drivers/scsi/sata_qstor.c
+++ b/drivers/scsi/sata_qstor.c
@@ -132,6 +132,7 @@ static struct scsi_host_template qs_ata_
 	.name			= DRV_NAME,
 	.ioctl			= ata_scsi_ioctl,
 	.queuecommand		= ata_scsi_queuecmd,
+	.eh_timed_out		= ata_scsi_timed_out,
 	.eh_strategy_handler	= ata_scsi_error,
 	.can_queue		= ATA_DEF_QUEUE,
 	.this_id		= ATA_SHT_THIS_ID,
diff --git a/drivers/scsi/sata_sil.c b/drivers/scsi/sata_sil.c
index 17f74d3..f40f25e 100644
--- a/drivers/scsi/sata_sil.c
+++ b/drivers/scsi/sata_sil.c
@@ -135,6 +135,7 @@ static struct scsi_host_template sil_sht
 	.name			= DRV_NAME,
 	.ioctl			= ata_scsi_ioctl,
 	.queuecommand		= ata_scsi_queuecmd,
+	.eh_timed_out		= ata_scsi_timed_out,
 	.eh_strategy_handler	= ata_scsi_error,
 	.can_queue		= ATA_DEF_QUEUE,
 	.this_id		= ATA_SHT_THIS_ID,
diff --git a/drivers/scsi/sata_sil24.c b/drivers/scsi/sata_sil24.c
index 7222fc7..f4742ad 100644
--- a/drivers/scsi/sata_sil24.c
+++ b/drivers/scsi/sata_sil24.c
@@ -280,6 +280,7 @@ static struct scsi_host_template sil24_s
 	.name			= DRV_NAME,
 	.ioctl			= ata_scsi_ioctl,
 	.queuecommand		= ata_scsi_queuecmd,
+	.eh_timed_out		= ata_scsi_timed_out,
 	.eh_strategy_handler	= ata_scsi_error,
 	.can_queue		= ATA_DEF_QUEUE,
 	.this_id		= ATA_SHT_THIS_ID,
diff --git a/drivers/scsi/sata_sis.c b/drivers/scsi/sata_sis.c
index 2df8c56..2f18157 100644
--- a/drivers/scsi/sata_sis.c
+++ b/drivers/scsi/sata_sis.c
@@ -87,6 +87,7 @@ static struct scsi_host_template sis_sht
 	.name			= DRV_NAME,
 	.ioctl			= ata_scsi_ioctl,
 	.queuecommand		= ata_scsi_queuecmd,
+	.eh_timed_out		= ata_scsi_timed_out,
 	.eh_strategy_handler	= ata_scsi_error,
 	.can_queue		= ATA_DEF_QUEUE,
 	.this_id		= ATA_SHT_THIS_ID,
diff --git a/drivers/scsi/sata_svw.c b/drivers/scsi/sata_svw.c
index d847256..f369c30 100644
--- a/drivers/scsi/sata_svw.c
+++ b/drivers/scsi/sata_svw.c
@@ -288,6 +288,7 @@ static struct scsi_host_template k2_sata
 	.name			= DRV_NAME,
 	.ioctl			= ata_scsi_ioctl,
 	.queuecommand		= ata_scsi_queuecmd,
+	.eh_timed_out		= ata_scsi_timed_out,
 	.eh_strategy_handler	= ata_scsi_error,
 	.can_queue		= ATA_DEF_QUEUE,
 	.this_id		= ATA_SHT_THIS_ID,
diff --git a/drivers/scsi/sata_sx4.c b/drivers/scsi/sata_sx4.c
index 9f992fb..3319f03 100644
--- a/drivers/scsi/sata_sx4.c
+++ b/drivers/scsi/sata_sx4.c
@@ -182,6 +182,7 @@ static struct scsi_host_template pdc_sat
 	.name			= DRV_NAME,
 	.ioctl			= ata_scsi_ioctl,
 	.queuecommand		= ata_scsi_queuecmd,
+	.eh_timed_out		= ata_scsi_timed_out,
 	.eh_strategy_handler	= ata_scsi_error,
 	.can_queue		= ATA_DEF_QUEUE,
 	.this_id		= ATA_SHT_THIS_ID,
diff --git a/drivers/scsi/sata_uli.c b/drivers/scsi/sata_uli.c
index 9635ca7..c500f24 100644
--- a/drivers/scsi/sata_uli.c
+++ b/drivers/scsi/sata_uli.c
@@ -75,6 +75,7 @@ static struct scsi_host_template uli_sht
 	.name			= DRV_NAME,
 	.ioctl			= ata_scsi_ioctl,
 	.queuecommand		= ata_scsi_queuecmd,
+	.eh_timed_out		= ata_scsi_timed_out,
 	.eh_strategy_handler	= ata_scsi_error,
 	.can_queue		= ATA_DEF_QUEUE,
 	.this_id		= ATA_SHT_THIS_ID,
diff --git a/drivers/scsi/sata_via.c b/drivers/scsi/sata_via.c
index 6d5b0a7..2e20887 100644
--- a/drivers/scsi/sata_via.c
+++ b/drivers/scsi/sata_via.c
@@ -94,6 +94,7 @@ static struct scsi_host_template svia_sh
 	.name			= DRV_NAME,
 	.ioctl			= ata_scsi_ioctl,
 	.queuecommand		= ata_scsi_queuecmd,
+	.eh_timed_out		= ata_scsi_timed_out,
 	.eh_strategy_handler	= ata_scsi_error,
 	.can_queue		= ATA_DEF_QUEUE,
 	.this_id		= ATA_SHT_THIS_ID,
diff --git a/drivers/scsi/sata_vsc.c b/drivers/scsi/sata_vsc.c
index 2e2c3b7..cf1f8a6 100644
--- a/drivers/scsi/sata_vsc.c
+++ b/drivers/scsi/sata_vsc.c
@@ -223,6 +223,7 @@ static struct scsi_host_template vsc_sat
 	.name			= DRV_NAME,
 	.ioctl			= ata_scsi_ioctl,
 	.queuecommand		= ata_scsi_queuecmd,
+	.eh_timed_out		= ata_scsi_timed_out,
 	.eh_strategy_handler	= ata_scsi_error,
 	.can_queue		= ATA_DEF_QUEUE,
 	.this_id		= ATA_SHT_THIS_ID,
-- 
1.1.5


