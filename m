From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 11/12] ide: Kconfig face-lift
Date: Sun, 8 Jul 2007 15:40:25 +0200
Message-ID: <200707081540.25581.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.174]:47402 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756057AbXGHOAU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 8 Jul 2007 10:00:20 -0400
Received: by ug-out-1314.google.com with SMTP id j3so991056ugf
        for <linux-ide@vger.kernel.org>; Sun, 08 Jul 2007 07:00:19 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


* Convert config options for PCI host drivers to select BLK_DEV_IDEPCI.

* Same for BLK_DEV_IDEDMA_PCI and PCI DMA host drivers, also make this
  config option select BLK_DEV_IDEPCI.

* Remove no longer needed help for BLK_DEV_IDEPCI and BLK_DEV_IDEDMA_PCI.

* Remove redundant IDE_CHIPSETS config option.

As a result of this patch users have now three less config options
to worry about and can just select host drivers that they need
(IDE config menu is "flatter").

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/Kconfig |  102 ++++++++++++++++++++++++++--------------------------
 1 file changed, 52 insertions(+), 50 deletions(-)

Index: b/drivers/ide/Kconfig
===================================================================
--- a/drivers/ide/Kconfig
+++ b/drivers/ide/Kconfig
@@ -350,17 +350,16 @@ config BLK_DEV_IDEPNP
 	  would like the kernel to automatically detect and activate
 	  it, say Y here.
 
+if PCI
+
+comment "PCI IDE chipsets support"
+
 config BLK_DEV_IDEPCI
-	bool "PCI IDE chipset support" if PCI
-	default BLK_DEV_IDEDMA_PMAC if PPC_PMAC && BLK_DEV_IDEDMA_PMAC
-	help
-	  Say Y here for PCI systems which use IDE drive(s).
-	  This option helps the IDE driver to automatically detect and
-	  configure all PCI-based IDE interfaces in your system.
+	bool
 
 config IDEPCI_SHARE_IRQ
 	bool "Sharing PCI IDE interrupts support"
-	depends on PCI && BLK_DEV_IDEPCI
+	depends on BLK_DEV_IDEPCI
 	help
 	  Some ATA/IDE chipsets have hardware support which allows for
 	  sharing a single IRQ with other cards. To enable support for
@@ -370,11 +369,11 @@ config IDEPCI_SHARE_IRQ
 	  If unsure, say N.
 
 config IDEPCI_PCIBUS_ORDER
-	def_bool PCI && BLK_DEV_IDE=y && BLK_DEV_IDEPCI
+	def_bool BLK_DEV_IDE=y && BLK_DEV_IDEPCI
 
 config BLK_DEV_OFFBOARD
 	bool "Boot off-board chipsets first support"
-	depends on PCI && BLK_DEV_IDEPCI
+	depends on BLK_DEV_IDEPCI
 	help
 	  Normally, IDE controllers built into the motherboard (on-board
 	  controllers) are assigned to ide0 and ide1 while those on add-in PCI
@@ -397,21 +396,23 @@ config BLK_DEV_OFFBOARD
 
 config BLK_DEV_GENERIC
 	tristate "Generic PCI IDE Chipset Support"
-	depends on BLK_DEV_IDEPCI
+	select BLK_DEV_IDEPCI
         help
           This option provides generic support for various PCI IDE Chipsets
           which otherwise might not be supported.
 
 config BLK_DEV_OPTI621
 	tristate "OPTi 82C621 chipset enhanced support (EXPERIMENTAL)"
-	depends on PCI && BLK_DEV_IDEPCI && EXPERIMENTAL
+	depends on EXPERIMENTAL
+	select BLK_DEV_IDEPCI
 	help
 	  This is a driver for the OPTi 82C621 EIDE controller.
 	  Please read the comments at the top of <file:drivers/ide/pci/opti621.c>.
 
 config BLK_DEV_RZ1000
 	tristate "RZ1000 chipset bugfix/support"
-	depends on PCI && BLK_DEV_IDEPCI && X86
+	depends on X86
+	select BLK_DEV_IDEPCI
 	help
 	  The PC-Technologies RZ1000 IDE chip is used on many common 486 and
 	  Pentium motherboards, usually along with the "Neptune" chipset.
@@ -422,35 +423,21 @@ config BLK_DEV_RZ1000
 	  things will operate 100% reliably.
 
 config BLK_DEV_IDEDMA_PCI
-	bool "Generic PCI bus-master DMA support"
-	depends on PCI && BLK_DEV_IDEPCI
-	---help---
-	  If your PCI system uses IDE drive(s) (as opposed to SCSI, say) and
-	  is capable of bus-master DMA operation (most Pentium PCI systems),
-	  you will want to say Y here to reduce CPU overhead. You can then use
-	  the "hdparm" utility to enable DMA for drives for which it was not
-	  enabled automatically. By default, DMA is not enabled automatically
-	  for these drives, but you can change that by saying Y to the
-	  following question "Use DMA by default when available". You can get
-	  the latest version of the hdparm utility from
-	  <ftp://ibiblio.org/pub/Linux/system/hardware/>.
-
-	  Read the comments at the beginning of <file:drivers/ide/ide-dma.c>
-	  and the file <file:Documentation/ide.txt> for more information.
-
-	  It is safe to say Y to this question.
-
-if BLK_DEV_IDEDMA_PCI
+	bool
+	select BLK_DEV_IDEPCI
 
 config BLK_DEV_IDEDMA_FORCED
 	bool "Force enable legacy 2.0.X HOSTS to use DMA"
+	depends on BLK_DEV_IDEDMA_PCI
 	help
 	  This is an old piece of lost code from Linux 2.0 Kernels.
 
 	  Generally say N here.
 
+# TODO: remove it
 config IDEDMA_ONLYDISK
 	bool "Enable DMA only for disks "
+	depends on BLK_DEV_IDEDMA_PCI
 	help
 	  This is used if you know your ATAPI Devices are going to fail DMA
 	  Transfers.
@@ -459,6 +446,7 @@ config IDEDMA_ONLYDISK
 
 config BLK_DEV_AEC62XX
 	tristate "AEC62XX chipset support"
+	select BLK_DEV_IDEDMA_PCI
 	help
 	  This driver adds explicit support for Acard AEC62xx (Artop ATP8xx)
 	  IDE controllers. This allows the kernel to change PIO, DMA and UDMA
@@ -466,6 +454,7 @@ config BLK_DEV_AEC62XX
 
 config BLK_DEV_ALI15X3
 	tristate "ALI M15x3 chipset support"
+	select BLK_DEV_IDEDMA_PCI
 	help
 	  This driver ensures (U)DMA support for ALI 1533, 1543 and 1543C
 	  onboard chipsets.  It also tests for Simplex mode and enables
@@ -494,6 +483,7 @@ config WDC_ALI15X3
 
 config BLK_DEV_AMD74XX
 	tristate "AMD and nVidia IDE support"
+	select BLK_DEV_IDEDMA_PCI
 	help
 	  This driver adds explicit support for AMD-7xx and AMD-8111 chips
 	  and also for the nVidia nForce chip.  This allows the kernel to
@@ -503,6 +493,7 @@ config BLK_DEV_AMD74XX
 config BLK_DEV_ATIIXP
 	tristate "ATI IXP chipset IDE support"
 	depends on X86
+	select BLK_DEV_IDEDMA_PCI
 	help
 	  This driver adds explicit support for ATI IXP chipset.
 	  This allows the kernel to change PIO, DMA and UDMA speeds
@@ -512,18 +503,21 @@ config BLK_DEV_ATIIXP
 
 config BLK_DEV_CMD64X
 	tristate "CMD64{3|6|8|9} chipset support"
+	select BLK_DEV_IDEDMA_PCI
 	help
 	  Say Y here if you have an IDE controller which uses any of these
 	  chipsets: CMD643, CMD646, or CMD648.
 
 config BLK_DEV_TRIFLEX
 	tristate "Compaq Triflex IDE support"
+	select BLK_DEV_IDEDMA_PCI
 	help
 	  Say Y here if you have a Compaq Triflex IDE controller, such
 	  as those commonly found on Compaq Pentium-Pro systems
 
 config BLK_DEV_CY82C693
 	tristate "CY82C693 chipset support"
+	select BLK_DEV_IDEDMA_PCI
 	help
 	  This driver adds detection and support for the CY82C693 chipset
 	  used on Digital's PC-Alpha 164SX boards.
@@ -534,6 +528,7 @@ config BLK_DEV_CY82C693
 config BLK_DEV_CS5520
 	tristate "Cyrix CS5510/20 MediaGX chipset support (VERY EXPERIMENTAL)"
 	depends on EXPERIMENTAL
+	select BLK_DEV_IDEDMA_PCI
 	help
 	  Include support for PIO tuning and virtual DMA on the Cyrix MediaGX
 	  5510/5520 chipset. This will automatically be detected and
@@ -543,6 +538,7 @@ config BLK_DEV_CS5520
 
 config BLK_DEV_CS5530
 	tristate "Cyrix/National Semiconductor CS5530 MediaGX chipset support"
+	select BLK_DEV_IDEDMA_PCI
 	help
 	  Include support for UDMA on the Cyrix MediaGX 5530 chipset. This
 	  will automatically be detected and configured if found.
@@ -552,6 +548,7 @@ config BLK_DEV_CS5530
 config BLK_DEV_CS5535
 	tristate "AMD CS5535 chipset support"
 	depends on X86 && !X86_64
+	select BLK_DEV_IDEDMA_PCI
 	help
 	  Include support for UDMA on the NSC/AMD CS5535 companion chipset.
 	  This will automatically be detected and configured if found.
@@ -560,6 +557,7 @@ config BLK_DEV_CS5535
 
 config BLK_DEV_HPT34X
 	tristate "HPT34X chipset support"
+	select BLK_DEV_IDEDMA_PCI
 	help
 	  This driver adds up to 4 more EIDE devices sharing a single
 	  interrupt. The HPT343 chipset in its current form is a non-bootable
@@ -580,7 +578,8 @@ config HPT34X_AUTODMA
 
 config BLK_DEV_HPT366
 	tristate "HPT36X/37X chipset support"
-	---help---
+	select BLK_DEV_IDEDMA_PCI
+	help
 	  HPT366 is an Ultra DMA chipset for ATA-66.
 	  HPT368 is an Ultra DMA chipset for ATA-66 RAID Based.
 	  HPT370 is an Ultra DMA chipset for ATA-100.
@@ -604,18 +603,21 @@ config BLK_DEV_HPT366
 
 config BLK_DEV_JMICRON
 	tristate "JMicron JMB36x support"
+	select BLK_DEV_IDEDMA_PCI
 	help
 	  Basic support for the JMicron ATA controllers. For full support
 	  use the libata drivers.
 
 config BLK_DEV_SC1200
 	tristate "National SCx200 chipset support"
+	select BLK_DEV_IDEDMA_PCI
 	help
 	  This driver adds support for the built in IDE on the National
 	  SCx200 series of embedded x86 "Geode" systems
 
 config BLK_DEV_PIIX
 	tristate "Intel PIIXn chipsets support"
+	select BLK_DEV_IDEDMA_PCI
 	help
 	  This driver adds explicit support for Intel PIIX and ICH chips
 	  and also for the Efar Victory66 (slc90e66) chip.  This allows
@@ -624,17 +626,20 @@ config BLK_DEV_PIIX
 
 config BLK_DEV_IT8213
 	tristate "IT8213 IDE support"
+	select BLK_DEV_IDEDMA_PCI
 	help
 	 This driver adds support for the ITE 8213 IDE controller.
 
 config BLK_DEV_IT821X
 	tristate "IT821X IDE support"
+	select BLK_DEV_IDEDMA_PCI
 	help
 	  This driver adds support for the ITE 8211 IDE controller and the
 	  IT 8212 IDE RAID controller in both RAID and pass-through mode.
 
 config BLK_DEV_NS87415
 	tristate "NS87415 chipset support"
+	select BLK_DEV_IDEDMA_PCI
 	help
 	  This driver adds detection and support for the NS87415 chip
 	  (used mainly on SPARC64 and PA-RISC machines).
@@ -643,6 +648,7 @@ config BLK_DEV_NS87415
 
 config BLK_DEV_PDC202XX_OLD
 	tristate "PROMISE PDC202{46|62|65|67} support"
+	select BLK_DEV_IDEDMA_PCI
 	help
 	  Promise Ultra33 or PDC20246
 	  Promise Ultra66 or PDC20262
@@ -684,9 +690,11 @@ config PDC202XX_BURST
 
 config BLK_DEV_PDC202XX_NEW
 	tristate "PROMISE PDC202{68|69|70|71|75|76|77} support"
+	select BLK_DEV_IDEDMA_PCI
 
 config BLK_DEV_SVWKS
 	tristate "ServerWorks OSB4/CSB5/CSB6 chipsets support"
+	select BLK_DEV_IDEDMA_PCI
 	help
 	  This driver adds PIO/(U)DMA support for the ServerWorks OSB4/CSB5
 	  chipsets.
@@ -695,6 +703,7 @@ config BLK_DEV_SGIIOC4
 	tristate "Silicon Graphics IOC4 chipset ATA/ATAPI support"
 	depends on (IA64_SGI_SN2 || IA64_GENERIC) && SGI_IOC4
 	select IDEPCI_SHARE_IRQ
+	select BLK_DEV_IDEDMA_PCI
 	help
 	  This driver adds PIO & MultiMode DMA-2 support for the SGI IOC4
 	  chipset, which has one channel and can support two devices.
@@ -702,6 +711,7 @@ config BLK_DEV_SGIIOC4
 
 config BLK_DEV_SIIMAGE
 	tristate "Silicon Image chipset support"
+	select BLK_DEV_IDEDMA_PCI
 	help
 	  This driver adds PIO/(U)DMA support for the SI CMD680 and SII
 	  3112 (Serial ATA) chips.
@@ -709,7 +719,8 @@ config BLK_DEV_SIIMAGE
 config BLK_DEV_SIS5513
 	tristate "SiS5513 chipset support"
 	depends on X86
-	---help---
+	select BLK_DEV_IDEDMA_PCI
+	help
 	  This driver ensures (U)DMA support for SIS5513 chipset family based
 	  mainboards.
 
@@ -728,6 +739,7 @@ config BLK_DEV_SIS5513
 config BLK_DEV_SL82C105
 	tristate "Winbond SL82c105 support"
 	depends on (PPC || ARM)
+	select BLK_DEV_IDEDMA_PCI
 	help
 	  If you have a Winbond SL82c105 IDE controller, say Y here to enable
 	  special configuration for this chip. This is common on various CHRP
@@ -735,6 +747,7 @@ config BLK_DEV_SL82C105
 
 config BLK_DEV_SLC90E66
 	tristate "SLC90E66 chipset support"
+	select BLK_DEV_IDEDMA_PCI
 	help
 	  This driver ensures (U)DMA support for Victory66 SouthBridges for
 	  SMsC with Intel NorthBridges.  This is an Ultra66 based chipset.
@@ -750,6 +763,7 @@ config BLK_DEV_SLC90E66
 
 config BLK_DEV_TRM290
 	tristate "Tekram TRM290 chipset support"
+	select BLK_DEV_IDEDMA_PCI
 	help
 	  This driver adds support for bus master DMA transfers
 	  using the Tekram TRM290 PCI IDE chip. Volunteers are
@@ -758,6 +772,7 @@ config BLK_DEV_TRM290
 
 config BLK_DEV_VIA82CXXX
 	tristate "VIA82CXXX chipset support"
+	select BLK_DEV_IDEDMA_PCI
 	help
 	  This driver adds explicit support for VIA BusMastering IDE chips.
 	  This allows the kernel to change PIO, DMA and UDMA speeds and to
@@ -765,12 +780,14 @@ config BLK_DEV_VIA82CXXX
 
 config BLK_DEV_TC86C001
 	tristate "Toshiba TC86C001 support"
+	select BLK_DEV_IDEDMA_PCI
 	help
 	This driver adds support for Toshiba TC86C001 GOKU-S chip.
 
 config BLK_DEV_CELLEB
 	tristate "Toshiba's Cell Reference Set IDE support"
 	depends on PPC_CELLEB
+	select BLK_DEV_IDEDMA_PCI
 	help
 	  This driver provides support for the built-in IDE controller on
 	  Toshiba Cell Reference Board.
@@ -977,24 +994,9 @@ config IDE_EXT_DIRECT
 endchoice
 
 # no isa -> no vlb
-config IDE_CHIPSETS
-	bool "Other IDE chipset support"
-	depends on ISA
-	---help---
-	  Say Y here if you want to include enhanced support for various IDE
-	  interface chipsets used on motherboards and add-on cards. You can
-	  then pick your particular IDE chip from among the following options.
-	  This enhanced support may be necessary for Linux to be able to
-	  access the 3rd/4th drives in some systems. It may also enable
-	  setting of higher speed I/O rates to improve system performance with
-	  these chipsets. Most of these also require special kernel boot
-	  parameters to actually turn on the support at runtime; you can find
-	  a list of these in the file <file:Documentation/ide.txt>.
-
-	  People with SCSI-only systems can say N here.
-
-if IDE_CHIPSETS
+if ISA
 
+comment "Other IDE chipsets support"
 comment "Note: most of these also require special kernel boot parameters"
 
 config BLK_DEV_4DRIVES
