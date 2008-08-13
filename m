From: Adrian Bunk <bunk@kernel.org>
Subject: [2.6 patch] xtensa: remove dead CONFIG_BLK_DEV_IDE code
Date: Thu, 14 Aug 2008 01:19:07 +0300
Message-ID: <20080813221907.GE7071@cs181140183.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp5.pp.htv.fi ([213.243.153.39]:39587 "EHLO smtp5.pp.htv.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752237AbYHMWU7 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 13 Aug 2008 18:20:59 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, chris@zankel.net
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

I don't know why this was there, but it was dead code.

Signed-off-by: Adrian Bunk <bunk@kernel.org>

---
f2db4adb7a7f8fc0ea216fbc2d38a0c3802894ab 
diff --git a/arch/xtensa/kernel/setup.c b/arch/xtensa/kernel/setup.c
index a00359e..9606d2b 100644
--- a/arch/xtensa/kernel/setup.c
+++ b/arch/xtensa/kernel/setup.c
@@ -53,11 +53,6 @@ extern struct fd_ops no_fd_ops;
 struct fd_ops *fd_ops;
 #endif
 
-#if defined(CONFIG_BLK_DEV_IDE) || defined(CONFIG_BLK_DEV_IDE_MODULE)
-extern struct ide_ops no_ide_ops;
-struct ide_ops *ide_ops;
-#endif
-
 extern struct rtc_ops no_rtc_ops;
 struct rtc_ops *rtc_ops;
 

