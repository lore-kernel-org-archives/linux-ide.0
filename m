From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 1/2] ide: add CONFIG_IDE_ARCH_OBSOLETE_DEFAULTS
Date: Thu, 14 Feb 2008 21:55:50 +0100
Message-ID: <200802142155.50893.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hu-out-0506.google.com ([72.14.214.228]:59051 "EHLO
	hu-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751657AbYBNUml (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 14 Feb 2008 15:42:41 -0500
Received: by hu-out-0506.google.com with SMTP id 19so10252111hue.21
        for <linux-ide@vger.kernel.org>; Thu, 14 Feb 2008 12:42:40 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Add CONFIG_IDE_ARCH_OBSOLETE_DEFAULTS to drivers/ide/Kconfig and use
it instead of defining IDE_ARCH_OBSOLETE_DEFAULTS in <arch/ide.h>.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/Kconfig                 |    3 +++
 drivers/ide/ide.c                   |    5 +++++
 include/asm-alpha/ide.h             |    3 ---
 include/asm-ia64/ide.h              |    2 --
 include/asm-m32r/ide.h              |    2 --
 include/asm-mips/mach-generic/ide.h |    2 --
 include/asm-powerpc/ide.h           |    2 --
 include/asm-x86/ide.h               |    2 --
 include/linux/ide.h                 |    7 -------
 9 files changed, 8 insertions(+), 20 deletions(-)

Index: b/drivers/ide/Kconfig
===================================================================
--- a/drivers/ide/Kconfig
+++ b/drivers/ide/Kconfig
@@ -1099,6 +1099,9 @@ config BLK_DEV_IDEDMA
 config IDE_ARCH_OBSOLETE_INIT
 	def_bool ALPHA || (ARM && !ARCH_L7200) || BLACKFIN || X86 || IA64 || M32R || MIPS || PARISC || PPC || (SUPERH64 && BLK_DEV_IDEPCI) || SPARC
 
+config IDE_ARCH_OBSOLETE_DEFAULTS
+	def_bool ALPHA || X86 || IA64 || M32R || MIPS || PPC32
+
 endif
 
 config BLK_DEV_HD_ONLY
Index: b/drivers/ide/ide.c
===================================================================
--- a/drivers/ide/ide.c
+++ b/drivers/ide/ide.c
@@ -167,6 +167,11 @@ static void ide_port_init_devices_data(i
 	}
 }
 
+#ifndef CONFIG_IDE_ARCH_OBSOLETE_DEFAULTS
+# define ide_default_io_base(index)	(0)
+# define ide_default_irq(base)		(0)
+# define ide_init_default_irq(base)	(0)
+#endif
 
 /*
  * init_ide_data() sets reasonable default values into all fields
Index: b/include/asm-alpha/ide.h
===================================================================
--- a/include/asm-alpha/ide.h
+++ b/include/asm-alpha/ide.h
@@ -13,9 +13,6 @@
 
 #ifdef __KERNEL__
 
-
-#define IDE_ARCH_OBSOLETE_DEFAULTS
-
 static inline int ide_default_irq(unsigned long base)
 {
 	switch (base) {
Index: b/include/asm-ia64/ide.h
===================================================================
--- a/include/asm-ia64/ide.h
+++ b/include/asm-ia64/ide.h
@@ -16,8 +16,6 @@
 
 #include <linux/irq.h>
 
-#define IDE_ARCH_OBSOLETE_DEFAULTS
-
 static inline int ide_default_irq(unsigned long base)
 {
 	switch (base) {
Index: b/include/asm-m32r/ide.h
===================================================================
--- a/include/asm-m32r/ide.h
+++ b/include/asm-m32r/ide.h
@@ -23,8 +23,6 @@
 # endif
 #endif
 
-#define IDE_ARCH_OBSOLETE_DEFAULTS
-
 static __inline__ int ide_default_irq(unsigned long base)
 {
 	switch (base) {
Index: b/include/asm-mips/mach-generic/ide.h
===================================================================
--- a/include/asm-mips/mach-generic/ide.h
+++ b/include/asm-mips/mach-generic/ide.h
@@ -27,8 +27,6 @@
 # endif
 #endif
 
-#define IDE_ARCH_OBSOLETE_DEFAULTS
-
 static __inline__ int ide_probe_legacy(void)
 {
 #ifdef CONFIG_PCI
Index: b/include/asm-powerpc/ide.h
===================================================================
--- a/include/asm-powerpc/ide.h
+++ b/include/asm-powerpc/ide.h
@@ -31,8 +31,6 @@
 #include <linux/hdreg.h>
 #include <linux/ioport.h>
 
-#define IDE_ARCH_OBSOLETE_DEFAULTS
-
 /* FIXME: use ide_platform host driver */
 static __inline__ int ide_default_irq(unsigned long base)
 {
Index: b/include/asm-x86/ide.h
===================================================================
--- a/include/asm-x86/ide.h
+++ b/include/asm-x86/ide.h
@@ -20,8 +20,6 @@
 # endif
 #endif
 
-#define IDE_ARCH_OBSOLETE_DEFAULTS
-
 static __inline__ int ide_default_irq(unsigned long base)
 {
 	switch (base) {
Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -194,13 +194,6 @@ static inline void ide_std_init_ports(hw
 #define MAX_HWIFS	CONFIG_IDE_MAX_HWIFS
 #endif
 
-/* needed on alpha, x86/x86_64, ia64, mips, ppc32 and sh */
-#ifndef IDE_ARCH_OBSOLETE_DEFAULTS
-# define ide_default_io_base(index)	(0)
-# define ide_default_irq(base)		(0)
-# define ide_init_default_irq(base)	(0)
-#endif
-
 /* Currently only m68k, apus and m8xx need it */
 #ifndef IDE_ARCH_ACK_INTR
 # define ide_ack_intr(hwif) (1)
