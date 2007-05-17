From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] sata_via: pcim_iomap_regions() conversion missed BAR5
Date: Thu, 17 May 2007 13:37:12 +0200
Message-ID: <464C3E68.30608@gmail.com>
References: <464C29DC.80901@deadlyninja.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.229]:64590 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755512AbXEQLhd (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 17 May 2007 07:37:33 -0400
Received: by nz-out-0506.google.com with SMTP id r28so915865nza
        for <linux-ide@vger.kernel.org>; Thu, 17 May 2007 04:37:33 -0700 (PDT)
In-Reply-To: <464C29DC.80901@deadlyninja.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tim Valenzuela <tim@deadlyninja.com>, Jeff Garzik <jeff@garzik.org>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

pcim_iomap_regions() conversion missed BAR5.  Fix it.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
Sorry, dunno how I missed that during testing. :-( Please verify this
fixes your problem.

diff --git a/drivers/ata/sata_via.c b/drivers/ata/sata_via.c
index d105d2c..ac4f43c 100644
--- a/drivers/ata/sata_via.c
+++ b/drivers/ata/sata_via.c
@@ -441,7 +441,7 @@ static int vt6421_prepare_host(struct pc
 		return -ENOMEM;
 	}
 
-	rc = pcim_iomap_regions(pdev, 0x1f, DRV_NAME);
+	rc = pcim_iomap_regions(pdev, 0x3f, DRV_NAME);
 	if (rc) {
 		dev_printk(KERN_ERR, &pdev->dev, "failed to request/iomap "
 			   "PCI BARs (errno=%d)\n", rc);
