From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 11/12] libata-pmp-prep: implement ATA_HORKAGE_SKIP_PM
Date: Sun, 23 Sep 2007 13:14:13 +0900
Message-ID: <11905208531559-git-send-email-htejun@gmail.com>
References: <11905208513747-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.190]:50630 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752657AbXIWEOa (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 23 Sep 2007 00:14:30 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1140954rvb
        for <linux-ide@vger.kernel.org>; Sat, 22 Sep 2007 21:14:29 -0700 (PDT)
In-Reply-To: <11905208513747-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org
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
index eb611b4..a651bdd 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -945,6 +945,13 @@ static unsigned int ata_scsi_start_stop_xlat(struct ata_queued_cmd *qc)
 		goto invalid_fld;       /* LOEJ bit set not supported */
 	if (((cdb[4] >> 4) & 0xf) != 0)
 		goto invalid_fld;       /* power conditions not supported */
+
+	if (qc->dev->horkage & ATA_HORKAGE_SKIP_PM) {
+		/* the device lacks PM support, finish without doing anything */
+		scmd->result = SAM_STAT_GOOD;
+		return 1;
+	}
+
 	if (cdb[4] & 0x1) {
 		tf->nsect = 1;	/* 1 sector, lba=0 */
 
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 2bd1d26..56b2187 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -329,6 +329,7 @@ enum {
 	ATA_HORKAGE_NONCQ	= (1 << 2),	/* Don't use NCQ */
 	ATA_HORKAGE_MAX_SEC_128	= (1 << 3),	/* Limit max sects to 128 */
 	ATA_HORKAGE_BROKEN_HPA	= (1 << 4),	/* Broken HPA */
+	ATA_HORKAGE_SKIP_PM	= (1 << 5),	/* Skip PM operations */
 };
 
 enum hsm_task_states {
-- 
1.5.0.3


