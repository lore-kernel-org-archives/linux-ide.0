From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] sata_dwc_460ex: indent an if statement
Date: Mon, 30 Mar 2015 13:30:25 +0300
Message-ID: <20150330103025.GA27144@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:40560 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751459AbbC3Kan (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 30 Mar 2015 06:30:43 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-ide@vger.kernel.org, kernel-janitors@vger.kernel.org

We shuffled some code around in 8b3444852a2b ('sata_dwc_460ex: move to
generic DMA driver') an accidentally deleted a tab character here.  It
causes a Smatch warning "if statement not indented".

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.c
index 5ab4849..9020349 100644
--- a/drivers/ata/sata_dwc_460ex.c
+++ b/drivers/ata/sata_dwc_460ex.c
@@ -295,7 +295,7 @@ static void dma_dwc_xfer_done(void *hsdev_instance)
 	}
 
 	if ((hsdevp->dma_interrupt_count % 2) == 0)
-	sata_dwc_dma_xfer_complete(ap, 1);
+		sata_dwc_dma_xfer_complete(ap, 1);
 
 	spin_unlock_irqrestore(&host->lock, flags);
 }
