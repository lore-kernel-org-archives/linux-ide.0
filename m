From: Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH] ata: libahci: Use of_platform_device_create only if supported
Date: Sat, 31 Jan 2015 08:32:18 -0800
Message-ID: <1422721938-1542-1-git-send-email-linux@roeck-us.net>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:53471 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752472AbbAaQca (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 31 Jan 2015 11:32:30 -0500
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
	(envelope-from <linux@roeck-us.net>)
	id 1YHayF-0000TM-5q
	for linux-ide@vger.kernel.org; Sat, 31 Jan 2015 16:32:31 +0000
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, Gregory CLEMENT <gregory.clement@free-electrons.com>

of_platform_device_create does not exist if OF_ADDRESS is not configured,
so limit its use accordingly.

Without this fix, the sparc64:allmodconfig build fails with

ERROR: "of_platform_device_create" [drivers/ata/libahci_platform.ko] undefined!

Fixes: c7d7ddee7e24 ("ata: libahci: Allow using multiple regulators")
Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
Applies to -next.

 drivers/ata/libahci_platform.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
index 077c7a2..de9a5dc 100644
--- a/drivers/ata/libahci_platform.c
+++ b/drivers/ata/libahci_platform.c
@@ -434,7 +434,8 @@ struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev)
 			}
 			mask_port_map |= BIT(port);
 
-			of_platform_device_create(child, NULL, NULL);
+			if (IS_ENABLED(CONFIG_OF_ADDRESS))
+				of_platform_device_create(child, NULL, NULL);
 
 			port_dev = of_find_device_by_node(child);
 
-- 
2.1.0

