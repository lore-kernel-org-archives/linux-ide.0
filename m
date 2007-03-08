From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] libata: Restore Kconfig updated experimental levels and
 correct
Date: Thu, 8 Mar 2007 23:24:49 +0000
Message-ID: <20070308232449.5ce1a43b@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:47071 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1030807AbXCHWVD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 8 Mar 2007 17:21:03 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@osdl.org, linux-ide@vger.kernel.org

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.21-rc3-mm2/drivers/ata/Kconfig linux-2.6.21-rc3-mm2/drivers/ata/Kconfig
--- linux.vanilla-2.6.21-rc3-mm2/drivers/ata/Kconfig	2007-03-08 16:01:10.000000000 +0000
+++ linux-2.6.21-rc3-mm2/drivers/ata/Kconfig	2007-03-08 16:41:36.000000000 +0000
@@ -184,7 +193,7 @@
 	  If unsure, say N.
 
 config PATA_AMD
-	tristate "AMD/NVidia PATA support (Experimental)"
+	tristate "AMD/NVidia PATA support"
 	depends on PCI
 	help
 	  This option enables support for the AMD and NVidia PATA
@@ -283,7 +292,7 @@
 	  If unsure, say N.
 
 config PATA_HPT366
-	tristate "HPT 366/368 PATA support (Very Experimental)"
+	tristate "HPT 366/368 PATA support (Experimental)"
 	depends on PCI && EXPERIMENTAL
 	help
 	  This option enables support for the HPT 366 and 368
@@ -292,7 +301,7 @@
 	  If unsure, say N.
 
 config PATA_HPT37X
-	tristate "HPT 370/370A/371/372/374/302 PATA support (Very Experimental)"
+	tristate "HPT 370/370A/371/372/374/302 PATA support (Experimental)"
 	depends on PCI && EXPERIMENTAL
 	help
 	  This option enables support for the majority of the later HPT
@@ -319,7 +328,7 @@
 	  If unsure, say N.
 
 config PATA_ISAPNP
-	tristate "ISA Plug and Play PATA support (Very Experimental)"
+	tristate "ISA Plug and Play PATA support (Experimental)"
 	depends on EXPERIMENTAL && ISAPNP
 	help
 	  This option enables support for ISA plug & play ATA
@@ -328,8 +337,8 @@
 	  If unsure, say N.
 
 config PATA_IT821X
-	tristate "IT8211/2 PATA support (Experimental)"
-	depends on PCI && EXPERIMENTAL
+	tristate "IT8211/2 PATA support"
+	depends on PCI
 	help
 	  This option enables support for the ITE 8211 and 8212
 	  PATA controllers via the new ATA layer, including RAID
@@ -400,10 +409,10 @@
 	  If unsure, say N.
 
 config PATA_OLDPIIX
-	tristate "Intel PATA old PIIX support (Experimental)"
-	depends on PCI && EXPERIMENTAL
+	tristate "Intel PATA old PIIX support"
+	depends on PCI
 	help
-	  This option enables support for old(?) PIIX PATA support.
+	  This option enables support for early PIIX PATA support.
 
 	  If unsure, say N.
 
@@ -454,7 +463,7 @@
 	  If unsure, say N.
 
 config PATA_PDC_OLD
-	tristate "Older Promise PATA controller support (Very Experimental)"
+	tristate "Older Promise PATA controller support (Experimental)"
 	depends on PCI && EXPERIMENTAL
 	help
 	  This option enables support for the Promise 20246, 20262, 20263,
@@ -469,7 +478,7 @@
 	  Support for QDI 6500 and 6580 PATA controllers on VESA local bus.
 
 config PATA_RADISYS
-	tristate "RADISYS 82600 PATA support (Very experimental)"
+	tristate "RADISYS 82600 PATA support (Very Experimental)"
 	depends on PCI && EXPERIMENTAL
 	help
 	  This option enables support for the RADISYS 82600
@@ -487,7 +496,7 @@
 	  If unsure, say N.
 
 config PATA_SC1200
-	tristate "SC1200 PATA support (Raving Lunatic)"
+	tristate "SC1200 PATA support (Very Experimental)"
 	depends on PCI && EXPERIMENTAL
 	help
 	  This option enables support for the NatSemi/AMD SC1200 SoC
@@ -496,7 +505,7 @@
 	  If unsure, say N.
 
 config PATA_SERVERWORKS
-	tristate "SERVERWORKS OSB4/CSB5/CSB6/HT1000 PATA support (Experimental)"
+	tristate "SERVERWORKS OSB4/CSB5/CSB6/HT1000 PATA support"
 	depends on PCI
 	help
 	  This option enables support for the Serverworks OSB4/CSB5/CSB6 and
@@ -572,15 +581,6 @@
 
 	  If unsure, say N.
 
-config PATA_SCC
-	tristate "Toshiba's Cell Reference Set IDE support"
-	depends on PCI && PPC_IBM_CELL_BLADE
-	help
-	  This option enables support for the built-in IDE controller on
-	  Toshiba Cell Reference Board.
-
-	  If unsure, say N.
-
 endif
 endmenu
 
