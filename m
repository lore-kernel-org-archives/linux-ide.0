From: Brian Norris <computersforpeace@gmail.com>
Subject: [PATCH 10/14] ata_platform: remove unused remove function
Date: Fri,  2 Nov 2012 00:46:24 -0700
Message-ID: <1351842388-27210-11-git-send-email-computersforpeace@gmail.com>
References: <1351842388-27210-1-git-send-email-computersforpeace@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-da0-f46.google.com ([209.85.210.46]:43309 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754634Ab2KBHrC (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 2 Nov 2012 03:47:02 -0400
Received: by mail-da0-f46.google.com with SMTP id n41so1546133dak.19
        for <linux-ide@vger.kernel.org>; Fri, 02 Nov 2012 00:47:02 -0700 (PDT)
In-Reply-To: <1351842388-27210-1-git-send-email-computersforpeace@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, Brian Norris <computersforpeace@gmail.com>, Tejun Heo <tj@kernel.org>

All users of __pata_platform_remove() have been converted to utilize the
common ata_platform_remove_one().

Signed-off-by: Brian Norris <computersforpeace@gmail.com>
---
 drivers/ata/pata_platform.c  | 17 -----------------
 include/linux/ata_platform.h |  2 --
 2 files changed, 19 deletions(-)

diff --git a/drivers/ata/pata_platform.c b/drivers/ata/pata_platform.c
index 449aa29..f4372d0 100644
--- a/drivers/ata/pata_platform.c
+++ b/drivers/ata/pata_platform.c
@@ -178,23 +178,6 @@ int __devinit __pata_platform_probe(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(__pata_platform_probe);
 
-/**
- *	__pata_platform_remove		-	unplug a platform interface
- *	@dev: device
- *
- *	A platform bus ATA device has been unplugged. Perform the needed
- *	cleanup. Also called on module unload for any active devices.
- */
-int __pata_platform_remove(struct device *dev)
-{
-	struct ata_host *host = dev_get_drvdata(dev);
-
-	ata_host_detach(host);
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(__pata_platform_remove);
-
 static int __devinit pata_platform_probe(struct platform_device *pdev)
 {
 	struct resource *io_res;
diff --git a/include/linux/ata_platform.h b/include/linux/ata_platform.h
index b856a2a..fe99896 100644
--- a/include/linux/ata_platform.h
+++ b/include/linux/ata_platform.h
@@ -22,8 +22,6 @@ extern int __devinit __pata_platform_probe(struct device *dev,
 					   unsigned int ioport_shift,
 					   int __pio_mask);
 
-extern int __devexit __pata_platform_remove(struct device *dev);
-
 /*
  * Marvell SATA private data
  */
-- 
1.7.11.3

