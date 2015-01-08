From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 3/3] sata_dwc_460ex: convert to devm_kzalloc in ->probe()
Date: Thu,  8 Jan 2015 12:50:14 +0200
Message-ID: <1420714214-16950-3-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1420714214-16950-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:51653 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756315AbbAHKwJ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 8 Jan 2015 05:52:09 -0500
In-Reply-To: <1420714214-16950-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Rupjyoti Sarmah <rsarmah@amcc.com>, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

The patch converts ->probe() to use devm_kzalloc that simplifies error path.
Note that ata_host_alloc_pinfo() has been using device resources already.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/ata/sata_dwc_460ex.c | 24 ++++++------------------
 1 file changed, 6 insertions(+), 18 deletions(-)

diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.c
index 169cbca..fdb0f28 100644
--- a/drivers/ata/sata_dwc_460ex.c
+++ b/drivers/ata/sata_dwc_460ex.c
@@ -1676,10 +1676,13 @@ static int sata_dwc_probe(struct platform_device *ofdev)
 	u32 dma_chan;
 
 	/* Allocate DWC SATA device */
-	hsdev = kzalloc(sizeof(*hsdev), GFP_KERNEL);
-	if (hsdev == NULL)
+	host = ata_host_alloc_pinfo(&ofdev->dev, ppi, SATA_DWC_MAX_PORTS);
+	hsdev = devm_kzalloc(&ofdev->dev, sizeof(*hsdev), GFP_KERNEL);
+	if (!host || !hsdev)
 		return -ENOMEM;
 
+	host->private_data = hsdev;
+
 	if (of_property_read_u32(np, "dma-channel", &dma_chan)) {
 		dev_warn(&ofdev->dev, "no dma-channel property set."
 			 " Use channel 0\n");
@@ -1692,8 +1695,7 @@ static int sata_dwc_probe(struct platform_device *ofdev)
 	if (!base) {
 		dev_err(&ofdev->dev, "ioremap failed for SATA register"
 			" address\n");
-		err = -ENODEV;
-		goto error_kmalloc;
+		return -ENODEV;
 	}
 	hsdev->reg_base = base;
 	dev_dbg(&ofdev->dev, "ioremap done for SATA register address\n");
@@ -1701,16 +1703,6 @@ static int sata_dwc_probe(struct platform_device *ofdev)
 	/* Synopsys DWC SATA specific Registers */
 	hsdev->sata_dwc_regs = (void *__iomem)(base + SATA_DWC_REG_OFFSET);
 
-	/* Allocate and fill host */
-	host = ata_host_alloc_pinfo(&ofdev->dev, ppi, SATA_DWC_MAX_PORTS);
-	if (!host) {
-		dev_err(&ofdev->dev, "ata_host_alloc_pinfo failed\n");
-		err = -ENOMEM;
-		goto error_iomap;
-	}
-
-	host->private_data = hsdev;
-
 	/* Setup port */
 	host->ports[0]->ioaddr.cmd_addr = base;
 	host->ports[0]->ioaddr.scr_addr = base + SATA_DWC_SCR_OFFSET;
@@ -1778,8 +1770,6 @@ error_dma_iomap:
 	iounmap((void __iomem *)host_pvt.sata_dma_regs);
 error_iomap:
 	iounmap(base);
-error_kmalloc:
-	kfree(hsdev);
 	return err;
 }
 
@@ -1796,8 +1786,6 @@ static int sata_dwc_remove(struct platform_device *ofdev)
 
 	iounmap((void __iomem *)host_pvt.sata_dma_regs);
 	iounmap(hsdev->reg_base);
-	kfree(hsdev);
-	kfree(host);
 	dev_dbg(&ofdev->dev, "done\n");
 	return 0;
 }
-- 
2.1.3

