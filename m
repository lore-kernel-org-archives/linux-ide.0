From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ide: add ide_pio_cycle_time() helper (take 2)
Date: Sun, 1 Jul 2007 00:45:24 +0200
Message-ID: <200707010045.24252.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.187]:48428 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752946AbXF3WdG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 30 Jun 2007 18:33:06 -0400
Received: by mu-out-0910.google.com with SMTP id i10so1808903mue
        for <linux-ide@vger.kernel.org>; Sat, 30 Jun 2007 15:33:04 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Jeff Garzik <jeff@garzik.org>


* Add ide_pio_cycle_time() helper.

* Use it in ali14xx/ht6560b/qd65xx/cmd64{0,x}/sl82c105 and pmac host drivers
  (previously cycle time given by the device was only used for "pio" == 255).

* Remove no longer needed ide_pio_data_t.cycle_time field.

v2:
* Fix "ata_" prefix (Noticed by Jeff).

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>
---
 drivers/ide/ide-lib.c        |   40 ++++++++++++++++++++++++++++------------
 drivers/ide/legacy/ali14xx.c |    5 ++---
 drivers/ide/legacy/ht6560b.c |   10 ++++++----
 drivers/ide/legacy/qd65xx.c  |   20 ++++++++++----------
 drivers/ide/pci/cmd640.c     |   12 +++++-------
 drivers/ide/pci/cmd64x.c     |   10 ++++++----
 drivers/ide/pci/sl82c105.c   |   16 ++++++++--------
 drivers/ide/ppc/pmac.c       |   15 ++++++++-------
 include/linux/ide.h          |    2 +-
 9 files changed, 74 insertions(+), 56 deletions(-)

Index: b/drivers/ide/ide-lib.c
===================================================================
--- a/drivers/ide/ide-lib.c
+++ b/drivers/ide/ide-lib.c
@@ -249,6 +249,29 @@ static int ide_scan_pio_blacklist (char 
 	return -1;
 }
 
+unsigned int ide_pio_cycle_time(ide_drive_t *drive, u8 pio)
+{
+	struct hd_driveid *id = drive->id;
+	int cycle_time = 0;
+
+	if (id->field_valid & 2) {
+		if (id->capability & 8)
+			cycle_time = id->eide_pio_iordy;
+		else
+			cycle_time = id->eide_pio;
+	}
+
+	/* conservative "downgrade" for all pre-ATA2 drives */
+	if (pio < 3) {
+		if (cycle_time && cycle_time < ide_pio_timings[pio].cycle_time)
+			cycle_time = 0; /* use standard timing */
+	}
+
+	return cycle_time ? cycle_time : ide_pio_timings[pio].cycle_time;
+}
+
+EXPORT_SYMBOL_GPL(ide_pio_cycle_time);
+
 /**
  *	ide_get_best_pio_mode	-	get PIO mode from drive
  *	@drive: drive to consider
@@ -266,7 +289,6 @@ static int ide_scan_pio_blacklist (char 
 u8 ide_get_best_pio_mode (ide_drive_t *drive, u8 mode_wanted, u8 max_mode, ide_pio_data_t *d)
 {
 	int pio_mode;
-	int cycle_time = 0;
 	struct hd_driveid* id = drive->id;
 	int overridden  = 0;
 
@@ -284,7 +306,6 @@ u8 ide_get_best_pio_mode (ide_drive_t *d
 		}
 		if (id->field_valid & 2) {	  /* drive implements ATA2? */
 			if (id->capability & 8) { /* IORDY supported? */
-				cycle_time = id->eide_pio_iordy;
 				if (id->eide_pio_modes & 7) {
 					overridden = 0;
 					if (id->eide_pio_modes & 4)
@@ -294,8 +315,6 @@ u8 ide_get_best_pio_mode (ide_drive_t *d
 					else
 						pio_mode = 3;
 				}
-			} else {
-				cycle_time = id->eide_pio;
 			}
 		}
 
@@ -310,18 +329,15 @@ u8 ide_get_best_pio_mode (ide_drive_t *d
 			pio_mode--;
 			printk(KERN_INFO "%s: applying conservative "
 					 "PIO \"downgrade\"\n", drive->name);
-			if (cycle_time && cycle_time < ide_pio_timings[pio_mode].cycle_time)
-				cycle_time = 0; /* use standard timing */
 		}
 	}
-	if (pio_mode > max_mode) {
+
+	if (pio_mode > max_mode)
 		pio_mode = max_mode;
-		cycle_time = 0;
-	}
-	if (d) {
+
+	if (d)
 		d->pio_mode = pio_mode;
-		d->cycle_time = cycle_time ? cycle_time : ide_pio_timings[pio_mode].cycle_time;
-	}
+
 	return pio_mode;
 }
 
Index: b/drivers/ide/legacy/ali14xx.c
===================================================================
--- a/drivers/ide/legacy/ali14xx.c
+++ b/drivers/ide/legacy/ali14xx.c
@@ -115,13 +115,12 @@ static void ali14xx_tune_drive (ide_driv
 	int time1, time2;
 	u8 param1, param2, param3, param4;
 	unsigned long flags;
-	ide_pio_data_t d;
 	int bus_speed = system_bus_clock();
 
-	pio = ide_get_best_pio_mode(drive, pio, ALI_MAX_PIO, &d);
+	pio = ide_get_best_pio_mode(drive, pio, ALI_MAX_PIO, NULL);
 
 	/* calculate timing, according to PIO mode */
-	time1 = d.cycle_time;
+	time1 = ide_pio_cycle_time(drive, pio);
 	time2 = ide_pio_timings[pio].active_time;
 	param3 = param1 = (time2 * bus_speed + 999) / 1000;
 	param4 = param2 = (time1 * bus_speed + 999) / 1000 - param1;
Index: b/drivers/ide/legacy/ht6560b.c
===================================================================
--- a/drivers/ide/legacy/ht6560b.c
+++ b/drivers/ide/legacy/ht6560b.c
@@ -203,19 +203,21 @@ static u8 ht_pio2timings(ide_drive_t *dr
 {
 	int active_time, recovery_time;
 	int active_cycles, recovery_cycles;
-	ide_pio_data_t d;
 	int bus_speed = system_bus_clock();
 	
         if (pio) {
-		pio = ide_get_best_pio_mode(drive, pio, 5, &d);
-		
+		unsigned int cycle_time;
+
+		pio = ide_get_best_pio_mode(drive, pio, 5, NULL);
+		cycle_time = ide_pio_cycle_time(drive, pio);
+
 		/*
 		 *  Just like opti621.c we try to calculate the
 		 *  actual cycle time for recovery and activity
 		 *  according system bus speed.
 		 */
 		active_time = ide_pio_timings[pio].active_time;
-		recovery_time = d.cycle_time 
+		recovery_time = cycle_time
 			- active_time
 			- ide_pio_timings[pio].setup_time;
 		/*
Index: b/drivers/ide/legacy/qd65xx.c
===================================================================
--- a/drivers/ide/legacy/qd65xx.c
+++ b/drivers/ide/legacy/qd65xx.c
@@ -252,38 +252,38 @@ static void qd6500_tune_drive (ide_drive
 
 static void qd6580_tune_drive (ide_drive_t *drive, u8 pio)
 {
-	ide_pio_data_t d;
 	int base = HWIF(drive)->select_data;
+	unsigned int cycle_time;
 	int active_time   = 175;
 	int recovery_time = 415; /* worst case values from the dos driver */
 
 	if (drive->id && !qd_find_disk_type(drive, &active_time, &recovery_time)) {
-		pio = ide_get_best_pio_mode(drive, pio, 4, &d);
+		pio = ide_get_best_pio_mode(drive, pio, 4, NULL);
+		cycle_time = ide_pio_cycle_time(drive, pio);
 
 		switch (pio) {
 			case 0: break;
 			case 3:
-				if (d.cycle_time >= 110) {
+				if (cycle_time >= 110) {
 					active_time = 86;
-					recovery_time = d.cycle_time - 102;
+					recovery_time = cycle_time - 102;
 				} else
 					printk(KERN_WARNING "%s: Strange recovery time !\n",drive->name);
 				break;
 			case 4:
-				if (d.cycle_time >= 69) {
+				if (cycle_time >= 69) {
 					active_time = 70;
-					recovery_time = d.cycle_time - 61;
+					recovery_time = cycle_time - 61;
 				} else
 					printk(KERN_WARNING "%s: Strange recovery time !\n",drive->name);
 				break;
 			default:
-				if (d.cycle_time >= 180) {
+				if (cycle_time >= 180) {
 					active_time = 110;
-					recovery_time = d.cycle_time - 120;
+					recovery_time = cycle_time - 120;
 				} else {
 					active_time = ide_pio_timings[pio].active_time;
-					recovery_time = d.cycle_time
-							-active_time;
+					recovery_time = cycle_time - active_time;
 				}
 		}
 		printk(KERN_INFO "%s: PIO mode%d\n", drive->name,pio);
Index: b/drivers/ide/pci/cmd640.c
===================================================================
--- a/drivers/ide/pci/cmd640.c
+++ b/drivers/ide/pci/cmd640.c
@@ -633,9 +633,8 @@ static void cmd640_set_mode (unsigned in
  */
 static void cmd640_tune_drive (ide_drive_t *drive, u8 mode_wanted)
 {
+	unsigned int index = 0, cycle_time;
 	u8 b;
-	ide_pio_data_t  d;
-	unsigned int index = 0;
 
 	while (drive != cmd_drives[index]) {
 		if (++index > 3) {
@@ -662,13 +661,12 @@ static void cmd640_tune_drive (ide_drive
 			return;
 	}
 
-	(void) ide_get_best_pio_mode (drive, mode_wanted, 5, &d);
-	cmd640_set_mode (index, d.pio_mode, d.cycle_time);
+	mode_wanted = ide_get_best_pio_mode(drive, mode_wanted, 5, NULL);
+	cycle_time = ide_pio_cycle_time(drive, mode_wanted);
+	cmd640_set_mode(index, mode_wanted, cycle_time);
 
 	printk("%s: selected cmd640 PIO mode%d (%dns)",
-		drive->name,
-		d.pio_mode,
-		d.cycle_time);
+		drive->name, mode_wanted, cycle_time);
 
 	display_clocks(index);
 }
Index: b/drivers/ide/pci/cmd64x.c
===================================================================
--- a/drivers/ide/pci/cmd64x.c
+++ b/drivers/ide/pci/cmd64x.c
@@ -223,16 +223,18 @@ static u8 cmd64x_tune_pio (ide_drive_t *
 {
 	ide_hwif_t *hwif	= HWIF(drive);
 	struct pci_dev *dev	= hwif->pci_dev;
-	ide_pio_data_t pio;
+	unsigned int cycle_time;
 	u8 pio_mode, setup_count, arttim = 0;
 	static const u8 setup_values[] = {0x40, 0x40, 0x40, 0x80, 0, 0xc0};
 	static const u8 arttim_regs[4] = {ARTTIM0, ARTTIM1, ARTTIM23, ARTTIM23};
-	pio_mode = ide_get_best_pio_mode(drive, mode_wanted, 5, &pio);
+
+	pio_mode = ide_get_best_pio_mode(drive, mode_wanted, 5, NULL);
+	cycle_time = ide_pio_cycle_time(drive, pio_mode);
 
 	cmdprintk("%s: PIO mode wanted %d, selected %d (%d ns)\n",
-		  drive->name, mode_wanted, pio_mode, pio.cycle_time);
+		  drive->name, mode_wanted, pio_mode, cycle_time);
 
-	program_cycle_times(drive, pio.cycle_time,
+	program_cycle_times(drive, cycle_time,
 			    ide_pio_timings[pio_mode].active_time);
 
 	setup_count = quantize_timing(ide_pio_timings[pio_mode].setup_time,
Index: b/drivers/ide/pci/sl82c105.c
===================================================================
--- a/drivers/ide/pci/sl82c105.c
+++ b/drivers/ide/pci/sl82c105.c
@@ -52,13 +52,13 @@
  * Convert a PIO mode and cycle time to the required on/off times
  * for the interface.  This has protection against runaway timings.
  */
-static unsigned int get_pio_timings(ide_drive_t *drive, ide_pio_data_t *p)
+static unsigned int get_pio_timings(ide_drive_t *drive, u8 pio)
 {
 	unsigned int cmd_on, cmd_off;
 	u8 iordy = 0;
 
-	cmd_on  = (ide_pio_timings[p->pio_mode].active_time + 29) / 30;
-	cmd_off = (p->cycle_time - 30 * cmd_on + 29) / 30;
+	cmd_on  = (ide_pio_timings[pio].active_time + 29) / 30;
+	cmd_off = (ide_pio_cycle_time(drive, pio) - 30 * cmd_on + 29) / 30;
 
 	if (cmd_on == 0)
 		cmd_on = 1;
@@ -66,7 +66,7 @@ static unsigned int get_pio_timings(ide_
 	if (cmd_off == 0)
 		cmd_off = 1;
 
-	if (p->pio_mode > 2 || ide_dev_has_iordy(drive->id))
+	if (pio > 2 || ide_dev_has_iordy(drive->id))
 		iordy = 0x40;
 
 	return (cmd_on - 1) << 8 | (cmd_off - 1) | iordy;
@@ -79,14 +79,13 @@ static u8 sl82c105_tune_pio(ide_drive_t 
 {
 	struct pci_dev *dev	= HWIF(drive)->pci_dev;
 	int reg			= 0x44 + drive->dn * 4;
-	ide_pio_data_t p;
 	u16 drv_ctrl;
 
 	DBG(("sl82c105_tune_pio(drive:%s, pio:%u)\n", drive->name, pio));
 
-	pio = ide_get_best_pio_mode(drive, pio, 5, &p);
+	pio = ide_get_best_pio_mode(drive, pio, 5, NULL);
 
-	drv_ctrl = get_pio_timings(drive, &p);
+	drv_ctrl = get_pio_timings(drive, pio);
 
 	/*
 	 * Store the PIO timings so that we can restore them
@@ -105,7 +104,8 @@ static u8 sl82c105_tune_pio(ide_drive_t 
 	}
 
 	printk(KERN_DEBUG "%s: selected %s (%dns) (%04X)\n", drive->name,
-	       ide_xfer_verbose(pio + XFER_PIO_0), p.cycle_time, drv_ctrl);
+			  ide_xfer_verbose(pio + XFER_PIO_0),
+			  ide_pio_cycle_time(drive, pio), drv_ctrl);
 
 	return pio;
 }
Index: b/drivers/ide/ppc/pmac.c
===================================================================
--- a/drivers/ide/ppc/pmac.c
+++ b/drivers/ide/ppc/pmac.c
@@ -615,24 +615,25 @@ out:
 static void
 pmac_ide_tuneproc(ide_drive_t *drive, u8 pio)
 {
-	ide_pio_data_t d;
 	u32 *timings;
 	unsigned accessTicks, recTicks;
 	unsigned accessTime, recTime;
 	pmac_ide_hwif_t* pmif = (pmac_ide_hwif_t *)HWIF(drive)->hwif_data;
-	
+	unsigned int cycle_time;
+
 	if (pmif == NULL)
 		return;
 		
 	/* which drive is it ? */
 	timings = &pmif->timings[drive->select.b.unit & 0x01];
 
-	pio = ide_get_best_pio_mode(drive, pio, 4, &d);
+	pio = ide_get_best_pio_mode(drive, pio, 4, NULL);
+	cycle_time = ide_pio_cycle_time(drive, pio);
 
 	switch (pmif->kind) {
 	case controller_sh_ata6: {
 		/* 133Mhz cell */
-		u32 tr = kauai_lookup_timing(shasta_pio_timings, d.cycle_time);
+		u32 tr = kauai_lookup_timing(shasta_pio_timings, cycle_time);
 		if (tr == 0)
 			return;
 		*timings = ((*timings) & ~TR_133_PIOREG_PIO_MASK) | tr;
@@ -641,7 +642,7 @@ pmac_ide_tuneproc(ide_drive_t *drive, u8
 	case controller_un_ata6:
 	case controller_k2_ata6: {
 		/* 100Mhz cell */
-		u32 tr = kauai_lookup_timing(kauai_pio_timings, d.cycle_time);
+		u32 tr = kauai_lookup_timing(kauai_pio_timings, cycle_time);
 		if (tr == 0)
 			return;
 		*timings = ((*timings) & ~TR_100_PIOREG_PIO_MASK) | tr;
@@ -649,7 +650,7 @@ pmac_ide_tuneproc(ide_drive_t *drive, u8
 		}
 	case controller_kl_ata4:
 		/* 66Mhz cell */
-		recTime = d.cycle_time - ide_pio_timings[pio].active_time
+		recTime = cycle_time - ide_pio_timings[pio].active_time
 				- ide_pio_timings[pio].setup_time;
 		recTime = max(recTime, 150U);
 		accessTime = ide_pio_timings[pio].active_time;
@@ -665,7 +666,7 @@ pmac_ide_tuneproc(ide_drive_t *drive, u8
 	default: {
 		/* 33Mhz cell */
 		int ebit = 0;
-		recTime = d.cycle_time - ide_pio_timings[pio].active_time
+		recTime = cycle_time - ide_pio_timings[pio].active_time
 				- ide_pio_timings[pio].setup_time;
 		recTime = max(recTime, 150U);
 		accessTime = ide_pio_timings[pio].active_time;
Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -1379,9 +1379,9 @@ typedef struct ide_pio_timings_s {
 
 typedef struct ide_pio_data_s {
 	u8 pio_mode;
-	unsigned int cycle_time;
 } ide_pio_data_t;
 
+unsigned int ide_pio_cycle_time(ide_drive_t *, u8);
 extern u8 ide_get_best_pio_mode (ide_drive_t *drive, u8 mode_wanted, u8 max_mode, ide_pio_data_t *d);
 extern const ide_pio_timings_t ide_pio_timings[6];
 
