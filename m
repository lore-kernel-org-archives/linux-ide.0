From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 2/2] ahci: also use a per-port lock for the multi-MSIX case
Date: Thu, 11 Aug 2016 07:26:02 -0700
Message-ID: <1470925562-28914-3-git-send-email-hch@lst.de>
References: <1470925562-28914-1-git-send-email-hch@lst.de>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:58304 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752212AbcHKO0H (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 11 Aug 2016 10:26:07 -0400
In-Reply-To: <1470925562-28914-1-git-send-email-hch@lst.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org
Cc: linux-ide@vger.kernel.org

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/ata/libahci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index dcf2c72..5a1329e 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -2378,7 +2378,7 @@ static int ahci_port_start(struct ata_port *ap)
 	/*
 	 * Switch to per-port locking in case each port has its own MSI vector.
 	 */
-	if (hpriv->flags & AHCI_HFLAG_MULTI_MSI) {
+	if (hpriv->flags & (AHCI_HFLAG_MULTI_MSI | AHCI_HFLAG_MULTI_MSIX)) {
 		spin_lock_init(&pp->lock);
 		ap->lock = &pp->lock;
 	}
-- 
2.1.4

