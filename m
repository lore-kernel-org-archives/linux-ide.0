From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH] pata_at32: use module_platform_driver_probe()
Date: Tue, 05 Mar 2013 10:39:47 +0900
Message-ID: <004901ce1942$5238e780$f6aab680$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:55157 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932114Ab3CEBju (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 4 Mar 2013 20:39:50 -0500
Received: from epcpsbgr5.samsung.com
 (u145.gpu120.samsung.co.kr [203.254.230.145])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MJ500E24Z9HE2A0@mailout2.samsung.com> for
 linux-ide@vger.kernel.org; Tue, 05 Mar 2013 10:39:49 +0900 (KST)
Content-language: ko
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: 'Jeff Garzik' <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, 'Jingoo Han' <jg1.han@samsung.com>

This patch uses module_platform_driver_probe() macro which makes
the code smaller and simpler.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/ata/pata_at32.c |   13 +------------
 1 files changed, 1 insertions(+), 12 deletions(-)

diff --git a/drivers/ata/pata_at32.c b/drivers/ata/pata_at32.c
index 36f189c..8d493b4 100644
--- a/drivers/ata/pata_at32.c
+++ b/drivers/ata/pata_at32.c
@@ -393,18 +393,7 @@ static struct platform_driver pata_at32_driver = {
 	},
 };
 
-static int __init pata_at32_init(void)
-{
-	return platform_driver_probe(&pata_at32_driver, pata_at32_probe);
-}
-
-static void __exit pata_at32_exit(void)
-{
-	platform_driver_unregister(&pata_at32_driver);
-}
-
-module_init(pata_at32_init);
-module_exit(pata_at32_exit);
+module_platform_driver_probe(pata_at32_driver, pata_at32_probe);
 
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("AVR32 SMC/CFC PATA Driver");
-- 
1.7.2.5


