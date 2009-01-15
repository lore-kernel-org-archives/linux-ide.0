From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 1/9] ide: remove stale comments from drive_is_ready()
Date: Thu, 15 Jan 2009 21:00:38 +0100
Message-ID: <20090115200038.17294.83145.sendpatchset@localhost.localdomain>
References: <20090115200032.17294.84745.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.27]:44426 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762965AbZAOUAZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 15 Jan 2009 15:00:25 -0500
In-Reply-To: <20090115200032.17294.84745.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ide: remove stale comments from drive_is_ready()

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-iops.c |    9 ---------
 1 file changed, 9 deletions(-)

Index: b/drivers/ide/ide-iops.c
===================================================================
--- a/drivers/ide/ide-iops.c
+++ b/drivers/ide/ide-iops.c
@@ -436,9 +436,6 @@ void ide_fixstring (u8 *s, const int byt
 
 EXPORT_SYMBOL(ide_fixstring);
 
-/*
- * Needed for PCI irq sharing
- */
 int drive_is_ready (ide_drive_t *drive)
 {
 	ide_hwif_t *hwif	= drive->hwif;
@@ -447,12 +444,6 @@ int drive_is_ready (ide_drive_t *drive)
 	if (drive->waiting_for_dma)
 		return hwif->dma_ops->dma_test_irq(drive);
 
-	/*
-	 * We do a passive status test under shared PCI interrupts on
-	 * cards that truly share the ATA side interrupt, but may also share
-	 * an interrupt with another pci card/device.  We make no assumptions
-	 * about possible isa-pnp and pci-pnp issues yet.
-	 */
 	if (hwif->io_ports.ctl_addr &&
 	    (hwif->host_flags & IDE_HFLAG_BROKEN_ALTSTATUS) == 0)
 		stat = hwif->tp_ops->read_altstatus(hwif);
