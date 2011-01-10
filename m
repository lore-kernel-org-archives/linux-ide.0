From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH 1/2 v2] pata_hpt366: use pr_warning(...) instead of printk(KERN_WARNING ...)
Date: Mon, 10 Jan 2011 18:54:17 +0300
Message-ID: <201101101854.17767.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dev.rtsoft.ru ([213.79.90.226]:43928 "HELO
	mail.dev.rtsoft.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751463Ab1AJPzj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 10 Jan 2011 10:55:39 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org
Cc: alan@lxorguk.ukuu.org.uk

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
The patch is against the recent Linus' tree plus the patches queued by
Jeff Garzik in his 'upstream-linus' branch.

 drivers/ata/pata_hpt366.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

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
@@ -160,8 +160,8 @@ static int hpt_dma_blacklisted(const str
 
 	while (list[i] != NULL) {
 		if (!strcmp(list[i], model_num)) {
-			printk(KERN_WARNING DRV_NAME ": %s is not supported for %s.\n",
-				modestr, list[i]);
+			pr_warning(DRV_NAME ": %s is not supported for %s.\n",
+				   modestr, list[i]);
 			return 1;
 		}
 		i++;
