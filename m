From: Borislav Petkov <petkovbb@googlemail.com>
Subject: [PATCH 15/17] ide-tape: remove misc references to pipelined operation in the comments
Date: Mon, 17 Mar 2008 07:41:28 +0100
Message-ID: <1205736090-4435-16-git-send-email-petkovbb@gmail.com>
References: <1205736090-4435-1-git-send-email-petkovbb@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hu-out-0506.google.com ([72.14.214.238]:30337 "EHLO
	hu-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753505AbYCQGlm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 17 Mar 2008 02:41:42 -0400
Received: by hu-out-0506.google.com with SMTP id 19so3301581hue.21
        for <linux-ide@vger.kernel.org>; Sun, 16 Mar 2008 23:41:42 -0700 (PDT)
In-Reply-To: <1205736090-4435-1-git-send-email-petkovbb@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Borislav Petkov <petkovbb@gmail.com>

Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
---
 drivers/ide/ide-tape.c |   22 +++-------------------
 1 files changed, 3 insertions(+), 19 deletions(-)

diff --git a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
index 9ae42c3..a4caf2b 100644
--- a/drivers/ide/ide-tape.c
+++ b/drivers/ide/ide-tape.c
@@ -265,9 +265,7 @@ typedef struct ide_tape_obj {
 	 * While polling for DSC we use postponed_rq to postpone the current
 	 * request so that ide.c will be able to service pending requests on the
 	 * other device. Note that at most we will have only one DSC (usually
-	 * data transfer) request in the device request queue. Additional
-	 * requests can be queued in our internal pipeline, but they will be
-	 * visible to ide.c only one at a time.
+	 * data transfer) request in the device request queue.
 	 */
 	struct request *postponed_rq;
 	/* The time in which we started polling for DSC */
@@ -608,10 +606,6 @@ static void __idetape_kfree_stage(idetape_stage_t *stage)
 	kfree(stage);
 }
 
-/*
- * Finish servicing a request and insert a pending pipeline request into the
- * main device queue.
- */
 static int idetape_end_request(ide_drive_t *drive, int uptodate, int nr_sects)
 {
 	struct request *rq = HWGROUP(drive)->rq;
@@ -1291,8 +1285,6 @@ out:
 	return idetape_issue_pc(drive, pc);
 }
 
-/* Pipeline related functions */
-
 /*
  * The function below uses __get_free_page to allocate a pipeline stage, along
  * with all the necessary small buffers which together make a buffer of size
@@ -1301,9 +1293,6 @@ out:
  *
  * It returns a pointer to the new allocated stage, or NULL if we can't (or
  * don't want to) allocate a stage.
- *
- * Pipeline stages are optional and are used to increase performance. If we
- * can't allocate them, we'll manage without them.
  */
 static idetape_stage_t *__idetape_kmalloc_stage(idetape_tape_t *tape, int full,
 						int clear)
@@ -1775,10 +1764,7 @@ static int idetape_init_read(ide_drive_t *drive)
 	return 0;
 }
 
-/*
- * Called from idetape_chrdev_read() to service a character device read request
- * and add read-ahead requests to our pipeline.
- */
+/* called from idetape_chrdev_read() to service a chrdev read request. */
 static int idetape_add_chrdev_read_request(ide_drive_t *drive, int blocks)
 {
 	idetape_tape_t *tape = drive->driver_data;
@@ -2107,8 +2093,7 @@ static int idetape_write_filemark(ide_drive_t *drive)
  *
  * Note: MTBSF and MTBSFM are not supported when the tape doesn't support
  * spacing over filemarks in the reverse direction. In this case, MTFSFM is also
- * usually not supported (it is supported in the rare case in which we crossed
- * the filemark during our read-ahead pipelined operation mode).
+ * usually not supported.
  *
  * The following commands are currently not supported:
  *
@@ -2124,7 +2109,6 @@ static int idetape_mtioctop(ide_drive_t *drive, short mt_op, int mt_count)
 	debug_log(DBG_ERR, "Handling MTIOCTOP ioctl: mt_op=%d, mt_count=%d\n",
 			mt_op, mt_count);
 
-	/* Commands which need our pipelined read-ahead stages. */
 	switch (mt_op) {
 	case MTFSF:
 	case MTFSFM:
-- 
1.5.4.1

