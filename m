From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 11/12] libata-pmp-prep: implement ATA_HORKAGE_SKIP_PM
Date: Sun, 1 Jul 2007 19:26:09 +0900
Message-ID: <1183285569556-git-send-email-htejun@gmail.com>
References: <11832855672398-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.182]:25193 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755616AbXGAK0R (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 1 Jul 2007 06:26:17 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1884708wah
        for <linux-ide@vger.kernel.org>; Sun, 01 Jul 2007 03:26:16 -0700 (PDT)
In-Reply-To: <11832855672398-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, Forrest Zhao <forrest.zhao@gmail.com>
Cc: Tejun Heo <htejun@gmail.com>

Some pseudo devices fail PM commands unnecessarily aborting system
suspend.  Implement ATA_HORKAGE_SKIP_PM which makes libata skip PM
commands for these devices.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-scsi.c |    7 +++++++
 include/linux/libata.h    |    1 +
 2 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 680850f..6317533 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -950,6 +950,13 @@ static unsigned int ata_scsi_start_stop_xlat(struct ata_queued_cmd *qc)
 		goto invalid_fld;       /* LOEJ bit set not supported */
 	if (((cdb[4] >> 4) & 0xf) != 0)
 		goto invalid_fld;       /* power conditions not supported */
+
+	if (ata_device_blacklisted(qc->dev) & ATA_HORKAGE_SKIP_PM) {
+		/* the device lacks PM support, finish without doing anything */
+		scmd->result = SAM_STAT_GOOD;
+		return 1;
+	}
+
 	if (cdb[4] & 0x1) {
 		tf->nsect = 1;	/* 1 sector, lba=0 */
 
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 6b7b346..d41da74 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -325,6 +325,7 @@ enum {
 	ATA_HORKAGE_NODMA	= (1 << 1),	/* DMA problems */
 	ATA_HORKAGE_NONCQ	= (1 << 2),	/* Don't use NCQ */
 	ATA_HORKAGE_MAX_SEC_128	= (1 << 3),	/* Limit max sects to 128 */
+	ATA_HORKAGE_SKIP_PM	= (1 << 4),	/* Skip PM operations */
 };
 
 enum hsm_task_states {
-- 
1.5.0.3


