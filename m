From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: PATCH: Fix HPT372 oops (not the ideal way for now) and add
	debug/2.4 sync ups
Date: Fri, 05 Nov 2004 16:23:33 +0000
Message-ID: <1099671811.5567.34.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from clock-tower.bc.nu ([81.2.110.250]:6853 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262733AbUKER00 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 5 Nov 2004 12:26:26 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>

diff --exclude-from /usr/src/exclude -u --new-file --recursive linux.vanilla-2.6.10rc1/drivers/ide/pci/hpt366.c linux-2.6.10rc1/drivers/ide/pci/hpt366.c
--- linux.vanilla-2.6.10rc1/drivers/ide/pci/hpt366.c	2004-11-05 15:42:15.000000000 +0000
+++ linux-2.6.10rc1/drivers/ide/pci/hpt366.c	2004-11-05 16:08:46.000000000 +0000
@@ -10,6 +10,11 @@
  * donation of an ABit BP6 mainboard, processor, and memory acellerated
  * development and support.
  *
+ *
+ * Highpoint have their own driver (source except for the raid part)
+ * available from http://www.highpoint-tech.com/hpt3xx-opensource-v131.tgz
+ * This may be useful to anyone wanting to work on the mainstream hpt IDE.
+ *
  * Note that final HPT370 support was done by force extraction of GPL.
  *
  * - add function for getting/setting power status of drive
@@ -169,6 +174,12 @@
 }
 #endif  /* defined(DISPLAY_HPT366_TIMINGS) && defined(CONFIG_PROC_FS) */
 
+/*
+ *	This wants fixing so that we do everything not by classrev
+ *	(which breaks on the newest chips) but by creating an
+ *	enumeration of chip variants and using that
+ */
+ 
 static u32 hpt_revision (struct pci_dev *dev)
 {
 	u32 class_rev;
@@ -466,7 +477,11 @@
 {
 	u8 speed = ide_dma_speed(drive, hpt3xx_ratemask(drive));
 
-	if (!(speed))
+	if (!speed)
+		return 0;
+		
+	/* If we don't have any timings we can't do a lot */
+	if (pci_get_drvdata(HWIF(drive)->pci_dev) == NULL)
 		return 0;
 
 	(void) hpt3xx_tune_chipset(drive, speed);
@@ -886,7 +901,11 @@
 
 	/*
 	 * default to pci clock. make sure MA15/16 are set to output
-	 * to prevent drives having problems with 40-pin cables.
+	 * to prevent drives having problems with 40-pin cables. Needed
+	 * for some drives such as IBM-DTLA which will not enter ready
+	 * state on reset when PDIAG is a input.
+	 *
+	 * ToDo: should we set 0x21 when using PLL mode ?
 	 */
 	pci_write_config_byte(dev, 0x5b, 0x23);
 
@@ -981,6 +1000,9 @@
 	 * result in slow reads when using a 33MHz PCI clock. we also
 	 * don't like to use the PLL because it will cause glitches
 	 * on PRST/SRST when the HPT state engine gets reset.
+	 *
+	 * ToDo: Use 66MHz PLL when ATA133 devices are present on a
+	 * 372 device so we can get ATA133 support
 	 */
 	if (pci_get_drvdata(dev)) 
 		goto init_hpt37X_done;
@@ -1030,6 +1052,9 @@
 	} 
 
 init_hpt37X_done:
+	if (!pci_get_drvdata(dev))
+		printk(KERN_ERR "HPT37X%s: unknown bus timing [%d %d].\n", 
+			is_372n?"N":"", pll, freq);
 	/* reset state engine */
 	pci_write_config_byte(dev, 0x50, 0x37); 
 	pci_write_config_byte(dev, 0x54, 0x37); 

