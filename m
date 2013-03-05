From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH 1/3] ide: tx4938ide: use module_platform_driver_probe()
Date: Tue, 05 Mar 2013 11:25:46 +0900
Message-ID: <004e01ce1948$be5f4f20$3b1ded60$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:44095 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758723Ab3CECZr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 4 Mar 2013 21:25:47 -0500
Received: from epcpsbgr5.samsung.com
 (u145.gpu120.samsung.co.kr [203.254.230.145])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MJ60074D1EM2YD0@mailout4.samsung.com> for
 linux-ide@vger.kernel.org; Tue, 05 Mar 2013 11:25:46 +0900 (KST)
Content-language: ko
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "'David S. Miller'" <davem@davemloft.net>
Cc: linux-ide@vger.kernel.org, 'Jingoo Han' <jg1.han@samsung.com>

This patch uses module_platform_driver_probe() macro which makes
the code smaller and simpler.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/ide/tx4938ide.c |   13 +------------
 1 files changed, 1 insertions(+), 12 deletions(-)

diff --git a/drivers/ide/tx4938ide.c b/drivers/ide/tx4938ide.c
index 91d49dd..ede8575 100644
--- a/drivers/ide/tx4938ide.c
+++ b/drivers/ide/tx4938ide.c
@@ -203,18 +203,7 @@ static struct platform_driver tx4938ide_driver = {
 	.remove = __exit_p(tx4938ide_remove),
 };
 
-static int __init tx4938ide_init(void)
-{
-	return platform_driver_probe(&tx4938ide_driver, tx4938ide_probe);
-}
-
-static void __exit tx4938ide_exit(void)
-{
-	platform_driver_unregister(&tx4938ide_driver);
-}
-
-module_init(tx4938ide_init);
-module_exit(tx4938ide_exit);
+module_platform_driver_probe(tx4938ide_driver, tx4938ide_probe);
 
 MODULE_DESCRIPTION("TX4938 internal IDE driver");
 MODULE_LICENSE("GPL");
-- 
1.7.2.5


