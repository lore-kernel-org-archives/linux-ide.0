From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 1/2] hpt366: add hpt3xx_disable_fast_irq() helper
Date: Sat, 2 Aug 2008 19:15:03 +0200
Message-ID: <200808021915.03424.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.190]:7929 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751863AbYHBRTj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 2 Aug 2008 13:19:39 -0400
Received: by fk-out-0910.google.com with SMTP id 18so1268055fkq.5
        for <linux-ide@vger.kernel.org>; Sat, 02 Aug 2008 10:19:37 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Sergei Shtylyov <sshtylyov@ru.mvista.com>

* Factor out disabling of "fast interrupt" prediction from
  init_hwif_hpt366() to hpt3xx_disable_fast_irq() helper.

* Use hpt3xx_disable_fast_irq() in ->init_chipset instead of
  ->init_hwif method.

  This is a preparation for adding proper PCI PM support.

While at it:

* Cache chip type in chip_type variable in hpt3xx_disable_fast_irq().

There should be no functional changes caused by this patch.

Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/pci/hpt366.c |   58 ++++++++++++++++++++++++++---------------------
 1 file changed, 33 insertions(+), 25 deletions(-)

Index: b/drivers/ide/pci/hpt366.c
===================================================================
--- a/drivers/ide/pci/hpt366.c
+++ b/drivers/ide/pci/hpt366.c
@@ -969,6 +969,36 @@ static int __devinit hpt37x_calibrate_dp
 	return 1;
 }
 
+static void __devinit hpt3xx_disable_fast_irq(struct pci_dev *dev, u8 mcr_addr)
+{
+	struct ide_host *host	= pci_get_drvdata(dev);
+	struct hpt_info *info	= host->host_priv + (&dev->dev == host->dev[1]);
+	u8  chip_type		= info->chip_type;
+	u8  new_mcr, old_mcr	= 0;
+
+	/*
+	 * Disable the "fast interrupt" prediction.  Don't hold off
+	 * on interrupts. (== 0x01 despite what the docs say)
+	 */
+	pci_read_config_byte(dev, mcr_addr + 1, &old_mcr);
+
+	if (chip_type >= HPT374)
+		new_mcr = old_mcr & ~0x07;
+	else if (chip_type >= HPT370) {
+		new_mcr = old_mcr;
+		new_mcr &= ~0x02;
+#ifdef HPT_DELAY_INTERRUPT
+		new_mcr &= ~0x01;
+#else
+		new_mcr |=  0x01;
+#endif
+	} else					/* HPT366 and HPT368  */
+		new_mcr = old_mcr & ~0x80;
+
+	if (new_mcr != old_mcr)
+		pci_write_config_byte(dev, mcr_addr + 1, new_mcr);
+}
+
 static unsigned int __devinit init_chipset_hpt366(struct pci_dev *dev)
 {
 	unsigned long io_base	= pci_resource_start(dev, 4);
@@ -1207,9 +1237,11 @@ static unsigned int __devinit init_chips
 	 * NOTE: This register is only writeable via I/O space.
 	 */
 	if (chip_type == HPT371N && clock == ATA_CLOCK_66MHZ)
-
 		outb(inb(io_base + 0x9c) | 0x04, io_base + 0x9c);
 
+	hpt3xx_disable_fast_irq(dev, 0x50);
+	hpt3xx_disable_fast_irq(dev, 0x54);
+
 	return dev->irq;
 }
 
@@ -1265,7 +1297,6 @@ static void __devinit init_hwif_hpt366(i
 	struct hpt_info *info	= host->host_priv + (hwif->dev == host->dev[1]);
 	int serialize		= HPT_SERIALIZE_IO;
 	u8  chip_type		= info->chip_type;
-	u8  new_mcr, old_mcr	= 0;
 
 	/* Cache the channel's MISC. control registers' offset */
 	hwif->select_data	= hwif->channel ? 0x54 : 0x50;
@@ -1288,29 +1319,6 @@ static void __devinit init_hwif_hpt366(i
 	/* Serialize access to this device if needed */
 	if (serialize && hwif->mate)
 		hwif->serialized = hwif->mate->serialized = 1;
-
-	/*
-	 * Disable the "fast interrupt" prediction.  Don't hold off
-	 * on interrupts. (== 0x01 despite what the docs say)
-	 */
-	pci_read_config_byte(dev, hwif->select_data + 1, &old_mcr);
-
-	if (info->chip_type >= HPT374)
-		new_mcr = old_mcr & ~0x07;
-	else if (info->chip_type >= HPT370) {
-		new_mcr = old_mcr;
-		new_mcr &= ~0x02;
-
-#ifdef HPT_DELAY_INTERRUPT
-		new_mcr &= ~0x01;
-#else
-		new_mcr |=  0x01;
-#endif
-	} else					/* HPT366 and HPT368  */
-		new_mcr = old_mcr & ~0x80;
-
-	if (new_mcr != old_mcr)
-		pci_write_config_byte(dev, hwif->select_data + 1, new_mcr);
 }
 
 static int __devinit init_dma_hpt366(ide_hwif_t *hwif,
