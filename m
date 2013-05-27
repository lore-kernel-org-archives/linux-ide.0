From: Libo Chen <libo.chen@huawei.com>
Subject: [PATCH 07/24] drivers/ide/delkin_cb: Convert to module_pci_driver
Date: Mon, 27 May 2013 10:28:46 +0800
Message-ID: <1369621726-13828-1-git-send-email-libo.chen@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: davem@davemloft.net
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, lizefan@huawei.com, libo.chen@huawei.com, gregkh@linuxfoundation.org
List-Id: linux-ide@vger.kernel.org

use module_pci_driver instead of init/exit, make code clean.

Signed-off-by: Libo Chen <libo.chen@huawei.com>
---
 drivers/ide/delkin_cb.c |   13 +------------
 1 files changed, 1 insertions(+), 12 deletions(-)

diff --git a/drivers/ide/delkin_cb.c b/drivers/ide/delkin_cb.c
index 7e27d32..300daab 100644
--- a/drivers/ide/delkin_cb.c
+++ b/drivers/ide/delkin_cb.c
@@ -173,18 +173,7 @@ static struct pci_driver delkin_cb_pci_driver = {
 	.resume		= delkin_cb_resume,
 };
 
-static int __init delkin_cb_init(void)
-{
-	return pci_register_driver(&delkin_cb_pci_driver);
-}
-
-static void __exit delkin_cb_exit(void)
-{
-	pci_unregister_driver(&delkin_cb_pci_driver);
-}
-
-module_init(delkin_cb_init);
-module_exit(delkin_cb_exit);
+module_pci_driver(delkin_cb_pci_driver);
 
 MODULE_AUTHOR("Mark Lord");
 MODULE_DESCRIPTION("Basic support for Delkin/ASKA/Workbit Cardbus IDE");
-- 
1.7.1
