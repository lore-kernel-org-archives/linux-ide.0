From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 5/8] sata_sil24: enable 64bit
Date: Wed, 5 Apr 2006 22:29:02 +0900
Message-ID: <11442437424186-git-send-email-htejun@gmail.com>
References: <11442437413563-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.229]:7450 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751135AbWDEN3O (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 5 Apr 2006 09:29:14 -0400
Received: by wproxy.gmail.com with SMTP id i7so187751wra
        for <linux-ide@vger.kernel.org>; Wed, 05 Apr 2006 06:29:14 -0700 (PDT)
In-Reply-To: <11442437413563-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, Carlos.Pardo@siliconimage.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Enable 64bit.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/sata_sil24.c |   47 +++++++++++++++++++++++++++------------------
 1 files changed, 28 insertions(+), 19 deletions(-)

5cb76b87a81b68e230343cec82e75b1fb3335c73
diff --git a/drivers/scsi/sata_sil24.c b/drivers/scsi/sata_sil24.c
index 0941f74..f50a728 100644
--- a/drivers/scsi/sata_sil24.c
+++ b/drivers/scsi/sata_sil24.c
@@ -480,6 +480,7 @@ static int sil24_softreset(struct ata_po
 	prb->fis[1] = 0; /* no PM yet */
 
 	writel((u32)paddr, port + PORT_CMD_ACTIVATE);
+	writel((u64)paddr >> 32, port + PORT_CMD_ACTIVATE + 4);
 
 	do {
 		irq_stat = readl(port + PORT_IRQ_STAT);
@@ -599,6 +600,8 @@ static unsigned int sil24_qc_issue(struc
 	dma_addr_t paddr = pp->cmd_block_dma + qc->tag * sizeof(*pp->cmd_block);
 
 	writel((u32)paddr, port + PORT_CMD_ACTIVATE);
+	writel((u64)paddr >> 32, port + PORT_CMD_ACTIVATE + 4);
+
 	return 0;
 }
 
@@ -935,22 +938,29 @@ static int sil24_init_one(struct pci_dev
 	/*
 	 * Configure the device
 	 */
-	/*
-	 * FIXME: This device is certainly 64-bit capable.  We just
-	 * don't know how to use it.  After fixing 32bit activation in
-	 * this function, enable 64bit masks here.
-	 */
-	rc = pci_set_dma_mask(pdev, DMA_32BIT_MASK);
-	if (rc) {
-		dev_printk(KERN_ERR, &pdev->dev,
-			   "32-bit DMA enable failed\n");
-		goto out_free;
-	}
-	rc = pci_set_consistent_dma_mask(pdev, DMA_32BIT_MASK);
-	if (rc) {
-		dev_printk(KERN_ERR, &pdev->dev,
-			   "32-bit consistent DMA enable failed\n");
-		goto out_free;
+	if (!pci_set_dma_mask(pdev, DMA_64BIT_MASK)) {
+		rc = pci_set_consistent_dma_mask(pdev, DMA_64BIT_MASK);
+		if (rc) {
+			rc = pci_set_consistent_dma_mask(pdev, DMA_32BIT_MASK);
+			if (rc) {
+				dev_printk(KERN_ERR, &pdev->dev,
+					   "64-bit DMA enable failed\n");
+				goto out_free;
+			}
+		}
+	} else {
+		rc = pci_set_dma_mask(pdev, DMA_32BIT_MASK);
+		if (rc) {
+			dev_printk(KERN_ERR, &pdev->dev,
+				   "32-bit DMA enable failed\n");
+			goto out_free;
+		}
+		rc = pci_set_consistent_dma_mask(pdev, DMA_32BIT_MASK);
+		if (rc) {
+			dev_printk(KERN_ERR, &pdev->dev,
+				   "32-bit consistent DMA enable failed\n");
+			goto out_free;
+		}
 	}
 
 	/* GPIO off */
@@ -1007,9 +1017,8 @@ static int sil24_init_one(struct pci_dev
 		writel(0x0000, port + PORT_CRC_ERR_CNT);
 		writel(0x0000, port + PORT_HSHK_ERR_CNT);
 
-		/* FIXME: 32bit activation? */
-		writel(0, port + PORT_ACTIVATE_UPPER_ADDR);
-		writel(PORT_CS_32BIT_ACTV, port + PORT_CTRL_STAT);
+		/* Always use 64bit activation */
+		writel(PORT_CS_32BIT_ACTV, port + PORT_CTRL_CLR);
 
 		/* Configure interrupts */
 		writel(0xffff, port + PORT_IRQ_ENABLE_CLR);
-- 
1.2.4


