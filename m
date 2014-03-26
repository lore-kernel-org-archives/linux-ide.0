From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH] ata: fix R-Car SATA driver dependencies
Date: Wed, 26 Mar 2014 15:19:23 +0100
Message-ID: <4494466.bbG3GqUbue@amdc1032>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, linux-ide@vger.kernel.org, linux-sh@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Make sata_rcar host driver depend on ARCH_SHMOBILE config option as
Renesas R-Car SATA support is specific to Renesas SoCs and the driver
to work requires suitable device tree node (or platform device) to be
defined.  Additionally allow the driver build if COMPILE_TEST config
option is set.

Cc: Simon Horman <horms@verge.net.au>
Cc: Magnus Damm <magnus.damm@gmail.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/ata/Kconfig |    1 +
 1 file changed, 1 insertion(+)

Index: b/drivers/ata/Kconfig
===================================================================
--- a/drivers/ata/Kconfig	2014-03-25 20:08:10.220311027 +0100
+++ b/drivers/ata/Kconfig	2014-03-26 15:09:04.259143796 +0100
@@ -298,6 +298,7 @@ config SATA_PROMISE
 
 config SATA_RCAR
 	tristate "Renesas R-Car SATA support"
+	depends on ARCH_SHMOBILE || COMPILE_TEST
 	help
 	  This option enables support for Renesas R-Car Serial ATA.
 

