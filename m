From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 1/10] ide: fix <asm-xtensa/ide.h>
Date: Mon, 7 Jul 2008 23:52:56 +0200
Message-ID: <200807072352.56126.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.30]:9234 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758191AbYGGWAv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 7 Jul 2008 18:00:51 -0400
Received: by yw-out-2324.google.com with SMTP id 9so1051966ywe.1
        for <linux-ide@vger.kernel.org>; Mon, 07 Jul 2008 15:00:45 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Chris Zankel <chris@zankel.net>


* Add missing <asm-generic/ide_iops.h> include.

While at it:

* Remove needless ide_default_{irq,io_base}() inlines.

Cc: Chris Zankel <chris@zankel.net>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 include/asm-xtensa/ide.h |   13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

Index: b/include/asm-xtensa/ide.h
===================================================================
--- a/include/asm-xtensa/ide.h
+++ b/include/asm-xtensa/ide.h
@@ -19,17 +19,8 @@
 # define MAX_HWIFS	1
 #endif
 
-static __inline__ int ide_default_irq(unsigned long base)
-{
-	/* Unsupported! */
-  	return 0;
-}
-
-static __inline__ unsigned long ide_default_io_base(int index)
-{
-	/* Unsupported! */
-  	return 0;
-}
+#include <asm-generic/ide_iops.h>
 
 #endif	/* __KERNEL__ */
+
 #endif	/* _XTENSA_IDE_H */
