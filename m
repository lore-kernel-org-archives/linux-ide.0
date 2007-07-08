From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 2/12] ide: mode limiting fixes for user requested speed changes
Date: Sun, 8 Jul 2007 15:34:12 +0200
Message-ID: <200707081534.13187.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.191]:5731 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756373AbXGHOAE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 8 Jul 2007 10:00:04 -0400
Received: by mu-out-0910.google.com with SMTP id i10so570149mue
        for <linux-ide@vger.kernel.org>; Sun, 08 Jul 2007 07:00:02 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


* Add an extra argument to ide_max_dma_mode() for passing requested transfer
  mode.  Use it as an upper limit when finding the best DMA for device/host.

* Rename ide_max_dma_mode() to ide_find_dma_mode() and at the same time add
  ide_max_dma_mode() wrapper which passes XFER_UDMA_6 as a requested mode to
  ide_find_dma_mode().  Also add inline ide_find_dma_mode() version for
  CONFIG_BLK_DEV_IDEDMA=n case.

* Pass requested transfer mode from ide_find_dma_mode() to ide_get_mode_mask()
  to avoid false warning from eighty_ninty_three().

* Use ide_find_dma_mode() to limit the user requested transfer mode in
  ide_rate_filter().  Also limit the requested mode by host max PIO mode.


Above changes make ide_rate_filter() to:

* Clip desired transfer mode down if it is invalid (values 0x0F, 0x13-0x19
  and 0x25-0x39, values > 0x46 values were already clipped down, same for
  0x25-0x39 values but iff UDMA was not supported by the host).

* Clip desired transfer mode down down if it is currently unsupported by
  IDE core (PIO6 and MWDMA3-4, the latter were already clipped down but
  iff UDMA was not supported by the host).

* Clip desired transfer mode down according to the host capabilities
  (UDMA modes were already clipped down but MWDMA/SWDMA/PIO weren't,
  also ->atapi_dma flag was not respected).

* Clip desired transfer mode down according to the device capabilities
  (except PIO modes for now which require mode work) - shouldn't be a
  problem since ide_set_xfer_rate() is called _after_ device has accepted
  given transfer mode.

and also result in a number of host driver specific bugfixes:

* icside
  - clip unsupported PIO5 mode down
  - fix unsupported/invalid modes being set in drive->current_speed

* ide-cris
  - clip unsupported PIO5 and SWDMA0-2 modes down
  - clip DMA modes down for ATAPI devices
  - fix BUG() on unsupported/invalid modes

* au1xxx-ide
  - clip unsupported PIO5, SWDMA0-2 and MWDMA0-2
    (if BLK_DEV_IDE_AU1XXX_MDMA2_DBDMA=n) modes down

* aec62xx
  - clip unsupported PIO5 and SWDMA0-2 modes down
  - clip DMA modes down for ATAPI devices
  - fix 0x00 being programmed as PIO timing for unsupported/invalid modes
  - fix unsupported/invalid modes being set on the device

* alim15x3
  - clip DMA modes down for ATAPI devices (chipset revision == 0x20 only)
  - fix theoretical OOPS for 0x0F mode
  - fix unsupported/invalid modes being set on the device

* amd74xx
  - clip unsupported SWDMA0-2 (on COBRA_7401 revs <= 7) modes down
  - fix random PIO timings being set for unsupported/invalid modes
  - fix unsupported/invalid modes being set on the device

* atiixp
  - clip unsupported PIO5 and SWDMA0-2 modes down
  - fix cached MWDMA mode being cleared for unsupported/invalid modes
  - fix PIO{0,2} timings being programmed for unsupported/invalid modes
  - fix theoretical OOPS for PIO5-6 and 0x0F modes
  - fix unsupported/invalid modes being set on the device

* cmd64x
  - clip unsupported SWDMA0-2 modes down

* cs5530
  - clip unsupported PIO5 and SWDMA0-2 modes down
  - fix unsupported/invalid modes being set on the device
  - fix bug BUG() on unsupported/invalid modes
    (which happend if the device accepted the setting)

* cs5535
  - clip unsupported PIO5 and SWDMA0-2 modes down
  - fix unsupported/invalid modes being set on the device
  - fix theoretical OOPS for PIO5-6 and 0x0F modes

* hpt34x
  - clip DMA modes down for ATAPI devices
  - fix invalid timings being programmed for unsupported/invalid modes
  - fix unsupported/invalid modes being set on the device

* hpt366
  - clip unsupported PIO5 and SWDMA0-2 modes down
  - fix PIO0 timings being programmed for unsupported/invalid modes
  - fix DMA timings being cleared for MWDMA3-4 and 0x25-0x39 modes
  - fix unsupported/invalid modes being set on the device

* it8213
  - clip unsupported PIO5, SWDMA0-1 and MWDMA0 modes down

* it821x
  - clip unsupported PIO5 and SWDMA0-2 modes down
  - clip DMA modes down for ATAPI devices
    (chipset in smart mode and revision 0x10 in pass-through mode)

* jmicron
  - clip unsupported SWDMA0-2 modes down
  - fix unsupported/invalid modes being set on the device

* pdc202xx_new
  - clip unsupported PIO5 and SWDMA0-2 modes down
  - fix unsupported/invalid modes being set on the device

* pdc202xx_old
  - clip unsupported PIO5 mode down
  - fix incorrect timings being set for unsupported/invalid modes
  - fix unsupported/invalid modes being set on the device

* piix
  - clip unsupported PIO5, SWDMA0-1 and MWDMA0 modes down

* sc1200
  - clip unsupported PIO5 and SWDMA0-2 modes down
  - fix unsupported/invalid modes being set on the device
  - fix bug BUG() on unsupported/invalid modes
    (which happend if the device accepted the setting)

* scc_pata
  - clip unsupported PIO5, SWDMA0-2 and MWDMA0-2 modes down

* serverworks
  - clip unsupported PIO5 and SWDMA0-2 modes down
  - fix DMA/UDMA timings/settings being cleared for unsupported/invalid modes
  - fix unsupported/invalid modes being set on the device

* siimage
  - clip unsupported PIO5 and SWDMA0-2 modes down
  - clip DMA modes down for ATAPI devices (SATA chipsets)

* sis5513
  - clip unsupported PIO5 mode down
  - fix BUG() on unsupported/invalid modes

* sl82c105
  - clip unsupported SWDMA0-2 modes down

* slc90e66
  - clip unsupported PIO5, SWDMA0-1 and MWDMA0 modes down

* tc86c001
  - clip unsupported PIO5 and SWDMA0-2 modes down
  - fix PIO0 timings being programmed for PIO5/0x0F/SWDMA0-2/0x13-0x19 modes
  - fix invalid 0x00 DMA timing being programmed for MWDMA3-4/0x25-0x39 modes
  - fix unsupported/invalid modes being set on the device

* triflex
  - clip unsupported PIO5 mode down

* via82cxxx
  - fix random PIO timings being set for unsupported/invalid modes
  - fix unsupported/invalid modes being set on the device

* pmac
  - clip unsupported PIO5 and SWDMA0-2 modes down

* cmd640/ht6560b
  - clip DMA modes down (if CONFIG_BLK_DEV_IDEDMA=y)
  - fix PIO5 being clipped to PIO4 (if CONFIG_BLK_DEV_IDEDMA=n)

* opti621
  - clip DMA modes down (if CONFIG_BLK_DEV_IDEDMA=y)
  - clip unsupported PIO4 to PIO3 (if CONFIG_BLK_DEV_IDEDMA=n)


While at it:

* Use ide_rate_filter() in cs5520.c::cs5520_tune_chipset().

* Remove no longer needed checks from hpt366.c::hpt3{6,7}x_tune_chipset().

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
This patch obsoletes following previous patches:
[PATCH] atiixp: ->speedproc, filter out invalid modes passed from user-space
[PATCH] alim15x3: ->speedproc, filter out invalid modes passed from user-space

 drivers/ide/ide-dma.c    |   32 +++++++++++++++++++++-----------
 drivers/ide/ide-lib.c    |   27 +++++++--------------------
 drivers/ide/pci/cs5520.c |    2 +-
 drivers/ide/pci/hpt366.c |    8 --------
 include/linux/ide.h      |   10 +++++++++-
 5 files changed, 38 insertions(+), 41 deletions(-)

Index: b/drivers/ide/ide-dma.c
===================================================================
--- a/drivers/ide/ide-dma.c
+++ b/drivers/ide/ide-dma.c
@@ -678,7 +678,7 @@ static const u8 xfer_mode_bases[] = {
 	XFER_SW_DMA_0,
 };
 
-static unsigned int ide_get_mode_mask(ide_drive_t *drive, u8 base)
+static unsigned int ide_get_mode_mask(ide_drive_t *drive, u8 base, u8 req_mode)
 {
 	struct hd_driveid *id = drive->id;
 	ide_hwif_t *hwif = drive->hwif;
@@ -694,8 +694,13 @@ static unsigned int ide_get_mode_mask(id
 		if (hwif->udma_filter)
 			mask &= hwif->udma_filter(drive);
 
-		if ((mask & 0x78) && (eighty_ninty_three(drive) == 0))
-			mask &= 0x07;
+		/*
+		 * avoid false cable warning from eighty_ninty_three()
+		 */
+		if (req_mode > XFER_UDMA_2) {
+			if ((mask & 0x78) && (eighty_ninty_three(drive) == 0))
+				mask &= 0x07;
+		}
 		break;
 	case XFER_MW_DMA_0:
 		if (id->field_valid & 2)
@@ -728,15 +733,18 @@ static unsigned int ide_get_mode_mask(id
 }
 
 /**
- *	ide_max_dma_mode	-	compute DMA speed
+ *	ide_find_dma_mode	-	compute DMA speed
  *	@drive: IDE device
+ *	@req_mode: requested mode
+ *
+ *	Checks the drive/host capabilities and finds the speed to use for
+ *	the DMA transfer.  The speed is then limited by the requested mode.
  *
- *	Checks the drive capabilities and returns the speed to use
- *	for the DMA transfer.  Returns 0 if the drive is incapable
- *	of DMA transfers.
+ *	Returns 0 if the drive/host combination is incapable of DMA transfers
+ *	or if the requested mode is not a DMA mode.
  */
 
-u8 ide_max_dma_mode(ide_drive_t *drive)
+u8 ide_find_dma_mode(ide_drive_t *drive, u8 req_mode)
 {
 	ide_hwif_t *hwif = drive->hwif;
 	unsigned int mask;
@@ -747,7 +755,9 @@ u8 ide_max_dma_mode(ide_drive_t *drive)
 		return 0;
 
 	for (i = 0; i < ARRAY_SIZE(xfer_mode_bases); i++) {
-		mask = ide_get_mode_mask(drive, xfer_mode_bases[i]);
+		if (req_mode < xfer_mode_bases[i])
+			continue;
+		mask = ide_get_mode_mask(drive, xfer_mode_bases[i], req_mode);
 		x = fls(mask) - 1;
 		if (x >= 0) {
 			mode = xfer_mode_bases[i] + x;
@@ -757,10 +767,10 @@ u8 ide_max_dma_mode(ide_drive_t *drive)
 
 	printk(KERN_DEBUG "%s: selected mode 0x%x\n", drive->name, mode);
 
-	return mode;
+	return min(mode, req_mode);
 }
 
-EXPORT_SYMBOL_GPL(ide_max_dma_mode);
+EXPORT_SYMBOL_GPL(ide_find_dma_mode);
 
 int ide_tune_dma(ide_drive_t *drive)
 {
Index: b/drivers/ide/ide-lib.c
===================================================================
--- a/drivers/ide/ide-lib.c
+++ b/drivers/ide/ide-lib.c
@@ -76,37 +76,24 @@ EXPORT_SYMBOL(ide_xfer_verbose);
  *	Given the available transfer modes this function returns
  *	the best available speed at or below the speed requested.
  *
- *	FIXME: filter also PIO/SWDMA/MWDMA modes
+ *	TODO: check device PIO capabilities
  */
 
 u8 ide_rate_filter(ide_drive_t *drive, u8 speed)
 {
-#ifdef CONFIG_BLK_DEV_IDEDMA
 	ide_hwif_t *hwif = drive->hwif;
-	u8 mask = hwif->ultra_mask, mode = XFER_MW_DMA_2;
+	u8 mode = ide_find_dma_mode(drive, speed);
 
-	if (hwif->udma_filter)
-		mask = hwif->udma_filter(drive);
-
-	/*
-	 * TODO: speed > XFER_UDMA_2 extra check is needed to avoid false
-	 * cable warning from eighty_ninty_three(), moving ide_rate_filter()
-	 * calls from ->speedproc to core code will make this hack go away
-	 */
-	if (speed > XFER_UDMA_2) {
-		if ((mask & 0x78) && (eighty_ninty_three(drive) == 0))
-			mask &= 0x07;
+	if (mode == 0) {
+		if (hwif->pio_mask)
+			mode = fls(hwif->pio_mask) - 1 + XFER_PIO_0;
+		else
+			mode = XFER_PIO_4;
 	}
 
-	if (mask)
-		mode = fls(mask) - 1 + XFER_UDMA_0;
-
 //	printk("%s: mode 0x%02x, speed 0x%02x\n", __FUNCTION__, mode, speed);
 
 	return min(speed, mode);
-#else /* !CONFIG_BLK_DEV_IDEDMA */
-	return min(speed, (u8)XFER_PIO_4);
-#endif /* CONFIG_BLK_DEV_IDEDMA */
 }
 
 EXPORT_SYMBOL(ide_rate_filter);
Index: b/drivers/ide/pci/cs5520.c
===================================================================
--- a/drivers/ide/pci/cs5520.c
+++ b/drivers/ide/pci/cs5520.c
@@ -70,7 +70,7 @@ static int cs5520_tune_chipset(ide_drive
 {
 	ide_hwif_t *hwif = HWIF(drive);
 	struct pci_dev *pdev = hwif->pci_dev;
-	u8 speed = min((u8)XFER_PIO_4, xferspeed);
+	u8 speed = ide_rate_filter(drive, xferspeed);
 	int pio = speed;
 	u8 reg;
 	int controller = drive->dn > 1 ? 1 : 0;
Index: b/drivers/ide/pci/hpt366.c
===================================================================
--- a/drivers/ide/pci/hpt366.c
+++ b/drivers/ide/pci/hpt366.c
@@ -588,10 +588,6 @@ static int hpt36x_tune_chipset(ide_drive
 	u32 old_itr		= 0;
 	u32 itr_mask, new_itr;
 
-	/* TODO: move this to ide_rate_filter() [ check ->atapi_dma ] */
-	if (drive->media != ide_disk)
-		speed = min_t(u8, speed, XFER_PIO_4);
-
 	itr_mask = speed < XFER_MW_DMA_0 ? 0x30070000 :
 		  (speed < XFER_UDMA_0   ? 0xc0070000 : 0xc03800ff);
 
@@ -620,10 +616,6 @@ static int hpt37x_tune_chipset(ide_drive
 	u32 old_itr		= 0;
 	u32 itr_mask, new_itr;
 
-	/* TODO: move this to ide_rate_filter() [ check ->atapi_dma ] */
-	if (drive->media != ide_disk)
-		speed = min_t(u8, speed, XFER_PIO_4);
-
 	itr_mask = speed < XFER_MW_DMA_0 ? 0x303c0000 :
 		  (speed < XFER_UDMA_0   ? 0xc03c0000 : 0xc1c001ff);
 
Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -1300,7 +1300,14 @@ struct drive_list_entry {
 int ide_in_drive_list(struct hd_driveid *, const struct drive_list_entry *);
 int __ide_dma_bad_drive(ide_drive_t *);
 int __ide_dma_good_drive(ide_drive_t *);
-u8 ide_max_dma_mode(ide_drive_t *);
+
+u8 ide_find_dma_mode(ide_drive_t *, u8);
+
+static inline u8 ide_max_dma_mode(ide_drive_t *drive)
+{
+	return ide_find_dma_mode(drive, XFER_UDMA_6);
+}
+
 int ide_tune_dma(ide_drive_t *);
 void ide_dma_off(ide_drive_t *);
 void ide_dma_verbose(ide_drive_t *);
@@ -1327,6 +1334,7 @@ extern void ide_dma_timeout(ide_drive_t 
 #endif /* CONFIG_BLK_DEV_IDEDMA_PCI */
 
 #else
+static inline u8 ide_find_dma_mode(ide_drive_t *drive, u8 speed) { return 0; }
 static inline u8 ide_max_dma_mode(ide_drive_t *drive) { return 0; }
 static inline int ide_tune_dma(ide_drive_t *drive) { return 0; }
 static inline void ide_dma_off(ide_drive_t *drive) { ; }
