From: "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 3/4] libata: READ LOG DMA EXT support can be in either page 119 or 120
Date: Mon,  4 May 2015 21:54:20 -0400
Message-ID: <1430790861-30066-3-git-send-email-martin.petersen@oracle.com>
References: <1430790861-30066-1-git-send-email-martin.petersen@oracle.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:48437 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932727AbbEEByg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 4 May 2015 21:54:36 -0400
In-Reply-To: <1430790861-30066-1-git-send-email-martin.petersen@oracle.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org
Cc: hare@suse.de, linux-ide@vger.kernel.org, "Martin K. Petersen" <martin.petersen@oracle.com>

Support for the READ/WRITE LOG DMA EXT commands can be signaled either
in page 119 or page 120. We should check both pages.

Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
---
 include/linux/ata.h | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/include/linux/ata.h b/include/linux/ata.h
index b666b773e111..fed36418dd1c 100644
--- a/include/linux/ata.h
+++ b/include/linux/ata.h
@@ -704,9 +704,19 @@ static inline bool ata_id_wcache_enabled(const u16 *id)
 
 static inline bool ata_id_has_read_log_dma_ext(const u16 *id)
 {
+	/* Word 86 must have bit 15 set */
 	if (!(id[ATA_ID_CFS_ENABLE_2] & (1 << 15)))
 		return false;
-	return id[ATA_ID_COMMAND_SET_3] & (1 << 3);
+
+	/* READ LOG DMA EXT support can be signaled either from word 119
+	 * or from word 120. The format is the same for both words: Bit
+	 * 15 must be cleared, bit 14 set and bit 3 set.
+	 */
+	if ((id[ATA_ID_COMMAND_SET_3] & 0xC008) == 0x4008 ||
+	    (id[ATA_ID_COMMAND_SET_4] & 0xC008) == 0x4008)
+		return true;
+
+	return false;
 }
 
 static inline bool ata_id_has_sense_reporting(const u16 *id)
-- 
1.9.3

