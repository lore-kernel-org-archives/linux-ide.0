From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCH v2 9/9] ARM: at91: remove useless Makefile.boot
Date: Mon, 23 Mar 2015 20:29:15 +0100
Message-ID: <1427138955-3617-10-git-send-email-alexandre.belloni@free-electrons.com>
References: <1427138955-3617-1-git-send-email-alexandre.belloni@free-electrons.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1427138955-3617-1-git-send-email-alexandre.belloni@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, linux-pcmcia@lists.infradead.org, linux-arm-kernel@lists.infradead.org, Alexandre Belloni <alexandre.belloni@free-electrons.com>
List-Id: linux-ide@vger.kernel.org

Makefile.boot is not used anymore, remove it.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/mach-at91/Makefile.boot | 8 --------
 1 file changed, 8 deletions(-)
 delete mode 100644 arch/arm/mach-at91/Makefile.boot

diff --git a/arch/arm/mach-at91/Makefile.boot b/arch/arm/mach-at91/Makefile.boot
deleted file mode 100644
index 29ed0fa374ca..000000000000
--- a/arch/arm/mach-at91/Makefile.boot
+++ /dev/null
@@ -1,8 +0,0 @@
-# Note: the following conditions must always be true:
-#   ZRELADDR == virt_to_phys(TEXTADDR)
-#   PARAMS_PHYS must be within 4MB of ZRELADDR
-#   INITRD_PHYS must be in RAM
-
-   zreladdr-y	+= 0x20008000
-params_phys-y	:= 0x20000100
-initrd_phys-y	:= 0x20410000
-- 
2.1.0
