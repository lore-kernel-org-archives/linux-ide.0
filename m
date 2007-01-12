From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 8/19] ide: remove write-only ide_pio_data_t.blacklisted
Date: Fri, 12 Jan 2007 05:26:58 +0100
Message-ID: <20070112042658.28794.88286.sendpatchset@localhost.localdomain>
References: <20070112042621.28794.6937.sendpatchset@localhost.localdomain>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1030485AbXALEXa@vger.kernel.org>
In-Reply-To: <20070112042621.28794.6937.sendpatchset@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

[PATCH] ide: remove write-only ide_pio_data_t.blacklisted

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

---
 drivers/ide/ide-lib.c |    3 ---
 include/linux/ide.h   |    1 -
 2 files changed, 4 deletions(-)

Index: a/drivers/ide/ide-lib.c
===================================================================
--- a.orig/drivers/ide/ide-lib.c
+++ a/drivers/ide/ide-lib.c
@@ -349,7 +349,6 @@ u8 ide_get_best_pio_mode (ide_drive_t *d
 	int use_iordy = 0;
 	struct hd_driveid* id = drive->id;
 	int overridden  = 0;
-	int blacklisted = 0;
 
 	if (mode_wanted != 255) {
 		pio_mode = mode_wanted;
@@ -357,7 +356,6 @@ u8 ide_get_best_pio_mode (ide_drive_t *d
 		pio_mode = 0;
 	} else if ((pio_mode = ide_scan_pio_blacklist(id->model)) != -1) {
 		overridden = 1;
-		blacklisted = 1;
 		use_iordy = (pio_mode > 2);
 	} else {
 		pio_mode = id->tPIO;
@@ -409,7 +407,6 @@ u8 ide_get_best_pio_mode (ide_drive_t *d
 		d->cycle_time = cycle_time ? cycle_time : ide_pio_timings[pio_mode].cycle_time;
 		d->use_iordy = use_iordy;
 		d->overridden = overridden;
-		d->blacklisted = blacklisted;
 	}
 	return pio_mode;
 }
Index: a/include/linux/ide.h
===================================================================
--- a.orig/include/linux/ide.h
+++ a/include/linux/ide.h
@@ -1340,7 +1340,6 @@ typedef struct ide_pio_data_s {
 	u8 pio_mode;
 	u8 use_iordy;
 	u8 overridden;
-	u8 blacklisted;
 	unsigned int cycle_time;
 } ide_pio_data_t;
 
