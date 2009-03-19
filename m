From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH 2/2] ide: inline SELECT_DRIVE()
Date: Thu, 19 Mar 2009 19:35:13 +0400
Message-ID: <200903191835.13048.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:65504 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754405AbZCSPea (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 19 Mar 2009 11:34:30 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org

Since SELECT_DRIVE() has boiled down to a mere dev_select() method call, it now
makes sense to just inline it...

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
This patch is atop of the latest pata-2.6 series...

 drivers/ide/ide-eh.c    |    7 ++++---
 drivers/ide/ide-io.c    |    2 +-
 drivers/ide/ide-iops.c  |    7 +------
 drivers/ide/ide-pm.c    |    5 +++--
 drivers/ide/ide-probe.c |   15 ++++++++-------
 drivers/ide/ns87415.c   |    2 +-
 include/linux/ide.h     |    1 -
 7 files changed, 18 insertions(+), 21 deletions(-)

Index: linux-2.6/drivers/ide/ide-eh.c
===================================================================
--- linux-2.6.orig/drivers/ide/ide-eh.c
+++ linux-2.6/drivers/ide/ide-eh.c
@@ -165,11 +165,12 @@ static ide_startstop_t do_reset1(ide_dri
 static ide_startstop_t atapi_reset_pollfunc(ide_drive_t *drive)
 {
 	ide_hwif_t *hwif = drive->hwif;
+	const struct ide_tp_ops *tp_ops = hwif->tp_ops;
 	u8 stat;
 
-	SELECT_DRIVE(drive);
+	tp_ops->dev_select(drive);
 	udelay(10);
-	stat = hwif->tp_ops->read_status(hwif);
+	stat = tp_ops->read_status(hwif);
 
 	if (OK_STAT(stat, 0, ATA_BUSY))
 		printk(KERN_INFO "%s: ATAPI reset complete\n", drive->name);
@@ -348,7 +349,7 @@ static ide_startstop_t do_reset1(ide_dri
 	/* For an ATAPI device, first try an ATAPI SRST. */
 	if (drive->media != ide_disk && !do_not_try_atapi) {
 		pre_reset(drive);
-		SELECT_DRIVE(drive);
+		tp_ops->dev_select(drive);
 		udelay(20);
 		tp_ops->exec_command(hwif, ATA_CMD_DEV_RESET);
 		ndelay(400);
Index: linux-2.6/drivers/ide/ide-io.c
===================================================================
--- linux-2.6.orig/drivers/ide/ide-io.c
+++ linux-2.6/drivers/ide/ide-io.c
@@ -348,7 +348,7 @@ static ide_startstop_t start_request (id
 	if (blk_pm_request(rq))
 		ide_check_pm_state(drive, rq);
 
-	SELECT_DRIVE(drive);
+	drive->hwif->tp_ops->dev_select(drive);
 	if (ide_wait_stat(&startstop, drive, drive->ready_stat,
 			  ATA_BUSY | ATA_DRQ, WAIT_READY)) {
 		printk(KERN_ERR "%s: drive not ready for command\n", drive->name);
Index: linux-2.6/drivers/ide/ide-iops.c
===================================================================
--- linux-2.6.orig/drivers/ide/ide-iops.c
+++ linux-2.6/drivers/ide/ide-iops.c
@@ -27,11 +27,6 @@
 #include <asm/uaccess.h>
 #include <asm/io.h>
 
-void SELECT_DRIVE(ide_drive_t *drive)
-{
-	drive->hwif->tp_ops->dev_select(drive);
-}
-
 void SELECT_MASK(ide_drive_t *drive, int mask)
 {
 	const struct ide_port_ops *port_ops = drive->hwif->port_ops;
@@ -347,7 +342,7 @@ int ide_config_drive_speed(ide_drive_t *
 	disable_irq_nosync(hwif->irq);
 
 	udelay(1);
-	SELECT_DRIVE(drive);
+	tp_ops->dev_select(drive);
 	SELECT_MASK(drive, 1);
 	udelay(1);
 	tp_ops->write_devctl(hwif, ATA_NIEN | ATA_DEVCTL_OBS);
Index: linux-2.6/drivers/ide/ide-pm.c
===================================================================
--- linux-2.6.orig/drivers/ide/ide-pm.c
+++ linux-2.6/drivers/ide/ide-pm.c
@@ -223,6 +223,7 @@ void ide_check_pm_state(ide_drive_t *dri
 		 * point.
 		 */
 		ide_hwif_t *hwif = drive->hwif;
+		const struct ide_tp_ops *tp_ops = hwif->tp_ops;
 		struct request_queue *q = drive->queue;
 		unsigned long flags;
 		int rc;
@@ -232,8 +233,8 @@ void ide_check_pm_state(ide_drive_t *dri
 		rc = ide_wait_not_busy(hwif, 35000);
 		if (rc)
 			printk(KERN_WARNING "%s: bus not ready on wakeup\n", drive->name);
-		SELECT_DRIVE(drive);
-		hwif->tp_ops->write_devctl(hwif, ATA_DEVCTL_OBS);
+		tp_ops->dev_select(drive);
+		tp_ops->write_devctl(hwif, ATA_DEVCTL_OBS);
 		rc = ide_wait_not_busy(hwif, 100000);
 		if (rc)
 			printk(KERN_WARNING "%s: drive not ready on wakeup\n", drive->name);
Index: linux-2.6/drivers/ide/ide-probe.c
===================================================================
--- linux-2.6.orig/drivers/ide/ide-probe.c
+++ linux-2.6/drivers/ide/ide-probe.c
@@ -390,13 +390,13 @@ static int do_probe (ide_drive_t *drive,
 	 * (e.g. crw9624 as drive0 with disk as slave)
 	 */
 	msleep(50);
-	SELECT_DRIVE(drive);
+	tp_ops->dev_select(drive);
 	msleep(50);
 
 	if (ide_read_device(drive) != drive->select && present == 0) {
 		if (drive->dn & 1) {
 			/* exit with drive0 selected */
-			SELECT_DRIVE(hwif->devices[0]);
+			tp_ops->dev_select(hwif->devices[0]);
 			/* allow ATA_BUSY to assert & clear */
 			msleep(50);
 		}
@@ -422,7 +422,7 @@ static int do_probe (ide_drive_t *drive,
 			printk(KERN_ERR "%s: no response (status = 0x%02x), "
 					"resetting drive\n", drive->name, stat);
 			msleep(50);
-			SELECT_DRIVE(drive);
+			tp_ops->dev_select(drive);
 			msleep(50);
 			tp_ops->exec_command(hwif, ATA_CMD_DEV_RESET);
 			(void)ide_busy_sleep(hwif, WAIT_WORSTCASE, 0);
@@ -441,7 +441,7 @@ static int do_probe (ide_drive_t *drive,
 	}
 	if (drive->dn & 1) {
 		/* exit with drive0 selected */
-		SELECT_DRIVE(hwif->devices[0]);
+		tp_ops->dev_select(hwif->devices[0]);
 		msleep(50);
 		/* ensure drive irq is clear */
 		(void)tp_ops->read_status(hwif);
@@ -605,6 +605,7 @@ out:
 
 static int ide_port_wait_ready(ide_hwif_t *hwif)
 {
+	const struct ide_tp_ops *tp_ops = hwif->tp_ops;
 	ide_drive_t *drive;
 	int i, rc;
 
@@ -627,8 +628,8 @@ static int ide_port_wait_ready(ide_hwif_
 		/* Ignore disks that we will not probe for later. */
 		if ((drive->dev_flags & IDE_DFLAG_NOPROBE) == 0 ||
 		    (drive->dev_flags & IDE_DFLAG_PRESENT)) {
-			SELECT_DRIVE(drive);
-			hwif->tp_ops->write_devctl(hwif, ATA_DEVCTL_OBS);
+			tp_ops->dev_select(drive);
+			tp_ops->write_devctl(hwif, ATA_DEVCTL_OBS);
 			mdelay(2);
 			rc = ide_wait_not_busy(hwif, 35000);
 			if (rc)
@@ -640,7 +641,7 @@ static int ide_port_wait_ready(ide_hwif_
 out:
 	/* Exit function with master reselected (let's be sane) */
 	if (i)
-		SELECT_DRIVE(hwif->devices[0]);
+		tp_ops->dev_select(hwif->devices[0]);
 
 	return rc;
 }
Index: linux-2.6/drivers/ide/ns87415.c
===================================================================
--- linux-2.6.orig/drivers/ide/ns87415.c
+++ linux-2.6/drivers/ide/ns87415.c
@@ -259,7 +259,7 @@ static void __devinit init_hwif_ns87415 
 #ifdef __sparc_v9__
 		/*
 		 * XXX: Reset the device, if we don't it will not respond to
-		 *      SELECT_DRIVE() properly during first ide_probe_port().
+		 *      dev_select() properly during first ide_probe_port().
 		 */
 		timeout = 10000;
 		outb(12, hwif->io_ports.ctl_addr);
Index: linux-2.6/include/linux/ide.h
===================================================================
--- linux-2.6.orig/include/linux/ide.h
+++ linux-2.6/include/linux/ide.h
@@ -1175,7 +1175,6 @@ void ide_tf_read(ide_drive_t *, struct i
 void ide_input_data(ide_drive_t *, struct ide_cmd *, void *, unsigned int);
 void ide_output_data(ide_drive_t *, struct ide_cmd *, void *, unsigned int);
 
-extern void SELECT_DRIVE(ide_drive_t *);
 void SELECT_MASK(ide_drive_t *, int);
 
 u8 ide_read_error(ide_drive_t *);

