From: Borislav Petkov <petkovbb@googlemail.com>
Subject: [PATCH 09/22] ide-tape: remove idetape_increase_max_pipeline_stages()
Date: Mon,  4 Feb 2008 14:40:27 +0100
Message-ID: <1202132440-26648-10-git-send-email-petkovbb@gmail.com>
References: <1202132440-26648-1-git-send-email-petkovbb@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.174]:4171 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756044AbYBDNmg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 4 Feb 2008 08:42:36 -0500
Received: by ug-out-1314.google.com with SMTP id z38so1148561ugc.16
        for <linux-ide@vger.kernel.org>; Mon, 04 Feb 2008 05:42:35 -0800 (PST)
In-Reply-To: <1202132440-26648-1-git-send-email-petkovbb@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Borislav Petkov <petkovbb@gmail.com>

This function was being used only at one place so fold it in there.

Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
---
 drivers/ide/ide-tape.c |   36 ++++++++++++++++--------------------
 1 files changed, 16 insertions(+), 20 deletions(-)

diff --git a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
index b4944ef..ae2c76d 100644
--- a/drivers/ide/ide-tape.c
+++ b/drivers/ide/ide-tape.c
@@ -771,25 +771,6 @@ static void idetape_activate_next_stage(ide_drive_t *drive)
 }
 
 /*
- *	idetape_increase_max_pipeline_stages is a part of the feedback
- *	loop which tries to find the optimum number of stages. In the
- *	feedback loop, we are starting from a minimum maximum number of
- *	stages, and if we sense that the pipeline is empty, we try to
- *	increase it, until we reach the user compile time memory limit.
- */
-static void idetape_increase_max_pipeline_stages (ide_drive_t *drive)
-{
-	idetape_tape_t *tape = drive->driver_data;
-	int increase = (tape->max_pipeline - tape->min_pipeline) / 10;
-
-	debug_log(DBG_PROCS, "Enter %s\n", __func__);
-
-	tape->max_stages += max(increase, 1);
-	tape->max_stages = max(tape->max_stages, tape->min_pipeline);
-	tape->max_stages = min(tape->max_stages, tape->max_pipeline);
-}
-
-/*
  *	idetape_kfree_stage calls kfree to completely free a stage, along with
  *	its related buffers.
  */
@@ -937,7 +918,22 @@ static int idetape_end_request(ide_drive_t *drive, int uptodate, int nr_sects)
 			(void)ide_do_drive_cmd(drive, tape->active_data_rq,
 						ide_end);
 		} else if (!error) {
-				idetape_increase_max_pipeline_stages(drive);
+			/*
+			 * This is a part of the feedback loop which tries to
+			 * find the optimum number of stages. We are starting
+			 * from a minimum maximum number of stages, and if we
+			 * sense that the pipeline is empty, we try to increase
+			 * it, until we reach the user compile time memory
+			 * limit.
+			 */
+			int i = (tape->max_pipeline - tape->min_pipeline) / 10;
+
+			tape->max_stages += max(i, 1);
+			tape->max_stages = max(tape->max_stages,
+						tape->min_pipeline);
+			tape->max_stages = min(tape->max_stages,
+						tape->max_pipeline);
+
 		}
 	}
 	ide_end_drive_cmd(drive, 0, 0);
-- 
1.5.3.7

