From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 1/2] ahci: disable correct irq for dymmy ports
Date: Thu, 11 Aug 2016 07:24:18 -0700
Message-ID: <1470925459-28873-1-git-send-email-hch@lst.de>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:58284 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750832AbcHKOYV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 11 Aug 2016 10:24:21 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org
Cc: linux-ide@vger.kernel.org

irq already contains the interrupt number for the port, don't add the port
index to it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/ata/libahci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index 7461a58..dcf2c72 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -2524,7 +2524,7 @@ static int ahci_host_activate_multi_irqs(struct ata_host *host,
 
 		/* Do not receive interrupts sent by dummy ports */
 		if (!pp) {
-			disable_irq(irq + i);
+			disable_irq(irq);
 			continue;
 		}
 
-- 
2.1.4

