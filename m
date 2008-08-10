From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ide: fix support for IDE PCI controllers using MMIO on frv
Date: Sun, 10 Aug 2008 17:44:30 +0200
Message-ID: <200808101744.31144.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.188]:15451 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753890AbYHJPtt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 10 Aug 2008 11:49:49 -0400
Received: by fk-out-0910.google.com with SMTP id 18so1417867fkq.5
        for <linux-ide@vger.kernel.org>; Sun, 10 Aug 2008 08:49:47 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>

Just include <asm-generic/ide_iops.h> for __ide_mm_*() instead of
defining them to normal I/O helpers so PCI bus <-> CPU byte-swapping
is done as needed.

Cc: David Howells <dhowells@redhat.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
David, please verify it.  Thanks.

 include/asm-frv/ide.h |   10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

Index: b/include/asm-frv/ide.h
===================================================================
--- a/include/asm-frv/ide.h
+++ b/include/asm-frv/ide.h
@@ -18,15 +18,7 @@
 #include <asm/io.h>
 #include <asm/irq.h>
 
-/****************************************************************************/
-/*
- * some bits needed for parts of the IDE subsystem to compile
- */
-#define __ide_mm_insw(port, addr, n)	insw((unsigned long) (port), addr, n)
-#define __ide_mm_insl(port, addr, n)	insl((unsigned long) (port), addr, n)
-#define __ide_mm_outsw(port, addr, n)	outsw((unsigned long) (port), addr, n)
-#define __ide_mm_outsl(port, addr, n)	outsl((unsigned long) (port), addr, n)
-
+#include <asm-generic/ide_iops.h>
 
 #endif /* __KERNEL__ */
 #endif /* _ASM_IDE_H */
