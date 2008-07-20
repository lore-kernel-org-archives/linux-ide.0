From: Alexander Beregalov <a.beregalov@gmail.com>
Subject: [PATCH] libata.h: replace __FUNCTION__ with __func__
Date: Mon, 21 Jul 2008 00:06:19 +0400
Message-ID: <48839ABB.3070503@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.188]:44370 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751662AbYGTUGb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 20 Jul 2008 16:06:31 -0400
Received: by mu-out-0910.google.com with SMTP id w8so703572mue.1
        for <linux-ide@vger.kernel.org>; Sun, 20 Jul 2008 13:06:29 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org, kernel-janitors@vger.kernel.org

From: Alexander Beregalov <a.beregalov@gmail.com>

libata.h: replace __FUNCTION__ with __func__


Signed-off-by: Alexander Beregalov <a.beregalov@gmail.com>

---

 include/linux/libata.h |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/libata.h b/include/linux/libata.h
index 5b247b8..d4b8e5f 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -60,9 +60,9 @@

 /* note: prints function name for you */
 #ifdef ATA_DEBUG
-#define DPRINTK(fmt, args...) printk(KERN_ERR "%s: " fmt, __FUNCTION__, ## args)
+#define DPRINTK(fmt, args...) printk(KERN_ERR "%s: " fmt, __func__, ## args)
 #ifdef ATA_VERBOSE_DEBUG
-#define VPRINTK(fmt, args...) printk(KERN_ERR "%s: " fmt, __FUNCTION__, ## args)
+#define VPRINTK(fmt, args...) printk(KERN_ERR "%s: " fmt, __func__, ## args)
 #else
 #define VPRINTK(fmt, args...)
 #endif /* ATA_VERBOSE_DEBUG */
@@ -71,7 +71,7 @@
 #define VPRINTK(fmt, args...)
 #endif /* ATA_DEBUG */

-#define BPRINTK(fmt, args...) if (ap->flags & ATA_FLAG_DEBUGMSG) printk(KERN_ERR "%s: " fmt, __FUNCTION__, ## args)
+#define BPRINTK(fmt, args...) if (ap->flags & ATA_FLAG_DEBUGMSG) printk(KERN_ERR "%s: " fmt, __func__, ## args)

 /* NEW: debug levels */
 #define HAVE_LIBATA_MSG 1
