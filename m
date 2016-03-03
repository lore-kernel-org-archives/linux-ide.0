From: Simon Horman <horms+renesas@verge.net.au>
Subject: [PATCH] ata: sata_rcar: Use ARCH_RENESAS
Date: Thu,  3 Mar 2016 10:28:50 +0900
Message-ID: <1456968530-19635-1-git-send-email-horms+renesas@verge.net.au>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms+renesas@verge.net.au>
List-Id: linux-ide@vger.kernel.org

Make use of ARCH_RENESAS in place of ARCH_SHMOBILE.

This is part of an ongoing process to migrate from ARCH_SHMOBILE to
ARCH_RENESAS the motivation for which being that RENESAS seems to be a more
appropriate name than SHMOBILE for the majority of Renesas ARM based SoCs.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/ata/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

 Based on libata/master

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index 861643ea91b5..f1f83e9bf425 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -355,7 +355,7 @@ config SATA_PROMISE
 
 config SATA_RCAR
 	tristate "Renesas R-Car SATA support"
-	depends on ARCH_SHMOBILE || COMPILE_TEST
+	depends on ARCH_RENESAS || COMPILE_TEST
 	help
 	  This option enables support for Renesas R-Car Serial ATA.
 
-- 
2.1.4
