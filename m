From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH 1/2 v3] pata_hpt{366|37x}: use pr_warning(...) instead of printk(KERN_WARNING ...)
Date: Mon, 10 Jan 2011 21:34:27 +0300
Message-ID: <201101102134.28111.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dev.rtsoft.ru ([213.79.90.226]:35842 "HELO
	mail.dev.rtsoft.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751619Ab1AJSfr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 10 Jan 2011 13:35:47 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org
Cc: alan@lxorguk.ukuu.org.uk

... in hpt_dma_blacklisted().

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
The patch is against the recent Linus' tree plus the patches queued by
Jeff Garzik in his 'upstream-linus' branch.

Changes from the previous version:
- added the similar change for the 'pata_hpt37x' driver...

 drivers/ata/pata_hpt366.c |    6 +++---
 drivers/ata/pata_hpt37x.c |    6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

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
Index: linux-2.6/drivers/ata/pata_hpt37x.c
===================================================================
--- linux-2.6.orig/drivers/ata/pata_hpt37x.c
+++ linux-2.6/drivers/ata/pata_hpt37x.c
@@ -24,7 +24,7 @@
 #include <linux/libata.h>
 
 #define DRV_NAME	"pata_hpt37x"
-#define DRV_VERSION	"0.6.18"
+#define DRV_VERSION	"0.6.19"
 
 struct hpt_clock {
 	u8	xfer_speed;
@@ -229,8 +229,8 @@ static int hpt_dma_blacklisted(const str
 
 	while (list[i] != NULL) {
 		if (!strcmp(list[i], model_num)) {
-			printk(KERN_WARNING DRV_NAME ": %s is not supported for %s.\n",
-				modestr, list[i]);
+			pr_warning(DRV_NAME ": %s is not supported for %s.\n",
+				   modestr, list[i]);
 			return 1;
 		}
 		i++;
