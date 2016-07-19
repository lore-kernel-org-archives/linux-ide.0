From: Wei Yongjun <weiyj_lk@163.com>
Subject: [PATCH -next] ata: sata_dwc_460ex: remove redundant dev_err call
Date: Tue, 19 Jul 2016 11:27:53 +0000
Message-ID: <1468927673-437-1-git-send-email-weiyj_lk@163.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from m12-12.163.com ([220.181.12.12]:42515 "EHLO m12-12.163.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753009AbcGSL2E (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 19 Jul 2016 07:28:04 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Wei Yongjun <yongjun_wei@trendmicro.com.cn>, linux-ide@vger.kernel.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

There is a error message within devm_ioremap_resource
already, so remove the dev_err call to avoid redundant
error message.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 drivers/ata/sata_dwc_460ex.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.c
index fa1530a..62ead5a 100644
--- a/drivers/ata/sata_dwc_460ex.c
+++ b/drivers/ata/sata_dwc_460ex.c
@@ -259,11 +259,8 @@ static int sata_dwc_dma_init_old(struct platform_device *pdev,
 	/* Get physical SATA DMA register base address */
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
 	hsdev->dma->regs = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(hsdev->dma->regs)) {
-		dev_err(&pdev->dev,
-			"ioremap failed for AHBDMA register address\n");
+	if (IS_ERR(hsdev->dma->regs))
 		return PTR_ERR(hsdev->dma->regs);
-	}
 
 	/* Initialize AHB DMAC */
 	return dw_dma_probe(hsdev->dma);
@@ -1227,11 +1224,8 @@ static int sata_dwc_probe(struct platform_device *ofdev)
 	/* Ioremap SATA registers */
 	res = platform_get_resource(ofdev, IORESOURCE_MEM, 0);
 	base = devm_ioremap_resource(&ofdev->dev, res);
-	if (IS_ERR(base)) {
-		dev_err(&ofdev->dev,
-			"ioremap failed for SATA register address\n");
+	if (IS_ERR(base))
 		return PTR_ERR(base);
-	}
 	dev_dbg(&ofdev->dev, "ioremap done for SATA register address\n");
 
 	/* Synopsys DWC SATA specific Registers */


