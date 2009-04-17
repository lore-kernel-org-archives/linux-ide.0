From: Tejun Heo <tj@kernel.org>
Subject: [PATCH 11/15] ide: add helpers for preparing sense requests
Date: Fri, 17 Apr 2009 18:33:18 +0900
Message-ID: <1239960802-31978-12-git-send-email-tj@kernel.org>
References: <1239960802-31978-1-git-send-email-tj@kernel.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:39994 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759230AbZDQJds (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 17 Apr 2009 05:33:48 -0400
In-Reply-To: <1239960802-31978-1-git-send-email-tj@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: petkovbb@googlemail.com, bzolnier@gmail.com, axboe@kernel.dk, linux-ide@vger.kernel.org
Cc: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>, Borislav Petkov <petkovbb@gmail.com>, Tejun Heo <tj@kernel.org>

From: Borislav Petkov <petkovbb@googlemail.com>

This is in preparation of removing the queueing of a sense request out
of the IRQ handler path.

Use struct request_sense as a general sense buffer for all ATAPI
devices ide-{floppy,tape,cd}.

tj: * blk_get_request(__GFP_WAIT) can't be called from do_request() as
      it can cause deadlock.  Converted to use inline struct request
      and blk_rq_init().

    * Added xfer / cdb len selection depending on device type.

    * All sense prep logics folded into ide_prep_sense() which never
      fails.

    * hwif->rq clearing and sense_rq used handling moved into
      ide_queue_sense_rq().

    * blk_rq_map_kern() conversion is moved to later patch.

CC: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
CC: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 drivers/ide/ide-atapi.c |   61 +++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/ide.h     |   11 ++++++++
 2 files changed, 72 insertions(+), 0 deletions(-)

diff --git a/drivers/ide/ide-atapi.c b/drivers/ide/ide-atapi.c
index 2894577..c6e0348 100644
--- a/drivers/ide/ide-atapi.c
+++ b/drivers/ide/ide-atapi.c
@@ -191,6 +191,67 @@ void ide_create_request_sense_cmd(ide_drive_t *drive, struct ide_atapi_pc *pc)
 }
 EXPORT_SYMBOL_GPL(ide_create_request_sense_cmd);
 
+void ide_prep_sense(ide_drive_t *drive, struct request *rq)
+{
+	struct request_sense *sense = &drive->sense_data;
+	struct request *sense_rq = &drive->sense_rq;
+	unsigned int cmd_len, sense_len;
+
+	debug_log("%s: enter\n", __func__);
+
+	switch (drive->media) {
+	case ide_floppy:
+		cmd_len = 255;
+		sense_len = 18;
+		break;
+	case ide_tape:
+		cmd_len = 20;
+		sense_len = 20;
+		break;
+	default:
+		cmd_len = 18;
+		sense_len = 18;
+	}
+
+	BUG_ON(sense_len > sizeof(*sense));
+
+	if (blk_sense_request(rq) || drive->sense_rq_armed)
+		return;
+
+	memset(sense, 0, sizeof(*sense));
+
+	blk_rq_init(rq->q, sense_rq);
+	sense_rq->rq_disk = rq->rq_disk;
+
+	sense_rq->data = sense;
+	sense_rq->cmd[0] = GPCMD_REQUEST_SENSE;
+	sense_rq->cmd[4] = cmd_len;
+	sense_rq->data_len = sense_len;
+
+	sense_rq->cmd_type = REQ_TYPE_SENSE;
+	sense_rq->cmd_flags |= REQ_PREEMPT;
+
+	if (drive->media == ide_tape)
+		sense_rq->cmd[13] = REQ_IDETAPE_PC1;
+
+	drive->sense_rq_armed = true;
+}
+EXPORT_SYMBOL_GPL(ide_prep_sense);
+
+void ide_queue_sense_rq(ide_drive_t *drive, void *special)
+{
+	BUG_ON(!drive->sense_rq_armed);
+
+	drive->sense_rq.special = special;
+	drive->sense_rq_armed = false;
+
+	drive->hwif->rq = NULL;
+
+	elv_add_request(drive->queue, &drive->sense_rq,
+			ELEVATOR_INSERT_FRONT, 0);
+}
+EXPORT_SYMBOL_GPL(ide_queue_sense_rq);
+
 /*
  * Called when an error was detected during the last packet command.
  * We queue a request sense packet command in the head of the request list.
diff --git a/include/linux/ide.h b/include/linux/ide.h
index 846a1e1..a69ccac 100644
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -26,6 +26,9 @@
 #include <asm/io.h>
 #include <asm/mutex.h>
 
+/* for request_sense */
+#include <linux/cdrom.h>
+
 #if defined(CONFIG_CRIS) || defined(CONFIG_FRV) || defined(CONFIG_MN10300)
 # define SUPPORT_VLB_SYNC 0
 #else
@@ -602,6 +605,11 @@ struct ide_drive_s {
 
 	struct ide_atapi_pc request_sense_pc;
 	struct request request_sense_rq;
+
+	/* current sense rq and buffer */
+	bool sense_rq_armed;
+	struct request sense_rq;
+	struct request_sense sense_data;
 };
 
 typedef struct ide_drive_s ide_drive_t;
@@ -1175,6 +1183,9 @@ int ide_set_media_lock(ide_drive_t *, struct gendisk *, int);
 void ide_create_request_sense_cmd(ide_drive_t *, struct ide_atapi_pc *);
 void ide_retry_pc(ide_drive_t *, struct gendisk *);
 
+void ide_prep_sense(ide_drive_t *drive, struct request *rq);
+void ide_queue_sense_rq(ide_drive_t *drive, void *special);
+
 int ide_cd_expiry(ide_drive_t *);
 
 int ide_cd_get_xferlen(struct request *);
-- 
1.6.0.2

