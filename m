From: Brian Norris <computersforpeace@gmail.com>
Subject: [RFC v2 2/3] ahci_platform: convert to module_platform_driver
Date: Sat, 27 Oct 2012 13:09:35 -0700
Message-ID: <1351368576-5264-3-git-send-email-computersforpeace@gmail.com>
References: <1351368576-5264-1-git-send-email-computersforpeace@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:44950 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752145Ab2J0UKR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 27 Oct 2012 16:10:17 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so3454458pbb.19
        for <linux-ide@vger.kernel.org>; Sat, 27 Oct 2012 13:10:16 -0700 (PDT)
In-Reply-To: <1351368576-5264-1-git-send-email-computersforpeace@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, linux-pm@lists.linux-foundation.org, Kevin Cernekee <cernekee@gmail.com>, Brian Norris <computersforpeace@gmail.com>

The ahci_platform driver can now use the module_platform_driver() macro.

Signed-off-by: Brian Norris <computersforpeace@gmail.com>
---
 drivers/ata/ahci_platform.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform.c
index f467ba8..d9fbd10 100644
--- a/drivers/ata/ahci_platform.c
+++ b/drivers/ata/ahci_platform.c
@@ -298,18 +298,7 @@ static struct platform_driver ahci_driver = {
 	},
 	.id_table	= ahci_devtype,
 };
-
-static int __init ahci_init(void)
-{
-	return platform_driver_register(&ahci_driver);
-}
-module_init(ahci_init);
-
-static void __exit ahci_exit(void)
-{
-	platform_driver_unregister(&ahci_driver);
-}
-module_exit(ahci_exit);
+module_platform_driver(ahci_driver);
 
 MODULE_DESCRIPTION("AHCI SATA platform driver");
 MODULE_AUTHOR("Anton Vorontsov <avorontsov@ru.mvista.com>");
-- 
1.7.11.3

