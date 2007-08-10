From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH 1/2] pata_hpt37x: actually clock HPT374 with 50 MHz DPLL (take 2)
Date: Fri, 10 Aug 2007 20:58:46 +0400
Message-ID: <200708102058.46160.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtsoft3.corbina.net ([85.21.88.6]:7576 "EHLO
	buildserver.ru.mvista.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1763452AbXHJQ4g (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 10 Aug 2007 12:56:36 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org
Cc: alan@lxorguk.ukuu.org.uk, rah@bash.sh

The DPLL tuning code always set up it for 66 MHz due to wrong UltraDMA mask
including mode 5 used to check for the necessity of 66 MHz clocking -- this
caused 66 MHz clock to be used for HPT374 chip that does not tolerate it.
While fixing this, also remove PLL mode from the TODO list -- I don't think
it's still a relevant item.

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
This is against the current Linus tree -- with wording in the header fixed. :-)

 drivers/ata/pata_hpt37x.c |   12 ++++--------
 1 files changed, 4 insertions(+), 8 deletions(-)

Index: linux-2.6/drivers/ata/pata_hpt37x.c
===================================================================
--- linux-2.6.orig/drivers/ata/pata_hpt37x.c
+++ linux-2.6/drivers/ata/pata_hpt37x.c
@@ -8,12 +8,10 @@
  * Copyright (C) 1999-2003		Andre Hedrick <andre@linux-ide.org>
  * Portions Copyright (C) 2001	        Sun Microsystems, Inc.
  * Portions Copyright (C) 2003		Red Hat Inc
- * Portions Copyright (C) 2005-2006	MontaVista Software, Inc.
+ * Portions Copyright (C) 2005-2007	MontaVista Software, Inc.
  *
  * TODO
- *	PLL mode
- *	Look into engine reset on timeout errors. Should not be
- *		required.
+ *	Look into engine reset on timeout errors. Should not be	required.
  */
 
 #include <linux/kernel.h>
@@ -26,7 +24,7 @@
 #include <linux/libata.h>
 
 #define DRV_NAME	"pata_hpt37x"
-#define DRV_VERSION	"0.6.7"
+#define DRV_VERSION	"0.6.8"
 
 struct hpt_clock {
 	u8	xfer_speed;
@@ -1092,9 +1090,7 @@ static int hpt37x_init_one(struct pci_de
 		int dpll, adjust;
 
 		/* Compute DPLL */
-		dpll = 2;
-		if (port->udma_mask & 0xE0)
-			dpll = 3;
+		dpll = (port->udma_mask & 0xC0) ? 3 : 2;
 
 		f_low = (MHz[clock_slot] * 48) / MHz[dpll];
 		f_high = f_low + 2;

