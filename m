From: janitor@sternwelten.at
Subject: [patch 5/5]  ide-cs: replace schedule_timeout() with 	msleep()
Date: Thu, 02 Sep 2004 01:19:40 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <E1C2eOC-0003ew-MD@sputnik>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from baikonur.stro.at ([213.239.196.228]:41856 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S268134AbUIAXTk
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 1 Sep 2004 19:19:40 -0400
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: B.Zolnierkiewicz@elka.pw.edu.pl, alan@redhat.com, janitor@sternwelten.at







I would appreciate any comments from the janitor@sternweltens list.

Thanks,
Nish



Description: Use msleep() instead of schedule_timeout() to guarantee the
desired delay.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
Signed-off-by: Maximilian Attems <janitor@sternwelten.at>



---

 linux-2.6.9-rc1-bk7-max/drivers/ide/legacy/ide-cs.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -puN drivers/ide/legacy/ide-cs.c~msleep-drivers_ide_legacy_ide-cs drivers/ide/legacy/ide-cs.c
--- linux-2.6.9-rc1-bk7/drivers/ide/legacy/ide-cs.c~msleep-drivers_ide_legacy_ide-cs	2004-09-01 19:34:49.000000000 +0200
+++ linux-2.6.9-rc1-bk7-max/drivers/ide/legacy/ide-cs.c	2004-09-01 19:34:49.000000000 +0200
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
