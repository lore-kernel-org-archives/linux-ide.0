From: Borislav Petkov <petkovbb@googlemail.com>
Subject: [PATCH 09/17] ide-tape: unwrap idetape_queue_pc_tail()
Date: Mon, 17 Mar 2008 07:41:22 +0100
Message-ID: <1205736090-4435-10-git-send-email-petkovbb@gmail.com>
References: <1205736090-4435-1-git-send-email-petkovbb@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hu-out-0506.google.com ([72.14.214.236]:30083 "EHLO
	hu-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753101AbYCQGli (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 17 Mar 2008 02:41:38 -0400
Received: by hu-out-0506.google.com with SMTP id 19so3301615hue.21
        for <linux-ide@vger.kernel.org>; Sun, 16 Mar 2008 23:41:36 -0700 (PDT)
In-Reply-To: <1205736090-4435-1-git-send-email-petkovbb@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Borislav Petkov <petkovbb@gmail.com>

idetape_queue_pc_tail() is a wrapper for its __idetape_queue_pc_tail() counterpart
and has no other functionality. Remove it and call the "wrapped" function
directly.

Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
---
 drivers/ide/ide-tape.c |   11 +++--------
 1 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
index 3eeb5c0..a85866a 100644
--- a/drivers/ide/ide-tape.c
+++ b/drivers/ide/ide-tape.c
@@ -1631,7 +1631,7 @@ static void idetape_create_test_unit_ready_cmd(struct ide_atapi_pc *pc)
  * to the request list without waiting for it to be serviced! In that case, we
  * usually use idetape_queue_pc_head().
  */
-static int __idetape_queue_pc_tail(ide_drive_t *drive, struct ide_atapi_pc *pc)
+static int idetape_queue_pc_tail(ide_drive_t *drive, struct ide_atapi_pc *pc)
 {
 	struct ide_tape_obj *tape = drive->driver_data;
 	struct request rq;
@@ -1663,7 +1663,7 @@ static int idetape_wait_ready(ide_drive_t *drive, unsigned long timeout)
 	timeout += jiffies;
 	while (time_before(jiffies, timeout)) {
 		idetape_create_test_unit_ready_cmd(&pc);
-		if (!__idetape_queue_pc_tail(drive, &pc))
+		if (!idetape_queue_pc_tail(drive, &pc))
 			return 0;
 		if ((tape->sense_key == 2 && tape->asc == 4 && tape->ascq == 2)
 		    || (tape->asc == 0x3A)) {
@@ -1672,7 +1672,7 @@ static int idetape_wait_ready(ide_drive_t *drive, unsigned long timeout)
 				return -ENOMEDIUM;
 			idetape_create_load_unload_cmd(drive, &pc,
 							IDETAPE_LU_LOAD_MASK);
-			__idetape_queue_pc_tail(drive, &pc);
+			idetape_queue_pc_tail(drive, &pc);
 			load_attempted = 1;
 		/* not about to be ready */
 		} else if (!(tape->sense_key == 2 && tape->asc == 4 &&
@@ -1683,11 +1683,6 @@ static int idetape_wait_ready(ide_drive_t *drive, unsigned long timeout)
 	return -EIO;
 }
 
-static int idetape_queue_pc_tail(ide_drive_t *drive, struct ide_atapi_pc *pc)
-{
-	return __idetape_queue_pc_tail(drive, pc);
-}
-
 static int idetape_flush_tape_buffers(ide_drive_t *drive)
 {
 	struct ide_atapi_pc pc;
-- 
1.5.4.1

