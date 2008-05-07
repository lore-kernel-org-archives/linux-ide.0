From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 1/6] sgiioc4: use ->extra_base instead of ->dma_status for dma_handle
Date: Wed, 7 May 2008 19:39:41 +0200
Message-ID: <200805071939.41558.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.185]:25780 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751375AbYEGR3F (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 7 May 2008 13:29:05 -0400
Received: by nf-out-0910.google.com with SMTP id d3so225814nfc.21
        for <linux-ide@vger.kernel.org>; Wed, 07 May 2008 10:29:02 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Jeremy Higdon <jeremy@sgi.com>

This is a preparation for removal of ->dma_status field from ide_hwif_t.

There should be no functional changes caused by this patch.

Cc: Jeremy Higdon <jeremy@sgi.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/pci/sgiioc4.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

Index: b/drivers/ide/pci/sgiioc4.c
===================================================================
--- a/drivers/ide/pci/sgiioc4.c
+++ b/drivers/ide/pci/sgiioc4.c
@@ -369,8 +369,7 @@ ide_dma_sgiioc4(ide_hwif_t *hwif, const 
 	hwif->sg_max_nents = IOC4_PRD_ENTRIES;
 
 	pad = pci_alloc_consistent(dev, IOC4_IDE_CACHELINE_SIZE,
-				   (dma_addr_t *) &(hwif->dma_status));
-
+				   (dma_addr_t *)&hwif->extra_base);
 	if (pad) {
 		ide_set_hwifdata(hwif, pad);
 		return 0;
@@ -439,7 +438,7 @@ sgiioc4_configure_for_dma(int dma_direct
 
 	/* Address of the Ending DMA */
 	memset(ide_get_hwifdata(hwif), 0, IOC4_IDE_CACHELINE_SIZE);
-	ending_dma_addr = cpu_to_le32(hwif->dma_status);
+	ending_dma_addr = cpu_to_le32(hwif->extra_base);
 	writel(ending_dma_addr, (void __iomem *)(dma_base + IOC4_DMA_END_ADDR * 4));
 
 	writel(dma_direction, (void __iomem *)ioc4_dma_addr);
