From: Mikael Pettersson <mikpe@it.uu.se>
Subject: [PATCH 2.6.21-rc7-mm2 2/2] sata_promise: move port reset from error intr to EH prereset
Date: Sun, 29 Apr 2007 04:03:30 +0200 (MEST)
Message-ID: <200704290203.l3T23UeQ009873@harpo.it.uu.se>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aun.it.uu.se ([130.238.12.36]:64736 "EHLO aun.it.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753699AbXD2CDg (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 28 Apr 2007 22:03:36 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

When sata_promise detects an error, it resets the port and
triggers EH. This is how it has always done things. New-style
EH however appears to prefer (based on ahci and sata_sil24)
error detection to just freeze the port or otherwise render
it harmless, and for the reset to be delayed until EH runs.

This patch updates sata_promise EH according to this principle.
When an error is detected in pdc_error_intr, the port is frozen
but not reset. Later in the error handler, the prereset procedure
performs the necessary Promise-specific reset of the port.

Notes:
- Since pdc_error_intr no longer resets the port, ata_do_eh()
  can do its error analysis on the current register contents, so
  pdc_error_intr doesn't need to copy SCR_ERROR to ehi->serror.
- The reset is done in prereset since that is the one point that
  (a) comes after libata's error analysis, and (b) dominates
  (in a control-flow sense) all subsequent reset parts of EH.

Tested on SATA300 TX4, SATA300 TX2plus, SATAII-150 TX2plus,
SATA150 TX2plus, and TX4000.

Signed-off-by: Mikael Pettersson <mikpe@it.uu.se>
---
 drivers/ata/sata_promise.c |   19 ++++++++++---------
 1 files changed, 10 insertions(+), 9 deletions(-)

--- linux-2.6.21-rc7-mm2/drivers/ata/sata_promise.c.~1~	2007-04-28 23:16:57.000000000 +0200
+++ linux-2.6.21-rc7-mm2/drivers/ata/sata_promise.c	2007-04-28 23:55:49.000000000 +0200
@@ -45,7 +45,7 @@
 #include "sata_promise.h"
 
 #define DRV_NAME	"sata_promise"
-#define DRV_VERSION	"2.06"
+#define DRV_VERSION	"2.07"
 
 
 enum {
@@ -598,13 +598,16 @@ static void pdc_thaw(struct ata_port *ap
 	readl(mmio + PDC_CTLSTAT); /* flush */
 }
 
-static void pdc_common_error_handler(struct ata_port *ap, ata_reset_fn_t hardreset)
+static int pdc_prereset(struct ata_port *ap, unsigned long deadline)
 {
-	if (!(ap->pflags & ATA_PFLAG_FROZEN))
-		pdc_reset_port(ap);
+	pdc_reset_port(ap);
+	return ata_std_prereset(ap, deadline);
+}
 
+static void pdc_common_error_handler(struct ata_port *ap, ata_reset_fn_t hardreset)
+{
 	/* perform recovery */
-	ata_do_eh(ap, ata_std_prereset, ata_std_softreset, hardreset,
+	ata_do_eh(ap, pdc_prereset, ata_std_softreset, hardreset,
 		  ata_std_postreset);
 }
 
@@ -647,12 +650,10 @@ static void pdc_error_intr(struct ata_po
 			   | PDC_PCI_SYS_ERR | PDC1_PCI_PARITY_ERR))
 		ac_err_mask |= AC_ERR_HOST_BUS;
 
-	if (sata_scr_valid(ap))
-		ehi->serror |= pdc_sata_scr_read(ap, SCR_ERROR);
-
+	ehi->action |= ATA_EH_SOFTRESET;
 	qc->err_mask |= ac_err_mask;
 
-	pdc_reset_port(ap);
+	ata_port_freeze(ap);
 }
 
 static inline unsigned int pdc_host_intr( struct ata_port *ap,
