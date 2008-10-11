From: Elias Oltmanns <eo@nebensachen.de>
Subject: ide: Bug fixes and improvements in the disk head parking code
Date: Sat, 11 Oct 2008 19:37:20 +0200
Message-ID: <87fxn3hw33.fsf@denkblock.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nebensachen.de ([195.34.83.29]:53716 "EHLO mail.nebensachen.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761679AbYJKRhz (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 11 Oct 2008 13:37:55 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Fix a memory leak due to a missing blk_put_request() in
issue_park_cmd(). Additionally, we should plug the queue when enqueueing
the unpark request because there is no guarantee that the park timeout
has not expired by then. Even though the chance for that to happen is
very slim, the request might end up hanging in the queue until the next
I/O operation is queued up. While at it, clean up the code a little:
- make issue_park_cmd() a function of type void since nobody cares for
  the return value anyway;
- use blk_start_queueing() instead of __blk_run_queue() since we don't
  have to worry about recursion;
- remove a superfluous pointer deference in task_no_data_intr().

Signed-off-by: Elias Oltmanns <eo@nebensachen.de>
---
Feel free to merge with original patch if Linus hasn't pulled your tree
yet.

 ide-park.c     |   11 ++++++-----
 ide-taskfile.c |    2 +-
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/ide/ide-park.c b/drivers/ide/ide-park.c
index 02d7e35..03b00e5 100644
--- a/drivers/ide/ide-park.c
+++ b/drivers/ide/ide-park.c
@@ -5,7 +5,7 @@
 
 DECLARE_WAIT_QUEUE_HEAD(ide_park_wq);
 
-static int issue_park_cmd(ide_drive_t *drive, unsigned long timeout)
+static void issue_park_cmd(ide_drive_t *drive, unsigned long timeout)
 {
 	struct request_queue *q = drive->queue;
 	struct request *rq;
@@ -24,10 +24,10 @@ static int issue_park_cmd(ide_drive_t *drive, unsigned long timeout)
 		    del_timer(&hwgroup->timer)) {
 			hwgroup->sleeping = 0;
 			hwgroup->busy = 0;
-			__blk_run_queue(q);
+			blk_start_queueing(q);
 		}
 		spin_unlock_irq(&ide_lock);
-		return 0;
+		return;
 	}
 	spin_unlock_irq(&ide_lock);
 
@@ -37,6 +37,7 @@ static int issue_park_cmd(ide_drive_t *drive, unsigned long timeout)
 	rq->cmd_type = REQ_TYPE_SPECIAL;
 	rq->special = &timeout;
 	rc = blk_execute_rq(q, NULL, rq, 1);
+	blk_put_request(rq);
 	if (rc)
 		goto out;
 
@@ -51,10 +52,10 @@ static int issue_park_cmd(ide_drive_t *drive, unsigned long timeout)
 	rq->cmd[0] = REQ_UNPARK_HEADS;
 	rq->cmd_len = 1;
 	rq->cmd_type = REQ_TYPE_SPECIAL;
-	elv_add_request(q, rq, ELEVATOR_INSERT_FRONT, 0);
+	elv_add_request(q, rq, ELEVATOR_INSERT_FRONT, 1);
 
 out:
-	return rc;
+	return;
 }
 
 ssize_t ide_park_show(struct device *dev, struct device_attribute *attr,
diff --git a/drivers/ide/ide-taskfile.c b/drivers/ide/ide-taskfile.c
index 480c97f..bf4fb9d 100644
--- a/drivers/ide/ide-taskfile.c
+++ b/drivers/ide/ide-taskfile.c
@@ -153,7 +153,7 @@ static ide_startstop_t task_no_data_intr(ide_drive_t *drive)
 	if (!custom)
 		ide_end_drive_cmd(drive, stat, ide_read_error(drive));
 	else if (tf->command == ATA_CMD_IDLEIMMEDIATE) {
-		drive->hwif->tp_ops->tf_read(drive, task);
+		hwif->tp_ops->tf_read(drive, task);
 		if (tf->lbal != 0xc4) {
 			printk(KERN_ERR "%s: head unload failed!\n",
 			       drive->name);
