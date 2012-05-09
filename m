From: Viresh Kumar <viresh.kumar@st.com>
Subject: [PATCH V3 1/3] ata: pata_arasan: Add clk_{un}prepare() support
Date: Wed, 9 May 2012 09:38:59 +0530
Message-ID: <9848a1a6838c4f3a7e0cbd6cdc3bc6146fd2e2cc.1336536285.git.viresh.kumar@st.com>
References: <cover.1336536285.git.viresh.kumar@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from eu1sys200aog104.obsmtp.com ([207.126.144.117]:54652 "EHLO
	eu1sys200aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751232Ab2EIEJY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 9 May 2012 00:09:24 -0400
In-Reply-To: <cover.1336536285.git.viresh.kumar@st.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@redhat.com
Cc: linux-ide@vger.kernel.org, sshtylyov@mvista.com, spear-devel@list.st.com, viresh.linux@gmail.com, Viresh Kumar <viresh.kumar@st.com>

clk_{un}prepare is mandatory for platforms using common clock framework. Since
this driver is used by SPEAr platform, which supports common clock framework,
add clk_{un}prepare() support for it.

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 drivers/ata/pata_arasan_cf.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/pata_arasan_cf.c b/drivers/ata/pata_arasan_cf.c
index b943be0..febc914 100644
--- a/drivers/ata/pata_arasan_cf.c
+++ b/drivers/ata/pata_arasan_cf.c
@@ -310,7 +310,7 @@ static int cf_init(struct arasan_cf_dev *acdev)
 	unsigned long flags;
 	int ret = 0;
 
-	ret = clk_enable(acdev->clk);
+	ret = clk_prepare_enable(acdev->clk);
 	if (ret) {
 		dev_dbg(acdev->host->dev, "clock enable failed");
 		return ret;
@@ -340,7 +340,7 @@ static void cf_exit(struct arasan_cf_dev *acdev)
 	writel(readl(acdev->vbase + OP_MODE) & ~CFHOST_ENB,
 			acdev->vbase + OP_MODE);
 	spin_unlock_irqrestore(&acdev->host->lock, flags);
-	clk_disable(acdev->clk);
+	clk_disable_unprepare(acdev->clk);
 }
 
 static void dma_callback(void *dev)
-- 
1.7.9

