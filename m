From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 4/6] siimage: separate PATA and SATA methods
Date: Mon, 17 Sep 2007 22:08:46 +0200
Message-ID: <200709172208.46787.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.186]:4885 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756263AbXIQUIY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 17 Sep 2007 16:08:24 -0400
Received: by nf-out-0910.google.com with SMTP id g13so1242555nfb
        for <linux-ide@vger.kernel.org>; Mon, 17 Sep 2007 13:08:22 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


* Split off sil_sata_udma_filter() from sil_udma_filter()
  and rename sil_udma_filter() to sil_pata_udma_filter().

* Rename siimage_busproc() to sil_sata_busproc().

* Rename siimage_reset_poll() to sil_sata_reset_poll()
  and in init_hwif_siimage() set ->reset_poll method only
  for SATA controllers.

* Rename siimage_pre_reset() to sil_sata_pre_reset(),
  in init_hwif_siimage() set ->pre_reset method only for
  SATA controllers and remove redundant is_sata() call.

* Add CONFIG_BLK_DEV_IDE_SATA #ifdef/#endif to pdev_is_sata()
  so compiler will know to throw out unused SATA code for
  CONFIG_BLK_DEV_IDE_SATA=n case (830 bytes saved on x86-32).

* Bump driver version.

Some minor cleanups while at it:

* Convert sil_{pata,sata}_udma_filter() to use ATA_UDMA* defines.

* In siimage_mmio_ide_dma_test_irq() move 'base' variable
  under 'if (SATA_ERROR_REG)' block.

* Simplify sil_sata_reset_poll() a bit.

* Cache is_sata() result in init_hwif_siimage() 

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/pci/siimage.c |   79 ++++++++++++++++++++++------------------------
 1 file changed, 39 insertions(+), 40 deletions(-)

Index: b/drivers/ide/pci/siimage.c
===================================================================
--- a/drivers/ide/pci/siimage.c
+++ b/drivers/ide/pci/siimage.c
@@ -1,5 +1,5 @@
 /*
- * linux/drivers/ide/pci/siimage.c		Version 1.16	Jul 13 2007
+ * linux/drivers/ide/pci/siimage.c		Version 1.17	Sep 15 2007
  *
  * Copyright (C) 2001-2002	Andre Hedrick <andre@linux-ide.org>
  * Copyright (C) 2003		Red Hat <alan@redhat.com>
@@ -57,8 +57,8 @@
  
 static int pdev_is_sata(struct pci_dev *pdev)
 {
-	switch(pdev->device)
-	{
+#ifdef CONFIG_BLK_DEV_IDE_SATA
+	switch(pdev->device) {
 		case PCI_DEVICE_ID_SII_3112:
 		case PCI_DEVICE_ID_SII_1210SA:
 			return 1;
@@ -66,9 +66,10 @@ static int pdev_is_sata(struct pci_dev *
 			return 0;
 	}
 	BUG();
+#endif
 	return 0;
 }
- 
+
 /**
  *	is_sata			-	check if hwif is SATA
  *	@hwif:	interface to check
@@ -136,7 +137,7 @@ static inline unsigned long siimage_seld
  *	SI3112 SATA controller life is a bit simpler.
  */
 
-static u8 sil_udma_filter(ide_drive_t *drive)
+static u8 sil_pata_udma_filter(ide_drive_t *drive)
 {
 	ide_hwif_t *hwif = drive->hwif;
 	unsigned long base = (unsigned long) hwif->hwif_data;
@@ -147,23 +148,23 @@ static u8 sil_udma_filter(ide_drive_t *d
 	else
 		pci_read_config_byte(hwif->pci_dev, 0x8A, &scsc);
 
-	if (is_sata(hwif)) {
-		mask = strstr(drive->id->model, "Maxtor") ? 0x3f : 0x7f;
-		goto out;
-	}
-
 	if ((scsc & 0x30) == 0x10)	/* 133 */
-		mask = 0x7f;
+		mask = ATA_UDMA6;
 	else if ((scsc & 0x30) == 0x20)	/* 2xPCI */
-		mask = 0x7f;
+		mask = ATA_UDMA6;
 	else if ((scsc & 0x30) == 0x00)	/* 100 */
-		mask = 0x3f;
+		mask = ATA_UDMA5;
 	else 	/* Disabled ? */
 		BUG();
-out:
+
 	return mask;
 }
 
+static u8 sil_sata_udma_filter(ide_drive_t *drive)
+{
+	return strstr(drive->id->model, "Maxtor") ? ATA_UDMA5 : ATA_UDMA6;
+}
+
 /**
  *	sil_set_pio_mode	-	set host controller for PIO mode
  *	@drive: drive
@@ -340,10 +341,11 @@ static int siimage_io_ide_dma_test_irq (
 static int siimage_mmio_ide_dma_test_irq (ide_drive_t *drive)
 {
 	ide_hwif_t *hwif	= HWIF(drive);
-	unsigned long base	= (unsigned long)hwif->hwif_data;
 	unsigned long addr	= siimage_selreg(hwif, 0x1);
 
 	if (SATA_ERROR_REG) {
+		unsigned long base = (unsigned long)hwif->hwif_data;
+
 		u32 ext_stat = readl((void __iomem *)(base + 0x10));
 		u8 watchdog = 0;
 		if (ext_stat & ((hwif->channel) ? 0x40 : 0x10)) {
@@ -376,7 +378,7 @@ static int siimage_mmio_ide_dma_test_irq
 }
 
 /**
- *	siimage_busproc		-	bus isolation ioctl
+ *	sil_sata_busproc	-	bus isolation IOCTL
  *	@drive: drive to isolate/restore
  *	@state: bus state to set
  *
@@ -384,8 +386,8 @@ static int siimage_mmio_ide_dma_test_irq
  *	SATA controller the work required is quite limited, we 
  *	just have to clean up the statistics
  */
- 
-static int siimage_busproc (ide_drive_t * drive, int state)
+
+static int sil_sata_busproc(ide_drive_t * drive, int state)
 {
 	ide_hwif_t *hwif	= HWIF(drive);
 	u32 stat_config		= 0;
@@ -417,14 +419,14 @@ static int siimage_busproc (ide_drive_t 
 }
 
 /**
- *	siimage_reset_poll	-	wait for sata reset
+ *	sil_sata_reset_poll	-	wait for SATA reset
  *	@drive: drive we are resetting
  *
  *	Poll the SATA phy and see whether it has come back from the dead
  *	yet.
  */
- 
-static int siimage_reset_poll (ide_drive_t *drive)
+
+static int sil_sata_reset_poll(ide_drive_t *drive)
 {
 	if (SATA_STATUS_REG) {
 		ide_hwif_t *hwif	= HWIF(drive);
@@ -436,27 +438,22 @@ static int siimage_reset_poll (ide_drive
 			HWGROUP(drive)->polling = 0;
 			return ide_started;
 		}
-		return 0;
-	} else {
-		return 0;
 	}
+
+	return 0;
 }
 
 /**
- *	siimage_pre_reset	-	reset hook
+ *	sil_sata_pre_reset	-	reset hook
  *	@drive: IDE device being reset
  *
  *	For the SATA devices we need to handle recalibration/geometry
  *	differently
  */
- 
-static void siimage_pre_reset (ide_drive_t *drive)
-{
-	if (drive->media != ide_disk)
-		return;
 
-	if (is_sata(HWIF(drive)))
-	{
+static void sil_sata_pre_reset(ide_drive_t *drive)
+{
+	if (drive->media == ide_disk) {
 		drive->special.b.set_geometry = 0;
 		drive->special.b.recalibrate = 0;
 	}
@@ -502,7 +499,6 @@ static void siimage_reset (ide_drive_t *
 			drive->failures++;
 		}
 	}
-
 }
 
 /**
@@ -864,28 +860,31 @@ static u8 __devinit ata66_siimage(ide_hw
 
 static void __devinit init_hwif_siimage(ide_hwif_t *hwif)
 {
+	u8 sata = is_sata(hwif);
+
 	hwif->resetproc = &siimage_reset;
 	hwif->set_pio_mode = &sil_set_pio_mode;
 	hwif->set_dma_mode = &sil_set_dma_mode;
-	hwif->reset_poll = &siimage_reset_poll;
-	hwif->pre_reset = &siimage_pre_reset;
-	hwif->udma_filter = &sil_udma_filter;
 
-	if(is_sata(hwif)) {
+	if (sata) {
 		static int first = 1;
 
-		hwif->busproc   = &siimage_busproc;
+		hwif->busproc = &sil_sata_busproc;
+		hwif->reset_poll = &sil_sata_reset_poll;
+		hwif->pre_reset = &sil_sata_pre_reset;
+		hwif->udma_filter = &sil_sata_udma_filter;
 
 		if (first) {
 			printk(KERN_INFO "siimage: For full SATA support you should use the libata sata_sil module.\n");
 			first = 0;
 		}
-	}
+	} else
+		hwif->udma_filter = &sil_pata_udma_filter;
 
 	if (hwif->dma_base == 0)
 		return;
 
-	if (is_sata(hwif))
+	if (sata)
 		hwif->host_flags |= IDE_HFLAG_NO_ATAPI_DMA;
 
 	if (hwif->cbl != ATA_CBL_PATA40_SHORT)
