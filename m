From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH] ahci: fix nvec check
Date: Thu, 20 Oct 2016 17:15:41 +0200
Message-ID: <1476976541-14501-1-git-send-email-hch@lst.de>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:41181 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751827AbcJTPPq (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 20 Oct 2016 11:15:46 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org
Cc: colin.king@canonical.com, linux-ide@vger.kernel.org

commit 17a51f12 ("ahci: only try to use multi-MSI mode if there is more
than 1 port") lead to a case where nvec isn't initialized before it's
used.  Fix this by moving the check into the n_ports conditional.

Reported-by Colin Ian King <colin.king@canonical.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/ata/ahci.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index ed311a0..60e42e2 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1436,14 +1436,14 @@ static int ahci_init_msi(struct pci_dev *pdev, unsigned int n_ports,
 				"ahci: MRSM is on, fallback to single MSI\n");
 			pci_free_irq_vectors(pdev);
 		}
-	}
 
-	/*
-	 * -ENOSPC indicated we don't have enough vectors.  Don't bother trying
-	 * a single vectors for any other error:
-	 */
-	if (nvec < 0 && nvec != -ENOSPC)
-		return nvec;
+		/*
+		 * -ENOSPC indicated we don't have enough vectors.  Don't bother
+		 * trying a single vectors for any other error:
+		 */
+		if (nvec < 0 && nvec != -ENOSPC)
+			return nvec;
+	}
 
 	/*
 	 * If the host is not capable of supporting per-port vectors, fall
-- 
2.1.4

