From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ide: fix defining SUPPORT_VLB_SYNC
Date: Sat, 29 Mar 2008 19:58:21 +0100
Message-ID: <200803291958.22010.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.159]:43493 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753765AbYC2Sny (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 29 Mar 2008 14:43:54 -0400
Received: by fg-out-1718.google.com with SMTP id l27so905032fgb.17
        for <linux-ide@vger.kernel.org>; Sat, 29 Mar 2008 11:43:52 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

We need to check for CONFIG_{CRIS,FRV} not {CRIS,FRV}.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 include/linux/ide.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -26,7 +26,7 @@
 #include <asm/semaphore.h>
 #include <asm/mutex.h>
 
-#if defined(CRIS) || defined(FRV)
+#if defined(CONFIG_CRIS) || defined(CONFIG_FRV)
 # define SUPPORT_VLB_SYNC 0
 #else
 # define SUPPORT_VLB_SYNC 1
