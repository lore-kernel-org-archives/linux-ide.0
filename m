From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 2/2] ide: ide_unregister() locking bugfix
Date: Sat, 5 Jul 2008 14:51:18 +0200
Message-ID: <200807051451.18784.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gv-out-0910.google.com ([216.239.58.189]:10930 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752803AbYGEMvJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 5 Jul 2008 08:51:09 -0400
Received: by gv-out-0910.google.com with SMTP id e6so282661gvc.37
        for <linux-ide@vger.kernel.org>; Sat, 05 Jul 2008 05:51:08 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Holding ide_lock for ide_release_dma_engine() call is unnecessary
and triggers WARN_ON(irqs_disabled()) in dma_free_coherent().

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: b/drivers/ide/ide.c
===================================================================
--- a/drivers/ide/ide.c
+++ b/drivers/ide/ide.c
@@ -352,15 +352,15 @@ void ide_unregister(ide_hwif_t *hwif)
 	blk_unregister_region(MKDEV(hwif->major, 0), MAX_DRIVES<<PARTN_BITS);
 	kfree(hwif->sg_table);
 	unregister_blkdev(hwif->major, hwif->name);
-	spin_lock_irq(&ide_lock);
 
 	if (hwif->dma_base)
 		ide_release_dma_engine(hwif);
 
+	spin_lock_irq(&ide_lock);
 	/* restore hwif data to pristine status */
 	ide_init_port_data(hwif, hwif->index);
-
 	spin_unlock_irq(&ide_lock);
+
 	mutex_unlock(&ide_cfg_mtx);
 }
 
