From: Viresh Kumar <viresh.linux@gmail.com>
Subject: [PATCH 2/5] ata: pata_arasan: Add clk_{un}prepare() support
Date: Fri, 20 Apr 2012 20:08:20 +0530
Message-ID: <dd18da8082e0e87c0e214c0bcd4f54c05dc721d3.1334932338.git.viresh.kumar@st.com>
References: <cover.1334932338.git.viresh.kumar@st.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pz0-f52.google.com ([209.85.210.52]:40428 "EHLO
	mail-pz0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754768Ab2DTOjW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 20 Apr 2012 10:39:22 -0400
Received: by mail-pz0-f52.google.com with SMTP id e40so13106310dak.11
        for <linux-ide@vger.kernel.org>; Fri, 20 Apr 2012 07:39:22 -0700 (PDT)
In-Reply-To: <cover.1334932338.git.viresh.kumar@st.com>
In-Reply-To: <cover.1334932338.git.viresh.kumar@st.com>
References: <cover.1334932338.git.viresh.kumar@st.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@redhat.com
Cc: spear-devel@list.st.com, viresh.linux@gmail.com, linux-ide@vger.kernel.org, Viresh Kumar <viresh.kumar@st.com>

clk_{un}prepare is mandatory for platforms using common clock framework. Since
this driver is used by SPEAr platform, which supports common clock framework,
add clk_{un}prepare() support for it.

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 drivers/ata/pata_arasan_cf.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/pata_arasan_cf.c b/drivers/ata/pata_arasan_cf.c
index 3239517..492db9c 100644
--- a/drivers/ata/pata_arasan_cf.c
+++ b/drivers/ata/pata_arasan_cf.c
@@ -313,7 +313,7 @@ static int cf_init(struct arasan_cf_dev *acdev)
 	int ret = 0;
 
 #ifdef CONFIG_HAVE_CLK
-	ret = clk_enable(acdev->clk);
+	ret = clk_prepare_enable(acdev->clk);
 	if (ret) {
 		dev_dbg(acdev->host->dev, "clock enable failed");
 		return ret;
@@ -345,7 +345,7 @@ static void cf_exit(struct arasan_cf_dev *acdev)
 			acdev->vbase + OP_MODE);
 	spin_unlock_irqrestore(&acdev->host->lock, flags);
 #ifdef CONFIG_HAVE_CLK
-	clk_disable(acdev->clk);
+	clk_disable_unprepare(acdev->clk);
 #endif
 }
 
-- 
1.7.9

