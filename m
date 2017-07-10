From: Damien Le Moal <damien.lemoal@wdc.com>
Subject: [PATCH] libata: Cleanup ata_read_log_page()
Date: Mon, 10 Jul 2017 14:45:20 +0900
Message-ID: <20170710054520.24213-1-damien.lemoal@wdc.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:59889 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753350AbdGJFpY (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 10 Jul 2017 01:45:24 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, Tejun Heo <tj@kernel.org>
Cc: Hannes Reinecke <hare@suse.de>

The warning message "READ LOG DMA EXT failed, trying unqueued" in
ata_read_log_page() as well as the macro name ATA_HORKAGE_NO_NCQ_LOG
are confusing: the command READ LOG DMA EXT is not an queued NCQ command
unless it is encapsulated in a RECEIVE FPDMA QUEUED command.
>From ACS-4 READ LOG DMA EXT description:

"The device processes the READ LOG DMA EXT command in the NCQ feature
set environment (see 4.13.6) if the READ LOG DMA EXT command is
encapsulated in a RECEIVE FPDMA QUEUED command (see 7.30) with the
inputs encapsulated as shown in 7.23.6."

To avoid confusion, fix the warning messsage to mention switching to PIO and
not "unqueued" and rename the macro ATA_HORKAGE_NO_NCQ_LOG to
ATA_HORKAGE_NO_DMA_LOG.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 drivers/ata/libata-eh.c | 6 +++---
 include/linux/libata.h  | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index ef68232..f3f5125 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -1523,7 +1523,7 @@ unsigned int ata_read_log_page(struct ata_device *dev, u8 log,
 retry:
 	ata_tf_init(dev, &tf);
 	if (dev->dma_mode && ata_id_has_read_log_dma_ext(dev->id) &&
-	    !(dev->horkage & ATA_HORKAGE_NO_NCQ_LOG)) {
+	    !(dev->horkage & ATA_HORKAGE_NO_DMA_LOG)) {
 		tf.command = ATA_CMD_READ_LOG_DMA_EXT;
 		tf.protocol = ATA_PROT_DMA;
 		dma = true;
@@ -1542,8 +1542,8 @@ unsigned int ata_read_log_page(struct ata_device *dev, u8 log,
 				     buf, sectors * ATA_SECT_SIZE, 0);
 
 	if (err_mask && dma) {
-		dev->horkage |= ATA_HORKAGE_NO_NCQ_LOG;
-		ata_dev_warn(dev, "READ LOG DMA EXT failed, trying unqueued\n");
+		dev->horkage |= ATA_HORKAGE_NO_DMA_LOG;
+		ata_dev_warn(dev, "READ LOG DMA EXT failed, trying PIO\n");
 		goto retry;
 	}
 
diff --git a/include/linux/libata.h b/include/linux/libata.h
index c9a69fc..4718e85 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -434,7 +434,7 @@ enum {
 	ATA_HORKAGE_NOLPM	= (1 << 20),	/* don't use LPM */
 	ATA_HORKAGE_WD_BROKEN_LPM = (1 << 21),	/* some WDs have broken LPM */
 	ATA_HORKAGE_ZERO_AFTER_TRIM = (1 << 22),/* guarantees zero after trim */
-	ATA_HORKAGE_NO_NCQ_LOG	= (1 << 23),	/* don't use NCQ for log read */
+	ATA_HORKAGE_NO_DMA_LOG	= (1 << 23),	/* don't use DMA for log read */
 	ATA_HORKAGE_NOTRIM	= (1 << 24),	/* don't use TRIM */
 	ATA_HORKAGE_MAX_SEC_1024 = (1 << 25),	/* Limit max sects to 1024 */
 
-- 
2.9.4

