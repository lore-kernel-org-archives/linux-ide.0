From: domen@coderock.org
Subject: [patch 2/3] ide/ide-cs: replace schedule_timeout() with msleep()
Date: Wed, 12 Jan 2005 00:17:40 +0100
Message-ID: <20050111231740.738FE1F226@trashy.coderock.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from coderock.org ([193.77.147.115]:13509 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S262917AbVAKXRs (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 11 Jan 2005 18:17:48 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: B.Zolnierkiewicz@elka.pw.edu.pl
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, domen@coderock.org, nacc@us.ibm.com, janitor@sternwelten.at




Any comments would be appreciated.

Description: Uses msleep() in place of schedule_timeout()
to guarantee the task delays as expected.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
Signed-off-by: Maximilian Attems <janitor@sternwelten.at>
Signed-off-by: Domen Puncer <domen@coderock.org>
---


 kj-domen/drivers/ide/legacy/ide-cs.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -puN drivers/ide/legacy/ide-cs.c~msleep-drivers_ide_ide-cs drivers/ide/legacy/ide-cs.c
--- kj/drivers/ide/legacy/ide-cs.c~msleep-drivers_ide_ide-cs	2005-01-10 17:59:50.000000000 +0100
+++ kj-domen/drivers/ide/legacy/ide-cs.c	2005-01-10 17:59:50.000000000 +0100
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
