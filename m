From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 10/11] libata-pmp-prep: implement ATA_HORKAGE_SKIP_PM
Date: Mon, 16 Jul 2007 18:39:47 +0900
Message-ID: <11845787871886-git-send-email-htejun@gmail.com>
References: <1184578783463-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.229]:51458 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755382AbXGPJj4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 16 Jul 2007 05:39:56 -0400
Received: by nz-out-0506.google.com with SMTP id s18so783516nze
        for <linux-ide@vger.kernel.org>; Mon, 16 Jul 2007 02:39:56 -0700 (PDT)
In-Reply-To: <1184578783463-git-send-email-htejun@gmail.com>
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
index 1a1c018..3b8693f 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -950,6 +950,13 @@ static unsigned int ata_scsi_start_stop_xlat(struct ata_queued_cmd *qc)
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
index 717fdb5..4e37180 100644
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


