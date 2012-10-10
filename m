From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: [PATCH] ide: use module_pci_driver to simplify the code
Date: Wed, 10 Oct 2012 21:08:45 +0800
Message-ID: <CAPgLHd8Cd_R5VvdtTfrFYJcfXTQ2sUrCSr-wvF44R38kAsPtbA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qa0-f46.google.com ([209.85.216.46]:50553 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755832Ab2JJNIq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 10 Oct 2012 09:08:46 -0400
Received: by mail-qa0-f46.google.com with SMTP id c26so4450969qad.19
        for <linux-ide@vger.kernel.org>; Wed, 10 Oct 2012 06:08:45 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: davem@davemloft.net
Cc: yongjun_wei@trendmicro.com.cn, linux-ide@vger.kernel.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Use the module_pci_driver() macro to make the code simpler
by eliminating module_init and module_exit calls.

dpatch engine is used to auto generate this patch.
(https://github.com/weiyj/dpatch)

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 drivers/ide/delkin_cb.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/ide/delkin_cb.c b/drivers/ide/delkin_cb.c
index 1e10eba..e6550dc 100644
--- a/drivers/ide/delkin_cb.c
+++ b/drivers/ide/delkin_cb.c
@@ -174,18 +174,7 @@ static struct pci_driver delkin_cb_pci_driver = {
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

