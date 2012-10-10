From: Srinivas KANDAGATLA <srinivas.kandagatla@st.com>
Subject: [PATCH 3.6.0- 2/2] ide_platform: use module_platform_driver macro
Date: Wed, 10 Oct 2012 19:33:18 +0100
Message-ID: <1349893998-7950-1-git-send-email-srinivas.kandagatla@st.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from eu1sys200aog115.obsmtp.com ([207.126.144.139]:37824 "EHLO
	eu1sys200aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751970Ab2JJSer (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 10 Oct 2012 14:34:47 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: davem@davemloft.net
Cc: srinivas.kandagatla@st.com, bzolnier@gmail.com, jgarzik@pobox.com, linux-ide@vger.kernel.org, galak@kernel.crashing.org

From: Srinivas Kandagatla <srinivas.kandagatla@st.com>

This patch removes some code duplication by using
module_platform_driver.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@st.com>
---
 drivers/ide/ide_platform.c |   14 +-------------
 1 files changed, 1 insertions(+), 13 deletions(-)

diff --git a/drivers/ide/ide_platform.c b/drivers/ide/ide_platform.c
index 962693b..175a975 100644
--- a/drivers/ide/ide_platform.c
+++ b/drivers/ide/ide_platform.c
@@ -133,19 +133,7 @@ static struct platform_driver platform_ide_driver = {
 	.remove = __devexit_p(plat_ide_remove),
 };
 
-static int __init platform_ide_init(void)
-{
-	return platform_driver_register(&platform_ide_driver);
-}
-
-static void __exit platform_ide_exit(void)
-{
-	platform_driver_unregister(&platform_ide_driver);
-}
-
 MODULE_DESCRIPTION("Platform IDE driver");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS("platform:pata_platform");
-
-module_init(platform_ide_init);
-module_exit(platform_ide_exit);
+module_platform_driver(platform_ide_driver);
-- 
1.7.0.4

