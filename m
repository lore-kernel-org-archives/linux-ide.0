From: Viresh Kumar <viresh.kumar@st.com>
Subject: [PATCH] ata/pata_arasan_cf: Move arasan_cf_pm_ops out of #ifdef, #endif macros
Date: Thu, 1 Mar 2012 13:34:39 +0530
Message-ID: <427196876874fef7e956b10d035d06eed5895743.1330588911.git.viresh.kumar@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from eu1sys200aog118.obsmtp.com ([207.126.144.145]:40193 "EHLO
	eu1sys200aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757581Ab2CAIO5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 1 Mar 2012 03:14:57 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org, spear-devel@list.st.com, viresh.linux@gmail.com, Viresh Kumar <viresh.kumar@st.com>

#ifdef, #endif is not required in definition/usage of arasan_cf_pm_ops. So, move
this definition and its usage outside of them.

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 drivers/ata/pata_arasan_cf.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/pata_arasan_cf.c b/drivers/ata/pata_arasan_cf.c
index fc2db2a..3239517 100644
--- a/drivers/ata/pata_arasan_cf.c
+++ b/drivers/ata/pata_arasan_cf.c
@@ -943,9 +943,9 @@ static int arasan_cf_resume(struct device *dev)
 
 	return 0;
 }
+#endif
 
 static SIMPLE_DEV_PM_OPS(arasan_cf_pm_ops, arasan_cf_suspend, arasan_cf_resume);
-#endif
 
 static struct platform_driver arasan_cf_driver = {
 	.probe		= arasan_cf_probe,
@@ -953,9 +953,7 @@ static struct platform_driver arasan_cf_driver = {
 	.driver		= {
 		.name	= DRIVER_NAME,
 		.owner	= THIS_MODULE,
-#ifdef CONFIG_PM
 		.pm	= &arasan_cf_pm_ops,
-#endif
 	},
 };
 
-- 
1.7.8.110.g4cb5d

