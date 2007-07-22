From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 7/11] ide: add __ide_wait_stat() helper
Date: Sun, 22 Jul 2007 20:31:30 +0200
Message-ID: <200707222031.30499.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.190]:48318 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756266AbXGVSTJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 22 Jul 2007 14:19:09 -0400
Received: by nf-out-0910.google.com with SMTP id g13so97866nfb
        for <linux-ide@vger.kernel.org>; Sun, 22 Jul 2007 11:19:07 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>


* Split off checking of the status register from ide_wait_stat() to
  __ide_wait_stat() helper.

* Use the new helper in ide_config_drive_speed().  The only change in the
  functionality is that the function now fails if after 20 sec (WAIT_CMD)
  device is still busy (BUSY_STAT bit is set) while previously instead of
  failing the function continued with checking for the correct device status
  (which would give the device additional 10 usec to clear BUSY_STAT bit).

* Remove stale comment for ide_config_drive_speed().

* Remove duplicate comment for ide_wait_stat() from <linux/ide.h>.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-iops.c |   96 ++++++++++++++++++++++---------------------------
 include/linux/ide.h    |   11 -----
 2 files changed, 45 insertions(+), 62 deletions(-)

Index: b/drivers/ide/ide-iops.c
===================================================================
--- a/drivers/ide/ide-iops.c
+++ b/drivers/ide/ide-iops.c
@@ -505,25 +505,19 @@ int wait_for_ready (ide_drive_t *drive, 
  * This routine busy-waits for the drive status to be not "busy".
  * It then checks the status for all of the "good" bits and none
  * of the "bad" bits, and if all is okay it returns 0.  All other
- * cases return 1 after invoking ide_error() -- caller should just return.
+ * cases return error -- caller may then invoke ide_error().
  *
  * This routine should get fixed to not hog the cpu during extra long waits..
  * That could be done by busy-waiting for the first jiffy or two, and then
  * setting a timer to wake up at half second intervals thereafter,
  * until timeout is achieved, before timing out.
  */
-int ide_wait_stat (ide_startstop_t *startstop, ide_drive_t *drive, u8 good, u8 bad, unsigned long timeout)
+static int __ide_wait_stat(ide_drive_t *drive, u8 good, u8 bad, unsigned long timeout, u8 *rstat)
 {
-	ide_hwif_t *hwif = HWIF(drive);
-	u8 stat;
-	int i;
+	ide_hwif_t *hwif = drive->hwif;
 	unsigned long flags;
- 
-	/* bail early if we've exceeded max_failures */
-	if (drive->max_failures && (drive->failures > drive->max_failures)) {
-		*startstop = ide_stopped;
-		return 1;
-	}
+	int i;
+	u8 stat;
 
 	udelay(1);	/* spec allows drive 400ns to assert "BUSY" */
 	if ((stat = hwif->INB(IDE_STATUS_REG)) & BUSY_STAT) {
@@ -541,8 +535,8 @@ int ide_wait_stat (ide_startstop_t *star
 					break;
 
 				local_irq_restore(flags);
-				*startstop = ide_error(drive, "status timeout", stat);
-				return 1;
+				*rstat = stat;
+				return -EBUSY;
 			}
 		}
 		local_irq_restore(flags);
@@ -556,11 +550,39 @@ int ide_wait_stat (ide_startstop_t *star
 	 */
 	for (i = 0; i < 10; i++) {
 		udelay(1);
-		if (OK_STAT((stat = hwif->INB(IDE_STATUS_REG)), good, bad))
+		if (OK_STAT((stat = hwif->INB(IDE_STATUS_REG)), good, bad)) {
+			*rstat = stat;
 			return 0;
+		}
 	}
-	*startstop = ide_error(drive, "status error", stat);
-	return 1;
+	*rstat = stat;
+	return -EFAULT;
+}
+
+/*
+ * In case of error returns error value after doing "*startstop = ide_error()".
+ * The caller should return the updated value of "startstop" in this case,
+ * "startstop" is unchanged when the function returns 0.
+ */
+int ide_wait_stat(ide_startstop_t *startstop, ide_drive_t *drive, u8 good, u8 bad, unsigned long timeout)
+{
+	int err;
+	u8 stat;
+
+	/* bail early if we've exceeded max_failures */
+	if (drive->max_failures && (drive->failures > drive->max_failures)) {
+		*startstop = ide_stopped;
+		return 1;
+	}
+
+	err = __ide_wait_stat(drive, good, bad, timeout, &stat);
+
+	if (err) {
+		char *s = (err == -EBUSY) ? "status timeout" : "status error";
+		*startstop = ide_error(drive, s, stat);
+	}
+
+	return err;
 }
 
 EXPORT_SYMBOL(ide_wait_stat);
@@ -777,15 +799,10 @@ int ide_driveid_update (ide_drive_t *dri
 #endif
 }
 
-/*
- * Similar to ide_wait_stat(), except it never calls ide_error internally.
- *
- * const char *msg == consider adding for verbose errors.
- */
-int ide_config_drive_speed (ide_drive_t *drive, u8 speed)
+int ide_config_drive_speed(ide_drive_t *drive, u8 speed)
 {
-	ide_hwif_t *hwif	= HWIF(drive);
-	int	i, error	= 1;
+	ide_hwif_t *hwif = drive->hwif;
+	int error;
 	u8 stat;
 
 //	while (HWGROUP(drive)->busy)
@@ -825,35 +842,10 @@ int ide_config_drive_speed (ide_drive_t 
 	hwif->OUTBSYNC(drive, WIN_SETFEATURES, IDE_COMMAND_REG);
 	if ((IDE_CONTROL_REG) && (drive->quirk_list == 2))
 		hwif->OUTB(drive->ctl, IDE_CONTROL_REG);
-	udelay(1);
-	/*
-	 * Wait for drive to become non-BUSY
-	 */
-	if ((stat = hwif->INB(IDE_STATUS_REG)) & BUSY_STAT) {
-		unsigned long flags, timeout;
-		local_irq_set(flags);
-		timeout = jiffies + WAIT_CMD;
-		while ((stat = hwif->INB(IDE_STATUS_REG)) & BUSY_STAT) {
-			if (time_after(jiffies, timeout))
-				break;
-		}
-		local_irq_restore(flags);
-	}
 
-	/*
-	 * Allow status to settle, then read it again.
-	 * A few rare drives vastly violate the 400ns spec here,
-	 * so we'll wait up to 10usec for a "good" status
-	 * rather than expensively fail things immediately.
-	 * This fix courtesy of Matthew Faupel & Niccolo Rigacci.
-	 */
-	for (i = 0; i < 10; i++) {
-		udelay(1);
-		if (OK_STAT((stat = hwif->INB(IDE_STATUS_REG)), drive->ready_stat, BUSY_STAT|DRQ_STAT|ERR_STAT)) {
-			error = 0;
-			break;
-		}
-	}
+	error = __ide_wait_stat(drive, drive->ready_stat,
+				BUSY_STAT|DRQ_STAT|ERR_STAT,
+				WAIT_CMD, &stat);
 
 	SELECT_MASK(drive, 0);
 
Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -1078,16 +1078,7 @@ extern void ide_fix_driveid(struct hd_dr
  */
 extern void ide_fixstring(u8 *, const int, const int);
 
-/*
- * This routine busy-waits for the drive status to be not "busy".
- * It then checks the status for all of the "good" bits and none
- * of the "bad" bits, and if all is okay it returns 0.  All other
- * cases return 1 after doing "*startstop = ide_error()", and the
- * caller should return the updated value of "startstop" in this case.
- * "startstop" is unchanged when the function returns 0;
- * (startstop, drive, good, bad, timeout)
- */
-extern int ide_wait_stat(ide_startstop_t *, ide_drive_t *, u8, u8, unsigned long);
+int ide_wait_stat(ide_startstop_t *, ide_drive_t *, u8, u8, unsigned long);
 
 /*
  * Start a reset operation for an IDE interface.
