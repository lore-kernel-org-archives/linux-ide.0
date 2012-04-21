From: Viresh Kumar <viresh.linux@gmail.com>
Subject: [PATCH V2 1/5] ata/pata_arasan_cf: Move arasan_cf_pm_ops out of #ifdef, #endif macros
Date: Sat, 21 Apr 2012 17:40:09 +0530
Message-ID: <c77d2918c9418abca344c2a6bafc0e3ceeab9016.1335009631.git.viresh.kumar@st.com>
References: <cover.1335009631.git.viresh.kumar@st.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pz0-f52.google.com ([209.85.210.52]:52398 "EHLO
	mail-pz0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751725Ab2DUMLC (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 21 Apr 2012 08:11:02 -0400
Received: by mail-pz0-f52.google.com with SMTP id e40so14092262dak.11
        for <linux-ide@vger.kernel.org>; Sat, 21 Apr 2012 05:11:02 -0700 (PDT)
In-Reply-To: <cover.1335009631.git.viresh.kumar@st.com>
In-Reply-To: <cover.1335009631.git.viresh.kumar@st.com>
References: <cover.1335009631.git.viresh.kumar@st.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@redhat.com
Cc: spear-devel@list.st.com, viresh.linux@gmail.com, linux-ide@vger.kernel.org, sshtylyov@mvista.com, Viresh Kumar <viresh.kumar@st.com>

#ifdef, #endif is not required in definition/usage of arasan_cf_pm_ops. So, move
this definition and its usage outside of them.

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 drivers/ata/pata_arasan_cf.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/pata_arasan_cf.c b/drivers/ata/pata_arasan_cf.c
index b370e35..5ebf1cc 100644
--- a/drivers/ata/pata_arasan_cf.c
+++ b/drivers/ata/pata_arasan_cf.c
@@ -936,9 +936,9 @@ static int arasan_cf_resume(struct device *dev)
 
 	return 0;
 }
+#endif
 
 static SIMPLE_DEV_PM_OPS(arasan_cf_pm_ops, arasan_cf_suspend, arasan_cf_resume);
-#endif
 
 static struct platform_driver arasan_cf_driver = {
 	.probe		= arasan_cf_probe,
@@ -946,9 +946,7 @@ static struct platform_driver arasan_cf_driver = {
 	.driver		= {
 		.name	= DRIVER_NAME,
 		.owner	= THIS_MODULE,
-#ifdef CONFIG_PM
 		.pm	= &arasan_cf_pm_ops,
-#endif
 	},
 };
 
-- 
1.7.9

