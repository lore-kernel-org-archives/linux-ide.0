From: domen@coderock.org
Subject: [patch 1/6] ide/ide-cs: replace schedule_timeout() with msleep()
Date: Mon, 20 Jun 2005 23:52:17 +0200
Message-ID: <20050620215216.538027000@nd47.coderock.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from coderock.org ([193.77.147.115]:31129 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S261753AbVFTV4H (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 20 Jun 2005 17:56:07 -0400
Content-Disposition: inline; filename=msleep-drivers_ide_ide-cs.patch
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: B.Zolnierkiewicz@elka.pw.edu.pl
Cc: linux-ide@vger.kernel.org, Nishanth Aravamudan <nacc@us.ibm.com>, Maximilian Attems <janitor@sternwelten.at>, domen@coderock.org

From: Nishanth Aravamudan <nacc@us.ibm.com>



Uses msleep() in place of schedule_timeout()
to guarantee the task delays as expected.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
Signed-off-by: Maximilian Attems <janitor@sternwelten.at>
Signed-off-by: Domen Puncer <domen@coderock.org>
---
 ide-cs.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

Index: quilt/drivers/ide/legacy/ide-cs.c
===================================================================
--- quilt.orig/drivers/ide/legacy/ide-cs.c
+++ quilt/drivers/ide/legacy/ide-cs.c
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

--
