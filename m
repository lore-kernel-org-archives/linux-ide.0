From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH] ahci: fix the single MSI-X case in ahci_init_one
Date: Tue, 25 Oct 2016 14:04:34 +0200
Message-ID: <1477397074-26799-1-git-send-email-hch@lst.de>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:49541 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756438AbcJYMEj (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 25 Oct 2016 08:04:39 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org
Cc: linux-ide@vger.kernel.org, rrichter@cavium.com, ddaney.cavm@gmail.com

We need to make sure hpriv->irq is set properly if we don't use per-port
vectors, so switch from blindly assigning pdev->irq to using
pci_irq_vector, which handles all interrupt types correctly.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reported-by: Robert Richter <robert.richter@cavium.com>
Tested-by: Robert Richter <robert.richter@cavium.com>
Tested-by: David Daney <ddaney.cavm@gmail.com>
Fixes: 0b9e2988ab22 ("ahci: use pci_alloc_irq_vectors")

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index ba5f11c..5fe852d 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1617,7 +1617,7 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 		/* legacy intx interrupts */
 		pci_intx(pdev, 1);
 	}
-	hpriv->irq = pdev->irq;
+	hpriv->irq = pci_irq_vector(pdev, 0);
 
 	if (!(hpriv->cap & HOST_CAP_SSS) || ahci_ignore_sss)
 		host->flags |= ATA_HOST_PARALLEL_SCAN;
