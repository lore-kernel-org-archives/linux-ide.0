From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 06/14] ide: set IDE_TFLAG_WRITE basing on data phase used in ide_taskfile_ioctl()
Date: Mon, 02 Feb 2009 22:37:48 +0100
Message-ID: <20090202213748.17960.34658.sendpatchset@localhost.localdomain>
References: <20090202213707.17960.61897.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f20.google.com ([209.85.220.20]:63868 "EHLO
	mail-fx0-f20.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755924AbZBBVgx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 2 Feb 2009 16:36:53 -0500
In-Reply-To: <20090202213707.17960.61897.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ide: set IDE_TFLAG_WRITE basing on data phase used in ide_taskfile_ioctl()

Also take care of fixing up incorrect TASKFILE_IN_DMA[Q] data phase when
IDE_DRIVE_TASK_RAW_WRITE is requested (no need to do it for TASKFILE_NO_DATA
and TASKFILE_[MULTI]_IN -- it had no chance of working previously).

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-taskfile.c |   13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

Index: b/drivers/ide/ide-taskfile.c
===================================================================
--- a/drivers/ide/ide-taskfile.c
+++ b/drivers/ide/ide-taskfile.c
@@ -582,7 +582,14 @@ int ide_taskfile_ioctl(ide_drive_t *driv
 	if (req_task->in_flags.b.data)
 		cmd.ftf_flags |= IDE_FTFLAG_IN_DATA;
 
-	switch(req_task->data_phase) {
+	if (req_task->req_cmd == IDE_DRIVE_TASK_RAW_WRITE) {
+		/* fixup data phase if needed */
+		if (req_task->data_phase == TASKFILE_IN_DMAQ ||
+		    req_task->data_phase == TASKFILE_IN_DMA)
+			cmd.data_phase = TASKFILE_OUT_DMA;
+	}
+
+	switch (cmd.data_phase) {
 		case TASKFILE_MULTI_OUT:
 			if (!drive->mult_count) {
 				/* (hs): give up if multcount is not set */
@@ -597,6 +604,7 @@ int ide_taskfile_ioctl(ide_drive_t *driv
 			/* fall through */
 		case TASKFILE_OUT_DMAQ:
 		case TASKFILE_OUT_DMA:
+			cmd.tf_flags |= IDE_TFLAG_WRITE;
 			nsect = taskout / SECTOR_SIZE;
 			data_buf = outbuf;
 			break;
@@ -637,9 +645,6 @@ int ide_taskfile_ioctl(ide_drive_t *driv
 		}
 	}
 
-	if (req_task->req_cmd == IDE_DRIVE_TASK_RAW_WRITE)
-		cmd.tf_flags |= IDE_TFLAG_WRITE;
-
 	err = ide_raw_taskfile(drive, &cmd, data_buf, nsect);
 
 	memcpy(req_task->hob_ports, &cmd.tf_array[0],
