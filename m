From: Jeff Garzik <jgarzik@pobox.com>
Subject: [PATCH] libata updates for 2.4
Date: Mon, 21 Jun 2004 23:54:14 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20040622035414.GA11492@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from havoc.gtf.org ([216.162.42.101]:50120 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S266550AbUFVDyQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 21 Jun 2004 23:54:16 -0400
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>, Marcelo Tosatti <marcelo.tosatti@cyclades.com>


(do not apply, just for review/FYI)

Here is what is pending for Marcelo in 2.4.  I'm not
going to push until after 2.4.27 is released.

BK users:

	bk pull bk://gkernel.bkbits.net/libata-upstream-2.4

This will update the following files:

 Documentation/Configure.help |   18 +
 drivers/ide/Config.in        |    1 
 drivers/ide/pci/amd74xx.c    |   14 -
 drivers/ide/pci/amd74xx.h    |   44 ---
 drivers/ide/pci/piix.c       |   37 +-
 drivers/ide/pci/siimage.c    |    2 
 drivers/scsi/Config.in       |    2 
 drivers/scsi/Makefile        |    2 
 drivers/scsi/ata_piix.c      |  593 +++++++++++++++++++++++++++++++++++++++++++
 drivers/scsi/libata-core.c   |  362 +++++++-------------------
 drivers/scsi/sata_nv.c       |  361 ++++++++++++++++++++++++++
 drivers/scsi/sata_promise.c  |    8 
 drivers/scsi/sata_sil.c      |    2 
 drivers/scsi/sata_sis.c      |    2 
 drivers/scsi/sata_svw.c      |    2 
 drivers/scsi/sata_sx4.c      |    9 
 drivers/scsi/sata_via.c      |    2 
 drivers/scsi/sata_vsc.c      |    2 
 include/linux/libata.h       |   59 +++-
 19 files changed, 1165 insertions(+), 357 deletions(-)

through these ChangeSets:

<bunk@fs.tum.de> (04/06/21 1.1459)
   [PATCH] 2.6.7-mm1: drivers/scsi/hosts.h -> scsi/scsi_host.h
   
   On Sun, Jun 20, 2004 at 05:46:32PM -0700, Andrew Morton wrote:
   >...
   > All 226 patches:
   >...
   > bk-libata.patch
   >...
   
   drivers/scsi/hosts.h is obsolete, use scsi/scsi_host.h.
   
   Please apply
   Adrian

<jgarzik@pobox.com> (04/06/17 1.1458)
   [libata/IDE nvidia] shuffle pci ids
   
   * Mark conflicting PCI ids with CONFIG_BLK_DEV_IDE_SATA
   * Move not-yet-released PCI ids to libata sata_nv driver

<B.Zolnierkiewicz@elka.pw.edu.pl> (04/06/17 1.1457)
   [PATCH] DMA mode setup fixes for piix.c/ata_piix.c
   
   From: Go Taniguchi <go@turbolinux.co.jp> (Turbolinx Inc.)
   
   Change reg48 and reg54 in 8bit access and remove unused reg44.
   
   Jeff acked ata_piix.c part.
   
   Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
   Signed-off-by: Linus Torvalds <torvalds@osdl.org>

<jgarzik@pobox.com> (04/06/16 1.1456)
   [libata ata_piix] disable combined mode
   
   2.4.x kernels do not have the nasty PCI/resource gunk necessary to make
   combined mode work, so support for it is disabled in the driver.

<achew@nvidia.com> (04/06/16 1.1455)
   [libata] Add NVIDIA SATA driver.

<jgarzik@pobox.com> (04/06/16 1.1454)
   [IDE] Introduce SATA enable/disable config option
   
   This config option is introduced to help reduce user confusion,
   and eliminate conflicts between the IDE driver (which is often
   built into user kernels) and the new libata SATA driver.

<jgarzik@pobox.com> (04/06/16 1.1453)
   [libata] Add Intel ICH5/6 driver

<jgarzik@pobox.com> (04/06/15 1.1451)
   [libata] ->qc_prep hook
   
   Rename ->fill_sg hook to ->qc_prep, and call it unconditionally
   (as opposed to ->fill_sg, which was called only when the
   flag ATA_QCFLAG_SG was set).

<jgarzik@pobox.com> (04/06/14 1.1450)
   [libata] PCI IDE command-end/irq-acknowledge cleanup
   
   Restruct default irq handler (used for many PCI IDE-like SATA
   controllers) to obtain device status and acknowledge interrupts
   a bit differently.
   
   In an attempt to better attack the "ich5 screaming interrupt" problem,
   acknowledge and clear the device's INTRQ by reading the Status register
   _before_ ack'ing the controller's irq status.  This is a deviation
   from how the Linux IDE driver acknowledges interrupts, but it may
   be the best method, since the ICH5 appears to continue to assert
   the interrupt bit in the BMDMA until the device INTRQ line is cleared.
   
   Of course, SATA has no INTRQ line per se, so ICH5 essentially has
   new interrupt behavior not seen before in the PCI IDE world, while
   pretending that it's compatible with PCI IDE.  Sigh.
   
   This change affects all SATA controllers (for which there are libata
   drivers) except for sata_promise and sata_sx4.

<jgarzik@pobox.com> (04/06/14 1.1449)
   [libata] PCI IDE DMA code shuffling
   
   PCI IDE DMA standard (or "bmdma") helper routines ata_bmdma_stop,
   ata_bmdma_ack_irq, and ata_bmdma_status are added to linux/libata.h,
   and used in libata-core.
   
   There is a minor behavior change, such that, the Alt Status register
   is read before acknowledging the bmdma interrupt.  This should be ok,
   and furthermore there will be more significant behavior changes
   in this area coming soon.

<jgarzik@pobox.com> (04/06/14 1.1448)
   [libata] don't probe from workqueue
   
   Since we want the probe phase to call other workqueues, this is
   required to eliminate future deadlocks.
   
   Other methods would include starting a single-shot thread just for
   probing, but overall, using a separate thread for probing is pointless
   since we are already in process context when we probe.
    
   So, we simply call ata_bus_probe directly.

<p.lavarre@ieee.org> (04/06/02 1.1421.1.1)
   [PATCH] ata_check_bmdma
   
   Move hand-coded BMDMA status check into separate function.

diff -Nru a/Documentation/Configure.help b/Documentation/Configure.help
--- a/Documentation/Configure.help	2004-06-21 23:52:19 -04:00
+++ b/Documentation/Configure.help	2004-06-21 23:52:19 -04:00
@@ -696,6 +696,24 @@
   could say N here, and select the "Old hard disk driver" below
   instead to save about 13 KB of memory in the kernel.
 
+Support for SATA (deprecated; conflicts with libata SATA driver)
+CONFIG_BLK_DEV_IDE_SATA
+  There are two drivers for Serial ATA controllers.
+
+  The main driver, "libata", exists inside the SCSI subsystem
+  and supports most modern SATA controllers.
+
+  The IDE driver (which you are currently configuring) supports
+  a few first-generation SATA controllers.
+
+  In order to eliminate conflicts between the two subsystems,
+  this config option enables the IDE driver's SATA support.
+  Normally this is disabled, as it is preferred that libata
+  supports SATA controllers, and this (IDE) driver supports
+  PATA controllers.
+
+  If unsure, say N.
+
 Old hard disk (MFM/RLL/IDE) driver
 CONFIG_BLK_DEV_HD_ONLY
   There are two drivers for MFM/RLL/IDE hard disks. Most people use
diff -Nru a/drivers/ide/Config.in b/drivers/ide/Config.in
--- a/drivers/ide/Config.in	2004-06-21 23:52:19 -04:00
+++ b/drivers/ide/Config.in	2004-06-21 23:52:19 -04:00
@@ -12,6 +12,7 @@
    dep_bool '  Use old disk-only driver on primary interface' CONFIG_BLK_DEV_HD_IDE $CONFIG_X86
    define_bool CONFIG_BLK_DEV_HD $CONFIG_BLK_DEV_HD_IDE
 
+   dep_mbool '  Support for SATA (deprecated; conflicts with libata SATA driver)' CONFIG_BLK_DEV_IDE_SATA $CONFIG_BLK_DEV_IDE
    dep_tristate '  Include IDE/ATA-2 DISK support' CONFIG_BLK_DEV_IDEDISK $CONFIG_BLK_DEV_IDE
    dep_mbool '    Use multi-mode by default' CONFIG_IDEDISK_MULTI_MODE $CONFIG_BLK_DEV_IDEDISK
    dep_mbool '    Auto-Geometry Resizing support' CONFIG_IDEDISK_STROKE $CONFIG_BLK_DEV_IDEDISK
diff -Nru a/drivers/ide/pci/amd74xx.c b/drivers/ide/pci/amd74xx.c
--- a/drivers/ide/pci/amd74xx.c	2004-06-21 23:52:19 -04:00
+++ b/drivers/ide/pci/amd74xx.c	2004-06-21 23:52:19 -04:00
@@ -70,11 +70,7 @@
 	{ PCI_DEVICE_ID_NVIDIA_NFORCE3S_SATA,	0x50, AMD_UDMA_133 },
 	{ PCI_DEVICE_ID_NVIDIA_NFORCE3S_SATA2,	0x50, AMD_UDMA_133 },
 	{ PCI_DEVICE_ID_NVIDIA_NFORCE_CK804_IDE,	0x50, AMD_UDMA_133 },
-	{ PCI_DEVICE_ID_NVIDIA_NFORCE_CK804_SATA,	0x50, AMD_UDMA_133 },
-	{ PCI_DEVICE_ID_NVIDIA_NFORCE_CK804_SATA2,	0x50, AMD_UDMA_133 },
 	{ PCI_DEVICE_ID_NVIDIA_NFORCE_MCP04_IDE,	0x50, AMD_UDMA_133 },
-	{ PCI_DEVICE_ID_NVIDIA_NFORCE_MCP04_SATA,	0x50, AMD_UDMA_133 },
-	{ PCI_DEVICE_ID_NVIDIA_NFORCE_MCP04_SATA2,	0x50, AMD_UDMA_133 },
 	{ 0 }
 };
 
@@ -466,17 +462,17 @@
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_IDE,	PCI_ANY_ID, PCI_ANY_ID, 0, 0,  5 },
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE2_IDE,	PCI_ANY_ID, PCI_ANY_ID, 0, 0,  6 },
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE2S_IDE,	PCI_ANY_ID, PCI_ANY_ID, 0, 0,  7 },
+#ifdef CONFIG_BLK_DEV_IDE_SATA
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE2S_SATA,	PCI_ANY_ID, PCI_ANY_ID, 0, 0,  8 },
+#endif
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE3_IDE,	PCI_ANY_ID, PCI_ANY_ID, 0, 0,  9 },
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE3S_IDE,	PCI_ANY_ID, PCI_ANY_ID, 0, 0, 10 },
+#ifdef CONFIG_BLK_DEV_IDE_SATA
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE3S_SATA,	PCI_ANY_ID, PCI_ANY_ID, 0, 0, 11 },
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE3S_SATA2,	PCI_ANY_ID, PCI_ANY_ID, 0, 0, 12 },
+#endif
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_CK804_IDE,	PCI_ANY_ID, PCI_ANY_ID, 0, 0, 13 },
-	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_CK804_SATA,	PCI_ANY_ID, PCI_ANY_ID, 0, 0, 14 },
-	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_CK804_SATA2, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 15 },
-	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP04_IDE,	PCI_ANY_ID, PCI_ANY_ID, 0, 0, 16 },
-	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP04_SATA,	PCI_ANY_ID, PCI_ANY_ID, 0, 0, 17 },
-	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP04_SATA2, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 18 },
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP04_IDE,	PCI_ANY_ID, PCI_ANY_ID, 0, 0, 14 },
 	{ 0, },
 };
 
diff -Nru a/drivers/ide/pci/amd74xx.h b/drivers/ide/pci/amd74xx.h
--- a/drivers/ide/pci/amd74xx.h	2004-06-21 23:52:19 -04:00
+++ b/drivers/ide/pci/amd74xx.h	2004-06-21 23:52:19 -04:00
@@ -188,52 +188,8 @@
 	},
 	{	/* 14 */
 		.vendor		= PCI_VENDOR_ID_NVIDIA,
-		.device		= PCI_DEVICE_ID_NVIDIA_NFORCE_CK804_SATA,
-		.name		= "NFORCE-CK804-SATA",
-		.init_chipset	= init_chipset_amd74xx,
-		.init_hwif	= init_hwif_amd74xx,
-		.channels	= 2,
-		.autodma	= AUTODMA,
-		.enablebits	= {{0x50,0x02,0x02}, {0x50,0x01,0x01}},
-		.bootable	= ON_BOARD,
-	},
-	{	/* 15 */
-		.vendor		= PCI_VENDOR_ID_NVIDIA,
-		.device		= PCI_DEVICE_ID_NVIDIA_NFORCE_CK804_SATA2,
-		.name		= "NFORCE-CK804-SATA2",
-		.init_chipset	= init_chipset_amd74xx,
-		.init_hwif	= init_hwif_amd74xx,
-		.channels	= 2,
-		.autodma	= AUTODMA,
-		.enablebits	= {{0x50,0x02,0x02}, {0x50,0x01,0x01}},
-		.bootable	= ON_BOARD,
-	},
-	{	/* 16 */
-		.vendor		= PCI_VENDOR_ID_NVIDIA,
 		.device		= PCI_DEVICE_ID_NVIDIA_NFORCE_MCP04_IDE,
 		.name		= "NFORCE-MCP04",
-		.init_chipset	= init_chipset_amd74xx,
-		.init_hwif	= init_hwif_amd74xx,
-		.channels	= 2,
-		.autodma	= AUTODMA,
-		.enablebits	= {{0x50,0x02,0x02}, {0x50,0x01,0x01}},
-		.bootable	= ON_BOARD,
-	},
-	{	/* 17 */
-		.vendor		= PCI_VENDOR_ID_NVIDIA,
-		.device		= PCI_DEVICE_ID_NVIDIA_NFORCE_MCP04_SATA,
-		.name		= "NFORCE-MCP04-SATA",
-		.init_chipset	= init_chipset_amd74xx,
-		.init_hwif	= init_hwif_amd74xx,
-		.channels	= 2,
-		.autodma	= AUTODMA,
-		.enablebits	= {{0x50,0x02,0x02}, {0x50,0x01,0x01}},
-		.bootable	= ON_BOARD,
-	},
-	{	/* 18 */
-		.vendor		= PCI_VENDOR_ID_NVIDIA,
-		.device		= PCI_DEVICE_ID_NVIDIA_NFORCE_MCP04_SATA2,
-		.name		= "NFORCE-MCP04-SATA2",
 		.init_chipset	= init_chipset_amd74xx,
 		.init_hwif	= init_hwif_amd74xx,
 		.channels	= 2,
diff -Nru a/drivers/ide/pci/piix.c b/drivers/ide/pci/piix.c
--- a/drivers/ide/pci/piix.c	2004-06-21 23:52:19 -04:00
+++ b/drivers/ide/pci/piix.c	2004-06-21 23:52:19 -04:00
@@ -49,9 +49,9 @@
  * pci_read_config_word(HWIF(drive)->pci_dev, 0x40, &reg40);
  * pci_read_config_word(HWIF(drive)->pci_dev, 0x42, &reg42);
  * pci_read_config_word(HWIF(drive)->pci_dev, 0x44, &reg44);
- * pci_read_config_word(HWIF(drive)->pci_dev, 0x48, &reg48);
+ * pci_read_config_byte(HWIF(drive)->pci_dev, 0x48, &reg48);
  * pci_read_config_word(HWIF(drive)->pci_dev, 0x4a, &reg4a);
- * pci_read_config_word(HWIF(drive)->pci_dev, 0x54, &reg54);
+ * pci_read_config_byte(HWIF(drive)->pci_dev, 0x54, &reg54);
  *
  * Documentation
  *	Publically available from Intel web site. Errata documentation
@@ -433,15 +433,14 @@
 	int w_flag		= 0x10 << drive->dn;
 	int u_speed		= 0;
 	int			sitre;
-	u16			reg4042, reg44, reg48, reg4a, reg54;
-	u8			reg55;
+	u16			reg4042, reg4a;
+	u8			reg48, reg54, reg55;
 
 	pci_read_config_word(dev, maslave, &reg4042);
 	sitre = (reg4042 & 0x4000) ? 1 : 0;
-	pci_read_config_word(dev, 0x44, &reg44);
-	pci_read_config_word(dev, 0x48, &reg48);
+	pci_read_config_byte(dev, 0x48, &reg48);
 	pci_read_config_word(dev, 0x4a, &reg4a);
-	pci_read_config_word(dev, 0x54, &reg54);
+	pci_read_config_byte(dev, 0x54, &reg54);
 	pci_read_config_byte(dev, 0x55, &reg55);
 
 	switch(speed) {
@@ -463,30 +462,26 @@
 
 	if (speed >= XFER_UDMA_0) {
 		if (!(reg48 & u_flag))
-			pci_write_config_word(dev, 0x48, reg48|u_flag);
+			pci_write_config_byte(dev, 0x48, reg48 | u_flag);
 		if (speed == XFER_UDMA_5) {
 			pci_write_config_byte(dev, 0x55, (u8) reg55|w_flag);
 		} else {
 			pci_write_config_byte(dev, 0x55, (u8) reg55 & ~w_flag);
 		}
-		if (!(reg4a & u_speed)) {
-			pci_write_config_word(dev, 0x4a, reg4a & ~a_speed);
-			pci_write_config_word(dev, 0x4a, reg4a|u_speed);
-		}
+		if ((reg4a & a_speed) != u_speed)
+			pci_write_config_word(dev, 0x4a, (reg4a & ~a_speed) | u_speed);
 		if (speed > XFER_UDMA_2) {
-			if (!(reg54 & v_flag)) {
-				pci_write_config_word(dev, 0x54, reg54|v_flag);
-			}
-		} else {
-			pci_write_config_word(dev, 0x54, reg54 & ~v_flag);
-		}
+			if (!(reg54 & v_flag))
+				pci_write_config_byte(dev, 0x54, reg54 | v_flag);
+		} else
+			pci_write_config_byte(dev, 0x54, reg54 & ~v_flag);
 	} else {
 		if (reg48 & u_flag)
-			pci_write_config_word(dev, 0x48, reg48 & ~u_flag);
+			pci_write_config_byte(dev, 0x48, reg48 & ~u_flag);
 		if (reg4a & a_speed)
 			pci_write_config_word(dev, 0x4a, reg4a & ~a_speed);
 		if (reg54 & v_flag)
-			pci_write_config_word(dev, 0x54, reg54 & ~v_flag);
+			pci_write_config_byte(dev, 0x54, reg54 & ~v_flag);
 		if (reg55 & w_flag)
 			pci_write_config_byte(dev, 0x55, (u8) reg55 & ~w_flag);
 	}
@@ -882,7 +877,9 @@
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801EB_11,PCI_ANY_ID, PCI_ANY_ID, 0, 0, 15},
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801E_11, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 16},
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801DB_10,PCI_ANY_ID, PCI_ANY_ID, 0, 0, 17},
+#ifdef CONFIG_BLK_DEV_IDE_SATA
  	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801EB_1, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 18},
+#endif
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ESB_2, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 19},
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH6_2, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 20},
 	{ 0, },
diff -Nru a/drivers/ide/pci/siimage.c b/drivers/ide/pci/siimage.c
--- a/drivers/ide/pci/siimage.c	2004-06-21 23:52:19 -04:00
+++ b/drivers/ide/pci/siimage.c	2004-06-21 23:52:19 -04:00
@@ -1194,8 +1194,10 @@
 
 static struct pci_device_id siimage_pci_tbl[] __devinitdata = {
 	{ PCI_VENDOR_ID_CMD, PCI_DEVICE_ID_SII_680,  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
+#ifdef CONFIG_BLK_DEV_IDE_SATA
 	{ PCI_VENDOR_ID_CMD, PCI_DEVICE_ID_SII_3112, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 1},
 	{ PCI_VENDOR_ID_CMD, PCI_DEVICE_ID_SII_1210SA, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 2},
+#endif
 	{ 0, },
 };
 
diff -Nru a/drivers/scsi/Config.in b/drivers/scsi/Config.in
--- a/drivers/scsi/Config.in	2004-06-21 23:52:19 -04:00
+++ b/drivers/scsi/Config.in	2004-06-21 23:52:19 -04:00
@@ -70,6 +70,8 @@
 dep_tristate 'AMI MegaRAID2 support' CONFIG_SCSI_MEGARAID2 $CONFIG_SCSI
 dep_mbool 'Serial ATA (SATA) support' CONFIG_SCSI_SATA $CONFIG_SCSI
 dep_tristate '  ServerWorks Frodo / Apple K2 SATA support (EXPERIMENTAL)' CONFIG_SCSI_SATA_SVW $CONFIG_SCSI_SATA $CONFIG_PCI $CONFIG_EXPERIMENTAL
+dep_tristate '  Intel PIIX/ICH SATA support' CONFIG_SCSI_ATA_PIIX $CONFIG_SCSI_SATA $CONFIG_PCI
+dep_tristate '  NVIDIA SATA support (EXPERIMENTAL)' CONFIG_SCSI_SATA_NV $CONFIG_SCSI_SATA $CONFIG_PCI
 dep_tristate '  Promise SATA TX2/TX4 support (EXPERIMENTAL)' CONFIG_SCSI_SATA_PROMISE $CONFIG_SCSI_SATA $CONFIG_PCI $CONFIG_EXPERIMENTAL
 dep_tristate '  Promise SATA SX4 support (EXPERIMENTAL)' CONFIG_SCSI_SATA_SX4 $CONFIG_SCSI_SATA $CONFIG_PCI $CONFIG_EXPERIMENTAL
 dep_tristate '  Silicon Image SATA support (EXPERIMENTAL)' CONFIG_SCSI_SATA_SIL $CONFIG_SCSI_SATA $CONFIG_PCI $CONFIG_EXPERIMENTAL
diff -Nru a/drivers/scsi/Makefile b/drivers/scsi/Makefile
--- a/drivers/scsi/Makefile	2004-06-21 23:52:19 -04:00
+++ b/drivers/scsi/Makefile	2004-06-21 23:52:19 -04:00
@@ -131,12 +131,14 @@
 obj-$(CONFIG_SCSI_LASI700)	+= lasi700.o 53c700.o
 obj-$(CONFIG_SCSI_NSP32)	+= nsp32.o
 obj-$(CONFIG_SCSI_SATA_SVW)	+= libata.o sata_svw.o
+obj-$(CONFIG_SCSI_ATA_PIIX)	+= libata.o ata_piix.o
 obj-$(CONFIG_SCSI_SATA_PROMISE)	+= libata.o sata_promise.o
 obj-$(CONFIG_SCSI_SATA_SIL)	+= libata.o sata_sil.o
 obj-$(CONFIG_SCSI_SATA_VIA)	+= libata.o sata_via.o
 obj-$(CONFIG_SCSI_SATA_VITESSE)	+= libata.o sata_vsc.o
 obj-$(CONFIG_SCSI_SATA_SIS)	+= libata.o sata_sis.o
 obj-$(CONFIG_SCSI_SATA_SX4)	+= libata.o sata_sx4.o
+obj-$(CONFIG_SCSI_SATA_NV)	+= libata.o sata_nv.o
 
 subdir-$(CONFIG_ARCH_ACORN)	+= ../acorn/scsi
 obj-$(CONFIG_ARCH_ACORN)	+= ../acorn/scsi/acorn-scsi.o
diff -Nru a/drivers/scsi/ata_piix.c b/drivers/scsi/ata_piix.c
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/drivers/scsi/ata_piix.c	2004-06-21 23:52:19 -04:00
@@ -0,0 +1,593 @@
+/*
+
+    ata_piix.c - Intel PATA/SATA controllers
+
+
+	Copyright 2003-2004 Red Hat Inc
+	Copyright 2003-2004 Jeff Garzik
+
+
+	Copyright header from piix.c:
+
+    Copyright (C) 1998-1999 Andrzej Krzysztofowicz, Author and Maintainer
+    Copyright (C) 1998-2000 Andre Hedrick <andre@linux-ide.org>
+    Copyright (C) 2003 Red Hat Inc <alan@redhat.com>
+
+    May be copied or modified under the terms of the GNU General Public License
+
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/init.h>
+#include <linux/blkdev.h>
+#include <linux/delay.h>
+#include "scsi.h"
+#include <scsi/scsi_host.h>
+#include <linux/libata.h>
+
+#define DRV_NAME	"ata_piix"
+#define DRV_VERSION	"1.02"
+
+enum {
+	PIIX_IOCFG		= 0x54, /* IDE I/O configuration register */
+	ICH5_PMR		= 0x90, /* port mapping register */
+	ICH5_PCS		= 0x92,	/* port control and status */
+
+	PIIX_FLAG_CHECKINTR	= (1 << 29), /* make sure PCI INTx enabled */
+	PIIX_FLAG_COMBINED	= (1 << 30), /* combined mode possible */
+
+	/* combined mode.  if set, PATA is channel 0.
+	 * if clear, PATA is channel 1.
+	 */
+	PIIX_COMB_PATA_P0	= (1 << 1),
+	PIIX_COMB		= (1 << 2), /* combined mode enabled? */
+
+	PIIX_PORT_PRESENT	= (1 << 0),
+	PIIX_PORT_ENABLED	= (1 << 4),
+
+	PIIX_80C_PRI		= (1 << 5) | (1 << 4),
+	PIIX_80C_SEC		= (1 << 7) | (1 << 6),
+
+	ich5_pata		= 0,
+	ich5_sata		= 1,
+	piix4_pata		= 2,
+};
+
+static int piix_init_one (struct pci_dev *pdev,
+				    const struct pci_device_id *ent);
+
+static void piix_pata_phy_reset(struct ata_port *ap);
+static void piix_sata_phy_reset(struct ata_port *ap);
+static void piix_set_piomode (struct ata_port *ap, struct ata_device *adev,
+			      unsigned int pio);
+static void piix_set_udmamode (struct ata_port *ap, struct ata_device *adev,
+			       unsigned int udma);
+
+static unsigned int in_module_init = 1;
+
+static struct pci_device_id piix_pci_tbl[] = {
+#ifdef ATA_ENABLE_PATA
+	{ 0x8086, 0x7111, PCI_ANY_ID, PCI_ANY_ID, 0, 0, piix4_pata },
+	{ 0x8086, 0x24db, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich5_pata },
+	{ 0x8086, 0x25a2, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich5_pata },
+#endif
+
+	/* NOTE: The following PCI ids must be kept in sync with the
+	 * list in drivers/pci/quirks.c.
+	 */
+
+	{ 0x8086, 0x24d1, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich5_sata },
+	{ 0x8086, 0x24df, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich5_sata },
+	{ 0x8086, 0x25a3, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich5_sata },
+	{ 0x8086, 0x25b0, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich5_sata },
+
+	/* ICH6 operates in two modes, "looks-like-ICH5" mode,
+	 * and enhanced mode, with queueing and other fancy stuff.
+	 * This is distinguished by PCI class code.
+	 */
+	{ 0x8086, 0x2651, PCI_ANY_ID, PCI_ANY_ID,
+	  PCI_CLASS_STORAGE_IDE << 8, 0xffff00, ich5_sata },
+	{ 0x8086, 0x2652, PCI_ANY_ID, PCI_ANY_ID,
+	  PCI_CLASS_STORAGE_IDE << 8, 0xffff00, ich5_sata },
+
+	{ }	/* terminate list */
+};
+
+static struct pci_driver piix_pci_driver = {
+	.name			= DRV_NAME,
+	.id_table		= piix_pci_tbl,
+	.probe			= piix_init_one,
+	.remove			= ata_pci_remove_one,
+};
+
+static Scsi_Host_Template piix_sht = {
+	.module			= THIS_MODULE,
+	.name			= DRV_NAME,
+	.detect			= ata_scsi_detect,
+	.release		= ata_scsi_release,
+	.queuecommand		= ata_scsi_queuecmd,
+	.eh_strategy_handler	= ata_scsi_error,
+	.can_queue		= ATA_DEF_QUEUE,
+	.this_id		= ATA_SHT_THIS_ID,
+	.sg_tablesize		= LIBATA_MAX_PRD,
+	.max_sectors		= ATA_MAX_SECTORS,
+	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
+	.use_new_eh_code	= ATA_SHT_NEW_EH_CODE,
+	.emulated		= ATA_SHT_EMULATED,
+	.use_clustering		= ATA_SHT_USE_CLUSTERING,
+	.proc_name		= DRV_NAME,
+	.bios_param		= ata_std_bios_param,
+};
+
+static struct ata_port_operations piix_pata_ops = {
+	.port_disable		= ata_port_disable,
+	.set_piomode		= piix_set_piomode,
+	.set_udmamode		= piix_set_udmamode,
+
+	.tf_load		= ata_tf_load_pio,
+	.tf_read		= ata_tf_read_pio,
+	.check_status		= ata_check_status_pio,
+	.exec_command		= ata_exec_command_pio,
+
+	.phy_reset		= piix_pata_phy_reset,
+
+	.bmdma_setup		= ata_bmdma_setup_pio,
+	.bmdma_start		= ata_bmdma_start_pio,
+	.qc_prep		= ata_qc_prep,
+	.eng_timeout		= ata_eng_timeout,
+
+	.irq_handler		= ata_interrupt,
+
+	.port_start		= ata_port_start,
+	.port_stop		= ata_port_stop,
+};
+
+static struct ata_port_operations piix_sata_ops = {
+	.port_disable		= ata_port_disable,
+	.set_piomode		= piix_set_piomode,
+	.set_udmamode		= piix_set_udmamode,
+
+	.tf_load		= ata_tf_load_pio,
+	.tf_read		= ata_tf_read_pio,
+	.check_status		= ata_check_status_pio,
+	.exec_command		= ata_exec_command_pio,
+
+	.phy_reset		= piix_sata_phy_reset,
+
+	.bmdma_setup		= ata_bmdma_setup_pio,
+	.bmdma_start		= ata_bmdma_start_pio,
+	.qc_prep		= ata_qc_prep,
+	.eng_timeout		= ata_eng_timeout,
+
+	.irq_handler		= ata_interrupt,
+
+	.port_start		= ata_port_start,
+	.port_stop		= ata_port_stop,
+};
+
+static struct ata_port_info piix_port_info[] = {
+	/* ich5_pata */
+	{
+		.sht		= &piix_sht,
+		.host_flags	= ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST |
+				  PIIX_FLAG_CHECKINTR,
+		.pio_mask	= 0x03,	/* pio3-4 */
+		.udma_mask	= ATA_UDMA_MASK_40C, /* FIXME: cbl det */
+		.port_ops	= &piix_pata_ops,
+	},
+
+	/* ich5_sata */
+	{
+		.sht		= &piix_sht,
+		.host_flags	= ATA_FLAG_SATA | ATA_FLAG_SRST |
+				  PIIX_FLAG_COMBINED | PIIX_FLAG_CHECKINTR,
+		.pio_mask	= 0x03,	/* pio3-4 */
+		.udma_mask	= 0x7f,	/* udma0-6 ; FIXME */
+		.port_ops	= &piix_sata_ops,
+	},
+
+	/* piix4_pata */
+	{
+		.sht		= &piix_sht,
+		.host_flags	= ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
+		.pio_mask	= 0x03, /* pio3-4 */
+		.udma_mask	= ATA_UDMA_MASK_40C, /* FIXME: cbl det */
+		.port_ops	= &piix_pata_ops,
+	},
+};
+
+static struct pci_bits piix_enable_bits[] = {
+	{ 0x41U, 1U, 0x80UL, 0x80UL },	/* port 0 */
+	{ 0x43U, 1U, 0x80UL, 0x80UL },	/* port 1 */
+};
+
+MODULE_AUTHOR("Andre Hedrick, Alan Cox, Andrzej Krzysztofowicz, Jeff Garzik");
+MODULE_DESCRIPTION("SCSI low-level driver for Intel PIIX/ICH ATA controllers");
+MODULE_LICENSE("GPL");
+MODULE_DEVICE_TABLE(pci, piix_pci_tbl);
+
+/**
+ *	piix_pata_cbl_detect - Probe host controller cable detect info
+ *	@ap: Port for which cable detect info is desired
+ *
+ *	Read 80c cable indicator from SATA PCI device's PCI config
+ *	register.  This register is normally set by firmware (BIOS).
+ *
+ *	LOCKING:
+ *	None (inherited from caller).
+ */
+static void piix_pata_cbl_detect(struct ata_port *ap)
+{
+	struct pci_dev *pdev = ap->host_set->pdev;
+	u8 tmp, mask;
+
+	/* no 80c support in host controller? */
+	if ((ap->udma_mask & ~ATA_UDMA_MASK_40C) == 0)
+		goto cbl40;
+
+	/* check BIOS cable detect results */
+	mask = ap->port_no == 0 ? PIIX_80C_PRI : PIIX_80C_SEC;
+	pci_read_config_byte(pdev, PIIX_IOCFG, &tmp);
+	if ((tmp & mask) == 0)
+		goto cbl40;
+
+	ap->cbl = ATA_CBL_PATA80;
+	return;
+
+cbl40:
+	ap->cbl = ATA_CBL_PATA40;
+	ap->udma_mask &= ATA_UDMA_MASK_40C;
+}
+
+/**
+ *	piix_pata_phy_reset - Probe specified port on PATA host controller
+ *	@ap: Port to probe
+ *
+ *	Probe PATA phy.
+ *
+ *	LOCKING:
+ *	None (inherited from caller).
+ */
+
+static void piix_pata_phy_reset(struct ata_port *ap)
+{
+	if (!pci_test_config_bits(ap->host_set->pdev,
+				  &piix_enable_bits[ap->port_no])) {
+		ata_port_disable(ap);
+		printk(KERN_INFO "ata%u: port disabled. ignoring.\n", ap->id);
+		return;
+	}
+
+	piix_pata_cbl_detect(ap);
+
+	ata_port_probe(ap);
+
+	ata_bus_reset(ap);
+}
+
+/**
+ *	piix_sata_probe - Probe PCI device for present SATA devices
+ *	@ap: Port associated with the PCI device we wish to probe
+ *
+ *	Reads SATA PCI device's PCI config register Port Configuration
+ *	and Status (PCS) to determine port and device availability.
+ *
+ *	LOCKING:
+ *	None (inherited from caller).
+ *
+ *	RETURNS:
+ *	Non-zero if device detected, zero otherwise.
+ */
+static int piix_sata_probe (struct ata_port *ap)
+{
+	struct pci_dev *pdev = ap->host_set->pdev;
+	int combined = (ap->flags & ATA_FLAG_SLAVE_POSS);
+	int orig_mask, mask, i;
+	u8 pcs;
+
+	mask = (PIIX_PORT_PRESENT << ap->port_no) |
+	       (PIIX_PORT_ENABLED << ap->port_no);
+
+	pci_read_config_byte(pdev, ICH5_PCS, &pcs);
+	orig_mask = (int) pcs & 0xff;
+
+	/* TODO: this is vaguely wrong for ICH6 combined mode,
+	 * where only two of the four SATA ports are mapped
+	 * onto a single ATA channel.  It is also vaguely inaccurate
+	 * for ICH5, which has only two ports.  However, this is ok,
+	 * as further device presence detection code will handle
+	 * any false positives produced here.
+	 */
+
+	for (i = 0; i < 4; i++) {
+		mask = (PIIX_PORT_PRESENT << i) | (PIIX_PORT_ENABLED << i);
+
+		if ((orig_mask & mask) == mask)
+			if (combined || (i == ap->port_no))
+				return 1;
+	}
+
+	return 0;
+}
+
+/**
+ *	piix_sata_phy_reset - Probe specified port on SATA host controller
+ *	@ap: Port to probe
+ *
+ *	Probe SATA phy.
+ *
+ *	LOCKING:
+ *	None (inherited from caller).
+ */
+
+static void piix_sata_phy_reset(struct ata_port *ap)
+{
+	if (!pci_test_config_bits(ap->host_set->pdev,
+				  &piix_enable_bits[ap->port_no])) {
+		ata_port_disable(ap);
+		printk(KERN_INFO "ata%u: port disabled. ignoring.\n", ap->id);
+		return;
+	}
+
+	if (!piix_sata_probe(ap)) {
+		ata_port_disable(ap);
+		printk(KERN_INFO "ata%u: SATA port has no device.\n", ap->id);
+		return;
+	}
+
+	ap->cbl = ATA_CBL_SATA;
+
+	ata_port_probe(ap);
+
+	ata_bus_reset(ap);
+}
+
+/**
+ *	piix_set_piomode - Initialize host controller PATA PIO timings
+ *	@ap: Port whose timings we are configuring
+ *	@adev: um
+ *	@pio: PIO mode, 0 - 4
+ *
+ *	Set PIO mode for device, in host controller PCI config space.
+ *
+ *	LOCKING:
+ *	None (inherited from caller).
+ */
+
+static void piix_set_piomode (struct ata_port *ap, struct ata_device *adev,
+			      unsigned int pio)
+{
+	struct pci_dev *dev	= ap->host_set->pdev;
+	unsigned int is_slave	= (adev->flags & ATA_DFLAG_MASTER) ? 0 : 1;
+	unsigned int master_port= ap->port_no ? 0x42 : 0x40;
+	unsigned int slave_port	= 0x44;
+	u16 master_data;
+	u8 slave_data;
+
+	static const	 /* ISP  RTC */
+	u8 timings[][2]	= { { 0, 0 },
+			    { 0, 0 },
+			    { 1, 0 },
+			    { 2, 1 },
+			    { 2, 3 }, };
+
+	pci_read_config_word(dev, master_port, &master_data);
+	if (is_slave) {
+		master_data |= 0x4000;
+		/* enable PPE, IE and TIME */
+		master_data |= 0x0070;
+		pci_read_config_byte(dev, slave_port, &slave_data);
+		slave_data &= (ap->port_no ? 0x0f : 0xf0);
+		slave_data |=
+			(timings[pio][0] << 2) |
+			(timings[pio][1] << (ap->port_no ? 4 : 0));
+	} else {
+		master_data &= 0xccf8;
+		/* enable PPE, IE and TIME */
+		master_data |= 0x0007;
+		master_data |=
+			(timings[pio][0] << 12) |
+			(timings[pio][1] << 8);
+	}
+	pci_write_config_word(dev, master_port, master_data);
+	if (is_slave)
+		pci_write_config_byte(dev, slave_port, slave_data);
+}
+
+/**
+ *	piix_set_udmamode - Initialize host controller PATA PIO timings
+ *	@ap: Port whose timings we are configuring
+ *	@adev: um
+ *	@udma: udma mode, 0 - 6
+ *
+ *	Set UDMA mode for device, in host controller PCI config space.
+ *
+ *	LOCKING:
+ *	None (inherited from caller).
+ */
+
+static void piix_set_udmamode (struct ata_port *ap, struct ata_device *adev,
+			      unsigned int udma)
+{
+	struct pci_dev *dev	= ap->host_set->pdev;
+	u8 maslave		= ap->port_no ? 0x42 : 0x40;
+	u8 speed		= udma;
+	unsigned int drive_dn	= (ap->port_no ? 2 : 0) + adev->devno;
+	int a_speed		= 3 << (drive_dn * 4);
+	int u_flag		= 1 << drive_dn;
+	int v_flag		= 0x01 << drive_dn;
+	int w_flag		= 0x10 << drive_dn;
+	int u_speed		= 0;
+	int			sitre;
+	u16			reg4042, reg4a;
+	u8			reg48, reg54, reg55;
+
+	pci_read_config_word(dev, maslave, &reg4042);
+	DPRINTK("reg4042 = 0x%04x\n", reg4042);
+	sitre = (reg4042 & 0x4000) ? 1 : 0;
+	pci_read_config_byte(dev, 0x48, &reg48);
+	pci_read_config_word(dev, 0x4a, &reg4a);
+	pci_read_config_byte(dev, 0x54, &reg54);
+	pci_read_config_byte(dev, 0x55, &reg55);
+
+	switch(speed) {
+		case XFER_UDMA_4:
+		case XFER_UDMA_2:	u_speed = 2 << (drive_dn * 4); break;
+		case XFER_UDMA_6:
+		case XFER_UDMA_5:
+		case XFER_UDMA_3:
+		case XFER_UDMA_1:	u_speed = 1 << (drive_dn * 4); break;
+		case XFER_UDMA_0:	u_speed = 0 << (drive_dn * 4); break;
+		default:
+			BUG();
+			return;
+	}
+
+	if (!(reg48 & u_flag))
+		pci_write_config_byte(dev, 0x48, reg48 | u_flag);
+	if (speed == XFER_UDMA_5) {
+		pci_write_config_byte(dev, 0x55, (u8) reg55|w_flag);
+	} else {
+		pci_write_config_byte(dev, 0x55, (u8) reg55 & ~w_flag);
+	}
+	if ((reg4a & a_speed) != u_speed)
+		pci_write_config_word(dev, 0x4a, (reg4a & ~a_speed) | u_speed);
+	if (speed > XFER_UDMA_2) {
+		if (!(reg54 & v_flag))
+			pci_write_config_byte(dev, 0x54, reg54 | v_flag);
+	} else
+		pci_write_config_byte(dev, 0x54, reg54 & ~v_flag);
+}
+
+/* move to PCI layer, integrate w/ MSI stuff */
+static void pci_enable_intx(struct pci_dev *pdev)
+{
+	u16 pci_command;
+
+	pci_read_config_word(pdev, PCI_COMMAND, &pci_command);
+	if (pci_command & PCI_COMMAND_INTX_DISABLE) {
+		pci_command &= ~PCI_COMMAND_INTX_DISABLE;
+		pci_write_config_word(pdev, PCI_COMMAND, pci_command);
+	}
+}
+
+/**
+ *	piix_init_one - Register PIIX ATA PCI device with kernel services
+ *	@pdev: PCI device to register
+ *	@ent: Entry in piix_pci_tbl matching with @pdev
+ *
+ *	Called from kernel PCI layer.  We probe for combined mode (sigh),
+ *	and then hand over control to libata, for it to do the rest.
+ *
+ *	LOCKING:
+ *	Inherited from PCI layer (may sleep).
+ *
+ *	RETURNS:
+ *	Zero on success, or -ERRNO value.
+ */
+
+static int piix_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
+{
+	static int printed_version;
+	struct ata_port_info *port_info[2];
+	unsigned int combined = 0, n_ports = 1;
+	unsigned int pata_chan = 0, sata_chan = 0;
+
+	if (!printed_version++)
+		printk(KERN_DEBUG DRV_NAME " version " DRV_VERSION "\n");
+
+	/* no hotplugging support (FIXME) */
+	if (!in_module_init)
+		return -ENODEV;
+
+	port_info[0] = &piix_port_info[ent->driver_data];
+	port_info[1] = NULL;
+
+	if (port_info[0]->host_flags & PIIX_FLAG_COMBINED) {
+		u8 tmp;
+		pci_read_config_byte(pdev, ICH5_PMR, &tmp);
+
+		if (tmp & PIIX_COMB) {
+			combined = 1;
+			if (tmp & PIIX_COMB_PATA_P0)
+				sata_chan = 1;
+			else
+				pata_chan = 1;
+		}
+	}
+
+	/* On ICH5, some BIOSen disable the interrupt using the
+	 * PCI_COMMAND_INTX_DISABLE bit added in PCI 2.3.
+	 * On ICH6, this bit has the same effect, but only when
+	 * MSI is disabled (and it is disabled, as we don't use
+	 * message-signalled interrupts currently).
+	 */
+	if (port_info[0]->host_flags & PIIX_FLAG_CHECKINTR)
+		pci_enable_intx(pdev);
+
+	if (combined) {
+		port_info[sata_chan] = &piix_port_info[ent->driver_data];
+		port_info[sata_chan]->host_flags |= ATA_FLAG_SLAVE_POSS;
+		port_info[pata_chan] = &piix_port_info[ich5_pata];
+		n_ports++;
+
+		printk(KERN_ERR DRV_NAME ": combined mode not supported\n");
+		return -ENODEV;
+	}
+
+	return ata_pci_init_one(pdev, port_info, n_ports);
+}
+
+/**
+ *	piix_init -
+ *
+ *	LOCKING:
+ *
+ *	RETURNS:
+ *
+ */
+
+static int __init piix_init(void)
+{
+	int rc;
+
+	DPRINTK("pci_module_init\n");
+	rc = pci_module_init(&piix_pci_driver);
+	if (rc)
+		return rc;
+
+	in_module_init = 0;
+
+	DPRINTK("scsi_register_host\n");
+	rc = scsi_register_module(MODULE_SCSI_HA, &piix_sht);
+	if (rc) {
+		rc = -ENODEV;
+		goto err_out;
+	}
+
+	DPRINTK("done\n");
+	return 0;
+
+err_out:
+	pci_unregister_driver(&piix_pci_driver);
+	return rc;
+}
+
+/**
+ *	piix_exit -
+ *
+ *	LOCKING:
+ *
+ */
+
+static void __exit piix_exit(void)
+{
+	scsi_unregister_module(MODULE_SCSI_HA, &piix_sht);
+	pci_unregister_driver(&piix_pci_driver);
+}
+
+module_init(piix_init);
+module_exit(piix_exit);
+
diff -Nru a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
--- a/drivers/scsi/libata-core.c	2004-06-21 23:52:19 -04:00
+++ b/drivers/scsi/libata-core.c	2004-06-21 23:52:19 -04:00
@@ -49,7 +49,6 @@
 				    unsigned long tmout_pat,
 			    	    unsigned long tmout);
 static void __ata_dev_select (struct ata_port *ap, unsigned int device);
-static void ata_dma_complete(struct ata_queued_cmd *qc, u8 host_stat);
 static void ata_host_set_pio(struct ata_port *ap);
 static void ata_host_set_udma(struct ata_port *ap);
 static void ata_dev_set_pio(struct ata_port *ap, unsigned int device);
@@ -65,37 +64,6 @@
 MODULE_DESCRIPTION("Library module for ATA devices");
 MODULE_LICENSE("GPL");
 
-static const char * thr_state_name[] = {
-	"THR_UNKNOWN",
-	"THR_PORT_RESET",
-	"THR_AWAIT_DEATH",
-	"THR_PROBE_FAILED",
-	"THR_IDLE",
-	"THR_PROBE_SUCCESS",
-	"THR_PROBE_START",
-};
-
-/**
- *	ata_thr_state_name - convert thread state enum to string
- *	@thr_state: thread state to be converted to string
- *
- *	Converts the specified thread state id to a constant C string.
- *
- *	LOCKING:
- *	None.
- *
- *	RETURNS:
- *	The THR_xxx-prefixed string naming the specified thread
- *	state id, or the string "<invalid THR_xxx state>".
- */
-
-static const char *ata_thr_state_name(unsigned int thr_state)
-{
-	if (thr_state < ARRAY_SIZE(thr_state_name))
-		return thr_state_name[thr_state];
-	return "<invalid THR_xxx state>";
-}
-
 /**
  *	msleep - sleep for a number of milliseconds
  *	@msecs: number of milliseconds to sleep
@@ -1167,13 +1135,16 @@
 }
 
 /**
- *	ata_port_reset -
- *	@ap:
+ *	ata_bus_probe - Reset and probe ATA bus
+ *	@ap: Bus to probe
  *
  *	LOCKING:
+ *
+ *	RETURNS:
+ *	Zero on success, non-zero on error.
  */
 
-static void ata_port_reset(struct ata_port *ap)
+static int ata_bus_probe(struct ata_port *ap)
 {
 	unsigned int i, found = 0;
 
@@ -1197,14 +1168,12 @@
 	if (ap->flags & ATA_FLAG_PORT_DISABLED)
 		goto err_out_disable;
 
-	ap->thr_state = THR_PROBE_SUCCESS;
-
-	return;
+	return 0;
 
 err_out_disable:
 	ap->ops->port_disable(ap);
 err_out:
-	ap->thr_state = THR_PROBE_FAILED;
+	return -1;
 }
 
 /**
@@ -1823,13 +1792,13 @@
 }
 
 /**
- *	ata_fill_sg -
- *	@qc:
+ *	ata_fill_sg - Fill PCI IDE PRD table
+ *	@qc: Metadata associated with taskfile to be transferred
  *
  *	LOCKING:
  *
  */
-void ata_fill_sg(struct ata_queued_cmd *qc)
+static void ata_fill_sg(struct ata_queued_cmd *qc)
 {
 	struct scatterlist *sg = qc->sg;
 	struct ata_port *ap = qc->ap;
@@ -1871,6 +1840,21 @@
 }
 
 /**
+ *	ata_qc_prep - Prepare taskfile for submission
+ *	@qc: Metadata associated with taskfile to be prepared
+ *
+ *	LOCKING:
+ *	spin_lock_irqsave(host_set lock)
+ */
+void ata_qc_prep(struct ata_queued_cmd *qc)
+{
+	if (!(qc->flags & ATA_QCFLAG_SG))
+		return;
+
+	ata_fill_sg(qc);
+}
+
+/**
  *	ata_sg_setup_one -
  *	@qc:
  *
@@ -1887,7 +1871,6 @@
 	struct scsi_cmnd *cmd = qc->scsicmd;
 	int dir = scsi_to_pci_dma_dir(cmd->sc_data_direction);
 	struct scatterlist *sg = qc->sg;
-	unsigned int have_sg = (qc->flags & ATA_QCFLAG_SG);
 	dma_addr_t dma_address;
 
 	assert(sg == &qc->sgent);
@@ -1898,9 +1881,6 @@
 	sg->offset = (unsigned long) cmd->request_buffer & ~PAGE_MASK;
 	sg_dma_len(sg) = cmd->request_bufflen;
 
-	if (!have_sg)
-		return 0;
-
 	dma_address = pci_map_single(ap->host_set->pdev, cmd->request_buffer,
 				     cmd->request_bufflen, dir);
 
@@ -1928,22 +1908,19 @@
 	struct ata_port *ap = qc->ap;
 	struct scsi_cmnd *cmd = qc->scsicmd;
 	struct scatterlist *sg;
-	int n_elem;
-	unsigned int have_sg = (qc->flags & ATA_QCFLAG_SG);
+	int n_elem, dir;
 
 	VPRINTK("ENTER, ata%u, use_sg %d\n", ap->id, cmd->use_sg);
 	assert(cmd->use_sg > 0);
 
 	sg = (struct scatterlist *)cmd->request_buffer;
-	if (have_sg) {
-		int dir = scsi_to_pci_dma_dir(cmd->sc_data_direction);
-		n_elem = pci_map_sg(ap->host_set->pdev, sg, cmd->use_sg, dir);
-		if (n_elem < 1)
-			return -1;
-		DPRINTK("%d sg elements mapped\n", n_elem);
-	} else {
-		n_elem = cmd->use_sg;
-	}
+	dir = scsi_to_pci_dma_dir(cmd->sc_data_direction);
+	n_elem = pci_map_sg(ap->host_set->pdev, sg, cmd->use_sg, dir);
+	if (n_elem < 1)
+		return -1;
+
+	DPRINTK("%d sg elements mapped\n", n_elem);
+
 	qc->n_elem = n_elem;
 
 	return 0;
@@ -2182,7 +2159,7 @@
 
 void ata_eng_timeout(struct ata_port *ap)
 {
-	u8 host_stat, drv_stat;
+	u8 host_stat = 0, drv_stat;
 	struct ata_queued_cmd *qc;
 
 	DPRINTK("ENTER\n");
@@ -2203,34 +2180,28 @@
 	qc->scsidone = scsi_finish_command;
 
 	switch (qc->tf.protocol) {
+
 	case ATA_PROT_DMA:
-		if (ap->flags & ATA_FLAG_MMIO) {
-			void *mmio = (void *) ap->ioaddr.bmdma_addr;
-			host_stat = readb(mmio + ATA_DMA_STATUS);
-		} else
-			host_stat = inb(ap->ioaddr.bmdma_addr + ATA_DMA_STATUS);
+	case ATA_PROT_ATAPI_DMA:
+		host_stat = ata_bmdma_status(ap);
 
-		printk(KERN_ERR "ata%u: DMA timeout, stat 0x%x\n",
-		       ap->id, host_stat);
+		/* before we do anything else, clear DMA-Start bit */
+		ata_bmdma_stop(ap);
 
-		ata_dma_complete(qc, host_stat);
-		break;
+		/* fall through */
 
 	case ATA_PROT_NODATA:
-		drv_stat = ata_busy_wait(ap, ATA_BUSY | ATA_DRQ, 1000);
-
-		printk(KERN_ERR "ata%u: command 0x%x timeout, stat 0x%x\n",
-		       ap->id, qc->tf.command, drv_stat);
-
-		ata_qc_complete(qc, drv_stat);
-		break;
-
 	default:
-		drv_stat = ata_busy_wait(ap, ATA_BUSY | ATA_DRQ, 1000);
+		ata_altstatus(ap);
+		drv_stat = ata_chk_status(ap);
+
+		/* ack bmdma irq events */
+		ata_bmdma_ack_irq(ap);
 
-		printk(KERN_ERR "ata%u: unknown timeout, cmd 0x%x stat 0x%x\n",
-		       ap->id, qc->tf.command, drv_stat);
+		printk(KERN_ERR "ata%u: command 0x%x timeout, stat 0x%x host_stat 0x%x\n",
+		       ap->id, qc->tf.command, drv_stat, host_stat);
 
+		/* complete taskfile transaction */
 		ata_qc_complete(qc, drv_stat);
 		break;
 	}
@@ -2378,10 +2349,10 @@
 			if (ata_sg_setup_one(qc))
 				goto err_out;
 		}
-
-		ap->ops->fill_sg(qc);
 	}
 
+	ap->ops->qc_prep(qc);
+
 	qc->ap->active_tag = qc->tag;
 	qc->flags |= ATA_QCFLAG_ACTIVE;
 
@@ -2461,7 +2432,7 @@
 {
 	struct ata_port *ap = qc->ap;
 	unsigned int rw = (qc->tf.flags & ATA_TFLAG_WRITE);
-	u8 host_stat, dmactl;
+	u8 dmactl;
 	void *mmio = (void *) ap->ioaddr.bmdma_addr;
 
 	/* load PRD table addr. */
@@ -2475,10 +2446,6 @@
 		dmactl |= ATA_DMA_WR;
 	writeb(dmactl, mmio + ATA_DMA_CMD);
 
-	/* clear interrupt, error bits */
-	host_stat = readb(mmio + ATA_DMA_STATUS);
-	writeb(host_stat | ATA_DMA_INTR | ATA_DMA_ERR, mmio + ATA_DMA_STATUS);
-
 	/* issue r/w command */
 	ap->ops->exec_command(ap, &qc->tf);
 }
@@ -2526,7 +2493,7 @@
 {
 	struct ata_port *ap = qc->ap;
 	unsigned int rw = (qc->tf.flags & ATA_TFLAG_WRITE);
-	u8 host_stat, dmactl;
+	u8 dmactl;
 
 	/* load PRD table addr. */
 	outl(ap->prd_dma, ap->ioaddr.bmdma_addr + ATA_DMA_TABLE_OFS);
@@ -2538,11 +2505,6 @@
 		dmactl |= ATA_DMA_WR;
 	outb(dmactl, ap->ioaddr.bmdma_addr + ATA_DMA_CMD);
 
-	/* clear interrupt, error bits */
-	host_stat = inb(ap->ioaddr.bmdma_addr + ATA_DMA_STATUS);
-	outb(host_stat | ATA_DMA_INTR | ATA_DMA_ERR,
-	     ap->ioaddr.bmdma_addr + ATA_DMA_STATUS);
-
 	/* issue r/w command */
 	ap->ops->exec_command(ap, &qc->tf);
 }
@@ -2567,50 +2529,6 @@
 }
 
 /**
- *	ata_dma_complete - Complete an active ATA BMDMA command
- *	@qc: Command to complete
- *	@host_stat: BMDMA status register contents
- *
- *	LOCKING:
- */
-
-static void ata_dma_complete(struct ata_queued_cmd *qc, u8 host_stat)
-{
-	struct ata_port *ap = qc->ap;
-	VPRINTK("ENTER\n");
-
-	if (ap->flags & ATA_FLAG_MMIO) {
-		void *mmio = (void *) ap->ioaddr.bmdma_addr;
-
-		/* clear start/stop bit */
-		writeb(readb(mmio + ATA_DMA_CMD) & ~ATA_DMA_START,
-		       mmio + ATA_DMA_CMD);
-
-		/* ack intr, err bits */
-		writeb(host_stat | ATA_DMA_INTR | ATA_DMA_ERR,
-		       mmio + ATA_DMA_STATUS);
-	} else {
-		/* clear start/stop bit */
-		outb(inb(ap->ioaddr.bmdma_addr + ATA_DMA_CMD) & ~ATA_DMA_START,
-		     ap->ioaddr.bmdma_addr + ATA_DMA_CMD);
-
-		/* ack intr, err bits */
-		outb(host_stat | ATA_DMA_INTR | ATA_DMA_ERR,
-		     ap->ioaddr.bmdma_addr + ATA_DMA_STATUS);
-	}
-
-
-	/* one-PIO-cycle guaranteed wait, per spec, for HDMA1:0 transition */
-	ata_altstatus(ap);		/* dummy read */
-
-	DPRINTK("host %u, host_stat==0x%X, drv_stat==0x%X\n",
-		ap->id, (u32) host_stat, (u32) ata_chk_status(ap));
-
-	/* get drive status; clear intr; complete txn */
-	ata_qc_complete(qc, ata_wait_idle(ap));
-}
-
-/**
  *	ata_host_intr - Handle host interrupt for given (port, task)
  *	@ap: Port on which interrupt arrived (possibly...)
  *	@qc: Taskfile currently active in engine
@@ -2630,59 +2548,60 @@
 				   struct ata_queued_cmd *qc)
 {
 	u8 status, host_stat;
-	unsigned int handled = 0;
 
 	switch (qc->tf.protocol) {
 
-	/* BMDMA completion */
 	case ATA_PROT_DMA:
 	case ATA_PROT_ATAPI_DMA:
-		if (ap->flags & ATA_FLAG_MMIO) {
-			void *mmio = (void *) ap->ioaddr.bmdma_addr;
-			host_stat = readb(mmio + ATA_DMA_STATUS);
-		} else
-			host_stat = inb(ap->ioaddr.bmdma_addr + ATA_DMA_STATUS);
+		/* check status of DMA engine */
+		host_stat = ata_bmdma_status(ap);
 		VPRINTK("BUS_DMA (host_stat 0x%X)\n", host_stat);
 
-		if (!(host_stat & ATA_DMA_INTR)) {
-			ap->stats.idle_irq++;
-			break;
-		}
+		/* if it's not our irq... */
+		if (!(host_stat & ATA_DMA_INTR))
+			goto idle_irq;
 
-		ata_dma_complete(qc, host_stat);
-		handled = 1;
-		break;
+		/* before we do anything else, clear DMA-Start bit */
+		ata_bmdma_stop(ap);
+
+		/* fall through */
 
-	/* command completion, but no data xfer */
-	/* FIXME: a shared interrupt _will_ cause a non-data command
-	 * to be completed prematurely, with an error.
-	 *
-	 * This doesn't matter right now, since we aren't sending
-	 * non-data commands down this pipe except in development
-	 * situations.
-	 */
-	case ATA_PROT_ATAPI:
 	case ATA_PROT_NODATA:
-		status = ata_busy_wait(ap, ATA_BUSY | ATA_DRQ, 1000);
-		DPRINTK("BUS_NODATA (drv_stat 0x%X)\n", status);
+		/* check altstatus */
+		status = ata_altstatus(ap);
+		if (status & ATA_BUSY)
+			goto idle_irq;
+
+		/* check main status, clearing INTRQ */
+		status = ata_chk_status(ap);
+		if (unlikely(status & ATA_BUSY))
+			goto idle_irq;
+		DPRINTK("BUS_NODATA (dev_stat 0x%X)\n", status);
+
+		/* ack bmdma irq events */
+		ata_bmdma_ack_irq(ap);
+
+		/* complete taskfile transaction */
 		ata_qc_complete(qc, status);
-		handled = 1;
 		break;
 
 	default:
-		ap->stats.idle_irq++;
+		goto idle_irq;
+	}
+
+	return 1;	/* irq handled */
+
+idle_irq:
+	ap->stats.idle_irq++;
 
 #ifdef ATA_IRQ_TRAP
-		if ((ap->stats.idle_irq % 1000) == 0) {
-			handled = 1;
-			ata_irq_ack(ap, 0); /* debug trap */
-			printk(KERN_WARNING "ata%d: irq trap\n", ap->id);
-		}
-#endif
-		break;
+	if ((ap->stats.idle_irq % 1000) == 0) {
+		handled = 1;
+		ata_irq_ack(ap, 0); /* debug trap */
+		printk(KERN_WARNING "ata%d: irq trap\n", ap->id);
 	}
-
-	return handled;
+#endif
+	return 0;	/* irq not handled */
 }
 
 /**
@@ -2716,7 +2635,7 @@
 
 			qc = ata_qc_from_tag(ap, ap->active_tag);
 			if (qc && (!(qc->tf.ctl & ATA_NIEN)))
-				handled += ata_host_intr(ap, qc);
+				handled |= ata_host_intr(ap, qc);
 		}
 	}
 
@@ -2726,62 +2645,6 @@
 }
 
 /**
- *	ata_thread_iter -
- *	@ap:
- *
- *	LOCKING:
- *
- *	RETURNS:
- *
- */
-
-static unsigned long ata_thread_iter(struct ata_port *ap)
-{
-	long timeout = 0;
-
-	DPRINTK("ata%u: thr_state %s\n",
-		ap->id, ata_thr_state_name(ap->thr_state));
-
-	switch (ap->thr_state) {
-	case THR_UNKNOWN:
-		ap->thr_state = THR_PORT_RESET;
-		break;
-
-	case THR_PROBE_START:
-		ap->thr_state = THR_PORT_RESET;
-		break;
-
-	case THR_PORT_RESET:
-		ata_port_reset(ap);
-		break;
-
-	case THR_PROBE_SUCCESS:
-		up(&ap->probe_sem);
-		ap->thr_state = THR_IDLE;
-		break;
-
-	case THR_PROBE_FAILED:
-		up(&ap->probe_sem);
-		ap->thr_state = THR_AWAIT_DEATH;
-		break;
-
-	case THR_AWAIT_DEATH:
-	case THR_IDLE:
-		timeout = -1;
-		break;
-
-	default:
-		printk(KERN_DEBUG "ata%u: unknown thr state %s\n",
-		       ap->id, ata_thr_state_name(ap->thr_state));
-		break;
-	}
-
-	DPRINTK("ata%u: new thr_state %s, returning %ld\n",
-		ap->id, ata_thr_state_name(ap->thr_state), timeout);
-	return timeout;
-}
-
-/**
  *	atapi_packet_task - Write CDB bytes to hardware
  *	@_data: Port to which ATAPI device is attached.
  *
@@ -2862,23 +2725,6 @@
 	pci_free_consistent(pdev, ATA_PRD_TBL_SZ, ap->prd, ap->prd_dma);
 }
 
-static void ata_probe_task(void *_data)
-{
-	struct ata_port *ap = _data;
-	long timeout;
-
-	timeout = ata_thread_iter(ap);
-	if (timeout < 0)
-		return;
-
-	if (timeout > 0) {
-		set_current_state(TASK_UNINTERRUPTIBLE);
-		schedule_timeout(timeout);
-	}
-
-	schedule_task(&ap->probe_task);
-}
-
 /**
  *	ata_host_remove - Unregister SCSI host structure with upper layers
  *	@ap: Port to unregister
@@ -2934,7 +2780,6 @@
 	ap->udma_mask = ent->udma_mask;
 	ap->flags |= ent->host_flags;
 	ap->ops = ent->port_ops;
-	ap->thr_state = THR_PROBE_START;
 	ap->cbl = ATA_CBL_NONE;
 	ap->device[0].flags = ATA_DFLAG_MASTER;
 	ap->active_tag = ATA_TAG_POISON;
@@ -2942,13 +2787,10 @@
 
 	INIT_TQUEUE(&ap->packet_task, atapi_packet_task, ap);
 	INIT_TQUEUE(&ap->pio_task, ata_pio_task, ap);
-	INIT_TQUEUE(&ap->probe_task, ata_probe_task, ap);
 
 	for (i = 0; i < ATA_MAX_DEVICES; i++)
 		ap->device[i].devno = i;
 
-	init_MUTEX_LOCKED(&ap->probe_sem);
-
 #ifdef ATA_IRQ_TRAP
 	ap->stats.unhandled_irq = 1;
 	ap->stats.idle_irq = 1;
@@ -3057,6 +2899,10 @@
 		return 0;
 	}
 
+	/* TODO: ack irq here, to ensure it won't scream
+	 * when we enable it?
+	 */
+
 	/* obtain irq, that is shared between channels */
 	if (request_irq(ent->irq, ent->port_ops->irq_handler, ent->irq_flags,
 			DRV_NAME, host_set))
@@ -3066,16 +2912,22 @@
 	DPRINTK("probe begin\n");
 	for (i = 0; i < count; i++) {
 		struct ata_port *ap;
+		int rc;
 
 		ap = host_set->ports[i];
 
 		DPRINTK("ata%u: probe begin\n", ap->id);
-		schedule_task(&ap->probe_task);		/* start probe */
+		rc = ata_bus_probe(ap);
+		DPRINTK("ata%u: probe end\n", ap->id);
 
-		DPRINTK("ata%u: probe-wait begin\n", ap->id);
-		down(&ap->probe_sem);	/* wait for end */
-
-		DPRINTK("ata%u: probe-wait end\n", ap->id);
+		if (rc) {
+			/* FIXME: do something useful here?
+			 * Current libata behavior will
+			 * tear down everything when
+			 * the module is removed
+			 * or the h/w is unplugged.
+			 */
+		}
 	}
 
 	pci_set_drvdata(pdev, host_set);
@@ -3507,7 +3359,7 @@
 EXPORT_SYMBOL_GPL(ata_port_start);
 EXPORT_SYMBOL_GPL(ata_port_stop);
 EXPORT_SYMBOL_GPL(ata_interrupt);
-EXPORT_SYMBOL_GPL(ata_fill_sg);
+EXPORT_SYMBOL_GPL(ata_qc_prep);
 EXPORT_SYMBOL_GPL(ata_bmdma_setup_pio);
 EXPORT_SYMBOL_GPL(ata_bmdma_start_pio);
 EXPORT_SYMBOL_GPL(ata_bmdma_setup_mmio);
diff -Nru a/drivers/scsi/sata_nv.c b/drivers/scsi/sata_nv.c
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/drivers/scsi/sata_nv.c	2004-06-21 23:52:19 -04:00
@@ -0,0 +1,361 @@
+/*
+ *  sata_nv.c - NVIDIA nForce SATA
+ *
+ *  Copyright 2004 NVIDIA Corp.  All rights reserved.
+ *  Copyright 2004 Andrew Chew
+ *
+ *  The contents of this file are subject to the Open
+ *  Software License version 1.1 that can be found at
+ *  http://www.opensource.org/licenses/osl-1.1.txt and is included herein
+ *  by reference.
+ *
+ *  Alternatively, the contents of this file may be used under the terms
+ *  of the GNU General Public License version 2 (the "GPL") as distributed
+ *  in the kernel source COPYING file, in which case the provisions of
+ *  the GPL are applicable instead of the above.  If you wish to allow
+ *  the use of your version of this file only under the terms of the
+ *  GPL and not to allow others to use your version of this file under
+ *  the OSL, indicate your decision by deleting the provisions above and
+ *  replace them with the notice and other provisions required by the GPL.
+ *  If you do not delete the provisions above, a recipient may use your
+ *  version of this file under either the OSL or the GPL.
+ *
+ */
+
+#include <linux/config.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/init.h>
+#include <linux/blkdev.h>
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include "scsi.h"
+#include <scsi/scsi_host.h>
+#include <linux/libata.h>
+
+#define DRV_NAME			"sata_nv"
+#define DRV_VERSION			"0.01"
+
+#define NV_PORTS			2
+#define NV_PIO_MASK			0x1f
+#define NV_UDMA_MASK			0x7f
+#define NV_PORT0_BMDMA_REG_OFFSET	0x00
+#define NV_PORT1_BMDMA_REG_OFFSET	0x08
+#define NV_PORT0_SCR_REG_OFFSET		0x00
+#define NV_PORT1_SCR_REG_OFFSET		0x40
+
+#define NV_INT_STATUS			0x10
+#define NV_INT_STATUS_PDEV_INT		0x01
+#define NV_INT_STATUS_PDEV_PM		0x02
+#define NV_INT_STATUS_PDEV_ADDED	0x04
+#define NV_INT_STATUS_PDEV_REMOVED	0x08
+#define NV_INT_STATUS_SDEV_INT		0x10
+#define NV_INT_STATUS_SDEV_PM		0x20
+#define NV_INT_STATUS_SDEV_ADDED	0x40
+#define NV_INT_STATUS_SDEV_REMOVED	0x80
+#define NV_INT_STATUS_PDEV_HOTPLUG	(NV_INT_STATUS_PDEV_ADDED | \
+					NV_INT_STATUS_PDEV_REMOVED)
+#define NV_INT_STATUS_SDEV_HOTPLUG	(NV_INT_STATUS_SDEV_ADDED | \
+					NV_INT_STATUS_SDEV_REMOVED)
+#define NV_INT_STATUS_HOTPLUG		(NV_INT_STATUS_PDEV_HOTPLUG | \
+					NV_INT_STATUS_SDEV_HOTPLUG)
+
+#define NV_INT_ENABLE			0x11
+#define NV_INT_ENABLE_PDEV_MASK		0x01
+#define NV_INT_ENABLE_PDEV_PM		0x02
+#define NV_INT_ENABLE_PDEV_ADDED	0x04
+#define NV_INT_ENABLE_PDEV_REMOVED	0x08
+#define NV_INT_ENABLE_SDEV_MASK		0x10
+#define NV_INT_ENABLE_SDEV_PM		0x20
+#define NV_INT_ENABLE_SDEV_ADDED	0x40
+#define NV_INT_ENABLE_SDEV_REMOVED	0x80
+#define NV_INT_ENABLE_PDEV_HOTPLUG	(NV_INT_ENABLE_PDEV_ADDED | \
+					NV_INT_ENABLE_PDEV_REMOVED)
+#define NV_INT_ENABLE_SDEV_HOTPLUG	(NV_INT_ENABLE_SDEV_ADDED | \
+					NV_INT_ENABLE_SDEV_REMOVED)
+#define NV_INT_ENABLE_HOTPLUG		(NV_INT_ENABLE_PDEV_HOTPLUG | \
+					NV_INT_ENABLE_SDEV_HOTPLUG)
+
+#define NV_INT_CONFIG			0x12
+#define NV_INT_CONFIG_METHD		0x01 // 0 = INT, 1 = SMI
+
+static int nv_init_one (struct pci_dev *pdev, const struct pci_device_id *ent);
+irqreturn_t nv_interrupt (int irq, void *dev_instance, struct pt_regs *regs);
+static u32 nv_scr_read (struct ata_port *ap, unsigned int sc_reg);
+static void nv_scr_write (struct ata_port *ap, unsigned int sc_reg, u32 val);
+static void nv_host_stop (struct ata_host_set *host_set);
+
+static struct pci_device_id nv_pci_tbl[] = {
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE2S_SATA,
+		PCI_ANY_ID, PCI_ANY_ID, },
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE3S_SATA,
+		PCI_ANY_ID, PCI_ANY_ID, },
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE3S_SATA2,
+		PCI_ANY_ID, PCI_ANY_ID, },
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_CK804_SATA,
+		PCI_ANY_ID, PCI_ANY_ID, },
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_CK804_SATA2,
+		PCI_ANY_ID, PCI_ANY_ID, },
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP04_SATA,
+		PCI_ANY_ID, PCI_ANY_ID, },
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP04_SATA2,
+		PCI_ANY_ID, PCI_ANY_ID, },
+	{ 0, } /* terminate list */
+};
+
+static struct pci_driver nv_pci_driver = {
+	.name			= DRV_NAME,
+	.id_table		= nv_pci_tbl,
+	.probe			= nv_init_one,
+	.remove			= ata_pci_remove_one,
+};
+
+static Scsi_Host_Template nv_sht = {
+	.module			= THIS_MODULE,
+	.name			= DRV_NAME,
+	.detect			= ata_scsi_detect,
+	.release		= ata_scsi_release,
+	.queuecommand		= ata_scsi_queuecmd,
+	.eh_strategy_handler	= ata_scsi_error,
+	.can_queue		= ATA_DEF_QUEUE,
+	.this_id		= ATA_SHT_THIS_ID,
+	.sg_tablesize		= LIBATA_MAX_PRD,
+	.max_sectors		= ATA_MAX_SECTORS,
+	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
+	.use_new_eh_code	= ATA_SHT_NEW_EH_CODE,
+	.emulated		= ATA_SHT_EMULATED,
+	.use_clustering		= ATA_SHT_USE_CLUSTERING,
+	.proc_name		= DRV_NAME,
+	.bios_param		= ata_std_bios_param,
+};
+
+static struct ata_port_operations nv_ops = {
+	.port_disable		= ata_port_disable,
+	.tf_load		= ata_tf_load_pio,
+	.tf_read		= ata_tf_read_pio,
+	.exec_command		= ata_exec_command_pio,
+	.check_status		= ata_check_status_pio,
+	.phy_reset		= sata_phy_reset,
+	.bmdma_setup		= ata_bmdma_setup_pio,
+	.bmdma_start		= ata_bmdma_start_pio,
+	.qc_prep		= ata_qc_prep,
+	.eng_timeout		= ata_eng_timeout,
+	.irq_handler		= nv_interrupt,
+	.scr_read		= nv_scr_read,
+	.scr_write		= nv_scr_write,
+	.port_start		= ata_port_start,
+	.port_stop		= ata_port_stop,
+	.host_stop		= nv_host_stop,
+};
+
+MODULE_AUTHOR("NVIDIA");
+MODULE_DESCRIPTION("low-level driver for NVIDIA nForce SATA controller");
+MODULE_LICENSE("GPL");
+MODULE_DEVICE_TABLE(pci, nv_pci_tbl);
+
+irqreturn_t nv_interrupt (int irq, void *dev_instance, struct pt_regs *regs)
+{
+	struct ata_host_set *host_set = dev_instance;
+	unsigned int i;
+	unsigned int handled = 0;
+	unsigned long flags;
+	u8 intr_status;
+	u8 intr_enable;
+
+	spin_lock_irqsave(&host_set->lock, flags);
+
+	for (i = 0; i < host_set->n_ports; i++) {
+		struct ata_port *ap;
+
+		ap = host_set->ports[i];
+		if (ap && (!(ap->flags & ATA_FLAG_PORT_DISABLED))) {
+			struct ata_queued_cmd *qc;
+
+			qc = ata_qc_from_tag(ap, ap->active_tag);
+			if (qc && (!(qc->tf.ctl & ATA_NIEN)))
+				handled += ata_host_intr(ap, qc);
+		}
+
+		intr_status = inb(ap->ioaddr.scr_addr + NV_INT_STATUS);
+		intr_enable = inb(ap->ioaddr.scr_addr + NV_INT_ENABLE);
+
+		// Clear interrupt status.
+		outb(0xff, ap->ioaddr.scr_addr + NV_INT_STATUS);
+
+		if (intr_status & NV_INT_STATUS_HOTPLUG) {
+			if (intr_status & NV_INT_STATUS_PDEV_ADDED) {
+				printk(KERN_WARNING "ata%u: "
+					"Primary device added\n", ap->id);
+			}
+
+			if (intr_status & NV_INT_STATUS_PDEV_REMOVED) {
+				printk(KERN_WARNING "ata%u: "
+					"Primary device removed\n", ap->id);
+			}
+
+			if (intr_status & NV_INT_STATUS_SDEV_ADDED) {
+				printk(KERN_WARNING "ata%u: "
+					"Secondary device added\n", ap->id);
+			}
+
+			if (intr_status & NV_INT_STATUS_SDEV_REMOVED) {
+				printk(KERN_WARNING "ata%u: "
+					"Secondary device removed\n", ap->id);
+			}
+		}
+	}
+
+	spin_unlock_irqrestore(&host_set->lock, flags);
+
+	return IRQ_RETVAL(handled);
+}
+
+static u32 nv_scr_read (struct ata_port *ap, unsigned int sc_reg)
+{
+	if (sc_reg > SCR_CONTROL)
+		return 0xffffffffU;
+
+	return inl(ap->ioaddr.scr_addr + (sc_reg * 4));
+}
+
+static void nv_scr_write (struct ata_port *ap, unsigned int sc_reg, u32 val)
+{
+	if (sc_reg > SCR_CONTROL)
+		return;
+
+	outl(val, ap->ioaddr.scr_addr + (sc_reg * 4));
+}
+
+static void nv_host_stop (struct ata_host_set *host_set)
+{
+	int i;
+
+	for (i=0; i<host_set->n_ports; i++) {
+		u8 intr_mask;
+
+		// Disable hotplug event interrupts.
+		intr_mask = inb(host_set->ports[i]->ioaddr.scr_addr +
+				NV_INT_ENABLE);
+		intr_mask &= ~(NV_INT_ENABLE_HOTPLUG);
+		outb(intr_mask, host_set->ports[i]->ioaddr.scr_addr +
+				NV_INT_ENABLE);
+	}
+}
+
+static int nv_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
+{
+	static int printed_version = 0;
+	struct ata_probe_ent *probe_ent = NULL;
+	int i;
+	int rc;
+
+	if (!printed_version++)
+		printk(KERN_DEBUG DRV_NAME " version " DRV_VERSION "\n");
+
+	rc = pci_enable_device(pdev);
+	if (rc)
+		return rc;
+
+	rc = pci_request_regions(pdev, DRV_NAME);
+	if (rc)
+		goto err_out;
+
+	rc = pci_set_dma_mask(pdev, ATA_DMA_MASK);
+	if (rc)
+		goto err_out_regions;
+
+	probe_ent = kmalloc(sizeof(*probe_ent), GFP_KERNEL);
+	if (!probe_ent) {
+		rc = -ENOMEM;
+		goto err_out_regions;
+	}
+
+	memset(probe_ent, 0, sizeof(*probe_ent));
+	INIT_LIST_HEAD(&probe_ent->node);
+
+	probe_ent->pdev = pdev;
+	probe_ent->sht = &nv_sht;
+	probe_ent->host_flags = ATA_FLAG_SATA |
+				ATA_FLAG_SATA_RESET |
+				ATA_FLAG_SRST |
+				ATA_FLAG_NO_LEGACY;
+	probe_ent->port_ops = &nv_ops;
+	probe_ent->n_ports = NV_PORTS;
+	probe_ent->irq = pdev->irq;
+	probe_ent->irq_flags = SA_SHIRQ;
+	probe_ent->pio_mask = NV_PIO_MASK;
+	probe_ent->udma_mask = NV_UDMA_MASK;
+
+	probe_ent->port[0].cmd_addr = pci_resource_start(pdev, 0);
+	ata_std_ports(&probe_ent->port[0]);
+	probe_ent->port[0].altstatus_addr =
+	probe_ent->port[0].ctl_addr =
+		pci_resource_start(pdev, 1) | ATA_PCI_CTL_OFS;
+	probe_ent->port[0].bmdma_addr =
+		pci_resource_start(pdev, 4) | NV_PORT0_BMDMA_REG_OFFSET;
+	probe_ent->port[0].scr_addr =
+		pci_resource_start(pdev, 5) | NV_PORT0_SCR_REG_OFFSET;
+
+	probe_ent->port[1].cmd_addr = pci_resource_start(pdev, 2);
+	ata_std_ports(&probe_ent->port[1]);
+	probe_ent->port[1].altstatus_addr =
+	probe_ent->port[1].ctl_addr =
+		pci_resource_start(pdev, 3) | ATA_PCI_CTL_OFS;
+	probe_ent->port[1].bmdma_addr =
+		pci_resource_start(pdev, 4) | NV_PORT1_BMDMA_REG_OFFSET;
+	probe_ent->port[1].scr_addr =
+		pci_resource_start(pdev, 5) | NV_PORT1_SCR_REG_OFFSET;
+
+	pci_set_master(pdev);
+
+	// Enable hotplug event interrupts.
+	for (i=0; i<probe_ent->n_ports; i++) {
+		u8 intr_mask;
+
+		outb(NV_INT_STATUS_HOTPLUG, probe_ent->port[i].scr_addr +
+						NV_INT_STATUS);
+
+		intr_mask = inb(probe_ent->port[i].scr_addr + NV_INT_ENABLE);
+		intr_mask |= NV_INT_ENABLE_HOTPLUG;
+		outb(intr_mask, probe_ent->port[i].scr_addr + NV_INT_ENABLE);
+	}
+
+	ata_add_to_probe_list(probe_ent);
+
+	return 0;
+
+err_out_regions:
+	pci_release_regions(pdev);
+
+err_out:
+	pci_disable_device(pdev);
+	return rc;
+}
+
+static int __init nv_init(void)
+{
+	int rc;
+
+	rc = pci_module_init(&nv_pci_driver);
+	if (rc)
+		return rc;
+	
+	rc = scsi_register_module(MODULE_SCSI_HA, &nv_sht);
+	if (rc) {
+		pci_unregister_driver(&nv_pci_driver);
+		/* TODO: does scsi_register_module return errno val? */
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+static void __exit nv_exit(void)
+{
+	scsi_unregister_module(MODULE_SCSI_HA, &nv_sht);
+	pci_unregister_driver(&nv_pci_driver);
+}
+
+module_init(nv_init);
+module_exit(nv_exit);
diff -Nru a/drivers/scsi/sata_promise.c b/drivers/scsi/sata_promise.c
--- a/drivers/scsi/sata_promise.c	2004-06-21 23:52:19 -04:00
+++ b/drivers/scsi/sata_promise.c	2004-06-21 23:52:19 -04:00
@@ -81,7 +81,7 @@
 static int pdc_port_start(struct ata_port *ap);
 static void pdc_port_stop(struct ata_port *ap);
 static void pdc_phy_reset(struct ata_port *ap);
-static void pdc_fill_sg(struct ata_queued_cmd *qc);
+static void pdc_qc_prep(struct ata_queued_cmd *qc);
 static void pdc_tf_load_mmio(struct ata_port *ap, struct ata_taskfile *tf);
 static void pdc_exec_command_mmio(struct ata_port *ap, struct ata_taskfile *tf);
 static inline void pdc_dma_complete (struct ata_port *ap,
@@ -115,7 +115,7 @@
 	.phy_reset		= pdc_phy_reset,
 	.bmdma_setup            = pdc_dma_setup,
 	.bmdma_start            = pdc_dma_start,
-	.fill_sg		= pdc_fill_sg,
+	.qc_prep		= pdc_qc_prep,
 	.eng_timeout		= pdc_eng_timeout,
 	.irq_handler		= pdc_interrupt,
 	.scr_read		= pdc_sata_scr_read,
@@ -262,14 +262,14 @@
 	writel(val, (void *) ap->ioaddr.scr_addr + (sc_reg * 4));
 }
 
-static void pdc_fill_sg(struct ata_queued_cmd *qc)
+static void pdc_qc_prep(struct ata_queued_cmd *qc)
 {
 	struct pdc_port_priv *pp = qc->ap->private_data;
 	unsigned int i;
 
 	VPRINTK("ENTER\n");
 
-	ata_fill_sg(qc);
+	ata_qc_prep(qc);
 
 	i = pdc_pkt_header(&qc->tf, qc->ap->prd_dma,  qc->dev->devno, pp->pkt);
 
diff -Nru a/drivers/scsi/sata_sil.c b/drivers/scsi/sata_sil.c
--- a/drivers/scsi/sata_sil.c	2004-06-21 23:52:19 -04:00
+++ b/drivers/scsi/sata_sil.c	2004-06-21 23:52:19 -04:00
@@ -132,7 +132,7 @@
 	.post_set_mode		= sil_post_set_mode,
 	.bmdma_setup            = ata_bmdma_setup_mmio,
 	.bmdma_start            = ata_bmdma_start_mmio,
-	.fill_sg		= ata_fill_sg,
+	.qc_prep		= ata_qc_prep,
 	.eng_timeout		= ata_eng_timeout,
 	.irq_handler		= ata_interrupt,
 	.scr_read		= sil_scr_read,
diff -Nru a/drivers/scsi/sata_sis.c b/drivers/scsi/sata_sis.c
--- a/drivers/scsi/sata_sis.c	2004-06-21 23:52:19 -04:00
+++ b/drivers/scsi/sata_sis.c	2004-06-21 23:52:19 -04:00
@@ -101,7 +101,7 @@
 	.phy_reset		= sata_phy_reset,
 	.bmdma_setup            = ata_bmdma_setup_pio,
 	.bmdma_start            = ata_bmdma_start_pio,
-	.fill_sg		= ata_fill_sg,
+	.qc_prep		= ata_qc_prep,
 	.eng_timeout		= ata_eng_timeout,
 	.irq_handler		= ata_interrupt,
 	.scr_read		= sis_scr_read,
diff -Nru a/drivers/scsi/sata_svw.c b/drivers/scsi/sata_svw.c
--- a/drivers/scsi/sata_svw.c	2004-06-21 23:52:19 -04:00
+++ b/drivers/scsi/sata_svw.c	2004-06-21 23:52:19 -04:00
@@ -234,7 +234,7 @@
 	.phy_reset		= sata_phy_reset,
 	.bmdma_setup            = ata_bmdma_setup_mmio,
 	.bmdma_start            = ata_bmdma_start_mmio,
-	.fill_sg		= ata_fill_sg,
+	.qc_prep		= ata_qc_prep,
 	.eng_timeout		= ata_eng_timeout,
 	.irq_handler		= ata_interrupt,
 	.scr_read		= k2_sata_scr_read,
diff -Nru a/drivers/scsi/sata_sx4.c b/drivers/scsi/sata_sx4.c
--- a/drivers/scsi/sata_sx4.c	2004-06-21 23:52:19 -04:00
+++ b/drivers/scsi/sata_sx4.c	2004-06-21 23:52:19 -04:00
@@ -153,7 +153,7 @@
 static void pdc_20621_phy_reset (struct ata_port *ap);
 static int pdc_port_start(struct ata_port *ap);
 static void pdc_port_stop(struct ata_port *ap);
-static void pdc20621_fill_sg(struct ata_queued_cmd *qc);
+static void pdc20621_qc_prep(struct ata_queued_cmd *qc);
 static void pdc_tf_load_mmio(struct ata_port *ap, struct ata_taskfile *tf);
 static void pdc_exec_command_mmio(struct ata_port *ap, struct ata_taskfile *tf);
 static void pdc20621_host_stop(struct ata_host_set *host_set);
@@ -201,7 +201,7 @@
 	.phy_reset		= pdc_20621_phy_reset,
 	.bmdma_setup            = pdc20621_dma_setup,
 	.bmdma_start            = pdc20621_dma_start,
-	.fill_sg		= pdc20621_fill_sg,
+	.qc_prep		= pdc20621_qc_prep,
 	.eng_timeout		= pdc_eng_timeout,
 	.irq_handler		= pdc20621_interrupt,
 	.port_start		= pdc_port_start,
@@ -435,7 +435,7 @@
 		buf32[dw + 3]);
 }
 
-static void pdc20621_fill_sg(struct ata_queued_cmd *qc)
+static void pdc20621_qc_prep(struct ata_queued_cmd *qc)
 {
 	struct scatterlist *sg = qc->sg;
 	struct ata_port *ap = qc->ap;
@@ -446,6 +446,9 @@
 	unsigned int portno = ap->port_no;
 	unsigned int i, last, idx, total_len = 0, sgt_len;
 	u32 *buf = (u32 *) &pp->dimm_buf[PDC_DIMM_HEADER_SZ];
+
+	if (!(qc->flags & ATA_QCFLAG_SG))
+		return;
 
 	VPRINTK("ata%u: ENTER\n", ap->id);
 
diff -Nru a/drivers/scsi/sata_via.c b/drivers/scsi/sata_via.c
--- a/drivers/scsi/sata_via.c	2004-06-21 23:52:19 -04:00
+++ b/drivers/scsi/sata_via.c	2004-06-21 23:52:19 -04:00
@@ -109,7 +109,7 @@
 
 	.bmdma_setup            = ata_bmdma_setup_pio,
 	.bmdma_start            = ata_bmdma_start_pio,
-	.fill_sg		= ata_fill_sg,
+	.qc_prep		= ata_qc_prep,
 	.eng_timeout		= ata_eng_timeout,
 
 	.irq_handler		= ata_interrupt,
diff -Nru a/drivers/scsi/sata_vsc.c b/drivers/scsi/sata_vsc.c
--- a/drivers/scsi/sata_vsc.c	2004-06-21 23:52:19 -04:00
+++ b/drivers/scsi/sata_vsc.c	2004-06-21 23:52:19 -04:00
@@ -216,7 +216,7 @@
 	.phy_reset		= sata_phy_reset,
 	.bmdma_setup            = ata_bmdma_setup_mmio,
 	.bmdma_start            = ata_bmdma_start_mmio,
-	.fill_sg		= ata_fill_sg,
+	.qc_prep		= ata_qc_prep,
 	.eng_timeout		= ata_eng_timeout,
 	.irq_handler		= vsc_sata_interrupt,
 	.scr_read		= vsc_sata_scr_read,
diff -Nru a/include/linux/libata.h b/include/linux/libata.h
--- a/include/linux/libata.h	2004-06-21 23:52:19 -04:00
+++ b/include/linux/libata.h	2004-06-21 23:52:19 -04:00
@@ -134,15 +134,6 @@
 	BUS_IDENTIFY		= 8,
 	BUS_PACKET		= 9,
 
-	/* thread states */
-	THR_UNKNOWN		= 0,
-	THR_PORT_RESET		= (THR_UNKNOWN + 1),
-	THR_AWAIT_DEATH		= (THR_PORT_RESET + 1),
-	THR_PROBE_FAILED	= (THR_AWAIT_DEATH + 1),
-	THR_IDLE		= (THR_PROBE_FAILED + 1),
-	THR_PROBE_SUCCESS	= (THR_IDLE + 1),
-	THR_PROBE_START		= (THR_PROBE_SUCCESS + 1),
-
 	/* SATA port states */
 	PORT_UNKNOWN		= 0,
 	PORT_ENABLED		= 1,
@@ -294,18 +285,12 @@
 	struct ata_host_stats	stats;
 	struct ata_host_set	*host_set;
 
-	struct semaphore	probe_sem;
-
-	unsigned int		thr_state;
-
 	struct tq_struct	packet_task;
 
 	struct tq_struct	pio_task;
 	unsigned int		pio_task_state;
 	unsigned long		pio_task_timeout;
 
-	struct tq_struct	probe_task;
-
 	void			*private_data;
 };
 
@@ -330,7 +315,7 @@
 
 	void (*bmdma_setup) (struct ata_queued_cmd *qc);
 	void (*bmdma_start) (struct ata_queued_cmd *qc);
-	void (*fill_sg) (struct ata_queued_cmd *qc);
+	void (*qc_prep) (struct ata_queued_cmd *qc);
 	void (*eng_timeout) (struct ata_port *ap);
 
 	irqreturn_t (*irq_handler)(int, void *, struct pt_regs *);
@@ -390,7 +375,7 @@
 extern int ata_port_start (struct ata_port *ap);
 extern void ata_port_stop (struct ata_port *ap);
 extern irqreturn_t ata_interrupt (int irq, void *dev_instance, struct pt_regs *regs);
-extern void ata_fill_sg(struct ata_queued_cmd *qc);
+extern void ata_qc_prep(struct ata_queued_cmd *qc);
 extern void ata_dev_id_string(struct ata_device *dev, unsigned char *s,
 			      unsigned int ofs, unsigned int len);
 extern void ata_bmdma_setup_mmio (struct ata_queued_cmd *qc);
@@ -557,6 +542,46 @@
 static inline unsigned int sata_dev_present(struct ata_port *ap)
 {
 	return ((scr_read(ap, SCR_STATUS) & 0xf) == 0x3) ? 1 : 0;
+}
+
+static inline void ata_bmdma_stop(struct ata_port *ap)
+{
+	if (ap->flags & ATA_FLAG_MMIO) {
+		void *mmio = (void *) ap->ioaddr.bmdma_addr;
+
+		/* clear start/stop bit */
+		writeb(readb(mmio + ATA_DMA_CMD) & ~ATA_DMA_START,
+		      mmio + ATA_DMA_CMD);
+	} else {
+		/* clear start/stop bit */
+		outb(inb(ap->ioaddr.bmdma_addr + ATA_DMA_CMD) & ~ATA_DMA_START,
+		    ap->ioaddr.bmdma_addr + ATA_DMA_CMD);
+	}
+
+	/* one-PIO-cycle guaranteed wait, per spec, for HDMA1:0 transition */
+	ata_altstatus(ap);	      /* dummy read */
+}
+
+static inline void ata_bmdma_ack_irq(struct ata_port *ap)
+{
+	if (ap->flags & ATA_FLAG_MMIO) {
+		void *mmio = ((void *) ap->ioaddr.bmdma_addr) + ATA_DMA_STATUS;
+		writeb(readb(mmio), mmio);
+	} else {
+		unsigned long addr = ap->ioaddr.bmdma_addr + ATA_DMA_STATUS;
+		outb(inb(addr), addr);
+	}
+}
+
+static inline u8 ata_bmdma_status(struct ata_port *ap)
+{
+	u8 host_stat;
+	if (ap->flags & ATA_FLAG_MMIO) {
+		void *mmio = (void *) ap->ioaddr.bmdma_addr;
+		host_stat = readb(mmio + ATA_DMA_STATUS);
+	} else
+		host_stat = inb(ap->ioaddr.bmdma_addr + ATA_DMA_STATUS);
+	return host_stat;
 }
 
 #endif /* __LINUX_LIBATA_H__ */
