From: Mikael Pettersson <mikpe@it.uu.se>
Subject: [PATCH 2.6.21-mm1 1/2] sata_promise: fix another error decode regression
Date: Sun, 6 May 2007 22:12:31 +0200 (MEST)
Message-ID: <200705062012.l46KCVoK026743@harpo.it.uu.se>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aun.it.uu.se ([130.238.12.36]:56130 "EHLO aun.it.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755239AbXEFUMn (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 6 May 2007 16:12:43 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: akpm@linux-foundation.org, linux-ide@vger.kernel.org

The sata_promise error decode update changed pdc_host_intr()
to return and not complete the qc after detecting an error.
Unfortunately not completing the qc:s causes them to always
time out on error, which is wrong and has nasty side-effects.

This patch updates pdc_error_intr() to call ata_port_abort(),
similar to ahci and sata_sil24. Doing this is important as it
makes EH see the original error and not a bogus timeout.

Signed-off-by: Mikael Pettersson <mikpe@it.uu.se>
---
Thanks to Tejun for educating me about the significance of
ata_port_abort()/ata_port_freeze() in ahci and sata_sil24's
error intr paths.

 drivers/ata/sata_promise.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletion(-)

--- linux-2.6.21-mm1/drivers/ata/sata_promise.c.~1~	2007-05-06 20:29:01.000000000 +0200
+++ linux-2.6.21-mm1/drivers/ata/sata_promise.c	2007-05-06 20:29:28.000000000 +0200
@@ -45,7 +45,7 @@
 #include "sata_promise.h"
 
 #define DRV_NAME	"sata_promise"
-#define DRV_VERSION	"2.05"
+#define DRV_VERSION	"2.06"
 
 
 enum {
@@ -653,6 +653,8 @@ static void pdc_error_intr(struct ata_po
 	qc->err_mask |= ac_err_mask;
 
 	pdc_reset_port(ap);
+
+	ata_port_abort(ap);
 }
 
 static inline unsigned int pdc_host_intr( struct ata_port *ap,
