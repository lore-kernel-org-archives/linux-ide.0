From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 3/7] ata: Fix experimental tags
Date: Fri, 05 Dec 2008 19:43:03 +0000
Message-ID: <20081205194254.17133.67496.stgit@localhost.localdomain>
References: <20081205194231.17133.42760.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:40160 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755597AbYLETmz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 5 Dec 2008 14:42:55 -0500
In-Reply-To: <20081205194231.17133.42760.stgit@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: kai@kaishome.de, linux-ide@vger.kernel.org, jeff@garzik.org

From: Alan Cox <alan@redhat.com>

Various tags are now way out of date
---

 drivers/ata/Kconfig |   44 ++++++++++++++++++++++----------------------
 1 files changed, 22 insertions(+), 22 deletions(-)


diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index 78fbec8..421b7c7 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -153,7 +153,7 @@ config SATA_PROMISE
 	  If unsure, say N.
 
 config SATA_SX4
-	tristate "Promise SATA SX4 support"
+	tristate "Promise SATA SX4 support (Experimental)"
 	depends on PCI && EXPERIMENTAL
 	help
 	  This option enables support for Promise Serial ATA SX4.
@@ -219,8 +219,8 @@ config PATA_ACPI
 	  otherwise unsupported hardware.
 
 config PATA_ALI
-	tristate "ALi PATA support (Experimental)"
-	depends on PCI && EXPERIMENTAL
+	tristate "ALi PATA support"
+	depends on PCI
 	help
 	  This option enables support for the ALi ATA interfaces
 	  found on the many ALi chipsets.
@@ -263,7 +263,7 @@ config PATA_ATIIXP
 	  If unsure, say N.
 
 config PATA_CMD640_PCI
-	tristate "CMD640 PCI PATA support (Very Experimental)"
+	tristate "CMD640 PCI PATA support (Experimental)"
 	depends on PCI && EXPERIMENTAL
 	help
 	  This option enables support for the CMD640 PCI IDE
@@ -291,8 +291,8 @@ config PATA_CS5520
 	  If unsure, say N.
 
 config PATA_CS5530
-	tristate "CS5530 PATA support (Experimental)"
-	depends on PCI && EXPERIMENTAL
+	tristate "CS5530 PATA support"
+	depends on PCI
 	help
 	  This option enables support for the Cyrix/NatSemi/AMD CS5530
 	  companion chip used with the MediaGX/Geode processor family.
@@ -309,8 +309,8 @@ config PATA_CS5535
 	  If unsure, say N.
 
 config PATA_CS5536
-	tristate "CS5536 PATA support (Experimental)"
-	depends on PCI && X86 && !X86_64 && EXPERIMENTAL
+	tristate "CS5536 PATA support"
+	depends on PCI && X86 && !X86_64
 	help
 	  This option enables support for the AMD CS5536
 	  companion chip used with the Geode LX processor family.
@@ -363,7 +363,7 @@ config PATA_HPT37X
 	  If unsure, say N.
 
 config PATA_HPT3X2N
-	tristate "HPT 372N/302N PATA support (Very Experimental)"
+	tristate "HPT 372N/302N PATA support (Experimental)"
 	depends on PCI && EXPERIMENTAL
 	help
 	  This option enables support for the N variant HPT PATA
@@ -389,8 +389,8 @@ config PATA_HPT3X3_DMA
 	  problems with DMA on this chipset.
 
 config PATA_ISAPNP
-	tristate "ISA Plug and Play PATA support (Experimental)"
-	depends on EXPERIMENTAL && ISAPNP
+	tristate "ISA Plug and Play PATA support"
+	depends on ISAPNP
 	help
 	  This option enables support for ISA plug & play ATA
 	  controllers such as those found on old soundcards.
@@ -498,8 +498,8 @@ config PATA_NINJA32
 	  If unsure, say N.
 
 config PATA_NS87410
-	tristate "Nat Semi NS87410 PATA support (Experimental)"
-	depends on PCI && EXPERIMENTAL
+	tristate "Nat Semi NS87410 PATA support"
+	depends on PCI
 	help
 	  This option enables support for the National Semiconductor
 	  NS87410 PCI-IDE controller.
@@ -507,8 +507,8 @@ config PATA_NS87410
 	  If unsure, say N.
 
 config PATA_NS87415
-	tristate "Nat Semi NS87415 PATA support (Experimental)"
-	depends on PCI && EXPERIMENTAL
+	tristate "Nat Semi NS87415 PATA support"
+	depends on PCI
 	help
 	  This option enables support for the National Semiconductor
 	  NS87415 PCI-IDE controller.
@@ -544,8 +544,8 @@ config PATA_PCMCIA
 	  If unsure, say N.
 
 config PATA_PDC_OLD
-	tristate "Older Promise PATA controller support (Experimental)"
-	depends on PCI && EXPERIMENTAL
+	tristate "Older Promise PATA controller support"
+	depends on PCI
 	help
 	  This option enables support for the Promise 20246, 20262, 20263,
 	  20265 and 20267 adapters.
@@ -559,7 +559,7 @@ config PATA_QDI
 	  Support for QDI 6500 and 6580 PATA controllers on VESA local bus.
 
 config PATA_RADISYS
-	tristate "RADISYS 82600 PATA support (Very Experimental)"
+	tristate "RADISYS 82600 PATA support (Experimental)"
 	depends on PCI && EXPERIMENTAL
 	help
 	  This option enables support for the RADISYS 82600
@@ -586,8 +586,8 @@ config PATA_RZ1000
 	  If unsure, say N.
 
 config PATA_SC1200
-	tristate "SC1200 PATA support (Very Experimental)"
-	depends on PCI && EXPERIMENTAL
+	tristate "SC1200 PATA support"
+	depends on PCI
 	help
 	  This option enables support for the NatSemi/AMD SC1200 SoC
 	  companion chip used with the Geode processor family.
@@ -620,8 +620,8 @@ config PATA_SIL680
 	  If unsure, say N.
 
 config PATA_SIS
-	tristate "SiS PATA support (Experimental)"
-	depends on PCI && EXPERIMENTAL
+	tristate "SiS PATA support"
+	depends on PCI
 	help
 	  This option enables support for SiS PATA controllers
 

