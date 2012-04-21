From: Viresh Kumar <viresh.linux@gmail.com>
Subject: [PATCH V2 2/5] ata: pata_arasan: Add clk_{un}prepare() support
Date: Sat, 21 Apr 2012 17:40:10 +0530
Message-ID: <6b5d5180809bff6d85d4a75ce59b44a5894784e3.1335009631.git.viresh.kumar@st.com>
References: <cover.1335009631.git.viresh.kumar@st.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:33246 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751725Ab2DUML2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 21 Apr 2012 08:11:28 -0400
Received: by pbcun15 with SMTP id un15so2061502pbc.19
        for <linux-ide@vger.kernel.org>; Sat, 21 Apr 2012 05:11:28 -0700 (PDT)
In-Reply-To: <cover.1335009631.git.viresh.kumar@st.com>
In-Reply-To: <cover.1335009631.git.viresh.kumar@st.com>
References: <cover.1335009631.git.viresh.kumar@st.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@redhat.com
Cc: spear-devel@list.st.com, viresh.linux@gmail.com, linux-ide@vger.kernel.org, sshtylyov@mvista.com, Viresh Kumar <viresh.kumar@st.com>

clk_{un}prepare is mandatory for platforms using common clock framework. Since
this driver is used by SPEAr platform, which supports common clock framework,
add clk_{un}prepare() support for it.

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 drivers/ata/pata_arasan_cf.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/pata_arasan_cf.c b/drivers/ata/pata_arasan_cf.c
index 5ebf1cc..aa3b4d4 100644
--- a/drivers/ata/pata_arasan_cf.c
+++ b/drivers/ata/pata_arasan_cf.c
@@ -311,7 +311,7 @@ static int cf_init(struct arasan_cf_dev *acdev)
 	int ret = 0;
 
 	if (!IS_ERR(acdev->clk)) {
-		ret = clk_enable(acdev->clk);
+		ret = clk_prepare_enable(acdev->clk);
 		if (ret) {
 			dev_dbg(acdev->host->dev, "clock enable failed");
 			return ret;
@@ -344,7 +344,7 @@ static void cf_exit(struct arasan_cf_dev *acdev)
 	spin_unlock_irqrestore(&acdev->host->lock, flags);
 
 	if (!IS_ERR(acdev->clk))
-		clk_disable(acdev->clk);
+		clk_disable_unprepare(acdev->clk);
 }
 
 static void dma_callback(void *dev)
-- 
1.7.9

