From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 20/21] ide: fix host drivers depending on ide_generic to probe for interfaces
Date: Sun, 18 Nov 2007 23:41:27 +0100
Message-ID: <200711182341.27444.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.174]:49114 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753202AbXKRWgx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 18 Nov 2007 17:36:53 -0500
Received: by ug-out-1314.google.com with SMTP id z38so873065ugc
        for <linux-ide@vger.kernel.org>; Sun, 18 Nov 2007 14:36:51 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Mikael Starvik <starvik@axis.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Roman Zippel <zippel@linux-m68k.org>


* Add mpc8xx_ide_probe() to mpc8xx.c and call it from probe_for_hwifs().

* Convert ide_arm, ide-cris, ide-h8300, ide-pnp, buddha, falconide, gayle,
  macide, q40ide, cmd640 and mpc8xx host drivers to use ide_device_add().

  This removes dependency on ide_generic for these drivers so update
  ide/Kconfig accordingly.

Cc: Mikael Starvik <starvik@axis.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Roman Zippel <zippel@linux-m68k.org>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/Kconfig            |   11 -----------
 drivers/ide/arm/ide_arm.c      |    4 ++++
 drivers/ide/cris/ide-cris.c    |    9 ++++++---
 drivers/ide/h8300/ide-h8300.c  |    6 ++++++
 drivers/ide/ide-pnp.c          |    4 ++++
 drivers/ide/ide.c              |    4 ++++
 drivers/ide/legacy/buddha.c    |   10 ++++++++--
 drivers/ide/legacy/falconide.c |    3 +++
 drivers/ide/legacy/gayle.c     |    5 +++++
 drivers/ide/legacy/macide.c    |    3 +++
 drivers/ide/legacy/q40ide.c    |    5 +++++
 drivers/ide/pci/cmd640.c       |    8 ++++++++
 drivers/ide/ppc/mpc8xx.c       |   14 ++++++++++++++
 13 files changed, 70 insertions(+), 16 deletions(-)

Index: b/drivers/ide/Kconfig
===================================================================
--- a/drivers/ide/Kconfig
+++ b/drivers/ide/Kconfig
@@ -327,7 +327,6 @@ config BLK_DEV_PLATFORM
 config BLK_DEV_CMD640
 	bool "CMD640 chipset bugfix/support"
 	depends on X86
-	select IDE_GENERIC
 	---help---
 	  The CMD-Technologies CMD640 IDE chip is used on many common 486 and
 	  Pentium motherboards, usually in combination with a "Neptune" or
@@ -362,7 +361,6 @@ config BLK_DEV_CMD640_ENHANCED
 config BLK_DEV_IDEPNP
 	bool "PNP EIDE support"
 	depends on PNP
-	select IDE_GENERIC
 	help
 	  If you have a PnP (Plug and Play) compatible EIDE card and
 	  would like the kernel to automatically detect and activate
@@ -840,7 +838,6 @@ config BLK_DEV_IDE_AU1XXX_SEQTS_PER_RQ
 
 config IDE_ARM
 	def_bool ARM && (ARCH_CLPS7500 || ARCH_RPC || ARCH_SHARK)
-	select IDE_GENERIC
 
 config BLK_DEV_IDE_ICSIDE
 	tristate "ICS IDE interface support"
@@ -875,7 +872,6 @@ config ETRAX_IDE
 	bool "ETRAX IDE support"
 	depends on CRIS && BROKEN
 	select BLK_DEV_IDEDMA
-	select IDE_GENERIC
 	help
 	  Enables the ETRAX IDE driver.
 
@@ -909,7 +905,6 @@ endchoice
 config IDE_H8300
 	bool "H8300 IDE support"
 	depends on H8300
-	select IDE_GENERIC
 	default y
 	help
 	  Enables the H8300 IDE driver.
@@ -917,7 +912,6 @@ config IDE_H8300
 config BLK_DEV_GAYLE
 	bool "Amiga Gayle IDE interface support"
 	depends on AMIGA
-	select IDE_GENERIC
 	help
 	  This is the IDE driver for the Amiga Gayle IDE interface. It supports
 	  both the `A1200 style' and `A4000 style' of the Gayle IDE interface,
@@ -949,7 +943,6 @@ config BLK_DEV_IDEDOUBLER
 config BLK_DEV_BUDDHA
 	bool "Buddha/Catweasel/X-Surf IDE interface support (EXPERIMENTAL)"
 	depends on ZORRO && EXPERIMENTAL
-	select IDE_GENERIC
 	help
 	  This is the IDE driver for the IDE interfaces on the Buddha, 
 	  Catweasel and X-Surf expansion boards.  It supports up to two interfaces 
@@ -962,7 +955,6 @@ config BLK_DEV_BUDDHA
 config BLK_DEV_FALCON_IDE
 	bool "Falcon IDE interface support"
 	depends on ATARI
-	select IDE_GENERIC
 	help
 	  This is the IDE driver for the builtin IDE interface on the Atari
 	  Falcon. Say Y if you have a Falcon and want to use IDE devices (hard
@@ -972,7 +964,6 @@ config BLK_DEV_FALCON_IDE
 config BLK_DEV_MAC_IDE
 	bool "Macintosh Quadra/Powerbook IDE interface support"
 	depends on MAC
-	select IDE_GENERIC
 	help
 	  This is the IDE driver for the builtin IDE interface on some m68k
 	  Macintosh models. It supports both the `Quadra style' (used in
@@ -986,7 +977,6 @@ config BLK_DEV_MAC_IDE
 config BLK_DEV_Q40IDE
 	bool "Q40/Q60 IDE interface support"
 	depends on Q40
-	select IDE_GENERIC
 	help
 	  Enable the on-board IDE controller in the Q40/Q60.  This should
 	  normally be on; disable it only if you are running a custom hard
@@ -995,7 +985,6 @@ config BLK_DEV_Q40IDE
 config BLK_DEV_MPC8xx_IDE
 	bool "MPC8xx IDE support"
 	depends on 8xx && (LWMON || IVMS8 || IVML24 || TQM8xxL) && IDE=y && BLK_DEV_IDE=y && !PPC_MERGE
-	select IDE_GENERIC
 	help
 	  This option provides support for IDE on Motorola MPC8xx Systems.
 	  Please see 'Type of MPC8xx IDE interface' for details.
Index: b/drivers/ide/arm/ide_arm.c
===================================================================
--- a/drivers/ide/arm/ide_arm.c
+++ b/drivers/ide/arm/ide_arm.c
@@ -28,6 +28,7 @@ void __init ide_arm_init(void)
 {
 	ide_hwif_t *hwif;
 	hw_regs_t hw;
+	u8 idx[4] = { 0xff, 0xff, 0xff, 0xff };
 
 	memset(&hw, 0, sizeof(hw));
 	ide_std_init_ports(&hw, IDE_ARM_IO, IDE_ARM_IO + 0x206);
@@ -36,5 +37,8 @@ void __init ide_arm_init(void)
 	hwif = ide_find_port(hw.io_ports[IDE_DATA_OFFSET]);
 	if (hwif) {
 		ide_init_port_hw(hwif, &hw);
+		idx[0] = hwif->index;
+
+		ide_device_idx(idx);
 	}
 }
Index: b/drivers/ide/cris/ide-cris.c
===================================================================
--- a/drivers/ide/cris/ide-cris.c
+++ b/drivers/ide/cris/ide-cris.c
@@ -758,9 +758,8 @@ void __init
 init_e100_ide (void)
 {
 	hw_regs_t hw;
-	int ide_offsets[IDE_NR_PORTS];
-	int h;
-	int i;
+	int ide_offsets[IDE_NR_PORTS], h, i;
+	u8 idx[4] = { 0xff, 0xff, 0xff, 0xff };
 
 	printk("ide: ETRAX FS built-in ATA DMA controller\n");
 
@@ -808,6 +807,8 @@ init_e100_ide (void)
 		hwif->drives[1].autotune = 1;
 		hwif->ultra_mask = cris_ultra_mask;
 		hwif->mwdma_mask = 0x07; /* Multiword DMA 0-2 */
+
+		idx[h] = hwif->index;
 	}
 
 	/* Reset pulse */
@@ -820,6 +821,8 @@ init_e100_ide (void)
 	cris_ide_set_speed(TYPE_PIO, ATA_PIO4_SETUP, ATA_PIO4_STROBE, ATA_PIO4_HOLD);
 	cris_ide_set_speed(TYPE_DMA, 0, ATA_DMA2_STROBE, ATA_DMA2_HOLD);
 	cris_ide_set_speed(TYPE_UDMA, ATA_UDMA2_CYC, ATA_UDMA2_DVS, 0);
+
+	ide_device_add(idx);
 }
 
 static cris_dma_descr_type mydescr __attribute__ ((__aligned__(16)));
Index: b/drivers/ide/h8300/ide-h8300.c
===================================================================
--- a/drivers/ide/h8300/ide-h8300.c
+++ b/drivers/ide/h8300/ide-h8300.c
@@ -89,6 +89,7 @@ void __init h8300_ide_init(void)
 	hw_regs_t hw;
 	ide_hwif_t *hwif;
 	int index;
+	u8 idx[4] = { 0xff, 0xff, 0xff, 0xff };
 
 	if (!request_region(CONFIG_H8300_IDE_BASE, H8300_IDE_GAP*8, "ide-h8300"))
 		goto out_busy;
@@ -111,6 +112,11 @@ void __init h8300_ide_init(void)
 	ide_init_port_hw(hwif, &hw);
 	hwif_setup(hwif);
 	printk(KERN_INFO "ide%d: H8/300 generic IDE interface\n", index);
+
+	idx[0] = index;
+
+	ide_device_add(idx);
+
 	return;
 
 out_busy:
Index: b/drivers/ide/ide-pnp.c
===================================================================
--- a/drivers/ide/ide-pnp.c
+++ b/drivers/ide/ide-pnp.c
@@ -43,12 +43,16 @@ static int idepnp_probe(struct pnp_dev *
 	hwif = ide_find_port(hw.io_ports[IDE_DATA_OFFSET]);
 	if (hwif) {
 		u8 index = hwif->index;
+		u8 idx[4] = { index, 0xff, 0xff, 0xff };
 
 		ide_init_port_data(hwif, index);
 		ide_init_port_hw(hwif, &hw);
 
 		printk(KERN_INFO "ide%d: generic PnP IDE interface\n", index);
 		pnp_set_drvdata(dev,hwif);
+
+		ide_device_add(idx);
+
 		return 0;
 	}
 
Index: b/drivers/ide/ide.c
===================================================================
--- a/drivers/ide/ide.c
+++ b/drivers/ide/ide.c
@@ -1549,6 +1549,7 @@ done:
 extern void __init pnpide_init(void);
 extern void __exit pnpide_exit(void);
 extern void __init h8300_ide_init(void);
+extern void __init mpc8xx_ide_probe(void);
 
 /*
  * probe_for_hwifs() finds/initializes "known" IDE interfaces
@@ -1613,6 +1614,9 @@ static void __init probe_for_hwifs (void
 #ifdef CONFIG_H8300
 	h8300_ide_init();
 #endif
+#ifdef BLK_DEV_MPC8xx_IDE
+	mpc8xx_ide_probe();
+#endif
 }
 
 /*
Index: b/drivers/ide/legacy/buddha.c
===================================================================
--- a/drivers/ide/legacy/buddha.c
+++ b/drivers/ide/legacy/buddha.c
@@ -156,6 +156,8 @@ void __init buddha_init(void)
 
 	while ((z = zorro_find_device(ZORRO_WILDCARD, z))) {
 		unsigned long board;
+		u8 idx[4] = { 0xff, 0xff, 0xff, 0xff };
+
 		if (z->id == ZORRO_PROD_INDIVIDUAL_COMPUTERS_BUDDHA) {
 			buddha_num_hwifs = BUDDHA_NUM_HWIFS;
 			type=BOARD_BUDDHA;
@@ -233,8 +235,12 @@ fail_base2:
 					printk("X-Surf");
 					break;
 				}
-				printk(" IDE interface\n");	    
-			}		      
+				printk(" IDE interface\n");
+
+				idx[i] = index;
+			}
 		}
+
+		ide_device_add(idx);
 	}
 }
Index: b/drivers/ide/legacy/falconide.c
===================================================================
--- a/drivers/ide/legacy/falconide.c
+++ b/drivers/ide/legacy/falconide.c
@@ -75,10 +75,13 @@ void __init falconide_init(void)
 	hwif = ide_find_port(hw.io_ports[IDE_DATA_OFFSET]);
 	if (hwif) {
 		u8 index = hwif->index;
+		u8 idx[4] = { index, 0xff, 0xff, 0xff };
 
 		ide_init_port_data(hwif, index);
 		ide_init_port_hw(hwif, &hw);
 
 		printk("ide%d: Falcon IDE interface\n", index);
+
+		ide_device_add(idx);
 	}
 }
Index: b/drivers/ide/legacy/gayle.c
===================================================================
--- a/drivers/ide/legacy/gayle.c
+++ b/drivers/ide/legacy/gayle.c
@@ -113,6 +113,7 @@ static int gayle_ack_intr_a1200(ide_hwif
 void __init gayle_init(void)
 {
     int a4000, i;
+    u8 idx[4] = { 0xff, 0xff, 0xff, 0xff };
 
     if (!MACH_IS_AMIGA)
 	return;
@@ -183,7 +184,11 @@ found:
 		    break;
 #endif /* CONFIG_BLK_DEV_IDEDOUBLER */
 	    }
+
+	    idx[i] = index;
 	} else
 	    release_mem_region(res_start, res_n);
     }
+
+    ide_device_add(idx);
 }
Index: b/drivers/ide/legacy/macide.c
===================================================================
--- a/drivers/ide/legacy/macide.c
+++ b/drivers/ide/legacy/macide.c
@@ -112,6 +112,7 @@ void __init macide_init(void)
 	hwif = ide_find_port(hw.io_ports[IDE_DATA_OFFSET]);
 	if (hwif) {
 		u8 index = hwif->index;
+		u8 idx[4] = { index, 0xff, 0xff, 0xff };
 
 		ide_init_port_data(hwif, index);
 		ide_init_port_hw(hwif, &hw);
@@ -135,5 +136,7 @@ void __init macide_init(void)
 			printk(KERN_INFO "ide%d: Macintosh Powerbook Baboon IDE interface\n", index);
 		else
 			printk(KERN_INFO "ide%d: Unknown Macintosh IDE interface\n", index);
+
+		ide_device_add(idx);
 	}
 }
Index: b/drivers/ide/legacy/q40ide.c
===================================================================
--- a/drivers/ide/legacy/q40ide.c
+++ b/drivers/ide/legacy/q40ide.c
@@ -116,6 +116,7 @@ void __init q40ide_init(void)
     int i;
     ide_hwif_t *hwif;
     const char *name;
+    u8 idx[4] = { 0xff, 0xff, 0xff, 0xff };
 
     if (!MACH_IS_Q40)
       return ;
@@ -146,7 +147,11 @@ void __init q40ide_init(void)
 		ide_init_port_data(hwif, hwif->index);
 		ide_init_port_hw(hwif, &hw);
 		hwif->mmio = 1;
+
+		idx[i] = hwif->index;
 	}
     }
+
+    ide_device_add(idx);
 }
 
Index: b/drivers/ide/pci/cmd640.c
===================================================================
--- a/drivers/ide/pci/cmd640.c
+++ b/drivers/ide/pci/cmd640.c
@@ -717,6 +717,7 @@ int __init ide_probe_for_cmd640x (void)
 	const char *bus_type, *port2;
 	unsigned int index;
 	u8 b, cfr;
+	u8 idx[4] = { 0xff, 0xff, 0xff, 0xff };
 
 	if (cmd640_vlb && probe_for_cmd640_vlb()) {
 		bus_type = "VLB";
@@ -769,6 +770,8 @@ int __init ide_probe_for_cmd640x (void)
 	cmd_hwif0->set_pio_mode = &cmd640_set_pio_mode;
 #endif /* CONFIG_BLK_DEV_CMD640_ENHANCED */
 
+	idx[0] = cmd_hwif0->index;
+
 	/*
 	 * Ensure compatibility by always using the slowest timings
 	 * for access to the drive's command register block,
@@ -826,6 +829,8 @@ int __init ide_probe_for_cmd640x (void)
 		cmd_hwif1->pio_mask = ATA_PIO5;
 		cmd_hwif1->set_pio_mode = &cmd640_set_pio_mode;
 #endif /* CONFIG_BLK_DEV_CMD640_ENHANCED */
+
+		idx[1] = cmd_hwif1->index;
 	}
 	printk(KERN_INFO "%s: %sserialized, secondary interface %s\n", cmd_hwif1->name,
 		cmd_hwif0->serialized ? "" : "not ", port2);
@@ -872,6 +877,9 @@ int __init ide_probe_for_cmd640x (void)
 #ifdef CMD640_DUMP_REGS
 	cmd640_dump_regs();
 #endif
+
+	ide_device_add(idx);
+
 	return 1;
 }
 
Index: b/drivers/ide/ppc/mpc8xx.c
===================================================================
--- a/drivers/ide/ppc/mpc8xx.c
+++ b/drivers/ide/ppc/mpc8xx.c
@@ -838,3 +838,17 @@ void m8xx_ide_init(void)
 	ppc_ide_md.default_io_base      = m8xx_ide_default_io_base;
 	ppc_ide_md.ide_init_hwif        = m8xx_ide_init_hwif_ports;
 }
+
+void __init mpc8xx_ide_probe(void)
+{
+	u8 idx[4] = { 0xff, 0xff, 0xff, 0xff };
+
+#ifdef IDE0_BASE_OFFSET
+	idx[0] = 0;
+#ifdef IDE1_BASE_OFFSET
+	idx[1] = 1;
+#endif
+#endif
+
+	ide_device_add(idx);
+}
