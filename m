From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 9/13] ide: remove ->ide_dma_on and ->dma_off_quietly methods from ide_hwif_t
Date: Tue, 13 Nov 2007 00:02:00 +0100
Message-ID: <200711130002.00911.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.186]:26998 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758072AbXKLW62 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 12 Nov 2007 17:58:28 -0500
Received: by mu-out-0910.google.com with SMTP id i10so1613501mue
        for <linux-ide@vger.kernel.org>; Mon, 12 Nov 2007 14:58:26 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


* Make ide_dma_off_quietly() and __ide_dma_on() always available.

* Drop "__" prefix from __ide_dma_on().

* Check for presence of ->dma_host_on instead of ->ide_dma_on.

* Convert all users of ->ide_dma_on and ->dma_off_quietly methods
  to use ide_dma_on() and ide_dma_off_quietly() instead.

* Remove no longer needed ->ide_dma_on and ->dma_off_quietly methods
  from ide_hwif_t.

* Make ide_dma_on() void.

There should be no functionality changes caused by this patch.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/arm/icside.c      |   16 ----------------
 drivers/ide/ide-dma.c         |   30 +++++++++++++-----------------
 drivers/ide/ide-io.c          |    8 ++++----
 drivers/ide/ide-iops.c        |   10 +++++-----
 drivers/ide/ide-probe.c       |    2 +-
 drivers/ide/ide.c             |    4 +---
 drivers/ide/mips/au1xxx-ide.c |   16 ----------------
 drivers/ide/pci/sc1200.c      |    2 +-
 drivers/ide/pci/sgiioc4.c     |   19 -------------------
 drivers/ide/ppc/pmac.c        |    2 --
 include/linux/ide.h           |    8 ++++----
 11 files changed, 29 insertions(+), 88 deletions(-)

Index: b/drivers/ide/arm/icside.c
===================================================================
--- a/drivers/ide/arm/icside.c
+++ b/drivers/ide/arm/icside.c
@@ -291,24 +291,10 @@ static void icside_dma_host_off(ide_driv
 {
 }
 
-static void icside_dma_off_quietly(ide_drive_t *drive)
-{
-	drive->using_dma = 0;
-	ide_toggle_bounce(drive, 0);
-}
-
 static void icside_dma_host_on(ide_drive_t *drive)
 {
 }
 
-static int icside_dma_on(ide_drive_t *drive)
-{
-	drive->using_dma = 1;
-	ide_toggle_bounce(drive, 1);
-
-	return 0;
-}
-
 static int icside_dma_end(ide_drive_t *drive)
 {
 	ide_hwif_t *hwif = HWIF(drive);
@@ -425,9 +411,7 @@ static void icside_dma_init(ide_hwif_t *
 	hwif->set_dma_mode	= icside_set_dma_mode;
 
 	hwif->dma_host_off	= icside_dma_host_off;
-	hwif->dma_off_quietly	= icside_dma_off_quietly;
 	hwif->dma_host_on	= icside_dma_host_on;
-	hwif->ide_dma_on	= icside_dma_on;
 	hwif->dma_setup		= icside_dma_setup;
 	hwif->dma_exec_cmd	= icside_dma_exec_cmd;
 	hwif->dma_start		= icside_dma_start;
Index: b/drivers/ide/ide-dma.c
===================================================================
--- a/drivers/ide/ide-dma.c
+++ b/drivers/ide/ide-dma.c
@@ -424,6 +424,7 @@ void ide_dma_host_off(ide_drive_t *drive
 }
 
 EXPORT_SYMBOL(ide_dma_host_off);
+#endif /* CONFIG_BLK_DEV_IDEDMA_PCI */
 
 /**
  *	ide_dma_off_quietly	-	Generic DMA kill
@@ -441,7 +442,6 @@ void ide_dma_off_quietly(ide_drive_t *dr
 }
 
 EXPORT_SYMBOL(ide_dma_off_quietly);
-#endif /* CONFIG_BLK_DEV_IDEDMA_PCI */
 
 /**
  *	ide_dma_off	-	disable DMA on a device
@@ -454,7 +454,7 @@ EXPORT_SYMBOL(ide_dma_off_quietly);
 void ide_dma_off(ide_drive_t *drive)
 {
 	printk(KERN_INFO "%s: DMA disabled\n", drive->name);
-	drive->hwif->dma_off_quietly(drive);
+	ide_dma_off_quietly(drive);
 }
 
 EXPORT_SYMBOL(ide_dma_off);
@@ -480,26 +480,26 @@ void ide_dma_host_on(ide_drive_t *drive)
 }
 
 EXPORT_SYMBOL(ide_dma_host_on);
+#endif
 
 /**
- *	__ide_dma_on		-	Enable DMA on a device
+ *	ide_dma_on		-	Enable DMA on a device
  *	@drive: drive to enable DMA on
  *
  *	Enable IDE DMA for a device on this IDE controller.
  */
- 
-int __ide_dma_on (ide_drive_t *drive)
+
+void ide_dma_on(ide_drive_t *drive)
 {
 	drive->using_dma = 1;
 	ide_toggle_bounce(drive, 1);
 
 	drive->hwif->dma_host_on(drive);
-
-	return 0;
 }
 
-EXPORT_SYMBOL(__ide_dma_on);
+EXPORT_SYMBOL(ide_dma_on);
 
+#ifdef CONFIG_BLK_DEV_IDEDMA_PCI
 /**
  *	ide_dma_setup	-	begin a DMA phase
  *	@drive: target device
@@ -854,15 +854,13 @@ void ide_dma_verbose(ide_drive_t *drive)
 	return;
 bug_dma_off:
 	printk(", BUG DMA OFF");
-	hwif->dma_off_quietly(drive);
-	return;
+	ide_dma_off_quietly(drive);
 }
 
 EXPORT_SYMBOL(ide_dma_verbose);
 
 int ide_set_dma(ide_drive_t *drive)
 {
-	ide_hwif_t *hwif = drive->hwif;
 	int rc;
 
 	/*
@@ -871,13 +869,15 @@ int ide_set_dma(ide_drive_t *drive)
 	 * things, if not checked and cleared.
 	 *   PARANOIA!!!
 	 */
-	hwif->dma_off_quietly(drive);
+	ide_dma_off_quietly(drive);
 
 	rc = ide_dma_check(drive);
 	if (rc)
 		return rc;
 
-	return hwif->ide_dma_on(drive);
+	ide_dma_on(drive);
+
+	return 0;
 }
 
 #ifdef CONFIG_BLK_DEV_IDEDMA_PCI
@@ -1014,12 +1014,8 @@ void ide_setup_dma(ide_hwif_t *hwif, uns
 	if (!(hwif->dma_prdtable))
 		hwif->dma_prdtable	= (hwif->dma_base + 4);
 
-	if (!hwif->dma_off_quietly)
-		hwif->dma_off_quietly = &ide_dma_off_quietly;
 	if (!hwif->dma_host_off)
 		hwif->dma_host_off = &ide_dma_host_off;
-	if (!hwif->ide_dma_on)
-		hwif->ide_dma_on = &__ide_dma_on;
 	if (!hwif->dma_host_on)
 		hwif->dma_host_on = &ide_dma_host_on;
 	if (!hwif->dma_setup)
Index: b/drivers/ide/ide-io.c
===================================================================
--- a/drivers/ide/ide-io.c
+++ b/drivers/ide/ide-io.c
@@ -75,7 +75,7 @@ static int __ide_end_request(ide_drive_t
 	 */
 	if (drive->state == DMA_PIO_RETRY && drive->retry_pio <= 3) {
 		drive->state = 0;
-		HWGROUP(drive)->hwif->ide_dma_on(drive);
+		ide_dma_on(drive);
 	}
 
 	if (!end_that_request_chunk(rq, uptodate, nr_bytes)) {
@@ -219,7 +219,7 @@ static ide_startstop_t ide_start_power_s
 		 * we could be smarter and check for current xfer_speed
 		 * in struct drive etc...
 		 */
-		if (drive->hwif->ide_dma_on == NULL)
+		if (drive->hwif->dma_host_on == NULL)
 			break;
 		/*
 		 * TODO: respect ->using_dma setting
@@ -787,7 +787,7 @@ static ide_startstop_t do_special (ide_d
 
 			if (hwif->host_flags & IDE_HFLAG_SET_PIO_MODE_KEEP_DMA) {
 				if (keep_dma)
-					hwif->ide_dma_on(drive);
+					ide_dma_on(drive);
 			}
 		}
 
@@ -1332,7 +1332,7 @@ static ide_startstop_t ide_dma_timeout_r
 	 */
 	drive->retry_pio++;
 	drive->state = DMA_PIO_RETRY;
-	hwif->dma_off_quietly(drive);
+	ide_dma_off_quietly(drive);
 
 	/*
 	 * un-busy drive etc (hwgroup->busy is cleared on return) and
Index: b/drivers/ide/ide-iops.c
===================================================================
--- a/drivers/ide/ide-iops.c
+++ b/drivers/ide/ide-iops.c
@@ -739,7 +739,7 @@ int ide_config_drive_speed(ide_drive_t *
 //		msleep(50);
 
 #ifdef CONFIG_BLK_DEV_IDEDMA
-	if (hwif->ide_dma_on)	/* check if host supports DMA */
+	if (hwif->dma_host_on)	/* check if host supports DMA */
 		hwif->dma_host_off(drive);
 #endif
 
@@ -793,8 +793,8 @@ int ide_config_drive_speed(ide_drive_t *
 #ifdef CONFIG_BLK_DEV_IDEDMA
 	if (speed >= XFER_SW_DMA_0 || (hwif->host_flags & IDE_HFLAG_VDMA))
 		hwif->dma_host_on(drive);
-	else if (hwif->ide_dma_on)	/* check if host supports DMA */
-		hwif->dma_off_quietly(drive);
+	else if (hwif->dma_host_on)	/* check if host supports DMA */
+		ide_dma_off_quietly(drive);
 #endif
 
 	switch(speed) {
@@ -1004,10 +1004,10 @@ static void check_dma_crc(ide_drive_t *d
 {
 #ifdef CONFIG_BLK_DEV_IDEDMA
 	if (drive->crc_count) {
-		drive->hwif->dma_off_quietly(drive);
+		ide_dma_off_quietly(drive);
 		ide_set_xfer_rate(drive, ide_auto_reduce_xfer(drive));
 		if (drive->current_speed >= XFER_SW_DMA_0)
-			(void) HWIF(drive)->ide_dma_on(drive);
+			ide_dma_on(drive);
 	} else
 		ide_dma_off(drive);
 #endif
Index: b/drivers/ide/ide-probe.c
===================================================================
--- a/drivers/ide/ide-probe.c
+++ b/drivers/ide/ide-probe.c
@@ -840,7 +840,7 @@ static void probe_hwif(ide_hwif_t *hwif)
 
 			drive->nice1 = 1;
 
-			if (hwif->ide_dma_on)
+			if (hwif->dma_host_on)
 				ide_set_dma(drive);
 		}
 	}
Index: b/drivers/ide/ide.c
===================================================================
--- a/drivers/ide/ide.c
+++ b/drivers/ide/ide.c
@@ -437,8 +437,6 @@ static void ide_hwif_restore(ide_hwif_t 
 	hwif->dma_exec_cmd		= tmp_hwif->dma_exec_cmd;
 	hwif->dma_start			= tmp_hwif->dma_start;
 	hwif->ide_dma_end		= tmp_hwif->ide_dma_end;
-	hwif->ide_dma_on		= tmp_hwif->ide_dma_on;
-	hwif->dma_off_quietly		= tmp_hwif->dma_off_quietly;
 	hwif->ide_dma_test_irq		= tmp_hwif->ide_dma_test_irq;
 	hwif->ide_dma_clear_irq		= tmp_hwif->ide_dma_clear_irq;
 	hwif->dma_host_on		= tmp_hwif->dma_host_on;
@@ -830,7 +828,7 @@ int set_using_dma(ide_drive_t *drive, in
 	if (!drive->id || !(drive->id->capability & 1))
 		goto out;
 
-	if (hwif->ide_dma_on == NULL)
+	if (hwif->dma_host_on == NULL)
 		goto out;
 
 	err = -EBUSY;
Index: b/drivers/ide/mips/au1xxx-ide.c
===================================================================
--- a/drivers/ide/mips/au1xxx-ide.c
+++ b/drivers/ide/mips/au1xxx-ide.c
@@ -399,24 +399,10 @@ static void auide_dma_host_on(ide_drive_
 {
 }
 
-static int auide_dma_on(ide_drive_t *drive)
-{
-	drive->using_dma = 1;
-	ide_toggle_bounce(drive, 1);
-
-	return 0;
-}
-
 static void auide_dma_host_off(ide_drive_t *drive)
 {
 }
 
-static void auide_dma_off_quietly(ide_drive_t *drive)
-{
-	drive->using_dma = 0;
-	ide_toggle_bounce(drive, 0);
-}
-
 static void auide_dma_lost_irq(ide_drive_t *drive)
 {
 	printk(KERN_ERR "%s: IRQ lost\n", drive->name);
@@ -684,7 +670,6 @@ static int au_ide_probe(struct device *d
 	hwif->set_dma_mode		= &auide_set_dma_mode;
 
 #ifdef CONFIG_BLK_DEV_IDE_AU1XXX_MDMA2_DBDMA
-	hwif->dma_off_quietly		= &auide_dma_off_quietly;
 	hwif->dma_timeout		= &auide_dma_timeout;
 
 	hwif->mdma_filter		= &auide_mdma_filter;
@@ -697,7 +682,6 @@ static int au_ide_probe(struct device *d
 	hwif->dma_host_off		= &auide_dma_host_off;
 	hwif->dma_host_on		= &auide_dma_host_on;
 	hwif->dma_lost_irq		= &auide_dma_lost_irq;
-	hwif->ide_dma_on                = &auide_dma_on;
 #else /* !CONFIG_BLK_DEV_IDE_AU1XXX_MDMA2_DBDMA */
 	hwif->channel                   = 0;
 	hwif->hold                      = 1;
Index: b/drivers/ide/pci/sc1200.c
===================================================================
--- a/drivers/ide/pci/sc1200.c
+++ b/drivers/ide/pci/sc1200.c
@@ -220,7 +220,7 @@ static void sc1200_set_pio_mode(ide_driv
 	}
 	if (mode != -1) {
 		printk("SC1200: %s: changing (U)DMA mode\n", drive->name);
-		hwif->dma_off_quietly(drive);
+		ide_dma_off_quietly(drive);
 		if (ide_set_dma_mode(drive, mode) == 0)
 			hwif->dma_host_on(drive);
 		return;
Index: b/drivers/ide/pci/sgiioc4.c
===================================================================
--- a/drivers/ide/pci/sgiioc4.c
+++ b/drivers/ide/pci/sgiioc4.c
@@ -277,23 +277,6 @@ sgiioc4_ide_dma_end(ide_drive_t * drive)
 	return dma_stat;
 }
 
-static int
-sgiioc4_ide_dma_on(ide_drive_t * drive)
-{
-	drive->using_dma = 1;
-	ide_toggle_bounce(drive, 1);
-
-	return 0;
-}
-
-static void sgiioc4_dma_off_quietly(ide_drive_t *drive)
-{
-	drive->using_dma = 0;
-	ide_toggle_bounce(drive, 0);
-
-	drive->hwif->dma_host_off(drive);
-}
-
 static void sgiioc4_set_dma_mode(ide_drive_t *drive, const u8 speed)
 {
 }
@@ -598,8 +581,6 @@ ide_init_sgiioc4(ide_hwif_t * hwif)
 	hwif->dma_setup = &sgiioc4_ide_dma_setup;
 	hwif->dma_start = &sgiioc4_ide_dma_start;
 	hwif->ide_dma_end = &sgiioc4_ide_dma_end;
-	hwif->ide_dma_on = &sgiioc4_ide_dma_on;
-	hwif->dma_off_quietly = &sgiioc4_dma_off_quietly;
 	hwif->ide_dma_test_irq = &sgiioc4_ide_dma_test_irq;
 	hwif->dma_host_on = &sgiioc4_dma_host_on;
 	hwif->dma_host_off = &sgiioc4_dma_host_off;
Index: b/drivers/ide/ppc/pmac.c
===================================================================
--- a/drivers/ide/ppc/pmac.c
+++ b/drivers/ide/ppc/pmac.c
@@ -1748,8 +1748,6 @@ pmac_ide_setup_dma(pmac_ide_hwif_t *pmif
 		return;
 	}
 
-	hwif->dma_off_quietly = &ide_dma_off_quietly;
-	hwif->ide_dma_on = &__ide_dma_on;
 	hwif->dma_setup = &pmac_ide_dma_setup;
 	hwif->dma_exec_cmd = &pmac_ide_dma_exec_cmd;
 	hwif->dma_start = &pmac_ide_dma_start;
Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -546,8 +546,6 @@ typedef struct hwif_s {
 	void (*dma_exec_cmd)(ide_drive_t *, u8);
 	void (*dma_start)(ide_drive_t *);
 	int (*ide_dma_end)(ide_drive_t *drive);
-	int (*ide_dma_on)(ide_drive_t *drive);
-	void (*dma_off_quietly)(ide_drive_t *drive);
 	int (*ide_dma_test_irq)(ide_drive_t *drive);
 	void (*ide_dma_clear_irq)(ide_drive_t *drive);
 	void (*dma_host_on)(ide_drive_t *drive);
@@ -1148,7 +1146,9 @@ static inline u8 ide_max_dma_mode(ide_dr
 	return ide_find_dma_mode(drive, XFER_UDMA_6);
 }
 
+void ide_dma_off_quietly(ide_drive_t *);
 void ide_dma_off(ide_drive_t *);
+void ide_dma_on(ide_drive_t *);
 void ide_dma_verbose(ide_drive_t *);
 int ide_set_dma(ide_drive_t *);
 ide_startstop_t ide_dma_intr(ide_drive_t *);
@@ -1161,9 +1161,7 @@ extern int ide_release_dma(ide_hwif_t *)
 extern void ide_setup_dma(ide_hwif_t *, unsigned long, unsigned int);
 
 void ide_dma_host_off(ide_drive_t *);
-void ide_dma_off_quietly(ide_drive_t *);
 void ide_dma_host_on(ide_drive_t *);
-extern int __ide_dma_on(ide_drive_t *);
 extern int ide_dma_setup(ide_drive_t *);
 extern void ide_dma_start(ide_drive_t *);
 extern int __ide_dma_end(ide_drive_t *);
@@ -1174,7 +1172,9 @@ extern void ide_dma_timeout(ide_drive_t 
 #else
 static inline u8 ide_find_dma_mode(ide_drive_t *drive, u8 speed) { return 0; }
 static inline u8 ide_max_dma_mode(ide_drive_t *drive) { return 0; }
+static inline void ide_dma_off_quietly(ide_drive_t *drive) { ; }
 static inline void ide_dma_off(ide_drive_t *drive) { ; }
+static inline void ide_dma_on(ide_drive_t *drive) { ; }
 static inline void ide_dma_verbose(ide_drive_t *drive) { ; }
 static inline int ide_set_dma(ide_drive_t *drive) { return 1; }
 #endif /* CONFIG_BLK_DEV_IDEDMA */
