From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 2/2] IDE: palm_bk3710: fix compile warning for unused variable
Date: Thu, 21 Aug 2008 14:23:44 -0700
Message-ID: <1219353824-31246-2-git-send-email-khilman@deeprootsystems.com>
References: <1219353824-31246-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from deeprooted.net ([216.254.16.51]:33420 "EHLO grasse"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754855AbYHUWq5 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 21 Aug 2008 18:46:57 -0400
In-Reply-To: <1219353824-31246-1-git-send-email-khilman@deeprootsystems.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Kevin Hilman <khilman@deeprootsystems.com>

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 drivers/ide/arm/palm_bk3710.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/ide/arm/palm_bk3710.c b/drivers/ide/arm/palm_bk3710.c
index f788fa5..581a7d1 100644
--- a/drivers/ide/arm/palm_bk3710.c
+++ b/drivers/ide/arm/palm_bk3710.c
@@ -347,7 +347,6 @@ static int __devinit palm_bk3710_probe(struct platform_device *pdev)
 {
 	struct clk *clk;
 	struct resource *mem, *irq;
-	struct ide_host *host;
 	unsigned long base, rate;
 	int i, rc;
 	hw_regs_t hw, *hws[] = { &hw, NULL, NULL, NULL };
-- 
1.5.6.4

