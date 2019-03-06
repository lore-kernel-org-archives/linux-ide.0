From: "Enrico Weigelt, metux IT consult" <info@metux.net>
Subject: [PATCH] drivers: ide: Kconfig: pedantic cleanups
Date: Wed,  6 Mar 2019 20:03:24 +0100
Message-ID: <1551899004-25283-1-git-send-email-info@metux.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: davem@davemloft.net, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/ide/Kconfig | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/ide/Kconfig b/drivers/ide/Kconfig
index 901b883..19fcd07 100644
--- a/drivers/ide/Kconfig
+++ b/drivers/ide/Kconfig
@@ -320,9 +320,9 @@ config BLK_DEV_OFFBOARD
 config BLK_DEV_GENERIC
 	tristate "Generic PCI IDE Chipset Support"
 	select BLK_DEV_IDEPCI
-        help
-          This option provides generic support for various PCI IDE Chipsets
-          which otherwise might not be supported.
+	help
+	  This option provides generic support for various PCI IDE Chipsets
+	  which otherwise might not be supported.
 
 config BLK_DEV_OPTI621
 	tristate "OPTi 82C621 chipset enhanced support"
@@ -516,7 +516,7 @@ config BLK_DEV_IT8213
 	tristate "IT8213 IDE support"
 	select BLK_DEV_IDEDMA_PCI
 	help
-	 This driver adds support for the ITE 8213 IDE controller.
+	  This driver adds support for the ITE 8213 IDE controller.
 
 config BLK_DEV_IT821X
 	tristate "IT821X IDE support"
@@ -671,20 +671,20 @@ config BLK_DEV_IDE_PMAC_ATA100FIRST
 	  hard disk and hdc for CD-ROM.
 
 config BLK_DEV_IDE_AU1XXX
-       bool "IDE for AMD Alchemy Au1200"
-       depends on MIPS_ALCHEMY
-       select IDE_XFER_MODE
+	bool "IDE for AMD Alchemy Au1200"
+	depends on MIPS_ALCHEMY
+	select IDE_XFER_MODE
 choice
-       prompt "IDE Mode for AMD Alchemy Au1200"
-       default BLK_DEV_IDE_AU1XXX_PIO_DBDMA
-       depends on BLK_DEV_IDE_AU1XXX
+	prompt "IDE Mode for AMD Alchemy Au1200"
+	default BLK_DEV_IDE_AU1XXX_PIO_DBDMA
+	depends on BLK_DEV_IDE_AU1XXX
 
 config BLK_DEV_IDE_AU1XXX_PIO_DBDMA
-       bool "PIO+DbDMA IDE for AMD Alchemy Au1200"
+	bool "PIO+DbDMA IDE for AMD Alchemy Au1200"
 
 config BLK_DEV_IDE_AU1XXX_MDMA2_DBDMA
-       bool "MDMA2+DbDMA IDE for AMD Alchemy Au1200"
-       depends on BLK_DEV_IDE_AU1XXX
+	bool "MDMA2+DbDMA IDE for AMD Alchemy Au1200"
+	depends on BLK_DEV_IDE_AU1XXX
 endchoice
 
 config BLK_DEV_IDE_TX4938
-- 
1.9.1
