From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 39/64] via82cxxx: vx855 is a single channel controller
Date: Mon, 18 Jan 2010 18:19:37 +0100
Message-ID: <20100118171937.14623.67352.sendpatchset@localhost>
References: <20100118171349.14623.90030.sendpatchset@localhost>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755272Ab0ARRUz@vger.kernel.org>
In-Reply-To: <20100118171349.14623.90030.sendpatchset@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] via82cxxx: vx855 is a single channel controller

Based on commit e4d866c for pata_via host driver
(PCI ID was later changed by commit 5993856).

Update my credits while at it.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/via82cxxx.c |   19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

Index: b/drivers/ide/via82cxxx.c
===================================================================
--- a/drivers/ide/via82cxxx.c
+++ b/drivers/ide/via82cxxx.c
@@ -6,7 +6,7 @@
  *   vt8235, vt8237, vt8237a
  *
  * Copyright (c) 2000-2002 Vojtech Pavlik
- * Copyright (c) 2007 Bartlomiej Zolnierkiewicz
+ * Copyright (c) 2007-2010 Bartlomiej Zolnierkiewicz
  *
  * Based on the work of:
  *	Michel Aubry
@@ -55,6 +55,10 @@
 #define VIA_BAD_ID		0x10 /* Has wrong vendor ID (0x1107) */
 #define VIA_BAD_AST		0x20 /* Don't touch Address Setup Timing */
 
+enum {
+	VIA_IDFLAG_SINGLE = (1 << 1), /* single channel controller */
+};
+
 /*
  * VIA SouthBridge chips.
  */
@@ -436,10 +440,13 @@ static int __devinit via_init_one(struct
 		via_clock = 33333;
 	}
 
-	if (idx == 0)
-		d.host_flags |= IDE_HFLAG_NO_AUTODMA;
-	else
+	if (idx == 1)
 		d.enablebits[1].reg = d.enablebits[0].reg = 0;
+	else
+		d.host_flags |= IDE_HFLAG_NO_AUTODMA;
+
+	if (idx == VIA_IDFLAG_SINGLE)
+		d.host_flags |= IDE_HFLAG_SINGLE;
 
 	if ((via_config->flags & VIA_NO_UNMASK) == 0)
 		d.host_flags |= IDE_HFLAG_UNMASK_IRQS;
@@ -475,7 +482,7 @@ static const struct pci_device_id via_pc
 	{ PCI_VDEVICE(VIA, PCI_DEVICE_ID_VIA_82C576_1),  0 },
 	{ PCI_VDEVICE(VIA, PCI_DEVICE_ID_VIA_82C586_1),  0 },
 	{ PCI_VDEVICE(VIA, PCI_DEVICE_ID_VIA_CX700_IDE), 0 },
-	{ PCI_VDEVICE(VIA, PCI_DEVICE_ID_VIA_VX855_IDE), 0 },
+	{ PCI_VDEVICE(VIA, PCI_DEVICE_ID_VIA_VX855_IDE), VIA_IDFLAG_SINGLE },
 	{ PCI_VDEVICE(VIA, PCI_DEVICE_ID_VIA_6410),      1 },
 	{ PCI_VDEVICE(VIA, PCI_DEVICE_ID_VIA_SATA_EIDE), 1 },
 	{ 0, },
@@ -504,6 +511,6 @@ static void __exit via_ide_exit(void)
 module_init(via_ide_init);
 module_exit(via_ide_exit);
 
-MODULE_AUTHOR("Vojtech Pavlik, Michel Aubry, Jeff Garzik, Andre Hedrick");
+MODULE_AUTHOR("Vojtech Pavlik, Bartlomiej Zolnierkiewicz, Michel Aubry, Jeff Garzik, Andre Hedrick");
 MODULE_DESCRIPTION("PCI driver module for VIA IDE");
 MODULE_LICENSE("GPL");
