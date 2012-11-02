From: Brian Norris <computersforpeace@gmail.com>
Subject: [PATCH v3 04/14] libata: implement ata_platform_remove_one()
Date: Fri,  2 Nov 2012 12:29:32 -0700
Message-ID: <1351884572-1273-1-git-send-email-computersforpeace@gmail.com>
References: <1351883393-32354-1-git-send-email-computersforpeace@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:35284 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751096Ab2KBT3o (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 2 Nov 2012 15:29:44 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so2652180pbb.19
        for <linux-ide@vger.kernel.org>; Fri, 02 Nov 2012 12:29:44 -0700 (PDT)
In-Reply-To: <1351883393-32354-1-git-send-email-computersforpeace@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, Brian Norris <computersforpeace@gmail.com>, Sergei Shtylyov <sshtylyov@mvista.com>

This relatively simple boiler-plate code is repeated in several platform
drivers. We should implement a common version in libata.

Signed-off-by: Brian Norris <computersforpeace@gmail.com>
---
v2: fix whitespace
v3: really fix whitespace. Thanks Sergei.

 drivers/ata/libata-core.c | 23 +++++++++++++++++++++++
 include/linux/libata.h    |  4 ++++
 2 files changed, 27 insertions(+)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 611050d..f13fe28 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -67,6 +67,7 @@
 #include <linux/cdrom.h>
 #include <linux/ratelimit.h>
 #include <linux/pm_runtime.h>
+#include <linux/platform_device.h>
 
 #include "libata.h"
 #include "libata-transport.h"
@@ -6350,6 +6351,26 @@ int ata_pci_device_resume(struct pci_dev *pdev)
 
 #endif /* CONFIG_PCI */
 
+/**
+ *	ata_platform_remove_one - Platform layer callback for device removal
+ *	@pdev: Platform device that was removed
+ *
+ *	Platform layer indicates to libata via this hook that hot-unplug or
+ *	module unload event has occurred.  Detach all ports.  Resource
+ *	release is handled via devres.
+ *
+ *	LOCKING:
+ *	Inherited from platform layer (may sleep).
+ */
+int ata_platform_remove_one(struct platform_device *pdev)
+{
+	struct ata_host *host = platform_get_drvdata(pdev);
+
+	ata_host_detach(host);
+
+	return 0;
+}
+
 static int __init ata_parse_force_one(char **cur,
 				      struct ata_force_ent *force_ent,
 				      const char **reason)
@@ -6844,6 +6865,8 @@ EXPORT_SYMBOL_GPL(ata_pci_device_resume);
 #endif /* CONFIG_PM */
 #endif /* CONFIG_PCI */
 
+EXPORT_SYMBOL_GPL(ata_platform_remove_one);
+
 EXPORT_SYMBOL_GPL(__ata_ehi_push_desc);
 EXPORT_SYMBOL_GPL(ata_ehi_push_desc);
 EXPORT_SYMBOL_GPL(ata_ehi_clear_desc);
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 464e67c..cedcd0f 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -1103,6 +1103,10 @@ extern int ata_pci_device_resume(struct pci_dev *pdev);
 #endif /* CONFIG_PM */
 #endif /* CONFIG_PCI */
 
+struct platform_device;
+
+extern int ata_platform_remove_one(struct platform_device *pdev);
+
 /*
  * ACPI - drivers/ata/libata-acpi.c
  */
-- 
1.7.11.3

