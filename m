From: Yaowei Bai <baiyaowei@cmss.chinamobile.com>
Subject: [PATCH 2/2] drivers/ata: make ata_using_udma return directly and bool
Date: Fri, 25 Mar 2016 10:12:00 +0800
Message-ID: <1458871920-3303-2-git-send-email-baiyaowei@cmss.chinamobile.com>
References: <1458871920-3303-1-git-send-email-baiyaowei@cmss.chinamobile.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1458871920-3303-1-git-send-email-baiyaowei@cmss.chinamobile.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tj@kernel.org
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, baiyaowei@cmss.chinamobile.com
List-Id: linux-ide@vger.kernel.org

This patch makes ata_using_udma return bool due to this
particular function only using either one or zero as its return
value.

This patch also makes ata_using_udma return directly by removing
if condition.

No functional change.

Signed-off-by: Yaowei Bai <baiyaowei@cmss.chinamobile.com>
---
 include/linux/libata.h | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/include/linux/libata.h b/include/linux/libata.h
index 2b01760..5dc2083 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -1759,11 +1759,9 @@ static inline unsigned long ata_deadline(unsigned long from_jiffies,
    change in future hardware and specs, secondly 0xFF means 'no DMA' but is
    > UDMA_0. Dyma ddreigiau */
 
-static inline int ata_using_udma(struct ata_device *adev)
+static inline bool ata_using_udma(struct ata_device *adev)
 {
-	if (adev->dma_mode >= XFER_UDMA_0 && adev->dma_mode <= XFER_UDMA_7)
-		return 1;
-	return 0;
+	return adev->dma_mode >= XFER_UDMA_0 && adev->dma_mode <= XFER_UDMA_7;
 }
 
 static inline int ata_dma_enabled(struct ata_device *adev)
-- 
1.9.1
