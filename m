From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH] (pata-2.6 fix queue) ide_get_best_pio_mode() returns incorrect IORDY setting (take 2)
Date: Thu, 8 Feb 2007 16:57:39 +0300
Message-ID: <200702081657.39757.sshtylyov@ru.mvista.com>
References: <200702081632.43844.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:44253 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752327AbXBHN5q (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 8 Feb 2007 08:57:46 -0500
In-Reply-To: <200702081632.43844.sshtylyov@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org

The function ide_get_best_pio_mode() fails to return the correct IORDY setting
for the explicitly specified modes -- fix this along with the heading comment,
and also remove the long commented out code.

Also, while at it, correct the misliading comment about the PIO cycle time in
<linux/ide.h> -- it actually consists of only the active and recovery periods,
with only some chips also including the address setup time into equation...

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

 drivers/ide/ide-lib.c |   18 ++++++------------
 include/linux/ide.h   |    3 ++-
 2 files changed, 8 insertions(+), 13 deletions(-)

Index: linux-2.6/drivers/ide/ide-lib.c
===================================================================
--- linux-2.6.orig/drivers/ide/ide-lib.c
+++ linux-2.6/drivers/ide/ide-lib.c
@@ -330,16 +330,16 @@ static int ide_scan_pio_blacklist (char 
 
 /**
  *	ide_get_best_pio_mode	-	get PIO mode from drive
- *	@driver: drive to consider
+ *	@drive: drive to consider
  *	@mode_wanted: preferred mode
- *	@max_mode: highest allowed
- *	@d: pio data
+ *	@max_mode: highest allowed mode
+ *	@d: PIO data
  *
  *	This routine returns the recommended PIO settings for a given drive,
  *	based on the drive->id information and the ide_pio_blacklist[].
- *	This is used by most chipset support modules when "auto-tuning".
  *
- *	Drive PIO mode auto selection
+ *	Drive PIO mode is auto-selected if 255 is passed as mode_wanted.
+ *	This is used by most chipset support modules when "auto-tuning".
  */
 
 u8 ide_get_best_pio_mode (ide_drive_t *drive, u8 mode_wanted, u8 max_mode, ide_pio_data_t *d)
@@ -353,6 +353,7 @@ u8 ide_get_best_pio_mode (ide_drive_t *d
 
 	if (mode_wanted != 255) {
 		pio_mode = mode_wanted;
+		use_iordy = (pio_mode > 2);
 	} else if (!drive->id) {
 		pio_mode = 0;
 	} else if ((pio_mode = ide_scan_pio_blacklist(id->model)) != -1) {
@@ -383,19 +384,12 @@ u8 ide_get_best_pio_mode (ide_drive_t *d
 			}
 		}
 
-#if 0
-		if (drive->id->major_rev_num & 0x0004) printk("ATA-2 ");
-#endif
-
 		/*
 		 * Conservative "downgrade" for all pre-ATA2 drives
 		 */
 		if (pio_mode && pio_mode < 4) {
 			pio_mode--;
 			overridden = 1;
-#if 0
-			use_iordy = (pio_mode > 2);
-#endif
 			if (cycle_time && cycle_time < ide_pio_timings[pio_mode].cycle_time)
 				cycle_time = 0; /* use standard timing */
 		}
Index: linux-2.6/include/linux/ide.h
===================================================================
--- linux-2.6.orig/include/linux/ide.h
+++ linux-2.6/include/linux/ide.h
@@ -1333,7 +1333,8 @@ u8 ide_dump_status(ide_drive_t *, const 
 typedef struct ide_pio_timings_s {
 	int	setup_time;	/* Address setup (ns) minimum */
 	int	active_time;	/* Active pulse (ns) minimum */
-	int	cycle_time;	/* Cycle time (ns) minimum = (setup + active + recovery) */
+	int	cycle_time;	/* Cycle time (ns) minimum = */
+				/* active + recovery (+ setup for some chips) */
 } ide_pio_timings_t;
 
 typedef struct ide_pio_data_s {

