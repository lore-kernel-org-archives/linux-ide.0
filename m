From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH 2/2 v3] pata_hpt{37x|3x2n}: use pr_*(DRV_NAME ...) instead of printk(KERN_* ...)
Date: Mon, 10 Jan 2011 21:39:34 +0300
Message-ID: <201101102139.35078.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dev.rtsoft.ru ([213.79.90.226]:59776 "HELO
	mail.dev.rtsoft.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751619Ab1AJSky (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 10 Jan 2011 13:40:54 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org
Cc: alan@lxorguk.ukuu.org.uk

... the same as the 'pata_hpt366' driver does.

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
The patch is against the recent Linus' tree plus the patches queued by
Jeff Garzik in his 'upstream-linus' branch.

Changes from the previous version:
- moved change in hpt_dma_blacklisted() of the 'pata_hpt37x' driver to patch 1.

 drivers/ata/pata_hpt37x.c  |   22 +++++++++++-----------
 drivers/ata/pata_hpt3x2n.c |   12 +++++-------
 2 files changed, 16 insertions(+), 18 deletions(-)

Index: linux-2.6/drivers/ata/pata_hpt37x.c
===================================================================
--- linux-2.6.orig/drivers/ata/pata_hpt37x.c
+++ linux-2.6/drivers/ata/pata_hpt37x.c
@@ -24,7 +24,7 @@
 #include <linux/libata.h>
 
 #define DRV_NAME	"pata_hpt37x"
-#define DRV_VERSION	"0.6.19"
+#define DRV_VERSION	"0.6.20"
 
 struct hpt_clock {
 	u8	xfer_speed;
@@ -863,7 +863,7 @@ static int hpt37x_init_one(struct pci_de
 			chip_table = &hpt372;
 			break;
 		default:
-			printk(KERN_ERR "pata_hpt37x: Unknown HPT366 subtype, "
+			pr_err(DRV_NAME ": Unknown HPT366 subtype, "
 			       "please report (%d).\n", rev);
 			return -ENODEV;
 		}
@@ -906,8 +906,8 @@ static int hpt37x_init_one(struct pci_de
 				*ppi = &info_hpt374_fn1;
 			break;
 		default:
-			printk(KERN_ERR
-			       "pata_hpt37x: PCI table is bogus, please report (%d).\n",
+			pr_err(DRV_NAME
+			       ": PCI table is bogus, please report (%d).\n",
 			       dev->device);
 				return -ENODEV;
 		}
@@ -957,8 +957,7 @@ static int hpt37x_init_one(struct pci_de
 		u8 sr;
 		u32 total = 0;
 
-		printk(KERN_WARNING
-		       "pata_hpt37x: BIOS has not set timing clocks.\n");
+		pr_warning(DRV_NAME ": BIOS has not set timing clocks.\n");
 
 		/* This is the process the HPT371 BIOS is reported to use */
 		for (i = 0; i < 128; i++) {
@@ -1014,7 +1013,7 @@ static int hpt37x_init_one(struct pci_de
 					       (f_high << 16) | f_low | 0x100);
 		}
 		if (adjust == 8) {
-			printk(KERN_ERR "pata_hpt37x: DPLL did not stabilize!\n");
+			pr_err(DRV_NAME ": DPLL did not stabilize!\n");
 			return -ENODEV;
 		}
 		if (dpll == 3)
@@ -1022,8 +1021,8 @@ static int hpt37x_init_one(struct pci_de
 		else
 			private_data = (void *)hpt37x_timings_50;
 
-		printk(KERN_INFO "pata_hpt37x: bus clock %dMHz, using %dMHz DPLL.\n",
-		       MHz[clock_slot], MHz[dpll]);
+		pr_info(DRV_NAME ": bus clock %dMHz, using %dMHz DPLL.\n",
+			MHz[clock_slot], MHz[dpll]);
 	} else {
 		private_data = (void *)chip_table->clocks[clock_slot];
 		/*
@@ -1036,8 +1035,9 @@ static int hpt37x_init_one(struct pci_de
 			ppi[0] = &info_hpt370_33;
 		if (clock_slot < 2 && ppi[0] == &info_hpt370a)
 			ppi[0] = &info_hpt370a_33;
-		printk(KERN_INFO "pata_hpt37x: %s using %dMHz bus clock.\n",
-		       chip_table->name, MHz[clock_slot]);
+
+		pr_info(DRV_NAME ": %s using %dMHz bus clock.\n",
+			chip_table->name, MHz[clock_slot]);
 	}
 
 	/* Now kick off ATA set up */
Index: linux-2.6/drivers/ata/pata_hpt3x2n.c
===================================================================
--- linux-2.6.orig/drivers/ata/pata_hpt3x2n.c
+++ linux-2.6/drivers/ata/pata_hpt3x2n.c
@@ -25,7 +25,7 @@
 #include <linux/libata.h>
 
 #define DRV_NAME	"pata_hpt3x2n"
-#define DRV_VERSION	"0.3.13"
+#define DRV_VERSION	"0.3.14"
 
 enum {
 	HPT_PCI_FAST	=	(1 << 31),
@@ -418,7 +418,7 @@ static int hpt3x2n_pci_clock(struct pci_
 		u16 sr;
 		u32 total = 0;
 
-		printk(KERN_WARNING "pata_hpt3x2n: BIOS clock data not set.\n");
+		pr_warning(DRV_NAME ": BIOS clock data not set.\n");
 
 		/* This is the process the HPT371 BIOS is reported to use */
 		for (i = 0; i < 128; i++) {
@@ -528,8 +528,7 @@ hpt372n:
 		ppi[0] = &info_hpt372n;
 		break;
 	default:
-		printk(KERN_ERR
-		       "pata_hpt3x2n: PCI table is bogus please report (%d).\n",
+		pr_err(DRV_NAME ": PCI table is bogus, please report (%d).\n",
 		       dev->device);
 		return -ENODEV;
 	}
@@ -579,12 +578,11 @@ hpt372n:
 		pci_write_config_dword(dev, 0x5C, (f_high << 16) | f_low);
 	}
 	if (adjust == 8) {
-		printk(KERN_ERR "pata_hpt3x2n: DPLL did not stabilize!\n");
+		pr_err(DRV_NAME ": DPLL did not stabilize!\n");
 		return -ENODEV;
 	}
 
-	printk(KERN_INFO "pata_hpt37x: bus clock %dMHz, using 66MHz DPLL.\n",
-	       pci_mhz);
+	pr_info(DRV_NAME ": bus clock %dMHz, using 66MHz DPLL.\n", pci_mhz);
 
 	/*
 	 * Set our private data up. We only need a few flags
