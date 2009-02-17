From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Subject: [PATCH] fix dma_unmap_sg misuse
Date: Tue, 17 Feb 2009 13:35:27 +0900
Message-ID: <20090217133432M.fujita.tomonori@lab.ntt.co.jp>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from sh.osrg.net ([192.16.179.4]:33212 "EHLO sh.osrg.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750848AbZBQEf3 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 16 Feb 2009 23:35:29 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Looks like that libata misuses dma_unmap_sg though I'm not familiar
with libata so I might completely misunderstand something.

=
From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Subject: [PATCH] fix dma_unmap_sg misuse

DMA-mapping.txt says:

To unmap a scatterlist, just call:

	pci_unmap_sg(pdev, sglist, nents, direction);

Again, make sure DMA activity has already finished.

PLEASE NOTE:  The 'nents' argument to the pci_unmap_sg call must be
              the _same_ one you passed into the pci_map_sg call,
	      it should _NOT_ be the 'count' value _returned_ from the
              pci_map_sg call.

Signed-off-by: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
---
 drivers/ata/libata-core.c |    4 ++--
 include/linux/libata.h    |    1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 9fbf059..5e324ce 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4612,7 +4612,7 @@ void ata_sg_clean(struct ata_queued_cmd *qc)
 	VPRINTK("unmapping %u sg elements\n", qc->n_elem);
 
 	if (qc->n_elem)
-		dma_unmap_sg(ap->dev, sg, qc->n_elem, dir);
+		dma_unmap_sg(ap->dev, sg, qc->orig_n_elem, dir);
 
 	qc->flags &= ~ATA_QCFLAG_DMAMAP;
 	qc->sg = NULL;
@@ -4727,7 +4727,7 @@ static int ata_sg_setup(struct ata_queued_cmd *qc)
 		return -1;
 
 	DPRINTK("%d sg elements mapped\n", n_elem);
-
+	qc->orig_n_elem = qc->n_elem;
 	qc->n_elem = n_elem;
 	qc->flags |= ATA_QCFLAG_DMAMAP;
 
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 5577ea8..2de827d 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -530,6 +530,7 @@ struct ata_queued_cmd {
 	unsigned long		flags;		/* ATA_QCFLAG_xxx */
 	unsigned int		tag;
 	unsigned int		n_elem;
+	unsigned int		orig_n_elem;
 
 	int			dma_dir;
 
-- 
1.6.0.6

