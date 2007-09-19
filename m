From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 3/3] ide: add CONFIG_IDE_ARCH_OBSOLETE_INIT
Date: Wed, 19 Sep 2007 22:11:03 +0200
Message-ID: <200709192211.03850.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.189]:40933 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752421AbXISUIh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 19 Sep 2007 16:08:37 -0400
Received: by nf-out-0910.google.com with SMTP id g13so272656nfb
        for <linux-ide@vger.kernel.org>; Wed, 19 Sep 2007 13:08:36 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


Add CONFIG_IDE_ARCH_OBSOLETE_INIT to drivers/ide/Kconfig and use it instead
of defining IDE_ARCH_OBSOLETE_INIT in <arch/ide.h>.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/Kconfig                 |    3 +++
 drivers/ide/setup-pci.c             |    2 +-
 include/asm-alpha/ide.h             |    1 -
 include/asm-arm/ide.h               |    1 -
 include/asm-arm26/ide.h             |    1 -
 include/asm-blackfin/ide.h          |    1 -
 include/asm-i386/ide.h              |    1 -
 include/asm-ia64/ide.h              |    1 -
 include/asm-m32r/ide.h              |    1 -
 include/asm-mips/mach-generic/ide.h |    1 -
 include/asm-parisc/ide.h            |    1 -
 include/asm-powerpc/ide.h           |    1 -
 include/asm-sh64/ide.h              |    1 -
 include/asm-sparc/ide.h             |    1 -
 include/asm-sparc64/ide.h           |    1 -
 include/linux/ide.h                 |    8 ++------
 16 files changed, 6 insertions(+), 20 deletions(-)

Index: b/drivers/ide/Kconfig
===================================================================
--- a/drivers/ide/Kconfig
+++ b/drivers/ide/Kconfig
@@ -1056,6 +1056,9 @@ endif
 config BLK_DEV_IDEDMA
 	def_bool BLK_DEV_IDEDMA_PCI || BLK_DEV_IDEDMA_PMAC || BLK_DEV_IDEDMA_ICS || BLK_DEV_IDE_AU1XXX_MDMA2_DBDMA
 
+config IDE_ARCH_OBSOLETE_INIT
+	def_bool ALPHA || (ARM && !ARCH_L7200) || BLACKFIN || X86 || IA64 || M32R || MIPS || PARISC || PPC || (SUPERH64 && BLK_DEV_IDEPCI) || SPARC
+
 endif
 
 config BLK_DEV_HD_ONLY
Index: b/drivers/ide/setup-pci.c
===================================================================
--- a/drivers/ide/setup-pci.c
+++ b/drivers/ide/setup-pci.c
@@ -388,7 +388,7 @@ static ide_hwif_t *ide_hwif_configure(st
 	if (hwif->io_ports[IDE_DATA_OFFSET] != base ||
 	    hwif->io_ports[IDE_CONTROL_OFFSET] != (ctl | 2)) {
 		memset(&hwif->hw, 0, sizeof(hwif->hw));
-#ifndef IDE_ARCH_OBSOLETE_INIT
+#ifndef CONFIG_IDE_ARCH_OBSOLETE_INIT
 		ide_std_init_ports(&hwif->hw, base, (ctl | 2));
 		hwif->hw.io_ports[IDE_IRQ_OFFSET] = 0;
 #else
Index: b/include/asm-alpha/ide.h
===================================================================
--- a/include/asm-alpha/ide.h
+++ b/include/asm-alpha/ide.h
@@ -40,7 +40,6 @@ static inline unsigned long ide_default_
 	}
 }
 
-#define IDE_ARCH_OBSOLETE_INIT
 #define ide_default_io_ctl(base)	((base) + 0x206) /* obsolete */
 
 #ifdef CONFIG_PCI
Index: b/include/asm-arm/ide.h
===================================================================
--- a/include/asm-arm/ide.h
+++ b/include/asm-arm/ide.h
@@ -18,7 +18,6 @@
 #endif
 
 #if !defined(CONFIG_ARCH_L7200)
-# define IDE_ARCH_OBSOLETE_INIT
 # ifdef CONFIG_ARCH_CLPS7500
 #  define ide_default_io_ctl(base)	((base) + 0x206) /* obsolete */
 # else
Index: b/include/asm-arm26/ide.h
===================================================================
--- a/include/asm-arm26/ide.h
+++ b/include/asm-arm26/ide.h
@@ -26,7 +26,6 @@
 #define __ide_mm_outsw(port,addr,len)   writesw(port,addr,len)
 #define __ide_mm_outsl(port,addr,len)   writesl(port,addr,len)
 
-#define IDE_ARCH_OBSOLETE_INIT
 #define ide_default_io_ctl(base)	(0)
 
 #endif /* __KERNEL__ */
Index: b/include/asm-blackfin/ide.h
===================================================================
--- a/include/asm-blackfin/ide.h
+++ b/include/asm-blackfin/ide.h
@@ -20,7 +20,6 @@
 #define MAX_HWIFS	1
 
 /* Legacy ... BLK_DEV_IDECS */
-#define IDE_ARCH_OBSOLETE_INIT
 #define ide_default_io_ctl(base)	((base) + 0x206) /* obsolete */
 
 
Index: b/include/asm-i386/ide.h
===================================================================
--- a/include/asm-i386/ide.h
+++ b/include/asm-i386/ide.h
@@ -62,7 +62,6 @@ static __inline__ unsigned long ide_defa
 	}
 }
 
-#define IDE_ARCH_OBSOLETE_INIT
 #define ide_default_io_ctl(base)	((base) + 0x206) /* obsolete */
 
 #ifdef CONFIG_BLK_DEV_IDEPCI
Index: b/include/asm-ia64/ide.h
===================================================================
--- a/include/asm-ia64/ide.h
+++ b/include/asm-ia64/ide.h
@@ -46,7 +46,6 @@ static inline unsigned long ide_default_
 	}
 }
 
-#define IDE_ARCH_OBSOLETE_INIT
 #define ide_default_io_ctl(base)	((base) + 0x206) /* obsolete */
 
 #ifdef CONFIG_PCI
Index: b/include/asm-m32r/ide.h
===================================================================
--- a/include/asm-m32r/ide.h
+++ b/include/asm-m32r/ide.h
@@ -65,7 +65,6 @@ static __inline__ unsigned long ide_defa
 	}
 }
 
-#define IDE_ARCH_OBSOLETE_INIT
 #define ide_default_io_ctl(base)	((base) + 0x206) /* obsolete */
 
 #ifdef CONFIG_BLK_DEV_IDEPCI
Index: b/include/asm-mips/mach-generic/ide.h
===================================================================
--- a/include/asm-mips/mach-generic/ide.h
+++ b/include/asm-mips/mach-generic/ide.h
@@ -98,7 +98,6 @@ static __inline__ unsigned long ide_defa
 	}
 }
 
-#define IDE_ARCH_OBSOLETE_INIT
 #define ide_default_io_ctl(base)	((base) + 0x206) /* obsolete */
 
 #ifdef CONFIG_BLK_DEV_IDEPCI
Index: b/include/asm-parisc/ide.h
===================================================================
--- a/include/asm-parisc/ide.h
+++ b/include/asm-parisc/ide.h
@@ -17,7 +17,6 @@
 #define MAX_HWIFS	2
 #endif
 
-#define IDE_ARCH_OBSOLETE_INIT
 #define ide_default_io_ctl(base)	((base) + 0x206) /* obsolete */
 
 #define ide_request_irq(irq,hand,flg,dev,id)	request_irq((irq),(hand),(flg),(dev),(id))
Index: b/include/asm-powerpc/ide.h
===================================================================
--- a/include/asm-powerpc/ide.h
+++ b/include/asm-powerpc/ide.h
@@ -74,7 +74,6 @@ static __inline__ unsigned long ide_defa
 
 #endif /* __powerpc64__ */
 
-#define IDE_ARCH_OBSOLETE_INIT
 #define ide_default_io_ctl(base)	((base) + 0x206) /* obsolete */
 
 #endif /* __KERNEL__ */
Index: b/include/asm-sh64/ide.h
===================================================================
--- a/include/asm-sh64/ide.h
+++ b/include/asm-sh64/ide.h
@@ -19,7 +19,6 @@
 /* Without this, the initialisation of PCI IDE cards end up calling
  * ide_init_hwif_ports, which won't work. */
 #ifdef CONFIG_BLK_DEV_IDEPCI
-#define IDE_ARCH_OBSOLETE_INIT 1
 #define ide_default_io_ctl(base)	(0)
 #endif
 
Index: b/include/asm-sparc/ide.h
===================================================================
--- a/include/asm-sparc/ide.h
+++ b/include/asm-sparc/ide.h
@@ -18,7 +18,6 @@
 #undef  MAX_HWIFS
 #define MAX_HWIFS	2
 
-#define IDE_ARCH_OBSOLETE_INIT
 #define ide_default_io_ctl(base)	((base) + 0x206) /* obsolete */
 
 #define __ide_insl(data_reg, buffer, wcount) \
Index: b/include/asm-sparc64/ide.h
===================================================================
--- a/include/asm-sparc64/ide.h
+++ b/include/asm-sparc64/ide.h
@@ -24,7 +24,6 @@
 # endif
 #endif
 
-#define IDE_ARCH_OBSOLETE_INIT
 #define ide_default_io_ctl(base)	((base) + 0x206) /* obsolete */
 
 #define __ide_insl(data_reg, buffer, wcount) \
Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -265,11 +265,7 @@ static inline void ide_std_init_ports(hw
 # define ide_init_default_irq(base)	(0)
 #endif
 
-/*
- * ide_init_hwif_ports() is OBSOLETE and will be removed in 2.7 series.
- * New ports shouldn't define IDE_ARCH_OBSOLETE_INIT in <asm/ide.h>.
- */
-#ifdef IDE_ARCH_OBSOLETE_INIT
+#ifdef CONFIG_IDE_ARCH_OBSOLETE_INIT
 static inline void ide_init_hwif_ports(hw_regs_t *hw,
 				       unsigned long io_addr,
 				       unsigned long ctl_addr,
@@ -299,7 +295,7 @@ static inline void ide_init_hwif_ports(h
 	if (io_addr || ctl_addr)
 		printk(KERN_WARNING "%s: must not be called\n", __FUNCTION__);
 }
-#endif /* IDE_ARCH_OBSOLETE_INIT */
+#endif /* CONFIG_IDE_ARCH_OBSOLETE_INIT */
 
 /* Currently only m68k, apus and m8xx need it */
 #ifndef IDE_ARCH_ACK_INTR
