From: Borislav Petkov <petkovbb@gmail.com>
Subject: [PATCH 20/32] ide-tape: make function name more accurate
Date: Sun, 27 Jan 2008 10:48:08 +0100
Message-ID: <1201427300-3954-15-git-send-email-petkovbb@gmail.com>
References: <1201427300-3954-1-git-send-email-petkovbb@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [212.23.103.76] ([212.23.103.76]:59095 "EHLO gollum.tnic"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756357AbYA0JtX (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 27 Jan 2008 04:49:23 -0500
In-Reply-To: <1201427300-3954-1-git-send-email-petkovbb@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Borislav Petkov <bbpetkov@yahoo.de>

From: Borislav Petkov <bbpetkov@yahoo.de>

idetape_active_next_stage() was rather ambiguous wrt its purpose. Make that
more explicit and remove superfluous comment.

Signed-off-by: Borislav Petkov <bbpetkov@yahoo.de>
---
 drivers/ide/ide-tape.c |    9 +++------
 1 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
index fd7eeea..cf308d7 100644
--- a/drivers/ide/ide-tape.c
+++ b/drivers/ide/ide-tape.c
@@ -820,10 +820,7 @@ static void idetape_analyze_error(ide_drive_t *drive, u8 *sense)
 	}
 }
 
-/*
- * idetape_active_next_stage will declare the next stage as "active".
- */
-static void idetape_active_next_stage (ide_drive_t *drive)
+static void idetape_activate_next_stage(ide_drive_t *drive)
 {
 	idetape_tape_t *tape = drive->driver_data;
 	idetape_stage_t *stage = tape->next_stage;
@@ -1004,7 +1001,7 @@ static int idetape_end_request(ide_drive_t *drive, int uptodate, int nr_sects)
 			}
 		}
 		if (tape->next_stage != NULL) {
-			idetape_active_next_stage(drive);
+			idetape_activate_next_stage(drive);
 
 			/*
 			 * Insert the next request into the request queue.
@@ -2338,7 +2335,7 @@ static void idetape_insert_pipeline_into_queue (ide_drive_t *drive)
 		return;
 	if (!idetape_pipeline_active(tape)) {
 		set_bit(IDETAPE_PIPELINE_ACTIVE, &tape->flags);
-		idetape_active_next_stage(drive);
+		idetape_activate_next_stage(drive);
 		(void) ide_do_drive_cmd(drive, tape->active_data_request, ide_end);
 	}
 }
-- 
1.5.3.7

