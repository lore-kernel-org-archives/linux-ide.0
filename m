From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 02/10] libata: update ata_*_printk() macros such that level can be a variable
Date: Sat, 15 Dec 2007 15:04:58 +0900
Message-ID: <11976987061388-git-send-email-htejun@gmail.com>
References: <11976987063011-git-send-email-htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.187]:53382 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756619AbXLOGFM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 15 Dec 2007 01:05:12 -0500
Received: by rv-out-0910.google.com with SMTP id k20so1193509rvb.1
        for <linux-ide@vger.kernel.org>; Fri, 14 Dec 2007 22:05:12 -0800 (PST)
In-Reply-To: <11976987063011-git-send-email-htejun@gmail.com>
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
index 1ca9b89..3784af3 100644
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

