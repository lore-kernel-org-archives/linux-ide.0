From: Elias Oltmanns <eo@nebensachen.de>
Subject: [PATCH] IDE: Fix HDIO_DRIVE_RESET handling
Date: Thu, 19 Jun 2008 01:35:01 +0200
Message-ID: <87k5gmz596.fsf@denkblock.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nebensachen.de ([195.34.83.29]:42641 "EHLO mail.nebensachen.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754734AbYFRXfw (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 18 Jun 2008 19:35:52 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Hi Bart,

currently, the code path executing an HDIO_DRIVE_RESET ioctl is broken
in various ways.  Firstly, ide_abort() is called with the ide_lock held
and may call ide_end_request() further down the line which will try to
grab the same lock again.  More importantly though, the whole concept of
aborting an inflight request is flawed -- at least as far as ide_abort()
is concerned.

The patch below tries to address these issues by handling the
HDIO_DRIVE_RESET ioctl in-band.  I wonder whether this approach is
acceptable and may be extended to other applications like a modified
version of the disk shock protection patches.  Also, I abstained from
using op codes 0x0 to 0x1f since at least part of this range is used by
ULDs like ide-floppy, ide-tape, etc.  On the other hand, there really
should be no conflict because those ULDs will always set ->rq_disk thus
preventing ide_special_rq() from snatching away what should be passed on
to ->do_request().  So, what's you're advice on this one?  Finally,
shouldn't op codes like REQ_DRIVE_RESET really be declared in a private
header file in drivers/ide/?

Signed-off-by: Elias Oltmanns <eo@nebensachen.de>
---

 drivers/ide/ide-io.c |   16 +++++++++++++++-
 drivers/ide/ide.c    |   40 ++++++++++++++--------------------------
 include/linux/ide.h  |    6 ++++++
 3 files changed, 35 insertions(+), 27 deletions(-)

diff --git a/drivers/ide/ide-io.c b/drivers/ide/ide-io.c
index 6965253..b3a37b1 100644
--- a/drivers/ide/ide-io.c
+++ b/drivers/ide/ide-io.c
@@ -788,6 +788,19 @@ static ide_startstop_t execute_drive_cmd (ide_drive_t *drive,
  	return ide_stopped;
 }
 
+static ide_startstop_t ide_special_rq(ide_drive_t *drive, struct request *rq)
+{
+	switch (rq->cmd[0]) {
+	case REQ_DRIVE_RESET:
+		ide_end_request(drive, 1, 0);
+		return ide_do_reset(drive);
+	default:
+		blk_dump_rq_flags(rq, "ide_special_rq - bad request");
+		ide_end_request(drive, 0, 0);
+		return ide_stopped;
+	}
+}
+
 static void ide_check_pm_state(ide_drive_t *drive, struct request *rq)
 {
 	struct request_pm_state *pm = rq->data;
@@ -891,7 +904,8 @@ static ide_startstop_t start_request (ide_drive_t *drive, struct request *rq)
 			    pm->pm_step == ide_pm_state_completed)
 				ide_complete_pm_request(drive, rq);
 			return startstop;
-		}
+		} else if (!rq->rq_disk && blk_special_request(rq))
+			return ide_special_rq(drive, rq);
 
 		drv = *(ide_driver_t **)rq->rq_disk->private_data;
 		return drv->do_request(drive, rq, block);
diff --git a/drivers/ide/ide.c b/drivers/ide/ide.c
index c758dcb..4f9c796 100644
--- a/drivers/ide/ide.c
+++ b/drivers/ide/ide.c
@@ -623,6 +623,19 @@ static int generic_ide_resume(struct device *dev)
 	return err;
 }
 
+static void generic_drive_reset(ide_drive_t *drive)
+{
+	struct request *rq;
+
+	rq = blk_get_request(drive->queue, 0, __GFP_WAIT);
+	/* Should we call ide_init_drive_cmd() here? */
+
+	rq->cmd[0] = REQ_DRIVE_RESET;
+	rq->cmd_type = REQ_TYPE_SPECIAL;
+	rq->cmd_flags |= REQ_SOFTBARRIER;
+	ide_do_drive_cmd(drive, rq, ide_end);
+}
+
 int generic_ide_ioctl(ide_drive_t *drive, struct file *file, struct block_device *bdev,
 			unsigned int cmd, unsigned long arg)
 {
@@ -697,32 +710,7 @@ int generic_ide_ioctl(ide_drive_t *drive, struct file *file, struct block_device
 			if (!capable(CAP_SYS_ADMIN))
 				return -EACCES;
 
-			/*
-			 *	Abort the current command on the
-			 *	group if there is one, taking
-			 *	care not to allow anything else
-			 *	to be queued and to die on the
-			 *	spot if we miss one somehow
-			 */
-
-			spin_lock_irqsave(&ide_lock, flags);
-
-			if (HWGROUP(drive)->resetting) {
-				spin_unlock_irqrestore(&ide_lock, flags);
-				return -EBUSY;
-			}
-
-			ide_abort(drive, "drive reset");
-
-			BUG_ON(HWGROUP(drive)->handler);
-
-			/* Ensure nothing gets queued after we
-			   drop the lock. Reset will clear the busy */
-
-			HWGROUP(drive)->busy = 1;
-			spin_unlock_irqrestore(&ide_lock, flags);
-			(void) ide_do_reset(drive);
-
+			generic_drive_reset(drive);
 			return 0;
 		case HDIO_GET_BUSSTATE:
 			if (!capable(CAP_SYS_ADMIN))
diff --git a/include/linux/ide.h b/include/linux/ide.h
index 9918772..4c3e802 100644
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -842,6 +842,12 @@ int ide_wait_stat(ide_startstop_t *, ide_drive_t *, u8, u8, unsigned long);
 
 extern ide_startstop_t ide_do_reset (ide_drive_t *);
 
+/*
+ * Op codes for special requests to be handled by ide_special_rq().
+ * Values should be in the range of 0x20 to 0x3f.
+ */
+#define REQ_DRIVE_RESET		0x20
+
 extern void ide_init_drive_cmd (struct request *rq);
 
 /*
