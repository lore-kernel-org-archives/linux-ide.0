From: Borislav Petkov <petkovbb@googlemail.com>
Subject: [PATCH 2.6.29] ide-tape: remove back-to-back REQUEST_SENSE
	detection
Date: Wed, 27 May 2009 09:20:04 +0200
Message-ID: <20090527072004.GA8127@liondog.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f168.google.com ([209.85.220.168]:56369 "EHLO
	mail-fx0-f168.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761409AbZE0HUG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 27 May 2009 03:20:06 -0400
Received: by fxm12 with SMTP id 12so2602985fxm.37
        for <linux-ide@vger.kernel.org>; Wed, 27 May 2009 00:20:07 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: stable@kernel.org
Cc: tj@kernel.org, bzolnier@gmail.com, linux-ide@vger.kernel.org

Hi,

please include, commit id upstream:

1e75540ec5202cae63cd238c86bd880e3d496546

---
From: Tejun Heo <tj@kernel.org>
Date: Wed, 27 May 2009 09:12:05 +0200
Subject: [PATCH] ide-tape: remove back-to-back REQUEST_SENSE detection

Impact: fix an oops which always triggers

ide_tape_issue_pc() assumed drive->pc isn't NULL on invocation when
checking for back-to-back request sense issues but drive->pc can be
NULL and even when it's not NULL, it's not safe to dereference it once
the previous command is complete because pc could have been freed or
was on stack.  Kill back-to-back REQUEST_SENSE detection.

Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
---
 drivers/ide/ide-tape.c |    6 ------
 1 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
index 4e6181c..af7860c 100644
--- a/drivers/ide/ide-tape.c
+++ b/drivers/ide/ide-tape.c
@@ -654,12 +654,6 @@ static ide_startstop_t idetape_issue_pc(ide_drive_t *drive,
 {
 	idetape_tape_t *tape = drive->driver_data;
 
-	if (drive->pc->c[0] == REQUEST_SENSE &&
-	    pc->c[0] == REQUEST_SENSE) {
-		printk(KERN_ERR "ide-tape: possible ide-tape.c bug - "
-			"Two request sense in serial were issued\n");
-	}
-
 	if (tape->failed_pc == NULL && pc->c[0] != REQUEST_SENSE)
 		tape->failed_pc = pc;
 
-- 
1.6.3.1

-- 
Regards/Gruss,
    Boris.
