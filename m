From: Srinivas KANDAGATLA <srinivas.kandagatla@st.com>
Subject: [PATCH 3.6.0- 1/2] ide/au1xxx: use module_platform_driver macro
Date: Wed, 10 Oct 2012 19:33:13 +0100
Message-ID: <1349893993-7918-1-git-send-email-srinivas.kandagatla@st.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from eu1sys200aog103.obsmtp.com ([207.126.144.115]:51688 "EHLO
	eu1sys200aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755828Ab2JJSfB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 10 Oct 2012 14:35:01 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: davem@davemloft.net
Cc: srinivas.kandagatla@st.com, bzolnier@gmail.com, jgarzik@pobox.com, linux-ide@vger.kernel.org, galak@kernel.crashing.org

From: Srinivas Kandagatla <srinivas.kandagatla@st.com>

This patch removes some code duplication by using
module_platform_driver.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@st.com>
---
 drivers/ide/au1xxx-ide.c |   14 +-------------
 1 files changed, 1 insertions(+), 13 deletions(-)

diff --git a/drivers/ide/au1xxx-ide.c b/drivers/ide/au1xxx-ide.c
index 259786c..3d30f55 100644
--- a/drivers/ide/au1xxx-ide.c
+++ b/drivers/ide/au1xxx-ide.c
@@ -592,18 +592,6 @@ static struct platform_driver au1200_ide_driver = {
 	.remove		= au_ide_remove,
 };
 
-static int __init au_ide_init(void)
-{
-	return platform_driver_register(&au1200_ide_driver);
-}
-
-static void __exit au_ide_exit(void)
-{
-	platform_driver_unregister(&au1200_ide_driver);
-}
-
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("AU1200 IDE driver");
-
-module_init(au_ide_init);
-module_exit(au_ide_exit);
+module_platform_driver(au1200_ide_driver);
-- 
1.7.0.4

