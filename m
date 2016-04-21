From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 05/23] ata: sata_dwc_460ex: DMA is always a flow controller
Date: Thu, 21 Apr 2016 21:15:26 +0300
Message-ID: <1461262544-115408-6-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1461262544-115408-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:21993 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754035AbcDUSPx (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 21 Apr 2016 14:15:53 -0400
In-Reply-To: <1461262544-115408-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Christian Lamparter <chunkeey@googlemail.com>, =?UTF-8?q?M=C3=A5ns=20Rullg=C3=A5rd?= <mans@mansr.com>, Julian Margetson <runaway@candw.ms>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

In the original code the DMA is always a flow controller. Set this accordingly
in updated code.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/ata/sata_dwc_460ex.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.c
index 4cac27d..1250e18 100644
--- a/drivers/ata/sata_dwc_460ex.c
+++ b/drivers/ata/sata_dwc_460ex.c
@@ -311,7 +311,7 @@ static struct dma_async_tx_descriptor *dma_dwc_xfer_setup(struct ata_queued_cmd
 
 	if (qc->dma_dir == DMA_DEV_TO_MEM) {
 		sconf.src_addr = addr;
-		sconf.device_fc = true;
+		sconf.device_fc = false;
 	} else {	/* DMA_MEM_TO_DEV */
 		sconf.dst_addr = addr;
 		sconf.device_fc = false;
-- 
2.8.0.rc3

