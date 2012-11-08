From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH] ata: pata_arasan: Initialize cf clock to 166MHz
Date: Thu,  8 Nov 2012 20:39:54 +0530
Message-ID: <382d2087350ff0955ba14f125294ace4ed28382b.1352387366.git.viresh.kumar@linaro.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:37057 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752631Ab2KHPKG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 8 Nov 2012 10:10:06 -0500
Received: by mail-pa0-f46.google.com with SMTP id hz1so2046422pad.19
        for <linux-ide@vger.kernel.org>; Thu, 08 Nov 2012 07:10:06 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, spear-devel@list.st.com, Vipul Kumar Samar <vipulkumar.samar@st.com>, Viresh Kumar <viresh.kumar@linaro.org>

From: Vipul Kumar Samar <vipulkumar.samar@st.com>

PATA arasan driver expects the clock to be set to 166 MHz for proper functioning.
This patch sets clk to 166 MHz in probe.

Signed-off-by: Vipul Kumar Samar <vipulkumar.samar@st.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/ata/pata_arasan_cf.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/ata/pata_arasan_cf.c b/drivers/ata/pata_arasan_cf.c
index 26201eb..71111f2 100644
--- a/drivers/ata/pata_arasan_cf.c
+++ b/drivers/ata/pata_arasan_cf.c
@@ -317,6 +317,12 @@ static int cf_init(struct arasan_cf_dev *acdev)
 		return ret;
 	}
 
+	ret = clk_set_rate(acdev->clk, 166000000);
+	if (ret) {
+		dev_warn(acdev->host->dev, "clock set rate failed");
+		return ret;
+	}
+
 	spin_lock_irqsave(&acdev->host->lock, flags);
 	/* configure CF interface clock */
 	writel((pdata->cf_if_clk <= CF_IF_CLK_200M) ? pdata->cf_if_clk :
-- 
1.7.12.rc2.18.g61b472e

