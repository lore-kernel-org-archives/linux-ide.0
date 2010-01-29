From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 17/68] via82cxxx: use pata_via.h
Date: Fri, 29 Jan 2010 17:04:59 +0100
Message-ID: <20100129160459.21495.85998.sendpatchset@localhost>
References: <20100129160308.21495.14120.sendpatchset@localhost>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754064Ab0A2QFT@vger.kernel.org>
In-Reply-To: <20100129160308.21495.14120.sendpatchset@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] via82cxxx: use pata_via.h

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/via82cxxx.c |   30 +-----------------------------
 1 file changed, 1 insertion(+), 29 deletions(-)

Index: b/drivers/ide/via82cxxx.c
===================================================================
--- a/drivers/ide/via82cxxx.c
+++ b/drivers/ide/via82cxxx.c
@@ -29,7 +29,6 @@
 #include <linux/pci.h>
 #include <linux/init.h>
 #include <linux/ide.h>
-#include <linux/dmi.h>
 
 #ifdef CONFIG_PPC_CHRP
 #include <asm/processor.h>
@@ -351,34 +350,7 @@ static int init_chipset_via82cxxx(struct
 	return 0;
 }
 
-/*
- *	Cable special cases
- */
-
-static const struct dmi_system_id cable_dmi_table[] = {
-	{
-		.ident = "Acer Ferrari 3400",
-		.matches = {
-			DMI_MATCH(DMI_BOARD_VENDOR, "Acer,Inc."),
-			DMI_MATCH(DMI_BOARD_NAME, "Ferrari 3400"),
-		},
-	},
-	{ }
-};
-
-static int via_cable_override(struct pci_dev *pdev)
-{
-	/* Systems by DMI */
-	if (dmi_check_system(cable_dmi_table))
-		return 1;
-
-	/* Arima W730-K8/Targa Visionary 811/... */
-	if (pdev->subsystem_vendor == 0x161F &&
-	    pdev->subsystem_device == 0x2032)
-		return 1;
-
-	return 0;
-}
+#include "../ata/pata_via.h"
 
 static u8 via82cxxx_cable_detect(ide_hwif_t *hwif)
 {
