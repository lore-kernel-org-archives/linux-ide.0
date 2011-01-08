From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH 1/2] pata_hpt366: use pr_warning(...) instead of printk(KERN_WARNING ...)
Date: Sat, 8 Jan 2011 22:47:21 +0300
Message-ID: <201101082247.21936.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dev.rtsoft.ru ([213.79.90.226]:35759 "HELO
	mail.dev.rtsoft.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751077Ab1AHTsm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 8 Jan 2011 14:48:42 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org
Cc: alan@lxorguk.ukuu.org.uk

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
The patch is against the recent Linus' tree plus the patch I have re-posted
today:

http://marc.info/?l=linux-ide&m=129450185904620

 drivers/ata/pata_hpt366.c |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

Index: linux-2.6/drivers/ata/pata_hpt366.c
===================================================================
--- linux-2.6.orig/drivers/ata/pata_hpt366.c
+++ linux-2.6/drivers/ata/pata_hpt366.c
@@ -25,7 +25,7 @@
 #include <linux/libata.h>
 
 #define DRV_NAME	"pata_hpt366"
-#define DRV_VERSION	"0.6.9"
+#define DRV_VERSION	"0.6.10"
 
 struct hpt_clock {
 	u8	xfer_mode;
@@ -160,9 +160,8 @@ static int hpt_dma_blacklisted(const str
 
 	while (list[i] != NULL) {
 		if (!strcmp(list[i], model_num)) {
-			printk(KERN_WARNING DRV_NAME
-				": %s is not supported for %s.\n",
-				modestr, list[i]);
+			pr_warning(DRV_NAME ": %s is not supported for %s.\n",
+				   modestr, list[i]);
 			return 1;
 		}
 		i++;

