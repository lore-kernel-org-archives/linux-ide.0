From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/4] sata_dwc_460ex: fix resource leak on error path
Date: Wed,  7 Jan 2015 15:24:19 +0200
Message-ID: <1420637062-15450-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:23411 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752742AbbAGNY2 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 7 Jan 2015 08:24:28 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Miesfeld <mmiesfeld@amcc.com>, Jeff Garzik <jgarzik@redhat.com>, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

DMA mapped IO should be unmapped on the error path in probe() and
unconditionally on remove().

Fixes: 62936009f35a ([libata] Add 460EX on-chip SATA driver, sata_dwc_460ex)
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/ata/sata_dwc_460ex.c | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.c
index c7ddef8..8e824817 100644
--- a/drivers/ata/sata_dwc_460ex.c
+++ b/drivers/ata/sata_dwc_460ex.c
@@ -797,7 +797,7 @@ static int dma_dwc_init(struct sata_dwc_device *hsdev, int irq)
 	if (err) {
 		dev_err(host_pvt.dwc_dev, "%s: dma_request_interrupts returns"
 			" %d\n", __func__, err);
-		goto error_out;
+		return err;
 	}
 
 	/* Enabe DMA */
@@ -808,11 +808,6 @@ static int dma_dwc_init(struct sata_dwc_device *hsdev, int irq)
 		sata_dma_regs);
 
 	return 0;
-
-error_out:
-	dma_dwc_exit(hsdev);
-
-	return err;
 }
 
 static int sata_dwc_scr_read(struct ata_link *link, unsigned int scr, u32 *val)
@@ -1662,7 +1657,7 @@ static int sata_dwc_probe(struct platform_device *ofdev)
 	char *ver = (char *)&versionr;
 	u8 *base = NULL;
 	int err = 0;
-	int irq, rc;
+	int irq;
 	struct ata_host *host;
 	struct ata_port_info pi = sata_dwc_port_info[0];
 	const struct ata_port_info *ppi[] = { &pi, NULL };
@@ -1725,7 +1720,7 @@ static int sata_dwc_probe(struct platform_device *ofdev)
 	if (irq == NO_IRQ) {
 		dev_err(&ofdev->dev, "no SATA DMA irq\n");
 		err = -ENODEV;
-		goto error_out;
+		goto error_iomap;
 	}
 
 	/* Get physical SATA DMA register base address */
@@ -1734,14 +1729,16 @@ static int sata_dwc_probe(struct platform_device *ofdev)
 		dev_err(&ofdev->dev, "ioremap failed for AHBDMA register"
 			" address\n");
 		err = -ENODEV;
-		goto error_out;
+		goto error_iomap;
 	}
 
 	/* Save dev for later use in dev_xxx() routines */
 	host_pvt.dwc_dev = &ofdev->dev;
 
 	/* Initialize AHB DMAC */
-	dma_dwc_init(hsdev, irq);
+	err = dma_dwc_init(hsdev, irq);
+	if (err)
+		goto error_dma_iomap;
 
 	/* Enable SATA Interrupts */
 	sata_dwc_enable_interrupts(hsdev);
@@ -1759,9 +1756,8 @@ static int sata_dwc_probe(struct platform_device *ofdev)
 	 * device discovery process, invoking our port_start() handler &
 	 * error_handler() to execute a dummy Softreset EH session
 	 */
-	rc = ata_host_activate(host, irq, sata_dwc_isr, 0, &sata_dwc_sht);
-
-	if (rc != 0)
+	err = ata_host_activate(host, irq, sata_dwc_isr, 0, &sata_dwc_sht);
+	if (err)
 		dev_err(&ofdev->dev, "failed to activate host");
 
 	dev_set_drvdata(&ofdev->dev, host);
@@ -1770,7 +1766,8 @@ static int sata_dwc_probe(struct platform_device *ofdev)
 error_out:
 	/* Free SATA DMA resources */
 	dma_dwc_exit(hsdev);
-
+error_dma_iomap:
+	iounmap((void __iomem *)host_pvt.sata_dma_regs);
 error_iomap:
 	iounmap(base);
 error_kmalloc:
@@ -1791,6 +1788,7 @@ static int sata_dwc_remove(struct platform_device *ofdev)
 	/* Free SATA DMA resources */
 	dma_dwc_exit(hsdev);
 
+	iounmap((void __iomem *)host_pvt.sata_dma_regs);
 	iounmap(hsdev->reg_base);
 	kfree(hsdev);
 	kfree(host);
-- 
2.1.3

