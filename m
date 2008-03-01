From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 8/9] ide: remove ide_hwif_request_regions()
Date: Sat, 1 Mar 2008 21:53:33 +0100
Message-ID: <200803012153.34093.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.175]:27722 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759985AbYCAUnm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 1 Mar 2008 15:43:42 -0500
Received: by ug-out-1314.google.com with SMTP id z38so1035350ugc.16
        for <linux-ide@vger.kernel.org>; Sat, 01 Mar 2008 12:43:42 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Remove no longer used ide_hwif_request_regions() and hwif_request_region().

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide.c   |   50 --------------------------------------------------
 include/linux/ide.h |    1 -
 2 files changed, 51 deletions(-)

Index: b/drivers/ide/ide.c
===================================================================
--- a/drivers/ide/ide.c
+++ b/drivers/ide/ide.c
@@ -229,56 +229,6 @@ static int ide_system_bus_speed(void)
 	return pci_dev_present(pci_default) ? 33 : 50;
 }
 
-static struct resource* hwif_request_region(ide_hwif_t *hwif,
-					    unsigned long addr, int num)
-{
-	struct resource *res = request_region(addr, num, hwif->name);
-
-	if (!res)
-		printk(KERN_ERR "%s: I/O resource 0x%lX-0x%lX not free.\n",
-				hwif->name, addr, addr+num-1);
-	return res;
-}
-
-/**
- *	ide_hwif_request_regions - request resources for IDE
- *	@hwif: interface to use
- *
- *	Requests all the needed resources for an interface.
- *	Right now core IDE code does this work which is deeply wrong.
- *	MMIO leaves it to the controller driver,
- *	PIO will migrate this way over time.
- */
-
-int ide_hwif_request_regions(ide_hwif_t *hwif)
-{
-	unsigned long addr;
-
-	if (hwif->mmio)
-		return 0;
-
-	addr = hwif->io_ports[IDE_CONTROL_OFFSET];
-
-	if (addr && !hwif_request_region(hwif, addr, 1))
-		goto control_region_busy;
-
-	addr = hwif->io_ports[IDE_DATA_OFFSET];
-	BUG_ON((addr | 7) != hwif->io_ports[IDE_STATUS_OFFSET]);
-
-	if (!hwif_request_region(hwif, addr, 8))
-		goto data_region_busy;
-
-	return 0;
-
-data_region_busy:
-	addr = hwif->io_ports[IDE_CONTROL_OFFSET];
-	if (addr)
-		release_region(addr, 1);
-control_region_busy:
-	/* If any errors are return, we drop the hwif interface. */
-	return -EBUSY;
-}
-
 void ide_remove_port_from_hwgroup(ide_hwif_t *hwif)
 {
 	ide_hwgroup_t *hwgroup = hwif->hwgroup;
Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -1204,7 +1204,6 @@ static inline void ide_acpi_set_state(id
 #endif
 
 void ide_remove_port_from_hwgroup(ide_hwif_t *);
-extern int ide_hwif_request_regions(ide_hwif_t *hwif);
 void ide_unregister(unsigned int);
 
 void ide_register_region(struct gendisk *);
