From: Mikael Pettersson <mikpe@it.uu.se>
Subject: [PATCH libata#upstream] sata_promise: fix error decode regression
Date: Sat, 7 Apr 2007 14:29:51 +0200 (MEST)
Message-ID: <200704071229.l37CTp6M010861@harpo.it.uu.se>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aun.it.uu.se ([130.238.12.36]:41351 "EHLO aun.it.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965824AbXDGM36 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 7 Apr 2007 08:29:58 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

Promise ATA ports should always be reset by pdc_reset_port()
when errors are detected, but the recent error reason decoding
update to sata_promise replaced that reset with a freeze.

This patch changes the error detection to do a reset again.
This makes the error decoding update safer, as it now only
adds error decoding without changing any other behaviour.

Signed-off-by: Mikael Pettersson <mikpe@it.uu.se>
---
 drivers/ata/sata_promise.c |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

--- linux-2.6.21-rc6+upstream/drivers/ata/sata_promise.c.~1~	2007-04-06 19:40:01.000000000 +0200
+++ linux-2.6.21-rc6+upstream/drivers/ata/sata_promise.c	2007-04-06 19:45:33.000000000 +0200
@@ -45,7 +45,7 @@
 #include "sata_promise.h"
 
 #define DRV_NAME	"sata_promise"
-#define DRV_VERSION	"2.04"
+#define DRV_VERSION	"2.05"
 
 
 enum {
@@ -650,9 +650,12 @@ static void pdc_error_intr(struct ata_po
 			   | PDC_PCI_SYS_ERR | PDC1_PCI_PARITY_ERR))
 		ac_err_mask |= AC_ERR_HOST_BUS;
 
-	ehi->action |= ATA_EH_SOFTRESET;
+	if (sata_scr_valid(ap))
+		ehi->serror |= pdc_sata_scr_read(ap, SCR_ERROR);
+
 	qc->err_mask |= ac_err_mask;
-	ata_port_freeze(ap);
+
+	pdc_reset_port(ap);
 }
 
 static inline unsigned int pdc_host_intr( struct ata_port *ap,
