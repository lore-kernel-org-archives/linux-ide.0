From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] libata-eh: Use switch() instead of sparse array for protocol strings
Date: Mon,  9 Jan 2017 15:49:28 +0100
Message-ID: <1483973368-6828-1-git-send-email-geert@linux-m68k.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from baptiste.telenet-ops.be ([195.130.132.51]:37690 "EHLO
        baptiste.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1033999AbdAIOti (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 9 Jan 2017 09:49:38 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>

Replace the sparse 256-pointer array for looking up protocol strings by
a switch() statement to reduce kernel size.

According to bloat-o-meter, this saves 910 bytes on m68k (32-bit), and
1892 bytes on arm64 (64-bit).

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/ata/libata-eh.c | 44 +++++++++++++++++++++++++++++++-------------
 1 file changed, 31 insertions(+), 13 deletions(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 0e1ec37070d19b64..e7196fc29ff09434 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -2606,21 +2606,39 @@ static void ata_eh_link_report(struct ata_link *link)
 				[DMA_TO_DEVICE]		= "out",
 				[DMA_FROM_DEVICE]	= "in",
 			};
-			static const char *prot_str[] = {
-				[ATA_PROT_UNKNOWN]	= "unknown",
-				[ATA_PROT_NODATA]	= "nodata",
-				[ATA_PROT_PIO]		= "pio",
-				[ATA_PROT_DMA]		= "dma",
-				[ATA_PROT_NCQ]		= "ncq dma",
-				[ATA_PROT_NCQ_NODATA]	= "ncq nodata",
-				[ATAPI_PROT_NODATA]	= "nodata",
-				[ATAPI_PROT_PIO]	= "pio",
-				[ATAPI_PROT_DMA]	= "dma",
-			};
+			const char *prot_str = NULL;
 
+			switch (qc->tf.protocol) {
+			case ATA_PROT_UNKNOWN:
+				prot_str = "unknown";
+				break;
+			case ATA_PROT_NODATA:
+				prot_str = "nodata";
+				break;
+			case ATA_PROT_PIO:
+				prot_str = "pio";
+				break;
+			case ATA_PROT_DMA:
+				prot_str = "dma";
+				break;
+			case ATA_PROT_NCQ:
+				prot_str = "ncq dma";
+				break;
+			case ATA_PROT_NCQ_NODATA:
+				prot_str = "ncq nodata";
+				break;
+			case ATAPI_PROT_NODATA:
+				prot_str = "nodata";
+				break;
+			case ATAPI_PROT_PIO:
+				prot_str = "pio";
+				break;
+			case ATAPI_PROT_DMA:
+				prot_str = "dma";
+				break;
+			}
 			snprintf(data_buf, sizeof(data_buf), " %s %u %s",
-				 prot_str[qc->tf.protocol], qc->nbytes,
-				 dma_str[qc->dma_dir]);
+				 prot_str, qc->nbytes, dma_str[qc->dma_dir]);
 		}
 
 		if (ata_is_atapi(qc->tf.protocol)) {
-- 
1.9.1

