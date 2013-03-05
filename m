From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH 2/3] ide: tx4939ide: use module_platform_driver_probe()
Date: Tue, 05 Mar 2013 11:26:53 +0900
Message-ID: <004f01ce1948$e697f0a0$b3c7d1e0$%han@samsung.com>
References: <004e01ce1948$be5f4f20$3b1ded60$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:32690 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758723Ab3CEC0z (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 4 Mar 2013 21:26:55 -0500
Received: from epcpsbgr4.samsung.com
 (u144.gpu120.samsung.co.kr [203.254.230.144])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MJ600J0R1GS4UD0@mailout3.samsung.com> for
 linux-ide@vger.kernel.org; Tue, 05 Mar 2013 11:26:54 +0900 (KST)
Received: from DOJG1HAN02 ([12.23.120.99])
 by mmp1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTPA id <0MJ600BOQ1GT5A50@mmp1.samsung.com> for
 linux-ide@vger.kernel.org; Tue, 05 Mar 2013 11:26:53 +0900 (KST)
In-reply-to: <004e01ce1948$be5f4f20$3b1ded60$%han@samsung.com>
Content-language: ko
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "'David S. Miller'" <davem@davemloft.net>
Cc: linux-ide@vger.kernel.org, 'Jingoo Han' <jg1.han@samsung.com>

This patch uses module_platform_driver_probe() macro which makes
the code smaller and simpler.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/ide/tx4939ide.c |   13 +------------
 1 files changed, 1 insertions(+), 12 deletions(-)

diff --git a/drivers/ide/tx4939ide.c b/drivers/ide/tx4939ide.c
index c0ab800..4ecdee5 100644
--- a/drivers/ide/tx4939ide.c
+++ b/drivers/ide/tx4939ide.c
@@ -624,18 +624,7 @@ static struct platform_driver tx4939ide_driver = {
 	.resume = tx4939ide_resume,
 };
 
-static int __init tx4939ide_init(void)
-{
-	return platform_driver_probe(&tx4939ide_driver, tx4939ide_probe);
-}
-
-static void __exit tx4939ide_exit(void)
-{
-	platform_driver_unregister(&tx4939ide_driver);
-}
-
-module_init(tx4939ide_init);
-module_exit(tx4939ide_exit);
+module_platform_driver_probe(tx4939ide_driver, tx4939ide_probe);
 
 MODULE_DESCRIPTION("TX4939 internal IDE driver");
 MODULE_LICENSE("GPL");
-- 
1.7.2.5


