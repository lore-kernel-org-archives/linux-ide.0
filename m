From: domen@coderock.org
Subject: [patch 1/6] ide/ide-cs: replace schedule_timeout() with msleep()
Date: Sun, 06 Mar 2005 11:42:03 +0100
Message-ID: <20050306104203.057601F1F0@trashy.coderock.org>
Received: from coderock.org ([193.77.147.115]:26538 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S261367AbVCFKmI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 6 Mar 2005 05:42:08 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: B.Zolnierkiewicz@elka.pw.edu.pl
Cc: linux-ide@vger.kernel.org, domen@coderock.org, nacc@us.ibm.com, janitor@sternwelten.at





Uses msleep() in place of schedule_timeout()
to guarantee the task delays as expected.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
Signed-off-by: Maximilian Attems <janitor@sternwelten.at>
Signed-off-by: Domen Puncer <domen@coderock.org>
---


 kj-domen/drivers/ide/legacy/ide-cs.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -puN drivers/ide/legacy/ide-cs.c~msleep-drivers_ide_ide-cs drivers/ide/legacy/ide-cs.c
--- kj/drivers/ide/legacy/ide-cs.c~msleep-drivers_ide_ide-cs	2005-03-05 16:09:13.000000000 +0100
+++ kj-domen/drivers/ide/legacy/ide-cs.c	2005-03-05 16:09:13.000000000 +0100
@@ -43,6 +43,7 @@
 #include <linux/ide.h>
 #include <linux/hdreg.h>
 #include <linux/major.h>
+#include <linux/delay.h>
 #include <asm/io.h>
 #include <asm/system.h>
 
@@ -346,8 +347,7 @@ static void ide_config(dev_link_t *link)
 		break;
 	    }
 	}
-	__set_current_state(TASK_UNINTERRUPTIBLE);
-	schedule_timeout(HZ/10);
+	msleep(100);
     }
 
     if (hd < 0) {
_
