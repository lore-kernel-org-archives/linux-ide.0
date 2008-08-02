From: Borislav Petkov <petkovbb@googlemail.com>
Subject: updated remove-unnecessary-linux-hdreg-h-includes.patch
Date: Sat, 2 Aug 2008 11:25:32 +0200
Message-ID: <20080802092532.GA11961@gollum.tnic>
Reply-To: petkovbb@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.157]:7341 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751810AbYHBJZi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 2 Aug 2008 05:25:38 -0400
Received: by fg-out-1718.google.com with SMTP id 19so688215fgg.17
        for <linux-ide@vger.kernel.org>; Sat, 02 Aug 2008 02:25:36 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org

Woopsie, found another one, here's the updated version:

---
From: Adrian Bunk <bunk@kernel.org>
Subject: [2.6 patch] remove unneeded #include <linux/ide.h>'s

This patch remove unneeded #include <linux/ide.h>'s.

It also adds a required #include <linux/interrupt.h> that was previously 
implicitely pulled by ide.h

Signed-off-by: Adrian Bunk <bunk@kernel.org>
[bart: revert change to tests/lkdtm.c (spotted by Stephen Rothwell)]
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---

 arch/arm/mach-pxa/pcm990-baseboard.c |    1 -
 arch/m68k/mac/baboon.c               |    1 -
 arch/m68k/mac/via.c                  |    1 -
 arch/mips/emma2rh/markeins/setup.c   |    1 -
 arch/mips/jazz/setup.c               |    1 -
 arch/sh/boards/renesas/systemh/irq.c |    2 +-
 arch/xtensa/kernel/xtensa_ksyms.c    |    1 -
 7 files changed, 1 insertion(+), 7 deletions(-)

5d4186cd22d575b6adbbeeee7dfa88299817a408 
Index: b/arch/arm/mach-pxa/pcm990-baseboard.c
===================================================================
--- a/arch/arm/mach-pxa/pcm990-baseboard.c
+++ b/arch/arm/mach-pxa/pcm990-baseboard.c
@@ -22,7 +22,6 @@
 
 #include <linux/irq.h>
 #include <linux/platform_device.h>
-#include <linux/ide.h>
 #include <linux/i2c.h>
 #include <linux/pwm_backlight.h>
 
Index: b/arch/m68k/mac/baboon.c
===================================================================
--- a/arch/m68k/mac/baboon.c
+++ b/arch/m68k/mac/baboon.c
@@ -11,7 +11,6 @@
 #include <linux/mm.h>
 #include <linux/delay.h>
 #include <linux/init.h>
-#include <linux/ide.h>
 
 #include <asm/traps.h>
 #include <asm/bootinfo.h>
Index: b/arch/m68k/mac/via.c
===================================================================
--- a/arch/m68k/mac/via.c
+++ b/arch/m68k/mac/via.c
@@ -27,7 +27,6 @@
 #include <linux/mm.h>
 #include <linux/delay.h>
 #include <linux/init.h>
-#include <linux/ide.h>
 #include <linux/module.h>
 
 #include <asm/bootinfo.h>
Index: b/arch/mips/emma2rh/markeins/setup.c
===================================================================
--- a/arch/mips/emma2rh/markeins/setup.c
+++ b/arch/mips/emma2rh/markeins/setup.c
@@ -27,7 +27,6 @@
 #include <linux/types.h>
 #include <linux/initrd.h>
 #include <linux/irq.h>
-#include <linux/ide.h>
 #include <linux/ioport.h>
 #include <linux/param.h>	/* for HZ */
 #include <linux/root_dev.h>
Index: b/arch/mips/jazz/setup.c
===================================================================
--- a/arch/mips/jazz/setup.c
+++ b/arch/mips/jazz/setup.c
@@ -17,7 +17,6 @@
 #include <linux/mm.h>
 #include <linux/console.h>
 #include <linux/fb.h>
-#include <linux/ide.h>
 #include <linux/pm.h>
 #include <linux/screen_info.h>
 #include <linux/platform_device.h>
Index: b/arch/sh/boards/renesas/systemh/irq.c
===================================================================
--- a/arch/sh/boards/mach-systemh/irq.c
+++ b/arch/sh/boards/mach-systemh/irq.c
@@ -11,8 +11,8 @@
 
 #include <linux/init.h>
 #include <linux/irq.h>
+#include <linux/interrupt.h>
 
-#include <linux/ide.h>
 #include <asm/io.h>
 #include <asm/systemh7751.h>
 #include <asm/smc37c93x.h>
Index: b/arch/xtensa/kernel/xtensa_ksyms.c
===================================================================
--- a/arch/xtensa/kernel/xtensa_ksyms.c
+++ b/arch/xtensa/kernel/xtensa_ksyms.c
@@ -18,7 +18,6 @@
 #include <linux/interrupt.h>
 #include <asm/irq.h>
 #include <linux/in6.h>
-#include <linux/ide.h>
 
 #include <asm/uaccess.h>
 #include <asm/checksum.h>

-- 
Regards/Gruss,
    Boris.
