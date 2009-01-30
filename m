From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH v2] IDE: palm_bk3710: use ioremap instead of arch-specific IO_ADDRESS()
Date: Fri, 30 Jan 2009 11:59:27 -0800
Message-ID: <1233345567-643-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.231]:18282 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753512AbZA3T7c (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 30 Jan 2009 14:59:32 -0500
Received: by rv-out-0506.google.com with SMTP id k40so590579rvb.1
        for <linux-ide@vger.kernel.org>; Fri, 30 Jan 2009 11:59:31 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: davinci-linux-open-source@linux.davincidsp.com, Sergei Shtylyov <sshtylyov@ru.mvista.com>

Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 drivers/ide/palm_bk3710.c |   12 +++++++++---
 1 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/ide/palm_bk3710.c b/drivers/ide/palm_bk3710.c
index f38aac7..6196f76 100644
--- a/drivers/ide/palm_bk3710.c
+++ b/drivers/ide/palm_bk3710.c
@@ -347,7 +347,7 @@ static int __init palm_bk3710_probe(struct platform_device *pdev)
 	struct clk *clk;
 	struct resource *mem, *irq;
 	void __iomem *base;
-	unsigned long rate;
+	unsigned long rate, mem_size;
 	int i, rc;
 	hw_regs_t hw, *hws[] = { &hw, NULL, NULL, NULL };
 
@@ -374,13 +374,19 @@ static int __init palm_bk3710_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	if (request_mem_region(mem->start, mem->end - mem->start + 1,
+	mem_size = mem->end - mem->start + 1;
+	if (request_mem_region(mem->start, mem_size,
 			       "palm_bk3710") == NULL) {
 		printk(KERN_ERR "failed to request memory region\n");
 		return -EBUSY;
 	}
 
-	base = IO_ADDRESS(mem->start);
+	base = ioremap(mem->start, mem_size);
+	if (!base) {
+		printk(KERN_ERR "failed to map IO memory\n");
+		release_mem_region(mem->start, mem_size);
+		return -ENOMEM;
+	}
 
 	/* Configure the Palm Chip controller */
 	palm_bk3710_chipinit(base);
-- 
1.6.1

