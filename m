From: Adrian Bunk <bunk@kernel.org>
Subject: [2.6 patch] cleanup powerpc/include/asm/ide.h
Date: Fri, 8 Aug 2008 18:18:49 +0300
Message-ID: <20080808151849.GB14495@cs181140183.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp4.pp.htv.fi ([213.243.153.38]:46341 "EHLO smtp4.pp.htv.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752962AbYHHPUY (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 8 Aug 2008 11:20:24 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org

This patch removes code that became unused through IDE changes and the 
arch/ppc/ removal.

Signed-off-by: Adrian Bunk <bunk@kernel.org>

---

 arch/powerpc/include/asm/ide.h |   43 ---------------------------------
 1 file changed, 1 insertion(+), 42 deletions(-)

363979e32b08c578431a1773e7b885698feb30aa 
diff --git a/arch/powerpc/include/asm/ide.h b/arch/powerpc/include/asm/ide.h
index 048480e..da01b20 100644
--- a/arch/powerpc/include/asm/ide.h
+++ b/arch/powerpc/include/asm/ide.h
@@ -6,12 +6,7 @@
 #ifndef _ASM_POWERPC_IDE_H
 #define _ASM_POWERPC_IDE_H
 
-#ifdef __KERNEL__
-
-#ifndef __powerpc64__
-#include <linux/sched.h>
-#include <asm/mpc8xx.h>
-#endif
+#include <linux/compiler.h>
 #include <asm/io.h>
 
 #define __ide_mm_insw(p, a, c)	readsw((void __iomem *)(p), (a), (c))
@@ -19,40 +14,4 @@
 #define __ide_mm_outsw(p, a, c)	writesw((void __iomem *)(p), (a), (c))
 #define __ide_mm_outsl(p, a, c)	writesl((void __iomem *)(p), (a), (c))
 
-#ifndef  __powerpc64__
-#include <linux/ioport.h>
-
-/* FIXME: use ide_platform host driver */
-static __inline__ int ide_default_irq(unsigned long base)
-{
-#ifdef CONFIG_PPLUS
-	switch (base) {
-	case 0x1f0:	return 14;
-	case 0x170:	return 15;
-	}
-#endif
-	return 0;
-}
-
-/* FIXME: use ide_platform host driver */
-static __inline__ unsigned long ide_default_io_base(int index)
-{
-#ifdef CONFIG_PPLUS
-	switch (index) {
-	case 0:		return 0x1f0;
-	case 1:		return 0x170;
-	}
-#endif
-	return 0;
-}
-
-#ifdef CONFIG_BLK_DEV_MPC8xx_IDE
-#define IDE_ARCH_ACK_INTR  1
-#define ide_ack_intr(hwif) ((hwif)->ack_intr ? (hwif)->ack_intr(hwif) : 1)
-#endif
-
-#endif /* __powerpc64__ */
-
-#endif /* __KERNEL__ */
-
 #endif /* _ASM_POWERPC_IDE_H */

