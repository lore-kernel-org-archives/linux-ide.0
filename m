From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] ata: sata_dwc_460ex: Propagate platform device ID to DMA driver
Date: Fri, 10 Nov 2017 19:59:37 +0200
Message-ID: <20171110175937.83792-1-andriy.shevchenko@linux.intel.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:62273 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753579AbdKJR7m (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Fri, 10 Nov 2017 12:59:42 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Propagate platform device ID to DMA driver to distinguish relationship
between DMA and SATA instances.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/ata/sata_dwc_460ex.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.c
index ce128d5a6ded..6af4ec3c88c3 100644
--- a/drivers/ata/sata_dwc_460ex.c
+++ b/drivers/ata/sata_dwc_460ex.c
@@ -248,6 +248,7 @@ static int sata_dwc_dma_init_old(struct platform_device *pdev,
 		return -ENOMEM;
 
 	hsdev->dma->dev = &pdev->dev;
+	hsdev->dma->id = pdev->id;
 
 	/* Get SATA DMA interrupt number */
 	hsdev->dma->irq = irq_of_parse_and_map(np, 1);
-- 
2.14.2

