From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 1/3] libata: remove ata_is_nodata
Date: Sat, 16 Jul 2016 22:16:41 +0900
Message-ID: <1468675003-13701-2-git-send-email-hch@lst.de>
References: <1468675003-13701-1-git-send-email-hch@lst.de>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:50481 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751593AbcGPNQs (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 16 Jul 2016 09:16:48 -0400
In-Reply-To: <1468675003-13701-1-git-send-email-hch@lst.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org
Cc: linux-ide@vger.kernel.org

The only caller an just check for !ata_is_data instead.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/ata/libata-core.c | 2 +-
 include/linux/libata.h    | 5 -----
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 522848a..0749f71 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -5044,7 +5044,7 @@ static void ata_verify_xfer(struct ata_queued_cmd *qc)
 {
 	struct ata_device *dev = qc->dev;
 
-	if (ata_is_nodata(qc->tf.protocol))
+	if (!ata_is_data(qc->tf.protocol))
 		return;
 
 	if ((dev->mwdma_mask || dev->udma_mask) && ata_is_pio(qc->tf.protocol))
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 1abd669..283b6be 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -1070,11 +1070,6 @@ static inline bool ata_is_atapi(u8 prot)
 	return ata_prot_flags(prot) & ATA_PROT_FLAG_ATAPI;
 }
 
-static inline bool ata_is_nodata(u8 prot)
-{
-	return !(ata_prot_flags(prot) & ATA_PROT_FLAG_DATA);
-}
-
 static inline bool ata_is_pio(u8 prot)
 {
 	return ata_prot_flags(prot) & ATA_PROT_FLAG_PIO;
-- 
2.1.4

