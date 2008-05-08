From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 5/5] ide/Kconfig: couple of fixes
Date: Thu, 8 May 2008 23:05:55 +0200
Message-ID: <200805082305.55498.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.189]:61695 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761000AbYEHUu2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 8 May 2008 16:50:28 -0400
Received: by mu-out-0910.google.com with SMTP id w8so741973mue.1
        for <linux-ide@vger.kernel.org>; Thu, 08 May 2008 13:50:24 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

* Don't ask to enable no longer existing config options
  ("Use DMA by default when available" and "Special UDMA Feature").

* PIIX host driver doesn't support Victory66 chipset.

* "ide0=cmd640_vlb" -> "cmd640.probe_vlb"

* "ide=doubler" -> "gayle.doubler"

* Amiga IDE doubler support is a feature for gayle host driver
  not a separate host driver.

* Remove Andre's mail.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/Kconfig |   39 +++++++++++----------------------------
 1 file changed, 11 insertions(+), 28 deletions(-)

Index: b/drivers/ide/Kconfig
===================================================================
--- a/drivers/ide/Kconfig
+++ b/drivers/ide/Kconfig
@@ -1,8 +1,6 @@
 #
 # IDE ATA ATAPI Block device driver configuration
 #
-# Andre Hedrick <andre@linux-ide.org>
-#
 
 # Select HAVE_IDE if IDE is supported
 config HAVE_IDE
@@ -335,7 +333,7 @@ config BLK_DEV_CMD640
 	  This driver will work automatically in PCI based systems (most new
 	  systems have PCI slots). But if your system uses VESA local bus
 	  (VLB) instead of PCI, you must also supply a kernel boot parameter
-	  to enable the CMD640 bugfix/support: "ide0=cmd640_vlb". (Try "man
+	  to enable the CMD640 bugfix/support: "cmd640.probe_vlb". (Try "man
 	  bootparam" or see the documentation of your boot loader about how to
 	  pass options to the kernel.)
 
@@ -457,8 +455,7 @@ config BLK_DEV_ALI15X3
 	  onboard chipsets.  It also tests for Simplex mode and enables
 	  normal dual channel support.
 
-	  If you say Y here, you also need to say Y to "Use DMA by default
-	  when available", above.  Please read the comments at the top of
+	  Please read the comments at the top of
 	  <file:drivers/ide/pci/alim15x3.c>.
 
 	  If unsure, say N.
@@ -505,9 +502,6 @@ config BLK_DEV_CY82C693
 	  This driver adds detection and support for the CY82C693 chipset
 	  used on Digital's PC-Alpha 164SX boards.
 
-	  If you say Y here, you need to say Y to "Use DMA by default
-	  when available" as well.
-
 config BLK_DEV_CS5520
 	tristate "Cyrix CS5510/20 MediaGX chipset support (VERY EXPERIMENTAL)"
 	depends on EXPERIMENTAL
@@ -598,13 +592,12 @@ config BLK_DEV_SC1200
 	  National SCx200 series of embedded x86 "Geode" systems.
 
 config BLK_DEV_PIIX
-	tristate "Intel PIIXn chipsets support"
+	tristate "Intel PIIX/ICH chipsets support"
 	select BLK_DEV_IDEDMA_PCI
 	help
-	  This driver adds explicit support for Intel PIIX and ICH chips
-	  and also for the Efar Victory66 (slc90e66) chip.  This allows
-	  the kernel to change PIO, DMA and UDMA speeds and to configure
-	  the chip to optimum performance.
+	  This driver adds explicit support for Intel PIIX and ICH chips.
+	  This allows the kernel to change PIO, DMA and UDMA speeds and to
+	  configure the chip to optimum performance.
 
 config BLK_DEV_IT8213
 	tristate "IT8213 IDE support"
@@ -642,11 +635,7 @@ config BLK_DEV_PDC202XX_OLD
 	  happen if the BIOS revisions of all installed cards (three-max) do
 	  not match, the driver attempts to do dynamic tuning of the chipset
 	  at boot-time for max-speed.  Ultra33 BIOS 1.25 or newer is required
-	  for more than one card. This card may require that you say Y to
-	  "Special UDMA Feature".
-
-	  If you say Y here, you need to say Y to "Use DMA by default when
-	  available" as well.
+	  for more than one card.
 
 	  Please read the comments at the top of
 	  <file:drivers/ide/pci/pdc202xx_old.c>.
@@ -695,9 +684,6 @@ config BLK_DEV_SIS5513
 	  ATA100: SiS635, SiS645, SiS650, SiS730, SiS735, SiS740,
 	  SiS745, SiS750
 
-	  If you say Y here, you need to say Y to "Use DMA by default when
-	  available" as well.
-
 	  Please read the comments at the top of <file:drivers/ide/pci/sis5513.c>.
 
 config BLK_DEV_SL82C105
@@ -719,9 +705,6 @@ config BLK_DEV_SLC90E66
 	  and it will handle timing cycles.  Since this is an improved
 	  look-a-like to the PIIX4 it should be a nice addition.
 
-	  If you say Y here, you need to say Y to "Use DMA by default when
-	  available" as well.
-
 	  Please read the comments at the top of
 	  <file:drivers/ide/pci/slc90e66.c>.
 
@@ -873,17 +856,17 @@ config BLK_DEV_IDEDOUBLER
 	bool "Amiga IDE Doubler support (EXPERIMENTAL)"
 	depends on BLK_DEV_GAYLE && EXPERIMENTAL
 	---help---
-	  This driver provides support for the so-called `IDE doublers' (made
+	  This feature provides support for the so-called `IDE doublers' (made
 	  by various manufacturers, e.g. Eyetech) that can be connected to
 	  the on-board IDE interface of some Amiga models. Using such an IDE
 	  doubler, you can connect up to four instead of two IDE devices to
 	  the Amiga's on-board IDE interface.
 
 	  Note that the normal Amiga Gayle IDE driver may not work correctly
-	  if you have an IDE doubler and don't enable this driver!
+	  if you have an IDE doubler and don't enable this feature!
 
-	  Say Y if you have an IDE doubler.  The driver is enabled at kernel
-	  runtime using the "ide=doubler" kernel boot parameter.
+	  Say Y if you have an IDE doubler.  The feature is enabled at kernel
+	  runtime using the "gayle.doubler" kernel boot parameter.
 
 config BLK_DEV_BUDDHA
 	tristate "Buddha/Catweasel/X-Surf IDE interface support (EXPERIMENTAL)"
