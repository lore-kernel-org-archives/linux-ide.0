From: Yaowei Bai <baiyaowei@cmss.chinamobile.com>
Subject: [PATCH 1/2] drivers/ata: delete unused ata_using_mwdma function
Date: Fri, 25 Mar 2016 10:11:59 +0800
Message-ID: <1458871920-3303-1-git-send-email-baiyaowei@cmss.chinamobile.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cmccmta3.chinamobile.com ([221.176.66.81]:8834 "EHLO
	cmccmta3.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751627AbcCYCNi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 24 Mar 2016 22:13:38 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, baiyaowei@cmss.chinamobile.com

There's no user of ata_using_mwdma since introduced by commit
b15b3ebae ("libata: Fix a large collection of DMA mode mismatches")
in 2008, so remove it.

Signed-off-by: Yaowei Bai <baiyaowei@cmss.chinamobile.com>
---
 include/linux/libata.h | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/include/linux/libata.h b/include/linux/libata.h
index 2c4ebef..2b01760 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -1759,13 +1759,6 @@ static inline unsigned long ata_deadline(unsigned long from_jiffies,
    change in future hardware and specs, secondly 0xFF means 'no DMA' but is
    > UDMA_0. Dyma ddreigiau */
 
-static inline int ata_using_mwdma(struct ata_device *adev)
-{
-	if (adev->dma_mode >= XFER_MW_DMA_0 && adev->dma_mode <= XFER_MW_DMA_4)
-		return 1;
-	return 0;
-}
-
 static inline int ata_using_udma(struct ata_device *adev)
 {
 	if (adev->dma_mode >= XFER_UDMA_0 && adev->dma_mode <= XFER_UDMA_7)
-- 
1.9.1



