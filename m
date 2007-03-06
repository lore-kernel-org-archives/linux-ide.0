From: akpm@linux-foundation.org
Subject: [patch 28/30] libata Kconfig: Update the various experimentality levels
Date: Tue, 06 Mar 2007 02:38:12 -0800
Message-ID: <200703061038.l26AcCtO019550@shell0.pdx.osdl.net>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.24]:34502 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934061AbXCFKii (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 6 Mar 2007 05:38:38 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org
Cc: linux-ide@vger.kernel.org, akpm@linux-foundation.org, alan@lxorguk.ukuu.org.uk, alan@redhat.com

From: Alan Cox <alan@lxorguk.ukuu.org.uk>

Signed-off-by: Alan Cox <alan@redhat.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/ata/Kconfig |   24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff -puN drivers/ata/Kconfig~libata-kconfig-update-the-various-experimentality-levels drivers/ata/Kconfig
--- a/drivers/ata/Kconfig~libata-kconfig-update-the-various-experimentality-levels
+++ a/drivers/ata/Kconfig
@@ -193,7 +193,7 @@ config PATA_ALI
 	  If unsure, say N.
 
 config PATA_AMD
-	tristate "AMD/NVidia PATA support (Experimental)"
+	tristate "AMD/NVidia PATA support"
 	depends on PCI
 	help
 	  This option enables support for the AMD and NVidia PATA
@@ -292,7 +292,7 @@ config ATA_GENERIC
 	  If unsure, say N.
 
 config PATA_HPT366
-	tristate "HPT 366/368 PATA support (Very Experimental)"
+	tristate "HPT 366/368 PATA support (Experimental)"
 	depends on PCI && EXPERIMENTAL
 	help
 	  This option enables support for the HPT 366 and 368
@@ -301,7 +301,7 @@ config PATA_HPT366
 	  If unsure, say N.
 
 config PATA_HPT37X
-	tristate "HPT 370/370A/371/372/374/302 PATA support (Very Experimental)"
+	tristate "HPT 370/370A/371/372/374/302 PATA support (Experimental)"
 	depends on PCI && EXPERIMENTAL
 	help
 	  This option enables support for the majority of the later HPT
@@ -328,7 +328,7 @@ config PATA_HPT3X3
 	  If unsure, say N.
 
 config PATA_ISAPNP
-	tristate "ISA Plug and Play PATA support (Very Experimental)"
+	tristate "ISA Plug and Play PATA support (Experimental)"
 	depends on EXPERIMENTAL && ISAPNP
 	help
 	  This option enables support for ISA plug & play ATA
@@ -337,8 +337,8 @@ config PATA_ISAPNP
 	  If unsure, say N.
 
 config PATA_IT821X
-	tristate "IT8211/2 PATA support (Experimental)"
-	depends on PCI && EXPERIMENTAL
+	tristate "IT8211/2 PATA support"
+	depends on PCI
 	help
 	  This option enables support for the ITE 8211 and 8212
 	  PATA controllers via the new ATA layer, including RAID
@@ -409,10 +409,10 @@ config PATA_MPIIX
 	  If unsure, say N.
 
 config PATA_OLDPIIX
-	tristate "Intel PATA old PIIX support (Experimental)"
+	tristate "Intel PATA support for the original PIIX"
 	depends on PCI && EXPERIMENTAL
 	help
-	  This option enables support for old(?) PIIX PATA support.
+	  This option enables support for early Intel PIIX PATA support.
 
 	  If unsure, say N.
 
@@ -463,7 +463,7 @@ config PATA_PCMCIA
 	  If unsure, say N.
 
 config PATA_PDC_OLD
-	tristate "Older Promise PATA controller support (Very Experimental)"
+	tristate "Older Promise PATA controller support (Experimental)"
 	depends on PCI && EXPERIMENTAL
 	help
 	  This option enables support for the Promise 20246, 20262, 20263,
@@ -496,7 +496,7 @@ config PATA_RZ1000
 	  If unsure, say N.
 
 config PATA_SC1200
-	tristate "SC1200 PATA support (Raving Lunatic)"
+	tristate "SC1200 PATA support (Very Experimental)"
 	depends on PCI && EXPERIMENTAL
 	help
 	  This option enables support for the NatSemi/AMD SC1200 SoC
@@ -505,8 +505,8 @@ config PATA_SC1200
 	  If unsure, say N.
 
 config PATA_SERVERWORKS
-	tristate "SERVERWORKS OSB4/CSB5/CSB6/HT1000 PATA support (Experimental)"
-	depends on PCI && EXPERIMENTAL
+	tristate "SERVERWORKS OSB4/CSB5/CSB6/HT1000 PATA support"
+	depends on PCI
 	help
 	  This option enables support for the Serverworks OSB4/CSB5/CSB6 and
 	  HT1000 PATA controllers, via the new ATA layer.
_
