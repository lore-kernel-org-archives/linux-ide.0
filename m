From: janitor@sternwelten.at
Subject: [patch 3/4]  ide/ide-cd: replace 	cdrom_sleep() with msleep()
Date: Thu, 21 Oct 2004 10:41:43 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <E1CKYVz-0003wN-DM@sputnik>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from baikonur.stro.at ([213.239.196.228]:14773 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S270699AbUJUIlr
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 21 Oct 2004 04:41:47 -0400
List-Id: linux-ide@vger.kernel.org
To: B.Zolnierkiewicz@elka.pw.edu.pl
Cc: linux-ide@vger.kernel.org, janitor@sternwelten.at, nacc@us.ibm.com




Any comments would be appreciated.

Description: Uses msleep() in place of cdrom_sleep()
to guarantee the task delays as expected.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
Signed-off-by: Maximilian Attems <janitor@sternwelten.at>

---

 linux-2.6.9-max/drivers/ide/ide-cd.c |   15 +--------------
 1 files changed, 1 insertion(+), 14 deletions(-)

diff -puN drivers/ide/ide-cd.c~msleep-drivers_ide_ide-cd drivers/ide/ide-cd.c
--- linux-2.6.9/drivers/ide/ide-cd.c~msleep-drivers_ide_ide-cd	2004-10-21 02:37:56.000000000 +0200
+++ linux-2.6.9-max/drivers/ide/ide-cd.c	2004-10-21 02:37:56.000000000 +0200
@@ -1514,19 +1514,6 @@ static ide_startstop_t cdrom_do_packet_c
 }
 
 
-/* Sleep for TIME jiffies.
-   Not to be called from an interrupt handler. */
-static
-void cdrom_sleep (int time)
-{
-	int sleep = time;
-
-	do {
-		set_current_state(TASK_INTERRUPTIBLE);
-		sleep = schedule_timeout(sleep);
-	} while (sleep);
-}
-
 static
 int cdrom_queue_packet_command(ide_drive_t *drive, struct request *rq)
 {
@@ -1561,7 +1548,7 @@ int cdrom_queue_packet_command(ide_drive
 				/* The drive is in the process of loading
 				   a disk.  Retry, but wait a little to give
 				   the drive time to complete the load. */
-				cdrom_sleep(2 * HZ);
+				msleep(2000);
 			} else {
 				/* Otherwise, don't retry. */
 				retries = 0;
_
