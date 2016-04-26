From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 20/23] ata: sata_dwc_460ex: tidy up sata_dwc_clear_dmacr()
Date: Tue, 26 Apr 2016 12:03:21 +0300
Message-ID: <1461661404-1952-21-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1461661404-1952-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1461661404-1952-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Christian Lamparter <chunkeey@googlemail.com>, =?UTF-8?q?M=C3=A5ns=20Rullg=C3=A5rd?= <mans@mansr.com>, Julian Margetson <runaway@candw.ms>
List-Id: linux-ide@vger.kernel.org

From: Mans Rullgard <mans@mansr.com>

This consolidates the reads from each of the if/else branches
to one place making the code a lot nicer to look at.

Tested-by: Christian Lamparter <chunkeey@googlemail.com>
Signed-off-by: Mans Rullgard <mans@mansr.com>
---
 drivers/ata/sata_dwc_460ex.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.c
index 2e3222f..92f4008 100644
--- a/drivers/ata/sata_dwc_460ex.c
+++ b/drivers/ata/sata_dwc_460ex.c
@@ -729,15 +729,14 @@ DONE:
 static void sata_dwc_clear_dmacr(struct sata_dwc_device_port *hsdevp, u8 tag)
 {
 	struct sata_dwc_device *hsdev = HSDEV_FROM_HSDEVP(hsdevp);
+	u32 dmacr = sata_dwc_readl(&hsdev->sata_dwc_regs->dmacr);
 
 	if (hsdevp->dma_pending[tag] == SATA_DWC_DMA_PENDING_RX) {
-		sata_dwc_writel(&hsdev->sata_dwc_regs->dmacr,
-			SATA_DWC_DMACR_RX_CLEAR(
-				sata_dwc_readl(&hsdev->sata_dwc_regs->dmacr)));
+		dmacr = SATA_DWC_DMACR_RX_CLEAR(dmacr);
+		sata_dwc_writel(&hsdev->sata_dwc_regs->dmacr, dmacr);
 	} else if (hsdevp->dma_pending[tag] == SATA_DWC_DMA_PENDING_TX) {
-		sata_dwc_writel(&hsdev->sata_dwc_regs->dmacr,
-			SATA_DWC_DMACR_TX_CLEAR(
-				sata_dwc_readl(&hsdev->sata_dwc_regs->dmacr)));
+		dmacr = SATA_DWC_DMACR_TX_CLEAR(dmacr);
+		sata_dwc_writel(&hsdev->sata_dwc_regs->dmacr, dmacr);
 	} else {
 		/*
 		 * This should not happen, it indicates the driver is out of
@@ -745,8 +744,7 @@ static void sata_dwc_clear_dmacr(struct sata_dwc_device_port *hsdevp, u8 tag)
 		 */
 		dev_err(hsdev->dev,
 			"%s DMA protocol RX and TX DMA not pending tag=0x%02x pending=%d dmacr: 0x%08x\n",
-			__func__, tag, hsdevp->dma_pending[tag],
-			sata_dwc_readl(&hsdev->sata_dwc_regs->dmacr));
+			__func__, tag, hsdevp->dma_pending[tag], dmacr);
 		sata_dwc_writel(&hsdev->sata_dwc_regs->dmacr,
 				SATA_DWC_DMACR_TXRXCH_CLEAR);
 	}
-- 
2.8.0.rc3
