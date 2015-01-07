From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 2/4] sata_dwc_460ex: remove redundant dev_set_drvdata
Date: Wed,  7 Jan 2015 15:24:20 +0200
Message-ID: <1420637062-15450-2-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1420637062-15450-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:23411 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753058AbbAGNY3 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 7 Jan 2015 08:24:29 -0500
In-Reply-To: <1420637062-15450-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Miesfeld <mmiesfeld@amcc.com>, Jeff Garzik <jgarzik@redhat.com>, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Driver core sets it to NULL upon probe failure or release.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/ata/sata_dwc_460ex.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.c
index 8e824817..5c34395 100644
--- a/drivers/ata/sata_dwc_460ex.c
+++ b/drivers/ata/sata_dwc_460ex.c
@@ -1783,7 +1783,6 @@ static int sata_dwc_remove(struct platform_device *ofdev)
 	struct sata_dwc_device *hsdev = host->private_data;
 
 	ata_host_detach(host);
-	dev_set_drvdata(dev, NULL);
 
 	/* Free SATA DMA resources */
 	dma_dwc_exit(hsdev);
-- 
2.1.3

