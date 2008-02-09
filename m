From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH] ide: introduce CONFIG_BLK_DEV_IDEDMA_SFF option
Date: Sat, 9 Feb 2008 20:33:59 +0300
Message-ID: <200802092033.59852.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtsoft3.corbina.net ([85.21.88.6]:64218 "EHLO
	buildserver.ru.mvista.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754854AbYBIRdL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 9 Feb 2008 12:33:11 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com, asalnikov@ru.mvista.com
Cc: linux-ide@vger.kernel.org

Introduce new option CONFIG_BLK_DEV_IDEDMA_SFF for non-PCI SFF-8038i compatible
bus mastering IDE controllers (which there are a few known), thus fixing a hack
made for Palmchip BK3710 controller...

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
Bart, did you mean something like that?
Anton, make sure it works, just in case... :-)

 drivers/ide/Kconfig   |    9 +++++++--
 drivers/ide/ide-dma.c |   14 +++++++-------
 include/linux/ide.h   |    9 ++++-----
 3 files changed, 18 insertions(+), 14 deletions(-)

Index: linux-2.6/drivers/ide/Kconfig
===================================================================
--- linux-2.6.orig/drivers/ide/Kconfig
+++ linux-2.6/drivers/ide/Kconfig
@@ -374,6 +374,9 @@ config BLK_DEV_IDEPNP
 	  would like the kernel to automatically detect and activate
 	  it, say Y here.
 
+config BLK_DEV_IDEDMA_SFF
+	bool
+
 if PCI
 
 comment "PCI IDE chipsets support"
@@ -455,6 +458,7 @@ config BLK_DEV_RZ1000
 config BLK_DEV_IDEDMA_PCI
 	bool
 	select BLK_DEV_IDEPCI
+	select BLK_DEV_IDEDMA_SFF
 
 config BLK_DEV_AEC62XX
 	tristate "AEC62XX chipset support"
@@ -1012,7 +1016,7 @@ config BLK_DEV_Q40IDE
 config BLK_DEV_PALMCHIP_BK3710
 	tristate "Palmchip bk3710 IDE controller support"
 	depends on ARCH_DAVINCI
-	select BLK_DEV_IDEDMA_PCI
+	select BLK_DEV_IDEDMA_SFF
 	help
 	  Say Y here if you want to support the onchip IDE controller on the
 	  TI DaVinci SoC
@@ -1120,7 +1124,8 @@ config BLK_DEV_UMC8672
 endif
 
 config BLK_DEV_IDEDMA
-	def_bool BLK_DEV_IDEDMA_PCI || BLK_DEV_IDEDMA_PMAC || BLK_DEV_IDEDMA_ICS || BLK_DEV_IDE_AU1XXX_MDMA2_DBDMA
+	def_bool BLK_DEV_IDEDMA_SFF || BLK_DEV_IDEDMA_PMAC || \
+		 BLK_DEV_IDEDMA_ICS || BLK_DEV_IDE_AU1XXX_MDMA2_DBDMA
 
 config IDE_ARCH_OBSOLETE_INIT
 	def_bool ALPHA || (ARM && !ARCH_L7200) || BLACKFIN || X86 || IA64 || M32R || MIPS || PARISC || PPC || (SUPERH64 && BLK_DEV_IDEPCI) || SPARC
Index: linux-2.6/drivers/ide/ide-dma.c
===================================================================
--- linux-2.6.orig/drivers/ide/ide-dma.c
+++ linux-2.6/drivers/ide/ide-dma.c
@@ -198,7 +198,7 @@ int ide_build_sglist(ide_drive_t *drive,
 
 EXPORT_SYMBOL_GPL(ide_build_sglist);
 
-#ifdef CONFIG_BLK_DEV_IDEDMA_PCI
+#ifdef CONFIG_BLK_DEV_IDEDMA_SFF
 /**
  *	ide_build_dmatable	-	build IDE DMA table
  *
@@ -316,7 +316,7 @@ void ide_destroy_dmatable (ide_drive_t *
 
 EXPORT_SYMBOL_GPL(ide_destroy_dmatable);
 
-#ifdef CONFIG_BLK_DEV_IDEDMA_PCI
+#ifdef CONFIG_BLK_DEV_IDEDMA_SFF
 /**
  *	config_drive_for_dma	-	attempt to activate IDE DMA
  *	@drive: the drive to place in DMA mode
@@ -424,7 +424,7 @@ void ide_dma_host_set(ide_drive_t *drive
 }
 
 EXPORT_SYMBOL_GPL(ide_dma_host_set);
-#endif /* CONFIG_BLK_DEV_IDEDMA_PCI */
+#endif /* CONFIG_BLK_DEV_IDEDMA_SFF  */
 
 /**
  *	ide_dma_off_quietly	-	Generic DMA kill
@@ -474,7 +474,7 @@ void ide_dma_on(ide_drive_t *drive)
 	drive->hwif->dma_host_set(drive, 1);
 }
 
-#ifdef CONFIG_BLK_DEV_IDEDMA_PCI
+#ifdef CONFIG_BLK_DEV_IDEDMA_SFF
 /**
  *	ide_dma_setup	-	begin a DMA phase
  *	@drive: target device
@@ -591,7 +591,7 @@ static int __ide_dma_test_irq(ide_drive_
 }
 #else
 static inline int config_drive_for_dma(ide_drive_t *drive) { return 0; }
-#endif /* CONFIG_BLK_DEV_IDEDMA_PCI */
+#endif /* CONFIG_BLK_DEV_IDEDMA_SFF */
 
 int __ide_dma_bad_drive (ide_drive_t *drive)
 {
@@ -840,7 +840,7 @@ void ide_check_dma_crc(ide_drive_t *driv
 		ide_dma_on(drive);
 }
 
-#ifdef CONFIG_BLK_DEV_IDEDMA_PCI
+#ifdef CONFIG_BLK_DEV_IDEDMA_SFF
 void ide_dma_lost_irq (ide_drive_t *drive)
 {
 	printk("%s: DMA interrupt recovery\n", drive->name);
@@ -1002,4 +1002,4 @@ void ide_setup_dma(ide_hwif_t *hwif, uns
 }
 
 EXPORT_SYMBOL_GPL(ide_setup_dma);
-#endif /* CONFIG_BLK_DEV_IDEDMA_PCI */
+#endif /* CONFIG_BLK_DEV_IDEDMA_SFF */
Index: linux-2.6/include/linux/ide.h
===================================================================
--- linux-2.6.orig/include/linux/ide.h
+++ linux-2.6/include/linux/ide.h
@@ -998,8 +998,7 @@ extern int __ide_pci_register_driver(str
 void ide_pci_setup_ports(struct pci_dev *, const struct ide_port_info *, int, u8 *);
 void ide_setup_pci_noise(struct pci_dev *, const struct ide_port_info *);
 
-/* FIXME: palm_bk3710 uses BLK_DEV_IDEDMA_PCI without BLK_DEV_IDEPCI! */
-#if defined(CONFIG_BLK_DEV_IDEPCI) && defined(CONFIG_BLK_DEV_IDEDMA_PCI)
+#ifdef CONFIG_BLK_DEV_IDEDMA_PCI
 void ide_hwif_setup_dma(ide_hwif_t *, const struct ide_port_info *);
 #else
 static inline void ide_hwif_setup_dma(ide_hwif_t *hwif,
@@ -1146,7 +1145,7 @@ ide_startstop_t ide_dma_intr(ide_drive_t
 int ide_build_sglist(ide_drive_t *, struct request *);
 void ide_destroy_dmatable(ide_drive_t *);
 
-#ifdef CONFIG_BLK_DEV_IDEDMA_PCI
+#ifdef CONFIG_BLK_DEV_IDEDMA_SFF
 extern int ide_build_dmatable(ide_drive_t *, struct request *);
 extern int ide_release_dma(ide_hwif_t *);
 extern void ide_setup_dma(ide_hwif_t *, unsigned long);
@@ -1157,7 +1156,7 @@ extern void ide_dma_start(ide_drive_t *)
 extern int __ide_dma_end(ide_drive_t *);
 extern void ide_dma_lost_irq(ide_drive_t *);
 extern void ide_dma_timeout(ide_drive_t *);
-#endif /* CONFIG_BLK_DEV_IDEDMA_PCI */
+#endif /* CONFIG_BLK_DEV_IDEDMA_SFF */
 
 #else
 static inline int ide_id_dma_bug(ide_drive_t *drive) { return 0; }
@@ -1171,7 +1170,7 @@ static inline int ide_set_dma(ide_drive_
 static inline void ide_check_dma_crc(ide_drive_t *drive) { ; }
 #endif /* CONFIG_BLK_DEV_IDEDMA */
 
-#ifndef CONFIG_BLK_DEV_IDEDMA_PCI
+#ifndef CONFIG_BLK_DEV_IDEDMA_SFF
 static inline void ide_release_dma(ide_hwif_t *drive) {;}
 #endif
 

