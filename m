From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 2/2] sl82c105: remove no longer needed ->selectproc method
Date: Tue, 6 Nov 2007 00:27:47 +0100
Message-ID: <200711060027.48047.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.184]:54179 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754738AbXKEXWL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 5 Nov 2007 18:22:11 -0500
Received: by nf-out-0910.google.com with SMTP id g13so1517624nfb
        for <linux-ide@vger.kernel.org>; Mon, 05 Nov 2007 15:22:09 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>


* Program register 0x40 in sl82c105_resetproc().

* Remove no longer needed sl82c105_selectproc() and pci_set_drvdata() calls.

Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/pci/sl82c105.c |   34 +++-------------------------------
 1 file changed, 3 insertions(+), 31 deletions(-)

Index: b/drivers/ide/pci/sl82c105.c
===================================================================
--- a/drivers/ide/pci/sl82c105.c
+++ b/drivers/ide/pci/sl82c105.c
@@ -219,35 +219,8 @@ static int sl82c105_dma_end(ide_drive_t 
 }
 
 /*
- * Ok, that is nasty, but we must make sure the DMA timings
- * won't be used for a PIO access. The solution here is
- * to make sure the 16 bits mode is diabled on the channel
- * when DMA is enabled, thus causing the chip to use PIO0
- * timings for those operations.
- */
-static void sl82c105_selectproc(ide_drive_t *drive)
-{
-	ide_hwif_t *hwif	= HWIF(drive);
-	struct pci_dev *dev	= hwif->pci_dev;
-	u32 val, old, mask;
-
-	//DBG(("sl82c105_selectproc(drive:%s)\n", drive->name));
-
-	mask = hwif->channel ? CTRL_P1F16 : CTRL_P0F16;
-	old = val = (u32)pci_get_drvdata(dev);
-	if (drive->using_dma)
-		val &= ~mask;
-	else
-		val |= mask;
-	if (old != val) {
-		pci_write_config_dword(dev, 0x40, val);	
-		pci_set_drvdata(dev, (void *)val);
-	}
-}
-
-/*
  * ATA reset will clear the 16 bits mode in the control
- * register, we need to update our cache
+ * register, we need to reprogram it
  */
 static void sl82c105_resetproc(ide_drive_t *drive)
 {
@@ -257,7 +230,8 @@ static void sl82c105_resetproc(ide_drive
 	DBG(("sl82c105_resetproc(drive:%s)\n", drive->name));
 
 	pci_read_config_dword(dev, 0x40, &val);
-	pci_set_drvdata(dev, (void *)val);
+	val |= (CTRL_P1F16 | CTRL_P0F16);
+	pci_write_config_dword(dev, 0x40, val);
 }
 
 /*
@@ -310,7 +284,6 @@ static unsigned int __devinit init_chips
 	pci_read_config_dword(dev, 0x40, &val);
 	val |= CTRL_P0EN | CTRL_P0F16 | CTRL_P1F16;
 	pci_write_config_dword(dev, 0x40, val);
-	pci_set_drvdata(dev, (void *)val);
 
 	return dev->irq;
 }
@@ -326,7 +299,6 @@ static void __devinit init_hwif_sl82c105
 
 	hwif->set_pio_mode	= &sl82c105_set_pio_mode;
 	hwif->set_dma_mode	= &sl82c105_set_dma_mode;
-	hwif->selectproc	= &sl82c105_selectproc;
 	hwif->resetproc 	= &sl82c105_resetproc;
 
 	if (!hwif->dma_base)
