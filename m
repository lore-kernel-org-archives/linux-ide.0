From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH 3/10] siimage: use ide_dma_test_irq() (take 2)
Date: Sat, 13 Jun 2009 17:30:05 +0400
Message-ID: <200906131730.05823.sshtylyov@ru.mvista.com>
References: <200702140101.26639.sshtylyov@ru.mvista.com> <200906102305.36117.sshtylyov@ru.mvista.com> <4A301BD3.80307@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:52397 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1765656AbZFMN2Z (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 13 Jun 2009 09:28:25 -0400
In-Reply-To: <4A301BD3.80307@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org

Remove interrupt bit test (not trusted anyway) from siimage_io_dma_test_irq()
and siimage_mmio_dma_test_irq() -- this allows to replace the former function
with now identical ide_dma_test_irq()...

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
The patch is atop of ide-2.6.git 'for-next' branch.

Changes since previous take:
- fixed warning about unused variable in siimage_mmio_dma_test_irq().

 drivers/ide/siimage.c |   27 +--------------------------
 1 files changed, 1 insertion(+), 26 deletions(-)

Index: ide-2.6/drivers/ide/siimage.c
===================================================================
--- ide-2.6.orig/drivers/ide/siimage.c
+++ ide-2.6/drivers/ide/siimage.c
@@ -337,26 +337,6 @@ static void sil_set_dma_mode(ide_drive_t
 	sil_iowrite16(dev, ultra, ua);
 }
 
-/* returns 1 if dma irq issued, 0 otherwise */
-static int siimage_io_dma_test_irq(ide_drive_t *drive)
-{
-	ide_hwif_t *hwif	= drive->hwif;
-	struct pci_dev *dev	= to_pci_dev(hwif->dev);
-	u8 dma_altstat		= 0;
-	unsigned long addr	= siimage_selreg(hwif, 1);
-
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
-}
-
 /**
  *	siimage_mmio_dma_test_irq	-	check we caused an IRQ
  *	@drive: drive we are testing
@@ -368,7 +348,6 @@ static int siimage_io_dma_test_irq(ide_d
 static int siimage_mmio_dma_test_irq(ide_drive_t *drive)
 {
 	ide_hwif_t *hwif	= drive->hwif;
-	unsigned long addr	= siimage_selreg(hwif, 0x1);
 	void __iomem *sata_error_addr
 		= (void __iomem *)hwif->sata_scr[SATA_ERROR_OFFSET];
 
@@ -397,10 +376,6 @@ static int siimage_mmio_dma_test_irq(ide
 	if (readb((void __iomem *)(hwif->dma_base + ATA_DMA_STATUS)) & 4)
 		return 1;
 
-	/* return 1 if Device INTR asserted */
-	if (readb((void __iomem *)addr) & 8)
-		return 0;	/* return 1; */
-
 	return 0;
 }
 
@@ -409,7 +384,7 @@ static int siimage_dma_test_irq(ide_driv
 	if (drive->hwif->host_flags & IDE_HFLAG_MMIO)
 		return siimage_mmio_dma_test_irq(drive);
 	else
-		return siimage_io_dma_test_irq(drive);
+		return ide_dma_test_irq(drive);
 }
 
 /**

