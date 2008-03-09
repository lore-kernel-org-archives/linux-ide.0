From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 2/4] ide: add IDE_HFLAG_SERIALIZE_DMA host flag
Date: Sun, 9 Mar 2008 16:59:54 +0100
Message-ID: <200803091659.54507.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.153]:11253 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752473AbYCIPso (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 9 Mar 2008 11:48:44 -0400
Received: by fg-out-1718.google.com with SMTP id e21so1566575fga.17
        for <linux-ide@vger.kernel.org>; Sun, 09 Mar 2008 08:48:43 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

* Add IDE_HFLAG_SERIALIZE_DMA host flag to serialize ports
  if DMA is available and handle it in ide_init_port().

* Convert sl82c105 host driver to use this new flag.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-probe.c    |    7 +++++--
 drivers/ide/pci/sl82c105.c |    5 ++---
 include/linux/ide.h        |    2 ++
 3 files changed, 9 insertions(+), 5 deletions(-)

Index: b/drivers/ide/ide-probe.c
===================================================================
--- a/drivers/ide/ide-probe.c
+++ b/drivers/ide/ide-probe.c
@@ -1364,8 +1364,11 @@ static void ide_init_port(ide_hwif_t *hw
 	if (hwif->chipset != ide_dtc2278 || hwif->channel == 0)
 		hwif->port_ops = d->port_ops;
 
-	if ((d->host_flags & IDE_HFLAG_SERIALIZE) && hwif->mate)
-		hwif->mate->serialized = hwif->serialized = 1;
+	if ((d->host_flags & IDE_HFLAG_SERIALIZE) ||
+	    ((d->host_flags & IDE_HFLAG_SERIALIZE_DMA) && hwif->dma_base)) {
+		if (hwif->mate)
+			hwif->mate->serialized = hwif->serialized = 1;
+	}
 
 	hwif->swdma_mask = d->swdma_mask;
 	hwif->mwdma_mask = d->mwdma_mask;
Index: b/drivers/ide/pci/sl82c105.c
===================================================================
--- a/drivers/ide/pci/sl82c105.c
+++ b/drivers/ide/pci/sl82c105.c
@@ -296,9 +296,6 @@ static void __devinit init_hwif_sl82c105
 	hwif->dma_start			= &sl82c105_dma_start;
 	hwif->ide_dma_end		= &sl82c105_dma_end;
 	hwif->dma_timeout		= &sl82c105_dma_timeout;
-
-	if (hwif->mate)
-		hwif->serialized = hwif->mate->serialized = 1;
 }
 
 static const struct ide_port_ops sl82c105_port_ops = {
@@ -319,6 +316,7 @@ static const struct ide_port_info sl82c1
 #if defined(CONFIG_LOPEC) || defined(CONFIG_SANDPOINT)
 			  IDE_HFLAG_FORCE_LEGACY_IRQS |
 #endif
+			  IDE_HFLAG_SERIALIZE_DMA |
 			  IDE_HFLAG_NO_AUTODMA,
 	.pio_mask	= ATA_PIO5,
 	.mwdma_mask	= ATA_MWDMA2,
@@ -338,6 +336,7 @@ static int __devinit sl82c105_init_one(s
 				 "revision %d, BM-DMA disabled\n", rev);
 		d.init_hwif = NULL;
 		d.mwdma_mask = 0;
+		d.host_flags &= ~IDE_HFLAG_SERIALIZE_DMA;
 	}
 
 	return ide_setup_pci_device(dev, &d);
Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -1086,6 +1086,8 @@ enum {
 	/* unmask IRQs */
 	IDE_HFLAG_UNMASK_IRQS		= (1 << 25),
 	IDE_HFLAG_ABUSE_SET_DMA_MODE	= (1 << 26),
+	/* serialize ports if DMA is possible (for sl82c105) */
+	IDE_HFLAG_SERIALIZE_DMA		= (1 << 27),
 	/* force host out of "simplex" mode */
 	IDE_HFLAG_CLEAR_SIMPLEX		= (1 << 28),
 	/* DSC overlap is unsupported */
