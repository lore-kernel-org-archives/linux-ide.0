From: Akinobu Mita <akinobu.mita@gmail.com>
Subject: [PATCH] libata: use __ratelimit
Date: Mon, 12 Apr 2010 21:11:41 +0900
Message-ID: <1271074301-3812-1-git-send-email-akinobu.mita@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:64254 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750776Ab0DLMPP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 12 Apr 2010 08:15:15 -0400
Received: by gwj19 with SMTP id 19so930335gwj.19
        for <linux-ide@vger.kernel.org>; Mon, 12 Apr 2010 05:15:14 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Akinobu Mita <akinobu.mita@gmail.com>, Jeff Garzik <jgarzik@pobox.com>

Use __ratelimit() instead of its own private rate limit implementation.

Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org
---
 drivers/ata/libata-core.c |   19 +++----------------
 1 files changed, 3 insertions(+), 16 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 49cffb6..1e0ce69 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -65,6 +65,7 @@
 #include <linux/libata.h>
 #include <asm/byteorder.h>
 #include <linux/cdrom.h>
+#include <linux/ratelimit.h>
 
 #include "libata.h"
 
@@ -6700,25 +6701,11 @@ static void __exit ata_exit(void)
 subsys_initcall(ata_init);
 module_exit(ata_exit);
 
-static unsigned long ratelimit_time;
-static DEFINE_SPINLOCK(ata_ratelimit_lock);
+static DEFINE_RATELIMIT_STATE(ratelimit, HZ / 5, 1);
 
 int ata_ratelimit(void)
 {
-	int rc;
-	unsigned long flags;
-
-	spin_lock_irqsave(&ata_ratelimit_lock, flags);
-
-	if (time_after(jiffies, ratelimit_time)) {
-		rc = 1;
-		ratelimit_time = jiffies + (HZ/5);
-	} else
-		rc = 0;
-
-	spin_unlock_irqrestore(&ata_ratelimit_lock, flags);
-
-	return rc;
+	return __ratelimit(&ratelimit);
 }
 
 /**
-- 
1.6.0.6

