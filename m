From: Mikael Pettersson <mikpe@it.uu.se>
Subject: [PATCH 2.6.21-rc1] sata_promise: fix 20619 new EH merge error
Date: Sun, 25 Feb 2007 12:44:39 +0100 (MET)
Message-ID: <200702251144.l1PBidUj003214@harpo.it.uu.se>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aun.it.uu.se ([130.238.12.36]:36885 "EHLO aun.it.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964801AbXBYLov (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 25 Feb 2007 06:44:51 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

When I merged my 20619 new EH conversion with #libata-upstream
I had to manually resolve a conflict, and inadvertently lost
pdc_pata_ops' ->post_internal_cmd binding. Corrected by this patch.

Signed-off-by: Mikael Pettersson <mikpe@it.uu.se>

---

 drivers/ata/sata_promise.c |    1 +
 1 files changed, 1 insertion(+)

diff -rupN linux-2.6.21-rc1/drivers/ata/sata_promise.c linux-2.6.21-rc1.sata_promise-20619-newEH-fix/drivers/ata/sata_promise.c
--- linux-2.6.21-rc1/drivers/ata/sata_promise.c	2007-02-24 22:32:42.000000000 +0100
+++ linux-2.6.21-rc1.sata_promise-20619-newEH-fix/drivers/ata/sata_promise.c	2007-02-24 23:05:08.000000000 +0100
@@ -218,6 +218,7 @@ static const struct ata_port_operations 
 	.freeze			= pdc_freeze,
 	.thaw			= pdc_thaw,
 	.error_handler		= pdc_error_handler,
+	.post_internal_cmd	= pdc_post_internal_cmd,
 	.data_xfer		= ata_data_xfer,
 	.irq_handler		= pdc_interrupt,
 	.irq_clear		= pdc_irq_clear,
