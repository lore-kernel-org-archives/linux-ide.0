From: domen@coderock.org
Subject: [patch 1/1] drivers/ide/ide-tape.c : Use of time_after macro
Date: Fri, 15 Jul 2005 00:21:12 +0200
Message-ID: <20050714222111.777320000@homer>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from coderock.org ([193.77.147.115]:51361 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S262605AbVGNWVR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 14 Jul 2005 18:21:17 -0400
Content-Disposition: inline; filename=time_after-drivers_ide_ide-tape
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: gadio@netvision.net.il
Cc: B.Zolnierkiewicz@elka.pw.edu.pl, linux-ide@vger.kernel.org, Marcelo Feitoza Parisi <marcelo@feitoza.com.br>, domen@coderock.org

From: Marcelo Feitoza Parisi <marcelo@feitoza.com.br>


Use of the time_after() macro, defined at linux/jiffies.h, which deal
with wrapping correctly and are nicer to read.

Signed-off-by: Marcelo Feitoza Parisi <marcelo@feitoza.com.br>
Signed-off-by: Domen Puncer <domen@coderock.org>

---
 ide-tape.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)

Index: quilt/drivers/ide/ide-tape.c
===================================================================
--- quilt.orig/drivers/ide/ide-tape.c
+++ quilt/drivers/ide/ide-tape.c
@@ -443,6 +443,7 @@
 #include <linux/smp_lock.h>
 #include <linux/completion.h>
 #include <linux/bitops.h>
+#include <linux/jiffies.h>
 
 #include <asm/byteorder.h>
 #include <asm/irq.h>
@@ -2333,7 +2334,7 @@ static ide_startstop_t idetape_rw_callba
 	}
 	if (time_after(jiffies, tape->insert_time))
 		tape->insert_speed = tape->insert_size / 1024 * HZ / (jiffies - tape->insert_time);
-	if (jiffies - tape->avg_time >= HZ) {
+	if (time_after_eq(jiffies, tape->avg_time + HZ)) {
 		tape->avg_speed = tape->avg_size * HZ / (jiffies - tape->avg_time) / 1024;
 		tape->avg_size = 0;
 		tape->avg_time = jiffies;

--
