From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 3/3] libata: kill assert() macro
Date: Sat, 11 Feb 2006 19:11:13 +0900
Message-ID: <11396526733651-git-send-email-htejun@gmail.com>
References: <11396526734098-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pproxy.gmail.com ([64.233.166.178]:6714 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751312AbWBKKLQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 11 Feb 2006 05:11:16 -0500
Received: by pproxy.gmail.com with SMTP id e30so386474pya
        for <linux-ide@vger.kernel.org>; Sat, 11 Feb 2006 02:11:16 -0800 (PST)
In-Reply-To: <11396526734098-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

libata assert() now has no user left.  Kill it.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 include/linux/libata.h |   10 ----------
 1 files changed, 0 insertions(+), 10 deletions(-)

c832a91bfb341cc331bda1c27ad433a769d3fc4a
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 695d9ae..83a1f2e 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -62,16 +62,6 @@
 
 #define BPRINTK(fmt, args...) if (ap->flags & ATA_FLAG_DEBUGMSG) printk(KERN_ERR "%s: " fmt, __FUNCTION__, ## args)
 
-#ifdef ATA_NDEBUG
-#define assert(expr)
-#else
-#define assert(expr) \
-        if(unlikely(!(expr))) {                                   \
-        printk(KERN_ERR "Assertion failed! %s,%s,%s,line=%d\n", \
-        #expr,__FILE__,__FUNCTION__,__LINE__);          \
-        }
-#endif
-
 /* NEW: debug levels */
 #define HAVE_LIBATA_MSG 1
 
-- 
1.1.5


