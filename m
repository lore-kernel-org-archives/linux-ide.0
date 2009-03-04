From: akpm@linux-foundation.org
Subject: [patch 2/3] libata: fix dma_unmap_sg misuse
Date: Wed, 04 Mar 2009 11:59:47 -0800
Message-ID: <200903041959.n24JxmI3028535@imap1.linux-foundation.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:51733 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757335AbZCDUAh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 4 Mar 2009 15:00:37 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org
Cc: linux-ide@vger.kernel.org, akpm@linux-foundation.org, fujita.tomonori@lab.ntt.co.jp, bzolnier@gmail.com, tj@kernel.org

From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>

libata passes the returned value of dma_map_sg() to dma_unmap_sg(),which
is the misuse of dma_unmap_sg().

DMA-mapping.txt says:

To unmap a scatterlist, just call:

	pci_unmap_sg(pdev, sglist, nents, direction);

Again, make sure DMA activity has already finished.

PLEASE NOTE:  The 'nents' argument to the pci_unmap_sg call must be
              the _same_ one you passed into the pci_map_sg call,
	      it should _NOT_ be the 'count' value _returned_ from the
              pci_map_sg call.

Signed-off-by: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Acked-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Acked-by: Tejun Heo <tj@kernel.org>
Cc: Jeff Garzik <jeff@garzik.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/ata/libata-core.c |    4 ++--
 include/linux/libata.h    |    1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

diff -puN drivers/ata/libata-core.c~libata-fix-dma_unmap_sg-misuse drivers/ata/libata-core.c
--- a/drivers/ata/libata-core.c~libata-fix-dma_unmap_sg-misuse
+++ a/drivers/ata/libata-core.c
@@ -4612,7 +4612,7 @@ void ata_sg_clean(struct ata_queued_cmd 
 	VPRINTK("unmapping %u sg elements\n", qc->n_elem);
 
 	if (qc->n_elem)
-		dma_unmap_sg(ap->dev, sg, qc->n_elem, dir);
+		dma_unmap_sg(ap->dev, sg, qc->orig_n_elem, dir);
 
 	qc->flags &= ~ATA_QCFLAG_DMAMAP;
 	qc->sg = NULL;
@@ -4727,7 +4727,7 @@ static int ata_sg_setup(struct ata_queue
 		return -1;
 
 	DPRINTK("%d sg elements mapped\n", n_elem);
-
+	qc->orig_n_elem = qc->n_elem;
 	qc->n_elem = n_elem;
 	qc->flags |= ATA_QCFLAG_DMAMAP;
 
diff -puN include/linux/libata.h~libata-fix-dma_unmap_sg-misuse include/linux/libata.h
--- a/include/linux/libata.h~libata-fix-dma_unmap_sg-misuse
+++ a/include/linux/libata.h
@@ -530,6 +530,7 @@ struct ata_queued_cmd {
 	unsigned long		flags;		/* ATA_QCFLAG_xxx */
 	unsigned int		tag;
 	unsigned int		n_elem;
+	unsigned int		orig_n_elem;
 
 	int			dma_dir;
 
_
