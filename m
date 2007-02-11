From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH][pata] ide: cable detection fixes
Date: Sun, 11 Feb 2007 23:24:21 +0100
Message-ID: <200702112324.21704.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.169]:2629 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932577AbXBKWSw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 11 Feb 2007 17:18:52 -0500
Received: by ug-out-1314.google.com with SMTP id 44so422500uga
        for <linux-ide@vger.kernel.org>; Sun, 11 Feb 2007 14:18:51 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>


[PATCH] ide: cable detection fixes

Tejun's recent eighty_ninty_three() fix has inspired me to do more thorough
review of the cable detection code...

* print user-friendly warning about limiting the maximum transfer speed
  to UDMA33 (and the reason behind it) when 80-wire cable is not detected,
  also while at it cleanup eighty_ninty_three() a bit

* use eighty_ninty_three() in ide_ata66_check(), this actually fixes 3 bugs:
  - bit 13 (word 93 validity check) == 1 and bit 12 (80-wire cable test) == 0
    configuration was incorrectly treated as a 80-wire cable present
    [ for CONFIG_IDEDMA_IVB=n ]
  - CONFIG_IDEDMA_IVB=y/n cases were interchanged
  - check for SATA devices were missing

* remove private cable warnings from pdc_202xx{old,new} drivers now that core
  code provides this functionality (plus, in pdc202xx_new case the test could
  give false warnings for ATAPI devices because pdc202xx_new driver doesn't
  even support ATAPI DMA)

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

---
 drivers/ide/ide-iops.c         |   51 +++++++++++++++++++++--------------------
 drivers/ide/ide-lib.c          |   11 +++++++-
 drivers/ide/pci/pdc202xx_new.c |   16 ------------
 drivers/ide/pci/pdc202xx_old.c |   20 ----------------
 include/linux/ide.h            |    1 
 5 files changed, 38 insertions(+), 61 deletions(-)

Index: b/drivers/ide/ide-iops.c
===================================================================
--- a/drivers/ide/ide-iops.c
+++ b/drivers/ide/ide-iops.c
@@ -571,21 +571,34 @@ EXPORT_SYMBOL(ide_wait_stat);
  */
 u8 eighty_ninty_three (ide_drive_t *drive)
 {
-	if(HWIF(drive)->udma_four == 0)
-		return 0;
+	ide_hwif_t *hwif = drive->hwif;
+	struct hd_driveid *id = drive->id;
+
+	if (hwif->udma_four == 0)
+		goto no_80w;
 
 	/* Check for SATA but only if we are ATA5 or higher */
-	if (drive->id->hw_config == 0 && (drive->id->major_rev_num & 0x7FE0))
+	if (id->hw_config == 0 && (id->major_rev_num & 0x7FE0))
 		return 1;
-	if (!(drive->id->hw_config & 0x6000))
-		return 0;
+
 #ifndef CONFIG_IDEDMA_IVB
-	if(!(drive->id->hw_config & 0x4000))
-		return 0;
-#endif /* CONFIG_IDEDMA_IVB */
-	if (!(drive->id->hw_config & 0x2000))
+	if ((id->hw_config & 0x6000) == 0x6000)
+#else
+	if (id->hw_config & 0x2000)
+#endif
+		return 1;
+
+no_80w:
+	if (drive->udma33_warned == 1)
 		return 0;
-	return 1;
+
+	printk(KERN_WARNING "%s: %s side 80-wire cable detection failed, "
+			    "limiting max speed to UDMA33\n",
+			    drive->name, hwif->udma_four ? "drive" : "host");
+
+	drive->udma33_warned = 1;
+
+	return 0;
 }
 
 int ide_ata66_check (ide_drive_t *drive, ide_task_t *args)
@@ -593,23 +606,13 @@ int ide_ata66_check (ide_drive_t *drive,
 	if ((args->tfRegister[IDE_COMMAND_OFFSET] == WIN_SETFEATURES) &&
 	    (args->tfRegister[IDE_SECTOR_OFFSET] > XFER_UDMA_2) &&
 	    (args->tfRegister[IDE_FEATURE_OFFSET] == SETFEATURES_XFER)) {
-#ifndef CONFIG_IDEDMA_IVB
-		if ((drive->id->hw_config & 0x6000) == 0) {
-#else /* !CONFIG_IDEDMA_IVB */
-		if (((drive->id->hw_config & 0x2000) == 0) ||
-		    ((drive->id->hw_config & 0x4000) == 0)) {
-#endif /* CONFIG_IDEDMA_IVB */
-			printk("%s: Speed warnings UDMA 3/4/5 is not "
-				"functional.\n", drive->name);
-			return 1;
-		}
-		if (!HWIF(drive)->udma_four) {
-			printk("%s: Speed warnings UDMA 3/4/5 is not "
-				"functional.\n",
-				HWIF(drive)->name);
+		if (eighty_ninty_three(drive) == 0) {
+			printk(KERN_WARNING "%s: UDMA speeds >UDMA33 cannot "
+					    "be set\n", drive->name);
 			return 1;
 		}
 	}
+
 	return 0;
 }
 
Index: b/drivers/ide/ide-lib.c
===================================================================
--- a/drivers/ide/ide-lib.c
+++ b/drivers/ide/ide-lib.c
@@ -88,8 +88,15 @@ u8 ide_rate_filter(ide_drive_t *drive, u
 	if (hwif->udma_filter)
 		mask = hwif->udma_filter(drive);
 
-	if ((mask & 0x78) && (eighty_ninty_three(drive) == 0))
-		mask &= 0x07;
+	/*
+	 * TODO: speed > XFER_UDMA_2 extra check is needed to avoid false
+	 * cable warning from eighty_ninty_three(), moving ide_rate_filter()
+	 * calls from ->speedproc to core code will make this hack go away
+	 */
+	if (speed > XFER_UDMA_2) {
+		if ((mask & 0x78) && (eighty_ninty_three(drive) == 0))
+			mask &= 0x07;
+	}
 
 	if (mask)
 		mode = fls(mask) - 1 + XFER_UDMA_0;
Index: b/drivers/ide/pci/pdc202xx_new.c
===================================================================
--- a/drivers/ide/pci/pdc202xx_new.c
+++ b/drivers/ide/pci/pdc202xx_new.c
@@ -37,8 +37,6 @@
 #include <asm/pci-bridge.h>
 #endif
 
-#define PDC202_DEBUG_CABLE	0
-
 #undef DEBUG
 
 #ifdef DEBUG
@@ -234,17 +232,8 @@ static int config_chipset_for_dma(ide_dr
 {
 	struct hd_driveid *id	= drive->id;
 	ide_hwif_t *hwif	= HWIF(drive);
-	u8 ultra_66		= (id->dma_ultra & 0x0078) ? 1 : 0;
-	u8 cable		= pdcnew_cable_detect(hwif);
 	u8 speed;
 
-	if (ultra_66 && cable) {
-		printk(KERN_WARNING "Warning: %s channel "
-		       "requires an 80-pin cable for operation.\n",
-		       hwif->channel ? "Secondary" : "Primary");
-		printk(KERN_WARNING "%s reduced to Ultra33 mode.\n", drive->name);
-	}
-
 	if (drive->media != ide_disk)
 		return 0;
 
@@ -548,11 +537,6 @@ static void __devinit init_hwif_pdc202ne
 	if (!noautodma)
 		hwif->autodma = 1;
 	hwif->drives[0].autodma = hwif->drives[1].autodma = hwif->autodma;
-
-#if PDC202_DEBUG_CABLE
-	printk(KERN_DEBUG "%s: %s-pin cable\n",
-		hwif->name, hwif->udma_four ? "80" : "40");
-#endif /* PDC202_DEBUG_CABLE */
 }
 
 static int __devinit init_setup_pdcnew(struct pci_dev *dev, ide_pci_device_t *d)
Index: b/drivers/ide/pci/pdc202xx_old.c
===================================================================
--- a/drivers/ide/pci/pdc202xx_old.c
+++ b/drivers/ide/pci/pdc202xx_old.c
@@ -46,7 +46,6 @@
 #include <asm/io.h>
 #include <asm/irq.h>
 
-#define PDC202_DEBUG_CABLE		0
 #define PDC202XX_DEBUG_DRIVE_INFO	0
 
 static const char *pdc_quirk_drives[] = {
@@ -238,20 +237,7 @@ static int config_chipset_for_dma (ide_d
 	u32 drive_conf		= 0;
 	u8 drive_pci		= 0x60 + (drive->dn << 2);
 	u8 test1 = 0, test2 = 0, speed = -1;
-	u8 AP = 0, cable = 0;
-
-	u8 ultra_66		= ((id->dma_ultra & 0x0010) ||
-				   (id->dma_ultra & 0x0008)) ? 1 : 0;
-
-	if (dev->device != PCI_DEVICE_ID_PROMISE_20246)
-		cable = pdc202xx_old_cable_detect(hwif);
-	else
-		ultra_66 = 0;
-
-	if (ultra_66 && cable) {
-		printk(KERN_WARNING "Warning: %s channel requires an 80-pin cable for operation.\n", hwif->channel ? "Secondary":"Primary");
-		printk(KERN_WARNING "%s reduced to Ultra33 mode.\n", drive->name);
-	}
+	u8 AP = 0;
 
 	if (dev->device != PCI_DEVICE_ID_PROMISE_20246)
 		pdc_old_disable_66MHz_clock(drive->hwif);
@@ -477,10 +463,6 @@ static void __devinit init_hwif_pdc202xx
 	if (!noautodma)
 		hwif->autodma = 1;
 	hwif->drives[0].autodma = hwif->drives[1].autodma = hwif->autodma;
-#if PDC202_DEBUG_CABLE
-	printk(KERN_DEBUG "%s: %s-pin cable\n",
-		hwif->name, hwif->udma_four ? "80" : "40");
-#endif /* PDC202_DEBUG_CABLE */	
 }
 
 static void __devinit init_dma_pdc202xx(ide_hwif_t *hwif, unsigned long dmabase)
Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -605,6 +605,7 @@ typedef struct ide_drive_s {
 	unsigned scsi		: 1;	/* 0=default, 1=ide-scsi emulation */
 	unsigned sleeping	: 1;	/* 1=sleeping & sleep field valid */
 	unsigned post_reset	: 1;
+	unsigned udma33_warned	: 1;
 
 	u8	addressing;	/* 0=28-bit, 1=48-bit, 2=48-bit doing 28-bit */
         u8	quirk_list;	/* considered quirky, set for a specific host */
