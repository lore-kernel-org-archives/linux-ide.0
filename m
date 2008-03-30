From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 3/5] ide: make 32-bit I/O support for IDE VLB available only when it makes sense
Date: Sun, 30 Mar 2008 17:12:05 +0200
Message-ID: <200803301712.05711.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.172]:13117 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752921AbYC3Pcd (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 30 Mar 2008 11:32:33 -0400
Received: by ug-out-1314.google.com with SMTP id z38so296945ugc.16
        for <linux-ide@vger.kernel.org>; Sun, 30 Mar 2008 08:32:32 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

IDE VLB host drivers depend on ISA && (ALPHA || X86 || MIPS) so only then it
makes sense to support "VLB sync" (controlled by SUPPORT_VLB_SYNC define).

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 include/linux/ide.h |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -26,10 +26,11 @@
 #include <asm/semaphore.h>
 #include <asm/mutex.h>
 
-#if defined(CONFIG_CRIS) || defined(CONFIG_FRV)
-# define SUPPORT_VLB_SYNC 0
-#else
+#if defined(CONFIG_ISA) && \
+    (defined(CONFIG_ALPHA) || defined(CONFIG_X86) || defined(CONFIG_MIPS))
 # define SUPPORT_VLB_SYNC 1
+#else
+# define SUPPORT_VLB_SYNC 0
 #endif
 
 /*
