From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/3] sata_dwc_460ex: use np local variable in ->probe()
Date: Thu,  8 Jan 2015 12:50:12 +0200
Message-ID: <1420714214-16950-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:51406 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754289AbbAHKuD (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 8 Jan 2015 05:50:03 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Rupjyoti Sarmah <rsarmah@amcc.com>, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

This patch fixes the style of usage of a node pointer. There is no functional
change.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/ata/sata_dwc_460ex.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.c
index 6c1b649..b206017 100644
--- a/drivers/ata/sata_dwc_460ex.c
+++ b/drivers/ata/sata_dwc_460ex.c
@@ -1691,7 +1691,7 @@ static int sata_dwc_probe(struct platform_device *ofdev)
 	host_pvt.dma_channel = dma_chan;
 
 	/* Ioremap SATA registers */
-	base = of_iomap(ofdev->dev.of_node, 0);
+	base = of_iomap(np, 0);
 	if (!base) {
 		dev_err(&ofdev->dev, "ioremap failed for SATA register"
 			" address\n");
@@ -1727,7 +1727,7 @@ static int sata_dwc_probe(struct platform_device *ofdev)
 		   idr, ver[0], ver[1], ver[2]);
 
 	/* Get SATA DMA interrupt number */
-	irq = irq_of_parse_and_map(ofdev->dev.of_node, 1);
+	irq = irq_of_parse_and_map(np, 1);
 	if (irq == NO_IRQ) {
 		dev_err(&ofdev->dev, "no SATA DMA irq\n");
 		err = -ENODEV;
@@ -1735,7 +1735,7 @@ static int sata_dwc_probe(struct platform_device *ofdev)
 	}
 
 	/* Get physical SATA DMA register base address */
-	host_pvt.sata_dma_regs = (void *)of_iomap(ofdev->dev.of_node, 1);
+	host_pvt.sata_dma_regs = (void *)of_iomap(np, 1);
 	if (!(host_pvt.sata_dma_regs)) {
 		dev_err(&ofdev->dev, "ioremap failed for AHBDMA register"
 			" address\n");
@@ -1755,7 +1755,7 @@ static int sata_dwc_probe(struct platform_device *ofdev)
 	sata_dwc_enable_interrupts(hsdev);
 
 	/* Get SATA interrupt number */
-	irq = irq_of_parse_and_map(ofdev->dev.of_node, 0);
+	irq = irq_of_parse_and_map(np, 0);
 	if (irq == NO_IRQ) {
 		dev_err(&ofdev->dev, "no SATA DMA irq\n");
 		err = -ENODEV;
-- 
2.1.3

