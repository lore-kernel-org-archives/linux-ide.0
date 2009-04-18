From: Tejun Heo <tj@kernel.org>
Subject: [PATCH 01/10] ide-tape,floppy: fix failed command completion after request sense
Date: Sun, 19 Apr 2009 08:58:33 +0900
Message-ID: <1240099122-18381-2-git-send-email-tj@kernel.org>
References: <1240099122-18381-1-git-send-email-tj@kernel.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:57754 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752367AbZDRX6w (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 18 Apr 2009 19:58:52 -0400
In-Reply-To: <1240099122-18381-1-git-send-email-tj@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: petkovbb@googlemail.com, bzolnier@gmail.com, axboe@kernel.dk, linux-ide@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>

Impact: fix infinite retry loop

After a command failed, ide-tape and floppy inserts REQUEST_SENSE in
front of the failed command and according to the result, sets
pc->retries, flags and errors.  After REQUEST_SENSE is complete, the
failed command is again at the front of the queue and if the verdict
was to terminate the request, the issue functions tries to complete it
directly by calling drive->pc_callback() and returning ide_stopped.

However, drive->pc_callback() doesn't complete a request.  It only
prepares for completion of the request.  As a result, this creates an
infinite loop where the failed request is retried perpetually.

Fix it by actually ending the request by calling ide_complete_rq().

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 drivers/ide/ide-floppy.c |    1 +
 drivers/ide/ide-tape.c   |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/ide/ide-floppy.c b/drivers/ide/ide-floppy.c
index d3302cc..d20704a 100644
--- a/drivers/ide/ide-floppy.c
+++ b/drivers/ide/ide-floppy.c
@@ -141,6 +141,7 @@ static ide_startstop_t ide_floppy_issue_pc(ide_drive_t *drive,
 
 		drive->failed_pc = NULL;
 		drive->pc_callback(drive, 0);
+		ide_complete_rq(drive, -EIO, blk_rq_bytes(drive->hwif->rq));
 		return ide_stopped;
 	}
 
diff --git a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
index 9b762a2..2b9a136 100644
--- a/drivers/ide/ide-tape.c
+++ b/drivers/ide/ide-tape.c
@@ -643,6 +643,7 @@ static ide_startstop_t ide_tape_issue_pc(ide_drive_t *drive,
 		}
 		drive->failed_pc = NULL;
 		drive->pc_callback(drive, 0);
+		ide_complete_rq(drive, -EIO, blk_rq_bytes(drive->hwif->rq));
 		return ide_stopped;
 	}
 	debug_log(DBG_SENSE, "Retry #%d, cmd = %02X\n", pc->retries, pc->c[0]);
-- 
1.6.0.2

