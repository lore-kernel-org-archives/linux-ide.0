From: domen@coderock.org
Subject: [patch 1/1] ide-tape: replace schedule_timeout() with msleep()
Date: Sun, 06 Mar 2005 11:42:29 +0100
Message-ID: <20050306104230.11C431F1F0@trashy.coderock.org>
Received: from coderock.org ([193.77.147.115]:37034 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S261380AbVCFKme (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 6 Mar 2005 05:42:34 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: gadio@netvision.net.il
Cc: B.Zolnierkiewicz@elka.pw.edu.pl, linux-ide@vger.kernel.org, domen@coderock.org, nacc@us.ibm.com, janitor@sternwelten.at



Uses msleep() instead of schedule_timeout() to guarantee
the task delays at least the desired time amount.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
Signed-off-by: Maximilian Attems <janitor@sternwelten.at>
Signed-off-by: Domen Puncer <domen@coderock.org>
---


 kj-domen/drivers/ide/ide-tape.c |    3 +--
 1 files changed, 1 insertion(+), 2 deletions(-)

diff -puN drivers/ide/ide-tape.c~msleep-drivers_ide_ide-tape drivers/ide/ide-tape.c
--- kj/drivers/ide/ide-tape.c~msleep-drivers_ide_ide-tape	2005-03-05 16:09:07.000000000 +0100
+++ kj-domen/drivers/ide/ide-tape.c	2005-03-05 16:09:07.000000000 +0100
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
