From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 2/3] ide: remove redundant comments from ide.h
Date: Wed, 19 Sep 2007 22:10:19 +0200
Message-ID: <200709192210.19234.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.171]:63279 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751924AbXISUId (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 19 Sep 2007 16:08:33 -0400
Received: by ug-out-1314.google.com with SMTP id z38so300888ugc
        for <linux-ide@vger.kernel.org>; Wed, 19 Sep 2007 13:08:32 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


There is better documentation for these functions in drivers/ide/.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 include/linux/ide.h |   41 -----------------------------------------
 1 file changed, 41 deletions(-)

Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -228,9 +228,6 @@ struct hwif_s * ide_find_port(unsigned l
 int ide_register_hw(hw_regs_t *, void (*)(struct hwif_s *), int,
 		    struct hwif_s **);
 
-/*
- * Set up hw_regs_t structure before calling ide_register_hw (optional)
- */
 void ide_setup_ports(	hw_regs_t *hw,
 			unsigned long base,
 			int *offsets,
@@ -1031,36 +1028,16 @@ extern int ide_end_request (ide_drive_t 
 int ide_end_dequeued_request(ide_drive_t *drive, struct request *rq,
 			     int uptodate, int nr_sectors);
 
-/*
- * This is used on exit from the driver to designate the next irq handler
- * and also to start the safety timer.
- */
 extern void ide_set_handler (ide_drive_t *drive, ide_handler_t *handler, unsigned int timeout, ide_expiry_t *expiry);
 
-/*
- * This is used on exit from the driver to designate the next irq handler
- * and start the safety time safely and atomically from the IRQ handler
- * with respect to the command issue (which it also does)
- */
 extern void ide_execute_command(ide_drive_t *, task_ioreg_t cmd, ide_handler_t *, unsigned int, ide_expiry_t *);
 
 ide_startstop_t __ide_error(ide_drive_t *, struct request *, u8, u8);
 
-/*
- * ide_error() takes action based on the error returned by the controller.
- * The caller should return immediately after invoking this.
- *
- * (drive, msg, status)
- */
 ide_startstop_t ide_error (ide_drive_t *drive, const char *msg, byte stat);
 
 ide_startstop_t __ide_abort(ide_drive_t *, struct request *);
 
-/*
- * Abort a running command on the controller triggering the abort
- * from a host side, non error situation
- * (drive, msg)
- */
 extern ide_startstop_t ide_abort(ide_drive_t *, const char *);
 
 extern void ide_fix_driveid(struct hd_driveid *);
@@ -1076,15 +1053,8 @@ extern void ide_fixstring(u8 *, const in
 
 int ide_wait_stat(ide_startstop_t *, ide_drive_t *, u8, u8, unsigned long);
 
-/*
- * Start a reset operation for an IDE interface.
- * The caller should return immediately after invoking this.
- */
 extern ide_startstop_t ide_do_reset (ide_drive_t *);
 
-/*
- * This function is intended to be used prior to invoking ide_do_drive_cmd().
- */
 extern void ide_init_drive_cmd (struct request *rq);
 
 /*
@@ -1104,13 +1074,6 @@ typedef enum {
 
 extern int ide_do_drive_cmd(ide_drive_t *, struct request *, ide_action_t);
 
-/*
- * Clean up after success/failure of an explicit drive cmd.
- * stat/err are used only when (HWGROUP(drive)->rq->cmd == IDE_DRIVE_CMD).
- * stat/err are used only when (HWGROUP(drive)->rq->cmd == IDE_DRIVE_TASK_MASK).
- *
- * (ide_drive_t *drive, u8 stat, u8 err)
- */
 extern void ide_end_drive_cmd(ide_drive_t *, u8, u8);
 
 /*
@@ -1183,10 +1146,6 @@ extern int taskfile_lib_get_identify(ide
 
 extern int ide_wait_not_busy(ide_hwif_t *hwif, unsigned long timeout);
 
-/*
- * ide_stall_queue() can be used by a drive to give excess bandwidth back
- * to the hwgroup by sleeping for timeout jiffies.
- */
 extern void ide_stall_queue(ide_drive_t *drive, unsigned long timeout);
 
 extern int ide_spin_wait_hwgroup(ide_drive_t *);
