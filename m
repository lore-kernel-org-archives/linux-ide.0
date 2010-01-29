From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 15/68] sis5513: use pata_sis.h
Date: Fri, 29 Jan 2010 17:04:46 +0100
Message-ID: <20100129160446.21495.53881.sendpatchset@localhost>
References: <20100129160308.21495.14120.sendpatchset@localhost>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.155]:44306 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753050Ab0A2QEy (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 29 Jan 2010 11:04:54 -0500
In-Reply-To: <20100129160308.21495.14120.sendpatchset@localhost>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] sis5513: use pata_sis.h

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/sis5513.c |   25 +++----------------------
 1 file changed, 3 insertions(+), 22 deletions(-)

Index: b/drivers/ide/sis5513.c
===================================================================
--- a/drivers/ide/sis5513.c
+++ b/drivers/ide/sis5513.c
@@ -506,34 +506,15 @@ static int init_chipset_sis5513(struct p
 	return 0;
 }
 
-struct sis_laptop {
-	u16 device;
-	u16 subvendor;
-	u16 subdevice;
-};
-
-static const struct sis_laptop sis_laptop[] = {
-	/* devid, subvendor, subdev */
-	{ 0x5513, 0x1043, 0x1107 },	/* ASUS A6K */
-	{ 0x5513, 0x1734, 0x105f },	/* FSC Amilo A1630 */
-	{ 0x5513, 0x1071, 0x8640 },     /* EasyNote K5305 */
-	/* end marker */
-	{ 0, }
-};
+#include "../ata/pata_sis.h"
 
 static u8 sis_cable_detect(ide_hwif_t *hwif)
 {
 	struct pci_dev *pdev = to_pci_dev(hwif->dev);
-	const struct sis_laptop *lap = &sis_laptop[0];
 	u8 ata66 = 0;
 
-	while (lap->device) {
-		if (lap->device == pdev->device &&
-		    lap->subvendor == pdev->subsystem_vendor &&
-		    lap->subdevice == pdev->subsystem_device)
-			return ATA_CBL_PATA40_SHORT;
-		lap++;
-	}
+	if (sis_short_ata40(pdev))
+		return ATA_CBL_PATA40_SHORT;
 
 	if (chipset_family >= ATA_133) {
 		u16 regw = 0;
