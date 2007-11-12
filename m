From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 3/13] ide: (hopefully) fix VDMA for CS5520
Date: Tue, 13 Nov 2007 00:01:28 +0100
Message-ID: <200711130001.28320.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.190]:11054 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757691AbXKLW6M (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 12 Nov 2007 17:58:12 -0500
Received: by fk-out-0910.google.com with SMTP id z23so1634397fkz
        for <linux-ide@vger.kernel.org>; Mon, 12 Nov 2007 14:58:11 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


* Set the correct hwif->dma_base for the second channel in
  ide_get_or_set_dma_base().

* Remove DMA enable code from cs5520_set_pio_mode(), this can
  be handled by the generic ->dma_host_on method now.

* Add VDMA check to ide_config_drive_speed().

* drive->using_dma was never enabled since cs5520 host driver's
  ->ide_dma_on method overrided the generic ->ide_dma_on (so
  __ide_dma_on() was never called, drive->using_dma was never set
  and VDMA was never used since it depends on drive->using_dma).

  Fix it by using ->dma_host_on method instead of ->ide_dma_on
  (also add matching ->dma_host_off method).

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-iops.c   |    2 +-
 drivers/ide/pci/cs5520.c |   29 +++++++++++++++++------------
 drivers/ide/setup-pci.c  |   10 +++++++---
 3 files changed, 25 insertions(+), 16 deletions(-)

Index: b/drivers/ide/ide-iops.c
===================================================================
--- a/drivers/ide/ide-iops.c
+++ b/drivers/ide/ide-iops.c
@@ -791,7 +791,7 @@ int ide_config_drive_speed(ide_drive_t *
 	drive->id->dma_1word &= ~0x0F00;
 
 #ifdef CONFIG_BLK_DEV_IDEDMA
-	if (speed >= XFER_SW_DMA_0)
+	if (speed >= XFER_SW_DMA_0 || (hwif->host_flags & IDE_HFLAG_VDMA))
 		hwif->dma_host_on(drive);
 	else if (hwif->ide_dma_on)	/* check if host supports DMA */
 		hwif->dma_off_quietly(drive);
Index: b/drivers/ide/pci/cs5520.c
===================================================================
--- a/drivers/ide/pci/cs5520.c
+++ b/drivers/ide/pci/cs5520.c
@@ -71,7 +71,6 @@ static void cs5520_set_pio_mode(ide_driv
 	ide_hwif_t *hwif = HWIF(drive);
 	struct pci_dev *pdev = hwif->pci_dev;
 	int controller = drive->dn > 1 ? 1 : 0;
-	u8 reg;
 
 	/* FIXME: if DMA = 1 do we need to set the DMA bit here ? */
 
@@ -91,11 +90,6 @@ static void cs5520_set_pio_mode(ide_driv
 	pci_write_config_byte(pdev, 0x66 + 4*controller + (drive->dn&1),
 		(cs5520_pio_clocks[pio].recovery << 4) |
 		(cs5520_pio_clocks[pio].assert));
-		
-	/* Set the DMA enable/disable flag */
-	reg = inb(hwif->dma_base + 0x02 + 8*controller);
-	reg |= 1<<((drive->dn&1)+5);
-	outb(reg, hwif->dma_base + 0x02 + 8*controller);
 }
 
 static void cs5520_set_dma_mode(ide_drive_t *drive, const u8 speed)
@@ -109,13 +103,23 @@ static void cs5520_set_dma_mode(ide_driv
  *	We wrap the DMA activate to set the vdma flag. This is needed
  *	so that the IDE DMA layer issues PIO not DMA commands over the
  *	DMA channel
+ *
+ *	ATAPI is harder so disable it for now using IDE_HFLAG_NO_ATAPI_DMA
  */
- 
-static int cs5520_dma_on(ide_drive_t *drive)
+
+static void cs5520_dma_host_on(ide_drive_t *drive)
 {
-	/* ATAPI is harder so leave it for now */
-	drive->vdma = 1;
-	return 0;
+	if (drive->using_dma)
+		drive->vdma = 1;
+
+	ide_dma_host_on(drive);
+}
+
+static void cs5520_dma_host_off(ide_drive_t *drive)
+{
+	drive->vdma = 0;
+
+	ide_dma_host_off(drive);
 }
 
 static void __devinit init_hwif_cs5520(ide_hwif_t *hwif)
@@ -126,7 +130,8 @@ static void __devinit init_hwif_cs5520(i
 	if (hwif->dma_base == 0)
 		return;
 
-	hwif->ide_dma_on = &cs5520_dma_on;
+	hwif->dma_host_on  = &cs5520_dma_host_on;
+	hwif->dma_host_off = &cs5520_dma_host_off;
 }
 
 #define DECLARE_CS_DEV(name_str)				\
Index: b/drivers/ide/setup-pci.c
===================================================================
--- a/drivers/ide/setup-pci.c
+++ b/drivers/ide/setup-pci.c
@@ -170,13 +170,17 @@ static unsigned long ide_get_or_set_dma_
 
 		dma_base = pci_resource_start(dev, baridx);
 
-		if (dma_base == 0)
+		if (dma_base == 0) {
 			printk(KERN_ERR "%s: DMA base is invalid\n", d->name);
+			return 0;
+		}
 	}
 
-	if ((d->host_flags & IDE_HFLAG_CS5520) == 0 && dma_base) {
+	if (hwif->channel)
+		dma_base += 8;
+
+	if ((d->host_flags & IDE_HFLAG_CS5520) == 0) {
 		u8 simplex_stat = 0;
-		dma_base += hwif->channel ? 8 : 0;
 
 		switch(dev->device) {
 			case PCI_DEVICE_ID_AL_M5219:
