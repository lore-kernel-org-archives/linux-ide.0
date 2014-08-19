From: Alexander Shiyan <shc_work@mail.ru>
Subject: [PATCH] libata: Use dev_name() for request_irq() to distinguish devices
Date: Tue, 19 Aug 2014 10:51:04 +0400
Message-ID: <1408431064-6796-1-git-send-email-shc_work@mail.ru>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fallback8.mail.ru ([94.100.181.110]:47130 "EHLO
	fallback8.mail.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752680AbaHSHcB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 19 Aug 2014 03:32:01 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>, Alexander Shiyan <shc_work@mail.ru>

Use dev_name() instead of driver name for request_irq().
This will help to distinguish between multiple identical devices.

Before:
 CPU0
 5:      34425  clps711x-intc   5  pata_of_platform
 6:       6778  clps711x-intc   6  pata_of_platform

After:
 CPU0
 5:       2182  clps711x-intc   5  20000000.ide
 6:      11024  clps711x-intc   6  20100000.ide

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 drivers/ata/libata-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index dbdc5d3..782d126 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -6227,7 +6227,7 @@ int ata_host_activate(struct ata_host *host, int irq,
 	}
 
 	rc = devm_request_irq(host->dev, irq, irq_handler, irq_flags,
-			      dev_driver_string(host->dev), host);
+			      dev_name(host->dev), host);
 	if (rc)
 		return rc;
 
-- 
1.8.5.5

