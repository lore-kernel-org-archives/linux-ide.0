From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 1/12] ide: check ->dma_setup() return value in flagged_taskfile()
Date: Mon, 8 Oct 2007 23:07:08 +0200
Message-ID: <200710082307.08468.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.190]:59801 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753258AbXJHVjs (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 8 Oct 2007 17:39:48 -0400
Received: by nf-out-0910.google.com with SMTP id g13so1370193nfb
        for <linux-ide@vger.kernel.org>; Mon, 08 Oct 2007 14:39:46 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-taskfile.c |   11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

Index: b/drivers/ide/ide-taskfile.c
===================================================================
--- a/drivers/ide/ide-taskfile.c
+++ b/drivers/ide/ide-taskfile.c
@@ -827,9 +827,11 @@ ide_startstop_t flagged_taskfile (ide_dr
 		case TASKFILE_OUT_DMA:
 		case TASKFILE_IN_DMAQ:
 		case TASKFILE_IN_DMA:
-			hwif->dma_setup(drive);
-			hwif->dma_exec_cmd(drive, taskfile->command);
-			hwif->dma_start(drive);
+			if (!hwif->dma_setup(drive)) {
+				hwif->dma_exec_cmd(drive, taskfile->command);
+				hwif->dma_start(drive);
+				return ide_started;
+			}
 			break;
 
 	        default:
@@ -843,7 +845,8 @@ ide_startstop_t flagged_taskfile (ide_dr
 				return task->prehandler(drive, task->rq);
 			}
 			ide_execute_command(drive, taskfile->command, task->handler, WAIT_WORSTCASE, NULL);
+			return ide_started;
 	}
 
-	return ide_started;
+	return ide_stopped;
 }
