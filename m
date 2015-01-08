From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 2/3] sata_dwc_460ex: remove extra message
Date: Thu,  8 Jan 2015 12:50:13 +0200
Message-ID: <1420714214-16950-2-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1420714214-16950-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:14585 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756233AbbAHKuD (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 8 Jan 2015 05:50:03 -0500
In-Reply-To: <1420714214-16950-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Rupjyoti Sarmah <rsarmah@amcc.com>, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

There is no need to print a message about failure of memory allocation. The
caller will get an error code and may print the same.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/ata/sata_dwc_460ex.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.c
index b206017..169cbca 100644
--- a/drivers/ata/sata_dwc_460ex.c
+++ b/drivers/ata/sata_dwc_460ex.c
@@ -1677,11 +1677,8 @@ static int sata_dwc_probe(struct platform_device *ofdev)
 
 	/* Allocate DWC SATA device */
 	hsdev = kzalloc(sizeof(*hsdev), GFP_KERNEL);
-	if (hsdev == NULL) {
-		dev_err(&ofdev->dev, "kmalloc failed for hsdev\n");
-		err = -ENOMEM;
-		goto error;
-	}
+	if (hsdev == NULL)
+		return -ENOMEM;
 
 	if (of_property_read_u32(np, "dma-channel", &dma_chan)) {
 		dev_warn(&ofdev->dev, "no dma-channel property set."
@@ -1783,7 +1780,6 @@ error_iomap:
 	iounmap(base);
 error_kmalloc:
 	kfree(hsdev);
-error:
 	return err;
 }
 
-- 
2.1.3

