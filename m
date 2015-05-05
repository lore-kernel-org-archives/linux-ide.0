From: "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 4/4] libata: Fall back to unqueued READ LOG EXT if the DMA variant fails
Date: Mon,  4 May 2015 21:54:21 -0400
Message-ID: <1430790861-30066-4-git-send-email-martin.petersen@oracle.com>
References: <1430790861-30066-1-git-send-email-martin.petersen@oracle.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:48438 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932728AbbEEByh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 4 May 2015 21:54:37 -0400
In-Reply-To: <1430790861-30066-1-git-send-email-martin.petersen@oracle.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org
Cc: hare@suse.de, linux-ide@vger.kernel.org, "Martin K. Petersen" <martin.petersen@oracle.com>

Some devices advertise support for the READ/WRITE LOG DMA EXT commands
but fail when we try to issue them. This can lead to queued TRIM being
unintentionally disabled since the relevant feature flag is located in a
general purpose log page.

Fall back to unqueued READ LOG EXT if the DMA variant fails while
reading a log page.

Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
---
 drivers/ata/libata-eh.c | 12 +++++++++++-
 include/linux/libata.h  |  1 +
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 07f41be38fbe..2893563d0537 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -1507,13 +1507,17 @@ unsigned int ata_read_log_page(struct ata_device *dev, u8 log,
 {
 	struct ata_taskfile tf;
 	unsigned int err_mask;
+	bool dma = false;
 
 	DPRINTK("read log page - log 0x%x, page 0x%x\n", log, page);
 
+retry:
 	ata_tf_init(dev, &tf);
-	if (dev->dma_mode && ata_id_has_read_log_dma_ext(dev->id)) {
+	if (dev->dma_mode && ata_id_has_read_log_dma_ext(dev->id) &&
+	    !(dev->horkage & ATA_HORKAGE_NO_NCQ_LOG)) {
 		tf.command = ATA_CMD_READ_LOG_DMA_EXT;
 		tf.protocol = ATA_PROT_DMA;
+		dma = true;
 	} else {
 		tf.command = ATA_CMD_READ_LOG_EXT;
 		tf.protocol = ATA_PROT_PIO;
@@ -1527,6 +1531,12 @@ unsigned int ata_read_log_page(struct ata_device *dev, u8 log,
 	err_mask = ata_exec_internal(dev, &tf, NULL, DMA_FROM_DEVICE,
 				     buf, sectors * ATA_SECT_SIZE, 0);
 
+	if (err_mask && dma) {
+		dev->horkage |= ATA_HORKAGE_NO_NCQ_LOG;
+		ata_dev_warn(dev, "READ LOG DMA EXT failed, trying unqueued\n");
+		goto retry;
+	}
+
 	DPRINTK("EXIT, err_mask=%x\n", err_mask);
 	return err_mask;
 }
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 8dad4a307bb8..c3ef58014b33 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -424,6 +424,7 @@ enum {
 	ATA_HORKAGE_NOLPM	= (1 << 20),	/* don't use LPM */
 	ATA_HORKAGE_WD_BROKEN_LPM = (1 << 21),	/* some WDs have broken LPM */
 	ATA_HORKAGE_ZERO_AFTER_TRIM = (1 << 22),/* guarantees zero after trim */
+	ATA_HORKAGE_NO_NCQ_LOG	= (1 << 23),	/* don't use NCQ for log read */
 
 	 /* DMA mask for user DMA control: User visible values; DO NOT
 	    renumber */
-- 
1.9.3

