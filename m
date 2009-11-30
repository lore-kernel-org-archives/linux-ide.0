From: Alan Cox <alan@linux.intel.com>
Subject: [PATCH 4/6] pata: Update experimental tags
Date: Mon, 30 Nov 2009 13:23:00 +0000
Message-ID: <20091130132259.27236.76479.stgit@localhost.localdomain>
References: <20091130132005.27236.77890.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:50842 "EHLO
	bob.linux.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752815AbZK3Nmd (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 30 Nov 2009 08:42:33 -0500
In-Reply-To: <20091130132005.27236.77890.stgit@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, jeff@garzik.org, davem@davemloft.net

Signed-off-by: Alan Cox <alan@linux.intel.com>
---

 drivers/ata/Kconfig |   30 +++++++++++++++---------------
 1 files changed, 15 insertions(+), 15 deletions(-)


diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index 33133c6..a47ca75 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -374,8 +374,8 @@ config PATA_HPT366
 	  If unsure, say N.
 
 config PATA_HPT37X
-	tristate "HPT 370/370A/371/372/374/302 PATA support (Experimental)"
-	depends on PCI && EXPERIMENTAL
+	tristate "HPT 370/370A/371/372/374/302 PATA support"
+	depends on PCI
 	help
 	  This option enables support for the majority of the later HPT
 	  PATA controllers via the new ATA layer.
@@ -383,8 +383,8 @@ config PATA_HPT37X
 	  If unsure, say N.
 
 config PATA_HPT3X2N
-	tristate "HPT 372N/302N PATA support (Experimental)"
-	depends on PCI && EXPERIMENTAL
+	tristate "HPT 372N/302N PATA support"
+	depends on PCI
 	help
 	  This option enables support for the N variant HPT PATA
 	  controllers via the new ATA layer
@@ -401,7 +401,7 @@ config PATA_HPT3X3
 	  If unsure, say N.
 
 config PATA_HPT3X3_DMA
-	bool "HPT 343/363 DMA support (Experimental)"
+	bool "HPT 343/363 DMA support"
 	depends on PATA_HPT3X3
 	help
 	  This option enables DMA support for the HPT343/363
@@ -510,8 +510,8 @@ config PATA_NETCELL
 	  If unsure, say N.
 
 config PATA_NINJA32
-	tristate "Ninja32/Delkin Cardbus ATA support (Experimental)"
-	depends on PCI && EXPERIMENTAL
+	tristate "Ninja32/Delkin Cardbus ATA support"
+	depends on PCI
 	help
 	  This option enables support for the Ninja32, Delkin and
 	  possibly other brands of Cardbus ATA adapter
@@ -573,6 +573,14 @@ config PATA_PCMCIA
 
 	  If unsure, say N.
 
+config PATA_PDC2027X
+	tristate "Promise PATA 2027x support"
+	depends on PCI
+	help
+	  This option enables support for Promise PATA pdc20268 to pdc20277 host adapters.
+
+	  If unsure, say N.
+
 config PATA_PDC_OLD
 	tristate "Older Promise PATA controller support"
 	depends on PCI
@@ -643,14 +651,6 @@ config PATA_SERVERWORKS
 
 	  If unsure, say N.
 
-config PATA_PDC2027X
-	tristate "Promise PATA 2027x support"
-	depends on PCI
-	help
-	  This option enables support for Promise PATA pdc20268 to pdc20277 host adapters.
-
-	  If unsure, say N.
-
 config PATA_SIL680
 	tristate "CMD / Silicon Image 680 PATA support"
 	depends on PCI

