From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ide: add ide_set{_max}_pio() (take 4)
Date: Thu, 26 Jul 2007 21:53:44 +0200
Message-ID: <200707262153.44269.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.172]:62760 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936199AbXGZT7z (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 26 Jul 2007 15:59:55 -0400
Received: by ug-out-1314.google.com with SMTP id j3so591339ugf
        for <linux-ide@vger.kernel.org>; Thu, 26 Jul 2007 12:59:53 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, Jeff Garzik <jeff@garzik.org>


* Add IDE_HFLAG_ABUSE_{PREFETCH,FAST_DEVSEL,DMA_MODES} flags
  and set them in ht6560, cmd640, cmd64x and sc1200 host drivers.

* Add set_pio_mode_abuse() for checking if host driver has a non-standard
  ->tuneproc() implementation and use it in do_special().

* Add ide_set_pio() for setting PIO mode (it uses hwif->pio_mask to find
  the maximum PIO mode supported by the host), also add ide_set_max_pio()
  wrapper for ide_set_pio() to use for auto-tuning.  Convert users of
  ->tuneproc to use ide_set{_max}_pio() where possible.  This leaves only
  do_special(), set_using_pio(), ide_hwif_restore() and ide_set_pio() as
  a direct users of ->tuneproc.

* Remove no longer needed ide_get_best_pio_mode() calls and printk-s
  reporting PIO mode selected from ->tuneproc implementations.

* Rename ->tuneproc hook to ->set_pio_mode and make 'pio' argument const.

* Remove stale comment from ide_config_drive_speed().

v2:
* Fix "ata_" prefix (Noticed by Jeff).

v3:
* Minor cleanups/fixups per Sergei's suggestions.

v4:
* Fix compile problem in drivers/ide/pci/cmd640.c
  (Noticed by Andrew Morton).

* Improve some ->set_pio_mode comments.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>
Reviewed-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
---
replacement patch for the one in IDE quilt tree

 drivers/ide/cris/ide-cris.c    |    8 ++---
 drivers/ide/ide-io.c           |   39 +++++++++++++++++++++++---
 drivers/ide/ide-iops.c         |    6 ----
 drivers/ide/ide-lib.c          |   29 +++++++++++++++++++
 drivers/ide/ide-probe.c        |    6 +---
 drivers/ide/ide.c              |    5 ++-
 drivers/ide/legacy/ali14xx.c   |   10 ++----
 drivers/ide/legacy/dtc2278.c   |    6 +---
 drivers/ide/legacy/ht6560b.c   |   11 ++++---
 drivers/ide/legacy/qd65xx.c    |   60 ++++++++++++++++++++++-------------------
 drivers/ide/legacy/umc8672.c   |    7 ++--
 drivers/ide/mips/au1xxx-ide.c  |   12 ++------
 drivers/ide/pci/aec62xx.c      |    7 ++--
 drivers/ide/pci/alim15x3.c     |   32 ++++++++-------------
 drivers/ide/pci/amd74xx.c      |   14 +++------
 drivers/ide/pci/atiixp.c       |    7 ++--
 drivers/ide/pci/cmd640.c       |   35 +++++++++++------------
 drivers/ide/pci/cmd64x.c       |   39 ++++++++++++--------------
 drivers/ide/pci/cs5520.c       |   11 +++----
 drivers/ide/pci/cs5530.c       |   15 ++++------
 drivers/ide/pci/cs5535.c       |   16 +++++-----
 drivers/ide/pci/cy82c693.c     |   20 +------------
 drivers/ide/pci/hpt34x.c       |    7 ++--
 drivers/ide/pci/hpt366.c       |    7 ++--
 drivers/ide/pci/it8213.c       |    7 ++--
 drivers/ide/pci/it821x.c       |    7 ++--
 drivers/ide/pci/jmicron.c      |    7 ++--
 drivers/ide/pci/opti621.c      |   19 ++++++------
 drivers/ide/pci/pdc202xx_new.c |    8 ++---
 drivers/ide/pci/pdc202xx_old.c |   14 +++++----
 drivers/ide/pci/piix.c         |   21 +++++++-------
 drivers/ide/pci/sc1200.c       |   14 ++++-----
 drivers/ide/pci/scc_pata.c     |    7 ++--
 drivers/ide/pci/serverworks.c  |    7 ++--
 drivers/ide/pci/sgiioc4.c      |    2 -
 drivers/ide/pci/siimage.c      |    7 ++--
 drivers/ide/pci/sis5513.c      |   11 +++----
 drivers/ide/pci/sl82c105.c     |   17 +++--------
 drivers/ide/pci/slc90e66.c     |    7 ++--
 drivers/ide/pci/tc86c001.c     |    7 ++--
 drivers/ide/pci/triflex.c      |    9 ++----
 drivers/ide/pci/via82cxxx.c    |   17 ++++-------
 drivers/ide/ppc/mpc8xx.c       |   21 ++------------
 drivers/ide/ppc/pmac.c         |    8 ++---
 include/linux/ide.h            |   18 ++++++++++--
 45 files changed, 318 insertions(+), 326 deletions(-)

Index: b/drivers/ide/cris/ide-cris.c
===================================================================
--- a/drivers/ide/cris/ide-cris.c
+++ b/drivers/ide/cris/ide-cris.c
@@ -680,12 +680,10 @@ static void cris_dma_off(ide_drive_t *dr
 {
 }
 
-static void tune_cris_ide(ide_drive_t *drive, u8 pio)
+static void cris_set_pio_mode(ide_drive_t *drive, const u8 pio)
 {
 	int setup, strobe, hold;
 
-	pio = ide_get_best_pio_mode(drive, pio, 4);
-
 	switch(pio)
 	{
 		case 0:
@@ -725,7 +723,7 @@ static int speed_cris_ide(ide_drive_t *d
 	int cyc = 0, dvs = 0, strobe = 0, hold = 0;
 
 	if (speed >= XFER_PIO_0 && speed <= XFER_PIO_4) {
-		tune_cris_ide(drive, speed - XFER_PIO_0);
+		cris_set_pio_mode(drive, speed - XFER_PIO_0);
 		return ide_config_drive_speed(drive, speed);
 	}
 
@@ -795,7 +793,7 @@ init_e100_ide (void)
 		ide_register_hw(&hw, 1, &hwif);
 		hwif->mmio = 1;
 		hwif->chipset = ide_etrax100;
-		hwif->tuneproc = &tune_cris_ide;
+		hwif->set_pio_mode = &cris_set_pio_mode;
 		hwif->speedproc = &speed_cris_ide;
 		hwif->ata_input_data = &cris_ide_input_data;
 		hwif->ata_output_data = &cris_ide_output_data;
Index: b/drivers/ide/ide-io.c
===================================================================
--- a/drivers/ide/ide-io.c
+++ b/drivers/ide/ide-io.c
@@ -201,8 +201,7 @@ static ide_startstop_t ide_start_power_s
 		return do_rw_taskfile(drive, args);
 
 	case idedisk_pm_restore_pio:	/* Resume step 1 (restore PIO) */
-		if (drive->hwif->tuneproc != NULL)
-			drive->hwif->tuneproc(drive, 255);
+		ide_set_max_pio(drive);
 		/*
 		 * skip idedisk_pm_idle for ATAPI devices
 		 */
@@ -788,6 +787,30 @@ static ide_startstop_t ide_disk_special(
 	return ide_started;
 }
 
+/*
+ * handle HDIO_SET_PIO_MODE ioctl abusers here, eventually it will go away
+ */
+static int set_pio_mode_abuse(ide_hwif_t *hwif, u8 req_pio)
+{
+	switch (req_pio) {
+	case 202:
+	case 201:
+	case 200:
+	case 102:
+	case 101:
+	case 100:
+		return (hwif->host_flags & IDE_HFLAG_ABUSE_DMA_MODES) ? 1 : 0;
+	case 9:
+	case 8:
+		return (hwif->host_flags & IDE_HFLAG_ABUSE_PREFETCH) ? 1 : 0;
+	case 7:
+	case 6:
+		return (hwif->host_flags & IDE_HFLAG_ABUSE_FAST_DEVSEL) ? 1 : 0;
+	default:
+		return 0;
+	}
+}
+
 /**
  *	do_special		-	issue some special commands
  *	@drive: drive the command is for
@@ -805,9 +828,17 @@ static ide_startstop_t do_special (ide_d
 	printk("%s: do_special: 0x%02x\n", drive->name, s->all);
 #endif
 	if (s->b.set_tune) {
+		ide_hwif_t *hwif = drive->hwif;
+		u8 req_pio = drive->tune_req;
+
 		s->b.set_tune = 0;
-		if (HWIF(drive)->tuneproc != NULL)
-			HWIF(drive)->tuneproc(drive, drive->tune_req);
+
+		if (set_pio_mode_abuse(drive->hwif, req_pio)) {
+			if (hwif->set_pio_mode)
+				hwif->set_pio_mode(drive, req_pio);
+		} else
+			ide_set_pio(drive, req_pio);
+
 		return ide_stopped;
 	} else {
 		if (drive->media == ide_disk)
Index: b/drivers/ide/ide-iops.c
===================================================================
--- a/drivers/ide/ide-iops.c
+++ b/drivers/ide/ide-iops.c
@@ -746,12 +746,6 @@ int ide_driveid_update (ide_drive_t *dri
 
 /*
  * Similar to ide_wait_stat(), except it never calls ide_error internally.
- * This is a kludge to handle the new ide_config_drive_speed() function,
- * and should not otherwise be used anywhere.  Eventually, the tuneproc's
- * should be updated to return ide_startstop_t, in which case we can get
- * rid of this abomination again.  :)   -ml
- *
- * It is gone..........
  *
  * const char *msg == consider adding for verbose errors.
  */
Index: b/drivers/ide/ide-lib.c
===================================================================
--- a/drivers/ide/ide-lib.c
+++ b/drivers/ide/ide-lib.c
@@ -325,6 +325,35 @@ u8 ide_get_best_pio_mode (ide_drive_t *d
 
 EXPORT_SYMBOL_GPL(ide_get_best_pio_mode);
 
+/* req_pio == "255" for auto-tune */
+void ide_set_pio(ide_drive_t *drive, u8 req_pio)
+{
+	ide_hwif_t *hwif = drive->hwif;
+	u8 host_pio, pio;
+
+	if (hwif->set_pio_mode == NULL)
+		return;
+
+	BUG_ON(hwif->pio_mask == 0x00);
+
+	host_pio = fls(hwif->pio_mask) - 1;
+
+	pio = ide_get_best_pio_mode(drive, req_pio, host_pio);
+
+	/*
+	 * TODO:
+	 * - report device max PIO mode
+	 * - check req_pio != 255 against device max PIO mode
+	 */
+	printk(KERN_DEBUG "%s: host max PIO%d wanted PIO%d%s selected PIO%d\n",
+			  drive->name, host_pio, req_pio,
+			  req_pio == 255 ? "(auto-tune)" : "", pio);
+
+	hwif->set_pio_mode(drive, pio);
+}
+
+EXPORT_SYMBOL_GPL(ide_set_pio);
+
 /**
  *	ide_toggle_bounce	-	handle bounce buffering
  *	@drive: drive to update
Index: b/drivers/ide/ide-probe.c
===================================================================
--- a/drivers/ide/ide-probe.c
+++ b/drivers/ide/ide-probe.c
@@ -827,10 +827,8 @@ static void probe_hwif(ide_hwif_t *hwif,
 		ide_drive_t *drive = &hwif->drives[unit];
 
 		if (drive->present) {
-			if (hwif->tuneproc != NULL && 
-				drive->autotune == IDE_TUNE_AUTO)
-				/* auto-tune PIO mode */
-				hwif->tuneproc(drive, 255);
+			if (drive->autotune == IDE_TUNE_AUTO)
+				ide_set_max_pio(drive);
 
 			if (drive->autotune != IDE_TUNE_DEFAULT &&
 			    drive->autotune != IDE_TUNE_AUTO)
Index: b/drivers/ide/ide.c
===================================================================
--- a/drivers/ide/ide.c
+++ b/drivers/ide/ide.c
@@ -396,7 +396,7 @@ static void ide_hwif_restore(ide_hwif_t 
 	hwif->cds			= tmp_hwif->cds;
 #endif
 
-	hwif->tuneproc			= tmp_hwif->tuneproc;
+	hwif->set_pio_mode		= tmp_hwif->set_pio_mode;
 	hwif->speedproc			= tmp_hwif->speedproc;
 	hwif->udma_filter		= tmp_hwif->udma_filter;
 	hwif->selectproc		= tmp_hwif->selectproc;
@@ -866,8 +866,9 @@ int set_pio_mode(ide_drive_t *drive, int
 	if (arg < 0 || arg > 255)
 		return -EINVAL;
 
-	if (!HWIF(drive)->tuneproc)
+	if (drive->hwif->set_pio_mode == NULL)
 		return -ENOSYS;
+
 	if (drive->special.b.set_tune)
 		return -EBUSY;
 	ide_init_drive_cmd(&rq);
Index: b/drivers/ide/legacy/ali14xx.c
===================================================================
--- a/drivers/ide/legacy/ali14xx.c
+++ b/drivers/ide/legacy/ali14xx.c
@@ -68,8 +68,6 @@ static RegInitializer initData[] __initd
 	{0x35, 0x03}, {0x00, 0x00}
 };
 
-#define ALI_MAX_PIO 4
-
 /* timing parameter registers for each drive */
 static struct { u8 reg1, reg2, reg3, reg4; } regTab[4] = {
 	{0x03, 0x26, 0x04, 0x27},     /* drive 0 */
@@ -109,7 +107,7 @@ static void outReg (u8 data, u8 reg)
  * This function computes timing parameters
  * and sets controller registers accordingly.
  */
-static void ali14xx_tune_drive (ide_drive_t *drive, u8 pio)
+static void ali14xx_set_pio_mode(ide_drive_t *drive, const u8 pio)
 {
 	int driveNum;
 	int time1, time2;
@@ -117,8 +115,6 @@ static void ali14xx_tune_drive (ide_driv
 	unsigned long flags;
 	int bus_speed = system_bus_clock();
 
-	pio = ide_get_best_pio_mode(drive, pio, ALI_MAX_PIO);
-
 	/* calculate timing, according to PIO mode */
 	time1 = ide_pio_cycle_time(drive, pio);
 	time2 = ide_pio_timings[pio].active_time;
@@ -212,12 +208,12 @@ static int __init ali14xx_probe(void)
 
 	hwif->chipset = ide_ali14xx;
 	hwif->pio_mask = ATA_PIO4;
-	hwif->tuneproc = &ali14xx_tune_drive;
+	hwif->set_pio_mode = &ali14xx_set_pio_mode;
 	hwif->mate = mate;
 
 	mate->chipset = ide_ali14xx;
 	mate->pio_mask = ATA_PIO4;
-	mate->tuneproc = &ali14xx_tune_drive;
+	mate->set_pio_mode = &ali14xx_set_pio_mode;
 	mate->mate = hwif;
 	mate->channel = 1;
 
Index: b/drivers/ide/legacy/dtc2278.c
===================================================================
--- a/drivers/ide/legacy/dtc2278.c
+++ b/drivers/ide/legacy/dtc2278.c
@@ -67,12 +67,10 @@ static void sub22 (char b, char c)
 	}
 }
 
-static void tune_dtc2278 (ide_drive_t *drive, u8 pio)
+static void dtc2278_set_pio_mode(ide_drive_t *drive, const u8 pio)
 {
 	unsigned long flags;
 
-	pio = ide_get_best_pio_mode(drive, pio, 4);
-
 	if (pio >= 3) {
 		spin_lock_irqsave(&ide_lock, flags);
 		/*
@@ -124,7 +122,7 @@ static int __init dtc2278_probe(void)
 	hwif->serialized = 1;
 	hwif->chipset = ide_dtc2278;
 	hwif->pio_mask = ATA_PIO4;
-	hwif->tuneproc = &tune_dtc2278;
+	hwif->set_pio_mode = &dtc2278_set_pio_mode;
 	hwif->drives[0].no_unmask = 1;
 	hwif->drives[1].no_unmask = 1;
 	hwif->mate = mate;
Index: b/drivers/ide/legacy/ht6560b.c
===================================================================
--- a/drivers/ide/legacy/ht6560b.c
+++ b/drivers/ide/legacy/ht6560b.c
@@ -199,7 +199,7 @@ static int __init try_to_init_ht6560b(vo
 	return 1;
 }
 
-static u8 ht_pio2timings(ide_drive_t *drive, u8 pio)
+static u8 ht_pio2timings(ide_drive_t *drive, const u8 pio)
 {
 	int active_time, recovery_time;
 	int active_cycles, recovery_cycles;
@@ -208,7 +208,6 @@ static u8 ht_pio2timings(ide_drive_t *dr
         if (pio) {
 		unsigned int cycle_time;
 
-		pio = ide_get_best_pio_mode(drive, pio, 5);
 		cycle_time = ide_pio_cycle_time(drive, pio);
 
 		/*
@@ -277,7 +276,7 @@ static void ht_set_prefetch(ide_drive_t 
 #endif
 }
 
-static void tune_ht6560b (ide_drive_t *drive, u8 pio)
+static void ht6560b_set_pio_mode(ide_drive_t *drive, const u8 pio)
 {
 	unsigned long flags;
 	u8 timing;
@@ -333,15 +332,17 @@ int __init ht6560b_init(void)
 
 	hwif->chipset = ide_ht6560b;
 	hwif->selectproc = &ht6560b_selectproc;
+	hwif->host_flags = IDE_HFLAG_ABUSE_PREFETCH;
 	hwif->pio_mask = ATA_PIO5;
-	hwif->tuneproc = &tune_ht6560b;
+	hwif->set_pio_mode = &ht6560b_set_pio_mode;
 	hwif->serialized = 1;	/* is this needed? */
 	hwif->mate = mate;
 
 	mate->chipset = ide_ht6560b;
 	mate->selectproc = &ht6560b_selectproc;
+	mate->host_flags = IDE_HFLAG_ABUSE_PREFETCH;
 	mate->pio_mask = ATA_PIO5;
-	mate->tuneproc = &tune_ht6560b;
+	mate->set_pio_mode = &ht6560b_set_pio_mode;
 	mate->serialized = 1;	/* is this needed? */
 	mate->mate = hwif;
 	mate->channel = 1;
Index: b/drivers/ide/legacy/qd65xx.c
===================================================================
--- a/drivers/ide/legacy/qd65xx.c
+++ b/drivers/ide/legacy/qd65xx.c
@@ -224,15 +224,14 @@ static void qd_set_timing (ide_drive_t *
 	printk(KERN_DEBUG "%s: %#x\n", drive->name, timing);
 }
 
-/*
- * qd6500_tune_drive
- */
-
-static void qd6500_tune_drive (ide_drive_t *drive, u8 pio)
+static void qd6500_set_pio_mode(ide_drive_t *drive, const u8 pio)
 {
 	int active_time   = 175;
 	int recovery_time = 415; /* worst case values from the dos driver */
 
+	/*
+	 * FIXME: use "pio" value
+	 */
 	if (drive->id && !qd_find_disk_type(drive, &active_time, &recovery_time)
 		&& drive->id->tPIO && (drive->id->field_valid & 0x02)
 		&& drive->id->eide_pio >= 240) {
@@ -246,11 +245,7 @@ static void qd6500_tune_drive (ide_drive
 	qd_set_timing(drive, qd6500_compute_timing(HWIF(drive), active_time, recovery_time));
 }
 
-/*
- * qd6580_tune_drive
- */
-
-static void qd6580_tune_drive (ide_drive_t *drive, u8 pio)
+static void qd6580_set_pio_mode(ide_drive_t *drive, const u8 pio)
 {
 	int base = HWIF(drive)->select_data;
 	unsigned int cycle_time;
@@ -258,7 +253,6 @@ static void qd6580_tune_drive (ide_drive
 	int recovery_time = 415; /* worst case values from the dos driver */
 
 	if (drive->id && !qd_find_disk_type(drive, &active_time, &recovery_time)) {
-		pio = ide_get_best_pio_mode(drive, pio, 4);
 		cycle_time = ide_pio_cycle_time(drive, pio);
 
 		switch (pio) {
@@ -335,8 +329,7 @@ static int __init qd_testreg(int port)
  */
 
 static void __init qd_setup(ide_hwif_t *hwif, int base, int config,
-			    unsigned int data0, unsigned int data1,
-			    void (*tuneproc) (ide_drive_t *, u8 pio))
+			    unsigned int data0, unsigned int data1)
 {
 	hwif->chipset = ide_qd65xx;
 	hwif->channel = hwif->index;
@@ -347,8 +340,6 @@ static void __init qd_setup(ide_hwif_t *
 	hwif->drives[0].io_32bit =
 	hwif->drives[1].io_32bit = 1;
 	hwif->pio_mask = ATA_PIO4;
-	hwif->tuneproc = tuneproc;
-	probe_hwif_init(hwif);
 }
 
 /*
@@ -361,7 +352,7 @@ static void __exit qd_unsetup(ide_hwif_t
 {
 	u8 config = hwif->config_data;
 	int base = hwif->select_data;
-	void *tuneproc = (void *) hwif->tuneproc;
+	void *set_pio_mode = (void *)hwif->set_pio_mode;
 
 	if (hwif->chipset != ide_qd65xx)
 		return;
@@ -369,12 +360,12 @@ static void __exit qd_unsetup(ide_hwif_t
 	printk(KERN_NOTICE "%s: back to defaults\n", hwif->name);
 
 	hwif->selectproc = NULL;
-	hwif->tuneproc = NULL;
+	hwif->set_pio_mode = NULL;
 
-	if (tuneproc == (void *) qd6500_tune_drive) {
+	if (set_pio_mode == (void *)qd6500_set_pio_mode) {
 		// will do it for both
 		qd_write_reg(QD6500_DEF_DATA, QD_TIMREG(&hwif->drives[0]));
-	} else if (tuneproc == (void *) qd6580_tune_drive) {
+	} else if (set_pio_mode == (void *)qd6580_set_pio_mode) {
 		if (QD_CONTROL(hwif) & QD_CONTR_SEC_DISABLED) {
 			qd_write_reg(QD6580_DEF_DATA, QD_TIMREG(&hwif->drives[0]));
 			qd_write_reg(QD6580_DEF_DATA2, QD_TIMREG(&hwif->drives[1]));
@@ -424,8 +415,11 @@ static int __init qd_probe(int base)
 			return 1;
 		}
 
-		qd_setup(hwif, base, config, QD6500_DEF_DATA, QD6500_DEF_DATA,
-			 &qd6500_tune_drive);
+		qd_setup(hwif, base, config, QD6500_DEF_DATA, QD6500_DEF_DATA);
+
+		hwif->set_pio_mode = &qd6500_set_pio_mode;
+
+		probe_hwif_init(hwif);
 
 		ide_proc_register_port(hwif);
 
@@ -455,8 +449,12 @@ static int __init qd_probe(int base)
 			printk(KERN_INFO "%s: qd6580: single IDE board\n",
 					 hwif->name);
 			qd_setup(hwif, base, config | (control << 8),
-				 QD6580_DEF_DATA, QD6580_DEF_DATA2,
-				 &qd6580_tune_drive);
+				 QD6580_DEF_DATA, QD6580_DEF_DATA2);
+
+			hwif->set_pio_mode = &qd6580_set_pio_mode;
+
+			probe_hwif_init(hwif);
+
 			qd_write_reg(QD_DEF_CONTR,QD_CONTROL_PORT);
 
 			ide_proc_register_port(hwif);
@@ -472,11 +470,19 @@ static int __init qd_probe(int base)
 					hwif->name, mate->name);
 
 			qd_setup(hwif, base, config | (control << 8),
-				 QD6580_DEF_DATA, QD6580_DEF_DATA,
-				 &qd6580_tune_drive);
+				 QD6580_DEF_DATA, QD6580_DEF_DATA);
+
+			hwif->set_pio_mode = &qd6580_set_pio_mode;
+
+			probe_hwif_init(hwif);
+
 			qd_setup(mate, base, config | (control << 8),
-				 QD6580_DEF_DATA2, QD6580_DEF_DATA2,
-				 &qd6580_tune_drive);
+				 QD6580_DEF_DATA2, QD6580_DEF_DATA2);
+
+			mate->set_pio_mode = &qd6580_set_pio_mode;
+
+			probe_hwif_init(mate);
+
 			qd_write_reg(QD_DEF_CONTR,QD_CONTROL_PORT);
 
 			ide_proc_register_port(hwif);
Index: b/drivers/ide/legacy/umc8672.c
===================================================================
--- a/drivers/ide/legacy/umc8672.c
+++ b/drivers/ide/legacy/umc8672.c
@@ -105,12 +105,11 @@ static void umc_set_speeds (u8 speeds[])
 		speeds[0], speeds[1], speeds[2], speeds[3]);
 }
 
-static void tune_umc (ide_drive_t *drive, u8 pio)
+static void umc_set_pio_mode(ide_drive_t *drive, const u8 pio)
 {
 	unsigned long flags;
 	ide_hwgroup_t *hwgroup = ide_hwifs[HWIF(drive)->index^1].hwgroup;
 
-	pio = ide_get_best_pio_mode(drive, pio, 4);
 	printk("%s: setting umc8672 to PIO mode%d (speed %d)\n",
 		drive->name, pio, pio_to_umc[pio]);
 	spin_lock_irqsave(&ide_lock, flags);
@@ -150,12 +149,12 @@ static int __init umc8672_probe(void)
 
 	hwif->chipset = ide_umc8672;
 	hwif->pio_mask = ATA_PIO4;
-	hwif->tuneproc = &tune_umc;
+	hwif->set_pio_mode = &umc_set_pio_mode;
 	hwif->mate = mate;
 
 	mate->chipset = ide_umc8672;
 	mate->pio_mask = ATA_PIO4;
-	mate->tuneproc = &tune_umc;
+	mate->set_pio_mode = &umc_set_pio_mode;
 	mate->mate = hwif;
 	mate->channel = 1;
 
Index: b/drivers/ide/mips/au1xxx-ide.c
===================================================================
--- a/drivers/ide/mips/au1xxx-ide.c
+++ b/drivers/ide/mips/au1xxx-ide.c
@@ -99,18 +99,12 @@ void auide_outsw(unsigned long port, voi
 
 #endif
 
-static void auide_tune_drive(ide_drive_t *drive, byte pio)
+static void au1xxx_set_pio_mode(ide_drive_t *drive, const u8 pio)
 {
 	int mem_sttime;
 	int mem_stcfg;
 	u8 speed;
 
-	/* get the best pio mode for the drive */
-	pio = ide_get_best_pio_mode(drive, pio, 4);
-
-	printk(KERN_INFO "%s: setting Au1XXX IDE to PIO mode%d\n",
-	       drive->name, pio);
-
 	mem_sttime = 0;
 	mem_stcfg  = au_readl(MEM_STCFG2);
 
@@ -184,7 +178,7 @@ static int auide_tune_chipset(ide_drive_
 	mem_stcfg  = au_readl(MEM_STCFG2);
 
 	if (speed >= XFER_PIO_0 && speed <= XFER_PIO_4) {
-		auide_tune_drive(drive, speed - XFER_PIO_0);
+		au1xxx_set_pio_mode(drive, speed - XFER_PIO_0);
 		return 0;
 	}
 
@@ -712,7 +706,7 @@ static int au_ide_probe(struct device *d
 	hwif->OUTSW                     = auide_outsw;
 #endif
 
-	hwif->tuneproc                  = &auide_tune_drive;
+	hwif->set_pio_mode		= &au1xxx_set_pio_mode;
 	hwif->speedproc                 = &auide_tune_chipset;
 
 #ifdef CONFIG_BLK_DEV_IDE_AU1XXX_MDMA2_DBDMA
Index: b/drivers/ide/pci/aec62xx.c
===================================================================
--- a/drivers/ide/pci/aec62xx.c
+++ b/drivers/ide/pci/aec62xx.c
@@ -138,9 +138,8 @@ static int aec6260_tune_chipset(ide_driv
 	return(ide_config_drive_speed(drive, speed));
 }
 
-static void aec62xx_tune_drive (ide_drive_t *drive, u8 pio)
+static void aec_set_pio_mode(ide_drive_t *drive, const u8 pio)
 {
-	pio = ide_get_best_pio_mode(drive, pio, 4);
 	(void) HWIF(drive)->speedproc(drive, pio + XFER_PIO_0);
 }
 
@@ -150,7 +149,7 @@ static int aec62xx_config_drive_xfer_rat
 		return 0;
 
 	if (ide_use_fast_pio(drive))
-		aec62xx_tune_drive(drive, 255);
+		ide_set_max_pio(drive);
 
 	return -1;
 }
@@ -201,7 +200,7 @@ static void __devinit init_hwif_aec62xx(
 	u8 reg54 = 0,  mask	= hwif->channel ? 0xf0 : 0x0f;
 	unsigned long flags;
 
-	hwif->tuneproc = &aec62xx_tune_drive;
+	hwif->set_pio_mode = &aec_set_pio_mode;
 
 	if (dev->device == PCI_DEVICE_ID_ARTOP_ATP850UF) {
 		if(hwif->mate)
Index: b/drivers/ide/pci/alim15x3.c
===================================================================
--- a/drivers/ide/pci/alim15x3.c
+++ b/drivers/ide/pci/alim15x3.c
@@ -283,17 +283,14 @@ static int ali_get_info (char *buffer, c
 #endif  /* defined(DISPLAY_ALI_TIMINGS) && defined(CONFIG_IDE_PROC_FS) */
 
 /**
- *	ali15x3_tune_pio	-	set up chipset for PIO mode
- *	@drive: drive to tune
- *	@pio: desired mode
- *
- *	Select the best PIO mode for the drive in question.
- *	Then program the controller for this mode.
+ *	ali_tune_pio	-	set host controller for PIO mode
+ *	@drive: drive
+ *	@pio: PIO mode number
  *
- *	Returns the PIO mode programmed.
+ *	Program the controller for the given PIO mode.
  */
- 
-static u8 ali15x3_tune_pio (ide_drive_t *drive, u8 pio)
+
+static void ali_tune_pio(ide_drive_t *drive, const u8 pio)
 {
 	ide_hwif_t *hwif = HWIF(drive);
 	struct pci_dev *dev = hwif->pci_dev;
@@ -306,7 +303,6 @@ static u8 ali15x3_tune_pio (ide_drive_t 
 	u8 cd_dma_fifo = 0;
 	int unit = drive->select.b.unit & 1;
 
-	pio = ide_get_best_pio_mode(drive, pio, 5);
 	s_time = ide_pio_timings[pio].setup_time;
 	a_time = ide_pio_timings[pio].active_time;
 	if ((s_clc = (s_time * bus_speed + 999) / 1000) >= 8)
@@ -359,22 +355,20 @@ static u8 ali15x3_tune_pio (ide_drive_t 
 	 * { 25,   70,     25  },   PIO Mode 4 with IORDY  ns
 	 * { 20,   50,     30  }    PIO Mode 5 with IORDY (nonstandard)
 	 */
-
-	return pio;
 }
 
 /**
- *	ali15x3_tune_drive	-	set up drive for PIO mode
+ *	ali_set_pio_mode	-	set up drive for PIO mode
  *	@drive: drive to tune
  *	@pio: desired mode
  *
- *	Program the controller with the best PIO timing for the given drive.
+ *	Program the controller with the desired PIO timing for the given drive.
  *	Then set up the drive itself.
  */
 
-static void ali15x3_tune_drive (ide_drive_t *drive, u8 pio)
+static void ali_set_pio_mode(ide_drive_t *drive, const u8 pio)
 {
-	pio = ali15x3_tune_pio(drive, pio);
+	ali_tune_pio(drive, pio);
 	(void) ide_config_drive_speed(drive, XFER_PIO_0 + pio);
 }
 
@@ -437,7 +431,7 @@ static int ali15x3_tune_chipset(ide_driv
 		pci_write_config_byte(dev, m5229_udma, tmpbyte);
 
 		if (speed < XFER_SW_DMA_0)
-			(void) ali15x3_tune_pio(drive, speed - XFER_PIO_0);
+			ali_tune_pio(drive, speed - XFER_PIO_0);
 	} else {
 		pci_read_config_byte(dev, m5229_udma, &tmpbyte);
 		tmpbyte &= (0x0f << ((1-unit) << 2));
@@ -470,7 +464,7 @@ static int ali15x3_config_drive_for_dma(
 	if (ide_tune_dma(drive))
 		return 0;
 
-	ali15x3_tune_drive(drive, 255);
+	ide_set_max_pio(drive);
 
 	return -1;
 }
@@ -693,7 +687,7 @@ static u8 __devinit ata66_ali15x3(ide_hw
 static void __devinit init_hwif_common_ali15x3 (ide_hwif_t *hwif)
 {
 	hwif->autodma = 0;
-	hwif->tuneproc = &ali15x3_tune_drive;
+	hwif->set_pio_mode = &ali_set_pio_mode;
 	hwif->speedproc = &ali15x3_tune_chipset;
 	hwif->udma_filter = &ali_udma_filter;
 
Index: b/drivers/ide/pci/amd74xx.c
===================================================================
--- a/drivers/ide/pci/amd74xx.c
+++ b/drivers/ide/pci/amd74xx.c
@@ -266,16 +266,12 @@ static int amd_set_drive(ide_drive_t *dr
 }
 
 /*
- * amd74xx_tune_drive() is a callback from upper layers for
- * PIO-only tuning.
+ * amd_set_pio_mode() is a callback from upper layers for PIO-only tuning.
  */
 
-static void amd74xx_tune_drive(ide_drive_t *drive, u8 pio)
+static void amd_set_pio_mode(ide_drive_t *drive, const u8 pio)
 {
-	if (pio == 255)
-		pio = ide_get_best_pio_mode(drive, 255, 5);
-
-	amd_set_drive(drive, XFER_PIO_0 + min_t(byte, pio, 5));
+	amd_set_drive(drive, XFER_PIO_0 + pio);
 }
 
 static int amd74xx_ide_dma_check(ide_drive_t *drive)
@@ -283,7 +279,7 @@ static int amd74xx_ide_dma_check(ide_dri
 	u8 speed = ide_max_dma_mode(drive);
 
 	if (speed == 0) {
-		amd74xx_tune_drive(drive, 255);
+		ide_set_max_pio(drive);
 		return -1;
 	}
 
@@ -409,7 +405,7 @@ static void __devinit init_hwif_amd74xx(
 
 	hwif->autodma = 0;
 
-	hwif->tuneproc = &amd74xx_tune_drive;
+	hwif->set_pio_mode = &amd_set_pio_mode;
 	hwif->speedproc = &amd_set_drive;
 
 	for (i = 0; i < 2; i++) {
Index: b/drivers/ide/pci/atiixp.c
===================================================================
--- a/drivers/ide/pci/atiixp.c
+++ b/drivers/ide/pci/atiixp.c
@@ -153,9 +153,8 @@ static void atiixp_tune_pio(ide_drive_t 
 	spin_unlock_irqrestore(&atiixp_lock, flags);
 }
 
-static void atiixp_tuneproc(ide_drive_t *drive, u8 pio)
+static void atiixp_set_pio_mode(ide_drive_t *drive, const u8 pio)
 {
-	pio = ide_get_best_pio_mode(drive, pio, 4);
 	atiixp_tune_pio(drive, pio);
 	(void)ide_config_drive_speed(drive, XFER_PIO_0 + pio);
 }
@@ -231,7 +230,7 @@ static int atiixp_dma_check(ide_drive_t 
 		return 0;
 
 	if (ide_use_fast_pio(drive))
-		atiixp_tuneproc(drive, 255);
+		ide_set_max_pio(drive);
 
 	return -1;
 }
@@ -254,7 +253,7 @@ static void __devinit init_hwif_atiixp(i
 		hwif->irq = ch ? 15 : 14;
 
 	hwif->autodma = 0;
-	hwif->tuneproc = &atiixp_tuneproc;
+	hwif->set_pio_mode = &atiixp_set_pio_mode;
 	hwif->speedproc = &atiixp_speedproc;
 	hwif->drives[0].autotune = 1;
 	hwif->drives[1].autotune = 1;
Index: b/drivers/ide/pci/cmd640.c
===================================================================
--- a/drivers/ide/pci/cmd640.c
+++ b/drivers/ide/pci/cmd640.c
@@ -628,45 +628,40 @@ static void cmd640_set_mode (unsigned in
 	program_drive_counts (index);
 }
 
-/*
- * Drive PIO mode selection:
- */
-static void cmd640_tune_drive (ide_drive_t *drive, u8 mode_wanted)
+static void cmd640_set_pio_mode(ide_drive_t *drive, const u8 pio)
 {
 	unsigned int index = 0, cycle_time;
 	u8 b;
 
 	while (drive != cmd_drives[index]) {
 		if (++index > 3) {
-			printk("%s: bad news in cmd640_tune_drive\n", drive->name);
+			printk(KERN_ERR "%s: bad news in %s\n",
+					drive->name, __FUNCTION__);
 			return;
 		}
 	}
-	switch (mode_wanted) {
+	switch (pio) {
 		case 6: /* set fast-devsel off */
 		case 7: /* set fast-devsel on */
-			mode_wanted &= 1;
 			b = get_cmd640_reg(CNTRL) & ~0x27;
-			if (mode_wanted)
+			if (pio & 1)
 				b |= 0x27;
 			put_cmd640_reg(CNTRL, b);
-			printk("%s: %sabled cmd640 fast host timing (devsel)\n", drive->name, mode_wanted ? "en" : "dis");
+			printk("%s: %sabled cmd640 fast host timing (devsel)\n", drive->name, (pio & 1) ? "en" : "dis");
 			return;
 
 		case 8: /* set prefetch off */
 		case 9: /* set prefetch on */
-			mode_wanted &= 1;
-			set_prefetch_mode(index, mode_wanted);
-			printk("%s: %sabled cmd640 prefetch\n", drive->name, mode_wanted ? "en" : "dis");
+			set_prefetch_mode(index, pio & 1);
+			printk("%s: %sabled cmd640 prefetch\n", drive->name, (pio & 1) ? "en" : "dis");
 			return;
 	}
 
-	mode_wanted = ide_get_best_pio_mode(drive, mode_wanted, 5);
-	cycle_time = ide_pio_cycle_time(drive, mode_wanted);
-	cmd640_set_mode(index, mode_wanted, cycle_time);
+	cycle_time = ide_pio_cycle_time(drive, pio);
+	cmd640_set_mode(index, pio, cycle_time);
 
 	printk("%s: selected cmd640 PIO mode%d (%dns)",
-		drive->name, mode_wanted, cycle_time);
+		drive->name, pio, cycle_time);
 
 	display_clocks(index);
 }
@@ -766,8 +761,10 @@ int __init ide_probe_for_cmd640x (void)
 	       cmd_hwif0->name, 'a' + cmd640_chip_version - 1, bus_type, cfr);
 	cmd_hwif0->chipset = ide_cmd640;
 #ifdef CONFIG_BLK_DEV_CMD640_ENHANCED
+	cmd_hwif0->host_flags = IDE_HFLAG_ABUSE_PREFETCH |
+				IDE_HFLAG_ABUSE_FAST_DEVSEL;
 	cmd_hwif0->pio_mask = ATA_PIO5;
-	cmd_hwif0->tuneproc = &cmd640_tune_drive;
+	cmd_hwif0->set_pio_mode = &cmd640_set_pio_mode;
 #endif /* CONFIG_BLK_DEV_CMD640_ENHANCED */
 
 	/*
@@ -822,8 +819,10 @@ int __init ide_probe_for_cmd640x (void)
 		cmd_hwif1->mate = cmd_hwif0;
 		cmd_hwif1->channel = 1;
 #ifdef CONFIG_BLK_DEV_CMD640_ENHANCED
+		cmd_hwif1->host_flags = IDE_HFLAG_ABUSE_PREFETCH |
+					IDE_HFLAG_ABUSE_FAST_DEVSEL;
 		cmd_hwif1->pio_mask = ATA_PIO5;
-		cmd_hwif1->tuneproc = &cmd640_tune_drive;
+		cmd_hwif1->set_pio_mode = &cmd640_set_pio_mode;
 #endif /* CONFIG_BLK_DEV_CMD640_ENHANCED */
 	}
 	printk(KERN_INFO "%s: %sserialized, secondary interface %s\n", cmd_hwif1->name,
Index: b/drivers/ide/pci/cmd64x.c
===================================================================
--- a/drivers/ide/pci/cmd64x.c
+++ b/drivers/ide/pci/cmd64x.c
@@ -214,28 +214,25 @@ static void program_cycle_times (ide_dri
 }
 
 /*
- * This routine selects drive's best PIO mode and writes into the chipset
- * registers setup/active/recovery timings.
+ * This routine writes into the chipset registers
+ * PIO setup/active/recovery timings.
  */
-static u8 cmd64x_tune_pio (ide_drive_t *drive, u8 mode_wanted)
+static void cmd64x_tune_pio(ide_drive_t *drive, const u8 pio)
 {
 	ide_hwif_t *hwif	= HWIF(drive);
 	struct pci_dev *dev	= hwif->pci_dev;
 	unsigned int cycle_time;
-	u8 pio_mode, setup_count, arttim = 0;
+	u8 setup_count, arttim = 0;
+
 	static const u8 setup_values[] = {0x40, 0x40, 0x40, 0x80, 0, 0xc0};
 	static const u8 arttim_regs[4] = {ARTTIM0, ARTTIM1, ARTTIM23, ARTTIM23};
 
-	pio_mode = ide_get_best_pio_mode(drive, mode_wanted, 5);
-	cycle_time = ide_pio_cycle_time(drive, pio_mode);
-
-	cmdprintk("%s: PIO mode wanted %d, selected %d (%d ns)\n",
-		  drive->name, mode_wanted, pio_mode, cycle_time);
+	cycle_time = ide_pio_cycle_time(drive, pio);
 
 	program_cycle_times(drive, cycle_time,
-			    ide_pio_timings[pio_mode].active_time);
+			    ide_pio_timings[pio].active_time);
 
-	setup_count = quantize_timing(ide_pio_timings[pio_mode].setup_time,
+	setup_count = quantize_timing(ide_pio_timings[pio].setup_time,
 				      1000 / system_bus_clock());
 
 	/*
@@ -266,16 +263,14 @@ static u8 cmd64x_tune_pio (ide_drive_t *
 	arttim |= setup_values[setup_count];
 	(void) pci_write_config_byte(dev, arttim_regs[drive->dn], arttim);
 	cmdprintk("Write 0x%02x to reg 0x%x\n", arttim, arttim_regs[drive->dn]);
-
-	return pio_mode;
 }
 
 /*
  * Attempts to set drive's PIO mode.
- * Special cases are 8: prefetch off, 9: prefetch on (both never worked),
- * and 255: auto-select best mode (used at boot time).
+ * Special cases are 8: prefetch off, 9: prefetch on (both never worked)
  */
-static void cmd64x_tune_drive (ide_drive_t *drive, u8 pio)
+
+static void cmd64x_set_pio_mode(ide_drive_t *drive, const u8 pio)
 {
 	/*
 	 * Filter out the prefetch control values
@@ -284,7 +279,7 @@ static void cmd64x_tune_drive (ide_drive
 	if (pio == 8 || pio == 9)
 		return;
 
-	pio = cmd64x_tune_pio(drive, pio);
+	cmd64x_tune_pio(drive, pio);
 	(void) ide_config_drive_speed(drive, XFER_PIO_0 + pio);
 }
 
@@ -334,7 +329,7 @@ static int cmd64x_tune_chipset(ide_drive
 	case XFER_PIO_2:
 	case XFER_PIO_1:
 	case XFER_PIO_0:
-		(void) cmd64x_tune_pio(drive, speed - XFER_PIO_0);
+		cmd64x_tune_pio(drive, speed - XFER_PIO_0);
 		break;
 	default:
 		return 1;
@@ -352,7 +347,7 @@ static int cmd64x_config_drive_for_dma (
 		return 0;
 
 	if (ide_use_fast_pio(drive))
-		cmd64x_tune_drive(drive, 255);
+		ide_set_max_pio(drive);
 
 	return -1;
 }
@@ -536,7 +531,7 @@ static void __devinit init_hwif_cmd64x(i
 
 	pci_read_config_byte(dev, PCI_REVISION_ID, &rev);
 
-	hwif->tuneproc  = &cmd64x_tune_drive;
+	hwif->set_pio_mode = &cmd64x_set_pio_mode;
 	hwif->speedproc = &cmd64x_tune_chipset;
 
 	hwif->drives[0].autotune = hwif->drives[1].autotune = 1;
@@ -620,6 +615,7 @@ static ide_pci_device_t cmd64x_chipsets[
 		.autodma	= AUTODMA,
 		.enablebits	= {{0x00,0x00,0x00}, {0x51,0x08,0x08}},
 		.bootable	= ON_BOARD,
+		.host_flags	= IDE_HFLAG_ABUSE_PREFETCH,
 		.pio_mask	= ATA_PIO5,
 		.udma_mask	= 0x00, /* no udma */
 	},{	/* 1 */
@@ -630,6 +626,7 @@ static ide_pci_device_t cmd64x_chipsets[
 		.autodma	= AUTODMA,
 		.enablebits	= {{0x51,0x04,0x04}, {0x51,0x08,0x08}},
 		.bootable	= ON_BOARD,
+		.host_flags	= IDE_HFLAG_ABUSE_PREFETCH,
 		.pio_mask	= ATA_PIO5,
 		.udma_mask	= 0x07, /* udma0-2 */
 	},{	/* 2 */
@@ -640,6 +637,7 @@ static ide_pci_device_t cmd64x_chipsets[
 		.autodma	= AUTODMA,
 		.enablebits	= {{0x51,0x04,0x04}, {0x51,0x08,0x08}},
 		.bootable	= ON_BOARD,
+		.host_flags	= IDE_HFLAG_ABUSE_PREFETCH,
 		.pio_mask	= ATA_PIO5,
 		.udma_mask	= 0x1f, /* udma0-4 */
 	},{	/* 3 */
@@ -650,6 +648,7 @@ static ide_pci_device_t cmd64x_chipsets[
 		.autodma	= AUTODMA,
 		.enablebits	= {{0x51,0x04,0x04}, {0x51,0x08,0x08}},
 		.bootable	= ON_BOARD,
+		.host_flags	= IDE_HFLAG_ABUSE_PREFETCH,
 		.pio_mask	= ATA_PIO5,
 		.udma_mask	= 0x3f, /* udma0-5 */
 	}
Index: b/drivers/ide/pci/cs5520.c
===================================================================
--- a/drivers/ide/pci/cs5520.c
+++ b/drivers/ide/pci/cs5520.c
@@ -122,17 +122,16 @@ static int cs5520_tune_chipset(ide_drive
 
 	return error;
 }	
-	
-static void cs5520_tune_drive(ide_drive_t *drive, u8 pio)
+
+static void cs5520_set_pio_mode(ide_drive_t *drive, const u8 pio)
 {
-	pio = ide_get_best_pio_mode(drive, pio, 4);
-	cs5520_tune_chipset(drive, (XFER_PIO_0 + pio));
+	cs5520_tune_chipset(drive, XFER_PIO_0 + pio);
 }
 
 static int cs5520_config_drive_xfer_rate(ide_drive_t *drive)
 {
 	/* Tune the drive for PIO modes up to PIO 4 */	
-	cs5520_tune_drive(drive, 255);
+	ide_set_max_pio(drive);
 
 	/* Then tell the core to use DMA operations */
 	return 0;
@@ -164,7 +163,7 @@ static int cs5520_dma_on(ide_drive_t *dr
 
 static void __devinit init_hwif_cs5520(ide_hwif_t *hwif)
 {
-	hwif->tuneproc = &cs5520_tune_drive;
+	hwif->set_pio_mode = &cs5520_set_pio_mode;
 	hwif->speedproc = &cs5520_tune_chipset;
 	hwif->ide_dma_check = &cs5520_config_drive_xfer_rate;
 	hwif->ide_dma_on = &cs5520_dma_on;
Index: b/drivers/ide/pci/cs5530.c
===================================================================
--- a/drivers/ide/pci/cs5530.c
+++ b/drivers/ide/pci/cs5530.c
@@ -71,19 +71,18 @@ static void cs5530_tunepio(ide_drive_t *
 }
 
 /**
- *	cs5530_tuneproc		-	select/set PIO modes
+ *	cs5530_set_pio_mode	-	set PIO mode
+ *	@drive: drive
+ *	@pio: PIO mode number
  *
- *	cs5530_tuneproc() handles selection/setting of PIO modes
- *	for both the chipset and drive.
+ *	Handles setting of PIO mode for both the chipset and drive.
  *
- *	The ide_init_cs5530() routine guarantees that all drives
+ *	The init_hwif_cs5530() routine guarantees that all drives
  *	will have valid default PIO timings set up before we get here.
  */
 
-static void cs5530_tuneproc (ide_drive_t *drive, u8 pio)	/* pio=255 means "autotune" */
+static void cs5530_set_pio_mode(ide_drive_t *drive, const u8 pio)
 {
-	pio = ide_get_best_pio_mode(drive, pio, 4);
-
 	if (cs5530_set_xfer_mode(drive, XFER_PIO_0 + pio) == 0)
 		cs5530_tunepio(drive, pio);
 }
@@ -303,7 +302,7 @@ static void __devinit init_hwif_cs5530 (
 	if (hwif->mate)
 		hwif->serialized = hwif->mate->serialized = 1;
 
-	hwif->tuneproc = &cs5530_tuneproc;
+	hwif->set_pio_mode = &cs5530_set_pio_mode;
 	hwif->speedproc = &cs5530_tune_chipset;
 
 	basereg = CS5530_BASEREG(hwif);
Index: b/drivers/ide/pci/cs5535.c
===================================================================
--- a/drivers/ide/pci/cs5535.c
+++ b/drivers/ide/pci/cs5535.c
@@ -147,16 +147,16 @@ static int cs5535_set_drive(ide_drive_t 
 	return 0;
 }
 
-/****
- *	cs5535_tuneproc    -       PIO setup
- *	@drive: drive to set up
- *	@pio: mode to use (255 for 'best possible')
+/**
+ *	cs5535_set_pio_mode	-	PIO setup
+ *	@drive: drive
+ *	@pio: PIO mode number
  *
  *	A callback from the upper layers for PIO-only tuning.
  */
-static void cs5535_tuneproc(ide_drive_t *drive, u8 pio)
+
+static void cs5535_set_pio_mode(ide_drive_t *drive, const u8 pio)
 {
-	pio = ide_get_best_pio_mode(drive, pio, 4);
 	ide_config_drive_speed(drive, XFER_PIO_0 + pio);
 	cs5535_set_speed(drive, XFER_PIO_0 + pio);
 }
@@ -169,7 +169,7 @@ static int cs5535_dma_check(ide_drive_t 
 		return 0;
 
 	if (ide_use_fast_pio(drive))
-		cs5535_tuneproc(drive, 255);
+		ide_set_max_pio(drive);
 
 	return -1;
 }
@@ -198,7 +198,7 @@ static void __devinit init_hwif_cs5535(i
 
 	hwif->autodma = 0;
 
-	hwif->tuneproc = &cs5535_tuneproc;
+	hwif->set_pio_mode = &cs5535_set_pio_mode;
 	hwif->speedproc = &cs5535_set_drive;
 	hwif->ide_dma_check = &cs5535_dma_check;
 
Index: b/drivers/ide/pci/cy82c693.c
===================================================================
--- a/drivers/ide/pci/cy82c693.c
+++ b/drivers/ide/pci/cy82c693.c
@@ -97,9 +97,6 @@
 #define CY82_INDEX_CHANNEL1	0x31
 #define CY82_INDEX_TIMEOUT	0x32
 
-/* the max PIO mode - from datasheet */
-#define CY82C693_MAX_PIO	4
-
 /* the min and max PCI bus speed in MHz - from datasheet */
 #define CY82C963_MIN_BUS_SPEED	25
 #define CY82C963_MAX_BUS_SPEED	33
@@ -148,9 +145,6 @@ static void compute_clocks (u8 pio, pio_
 	 * so you can play with the idebus=xx parameter
 	 */
 
-	if (pio > CY82C693_MAX_PIO)
-		pio = CY82C693_MAX_PIO;
-
 	/* let's calc the address setup time clocks */
 	p_pclk->address_time = (u8)calc_clk(ide_pio_timings[pio].setup_time, bus_speed);
 
@@ -269,10 +263,7 @@ static int cy82c693_ide_dma_on (ide_driv
         return __ide_dma_on(drive);
 }
 
-/*
- * tune ide drive - set PIO mode
- */
-static void cy82c693_tune_drive (ide_drive_t *drive, u8 pio)
+static void cy82c693_set_pio_mode(ide_drive_t *drive, const u8 pio)
 {
 	ide_hwif_t *hwif = HWIF(drive);
 	struct pci_dev *dev = hwif->pci_dev;
@@ -329,13 +320,6 @@ static void cy82c693_tune_drive (ide_dri
 		addrCtrl, pclk.time_16r, pclk.time_16w, pclk.time_8);
 #endif /* CY82C693_DEBUG_LOGS */
 
-	/* first let's calc the pio modes */
-	pio = ide_get_best_pio_mode(drive, pio, CY82C693_MAX_PIO);
-
-#if CY82C693_DEBUG_INFO
-	printk (KERN_INFO "%s: Selected PIO mode %d\n", drive->name, pio);
-#endif /* CY82C693_DEBUG_INFO */
-
 	/* let's calc the values for this PIO mode */
 	compute_clocks(pio, &pclk);
 
@@ -447,7 +431,7 @@ static void __devinit init_hwif_cy82c693
 	hwif->autodma = 0;
 
 	hwif->chipset = ide_cy82c693;
-	hwif->tuneproc = &cy82c693_tune_drive;
+	hwif->set_pio_mode = &cy82c693_set_pio_mode;
 
 	if (!hwif->dma_base) {
 		hwif->drives[0].autotune = 1;
Index: b/drivers/ide/pci/hpt34x.c
===================================================================
--- a/drivers/ide/pci/hpt34x.c
+++ b/drivers/ide/pci/hpt34x.c
@@ -77,9 +77,8 @@ static int hpt34x_tune_chipset(ide_drive
 	return(ide_config_drive_speed(drive, speed));
 }
 
-static void hpt34x_tune_drive (ide_drive_t *drive, u8 pio)
+static void hpt34x_set_pio_mode(ide_drive_t *drive, const u8 pio)
 {
-	pio = ide_get_best_pio_mode(drive, pio, 5);
 	(void) hpt34x_tune_chipset(drive, (XFER_PIO_0 + pio));
 }
 
@@ -95,7 +94,7 @@ static int hpt34x_config_drive_xfer_rate
 #endif
 
 	if (ide_use_fast_pio(drive))
-		hpt34x_tune_drive(drive, 255);
+		ide_set_max_pio(drive);
 
 	return -1;
 }
@@ -149,7 +148,7 @@ static void __devinit init_hwif_hpt34x(i
 
 	hwif->autodma = 0;
 
-	hwif->tuneproc = &hpt34x_tune_drive;
+	hwif->set_pio_mode = &hpt34x_set_pio_mode;
 	hwif->speedproc = &hpt34x_tune_chipset;
 	hwif->drives[0].autotune = 1;
 	hwif->drives[1].autotune = 1;
Index: b/drivers/ide/pci/hpt366.c
===================================================================
--- a/drivers/ide/pci/hpt366.c
+++ b/drivers/ide/pci/hpt366.c
@@ -640,9 +640,8 @@ static int hpt3xx_tune_chipset(ide_drive
 		return hpt36x_tune_chipset(drive, speed);
 }
 
-static void hpt3xx_tune_drive(ide_drive_t *drive, u8 pio)
+static void hpt3xx_set_pio_mode(ide_drive_t *drive, const u8 pio)
 {
-	pio = ide_get_best_pio_mode(drive, pio, 4);
 	(void) hpt3xx_tune_chipset (drive, XFER_PIO_0 + pio);
 }
 
@@ -704,7 +703,7 @@ static int hpt366_config_drive_xfer_rate
 		return 0;
 
 	if (ide_use_fast_pio(drive))
-		hpt3xx_tune_drive(drive, 255);
+		ide_set_max_pio(drive);
 
 	return -1;
 }
@@ -1218,7 +1217,7 @@ static void __devinit init_hwif_hpt366(i
 	/* Cache the channel's MISC. control registers' offset */
 	hwif->select_data		= hwif->channel ? 0x54 : 0x50;
 
-	hwif->tuneproc			= &hpt3xx_tune_drive;
+	hwif->set_pio_mode		= &hpt3xx_set_pio_mode;
 	hwif->speedproc			= &hpt3xx_tune_chipset;
 	hwif->quirkproc			= &hpt3xx_quirkproc;
 	hwif->intrproc			= &hpt3xx_intrproc;
Index: b/drivers/ide/pci/it8213.c
===================================================================
--- a/drivers/ide/pci/it8213.c
+++ b/drivers/ide/pci/it8213.c
@@ -105,9 +105,8 @@ static void it8213_tune_pio(ide_drive_t 
 	spin_unlock_irqrestore(&tune_lock, flags);
 }
 
-static void it8213_tuneproc(ide_drive_t *drive, u8 pio)
+static void it8213_set_pio_mode(ide_drive_t *drive, const u8 pio)
 {
-	pio = ide_get_best_pio_mode(drive, pio, 4);
 	it8213_tune_pio(drive, pio);
 	ide_config_drive_speed(drive, XFER_PIO_0 + pio);
 }
@@ -214,7 +213,7 @@ static int it8213_config_drive_for_dma (
 	if (ide_tune_dma(drive))
 		return 0;
 
-	it8213_tuneproc(drive, 255);
+	ide_set_max_pio(drive);
 
 	return -1;
 }
@@ -233,7 +232,7 @@ static void __devinit init_hwif_it8213(i
 	u8 reg42h = 0;
 
 	hwif->speedproc = &it8213_tune_chipset;
-	hwif->tuneproc	= &it8213_tuneproc;
+	hwif->set_pio_mode = &it8213_set_pio_mode;
 
 	hwif->autodma = 0;
 
Index: b/drivers/ide/pci/it821x.c
===================================================================
--- a/drivers/ide/pci/it821x.c
+++ b/drivers/ide/pci/it821x.c
@@ -274,9 +274,8 @@ static int it821x_tunepio(ide_drive_t *d
 	return ide_config_drive_speed(drive, XFER_PIO_0 + set_pio);
 }
 
-static void it821x_tuneproc(ide_drive_t *drive, u8 pio)
+static void it821x_set_pio_mode(ide_drive_t *drive, const u8 pio)
 {
-	pio = ide_get_best_pio_mode(drive, pio, 4);
 	(void)it821x_tunepio(drive, pio);
 }
 
@@ -473,7 +472,7 @@ static int it821x_config_drive_for_dma (
 	if (ide_tune_dma(drive))
 		return 0;
 
-	it821x_tuneproc(drive, 255);
+	ide_set_max_pio(drive);
 
 	return -1;
 }
@@ -640,7 +639,7 @@ static void __devinit init_hwif_it821x(i
 	}
 
 	hwif->speedproc = &it821x_tune_chipset;
-	hwif->tuneproc	= &it821x_tuneproc;
+	hwif->set_pio_mode = &it821x_set_pio_mode;
 
 	/* MWDMA/PIO clock switching for pass through mode */
 	if(!idev->smart) {
Index: b/drivers/ide/pci/jmicron.c
===================================================================
--- a/drivers/ide/pci/jmicron.c
+++ b/drivers/ide/pci/jmicron.c
@@ -83,9 +83,8 @@ static u8 __devinit ata66_jmicron(ide_hw
 	return ATA_CBL_PATA80;
 }
 
-static void jmicron_tuneproc(ide_drive_t *drive, u8 pio)
+static void jmicron_set_pio_mode(ide_drive_t *drive, const u8 pio)
 {
-	pio = ide_get_best_pio_mode(drive, pio, 5);
 	ide_config_drive_speed(drive, XFER_PIO_0 + pio);
 }
 
@@ -116,7 +115,7 @@ static int jmicron_config_drive_for_dma 
 	if (ide_tune_dma(drive))
 		return 0;
 
-	jmicron_tuneproc(drive, 255);
+	ide_set_max_pio(drive);
 
 	return -1;
 }
@@ -131,7 +130,7 @@ static int jmicron_config_drive_for_dma 
 static void __devinit init_hwif_jmicron(ide_hwif_t *hwif)
 {
 	hwif->speedproc = &jmicron_tune_chipset;
-	hwif->tuneproc	= &jmicron_tuneproc;
+	hwif->set_pio_mode = &jmicron_set_pio_mode;
 
 	hwif->drives[0].autotune = 1;
 	hwif->drives[1].autotune = 1;
Index: b/drivers/ide/pci/opti621.c
===================================================================
--- a/drivers/ide/pci/opti621.c
+++ b/drivers/ide/pci/opti621.c
@@ -47,7 +47,7 @@
  * The main problem with OPTi is that some timings for master
  * and slave must be the same. For example, if you have master
  * PIO 3 and slave PIO 0, driver have to set some timings of
- * master for PIO 0. Second problem is that opti621_tune_drive
+ * master for PIO 0. Second problem is that opti621_set_pio_mode
  * got only one drive to set, but have to set both drives.
  * This is solved in compute_pios. If you don't set
  * the second drive, compute_pios use ide_get_best_pio_mode
@@ -103,7 +103,7 @@
 
 #include <asm/io.h>
 
-#define OPTI621_MAX_PIO 3
+//#define OPTI621_MAX_PIO 3
 /* In fact, I do not have any PIO 4 drive
  * (address: 25 ns, data: 70 ns, recovery: 35 ns),
  * but OPTi 82C621 is programmable and it can do (minimal values):
@@ -136,8 +136,8 @@ static int reg_base;
 #define PIO_NOT_EXIST 254
 #define PIO_DONT_KNOW 255
 
-/* there are stored pio numbers from other calls of opti621_tune_drive */
-static void compute_pios(ide_drive_t *drive, u8 pio)
+/* there are stored pio numbers from other calls of opti621_set_pio_mode */
+static void compute_pios(ide_drive_t *drive, const u8 pio)
 /* Store values into drive->drive_data
  *	second_contr - 0 for primary controller, 1 for secondary
  *	slave_drive - 0 -> pio is for master, 1 -> pio is for slave
@@ -147,12 +147,13 @@ static void compute_pios(ide_drive_t *dr
 	int d;
 	ide_hwif_t *hwif = HWIF(drive);
 
-	drive->drive_data = ide_get_best_pio_mode(drive, pio, OPTI621_MAX_PIO);
+	drive->drive_data = pio;
+
 	for (d = 0; d < 2; ++d) {
 		drive = &hwif->drives[d];
 		if (drive->present) {
 			if (drive->drive_data == PIO_DONT_KNOW)
-				drive->drive_data = ide_get_best_pio_mode(drive, 255, OPTI621_MAX_PIO);
+				drive->drive_data = ide_get_best_pio_mode(drive, 255, 3);
 #ifdef OPTI621_DEBUG
 			printk("%s: Selected PIO mode %d\n",
 				drive->name, drive->drive_data);
@@ -240,8 +241,7 @@ static void compute_clocks(int pio, pio_
  
 }
 
-/* Main tune procedure, called from tuneproc. */
-static void opti621_tune_drive (ide_drive_t *drive, u8 pio)
+static void opti621_set_pio_mode(ide_drive_t *drive, const u8 pio)
 {
 	/* primary and secondary drives share some registers,
 	 * so we have to program both drives
@@ -331,7 +331,8 @@ static void __devinit init_hwif_opti621 
 	hwif->autodma = 0;
 	hwif->drives[0].drive_data = PIO_DONT_KNOW;
 	hwif->drives[1].drive_data = PIO_DONT_KNOW;
-	hwif->tuneproc = &opti621_tune_drive;
+
+	hwif->set_pio_mode = &opti621_set_pio_mode;
 
 	if (!(hwif->dma_base))
 		return;
Index: b/drivers/ide/pci/pdc202xx_new.c
===================================================================
--- a/drivers/ide/pci/pdc202xx_new.c
+++ b/drivers/ide/pci/pdc202xx_new.c
@@ -215,9 +215,8 @@ static int pdcnew_tune_chipset(ide_drive
 	return err;
 }
 
-static void pdcnew_tune_drive(ide_drive_t *drive, u8 pio)
+static void pdcnew_set_pio_mode(ide_drive_t *drive, const u8 pio)
 {
-	pio = ide_get_best_pio_mode(drive, pio, 4);
 	(void)pdcnew_tune_chipset(drive, XFER_PIO_0 + pio);
 }
 
@@ -237,7 +236,7 @@ static int pdcnew_config_drive_xfer_rate
 		return 0;
 
 	if (ide_use_fast_pio(drive))
-		pdcnew_tune_drive(drive, 255);
+		ide_set_max_pio(drive);
 
 	return -1;
 }
@@ -487,7 +486,8 @@ static void __devinit init_hwif_pdc202ne
 {
 	hwif->autodma = 0;
 
-	hwif->tuneproc  = &pdcnew_tune_drive;
+	hwif->set_pio_mode = &pdcnew_set_pio_mode;
+
 	hwif->quirkproc = &pdcnew_quirkproc;
 	hwif->speedproc = &pdcnew_tune_chipset;
 	hwif->resetproc = &pdcnew_reset;
Index: b/drivers/ide/pci/pdc202xx_old.c
===================================================================
--- a/drivers/ide/pci/pdc202xx_old.c
+++ b/drivers/ide/pci/pdc202xx_old.c
@@ -142,9 +142,8 @@ static int pdc202xx_tune_chipset(ide_dri
 	return ide_config_drive_speed(drive, speed);
 }
 
-static void pdc202xx_tune_drive(ide_drive_t *drive, u8 pio)
+static void pdc202xx_set_pio_mode(ide_drive_t *drive, const u8 pio)
 {
-	pio = ide_get_best_pio_mode(drive, pio, 4);
 	pdc202xx_tune_chipset(drive, XFER_PIO_0 + pio);
 }
 
@@ -190,7 +189,7 @@ static int pdc202xx_config_drive_xfer_ra
 		return 0;
 
 	if (ide_use_fast_pio(drive))
-		pdc202xx_tune_drive(drive, 255);
+		ide_set_max_pio(drive);
 
 	return -1;
 }
@@ -306,10 +305,11 @@ static void pdc202xx_reset (ide_drive_t 
 {
 	ide_hwif_t *hwif	= HWIF(drive);
 	ide_hwif_t *mate	= hwif->mate;
-	
+
 	pdc202xx_reset_host(hwif);
 	pdc202xx_reset_host(mate);
-	pdc202xx_tune_drive(drive, 255);
+
+	ide_set_max_pio(drive);
 }
 
 static unsigned int __devinit init_chipset_pdc202xx(struct pci_dev *dev,
@@ -328,7 +328,9 @@ static void __devinit init_hwif_pdc202xx
 		hwif->rqsize = 256;
 
 	hwif->autodma = 0;
-	hwif->tuneproc  = &pdc202xx_tune_drive;
+
+	hwif->set_pio_mode = &pdc202xx_set_pio_mode;
+
 	hwif->quirkproc = &pdc202xx_quirkproc;
 
 	if (hwif->pci_dev->device != PCI_DEVICE_ID_PROMISE_20246)
Index: b/drivers/ide/pci/piix.c
===================================================================
--- a/drivers/ide/pci/piix.c
+++ b/drivers/ide/pci/piix.c
@@ -17,11 +17,11 @@
  *                 41
  *                 43
  *
- * | PIO 0       | c0 | 80 | 0 | 	piix_tune_drive(drive, 0);
- * | PIO 2 | SW2 | d0 | 90 | 4 | 	piix_tune_drive(drive, 2);
- * | PIO 3 | MW1 | e1 | a1 | 9 | 	piix_tune_drive(drive, 3);
- * | PIO 4 | MW2 | e3 | a3 | b | 	piix_tune_drive(drive, 4);
- * 
+ * | PIO 0       | c0 | 80 | 0 |
+ * | PIO 2 | SW2 | d0 | 90 | 4 |
+ * | PIO 3 | MW1 | e1 | a1 | 9 |
+ * | PIO 4 | MW2 | e3 | a3 | b |
+ *
  * sitre = word40 & 0x4000; primary
  * sitre = word42 & 0x4000; secondary
  *
@@ -204,16 +204,16 @@ static void piix_tune_pio (ide_drive_t *
 }
 
 /**
- *	piix_tune_drive		-	tune a drive attached to PIIX
+ *	piix_set_pio_mode	-	set PIO mode
  *	@drive: drive to tune
  *	@pio: desired PIO mode
  *
  *	Set the drive's PIO mode (might be useful if drive is not registered
  *	in CMOS for any reason).
  */
-static void piix_tune_drive (ide_drive_t *drive, u8 pio)
+
+static void piix_set_pio_mode(ide_drive_t *drive, const u8 pio)
 {
-	pio = ide_get_best_pio_mode(drive, pio, 4);
 	piix_tune_pio(drive, pio);
 	(void) ide_config_drive_speed(drive, XFER_PIO_0 + pio);
 }
@@ -317,7 +317,7 @@ static int piix_config_drive_xfer_rate (
 		return 0;
 
 	if (ide_use_fast_pio(drive))
-		piix_tune_drive(drive, 255);
+		ide_set_max_pio(drive);
 
 	return -1;
 }
@@ -454,7 +454,8 @@ static void __devinit init_hwif_piix(ide
 	}
 
 	hwif->autodma = 0;
-	hwif->tuneproc = &piix_tune_drive;
+
+	hwif->set_pio_mode = &piix_set_pio_mode;
 	hwif->speedproc = &piix_tune_chipset;
 	hwif->drives[0].autotune = 1;
 	hwif->drives[1].autotune = 1;
Index: b/drivers/ide/pci/sc1200.c
===================================================================
--- a/drivers/ide/pci/sc1200.c
+++ b/drivers/ide/pci/sc1200.c
@@ -272,19 +272,20 @@ static int sc1200_ide_dma_end (ide_drive
 }
 
 /*
- * sc1200_tuneproc() handles selection/setting of PIO modes
+ * sc1200_set_pio_mode() handles setting of PIO modes
  * for both the chipset and drive.
  *
  * All existing BIOSs for this chipset guarantee that all drives
  * will have valid default PIO timings set up before we get here.
  */
-static void sc1200_tuneproc (ide_drive_t *drive, byte pio)	/* mode=255 means "autotune" */
+
+static void sc1200_set_pio_mode(ide_drive_t *drive, const u8 pio)
 {
 	ide_hwif_t	*hwif = HWIF(drive);
 	int		mode = -1;
 
 	/*
-	 * bad abuse of ->tuneproc interface
+	 * bad abuse of ->set_pio_mode interface
 	 */
 	switch (pio) {
 		case 200: mode = XFER_UDMA_0;	break;
@@ -302,9 +303,6 @@ static void sc1200_tuneproc (ide_drive_t
 		return;
 	}
 
-	pio = ide_get_best_pio_mode(drive, pio, 4);
-	printk("SC1200: %s: setting PIO mode%d\n", drive->name, pio);
-
 	if (sc1200_set_xfer_mode(drive, XFER_PIO_0 + pio) == 0)
 		sc1200_tunepio(drive, pio);
 }
@@ -420,7 +418,8 @@ static void __devinit init_hwif_sc1200 (
 		hwif->ide_dma_end   = &sc1200_ide_dma_end;
         	if (!noautodma)
                 	hwif->autodma = 1;
-		hwif->tuneproc = &sc1200_tuneproc;
+
+		hwif->set_pio_mode = &sc1200_set_pio_mode;
 		hwif->speedproc = &sc1200_tune_chipset;
 	}
         hwif->atapi_dma = 1;
@@ -436,6 +435,7 @@ static ide_pci_device_t sc1200_chipset _
 	.init_hwif	= init_hwif_sc1200,
 	.autodma	= AUTODMA,
 	.bootable	= ON_BOARD,
+	.host_flags	= IDE_HFLAG_ABUSE_DMA_MODES,
 	.pio_mask	= ATA_PIO4,
 };
 
Index: b/drivers/ide/pci/scc_pata.c
===================================================================
--- a/drivers/ide/pci/scc_pata.c
+++ b/drivers/ide/pci/scc_pata.c
@@ -221,9 +221,8 @@ static void scc_tune_pio(ide_drive_t *dr
 	out_be32((void __iomem *)pioct_port, reg);
 }
 
-static void scc_tuneproc(ide_drive_t *drive, u8 pio)
+static void scc_set_pio_mode(ide_drive_t *drive, const u8 pio)
 {
-	pio = ide_get_best_pio_mode(drive, pio, 4);
 	scc_tune_pio(drive, pio);
 	ide_config_drive_speed(drive, XFER_PIO_0 + pio);
 }
@@ -316,7 +315,7 @@ static int scc_config_drive_for_dma(ide_
 		return 0;
 
 	if (ide_use_fast_pio(drive))
-		scc_tuneproc(drive, 255);
+		ide_set_max_pio(drive);
 
 	return -1;
 }
@@ -717,7 +716,7 @@ static void __devinit init_hwif_scc(ide_
 	hwif->dma_setup = scc_dma_setup;
 	hwif->ide_dma_end = scc_ide_dma_end;
 	hwif->speedproc = scc_tune_chipset;
-	hwif->tuneproc = scc_tuneproc;
+	hwif->set_pio_mode = scc_set_pio_mode;
 	hwif->ide_dma_check = scc_config_drive_for_dma;
 	hwif->ide_dma_test_irq = scc_dma_test_irq;
 	hwif->udma_filter = scc_udma_filter;
Index: b/drivers/ide/pci/serverworks.c
===================================================================
--- a/drivers/ide/pci/serverworks.c
+++ b/drivers/ide/pci/serverworks.c
@@ -202,9 +202,8 @@ static int svwks_tune_chipset(ide_drive_
 	return (ide_config_drive_speed(drive, speed));
 }
 
-static void svwks_tune_drive (ide_drive_t *drive, u8 pio)
+static void svwks_set_pio_mode(ide_drive_t *drive, const u8 pio)
 {
-	pio = ide_get_best_pio_mode(drive, pio, 4);
 	svwks_tune_pio(drive, pio);
 	(void)ide_config_drive_speed(drive, XFER_PIO_0 + pio);
 }
@@ -217,7 +216,7 @@ static int svwks_config_drive_xfer_rate 
 		return 0;
 
 	if (ide_use_fast_pio(drive))
-		svwks_tune_drive(drive, 255);
+		ide_set_max_pio(drive);
 
 	return -1;
 }
@@ -389,7 +388,7 @@ static void __devinit init_hwif_svwks (i
 	if (!hwif->irq)
 		hwif->irq = hwif->channel ? 15 : 14;
 
-	hwif->tuneproc = &svwks_tune_drive;
+	hwif->set_pio_mode = &svwks_set_pio_mode;
 	hwif->speedproc = &svwks_tune_chipset;
 	hwif->udma_filter = &svwks_udma_filter;
 
Index: b/drivers/ide/pci/sgiioc4.c
===================================================================
--- a/drivers/ide/pci/sgiioc4.c
+++ b/drivers/ide/pci/sgiioc4.c
@@ -587,7 +587,7 @@ ide_init_sgiioc4(ide_hwif_t * hwif)
 	hwif->mwdma_mask = 0x2;	/* Multimode-2 DMA  */
 	hwif->swdma_mask = 0x2;
 	hwif->pio_mask = 0x00;
-	hwif->tuneproc = NULL;	/* Sets timing for PIO mode */
+	hwif->set_pio_mode = NULL; /* Sets timing for PIO mode */
 	hwif->speedproc = NULL;	/* Sets timing for DMA &/or PIO modes */
 	hwif->selectproc = NULL;/* Use the default routine to select drive */
 	hwif->reset_poll = NULL;/* No HBA specific reset_poll needed */
Index: b/drivers/ide/pci/siimage.c
===================================================================
--- a/drivers/ide/pci/siimage.c
+++ b/drivers/ide/pci/siimage.c
@@ -219,9 +219,8 @@ static void sil_tune_pio(ide_drive_t *dr
 	}
 }
 
-static void sil_tuneproc(ide_drive_t *drive, u8 pio)
+static void sil_set_pio_mode(ide_drive_t *drive, const u8 pio)
 {
-	pio = ide_get_best_pio_mode(drive, pio, 4);
 	sil_tune_pio(drive, pio);
 	(void)ide_config_drive_speed(drive, XFER_PIO_0 + pio);
 }
@@ -328,7 +327,7 @@ static int siimage_config_drive_for_dma 
 		return 0;
 
 	if (ide_use_fast_pio(drive))
-		sil_tuneproc(drive, 255);
+		ide_set_max_pio(drive);
 
 	return -1;
 }
@@ -899,7 +898,7 @@ static void __devinit init_hwif_siimage(
 	
 	hwif->resetproc = &siimage_reset;
 	hwif->speedproc = &siimage_tune_chipset;
-	hwif->tuneproc	= &sil_tuneproc;
+	hwif->set_pio_mode = &sil_set_pio_mode;
 	hwif->reset_poll = &siimage_reset_poll;
 	hwif->pre_reset = &siimage_pre_reset;
 	hwif->udma_filter = &sil_udma_filter;
Index: b/drivers/ide/pci/sis5513.c
===================================================================
--- a/drivers/ide/pci/sis5513.c
+++ b/drivers/ide/pci/sis5513.c
@@ -519,14 +519,13 @@ static void config_art_rwp_pio (ide_driv
 	}
 }
 
-static int sis5513_tune_drive(ide_drive_t *drive, u8 pio)
+static int sis5513_tune_drive(ide_drive_t *drive, const u8 pio)
 {
-	pio = ide_get_best_pio_mode(drive, pio, 4);
 	config_art_rwp_pio(drive, pio);
 	return ide_config_drive_speed(drive, XFER_PIO_0 + pio);
 }
 
-static void sis5513_tuneproc(ide_drive_t *drive, u8 pio)
+static void sis_set_pio_mode(ide_drive_t *drive, const u8 pio)
 {
 	(void)sis5513_tune_drive(drive, pio);
 }
@@ -621,7 +620,7 @@ static int sis5513_config_xfer_rate(ide_
 	/*
 	 * TODO: always set PIO mode and remove this
 	 */
-	sis5513_tuneproc(drive, 255);
+	ide_set_max_pio(drive);
 
 	drive->init_speed = 0;
 
@@ -629,7 +628,7 @@ static int sis5513_config_xfer_rate(ide_
 		return 0;
 
 	if (ide_use_fast_pio(drive))
-		sis5513_tuneproc(drive, 255);
+		ide_set_max_pio(drive);
 
 	return -1;
 }
@@ -851,7 +850,7 @@ static void __devinit init_hwif_sis5513 
 	if (!hwif->irq)
 		hwif->irq = hwif->channel ? 15 : 14;
 
-	hwif->tuneproc = &sis5513_tuneproc;
+	hwif->set_pio_mode = &sis_set_pio_mode;
 	hwif->speedproc = &sis5513_tune_chipset;
 
 	if (chipset_family >= ATA_133)
Index: b/drivers/ide/pci/sl82c105.c
===================================================================
--- a/drivers/ide/pci/sl82c105.c
+++ b/drivers/ide/pci/sl82c105.c
@@ -75,16 +75,12 @@ static unsigned int get_pio_timings(ide_
 /*
  * Configure the chipset for PIO mode.
  */
-static u8 sl82c105_tune_pio(ide_drive_t *drive, u8 pio)
+static void sl82c105_tune_pio(ide_drive_t *drive, const u8 pio)
 {
 	struct pci_dev *dev	= HWIF(drive)->pci_dev;
 	int reg			= 0x44 + drive->dn * 4;
 	u16 drv_ctrl;
 
-	DBG(("sl82c105_tune_pio(drive:%s, pio:%u)\n", drive->name, pio));
-
-	pio = ide_get_best_pio_mode(drive, pio, 5);
-
 	drv_ctrl = get_pio_timings(drive, pio);
 
 	/*
@@ -106,8 +102,6 @@ static u8 sl82c105_tune_pio(ide_drive_t 
 	printk(KERN_DEBUG "%s: selected %s (%dns) (%04X)\n", drive->name,
 			  ide_xfer_verbose(pio + XFER_PIO_0),
 			  ide_pio_cycle_time(drive, pio), drv_ctrl);
-
-	return pio;
 }
 
 /*
@@ -151,7 +145,7 @@ static int sl82c105_tune_chipset(ide_dri
 	case XFER_PIO_2:
 	case XFER_PIO_1:
 	case XFER_PIO_0:
-		(void) sl82c105_tune_pio(drive, speed - XFER_PIO_0);
+		sl82c105_tune_pio(drive, speed - XFER_PIO_0);
 		break;
 	default:
 		return -1;
@@ -325,11 +319,10 @@ static void sl82c105_resetproc(ide_drive
  * We only deal with PIO mode here - DMA mode 'using_dma' is not
  * initialised at the point that this function is called.
  */
-static void sl82c105_tune_drive(ide_drive_t *drive, u8 pio)
+static void sl82c105_set_pio_mode(ide_drive_t *drive, const u8 pio)
 {
-	DBG(("sl82c105_tune_drive(drive:%s, pio:%u)\n", drive->name, pio));
+	sl82c105_tune_pio(drive, pio);
 
-	pio = sl82c105_tune_pio(drive, pio);
 	(void) ide_config_drive_speed(drive, XFER_PIO_0 + pio);
 }
 
@@ -397,7 +390,7 @@ static void __devinit init_hwif_sl82c105
 
 	DBG(("init_hwif_sl82c105(hwif: ide%d)\n", hwif->index));
 
-	hwif->tuneproc		= &sl82c105_tune_drive;
+	hwif->set_pio_mode	= &sl82c105_set_pio_mode;
 	hwif->speedproc 	= &sl82c105_tune_chipset;
 	hwif->selectproc	= &sl82c105_selectproc;
 	hwif->resetproc 	= &sl82c105_resetproc;
Index: b/drivers/ide/pci/slc90e66.c
===================================================================
--- a/drivers/ide/pci/slc90e66.c
+++ b/drivers/ide/pci/slc90e66.c
@@ -95,9 +95,8 @@ static void slc90e66_tune_pio (ide_drive
 	spin_unlock_irqrestore(&ide_lock, flags);
 }
 
-static void slc90e66_tune_drive (ide_drive_t *drive, u8 pio)
+static void slc90e66_set_pio_mode(ide_drive_t *drive, const u8 pio)
 {
-	pio = ide_get_best_pio_mode(drive, pio, 4);
 	slc90e66_tune_pio(drive, pio);
 	(void) ide_config_drive_speed(drive, XFER_PIO_0 + pio);
 }
@@ -166,7 +165,7 @@ static int slc90e66_config_drive_xfer_ra
 		return 0;
 
 	if (ide_use_fast_pio(drive))
-		slc90e66_tune_drive(drive, 255);
+		ide_set_max_pio(drive);
 
 	return -1;
 }
@@ -182,7 +181,7 @@ static void __devinit init_hwif_slc90e66
 		hwif->irq = hwif->channel ? 15 : 14;
 
 	hwif->speedproc = &slc90e66_tune_chipset;
-	hwif->tuneproc	= &slc90e66_tune_drive;
+	hwif->set_pio_mode = &slc90e66_set_pio_mode;
 
 	pci_read_config_byte(hwif->pci_dev, 0x47, &reg47);
 
Index: b/drivers/ide/pci/tc86c001.c
===================================================================
--- a/drivers/ide/pci/tc86c001.c
+++ b/drivers/ide/pci/tc86c001.c
@@ -43,9 +43,8 @@ static int tc86c001_tune_chipset(ide_dri
 	return ide_config_drive_speed(drive, speed);
 }
 
-static void tc86c001_tune_drive(ide_drive_t *drive, u8 pio)
+static void tc86c001_set_pio_mode(ide_drive_t *drive, const u8 pio)
 {
-	pio = ide_get_best_pio_mode(drive, pio, 4);
 	(void) tc86c001_tune_chipset(drive, XFER_PIO_0 + pio);
 }
 
@@ -171,7 +170,7 @@ static int tc86c001_config_drive_xfer_ra
 		return 0;
 
 	if (ide_use_fast_pio(drive))
-		tc86c001_tune_drive(drive, 255);
+		ide_set_max_pio(drive);
 
 	return -1;
 }
@@ -193,7 +192,7 @@ static void __devinit init_hwif_tc86c001
 	/* Store the system control register base for convenience... */
 	hwif->config_data = sc_base;
 
-	hwif->tuneproc	= &tc86c001_tune_drive;
+	hwif->set_pio_mode = &tc86c001_set_pio_mode;
 	hwif->speedproc = &tc86c001_tune_chipset;
 	hwif->busproc	= &tc86c001_busproc;
 
Index: b/drivers/ide/pci/triflex.c
===================================================================
--- a/drivers/ide/pci/triflex.c
+++ b/drivers/ide/pci/triflex.c
@@ -93,10 +93,9 @@ static int triflex_tune_chipset(ide_driv
 	return (ide_config_drive_speed(drive, speed));
 }
 
-static void triflex_tune_drive(ide_drive_t *drive, u8 pio)
+static void triflex_set_pio_mode(ide_drive_t *drive, const u8 pio)
 {
-	int use_pio = ide_get_best_pio_mode(drive, pio, 4);
-	(void) triflex_tune_chipset(drive, (XFER_PIO_0 + use_pio));
+	(void)triflex_tune_chipset(drive, XFER_PIO_0 + pio);
 }
 
 static int triflex_config_drive_xfer_rate(ide_drive_t *drive)
@@ -104,14 +103,14 @@ static int triflex_config_drive_xfer_rat
 	if (ide_tune_dma(drive))
 		return 0;
 
-	triflex_tune_drive(drive, 255);
+	ide_set_max_pio(drive);
 
 	return -1;
 }
 
 static void __devinit init_hwif_triflex(ide_hwif_t *hwif)
 {
-	hwif->tuneproc = &triflex_tune_drive;
+	hwif->set_pio_mode = &triflex_set_pio_mode;
 	hwif->speedproc = &triflex_tune_chipset;
 
 	hwif->atapi_dma  = 1;
Index: b/drivers/ide/pci/via82cxxx.c
===================================================================
--- a/drivers/ide/pci/via82cxxx.c
+++ b/drivers/ide/pci/via82cxxx.c
@@ -194,19 +194,16 @@ static int via_set_drive(ide_drive_t *dr
 }
 
 /**
- *	via82cxxx_tune_drive	-	PIO setup
- *	@drive: drive to set up
- *	@pio: mode to use (255 for 'best possible')
+ *	via_set_pio_mode	-	PIO setup
+ *	@drive: drive
+ *	@pio: PIO mode number
  *
  *	A callback from the upper layers for PIO-only tuning.
  */
 
-static void via82cxxx_tune_drive(ide_drive_t *drive, u8 pio)
+static void via_set_pio_mode(ide_drive_t *drive, const u8 pio)
 {
-	if (pio == 255)
-		pio = ide_get_best_pio_mode(drive, 255, 5);
-
-	via_set_drive(drive, XFER_PIO_0 + min_t(u8, pio, 5));
+	via_set_drive(drive, XFER_PIO_0 + pio);
 }
 
 /**
@@ -222,7 +219,7 @@ static int via82cxxx_ide_dma_check (ide_
 	u8 speed = ide_max_dma_mode(drive);
 
 	if (speed == 0) {
-		via82cxxx_tune_drive(drive, 255);
+		ide_set_max_pio(drive);
 		return -1;
 	}
 
@@ -457,7 +454,7 @@ static void __devinit init_hwif_via82cxx
 
 	hwif->autodma = 0;
 
-	hwif->tuneproc = &via82cxxx_tune_drive;
+	hwif->set_pio_mode = &via_set_pio_mode;
 	hwif->speedproc = &via_set_drive;
 
 
Index: b/drivers/ide/ppc/mpc8xx.c
===================================================================
--- a/drivers/ide/ppc/mpc8xx.c
+++ b/drivers/ide/ppc/mpc8xx.c
@@ -46,7 +46,7 @@ static void print_funcid (int func);
 static int check_ide_device (unsigned long base);
 
 static void ide_interrupt_ack (void *dev);
-static void m8xx_ide_tuneproc(ide_drive_t *drive, u8 pio);
+static void m8xx_ide_set_pio_mode(ide_drive_t *drive, const u8 pio);
 
 typedef	struct ide_ioport_desc {
 	unsigned long	base_off;		/* Offset to PCMCIA memory	*/
@@ -315,9 +315,8 @@ m8xx_ide_init_hwif_ports(hw_regs_t *hw, 
 #endif	/* CONFIG_IDE_8xx_PCCARD */
 	}
 
-	/* register routine to tune PIO mode */
 	ide_hwifs[data_port].pio_mask = ATA_PIO4;
-	ide_hwifs[data_port].tuneproc = m8xx_ide_tuneproc;
+	ide_hwifs[data_port].set_pio_mode = m8xx_ide_set_pio_mode;
 
 	hw->ack_intr = (ide_ack_intr_t *) ide_interrupt_ack;
 	/* Enable Harddisk Interrupt,
@@ -402,9 +401,8 @@ void m8xx_ide_init_hwif_ports (hw_regs_t
 		*irq = ioport_dsc[data_port].irq;
 	}
 
-	/* register routine to tune PIO mode */
 	ide_hwifs[data_port].pio_mask = ATA_PIO4;
-	ide_hwifs[data_port].tuneproc = m8xx_ide_tuneproc;
+	ide_hwifs[data_port].set_pio_mode = m8xx_ide_set_pio_mode;
 
 	hw->ack_intr = (ide_ack_intr_t *) ide_interrupt_ack;
 	/* Enable Harddisk Interrupt,
@@ -428,24 +426,13 @@ void m8xx_ide_init_hwif_ports (hw_regs_t
 #define PCMCIA_SL(t) ((t==32) ? 0 : ((t & 0x1F)<<7)) /* Strobe Length	*/
 #endif
 
-
 /* Calculate PIO timings */
-static void
-m8xx_ide_tuneproc(ide_drive_t *drive, u8 pio)
+static void m8xx_ide_set_pio_mode(ide_drive_t *drive, const u8 pio)
 {
 #if defined(CONFIG_IDE_8xx_PCCARD) || defined(CONFIG_IDE_8xx_DIRECT)
 	volatile pcmconf8xx_t	*pcmp;
 	ulong timing, mask, reg;
-#endif
-
-	pio = ide_get_best_pio_mode(drive, pio, 4);
 
-#if 1
-	printk("%s[%d] %s: best PIO mode: %d\n",
-		__FILE__,__LINE__,__FUNCTION__, pio);
-#endif
-
-#if defined(CONFIG_IDE_8xx_PCCARD) || defined(CONFIG_IDE_8xx_DIRECT)
 	pcmp = (pcmconf8xx_t *)(&(((immap_t *)IMAP_ADDR)->im_pcmcia));
 
 	mask = ~(PCMCIA_SHT(0xFF) | PCMCIA_SST(0xFF) | PCMCIA_SL(0xFF));
Index: b/drivers/ide/ppc/pmac.c
===================================================================
--- a/drivers/ide/ppc/pmac.c
+++ b/drivers/ide/ppc/pmac.c
@@ -411,7 +411,6 @@ kauai_lookup_timing(struct kauai_timing*
 
 static void pmac_ide_setup_dma(pmac_ide_hwif_t *pmif, ide_hwif_t *hwif);
 static int pmac_ide_build_dmatable(ide_drive_t *drive, struct request *rq);
-static void pmac_ide_tuneproc(ide_drive_t *drive, u8 pio);
 static void pmac_ide_selectproc(ide_drive_t *drive);
 static void pmac_ide_kauai_selectproc(ide_drive_t *drive);
 
@@ -612,7 +611,7 @@ out:
  * Old tuning functions (called on hdparm -p), sets up drive PIO timings
  */
 static void
-pmac_ide_tuneproc(ide_drive_t *drive, u8 pio)
+pmac_ide_set_pio_mode(ide_drive_t *drive, const u8 pio)
 {
 	u32 *timings;
 	unsigned accessTicks, recTicks;
@@ -626,7 +625,6 @@ pmac_ide_tuneproc(ide_drive_t *drive, u8
 	/* which drive is it ? */
 	timings = &pmif->timings[drive->select.b.unit & 0x01];
 
-	pio = ide_get_best_pio_mode(drive, pio, 4);
 	cycle_time = ide_pio_cycle_time(drive, pio);
 
 	switch (pmif->kind) {
@@ -963,7 +961,7 @@ static int pmac_ide_tune_chipset(ide_dri
 		case XFER_PIO_2:
 		case XFER_PIO_1:
 		case XFER_PIO_0:
-			pmac_ide_tuneproc(drive, speed & 0x07);
+			pmac_ide_set_pio_mode(drive, speed & 0x07);
 			break;
 		default:
 			ret = 1;
@@ -1239,7 +1237,7 @@ pmac_ide_setup_device(pmac_ide_hwif_t *p
 	hwif->drives[0].unmask = 1;
 	hwif->drives[1].unmask = 1;
 	hwif->pio_mask = ATA_PIO4;
-	hwif->tuneproc = pmac_ide_tuneproc;
+	hwif->set_pio_mode = pmac_ide_set_pio_mode;
 	if (pmif->kind == controller_un_ata6
 	    || pmif->kind == controller_k2_ata6
 	    || pmif->kind == controller_sh_ata6)
Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -634,7 +634,7 @@ typedef struct ide_drive_s {
 
 	unsigned int	bios_cyl;	/* BIOS/fdisk/LILO number of cyls */
 	unsigned int	cyl;		/* "real" number of cyls */
-	unsigned int	drive_data;	/* use by tuneproc/selectproc */
+	unsigned int	drive_data;	/* used by set_pio_mode/selectproc */
 	unsigned int	failures;	/* current failure count */
 	unsigned int	max_failures;	/* maximum allowed failure count */
 	u64		probed_capacity;/* initial reported media capacity (ide-cd only currently) */
@@ -702,8 +702,8 @@ typedef struct hwif_s {
 #if 0
 	ide_hwif_ops_t	*hwifops;
 #else
-	/* routine to tune PIO mode for drives */
-	void	(*tuneproc)(ide_drive_t *, u8);
+	/* routine to set PIO mode for drives */
+	void	(*set_pio_mode)(ide_drive_t *, const u8);
 	/* routine to retune DMA modes for drives */
 	int	(*speedproc)(ide_drive_t *, const u8);
 	/* tweaks hardware to select drive */
@@ -1255,6 +1255,12 @@ enum {
 	IDE_HFLAG_PIO_NO_BLACKLIST	= (1 << 2),
 	/* don't use conservative PIO "downgrade" */
 	IDE_HFLAG_PIO_NO_DOWNGRADE	= (1 << 3),
+	/* use PIO8/9 for prefetch off/on */
+	IDE_HFLAG_ABUSE_PREFETCH	= (1 << 4),
+	/* use PIO6/7 for fast-devsel off/on */
+	IDE_HFLAG_ABUSE_FAST_DEVSEL	= (1 << 5),
+	/* use 100-102 and 200-202 PIO values to set DMA modes */
+	IDE_HFLAG_ABUSE_DMA_MODES	= (1 << 6),
 };
 
 typedef struct ide_pci_device_s {
@@ -1398,6 +1404,12 @@ unsigned int ide_pio_cycle_time(ide_driv
 u8 ide_get_best_pio_mode(ide_drive_t *, u8, u8);
 extern const ide_pio_timings_t ide_pio_timings[6];
 
+void ide_set_pio(ide_drive_t *, u8);
+
+static inline void ide_set_max_pio(ide_drive_t *drive)
+{
+	ide_set_pio(drive, 255);
+}
 
 extern spinlock_t ide_lock;
 extern struct mutex ide_cfg_mtx;
