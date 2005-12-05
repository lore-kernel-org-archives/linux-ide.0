From: Akira Tsukamoto <akira-t@s9.dion.ne.jp>
Subject: [PATH 2.4] ide: add recent ATI IXP300/400 PATA support
Date: Mon, 05 Dec 2005 11:30:29 +0900
Message-ID: <20051205103343.701A.AKIRA-T@s9.dion.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nm02mta.dion.ne.jp ([61.117.3.79]:33796 "HELO
	nm02omta028.dion.ne.jp") by vger.kernel.org with SMTP
	id S1750983AbVLECaA (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 4 Dec 2005 21:30:00 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Marcelo Tosatti <marcelo.tosatti@cyclades.com>


This patch just adds recent ATI IXP300/400 ATA133 controler to ide, atiixp.c 
for 2.4 kernel.

People in my lab been using it for a while and seems to have no problem, 
so I decided to post it here.

If acceptable, please apply.


Signed-off-by: Akira Tsukamoto <akira-t@s9.dion.ne.jp>

diff -NurpX dontdiff linux-2.4.31/drivers/ide/pci/atiixp.c linux-2.4.31-ixp/drivers/ide/pci/atiixp.c
--- linux-2.4.31/drivers/ide/pci/atiixp.c	2004-04-14 22:05:29.000000000 +0900
+++ linux-2.4.31-ixp/drivers/ide/pci/atiixp.c	2005-11-28 02:02:48.000000000 +0900
@@ -467,15 +467,35 @@ static void __devinit init_hwif_atiixp(i
 static ide_pci_device_t atiixp_pci_info[] __devinitdata = {
 	{	/* 0 */
 		.vendor		= PCI_VENDOR_ID_ATI,
-		.device		= PCI_DEVICE_ID_ATI_IXP_IDE,
-		.name		= "ATIIXP",
+		.device		= PCI_DEVICE_ID_ATI_IXP200_IDE,
+		.name		= "ATI-IXP200",
 		.init_chipset	= init_chipset_atiixp,
 		.init_hwif	= init_hwif_atiixp,
 		.channels	= 2,
 		.autodma	= AUTODMA,
 		.enablebits	= {{0x48,0x01,0x00}, {0x48,0x08,0x00}},
 		.bootable	= ON_BOARD,
-	}
+	},{	/* 1 */
+		.vendor		= PCI_VENDOR_ID_ATI,
+		.device		= PCI_DEVICE_ID_ATI_IXP300_IDE,
+		.name		= "ATI-IXP300",
+		.init_chipset	= init_chipset_atiixp,
+		.init_hwif	= init_hwif_atiixp,
+		.channels	= 2,
+		.autodma	= AUTODMA,
+		.enablebits	= {{0x48,0x01,0x00}, {0x48,0x08,0x00}},
+		.bootable	= ON_BOARD,
+	},{	/* 2 */
+		.vendor		= PCI_VENDOR_ID_ATI,
+		.device		= PCI_DEVICE_ID_ATI_IXP400_IDE,
+		.name		= "ATI-IXP400",
+		.init_chipset	= init_chipset_atiixp,
+		.init_hwif	= init_hwif_atiixp,
+		.channels	= 2,
+		.autodma	= AUTODMA,
+		.enablebits	= {{0x48,0x01,0x00}, {0x48,0x08,0x00}},
+		.bootable	= ON_BOARD,
+        }
 };
 
 /**
@@ -498,7 +518,9 @@ static int __devinit atiixp_init_one(str
 }
 
 static struct pci_device_id atiixp_pci_tbl[] = {
-	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_IXP_IDE, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
+	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_IXP200_IDE, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
+	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_IXP300_IDE, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 1},
+	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_IXP400_IDE, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 2},
 	{ 0, },
 };
 
diff -NurpX dontdiff linux-2.4.31/include/linux/pci_ids.h linux-2.4.31-ixp/include/linux/pci_ids.h
--- linux-2.4.31/include/linux/pci_ids.h	2005-06-01 09:56:56.000000000 +0900
+++ linux-2.4.31-ixp/include/linux/pci_ids.h	2005-11-28 01:00:17.000000000 +0900
@@ -319,7 +319,11 @@
 /* RadeonIGP */
 #define PCI_DEVICE_ID_ATI_RADEON_IGP	0xCAB0
 /* ATI IXP Chipset */
-#define PCI_DEVICE_ID_ATI_IXP_IDE	0x4349
+#define PCI_DEVICE_ID_ATI_IXP200_IDE	0x4349
+#define PCI_DEVICE_ID_ATI_IXP300_IDE	0x4369
+#define PCI_DEVICE_ID_ATI_IXP300_SATA	0x436e
+#define PCI_DEVICE_ID_ATI_IXP400_IDE	0x4376
+#define PCI_DEVICE_ID_ATI_IXP400_SATA	0x4379
 
 #define PCI_VENDOR_ID_VLSI		0x1004
 #define PCI_DEVICE_ID_VLSI_82C592	0x0005
Binary files linux-2.4.31/initrd.img and linux-2.4.31-ixp/initrd.img differ


-- 
Akira Tsukamoto <akira-t@s9.dion.ne.jp> <at541@columbia.edu>


