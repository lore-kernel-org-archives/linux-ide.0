From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] ata: Fix experimental tags
Date: Tue, 21 Oct 2008 13:45:38 +0100
Message-ID: <20081021124529.31706.54794.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:56796 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753393AbYJUMph (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 21 Oct 2008 08:45:37 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org

From: Alan Cox <alan@redhat.com>

Various tags are now way out of date

Signed-off-by: Alan Cox <alan@redhat.com>

---

 drivers/ata/Kconfig |   32 ++++++++++++++++----------------
 1 files changed, 16 insertions(+), 16 deletions(-)


diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index 78fbec8..4095a2c 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
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
@@ -389,7 +389,7 @@ config PATA_HPT3X3_DMA
 	  problems with DMA on this chipset.
 
 config PATA_ISAPNP
-	tristate "ISA Plug and Play PATA support (Experimental)"
+	tristate "ISA Plug and Play PATA support"
 	depends on EXPERIMENTAL && ISAPNP
 	help
 	  This option enables support for ISA plug & play ATA
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
@@ -507,7 +507,7 @@ config PATA_NS87410
 	  If unsure, say N.
 
 config PATA_NS87415
-	tristate "Nat Semi NS87415 PATA support (Experimental)"
+	tristate "Nat Semi NS87415 PATA support"
 	depends on PCI && EXPERIMENTAL
 	help
 	  This option enables support for the National Semiconductor
@@ -544,7 +544,7 @@ config PATA_PCMCIA
 	  If unsure, say N.
 
 config PATA_PDC_OLD
-	tristate "Older Promise PATA controller support (Experimental)"
+	tristate "Older Promise PATA controller support"
 	depends on PCI && EXPERIMENTAL
 	help
 	  This option enables support for the Promise 20246, 20262, 20263,
@@ -559,7 +559,7 @@ config PATA_QDI
 	  Support for QDI 6500 and 6580 PATA controllers on VESA local bus.
 
 config PATA_RADISYS
-	tristate "RADISYS 82600 PATA support (Very Experimental)"
+	tristate "RADISYS 82600 PATA support (Experimental)"
 	depends on PCI && EXPERIMENTAL
 	help
 	  This option enables support for the RADISYS 82600
@@ -586,7 +586,7 @@ config PATA_RZ1000
 	  If unsure, say N.
 
 config PATA_SC1200
-	tristate "SC1200 PATA support (Very Experimental)"
+	tristate "SC1200 PATA support"
 	depends on PCI && EXPERIMENTAL
 	help
 	  This option enables support for the NatSemi/AMD SC1200 SoC
@@ -620,7 +620,7 @@ config PATA_SIL680
 	  If unsure, say N.
 
 config PATA_SIS
-	tristate "SiS PATA support (Experimental)"
+	tristate "SiS PATA support"
 	depends on PCI && EXPERIMENTAL
 	help
 	  This option enables support for SiS PATA controllers

