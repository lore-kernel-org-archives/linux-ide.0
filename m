From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH] IDE: palm_bk3710: convert clock usage after clkdev conversion
Date: Mon,  6 Jul 2009 15:26:16 -0700
Message-ID: <1246919176-28683-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.169]:5238 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752558AbZGFW0Q (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 6 Jul 2009 18:26:16 -0400
Received: by wf-out-1314.google.com with SMTP id 26so1615549wfd.4
        for <linux-ide@vger.kernel.org>; Mon, 06 Jul 2009 15:26:18 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: davinci-linux-open-source@linux.davincidsp.com

DaVinci core code has converted to the new clkdev API so
clock name strings are not needed.  Instead, just the a
'struct device' pointer is needed.

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
Fix needed for 2.6.31

 drivers/ide/palm_bk3710.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/ide/palm_bk3710.c b/drivers/ide/palm_bk3710.c
index 3c1dc01..f8eddf0 100644
--- a/drivers/ide/palm_bk3710.c
+++ b/drivers/ide/palm_bk3710.c
@@ -318,7 +318,7 @@ static int __init palm_bk3710_probe(struct platform_device *pdev)
 	int i, rc;
 	struct ide_hw hw, *hws[] = { &hw };
 
-	clk = clk_get(&pdev->dev, "IDECLK");
+	clk = clk_get(&pdev->dev, NULL);
 	if (IS_ERR(clk))
 		return -ENODEV;
 
-- 
1.6.3.3

