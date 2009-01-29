From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH] IDE: palm_bk3710: use ioremap instead of arch-specific IO_ADDRESS()
Date: Thu, 29 Jan 2009 15:05:57 -0800
Message-ID: <1233270357-604-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.175]:4453 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756914AbZA2XGP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 29 Jan 2009 18:06:15 -0500
Received: by wf-out-1314.google.com with SMTP id 27so171457wfd.4
        for <linux-ide@vger.kernel.org>; Thu, 29 Jan 2009 15:06:14 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: davinci-linux-open-source@linux.davincidsp.com, Sergei Shtylyov <sshtylyov@ru.mvista.com>

Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 drivers/ide/palm_bk3710.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/drivers/ide/palm_bk3710.c b/drivers/ide/palm_bk3710.c
index f38aac7..be9c904 100644
--- a/drivers/ide/palm_bk3710.c
+++ b/drivers/ide/palm_bk3710.c
@@ -380,7 +380,11 @@ static int __init palm_bk3710_probe(struct platform_device *pdev)
 		return -EBUSY;
 	}
 
-	base = IO_ADDRESS(mem->start);
+	base = ioremap(mem->start, mem->end);
+	if (!base) {
+		printk(KERN_ERR "failed to map IO memory\n");
+		return -ENOMEM;
+	}
 
 	/* Configure the Palm Chip controller */
 	palm_bk3710_chipinit(base);
-- 
1.6.1

