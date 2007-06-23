From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 4/6] ide: make ide_get_best_pio_mode() print info if overriding PIO mode
Date: Sat, 23 Jun 2007 20:04:41 +0200
Message-ID: <200706232004.41342.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.174]:28198 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754498AbXFWRxB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 23 Jun 2007 13:53:01 -0400
Received: by ug-out-1314.google.com with SMTP id j3so1019617ugf
        for <linux-ide@vger.kernel.org>; Sat, 23 Jun 2007 10:53:00 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


* Print info about overriding PIO mode in ide_get_best_pio_mode().

* Remove info about overriding PIO mode from cmd64{0,x} host drivers.

* Remove no longer needed ide_pio_data_t.overridden field.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-lib.c    |   10 +++++++---
 drivers/ide/pci/cmd640.c |    7 +++----
 drivers/ide/pci/cmd64x.c |    5 ++---
 include/linux/ide.h      |    1 -
 4 files changed, 12 insertions(+), 11 deletions(-)

Index: b/drivers/ide/ide-lib.c
===================================================================
--- a/drivers/ide/ide-lib.c
+++ b/drivers/ide/ide-lib.c
@@ -277,7 +277,7 @@ u8 ide_get_best_pio_mode (ide_drive_t *d
 	} else if (!drive->id) {
 		pio_mode = 0;
 	} else if ((pio_mode = ide_scan_pio_blacklist(id->model)) != -1) {
-		overridden = 1;
+		printk(KERN_INFO "%s: is on PIO blacklist\n", drive->name);
 		use_iordy = (pio_mode > 2);
 	} else {
 		pio_mode = id->tPIO;
@@ -303,12 +303,17 @@ u8 ide_get_best_pio_mode (ide_drive_t *d
 			}
 		}
 
+		if (overridden)
+			printk(KERN_INFO "%s: tPIO > 2, assuming tPIO = 2\n",
+					 drive->name);
+
 		/*
 		 * Conservative "downgrade" for all pre-ATA2 drives
 		 */
 		if (pio_mode && pio_mode < 4) {
 			pio_mode--;
-			overridden = 1;
+			printk(KERN_INFO "%s: applying conservative "
+					 "PIO \"downgrade\"\n", drive->name);
 			if (cycle_time && cycle_time < ide_pio_timings[pio_mode].cycle_time)
 				cycle_time = 0; /* use standard timing */
 		}
@@ -321,7 +326,6 @@ u8 ide_get_best_pio_mode (ide_drive_t *d
 		d->pio_mode = pio_mode;
 		d->cycle_time = cycle_time ? cycle_time : ide_pio_timings[pio_mode].cycle_time;
 		d->use_iordy = use_iordy;
-		d->overridden = overridden;
 	}
 	return pio_mode;
 }
Index: b/drivers/ide/pci/cmd640.c
===================================================================
--- a/drivers/ide/pci/cmd640.c
+++ b/drivers/ide/pci/cmd640.c
@@ -665,13 +665,12 @@ static void cmd640_tune_drive (ide_drive
 	(void) ide_get_best_pio_mode (drive, mode_wanted, 5, &d);
 	cmd640_set_mode (index, d.pio_mode, d.cycle_time);
 
-	printk ("%s: selected cmd640 PIO mode%d (%dns)%s",
+	printk("%s: selected cmd640 PIO mode%d (%dns)",
 		drive->name,
 		d.pio_mode,
-		d.cycle_time,
-		d.overridden ? " (overriding vendor mode)" : "");
+		d.cycle_time);
+
 	display_clocks(index);
-	return;
 }
 
 #endif /* CONFIG_BLK_DEV_CMD640_ENHANCED */
Index: b/drivers/ide/pci/cmd64x.c
===================================================================
--- a/drivers/ide/pci/cmd64x.c
+++ b/drivers/ide/pci/cmd64x.c
@@ -229,9 +229,8 @@ static u8 cmd64x_tune_pio (ide_drive_t *
 	static const u8 arttim_regs[4] = {ARTTIM0, ARTTIM1, ARTTIM23, ARTTIM23};
 	pio_mode = ide_get_best_pio_mode(drive, mode_wanted, 5, &pio);
 
-	cmdprintk("%s: PIO mode wanted %d, selected %d (%d ns)%s\n",
-		  drive->name, mode_wanted, pio_mode, pio.cycle_time,
-		  pio.overridden ? " (overriding vendor mode)" : "");
+	cmdprintk("%s: PIO mode wanted %d, selected %d (%d ns)\n",
+		  drive->name, mode_wanted, pio_mode, pio.cycle_time);
 
 	program_cycle_times(drive, pio.cycle_time,
 			    ide_pio_timings[pio_mode].active_time);
Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -1375,7 +1375,6 @@ typedef struct ide_pio_timings_s {
 typedef struct ide_pio_data_s {
 	u8 pio_mode;
 	u8 use_iordy;
-	u8 overridden;
 	unsigned int cycle_time;
 } ide_pio_data_t;
 
