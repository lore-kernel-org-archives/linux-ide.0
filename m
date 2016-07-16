From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 2/3] libata: remove ATA_PROT_FLAG_DATA
Date: Sat, 16 Jul 2016 22:16:42 +0900
Message-ID: <1468675003-13701-3-git-send-email-hch@lst.de>
References: <1468675003-13701-1-git-send-email-hch@lst.de>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:50484 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751593AbcGPNQv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 16 Jul 2016 09:16:51 -0400
In-Reply-To: <1468675003-13701-1-git-send-email-hch@lst.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org
Cc: linux-ide@vger.kernel.org

Instead we can simply check for PIO or DMA in ata_is_data.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/libata.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/linux/libata.h b/include/linux/libata.h
index 283b6be..5838fbf 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -149,7 +149,6 @@ enum {
 	/* protocol flags */
 	ATA_PROT_FLAG_PIO	= (1 << 0), /* is PIO */
 	ATA_PROT_FLAG_DMA	= (1 << 1), /* is DMA */
-	ATA_PROT_FLAG_DATA	= ATA_PROT_FLAG_PIO | ATA_PROT_FLAG_DMA,
 	ATA_PROT_FLAG_NCQ	= (1 << 2), /* is NCQ */
 	ATA_PROT_FLAG_ATAPI	= (1 << 3), /* is ATAPI */
 
@@ -1087,7 +1086,7 @@ static inline bool ata_is_ncq(u8 prot)
 
 static inline bool ata_is_data(u8 prot)
 {
-	return ata_prot_flags(prot) & ATA_PROT_FLAG_DATA;
+	return ata_prot_flags(prot) & (ATA_PROT_FLAG_PIO | ATA_PROT_FLAG_DMA);
 }
 
 static inline int is_multi_taskfile(struct ata_taskfile *tf)
-- 
2.1.4

