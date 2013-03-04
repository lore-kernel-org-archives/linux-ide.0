From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH] pata_samsung_cf: use module_platform_driver_probe()
Date: Mon, 04 Mar 2013 17:34:42 +0900
Message-ID: <015401ce18b3$1eb9aaa0$5c2cffe0$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:57437 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755350Ab3CDIeo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 4 Mar 2013 03:34:44 -0500
Received: from epcpsbgr2.samsung.com
 (u142.gpu120.samsung.co.kr [203.254.230.142])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MJ4009ZRNT11MG0@mailout4.samsung.com> for
 linux-ide@vger.kernel.org; Mon, 04 Mar 2013 17:34:43 +0900 (KST)
Content-language: ko
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: 'Jeff Garzik' <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, 'Jingoo Han' <jg1.han@samsung.com>

This patch uses module_platform_driver_probe() macro which makes
the code smaller and simpler.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/ata/pata_samsung_cf.c |   13 +------------
 1 files changed, 1 insertions(+), 12 deletions(-)

diff --git a/drivers/ata/pata_samsung_cf.c b/drivers/ata/pata_samsung_cf.c
index 70b0e01..6ef27e9 100644
--- a/drivers/ata/pata_samsung_cf.c
+++ b/drivers/ata/pata_samsung_cf.c
@@ -661,18 +661,7 @@ static struct platform_driver pata_s3c_driver = {
 	},
 };
 
-static int __init pata_s3c_init(void)
-{
-	return platform_driver_probe(&pata_s3c_driver, pata_s3c_probe);
-}
-
-static void __exit pata_s3c_exit(void)
-{
-	platform_driver_unregister(&pata_s3c_driver);
-}
-
-module_init(pata_s3c_init);
-module_exit(pata_s3c_exit);
+module_platform_driver_probe(pata_s3c_driver, pata_s3c_probe);
 
 MODULE_AUTHOR("Abhilash Kesavan, <a.kesavan@samsung.com>");
 MODULE_DESCRIPTION("low-level driver for Samsung PATA controller");
-- 
1.7.2.5


