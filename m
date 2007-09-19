From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 1/3] ide: add ide_find_port() helper
Date: Wed, 19 Sep 2007 22:09:40 +0200
Message-ID: <200709192209.40971.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.189]:40972 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751694AbXISUIc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 19 Sep 2007 16:08:32 -0400
Received: by nf-out-0910.google.com with SMTP id g13so272662nfb
        for <linux-ide@vger.kernel.org>; Wed, 19 Sep 2007 13:08:32 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


* Add ide_find_port() helper.

* Convert icside, rapide and ide_platform host drivers to use it.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/arm/icside.c          |   24 +-----------------------
 drivers/ide/arm/rapide.c          |   25 +++++--------------------
 drivers/ide/ide.c                 |   24 ++++++++++++++++++++++++
 drivers/ide/legacy/ide_platform.c |   25 ++++++-------------------
 include/linux/ide.h               |    2 ++
 5 files changed, 38 insertions(+), 62 deletions(-)

Index: b/drivers/ide/arm/icside.c
===================================================================
--- a/drivers/ide/arm/icside.c
+++ b/drivers/ide/arm/icside.c
@@ -438,35 +438,13 @@ static void icside_dma_init(ide_hwif_t *
 #define icside_dma_init(hwif)	(0)
 #endif
 
-static ide_hwif_t *icside_find_hwif(unsigned long dataport)
-{
-	ide_hwif_t *hwif;
-	int index;
-
-	for (index = 0; index < MAX_HWIFS; ++index) {
-		hwif = &ide_hwifs[index];
-		if (hwif->io_ports[IDE_DATA_OFFSET] == dataport)
-			goto found;
-	}
-
-	for (index = 0; index < MAX_HWIFS; ++index) {
-		hwif = &ide_hwifs[index];
-		if (!hwif->io_ports[IDE_DATA_OFFSET])
-			goto found;
-	}
-
-	hwif = NULL;
-found:
-	return hwif;
-}
-
 static ide_hwif_t *
 icside_setup(void __iomem *base, struct cardinfo *info, struct expansion_card *ec)
 {
 	unsigned long port = (unsigned long)base + info->dataoffset;
 	ide_hwif_t *hwif;
 
-	hwif = icside_find_hwif(port);
+	hwif = ide_find_port(port);
 	if (hwif) {
 		int i;
 
Index: b/drivers/ide/arm/rapide.c
===================================================================
--- a/drivers/ide/arm/rapide.c
+++ b/drivers/ide/arm/rapide.c
@@ -13,31 +13,16 @@
 
 #include <asm/ecard.h>
 
-/*
- * Something like this really should be in generic code, but isn't.
- */
 static ide_hwif_t *
 rapide_locate_hwif(void __iomem *base, void __iomem *ctrl, unsigned int sz, int irq)
 {
 	unsigned long port = (unsigned long)base;
-	ide_hwif_t *hwif;
-	int index, i;
-
-	for (index = 0; index < MAX_HWIFS; ++index) {
-		hwif = ide_hwifs + index;
-		if (hwif->io_ports[IDE_DATA_OFFSET] == port)
-			goto found;
-	}
+	ide_hwif_t *hwif = ide_find_port(port);
+	int i;
 
-	for (index = 0; index < MAX_HWIFS; ++index) {
-		hwif = ide_hwifs + index;
-		if (hwif->io_ports[IDE_DATA_OFFSET] == 0)
-			goto found;
-	}
-
-	return NULL;
+	if (hwif == NULL)
+		goto out;
 
- found:
 	for (i = IDE_DATA_OFFSET; i <= IDE_STATUS_OFFSET; i++) {
 		hwif->hw.io_ports[i] = port;
 		hwif->io_ports[i] = port;
@@ -48,7 +33,7 @@ rapide_locate_hwif(void __iomem *base, v
 	hwif->hw.irq = hwif->irq = irq;
 	hwif->mmio = 1;
 	default_hwif_mmiops(hwif);
-
+out:
 	return hwif;
 }
 
Index: b/drivers/ide/ide.c
===================================================================
--- a/drivers/ide/ide.c
+++ b/drivers/ide/ide.c
@@ -267,6 +267,30 @@ static int ide_system_bus_speed(void)
 	return system_bus_speed;
 }
 
+ide_hwif_t * ide_find_port(unsigned long base)
+{
+	ide_hwif_t *hwif;
+	int i;
+
+	for (i = 0; i < MAX_HWIFS; i++) {
+		hwif = &ide_hwifs[i];
+		if (hwif->io_ports[IDE_DATA_OFFSET] == base)
+			goto found;
+	}
+
+	for (i = 0; i < MAX_HWIFS; i++) {
+		hwif = &ide_hwifs[i];
+		if (hwif->io_ports[IDE_DATA_OFFSET] == 0)
+			goto found;
+	}
+
+	hwif = NULL;
+found:
+	return hwif;
+}
+
+EXPORT_SYMBOL_GPL(ide_find_port);
+
 static struct resource* hwif_request_region(ide_hwif_t *hwif,
 					    unsigned long addr, int num)
 {
Index: b/drivers/ide/legacy/ide_platform.c
===================================================================
--- a/drivers/ide/legacy/ide_platform.c
+++ b/drivers/ide/legacy/ide_platform.c
@@ -33,24 +33,11 @@ static ide_hwif_t *__devinit plat_ide_lo
 	    int mmio)
 {
 	unsigned long port = (unsigned long)base;
-	ide_hwif_t *hwif;
-	int index, i;
-
-	for (index = 0; index < MAX_HWIFS; ++index) {
-		hwif = ide_hwifs + index;
-		if (hwif->io_ports[IDE_DATA_OFFSET] == port)
-			goto found;
-	}
-
-	for (index = 0; index < MAX_HWIFS; ++index) {
-		hwif = ide_hwifs + index;
-		if (hwif->io_ports[IDE_DATA_OFFSET] == 0)
-			goto found;
-	}
+	ide_hwif_t *hwif = ide_find_port(port);
+	int i;
 
-	return NULL;
-
-found:
+	if (hwif == NULL)
+		goto out;
 
 	hwif->hw.io_ports[IDE_DATA_OFFSET] = port;
 
@@ -73,8 +60,8 @@ found:
 	}
 
 	hwif_prop.hwif = hwif;
-	hwif_prop.index = index;
-
+	hwif_prop.index = hwif->index;
+out:
 	return hwif;
 }
 
Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -223,6 +223,8 @@ typedef struct hw_regs_s {
 	struct device	*dev;
 } hw_regs_t;
 
+struct hwif_s * ide_find_port(unsigned long);
+
 int ide_register_hw(hw_regs_t *, void (*)(struct hwif_s *), int,
 		    struct hwif_s **);
 
