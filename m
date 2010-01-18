From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 37/64] serverworks: cleanup svwks_udma_filter()
Date: Mon, 18 Jan 2010 18:19:22 +0100
Message-ID: <20100118171922.14623.96042.sendpatchset@localhost>
References: <20100118171349.14623.90030.sendpatchset@localhost>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755230Ab0ARRUk@vger.kernel.org>
In-Reply-To: <20100118171349.14623.90030.sendpatchset@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] serverworks: cleanup svwks_udma_filter()

* remove dead OSB4 UDMA support
* remove unreachable code
* make isa_dev local to ->init_chipset

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/serverworks.c |   40 +++++++++++-----------------------------
 1 file changed, 11 insertions(+), 29 deletions(-)

Index: b/drivers/ide/serverworks.c
===================================================================
--- a/drivers/ide/serverworks.c
+++ b/drivers/ide/serverworks.c
@@ -2,7 +2,7 @@
  * Copyright (C) 1998-2000 Michel Aubry
  * Copyright (C) 1998-2000 Andrzej Krzysztofowicz
  * Copyright (C) 1998-2000 Andre Hedrick <andre@linux-ide.org>
- * Copyright (C)      2007 Bartlomiej Zolnierkiewicz
+ * Copyright (C) 2007-2010 Bartlomiej Zolnierkiewicz
  * Portions copyright (c) 2001 Sun Microsystems
  *
  *
@@ -52,8 +52,6 @@ static const char *svwks_bad_ata100[] =
 	NULL
 };
 
-static struct pci_dev *isa_dev;
-
 static int check_in_drive_lists (ide_drive_t *drive, const char **list)
 {
 	char *m = (char *)&drive->id[ATA_ID_PROD];
@@ -67,26 +65,14 @@ static int check_in_drive_lists (ide_dri
 static u8 svwks_udma_filter(ide_drive_t *drive)
 {
 	struct pci_dev *dev = to_pci_dev(drive->hwif->dev);
-	u8 mask = 0;
 
-	if (dev->device == PCI_DEVICE_ID_SERVERWORKS_HT1000IDE)
+	if (dev->device == PCI_DEVICE_ID_SERVERWORKS_HT1000IDE) {
 		return 0x1f;
-	if (dev->device == PCI_DEVICE_ID_SERVERWORKS_OSB4IDE) {
-		u32 reg = 0;
-		if (isa_dev)
-			pci_read_config_dword(isa_dev, 0x64, &reg);
-			
-		/*
-		 *	Don't enable UDMA on disk devices for the moment
-		 */
-		if(drive->media == ide_disk)
-			return 0;
-		/* Check the OSB4 DMA33 enable bit */
-		return ((reg & 0x00004000) == 0x00004000) ? 0x07 : 0;
 	} else if (dev->revision < SVWKS_CSB5_REVISION_NEW) {
 		return 0x07;
-	} else if (dev->revision >= SVWKS_CSB5_REVISION_NEW) {
-		u8 btr = 0, mode;
+	} else {
+		u8 btr = 0, mode, mask;
+
 		pci_read_config_byte(dev, 0x5A, &btr);
 		mode = btr & 0x3;
 
@@ -101,13 +87,9 @@ static u8 svwks_udma_filter(ide_drive_t
 		case 1:	 mask = 0x07; break;
 		default: mask = 0x00; break;
 		}
-	}
-	if (((dev->device == PCI_DEVICE_ID_SERVERWORKS_CSB6IDE) ||
-	     (dev->device == PCI_DEVICE_ID_SERVERWORKS_CSB6IDE2)) &&
-	    (!(PCI_FUNC(dev->devfn) & 1)))
-		mask = 0x1f;
 
-	return mask;
+		return mask;
+	}
 }
 
 static u8 svwks_csb_check (struct pci_dev *dev)
@@ -185,8 +167,9 @@ static int init_chipset_svwks(struct pci
 
 	/* OSB4 : South Bridge and IDE */
 	if (dev->device == PCI_DEVICE_ID_SERVERWORKS_OSB4IDE) {
-		isa_dev = pci_get_device(PCI_VENDOR_ID_SERVERWORKS,
-			  PCI_DEVICE_ID_SERVERWORKS_OSB4, NULL);
+		struct pci_dev *isa_dev =
+			pci_get_device(PCI_VENDOR_ID_SERVERWORKS,
+					PCI_DEVICE_ID_SERVERWORKS_OSB4, NULL);
 		if (isa_dev) {
 			pci_read_config_dword(isa_dev, 0x64, &reg);
 			reg &= ~0x00002000; /* disable 600ns interrupt mask */
@@ -343,7 +326,6 @@ static u8 svwks_cable_detect(ide_hwif_t
 static const struct ide_port_ops osb4_port_ops = {
 	.set_pio_mode		= svwks_set_pio_mode,
 	.set_dma_mode		= svwks_set_dma_mode,
-	.udma_filter		= svwks_udma_filter,
 };
 
 static const struct ide_port_ops svwks_port_ops = {
@@ -460,6 +442,6 @@ static void __exit svwks_ide_exit(void)
 module_init(svwks_ide_init);
 module_exit(svwks_ide_exit);
 
-MODULE_AUTHOR("Michael Aubry. Andrzej Krzysztofowicz, Andre Hedrick");
+MODULE_AUTHOR("Michael Aubry. Andrzej Krzysztofowicz, Andre Hedrick, Bartlomiej Zolnierkiewicz");
 MODULE_DESCRIPTION("PCI driver module for Serverworks OSB4/CSB5/CSB6 IDE");
 MODULE_LICENSE("GPL");
