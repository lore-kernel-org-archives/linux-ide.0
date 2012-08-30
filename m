From: Shane Huang <shane.huang@amd.com>
Subject: [PATCH v3 1/2] ata: define enum constants for IDENTIFY DEVICE
Date: Thu, 30 Aug 2012 22:52:42 +0800
Message-ID: <1346338362-2266-1-git-send-email-shane.huang@amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from va3ehsobe002.messaging.microsoft.com ([216.32.180.12]:54042
	"EHLO va3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751526Ab2H3Gwx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 30 Aug 2012 02:52:53 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, Aaron Lu <aaron.lwe@gmail.com>, Shane Huang <shane.huang@amd.com>

Define enumeration constants for IDENTIFY DEVICE words.

Signed-off-by: Shane Huang <shane.huang@amd.com>
---
 include/linux/ata.h |   21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/include/linux/ata.h b/include/linux/ata.h
index 5713d3a..47a9dbf 100644
--- a/include/linux/ata.h
+++ b/include/linux/ata.h
@@ -77,6 +77,9 @@ enum {
 	ATA_ID_EIDE_PIO_IORDY	= 68,
 	ATA_ID_ADDITIONAL_SUPP	= 69,
 	ATA_ID_QUEUE_DEPTH	= 75,
+	ATA_ID_SATA_CAPABILITY	= 76,
+	ATA_ID_SATA_CAPABILITY_2	= 77,
+	ATA_ID_FEATURE_SUPP	= 78,
 	ATA_ID_MAJOR_VER	= 80,
 	ATA_ID_COMMAND_SET_1	= 82,
 	ATA_ID_COMMAND_SET_2	= 83,
@@ -558,15 +561,17 @@ static inline int ata_is_data(u8 prot)
 #define ata_id_is_ata(id)	(((id)[ATA_ID_CONFIG] & (1 << 15)) == 0)
 #define ata_id_has_lba(id)	((id)[ATA_ID_CAPABILITY] & (1 << 9))
 #define ata_id_has_dma(id)	((id)[ATA_ID_CAPABILITY] & (1 << 8))
-#define ata_id_has_ncq(id)	((id)[76] & (1 << 8))
+#define ata_id_has_ncq(id)	((id)[ATA_ID_SATA_CAPABILITY] & (1 << 8))
 #define ata_id_queue_depth(id)	(((id)[ATA_ID_QUEUE_DEPTH] & 0x1f) + 1)
 #define ata_id_removeable(id)	((id)[ATA_ID_CONFIG] & (1 << 7))
 #define ata_id_has_atapi_AN(id)	\
-	( (((id)[76] != 0x0000) && ((id)[76] != 0xffff)) && \
-	  ((id)[78] & (1 << 5)) )
+	((((id)[ATA_ID_SATA_CAPABILITY] != 0x0000) && \
+	  ((id)[ATA_ID_SATA_CAPABILITY] != 0xffff)) && \
+	 ((id)[ATA_ID_FEATURE_SUPP] & (1 << 5)))
 #define ata_id_has_fpdma_aa(id)	\
-	( (((id)[76] != 0x0000) && ((id)[76] != 0xffff)) && \
-	  ((id)[78] & (1 << 2)) )
+	((((id)[ATA_ID_SATA_CAPABILITY] != 0x0000) && \
+	  ((id)[ATA_ID_SATA_CAPABILITY] != 0xffff)) && \
+	 ((id)[ATA_ID_FEATURE_SUPP] & (1 << 2)))
 #define ata_id_iordy_disable(id) ((id)[ATA_ID_CAPABILITY] & (1 << 10))
 #define ata_id_has_iordy(id) ((id)[ATA_ID_CAPABILITY] & (1 << 11))
 #define ata_id_u32(id,n)	\
@@ -578,11 +583,11 @@ static inline int ata_is_data(u8 prot)
 	  ((u64) (id)[(n) + 0]) )
 
 #define ata_id_cdb_intr(id)	(((id)[ATA_ID_CONFIG] & 0x60) == 0x20)
-#define ata_id_has_da(id)	((id)[77] & (1 << 4))
+#define ata_id_has_da(id)	((id)[ATA_ID_SATA_CAPABILITY_2] & (1 << 4))
 
 static inline bool ata_id_has_hipm(const u16 *id)
 {
-	u16 val = id[76];
+	u16 val = id[ATA_ID_SATA_CAPABILITY];
 
 	if (val == 0 || val == 0xffff)
 		return false;
@@ -592,7 +597,7 @@ static inline bool ata_id_has_hipm(const u16 *id)
 
 static inline bool ata_id_has_dipm(const u16 *id)
 {
-	u16 val = id[78];
+	u16 val = id[ATA_ID_FEATURE_SUPP];
 
 	if (val == 0 || val == 0xffff)
 		return false;
-- 
1.7.9.5


