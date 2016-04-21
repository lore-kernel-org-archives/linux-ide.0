From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 03/23] ata: sata_dwc_460ex: set dma_boundary to 0x1fff
Date: Thu, 21 Apr 2016 21:15:24 +0300
Message-ID: <1461262544-115408-4-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1461262544-115408-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1461262544-115408-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Christian Lamparter <chunkeey@googlemail.com>, =?UTF-8?q?M=C3=A5ns=20Rullg=C3=A5rd?= <mans@mansr.com>, Julian Margetson <runaway@candw.ms>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-ide@vger.kernel.org

The original code states:

	Make sure a LLI block is not created that will span 8K max FIS
	boundary. If the block spans such a FIS boundary, there is a chance
	that a DMA burst will cross that boundary -- this results in an error
	in the host controller.

Since we have switched to generic DMAengine API we satisfy above by setting
dma_boundary value to 0x1fff.

Suggested-by: Mans Rullgard <mans@mansr.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/ata/sata_dwc_460ex.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.c
index 7f95389..aee8873 100644
--- a/drivers/ata/sata_dwc_460ex.c
+++ b/drivers/ata/sata_dwc_460ex.c
@@ -1151,7 +1151,13 @@ static struct scsi_host_template sata_dwc_sht = {
 	 */
 	.sg_tablesize		= LIBATA_MAX_PRD,
 	/* .can_queue		= ATA_MAX_QUEUE, */
-	.dma_boundary		= ATA_DMA_BOUNDARY,
+	/*
+	 * Make sure a LLI block is not created that will span 8K max FIS
+	 * boundary. If the block spans such a FIS boundary, there is a chance
+	 * that a DMA burst will cross that boundary -- this results in an
+	 * error in the host controller.
+	 */
+	.dma_boundary		= 0x1fff /* ATA_DMA_BOUNDARY */,
 };
 
 static struct ata_port_operations sata_dwc_ops = {
-- 
2.8.0.rc3
