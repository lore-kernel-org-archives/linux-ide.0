From: janitor@sternwelten.at
Subject: [patch 2/4]  ide-tape: replace schedule_timeout() with 	msleep()
Date: Thu, 21 Oct 2004 10:41:39 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <E1CKYVw-0003tT-8g@sputnik>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from baikonur.stro.at ([213.239.196.228]:17329 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S270664AbUJUIlo
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 21 Oct 2004 04:41:44 -0400
List-Id: linux-ide@vger.kernel.org
To: B.Zolnierkiewicz@elka.pw.edu.pl
Cc: linux-ide@vger.kernel.org, janitor@sternwelten.at, nacc@us.ibm.com







I would appreciate any comments from the janitor@sternweltens list. This is one (of
many) cases where I made a decision about replacing

set_current_state(TASK_INTERRUPTIBLE);
schedule_timeout(some_time);

with

msleep(jiffies_to_msecs(some_time));

msleep() is not exactly the same as the previous code, but I only did
this replacement where I thought long delays were *desired*. If this is
not the case here, then just disregard this patch.

Thanks,
Nish



Description: Uses msleep() instead of schedule_timeout() to guarantee
the task delays at least the desired time amount.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
Signed-off-by: Maximilian Attems <janitor@sternwelten.at>

---

 linux-2.6.9-max/drivers/ide/ide-tape.c |    3 +--
 1 files changed, 1 insertion(+), 2 deletions(-)

diff -puN drivers/ide/ide-tape.c~msleep-drivers_ide_ide-tape drivers/ide/ide-tape.c
--- linux-2.6.9/drivers/ide/ide-tape.c~msleep-drivers_ide_ide-tape	2004-10-21 02:36:01.000000000 +0200
+++ linux-2.6.9-max/drivers/ide/ide-tape.c	2004-10-21 02:36:01.000000000 +0200
@@ -2854,8 +2854,7 @@ static int idetape_wait_ready(ide_drive_
 		} else if (!(tape->sense_key == 2 && tape->asc == 4 &&
 			     (tape->ascq == 1 || tape->ascq == 8)))
 			return -EIO;
-		current->state = TASK_INTERRUPTIBLE;
-  		schedule_timeout(HZ / 10);
+		msleep(100);
 	}
 	return -EIO;
 }
_
