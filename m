From: Tejun Heo <tj@kernel.org>
Subject: [PATCH 02/15] ide-tape: remove back-to-back REQUEST_SENSE detection
Date: Fri, 17 Apr 2009 18:33:09 +0900
Message-ID: <1239960802-31978-3-git-send-email-tj@kernel.org>
References: <1239960802-31978-1-git-send-email-tj@kernel.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:39974 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754557AbZDQJdj (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 17 Apr 2009 05:33:39 -0400
In-Reply-To: <1239960802-31978-1-git-send-email-tj@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: petkovbb@googlemail.com, bzolnier@gmail.com, axboe@kernel.dk, linux-ide@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>

Impact: fix an oops which always triggers

ide_tape_issue_pc() assumed drive->pc isn't NULL on invocation when
checking for back-to-back request sense issues but drive->pc can be
NULL and even when it's not NULL, it's not safe to dereference it once
the previous command is complete because pc could have been freed or
was on stack.  Kill back-to-back REQUEST_SENSE detection.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 drivers/ide/ide-tape.c |    6 ------
 1 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
index cb942a9..3a53e08 100644
--- a/drivers/ide/ide-tape.c
+++ b/drivers/ide/ide-tape.c
@@ -614,12 +614,6 @@ static ide_startstop_t ide_tape_issue_pc(ide_drive_t *drive,
 {
 	idetape_tape_t *tape = drive->driver_data;
 
-	if (drive->pc->c[0] == REQUEST_SENSE &&
-	    pc->c[0] == REQUEST_SENSE) {
-		printk(KERN_ERR "ide-tape: possible ide-tape.c bug - "
-			"Two request sense in serial were issued\n");
-	}
-
 	if (drive->failed_pc == NULL && pc->c[0] != REQUEST_SENSE)
 		drive->failed_pc = pc;
 
-- 
1.6.0.2

