From: Borislav Petkov <petkovbb@googlemail.com>
Subject: [PATCH 1/3] ide-cd: move debug defines into header
Date: Thu, 20 Nov 2008 06:41:21 +0100
Message-ID: <1227159683-2487-2-git-send-email-petkovbb@gmail.com>
References: <1227159683-2487-1-git-send-email-petkovbb@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.154]:30022 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754041AbYKTFlW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 20 Nov 2008 00:41:22 -0500
Received: by fg-out-1718.google.com with SMTP id 19so240445fgg.17
        for <linux-ide@vger.kernel.org>; Wed, 19 Nov 2008 21:41:20 -0800 (PST)
In-Reply-To: <1227159683-2487-1-git-send-email-petkovbb@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Borislav Petkov <petkovbb@gmail.com>

Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
---
 drivers/ide/ide-cd.c |    8 --------
 drivers/ide/ide-cd.h |    8 ++++++++
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
index 5daa4dd..65e5513 100644
--- a/drivers/ide/ide-cd.c
+++ b/drivers/ide/ide-cd.c
@@ -53,14 +53,6 @@
 
 #include "ide-cd.h"
 
-#define IDECD_DEBUG_LOG		1
-
-#if IDECD_DEBUG_LOG
-#define ide_debug_log(lvl, fmt, args...) __ide_debug_log(lvl, fmt, args)
-#else
-#define ide_debug_log(lvl, fmt, args...) do {} while (0)
-#endif
-
 static DEFINE_MUTEX(idecd_ref_mutex);
 
 static void ide_cd_release(struct kref *);
diff --git a/drivers/ide/ide-cd.h b/drivers/ide/ide-cd.h
index d5ce336..389faa4 100644
--- a/drivers/ide/ide-cd.h
+++ b/drivers/ide/ide-cd.h
@@ -8,6 +8,14 @@
 #include <linux/cdrom.h>
 #include <asm/byteorder.h>
 
+#define IDECD_DEBUG_LOG		0
+
+#if IDECD_DEBUG_LOG
+#define ide_debug_log(lvl, fmt, args...) __ide_debug_log(lvl, fmt, args)
+#else
+#define ide_debug_log(lvl, fmt, args...) do {} while (0)
+#endif
+
 /*
  * typical timeout for packet command
  */
-- 
1.6.0.4

