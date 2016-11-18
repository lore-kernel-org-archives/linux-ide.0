From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH] ahci: always fall back to single-MSI mode
Date: Fri, 18 Nov 2016 14:09:06 +0100
Message-ID: <1479474546-4413-1-git-send-email-hch@lst.de>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:57965 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751527AbcKRNJL (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 18 Nov 2016 08:09:11 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org
Cc: michael@michaelmarley.com, linux-ide@vger.kernel.org

Don't try to guess what the errors from pci_irq_alloc_vectors mean, as
that's too fragile.  Instead always try allocating a single vector
when multi-MSI mode fails.  This makes various intel Desktop and
Laptop CPUs use MSI again.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reported-by: Michael Marley <michael@michaelmarley.com>
Tested-by: Michael Marley <michael@michaelmarley.com>
Fixes: 0b9e2988ab22 ("ahci: use pci_alloc_irq_vectors")
---
 drivers/ata/ahci.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 9669fc7..74f4c66 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1436,13 +1436,6 @@ static int ahci_init_msi(struct pci_dev *pdev, unsigned int n_ports,
 				"ahci: MRSM is on, fallback to single MSI\n");
 			pci_free_irq_vectors(pdev);
 		}
-
-		/*
-		 * -ENOSPC indicated we don't have enough vectors.  Don't bother
-		 * trying a single vectors for any other error:
-		 */
-		if (nvec < 0 && nvec != -ENOSPC)
-			return nvec;
 	}
 
 	/*
-- 
2.1.4

