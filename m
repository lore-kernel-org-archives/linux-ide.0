From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 3/3] ide: remove ide_hwif_release_regions()
Date: Thu, 28 Feb 2008 00:04:19 +0100
Message-ID: <200802280004.19218.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.169]:55154 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754436AbYB0WuT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 27 Feb 2008 17:50:19 -0500
Received: by ug-out-1314.google.com with SMTP id z38so1750ugc.16
        for <linux-ide@vger.kernel.org>; Wed, 27 Feb 2008 14:50:17 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

All host drivers using ide_unregister()/module_exit() have been fixed
to manage resources themselves so this function can be removed now.

There should be no functional changes caused by this patch.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide.c   |   25 -------------------------
 include/linux/ide.h |    1 -
 2 files changed, 26 deletions(-)

Index: b/drivers/ide/ide.c
===================================================================
--- a/drivers/ide/ide.c
+++ b/drivers/ide/ide.c
@@ -279,29 +279,6 @@ control_region_busy:
 	return -EBUSY;
 }
 
-/**
- *	ide_hwif_release_regions - free IDE resources
- *
- *	Note that we only release the standard ports,
- *	and do not even try to handle any extra ports
- *	allocated for weird IDE interface chipsets.
- *
- *	Note also that we don't yet handle mmio resources here. More
- *	importantly our caller should be doing this so we need to 
- *	restructure this as a helper function for drivers.
- */
-
-void ide_hwif_release_regions(ide_hwif_t *hwif)
-{
-	if (hwif->mmio)
-		return;
-
-	if (hwif->io_ports[IDE_CONTROL_OFFSET])
-		release_region(hwif->io_ports[IDE_CONTROL_OFFSET], 1);
-
-	release_region(hwif->io_ports[IDE_DATA_OFFSET], 8);
-}
-
 void ide_remove_port_from_hwgroup(ide_hwif_t *hwif)
 {
 	ide_hwgroup_t *hwgroup = hwif->hwgroup;
@@ -440,8 +417,6 @@ void ide_unregister(unsigned int index)
 	if (hwif->dma_base)
 		(void)ide_release_dma(hwif);
 
-	ide_hwif_release_regions(hwif);
-
 	/* restore hwif data to pristine status */
 	ide_init_port_data(hwif, index);
 
Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -1205,7 +1205,6 @@ static inline void ide_acpi_set_state(id
 
 void ide_remove_port_from_hwgroup(ide_hwif_t *);
 extern int ide_hwif_request_regions(ide_hwif_t *hwif);
-extern void ide_hwif_release_regions(ide_hwif_t* hwif);
 void ide_unregister(unsigned int);
 
 void ide_register_region(struct gendisk *);
