From: Alexey Dobriyan <adobriyan@gmail.com>
Subject: [PATCH] ide-tape: use time_after(), time_after_eq()
Date: Thu, 1 Dec 2005 00:41:19 +0300
Message-ID: <20051130214119.GC12551@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nproxy.gmail.com ([64.233.182.200]:53673 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750769AbVK3V0e (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 30 Nov 2005 16:26:34 -0500
Received: by nproxy.gmail.com with SMTP id x4so30757nfb
        for <linux-ide@vger.kernel.org>; Wed, 30 Nov 2005 13:26:33 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Gadi Oxman <gadio@netvision.net.il>
Cc: Marcelo Feitoza Parisi <marcelo@feitoza.com.br>, Andrew Morton <akpm@osdl.org>, linux-ide@vger.kernel.org

From: Marcelo Feitoza Parisi <marcelo@feitoza.com.br>

They deal with wrapping correctly and are nicer to read.

Signed-off-by: Marcelo Feitoza Parisi <marcelo@feitoza.com.br>
Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 drivers/ide/ide-tape.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/drivers/ide/ide-tape.c
+++ b/drivers/ide/ide-tape.c
@@ -443,6 +443,7 @@
 #include <linux/smp_lock.h>
 #include <linux/completion.h>
 #include <linux/bitops.h>
+#include <linux/jiffies.h>
 
 #include <asm/byteorder.h>
 #include <asm/irq.h>
@@ -2335,7 +2336,7 @@ static ide_startstop_t idetape_rw_callba
 	}
 	if (time_after(jiffies, tape->insert_time))
 		tape->insert_speed = tape->insert_size / 1024 * HZ / (jiffies - tape->insert_time);
-	if (jiffies - tape->avg_time >= HZ) {
+	if (time_after_eq(jiffies, tape->avg_time + HZ)) {
 		tape->avg_speed = tape->avg_size * HZ / (jiffies - tape->avg_time) / 1024;
 		tape->avg_size = 0;
 		tape->avg_time = jiffies;
@@ -2496,7 +2497,7 @@ static ide_startstop_t idetape_do_reques
 			} else {
 				return ide_do_reset(drive);
 			}
-		} else if (jiffies - tape->dsc_polling_start > IDETAPE_DSC_MA_THRESHOLD)
+		} else if (time_after(jiffies, tape->dsc_polling_start + IDETAPE_DSC_MA_THRESHOLD))
 			tape->dsc_polling_frequency = IDETAPE_DSC_MA_SLOW;
 		idetape_postpone_request(drive);
 		return ide_stopped;

