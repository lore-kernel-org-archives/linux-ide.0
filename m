From: "Jordan Crouse" <jordan.crouse@amd.com>
Subject: [PATCH] Enable MwDMA for AU1200 IDE driver
Date: Fri, 10 Feb 2006 11:20:33 -0700
Message-ID: <20060210182033.GA24353@cosmic.amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary=dDRMvlgZJXvWKvBx
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from amdext4.amd.com ([163.181.251.6]:15514 "EHLO amdext4.amd.com")
	by vger.kernel.org with ESMTP id S932165AbWBJSQL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 10 Feb 2006 13:16:11 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-mips@linux-mips.org, linux-ide@vger.kernel.org
Cc: enrico.walther@amd.com


--dDRMvlgZJXvWKvBx
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Greetings all - the attached patch enables MwDMA mode for the AU1200
IDE driver.  If one heavily uses the USB on the DB1200 board with IDE
in PIO mode, you may experience hangs from overloading the bus with
interrupts - this should help.  Since it is obvious that this is the
desired mode, I'm adding it to the defconfig to enable by default.

Also, I snuck in a fix for a warning (mixed code and declarations = evil!).
Applies against latest lmo git, but it should work for linux-ide as well.

Regards,
Jordan
-- 
Jordan Crouse
Senior Linux Engineer
AMD - Personal Connectivity Solutions Group
<www.amd.com/embeddedprocessors>

--dDRMvlgZJXvWKvBx
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline;
 filename=auide-fixes.patch
Content-Transfer-Encoding: 7bit

[PATCH] Enable MWDMA mode for the AU1200 IDE driver

This enables MwDMA mode for the AU1200 driver - this will benefit
anybody using IDE + USB, which together seem to cause hangs when IDE is 
in PIO due to the large number of interrupts on the same bus.

Signed-off-by: Jordan Crouse <jordan.crouse@amd.com>
---

 arch/mips/configs/db1200_defconfig        |    4 ++--
 drivers/ide/mips/au1xxx-ide.c             |   14 ++++++++++++--
 include/asm-mips/mach-au1x00/au1xxx_ide.h |    9 ---------
 3 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/arch/mips/configs/db1200_defconfig b/arch/mips/configs/db1200_defconfig
index 9288847..355b32f 100644
--- a/arch/mips/configs/db1200_defconfig
+++ b/arch/mips/configs/db1200_defconfig
@@ -497,8 +497,8 @@ CONFIG_BLK_DEV_IDECS=m
 #
 CONFIG_IDE_GENERIC=y
 CONFIG_BLK_DEV_IDE_AU1XXX=y
-CONFIG_BLK_DEV_IDE_AU1XXX_PIO_DBDMA=y
-# CONFIG_BLK_DEV_IDE_AU1XXX_MDMA2_DBDMA is not set
+#CONFIG_BLK_DEV_IDE_AU1XXX_PIO_DBDMA is not set
+CONFIG_BLK_DEV_IDE_AU1XXX_MDMA2_DBDMA=y
 CONFIG_BLK_DEV_IDE_AU1XXX_SEQTS_PER_RQ=128
 # CONFIG_IDE_ARM is not set
 # CONFIG_BLK_DEV_IDEDMA is not set
diff --git a/drivers/ide/mips/au1xxx-ide.c b/drivers/ide/mips/au1xxx-ide.c
index 32431dc..c2bf766 100644
--- a/drivers/ide/mips/au1xxx-ide.c
+++ b/drivers/ide/mips/au1xxx-ide.c
@@ -652,6 +652,7 @@ static int au_ide_probe(struct device *d
 	struct platform_device *pdev = to_platform_device(dev);
 	_auide_hwif *ahwif = &auide_hwif;
 	ide_hwif_t *hwif;
+	hw_regs_t *hw;
 	struct resource *res;
 	int ret = 0;
 
@@ -690,17 +691,26 @@ static int au_ide_probe(struct device *d
 	/* FIXME:  This might possibly break PCMCIA IDE devices */
 
 	hwif                            = &ide_hwifs[pdev->id];
-	hw_regs_t *hw 			= &hwif->hw;
+	hw				= &hwif->hw;
 	hwif->irq = hw->irq             = ahwif->irq;
 	hwif->chipset                   = ide_au1xxx;
 
 	auide_setup_ports(hw, ahwif);
 	memcpy(hwif->io_ports, hw->io_ports, sizeof(hwif->io_ports));
 
+#ifdef CONFIG_BLK_DEV_IDE_AU1XXX_SEQTS_PER_RQ
+	hwif->rqsize = CONFIG_BLK_DEV_IDE_AU1XXX_SEQTS_PER_RQ;
+	hwif->rqsize = ((hwif->rqsize > AU1XXX_ATA_RQSIZE)
+			|| (hwif->rqsize < 32)) 
+                        ? AU1XXX_ATA_RQSIZE : hwif->rqsize;
+#else /* if kernel config is not set */
+	hwif->rqsize                    = AU1XXX_ATA_RQSIZE;
+#endif
+			
 	hwif->ultra_mask                = 0x0;  /* Disable Ultra DMA */
 #ifdef CONFIG_BLK_DEV_IDE_AU1XXX_MDMA2_DBDMA
 	hwif->mwdma_mask                = 0x07; /* Multimode-2 DMA  */
-	hwif->swdma_mask                = 0x00;
+	hwif->swdma_mask                = 0x07;
 #else
 	hwif->mwdma_mask                = 0x0;
 	hwif->swdma_mask                = 0x0;
diff --git a/include/asm-mips/mach-au1x00/au1xxx_ide.h b/include/asm-mips/mach-au1x00/au1xxx_ide.h
index 5dab100..b9713c3 100644
--- a/include/asm-mips/mach-au1x00/au1xxx_ide.h
+++ b/include/asm-mips/mach-au1x00/au1xxx_ide.h
@@ -42,11 +42,6 @@
         #define AU1XXX_ATA_RQSIZE       128
 #endif
 
-/* Disable Burstable-Support for DBDMA */
-#ifndef CONFIG_BLK_DEV_IDE_AU1XXX_BURSTABLE_ON
-        #define CONFIG_BLK_DEV_IDE_AU1XXX_BURSTABLE_ON  0
-#endif
-
 typedef struct
 {
         u32                     tx_dev_id, rx_dev_id, target_dev_id;
@@ -65,10 +60,6 @@ typedef struct
 } _auide_hwif;
 
 #ifdef CONFIG_BLK_DEV_IDE_AU1XXX_MDMA2_DBDMA
-struct drive_list_entry {
-	const char *id_model;
-	const char *id_firmware;
-};
 
 /* HD white list */
 static const struct drive_list_entry dma_white_list [] = {

--dDRMvlgZJXvWKvBx--

