From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH 3/3] ide: gayle: use module_platform_driver_probe()
Date: Tue, 05 Mar 2013 11:27:36 +0900
Message-ID: <005001ce1948$ffebdb70$ffc39250$%han@samsung.com>
References: <004e01ce1948$be5f4f20$3b1ded60$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:47605 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932372Ab3CEC1h (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 4 Mar 2013 21:27:37 -0500
Received: from epcpsbgr5.samsung.com
 (u145.gpu120.samsung.co.kr [203.254.230.145])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MJ6004TM1HXAD90@mailout1.samsung.com> for
 linux-ide@vger.kernel.org; Tue, 05 Mar 2013 11:27:36 +0900 (KST)
Received: from DOJG1HAN02 ([12.23.120.99])
 by mmp1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTPA id <0MJ600AH21I0L090@mmp1.samsung.com> for
 linux-ide@vger.kernel.org; Tue, 05 Mar 2013 11:27:36 +0900 (KST)
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
 drivers/ide/gayle.c |   15 +--------------
 1 files changed, 1 insertions(+), 14 deletions(-)

diff --git a/drivers/ide/gayle.c b/drivers/ide/gayle.c
index 51beb85..0a8440a 100644
--- a/drivers/ide/gayle.c
+++ b/drivers/ide/gayle.c
@@ -183,20 +183,7 @@ static struct platform_driver amiga_gayle_ide_driver = {
 	},
 };
 
-static int __init amiga_gayle_ide_init(void)
-{
-	return platform_driver_probe(&amiga_gayle_ide_driver,
-				     amiga_gayle_ide_probe);
-}
-
-module_init(amiga_gayle_ide_init);
-
-static void __exit amiga_gayle_ide_exit(void)
-{
-	platform_driver_unregister(&amiga_gayle_ide_driver);
-}
-
-module_exit(amiga_gayle_ide_exit);
+module_platform_driver_probe(amiga_gayle_ide_driver, amiga_gayle_ide_probe);
 
 MODULE_LICENSE("GPL");
 MODULE_ALIAS("platform:amiga-gayle-ide");
-- 
1.7.2.5


