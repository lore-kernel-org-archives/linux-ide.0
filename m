From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 2/9] libata: update ata_*_printk() macros such that level can be a variable
Date: Fri, 14 Dec 2007 15:15:34 +0900
Message-ID: <1197612942101-git-send-email-htejun@gmail.com>
References: <11976129411285-git-send-email-htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.183]:60175 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753048AbXLNGPu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 14 Dec 2007 01:15:50 -0500
Received: by wa-out-1112.google.com with SMTP id v27so1544730wah.23
        for <linux-ide@vger.kernel.org>; Thu, 13 Dec 2007 22:15:50 -0800 (PST)
In-Reply-To: <11976129411285-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, hancockr@shaw.ca, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Make prink helpers format @lv together rather than prepending to the
format string as constant.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 include/linux/libata.h |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/libata.h b/include/linux/libata.h
index 6940344..d3a0caf 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -1013,18 +1013,18 @@ extern void ata_do_eh(struct ata_port *ap, ata_prereset_fn_t prereset,
  * printk helpers
  */
 #define ata_port_printk(ap, lv, fmt, args...) \
-	printk(lv"ata%u: "fmt, (ap)->print_id , ##args)
+	printk("%sata%u: "fmt, lv, (ap)->print_id , ##args)
 
 #define ata_link_printk(link, lv, fmt, args...) do { \
 	if ((link)->ap->nr_pmp_links) \
-		printk(lv"ata%u.%02u: "fmt, (link)->ap->print_id, \
+		printk("%sata%u.%02u: "fmt, lv, (link)->ap->print_id,	\
 		       (link)->pmp , ##args); \
 	else \
-		printk(lv"ata%u: "fmt, (link)->ap->print_id , ##args); \
+		printk("%sata%u: "fmt, lv, (link)->ap->print_id , ##args); \
 	} while(0)
 
 #define ata_dev_printk(dev, lv, fmt, args...) \
-	printk(lv"ata%u.%02u: "fmt, (dev)->link->ap->print_id, \
+	printk("%sata%u.%02u: "fmt, lv, (dev)->link->ap->print_id,	\
 	       (dev)->link->pmp + (dev)->devno , ##args)
 
 /*
-- 
1.5.2.4

