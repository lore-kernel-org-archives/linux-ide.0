From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 13/20] ide: initialize rq->cmd_type in ide_init_drive_cmd() callers
Date: Sun, 9 Dec 2007 22:16:50 +0100
Message-ID: <200712092216.50738.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.168]:55840 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751502AbXLIVVE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 9 Dec 2007 16:21:04 -0500
Received: by ug-out-1314.google.com with SMTP id z38so1381341ugc
        for <linux-ide@vger.kernel.org>; Sun, 09 Dec 2007 13:21:02 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


* Initialize rq->cmd_type in ide_wait_cmd(), ide_cmd_ioctl() and
  set_pio_mode() (other callers were aleady over-riding rq->cmd_type).

* Remove no longer needed rq->cmd_type setup from ide_init_drive_cmd().

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-io.c       |    1 -
 drivers/ide/ide-taskfile.c |    4 ++++
 drivers/ide/ide.c          |    3 +++
 3 files changed, 7 insertions(+), 1 deletion(-)

Index: b/drivers/ide/ide-io.c
===================================================================
--- a/drivers/ide/ide-io.c
+++ b/drivers/ide/ide-io.c
@@ -1671,7 +1671,6 @@ irqreturn_t ide_intr (int irq, void *dev
 void ide_init_drive_cmd (struct request *rq)
 {
 	memset(rq, 0, sizeof(*rq));
-	rq->cmd_type = REQ_TYPE_ATA_CMD;
 	rq->ref_count = 1;
 }
 
Index: b/drivers/ide/ide-taskfile.c
===================================================================
--- a/drivers/ide/ide-taskfile.c
+++ b/drivers/ide/ide-taskfile.c
@@ -760,6 +760,7 @@ int ide_wait_cmd (ide_drive_t *drive, u8
 		buf = buffer;
 	memset(buf, 0, 4 + SECTOR_WORDS * 4 * sectors);
 	ide_init_drive_cmd(&rq);
+	rq.cmd_type = REQ_TYPE_ATA_CMD;
 	rq.buffer = buf;
 	*buf++ = cmd;
 	*buf++ = nsect;
@@ -779,7 +780,10 @@ int ide_cmd_ioctl (ide_drive_t *drive, u
 
 	if (NULL == (void *) arg) {
 		struct request rq;
+
 		ide_init_drive_cmd(&rq);
+		rq.cmd_type = REQ_TYPE_ATA_CMD;
+
 		return ide_do_drive_cmd(drive, &rq, ide_wait);
 	}
 
Index: b/drivers/ide/ide.c
===================================================================
--- a/drivers/ide/ide.c
+++ b/drivers/ide/ide.c
@@ -874,7 +874,10 @@ int set_pio_mode(ide_drive_t *drive, int
 
 	if (drive->special.b.set_tune)
 		return -EBUSY;
+
 	ide_init_drive_cmd(&rq);
+	rq.cmd_type = REQ_TYPE_ATA_CMD;
+
 	drive->tune_req = (u8) arg;
 	drive->special.b.set_tune = 1;
 	(void) ide_do_drive_cmd(drive, &rq, ide_wait);
