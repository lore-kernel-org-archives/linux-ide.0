From: Mikael Pettersson <mikpe@it.uu.se>
Subject: [PATCH libata#upstream 1/2] sata_promise: add missing cable_detect hooks
Date: Sun, 11 Mar 2007 21:19:27 +0100 (MET)
Message-ID: <200703112019.l2BKJRQ7018662@harpo.it.uu.se>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aun.it.uu.se ([130.238.12.36]:41535 "EHLO aun.it.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751185AbXCKUTf (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 11 Mar 2007 16:19:35 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

The recent change which moved cable detection from
pdc_pre_reset() to the new ->cable_detect hook only
added the hook for SATAII chips, leaving SATAI chips
and the 20619 without the hook. Fixed by this patch.

Signed-off-by: Mikael Pettersson <mikpe@it.uu.se>
---
 drivers/ata/sata_promise.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletion(-)

--- linux-2.6.21-rc3/drivers/ata/sata_promise.c.~1~	2007-03-11 18:44:04.000000000 +0100
+++ linux-2.6.21-rc3/drivers/ata/sata_promise.c	2007-03-11 18:44:56.000000000 +0100
@@ -45,7 +45,7 @@
 #include "sata_promise.h"
 
 #define DRV_NAME	"sata_promise"
-#define DRV_VERSION	"2.01"
+#define DRV_VERSION	"2.02"
 
 
 enum {
@@ -194,6 +194,7 @@ static const struct ata_port_operations 
 	.thaw			= pdc_thaw,
 	.error_handler		= pdc_error_handler,
 	.post_internal_cmd	= pdc_post_internal_cmd,
+	.cable_detect		= pdc_cable_detect,
 	.data_xfer		= ata_data_xfer,
 	.irq_handler		= pdc_interrupt,
 	.irq_clear		= pdc_irq_clear,
@@ -220,6 +221,7 @@ static const struct ata_port_operations 
 	.thaw			= pdc_thaw,
 	.error_handler		= pdc_error_handler,
 	.post_internal_cmd	= pdc_post_internal_cmd,
+	.cable_detect		= pdc_cable_detect,
 	.data_xfer		= ata_data_xfer,
 	.irq_handler		= pdc_interrupt,
 	.irq_clear		= pdc_irq_clear,
