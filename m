From: Viresh Kumar <viresh.linux@gmail.com>
Subject: [PATCH 1/5] ata/pata_arasan_cf: Move arasan_cf_pm_ops out of #ifdef, #endif macros
Date: Fri, 20 Apr 2012 20:08:19 +0530
Message-ID: <d69a5a1782dd5b3794115d1862891aa91f725ed4.1334932338.git.viresh.kumar@st.com>
References: <cover.1334932338.git.viresh.kumar@st.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pz0-f52.google.com ([209.85.210.52]:40428 "EHLO
	mail-pz0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754768Ab2DTOi7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 20 Apr 2012 10:38:59 -0400
Received: by mail-pz0-f52.google.com with SMTP id e40so13106310dak.11
        for <linux-ide@vger.kernel.org>; Fri, 20 Apr 2012 07:38:59 -0700 (PDT)
In-Reply-To: <cover.1334932338.git.viresh.kumar@st.com>
In-Reply-To: <cover.1334932338.git.viresh.kumar@st.com>
References: <cover.1334932338.git.viresh.kumar@st.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@redhat.com
Cc: spear-devel@list.st.com, viresh.linux@gmail.com, linux-ide@vger.kernel.org, Viresh Kumar <viresh.kumar@st.com>

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
1.7.9

