From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 21/21] ide: make remaining built-in only IDE host drivers modular
Date: Sun, 18 Nov 2007 23:41:30 +0100
Message-ID: <200711182341.31267.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.175]:48323 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753233AbXKRWgy (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 18 Nov 2007 17:36:54 -0500
Received: by ug-out-1314.google.com with SMTP id z38so873016ugc
        for <linux-ide@vger.kernel.org>; Sun, 18 Nov 2007 14:36:53 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Mikael Starvik <starvik@axis.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Roman Zippel <zippel@linux-m68k.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>


* Make remaining built-in only IDE host drivers modular, add ide-scan-pci.c
  file for probing PCI host drivers registered with IDE core (special case
  for built-in IDE and CONFIG_IDEPCI_PCIBUS_ORDER=y) and then take care of
  the ordering in which all IDE host drivers are probed when IDE is built-in
  during link time.

* Move probing of gayle, falconide, macide, q40ide and buddha (m68k arch
  specific) host drivers, before PCI ones (no PCI on m68k), ide-cris (cris
  arch specific), cmd640 (x86 arch specific) and pmac (ppc arch specific).

* Move probing of ide-cris (cris arch specific) host driver before cmd640
  (x86 arch specific).

* Move probing of mpc8xx (ppc specific) host driver before ide-pnp (depends
  on ISA and none of ppc platform that use mpc8xx supports ISA) and ide-h8300
  (h8300 arch specific).

* Add "probe_vlb" kernel parameter to cmd640 host driver and update
  Documentation/ide.txt accordingly.

* Make IDE_ARM config option visible so it can also be disabled if needed.

* Remove bogus comment from ide.c while at it.

Cc: Mikael Starvik <starvik@axis.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Roman Zippel <zippel@linux-m68k.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 Documentation/ide.txt          |    9 +-
 drivers/ide/Kconfig            |   26 ++++----
 drivers/ide/Makefile           |   64 +++++++++++---------
 drivers/ide/arm/Makefile       |    4 +
 drivers/ide/arm/ide_arm.c      |    6 +
 drivers/ide/cris/Makefile      |    2 
 drivers/ide/cris/ide-cris.c    |    7 +-
 drivers/ide/h8300/Makefile     |    2 
 drivers/ide/h8300/ide-h8300.c  |   10 ++-
 drivers/ide/ide-pnp.c          |    9 +-
 drivers/ide/ide-scan-pci.c     |   11 +++
 drivers/ide/ide.c              |  131 -----------------------------------------
 drivers/ide/legacy/Makefile    |   19 ++++-
 drivers/ide/legacy/ali14xx.c   |    5 -
 drivers/ide/legacy/buddha.c    |    6 +
 drivers/ide/legacy/dtc2278.c   |    5 -
 drivers/ide/legacy/falconide.c |    7 +-
 drivers/ide/legacy/gayle.c     |   10 ++-
 drivers/ide/legacy/ht6560b.c   |    5 -
 drivers/ide/legacy/macide.c    |    8 +-
 drivers/ide/legacy/q40ide.c    |    7 +-
 drivers/ide/legacy/qd65xx.c    |    5 -
 drivers/ide/legacy/umc8672.c   |    5 -
 drivers/ide/pci/Makefile       |    4 +
 drivers/ide/pci/cmd640.c       |    8 +-
 drivers/ide/ppc/Makefile       |    3 
 drivers/ide/ppc/mpc8xx.c       |    6 +
 drivers/ide/ppc/pmac.c         |    2 
 drivers/ide/setup-pci.c        |    9 +-
 include/linux/ide.h            |    3 
 30 files changed, 174 insertions(+), 224 deletions(-)

Index: b/Documentation/ide.txt
===================================================================
--- a/Documentation/ide.txt
+++ b/Documentation/ide.txt
@@ -30,7 +30,7 @@
 ***
 ***  The CMD640 is also used on some Vesa Local Bus (VLB) cards, and is *NOT*
 ***  automatically detected by Linux.  For safe, reliable operation with such
-***  interfaces, one *MUST* use the "ide0=cmd640_vlb" kernel option.
+***  interfaces, one *MUST* use the "cmd640.probe_vlb" kernel option.
 ***
 ***  Use of the "serialize" option is no longer necessary.
 
@@ -292,9 +292,6 @@ The following are valid ONLY on ide0, wh
 to the first ATA interface found on the particular host, and the defaults for
 the base,ctl ports must not be altered.
 
- "ide0=cmd640_vlb"	: *REQUIRED* for VLB cards with the CMD640 chip
-			  (not for PCI -- automatically detected)
-
  "ide=doubler"		: probe/support IDE doublers on Amiga
 
 There may be more options than shown -- use the source, Luke!
@@ -310,6 +307,10 @@ i.e. to enable probing for ALI M14xx chi
 * "probe" module parameter when ali14xx driver is compiled as module
   ("modprobe ali14xx probe")
 
+Also for legacy CMD640 host driver (cmd640) you need to use "probe_vlb"
+kernel paremeter to enable probing for VLB version of the chipset (PCI ones
+are detected automatically).
+
 ================================================================================
 
 IDE ATAPI streaming tape driver
Index: b/drivers/ide/Kconfig
===================================================================
--- a/drivers/ide/Kconfig
+++ b/drivers/ide/Kconfig
@@ -325,7 +325,7 @@ config BLK_DEV_PLATFORM
 	  If unsure, say N.
 
 config BLK_DEV_CMD640
-	bool "CMD640 chipset bugfix/support"
+	tristate "CMD640 chipset bugfix/support"
 	depends on X86
 	---help---
 	  The CMD-Technologies CMD640 IDE chip is used on many common 486 and
@@ -359,7 +359,7 @@ config BLK_DEV_CMD640_ENHANCED
 	  Otherwise say N.
 
 config BLK_DEV_IDEPNP
-	bool "PNP EIDE support"
+	tristate "PNP EIDE support"
 	depends on PNP
 	help
 	  If you have a PnP (Plug and Play) compatible EIDE card and
@@ -783,7 +783,7 @@ config BLK_DEV_CELLEB
 endif
 
 config BLK_DEV_IDE_PMAC
-	bool "Builtin PowerMac IDE support"
+	tristate "Builtin PowerMac IDE support"
 	depends on PPC_PMAC && IDE=y && BLK_DEV_IDE=y
 	help
 	  This driver provides support for the built-in IDE controller on
@@ -837,7 +837,9 @@ config BLK_DEV_IDE_AU1XXX_SEQTS_PER_RQ
        depends on BLK_DEV_IDE_AU1XXX
 
 config IDE_ARM
-	def_bool ARM && (ARCH_CLPS7500 || ARCH_RPC || ARCH_SHARK)
+	tristate "ARM IDE support"
+	depends on ARM && (ARCH_CLPS7500 || ARCH_RPC || ARCH_SHARK)
+	default y
 
 config BLK_DEV_IDE_ICSIDE
 	tristate "ICS IDE interface support"
@@ -869,7 +871,7 @@ config BLK_DEV_IDE_BAST
 	  Simtec BAST or the Thorcom VR1000
 
 config ETRAX_IDE
-	bool "ETRAX IDE support"
+	tristate "ETRAX IDE support"
 	depends on CRIS && BROKEN
 	select BLK_DEV_IDEDMA
 	help
@@ -903,14 +905,14 @@ config ETRAX_IDE_G27_RESET
 endchoice
 
 config IDE_H8300
-	bool "H8300 IDE support"
+	tristate "H8300 IDE support"
 	depends on H8300
 	default y
 	help
 	  Enables the H8300 IDE driver.
 
 config BLK_DEV_GAYLE
-	bool "Amiga Gayle IDE interface support"
+	tristate "Amiga Gayle IDE interface support"
 	depends on AMIGA
 	help
 	  This is the IDE driver for the Amiga Gayle IDE interface. It supports
@@ -941,7 +943,7 @@ config BLK_DEV_IDEDOUBLER
 	  runtime using the "ide=doubler" kernel boot parameter.
 
 config BLK_DEV_BUDDHA
-	bool "Buddha/Catweasel/X-Surf IDE interface support (EXPERIMENTAL)"
+	tristate "Buddha/Catweasel/X-Surf IDE interface support (EXPERIMENTAL)"
 	depends on ZORRO && EXPERIMENTAL
 	help
 	  This is the IDE driver for the IDE interfaces on the Buddha, 
@@ -953,7 +955,7 @@ config BLK_DEV_BUDDHA
 	  to one of its IDE interfaces.
 
 config BLK_DEV_FALCON_IDE
-	bool "Falcon IDE interface support"
+	tristate "Falcon IDE interface support"
 	depends on ATARI
 	help
 	  This is the IDE driver for the builtin IDE interface on the Atari
@@ -962,7 +964,7 @@ config BLK_DEV_FALCON_IDE
 	  interface.
 
 config BLK_DEV_MAC_IDE
-	bool "Macintosh Quadra/Powerbook IDE interface support"
+	tristate "Macintosh Quadra/Powerbook IDE interface support"
 	depends on MAC
 	help
 	  This is the IDE driver for the builtin IDE interface on some m68k
@@ -975,7 +977,7 @@ config BLK_DEV_MAC_IDE
 	  builtin IDE interface.
 
 config BLK_DEV_Q40IDE
-	bool "Q40/Q60 IDE interface support"
+	tristate "Q40/Q60 IDE interface support"
 	depends on Q40
 	help
 	  Enable the on-board IDE controller in the Q40/Q60.  This should
@@ -983,7 +985,7 @@ config BLK_DEV_Q40IDE
 	  drive subsystem through an expansion card.
 
 config BLK_DEV_MPC8xx_IDE
-	bool "MPC8xx IDE support"
+	tristate "MPC8xx IDE support"
 	depends on 8xx && (LWMON || IVMS8 || IVML24 || TQM8xxL) && IDE=y && BLK_DEV_IDE=y && !PPC_MERGE
 	help
 	  This option provides support for IDE on Motorola MPC8xx Systems.
Index: b/drivers/ide/Makefile
===================================================================
--- a/drivers/ide/Makefile
+++ b/drivers/ide/Makefile
@@ -7,41 +7,37 @@
 # Note : at this point, these files are compiled on all systems.
 # In the future, some of these should be built conditionally.
 #
-# First come modules that register themselves with the core
+# link order is important here
 
 EXTRA_CFLAGS				+= -Idrivers/ide
 
-obj-$(CONFIG_BLK_DEV_IDE)		+= pci/
-
 ide-core-y += ide.o ide-io.o ide-iops.o ide-lib.o ide-probe.o ide-taskfile.o
 
-ide-core-$(CONFIG_BLK_DEV_CMD640)	+= pci/cmd640.o
-
-# Core IDE code - must come before legacy
+# core IDE code
 ide-core-$(CONFIG_BLK_DEV_IDEPCI)	+= setup-pci.o
 ide-core-$(CONFIG_BLK_DEV_IDEDMA)	+= ide-dma.o
 ide-core-$(CONFIG_IDE_PROC_FS)		+= ide-proc.o
-ide-core-$(CONFIG_BLK_DEV_IDEPNP)	+= ide-pnp.o
 ide-core-$(CONFIG_BLK_DEV_IDEACPI)	+= ide-acpi.o
 
-# built-in only drivers from arm/
-ide-core-$(CONFIG_IDE_ARM)		+= arm/ide_arm.o
-
-# built-in only drivers from legacy/
-ide-core-$(CONFIG_BLK_DEV_BUDDHA)	+= legacy/buddha.o
-ide-core-$(CONFIG_BLK_DEV_FALCON_IDE)	+= legacy/falconide.o
-ide-core-$(CONFIG_BLK_DEV_GAYLE)	+= legacy/gayle.o
-ide-core-$(CONFIG_BLK_DEV_MAC_IDE)	+= legacy/macide.o
-ide-core-$(CONFIG_BLK_DEV_Q40IDE)	+= legacy/q40ide.o
-
-# built-in only drivers from ppc/
-ide-core-$(CONFIG_BLK_DEV_MPC8xx_IDE)	+= ppc/mpc8xx.o
-ide-core-$(CONFIG_BLK_DEV_IDE_PMAC)	+= ppc/pmac.o
-
-# built-in only drivers from h8300/
-ide-core-$(CONFIG_IDE_H8300)		+= h8300/ide-h8300.o
-
 obj-$(CONFIG_BLK_DEV_IDE)		+= ide-core.o
+
+ifeq ($(CONFIG_IDE_ARM), y)
+	ide-arm-core-y += arm/ide_arm.o
+	obj-y += ide-arm-core.o
+endif
+
+obj-$(CONFIG_BLK_DEV_IDE)		+= legacy/ pci/
+
+obj-$(CONFIG_IDEPCI_PCIBUS_ORDER)	+= ide-scan-pci.o
+
+ifeq ($(CONFIG_BLK_DEV_CMD640), y)
+	cmd640-core-y += pci/cmd640.o
+	obj-y += cmd640-core.o
+endif
+
+obj-$(CONFIG_BLK_DEV_IDE)		+= cris/ ppc/
+obj-$(CONFIG_BLK_DEV_IDEPNP)		+= ide-pnp.o
+obj-$(CONFIG_IDE_H8300)			+= h8300/
 obj-$(CONFIG_IDE_GENERIC)		+= ide-generic.o
 
 obj-$(CONFIG_BLK_DEV_IDEDISK)		+= ide-disk.o
@@ -49,6 +45,20 @@ obj-$(CONFIG_BLK_DEV_IDECD)		+= ide-cd.o
 obj-$(CONFIG_BLK_DEV_IDETAPE)		+= ide-tape.o
 obj-$(CONFIG_BLK_DEV_IDEFLOPPY)		+= ide-floppy.o
 
-obj-$(CONFIG_BLK_DEV_IDE)		+= legacy/ arm/ mips/
-obj-$(CONFIG_BLK_DEV_HD)		+= legacy/
-obj-$(CONFIG_ETRAX_IDE)		+= cris/
+ifeq ($(CONFIG_BLK_DEV_IDECS), y)
+	ide-cs-core-y += legacy/ide-cs.o
+	obj-y += ide-cs-core.o
+endif
+
+ifeq ($(CONFIG_BLK_DEV_PLATFORM), y)
+	ide-platform-core-y += legacy/ide_platform.o
+	obj-y += ide-platform-core.o
+endif
+
+obj-$(CONFIG_BLK_DEV_IDE)		+= arm/ mips/
+
+# old hd driver must be last
+ifeq ($(CONFIG_BLK_DEV_HD), y)
+	hd-core-y += legacy/hd.o
+	obj-y += hd-core.o
+endif
Index: b/drivers/ide/arm/Makefile
===================================================================
--- a/drivers/ide/arm/Makefile
+++ b/drivers/ide/arm/Makefile
@@ -3,4 +3,8 @@ obj-$(CONFIG_BLK_DEV_IDE_ICSIDE)	+= icsi
 obj-$(CONFIG_BLK_DEV_IDE_RAPIDE)	+= rapide.o
 obj-$(CONFIG_BLK_DEV_IDE_BAST)		+= bast-ide.o
 
+ifeq ($(CONFIG_IDE_ARM), m)
+	obj-m += ide_arm.o
+endif
+
 EXTRA_CFLAGS	:= -Idrivers/ide
Index: b/drivers/ide/arm/ide_arm.c
===================================================================
--- a/drivers/ide/arm/ide_arm.c
+++ b/drivers/ide/arm/ide_arm.c
@@ -24,7 +24,7 @@
 # define IDE_ARM_IRQ	IRQ_HARDDISK
 #endif
 
-void __init ide_arm_init(void)
+static int __init ide_arm_init(void)
 {
 	ide_hwif_t *hwif;
 	hw_regs_t hw;
@@ -41,4 +41,8 @@ void __init ide_arm_init(void)
 
 		ide_device_idx(idx);
 	}
+
+	return 0;
 }
+
+module_init(ide_arm_init);
Index: b/drivers/ide/cris/Makefile
===================================================================
--- a/drivers/ide/cris/Makefile
+++ b/drivers/ide/cris/Makefile
@@ -1,3 +1,3 @@
 EXTRA_CFLAGS				+= -Idrivers/ide
 
-obj-y					+= ide-cris.o
+obj-$(CONFIG_IDE_ETRAX)			+= ide-cris.o
Index: b/drivers/ide/cris/ide-cris.c
===================================================================
--- a/drivers/ide/cris/ide-cris.c
+++ b/drivers/ide/cris/ide-cris.c
@@ -754,8 +754,7 @@ static void cris_set_dma_mode(ide_drive_
 		cris_ide_set_speed(TYPE_DMA, 0, strobe, hold);
 }
 
-void __init
-init_e100_ide (void)
+static int __init init_e100_ide(void)
 {
 	hw_regs_t hw;
 	int ide_offsets[IDE_NR_PORTS], h, i;
@@ -823,6 +822,8 @@ init_e100_ide (void)
 	cris_ide_set_speed(TYPE_UDMA, ATA_UDMA2_CYC, ATA_UDMA2_DVS, 0);
 
 	ide_device_add(idx);
+
+	return 0;
 }
 
 static cris_dma_descr_type mydescr __attribute__ ((__aligned__(16)));
@@ -1056,3 +1057,5 @@ static void cris_dma_start(ide_drive_t *
 		LED_DISK_READ(1);
 	}
 }
+
+module_init(init_e100_ide);
Index: b/drivers/ide/h8300/Makefile
===================================================================
--- /dev/null
+++ b/drivers/ide/h8300/Makefile
@@ -0,0 +1,2 @@
+
+obj-$(CONFIG_IDE_H8300)			+= ide-h8300.o
Index: b/drivers/ide/h8300/ide-h8300.c
===================================================================
--- a/drivers/ide/h8300/ide-h8300.c
+++ b/drivers/ide/h8300/ide-h8300.c
@@ -84,7 +84,7 @@ static inline void hwif_setup(ide_hwif_t
 	hwif->INSL  = NULL;
 }
 
-void __init h8300_ide_init(void)
+static int __init h8300_ide_init(void)
 {
 	hw_regs_t hw;
 	ide_hwif_t *hwif;
@@ -104,7 +104,7 @@ void __init h8300_ide_init(void)
 	hwif = ide_find_port(hw.io_ports[IDE_DATA_OFFSET]);
 	if (hwif == NULL) {
 		printk(KERN_ERR "ide-h8300: IDE I/F register failed\n");
-		return;
+		return -ENOMEM;
 	}
 
 	index = hwif->index;
@@ -117,8 +117,12 @@ void __init h8300_ide_init(void)
 
 	ide_device_add(idx);
 
-	return;
+	return 0;
 
 out_busy:
 	printk(KERN_ERR "ide-h8300: IDE I/F resource already used.\n");
+
+	return -EBUSY;
 }
+
+module_init(h8300_ide_init);
Index: b/drivers/ide/ide-pnp.c
===================================================================
--- a/drivers/ide/ide-pnp.c
+++ b/drivers/ide/ide-pnp.c
@@ -75,12 +75,15 @@ static struct pnp_driver idepnp_driver =
 	.remove		= idepnp_remove,
 };
 
-void __init pnpide_init(void)
+static int __init pnpide_init(void)
 {
-	pnp_register_driver(&idepnp_driver);
+	return pnp_register_driver(&idepnp_driver);
 }
 
-void __exit pnpide_exit(void)
+static void __exit pnpide_exit(void)
 {
 	pnp_unregister_driver(&idepnp_driver);
 }
+
+module_init(pnpide_init);
+module_exit(pnpide_exit);
Index: b/drivers/ide/ide-scan-pci.c
===================================================================
--- /dev/null
+++ b/drivers/ide/ide-scan-pci.c
@@ -0,0 +1,11 @@
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/ide.h>
+
+static int __init ide_scan_pci(void)
+{
+	return ide_scan_pcibus();
+}
+
+module_init(ide_scan_pci);
Index: b/drivers/ide/ide.c
===================================================================
--- a/drivers/ide/ide.c
+++ b/drivers/ide/ide.c
@@ -95,7 +95,7 @@ DEFINE_MUTEX(ide_cfg_mtx);
  __cacheline_aligned_in_smp DEFINE_SPINLOCK(ide_lock);
 
 #ifdef CONFIG_IDEPCI_PCIBUS_ORDER
-static int ide_scan_direction; /* THIS was formerly 2.2.x pci=reverse */
+int ide_scan_direction; /* THIS was formerly 2.2.x pci=reverse */
 #endif
 
 int noautodma = 0;
@@ -178,8 +178,6 @@ static void init_hwif_default(ide_hwif_t
 #endif
 }
 
-extern void ide_arm_init(void);
-
 /*
  * init_ide_data() sets reasonable default values into all fields
  * of all instances of the hwifs and drives, but only on the first call.
@@ -1217,26 +1215,12 @@ static int __init match_parm (char *s, c
 	return 0;	/* zero = nothing matched */
 }
 
-#ifdef CONFIG_BLK_DEV_ALI14XX
 extern int probe_ali14xx;
-extern int ali14xx_init(void);
-#endif
-#ifdef CONFIG_BLK_DEV_UMC8672
 extern int probe_umc8672;
-extern int umc8672_init(void);
-#endif
-#ifdef CONFIG_BLK_DEV_DTC2278
 extern int probe_dtc2278;
-extern int dtc2278_init(void);
-#endif
-#ifdef CONFIG_BLK_DEV_HT6560B
 extern int probe_ht6560b;
-extern int ht6560b_init(void);
-#endif
-#ifdef CONFIG_BLK_DEV_QD65XX
 extern int probe_qd65xx;
-extern int qd65xx_init(void);
-#endif
+extern int cmd640_vlb;
 
 static int __initdata is_chipset_set[MAX_HWIFS];
 
@@ -1452,11 +1436,8 @@ static int __init ide_setup(char *s)
 #endif
 #ifdef CONFIG_BLK_DEV_CMD640
 			case -14: /* "cmd640_vlb" */
-			{
-				extern int cmd640_vlb; /* flag for cmd640.c */
 				cmd640_vlb = 1;
 				goto done;
-			}
 #endif
 #ifdef CONFIG_BLK_DEV_HT6560B
 			case -13: /* "ht6560b" */
@@ -1546,83 +1527,6 @@ done:
 	return 1;
 }
 
-extern void __init pnpide_init(void);
-extern void __exit pnpide_exit(void);
-extern void __init h8300_ide_init(void);
-extern void __init mpc8xx_ide_probe(void);
-
-/*
- * probe_for_hwifs() finds/initializes "known" IDE interfaces
- */
-static void __init probe_for_hwifs (void)
-{
-#ifdef CONFIG_IDEPCI_PCIBUS_ORDER
-	ide_scan_pcibus(ide_scan_direction);
-#endif
-
-#ifdef CONFIG_ETRAX_IDE
-	{
-		extern void init_e100_ide(void);
-		init_e100_ide();
-	}
-#endif /* CONFIG_ETRAX_IDE */
-#ifdef CONFIG_BLK_DEV_CMD640
-	{
-		extern void ide_probe_for_cmd640x(void);
-		ide_probe_for_cmd640x();
-	}
-#endif /* CONFIG_BLK_DEV_CMD640 */
-#ifdef CONFIG_BLK_DEV_IDE_PMAC
-	{
-		extern int pmac_ide_probe(void);
-		(void)pmac_ide_probe();
-	}
-#endif /* CONFIG_BLK_DEV_IDE_PMAC */
-#ifdef CONFIG_BLK_DEV_GAYLE
-	{
-		extern void gayle_init(void);
-		gayle_init();
-	}
-#endif /* CONFIG_BLK_DEV_GAYLE */
-#ifdef CONFIG_BLK_DEV_FALCON_IDE
-	{
-		extern void falconide_init(void);
-		falconide_init();
-	}
-#endif /* CONFIG_BLK_DEV_FALCON_IDE */
-#ifdef CONFIG_BLK_DEV_MAC_IDE
-	{
-		extern void macide_init(void);
-		macide_init();
-	}
-#endif /* CONFIG_BLK_DEV_MAC_IDE */
-#ifdef CONFIG_BLK_DEV_Q40IDE
-	{
-		extern void q40ide_init(void);
-		q40ide_init();
-	}
-#endif /* CONFIG_BLK_DEV_Q40IDE */
-#ifdef CONFIG_BLK_DEV_BUDDHA
-	{
-		extern void buddha_init(void);
-		buddha_init();
-	}
-#endif /* CONFIG_BLK_DEV_BUDDHA */
-#ifdef CONFIG_BLK_DEV_IDEPNP
-	pnpide_init();
-#endif
-#ifdef CONFIG_H8300
-	h8300_ide_init();
-#endif
-#ifdef BLK_DEV_MPC8xx_IDE
-	mpc8xx_ide_probe();
-#endif
-}
-
-/*
- * Probe module
- */
-
 EXPORT_SYMBOL(ide_lock);
 
 static int ide_bus_match(struct device *dev, struct device_driver *drv)
@@ -1745,33 +1649,6 @@ static int __init ide_init(void)
 
 	proc_ide_create();
 
-#ifdef CONFIG_IDE_ARM
-	ide_arm_init();
-#endif
-#ifdef CONFIG_BLK_DEV_ALI14XX
-	if (probe_ali14xx)
-		(void)ali14xx_init();
-#endif
-#ifdef CONFIG_BLK_DEV_UMC8672
-	if (probe_umc8672)
-		(void)umc8672_init();
-#endif
-#ifdef CONFIG_BLK_DEV_DTC2278
-	if (probe_dtc2278)
-		(void)dtc2278_init();
-#endif
-#ifdef CONFIG_BLK_DEV_HT6560B
-	if (probe_ht6560b)
-		(void)ht6560b_init();
-#endif
-#ifdef CONFIG_BLK_DEV_QD65XX
-	if (probe_qd65xx)
-		(void)qd65xx_init();
-#endif
-
-	/* Probe for special PCI and other "known" interface chipsets. */
-	probe_for_hwifs();
-
 	return 0;
 }
 
@@ -1807,10 +1684,6 @@ void __exit cleanup_module (void)
 	for (index = 0; index < MAX_HWIFS; ++index)
 		ide_unregister(index);
 
-#ifdef CONFIG_BLK_DEV_IDEPNP
-	pnpide_exit();
-#endif
-
 	proc_ide_destroy();
 
 	bus_unregister(&ide_bus_type);
Index: b/drivers/ide/legacy/Makefile
===================================================================
--- a/drivers/ide/legacy/Makefile
+++ b/drivers/ide/legacy/Makefile
@@ -1,15 +1,24 @@
 
+# link order is important here
+
 obj-$(CONFIG_BLK_DEV_ALI14XX)		+= ali14xx.o
+obj-$(CONFIG_BLK_DEV_UMC8672)		+= umc8672.o
 obj-$(CONFIG_BLK_DEV_DTC2278)		+= dtc2278.o
 obj-$(CONFIG_BLK_DEV_HT6560B)		+= ht6560b.o
 obj-$(CONFIG_BLK_DEV_QD65XX)		+= qd65xx.o
-obj-$(CONFIG_BLK_DEV_UMC8672)		+= umc8672.o
 
-obj-$(CONFIG_BLK_DEV_IDECS)		+= ide-cs.o
+obj-$(CONFIG_BLK_DEV_GAYLE)		+= gayle.o
+obj-$(CONFIG_BLK_DEV_FALCON_IDE)	+= falconide.o
+obj-$(CONFIG_BLK_DEV_MAC_IDE)		+= macide.o
+obj-$(CONFIG_BLK_DEV_Q40IDE)		+= q40ide.o
+obj-$(CONFIG_BLK_DEV_BUDDHA)		+= buddha.o
 
-obj-$(CONFIG_BLK_DEV_PLATFORM)		+= ide_platform.o
+ifeq ($(CONFIG_BLK_DEV_IDECS), m)
+	obj-m += ide-cs.o
+endif
 
-# Last of all
-obj-$(CONFIG_BLK_DEV_HD)		+= hd.o
+ifeq ($(CONFIG_BLK_DEV_PLATFORM), m)
+	obj-m += ide_platform.o
+endif
 
 EXTRA_CFLAGS	:= -Idrivers/ide
Index: b/drivers/ide/legacy/ali14xx.c
===================================================================
--- a/drivers/ide/legacy/ali14xx.c
+++ b/drivers/ide/legacy/ali14xx.c
@@ -230,8 +230,7 @@ int probe_ali14xx = 0;
 module_param_named(probe, probe_ali14xx, bool, 0);
 MODULE_PARM_DESC(probe, "probe for ALI M14xx chipsets");
 
-/* Can be called directly from ide.c. */
-int __init ali14xx_init(void)
+static int __init ali14xx_init(void)
 {
 	if (probe_ali14xx == 0)
 		goto out;
@@ -247,9 +246,7 @@ out:
 	return -ENODEV;
 }
 
-#ifdef MODULE
 module_init(ali14xx_init);
-#endif
 
 MODULE_AUTHOR("see local file");
 MODULE_DESCRIPTION("support of ALI 14XX IDE chipsets");
Index: b/drivers/ide/legacy/buddha.c
===================================================================
--- a/drivers/ide/legacy/buddha.c
+++ b/drivers/ide/legacy/buddha.c
@@ -143,7 +143,7 @@ static int xsurf_ack_intr(ide_hwif_t *hw
      *  Probe for a Buddha or Catweasel IDE interface
      */
 
-void __init buddha_init(void)
+static int __init buddha_init(void)
 {
 	hw_regs_t hw;
 	ide_hwif_t *hwif;
@@ -243,4 +243,8 @@ fail_base2:
 
 		ide_device_add(idx);
 	}
+
+	return 0;
 }
+
+module_init(buddha_init);
Index: b/drivers/ide/legacy/dtc2278.c
===================================================================
--- a/drivers/ide/legacy/dtc2278.c
+++ b/drivers/ide/legacy/dtc2278.c
@@ -150,8 +150,7 @@ int probe_dtc2278 = 0;
 module_param_named(probe, probe_dtc2278, bool, 0);
 MODULE_PARM_DESC(probe, "probe for DTC2278xx chipsets");
 
-/* Can be called directly from ide.c. */
-int __init dtc2278_init(void)
+static int __init dtc2278_init(void)
 {
 	if (probe_dtc2278 == 0)
 		return -ENODEV;
@@ -163,9 +162,7 @@ int __init dtc2278_init(void)
 	return 0;
 }
 
-#ifdef MODULE
 module_init(dtc2278_init);
-#endif
 
 MODULE_AUTHOR("See Local File");
 MODULE_DESCRIPTION("support of DTC-2278 VLB IDE chipsets");
Index: b/drivers/ide/legacy/falconide.c
===================================================================
--- a/drivers/ide/legacy/falconide.c
+++ b/drivers/ide/legacy/falconide.c
@@ -62,7 +62,7 @@ EXPORT_SYMBOL(falconide_intr_lock);
      *  Probe for a Falcon IDE interface
      */
 
-void __init falconide_init(void)
+static int __init falconide_init(void)
 {
     if (MACH_IS_ATARI && ATARIHW_PRESENT(IDE)) {
 	hw_regs_t hw;
@@ -84,4 +84,9 @@ void __init falconide_init(void)
 
 		ide_device_add(idx);
 	}
+    }
+
+    return 0;
 }
+
+module_init(falconide_init);
Index: b/drivers/ide/legacy/gayle.c
===================================================================
--- a/drivers/ide/legacy/gayle.c
+++ b/drivers/ide/legacy/gayle.c
@@ -110,13 +110,13 @@ static int gayle_ack_intr_a1200(ide_hwif
      *  Probe for a Gayle IDE interface (and optionally for an IDE doubler)
      */
 
-void __init gayle_init(void)
+static int __init gayle_init(void)
 {
     int a4000, i;
     u8 idx[4] = { 0xff, 0xff, 0xff, 0xff };
 
     if (!MACH_IS_AMIGA)
-	return;
+	return -ENODEV;
 
     if ((a4000 = AMIGAHW_PRESENT(A4000_IDE)) || AMIGAHW_PRESENT(A1200_IDE))
 	goto found;
@@ -126,7 +126,7 @@ void __init gayle_init(void)
 			  NULL))
 	goto found;
 #endif
-    return;
+    return -ENODEV;
 
 found:
     for (i = 0; i < GAYLE_NUM_PROBE_HWIFS; i++) {
@@ -191,4 +191,8 @@ found:
     }
 
     ide_device_add(idx);
+
+    return 0;
 }
+
+module_init(gayle_init);
Index: b/drivers/ide/legacy/ht6560b.c
===================================================================
--- a/drivers/ide/legacy/ht6560b.c
+++ b/drivers/ide/legacy/ht6560b.c
@@ -307,8 +307,7 @@ int probe_ht6560b = 0;
 module_param_named(probe, probe_ht6560b, bool, 0);
 MODULE_PARM_DESC(probe, "probe for HT6560B chipset");
 
-/* Can be called directly from ide.c. */
-int __init ht6560b_init(void)
+static int __init ht6560b_init(void)
 {
 	ide_hwif_t *hwif, *mate;
 	static u8 idx[4] = { 0, 1, 0xff, 0xff };
@@ -369,9 +368,7 @@ release_region:
 	return -ENODEV;
 }
 
-#ifdef MODULE
 module_init(ht6560b_init);
-#endif
 
 MODULE_AUTHOR("See Local File");
 MODULE_DESCRIPTION("HT-6560B EIDE-controller support");
Index: b/drivers/ide/legacy/macide.c
===================================================================
--- a/drivers/ide/legacy/macide.c
+++ b/drivers/ide/legacy/macide.c
@@ -81,7 +81,7 @@ int macide_ack_intr(ide_hwif_t* hwif)
  * Probe for a Macintosh IDE interface
  */
 
-void __init macide_init(void)
+static int __init macide_init(void)
 {
 	hw_regs_t hw;
 	ide_hwif_t *hwif;
@@ -106,7 +106,7 @@ void __init macide_init(void)
 				IRQ_BABOON_1);
 		break;
 	default:
-		return;
+		return -ENODEV;
 	}
 
 	hwif = ide_find_port(hw.io_ports[IDE_DATA_OFFSET]);
@@ -139,4 +139,8 @@ void __init macide_init(void)
 
 		ide_device_add(idx);
 	}
+
+	return 0;
 }
+
+module_init(macide_init);
Index: b/drivers/ide/legacy/q40ide.c
===================================================================
--- a/drivers/ide/legacy/q40ide.c
+++ b/drivers/ide/legacy/q40ide.c
@@ -111,7 +111,7 @@ static const char *q40_ide_names[Q40IDE_
  *  Probe for Q40 IDE interfaces
  */
 
-void __init q40ide_init(void)
+static int __init q40ide_init(void)
 {
     int i;
     ide_hwif_t *hwif;
@@ -119,7 +119,7 @@ void __init q40ide_init(void)
     u8 idx[4] = { 0xff, 0xff, 0xff, 0xff };
 
     if (!MACH_IS_Q40)
-      return ;
+      return -ENODEV;
 
     for (i = 0; i < Q40IDE_NUM_HWIFS; i++) {
 	hw_regs_t hw;
@@ -153,5 +153,8 @@ void __init q40ide_init(void)
     }
 
     ide_device_add(idx);
+
+    return 0;
 }
 
+module_init(q40ide_init);
Index: b/drivers/ide/legacy/qd65xx.c
===================================================================
--- a/drivers/ide/legacy/qd65xx.c
+++ b/drivers/ide/legacy/qd65xx.c
@@ -478,8 +478,7 @@ int probe_qd65xx = 0;
 module_param_named(probe, probe_qd65xx, bool, 0);
 MODULE_PARM_DESC(probe, "probe for QD65xx chipsets");
 
-/* Can be called directly from ide.c. */
-int __init qd65xx_init(void)
+static int __init qd65xx_init(void)
 {
 	if (probe_qd65xx == 0)
 		return -ENODEV;
@@ -492,9 +491,7 @@ int __init qd65xx_init(void)
 	return 0;
 }
 
-#ifdef MODULE
 module_init(qd65xx_init);
-#endif
 
 MODULE_AUTHOR("Samuel Thibault");
 MODULE_DESCRIPTION("support of qd65xx vlb ide chipset");
Index: b/drivers/ide/legacy/umc8672.c
===================================================================
--- a/drivers/ide/legacy/umc8672.c
+++ b/drivers/ide/legacy/umc8672.c
@@ -169,8 +169,7 @@ int probe_umc8672 = 0;
 module_param_named(probe, probe_umc8672, bool, 0);
 MODULE_PARM_DESC(probe, "probe for UMC8672 chipset");
 
-/* Can be called directly from ide.c. */
-int __init umc8672_init(void)
+static int __init umc8672_init(void)
 {
 	if (probe_umc8672 == 0)
 		goto out;
@@ -181,9 +180,7 @@ out:
 	return -ENODEV;;
 }
 
-#ifdef MODULE
 module_init(umc8672_init);
-#endif
 
 MODULE_AUTHOR("Wolfram Podien");
 MODULE_DESCRIPTION("Support for UMC 8672 IDE chipset");
Index: b/drivers/ide/pci/Makefile
===================================================================
--- a/drivers/ide/pci/Makefile
+++ b/drivers/ide/pci/Makefile
@@ -36,4 +36,8 @@ obj-$(CONFIG_BLK_DEV_VIA82CXXX)		+= via8
 # Must appear at the end of the block
 obj-$(CONFIG_BLK_DEV_GENERIC)          += generic.o
 
+ifeq ($(CONFIG_BLK_DEV_CMD640), m)
+	obj-m += cmd640.o
+endif
+
 EXTRA_CFLAGS	:= -Idrivers/ide
Index: b/drivers/ide/pci/cmd640.c
===================================================================
--- a/drivers/ide/pci/cmd640.c
+++ b/drivers/ide/pci/cmd640.c
@@ -706,9 +706,9 @@ static int pci_conf2(void)
 }
 
 /*
- * Probe for a cmd640 chipset, and initialize it if found.  Called from ide.c
+ * Probe for a cmd640 chipset, and initialize it if found.
  */
-int __init ide_probe_for_cmd640x (void)
+static int __init cmd640x_init(void)
 {
 #ifdef CONFIG_BLK_DEV_CMD640_ENHANCED
 	int second_port_toggled = 0;
@@ -883,3 +883,7 @@ int __init ide_probe_for_cmd640x (void)
 	return 1;
 }
 
+module_param_named(probe_vlb, cmd640_vlb, bool, 0);
+MODULE_PARM_DESC(probe, "probe for VLB version of CMD640 chipset");
+
+module_init(cmd640x_init);
Index: b/drivers/ide/ppc/Makefile
===================================================================
--- /dev/null
+++ b/drivers/ide/ppc/Makefile
@@ -0,0 +1,3 @@
+
+obj-$(CONFIG_BLK_DEV_IDE_PMAC)		+= pmac.o
+obj-$(CONFIG_BLK_DEV_MPC8xx_IDE)	+= mpc8xx.o
Index: b/drivers/ide/ppc/mpc8xx.c
===================================================================
--- a/drivers/ide/ppc/mpc8xx.c
+++ b/drivers/ide/ppc/mpc8xx.c
@@ -839,7 +839,7 @@ void m8xx_ide_init(void)
 	ppc_ide_md.ide_init_hwif        = m8xx_ide_init_hwif_ports;
 }
 
-void __init mpc8xx_ide_probe(void)
+static int __init mpc8xx_ide_probe(void)
 {
 	u8 idx[4] = { 0xff, 0xff, 0xff, 0xff };
 
@@ -851,4 +851,8 @@ void __init mpc8xx_ide_probe(void)
 #endif
 
 	ide_device_add(idx);
+
+	return 0;
 }
+
+module_init(mpc8xx_ide_probe);
Index: b/drivers/ide/ppc/pmac.c
===================================================================
--- a/drivers/ide/ppc/pmac.c
+++ b/drivers/ide/ppc/pmac.c
@@ -1786,3 +1786,5 @@ pmac_ide_setup_dma(pmac_ide_hwif_t *pmif
 }
 
 #endif /* CONFIG_BLK_DEV_IDEDMA_PMAC */
+
+module_init(pmac_ide_probe);
Index: b/drivers/ide/setup-pci.c
===================================================================
--- a/drivers/ide/setup-pci.c
+++ b/drivers/ide/setup-pci.c
@@ -766,21 +766,20 @@ static int __init ide_scan_pcidev(struct
 
 /**
  *	ide_scan_pcibus		-	perform the initial IDE driver scan
- *	@scan_direction: set for reverse order scanning
  *
  *	Perform the initial bus rather than driver ordered scan of the
  *	PCI drivers. After this all IDE pci handling becomes standard
  *	module ordering not traditionally ordered.
  */
- 	
-void __init ide_scan_pcibus (int scan_direction)
+
+int __init ide_scan_pcibus(void)
 {
 	struct pci_dev *dev = NULL;
 	struct pci_driver *d;
 	struct list_head *l, *n;
 
 	pre_init = 0;
-	if (!scan_direction)
+	if (!ide_scan_direction)
 		while ((dev = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, dev)) != NULL)
 			ide_scan_pcidev(dev);
 	else
@@ -800,5 +799,7 @@ void __init ide_scan_pcibus (int scan_di
 			printk(KERN_ERR "%s: failed to register driver for %s\n",
 			       __FUNCTION__, d->driver.mod_name);
 	}
+
+	return 0;
 }
 #endif
Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -1014,7 +1014,8 @@ extern void do_ide_request(struct reques
 void ide_init_disk(struct gendisk *, ide_drive_t *);
 
 #ifdef CONFIG_IDEPCI_PCIBUS_ORDER
-extern void ide_scan_pcibus(int scan_direction) __init;
+extern int ide_scan_direction;
+int __init ide_scan_pcibus(void);
 extern int __ide_pci_register_driver(struct pci_driver *driver, struct module *owner, const char *mod_name);
 #define ide_pci_register_driver(d) __ide_pci_register_driver(d, THIS_MODULE, KBUILD_MODNAME)
 #else
