From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 6/6] ide: config_drive_for_dma() fixes
Date: Wed, 11 Jul 2007 02:09:11 +0200
Message-ID: <200707110209.11283.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.239]:5174 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754714AbXGJXwc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 10 Jul 2007 19:52:32 -0400
Received: by wr-out-0506.google.com with SMTP id i30so694381wra
        for <linux-ide@vger.kernel.org>; Tue, 10 Jul 2007 16:52:32 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


* Add DMA blacklist checking (->ide_dma_on check probably can go now).

* Add ->atapi_dma flag checking and remove no longer needed
  ns87415_ide_dma_check() from ns87415 host driver.

* Remove now needless __ide_dma_check() wrapper and symbol export.

* Check drive->autodma instead of hwif->autodma (there should be no changes in
  behavior as all users of config_drive_for_dma() set both ->autodma flags).

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-dma.c     |   26 ++++++++++----------------
 drivers/ide/pci/ns87415.c |    9 ---------
 include/linux/ide.h       |    1 -
 3 files changed, 10 insertions(+), 26 deletions(-)

Index: b/drivers/ide/ide-dma.c
===================================================================
--- a/drivers/ide/ide-dma.c
+++ b/drivers/ide/ide-dma.c
@@ -349,9 +349,17 @@ EXPORT_SYMBOL_GPL(ide_destroy_dmatable);
  
 static int config_drive_for_dma (ide_drive_t *drive)
 {
+	ide_hwif_t *hwif = drive->hwif;
 	struct hd_driveid *id = drive->id;
 
-	if ((id->capability & 1) && drive->hwif->autodma) {
+	/* consult the list of known "bad" drives */
+	if (__ide_dma_bad_drive(drive))
+		return -1;
+
+	if (drive->media != ide_disk && hwif->atapi_dma == 0)
+		return -1;
+
+	if ((id->capability & 1) && drive->autodma) {
 		/*
 		 * Enable DMA on any drive that has
 		 * UltraDMA (mode 0/1/2/3/4/5/6) enabled
@@ -514,20 +522,6 @@ int __ide_dma_on (ide_drive_t *drive)
 EXPORT_SYMBOL(__ide_dma_on);
 
 /**
- *	__ide_dma_check		-	check DMA setup
- *	@drive: drive to check
- *
- *	Don't use - due for extermination
- */
- 
-int __ide_dma_check (ide_drive_t *drive)
-{
-	return config_drive_for_dma(drive);
-}
-
-EXPORT_SYMBOL(__ide_dma_check);
-
-/**
  *	ide_dma_setup	-	begin a DMA phase
  *	@drive: target device
  *
@@ -1031,7 +1025,7 @@ void ide_setup_dma (ide_hwif_t *hwif, un
 	if (!hwif->dma_host_on)
 		hwif->dma_host_on = &ide_dma_host_on;
 	if (!hwif->ide_dma_check)
-		hwif->ide_dma_check = &__ide_dma_check;
+		hwif->ide_dma_check = &config_drive_for_dma;
 	if (!hwif->dma_setup)
 		hwif->dma_setup = &ide_dma_setup;
 	if (!hwif->dma_exec_cmd)
Index: b/drivers/ide/pci/ns87415.c
===================================================================
--- a/drivers/ide/pci/ns87415.c
+++ b/drivers/ide/pci/ns87415.c
@@ -187,14 +187,6 @@ static int ns87415_ide_dma_setup(ide_dri
 	return 1;
 }
 
-static int ns87415_ide_dma_check (ide_drive_t *drive)
-{
-	if (drive->media != ide_disk)
-		return -1;
-
-	return __ide_dma_check(drive);
-}
-
 static void __devinit init_hwif_ns87415 (ide_hwif_t *hwif)
 {
 	struct pci_dev *dev = hwif->pci_dev;
@@ -266,7 +258,6 @@ static void __devinit init_hwif_ns87415 
 
 	outb(0x60, hwif->dma_status);
 	hwif->dma_setup = &ns87415_ide_dma_setup;
-	hwif->ide_dma_check = &ns87415_ide_dma_check;
 	hwif->ide_dma_end = &ns87415_ide_dma_end;
 
 	if (!noautodma)
Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -1325,7 +1325,6 @@ void ide_dma_host_off(ide_drive_t *);
 void ide_dma_off_quietly(ide_drive_t *);
 void ide_dma_host_on(ide_drive_t *);
 extern int __ide_dma_on(ide_drive_t *);
-extern int __ide_dma_check(ide_drive_t *);
 extern int ide_dma_setup(ide_drive_t *);
 extern void ide_dma_start(ide_drive_t *);
 extern int __ide_dma_end(ide_drive_t *);
