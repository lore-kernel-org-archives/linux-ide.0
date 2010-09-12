From: Vasiliy Kulikov <segooon@gmail.com>
Subject: [PATCH] ata: sata_dwc_460ex: fix error path
Date: Sun, 12 Sep 2010 22:57:08 +0400
Message-ID: <1284317830-5022-1-git-send-email-segooon@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: kernel-janitors@vger.kernel.org
Cc: Jeff Garzik <jgarzik@pobox.com>, Stephen Rothwell <sfr@canb.auug.org.au>, Rupjyoti Sarmah <rsarmah@appliedmicro.com>, Prodyut Hazarika <phazarika@appliedmicro.com>, Grant Likely <grant.likely@secretlab.ca>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Free all allocated resources on error path.

Signed-off-by: Vasiliy Kulikov <segooon@gmail.com>
---
 I cannot compile this driver at all, so it is not tested.

 drivers/ata/sata_dwc_460ex.c |   21 ++++++++++++++-------
 1 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.c
index 6cf57c5..ad0535f 100644
--- a/drivers/ata/sata_dwc_460ex.c
+++ b/drivers/ata/sata_dwc_460ex.c
@@ -727,11 +727,15 @@ static int dma_dwc_xfer_setup(struct scatterlist *sg, int num_elems,
 static void dma_dwc_exit(struct sata_dwc_device *hsdev)
 {
 	dev_dbg(host_pvt.dwc_dev, "%s:\n", __func__);
-	if (host_pvt.sata_dma_regs)
+	if (host_pvt.sata_dma_regs) {
 		iounmap(host_pvt.sata_dma_regs);
+		host_pvt.sata_dma_regs = NULL;
+	}
 
-	if (hsdev->irq_dma)
+	if (hsdev->irq_dma) {
 		free_irq(hsdev->irq_dma, hsdev);
+		hsdev->irq_dma = 0;
+	}
 }
 
 /*
@@ -1606,7 +1610,7 @@ static int sata_dwc_probe(struct platform_device *ofdev,
 	if (hsdev == NULL) {
 		dev_err(&ofdev->dev, "kmalloc failed for hsdev\n");
 		err = -ENOMEM;
-		goto error_out;
+		goto error;
 	}
 	memset(hsdev, 0, sizeof(*hsdev));
 
@@ -1616,7 +1620,7 @@ static int sata_dwc_probe(struct platform_device *ofdev,
 		dev_err(&ofdev->dev, "ioremap failed for SATA register"
 			" address\n");
 		err = -ENODEV;
-		goto error_out;
+		goto error_kmalloc;
 	}
 	hsdev->reg_base = base;
 	dev_dbg(&ofdev->dev, "ioremap done for SATA register address\n");
@@ -1629,7 +1633,7 @@ static int sata_dwc_probe(struct platform_device *ofdev,
 	if (!host) {
 		dev_err(&ofdev->dev, "ata_host_alloc_pinfo failed\n");
 		err = -ENOMEM;
-		goto error_out;
+		goto error_iomap;
 	}
 
 	host->private_data = hsdev;
@@ -1697,8 +1701,11 @@ error_out:
 	/* Free SATA DMA resources */
 	dma_dwc_exit(hsdev);
 
-	if (base)
-		iounmap(base);
+error_iomap:
+	iounmap(base);
+error_kmalloc:
+	kfree(hsdev);
+error:
 	return err;
 }
 
-- 
1.7.0.4
