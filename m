From: Tejun Heo <tj@kernel.org>
Subject: [PATCH 6/6] libata-sff: make BMDMA optional
Date: Wed, 19 May 2010 22:10:24 +0200
Message-ID: <1274299824-15691-7-git-send-email-tj@kernel.org>
References: <1274299824-15691-1-git-send-email-tj@kernel.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:43337 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756023Ab0ESULB (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 19 May 2010 16:11:01 -0400
In-Reply-To: <1274299824-15691-1-git-send-email-tj@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>

Make BMDMA optional depending on new config variable CONFIG_ATA_BMDMA.
In Kconfig, drivers are grouped into five groups - non-SFF native, SFF
w/ custom DMA interface, SFF w/ BMDMA, PIO-only SFF, and generic
fallback / legacy ones.  Kconfig and Makefile are reorganized
according to the groups and ordered alphabetically inside each group.

ata_ioports.bmdma_addr and ata_port.bmdma_prd[_dma] are put into
CONFIG_ATA_BMDMA, as are all bmdma related ops, variables and
functions.

This increase the binary size slightly when BMDMA is enabled but on
both native-only and PIO-only configurations the size is slightly
reduced.  Either way, the size difference is insignificant.  This
change is more meaningful to signify the separation between SFF and
BMDMA and as a tool to verify the separation.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 drivers/ata/Kconfig      |  511 ++++++++++++++++++++++++----------------------
 drivers/ata/Makefile     |   83 ++++----
 drivers/ata/libata-sff.c |   11 +
 include/linux/libata.h   |   22 ++-
 4 files changed, 341 insertions(+), 286 deletions(-)

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index e68541f..73f8833 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -57,6 +57,8 @@ config SATA_PMP
 	  This option adds support for SATA Port Multipliers
 	  (the SATA version of an ethernet hub, or SAS expander).
 
+comment "Controllers with non-SFF native interface"
+
 config SATA_AHCI
 	tristate "AHCI SATA support"
 	depends on PCI
@@ -73,11 +75,12 @@ config SATA_AHCI_PLATFORM
 
 	  If unsure, say N.
 
-config SATA_SIL24
-	tristate "Silicon Image 3124/3132 SATA support"
-	depends on PCI
+config SATA_FSL
+	tristate "Freescale 3.0Gbps SATA support"
+	depends on FSL_SOC
 	help
-	  This option enables support for Silicon Image 3124/3132 Serial ATA.
+	  This option enables support for Freescale 3.0Gbps SATA controller.
+	  It can be found on MPC837x and MPC8315.
 
 	  If unsure, say N.
 
@@ -87,12 +90,11 @@ config SATA_INIC162X
 	help
 	  This option enables support for Initio 162x Serial ATA.
 
-config SATA_FSL
-	tristate "Freescale 3.0Gbps SATA support"
-	depends on FSL_SOC
+config SATA_SIL24
+	tristate "Silicon Image 3124/3132 SATA support"
+	depends on PCI
 	help
-	  This option enables support for Freescale 3.0Gbps SATA controller.
-	  It can be found on MPC837x and MPC8315.
+	  This option enables support for Silicon Image 3124/3132 Serial ATA.
 
 	  If unsure, say N.
 
@@ -116,15 +118,65 @@ config ATA_SFF
 
 if ATA_SFF
 
-config SATA_SVW
-	tristate "ServerWorks Frodo / Apple K2 SATA support"
+comment "SFF controllers with custom DMA interface"
+
+config PDC_ADMA
+	tristate "Pacific Digital ADMA support"
 	depends on PCI
 	help
-	  This option enables support for Broadcom/Serverworks/Apple K2
-	  SATA support.
+	  This option enables support for Pacific Digital ADMA controllers
+
+	  If unsure, say N.
+
+config PATA_MPC52xx
+	tristate "Freescale MPC52xx SoC internal IDE"
+	depends on PPC_MPC52xx && PPC_BESTCOMM
+	select PPC_BESTCOMM_ATA
+	help
+	  This option enables support for integrated IDE controller
+	  of the Freescale MPC52xx SoC.
+
+	  If unsure, say N.
+
+config PATA_OCTEON_CF
+	tristate "OCTEON Boot Bus Compact Flash support"
+	depends on CPU_CAVIUM_OCTEON
+	help
+	  This option enables a polled compact flash driver for use with
+	  compact flash cards attached to the OCTEON boot bus.
+
+	  If unsure, say N.
+
+config SATA_QSTOR
+	tristate "Pacific Digital SATA QStor support"
+	depends on PCI
+	help
+	  This option enables support for Pacific Digital Serial ATA QStor.
+
+	  If unsure, say N.
+
+config SATA_SX4
+	tristate "Promise SATA SX4 support (Experimental)"
+	depends on PCI && EXPERIMENTAL
+	help
+	  This option enables support for Promise Serial ATA SX4.
 
 	  If unsure, say N.
 
+config ATA_BMDMA
+	bool "ATA BMDMA support"
+	default y
+	help
+	  This option adds support for SFF ATA controllers with BMDMA
+	  capability.  BMDMA stands for bus-master DMA and the
+	  de-facto DMA interface for SFF controllers.
+
+	  If unuser, say Y.
+
+if ATA_BMDMA
+
+comment "SATA SFF controllers with BMDMA"
+
 config ATA_PIIX
 	tristate "Intel ESB, ICH, PIIX3, PIIX4 PATA/SATA support"
 	depends on PCI
@@ -152,22 +204,6 @@ config SATA_NV
 
 	  If unsure, say N.
 
-config PDC_ADMA
-	tristate "Pacific Digital ADMA support"
-	depends on PCI
-	help
-	  This option enables support for Pacific Digital ADMA controllers
-
-	  If unsure, say N.
-
-config SATA_QSTOR
-	tristate "Pacific Digital SATA QStor support"
-	depends on PCI
-	help
-	  This option enables support for Pacific Digital Serial ATA QStor.
-
-	  If unsure, say N.
-
 config SATA_PROMISE
 	tristate "Promise SATA TX2/TX4 support"
 	depends on PCI
@@ -176,14 +212,6 @@ config SATA_PROMISE
 
 	  If unsure, say N.
 
-config SATA_SX4
-	tristate "Promise SATA SX4 support (Experimental)"
-	depends on PCI && EXPERIMENTAL
-	help
-	  This option enables support for Promise Serial ATA SX4.
-
-	  If unsure, say N.
-
 config SATA_SIL
 	tristate "Silicon Image SATA support"
 	depends on PCI
@@ -203,6 +231,15 @@ config SATA_SIS
 	  enable the PATA_SIS driver in the config.
 	  If unsure, say N.
 
+config SATA_SVW
+	tristate "ServerWorks Frodo / Apple K2 SATA support"
+	depends on PCI
+	help
+	  This option enables support for Broadcom/Serverworks/Apple K2
+	  SATA support.
+
+	  If unsure, say N.
+
 config SATA_ULI
 	tristate "ULi Electronics SATA support"
 	depends on PCI
@@ -227,14 +264,7 @@ config SATA_VITESSE
 
 	  If unsure, say N.
 
-config PATA_ACPI
-	tristate "ACPI firmware driver for PATA"
-	depends on ATA_ACPI
-	help
-	  This option enables an ACPI method driver which drives
-	  motherboard PATA controller interfaces through the ACPI
-	  firmware in the BIOS. This driver can sometimes handle
-	  otherwise unsupported hardware.
+comment "PATA SFF controllers with BMDMA"
 
 config PATA_ALI
 	tristate "ALi PATA support"
@@ -262,40 +292,30 @@ config PATA_ARTOP
 
 	  If unsure, say N.
 
-config PATA_ATP867X
-	tristate "ARTOP/Acard ATP867X PATA support"
+config PATA_ATIIXP
+	tristate "ATI PATA support"
 	depends on PCI
 	help
-	  This option enables support for ARTOP/Acard ATP867X PATA
-	  controllers.
-
-	  If unsure, say N.
-
-config PATA_AT32
-	tristate "Atmel AVR32 PATA support (Experimental)"
-	depends on AVR32 && PLATFORM_AT32AP && EXPERIMENTAL
-	help
-	  This option enables support for the IDE devices on the
-	  Atmel AT32AP platform.
+	  This option enables support for the ATI ATA interfaces
+	  found on the many ATI chipsets.
 
 	  If unsure, say N.
 
-config PATA_ATIIXP
-	tristate "ATI PATA support"
+config PATA_ATP867X
+	tristate "ARTOP/Acard ATP867X PATA support"
 	depends on PCI
 	help
-	  This option enables support for the ATI ATA interfaces
-	  found on the many ATI chipsets.
+	  This option enables support for ARTOP/Acard ATP867X PATA
+	  controllers.
 
 	  If unsure, say N.
 
-config PATA_CMD640_PCI
-	tristate "CMD640 PCI PATA support (Experimental)"
-	depends on PCI && EXPERIMENTAL
+config PATA_BF54X
+	tristate "Blackfin 54x ATAPI support"
+	depends on BF542 || BF548 || BF549
 	help
-	  This option enables support for the CMD640 PCI IDE
-	  interface chip. Only the primary channel is currently
-	  supported.
+	  This option enables support for the built-in ATAPI controller on
+	  Blackfin 54x family chips.
 
 	  If unsure, say N.
 
@@ -362,15 +382,6 @@ config PATA_EFAR
 
 	  If unsure, say N.
 
-config ATA_GENERIC
-	tristate "Generic ATA support"
-	depends on PCI
-	help
-	  This option enables support for generic BIOS configured
-	  ATA controllers via the new ATA layer
-
-	  If unsure, say N.
-
 config PATA_HPT366
 	tristate "HPT 366/368 PATA support"
 	depends on PCI
@@ -415,12 +426,20 @@ config PATA_HPT3X3_DMA
 	  controllers. Enable with care as there are still some
 	  problems with DMA on this chipset.
 
-config PATA_ISAPNP
-	tristate "ISA Plug and Play PATA support"
-	depends on ISAPNP
+config PATA_ICSIDE
+	tristate "Acorn ICS PATA support"
+	depends on ARM && ARCH_ACORN
 	help
-	  This option enables support for ISA plug & play ATA
-	  controllers such as those found on old soundcards.
+	  On Acorn systems, say Y here if you wish to use the ICS PATA
+	  interface card.  This is not required for ICS partition support.
+	  If you are unsure, say N to this.
+
+config PATA_IT8213
+	tristate "IT8213 PATA support (Experimental)"
+	depends on PCI && EXPERIMENTAL
+	help
+	  This option enables support for the ITE 821 PATA
+          controllers via the new ATA layer.
 
 	  If unsure, say N.
 
@@ -434,15 +453,6 @@ config PATA_IT821X
 
 	  If unsure, say N.
 
-config PATA_IT8213
-	tristate "IT8213 PATA support (Experimental)"
-	depends on PCI && EXPERIMENTAL
-	help
-	  This option enables support for the ITE 821 PATA
-          controllers via the new ATA layer.
-
-	  If unsure, say N.
-
 config PATA_JMICRON
 	tristate "JMicron PATA support"
 	depends on PCI
@@ -452,23 +462,14 @@ config PATA_JMICRON
 
 	  If unsure, say N.
 
-config PATA_LEGACY
-	tristate "Legacy ISA PATA support (Experimental)"
-	depends on (ISA || PCI)  && EXPERIMENTAL
-	help
-	  This option enables support for ISA/VLB/PCI bus legacy PATA
-	  ports and allows them to be accessed via the new ATA layer.
-
-	  If unsure, say N.
-
-config PATA_TRIFLEX
-	tristate "Compaq Triflex PATA support"
-	depends on PCI
+config PATA_MACIO
+	tristate "Apple PowerMac/PowerBook internal 'MacIO' IDE"
+	depends on PPC_PMAC
 	help
-	  Enable support for the Compaq 'Triflex' IDE controller as found
-	  on many Compaq Pentium-Pro systems, via the new ATA layer.
-
-	  If unsure, say N.
+	  Most IDE capable PowerMacs have IDE busses driven by a variant
+          of this controller which is part of the Apple chipset used on
+          most PowerMac models. Some models have multiple busses using
+          different chipsets, though generally, MacIO is one of them.
 
 config PATA_MARVELL
 	tristate "Marvell PATA support via legacy mode"
@@ -481,32 +482,6 @@ config PATA_MARVELL
 
 	  If unsure, say N.
 
-config PATA_MPC52xx
-	tristate "Freescale MPC52xx SoC internal IDE"
-	depends on PPC_MPC52xx && PPC_BESTCOMM
-	select PPC_BESTCOMM_ATA
-	help
-	  This option enables support for integrated IDE controller
-	  of the Freescale MPC52xx SoC.
-
-	  If unsure, say N.
-
-config PATA_MPIIX
-	tristate "Intel PATA MPIIX support"
-	depends on PCI
-	help
-	  This option enables support for MPIIX PATA support.
-
-	  If unsure, say N.
-
-config PATA_OLDPIIX
-	tristate "Intel PATA old PIIX support"
-	depends on PCI
-	help
-	  This option enables support for early PIIX PATA support.
-
-	  If unsure, say N.
-
 config PATA_NETCELL
 	tristate "NETCELL Revolution RAID support"
 	depends on PCI
@@ -525,15 +500,6 @@ config PATA_NINJA32
 
 	  If unsure, say N.
 
-config PATA_NS87410
-	tristate "Nat Semi NS87410 PATA support"
-	depends on PCI
-	help
-	  This option enables support for the National Semiconductor
-	  NS87410 PCI-IDE controller.
-
-	  If unsure, say N.
-
 config PATA_NS87415
 	tristate "Nat Semi NS87415 PATA support"
 	depends on PCI
@@ -543,12 +509,11 @@ config PATA_NS87415
 
 	  If unsure, say N.
 
-config PATA_OPTI
-	tristate "OPTI621/6215 PATA support (Very Experimental)"
-	depends on PCI && EXPERIMENTAL
+config PATA_OLDPIIX
+	tristate "Intel PATA old PIIX support"
+	depends on PCI
 	help
-	  This option enables full PIO support for the early Opti ATA
-	  controllers found on some old motherboards.
+	  This option enables support for early PIIX PATA support.
 
 	  If unsure, say N.
 
@@ -562,24 +527,6 @@ config PATA_OPTIDMA
 
 	  If unsure, say N.
 
-config PATA_PALMLD
-	tristate "Palm LifeDrive PATA support"
-	depends on MACH_PALMLD
-	help
-	  This option enables support for Palm LifeDrive's internal ATA
-	  port via the new ATA layer.
-
-	  If unsure, say N.
-
-config PATA_PCMCIA
-	tristate "PCMCIA PATA support"
-	depends on PCMCIA
-	help
-	  This option enables support for PCMCIA ATA interfaces, including
-	  compact flash card adapters via the new ATA layer.
-
-	  If unsure, say N.
-
 config PATA_PDC2027X
 	tristate "Promise PATA 2027x support"
 	depends on PCI
@@ -597,12 +544,6 @@ config PATA_PDC_OLD
 
 	  If unsure, say N.
 
-config PATA_QDI
-	tristate "QDI VLB PATA support"
-	depends on ISA
-	help
-	  Support for QDI 6500 and 6580 PATA controllers on VESA local bus.
-
 config PATA_RADISYS
 	tristate "RADISYS 82600 PATA support (Experimental)"
 	depends on PCI && EXPERIMENTAL
@@ -612,15 +553,6 @@ config PATA_RADISYS
 
 	  If unsure, say N.
 
-config PATA_RB532
-	tristate "RouterBoard 532 PATA CompactFlash support"
-	depends on MIKROTIK_RB532
-	help
-	  This option enables support for the RouterBoard 532
-	  PATA CompactFlash controller.
-
-	  If unsure, say N.
-
 config PATA_RDC
 	tristate "RDC PATA support"
 	depends on PCI
@@ -631,21 +563,30 @@ config PATA_RDC
 
 	  If unsure, say N.
 
-config PATA_RZ1000
-	tristate "PC Tech RZ1000 PATA support"
+config PATA_SC1200
+	tristate "SC1200 PATA support"
 	depends on PCI
 	help
-	  This option enables basic support for the PC Tech RZ1000/1
-	  PATA controllers via the new ATA layer
+	  This option enables support for the NatSemi/AMD SC1200 SoC
+	  companion chip used with the Geode processor family.
 
 	  If unsure, say N.
 
-config PATA_SC1200
-	tristate "SC1200 PATA support"
+config PATA_SCC
+	tristate "Toshiba's Cell Reference Set IDE support"
+	depends on PCI && PPC_CELLEB
+	help
+	  This option enables support for the built-in IDE controller on
+	  Toshiba Cell Reference Board.
+
+	  If unsure, say N.
+
+config PATA_SCH
+	tristate "Intel SCH PATA support"
 	depends on PCI
 	help
-	  This option enables support for the NatSemi/AMD SC1200 SoC
-	  companion chip used with the Geode processor family.
+	  This option enables support for Intel SCH PATA on the Intel
+	  SCH (US15W, US15L, UL11L) series host controllers.
 
 	  If unsure, say N.
 
@@ -683,6 +624,15 @@ config PATA_TOSHIBA
 
 	  If unsure, say N.
 
+config PATA_TRIFLEX
+	tristate "Compaq Triflex PATA support"
+	depends on PCI
+	help
+	  Enable support for the Compaq 'Triflex' IDE controller as found
+	  on many Compaq Pentium-Pro systems, via the new ATA layer.
+
+	  If unsure, say N.
+
 config PATA_VIA
 	tristate "VIA PATA support"
 	depends on PCI
@@ -701,12 +651,99 @@ config PATA_WINBOND
 
 	  If unsure, say N.
 
-config PATA_WINBOND_VLB
-	tristate "Winbond W83759A VLB PATA support (Experimental)"
-	depends on ISA && EXPERIMENTAL
+endif # ATA_BMDMA
+
+comment "PIO-only SFF controllers"
+
+config PATA_AT32
+	tristate "Atmel AVR32 PATA support (Experimental)"
+	depends on AVR32 && PLATFORM_AT32AP && EXPERIMENTAL
 	help
-	  Support for the Winbond W83759A controller on Vesa Local Bus
-	  systems.
+	  This option enables support for the IDE devices on the
+	  Atmel AT32AP platform.
+
+	  If unsure, say N.
+
+config PATA_AT91
+	tristate "PATA support for AT91SAM9260"
+	depends on ARM && ARCH_AT91
+	help
+	  This option enables support for IDE devices on the Atmel AT91SAM9260 SoC.
+
+	  If unsure, say N.
+
+config PATA_CMD640_PCI
+	tristate "CMD640 PCI PATA support (Experimental)"
+	depends on PCI && EXPERIMENTAL
+	help
+	  This option enables support for the CMD640 PCI IDE
+	  interface chip. Only the primary channel is currently
+	  supported.
+
+	  If unsure, say N.
+
+config PATA_ISAPNP
+	tristate "ISA Plug and Play PATA support"
+	depends on ISAPNP
+	help
+	  This option enables support for ISA plug & play ATA
+	  controllers such as those found on old soundcards.
+
+	  If unsure, say N.
+
+config PATA_IXP4XX_CF
+	tristate "IXP4XX Compact Flash support"
+	depends on ARCH_IXP4XX
+	help
+	  This option enables support for a Compact Flash connected on
+	  the ixp4xx expansion bus. This driver had been written for
+	  Loft/Avila boards in mind but can work with others.
+
+	  If unsure, say N.
+
+config PATA_MPIIX
+	tristate "Intel PATA MPIIX support"
+	depends on PCI
+	help
+	  This option enables support for MPIIX PATA support.
+
+	  If unsure, say N.
+
+config PATA_NS87410
+	tristate "Nat Semi NS87410 PATA support"
+	depends on PCI
+	help
+	  This option enables support for the National Semiconductor
+	  NS87410 PCI-IDE controller.
+
+	  If unsure, say N.
+
+config PATA_OPTI
+	tristate "OPTI621/6215 PATA support (Very Experimental)"
+	depends on PCI && EXPERIMENTAL
+	help
+	  This option enables full PIO support for the early Opti ATA
+	  controllers found on some old motherboards.
+
+	  If unsure, say N.
+
+config PATA_PALMLD
+	tristate "Palm LifeDrive PATA support"
+	depends on MACH_PALMLD
+	help
+	  This option enables support for Palm LifeDrive's internal ATA
+	  port via the new ATA layer.
+
+	  If unsure, say N.
+
+config PATA_PCMCIA
+	tristate "PCMCIA PATA support"
+	depends on PCMCIA
+	help
+	  This option enables support for PCMCIA ATA interfaces, including
+	  compact flash card adapters via the new ATA layer.
+
+	  If unsure, say N.
 
 config HAVE_PATA_PLATFORM
 	bool
@@ -725,14 +762,6 @@ config PATA_PLATFORM
 
 	  If unsure, say N.
 
-config PATA_AT91
-	tristate "PATA support for AT91SAM9260"
-	depends on ARM && ARCH_AT91
-	help
-	  This option enables support for IDE devices on the Atmel AT91SAM9260 SoC.
-
-	  If unsure, say N.
-
 config PATA_OF_PLATFORM
 	tristate "OpenFirmware platform device PATA support"
 	depends on PATA_PLATFORM && PPC_OF
@@ -743,69 +772,65 @@ config PATA_OF_PLATFORM
 
 	  If unsure, say N.
 
-config PATA_ICSIDE
-	tristate "Acorn ICS PATA support"
-	depends on ARM && ARCH_ACORN
+config PATA_QDI
+	tristate "QDI VLB PATA support"
+	depends on ISA
 	help
-	  On Acorn systems, say Y here if you wish to use the ICS PATA
-	  interface card.  This is not required for ICS partition support.
-	  If you are unsure, say N to this.
+	  Support for QDI 6500 and 6580 PATA controllers on VESA local bus.
 
-config PATA_IXP4XX_CF
-	tristate "IXP4XX Compact Flash support"
-	depends on ARCH_IXP4XX
+config PATA_RB532
+	tristate "RouterBoard 532 PATA CompactFlash support"
+	depends on MIKROTIK_RB532
 	help
-	  This option enables support for a Compact Flash connected on
-	  the ixp4xx expansion bus. This driver had been written for
-	  Loft/Avila boards in mind but can work with others.
+	  This option enables support for the RouterBoard 532
+	  PATA CompactFlash controller.
 
 	  If unsure, say N.
 
-config PATA_OCTEON_CF
-	tristate "OCTEON Boot Bus Compact Flash support"
-	depends on CPU_CAVIUM_OCTEON
+config PATA_RZ1000
+	tristate "PC Tech RZ1000 PATA support"
+	depends on PCI
 	help
-	  This option enables a polled compact flash driver for use with
-	  compact flash cards attached to the OCTEON boot bus.
+	  This option enables basic support for the PC Tech RZ1000/1
+	  PATA controllers via the new ATA layer
 
 	  If unsure, say N.
 
-config PATA_SCC
-	tristate "Toshiba's Cell Reference Set IDE support"
-	depends on PCI && PPC_CELLEB
+config PATA_WINBOND_VLB
+	tristate "Winbond W83759A VLB PATA support (Experimental)"
+	depends on ISA && EXPERIMENTAL
 	help
-	  This option enables support for the built-in IDE controller on
-	  Toshiba Cell Reference Board.
+	  Support for the Winbond W83759A controller on Vesa Local Bus
+	  systems.
 
-	  If unsure, say N.
+comment "Generic fallback / legacy drivers"
 
-config PATA_SCH
-	tristate "Intel SCH PATA support"
-	depends on PCI
+config PATA_ACPI
+	tristate "ACPI firmware driver for PATA"
+	depends on ATA_ACPI && ATA_BMDMA
 	help
-	  This option enables support for Intel SCH PATA on the Intel
-	  SCH (US15W, US15L, UL11L) series host controllers.
-
-	  If unsure, say N.
+	  This option enables an ACPI method driver which drives
+	  motherboard PATA controller interfaces through the ACPI
+	  firmware in the BIOS. This driver can sometimes handle
+	  otherwise unsupported hardware.
 
-config PATA_BF54X
-	tristate "Blackfin 54x ATAPI support"
-	depends on BF542 || BF548 || BF549
+config ATA_GENERIC
+	tristate "Generic ATA support"
+	depends on PCI && ATA_BMDMA
 	help
-	  This option enables support for the built-in ATAPI controller on
-	  Blackfin 54x family chips.
+	  This option enables support for generic BIOS configured
+	  ATA controllers via the new ATA layer
 
 	  If unsure, say N.
 
-config PATA_MACIO
-	tristate "Apple PowerMac/PowerBook internal 'MacIO' IDE"
-	depends on PPC_PMAC
+config PATA_LEGACY
+	tristate "Legacy ISA PATA support (Experimental)"
+	depends on (ISA || PCI) && EXPERIMENTAL
 	help
-	  Most IDE capable PowerMacs have IDE busses driven by a variant
-          of this controller which is part of the Apple chipset used on
-          most PowerMac models. Some models have multiple busses using
-          different chipsets, though generally, MacIO is one of them.
+	  This option enables support for ISA/VLB/PCI bus legacy PATA
+	  ports and allows them to be accessed via the new ATA layer.
 
+	  If unsure, say N.
 
 endif # ATA_SFF
 endif # ATA
diff --git a/drivers/ata/Makefile b/drivers/ata/Makefile
index d0a93c4..7ef89d7 100644
--- a/drivers/ata/Makefile
+++ b/drivers/ata/Makefile
@@ -1,33 +1,39 @@
 
 obj-$(CONFIG_ATA)		+= libata.o
 
+# non-SFF interface
 obj-$(CONFIG_SATA_AHCI)		+= ahci.o libahci.o
 obj-$(CONFIG_SATA_AHCI_PLATFORM) += ahci_platform.o libahci.o
-obj-$(CONFIG_SATA_SVW)		+= sata_svw.o
+obj-$(CONFIG_SATA_FSL)		+= sata_fsl.o
+obj-$(CONFIG_SATA_INIC162X)	+= sata_inic162x.o
+obj-$(CONFIG_SATA_SIL24)	+= sata_sil24.o
+
+# SFF w/ custom DMA
+obj-$(CONFIG_PDC_ADMA)		+= pdc_adma.o
+obj-$(CONFIG_PATA_MPC52xx)	+= pata_mpc52xx.o
+obj-$(CONFIG_PATA_OCTEON_CF)	+= pata_octeon_cf.o
+obj-$(CONFIG_SATA_QSTOR)	+= sata_qstor.o
+obj-$(CONFIG_SATA_SX4)		+= sata_sx4.o
+
+# SFF SATA w/ BMDMA
 obj-$(CONFIG_ATA_PIIX)		+= ata_piix.o
+obj-$(CONFIG_SATA_MV)		+= sata_mv.o
+obj-$(CONFIG_SATA_NV)		+= sata_nv.o
 obj-$(CONFIG_SATA_PROMISE)	+= sata_promise.o
-obj-$(CONFIG_SATA_QSTOR)	+= sata_qstor.o
 obj-$(CONFIG_SATA_SIL)		+= sata_sil.o
-obj-$(CONFIG_SATA_SIL24)	+= sata_sil24.o
-obj-$(CONFIG_SATA_VIA)		+= sata_via.o
-obj-$(CONFIG_SATA_VITESSE)	+= sata_vsc.o
 obj-$(CONFIG_SATA_SIS)		+= sata_sis.o
-obj-$(CONFIG_SATA_SX4)		+= sata_sx4.o
-obj-$(CONFIG_SATA_NV)		+= sata_nv.o
+obj-$(CONFIG_SATA_SVW)		+= sata_svw.o
 obj-$(CONFIG_SATA_ULI)		+= sata_uli.o
-obj-$(CONFIG_SATA_MV)		+= sata_mv.o
-obj-$(CONFIG_SATA_INIC162X)	+= sata_inic162x.o
-obj-$(CONFIG_PDC_ADMA)		+= pdc_adma.o
-obj-$(CONFIG_SATA_FSL)		+= sata_fsl.o
-obj-$(CONFIG_PATA_MACIO)	+= pata_macio.o
+obj-$(CONFIG_SATA_VIA)		+= sata_via.o
+obj-$(CONFIG_SATA_VITESSE)	+= sata_vsc.o
 
+# SFF PATA w/ BMDMA
 obj-$(CONFIG_PATA_ALI)		+= pata_ali.o
 obj-$(CONFIG_PATA_AMD)		+= pata_amd.o
 obj-$(CONFIG_PATA_ARTOP)	+= pata_artop.o
-obj-$(CONFIG_PATA_ATP867X)	+= pata_atp867x.o
-obj-$(CONFIG_PATA_AT32)		+= pata_at32.o
 obj-$(CONFIG_PATA_ATIIXP)	+= pata_atiixp.o
-obj-$(CONFIG_PATA_CMD640_PCI)	+= pata_cmd640.o
+obj-$(CONFIG_PATA_ATP867X)	+= pata_atp867x.o
+obj-$(CONFIG_PATA_BF54X)	+= pata_bf54x.o
 obj-$(CONFIG_PATA_CMD64X)	+= pata_cmd64x.o
 obj-$(CONFIG_PATA_CS5520)	+= pata_cs5520.o
 obj-$(CONFIG_PATA_CS5530)	+= pata_cs5530.o
@@ -39,47 +45,50 @@ obj-$(CONFIG_PATA_HPT366)	+= pata_hpt366.o
 obj-$(CONFIG_PATA_HPT37X)	+= pata_hpt37x.o
 obj-$(CONFIG_PATA_HPT3X2N)	+= pata_hpt3x2n.o
 obj-$(CONFIG_PATA_HPT3X3)	+= pata_hpt3x3.o
-obj-$(CONFIG_PATA_ISAPNP)	+= pata_isapnp.o
-obj-$(CONFIG_PATA_IT821X)	+= pata_it821x.o
+obj-$(CONFIG_PATA_ICSIDE)	+= pata_icside.o
 obj-$(CONFIG_PATA_IT8213)	+= pata_it8213.o
+obj-$(CONFIG_PATA_IT821X)	+= pata_it821x.o
 obj-$(CONFIG_PATA_JMICRON)	+= pata_jmicron.o
+obj-$(CONFIG_PATA_MACIO)	+= pata_macio.o
+obj-$(CONFIG_PATA_MARVELL)	+= pata_marvell.o
 obj-$(CONFIG_PATA_NETCELL)	+= pata_netcell.o
 obj-$(CONFIG_PATA_NINJA32)	+= pata_ninja32.o
-obj-$(CONFIG_PATA_NS87410)	+= pata_ns87410.o
 obj-$(CONFIG_PATA_NS87415)	+= pata_ns87415.o
-obj-$(CONFIG_PATA_OPTI)		+= pata_opti.o
-obj-$(CONFIG_PATA_OPTIDMA)	+= pata_optidma.o
-obj-$(CONFIG_PATA_MPC52xx)	+= pata_mpc52xx.o
-obj-$(CONFIG_PATA_MARVELL)	+= pata_marvell.o
-obj-$(CONFIG_PATA_MPIIX)	+= pata_mpiix.o
 obj-$(CONFIG_PATA_OLDPIIX)	+= pata_oldpiix.o
-obj-$(CONFIG_PATA_PALMLD)	+= pata_palmld.o
-obj-$(CONFIG_PATA_PCMCIA)	+= pata_pcmcia.o
+obj-$(CONFIG_PATA_OPTIDMA)	+= pata_optidma.o
 obj-$(CONFIG_PATA_PDC2027X)	+= pata_pdc2027x.o
 obj-$(CONFIG_PATA_PDC_OLD)	+= pata_pdc202xx_old.o
-obj-$(CONFIG_PATA_QDI)		+= pata_qdi.o
 obj-$(CONFIG_PATA_RADISYS)	+= pata_radisys.o
-obj-$(CONFIG_PATA_RB532)	+= pata_rb532_cf.o
 obj-$(CONFIG_PATA_RDC)		+= pata_rdc.o
-obj-$(CONFIG_PATA_RZ1000)	+= pata_rz1000.o
 obj-$(CONFIG_PATA_SC1200)	+= pata_sc1200.o
+obj-$(CONFIG_PATA_SCC)		+= pata_scc.o
+obj-$(CONFIG_PATA_SCH)		+= pata_sch.o
 obj-$(CONFIG_PATA_SERVERWORKS)	+= pata_serverworks.o
 obj-$(CONFIG_PATA_SIL680)	+= pata_sil680.o
+obj-$(CONFIG_PATA_SIS)		+= pata_sis.o
 obj-$(CONFIG_PATA_TOSHIBA)	+= pata_piccolo.o
+obj-$(CONFIG_PATA_TRIFLEX)	+= pata_triflex.o
 obj-$(CONFIG_PATA_VIA)		+= pata_via.o
 obj-$(CONFIG_PATA_WINBOND)	+= pata_sl82c105.o
-obj-$(CONFIG_PATA_WINBOND_VLB)	+= pata_winbond.o
-obj-$(CONFIG_PATA_SIS)		+= pata_sis.o
-obj-$(CONFIG_PATA_TRIFLEX)	+= pata_triflex.o
+
+# SFF PIO only
+obj-$(CONFIG_PATA_AT32)		+= pata_at32.o
+obj-$(CONFIG_PATA_AT91)		+= pata_at91.o
+obj-$(CONFIG_PATA_CMD640_PCI)	+= pata_cmd640.o
+obj-$(CONFIG_PATA_ISAPNP)	+= pata_isapnp.o
 obj-$(CONFIG_PATA_IXP4XX_CF)	+= pata_ixp4xx_cf.o
-obj-$(CONFIG_PATA_SCC)		+= pata_scc.o
-obj-$(CONFIG_PATA_SCH)		+= pata_sch.o
-obj-$(CONFIG_PATA_BF54X)	+= pata_bf54x.o
-obj-$(CONFIG_PATA_OCTEON_CF)	+= pata_octeon_cf.o
+obj-$(CONFIG_PATA_MPIIX)	+= pata_mpiix.o
+obj-$(CONFIG_PATA_NS87410)	+= pata_ns87410.o
+obj-$(CONFIG_PATA_OPTI)		+= pata_opti.o
+obj-$(CONFIG_PATA_PCMCIA)	+= pata_pcmcia.o
+obj-$(CONFIG_PATA_PALMLD)	+= pata_palmld.o
 obj-$(CONFIG_PATA_PLATFORM)	+= pata_platform.o
-obj-$(CONFIG_PATA_AT91)	+= pata_at91.o
 obj-$(CONFIG_PATA_OF_PLATFORM)	+= pata_of_platform.o
-obj-$(CONFIG_PATA_ICSIDE)	+= pata_icside.o
+obj-$(CONFIG_PATA_QDI)		+= pata_qdi.o
+obj-$(CONFIG_PATA_RB532)	+= pata_rb532_cf.o
+obj-$(CONFIG_PATA_RZ1000)	+= pata_rz1000.o
+obj-$(CONFIG_PATA_WINBOND_VLB)	+= pata_winbond.o
+
 # Should be last but two libata driver
 obj-$(CONFIG_PATA_ACPI)		+= pata_acpi.o
 # Should be last but one libata driver
diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index c29f146..efa4a18 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -798,11 +798,15 @@ static void atapi_send_cdb(struct ata_port *ap, struct ata_queued_cmd *qc)
 	case ATAPI_PROT_NODATA:
 		ap->hsm_task_state = HSM_ST_LAST;
 		break;
+#ifdef CONFIG_ATA_BMDMA
 	case ATAPI_PROT_DMA:
 		ap->hsm_task_state = HSM_ST_LAST;
 		/* initiate bmdma */
 		ap->ops->bmdma_start(qc);
 		break;
+#endif /* CONFIG_ATA_BMDMA */
+	default:
+		BUG();
 	}
 }
 
@@ -2535,6 +2539,12 @@ EXPORT_SYMBOL_GPL(ata_pci_sff_init_one);
 
 #endif /* CONFIG_PCI */
 
+/*
+ *	BMDMA support
+ */
+
+#ifdef CONFIG_ATA_BMDMA
+
 const struct ata_port_operations ata_bmdma_port_ops = {
 	.inherits		= &ata_sff_port_ops,
 
@@ -3287,6 +3297,7 @@ int ata_pci_bmdma_init_one(struct pci_dev *pdev,
 EXPORT_SYMBOL_GPL(ata_pci_bmdma_init_one);
 
 #endif /* CONFIG_PCI */
+#endif /* CONFIG_ATA_BMDMA */
 
 /**
  *	ata_sff_port_init - Initialize SFF/BMDMA ATA port
diff --git a/include/linux/libata.h b/include/linux/libata.h
index fe2be88..4c5eca4 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -513,7 +513,9 @@ struct ata_ioports {
 	void __iomem		*command_addr;
 	void __iomem		*altstatus_addr;
 	void __iomem		*ctl_addr;
+#ifdef CONFIG_ATA_BMDMA
 	void __iomem		*bmdma_addr;
+#endif /* CONFIG_ATA_BMDMA */
 	void __iomem		*scr_addr;
 };
 #endif /* CONFIG_ATA_SFF */
@@ -721,8 +723,10 @@ struct ata_port {
 	u8			ctl;	/* cache of ATA control register */
 	u8			last_ctl;	/* Cache last written value */
 	struct delayed_work	sff_pio_task;
+#ifdef CONFIG_ATA_BMDMA
 	struct ata_bmdma_prd	*bmdma_prd;	/* BMDMA SG list */
 	dma_addr_t		bmdma_prd_dma;	/* and its DMA mapping */
+#endif /* CONFIG_ATA_BMDMA */
 #endif /* CONFIG_ATA_SFF */
 
 	unsigned int		pio_mask;
@@ -856,10 +860,12 @@ struct ata_port_operations {
 	void (*sff_irq_clear)(struct ata_port *);
 	void (*sff_drain_fifo)(struct ata_queued_cmd *qc);
 
+#ifdef CONFIG_ATA_BMDMA
 	void (*bmdma_setup)(struct ata_queued_cmd *qc);
 	void (*bmdma_start)(struct ata_queued_cmd *qc);
 	void (*bmdma_stop)(struct ata_queued_cmd *qc);
 	u8   (*bmdma_status)(struct ata_port *ap);
+#endif /* CONFIG_ATA_BMDMA */
 #endif /* CONFIG_ATA_SFF */
 
 	ssize_t (*em_show)(struct ata_port *ap, char *buf);
@@ -1555,7 +1561,6 @@ extern void sata_pmp_error_handler(struct ata_port *ap);
 #ifdef CONFIG_ATA_SFF
 
 extern const struct ata_port_operations ata_sff_port_ops;
-extern const struct ata_port_operations ata_bmdma_port_ops;
 extern const struct ata_port_operations ata_bmdma32_port_ops;
 
 /* PIO only, sg_tablesize and dma_boundary limits can be removed */
@@ -1564,11 +1569,6 @@ extern const struct ata_port_operations ata_bmdma32_port_ops;
 	.sg_tablesize		= LIBATA_MAX_PRD,		\
 	.dma_boundary		= ATA_DMA_BOUNDARY
 
-#define ATA_BMDMA_SHT(drv_name)					\
-	ATA_BASE_SHT(drv_name),					\
-	.sg_tablesize		= LIBATA_MAX_PRD,		\
-	.dma_boundary		= ATA_DMA_BOUNDARY
-
 extern void ata_sff_dev_select(struct ata_port *ap, unsigned int device);
 extern u8 ata_sff_check_status(struct ata_port *ap);
 extern void ata_sff_pause(struct ata_port *ap);
@@ -1625,6 +1625,15 @@ extern int ata_pci_sff_init_one(struct pci_dev *pdev,
 		struct scsi_host_template *sht, void *host_priv, int hflags);
 #endif /* CONFIG_PCI */
 
+#ifdef CONFIG_ATA_BMDMA
+
+extern const struct ata_port_operations ata_bmdma_port_ops;
+
+#define ATA_BMDMA_SHT(drv_name)					\
+	ATA_BASE_SHT(drv_name),					\
+	.sg_tablesize		= LIBATA_MAX_PRD,		\
+	.dma_boundary		= ATA_DMA_BOUNDARY
+
 extern void ata_bmdma_qc_prep(struct ata_queued_cmd *qc);
 extern unsigned int ata_bmdma_qc_issue(struct ata_queued_cmd *qc);
 extern void ata_bmdma_dumb_qc_prep(struct ata_queued_cmd *qc);
@@ -1652,6 +1661,7 @@ extern int ata_pci_bmdma_init_one(struct pci_dev *pdev,
 				  struct scsi_host_template *sht,
 				  void *host_priv, int hflags);
 #endif /* CONFIG_PCI */
+#endif /* CONFIG_ATA_BMDMA */
 
 /**
  *	ata_sff_busy_wait - Wait for a port status register
-- 
1.6.4.2

