From: Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org>
Subject: [PATCH] avoid releasing twice the same region on ide_release_iomio_dma()
Date: Mon, 24 Jul 2006 16:30:31 -0300
Message-ID: <20060724193031.GA18463@cathedrallabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from tinc.cathedrallabs.org ([72.9.252.66]:34486 "EHLO
	tinc.cathedrallabs.org") by vger.kernel.org with ESMTP
	id S1751334AbWGXTai (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 24 Jul 2006 15:30:38 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

In ide_release_iomio_dma() it's possible to release twice
hwif->dma_base if hwif->dma_base2 is not null and never releasing
hwif->dma_base2:
int ide_release_iomio_dma (ide_hwif_t *hwif)
{
        if ((hwif->dma_extra) && (hwif->channel == 0))
                release_region((hwif->dma_base + 16), hwif->dma_extra);
        release_region(hwif->dma_base, 8);
        if (hwif->dma_base2)
                release_region(hwif->dma_base, 8);
                                     ^^^^^^^^^
        return 1;
}
This patch fixes this typo.

Signed-off-by: Aristeu S. Rozanski F. <aris@cathedrallabs.org>

Index: ppc-2.6/drivers/ide/ide-dma.c
===================================================================
--- ppc-2.6.orig/drivers/ide/ide-dma.c	2006-07-24 12:25:20.000000000 -0300
+++ ppc-2.6/drivers/ide/ide-dma.c	2006-07-24 12:26:26.000000000 -0300
@@ -802,7 +802,7 @@
 		release_region((hwif->dma_base + 16), hwif->dma_extra);
 	release_region(hwif->dma_base, 8);
 	if (hwif->dma_base2)
-		release_region(hwif->dma_base, 8);
+		release_region(hwif->dma_base2, 8);
 	return 1;
 }
 

