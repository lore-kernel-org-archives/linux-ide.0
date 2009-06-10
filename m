From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH 8/9] siimage: implement test_irq() method
Date: Wed, 10 Jun 2009 23:05:36 +0400
Message-ID: <200906102305.36117.sshtylyov@ru.mvista.com>
References: <200702140101.26639.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:37736 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753330AbZFJTEB (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 10 Jun 2009 15:04:01 -0400
In-Reply-To: <200702140101.26639.sshtylyov@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org

Implement test_irq() method.  Remove interrupt bit test (not trusted anyway)
from siimage_io_dma_test_irq() and siimage_mmio_dma_test_irq(); this allows to
replace the former function with now identical ide_dma_test_irq()...

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
The patch is atop of ide-2.6.git 'for-next' branch.

 drivers/ide/siimage.c |   26 +++++++-------------------
 1 files changed, 7 insertions(+), 19 deletions(-)

Index: ide-2.6/drivers/ide/siimage.c
===================================================================
--- ide-2.6.orig/drivers/ide/siimage.c
+++ ide-2.6/drivers/ide/siimage.c
@@ -337,24 +337,14 @@ static void sil_set_dma_mode(ide_drive_t
 	sil_iowrite16(dev, ultra, ua);
 }
 
-/* returns 1 if dma irq issued, 0 otherwise */
-static int siimage_io_dma_test_irq(ide_drive_t *drive)
+static int sil_test_irq(ide_hwif_t *hwif)
 {
-	ide_hwif_t *hwif	= drive->hwif;
 	struct pci_dev *dev	= to_pci_dev(hwif->dev);
-	u8 dma_altstat		= 0;
 	unsigned long addr	= siimage_selreg(hwif, 1);
+	u8 val			= sil_ioread8(dev, addr);
 
-	/* return 1 if INTR asserted */
-	if (inb(hwif->dma_base + ATA_DMA_STATUS) & 4)
-		return 1;
-
-	/* return 1 if Device INTR asserted */
-	pci_read_config_byte(dev, addr, &dma_altstat);
-	if (dma_altstat & 8)
-		return 0;	/* return 1; */
-
-	return 0;
+	/* Return 1 if INTRQ asserted */
+	return (val & 8) ? 1 : 0;
 }
 
 /**
@@ -397,10 +387,6 @@ static int siimage_mmio_dma_test_irq(ide
 	if (readb((void __iomem *)(hwif->dma_base + ATA_DMA_STATUS)) & 4)
 		return 1;
 
-	/* return 1 if Device INTR asserted */
-	if (readb((void __iomem *)addr) & 8)
-		return 0;	/* return 1; */
-
 	return 0;
 }
 
@@ -409,7 +395,7 @@ static int siimage_dma_test_irq(ide_driv
 	if (drive->hwif->host_flags & IDE_HFLAG_MMIO)
 		return siimage_mmio_dma_test_irq(drive);
 	else
-		return siimage_io_dma_test_irq(drive);
+		return ide_dma_test_irq(drive);
 }
 
 /**
@@ -694,6 +680,7 @@ static const struct ide_port_ops sil_pat
 	.set_pio_mode		= sil_set_pio_mode,
 	.set_dma_mode		= sil_set_dma_mode,
 	.quirkproc		= sil_quirkproc,
+	.test_irq		= sil_test_irq,
 	.udma_filter		= sil_pata_udma_filter,
 	.cable_detect		= sil_cable_detect,
 };
@@ -704,6 +691,7 @@ static const struct ide_port_ops sil_sat
 	.reset_poll		= sil_sata_reset_poll,
 	.pre_reset		= sil_sata_pre_reset,
 	.quirkproc		= sil_quirkproc,
+	.test_irq		= sil_test_irq,
 	.udma_filter		= sil_sata_udma_filter,
 	.cable_detect		= sil_cable_detect,
 };

