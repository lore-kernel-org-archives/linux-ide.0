From: domen@coderock.org
Subject: [patch 1/1] ide-tape: replace schedule_timeout() with msleep()
Date: Mon, 20 Jun 2005 23:52:10 +0200
Message-ID: <20050620215209.992854000@nd47.coderock.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from coderock.org ([193.77.147.115]:25497 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S261744AbVFTVzx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 20 Jun 2005 17:55:53 -0400
Content-Disposition: inline; filename=msleep-drivers_ide_ide-tape.patch
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: gadio@netvision.net.il
Cc: B.Zolnierkiewicz@elka.pw.edu.pl, linux-ide@vger.kernel.org, Nishanth Aravamudan <nacc@us.ibm.com>, Maximilian Attems <janitor@sternwelten.at>, domen@coderock.org

From: Nishanth Aravamudan <nacc@us.ibm.com>



Uses msleep() instead of schedule_timeout() to guarantee
the task delays at least the desired time amount.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
Signed-off-by: Maximilian Attems <janitor@sternwelten.at>
Signed-off-by: Domen Puncer <domen@coderock.org>
---
 ide-tape.c |    3 +--
 1 files changed, 1 insertion(+), 2 deletions(-)

Index: quilt/drivers/ide/ide-tape.c
===================================================================
--- quilt.orig/drivers/ide/ide-tape.c
+++ quilt/drivers/ide/ide-tape.c
@@ -2903,8 +2903,7 @@ static int idetape_wait_ready(ide_drive_
 		} else if (!(tape->sense_key == 2 && tape->asc == 4 &&
 			     (tape->ascq == 1 || tape->ascq == 8)))
 			return -EIO;
-		current->state = TASK_INTERRUPTIBLE;
-  		schedule_timeout(HZ / 10);
+		msleep(100);
 	}
 	return -EIO;
 }

--
