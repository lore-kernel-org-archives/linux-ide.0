From: Simon Horman <horms+renesas@verge.net.au>
Subject: [PATCH] libata: do not limit R-Car SATA driver to shmobile
Date: Fri, 24 May 2013 11:05:59 +0900
Message-ID: <1369361159-20724-1-git-send-email-horms+renesas@verge.net.au>
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, linux-sh@vger.kernel.org
Cc: Magnus Damm <magnus.damm@gmail.com>, Vladimir Barinov <vladimir.barinov@cogentembedded.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Simon Horman <horms+renesas@verge.net.au>
List-Id: linux-ide@vger.kernel.org

The motivation for this is to allow the driver to be
used with the r8a7790 SoC.

I believe that rather than adding another SoC to the list of allowed SoCs
it is better to simply remove the dependency of the driver on shmobile all
together.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/ata/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index a5a3ebc..aba6e93 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -263,7 +263,6 @@ config SATA_PROMISE
 
 config SATA_RCAR
 	tristate "Renesas R-Car SATA support"
-	depends on ARCH_SHMOBILE && ARCH_R8A7779
 	help
 	  This option enables support for Renesas R-Car Serial ATA.
 
-- 
1.8.2.1

