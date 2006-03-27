From: "Tobias Oed" <tobiasoed@hotmail.com>
Subject: [PATCH]: Allow atapi dma with pdc202xx_old
Date: Mon, 27 Mar 2006 08:25:18 -0500
Message-ID: <BAY105-F3145ACB23DF123E7AFF118A3D20@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bay105-f31.bay105.hotmail.com ([65.54.224.41]:53843 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S1750734AbWC0NZV
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 27 Mar 2006 08:25:21 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: tobiasoed@hotmail.com

Hello,
I need the following patch to get atapi dma to work with my on board
promise pdc20265 controller. It works for udma but not mdma.
Comment?
Tobias

--- drivers/ide/pci/pdc202xx_old.c.orig	2006-03-16 00:44:01.000000000 +0100
+++ drivers/ide/pci/pdc202xx_old.c	2006-03-27 14:42:32.000000000 +0200
@@ -181,7 +181,7 @@
	u8			TA = 0, TB = 0, TC = 0;

	if ((drive->media != ide_disk) && (speed < XFER_SW_DMA_0))
-		return -1;
+		//return -1;

	pci_read_config_dword(dev, drive_pci, &drive_conf);
	pci_read_config_byte(dev, (drive_pci), &AP);
@@ -270,12 +270,14 @@
  */
static void config_chipset_for_pio (ide_drive_t *drive, u8 pio)
{
+	ide_hwif_t *hwif	= HWIF(drive);
	u8 speed = 0;

-	if (pio == 5) pio = 4;
+	if (pio == 5)
+                pio = 4;
	speed = XFER_PIO_0 + ide_get_best_pio_mode(drive, 255, pio, NULL);

-	pdc202xx_tune_chipset(drive, speed);
+	hwif->speedproc(drive, speed);
}

static u8 pdc202xx_old_cable_detect (ide_hwif_t *hwif)
@@ -356,21 +358,21 @@

chipset_is_set:

-	if (drive->media == ide_disk) {
-		pci_read_config_byte(dev, (drive_pci), &AP);
-		if (id->capability & 4)	/* IORDY_EN */
-			pci_write_config_byte(dev, (drive_pci), AP|IORDY_EN);
-		pci_read_config_byte(dev, (drive_pci), &AP);
-		if (drive->media == ide_disk)	/* PREFETCH_EN */
-			pci_write_config_byte(dev, (drive_pci), AP|PREFETCH_EN);
-	}
+	pci_read_config_byte(dev, (drive_pci), &AP);
+	if (id->capability & 4) {	/* IORDY_EN */
+		printk(KERN_ERR "TOBIAS: %s IORDY_EN\n", drive->name);
+                pci_write_config_byte(dev, (drive_pci), AP|IORDY_EN);
+        }
+	pci_read_config_byte(dev, (drive_pci), &AP);
+	if (drive->media == ide_disk)	/* PREFETCH_EN */
+		pci_write_config_byte(dev, (drive_pci), AP|PREFETCH_EN);

	speed = ide_dma_speed(drive, pdc202xx_ratemask(drive));

	if (!(speed)) {
		/* restore original pci-config space */
		pci_write_config_dword(dev, drive_pci, drive_conf);
-		hwif->tuneproc(drive, 5);
+		//hwif->tuneproc(drive, 5); /* pdc202xx_config_drive_xfer_rate will do 
this */
		return 0;
	}

@@ -412,12 +414,20 @@
{
	if (drive->current_speed > XFER_UDMA_2)
		pdc_old_enable_66MHz_clock(drive->hwif);
-	if (drive->addressing == 1) {
+	if (drive->media != ide_disk || drive->addressing == 1) {
		struct request *rq	= HWGROUP(drive)->rq;
		ide_hwif_t *hwif	= HWIF(drive);
//		struct pci_dev *dev	= hwif->pci_dev;
-//		unsgned long high_16	= pci_resource_start(dev, 4);
-		unsigned long high_16   = hwif->dma_master;
+//		unsigned long high_16	= pci_resource_start(dev, 4);
+//		unsigned long high_16   = hwif->dma_master;
+
+#ifdef CONFIG_BLK_DEV_IDEDMA
+//	unsigned long high_16	= hwif->dma_base - (8*(hwif->channel));
+	unsigned long high_16	= hwif->dma_master;
+#else /* !CONFIG_BLK_DEV_IDEDMA */
+	unsigned long high_16	= pci_resource_start(hwif->pci_dev, 4);
+#endif /* CONFIG_BLK_DEV_IDEDMA */
+
		unsigned long atapi_reg	= high_16 + (hwif->channel ? 0x24 : 0x20);
		u32 word_count	= 0;
		u8 clock = hwif->INB(high_16 + 0x11);
@@ -434,10 +444,18 @@

static int pdc202xx_old_ide_dma_end(ide_drive_t *drive)
{
-	if (drive->addressing == 1) {
+	if (drive->media != ide_disk || drive->addressing == 1) {
		ide_hwif_t *hwif	= HWIF(drive);
//		unsigned long high_16	= pci_resource_start(hwif->pci_dev, 4);
-		unsigned long high_16	= hwif->dma_master;
+//		unsigned long high_16	= hwif->dma_master;
+
+#ifdef CONFIG_BLK_DEV_IDEDMA
+//	unsigned long high_16	= hwif->dma_base - (8*(hwif->channel));
+	unsigned long high_16	= hwif->dma_master;
+#else /* !CONFIG_BLK_DEV_IDEDMA */
+	unsigned long high_16	= pci_resource_start(hwif->pci_dev, 4);
+#endif /* CONFIG_BLK_DEV_IDEDMA */
+
		unsigned long atapi_reg	= high_16 + (hwif->channel ? 0x24 : 0x20);
		u8 clock		= 0;

@@ -455,7 +473,15 @@
	ide_hwif_t *hwif	= HWIF(drive);
//	struct pci_dev *dev	= hwif->pci_dev;
//	unsigned long high_16	= pci_resource_start(dev, 4);
+//	unsigned long high_16	= hwif->dma_master;
+
+#ifdef CONFIG_BLK_DEV_IDEDMA
+//	unsigned long high_16	= hwif->dma_base - (8*(hwif->channel));
	unsigned long high_16	= hwif->dma_master;
+#else /* !CONFIG_BLK_DEV_IDEDMA */
+	unsigned long high_16	= pci_resource_start(hwif->pci_dev, 4);
+#endif /* CONFIG_BLK_DEV_IDEDMA */
+
	u8 dma_stat		= hwif->INB(hwif->dma_status);
	u8 sc1d			= hwif->INB((high_16 + 0x001d));

@@ -559,7 +585,15 @@
{
	ide_hwif_t *hwif	= HWIF(drive);
//	unsigned long high_16	= hwif->dma_base - (8*(hwif->channel));
+//	unsigned long high_16	= hwif->dma_master;
+
+#ifdef CONFIG_BLK_DEV_IDEDMA
+//	unsigned long high_16	= hwif->dma_base - (8*(hwif->channel));
	unsigned long high_16	= hwif->dma_master;
+#else /* !CONFIG_BLK_DEV_IDEDMA */
+	unsigned long high_16	= pci_resource_start(hwif->pci_dev, 4);
+#endif /* CONFIG_BLK_DEV_IDEDMA */
+
	u8 sc1f			= hwif->INB(high_16|0x001f);

	if (!hwif)
@@ -636,6 +670,7 @@
	hwif->ultra_mask = 0x3f;
	hwif->mwdma_mask = 0x07;
	hwif->swdma_mask = 0x07;
+        hwif->atapi_dma = 1;

	hwif->ide_dma_check = &pdc202xx_config_drive_xfer_rate;
	hwif->ide_dma_lostirq = &pdc202xx_ide_dma_lostirq;
@@ -646,7 +681,7 @@
			hwif->udma_four = (pdc202xx_old_cable_detect(hwif)) ? 0 : 1;
		hwif->dma_start = &pdc202xx_old_ide_dma_start;
		hwif->ide_dma_end = &pdc202xx_old_ide_dma_end;
-	}
+	}
	hwif->ide_dma_test_irq = &pdc202xx_old_ide_dma_test_irq;

	if (!noautodma)

_________________________________________________________________
Don’t just search. Find. Check out the new MSN Search! 
http://search.msn.click-url.com/go/onm00200636ave/direct/01/

