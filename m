From: Brian Norris <computersforpeace@gmail.com>
Subject: [PATCH 11/14] pata_palmld: utilize common ata_platform_remove_one()
Date: Fri,  2 Nov 2012 00:46:25 -0700
Message-ID: <1351842388-27210-12-git-send-email-computersforpeace@gmail.com>
References: <1351842388-27210-1-git-send-email-computersforpeace@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:38164 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755298Ab2KBHrD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 2 Nov 2012 03:47:03 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so2298063pbb.19
        for <linux-ide@vger.kernel.org>; Fri, 02 Nov 2012 00:47:03 -0700 (PDT)
In-Reply-To: <1351842388-27210-1-git-send-email-computersforpeace@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, Brian Norris <computersforpeace@gmail.com>, Tejun Heo <tj@kernel.org>

Signed-off-by: Brian Norris <computersforpeace@gmail.com>
---
 drivers/ata/pata_palmld.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/ata/pata_palmld.c b/drivers/ata/pata_palmld.c
index 5ff31b6..f9f79fc 100644
--- a/drivers/ata/pata_palmld.c
+++ b/drivers/ata/pata_palmld.c
@@ -111,9 +111,7 @@ err1:
 
 static __devexit int palmld_pata_remove(struct platform_device *dev)
 {
-	struct ata_host *host = platform_get_drvdata(dev);
-
-	ata_host_detach(host);
+	ata_platform_remove_one(dev);
 
 	/* power down the HDD */
 	gpio_set_value(GPIO_NR_PALMLD_IDE_PWEN, 0);
-- 
1.7.11.3

