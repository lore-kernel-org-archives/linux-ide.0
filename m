From: Tejun Heo <tj@kernel.org>
Subject: [PATCH #upstream] ata_generic: drop hard coded DMA force logic for
 CENATEK
Date: Fri, 02 Jul 2010 14:41:24 +0200
Message-ID: <4C2DDE74.3070405@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:56919 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754550Ab0GBMlh (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 2 Jul 2010 08:41:37 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Andy Whitcroft <apw@canonical.com>

Commit 1529c69adc (ata_generic: implement ATA_GEN_* flags and force
enable DMA on MBP 7,1) implemented ATA_GEN_FORCE_DMA for forcing DMA
mode and applied it to CENATEK but forgot to remove the original hard
coded logic.  This is removal of redundant logic and doesn't affect
correctness.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reported-by: Andy Whitcroft <apw@canonical.com>
---
 drivers/ata/ata_generic.c |    4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/ata/ata_generic.c b/drivers/ata/ata_generic.c
index 7107a69..cc5f772 100644
--- a/drivers/ata/ata_generic.c
+++ b/drivers/ata/ata_generic.c
@@ -54,7 +54,6 @@ static int generic_set_mode(struct ata_link *link, struct ata_device **unused)
 	const struct pci_device_id *id = ap->host->private_data;
 	int dma_enabled = 0;
 	struct ata_device *dev;
-	struct pci_dev *pdev = to_pci_dev(ap->host->dev);

 	if (id->driver_data & ATA_GEN_FORCE_DMA) {
 		dma_enabled = 0xff;
@@ -63,9 +62,6 @@ static int generic_set_mode(struct ata_link *link, struct ata_device **unused)
 		dma_enabled = ioread8(ap->ioaddr.bmdma_addr + ATA_DMA_STATUS);
 	}

-	if (pdev->vendor == PCI_VENDOR_ID_CENATEK)
-		dma_enabled = 0xFF;
-
 	ata_for_each_dev(dev, link, ENABLED) {
 		/* We don't really care */
 		dev->pio_mode = XFER_PIO_0;
