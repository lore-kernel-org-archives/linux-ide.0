From: Matthew Wilcox <matthew@wil.cx>
Subject: [PATCH] Some IDE chipsets are architecture-specific
Date: Mon, 7 Mar 2005 15:28:03 +0000
Message-ID: <20050307152803.GF28741@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:55524 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261297AbVCGP2E (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 7 Mar 2005 10:28:04 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: linux-ide@vger.kernel.org


Mark some chipset support as being for specific architectures.
I may have got some wrong, so please double-check.

Signed-off-by: Matthew Wilcox <matthew@wil.cx>

Index: ./drivers/ide/Kconfig
===================================================================
RCS file: /var/cvs/linux-2.6/drivers/ide/Kconfig,v
retrieving revision 1.25.2.1
diff -u -p -r1.25.2.1 Kconfig
--- ./drivers/ide/Kconfig	2 Mar 2005 11:19:06 -0000	1.25.2.1
+++ ./drivers/ide/Kconfig	7 Mar 2005 04:49:26 -0000
@@ -457,6 +457,7 @@ config BLK_DEV_AEC62XX
 
 config BLK_DEV_ALI15X3
 	tristate "ALI M15x3 chipset support"
+	depends on X86
 	help
 	  This driver ensures (U)DMA support for ALI 1533, 1543 and 1543C
 	  onboard chipsets.  It also tests for Simplex mode and enables
@@ -485,6 +486,7 @@ config WDC_ALI15X3
 
 config BLK_DEV_AMD74XX
 	tristate "AMD and nVidia IDE support"
+	depends on X86 || PPC
 	help
 	  This driver adds explicit support for AMD-7xx and AMD-8111 chips
 	  and also for the nVidia nForce chip.  This allows the kernel to
@@ -509,12 +511,14 @@ config BLK_DEV_CMD64X
 
 config BLK_DEV_TRIFLEX
 	tristate "Compaq Triflex IDE support"
+	depends on X86
 	help
 	  Say Y here if you have a Compaq Triflex IDE controller, such
 	  as those commonly found on Compaq Pentium-Pro systems
 
 config BLK_DEV_CY82C693
 	tristate "CY82C693 chipset support"
+	depends on ALPHA
 	help
 	  This driver adds detection and support for the CY82C693 chipset
 	  used on Digital's PC-Alpha 164SX boards.
@@ -524,7 +528,7 @@ config BLK_DEV_CY82C693
 
 config BLK_DEV_CS5520
 	tristate "Cyrix CS5510/20 MediaGX chipset support (VERY EXPERIMENTAL)"
-	depends on EXPERIMENTAL
+	depends on X86 && EXPERIMENTAL
 	help
 	  Include support for PIO tuning an virtual DMA on the Cyrix MediaGX 
 	  5510/5520 chipset. This will automatically be detected and
@@ -534,6 +538,7 @@ config BLK_DEV_CS5520
 
 config BLK_DEV_CS5530
 	tristate "Cyrix/National Semiconductor CS5530 MediaGX chipset support"
+	depends on X86
 	help
 	  Include support for UDMA on the Cyrix MediaGX 5530 chipset. This
 	  will automatically be detected and configured if found.
@@ -586,12 +591,14 @@ config BLK_DEV_HPT366
 
 config BLK_DEV_SC1200
 	tristate "National SCx200 chipset support"
+	depends on X86
 	help
 	  This driver adds support for the built in IDE on the National
 	  SCx200 series of embedded x86 "Geode" systems
 
 config BLK_DEV_PIIX
 	tristate "Intel PIIXn chipsets support"
+	depends on X86 || IA64
 	help
 	  This driver adds explicit support for Intel PIIX and ICH chips
 	  and also for the Efar Victory66 (slc90e66) chip.  This allows
@@ -611,7 +618,7 @@ config BLK_DEV_NS87415
 	tristate "NS87415 chipset support"
 	help
 	  This driver adds detection and support for the NS87415 chip
-	  (used in SPARC64, among others).
+	  (used mainly in SPARC64 and PA-RISC machines).
 
 	  Please read the comments at the top of <file:drivers/ide/pci/ns87415.c>.
 
@@ -668,6 +675,7 @@ config PDC202XX_FORCE
 
 config BLK_DEV_SVWKS
 	tristate "ServerWorks OSB4/CSB5/CSB6 chipsets support"
+	depends on X86
 	help
 	  This driver adds PIO/(U)DMA support for the ServerWorks OSB4/CSB5
 	  chipsets.
@@ -707,6 +715,7 @@ config BLK_DEV_SIS5513
 
 config BLK_DEV_SLC90E66
 	tristate "SLC90E66 chipset support"
+	depends on X86
 	help
 	  This driver ensures (U)DMA support for Victroy66 SouthBridges for
 	  SMsC with Intel NorthBridges.  This is an Ultra66 based chipset.
@@ -961,6 +970,7 @@ config BLK_DEV_4DRIVES
 
 config BLK_DEV_ALI14XX
 	tristate "ALI M14xx support"
+	depends on X86
 	help
 	  This driver is enabled at runtime using the "ide0=ali14xx" kernel
 	  boot parameter.  It enables support for the secondary IDE interface

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
