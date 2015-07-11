From: Vaishali Thakkar <vthakkar1994@gmail.com>
Subject: [PATCH] ide: Add helper macro for struct pci_driver bolierplate
Date: Sat, 11 Jul 2015 15:39:11 +0530
Message-ID: <20150711100910.GA16981@vaishali-Ideapad-Z570>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pd0-f178.google.com ([209.85.192.178]:32773 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753556AbbGKKJS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 11 Jul 2015 06:09:18 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "David S. Miller" <davem@davemloft.net>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

For simple IDE modules that contain a single pci_driver without any
additional setup code then ends up being a block of duplicated
boilerplate. This patch adds a new macro, module_ide_pci_driver(),
which replaces the module_init()/module_exit() registrations with
template functions.

Signed-off-by: Vaishali Thakkar <vthakkar1994@gmail.com>
---
 include/linux/ide.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/linux/ide.h b/include/linux/ide.h
index a633898..ac93cf5 100644
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -1189,6 +1189,17 @@ extern int __ide_pci_register_driver(struct pci_driver *driver, struct module *o
 #define ide_pci_register_driver(d) pci_register_driver(d)
 #endif
 
+/**
+ * module_ide_pci_driver() - Helper macro for registering a IDE drivers
+ * @__pci_driver: pci_driver struct
+ * Helper macro for IDE drivers which do not do anything special in module
+ * init/exit. This eliminates a lot of boilerplate. Each module may only
+ * use this macro once, and calling it replaces module_init() and module_exit()
+ */
+#define module_ide_pci_driver(__pci_driver) \
+	module_driver(__pci_driver, ide_pci_register_driver, \
+			pci_unregister_driver)
+
 static inline int ide_pci_is_in_compatibility_mode(struct pci_dev *dev)
 {
 	if ((dev->class >> 8) == PCI_CLASS_STORAGE_IDE && (dev->class & 5) != 5)
-- 
1.9.1

