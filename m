From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 2/6] au1xxx-ide: use ide_init_port_hw()
Date: Tue, 27 Nov 2007 23:56:15 +0100
Message-ID: <200711272356.15626.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.172]:44678 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752526AbXK0WxE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 27 Nov 2007 17:53:04 -0500
Received: by ug-out-1314.google.com with SMTP id z38so1367706ugc
        for <linux-ide@vger.kernel.org>; Tue, 27 Nov 2007 14:53:03 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/mips/au1xxx-ide.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

Index: b/drivers/ide/mips/au1xxx-ide.c
===================================================================
--- a/drivers/ide/mips/au1xxx-ide.c
+++ b/drivers/ide/mips/au1xxx-ide.c
@@ -625,12 +625,13 @@ static int au_ide_probe(struct device *d
 	/* FIXME:  This might possibly break PCMCIA IDE devices */
 
 	hwif                            = &ide_hwifs[pdev->id];
-	hwif->irq			= ahwif->irq;
-	hwif->chipset                   = ide_au1xxx;
 
 	memset(&hw, 0, sizeof(hw));
 	auide_setup_ports(&hw, ahwif);
-	memcpy(hwif->io_ports, hw.io_ports, sizeof(hwif->io_ports));
+	hw.irq = ahwif->irq;
+	hw.chipset = ide_au1xxx;
+
+	ide_init_port_hw(hwif, &hw);
 
 	hwif->ultra_mask                = 0x0;  /* Disable Ultra DMA */
 #ifdef CONFIG_BLK_DEV_IDE_AU1XXX_MDMA2_DBDMA
@@ -644,7 +645,6 @@ static int au_ide_probe(struct device *d
 	hwif->pio_mask = ATA_PIO4;
 	hwif->host_flags = IDE_HFLAG_POST_SET_MODE;
 
-	hwif->noprobe = 0;
 	hwif->drives[0].unmask          = 1;
 	hwif->drives[1].unmask          = 1;
 
