From: janitor@sternwelten.at
Subject: [patch 4/4]  ide/ide-cs: replace 	schedule_timeout() with msleep()
Date: Thu, 21 Oct 2004 10:41:46 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <E1CKYW2-0003zH-Gb@sputnik>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from baikonur.stro.at ([213.239.196.228]:64173 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S270700AbUJUIlu
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 21 Oct 2004 04:41:50 -0400
List-Id: linux-ide@vger.kernel.org
To: B.Zolnierkiewicz@elka.pw.edu.pl
Cc: linux-ide@vger.kernel.org, janitor@sternwelten.at, nacc@us.ibm.com




Any comments would be appreciated.

Description: Uses msleep() in place of schedule_timeout()
to guarantee the task delays as expected.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
Signed-off-by: Maximilian Attems <janitor@sternwelten.at>

---

 linux-2.6.9-max/drivers/ide/legacy/ide-cs.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -puN drivers/ide/legacy/ide-cs.c~msleep-drivers_ide_ide-cs drivers/ide/legacy/ide-cs.c
--- linux-2.6.9/drivers/ide/legacy/ide-cs.c~msleep-drivers_ide_ide-cs	2004-10-21 02:37:59.000000000 +0200
+++ linux-2.6.9-max/drivers/ide/legacy/ide-cs.c	2004-10-21 02:37:59.000000000 +0200
@@ -43,6 +43,7 @@
 #include <linux/ide.h>
 #include <linux/hdreg.h>
 #include <linux/major.h>
+#include <linux/delay.h>
 #include <asm/io.h>
 #include <asm/system.h>
 
@@ -357,8 +358,7 @@ void ide_config(dev_link_t *link)
 		break;
 	    }
 	}
-	__set_current_state(TASK_UNINTERRUPTIBLE);
-	schedule_timeout(HZ/10);
+	msleep(100);
     }
 
     if (hd < 0) {
_
