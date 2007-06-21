From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [RFT] hpt366: reset DMA state machine on timeouts
Date: Thu, 21 Jun 2007 21:54:47 +0400
Message-ID: <200706212154.47398.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:64531 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756669AbXFURxG (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 21 Jun 2007 13:53:06 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linas@austin.ibm.com
Cc: linux-ide@vger.kernel.org

Reset HPT36x's DMA state machine on a DMA timeout the way it's done for HPT370.

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
Linas, here's what I've come up with -- this should apply against 2.6.21.y.
Compile-tested only, not for merging.

 drivers/ide/pci/hpt366.c |   24 +++++++++++++++++++++++-
 1 files changed, 23 insertions(+), 1 deletion(-)

Index: linux-2.6/drivers/ide/pci/hpt366.c
===================================================================
--- linux-2.6.orig/drivers/ide/pci/hpt366.c
+++ linux-2.6/drivers/ide/pci/hpt366.c
@@ -752,6 +752,26 @@ static int hpt366_config_drive_xfer_rate
  * This is specific to the HPT366 UDMA chipset
  * by HighPoint|Triones Technologies, Inc.
  */
+static int hpt366_ide_dma_timeout(ide_drive_t *drive)
+{
+	ide_hwif_t *hwif	= HWIF(drive);
+	struct pci_dev *dev	= hwif->pci_dev;
+	u8 mcr1 = 0, mcr2	= 0;
+	u8 dma_cmd		= inb(hwif->dma_command);
+
+	/* Stop DMA */
+	outb(dma_cmd & ~0x01, hwif->dma_command);
+
+	/* Clear bus master state machine and S/G counter */
+	pci_read_config_byte (dev, 0x51, &mcr2);
+	pci_write_config_byte(dev, 0x51, (mcr2 | 0x03));
+	/* Clear buffers 0/1 */
+	pci_read_config_byte (dev, 0x50, &mcr1);
+	pci_write_config_byte(dev, 0x50, (mcr1 | 0x0c));
+
+	return __ide_dma_timeout(drive);
+}
+
 static int hpt366_ide_dma_lostirq(ide_drive_t *drive)
 {
 	struct pci_dev *dev = HWIF(drive)->pci_dev;
@@ -1368,8 +1388,10 @@ static void __devinit init_hwif_hpt366(i
 		hwif->dma_start 	= &hpt370_ide_dma_start;
 		hwif->ide_dma_end	= &hpt370_ide_dma_end;
 		hwif->ide_dma_timeout	= &hpt370_ide_dma_timeout;
-	} else
+	} else {
+		hwif->ide_dma_timeout	= &hpt366_ide_dma_timeout;
 		hwif->ide_dma_lostirq	= &hpt366_ide_dma_lostirq;
+	}
 
 	if (!noautodma)
 		hwif->autodma = 1;

