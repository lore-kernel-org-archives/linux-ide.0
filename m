From: "Max T. Woodbury" <max.teneyck.woodbury@verizon.net>
Subject: Patch to add 'printk's at *_abort and IDLEIMMEDIATE.
Date: Mon, 12 Jul 2004 11:23:45 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <40F2AD01.B6EDA948@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from out006pub.verizon.net ([206.46.170.106]:7593 "EHLO
	out006.verizon.net") by vger.kernel.org with ESMTP id S266874AbUGLPXn
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 12 Jul 2004 11:23:43 -0400
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>, linux-ide@vger.kernel.org

The following patch adds printk calls to the ide *_abort functions and after
each OUTB(WIN_IDLEIMMEDIATE,IDE_COMMAND_REG) call so that there is a record
of these important error conditions in the log.  I'm not absolutely certain
that KERN_WARNING is the correct message level.  KERN_ERR or higher might be
more appropriate.

diff -urB linux-2.4.26.orig/drivers/ide/ide-cd.c linux-2.4.26.new/drivers/ide/ide-cd.c
--- linux-2.4.26.orig/drivers/ide/ide-cd.c	2003-11-28 13:26:20.000000000 -0500
+++ linux-2.4.26.new/drivers/ide/ide-cd.c	2004-07-11 14:44:42.000000000 -0400
@@ -642,9 +642,11 @@
 	} else {
 		/* add decoding error stuff */
 	}
-	if (HWIF(drive)->INB(IDE_STATUS_REG) & (BUSY_STAT|DRQ_STAT))
+	if (HWIF(drive)->INB(IDE_STATUS_REG) & (BUSY_STAT|DRQ_STAT)) {
 		/* force an abort */
 		HWIF(drive)->OUTB(WIN_IDLEIMMEDIATE,IDE_COMMAND_REG);
+		printk(KERN_WARNING "%s: ide_cdrom_error: IDLEIMMEDIATE\n", drive->name);
+		}
 	if (rq->errors >= ERROR_MAX) {
 		DRIVER(drive)->end_request(drive, 0);
 	} else {
@@ -663,6 +665,9 @@
 
 	if (drive == NULL || (rq = HWGROUP(drive)->rq) == NULL)
 		return ide_stopped;
+
+	printk(KERN_WARNING "%s: ide_cdrom_abort: %s\n", drive->name, msg);
+
 	/* retry only "normal" I/O: */
 	if (rq->cmd == IDE_DRIVE_CMD || rq->cmd == IDE_DRIVE_TASK) {
 		rq->errors = 1;
diff -urB linux-2.4.26.orig/drivers/ide/ide-disk.c linux-2.4.26.new/drivers/ide/ide-disk.c
--- linux-2.4.26.orig/drivers/ide/ide-disk.c	2003-11-28 13:26:20.000000000 -0500
+++ linux-2.4.26.new/drivers/ide/ide-disk.c	2004-07-11 14:47:39.000000000 -0400
@@ -959,6 +959,7 @@
 	if (hwif->INB(IDE_STATUS_REG) & (BUSY_STAT|DRQ_STAT)) {
 		/* force an abort */
 		hwif->OUTB(WIN_IDLEIMMEDIATE,IDE_COMMAND_REG);
+		printk(KERN_WARNING "%s: idedisk_error: IDLEIMMEDIATE\n", drive->name);
 	}
 	if (rq->errors >= ERROR_MAX)
 		DRIVER(drive)->end_request(drive, 0);
@@ -982,6 +983,8 @@
 	if (drive == NULL || (rq = HWGROUP(drive)->rq) == NULL)
 		return ide_stopped;
 
+	printk(KERN_WARNING "%s: ide_disk_abort: %s\n", drive->name, msg);
+
 	hwif = HWIF(drive);
 	/* retry only "normal" I/O: */
 	switch (rq->cmd) {
diff -urB linux-2.4.26.orig/drivers/ide/ide-io.c linux-2.4.26.new/drivers/ide/ide-io.c
--- linux-2.4.26.orig/drivers/ide/ide-io.c	2003-11-28 13:26:20.000000000 -0500
+++ linux-2.4.26.new/drivers/ide/ide-io.c	2004-07-11 14:49:50.000000000 -0400
@@ -298,6 +298,7 @@
 	if (hwif->INB(IDE_STATUS_REG) & (BUSY_STAT|DRQ_STAT)) {
 		/* force an abort */
 		hwif->OUTB(WIN_IDLEIMMEDIATE,IDE_COMMAND_REG);
+		printk(KERN_WARNING "%s: ide_error: IDLEIMMEDIATE\n", drive->name);
 	}
 	if (rq->errors >= ERROR_MAX) {
 		DRIVER(drive)->end_request(drive, 0);
@@ -337,6 +338,8 @@
 	if (drive == NULL || (rq = HWGROUP(drive)->rq) == NULL)
 		return ide_stopped;
 
+	printk(KERN_WARNING "%s: ide_abort: %s\n", drive->name, msg);
+
 	hwif = HWIF(drive);
 	/* retry only "normal" I/O: */
 	if (rq->cmd == IDE_DRIVE_CMD || rq->cmd == IDE_DRIVE_TASK) {
diff -urB linux-2.4.26.orig/drivers/ide/ide-taskfile.c linux-2.4.26.new/drivers/ide/ide-taskfile.c
--- linux-2.4.26.orig/drivers/ide/ide-taskfile.c	2003-06-13 10:51:33.000000000 -0400
+++ linux-2.4.26.new/drivers/ide/ide-taskfile.c	2004-07-11 14:35:50.000000000 -0400
@@ -478,6 +478,7 @@
 	if (hwif->INB(IDE_STATUS_REG) & (BUSY_STAT|DRQ_STAT)) {
 		/* force an abort */
 		hwif->OUTB(WIN_IDLEIMMEDIATE, IDE_COMMAND_REG);
+		printk(KERN_WARNING "%s: taskfile_error: IDLEIMMEDIATE\n", drive->name);
 	}
 	if (rq->errors >= ERROR_MAX) {
 		DRIVER(drive)->end_request(drive, 0);
