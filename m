From: "Tomita, Haruo" <haruo.tomita@toshiba.co.jp>
Subject: [patch] 2.4.28-pre1: piix for 82801ESB  combine mode
Date: Thu, 19 Aug 2004 18:05:27 +0900
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <7076215DFAA4574099E5CD59FE42226204ED6D95@pcssrv42.pcs.pc.ome.toshiba.co.jp>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-2022-jp"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from inet-tsb.toshiba.co.jp ([202.33.96.40]:28815 "EHLO
	inet-tsb.toshiba.co.jp") by vger.kernel.org with ESMTP
	id S264256AbUHSJGx (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 19 Aug 2004 05:06:53 -0400
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>, linux-ide@vger.kernel.org, "Tomita, Haruo" <haruo.tomita@toshiba.co.jp>

Dear Jeff,

It seems that it cannot perform in combine mode 
at the ata_piix driver of a version 1.02.
In this case, although a piix driver should operate, 
ESB_3 is not recognized in a piix driver.
I created the following patches to linux-2.4,8-pre1 and linux-2.6.8.1.
Would you be applied in this patch?

===== For linux-2.4.28-pre1 =====

diff -urN linux-2.4.28-pre1.orig/drivers/ide/pci/piix.c linux-2.4.28-pre1/drivers/ide/pci/piix.c
--- linux-2.4.28-pre1.orig/drivers/ide/pci/piix.c	2004-08-17 14:24:03.000000000 +0900
+++ linux-2.4.28-pre1/drivers/ide/pci/piix.c	2004-08-19 15:10:35.000000000 +0900
@@ -143,6 +143,7 @@
 		p += sprintf(p, "\n                                Intel ");
 		switch(dev->device) {
 			case PCI_DEVICE_ID_INTEL_82801EB_1:
+			case PCI_DEVICE_ID_INTEL_ESB_3:
 				p += sprintf(p, "PIIX4 SATA 150 ");
 				break;
 			case PCI_DEVICE_ID_INTEL_82801BA_8:
@@ -281,6 +282,7 @@
 
 	switch(dev->device) {
 		case PCI_DEVICE_ID_INTEL_82801EB_1:
+		case PCI_DEVICE_ID_INTEL_ESB_3:
 			mode = 3;
 			break;
 		/* UDMA 100 capable */
@@ -881,7 +883,10 @@
  	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801EB_1, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 18},
 #endif
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ESB_2, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 19},
-	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH6_2, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 20},
+#ifdef CONFIG_BLK_DEV_IDE_SATA
+	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ESB_3, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 20},
+#endif
+	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH6_2, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 21},
 	{ 0, },
 };
 
diff -urN linux-2.4.28-pre1.orig/drivers/ide/pci/piix.h linux-2.4.28-pre1/drivers/ide/pci/piix.h
--- linux-2.4.28-pre1.orig/drivers/ide/pci/piix.h	2004-08-17 14:34:47.000000000 +0900
+++ linux-2.4.28-pre1/drivers/ide/pci/piix.h	2004-08-19 12:42:58.000000000 +0900
@@ -321,6 +321,20 @@
 		.extra		= 0,
 	},{	/* 20 */
 		.vendor		= PCI_VENDOR_ID_INTEL,
+		.device		= PCI_DEVICE_ID_INTEL_ESB_3,
+		.name		= "ICH5-SATA",
+		.init_setup	= init_setup_piix,
+		.init_chipset	= init_chipset_piix,
+		.init_iops	= NULL,
+		.init_hwif	= init_hwif_piix,
+		.init_dma	= init_dma_piix,
+		.channels	= 2,
+		.autodma	= AUTODMA,
+		.enablebits	= {{0x41,0x80,0x80}, {0x43,0x80,0x80}},
+		.bootable	= ON_BOARD,
+		.extra		= 0,
+	},{	/* 21 */
+		.vendor		= PCI_VENDOR_ID_INTEL,
 		.device		= PCI_DEVICE_ID_INTEL_ICH6_2,
 		.name		= "ICH6",
 		.init_setup	= init_setup_piix,

===== For linux-2.6.8.1 =====

diff -urN linux-2.6.8.1orig/drivers/ide/pci/piix.c linux-2.6.8.1/drivers/ide/pci/piix.c
--- linux-2.6.8.1orig/drivers/ide/pci/piix.c	2004-08-14 19:54:48.000000000 +0900
+++ linux-2.6.8.1/drivers/ide/pci/piix.c	2004-08-19 14:38:56.344569904 +0900
@@ -142,6 +142,7 @@
 		p += sprintf(p, "\n                                Intel ");
 		switch(dev->device) {
 			case PCI_DEVICE_ID_INTEL_82801EB_1:
+			case PCI_DEVICE_ID_INTEL_ESB_3:
 				p += sprintf(p, "PIIX4 SATA 150 ");
 				break;
 			case PCI_DEVICE_ID_INTEL_82801BA_8:
@@ -280,6 +281,7 @@
 
 	switch(dev->device) {
 		case PCI_DEVICE_ID_INTEL_82801EB_1:
+		case PCI_DEVICE_ID_INTEL_ESB_3:
 			mode = 3;
 			break;
 		/* UDMA 100 capable */
@@ -797,7 +799,10 @@
  	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801EB_1, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 18},
 #endif
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ESB_2, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 19},
-	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH6_19, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 20},
+#ifdef CONFIG_BLK_DEV_IDE_SATA
+	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ESB_3, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 20},
+#endif
+	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH6_19, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 21},
 	{ 0, },
 };
 MODULE_DEVICE_TABLE(pci, piix_pci_tbl);
diff -urN linux-2.6.8.1orig/drivers/ide/pci/piix.h linux-2.6.8.1/drivers/ide/pci/piix.h
--- linux-2.6.8.1orig/drivers/ide/pci/piix.h	2004-08-14 19:54:51.000000000 +0900
+++ linux-2.6.8.1/drivers/ide/pci/piix.h	2004-08-19 11:35:46.234320616 +0900
@@ -61,7 +61,8 @@
 	/* 17 */ DECLARE_PIIX_DEV("ICH4"),
 	/* 18 */ DECLARE_PIIX_DEV("ICH5-SATA"),
 	/* 19 */ DECLARE_PIIX_DEV("ICH5"),
-	/* 20 */ DECLARE_PIIX_DEV("ICH6")
+	/* 20 */ DECLARE_PIIX_DEV("ICH5-SATA"),
+	/* 21 */ DECLARE_PIIX_DEV("ICH6")
 };
 
 #endif /* PIIX_H */

