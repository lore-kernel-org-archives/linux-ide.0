From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] libata Kconfig: Update the various experimentality levels
Date: Fri, 2 Mar 2007 15:05:12 +0000
Message-ID: <20070302150512.281af8d3@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:49164 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S2992445AbXCBOBQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 2 Mar 2007 09:01:16 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, akpm@osdl.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.21-rc2/drivers/ata/Kconfig linux-2.6.21-rc2/drivers/ata/Kconfig
--- linux.vanilla-2.6.21-rc2/drivers/ata/Kconfig	2007-03-01 13:36:03.000000000 +0000
+++ linux-2.6.21-rc2/drivers/ata/Kconfig	2007-03-02 13:30:50.535164824 +0000
@@ -184,7 +184,7 @@
 	  If unsure, say N.
 
 config PATA_AMD
-	tristate "AMD/NVidia PATA support (Experimental)"
+	tristate "AMD/NVidia PATA support"
 	depends on PCI
 	help
 	  This option enables support for the AMD and NVidia PATA
@@ -273,7 +283,7 @@
 	  If unsure, say N.
 
 config PATA_HPT366
-	tristate "HPT 366/368 PATA support (Very Experimental)"
+	tristate "HPT 366/368 PATA support (Experimental)"
 	depends on PCI && EXPERIMENTAL
 	help
 	  This option enables support for the HPT 366 and 368
@@ -282,7 +292,7 @@
 	  If unsure, say N.
 
 config PATA_HPT37X
-	tristate "HPT 370/370A/371/372/374/302 PATA support (Very Experimental)"
+	tristate "HPT 370/370A/371/372/374/302 PATA support (Experimental)"
 	depends on PCI && EXPERIMENTAL
 	help
 	  This option enables support for the majority of the later HPT
@@ -309,7 +319,7 @@
 	  If unsure, say N.
 
 config PATA_ISAPNP
-	tristate "ISA Plug and Play PATA support (Very Experimental)"
+	tristate "ISA Plug and Play PATA support (Experimental)"
 	depends on EXPERIMENTAL && ISAPNP
 	help
 	  This option enables support for ISA plug & play ATA
@@ -318,8 +328,8 @@
 	  If unsure, say N.
 
 config PATA_IT821X
-	tristate "IT8211/2 PATA support (Experimental)"
-	depends on PCI && EXPERIMENTAL
+	tristate "IT8211/2 PATA support"
+	depends on PCI
 	help
 	  This option enables support for the ITE 8211 and 8212
 	  PATA controllers via the new ATA layer, including RAID
@@ -390,10 +400,10 @@
 	  If unsure, say N.
 
 config PATA_OLDPIIX
-	tristate "Intel PATA old PIIX support (Experimental)"
+	tristate "Intel PATA support for the original PIIX"
 	depends on PCI && EXPERIMENTAL
 	help
-	  This option enables support for old(?) PIIX PATA support.
+	  This option enables support for early Intel PIIX PATA support.
 
 	  If unsure, say N.
 
@@ -444,7 +454,7 @@
 	  If unsure, say N.
 
 config PATA_PDC_OLD
-	tristate "Older Promise PATA controller support (Very Experimental)"
+	tristate "Older Promise PATA controller support (Experimental)"
 	depends on PCI && EXPERIMENTAL
 	help
 	  This option enables support for the Promise 20246, 20262, 20263,
@@ -477,7 +487,7 @@
 	  If unsure, say N.
 
 config PATA_SC1200
-	tristate "SC1200 PATA support (Raving Lunatic)"
+	tristate "SC1200 PATA support (Very Experimental)"
 	depends on PCI && EXPERIMENTAL
 	help
 	  This option enables support for the NatSemi/AMD SC1200 SoC
@@ -486,8 +496,8 @@
 	  If unsure, say N.
 
 config PATA_SERVERWORKS
-	tristate "SERVERWORKS OSB4/CSB5/CSB6/HT1000 PATA support (Experimental)"
-	depends on PCI && EXPERIMENTAL
+	tristate "SERVERWORKS OSB4/CSB5/CSB6/HT1000 PATA support"
+	depends on PCI
 	help
 	  This option enables support for the Serverworks OSB4/CSB5/CSB6 and
 	  HT1000 PATA controllers, via the new ATA layer.
