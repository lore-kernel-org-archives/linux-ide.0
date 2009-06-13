From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 2/3] ide: IORDY handling fixes
Date: Sat, 13 Jun 2009 18:22:22 +0200
Message-ID: <200906131822.22343.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f213.google.com ([209.85.218.213]:36874 "EHLO
	mail-bw0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755912AbZFMQd0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 13 Jun 2009 12:33:26 -0400
Received: by bwz9 with SMTP id 9so2594785bwz.37
        for <linux-ide@vger.kernel.org>; Sat, 13 Jun 2009 09:33:27 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Add ide_pio_need_iordy() helper and convert host drivers to use it.

This fixes it8172, it8213, pdc202xx_old, piix, slc90e66 and siimage
host drivers to handle IORDY correctly.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/at91_ide.c      |    3 +--
 drivers/ide/ide-xfer-mode.c |    6 ++++++
 drivers/ide/it8172.c        |    2 +-
 drivers/ide/it8213.c        |    2 +-
 drivers/ide/pdc202xx_old.c  |    2 +-
 drivers/ide/piix.c          |    2 +-
 drivers/ide/siimage.c       |   15 ++++++++-------
 drivers/ide/sl82c105.c      |    3 +--
 drivers/ide/slc90e66.c      |    2 +-
 include/linux/ide.h         |    1 +
 10 files changed, 22 insertions(+), 16 deletions(-)

Index: b/drivers/ide/at91_ide.c
===================================================================
--- a/drivers/ide/at91_ide.c
+++ b/drivers/ide/at91_ide.c
@@ -185,8 +185,7 @@ static void at91_ide_set_pio_mode(ide_dr
 	timing = ide_timing_find_mode(XFER_PIO_0 + pio);
 	BUG_ON(!timing);
 
-	if ((pio > 2 || ata_id_has_iordy(drive->id)) &&
-	    !(ata_id_is_cfa(drive->id) && pio > 4))
+	if (ide_pio_need_iordy(drive, pio))
 		use_iordy = 1;
 
 	apply_timings(chipselect, pio, timing, use_iordy);
Index: b/drivers/ide/ide-xfer-mode.c
===================================================================
--- a/drivers/ide/ide-xfer-mode.c
+++ b/drivers/ide/ide-xfer-mode.c
@@ -107,6 +107,12 @@ u8 ide_get_best_pio_mode(ide_drive_t *dr
 }
 EXPORT_SYMBOL_GPL(ide_get_best_pio_mode);
 
+int ide_pio_need_iordy(ide_drive_t *drive, const u8 pio)
+{
+	return ata_id_pio_need_iordy(drive->id, pio);
+}
+EXPORT_SYMBOL_GPL(ide_pio_need_iordy);
+
 int ide_set_pio_mode(ide_drive_t *drive, const u8 mode)
 {
 	ide_hwif_t *hwif = drive->hwif;
Index: b/drivers/ide/it8172.c
===================================================================
--- a/drivers/ide/it8172.c
+++ b/drivers/ide/it8172.c
@@ -66,7 +66,7 @@ static void it8172_set_pio_mode(ide_driv
 	if (drive->media == ide_disk)
 		/* enable prefetch */
 		drive_enables |= 0x0004 << (drive->dn * 4);
-	if (ata_id_has_iordy(drive->id))
+	if (ide_pio_need_iordy(drive, pio))
 		/* enable IORDY sample-point */
 		drive_enables |= 0x0002 << (drive->dn * 4);
 
Index: b/drivers/ide/it8213.c
===================================================================
--- a/drivers/ide/it8213.c
+++ b/drivers/ide/it8213.c
@@ -50,7 +50,7 @@ static void it8213_set_pio_mode(ide_driv
 		control |= 1;	/* Programmable timing on */
 	if (drive->media != ide_disk)
 		control |= 4;	/* ATAPI */
-	if (pio > 2)
+	if (ide_pio_need_iordy(drive, pio))
 		control |= 2;	/* IORDY */
 	if (is_slave) {
 		master_data |=  0x4000;
Index: b/drivers/ide/pdc202xx_old.c
===================================================================
--- a/drivers/ide/pdc202xx_old.c
+++ b/drivers/ide/pdc202xx_old.c
@@ -73,7 +73,7 @@ static void pdc202xx_set_mode(ide_drive_
 		 * Prefetch_EN / IORDY_EN / PA[3:0] bits of register A
 		 */
 		AP &= ~0x3f;
-		if (ata_id_iordy_disable(drive->id))
+		if (ide_pio_need_iordy(drive, speed - XFER_PIO_0))
 			AP |= 0x20;	/* set IORDY_EN bit */
 		if (drive->media == ide_disk)
 			AP |= 0x10;	/* set Prefetch_EN bit */
Index: b/drivers/ide/piix.c
===================================================================
--- a/drivers/ide/piix.c
+++ b/drivers/ide/piix.c
@@ -98,7 +98,7 @@ static void piix_set_pio_mode(ide_drive_
 		control |= 1;	/* Programmable timing on */
 	if (drive->media == ide_disk)
 		control |= 4;	/* Prefetch, post write */
-	if (pio > 2)
+	if (ide_pio_need_iordy(drive, pio))
 		control |= 2;	/* IORDY */
 	if (is_slave) {
 		master_data |=  0x4000;
Index: b/drivers/ide/siimage.c
===================================================================
--- a/drivers/ide/siimage.c
+++ b/drivers/ide/siimage.c
@@ -32,7 +32,6 @@
  *  smarter code in libata.
  *
  * TODO:
- * - IORDY fixes
  * - VDMA support
  */
 
@@ -234,8 +233,7 @@ static u8 sil_sata_udma_filter(ide_drive
  *	@pio: PIO mode number
  *
  *	Load the timing settings for this device mode into the
- *	controller. If we are in PIO mode 3 or 4 turn on IORDY
- *	monitoring (bit 9). The TF timing is bits 31:16
+ *	controller.
  */
 
 static void sil_set_pio_mode(ide_drive_t *drive, u8 pio)
@@ -276,13 +274,16 @@ static void sil_set_pio_mode(ide_drive_t
 	/* now set up IORDY */
 	speedp = sil_ioread16(dev, tfaddr - 2);
 	speedp &= ~0x200;
-	if (pio > 2)
-		speedp |= 0x200;
-	sil_iowrite16(dev, speedp, tfaddr - 2);
 
 	mode = sil_ioread8(dev, base + addr_mask);
 	mode &= ~(unit ? 0x30 : 0x03);
-	mode |= unit ? 0x10 : 0x01;
+
+	if (ide_pio_need_iordy(drive, pio)) {
+		speedp |= 0x200;
+		mode |= unit ? 0x10 : 0x01;
+	}
+
+	sil_iowrite16(dev, speedp, tfaddr - 2);
 	sil_iowrite8(dev, mode, base + addr_mask);
 }
 
Index: b/drivers/ide/sl82c105.c
===================================================================
--- a/drivers/ide/sl82c105.c
+++ b/drivers/ide/sl82c105.c
@@ -61,8 +61,7 @@ static unsigned int get_pio_timings(ide_
 	if (cmd_off == 0)
 		cmd_off = 1;
 
-	if ((pio > 2 || ata_id_has_iordy(drive->id)) &&
-	    !(pio > 4 && ata_id_is_cfa(drive->id)))
+	if (ide_pio_need_iordy(drive, pio))
 		iordy = 0x40;
 
 	return (cmd_on - 1) << 8 | (cmd_off - 1) | iordy;
Index: b/drivers/ide/slc90e66.c
===================================================================
--- a/drivers/ide/slc90e66.c
+++ b/drivers/ide/slc90e66.c
@@ -44,7 +44,7 @@ static void slc90e66_set_pio_mode(ide_dr
 		control |= 1;	/* Programmable timing on */
 	if (drive->media == ide_disk)
 		control |= 4;	/* Prefetch, post write */
-	if (pio > 2)
+	if (ide_pio_need_iordy(drive, pio))
 		control |= 2;	/* IORDY */
 	if (is_slave) {
 		master_data |=  0x4000;
Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -1524,6 +1524,7 @@ int ide_timing_compute(ide_drive_t *, u8
 int ide_scan_pio_blacklist(char *);
 const char *ide_xfer_verbose(u8);
 u8 ide_get_best_pio_mode(ide_drive_t *, u8, u8);
+int ide_pio_need_iordy(ide_drive_t *, const u8);
 int ide_set_pio_mode(ide_drive_t *, u8);
 int ide_set_dma_mode(ide_drive_t *, u8);
 void ide_set_pio(ide_drive_t *, u8);
