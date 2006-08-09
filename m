From: "Anatoli Antonovitch" <antonovi@ati.com>
Subject: [PATCH 2.6.17] atiixp & ahci: ATI SB600 SATA/IDE support for various modes
Date: Wed, 9 Aug 2006 13:54:06 -0400
Message-ID: <B63F95CBF8A45E4293F8825849B30BF41171A6@TORCAEXMB3.atitech.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outbound-ash.frontbridge.com ([206.16.192.249]:18136 "EHLO
	outbound2-ash-R.bigfish.com") by vger.kernel.org with ESMTP
	id S1750705AbWHIR4o convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 9 Aug 2006 13:56:44 -0400
Content-class: urn:content-classes:message
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: B.Zolnierkiewicz@elka.pw.edu.pl, jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org, akpm@osdl.org

Description
1. Support SB600 SATA legacy IDE (DMA enable).
2. Automatically match the proper driver for different SATA/IDE modes of
SB600 SATA controller: ahci for SATA/Native IDE/RAID modes and
ATIIXP_IDE for legacy mode.

Signed-off-by: Anatoli Antonovitch <antonovi@ati.com>

Patch
diff -Nur linux-2.6.17/drivers/ide/pci/atiixp.c
linux-2.6.17.diff/drivers/ide/pci/atiixp.c
--- linux-2.6.17/drivers/ide/pci/atiixp.c	2006-06-18
09:49:35.000000000 +0800
+++ linux-2.6.17.diff/drivers/ide/pci/atiixp.c	2006-07-11
16:14:41.000000000 +0800
@@ -319,6 +319,21 @@
 	hwif->drives[0].autodma = hwif->autodma;
 }
 
+static void __devinit init_hwif_sb600_legacy(ide_hwif_t *hwif)
+{
+
+	hwif->atapi_dma = 1;
+	hwif->ultra_mask = 0x7f;
+	hwif->mwdma_mask = 0x07;
+	hwif->swdma_mask = 0x07;
+
+	if (!noautodma)
+		hwif->autodma = 1;
+	hwif->drives[0].autodma = hwif->autodma;
+	hwif->drives[1].autodma = hwif->autodma;
+}
+
+
 static ide_pci_device_t atiixp_pci_info[] __devinitdata = {
 	{	/* 0 */
 		.name		= "ATIIXP",
@@ -327,6 +342,12 @@
 		.autodma	= AUTODMA,
 		.enablebits	= {{0x48,0x01,0x00}, {0x48,0x08,0x00}},
 		.bootable	= ON_BOARD,
+	},{	/* 1 */
+		.name		= "ATI SB600 SATA Legacy IDE",
+		.init_hwif	= init_hwif_sb600_legacy,
+		.channels	= 2,
+		.autodma	= AUTODMA,
+		.bootable	= ON_BOARD,
 	}
 };
 
@@ -349,6 +370,7 @@
 	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_IXP300_IDE, PCI_ANY_ID,
PCI_ANY_ID, 0, 0, 0},
 	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_IXP400_IDE, PCI_ANY_ID,
PCI_ANY_ID, 0, 0, 0},
 	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_IXP600_IDE, PCI_ANY_ID,
PCI_ANY_ID, 0, 0, 0},
+	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_IXP600_SATA, PCI_ANY_ID,
PCI_ANY_ID, (PCI_CLASS_STORAGE_IDE<<8)|0x8a, 0xffff05, 1},
 	{ 0, },
 };
 MODULE_DEVICE_TABLE(pci, atiixp_pci_tbl);
diff -Nur linux-2.6.17/drivers/scsi/ahci.c
linux-2.6.17.diff/drivers/scsi/ahci.c
--- linux-2.6.17/drivers/scsi/ahci.c	2006-06-18 09:49:35.000000000
+0800
+++ linux-2.6.17.diff/drivers/scsi/ahci.c	2006-07-11
16:14:16.000000000 +0800
@@ -292,8 +292,9 @@
 	  board_ahci }, /* JMicron JMB360 */
 	{ 0x197b, 0x2363, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 	  board_ahci }, /* JMicron JMB363 */
-	{ PCI_VENDOR_ID_ATI, 0x4380, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-	  board_ahci }, /* ATI SB600 non-raid */
+	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_IXP600_SATA, PCI_ANY_ID,
PCI_ANY_ID, 0x010600, 0xffff00,	  board_ahci }, /* ATI SB600 AHCI */
+	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_IXP600_SATA, PCI_ANY_ID,
PCI_ANY_ID, 0x010400, 0xffff00,	  board_ahci }, /* ATI SB600 raid */
+	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_IXP600_SATA, PCI_ANY_ID,
PCI_ANY_ID, (PCI_CLASS_STORAGE_IDE<<8)|0x8f, 0xffff05,	  board_ahci },
/* ATI SB600 native IDE */
 	{ PCI_VENDOR_ID_ATI, 0x4381, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 	  board_ahci }, /* ATI SB600 raid */
 	{ }	/* terminate list */

