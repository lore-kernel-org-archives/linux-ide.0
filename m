From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 11/13] atiixp: remove ->dma_host_on and ->dma_host_off methods
Date: Tue, 13 Nov 2007 00:02:12 +0100
Message-ID: <200711130002.12321.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.188]:63392 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758061AbXKLW6b (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 12 Nov 2007 17:58:31 -0500
Received: by nf-out-0910.google.com with SMTP id g13so1250510nfb
        for <linux-ide@vger.kernel.org>; Mon, 12 Nov 2007 14:58:30 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


* Enable/disable UDMA in atiixp_set_dma_mode().

* Remove no longer needed atiixp_dma_host_{on,off}() and save_mdma_mode[].

* Bump driver version.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
Needs to be tested, I'll check it with SB400 unless somebody beats me to it...

 drivers/ide/pci/atiixp.c |   71 +++++++++++------------------------------------
 1 file changed, 18 insertions(+), 53 deletions(-)

Index: b/drivers/ide/pci/atiixp.c
===================================================================
--- a/drivers/ide/pci/atiixp.c
+++ b/drivers/ide/pci/atiixp.c
@@ -1,5 +1,5 @@
 /*
- *  linux/drivers/ide/pci/atiixp.c	Version 0.03	Aug 3 2007
+ *  linux/drivers/ide/pci/atiixp.c	Version 0.05	Nov 9 2007
  *
  *  Copyright (C) 2003 ATI Inc. <hyu@ati.com>
  *  Copyright (C) 2004,2007 Bartlomiej Zolnierkiewicz
@@ -43,47 +43,8 @@ static atiixp_ide_timing mdma_timing[] =
 	{ 0x02, 0x00 },
 };
 
-static int save_mdma_mode[4];
-
 static DEFINE_SPINLOCK(atiixp_lock);
 
-static void atiixp_dma_host_on(ide_drive_t *drive)
-{
-	struct pci_dev *dev = drive->hwif->pci_dev;
-	unsigned long flags;
-	u16 tmp16;
-
-	spin_lock_irqsave(&atiixp_lock, flags);
-
-	pci_read_config_word(dev, ATIIXP_IDE_UDMA_CONTROL, &tmp16);
-	if (save_mdma_mode[drive->dn])
-		tmp16 &= ~(1 << drive->dn);
-	else
-		tmp16 |= (1 << drive->dn);
-	pci_write_config_word(dev, ATIIXP_IDE_UDMA_CONTROL, tmp16);
-
-	spin_unlock_irqrestore(&atiixp_lock, flags);
-
-	ide_dma_host_on(drive);
-}
-
-static void atiixp_dma_host_off(ide_drive_t *drive)
-{
-	struct pci_dev *dev = drive->hwif->pci_dev;
-	unsigned long flags;
-	u16 tmp16;
-
-	spin_lock_irqsave(&atiixp_lock, flags);
-
-	pci_read_config_word(dev, ATIIXP_IDE_UDMA_CONTROL, &tmp16);
-	tmp16 &= ~(1 << drive->dn);
-	pci_write_config_word(dev, ATIIXP_IDE_UDMA_CONTROL, tmp16);
-
-	spin_unlock_irqrestore(&atiixp_lock, flags);
-
-	ide_dma_host_off(drive);
-}
-
 /**
  *	atiixp_set_pio_mode	-	set host controller for PIO mode
  *	@drive: drive
@@ -132,26 +93,33 @@ static void atiixp_set_dma_mode(ide_driv
 	int timing_shift = (drive->dn & 2) ? 16 : 0 + (drive->dn & 1) ? 0 : 8;
 	u32 tmp32;
 	u16 tmp16;
+	u16 udma_ctl = 0;
 
 	spin_lock_irqsave(&atiixp_lock, flags);
 
-	save_mdma_mode[drive->dn] = 0;
+	pci_read_config_word(dev, ATIIXP_IDE_UDMA_CONTROL, &udma_ctl);
+
 	if (speed >= XFER_UDMA_0) {
 		pci_read_config_word(dev, ATIIXP_IDE_UDMA_MODE, &tmp16);
 		tmp16 &= ~(0x07 << (drive->dn * 4));
 		tmp16 |= ((speed & 0x07) << (drive->dn * 4));
 		pci_write_config_word(dev, ATIIXP_IDE_UDMA_MODE, tmp16);
-	} else {
-		if ((speed >= XFER_MW_DMA_0) && (speed <= XFER_MW_DMA_2)) {
-			save_mdma_mode[drive->dn] = speed;
-			pci_read_config_dword(dev, ATIIXP_IDE_MDMA_TIMING, &tmp32);
-			tmp32 &= ~(0xff << timing_shift);
-			tmp32 |= (mdma_timing[speed & 0x03].recover_width << timing_shift) |
-				(mdma_timing[speed & 0x03].command_width << (timing_shift + 4));
-			pci_write_config_dword(dev, ATIIXP_IDE_MDMA_TIMING, tmp32);
-		}
+
+		udma_ctl |= (1 << drive->dn);
+	} else if (speed >= XFER_MW_DMA_0) {
+		u8 i = speed & 0x03;
+
+		pci_read_config_dword(dev, ATIIXP_IDE_MDMA_TIMING, &tmp32);
+		tmp32 &= ~(0xff << timing_shift);
+		tmp32 |= (mdma_timing[i].recover_width << timing_shift) |
+			 (mdma_timing[i].command_width << (timing_shift + 4));
+		pci_write_config_dword(dev, ATIIXP_IDE_MDMA_TIMING, tmp32);
+
+		udma_ctl &= ~(1 << drive->dn);
 	}
 
+	pci_write_config_word(dev, ATIIXP_IDE_UDMA_CONTROL, udma_ctl);
+
 	spin_unlock_irqrestore(&atiixp_lock, flags);
 }
 
@@ -181,9 +149,6 @@ static void __devinit init_hwif_atiixp(i
 		hwif->cbl = ATA_CBL_PATA80;
 	else
 		hwif->cbl = ATA_CBL_PATA40;
-
-	hwif->dma_host_on = &atiixp_dma_host_on;
-	hwif->dma_host_off = &atiixp_dma_host_off;
 }
 
 static const struct ide_port_info atiixp_pci_info[] __devinitdata = {
