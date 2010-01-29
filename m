From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 12/68] pata_ali: move short cable handling to pata_ali.h
Date: Fri, 29 Jan 2010 17:04:27 +0100
Message-ID: <20100129160427.21495.26006.sendpatchset@localhost>
References: <20100129160308.21495.14120.sendpatchset@localhost>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753193Ab0A2QEk@vger.kernel.org>
In-Reply-To: <20100129160308.21495.14120.sendpatchset@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] pata_ali: move short cable handling to pata_ali.h

It is a generic code and can be shared between pata_ali & alim15x3 drivers.

Fix typo while at it ("Satelite" -> "Satellite").

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ata/pata_ali.c |   37 +------------------------------------
 drivers/ata/pata_ali.h |   40 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+), 36 deletions(-)

Index: b/drivers/ata/pata_ali.c
===================================================================
--- a/drivers/ata/pata_ali.c
+++ b/drivers/ata/pata_ali.c
@@ -32,7 +32,6 @@
 #include <linux/delay.h>
 #include <scsi/scsi_host.h>
 #include <linux/libata.h>
-#include <linux/dmi.h>
 
 #define DRV_NAME "pata_ali"
 #define DRV_VERSION "0.7.8"
@@ -43,41 +42,7 @@ MODULE_PARM_DESC(atapi_dma, "Enable ATAP
 
 static struct pci_dev *ali_isa_bridge;
 
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
-		.ident = "Toshiba Satelite S1800-814",
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
-	if (pdev->subsystem_vendor == 0x10CF && pdev->subsystem_device == 0x10AF)
-	   	return 1;
-	/* Mitac 8317 (Winbook-A) and relatives */
-	if (pdev->subsystem_vendor == 0x1071 && pdev->subsystem_device == 0x8317)
-		return 1;
-	/* Systems by DMI */
-	if (dmi_check_system(cable_dmi_table))
-		return 1;
-	return 0;
-}
+#include "pata_ali.h"
 
 /**
  *	ali_c2_cable_detect	-	cable detection
Index: b/drivers/ata/pata_ali.h
===================================================================
--- /dev/null
+++ b/drivers/ata/pata_ali.h
@@ -0,0 +1,40 @@
+
+#include <linux/dmi.h>
+
+/*
+ *	Cable special cases
+ */
+
+static const struct dmi_system_id cable_dmi_table[] = {
+	{
+		.ident = "HP Pavilion N5430",
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "Hewlett-Packard"),
+			DMI_MATCH(DMI_BOARD_VERSION, "OmniBook N32N-736"),
+		},
+	},
+	{
+		.ident = "Toshiba Satellite S1800-814",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "S1800-814"),
+		},
+	},
+	{ }
+};
+
+static int ali_cable_override(struct pci_dev *pdev)
+{
+	/* Fujitsu P2000 */
+	if (pdev->subsystem_vendor == 0x10CF &&
+	    pdev->subsystem_device == 0x10AF)
+		return 1;
+	/* Mitac 8317 (Winbook-A) and relatives */
+	if (pdev->subsystem_vendor == 0x1071 &&
+	    pdev->subsystem_device == 0x8317)
+		return 1;
+	/* Systems by DMI */
+	if (dmi_check_system(cable_dmi_table))
+		return 1;
+	return 0;
+}
