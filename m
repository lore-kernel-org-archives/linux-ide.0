From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH] ata: Allow drivers to build if COMPILE_TEST is enabled
Date: Tue, 13 Oct 2015 15:39:06 +0200
Message-ID: <1444743546-11917-1-git-send-email-javier@osg.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Luis de Bethencourt <luisbg@osg.samsung.com>, Javier Martinez Canillas <javier@osg.samsung.com>, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

These drivers only have runtime but no build time dependencies so can be
built for testing purposes if the Kconfig COMPILE_TEST option is enabled.

This is useful to have more build coverage and make sure that drivers are
not affected by changes that could cause build regressions.

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>

---

 drivers/ata/Kconfig | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index 6aaa3f81755b..939f45d094d2 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -100,7 +100,7 @@ config SATA_AHCI_PLATFORM
 
 config AHCI_BRCMSTB
 	tristate "Broadcom STB AHCI SATA support"
-	depends on ARCH_BRCMSTB
+	depends on ARCH_BRCMSTB	|| COMPILE_TEST
 	help
 	  This option enables support for the AHCI SATA3 controller found on
 	  STB SoC's.
@@ -109,7 +109,7 @@ config AHCI_BRCMSTB
 
 config AHCI_DA850
 	tristate "DaVinci DA850 AHCI SATA support"
-	depends on ARCH_DAVINCI_DA850
+	depends on ARCH_DAVINCI_DA850 || COMPILE_TEST
 	help
 	  This option enables support for the DaVinci DA850 SoC's
 	  onboard AHCI SATA.
@@ -118,7 +118,7 @@ config AHCI_DA850
 
 config AHCI_ST
 	tristate "ST AHCI SATA support"
-	depends on ARCH_STI
+	depends on ARCH_STI || COMPILE_TEST
 	help
 	  This option enables support for ST AHCI SATA controller.
 
@@ -144,7 +144,7 @@ config AHCI_CEVA
 
 config AHCI_MVEBU
 	tristate "Marvell EBU AHCI SATA support"
-	depends on ARCH_MVEBU
+	depends on ARCH_MVEBU || COMPILE_TEST
 	help
 	  This option enables support for the Marvebu EBU SoC's
 	  onboard AHCI SATA.
@@ -153,7 +153,7 @@ config AHCI_MVEBU
 
 config AHCI_SUNXI
 	tristate "Allwinner sunxi AHCI SATA support"
-	depends on ARCH_SUNXI
+	depends on ARCH_SUNXI || COMPILE_TEST
 	help
 	  This option enables support for the Allwinner sunxi SoC's
 	  onboard AHCI SATA.
@@ -162,7 +162,7 @@ config AHCI_SUNXI
 
 config AHCI_TEGRA
 	tristate "NVIDIA Tegra124 AHCI SATA support"
-	depends on ARCH_TEGRA
+	depends on ARCH_TEGRA || COMPILE_TEST
 	help
 	  This option enables support for the NVIDIA Tegra124 SoC's
 	  onboard AHCI SATA.
@@ -186,7 +186,7 @@ config AHCI_QORIQ
 
 config SATA_FSL
 	tristate "Freescale 3.0Gbps SATA support"
-	depends on FSL_SOC
+	depends on FSL_SOC || COMPILE_TEST
 	help
 	  This option enables support for Freescale 3.0Gbps SATA controller.
 	  It can be found on MPC837x and MPC8315.
@@ -296,7 +296,7 @@ config ATA_PIIX
 
 config SATA_DWC
 	tristate "DesignWare Cores SATA support"
-	depends on 460EX
+	depends on 460EX || COMPILE_TEST
 	select DW_DMAC
 	help
 	  This option enables support for the on-chip SATA controller of the
@@ -602,7 +602,7 @@ config PATA_ICSIDE
 
 config PATA_IMX
 	tristate "PATA support for Freescale iMX"
-	depends on ARCH_MXC
+	depends on ARCH_MXC || COMPILE_TEST
 	help
 	  This option enables support for the PATA host available on Freescale
           iMX SoCs.
@@ -820,7 +820,7 @@ config PATA_VIA
 
 config PATA_PXA
 	tristate "PXA DMA-capable PATA support"
-	depends on ARCH_PXA
+	depends on ARCH_PXA || COMPILE_TEST
 	help
 	  This option enables support for harddrive attached to PXA CPU's bus.
 
@@ -871,7 +871,7 @@ config PATA_CMD640_PCI
 
 config PATA_ISAPNP
 	tristate "ISA Plug and Play PATA support"
-	depends on ISAPNP
+	depends on ISAPNP || COMPILE_TEST
 	help
 	  This option enables support for ISA plug & play ATA
 	  controllers such as those found on old soundcards.
@@ -953,7 +953,7 @@ config PATA_OF_PLATFORM
 
 config PATA_QDI
 	tristate "QDI VLB PATA support"
-	depends on ISA
+	depends on ISA || COMPILE_TEST
 	select PATA_LEGACY
 	help
 	  Support for QDI 6500 and 6580 PATA controllers on VESA local bus.
@@ -978,7 +978,7 @@ config PATA_RZ1000
 
 config PATA_SAMSUNG_CF
 	tristate "Samsung SoC PATA support"
-	depends on SAMSUNG_DEV_IDE
+	depends on SAMSUNG_DEV_IDE || COMPILE_TEST
 	help
 	  This option enables basic support for Samsung's S3C/S5P board
 	  PATA controllers via the new ATA layer
@@ -987,7 +987,7 @@ config PATA_SAMSUNG_CF
 
 config PATA_WINBOND_VLB
 	tristate "Winbond W83759A VLB PATA support (Experimental)"
-	depends on ISA
+	depends on ISA || COMPILE_TEST
 	select PATA_LEGACY
 	help
 	  Support for the Winbond W83759A controller on Vesa Local Bus
-- 
2.4.3
