From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH 1/2] pata_hpt37x: use ATA_DMA_* constants
Date: Sat, 5 Dec 2009 00:37:43 +0400
Message-ID: <200912042337.43381.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([206.112.117.35]:11031 "HELO
	imap.sh.mvista.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S1757247AbZLDUga (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 4 Dec 2009 15:36:30 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk

Use ATA_DMA_* constants instead of the bare numbers for the BMIDE registers.

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
The patch is against the recent Linus' tree.

 drivers/ata/pata_hpt37x.c |   19 ++++++++++---------
 1 files changed, 10 insertions(+), 9 deletions(-)

Index: linux-2.6/drivers/ata/pata_hpt37x.c
===================================================================
--- linux-2.6.orig/drivers/ata/pata_hpt37x.c
+++ linux-2.6/drivers/ata/pata_hpt37x.c
@@ -454,24 +454,25 @@ static void hpt370_bmdma_stop(struct ata
 {
 	struct ata_port *ap = qc->ap;
 	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
-	u8 dma_stat = ioread8(ap->ioaddr.bmdma_addr + 2);
-	u8 dma_cmd;
 	void __iomem *bmdma = ap->ioaddr.bmdma_addr;
+	u8 dma_stat = ioread8(bmdma + ATA_DMA_STATUS);
+	u8 dma_cmd;
 
-	if (dma_stat & 0x01) {
+	if (dma_stat & ATA_DMA_ACTIVE) {
 		udelay(20);
-		dma_stat = ioread8(bmdma + 2);
+		dma_stat = ioread8(bmdma + ATA_DMA_STATUS);
 	}
-	if (dma_stat & 0x01) {
+	if (dma_stat & ATA_DMA_ACTIVE) {
 		/* Clear the engine */
 		pci_write_config_byte(pdev, 0x50 + 4 * ap->port_no, 0x37);
 		udelay(10);
 		/* Stop DMA */
-		dma_cmd = ioread8(bmdma );
-		iowrite8(dma_cmd & 0xFE, bmdma);
+		dma_cmd = ioread8(bmdma + ATA_DMA_CMD);
+		iowrite8(dma_cmd & ~ATA_DMA_START, bmdma + ATA_DMA_CMD);
 		/* Clear Error */
-		dma_stat = ioread8(bmdma + 2);
-		iowrite8(dma_stat | 0x06 , bmdma + 2);
+		dma_stat = ioread8(bmdma + ATA_DMA_STATUS);
+		iowrite8(dma_stat | ATA_DMA_INTR | ATA_DMA_ERR,
+			 bmdma + ATA_DMA_STATUS);
 		/* Clear the engine */
 		pci_write_config_byte(pdev, 0x50 + 4 * ap->port_no, 0x37);
 		udelay(10);

