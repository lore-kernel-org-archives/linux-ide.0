From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] ata: pata_at91 only works on sam9
Date: Thu,  8 May 2014 16:56:21 +0200
Message-ID: <1399560990-1402858-10-git-send-email-arnd@arndb.de>
References: <1399560433-1402630-1-git-send-email-arnd@arndb.de>
 <1399560990-1402858-1-git-send-email-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1399560990-1402858-1-git-send-email-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Nicolas Ferre <nicolas.ferre@atmel.com>
List-Id: linux-ide@vger.kernel.org

The smc driver used by pata_at91 is at91sam9 specific, so building
this driver on another at91 platform results in this error:

ERROR: "sam9_smc_configure" [drivers/ata/pata_at91.ko] undefined!
ERROR: "sam9_smc_write_mode" [drivers/ata/pata_at91.ko] undefined!
ERROR: "sam9_smc_read_mode" [drivers/ata/pata_at91.ko] undefined!

This patch changes the Kconfig dependency to ensure it always works.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 drivers/ata/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index a91bf47..7671dba 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -824,7 +824,7 @@ config PATA_AT32
 
 config PATA_AT91
 	tristate "PATA support for AT91SAM9260"
-	depends on ARM && ARCH_AT91
+	depends on ARM && SOC_AT91SAM9
 	help
 	  This option enables support for IDE devices on the Atmel AT91SAM9260 SoC.
 
-- 
1.8.3.2
