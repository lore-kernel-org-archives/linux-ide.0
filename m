From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 4/5] sis5513: backport short cables support from pata_sis.c
Date: Sun, 10 Jun 2007 15:58:33 +0200
Message-ID: <200706101558.33636.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.175]:29995 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754563AbXFJNpm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 10 Jun 2007 09:45:42 -0400
Received: by ug-out-1314.google.com with SMTP id j3so1282247ugf
        for <linux-ide@vger.kernel.org>; Sun, 10 Jun 2007 06:45:42 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org


Backport short cables support from pata_sis.c.

This patch should allow UDMA > 2 modes on ASUS A6K.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/pci/sis5513.c |   25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

Index: b/drivers/ide/pci/sis5513.c
===================================================================
--- a/drivers/ide/pci/sis5513.c
+++ b/drivers/ide/pci/sis5513.c
@@ -1,5 +1,5 @@
 /*
- * linux/drivers/ide/pci/sis5513.c	Version 0.20	Mar 4, 2007
+ * linux/drivers/ide/pci/sis5513.c	Version 0.25	Jun 10, 2007
  *
  * Copyright (C) 1999-2000	Andre Hedrick <andre@linux-ide.org>
  * Copyright (C) 2002		Lionel Bouton <Lionel.Bouton@inet6.fr>, Maintainer
@@ -796,10 +796,33 @@ static unsigned int __devinit init_chips
 	return 0;
 }
 
+struct sis_laptop {
+	u16 device;
+	u16 subvendor;
+	u16 subdevice;
+};
+
+static const struct sis_laptop sis_laptop[] = {
+	/* devid, subvendor, subdev */
+	{ 0x5513, 0x1043, 0x1107 },	/* ASUS A6K */
+	/* end marker */
+	{ 0, }
+};
+
 static u8 __devinit ata66_sis5513(ide_hwif_t *hwif)
 {
+	struct pci_dev *pdev = hwif->pci_dev;
+	const struct sis_laptop *lap = &sis_laptop[0];
 	u8 ata66 = 0;
 
+	while (lap->device) {
+		if (lap->device == pdev->device &&
+		    lap->subvendor == pdev->subsystem_vendor &&
+		    lap->subdevice == pdev->subsystem_device)
+			return ATA_CBL_PATA40_SHORT;
+		lap++;
+	}
+
 	if (chipset_family >= ATA_133) {
 		u16 regw = 0;
 		u16 reg_addr = hwif->channel ? 0x52: 0x50;
