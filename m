From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH] drivers/ide: make ide-scan-pci.c driver explicitly non-modular
Date: Wed, 9 Dec 2015 16:45:51 -0500
Message-ID: <1449697551-16096-1-git-send-email-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>, "David S. Miller" <davem@davemloft.net>, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

The Kconfig for this support is currently:

config IDEPCI_PCIBUS_ORDER
        bool "Probe IDE PCI devices in the PCI bus order (DEPRECATED)"

...meaning that it currently is not being built as a module by anyone.
Lets change the initcall to be the equivalent device_initcall, so that
when reading the driver code, there is no doubt it is builtin-only.

Unlike other similar changes, we leave the module.h header to be
included since this code interacts with other drivers and needs to
know what a struct module is.

Cc: "David S. Miller" <davem@davemloft.net>
Cc: linux-ide@vger.kernel.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>

diff --git a/drivers/ide/ide-scan-pci.c b/drivers/ide/ide-scan-pci.c
index c3da53e7bb2b..86aa88aeb3a6 100644
--- a/drivers/ide/ide-scan-pci.c
+++ b/drivers/ide/ide-scan-pci.c
@@ -107,5 +107,4 @@ static int __init ide_scan_pcibus(void)
 
 	return 0;
 }
-
-module_init(ide_scan_pcibus);
+device_initcall(ide_scan_pcibus);
-- 
2.2.1
