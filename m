From: janitor@sternwelten.at
Subject: [patch 2/5]  ide-cd: replace schedule_timeout() with 	msleep()
Date: Thu, 02 Sep 2004 01:19:23 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <E1C2eNv-0003cG-Sd@sputnik>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from baikonur.stro.at ([213.239.196.228]:64439 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S268082AbUIAXTY
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 1 Sep 2004 19:19:24 -0400
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: B.Zolnierkiewicz@elka.pw.edu.pl, alan@redhat.com, janitor@sternwelten.at







I would appreciate any comments from the janitor@sternweltens list. This is one (of
many) cases where I made a decision about replacing

set_current_state(TASK_INTERRUPTIBLE);
schedule_timeout(some_time);

with

msleep(jiffies_to_msecs(some_time));

msleep() is not exactly the same as the previous code, but I only did
this replacement where I thought long delays were *desired*. If this is
not the case here, then just disregard this patch. I think in this case,
though, because of the while() loop, this was the desired effect.

Thanks,
Nish



Description: Replace cdrom_sleep() with msleep() and remove
cdrom_sleep() definition.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
Signed-off-by: Maximilian Attems <janitor@sternwelten.at>



---

 linux-2.6.9-rc1-bk7-max/drivers/ide/ide-cd.c |   15 +--------------
 1 files changed, 1 insertion(+), 14 deletions(-)

diff -puN drivers/ide/ide-cd.c~msleep-drivers_ide_ide-cd drivers/ide/ide-cd.c
--- linux-2.6.9-rc1-bk7/drivers/ide/ide-cd.c~msleep-drivers_ide_ide-cd	2004-09-01 19:34:48.000000000 +0200
+++ linux-2.6.9-rc1-bk7-max/drivers/ide/ide-cd.c	2004-09-01 19:34:48.000000000 +0200
@@ -1519,19 +1519,6 @@ static ide_startstop_t cdrom_do_packet_c
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
@@ -1566,7 +1553,7 @@ int cdrom_queue_packet_command(ide_drive
 				/* The drive is in the process of loading
 				   a disk.  Retry, but wait a little to give
 				   the drive time to complete the load. */
-				cdrom_sleep(2 * HZ);
+				msleep(2000);
 			} else {
 				/* Otherwise, don't retry. */
 				retries = 0;

_
