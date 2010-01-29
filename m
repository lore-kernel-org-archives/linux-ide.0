From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 13/68] alim15x3: use pata_ali.h
Date: Fri, 29 Jan 2010 17:04:34 +0100
Message-ID: <20100129160434.21495.56474.sendpatchset@localhost>
References: <20100129160308.21495.14120.sendpatchset@localhost>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753967Ab0A2QEr@vger.kernel.org>
In-Reply-To: <20100129160308.21495.14120.sendpatchset@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] alim15x3: use pata_ali.h

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/alim15x3.c |   42 +-----------------------------------------
 1 file changed, 1 insertion(+), 41 deletions(-)

Index: b/drivers/ide/alim15x3.c
===================================================================
--- a/drivers/ide/alim15x3.c
+++ b/drivers/ide/alim15x3.c
@@ -33,7 +33,6 @@
 #include <linux/pci.h>
 #include <linux/ide.h>
 #include <linux/init.h>
-#include <linux/dmi.h>
 
 #include <asm/io.h>
 
@@ -308,46 +307,7 @@ out:
 	return 0;
 }
 
-/*
- *	Cable special cases
- */
-
-static const struct dmi_system_id cable_dmi_table[] = {
-	{
-		.ident = "HP Pavilion N5430",
-		.matches = {
-			DMI_MATCH(DMI_BOARD_VENDOR, "Hewlett-Packard"),
-			DMI_MATCH(DMI_BOARD_VERSION, "OmniBook N32N-736"),
-		},
-	},
-	{
-		.ident = "Toshiba Satellite S1800-814",
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "S1800-814"),
-		},
-	},
-	{ }
-};
-
-static int ali_cable_override(struct pci_dev *pdev)
-{
-	/* Fujitsu P2000 */
-	if (pdev->subsystem_vendor == 0x10CF &&
-	    pdev->subsystem_device == 0x10AF)
-		return 1;
-
-	/* Mitac 8317 (Winbook-A) and relatives */
-	if (pdev->subsystem_vendor == 0x1071 &&
-	    pdev->subsystem_device == 0x8317)
-		return 1;
-
-	/* Systems by DMI */
-	if (dmi_check_system(cable_dmi_table))
-		return 1;
-
-	return 0;
-}
+#include "../ata/pata_ali.h"
 
 /**
  *	ali_cable_detect	-	cable detection
