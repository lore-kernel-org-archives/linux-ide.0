From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH] ide: cs5536: use module_pci_driver()
Date: Mon, 16 Sep 2013 13:58:47 +0900
Message-ID: <000301ceb299$6d606f60$48214e20$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:61232 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752323Ab3IPE6t (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 16 Sep 2013 00:58:49 -0400
Received: from epcpsbgr2.samsung.com
 (u142.gpu120.samsung.co.kr [203.254.230.142])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MT700M0PCHX87A0@mailout2.samsung.com> for
 linux-ide@vger.kernel.org; Mon, 16 Sep 2013 13:58:47 +0900 (KST)
Content-language: ko
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: 'David Miller' <davem@davemloft.net>
Cc: linux-ide@vger.kernel.org, 'Bartlomiej Zolnierkiewicz' <b.zolnierkie@samsung.com>, 'Jingoo Han' <jg1.han@samsung.com>

Use module_pci_driver() macro which makes the code smaller and
simpler.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/ide/cs5536.c |   13 +------------
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
-- 
1.7.10.4


