From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] libata: kill type mismatch compile warning
Date: Thu, 12 Apr 2007 13:38:11 +0900
Message-ID: <20070412043811.GG10619@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.236]:53297 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965419AbXDLEiU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 12 Apr 2007 00:38:20 -0400
Received: by nz-out-0506.google.com with SMTP id s1so318886nze
        for <linux-ide@vger.kernel.org>; Wed, 11 Apr 2007 21:38:19 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, albertcc@tw.ibm.com

kill the following compile warning.

drivers/ata/libata-core.c:1786: warning: comparison of distinct pointer types lacks a cast

Signed-off-by: Tejun Heo <htejun@gmail.com>

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 735f0b0..3556281 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -1783,7 +1783,8 @@ int ata_dev_configure(struct ata_device *dev)
 	}
 
 	if (ata_device_blacklisted(dev) & ATA_HORKAGE_MAX_SEC_128)
-		dev->max_sectors = min(ATA_MAX_SECTORS_128, dev->max_sectors);
+		dev->max_sectors = min_t(unsigned int, ATA_MAX_SECTORS_128,
+					 dev->max_sectors);
 
 	/* limit ATAPI DMA to R/W commands only */
 	if (ata_device_blacklisted(dev) & ATA_HORKAGE_DMA_RW_ONLY)
