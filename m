From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: [PATCH] cs5536: use module_pci_driver to simplify the code
Date: Wed, 10 Oct 2012 21:08:00 +0800
Message-ID: <CAPgLHd-Cx5k566XJ2C-VrmLUJ4AVPV=w52ZVfLATONv_sqbMaA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qa0-f46.google.com ([209.85.216.46]:43518 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755832Ab2JJNIC (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 10 Oct 2012 09:08:02 -0400
Received: by mail-qa0-f46.google.com with SMTP id c26so4450228qad.19
        for <linux-ide@vger.kernel.org>; Wed, 10 Oct 2012 06:08:00 -0700 (PDT)
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
 drivers/ide/cs5536.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/ide/cs5536.c b/drivers/ide/cs5536.c
index 24214ab..de9185d 100644
--- a/drivers/ide/cs5536.c
+++ b/drivers/ide/cs5536.c
@@ -295,15 +295,7 @@ static struct pci_driver cs5536_pci_driver = {
 	.resume		= ide_pci_resume,
 };
 
-static int __init cs5536_init(void)
-{
-	return pci_register_driver(&cs5536_pci_driver);
-}
-
-static void __exit cs5536_exit(void)
-{
-	pci_unregister_driver(&cs5536_pci_driver);
-}
+module_pci_driver(cs5536_pci_driver);
 
 MODULE_AUTHOR("Martin K. Petersen, Bartlomiej Zolnierkiewicz");
 MODULE_DESCRIPTION("low-level driver for the CS5536 IDE controller");
@@ -312,6 +304,3 @@ MODULE_DEVICE_TABLE(pci, cs5536_pci_tbl);
 
 module_param_named(msr, use_msr, int, 0644);
 MODULE_PARM_DESC(msr, "Force using MSR to configure IDE function (Default: 0)");
-
-module_init(cs5536_init);
-module_exit(cs5536_exit);


