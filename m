From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 3/3] remove <linux/ata.h> include from <linux/hdreg.h>
Date: Sun, 27 Jul 2008 17:32:13 +0200
Message-ID: <200807271732.13758.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.157]:10604 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751224AbYG0PfG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 27 Jul 2008 11:35:06 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1928048fgg.17
        for <linux-ide@vger.kernel.org>; Sun, 27 Jul 2008 08:35:05 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>

All <linux/hdreg.h> users that need <linux/ata.h> have been fixed
to include it directly.

Cc: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 include/linux/hdreg.h |    4 ----
 1 file changed, 4 deletions(-)

Index: b/include/linux/hdreg.h
===================================================================
--- a/include/linux/hdreg.h
+++ b/include/linux/hdreg.h
@@ -1,10 +1,6 @@
 #ifndef _LINUX_HDREG_H
 #define _LINUX_HDREG_H
 
-#ifdef __KERNEL__
-#include <linux/ata.h>
-#endif /* __KERNEL__ */
-
 #include <linux/types.h>
 
 /*
