From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Subject: [PATCH 05/11] at91/ide: use gpio_is_valid to check the gpio
Date: Mon, 19 Sep 2011 14:51:29 +0200
Message-ID: <1316436695-19194-5-git-send-email-plagnioj@jcrosoft.com>
References: <1316436695-19194-1-git-send-email-plagnioj@jcrosoft.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mo1.mail-out.ovh.net ([178.32.228.1]:59705 "EHLO
	mo1.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754519Ab1ISNxp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 19 Sep 2011 09:53:45 -0400
Received: from mail179.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo1.mail-out.ovh.net (Postfix) with SMTP id C906F1014A74
	for <linux-ide@vger.kernel.org>; Mon, 19 Sep 2011 15:14:40 +0200 (CEST)
In-Reply-To: <1316436695-19194-1-git-send-email-plagnioj@jcrosoft.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, Nicolas Ferre <nicolas.ferre@atmel.com>, linux-ide@vger.kernel.org

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: linux-ide@vger.kernel.org
---
Hi,

	I'd like to apply this patch via AT91 with the whole gpio patch series

Best Regards,
J.
 drivers/ide/at91_ide.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/ide/at91_ide.c b/drivers/ide/at91_ide.c
index 000a78e..ba2eda3 100644
--- a/drivers/ide/at91_ide.c
+++ b/drivers/ide/at91_ide.c
@@ -314,7 +314,7 @@ static int __init at91_ide_probe(struct platform_device *pdev)
 	apply_timings(board->chipselect, 0, ide_timing_find_mode(XFER_PIO_0), 0);
 
 	/* with GPIO interrupt we have to do quirks in handler */
-	if (board->irq_pin >= PIN_BASE)
+	if (gpio_is_valid(board->irq_pin))
 		host->irq_handler = at91_irq_handler;
 
 	host->ports[0]->select_data = board->chipselect;
-- 
1.7.5.4

