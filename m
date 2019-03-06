From: "Enrico Weigelt, metux IT consult" <info@metux.net>
Subject: [PATCH] drivers: ata: Kconfig: pedantic cleanups
Date: Wed,  6 Mar 2019 19:17:44 +0100
Message-ID: <1551896264-21374-1-git-send-email-info@metux.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: axboe@kernel.dk, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/ata/Kconfig | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index 8218db1..ae72350 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -32,7 +32,7 @@ menuconfig ATA
 if ATA
 
 config ATA_NONSTANDARD
-       bool
+	bool
 
 config ATA_VERBOSE_ERROR
 	bool "Verbose ATA error reporting"
@@ -222,7 +222,7 @@ config AHCI_XGENE
 	tristate "APM X-Gene 6.0Gbps AHCI SATA host controller support"
 	depends on PHY_XGENE
 	help
-	 This option enables support for APM X-Gene SoC SATA host controller.
+	  This option enables support for APM X-Gene SoC SATA host controller.
 
 config AHCI_QORIQ
 	tristate "Freescale QorIQ AHCI SATA support"
@@ -256,9 +256,9 @@ config SATA_AHCI_SEATTLE
 	tristate "AMD Seattle 6.0Gbps AHCI SATA host controller support"
 	depends on ARCH_SEATTLE
 	help
-	 This option enables support for AMD Seattle SATA host controller.
+	  This option enables support for AMD Seattle SATA host controller.
 
-	 If unsure, say N
+	  If unsure, say N
 
 config SATA_INIC162X
 	tristate "Initio 162x SATA support (Very Experimental)"
@@ -695,7 +695,7 @@ config PATA_IMX
 	depends on ARCH_MXC
 	help
 	  This option enables support for the PATA host available on Freescale
-          iMX SoCs.
+	  iMX SoCs.
 
 	  If unsure, say N.
 
@@ -704,7 +704,7 @@ config PATA_IT8213
 	depends on PCI
 	help
 	  This option enables support for the ITE 821 PATA
-          controllers via the new ATA layer.
+	  controllers via the new ATA layer.
 
 	  If unsure, say N.
 
@@ -732,9 +732,9 @@ config PATA_MACIO
 	depends on PPC_PMAC
 	help
 	  Most IDE capable PowerMacs have IDE busses driven by a variant
-          of this controller which is part of the Apple chipset used on
-          most PowerMac models. Some models have multiple busses using
-          different chipsets, though generally, MacIO is one of them.
+	  of this controller which is part of the Apple chipset used on
+	  most PowerMac models. Some models have multiple busses using
+	  different chipsets, though generally, MacIO is one of them.
 
 config PATA_MARVELL
 	tristate "Marvell PATA support via legacy mode"
-- 
1.9.1
