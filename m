From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH 2/2] pata_hpt{37x|3x2n}: fix clock reporting
Date: Sun, 5 Aug 2007 23:07:43 +0400
Message-ID: <200708052307.43781.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtsoft3.corbina.net ([85.21.88.6]:35441 "EHLO
	buildserver.ru.mvista.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753135AbXHETFk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 5 Aug 2007 15:05:40 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org
Cc: alan@lxorguk.ukuu.org.uk, rah@bash.sh

Fix several inconsistencies in these drivers WRT reporting the clocks:

- when using DPLL mode, pata_hpt37x driver reported the DPLL frequency as the
  PCI clock -- make properly report both clocks,  add the same ability to the
  pata_hpt3x2n driver;

- both drivers sometimes used "pata_hpt3*:" and sometime "pata3*:" message
  prefixes -- make them use only the former one;

- the message about failed DPLL stablization deserved KERN_ERR.

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
This is against the current Linus tree and has only been compile tested
(as well as the first patch :-).
Bob, please test it and report what you'll find out...

 drivers/ata/pata_hpt37x.c  |   10 ++++++----
 drivers/ata/pata_hpt3x2n.c |    8 +++++---
 2 files changed, 11 insertions(+), 7 deletions(-)

Index: linux-2.6/drivers/ata/pata_hpt37x.c
===================================================================
--- linux-2.6.orig/drivers/ata/pata_hpt37x.c
+++ linux-2.6/drivers/ata/pata_hpt37x.c
@@ -24,7 +24,7 @@
 #include <linux/libata.h>
 
 #define DRV_NAME	"pata_hpt37x"
-#define DRV_VERSION	"0.6.8"
+#define DRV_VERSION	"0.6.9"
 
 struct hpt_clock {
 	u8	xfer_speed;
@@ -1112,7 +1112,7 @@ static int hpt37x_init_one(struct pci_de
 			pci_write_config_dword(dev, 0x5C, (f_high << 16) | f_low | 0x100);
 		}
 		if (adjust == 8) {
-			printk(KERN_WARNING "hpt37x: DPLL did not stabilize.\n");
+			printk(KERN_ERR "pata_hpt37x: DPLL did not stabilize!\n");
 			return -ENODEV;
 		}
 		if (dpll == 3)
@@ -1120,7 +1120,8 @@ static int hpt37x_init_one(struct pci_de
 		else
 			private_data = (void *)hpt37x_timings_50;
 
-		printk(KERN_INFO "hpt37x: Bus clock %dMHz, using DPLL.\n", MHz[dpll]);
+		printk(KERN_INFO "pata_hpt37x: bus clock %dMHz, using %dMHz DPLL.\n",
+		       MHz[clock_slot], MHz[dpll]);
 	} else {
 		private_data = (void *)chip_table->clocks[clock_slot];
 		/*
@@ -1133,7 +1134,8 @@ static int hpt37x_init_one(struct pci_de
 			port = &info_hpt370_33;
 		if (clock_slot < 2 && port == &info_hpt370a)
 			port = &info_hpt370a_33;
-		printk(KERN_INFO "hpt37x: %s: Bus clock %dMHz.\n", chip_table->name, MHz[clock_slot]);
+		printk(KERN_INFO "pata_hpt37x: %s using %dMHz bus clock.\n",
+		       chip_table->name, MHz[clock_slot]);
 	}
 
 	/* Now kick off ATA set up */
Index: linux-2.6/drivers/ata/pata_hpt3x2n.c
===================================================================
--- linux-2.6.orig/drivers/ata/pata_hpt3x2n.c
+++ linux-2.6/drivers/ata/pata_hpt3x2n.c
@@ -8,7 +8,7 @@
  * Copyright (C) 1999-2003		Andre Hedrick <andre@linux-ide.org>
  * Portions Copyright (C) 2001	        Sun Microsystems, Inc.
  * Portions Copyright (C) 2003		Red Hat Inc
- * Portions Copyright (C) 2005-2006	MontaVista Software, Inc.
+ * Portions Copyright (C) 2005-2007	MontaVista Software, Inc.
  *
  *
  * TODO
@@ -25,7 +25,7 @@
 #include <linux/libata.h>
 
 #define DRV_NAME	"pata_hpt3x2n"
-#define DRV_VERSION	"0.3.3"
+#define DRV_VERSION	"0.3.4"
 
 enum {
 	HPT_PCI_FAST	=	(1 << 31),
@@ -579,10 +579,12 @@ static int hpt3x2n_init_one(struct pci_d
 		pci_write_config_dword(dev, 0x5C, (f_high << 16) | f_low);
 	}
 	if (adjust == 8) {
-		printk(KERN_WARNING "hpt3x2n: DPLL did not stabilize.\n");
+		printk(KERN_ERR "pata_hpt3x2n: DPLL did not stabilize!\n");
 		return -ENODEV;
 	}
 
+	printk(KERN_INFO "pata_hpt37x: bus clock %dMHz, using 66MHz DPLL.\n",
+	       pci_mhz);
 	/* Set our private data up. We only need a few flags so we use
 	   it directly */
 	port.private_data = NULL;

