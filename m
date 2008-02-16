From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 10/12] ide: remove ide_init_default_irq() macro
Date: Sat, 16 Feb 2008 17:40:01 +0100
Message-ID: <20080216164001.10174.51110.sendpatchset@localhost.localdomain>
References: <20080216163856.10174.72546.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.190]:28566 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756145AbYBPQZ3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 16 Feb 2008 11:25:29 -0500
Received: by fk-out-0910.google.com with SMTP id z23so1114981fkz.5
        for <linux-ide@vger.kernel.org>; Sat, 16 Feb 2008 08:25:28 -0800 (PST)
In-Reply-To: <20080216163856.10174.72546.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

* Use ide_default_irq() instead of ide_init_default_irq() in
  ide_generic host driver (so the correct IRQ is always set
  regardless of CONFIG_PCI / CONFIG_BLK_DEV_IDEPCI).

* Remove no longer needed ide_init_default_irq() macro.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-generic.c           |    2 +-
 include/asm-alpha/ide.h             |    6 ------
 include/asm-ia64/ide.h              |    6 ------
 include/asm-m32r/ide.h              |    6 ------
 include/asm-mips/mach-generic/ide.h |    6 ------
 include/asm-powerpc/ide.h           |    6 ------
 include/asm-x86/ide.h               |    6 ------
 7 files changed, 1 insertion(+), 37 deletions(-)

Index: b/drivers/ide/ide-generic.c
===================================================================
--- a/drivers/ide/ide-generic.c
+++ b/drivers/ide/ide-generic.c
@@ -102,7 +102,7 @@ static int __init ide_generic_init(void)
 
 			memset(&hw, 0, sizeof(hw));
 			ide_std_init_ports(&hw, io_addr, io_addr + 0x206);
-			hw.irq = ide_init_default_irq(io_addr);
+			hw.irq = ide_default_irq(io_addr);
 			ide_init_port_hw(hwif, &hw);
 
 			hwif->noprobe = oldnoprobe;
Index: b/include/asm-alpha/ide.h
===================================================================
--- a/include/asm-alpha/ide.h
+++ b/include/asm-alpha/ide.h
@@ -37,12 +37,6 @@ static inline unsigned long ide_default_
 	}
 }
 
-#ifdef CONFIG_PCI
-#define ide_init_default_irq(base)	(0)
-#else
-#define ide_init_default_irq(base)	ide_default_irq(base)
-#endif
-
 #include <asm-generic/ide_iops.h>
 
 #endif /* __KERNEL__ */
Index: b/include/asm-ia64/ide.h
===================================================================
--- a/include/asm-ia64/ide.h
+++ b/include/asm-ia64/ide.h
@@ -44,12 +44,6 @@ static inline unsigned long ide_default_
 	}
 }
 
-#ifdef CONFIG_PCI
-#define ide_init_default_irq(base)	(0)
-#else
-#define ide_init_default_irq(base)	ide_default_irq(base)
-#endif
-
 #include <asm-generic/ide_iops.h>
 
 #endif /* __KERNEL__ */
Index: b/include/asm-m32r/ide.h
===================================================================
--- a/include/asm-m32r/ide.h
+++ b/include/asm-m32r/ide.h
@@ -63,12 +63,6 @@ static __inline__ unsigned long ide_defa
 	}
 }
 
-#ifdef CONFIG_BLK_DEV_IDEPCI
-#define ide_init_default_irq(base)     (0)
-#else
-#define ide_init_default_irq(base)     ide_default_irq(base)
-#endif
-
 #include <asm-generic/ide_iops.h>
 
 #endif /* __KERNEL__ */
Index: b/include/asm-mips/mach-generic/ide.h
===================================================================
--- a/include/asm-mips/mach-generic/ide.h
+++ b/include/asm-mips/mach-generic/ide.h
@@ -96,12 +96,6 @@ static __inline__ unsigned long ide_defa
 	}
 }
 
-#ifdef CONFIG_BLK_DEV_IDEPCI
-#define ide_init_default_irq(base)	(0)
-#else
-#define ide_init_default_irq(base)	ide_default_irq(base)
-#endif
-
 /* MIPS port and memory-mapped I/O string operations.  */
 static inline void __ide_flush_prologue(void)
 {
Index: b/include/asm-powerpc/ide.h
===================================================================
--- a/include/asm-powerpc/ide.h
+++ b/include/asm-powerpc/ide.h
@@ -73,12 +73,6 @@ static __inline__ unsigned long ide_defa
 	return 0;
 }
 
-#ifdef CONFIG_PCI
-#define ide_init_default_irq(base)	(0)
-#else
-#define ide_init_default_irq(base)	ide_default_irq(base)
-#endif
-
 #ifdef CONFIG_BLK_DEV_MPC8xx_IDE
 #define IDE_ARCH_ACK_INTR  1
 #define ide_ack_intr(hwif) ((hwif)->ack_intr ? (hwif)->ack_intr(hwif) : 1)
Index: b/include/asm-x86/ide.h
===================================================================
--- a/include/asm-x86/ide.h
+++ b/include/asm-x86/ide.h
@@ -58,12 +58,6 @@ static __inline__ unsigned long ide_defa
 	}
 }
 
-#ifdef CONFIG_BLK_DEV_IDEPCI
-#define ide_init_default_irq(base)	(0)
-#else
-#define ide_init_default_irq(base)	ide_default_irq(base)
-#endif
-
 #include <asm-generic/ide_iops.h>
 
 #endif /* __KERNEL__ */
