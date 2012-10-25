From: Brian Norris <computersforpeace@gmail.com>
Subject: [RFC 2/3] ahci_platform: convert to module_platform_driver
Date: Thu, 25 Oct 2012 09:56:00 -0700
Message-ID: <1351184161-31433-3-git-send-email-computersforpeace@gmail.com>
References: <1351184161-31433-1-git-send-email-computersforpeace@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1351184161-31433-1-git-send-email-computersforpeace@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, linux-pm@lists.linux-foundation.org, Linux Kernel <linux-kernel@vger.kernel.org>, Brian Norris <computersforpeace@gmail.com>, Kevin Cernekee <cernekee@gmail.com>, Tejun Heo <tj@kernel.org>
List-Id: linux-ide@vger.kernel.org

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
