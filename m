From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH] ahci: only try to use multi-MSI mode if there is more than 1 port
Date: Tue, 18 Oct 2016 09:00:52 +0200
Message-ID: <1476774052-12662-1-git-send-email-hch@lst.de>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:52471 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757533AbcJRHA5 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 18 Oct 2016 03:00:57 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org
Cc: benisty.e@gmail.com, linux-ide@vger.kernel.org

We should only try to allocate multiple MSI or MSI-X vectors if the device
actually has multiple ports.  Otherwise pci_alloc_irq_vectors will return
a single vector due to n_ports = 1, in which case we shouldn't set the
AHCI_HFLAG_MULTI_MSI flag.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Fixes: 0b9e2988 ("ahci: use pci_alloc_irq_vectors")
Reported-by: Emmanuel Benisty <benisty.e@gmail.com>
Tested-by: Emmanuel Benisty <benisty.e@gmail.com>
---
 drivers/ata/ahci.c | 31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index ba5f11c..ed311a0 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1418,21 +1418,24 @@ static int ahci_init_msi(struct pci_dev *pdev, unsigned int n_ports,
 	 * Message mode could be enforced. In this case assume that advantage
 	 * of multipe MSIs is negated and use single MSI mode instead.
 	 */
-	nvec = pci_alloc_irq_vectors(pdev, n_ports, INT_MAX,
-			PCI_IRQ_MSIX | PCI_IRQ_MSI);
-	if (nvec > 0) {
-		if (!(readl(hpriv->mmio + HOST_CTL) & HOST_MRSM)) {
-			hpriv->get_irq_vector = ahci_get_irq_vector;
-			hpriv->flags |= AHCI_HFLAG_MULTI_MSI;
-			return nvec;
-		}
+	if (n_ports > 1) {
+		nvec = pci_alloc_irq_vectors(pdev, n_ports, INT_MAX,
+				PCI_IRQ_MSIX | PCI_IRQ_MSI);
+		if (nvec > 0) {
+			if (!(readl(hpriv->mmio + HOST_CTL) & HOST_MRSM)) {
+				hpriv->get_irq_vector = ahci_get_irq_vector;
+				hpriv->flags |= AHCI_HFLAG_MULTI_MSI;
+				return nvec;
+			}
 
-		/*
-		 * Fallback to single MSI mode if the controller enforced MRSM
-		 * mode.
-		 */
-		printk(KERN_INFO "ahci: MRSM is on, fallback to single MSI\n");
-		pci_free_irq_vectors(pdev);
+			/*
+			 * Fallback to single MSI mode if the controller
+			 * enforced MRSM mode.
+			 */
+			printk(KERN_INFO
+				"ahci: MRSM is on, fallback to single MSI\n");
+			pci_free_irq_vectors(pdev);
+		}
 	}
 
 	/*
-- 
2.1.4

