From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] ata: fix gemini Kconfig dependencies
Date: Mon, 10 Jul 2017 10:51:02 +0200
Message-ID: <20170710085120.1984293-1-arnd@arndb.de>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.24]:56541 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752454AbdGJIvo (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 10 Jul 2017 04:51:44 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Linus Walleij <linus.walleij@linaro.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

We cannot build the new ftide010 code without also building the faraday
sata bridge driver:

drivers/ata/pata_ftide010.o: In function `pata_ftide010_probe':
pata_ftide010.c:(.text+0x2b8): undefined reference to `gemini_sata_bridge_get'
pata_ftide010.c:(.text+0x32c): undefined reference to `gemini_sata_get_muxmode'
pata_ftide010.c:(.text+0x358): undefined reference to `gemini_sata_bridge_enabled'
drivers/ata/pata_ftide010.o: In function `pata_ftide010_gemini_port_stop':
pata_ftide010.c:(.text+0x520): undefined reference to `gemini_sata_stop_bridge'
drivers/ata/pata_ftide010.o: In function `pata_ftide010_gemini_port_start':
pata_ftide010.c:(.text+0x5bc): undefined reference to `gemini_sata_start_bridge'

This adjusts the Kconfig dependencies accordingly.

Fixes: be4e456ed3a5 ("ata: Add driver for Faraday Technology FTIDE010")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/ata/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index 948fc86980a1..363fc5330c21 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -215,7 +215,7 @@ config SATA_FSL
 
 config SATA_GEMINI
 	tristate "Gemini SATA bridge support"
-	depends on PATA_FTIDE010
+	depends on ARCH_GEMINI || COMPILE_TEST
 	default ARCH_GEMINI
 	help
 	  This enabled support for the FTIDE010 to SATA bridge
@@ -613,7 +613,7 @@ config PATA_FTIDE010
 	tristate "Faraday Technology FTIDE010 PATA support"
 	depends on OF
 	depends on ARM
-	default ARCH_GEMINI
+	depends on SATA_GEMINI
 	help
 	  This option enables support for the Faraday FTIDE010
 	  PATA controller found in the Cortina Gemini SoCs.
-- 
2.9.0

