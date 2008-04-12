From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 4/5] ide: remove ->dma_vendor{1,3} fields from ide_hwif_t
Date: Sat, 12 Apr 2008 21:05:09 +0200
Message-ID: <200804122105.09585.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.152]:16218 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755970AbYDLSvo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 12 Apr 2008 14:51:44 -0400
Received: by fg-out-1718.google.com with SMTP id l27so857247fgb.17
        for <linux-ide@vger.kernel.org>; Sat, 12 Apr 2008 11:51:44 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

* Use 'hwif->dma_base + {1,3}' instead of hwif->dma_vendor{1,3} in
  pdc202xx_new host driver.

* Remove no longer needed ->dma_vendor{1,3} fields from ide_hwif_t.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-dma.c          |    4 ----
 drivers/ide/pci/pdc202xx_new.c |    8 ++++----
 include/linux/ide.h            |    2 --
 3 files changed, 4 insertions(+), 10 deletions(-)

Index: b/drivers/ide/ide-dma.c
===================================================================
--- a/drivers/ide/ide-dma.c
+++ b/drivers/ide/ide-dma.c
@@ -858,12 +858,8 @@ void ide_setup_dma(ide_hwif_t *hwif, uns
 
 	if (!hwif->dma_command)
 		hwif->dma_command	= hwif->dma_base + 0;
-	if (!hwif->dma_vendor1)
-		hwif->dma_vendor1	= hwif->dma_base + 1;
 	if (!hwif->dma_status)
 		hwif->dma_status	= hwif->dma_base + 2;
-	if (!hwif->dma_vendor3)
-		hwif->dma_vendor3	= hwif->dma_base + 3;
 	if (!hwif->dma_prdtable)
 		hwif->dma_prdtable	= hwif->dma_base + 4;
 
Index: b/drivers/ide/pci/pdc202xx_new.c
===================================================================
--- a/drivers/ide/pci/pdc202xx_new.c
+++ b/drivers/ide/pci/pdc202xx_new.c
@@ -83,8 +83,8 @@ static u8 get_indexed_reg(ide_hwif_t *hw
 {
 	u8 value;
 
-	outb(index, hwif->dma_vendor1);
-	value = inb(hwif->dma_vendor3);
+	outb(index, hwif->dma_base + 1);
+	value = inb(hwif->dma_base + 3);
 
 	DBG("index[%02X] value[%02X]\n", index, value);
 	return value;
@@ -97,8 +97,8 @@ static u8 get_indexed_reg(ide_hwif_t *hw
  */
 static void set_indexed_reg(ide_hwif_t *hwif, u8 index, u8 value)
 {
-	outb(index, hwif->dma_vendor1);
-	outb(value, hwif->dma_vendor3);
+	outb(index, hwif->dma_base + 1);
+	outb(value, hwif->dma_base + 3);
 	DBG("index[%02X] value[%02X]\n", index, value);
 }
 
Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -510,9 +510,7 @@ typedef struct hwif_s {
 
 	unsigned long	dma_base;	/* base addr for dma ports */
 	unsigned long	dma_command;	/* dma command register */
-	unsigned long	dma_vendor1;	/* dma vendor 1 register */
 	unsigned long	dma_status;	/* dma status register */
-	unsigned long	dma_vendor3;	/* dma vendor 3 register */
 	unsigned long	dma_prdtable;	/* actual prd table address */
 
 	unsigned long	config_data;	/* for use by chipset-specific code */
