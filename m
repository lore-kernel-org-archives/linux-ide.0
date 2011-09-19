From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Subject: [PATCH 04/11] at91/pata: use gpio_is_valid to check the gpio
Date: Mon, 19 Sep 2011 14:51:28 +0200
Message-ID: <1316436695-19194-4-git-send-email-plagnioj@jcrosoft.com>
References: <1316436695-19194-1-git-send-email-plagnioj@jcrosoft.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 7.mo1.mail-out.ovh.net ([87.98.158.110]:53094 "EHLO
	mo1.mail-out.ovh.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751216Ab1ISQzX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 19 Sep 2011 12:55:23 -0400
Received: from mail179.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo1.mail-out.ovh.net (Postfix) with SMTP id CA5F41014A75
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
 drivers/ata/pata_at91.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/pata_at91.c b/drivers/ata/pata_at91.c
index 960c725..3915353 100644
--- a/drivers/ata/pata_at91.c
+++ b/drivers/ata/pata_at91.c
@@ -360,7 +360,7 @@ static int __devinit pata_at91_probe(struct platform_device *pdev)
 	ap->flags |= ATA_FLAG_SLAVE_POSS;
 	ap->pio_mask = ATA_PIO4;
 
-	if (!irq) {
+	if (!gpio_is_valid(irq)) {
 		ap->flags |= ATA_FLAG_PIO_POLLING;
 		ata_port_desc(ap, "no IRQ, using PIO polling");
 	}
@@ -414,8 +414,8 @@ static int __devinit pata_at91_probe(struct platform_device *pdev)
 
 	host->private_data = info;
 
-	return ata_host_activate(host, irq ? gpio_to_irq(irq) : 0,
-			irq ? ata_sff_interrupt : NULL,
+	return ata_host_activate(host, gpio_is_valid(irq) ? gpio_to_irq(irq) : 0,
+			gpio_is_valid(irq) ? ata_sff_interrupt : NULL,
 			irq_flags, &pata_at91_sht);
 
 err_put:
-- 
1.7.5.4

