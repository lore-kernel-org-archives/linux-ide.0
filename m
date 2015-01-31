From: Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v2] ata: libahci: Use of_platform_device_create only if supported
Date: Sat, 31 Jan 2015 10:36:22 -0800
Message-ID: <1422729382-20150-1-git-send-email-linux@roeck-us.net>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:37513 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753274AbbAaSgc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 31 Jan 2015 13:36:32 -0500
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
	(envelope-from <linux@roeck-us.net>)
	id 1YHcuG-0016n6-Bv
	for linux-ide@vger.kernel.org; Sat, 31 Jan 2015 18:36:32 +0000
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
v2: Use #ifdef instead of IS_ENABLED

 drivers/ata/libahci_platform.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
index 077c7a2..d89305d 100644
--- a/drivers/ata/libahci_platform.c
+++ b/drivers/ata/libahci_platform.c
@@ -418,7 +418,7 @@ struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev)
 	if (child_nodes) {
 		for_each_child_of_node(dev->of_node, child) {
 			u32 port;
-			struct platform_device *port_dev;
+			struct platform_device *port_dev __maybe_unused;
 
 			if (!of_device_is_available(child))
 				continue;
@@ -434,6 +434,7 @@ struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev)
 			}
 			mask_port_map |= BIT(port);
 
+#ifdef CONFIG_OF_ADDRESS
 			of_platform_device_create(child, NULL, NULL);
 
 			port_dev = of_find_device_by_node(child);
@@ -444,6 +445,7 @@ struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev)
 				if (rc == -EPROBE_DEFER)
 					goto err_out;
 			}
+#endif
 
 			rc = ahci_platform_get_phy(hpriv, port, dev, child);
 			if (rc)
-- 
2.1.0

